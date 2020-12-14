package servlet;


import domain.User;
import service.UserService;
import service.impl.UserServiceImpl;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "LoginServlet", urlPatterns = "/loginServlet")
public class LoginServlet extends HttpServlet {

    private User userDB;       //数据库查询得到的用户,可能为null
    private User userTemp;     //临时用户
    private UserService userService=new UserServiceImpl();


    @Override
    public void init(ServletConfig config) throws ServletException {
        System.out.println("init() called");
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("LoginServlet doGet");
//        req.getRequestDispatcher("/WEB-INF/success.jsp").forward(req,resp);

        /*初始化userTemp 和 userDB */
        userTemp=new User();
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
            //jsp实现的提示,每次都要刷新页面,故放弃改用ajax
//            req.setAttribute("error","The user doesn't exist!");
//            req.getRequestDispatcher("/login.jsp").forward(req,resp);
            System.out.println("用户不存在!");
            printWriter.write("{\"status\":1}");

        }else {  //存在该用户
            if (! (userDB.getPassword().equals(userTemp.getPassword())) ){  //密码不匹配
//                req.setAttribute("isTrue",true);
                System.out.println("LoginServlet: 输入密码错误!!!");
//                req.setAttribute("error","wrong password!");
//                req.getRequestDispatcher("/login.jsp").forward(req,resp);
                printWriter.write("{\"status\":2}");


            }else {  //存在该用户且密码匹配
                System.out.println("登陆成功!");

                if (userDB.getName().equals("admin")) { //系统管理员
                    printWriter.write("{\"status\":3}");

//                    req.getRequestDispatcher("/userServlet").forward(req, resp);
                }
                else {   //普通用户
                    printWriter.write("{\"status\":4}");

//                    req.getRequestDispatcher("/WEB-INF/success.jsp").forward(req, resp);
                }

            }

        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("LoginServlet doPost");
        doGet(req,resp);

    }







}
