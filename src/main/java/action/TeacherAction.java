package action;

import com.alibaba.fastjson.JSONArray;
import com.mysql.fabric.Response;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;
import dao.CourseDao;
import entity.*;
import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.beanutils.ConvertUtils;
import org.apache.commons.beanutils.converters.DateConverter;
import com.opensymphony.xwork2.util.ValueStack;
import org.apache.commons.io.FileUtils;
import org.apache.commons.io.IOUtils;
import org.apache.struts2.ServletActionContext;
import org.apache.xmlbeans.impl.xb.xsdschema.Public;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.slf4j.Logger;
import org.springframework.util.FileCopyUtils;
import service.TeacherService;
import utils.ExcelUtils;
import utils.FastJsonUtil;
import utils.LogUtils;
import utils.TimeUtils;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.lang.reflect.InvocationTargetException;
import java.net.URLEncoder;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * @ClassName TeacherAction
 * @Description TODO
 * Author sf
 * Date 18-11-15 下午10:58
 * @Version 1.0
 **/
public class TeacherAction extends ActionSupport implements ModelDriven<Teacher> {
    private static Logger logger = LogUtils.getLogger();

    private Teacher teacher = new Teacher();
    private TeacherService teacherService;

    public void setTeacher(Teacher teacher) {
        this.teacher = teacher;
    }

    public TeacherService getTeacherService() {
        return teacherService;
    }

    public void setTeacherService(TeacherService teacherService) {
        this.teacherService = teacherService;
    }


    @Override
    public Teacher getModel() {
        return teacher;
    }

    public String createCourse() {
        Course course = new Course();
        HttpServletRequest request = ServletActionContext.getRequest();
        Map<String, Object> session = ActionContext.getContext().getSession();
        Map<String, String[]> map = request.getParameterMap();

        try (PrintWriter writer = ServletActionContext.getResponse().getWriter()) {
            DateConverter converter = new DateConverter(null);
            converter.setPattern("yyyy-MM-dd");
            ConvertUtils.register(converter, Date.class);
            BeanUtils.populate(course, map);
            logger.debug("date: {}", course.getCo_date());
            logger.debug("before saveCourse");

            Teacher teacher = (Teacher) session.get("user");
            teacherService.saveCourse(teacher.getId(), course);
            logger.debug("saveCourse success");
            writer.print("success");
            return NONE;
        } catch (IllegalAccessException | InvocationTargetException e) {
            e.printStackTrace();
            try (PrintWriter writer = ServletActionContext.getResponse().getWriter()) {
                writer.print("fail");
            } catch (IOException ee) {
                ee.printStackTrace();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }

        return NONE;
    }

    /**
     * 文件的上传，需要在Action类中定义成员的属性，命名是有规则的
     * 提供set方法，拦截器就注入值了
     */

    // 要上传的文件
    private File upload;
    // 文件的名称
    private String uploadFileName;
    // 文件的MIME的类型
    private String uploadContentType;

    public void setUpload(File upload) {
        this.upload = upload;
    }

    public void setUploadFileName(String uploadFileName) {
        this.uploadFileName = uploadFileName;
    }

    public void setUploadContentType(String uploadContentType) {
        this.uploadContentType = uploadContentType;
    }

    public String addByExcel() {
//        String co_id = (String)ServletActionContext.getRequest().getParameterMap().get("co_id");
        String co_id = (String)((Map<String, String[]>)ServletActionContext.getRequest().getParameterMap()).get("co_id")[0];
        if (uploadFileName != null && co_id != null) {
            // 打印
            logger.debug("文件名：{}", uploadFileName);

            String path = "E:\\javaProject\\files\\" + uploadFileName;
            logger.debug(path);
            // 创建file对象
            File file = new File(path);
            if (file.exists()) {
                file.delete();
            }

            try(PrintWriter writer = ServletActionContext.getResponse().getWriter()) {
                FileUtils.copyFile(upload, file);
                List<List<String[]>> studentSheets = ExcelUtils.readExcel(path);
                for(List<String[]> ls : studentSheets){
                    for(String[] ss:ls){
                        for(String s:ss){
                            System.out.print(s);
                        }
                        System.out.println();
                    }
                }

                int status = teacherService.addStudentByExcel(studentSheets, co_id);
                logger.debug("debug: {}", status);
                switch (status){
                    case 0:
                        writer.print("success");
                        break;
                    case 1:
                        writer.print("partial");
                        break;
                    case -1:
                        writer.print("fail");
                        break;
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        return NONE;
    }

    public String add(){
        Map<String, String[]> params = ServletActionContext.getRequest().getParameterMap();
        String co_id = params.get("co_id")[0];
        String student_id = params.get("student_id")[0];


        try(PrintWriter writer = ServletActionContext.getResponse().getWriter()){
            if(co_id.trim().length() == 0 || student_id.trim().length() == 0){
                writer.print("fail");
            } else{
                if(teacherService.addSingleStudent(student_id, co_id)){
                    writer.print("success");
                } else{
                    writer.print("fail");
                }
            }
        } catch (IOException e){
            e.printStackTrace();
        }

        return NONE;
    }

    /**
     * 获取所有该老师创建的课程
     * @return
     */
    public String getCourse() {
        Map<String, Object> session = ActionContext.getContext().getSession();
        Teacher teacher = (Teacher) session.get("user");
        logger.debug("teacher ID: {}", teacher.getId());

        List<Course> courseList = teacherService.findCourseList(teacher.getId());
        String s = FastJsonUtil.toJSONString(courseList);
        FastJsonUtil.writeJson(ServletActionContext.getResponse(), s);
        return NONE;
    }

    /**
     * 获取某门课程的详细信息
     *
     * @return
     */
    public String getCourseDetail() {
        Map<String, String[]> params = ServletActionContext.getRequest().getParameterMap();
        Course course = teacherService.getCourse(params.get("co_id")[0]);
        FastJsonUtil.writeJson(ServletActionContext.getResponse(),  FastJsonUtil.toJSONString(course));

        return NONE;
    }

    public String getStudent(){
        // 得到课程名，查数据库
        HttpServletRequest request = ServletActionContext.getRequest();
        String co_id = request.getParameter("co_id");
        logger.debug("co_id: {}", co_id);
        List<Student> studentlist = teacherService.getStudents(co_id);
        FastJsonUtil.writeJson(ServletActionContext.getResponse(), FastJsonUtil.toJSONString(studentlist));

        return NONE;
    }

    public String deleteStudent(){
        Map<String, String[]> params = ServletActionContext.getRequest().getParameterMap();
        String co_id = params.get("co_id")[0];
        String[] ids = params.get("ids");

        try(PrintWriter writer = ServletActionContext.getResponse().getWriter()){
            if(co_id.trim().length() == 0 || ids == null || !teacherService.deleteStudent(ids, co_id)){
                writer.print("fail");
            } else{
                writer.print("success");
            }
        } catch (IOException e){
            e.printStackTrace();
        }
        return NONE;
    }

    public String createAssignment(){
        Assignment assignment = new Assignment();
        assignment.setAs_assigntime(new Timestamp(new Date().getTime()) );

        Map<String, String[]> map = ServletActionContext.getRequest().getParameterMap();
        String co_id = map.get("co_id")[0];

        String ddl = map.get("ddl")[0];
        Timestamp timestamp = TimeUtils.strToTimestamp(ddl, "yyyy-MM-dd HH:mm:ss");
        assignment.setAs_ddl(timestamp);

        try (PrintWriter writer = ServletActionContext.getResponse().getWriter()) {
            BeanUtils.populate(assignment, map);
            logger.debug("before saveAssignment");
            teacherService.addAssignment(co_id, assignment);
            logger.debug("saveAssignment success");
            writer.print("success");

            return NONE;
        } catch (IllegalAccessException | InvocationTargetException e) {
            e.printStackTrace();
            try (PrintWriter writer = ServletActionContext.getResponse().getWriter()) {
                writer.print("fail");
            } catch (IOException ee) {
                ee.printStackTrace();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }

        return NONE;
    }

    public String getAssignment(){
//        String co_id = (String) ServletActionContext.getRequest().getParameterMap().get("co_id");
        String co_id = (String) ((Map<String, String[]>)ServletActionContext.getRequest().getParameterMap()).get("co_id")[0];
        List<Assignment> assignments = teacherService.getAssignment(co_id);
        FastJsonUtil.writeJson(ServletActionContext.getResponse(), FastJsonUtil.toJSONString(assignments));
        return NONE;
    }

    public String modifyAssignment(){
        Map<String, String[]> params = ServletActionContext.getRequest().getParameterMap();
        Assignment assignment = new Assignment();

        String ddl = params.get("ddl")[0];
        if(ddl.trim().length() != 0) {
            Timestamp timestamp = TimeUtils.strToTimestamp(ddl, "yyyy-MM-dd HH:mm:ss");
            assignment.setAs_ddl(timestamp);
        }

        String weight = params.get("weight")[0];
        if(weight.trim().length() != 0){
            assignment.setAs_weight(Integer.parseInt(weight));
        }

        assignment.setAs_describe(params.get("as_describe")[0]);
        assignment.setAs_id(params.get("as_id")[0]);
        try (PrintWriter writer = ServletActionContext.getResponse().getWriter()) {
            if(teacherService.modifyAssignment(assignment)) {
                writer.print("success");
            }else{
                writer.print("fail");
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return NONE;
    }

    /**
     * 点名
     * @return
     */
    public String rollcall(){
        Map<String, String[]> params = ServletActionContext.getRequest().getParameterMap();
        String co_id = params.get("co_id")[0];
        String[] ids = params.get("ids");

        if(teacherService.rollcall(ids, co_id)){
            FastJsonUtil.writeJson(ServletActionContext.getResponse(), "success");
        } else{
            FastJsonUtil.writeJson(ServletActionContext.getResponse(), "fail");
        }

        return NONE;
    }

    public String getRollcallCount(){
        Map<String, String[]> params = ServletActionContext.getRequest().getParameterMap();
        String co_id = params.get("co_id")[0];
        Map<String, Integer> rollcallCount = teacherService.getRollcallCount(co_id);
        if(rollcallCount != null){
            FastJsonUtil.writeJson(ServletActionContext.getResponse(), FastJsonUtil.toJSONString(rollcallCount));
        }else{
            FastJsonUtil.writeJson(ServletActionContext.getResponse(), "fail");
        }

        return NONE;
    }

    public String getGroup(){
        Map<String, String[]> params = ServletActionContext.getRequest().getParameterMap();
        String co_id = params.get("co_id")[0];
        List<Group> groups = teacherService.getGroup(co_id);
        if(groups != null) {
            FastJsonUtil.writeJson(ServletActionContext.getResponse(), FastJsonUtil.toJSONString(groups));
        }
        return NONE;
    }

    /**
     * 获取所有已提交的作业
     * @return
     */
    public String getHomeworks(){
        Map<String, String[]> params = ServletActionContext.getRequest().getParameterMap();
        String co_id = params.get("co_id")[0];
        List<Homework> homeworkList = teacherService.getHomeworks(co_id);
        if(homeworkList != null){
            FastJsonUtil.writeJson(ServletActionContext.getResponse(), FastJsonUtil.toJSONString(homeworkList));
        }
        return NONE;
    }

    /**
     * 下载某个指定的作业文件
     * @return
     */
    public String getHomework(){
        Map<String, String[]> params = ServletActionContext.getRequest().getParameterMap();
        String id = params.get("id")[0];
        Homework homework = teacherService.getHomework(id);
        String path = "E:\\javaProject\\files\\" + homework.getHo_path() + homework.getHo_name();
        logger.debug(path);
        File file = new File(path);
        if(!file.exists()){
            return ERROR;
        }

        HttpServletResponse response = ServletActionContext.getResponse();
        try {
            response.setHeader("content-disposition",
                    "attachment;filename=" + URLEncoder.encode(homework.getHo_name(), "utf-8"));
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }

        try {
            FileInputStream fileInputStream = new FileInputStream(path);
            ServletOutputStream outputStream = response.getOutputStream();
            FileCopyUtils.copy(fileInputStream, new BufferedOutputStream(outputStream));
        } catch (IOException e) {
            e.printStackTrace();
        }

        return NONE;
    }

    public String modifyGrade(){
        Map<String, String[]> params = ServletActionContext.getRequest().getParameterMap();
        String ho_id = params.get("id")[0];
        String grade = params.get("grade")[0];

        try (PrintWriter writer = ServletActionContext.getResponse().getWriter()){
            if (teacherService.modifyGrade(ho_id, Float.parseFloat(grade))){
                writer.print("success");
            } else {
                writer.print("fail");
            }
        } catch (IOException e){
            e.printStackTrace();
        }

        return NONE;
    }

    public String modifyCorrection(){
        Map<String, String[]> params = ServletActionContext.getRequest().getParameterMap();
        String ho_id = params.get("id")[0];
        String correction = params.get("correction")[0];

        try (PrintWriter writer = ServletActionContext.getResponse().getWriter()){

            if (teacherService.modifyCorrection(ho_id, correction)){
                writer.print("success");
            } else {
                writer.print("fail");
            }
        } catch (IOException e){
            e.printStackTrace();
        }

        return NONE;
    }

    public String getGroups(){
        Map<String, String[]> params = ServletActionContext.getRequest().getParameterMap();
        String co_id = params.get("co_id")[0];

        List<Group> groups = teacherService.getGroup(co_id);
        FastJsonUtil.writeJson(ServletActionContext.getResponse(), FastJsonUtil.toJSONString(groups));
        return NONE;
    }

    public String getAssignments(){
        Map<String, String[]> params = ServletActionContext.getRequest().getParameterMap();
        String co_id = params.get("co_id")[0];

        List<Assignment> assignments = teacherService.getAssignment(co_id);
        FastJsonUtil.writeJson(ServletActionContext.getResponse(), FastJsonUtil.toJSONString(assignments));
        return NONE;
    }

    public String filterHomeworks(){
        Map<String, String[]> params = ServletActionContext.getRequest().getParameterMap();
        String as_id = params.get("assignment")[0];
        String co_id = params.get("co_id")[0];
        String end = params.get("end")[0];
        String start = params.get("start")[0];
        String group_id = params.get("group")[0];

        List<Homework> homeworkList = teacherService.filterHomework(co_id, as_id, group_id, start, end);
        FastJsonUtil.writeJson(ServletActionContext.getResponse(), FastJsonUtil.toJSONString(homeworkList));

        return NONE;
    }

    public String updateGrade(){
        Map<String, String[]> params = ServletActionContext.getRequest().getParameterMap();
        String co_id = params.get("co_id")[0];
        try(PrintWriter writer = ServletActionContext.getResponse().getWriter()){
            Integer res = teacherService.updateGrade(co_id);
            logger.debug("updateGrade res: {}", res);
            switch (res){
                case -1:
                    writer.print("notfound");       // 查无此课
                    break;
                case -2:
                    writer.print("checkrollcall");  // 点名次数不够
                    break;
                case 0:
                    writer.print("success");
                    break;
                default:
                    break;
            }
        } catch (IOException e){
            e.printStackTrace();
        }

        return NONE;
    }

    public String getGrade(){
        Map<String, String[]> params = ServletActionContext.getRequest().getParameterMap();
        String co_id = params.get("co_id")[0];

        List<Grade> gradeList = teacherService.getGrade(co_id);
        logger.debug("getGrade");
        logger.debug(FastJsonUtil.toJSONString(gradeList));
        FastJsonUtil.writeJson(ServletActionContext.getResponse(), FastJsonUtil.toJSONString(gradeList));
        return NONE;
    }
}
