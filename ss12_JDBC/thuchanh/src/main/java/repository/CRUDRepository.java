package repository;

import java.sql.SQLException;
import java.util.List;

public interface CRUDRepository<T> {
     void insertUser(T t) throws SQLException;

     T selectUser(int id);

     List<T> selectAllUsers();

     boolean deleteUser(int id) throws SQLException;

     boolean updateUser(T t) throws SQLException;

     T getById(int id);

     void insertStore(T t);

}
