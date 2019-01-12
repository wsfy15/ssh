package dao;

import entity.Course;
import entity.Group;
import entity.GroupMember;
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

import java.util.ArrayList;
import java.util.List;
import java.util.Set;

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
    public List<Student> findbyproperty(String property,Course course) {
        //System.out.println(property);
        logger.debug(course.getCo_id());
        DetachedCriteria criteria = DetachedCriteria.forClass(Student.class);
        criteria.add(Restrictions.like("name", property,MatchMode.ANYWHERE));
        //criteria.add(Restrictions.eq("course",course));
        List<Student> list = (List<Student>) this.getHibernateTemplate().findByCriteria(criteria);
        List<Student> alist= new ArrayList<>();
        for(Student student:list){
            Set<Course> courseList=student.getCourses();
            for(Course course1:courseList){
                logger.debug(course1.getCo_id());
                if(course1.getCo_id().equals(course.getCo_id())){
                    alist.add(student);
                }
            }
        }
        //System.out.println("查询学生+"+list);
        return alist;
    }
     public List<Student> findallreadyhavegroup(Course course,StudentDao studentDao){
        List<Student> list=new ArrayList<>();
        for(Group group:course.getGroups()){
            for(GroupMember groupMember :group.getGroupMembers()){
                list.add(studentDao.findById(groupMember.getStudent().getId()))  ;
            }
         }
        return list;
     }
//    public Set<Course> getcourse(String id){
//        DetachedCriteria criteria = DetachedCriteria.forClass(Course.class);
//        criteria.add(Restrictions.eq("id",id ,MatchMode.ANYWHERE));
//        List<Student> list = (List<Student>) this.getHibernateTemplate().findByCriteria(criteria);
//    }
}
