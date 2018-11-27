package service;

import entity.Course;

public interface TeacherService {

    Boolean addStudentByExcel() throws Exception;
    String TeacherIDGenerator();
    String CourseIDGenerator();

    void saveCourse(String teacher_id, Course course);

}
