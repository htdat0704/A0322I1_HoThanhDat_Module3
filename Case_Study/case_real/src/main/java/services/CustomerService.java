package services;

import bean.Customer;
import bean.CustomerType;

import java.sql.SQLException;
import java.util.List;

public interface CustomerService extends CRUDService<Customer> {
    List<CustomerType> customerType() throws SQLException, ClassNotFoundException;
    List<Customer> searchCustomer(String name) throws ClassNotFoundException;
}
