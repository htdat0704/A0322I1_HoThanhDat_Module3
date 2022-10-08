package utils;

public interface Constants {
    String INSERT_INTO_PRODUCT = "Insert into product (name," +
            "price, quantity, color, description, id_category) values (?,?,?,?,?,?)";

    String SELECT_CATEGORY = "SELECT * FROM category ";
    String SELECT_PRODUCT = "SELECT * FROM product ";
    String SELECT_PRODUCT_BY_ID = "SELECT * FROM product where id = ? ";

    String UPDATE_PRODUCT = "update product set name = ?, price = ?" +
            ", quantity = ?, color = ?, description = ?, id_category =? where id = ?";

    String FIND_BY_NAME = "select * from product where name like ? ";
}
