package service;

import entity.Admin;
import entity.Student;
import entity.Teacher;
import entity.User;

import java.util.List;
import java.util.Map;

public interface AdminService {
    public String save(List<String> list, Integer role);
    public List<User> saveMulti(List<List<String[]>> userSheets, String role);

    public List<String> getAllClass();
    public String createClass(String year);

    public List<Student> listStudent();
    public List<Teacher> listTeacher();
    public List<Admin> listAdmin();

    public Boolean deleteUser(String[] ids, String role);
    public Boolean update(Map<String, String[]> params);

    String AdminIDGenerator();
    String StudentIDGenerator();
    String TeacherIDGenerator();
}
