<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="GestionarReservaciones.aspx.cs" Inherits="ProyectoGrupo6.Pages.GestionarReservaciones" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="titulo">
        <div class="izquierda">
            <h1 class="">Gestionar Reservaciones</h1>
        </div>
        <div class="derecha">
            <asp:Label ID="lblUsuario" runat="server" Text="Usuario" Font-Bold="True"></asp:Label>
        </div>
    </div>

    <!--El filtro de busqueda-->
    <div id="flitro" class="row">
        <div class="col-3">
            <asp:Label ID="lbCliente" runat="server" Text="Cliente"></asp:Label>
            <asp:DropDownList ID="ddlCliente" runat="server" CssClass="form-select"></asp:DropDownList>
        </div>
        <div class="col-3">
            <asp:Label ID="lbFechaEntrada" runat="server" Text="Fecha Entrada"></asp:Label>
            <asp:TextBox ID="txtFechaEntrada" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
            <!--Validaciones-->
            <asp:RequiredFieldValidator ID="rfvFechaEntrada" runat="server" ErrorMessage="Este campo es requerido" ForeColor="Red" ControlToValidate="txtFechaEntrada" Display="Dynamic"></asp:RequiredFieldValidator>

        </div>
        <div class="col-3">
            <asp:Label ID="lbFechaSalida" runat="server" Text="Fecha Salida"></asp:Label>
            <asp:TextBox ID="txtFechaSalida" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
            <!--Validaciones-->
            <asp:RequiredFieldValidator ID="rfvFechaSalida" runat="server" ErrorMessage="Este campo es requerido" ForeColor="Red" ControlToValidate="txtFechaSalida" Display="Dynamic"></asp:RequiredFieldValidator>
        </div>
        <div class="col-3">
            <br />
            <asp:Button ID="btnFiltrar" runat="server" Text="Filtrar" OnClick="btnFiltrar_Click" CssClass="btn btn-outline-dark" />
        </div>

        <!--Validacion de los campos de fecha-->
        <asp:CustomValidator ID="cuvFechas" runat="server" ErrorMessage="Fechas invalidas: Fecha de salida debe ser mayor a la fecha de entrada"
            OnServerValidate="cuvFechas_ServerValidate" ForeColor="Red" Display="Dynamic"></asp:CustomValidator>
    </div>

    <div>
        <a href="CrearReservacion.aspx" class="btn btn_cr" role="button">Nuevo reservación</a>
    </div>

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

            <asp:BoundField DataField="costoTotal" HeaderText="Costo" DataFormatString="${0:N2}"
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
