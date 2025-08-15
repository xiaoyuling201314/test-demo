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
            <%--     <div class="zz-pay2 col-md-12">
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
                </div> --%>
                 <%@include file="/WEB-INF/view/terminal/income/payMethod.jsp"%>
            </div>
        </div>
        <div class="zz-tb-btns col-md-12 " style="margin-top:156px ">	<a href="javascirpt:;" data-toggle="modal" data-target="#confirm-delete3" class="btn btn-danger">取消</a>

        </div>
    </div>
    <%@include file="/WEB-INF/view/terminal/balance/setPassword.jsp" %>
</div>
</div>
<%@include file="/WEB-INF/view/terminal/income/payConfirm.jsp"%>
<%@include file="/WEB-INF/view/terminal/tips.jsp"%>
</body>
<%@include file="/WEB-INF/view/terminal/keyboard_number.jsp"%> 
 <script src="${webRoot}/js/num-alignment.js"></script>
<script src="${webRoot}/plug-in/iCheck/icheck.js?v=1.0.2"></script>
<script src="${webRoot}/plug-in/iCheck/js/custom.min.js?v=1.0.2"></script> 
<script type="text/javascript">
	 var timeCount=90;//总时长
	 var showCount=60;//剩余多少时间显示倒计时
	 var payType="printMoney";
	 $(".cancelMsg").html("取消支付");
	//取消支付
		function cancelOrder(incomeId ,number){
			$.ajax({
		        type: "POST",
		        url: "${webRoot}/pay/cancelOrder",
		        data: {"incomeId":incomeId,"orderid":number},
		        dataType: "json",
		        success: function (data) {
		            if (data && data.success ) {
		            	isPrint=0;
	                    //关闭付款页面
	                    clearInterval(query);
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
