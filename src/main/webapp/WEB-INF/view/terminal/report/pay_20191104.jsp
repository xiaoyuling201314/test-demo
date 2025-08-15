<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/WEB-INF/view/terminal/resource.jsp"%>

<html>
<head>
    <title>快检服务云平台</title>
</head>
<body style="background: rgba(0,0,0,0)">
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
                    <div class="col-md-12 ">费用类型：打印费
					</div>
                </div>
                <div class="zz-pay2 col-md-12">
                    <div class="select-pay">
                        <label for="weixinPay" class="">
                            <div class="demo-list">
                                <ul>
                                    <li>
                                        <input tabindex="1" type="radio" name="pay" id="weixinPay" checked="checked" >
                                    </li>
                                </ul>
                            </div>
                            <img src="${webRoot}/img/terminal/wx.png" alt="" style="width: 22px;margin-right:5px">微信支付</label>
                        <label for="aliyPay" class=""  >
                            <div class="demo-list">
                                <ul>
                                    <li>
                                        <input tabindex="1" type="radio" name="pay" id="aliyPay" >
                                    </li>
                                </ul>
                            </div>
                            <img src="${webRoot}/img/terminal/tb.png" alt="" style="width: 22px;margin-right:5px">支付宝支付</label>
                    </div>
                    <div class="col-md-12" style="margin-top: -1px;">
                        <div class="zz-2dcode zz-2dcode2">
                            <img src="${webRoot}/pay/weipay.do?orderid=${bean.number}&money=${bean.money}&samplingNo=${sampleBean.samplingNo}" id="qrCode" style="width: 200px;" alt="">
                            <p>
                                <img src="${webRoot}/img/terminal/wx.png" alt="" id="pType" style="width: 22px;margin-right:5px">金额：<i class="text-danger">${bean.money}元</i>
                            </p>
                            <div class="zz-pay-all col-md-12" style="color:#dc8703;font-size:16px;margin-top: 5px;">支付成功，不予退款</div>
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
        <div class="zz-tb-btns col-md-12 " style="margin-top:156px ">	<a href="javascirpt:;" data-toggle="modal" data-target="#confirm-delete3" class="btn btn-danger">取消</a>

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
					确认要取消吗？
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
 <script src="${webRoot}/js/num-alignment.js"></script>
<script src="${webRoot}/plug-in/iCheck/icheck.js?v=1.0.2"></script>
<script src="${webRoot}/plug-in/iCheck/js/custom.min.js?v=1.0.2"></script> 
<script type="text/javascript">
	 var i=0;
	 var query;
	 var timeCount=90;//总时长
	 var showCount=60;//剩余多少时间显示倒计时
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
	 query=setInterval("clock('weixinPay')",3000);
	 //测试时使用，自动跳转打印页面
	   /* setTimeout(function(){
		 parent.closeMbIframe();
		 timeInterval=setInterval(function(){//重新开启定时器
      		showDownTime();
      		},1000);
         parent.preview();
          $("#myContent1" , parent.document).show();
	 },3000);   */
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
                 if (data && data.success && (data.obj.trade_state=="SUCCESS" || data.attributes.trade_state=="TRADE_SUCCESS")) {
                	 clearInterval(query);
                     //付款成功，关闭页面并打印
                     parent.closeMbIframe();
                     timeInterval=setInterval(function(){//重新开启定时器
                 		showDownTime();
                 		},1000);
                     parent.preview();
                     $("#myContent1" , parent.document).show();
                 }else if(data.attributes.trade_state=="TRADE_CLOSED" || data.attributes.trade_state=="PAYERROR"){//交易管理
                	 $("#confirm-delete3").modal('toggle');
                	 $(".printBtn",window.parent.document).removeAttr("disabled");
                 } else {
                    
                 }
             }
         });
	}  
	
$(function(){
		$("#weixinPay,#aliyPay").on("click",function(event){
			var pType=$(this).attr("id");
			if(pType=="aliyPay"){
				$("#qrCode").attr("src","${webRoot}/pay/alipay.do?orderid=${bean.number}&money=${bean.money}&samplingNo=${sampleBean.samplingNo}");
				$("#pType").attr("src","${webRoot}/img/terminal/tb.png");
			}else{
				$("#qrCode").attr("src","${webRoot}/pay/weipay.do?orderid=${bean.number}&money=${bean.money}&samplingNo=${sampleBean.samplingNo}");
				$("#pType").attr("src","${webRoot}/img/terminal/wx.png");
			}
			query=setInterval("clock('"+pType+"')",3000);
			i=0;
		});
	});

	//取消支付
	function cancelOrder(incomeId ,number){
		$.ajax({
	        type: "POST",
	        url: "${webRoot}/pay/cancelOrder",
	        data: {"incomeId":incomeId,"orderid":number},
	        dataType: "json",
	        success: function (data) {
	            if (data && data.success ) {
                    //关闭付款页面
                    $("#myContent1" , parent.document).show();
                    parent.closeMbIframe();
                    $(".printBtn",window.parent.document).removeAttr("disabled");
                }else {
	               $("#confirm-delete4").modal("toggle");
	            }
	        }
	    });
	}
</script>
 <script type="text/javascript" src="${webRoot}/js/showTime.js"></script>
</html>
