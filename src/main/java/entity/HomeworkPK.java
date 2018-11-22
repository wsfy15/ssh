package entity;

import java.io.Serializable;
import java.util.Objects;

/**
 * @ClassName HomeworkPK
 * @Description Homework类的主键类
 * Author sf
 * Date 18-11-22 下午6:07
 * @Version 1.0
 **/
public class HomeworkPK implements Serializable {
    private String ho_as_id;    // 作业编号参考ass编号
    private String ho_gr_id;    // 相关联的小组编号

    public String getHo_as_id() {
        return ho_as_id;
    }

    public void setHo_as_id(String ho_as_id) {
        this.ho_as_id = ho_as_id;
    }

    public String getHo_gr_id() {
        return ho_gr_id;
    }

    public void setHo_gr_id(String ho_gr_id) {
        this.ho_gr_id = ho_gr_id;
    }

    @Override
    public boolean equals(Object o){
        if(o instanceof HomeworkPK){
            HomeworkPK pk = (HomeworkPK)o;
            if(this.ho_as_id.equals(pk.getHo_as_id()) &&
                    this.ho_gr_id.equals(pk.getHo_gr_id())){
                return true;
            }
        }

        return false;
    }

    @Override
    public int hashCode() {
        return Objects.hash(ho_as_id, ho_gr_id);
    }
}
