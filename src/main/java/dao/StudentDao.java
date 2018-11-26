package dao;

import entity.Student;


public interface StudentDao extends BaseDao<Student> {
    boolean login(String id, String password);
}
