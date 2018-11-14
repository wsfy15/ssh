package dao;

import entity.User;

public interface UserDao extends BaseDao<User>{
    public String getPassword(String id);
}
