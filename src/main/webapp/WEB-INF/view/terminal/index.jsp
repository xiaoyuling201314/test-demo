<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/terminal/resource.jsp"%>
<!doctype html>
<html lang="en" class="no-js">
<head>
<meta charset="utf-8" />
<title>自助终端</title>
<meta name="description" content="">
<meta name="keywords" content="">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">

</head>

<body>
	 <div class="zz-content">
    	<div></div>
		<div class="zz-title"><img src="${webRoot}/img/terminal/title.png" alt=""></div>
		 <div class="zz-li"><img src="${webRoot}/img/terminal/li.png" alt=""></div>
		<div class="zz-btns">
			<%-- <div class="zz-btns1"><a href="${webRoot}/order/visitorlist"><img src="${webRoot}/img/terminal/b5.png" alt=""><p>游客模式</p></a></div>  --%>
			<div class="zz-btns2"><a href="${webRoot}/terminal/toLogin"><img src="${webRoot}/img/terminal/b4.png" alt=""><p>账号登录</p></a></div>
			<div class="zz-btns2"><a href="${webRoot}/reportPrint/printNoLogin"><img src="${webRoot}/img/terminal/b2.png" alt=""><p>打印报告</p></a></div>
		</div>
		<div class="zz-bottom-copy">© 2020 广东中检达元检测技术有限公司 All Rights Reserved.</div>
		<div class="zz-left"><img src="${webRoot}/img/terminal/left.png" alt="" ></div>
		<div class="zz-right2"><img src="${webRoot}/img/${weChatImg}" style="width: 160px;" alt=""></div>
    </div>
</body>
<script type="text/javascript" src="${webRoot}/js/selectSearch.js"></script>
<script type="text/javascript">
var webRoot="${webRoot}";
$(function(){
	//进入index页面后台静默加载所有样品信息和来源信息
	queryAllData();
	openwebsocket();
});
</script>
</html>


