package service.impl;

import dao.UserDao;
import dao.impl.UserDaoImpl;
import domain.User;
import service.UserService;

import java.io.Serializable;
import java.sql.SQLException;
import java.util.List;

public class UserServiceImpl implements UserService {

    /*在简单的项目中DAO基本上和service差不多,但我这里区别一下
    * 不过service中还是主要调用DAO中的方法*/
    UserDao userDao=new UserDaoImpl();

    @Override
    public List<User> queryUsers() throws SQLException{
        return  userDao.queryUsers();    //调用DAO层方法来返回
    }

    @Override
    public Boolean updateUser(User user) throws Exception {
        return userDao.updateUser(user);
    }

    @Override
    public boolean deleteUser(String userName) throws Exception {
        return userDao.deleteUser(userName);
    }

    @Override
    public void register(User user) throws Exception {
       userDao.addUser(user);
    }

    @Override
    public User findUser(User user) throws Exception {
        User DBUser=userDao.findUser(user);    //找到则返回该用户,找不到返回null
        return DBUser;

    }

    @Override
    public Boolean modifyPassword(User user, String newPassword) throws SQLException {
        return userDao.modifyPassword(user,newPassword);
    }

    @Override
    public void addUser(User user) throws Exception {
        userDao.addUser(user);
    }
}
