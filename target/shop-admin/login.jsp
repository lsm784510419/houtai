<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/8/28/028
  Time: 21:01
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>


<html>
<head>
    <title>登陆页面</title>
    <link rel="stylesheet" href="/js/bootStrap/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="/js/DataTables/css/jquery.dataTables.min.css"/>
  <%--  <meta charset="utf-8">--%>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <script type="application/x-javascript"> addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false); function hideURLbar(){ window.scrollTo(0,1); } </script>
    <meta name="keywords" content="Flat Dark Web Login Form Responsive Templates, Iphone Widget Template, Smartphone login forms,Login form, Widget Template, Responsive Templates, a Ipad 404 Templates, Flat Responsive Templates" />
    <link href="css/style.css" rel='stylesheet' type='text/css' />
    <link href='http://fonts.useso.com/css?family=PT+Sans:400,700,400italic,700italic|Oswald:400,300,700' rel='stylesheet' type='text/css'>
    <link href='http://fonts.useso.com/css?family=Exo+2' rel='stylesheet' type='text/css'>
    <h1> Login </h1>
    <div class="login-form">
        <div class="avtar">
            <img src="images/avtar.png" />
        </div>
        <form>
            <input type="text" class="text" id="name" placeholder="账号" ><br><span id="font1"></span><br>
            <div class="key">
                <input type="password"  id="password" placeholder="密码"><br></b><span id="font2"></span><br>
            </div>
            <div class="key">
                <input type="text" id="imgCodeName"/>
                <img src="/img/code" id="imgCode"/>
                <a href="#" onclick="tradeImgCode()">换一张</a>
            </div>
        </form>
        <div class="signin">
            <input type="submit" id="loginButton" value="Login" onclick="loginUser()">
        </div>
        <div>
           <input type="button" id="pass" value="忘记密码" onclick="toFindPassword()">
        </div>
    </div>
    <jsp:include page="/common/script.jsp"></jsp:include>


    <script>
        /*找回密码页面*/
        function toFindPassword() {
            location.href="/user/toFindPassword.do";

        }
        function tradeImgCode() {
            var v_date = new Date().getTime();
            document.getElementById("imgCode").src="/img/code?"+v_date;
        }

        function loginUser(){
            var v_userName = $("#name").val();
            var v_password = $("#password").val();
            var v_imgCodeName = $("#imgCodeName").val();
            $.post({
                url:"/user/login.do",
                data:{
                    "userName":v_userName,
                    "password":v_password,
                    "imgCodeName":v_imgCodeName,
                },
                success:function (result) {
                    if (result.code==200){
                        location.href="/index.do";
                    }else {
                        bootbox.alert({
                            message: "<span class='glyphicon glyphicon-exclamation-sign'></span>"+result.msg,
                            size: 'small',
                            title: "提示信息"
                        });
                    }
                }
            })
        }
    </script>
</body>
</head>
</html>
