using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ProyectoGrupo6.Pages
{
    public partial class MisReservaciones : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            try
            {
                if (Session["nombreCompleto"] == null)
                {
                    // Si no hay sesión activa, vuelve al login
                    Response.Redirect("Login.aspx");
                }

                lblUsuario.Text = Session["nombreCompleto"].ToString();
            }
            catch
            {

            }

        }
    }
}