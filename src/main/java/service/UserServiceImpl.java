package service;

import dao.AdminDao;
import dao.StudentDao;
import dao.TeacherDao;
import entity.Admin;
import entity.Student;
import entity.Teacher;
import entity.User;
import org.springframework.transaction.annotation.Transactional;
import utils.MD5utils;

@Transactional
public class UserServiceImpl implements UserService {
    private static final String[] roles = {"admin", "teacher", "student"};

    private StudentDao studentDao;
    private AdminDao adminDao;
    private TeacherDao teacherDao;

    public StudentDao getStudentDao() {
        return studentDao;
    }

    public void setStudentDao(StudentDao studentDao) {
        this.studentDao = studentDao;
    }

    public AdminDao getAdminDao() {
        return adminDao;
    }

    public void setAdminDao(AdminDao adminDao) {
        this.adminDao = adminDao;
    }

    public TeacherDao getTeacherDao() {
        return teacherDao;
    }

    public void setTeacherDao(TeacherDao teacherDao) {
        this.teacherDao = teacherDao;
    }

    @Override
    public void save(User s) {
        if(s.getId().startsWith("1010")){
            this.teacherDao.save((Teacher)s);
        }
        else if(s.getId().startsWith("1000")){
            this.adminDao.save((Admin) s);
        }else{
            this.studentDao.save((Student)s);
        }
    }

    @Override
    public Student studentLogin(String id, String password) {
        Student student = studentDao.findById(id);
        if(student != null && student.getPassword().equals(password)){
            return student;
        }
        return null;
    }

    @Override
    public Teacher teacherLogin(String id, String password) {
        Teacher teacher = teacherDao.findById(id);
        if(teacher != null && teacher.getPassword().equals(password)){
            return teacher;
        }
        return null;
    }

    @Override
    public Admin adminLogin(String id, String password) {
        Admin admin = adminDao.findById(id);
        if(admin != null && admin.getPassword().equals(password)){
            return admin;
        }
        return null;
    }

    @Override
    public Teacher teacherLoginAndModifyPassword(String id, String oldPassword, String newPassword) {
        Teacher teacher = teacherDao.findById(id);
        if(teacher != null && teacher.getPassword().equals(MD5utils.md5(oldPassword))){
            teacher.setPassword(MD5utils.md5(newPassword));
            teacherDao.update(teacher);
            return teacher;
        }
        return null;
    }

    @Override
    public Student studentLoginAndModifyPassword(String id, String oldPassword, String newPassword) {
        Student student = studentDao.findById(id);
        if(student != null && student.getPassword().equals(MD5utils.md5(oldPassword))){
            student.setPassword(MD5utils.md5(newPassword));
            studentDao.update(student);
            return student;
        }
        return null;
    }

    @Override
    public Admin adminLoginAndModifyPassword(String id, String oldPassword, String newPassword) {
        Admin admin = adminDao.findById(id);
        if(admin != null && admin.getPassword().equals(MD5utils.md5(oldPassword))){
            admin.setPassword(MD5utils.md5(newPassword));
            adminDao.update(admin);
            return admin;
        }
        return null;
    }


}
