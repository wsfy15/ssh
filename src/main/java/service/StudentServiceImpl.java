package service;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.alibaba.fastjson.serializer.JSONSerializer;
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
import java.util.ArrayList;
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

    
    public JSONArray findCourse(String id) {

        Student student = studentDao.findById(id);
        System.out.println(student.getCourses().size());

        Set<Course> courses = student.getCourses();
        JSONArray jsonArray = new JSONArray();

        for(Course c : courses){
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("co_id", c.getCo_id());
            jsonObject.put("co_name", c.getCo_name());
            jsonObject.put("co_describe", c.getCo_describe());
            jsonObject.put("teacher_name", c.getTeacher().getName());
            jsonObject.put("co_ro_num",c.getCo_ro_num());
            jsonObject.put("co_date",c.getCo_date());
            jsonObject.put("co_gr_max",c.getCo_gr_max());
            jsonObject.put("co_gr_min",c.getCo_gr_min());
            jsonObject.put("co_gr_preyear",c.getCo_gr_preyear());
            jsonObject.put("co_gr_preclass",c.getCo_gr_preclass());
            jsonObject.put("co_te_id",c.getTeacher().getId());
            jsonArray.add(jsonObject);
        }
        return jsonArray;
    }

    @Override
    public List<Course> findCourseList(String id) {
        Student student = studentDao.findById(id);
        logger.debug("course count: {}", student.getCourses().size());

        Set<Course> courses = student.getCourses();
        return new ArrayList<>(courses);
    }
}
