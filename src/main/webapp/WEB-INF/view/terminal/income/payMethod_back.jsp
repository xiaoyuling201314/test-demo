<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
   <div class="zz-pay2 col-md-12">
     <div class="select-pay">
     <c:if test="${balance=='0' }">
         <label for="balancePay" class="show-input active balancePay">
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
          <label for="aliyPay" class="show-codes aliyPay"  >
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
			<div class="pay-password">
				<p style="margin-bottom: 20px;float: left">账户余额：<i class="text-warning">${totalMoney}元</i></p>
			<p style="float: right">支付：<i class="text-danger">${bean.money}元</i></p>
			<!-- <p>余额支付密码</p> -->
			<div class="clearfix" style="clear:both">
			<input type="password" class="pay-input inputData" autocomplete="off" > 
			<p style="color:#666">请输入支付密码</p>
				</div>
				<div class="pay-btn"> <buttont  class="btn btn-primary" id="confirmPay">确定支付</buttont></div>
			</div>
			</div>
		</div>
     <div class="input-box col-md-12" style="">
         <div class="zz-2dcode zz-2dcode2">
         	<c:choose>
         		<c:when test="${aliPay=='0' && weiPay=='1'}">
         			 <img src="${webRoot}/pay/alipay.do?orderid=${bean.number}&money=${bean.money}&samplingNo=${sampleBean.samplingNo}" id="qrCode" alt="点击重试" onclick="flushImage(this)"  style="width: 200px;" alt="">
               <p style="font-size: 18px;">
                   <img src="${webRoot}/img/terminal/tb.png" alt="" id="pType" style="width: 22px;margin-right:5px">金额：<i class="text-danger">${bean.money}元</i>
               </p>
         		</c:when>
         		<c:otherwise>
         			 <img src="${webRoot}/pay/weipay.do?orderid=${bean.number}&money=${bean.money}&samplingNo=${sampleBean.samplingNo}" id="qrCode"  alt="点击重试" onclick="flushImage(this)" style="width: 200px;" alt="">
               <p style="font-size: 18px;">
                   <img src="${webRoot}/img/terminal/wx.png" alt="" id="pType" style="width: 22px;margin-right:5px">金额：<i class="text-danger">${bean.money}元</i>
               </p>
         		</c:otherwise>
         	</c:choose>
            
             <div class="zz-pay-all col-md-12 payTitle" style="color:#dc8703;font-size:16px;margin-top: 20px;"><i class="icon iconfont icon-bell" style="color:#dc8703;margin:0 4px;"></i>支付成功，不予退款</div>
         </div>
     </div>
 </div>
 <script type="text/javascript">
	 var i=0;
	 var query;
	 var flag=0;
	 var weixinPay=false;
	 var aliPay=false;
	function clock(pType)
	{
		i++;
		 var urlStr="";
		if(pType=="weixinPay"){
// 			urlStr="${webRoot}/pay/weipayQuery.do";
			weixinPay=true;
		}else if(pType=="aliyPay"){
// 			urlStr="${webRoot}/pay/alipayQuery.do";
			aliPay=true;
		}else{
			weixinPay=true;
			aliPay=true;
		}
		 $.ajax({
             type: "POST",
             url: "${webRoot}/pay/payQuery.do",
             data: {"id":"${sampleBean.id}","orderid":"${bean.number}","weixinPay":weixinPay,"aliPay":aliPay},
             dataType: "json",
             success: function (data) {
                 if (data && data.success && (data.obj.status==1 || data.obj.weixin_trade_state=="SUCCESS" || data.obj.trade_state=="TRADE_SUCCESS")) {
                	 if(payType=="checkMoney"){
	                	 clearInterval(query);
		                  location.href="${webRoot}/pay/paySuccess.do?incomeId=${bean.id}";
		            	}else if(payType=="printMoney"){
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
             }
         });
	}  
	
$(function(){
		if('${balance}'=='0' && '${totalMoney}'>='${bean.money}' ){
			$('.code-box').show();
			$('.input-box').hide();
			$("#balancePay").attr("checked","checked");
			flag=1;
			$(".select-pay").find(".balance").addClass('active').siblings().removeClass('active');
			query=setInterval("clock('balancePay')",3000);
		}else if('${weiPay}'=='0'){//支持微信支付
			$(".show-input").attr("style","opacity: 0.7;");
			$("#balancePay").attr("disabled","disabled");
			$("#weixinPay").attr("checked","checked");
			$(".select-pay").find(".weixinPay").addClass('active').siblings().removeClass('active');
			 query=setInterval("clock('weixinPay')",3000);
		}else if('${aliPay}'=='0'){//支持支付宝支付
			$(".show-input").attr("style","opacity: 0.7;");
			$("#balancePay").attr("disabled","disabled");
			$("#aliyPay").attr("checked","checked");
			$(".select-pay").find(".aliyPay").addClass('active').siblings().removeClass('active');
			 query=setInterval("clock('weixinPay')",3000);
		} 
	/* 	$("#weixinPay,#aliyPay").on("click",function(event){
			var pType=$(this).attr("id");
			if(pType=="aliyPay"){
				$("#qrCode").attr("src","${webRoot}/pay/alipay.do?orderid=${bean.number}&money=${bean.money}&samplingNo=${sampleBean.samplingNo}");
				$("#pType").attr("src","${webRoot}/img/terminal/tb.png");
			}else{
				$("#qrCode").attr("src","${webRoot}/pay/weipay.do?orderid=${bean.number}&money=${bean.money}&samplingNo=${sampleBean.samplingNo}");
				$("#pType").attr("src","${webRoot}/img/terminal/wx.png");
			}
			clearInterval(query);
			query=setInterval("clock('"+pType+"')",3000);
			i=0;
		}); */
		//切换支付方式
		$('.show-codes').click(function(){
			$('.input-box').show();
			$('.code-box').hide();
			query=setInterval("clock('balancePay')",3000);
			i=0;
		})

		$('.show-input').click(function(){
			if(flag==1){
				$('.code-box').show();
				$('.input-box').hide();
			}
			
		});
		//输入密码确认支付
		$("#confirmPay").click(function(){
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
			            	if(payType=="checkMoney"){
				            	location.href="${webRoot}/pay/paySuccess.do?incomeId=${bean.id}";
			            	}else if(payType=="printMoney"){
			            		//付款成功，关闭页面并打印
			                     parent.closeMbIframe();
			                     timeInterval=setInterval(function(){//重新开启定时器
			                 		showDownTime();
			                 		},1000);
			                     parent.preview();
			                     $("#myContent1" , parent.document).show();
			            	}
			            }else {
			               tips(data.msg);
			               $("#confirmPay").removeAttr("disabled");
			            }
			        }
			    });
			}
		});
	});
	$('.select-pay label').click(function(){
		$(this).addClass('active').siblings().removeClass('active')
		var pType=$(this).find("input").attr("id");
		flushImage(pType);
	});
	function flushImage(pType) {
		if(pType=="aliyPay" ||  $(pType).hasClass("flushAlipay")){
			$("#qrCode").attr("src","${webRoot}/pay/alipay.do?orderid=${bean.number}&money=${bean.money}&samplingNo=${sampleBean.samplingNo}");
			$("#qrCode").removeClass("flushWeixinPay");
			$("#qrCode").addClass("flushAlipay");
			$("#pType").attr("src","${webRoot}/img/terminal/tb.png");
		}else if(pType=="weixinPay" || $(pType).hasClass("flushWeixinPay")){
			$("#qrCode").attr("src","${webRoot}/pay/weipay.do?orderid=${bean.number}&money=${bean.money}&samplingNo=${sampleBean.samplingNo}");
			$("#qrCode").removeClass("flushAlipay");
			$("#qrCode").addClass("flushWeixinPay");
			$("#pType").attr("src","${webRoot}/img/terminal/wx.png");
		}
		clearInterval(query);
		query=setInterval("clock('"+pType+"')",3000);
		i=0;
	}
</script>