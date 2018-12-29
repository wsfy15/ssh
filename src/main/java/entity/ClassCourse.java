package entity;

public class ClassCourse {
    private Integer valid;

    private  String id;// 复合的id

    private  Course course; //参考groupid

    private Class aClass;//参考学生id

    public Integer getValid() {
        return valid;
    }
    public void setValid(Integer valid) {
        this.valid = valid;
    }

    public String getId() {
        return id;
    }
    public void setId(String id) {
        this.id = id;
    }

    public Course getCourse() {
        return course;
    }
    public void setCourse(Course course) {
        this.course = course;
    }

    public Class getaClass() {
        return aClass;
    }
    public void setaClass(Class aClass) {
        this.aClass = aClass;
    }
}
