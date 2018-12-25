package dao;

import entity.Course;
import entity.Group;
import entity.GroupMember;
import entity.Student;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;

import java.util.ArrayList;
import java.util.List;

public class GroupMemberDaoImpl extends BaseDaoImpl<GroupMember> implements GroupMemberDao {

    public List<GroupMember> findbyuserid(Student student){


       logger.debug(student.toString());
       DetachedCriteria criteria = DetachedCriteria.forClass(GroupMember.class);
       criteria.add(Restrictions.eq("student",student));
       List<GroupMember> list = (List<GroupMember>) this.getHibernateTemplate().findByCriteria(criteria);
        return  list;
    }

}
