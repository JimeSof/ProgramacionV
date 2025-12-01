<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="MisReservaciones.aspx.cs" Inherits="ProyectoGrupo6.Pages.MisReservaciones" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        /* === Estilo exacto tipo mockup === */

        .tabla-reservas {
            width: 100%;
            border-collapse: collapse;
            font-size: 16px;
        }

            .tabla-reservas th {
                background-color: #e6e6e6 !important;
                padding: 10px;
                text-align: left;
                border: 1px solid #a6a6a6;
                font-weight: bold;
            }

            .tabla-reservas td {
                padding: 10px;
                border: 1px solid #d9d9d9;
            }

        .col-consultar a {
            color: #0047b3;
            font-weight: bold;
            text-decoration: underline;
        }
    </style>


    <!-- TÍTULO -->
    <div class="titulo">
        <div class="izquierda">
            <h1>Mis Reservaciones</h1>
        </div>
        <div class="derecha">
            <asp:Label ID="lblUsuario" runat="server" Text="Usuario" Font-Bold="True"></asp:Label>
        </div>
    </div>

    <!-- BOTÓN NUEVA RESERVACIÓN -->
    <div>
        <a href="CrearReservacion.aspx" class="btn btn_cr" role="button">Nuevo reservación</a>
    </div>
    <br />
    <!-- TABLA -->
    <asp:GridView ID="grdReservaciones" runat="server" AutoGenerateColumns="False"
        CssClass="rgrid table table-bordered table-hover" HeaderStyle-CssClass="rgrid-header">

        <Columns>

            <asp:BoundField DataField="IdReservacion" HeaderText="# reservación"
                 HeaderStyle-CssClass="text-center" ItemStyle-HorizontalAlign="Center"/>

            <asp:BoundField DataField="Hotel" HeaderText="Hotel" 
                HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" />

            <asp:BoundField DataField="FechaEntrada"
                HeaderText="Fecha entrada"
                DataFormatString="{0:dd/MM/yyyy}" 
                 HeaderStyle-CssClass="text-center" ItemStyle-HorizontalAlign="Center" />

            <asp:BoundField DataField="FechaSalida"
                HeaderText="Fecha salida"
                DataFormatString="{0:dd/MM/yyyy}" 
                 HeaderStyle-CssClass="text-center" ItemStyle-HorizontalAlign="Center" />

            <asp:BoundField DataField="CostoTotal"
                HeaderText="Costo"
                DataFormatString="${0:N2}" 
                HeaderStyle-CssClass="text-end" ItemStyle-HorizontalAlign="Right" />

            <asp:TemplateField HeaderText="Estado" HeaderStyle-CssClass="text-center" ItemStyle-HorizontalAlign="Center">
                <ItemTemplate>
                    <%# Eval("EstadoTexto") %>
                </ItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText=" " ItemStyle-HorizontalAlign="Center">
                <ItemTemplate>
                    <span class="col-consultar">
                        <a href='Detalle.aspx?idReservacion=<%# Eval("IdReservacion") %>'>Consultar
                        </a>
                    </span>
                </ItemTemplate>
            </asp:TemplateField>

        </Columns>

    </asp:GridView>

</asp:Content>
