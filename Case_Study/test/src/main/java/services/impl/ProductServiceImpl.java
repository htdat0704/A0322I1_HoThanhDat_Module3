package services.impl;

import bean.Category;
import bean.Product;
import repository.ProductRepository;
import repository.impl.ProductRepositoryImpl;
import services.ProductService;

import java.sql.SQLException;
import java.util.List;

public class ProductServiceImpl implements ProductService {

    private static ProductRepository productRepository = new ProductRepositoryImpl();

    @Override
    public void create(Product product) throws SQLException, ClassNotFoundException {
        productRepository.create(product);
    }

    @Override
    public void update(Product product) throws SQLException, ClassNotFoundException {
        productRepository.update(product);
    }

    @Override
    public Product findById(int id) throws SQLException, ClassNotFoundException {
        return productRepository.findById(id);
    }

    @Override
    public List<Product> findAll() throws SQLException, ClassNotFoundException {
        return productRepository.findAll();
    }

    @Override
    public void delete(int id) throws SQLException, ClassNotFoundException {
        productRepository.delete(id);
    }

    @Override
    public List<Category> findAllCategory() throws SQLException, ClassNotFoundException {
        return productRepository.findAllCategory();
    }

    @Override
    public List<Product> findByName(String name) throws SQLException, ClassNotFoundException {
        return productRepository.findByName(name);
    }

    @Override
    public List<Product> findByPrice(double price) throws SQLException, ClassNotFoundException {
        return productRepository.findByPrice(price);
    }

    @Override
    public List<Product> findByNameAndPrice(String name, double price) throws SQLException, ClassNotFoundException {
        return productRepository.findByNameAndPrice(name,price);
    }
}
