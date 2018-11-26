package dao;

import entity.Teacher;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;

import java.util.List;

/**
 * @ClassName TeacherDaoImpl
 * @Description TODO
 * Author sf
 * Date 18-11-24 下午7:20
 * @Version 1.0
 **/
public class TeacherDaoImpl extends BaseDaoImpl<Teacher> implements TeacherDao {


    @Override
    public boolean login(String id, String password) {
        DetachedCriteria criteria = DetachedCriteria.forClass(Teacher.class);
        criteria.add(Restrictions.eq("id", id));
        criteria.add(Restrictions.eq("password", password));
        List<Teacher> list = (List<Teacher>) this.getHibernateTemplate().findByCriteria(criteria);
        return list.size() > 0;
    }
}
