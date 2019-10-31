<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/9/10/010
  Time: 18:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="/common/head.jsp"></jsp:include>
    <title>修改密码</title>
</head>
<body>
<%--导航条--%>
<jsp:include page="/common/navStatic.jsp"></jsp:include>

<%--整个JSP页面的栅格布局--%>
<div class="container">
    <%--栅格布局的第一行 模糊查询--%>
    <div class="row">
        <div class="col-md-12">
            <div class="panel panel-success">
                <div class="panel-heading">修改密码</div>
                <div class="panel-body">
                    <form class="form-horizontal" id="searchFrom">
                        <div class="form-group">
                            <label  class="col-sm-1 control-label">原密码</label>
                            <div class="col-sm-5">
                                <input type="password" class="form-control" id="oldPassword" placeholder="请输入原密码">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-1 control-label">新密码</label>
                            <div class="col-sm-5">
                                    <input type="password" class="form-control" id="newPassword" placeholder="请输入新密码">
                            </div>
                        </div>
                        <div class="form-group">
                            <label  class="col-sm-1 control-label">确认密码</label>
                            <div class="col-sm-5">
                                    <input type="password" class="form-control" id="confirmPassword" placeholder="请输入确认密码">
                            </div>

                        </div>

                        <div class="form-group" style="text-align: center">
                            <button class="btn btn-primary btn-lg" onclick="updatePassword()" type="button"><i class="glyphicon glyphicon-ok">确认</i></button>
                            <button class="btn btn-default btn-lg" type="reset"><i class="glyphicon glyphicon-refresh">重置</i></button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>


</div>


<jsp:include page="/common/script.jsp"></jsp:include>
    <script>
        function updatePassword() {
            var v_oldPassword = $("#oldPassword").val();
            var v_newPassword = $("#newPassword").val();
            var v_confirmPassword = $("#confirmPassword").val();
            var v_userId = '${userDB.id}'

            if (v_newPassword != v_confirmPassword ){
                bootbox.alert({
                    size: "small",
                    title: "提示信息",
                    message: "<span class='glyphicon glyphicon-exclamation-sign'></span>两次输入的密码不一致",
                });
            }
            $.post({
                url:"/user/updatePassword.do",
                data:{
                    "oldPassword":v_oldPassword,
                    "newPassword":v_newPassword,
                    "confirmPassword":v_confirmPassword,
                    "userId":v_userId
                },
                success:function (result) {
                    if (result.code==200){
                        alert("修改成功")
                    }
                }
            })
        }
    </script>
</body>
</html>
