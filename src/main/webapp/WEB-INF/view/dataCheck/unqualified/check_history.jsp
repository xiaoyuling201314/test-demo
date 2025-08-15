<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/WEB-INF/view/common/resource.jsp" %>
<html>
<head>
    <title>快检服务云平台</title>
    <link rel="stylesheet" type="text/css" href="${webRoot}/css/fileinput.css"/>
    <link rel="stylesheet" type="text/css" href="${webRoot}/css/theme.css"/>
    <!-- 上传 -->
    <script src="${webRoot}/js/sortable.js" type="text/javascript"></script>
    <script src="${webRoot}/js/fileinput.js" type="text/javascript"></script>
    <script src="${webRoot}/js/zh.js" type="text/javascript"></script>
    <script src="${webRoot}/js/theme.js" type="text/javascript"></script>
</head>
<body>
<div class="cs-col-lg clearfix">
    <!-- 面包屑导航栏  开始-->
    <ol class="cs-breadcrumb cs-fl">
        <li class="cs-fl">
            <img src="${webRoot}/img/set.png" alt=""/>
        <li class="cs-fl">不合格处理</li>
        <li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
        <li class="cs-fl"><a href="javascript:" onclick="self.history.back();">待处理</a></li>
        <li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
        <li class="cs-b-active cs-fl">复检信息</li>
    </ol>
    <div class="cs-search-box cs-fr">
        <div class="cs-fr cs-ac ">
            <a href="${webRoot}/dataCheck/unqualified/list"<%-- onclick="self.history.back();"--%> class="cs-menu-btn cs-fun-btn"><i
                    class="icon iconfont icon-fanhui"></i>返回</a>
        </div>
    </div>
</div>
<div class="cs-content2">
    <h3>最新检测信息</h3>
    <table class="cs-add-new">
        <tbody>
        <tr>
            <td class="cs-name">受检单位：</td>
            <td class="cs-in-style">
                <input type="text" class="cs-top-write" disabled="disabled" value="${checkResult.regName}"></td>
            <td class="cs-name">档口编号：</td>
            <td class="cs-in-style">
                <input type="text" class="cs-top-write" disabled="disabled" value="${checkResult.ope_shop_code}"></td>
            <td class="cs-name">经营户名称：</td>
            <td class="cs-in-style">
                <input type="text" class="cs-top-write" disabled="disabled" value="${checkResult.opeName}"></td>
        </tr>
        <tr>
            <td class="cs-name">检测点：</td>
            <td class="cs-in-style">
                <input type="text" class="cs-top-write" disabled="disabled" value="${checkResult.pointName}"></td>
            <td class="cs-name">检测人员：</td>
            <td class="cs-in-style cs-td-detail" colspan="">
                <input type="text" class="cs-top-write" disabled="disabled" value="${checkResult.checkUsername}"/>
            </td>
            <td class="cs-name">检测时间：</td>
            <td class="cs-in-style cs-td-detail" colspan="">
                <input type="text" class="cs-top-write" disabled="disabled" value="<fmt:formatDate type="both" value="${checkResult.checkDate}"/>"/>
            </td>
        </tr>
        <tr>
            <td class="cs-name">检测样品：</td>
            <td class="cs-in-style">
                <input type="text" class="cs-top-write" disabled="disabled" value="${checkResult.foodName}"></td>
            <td class="cs-name">检测项目：</td>
            <td class="cs-in-style">
                <input type="text" class="cs-top-write" disabled="disabled" value="${checkResult.itemName}"></td>
            <td class="cs-name">限定值：</td>
            <td class="cs-in-style cs-td-detail">
                <input type="text" class="cs-top-write" disabled="disabled" value="${checkResult.limitValue}"/></td>
        </tr>
        <tr>

            <td class="cs-name">检测结果：</td>
            <td class="cs-in-style cs-td-detail">
                <input type="text" class="cs-top-write" disabled="disabled" value="${checkResult.checkResult}"/>
            </td>
            <td class="cs-name">检测结果单位：</td>
            <td class="cs-in-style cs-td-detail">
                <input type="text" class="cs-top-write" disabled="disabled" value="${checkResult.checkUnit}"/>
            </td>
            <td class="cs-name">检测标准：</td>
            <td class="cs-in-style cs-td-detail">
                <input type="text" class="cs-top-write" disabled="disabled" value="${checkResult.checkAccord}"/>
            </td>
        </tr>
        <tr>
            <td class="cs-name">检测结论：</td>
            <td class="cs-in-style">
                <c:choose>
                    <c:when test="${checkResult.conclusion == '合格'}">
                        <input type="text" class="cs-top-write cs-success" disabled="disabled" value="${checkResult.conclusion}"/>
                    </c:when>
                    <c:otherwise>
                        <input type="text" class="inputxt cs-danger" disabled="disabled" value="${checkResult.conclusion}"/>
                    </c:otherwise>
                </c:choose>
            </td>
        </tr>
        </tbody>
    </table>
</div>
<c:forEach items="${checkHistoryList}" var="history" varStatus="num">
    <div class="cs-content2">
        <c:choose>
            <c:when test="${fn:length(checkHistoryList)>1}">
                <h3>复检 ${num.index+1}</h3>
            </c:when>
            <c:otherwise>
                <h3>复检信息</h3>
            </c:otherwise>
        </c:choose>
        <table class="cs-add-new">
            <tbody>
            <tr>
                <td class="cs-name">检测点：</td>
                <td class="cs-in-style">
                    <input type="text" class="cs-top-write" disabled="disabled" value="${history.pointName}"></td>
                <td class="cs-name">复检结果：</td>
                <td class="cs-in-style cs-td-detail">
                    <input type="text" class="cs-top-write" disabled="disabled" value="${history.checkResult}"/></td>
                <td class="cs-name">复检结论：</td>
                <td class="cs-in-style cs-td-detail">
                    <c:choose>
                        <c:when test="${history.conclusion == '合格'}">
                            <input type="text" class="cs-top-write cs-success" disabled="disabled" value="${history.conclusion}"/>
                        </c:when>
                        <c:otherwise>
                            <input type="text" class="inputxt cs-danger" disabled="disabled" value="${history.conclusion}"/>
                        </c:otherwise>
                    </c:choose>
                </td>
            </tr>
            <tr>
                <td class="cs-name">复检时间：</td>
                <td class="cs-in-style">
                    <input type="text" class="cs-top-write" disabled="disabled" value="<fmt:formatDate type="both" value="${history.checkDate}"/>"/>
                <td class="cs-name">复检人员：</td>
                <td class="cs-in-style">
                    <input type="text" class="cs-top-write" disabled="disabled" value="${history.checkUsername}"></td>
                <td class="cs-name">上传时间：</td>
                <td class="cs-in-style">
                    <input type="text" class="cs-top-write" disabled="disabled" value="<fmt:formatDate type="both" value="${history.updateDate}"/>"/>
            </tr>
            </tbody>
        </table>
    </div>
</c:forEach>
<!-- 底部导航 结束 -->
<div class="cs-hd"></div>
<div class="cs-alert-form-btn">
    <a href="${webRoot}/dataCheck/unqualified/list" <%--onclick="self.history.back();"--%> class="cs-menu-btn"><i
            class="icon iconfont icon-fanhui"></i>返回</a>
</div>
<%@include file="/WEB-INF/view/common/confirm.jsp" %>
</body>
</html>
