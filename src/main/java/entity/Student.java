package entity;

import com.alibaba.fastjson.annotation.JSONField;
import com.sun.org.apache.bcel.internal.generic.NEW;

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

    @JSONField(serialize=false)
    private Set<Course> courses = new HashSet<>();

    @JSONField(serialize=false)
    private  Set<GroupMember> groupMembers= new HashSet<>();//小组成员参考学生id

    @JSONField(serialize=false)
    private Set<Rollcall> rollcalls = new HashSet<>();

    public Set<Rollcall> getRollcalls() {
        return rollcalls;
    }

    public void setRollcalls(Set<Rollcall> rollcalls) {
        this.rollcalls = rollcalls;
    }

    public Set<GroupMember> getGroupMembers() {
        return groupMembers;
    }

    public void setGroupMembers(Set<GroupMember> groupMembers) {
        this.groupMembers = groupMembers;
    }

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
