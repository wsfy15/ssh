package service;

import dao.CourseDao;
import dao.StudentDao;
import dao.TeacherDao;
import entity.Course;
import entity.Student;
import entity.Teacher;
import org.apache.http.entity.ContentType;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
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
import java.util.Set;

@Transactional
public class StudentServiceImpl implements StudentService {
    private static Logger logger = LogUtils.getLogger();

    private CourseDao courseDao;
    private StudentDao studentDao;

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


    @Override
    public Set<Course> findCourse(String id) {

        Student student = studentDao.findById(id);
        System.out.println(student.getCourses().size());
        return student.getCourses();
    }
}
