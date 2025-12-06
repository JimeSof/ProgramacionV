<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="EditarHabitacion.aspx.cs" Inherits="ProyectoGrupo6.Pages.EditarHabitacion" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div>
        <h1>Editar habitación</h1>
    </div>
    <!--------------------------------------------------------------------------------------->
    <div class="col-md-6">
        <div>
            <asp:HiddenField ID="hdnIdHabitacion" runat="server" />
            <asp:HiddenField ID="hdnHotel" runat="server" />
        </div>
        <div>
            <asp:Label ID="lblHotel" runat="server" Text="Hotel"></asp:Label>
        </div>
        <div>
            <asp:TextBox ID="txtHotel" runat="server" ReadOnly="true" Enabled="false" CssClass="form-control" TextMode="SingleLine"></asp:TextBox>
        </div>
        <!--------------------------------------------------------------------------------------->
        <div>
            <asp:Label ID="lblHabitacion" runat="server" Text="Número de habitación"></asp:Label>
        </div>
        <div>
            <asp:TextBox ID="txtHabitacion" runat="server" MaxLength="10" CssClass="form-control" TextMode="SingleLine"></asp:TextBox>
            <!--Validaciones-->
            <asp:RequiredFieldValidator ID="rfvHabitacion" runat="server" ControlToValidate="txtHabitacion"
                ErrorMessage="Debes ingresar la habitación."></asp:RequiredFieldValidator>

            <asp:CustomValidator ID="cuvHabitacion" runat="server" ControlToValidate="txtHabitacion"
                ErrorMessage="Esta habitación ya existe" Display="Dynamic" ForeColor="Red" OnServerValidate="cuvHabitacion_ServerValidate"></asp:CustomValidator>
        </div>
        <!--------------------------------------------------------------------------------------->
        <div>
            <asp:Label ID="lblCapacidad" runat="server" Text="Capacidad máxima"></asp:Label>
        </div>
        <div>
            <asp:TextBox ID="txtCantidad" runat="server" CssClass="form-control" TextMode="Number"></asp:TextBox>
            <!--Validaciones-->
            <asp:RequiredFieldValidator ID="rfvCantidad" runat="server" ControlToValidate="txtCantidad"
                ForeColor="Red" Display="Dynamic" ErrorMessage="Falta ingresar capacidad de habitación"></asp:RequiredFieldValidator>
            <asp:RangeValidator ID="rvCantidad" runat="server" ErrorMessage="El numero debe ser entero entre 1-8"
                ControlToValidate="txtCantidad" MinimumValue="1" MaximumValue="8" Type="Integer" ForeColor="Red"></asp:RangeValidator>
        </div>
        <!--------------------------------------------------------------------------------------->
        <div>
            <asp:Label ID="lblDescripción" runat="server" Text="Descripción"></asp:Label>
        </div>
        <div>
            <asp:TextBox ID="txtDescripcion" runat="server" MaxLength="500" CCssClass="form-control" TextMode="MultiLine"></asp:TextBox>
            <!--Validaciones-->
            <asp:RequiredFieldValidator ID="rfvDescripcion" runat="server" ControlToValidate="txtDescripcion"
                ForeColor="Red" Display="Dynamic" ErrorMessage="Falta ingresar descripción"></asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator ID="revDescripcion" runat="server" ErrorMessage="El máximo es 500 caracteres"
                ControlToValidate="txtDescripcion" ValidationExpression="^.{1,500}$" Display="Dynamic"></asp:RegularExpressionValidator>
        </div>
    </div>
    <!--------------------------------------------------------------------------------------->
    <br />
    <div>
        <asp:Button ID="btnGuardar" runat="server" Text="Guardar" CssClass="btn btn-success" OnClick="btnGuardar_Click" />
        <asp:Button ID="btnInactivar" runat="server" Text="Inactivar" CausesValidation="false" CssClass="btn btn-danger" OnClick="btnInactivar_Click" />
        <asp:Button ID="btnRegresar" runat="server" Text="Regresar" CausesValidation="false" CssClass="btn btn-secondary" OnClick="btnRegresar_Click" />
    </div>

</asp:Content>
