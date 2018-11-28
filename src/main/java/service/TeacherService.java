package service;

import entity.Course;

import java.util.List;

public interface TeacherService {

    Boolean addStudentByExcel(List<List<String[]>> studentSheets);
    String TeacherIDGenerator();
    String CourseIDGenerator();

    void saveCourse(String teacher_id, Course course);

}
