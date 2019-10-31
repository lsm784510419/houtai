<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/8/25/025
  Time: 23:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <jsp:include page="/common/head.jsp"></jsp:include>
    <title>地区展示</title>

</head>
<body>
<%--导航条--%>
<jsp:include page="/common/navStatic.jsp"></jsp:include>
<%--展示列表--%>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="panel panel-success">
                <div class="panel-heading">地区展示
                    <button onclick="add()" type="button" class="btn btn-primary "><i class="glyphicon
        glyphicon-plus">新增</i></button>
                    <button onclick="deleteBatchArea()" type="button" class="btn btn-danger "><i class="glyphicon glyphicon-trash">删除</i></button>
                    <button onclick="findAreaUpdate()" type="button" class="btn btn-info "><i class="glyphicon glyphicon-pencil">修改</i></button>
                </div>
                <ul id="areaTree" class="ztree"></ul>
            </div>
        </div>
    </div>
</div>
</div>
<%--新增form表单--%>
<div id="addAreaDiv" style="display: none">
    <form class="form-horizontal">
        <div class="form-group">
            <label class="col-sm-2 control-label">地区名称名称:</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" placeholder="请输入地区名" id="add_areaName" >
            </div>
        </div>

    </form>
</div>
<%--修改form表单--%>
<div id="updateAreaDiv" style="display: none">
    <form class="form-horizontal">
        <div class="form-group">
            <label class="col-sm-2 control-label">地区名称:</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" placeholder="请输入地区名" id="update_areaName" >
            </div>
        </div>

    </form>
</div>
<jsp:include page="/common/script.jsp"></jsp:include>
<script>
    var v_addAreaForm;
    var v_updateAreaForm;
    $(function() {
        initZtree();
        backup();
    })
    /*备份*/
    function backup(){
        v_addAreaForm = $("#addAreaDiv").html();
        v_updateAreaForm = $("#updateAreaDiv").html();
    }

    /*初始化树展示*/
    function initZtree() {
        $.post({
            url:"/area/findAreaList.do",
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
                $.fn.zTree.init($("#areaTree"), setting, result.data);
            }
        })
    }
    var v_areaAdd;
    function add() {
        v_areaAdd= bootbox.dialog({
            title:"新增页面",
            message: $("#addAreaDiv form"),
            size:"large",
            buttons: {
                confirm: {
                    label: "<span class='glyphicon glyphicon-ok'></span>保存",
                    className: 'btn-danger',
                    callback: function(){
                        //点击确定按钮 发送ajax请求，插入数据
                        //获取当前树
                        var treeObj = $.fn.zTree.getZTreeObj("areaTree");
                        //获取选中的所有节点
                        var nodes = treeObj.getSelectedNodes();

                        if (nodes.length==1){
                            var v_addAreaName = $("#add_areaName",v_areaAdd).val();
                            var v_fatherId = nodes[0].id;
                            $.post({
                                url:"/area/addArea.do",
                                data:{
                                    "areaName":v_addAreaName,
                                    "fatherId":v_fatherId
                                },
                                success:function (result) {
                                    if (result.code==200){
                                        //刷新页面
                                        alert("增加成功")
                                        var newNode = {"id":result.data,name:v_addAreaName,pId:v_fatherId};
                                        treeObj.addNodes(nodes[0], newNode);
                                    }
                                }
                            })
                        }
                        else if (nodes.length>1){
                            bootbox.alert({
                                size: "small",
                                title: "提示信息",
                                message: "<span class='glyphicon glyphicon-exclamation-sign'></span>最多选择一项",
                            })
                        }else{
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
         $("#addAreaDiv").html(v_addAreaForm);
    }
    /*修改方法*/
    var v_areaUpdate;
    function findAreaUpdate(){
        //获取当前树
        var treeObj = $.fn.zTree.getZTreeObj("areaTree");
        //获取选中的所有节点
        var nodes = treeObj.getSelectedNodes();

        if (nodes.length==1){
            var v_areaName = nodes[0].name;
            $("#update_areaName").val(v_areaName);
            v_areaUpdate= bootbox.dialog({
                title:"修改页面",
                message: $("#updateAreaDiv form"),
                size:"large",
                buttons: {
                    confirm: {
                        label: "<span class='glyphicon glyphicon-ok'></span>保存",
                        className: 'btn-danger',
                        callback: function(){
                            //点击确定按钮 发送ajax请求，插入数据
                            var v_id = nodes[0].id;
                            var v_updateAreaName = $("#update_areaName",v_areaUpdate).val()
                            $.post({
                                url:"/area/updateArea.do",
                                data:{
                                    "id":v_id,
                                    "areaName":v_updateAreaName
                                },
                                success:function (result) {
                                    if (result.code==200){
                                        alert("修改成功");
                                        //刷新页面
                                        nodes[0].name = v_updateAreaName;
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
      $("#updateAreaDiv").html(v_updateAreaForm);

    }
    function deleteBatchArea(){
        //获取当前树
        var treeObj = $.fn.zTree.getZTreeObj("areaTree");
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
                                url:"/area/deleteArea.do",
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
</script>
</body>
</html>
