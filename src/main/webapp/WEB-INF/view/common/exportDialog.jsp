<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="modal export-modal fade" id="exportModal" tabindex="-1" style="z-index:10000" role="dialog" aria-labelledby="myModalLabel">
	<div class="modal-dialog cs-alert-width">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title">选择导出格式</h4>
			</div>
			<div class="modal-body text-center">
				<div class="row cs-export-row" style="padding-top:5px;">
					<div class="cs-export-box col-sm-12">
						<label class="radio-inline">
							<input type="radio" name="inlineRadioOptions" id="inlineRadio1" value="excel" checked="checked">
							<i class="iconfont text-success">&#xe646;</i> Excel
						</label>
					</div>
					<div class="cs-export-box col-sm-4 cs-hide">
						<label class="radio-inline">
							<input type="radio" name="inlineRadioOptions" id="inlineRadio2" value="word" disabled="disabled"> 
							<i class="iconfont text-primary">&#xe64a;</i> Word
						</label>
					</div>
					<div class="cs-export-box col-sm-4 cs-hide">
						<label class="radio-inline"> 
							<input type="radio" name="inlineRadioOptions" id="inlineRadio3" value="pdf" disabled="disabled"> 
							<i class="iconfont text-danger">&#xe647;</i> PDF
						</label>
					</div>
				</div>
				<div class="text-center">
					
				</div>
			</div>
			<div class="modal-footer">
		      	<button type="button" class="btn btn-success" onclick="exportFile();">导出</button>
				<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
		    </div>
		</div>
	</div>
</div>