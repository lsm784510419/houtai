<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/8/23/023
  Time: 16:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="/common/head.jsp"></jsp:include>
    <title>Title</title>

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
                <div class="panel-heading">商品查询</div>
                <div class="panel-body">
                    <form class="form-horizontal" id="shopFrom">
                        <div class="form-group">
                            <label  class="col-sm-1 control-label">商品名</label>
                            <div class="col-sm-5">
                                <input type="email" class="form-control" id="shopName" name="shopName" placeholder="请输入商品名">
                            </div>
                            <label class="col-sm-1 control-label">价格范围</label>
                            <div class="col-sm-5">
                                <div class="input-group">
                                    <input type="text" class="form-control" name="price" id="minPrice" placeholder="最小价格">
                                    <span class="input-group-addon"><i class="glyphicon glyphicon-yen"></i></span>
                                    <input type="text" class="form-control" name="price" id="maxPrice" placeholder="最大价格">
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label  class="col-sm-1 control-label">生产时间</label>
                            <div class="col-sm-5">
                                <div class="input-group">
                                    <input type="text" class="form-control" name="shopTime" id="minDate" placeholder="最早时间">
                                    <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                                    <input type="text" class="form-control" name="shopTime" id="maxDate" placeholder="最晚时间">
                                </div>
                            </div>

                        </div>

                        <div class="form-group" style="text-align: center">
                            <button class="btn btn-primary btn-lg" onclick="searchShop()" type="button"><i class="glyphicon glyphicon-search">查询</i></button>
                            <button class="btn btn-default btn-lg" type="reset"><i class="glyphicon glyphicon-refresh">重置</i></button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <%--所有按钮--%>
    <div style="background: #2aabd2">
        <button onclick="addShop()" type="button" class="btn btn-primary btn-lg"><i class="glyphicon glyphicon-plus">新增</i></button>
        <%-- <button onclick="deleteBatchShop()" type="button" class="btn btn-danger btn-lg"><i class="glyphicon glyphicon-trash">批量删除</i></button>--%>
        <button onclick="exportExcle()" type="button" class="btn btn-info btn-lg"><i class="glyphicon glyphicon-download-alt">导出Excel</i></button>
        <button onclick="exportWord()" type="button" class="btn btn-info btn-lg"><i class="glyphicon glyphicon-download-alt">导出Word</i></button>
        <button onclick="exportPDF()" type="button" class="btn btn-info btn-lg"><i class="glyphicon glyphicon-download-alt">导出PDF</i></button>
    </div>
    <%--栅格布局第二行  展示的table表格--%>
    <div class="row">
        <div class="col-md-12">
            <div class="panel panel-success">
                <div class="panel-heading">商品列表</div>
                <table id="shopTable" class="table table-striped table-bordered" style="width:100%">
                    <thead>
                    <tr>
                        <th>id</th>
                        <th>商品名</th>
                        <th>商品价格</th>
                        <th>图片</th>
                        <th>生产日期</th>
                        <th>是否热销</th>
                        <th>库存量</th>
                        <th>状态</th>
                        <th>操作</th>

                    </tr>
                    </thead>
                    <tfoot>
                    <tr>
                        <th>id</th>
                        <th>商品名</th>
                        <th>商品价格</th>
                        <th>图片</th>
                        <th>生产日期</th>
                        <th>是否热销</th>
                        <th>库存量</th>
                        <th>状态</th>
                        <th>操作</th>
                    </tr>
                    </tfoot>
                </table>
            </div>
        </div>
    </div>
</div>
<%--新增的form表单--%>
<div id="addShopDiv" style="display: none">
    <form class="form-horizontal">
        <div class="form-group">
            <label class="col-sm-2 control-label">商品名:</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" placeholder="请输入商品名" id="add_shopName"  >
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">商品价格:</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" placeholder="请输入商品价格" id="add_price"  >
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">图片:</label>
            <div class="col-sm-10">
                <input type="file" name="files" id="add_shopImg" class="file-loading">
                <input type="hidden"  id="fileInput" >
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">生产日期:</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" placeholder="请输入生产日期" id="add_shopTime"  >
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">是否热销:</label>
            <div class="col-sm-10">
                <input type="radio" name="add_isHotCakes" value="1">是
                <input type="radio" name="add_isHotCakes" value="2">否
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">库存量:</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" placeholder="请输入库存量" id="add_stock"  >
            </div>
        </div>

    </form>
</div>
<%--修改的form表单--%>
<div id="updateShopDiv" style="display: none">
    <form class="form-horizontal">
        <div class="form-group">
            <label class="col-sm-2 control-label">商品名:</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" placeholder="请输入商品名" id="update_shopName"  >
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">商品价格:</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" placeholder="请输入商品价格" id="update_price"  >
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">图片:</label>
            <div class="col-sm-10">
                <input type="file" name="files" id="update_shopImg" class="file-loading">
                <input type="hidden"  id="updateFileInput" >
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">生产日期:</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" placeholder="请输入生产日期" id="update_shopTime"  >
            </div>
        </div>

        <div class="form-group">
            <label class="col-sm-2 control-label">是否热销:</label>
            <div class="col-sm-10">
                <input type="radio" name="update_isHotCakes" value="1">是
                <input type="radio" name="update_isHotCakes" value="2">否
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">库存量:</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" placeholder="请输入库存量" id="update_stock"  >
            </div>
        </div>

    </form>
</div>
<jsp:include page="/common/script.jsp"></jsp:include>

<script>
    var  v_shopAddFrom;
    var v_shopUpdateFrom;
    $(function () {
        initTable();
        initDate();
        backup();
        initSearchDate();
        initFileInput("add_shopImg","fileInput");
    })
    /*备份*/
    function backup(){
        v_shopAddFrom =  $("#addShopDiv").html();
        v_shopUpdateFrom = $("#updateShopDiv").html();
    }
    /*新增修改初始化日期*/
    function initDate(){
        $("#add_shopTime").datetimepicker({
            format: 'YYYY-MM-DD HH:mm:ss',
            showClear:true,
            locale:"zh-CN",
        });
        $("#update_shopTime").datetimepicker({
            format: 'YYYY-MM-DD HH:mm:ss',
            showClear:true,
            locale:"zh-CN",
        });
    }
    /*条件查询的日期初始化*/
    function initSearchDate(){
        $("#minDate").datetimepicker({
            format: 'YYYY-MM-DD HH:mm:ss',
            showClear:true,
            locale:"zh-CN",
        });
        $("#maxDate").datetimepicker({
            format: 'YYYY-MM-DD HH:mm:ss',
            showClear:true,
            locale:"zh-CN",
        });
    }
    
    /*导出excle*/
    function exportExcle() {
        var v_shopFrom = document.getElementById("shopFrom");
        v_shopFrom.action="/shop/exportExcle.do";
        v_shopFrom.type="post";
        v_shopFrom.submit();
    }
    /*导出word*/
    function exportWord(){
        var v_shopFrom = document.getElementById("shopFrom");
        v_shopFrom.action="/shop/exportWord.do";
        v_shopFrom.type="post";
        v_shopFrom.submit();
    }
    
    
    
    /*展示页面*/
    var shopTable1;
    function initTable(){
        shopTable1=$("#shopTable").DataTable( {
            "aLengthMenu":[2,5,10],//自定义每页展示条数
            "serverSide": true,//开启服务器分页模式
            "searching": false,//是否允许检索
            "language": {
                url:"/js/DataTables/Chinese.json"
            },
            "ajax":{
                url:"<%=request.getContextPath()%>/shop/findPageShopList.do",
                type:"post",
            },
            columns: [
                { data: 'id' },
                { data: 'shopName' },
                { data: 'price' },
                { data: 'shopImg',
                    render : function (data,type,row,meta) {
                        return "<img alt='图片' src="+data+" width='60px'/>";
                    }
                },
                { data: 'shopTime' },
                { data: 'isHotCakes',
                    render : function (data,type,row,meta) {
                        return data==1?"是":"否";
                    }
                },
                { data: 'stock' },
                { data: 'isUp',
                    render : function (data,type,row,meta) {
                        return data==0?"正常":"下架 ";
                    }
                },



                { data: "id",
                    render:function(data,type,row,meta){
                        var a=row.isUp==0?"btn btn-Warning":"btn btn-success";
                        var b=row.isUp==0?"下架":"上架";
                        return "<div class=\"btn-group\" role=\"group\" aria-label=\"...\">\n" +
                            "  <button type=\"button\" onclick=\"deleteShop('"+data+"')\" class=\"btn btn-danger\"><span class=\"glyphicon glyphicon-trash\"></span>删除</button>\n" +
                            "  <button type=\"button\" onclick=\"findUpdateShop('"+data+"')\" class=\"btn btn-info\"><span class=\"glyphicon glyphicon-pencil\"></span>修改</button>\n" +
                            "  <button type=\"button\" onclick=\"isUpShop('"+data+"')\" class=\""+a+"\"><span class=\"glyphicon glyphicon-retweet\"></span>"+b+"</button>\n" +
                            "</div>";

                    }}
            ]
        } );}

        /*获取上下架状态*/
       function isUpShop(id){

           bootbox.confirm({
               message: "您确认要修改状态么?",
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
                           url:"/shop/updateIsUp.do",
                           data:{
                               "id":id,
                           },
                           success:function (result) {
                               if (result.code==200){
                                    //刷新页面
                                   searchShop();
                               }
                           }
                       })
                   }
               }
           });
       }





        /*新增的ajax*/
    var v_shopAdd;
    function addShop(){
        v_shopAdd=  bootbox.dialog({
            title:"新增页面",
            message: $("#addShopDiv form"),
            size:"large",
            buttons: {
                confirm: {
                    label: "<span class='glyphicon glyphicon-ok'></span>保存",
                    className: 'btn-danger',
                    callback: function(){
                        //点击确定按钮 发送ajax请求，插入数据
                        var v_shopName = $("#add_shopName",v_shopAdd).val();
                        var v_price = $("#add_price",v_shopAdd).val();
                        var v_shopImg = $("#fileInput",v_shopAdd).val();
                        var v_shopTime = $("#add_shopTime",v_shopAdd).val();
                        var v_add_isHotCakes= $("input[name=add_isHotCakes]:checked",v_shopAdd).val();
                        var v_add_stock = $("#add_stock",v_shopAdd).val();
                        var v_jsonShop = {};

                        v_jsonShop.shopName = v_shopName;
                        v_jsonShop.price = v_price;
                        v_jsonShop.shopTime = v_shopTime;
                        v_jsonShop.shopImg = v_shopImg;
                        v_jsonShop.isHotCakes = v_add_isHotCakes;
                        v_jsonShop.stock = v_add_stock;

                        $.ajax({
                            url:"/shop/addShop.do",
                            type:"post",
                            data:v_jsonShop,
                            success:function (result) {
                                if (result.code==200){
                                    alert("添加成功")
                                    //刷新页面
                                    searchShop();
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
        $("#addShopDiv").html(v_shopAddFrom);
        initDate();
        initFileInput("add_shopImg","fileInput");
    }
    /*删除的ajax*/
    function deleteShop(id) {
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
                        url:"/shop/deleteShop.do",
                        data:{
                            "id":id,
                        },
                        success:function (result) {
                            if (result.code==200){
                              //刷新页面
                                searchShop()
                            }
                        }
                    })
                }
            }
        });
    }
    /*修改*/
    var v_shopUpdate;
    function findUpdateShop(id) {
        $.post({
            url:"/shop/findUpdateShop.do",
            data:{
                "id":id
            },
            success:function(result){
                if(result.code==200){
                    //赋值
                    var v_shopName = result.data.shopName;
                    var v_price = result.data.price;
                    var v_shopTime = result.data.shopTime;
                    var v_shopImg = result.data.shopImg;
                    var v_isHotCakes = result.data.isHotCakes;
                    var v_stock = result.data.stock;

                    $("#update_shopName").val(v_shopName);
                    $("#update_price").val(v_price);
                    $("#update_shopTime").val(v_shopTime);
                    $("#updateFileInput").val(v_shopImg);
                    //回填时获取单选框选中状态
                    $("input[name=update_isHotCakes]").each(function () {
                        if (this.value==v_isHotCakes){
                            this.checked=true;
                        }
                    })
                    $("#update_stock").val(v_stock);


                    initFileInput("update_shopImg","updateFileInput");


                   v_shopUpdate =  bootbox.dialog({
                        title:"修改页面",
                        message: $("#updateShopDiv form"),
                        size:"large",
                        buttons: {
                            confirm: {
                                label: "<span class='glyphicon glyphicon-ok'></span>保存",
                                className: 'btn-danger',
                                callback: function(){
                                    //获取文本框的值
                                    var v_updateShopName = $("#update_shopName",v_shopUpdate).val();
                                    var v_updatePrice = $("#update_price",v_shopUpdate).val();
                                    var v_updateShopTime = $("#update_shopTime",v_shopUpdate).val();
                                    var v_updateShopImg = $("#updateFileInput",v_shopUpdate).val();
                                    var v_update_isHotCakes = $("input[name=update_isHotCakes]:checked",v_shopUpdate).val();
                                    var v_update_stock = $("#update_stock",v_shopUpdate).val();
                                    //json对象传值用
                                    var v_jsonUpdateShop= {};
                                    v_jsonUpdateShop.id=id;
                                    v_jsonUpdateShop.shopName=v_updateShopName;
                                    v_jsonUpdateShop.price = v_updatePrice;
                                    v_jsonUpdateShop.shopTime = v_updateShopTime;
                                    v_jsonUpdateShop.shopImg = v_updateShopImg;
                                    v_jsonUpdateShop.isHotCakes = v_update_isHotCakes;
                                    v_jsonUpdateShop.stock = v_update_stock;
                                    $.post({
                                        url:"/shop/updateShop.do",
                                        data:v_jsonUpdateShop,
                                        success:function (result) {
                                            if (result.code==200){
                                                searchShop();
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
                    $("#updateShopDiv").html(v_shopUpdateFrom);
                    initDate();

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
            console.log(urlArr)
        }
        $("#"+prefix).fileinput({
            language: 'zh', //设置语言
            uploadUrl:"/shop/addFileInputShop.do", //上传的地址
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
            alert(data.response.url)
            if (prefix=="update_shopImg"){
                $("#"+aftrUrl,v_shopUpdate).val(data.response.url);
            }else{
                $("#"+aftrUrl,v_shopAdd).val(data.response.url);

            }
        });
    }
    /*条件查询*/
    function searchShop(){
        var v_shopName = $("#shopName").val();
        var v_minPrice = $("#minPrice").val();
        var v_maxPrice = $("#maxPrice").val();
        var v_minDate = $("#minDate").val();
        var v_maxDate = $("#maxDate").val();

        var searchJson= {};
        searchJson.shopName=v_shopName;
        searchJson.minPrice = v_minPrice;
        searchJson.maxPrice = v_maxPrice;
        searchJson.minDate = v_minDate;
        searchJson.maxDate = v_maxDate;
        shopTable1.settings()[0].ajax.data=searchJson;
        shopTable1.ajax.reload();
    }
</script>
</body>
</html>
