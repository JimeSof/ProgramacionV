using ProyectoGrupo6.Classes;
using DataModels;
using System;
using System.Linq;
using System.Web.UI;

namespace ProyectoGrupo6.Pages
{
    public partial class MisReservaciones : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                Usuario usuario = (Usuario)Session["Usuario"];
                lblUsuario.Text = usuario.nombreCompleto;

                if (!IsPostBack)
                {
                    CargarReservaciones(usuario.idPersona.Value);
                }
            }
            catch
            {

            }
        }

        private void CargarReservaciones(int idPersona)
        {
            using (PvProyectoFinalDB db = new PvProyectoFinalDB("Database"))
            {
                var lista = db.SpConsultarClienteReservacion(idPersona).ToList();
                grdReservaciones.DataSource = lista;
                grdReservaciones.DataBind();
            }
        }
    }
}
