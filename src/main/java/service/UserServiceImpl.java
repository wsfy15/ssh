package service;

import dao.AdminDao;
import dao.StudentDao;
import dao.TeacherDao;
import entity.Admin;
import entity.Student;
import entity.Teacher;
import entity.User;
import org.springframework.transaction.annotation.Transactional;

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
    public String login(User s){
        String id = s.getId();
        String password = s.getPassword();

        if(id.startsWith("1010") && teacherDao.login(id, password)){
            return "teacher";
        }
        else if(id.startsWith("1000") && adminDao.login(id, password)){
            return "admin";
        }else if(studentDao.login(id, password)){
                return "student";
        }

        return null;
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


}
