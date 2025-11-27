using DataModels;
using ProyectoGrupo6.Classes;
using System;
using System.Linq;
using System.Web.UI;

namespace ProyectoGrupo6
{
    public partial class Detalle : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                Usuario usuario = (Usuario)Session["Usuario"];

                if (!IsPostBack)
                {
                    if (!int.TryParse(Request.QueryString["idReservacion"], out int idReservacion))
                    {
                        Response.Redirect("MisReservaciones.aspx");
                        return;
                    }

                    int idPersona = usuario.idPersona.Value;
                    bool esEmpleado = Convert.ToBoolean(Session["esEmpleado"]);

                    using (PvProyectoFinalDB db = new PvProyectoFinalDB("Database"))
                    {
                        var reservacion = db.SpObtenerReservacionById(idReservacion, idPersona, esEmpleado).FirstOrDefault();
                        var bitacora = db.SpObtenerBitacoraById(idReservacion).ToList();

                        if (reservacion == null)
                        {
                            Response.Redirect("MisReservaciones.aspx");
                            return;
                        }

                        // Mostrar detalle y bitácora
                        dvDetalle.DataSource = new[] { reservacion };
                        dvDetalle.DataBind();

                        grdBitacora.DataSource = bitacora;
                        grdBitacora.DataBind();

                        // Reglas RF-004 y RF-005
                        DateTime hoy = DateTime.Now;

                        bool estaCancelada = reservacion.Estado == 'I';
                        bool finalizada = reservacion.FechaSalida <= hoy;
                        bool enProceso = reservacion.FechaEntrada <= hoy && reservacion.FechaSalida > hoy;

                        // EDITAR
                        if (esEmpleado)
                            btnEditar.Visible = (!estaCancelada && !finalizada);
                        else
                            btnEditar.Visible = (!estaCancelada && !finalizada && !enProceso);

                        // CANCELAR
                        if (esEmpleado)
                            btnCancelar.Visible = (!estaCancelada && !finalizada);
                        else
                            btnCancelar.Visible = (!estaCancelada && !finalizada && !enProceso);
                    }
                }
            }
            catch { }
        }

        protected void btnEditar_Click(object sender, EventArgs e)
        {
            string id = Request.QueryString["idReservacion"];
            Response.Redirect("EditarReservacion.aspx?id=" + id);
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            try
            {
                int idReservacion = int.Parse(Request.QueryString["idReservacion"]);
                Usuario usuario = (Usuario)Session["Usuario"];

                using (PvProyectoFinalDB db = new PvProyectoFinalDB("Database"))
                {
                    db.SpCancelarReservacion(idReservacion, usuario.idPersona.Value);
                }

                ScriptManager.RegisterStartupScript(this, GetType(), "alert",
                    "alert('¡Reservación cancelada exitosamente!'); window.location='MisReservaciones.aspx';", true);
            }
            catch
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "alert",
                    "alert('Error al cancelar la reservación.');", true);
            }
        }

        protected void btnRegresar_Click(object sender, EventArgs e)
        {
            bool esEmpleado = Convert.ToBoolean(Session["esEmpleado"]);

            if (esEmpleado)
                Response.Redirect("GestionarReservaciones.aspx");
            else
                Response.Redirect("MisReservaciones.aspx");
        }
    }
}
