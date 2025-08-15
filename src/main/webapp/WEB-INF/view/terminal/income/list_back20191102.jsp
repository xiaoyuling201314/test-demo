<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/WEB-INF/view/terminal/resource.jsp"%>

<html>
<head>
    <title>快检服务云平台</title>
</head>
<body>
 <div class="zz-content">
    <div class="zz-cont-box" style="top:10px;">
        <div class="zz-title2">	<span>收银台</span>
		<i class="showTime cs-hide" style="top: 35px;font-size:28px;font-weight:bold;color:#4373e0;border-color:#4373e0;"></i>
        </div>
        <div class="zz-table zz-center-pay">
            <div class="zz-code col-md-12 ">
                <div class="zz-list col-md-12 ">
                    <div class="col-md-12 ">订单编号：${sampleBean.samplingNo }     <i class="text-default">订单提交成功，请尽快付款！</i>

                        <div class="zz-pay-price">应付金额：<i class="text-danger">${bean.money}  元</i>

                        </div>
                    </div>
                    <div class="col-md-12 ">费用类型：
						<c:choose>
							<c:when test="${bean.transactionType==0}">检测费用</c:when>
							<c:when test="${bean.transactionType==1}">打印费</c:when>
							<c:when test="${bean.transactionType==2}">余额充值</c:when>
						</c:choose>
					</div>
                </div>
                <div class="zz-list col-md-12 ">
                    <div class="col-md-12 ">委托单位： ${sampleBean.regName }</div>
                    <div class="col-md-12 ">送检单位： ${sampleBean.inspectionName }</div>
                    <div class="col-md-12 ">订单信息： ${sampleBean.total }个检测项目</div>
                </div>
                <div class="zz-pay2 col-md-12">
                    <div class="select-pay">
                    <c:if test="${weiPay=='0' }">
                        <label for="weixinPay" class="">
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
	                        <label for="aliyPay" class=""  >
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
                    <div class="col-md-12" style="margin-top: -1px;">
                        <div class="zz-2dcode zz-2dcode2">
                        	<c:choose>
                        		<c:when test="${aliPay=='0' && weiPay=='1'}">
                        			 <img src="${webRoot}/pay/alipay.do?orderid=${bean.number}&money=${bean.money}&samplingNo=${sampleBean.samplingNo}" id="qrCode" style="width: 200px;" alt="">
		                            <p style="font-size: 18px;">
		                                <img src="${webRoot}/img/terminal/tb.png" alt="" id="pType" style="width: 22px;margin-right:5px">金额：<i class="text-danger">${bean.money}元</i>
		                            </p>
                        		</c:when>
                        		<c:otherwise>
                        			 <img src="${webRoot}/pay/weipay.do?orderid=${bean.number}&money=${bean.money}&samplingNo=${sampleBean.samplingNo}" id="qrCode" style="width: 200px;" alt="">
		                            <p style="font-size: 18px;">
		                                <img src="${webRoot}/img/terminal/wx.png" alt="" id="pType" style="width: 22px;margin-right:5px">金额：<i class="text-danger">${bean.money}元</i>
		                            </p>
                        		</c:otherwise>
                        	</c:choose>
                           
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
        <div class="zz-tb-btns col-md-12 " style="margin-top:176px ">	<a href="javascirpt:;" data-toggle="modal" data-target="#confirm-delete3" class="btn btn-danger">取消</a>

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
					确认要取消该订单吗？
				</div>	
			</div>
			<div class="modal-footer">
				<a href="javascript:" class="btn btn-danger" onclick="cancelOrder(${bean.id},${bean.samplingId },'${bean.number}')">取消订单</a>
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
<%@include file="/WEB-INF/view/terminal/tips.jsp"%>
 <script src="${webRoot}/js/num-alignment.js"></script>
<script src="${webRoot}/plug-in/iCheck/icheck.js?v=1.0.2"></script>
<script src="${webRoot}/plug-in/iCheck/js/custom.min.js?v=1.0.2"></script> 
<script type="text/javascript">
	 var i=0;
	 var query;
	 var timeCount=120;//总时长
	 var showCount=90;//实时时长
	 query=setInterval("clock('weixinPay')",3000);
	function clock(pType)
	{
		i++;
		var urlStr="";
		if(pType=="weixinPay"){
			urlStr="${webRoot}/pay/weipayQuery.do";
		}else{
			urlStr="${webRoot}/pay/alipayQuery.do";
		}
		 $.ajax({
             type: "POST",
             url: urlStr,
             data: {"id":"${bean.id}","orderid":"${bean.number}"},
             dataType: "json",
             success: function (data) {
                 if (data && data.success && (data.obj.status==1 || data.obj.trade_state=="SUCCESS" || data.attributes.trade_state=="TRADE_SUCCESS")) {
                	 clearInterval(query);
	                  location.href="${webRoot}/pay/paySuccess.do?incomeId=${bean.id}";
                 }else if(data.attributes.trade_state=="TRADE_CLOSED" || data.attributes.trade_state=="PAYERROR"){//交易关闭
                	 $("#confirm-delete3").modal('toggle');
                 } else {
                    
                 }
             }
         });
	}  
	
$(function(){
		/* $(".payTitle").html("支付成功，不予退款"); */
// 		$("input").on("ifClicked",function(event){
		$("#weixinPay,#aliyPay").on("click",function(event){
			var pType=$(this).attr("id");
			if(pType=="aliyPay"){
// 				$(".payTitle").html("支付宝扫描");
				$("#qrCode").attr("src","${webRoot}/pay/alipay.do?orderid=${bean.number}&money=${bean.money}&samplingNo=${sampleBean.samplingNo}");
				$("#pType").attr("src","${webRoot}/img/terminal/tb.png");
			}else{
				//$(".payTitle").html("微信扫描");
				$("#qrCode").attr("src","${webRoot}/pay/weipay.do?orderid=${bean.number}&money=${bean.money}&samplingNo=${sampleBean.samplingNo}");
				$("#pType").attr("src","${webRoot}/img/terminal/wx.png");
			}
			clearInterval(query);
			query=setInterval("clock('"+pType+"')",3000);
			i=0;
		});
	});
	function cancelOrder(incomeId,samplingId ,number){
		$.ajax({
	        type: "POST",
	        url: "${webRoot}/pay/cancelOrder.do",
	        data: {"incomeId":incomeId,"samplingId":samplingId,"orderid":number},
	        dataType: "json",
	        success: function (data) {
	            if (data && data.success ) {
	                 location.href="${webRoot}/terminal/goHome.do";
	            }else if(data.obj!=null){//付款成功，进入支付成功页面
	            	$("#confirm-delete3").modal("toggle");
	            	 tips("订单支付成功，无法取消!");	
	            	 setTimeout(function(){
	            		 //location.href="${webRoot}/pay/paySuccess.do?incomeId="+incomeId;
	            	 },3000);
	            }else {
	               $("#confirm-delete4").modal("toggle");
	            }
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
		            	location.href="${webRoot}/terminal/logout.do";
	               }else {
		               $("#confirm-delete4").modal("toggle");
		            }
		        }
		    });
	}
</script>
<script type="text/javascript" src="${webRoot}/js/showTime.js"></script>
</html>
