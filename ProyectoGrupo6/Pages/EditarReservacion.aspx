<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="EditarReservacion.aspx.cs" Inherits="ProyectoGrupo6.Pages.EditarReservacion" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <h1 style="font-size:30px; font-weight:bold;">Modificar reservación</h1>

    <div style="max-width:600px;">

        <!-- HOTEL -->
        <asp:Label runat="server" Text="Hotel"></asp:Label>
        <asp:TextBox ID="txtHotel" runat="server" CssClass="form-control"
            ReadOnly="true" Style="background:#edf0f5;"></asp:TextBox>

        <!-- HABITACIÓN -->
        <asp:Label runat="server" Text="Número de habitación"></asp:Label>
        <asp:TextBox ID="txtNumeroHabitacion" runat="server" CssClass="form-control"
            ReadOnly="true" Style="background:#edf0f5;"></asp:TextBox>

        <!-- CLIENTE -->
        <asp:Label runat="server" Text="Cliente"></asp:Label>
        <asp:TextBox ID="txtCliente" runat="server" CssClass="form-control"
            ReadOnly="true" Style="background:#edf0f5;"></asp:TextBox>

        <br />

        <!-- FECHAS -->
        <div class="row">
            <div class="col-6">
                <asp:Label runat="server" Text="Fecha de entrada"></asp:Label>
                <asp:TextBox ID="txtFechaEntrada" runat="server" CssClass="form-control"
                    TextMode="Date"></asp:TextBox>
            </div>

            <div class="col-6">
                <asp:Label runat="server" Text="Fecha de salida"></asp:Label>
                <asp:TextBox ID="txtFechaSalida" runat="server" CssClass="form-control"
                    TextMode="Date"></asp:TextBox>
            </div>
        </div>

        <br />

        <!-- ADULTOS / NIÑOS -->
        <div class="row">
            <div class="col-6">
                <asp:Label runat="server" Text="Número de adultos"></asp:Label>
                <asp:TextBox ID="txtNumeroAdultos" runat="server" CssClass="form-control"
                    TextMode="Number" ></asp:TextBox>
            </div>

            <div class="col-6">
                <asp:Label runat="server" Text="Número de niños"></asp:Label>
                <asp:TextBox ID="txtNumeroNinhos" runat="server" CssClass="form-control"
                    TextMode="Number"></asp:TextBox>
            </div>
        </div>

        <br />

        <!-- BOTONES -->
        <div style="margin-top:15px;">
            <asp:Button ID="btnGuardar" runat="server" Text="Guardar"
                CssClass="btn btn-success" OnClick="btnGuardar_Click" />

            <asp:Button ID="btnRegresar" runat="server" Text="Regresar"
                CssClass="btn btn-outline-dark" OnClick="btnRegresar_Click" />
        </div>

    </div>

</asp:Content>
