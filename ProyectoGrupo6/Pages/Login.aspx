<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="ProyectoGrupo6.Pages.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

    <link rel="stylesheet" href="../Content/Estilos.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" integrity="sha512-..." crossorigin="anonymous" referrerpolicy="no-referrer" />
    <link rel="preconnect" href="https://fonts.gstatic.com" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" />
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500;600&display=swap" rel="stylesheet" />


    <title>Hotel Solar</title>

</head>
<body>
    <!--Esta seccion coloca la imagen de fondo-->
    <section class="imagen overlay" style="background-image: url('/Imagen/hotel.jpg');">

        <!--Este div es el contenedor de dos columnas para poner el logo y el formuladio login-->
        <div class="contenedor">

            <div>
                <!--Esta es la primera columna del logo-->
                <img src="../Imagen/Logo.png" />
            </div>


            <!--Formulario para realizar el login-->
            <form runat="server">

                <div class="login-container">
                    <!--Icono-->
                    <div class="user-icon">
                        <i class="fa-solid fa-circle-user"></i>
                    </div>

                    <div class="group">
                        <asp:Label ID="lblEmail" runat="server" Text="Email"></asp:Label>

                        <div class="campo-icon">
                            <!--Icono del campo email-->
                            <span class="icon"><i class="fa-solid fa-user"></i></span>
                            <!--Input del email-->
                            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-input" placeholder="xxxx@sitio.com"></asp:TextBox>

                        </div>
                    </div>

                    <div class="group">
                        <asp:Label ID="lblClave" runat="server" Text="Clave"></asp:Label>

                        <div class="campo-icon">
                            <!--Icono del campo clave-->
                            <span class="icon"><i class="fa-duotone fa-solid fa-lock"></i></span>
                            <!--Input de la clave-->
                            <asp:TextBox ID="txtClave" runat="server" CssClass="form-input"></asp:TextBox>
                        </div>
                    </div>

                    <!--Boton de validar los datos en la base y que permita el logueo-->
                    <asp:Button ID="btnValidar" runat="server" Text="Iniciar Sesión" OnClick="btnValidar_Click" CssClass="btn1" BackColor="White" BorderColor="White" ForeColor="Black" />

                   
                </div>

            </form>
        </div>


    </section>

</body>
</html>
