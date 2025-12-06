<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ListarHabitaciones.aspx.cs" Inherits="ProyectoGrupo6.Pages.ListarHabitaciones" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="titulo">
        <div class="izquierda">
            <h1>Lista habitaciones</h1>
        </div>
        <div class="derecha">
            <asp:Label ID="lblUsuario" runat="server" Text="Usuario" Font-Bold="True"></asp:Label>
        </div>
    </div>
    <!--------------------------------------------------------------------------------------->
    <div>
        <a href="CrearHabitacion.aspx" class="btn btn_cr" role="button">Crear habitaciones</a>
    </div>

    <!--------------------------------------------------------------------------------------->
    <div>
        <asp:GridView ID="grdListaHabitaciones" runat="server" AutoGenerateColumns="false" CssClass="rgrid table table-bordered table-hover"
            HeaderStyle-CssClass="rgrid-header" RowStyle-BackColor="WhiteSmoke" AlternatingRowStyle-BackColor="White">
            <Columns>
                <asp:BoundField DataField="idHabitacion" HeaderText="ID"
                    HeaderStyle-CssClass="text-center" ItemStyle-HorizontalAlign="Center"></asp:BoundField>

                <asp:BoundField DataField="Nombre" HeaderText="Hotel"
                    HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left"></asp:BoundField>

                <asp:BoundField DataField="numeroHabitacion" HeaderText="Número habitación"
                    HeaderStyle-CssClass="text-center" ItemStyle-HorizontalAlign="Center"></asp:BoundField>

                <asp:BoundField DataField="capacidadMaxima" HeaderText="Capacidad máxima"
                    HeaderStyle-CssClass="text-center" ItemStyle-HorizontalAlign="Center"></asp:BoundField>



                <asp:TemplateField HeaderText="Estado" HeaderStyle-CssClass="text-center" ItemStyle-HorizontalAlign="Center">
                    <ItemTemplate>
                        <%# Eval("estado").ToString() == "A" ? "Activa" : "Inactiva" %>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="" HeaderStyle-CssClass="text-center" ItemStyle-HorizontalAlign="Center">
                    <ItemTemplate>
                        <%# Eval("estado").ToString() == "A"
                                ? "<a href='EditarHabitacion.aspx?idHabitacion=" + Eval("idHabitacion") + "'>Modificar</a>"
                                : (Eval("estado").ToString() == "I"
                                    ? "<a href='Mensajes.aspx?idHabitacion=" + Eval("idHabitacion") + "'>Modificar</a>"
                                    : "Sin acción") %>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>
</asp:Content>
