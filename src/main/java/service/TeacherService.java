package service;

import entity.Course;

import java.util.List;

public interface TeacherService {

    Boolean addStudentByExcel(List<List<String[]>> studentSheets);
    String TeacherIDGenerator();
    String CourseIDGenerator();
    List<Course> findCourseList(String id);

    void saveCourse(String teacher_id, Course course);

}
