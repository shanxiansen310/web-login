<%--
  Created by IntelliJ IDEA.
  User: shanxiansen310
  Date: 2020/11/22
  Time: 11:16
  To change this template use File | Settings | File Templates.
--%>
<% String path = request.getContextPath(); %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="stylesheet" href="user/css/style.css" type="text/css">
    <script src="user/js/slider.js"></script>
    <title>csu-information</title>

    <link rel="icon" href="user/images/favor.ico" type="image/x-icon">
</head>

<body>
<div class="container">

    <div class="header">
        <div class="logo">
            <img src="user/images/spike4.jpg">
            <img src="user/images/spike3.jpg">
            <img src="user/images/faye2.jpg">
        </div>
    </div>

    <p id="motto">In the way of samurai</p>

    <div class="content">
        <div class="box">
            <div class="slides">
                <div class="slide-box">
                    <img src="user/images/slide1.jpg" alt="slide">
                    <img src="user/images/slide3.jpg" alt="slide">
                    <img src="user/images/faye.png" alt="slide">
                    <img src="user/images/gin.jpg" alt="slide">
                    <img src="user/images/slide1.jpg" alt="slide">
                </div>

                <ul class="dot-box">
                    <li class="active"></li>
                    <li></li>
                    <li></li>
                    <li></li>
                </ul>

            </div>

            <div class="login">

                <form class="form-list" id="form" method="post" action="<%=path%>/userServlet">

                    <%--告诉servlet该怎样操作--%>
                    <input type="hidden" name="type" value="0">
                    <span class="login-head">
                    Account Login
                    </span>

                    <div class="input-outline-x" data-validate="Type user name">
                        <input class="input-control input-outline" size="30" id="userName" name="userName"
                               placeholder="User name" required="required">
                        <label class="input-label">User name</label>
                    </div>

                    <div class="input-outline-x">
                        <input class="input-control input-outline" size="30" type="password" id="userPassword"
                               name="userPassword"
                               placeholder="Password" required="required">
                        <label class="input-label">Password</label>
                    </div>
                    <p id="error" style="height: 20px;color: firebrick;font-size: 16px"></p>


                    <div class="sign-in">
                        <button type="button" class="sign-in-button" name="signInButton"
                                onclick="loginCheck()" value="">
                            Sign in
                        </button>
                    </div>

                    <div class="forgot-bar" style="margin-bottom:18px; ">
                        <a id="login-phone" >
                            Login via mobile phone
                        </a>
                    </div>

                    <div class="forgot-bar">
                        <a id="forgot-tag" href="user/security.jsp">
                            Modify/Forgot password?
                        </a>
                    </div>
                    <div class="sign-up">
                        <a href="#" class="txt3">
                            Sign Up
                        </a>
                    </div>

                    <%-- 验证码登录 --%>
                    <div class="validation">
                        <span>Verification</span>

                        <form  method="post" action="<%=path%>/success">

                            <div class="false-box">
                                <div class="left"></div>
                                <div class="right"></div>
                            </div>

                            <div class="input-outline-x">
                                <input class="input-control input-outline" size="25" placeholder="Phone number"
                                       id="phoneNum" name="phoneNum" type="text" required="required">
                                <label class="input-label">Phone number</label>
                            </div>
                            <p id="errorPhoneNum" style="height: 20px;font-size: 16px;
                            color: firebrick;opacity: 0;"></p>
                            <button class="send-code" type="button" onclick="sendCode()">Send code</button>


                            <div class="input-outline-x">
                                <input class="input-control input-outline" size="25" placeholder="Verify code"
                                       id="codeNum" name="verifyCode" type="text" required="required">
                                <label class="input-label">Verification code</label>
                            </div>


                            <p id="errorCode" style="height: 20px;font-size: 16px;
                            color: firebrick;opacity: 0;"></p>

                            <button class="send-code" type="button" onclick="checkCode()">Commit</button>

                        </form>
                    </div>
                </form>



            </div>
        </div>
    </div>
</div>
</div>
</body>

</html>

<script>

    /*登陆验证*/
    function loginCheck() {
        let userName = document.getElementById("userName").value;
        let userPassword = document.getElementById("userPassword").value;
        let errorText=document.getElementById("error");
        let form=document.getElementById("form");
        ajax({
            type: "POST",
            url: "<%=path%>/loginServlet",
            dataType: "json",
            responseType:"json",
            data:{
                "userName":userName,
                "userPassword":userPassword
            } ,

            /*此处的ajax不进行before操作,故直接return true*/
            beforeSend: function (){
                return true;
            },

            success: function (response){
                /* 1表示用户不存在,2表示密码错误,3管理员登陆成功 4普通用户登录 */
                console.log(response["status"]);

                switch (response["status"]){
                    case 1:
                        errorText.style.opacity="1";
                        errorText.innerHTML="The user doesn't exist!";
                        setTimeout(function (){
                            errorText.style.transition=".6s"
                            errorText.style.opacity="0";
                        },3000);
                        break;
                    case 2:
                        errorText.style.opacity="1";
                        errorText.innerHTML="Wrong password!";
                        setTimeout(function (){
                            errorText.style.transition=".6s"
                            errorText.style.opacity="0";
                        },3000);
                        break;
                    case 3:
                        form.submit();
                        break;
                    case 4:
                        window.location.href="<%=path%>/success"
                        break;
                    default:
                        errorText.innerHTML="internal error!";

                }
            },
            error: function (){
                alert("error")
            }
        })
    }

    /* 发送验证码 */
    function sendCode(){
        let phoneNum=document.getElementById("phoneNum").value;
        let errorPhoneNum=document.getElementById("errorPhoneNum");

        ajax({
            type: "POST",
            url: "<%=path%>/verify",
            dataType: "json",
            responseType:"json",
            data:{
                "requestType":"send",
                "phoneNum":phoneNum
            },

            /*确保数据正确再发送*/
            beforeSend:function (){
                if (phoneNum===""){
                    errorPhoneNum.style.opacity="1";
                    errorPhoneNum.innerHTML="Please enter your phone number!";
                    setTimeout(function (){
                        errorPhoneNum.style.transition=".6s";
                        errorPhoneNum.style.opacity="0";
                    },3000);
                    return false;
                }
                else
                    return true;
            },

            success:function (response){
                console.log("verify:"+response["status"]);
                if (response["status"]===1){
                    errorPhoneNum.style.opacity="1";
                    errorPhoneNum.innerHTML="Send successfully! ";
                    setTimeout(function (){
                        errorPhoneNum.style.transition=".6s"
                        errorPhoneNum.style.opacity="0";
                    },3000);
                }

                else if (response["status"]===0){   //发送失败
                    errorPhoneNum.style.opacity="1";
                    errorPhoneNum.innerHTML="Failure! Please send again!";
                    setTimeout(function (){
                        errorPhoneNum.style.transition=".6s"
                        errorPhoneNum.style.opacity="0";
                    },3000);
                }
            },
            error:function (){
                alert("error");
            }


        })
    }

    /* 检验验证码 */
    function checkCode(){
        let codeNum=document.getElementById("codeNum").value;
        let errorCode=document.getElementById("errorCode");

        ajax({
            type: "POST",
            url: "<%=path%>/verify",
            dataType: "json",
            responseType:"json",
            data:{
                "requestType":"verify",
                "verifyCode":codeNum
            },

            beforeSend:function (){
                if (codeNum===""){
                    errorCode.style.opacity="1";
                    errorCode.innerHTML="Please enter received code!";
                    setTimeout(function (){
                        errorCode.style.transition=".6s";
                        errorCode.style.opacity="0";
                    },3000);
                    return false;
                }
                else
                    return true;  //继续进行下一步
            },
            success:function (response){
                if (response["verifyStatus"]===0){
                    errorCode.style.opacity="1";
                    errorCode.innerHTML="Mismatched! ";
                    setTimeout(function (){
                        errorCode.style.transition=".6s"
                        errorCode.style.opacity="0";
                    },3000);
                }
                else if (response["verifyStatus"]===1){  //登陆成功
                    window.location.href="<%=path%>/success";
                }
            },
            error:function (){
                alert("error");
            }


        });

    }


    /* 纯js实现ajax */
    function createXMLHttpRequest() {
        if (window.ActiveXObject) {
            return new ActiveXObject("Microsoft.XMLHTTP");
        } else if (window.XMLHttpRequest) {
            return new XMLHttpRequest();
        }
    }

    function ajax() {
        let ajaxData = {
            type: arguments[0].type || "GET",
            url: arguments[0].url || "",
            async: arguments[0].async || "true",
            data: arguments[0].data || null,
            dataType: arguments[0].dataType || "text",
            contentType: arguments[0].contentType || "application/x-www-form-urlencoded",
            responseType:arguments[0].responseType || "",
            beforeSend: arguments[0].beforeSend || function () {
            },
            success: arguments[0].success || function () {
            },
            error: arguments[0].error || function () {
            }
        }

        /*这里进行判断前后两次输入的密码是否一致,如果不一致则ajax停止*/
        if (!ajaxData.beforeSend()){
            return ;
        }


        let xhr = createXMLHttpRequest();
        xhr.responseType=ajaxData.responseType;
        xhr.open(ajaxData.type, ajaxData.url, ajaxData.async);
        xhr.setRequestHeader("Content-Type", ajaxData.contentType);
        xhr.send(convertData(ajaxData.data));
        console.log(typeof ajaxData.data);

        xhr.onreadystatechange = function () {
            if (xhr.readyState === 4) {
                if (xhr.status === 200) {
                    ajaxData.success(xhr.response)
                } else {
                    ajaxData.error()
                }
            }
        }

    }

    function convertData(data) {
        if (typeof data === 'object') {
            let convertResult = "";
            for (let c in data) {
                convertResult += c + "=" + data[c] + "&";
            }
            convertResult = convertResult.substring(0, convertResult.length - 1);
            return convertResult;
        } else {
            return data;
        }
    }



    //该模块移除,修改input的required属性更简洁!!!
    // function loginVerify(){
    //     let username=document.getElementById("userName").value;
    //     let password=document.getElementById("userPassword").value;
    //     let form=document.getElementById("form");
    //     if (username==''){
    //         alert("username is blank,please enter!")
    //         return ;
    //     }
    //     if (password==''){
    //         alert("password is blank,please enter!");
    //         return ;
    //     }
    //     //调用后端servlet,进行数据传递
    //     form.submit();
    // }

    /*忘记密码*/
    let forgot=document.getElementById("login-phone");
    let validation=document.getElementsByClassName("validation")[0];
    forgot.onclick=function (){
        validation.style.opacity="1";
        validation.style.zIndex="1";
    }

    let falseBox=document.getElementsByClassName("false-box")[0];
    falseBox.onclick=function (){
        validation.style.opacity="0"
        validation.style.zIndex="-1";
    }

</script>