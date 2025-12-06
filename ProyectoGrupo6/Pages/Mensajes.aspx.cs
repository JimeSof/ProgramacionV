using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ProyectoGrupo6.Pages
{
    public partial class HabitacionInactiva : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                try
                {
                    lblResultado.Text = "Esta habitacion está inactiva, no puede ser modificada";

                    if (Session["Mensaje"] != null)
                    {
                        string mensaje = Session["Mensaje"].ToString();

                        switch (mensaje)
                        {
                            case "Inactivar":
                                MostrarMensaje("info", "La habitación fue marcada como inactiva.");
                                break;

                            case "CreadaReservacion":
                                MostrarMensaje("success", "Se registró correctamente la reservación.");
                                break;

                            case "EditarReservacion":
                                MostrarMensaje("success", "Se modificó correctamente la reservación.");
                                break;

                            case "CancelarReservacion":
                                MostrarMensaje("danger", "Se ha cancelado la reservación.");
                                break;

                            case "CreadaHabitacion":
                                MostrarMensaje("success", "La habitación fue creada correctamente.");
                                break;

                            case "EditarHabitacion":
                                MostrarMensaje("success", "La habitación fue modificada correctamente.");
                                break;

                            case "hayReservacion":
                                MostrarMensaje("danger", "La habitación no se puede modificar porque tiene reservaciones activas.");
                                break;
                        }

                        Session.Remove("Mensaje");
                    }


                }
                catch { }
            }
        }

        private void MostrarMensaje(string tipo, string texto)
        {
            pnlResultado.Visible = true;

            string clase = "alert alert-secondary"; 

            if (tipo == "success")
                clase = "alert alert-success";
            else if (tipo == "info")
                clase = "alert alert-info";
            else if (tipo == "danger")
                clase = "alert alert-danger";

            pnlResultado.CssClass = clase;
            lblResultado.Text = texto;
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
    }
}