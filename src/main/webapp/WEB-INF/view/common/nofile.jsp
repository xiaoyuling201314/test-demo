<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/WEB-INF/view/common/resource.jsp" %>
<html>
<head>
    <title>404</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<div class="page-info">
    <div class="info-box">
        <div class="info-content">
        <span style="color: red">
          <c:if test="${empty msg}">
              下载文件不存在
          </c:if>
            <c:if test="${!empty msg}">
                ${msg}
            </c:if>
        </span>
            <span class="cs-hide">${error}</span>
            <a onclick="javascript:history.back(-1);" class="cs-menu-btn">
                <i class="icon iconfont icon-fanhui"></i>返回</a>
        </div>
    </div>
</div>
</body>
</html>