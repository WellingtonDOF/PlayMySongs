package unoeste.fipp.playmysongs;

import java.io.*;

import unoeste.fipp.playmysongs.security.User;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

@WebServlet(name = "loginServlet", value = "/login-servlet")
public class LoginServlet extends HttpServlet {
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {

        String login, pswd;

        login = request.getParameter("email");

        if (isValidMail(login))
        {
            pswd = request.getParameter("psw");
            if (isValidPass(login, pswd))
            {
                User user = new User(login);
                HttpSession session = request.getSession();
                session.setMaxInactiveInterval(30); //tempo para expirar a sessão
                session.setAttribute("user", user);
                user.setAccess(true);
                response.sendRedirect("index.jsp"); // entra no sistema
            }
            else
                // Redirecionar de volta para a página de login com um parâmetro de consulta indicando o erro
                response.sendRedirect("index.jsp?error=invalid_credentials");
        }
        else
            // Redirecionar de volta para a página de login com um parâmetro de consulta indicando o erro
            response.sendRedirect("index.jsp?error=invalid_email");
    }
    private boolean isValidMail (String email)
    {
        return email != null && email.matches("[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}");
    }
    private boolean isValidPass (String email, String pswd)
    {
        return pswd !=null && pswd.equals(email.substring(0, email.indexOf('@')));
    }
}


