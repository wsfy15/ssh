package dao;

import entity.Grade;
import org.hibernate.Criteria;
import org.hibernate.criterion.DetachedCriteria;

import java.util.List;

/**
 * @ClassName TeacherDaoImpl
 * @Description TODO
 * Author sf
 * Date 18-11-24 下午7:20
 * @Version 1.0
 **/
public class GradeDaoImpl extends BaseDaoImpl<Grade> implements GradeDao {

    @Override
    public List<Grade> findByCriteria(DetachedCriteria criteria) {
        return (List<Grade>)this.getHibernateTemplate().findByCriteria(criteria);
    }
}
