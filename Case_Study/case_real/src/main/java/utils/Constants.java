package utils;

public class Constants {

    public static String INSERT_INTO_CUSTOMER = "Insert into customer (customer_type_id,customer_name," +
            "customer_birthday, customer_gender, customer_id_card, customer_phone, customer_email, " +
            "customer_address) values (?,?,?,?,?,?,?,?)";

    public static String SELECT_CUSTOMER_TYPE = "SELECT * FROM customer_type order by customer_type_id DESC ";
    public static String SELECT_CUSTOMER = "SELECT * FROM customer ";
    public static String SELECT_CUSTOMER_BY_ID = "SELECT * FROM customer where customer_id = ? ";

    public static String UPDATE_CUSTOMER = "update customer set customer_type_id = ?, customer_name = ?" +
            ", customer_birthday = ?, customer_gender = ?, customer_id_card = ?, customer_phone =? , " +
            "customer_email = ?, customer_address = ? where customer_id = ?";

    public static String FIND_BY_NAME = "select * from customer where customer_name like ? ";
}
