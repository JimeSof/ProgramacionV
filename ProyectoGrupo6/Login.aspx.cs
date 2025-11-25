using DataModels;
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

                Usuario usuario = new Usuario();

                usuario.email = txtEmail.Text;
                usuario.clave = txtClave.Text;


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
                        email: usuario.email,
                        clave: usuario.clave,
                        idPersona: ref idPersona,
                        esEmpleado: ref esEmpleado,
                        acceso: ref acceso,
                        nombreCompleto: ref nombreCompleto
                    );
                }

                //Asignar las variables al objeto Usuario
                usuario.idPersona = idPersona;
                usuario.esEmpleado = esEmpleado;
                usuario.nombreCompleto = nombreCompleto;


                // Validar los valores que devolvió el procedimiento

                //Pimero valida si los datos existen y estan activos
                if (acceso == 1)
                {
                    // Guardar datos en sesión 
                    Session.Add("Usuario", usuario);

                    FormsAuthentication.SetAuthCookie(usuario.email, false);

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