<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/9/8/008
  Time: 19:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <jsp:include page="/common/head.jsp"></jsp:include>
    <title>日志记录</title>
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
                <div class="panel-heading">日志页面</div>
                <div class="panel-body">
                    <form class="form-horizontal" id="searchFrom">
                        <div class="form-group">
                            <label  class="col-sm-1 control-label">用户名</label>
                            <div class="col-sm-5">
                                <input type="email" class="form-control" id="userName" placeholder="请输入用户名">
                            </div>
                            <label class="col-sm-1 control-label">真实姓名</label>
                            <div class="col-sm-5">
                                <input type="email" class="form-control" id="realName" placeholder="请输入真实姓名">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-1 control-label">状态</label>
                            <div class="col-sm-5">
                                <div class="input-group">
                                    <input type="radio" name="status"  value="1">成功
                                    <input type="radio"  name="status" value="0">失败
                                </div>
                            </div>
                            <label class="col-sm-1 control-label">执行方法</label>
                            <div class="col-sm-5">
                                <div class="input-group">
                                    <input type="text" class="form-control" id="info" placeholder="请输入执行方法">
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label  class="col-sm-1 control-label">时间范围</label>
                            <div class="col-sm-5">
                                <div class="input-group">
                                    <input type="text" class="form-control" id="minDate" placeholder="最早时间">
                                    <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                                    <input type="text" class="form-control" id="maxDate" placeholder="最晚时间">
                                </div>
                            </div>
                            <label  class="col-sm-1 control-label">操作信息</label>
                            <div class="col-sm-5">
                                <div class="input-group">
                                    <input type="email" class="form-control" id="content" placeholder="请输入操作信息">
                                </div>
                            </div>
                        </div>

                        <div class="form-group" style="text-align: center">
                            <button class="btn btn-primary btn-lg" onclick="search()" type="button"><i class="glyphicon glyphicon-search">查询</i></button>
                            <button class="btn btn-default btn-lg" type="reset"><i class="glyphicon glyphicon-refresh">重置</i></button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <%--栅格布局第二行  展示的table表格--%>
    <div class="row">
        <div class="col-md-12">
            <div class="panel panel-success">
                <div class="panel-heading">日志列表</div>
                <table id="logTable" class="table table-striped table-bordered" style="width:100%">
                    <thead>
                    <tr>
                        <th>id</th>
                        <th>用户名</th>
                        <th>真实姓名</th>
                        <th>操作时间</th>
                        <th>执行方法</th>
                        <th>状态</th>
                        <th>异常信息</th>
                        <th>参数详情</th>
                        <th>操作信息</th>
                    </tr>
                    </thead>
                    <tfoot>
                    <tr>
                        <th>id</th>
                        <th>用户名</th>
                        <th>真实姓名</th>
                        <th>操作时间</th>
                        <th>执行方法</th>
                        <th>状态</th>
                        <th>异常信息</th>
                        <th>参数详情</th>
                        <th>操作信息</th>
                    </tr>
                    </tfoot>
                </table>
            </div>
        </div>
    </div>
</div>
<jsp:include page="/common/script.jsp"></jsp:include>

<script>
    $(function () {
        initTable();
        initSearchDate();

    })
    function initSearchDate(){
        $("#minDate").datetimepicker({
            format: 'YYYY-MM-DD HH:mm',
            showClear:true,
            locale:"zh-CN",
        });
        $("#maxDate").datetimepicker({
            format: 'YYYY-MM-DD HH:mm',
            showClear:true,
            locale:"zh-CN",
        });
    }

    /*查询的AJAX  服务器端分页*/
    var searchTable;
    function initTable(){
        searchTable=$("#logTable").DataTable( {
            "aLengthMenu":[10,20,30],//自定义每页展示条数
            "serverSide": true,//开启服务器分页模式
            "searching": false,//是否允许检索
            "sScrollX" : 820, //DataTables的宽
            "language": {
                url:"/js/DataTables/Chinese.json"
            },
            "ajax":{
                url:"/log/findPageLogList.do",
                type:"post",
            },
            columns: [
                { data: 'id',},
                { data: 'userName'},
                { data: 'realName'},
                { data: 'currDate'},
                { data: 'info'},
                { data: 'status',
                    render:function (data,type,row,meta) {
                        return data==1?"成功":"失败";
                    }
                },
                { data: 'errorMsg'},
                { data: 'detail'},
                { data: 'content'}
            ]
        } );}
      /*条件查询*/
    function search() {
       var v_userName = $("#userName").val();
       var v_realName = $("#realName").val();
       var v_info = $("#info").val();
       var v_status = $("input[name=status]:checked").val();
       var v_minDate = $("#minDate").val();
       var v_maxDate = $("#maxDate").val();
       var v_content = $("#content").val();

       var v_searchJsonLog = {};
        v_searchJsonLog.userName = v_userName;
        v_searchJsonLog.realName = v_realName;
        v_searchJsonLog.info = v_info;
        v_searchJsonLog.status = v_status;
        v_searchJsonLog.minCurrDate = v_minDate;
        v_searchJsonLog.maxCurrDate = v_maxDate;
        v_searchJsonLog.content = v_content;
        searchTable.settings()[0].ajax.data=v_searchJsonLog;
        searchTable.ajax.reload();
    }
</script>
</body>
</html>
