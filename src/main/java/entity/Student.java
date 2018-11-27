package entity;

import java.util.HashSet;
import java.util.Set;

/**
 * @ClassName Student
 * @Description TODO
 * Author sf
 * Date 18-11-24 下午7:26
 * @Version 1.0
 **/
public class Student extends User {
    private String classNo; // 所属班级
    private Set<Course> courses = new HashSet<>();

    public String getClassNo() {
        return classNo;
    }

    public void setClassNo(String classNo) {
        this.classNo = classNo;
    }

    public Set<Course> getCourses() {
        return courses;
    }

    public void setCourses(Set<Course> courses) {
        this.courses = courses;
    }
}
