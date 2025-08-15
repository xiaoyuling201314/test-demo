<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/terminal/resource.jsp"%>
<!doctype html>
<html lang="en" class="no-js">
<head>
<meta charset="utf-8" />
<title>个人信息</title>
<meta name="description" content="">
<meta name="keywords" content="">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
</head>
<style type="text/css">
     .base-info p {
   		  width: 120px;
    	  padding-right: 9px;
    } 
    .readStyle{
    	    border: 1px solid #999;
    		background: #f0f5ff;
    		border-radius: 4px;
    }
</style> 
<body>
	<div class="zz-content">
    	<div></div>
		<div class="zz-title" style="height: 100px;"> <img src="${webRoot}/img/terminal/title.png" alt="">
		<i class="showTime cs-hide" style="font-size: 28px;font-weight: bold;"></i>
		</div>
		 <!-- <div class="zz-li"><img src="img/li.png" alt=""></div> -->
		 
		<form action="" id="saveForm" autocomplete="off">
		<input type="hidden" name="id" value="${userInfo.id}"/>
		<input type="hidden" name="checked" value="${userInfo.checked}"/>
		<input type="hidden" name="inspectionId" value="${unitInfo.id}"/>
		<div class="zz-login zz-login2 clearfix">
			<h2>个人信息</h2>
			 <div class="base-info clearfix">
			  <p class="pull-left"><!-- <i class="cs-mred">*</i> -->公司名称</p>
			  <input class="pull-left readStyle" type="text" name="companyName" id="companyName" readonly="readonly" value="${unitInfo.companyName }">
			</div> 
			<div class="base-info clearfix">
			  <p class="pull-left"><!-- <i class="cs-mred">*</i> -->社会信用代码</p>
			  <input class="pull-left readStyle" type="text" name="creditCode" id="creditCode" style="text-transform: uppercase" value="${unitInfo.creditCode }"/>
			 </div>
			 <div class="base-info clearfix">
			  <p class="pull-left"><!-- <i class="cs-mred">*</i> -->法定代表人</p>
			  <input class="pull-left readStyle" type="text" name="creditCode" id="creditCode" value="${unitInfo.legalPerson }"/>
			 </div>
			 <div class="base-info clearfix">
			  <p class="pull-left"><!-- <i class="cs-mred">*</i>inputData -->姓&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;名</p>
			  <input class="pull-left readStyle" type="text" name="realName" id="realName" placeholder="" value="${userInfo.realName }">
			 </div>
			 <div class="base-info clearfix">
			  <p class="pull-left"><!-- <i class="cs-mred">*</i> inputData-->登录账号</p>
			  <input class="pull-left readStyle" type="text" name="userName" id="userName" placeholder="请输入账号" value=${userInfo.userName }>
			 </div>
			<div class="base-info clearfix">
			  <p class="pull-left"><!-- <i class="cs-mred">*</i> inputData-->登录密码</p>
			  <input class="pull-left readStyle" type="password" name="password" id="password" placeholder="请输入6位以上密码" value=${userInfo.password }>
			 </div>
			<div class="base-info clearfix">
			  <p class="pull-left"><!-- <i class="cs-mred">*</i> -->手机号码</p>
			  <input class="pull-left readStyle" type="text" name="phone" id="phone" placeholder="请输入手机号码" value=${userInfo.phone }>
			 </div>
			<div class="login-btn2">
				<a href="${webRoot}/terminal/goHome" class="btn btn-danger" type="button" id="loginBtn">返回</a>
<!-- 				<a href="javascript:;" class="btn btn-primary" type="button" id="submitBtn">提交</a> -->
			</div>
		</div>
		</form>
		<div class="zz-bottom-copy">© 2020 广东中检达元检测技术有限公司 All Rights Reserved.</div>
		<div class="zz-left"><img src="${webRoot}/img/terminal/left.png" alt=""></div>
		<div class="zz-right2"><img src="${webRoot}/img/${weChatImg}" alt="" style="width:160px;"></div>
    </div>
    <%@include file="/WEB-INF/view/common/confirm.jsp"%>
    <%@include file="/WEB-INF/view/terminal/keyboard_input.jsp"%>
    <%@include file="/WEB-INF/view/terminal/tips.jsp"%>
</body>
 <script type="text/javascript" src="${webRoot}/js/showTime.js"></script>
<script type="text/javascript">
	$(function(){
		var regPassword=/^\w{6,}$/;//验证密码：6位以上数字+英文+下拉线
		var regPhone=/^[1][3,4,5,7,8][0-9]{9}$/;//验证手机号码
		$("#submitBtn").on("click",function(){
			var userName=$("#userName").val();
			var password=$("#password").val();
			var phone=$("#phone").val();
			var realName=$("#realName").val();
			if(realName==""){
				tips("请输入姓名！");
			}else if(userName==""){
				tips("请输入账号！");
			}else if(password==""){
        		tips("请输入密码！");
			}else if(!regPassword.test(password)){
        		tips("请输入6位以上密码，可包含数字，字母和下划线！");
			}else if(phone==""){
        		tips("请输入手机号码！");
			}else if (!regPhone.test(phone)){
        		tips("请输入正确的手机号码！");
			}else{
				$("#userName").attr("name","userName");
				$("#password").attr("name","password");
				$("#phone").attr("name","phone");
				$("#realName").attr("name","realName");
				var formData = new FormData($('#saveForm')[0]);
				$.ajax({
			        type: "POST",
			        url: "${webRoot}/inspUnitUser/save.do",
			        data: formData,
	  		        contentType: false, //必须false才会避开jQuery对 formdata 的默认处理 XMLHttpRequest会对 formdata 进行正确的处理 
	  		        processData: false, //必须false才会自动加上正确的Content-Type
	  		        dataType: "json",
			        success: function(data){
			        	if(data && data.success){
			        		window.location = "${webRoot}/terminal/goHome";
			        	}else{
			        		$("#waringMsg>span").html(data.msg);
			        		$("#confirm-warnning").modal('toggle');
			        	}
					},error: function(e){
						console.log(e);
					}
			    });
			}
		});
		
	});
</script>
</html>