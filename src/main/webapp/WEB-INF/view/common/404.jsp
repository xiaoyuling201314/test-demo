<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/WEB-INF/view/common/resource.jsp" %>
<html>
<head>
    <c:choose>
        <c:when test="${!empty ERROR_CODE}">
            <c:if test="${ERROR_CODE eq '500'}">
                <title>500</title>
            </c:if>
        </c:when>
        <c:otherwise>
            <title>404</title>
        </c:otherwise>
    </c:choose>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<div class="page-info">
    <div class="info-box">
        <h1><i class="iconfont">&#xe60d;</i>
            <c:choose>
                <c:when test="${!empty ERROR_CODE}">
                    <c:if test="${ERROR_CODE eq '500'}">
                        <span>500</span>
                    </c:if>
                </c:when>
                <c:otherwise>
                    <span>404</span>
                </c:otherwise>
            </c:choose>
        </h1>
        <div class="info-content">
            <c:choose>
                <c:when test="${!empty ERROR_CODE}">
                    <c:if test="${ERROR_CODE eq '500'}">
                        <c:if test="${!empty ERROR_MSG}">
                            <h4>${ERROR_MSG}</h4>
                        </c:if>
                        <c:if test="${empty ERROR_MSG}">
                            <h4>参数传递错误,请传递正确的token！</h4>
                        </c:if>
                    </c:if>
                </c:when>
                <c:otherwise>
                    <h4>您打开的页面不存在！</h4>
                    <p>当您看到这个页面，表示您的访问出错，这个错误是您打开的页面不存在，请确认您输入的地址是正确的！</p>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>
</body>
</html>