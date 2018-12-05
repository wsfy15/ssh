package interceptor;

import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.MethodFilterInterceptor;
import entity.User;
import org.apache.struts2.ServletActionContext;

/**
 * @ClassName TeacherInterceptor
 * @Description 进行教师相关的操作前,判断教师是否已经登录
 * Author sf
 * Date 18-11-29 下午7:19
 * @Version 1.0
 **/
public class TeacherInterceptor extends MethodFilterInterceptor {
    @Override
    protected String doIntercept(ActionInvocation actionInvocation) throws Exception {
        User user = (User) ServletActionContext.getRequest().getSession().getAttribute("user");
        String id = user.getId();
        if(id == null){
            return "login";
        }
        return actionInvocation.invoke();
    }
}
