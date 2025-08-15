<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<style>
	.dec-font{
		position:relative;
	}
	.dec-line{
		position:absolute;
		left:0;
		top: -2px;
	  	color: #999;
	}
	.dec1{
		left:31px;
	}
	.dec2{
		left:64px;
	}
	.dec3{
		left:97px;
	}
	.dec4{
		left:130px;
	}
	.dec5{
		left:163px;
	}
</style>
   <div class="zz-pay2 col-md-12" style="height:360px;">
     <div class="select-pay">
     <c:set var="payTotalMoney" >
     	<fmt:formatNumber value="${bean.money}" pattern="0.00"/>
     </c:set>
     <c:if test="${balance=='0' }">
         <label for="balancePay" class="show-codes active balancePay">
             <div class="demo-list">
                 <ul>
                     <li>
                         <input tabindex="1" type="radio" name="pay" id="balancePay">
                     </li>
                 </ul>
             </div>
            	 <img src="${webRoot}/img/terminal/ye.png" alt="" style="width: 22px;margin-right:5px"/>余额支付
           </label>
      </c:if>
     <c:if test="${weiPay=='0' }">
         <label for="weixinPay" class="show-codes weixinPay">
             <div class="demo-list">
                 <ul>
                     <li>
                         <input tabindex="1" type="radio" name="pay" id="weixinPay">
                     </li>
                 </ul>
             </div>
             <img src="${webRoot}/img/terminal/wx.png" alt="" style="width: 22px;margin-right:5px">微信支付</label>
      </c:if>
      <c:if test="${aliPay=='0' }">
          <label for="aliyPay" class="show-codes aliyPay">
              <div class="demo-list">
                  <ul>
                      <li> 
                     <input tabindex="1" type="radio" name="pay" id="aliyPay" />
                      </li>
                  </ul>
              </div>
             <img src="${webRoot}/img/terminal/tb.png" alt="" style="width: 22px;margin-right:5px">支付宝支付</label>
         </c:if>
     </div>
     <div class="code-box col-md-12" style=" display: none">
			<div class="zz-2dcode zz-2dcode2">
			<div class="pay-password" style="height: 220px;">
				<p style="margin-bottom: 20px;float: left">账户余额：<i class="text-warning">
				<c:choose>
				<c:when test="${account!=null}">
					${account.totalMoney}
				</c:when>
				<c:otherwise>
					0
				</c:otherwise>
				</c:choose>
				元</i></p>
			<p style="float: right">支付：<i class="text-danger">${payTotalMoney}元</i></p>
			<div class="clearfix showInputDiv" style="clear:both;">
			<span class="dec-font">
			<input type="password" class="pay-input inputData" id="inputPassword"  autocomplete="off" maxlength="6"  style="text-align:left;letter-spacing: 27px;text-indent: 14px;padding:0;"> 
			<span class="dec-line dec1">|</span>	
			<span class="dec-line dec2">|</span>	
			<span class="dec-line dec3">|</span>	
			<span class="dec-line dec4">|</span>	
			<span class="dec-line dec5">|</span>	
			</span>
			<p style="color:#666">请输入支付密码</p>
				</div>
				<div class="pay-btn showInputDiv"> 
				<!-- <buttont  class="btn btn-primary" id="confirmPay">确定支付</buttont> -->
				</div>
				 
				<div class="setPassword showInputPassword" style="clear:both;padding:30px;font-size: 20px;">
					请先设置
					<a  href="javascript:void(0);" data-toggle="modal" data-target="#confirm-setPassword">支付密码</a>
				</div>
				
				<div class="setPassword showRecharge" style="clear:both;padding:30px;font-size: 20px;">
					余额不足，请先
					<a  href="${webRoot}/balance/prepareList.do?incomeId=${bean.id}">充值</a>
				</div>
				
			</div>
			</div>
		</div>
     <div class="input-box-weixin col-md-12" style=" display: none">
         <div class="zz-2dcode zz-2dcode2">
               	<img src="${webRoot}/pay/weipay.do?orderid=${bean.number}&money=${payTotalMoney}&samplingNo=${sampleBean.samplingNo}" id="qrCodeWeiXinPay" onerror="onerror=null;src='${webRoot}/img/terminal/refresh.png'" onclick="flushImage('weixinPay')" style="width: 200px;" alt="">
               <p style="font-size: 18px;">
                   <img src="${webRoot}/img/terminal/wx.png" alt="" id="pType" style="width: 22px;margin-right:5px">金额：<i class="text-danger">${payTotalMoney}元</i>
               </p>
             <div class="zz-pay-all col-md-12 payTitle" style="color:#dc8703;font-size:16px;margin-top: 20px;"><i class="icon iconfont icon-bell" style="color:#dc8703;margin:0 4px;"></i>支付成功，不予退款</div>
         </div>
     </div>
     <div class="input-box-alipay col-md-12" style=" display: none">
         <div class="zz-2dcode zz-2dcode2">
             <img src="${webRoot}/pay/alipay.do?orderid=${bean.number}&money=${payTotalMoney}&samplingNo=${sampleBean.samplingNo}" id="qrCodeAliPay"  onerror="onerror=null;src='${webRoot}/img/terminal/refresh.png'" onclick="flushImage('aliyPay')"  style="width: 200px;" alt="">
               <p style="font-size: 18px;">
                   <img src="${webRoot}/img/terminal/tb.png" alt="" id="pType" style="width: 22px;margin-right:5px">金额：<i class="text-danger">${payTotalMoney}元</i>
               </p>
             <div class="zz-pay-all col-md-12 payTitle" style="color:#dc8703;font-size:16px;margin-top: 20px;"><i class="icon iconfont icon-bell" style="color:#dc8703;margin:0 4px;"></i>支付成功，不予退款</div>
         </div>
     </div>
 
<%--  <%@include file="/WEB-INF/view/terminal/balance/setPassword.jsp" %> --%>
 </div>
 <script type="text/javascript">
	 var i=0;
	 var query;
	 var flag=0;
	 var weixinPay=false;
	 var aliPay=false;
	 var isPrint=0;
	 var isQuery=true;
	function clock(pType)
	{
		i++;
		 var urlStr="";
		if(i>=10){
			weixinPay=true;
			aliPay=true;
		}else if(pType=="weixinPay"){
			weixinPay=true;
		}else if(pType=="aliyPay"){
			aliPay=true;
		}else{
			weixinPay=true;
			aliPay=true;
		}
		if(isQuery){
			isQuery=false;
			$.ajax({
	             type: "POST",
	             url: "${webRoot}/pay/payQuery.do",
	             data: {"id":"${sampleBean.id}","orderid":"${bean.number}","weixinPay":weixinPay,"aliPay":aliPay},
	             dataType: "json",
	             success: function (data) {
	                 if (data && data.success && (data.obj.status==1 || data.obj.indexOf('"weixin_trade_state":"SUCCESS"')>-1 || data.obj.indexOf('"alipay_trade_state":"TRADE_SUCCESS"')>-1)) {
	                	 if(payType=="checkMoney"){
		                	 clearInterval(query);
			                  location.href="${webRoot}/pay/paySuccess.do?incomeId=${bean.id}";
			            	}else if(payType=="printMoney" && isPrint==0){
			            		isPrint=1;
			            		//付款成功，关闭页面并打印
			                     parent.closeMbIframe();
			                     timeInterval=setInterval(function(){//重新开启定时器
			                 		showDownTime();
			                 		},1000);
			                     parent.preview();
			                     $("#myContent1" , parent.document).show();
			            	}
	                 }else {
	                    
	                 }
	                	 isQuery=true;
	             },error:function(){
	            	 isQuery=true;
	            	 console.log("支付状态查询异常！");
	             }
	         });
		}else{
			clock(pType);
		}
	}  
	
$(function(){
		
		if("${account}"=="" || parseFloat("${account.totalMoney}")<${bean.money} ){//余额不足，引导用户充值
			$(".showInputDiv").addClass("cs-hide");
			$(".showInputPassword").addClass("cs-hide");
		}else if('${account.payPassword}'==''){////判断用户是否设置支付密码，没有的话先设置支付密码
			$(".showInputDiv").addClass("cs-hide");
			$(".showRecharge").addClass("cs-hide");
		}else if('${account.payPassword}'!=''){
			$(".showInputPassword").addClass("cs-hide");
			$(".showRecharge").addClass("cs-hide");
		} 
		 //限制只能输入6位数密码
	  /*   $("#inputPassword").on("keyup",function(){
			 	var password=$("#inputPassword").val(); 
				if(password.length>6){
					$("#inputPassword").val(password.substr(0,6));
					return ;
				}
		}); */
		if('${balance}'=='0' ){//余额支付   && "${account}"!="" && parseFloat("${account.totalMoney}")>=${bean.money} 
			$('.code-box').show();
			$('.input-box-alipay,.input-box-weixin').hide();
			$("#balancePay").attr("checked","checked");
			flag=1;
			$(".select-pay").find(".balance").addClass('active').siblings().removeClass('active');
			query=setInterval("clock('balancePay')",3000);
		}else if('${weiPay}'=='0'){//支持微信支付
			$('.input-box-weixin').show();
			$('.input-box-alipay,.code-box').hide();
			$(".balancePay").attr("style","opacity: 0.7;");
			$("#balancePay").attr("disabled","disabled");
			$("#weixinPay").attr("checked","checked");
			$(".select-pay").find(".weixinPay").addClass('active').siblings().removeClass('active');
			 query=setInterval("clock('weixinPay')",3000);
		}else if('${aliPay}'=='0'){//支持支付宝支付
			$('.input-box-alipay').show();
			$('.input-box-weixin,.code-box').hide();
			$(".balancePay").attr("style","opacity: 0.7;");
			$("#balancePay").attr("disabled","disabled");
			$("#aliyPay").attr("checked","checked");
			$(".select-pay").find(".aliyPay").addClass('active').siblings().removeClass('active');
			 query=setInterval("clock('aliyPay')",3000);
		} 
		var isSubmitbalance=false;
		$("#inputPassword").unbind('keyup');
		$("#inputPassword").on("keyup",function(){
			var password=$("#inputPassword").val(); 
			if(password.length>6){
				$("#inputPassword").val(password.substr(0,6));
			}
			console.log("length:"+$("#inputPassword").val());
			if($("#inputPassword").val().length==6 && isSubmitbalance==false){
				 $('.softkeys').hide();
				var password=$(".pay-input").val();
				$.ajax({
			        type: "POST",
			        url: "${webRoot}/balance/balancePay.do",
			        data: {"incomeId":"${bean.id}","payPassword":password},
			        dataType: "json",
			        success: function (data) {
			            if (data && data.success ) {
			            	//clearInterval(query);
			            	clock("balancePay");
			            }else {
			               tips(data.msg);
			               isSubmitbalance=false;
			               $(".pay-input").val("");
			            }
			        }
			    });
			}
		});
		/*$(document).on("change","#inputPassword",function(){
			//alert("123");
			if($("#inputPassword").val().length==6 && isSubmitbalance==false){
				 $('.softkeys').hide();
				var password=$(".pay-input").val();
				$.ajax({
			        type: "POST",
			        url: "${webRoot}/balance/balancePay.do",
			        data: {"incomeId":"${bean.id}","payPassword":password},
			        dataType: "json",
			        success: function (data) {
			            if (data && data.success ) {
			            	clock("balancePay");
			            }else {
			               tips(data.msg);
			               isSubmitbalance=false;
			               $(".pay-input").val("");
			            }
			        }
			    });
			}
		});*/
		//输入密码确认支付
	/* 	$("#confirmPay").click(function(){
			var password=$(".pay-input").val();
			if(password=="" || password.length!=6){
				tips("请输入6位数密码！");
			}else{
				$("#confirmPay").attr("disabled","disabled");
				$.ajax({
			        type: "POST",
			        url: "${webRoot}/balance/balancePay.do",
			        data: {"incomeId":"${bean.id}","payPassword":password},
			        dataType: "json",
			        success: function (data) {
			            if (data && data.success ) {
			            	clock("balancePay");
			            }else {
			               tips(data.msg);
			               $("#confirmPay").removeAttr("disabled");
			            }
			        }
			    });
			}
		}); */
	});
	$('.select-pay label').click(function(){
		
		var pType=$(this).find("input").attr("id");
		if(pType=="balancePay"){
			if(flag==1){
				$(this).addClass('active').siblings().removeClass('active');
				$('.code-box').show();
				$('.input-box-alipay,.input-box-weixin').hide();
			}
		}else if(pType=="weixinPay"){
			$(this).addClass('active').siblings().removeClass('active');
			$('.input-box-weixin').show();
			$('.input-box-alipay,.code-box').hide();
		}else if(pType=="aliyPay"){
			$(this).addClass('active').siblings().removeClass('active');
			$('.input-box-alipay').show();
			$('.input-box-weixin,.code-box').hide();
		}
	});
	function flushImage(pType) {
		var money="${payTotalMoney}";
		if(pType=="aliyPay"){
			$("#qrCodeAliPay").attr("src","${webRoot}/pay/alipay.do?orderid=${bean.number}&money="+money+"&samplingNo=${sampleBean.samplingNo}&time="+new Date().getTime());
		}else if(pType=="weixinPay"){
			$("#qrCodeWeiXinPay").attr("src","${webRoot}/pay/weipay.do?orderid=${bean.number}&money="+money+"&samplingNo=${sampleBean.samplingNo}&time="+new Date().getTime());
		}
		clearInterval(query);
		query=setInterval("clock('"+pType+"')",3000);
		i=0;
	}
</script>