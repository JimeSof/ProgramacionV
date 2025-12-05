<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="HabitacionInactiva.aspx.cs" Inherits="ProyectoGrupo6.Pages.HabitacionInactiva" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    
    <div class="alert alert-info">
    
        <asp:Label ID="lblResultado" runat="server" Text=""></asp:Label>
    </div>
    
    <asp:Button ID="btnRegresar" runat="server" CssClass="btn btn-outline-secondary" Text="Regresar" OnClick="btnRegresar_Click" />
</asp:Content>
