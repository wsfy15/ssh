package service;

import entity.User;

import java.util.List;

public interface AdminService {
    public String save(List<String> list, Integer role);
    public List<User> saveMulti(List<List<String[]>> userSheets, String role);
    public List<String> getAllClass();
    public String createClass(String year);

    String AdminIDGenerator();
    String StudentIDGenerator();
    String TeacherIDGenerator();
}
