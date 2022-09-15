package controller;

import bean.Product;
import services.ProductService;
import services.impl.ProductServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "ProductController", urlPatterns = "/product")
public class ProductController extends HttpServlet {

    private static ProductService productService = new ProductServiceImpl();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if(action == null){
            doGet(request,response);
        }
        switch (action){
            case "create":
                createNewProduct(request, response);
                break;
            case "update":
                updateProduct(request, response);
                break;
        }
    }

    private void updateProduct(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String error = null;
        String id = request.getParameter("id");
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String producer = request.getParameter("producer");
        double price = Double.parseDouble(request.getParameter("price"));

        try {
            productService.update(new Product(id,name,price,description,producer));
        } catch (Exception e) {
            error = e.getMessage();
        }
        if(error == null){
            response.sendRedirect("/product");
        }else{
            request.setAttribute("error",error);
            request.getRequestDispatcher("WEB-INF/views/products/update.jsp").forward(request,response);
        }
        ;
    }

    private void createNewProduct(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String error = null;
        String id = request.getParameter("id");
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String producer = request.getParameter("producer");
        double price = Double.parseDouble(request.getParameter("price"));

        try {
            productService.create(new Product(id,name,price,description,producer));
        } catch (Exception e) {
            error = e.getMessage();
        }

        if(error == null){
            response.sendRedirect("/product");
        }else{
            request.setAttribute("error",error);
            request.getRequestDispatcher("WEB-INF/views/products/create.jsp").forward(request,response);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        String idProduct = request.getParameter("id");
        if(action == null){
            action = "";
        }
        if(idProduct == null){
            idProduct = "";
        }
        switch (action){
            case "create":
                request.getRequestDispatcher("WEB-INF/views/products/create.jsp").forward(request,response);
                break;
            case "update":
                try {
                    request.setAttribute("product",productService.findById(idProduct));
                } catch (Exception e) {
                    e.printStackTrace();
                }
                request.getRequestDispatcher("WEB-INF/views/products/update.jsp").forward(request,response);
                break;
            case "delete":
                try {
                    productService.delete(idProduct);
                } catch (Exception e) {
                    e.printStackTrace();
                }
                response.sendRedirect("/product");
                break;
            case "detail":
                try {
                    request.setAttribute("product",productService.findById(idProduct));
                } catch (Exception e) {
                    e.printStackTrace();
                }
                request.getRequestDispatcher("WEB-INF/views/products/detail.jsp").forward(request,response);
                break;
            case "findName":
                String error = "";
                String txtSearch = request.getParameter("txtSearch");
                try {
                    request.setAttribute("productList",productService.findByName(txtSearch));
                } catch (Exception e) {
                    error= e.getMessage();
                }
                request.setAttribute("error",error);
                request.getRequestDispatcher("WEB-INF/views/products/list.jsp").forward(request,response);
                break;
            default:
                request.setAttribute("productList",productService.findAll());
                request.getRequestDispatcher("WEB-INF/views/products/list.jsp").forward(request,response);
        }
    }
}
