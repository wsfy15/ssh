package service;


import com.alibaba.fastjson.JSONArray;
import entity.Course;
import entity.Student;

import java.util.List;
import java.util.Set;

public interface StudentService {

    JSONArray findCourse(String id);
    List<Course> findCourseList(String id);

    List<Student> searchforstudent(String getvalue);
}
