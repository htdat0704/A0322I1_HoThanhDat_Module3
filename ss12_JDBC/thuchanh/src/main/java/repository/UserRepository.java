package repository;

import bean.User;

import java.util.List;

public interface UserRepository extends CRUDRepository<User> {
    List<User> findByCountry(String country);

    List<User> sortByName();
}
