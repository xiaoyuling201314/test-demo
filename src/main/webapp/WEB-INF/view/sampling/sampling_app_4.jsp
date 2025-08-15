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
    <meta charset="utf-8">
    <meta name="viewport" content="initial-scale=1, maximum-scale=1, user-scalable=no">
    <meta name="format-detection" content="telephone=no">
    <title> 抽样单详情</title>
</head>
<script type="text/javascript" src="${webRoot}/js/dy-switch.js"></script>
<link rel="stylesheet" href="${webRoot}/plug-in/swiperTab/css/swiper-3.2.7.min.css"/>
<link rel="stylesheet" type="text/css" href="${webRoot}/css/iconfont/iconfont.css"/>
<link rel="stylesheet" type="text/css" href="${webRoot}/css/bootstrap.css">
<link rel="stylesheet" type="text/css" href="${webRoot}/plug-in/weui/lib/weui.min.css">
<link rel="stylesheet" type="text/css" href="${webRoot}/plug-in/weui/css/jquery-weui.css">
<link rel="stylesheet" type="text/css" href="${webRoot}/css/app/index2.css">
<link rel="stylesheet" type="text/css" href="${webRoot}/css/app/regulatory-scan4.css">
<style>
    .new-invoice-list .invoice-li{
        border: 0;
        border-bottom: 1px solid #eee;
        border-radius: 0;
        margin: 0;
    }
    .new-invoice-list .invoice-li:last-child{
        border: 0;
    }
    .new-list{
        border: 1px solid #c5daf9;
    }
</style>
<body>
<div class="all-content content-padding">
   <%-- <h2 class="system-title text-center">
        抽样单详情
    </h2>--%>
    <c:choose>
        <%--送检单--%>
        <c:when test="${sampling.personal==1}">
            <div class="company-all-info sample-info  zz-tp is-flex" style="flex-direction: column;position: relative;">
                <div class="stock-name is-flex">
                    <div class="is-flex">
                        <i class="iconfont icon-yemian" style="font-weight: normal;"></i>
                        基础信息
                    </div>
                </div>
                <div class="is-flex">
                    <div class="company-all" style="box-shadow: none;padding-left: 15px;">
                        <div class="company-name2">
                            抽样单号：<b>${sampling.samplingNo}</b> <%--<span class="pull-right"></span>--%>
                        </div>
                        <div class="company-name2">
                            <span>抽样时间：<fmt:formatDate value="${sampling.samplingDate}" pattern="yyyy-MM-dd HH:mm:ss"/></span>
                        </div>
                        <div class="address">
                            <p class="text-indent">
                                <span>送&ensp;检&ensp;人：<i class="text-diy">${sampling.regName}</i></span>
                            </p>
                            <p class="text-indent">
                                <span>联系电话：<i class="text-diy">${sampling.regLinkPhone}</i></span>
                            </p>
                            <p class="text-indent">
                                <span>微&ensp;&ensp;&ensp;&ensp;信：<i class="text-diy">${sampling.opePhone}</i></span>
                            </p>
                            <p class="text-indent-70">
                                <span>地&ensp;&ensp;&ensp;&ensp;址：<i class="text-diy">${sampling.opeShopName}</i></span>
                            </p>
                        </div>

                    </div>
                </div>
                    <%--<div class="company-img show-img2" style="width: 80px;  position: absolute;right: 0;top: 35%;">
                        <i class="iconfont icon-yemian" onclick="viewSheet('${sampling.samplingNo}')"></i>
                    </div>--%>
            </div>
        </c:when>
        <%--抽样单--%>
        <c:otherwise>
            <div class="company-all-info sample-info  zz-tp is-flex" style="flex-direction: column;position: relative;">
                <div class="stock-name is-flex">
                    <div class="is-flex">
                        <i class="iconfont icon-yemian" style="font-weight: normal;"></i>
                        基础信息
                    </div>
                </div>
                <div class="is-flex">
                    <div class="company-all" style="box-shadow: none;padding-left: 15px;">
                        <div class="company-name2">
                            抽样单号：<b>${sampling.samplingNo}</b> <%--<span class="pull-right"></span>--%>
                        </div>
                        <div class="company-name2">
                            <span>抽样时间：<fmt:formatDate value="${sampling.samplingDate}" pattern="yyyy-MM-dd HH:mm:ss"/></span>
                        </div>
                        <div class="address">
                            <p class="text-indent">
                                <span>受检单位：<i class="text-diy">${sampling.regName}</i></span>
                            </p>
                            <p class="text-indent">
                                <span><c:choose><c:when test="${systemFlag==1}">摊位编号：</c:when><c:otherwise>档口编号：</c:otherwise></c:choose><i class="text-diy">${sampling.opeShopCode}</i></span>
                            </p>
                            <p class="text-indent">
                                <span><c:choose><c:when test="${systemFlag==1}">摊位名称：</c:when><c:otherwise>档口名称：</c:otherwise></c:choose><i class="text-diy">${sampling.opeShopName}</i></span>
                            </p>
                            <p class="text-indent">
                                <span>经&ensp;营&ensp;者：<i class="text-diy">${sampling.opeName}</i></span>
                            </p>
                            <p class="text-indent-70">
                                <span>单位地址：<i class="text-diy">${sampling.regAddress}</i></span>
                            </p>
                        </div>

                    </div>
                </div>
                    <%--<div class="company-img show-img2" style="width: 80px;  position: absolute;right: 0;top: 35%;">
                        <i class="iconfont icon-yemian" onclick="viewSheet('${sampling.samplingNo}')"></i>
                    </div>--%>
            </div>
        </c:otherwise>
    </c:choose>


    <div class="new-list zz-tp">
        <div class="stock-name is-flex">
            <div class="is-flex">
                <i class="iconfont icon-ceshi" style="font-weight: normal;"></i>
                样品数据
            </div>
        </div>
        <div class="invoice-list new-invoice-list sample-list clearfix">
            <c:forEach items="${details}" var="detail" varStatus="index">
                <div class="invoice-li invoice-control">
                    <div class="food-row is-flex">
                        <div class="num-box text-primary">
                                ${index.index+1}
                        </div>
                        <div class="zz-food">
                            <div class="invoice-top">
                                <span class="piao-detail" href="javascript:;">名称：<b>${detail.foodName}</b></span>
                                <span class="pull-right text-muted"><fmt:formatDate value="${detail.checkDate}" pattern="yyyy-MM-dd HH:mm:ss"/></span>

                            </div>
                            <div class=" text-left invoice-info">
                                <p>项目：${detail.itemName}
                                    <c:choose>
                                        <c:when test="${detail.conclusion eq '合格'}">
                                            <span class="pull-right text-primary">合格</span>
                                        </c:when>
                                        <c:when test="${detail.conclusion eq '不合格'}">
                                            <span class="pull-right text-danger">不合格</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="pull-right">未完成</span>
                                        </c:otherwise>
                                    </c:choose>
                                </p>
                                <p>状态：<c:choose>
                                    <c:when test="${detail.conclusion eq '合格' or detail.conclusion eq '不合格'}">
                                        <i class="font-size-12">[抽样]→[分配]→[检测]→<i class="text-success">[完成] </i></i>
                                    </c:when>
                                    <c:when test="${detail.recevieCount<detail.samplingCount}">
                                        <i class="font-size-12">[抽样]→<i class="text-danger">[分配]</i>→[检测]→[完成] </i>
                                    </c:when>
                                    <c:otherwise>
                                        <i class="font-size-12">[抽样]→[分配]→<i class="text-danger">[检测] </i>→[完成]</i>
                                    </c:otherwise>
                                </c:choose>
                                    <span class="closeBox more-info pull-right text-muted">
                                        <i class="iconfont icon-xia2 icon-shang2"></i>
                                    </span>
                                </p>
                            </div>
                        </div>
                    </div>
                    <c:choose>
                        <c:when test="${souce==1 && !empty list[index.index]}"> <!-- 当获取进货台账溯源信息时 -->
                            <div class="origin-content cs-hide">

                                <div class="origin-info">
                                    <p>来源/市场：${list[index.index].param1}</p>
                                    <p><c:choose>
                                        <c:when test="${systemFlag==1}">
                                            供货摊位：
                                        </c:when>
                                        <c:otherwise>
                                            供货档口：
                                        </c:otherwise>
                                    </c:choose>
                                            ${list[index.index].supplier}
                                    </p>
                                    <p>供货者名称：${list[index.index].supplierUser}</p>
                                    <p>供货者电话：${list[index.index].supplierTel}</p>
                                    <p>生产日期：<fmt:formatDate value="${list[index.index].productionDate}" pattern="yyyy-MM-dd"/></p>
                                    <p>进货日期：<fmt:formatDate value="${list[index.index].stockDate}" pattern="yyyy-MM-dd"/></p>
                                    <p>保质期：${list[index.index].expirationDate}</p>
                                    <p>产地：${list[index.index].productionPlace}</p>
                                    <p>批次：${list[index.index].batchNumber}</p>
                                    <p>进货数量：${list[index.index].stockCount}${list[index.index].size}</p>
                                    <p>检验编码：${list[index.index].checkProof}</p>
                                </div>
                            </div>
                        </c:when>
                        <%-- 送检单--%>
                        <c:when test="${sampling.personal==1}">
                            <div class="origin-content cs-hide">


                                <div class="origin-info">
                                    <p>购买地点：${detail.origin}</p>
                                    <p><c:choose>
                                        <c:when test="${systemFlag==1}">
                                            摊位名称：
                                        </c:when>
                                        <c:otherwise>
                                            档口名称：
                                        </c:otherwise>
                                    </c:choose>
                                            ${detail.opeShopName}
                                    </p>
                                    <p>送检日期：<fmt:formatDate value="${detail.purchaseDate}" pattern="yyyy-MM-dd"/></p>
                                    <p>送检数量：${detail.purchaseAmount}</p>
                                </div>
                            </div>
                        </c:when>
                        <%--抽样单--%>
                        <c:otherwise>
                            <div class="origin-content cs-hide">

                                <div class="origin-info">
                                    <p>数量：${detail.purchaseAmount}<c:if test="${!empty detail.purchaseAmount}">&nbsp;kg</c:if></p>
                                    <p>日期：<fmt:formatDate value="${detail.purchaseDate}" pattern="yyyy-MM-dd"/></p>
                                    <p>批号：${detail.batchNumber}</p>
                                    <p>产地：${detail.origin}</p>
                                    <p>货商：${detail.supplier}</p>
                                    <p>手机：${detail.supplierPhone}</p>
                                        <%--<p>地址：${detail.supplierAddress}</p>--%>
                                </div>
                            </div>
                        </c:otherwise>
                    </c:choose>
                        <%-- <div class="origin-content cs-hide">
                             <div class="origin-info">
                                 <p>货商：广州农产品基地</p>
                                 <p>姓名：李四</p>
                                 <p>手机：13216451475</p>
                                 <p>地址：广州市黄埔区开元大道15号A2栋5楼</p>
                                 <p>日期：2021-8-31</p>
                                 <p>数量：20.00Kg</p>
                                 <p>批次：202108310001</p>
                                 <p>产地：广州</p>
                             </div>
                    </div>--%>
                </div>
            </c:forEach>
        </div>
    </div>


    <div class="company-all-info point-style sample-info  zz-tp is-flex" style="flex-direction: column;">
        <div class="stock-name is-flex">
            <div class="is-flex">
                <i class="iconfont icon-zzd" style="font-weight: normal;"></i>检测单位
            </div>
        </div>
        <div class="is-flex">
            <div class="company-all" style="box-shadow: none;padding: 5px 15px;">
                <div class="address">
                    <p class="text-indent">
                        <span>抽样单位：<i class="text-diy"><c:if test="${!empty point}">${point.pointName}</c:if></i></span>
                    </p>
                    <p class="text-indent">
                        <span>抽样人员：<i class="text-diy">${sampling.samplingUsername}</i></span>
                    </p>

                </div>
            </div>
        </div>
    </div>
    <div class="company-footer">${copyright}</div>
</div>
</body>
<script type="text/javascript" src="${webRoot}/app/js/jquery.min1.11.3.js"></script>
<script type="text/javascript">

    function footPos(){
        let topH = $('.system-title').outerHeight(true)
        let comH = $('.company-all-info').outerHeight(true)
        let pointH = $('.point-style').outerHeight(true)
        let windowH = $(window).height()
        let listH = $('.invoice-list').outerHeight(true)
        let footH = windowH - topH - comH - listH - pointH;
        console.log(footH)
        if(footH<74){
            $('.company-footer').css('position','static')
        }else{
            $('.company-footer').css('position','fixed')
        }
    }

    // $('.invoice-list').css('min-height', listH)


    // $('.ui-find').click(function(){
    //   $(this).parents('.ui-bg-white').siblings('.ui-back-info').toggle();
    // });
    // $('.ui-btn-close').click(function(){
    //   $(this).parents('.ui-back-info').hide();
    // });

    $(function () {
        //计算底部版权高度
        footPos();
        $('.more-info').on('click', function () {
            $(this).children('i').toggleClass('icon-xia2')
            $(this).parents('.food-row').siblings('.origin-content').toggle()
            footPos();
        })

        //扫描抽样单、监管对象、经营户二维码进入的页面溯源权限控制
        if (DySwitch.traceability()) {
            $(".traceability").show();
        } else {
            $(".traceability").hide();
        }
        //自定义档口编号
        $(".customizeShopCode").text(DySwitch.getShopCode());

    });

    function viewSheet(samplingNo) {
        self.location.href = "${webRoot}/iSampling/toWord.do?samplingNo=" + samplingNo;
    }
</script>
</html>