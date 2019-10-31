<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/8/28/028
  Time: 12:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--导航条--%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
</head>
<body>
<nav class="navbar navbar-inverse" role="navigation">
    <div class="container-fluid">
               <div class="navbar-header">
                    <a class="navbar-brand" href="#">飞狐电商后台管理</a>
                </div>
                    <ul class="nav navbar-nav" id="menuTable">
                       <%-- <li><a href="/shop/toList.do">商品管理</a></li>
                        <li><a href="/brand/toList.do">品牌管理</a></li>
                        <li><a href="/area/toList.do">地区管理</a></li>
                        <li><a href="#">日志管理</a></li>--%>
                     <%-- <li class="dropdown">
                            <a href="#"  data-toggle="dropdown">
                               系统管理<b class="caret"></b>
                            </a>
                            <ul class="dropdown-menu">
                               <li><a href="/user/toList.do">用户管理</a></li>
                                <li><a href="/role/toList.do">角色管理</a></li>
                                <li><a href="/menu/toList.do">菜单管理</a></li>
                            </ul>
                        </li>--%>
                    </ul>
                    <ul class="nav navbar-nav navbar-right">
                        <li><a href="#">欢迎${userDB.realName}登陆<img src="/${userDB.userImg} width='10px'"/></a></li>
                        <c:if test="${!empty userDB.loginTime}">
                            <li><a href="#">上次登陆时间<fmt:formatDate value="${userDB.loginTime}" pattern="yyyy-MM-dd HH:mm:ss"/></a></li>
                        </c:if>
                        <li><a href="#">今日第${userDB.loginCount}次登陆</a></li>
                        <li><a href="/user/outLogin.do">退出</a></li>
                    </ul>
        <input type="hidden" id="userId" value="${userDB.id}"/>
    </div>
</nav>


<script src="/js/jquery-3.3.1.js"></script>

<script>
    var v_menuArr;
    $(function () {
        initMenu();
    });
    function initMenu() {
        $.post({
            url:"/menu/findUrl.do",
            success:function (result) {
                if (result.code==200){
                    v_menuArr=result.data;
                    buildMenu();
                }
            }
        })
    }

    function buildMenu() {
        var topHtml = getTopHtml();
        var topObj = $(topHtml);
        var topMenuIdArr = getTopMenuIds();
        for (var i = 0; i < topMenuIdArr.length; i++) {
            var childrenArr = getChildrenArr(topMenuIdArr[i]);

            if(childrenArr.length>0){
                var obj = topObj.find("a[data-id='"+topMenuIdArr[i]+"']");
                obj.attr("data-toggle","dropdown");
                obj.append("<b class=\"caret\"></b>");
                var childHtml = buildChildrenHtml(childrenArr);
                obj.parent().append(childHtml);
            }
        }

        $("#menuTable").html(topObj);
    }

    function getTopHtml() {
        var str = "";
        for (var i = 0; i < v_menuArr.length; i++) {
            if(v_menuArr[i].fatherId == 1){
                str += "<li><a href=\""+v_menuArr[i].menuUrl+"\" data-id=\""+v_menuArr[i].id+"\">"+v_menuArr[i].menuName+"</a></li>";
            }
        }
        return str;
    }

    function getTopMenuIds() {
        var menuIds = [];
        for (var i = 0; i < v_menuArr.length; i++) {
            if(v_menuArr[i].fatherId == 1){
                menuIds.push(v_menuArr[i].id);
            }
        }
        return menuIds;
    }

    function getChildrenArr(id) {
        var childrenArr = [];
        for (var i = 0; i < v_menuArr.length; i++) {
            if(v_menuArr[i].fatherId == id){
                childrenArr.push(v_menuArr[i]);
            }
        }
        return childrenArr;
    }
    function buildChildrenHtml(childArr) {
        var str ="<ul class=\"dropdown-menu\">";
        for (var i = 0; i < childArr.length; i++) {
            str += "<li><a href=\""+childArr[i].menuUrl+"\">"+childArr[i].menuName+"</a></li>";
        }
        str += "</ul>";
        return str;
    }
</script>
</body>
</html>

