package service;

import dao.StudentDao;
import entity.Student;
import org.springframework.transaction.annotation.Transactional;

@Transactional
public class StudentServiceImpl implements StudentService {
    private StudentDao studentDao;

    public void setStudentDao(StudentDao studentDao) {
        this.studentDao = studentDao;
    }

    @Override
    public void add(Student s) {
        this.studentDao.add(s);
    }
}
