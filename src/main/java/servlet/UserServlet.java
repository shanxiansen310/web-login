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
import java.sql.SQLException;
import java.util.List;

@WebServlet (name = "userServlet" ,urlPatterns = "/userServlet")
public class UserServlet extends HttpServlet {

    @Override
    public void init(ServletConfig config) throws ServletException {
        super.init(config);
        System.out.println(getServletContext().getContextPath());
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req,resp);

    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        UserService userService=new UserServiceImpl();
        String userName=req.getParameter("userName");
        PrintWriter printWriter = resp.getWriter();

        /*根据ajax传来的request进行相关的操作*/
        String type=req.getParameter("type");
        System.out.println("type:"+type);
        try {
            switch (type) {
                case "1":  //添加用户
                    User user=new User();
                    user.setName(req.getParameter("userName"));
                    user.setPassword(req.getParameter("userPsd"));
                    user.setPhoneNum(req.getParameter("userPhoneNum"));

                    /*使用service中的方法添加用户*/
                    userService.addUser(user);
                    //添加完用户后再次进入该页面,并通过type=0进入default中
                    req.getRequestDispatcher("/userServlet?type=0").forward(req,resp);

                    break;
                case "2":  //修改用户 update
                    User upUser=new User();
                    upUser.setName(req.getParameter("userName"));
                    upUser.setPassword(req.getParameter("userPsd"));
                    upUser.setPhoneNum(req.getParameter("userPhoneNum"));

                    boolean isUpdated=userService.updateUser(upUser);
                    if (!isUpdated) {
                        printWriter.write("update failed!");
                        Thread.sleep(2000);
                        /*虽然失败了还是要返回的啊!!!*/
                    }
                    req.getRequestDispatcher("/userServlet?type=0").forward(req,resp);
                    break;

                case "3":  //删除用户
                    userName=req.getParameter("userName");

                    boolean isDeleted=userService.deleteUser(userName);
                    if (!isDeleted) {
                        printWriter.write("delete failed!");
//                        Thread.sleep(2000);
                        /*虽然失败了还是要返回的啊!!!*/
                    }
                    req.getRequestDispatcher("/userServlet?type=0").forward(req,resp);

                    break;
                case "4":   //验证是否用户名重复
                    User userTemp = new User();
                    System.out.println("userServlet:"+userName);
                    userTemp.setName(userName);
                    System.out.println("case 4!!!");

                    User serviceUser = userService.findUser(userTemp);
                    if (serviceUser==null){    /* 1不存在重复 2存在重复 */
                        System.out.println("userServlet:不重复");
                        resp.getWriter().print("1");   //对ajax输出返回值
                    }else {
                        System.out.println("userServlet:重复");
                        resp.getWriter().print("2");
                    }

                    break;

                default:
                    /*简单的对该页面进行保护!!!*/
                    if (userName!=null) {
                        try {
                            List<User> list = userService.queryUsers();

                            req.setAttribute("userList", list);
                            req.getRequestDispatcher("/WEB-INF/userList.jsp").forward(req, resp);
                        } catch (SQLException e) {
                            e.printStackTrace();
                        }
                    }
                    else {
                        printWriter.write("404: Not Found!!!");
                    }
//                    break;
            }
        }
         catch (Exception e) {
                e.printStackTrace();
        }



    }

}
