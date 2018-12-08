package action;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;
import com.opensymphony.xwork2.util.ValueStack;
import entity.Admin;
import entity.Student;
import entity.Teacher;
import entity.User;
import org.apache.struts2.ServletActionContext;
import service.UserService;
import utils.MD5utils;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Map;


/**
 * ApplicationContext >  SessionContext  >  RequestContext
 **/


public class UserAction extends ActionSupport implements ModelDriven<User> {
    private static final long serialVersionUID = -6398052356842807636L;
    private UserService userService;
    private User user = new User();

    @Override
    public User getModel() {
        return user;
    }

    public void setUserService(UserService userService) {
        this.userService = userService;
    }

//    public String none(){
//        return NONE;
//    }

    /**
     * 登陆成功后，将用户对象压到值栈（root栈）
     * @return
     */
    public String login(){
        ValueStack valueStack = ActionContext.getContext().getValueStack();
        Map<String, Object> session = ActionContext.getContext().getSession();

        String id = user.getId();
        String password = MD5utils.md5(user.getPassword());

        if(id.startsWith("1010")){
            Teacher teacher = userService.teacherLogin(id, password);
            if(teacher != null){
                valueStack.set("user", teacher);
                session.put("user", teacher);
                if(user.getPassword().equals(id)){
                    // 首次登陆，默认密码与ID相同
                    return "firstLogin";
                }
                return "teacher";
            }
        } else if(id.startsWith("1000") ){
            Admin admin = userService.adminLogin(id, password);
            if(admin != null){
                valueStack.set("user", admin);
                session.put("user", admin);
                if(user.getPassword().equals(id)){
                    // 首次登陆，默认密码与ID相同
                    return "firstLogin";
                }
                return "admin";
            }
        }else {
            Student student = userService.studentLogin(id, password);
            if(student != null){
                valueStack.set("user", student);
                session.put("user", student);
                if(user.getPassword().equals(id)){
                    // 首次登陆，默认密码与ID相同
                    return "firstLogin";
                }
                return "student";
            }
        }
        return ERROR;
    }

    public String modifyPassword(){
        // 成功返回登陆页面，重新登陆
        //失败保存在修改页面
        HttpServletRequest request = ServletActionContext.getRequest();
        Map<String, String[]> params = request.getParameterMap();

        String id = (String) params.get("id")[0];
        String password = (String) params.get("password")[0];
        String newPassword = (String) params.get("newPassword")[0];
        if(id.startsWith("1010")){
            user = userService.teacherLoginAndModifyPassword(id, password, newPassword);
        }else if(id.startsWith("1000") ){
            user = userService.adminLoginAndModifyPassword(id, password, newPassword);
        }else{
            user = userService.studentLoginAndModifyPassword(id, password, newPassword);
        }

        try(PrintWriter writer = ServletActionContext.getResponse().getWriter()){
            if(user != null){
                writer.print("success");
                ActionContext.getContext().getSession().clear();
            }else{
                writer.print("fail");
            }
        } catch (IOException e) {
            e.printStackTrace();
        }

        return NONE;
    }
}
