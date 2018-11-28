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
import org.apache.commons.io.FileUtils;
import org.apache.struts2.ServletActionContext;
import org.slf4j.Logger;
import service.TeacherService;
import utils.ExcelUtils;
import utils.LogUtils;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
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

    public String uploadStudents(){
        // 做文件的上传，说明用户选择了上传的文件了
        if(uploadFileName != null){
            // 打印
            System.out.println("文件类型：" + uploadContentType);

            String path = "/home/sf/Desktop/ssh/files/" + uploadFileName;
            System.out.println(path);
            // 创建file对象
            File file = new File(path);
            if(file.exists()){
                file.delete();
            }

            try {
                FileUtils.copyFile(upload, file);

                List<List<String[]>> studentSheets = ExcelUtils.readExcel(path);
                if(teacherService.addStudentByExcel(studentSheets)){
                    return SUCCESS;
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
        }

        return ERROR;
    }
}
