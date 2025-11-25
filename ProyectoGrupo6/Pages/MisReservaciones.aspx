<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="MisReservaciones.aspx.cs" Inherits="ProyectoGrupo6.Pages.MisReservaciones" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <!-- Mostrar nombre del usuario -->
    <asp:Label ID="lblUsuario" runat="server" 
               Text="" 
               Font-Bold="true" 
               Font-Size="Large"></asp:Label>

    <br /><br />

    <asp:GridView ID="grdReservaciones" runat="server"
        AutoGenerateColumns="False"
        CssClass="table table-bordered table-hover">

        <Columns>
            <asp:BoundField DataField="idReservacion" HeaderText="# Reservación" />
            <asp:BoundField DataField="hotel" HeaderText="Hotel" />
            <asp:BoundField DataField="fechaEntrada" HeaderText="Entrada" DataFormatString="{0:d}" />
            <asp:BoundField DataField="fechaSalida" HeaderText="Salida" DataFormatString="{0:d}" />
            <asp:BoundField DataField="costoTotal" HeaderText="Costo total" />

            <asp:TemplateField HeaderText="Acciones">
                <ItemTemplate>
                    <a href='Detalle.aspx?idReservacion=<%# Eval("idReservacion") %>'>Consultar</a>
                </ItemTemplate>
            </asp:TemplateField>

        </Columns>

    </asp:GridView>

</asp:Content>
