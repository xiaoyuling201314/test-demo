<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- 人工判定 --%>
<div class="modal modal2 fade intro2" id="assessmentModal" tabindex="-1" role="dialog" aria-labelledby="assessmentModalLabel">
	<div class="modal-dialog cs-mid-width" role="document">
		<div class="modal-content ">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
				<h4 class="modal-title" >人工判定考核状态</h4>
			</div>
			<div class="modal-body cs-mid-height">
				<div class="cs-tabcontent">
					<div class="cs-content2">
						<form id="assessmentForm" method="post" action="${webRoot}/dataCheck/unqualified/gs/determineFraud">
							<input type="hidden" name="id">
							<table class="cs-add-new">
								<tr>
									<td class="cs-name" style="width: 150px;">编号：</td>
									<td class="cs-in-style" style="width: 210px;">
										<input type="text" class="disabled-style" name="checkRecordingId" disabled="disabled"/>
									</td>
									<td></td>
								</tr>
								<tr>
									<td class="cs-name">样品名称：</td>
									<td class="cs-in-style">
										<input type="text" class="disabled-style" name="foodName" disabled="disabled"/>
									</td>
									<td></td>
								</tr>
								<tr>
									<td class="cs-name">检测项目：</td>
									<td class="cs-in-style">
										<input type="text" class="disabled-style" name="itemName" disabled="disabled"/>
									</td>
									<td></td>
								</tr>
								<tr>
									<td class="cs-name">考核状态：</td>
									<td class="cs-in-style">
										<select name="handledAssessment">
											<option value="0">正常</option>
											<option value="1">超时未处理</option>
											<option value="2">超时处理</option>
											<option value="3">处理不规范</option>
											<option value="4">超时不规范</option>
											<option value="5">造假</option>
										</select>
									</td>
									<td></td>
								</tr>
								<tr>
									<td class="cs-name"><i class="cs-mred">*</i>备注：</td>
									<td class="cs-in-style">
										<textarea class="cs-remark" name="handledRemark" cols="30" rows="10" datatype="*" nullmsg="请输入备注" errormsg="请输入备注" maxlength="180"></textarea>
									</td>
									<td></td>
								</tr>
							</table>
						</form>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-success" id="submitForFraud">确定</button>
				<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
			</div>
		</div>
	</div>
</div>
<script>
	//删除数据
	var df = $("#assessmentForm").Validform({
		tiptype: 2,
		ajaxPost: true,
		callback: function (data) {
			$.Hidemsg();
			$("#assessmentModal").modal("toggle");
			if (data && data.success) {
				reloadBack();
			} else {
				$("#confirm-warnning .tips").text(data.msg);
				$("#confirm-warnning").modal('toggle');
			}
		}
	});
	$(document).on("click", "#submitForFraud", function () {
		df.ajaxPost();
	});
</script>