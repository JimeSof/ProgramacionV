<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CrearReservacion.aspx.cs" Inherits="ProyectoGrupo6.Pages.CrearReservacion" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <h1 style="color: #1750BA; font-family: Arial; font-weight: bold">Crear reservación</h1>

    <div class="container">


        <div>
            <span style="color: #1750BA; font-family: Arial;">Hotel:</span>
            <asp:DropDownList ID="ddlHotel" runat="server" CssClass="form-select"></asp:DropDownList>
            <!--Validaciones-->
            <asp:RequiredFieldValidator ID="rfvHotel" runat="server" InitialValue="" ControlToValidate="ddlHotel"
                ErrorMessage="Este valor es requerido" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
        </div>
        <br />

        <div>
            <span style="color: #1750BA; font-family: Arial;">Cliente:</span>
            <asp:DropDownList ID="ddlCliente" runat="server" CssClass="form-select"></asp:DropDownList>
            <!--Validaciones-->
            <asp:RequiredFieldValidator ID="rfvCliente" runat="server" InitialValue="" ControlToValidate="ddlCliente"
                ErrorMessage="Este valor es requerido" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
        </div>
        <br />

        <div class="row">
            <div class="col-3">
                <label style="color: #1750BA;">Fecha Entrada:</label>
                <asp:TextBox ID="txtFechaEntrada" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                <!--Validaciones-->
                <asp:RequiredFieldValidator ID="rfvFechEntrada" runat="server" InitialValue="" ControlToValidate="txtFechaEntrada"
                    ErrorMessage="Este valor es requerido" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>

                <asp:CustomValidator ID="cuvFechaEntrada" runat="server" ErrorMessage="La fecha es invalida" ControlToValidate="txtFechaEntrada"
                    OnServerValidate="cuvFechaEntrada_ServerValidate" ForeColor="Red" Display="Dynamic"></asp:CustomValidator>
            </div>

            <div class="col-3">
                <label style="color: #1750BA;">Fecha Salida:</label>
                <asp:TextBox ID="txtFechaSalida" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                <!--Validaciones-->
                <asp:RequiredFieldValidator ID="rfvFechaSalida" runat="server" InitialValue="" ControlToValidate="txtFechaSalida"
                    ErrorMessage="Este valor es requerido" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>

                <asp:CustomValidator ID="cuvFechaSalida" runat="server" ErrorMessage="La fecha es invalida" ControlToValidate="txtFechaSalida"
                    OnServerValidate="cuvFechaSalida_ServerValidate" ForeColor="Red" Display="Dynamic"></asp:CustomValidator>
            </div>
        </div>

        <br />

        <div class="row">
            <div class="col-3">
                <label style="color: #1750BA;">Número de adultos:</label>
                <asp:TextBox ID="txtNumAdultos" runat="server" CssClass="form-control" Text="1" TextMode="Number"></asp:TextBox>
                <!--Validaciones-->
                <asp:RequiredFieldValidator ID="rfvNumeroAdultos" runat="server" ControlToValidate="txtNumAdultos"
                    ErrorMessage="Este valor es requerido" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                <asp:CustomValidator ID="cuvNumeroAdultos" runat="server" ErrorMessage="Cantidad no valida para la habitacion"
                    ForeColor="Red" OnServerValidate="cuvNumeroAdultos_ServerValidate"></asp:CustomValidator>
            </div>
            <div class="col-3">
                <label style="color: #1750BA;">Número de niños:</label>
                <asp:TextBox ID="txtNumNinos" runat="server" CssClass="form-control" Text="0" TextMode="Number"></asp:TextBox>
                <!--Validaciones-->
                <asp:RequiredFieldValidator ID="rfvNumNinhos" runat="server" InitialValue="" ControlToValidate="txtNumNinos"
                    ErrorMessage="Este valor es requerido" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>

            </div>


        </div>
        <br />

        <div>
            <asp:Button ID="btnGuardar" runat="server" Text="Guardar" CssClass="btn btn-success" OnClick="btnGuardar_Click" />
            <asp:Button ID="btnRegresar" runat="server" Text="Regresar" CssClass="btn btn-danger" OnClick="btnRegresar_Click" CausesValidation="False" />
        </div>

    </div>
</asp:Content>
