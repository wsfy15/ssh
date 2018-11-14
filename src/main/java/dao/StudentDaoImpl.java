package dao;

import entity.Student;
import org.springframework.orm.hibernate5.support.HibernateDaoSupport;

public class StudentDaoImpl extends HibernateDaoSupport implements StudentDao {

    @Override
    public void add(Student s) {
        this.getHibernateTemplate().save(s);
    }
}
