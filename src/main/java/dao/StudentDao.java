package dao;

import entity.Course;
import entity.Student;

import java.util.List;
import java.util.Set;


public interface StudentDao extends BaseDao<Student> {
    boolean login(String id, String password);
    List<Student> findbyproperty(String property);

//    Set<Course> getcourse(String id);
}
