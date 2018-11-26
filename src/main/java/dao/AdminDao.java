package dao;

import entity.Admin;


public interface AdminDao extends BaseDao<Admin> {
    boolean login(String id, String password);

}
