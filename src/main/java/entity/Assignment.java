package entity;

import java.util.Date;

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
    private Date as_ddl; // 作业截至时间
    private Date as_assigntime;  // 作业布置时间
    private String as_co_id;    // 相关课程的作业
    private Integer as_proportion;  // 作业所占比例 1 ~ 100

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

    public Date getAs_ddl() {
        return as_ddl;
    }

    public void setAs_ddl(Date as_ddl) {
        this.as_ddl = as_ddl;
    }

    public Date getAs_assigntime() {
        return as_assigntime;
    }

    public void setAs_assigntime(Date as_assigntime) {
        this.as_assigntime = as_assigntime;
    }

    public String getAs_co_id() {
        return as_co_id;
    }

    public void setAs_co_id(String as_co_id) {
        this.as_co_id = as_co_id;
    }

    public Integer getAs_proportion() {
        return as_proportion;
    }

    public void setAs_proportion(Integer as_proportion) {
        this.as_proportion = as_proportion;
    }
}
