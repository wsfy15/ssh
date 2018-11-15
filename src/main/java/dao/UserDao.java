package dao;

import entity.User;

public interface UserDao extends BaseDao<User>{
    String getPassword(String id);
}
