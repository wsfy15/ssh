package entity;

import com.alibaba.fastjson.annotation.JSONField;

import java.util.HashSet;
import java.util.Set;

/**
 * @ClassName Teacher
 * @Description TODO
 * Author sf
 * Date 18-11-24 下午5:17
 * @Version 1.0
 **/
public class Teacher extends User{
    @JSONField(serialize=false)
    private Set<Course> courses = new HashSet<>();

    public Set<Course> getCourses() {
        return courses;
    }

    public void setCourses(Set<Course> courses) {
        this.courses = courses;
    }



}
