package service;

import entity.User;

public interface UserService {
    void save(User s);
    String login(User s);

}
