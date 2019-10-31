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
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
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
                        <li><a href="#">欢迎${userDB.realName}登陆</a></li>
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
    $(function () {
        find();
    })
    var v_menuArr;
    function find(){
        $.post({
            url:"/menu/findUrl.do",
            success:function (result) {
                if (result.code==200){
                    v_menuArr=result.data;
                    console.log(v_menuArr);
                    initMenu();
                }
            }
        })
    }
    function initMenu(){
        //获取最顶级菜单
        var v_menuUrl= getTopMenu();
        //又因为最顶级菜单是 js代码需要转换为jQuery代码
        var v_topMenuObj = $(v_menuUrl);
        console.log(v_menuUrl);
        //获取最顶级菜单的Id
        var  v_MenuIdArr =getTopMenuIdArr();
        console.log(v_MenuIdArr)
        for (var i=0;i<v_MenuIdArr.length;i++){
            //这是带孩子的ID，就是含有pId的id
            var v_son= getSon(v_MenuIdArr[i]);
            if(v_son.length>0){
                //找到要增加特性属性的那个
                var v_url=v_topMenuObj.find("a[data-id='"+v_MenuIdArr[i]+"']")
                //下拉框菜单，需要加上特定的属性
                v_url.attr("data-toggle","dropdown");
                v_url.append('<span class="caret">');
                //构建孩子对应的HTML代码
                var v_sonHtml= findSonHtml(v_son);
                //追加孩子
                v_url.parent().append(v_sonHtml)
            }
        }
            console.log(v_topMenuObj)
            $("#menuTable").html(v_topMenuObj);
    }
    //获取最顶级菜单
    function getTopMenu(){
        var v_menuUrl="";
        for (var i=0;i<v_menuArr.length;i++){
            if (v_menuArr[i].fatherId==1){
                //又因为需要给带下拉框的菜单添加字信息，所以需要绑定一个来找到他
                v_menuUrl+='  <li><a href="'+v_menuArr[i].menuUrl+'" data-id="'+v_menuArr[i].id+'">'+v_menuArr[i].menuName+'</a></li>';
            }
        }
        return v_menuUrl;
    }
    //获取最顶级菜单的id
    function getTopMenuIdArr() {
        var v_MenuIdArr = [];
        for (var i=0;i<v_menuArr.length;i++){
            if (v_menuArr[i].fatherId==1){
                v_MenuIdArr.push(v_menuArr[i].id);
            }
        }
        return v_MenuIdArr;
    }
    //获取含有pid的id   获取到的是孩子的JSON数组
    function getSon(id){
        var v_son = [];
        //循环查出来的所有数据
        for (var i=0;i<v_menuArr.length;i++){
            //如果pid和id相等。
            if (v_menuArr[i].fatherId==id){
                //就将所有的数据放入带孩子的数组中
                v_son.push(v_menuArr[i]);
            }
        }
        return v_son;
    }
    //最后我们拼接的时候需要拼接的HTML代码  所以获取HTML代码
    function findSonHtml(v_son) {

        var v_result = ' <ul class="dropdown-menu">';
        for (var i=0;i<v_son.length;i++){
            v_result+='<li><a href="'+v_son[i].menuUrl+'">'+v_son[i].menuName+'</a></li>';
        }
        v_result+="</ul>";
        return v_result;
    }

</script>
</body>
</html>

