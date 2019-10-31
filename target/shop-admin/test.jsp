<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/9/3/003
  Time: 12:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="/common/head.jsp"></jsp:include>
    <title>Title</title>
</head>
<body>
    <div id="div"></div>
    <jsp:include page="/common/script.jsp"></jsp:include>
    <script>
        var menuArr = [
            {id:1,menuName:"河南",fatherId:0},
            {id:2,menuName:"河北",fatherId:0},
            {id:3,menuName:"郑州",fatherId:1},
            {id:4,menuName:"巩义",fatherId:3},
            {id:5,menuName:"巩义11",fatherId:4},
            {id:6,menuName:"巩义111",fatherId:5},
            {id:7,menuName:"洛阳",fatherId:1},
            {id:8,menuName:"偃师",fatherId:7},
            {id:9,menuName:"偃师1",fatherId:8},
            {id:10,menuName:"偃师11",fatherId:9},
        ];
        $(function () {
            initMenu(0,1);
            $("#div").append(v_html);
        })
        var v_html = "";
        function initMenu(id,level) {
            //获取指定Id下的所有孩子
            var v_sonArr= getSon(id);
            //退出条件 也可以说是否有孩子
            if (v_sonArr.length > 0 ){
                v_html += "<ul>";
                for (var i = 0; i < v_sonArr.length; i++) {
                    v_html+="<li>'"+v_sonArr[i].menuName+"'";
                    v_sonArr[i].treelevel=level;
                    initMenu(v_sonArr[i].id,level+1);
                    v_html+="</li>";
                }
                v_html+="</ul>";
            }
        }

        function getSon(id) {
            var v_son = [];
            for (var i = 0; i < menuArr.length; i++) {
                 if (menuArr[i].fatherId==id){
                    v_son.push(menuArr[i])
                 }
                }
                return v_son;
            }
    </script>
</body>
</html>
