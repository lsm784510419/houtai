<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/8/21/021
  Time: 22:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <jsp:include page="/common/head.jsp"></jsp:include>
    <title>角色展示页面</title>

</head>
<body>
<%--导航条--%>
<jsp:include page="/common/navStatic.jsp"></jsp:include>

<div class="container">
    <%--所有按钮--%>
    <div style="background: #2aabd2">
        <button onclick="add()" type="button" class="btn btn-primary btn-lg"><i class="glyphicon glyphicon-plus">新增</i></button>
    </div>
    <%--栅格布局第二行  展示的table表格--%>
    <div class="row">
        <div class="col-md-12">
            <div class="panel panel-success">
                <div class="panel-heading">角色列表</div>
                <table id="roleTable" class="table table-striped table-bordered" style="width:100%">
                    <thead>
                    <tr>
                        <th>id</th>
                        <th>角色名</th>
                        <th>操作</th>
                    </tr>
                    </thead>
                    <tfoot>
                    <tr>
                        <th>id</th>
                        <th>角色名</th>
                        <th>操作</th>
                    </tr>
                    </tfoot>
                </table>
            </div>
        </div>
    </div>
</div>
<%--新增的from表单--%>
<div id="addRoleDiv" style="display: none">
    <form class="form-horizontal">
        <div class="form-group">
            <label class="col-sm-2 control-label">角色名:</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" placeholder="请输入角色名" id="add_roleName"  >
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">权限名:</label>
            <div class="col-sm-10">
            <ul id="add_menuTree" class="ztree"></ul>
            </div>
        </div>
    </form>
</div>
<%--修改的from表单--%>
<div id="updateRoleDiv"style="display: none">
    <form class="form-horizontal">
        <div class="form-group">
            <label class="col-sm-2 control-label">角色名:</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" placeholder="请输入角色名" id="update_roleName"  >
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">权限名:</label>
            <div class="col-sm-10">
                <ul id="update_menuTree" class="ztree"></ul>
            </div>
        </div>
    </form>
</div>
<jsp:include page="/common/script.jsp"></jsp:include>
<script>
    var addFrom;
    var updateFrom;
    $(function(){
        initZtree();
        initTable();
        addFrom=  $("#addRoleDiv").html()
        updateFrom=  $("#updateRoleDiv").html()
    })
    var roleTable;
    function initTable(){
        roleTable=  $("#roleTable").DataTable( {
            "aLengthMenu":[2,5,10],//自定义每页展示条数
            "serverSide": true,//开启服务器分页模式
            "searching": false,//是否允许检索
            "language": {
                url:"/js/DataTables/Chinese.json"
            },
            "ajax":{
                url:"<%=request.getContextPath()%>/role/findRoleList.do",
                type:"post",
            },
            columns: [
                { data: 'id' },
                { data: 'roleName'},
                { data: "id",
                    render:function(data,type,row,meta){
                        return "<div class=\"btn-group\" role=\"group\" aria-label=\"...\">\n" +
                            "  <button type=\"button\" onclick=\"deleteRole('"+data+"')\" class=\"btn btn-danger\"><span class=\"glyphicon glyphicon-trash\"></span>删除</button>\n" +
                            "  <button type=\"button\" onclick=\"findUpdateRole('"+data+"')\" class=\"btn btn-info\"><span class=\"glyphicon glyphicon-pencil\"></span>修改</button>\n" +
                            "</div>";

                    }}
            ]
        } );}

    //新增页面方法
    var v_roleAdd;
    var v_menuIds = [];
    function add(){
        v_roleAdd =  bootbox.dialog({
            title:"新增页面",
            message: $("#addRoleDiv form"),
            size:"large",
            buttons: {
                confirm: {
                    label: "<span class='glyphicon glyphicon-ok'></span>保存",
                    className: 'btn-danger',
                    callback: function(){
                        //点击确定按钮 发送ajax请求，插入数据
                        var v_roleName=$("#add_roleName",v_roleAdd).val();
                        //获取树
                        var treeObj = $.fn.zTree.getZTreeObj("add_menuTree");
                        //获取所有复选框的集合
                        var checkedNodes = treeObj.getCheckedNodes(true);
                        $(checkedNodes).each(function () {
                            v_menuIds.push(this.id)
                        })

                        $.ajax({
                            url:"/role/addRole.do",
                            type:"post",
                            data:{
                                "roleName":v_roleName,
                                "menuIds":v_menuIds
                            },
                            success:function (result) {
                                if (result.code==200){
                                    alert("添加成功")
                                    roleTable.ajax.reload();
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
        $("#addRoleDiv").html(addFrom);
        initZtree();
    }

    //删除方法
    function deleteRole(id) {
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
                        url:"/role/deleteRole.do",
                        data:{
                            "id":id,
                        },
                        success:function (result) {
                            if (result.code==200){
                                bootbox.alert({
                                    size: "small",
                                    title: "提示信息",
                                    message: "<span class='glyphicon glyphicon-exclamation-sign'></span>删除成功"
                                });
                                location.reload();
                            }
                        }
                    })
                }
            }
        });
    }

    /*修改方法*/
    var v_roleUpdate;

    function findUpdateRole(id){
        initZtreeUpdate();
        $.post({
            url:"/role/findUpdateRole.do",
            data:{
                "id":id
            },
            success:function(result){
                if(result.code==200){
                    //赋值
                     var v_data=result.data;
                    var v_roleName = v_data.roleName;

                    $("#update_roleName").val(v_roleName);

                    //回填树
                    //先拿到后台传过来的menuId数组
                   var menuIdArr = v_data.list;
                   //获取树
                    var treeObj = $.fn.zTree.getZTreeObj("update_menuTree");
                    //循环后台传过来的menuIdArr数组
                    for(var i=0;i<menuIdArr.length;i++){
                        //因为要回显，回显出来的就是menuid
                        var v_id = menuIdArr[i];
                        //通过ztree的这个方法将查出来的id赋值给每个node节点
                        var v_node = treeObj.getNodeByParam("id",v_id, null);
                        console.log(v_node)
                        //将复选框选中的节点勾住   此方法是勾住节点
                        treeObj.checkNode(v_node,true);
                    }
                    v_roleUpdate =  bootbox.dialog({
                        title:"修改页面",
                        message: $("#updateRoleDiv form"),
                        size:"large",
                        buttons: {
                            confirm: {
                                label: "<span class='glyphicon glyphicon-ok'></span>保存",
                                className: 'btn-danger',
                                callback: function(){
                                    //获取文本框的值
                                    var v_update_roleName = $("#update_roleName",v_roleUpdate).val();

                                    var v_jsonUpdateRole={};
                                    v_jsonUpdateRole.id=id;
                                    v_jsonUpdateRole.roleName = v_update_roleName;
                                    //因为回显已经获取过树 所以直接获取复选框
                                    var v_nodes=treeObj.getCheckedNodes(true);
                                    var menuIds= [];
                                    $(v_nodes).each(function () {
                                        menuIds.push(this.id)
                                    })
                                    if(menuIds.length==0){
                                        menuIds.push(-1)
                                    }
                                        v_jsonUpdateRole.menuIds = menuIds;
                                    $.post({
                                        url:"/role/updateRole.do",
                                        data:v_jsonUpdateRole,
                                        success:function (result) {
                                            if (result.code==200){
                                                alert("添加成功")
                                                location.reload();
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
                    $("#updateRoleDiv").html(updateFrom)
                }
            }
        })
    }

    /*初始化新增树*/
    function initZtree() {
        $.post({
            url:"/menu/findMenuList.do",
            success:function(result) {
                if (result.code==200){
                    var setting = {
                        check: {
                            enable: true,
                            chkboxType:{ "Y" : "ps", "N" : "s" },
                        },
                        data: {
                            simpleData: {
                                enable: true
                            }
                        }
                    };
                }
                if (v_roleAdd){
                    $.fn.zTree.init($("#add_menuTree",v_roleAdd), setting, result.data);
                } else {
                    $.fn.zTree.init($("#add_menuTree"), setting, result.data);
                }

            }
        })
    }
    /*初始化修改树*/
    function initZtreeUpdate() {
        $.post({
            url:"/menu/findMenuList.do",
            async:false,
            success:function(result) {
                if (result.code==200){
                    var setting = {
                        check: {
                            enable: true,
                            chkboxType:{ "Y" : "ps", "N" : "s" },
                        },
                        data: {
                            simpleData: {
                                enable: true
                            }
                        }
                    };
                }
                $.fn.zTree.init($("#update_menuTree"), setting, result.data);

            }
        })
    }
    </script>
</body>
</html>
