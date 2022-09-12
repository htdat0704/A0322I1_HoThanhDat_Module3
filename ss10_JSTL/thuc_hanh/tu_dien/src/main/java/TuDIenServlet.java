import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@WebServlet(name = "TuDIenServlet", urlPatterns = "/tudien")
public class TuDIenServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String txtSearch = request.getParameter("search").toLowerCase();

        Map<String,String> mapDic = new HashMap<>();
        mapDic.put("search","Tìm kiếm");
        mapDic.put("run","Chạy");
        mapDic.put("prom","vũ hội");
        mapDic.put("pig","heo");
        mapDic.put("vendor","người buôn hàng");

        String result = mapDic.get(txtSearch);

        if(result == null){

            request.setAttribute("result","Not Found");
        }else {
            request.setAttribute("result",result);

        }

        request.getRequestDispatcher("index.jsp").forward(request,response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
