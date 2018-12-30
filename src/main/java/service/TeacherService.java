package service;

import entity.*;

import java.util.List;
import java.util.Map;
import java.util.Set;

public interface TeacherService {

    String AssignmentIDGenerator();
    String CourseIDGenerator();
    List<Course> findCourseList(String id);

    void saveCourse(String teacher_id, Course course);
    void updateCourse(Course course);
    void addAssignment(String co_id, Assignment assignment);

    Course getCourse(String courseId);

    boolean addSingleStudent(String student_id, String co_id);
    int addStudentByExcel(List<List<String[]>> studentSheets, String co_id);

    List<Student> getStudents(String co_id);

    boolean deleteStudent(String[] ids, String co_id);

    List<Assignment> getAssignment(String co_id);

    boolean modifyAssignment(Assignment assignment);

    Map<String, Integer> getRollcallCount(String co_id);

    boolean rollcall(String[] ids, String co_id);

    List<Group> getGroup(String co_id);

    List<Homework> getHomeworks(String co_id);

    Homework getHomework(String homework_id);

    boolean modifyGrade(String ho_id, Float grade);

    boolean modifyCorrection(String ho_id, String correction);
}
