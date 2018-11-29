package action;

import com.alibaba.fastjson.JSONArray;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;
import com.opensymphony.xwork2.util.ValueStack;
import entity.Course;
import entity.Student;
import org.apache.struts2.ServletActionContext;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import service.StudentService;
import utils.FastJsonUtil;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.Map;
import java.util.Set;

/**
 * @ClassName StudentAction
 * @Description TODO
 * Author sf
 * Date 18-11-26 下午11:09
 * @Version 1.0
 **/
public class StudentAction extends ActionSupport implements ModelDriven<Student> {
    private Student student = new Student();
    private StudentService studentService;

    @Override
    public Student getModel() {
        return student;
    }

    public String getAllCourse(){
        Map<String, Object> session = ActionContext.getContext().getSession();
        HttpServletRequest request = ServletActionContext.getRequest();
        String id = (String) session.get("id");
//        String id = student.getId();  //json
        System.out.println(id);
        JSONArray courses = studentService.findCourse(id);


        ValueStack valueStack = ActionContext.getContext().getValueStack();
        List<Course> courseList = studentService.findCourseList(id);
        valueStack.set("courseList", courseList);
        return "course";

        // 使用fastjson，把list转换成json字符串
//        String jsonString = FastJsonUtil.toJSONString(courses);
//        // 把json字符串写到浏览器
//        HttpServletResponse response = ServletActionContext.getResponse();
//        // 输出
//        FastJsonUtil.writeJson(response, jsonString);
//        return NONE;
    }

    public StudentService getStudentService() {
        return studentService;
    }

    public void setStudentService(StudentService studentService) {
        this.studentService = studentService;
    }
}
