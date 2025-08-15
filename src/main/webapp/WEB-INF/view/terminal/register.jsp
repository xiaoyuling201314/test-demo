<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/terminal/resource.jsp"%>
<!doctype html>
<html lang="en" class="no-js">
<head>
<meta charset="utf-8" />
<title>用户注册</title>
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
		<i class="showTime cs-hide" style="font-size: 28px;"></i>
		</div>
		 <!-- <div class="zz-li"><img src="img/li.png" alt=""></div> -->
		 
		<form action="" id="saveForm" autocomplete="off">
		<input type="hidden" name="inspectionId"/>
		<div class="zz-login zz-login2 clearfix">
		    <h2 class="tab-current">注册</h2>
			 
			<div class="base-info clearfix">
			  <p class="pull-left"><i class="cs-mred">*</i>手机号码</p>
			  <input class="pull-left inputData" data-name="number" type="text" name="phone" id="phone" placeholder="请输入手机号码">
			 </div>
			 <!-- <div class="base-info clearfix">
			  <p class="pull-left"><i class="cs-mred">*</i>登录账号</p>
			  <input class="pull-left inputData" type="text" name="userName" id="userName" placeholder="请输入账号">
			 </div> -->
			<div class="base-info clearfix">
			  <p class="pull-left"><i class="cs-mred">*</i>登录密码</p>
			  <input class="pull-left inputData show-password" type="password" name="password" id="password" placeholder="请输入6位以上密码">
			  <span class="zz-show-btn"><i class="icon iconfont icon-yan"></i> </span>
			 </div>
			 <div class="base-info clearfix">
			  <p class="pull-left"><i class="cs-mred">*</i>确认密码</p>
			  <input class="pull-left inputData show-password" type="password" name="rePassword" id="rePassword" placeholder="请确认密码">
			 </div>
			 <div class="clearfix" style="padding: 10px;">
			 		<p class="pull-left" style="font-size: 16px; line-height: 38px; width: 160px; padding-right: 9px;">用户类型</p>
			  		<div  class="pull-left" style="padding-top: 5px;margin-left: -30px;">
			  			<input id="cs-check-radio2" type="radio" value="1" name="userType"  class="userType" checked="checked" /><label for="cs-check-radio2">企业</label>
                   		<input id="cs-check-radio1" type="radio" value="0" name="userType" class="userType" style="margin-left:20px"  /><label  for="cs-check-radio1">个人</label>
                   </div>
			 </div>
			 
			 <div class="base-info clearfix">
			  <p class="pull-left" id="creditCodeName">社会信用代码</p>
			  <input class="pull-left inputData" type="text" name="identifiedNumber" id="creditCodeCode" placeholder="请扫描或输入社会信用代码" style="text-transform: uppercase" />
			  <button class="zz-clear-btn" type="button" style="margin-top: 10px;margin-left: 10px;"><i class="icon iconfont icon-tiaoxingma"></i></button>
			</div>
			 <div class="base-info clearfix showCompany">
			  <p class="pull-left">公司名称</p>
			  <input class="pull-left readStyle" type="text" name="companyName" id="companyName" >
			</div>
			<div class="login-btn2">
				<a href="${webRoot}/terminal/toLogin.do" class="btn btn-danger" type="button" id="loginBtn">取消</a>
				<a href="javascript:" class="btn btn-primary" type="button" id="submitBtn">提交</a>
			</div>
		</div>
		</form>
		<div class="zz-bottom-copy">© 2020 广东中检达元检测技术有限公司 All Rights Reserved.</div>
		<div class="zz-left"><img src="${webRoot}/img/terminal/left.png" alt=""></div>
		<div class="zz-right2"><img src="${webRoot}/img/${weChatImg}" alt="" style="width:160px;"></div>
    </div>
    <%@include file="/WEB-INF/view/common/confirm.jsp"%>
    <%@include file="/WEB-INF/view/terminal/keyboard_new.jsp"%>
</body>
<script type="text/javascript" src="${webRoot}/js/showTime.js"></script>
<%@include file="/WEB-INF/view/terminal/tips.jsp"%>
<script type="text/javascript">
	var webRoot="${webRoot}";
	var inspectionUnitPath="${inspectionUnitPath}";
	var showCreditCode="";
	var showCompany="";
	var id;
	$('.userType').click(function(){
		if($(this).attr("id")=="cs-check-radio2" || $(this).attr("id")=="cs-check-radio3"){
			$("#creditCodeCode").val(showCreditCode);
			$("#companyName").val(showCompany);
			$("#creditCodeName").html('社会信用代码');
			$(".showCompany").removeClass("cs-hide");
			$(".zz-clear-btn").removeClass("cs-hide");
			$("#creditCodeCode").attr("placeholder","请扫描或输入社会信用代码");
		}else{
			$("#creditCodeCode").val("");
			$("#creditCodeName").html('身份证号码');
			$(".showCompany").addClass("cs-hide");
			$(".zz-clear-btn").addClass("cs-hide");
			$("#creditCodeCode").attr("placeholder","请输入身份证号码");
		}
	})
	
	var i = 0;
		$('.zz-show-btn').click(function(){
			if(i==0){
				$(this).children('i').addClass('icon-biyan').removeClass('icon-yan')
				$('.show-password').prop('type','text');
				i=1;
			}else{
				$(this).children('i').addClass('icon-yan').removeClass('icon-biyan')
				$('.show-password').prop('type','password');
				i=0;
			}
			
			
		});
</script>
<script type="text/javascript" src="${webRoot}/js/register.js"></script>
</html>