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
			<div class="login-tab">
			    <div class="tab-l tab-current" id="company">企业注册</div> 
			    <div class="tab-r text-center" id="personal">个人注册</div>
		    </div>
			<div class="base-info clearfix">
			  <p class="pull-left" id="creditCodeName"><i class="cs-mred">*</i>社会信用代码</p>
			  <input class="pull-left inputData" type="text" name="creditCode" id="creditCode" placeholder="请扫描或输入社会信用代码" style="text-transform: uppercase"/>
			 </div>
			 <div class="base-info clearfix">
			  <p class="pull-left" id="companyName"><i class="cs-mred">*</i>公司名称</p>
			  <input class="pull-left inputData readStyle" type="text" name="companyName" id="companyName_input" readonly="readonly">
			</div> 
			<!-- <div class="base-info clearfix">
			  <p class="pull-left"><i class="cs-mred">*</i>姓&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;名</p>
			  <input class="pull-left inputData" type="text" name="realName" id="realName" placeholder="请输入姓名">
			 </div> -->
			 <div class="base-info clearfix">
			  <p class="pull-left"><i class="cs-mred">*</i>登录账号</p>
			  <input class="pull-left inputData" type="text" name="userName" id="userName" placeholder="请输入账号">
			 </div>
			<div class="base-info clearfix">
			  <p class="pull-left"><i class="cs-mred">*</i>登录密码</p>
			  <input class="pull-left inputData" type="password" name="password" id="password" placeholder="请输入6位以上密码">
			 </div>
			 <div class="base-info clearfix">
			  <p class="pull-left"><i class="cs-mred">*</i>确认密码</p>
			  <input class="pull-left inputData" type="password" name="rePassword" id="rePassword" placeholder="请确认密码">
			 </div>
			<div class="base-info clearfix">
			  <p class="pull-left"><i class="cs-mred">*</i>手机号码</p>
			  <input class="pull-left inputData" type="text" name="phone" id="phone" placeholder="请输入手机号码">
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
    <%@include file="/WEB-INF/view/terminal/keyboard_input.jsp"%>
</body>
<script type="text/javascript" src="${webRoot}/js/showTime.js"></script>
<%@include file="/WEB-INF/view/terminal/tips.jsp"%>
<script type="text/javascript">
	$(function(){
		openwebsocket();//连接扫描服务器
		var regCreditCode=/^[a-zA-Z0-9]{18}$/;//验证统一社会代码是否合格：数字+字母共18位
		var regPassword=/^\w{6,}$/;//验证密码：6位以上数字+英文+下拉线
		var regPhone=/^[1][3,4,5,7,8][0-9]{9}$/;//验证手机号码
		$("#submitBtn").on("click",function(){
			var creditCode=$("#creditCode").val()
			var userName=$("#userName").val();
// 			var realName=$("#realName").val();
			var password=$("#password").val();
			var phone=$("#phone").val()
			var rePassword=$("#rePassword").val();
			if(creditCode=="" ){
				tips("请输入社会信用代码！");
			} else if(!regCreditCode.test(creditCode.toUpperCase())){
				tips("请输入正确的社会信用代码！");
			}
			/* else if(realName==""){
				$("#waringMsg>span").html("请输入姓名！");
        		$("#confirm-warnning").modal('toggle');
			} */
			else if(userName==""){
				tips("请输入账号信息！");
			}else if(password==""){
				tips("请输入密码信息！");
			}else if(!regPassword.test(password)){
				tips("请输入6位以上密码，可包含数字，字母和下划线！");
			}else if(rePassword==""){
				tips("请输入确认密码！");
			}else if(password!=rePassword){
				tips("确认密码与密码不一致！");
			}else if(phone==""){
				tips("请输入手机号码！");
			}else if (!regPhone.test(phone)){
				tips("请输入正确的手机号码！");
			}else{
				var check=1;//是否审核:0未审核，1已审核 "realName":realName,
				$.ajax({
			        type: "POST",
			        url: "${webRoot}/terminal/registerUser.do",
			        data: {"userName":userName,"inspectionId":$("input[name=inspectionId]").val(),"password":$("#password").val(),"phone":$("#phone").val(),"checked":check},
    		        dataType: "json",
			        success: function(data){
			        	if(data && data.success){
			        		window.location = "${webRoot}/terminal/checkPage?userName="+data.obj.userName+"&pwd="+data.obj.password;
			        	}else{
			        		tips(data.msg);
			        	}
					},error: function(e){
						console.log(e);
					}
			    });
			}
		});
		//根据社会信用代码信息查询送检单位信息
		 $("#creditCode").on("blur",function(){
			 $('.softkeys,.cs-check-down').hide();
			$.ajax({
		        type: "POST",
		        url: "${webRoot}/wx/order/checkCreditCode.do",
		        data: {"creditCode":$("#creditCode").val()},
		        dataType: "json",
		        success: function(data){
		        	if(data && data.success){
		        		if(data.obj!=""){
			        		$("#companyName_input").val(data.obj.companyName);
			        		$("input[name=inspectionId]").val(data.obj.id);
		        		}else{
		        			$("#companyName").val("");
		        			tips("未查询到公司信息，请先到收样窗口进行登记！");
		        		}
		        	}else{
		        		tips(data.msg);
		        	}
				},error: function(e){
					console.log(e);
				}
		    });
		}); 
	});
	
	$('.login-tab div').click(function(){
		$(this).addClass('tab-current').siblings().removeClass('tab-current');
		if($(this).attr("id")=="company"){
			$("#creditCodeName").html('<i class="cs-mred">*</i>社会信用代码');
			$("#companyName").html('<i class="cs-mred">*</i>公司名称');
			$("#creditCode").attr("placeholder","请扫描或输入社会信用代码");
		}else{
			$("#creditCodeName").html('<i class="cs-mred">*</i>身份证号码');
			$("#companyName").html('<i class="cs-mred">*</i>注册人姓名');
			$("#creditCode").attr("placeholder","请扫描或输入身份证号码");
		}
	})
	function websocket_decode(message){
		var sampleRegExp =  new RegExp("^("+"${inspectionUnitPath}"+")([0-9A-Z])*$");
		if(message.indexOf("http://cola.cross.echosite.cn/dykjfw/wx/register/main.do?a=DYKJFW&id=")==-1){
			  tips("请扫描正确的二维码！");
		  }else{
			  var id=message.substring(message.indexOf("id")+3,message.length);
			  $.ajax({
			        type: "POST",
			        url: "${webRoot}/wx/register/checkUnit.do",
			        data: {"id":id},
			        dataType: "json",
			        success: function(data){
			        	if(data && data.success){
			        		$("#creditCode").val(data.obj.creditCode);
			        		$("#companyName_input").val(data.obj.companyName);
			        	}else{
			        		tips(data.msg);
			        	}
					},error: function(e){
						console.log(e);
					}
			    });
		  }
	}
</script>
</html>