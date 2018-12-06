package action;

import com.alibaba.fastjson.JSONArray;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;
import com.opensymphony.xwork2.util.ValueStack;
import entity.User;
import org.apache.commons.io.FileUtils;
import org.apache.struts2.ServletActionContext;
import org.slf4j.Logger;
import service.AdminService;
import utils.ExcelUtils;
import utils.FastJsonUtil;
import utils.LogUtils;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class AdminAction extends ActionSupport implements ModelDriven<User> {
    private static Logger logger = LogUtils.getLogger();

    AdminService adminService;

    public AdminService getAdminService() {
        return adminService;
    }

    public void setAdminService(AdminService adminService) {
        this.adminService = adminService;
    }

    public String getAllClass(){
        List<String> list = adminService.getAllClass();
        String jsonString = FastJsonUtil.toJSONString(list);
        HttpServletResponse response = ServletActionContext.getResponse();
        FastJsonUtil.writeJson(response, jsonString);

        logger.debug("finish getAllClass");
        return NONE;
    }

    public String add(){
        // 根据role判断添加何种用户，有什么属性
        HttpServletRequest request = ServletActionContext.getRequest();
        Map<String, String[]> params = request.getParameterMap();
        String role = (String) params.get("role")[0];
        logger.debug("role: {}", role);
        String name = user.getName();
        logger.debug("name: {}", name);
        String password = user.getPassword();
        logger.debug("password: {}", password);

        List<String> list = new ArrayList<>();
        list.add(name);
        list.add(password);

        String id;
        switch (role){
            case "student":
                String classNo = params.get("class")[0];
                list.add(classNo);
                id = adminService.save(list, User.STUDENT);
                break;
            case "teacher":
                id = adminService.save(list, User.TEACHER);
                break;
            case "admin":
                id = adminService.save(list, User.ADMIN);
                break;
            default:
                return ERROR;
        }

        user.setId(id);

        List<User> newUser = new ArrayList<>();
        newUser.add(user);

        ServletActionContext.getRequest().setAttribute("newUser", JSONArray.toJSONString(newUser));
//        ValueStack valueStack = ActionContext.getContext().getValueStack();
//        valueStack.set("newUser", newUser);
        return "add";
    }

    public String addByExcel(){
        if(uploadFileName != null){
            // 打印
            System.out.println("文件类型：" + uploadContentType);

            String path = "E:\\javaProject\\files\\" + uploadFileName;
            logger.debug("save path: {}", path);
            // 创建file对象
            File file = new File(path);
            if(file.exists()){
                file.delete();
            }

            try {
                FileUtils.copyFile(upload, file);

                Map<String, String[]> params = ServletActionContext.getRequest().getParameterMap();
                String role = (String) params.get("role")[0];

                List<List<String[]>> userSheets = ExcelUtils.readExcel(path);
                List<User> users = adminService.saveMulti(userSheets, role);
                if(users == null){
                    return ERROR;
                }
//                for(User u : users){ System.out.println(u); }

                ServletActionContext.getRequest().setAttribute("newUser", JSONArray.toJSONString(users));
//                ValueStack valueStack = ActionContext.getContext().getValueStack();
//                valueStack.set("newUser", users);
                return "add";
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        return ERROR;
    }

    private User user = new User();
    @Override
    public User getModel() {
        return user;
    }

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

}
