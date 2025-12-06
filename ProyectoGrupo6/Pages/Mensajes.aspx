<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Mensajes.aspx.cs" Inherits="ProyectoGrupo6.Pages.HabitacionInactiva" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    
    <asp:Panel ID="pnlResultado" runat="server" Visible="true" CssClass="alert alert-info" >
         <asp:Label ID="lblResultado" runat="server" Text=""></asp:Label>
    </asp:Panel>

    
    <asp:Button ID="btnRegresar" runat="server" CssClass="btn btn-outline-secondary" Text="Regresar" OnClick="btnRegresar_Click" />
</asp:Content>
