package dao;

/* DAO (Data Access Objects 数据存取对象) */

import domain.User;

import java.sql.SQLException;
import java.util.List;

public interface UserDao {

    /**
    * @return all users in table "users"
    */
    public List<User> queryUsers() throws SQLException;

    /* 增删改查 */
    public void addUser(User user) throws Exception;

    public boolean updateUser(User user) throws Exception;

    public boolean deleteUser(String username) throws Exception;


    /**
     * 主要用于修改密码,不进行任何验证
     * @param user           要修改的用户
     * @param newPassword    新密码
     */
    public boolean modifyPassword(User user, String newPassword) throws SQLException;


    /**
     * 查找用户,查找数据库中是否存在某个用户,不进行密码验证,单纯查找是否存在某个用户
     * @param user  User对象,根据用户输入产生的
     * @return      找到-->返回该用户用于验证密码  没找到-->返回null
     * @throws Exception  异常
     */
    public User findUser(User user) throws Exception;


}
