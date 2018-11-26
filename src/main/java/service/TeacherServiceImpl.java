package service;

import dao.CourseDao;
import dao.CourseDaoImpl;
import dao.StudentDao;
import dao.TeacherDao;
import entity.Course;
import entity.Student;
import entity.Teacher;
import entity.User;
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
import java.util.List;

@Transactional
public class TeacherServiceImpl implements TeacherService {
    private static Logger logger = LogUtils.getLogger();

    private CourseDao courseDao;
    private TeacherDao teacherDao;
    private StudentDao studentDao;


    @Override
    public Boolean addStudentByExcel() throws Exception{
        File file = new File("java.xlsx");
        MultipartFile mulFile = new MockMultipartFile("java.xlsx", "java.xlsx",
                ContentType.APPLICATION_OCTET_STREAM.toString(), new FileInputStream(file));
        List<List<String[]>> studentSheets = ExcelUtils.readExcel(mulFile);
        for(List<String[]> sheet : studentSheets){
            // 检查表字段
            // 必须有名字和班级，可以没有密码，则默认与ID相同
            int nameIndex = -1;
            int passwordIndex = -1;
            int classIndex = -1;
            String[] strings = sheet.get(0);
            for(int i = 0; i < strings.length; i++){
                switch (strings[i]){
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
                user.setName(student[nameIndex]);

                if(passwordIndex == -1){
                    user.setPassword(MD5utils.md5(user.getId()));
                }else{
                    user.setPassword(MD5utils.md5(student[passwordIndex]));
                }

                user.setClassNo(student[classIndex]);
            }
        }

        return true;
    }

    @Override
    public void saveCourse(String teacher_id, Course course) {
        Teacher teacher = teacherDao.findById(teacher_id);
        String course_id = CourseIDGenerator();
        logger.debug("course id: {}", course_id);
        course.setCo_id(course_id);
        course.setTeacher(teacher);
        teacher.getCourses().add(course);
        courseDao.save(course);
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

}
