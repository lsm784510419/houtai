<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/9/4/004
  Time: 21:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="/common/head.jsp"></jsp:include>
    <title>Title</title>
</head>
<body>
<form>
    <div class="form-group">
        <label>Username</label>
        <input type="text" class="form-control" name="username" />
    </div>
    <div class="form-group">
        <label>Email address</label>
        <input type="text" class="form-control" name="email" />
    </div>
    <div class="form-group">
        <button type="submit" name="submit" class="btn btn-primary">Submit</button>
    </div>
</form>

    <jsp:include page="/common/script.jsp"></jsp:include>
    <script>
        $(function () {
            $('form').bootstrapValidator({
                message: 'This value is not valid',
                feedbackIcons: {
                    valid: 'glyphicon glyphicon-ok',
                    invalid: 'glyphicon glyphicon-remove',
                    validating: 'glyphicon glyphicon-refresh'
                },
                fields: {
                    username: {
                        message: '用户名验证失败',
                        validators: {
                            notEmpty: {
                                message: '用户名不能为空'
                            },
                            stringLength: {  //长度限制
                                min: 6,
                                max: 18,
                                message: '用户名长度必须在6到18位之间'
                            },
                            regexp: { //正则表达式
                                regexp: /^[a-zA-Z0-9_]+$/,
                                message: '用户名只能包含大写、小写、数字和下划线'
                            },
                        }
                    },
                    email: {
                        validators: {
                            notEmpty: {
                                message: '邮箱地址不能为空'
                            }
                        }
                    }
                }
            });
        });
    </script>
</body>
</html>
