<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/WEB-INF/view/terminal/resource.jsp"%>

<html>
<head>
    <title>快检服务云平台</title>
</head>
<body>
 <div class="zz-content">
 <div class="zz-title2">
        <img class="pull-left" src="${webRoot}/img/terminal/title2.png" alt=""><span >充值中心 </span>
         <div class="btn lt-btn pull-right btn" style="position: absolute;right: 5px;top: 18px;"><a href="${webRoot}/terminal/logout.do" class="pull-left" style="width: 102px;color:#fff;">
			<i class="icon iconfont icon-tuichu1"></i>&nbsp;退出</a>
			 <i class="showTime cs-hide" style="font-size:28px;font-weight:bold;right: 113px;top: 27px;"></i>
		</div>
    </div>
    <div class="zz-cont-box">
        <!-- <div class="zz-title2">	<span >充值中心</span>
		<i class="showTime cs-hide" style="top: 35px;font-size:28px;font-weight:bold;color:#4373e0;border-color:#4373e0;"></i>
        </div> -->
        <div class="zz-table zz-center-pay">
            <div class="zz-code col-md-12 ">
                <div class="zz-list col-md-12 ">
                    <div class="col-md-12 ">
							支付金额：	<i class="text-primary" id="price_money"></i>
							</div>
							<div class="col-md-12 ">
							赠送金额：	<i class="text-primary"  id="price_giftmoney"></i>
							</div>
							
							<div class="col-md-12 ">
							实际到账：	<i class="text-primary"  id="price_totalmoney"></i>
							</div>
                </div>
                <div class="zz-pay2 col-md-12">
                    <div class="select-pay">
                   	  <c:if test="${weiPay=='0' }">
                        <label for="weixinPay" class="active show-codes">
                            <div class="demo-list">
                                <ul>
                                    <li>
                                        <input tabindex="1" type="radio" name="pay" id="weixinPay" checked="checked" >
                                    </li>
                                </ul>
                            </div>
                            <img src="${webRoot}/img/terminal/wx.png" alt="" style="width: 22px;margin-right:5px">微信支付</label>
                         </c:if>
                         <c:if test="${aliPay=='0' }">
	                        <label for="aliyPay" class="show-codes"  >
	                            <div class="demo-list">
	                                <ul>
	                                    <li> 
		                                   <c:choose>
	                        					<c:when test="${weiPay=='1'}">
		                        					<input tabindex="1" type="radio" name="pay" id="aliyPay" checked="checked"  />
			                                    </c:when>
			                                    <c:otherwise>
			                                    	<input tabindex="1" type="radio" name="pay" id="aliyPay" />
			                                    </c:otherwise>
		                                    </c:choose>
	                                    </li>
	                                </ul>
	                            </div>
                            <img src="${webRoot}/img/terminal/tb.png" alt="" style="width: 22px;margin-right:5px">支付宝支付</label>
                           </c:if>
                    </div>
                    <div class="input-box-weixin col-md-12" style=" display: none">
                        <div class="zz-2dcode zz-2dcode2">
                            <img src="${webRoot}/pay/weipay.do?orderid=${bean.number}&money=${bean.money}&title=账号充值" id="qrCodeWeiXinPay" alt="点击重试" onclick="flushImage('weixinPay')" style="width: 200px;" alt="">
                            <p style="font-size: 18px;">
                                <img src="${webRoot}/img/terminal/wx.png" alt="" id="pType" style="width: 22px;margin-right:5px">金额：<i class="text-danger">${bean.money}元</i>
                            </p>
                            <div class="zz-pay-all col-md-12 payTitle" style="color:#dc8703;font-size:16px;margin-top: 20px;"><i class="icon iconfont icon-bell" style="color:#dc8703;margin:0 4px;"></i>支付成功，不予退款</div>
                        </div>
                    </div>
                       <div class="input-box-alipay col-md-12" style=" display: none">
                        <div class="zz-2dcode zz-2dcode2">
                            <img src="${webRoot}/pay/alipay.do?orderid=${bean.number}&money=${bean.money}&title=账号充值" id="qrCodeAliPay" alt="点击重试"  onclick="flushImage('aliyPay')" style="width: 200px;" alt="">
                            <p style="font-size: 18px;">
                                <img src="${webRoot}/img/terminal/tb.png" alt="" id="pType" style="width: 22px;margin-right:5px">金额：<i class="text-danger">${bean.money}元</i>
                            </p>
                            <div class="zz-pay-all col-md-12 payTitle" style="color:#dc8703;font-size:16px;margin-top: 20px;"><i class="icon iconfont icon-bell" style="color:#dc8703;margin:0 4px;"></i>支付成功，不予退款</div>
                        </div>
                    </div>
                </div>
                <div>
                    <img src="${webRoot}/img/terminal/code2.png" style="display: none; border: 1px solid #00911f" alt="">
                </div>
            </div>
            <div class="zz-price-all zz-hide">
                <div>
                    <img src="${webRoot}/img/terminal/code2.png" style="display: none; border: 1px solid #00911f" alt="">
                </div>
            </div>
        </div>
        <div class="zz-tb-btns col-md-12 " style="margin-top:176px ">
        	<a href="javascirpt:;" id="_back"  class="btn btn-danger">返回</a>
        	<a href="javascirpt:;" data-toggle="modal" data-target="#confirm-delete3" class="btn btn-danger">取消</a>
        </div>
    </div>
</div>
</div>
<!-- Modal -->
<div class="modal fade intro2" id="confirm-delete3" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="static" data-keyboard="false">
	<div class="modal-dialog cs-alert-width">
		<div class="modal-content">
			<div class="modal-body cs-alert-height zz-dis-tab2 " style="">
				<div class="zz-pay zz-ok zz-no-margin">
					<img src="${webRoot}/img/terminal/cuo.png" alt="" style="width: 40px">
					<p class="zz-ok-text" style="display: inline-block;">提示</p>
					</div>
				<div class="zz-notice">
					确认要取消该支付吗？
				</div>	
			</div>
			<div class="modal-footer">
				<a href="javascript:" class="btn btn-danger" onclick="cancelOrder(${bean.id},'${bean.number}')">取消支付</a>
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
</body>
 <%@include file="/WEB-INF/view/terminal/returnConfirm.jsp"%>
<%@include file="/WEB-INF/view/terminal/tips.jsp"%>
 <script src="${webRoot}/js/num-alignment.js"></script>
<script src="${webRoot}/plug-in/iCheck/icheck.js?v=1.0.2"></script>
<script src="${webRoot}/plug-in/iCheck/js/custom.min.js?v=1.0.2"></script> 
<script type="text/javascript">
	 var i=0;
	 var query;
	 var timeCount=120;//总时长
// 	 var showCount=60;//实时时长
	 query=setInterval("clock('weixinPay')",3000);
	 var weixinPay=false;
	 var aliPay=false;
	function clock(pType)
	{
		i++;
		if(i>=10){
			weixinPay=true;
			aliPay=true;
		}else if(pType=="weixinPay"){
			weixinPay=true;
		}else if(pType=="aliyPay"){
			aliPay=true;
		}
		 $.ajax({
             type: "POST",
             url: "${webRoot}/pay/payQuery.do",
             data: {"id":"","orderid":"${bean.number}","weixinPay":weixinPay,"aliPay":aliPay},
             dataType: "json",
             success: function (data) {
            	 if (data && data.success && (data.obj.status==1 || data.obj.weixin_trade_state=="SUCCESS" || data.obj.trade_state=="TRADE_SUCCESS")) {
                	 clearInterval(query);
	                  location.href="${webRoot}/balance/paySuccess.do?incomeId=${bean.id}";
                 }else if(data.attributes.trade_state=="TRADE_CLOSED" || data.attributes.trade_state=="PAYERROR"){//交易关闭
                	 $("#confirm-delete3").modal('toggle');
                 } else {
                    
                 }
             }
         });
	}  
	
$(function(){
		$("#price_money").html("${bean.money}元");
		$("#price_giftmoney").html("${giftMoney}元");
		var total=parseFloat(${bean.money+giftMoney});
		$("#price_totalmoney").html(total+"元");
		if('${weiPay}'=='0'){//支持微信支付
			$('.input-box-weixin').show();
			$('.input-box-alipay').hide();
			$("#weixinPay").attr("checked","checked");
			$(".select-pay").find(".weixinPay").addClass('active').siblings().removeClass('active');
			 query=setInterval("clock('weixinPay')",3000);
		}else if('${aliPay}'=='0'){//支持支付宝支付
			$('.input-box-alipay').show();
			$('.input-box-weixin').hide();
			$("#aliyPay").attr("checked","checked");
			$(".select-pay").find(".aliyPay").addClass('active').siblings().removeClass('active');
			 query=setInterval("clock('aliyPay')",3000);
		} 
	});
	function cancelOrder(incomeId,number){
		$.ajax({
	        type: "POST",
	        url: "${webRoot}/balance/cancelOrder.do",
	        data: {"incomeId":incomeId},
	        dataType: "json",
	        success: function (data) {
	            if (data && data.success ) {
	            	if("${incomeId}"!=""){
			        	location.href = "${webRoot}/pay/list.do?incomeId=${incomeId}";
		           }else{
	                    location.href="${webRoot}/balance/list.do";
		           }
	            }else if(data.obj!=null){//付款成功，进入支付成功页面
	            	$("#confirm-delete3").modal("toggle");
	            	 tips("订单支付成功，无法取消!");	
	            	 setTimeout(function(){
	            		 location.href="${webRoot}/balance/paySuccess.do?incomeId=${bean.id}";
	            	 },3000);
	            }else {
	            	tips("订单取消失败，请联系工作人员!");	
	            }
	        }
	    });
	}
	function callBackFunction(){
		 $.ajax({
		        type: "POST",
		        url: "${webRoot}/balance/cancelOrder",
		        data: {"incomeId":'${bean.id}'},
		        dataType: "json",
		        success: function (data) {
		            if (data && data.success ) {
		            	location.href="${webRoot}/terminal/logout.do";
	               }else {
	            	   tips("订单取消失败，请联系工作人员!");	
		            }
		        }
		    });
	}
	$('.select-pay label').click(function(){
		$(this).addClass('active').siblings().removeClass('active')
		var pType=$(this).find("input").attr("id");
	   if(pType=="weixinPay"){
			$('.input-box-weixin').show();
			$('.input-box-alipay').hide();
		}else if(pType=="aliyPay"){
			$('.input-box-alipay').show();
			$('.input-box-weixin').hide();
		}
	});
	function flushImage(pType) {
		if(pType=="aliyPay"){
			$("#qrCodeAliPay").attr("src","${webRoot}/pay/alipay.do?orderid=${bean.number}&money=${bean.money}&title=账号充值");
		}else if(pType=="weixinPay"){
			$("#qrCodeWeiXinPay").attr("src","${webRoot}/pay/weipay.do?orderid=${bean.number}&money=${bean.money}&title=账号充值");
		}
		clearInterval(query);
		query=setInterval("clock('"+pType+"')",3000);
		i=0;
	}
	 $(document).on("click","#_back",function() {
		 $("#confirm-returnBack").modal("show");
     });
     $(document).on("click","._return_confirm_btn",function() {
    	 $.ajax({
		        type: "POST",
		        url: "${webRoot}/balance/cancelOrder",
		        data: {"incomeId":'${bean.id}'},
		        dataType: "json",
		        success: function (data) {
		           console.log("订单取消成功！");
		           if("${incomeId}"!=""){
		        	   window.location.href = "${webRoot}/pay/list.do?incomeId=${incomeId}";
		           }else{
			           window.location.href = "${webRoot}/balance/prepareList";
		           }
		        },error:function(){
		        	 console.log("订单取消失败！");
			         window.location.href = "${webRoot}/balance/prepareList";
		        }
		    });
    	 
     });
</script>
<script type="text/javascript" src="${webRoot}/js/showTime.js"></script>
</html>
