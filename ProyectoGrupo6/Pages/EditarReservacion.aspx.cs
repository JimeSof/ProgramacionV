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
                if (!esEmpleado && data.IdPersona != usuario.idPersona)
                {
                    Response.Redirect("MisReservaciones.aspx");
                    return;
                }

                //verifica si la reservacion esta inactiva o si la fecha de salida ya paso
                if (data.Estado == 'I' || data.FechaSalida <= hoy)
                {
                    RedirigirSegunUsuario(esEmpleado);
                    return;
                }
                else if (data.FechaEntrada <= hoy && data.FechaSalida > hoy && esEmpleado == false)
                {
                    Response.Redirect("MisReservaciones.aspx");
                    return;
                }

                //llena los campos con los datos obtenidos 
                hfnIdReservacion.Value = data.IdReservacion.ToString();
                hfncapacidadMaxima.Value = data.CapacidadMaxima.ToString();

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
            if (Page.IsValid)
            {
                try
                {

                    // Si llegamos aquí, todas las validaciones ya pasaron

                    // Variables para guardar
                    int idReserva = int.Parse(hfnIdReservacion.Value);
                    DateTime entrada = DateTime.Parse(txtFechaEntrada.Text);
                    DateTime salida = DateTime.Parse(txtFechaSalida.Text);
                    int adultos = int.Parse(txtNumeroAdultos.Text);
                    int ninhos = int.Parse(txtNumeroNinhos.Text);
                    Usuario usuario = (Usuario)Session["Usuario"];

                    using (PvProyectoFinalDB db = new PvProyectoFinalDB("Database"))
                    {
                        db.SpEditarReservacion(idReserva, entrada, salida, adultos, ninhos, usuario.idPersona.Value);
                    }

                    Session["Mensaje"] = "EditarReservacion";
                    Response.Redirect("~/Pages/Mensajes.aspx");
                }
                catch
                {
                    MostrarMensaje("Error al guardar la reservación.");
                }
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

        // Métodos de validación para los CustomValidators

        protected void cuvFechaEntrada_ServerValidate(object source, System.Web.UI.WebControls.ServerValidateEventArgs args)
        {
            try
            {
                DateTime fechaEntrada;
                if (DateTime.TryParse(args.Value, out fechaEntrada))
                {
                    args.IsValid = fechaEntrada > DateTime.Now;
                }
                else
                {
                    args.IsValid = false;
                }
            }
            catch { }
        }

        protected void cuvFechaSalida_ServerValidate(object source, System.Web.UI.WebControls.ServerValidateEventArgs args)
        {
            try
            {
                DateTime fechaSalida;
                if (DateTime.TryParse(args.Value, out fechaSalida))
                {
                    args.IsValid = fechaSalida > DateTime.Now;
                }
                else
                {
                    args.IsValid = false;
                }
            }
            catch { }

        }

        protected void cuvFechaSalidaMayor_ServerValidate(object source, System.Web.UI.WebControls.ServerValidateEventArgs args)
        {
            try
            {
                DateTime fechaEntrada, fechaSalida;
                if (DateTime.TryParse(txtFechaEntrada.Text, out fechaEntrada) &&
                    DateTime.TryParse(args.Value, out fechaSalida))
                {
                    args.IsValid = fechaSalida >= fechaEntrada;
                }
                else
                {
                    args.IsValid = false;
                }
            }
            catch { }
        }

        protected void cuvNumeroAdultosMaximo_ServerValidate(object source, System.Web.UI.WebControls.ServerValidateEventArgs args)
        {
            try
            {
                int capacidadMaxima = Convert.ToInt32(hfncapacidadMaxima.Value);

                int numAdultos = int.Parse(txtNumeroAdultos.Text);
                int numNinhos = int.Parse(txtNumeroNinhos.Text);

                int cantidadActual = numAdultos + numNinhos;

                if (cantidadActual > capacidadMaxima)
                {
                    args.IsValid = false;
                    cuvNumeroAdultosMaximo.ErrorMessage = "La cantidad de personas supera la capacidad máxima de esta habitación.";
                }
                else
                {
                    args.IsValid = true;
                }
            }
            catch { }
        }
    }
}
