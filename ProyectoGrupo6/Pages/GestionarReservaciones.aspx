<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="GestionarReservaciones.aspx.cs" Inherits="ProyectoGrupo6.Pages.GestionarReservaciones" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    
    <link rel="stylesheet" href="../Content/Estilos.css" />

    <h1 style="font-family: Arial, Helvetica, sans-serif">Gestionar Reservaciones</h1>

    <!--El filtro de busqueda-->
    <div id="flitro">
        <asp:BulletedList ID="BulletedList1" runat="server"></asp:BulletedList>
    </div>

    <div>
        <a href="CrearReservacion.aspx" class="btn btn-primary" role="button">Nuevo reservación</a>
    </div>
    <br />

    <!--GridView para visualizar los datos de la tabla para gestionar las reservaciones-->
    <asp:GridView ID="grdGestion" runat="server" AutoGenerateColumns="false" CssClass="rgrid table table-bordered table-hover"
        HeaderStyle-CssClass="rgrid-header">
        <Columns>
            <asp:BoundField DataField="idReservacion" HeaderText="# reservación"
                HeaderStyle-CssClass="text-center" ItemStyle-HorizontalAlign="Center" />

            <asp:BoundField DataField="cliente" HeaderText="Cliente"
                HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" />

            <asp:BoundField DataField="hotel" HeaderText="Hotel"
                HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" />

            <asp:BoundField DataField="fechaEntrada" HeaderText="Fecha entrada" DataFormatString="{0:d}"
                HeaderStyle-CssClass="text-center" ItemStyle-HorizontalAlign="Center" />

            <asp:BoundField DataField="fechaSalida" HeaderText="Fecha salida" DataFormatString="{0:d}"
                HeaderStyle-CssClass="text-center" ItemStyle-HorizontalAlign="Center" />

            <asp:BoundField DataField="costoTotal" HeaderText="Costo" DataFormatString="{0:C2}"
                HeaderStyle-CssClass="text-end" ItemStyle-HorizontalAlign="Right" />

            <asp:TemplateField HeaderText="Estado" HeaderStyle-CssClass="text-center" ItemStyle-HorizontalAlign="Center">
                <ItemTemplate>
                    <%#  
                          EvaluarEstado(
                               Eval("estado").ToString(),
                               Convert.ToDateTime(Eval("fechaEntrada")),
                               Convert.ToDateTime(Eval("fechaSalida"))
                               )
                    %>
                </ItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                <ItemTemplate>
                    <a href="Detalle.aspx?idReservacion=<%# (Eval("idReservacion"))%>">Consultar</a>
                </ItemTemplate>
            </asp:TemplateField>

        </Columns>
    </asp:GridView>

</asp:Content>
