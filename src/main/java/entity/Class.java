package entity;

import com.alibaba.fastjson.annotation.JSONField;

import java.util.HashSet;
import java.util.Set;

public class Class {
    private String id;
    private Integer valid;
    @JSONField(serialize=false)
    private Set<ClassCourse> classCourses=new HashSet<>();

    public Set<ClassCourse> getClassCourses() {
        return classCourses;
    }

    public void setClassCourses(Set<ClassCourse> classCourses) {
        this.classCourses = classCourses;
    }

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
}
