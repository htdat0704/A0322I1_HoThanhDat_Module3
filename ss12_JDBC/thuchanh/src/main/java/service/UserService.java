package service;

import bean.User;
import repository.CRUDRepository;

import java.util.List;

public interface UserService extends CRUDRepository<User> {
    List<User> findByCountry(String country);

    List<User> sortByName();
}
