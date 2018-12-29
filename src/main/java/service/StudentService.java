package service;


import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import entity.*;

import java.util.List;
import java.util.Set;

public interface StudentService {

//    JSONArray findCourse(String id);
    List<Course> findCourseList(String id);

    List<Student> searchForStudent(String getvalue);

    boolean upload(JSONArray array,String courseid);
    void uploadgroup(GroupMember groupMember, JSONObject[] jsonObject, int num);
    void uploadstudent(GroupMember groupMember,Student student);


    List<Assignment> findassignmentbyid(String assignid);

    List<Assignment> searchForAssignments(String co_id);

    String getGroupId(String courseid, String userid);

    void savaHomeworkPath(String groupid, String savepath, String uploadfileFileName);

    Group getGroup(String groupid);

    List<Homework> findHomework(Group group);
}
