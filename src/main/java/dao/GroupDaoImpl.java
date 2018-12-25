package dao;

import entity.Course;
import entity.Group;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;

import java.util.List;

public class GroupDaoImpl  extends BaseDaoImpl<Group> implements GroupDao  {
    public List<Group> findbycourse(Course course){
        DetachedCriteria criteria=DetachedCriteria.forClass(Group.class);
        criteria.add(Restrictions.eq("course",course));
        List<Group> list=(List<Group>) this .getHibernateTemplate().findByCriteria(criteria);
        for(Group group:list){
            logger.debug(group.getGr_id());
        }
        return  list;
    }
}
