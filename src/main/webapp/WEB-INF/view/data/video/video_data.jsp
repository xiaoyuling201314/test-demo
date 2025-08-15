<%@ taglib prefix="C" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/WEB-INF/view/common/resource.jsp" %>
<%--<link href="http://vjs.zencdn.net/6.8.0/video-js.css" rel="stylesheet">--%>
<link href="${webRoot}/plug-in/video/css/video-js.css" rel="stylesheet">
<%--<script src="http://vjs.zencdn.net/ie8/1.1.2/videojs-ie8.min.js"></script>--%>
<script src="${webRoot}/plug-in/video/js/videojs-ie8_1.1.2.min.js"></script>
<%--文件上传样式--%>
<link rel="stylesheet" type="text/css" href="${webRoot}/css/fileinput.css"/>
<link rel="stylesheet" type="text/css" href="${webRoot}/css/theme.css"/>
<!-- 上传 -->
<script src="${webRoot}/js/sortable.js" type="text/javascript"></script>
<script src="${webRoot}/js/fileinput.js" type="text/javascript"></script>
<script src="${webRoot}/js/zh.js" type="text/javascript"></script>
<script src="${webRoot}/js/theme.js" type="text/javascript"></script>
<html>
<head>
    <meta charset="utf-8">
    <meta name="description" content="">
    <meta name="author" content="食安科技">
    <meta http-equiv="X-UA-Compatible" content="IE=Edge">
    <title>快检服务云平台</title>
    <style>
        .video-js.vjs-fluid {
            width: 800px;
        }
    </style>
</head>
<body>

<div class="cs-col-lg clearfix">
    <!-- 面包屑导航栏  开始-->
    <ol class="cs-breadcrumb">
        <li class="cs-fl">
            <img src="${webRoot}/img/set.png" alt=""/>
            <a href="javascript:">数据中心</a></li>
        <li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
        <li class="cs-b-active cs-fl">资料下载</li>
    </ol>
    <!-- 面包屑导航栏  结束-->
    <div class="cs-search-box cs-fr" id="addVideo">
    </div>
</div>
<!-- 列表 -->
<div class="cs-col-lg-table" id="totalId">
    <div class="cs-table-responsive" id="videoDataList"></div>
    <%-- http://localhost:8080/videos/1526107256821.mp4  autoplay 自动播放--%>
    <div id="myVideos" class="hide" style="position: absolute;left: 50%; top: 50%; transform: translate(-50%, -46%);">
        <video id="video" class="video-js vjs-default-skin vjs-fluid   vjs-big-play-centered" controls preload="none"
               data-setup='{}'>
            <source src="http://vjs.zencdn.net/v/oceans.mp4" type="video/mp4">
            </source>
            <source src="http://vjs.zencdn.net/v/oceans.webm" type="video/webm">
            </source>
            <source src="http://vjs.zencdn.net/v/oceans.ogv" type="video/ogg">
            <p class="vjs-no-js">视频编码格式或MIME类型不支持<a
                    href="http://videojs.com/html5-video-support/" target="_blank">supports HTML5 video</a></p>
            </source>
        </video>
    </div>
</div>
<!-- 内容主体 结束 -->
<!-- 新增视频 -->
<div class="modal fade intro2" id="myModal-mid3" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="static">
    <div class="modal-dialog cs-mid-width" role="document">
        <div class="modal-content ">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">新增视频</h4>
            </div>
            <div class="modal-body cs-mid-height" style="padding:10px 0;">
                <!-- 主题内容 -->
                <div class="cs-main">
                    <div class="cs-wraper">
                        <form id="ckForm" action="${webRoot}/video/saveUP.do" method="post" enctype="multipart/form-data">
                            <input name="fileSize" type="hidden"/>
                            <input name="id" type="hidden"/>
                            <div width="100%" class="cs-add-new">
                                <ul class="cs-ul-form  col-xs-12 col-md-12 clearfix ">
                                    <li class="cs-name col-xs-3 col-md-3">资料上传：</li>
                                    <li class="cs-in-style col-xs-8 col-md-8">
                                        <div class="kv-main">
                                            <input type="file" name="file" id="kv-explorer" onchange="fileChange(this);"/>
                                        </div>
                                        <p class="help-block">支持格式为mp4、docx、doc、xls、xlsx、pdf，大小未限制</p>
                                    </li>
                                </ul>
                                <ul class="cs-ul-form clearfix">
                                    <li class="cs-name col-md-3">资料名称：</li>
                                    <li class="cs-in-style col-md-5">
                                        <input type="text" value="" name="title"
                                               class="inputxt">
                                    </li>
                                </ul>
                                <ul class="cs-ul-form clearfix">
                                    <li class="cs-name col-md-3">类型：</li>
                                    <li class="cs-in-style col-md-5">
                                        <select name="videoType" id="videoSelected" ><%--onchange="selectedMonth()"--%>
                                            <%--<option value="-1">--请选择--</option>--%>
                                            <option value="0">仪器类</option>
                                            <option value="1">平台类</option>
                                            <option value="2">APP类</option>
                                            <option value="3">实验类</option>
                                        </select>
                                    </li>
                                </ul>
                                <ul class="cs-ul-form clearfix">
                                    <li class="cs-name col-xs-3 col-md-3" width="20% ">状态：</li>
                                    <li class="cs-al cs-modal-input">
                                        <input id="cs-check-radio2" type="radio" value="1" name="state" checked="checked"><label for="cs-check-radio2">审核</label>
                                        <input id="cs-check-radio" type="radio" value="0" name="state" ><label
                                            for="cs-check-radio">未审核</label>
                                    </li>
                                </ul>
                                <ul class="cs-ul-form clearfix">
                                    <li class="cs-name col-xs-3 col-md-3" width="20% ">备注：</li>
                                    <li class="cs-al cs-in-style col-xs-8 col-md-8">
                                        <textarea class="cs-remark" name="remark" cols="30" rows="10"></textarea>
                                    </li>
                                </ul>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
            <div class="modal-footer action">
                <button type="button" class="btn btn-success" id="btnSave">保存</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
            </div>

        </div>
    </div>
</div>


<!-- 操作失败或成功弹出框 -->
<div class="modal fade intro2" id="btn-warnning" tabindex="-1"
     role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog cs-alert-width">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"
                        aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title">提示</h4>
            </div>
            <div class="modal-body cs-alert-height cs-dis-tab">
                <div class="cs-text-algin" id="waringMsg">
                    <img id="imgState" src="${webRoot}/img/warn.png"
                         width="40px" alt=""/> <span class="tips">操作失败</span>
                </div>
            </div>
            <div class="modal-footer">
                <a class="btn btn-primary btn-ok" data-dismiss="modal" id="close">关闭</a>
            </div>
        </div>
    </div>
</div>
<%@include file="/WEB-INF/view/common/confirm.jsp" %>
<script src="${webRoot}/js/datagridUtil2.js"></script>
<%--<script src="http://vjs.zencdn.net/6.8.0/video.js"></script>--%>
<script src="${webRoot}/plug-in/video/js/video.js"></script>

<script>
    var videoPath;
    rootPath = "${webRoot}/video";

    if (Permission.exist("1378-1")) {
        var html = '<a href="#myModal-mid" class="cs-menu-btn" data-toggle="modal" data-target="#myModal-mid3"><i class="icon iconfont icon-zengjia"></i>新增</a>';
        $("#addVideo").html(html);
    }

    //==========================页面显示=============================================
    var dgu = datagridUtil.initOption({
        tableId: "videoDataList",
        tableAction: "${webRoot}/video/datagrid.do",
        parameter: [
            {
                columnCode: "title",
                columnName: "资料名称"
            }, {
                columnCode: "videoType",
                columnName: "类型",
                columnWidth: '9%',
                customVal: {0: "仪器类", 1: "平台类", 2: "APP类", 3: "实验类"}
            }, {
                columnCode: "fileSize",
                columnName: "文件大小",
                customElement: "<span>?MB</span>"
            }, {
                columnCode: "uptime",
                columnName: "上传时间",
                queryType: 1,
                queryCode: "uptime",
                dateFormat: "yyyy-MM-dd HH:mm:ss",
                columnWidth: '13%'
            }, {
                columnCode: "state",
                columnName: "状态",
                columnWidth: '9%',
                customVal: {0: "<span class='text-danger'>未审核</span>", 1: "<span class='text-success'>已审核</span>"}
            }, {
                columnCode: "remark",
                columnName: "备注"
            }],
        funBtns: [
            { //播放按钮
                show: Permission.exist("1378-4"),
                style: Permission.getPermission("1378-4"),
                action: function (id, row) {
                    $("#addVideo").html("");
                    var html = '<a onclick="videoHide()" class="cs-menu-btn"><i class=" icon iconfont icon-fanhui"></i>返回</a>';
                    $("#addVideo").append(html);

                    var url = '${webRoot}' + "${videoPath}" + row.src;
                    videojs.options.flash.swf = "__JS__/video/video-js.swf";
                    $("#MyVideoRUL").attr("src", url);
                    var myPlayer = videojs("video");  //初始化视频
                    myPlayer.src(url);  //重置video的src
                    myPlayer.load(url);  //使video重新加载
                    //特别提醒：如果使用JQuery的Load方法是无法重新加载的  请使用video.js中内置的load   如何使用请注意自己的调用域

                    //video_html5_api 自适应
                    var player = videojs('video_html5_api', {fluid: true}, function () {   //id="video"
                        console.log('Good to go!');
                        this.play(); // if you don't trust autoplay for some reason
                        setTimeout(function(){
                            getVideoInfo();
                        },200);
                    });
                    $("#myVideos").removeClass("hide");
                    $("#videoDataList").addClass("hide");
                }
            },
            { //下载按钮
                show: Permission.exist("1378-5"),
                style: Permission.getPermission("1378-5"),
                action: function (id, row) {
                    window.location.href = "${webRoot}/video/download.do?path=" + row.src + "&id=" + id;
                }
            },
            { //编辑按钮
                show: Permission.exist("1378-2"),
                style: Permission.getPermission("1378-2"),
                action: function (id, row) {
                    $("#myModalLabel").text("编辑视频");
                    //调用编辑回显方法
                    echoData(id);
                }
            }, {
                //删除按钮
                show: Permission.exist("1378-3"),
                style: Permission.getPermission("1378-3"),
                action: function (id, row) {
                    idsStr = "{\"ids\":\"" + id.toString() + "\"}";
                    $("#confirm-delete").modal('toggle');
                }
            }],
        bottomBtns: [{
            show: Permission.exist("1378-3"),
            style: Permission.getPermission("1378-3"),
            action: function (ids) {//批量删除
                if (ids == '') {
                    $("#confirm-warnning .tips").text("请选择检测项目");
                    $("#confirm-warnning").modal('toggle');
                } else {
                    idsStr = "{\"ids\":\"" + ids.toString() + "\"}";
                    $("#confirm-delete").modal('toggle');
                }
            }
        }],
        onload: function (rows, pageData) {
            $(".rowTr").each(function(){
                for(var i=0;i<rows.length;i++){
                    if($(this).attr("data-rowId") == rows[i].id && rows[i].src.indexOf(".avi") == -1
                        && rows[i].src.indexOf(".mp4") == -1 && rows[i].src.indexOf(".MP4") == -1){
                        //隐藏播放按钮
                        $(this).find(".1378-4").hide();
                    }
                }
            });
        }
    });
    dgu.query();

    //====================================保存的表单验证=========================
    $(function () {
        $("#ckForm").Validform({
            tiptype: 2, beforeSubmit: function () {
                var formData = new FormData($('#ckForm')[0]);//拿到该表单对象
                $.ajax({
                    type: "POST",
                    url: "${webRoot}/video/saveUP.do",
                    data: formData,
                    contentType: false, //必须false才会避开jQuery对 formdata 的默认处理 XMLHttpRequest会对 formdata 进行正确的处理
                    processData: false, //必须false才会自动加上正确的Content-Type
                    dataType: "json",
                    success: function (data) {
                        $("#myModal-mid3").modal('hide');
                        $(".tips").text(data.msg);
                        $("#imgState").attr("src", "${webRoot}/img/sure.png");
                        $("#btn-warnning").modal('toggle');
                        if (data && data.success) {
                            dgu.query();
                        } else {
                            $("#btn-warnning").modal('toggle');
                        }
                        dgu.query();
                    }
                });
                return false;
            }
        });
        // 新增或修改
        $("#btnSave").on("click", function () {
            $("#ckForm").submit();
            return false;
        });

        //当隐藏模态框时调用该方法,先清空模态框
        $("#myModal-mid3").on('hidden.bs.modal', function () {
            $("#ckForm").form("reset");//清空这个表单
            $("input[name=id]").val("");
            $("#videoSelected option[value='-1']").attr("selected", "selected");
        });
    });

    //编辑回显方法
    function echoData(id) {
        $.ajax({
            type: 'POST',
            url: '${webRoot}/video/queryById.do',
            data: {'id': id},
            dataType: 'json',
            success: function (data) {
                if (data.success) {
                    $("input[name=id]").val(data.obj.id);
                    $(".file-caption-name").val(data.obj.title);
                    $("textarea[name=remark]").val(data.obj.remark);
                    $("input[name=title]").val(data.obj.title);
                    $("#videoSelected option[value=" + data.obj.videoType + "]").attr("selected", "selected");
                    $("input[type='radio'][name='state'][value=" + data.obj.state + "]").prop("checked", "checked");
                    $("#myModal-mid3").modal('show');
                    dgu.query();
                } else {
                    $("#btn-warnning").modal('toggle');
                }
            }
        });
    }

    //点击隐藏视频pause(),同时调用暂停方法
    function videoHide() {
        $("#videoDataList").removeClass("hide");
        $("#myVideos").addClass("hide");
        $('#video_html5_api')[0].pause();
        $("#addVideo").html("");
        var html = '<a href="#myModal-mid" class="cs-menu-btn" data-toggle="modal" data-target="#myModal-mid3"><i class="icon iconfont icon-zengjia"></i>新增</a>';
        $("#addVideo").html(html);
    }

    //查看视频
    $(document).on("click", ".dj", function () {
        var id = $(this).parents(".rowTr").attr("data-rowId");
        //==============================================================
        var obj = datagridOption.obj;
        $("#addVideo").html("");
        var html = '<a onclick="videoHide()" class="cs-menu-btn"><i class=" icon iconfont icon-fanhui"></i>返回</a>';
        $("#addVideo").append(html);
        if (obj) {
            for (var i = 0; i < obj.length; i++) {
                if (obj[i].id == id) {
                    //var url = "${videoPath}" + obj[i].src;
                    var url = '${webRoot}' + "${videoPath}" + obj[i].src;
                    videojs.options.flash.swf = "__JS__/video/video-js.swf";
                    $("#MyVideoRUL").attr("src", url);
                    var myPlayer = videojs("video");  //初始化视频
                    myPlayer.src(url);  //重置video的src
                    myPlayer.load(url);  //使video重新加载
                    //特别提醒：如果使用JQuery的Load方法是无法重新加载的  请使用video.js中内置的load   如何使用请注意自己的调用域
                }
            }
        }
        //video_html5_api 自适应
        var player = videojs('video_html5_api', {fluid: true}, function () {   //id="video"
            console.log('Good to go!');
            this.play(); // if you don't trust autoplay for some reason
        });
        $("#myVideos").removeClass("hide");
        $("#videoDataList").addClass("hide");

    });
    function getVideoInfo() {
        var video = $('video');
        var videoH = video[0].videoHeight;
        var videoW = video[0].videoWidth;
        var frameH = $(window.parent.document).find("#main_iframe").height();
        var frameW = $(window.parent.document).find("#main_iframe").width();

        var videoRatio = videoH / videoW;
        var videoRatio2 = videoW / videoH;
        // if (videoH != 0 || videoH>videoW) {
            $('.video-js.vjs-fluid').css({
                'height': frameH-50,
                'max-height': frameH-50
            });
        // } else {
        //     $('.video-js.vjs-fluid').css({
        //         'width': 800
        //     });
        // }
    }

</script>
<%--文件类型和大小控制 格式 mp4 flv大小限制在1000M--%>
<script type="text/javascript">
    var isIE = /msie/i.test(navigator.userAgent) && !window.opera;
    function fileChange(target, id) {
        var fileSize = 0;
        var filetypes = [".mp4",".MP4", ".docx", ".doc", ".xls", ".xlsx", ".pdf"];
        var filepath = target.value;
        var filemaxsize = 1024 * 1000;//1000M
        if (filepath) {
            var isnext = false;
            var fileend = filepath.substring(filepath.lastIndexOf("."));
            if (filetypes && filetypes.length > 0) {
                for (var i = 0; i < filetypes.length; i++) {
                    if (filetypes[i].toUpperCase() == fileend.toUpperCase()) {
                        isnext = true;
                        break;
                    }
                }
            }
            if (!isnext) {
                alert("不接受此文件类型！");
                target.value = "";
                return false;
            }
        } else {
            return false;
        }
        if (isIE && !target.files) {
            var filePath = target.value;
            var fileSystem = new ActiveXObject("Scripting.FileSystemObject");
            if (!fileSystem.FileExists(filePath)) {
                alert("文件不存在，请重新选择！");
                return false;
            }
            var file = fileSystem.GetFile(filePath);
            fileSize = file.Size;

        } else {
            fileSize = target.files[0].size;
        }

        var size = fileSize / 1024;

        if (size > filemaxsize) {
            alert("文件大小不能大于" + filemaxsize / 1024 + "M！");
            target.value = "";
            return false;
        }
        if (size <= 0) {
            alert("文件大小不能为0M！");
            target.value = "";
            return false;
        }
        //alert(Math.round(size/1024 * 100) / 100);
        //赋值
        $("input[name=fileSize]").val(Math.round(size / 1024 * 100) / 100);
    }

    //===============================
    $(document).ready(function () {
        $("#kv-explorer").fileinput({
            'theme': 'explorer',
            'uploadUrl': '#',
            textEncoding: 'UTF-8',
            language: 'zh',
            overwriteInitial: false,
            initialPreviewAsData: true,
            dropZoneEnabled: false,
            showClose: false,
            maxFileCount: 10,
            browseLabel: '浏览'
        });
    });
</script>
</body>
</html>
