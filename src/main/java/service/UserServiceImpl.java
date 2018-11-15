package service;

import dao.UserDao;
import entity.User;
import org.springframework.transaction.annotation.Transactional;
import utils.MD5utils;

@Transactional
public class UserServiceImpl implements UserService {
    private static final String[] roles = {"admin", "teacher", "student"};

    private UserDao userDao;

    public void setUserDao(UserDao userDao) {
        this.userDao = userDao;
    }

    @Override
    public void save(User s) {
        System.out.println(s);
        this.userDao.save(s);
    }

    @Override
    public String login(User s){
        String correctPassword = userDao.getPassword(s.getId());
        if (correctPassword != null && correctPassword.equals(s.getPassword())){
            User user = userDao.findById(s.getId());
            return roles[user.getRole()];
        }
        return null;
    }


}
