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
import java.util.List;


/* 通过验证码对密码进行修改 */
@WebServlet(name = "Val",urlPatterns = "/valModify")
public class PhoneValServlet extends HttpServlet {
    private UserService userService=new UserServiceImpl();


    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req,resp);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User user=null;
        String phoneNum;
        String newPsd;
        PrintWriter printWriter=resp.getWriter();   //向客户端输出json数据
        phoneNum=req.getParameter("phoneNum");
        newPsd=req.getParameter("newPsd");

        if (phoneNum==null){   //按常理来说不该为null,但万一有什么意外呢
            printWriter.write("{\"status\":0}");
        }
        else {        //进行密码的修改
            /*找到对应手机号码的用户*/
            try {
                List<User> userList=userService.queryUsers();
                for (User u:userList) {
                    if (u.getPhoneNum().equals(phoneNum)){
                        user=u;
                    }
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }

            if (user==null){
                printWriter.write("{\"status\":0}");
            }
            else {

                try {
                    if (userService.modifyPassword(user,newPsd)){
                        //表示修改成功!!!
                        printWriter.write("{\"status\":1}");
                    }else {
                        //修改不成功!!! 数据库处理的问题
                        printWriter.write("{\"status\":0}");
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                }

            }


        }


//        resp.getWriter().write("modify");
        //req.getRequestDispatcher("/WEB-INF/modify.jsp").forward(req,resp);
    }


}
