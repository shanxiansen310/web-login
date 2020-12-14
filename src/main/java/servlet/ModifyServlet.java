package servlet;


import domain.User;
import service.UserService;
import service.impl.UserServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

/*进行密码修改,但要注意必须先验证是否存在该用户和用户密码是否匹配*/
@WebServlet(name = "Modify",urlPatterns = "/modify")
public class ModifyServlet extends HttpServlet {

    private User userDB;       //数据库查询得到的用户,可能为null
    private User userTemp;     //临时用户
    private UserService userService=new UserServiceImpl();
    private String newPassword;  //客户端有处理,能传过来的新密码是不可能为空的!!!

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req,resp);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("ModifyServlet doGet");

        /*初始化userTemp 和 userDB */
        userTemp=new User();
        newPassword=req.getParameter("newPassword");
        userTemp.setName(req.getParameter("userName"));  //从浏览器获取数据
        userTemp.setPassword(req.getParameter("userPassword"));

        try {
            userDB =userService.findUser(userTemp);
        } catch (Exception e) {
            e.printStackTrace();
        }

        /*登录!!!*/
        //匹配数据库中是否存在该用户,不存在则提示
        PrintWriter printWriter=resp.getWriter();

        if(userDB ==null){   //不存在该用户
            System.out.println("modify:用户不存在!");
            printWriter.write("{\"status\":1}");

        }else {  //存在该用户
            if (! (userDB.getPassword().equals(userTemp.getPassword())) ){  //密码不匹配
                System.out.println("modify: 输入密码错误!!!");
                printWriter.write("{\"status\":2}");

            }else {  //存在该用户且密码匹配
                System.out.println("modify:用户名与旧密码匹配!");

                /*将修改的密码存储到数据库*/
                try {
                    if (userService.modifyPassword(userTemp,newPassword)){
                        //表示修改成功!!!
                        printWriter.write("{\"status\":3}");
                    }else {
                        //修改不成功!!! 数据库处理的问题
                        printWriter.write("{\"status\":4}");
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                }

            }

        }

    }
}
