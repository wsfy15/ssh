package dao;

import entity.Group;
import entity.Homework;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;

import java.util.List;

public class HomeWorkDaoImpl extends BaseDaoImpl<Homework> implements HomeWorkDao {
    public Homework findbygroupid_filename(Group group, String uploadfileFileName){

        DetachedCriteria criteria=DetachedCriteria.forClass(Homework.class);
        criteria.add(Restrictions.eq("group",group));
        criteria.add(Restrictions.eq("ho_name",uploadfileFileName));
        logger.debug(group.getGr_id());
        logger.debug(uploadfileFileName);
        List<Homework> list=(List<Homework>) this.getHibernateTemplate().findByCriteria(criteria);
        logger.debug("list.size"+list.size());
        if(list.size()==0)
            return null;
        return list.get(0);
    }
    public List<Homework> findhomeworkbygroup(Group group){
        DetachedCriteria criteria=DetachedCriteria.forClass(Homework.class);
        criteria.add(Restrictions.eq("group",group));
        return  (List<Homework>) this.getHibernateTemplate().findByCriteria(criteria);
    }

}
