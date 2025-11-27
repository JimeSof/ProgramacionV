using DataModels;
using ProyectoGrupo6.Classes;
using System;
using System.Linq;
using System.Web.UI;

namespace ProyectoGrupo6.Pages
{
    public partial class EditarReservacion : System.Web.UI.Page
    {
        protected int idReserva;

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!int.TryParse(Request.QueryString["id"], out idReserva))
                {
                    Response.Redirect("MisReservaciones.aspx");
                    return;
                }

                Usuario usuario = (Usuario)Session["Usuario"];
                bool esEmpleado = Convert.ToBoolean(Session["esEmpleado"]);

                if (!IsPostBack)
                {
                    CargarDatos(usuario, esEmpleado);
                }
            }
            catch { }
        }

        private void CargarDatos(Usuario usuario, bool esEmpleado)
        {
            using (PvProyectoFinalDB db = new PvProyectoFinalDB("Database"))
            {
                var data = db.SpObtenerReservacionById(idReserva, usuario.idPersona.Value, esEmpleado).FirstOrDefault();

                if (data == null)
                {
                    Response.Redirect("MisReservaciones.aspx");
                    return;
                }

                DateTime hoy = DateTime.Now;

                if (data.Estado == 'I' || data.FechaSalida <= hoy || (data.FechaEntrada <= hoy && data.FechaSalida > hoy && !esEmpleado))
                {
                    RedirigirSegunUsuario(esEmpleado);
                    return;
                }

                txtHotel.Text = data.Hotel;
                txtNumeroHabitacion.Text = data.NumeroHabitacion;
                txtCliente.Text = data.Cliente;

                txtFechaEntrada.Text = data.FechaEntrada.ToString("yyyy-MM-dd");
                txtFechaSalida.Text = data.FechaSalida.ToString("yyyy-MM-dd");
                txtNumeroAdultos.Text = data.NumeroAdultos.ToString();
                txtNumeroNinhos.Text = data.NumeroNinhos.ToString();
            }
        }

        private void RedirigirSegunUsuario(bool esEmpleado)
        {
            if (esEmpleado)
                Response.Redirect("GestionarReservaciones.aspx");
            else
                Response.Redirect("MisReservaciones.aspx");
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            try
            {
                if (string.IsNullOrWhiteSpace(txtFechaEntrada.Text) ||
                    string.IsNullOrWhiteSpace(txtFechaSalida.Text) ||
                    string.IsNullOrWhiteSpace(txtNumeroAdultos.Text) ||
                    string.IsNullOrWhiteSpace(txtNumeroNinhos.Text))
                {
                    MostrarMensaje("Todos los campos son requeridos.");
                    return;
                }

                DateTime entrada = DateTime.Parse(txtFechaEntrada.Text);
                DateTime salida = DateTime.Parse(txtFechaSalida.Text);

                if (entrada <= DateTime.Now || salida <= DateTime.Now)
                {
                    MostrarMensaje("Las fechas deben ser posteriores a hoy.");
                    return;
                }

                if (salida <= entrada)
                {
                    MostrarMensaje("La fecha de salida debe ser mayor que la fecha de entrada.");
                    return;
                }

                int adultos = int.Parse(txtNumeroAdultos.Text);
                int ninhos = int.Parse(txtNumeroNinhos.Text);

                if (adultos <= 0 || ninhos < 0)
                {
                    MostrarMensaje("Número de personas incorrecto.");
                    return;
                }

                Usuario usuario = (Usuario)Session["Usuario"];

                using (PvProyectoFinalDB db = new PvProyectoFinalDB("Database"))
                {
                    db.SpEditarReservacion(idReserva, entrada, salida, adultos, ninhos, usuario.idPersona.Value);
                }

                bool esEmpleado = Convert.ToBoolean(Session["esEmpleado"]);

                if (esEmpleado)
                    Response.Redirect("GestionarReservaciones.aspx");
                else
                    Response.Redirect("MisReservaciones.aspx");
            }
            catch
            {
                MostrarMensaje("Error al guardar la reservación.");
            }
        }

        private void MostrarMensaje(string msg)
        {
            ScriptManager.RegisterStartupScript(this, GetType(), "alert", $"alert('{msg}');", true);
        }

        protected void btnRegresar_Click(object sender, EventArgs e)
        {
            bool esEmpleado = Convert.ToBoolean(Session["esEmpleado"]);

            if (esEmpleado)
                Response.Redirect("GestionarReservaciones.aspx");
            else
                Response.Redirect("MisReservaciones.aspx");
        }
    }
}
