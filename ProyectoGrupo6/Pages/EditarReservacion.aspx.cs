using DataModels;
using LinqToDB;
using ProyectoGrupo6.Classes;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Caching;
using System.Web.UI;
using static LinqToDB.Common.Configuration;

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
                    bool esEmpleado = Convert.ToBoolean(Session["esEmpleado"]);

                    CargarDatos(usuario, esEmpleado);

                    
                }
                catch { }

            }

                
        }

        private void CargarDatos(Usuario usuario, bool esEmpleado)
        {
            //este public lo que hace es cargar los datos de la reservacion seleccionada
            int id = int.Parse(Request.QueryString["idReservacion"]);

            using (PvProyectoFinalDB db = new PvProyectoFinalDB("Database"))
            {
                var data = db.SpObtenerReservacionById(id, usuario.idPersona.Value, esEmpleado).FirstOrDefault();

                DateTime hoy = DateTime.Now;

                //verifica si la reservacion esta inactiva o si la fecha de salida ya paso o si la fecha de entrada es hoy o ya paso y el usuario no es empleado
                //en ese caso redirige segun el tipo de usuario y buscar entrar por url
                if (data == null)
                {
                    RedirigirSegunUsuario(esEmpleado);
                    return;

                }
                //verifica si el usuario es empleado o si la reservacion pertenece al usuario
                if (!esEmpleado && data.IdPersona != usuario.idPersona )
                {
                    Response.Redirect("MisReservaciones.aspx");
                    return;
                }

                if (data.Estado == 'I' || data.FechaSalida <= hoy || (data.FechaEntrada <= hoy && data.FechaSalida > hoy))
                {
                    RedirigirSegunUsuario(esEmpleado);
                    return;
                }

                //llena los campos con los datos obtenidos
                hfnIdReservacion.Value = data.IdReservacion.ToString();
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
            //redirecciona segun el tipo de usuario
            if (esEmpleado)
                Response.Redirect("GestionarReservaciones.aspx");
            else
                Response.Redirect("MisReservaciones.aspx");
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        { //Permite guardar los cambios realizados en la reservacion usando un procedimiento almacenado
            try
            {
                //LAS VALIDACIONES NO PUEDEN IR EN EL GUARDAR, DEBEN IR APARTE EN REQUIERIED FIELD VALIDATOR O CUSTOM VALIDATOR


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

                //HASTA AQUI LAS VALIDACIONS NO PUEDEN IR EN EL GUARDAR, DEBEN IR APARTE EN REQUIERIED FIELD VALIDATOR O CUSTOM VALIDATOR

                //PON LAS VARIABLES AQUI PARA QUE NO HAYA PROBLEMAS AL MOMENTO DE GUARDAR


                Usuario usuario = (Usuario)Session["Usuario"];

                using (PvProyectoFinalDB db = new PvProyectoFinalDB("Database"))
                {
                  //  db.SpEditarReservacion(idReserva, entrada, salida, adultos, ninhos, usuario.idPersona.Value);
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

            try
            {
                int id = int.Parse(Request.QueryString["idReservacion"]);
                Response.Redirect("~/Pages/Detalle.aspx?idReservacion=" + id);

            }
            catch { }
        }
    }
}
