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
                lblUsuario.Text = "Usuario: " + usuario.nombreCompleto;

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

                var listaAdaptada = lista.Select(r => new
                {
                    r.IdReservacion,
                    r.Hotel,
                    r.FechaEntrada,
                    r.FechaSalida,
                    r.CostoTotal,
                    EstadoTexto = EvaluarEstado(r.Estado.ToString(), r.FechaEntrada, r.FechaSalida)
                }).ToList();

                grdReservaciones.DataSource = listaAdaptada;

                grdReservaciones.DataBind();
            }
        }

        private string EvaluarEstado(string estado, DateTime fechaEntrada, DateTime fechaSalida)
        {
            DateTime hoy = DateTime.Now;

            if (estado == "I")
                return "Cancelada";

            if (estado == "A" && fechaSalida < hoy)
                return "Finalizada";

            if (estado == "A" && fechaEntrada <= hoy)
                return "En proceso";

            return "En espera";
        }
    }
}
