<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<div class="login-out" onclick="logout()">
	<p id="timeLabel"></p>
	<i class="showTime cs-hide" style="font-size:28px;font-weight:bold;right: 118px;top: 63px;text-align: center;border:0;width: 42px;height: 42px;line-height: 42px;"></i>
	<div class="btn lt-btn pull-right btn"><a href="${webRoot}/terminal/logout.do"  class="pull-left" style="width: 102px;" >
	<i class="icon iconfont icon-tuichu1"></i>&nbsp;退出</a>
	
	</div>
</div>  
<script type="text/javascript" src="${webRoot}/js/showTime.js"></script>    
 <script type="text/javascript">
 function logout(){
		location.href="${webRoot}/terminal/logout.do";
	} 
</script>