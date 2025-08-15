<%@ page import="java.util.Date" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="modal fade intro2" id="exportStandBookModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	<div class="modal-dialog cs-mid-width" role="document">
		<div class="modal-content ">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
				<h4 class="modal-title" id="myModalLabel">台账导出</h4>
			</div>
			<div class="modal-body cs-mid-height">
				<!-- 主题内容 -->
				<div class="cs-tabcontent" >
					<div class="cs-content2">
						<form id="exportForm" method="post">
							<div width="100%" class="cs-add-new">
								<c:if test="${session_user.pointId=='' || session_user.pointId==null}">
									<ul class="cs-ul-form clearfix">
										<li class="cs-name col-xs-3 col-md-3"><i class="cs-mred">*</i>所属机构：</li>
										<li class="cs-in-style cs-modal-input">
											<div class="cs-all-ps">
												<div class="cs-input-box">
													<input type="hidden" class="sPointId" name="departId" value="${session_user.departId}">
													<input type="text" name="departName" readonly="readonly" value="${session_user.departName}" class="sPointName cs-down-input" datatype="*"
														   nullmsg="请选择机构!" errormsg="请选择机构!"/>
													<div class="cs-down-arrow"></div>
												</div>
												<div id="divBtn" class="cs-check-down  cs-hide" style="display: none;">

													<!-- 树状图 -->
													<ul id="tt" class="easyui-tree">
													</ul>
													<!-- 树状图 -->

												</div>
											</div>
										</li>
										<li class="col-xs-4 col-md-4 cs-text-nowrap">
											<div class="Validform_checktip"></div>
											<div class="info"></div>
										</li>
									</ul>
									<ul class="cs-ul-form clearfix" id="pointSelUl">
										<li class="cs-name col-xs-3 col-md-3"><i class="cs-mred">*</i>检测室：</li>
										<li class="cs-in-style cs-modal-input">
											<select class="js-select2-tags" name="pointId" id="point_select" datatype="*" nullmsg="请选择检测室!">
												<option value="">--请选择--</option>
											</select>
										</li>
										<li class="col-xs-4 col-md-4 cs-text-nowrap">
											<div class="Validform_checktip"></div>
											<div class="info"></div>
										</li>
									</ul>

								</c:if>
								<ul class="cs-ul-form clearfix">
									<li  class="cs-name col-xs-3 col-md-3" width="20% "><i class="cs-mred">*</i>日期：</li>
									<li class="cs-in-style cs-modal-input" >
										<input class="cs-time" type="text" name="relTime" id="standBookDate" onClick="WdatePicker()" value="<fmt:formatDate value='<%=new Date() %>' pattern='yyyy-MM-dd'/>" datatype="*" nullmsg="请选择日期" /></li>
									</li>
									<li class="col-xs-4 col-md-4 cs-text-nowrap">
										<div class="Validform_checktip"></div>
										<div class="info"></div>
									</li>
								</ul>
								<ul class="cs-ul-form clearfix">
									<li  class="cs-name col-xs-3 col-md-3" width="20% ">格式：</li>
									<li class="cs-in-style col-xs-9 col-md-9" >
										<div class="col-sm-8">
											<label class="radio-inline" style="font-size: 17px;margin-left: 20px;">
												<input type="radio" name="inlineRadioOptions" id="inlineRadioStandBook" value="excel" checked="checked" style="margin-top: 7px;">
												<i class="iconfont text-success" style="font-size: 15px;">&#xe646;</i> Excel
											</label>
										</div>
									</li>
								</ul>
							</div>
						</form>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-success" id="exportBookBtn">导出</button>
				<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
			</div>
			</form>
		</div>
	</div>
</div>
<script>
	$(function () {
		if("${session_user.pointId}"==""){
			//初始化检测点选择
			queryPoint(${session_user.departId});
			$('.js-select2-tags').select2();
			$("#tt").tree({
				checkbox: false,
				url: "${webRoot}/detect/depart/getDepartTree.do",
				animate: true,
				lines: false,
				onClick: function (node) {
					$(".sPointId").val(node.id);
					$(".sPointName").val(node.text);
					$(".cs-check-down").hide();
					queryPoint(node.id);
				}
			});
		}
	});
	//根据机构加载检测点信息
	function queryPoint(e) {
		var id = e;
		$("#point_select").empty();
		$.ajax({
			url: "${webRoot}/system/user/getPoint.do",
			type: "POST",
			data: {"id": id},
			dataType: "json",
			async: false,
			success: function (data) {
				var list = data.obj;
				$("#point_select").append('<option value="">-未选择-</option>');
				for (var i in list) {
					$("#point_select").append('<option value="' + list[i].id + '">' + list[i].pointName + '</option>');
				}
			},
			error: function () {
				$.Showmsg("操作失败");
			}
		});
	}
	//导出台账数据
	$("#exportForm").Validform({
		tiptype:2,
		beforeSubmit:function(){
			let standBookStartDate=$("#standBookDate").val()+" 00:00:00";
			let standBookEndDate=$("#standBookDate").val()+" 23:59:59";
			let radios = $("#inlineRadioStandBook").val();
			let pointId="${session_user.pointId}"=="" ? $("#point_select option:checked").val() : "${session_user.pointId}";
			let pointName="${session_user.pointName}"=="" ? $("#point_select option:checked").text() : "${session_user.pointName}";
			$('.cs-search-all input[name=pointName]').val(pointName);
			let form = $('.cs-search-all').serialize();
			form = decodeURIComponent(form, true);
			//"&regTypeId="+$("#regType").val()+
			if("undefined" == typeof dataType){
				dataType="${dataType}";
			}
			<%--location.href = '${webRoot}/dataCheck/recording/exportFile.do?' + form + '&type=' + radios + '&keyWords=' + $("#dataList input[name='keyWords']").val()+'&checkDateStartDateStr='+standBookStartDate+'&checkDateEndDateStr='+standBookEndDate+"&dataType="+dataType+"&exportDataType="+exportDataType+"&pointId="+pointId;--%>

			//查询数据条件仅限于弹窗内的选项 --Dz 20220708
			location.href = '${webRoot}/dataCheck/recording/exportFile.do?type=' + radios + '&checkDateStartDateStr='+standBookStartDate+'&checkDateEndDateStr='+standBookEndDate+"&dataType="+dataType+"&exportDataType="+exportDataType+"&pointId="+pointId+"&pointName="+pointName;
			$("#exportStandBookModal").modal('hide');
			return false;
		}
	});
	//表单提交
	$("#exportBookBtn").on("click", function () {
		$("#exportForm").submit();
	});
	//关闭编辑模态框前重置表单，清空隐藏域
	$('#exportStandBookModal').on('hidden.bs.modal', function(e) {
		$("#exportForm").Validform().resetForm();
		$("input").removeClass("Validform_error");
		$(".Validform_wrong").hide();
		$(".Validform_checktip").hide();
		$("#point_select").val("").trigger('change');
		$('#queryForm input[name=pointName]').val("");
	});
</script>