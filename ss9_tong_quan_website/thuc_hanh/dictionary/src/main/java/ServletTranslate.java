import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@WebServlet(name = "ServletTranslate", urlPatterns = "/translate")
public class ServletTranslate extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String txtSearch = request.getParameter("txtSearch").toLowerCase();

        Map<String,String> DictionaryMap = new HashMap<>();
        DictionaryMap.put("search","Tim kiem");
        DictionaryMap.put("add","them");
        DictionaryMap.put("love","tinh yeu");
        DictionaryMap.put("pool","ho boi");
        DictionaryMap.put("nope","khong");
        DictionaryMap.put("code","ma");
        DictionaryMap.put("hello", "xin chao");
        DictionaryMap.put("how", "The nao");
        DictionaryMap.put("book", "quyen vo");
        DictionaryMap.put("computer", "may tinh");

        String result = DictionaryMap.get(txtSearch);

        if(result == null){
            String error = "Not Found";
            request.setAttribute("error",error);
            request.setAttribute("result","");
        }else {
            request.setAttribute("error","");
            request.setAttribute("result",result);
            request.setAttribute("txtSearch",txtSearch);

        }
        request.getRequestDispatcher("index.jsp").forward(request,response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
