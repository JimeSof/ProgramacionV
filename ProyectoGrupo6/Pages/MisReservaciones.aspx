<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" 
    CodeBehind="MisReservaciones.aspx.cs" Inherits="ProyectoGrupo6.Pages.MisReservaciones" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <style>
        /* === Estilo exacto tipo mockup === */

        .titulo-pagina {
            font-size: 28px;
            font-weight: bold;
            margin-bottom: 10px;
        }

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

        .link-nueva {
            font-size: 18px;
            font-weight: bold;
        }

        .col-consultar a {
            color: #0047b3;
            font-weight: bold;
            text-decoration: underline;
        }
    </style>


    <!-- TÍTULO -->
    <div class="titulo-pagina">Mis reservaciones</div>

    <!-- BOTÓN NUEVA RESERVACIÓN -->
    <div style="margin-bottom:15px;">
        <asp:HyperLink ID="lnkNueva" runat="server"
            CssClass="link-nueva"
            NavigateUrl="~/Pages/CrearReservacion.aspx">
            Nueva reservación
        </asp:HyperLink>
    </div>

    <!-- TABLA -->
    <asp:GridView ID="grdReservaciones" runat="server"
        AutoGenerateColumns="False"
        CssClass="tabla-reservas">

        <Columns>

            <asp:BoundField DataField="IdReservacion" HeaderText="# reservación" />

            <asp:BoundField DataField="Hotel" HeaderText="Hotel" />

            <asp:BoundField DataField="FechaEntrada"
                            HeaderText="Fecha entrada"
                            DataFormatString="{0:dd/MM/yyyy}" />

            <asp:BoundField DataField="FechaSalida"
                            HeaderText="Fecha salida"
                            DataFormatString="{0:dd/MM/yyyy}" />

            <asp:BoundField DataField="CostoTotal"
                            HeaderText="Costo"
                            DataFormatString="{0:N2}" />

            <asp:TemplateField HeaderText="Estado">
                <ItemTemplate>
                    <%# Eval("EstadoTexto") %>
                </ItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText=" ">
                <ItemTemplate>
                    <span class="col-consultar">
                        <a href='Detalle.aspx?idReservacion=<%# Eval("IdReservacion") %>'>
                            Consultar
                        </a>
                    </span>
                </ItemTemplate>
            </asp:TemplateField>

        </Columns>

    </asp:GridView>

</asp:Content>
