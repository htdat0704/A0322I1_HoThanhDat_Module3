import java.io.IOException;

@javax.servlet.annotation.WebServlet(name = "ServletLogin", urlPatterns = "/form-login")
public class ServletLogin extends javax.servlet.http.HttpServlet {
    protected void doPost(javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response) throws javax.servlet.ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        if(username.equals("admin") && password.equals("admin")){
            request.setAttribute("username",username);
            request.getRequestDispatcher("login.jsp").forward(request,response);
        }else {
            request.setAttribute("error","Username or Password not Right !!!");
            request.getRequestDispatcher("index.jsp").forward(request,response);
        }
    }

    protected void doGet(javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response) throws javax.servlet.ServletException, IOException {

    }
}
