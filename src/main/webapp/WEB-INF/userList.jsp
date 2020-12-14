<%--
  Created by IntelliJ IDEA.
  User: shanxiansen310
  Date: 2020/11/22
  Time: 11:16
  To change this template use File | Settings | File Templates.
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% String path=request.getContextPath(); %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>User Management</title>
</head>
<body>

<h2>User List</h2>
<table border="1">
    <tr>
        <td>No.</td>
        <td>userName</td>
        <td>userPassword</td>
        <td>userPhoneNum</td>
    </tr>

    <%--items接收由servlet传递过来的值 其中${}一定要和servlet中设置的attribute一样!!!
        var表示循环遍历的userList中每一个user,  可以随意取名
    --%>
    <c:forEach items="${userList}" var="l" varStatus="vs">
        <tr>
            <td>${vs.index+1}</td>
            <td>${l.name}</td>
            <td>${l.password}</td>
            <td>${l.phoneNum}</td>

            <%--使用jsp变量进行传参!!! 记得加""--%>
            <td>
                <button type="button" onclick="showUserName('${l.name}');">编辑</button>
                <button type="button" onclick="deleteUser('${l.name}');">删除</button>
            </td>
        </tr>
    </c:forEach>
</table>
<br>


<form id="add-form" method="post" action="<%=path%>/userServlet" >
    <input id="type" type="hidden" value="1" name="type">   <%--告知servlet这里是添加用户--%>

    <br>
    User Name(required): <input type="text" id="userName" name="userName"
                      style="display: block" required="required"> <br>
    User Password(required): <input type="text" id="userPsd" name="userPsd"
                         style="display: block" required="required"> <br>
    User Phone Number(required): <input type="text" id="userPhoneNum" name="userPhoneNum"
                         style="display: block" required="required">
    <br>
    <button type="button" onclick="addUser();">Add user</button>
    <button type="button" onclick="editUser();">Edit user</button>
</form>

<form id="delete-form" method="post" action="<%=path%>/userServlet" >
    <input id="d-type" type="hidden" value="3" name="type">   <%--告知servlet这里是删除用户--%>
    <input id="d-name" type="hidden" value="" name="userName">  <%--记得设置value--%>
</form>

</body>
</html>

<script>

    function addUser(){
        let name=document.getElementById("userName").value;
        let psd=document.getElementById("userPsd").value;
        let phone=document.getElementById("userPhoneNum").value;

        /*注意这里添加参数的方式!!!  type=4表示进行验证用户名是否重复*/
        let url="<%=path%>/userServlet",params="type=4&userName="+name;
        let ret=getDataByAjax(url,params);
        console.log("ret:"+ret);

        if (ret=="1"){  //不存在重复
            document.getElementById("type").value=1;   //1 表示add
            document.getElementById("add-form").submit();
        }else {  //名字重复
            alert("您输入的用户已被占用,请重新输入!!!")
        }

    }

    /*修改用户*/
    /* 采用了jsp传参  $ */
    //用户点击user后将user名显示在input中
    function showUserName(userName){
        document.getElementById("userName").value=userName;
    }

    function editUser(userName){
        /*url中在 ? 后进行传参*/
        let name=document.getElementById("userName").value;
        let psd=document.getElementById("userPsd").value;
        let phone=document.getElementById("userPhoneNum").value;

        /*注意这里添加参数的方式!!!  type=4表示进行验证用户名是否重复*/
        let url="<%=path%>/userServlet",params="type=4&userName="+name;
        let ret=getDataByAjax(url,params);
        console.log("ret:"+ret);

        if (ret=="2"){  //名字存在于数据库,进行修改!!!
            document.getElementById("type").value=2;    //2 表示update
            document.getElementById("add-form").submit();
        }else {         //名字不存在,先添加再修改!!!
            alert("您输入的用户不存在,请重新输入!!!")
        }


    }

    function deleteUser(userName){
        /*type=3表示操作类型为删除, userName为要删除的用户名*/
        <%--let url="<%=path%>/userServlet",params="type=3&userName="+userName;--%>
        <%--let ret=getDataByAjax(url,params);--%>

        document.getElementById("d-type").value=3;    //3 表示delete
        document.getElementById("d-name").value=userName;
        document.getElementById("delete-form").submit();

    }

    /*简易的ajax*/
    function getDataByAjax(url,params){
        let ajaxObj=null;
        if (window.ActiveXObject){
            ajaxObj=new ActiveXObject("Microsoft.XMLHTTP");
        }else {
            ajaxObj=new XMLHttpRequest();
        }

        ajaxObj.open("POST",url,false);
        ajaxObj.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
        ajaxObj.send(params);
        return ajaxObj.responseText;
    }

</script>

