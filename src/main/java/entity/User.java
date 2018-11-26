package entity;

import java.util.Set;

public class User {
    public static final Integer ADMIN = 0;
    public static final Integer TEACHER = 1;
    public static final Integer STUDENT = 2;

    private String id;      // 学号/教工号
    private String name;    // 姓名
    private String password;  // 密码


    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }



    @Override
    public String toString(){
        return "id: " + this.id + "\npasswd: " + this.password + "\nname: " + this.name;
    }
}
