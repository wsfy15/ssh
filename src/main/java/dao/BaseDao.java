package dao;

import org.hibernate.criterion.DetachedCriteria;

import java.util.List;

/*
 * @Description 自定义泛型接口，所有DAO的接口都需要继承该接口
 * @Date 下午9:14 18-10-26
 * @Param
 * @return
 **/
public interface BaseDao<T> {

    void save(T t);

    void delete(T t);

    void update(T t);

    T findById(String id);

    List<T> findAll();

    // 记录总数
    long count();
}
