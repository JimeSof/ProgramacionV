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
                    bool esEmpleado = Convert.ToBoolean(Session["esEmpleado"]);
                    RedirigirSegunUsuario(esEmpleado);

                    lblResultado.Text = "Esta habitacion está inactiva, no puede ser modificada";

                    if (Session["Mensaje"] != null)
                    {
                        string mensaje = Session["Mensaje"].ToString();

                        if (mensaje == "Inactivar")
                        {

                            lblResultado.Text = "La habitación ha sido marcada como inactiva.";
                        }
                        
                        Session.Remove("Mensaje");
                    }

                }
                catch { }
            }
        }

        protected void btnRegresar_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Pages/ListarHabitaciones.aspx");
        }

        private void RedirigirSegunUsuario(bool esEmpleado)
        {
            //redirecciona segun el tipo de usuario
            if (!esEmpleado)
                Response.Redirect("MisReservaciones.aspx");
        }
    }
}