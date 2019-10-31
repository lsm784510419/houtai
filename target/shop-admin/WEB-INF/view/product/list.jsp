<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/9/16/016
  Time: 17:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="/common/head.jsp"></jsp:include>
    <title>商品页面</title>
</head>
<body>
<jsp:include page="/common/navStatic.jsp"></jsp:include>
<%--整个JSP页面的栅格布局--%>
<div class="container">
    <%--栅格布局的第一行 模糊查询--%>
    <div class="row">
        <div class="col-md-12">
            <div class="panel panel-success">
                <div class="panel-heading">商品查询</div>
                <div class="panel-body">
                    <form class="form-horizontal" id="productFrom">
                        <div class="form-group">
                            <label  class="col-sm-1 control-label">商品名</label>
                            <div class="col-sm-5">
                                <input type="type" class="form-control" id="proName" placeholder="请输入商品名" name="productName">
                            </div>
                            <label class="col-sm-1 control-label">价格范围</label>
                            <div class="col-sm-5">
                                <div class="input-group">
                                    <input type="text" class="form-control" name="minprice"  id="minPrice" placeholder="最小价格">
                                    <span class="input-group-addon"><i class="glyphicon glyphicon-yen"></i></span>
                                    <input type="text" class="form-control" name="maxPrice"  id="maxPrice" placeholder="最大价格">
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label  class="col-sm-1 control-label">生产时间</label>
                            <div class="col-sm-5">
                                <div class="input-group">
                                    <input type="text" class="form-control" name="minCreateDate" id="minDate" placeholder="最早时间">
                                    <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                                    <input type="text" class="form-control" name="maxCreateDate" id="maxDate" placeholder="最晚时间">
                                </div>
                            </div>
                            <label  class="col-sm-1 control-label">品牌</label>
                            <div class="col-sm-5">
                                <div class="input-group" id="searchBrandSelect">
                                </div>
                            </div>
                        </div>
                        <div class="form-group" id="searchTypeDiv">
                            <label  class="col-sm-1 control-label">商品类型</label>
                            <input type="hidden" name="cate1" id="cate1"/>
                            <input type="hidden" name="cate2" id="cate2"/>
                            <input type="hidden" name="cate3" id="cate3"/>
                        </div>
                        <div class="form-group" style="text-align: center">
                            <button class="btn btn-primary btn-lg" onclick="searchProduct()" type="button"><i class="glyphicon glyphicon-search">查询</i></button>
                            <button class="btn btn-default btn-lg" type="reset"><i class="glyphicon glyphicon-refresh">重置</i></button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <%--所有按钮--%>
    <div style="background: #2aabd2">
        <button onclick="addProduct()" type="button" class="btn btn-primary btn-lg"><i class="glyphicon glyphicon-plus">新增</i></button>
        <button onclick="clearCache()" type="button" class="btn btn-primary btn-lg"><i class="glyphicon glyphicon-refresh">手动清缓存</i></button>
        <button onclick="exportExcle()" type="button" class="btn btn-info btn-lg"><i class="glyphicon glyphicon-download-alt">导出Excel</i></button>
        <%-- <button onclick="deleteBatchShop()" type="button" class="btn btn-danger btn-lg"><i class="glyphicon glyphicon-trash">批量删除</i></button>--%>
    </div>
    <%--栅格布局第二行  展示的table表格--%>
    <div class="row">
        <div class="col-md-12">
            <div class="panel panel-success">
                <div class="panel-heading">商品列表</div>
                <table id="productTable" class="table table-striped table-bordered" style="width:100%">
                    <thead>
                    <tr>
                        <th>id</th>
                        <th>商品名</th>
                        <th>商品价格</th>
                        <th>生产日期</th>
                        <th>库存量</th>
                        <th>状态</th>
                        <th>品牌</th>
                        <th>商品类型</th>
                        <th>图片</th>
                        <th>操作</th>

                    </tr>
                    </thead>
                    <tfoot>
                    <tr>
                        <th>id</th>
                        <th>商品名</th>
                        <th>商品价格</th>
                        <th>生产日期</th>
                        <th>库存量</th>
                        <th>状态</th>
                        <th>品牌</th>
                        <th>商品类型</th>
                        <th>图片</th>
                        <th>操作</th>
                    </tr>
                    </tfoot>
                </table>
            </div>
        </div>
    </div>
</div>

<%--新增的form表单--%>
<div id="addProductDiv" style="display: none">
    <form class="form-horizontal">
        <div class="form-group">
            <label class="col-sm-2 control-label">商品名:</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" placeholder="请输入商品名" id="add_proName" >
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">商品价格:</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" placeholder="请输入商品价格" id="add_price" >
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">生产日期:</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" placeholder="请输入生产日期" id="add_createDate"  >
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">库存量:</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" placeholder="请输入库存量" id="add_stock"  >
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">品牌:</label>
            <div class="col-sm-10" id="addBrandSelect">
            </div>
        </div>
        <div class="form-group" id="addTypeDiv">
            <label  class="col-sm-1 control-label">商品类型</label>

        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">图片:</label>
            <div class="col-sm-10">
                <input type="file" name="files" id="add_shopImg" class="file-loading">
                <input type="hidden"  id="fileInput" >
            </div>
        </div>
    </form>
</div>

<%--修改的form表单--%>
<div id="updateProductDiv" style="display: none">
    <form class="form-horizontal">
        <div class="form-group">
            <label class="col-sm-2 control-label">商品名:</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" placeholder="请输入商品名" id="update_proName"  >
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">商品价格:</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" placeholder="请输入商品价格" id="update_price"  >
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">生产日期:</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" placeholder="请输入生产日期" id="update_createDate"  >
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">库存量:</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" placeholder="请输入库存量" id="update_stock"  >
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">品牌:</label>
            <div class="col-sm-10" id="updateBrandSelect">
            </div>
        </div>
        <div class="form-group" id="updateTypeDiv">
            <label class="col-sm-2 control-label">类型:</label>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">图片:</label>
            <div class="col-sm-10">
                <input type="file" name="files" id="update_shopImg" class="file-loading">
                <input type="text"  id="updateFileInput" >
                <input type="text"  id="newUpdateFileInput" >

            </div>
        </div>
    </form>
</div>


<jsp:include page="/common/script.jsp"></jsp:include>

<script>
    var v_productFromAdd;
    var v_productFromUpdate;
    $(function () {
        initTable();
        backup();
        initDate();
        initSearchDate();
        searchBrandSelect();
        initFileInput("add_shopImg","fileInput");
        searchTypeSelect(1);

    })
    /*备份*/
    function backup(){
        v_productFromAdd = $("#addProductDiv").html();
        v_productFromUpdate = $("#updateProductDiv").html();
    }
    /*初始化日期*/
    function initDate() {
        $("#add_createDate").datetimepicker({
            format: 'YYYY-MM-DD',
            showClear:true,
            locale:"zh-CN",
        });
        $("#update_createDate").datetimepicker({
            format: 'YYYY-MM-DD',
            showClear:true,
            locale:"zh-CN",
        });
    }
    /*条件查询的日期初始化*/
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
    /*手动清除缓存*/
    function clearCache() {

        $.post({
            url:"/cache/clearProductCache.do",
            success:function (result) {
                if (result.code == 200){
                    bootbox.alert({
                        size: "small",
                        title: "提示信息",
                        message: "<span class='glyphicon glyphicon-exclamation-sign'></span>清除缓存",
                    });
                }
            }
        })
    }
    /*导出excle*/
    function exportExcle() {
        var v_productFrom = document.getElementById("productFrom");
        var v_cate1 = $($("select[name='typeName']",$("#searchTypeDiv"))[0]).val();
        var v_cate2= $($("select[name='typeName']",$("#searchTypeDiv"))[1]).val();
        var v_cate3 = $($("select[name='typeName']",$("#searchTypeDiv"))[2]).val();
        $("#cate1").val(v_cate1);
        $("#cate2").val(v_cate2);
        $("#cate3").val(v_cate3);
        v_productFrom.action="/product/exportExcle.do";
        v_productFrom.type="post";
        v_productFrom.submit();
    }
    /*新增类型初始化*/
    function addTypeSelect(id,obj){
        if (obj){
            $(obj).parent().nextAll().remove();
        }
        $.post({
            url:"/type/findTypeAll.do",
            data:{
                "id":id,
            },
            success:function (result) {
                if (result.code == 200){
                    var v_TypeArr = result.data;
                    if (v_TypeArr.length == 0){
                        return;
                    }
                    var v_select = '<div class="col-sm-3">';
                    v_select += '<select class="form-control" onchange="addTypeSelect(this.value,this)" name="typeName">' +
                        '<option value = "-1">===请选择===</option>';
                    for (var i = 0; i < v_TypeArr.length; i++) {
                        var v_type = v_TypeArr[i];
                        v_select += '<option value="'+v_type.id+'">'+v_type.typeName+'</option>';
                    }
                    v_select += '</select></div>';
                    $("#addTypeDiv",v_productAdd).append(v_select);
                }
            }
        })
    }
    /*条件查询类型初始化*/
    function searchTypeSelect(id,obj){
        if (obj){
            $(obj).parent().nextAll().remove();
        }
        $.post({
            url:"/type/findTypeAll.do",
            data:{
                "id":id,
            },
            success:function (result) {
                if (result.code == 200){
                    var v_typeArr  = result.data;
                    if (v_typeArr.length == 0){
                        return;
                    }
                    var v_select = '<div class="col-sm-3">';
                    v_select += '<select class="form-control" onchange="searchTypeSelect(this.value,this)" name="typeName">'
                    v_select +='<option value = "-1">===请选择===</option>';
                    for (var i = 0; i < v_typeArr.length; i++) {
                        var v_type = v_typeArr[i];
                        v_select += '<option value="'+v_type.id+'">'+v_type.typeName+'</option>';
                    }
                    v_select += '</select></div>'
                    $("#searchTypeDiv").append(v_select);
                }
            }
        })
    }
    /*修改类型初始化*/
    function updateTypeSelect(id,obj) {
            if (obj){
                $(obj).parent().nextAll().remove();
            }
        $.post({
            url:"/type/findTypeAll.do",
            data:{
                "id":id,
            },
            success:function (result) {
                if (result.code == 200){
                     var v_typeArr = result.data;
                     if (v_typeArr.length == 0){
                         return ;
                     }
                    var v_select = '<div class="col-sm-2">';
                    v_select += '<select class="form-control" onchange="updateTypeSelect(this.value,this)" name="typeName">' +
                        '<option value="-1">请选择</option>';
                    for (var i = 0; i < v_typeArr.length; i++) {
                        var v_type = v_typeArr[i];
                        v_select += '<option value="'+v_type.id+'">'+v_type.typeName+'</option>';
                    }
                    v_select += '</select></div>';
                    $("#updateTypeDiv",v_productUpdate).append(v_select);
                }
            }
        })

    }
    /*fileinput图片的上传*/
    function initFileInput(prefix,aftrUrl) {
        /*修改回显*/
        if (aftrUrl=="updateFileInput"){
            var url=$("#"+aftrUrl).val();
            var urlArr=[];
            urlArr.push(url);
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
            if (prefix=="update_shopImg"){
                $("#newUpdateFileInput",v_productUpdate).val(data.response.data);
            }else{
                $("#"+aftrUrl,v_productAdd).val(data.response.data);

            }
        });
    }
    var v_productTbale;
    function initTable() {
        v_productTbale=$("#productTable").DataTable( {
            "aLengthMenu":[2,5,10],//自定义每页展示条数
            "serverSide": true,//开启服务器分页模式
            "searching": false,//是否允许检索
            "language": {
                url:"/js/DataTables/Chinese.json"
            },
            "ajax":{
                url:"/product/findPageProductList.do",
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
                { data: 'proName' },
                { data: 'price' },
                { data: 'createDate' },
                { data: 'stock' },
                { data: 'status',
                    render:function(data,type,row,meta){
                     return data==1?"上架":"下架";
                    }
                },
                { data: 'brandName' },
                { data: 'cateName' },
                { data: 'proImg',
                    render : function (data,type,row,meta) {
                        return "<img alt='图片' src="+data+" width='60px'/>";
                    }
                },
                { data: "id",
                    render:function(data,type,row,meta){
                        var v_buttons = "";
                        var v_color = "";
                        var v_icon = "";
                        var v_updateStatus;
                        if (row.status==1){
                            v_buttons="下架";
                            v_color = "btn btn-warning";
                            v_icon = "glyphicon glyphicon-menu-down";
                            v_updateStatus = 0;
                        }else {
                            v_buttons="上架";
                            v_color = "btn btn-success";
                            v_icon = "glyphicon glyphicon-menu-up";
                            v_updateStatus = 1;
                        }
                        return "<div class=\"btn-group\" role=\"group\" aria-label=\"...\">\n" +
                            "  <button type=\"button\" onclick=\"deleteProduct('"+data+"')\" class=\"btn btn-danger\"><span class=\"glyphicon glyphicon-trash\"></span>删除</button>\n" +
                            "  <button type=\"button\" onclick=\"findUpdateProduct('"+data+"')\" class=\"btn btn-info\"><span class=\"glyphicon glyphicon-pencil\"></span>修改</button>\n" +
                            "  <button type=\"button\" onclick=\"updateStatus('"+data+"','"+v_updateStatus+"')\" class='"+v_color+"'><span class='"+v_icon+"'></span>"+v_buttons+"</button>\n" +
                            "</div>";

                    }}
            ]
        } );
    }
    function updateStatus(id,status) {
        $.post({
            url:"/product/updateStatus.do",
            data:{
                "id":id,
                "status":status,
            },
            success:function (result) {
                if (result.code==200){
                    searchProduct();
                }
            }
        })
    }
    /*查询品牌新增用*/
    function findBrandSelect(){
        $.post({
            url:"/brand/findAllBrand.do",
            async:false,
            success:function (result) {
                if (result.code==200){
                    var v_data= result.data;
                    var v_sel="<select id='addSelect' class='form-control'><option value='-1'>=====请选择=====</option>"
                    for (var i = 0; i < v_data.length; i++) {
                        v_sel+="<option value='"+v_data[i].id+"'>"+v_data[i].brandName+"</option>"
                    }
                    v_sel+="</select>";
                    $("#addBrandSelect").html(v_sel);
                }
            },
        })
    }

    /*查询品牌修改用*/
    function updateBrandSelect(){
        $.post({
            url:"/brand/findAllBrand.do",
            async:false,
            success:function (result) {
                if (result.code==200){
                    var v_data= result.data;
                    var v_sel="<select id='updateSelect' class='form-control'><option value='-1'>=====请选择=====</option>"
                    for (var i = 0; i < v_data.length; i++) {
                        v_sel+="<option value='"+v_data[i].id+"'>"+v_data[i].brandName+"</option>"
                    }
                    v_sel+="</select>";
                    $("#updateBrandSelect").html(v_sel);
                }
            },
        })
    }

    /*查询品牌模糊查询用*/
    function searchBrandSelect(){
        $.post({
            url:"/brand/findAllBrand.do",
            async:false,
            success:function (result) {
                if (result.code==200){
                    var v_data= result.data;
                    var v_sel="<select id='searchSelect' name='brandId' class='form-control'><option value='-1'>=====请选择=====</option>"
                    for (var i = 0; i < v_data.length; i++) {
                        v_sel+="<option value='"+v_data[i].id+"'>"+v_data[i].brandName+"</option>"
                    }
                    v_sel+="</select>";
                    $("#searchBrandSelect").html(v_sel);
                }
            },
        })
    }

    var v_productAdd;
    function addProduct(){
        findBrandSelect();
        addTypeSelect(1);
        v_productAdd=  bootbox.dialog({
            title:"新增页面",
            message: $("#addProductDiv form"),
            size:"large",
            buttons: {
                confirm: {
                    label: "<span class='glyphicon glyphicon-ok'></span>保存",
                    className: 'btn-danger',
                    callback: function(){
                        //点击确定按钮 发送ajax请求，插入数据
                        var v_proName = $("#add_proName",v_productAdd).val();
                        var v_price = $("#add_price",v_productAdd).val();
                        var v_createDate = $("#add_createDate",v_productAdd).val();
                        var v_stock = $("#add_stock",v_productAdd).val();
                        var v_addSelect = $("#addSelect",v_productAdd).val();
                        var v_addProImg = $("#fileInput",v_productAdd).val();
                        var v_type1 = $($("select[name='typeName']",v_productAdd)[0]).val();
                        var v_type2 = $($("select[name='typeName']",v_productAdd)[1]).val();
                        var v_type3 = $($("select[name='typeName']",v_productAdd)[2]).val();

                        var v_jsonPro = {};

                        v_jsonPro.proName = v_proName;
                        v_jsonPro.price = v_price;
                        v_jsonPro.createDate = v_createDate;
                        v_jsonPro.stock = v_stock;
                        v_jsonPro.brandId = v_addSelect;
                        v_jsonPro.proImg = v_addProImg;
                        v_jsonPro.cate1 = v_type1;
                        v_jsonPro.cate2 = v_type2;
                        v_jsonPro.cate3 = v_type3;

                        $.ajax({
                            url:"/product/addProduct.do",
                            type:"post",
                            data:v_jsonPro,
                            success:function (result) {
                                if (result.code==200){
                                    alert("添加成功")
                                    //刷新页面
                                    searchProduct();
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
        $("#addProductDiv").html(v_productFromAdd);
        initDate();
        initFileInput("add_shopImg","fileInput");
    }

    /*删除的ajax*/
    function deleteProduct(id) {
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
                        url:"/product/deleteProduct.do",
                        data:{
                            "id":id,
                        },
                        success:function (result) {
                            if (result.code==200){
                                //刷新页面
                                searchProduct();

                            }
                        }
                    })
                }
            }
        });
    }
    function editType(obj){
        //删除这个div
        $(obj).parent().remove();
        //引入类型的下拉框替换文本
        updateTypeSelect(1);
        //替换按钮 点击按钮时替换
        $("#updateTypeDiv",v_productUpdate).append('<button onclick="cancelEditType()" type="button" class="btn btn-primary"><i class="glyphicon glyphicon-plus">取消编辑</i></button>')
    }
    function cancelEditType() {
        //因为使用的是html所以之前的div会被覆盖，所以需要将类型也给拼接上
        $("#updateTypeDiv",v_productUpdate).html('<label class="col-sm-2 control-label">类型:</label>' +
                //将我们查询出来的文本内容提为全局变量，在这里重新拼接上，还要在拼接上编辑按钮。
            '<div>'+v_cateName1+'<button onclick="editType(this)" type="button" class="btn btn-primary"><i class="glyphicon glyphicon-pencil">编辑</i></button></div>')
    }
    /*修改*/
    var v_productUpdate;
    var v_cateName1;
    function findUpdateProduct(id) {
        updateBrandSelect();
        $.post({
            url:"/product/findUpdateProduct.do",
            data:{
                "id":id
            },
            success:function(result){
                if(result.code==200){
                    //赋值
                    var v_proName = result.data.proName;
                    var v_price = result.data.price;
                    var v_createDate = result.data.createDate;
                    var v_brandId = result.data.brandId;
                    var v_shopImg = result.data.proImg;
                    var v_cateName = result.data.cateName;
                    var v_stock = result.data.stock;

                    $("#update_proName").val(v_proName);
                    $("#update_price").val(v_price);
                    $("#update_createDate").val(v_createDate);
                    $("#update_stock").val(v_stock);
                    $("#updateSelect").val(v_brandId);
                    $("#updateFileInput").val(v_shopImg);

                    
                    v_cateName1 = v_cateName;//全局变量
                    //将查询出来的内容以文本形式显示出来。后台返回的就是一个字符串
                    $("#updateTypeDiv").append('<div>'+v_cateName+'<button onclick="editType(this)" type="button" class="btn btn-primary"><i class="glyphicon glyphicon-pencil">编辑</i></button></div>');

                    initFileInput("update_shopImg","updateFileInput");
                    v_productUpdate =  bootbox.dialog({
                        title:"修改页面",
                        message: $("#updateProductDiv form"),
                        size:"large",
                        buttons: {
                            confirm: {
                                label: "<span class='glyphicon glyphicon-ok'></span>保存",
                                className: 'btn-danger',
                                callback: function(){
                                    //获取文本框的值
                                    var v_updateProName = $("#update_proName",v_productUpdate).val();
                                    var v_updatePrice = $("#update_price",v_productUpdate).val();
                                    var v_updateCreateDate = $("#update_createDate",v_productUpdate).val();
                                    var v_updateStock = $("#update_stock",v_productUpdate).val();
                                    var v_updateSelect = $("#updateSelect",v_productUpdate).val();
                                    var v_updateShopImg = $("#updateFileInput",v_productUpdate).val();
                                    var v_newUpdateFileInput = $("#newUpdateFileInput",v_productUpdate).val();
                                    console.log($("#newUpdateFileInput",v_productUpdate).val());
                                    var v_cate = $("select[name='typeName']",v_productUpdate);
                                        var v_cate1;
                                        var v_cate2;
                                        var v_cate3;
                                    if (v_cate.length == 3 && $(v_cate[2]).val()!=-1) {
                                        v_cate1 = $($("select[name='typeName']", v_productUpdate)[0]).val();
                                        v_cate2 = $($("select[name='typeName']", v_productUpdate)[1]).val();
                                        v_cate3 = $($("select[name='typeName']", v_productUpdate)[2]).val();
                                    }
                                    //json对象传值用
                                    var v_jsonUpdateProduct= {};
                                    v_jsonUpdateProduct.id=id;
                                    v_jsonUpdateProduct.proName=v_updateProName;
                                    v_jsonUpdateProduct.price = v_updatePrice;
                                    v_jsonUpdateProduct.createDate = v_updateCreateDate;
                                    v_jsonUpdateProduct.stock = v_updateStock;
                                    v_jsonUpdateProduct.brandId = v_updateSelect;
                                    v_jsonUpdateProduct.proImg = v_updateShopImg;
                                    v_jsonUpdateProduct.cate1 = v_cate1;
                                    v_jsonUpdateProduct.cate2 = v_cate2;
                                    v_jsonUpdateProduct.cate3 = v_cate3;
                                    v_jsonUpdateProduct.newProductImg = v_newUpdateFileInput;
                                    $.post({
                                        url:"/product/updateProduct.do",
                                        data:v_jsonUpdateProduct,
                                        success:function (result) {
                                            if (result.code==200){
                                                //刷新页面
                                                searchProduct();
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
                    $("#updateProductDiv").html(v_productFromUpdate);
                    initDate();

                }
            }
        })
    }

    function searchProduct() {
        var v_proName = $("#proName").val();
        var v_minPrice = $("#minPrice").val();
        var v_maxPrice = $("#maxPrice").val();
        var v_minDate = $("#minDate").val();
        var v_maxDate = $("#maxDate").val();
        var v_searchSelect = $("#searchSelect").val();
        //修改完后，会重新查询，这时候需要加上作用域，不然会出现数据不存在
        var v_cate1 = $($("select[name='typeName']",$("#searchTypeDiv"))[0]).val();
        var v_cate2= $($("select[name='typeName']",$("#searchTypeDiv"))[1]).val();
        var v_cate3 = $($("select[name='typeName']",$("#searchTypeDiv"))[2]).val();

        var v_searchJson = {};
        v_searchJson.productName = v_proName;
        v_searchJson.minPrice = v_minPrice;
        v_searchJson.maxPrice = v_maxPrice;
        v_searchJson.minCreateDate = v_minDate;
        v_searchJson.maxCreateDate = v_maxDate;
        v_searchJson.brandId = v_searchSelect;
        v_searchJson.cate1 = v_cate1;
        v_searchJson.cate2 = v_cate2;
        v_searchJson.cate3 = v_cate3;
        v_productTbale.settings()[0].ajax.data=v_searchJson;
        v_productTbale.ajax.reload();
    }
</script>
</body>
</html>
