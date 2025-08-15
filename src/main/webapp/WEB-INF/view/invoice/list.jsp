<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/common/resource.jsp"%>
<html>
<head>
<title>快检服务云平台</title>
</head>
<body>
	<div class="cs-col-lg clearfix">
		<!-- 面包屑导航栏  开始-->
		<ol class="cs-breadcrumb">
			<li class="cs-fl"><img src="${webRoot}/img/set.png" alt="" /> <a href="javascript:">财务管理</a></li>
			<li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
			<li class="cs-b-active cs-fl">开票管理</li>
		</ol>
		<!-- 面包屑导航栏  结束-->

		<div class="cs-search-box cs-fr">
			<form>
				<span class="check-date cs-fl" style="display: inline;">
					<span class="cs-name">开票类型:</span>
					<span class="cs-in-style cs-time-se cs-time-se">
						<select name="invoiceType" class="cs-selcet-style focusInput" style="width: 80px;">
							<option value="1">订单</option>
							<option value="2">充值</option>
						</select>
					</span>
					<span class="cs-name">时间范围:</span> 
					<span class="cs-in-style cs-time-se cs-time-se">
						<input name="startTimeStr" id="startTimeStr" style="width: 110px;" class="cs-time focusInput" type="text" onclick="WdatePicker()" autocomplete="off">
						<span style="padding: 0 5px;">至</span> 
						<input name="endTimeStr" id="endTimeStr" style="width: 110px;" class="cs-time focusInput" type="text" onclick="WdatePicker()" autocomplete="off">
						&nbsp;
					</span>
				</span> 
				<div class="cs-search-filter clearfix cs-fr">
					<input class="cs-input-cont cs-fl focusInput" type="text" name="search" placeholder="订单号、联系方式" />
					<input type="button" class="cs-search-btn cs-fl" href="javascript:;" value="搜索" onclick="query();">
					<%--<span class="cs-s-search cs-fl">高级搜索</span>--%>
				</div>
				<div class="clearfix cs-fr" id="showBtn"></div>
			</form>
		</div>
	</div>

	<div id="dataList"></div>

	<div class="modal fade intro2" id="addModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
		<div class="modal-dialog cs-mid-width" role="document">
			<div class="modal-content ">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
					<h4 class="modal-title" id="myModalLabel">开票</h4>
				</div>
				<div class="modal-body cs-mid-height">
					<div class="cs-tabcontent" >
						<div class="cs-content2">
							<form id="saveForm">
								<input type="hidden" name="ids">
								<div width="100%" class="cs-add-new">
									<ul class="cs-ul-form clearfix">
										<li  class="cs-name col-md-3 col-xs-3" ><i class="cs-mred">*</i>类型：</li>
										<li class="cs-in-style cs-modal-input" style="width: 230px;">
											<input id="_t1" type="radio" name="type" value="0" checked="checked"/>
											<label for="_t1">企业单位</label>

											<input id="_t2" type="radio" name="type" value="1" />
											<label for="_t2">个人/非企业单位</label>
										</li>
									</ul>
									<ul class="cs-ul-form clearfix">
										<li  class="cs-name col-md-3 col-xs-3" ><i class="cs-mred">*</i>抬头：</li>
										<li class="cs-in-style cs-modal-input" >
											<input type="text" name="title" />
										</li>
									</ul>
									<ul class="cs-ul-form clearfix">
										<li  class="cs-name col-md-3 col-xs-3" ><i class="cs-mred">*</i>税号：</li>
										<li class="cs-in-style cs-modal-input" >
											<input type="text" name="tallageno" />
										</li>
									</ul>
								</div>
							</form>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-success" onclick="mySubmit();">确定</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				</div>
				</form>
			</div>
		</div>
	</div>

	<%@include file="/WEB-INF/view/common/confirm.jsp"%>

	<script src="${webRoot}/js/datagridUtil2.js"></script>
	<script type="text/javascript">
	$(function () {
		$("input[name='startTimeStr']").val(new Date().DateAdd("d",-30).format('yyyy-MM-dd'));
		$("input[name='endTimeStr']").val(new Date().format('yyyy-MM-dd'));

		query();

	});

	//切换发票类型
	$(document).on("change","input[name='type']",function(){
		if ("0" == $("input[name='type']:checked").val()){
			$("input[name='tallageno']").parents("ul").show();
		} else if ("1" == $("input[name='type']:checked").val()){
			$("input[name='tallageno']").parents("ul").hide();
		}
	});

	//隐藏开票窗口
	$('#addModal').on('hide.bs.modal', function (){
		$("#addModal input[name='ids']").val("");
		$("#addModal input[name='title']").val("");
		$("#addModal input[name='tallageno']").val("");
	});

	function query(){
		var op;
		//订单发票
		if ("1" == $("select[name='invoiceType']").val()){
			op = {
				tableId: "dataList",
				tableAction: "${webRoot}/invoiceManage/datagrid",
				rowIdCode: "samplingId",
				parameter: [{
					columnCode: "samplingNo",
					columnName: "订单号"
				},{
					columnCode: "username",
					columnName: "送检人"
				},{
					columnCode: "phone",
					columnName: "联系方式"
				},{
					columnCode: "title",
					columnName: "抬头"
				},{
					columnCode: "tallageno",
					columnName: "税号"
				},{
					columnCode: "number",
					columnName: "流水号"
				},{
					columnCode: "filePath",
					columnName: "发票"
				}],
				funBtns: [{
					show: 0,
					style: Permission.getPermission("1458-1"),
					action: function(id) {
						if (id){
							$("#addModal input[name='ids']").val(id);
							$("#addModal").modal("show");
						} else {
							alert("没有订单ID");
						}

					}
				}],
				onload: function () {
					$("#mdataList tr").each(function () {
						if (!$(this).find("td:eq(4)").text()){
							$(this).find(".1458-1").show();
						}
					});
				}
			};

		//充值发票
		} else if ("2" == $("select[name='invoiceType']").val()){

		}

		var du1 = datagridUtil.initOption(op);
		datagridUtil.queryByFocus();

	}

	function mySubmit() {
		var samplingId = $("#addModal input[name='ids']").val();
		var title = $("#addModal input[name='title']").val();
		var tallageno = $("#addModal input[name='tallageno']").val();
		var type = $("input[name='type']:checked").val();

		if (type == "0" && samplingId && title && tallageno){
			$.ajax({
				type: "POST",
				url: "${webRoot}/wx/invoice/apply",
				data: {"ids":samplingId, "title":title, "tallageno":tallageno},
				dataType: "json",
				success: function(data){
					console.log(JSON.stringify(data));
					$("#addModal").modal("hide");
					if(data && data.success){
						datagridUtil.queryByFocus();
					}else{
						$("#waringMsg>span").html(data.msg);
						$("#confirm-warnning").modal('toggle');
					}
				}
			});

		} else if (type == "1" && samplingId && title){

		} else {
			alert("请输入必填信息");
		}
	}

	</script>
</body>
</html>
