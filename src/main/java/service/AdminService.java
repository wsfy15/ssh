package service;

import java.util.List;

public interface AdminService {
    public String save(List<String> list, Integer role);
    public List<String> getAllClass();

    String AdminIDGenerator();
    String StudentIDGenerator();
    String TeacherIDGenerator();
}
