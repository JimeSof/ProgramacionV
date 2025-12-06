using DataModels;
using ProyectoGrupo6.Classes;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Windows.Forms;
using static DataModels.PvProyectoFinalDBStoredProcedures;
using static System.Collections.Specialized.BitVector32;

namespace ProyectoGrupo6.Pages
{
    public partial class GestionarReservaciones : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                try
                {
                    Usuario usuario = (Usuario)Session["Usuario"];

                    lblUsuario.Text = "Usuario: " + usuario.nombreCompleto;

                    bool esEmpleado = Convert.ToBoolean(Session["esEmpleado"]);
                    RedirigirSegunUsuario(esEmpleado);

                    if (!IsPostBack)
                    {

                        //Muestra los datos de las reservaciones de la base de datos y para el dropdonwlist los clientes
                        int idPersona = Convert.ToInt32(usuario.idPersona);

                        using (PvProyectoFinalDB db = new PvProyectoFinalDB("Database"))
                        {
                            List<SpConsultarGestionReservasionResult> gestion = db.SpConsultarGestionReservasion(idPersona).ToList();
                            grdGestion.DataSource = gestion;
                            grdGestion.DataBind();

                            var filtro = db.SpFiltroClientes(idPersona).ToList();

                            ddlCliente.DataValueField = "IdPersona";
                            ddlCliente.DataTextField = "NombreCompleto";
                            ddlCliente.DataSource = filtro;
                            ddlCliente.DataBind();

                            ddlCliente.Items.Insert(0, new ListItem("Seleccione un cliente", "0"));
                        }
                    }


                }
                catch
                {

                }

            }
        }

        private void RedirigirSegunUsuario(bool esEmpleado)
        {
            //redirecciona segun el tipo de usuario
            if (!esEmpleado)
                Response.Redirect("MisReservaciones.aspx");
        }

        public String EvaluarEstado(string estado, DateTime fechaEntrada, DateTime fechaSalida)
        {
            //Evalia el estado de las reservaciones para mostrarlas en la tabla

            DateTime fechaActual = DateTime.Now;
            string respuesta = "";

            if (estado == "I")
                respuesta = "Cancelada";
            else if (estado == "A" && fechaSalida < fechaActual)
                respuesta = "Finalizada";
            else if (estado == "A" && fechaEntrada <= fechaActual)
                respuesta = "En proceso";
            else
                respuesta = "En espera";


            return respuesta;
        }

        protected void btnFiltrar_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {

                int cliente = int.Parse(ddlCliente.SelectedValue);

                DateTime fechaEntrada = DateTime.Parse(txtFechaEntrada.Text);
                DateTime fechaSalida = DateTime.Parse(txtFechaSalida.Text);

                using (PvProyectoFinalDB db = new PvProyectoFinalDB("Database"))
                {
                    List<SpFiltroReservacionesResult> filtro = db.SpFiltroReservaciones(cliente, fechaEntrada, fechaSalida).ToList();

                    grdGestion.DataSource = filtro;
                    grdGestion.DataBind();

                }

            }

        }

        protected void cuvFechas_ServerValidate(object source, ServerValidateEventArgs args)
        {
            try
            {
                //comprueba que las fechas sean validas, salida mayor o igual a entrada
                DateTime entrada = Convert.ToDateTime(txtFechaEntrada.Text);
                DateTime salida = Convert.ToDateTime(txtFechaSalida.Text);


                //asumir args es falso
                args.IsValid = false;

                if (entrada <= salida)
                {

                    args.IsValid = true;
                }
                else
                {
                    args.IsValid = false;
                }
            }
            catch { }

        }
    }
}