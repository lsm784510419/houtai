<%@ page import="com.fh.shop.admin.util.DistributeSession" %>
<%@ page import="com.fh.shop.admin.util.RedisUtil" %>
<%@ page import="com.fh.shop.admin.util.KeyUtil" %>
<%@ page import="com.alibaba.fastjson.JSONObject" %>
<%@ page import="com.fh.shop.admin.po.user.User" %><%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/9/3/003
  Time: 20:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <jsp:include page="/common/head.jsp"></jsp:include>
    <title>Title</title>

    <style>
        .dropdown-submenu {
            position: relative;
        }

        .dropdown-submenu > .dropdown-menu {
            top: 0;
            left: 100%;
            margin-top: -6px;
            margin-left: -1px;
            -webkit-border-radius: 0 6px 6px 6px;
            -moz-border-radius: 0 6px 6px;
            border-radius: 0 6px 6px 6px;
        }

        .dropdown-submenu:hover > .dropdown-menu {
            display: block;
        }

        .dropdown-submenu > a:after {
            display: block;
            content: " ";
            float: right;
            width: 0;
            height: 0;
            border-color: transparent;
            border-style: solid;
            border-width: 5px 0 5px 5px;
            border-left-color: #ccc;
            margin-top: 5px;
            margin-right: -10px;
        }

        .dropdown-submenu:hover > a:after {
            border-left-color: #fff;
        }

        .dropdown-submenu.pull-left {
            float: none;
        }

        .dropdown-submenu.pull-left > .dropdown-menu {
            left: -100%;
            margin-left: 10px;
            -webkit-border-radius: 6px 0 6px 6px;
            -moz-border-radius: 6px 0 6px 6px;
            border-radius: 6px 0 6px 6px;
        }
    </style>
</head>
<body>

<nav class="navbar navbar-inverse">
    <div class="container-fluid">
        <!-- Brand and toggle get grouped for better mobile display -->
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="#">飞狐电商后台管理</a>
        </div>

        <!-- Collect the nav links, forms, and other content for toggling -->
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <div id="test"></div>
            <%--<ul class="nav navbar-nav">
                <li class="active"><a href="#">商品管理 <span class="sr-only">(current)</span></a></li>
                <li><a href="#">品牌管理</a></li>
                <li><a href="#">地区管理</a></li>
                <li><a href="#">分类管理</a></li>
                <li>
                    <a href="#" data-toggle="dropdown">系统管理<span class="caret"></span></a>
                    <ul class="dropdown-menu">
                        <li><a href="/user/index.jhtml">用户管理</a></li>
                        <li role="separator" class="divider"></li>
                        <li><a href="/role/index.jhtml">角色管理</a></li>
                        <li role="separator" class="divider"></li>
                        <li><a href="/resource/index.jhtml">菜单管理</a></li>
                        <li role="separator" class="divider"></li>
                        <li class="dropdown-submenu">
                            <a tabindex="-1" href="#">角色管理</a>
                            <ul class="dropdown-menu">
                                        <li class="dropdown-submenu"><a tabindex="-1" href="#">Second level link</a>
                                <ul class="dropdown-menu">
                                    <li><a tabindex="-1" href="#">Second level link</a></li>
                                    <li><a tabindex="-1" href="#">Second level link</a></li>
                                </ul>
                            </li>
                                        <li><a tabindex="-1" href="#">Second level link</a></li>
                                        <li><a tabindex="-1" href="#">Second level link</a></li>
                                        <li><a tabindex="-1" href="#">Second level link</a></li>
                                        <li><a tabindex="-1" href="#">Second level link</a></li>
                                      </ul>
                        </li>
                    </ul>
                </li>
            </ul>--%>
         <%--   <%
                String sessionId = DistributeSession.getSessionId(request, response);
                String userDb = RedisUtil.get(KeyUtil.buildUserDBKey(sessionId));
                User user = JSONObject.parseObject(userDb,User.class);
            %>--%>
            <ul class="nav navbar-nav navbar-right" id="userInfoDiv">
                <li><a href="#">欢迎##realName##登陆</a></li>
               <%-- <c:if test="<%=user.getLoginTime()%>">--%>
                <%-- <li><a href="#">上次登陆时间<fmt:formatDate value="<%=user.getLoginTime()%>" pattern="yyyy-MM-dd HH:mm:ss"/></a></li>--%>
              <%--  </c:if>--%>
                <li id="loginTime" style="display: none"><a href="#">上次登陆时间##loginTime##</a></li>--%>
                <li><a href="#">今日第##loginCount##次登陆</a></li>
                <li><a href="/user/outLogin.do">退出</a></li>
                <li><a href="/user/toUpdatePassword.do">修改密码</a></li>
            </ul>
          <%--  <div style="display: none" id="userInfoModel">
                <li><a href="#">欢迎##realName##登陆</a></li>
                <c:if test="${!empty userDB.loginTime}">
                    <li><a href="#">上次登陆时间<fmt:formatDate value="${userDB.loginTime}" pattern="yyyy-MM-dd HH:mm:ss"/></a></li>
                </c:if>
                <li><a href="#">今日第${userDB.loginCount}次登陆</a></li>
                <li><a href="/user/outLogin.do">退出</a></li>
                <li><a href="/user/toUpdatePassword.do">修改密码</a></li>
            </div>--%>
        </div><!-- /.navbar-collapse -->
    </div><!-- /.container-fluid -->
</nav>

<script src="/js/jquery-3.3.1.js"></script>
    <script>

      /*  var v_menuArr = [
            {id:1,menuName:"河南",fatherId:0},
            {id:2,menuName:"河北",fatherId:0},
            {id:3,menuName:"郑州",fatherId:1},
            {id:4,menuName:"巩义",fatherId:3},
            {id:5,menuName:"巩义11",fatherId:4},
            {id:6,menuName:"巩义111",fatherId:5},
            {id:7,menuName:"洛阳",fatherId:1},
            {id:8,menuName:"偃师",fatherId:7},
            {id:9,menuName:"偃师1",fatherId:8},
            {id:10,menuName:"偃师11",fatherId:9}
        ];*/

      $(function () {
          initUserInfo();
          find();
          $.ajaxSetup({
              complete:function(result){
                  var v_data = result.responseJSON;
                  if (v_data.code && v_data.code != 200){
                      bootbox.alert({
                          size: "small",
                          title: "提示信息",
                          message: "<span class='glyphicon glyphicon-exclamation-sign'></span>"+v_data.msg,
                      });
                  }
              }
          })
      })

     function initUserInfo() {
          $.ajax({
              url:"/user/findUser.do",
              type:"post",
              success:function (result){
                  if (result.code==200){
                      var v_data = result.data;
                      var v_template = $("#userInfoDiv").html().replace(/##realName##/g,v_data.realName)
                          .replace(/##loginCount##/g,v_data.loginCount+1)
                          .replace(/##loginTime##/g,v_data.strLoginTime);
                      $("#userInfoDiv").html(v_template);
                      if (v_data.loginTime){
                          $("#loginTime").show();
                      }
                  }
              }
          })
      }

      var v_menuArr;
      function find(){
          $.post({
              url:"/menu/findUrl.do",
              success:function (result) {
                  if (result.code==200){
                      v_menuArr=result.data;
                      initMenu(1,1);
                      $("#test").html(v_html);
                  }
              }
          })
      }



      /*  $(function () {
            initMenu(0,1);
            $("#test").html(v_html);
        })*/
        var v_html = "";
        function initMenu(id,level){
            //获取指定id下的所有id
            var sonArr= getSon(id);
            //退出条件，如果长度大于0就继续执行下边代码，否则就不执行
            if (sonArr.length > 0){
                //自己定义的等级，==1的话就证明是最顶级
                if (level==1){
                    v_html+='<ul class="nav navbar-nav">';
                }else {
                    v_html+='<ul class="dropdown-menu">';
                }
                //循环所有的孩子
                for (var i = 0; i < sonArr.length; i++) {
                    var v_node = sonArr[i];
                    var sons= son(v_node.id);

                    if (sons){

                        if (level==1){
                            v_html+='<li><a href="'+sonArr[i].menuUrl+'" data-toggle="dropdown">'+sonArr[i].menuName+'<span class="caret"></span></a>';
                        }else {
                             v_html+='<li class="dropdown-submenu"> <a href="'+sonArr[i].menuUrl+'">'+sonArr[i].menuName+'</a>';
                        }
                    }else{

                            v_html+='<li><a href="'+sonArr[i].menuUrl+'">'+sonArr[i].menuName+'</a>';
                    }
                    initMenu(v_node.id,level+1);
                        v_html+='</li>'
                }
                        v_html+='</ul>'
            }

        }
        function getSon(id) {
            var v_sonArr = [];
            for (var i = 0; i < v_menuArr.length; i++) {
                if (v_menuArr[i].fatherId==id){
                    v_sonArr.push(v_menuArr[i]);
                }
            }
            return v_sonArr;
        }
        function son(id) {
            for (var i = 0; i < v_menuArr.length; i++) {
                if (v_menuArr[i].fatherId==id){
                    return true;
                }
            }
            return false;
        }
    </script>
</body>
</html>
