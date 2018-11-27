package service;


import entity.Course;

import java.util.Set;

public interface StudentService {

    Set<Course> findCourse(String id);

}
