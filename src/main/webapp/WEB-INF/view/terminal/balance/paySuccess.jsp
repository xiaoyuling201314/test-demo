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
			<%-- <div class="zz-title2">
			<span >收银台</span>
			<div class="btn lt-btn pull-right btn" style="position: absolute;right: 5px;top: 7px;"><a href="${webRoot}/terminal/logout.do" class="pull-left" style="width: 102px;color:#fff;">
			<i class="icon iconfont icon-tuichu1"></i>&nbsp;退出</a>
			 <i class="showTime cs-hide" style="font-size:28px;font-weight:bold;right: 113px;top: 27px;"></i>
			</div>
    	</div> --%>
			<div class="zz-table zz-table2 col-md-12 col-sm-12" style="">
				<div class="zz-ok zz-no-margin" style="margin-top: 100px;">
						<div style="display:table; width: 100%;">
							<div style="display:table-cell; font-size: 20px;font-weight: 600;line-height: 40px; ">
							<img src="${webRoot}/img/terminal/dui.png" alt="" style="width: 40px"><span style="margin-left:10px;font-size:28px; font-weight:bold;vertical-align: middle;">充值成功</span>
							</div>
						</div>
						<div style="text-align:left;margin-top:40px;font-size:24px;line-height:40px;padding-left: 400px;">
							<p class="" >交易单号：${payNumber}</p> 
							<div style="">
								<p>充值金额：<i class="text-danger"><fmt:formatNumber type="number" value="${bean.money}" pattern="0.00"/> 元</i></p>
								<p>赠送金额：<i class="text-danger"><fmt:formatNumber type="number" value="${bean.giftMoney}" pattern="0.00"/>元</i></p>
								<p>到账金额：<i class="text-danger"><fmt:formatNumber type="number" value="${bean.money+bean.giftMoney}" pattern="0.00"/>元</i></p>
							</div>
						</div>
						</div>
				<div class="zz-paint-page ">
						<div class="zz-notice" style="line-height: 40px;font-size:20px;">
							
						</div>
						<div style="text-align: center; "> </div>
				</div>
			</div>
			<div class="zz-tb-btns zz-tb-btns2 zz-tb-btns3 col-md-12 col-sm-12" style="margin-top: 100px;">
<%-- 				<a href="${webRoot}/balance/prepareList" type="" class="btn btn-primary" >设置密码</a> --%>
				<c:choose>
					<c:when test="${incomeId!=null }">
						<a href="${webRoot}/pay/list.do?incomeId=${incomeId}" type="" class="btn btn-primary" >返回支付</a>
					</c:when>
					<c:otherwise>
						<a href="${webRoot}/balance/prepareList" type="" class="btn btn-primary" >继续充值</a>
						<a href="${webRoot}/terminal/goHome" type="" class="btn btn-primary" >返回首页</a>
					</c:otherwise>
				</c:choose> 
				
				<%-- <c:choose>
					<c:when test="${userAccount!=null && empty userAccount.payPassword}">
						<a href="javascript:void(0);" data-toggle="modal" data-target="#confirm-setPassword" id="setBtn" class="btn btn-primary" >设置支付密码</a>
					</c:when>
					<c:otherwise>
						<a href="${webRoot}/terminal/goHome" type="" class="btn btn-primary" >返回首页</a> 
					</c:otherwise>
				</c:choose> --%>
			</div>

    </div>

</div>
<%@include file="/WEB-INF/view/terminal/balance/setPassword.jsp" %>
<%@include file="/WEB-INF/view/terminal/tips.jsp" %>
<%@include file="/WEB-INF/view/terminal/keyboard_number.jsp" %>
</body>
 <script type="text/javascript" src="${webRoot}/js/printTicket.js"></script>
<script type="text/javascript">
var timeCount=30;//总时长
var  showCount=20;//剩余多少秒时显示倒计时 
payType="rechargeSuccess";
$(function(){
	if(${empty userAccount.payPassword}){
		 $('#confirm-setPassword').modal("show");
	}else if("${incomeId}"!=""){
		location.href="${webRoot}/pay/list.do?incomeId=${incomeId}";
	}
});
</script>
<script type="text/javascript" src="${webRoot}/js/showTime.js"></script>
</html>
