<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="ProyectoGrupo6.Pages.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Hotel Solar</title>
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="../Content/Estilos.css" />
</head>
<body>

    <div class="background">
        <div class="shape"></div>
        <div class="shape"></div>
    </div>

    <form runat="server">
        
        <h2>Inicio de Sesión</h2>
        <br />
        <br />

        <div class="group">
            <asp:Label ID="lblEmail" runat="server" Text="Email"></asp:Label>
            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control"></asp:TextBox>
        </div>

        <div class="group">
            <asp:Label ID="lblClave" runat="server" Text="Clave"></asp:Label>
            <asp:TextBox ID="txtClave" runat="server" CssClass="input"></asp:TextBox>
        </div>

        <br />
        <br />
        <asp:Button ID="btnValidar" runat="server" Text="Acceder" OnClick="btnValidar_Click"  CssClass="btn1" BackColor="White" BorderColor="White" ForeColor="Black" />

    </form>

</body>
</html>
