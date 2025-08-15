<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<%--<%@include file="/WEB-INF/view/wxPay/wxPayResource.jsp" %>--%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
    String resourcesUrl = basePath + "/resources";
%>
<c:set var="webRoot" value="<%=basePath%>"/>
<c:set var="resourcesUrl" value="<%=resourcesUrl%>"/>
<!-- css -->
<link rel="stylesheet" type="text/css" href="${webRoot}/css/iconfont/iconfont.css"/>
<!-- js -->
<script type="text/javascript" src="${webRoot}/js/dateUtil.js"></script>
<script type="text/javascript" src="${webRoot}/js/jquery-1.11.3.min.js"></script>
<!-- 弹出框 -->
<script type="text/javascript" src="${webRoot}/js/alert2.js"></script>
<link rel="stylesheet" type="text/css" href="${webRoot}/js/alert2.css"/>
<meta charset="UTF-8">
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">
    <meta name="format-detection" content="telephone=no">
    <title>检测报告</title>
    <link rel="stylesheet" type="text/css" href="${webRoot}/plug-in/wxPay/css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="${webRoot}/plug-in/wxPay/css/index.css">
    <link rel="stylesheet" type="text/css" href="${webRoot}/plug-in/layer/mobile/need/layer.css">
    <style>
        .ui-headed {
            position: absolute;
            z-index: 10000;
            left: 0;
            right: 0;
            top: 0;
        }

        .btn {
            padding: 6px 0;
            min-width: 120px;
        }

        body {
            padding: 0;
        }

        .formData {
            width: 100%;
            height: 80%;
            overflow-x: hidden;
            overflow-y: auto;
        }

        .box {
            width: 100%;
            /*height: 100%;*/
            height: auto;
            /*overflow: hidden;*/
            position: relative;
            top: 50px;
            bottom: 0px;
            left: 0;
            right: 0;
            /*padding-bottom: 50px;*/
        }

        #iframe {
            height: 100%;
            min-height: 400px;
            width: 100%;
            transform: scale(0.5);
            transform-origin: center top 0;
            padding-bottom: 0px;
            overflow: hidden;
            top: 0;
            bottom: 0px;
            position: absolute;
        }

        /*遮罩层样式 start*/
        .food-bg img {
            width: 280px;
        }

        .img-bg {
            position: absolute;
            top: 0;
            left: 0;
            bottom: 0;
            right: 0;
            width: 100%;
            height: 100%;
            text-align: center;
            background: rgba(0, 0, 0, 0.5);
            z-index: 10000;
            display: table;
            vertical-align: middle;
            background-image: url(${webRoot}/img/terminal/right-top.png);
            background-repeat: no-repeat;
            background-position: right top;

        }

        .img-bg div {
            display: table-cell;
            vertical-align: middle;
        }

        .img-bg img {
            display: inline-block;

        }

        /*遮罩层样式 end*/
    </style>
</head>
<body ontouchstart="" style="height:100%;">
<div class="formData" id="formData" style="padding: 0;z-index:100; height: 100%;">
    <div class="ui-headed">
        <h4><a href="javascript:history.back(-1)" class="icon iconfont icon-zuo closeModal"></a>查看报告</h4>
    </div>
    <div class="box" id="box">
        <iframe id="iframe"
                src="${webRoot}/reportPrint/report?samplingId=${samplingId}&requestId=${requestId}&collectCode=${collectCode}"
                class="ui-iframe ui-second-info clearfix" frameborder="0" style="top:0px;"></iframe>
    </div>
    <div class="zz-btm-bar zz-sure-bar" style="height: 70px;position: fixed;z-index: 10000">
        <div class="sure-btns2 clearfix" style="padding: 10px;">
            <a href="#" id="copyUrl" class="btn btn-danger cleartbtn" style="width:30%;margin-right: 5%">复制下载链接</a>
            <a href="#" id="createPdf" onclick="createPdf()" class="btn btn-primary closeModal" style="width:30%">下载报告文档</a><%--复制下载链接--%>
        </div>
    </div>
</div>
<%--模态框 start--%>
<%--<div class="zz-back-modal zz-back-modal3 hide" id="mb_box">
    <div class="zz-del-warn"><p class="zz-warn-text">消息</p>
        <p class="zz-warn-text2" style="padding-left:1px;"></p>
        <p></p>
        <div class="zz-btns clearfix">
            <div class="zz-del-can" onclick="closeModal()">关闭弹窗</div>
            <div class="zz-del-sure copyurl">复制地址</div>
        </div>
    </div>
</div>--%>
<%--模态框 end--%>
<%--遮罩层 start--%>
<div class="img-bg" style="display: none">
    <div>
        <img onclick="closePage()" src="${webRoot}/img/terminal/alert.png" alt="" style="width: 260px"/>
    </div>
</div>
<%--遮罩层 end--%>
</body>
<%--复制功能js的引入--%>
<script src="${webRoot}/plug-in/clipboard/clipboard.min.js"></script>
<%--layer.js 加载提示层--%>
<script type="text/javascript" src="${webRoot}/plug-in/layer/mobile/layer.js"></script>
<script>
    //======================注释的内容_start======================
    /*
     function closeModal() {
     $("#mb_box").addClass("hide");
     }
     function showModal(title, content) {
     var obj = $("#mb_box");
     obj.removeClass("hide");
     title ? obj.find(".zz-warn-text").html(title) : '';
     content ? obj.find(".zz-warn-text2").html(content) : '';
     }

     $(".copyurl").click(function () {
     let url = $("#pdfUlr").val();
     new ClipboardJS('.copyurl', {//通过样式拿到按钮对象
     text: function () {
     layer.open({
     content: '复制成功'
     , skin: 'msg'
     , time: 2 //2秒后自动关闭
     });
     closeModal();//关闭模态框
     return url;//返回指定的text文本
     }
     });
     });


     function copyUrl(url) {
     new ClipboardJS('#createPdf', {//通过样式拿到按钮对象
     text: function () {
     layer.open({
     content: '复制成功'
     , skin: 'msg'
     , time: 2 //2秒后自动关闭
     });
     return url;//返回指定的text文本
     }
     });
     }


     //改代码原本放在createPdf()方法中的
     layer.open({
     type: 2,
     content: '文档生成中...'
     });
     $.ajax({
     type: "POST",
     url: 'webRoot/rpt/create_pdf',
     async: true,
     traditional: true,
     data: {'samplingId': '{samplingId}', 'requestId': '{requestId}', 'collectCode': '{collectCode}'},
     dataType: 'json',
     success: (data) => {
     if (data.success) {
     layer.closeAll();
     let url = "
     {webRoot}/resources/" + data.obj;
     showModal('', '生成文档地址<input id="pdfUlr" style="width: 90%;background: #f1f1f1;border:1px solid #ddd;" type="text" value="' + url + '"/>');
     $("#createPdf").text("复制文档地址").attr("onclick", "copyUrl(\"" + url + "\")");
     } else {
     layer.closeAll();
     layer.open({
     content: '文档生成失败,请联系管理员!'
     , skin: 'msg'
     , time: 2 //2秒后自动关闭
     });
     }
     }
     });

     */
    //======================注释的内容_end======================
    var filePath = "${filePath}";
    $(function () {
        //判断是否已经生成过PDF文档(已经生成过pdf文档就把按钮变为复制文档地址)
        if (filePath != '') {
            filePath = "${webRoot}/resources/" + filePath;
            $("#createPdf").text("下载报告文档").attr("onclick", "createPdf(\"" + filePath + "\")");
        }

        //移动端和PC端的布局设置
        if (/Android|webOS|iPhone|iPod|BlackBerry/i.test(navigator.userAgent)) {//移动端
            let ifr = document.getElementById('iframe');
            ifr.onload = function () {
                let wd = ifr.contentWindow.document.documentElement.scrollWidth;
                let ht = ifr.contentWindow.document.documentElement.scrollHeight;
                let x = document.getElementsByClassName('formData')[0].clientWidth / wd;
                ifr.style.width = wd + 'px';
                ifr.style.height = ht + 'px';
                ifr.style.transform = `scale(${x})`;
                ifr.style.transformOrigin = '0 0';
                document.getElementsByClassName('box')[0].style.height = ht * x + 'px';
                $('#iframe').css('transform', 'scale(0.5)')
            };
            mobiles();
        } else {//PC端
            $('#iframe').css('transform', 'scale(1)');
        }

        //点击复制查看链接
        $("#copyUrl").click(function () {
            //let url = '${webRoot}/rpt/report?samplingId=${samplingId}&requestId=${requestId}&collectCode=${collectCode}';
            let url = "";
            new ClipboardJS('#copyUrl', {//通过样式拿到按钮对象
                text: function () {
                    layer.open({
                        content: '复制成功'
                        , skin: 'msg'
                        , time: 2 //2秒后自动关闭
                    });
                    if (filePath != '') {
                        url = filePath;
                    } else {
                        url = "${webRoot}/rpt/create_pdf.do?samplingId=${samplingId}&requestIds=${requestId}&collectCode=${collectCode}";
                    }
                    return url;//返回指定的text文本
                }
            });
        });

    });

    //点击生成报告对应的pdf文档
    function createPdf(path) {
        var isWeixin = is_weixin();
        if (isWeixin) {
            $(".img-bg").show();
        } else {
            $(".img-bg").hide();
            if (path) {
                window.location.href = path;
            } else {
                window.location.href = "${webRoot}/rpt/create_pdf.do?samplingId=${samplingId}&requestIds=${requestId}&collectCode=${collectCode}";
            }
        }
    }

    //对安卓手机、苹果手机、PC端界面的不同高度设置
    var winH = $(window).height();
    $('#iframe').height(winH - 120);
    function mobiles() {
        let u = navigator.userAgent;
        let isAndroid = u.indexOf('Android') > -1 || u.indexOf('Adr') > -1; //android终端
        if (isAndroid) {
            $('#iframe').css('padding-bottom', '0px');
            $('#iframe').height(winH - 120)

        } else {
            $('#iframe').css('padding-bottom', '0px');
            $('#iframe').height(winH - 120)
        }
    }
    //判断是否微信浏览器访问
    function is_weixin() {
        let ua = navigator.userAgent.toLowerCase();
        if (ua.match(/MicroMessenger/i) == "micromessenger") {
            return true;
        } else {
            return false;
        }
    }
    //点击图片关闭遮罩层
    function closePage() {
        $(".img-bg").hide();
    }
</script>
</html>


