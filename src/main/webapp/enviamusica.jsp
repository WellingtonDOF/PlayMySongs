
<%@ page import="java.io.File" %>
<%@ page import="unoeste.fipp.playmysongs.security.User" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <title>Play My Songs!</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="assets/css/estilo.css">
    <script src="./assets/script/scriptjs.js"></script>
</head>
<body>

<%
    User user = (User) session.getAttribute("user");

    //fazer essa confirmação porque se o usuario digitar na barra de pesquisa /enviamusica.jsp e não existir usuario conectado vai dar erro
    if(user!=null)
    {
        if(user.isAccess())
        {
            String login = user.getName().substring(0, user.getName().indexOf('@'));
%>
            <div class="topnav">
                <a class="active" href="index.jsp">HOME</a>
                <div class="login-container">
                    <a href="./logout-servlet">Logout</a>
                </div>

                <div class="login-container">
                    <p style="margin-left: -50%; "><b><%=login%></b></p>
                </div>
            </div>

            <div class="enviarM">
                <form method="post" action="./upload-servlet" onsubmit="validarCaracter()" enctype="multipart/form-data">
                    <label for="estilos">Escolha um estilo:</label>
                    <select name="estilos" id="estilos">
                        <option value="pop">POP</option>
                        <option value="rock">Rock</option>
                        <option value="eletronica">Eletrônica</option>
                        <option value="sertanejo">Sertanejo</option>
                        <option value="funk">Funk</option>
                        <option value="classica">Clássica</option>
                        <option value="gospel">Gospel</option>
                        <option value="mpb">MPB</option>
                    </select>
                    <br><br>

                    <input type="text" id="music" name="nomeM" placeholder="Nome da Música">
                    <input type="text" id="singer" name="cantorM" placeholder="Cantor">
                    <input type="file" name="arq" id="arq">

                    <input type="submit" value="Submit">
                </form>
            </div>
   <%
        }
    }
    else//se o usuario não existir, ou seja nao tiver login nenhum, redireciona pra página inicial
        response.sendRedirect("index.jsp");
   %>

</body>
</html>