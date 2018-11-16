package excel;


import org.apache.http.entity.ContentType;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.mock.web.MockMultipartFile;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
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
        MultipartFile mulFile = new MockMultipartFile("java.xlsx", "java.xlsx",
                ContentType.APPLICATION_OCTET_STREAM.toString(), new FileInputStream(file));
        List<String[]> strings = ExcelUtils.readExcel(mulFile);
        for(String[] strings1:strings){
            for(String s : strings1){
                System.out.print(s);
            }
            System.out.println();
        }

//        obj.testLog();
    }

    private void readExcel(File file) throws Exception{
        // 读取Excel模板
        XSSFWorkbook wb = new XSSFWorkbook(file);
        // 读取了模板内sheet的内容
        XSSFSheet sheet = wb.getSheetAt(0);
        // 在相应的单元格进行（读取）赋值 行列分别从0开始
        XSSFCell cell = sheet.getRow(1).getCell(1);
        cell.setCellValue("张三");
        // 修改模板内容导出新模板
        FileOutputStream out = new FileOutputStream("C:\\Users\\passwdIs123\\Desktop\\java2.xlsx");
        // 关闭相应的流
        wb.write(out);
        out.close();
        wb.close();
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
}