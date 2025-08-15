<%@ page import="java.util.Date" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="modal fade intro2" id="reviewSamplingModal" tabindex="-1"  role="dialog" aria-labelledby="myModalLabel">
	<div class="modal-dialog cs-mid-width" role="document">
		<div class="modal-content ">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
				<h4 class="modal-title" id="myModalLabel">复核抽样单</h4>
			</div>
			<div class="modal-body cs-mid-height">
				<!-- 主题内容 -->
				<div class="cs-tabcontent" >
					<div class="cs-content2">
						<form id="reviewForm" method="post">
							<input type="hidden" name="id" />
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
											<select class="js-select2-tags" name="pointId" id="point_select" onchange="chosePoint();" datatype="*" nullmsg="请选择检测室!">
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
									<li  class="cs-name col-xs-3 col-md-3" width="20% ">抽样单号：</li>
									<li class="cs-in-style cs-modal-input" >
										<input type="text" name="samplingNo" readonly="readonly"  />
									</li>
									<li class="col-xs-4 col-md-4 cs-text-nowrap">
										<div class="Validform_checktip"></div>
										<div class="info"></div>
									</li>
								</ul>
								<ul class="cs-ul-form clearfix" id="pointSelUl">
									<li class="cs-name col-xs-3 col-md-3"><i class="cs-mred">*</i>复核人员：</li>
									<li class="cs-in-style cs-modal-input">
										<select class="js-select2-tags" name="reviewSignature" id="review_select" datatype="*" nullmsg="请选择复核人员!">
										</select>
									</li>
									<li class="col-xs-4 col-md-4 cs-text-nowrap">
										<div class="Validform_checktip"></div>
										<div class="info"></div>
									</li>
								</ul>
							</div>
						</form>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-success" id="reviewSamplBtn">保存</button>
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
		}else{
			//检测点用户，自动查询当前检测点下的用户列表
			chosePoint("${session_user.pointId}");
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

	/**
	 * 选择检测点后加载检测点下的用户列表信息
	 * @param pointId
	 */
	function chosePoint(pointId){
		if(pointId==undefined){
			pointId=$("#point_select option:checked").val();
		}
		$.ajax({
			url: "${webRoot}/system/user/queryUserByPointId.do",
			type: "POST",
			data: {"id": pointId},
			dataType: "json",
			async: false,
			success: function (data) {
				var list = data.obj;
				$("#review_select").empty("");
				$("#review_select").append('<option value="">-未选择-</option>');
				for (var i in list) {
					let reviewName=list[i].signatureFile;
					if(reviewName==""){
						reviewName=list[i].realname;
					}
					$("#review_select").append('<option value="' + reviewName + '" >' + list[i].realname + '</option>');
				}
			},
			error: function () {
				$.Showmsg("操作失败");
			}
		});
	}

	//保存复核人员信息
	$("#reviewForm").Validform({
		tiptype:2,
		beforeSubmit:function(){
			var reviewName=$("#review_select option:checked").val();
			var pointId="${session_user.pointId}"!="" ? "${session_user.pointId}" : $("#point_select option:checked").val();
			$.ajax({
				type: "POST",
				url: "${webRoot}/sampling/reviewSampling.do",
				data: {"ids":reviewObj.id,"reviewName":reviewName,"pointId":pointId},
				dataType: "json",
				success: function (data) {
					if (data && data.success) {
						$("#reviewSamplingModal").modal('hide');
						refreshData();
					} else {
						$("#waringMsg>span").html(data.msg);
						$("#confirm-warnning").modal('toggle');
					}
				}
			});
			return false;
		}
	});
	//表单提交
	$("#reviewSamplBtn").on("click", function () {
		$("#reviewForm").submit();
	});
	//打开编辑模态框前赋值
	$('#reviewSamplingModal').on('show.bs.modal', function(e) {
		$("#reviewForm input[name=samplingNo]").val(reviewObj.samplingNo);
		$("#reviewForm input[name=id]").val(reviewObj.id);
		if(reviewObj.reviewName!=""){
			$("#review_select").val(reviewObj.reviewName);
		}
	});
	//关闭编辑模态框前重置表单，清空隐藏域
	$('#reviewSamplingModal').on('hidden.bs.modal', function(e) {
		$("#reviewForm").Validform().resetForm();
		$("input").removeClass("Validform_error");
		$(".Validform_wrong").hide();
		$(".Validform_checktip").hide();
		$("#point_select").val("").trigger('change');
	});
</script>