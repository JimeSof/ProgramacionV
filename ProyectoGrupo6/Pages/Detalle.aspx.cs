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
                //este load lo que hace es cargar los datos de la reservacion seleccionada
                Usuario usuario = (Usuario)Session["Usuario"];
                if (!IsPostBack)
                {
                    //se capturan el id enviado por query string y los parametros del usuario

                    int id = int.Parse(Request.QueryString["idReservacion"]);

                    int idPersona = int.Parse(usuario.idPersona.ToString());
                    bool esEmpleado = Convert.ToBoolean(Session["esEmpleado"]);


                    using (PvProyectoFinalDB db = new PvProyectoFinalDB("Database"))
                    {
                        //se llama a los procedimientos almacenados para obtener los datos de la reservacion y la bitacora
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

                        // lógica para mostrar u ocultar botones según el estado de la reservación y el tipo de usuario
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
        {//redirecciona a la pagina de editar reservacion enviando el id por query string
            try
            {
                string id = Request.QueryString["idReservacion"];
                Response.Redirect("EditarReservacion.aspx?idReservacion=" + id);
            }
            catch { }
        }

        protected void btnRegresar_Click(object sender, EventArgs e)
        {
            //redirecciona a la pagina correspondiente segun el tipo de usuario
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
        { //llama al procedimiento almacenado para cancelar la reservacion
            try
            {

                int idReservacion = int.Parse(Request.QueryString["idReservacion"]);
                Usuario usuario = (Usuario)Session["Usuario"];


                using (PvProyectoFinalDB db = new PvProyectoFinalDB("Database"))
                {
                    db.SpCancelarReservacion(idReservacion, usuario.idPersona.Value);
                }

                //redirecciona a la pagina correspondiente al mensaje
                Session["Mensaje"] = "CancelarReservacion";
                Response.Redirect("~/Pages/Mensajes.aspx");

            }
            catch
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "error",
                    "alert('Error al cancelar la reservación.');", true);
            }
        }
    }
}