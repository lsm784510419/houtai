<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/10/21/021
  Time: 20:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="/common/head.jsp"></jsp:include>
    <title>会员展示页面</title>
</head>
<body>
<jsp:include page="/common/navStatic.jsp"></jsp:include>
<%--整个JSP页面的栅格布局--%>
<div class="container">
    <%--栅格布局的第一行 模糊查询--%>
    <div class="row">
        <div class="col-md-12">
            <div class="panel panel-success">
                <div class="panel-heading">会员查询</div>
                <div class="panel-body">
                    <form class="form-horizontal" id="productFrom">
                        <div class="form-group">
                            <label  class="col-sm-1 control-label">会员名</label>
                            <div class="col-sm-5">
                                <input type="type" class="form-control" id="userName" placeholder="请输入会员名" name="userName">
                            </div>
                            <label  class="col-sm-1 control-label">出生日期</label>
                            <div class="col-sm-5">
                                <div class="input-group">
                                    <input type="text" class="form-control" id="minBirthday" placeholder="最早时间">
                                    <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                                    <input type="text" class="form-control" id="maxBirthday" placeholder="最晚时间">
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label  class="col-sm-1 control-label">真实姓名</label>
                            <div class="col-sm-5">
                                <input type="type" class="form-control" id="realName" placeholder="请输入真实姓名" name="realName">
                            </div>
                        </div>
                        <div class="form-group" id="searchAreaDiv">
                            <label  class="col-sm-1 control-label">地区查询</label>
                            <input type="hidden" name="area1" id="area1"/>
                            <input type="hidden" name="area2" id="area2"/>
                            <input type="hidden" name="area3" id="area3"/>
                        </div>
                        <div class="form-group" style="text-align: center">
                            <button class="btn btn-primary btn-lg" onclick="searchArea()" type="button"><i class="glyphicon glyphicon-search">查询</i></button>
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
                <div class="panel-heading">会员列表</div>
                <table id="memberTable" class="table table-striped table-bordered" style="width:100%">
                    <thead>
                    <tr>
                        <th>id</th>
                        <th>会员名</th>
                        <th>真实姓名</th>
                        <th>电话号码</th>
                        <th>生日</th>
                        <th>邮箱</th>
                        <th>地区</th>
                        <th>操作</th>
                    </tr>
                    </thead>
                    <tfoot>
                    <tr>
                        <th>id</th>
                        <th>会员名</th>
                        <th>真实姓名</th>
                        <th>电话号码</th>
                        <th>生日</th>
                        <th>邮箱</th>
                        <th>地区</th>
                        <th>操作</th>
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
        searchAreaSelect(1);
        initSearchDate();
    })

    function initSearchDate(){
        $("#minBirthday").datetimepicker({
            format: 'YYYY-MM-DD',
            showClear:true,
            locale:"zh-CN",
        });
        $("#maxBirthday").datetimepicker({
            format: 'YYYY-MM-DD',
            showClear:true,
            locale:"zh-CN",
        });
    }

    function searchAreaSelect(id,obj) {
        if (obj){
            $(obj).parent().nextAll().remove();
        }
        $.ajax({
            url:"/area/findAreaSelect.do",
            type:"post",
            data:{
                "id":id,
            },
            success:function (result) {
                if (result.code == 200){
                    var v_areaArr = result.data;
                    if (v_areaArr.length == 0){
                        return "";
                    }
                    var v_select = '<div class="col-sm-3">';
                    v_select += '<select class="form-control" name="areaName" onchange="searchAreaSelect(this.value,this)">';
                    v_select += '<option value="-1">请选择</option>';
                    for (var i = 0; i < v_areaArr.length; i++) {
                        var v_area = v_areaArr[i];
                        v_select += ' <option value="'+v_area.id+'">'+v_area.areaName+'</option>';
                    }
                    v_select += '</select></div>'
                    $("#searchAreaDiv").append(v_select);
                }
            }
        })
    }
    var v_memberTable;
    function initTable() {
        v_memberTable=$("#memberTable").DataTable( {
            "aLengthMenu":[2,5,10],//自定义每页展示条数
            "serverSide": true,//开启服务器分页模式
            "searching": false,//是否允许检索
            "language": {
                url:"/js/DataTables/Chinese.json"
            },
            "ajax":{
                url:"/member/findPageMemberList.do",
                type:"post",
                "dataSrc":function (result) {
                    if (result.code==200){
                        result.draw = result.data.draw;
                        result.recordsTotal = result.data.recordsTotal;
                        result.recordsFiltered = result.data.recordsFiltered;
                        return result.data.data;
                    }
                }
            },
            columns: [
                { data: 'id' },
                { data: 'userName' },
                { data: 'realName' },
                { data: 'phone'},
                { data: 'birthday'},
                { data: 'email' },
                { data: 'areaName' },
                { data: "id",
                    render:function(data,type,row,meta){
                        return "<div class=\"btn-group\" role=\"group\" aria-label=\"...\">\n" +
                            "  <button type=\"button\" onclick=\"deleteProduct('"+data+"')\" class=\"btn btn-danger\"><span class=\"glyphicon glyphicon-trash\"></span>删除</button>\n" +
                            "  <button type=\"button\" onclick=\"findUpdateProduct('"+data+"')\" class=\"btn btn-info\"><span class=\"glyphicon glyphicon-pencil\"></span>修改</button>\n" +
                            "</div>";
                    }}
            ]
        } );
    }

    /*条件查询*/
    function searchArea(){

        var v_userName = $("#userName").val();
        var v_realName = $("#realName").val();
        var v_minBirthday = $("#minBirthday").val();
        var v_maxBirthday = $("#maxBirthday").val();

        var v_area1 = $($("select[name='areaName']",$("#searchAreaSelDiv"))[0]).val();
        var v_area2 = $($("select[name='areaName']",$("#searchAreaSelDiv"))[1]).val();
        var v_area3 = $($("select[name='areaName']",$("#searchAreaSelDiv"))[2]).val();
        var searchJson = {};
        searchJson.userName = v_userName;
        searchJson.realName = v_realName;
        searchJson.minBirthday = v_minBirthday;
        searchJson.maxBirthday = v_maxBirthday;
        searchJson.area1 = v_area1;
        searchJson.area2 = v_area2;
        searchJson.area3 = v_area3;

        v_memberTable.settings()[0].ajax.data=searchJson;
        v_memberTable.ajax.reload();
    }
</script>
</body>
</html>
