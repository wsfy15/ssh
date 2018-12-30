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
    private Float grade;  // 分数
    private Integer valid;
    private String correction;  // 批改说明
    private String opinion;     // 学生意见

    private Student submit_user;    //提交人

//    @JSONField(serialize = false)
    private Group group; //绑定到小组

//    @JSONField(serialize = false)
    private Assignment assignment;//绑定到作业布置

    public String getId() {
        return id;
    }
    public void setId(String id) {
        this.id = id;
    }

    public Timestamp getHo_time() {
        return ho_time;
    }
    public void setHo_time(Timestamp ho_time) {
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

    public Group getGroup() {
        return group;
    }
    public void setGroup(Group group) {
        this.group = group;
    }

    public Integer getValid() {
        return valid;
    }
    public void setValid(Integer valid) {
        this.valid = valid;
    }

    public Float getGrade() {
        return grade;
    }
    public void setGrade(Float grade) {
        this.grade = grade;
    }

    public Assignment getAssignment() {
        return assignment;
    }
    public void setAssignment(Assignment assignment) {
        this.assignment = assignment;
    }

    public Student getSubmit_user() {
        return submit_user;
    }
    public void setSubmit_user(Student submit_user) {
        this.submit_user = submit_user;
    }

    public String getCorrection() {
        return correction;
    }
    public void setCorrection(String correction) {
        this.correction = correction;
    }

    public String getOpinion() {
        return opinion;
    }
    public void setOpinion(String opinion) {
        this.opinion = opinion;
    }

    @Override
    public String toString() {
        return "Homework{" +
                "id='" + id + '\'' +
                ", ho_time=" + ho_time +
                ", ho_path='" + ho_path + '\'' +
                ", ho_name='" + ho_name + '\'' +
                ", group=" + group +
                '}';
    }
}
