package dao;

import entity.Student;

import java.util.List;


public interface StudentDao extends BaseDao<Student> {
    boolean login(String id, String password);
    List<Student> findbyproperty(String property);
}
