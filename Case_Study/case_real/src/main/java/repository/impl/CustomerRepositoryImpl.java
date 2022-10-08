package repository.impl;

import bean.Customer;
import bean.CustomerType;
import repository.CustomerRepository;
import utils.ConnectionUtils;
import utils.Constants;

import java.sql.*;
import java.sql.Date;
import java.util.*;

public class CustomerRepositoryImpl implements CustomerRepository {

    

    @Override
    public void create(Customer customer) throws SQLException, ClassNotFoundException {
        try (
                Connection connection = ConnectionUtils.getConnection();
                PreparedStatement statement = connection.prepareStatement(Constants.INSERT_INTO_CUSTOMER)
        ){
            statement.setInt(1, customer.getCustomerType());
            statement.setString(2,customer.getName());
            statement.setDate(3, new java.sql.Date(customer.getBirthday().getTime()));
            statement.setInt(4,customer.isGender() ? 1: 0);
            statement.setString(5,customer.getIdCard());
            statement.setString(6,customer.getPhone());
            statement.setString(7,customer.getEmail());
            statement.setString(8,customer.getAddress());
            statement.executeUpdate();
        }

    }

    @Override
    public void update(Customer customer) throws SQLException, ClassNotFoundException {
        try(
                Connection connection = ConnectionUtils.getConnection();
                PreparedStatement statement = connection.prepareStatement(Constants.UPDATE_CUSTOMER);
                ){
            statement.setInt(1, customer.getCustomerType());
            statement.setString(2,customer.getName());
            statement.setDate(3, new java.sql.Date(customer.getBirthday().getTime()));
            statement.setInt(4,customer.isGender() ? 1: 0);
            statement.setString(5,customer.getIdCard());
            statement.setString(6,customer.getPhone());
            statement.setString(7,customer.getEmail());
            statement.setString(8,customer.getAddress());
            statement.setInt(9,customer.getId());
            statement.executeUpdate();
        }
    }

    @Override
    public void delete(int id) {

    }

    @Override
    public Customer findById(int id) throws SQLException, ClassNotFoundException {
        try(
                Connection connection = ConnectionUtils.getConnection();
                PreparedStatement preparedStatement = connection.prepareStatement(Constants.SELECT_CUSTOMER_BY_ID);
                ){
            preparedStatement.setInt(1,id);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()){
                int idCustomer = resultSet.getInt("customer_id");
                String name = resultSet.getString("customer_name");
                java.util.Date date = new java.util.Date(resultSet.getDate("customer_birthday").getTime());
                boolean gender = resultSet.getInt("customer_gender") != 0;
                String idCard = resultSet.getString("customer_id_card");
                String phone = resultSet.getString("customer_phone");
                String email = resultSet.getString("customer_email");
                String address = resultSet.getString("customer_address");
                return new Customer(id,name,date,gender,idCard,phone,email,address,idCustomer);
            }
        }
        return null;
    }

    @Override
    public List<Customer> findAll() throws SQLException, ClassNotFoundException {
        List<Customer> output = new LinkedList<>();
        try(
                Connection connection = ConnectionUtils.getConnection();
                PreparedStatement ps = connection.prepareStatement(Constants.SELECT_CUSTOMER);
                ResultSet rs = ps.executeQuery();
                ){
            while (rs.next()){
                int id = rs.getInt("customer_id");
                int idCustomerType = rs.getInt("customer_type_id");
                String customerName = rs.getString("customer_name");
                java.util.Date date = new java.util.Date(rs.getDate("customer_birthday").getTime());
                boolean customerGender = rs.getInt("customer_gender") != 0;
                String customerIdCard = rs.getString("customer_id_card");
                String customerPhone = rs.getString("customer_phone");
                String customerEmail = rs.getString("customer_email");
                String customerAddress = rs.getString("customer_address");
                output.add(new Customer(id,customerName,date,customerGender,customerIdCard,customerPhone,
                        customerEmail, customerAddress,idCustomerType));
            }
        }
        return output;
    }

    @Override
    public List<CustomerType> customerType() throws SQLException, ClassNotFoundException {
        List<CustomerType> output = new LinkedList<>();
        try(
                Connection connection = ConnectionUtils.getConnection();
                PreparedStatement st = connection.prepareStatement(Constants.SELECT_CUSTOMER_TYPE);
                ResultSet resultSet = st.executeQuery();
        ){
            while (resultSet.next()){
                int id = resultSet.getInt("customer_type_id");
                String nameType = resultSet.getString("customer_type_name");
                output.add(new CustomerType(id,nameType));
            }
        }
        return output;
    }

    @Override
    public List<Customer> searchCustomer(String name) throws ClassNotFoundException {
        List<Customer> output = new ArrayList<>();
        try (
                Connection connection = ConnectionUtils.getConnection();
                PreparedStatement statement = connection.prepareStatement(Constants.FIND_BY_NAME);
        ){
            statement.setString(1,"%" + name + "%");
            ResultSet rs = statement.executeQuery();
            while (rs.next()){
                int id = rs.getInt("customer_id");
                int idCustomerType = rs.getInt("customer_type_id");
                String customerName = rs.getString("customer_name");
                java.util.Date date = new java.util.Date(rs.getDate("customer_birthday").getTime());
                boolean customerGender = rs.getInt("customer_gender") != 0;
                String customerIdCard = rs.getString("customer_id_card");
                String customerPhone = rs.getString("customer_phone");
                String customerEmail = rs.getString("customer_email");
                String customerAddress = rs.getString("customer_address");
                output.add(new Customer(id,customerName,date,customerGender,customerIdCard,customerPhone,
                        customerEmail, customerAddress,idCustomerType));
            }
            if(output.size() > 0){
                return output;
            }
        }
        catch (SQLException throwables) {
            throwables.printStackTrace();
        }
        return null;
    }
}
