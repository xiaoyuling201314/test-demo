<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
    String resourcesUrl = basePath + "/resources";
%>
<c:set var="webRoot" value="<%=basePath%>"/>
<c:set var="resourcesUrl" value="<%=resourcesUrl%>"/>
<meta charset="UTF-8">
<html>
<head>
    <meta name="viewport" content="initial-scale=1, maximum-scale=1, user-scalable=no">
    <link rel="stylesheet" type="text/css" href="${webRoot}/css/iconfont/iconfont.css"/>
    <link rel="stylesheet" type="text/css" href="${webRoot}/plug-in/wxPay/css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="${webRoot}/plug-in/wxPay/css/index.css">
    <style>
        .zz-food-reports {
            height: auto;
        }

        .zz-food-reports .check-report {
            /* height: 64px;
            line-height: 64px; */
        }

        /* .zz-food-reports .zz-num, .zz-food-reports .zz-del-btn {
            height: 64px;
            line-height: 64px;
        } */
        .dis-table {
            display: table;
            table-layout: fixed;
        }

        .dis-cells {
            display: table-cell;
            vertical-align: top;
            line-height: 15px;
            position: relative;
        }

        .food-select-list .dis-cells {
            vertical-align: middle;
            line-height: 20px;
        }

        .zz-check-box input {
            margin-top: 0;
        }

        .input-cell {
            width: 20px;
        }

        .zz-project-price {
            float: none;
            width: 50px;
        }

        .zz-check-box label {
            border-color: #f1f1f1;
            padding: 15px 0;
        }

        .food-select-list {
            width: 100%;
            padding-bottom: 5px;
        }

        .food-select-list .zz-num {
            width: 40px;
        }

        .food-select-list .food-num {
            margin-top: 0px;
        }

        .food-select-list .zz-del-btn {
            padding: 0 5px;
            width: 40px;
        }

        .food-select-list .dis-top .dis-cells {
            vertical-align: top;

        }

        .food-select-list .check-report {
            width: 50px;
        }

    </style>
</head>
<body>

<div class="ui-headed">
    <h4></a>送检样品</h4>
</div>
<section class="ui-container">
    <div class="cs-table-form zz-tp"></div>
    <div class="cs-table-form zz-tp">
        <div class="cs-table-row">
            <div class="cs-table-cell cs-first-name">
                订单编号：
            </div>
            <div class="cs-table-cell">
                ${order.samplingNo}
            </div>
        </div>
        <div class="cs-table-row">
            <div class="cs-table-cell cs-first-name">
                委托单位：
            </div>
            <div class="cs-table-cell">
                ${order.regName}
            </div>
        </div>
        <%--<div class="cs-table-row">--%>
        <%--<div class="cs-table-cell cs-first-name">--%>
        <%--送检单位：--%>
        <%--</div>--%>
        <%--<div class="cs-table-cell">--%>
        <%--<c:if test="${!empty insUnit}">${insUnit.companyName}</c:if>--%>
        <%--</div>--%>
        <%--</div>--%>

        <%--
            此处逻辑：
            1.如果是送检单位：需要展示送检单位，且展示送检人，送检人名字为空就把电话号码展示出来
            2.如果是送检人：展示送检人，送检人名字为空就把电话号码展示出来
            --%>
        <c:choose>
            <c:when test="${!empty order.inspectionId}">
                <div class="cs-table-row">
                    <div class="cs-table-cell cs-first-name">
                        送检单位：
                    </div>
                    <div class="cs-table-cell">
                            ${order.inspectionCompany}
                    </div>
                </div>
                <div class="cs-table-row">
                    <div class="cs-table-cell cs-first-name">
                        送检人员：
                    </div>
                    <div class="cs-table-cell">
                        <c:choose>
                            <c:when test="${!empty insUnitUser.realName}">
                                ${insUnitUser.realName}
                            </c:when>
                            <c:otherwise>
                                ${insUnitUser.phone}
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </c:when>
            <c:otherwise>
                <div class="cs-table-row">
                    <div class="cs-table-cell cs-first-name">
                        送检人员：
                    </div>
                    <div class="cs-table-cell">
                        <c:choose>
                            <c:when test="${!empty order.inspectionCompany}">
                                ${order.inspectionCompany}
                            </c:when>
                            <c:otherwise>
                                ${order.param3}
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>

        <div class="cs-table-row">
            <div class="cs-table-cell cs-first-name">
                收样人员：
            </div>
            <div class="cs-table-cell">
                ${collectUser}
            </div>
        </div>
        <div class="cs-table-row">
            <div class="cs-table-cell cs-first-name">
                下单时间：
            </div>
            <div class="cs-table-cell">
                <fmt:formatDate value="${order.samplingDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
            </div>
        </div>
        <div class="cs-table-row">
            <div class="cs-table-cell cs-first-name">
                送样时间：
            </div>
            <div class="cs-table-cell">
                <fmt:formatDate value="${collectTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
            </div>
        </div>
    </div>


    <div class="top-batch text-center">
        样品信息
    </div>

    <div class="list-border clearfix">
        <c:forEach items="${sampleList}" var="sample" varStatus="vs">
            <div class="zz-food zz-add-food zz-food-reports food-select-list dis-table">
                <div class="zz-num dis-cells">
                    <span class="food-num">${vs.index+1}</span>
                </div>
                <div class="dis-cells text-left zz-text-left">
                    <p><b>样品名称：${sample.foodName}</b></p>
                    <c:if test="${showReq eq 1 || showReq eq 2}">
                        <p>进货数量：
                            <c:if test="${!empty sample.purchaseAmount}">
                                ${sample.purchaseAmount}KG
                            </c:if>
                        </p>
                    </c:if>
                    <p class="dis-table dis-top"><span class="dis-cells" style="width:72px">检测项目：</span> <i
                            class="dis-cells">${sample.itemName}</i></p>
                    <p>检测结果：
                        <c:choose>
                            <c:when test="${!empty sample.conclusion}">
                                <c:if test="${sample.conclusion eq '合格'}">
                                    <i class="text-success zz-b-text zz-text-center">${sample.conclusion}</i>
                                </c:if>
                                <c:if test="${sample.conclusion eq '不合格'}">
                                    <i class="text-danger zz-b-text zz-text-center">${sample.conclusion}</i>
                                </c:if>
                            </c:when>
                            <c:when test="${!empty sample.tubeCode1}">
                                <%--已处理未出结果--%>
                                <i class="text-primary zz-b-text zz-text-center">检测中</i>
                            </c:when>
                            <c:otherwise>
                                <%--未处理--%>
                                <%--<i class="text-success zz-b-text zz-text-center pull-right" style="color:#999999;">待检测</i>--%>
                                <i class="text-primary zz-b-text zz-text-center">检测中</i>
                            </c:otherwise>
                        </c:choose>

                    </p>
                </div>

                <c:if test="${!empty sample.conclusion}">
                    <div class="dis-cells text-center check-report">
                        <a href="${webRoot}/rpt/report?samplingId=${order.id}&collectCode=${collectCode}"
                           class="icon iconfont icon-check text-primary"></a>
                            <%-- shit修改
                                                    <a href="${webRoot}/reportPrint/report?samplingId=${order.id}&collectCode=${collectCode}" class="icon iconfont icon-check text-primary"></a>
                            --%>
                    </div>
                </c:if>
            </div>
        </c:forEach>
    </div>
</section>
</body>
</html>
