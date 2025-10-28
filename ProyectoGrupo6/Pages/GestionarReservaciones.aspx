<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="GestionarReservaciones.aspx.cs" Inherits="ProyectoGrupo6.Pages.GestionarReservaciones" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <h1 style="font-family: Arial, Helvetica, sans-serif">Gestionar Reservaciones</h1>

    <div>
        <a href="CrearReservacion.aspx" class="btn btn-primary" role="button">Nuevo reservación</a>
    </div>
    <br />

    <asp:GridView ID="grdGestion" runat="server" AutoGenerateColumns="false" CssClass="table table-bordered table-hover">
        <Columns>
            <asp:BoundField DataField="idReservacion" HeaderText="# reservación" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" HeaderStyle-VerticalAlign="Middle" />
            <asp:BoundField DataField="cliente" HeaderText="Cliente" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" HeaderStyle-VerticalAlign="Middle" />
            <asp:BoundField DataField="hotel" HeaderText="Hotel" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" HeaderStyle-VerticalAlign="Middle" />
            <asp:BoundField DataField="fechaEntrada" HeaderText="Fecha entrada" DataFormatString="{0:d}" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" HeaderStyle-VerticalAlign="Middle" />
            <asp:BoundField DataField="fechaSalida" HeaderText="Fecha salida" DataFormatString="{0:d}" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" HeaderStyle-VerticalAlign="Middle" />
            <asp:BoundField DataField="costoTotal" HeaderText="Costo" DataFormatString="{0:C4}" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right" HeaderStyle-VerticalAlign="Middle" />
            <asp:TemplateField HeaderText="Estado" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" HeaderStyle-VerticalAlign="Middle">
                <ItemTemplate>
                    <%#  
                         Eval("estado").ToString() == "I" ? "Cancelada" : 
                         Eval("estado").ToString() == "A" && Convert.ToDateTime(Eval("fechaSalida")) < DateTime.UtcNow ? "Finalizado" : 
                         Eval("estado").ToString() == "A" && Convert.ToDateTime(Eval("fechaEntrada")) <= DateTime.UtcNow ? "En proceso" : 
                         Eval("estado").ToString() == "A" && Convert.ToDateTime(Eval("fechaSalida")) > DateTime.UtcNow && 
                         Convert.ToDateTime(Eval("fechaEntrada")) > DateTime.UtcNow ? "En espera" : ""
                    %>
                </ItemTemplate>
            </asp:TemplateField>

            <asp:BoundField HeaderText="Accion" />



        </Columns>
        <HeaderStyle Font-Bold="True" />
    </asp:GridView>

</asp:Content>
