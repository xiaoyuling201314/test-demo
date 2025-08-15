<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/terminal/resource.jsp"%>
<!doctype html>
<html lang="en" class="no-js">
<head>
<meta charset="utf-8" />
<title>用户登录</title>
<meta name="description" content="">
<meta name="keywords" content="">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">


<script type="text/javascript" src="${webRoot}/js/jquery.cookie.js"></script>
<style>
	.word-clear{
		position:absolute;
		right:30px;
		height: 40px;
	    line-height: 40px;
	    width: 40px;
	    top: 0px;
	}

</style>
</head>

<body>
	  <div class="zz-content">
    	<div class="softkeys zz-hide" id="hide-b" data-target="input[name='code']"></div>
		<div class="zz-title"><img src="${webRoot}/img/terminal/title.png" alt="">
			 <i class="showTime cs-hide" style="font-size:28px;font-weight:bold;"></i>
		</div>
		 <div class="zz-li"><img src="${webRoot}/img/terminal/li.png" alt=""></div>
		<div class="zz-login clearfix" style="margin-top:10%;">
			<div class="login-tab">
				<!-- <div class="tab-l tab-current">扫码登陆</div>  -->
				<div class="text-center" style="width: 100%">账户登录</div>
			</div>
			<!-- <div class="zz-wx-login zz-hide">
				<p>微信扫一扫</p>
				
				<img src="img/code.png" alt="" style="width: 180px;"></div> -->
			<div class="userform">
				<form action="" class="form-signin" id="saveForm">
					<div class="username">
						<p class="icon iconfont icon-username text-primary login-pos" style="font-size: 18px;top: -2px;"></p><!-- name="userName" -->
						<input type="text"  id="userName" class="input-block-level inputData" value="" placeholder="请输入手机号码" autocomplete="off" oninput="inpChange()"> <font>
						</font>
						<span class="icon iconfont icon-close text-primary word-clear cs-hide" style="font-size: 16px;"></span>
					</div>
					<div class="password">
						<p class="icon iconfont icon-icon2 text-primary login-pos"></p><!-- name="password" -->
						<input type="password"  id="password" class="input-block-level inputData" value="" placeholder="请输入密码" oninput="inpChange2()"> <font>
						</font>
						<span class="icon iconfont icon-close text-primary word-clear cs-hide" style="font-size: 16px;"></span>
					</div>
					
					<div class="login-btn">
						<a href="javascript:void(0);" class="btn btn-primary" type="button" id="loginBtn">登录</a>
					</div>
				</form>
			</div>
			<div class="remenber">
				<label for="reme" class="pull-right"><a href="${webRoot}/terminal/register.do">账号注册</a></label>
				<label for="reme" class="pull-left"><a href="${webRoot}/terminal/index.do"><i class="icon iconfont icon-left"></i>返回首页</a></label>
			</div>
		</div>
		<div class="zz-bottom-copy">© 2020 广东中检达元检测技术有限公司 All Rights Reserved.</div>
		<div class="zz-left"><img src="${webRoot}/img/terminal/left.png" alt=""></div>
		<!-- <div class="zz-right"><img src="img/right.png" alt=""></div> -->
		<div class="zz-right2"><img src="${webRoot}/img/${weChatImg}" alt="" style="width:160px;"></div>
    </div>
    <%@include file="/WEB-INF/view/common/confirm.jsp"%>
    <%@include file="/WEB-INF/view/terminal/keyboard_input.jsp"%>
</body>
<script type="text/javascript" src="${webRoot}/js/showTime.js"></script>
<script type="text/javascript">
	$(function(){
		
		$("#loginBtn").on("click",function(){
// 			$("#userName_tip").attr("style","display:block");
			var userName=$("#userName").val();
			var password=$("#password").val()
			if(userName==""){
				$("#waringMsg>span").html("请输入手机号码！");
        		$("#confirm-warnning").modal('toggle');
			}else if(password==""){
				$("#waringMsg>span").html("请输入密码！");
        		$("#confirm-warnning").modal('toggle');
			}else{
				$.ajax({
			        type: "POST",
			        url: "${webRoot}/terminal/loginAjax.do",
			        data: {"userName":$.trim(userName),"password":$.trim(password)},
			        dataType: "json",
			        success: function(data){
			        	if(data && data.success){
				        	window.location = "${webRoot}/terminal/goHome.do";
			        	}else if (data.msg=="checkPage"){
			        		window.location = "${webRoot}/terminal/checkPage.do";
			        	}else{
			        		$("#waringMsg>span").html(data.msg);
			        		$("#confirm-warnning").modal('toggle');
			        	}
					}
			    });
			}
		});
	  
	})
	
	function inpChange(){
		var inp = $('#userName').val()
		
		if(inp.length>0){
			$('#userName').siblings('.word-clear').show();

		}else{
			$('#userName').siblings('.word-clear').hide();
		}
		
	}
	function inpChange2(){
		var inp2 = $('#password').val()
		
		if(inp2.length>0){
			$('#password').siblings('.word-clear').show();

		}else{
			$('#password').siblings('.word-clear').hide();
		}
		
	}
	inpChange()
	inpChange2()
	$('.word-clear').click(function(){
		$(this).siblings('input').val('')
	})
</script>
</html>


