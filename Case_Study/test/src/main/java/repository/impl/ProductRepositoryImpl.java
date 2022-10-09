package repository.impl;

import bean.Category;
import bean.Product;
import repository.ProductRepository;
import utils.ConnectionUtil;
import utils.Constants;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedList;
import java.util.List;

public class ProductRepositoryImpl implements ProductRepository {
    @Override
    public void create(Product product) throws SQLException, ClassNotFoundException {
        try(
                Connection connection = ConnectionUtil.getConnection();
                PreparedStatement preparedStatement = connection.prepareStatement(Constants.INSERT_INTO_PRODUCT);
                ){
            preparedStatement.setString(1, product.getName());
            preparedStatement.setDouble(2, product.getPrice());
            preparedStatement.setInt(3, product.getQuantity());
            preparedStatement.setString(4, product.getColor());
            preparedStatement.setString(5, product.getDescription());
            preparedStatement.setInt(6, product.getIdCategory());
            preparedStatement.execute();
        }
    }

    @Override
    public void update(Product product) throws SQLException, ClassNotFoundException {
        try(
                Connection connection = ConnectionUtil.getConnection();
                PreparedStatement preparedStatement = connection.prepareStatement(Constants.UPDATE_PRODUCT);
        ){
            preparedStatement.setString(1, product.getName());
            preparedStatement.setDouble(2, product.getPrice());
            preparedStatement.setInt(3, product.getQuantity());
            preparedStatement.setString(4, product.getColor());
            preparedStatement.setString(5, product.getDescription());
            preparedStatement.setInt(6, product.getIdCategory());
            preparedStatement.setInt(7, product.getId());
            preparedStatement.execute();
        }
    }

    @Override
    public Product findById(int id) throws SQLException, ClassNotFoundException {
        try(
                Connection connection = ConnectionUtil.getConnection();
                PreparedStatement ps = connection.prepareStatement(Constants.SELECT_PRODUCT_BY_ID);
                ){
                ps.setInt(1,id);
                ResultSet rs = ps.executeQuery();
                while (rs.next()){
                    String name = rs.getString("name");
                    double price = rs.getDouble("price");
                    int quantity = rs.getInt("quantity");
                    String color = rs.getString("id");
                    String description = rs.getString("description");
                    int idCategory = rs.getInt("id_category");
                    return new Product(id,name,price,quantity,color,description,idCategory);
                }
        }
        return null;
    }

    @Override
    public List<Product> findAll() throws SQLException, ClassNotFoundException {
        List<Product> products = new LinkedList<>();
        try(
                Connection connection = ConnectionUtil.getConnection();
                PreparedStatement statement = connection.prepareStatement(Constants.SELECT_PRODUCT);
                ResultSet rs = statement.executeQuery();
                ){
            while (rs.next()){
                int id = rs.getInt("id");
                String name = rs.getString("name");
                double price = rs.getDouble("price");
                int quantity = rs.getInt("quantity");
                String color = rs.getString("color");
                String description = rs.getString("description");
                int idCategory = rs.getInt("id_category");
                products.add(new Product(id,name,price,quantity,color,description,idCategory));
            }
        }
        return products;
    }

    @Override
    public void delete(int id) throws SQLException, ClassNotFoundException {
        try(
                Connection connection = ConnectionUtil.getConnection();
                PreparedStatement preparedStatement = connection.prepareStatement(Constants.DELETE_PRODUCT);
                ){
            preparedStatement.setInt(1,id);
            preparedStatement.execute();
        }
    }

    @Override
    public List<Category> findAllCategory() throws SQLException, ClassNotFoundException {
        List<Category> categories = new LinkedList<>();
        try(
                Connection connection = ConnectionUtil.getConnection();
                PreparedStatement statement = connection.prepareStatement(Constants.SELECT_CATEGORY);
                ResultSet rs = statement.executeQuery();
        ){
            while (rs.next()){
                int id = rs.getInt("id");
                String name = rs.getString("name");
                categories.add(new Category(id,name));
            }
        }
        return categories;
    }

    @Override
    public List<Product> findByName(String name) throws SQLException, ClassNotFoundException {
        List<Product> products = new LinkedList<>();
        try(
                Connection connection = ConnectionUtil.getConnection();
                PreparedStatement ps = connection.prepareStatement(Constants.FIND_BY_NAME);
        ){
            ps.setString(1,"%" +name+ "%");
            ResultSet rs = ps.executeQuery();
            while (rs.next()){
                int id = rs.getInt("id");
                String nameSearch = rs.getString("name");
                double price = rs.getDouble("price");
                int quantity = rs.getInt("quantity");
                String color = rs.getString("color");
                String description = rs.getString("description");
                int idCategory = rs.getInt("id_category");
                products.add(new Product(id,nameSearch,price,quantity,color,description,idCategory));
            }
        }
        return products;
    }

    @Override
    public List<Product> findByPrice(double price) throws SQLException, ClassNotFoundException {
        List<Product> products = new LinkedList<>();
        try(
                Connection connection = ConnectionUtil.getConnection();
                PreparedStatement ps = connection.prepareStatement(Constants.FIND_BY_PRICE);
        ){
            ps.setDouble(1,price);
            ResultSet rs = ps.executeQuery();
            while (rs.next()){
                int id = rs.getInt("id");
                String nameSearch = rs.getString("name");
                int quantity = rs.getInt("quantity");
                String color = rs.getString("color");
                String description = rs.getString("description");
                int idCategory = rs.getInt("id_category");
                products.add(new Product(id,nameSearch,price,quantity,color,description,idCategory));
            }
        }
        return products;
    }

    @Override
    public List<Product> findByNameAndPrice(String name, double price) throws SQLException, ClassNotFoundException {
        List<Product> products = new LinkedList<>();
        try(
                Connection connection = ConnectionUtil.getConnection();
                PreparedStatement ps = connection.prepareStatement(Constants.FIND_BY_PRICE_AND_NAME);
        ){
            ps.setDouble(1,price);
            ps.setString(2,"%" +name+ "%");
            ResultSet rs = ps.executeQuery();
            while (rs.next()){
                int id = rs.getInt("id");
                String nameSearch = rs.getString("name");
                int quantity = rs.getInt("quantity");
                String color = rs.getString("color");
                String description = rs.getString("description");
                int idCategory = rs.getInt("id_category");
                products.add(new Product(id,nameSearch,price,quantity,color,description,idCategory));
            }
        }
        return products;
    }

    @Override
    public List<Product> findAllProductPagination(int page, int resultPerPage) throws SQLException, ClassNotFoundException {
        ProductRepository productRepository = new ProductRepositoryImpl();
        int totalPage = productRepository.findTotalPage(resultPerPage);
        if(page > totalPage) {
            page = totalPage;
        }
        if(page < 1) {
            page = 1;
        }
        List<Product> products = new LinkedList<>();
        int skip = resultPerPage * (page - 1);
        try(
                Connection connection = ConnectionUtil.getConnection();
                PreparedStatement preparedStatement = connection.prepareStatement(Constants.SELECT_PRODUCT_PAGINATION);
                ){
            preparedStatement.setInt(1,skip);
            preparedStatement.setInt(2,resultPerPage);
            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()){
                int id = rs.getInt("id");
                String nameSearch = rs.getString("name");
                int quantity = rs.getInt("quantity");
                double price = rs.getDouble("price");
                String color = rs.getString("color");
                String description = rs.getString("description");
                int idCategory = rs.getInt("id_category");
                products.add(new Product(id,nameSearch,price,quantity,color,description,idCategory));
            }
        }
        return products;
    }

    @Override
    public int findTotalPage(int resultPerPage) throws SQLException, ClassNotFoundException {
        int output = 0;
        try(
                Connection connection = ConnectionUtil.getConnection();
                PreparedStatement ps = connection.prepareStatement(Constants.SELECT_COUNT_PRODUCT);
                ResultSet rs = ps.executeQuery();
                ){
            while (rs.next()){
                output = rs.getInt("count(1)");
            }

        }
        if(resultPerPage%output == 0){
            return output/resultPerPage;
        }
        return  ((int) output/resultPerPage) +1;
    }
}
