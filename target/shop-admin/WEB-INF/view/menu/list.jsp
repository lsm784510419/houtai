    <%--
      Created by IntelliJ IDEA.
      User: Administrator
      Date: 2019/8/25/025
      Time: 18:29
      To change this template use File | Settings | File Templates.
    --%>
        <%@ page contentType="text/html;charset=UTF-8" language="java" %>
        <!DOCTYPE html>
        <html lang="zh-CN">
        <head>
        <jsp:include page="/common/head.jsp"></jsp:include>
        <title>菜单页面</title>


        </head>
        <body>
        <%--导航条--%>
        <jsp:include page="/common/navStatic.jsp"></jsp:include>
            <%--展示列表--%>
        <div class="container">
        <div class="row">
        <div class="col-md-12">
        <div class="panel panel-success">
        <div class="panel-heading">菜单展示
        <button onclick="add()" type="button" class="btn btn-primary "><i class="glyphicon
        glyphicon-plus">新增</i></button>
        <button onclick="deleteMenu()" type="button" class="btn btn-danger "><i class="glyphicon glyphicon-trash">删除</i></button>
        <button onclick="findMenuUpdate()" type="button" class="btn btn-info "><i class="glyphicon glyphicon-pencil">修改</i></button>
        </div>
        <ul id="menuTree" class="ztree"></ul>
        </div>
        </div>
        </div>
        </div>
        </div>
            <%--新增form表单--%>
            <div id="addMenuDiv" style="display: none">
            <form class="form-horizontal">
            <div class="form-group">
            <label class="col-sm-2 control-label">菜单名称:</label>
            <div class="col-sm-10">
            <input type="text" class="form-control" placeholder="请输入菜单名" id="add_menuName" >
            </div>
            </div>
            <div class="form-group">
        <label class="col-sm-2 control-label">菜单类型:</label>
        <div class="col-sm-10">
        <input type="radio" name="menuType" value="1">菜单
        <input type="radio" name="menuType" value="2">按钮
        </div>
        </div>
            <div class="form-group">
        <label class="col-sm-2 control-label">菜单路径:</label>
        <div class="col-sm-10">
        <input type="text" class="form-control" placeholder="请输入菜单名" id="add_menuUrl" >
        </div>
        </div>

            </form>
            </div>
            <%--修改form表单--%>
            <div id="updateMenuDiv" style="display: none">
            <form class="form-horizontal">
            <div class="form-group">
            <label class="col-sm-2 control-label">菜单名称:</label>
            <div class="col-sm-10">
            <input type="text" class="form-control" placeholder="请输入菜单名" id="update_menuName" >
            </div>
            </div>
        <div class="form-group">
        <label class="col-sm-2 control-label">菜单类型:</label>
        <div class="col-sm-10">
        <input type="radio" name="updatemenuType" value="1">菜单
        <input type="radio" name="updatemenuType" value="2">按钮
        </div>
        </div>
        <div class="form-group">
        <label class="col-sm-2 control-label">菜单路径:</label>
        <div class="col-sm-10">
        <input type="text" class="form-control" placeholder="请输入菜单名" id="update_menuUrl" >
        </div>
        </div>

            </form>
            </div>
        <jsp:include page="/common/script.jsp"></jsp:include>
        <script>
        var v_addMenuForm;
        var v_updateMenuForm;
            /*页面加载事件*/
        $(function() {
        initZtree();
            backup();
        })
        /*备份*/
        function backup(){
        v_addMenuForm = $("#addMenuDiv").html();
        v_updateMenuForm = $("#updateMenuDiv").html();
        }
        /*初始化树*/
        function initZtree() {
        $.post({
        url:"/menu/findMenuList.do",
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
        $.fn.zTree.init($("#menuTree"), setting, result.data);
        }
        })
        }
        //新增页面方法
        var v_menuAdd;
        function add(){
        v_menuAdd= bootbox.dialog({
        title:"新增页面",
        message: $("#addMenuDiv form"),
        size:"large",
        buttons: {
        confirm: {
        label: "<span class='glyphicon glyphicon-ok'></span>保存",
        className: 'btn-danger',
        callback: function(){
        //点击确定按钮 发送ajax请求，插入数据
        var treeObj = $.fn.zTree.getZTreeObj("menuTree");
        var nodes = treeObj.getSelectedNodes();
        if (nodes.length==1){
        var v_add_menuName = $("#add_menuName",v_menuAdd).val();
        var v_fatherId = nodes[0].id;
        var v_menuType = $("input[name=menuType]:checked",v_menuAdd).val();
        var v_add_menuUrl = $("#add_menuUrl",v_menuAdd).val();
        $.ajax({
        url:"/menu/addMenu.do",
        type:"post",
        data:{
        "fatherId":v_fatherId,
        "menuName":v_add_menuName,
        "menuType":v_menuType,
        "menuUrl":v_add_menuUrl
        },
        success:function (result) {
        if (result.code==200){
        alert("添加成功")
        var newNode = {"id":result.data,"name":v_add_menuName,"pId":v_fatherId,"menuType":v_menuType,"menuUrl":v_add_menuUrl};
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
        $("#addMenuDiv").html( v_addMenuForm);

        }





        /*修改方法*/
        var v_menuUpdate;
        function findMenuUpdate() {

            //获取树
            var treeObj = $.fn.zTree.getZTreeObj("menuTree");
            //获取所有节点数据
            var nodes = treeObj.getSelectedNodes();
        if (nodes.length==1){
            console.log(nodes)
            var v_menuName = nodes[0].name;
            $("#update_menuName").val(v_menuName);
           $("input[name=updatemenuType]").each(function() {
                if (this.value==nodes[0].menuType){
                    this.checked=true;
        }
        })
           $("#update_menuUrl").val(nodes[0].menuUrl)
            v_menuUpdate= bootbox.dialog({
            title:"修改页面",
            message: $("#updateMenuDiv form"),
            size:"large",
            buttons: {
            confirm: {
            label: "<span class='glyphicon glyphicon-ok'></span>保存",
            className: 'btn-danger',
            callback: function(){
            //点击确定按钮 发送ajax请求，插入数据

            var v_id = nodes[0].id;
            var v_update_menuName = $("#update_menuName",v_menuUpdate).val();
            var v_updatemenuType = $("input[name=updatemenuType]:checked",v_menuUpdate).val();
            var v_updateMenuUrl = $("#update_menuUrl",v_menuUpdate).val();
            $.ajax({
            url:"/menu/updateMenu.do",
            type:"post",
            data:{
            "id":v_id,
            "menuName":v_update_menuName,
            "menuType":v_updatemenuType,
             "menuUrl":v_updateMenuUrl
            },
            success:function (result) {
            if (result.code==200){
            alert("修改成功")
            //刷新页面
                nodes[0].name = v_update_menuName;
                nodes[0].menuUrl = v_updateMenuUrl;
                nodes[0].menuType = v_updatemenuType;
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
        }   else if (nodes.length>1){
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
            $("#updateMenuDiv").html(v_updateMenuForm);



        }
        /*删除方法*/
        function deleteMenu() {
            //获取当前树
            var treeObj = $.fn.zTree.getZTreeObj("menuTree");
            /*获取所有选中的节点*/
            var nodes = treeObj.getSelectedNodes();
            if (nodes.length>0){
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
                console.log(nodeArr)
                 //id :"",name:"",pId:"",
                var id = [];
                for (var i =0;i<nodeArr.length;i++){
                        id.push(nodeArr[i].id);
                        $.post({
                                url:"/menu/deleteMenu.do",
                                data:{
                                    "id":id,
                                 },
                                success:function(result) {
                                if (result.code==200){
                                    for (var i =nodeArr.length-1;i>=0;i--){
                                        treeObj.removeNode(nodeArr[i]);
                          }
            }
            }
                        })
            }
            }
            }
            });
            }
        else{
        bootbox.alert({
        message: "<span class='glyphicon glyphicon-exclamation-sign'></span>请选择一个节点",
        size: 'small',
        title: "提示信息"
        });
        }
        }
        </script>
        </body>
        </html>
