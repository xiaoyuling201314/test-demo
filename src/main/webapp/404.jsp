<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/WEB-INF/view/common/resource.jsp" %>
<html>
<head>
  <title>404</title>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

  <style type="text/css">
    .img-content{
      position:absolute;
      left:0;
      right:0;
      top: 0;
      bottom:0;
      text-align: center;
    }
    .img-content-box{
      width:400px;
      height:300px;
      background:url(./img/404.png) no-repeat center center;
      background-size:100%;
      margin:0 auto;
    }
    .not-found-text{
      font-size: 18px;
    }
    .img-content a{
      font-size: 15px;
    }
  </style>

</head>

<body>

<div class="img-content">
  <div class="img-content-box"></div>
  <p class="not-found-text">哎呀，找不到页面了！请确认您访问的地址是正确的！</p>
  <br>
  <a class="btn" href="javascript:history.back(-1);"><i class="icon iconfont icon-fanhui"></i>&nbsp;返回</a>
  <a class="btn" href="javascript:location.reload();"><i class="icon iconfont icon-shuaxin"></i>&nbsp;刷新</a>
</div>
</body>
</html>