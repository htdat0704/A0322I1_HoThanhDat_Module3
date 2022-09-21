package service.impl;

import bean.User;
import repository.UserRepository;
import repository.impl.UserRepositoryImpl;
import service.UserService;

import java.sql.SQLException;
import java.util.List;

public class UserServiceImpl implements UserService {

    private static UserRepository repository = new UserRepositoryImpl();


    @Override
    public void insertUser(User user) throws SQLException {
        repository.insertUser(user);
    }

    @Override
    public User selectUser(int id) {
        return repository.selectUser(id);
    }


    @Override
    public List selectAllUsers() {
        return repository.selectAllUsers();
    }

    @Override
    public boolean deleteUser(int id) throws SQLException {
        return repository.deleteUser(id);
    }

    @Override
    public boolean updateUser(User user) throws SQLException {
        return repository.updateUser(user);
    }

    @Override
    public User getById(int id) {
        return repository.getById(id);
    }

    @Override
    public void insertStore(User user) {
        repository.insertStore(user);
    }

    @Override
    public List<User> findByCountry(String country) {
        return repository.findByCountry(country);
    }

    @Override
    public List<User> sortByName() {
        return repository.sortByName();
    }

    @Override
    public void addUserTransaction(User user, int[] permision) throws SQLException {
        repository.addUserTransaction(user,permision);
    }

    @Override
    public List<User> showAllUsersProcedure() {
        return repository.showAllUsersProcedure();
    }

    @Override
    public void editUserProcedure(User user) {
        repository.editUserProcedure(user);
    }

    @Override
    public void deleteUserProcedure(int id) {
        repository.deleteUserProcedure(id);
    }
}
