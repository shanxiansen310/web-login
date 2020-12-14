package dao.impl;

import dao.UserDao;
import domain.User;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDaoImpl implements UserDao {


    @Override
    public List<User> queryUsers() throws SQLException {
        String sql = "select * from users";
        List<User> userList = new ArrayList<>();

        MysqlDB mysqlDB = new MysqlDB();
        Connection connection = mysqlDB.getConn();
        Statement statement = null;
        ResultSet resultSet = null;

        try {
            statement = connection.createStatement();
            resultSet = statement.executeQuery(sql);

            /*查询数据库中的所有用户,并存放在list中保存为对象*/
            while (resultSet.next()) {
                /*创建新用户*/
                User user = new User();

                user.setName(resultSet.getString("userName"));
                user.setPassword(resultSet.getString("userPassword"));
                user.setPhoneNum(resultSet.getString("userPhoneNum"));

                userList.add(user);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            resultSet.close();
            statement.close();
            connection.close();
        }
        return userList;
    }

    @Override
    public void addUser(User user) throws Exception {
        /*建议用StringBuffer,使用String会导致内存被占用太多!!!*/
        StringBuffer sql=new StringBuffer("insert into users(userName," +
                "userPassword,userPhoneNum) values(");
        sql.append("'"+user.getName()+"',");
        sql.append("'"+user.getPassword()+"',");
        sql.append("'"+user.getPhoneNum()+"'");
        sql.append(")");

        MysqlDB mysqlDB = new MysqlDB();
        Connection connection = mysqlDB.getConn();
        Statement statement = null;

        try {
            //创建一个 Statement 对象，封装 SQL 语句发送给数据库，通常用来执行不带参数的 SQL 语句。
            statement = connection.createStatement();
            //这是dml语句不能用executeQuery
            statement.execute(sql.toString());

            /*查询数据库中的所有用户,并存放在list中保存为对象*/

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            statement.close();
            connection.close();
        }
    }

    @Override
    public boolean updateUser(User user) throws Exception {
        int result=0;   //result表示DML操作影响的行数,初始值为0
        String sql="update users set userPassword = ? , userPhoneNum = ?" +
                "where userName= ?";

        MysqlDB mysqlDB=new MysqlDB();
        Connection connection= mysqlDB.getConn();
        PreparedStatement preparedStatement=null;
        try {
            preparedStatement=connection.prepareStatement(sql);
            preparedStatement.setString(1,user.getPassword());
            preparedStatement.setString(2,user.getPhoneNum());
            preparedStatement.setString(3,user.getName());

            result=preparedStatement.executeUpdate();
            System.out.println("UserDao updateUser:modify "+ result);

        }catch (Exception e){
            e.printStackTrace();
            return false;
        }finally {
            preparedStatement.close();
            connection.close();
        }
        if (result == 1) {  //只修改一个用户的密码,故只会影响到一行
            return true;
        }else {
            return false;
        }
    }

    @Override
    public boolean deleteUser(String username) throws Exception {
        int result=0;   //result表示DML操作影响的行数,初始值为0
        String sql="delete from users where userName= ?";

        MysqlDB mysqlDB=new MysqlDB();
        Connection connection= mysqlDB.getConn();
        PreparedStatement preparedStatement=null;
        try {
            preparedStatement=connection.prepareStatement(sql);
            preparedStatement.setString(1,username);

            result=preparedStatement.executeUpdate();
            System.out.println("UserDao delete:modify "+ result);

        }catch (Exception e){
            e.printStackTrace();
            return false;
        }finally {
            preparedStatement.close();
            connection.close();
        }
        if (result == 1) {  //只修改一个用户的密码,故只会影响到一行
            return true;
        }else {
            return false;
        }

    }

    @Override
    public boolean modifyPassword(User user, String newPassword) throws SQLException {
        /*不进行判断是否存在用户或者密码是否匹配,单纯提供用户名进行修改密码,验证在servlet进行*/
        int result=0;   //result表示DML操作影响的行数,初始值为0
        String sql="update users set userPassword = ? where userName= ?";

        MysqlDB mysqlDB=new MysqlDB();
        Connection connection= mysqlDB.getConn();
        PreparedStatement preparedStatement=null;
        try {
            preparedStatement=connection.prepareStatement(sql);
            preparedStatement.setString(1,newPassword);
            preparedStatement.setString(2,user.getName());

            result=preparedStatement.executeUpdate();
            System.out.println("UserDao:modify "+ result);

        }catch (Exception e){
            e.printStackTrace();
            return false;
        }finally {
            preparedStatement.close();
            connection.close();
        }
        if (result == 1) {  //只修改一个用户的密码,故只会影响到一行
            return true;
        }else {
            return false;
        }

    }

    @Override
    public User findUser(User user) throws Exception {
        User u=new User();
        String sql = "select * from users where userName = ?";
//        List<User> userList=new ArrayList<>();

        MysqlDB mysqlDB = new MysqlDB();
        Connection connection = mysqlDB.getConn();
        PreparedStatement preStatement=null;
        ResultSet resultSet = null;

        try {
            preStatement=connection.prepareStatement(sql);    //进行预编译和缓存
            preStatement.setString(1,user.getName());  //设置参数

            /*execute @return either
             * (1) the row count for SQL Data Manipulation Language (DML) statements
             * or (2) 0 for SQL statements that return nothing*/

            resultSet=preStatement.executeQuery();    //获取查询结果

            /* 查询数据库中是否存在该用户,存在则返回该用户 */
            if (resultSet.next()) {
                System.out.println("UserDaoImpl: 用户\" "+user.getName()+"\" 存在!!!");
                u.setName(resultSet.getString("userName"));
                u.setPassword(resultSet.getString("userPassword"));
                u.setPhoneNum(resultSet.getString("userPhoneNum"));
                return u;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            preStatement.close();
            connection.close();
        }

        return null;
    }
}

