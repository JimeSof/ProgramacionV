<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="ProyectoGrupo6.Pages.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Hotel Solar</title>
    <link rel="stylesheet" href="../Content/Estilos.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" integrity="sha512-..." crossorigin="anonymous" referrerpolicy="no-referrer" />

</head>
<body>

    <section class="imagen overlay" style="background-image: url('/Imagen/hotel.jpg');">


        <div class="contenedor">

            <div>
                <img src="../Imagen/Banner.png" />
            </div>


            <form runat="server">


                <span class="icon-container">
                    <i class="fa-solid fa-circle-user"></i>
                </span>
                <br />
                <br />

                <div class="group">
                    <asp:Label ID="lblEmail" runat="server" Text="Email" ></asp:Label>

                    <div class="campo-icon">
                        <span class="icon">
                            <i class="fa-solid fa-user"></i>
                        </span>
                        <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control"></asp:TextBox>

                    </div>

                </div>

                <div class="group">
                    <asp:Label ID="lblClave" runat="server" Text="Clave"></asp:Label>
                    <div class="campo-icon">
                        <span class="icon">
                            <i class="fa-duotone fa-solid fa-lock"></i>
                        </span>
                        <asp:TextBox ID="txtClave" runat="server" CssClass="input"></asp:TextBox>
                    </div>
                </div>
                <br />
                <br />
                <asp:Button ID="btnValidar" runat="server" Text="Iniciar Sesión" OnClick="btnValidar_Click" CssClass="btn1" BackColor="White" BorderColor="White" ForeColor="Black" />
            </form>


        </div>
    </section>

</body>
</html>
