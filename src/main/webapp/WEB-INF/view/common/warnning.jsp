<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <!-- Modal 提示窗-删除-->
	<div class="modal fade intro2" id="confirm-warnning" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog cs-alert-width">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
				<h4 class="modal-title">提示</h4>
			</div>
			<div class="modal-body cs-alert-height cs-dis-tab">
				<div class="cs-text-algin">
					<img src="${webRoot}/img/warn.png" width="40px" alt="" />
					<span class="tips">操作失败</span>
				</div>
			</div>
			<div class="modal-footer">
				<a class="btn btn-primary btn-ok" data-dismiss="modal">关闭</a>
			</div>
		</div>
		</div>
	</div>