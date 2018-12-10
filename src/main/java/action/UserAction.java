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
import org.slf4j.Logger;
import service.UserService;
import utils.LogUtils;
import utils.MD5utils;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Map;


/**
 * ApplicationContext >  SessionContext  >  RequestContext
 **/


public class UserAction extends ActionSupport implements ModelDriven<User> {
    private static Logger logger = LogUtils.getLogger();
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
//        ValueStack valueStack = ActionContext.getContext().getValueStack();
        Map<String, Object> session = ActionContext.getContext().getSession();

        String id = user.getId();
        String password = MD5utils.md5(user.getPassword());

        try(PrintWriter writer = ServletActionContext.getResponse().getWriter()){
            if(id.startsWith("1010")){
                Teacher teacher = userService.teacherLogin(id, password);
                if(teacher != null){
                    session.put("user", teacher);
                    if(user.getPassword().equals(id)){
                        // 首次登陆，默认密码与ID相同
                        writer.print("firstLogin");
                    }else{
                        writer.print("success");
                    }
                }else{
                    writer.print("fail");
                }
            } else if(id.startsWith("1000") ){
                Admin admin = userService.adminLogin(id, password);
                if(admin != null){
                    session.put("user", admin);
                    if(user.getPassword().equals(id)){
                        // 首次登陆，默认密码与ID相同
                        writer.print("firstLogin");
                    }else{
                        writer.print("success");
                    }
                }else{
                    writer.print("fail");
                }
            }else {
                Student student = userService.studentLogin(id, password);
                if(student != null){
                    session.put("user", student);
                    if(user.getPassword().equals(id)){
                        // 首次登陆，默认密码与ID相同
                        writer.print("firstLogin");
                    }else{
                        writer.print("success");
                    }
                }else{
                    writer.print("fail");
                }
            }
        }catch (IOException e){
            e.printStackTrace();
        }

        return NONE;
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
