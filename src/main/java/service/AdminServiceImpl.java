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
import org.slf4j.Logger;
import org.springframework.transaction.annotation.Transactional;
import utils.LogUtils;
import utils.MD5utils;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Transactional
public class AdminServiceImpl implements AdminService {
    private static Logger logger = LogUtils.getLogger();

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
            if(list.get(1) == null || list.get(1).trim().length() == 0){
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
            if(list.get(1) == null || list.get(1).trim().length() == 0){
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
            if(list.get(1) == null || list.get(1).trim().length() == 0){
                logger.debug("set password as ID : {}", admin.getId());
                admin.setPassword(MD5utils.md5(admin.getId()));
            }
            else{
                logger.debug("set password: {}", list.get(1));
                admin.setPassword(MD5utils.md5(list.get(1)));
            }

            adminDao.save(admin);
            return admin.getId();
        }
    }

    @Override
    public List<User> saveMulti(List<List<String[]>> userSheets, String role) {
        List<User> users = new ArrayList<>();

        switch (role){
            case "student":
                for(List<String[]> sheet : userSheets){
                    if(sheet.size() == 0){
                        continue;
                    }

                    // 检查表字段
                    // 必须有名字和班级，可以没有密码，则默认与ID相同
                    Map<String, Integer> fieldMap = getFields(sheet.get(0));
                    for(String s: fieldMap.keySet()){
                        logger.debug("{}:{}", s, fieldMap.get(s));
                    }

                    // 不符合规范的用户不添加
                    if(fieldMap.get("name") == null || fieldMap.get("class") == null){
                        continue;
                    }
                    int nameIndex = fieldMap.get("name");
                    int passwordIndex = fieldMap.get("password") == null ? -1 : fieldMap.get("password");
                    int classIndex = fieldMap.get("class");

                    logger.debug("name index: {}", nameIndex);
                    logger.debug("class index: {}", classIndex);

                    for(int i = 1; i < sheet.size(); i++){
                        String[] student = sheet.get(i);
                        Student user = new Student();
                        user.setValid(1);
                        user.setId(StudentIDGenerator());
                        logger.debug("student ID:{}", user.getId());

                        user.setName(student[nameIndex]);

                        if(passwordIndex == -1 || "".equals(student[passwordIndex])){
                            user.setPassword(MD5utils.md5(user.getId()));
                        }else{
                            user.setPassword(MD5utils.md5(student[passwordIndex]));
                        }

                        user.setClassNo(student[classIndex]);
                        studentDao.save(user);
                        users.add(user);
                    }
                }
                break;
            case "teacher":
                for(List<String[]> sheet : userSheets){
                    if(sheet.size() == 0){
                        continue;
                    }

                    // 检查表字段
                    // 必须有名字，可以没有密码，则默认与ID相同
                    Map<String, Integer> fieldMap = getFields(sheet.get(0));

                    // 不符合规范的用户不添加
                    if(fieldMap.get("name") == null){
                        continue;
                    }
                    int nameIndex = fieldMap.get("name");
                    int passwordIndex = fieldMap.get("password") == null ? -1 : fieldMap.get("password");

                    for(int i = 1; i < sheet.size(); i++){
                        String[] teacher = sheet.get(i);
                        Teacher user = new Teacher();
                        user.setValid(1);
                        user.setName(teacher[nameIndex]);
                        user.setId(TeacherIDGenerator());
                        logger.debug("teacher ID:{}", user.getId());

                        if(passwordIndex == -1 || "".equals(teacher[passwordIndex])){
                            user.setPassword(MD5utils.md5(user.getId()));
                        }else{
                            user.setPassword(MD5utils.md5(teacher[passwordIndex]));
                        }

                        teacherDao.save(user);
                        users.add(user);
                    }
                }
                break;
            case "admin":
                for(List<String[]> sheet : userSheets){
                    if(sheet.size() == 0){
                        continue;
                    }

                    // 检查表字段
                    // 必须有名字，可以没有密码，则默认与ID相同
                    Map<String, Integer> fieldMap = getFields(sheet.get(0));

                    // 不符合规范的用户不添加
                    if(fieldMap.get("name") == null ){
                        continue;
                    }
                    int nameIndex = fieldMap.get("name");
                    int passwordIndex = fieldMap.get("password") == null ? -1 : fieldMap.get("password");

                    for(int i = 1; i < sheet.size(); i++){
                        String[] admin = sheet.get(i);
                        for(String s : admin){
                            logger.debug(s);
                        }
                        if(admin[nameIndex].length() == 0){
                            continue;
                        }
                        Admin user = new Admin();
                        user.setValid(1);
                        user.setName(admin[nameIndex]);
                        user.setId(AdminIDGenerator());
                        logger.debug("admin ID:{}", user.getId());

                        if(passwordIndex == -1 || "".equals(admin[passwordIndex])){
                            user.setPassword(MD5utils.md5(user.getId()));
                        }else{
                            user.setPassword(MD5utils.md5(admin[passwordIndex]));
                        }

                        adminDao.save(user);
                        users.add(user);
                    }
                }
                break;
            default:
                return null;
        }

        return users;
    }

    /**
     *
     * @param row: 一般为表格的第一行
     * @return
     */
    private Map<String, Integer> getFields(String[] row){
        Map<String, Integer> map = new HashMap<>();
        Integer index = 0;
        for(String s : row){
            map.put(s, index);
            index++;
        }
        return map;
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

    @Override
    public String createClass(final String year) {
        List<Class> classes = classDao.findAll();
        Integer count = 1;
        for(Class c : classes){
            if(c.getId().startsWith(year)){
                count++;
            }
        }
        Class c = new Class();
        c.setValid(1);
        c.setId(year.concat(String.format("%06d", count)));
        classDao.save(c);
        return c.getId();
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
