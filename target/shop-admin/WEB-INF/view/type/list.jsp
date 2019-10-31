<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/9/20/020
  Time: 12:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="/common/head.jsp"></jsp:include>
    <title>分类页面</title>
</head>
<body>
<jsp:include page="/common/navStatic.jsp"></jsp:include>
<%--展示列表--%>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="panel panel-success">
                <div class="panel-heading">分类展示
                    <button onclick="addType()" type="button" class="btn btn-primary "><i class="glyphicon
        glyphicon-plus">新增</i></button>
                    <button onclick="deleteBatchType()" type="button" class="btn btn-danger "><i class="glyphicon glyphicon-trash">删除</i></button>
                    <button onclick="findTypeUpdate()" type="button" class="btn btn-info "><i class="glyphicon glyphicon-pencil">修改</i></button>
                </div>
                <ul id="typeTree" class="ztree"></ul>
            </div>
        </div>
    </div>
</div>
<%--新增form表单--%>
<div id="addTypeDiv" style="display: none">
    <form class="form-horizontal">
        <div class="form-group">
            <label class="col-sm-2 control-label">类型名称:</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" placeholder="请输入类型名..." id="add_typeName" >
            </div>
        </div>

    </form>
</div>

<%--修改form表单--%>
<div id="updateTypeDiv" style="display: none">
    <form class="form-horizontal">
        <div class="form-group">
            <label class="col-sm-2 control-label">类型名称:</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" placeholder="请输入类型名..." id="update_typeName" >
            </div>
        </div>

    </form>
</div>

<jsp:include page="/common/script.jsp"></jsp:include>

<script>
    $(function () {
        initZtree();
        backUp();
    })
    /*备份*/
    var v_addTypeForm;
    var v_updateTyeForm;
    function backUp(){
        v_addTypeForm = $("#addTypeDiv").html();
        v_updateTyeForm = $("#updateTypeDiv").html();
    }
    /*初始化树展示*/
    function initZtree() {
        $.post({
            url:"/type/findTypeList.do",
            success:function(result) {
                if (result.code==200){
                    var setting = {
                        data: {
                            simpleData: {
                                enable: true
                            }
                        }
                    };
                }
                $.fn.zTree.init($("#typeTree"), setting, result.data);
            }
        })
    }
    /*新增页面*/
    var v_typeAdd;
    function addType() {
        v_typeAdd= bootbox.dialog({
            title:"新增页面",
            message: $("#addTypeDiv form"),
            size:"large",
            buttons: {
                confirm: {
                    label: "<span class='glyphicon glyphicon-ok'></span>保存",
                    className: 'btn-danger',
                    callback: function(){
                        //点击确定按钮 发送ajax请求，插入数据
                        //获取当前树
                        var treeObj = $.fn.zTree.getZTreeObj("typeTree");
                        //获取选中的所有节点
                        var nodes = treeObj.getSelectedNodes();
                        if (nodes.length==1){
                            var v_addTypeName = $("#add_typeName",v_typeAdd).val();
                            var v_pid = nodes[0].id;
                            $.post({
                                url:"/type/addType.do",
                                data:{
                                    "typeName":v_addTypeName,
                                    "pid":v_pid,
                                },
                                success:function (result) {
                                    if (result.code==200){
                                        //刷新页面
                                        alert("增加成功")
                                        var newNode = {"id":result.data,"name":v_addTypeName,"pId":v_pid};
                                        treeObj.addNodes(nodes[0],newNode);
                                    }
                                }
                            })

                        } else if (nodes.length>1){
                            bootbox.alert({
                                size: "small",
                                title: "提示信息",
                                message: "<span class='glyphicon glyphicon-exclamation-sign'></span>最多选择一项",
                            })
                        } else{
                            bootbox.alert({
                                size: "small",
                                title: "提示信息",
                                message: "<span class='glyphicon glyphicon-exclamation-sign'></span>至少选择一项",
                            })
                        }

                    }
                },
                cancel: {
                    label: "<span class='glyphicon glyphicon-remove'></span>关闭",
                    className: 'btn-warning',

                },
            },
        })
          $("#addTypeDiv").html(v_addTypeForm);
    }
    /*删除方法*/
    function deleteBatchType(){
        //获取当前树
        var treeObj = $.fn.zTree.getZTreeObj("typeTree");
        //获取选中的所有节点
        var nodes = treeObj.getSelectedNodes();
        if(nodes.length>0){
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
                        //获取当前选中的节点以及他的子节点
                        var nodeArr =  treeObj.transformToArray(nodes);
                        var ids = [];
                        for (var i=0;i<nodeArr.length;i++){
                            ids.push(nodeArr[i].id);
                            $.post({
                                url:"/type/deleteType.do",
                                data:{
                                    "ids":ids
                                },
                                success:function (result) {
                                    if (result.code==200){
                                        for (var i=nodeArr.length-1;i>=0;i--){
                                            treeObj.removeNode(nodeArr[i]);
                                        }
                                    }
                                }
                            })
                        }
                    }
                }
            });
        }else{
            bootbox.alert({
                size: "small",
                title: "提示信息",
                message: "<span class='glyphicon glyphicon-exclamation-sign'></span>至少选择一项",
            })
        }
    }
    /*修改树*/
    var v_treeUpdate;
    function findTypeUpdate(){
        //获取当前树
        var treeObj = $.fn.zTree.getZTreeObj("typeTree");
        //获取选中的所有节点
        var nodes = treeObj.getSelectedNodes();

        if (nodes.length==1){
            var v_treeName = nodes[0].name;
            $("#update_typeName").val(v_treeName);
            v_treeUpdate= bootbox.dialog({
                title:"修改页面",
                message: $("#updateTypeDiv form"),
                size:"large",
                buttons: {
                    confirm: {
                        label: "<span class='glyphicon glyphicon-ok'></span>保存",
                        className: 'btn-danger',
                        callback: function(){
                            //点击确定按钮 发送ajax请求，插入数据
                            var v_id = nodes[0].id;
                            var v_updateTreeName = $("#update_typeName",v_treeUpdate).val()
                            $.post({
                                url:"/type/updateType.do",
                                data:{
                                    "id":v_id,
                                    "typeName":v_updateTreeName
                                },
                                success:function (result) {
                                    if (result.code==200){
                                        alert("修改成功");
                                        //刷新页面
                                        nodes[0].name = v_updateTreeName;
                                        treeObj.updateNode(nodes[0]);
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
        } else if(nodes.length>1){
            bootbox.alert({
                size: "small",
                title: "提示信息",
                message: "<span class='glyphicon glyphicon-exclamation-sign'></span>最多选择一项",
            })
        }else {
            bootbox.alert({
                size: "small",
                title: "提示信息",
                message: "<span class='glyphicon glyphicon-exclamation-sign'></span>至少选择一项",
            })
        }
         $("#updateTypeDiv").html(v_updateTyeForm);
    }
</script>
</body>
</html>
