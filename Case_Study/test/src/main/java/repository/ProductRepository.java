package repository;

import bean.Category;
import bean.Product;

import java.sql.SQLException;
import java.util.List;

public interface ProductRepository extends CRUDRepository<Product>{
    List<Category> findAllCategory() throws SQLException, ClassNotFoundException;

    List<Product> findByName(String name) throws SQLException, ClassNotFoundException;
    List<Product> findByPrice(double price) throws SQLException, ClassNotFoundException;
    List<Product> findByNameAndPrice(String name, double price)throws SQLException, ClassNotFoundException;

    List<Product> findAllProductPagination(int page, int resultPerPage) throws SQLException, ClassNotFoundException;
    int findTotalPage(int resultPerPage) throws SQLException, ClassNotFoundException;
}
