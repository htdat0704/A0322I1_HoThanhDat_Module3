import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "CalServlet", urlPatterns = "/calculator")
public class CalServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String operator = request.getParameter("operator");
        double first = Double.parseDouble(request.getParameter("first"));
        double second = Double.parseDouble(request.getParameter("second"));
        double result = 0;

        switch (operator){
            case "+":
                result= first+second;
                break;
            case "-":
                result= first-second;
                break;
            case "*":
                result= first*second;
                break;
            case "/":
                result= first/second;
                break;
        }

        request.setAttribute("result","Result is "+result);
        request.getRequestDispatcher("result.jsp").forward(request,response);
    }
}
