package dao;

import java.util.List;

/*
 * @Description 自定义泛型接口，所有DAO的接口都需要继承该接口
 * @Date 下午9:14 18-10-26
 * @Param
 * @return
 **/
public interface BaseDao<T> {

    public void save(T t);

    public void delete(T t);

    public void update(T t);

    public T findById(String id);

    public List<T> findAll();

}
