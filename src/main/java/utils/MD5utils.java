package utils;

import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

/**
 * @ClassName MD5utils
 * @Description TODO
 * Author sf
 * Date 18-11-14 下午4:19
 * @Version 1.0
 **/
public class MD5utils {
    public static String md5(String text) {
        byte[] encryptedBytes = null;
        try {
            encryptedBytes = MessageDigest.getInstance("md5").digest(text.getBytes());
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("没有md5这个算法！");
        }

        String md5code = new BigInteger(1, encryptedBytes).toString(16);// 16进制数字
        // 如果生成数字未满32位，需要前面补0
        for (int i = 0; i < 32 - md5code.length(); i++) {
            md5code = "0" + md5code;
        }
        System.out.println(md5code);
        return md5code;
    }
}
