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
    .zz-table{
    	display:table;
    	width:auto;
    	padding-left:0;
    	min-height:580px;
    }
    .zz-table-cell{
    	display:table-cell;
    	padding-top: 0;
    	vertical-align: top;
    }
    .cell-left .cell-tab{
    	padding: 20px 20px;
    	border-bottom: 1px solid #ccc;
    	font-size:18px;
    	cursor:pointer;
    }
    .cell-left{
        border-right: 1px solid #ccc;
    }
    .cell-right{
    	padding-top:10px;
    	position:relative;
    	width:480px;
    }
    .current{
	    background: #0460f7;
	    color: #fff;
    }
    .login-btn2{
    	position: absolute;
	    bottom: 0px;
	    text-align: center;
	    width: 100%;
	    padding-left: 20px;
    }
    .userLabel{
    	bottom:3px;
    	border-bottom: 1px solid #ccc;
    }
    .userLabel p{
    	width:auto;
    }
    .zz-side-btn{
    	bottom:13px;
    }
    span.zz-labelName{
    	width:120px;
    	white-space:nowrap;
    	overflow:hidden;
    	text-overflow:ellipsis;
    	text-align:left;
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
		<div class="zz-login zz-login2 zz-table clearfix">
			<div class="zz-table-cell cell-left">
				<div class="cell-tab current"> <i class="icon iconfont icon-shengxiao"></i> 个人信息</div>
				<div class="cell-tab"><i class="icon iconfont icon-shengxiao"></i> 修改密码</div>
				<%-- <c:if test="${session_user_terminal.terminalUserType==1}">
					<div class="cell-tab"><i class="icon iconfont icon-shengxiao"></i> 单位分组</div>
				</c:if> --%>
			</div>
		<div class="zz-table-cell cell-right">
			<div class="base-info clearfix">
			  <p class="pull-left"><i class="cs-mred">*</i>手机号码</p>
			  <input class="pull-left inputData" data-name="number" type="text" name="phone" id="phone" placeholder="请输入手机号码" value="${userInfo.phone }">
			 </div>
		<%-- 	 <div class="base-info clearfix">
			  <p class="pull-left"><!-- <i class="cs-mred">*</i> inputData-->登录账号</p>
			  <input class="pull-left" type="text" name="userName" id="userName" placeholder="请输入账号" value="${userInfo.userName }">
			 </div> --%>
			<%-- <div class="base-info clearfix">
			  <p class="pull-left"><!-- <i class="cs-mred">*</i> inputData-->登录密码</p>
			  <input class="pull-left" type="password" name="password" id="password" placeholder="请输入6位以上密码" value="${userInfo.password }">
			 </div> 
			 <div class="base-info clearfix cs-hide">
			  <p class="pull-left"><i class="cs-mred">*</i>确认密码</p>
			  <input class="pull-left inputData" type="password" name="rePassword" id="rePassword" placeholder="请确认密码" value="${userInfo.password }">
			 </div>--%>
			 <c:if test="${userInfo.realName!=null}">
				  <div class="base-info clearfix">
				  <p class="pull-left">姓&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;名</p>
				  <input class="pull-left" type="text" name="realName" id="realName" placeholder="" value="${userInfo.realName }">
				 </div>
			 </c:if>
			<div class="clearfix" style="padding: 10px;">
			 		<p class="pull-left" style="font-size: 16px; line-height: 38px; width: 160px; padding-right: 9px;">用户类型</p>
			  		<div  class="pull-left" style="padding-top: 5px;margin-left: -30px;">
			  			<input id="cs-check-radio2" type="radio" value="1" name="userType"  class="userType"  <c:if test="${userInfo.userType==1}">checked="checked"</c:if>/><label for="cs-check-radio2">企业</label>
                   		<input id="cs-check-radio1" type="radio" value="0" name="userType" class="userType" style="margin-left:20px" <c:if test="${userInfo.userType==0}">checked="checked"</c:if>/><label  for="cs-check-radio1">个人</label>
                   </div>
			 </div>
			
			
			<div class="base-info clearfix">
			  <p class="pull-left" id="creditCodeName">社会信用代码</p>
			  <input class="pull-left inputData" type="text" name="identifiedNumber" id="creditCodeCode" style="text-transform: uppercase" />
			  <button class="zz-clear-btn" type="button" style="margin-top: 10px;margin-left: 10px;"><i class="icon iconfont icon-tiaoxingma"></i></button>
			 </div>
			
			 <div class="base-info clearfix showCompany ">
			  <p class="pull-left">公司名称</p>
			  <input class="pull-left readStyle" type="text" name="companyName" id="companyName" readonly="readonly" value="${unitInfo.companyName }">
			</div> 
			 <div class="base-info clearfix cs-hide showCompany">
			  <p class="pull-left">法定代表人</p>
			  <input class="pull-left readStyle" type="text" name="legalPerson" id="legalPerson" value="${unitInfo.legalPerson }"/>
			 </div>
			 
			 
			<div class="login-btn2">
				<a href="${webRoot}/terminal/goHome.do" class="btn btn-danger" type="button" id="loginBtn">返回</a>
				<a href="javascript:" class="btn btn-primary" type="button" id="submitBtnForInfo">提交</a>

			</div>
				
			</div>
			
			<div class="zz-table-cell cell-right" style="display:none;">
				<div class="base-info clearfix">
				  <p class="pull-left"><!-- <i class="cs-mred">*</i> -->原密码</p>
				  <input class="pull-left show-password inputData" type="password"  value="" name="password" id="oldPpassword" placeholder="请输入原密码" >
				  <span class="zz-show-btn" style="right: 74px;"><i class="icon iconfont icon-yan"></i> </span>
				</div> 
				<div class="base-info clearfix">
				  <p class="pull-left"><!-- <i class="cs-mred">*</i> -->新密码</p>
				  <input class="pull-left show-password inputData" type="password" name="" id="password"  value="" placeholder="请输入新密码"/>
				 </div>
				 <div class="base-info clearfix">
				  <p class="pull-left"><!-- <i class="cs-mred">*</i> -->确认密码</p>
				  <input class="pull-left show-password inputData" type="password" name=""  id="rePassword" value="" placeholder="请输入确认密码"/>
				 </div>
				 <div class="login-btn2">
					<a href="${webRoot}/terminal/goHome.do" class="btn btn-danger" type="button" id="loginBtn">返回</a>
					<a href="javascript:" class="btn btn-primary" type="button" id="submitBtnForpassword">提交</a>
				</div>
			</div>
			
			<!-- 委托单位设置 -->
			<div class="zz-table-cell cell-right" style="display:none;" >
				<div id="requestLabel">
				</div>
				<div class="login-btn2">
					<a href="${webRoot}/terminal/goHome.do" class="btn btn-danger" type="button" id="loginBtn">返回</a>
				</div>
			</div>
		</div>
		</form>
		<div class="zz-bottom-copy">© 2020 广东中检达元检测技术有限公司 All Rights Reserved.</div>
		<div class="zz-left"><img src="${webRoot}/img/terminal/left.png" alt=""></div>
		<div class="zz-right2"><img src="${webRoot}/img/${weChatImg}" alt="" style="width:160px;"></div>
    </div>
    <%@include file="/WEB-INF/view/common/confirm.jsp"%>
    <%@include file="/WEB-INF/view/terminal/keyboard_new.jsp"%>
    <%@include file="/WEB-INF/view/terminal/tips.jsp"%>
    <%@include file="/WEB-INF/view/common/modalBox.jsp"%>
</body>
<script type="text/javascript" src="${webRoot}/js/showTime.js"></script>
<script type="text/javascript">
	var webRoot="${webRoot}";
	var inspectionUnitPath="${inspectionUnitPath}";
	var id="${userInfo.id}";
	var showCreditCode="${unitInfo.creditCode}";
	var identifiedNumber="${userInfo.identifiedNumber}";
	$(function(){
		$("#phone").focus();
	});
	if("${userInfo.userType}"=="0"){
		$("#creditCodeCode").val(identifiedNumber);
		$("#creditCodeName").html('身份证号码');
		$(".showCompany").addClass("cs-hide");
		$(".zz-clear-btn").addClass("cs-hide");
		$("#creditCodeCode").attr("placeholder","请输入身份证号码");
	}else{
		$("#creditCodeCode").val(showCreditCode);
		$("#creditCodeName").html('社会信用代码');
		$(".showCompany").removeClass("cs-hide");
		$(".zz-clear-btn").removeClass("cs-hide");
		$("#creditCodeCode").attr("placeholder","请扫描或输入社会信用代码");
	}
	$('.userType').click(function(){
		if($(this).attr("id")=="cs-check-radio2" || $(this).attr("id")=="cs-check-radio3"){
			$("#creditCodeCode").val(showCreditCode);
			$("#creditCodeName").html('社会信用代码');
			$(".showCompany").removeClass("cs-hide");
			$(".zz-clear-btn").removeClass("cs-hide");
			$("#creditCodeCode").attr("placeholder","请扫描或输入社会信用代码");
		}else{
			$("#creditCodeCode").val("${userInfo.identifiedNumber}");
			$("#creditCodeName").html('身份证号码');
			$(".showCompany").addClass("cs-hide");
			$(".zz-clear-btn").addClass("cs-hide");
			$("#creditCodeCode").attr("placeholder","请输入身份证号码");
		}
	});
	 
	 $('.cell-tab').click(function(){
			var index=$(this).index();
			$(this).addClass('current').siblings().removeClass('current')
			$('.cell-right').eq(index).show().siblings('.cell-right').hide();
			if(index=2){//委托单位设置
				loadLabels();
			}
		});
		function loadLabels(){
			$.ajax({
	            type: "POST",
	            url: webRoot+"/wx/order/getUserLabelForTerminal.do",
	            dataType: "json",
	            success: function(data){
	                if(data && data.success){
	                	$("#requestLabel").empty();
	                	var json=eval(data.obj);
	                	var html="";
	                	$.each(json,function(index,item){
	                		html+='<div class="base-info userLabel clearfix">';
	                		html+='<p class="pull-left"><span class="zz-circle pull-left">'+(index+1)+'</span><span class="zz-labelName pull-left">'+item.labelName+'</span>【'+item.num+'】';
	                		if(item.isdefault==1){
	                			html+='<i class="text-danger">（默认）</i>';
	                		}
	                		html+='</p>';
	                		html+='<div class="zz-side-btn pull-right">';
	                		html+='<a href="javascript:void(0);" onclick="queryLabelById('+item.id+');" class="btn btn-primary"><b>编辑</b></a>';
	                		if(item.isdefault==0){
                				html+='	<a href="javascript:void(0);" onclick="setDefaultLabel('+item.id+');" class="btn btn-default"><b>设为默认</b></a>';
	                		}
            				html+='</div>';
           					html+='</div> ';
	                		
	                	});
	                	$("#requestLabel").append(html);
	                }
	            }
	        });
		}
		//设置为默认标签
		function setDefaultLabel(id){
			$.ajax({
	            type: "POST",
	            url: webRoot+"/inspUnitUser/setDefaultlabel.do",
	            dataType: "json",
	            data:{"id":id},
	            success: function(data){
	                if(data && data.success){
	                	tips("设置成功！");
	                	loadLabels();
	                }
	            }
	        });
		}
		//编辑委托单位信息
		function queryLabelById(id){
			 showMbIframe("${webRoot}/inspUnitUser/queryLabelById?labelId="+id);
			 $(".zz-content").hide(); 
		}
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
		})	
</script>
<script type="text/javascript" src="${webRoot}/js/register.js"></script>
</html>