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
import java.sql.SQLException;
import java.text.SimpleDateFormat;

@WebServlet(name = "ProductServlet", urlPatterns = "/product")
public class ProductServlet extends HttpServlet {

    private static ProductService productService = new ProductServiceImpl();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if(action == null){
            action = "";
        }
        String idAsString = request.getParameter("idProduct");
        int idProduct = -1;
        if(idAsString != null){
            idProduct = Integer.parseInt(idAsString);
        }
        switch (action){
            case "create":
                int idCategory = Integer.parseInt(request.getParameter("category"));
                String name = request.getParameter("name");
                double price = Double.parseDouble(request.getParameter("price"));
                int quantity = Integer.parseInt(request.getParameter("quantity"));
                String color = request.getParameter("color");
                String description = request.getParameter("description");
                try {
                    productService.create(new Product(name,price,quantity,color,description,idCategory));
                } catch (SQLException throwables) {
                    throwables.printStackTrace();
                } catch (ClassNotFoundException e) {
                    e.printStackTrace();
                }
                response.sendRedirect("/product?success=create");
                break;
            case "update":
                int idCategory1 = Integer.parseInt(request.getParameter("category"));
                String name1 = request.getParameter("name");
                double price1 = Double.parseDouble(request.getParameter("price"));
                int quantity1 = Integer.parseInt(request.getParameter("quantity"));
                String color1 = request.getParameter("color");
                String description1 = request.getParameter("description");
                try {
                    productService.update(new Product(idProduct,name1,price1,quantity1,color1,description1,idCategory1));
                } catch (SQLException throwables) {
                    throwables.printStackTrace();
                } catch (ClassNotFoundException e) {
                    e.printStackTrace();
                }
                response.sendRedirect("/product");
                break;
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        String success = request.getParameter("success");
        String pageAsString = request.getParameter("page");
        int page = 1;
        int resultPerPage = 10;
        if(pageAsString == null){
            page = 1;
        }else {
            page = Integer.parseInt(pageAsString);
        }
        if(success == null){
            success = "";
        }else {
            request.setAttribute("success",success);
        }
        if(action == null){
            action = "";
        }
        String idAsString = request.getParameter("idProduct");
        int idProduct = -1;
        if(idAsString != null){
            idProduct = Integer.parseInt(idAsString);
        }
        try {
            request.setAttribute("categories",productService.findAllCategory());
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        switch (action){
            case "create":
                request.getRequestDispatcher("WEB-INF/views/product/create.jsp").forward(request,response);
                break;
            case "update":
                try {
                    request.setAttribute("product",productService.findById(idProduct));
                } catch (SQLException throwables) {
                    throwables.printStackTrace();
                } catch (ClassNotFoundException e) {
                    e.printStackTrace();
                }
                request.getRequestDispatcher("WEB-INF/views/product/update.jsp").forward(request,response);
                break;
            case "search":
                String nameSearch = request.getParameter("name");
                String priceAsString = request.getParameter("price");
                double price =-1;
                if(priceAsString != ""){
                    price = Double.parseDouble(priceAsString);
                }
                String error = null;
                try {
                    if(price > -1 && nameSearch != null){
                        request.setAttribute("products",productService.findByNameAndPrice(nameSearch,price));
                    } else if(nameSearch != null){
                        request.setAttribute("products",productService.findByName(nameSearch));
                    } else if(price > 1) {
                        request.setAttribute("products",productService.findByPrice(price));
                    }
//                    request.setAttribute("error",price);
//                    request.setAttribute("products",productService.findByName(nameSearch));
                } catch (Exception e){
                    error = e.getMessage();
                    request.setAttribute("error",error);
                }
                request.getRequestDispatcher("WEB-INF/views/product/list.jsp").forward(request,response);
                break;
            case "delete":
                try {
                    productService.delete(idProduct);
                } catch (SQLException throwables) {
                    throwables.printStackTrace();
                } catch (ClassNotFoundException e) {
                    e.printStackTrace();
                }
                response.sendRedirect("/product?success=delete");
                break;
            default:
                try {
                    request.setAttribute("totalPage", productService.findTotalPage(resultPerPage));
                    request.setAttribute("products", productService.findAllProductPagination(page, resultPerPage));
//                    request.setAttribute("products",productService.findAll());
                } catch (SQLException throwables) {
                    throwables.printStackTrace();
                } catch (ClassNotFoundException e) {
                    e.printStackTrace();
                }
                request.getRequestDispatcher("WEB-INF/views/product/list.jsp").forward(request,response);
        }
    }
}
