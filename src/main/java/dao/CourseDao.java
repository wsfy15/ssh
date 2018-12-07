package dao;

import entity.Course;

public interface CourseDao extends BaseDao<Course> {
    void update(String id,Course course);
}
