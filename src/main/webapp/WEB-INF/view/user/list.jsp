<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/8/18/018
  Time: 19:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <jsp:include page="/common/head.jsp"></jsp:include>
    <title>展示页面</title>

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
                    <div class="panel-heading">用户查询</div>
                    <div class="panel-body">
                        <form class="form-horizontal" id="searchFrom">
                            <div class="form-group">
                                <label  class="col-sm-1 control-label">用户名</label>
                                <div class="col-sm-5">
                                    <input type="email" class="form-control" name="userName" id="userName" placeholder="请输入用户名">
                                </div>
                                <label class="col-sm-1 control-label">真实姓名</label>
                                <div class="col-sm-5">
                                    <input type="email" class="form-control" name="realName" id="realName" placeholder="请输入真实姓名">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-1 control-label">年龄范围</label>
                                <div class="col-sm-5">
                                    <div class="input-group">
                                        <input type="text" class="form-control" name="minAge" id="minAge" placeholder="最小年龄">
                                        <span class="input-group-addon"><i class="glyphicon glyphicon-transfer"></i></span>
                                        <input type="text" class="form-control" name="maxAge" id="maxAge" placeholder="最大年龄">
                                    </div>
                                </div>
                                <label class="col-sm-1 control-label">薪资范围</label>
                                <div class="col-sm-5">
                                    <div class="input-group">
                                        <input type="text" class="form-control" name="minPrice" id="minPrice" placeholder="最小薪资">
                                        <span class="input-group-addon"><i class="glyphicon glyphicon-yen"></i></span>
                                        <input type="text" class="form-control" name="maxPrice" id="maxPrice" placeholder="最大薪资">
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <label  class="col-sm-1 control-label">入职时间</label>
                                <div class="col-sm-5">
                                    <div class="input-group">
                                        <input type="text" class="form-control" name="minEntryDate" id="minDate" placeholder="开始时间">
                                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                                        <input type="text" class="form-control" id="maxEntryDate" placeholder="结束时间">
                                    </div>
                                </div>
                                <label  class="col-sm-1 control-label">角色管理</label>
                                <div class="col-sm-5">
                                    <div class="input-group" id="roleSearch">

                                    </div>
                                </div>
                            </div>
                            <div class="form-group" id="searchAreaSelDiv">
                                <label  class="col-sm-1 control-label">地区</label>
                                <input type="hidden" name="area1" id="area1"/>
                                <input type="hidden" name="area2" id="area2"/>
                                <input type="hidden" name="area3" id="area3"/>
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

            <%--所有按钮--%>
        <div style="background: #2aabd2">
            <button onclick="addu()" type="button" class="btn btn-primary btn-lg"><i class="glyphicon glyphicon-plus">新增</i></button>
            <button onclick="deleteBatch()" type="button" class="btn btn-danger btn-lg"><i class="glyphicon glyphicon-trash">批量删除</i></button>
            <button onclick="downExcel()" type="button" class="btn btn-info btn-lg"><i class="glyphicon glyphicon-download-alt">导出Excel</i></button>
            <button onclick="downExcel()" type="button" class="btn btn-info btn-lg"><i class="glyphicon glyphicon-download-alt">导出Word</i></button>
            <button onclick="downUserPdf()" type="button" class="btn btn-info btn-lg"><i class="glyphicon glyphicon-download-alt">导出Pdf</i></button>

        </div>
            <%--栅格布局第二行  展示的table表格--%>
        <div class="row">
            <div class="col-md-12">
                <div class="panel panel-success">
                    <div class="panel-heading">用户列表</div>
                    <table id="userTable" class="table table-striped table-bordered" style="width:100%">
                        <thead>
                        <tr>
                            <th>选择</th>
                            <th>用户名</th>
                            <th>真实姓名</th>
                            <th>性别</th>
                            <th>年龄</th>
                            <th>电话</th>
                            <th>邮箱</th>
                            <th>薪资</th>
                            <th>入职时间</th>
                            <th>用户角色</th>
                            <th>用户头像</th>
                            <th>状态</th>
                            <th>地区</th>
                            <th>操作</th>

                        </tr>
                        </thead>
                        <tfoot>
                        <tr>
                            <th>选择</th>
                            <th>用户名</th>
                            <th>真实姓名</th>
                            <th>性别</th>
                            <th>年龄</th>
                            <th>电话</th>
                            <th>邮箱</th>
                            <th>薪资</th>
                            <th>入职时间</th>
                            <th>用户角色</th>
                            <th>用户头像</th>
                            <th>状态</th>
                            <th>地区</th>
                            <th>操作</th>
                        </tr>
                        </tfoot>
                    </table>
                </div>
            </div>
        </div>
    </div>
<%--新增的from表单--%>
<div id="addUserDiv" style="display: none">
    <form class="form-horizontal" id="addUserForm">
        <div class="form-group">
            <label class="col-sm-2 control-label">昵称:</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" name="userName" placeholder="请输入用户名" id="add_userName"  >
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">真实姓名:</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" name="realName" placeholder="请输入真实姓名" id="add_realName"  >
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">密码:</label>
            <div class="col-sm-10">
                <input type="password" class="form-control" name="password" placeholder="请输入密码" id="add_password" >
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">确认密码:</label>
            <div class="col-sm-10">
                <input type="password" class="form-control" name="password1" placeholder="请确认密码" id="add_password2" >
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">性别:</label>
            <div class="col-sm-10">
                <input type="radio" name="sex" class="add_sex" value="1" >男
                <input type="radio" name="sex" class="add_sex" value="0" >女
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">年龄:</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" name="age" placeholder="请输入年龄" id="add_age" >
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">电话:</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" name="phone" placeholder="请输入电话" id="add_phone"  >
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">邮箱:</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" name="email" placeholder="请输入邮箱" id="add_email"  >
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">薪资:</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" name="price" placeholder="请输入薪资" id="add_price"  >
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">入职时间:</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" name="entryDate" placeholder="请输入入职时间" id="add_entryDate"  >
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">角色管理:</label>
            <div class="col-sm-10" id="add_role">

            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">用户图片:</label>
            <div class="col-sm-10">
                <input type="file" name="files" class="file-loading" id="add_userImg"  >
                <input type="hidden" id="fileInput"/>
            </div>
        </div>
        <div class="form-group" id="addAreaSelDiv">
            <label class="col-sm-2 control-label">地区:</label>

        </div>
    </form>
</div>
<%--修改的from表单--%>
<div id="updateUserDiv" style="display: none">
    <form class="form-horizontal" id="updateUserFrom">
        <div class="form-group">
            <label class="col-sm-2 control-label">昵称:</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" name="userName" placeholder="请输入用户名" id="update_userName"  >
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">真实姓名:</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" name="realName" placeholder="请输入真实姓名" id="update_realName"  >
            </div>
        </div>

        <div class="form-group">
            <label class="col-sm-2 control-label">性别:</label>
            <div class="col-sm-10">
                <input type="radio" name="sex"  value="1" >男
                <input type="radio" name="sex"  value="0" >女

            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">年龄:</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" name="age" placeholder="请输入年龄" id="update_age" >
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">电话:</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" name="phone" placeholder="请输入电话" id="update_phone"  >
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">邮箱:</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" name="email" placeholder="请输入邮箱" id="update_email"  >
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">薪资:</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" name="price" placeholder="请输入薪资" id="update_price"  >
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">入职时间:</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" name="entryDate" placeholder="请输入入职时间" id="update_entryDate"  >
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">角色管理:</label>
            <div class="col-sm-10" id="update_role">
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">用户图片:</label>
            <div class="col-sm-10">
                <input type="file" name="files" class="file-loading" id="update_userImg"  >
                <input type="hidden" id="updateFileInput"/>
            </div>
        </div>
        <div class="form-group" id="updateAreaSelDiv">
            <label class="col-sm-2 control-label">地区:</label>

        </div>
    </form>
</div>

<jsp:include page="/common/script.jsp"></jsp:include>
<script>
    //获取后台准备好的JSON数据
    var v_userAddFrom;
    var v_userUpdateFrom;
        $(function () {
            initTable();
            backup();
            initDate();
            initSearchDate();
            findRole("add_role","add");
            findRole("update_role","update");
            findRole("roleSearch","search");
            initFileInput("add_userImg","fileInput");
            initDeleteBatch();
            formYZ();
            searchAreaSelect(1);

        })
    /*备份*/
        function backup(){
            v_userAddFrom =  $("#addUserDiv").html();
            v_userUpdateFrom = $("#updateUserDiv").html();
        }
        /*初始化增加修改日期*/
        function initDate(){
            $("#add_entryDate").datetimepicker({
                format: 'YYYY-MM-DD',
                showClear:true,
                locale:"zh-CN",
            });
            $("#update_entryDate").datetimepicker({
                format: 'YYYY-MM-DD',
                showClear:true,
                locale:"zh-CN",
            });
        }
        function initSearchDate(){
            $("#minDate").datetimepicker({
                format: 'YYYY-MM-DD',
                showClear:true,
                locale:"zh-CN",
            });
            $("#maxDate").datetimepicker({
                format: 'YYYY-MM-DD',
                showClear:true,
                locale:"zh-CN",
            });
        }

        function isExist(id){
            for (var i = 0;i<idArr.length;i++){
                if(idArr[i]==id){
                    return true
                }
            }
        }
    /*查询的AJAX  服务器端分页*/
    var searchTable;
    function initTable(){
        searchTable=$("#userTable").DataTable( {
        "aLengthMenu":[2,5,10],//自定义每页展示条数
        "serverSide": true,//开启服务器分页模式
        "searching": false,//是否允许检索
        "language": {
            url:"/js/DataTables/Chinese.json"
        },
        "ajax":{
            url:"/user/findUserList.do",
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
            "drawCallback": function( settings ) {
                //通过id选择器获取当前行
                $("#userTable tbody tr").each(function () {
                    //获取当前行的复选框
                    var v_checkbox = $(this).find("input[type='checkbox']")
                    //获取复选框的value值 也就是Id
                    var v_id = v_checkbox.val();
                    if(isExist(v_id)){
                        v_checkbox.prop("checked",true);
                        $(this).css("background-color","blue");
                    }

                })
            },
        columns: [
            { data: 'id',
                render:function (data,type,row,meta) {
                    return "<input type='checkbox' value='"+data+"'>"
                }
            },
            { data: 'userName'},
            { data: 'realName'},
            { data: 'sex',
                render:function (data,type,row,meta) {
                    return data==0?"女":"男";
                }
            },
            { data: 'age'},
            { data: 'phone'},
            { data: 'email'},
            { data: 'price'},
            { data: 'entryDate'},
            { data: 'roleIds'},
            { data: 'userImg',
                render :function (data,type,row,meta) {
                    return "<img alt='图片' src="+data+" width='60px'/>"
                }
            },
            { data: 'status',
                render :function (data,type,row,meta) {
                    return data?"锁定":"正常"
                }
            },
            { data: 'areaName'},
            { data: "id",
                render:function(data,type,row,meta){
                    return "<div class=\"btn-group\" role=\"group\" aria-label=\"...\">\n" +
                        "  <button type=\"button\" onclick=\"deleteUser('"+data+"')\" class=\"btn btn-danger\"><span class=\"glyphicon glyphicon-trash\"></span>删除</button>\n" +
                        "  <button type=\"button\" onclick=\"findUpdateUser('"+data+"')\" class=\"btn btn-info\"><span class=\"glyphicon glyphicon-pencil\"></span>修改</button>\n" +
                        "  <button type=\"button\" onclick=\"updateLock('"+data+"')\" class=\"btn btn-success\"><span class=\"glyphicon glyphicon-lock\"></span>解锁</button>\n" +
                        "  <button type=\"button\" onclick=\"resetPassword('"+data+"')\" class=\"btn btn-danger\"><span class=\"glyphicon glyphicon-refresh\"></span>重置密码</button>\n" +
                        "</div>";

                }}
        ]
    } );}
    /*重置密码*/
    function resetPassword(userId) {
        //阻止事件冒泡
        event.stopPropagation();
        bootbox.confirm({
            message: "你确认要重置密码么?",
            buttons: {
                confirm: {
                    label: '<span class="glyphicon glyphicon-ok"></span>确认',
                    className: 'btn-success'
                },
                cancel: {
                    label: '<span class="glyphicon glyphicon-remove"></span>关闭',
                    className: 'btn-danger'
                }
            },
            callback: function (result) {
                if (result){
                    $.post({
                        url:"/user/resetPassword.do",
                        data:{
                            "id":userId,
                        },
                        success:function (result) {
                            if (result.code==200){
                                //刷新页面
                                search()
                            }
                        }
                    })
                }
            }
        });
    }

    /*修改状态方法*/
    function updateLock(userId){
        //阻止事件冒泡
        event.stopPropagation();
        bootbox.confirm({
            message: "你确认要修改状态么?",
            buttons: {
                confirm: {
                    label: '<span class="glyphicon glyphicon-ok"></span>确认',
                    className: 'btn-success'
                },
                cancel: {
                    label: '<span class="glyphicon glyphicon-remove"></span>关闭',
                    className: 'btn-danger'
                }
            },
            callback: function (result) {
                if (result){
                    $.post({
                        url:"/user/updateLockStauts.do",
                        data:{
                            "id":userId,
                        },
                        success:function (result) {
                            if (result.code==200){
                                //刷新页面
                                search()
                            }
                        }
                    })
                }
            }
        });
    }

    /*初始化批量删除方法*/
    var idArr = [];
    function initDeleteBatch(){
        $("#userTable tbody").on("click","tr",function(){
            //获取复选框
            var v_checkbox = $(this).find("input[type='checkbox']");
            //获取复选框的选中状态
            var v_checked = v_checkbox.prop("checked");
            if (v_checked){
                //如果复选框被选中，则取消选中，并还原背景色
                v_checkbox.prop("checked",false);
                $(this).css("background-color","");
                //获取
                var v_id = v_checkbox[0].value;
                for (var i =idArr.length-1; i>= 0; i--){
                   if ( idArr[i]==v_id){
                       idArr.splice(i,1);
                   }
                }

            }else {
                v_checkbox.prop("checked",true);
                $(this).css("background-color","blue");
                idArr.push(v_checkbox.val())
               // console.log(ids)

            }
        })
    }
    /*删除方法*/
    function deleteUser(id) {
        //阻止事件冒泡
        event.stopPropagation();
        bootbox.confirm({
            message: "你确认要删除么?",
            buttons: {
                confirm: {
                    label: '<span class="glyphicon glyphicon-ok"></span>确认',
                    className: 'btn-success'
                },
                cancel: {
                    label: '<span class="glyphicon glyphicon-remove"></span>关闭',
                    className: 'btn-danger'
                }
            },
            callback: function (result) {
                if (result){
                    $.post({
                        url:"/user/deleteUser.do",
                        data:{
                            "id":id,
                        },
                        success:function (result) {
                            if (result.code==200){
                                //刷新页面
                                search()
                            }
                        }
                    })
                }
            }
        });
    }

    /*批量删除方法*/
    function deleteBatch(){
        if (idArr.length>0){
            bootbox.confirm({
                message: "你确认要删除么?",
                buttons: {
                    confirm: {
                        label: '<span class="glyphicon glyphicon-ok"></span>确认',
                        className: 'btn-success'
                    },
                    cancel: {
                        label: '<span class="glyphicon glyphicon-remove"></span>关闭',
                        className: 'btn-danger'
                    }
                },
                callback: function (result) {
                    if (result){
                        $.post({
                            url:"/user/deleteBatchUser.do",
                            data:{
                                "idArr":idArr,
                            },
                            success:function (result) {
                                if (result.code==200){
                                    //刷新页面
                                    search()
                                    idArr = [];
                                }
                            }
                        })
                    }
                }
            });
        }else{
            bootbox.alert({
                size: "small",
                title: "提示信息",
                message: "<span class=''></span>请至少选择一项",

            })
        }
    }

    //查询role表的方法   拼接的下拉框
        function findRole(role,prefix) {
            $.post({
                url:"/role/findRole.do",
                success:function (result) {
                    if (result.code==200){
                        var v_roleList = result.data;
                        var sel="<select id='"+prefix+"_roleSel' data-style=\"btn-info\" class='selectpicker' multiple title='请选择角色'>"
                        /*var str = "";*/
                        for (var i=0;i< v_roleList.length;i++){

                            /*str+= "<input type='checkbox' value='"+v_roleList[i].id+"' name='"+prefix+"_roleName'/>"+v_roleList[i].roleName*/
                          sel+="<option value='"+v_roleList[i].id+"' >"+v_roleList[i].roleName+"</option>"
                        }
                        sel+="</select>"
                        $("#"+role).html(sel);
                        $('#'+prefix+"_roleSel").selectpicker('render');
                    }
                }
            })
        }
        //新增页面方法
        var v_userAdd;
             function addu(){
                 formYZ();
                 addAreaSelect(1);
                 v_userAdd=  bootbox.dialog({
                     title:"新增页面",
                     message: $("#addUserDiv form"),
                     size:"large",
                     buttons: {
                         confirm: {
                             label: "<span class='glyphicon glyphicon-ok'></span>保存",
                             className: 'btn-danger',
                        callback: function(){
                            $('#addUserForm',v_userAdd).data('bootstrapValidator').validate();//启用验证
                            var flag = $('#addUserForm',v_userAdd).data('bootstrapValidator').isValid();
                            if(flag==false)
                                return false;
                            //点击确定按钮 发送ajax请求，插入数据
                             var v_userName=$("#add_userName",v_userAdd).val();
                             var v_realName=$("#add_realName",v_userAdd).val();
                             var v_password=$("#add_password",v_userAdd).val();
                             var v_sex= $("input[name=sex]:checked",v_userAdd).val();
                             var v_age=$("#add_age",v_userAdd).val();
                             var v_phone=$("#add_phone",v_userAdd).val();
                             var v_email=$("#add_email",v_userAdd).val();
                             var v_price = $("#add_price",v_userAdd).val();
                             var v_entryDate = $("#add_entryDate",v_userAdd).val();
                             var v_role = $("#add_roleSel",v_userAdd).val().join(",");
                             var v_area1 = $($("select[name='areaName']",v_userAdd)[0]).val();
                             var v_area2 = $($("select[name='areaName']",v_userAdd)[1]).val();
                             var v_area3 = $($("select[name='areaName']",v_userAdd)[2]).val();

                           /* var v_role = "";
                            $("#add_roleSel option:selected",v_userAdd).each(function () {
                                 v_role+=","+this.value
                             })
                                if (v_role.length>0){
                                    v_role= v_role.substring(1);
                                }*/
                              var v_userImg = $("#fileInput",v_userAdd).val();


                             var v_jsonUser ={};
                             v_jsonUser.userName=v_userName;
                             v_jsonUser.realName=v_realName;
                             v_jsonUser.password=v_password;
                             v_jsonUser.sex=v_sex;
                             v_jsonUser.age=v_age;
                             v_jsonUser.phone=v_phone;
                             v_jsonUser.email=v_email;
                             v_jsonUser.price = v_price;
                             v_jsonUser.entryDate = v_entryDate;
                             v_jsonUser.roleIds = v_role;
                             v_jsonUser.userImg = v_userImg;
                             v_jsonUser.area1 = v_area1;
                             v_jsonUser.area2 = v_area2;
                             v_jsonUser.area3 = v_area3;

                           $.ajax({
                                url:"/user/addUser.do",
                                type:"post",
                                data:v_jsonUser,
                                success:function (result) {
                                    if (result.code==200){
                                        alert("添加成功")
                                        search()
                                    }
                                }
                            })
                                 }
                             },
                     cancel: {
                             label: "<span class='glyphicon glyphicon-remove'></span>关闭",
                             className: 'btn-warning',

                         },
                     },
                 })
                 $("#addUserDiv").html(v_userAddFrom);
                 initDate();
                 findRole("add_role",'add');
                 initFileInput("add_userImg","fileInput");
             }
    /*循环获取到的复选框值*/
 /*   function checkRole(id){
        $("select[ name='update_roleName']:selected").each(function () {
            if (this.value == id){
                this.selected=true;
            }
        })
    }*/
    function editArea(obj) {
        //删除这个div，按钮在div里放着，所以找到按钮的上一级，也就是div然后删除
        $(obj).parent().remove();
        //替换文本内容
        updateAreaSelect(1);
        //替换按钮
        $("#updateAreaSelDiv",v_userUpdate).append('<button onclick="cancelEditArea()" type="button" class="btn btn-primary"><i class="glyphicon glyphicon-plus">取消编辑</i></button>')
    }
    function cancelEditArea() {
        //还原我们查询出来展示的数据 也就是后台响应过来的字符串数据
        $("#updateAreaSelDiv",v_userUpdate).html('<label class="col-sm-2 control-label">地区:</label>' +
            '<div>'+v_areaName1+'<button onclick="editArea(this)" type="button" class="btn btn-primary"><i class="glyphicon glyphicon-pencil">编辑</i></button></div>');
    }

    /*回填方法*/
    var v_userUpdate;
    //修改密码的盐  salt
    var v_salt;
    var v_areaName1;
    function findUpdateUser(id){
        event.stopPropagation();
        formUpdateYZ();
        $.post({
            url:"/user/findUpdateUser.do",
            data:{
                "id":id
            },
            success:function(result){
                if(result.code==200){
                    //赋值
                    var v_userName = result.data.userName;
                    var v_realName = result.data.realName;
                    var v_sex = result.data.sex;
                    var v_age = result.data.age;
                    var v_phone = result.data.phone;
                    var v_email = result.data.email;
                    var v_id = result.data.id;
                    var v_price = result.data.price;
                    var v_entryDate = result.data.entryDate;
                    var v_userImg = result.data.userImg;
                    v_salt=result.data.salt;
                    v_areaName1 = result.data.areaName;
                    var v_a1 = result.data.area1;
                    var v_a2 = result.data.area2;
                    var v_a3 = result.data.area3;


                    $("#userId").val(v_id);
                   var v_name= $("#update_userName").val(v_userName);
                   //只读 不可修改
                   v_name.attr("readonly",true);

                    $("#update_realName").val(v_realName);
                    if (v_sex==1){
                            $("input[name='sex'][value='1']").attr("checked",true)
                        }
                        else {
                            $("input[name='sex'][value='0']").attr("checked",true)
                    }
                    $(".update_sex").val(v_sex);
                    $("#update_age").val(v_age);
                    $("#update_phone").val(v_phone);
                    $("#update_email").val(v_email);
                    $("#update_price").val(v_price);
                    $("#update_entryDate").val(v_entryDate);
                    $("#updateAreaSelDiv").append('<div>'+v_areaName1+'<button onclick="editArea(this)" type="button" class="btn btn-primary"><i class="glyphicon glyphicon-pencil">编辑</i></button></div>');
                    var v_roleIdArr = result.data.roleNames;
                    /* 回填复选框 for (var i = 0;i <v_roleIdArr.length;i++){
                         checkRole(v_roleIdArr[i]);
                     }*/
                    //回填下拉框
                    $('#update_roleSel').selectpicker('val', v_roleIdArr);
                    $("#updateFileInput").val(v_userImg);

                    initFileInput("update_userImg","updateFileInput");

                    v_userUpdate =  bootbox.dialog({
                        title:"修改页面",
                        message: $("#updateUserDiv form"),
                        size:"large",
                        buttons: {
                            confirm: {
                                label: "<span class='glyphicon glyphicon-ok'></span>保存",
                                className: 'btn-danger',
                                callback: function(){

                                    $('#updateUserFrom',v_userUpdate).data('bootstrapValidator').validate();//启用验证
                                    var flag = $('#updateUserFrom',v_userUpdate).data('bootstrapValidator').isValid();
                                    if(flag==false)
                                        return false;
                                    //获取文本框的值
                                    var v_updateUserName = $("#update_userName",v_userUpdate).val();
                                    var v_updateRealName = $("#update_realName",v_userUpdate).val();
                                    var v_updateSex = $("input[name=sex]:checked",v_userUpdate).val();
                                    var v_updateAge = $("#update_age",v_userUpdate).val();
                                    var v_updatePhone = $("#update_phone",v_userUpdate).val();
                                    var v_updateEmail = $("#update_email",v_userUpdate).val();
                                    var v_updatePrice = $("#update_price",v_userUpdate).val();
                                    var v_updateEntryDate = $("#update_entryDate",v_userUpdate).val();
                                    //获取下拉框
                                    var v_updateRoleIds = $("#update_roleSel",v_userUpdate).val().join(",");
                                    /*  获取复选框的值
                                    var v_updateRoleIds = "";
                                   $("input[name=update_roleName]:checked",v_userUpdate).each(function () {
                                       v_updateRoleIds+=","+this.value;
                                   })
                                   if (v_updateRoleIds.length>0){
                                       v_updateRoleIds = v_updateRoleIds.substring(1);
                                   }*/
                                    var v_updateUserImg = $("#updateFileInput",v_userUpdate).val();
                                    var v_area = $("select[name='areaName']",v_userUpdate);
                                    var v_area1;
                                    var v_area2;
                                    var v_area3;
                                    if (v_area.length ==3 && $(v_area[2]).val() != -1){
                                        v_area1 = $($("select[name='areaName']",v_userUpdate)[0]).val();
                                        v_area2 = $($("select[name='areaName']",v_userUpdate)[1]).val();
                                        v_area3 = $($("select[name='areaName']",v_userUpdate)[2]).val();
                                    }else {
                                        v_area1=v_a1;
                                        v_area2=v_a2;
                                        v_area3=v_a3;
                                    }

                                    /*数据转换*/
                                    var v_jsonUpdateUser={};
                                    v_jsonUpdateUser.id=id;
                                    v_jsonUpdateUser.userName = v_updateUserName;
                                    v_jsonUpdateUser.realName = v_updateRealName;
                                    v_jsonUpdateUser.sex = v_updateSex;
                                    v_jsonUpdateUser.age = v_updateAge;
                                    v_jsonUpdateUser.phone = v_updatePhone;
                                    v_jsonUpdateUser.email = v_updateEmail;
                                    v_jsonUpdateUser.price= v_updatePrice;
                                    v_jsonUpdateUser.entryDate=v_updateEntryDate;
                                    v_jsonUpdateUser.roleIds = v_updateRoleIds;
                                    v_jsonUpdateUser.userImg = v_updateUserImg;
                                    v_jsonUpdateUser.salt = v_salt;
                                    v_jsonUpdateUser.area1 = v_area1;
                                    v_jsonUpdateUser.area2 = v_area2;
                                    v_jsonUpdateUser.area3 = v_area3;
                                    $.post({
                                        url:"/user/updateUser.do",
                                        data:v_jsonUpdateUser,
                                        success:function (result) {
                                            if (result.code==200){
                                                alert("添加成功")
                                                search()
                                            }
                                        }
                                    })
                                }
                            },
                            cancel: {
                                label: "<span class='glyphicon glyphicon-remove'></span>关闭",
                                className: 'btn-warning',

                            },
                        },
                    })
                    $("#updateUserDiv").html(v_userUpdateFrom);
                    initDate();
                    findRole("update_role",'update');
                }
            }
        })
    }
    /*条件查询*/
    function search(){

        var v_userName = $("#userName").val();
        var v_realName = $("#realName").val();
        var v_minAge = $("#minAge").val();
        var v_maxAge = $("#maxAge").val();
        var v_minPrice = $("#minPrice").val();
        var v_maxPrice = $("#maxPrice").val();
        var v_minDate = $("#minDate").val();
        var v_maxDate = $("#maxDate").val();

        //下拉框
        var v_searchRole = $("#search_roleSel").val().join(",");
        //复选框的时候用的
     /*   var v_searchRole = "";
     $("#search_roleSel option:selected").each(function () {
            v_searchRole+=","+this.value;
        })
        if (v_searchRole.length>0){
            v_searchRole=v_searchRole.substring(1);
        }*/
        var v_area1 = $($("select[name='areaName']",$("#searchAreaSelDiv"))[0]).val();
        var v_area2 = $($("select[name='areaName']",$("#searchAreaSelDiv"))[1]).val();
        var v_area3 = $($("select[name='areaName']",$("#searchAreaSelDiv"))[2]).val();
        var searchJson = {};
        searchJson.userName = v_userName;
        searchJson.realName = v_realName;
        searchJson.minAge = v_minAge;
        searchJson.maxAge = v_maxAge;
        searchJson.minPrice = v_minPrice;
        searchJson.maxPrice = v_maxPrice;
        searchJson.minEntryDate = v_minDate;
        searchJson.maxEntryDate = v_maxDate;
        searchJson.roleIds = v_searchRole;
        searchJson.area1 = v_area1;
        searchJson.area2 = v_area2;
        searchJson.area3 = v_area3;

        searchTable.settings()[0].ajax.data=searchJson;
        searchTable.ajax.reload();
    }
    /*FileInput的图片上传*/
    function initFileInput(prefix,aftrUrl) {
        /*修改回显*/
        if (aftrUrl=="updateFileInput"){
            var url=$("#"+aftrUrl).val();
            var urlArr=[];
            urlArr.push(url);
            console.log(urlArr)
        }
        $("#"+prefix).fileinput({
            language: 'zh', //设置语言
            uploadUrl:"/user/addUserFileInput.do", //上传的地址
            //allowedFileExtensions: ['jpg', 'gif', 'png'],//接收的文件后缀
            //uploadExtraData:{"id": 1, "fileName":'123.mp3'},
            allowedFileExtensions : ["jpg","bmp","png","gif","docx","zip","xlsx","txt"],/*上传文件格式限制*/
            uploadAsync: true, //默认异步上传
            showUpload:true, //是否显示上传按钮
            showRemove :true, //显示移除按钮
            showPreview :true, //是否显示预览
            showCaption:false,//是否显示标题
            browseClass:"btn btn-primary", //按钮样式
            dropZoneEnabled: false,//是否显示拖拽区域
            minImageWidth: 0, //图片的最小宽度
            minImageHeight: 0,//图片的最小高度
            maxImageWidth: 1000,//图片的最大宽度
            maxImageHeight: 1000,//图片的最大高度
            maxFileSize:0,//单位为kb，如果为0表示不限制文件大小
            minFileCount: 0,
            maxFileCount:10, //表示允许同时上传的最大文件个数
            //enctype:'multipart/form-data',
            validateInitialCount:true,
            previewFileIcon: "<iclass='glyphicon glyphicon-king'></i>",
            msgFilesTooMany: "选择上传的文件数量({n}) 超过允许的最大数值{m}！",
            initialPreview:urlArr,
            initialPreviewAsData:true,
            // 默认预览的详细配置，回显时会用到
        }).on("fileuploaded", function (event, data, previewId, index){

            if (prefix=="update_userImg"){
                $("#"+aftrUrl,v_userUpdate).val(data.response.url);
            }else{
                $("#"+aftrUrl,v_userAdd).val(data.response.url);
            }
        });
    }

    function downExcel() {
        var v_userFrom = document.getElementById("searchFrom");

        var v_area1 = $($("select[name='areaName']",$("#searchAreaSelDiv"))[0]).val();
        var v_area2 = $($("select[name='areaName']",$("#searchAreaSelDiv"))[1]).val();
        var v_area3 = $($("select[name='areaName']",$("#searchAreaSelDiv"))[2]).val();

        $("#area1").val(v_area1);
        $("#area2").val(v_area2);
        $("#area3").val(v_area3);
        v_userFrom.action="/user/exportExcle.do";
        v_userFrom.type="post";
        v_userFrom.submit();
    }
    function downUserPdf() {
        location.href = "/user/downUserPdf.do";
    }

    //新增表单验证
    function formYZ(){
        $('#addUserForm').bootstrapValidator({
            message: 'This value is not valid',
            feedbackIcons: {
                valid: 'glyphicon glyphicon-ok',
                invalid: 'glyphicon glyphicon-remove',
                validating: 'glyphicon glyphicon-refresh'
            },
            fields: {
                userName: {
                    validators: {
                        notEmpty: {
                            message: '用户名不能为空'
                        },
                        stringLength: {  //长度限制
                            min: 6,
                            max: 12,
                            message: '用户名长度必须在6到12位之间'
                        },
                        regexp: { //正则表达式
                            regexp: /^[a-zA-Z0-9_]+$/,
                            message: '用户名只能包含大写、小写、数字和下划线'
                        },
                        remote: { // ajax校验，获得一个json数据（{'valid': true or false}）
                            url: '/user/verifyUserName.do',       //验证地址
                            message: '用户已存在',   //提示信息
                            type: 'POST',          //请求方式
                        }
                    }
                },
                realName:{
                    validators: {
                        notEmpty: {
                            message: '真实姓名不能为空'
                        },
                        stringLength: {  //长度限制
                            min: 2,
                            max: 10,
                            message: '真实姓名长度必须在2到10位之间'
                        },
                        regexp: { //正则表达式
                            regexp: /^[\u4e00-\u9fa5]+$/,  //正则中文范围
                            message: '真实姓名只能使用中文'
                        },
                    }
                },
                password: {
                    validators: {
                        notEmpty: {
                            message: '密码不能为空'
                        },
                        stringLength: {  //长度限制
                            min: 8,
                            max: 16,
                            message: '密码长度必须在8到16位之间'
                        },
                        identical: {  //比较是否相同
                            field: 'password1',  //需要进行比较的input name值
                            message: '两次密码不一致'
                        },
                    }
                },
                password1: {
                    validators: {
                        notEmpty: {
                            message: '密码不能为空'
                        },
                        stringLength: {  //长度限制
                            min: 8,
                            max: 16,
                            message: '密码长度必须在8到16位之间'
                        },
                        identical: {  //比较是否相同
                            field: 'password',  //需要进行比较的input name值
                            message: '两次密码不一致'
                        },
                    }
                },
                age:{
                    validators: {
                        notEmpty: {
                            message: '年龄不能为空'
                        },
                        stringLength: {  //长度限制
                            min: 1,
                            max: 3,
                            message: '用户名长度必须在1到3位之间'
                        },
                        regexp: { //正则表达式
                            regexp: /^\+?[1-9][0-9]*$/,
                            message: '只能输入0-9的正整数'
                        },
                    }
                },
                phone:{
                    validators: {
                        notEmpty: {
                            message: '手机号不能为空'
                        },
                        regexp: { //正则表达式
                            regexp: /^1(3|4|5|7|8)\d{9}$/,
                            message: '请输入正式格式，开头必须为1'
                        },
                    }
                },
                email: {
                    validators: {
                        notEmpty: {
                            message: '邮箱不能为空'
                        },
                        emailAddress: {
                            message: '邮箱地址格式有误'
                        }
                    }
                },
                price:{
                    validators: {
                        notEmpty: {
                            message: '薪资不能为空'
                        },

                    },
                }
            }
        });
    }

    //修改表单验证
    function formUpdateYZ(){
        $('#updateUserFrom').bootstrapValidator({
            message: 'This value is not valid',
            feedbackIcons: {
                valid: 'glyphicon glyphicon-ok',
                invalid: 'glyphicon glyphicon-remove',
                validating: 'glyphicon glyphicon-refresh'
            },
            fields: {
                userName: {
                    validators: {
                        notEmpty: {
                            message: '用户名不能为空'
                        },
                        stringLength: {  //长度限制
                            min: 6,
                            max: 12,
                            message: '用户名长度必须在6到12位之间'
                        },
                        regexp: { //正则表达式
                            regexp: /^[a-zA-Z0-9_]+$/,
                            message: '用户名只能包含大写、小写、数字和下划线'
                        },
                    }
                },
                realName:{
                    validators: {
                        notEmpty: {
                            message: '真实姓名不能为空'
                        },
                        stringLength: {  //长度限制
                            min: 2,
                            max: 10,
                            message: '真实姓名长度必须在2到10位之间'
                        },
                        regexp: { //正则表达式
                            regexp: /^[\u4e00-\u9fa5]+$/,  //正则中文范围
                            message: '真实姓名只能使用中文'
                        },
                    }
                },
                password: {
                    validators: {
                        notEmpty: {
                            message: '密码不能为空'
                        },
                        stringLength: {  //长度限制
                            min: 8,
                            max: 16,
                            message: '密码长度必须在8到16位之间'
                        },
                        identical: {  //比较是否相同
                            field: 'password1',  //需要进行比较的input name值
                            message: '两次密码不一致'
                        },
                    }
                },
                password1: {
                    validators: {
                        notEmpty: {
                            message: '密码不能为空'
                        },
                        stringLength: {  //长度限制
                            min: 8,
                            max: 16,
                            message: '密码长度必须在8到16位之间'
                        },
                        identical: {  //比较是否相同
                            field: 'password',  //需要进行比较的input name值
                            message: '两次密码不一致'
                        },
                    }
                },
                age:{
                    validators: {
                        notEmpty: {
                            message: '年龄不能为空'
                        },
                        stringLength: {  //长度限制
                            min: 1,
                            max: 3,
                            message: '用户名长度必须在1到3位之间'
                        },
                        regexp: { //正则表达式
                            regexp: /^\+?[1-9][0-9]*$/,
                            message: '只能输入0-9的正整数'
                        },
                    }
                },
                phone:{
                    validators: {
                        notEmpty: {
                            message: '手机号不能为空'
                        },
                        regexp: { //正则表达式
                            regexp: /^1(3|4|5|7|8)\d{9}$/,
                            message: '请输入正式格式，开头必须为1'
                        },
                    }
                },
                email: {
                    validators: {
                        notEmpty: {
                            message: '邮箱不能为空'
                        },
                        emailAddress: {
                            message: '邮箱地址格式有误'
                        }
                    }
                },
                price:{
                    validators: {
                        notEmpty: {
                            message: '薪资不能为空'
                        },

                    },
                }
            }
        });
    }

   function addAreaSelect(id,obj){
       if (obj){
            $(obj).parent().nextAll().remove();
       }
        $.post({
            url:"/area/findAreaSelect.do",
            data:{
                "id":id,
            },
            success:function (result) {
                if(result.code == 200){
                    var v_areaArr = result.data;
                    if (v_areaArr.length == 0){
                        return "";
                    }
                    var v_select = ' <div class="col-sm-3">' +
                        '<select class="form-control" name="areaName" onchange="addAreaSelect(this.value,this)">';
                    v_select += '<option value="-1">请选择</option>';
                    for (var i = 0; i < v_areaArr.length; i++) {
                        var v_area = v_areaArr[i];
                        v_select +='<option value="'+v_area.id+'">'+v_area.areaName+'</option>';
                    }
                    v_select += '</select></div>';
                    $("#addAreaSelDiv",v_userAdd).append(v_select);
                }
            }
        })
   }
   function searchAreaSelect(id,obj) {
       if (obj){
           $(obj).parent().nextAll().remove();
       }
       $.post({
           url:"/area/findAreaSelect.do",
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
                   $("#searchAreaSelDiv").append(v_select);
               }
           }
       })
   }
   function updateAreaSelect(id,obj){
        if (obj){
            $(obj).parent().nextAll().remove();
        }
        $.post({
            url:"/area/findAreaSelect.do",
            data:{
                "id":id,
            },
            success:function (result) {
                if(result.code == 200){
                    var v_areaArr = result.data;
                    if (v_areaArr.length == 0){
                        return "";
                    }
                    var v_select = ' <div class="col-sm-2">';
                    v_select += '<select class="form-control" name="areaName" onchange="updateAreaSelect(this.value,this)">';
                    v_select += '<option value="-1">请选择</option>';
                    for (var i = 0; i < v_areaArr.length; i++) {
                        var v_area = v_areaArr[i];
                        v_select += '<option value="'+v_area.id+'">'+v_area.areaName+'</option>';
                    }
                    v_select += '</select></div>';
                    $("#updateAreaSelDiv",v_userUpdate).append(v_select);
                }
            }
        })
   }
</script>

</body>
</html>
