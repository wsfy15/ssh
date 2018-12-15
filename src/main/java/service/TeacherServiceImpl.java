package service;

import dao.AssignmentDao;
import dao.CourseDao;
import dao.StudentDao;
import dao.TeacherDao;
import entity.Assignment;
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
    private AssignmentDao assignmentDao;

    /**
     * 添加学生到某节课的学生列表中
     * @param studentSheets
     * @return
     */
    @Override
    public int addStudentByExcel(List<List<String[]>> studentSheets, String co_id){
        Course course = courseDao.findById(co_id);
        if(course == null){
            return -1;
        }

        logger.debug("sheets size:{}", studentSheets.size());
        int success = 0, total = 0;
        for(List<String[]> sheet : studentSheets){
            for(int i = 0; i < sheet.size(); i++){
                String student_id = sheet.get(i)[0];
                if(student_id.trim().length() == 0){
                    continue;
                }

                Student student = studentDao.findById(student_id);
                logger.debug("student ID:{}", student_id);
                if(student != null && student.getValid() == 1){
                    student.getCourses().add(course);
                    success += 1;
                    studentDao.update(student);
                }
                total += 1;
            }
        }
        return success == total ? 0 : 1;
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

    @Override
    public void addAssignment(String co_id, Assignment assignment) {
        Course course = courseDao.findById(co_id);
        assignment.setCourse(course);
        assignment.setAs_id(AssignmentIDGenerator());
        assignment.setValid(1);
        assignmentDao.save(assignment);
    }

    @Override
    public Course getCourse(String courseId) {
        Course course = courseDao.findById(courseId);
        return course;
    }

    @Override
    public boolean addSingleStudent(String student_id, String co_id) {
        Student student = studentDao.findById(student_id);
        Course course = courseDao.findById(co_id);
        if(student == null || course == null) {
            return false;
        }

        student.getCourses().add(course);
        studentDao.update(student);
        return true;
    }

    @Override
    public List<Student> getStudents(String co_id) {
        Course course = courseDao.findById(co_id);
        if(course == null) {
            return null;
        }

        return new ArrayList<Student>(course.getStudents());
    }

    @Override
    public boolean deleteStudent(String[] ids, String co_id) {
        Course course = courseDao.findById(co_id);
        if(course == null){
            return false;
        }

        for(String id : ids){
            Student student = studentDao.findById(id);
            if(student != null && student.getCourses().contains(course)){
                student.getCourses().remove(course);
            }
        }
        return true;
    }

    @Override
    public List<Course> findCourseList(String id) {
        Teacher teacher = teacherDao.findById(id);
        logger.debug("course count: {}", teacher.getCourses().size());

        Set<Course> courses = teacher.getCourses();
        return new ArrayList<>(courses);
    }


    public String AssignmentIDGenerator(){
        long count = this.assignmentDao.count();
        return String.format("%06d", count);
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

    public AssignmentDao getAssignmentDao() {
        return assignmentDao;
    }

    public void setAssignmentDao(AssignmentDao assignmentDao) {
        this.assignmentDao = assignmentDao;
    }

}
