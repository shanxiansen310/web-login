<%--
  Created by IntelliJ IDEA.
  User: shanxiansen310
  Date: 2020/11/23
  Time: 20:44
  To change this template use File | Settings | File Templates.
--%>
<% String path=request.getContextPath(); %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Security</title>

    <style type="text/css">
        * {
            padding: 0;
            margin: 0;
            font-family: "微软雅黑";
        }
        body{
            background-color: #f2f2f2 ;
        }

        .container{
            width: 100%;
            min-width: 1200px;
            /*height: 100px;*/
        }
        .header{
            height: 180px;
            overflow: hidden;
            background: whitesmoke;
        }
        .logo{
            float: left;
            /*margin-left: 50px;*/
            /*background-image: url("images/spike.jpg");*/
            /*background-size: 100%;*/
            /*width: 600px;*/
            height: 100%;
            width: 100%;

            /*background-repeat: repeat;*/
        }
        /*.logo img{*/
        /*    float: left;*/
        /*    width: 33.33%;*/
        /*    height: 200px;*/
        /*}*/

        #motto{
            font:35px "Trebuchet MS", Arial, Helvetica, sans-serif;
            background-color: lightgrey;
            text-align: center;
            color:black;
            opacity: .8;
        }

        .content{

            width: 100%;
            overflow: hidden;
            background-color: lightgray;
        }

        .box{
            position: relative;
            width: 65%;
            height: 600px;
            margin: 40px auto;
            /*border-radius: 45px;*/
            background-color: white;
            overflow: hidden;
        }

        .left{
            position: relative;
            float: left;
            width: 49.5%;
            height: 100%;
            /*margin-left: 40px;*/
            /*margin-top: 40px;*/
            /*background-color: grey;*/
            overflow: hidden;
            font-size: 0;    //消除img间隔
        }

        .split{
            position: absolute;
            width: 1px;
            height: 70%;
            left: 50%;
            top: 50%;
            transform: translateX(-50%) translateY(-50%);
            background: grey;

        }
        .right{
            position: relative;
            float: right;
            width: 49.5%;
            height: 100%;
            overflow: hidden;
            /*background: #3c415c;*/
        }

        .validation{
            /*position: absolute;*/
            position: relative;
            top: 50%;
            transform: translateY(-50%);
            min-width:250px ;      /*防止collapse*/
            height: 65%;
            bottom: 40%;
            width: fit-content;
            width: -moz-fit-content;
            margin: auto;
            text-align: center;
            border-radius: 20px;



            overflow: hidden;
        }

        .validation span{
            display: inline-block;
            margin-bottom: 10px;
            font-family: Arial, Helvetica, sans-serif;
            font-size: 20px;
            font-weight: bold;
            color: #5f5f5f;
            line-height: 35px;
            text-transform: uppercase
        }

        .validation .input-outline-x{
            margin-top: 10px;
            margin-bottom: 20px;
        }
        .validation .input-outline{
            border-color: darkgray;
        }
        .validation .input-outline:focus{
            border-color: black;
        }

        .send-code{
            background-color: grey;
            border: none;
            color: white;
            padding: 8px 25px;
            text-align: center;
            text-decoration: none;
            font-size: 15px;
            margin-bottom: 35px;
            cursor: pointer;
            border-radius: 10px;
            transition: .4s;
            outline: none;
        }
        .send-code:hover{
            background-color: #2c2a2c;
            transform: scale(1.1);
        }
        /* 外部容器宽度由输入框决定 */
        .input-outline-x{
            position: relative;        /*placeholder*/
            width: fit-content;
            width: -moz-fit-content;
            margin: 10px auto 20px;
        }

        .input-outline{
            padding: 10px 16px 10px;
            border:solid black;
            border-width: 2px 2px 2.5px 2px;
            border-radius: 20px;
            transition: border-color .55s;
        }
        .input-outline:focus{
            border-color: coral;
            outline: none;
        }
        /* 默认placeholder颜色透明不可见 */
        .input-control:placeholder-shown::placeholder {
            color: transparent;
        }

        .input-label {
            position: absolute;  /*相对input-outline-x*/
            font-size: 16px;
            line-height: 1.5em;
            left: 10%; top: 20%;
            color: #a2a9b6;
            padding: 0 2px;
            transform-origin: 0 0;
            pointer-events: none;
            transition: all .25s;
        }
        /* 线框样式label定位 */
        .input-control:not(:placeholder-shown) ~ .input-label,
        .input-control:focus ~ .input-label {
            /*color: #2486ff;*/
            background-color: transparent;
            transform: scale(0.75) translate(-2px, -32px);
        }

        /* 提示框 */
        .attention{
            position: absolute;
            width: 50%;
            min-width:280px ;       /*防止collapse*/
            height: 60%;
            bottom: 30%;
            border-radius: 20px;
            left: 50%;
            transform: translateX(-50%);
            background-color: #cfd5d0;
            transition: .5s;
            /*text-align: center;*/
            opacity: 0;
            overflow: hidden;
            z-index: -2;
        }

        /*通过验证码修改密码*/
        #valModify{
            position: absolute;
            width: 50%;
            min-width:280px ;       /*防止collapse*/
            height: 47%;
            bottom: 35%;
            border-radius: 20px;
            left: 50%;
            transform: translateX(-50%);
            background-color: #cfd5d0;
            transition: .5s;
            text-align: center;
            opacity: 0;
            overflow: hidden;
            z-index: -2;
        }

        #valModify span{
            display: inline-block;
            margin-left: 6px;
            font-family: Arial, Helvetica, sans-serif;
            font-size: 20px;
            font-weight: bold;
            color: #5f5f5f;
            line-height: 35px;
            text-transform: uppercase
        }



        .false-box{
            float: right;
            position: relative;
            width: 40px;
            height: 40px;
            top: -5px;
            text-align: center;
            transform: scale(0.5);
        }
        .false-box:hover{
            cursor: pointer;
            transform: scale(0.65);
            transition: .5s;
        }
        .false-box:hover .left-close,.false-box:hover .right-close{
            background-color: black;
        }
        .left-close{
            position: absolute;
            width: 6px;
            height: 50px;
            left: 45%;
            bottom: -6px;
            transform: rotate(45deg) ;
            border-radius: 3px;
            background: grey;
        }
        .right-close{
            position: absolute;
            width: 6px;
            height: 50px;
            bottom: -6px;
            transform:  translateX(16px) rotate(-45deg) ;
            border-radius: 3px;
            background: grey;
        }

        .info{
            /*display: inline-block;*/
            position: absolute;
            top: 20%;
            left: 50%;
            transform: translateX(-50%);
            width: fit-content;
            width: -moz-fit-content;

            font-size: 20px;
            font-weight: bold;
            color: #2c2a2c;
        }

        #home{
            position: absolute;
            bottom: 10%;
            margin: 0;
            /*width: fit-content;*/
            left: 50%;
            transform: translateX(-50%);
        }
        #home:hover{
            transform: translateX(-50%) scale(1.1);
        }

    </style>
    <link rel="icon" href="images/favor.ico">
</head>
<body>

<div class="container">

    <div class="header">
        <div class="logo">
            <img src="images/blade6.png" style="width: 100%;max-height: 130%;min-height: 100%">
        </div>
    </div>
    <p id="motto">Security</p>

    <div class="content">
        <div class="box">
            <div class="left">
                <div class="validation">
                    <span>Modify Password</span>

                    <form id="modify">
                        <div class="input-outline-x" data-validate="Type user name">
                            <input class="input-control input-outline" size="25" id="userName"
                                   name="userName" placeholder="User name" required="required">
                            <label class="input-label">User name</label>
                        </div>
                        <div class="input-outline-x" style="margin-bottom: 10px;">
                            <input class="input-control input-outline" size="25" id="oldPsd"
                                   name="oldPsd" placeholder="Old password" type="password" required="required">
                            <label class="input-label">Old password</label>
                        </div>
                        <p id="error" style="height: 20px;font-size: 16px;color: firebrick">

                        </p>


                        <div class="input-outline-x">
                            <input class="input-control input-outline" size="25" id="newPsd"
                                   name="newPsd" placeholder="Old password" type="password" required="required">
                            <label class="input-label">New password</label>
                        </div>
                        <div class="input-outline-x" style="margin-bottom: 10px;">
                            <input class="input-control input-outline" size="25" id="verifyNewPsd"
                                   name="verifyNewPsd" placeholder="Old password" type="password" required="required">
                            <label class="input-label">Please enter again</label>
                        </div>
                        <p id="errorPsd" style="height: 20px;font-size: 16px;
                        color: firebrick;margin-bottom: 10px;"></p>

                        <button class="send-code" type="button" onclick="modifyCheck()">
                            Confirm
                        </button>
                    </form>

                </div>

                <div class="attention">
                    <div class="false-box">

                        <div class="left-close"></div>
                        <div class="right-close"></div>
                    </div>
                    <p class="info">Modify Successfully!</p>

                    <a href="../login.jsp">
                        <button  class="send-code" id="home">Back to Homepage</button>
                    </a>

                </div>

            </div>
            <div class="split"></div>

            <div class="right">

                <div class="validation">
                    <span>Modify via phone</span>
                    <form id="val-form" method="post" action="<%=path%>/valModify">

                        <div class="input-outline-x" style="margin-bottom: 0px;">
                            <input class="input-control input-outline" size="25" placeholder="Phone number"
                                   id="phoneNum" name="phoneNum" type="text" required="required">
                            <label class="input-label">Phone number</label>
                        </div>

                        <p id="errorPhoneNum" style="height: 20px;font-size: 16px;
                        color: firebrick;margin-bottom: 12px;opacity: 0;"></p>

                        <button class="send-code" type="button" onclick="sendCode()">Send code</button>

                        <div class="input-outline-x" style="margin-bottom: 0px;">
                            <input class="input-control input-outline" size="25" placeholder="Verify code"
                                   id="codeNum" name="verifyCode" type="text" required="required">
                            <label class="input-label">Verification code</label>
                        </div>

                        <p id="errorCode" style="height: 20px;font-size: 16px;
                        color: firebrick;margin-bottom: 12px;opacity: 0;"></p>

                        <button class="send-code" type="button" onclick="checkCode()">Commit</button>
                    </form>
                </div>

                <div id="valModify">
                    <div class="false-box">
                        <div class="left-close"></div>
                        <div class="right-close"></div>
                    </div>

                    <span>Modify your password</span>
                    <div class="input-outline-x">
                        <input class="input-control input-outline" size="25" id="val-newPsd"
                               name="newPsd" placeholder="Old password" type="password" required="required">
                        <label class="input-label">New password</label>
                    </div>
                    <div class="input-outline-x" style="margin-bottom: 10px;">
                        <input class="input-control input-outline" size="25" id="val-verifyNewPsd"
                               name="verifyNewPsd" placeholder="Old password" type="password" required="required">
                        <label class="input-label">Please enter again</label>
                    </div>
                    <p id="val-errorPsd" style="height: 20px;font-size: 16px;
                        color: firebrick;margin-bottom: 10px;"></p>

                    <%--class控制样式--%>
                    <button class="send-code" type="button" onclick="valModify()">
                        Confirm
                    </button>
                </div>

            </div>


        </div>

    </div>


</div>

</body>
</html>

<script>

    /*由于我们会在这里进行密码的修改,为了防止用户作弊
    * 比如修改html/css属性来修改我们隐藏的modify界面*/
    let isCheat=true;

    /* 通过手机验证码修改密码 */
    function valModify(){
        let valNewPsd=document.getElementById("val-newPsd").value;
        let valVeriNewPsd=document.getElementById("val-verifyNewPsd").value;
        let phoneNum=document.getElementById("phoneNum").value;

        let valError=document.getElementById("val-errorPsd");   //错误信息显示

        /*若是非法登录的会提示不要cheat且没办法进行修改密码*/
        if (isCheat){
            alert("Please don't cheat!!!")
        }
        else
            ajax({
            type: "POST",
            url: "<%=path%>/valModify",
            dataType: "json",
            responseType:"json",
            data:{         //已经通过验证,所以这里只需传递手机号和新密码
                "phoneNum":phoneNum,
                "newPsd":valNewPsd
            },

            beforeSend:function (){
                if (valNewPsd===""||valVeriNewPsd===""){
                    valError.style.opacity="1";
                    valError.innerHTML="Password can't be blank!";
                    setTimeout(function (){
                        valError.style.transition=".6s";
                        valError.style.opacity="0";
                    },3000);
                    return false;
                }
                else if (valNewPsd!==valVeriNewPsd){
                    valError.style.opacity="1";
                    valError.innerHTML="Mismatched!";
                    setTimeout(function (){
                        valError.style.transition=".6s";
                        valError.style.opacity="0";
                    },3000);
                    return false;
                }
                return true;
            },

            success:function (response){
                console.log(response["status"]);

                if (response["status"]===0){
                    valError.style.opacity="1";
                    valError.innerHTML="error ! try again !";
                    setTimeout(function (){
                        valError.style.transition=".6s";
                        valError.style.opacity="0";
                    },3000);
                }
                /*成功修改*/
                else if (response["status"]===1){
                    valError.style.opacity="1";
                    valError.innerHTML="successfully!";
                    setTimeout(function (){
                        valError.style.transition=".6s";
                        valError.style.opacity="0";
                    },3000);

                }

            },

            error:function (){
                alert("error");
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
                /*不存在这个电话号码!*/
                if (response["status"]===9){
                    errorPhoneNum.style.opacity="1";
                    errorPhoneNum.innerHTML="PhoneNum doesn't exists!";
                    setTimeout(function (){
                        errorPhoneNum.style.transition=".6s"
                        errorPhoneNum.style.opacity="0";
                    },3000);
                }
                else if (response["status"]===1){
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
        let valForm=document.getElementById('val-form');  //用于待会提交表单数据
        let valFalseBox=document.getElementById("valModify");
        let valFalse=document.getElementsByClassName("false-box")[1];

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
                    },3000)
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
                else if (response["verifyStatus"]===1){       //登陆成功
                    //这样不安全我们舍弃掉,任何人都能通过url进行访问
                    //window.location.href="<%=path%>/success";

                    //放弃,太复杂!!!
                    ///*验证成功,提交表单数据(post)跳转到新界面(不能通过url访问)*/
                    //valForm.submit();

                    /* 打开修改密码的页面,修改isCheat表示这是正常登录的 */
                    isCheat=false;
                    valFalseBox.style.opacity="1";
                    valFalseBox.style.zIndex="2";
                }
            },
            error:function (){
                alert("error");
            }

        });

        /*添加一个按钮关闭的点击事件*/

        valFalse.onclick=function (){
            valFalseBox.style.opacity="0"
            valFalseBox.style.zIndex="-1";
        }
    }

    /*修改密码*/
    function modifyCheck() {
        let userName = document.getElementById("userName").value;
        let oldPassword = document.getElementById("oldPsd").value;
        let newPassword=document.getElementById("newPsd").value;
        let verifyNewPassword=document.getElementById("verifyNewPsd").value;
        let errorOld=document.getElementById("error");
        let errorNew=document.getElementById("errorPsd");
        let attentionBox=document.getElementsByClassName("attention")[0];
        let falseBox=document.getElementsByClassName("false-box")[0];
        let form=document.getElementById("form");
        /*ajax利用XHR异步发送请求*/
        ajax({
            type: "POST",
            url: "<%=path%>/modify",
            dataType: "json",
            responseType:"json",
            data:{
                "userName":userName,
                "userPassword":oldPassword,
                "newPassword":newPassword
            } ,

            /*对输入不为空的提示,对前后两次输入的新密码是否一致进行验证*/
            beforeSend: function (){
                if (userName===""||oldPassword===""){
                    errorOld.style.opacity="1";
                    errorOld.innerHTML="Please enter your information!";
                    setTimeout(function (){
                        errorOld.style.transition=".6s"
                        errorOld.style.opacity="0";
                    },3000);
                    return false;
                }

                else if (newPassword===""||verifyNewPassword===""){
                    errorNew.style.opacity="1";
                    errorNew.innerHTML="Password can't be blank!";
                    setTimeout(function (){
                        errorNew.style.transition=".6s"
                        errorNew.style.opacity="0";
                    },3000);
                    return false;
                }
                else if (newPassword!==verifyNewPassword){
                    errorNew.style.opacity="1";
                    errorNew.innerHTML="Mismatched!";
                    setTimeout(function (){
                        errorNew.style.transition=".6s"
                        errorNew.style.opacity="0";
                    },3000);
                    return false;
                }
                return true;
            },

            success: function (response){
                /* 1表示用户不存在,2表示密码错误,3表示修改成功,4表示数据库没修改成功 */
                console.log(response["status"]);

                switch (response["status"]){
                    case 1:
                        errorOld.style.opacity="1";
                        errorOld.innerHTML="The user doesn't exist!";
                        setTimeout(function (){
                            errorOld.style.transition=".6s"
                            errorOld.style.opacity="0";
                        },3000);
                        break;
                    case 2:
                        errorOld.style.opacity="1";
                        errorOld.innerHTML="Wrong password!";
                        setTimeout(function (){
                            errorOld.style.transition=".6s"
                            errorOld.style.opacity="0";
                        },3000);
                        break;
                    case 3:
                        attentionBox.style.zIndex="2";
                        attentionBox.style.opacity="1"
                        break;
                    case 4:
                        errorNew.style.opacity="1";
                        errorNew.innerHTML="Database error!";
                        setTimeout(function (){
                            errorNew.style.transition=".6s"
                            errorNew.style.opacity="0";
                        },3000);
                        break;
                    default:
                        errorOld.innerHTML="internal error!";

                }
            },
            error: function (){
                alert("error")
            }
        })

        /*添加一个关闭attention的按钮点击事件*/
        falseBox.onclick=function (){
            attentionBox.style.opacity="0"
            attentionBox.style.zIndex="-1";
        }
    }

    /* 纯js实现ajax */
    function createXMLHttpRequest() {
        if (window.ActiveXObject) {    // IE
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

</script>
