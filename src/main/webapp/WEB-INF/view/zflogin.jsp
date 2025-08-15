<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/common/resource.jsp"%>
<!doctype html>
<html lang="en" class="no-js">
<head>
<meta charset="utf-8" />
<title>登录页面</title>
<!-- <meta name="viewport" content="width=device-width, initial-scale=1.0"> -->
<link rel="stylesheet" href="${webRoot}/css/login/css/style.css" />
<script type='text/javascript' src='${webRoot}/css/login/js/jquery.particleground.min.js'></script>
<script type='text/javascript' src='${webRoot}/css/login/js/demo.js'></script>
<script type="text/javascript" src="${webRoot}/js/jquery.cookie.js"></script>
<style type="text/css">
.form-signin .form-signin-heading, .form-signin .checkbox {
	margin-bottom: 10px;
}

.form-signin img {
	float: right
}

form font {
	height: 20px;
	display: block
}

form font strong {
	display: none;
	height: 20px;
	line-height: 20px;
	color: red;
	font-size: 10px;
	font-family: initial;
}
</style>
<script type="text/javascript">
	$(function() {

		/** 验证码手指状态以及点击刷新 **/
		$("#vimg").mouseover(function() {
			$(this).css("cursor", "pointer");
		}).click(function() {
			$("#vimg").attr("src", "verify?random=" + Math.random())
		});

		/** 隐藏所有的提示信息 */
		$("strong[id$='_tip']").hide();

		/** 为表单绑定提交事件onsubmit */
		$("#loginBtn").click(function() {
			/** 隐藏所有的提示信息 */
			$("strong[id$='_tip']").hide();
			/** 定义是否提交表单的标识符 */
			var isSubmit = true;
			/** 表单输入校验 */
			var userName = $("#userName");
			var pwd = $("#pwd");
			var code = $("#code");
			if ($.trim(userName.val()) == "") {
				$("#userName_tip").html("* 用户名不能空！").show();
				$(this).text("登录");
				isSubmit = false;
				userName.focus();// 调用文本框获取焦点方法
			} else if (!/^\w{5,20}$/.test($.trim(userName.val()))) {
				$("#userName_tip").html("* 请输入5-20位的账号！").show();
				isSubmit = false;
				$(this).text("登录");
				userName.focus();
			} else if ($.trim(pwd.val()) == "") {
				$("#pwd_tip").html("* 密码不能为空！").show();
				isSubmit = false;
				$(this).text("登录");
				pwd.focus();
			} else if (!/^\S{6,18}$/.test($.trim(pwd.val()))) {
				$("#pwd_tip").html("* 请输入6-18位密码！").show();
				isSubmit = false;
				pwd.focus();
			} else if ($.trim(code.val()) == "") {
				$("#code_tip").html("* 验证码不能为空！").show();
				isSubmit = false;
				$(this).text("登录");
				code.focus();
			} else if (!/^[a-zA-Z0-9]{4}$/.test($.trim(code.val()))) {
				$("#code_tip").html("* 请输入4位验证码！").show();
				isSubmit = false;
				$(this).text("登录");
				code.focus();
			}
			/** 判断表单是否通过校验 */
			if (isSubmit) {
				var params = $("form[class=form-signin]").serialize();
				var url = "${webRoot}/loginAjax.do";
				$.post(url, params, function(data) {
					if (data.status == 0) {
						rememberPassword();
						window.location = "${webRoot}/system/goHome.do";
					} else {
						//alert(data.tip);
						$("#confirm-warnning .tips").text(data.tip);
		    			$("#confirm-warnning").modal('toggle');
		    			
						//刷新验证码
						$("#code").val("");
						flushCode();
						$("#loginBtn").text("登录");
					}
				}, "json");
			}
		});

		/** 回车键提交交表单 */
		$(document).keydown(function(event) {
			if (event.keyCode === 13) {
				if(document.getElementById("confirm-warnning").style.display=='block'){
					$("#confirm-warnning").modal('hide');
					code.focus();
				}else{
					$("#loginBtn").trigger("click");
				}
			}
		});

		if (top.location != self.location) {
			top.location = self.location;
		}

		if ($.cookie("userName") != undefined && $.cookie("userName") != 'null') {
			$('#reme').prop("checked", true);
			$("#userName").val($.cookie("userName"));
			$("#pwd").val($.cookie("password"));
		}

	});

	$(document).on("change", "#reme", function() {
		rememberPassword();
	});
	//检测是否记住密码
	function rememberPassword() {
		if ($('#reme').is(':checked')) {
			//记住账号密码
			$.cookie("userName", $("#userName").val());
			$.cookie("password", $("#pwd").val());
		} else {
			//清空cookie
			$.cookie("userName", null);
			$.cookie("password", null);
		}
	}

	function flushCode() {
		var _url = "${webRoot}/ImageServlet?time=" + new Date().getTime();
		$(".vc-pic").attr('src', _url);
	}
</script>
</head>

<body>
	<div class="login-content">
		<div class="login-logo">
			<img src="${webRoot}/img/zbsystem/fst-logo.png" height="60px" alt="" />
			<span>达元食品安全监督执法软件</span>
		</div>
		<div class="login-box">
			<div id="" class="login-body">
				<div class="intro">
					<div class="login-intro">
					
					</div>
					<div class="form">
						<h2>用户登录</h2>
						<div class="bottom-lines"></div>
						<div class="userform">
							<form action="" class="form-signin">
								<div class="username">
									<input type="text" name="userName" id="userName" class="input-block-level" placeholder="请输入账号" /> <font>
										<strong id="userName_tip" class="normal">* 用户名不能为空！</strong>
									</font>
								</div>
								<div class="password">
									<input type="password" name="password" id="pwd" class="input-block-level" placeholder="请输入密码" /> <font>
										<strong id="pwd_tip" class="normal">* 密码不能为空！</strong>
									</font>
								</div>
								<div class="idcode">
									<input type="text" name="vcode" id="code" class="input-medium" placeholder="请输入验证码" maxlength="4"/> <span
										onclick="flushCode()"> <img class="vc-pic fr-box" width="65" height="23"
										src="${webRoot}/ImageServlet?time=new Date().getTime()" title="点击刷新验证码">
									</span> <font> <strong id="code_tip" class="normal">* 验证码不能为空！</strong>
									</font>
								</div>
								<div class="remenber">
									<input id="reme" type="checkbox" class="cs-fl" /><label for="reme" class="pull-left"><span>记住密码</span></label>
								</div>

								<div>
									<button class="login button" type="button" id="loginBtn">登录</button>
								</div>
							</form>
						</div>
					</div>
					
					
					
					
				</div>
			</div>
		</div>
	</div>
	
	<%@include file="/WEB-INF/view/common/confirm.jsp"%>

	<div class="ins">
		<p>© 2018 广州达元信息科技有限公司 All Rights Reserved.</p>
	</div>
</body>
</html>


