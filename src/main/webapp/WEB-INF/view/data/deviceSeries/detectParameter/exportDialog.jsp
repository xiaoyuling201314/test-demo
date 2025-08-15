<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="modal export-modal fade" id="exportModal" tabindex="-1" style="z-index:10000" role="dialog" aria-labelledby="myModalLabel">
	<div class="modal-dialog cs-alert-width">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title">导出仪器检测项目</h4>
			</div>
			<div class="modal-body text-center">
				<ul class="cs-ul-form clearfix">
					<li class="cs-name col-xs-3 col-md-3 text-right" style="width: 28%;">仪器类别：
					</li>
					<li class="cs-in-style">
						<span class="produceBatch">${deviceType.deviceName}</span>
					</li>
				</ul>
				<ul class="cs-ul-form clearfix">
					<li class="cs-name col-xs-3 col-md-3 text-right" style="width: 28%;">项目数量：
					</li>
					<li class="cs-in-style">
						<span class="exportNumbers">0</span>
					</li>
				</ul>
				<ul class="cs-ul-form clearfix">
					<li class="cs-name col-xs-3 col-md-3 text-right" style="width: 28%;">导出格式：
					</li>
					<li class="cs-in-style">
						<label class="">
							<input type="radio" name="inlineRadioOptions" id="inlineRadio1" value="excel" checked="checked">
							<i class="iconfont text-success">&#xe646;</i> Excel
						</label>
					</li>
				</ul>
				<%--<div class="row cs-export-row" style="padding-top:5px;">
					<div class="cs-export-box col-sm-12">
						<label class="radio-inline">
							<input type="radio" name="inlineRadioOptions" id="inlineRadio1" value="excel" checked="checked">
							<i class="iconfont text-success">&#xe646;</i> Excel
						</label>
					</div>
				</div>--%>
			</div>
			<div class="modal-footer">
		      	<button type="button" class="btn btn-success" onclick="exportFile();">导出</button>
				<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
		    </div>
		</div>
	</div>
</div>