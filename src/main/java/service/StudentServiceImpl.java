package service;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.alibaba.fastjson.serializer.JSONSerializer;
import dao.*;
import entity.*;
import org.apache.http.entity.ContentType;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.slf4j.Logger;
import org.springframework.mock.web.MockMultipartFile;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import utils.ExcelUtils;
import utils.LogUtils;
import utils.MD5utils;

import java.io.Console;
import java.io.File;
import java.io.FileInputStream;
import java.lang.reflect.Array;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

@Transactional
public class StudentServiceImpl implements StudentService {
    private static Logger logger = LogUtils.getLogger();

    private CourseDao courseDao;
    private StudentDao studentDao;
    private  GroupDao groupDao;
    private  GroupMemberDao groupMemberDao;
    private  AssignmentDao  assignmentDao;

    public StudentDao getStudentDao() {
        return studentDao;
    }

    public void setStudentDao(StudentDao studentDao) {
        this.studentDao = studentDao;
    }

    public CourseDao getCourseDao() {
        return courseDao;
    }

    public void setCourseDao(CourseDao courseDao) {
        this.courseDao = courseDao;
    }

    public GroupDao getGroupDao() {
        return groupDao;
    }

    public void setGroupDao(GroupDao groupDao) {
        this.groupDao = groupDao;
    }

    public GroupMemberDao getGroupMemberDao() {
        return groupMemberDao;
    }

    public void setGroupMemberDao(GroupMemberDao groupMemberDao) {
        this.groupMemberDao = groupMemberDao;
    }

    public AssignmentDao getAssignmentDao() {
        return assignmentDao;
    }

    public void setAssignmentDao(AssignmentDao assignmentDao) {
        this.assignmentDao = assignmentDao;
    }

    //    public JSONArray findCourse(String id) {
//
//        //Student student = studentDao.findById(id);
//        //System.out.println(student.getCourses().size());
////        Set<Course> courses=studentDao.getcourse(id);
//        JSONArray jsonArray = new JSONArray();
//
//        for(Course c : courses){
//            JSONObject jsonObject = new JSONObject();
//            jsonObject.put("co_id", c.getCo_id());
//            jsonObject.put("co_name", c.getCo_name());
//            jsonObject.put("co_describe", c.getCo_describe());
//            jsonObject.put("teacher_name", c.getTeacher().getName());
//            jsonObject.put("co_ro_num",c.getCo_ro_num());
//            jsonObject.put("co_date",c.getCo_date());
//            jsonObject.put("co_gr_max",c.getCo_gr_max());
//            jsonObject.put("co_gr_min",c.getCo_gr_min());
//            jsonObject.put("co_te_id",c.getTeacher().getId());
//            jsonArray.add(jsonObject);
//        }
//        return jsonArray;
//    }


    @Override
    public List<Course> findCourseList(String id) {
        Student student = studentDao.findById(id);
        logger.debug("course count: {}", student.getCourses().size());

        Set<Course> courses = student.getCourses();
        return new ArrayList<>(courses);
    }
    @Override
    public   List<Student> searchforstudent(String getvalue){
        List<Student> list=studentDao.findbyproperty(getvalue);
        if (list.isEmpty()) {
            return null;
        } else {
            return list;
        }
    }
    public void uploadgroup(GroupMember groupMember,JSONObject[] jsonObject,int num){

    }
    public void uploadstudent(GroupMember groupMember,Student student){
        student.getGroupMembers().add(groupMember);
        studentDao.update(student);
    }
    @Override
    public boolean upload(JSONArray array, String courseid) {

        int num=array.size();
        logger.debug(String.valueOf(num));
        JSONObject[] jsonObjects=new JSONObject[num];
        for(int i=0;i<array.size();i++){
            jsonObjects[i]=array.getJSONObject(i);
        }
        Course course=courseDao.findById(courseid);
        String prefix=course.getCo_gr_prefix();
        Group group=new Group();
        long count=  groupDao.count();
        count++;
        prefix=prefix+String.valueOf(count);
        group.setGr_id(prefix);
        group.setGr_cheif((String)jsonObjects[0].get("id"));
        group.setGr_phone((String)jsonObjects[num-1].get("phone"));
        group.setGr_qq((String)jsonObjects[num-1].get("qq"));
        group.setGr_email((String)jsonObjects[num-1].get("mail"));
        group.setValid(1);
        group.setGr_num(num-1);
        group.setCourse(course);
        groupDao.save(group);


        for(int i=0;i<array.size()-1;i++){
            GroupMember groupMember=new GroupMember();

            Student student = studentDao.findById(jsonObjects[i].getString("id"));
            groupMember.setStudent(student);
            groupMember.setGroup(group);
            groupMember.setValid(1);

            groupMemberDao.save(groupMember);
        }
        return true;
    }
    public List<Assignment> findassignmentbyid(String assignid){
        Assignment assignment=assignmentDao.findById(assignid);
        List<Assignment> list= new ArrayList();
        list.add(assignment);
        logger.debug(list.toString());
        return list;
    }
    public List<Assignment> searchforassignments(String co_id){
        Course course = courseDao.findById(co_id);
        if(course != null){
            List<Assignment> assignments = new ArrayList<>(course.getAssignments());
            List<Assignment> assignments1 = assignments.stream().filter((Assignment g) -> g.getValid() == 1).collect(Collectors.toList());Collectors.toList();

            return assignments1;
        }
        return null;
    }

}
