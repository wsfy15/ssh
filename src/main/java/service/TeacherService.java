package service;

import entity.Assignment;
import entity.Course;
import entity.Student;

import java.util.List;
import java.util.Map;

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
}
