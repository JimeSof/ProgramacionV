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

namespace ProyectoGrupo6.Pages
{
    public partial class GestionarReservaciones : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                Usuario usuario = (Usuario)Session["Usuario"];

                bool esEmpleado = Convert.ToBoolean(usuario.esEmpleado);
                if (esEmpleado == false)
                {
                    // Si no es empleado, vuelve a mis reservaciones página
                    Response.Redirect("~/Pages/MisReservaciones.aspx");
                    return;
                }
                if (!IsPostBack)
                {


                    int idPersona = Convert.ToInt32(usuario.idPersona);

                    using (PvProyectoFinalDB db = new PvProyectoFinalDB("Database"))
                    {
                        List<SpConsultarGestionReservasionResult> gestion = db.SpConsultarGestionReservasion(idPersona).ToList();
                        grdGestion.DataSource = gestion;
                        grdGestion.DataBind();

                    }
                }


            }
            catch
            {

            }

        }

        public String EvaluarEstado(string estado, DateTime fechaEntrada, DateTime fechaSalida)
        {

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


            }

        }

        protected void cuvFechas_ServerValidate(object source, ServerValidateEventArgs args)
        {
            try
            {
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