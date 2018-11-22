package action;

import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;
import entity.Course;
import org.apache.struts2.ServletActionContext;
import service.CourseServiceImpl;

import javax.servlet.http.HttpServletRequest;

public class CourseAction extends ActionSupport implements ModelDriven<Course> {
    Course course = new Course();

    public String save(){
        HttpServletRequest request = ServletActionContext.getRequest();
        String tid = request.getParameter("tid");
        //new CourseServiceImpl().save(course, tid);
        return SUCCESS;
    }

    @Override
    public Course getModel() {
        return course;
    }
}
