<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/8/24/024
  Time: 17:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="/common/head.jsp"></jsp:include>
    <title>品牌页面</title>

</head>
<body>
<%--导航条--%>
<jsp:include page="/common/navStatic.jsp"></jsp:include>

<%--所有按钮--%>
<div style="background: #2aabd2">
    <button onclick="addBrand()" type="button" class="btn btn-primary btn-lg"><i class="glyphicon glyphicon-plus">新增</i></button>
    <button onclick="" type="button" class="btn btn-danger btn-lg"><i class="glyphicon glyphicon-trash">批量删除</i></button>
</div>

<%--栅格布局  展示的table表格--%>
<div class="row">
    <div class="col-md-12">
        <div class="panel panel-success">
            <div class="panel-heading">商品列表</div>
            <table id="brandTable" class="table table-striped table-bordered" style="width:100%">
                <thead>
                <tr>
                    <th>id</th>
                    <th>品牌名</th>
                    <th>品牌图片</th>
                    <th>是否热销</th>
                    <th>排序</th>
                    <th>操作</th>

                </tr>
                </thead>
                <tfoot>
                <tr>
                    <th>id</th>
                    <th>品牌名</th>
                    <th>品牌图片</th>
                    <th>是否热销</th>
                    <th>排序</th>
                    <th>操作</th>
                </tr>
                </tfoot>
            </table>
        </div>
    </div>
</div>
<%--新增的form表单--%>
<div id="addBrandDiv" style="display: none">
    <form class="form-horizontal">
        <div class="form-group">
            <label class="col-sm-2 control-label">品牌名:</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" placeholder="请输入商品名" id="add_brandName"  >
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">图片:</label>
            <div class="col-sm-10">
                <input type="file" name="files" id="add_brandImg" class="file-loading">
                <input type="hidden"  id="fileInput" >
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">是否热销:</label>
            <div class="col-sm-10">
                <input type="radio" value="1" name="add_hot">热销
                <input type="radio" value="0" name="add_hot">非热销
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">排序:</label>
            <div class="col-sm-10">
                <input type="text" id="add_sort">
            </div>
        </div>
    </form>
</div>
<%--修改的form表单--%>
<div id="updateBrandDiv" style="display: none">
    <form class="form-horizontal">
        <div class="form-group">
            <label class="col-sm-2 control-label">品牌名:</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" placeholder="请输入商品名" id="update_brandName"  >
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">图片:</label>
            <div class="col-sm-10">
                <input type="file" name="files" id="update_brandImg" >
                <input type="text"  id="updateFileInput" >
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">是否热销:</label>
            <div class="col-sm-10">
                <input type="radio" value="1" name="update_hot">热销
                <input type="radio" value="0" name="update_hot">非热销
            </div>
        </div>
    </form>
</div>
<jsp:include page="/common/script.jsp"></jsp:include>

<script>
    var v_brandAddFrom;
    var v_brandUpdateFrom;
    /*页面加载事件*/
    $(function () {

        initTable();

        backup();
        initFileInput("add_brandImg","fileInput");

    })

    /*备份*/
    function backup(){
        v_brandAddFrom =  $("#addBrandDiv").html();
        v_brandUpdateFrom = $("#updateBrandDiv").html();
    }
    /*全局变量 获取图片用*/
    var v_ossBrandImg;
    /*展示页面*/
    function initTable(){

        $("#brandTable").DataTable( {

            "aLengthMenu":[2,5,10],//自定义每页展示条数
            "serverSide": true,//开启服务器分页模式
            "searching": false,//是否允许检索
            "language": {
                url:"/js/DataTables/Chinese.json"
            },

            "ajax":{
                url:"/brand/findPageBrandList.do",
                type:"post",
            },
            columns: [
                { data: 'id' },
                { data: 'brandName' },
                { data: 'brandImg',
                    render:function (data,type,row,meta) {
                        return "<img alt='图片' src="+data+" width='60px'/>"
                    }
                },
                { data: 'isHot',
                    render:function (data,type,row,meta) {
                        return data==1?"热销":"非热销";
                    }
                },
                { data: 'isSort',
                    render:function (data,type,row,meta) {
                    var v_id = row.id;
                        return '<input type="text" class="form-control" id="v_sort'+v_id+'" value="'+data+'">' +
                            '<button onclick="updateSort('+v_id+')" type="button" class="btn btn-primary"><i class="glyphicon glyphicon-plus">更新</i></button>';
                    }
                },
                { data: "id",
                    render:function(data,type,row,meta){
                        /*获取图片路径*/
                        v_ossBrandImg = row.brandImg;
                        var v_test = "";
                        var v_icon = "";
                        var v_color = "";
                        var v_isHot = 0;
                        if (row.isHot == 1){
                            v_test = "非热销";
                            v_icon = "glyphicon glyphicon-hand-down";
                            v_color = "btn btn-warning";
                            v_isHot = 0;
                        }else {
                            v_test = "热销";
                            v_icon = "glyphicon glyphicon-hand-up";
                            v_color = "btn btn-success";
                            v_isHot = 1;
                        }
                        return "<div class=\"btn-group\" role=\"group\" aria-label=\"...\">\n" +
                            "  <button type=\"button\" onclick=\"deleteBrand('"+data+"','"+v_ossBrandImg+"')\" class=\"btn btn-danger\"><span class=\"glyphicon glyphicon-trash\"></span>删除</button>\n" +
                            "  <button type=\"button\" onclick=\"updateBrand('"+data+"')\" class=\"btn btn-info\"><span class=\"glyphicon glyphicon-pencil\"></span>修改</button>\n" +
                            "  <button type=\"button\" onclick=\"updateHot('"+data+"','"+v_isHot+"')\" class='"+v_color+"'><span class='"+v_icon+"'></span>"+v_test+"</button>\n" +
                            "</div>";

                    }}
            ]
        } );}
    /*修改排序信息*/
    function updateSort(id){
        bootbox.confirm({
            message: "你确认要修改排序信息么?",
            buttons: {
                confirm: {
                    label: '<span class="glyphicon   glyphicon-ok"></span>确认',
                    className: 'btn-success'
                },
                cancel: {
                    label: '<span class="glyphicon glyphicon-remove"></span>关闭',
                    className: 'btn-danger'
                }
            },
            callback: function (result) {
                var v_sort = $("#v_sort"+id).val();
                console.log(v_sort)
                if (result){
                    $.post({
                        url:"/brand/updateIsSort.do",
                        data:{
                            "id":id,
                            "isSort":v_sort,
                        },
                        success:function (result) {
                            if (result.code==200){
                                //刷新页面
                                location.reload();
                            }
                        }
                    })
                }
            }
        });
    }
    /*修改品牌热销状态*/
    function updateHot(id,hot) {
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
                        url:"/brand/updateIsHot.do",
                        data:{
                            "id":id,
                            "isHot":hot,
                        },
                        success:function (result) {
                            if (result.code==200){
                                //刷新页面
                                location.reload();
                            }
                        }
                    })
                }
            }
        });
    }
    /*新增的ajax*/
    var v_brandAdd;
    function addBrand(){
        v_brandAdd=  bootbox.dialog({
            title:"新增页面",
            message: $("#addBrandDiv form"),
            size:"large",
            buttons: {
                confirm: {
                    label: "<span class='glyphicon glyphicon-ok'></span>保存",
                    className: 'btn-danger',
                    callback: function(){
                        //点击确定按钮 发送ajax请求，插入数据
                        var v_brandName = $("#add_brandName",v_brandAdd).val();
                        var v_add_brandImg = $("#fileInput",v_brandAdd).val();
                        var v_add_hot = $("input[name='add_hot']:checked",v_brandAdd).val();
                        var v_add_sort = $("#add_sort",v_brandAdd).val();
                        var v_jsonBrand = {};

                        v_jsonBrand.brandName = v_brandName;
                        v_jsonBrand.brandImg = v_add_brandImg;
                        v_jsonBrand.isHot = v_add_hot;
                        v_jsonBrand.isSort = v_add_sort;

                        $.ajax({
                            url:"/brand/addBrand.do",
                            type:"post",
                            data:v_jsonBrand,
                            success:function (result) {
                                if (result.code==200){
                                    alert("添加成功")
                                    //刷新页面
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
        $("#addBrandDiv").html( v_brandAddFrom);
        initFileInput("add_brandImg","fileInput");

    }
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
            uploadUrl:"/file/uploadFile1.do", //上传的地址
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
            if (data.response.code == 200){
                if (prefix=="update_brandImg"){
                    $("#"+aftrUrl,v_brandUpdate).val(data.response.data);
                }else{
                    $("#"+aftrUrl,v_brandAdd).val(data.response.data);
                }
            }
        });
    }
    /*删除的ajax*/
    function deleteBrand(id,ossBrandImg) {
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
                        url:"/brand/deleteBrand.do",
                        data:{
                            "id":id,
                            "ossBrandImg":ossBrandImg,
                        },
                        success:function (result) {
                            if (result.code==200){
                                //刷新页面
                              location.reload();
                            }
                        }
                    })
                }
            }
        });
    }
    /*修改*/
    var v_brandUpdate;
    function updateBrand(id) {
        $.post({
            url:"/brand/findUpdateBrand.do",
            data:{
                "id":id
            },
            success:function(result){
                if(result.code==200){
                    //赋值
                    var v_brandName = result.data.brandName;
                    var v_brandImg = result.data.brandImg;
                    var v_isHot = result.data.isHot;
                    $("#update_brandName").val(v_brandName);
                    /*数据库中的路径赋值给隐藏域回显*/
                    $("#updateFileInput").val(v_brandImg);

                    $("input[name=update_hot]").each(function () {
                        if (this.value==v_isHot){
                            this.checked=true;
                        }
                    });

                    initFileInput("update_brandImg","updateFileInput");


                    v_brandUpdate =  bootbox.dialog({
                        title:"修改页面",
                        message: $("#updateBrandDiv form"),
                        size:"large",
                        buttons: {
                            confirm: {
                                label: "<span class='glyphicon glyphicon-ok'></span>保存",
                                className: 'btn-danger',
                                callback: function(){
                                    //获取文本框的值
                                   var v_update_brandName= $("#update_brandName",v_brandUpdate).val();
                                   var v_update_brandImg= $("#updateFileInput",v_brandUpdate).val();
                                   var v_update_isHot = $("input[name=update_hot]:checked",v_brandUpdate).val();

                                   //json对象传值用
                                    var v_jsonUpdateBrand= {};
                                    v_jsonUpdateBrand.id=id;
                                    v_jsonUpdateBrand.brandName = v_update_brandName;
                                    v_jsonUpdateBrand.brandImg = v_update_brandImg;
                                    v_jsonUpdateBrand.isHot = v_update_isHot;
                                    v_jsonUpdateBrand.ossBrandImg = result.data.brandImg;
                                    $.post({
                                        url:"/brand/updateBrand.do",
                                        data:v_jsonUpdateBrand,
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
                    $("#updateBrandDiv").html(v_brandUpdateFrom);
                }
            }
        })
    }
</script>

</body>
</html>
