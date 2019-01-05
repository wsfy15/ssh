package entity;

import java.util.Map;

public class Grade {
    private String id;
    private String student_id;
    private String student_class;
    private String student_name;
    private String course_id;
    private Integer[] rollcall;    // 记录第几次点名没到
    private Map<String, Float> homework;   // homework_name, grade
    private Float final_grade;    // 最終成績
    private Integer valid;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getStudent_id() {
        return student_id;
    }

    public void setStudent_id(String student_id) {
        this.student_id = student_id;
    }

    public String getStudent_class() {
        return student_class;
    }

    public void setStudent_class(String student_class) {
        this.student_class = student_class;
    }

    public String getStudent_name() {
        return student_name;
    }

    public void setStudent_name(String student_name) {
        this.student_name = student_name;
    }

    public String getCourse_id() {
        return course_id;
    }

    public void setCourse_id(String course_id) {
        this.course_id = course_id;
    }


    public Float getFinal_grade() {
        return final_grade;
    }

    public void setFinal_grade(Float final_grade) {
        this.final_grade = final_grade;
    }

    public Integer[] getRollcall() {
        return rollcall;
    }

    public void setRollcall(Integer[] rollcall) {
        this.rollcall = rollcall;
    }

    public Map<String, Float> getHomework() {
        return homework;
    }

    public void setHomework(Map<String, Float> homework) {
        this.homework = homework;
    }

    public Integer getValid() {
        return valid;
    }

    public void setValid(Integer valid) {
        this.valid = valid;
    }
}
