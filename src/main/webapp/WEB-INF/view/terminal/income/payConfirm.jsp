<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!-- Modal -->
<div class="modal fade intro2" id="confirm-delete3" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="static" data-keyboard="false">
	<div class="modal-dialog cs-alert-width">
		<div class="modal-content">
			<div class="cs-alert-height zz-dis-tab2 " style="">
				<div class="zz-pay zz-ok zz-no-margin zz-title-bg">
					<%-- <img src="${webRoot}/img/terminal/cuo.png" alt="" style="width: 40px"> --%>
					<p class="zz-ok-text" style="display: inline-block;">提示</p>
					</div>
				<div class="zz-notice">
					<img src="${webRoot}/img/terminal/cuo.png" alt="" style="width: 40px">确认要取消该订单吗？
				</div>	
			</div>
			<div class="modal-footer">
				<a href="javascript:" class="btn btn-danger cancelMsg" onclick="cancelOrder(${bean.id},${bean.samplingId },'${bean.number}')">取消订单</a>
				<a class="btn btn-primary" data-dismiss="modal">重新支付</a>
			</div>
		</div>
	</div>
</div>
<!-- 取消失败提示 -->
<div class="modal fade intro2" id="confirm-delete4" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="static" data-keyboard="false">
    <div class="modal-dialog cs-alert-width">
        <div class="modal-content">
            <div class="modal-body cs-alert-height zz-dis-tab2 " style="">
                <div class="zz-pay zz-ok zz-no-margin">
                    <img src="${webRoot}/img/terminal/cuo.png" alt="" style="width: 40px">
                    <p class="zz-ok-text" style="display: inline-block;">提示</p>
                </div>
                <div class="zz-notice">
                    订单取消失败，请联系工作人员。
                </div>
                <div class="modal-footer">
                    <button type="" class="btn btn-primary" data-dismiss="modal">关闭</button>
                </div>
            </div>
        </div>
    </div>
</div>
 <script type="text/javascript">
	function cancelOrder(incomeId,samplingId ,number){
		$.ajax({
	        type: "POST",
	        url: "${webRoot}/pay/cancelOrder.do",
	        data: {"incomeId":incomeId,"samplingId":samplingId,"orderid":number},
	        dataType: "json",
	        success: function (data) {
	            if (data && data.success ) {
	            	if(payType=="checkMoney"){
	                 	location.href="${webRoot}/terminal/goHome.do";
	            	}else if(payType=="printMoney"){
	            		//关闭付款页面
	                    $("#myContent1" , parent.document).show();
	                    parent.closeMbIframe();
	                    $(".printBtn",window.parent.document).removeAttr("disabled");
	            	}
	            }else if(data.obj!=null){//付款成功，进入支付成功页面
	            	$("#confirm-delete3").modal("toggle");
	            	 tips("订单支付成功，无法取消!");	
	            	 setTimeout(function(){
	            		 if(payType=="checkMoney"){
	            			 location.href="${webRoot}/pay/paySuccess.do?incomeId="+incomeId;
	 	            	}else if(payType=="printMoney"){
		            		//关闭付款页面
		                    $("#myContent1" , parent.document).show();
		                    parent.closeMbIframe();
		                    $(".printBtn",window.parent.document).removeAttr("disabled");
		            	}
	            	 },3000);
	            }else {
	               $("#confirm-delete4").modal("toggle");
	            }
	        },error:function(data){
	        	 tips("系统异常，请退出重新下单!");	
	        }
	    });
	}
	function callBackFunction(){
		 $.ajax({
		        type: "POST",
		        url: "${webRoot}/pay/cancelOrder",
		        data: {"incomeId":'${bean.id}',"orderid":'${bean.number}'},
		        dataType: "json",
		        success: function (data) {
		            if (data && data.success ) {
		            	 parent.location.href="${webRoot}/terminal/logout.do";
	               }else {
		               $("#confirm-delete4").modal("toggle");
		            }
		        }
		    });
	}
</script>