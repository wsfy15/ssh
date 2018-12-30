package dao;

import entity.Group;
import entity.Homework;
import org.hibernate.criterion.DetachedCriteria;

import java.util.List;

public interface HomeWorkDao extends BaseDao<Homework> {
    Homework findbygroupid_filename(Group group, String uploadfileFileName);

    List<Homework> findhomeworkbygroup(Group group);

}
