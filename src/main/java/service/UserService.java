package service;

import domain.User;

import java.sql.SQLException;
import java.util.List;

public interface UserService {


    /**
     * 获取用户列表
     * @return 所有用户User组成的ArrayList
     * @throws SQLException   抛出sql异常
     */
    List<User> queryUsers() throws SQLException;

    /*增删改查*/
    Boolean updateUser(User user) throws Exception;
    boolean deleteUser(String userName) throws Exception;

    public void register(User user) throws Exception;

    /**
     * 查找是否存在该用户,不验证验证密码
     * @param user 由servlet传入用户创建的临时User对象
     * @return     由数据库查询得到的用户对象
     * @throws Exception 异常
     */
    public User findUser(User user) throws Exception;

    /**
     * 修改密码
     * @param user           要修改的用户
     * @param newPassword    新密码
     * @return 修改成功返回true ,否则返回false
     */
    public Boolean modifyPassword(User user,String newPassword) throws SQLException;

    /**
     * 添加用户
     * @param user  添加的用户
     * @throws Exception  e
     */
    void addUser(User user) throws Exception;

}
