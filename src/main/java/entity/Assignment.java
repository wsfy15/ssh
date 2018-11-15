package entity;

import java.util.Date;

/**
 * @ClassName Assignment
 * @Description TODO
 * Author sf
 * Date 18-11-15 下午10:22
 * @Version 1.0
 **/
public class Assignment {
    private String as_id;
    private String as_name;     // 作业名称
    private String as_describe; // 作业简介
    private Date as_ddl; // 作业截至时间
    private Date as_assigntime;  // 作业布置时间
    private String as_co_id;    // 相关课程的作业
    private Integer as_proportion;  // 作业所占比例 1 ~ 100
}
