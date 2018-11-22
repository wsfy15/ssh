package entity;

import java.util.Date;
import java.util.Objects;

/**
 * @ClassName Homework
 * @Description TODO
 * Author sf
 * Date 18-11-15 下午10:41
 * @Version 1.0
 **/
public class Homework {

    private HomeworkPK homeworkPK;
    private Date ho_time;       // 作业提交时间
    private String ho_path;     // 作业存放的地址
    private String ho_name;     // 作业名称
    private String ho_us_id;    // 提交人id


    public HomeworkPK getHomeworkPK() {
        return homeworkPK;
    }

    public void setHomeworkPK(HomeworkPK homeworkPK) {
        this.homeworkPK = homeworkPK;
    }

    public Date getHo_time() {
        return ho_time;
    }

    public void setHo_time(Date ho_time) {
        this.ho_time = ho_time;
    }

    public String getHo_path() {
        return ho_path;
    }

    public void setHo_path(String ho_path) {
        this.ho_path = ho_path;
    }

    public String getHo_name() {
        return ho_name;
    }

    public void setHo_name(String ho_name) {
        this.ho_name = ho_name;
    }

    public String getHo_us_id() {
        return ho_us_id;
    }

    public void setHo_us_id(String ho_us_id) {
        this.ho_us_id = ho_us_id;
    }

}
