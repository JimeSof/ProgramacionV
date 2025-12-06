using ProyectoGrupo6.Classes;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ProyectoGrupo6
{
    public partial class SiteMaster : MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            try
            {

                //el código dentro del postback solo se ejecuta la primera vez que se carga la página.
                if (!IsPostBack)
                {

                    bool esEmpleado = false;

                    //session esEmpleado no puede estar vacia para realizar para mostrar la opcion 
                    if (Session["esEmpleado"] != null)

                        esEmpleado = Convert.ToBoolean(Session["esEmpleado"]);

                    // Mostrar u ocultar según el rol del usuario
                    if (esEmpleado == false)
                    {
                        liGestionar.Visible = false;
                        liGestionHabitacion.Visible = false;
                        liMis.Visible = true;
                    }


                }

            }
            catch { }

        }

        protected void lbtnCerrar_Click(object sender, EventArgs e)
        {
            Session.Clear();
            FormsAuthentication.SignOut();
            Response.Redirect("~/Login.aspx");

        }
    }
}