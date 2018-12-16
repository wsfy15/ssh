package entity;

import java.sql.Timestamp;

public class Rollcall {
    private String id;
    private Student student;
    private Course course;
    private Timestamp ro_date;
    private Integer valid;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public Timestamp getRo_date() {
        return ro_date;
    }

    public void setRo_date(Timestamp ro_date) {
        this.ro_date = ro_date;
    }

    public Integer getValid() {
        return valid;
    }

    public void setValid(Integer valid) {
        this.valid = valid;
    }

    public Student getStudent() {
        return student;
    }

    public void setStudent(Student student) {
        this.student = student;
    }

    public Course getCourse() {
        return course;
    }

    public void setCourse(Course course) {
        this.course = course;
    }
}
