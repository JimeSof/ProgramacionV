using DataModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.DynamicData;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ProyectoGrupo6.Pages
{
    public partial class CrearReservacion : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                //si no existe sesion, vuelve al login
                if (Session["idPersona"] == null)
                {
                    Response.Redirect("~/Pages/Login.aspx");
                    return;
                }

                if (!IsPostBack)
                {
                    using (PvProyectoFinalDB db = new PvProyectoFinalDB("Database"))
                    {
                        var hotel = (from Hotel in db.Hotels
                                     select new
                                     {
                                         Hotel.IdHotel,
                                         Hotel.Nombre
                                     }).ToList();

                        ddlHotel.DataValueField = "IdHotel";
                        ddlHotel.DataTextField = "Nombre";
                        ddlHotel.DataSource = hotel;
                        ddlHotel.DataBind();

                        ddlHotel.Items.Insert(0, new ListItem("Seleccione un hotel", ""));


                        bool esEmpleado = Convert.ToBoolean(Session["esEmpleado"]);
                        if (esEmpleado == true)
                        {

                            var nombrePersona = (from Persona in db.Personas
                                                 select new
                                                 {
                                                     Persona.IdPersona,
                                                     Persona.NombreCompleto
                                                 }).ToList();

                            ddlCliente.DataValueField = "IdPersona";
                            ddlCliente.DataTextField = "NombreCompleto";
                            ddlCliente.DataSource = nombrePersona;
                            ddlCliente.Enabled = true;
                            ddlCliente.DataBind();
                        }
                        else
                        {
                            int idPersona = int.Parse(Session["idPersona"].ToString());

                            var nombrePersona = (from Persona in db.Personas
                                                 where Persona.IdPersona == idPersona
                                                 select new
                                                 {
                                                     Persona.IdPersona,
                                                     Persona.NombreCompleto
                                                 }).ToList();

                            if (nombrePersona != null && nombrePersona.Count > 0)
                            {
                                ddlCliente.Items.Clear();
                                ddlCliente.Items.Add(new ListItem(nombrePersona[0].NombreCompleto.ToString()));
                                ddlCliente.Enabled = false;
                            }

                        }


                    }
                }


            }
            catch
            {

            }
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            using (PvProyectoFinalDB db = new PvProyectoFinalDB("Database"))
            { }
        }

        protected void btnRegresar_Click(object sender, EventArgs e)
        {
            bool esEmpleado = Convert.ToBoolean(Session["esEmpleado"]);

            if (esEmpleado == true)
            {
                Response.Redirect("GestionarReservaciones.aspx");
            }
            else
            {
                Response.Redirect("MisReservaciones.aspx");
            }
        }
    }
}