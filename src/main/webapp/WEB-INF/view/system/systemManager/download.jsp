<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
%>
<c:set var="webRoot" value="<%=basePath%>"/>
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="initial-scale=1, maximum-scale=1, user-scalable=no">
    <meta name="format-detection" content="telephone=no">
    <title>App下载</title>
    <link rel="stylesheet" href="${webRoot}/app/css/bootstrap.css">
    <link rel="stylesheet" href="${webRoot}/app/css/index.css">
    <style media="screen">
        html,
        body {
            height: 100%;
            width: 100%;
            position: relative;
        }

        .ui-navbar li.active {
            background: #5cb85c;
        }

        .ui-container {
            width: 100%;
            height: 100vh;
            background-color: #27bf72;
        }

        .food-bg img {
            width: 280px;
        }

        .ui-slogan h2 {
            font-weight: bold;
            margin-bottom: 20px;
        }

        .ui-slogan h2, .ui-slogan p {
            color: #fff;
        }

        .ui-slogan p {
            font-size: 16px;
            line-height: 18px;
        }

        .download-btn button {
            width: 185px;
            height: 50px;
            font-size: 18px;
            background: #ffffff;
            color: #6a6c6f;
            border: none;
            border-radius: 50px;
            cursor: pointer;
            line-height: 50px;
            box-shadow: 0px 3px 5px rgba(0, 0, 0, 0.4);
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
            background-image: url(${webRoot}/img/right-top.png);
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
    </style>
</head>

<body ontouchstart="">
<section class="ui-container">

    <div class="main-content" style="max-width:100%; text-align:center;">
        <div class="food-bg">
            <img src="${webRoot}/img/food-bg.png" alt=""/>
        </div>
        <div class="ui-slogan">
            <h2>食品安全App</h2>
            <p>食品健康，生活小常识</p>
            <p>让App伴您成长，幸福生活尽在达元App</p>
            </p>
        </div>
        <div class="download-btn">
            <button onclick="btnDonload()">
                立即下载
            </button>
        </div>
    </div>
    <div class="img-bg">
        <div>
            <img src="${webRoot}/img/alert.png" alt="" width="80%"/>
        </div>
    </div>
</section>
<%--<div class="ui-footer" style="position: absolute;bottom: 0;width: 100%;height:30px; line-height:30px; text-align: center;padding:0; color:#fff;">
    © 2018 广东达元绿洲食品安全科技股份有限公司®
</div>--%>
</body>
<script type="text/javascript" src="${webRoot}/js/jquery-1.11.3.min.js"></script>
<script type="text/javascript">
    var conH = $('.ui-container').height();
    var mainH = $('.main-content').height();
    var marginT = (conH - mainH) / 2;
    $('.main-content').css('margin-top', marginT-30);
    $(document).on('click', '.img-bg', function (event) {
        $(this).hide();
    });
    $(function () {
        $(".img-bg").hide();
    })
    //判断是否微信浏览器访问
    function is_weixin() {
        var ua = navigator.userAgent.toLowerCase();
        if (ua.match(/MicroMessenger/i) == "micromessenger") {
            return true;
        } else {
            return false;
        }
    }

    function btnDonload() {
        var isWeixin = is_weixin();
        if (isWeixin) {
            $(".img-bg").show();
        } else {
            $(".img-bg").hide();
            window.location.href = "${urlPath}";
        }
    }
</script>
</html>


