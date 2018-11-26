package action;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;
import entity.Course;
import entity.Teacher;
import entity.User;
import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.beanutils.ConvertUtils;
import org.apache.commons.beanutils.converters.DateConverter;
import org.apache.struts2.ServletActionContext;
import org.slf4j.Logger;
import service.TeacherService;
import utils.LogUtils;

import javax.servlet.http.HttpServletRequest;
import java.lang.reflect.InvocationTargetException;
import java.util.Date;
import java.util.Map;

/**
 * @ClassName TeacherAction
 * @Description TODO
 * Author sf
 * Date 18-11-15 下午10:58
 * @Version 1.0
 **/
public class TeacherAction extends ActionSupport implements ModelDriven<Teacher>{
    private static Logger logger = LogUtils.getLogger();
    private TeacherService teacherService;

    public TeacherService getTeacherService() {
        return teacherService;
    }

    public void setTeacherService(TeacherService teacherService) {
        this.teacherService = teacherService;
    }

    Teacher teacher = new Teacher();

    @Override
    public Teacher getModel() {
        return teacher;
    }

    public String saveCourse(){
        Course course = new Course();
        HttpServletRequest request = ServletActionContext.getRequest();
        Map<String, Object> session = ActionContext.getContext().getSession();
        Map<String, String[]> map = request.getParameterMap();
        try {
            DateConverter converter = new DateConverter( null );
            converter.setPattern("yyyy-mm-dd");
            ConvertUtils.register(converter, Date.class);
            BeanUtils.populate(course, map);
            logger.debug("before saveCourse");
            teacherService.saveCourse((String)session.get("id"), course);
            logger.debug("saveCourse success");
            return SUCCESS;

        } catch (IllegalAccessException|InvocationTargetException e) {
            e.printStackTrace();
        }

        return ERROR;
    }

}
