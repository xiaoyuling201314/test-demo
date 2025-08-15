<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/terminal/resource.jsp"%>
<html>
  <head>
    <title>快检服务云平台</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <style type="text/css">
    	.login-user{
    		position:absolute;
    		left:20px;
    		top:0px;
    	}
    	.login-user a,.login-user i,.login-user p{
    		color:#fff;
    	}
    	.no-wrap{
	    	overflow: hidden;
		    text-overflow:ellipsis;
		    white-space: nowrap;
		    width:280px;
    	}
    	.userUnits {
		    padding: 0 20px;
		    font-size: 18px;
		    margin-top: 6px;
		}
		.user-name{
			position:relative;
		}
		.check-user{
			position:absolute;
			right:0;
		}
    </style>
  </head>
 

  <body onload="showTime()">
     <div class="zz-content">
    	<div></div>
		<div class="zz-title"><img src="${webRoot}/img/terminal/title.png" alt=""></div>
		 <div class="zz-li"><img src="${webRoot}/img/terminal/li.png" alt=""></div>
		<c:choose>
		  <c:when test="${session_user_terminal.terminalUserType==1 }"><!-- 供应商用户送检 -->
				<div class="zz-btns">
					<div class="zz-btns1"><a href="${webRoot}/order/terminalOrderMultipurpose"><img src="${webRoot}/img/terminal/b1.png" alt=""><p>自助下单</p></a>
					</div>
					<div class="zz-btns2"><a href="${webRoot}/reportPrint/list.do"><img src="${webRoot}/img/terminal/b2.png" alt=""><p>打印报告</p></a>
					</div>
					<c:if test="${balance==0}">
						<div class="zz-btns2"><a href="${webRoot}/balance/list.do"><img src="${webRoot}/img/terminal/b7.png" alt=""><p>余额管理</p></a>
						</div>
					</c:if>
				</div>
			</c:when>
			<c:otherwise><!-- 普通用户送检 -->
				<div class="zz-btns">
					<div class="zz-btns1"><a href="${webRoot}/order/terminalOrder"><img src="${webRoot}/img/terminal/b1.png" alt=""><p>自助下单</p></a>
					</div>
					<div class="zz-btns2"><a href="${webRoot}/reportPrint/list.do"><img src="${webRoot}/img/terminal/b2.png" alt=""><p>打印报告</p></a>
					</div>
					<c:if test="${balance==0}">
						<div class="zz-btns2"><a href="${webRoot}/balance/list.do"><img src="${webRoot}/img/terminal/b7.png" alt=""><p>余额管理</p></a>
						</div>
					</c:if>
				</div>
			</c:otherwise>
		</c:choose>
		
		<%-- <div class="login-out"><a href="self.html" class="usernames">用户：${session_user_terminal.account}</a>
		<a href="${webRoot}/terminal/logout.do" id="logoutBtn" class="icon iconfont icon-tuichu">退出登录</a></div> --%>
		<div class="login-user">
			<div class="user-inform pull-left">
			<a href="javascript:" class="usernames" id="queryUsers">
				
				
				<p class="user-name clearfix"><i class="pull-left icon iconfont icon-yonghu"></i> 
				
				<span class="pull-left" style="margin-top:4px;">
					<c:choose>
						<c:when test="${session_user_terminal.realName!=''}">
								${session_user_terminal.realName}
						</c:when>
						<c:otherwise>
								${session_user_terminal.phone}
						</c:otherwise>
					</c:choose>
				</span>
				<span class="pull-left icon iconfont icon-chakan" style="margin-top:4px;margin-left: 4px;"></span>
				</p>
				<%-- <c:choose>
					<c:when test="${session_user_terminal.realName!=''}">
							${session_user_terminal.realName}
					</c:when>
					<c:otherwise>
							${session_user_terminal.phone}
					</c:otherwise>
				</c:choose> --%>
				<c:if test="${session_user_terminal.userType==1 }">
				<p style="" class="" title="${session_user_terminal.inspectionName}"><i style="float: left;" class="icon iconfont icon-gongsi"></i><span style="float: left;width: 260px;padding-top: 4px;">${session_user_terminal.inspectionName}</span></p>
				</c:if> 
			</a>
			</div>
		</div>
		 <div class="login-out" onclick="logout()">
			<p id="timeLabel"></p>
			<i class="showTime cs-hide" style="font-size:28px;font-weight:bold;right: 118px;top: 63px;text-align: center;border:0;width: 42px;height: 42px;line-height: 42px;"></i>
			<div class="btn lt-btn pull-right btn"><a href="${webRoot}/terminal/logout.do"  class="pull-left" style="width: 102px;" >
			<i class="icon iconfont icon-tuichu1"></i>&nbsp;退出</a>
			
			</div>
		</div> 
		<div class="zz-bottom-copy">© 2020 广东中检达元检测技术有限公司 All Rights Reserved.</div>
		<div class="zz-left"><img src="${webRoot}/img/terminal/left.png" alt=""></div>
		<!-- <div class="zz-right"><img src="img/right.png" alt=""></div> -->
		<div class="zz-right2"><img src="${webRoot}/img/${weChatImg}" style="width:160px;" alt=""></div>
    </div>
     <%@include file="/WEB-INF/view/common/confirm.jsp"%>
</body>
<script type="text/javascript" src="${webRoot}/js/selectSearch.js"></script>
<script type="text/javascript" src="${webRoot}/js/showTime.js"></script>
<script type="text/javascript">
var webRoot="${webRoot}";
//用户登录后清除上一次的报告列表记录
sessionStorage.removeItem("status");
sessionStorage.removeItem("pageNo");
sessionStorage.removeItem("createDate");
 $(function(){
	setInterval(function(){
		showTime();
	},1000);
});
function showTime(){
	var d=new Date().format("yyyy-MM-dd HH:mm:ss");
	$("#timeLabel").html(d);
} 
$("#queryUsers").click(function(){
	location.href="${webRoot}/inspUnitUser/queryInfo.do";
});
/* function logout(){
	location.href="${webRoot}/terminal/logout.do";
}  */
</script>
</html>