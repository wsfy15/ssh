package entity;

import com.alibaba.fastjson.annotation.JSONField;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

/**
 * @ClassName Course
 * @Description TODO
 * Author sf
 * Date 18-11-15 下午10:04
 * @Version 1.0
 **/
public class Course {
    private String co_id;       // 课程id
    private String co_name;     // 完整课程名
    private Integer co_ro_num;  // 本学期点名次数
    private Date co_date;       // 开课时间
    private String co_describe; // 课程描述
    private Integer co_gr_max;  //小组最大人员数目
    private Integer co_gr_min;  //小组最小人员数目
    private String co_gr_prefix;    // 小组编号前缀
    private Integer valid;
    private Teacher teacher;       // 课程教师编号

    @JSONField(serialize=false)
    private Set<Student> students = new HashSet<>();

    public Integer getCo_gr_max() { return co_gr_max; }

    public void setCo_gr_max(Integer co_gr_max) { this.co_gr_max = co_gr_max; }

    public Integer getCo_gr_min() { return co_gr_min; }

    public void setCo_gr_min(Integer co_gr_min) { this.co_gr_min = co_gr_min; }

    public String getCo_id() {
        return co_id;
    }

    public void setCo_id(String co_id) {
        this.co_id = co_id;
    }

    public String getCo_name() {
        return co_name;
    }

    public void setCo_name(String co_name) {
        this.co_name = co_name;
    }

    public Integer getCo_ro_num() {
        return co_ro_num;
    }

    public void setCo_ro_num(Integer co_ro_num) {
        this.co_ro_num = co_ro_num;
    }

    public Date getCo_date() {
        return co_date;
    }

    public void setCo_date(Date co_date) {
        this.co_date = co_date;
    }

    public String getCo_gr_prefix() {
        return co_gr_prefix;
    }

    public void setCo_gr_prefix(String co_gr_prefix) {
        this.co_gr_prefix = co_gr_prefix;
    }

    public String getCo_describe() {
        return co_describe;
    }

    public void setCo_describe(String co_describe) {
        this.co_describe = co_describe;
    }

    public Teacher getTeacher() {
        return teacher;
    }

    public void setTeacher(Teacher teacher) {
        this.teacher = teacher;
    }

    public Set<Student> getStudents() {
        return students;
    }

    public void setStudents(Set<Student> students) {
        this.students = students;
    }

    public Integer getValid() {
        return valid;
    }

    public void setValid(Integer valid) {
        this.valid = valid;
    }

    @Override
    public String toString() {
        return "Course{" +
                "co_id='" + co_id + '\'' +
                ", co_name='" + co_name + '\'' +
                ", co_ro_num=" + co_ro_num +
                ", co_date=" + co_date +
                ", co_describe='" + co_describe + '\'' +
                ", co_gr_max=" + co_gr_max +
                ", co_gr_min=" + co_gr_min +
                ", co_gr_prefix='" + co_gr_prefix + '\'' +
                ", valid=" + valid +
                ", teacher=" + teacher +
                '}';
    }
}
