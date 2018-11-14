package utils;

import java.util.UUID;

/**
 * @ClassName UploadUtils
 * @Description 传入文件名称，返回唯一的名称
 * Author sf
 * Date 18-10-25 下午8:59
 * @Version 1.0
 **/
public class UploadUtils {
    public static String getUUIDName(String fileName) {
        // 获得后缀名
        int index = fileName.lastIndexOf(".");
        fileName = fileName.substring(index, fileName.length());

        String uuid = UUID.randomUUID().toString().replace("-", "");

        return uuid + fileName;
    }
}
