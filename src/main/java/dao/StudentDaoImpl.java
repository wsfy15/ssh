package dao;

import entity.Student;
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
public class StudentDaoImpl extends BaseDaoImpl<Student> implements StudentDao {

    @Override
    public boolean login(String id, String password) {
        DetachedCriteria criteria = DetachedCriteria.forClass(Student.class);
        criteria.add(Restrictions.eq("id", id));
        criteria.add(Restrictions.eq("password", password));
        List<Student> list = (List<Student>) this.getHibernateTemplate().findByCriteria(criteria);
        return list.size() > 0;
    }
}
