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
                    //iniciar los valores en 0 siempre
                    int idHotel = 0;
                    int idCliente = 0;

                    //capturar las id de los dropdown del cliente y hotel
                    idHotel = int.Parse(ddlHotel.SelectedValue);
                    idCliente = int.Parse(ddlCliente.SelectedValue);

                    //capturar las fechas
                    DateTime fechaEntrada = DateTime.ParseExact(txtFechaEntrada.Text, "dd-MM-yyyy", null);
                    DateTime fechaSalida = DateTime.ParseExact(txtFechaSalida.Text, "dd-MM-yyyy", null);

                    //procedimiento de costos

                    int numeroNinhos = Convert.ToInt32(txtNinos.Text);
                    int numeroAdultos = Convert.ToInt32(txtAdultos.Text);

                    int precioAdul = 0;

                    using (PvProyectoFinalDB db = new PvProyectoFinalDB("Database"))
                    {

                    }
                }
                catch { }



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
        {
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
    }
}