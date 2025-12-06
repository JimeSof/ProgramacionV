<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CrearReservacion.aspx.cs" Inherits="ProyectoGrupo6.Pages.CrearReservacion" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <h1>Crear reservación</h1>

    <div class="col-md-6">

        <div>
            <span>Hotel:</span>
            <asp:DropDownList ID="ddlHotel" runat="server" CssClass="form-select w-100"></asp:DropDownList>
            <!--Validaciones-->
            <asp:RequiredFieldValidator ID="rfvHotel" runat="server" InitialValue="" ControlToValidate="ddlHotel"
                ErrorMessage="Este valor es requerido" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
        </div>
        <br />

        <div>
            <span>Cliente:</span>
            <asp:DropDownList ID="ddlCliente" runat="server" CssClass="form-select w-100"></asp:DropDownList>
            <!--Validaciones-->
            <asp:RequiredFieldValidator ID="rfvCliente" runat="server" InitialValue="" ControlToValidate="ddlCliente"
                ErrorMessage="Este valor es requerido" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
        </div>
        <br />
    </div>
    <div>
        <div class="row">
            <div class="col-3">
                <label>Fecha Entrada:</label>
                <asp:TextBox ID="txtFechaEntrada" runat="server" CssClass="form-control w-100" TextMode="Date"></asp:TextBox>
                <!--Validaciones-->
                <asp:RequiredFieldValidator ID="rfvFechEntrada" runat="server" InitialValue="" ControlToValidate="txtFechaEntrada"
                    ErrorMessage="Este valor es requerido" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>

                <asp:CustomValidator ID="cuvFechaEntrada" runat="server" ErrorMessage="La fecha es invalida" ControlToValidate="txtFechaEntrada"
                    OnServerValidate="cuvFechaEntrada_ServerValidate" ForeColor="Red" Display="Dynamic"></asp:CustomValidator>
            </div>

            <div class="col-3">
                <label>Fecha Salida:</label>
                <asp:TextBox ID="txtFechaSalida" runat="server" CssClass="form-control w-100" TextMode="Date"></asp:TextBox>
                <!--Validaciones-->
                <asp:RequiredFieldValidator ID="rfvFechaSalida" runat="server" InitialValue="" ControlToValidate="txtFechaSalida"
                    ErrorMessage="Este valor es requerido" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>

            </div>
        </div>

        <br />

        <div class="row">
            <div class="col-3">
                <label>Número de adultos:</label>
                <asp:TextBox ID="txtNumAdultos" runat="server" CssClass="form-control" Text="1" TextMode="Number"></asp:TextBox>
                <!--Validaciones-->
                <asp:RequiredFieldValidator ID="rfvNumeroAdultos" runat="server" ControlToValidate="txtNumAdultos"
                    ErrorMessage="Este valor es requerido" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
            </div>
            <div class="col-3">
                <label>Número de niños:</label>
                <asp:TextBox ID="txtNumNinos" runat="server" CssClass="form-control" Text="0" TextMode="Number"></asp:TextBox>
                <!--Validaciones-->
                <asp:RequiredFieldValidator ID="rfvNumNinhos" runat="server" InitialValue="" ControlToValidate="txtNumNinos"
                    ErrorMessage="Este valor es requerido" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
            </div>

            <asp:CustomValidator ID="cuvNumeroAdultos" runat="server" ErrorMessage="Cantidad no valida para la habitacion"
                    ForeColor="Red" OnServerValidate="cuvNumeroAdultos_ServerValidate" Display="Dynamic"></asp:CustomValidator>
        </div>
    </div>
    <br />
    <div>
        <asp:Button ID="btnGuardar" runat="server" Text="Guardar" CssClass="btn btn-success" OnClick="btnGuardar_Click" />
        <asp:Button ID="btnRegresar" runat="server" Text="Regresar" CssClass="btn btn-danger" OnClick="btnRegresar_Click" CausesValidation="False" />
    </div>


</asp:Content>
