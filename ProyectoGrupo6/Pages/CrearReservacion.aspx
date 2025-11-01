<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CrearReservacion.aspx.cs" Inherits="ProyectoGrupo6.Pages.CrearReservacion" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <h1 style="color: #1750BA; font-family: Arial; font-weight: bold">Crear reservación</h1>

    <div>
        <div>
            <span style="color: #1750BA; font-family: Arial;">Hotel:</span>
            <asp:DropDownList ID="ddlHotel" runat="server" placeholder="Seleccione un Hotel"></asp:DropDownList>
        </div>
        <br />
        <div>
            <span style="color: #1750BA; font-family: Arial;">Cliente:</span>
            <asp:DropDownList ID="ddlCliente" runat="server" placeholder=""></asp:DropDownList>

        </div>
        <br />

        <div class="row">
            <div class="col-3">
                <label style="color: #1750BA;">Fecha Entrada:</label>
                <asp:TextBox ID="txtFechaEntrada" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
            </div>
            <div class="col-3">
                <label style="color: #1750BA;">Fecha Salida:</label>
                <asp:TextBox ID="txtFechaSalida" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
            </div>
        </div>
        <br />

        <div class="row">
            <div class="col-3">
                <label style="color: #1750BA;">Número de adultos:</label>
                <asp:TextBox ID="txtAdultos" runat="server" CssClass="form-control" Text="1" TextMode="Number"></asp:TextBox>
            </div>
            <div class="col-3">
                <label style="color: #1750BA;">Número de niños:</label>
                <asp:TextBox ID="txtNinos" runat="server" CssClass="form-control" Text="0" TextMode="Number"></asp:TextBox>
            </div>
        </div>
        <br />

        <div>
            <asp:Button ID="btnGuardar" runat="server" Text="Guardar" CssClass="btn btn-success" />
            <a href="GestionarReservaciones.aspx" class="btn btn-danger" role="button">Cancelar</a>
        </div>

    </div>
</asp:Content>
