package action;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;
import com.opensymphony.xwork2.util.ValueStack;
import entity.*;
import org.apache.commons.io.FileUtils;
import org.apache.poi.ss.formula.functions.Npv;
import org.apache.struts2.ServletActionContext;
import org.slf4j.Logger;
import service.StudentService;
import utils.FastJsonUtil;
import utils.LogUtils;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.util.*;

/**
 * @ClassName StudentAction
 * @Description TODO
 * Author sf
 * Date 18-11-26 下午11:09
 * @Version 1.0
 **/
public class StudentAction extends ActionSupport implements ModelDriven<Student> {
    private static Logger logger = LogUtils.getLogger();

    private Student student = new Student();

    private StudentService studentService;
    //        <!--获取上传文件,名称必须和表单file控件名相同-->
    private File uploadFile;
    //         <!--获取上传文件名,命名格式：表单file控件名+FileName(固定)-->
    private String uploadFileFileName;
    //获取上传文件类型,命名格式：表单file控件名+ContentType(固定)
    private String uploadFileContentType;

    public File getUploadFile() {
        return uploadFile;
    }
    public void setUploadFile(File uploadFile) {
        this.uploadFile = uploadFile;
    }

    public String getUploadFileFileName() {
        return uploadFileFileName;
    }
    public void setUploadFileFileName(String uploadFileFileName) {
        this.uploadFileFileName = uploadFileFileName;
    }

    public String getUploadFileContentType() {
        return uploadFileContentType;
    }
    public void setUploadFileContentType(String uploadFileContentType) {
        this.uploadFileContentType = uploadFileContentType;
    }

    public String getallclassmate(){
        return NONE;
    }

    public StudentService getStudentService() {
        return studentService;
    }

    public void setStudentService(StudentService studentService) {
        this.studentService = studentService;
    }
    @Override
    public Student getModel() {
        return student;
    }

    public String getAllCourse(){
        Map<String, Object> session = ActionContext.getContext().getSession();
        Student student = (Student) session.get("user");

        logger.debug(student.getId());

        ValueStack valueStack = ActionContext.getContext().getValueStack();
        List<Course> courseList = studentService.findCourseList(student.getId());
        valueStack.set("courseList", courseList);
        return "course";
    }

    //学生选了哪些课程，在左上角提示
    public  String courseList(){
//        获取session值
        Map<String, Object> session = ActionContext.getContext().getSession();
        Student student = (Student) session.get("user");

        logger.debug(student.getId());

        //ValueStack valueStack = ActionContext.getContext().getValueStack();
        List<Course> courseList = studentService.findCourseList(student.getId());

        //valueStack.set("courseList", courseList);
        String jsonArray =new String();
        jsonArray = FastJsonUtil.toJSONString(courseList);
//        logger.debug(jsonArray);

        HttpServletResponse response = ServletActionContext.getResponse();
        response.setContentType("text/javascript;charset=UTF-8");
        try {
                response.getWriter().print(jsonArray);
            } catch (IOException e) {
                e.printStackTrace();
            }

        return NONE;

    }

    //模糊寻找小组成员
    public String searchMember(){
//        获取ajax值
        HttpServletRequest  request = ServletActionContext.getRequest();
        String getValue=request.getParameter("name");
        String courseId=request.getParameter("courseId");
        logger.debug(getValue);
        logger.debug(courseId);

//        获取学生对象并转化为json字符串
        List<Student> getstu=studentService.searchForStudent(getValue,courseId);
        String str = JSON.toJSONString(getstu);
       // System.out.println(getstu);

//        输出到web
        HttpServletResponse response=ServletActionContext.getResponse();
        if(getstu.isEmpty()){

            try {
                response.setContentType("text/javascript;charset=UTF-8");
                response.getWriter().print("null");
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        else {
                FastJsonUtil.writeJson(response,str);
        }
        return NONE;
    }

//    创建小组
    public String uploadGroup() throws IOException {
//        获取web数据
        HttpServletRequest request = ServletActionContext.getRequest();
        logger.debug("uploadGroup" + request.getParameter("data"));
        String getInfor = request.getParameter("data");
//        由于获取的是json对象，所以需要提取数据
        JSONArray jsonArray = JSONArray.parseArray(getInfor);
        int num = jsonArray.size();
//        System.out.println(num);
        JSONObject[] jsonObjects = new JSONObject[num];
        for (int i = 0; i < jsonArray.size(); i++) {
            jsonObjects[i] = jsonArray.getJSONObject(i);
            logger.debug(jsonObjects[i].toJSONString());
        }
//        判断是否已经创建了该课的小组
        String existGroupID=studentService.getGroupId((String) jsonObjects[num - 1].get("courseid"),(String) jsonObjects[0].get("id"));
//        保存到数据库
        boolean a=false;
        if(existGroupID==null){
            a = studentService.upload(jsonArray, (String) jsonObjects[num - 1].get("courseid"));
        }else {
            HttpServletResponse response = ServletActionContext.getResponse();

            if (a == true) {
                response.setContentType("text/javascript;charset=UTF-8");
                response.getWriter().print("success");
            } else {
                response.setContentType("text/javascript;charset=UTF-8");
                response.getWriter().print("error");
            }
        }
//        返回web信息

        return NONE;
    }

//        获取作业信息
    public  String getAssign() throws IOException {
        Map<String, String[]> params = ServletActionContext.getRequest().getParameterMap();
        String co_id = params.get("co_id")[0];
//        获取作业list
        List<Assignment> assignments = studentService.searchForAssignments(co_id);
        if(assignments != null) {
            FastJsonUtil.writeJson(ServletActionContext.getResponse(), FastJsonUtil.toJSONString(assignments));
        }
        return NONE;
    }


//上传文件
    public  String uploadFile() throws IOException {
//      获取参数
        HttpServletRequest request = ServletActionContext.getRequest();
        String courseid=request.getParameter("co_id");
        String userid=request.getParameter("us_id");
        String assignId=request.getParameter("assignID");
        logger.debug(courseid);
        logger.debug(userid);
        logger.debug(assignId);
        
//        获取小组id，若获取失败，返回error到web
        String groupid= studentService.getGroupId(courseid,userid);
        if(groupid==null){
            HttpServletResponse response=ServletActionContext.getResponse();
            Map map=new HashMap();
            map.put("code",0);
            map.put("data","error");
            map.put("msg","");
            map.put("count",7);

            FastJsonUtil.writeJson(response, FastJsonUtil.toJSONString(map));
            return NONE;
        }

//        上传文件，若名字相同则先删除再保存
        String savepath = courseid+"\\"+groupid+"\\";
        logger.debug(savepath);
//        String path = "E:\\javaProject\\files\\" + savepath + uploadFileFileName;
//        String path = request.getSession().getServletContext().getRealPath(savepath+uploadfileFileName);
        String path="D:\\code data\\java\\ssh1\\homeworks"+savepath+uploadFileFileName;
        logger.debug(uploadFileFileName);
        logger.debug(path+"  "+uploadFileFileName+"  "+uploadFile.toString());

        File file=new File(path);
        if(file.exists()) {
            file.delete();
        }
        FileUtils.copyFile(uploadFile, file);
        studentService.saveHomeworkPath(groupid, savepath, uploadFileFileName,assignId,userid);
//        发送成功信息
        HttpServletResponse response=ServletActionContext.getResponse();
        Map map=new HashMap();
        map.put("code",0);
        map.put("data","success");
        map.put("msg","");
        map.put("count",7);

        FastJsonUtil.writeJson(response, FastJsonUtil.toJSONString(map));
        return NONE;
    }

    public String getHomework1(){
//        获取web发来的数据（学生id和课程id）
        Map<String, String[]> params = ServletActionContext.getRequest().getParameterMap();
        String userId = params.get("us_id")[0];
        String co_Id=params.get("co_id")[0];

//        数据库查询小组id，并获取小组对象
        String groupId=studentService.getGroupId(co_Id,userId);
        Group group=studentService.getGroup(groupId);
        logger.debug(group.getGr_id());

//        获取作业对象list
        List<Homework> list=studentService.findHomework(group);

//        发送返回值到web
        HttpServletResponse response=ServletActionContext.getResponse();
        if(list.size()!=0) {
            logger.debug(list.get(0).getHo_name());
        }
        FastJsonUtil.writeJson(response, FastJsonUtil.toJSONString(list));
        return NONE;
    }

    public String getScoure(){
        Map<String, String[]> params = ServletActionContext.getRequest().getParameterMap();
        String userId = params.get("userId")[0];
        List<Grade> list = studentService.getgradelist(userId);
        HttpServletResponse response=ServletActionContext.getResponse();
        FastJsonUtil.writeJson(response, FastJsonUtil.toJSONString(list));
        return NONE;
    }
}
