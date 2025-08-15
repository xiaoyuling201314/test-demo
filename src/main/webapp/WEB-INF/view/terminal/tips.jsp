<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style type="text/css">
	.modal{
		left:50% !important;
		top:50% !important;
		transform:translate(-50%,-50%);
		opacity: 1 !important;
	}
</style>
<!-- 提示 -->
<div class="modal fade intro2" id="_tips_modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="static" data-keyboard="false">
	<div class="modal-dialog cs-alert-width">
		<div class="modal-content">
			<div class="modal-body cs-alert-height zz-dis-tab2 " style="height:auto;    text-align: center;">
				<div class="zz-pay zz-ok zz-no-margin">
					<img src="${webRoot}/img/terminal/wen.png" alt="" style="width: 40px">
				</div>
				<div class="zz-notice" style="height: 40px; line-height: 40px;">
					操作失败，请联系工作人员。
				</div>
				<div class="modal-footer" style="text-align:center; padding:10px;">
					<button type="" class="btn btn-primary" onclick="closeModal()">关闭</button>
				</div>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
    var modalSwitch = 0; //提示框状态：0_关闭，1_打开
    $('#_tips_modal').on('show.bs.modal', function () {
        modalSwitch = 1;
    });
    $('#_tips_modal').on('hidden.bs.modal', function () {
        modalSwitch = 0;
    });
	//提示信息
	function tips(t) {
        if (modalSwitch == 0){
            $("#_tips_modal .zz-notice").text(t);
            updateCloseTime(0);
        }
	}
	function closeModal(){
		$("#_tips_modal").modal("hide");
		clearTimeout(clockTime);
	}
	//自动关闭提示倒计时
	var clostSecond = 3;    //提示关闭倒计时（秒）
    var clockTime;
	function updateCloseTime(waitSecond) {
		if(waitSecond == 0){
			$("#_tips_modal").modal("show");
			$("#_tips_modal button").text("关闭("+clostSecond+"s)");
			clockTime=setTimeout(function () {
				updateCloseTime(++waitSecond);
			}, 1000);

		}else if(waitSecond < clostSecond){
			$("#_tips_modal button").text("关闭("+(clostSecond-waitSecond)+"s)");
			clockTime=setTimeout(function () {
				updateCloseTime(++waitSecond);
			}, 1000);
		}else{
			$("#_tips_modal").modal("hide");
		}
	}
</script>


