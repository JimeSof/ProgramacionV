<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="EditarReservacion.aspx.cs" Inherits="ProyectoGrupo6.Pages.EditarReservacion" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">


    <h1>Modificar Reservaciones</h1>


    <div>
        <asp:HiddenField ID="hfnIdReservacion" runat="server" />
        <asp:HiddenField ID="hfncapacidadMaxima" runat="server" />
    </div>

    <div class="col-6">
        <asp:Label ID="lblHotel" runat="server" Text="Hotel"></asp:Label>
        <asp:TextBox ID="txtHotel" runat="server" CssClass="form-control" Enabled="false" TextMode="SingleLine"></asp:TextBox>
    </div>

    <div class="col-6">
        <asp:Label ID="lblNumeroHabitacion" runat="server" Text="Numero de habitación"></asp:Label>
        <asp:TextBox ID="txtNumeroHabitacion" runat="server" CssClass="form-control" Enabled="false" TextMode="SingleLine"></asp:TextBox>
    </div>

    <div class="col-6">
        <asp:Label ID="lblCliente" runat="server" Text="Cliente"></asp:Label>
        <asp:TextBox ID="txtCliente" runat="server" CssClass="form-control" Enabled="false" TextMode="SingleLine"></asp:TextBox>

    </div>
    <br />

    <!--Datos a rellenar-->
    <div class="row">
        <div class="col-3">
            <asp:Label ID="lblFechaEntrada" runat="server" Text="Fecha de entrada"></asp:Label>
            <asp:TextBox ID="txtFechaEntrada" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
            <!--Validaciones-->
            <asp:RequiredFieldValidator ID="rfvFechaEntrada" runat="server" ErrorMessage="La fecha de entrada es requerida"
                ControlToValidate="txtFechaEntrada" CssClass="text-danger" Display="Dynamic"></asp:RequiredFieldValidator>
            <asp:CustomValidator ID="cuvFechaEntrada" runat="server" ErrorMessage="La fecha de entrada debe ser posterior a hoy" ControlToValidate="txtFechaEntrada"
                OnServerValidate="cuvFechaEntrada_ServerValidate" CssClass="text-danger" Display="Dynamic"></asp:CustomValidator>
        </div>

        <div class="col-3">
            <asp:Label ID="lblFechaSalida" runat="server" Text="Fecha de salida"></asp:Label>
            <asp:TextBox ID="txtFechaSalida" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
            <!--Validaciones-->
            <asp:RequiredFieldValidator ID="rfvFechaSalida" runat="server" ErrorMessage="La fecha de salida es requerida"
                ControlToValidate="txtFechaSalida" CssClass="text-danger" Display="Dynamic"></asp:RequiredFieldValidator>
            <asp:CustomValidator ID="cuvFechaSalida" runat="server" ErrorMessage="La fecha de salida debe ser posterior a hoy" ControlToValidate="txtFechaSalida"
                OnServerValidate="cuvFechaSalida_ServerValidate" CssClass="text-danger" Display="Dynamic"></asp:CustomValidator><br />
            <asp:CustomValidator ID="cuvFechaSalidaMayor" runat="server" ErrorMessage="La fecha de salida debe ser mayor que la fecha de entrada" ControlToValidate="txtFechaSalida"
                OnServerValidate="cuvFechaSalidaMayor_ServerValidate" CssClass="text-danger" Display="Dynamic"></asp:CustomValidator>

        </div>
    </div>

    <div class="row">
        <div class="col-3">
            <asp:Label ID="lblNumeroAdultos" runat="server" Text="Número de adultos"></asp:Label>
            <asp:TextBox ID="txtNumeroAdultos" runat="server" CssClass="form-control" TextMode="Number"></asp:TextBox>
            <!--Validaciones-->
            <asp:RequiredFieldValidator ID="rfvNumeroAdultos" runat="server" ErrorMessage="El número de adultos es requerido" 
                ControlToValidate="txtNumeroAdultos" CssClass="text-danger" Display="Dynamic"></asp:RequiredFieldValidator>
            <asp:RangeValidator ID="rvNumeroAdultos" runat="server" ErrorMessage="El número de adultos debe ser mayor a 0" ControlToValidate="txtNumeroAdultos" 
                MinimumValue="1" MaximumValue="100" Type="Integer" CssClass="text-danger" Display="Dynamic"></asp:RangeValidator>
        </div>
        <div class="col-3">
            <asp:Label ID="lblNumeroNinhos" runat="server" Text="Número de niños"></asp:Label>
            <asp:TextBox ID="txtNumeroNinhos" runat="server" CssClass="form-control" TextMode="Number"></asp:TextBox>
            <!--Validaciones-->
            <asp:RequiredFieldValidator ID="rfvNumeroNinhos" runat="server" ErrorMessage="El número de niños es requerido" 
                ControlToValidate="txtNumeroNinhos" CssClass="text-danger" Display="Dynamic"></asp:RequiredFieldValidator>
            <asp:RangeValidator ID="rvNumeroNinhos" runat="server" ErrorMessage="El número de niños debe ser 0 o mayor" ControlToValidate="txtNumeroNinhos" 
                MinimumValue="0" MaximumValue="100" Type="Integer" CssClass="text-danger" Display="Dynamic"></asp:RangeValidator>
        </div>
        <asp:CustomValidator ID="cuvNumeroAdultosMaximo" runat="server" ErrorMessage="Cantidad no valida para la habitacion"
        ForeColor="Red" OnServerValidate="cuvNumeroAdultosMaximo_ServerValidate" Display="Dynamic"></asp:CustomValidator>
    </div>
    <br />
    <div>
        <asp:Button ID="btnGuardar" runat="server" Text="Guardar" CssClass="btn btn-success" OnClick="btnGuardar_Click" />
        <asp:Button ID="btnRegresar" runat="server" Text="Regresar" CssClass="btn btn-outline-secondary" CausesValidation="false" OnClick="btnRegresar_Click" />
    </div>



</asp:Content>
