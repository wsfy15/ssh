package service;

import dao.*;
import entity.*;
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
import java.sql.Timestamp;
import java.util.*;
import java.util.stream.Collectors;

@Transactional
public class TeacherServiceImpl implements TeacherService {
    private static Logger logger = LogUtils.getLogger();

    private CourseDao courseDao;
    private TeacherDao teacherDao;
    private StudentDao studentDao;
    private AssignmentDao assignmentDao;
    private RollcallDao rollcallDao;
    private HomeWorkDao homeWorkDao;

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
        course.setCo_ro_num_complete(0);
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
        course.getAssignments().add(assignment);
        courseDao.update(course);
        logger.debug("set size: {}", course.getAssignments().size());
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
    public List<Assignment> getAssignment(String co_id) {
        logger.debug("co_id: {}", co_id);
        Course course = courseDao.findById(co_id);
        if(course != null){
            Set<Assignment> assignments = course.getAssignments();
            return new ArrayList<>(assignments);
        }
        return null;
    }

    @Override
    public boolean modifyAssignment(Assignment assignment) {
        Assignment assignment1 = assignmentDao.findById(assignment.getAs_id());
        if(assignment1 == null){
            return false;
        }

        if(assignment.getAs_ddl() != null){
            assignment1.setAs_ddl(assignment.getAs_ddl());
        }
        if(assignment.getAs_weight() != null){
            assignment1.setAs_weight(assignment.getAs_weight());
        }
        assignment1.setAs_describe(assignment.getAs_describe());
        assignmentDao.update(assignment1);
        return true;
    }

    @Override
    public Map<String, Integer> getRollcallCount(String co_id) {
        Course course = courseDao.findById(co_id);
        if(course != null){
            Map<String, Integer> rollcallCount = new HashMap<>();
            rollcallCount.put("complete", course.getCo_ro_num_complete());
            rollcallCount.put("total", course.getCo_ro_num());
            return rollcallCount;
        }
        return null;
    }

    @Override
    public boolean rollcall(String[] ids, String co_id) {
        Course course = courseDao.findById(co_id);
        if(course == null){
            return false;
        }

        Timestamp timestamp = new Timestamp((new Date().getTime()));
        Integer count = course.getCo_ro_num_complete() + 1;
        for(String id : ids){
            Rollcall rollcall = new Rollcall();
            rollcall.setValid(1);
            rollcall.setRo_date(timestamp);
            rollcall.setCourse(course);
            rollcall.setCount(count);

            Student student = studentDao.findById(id);
            if(student != null){
                rollcall.setStudent(student);
            }else{
                continue;
            }

            rollcallDao.save(rollcall);
        }

        course.setCo_ro_num_complete(count);
        return true;
    }

    @Override
    public List<Group> getGroup(String co_id) {
        Course course = courseDao.findById(co_id);
        if(course != null){
            List<Group> groups = new ArrayList<>(course.getGroups());
            List<Group> groups1 = groups.stream().filter((Group g) -> g.getValid() == 1).collect(Collectors.toList());Collectors.toList();
            return groups1;
        }

        return null;
    }

    @Override
    public List<Homework> getHomeworks(String co_id) {
        Course course = courseDao.findById(co_id);
        if(course == null) {
            return null;
        }

        List<Homework> homeworkList = new ArrayList<>();
        Set<Group> groups = course.getGroups();
        for(Group group : groups){
            Set<Homework> homeworks = group.getHomeworks();
            for(Homework homework : homeworks){
                homeworkList.add(homework);
            }
        }

        return homeworkList;
    }

    @Override
    public Homework getHomework(String homework_id) {
        Homework homework = homeWorkDao.findById(homework_id);
        return homework;
    }

    @Override
    public boolean modifyGrade(String ho_id, Float grade) {
        Homework homework = homeWorkDao.findById(ho_id);
        if(homework == null){
            return false;
        }

        homework.setGrade(grade);
        homeWorkDao.update(homework);
        return true;
    }

    @Override
    public boolean modifyCorrection(String ho_id, String correction) {
        Homework homework = homeWorkDao.findById(ho_id);
        if(homework == null){
            return false;
        }

        homework.setCorrection(correction);
        homeWorkDao.update(homework);
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

    public RollcallDao getRollcallDao() {
        return rollcallDao;
    }

    public void setRollcallDao(RollcallDao rollcallDao) {
        this.rollcallDao = rollcallDao;
    }

    public HomeWorkDao getHomeWorkDao() {
        return homeWorkDao;
    }

    public void setHomeWorkDao(HomeWorkDao homeWorkDao) {
        this.homeWorkDao = homeWorkDao;
    }
}
