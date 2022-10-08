package controller;

import bean.Customer;
import services.CustomerService;
import services.impl.CustomerServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;

@WebServlet(name = "CustomerServlet", urlPatterns = "/customers" )
public class CustomerServlet extends HttpServlet {

    private CustomerService service = new CustomerServiceImpl();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if(action == null) {
            action = "";
        }
        switch (action){
            case "create":
                addNewCustomer(request, response);
                break;
            case "update":
                updateCustomer(request, response);
                break;
            default:
                response.sendRedirect("/customers");
        }
    }

    private void updateCustomer(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        int idType = Integer.parseInt(request.getParameter("type"));
        int idCustomer = Integer.parseInt(request.getParameter("idCus"));
        String name = request.getParameter("name");
        int gender = Integer.parseInt(request.getParameter("gender"));
        String birthdateAsString = request.getParameter("birth");
        String idCard = request.getParameter("idCard");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String address = request.getParameter("address");
        String birthday = request.getParameter("birth");
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        String error = null;
        if(birthday.equals("")){
            try {
                service.update(new Customer(idCustomer,name, service.findById(idCustomer).getBirthday(), gender != 0, idCard, phone, email, address,idType ));
            } catch (Exception throwables) {
                error = throwables.getMessage();
            }
        }else{
            java.util.Date dateRelease = null;
            try {
                dateRelease = format.parse(birthdateAsString);
            } catch (ParseException e) {
                error = "Date Release sai format";
            }
            try {
                service.update(new Customer(idCustomer, name, dateRelease, gender != 0, idCard, phone, email, address,idType ));
            } catch (SQLException throwables) {
                throwables.printStackTrace();
            } catch (ClassNotFoundException e) {
                e.printStackTrace();
            }
        }
        if (error == null) {
            response.sendRedirect("/customers");
        } else {
            request.setAttribute("error", error);
            request.getRequestDispatcher("WEB-INF/views/customer/update.jsp").forward(request,response);
        }
    }


    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        String idString = request.getParameter("idCustomer");
        int id;
        if(action == null) {
            action = "";
        }
        if(idString == null) {
            id = -1;
        }else {
            id = Integer.parseInt(idString);
        }
        try {
            request.setAttribute("customerType",service.customerType());
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        switch (action){
            case "create":
                getCreateCustomer(request, response);
                break;
            case "update":
                getUpdateCustomer(request, response, id);
                break;
            case "search":
                findByName(request, response);
            default:
                showAllCustomer(request, response);
        }


    }

    private void findByName(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        if(name == null){
            name = "";
        }
        try {
            request.setAttribute("customers",service.searchCustomer(name));
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        request.getRequestDispatcher("WEB-INF/views/customer/list.jsp").forward(request,response);
    }

    private void getCreateCustomer(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("WEB-INF/views/customer/create.jsp").forward(request,response);
    }

    private void showAllCustomer(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            request.setAttribute("customers",service.findAll());
        } catch (SQLException throwables) {
            System.out.println(throwables.getMessage());
        } catch (ClassNotFoundException e) {
            System.out.println(e.getMessage());
        }
        request.getRequestDispatcher("WEB-INF/views/customer/list.jsp").forward(request,response);
    }

    private void getUpdateCustomer(HttpServletRequest request, HttpServletResponse response, int id) throws ServletException, IOException {
        Customer customer = null;
        try {
            customer = service.findById(id);
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        request.setAttribute("customer",customer);
        request.getRequestDispatcher("WEB-INF/views/customer/update.jsp").forward(request,response);
    }

    private void addNewCustomer(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        int idType = Integer.parseInt(request.getParameter("type"));
        String name = request.getParameter("name");
        int gender = Integer.parseInt(request.getParameter("gender"));
        String birthdateAsString = request.getParameter("birth");
        String idCard = request.getParameter("idCard");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String address = request.getParameter("address");
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        java.util.Date dateRelease = null;
        String error = null;
        try {
            dateRelease = format.parse(birthdateAsString);
        } catch (ParseException e) {
            error = "Date Release sai format";
        }
        try {
            service.create(new Customer( name, dateRelease, gender != 0, idCard, phone, email, address,idType ));
        } catch (SQLException throwables) {
            error = throwables.getMessage();
        } catch (ClassNotFoundException e) {
            error = e.getMessage();
        }
        if (error == null) {
            response.sendRedirect("/customers");
        } else {
            request.setAttribute("error", error);
            request.getRequestDispatcher("/WEB-INF/views/customer/create.jsp").forward(request, response);
        }
    }

}
