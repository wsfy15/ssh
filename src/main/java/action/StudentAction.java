package action;

import com.opensymphony.xwork2.ModelDriven;
import entity.Student;
import service.StudentService;

public class StudentAction implements ModelDriven<Student> {
    private StudentService studentService;
    private Student student;

    public void setStudentService(StudentService studentService) {
        this.studentService = studentService;
    }

    public String add(){
        Student s = new Student();
        s.setId(200);
        s.setName("小明");
        s.setPasswd("123");
        this.studentService.add(s);
        return "success";
    }

    @Override
    public Student getModel() {
        return student;
    }
}
