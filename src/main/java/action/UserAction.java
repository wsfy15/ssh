package action;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;
import entity.User;
import service.UserService;
import utils.MD5utils;

import java.util.Map;

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

    public String save(){
        User s = new User();
        s.setId("2015211002");
        s.setClassNo("2015211001");
        s.setName("小黑");
        s.setPassword(MD5utils.md5("123456"));
        s.setRole(2);

        this.userService.save(s);
        return SUCCESS;
    }

    public String login(){
//        System.out.println(user);
        user.setPassword(MD5utils.md5(user.getPassword()));
        String res = userService.login(user);

        if(res != null){
            ActionContext.getContext().getSession().put("id", user.getId());
            ActionContext.getContext().getSession().put("role", user.getRole());
            return res;
        }

        return ERROR;
    }


}
