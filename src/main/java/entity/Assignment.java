package entity;

import com.alibaba.fastjson.annotation.JSONField;

import java.sql.Timestamp;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

/**
 * @ClassName Assignment
 * @Description TODO
 * Author sf
 * Date 18-11-15 下午10:22
 * @Version 1.0
 **/
public class Assignment {
    private String as_id;
    private String as_name;     // 作业名称
    private String as_describe; // 作业简介
    private Timestamp as_ddl; // 作业截至时间
    private Timestamp as_assigntime;  // 作业布置时间
    private Integer as_weight;  // 作业权重
    private Integer valid;

    @JSONField(serialize=false)
    private Course course;      // // 相关联的课程

    @JSONField(serialize = false)
    private Set<Homework> homeworks=new HashSet<>();//关联作业

    public String getAs_id() {
        return as_id;
    }

    public void setAs_id(String as_id) {
        this.as_id = as_id;
    }

    public String getAs_name() {
        return as_name;
    }

    public void setAs_name(String as_name) {
        this.as_name = as_name;
    }

    public String getAs_describe() {
        return as_describe;
    }

    public void setAs_describe(String as_describe) {
        this.as_describe = as_describe;
    }

    public Timestamp getAs_ddl() {
        return as_ddl;
    }

    public void setAs_ddl(Timestamp as_ddl) {
        this.as_ddl = as_ddl;
    }

    public Timestamp getAs_assigntime() {
        return as_assigntime;
    }

    public void setAs_assigntime(Timestamp as_assigntime) {
        this.as_assigntime = as_assigntime;
    }

    public Integer getAs_weight() {
        return as_weight;
    }

    public void setAs_weight(Integer as_weight) {
        this.as_weight = as_weight;
    }

    public Integer getValid() {
        return valid;
    }

    public void setValid(Integer valid) {
        this.valid = valid;
    }

    public Course getCourse() {
        return course;
    }

    public void setCourse(Course course) {
        this.course = course;
    }

    public Set<Homework> getHomeworks() {
        return homeworks;
    }

    public void setHomeworks(Set<Homework> homeworks) {
        this.homeworks = homeworks;
    }
}
