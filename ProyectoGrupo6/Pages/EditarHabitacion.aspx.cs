using DataModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ProyectoGrupo6.Pages
{
    public partial class EditarHabitacion : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack == false)
            {
                try
                {
                    bool esEmpleado = Convert.ToBoolean(Session["esEmpleado"]);
                    RedirigirSegunUsuario(esEmpleado);

                    int idHabitacion = int.Parse(Request.QueryString["idHabitacion"]);

                    using (PvProyectoFinalDB db = new PvProyectoFinalDB("Database"))
                    {
                        var Habitacion = db.SpBuscarHabitacionById(idHabitacion).FirstOrDefault();

                        if (Habitacion != null)
                        {
                            hdnIdHabitacion.Value = Habitacion.IdHabitacion.ToString();
                            hdnHotel.Value = Habitacion.IdHotel.ToString();

                            // Mostrar valores visibles
                            txtHotel.Text = Habitacion.Hotel;
                            txtHabitacion.Text = Habitacion.NumeroHabitacion;
                            txtCantidad.Text = Habitacion.CapacidadMaxima.ToString();
                            txtDescripcion.Text = Habitacion.Descripcion;
                        }

                    }
                }

                catch
                {

                }
            }
        }


        private void RedirigirSegunUsuario(bool esEmpleado)
        {
            //redirecciona segun el tipo de usuario
            if (!esEmpleado)
                Response.Redirect("MisReservaciones.aspx");
        }
        protected void btnGuardar_Click(object sender, EventArgs e)
        {

            try
            {
                int idHabitacion = Convert.ToInt32(hdnIdHabitacion.Value);
                int idHotel = Convert.ToInt32(hdnHotel.Value);
                string numeroHabitacion = txtHabitacion.Text;
                int capacidadMaxima = Convert.ToInt32(txtCantidad.Text);
                string descripcion = txtDescripcion.Text;

                using (PvProyectoFinalDB db = new PvProyectoFinalDB("Database"))
                {
                    db.SpEditarHabitacion(idHabitacion, idHotel, numeroHabitacion, capacidadMaxima, descripcion);
                }
               
                Response.Redirect("~/Pages/ListarHabitaciones.aspx");
            }
            catch{}

        }

        protected void btnInactivar_Click(object sender, EventArgs e)
        {
            try
            {
                int idHabitacion = Convert.ToInt32(hdnIdHabitacion.Value);

                using (PvProyectoFinalDB db = new PvProyectoFinalDB("Database"))
                {
                    db.SpInactivarHabitacion(idHabitacion);
                }

                Session["Mensaje"] = "Inactivar";
                Response.Redirect("~/Pages/HabitacionInactiva.aspx");
            }
            catch { }
        }

        protected void btnRegresar_Click(object sender, EventArgs e)
        {
            try 
            {
                
                Response.Redirect("~/Pages/ListarHabitaciones.aspx");
            }
            catch { }

        }

        protected void cuvHabitacion_ServerValidate(object source, ServerValidateEventArgs args)
        {
            try 
            {
                //validacion que permite saber si existe una habitacion por medio de un procedimiento
                string numeroHabitacion = txtHabitacion.Text;
                int idHotel = Convert.ToInt32(hdnHotel.Value);

                using (var db = new PvProyectoFinalDB("Database"))
                {
                    var resultado = db.SpValidarHabitacion(idHotel, numeroHabitacion).FirstOrDefault();

                    if (resultado != null && resultado.Existe > 0)
                    {
                        args.IsValid = false;
                    }
                    else
                    {
                        args.IsValid = true;
                    }
                }
            }
            catch{}
        }
    }
}