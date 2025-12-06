using DataModels;
using System;
using System.Collections.Generic;
using System.Data.SqlTypes;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ProyectoGrupo6.Pages
{
    public partial class CrearHabitacion : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                try
                {
                    bool esEmpleado = Convert.ToBoolean(Session["esEmpleado"]);
                    RedirigirSegunUsuario(esEmpleado);
                        
                    //Los DropDownList necesitan capturar los valores desde la base de datos
                    using (PvProyectoFinalDB db = new PvProyectoFinalDB("Database"))
                    {
                        //obtener hoteles
                        var hotel = db.SpObtenerHoteles().ToList();

                        ddlHotel.DataValueField = "IdHotel";
                        ddlHotel.DataTextField = "Nombre";
                        ddlHotel.DataSource = hotel;
                        ddlHotel.DataBind();

                        ddlHotel.Items.Insert(0, new ListItem("Seleccione un hotel", ""));

                    }
                }
                catch { }
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
            if (Page.IsValid)
            {
                //boton que permite guardar la habitacion despues validar los campos
                try
                {
                    //asignar variables a los campos
                    int idHotel = Convert.ToInt32(ddlHotel.SelectedValue);
                    string numeroHabitacion = txtHabitacion.Text;
                    int capacidadMaxima = Convert.ToInt32(txtCantidad.Text);
                    string descripcion = txtDescripcion.Text;

                    using (PvProyectoFinalDB db = new PvProyectoFinalDB("Database"))
                    {
                        db.SpCrearHabitacion(idHotel, numeroHabitacion, capacidadMaxima, descripcion);

                    }

                }
                catch
                {
                }

                Session["Mensaje"] = "CreadaHabitacion";
                Response.Redirect("~/Pages/Mensajes.aspx");
            }
        }
        

        protected void btnRegresar_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Pages/ListarHabitaciones.aspx");
        }

        protected void cuvHabitacion_ServerValidate(object source, ServerValidateEventArgs args)
        {
            try 
            {
                //validacion que permite saber si existe una habitacion por medio de un procedimiento
                string numeroHabitacion = txtHabitacion.Text;
                int idHotel = Convert.ToInt32(ddlHotel.SelectedValue);

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
            catch { }
        }
    }
}