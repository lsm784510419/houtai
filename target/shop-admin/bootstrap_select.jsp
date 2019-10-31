<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/8/25/025
  Time: 12:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="/js/bootStrap/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="/js/bootstrap-select/css/bootstrap-select.min.css"/>
</head>
<body>


<select class="selectpicker" multiple id="sel_role" name="role" title="请选择">

</select>
<script src="/js/jquery-3.3.1.js"></script>
<script src="/js/bootStrap/js/bootstrap.min.js"></script>
<script src="/js/bootstrap-select/js/bootstrap-select.min.js"></script>
<script src="/js/bootstrap-select/js/i18n/defaults-zh_CN.js"></script>
<script>
    $(function () {
        sel();
    })
    function sel(){
        $.post({
            url:"/role/findRole.do",
            success:function (result) {
                alert(result)
                if (result.code==200){

                    var v_data = result.data;
                    for (var i = 0;i<v_data.length;i++) {
                       $("#sel_role").append("<option value='"+v_data[i].id+"'"+v_data[i].roleName+"</option>")
                    }
                    $("#sel_role").selectpicker("refresh");
                }
            }
        })
    }
</script>
</body>
</html>
