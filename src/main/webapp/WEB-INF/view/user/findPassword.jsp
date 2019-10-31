<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/9/11/011
  Time: 17:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="/common/head.jsp"></jsp:include>
    <title>找回密码</title>
</head>
<body>
<div class="container">
    <%--栅格布局的第一行 模糊查询--%>
    <div class="row">
        <div class="col-md-12">
            <div class="panel panel-success">
                <div class="panel-heading">找回密码</div>
                <div class="panel-body">
                    <form class="form-horizontal" id="searchFrom">
                        <div class="form-group">
                            <label  class="col-sm-1 control-label">邮箱</label>
                            <div class="col-sm-5">
                                <input type="text" class="form-control" id="mail" placeholder="请输入注册时的邮箱">
                            </div>
                        </div>

                        <div class="form-group" style="text-align: center">
                            <button class="btn btn-primary btn-lg" onclick="enbPassword()" type="button"><i class="glyphicon glyphicon-ok">发送密码至邮箱</i></button>
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
    function enbPassword() {
        var v_mail = $("#mail").val();
        $.post({
            url:"/user/enbPassword.do",
            data:{
                "mail":v_mail,
            },
            success:function (result) {
                if (result.code==200){
                    bootbox.alert({
                        size: "small",
                        title: "提示信息",
                        message: "<span class='glyphicon glyphicon-exclamation-sign'></span>密码已发送至邮箱",
                    });
                }else{
                    bootbox.alert({
                        size: "small",
                        title: "提示信息",
                        message: "<span class='glyphicon glyphicon-exclamation-sign'></span>"+result.msg,
                    });
                }
            }
        })

    }
</script>
</body>
</html>
