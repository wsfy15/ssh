package action;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;
import entity.Course;
import entity.Student;
import org.apache.struts2.ServletActionContext;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import service.StudentService;

import javax.servlet.http.HttpServletRequest;
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

        Set<Course> courses = studentService.findCourse(id);
        for(Course c : courses){
            System.out.println(c.getCo_id());
        }
        request.setAttribute("courses", courses);
//        session.put("courses", courses);
        return "course";
    }

    public StudentService getStudentService() {
        return studentService;
    }

    public void setStudentService(StudentService studentService) {
        this.studentService = studentService;
    }
}
