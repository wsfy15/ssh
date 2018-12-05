package service;

import dao.AdminDao;
import dao.ClassDao;
import dao.StudentDao;
import dao.TeacherDao;
import entity.Admin;
import entity.Class;
import entity.Student;
import entity.Teacher;
import entity.User;
import org.springframework.transaction.annotation.Transactional;
import utils.MD5utils;

import java.util.ArrayList;
import java.util.List;

@Transactional
public class AdminServiceImpl implements AdminService {

    /**
     *
     * @param list 0: name 1: password 2: classNo (if necessary)
     * @param role
     * @return String   生成的ID
     */
    @Override
    public String save(List<String> list, Integer role) {
        if(role == User.STUDENT){
            Student student = new Student();
            student.setName(list.get(0));
            student.setId(StudentIDGenerator());
            student.setClassNo(list.get(2));
            if(list.get(1) == null){
                student.setPassword(MD5utils.md5(student.getId()));
            }
            else{
                student.setPassword(MD5utils.md5(list.get(1)));
            }

            studentDao.save(student);
            return student.getId();
        }else if(role == User.TEACHER){
            Teacher teacher = new Teacher();
            teacher.setName(list.get(0));
            teacher.setId(TeacherIDGenerator());
            if(list.get(1) == null){
                teacher.setPassword(MD5utils.md5(teacher.getId()));
            }
            else{
                teacher.setPassword(MD5utils.md5(list.get(1)));
            }

            teacherDao.save(teacher);
            return teacher.getId();
        }else{
            Admin admin = new Admin();
            admin.setName(list.get(0));
            admin.setId(AdminIDGenerator());
            if(list.get(1) == null){
                admin.setPassword(MD5utils.md5(admin.getId()));
            }
            else{
                admin.setPassword(MD5utils.md5(list.get(1)));
            }

            adminDao.save(admin);
            return admin.getId();
        }
    }

    @Override
    public List<String> getAllClass() {
        List<Class> allClass = classDao.findAll();
        List<String> list = new ArrayList<>();
        for(Class c : allClass){
            list.add(c.getId());
        }

        return list;
    }

    public String TeacherIDGenerator(){
        long count = this.teacherDao.count();
        String id = "1010".concat(String.format("%06d", count));
        return id;
    }

    public String StudentIDGenerator(){
        long count = this.studentDao.count();
        String id = "2015".concat(String.format("%06d", count));
        return id;
    }

    public String AdminIDGenerator(){
        long count = this.adminDao.count();
        String id = "1000".concat(String.format("%06d", count));
        return id;
    }

    private AdminDao adminDao;
    private TeacherDao teacherDao;
    private StudentDao studentDao;
    private ClassDao classDao;

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

    public StudentDao getStudentDao() {
        return studentDao;
    }

    public void setStudentDao(StudentDao studentDao) {
        this.studentDao = studentDao;
    }

    public ClassDao getClassDao() {
        return classDao;
    }

    public void setClassDao(ClassDao classDao) {
        this.classDao = classDao;
    }
}
