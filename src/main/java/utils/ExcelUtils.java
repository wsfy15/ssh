package utils;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.slf4j.Logger;
import org.springframework.web.multipart.MultipartFile;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.FileNotFoundException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

public class ExcelUtils {
    private static Logger logger  = LogUtils.getLogger();
    private final static String xls = "xls";
    private final static String xlsx = "xlsx";

    /**
     * 读入excel文件，解析后返回
     * @param file
     * @return List<List<String[]> >  最外层每个list表示每个sheet，里层的list表示一行数据
     * @throws IOException
     */
    public static List<List<String[]> > readExcel(String path) throws IOException {
        //检查文件
        checkFile(path);
        logger.info("check file {} success", path);

        //获得Workbook工作薄对象
        Workbook workbook = getWorkBook(path);

        //创建返回对象，把每行中的值作为一个数组，所有行作为一个集合返回

        List<List<String[]> > lists = new ArrayList<>();
        if(workbook != null){
            for(int sheetNum = 0; sheetNum < workbook.getNumberOfSheets();sheetNum++){
                List<String[]> list = new ArrayList<>();
                //获得当前sheet工作表
                Sheet sheet = workbook.getSheetAt(sheetNum);
                if(sheet == null){
                    continue;
                }

                //获得当前sheet的 开始行 和 结束行
                int firstRowNum  = sheet.getFirstRowNum();
                int lastRowNum = sheet.getLastRowNum();
                logger.info("first row:{} last row: {}", firstRowNum, lastRowNum);

                //获得表头的 开始列 和 列数
                int firstCellNum = sheet.getRow(firstRowNum).getFirstCellNum();
                int cellCount = sheet.getRow(firstRowNum).getPhysicalNumberOfCells();

                //循环所有行，第一行表示字段名
                for(int rowNum = firstRowNum;rowNum <= lastRowNum; rowNum++){
                    //获得当前行
                    Row row = sheet.getRow(rowNum);
                    if(row == null){
                        continue;
                    }

                    logger.info("first col:{} last col: {}", firstCellNum, cellCount + firstCellNum);
                    //循环当前行的每一列
                    String[] cells = new String[cellCount];
                    for(int cellNum = 0; cellNum < cellCount; cellNum++){
                        Cell cell = row.getCell(cellNum + firstCellNum);
                        String value = getCellValue(cell);
                        cells[cellNum] = value.length() == 0 ? "" : value;
                        logger.debug(cells[cellNum]);
                    }
                    list.add(cells);
                }

                lists.add(list);
            }
            workbook.close();
        }
        return lists;
    }

    /**
     * 判断文件是否存在，是否以xls或xlsx结尾
     * @param file
     * @throws IOException
     */
    private static void checkFile(String path) throws IOException{
        //判断文件是否存在
        if(null == path){
            logger.error("文件不存在！");
            throw new FileNotFoundException("文件不存在！");
        }

        //判断文件是否是excel文件
        if(!path.endsWith(xls) && !path.endsWith(xlsx)){
            logger.error(path + "不是excel文件");
            throw new IOException(path + "不是excel文件");
        }
    }

    private static Workbook getWorkBook(String path) {
        //获得文件名
        //String fileName = file.getOriginalFilename();
        //创建Workbook工作薄对象，表示整个excel
        Workbook workbook = null;
        try {
            //获取excel文件的io流
            //InputStream is = file.getInputStream();
            InputStream is = new FileInputStream(path);
            //根据文件后缀名不同(xls和xlsx)获得不同的Workbook实现类对象
            if(path.endsWith(xls)){
                //2003
                workbook = new HSSFWorkbook(is);
            }else if(path.endsWith(xlsx)){
                //2007
                workbook = new XSSFWorkbook(is);
            }
        } catch (IOException e) {
            logger.info(e.getMessage());
        }
        return workbook;
    }

    private static String getCellValue(Cell cell){
        String cellValue = "";
        if(cell == null){
            return cellValue;
        }
        //把数字当成String来读，避免出现1读成1.0的情况
        if(cell.getCellType() == CellType.NUMERIC){
            cell.setCellType(CellType.STRING);
        }
        //判断数据的类型
        switch (cell.getCellType()){
            case NUMERIC: //数字
                cellValue = String.valueOf(cell.getNumericCellValue());
                break;
            case STRING: //字符串
                cellValue = String.valueOf(cell.getStringCellValue());
                break;
            case BOOLEAN: //Boolean

                cellValue = String.valueOf(cell.getBooleanCellValue());
                break;
            case FORMULA: //公式
                cellValue = String.valueOf(cell.getCellFormula());
                break;
            case BLANK: //空值
                cellValue = "";
                break;
            case ERROR: //故障
                cellValue = "非法字符";
                break;
            default:
                cellValue = "未知类型";
                break;
        }
        return cellValue;
    }
}
