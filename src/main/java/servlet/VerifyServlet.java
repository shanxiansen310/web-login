package servlet;

import com.aliyuncs.exceptions.ClientException;
import domain.User;
import service.UserService;
import service.impl.UserServiceImpl;
import utils.AliyunSmsUtils;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

@WebServlet(name = "Verify", urlPatterns = "/verify")
public class VerifyServlet extends HttpServlet {

    String requestType;
    String phoneNum;
    String verifyCode;     //用户输入的code

    String servletCode;    //服务器端生产的code

    @Override
    public void init(ServletConfig config) throws ServletException {
        System.out.println("VerifyServlet init()");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req,resp);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        PrintWriter printWriter=resp.getWriter();
        UserService userService=new UserServiceImpl();

        requestType=req.getParameter("requestType");
        /*发送验证码*/
        if (requestType.equals("send")){
            phoneNum = req.getParameter("phoneNum");
            boolean isExistNum=false;

            try {
                /*得到所有用户的信息,这里因为数据少所以这么写
                * 如果大量数据则应该在DAO中创建按号码搜索的接口*/
                List<User> list=userService.queryUsers();
                for (User u:list) {
                    if (u.getPhoneNum().equals(phoneNum))
                        isExistNum=true;
                }

            } catch (SQLException e) {
                e.printStackTrace();
            }

            /*存在该手机号*/
            if (isExistNum) {

                //设置随机验证码
                Random random = new Random();
                servletCode = String.valueOf(random.nextInt(9000) + 1000);  //每次调用生成一位四位数的随机数
                try {
                    if (AliyunSmsUtils.sendCode(phoneNum, servletCode)) {  //发送成功!!!
                        printWriter.write("{\"status\":1}");
                    } else {    //发送失败
                        printWriter.write("{\"status\":0}");
                    }
                } catch (ClientException e) {
                    e.printStackTrace();
                    printWriter.write("{\"status\":0}");
                }
            }
            /*不存在改手机号(不提供注册功能)*/
            else {
                printWriter.write("{\"status\":9}");
            }

        }


        /*验证用户输入的验证码是否和系统发送的匹配*/
        else if (requestType.equals("verify")){
            verifyCode =req.getParameter("verifyCode");


            if (verifyCode.equals(servletCode)){
                printWriter.write("{\"verifyStatus\":1}");   //匹配成功
            }else {
                printWriter.write("{\"verifyStatus\":0}");   //匹配失败
            }

            //printWriter.write("{\"verifyStatus\":1}");   //匹配成功
        }

    }

    @Override
    public void destroy() {
        System.out.println("verifyServlet destroy()");
    }
}
