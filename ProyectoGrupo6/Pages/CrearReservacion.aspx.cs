using DataModels;
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

            try
            {
                //si no existe sesion, vuelve al login
                if (Session["idPersona"] == null)
                {
                    Response.Redirect("~/Pages/Login.aspx");
                    return;
                }

                if (!IsPostBack)
                {
                    //Los DropDownList necesitan capturar los valores desde la base de datos
                    //estos se llaman con una variable que busca el procedimiento 
                    using (PvProyectoFinalDB db = new PvProyectoFinalDB("Database"))
                    {
                        //obtener hoteles
                        var hotel = db.SpObtenerHoteles().ToList();

                        ddlHotel.DataValueField = "IdHotel";
                        ddlHotel.DataTextField = "Nombre";
                        ddlHotel.DataSource = hotel;
                        ddlHotel.DataBind();

                        ddlHotel.Items.Insert(0, new ListItem("Seleccione un hotel", ""));

                        //obtener clientes
                        var clientes = db.SpObtenerCientes().ToList();

                        //se comprueba si el usuario es empleado para que muestre todos los clientes
                        bool esEmpleado = Convert.ToBoolean(Session["esEmpleado"]);

                        if (esEmpleado == true)
                        {
                            //si es empleado, campo desbloqueado
                            ddlCliente.DataValueField = "IdPersona";
                            ddlCliente.DataTextField = "NombreCompleto";
                            ddlCliente.DataSource = clientes;
                            ddlCliente.DataBind();

                            ddlCliente.Items.Insert(0, new ListItem("Selecciones un  cliente", ""));
                            ddlCliente.Enabled = true;
                        }
                        else
                        {
                            // Solo el cliente de la sesión, campo bloqueado
                            int idPersonaSesion = int.Parse(Session["idPersona"].ToString());

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
            }
            catch { }
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {       //Realiza el guardado de datos creados por medio del boton
            if (Page.IsValid)
            {
                try
                {
                    //iniciar los valores en 0 
                    int idHotel = 0;
                    int idPersona = 0;
                    int idHabitacion = 0;

                    //capturar las id de los dropdown del cliente y hotel
                    idHotel = int.Parse(ddlHotel.SelectedValue);
                    idPersona = int.Parse(ddlCliente.SelectedValue);

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
                        var costosHabit = db.SpObtenerCostosyHabitacion(idHotel,cantidadPer).FirstOrDefault();

                        if (costosHabit != null)
                        {
                            precioAdul = Convert.ToDecimal(costosHabit.CostoPorCadaAdulto);
                            precioNinh = Convert.ToDecimal(costosHabit.CostoPorCadaNinho);
                            idHabitacion = Convert.ToInt32(costosHabit.IdHabitacion);
                        }

                        
                        //procedimiento es llamado para crear los datos despues de pasar por todas las validaciones 
                        db.SpCrearReservacion(idPersona, idHabitacion,fechaEntrada,fechaSalida,
                                            numeroNinhos,numeroAdultos,precioAdul,precioNinh);

                    }
                   
                }
                catch {}

                Response.Redirect("~/Pages/GestionarReservaciones.aspx");

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
                //detectar errores en las fechas de entrada
                String stgfechaEntrada = txtFechaSalida.Text;

                //formato de la fecha
                bool fechaEntradaV = DateTime.TryParseExact(
                    txtFechaEntrada.Text, "yyyy-MM-dd",
                    CultureInfo.InvariantCulture,
                    DateTimeStyles.None,
                    out DateTime fechaEntrada);

                //asumir args es falso
                args.IsValid = false;

                //fecha de salida no posee formato y la fecha no es mayor a hoy
                if (!fechaEntradaV || fechaEntrada <= DateTime.Today)
                {
                    cuvFechaEntrada.ErrorMessage =
                        "Fecha de entrada invalida, debe ser formato dd/MM/yyyy y mayor a hoy.";
                }
                else
                {
                    args.IsValid = true;
                }

            }
            catch { }
        }

        protected void cuvFechaSalida_ServerValidate(object source, ServerValidateEventArgs args)
        {
            try
            {
                //detectar errores en las fechas de salida
                String stgfechaSalida = txtFechaSalida.Text;

                //formato de la fecha entrada
                bool fechaEntradaV = DateTime.TryParseExact(
                    txtFechaEntrada.Text, "yyyy-MM-dd",
                    CultureInfo.InvariantCulture,
                    DateTimeStyles.None,
                    out DateTime fechaEntrada);


                //formato de la fecha salida
                bool fechaSalidaV = DateTime.TryParseExact(
                    txtFechaSalida.Text, "yyyy-MM-dd",
                    CultureInfo.InvariantCulture,
                    DateTimeStyles.None,
                    out DateTime fechaSalida);


                //asumir args es falso
                args.IsValid = false;

                if (!fechaEntradaV || !fechaSalidaV)
                {
                    cuvFechaSalida.ErrorMessage = "Formato de fecha inválido.";
                }
                else if (fechaSalida < fechaEntrada)
                {
                    cuvFechaSalida.ErrorMessage = "La fecha de salida debe ser mayor a la fecha de entrada.";
                }
                else
                {
                    args.IsValid = true;

                }
            }
            catch { }

        }

        protected void cuvNumeroAdultos_ServerValidate(object source, ServerValidateEventArgs args)
        {       //validaciones de las cantidades (este custom valida las cantidades de los campos adulto y niños)
            try
            {
                //variables inciales
                int numAdultos = 0;
                int numNinhos = 0;

                //capturar el id del hotel seleccionado por el usuario
                int idHotel = int.Parse(ddlHotel.SelectedValue);

                //comprobar los datos de los campos txt para evitar errores en crear
                bool adultoValido = int.TryParse(txtNumAdultos.Text, out numAdultos);
                bool ninhosValido = int.TryParse(txtNumNinos.Text, out numNinhos);

                //suma de huespedes y se pasan al procedimiento
                int cantidadActual = numAdultos + numNinhos;
                
                args.IsValid = false;

                //llamado de la base para traer los datos de cantidad maxima y la habitacion seleccionada
                using (PvProyectoFinalDB db = new PvProyectoFinalDB("Database"))
                {   
                    //llamar procedimiento
                    var cantidades = db.SpObtenerCostosyHabitacion(idHotel, cantidadActual).FirstOrDefault();

                    if (cantidades == null)
                    {   
                        //si no hay una habitaciones lanza el mensaje
                        cuvNumeroAdultos.ErrorMessage = "No hay habitaciones disponibles para la cantidad de huespedes";
                        args.IsValid = false;
                        return;
                    }
                    //si hay habitaciones disponibles, pasa la cantidad maxima de la habitaciones a la variable
                    int cantidadMaxima = Convert.ToInt32(cantidades.CapacidadMaxima);

                    //comparativa de cantidades para permitir la reservacion
                    if (adultoValido == false || numAdultos <= 0)
                    {
                        cuvNumeroAdultos.ErrorMessage = "Cantidad de adultos no es valida.";
                    }
                    else if (numAdultos > cantidadMaxima)
                    {
                        cuvNumeroAdultos.ErrorMessage = "Cantidad no permitida, excede la capacidad permitida";
                    }
                    else if (ninhosValido == false || numNinhos < 0)
                    {
                        cuvNumeroAdultos.ErrorMessage = "Cantidad de Niños invalida";
                    }
                    else if ((numAdultos + numNinhos) > cantidadMaxima)
                    {
                        cuvNumeroAdultos.ErrorMessage = "Cantidad excede la capacidad maxima de la habitacion";
                    }
                    else
                    {
                        args.IsValid = true;
                    }
                }
                
            }
            catch { }
        }
    }
}