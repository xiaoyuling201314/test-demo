<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/common/resource.jsp"%>
<html>
<head>
	<title>快检服务云平台</title>
</head>
<body>

<div id="dataList"></div>

<%@include file="/WEB-INF/view/common/modalBox.jsp"%>
<%@include file="/WEB-INF/view/common/confirm.jsp"%>

<script src="${webRoot}/js/datagridUtil2.js"></script>
<script type="text/javascript">

	var dgu = datagridUtil.initOption({
		tableId: "dataList",
		tableAction: "${webRoot}/income/detailDatagrid",
		tableBar: {
			title: ["财务管理", "财务明细","订单编号：${bean.orderNumber}"],
			hlSearchOff: 0,
			ele: [{
				eleShow: 1,
				eleName: "keyWords",
				eleType: 0,
				elePlaceholder: "请输入交易单号"
			}],
			topBtns: [{
				show: 1,
				style: {"functionIcon":"icon iconfont icon-fanhui","operationName":"返回"},
				action: function (ids, rows) {
					parent.closeMbIframe();
				}
			}],
		},
		parameter: [
			{
			columnCode: "realName",
			columnName: "付款用户",
			columnWidth: "90px"
			},{
				columnCode: "transactionType",
				columnName: "费用类型",
				columnWidth: "80px",
				query: 1,
				customVal:{"0":"订单费用","1":"打印费用"}
			},
			{
				columnCode: "payType",
				columnName: "付款方式",
				columnWidth: "8%",
				query: 1,
				customVal:{"0":"微信","1":"支付宝","2":"余额支付"},
				columnWidth: "80px"
			},
			{
				columnCode: "number",
				columnName: "商户订单号",
				/* customElement: "<a class='text-primary cs-link _sampling_no_td'>?<a>", */
				columnWidth: "13%"
			},{
				columnCode: "payNumber",
				columnName: "交易单号",
				/* customElement: "<a class='text-primary cs-link _sampling_no_td'>?<a>", */
				columnWidth: "15%"
			},
			{
				columnCode: "payDate",
				columnName: "交易时间",
				columnWidth: "11%",
				sortDataType:"date"
			},
			{
				columnCode: "checkMoney",
				columnName: "检测费(元)",
				columnWidth: "90px",
                sortDataType:"float"
			},
			{
				columnCode: "reportMoney",
				columnName: "报告费(元)",
				columnWidth: "90px",
                sortDataType:"float"
			},
			{
				columnCode: "takeSamplingMoney",
				columnName: "取样费(元)",
				columnWidth: "90px",
                sortDataType:"float"
			}
			/*,{
				columnCode: "totalMoney",
				columnName: "合计费用(元)",
				columnWidth: "9%"
			}*/
			,{
				columnCode: "money",
				columnName: "小计(元)",
				columnWidth: "100px",
                sortDataType:"float"
			},{
				columnCode: "status",
				columnName: "交易状态",
				customVal: {"0":"待支付","1":"成功","2":"失败","3":"关闭"},
				columnWidth: "80px",
				query: 1
			}
		],
		 defaultCondition: [
				{
				    queryCode: "samplingId",
				    queryVal: "${bean.id}"
				}, {
				    queryCode: "payDate",
				    queryVal: "${payDate}"
				}
			],
	/* 	,
		funBtns: [
			{	//查看订单详情
				show: Permission.exist("1443-1"),
				style: Permission.getPermission("1443-1"),
				action: function(id){
					showMbIframe("${webRoot}/order/details?id="+id);
				}
			}
		] */
		rowTotal: 0,	//记录总数
		pageSize: pageSize,	//每页数量
		pageNo: 1,	//当前页序号
		pageCount: 1,	// 总页数
		bottomBtns: []
	});
	dgu.queryByFocus();

</script>
</body>
</html>
