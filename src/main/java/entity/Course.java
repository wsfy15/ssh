package entity;

import java.util.Date;

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

    private User teacher;       // 课程教师编号

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

    public String getCo_describe() {
        return co_describe;
    }

    public void setCo_describe(String co_describe) {
        this.co_describe = co_describe;
    }

    public User getTeacher() {
        return teacher;
    }

    public void setTeacher(User teacher) {
        this.teacher = teacher;
    }
}
