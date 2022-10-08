package services;

import java.sql.SQLException;
import java.util.List;

public interface CRUDService<T> {
    void create(T t) throws SQLException, ClassNotFoundException;

    void update(T t) throws SQLException, ClassNotFoundException;

    T findById(int id) throws SQLException, ClassNotFoundException;

    List<T> findAll() throws SQLException, ClassNotFoundException;

    void delete(int id) throws SQLException, ClassNotFoundException;
}
