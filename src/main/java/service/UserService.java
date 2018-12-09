package service;

import entity.Admin;
import entity.Student;
import entity.Teacher;
import entity.User;

public interface UserService {
    void save(User s);

    Student studentLogin(String id, String password);
    Teacher teacherLogin(String id, String password);
    Admin adminLogin(String id, String password);

    Teacher teacherLoginAndModifyPassword(String id, String oldPassword, String newPassword);
    Student studentLoginAndModifyPassword(String id, String oldPassword, String newPassword);
    Admin adminLoginAndModifyPassword(String id, String oldPassword, String newPassword);
}
