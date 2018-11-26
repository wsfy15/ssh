package dao;

import entity.Teacher;


public interface TeacherDao extends BaseDao<Teacher> {
    boolean login(String id, String password);
}
