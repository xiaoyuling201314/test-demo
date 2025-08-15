<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/WEB-INF/view/terminal/resource.jsp" %>
<!doctype html>
<html lang="en" class="no-js">
<head>
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta charset="utf-8"/>
    <title>自助终端</title>
    <meta name="description" content="">
    <meta name="keywords" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <link rel="stylesheet" type="text/css" href="${webRoot}/plug-in/time/shijian/shijian.css"/>
    <script src="${webRoot}/plug-in/time/shijian/jquer_shijian.js?ver=1" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="${webRoot}/js/showTime.js"></script>
    <style type="text/css">
        .hideList {
            display: none;
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

<body style="width:1280px;height: 1024px;">
<div class="zz-content">
    <div class="zz-title2">
        <img class="pull-left" src="${webRoot}/img/terminal/title2.png" alt=""><span>报告列表</span>
        <i class="showTime cs-hide"></i>
    </div>
    <div class="zz-cont-box">
        <div class="print-btns2 clearfix">
            <div class="print-all print-current" data-status="0">下单时间</div>
            <div class="print-all" data-status="1">收样时间</div>
            <div class="time-form"><i class="icon iconfont icon-shijian1"></i><input id="input3" type="text" placeholder="请选择搜索日期"
                                                                                     style="width: auto;"/>
                <button onclick="cleardate()" class="btn btn-primary reset-btn">清除</button>
            </div>
            <!-- <div class="print-all"><input type="text" id="reportCode" class="inputData" placeholder="输入取报告码" style="text-transform: uppercase">
                <a href="javascirpt:;" class="btn btn-primary zz-tiqu" style="" id="searchOrder">确定</a></div> -->
        </div>
        <div class="zz-tb-bg col-md-12 col-sm-12" id="dataList" style="min-height:750px;">
            <%-- delete by xiaoyl2019-08-13
                <c:forEach items="${list}" var="sampling" varStatus="status">
                        <div class="zz-reports col-md-12 col-sm-12">
                        <div class="zz-reports2 col-md-12 col-sm-12">
                            <div class="line-title col-md-4 col-sm-4"><span class="zz-circle">${status.index+1}</span><span>${sampling.regName }</span></div>
                            <div class="col-md-3 col-sm-3"><b>报告单号：${sampling.samplingNo }</b></div>
                            <div class="col-md-2 col-sm-2"><b>检测进度：<i class="text-primary">${sampling.completionNum }/${sampling.total }</i></b></div>
                            <div class="col-md-3 col-sm-3 text-right text-default"><span class="pull-right"><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${sampling.createDate}"/> </span> </div>
                        </div>
                        <div class="zz-reports3 col-md-12 col-sm-12">
                            <div class="col-md-4 col-sm-4"><b>检测费用：${sampling.inspectionFee}元</b></div> --%>
            <%--<div class="col-md-3 col-sm-3"><b>打印次数：${sampling.printNum}次</b></div>--%>
            <%-- delete by xiaoyl2019-08-13
            <div class="col-md-3 col-sm-3"><b>重打费用：${sampling.printingFee}元</b></div>
            <div class="zz-side-btn">
            <c:if test="${sampling.completionNum>0}">
                    <a href="javascript:;" onclick="printReport(${sampling.id},1,0)" class="btn btn-default"><b>打印</b></a>
            </c:if> --%>
            <%-- delete by xiaoyl2019-08-13
             <c:choose>
                <c:when test="${sampling.printNum>0}">
                    <a href="javascript:;" onclick="printReport(${sampling.id},0,1)" class="btn btn-default"><b>重打</b></a>
                </c:when>
                <c:when test="${sampling.completionNum>0 and sampling.completionNum<sampling.total}">
                    <a href="javascript:;" onclick="printReport(${sampling.id},1,0)" class="btn btn-default"><b>分开打印</b></a>
                </c:when>
                <c:when test="${sampling.completionNum==sampling.total && sampling.completionNum==1}">
                    <a href="javascript:;" onclick="printReport(${sampling.id},0,0)" class="btn btn-default"><b>打印</b></a>
                </c:when>
                <c:when test="${sampling.completionNum==sampling.total}">
                    <a href="javascript:;" onclick="printReport(${sampling.id},1,0)" class="btn btn-default"><b>分开打印</b></a>
                    <a href="javascript:;" onclick="printReport(${sampling.id},0,0)" class="btn btn-default"><b>合并打印</b></a>
                </c:when>
            </c:choose> --%>
            <%-- </div>
        </div>
    </div>
</c:forEach> --%>
        </div>
        <div class="cs-bottom-tools">
            <ul class="cs-pagination pull-right" style="padding-right: 14px;padding-top: 10px;">
                <li class="cs-disabled cs-distan"><a class="cs-b-nav-btn" onclick="changePage(-1)">«</a></li>
                <li class="" id="pageNumber"></li>
                <li class="cs-next cs-distan"><a class="cs-b-nav-btn" onclick="changePage(1)">»</a></li>
            </ul>
        </div>
        <div class="zz-tb-btns col-md-12 col-sm-12" style="padding:0;">
            <c:choose>
                <c:when test="${outPrint==1}">
                    <a href="${webRoot}/reportPrint/printNoLogin" class="btn btn-danger">返回</a>
                </c:when>
                <c:otherwise>
                    <a href="${webRoot}/terminal/goHome" class="btn btn-danger">返回</a>
                </c:otherwise>
            </c:choose>
        </div>

    </div>
    <div class="zz-left"><img src="${webRoot}/img/terminal/left.png" alt=""></div>
    <div class="zz-right"><img src="${webRoot}/img/terminal/right.png" alt=""></div>
</div>
<%@include file="/WEB-INF/view/common/modalBox.jsp" %>
</body>
<script>
	//1.在登录之后home页面移除上一次的sessionStorage报告列表记录
    var status = sessionStorage.getItem("status")!=null ?sessionStorage.getItem("status") : 0;
    $(".print-all").eq(status).addClass('print-current').siblings().removeClass('print-current');
    var pageCount = 0;
    var currentPage =  sessionStorage.getItem("pageNo")!=null ? parseInt(sessionStorage.getItem("pageNo")) : 1;
    var pageSize = 10;
    $(function () {
        var d = new Date().format("yyyy-MM-dd");
        $("#input3").val();
        queryData();//初始化数据列表
    })
    //清除时间
    function cleardate() {
    	sessionStorage.removeItem("createDate");
        $("#input3").val("");
        currentPage = 1;
        queryData();
    }

    function printReport(samplingId) {
    	if("${session_user_terminal.terminalUserType}"==1){//供应商用户送检
    		location.href = '${webRoot}/reportPrint/printAllMutl?samplingId=' + samplingId;
    	}else{
    		location.href = '${webRoot}/reportPrint/printAll?samplingId=' + samplingId;
    	}
        
    }
    $(document).on('click', '.print-all', function () {
        status = $(this).attr("data-status");
        currentPage = 1;
        sessionStorage.removeItem("createDate");
        $("#input3").val("");
        sessionStorage.setItem("status",status);
        sessionStorage.setItem("pageNo",currentPage);
        $(this).addClass('print-current').siblings().removeClass('print-current');
        queryData();//查询数据列表
    });

    //选择需要显示的
    $("#input3").shijian({
        y: -10,//当前年份+10
        Hour: false,//是否显示小时
        Minute: false,//是否显分钟
        showNowTime: true,
    });
    $(document).on('click', '.df-ok', function (e) {
    	if($("#input3").val()!=""){
    		currentPage = 1;
    		 sessionStorage.setItem("pageNo",currentPage);
	    	sessionStorage.setItem("createDate",$("#input3").val());
    	}
    });
    function queryData() {
    	var createDate;
    	if(sessionStorage.getItem("createDate")!=null && $("#input3").val()==""){
	    	createDate=sessionStorage.getItem("createDate");
	    	$("#input3").val(createDate);
    	}else{
	    	 createDate= $("#input3").val();
    	}
        $.ajax({
            type: "POST",
            url: "${webRoot}/reportPrint/queryOrderList.do",
            data: {"createDate": createDate, "orderType": status, "pageNo": currentPage, "pageSize": pageSize},
            dataType: "json",
            success: function (data) {
                if (data && data.success) {//拼接订单列表
                    $("#dataList").empty("");
                    var html = "";
                    if (data.obj.results != "") {
                        $.each(data.obj.results, function (k, sampling) {
                            html += '<div class="zz-reports col-md-12 col-sm-12">';
                            html += '<div class="zz-reports2 col-md-12 col-sm-12">';
                            html += '<input type="hidden" value="' + sampling.id + '"/>';
                            html += '<div class="line-title col-md-4 col-sm-4"><span class="zz-circle">' + (k + 1) + '</span><span>' + sampling.regName + '</span></div>';
                            html += '<div class="col-md-3 col-sm-3"><b>订单编号：' + sampling.samplingNo + '</b></div>';
                            html += '<div class="col-md-3 col-sm-3"><b>下单时间：' + sampling.createDate + '</b></div>';
                            html += '</div>';
                            html += '<div class="zz-reports3 col-md-12 col-sm-12">';

                            html += '<div class="col-md-4 col-sm-4" ><b style="margin-left:10%;">检测进度：<i class="text-primary">' + sampling.completionNum + '/' + sampling.total + '</i></b></div>';

                            html += '<div class="col-md-3 col-sm-3"><b>订单金额：' + sampling.inspectionFee + '元</b></div>';
                            html += '<div class="col-md-3 col-sm-3"><b>重打费用：' + sampling.printingFee + '元</b></div>';
                            html += '<div class="zz-side-btn">';
                            if (sampling.completionNum > 0) {
                                html += '<a href="javascript:;" onclick="printReport(' + sampling.id + ')" class="btn btn-default"><b>打印</b></a>';
                            }
                            html += '<a href="${webRoot}/reportPrint/orderDetail.do?samplingId=' + sampling.id + '" class="btn btn-default"><b>详情</b></a>';
                            html += '</div>';
                            html += '</div>';
                            html += '</div>';
                        });
                        $("#dataList").append(html);
                        pageCount = data.obj.pageCount;
                    } else {
                        currentPage = 1;
                        pageCount = 1;
                        $("#dataList").append('<div class="zz-reports col-md-12 col-sm-12" style="text-align: center;"><div class="zz-reports2 col-md-12 col-sm-12">暂无订单信息</div></div>');
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
	        sessionStorage.setItem("status",status);
	        sessionStorage.setItem("pageNo",currentPage);
            queryData();
        } else if (currentPage == 0) {
        	sessionStorage.setItem("status",status);
	        sessionStorage.setItem("pageNo",currentPage);
            currentPage = 1;
        }
    }


</script>
</html>


