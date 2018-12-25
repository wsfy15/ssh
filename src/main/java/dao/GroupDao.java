package dao;

import entity.Course;
import entity.Group;

import java.util.List;

public interface GroupDao extends BaseDao<Group>  {
    List<Group> findbycourse(Course course);
}
