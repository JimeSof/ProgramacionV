using DataModels;
using ProyectoGrupo6.Classes;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ProyectoGrupo6.Pages
{
    public partial class EditarReservacion : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //Permite cargar los datos en los campos usando un procedimiento almacenado

            if (!IsPostBack)
            {
                try
                {
                    Usuario usuario = (Usuario)Session["Usuario"];

                    int id = int.Parse(Request.QueryString["idReservacion"]);

                    int idPersona = int.Parse(usuario.idPersona.ToString());
                    bool esEmpleado = Convert.ToBoolean(Session["esEmpleado"]);

                    using (PvProyectoFinalDB db = new PvProyectoFinalDB("Database"))
                    {
                        var editReservacion = db.SpObtenerReservacionById(id, idPersona, esEmpleado).FirstOrDefault();

                        if (editReservacion != null)
                        {
                            txtHotel.Text = editReservacion.Hotel;
                            txtNumeroHabitacion.Text = editReservacion.NumeroHabitacion.ToString();
                            txtCliente.Text = editReservacion.Cliente;
                            txtFechaEntrada.Text = editReservacion.FechaEntrada.ToString("yyyy-MM-dd");
                            txtFechaSalida.Text = editReservacion.FechaSalida.ToString("yyyy-MM-dd");
                            txtNumeroAdultos.Text = editReservacion.NumeroAdultos.ToString();
                            txtNumeroNinhos.Text = editReservacion?.NumeroNinhos.ToString();
                        }
                        else
                        {
                            Response.Redirect("~/Pages/Detalle.aspx");
                        }


                    }

                }
                catch { }

            }

        }


        protected void btnRegresar_Click(object sender, EventArgs e)
        {

            try
            {
                int id = int.Parse(Request.QueryString["idReservacion"]);
                Response.Redirect("~/Pages/Detalle.aspx?idReservacion=" + id);

            }
            catch { }
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {//Boton Guardar los cambios
            try
            {

            }catch { }
        }
    }
}