package service;

import entity.User;

public interface UserService {
    public void save(User s);
    public String login(User s);

}
