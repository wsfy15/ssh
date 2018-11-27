package action;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;
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



    public String login(){
//        System.out.println(user.getPassword());
        String res = userService.login(user);
//        System.out.println("res: " + res);
        if(res != null){
            Map<String, Object> session = ActionContext.getContext().getSession();
            session.put("id", user.getId());
            session.put("role", res);
            return res;
        }

        return ERROR;
    }


}
