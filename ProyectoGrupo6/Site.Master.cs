using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
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
                if (Session["nombreCompleto"] == null)
                {
                    Response.Redirect("~/Pages/Login.aspx"); //si no hay sesión, va al login
                }


                //el código dentro del postback solo se ejecuta la primera vez que se carga la página.
                if (!IsPostBack)
                {
                    bool esEmpleado = false; //crear una varable por defecto falsa

                    //session esEmpleado no puede estar vacia para realizar para mostrar la opcion 
                    if (Session["esEmpleado"] != null)

                        //asignar variable bool a la sesion (la sesion se pasa a bool)
                        esEmpleado = (bool)Session["esEmpleado"];

                    // Mostrar u ocultar según el rol del usuario
                    if (esEmpleado == true)
                    {
                        liGestionar.Visible = true;
                        liMis.Visible = false;
                    }
                    else
                    {
                        liGestionar.Visible = false;
                        liMis.Visible = true;
                    }

                }
            }
            catch { }

        }
    }
}