package dao;

import entity.Grade;
import org.hibernate.Criteria;
import org.hibernate.criterion.DetachedCriteria;

import java.util.List;


public interface GradeDao extends BaseDao<Grade> {
    List<Grade> findByCriteria(DetachedCriteria criteria);
}
