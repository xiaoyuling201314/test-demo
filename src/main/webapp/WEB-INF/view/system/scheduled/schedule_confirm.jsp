<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%--停用模态框--%>
<div class="modal fade intro2" id="confirm-stopTask" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog cs-alert-width">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
				<h4 class="modal-title">确认停用</h4>
			</div>
			<div class="modal-body cs-alert-height cs-dis-tab">
				<div class="cs-text-algin">
					<img src="${webRoot}/img/warn.png" width="40px"/>
					<span class="tips">确认停用定时任务吗？</span>
				</div>
			</div>
			<div class="modal-footer">
				<a class="btn btn-danger btn-ok" onclick="stopTask()">停用</a>
				<button type="button" class="btn btn-" data-dismiss="modal">取消</button>
			</div>
		</div>
	</div>
</div>

<%--启用模态框--%>
<div class="modal fade intro2" id="confirm-startTask" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<input type="hidden" name="id" id="currentId" value=""/>
	<div class="modal-dialog cs-alert-width">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
				<h4 class="modal-title">确认启用</h4>
			</div>
			<div class="modal-body cs-alert-height cs-dis-tab">
				<div class="cs-text-algin">
					<img src="${webRoot}/img/sure.png" width="40px"/>
					<span class="tips">确认启用该定时任务吗？</span>
				</div>
			</div>
			<div class="modal-footer">
				<a class="btn btn-success btn-ok" onclick="enableStart()">启用</a>
				<button type="button" class="btn btn-" data-dismiss="modal">取消</button>
			</div>
		</div>
	</div>
</div>
