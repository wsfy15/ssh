package dao;

import entity.Student;
import org.apache.xmlbeans.impl.xb.xsdschema.RestrictionDocument;
import org.hibernate.Criteria;
import org.hibernate.Hibernate;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Restrictions;
import  utils.hibernateUtils;
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

    @Override
    public List<Student> findbyproperty(String property) {
        //System.out.println(property);
        DetachedCriteria criteria = DetachedCriteria.forClass(Student.class);
        criteria.add(Restrictions.like("name", property,MatchMode.ANYWHERE));
        List<Student> list = (List<Student>) this.getHibernateTemplate().findByCriteria(criteria);
        //System.out.println("查询学生+"+list);
        return list;
    }
}
