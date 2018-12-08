package action;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;
import com.opensymphony.xwork2.util.ValueStack;
import entity.Admin;
import entity.Student;
import entity.Teacher;
import entity.User;
import service.UserService;
import utils.MD5utils;

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

    // 该功能将被遗弃
    public String save(){

        Student s = new Student();
        s.setId("2015211003");
        s.setClassNo("2015211002");
        s.setName("小黑");
        s.setPassword(MD5utils.md5("123456"));
        this.userService.save(s);

        Admin s1 = new Admin();
        s1.setId("1000000000");
        s1.setName("小白");
        s1.setPassword(MD5utils.md5("123456"));
        this.userService.save(s1);

        Teacher s2 = new Teacher();
        s2.setId("1010000000");
        s2.setName("小王");
        s2.setPassword(MD5utils.md5("123456"));
        this.userService.save(s2);
        return SUCCESS;
    }


    /**
     * 登陆成功后，将用户对象压到值栈（root栈）
     * @return
     */
    public String login(){
        ValueStack valueStack = ActionContext.getContext().getValueStack();
        Map<String, Object> session = ActionContext.getContext().getSession();

        String id = user.getId();
        String password = user.getPassword();

        if(id.startsWith("1010")){
            Teacher teacher = userService.teacherLogin(id, password);
            if(teacher != null){
                valueStack.set("user", teacher);
                session.put("user", teacher);
                return "teacher";
            }
        }
        else if(id.startsWith("1000") ){
            Admin admin = userService.adminLogin(id, password);
            if(admin != null){
                valueStack.set("user", admin);
                session.put("user", admin);
                return "admin";
            }
        }else {
            Student student = userService.studentLogin(id, password);
            if(student != null){
                valueStack.set("user", student);
                session.put("user", student);
                return "student";
            }
        }
        return ERROR;
    }

}
