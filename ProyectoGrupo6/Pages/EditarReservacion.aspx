<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="EditarReservacion.aspx.cs" Inherits="ProyectoGrupo6.Pages.EditarReservacion" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <h1 style="color: #1750BA; font-family: Arial; font-weight: bold">Editar Reservacion</h1>

    <div class="container">
        <div>
            <asp:HiddenField ID="hfnIdReservacion" runat="server" />
        </div>

        <div class="col-3">
            <asp:Label ID="lblHotel" runat="server" Text="Hotel"></asp:Label>
            <asp:TextBox ID="txtHotel" runat="server" CssClass="form-control" Enabled="false" TextMode="SingleLine"></asp:TextBox>
        </div>

        <div class="col-3">
            <asp:Label ID="lblNumeroHabitacion" runat="server" Text="Numero de habitación"></asp:Label>
            <asp:TextBox ID="txtNumeroHabitacion" runat="server" CssClass="form-control" Enabled="false" TextMode="SingleLine"></asp:TextBox>
        </div>

        <div class="col-3">
            <asp:Label ID="lblCliente" runat="server" Text="Cliente"></asp:Label>
            <asp:TextBox ID="txtCliente" runat="server" CssClass="form-control" Enabled="false" TextMode="SingleLine"></asp:TextBox>
        </div>
    </div>
    <br />

    <div class="row">
        <div class="col-3">
            <asp:Label ID="lblFechaEntrada" runat="server" Text="Fecha de entrada"></asp:Label>
            <asp:TextBox ID="txtFechaEntrada" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
        </div>
        <div class="col-3">
            <asp:Label ID="lblFechaSalida" runat="server" Text="Fecha de salida"></asp:Label>
            <asp:TextBox ID="txtFechaSalida" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
        </div>
    </div>

    <div class="row">
        <div class="col-3">
            <asp:Label ID="lblNumeroAdultos" runat="server" Text="Número de adultos"></asp:Label>
            <asp:TextBox ID="txtNumeroAdultos" runat="server" CssClass="form-control" TextMode="Number"></asp:TextBox>
        </div>
        <div class="col-3">
            <asp:Label ID="lblNumeroNinhos" runat="server" Text="Número de niños"></asp:Label>
            <asp:TextBox ID="txtNumeroNinhos" runat="server" CssClass="form-control" TextMode="Number"></asp:TextBox>
        </div>

        <br />
        <div>
            <asp:Button ID="btnGuardar" runat="server" Text="Guardar" CssClass="btn btn-success" OnClick="btnGuardar_Click" />
            <asp:Button ID="btnRegresar" runat="server" Text="Regresar" CssClass="btn btn-outline-dark" OnClick="btnRegresar_Click" />
        </div>

    </div>

</asp:Content>
