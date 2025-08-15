<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/common/resource.jsp"%>
<html>
<head>
	<title>快检服务云平台</title>
	<style type="text/css">
	.cs-tittle-btn {
        margin-left: 4px;
    }
    .cs-title-hs input {
        height: auto;
        margin-right: 5px;
    }
    .qrcodes {
        height: 94%;
        width: 750px;
        margin: 0 auto;
    }
    .cs-search-box {
        position: absolute;
        right: 0px;
        top: 0px;
        z-index: 1;
    }
    .queryCondition{
    	width:100px ! important;
    }
    .takeSample{
/*     	color: #16ef16; */
    }


	.cs-search-box {
		position: absolute;
		right: 0px;
		top: 0px;
		z-index: 1;
	}
	.cs-modal-box{
		position: fixed;
		top: 0;
		bottom: 0;
		height: 100%;
		width: 100%;
		left: 0;
	}
    a.text-under{
        text-decoration: underline;
    }

	.tooltip {
		background: rgba(0, 0, 0, 0);
		border: 0;
	}

	.tooltip-inner {
		background: #ffefcb;
		color: #000;
	}

	.tooltip.top .tooltip-arrow {

		border-top-color: #ffefcb;
	}

	.tooltip.in {
		opacity: 1;
	}
	</style>
</head>
<body>
<div class="cs-col-lg clearfix">
	<ol class="cs-breadcrumb">
		<li class="cs-fl">
			<img src="${webRoot}/img/set.png" alt="" />
			<a href="javascript:">财务管理</a></li>
		<li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
		<li class="cs-b-active cs-fl">账户消费</li>
	</ol>
	<%@include file="/WEB-INF/view/common/selectDate.jsp"%>
	<div class="cs-search-box cs-fr">
		<%--
		<span style="float: left;    line-height: 30px;">统计日期：</span>
		<span class="cs-in-style cs-time-se cs-time-se" style="float: left;margin-right: 20px;">
			<input name="date" style="width: 110px;" class="cs-time focusInput" type="text"
				onclick="WdatePicker({maxDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd'})">
		 </span>
		--%>
		<div class="cs-search-filter clearfix cs-fl">
			<input class="cs-input-cont cs-fl focusInput" type="text" name="keyWords" placeholder="请输入姓名或联系方式" />
			&nbsp;<input type="button" class="cs-search-btn cs-fl" onclick="datagridUtil.queryByFocus()" href="javascript:;" value="搜索">
			<%--<span class="cs-s-search cs-fl">高级搜索</span>--%>
		</div>
		<div class="clearfix cs-fr"></div>
	</div>
</div>

<div id="dataList" class="hidden-over"></div>

<div id="moneyListDiv" class="cs-modal-box cs-hide" style="overflow: auto;">
	<div class="cs-col-lg clearfix">
		<ol class="cs-breadcrumb">
			<li class="cs-fl">
				<img src="${webRoot}/img/set.png" alt="">
				<a href="javascript:">财务管理</a></li>
			<li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
			<li class="cs-fl">账户消费</li>
			<li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
			<li class="cs-b-active cs-fl">消费流水</li>
		</ol>
		<div class="cs-search-box cs-fr">
			<div class="clearfix cs-fr">
				<a class="cs-menu-btn" onclick="(function () {$('#moneyListDiv').hide(); $('.hidden-over .cs-col-lg-table').css({height:'auto',overflow:'auto'});})();"><i class="icon iconfont icon-fanhui"></i>关闭</a>
			</div>
		</div>
	</div>
	<div id="moneyList"></div>
</div>

<div id="orderListDiv" class="cs-modal-box cs-hide" style="overflow: auto;">
	<div class="cs-col-lg clearfix">
		<ol class="cs-breadcrumb">
			<li class="cs-fl">
				<img src="${webRoot}/img/set.png" alt="">
				<a href="javascript:">财务管理</a></li>
			<li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
			<li class="cs-fl">账户消费</li>
			<li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
			<li class="cs-b-active cs-fl">消费订单</li>
		</ol>
		<div class="cs-search-box cs-fr">
			<div class="clearfix cs-fr">
				<a class="cs-menu-btn" onclick="(function () {$('#orderListDiv').hide(); $('.hidden-over .cs-col-lg-table').css({height:'auto',overflow:'auto'});})();"><i class="icon iconfont icon-fanhui"></i>关闭</a>
			</div>
		</div>
	</div>
	<div id="orderList"></div>
</div>


<%@include file="/WEB-INF/view/common/modalBox.jsp"%>
<%--<%@include file="/WEB-INF/view/common/confirm.jsp"%>--%>

<script type="text/javascript" src="${webRoot}/js/printTicket.js"></script>
<script type="text/javascript" src="${webRoot}/js/datagridUtil2.js"></script>
<script type="text/javascript">
	// $("input[name='date']").val(new Date().format("yyyy-MM-dd"));
	var datagrid1 = datagridUtil.initOption({
		tableId: "dataList",
		tableAction: "${webRoot}/consumptionStatistic/loadDatagrid",
		parameter: [
			{
				columnCode: "userId",
				columnName: "用户编号",
                columnWidth: "10%"
			},
			{
				columnCode: "userPhone",
				columnName: "登录账号",
                columnWidth: "15%"
			},
			{
				columnCode: "userName",
				columnName: "送检用户",
                columnWidth: "12%"
			},
            {
                columnCode: "companyName",
                columnName: "单位/个人",
                columnWidth: "22%",
                customElement: '<a data-toggle="tooltip" data-placement="top" title="?"  class="wenzi gys">?</a>',
                customStyle: 'text-left',
            },
			{
				columnCode: "feeOrder",
				columnName: "消费金额",
                columnWidth: "15%",
				sortDataType: "float",
				customElement: "<a class=\"text-primary text-under\" href=\"javascript:;\" onclick=\"money('#userId#');\">?</a>"
			},
			{
				columnCode: "qtyOrder",
				columnName: "订单数量",
                columnWidth: "12%",
				sortDataType: "float",
                customElement: "<a class=\"text-primary text-under\" href=\"javascript:;\" onclick=\"order('#userId#');\">?</a>"
			},
			{
				columnCode: "qtyOrderDetails",
				columnName: "样品数量",
                columnWidth: "12%",
				sortDataType: "float"
			}
		],
		defaultCondition: [{
			queryCode: "type",
			queryVal: ""
		},{
			queryCode: "month",
			queryVal: ""
		},{
			queryCode: "season",
			queryVal: ""
		},{
			queryCode: "year",
			queryVal: ""
		},{
			queryCode: "start",
			queryVal: ""
		},{
			queryCode: "end",
			queryVal: ""
		}],
		funBtns: [
		],
        summary: {
            summary2: [{
                title: "本页消费合计",
                text: "0"
            },{
                title: "本页订单合计",
                text: "0"
            }]
        },
		onload: function (rows, pageData) {
            $('[data-toggle="tooltip"]').tooltip();//初始化tip
			var money0 = 0.0;
			var orderNumber0 = 0;
			$.each(rows, function(index, value){
				money0 += parseFloat(value.feeOrder);
				orderNumber0 += parseInt(value.qtyOrder);


                //给供应商用户添加图标supplier
                if (value.supplier == 1 && value.userType == 1) {//如果为企业类型且企业为供应商就添加图标
                    $("tr[data-rowid=" + value.id + "]").find(".gys").prepend('<i class="icon iconfont icon-gongyingshang" style="margin-right: 4px;color:#9571e9;"></i>');
                }
			});
			datagrid1.setSummary({
				summary2: [{
					title: "本页消费合计",
					text: money0.toFixed(2)
				},{
					title: "本页订单合计",
					text: orderNumber0
				}]
			});
		}
	});

	//selectDate修改时间后执行函数
	selectDate.init(function (d){
		datagrid1.addDefaultCondition("type", d.type);
		datagrid1.addDefaultCondition("year", d.year);
		datagrid1.addDefaultCondition("season", d.season);
		datagrid1.addDefaultCondition("month", d.month);
		datagrid1.addDefaultCondition("start", d.start);
		datagrid1.addDefaultCondition("end", d.end);
		datagrid1.queryByFocus();
	});

    /**
     * 查看消费流水
     * @param userId 用户ID
     */
	function money(userId) {
		var sd = selectDate.getSelectDate();
		var datagrid2 = datagridUtil.initOption({
			tableId: "moneyList",
			tableAction: "${webRoot}/balanceMgt/flowDatagrid",
			defaultCondition: [{
				queryCode: "userId",
				queryVal: userId
			},{
				queryCode: "isok",
				queryVal: 0
			},{
				queryCode: "payDateStart",
				queryVal: sd.start
			},{
				queryCode: "payDateEnd",
				queryVal: sd.end
			}],
			parameter: [
				{
					columnCode: "payDate",
					columnName: "交易时间",
					queryType: "1",
					dateFormat: "yyyy-MM-dd HH:mm:ss",
					customStyle: 'text-left',
					columnWidth: "150px"
				},
				{
					columnCode: "payNumber",
					columnName: "交易流水号",
					customStyle: 'text-left',
					columnWidth: "235px"
				},
				{
					columnCode: "number",
					columnName: "订单号",
					customStyle: 'text-left',
					columnWidth: "190px"
				},
				{
					columnCode: "payMode",
					columnName: "交易方式",
					columnWidth: "80px"
				},
				{
					columnCode: "flowState",
					columnName: "类型",
					customVal: {"0": "支出", "1": "收入","is-null":"支出"},
					columnWidth: "60px"
				},
				{
					columnCode: "money",
					columnName: "交易金额",
					columnWidth: "80px",
					sortDataType:"float",
					customVal: {"is-null":"￥0.00", "non-null":"￥?"}
				},
				{
					columnCode: "giftMoney",
					columnName: "赠送金额",
					columnWidth: "80px",
					sortDataType:"float",
					customVal: {"is-null":"￥0", "non-null":"￥?"}
				},
				{
					columnCode: "balance",
					columnName: "余额",
					columnWidth: "80px",
					sortDataType:"float",
					customVal: {"is-null":"￥0.00", "non-null":"￥?"}
				},
				{
					columnCode: "status",
					columnName: "状态",
					customVal: {"0": "待支付", "1": "成功", "2": "失败", "3": "关闭"},
					columnWidth: "60px"
				},
				{
					columnCode: "remark",
					columnName: "备注"
				}
			]
		});
		datagrid2.query();

		$("#moneyListDiv").show();
        $(".hidden-over .cs-col-lg-table").css({height:0,overflow:"hidden"})
	}

	/**
     * 查看消费订单
     * @param userId 用户ID
     */
	function order(userId) {
		var sd = selectDate.getSelectDate();
		var datagrid3 = datagridUtil.initOption({
			tableId: "orderList",
			tableAction: "${webRoot}/order/orderDatagrid",
			defaultCondition: [{
				queryCode: "tbSampling.samplingUserid",
				queryVal: userId
			},{
				queryCode: "tbSampling.orderStatus",
				queryVal: 2
			},{
				queryCode: "samplingStartDate",
				queryVal: sd.start
			},{
				queryCode: "samplingEndDate",
				queryVal: sd.end
			}],
			parameter: [
                {
                    columnCode: "samplingNo",
                    columnName: "订单编号",
                    columnWidth: "125px"
                },
                {
                    columnCode: "regName",
                    columnName: "委托单位"
                },
                {
                    columnCode: "samplingUsername",
                    columnName: "送检用户",
                    columnWidth: "80px"
                },
                {
                    columnCode: "param3",
                    columnName: "送检电话",
                    columnWidth: "105px"
                },
                {
                    columnCode: "inspectionFee",
                    columnName: "订单金额",
                    customElement: "￥?",
                    sortDataType:"float",
                    columnWidth: "90px"
                },{
                    columnCode: "orderStatus",
                    columnName: "状态",
                    customVal: {"1":"待支付","2":"已支付","3":"已取消"},
                    columnWidth: "70px"
                },{
                    columnCode: "payDate",
                    columnName: "付款时间",
                    dateFormat: "yyyy-MM-dd HH:mm:ss",
                    columnWidth: "95px"
                },
                {
                    columnCode: "takeSamplingModal",
                    columnName: "方式",
                    customVal: {"0":"送样","1":"上门"},
                    columnWidth: "60px"
                },
                {
                    columnCode: "collectTime",
                    columnName: "收样时间",
                    dateFormat: "yyyy-MM-dd HH:mm:ss",
                    columnWidth: "95px"
                },
                {
                    columnCode: "samplingDate",
                    columnName: "下单时间",
                    dateFormat: "yyyy-MM-dd HH:mm:ss",
                    columnWidth: "95px"
                },
                {
                    columnCode: "orderStatus",
                    columnName: "进度",
                    customElement: "#checkedCount# / #detailsCount#",
                    columnWidth: "70px",
                    sortDataType:"rate"
                }
			]
		});
		datagrid3.query();

		$("#orderListDiv").show();
        $(".hidden-over .cs-col-lg-table").css({height:0,overflow:"hidden"})
	}
</script>
</body>
</html>
