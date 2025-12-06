using DataModels;
using ProyectoGrupo6.Classes;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.DynamicData;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Windows.Forms.VisualStyles;

namespace ProyectoGrupo6.Pages
{
    public partial class CrearReservacion : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                try
                {


                    //Los DropDownList necesitan capturar los valores desde la base de datos
                    //estos se llaman con una variable que busca el procedimiento 
                    Usuario usuario = (Usuario)Session["Usuario"];

                    using (PvProyectoFinalDB db = new PvProyectoFinalDB("Database"))
                    {
                        //obtener hoteles
                        var hotel = db.SpObtenerHoteles().ToList();

                        if (hotel != null)
                        {
                            ddlHotel.DataValueField = "IdHotel";
                            ddlHotel.DataTextField = "Nombre";
                            ddlHotel.DataSource = hotel;
                            ddlHotel.DataBind();

                            ddlHotel.Items.Insert(0, new ListItem("Seleccione un hotel", ""));
                        }



                        //obtener clientes
                        var clientes = db.SpObtenerCientes().ToList();

                        bool esEmpleado = Convert.ToBoolean(Session["esEmpleado"]);
                        if (esEmpleado == true)
                        {
                            //si es empleado, campo desbloqueado
                            if (clientes != null)
                            {
                                ddlCliente.DataValueField = "IdPersona";
                                ddlCliente.DataTextField = "NombreCompleto";
                                ddlCliente.DataSource = clientes;
                                ddlCliente.DataBind();
                            }

                            ddlCliente.Items.Insert(0, new ListItem("Selecciones un  cliente", ""));
                            ddlCliente.Enabled = true;
                        }
                        else
                        {
                            // Solo el cliente de la sesión, campo bloqueado
                            int idPersonaSesion = int.Parse(usuario.idPersona.ToString());

                            var clienteSeleccion = clientes.FirstOrDefault(c => c.IdPersona == idPersonaSesion);
                            ddlCliente.Items.Clear();

                            if (clienteSeleccion != null)
                            {
                                ddlCliente.Items.Add(new ListItem(clienteSeleccion.NombreCompleto, clienteSeleccion.IdPersona.ToString()));
                            }
                            ddlCliente.Enabled = false;
                        }
                    }
                }

                catch { }
            }
        }

        //Realiza el guardado de datos creados por medio del boton
        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                try
                {
                    Usuario usuario = (Usuario)Session["Usuario"];
                    int idEmpleado = Convert.ToInt32(usuario.idPersona);

                    //iniciar los valores en 0 
                    int idHabitacion = 0;

                    //capturar las id de los dropdown del cliente y hotel
                    int idHotel = int.Parse(ddlHotel.SelectedValue);
                    int idCliente = int.Parse(ddlCliente.SelectedValue);

                    //capturar las fechas
                    DateTime fechaEntrada = DateTime.ParseExact(txtFechaEntrada.Text, "yyyy-MM-dd", null);
                    DateTime fechaSalida = DateTime.ParseExact(txtFechaSalida.Text, "yyyy-MM-dd", null);

                    //variables de cantidad y para capturar los costos
                    int numeroAdultos = Convert.ToInt32(txtNumAdultos.Text);
                    int numeroNinhos = Convert.ToInt32(txtNumNinos.Text);

                    decimal precioAdul = 0;
                    decimal precioNinh = 0;

                    //se cancula la cantidad para enviarla al procedimiento obtner precios y habitacion
                    int cantidadPer = numeroAdultos + numeroNinhos;

                    using (PvProyectoFinalDB db = new PvProyectoFinalDB("Database"))
                    {
                        //este procedimiento se llama para capturar los costos de adultos y niños y el id de la habitacion
                        var costosHabit = db.SpObtenerCostosyHabitacion(idHotel, cantidadPer, fechaEntrada, fechaSalida).FirstOrDefault();

                        if (costosHabit != null)
                        {
                            precioAdul = Convert.ToDecimal(costosHabit.CostoPorCadaAdulto);
                            precioNinh = Convert.ToDecimal(costosHabit.CostoPorCadaNinho);
                            idHabitacion = Convert.ToInt32(costosHabit.IdHabitacion);
                        }


                        //procedimiento es llamado para crear los datos despues de pasar por todas las validaciones 
                        db.SpCrearReservacion(idCliente, idHabitacion, fechaEntrada, fechaSalida,
                                           numeroNinhos, numeroAdultos, precioAdul, precioNinh, idEmpleado);

                    }


                }
                catch { }

                Session["Mensaje"] = "CreadaReservacion";
                Response.Redirect("~/Pages/Mensajes.aspx");

            }
        }

        protected void btnRegresar_Click(object sender, EventArgs e)
        {
            //boton regresar, si es empleado regresa al gestionarReservaciones
            //si es cliente debe regresar a MisReservaciones
            try
            {
                bool esEmpleado = Convert.ToBoolean(Session["esEmpleado"]);

                if (esEmpleado == true)
                {
                    Response.Redirect("GestionarReservaciones.aspx");
                }
                else
                {
                    Response.Redirect("MisReservaciones.aspx");
                }

            }
            catch { }
        }

        protected void cuvFechaEntrada_ServerValidate(object source, ServerValidateEventArgs args)
        {       //validaciones de la fecha de entrada
            try
            {

                //formato de la fecha
                bool fechaEntradaV = DateTime.TryParseExact(
                    txtFechaEntrada.Text, "yyyy-MM-dd",
                    CultureInfo.InvariantCulture,
                    DateTimeStyles.None,
                    out DateTime fechaEntrada);

                bool fechaSalidaV = DateTime.TryParseExact(
                 txtFechaSalida.Text, "yyyy-MM-dd",
                 CultureInfo.InvariantCulture,
                 DateTimeStyles.None,
                 out DateTime fechaSalida);


                //asumir args es falso
                args.IsValid = false;

                //fecha de salida no posee formato y la fecha no es mayor a hoy
                if (!fechaEntradaV || fechaEntrada <= DateTime.Today)
                {
                    cuvFechaEntrada.ErrorMessage =
                        "Fecha de entrada invalida, debe ser mayor a hoy.";

                }
                else if (!fechaEntradaV || !fechaSalidaV)
                {
                    cuvFechaEntrada.ErrorMessage = "Formato de fecha inválido.";
                }
                else if (fechaSalida < fechaEntrada)
                {
                    cuvFechaEntrada.ErrorMessage = "La fecha de salida debe ser mayor a la fecha de entrada.";
                }
                else
                {
                    args.IsValid = true;
                }


            }
            catch { }
        }


        //validaciones de las cantidades (este custom valida las cantidades de los campos adulto y niños)
        protected void cuvNumeroAdultos_ServerValidate(object source, ServerValidateEventArgs args)
        {
            try
            {
                args.IsValid = false;

                //validar la cantidad de niños y adultos
                bool adultoValido = int.TryParse(txtNumAdultos.Text, out int numAdultos);
                bool ninhosValido = int.TryParse(txtNumNinos.Text, out int numNinhos);

                int cantidadActual = numAdultos + numNinhos;

                //validaciones los campos de adultos y niños
                if (!adultoValido || numAdultos <= 0)
                {
                    cuvNumeroAdultos.ErrorMessage = "Cantidad de adultos no es válida.";
                    return;
                }

                if (!ninhosValido || numNinhos < 0)
                {
                    cuvNumeroAdultos.ErrorMessage = "Cantidad de niños inválida.";
                    return;
                }

                // Validación con base de datos
                int idHotel = int.Parse(ddlHotel.SelectedValue);

                DateTime fechaEntrada = DateTime.Parse(txtFechaEntrada.Text);
                DateTime fechaSalida = DateTime.Parse(txtFechaSalida.Text);

                using (PvProyectoFinalDB db = new PvProyectoFinalDB("Database"))
                {
                    var cantidades = db.SpObtenerCostosyHabitacion(idHotel, cantidadActual,fechaEntrada,fechaSalida).FirstOrDefault();

                    //si no hay habitaciones disponibles
                    if (cantidades == null)
                    {
                        cuvNumeroAdultos.ErrorMessage = "No hay habitaciones disponibles para la cantidad de huéspedes.";
                        return;
                    }

                    int capacidadMaxima = Convert.ToInt32(cantidades.CapacidadMaxima);

                    //revisa cantidades del usuario con la cantidad maxima de la habitacion
                    if (cantidadActual > capacidadMaxima)
                    {
                        cuvNumeroAdultos.ErrorMessage = "Cantidad excede la capacidad máxima de la habitación.";
                        return;
                    }
                }

                //si todo pasó
                args.IsValid = true;

            }
            catch { }
        }
    }
}