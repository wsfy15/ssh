package action;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;
import com.opensymphony.xwork2.util.ValueStack;
import com.sun.org.apache.bcel.internal.generic.NEW;
import entity.Assignment;
import entity.Course;
import entity.Student;
import org.apache.commons.io.FileUtils;
import org.apache.struts2.ServletActionContext;
import org.hibernate.Session;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.slf4j.Logger;
import service.StudentService;
import utils.FastJsonUtil;
import utils.LogUtils;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.Console;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

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
    public  String courselist(){
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
    public String searchmember(){
        HttpServletRequest  request = ServletActionContext.getRequest();
        String getvalue=request.getParameter("name");
        logger.debug(getvalue);

        List<Student> getstu=studentService.searchforstudent(getvalue);
        String str = JSON.toJSONString(getstu);
       // System.out.println(getstu);
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


        public String uploadgroup() throws IOException {
        HttpServletRequest  request = ServletActionContext.getRequest();
        logger.debug("uploadgroup"+request.getParameter("data"));
        String getinfor=request.getParameter("data");
        JSONArray jsonArray=  JSONArray.parseArray(getinfor);
            int num=jsonArray.size();
            System.out.println(num);
            JSONObject[] jsonObjects=new JSONObject[num];
            for(int i=0;i<jsonArray.size();i++){
                jsonObjects[i]=jsonArray.getJSONObject(i);
                logger.debug(jsonObjects[i].toJSONString());
            }

            boolean a=studentService.upload(jsonArray, (String) jsonObjects[num-1].get("courseid"));
            HttpServletResponse response=ServletActionContext.getResponse();

            if(a==true){

                    response.setContentType("text/javascript;charset=UTF-8");
                    response.getWriter().print("success");

            }
            else{
                response.setContentType("text/javascript;charset=UTF-8");
                response.getWriter().print("error");
            }
        return NONE;
    }

    public  String getassign() throws IOException {
        Map<String, String[]> params = ServletActionContext.getRequest().getParameterMap();
        String co_id = params.get("co_id")[0];
        List<Assignment> assignments = studentService.searchforassignments(co_id);
        if(assignments != null) {
            FastJsonUtil.writeJson(ServletActionContext.getResponse(), FastJsonUtil.toJSONString(assignments));
        }
        return NONE;
    }

//        <!--获取上传文件,名称必须和表单file控件名相同-->
    private File uploadfile;

//         <!--获取上传文件名,命名格式：表单file控件名+FileName(固定)-->
    private String uploadfileFileName;

        //获取上传文件类型,命名格式：表单file控件名+ContentType(固定)
    private String uploadfileContentType;

    public File getUploadfile() {
        return uploadfile;
    }

    public void setUploadfile(File uploadfile) {
        this.uploadfile = uploadfile;
    }

    public String getUploadfileFileName() {
        return uploadfileFileName;
    }

    public void setUploadfileFileName(String uploadfileFileName) {
        this.uploadfileFileName = uploadfileFileName;
    }

    public String getUploadfileContentType() {
        return uploadfileContentType;
    }

    public void setUploadfileContentType(String uploadfileContentType) {
        this.uploadfileContentType = uploadfileContentType;
    }

    public  String uploadfile() throws IOException {

        HttpServletRequest request = ServletActionContext.getRequest();
        String path = request.getSession().getServletContext().getRealPath("/files/"+uploadfileFileName);
        logger.debug(path+"  "+uploadfileFileName+"  "+uploadfile.toString());
        File file=new File(path);
        if(file.exists())
        {
            file.delete();
        }
        FileUtils.copyFile(uploadfile,file);
        HttpServletResponse response=ServletActionContext.getResponse();
        Map map=new HashMap();
        map.put("code",0);
        map.put("data","success");
        map.put("msg","");
        map.put("count",7);

        FastJsonUtil.writeJson(response, FastJsonUtil.toJSONString(map));

        return NONE;
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
}
