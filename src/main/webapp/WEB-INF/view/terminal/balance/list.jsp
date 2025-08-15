<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/WEB-INF/view/terminal/resource.jsp" %>

<html>
<head>
    <title>快检服务云平台</title>
    <link rel="stylesheet" type="text/css" href="${webRoot}/plug-in/time/shijian/shijian.css"/>
    <script src="${webRoot}/plug-in/time/shijian/jquer_shijian.js?ver=1" type="text/javascript" charset="utf-8"></script>
    <style>
        .zz-prices {
            float: left;
            background: #fff;
            border: 1px solid #ccc;
            padding: 20px 10px;
            margin-right: 10px;
            border-radius: 4px;
            font-size: 20px;
            width: 180px;
            height: 120px;
            position: relative;
        }

        .zz-etc {
            padding: 10px 14px;
            clear: both;
        }

        .zz-etc .active {
            border-color: #299afb;
        }

        .pay-title {
            padding: 0px 10px 10px 10px;;
            font-size: 20px;
        }

        .zz-prices .icon {
            color: #f5c000;
            font-size: 22px;
        }

        .top-tip {
            position: absolute;
            right: 0;
            top: 0;
            background: #299afb;
            color: #fff;
            border-radius: 0 0 0 4px;
            font-size: 16px;
            padding: 3px 5px;
        }

        .zz-code {
            padding: 0;
        }

        .icon-qian2 {
            color: #f5c000;
            font-size: 60px;
        }

        .zz-money-all {
            text-align: left;
            margin-top: 20px;
            padding: 10px;
            background: #fff;
            border: 1px solid #ccc;
        }

        .zz-money-all p {
            line-height: 40px;
        }

        .zz-center-pay {
            /* background: #fff; */
            /* margin-top: 20px; */
        }

        .zz-etc-title {
            font-size: 24px;
            margin-top: 30px;
        }

        .zz-history-list {
            padding: 10px 0;
            height: 53px;
            line-height: 35px;
        }

        .zz-history-list .zz-side-btn {
            bottom: 11px;
        }

        .text-success {
            color: #1bad42;
        }

        .text-warning {
            color: #ffa100
        }

        .show-all-money {
            margin-top: 0px;
            border: 0;
            position: relative;
            padding: 30px 45px;
            margin-bottom: 15px;
            border-bottom: 1px solid #ccc;
        }

        .pay-password-set input[type=text], .pay-password-set input[type=password] {
            border: 1px solid #999;
        }

        .reset-btn {
            height: 39px;
            width: 80px;
            font-size: 16px;
            margin-left: 10px;
            display: inline-block;
            float: right;
        }

        .time-form i {
            right: 100px;
        }
    </style>
</head>
<body>
<div class="zz-content">
    <!-- <div class="zz-title2">
        <img class="pull-left" src="img/title2.png" alt=""><span >收银台</span>
    </div> -->
    <div class="zz-title2">
        <img class="pull-left" src="${webRoot}/img/terminal/title2.png" alt=""><span>余额管理 </span>
        <i class="showTime cs-hide"></i>
    </div>
    <div class="zz-cont-box">


        <div class="zz-ok zz-no-margin">

            <div class="zz-money-all show-all-money clearfix" style="    ">
                <div class="pull-left col-md-3">
                    <div style="">
                        <i class="icon iconfont icon-qiandai text-warning" style="font-size:22px;margin-right: 5px"></i>

                        账户余额
                    </div>
                    <div class="" style="font-size: 30px;">
                        <c:choose>
                            <c:when test="${userAccount.totalMoney!=null }">
                                <i class="">${userAccount.totalMoney}&nbsp;&nbsp;元</i>
                            </c:when>
                            <c:otherwise>
                                <i class="">0&nbsp;&nbsp;元</i>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <div class="pull-left col-md-3">
                    <div style="">
                        <i class="icon iconfont icon-qiandai text-warning" style="font-size:22px;margin-right: 5px"></i>

                        预存余额
                    </div>
                    <div class="" style="font-size: 30px;line-height: 48px;">
                        <c:choose>
                            <c:when test="${userAccount.actualMoney!=null }">
                                <i class="text-primary">${userAccount.actualMoney}&nbsp;&nbsp;元</i>
                            </c:when>
                            <c:otherwise>
                                <i class="text-primary">0&nbsp;&nbsp;元</i>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <div class="pull-left col-md-3">
                    <div style="">
                        <i class="icon iconfont icon-qiandai text-warning" style="font-size:22px;margin-right: 5px"></i>

                        赠送余额
                    </div>
                    <div class="" style="font-size: 30px;line-height: 48px;">
                        <c:choose>
                            <c:when test="${userAccount.giftMoney!=null }">
                                <i class="text-success">${userAccount.giftMoney}&nbsp;&nbsp;元</i>
                            </c:when>
                            <c:otherwise>
                                <i class="text-success">0&nbsp;&nbsp;元</i>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>


                <c:if test="${userAccount!=null && empty userAccount.payPassword}">
                    <a href="javascript:void(0);" data-toggle="modal" data-target="#confirm-setPassword" id="setBtn" class="btn btn-primary"
                       style="position: absolute;right: 200px; top:55px">设置支付密码</a>
                </c:if>
                <a href="${webRoot}/balance/prepareList" class="btn btn-primary" style="position: absolute;right: 25px; top:55px">充值</a>
            </div>
        </div>
        <div class="print-btns2 clearfix">
            <div class="print-all print-current" data-status="">交易明细</div>
            <div class="print-all" data-status="1">充值记录</div>
            <div class="time-form"><i class="icon iconfont icon-shijian1"></i>
            	<input id="input3" autocomplete="off" type="text" placeholder="请选择搜索日期" style="width: auto;">
                <button onclick="cleardate()" class="btn btn-primary reset-btn">清除</button>
            </div>
        </div>
        <!-- 交易明细数据列表 -->
        <div class="zz-tb-bg col-md-12 col-sm-12" style="height: 630px;" id="balanceList">

        </div>
        <div class="cs-bottom-tools">
            <ul class="cs-pagination pull-right" style="padding-right: 14px;padding-top: 10px;">
                <li class="cs-disabled cs-distan"><a class="cs-b-nav-btn" onclick="changePage(-1)">«</a></li>
                <li class="" id="pageNumber"></li>
                <li class="cs-next cs-distan"><a class="cs-b-nav-btn" onclick="changePage(1)">»</a></li>
            </ul>
        </div>
        <!-- 			<div class="zz-tb-btns col-md-12 " style="position: absolute; bottom: 20px"> -->
        <div class="zz-tb-btns col-md-12 col-sm-12"
             style="padding:0;position: absolute; bottom: 35px; left: 50%;width: 160px;margin-left: -80px;display:inline-block;">
            <a href="${webRoot}/terminal/goHome.do" class="btn btn-danger">返回</a>
        </div>
    </div>
</div>

</div>

<%@include file="/WEB-INF/view/terminal/balance/setPassword.jsp" %>
</body>
<%@include file="/WEB-INF/view/terminal/tips.jsp" %>
<%@include file="/WEB-INF/view/terminal/keyboard_number.jsp" %>
<script src="${webRoot}/js/num-alignment.js"></script>
<script src="${webRoot}/plug-in/iCheck/icheck.js?v=1.0.2"></script>
<script src="${webRoot}/plug-in/iCheck/js/custom.min.js?v=1.0.2"></script>
<script type="text/javascript">
    var pageCount = 0;
    var currentPage = 1;
    var pageSize = 10;
    $(function () {
        var d = new Date().format("yyyy-MM-dd");
        $("#input3").val();
        queryData();
        //选择需要显示的
        $("#input3").shijian({
            y: -10,//当前年份+10
// 		Format:"yyyy-mm",//显示日期格式//yyyy表示年份 ，mm月份 ，dd天数
            Year: true,//是否显示年//
            Month: true,//是否显示月//
            Day: true,//是否显示日//
            Hour: false,//是否显示小时
            Minute: false,//是否显分钟
            Seconds: false,//是否显示秒
            alwaysShow: false,//是否默认直接显示插件
// 		showNowTime:true,
        })
    });

    //清除时间
    function cleardate() {
        $("#input3").val("");
        currentPage = 1;
        queryData();
    }

    function queryData() {
        var status = $(".print-current").attr("data-status");
        $.ajax({
            type: "POST",
            url: "${webRoot}/balance/datagrid.do",
            data: {"status": status, "queryDate": $("#input3").val(), "pageNo": currentPage, "pageSize": pageSize},
            dataType: "json",
            success: function (data) {
                if (data && data.success) {//拼接订单列表
                    $("#balanceList").empty("");
                    var html = "";
                    if (data.obj.results != "") {
                        $.each(data.obj.results, function (k, flow) {
                            html += '<div class="zz-reports col-md-12 col-sm-12">';
                            html += '<div class="zz-history-list col-md-12 col-sm-12">';
                            html += '<div class="line-title col-md-3 col-sm-3"><span class="zz-circle">' + (k + 1) + '</span><span>' + flow.number + '</span></div>';
                            html += '<div class="col-md-1 col-sm-2">';
                            if (flow.transactionType == 0) {
                                html += '<b>检测费用</b>';
                            } else if (flow.transactionType == 1) {
                                html += '<b>打印费用</b>';
                            } else if (flow.transactionType == 2) {
                                html += '<b>余额充值</b>';
                            } else if (flow.transactionType == 5) {
                                html += '<b>赠送</b>';
                            } else if (flow.transactionType == 6) {
                                html += '<b>扣款</b>';
                            }
                            html += '</div>';
                            //支付方式
                            html += '<div class="col-md-1 col-sm-1">';
                            if (flow.payType == "" && flow.orderPlatform == 2) {
                                html += '<b>平台操作</b>';
                            } else if (flow.payType == 0) {
                                html += '<b>微信</b>';
                            } else if (flow.payType == 1) {
                                html += '<b>支付宝</b>';
                            } else if (flow.payType == 2) {
                                html += '<b>余额</b>';
                            } else {

                            }
                            html += '</div>';
                            if (flow.transactionType != 2 && flow.transactionType != 5) {//支出
                            	var totalMoney=parseFloat(flow.money+flow.reportMoney);
                                html += '<div class="col-md-3 col-sm-2"><span class=" text-danger">-' +totalMoney.toFixed(2)+ '元</span></div>';
                            } else {//充值
                                if (flow.giftMoney != 0) {
                                    html += '<div class="col-md-3 col-sm-2"><span class=" text-success">+' + flow.money + '元（赠送：' + flow.giftMoney + '元）</span></div>';
                                } else {
                                    html += '<div class="col-md-3 col-sm-2"><span class=" text-success">+' + flow.money + '元</span></div>';
                                }
                            }
                            html += '<div class="col-md-2 col-sm-2">';
                            if (flow.transactionType == 2 || flow.payType == 2) {
                                html += '<span class="">余额 ：' + flow.balance + '元</span>';
                            }
                            html += '</div>';
                            html += '<div class="col-md-2 col-sm-3 text-default" style="text-align:right; padding-right:20px;">' + flow.payDate + ' </div>';
                            html += '<div class="zz-side-btn">';
                            /* html+='<a href="#" class="btn btn-default"><b>详情</b></a>'; */
                            html += '</div></div>';
                        });
                        $("#balanceList").append(html);
                        pageCount = data.obj.pageCount;
                    } else {
                        currentPage = 1;
                        pageCount = 0;
                        $("#balanceList").append('<div class="zz-reports col-md-12 col-sm-12" style="text-align: center;"><div class="zz-reports2 col-md-12 col-sm-12">暂无交易信息</div></div>');
                    }
                    $("#pageNumber").html(currentPage + '/' + pageCount);
                }
            }
        });
    }
    //分页查看操作
    function changePage(page) {
        if (page == 1) {
            currentPage += 1;
        } else {
            currentPage -= 1;
        }
        if (currentPage != 0 && currentPage <= pageCount) {
            queryData();
        } else if (currentPage == 0) {
            currentPage = 1;
        }
    }
    $(document).on('click', '.print-all', function () {
        currentPage = 1;
        status = $(this).attr("data-status");
        $(this).addClass('print-current').siblings().removeClass('print-current');
        queryData();//查询数据列表
    });
</script>
<script type="text/javascript" src="${webRoot}/js/showTime.js"></script>
</html>
