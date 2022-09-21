package service;

import bean.User;
import repository.CRUDRepository;

import java.util.List;

public interface UserService extends CRUDRepository<User> {
    List<User> findByCountry(String country);

    List<User> sortByName();

    void addUserTransaction(User user, int[] permision);

    List<User> showAllUsersProcedure();

    void editUserProcedure(User user);

    void deleteUserProcedure(int id);
}
