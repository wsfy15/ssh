package dao;

import entity.User;


public class UserDaoImpl extends BaseDaoImpl<User> implements UserDao {

    @Override
    public String getPassword(String id) {
        User user = (User)this.findById(id);
        if(user != null){
            return user.getPassword();
        }
        return null;
    }
}
