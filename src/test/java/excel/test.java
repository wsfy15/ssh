package excel;


import dao.CourseDao;
import dao.CourseDaoImpl;
import org.apache.http.entity.ContentType;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.mock.web.MockMultipartFile;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import service.TeacherService;
import service.TeacherServiceImpl;
import sun.reflect.Reflection;
import utils.ExcelUtils;
import utils.LogUtils;


import java.io.*;
import java.util.List;


public class test {
    //private static Logger logger = LoggerFactory.getLogger(test.class); // 参数的目的：追踪产生此日志的类.
    private static Logger logger = LogUtils.getLogger();


    public static void main(String[] args) throws Exception{
        test obj = new test();
        File file = new File("C:\\Users\\passwdIs123\\Desktop\\java.xlsx");
//        MultipartFile mulFile = new MockMultipartFile("java.xlsx", "java.xlsx",
//                ContentType.APPLICATION_OCTET_STREAM.toString(), new FileInputStream(file));
//        List<List<String[]>> lists = ExcelUtils.readExcel(mulFile);
//        for(List<String[]> list : lists){
//            for(String[] s : list){
//                System.out.println(s.toString());
//            }
//        }

//        obj.testLog();
    }

    private void testLog() {
        logger.trace("log4j2 Demo");
        // 记录debug级别的信息
        logger.debug("This is debug message.");
        // 记录info级别的信息
        logger.info("This is info message.");
        // 记录error级别的信息
        logger.error("This is error message.");
    }

    @Test
    public void count(){
        TeacherService teacherService = new TeacherServiceImpl();
        CourseDao courseDao = new CourseDaoImpl();
        ((TeacherServiceImpl) teacherService).setCourseDao(courseDao);
        System.out.println(teacherService.CourseIDGenerator());
    }
}