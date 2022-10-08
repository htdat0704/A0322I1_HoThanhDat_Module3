package repository;

import java.sql.SQLException;
import java.util.List;

public interface CRUDRepository<T> {
    void create(T t) throws SQLException, ClassNotFoundException;

    void update(T t) throws SQLException, ClassNotFoundException;

    void delete(int id);

    T findById(int id) throws SQLException, ClassNotFoundException;

    List<T> findAll() throws SQLException, ClassNotFoundException;
}
