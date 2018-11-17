package service;

import entity.User;
import org.apache.http.entity.ContentType;
import org.springframework.mock.web.MockMultipartFile;
import org.springframework.web.multipart.MultipartFile;
import utils.ExcelUtils;
import utils.MD5utils;

import java.io.File;
import java.io.FileInputStream;
import java.util.List;

public class TeacherServiceImpl implements TeacherService {
    @Override
    public Boolean addStudent() throws Exception{
        File file = new File("java.xlsx");
        MultipartFile mulFile = new MockMultipartFile("java.xlsx", "java.xlsx",
                ContentType.APPLICATION_OCTET_STREAM.toString(), new FileInputStream(file));
        List<List<String[]>> studentSheets = ExcelUtils.readExcel(mulFile);
        for(List<String[]> sheet : studentSheets){
            // 检查表字段
            // 必须有名字和班级，可以没有密码，则默认与ID相同
            int nameIndex = -1;
            int passwordIndex = -1;
            int classIndex = -1;
            String[] strings = sheet.get(0);
            for(int i = 0; i < strings.length; i++){
                switch (strings[i]){
                    case "name":
                        nameIndex = i;
                        break;
                    case "password":
                        passwordIndex = i;
                        break;
                    case "class":
                        classIndex = i;
                        break;
                    default:
                        break;
                }
            }


            if(nameIndex == -1 || classIndex == -1){
                return false;
            }

            for(int i = 1; i < sheet.size(); i++){
                String[] student = sheet.get(i);
                User user = new User();
                user.setId(IDGenerator());
                user.setName(student[nameIndex]);

                if(passwordIndex == -1){
                    user.setPassword(MD5utils.md5(user.getId()));
                }else{
                    user.setPassword(MD5utils.md5(student[passwordIndex]));
                }

                user.setClassNo(student[classIndex]);
                user.setRole(User.STUDENT);
            }
        }

        return true;
    }

    private static String IDGenerator(){
        return "1234567890";
    }
}
