<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/WEB-INF/view/terminal/resource.jsp"%>

<html>
<head>
    <title>快检服务云平台</title>
</head>
<body>
 <div class="zz-content">
 <div class="zz-title2">
        <img class="pull-left" src="${webRoot}/img/terminal/title2.png" alt=""><span >收银台 </span>
        <div class="btn lt-btn pull-right btn" style="position: absolute;right: 5px;top: 18px;"><a href="${webRoot}/terminal/logout.do" class="pull-left" style="width: 102px;color:#fff;">
			<i class="icon iconfont icon-tuichu1"></i>&nbsp;退出</a>
			 <i class="showTime cs-hide" style="font-size:28px;font-weight:bold;right: 113px;top: 27px;"></i>
		</div>
    </div>
    <div class="zz-cont-box"> 
        <!-- <div class="zz-title2">	<span>收银台</span>
		<i class="showTime cs-hide" style="top: 35px;font-size:28px;font-weight:bold;color:#4373e0;border-color:#4373e0;"></i>
        </div> -->
        <div class="zz-table zz-center-pay">
            <div class="zz-code col-md-12 ">
                <div class="zz-list col-md-12 ">
                    <div class="col-md-12 ">订单编号：${sampleBean.samplingNo }     <i class="text-default">订单提交成功，请尽快付款！</i>

                        <div class="zz-pay-price">应付金额：<i class="text-danger"><fmt:formatNumber value="${bean.money}" pattern="0.00" />元</i>

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
                    <div class="col-md-12 ">
                    <c:choose>
				    	<c:when test="${session_user_terminal.terminalUserType==1}">
				    		委托单位： ${sampleBean.regName}
				    	</c:when>
				    	<c:otherwise>
							委托单位： ${unitList[0].requestName }
				    	</c:otherwise>
				    </c:choose>
                    </div>
                    <div class="col-md-12 ">
                    	<c:choose>
                    		<c:when test="${sampleBean.inspectionId!=null}">
                    		 送检单位： ${sampleBean.inspectionCompany }
                    		</c:when>
                    		<c:otherwise>
                    		送检人员：
                    			<c:choose>
                    				<c:when test=" ${sampleBean.inspectionCompany!=null}">
                    				${sampleBean.inspectionCompany }
                    				</c:when>
                    				<c:otherwise>
                    				${sampleBean.param3 }
                    				</c:otherwise>
                    			</c:choose>
                    		</c:otherwise>
                    	</c:choose>
                  		 
                    
                    </div>
                    <div class="col-md-12 ">订单信息： ${sampleBean.total }个检测项目</div>
                    <c:if test="${fn:length(unitList)>1}">
	                    <div class="col-md-12 ">检测费用： ${bean.checkMoney}元</div>
	                    <div class="col-md-12 ">报告费用： ${bean.reportMoney }元</div>
	                    <div class="col-md-12 ">合计费用：
	                    <fmt:formatNumber value="${bean.money}" pattern="0.00" />元</div>
                    </c:if>
                    <%-- <div class="col-md-12 ">报告单价： ￥${bean.reportMoney/(unitList.size()-1)}</div>
                    <div class="col-md-12 ">报告费用： ￥${bean.reportMoney }</div> --%>
                </div>
 
           <%@include file="/WEB-INF/view/terminal/income/payMethod.jsp"%>
            </div>
        </div>
       
        <div class="zz-tb-btns col-md-12 " style="margin-top:56px ">	<a href="javascirpt:;" data-toggle="modal" data-target="#confirm-delete3" class="btn btn-danger">取消</a>
        </div>
    </div>
     <%@include file="/WEB-INF/view/terminal/balance/setPassword.jsp" %>
	<%-- <%@include file="/WEB-INF/view/terminal/logout.jsp"%> --%>
</div>
</div>
<%@include file="/WEB-INF/view/terminal/income/payConfirm.jsp"%>
</body>
<%@include file="/WEB-INF/view/terminal/tips.jsp"%>
<%@include file="/WEB-INF/view/terminal/keyboard_number.jsp"%> 
 <script src="${webRoot}/js/num-alignment.js"></script>
<script type="text/javascript">
	 var timeCount=120;//总时长
// 	 var showCount=60;//实时时长
	 var payType="checkMoney";
	 /* function logout(){
		 callBackFunction();
		}  */
	 /* var i=0;
	 var query;
	 var flag=0;
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
		if("${balance}"=='0' && "${totalMoney}">"${bean.money}" ){
			$('.code-box').show();
			$('.input-box').hide();
			$("#balancePay").attr("checked","checked");
			flag=1;
		}else if($("${weiPay}"=='0')){//支持微信支付
			$("#balancePay").attr("disabled","disabled");
			$("#weixinPay").attr("checked","checked");
			 query=setInterval("clock('weixinPay')",3000);
		}else if($("${aliyPay}"=='0')){//支持支付宝支付
			$("#balancePay").attr("disabled","disabled");
			$("#aliyPay").attr("checked","checked");
			 query=setInterval("clock('weixinPay')",3000);
		} 
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
		//切换支付方式
		$('.show-codes').click(function(){
			$('.input-box').show();
			$('.code-box').hide();
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
			            	location.href="${webRoot}/pay/paySuccess.do?incomeId=${bean.id}";
			            }else {
			               tips(data.msg);
			               $("#confirmPay").removeAttr("disabled");
			            }
			        }
			    });
			}
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
	} */
</script>
<script type="text/javascript" src="${webRoot}/js/showTime.js"></script>
</html>
