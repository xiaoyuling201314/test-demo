<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" --%>
<%-- <%@include file="/WEB-INF/view/common/resource.jsp"%> --%>
<%@include file="/WEB-INF/view/ledger/wx/ledgerWxResource.jsp"%><% 
String serverName=request.getServerName()+":"+request.getServerPort();
%>
<c:set var="wxUrl" value="<%=serverName%>" />
<c:set var="webRoot" value="<%=basePath%>" />
<!DOCTYPE html>
<html>
  <head>
        <meta name="viewport" content="initial-scale=1, maximum-scale=1, user-scalable=no">
        <meta name="format-detection" content="telephone=no">
        <title>用户登录</title>
        <script src="${webRoot}/css/weixin/js/mui.min.js"></script>
		<link href="${webRoot}/css/weixin/css/mui.min.css" rel="stylesheet" />
		<link href="${webRoot}/css/weixin/js/picker/css/mui.dtpicker.css" rel="stylesheet" />
		<link href="${webRoot}/css/weixin/js/picker/css/mui.picker.css" rel="stylesheet" />
		<link href="${webRoot}/css/weixin/js/picker/css/mui.poppicker.css" rel="stylesheet" />
		<link href="${webRoot}/css/weixin/css/mui.indexedlist.css" rel="stylesheet" />
        <%-- <link rel="stylesheet" href="${webRoot}/app/css/bootstrap.css">
        <link rel="stylesheet" href="${webRoot}/app/css/index.css"> --%>
        <link href="${webRoot}/css/weixin/css/self.css" rel="stylesheet" />
          <style media="screen">
    html,
    body {
      height: 100%;
      width: 100%;
      position: relative;
    }
 /* .ui-navbar li.active{
      background:#5cb85c;
    } */
    .title {
	margin: 20px 15px 10px;
	color: #6d6d72;
	font-size: 15px;
	padding-bottom: 51px;
}

.mui-bar {
	-webkit-box-shadow: none;
	box-shadow: none;
}

.mui-list-show {
	line-height: 37px;
	padding: 0 10px;
}

.mui-content-padded {
	border-left: 1px solid #ddd;
	border-right: 1px solid #ddd;
}

.mui-input-row:first-child {
	border-radius: 6px 6px 0 0;
}

.mui-input-row:last-child {
	border-radius: 0 0 6px 6px;
}
.uploader-input-box2 {
    float: left;
    position: relative;
    margin-right: 5px;
    margin-bottom: 5px;
    width: 40px;
    height: 40px;
	border:1px solid #ddd;
	overflow: hidden;
}
.mui-input-row .mui-input-clear~.mui-icon-clear {
    font-size: 20px;
    position: absolute;
    z-index: 1;
    top: 7px;
    right: 30px;
    width: 38px;
    height: 38px;
    text-align: center;
    color: #999;
}
.mui-positon-btn {
    font-size: 20px;
    position: absolute;
    z-index: 1;
    top: 5px;
    right: 5px;
    width: 25px;
    height: 25px;
    text-align: center;
    background: #999;
    border-radius: 50%;
}
.mui-positon-btn .mui-icon{
	color:#fff;
}
.mui-indexed-list-search.mui-search:before {
	margin-top: -15px;
}
.ui-navbar li.active{
	font-size:14px;
}

.user-info{
	padding:20 30px;
}
/* input.user-name-bg{
		padding-left:24px;
	    background:#fff url(${webRoot}/css/login/img/username.png) no-repeat 4px center;
}
input.password-bg{
		padding-left:24px;
	    background:#fff url(${webRoot}/css/login/img/password.png) no-repeat 4px center;
} */
.ui-navbar{
    border-bottom:0;
    border-radius: 6px 6px 0 0;
}
.user-info{
    background:#fff;
    padding:20px;
    border:0;
    border-top:0;
    margin-bottom: 10px;
    padding-bottom: 0px;
    box-radius:6px;
    overflow:hidden;
}
.ui-nav-top{
	background:#f1f1f1;
	border:0;
}
.ui-navbar{
	border:0;
}
input[type=text],input[type=password]{
	padding:10px 15px 10px 22px;
}
section.ui-container{
min-height: 88%;
}
  </style>
  </head>
 <body ontouchstart="">
  <section class="ui-container" style="padding:10px;">
    <h2 style="text-align:center; margin:30px 0 45px 0;">
             <%--  <img src="${webRoot}/img/wx/logo.png" alt="" style="height: 40px"> --%>
              <p class="ui-dz-title">端州区食用农产品溯源系统</p>
            </h2>
    <div style="max-width:80%; text-align:center; margin:0 auto; box-shadow: 0 0 11px #ccc; border-radius:6px;">
      
      <form id="saveform" method="post" >
     
	<div class="ui-navbar clearfix">
              <ul class="clearfix">
                <li class="ui-nav-top col-md-12 col-xs-12">档口账号绑定</li>
              
              </ul>
            </div>
      <div class="user-info ui-tab-list" style="padding-bottom:15px;">
        <input type="hidden" name="openid" id="openid"  value="${openid }">
        <div class="form-group">

          <input type="text" class="form-control user-name-bg" name="username"  value="" id="username" placeholder="请输入账号">
        </div>
        <div class="form-group">
          <input type="password" class="password-bg form-control" name="pwd"    id="pwd" placeholder="请输入密码">
        </div>
        <button type="button" class="btn btn-success" style="width:80%; height:32px;" onclick="save();">绑定</button>
      </div>
      
       
        
         <!-- <button type="button" class="btn btn-danger" style="width:80%;" onclick="detele();">解除绑定</button> -->
      </form>
    </div>

  </section>
  <div class="ui-footer" style="bottom: 0;width: 100%;height:60px; line-height:30px; text-align: center;padding:0;">
    <div><i >© 2018 广东中检达元检测技术有限公司 <br> All Rights Reserved.</i></div>
  </div>
  
  
  
	
</body>
	<script type="text/javascript" src="${webRoot}/js/alert.js"></script>
  <script type="text/javascript">
  var rootPath="${webRoot}/ledger/wx/";
  var wxUrl="${wxUrl}";
  $('.ui-find').click(function() {
    $(this).parents('.ui-bg-white').siblings('.ui-back-info').toggle();
  });
  $('.ui-btn-close').click(function() {
    $(this).parents('.ui-back-info').hide();
  });

  $('.ui-third-info .ui-show-btn').click(function() {
    $(this).siblings('.ui-list-header,.ui-list-body').toggle();
  });
	//绑定
  function save(){
		var  openid=$("#openid").val();
		if(openid==null||openid==""){
			$.MsgBox.Alert("消息", "获取用户信息失败！");    
			return ;
		}
		var  username=$("#username").val();
		if(username==null||username==""){
			$.MsgBox.Alert("消息", "请输入账号！");    
			return ;
		}
		var  pwd=$("#pwd").val();
		if(pwd==null||pwd==""){
			$.MsgBox.Alert("消息", "请输入密码！");    
			return ;
		}
	  $.ajax({
	        type: "POST",
	        url: rootPath+"tologin.do",
	        data: $("#saveform").serialize(),
	        success: function(data){
	        	if(data && data.success){
	        		 $.MsgBox.Alert("消息", data.msg);
	        		//self.location="${webRoot}/wx/list.do";
	        		//self.location="https://open.weixin.qq.com/connect/oauth2/authorize?appid=wxed86b695b42432e5&redirect_uri=http%3a%2f%2fllg.tunnel.echomod.cn%2fdykjfw2%2fwx%2fsign.do&response_type=code&scope=snsapi_base&state=123#wechat_redirect";
	        		self.location=rootPath+"main.do?openid="+"${openid}";
	        	}else{
	        		/* $("#waringMsg>span").html(data.msg); */
	        		 $.MsgBox.Alert("消息", data.msg);
	        	}
			}
	    });
}

function closeModel() {
	$("#alertModel").hide();
}
$('.mui-action-back').click(function(event) {
	$('.mui-postion').hide()
});
$('.mui-icon-search').click(function(event) {
	$('.mui-postion').show()
});
  

</script>
</html>