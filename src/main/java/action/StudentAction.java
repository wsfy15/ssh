package action;

import entity.Student;
import service.StudentService;

public class StudentAction {
    private StudentService studentService;

    public void setStudentService(StudentService studentService) {
        this.studentService = studentService;
    }

    public String add(){
        Student s = new Student();
        s.setId(100);
        s.setName("小明");
        s.setPasswd("123");
        this.studentService.add(s);
        return "success";
    }
}
