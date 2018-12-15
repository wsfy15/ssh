package service;

import entity.Course;
import entity.Student;

import java.util.List;

public interface TeacherService {


    String TeacherIDGenerator();
    String CourseIDGenerator();
    List<Course> findCourseList(String id);

    void saveCourse(String teacher_id, Course course);
    void updateCourse(Course course);

    Course getCourse(String courseId);

    boolean addSingleStudent(String student_id, String co_id);
    int addStudentByExcel(List<List<String[]>> studentSheets, String co_id);

    List<Student> getStudents(String co_id);

    boolean deleteStudent(String[] ids, String co_id);
}
