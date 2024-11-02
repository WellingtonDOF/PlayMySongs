<%@ page import="java.io.File" %>
<%@ page import=" unoeste.fipp.playmysongs.security.User"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>


<!DOCTYPE html>
<html>
<head>
    <title>Play My Songs!</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="assets/css/estilo.css">
</head>
<body>

<!--<h1>Login opcional (caso queira enviar músicas)</h1>-->

<%
    User user = (User) session.getAttribute("user");

    // se existir um usuario cadastro
    if(session.getAttribute("user")!=null)
    {
        //se o acesso dele estiver ativo
        if(user.isAccess())
        {
            //colocar essa linha abaixo aqui dentro, porque pode ser que não exista o usuario aí vai pegar null e vai dar b.o
            String login = user.getName().substring(0, user.getName().indexOf('@'));

%>
            <div class="topnav">
                <a class="active" href="index.jsp">HOME</a>
                <div class="login-container">
                    <a href="./logout-servlet">Logout</a>
                </div>
                <div class="login-container">
                    <form method="post" action="enviamusica.jsp">
                        <button type="submit">Enviar Música</button>
                    </form>
                </div>
                <div class="login-container">
                    <p style="margin-left: -50%; "><b><%=login%></b></p>
                </div>
            </div>
        <%
        }
    }
    else
    {
%>
        <div class="topnav">
            <a class="active" href="index.jsp">HOME</a>
            <div class="login-container">
                <form method="post" action="./login-servlet">
                    <input type="email" placeholder="Email" name="email">
                    <input type="password" placeholder="Password" name="psw">
                    <button type="submit">Login</button>
                </form>
            </div>
        </div>
<%
    }
%>

<div id="error-message">
    <%
        String error = request.getParameter("error");
        if (error != null)
        {
            if (error.equals("invalid_credentials"))
            {
    %>
                <p style="text-align: center">A senha fornecida esta incorreta. Por favor, tente novamente.</p>
    <%
            }
            else
                if (error.equals("invalid_email"))
                {
    %>
                    <p style="text-align: center">O endereço de e-mail fornecido é inválido. Por favor, forneça um endereço de e-mail válido.</p>
    <%
                }
        }
    %>
</div>

<!--<h1>link de acesso para enviar músicas. "Desabilitado" só habilitar depois de logar</h1>
<a href="enviamusica.jsp">Envie uma música</a>-->
<!--<h1>Form para busca</h1>-->

<div style="margin-top: 15%">
    <form class="example" action="index.jsp" style="margin:auto;max-width:300px">
        <input type="text" placeholder="Search Music.." value="" name="search">
        <button type="submit"><i class="fa fa-search"></i></button>
    </form>
</div>
<!--Código JSP paa buscar arquivos</span>-->
<!--/<h1>Tabela de resultados (vazia no primeiro acesso)</h1>-->

<div style="margin: 0 auto; width: 35%;">
    <table>
        <%
            String searchM=request.getParameter("search");

            File pastaweb=new File(request.getServletContext().getRealPath("")+"/music");

            if(searchM!=null)
            {
                for (File file : pastaweb.listFiles())
                {   if(file.isFile())  // se é um arquivo e não uma pasta
                        if(file.getName().contains(searchM.toLowerCase()) &&  file.getName().toLowerCase().endsWith(".mp3"))
                        {
                            //Cria uma linha da tabela se encontrou um nome parecido e se o final do arquivo for do tipo .mp3 (extensão)
        %>
                            <tr>
                                <td style="border-radius: 10px 100px / 120px;">
                                    <div style="text-align: center">
                                        <span style="display: block; margin-bottom: 10px;" ><b><%=file.getName()%></b></span>
                                        <audio id="audio1"  controls>
                                            <source src="<%="music/"+file.getName()%>" type="audio/mpeg">
                                        </audio>
                                    </div>
                                </td>
                            </tr>
        <%
                        }
                }
            }
        %>
    </table>
</div>


<script>
    // Função para limpar a mensagem de erro após um determinado período de tempo
    function clearErrorMessage() {
        var errorMessage = document.getElementById('error-message');
        if (errorMessage) {
            // Define um tempo limite para remover a mensagem
            setTimeout(function() {
                errorMessage.style.display = 'none'; // Oculta a mensagem de erro
            }, 5000); // Tempo em milissegundos (5 segundos)
        }
    }
    // Chama a função para limpar a mensagem de erro após o carregamento da página
    window.onload = clearErrorMessage;
</script>

</body>
</html>