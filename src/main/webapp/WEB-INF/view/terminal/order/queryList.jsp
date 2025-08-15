<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/common/resource.jsp"%>
<html>
<head>
	<title>快检服务云平台</title>
</head>
<body>
<div class="cs-col-lg clearfix">
	<ol class="cs-breadcrumb">
		<li class="cs-fl">
			<img src="${webRoot}/img/set.png" alt="" />
			<a href="javascript:">订单管理</a></li>
		<li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
		<li class="cs-b-active cs-fl">订单查询</li>
	</ol>
	<div class="cs-search-box cs-fr">
		<form>
			<div class="cs-search-filter clearfix cs-fl">
				<input class="cs-input-cont cs-fl focusInput" type="text" name="keyWords" placeholder="订单编号、交易流水号" />
				&nbsp;<input type="button" class="cs-search-btn cs-fl" onclick="Focus()" href="javascript:;" value="搜索">
			</div>
		</form>
	</div>
</div>

<div id="dataList"></div>

<%@include file="/WEB-INF/view/common/modalBox.jsp"%>
<%@include file="/WEB-INF/view/common/confirm.jsp"%>

<script src="${webRoot}/js/datagridUtil.js"></script>
<script type="text/javascript">
	var op = {
		tableId: "dataList",
		tableAction: "${webRoot}/order/queryOrderDatagrid",
		parameter: [
			{
				columnCode: "orderNumber",
				columnName: "订单编号",
				customElement: "<a class='text-primary cs-link _sampling_no_td'>?<a>",
				columnWidth: "12%",
                queryCode : "tbSampling.orderNumber",
                query: 1
			},
			{
				columnCode: "ccuName",
				columnName: "冷库名称",
                queryCode : "tbSampling.ccuName",
                query: 1
			},
			{
				columnCode: "orderUsername",
				columnName: "下单用户名称",
				columnWidth: "10%",
                queryCode : "tbSampling.orderUsername",
                query: 1
			},
			{
				columnCode: "orderUserPhone",
				columnName: "用户手机号码",
				columnWidth: "10%",
                queryCode : "tbSampling.orderUserPhone",
                query: 1
			},
			{
				columnCode: "orderFees",
				columnName: "订单费用",
				customElement: "￥?",
				columnWidth: "8%"
			},
			/*{
				columnCode: "samplingDate",
				columnName: "下单时间",
                dateFormat : "yyyy-MM-dd HH:mm:ss",
				columnWidth: "10%",
                query : 1,
                queryCode : "sampling",
                queryType : 3
			},*/
			{
				columnCode: "orderTime",
				columnName: "订单创建时间",
				columnWidth: "10%"
			},
			{
				columnCode: "orderStatus",
				columnName: "状态",
				customVal: {"0":"暂存","1":"待支付","2":"已支付","3":"已完成","4":"已取消","5":"检测中","6":"复检中"},
				columnWidth: "8%",
                queryCode : "tbSampling.orderStatus",
                queryType: 2,
                query: 1
			},
			{
				columnCode: "payNumber",
				columnName: "交易流水号",
				columnWidth: "10%",
				columnWidth: "15%",
                query: 1
			}
		],
		funBtns: [
			{	//查看订单详情
				show: Permission.exist("1443-1"),
				style: Permission.getPermission("1443-1"),
				action: function(id){
					showMbIframe("${webRoot}/order/details?id="+id);
				}
			},
			{	//激活订单
				// show: Permission.exist("1443-3"),
				show: 0,
				style: Permission.getPermission("1443-3"),
				action: function(id){
                    activationId = id;
                    $("#confirmModal .tips").text("激活订单？");
                    $("#confirmModal").modal('toggle');
				}
			}
		],
		onload: function () {
			$(datagridOption["obj"]).each(function (index, value) {
				//取消的已支付的订单，打开激活订单按钮
				if (value.orderStatus == "3" && value.payNumber) {
					$("#mdataList tbody tr:eq("+index+")").find(".1443-3").show();
				}
			});
		}
	};
	datagridUtil.initOption(op);
	datagridUtil.query();

	//查看订单详情
	$(document).on("click","._sampling_no_td",function(){
		showMbIframe("${webRoot}/order/details?id="+$(this).parents(".rowTr").attr("data-rowId"));
	});

    //激活订单
    var activationId = '';
    function confirmModal(){
        $.ajax({
            type: "POST",
            url: "${webRoot}/order/activateOrder",
            data: {"id":activationId},
            dataType: "json",
            success: function(data) {
                if (data && data.success) {
                    datagridUtil.refresh();
                } else {
                    $("#confirm-warnning .tips").text("激活失败");
                    $("#confirm-warnning").modal('toggle');
                }
            }
        });
    }
	function Focus(){

		datagridUtil.queryByFocus();

	}
</script>
</body>
</html>
