<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Detalle.aspx.cs" Inherits="ProyectoGrupo6.Detalle" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <h1>Detalle de la reservación</h1>
    <br />

    <asp:DetailsView ID="dvDetalle" runat="server" AutoGenerateRows="false" CssClass="dvdetail table table-bordered table-hover">
        <Fields>
            <asp:BoundField DataField="idReservacion" HeaderText="# reservacion" />
            <asp:BoundField DataField="hotel" HeaderText="Hotel" />
            <asp:BoundField DataField="numeroHabitacion" HeaderText="Número habitación" />
            <asp:BoundField DataField="cliente" HeaderText="Cliente" />
            <asp:BoundField DataField="fechaEntrada" HeaderText="Fecha entrada" DataFormatString="{0:d}" />
            <asp:BoundField DataField="fechaSalida" HeaderText="Fecha salida" DataFormatString="{0:d}" />
            <asp:BoundField DataField="totalDiasReservacion" HeaderText="Días de la reserva" />
            <asp:BoundField DataField="numeroAdultos" HeaderText="Número de adultos" />
            <asp:BoundField DataField="numeroNinhos" HeaderText="Número de niños" />
            <asp:BoundField DataField="costoTotal" HeaderText="Costo Total" DataFormatString="${0:N2}" />

        </Fields>
    </asp:DetailsView>
    <br />

    <div class="cajabtn">
        <asp:Button ID="btnEditar" runat="server" Text="Editar reservación" CssClass="btn btn-outline-primary" Visible="false" OnClick="btnEditar_Click" />
        <asp:Button ID="btnCancelar" runat="server" Text="Cancelar reservación" CssClass="btn btn-outline-danger" Visible="false" OnClick="btnCancelar_Click" OnClientClick="return confirm('¿Está seguro de cancelar la reservacion?');"/>
        <asp:Button ID="btnRegresar" runat="server" Text="Regresar" CssClass="btn btn-outline-secondary" OnClick="btnRegresar_Click"/>
        
    </div>

    <br />

    <asp:GridView ID="grdBitacora" runat="server" AutoGenerateColumns="false" CssClass="rgrid table table-bordered table-hover"
        HeaderStyle-CssClass="rgrid-header">
        <Columns>
            <asp:BoundField DataField="fechaDeLaAccion" HeaderText="Fecha" />
            <asp:BoundField DataField="accionRealizada" HeaderText="Accion" />
            <asp:BoundField DataField="nombreCompleto" HeaderText="Realizada por" />
        </Columns>
    </asp:GridView>

</asp:Content>
