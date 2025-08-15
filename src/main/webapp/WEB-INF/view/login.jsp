<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/common/resource.jsp"%>
<%
	//增加随机数，解决 CSRF 漏洞
	String uuid = UUID.randomUUID().toString().replaceAll("-", "");
	request.getSession().setAttribute("randTxt",uuid);
%>
<!doctype html>
<html lang="en" class="no-js">
<head>
<meta charset="utf-8" />
<title>登录页面</title>
<link rel="stylesheet" href="${webRoot}/css/login/css/style.css" />
<script type='text/javascript' src='${webRoot}/css/login/js/jquery.particleground.min.js'></script>
<script type="text/javascript" src="${webRoot}/js/jquery.cookie.js"></script>
<link rel="stylesheet" type="text/css" href="${webRoot}/css/left.css" />
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
div.form{
	padding-top: 20px;
	height:auto;
}
</style>
</head>
<%-- MD5加密 --%>
<script type="text/javascript" src="${webRoot}/plug-in/blueimp-md5/md5.min.js"></script>
<script type="text/javascript">
	$(function() {
		//同一个账号重复登录，被迫下线
		if("${type}"=="1"){
			$("#confirm-warnning .tips").text("您的账号在其他地方登录,被迫退出！如非本人操作，请立即登录修改密码。");
			$("#confirm-warnning").modal('toggle');
		}
		var loginType=getQueryString("LOGIN_TYPE");
		if(loginType==1){
			$("#confirm-warnning .tips").text("token已失效，请重新登录!");
			$("#confirm-warnning").modal('toggle');
		}else if(loginType==2){
			$("#confirm-warnning .tips").text("用户会话失效，请重新登录!");
			$("#confirm-warnning").modal('toggle');
		}else if(loginType==3){
			$("#confirm-warnning .tips").text("此用户无可视化大屏权限,请重新登录！");
			$("#confirm-warnning").modal('toggle');
		}
	    //$("#confirm-warnning1").modal("show");

		/** 验证码手指状态以及点击刷新 **/
		$("#vimg").mouseover(function() {
			$(this).css("cursor", "pointer");
		}).click(function() {
			$("#vimg").attr("src", "verify?random=" + Math.random())
		});

		/*$(".clearStyle").mouseover(function() {
			$(this).css("cursor", "pointer");
		});
		$(".clearStyle").mouseout(function() {
			$(this).find("a").css("color", "transparent");
		});*/
		/** 隐藏所有的提示信息 */
		$("strong[id$='_tip']").hide();

		/** 为表单绑定提交事件onsubmit */
		$("#loginBtn").click(function() {
			/** 隐藏所有的提示信息 */
			$("strong[id$='_tip']").hide();
			/** 定义是否提交表单的标识符 */
			var isSubmit = true;
			isSubmit=enableORdisable(new Date());
			/** 表单输入校验 */
			if ($.trim($("#userName").val()) == "") {
				$("#userName_tip").html("* 用户名不能空！").show();
				$(this).text("登录");
				isSubmit = false;
                $("#userName").focus();// 调用文本框获取焦点方法
			} else if (!/^\w{5,20}$/.test($.trim($("#userName").val()))) {
				$("#userName_tip").html("* 请输入正确账号！").show();
				isSubmit = false;
				$(this).text("登录");
                $("#userName").focus();
			} else if ($.trim($("#pwd").val()) == "") {
				$("#pwd_tip").html("* 密码不能为空！").show();
				isSubmit = false;
				$(this).text("登录");
                $("#pwd").focus();
			} else if ($("#pwd").val().length != 32 && !/^\S{6,16}$/.test($.trim($("#pwd").val()))) {
				$("#pwd_tip").html("* 请输入6-16位密码！").show();
				isSubmit = false;
                $("#pwd").focus();
			} else if ($.trim($("#code").val()) == "") {
				$("#code_tip").html("* 验证码不能为空！").show();
				isSubmit = false;
				$(this).text("登录");
                $("#code").focus();
			} else if (!/^[a-zA-Z0-9]{4}$/.test($.trim($("#code").val()))) {
				$("#code_tip").html("* 请输入4位验证码！").show();
				isSubmit = false;
				$(this).text("登录");
                $("#code").focus();
			}

			if ($.Datatype.pw.test($("#pwd").val())) {
			    $("#spw").val(0);
            } else {
                $("#spw").val(1);
            }

			/** 判断表单是否通过校验 */
			if (isSubmit) {
				if ($("#pwd").val().length != 32) {
					$("input[name='password']").val(md5($("#pwd").val()).toLocaleUpperCase());
				}else if($("#pwd").val().length == 32){
					$("#spw").val(0);
					$("input[name='password']").val($("#pwd").val());
				}
				var params = $("form[class=form-signin]").serialize();
				$.post("${webRoot}/loginAjax.do", params, function(data) {
					if (data.status == 0) {
						localStorage.removeItem("failCount");
						localStorage.removeItem("failTime");
						rememberPassword();
						if(loginType==1 || loginType==2 || loginType==3){
							//自动跳转到对应的可视化大屏页面
							var version=getQueryString("version")!=null ? getQueryString("version") : "";
							window.location = "${webRoot}/visual/page"+version;
						}else{
							window.location = "${webRoot}/system/goHome.do";
						}

					} else if (data.status == 8) {
						localStorage.removeItem("failCount");
						localStorage.removeItem("failTime");
                        $("#confirm-warnning0 .tips").html("<b>${systemName}</b>监测到您的密码为初始密码，必须修改密码后才能继续使用平台！");
                        $("#confirm-warnning0").modal('toggle');

                    }  else if (data.status == 9) {
						localStorage.removeItem("failCount");
						localStorage.removeItem("failTime");
						$("#confirm-warnning0 .tips").html("<b>${systemName}</b>监测到您的密码已过期，请修改密码！");
                        $("#confirm-warnning0").modal('toggle');

                    } else {
						var failCount=localStorage.getItem("failCount")!=null ? parseInt(localStorage.getItem("failCount")) : 0;
						failCount+=1;
						localStorage.setItem("failCount",failCount);
						if(failCount==5){
							localStorage.setItem("failTime",new Date());
							enableORdisable();
						}else if(failCount>=2){
							$("#confirm-warnning .tips").text(data.tip+"当前剩余"+(5-failCount)+"次机会！");
							$("#confirm-warnning").modal('toggle');
						}else{
						$("#confirm-warnning .tips").text(data.tip);
		    			$("#confirm-warnning").modal('toggle');
						}

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
                    $("#code").focus();
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
	//连续5次登录失败，锁定客户端30分钟，判断客户端状态，是否解锁还是提示被锁定状态
	function enableORdisable(time){
		var checkFlag=true;
		var startTime=localStorage.getItem("failTime");
		if(parseInt(localStorage.getItem("failCount"))>=5){//5次登录失败，禁用登录按钮
			var diffMin=DateDifference(startTime,time);
			if(diffMin>=30){//解除锁定
				localStorage.removeItem("failCount");
				localStorage.removeItem("failTime");
			}else if(diffMin<30){
				$("#confirm-warnning .tips").text("连续登录失败5次，请在"+(30-diffMin)+"分钟后再试！");
				$("#confirm-warnning").modal('toggle');
				checkFlag=false;
			}else{
				$("#confirm-warnning .tips").text("连续登录失败5次，请在30分钟后再试！");
				$("#confirm-warnning").modal('toggle');
				checkFlag=false;
			}
		}
		return checkFlag;
	}
	//检测是否记住密码,cookie7天有效期
	function rememberPassword() {
		if ($('#reme').is(':checked')) {
			//记住账号密码
			$.cookie("userName", $("#userName").val(), { expires: 7 });
			//记住明文
			// $.cookie("password", $("#pwd").val(), { expires: 7 });
			//记住密文
			$.cookie("password", $("input[name='password']").val(), { expires: 7 });
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
	function clearCach(){
		if($("#userName").val()!="" && localStorage.getItem("faulCount")=="5"){
			$.ajax({
				url: "${webRoot}/system/user/unlock.do",
				type:"POST",
				data:{"username":$("#userName").val()},
				dataType:"json",
				success:function(data){
					$("#confirm-warnning .tips").text("解锁成功，请重新登录！");
					$("#confirm-warnning").modal('toggle');
				}
			});
		}else{
			$("#confirm-warnning .tips").text("解锁成功，请重新登录！");
			$("#confirm-warnning").modal('toggle');
		}
		localStorage.removeItem("failCount");
		localStorage.removeItem("failTime");
	}

</script>
<body>
	<div class="login-content">
		
		<div class="login-box" style="top: 35%;">
			<div class="login-logo" style="margin-bottom: 20px;width:auto;"> 
<%--				<div class="text-center"><img src="${webRoot}/img/pfsystem/logo.png" height="78px" style="float:none;" /></div>--%>
				<span style="float:none; font-size: 36px;">${systemName}</span>
			</div>
			<div id="" class="login-body">
				<div class="intro">
					<div class="login-intro">

					</div>
					<div class="form" style="border-radius: 4px;">
						<div class="userform">
							<form action="" class="form-signin" autocomplete="off">
                                <input type="hidden" id="spw" name="spw" value="0">
								<%-- 增加随机数，解决 CSRF 漏洞 --%>
								<input type="hidden" name="randSesion" value="<%=request.getSession().getAttribute("randTxt")%>" />
								<div class="username">
									<input type="text" name="userName" id="userName" class="input-block-level" placeholder="请输入账号" autocomplete="off"/> <font>
										<strong id="userName_tip" class="normal">* 用户名不能为空！</strong>
									</font>
								</div>
								<div class="password">
									<input type="hidden" name="password">
									<input type="password" id="pwd" class="input-block-level" placeholder="请输入密码" autocomplete="off" />
									<font>
										<strong id="pwd_tip" class="normal">* 密码不能为空！</strong>
									</font>
								</div>
								<div class="idcode clearfix">
									<input type="text" name="vcode" id="code" class="input-medium" placeholder="请输入验证码" maxlength="4" style="width: 260px;float: left;"/> <span
										onclick="flushCode()"> <img class="vc-pic fr-box" width="65" height="23"
										src="${webRoot}/ImageServlet?time=newDate().getTime()" title="点击刷新验证码">
									</span> <font> <strong id="code_tip" class="normal">* 验证码不能为空！</strong>
									</font>
								</div>
								<div class="remenber" style="display: none;">
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
		<%--隐藏的解除锁定功能，解除浏览器锁定或者账号锁定--%>
		<div class="clearStyle" style="float: right;width: 100px;height: 50px;padding-top:10px;cursor: pointer;"  onclick="clearCach()"></div>
	</div>

	<div class="ins">
		<p style="z-index: 100;">${copyright}</p>
	</div>


	<div class="modal fade intro2" id="confirm-warnning" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog cs-alert-width">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
					<h4 class="modal-title">提示</h4>
				</div>
				<div class="modal-body cs-alert-height cs-dis-tab">
					<div class="cs-text-algin" id="waringMsg">
						<img src="${webRoot}/img/warn.png" width="40px" alt="" />
						<span class="tips">操作失败</span>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-success btn-ok" data-dismiss="modal">关闭</button>
				</div>
			</div>
		</div>
	</div>

    <div class="modal fade intro2" id="confirm-warnning0"  role="dialog" aria-labelledby="myModalLabel" aria-hidden="false" data-backdrop="static" data-keyboard="false">
        <div class="modal-dialog cs-alert-width" style="width: 560px">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title">安全提示</h4>
                </div>
                <div class="modal-body cs-alert-height cs-dis-tab" style="height: 200px">
                    <div class="cs-text-algin" id="waringMsg0" style="padding-left: 10px; height: 180px">
                        <img src="${webRoot}/img/warn.png" width="40px" alt="" />
                        <span class="tips" style="width: 420px;padding-left: 15px;padding-left: 10px;font-size: 18px"><b>${systemName}</b>监测到您的密码为初始密码，必须修改密码后才能继续使用平台！</span>
                    </div>
                </div>
                <div class="modal-footer" style="padding: 10px; height: auto">
                    <a class="btn btn-success btn-ok" style="width: 150px;height: 32px;line-height: 22px;" href="${webRoot}/system/user/simplePassword.do">前往修改密码</a>
                </div>
            </div>
        </div>
    </div>
<%--

	<div class="modal fade intro2" id="confirm-warnning1"  role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="static" data-keyboard="false">
		<div class="modal-dialog cs-alert-width" style="width: 560px">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title">平台通知</h4>
				</div>
				<div class="modal-body cs-alert-height cs-dis-tab" style="height: 250px">
					<div class="cs-text-algin" style="padding-left: 10px">
						<img src="${webRoot}/img/warn.png" width="40px" alt="" />
						<span class="tips" style="width: 420px;padding-left: 15px;padding-left: 10px;font-size: 18px">根据甘肃省市场监督管理局的要求，请平台用户立即修改登录密码，且密码必须符合强口令规则：<span style="font-weight: bold">包含字母大写、字母小写、数字、特殊字符的组合，密码长度应不少于8位。</span>在5月18日之后未修改密码的账号将被强制修改密码，新密码请联系上级市场监督管理局用监管账号修改并获取。</span>
					</div>
				</div>
				<div class="modal-footer" style="padding: 10px; height: auto">
					<button type="button" class="btn btn-success btn-ok" style="width: 120px;height: 32px;line-height: 22px;" data-dismiss="modal">确定</button>
				</div>
			</div>
		</div>
	</div>
--%>

</body>
</html>


