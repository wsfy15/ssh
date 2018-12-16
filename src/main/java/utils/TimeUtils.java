package utils;

import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class TimeUtils {
    public static Timestamp strToTimestamp(String str, String pattern){
        DateFormat df = new SimpleDateFormat(pattern); //"yyyy-MM-dd HH:mm:ss"
        Date date = null;
        try {
            date = df.parse(str);
        } catch (ParseException e) {
            e.printStackTrace();
        }

        return new Timestamp(date.getTime());
    }
}
