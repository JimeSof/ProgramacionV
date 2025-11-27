<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="ProyectoGrupo6.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link rel="stylesheet" href="../Content/Estilos.css" />
    <link rel="stylesheet" media="screen" href="https://fontlibrary.org//face/andika" type="text/css"/>
    <title></title>
</head>
<body class="login-page">

    <!-- Main Content -->
    <div class="container-fluid">
        <div class="row main-content bg-success text-center">
            <div class="col-md-4 text-center company__info">
                <span class="company__logo">
                    <img src="Imagen/LogoHotel.png" />
                </span>
            </div>
            <div class="col-md-8 col-xs-12 col-sm-12 login_form ">
                <div class="container-fluid">
                    <div class="row">
                        <div class="user-icon">
                            <i class="fa-solid fa-circle-user"></i>
                        </div>
                    </div>
                    <div class="row">
                        <form control="" class="form-group" runat="server">
                            <div class="row">
                                <asp:Label ID="lblEmail" runat="server" Text="Email"></asp:Label>
                                <asp:TextBox ID="txtEmail" runat="server" CssClass="form_input" placeholder="xxxx@sitio.com"></asp:TextBox>
                                <!--Validaciones-->
                                <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ErrorMessage="Este campo es requerido" ForeColor="Red" ControlToValidate="txtEmail"></asp:RequiredFieldValidator><br />
                                <asp:RegularExpressionValidator ID="revEmail" runat="server" ErrorMessage="El formato del email no es valido"
                                    ValidationExpression="[^@\s]+@[^@\s]+\.[^@\s]+$" ControlToValidate="txtEmail" ForeColor="Red"></asp:RegularExpressionValidator>
                            </div>
                            <div class="row">

                                <asp:Label ID="lblClave" runat="server" Text="Clave"></asp:Label>
                                <asp:TextBox ID="txtClave" runat="server" CssClass="form_input"></asp:TextBox>
                                <!--Validaciones-->
                                <asp:RequiredFieldValidator ID="rfvClave" runat="server" ErrorMessage="Este campo es requerido" ControlToValidate="txtClave" ForeColor="Red"></asp:RequiredFieldValidator>
                            </div>
                            <!--Validaciones-->
                            <asp:Label ID="lblMensaje" runat="server" Text="" ForeColor="Red" Font-Bold="true" Visible="false"></asp:Label>
                            
                            <div class="row">
                                <asp:Button ID="btnValidar" runat="server" Text="Iniciar Sesión" OnClick="btnValidar_Click" CssClass="btn_log" />
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
