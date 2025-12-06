<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CrearHabitacion.aspx.cs" Inherits="ProyectoGrupo6.Pages.CrearHabitacion" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div>
        <h1>Crear habitación</h1>
    </div>
    <div class="col-md-6">
        <!--------------------------------------------------------------------------------------->
        <div>
            <asp:Label ID="lblHotel" runat="server" Text="Hotel"> </asp:Label>

            <asp:DropDownList ID="ddlHotel" runat="server" CssClass="form-select w-100"></asp:DropDownList>
            <!--Validaciones-->
            <asp:RequiredFieldValidator ID="rfvDdlHotel" runat="server" ErrorMessage="Debe seleccionar un hotel de la lista"
                ControlToValidate="ddlHotel" InitialValue="" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
        </div>
        <!--------------------------------------------------------------------------------------->
        <div>
            <asp:Label ID="lblHabitacion" runat="server" Text="Número de habitación"></asp:Label>

            <asp:TextBox ID="txtHabitacion" runat="server" MaxLength="10" CssClass="form-control"></asp:TextBox>
            <!--Validaciones-->
            <asp:RequiredFieldValidator ID="rfvHabitacion" runat="server" ControlToValidate="txtHabitacion"
                ForeColor="Red" Display="Dynamic" ErrorMessage="Falta ingresar numero de habitación"></asp:RequiredFieldValidator>
        
            <asp:CustomValidator ID="cuvHabitacion" runat="server" ControlToValidate="txtHabitacion" 
                ErrorMessage="Esta habitación ya existe" Display="Dynamic" ForeColor="Red" OnServerValidate="cuvHabitacion_ServerValidate"></asp:CustomValidator>
        </div>
        <!--------------------------------------------------------------------------------------->
        <div>
            <asp:Label ID="lblCapacidad" runat="server" Text="Capacidad máxima"></asp:Label>

            <asp:TextBox ID="txtCantidad" runat="server" CssClass="form-control" TextMode="Number" Text="1"></asp:TextBox>
            <!--Validaciones-->
            <asp:RequiredFieldValidator ID="rfvCantidad" runat="server" ControlToValidate="txtCantidad"
                ForeColor="Red" Display="Dynamic" ErrorMessage="Falta ingresar capacidad de habitación"></asp:RequiredFieldValidator>
            <asp:RangeValidator ID="rvCantidad" runat="server" ErrorMessage="El numero debe ser entero entre 1-8"
                ControlToValidate="txtCantidad" MinimumValue="1" MaximumValue="8" Type="Integer" ForeColor="Red"></asp:RangeValidator>
        </div>
        <!--------------------------------------------------------------------------------------->
        <div>
            <asp:Label ID="lblDescripción" runat="server" Text="Descripción"></asp:Label>

            <asp:TextBox ID="txtDescripcion" runat="server" MaxLength="500" CssClass="form-control"></asp:TextBox>
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
        <asp:Button ID="btnRegresar" runat="server" Text="Regresar" CssClass="btn btn-danger" CausesValidation="false" OnClick="btnRegresar_Click" />
    </div>

</asp:Content>
