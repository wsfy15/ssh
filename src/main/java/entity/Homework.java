package entity;

import com.alibaba.fastjson.annotation.JSONField;

import java.sql.Timestamp;
import java.util.Date;
import java.util.Objects;

/**
 * @ClassName Homework
 * @Description 学生提交的作业
 * Author sf
 * Date 18-11-15 下午10:41
 * @Version 1.0
 **/
public class Homework {

    private  String  id; //作业的id
    private Timestamp ho_time;       // 作业提交时间
    private String ho_path;     // 作业存放的地址
    private String ho_name;     // 作业名称
    private Group group; //绑定到小组
    private Integer valid;

    public String getId() {
        return id;
    }
    @JSONField(serialize=false)
    public void setId(String id) {
        this.id = id;
    }

    public Timestamp getHo_time() {
        return ho_time;
    }
    @JSONField(serialize=false)
    public void setHo_time(Timestamp ho_time) {
        this.ho_time = ho_time;
    }

    public String getHo_path() {
        return ho_path;
    }
    @JSONField(serialize=false)
    public void setHo_path(String ho_path) {
        this.ho_path = ho_path;
    }

    public String getHo_name() {
        return ho_name;
    }
    @JSONField(serialize=false)
    public void setHo_name(String ho_name) {
        this.ho_name = ho_name;
    }

    public Group getGroup() {
        return group;
    }
    @JSONField(serialize=false)
    public void setGroup(Group group) {
        this.group = group;
    }

    public Integer getValid() {
        return valid;
    }
    @JSONField(serialize=false)
    public void setValid(Integer valid) {
        this.valid = valid;
    }
}
