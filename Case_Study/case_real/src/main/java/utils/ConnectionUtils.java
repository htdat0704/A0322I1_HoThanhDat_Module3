package utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConnectionUtils {
    private static String jdbcURL =
            "jdbc:mysql://localhost:3307/cs_m3?useSSL=false";
    private static String jdbcUsername = "root";
    private static String jdbcPassword = "12345";

    public static Connection getConnection() throws SQLException, ClassNotFoundException {
        Connection connection = null;
        Class.forName("com.mysql.jdbc.Driver");
        connection = DriverManager.getConnection(jdbcURL,
                jdbcUsername, jdbcPassword);
        System.out.println("Connect Success");

        return connection;
    }
}
