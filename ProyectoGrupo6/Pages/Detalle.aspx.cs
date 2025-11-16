using DataModels;
using ProyectoGrupo6.Classes;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using static DataModels.PvProyectoFinalDBStoredProcedures;

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
                    int id = int.Parse(Request.QueryString["idReservacion"]);


                    int idPersona = int.Parse(usuario.idPersona.ToString());
                    bool esEmpleado = Convert.ToBoolean(Session["esEmpleado"]);


                    using (PvProyectoFinalDB db = new PvProyectoFinalDB("Database"))
                    {

                        var reservacion = db.SpObtenerReservacionById(id, idPersona, esEmpleado).FirstOrDefault();

                        List<SpObtenerBitacoraByIdResult> bitacora = db.SpObtenerBitacoraById(id).ToList();

                        if (reservacion != null)
                        {

                            dvDetalle.DataSource = new List<SpObtenerReservacionByIdResult> { reservacion };
                            dvDetalle.DataBind();

                            grdBitacora.DataSource = bitacora;
                            grdBitacora.DataBind();

                        }
                        else
                        {
                            // Si no devolvió nada, significa que el usuario no tiene acceso a esa reserva
                            Response.Redirect("MisReservaciones.aspx");
                        }


                        if (esEmpleado == true)
                        {
                            btnEditar.Visible = (Convert.ToString(reservacion.Estado) == "A" && reservacion.FechaSalida > DateTime.Now);

                        }
                        else
                        {
                            btnEditar.Visible = (Convert.ToString(reservacion.Estado) == "A" && reservacion.FechaEntrada > DateTime.Now);

                        }

                        if (Convert.ToString(reservacion.Estado) == "A" && reservacion.FechaEntrada > DateTime.Now)
                        {
                            btnCancelar.Visible = true;
                        }

                    }

                }
            }
            catch
            {

            }
        }

        protected void btnEditar_Click(object sender, EventArgs e)
        {
            try
            {
                string id = Request.QueryString["idReservacion"];
                Response.Redirect("EditarReservacion.aspx");
            }
            catch { }
        }

        protected void btnRegresar_Click(object sender, EventArgs e)
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

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            //edu
        }
    }
}