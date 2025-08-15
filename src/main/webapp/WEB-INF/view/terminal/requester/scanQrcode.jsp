<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/WEB-INF/view/common/resource.jsp" %>
<html>
<head>
    <title>检测数据查询</title>
    <meta name="viewport" content="initial-scale=1, maximum-scale=1, user-scalable=no">
    <link rel="stylesheet" type="text/css" href="${webRoot}/css/iconfont/iconfont.css"/>
    <link rel="stylesheet" type="text/css" href="${webRoot}/plug-in/wxPay/css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="${webRoot}/plug-in/wxPay/css/index.css">
    <!-- 弹出框 -->
    <script type="text/javascript" src="${webRoot}/js/alert2.js"></script>
    <link rel="stylesheet" type="text/css" href="${webRoot}/js/alert2.css"/>
    <style>
        .zz-food-reports {
            height: 64px;
        }

        .zz-food-reports .check-report {
            height: 64px;
            line-height: 64px;
        }

        .zz-food-reports .zz-num, .zz-food-reports .zz-del-btn {
            height: 64px;
            line-height: 64px;
        }

        .cs-table-row .table-time input {
            width: 40%;
            padding: 0 5px;
            background: #fff;
            height: 30px;
            line-height: 30px;
            border-radius: 4px;
            border: 1px solid #ddd;
            /* float: left; */
            display: inline-block;
            padding-top: 5px;
        }

        .cs-table-row .table-time span {
            height: 30px;
            line-height: 30px;
        }

        .cs-table-row .table-time {
            text-align: center
        }

        .dis-table {
            display: table;
        }

        .dis-cells {
            display: table-cell;
        }

        .food-num {
            display: inline-block;
            background: #007eea;
            line-height: 20px;
            height: 20px;
            width: 30px;
            text-align: center;
            border-radius: 20px;
            color: #fff;
            margin-left: 15px;
            margin-top: -11px;
        }
    </style>
</head>
<body>
<div class="ui-headed">
    <h4>
        <a href="${webRoot}/wx/public/requesterUnit.do?openid=${openid}" style="z-index: 10" class="icon iconfont icon-zuo zz-close1"></a>
        <c:choose>
            <c:when test="${!empty regType}">${regType.regType}信息</c:when>
            <c:otherwise>单位信息</c:otherwise>
        </c:choose>
    </h4>
</div>
<section class="">
    <div class="cs-table-form zz-tp"></div>
    <div class="cs-table-form zz-tp">
        <div class="cs-table-row">
            <div class="cs-table-cell cs-first-name">单位名称：</div>
            <div class="cs-table-cell">
                ${unit.requesterName }
            </div>
        </div>

        <%--<div class="cs-table-row">
            <div class="cs-table-cell cs-first-name">联系人：</div>
            <div class="cs-table-cell">
                ${unit.linkUser }
            </div>
        </div>
        <div class="cs-table-row">
            <div class="cs-table-cell cs-first-name">联系电话：</div>
            <div class="cs-table-cell">
                ${unit.linkPhone }
            </div>
        </div>--%>
        <div class="cs-table-row">
            <div class="cs-table-cell cs-first-name">单位地址：</div>
            <div class="cs-table-cell">
                ${unit.companyAddress }
            </div>
        </div>

    </div>
    <div class="top-batch text-center">
        <h4>检测信息</h4>

    </div>
    <%--<div class="ui-time clearfix" style="text-align: center;">
         <a href="javascript:;" class="ui-day-pre">&lt; 前一天</a>
        <input type="date" id="search" class="ui-search-time" />
         <a href="javascript:;" class="ui-day-next">后一天 &gt; </a>
    </div>--%>
    <div class="cs-table-form zz-tp detail-search" style="height: 45px;">
        <div class="cs-table-row">
            <!-- <div class="cs-table-cell cs-first-name">
              时间段：
            </div> -->
            <div class="cs-table-cell table-time" style="text-align:center;">
                <input type="date" id="startDate" placeholder="开始时间">
                <span class="left-text"> - </span>
                <input type="date" id="endDate" placeholder="结束时间">
            </div>
        </div>


    </div>

    <div id="recordings"></div>
    <div class="loadtip">
        <div class="zz-load-btn" id="loadData" onclick="checkRecording();"><i class="icon iconfont icon-xia"></i>点击加载更多</div>
        <div class="zz-loading" style="display: none"><img src="${webRoot}/plug-in/wxPay/img/loading.gif" alt="" style="width: 40px">加载中...</div>
        <div class="zz-nomore" style="display: none" id="stockStop">暂无更多数据</div>
    </div>
    <div class="list-border clearfix" id="template" style="display: none;">
        <div class="zz-food zz-add-food zz-food-reports col-md-12 col-xs-12" style="height: auto;">
            <div class="zz-num col-md-1 col-sm-1 col-xs-1" style="padding-top: 16px;">
                <span class="food-num recordingNo"></span>
            </div>
            <div class="col-md-9 col-sm-9 col-xs-9 text-left zz-text-left">
                <p><b>食品名称：<span class="foodName"></span></b></p>
                <p class="purchaseAmount hide">进货数量：<span class="purchaseAmountNum"></span></p>
                <p class="dis-table"><span class="dis-cells" style="width: 72px;">检测项目：</span><span class="dis-cells itemName"></span>
                </p>
                <p>检测结果：<span class="conclusion"></span></p>
                <p>下单时间：<span class="sampling_date"></span></p>
                <p>收样时间：<span class="sample_tube_time"></span></p>
            </div>
            <div class="col-md-2 col-sm-2 col-xs-2 text-center check-report" style="padding-top: 10px;">
                <a href="" class="text-primary queryReport"></a>
            </div>
        </div>
    </div>
</section>
</body>
<script type="text/javascript" src="${webRoot}/js/list.js"></script>
<script type="text/javascript">
    var pages = 1;//初始化页数
    var pageSize = 10;//一页多少条
    var size = 0;

    $(document).on("click", ".ui-find", function () {
        $(this).parents('.ui-bg-white').siblings('.ui-back-info').toggle();
    });

    $(document).on("click", ".ui-btn-close", function () {
        $(this).parents('.ui-back-info').hide();
    });

    $(function () {
        var endDate = new Date().format("yyyy-MM-dd");
        var startDate = new Date();
        startDate.setDate(startDate.getDate() - 6);
        startDate = startDate.format("yyyy-MM-dd");
        $("#endDate").val(endDate);
        $("#startDate").val(startDate);
        /*//设置时间的范围控制
         $("#endDate").attr("min",startDate).attr("max",endDate);
         $("#startDate").attr("max",endDate);*/
        checkRecording();
        //时间的改变事件
        $("#startDate,#endDate").change(function () {
            if (checkDate()) {
                pages = 1;
                pageSize = 10;
                size = 0;
                checkRecording();
            } else {
                $.MsgBox.Alert("消息", "结束时间不能小于开始时间！");
            }
        });
    });

    function checkDate() {
        var startDate = $("#startDate").val();
        var endDate = $("#endDate").val();
        if (startDate.length > 0 && endDate.length > 0) {
            var startDateTemp = startDate.split("-");
            var endDateTemp = endDate.split("-");
            var allStartDate = new Date(startDateTemp[0], startDateTemp[1], startDateTemp[2]);
            var allEndDate = new Date(endDateTemp[0], endDateTemp[1], endDateTemp[2]);
            if (allStartDate.getTime() > allEndDate.getTime()) {
                return false;
            } else {
                return true;
            }
        }
    }


    //检测结果
    function checkRecording() {
        var startDate = $("#startDate").val();
        var endDate = $("#endDate").val();
        if (pages == 1) {//第一页 需要清空
            $("#recordings").empty();
        }
        $.ajax({
            type: "POST",
            url: "${webRoot}/wx/unit/queryData2.do",
            data: {
                "id": "${id}",
                "startDate": startDate,
                "endDate": endDate,
                "pageNo": pages,
                "pageSize": pageSize
            },
            dataType: "json",
            success: function (data) {
                if (data && data.success) {
                    if (data.obj) {
                        var list = data.obj;
                        var html = "";
                        for (var i = 0; i < list.length; i++) {
                            /*html += '<div class="list-border clearfix" style="display: none;">';
                             html += '<div class="zz-food zz-add-food zz-food-reports col-md-12 col-xs-12" style="height: auto;">';
                             html += '<div class="zz-num col-md-1 col-sm-1 col-xs-1" style="padding-top: 16px;">';
                             html += '<span class="food-num recordingNo"></span>';
                             html += '</div>';
                             html += '<div class="col-md-9 col-sm-9 col-xs-9 text-left zz-text-left">';
                             html += '<p><b>食品名称：<span class="foodName"></span></b></p>';
                             html += '<p class="dis-table"><span class="dis-cells" style="width: 72px;">检测项目：</span>';
                             html += '<span class="dis-cells itemName"></span> </p>';
                             html += '<p>检测结果：<span class="conclusion"></span></p>';
                             html += '<p>下单时间：<span class="sampling_date"></span></p>';
                             html += '</div>';
                             html += '<div class="col-md-2 col-sm-2 col-xs-2 text-center check-report" style="padding-top: 10px;">';
                             html += '<a href="" class="text-primary queryReport"></a>';
                             html += '</div></div></div>';*/
                            var template = $("#template").clone();
                            template.find(".recordingNo").text(size + 1);
                            template.find(".foodName").text(list[i].foodName);
                            template.find(".itemName").text(list[i].itemName);
                            if ("${showReq}" === "1"||"${showReq}" === "2") {
                                template.find(".purchaseAmount").removeClass("hide");
                                template.find(".purchaseAmountNum").text(list[i].purchaseAmount ? returnFloat(list[i].purchaseAmount) + "KG" : "");
                            }
                            if (list[i].conclusion == "") {
                                list[i].sampleTubeTime ? template.find(".conclusion").text("检测中") : template.find(".conclusion").hide();
                            } else {
                                template.find(".conclusion").text(list[i].conclusion);
                            }
                            template.find(".samplingNo").text(list[i].samplingNo);
                            template.find(".supplier").text(list[i].supplier);
                            template.find(".opeName").text(list[i].opeName);
                            template.find(".sampling_date").text(list[i].samplingDate);
                            template.find(".sample_tube_time").text(list[i].sampleTubeTime);
                            if (list[i].conclusion == '合格') {//可生产pdf地址：/rpt/report 只给查看地址：/reportPrint/report
                                template.find(".queryReport").attr("href", "${webRoot}/reportPrint/report?samplingId=" + list[i].samplingId + "&requestId=${id}&collectCode=" + list[i].collectCode);
                                template.find(".queryReport").addClass("icon iconfont icon-check");
                                template.find(".conclusion").addClass("text-success");
                            } else if (list[i].conclusion == '不合格') {
                                template.find(".queryReport").attr("href", "${webRoot}/reportPrint/report?samplingId=" + list[i].samplingId + "&requestId=${id}&collectCode=" + list[i].collectCode);
                                template.find(".queryReport").addClass("icon iconfont icon-check");
                                template.find(".conclusion").addClass("text-danger");
                            }
                            html += template.html();
                            size = size + 1;
                        }
                        $("#recordings").append(html);
                        if (list.length > 0) {
                            pages = pages + 1;
                        }
                        $(".zz-loading").hide();
                        if (list.length < pageSize) {//说明不够满页
                            $("#loadData").hide();
                            $(".zz-nomore").show();
                        } else {
                            $("#loadData").show();
                            $(".zz-nomore").hide();
                        }
                        //allstockpages=data.obj.pageCount;
                    } else {
                        $(".zz-loading").hide();
                        $(".zz-nomore").show();
                    }
                }
            }
        });
    }

    $('input').blur(function () {

        $(window).scrollTop(0);

    })
</script>
</html>
