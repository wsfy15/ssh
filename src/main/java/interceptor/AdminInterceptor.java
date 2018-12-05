package interceptor;

import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.MethodFilterInterceptor;
import entity.User;
import org.apache.struts2.ServletActionContext;

/**
 * @ClassName AdminInterceptor
 * @Description 进行管理员相关的操作前,判断管理员是否已经登录
 * Author sf
 * Date 18-11-29 下午7:19
 * @Version 1.0
 **/
public class AdminInterceptor extends MethodFilterInterceptor {
    @Override
    protected String doIntercept(ActionInvocation actionInvocation) throws Exception {
        User user = (User) ServletActionContext.getRequest().getSession().getAttribute("user");
        if(user == null || !user.getId().startsWith("1000")){
            return "login";
        }
        return actionInvocation.invoke();
    }
}
