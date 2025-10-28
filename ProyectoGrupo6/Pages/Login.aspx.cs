using DataModels;
using Microsoft.Ajax.Utilities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Windows.Forms;

namespace ProyectoGrupo6.Pages
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnValidar_Click(object sender, EventArgs e)
        {
            try
            {
                //Variables de validacion digitadas por el usuario
                string email = txtEmail.Text;
                string clave = txtClave.Text;

                // Variables OUTPUT, permiten validar contra los parametros del procedimiento
                int? idPersona = null;
                bool? esEmpleado = null;
                int? acceso = null;
                string nombreCompleto = null;

                //Conexion a la base
                using (var db = new PvProyectoFinalDB("Database"))
                {
                    // Llamada directa del procedimiento almacenado
                    // Se colocan las variables con los parametros del procedimiento
                    db.SpLOGIN(
                        email: email,
                        clave: clave,
                        idPersona: ref idPersona,
                        esEmpleado: ref esEmpleado,
                        acceso: ref acceso,
                        nombreCompleto: ref nombreCompleto
                    );
                }

                // Validar los valores que devolvió el procedimiento

                //Pimero valida si los datos existen y estan activos
                if (acceso == 1)
                {
                    // Guardar datos en sesión 
                    Session["idPersona"] = idPersona;
                    Session["nombreCompleto"] = nombreCompleto;


                    //Despues valida si es un empleado o un cliente para redirigir al usuario
                    if (esEmpleado == true)
                    {
                        Session["esEmpleado"] = true;
                        Response.Redirect("~/Pages/GestionarReservaciones.aspx");
                    }
                    else
                    {
                        Session["esEmpleado"] = false;
                        Response.Redirect("~/Pages/MisReservaciones.aspx");
                    }
                }
                else if (acceso != 1)
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('Usuario no está activo en el sistema.');", true);

                }
             
            }
            catch
            {
            }
        }
    }
}