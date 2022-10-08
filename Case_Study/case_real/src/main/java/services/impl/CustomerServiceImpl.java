package services.impl;

import bean.Customer;
import bean.CustomerType;
import repository.CustomerRepository;
import repository.impl.CustomerRepositoryImpl;
import services.CustomerService;

import java.sql.SQLException;
import java.util.List;

public class CustomerServiceImpl implements CustomerService {

    private CustomerRepository repository = new CustomerRepositoryImpl();

    @Override
    public List<CustomerType> customerType() throws SQLException, ClassNotFoundException {
        return repository.customerType();
    }

    @Override
    public List<Customer> searchCustomer(String name) throws ClassNotFoundException {
        return repository.searchCustomer(name);
    }

    @Override
    public void create(Customer customer) throws SQLException, ClassNotFoundException {
        repository.create(customer);
    }

    @Override
    public void update(Customer customer) throws SQLException, ClassNotFoundException {
        repository.update(customer);
    }

    @Override
    public void delete(int id) {

    }

    @Override
    public Customer findById(int id) throws SQLException, ClassNotFoundException {
        return repository.findById(id);
    }

    @Override
    public List<Customer> findAll() throws SQLException, ClassNotFoundException {
        return repository.findAll();
    }
}
