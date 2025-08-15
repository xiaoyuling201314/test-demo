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
	.has-pdb-40{
		padding-bottom: 40px;
	}
	</style>
</head>
<body>
<div class="cs-col-lg clearfix">
	<ol class="cs-breadcrumb">
		<li class="cs-fl">
			<img src="${webRoot}/img/set.png" alt="" />
			<a href="javascript:">订单管理</a></li>
		<li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
		<li class="cs-b-active cs-fl">订单管理</li>
	</ol>
	<div class="cs-input-style cs-fl" style="margin:3px 0 0 20px;">
		订单状态:
		<select class="check-date cs-selcet-style focusInput queryCondition" id="checkStatus" name="checkStatus" onchange="queryByKeys()">
			<option value=""  selected="selected">--全部--</option>
			<option value="1">待支付</option>
			<option value="2">已支付</option>
			<option value="3">已完成</option>
			<option value="4">已取消</option>
			<option value="5" >检测中</option>
			<option value="6" >复检中</option>
		</select>
	</div>
	<div class="cs-input-style cs-fl" style="margin:3px 0 0 20px;">
		取样状态:
		<select class="check-date cs-selcet-style focusInput queryCondition" id="checkProgress" name="checkProgress" onchange="queryByKeys()">
			<option value="" selected="selected">--全部--</option>
			<option value="0" >待接收</option>
			<option value="1" >待取样</option>
			<option value="2">已取样</option>
		</select>
	</div>
	<div class="cs-search-box cs-fr">
		<form>
			<span style="float: left;    line-height: 30px;">下单时间：</span>
			<span class="cs-in-style cs-time-se cs-time-se" style="float: left;margin-right: 20px;">
				<input name="samplingStartDate" id="beginDate" style="width: 110px;" class="cs-time focusInput" type="text"
					   onclick="WdatePicker({maxDate:'#F{$dp.$D(\'endDate\')||\'%y-%M-%d\'}',dateFmt:'yyyy-MM-dd'})">
				-
				<input name="samplingEndDate" id="endDate" style="width: 110px;" class="cs-time focusInput" type="text"
					   onclick="WdatePicker({minDate:'#F{$dp.$D(\'beginDate\')}',maxDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd'})">
		     </span>
			<div class="cs-search-filter clearfix cs-fl">
				<input class="cs-input-cont cs-fl focusInput" type="text"  id="keysVal" name="keyWords" placeholder="订单编号、送检电话" />
				&nbsp;<input type="button" class="cs-search-btn cs-fl" onclick="queryByKeys()" href="javascript:;" value="搜索">
				<span class="cs-s-search cs-fl">高级搜索</span>
			</div>
			<div class="clearfix cs-fr" id="showBtn"></div>
		</form>
	</div>
</div>

<!-- <div id="dataList"></div> -->
<div class="cs-col-lg-table">
         <div id="dataList"></div>
 </div>

<%@include file="/WEB-INF/view/common/modalBox.jsp"%>
<%@include file="/WEB-INF/view/common/confirm.jsp"%>
<%-- MD5加密 --%>
<script type="text/javascript" src="${webRoot}/plug-in/blueimp-md5/md5.min.js"></script>
<script type="text/javascript" src="${webRoot}/js/printTicket.js"></script>
<script src="${webRoot}/js/datagridUtil2.js"></script>
<script type="text/javascript">
	//
	$(function(){
		 if(!Permission.exist("1443-7")){
 			$(".totalMoney").addClass("cs-hide");
 		}
	});
	$("input[name='samplingStartDate']").val(new Date().DateAdd("d", -6).format("yyyy-MM-dd"));
	$("input[name='samplingEndDate']").val(new Date().format("yyyy-MM-dd"));
	var choseMoney = 0;	//已选金额
	var moneyCount = 0;	//当页金额
	var totalMoney = 0;	//合计金额;
	var op= {
		tableId: "dataList",
		tableAction: "${webRoot}/order/orderDatagrid",
		parameter: [
			{
				// columnCode: "samplingNo",
				columnCode: "orderNumber",
				columnName: "电子单号",
				customElement: "<a class='text-primary cs-link _sampling_no_td'>?<a>",
				columnWidth: "125px",
                queryCode : "tbSampling.orderNumber",
                query: 1
			},
 			{
				columnCode: "ccuName",
				columnName: "冷库名称",
                queryCode : "tbSampling.ccuName",
                columnWidth: "12%",
                customElement: "<a class='text-primary cs-link _sampling_no_td2'>?<a>",
                query: 1
			},
			{
				columnCode: "iuName",
				columnName: "仓号名称",
				queryCode : "tbSampling.iuName",
				columnWidth: "12%",
				//customElement: "<a class='text-primary cs-link _sampling_no_td3'>?<a>",
				query: 1
			},
			{
				columnCode: "orderUsername",
				columnName: "下单用户",
				columnWidth: "8%",
                queryCode : "tbSampling.orderUsername",
                query: 1
			},

			{
				columnCode: "orderTime",
				columnName: "下单时间",
				columnWidth: "105px",
				queryCode : "tbSampling.orderTime",
				query: 1
			},
			{
				columnCode: "detailsCount",
				columnName: "总批次",
				columnWidth: "80px",
				queryCode : "tbSampling.detailsCount",
				query: 1
			},
			{
				columnCode: "checkedCount",
				columnName: "已完成",
				columnWidth: "80px",
				queryCode : "tbSampling.checkedCount",
				query: 1
			},
			{
				columnCode: "orderFees",
				columnName: "订单费用",
				customElement: "<a class='text-primary cs-link _sampling_money'>￥? <a>",
				customStyle:"orderFees",
				columnWidth: "90px",
				sortDataType: "float"
			},{
				columnCode: "orderStatus",
				columnName: "订单状态",
				customVal: {"1":"待支付","2":"<span class='text-success'>已支付</span>","3":"已完成","4":"<span class='text-danger'>已取消</span>","5":"检测中","6":"<span class='text-warning'>复检中</span>"},
				columnWidth: "90px",
                queryCode: "tbSampling.orderStatus",
                queryType: 2,
                query: 1
			},
			{
				columnCode: "isSampling",
				columnName: "取样状态",
				customVal: {"0":"待接收","1":"待取样","2":"已取样"},
				columnWidth: "80px",
				customStyle:"isSampling",
			    query: 1
			}
			/*,{
				columnCode: "payDate",
				columnName: "付款时间",
				columnWidth: "95px",
				dateFormat: "yyyy-MM-dd HH:mm:ss",
				query: 1,
				queryType: 3,
				queryCode: "payDate"
			},
			{
				columnCode: "takeSamplingModal",
				columnName: "方式",
				customVal: {"0":"送样","1":"上门"},
				columnWidth: "60px",
				customStyle:"takeSamplingModal",
                queryCode: "takeSamplingModal",
                queryType: 2,
                query: 1
			},

			// {
			// 	columnCode: "takeFoodDate",
			// 	columnName: "取样时间",
			// 	columnWidth: "95px",
			// 	show:0
			// },
			{
				columnCode: "collectTime",
				columnName: "收样时间",
				columnWidth: "95px",
                sortDataType: "date"
			},
			{
				columnCode: "samplingDate",
				columnName: "下单时间",
                dateFormat: "yyyy-MM-dd HH:mm:ss",
				columnWidth: "95px",
				show: 0,
                query: 1,
                queryCode: "sampling",
                queryType: 3,
                sortDataType: "date"
			},
			{
				columnCode: "orderStatus",
				columnName: "进度",
				customElement: "#checkedCount# / #detailsCount#",
				columnWidth: "80px",
                sortDataType: "rate"
			}*/
		],
		funBtns: [
			{	//查看订单详情
				show: Permission.exist("1443-1"),
				style: Permission.getPermission("1443-1"),
				action: function(id, row){
					showMbIframe("${webRoot}/order/details?id="+id);
				}
			},
			{	//激活订单
				show: 0,
				style: Permission.getPermission("1443-3"),
				action: function(id, row){
                    activationId = id;
					flag=0;
                    $("#confirmModal .tips").text("激活订单，修改为已支付状态？");
                    $("#confirmModal").modal('toggle');
				}
			},
			{	//取样
				show: 0,
				style: Permission.getPermission("1443-8"),
				action: function(id, row){
					sampleFood(id);
				}
			},
			{	//打印下单凭证
				show: 0,
				style: Permission.getPermission("1443-5"),
				action: function(id, row){
                    var data = getJson(id);
                    printTicket(data.obj);
				}
			}
			,
			{	//订单流水
				show: Permission.exist("1443-4"),
				style: Permission.getPermission("1443-4"),
				action: function(id, row){
					showMbIframe("${webRoot}/income/detailList?samplingId="+id);
				}
			},
			{	//检测报告
				show: 0,
				style: Permission.getPermission("1443-2"),
				action: function(id, row){
					let data = getJson(id);
					getReport(data.obj.orderNumber);
				}
			},
			{	//取消订单
				show: 0,
				style: Permission.getPermission("1443-9"),
				action: function(id, row){
					activationId = id;
					flag=1;
					$("#confirmModal .tips").text("确认取消订单吗？");
					$("#confirmModal").modal('toggle');
				}
			}
		],
		summary: {
			summary2: [{
				title: "已选合计",
				text: choseMoney+"（元）"
			},{
				title: "当页合计",
				text: moneyCount+"（元）"
			},{
				title: "总计",
				text: totalMoney+"（元）"
			}]
		},
		onload: function (rows,data) {
			choseMoney = 0;	//已选金额
			moneyCount = 0;	//当页金额
			totalMoney = data.resultCode/100;	//合计金额;

			$(rows).each(function (index, value) {
				moneyCount+=value.orderFees/100;
				//ccuid和iuid
				var ccuId=value.ccuId;
				var iuId=value.iuId;
				var tbelement=$("#mdataList tbody tr:eq("+index+")");
				tbelement.attr("ccuId",ccuId);
				tbelement.attr("iuId",iuId);
				//待支付或已取消订单，打开激活订单按钮
				if (value.orderStatus == "1" || value.orderStatus == "4") {
					$("#mdataList tbody tr:eq("+index+")").find(".1443-3").show();
				}
				if(value.orderStatus == "2"){
					$("#mdataList tbody tr:eq("+index+")").find(".1443-5").show();
					//已支付且未收样显示取样按钮
					if (value.isSampling != 2) {
						$("#mdataList tbody tr:eq("+index+")").find(".1443-8").show();
					}
				}
				if(value.takeSamplingModal == "1" && value.isTakeSampling == "2"){
					var takeSamplingElement=$("#mdataList tbody tr:eq("+index+")").find(".takeSamplingModal");
					takeSamplingElement.text("上门  √");
					takeSamplingElement.attr("title","取样时间："+value.takeFoodDate);
					takeSamplingElement.addClass("takeSample");
				}
				$("#mdataList tbody tr:eq("+index+")").find("._sampling_money").html("¥"+value.orderFees/100);

				//控制查看报告按钮显示与隐藏
				if (value.detailsCount == value.checkedCount) {
					$("#mdataList tbody tr:eq("+index+")").find(".1443-2").show();
				}
				//显示取消订单按钮
				if (value.orderStatus == "1") {
					$("#mdataList tbody tr:eq("+index+")").find(".1443-9").show();
				}
				// 进度提醒背景色
				// if(value.orderStatus == "2" && parseInt(value.checkedCount) < parseInt(value.detailsCount)){
				// 	$("#mdataList tbody tr:eq("+index+")").css("background", "#fbd5d5");
				// }
				//已取消订单，不显示取样状态
				if(value.orderStatus == "4"){
					$("#mdataList tbody tr:eq("+index+")").find(".isSampling").text("");
				}
			});

			moneyCount = moneyCount != 0 ? moneyCount.toFixed(2) : 0;
			datagrid1.setSummary({
				summary2: [{
					title: "已选合计",
					text: choseMoney+"（元）"
				},{
					title: "当页合计",
					text: moneyCount+"（元）"
				},{
					title: "总计",
					text: totalMoney+"（元）"
				}]
			});
		}
	};
	var datagrid1 = datagridUtil.initOption(op);
	datagrid1.queryByFocus();



	//查看订单详情
	$(document).on("click","._sampling_no_td",function(){
		showMbIframe("${webRoot}/order/details?id="+$(this).parents(".rowTr").attr("data-rowId"));
	});
	//冷链单位
	$(document).on("click","._sampling_no_td2",function() {
		//showMbIframe("${webRoot}/order/regUtil?id="+$(this).parents(".rowTr").attr("data-rowId"));
		showMbIframe("${webRoot}/cold/unit/goAddRegulatoryObject?id="+$(this).parents(".rowTr").attr("ccuId"));
		//alert($(this).parents(".rowTr").attr("ccuId"));
	});
	//仓号名称
	$(document).on("click","._sampling_no_td3",function(){
		//showMbIframe("${webRoot}/order/regUtil?id="+$(this).parents(".rowTr").attr("data-rowId"));
		showMbIframe("${webRoot}/inspection/unit/queryById?id="+$(this).parents(".rowTr").attr("iuId"));

	});
	//点击订单金额查看交易明细
	$(document).on("click","._sampling_money",function(){
		showMbIframe("${webRoot}/income/detailList?samplingId="+$(this).parents(".rowTr").attr("data-rowId"));

	});
    //打印下单凭证
    function printTicket(data){
    	var printNum=1;
    	if(printNum>=0){
    		//发送打印命令
    		var sublength=12;
    	 	var line=data.samplingUsername==""? 1: "${tbSampling.inspectionCompany}".length/sublength;
    	 	
    		var printLine=data.samplingUsername.length%sublength==0 ? line : parseInt(line)+1;
    		
    		var d=new Date().format("yyyy-MM-dd HH:mm:ss")

    	 	sendMessage = " CODEPAGE UTF-8\r\n DIRECTION 1\r\n CLS\r\n" ;
    	 	sendMessage+="TEXT 35,20,\"TSS24.BF2\",0,1.8,2,\"************下单凭证************\"\r\n";
    	 	sendMessage+="TEXT 35,80,\"TSS24.BF2\",0,1,1,\"送检人员:"+data.samplingUsername+"\"\r\n" ;
    	 	
    	 	if(printLine>1){
    			sendMessage+="TEXT 35,"+(((printLine+1))*55)+",\"TSS24.BF2\",0,1,1,\"打印时间:"+d+"\"\r\n" ;
    	 	}else{
    	 		sendMessage+="TEXT 35,"+(((printLine+1))*60)+",\"TSS24.BF2\",0,1,1,\"打印时间:"+d+"\"\r\n" ;
    	 	}
    		sendMessage+="BARCODE 90,"+((printLine+2)*53)+",\"128\",100,2,0,2,5,\""+data.samplingNo+"\"\r\n";
    		sendMessage+="TEXT 90,"+((printLine+5)*51)+",\"TSS24.BF2\",0,1,1,\"(请向收样窗口出示此码)\"\r\n" ;
    		sendMessage+="PRINT 1,1\r\n" ;
    		sendMessage+="SOUND 5,100\r\n" ;
    		sendMessage+="CUT\r\n";
    		sendMessage+="OUT \"ABCDE\"\r\n"; 
    		sendMessage = "SIZE 58 mm, "+(42+(printLine*5))+" mm\r\n" + sendMessage;
    		//	$("#printMsg").text(sendMessage);
    	  	sendCommand(); 
    	}
    }
	
	
    //激活订单
    var activationId;
    var flag=0;//操作类型： 0 激活订单，1 取消订单
    function confirmModal(){
		//激活订单
		$.ajax({
			type: "POST",
			url: (flag==0? "${webRoot}/order/activateOrder" : "${webRoot}/order/cancelOrder" ),
			data: {"id":activationId},
			dataType: "json",
			success: function(data) {
				if (data && data.success) {
					datagrid1.query();
				} else {
					$("#confirm-warnning .tips").text("操作失败");
					$("#confirm-warnning").modal('toggle');
				}
			},
			error: function(data){
				$("#confirm-warnning .tips").text("操作失败"+data.msg);
				$("#confirm-warnning").modal('toggle');
			}
		});
    }
    
    function getJson(Id) {

    	var datas="";
        $.ajax({
            url: "${webRoot}/order/getOrderById.do",
            type: "POST",
            async: false,
            data: {"id": Id},
            dataType: "json",
            success: function (data) {
            	datas =data;

            }
        });
        return datas;
    	
    }
  //选中复选框，计算已选择金额
	const oldGetDatagridObj = datagridUtil.getDatagridObj;

	datagridUtil.getDatagridObj = function(id) {

		const obj = oldGetDatagridObj ? oldGetDatagridObj(id) : {};
			obj.changeBox=function() {
				var choseMoney=0;
				var cbs = document.getElementsByName("rowCheckBox");
				var mbStatus = true;	//选中全选复选框
				for (var i = 0; i < cbs.length; i++) {
					if (!cbs[i].checked) {
						mbStatus = false;
						break;
					}
				}
				document.getElementById("dataList_mainCheckBox").checked = mbStatus;
				for (var i = 0; i < cbs.length; i++) {
					if (cbs[i].checked) {
						choseMoney+=parseFloat($(cbs[i]).parent().parent().parent().find(".orderFees").text().substring(1));
					}
				}

				choseMoney=choseMoney!=0 ? choseMoney.toFixed(2) : 0;
				$("#summary span:eq(0) i:eq(0)").text(choseMoney+"（元）");
				//alert("调用成功！");
			};
			obj.checkedAll=function(){
				var choseMoney=0;
				var cbs = document.getElementsByName("rowCheckBox");
				if (document.getElementById("dataList_mainCheckBox").checked) {
					//全选
					for (var i = 0; i < cbs.length; i++) {
						cbs[i].checked = true;
					}
				} else {
					//全不选
					for (var i = 0; i < cbs.length; i++) {
						cbs[i].checked = false;
					}
				}
				for (var i = 0; i < cbs.length; i++) {
					if (cbs[i].checked) {
						choseMoney+=parseFloat($(cbs[i]).parent().parent().parent().find(".orderFees").text().substring(1));
					}
				}
				choseMoney=choseMoney!=0 ? choseMoney.toFixed(2) : 0;
				$("#summary span:eq(0) i:eq(0)").text(choseMoney+"（元）");


			};

		return obj;
	};

    datagridUtil.changeBox=function(){}


    datagridUtil.checkedAll=function () {}


	function queryByKeys(){

		var status=$("#checkStatus").val();
		var progress=$("#checkProgress").val();
		var bgDate=$("#beginDate").val();
		var edDate=$("#endDate").val();
		var keys=$("#keysVal").val();
		var queryParams = "?checkStatus=" + encodeURIComponent(status)
				+ "&checkProgress=" + encodeURIComponent(progress)
				+ "&beginDate=" + encodeURIComponent(bgDate)
				+ "&endDate=" + encodeURIComponent(edDate)
				+ "&keyWords=" + encodeURIComponent(keys);
		op.tableAction="${webRoot}/order/queryOrderDatagrid"+queryParams;
		datagrid1=datagridUtil.initOption(op);
		datagrid1.queryByFocus();
	}

	function sampleFood(orderId){
			//激活订单
		$.ajax({
			type: "POST",
			url: "${webRoot}/order/sampleFood",
			data: {"id":orderId},
			dataType: "json",
			success: function(data) {
				if (data && data.success) {
					$("#tips-success .tips").text("取样成功");
					$("#tips-success").modal('toggle');
					datagrid1.query();
				} else {
					$("#confirm-warnning .tips").text("取样失败");
					$("#confirm-warnning").modal('toggle');
				}
			}
		})
	}

	function getReport(orderNumber){
    	let ct=md5(orderNumber.substring(1));
		window.open("${webRoot}/api/order/getReport/"+orderNumber+"/"+ct+"/pdf");
	}
</script>

</body>
</html>
