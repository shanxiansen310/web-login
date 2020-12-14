package dao.impl;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class MysqlDB {
    /* 连接数据库 */
    /* 如何得到一个connection */
    private final static String DB_DRIVER="com.mysql.cj.jdbc.Driver";
    private final static String DB_URL="jdbc:mysql://localhost:3306/testuser?useUnicode=true&characterEncoding=utf-8&serverTimezone=UTC";
    private final static String DB_USER="root";
    private final static String DB_PASSWD="123";

    public Connection getConn(){
        Connection connection=null;
        try {
            Class.forName(DB_DRIVER);        /*驱动*/
            connection= DriverManager.getConnection(DB_URL,DB_USER,DB_PASSWD);
        }catch (SQLException | ClassNotFoundException e){
            e.printStackTrace();
        }
        return connection;
    }
}
