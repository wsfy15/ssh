package service;

import dao.CourseDao;
import dao.StudentDao;
import dao.TeacherDao;
import entity.Course;
import entity.Student;
import entity.Teacher;
import org.apache.http.entity.ContentType;
import org.slf4j.Logger;
import org.springframework.mock.web.MockMultipartFile;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import utils.ExcelUtils;
import utils.LogUtils;
import utils.MD5utils;

import java.io.File;
import java.io.FileInputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;

@Transactional
public class TeacherServiceImpl implements TeacherService {
    private static Logger logger = LogUtils.getLogger();

    private CourseDao courseDao;
    private TeacherDao teacherDao;
    private StudentDao studentDao;

//    public void addCourseForStudent(){
//        Student student = studentDao.findById("2015211003");
//        Course course = courseDao.findById("000000");
//
//        student.getCourses().add(course);
//        studentDao.update(student);
//    }


    /**
     * 添加学生到某节课的学生列表中
     * @param studentSheets
     * @return
     */
    @Override
    public Boolean addStudentByExcel(List<List<String[]>> studentSheets){
        logger.debug("sheets size:{}", studentSheets.size());
        for(List<String[]> sheet : studentSheets){
            if(sheet.size() == 0){
                continue;
            }

            // 检查表字段
            // 必须有名字和班级，可以没有密码，则默认与ID相同
            int nameIndex = -1;
            int passwordIndex = -1;
            int classIndex = -1;
            String[] fieldName = sheet.get(0);
            for(int i = 0; i < fieldName.length; i++){
                switch (fieldName[i]){
                    case "name":
                        nameIndex = i;
                        break;
                    case "password":
                        passwordIndex = i;
                        break;
                    case "class":
                        classIndex = i;
                        break;
                    default:
                        break;
                }
            }

            if(nameIndex == -1 || classIndex == -1){
                return false;
            }

            for(int i = 1; i < sheet.size(); i++){
                String[] student = sheet.get(i);
                Student user = new Student();
                user.setId(StudentIDGenerator());
                logger.debug("student ID:{}", user.getId());

                user.setName(student[nameIndex]);

                if(passwordIndex == -1){
                    user.setPassword(MD5utils.md5(user.getId()));
                }else{
                    user.setPassword(MD5utils.md5(student[passwordIndex]));
                }

                user.setClassNo(student[classIndex]);
                user.setValid(1);
                studentDao.save(user);
            }
        }

        return true;
    }

    @Override
    public void saveCourse(String teacher_id, Course course) {
        Teacher teacher = teacherDao.findById(teacher_id);
        String course_id = CourseIDGenerator();
        logger.debug("course id: {}", course_id);
        course.setValid(1);
        course.setCo_id(course_id);
        course.setTeacher(teacher);
        teacher.getCourses().add(course);
        courseDao.save(course);
    }

    @Override
    public void updateCourse( Course course) {
        courseDao.update(course);
    }

    public  String TeacherIDGenerator(){
        long count = this.teacherDao.count();
        String id = "1010".concat(String.format("%06d", count));
        return id;
    }

    public String StudentIDGenerator(){
        long count = this.studentDao.count();
        String id = "2015".concat(String.format("%06d", count));
        return id;
    }

    public  String CourseIDGenerator(){
        // 长度为6,从 000 001 ~ 999 999
        long count = this.courseDao.count();
        String id = String.format("%06d", count);
        return id;
    }

    public StudentDao getStudentDao() {
        return studentDao;
    }

    public void setStudentDao(StudentDao studentDao) {
        this.studentDao = studentDao;
    }

    public CourseDao getCourseDao() {
        return courseDao;
    }

    public void setCourseDao(CourseDao courseDao) {
        this.courseDao = courseDao;
    }

    public TeacherDao getTeacherDao() {
        return teacherDao;
    }

    public void setTeacherDao(TeacherDao teacherDao) {
        this.teacherDao = teacherDao;
    }

    @Override
    public List<Course> findCourseList(String id) {
       Teacher teacher = teacherDao.findById(id);
        logger.debug("course count: {}", teacher.getCourses().size());

        Set<Course> courses = teacher.getCourses();
        return new ArrayList<>(courses);
    }

}
