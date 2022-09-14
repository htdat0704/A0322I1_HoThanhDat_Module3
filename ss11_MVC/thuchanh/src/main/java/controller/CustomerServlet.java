package controller;

import model.Customer;
import services.CustomerServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@javax.servlet.annotation.WebServlet(name = "CustomerServlet", urlPatterns = "/customer")
public class CustomerServlet extends javax.servlet.http.HttpServlet {

    private static CustomerServiceImpl customerServlet = new CustomerServiceImpl();

    protected void doPost(javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response) throws javax.servlet.ServletException, IOException {
        String action = request.getParameter("action");
        String findId = request.getParameter("id");
        int idInt;
        if(action == null){
            doGet(request,response);
            return;
        }
        if(findId == null){
            idInt = -1;
        }else {
            idInt = Integer.parseInt(findId);
        }

        switch (action){
            case "create":
                createCustomer(request, response, customerServlet);
                break;
            case "edit":
                createCustomer(request, response, customerServlet);
                break;
        }
    }

    protected void doGet(javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response) throws javax.servlet.ServletException, IOException {
        String action = request.getParameter("action");
        String findId = request.getParameter("id");
        int idInt;
        if(action == null){
            action = "";
        }
        if(findId == null){
            idInt = -1;
        }else {
            idInt = Integer.parseInt(findId);
        }
        switch (action){
            case "create":
                response.sendRedirect("view/customer/create.jsp");
                break;
            case "edit":
                request.setAttribute("customer",customerServlet.findById(idInt));
                request.getRequestDispatcher("view/customer/edit.jsp").forward(request,response);
                break;
            case "delete":
                customerServlet.remove(idInt);
                showList(request, response, customerServlet);
                break;
            case "detail":
                request.setAttribute("customer",customerServlet.findById(idInt));
                request.getRequestDispatcher("view/customer/detail.jsp").forward(request,response);
                break;
            default:
                showList(request, response, customerServlet);
                break;
        }

    }

    private void showList(HttpServletRequest request, HttpServletResponse response, CustomerServiceImpl customerService) throws ServletException, IOException {
        request.setAttribute("listCustomers", customerService.findAll());
        request.getRequestDispatcher("view/customer/list.jsp").forward(request, response);
    }

    private void createCustomer(HttpServletRequest request, HttpServletResponse response, CustomerServiceImpl customerService) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        String price = request.getParameter("email");
        String address = request.getParameter("address");

        customerService.save(new Customer(id,name,price,address));

        request.setAttribute("listCustomers", customerService.findAll());
        request.getRequestDispatcher("view/customer/list.jsp").forward(request, response);
    }
}
