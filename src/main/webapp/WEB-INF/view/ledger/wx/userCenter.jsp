<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@include file="/WEB-INF/view/ledger/wx/ledgerWxResource.jsp"%>

<c:set var="webRoot" value="<%=basePath%>" />
<c:set var="resourcesUrl" value="<%=resourcesUrl%>" />

<html>
  <head>
  		 <meta charset="utf-8">
        <meta name="viewport" content="initial-scale=1, maximum-scale=1, user-scalable=no">
        <meta name="format-detection" content="telephone=no">
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
	<style type="text/css">
		body, html{width: 100%;height: 100%; margin:0;font-family:"微软雅黑";}
		#l-map{height:300px;width:100%;}
		#r-result{width:100%;}
		section.ui-container{
			min-height:83%;
		}
		.ui-list-action{
			position:relative;
		}
		.ui-list-action .icon{
			position:absolute;
			right:20px;
			top:2px;
			color:#008ad4;
		}
		
	</style>
	<script src="${webRoot}/css/weixin/js/mui.min.js"></script>
<link href="${webRoot}/css/weixin/plugin/picker/css/mui.dtpicker.css" rel="stylesheet" />
<link href="${webRoot}/css/weixin/plugin/picker/css/mui.picker.css" rel="stylesheet" />
<link href="${webRoot}/css/weixin/plugin/picker/css/mui.poppicker.css" rel="stylesheet" />
<link href="${webRoot}/css/weixin/css/mui.indexedlist.css" rel="stylesheet" />
        <title>个人中心</title>
        <%-- <link rel="stylesheet" href="${webRoot}/app/css/bootstrap.css">
        <link rel="stylesheet" href="${webRoot}/app/css/index.css"> --%>
  </head>
 <body ontouchstart="" style="padding-bottom:10px;">
<%@include file="/WEB-INF/view/ledger/wx/comtitle.jsp"%>
<form action="" id="saveform" >
<input type="hidden" name="regId" id="regId" value="${ledgerUser.regId}">
<input type="hidden" name="regName" id="regName" value="${ledgerUser.regName}">
								<input type="hidden" name="type" value="${ledgerUser.type}">
								<input type="hidden" name="id" id="ledgerUserId" value="${ledgerUser.id}">
    <section class="ui-container" style="padding:10px 10px 0;">
            <div class="ui-second-info clearfix">
              <ul class="ui-bg-white">
                   <li class="ui-border-b clearfix">
                  <div class="ui-list-info ui-col ui-col-1">
              市场名称：
                  </div>
                  <div class="ui-list-action ui-list-info ui-col ui-col-3">${ledgerUser.regName}</div>
                </li>
                <c:if test="${ledgerUser.opeShopCode!=null }">
                <li class="ui-border-b clearfix">
                  <div class="ui-list-info ui-col ui-col-1">
                   档口编号：
                  </div>
                  <div class="ui-list-action ui-list-info ui-col ui-col-3">${ledgerUser.opeShopCode}</div>
                </li></c:if>
                 <c:if test="${ledgerUser.opeShopName!=null }">
                  <li class="ui-border-b clearfix">
                  <div class="ui-list-info ui-col ui-col-1">
               档口名称：
                  </div>
                  <div class="ui-list-action ui-list-info ui-col ui-col-3">${ledgerUser.opeShopName}</div>
                </li></c:if>
                 <c:if test="${ledgerUser.managementType!=null }">
                  <li class="ui-border-b clearfix">
                  <div class="ui-list-info ui-col ui-col-1">
              市场类型：
                  </div>
                  <div class="ui-list-action ui-list-info ui-col ui-col-3">
                  <c:if test="${ledgerUser.managementType==1}">农贸市场</c:if>
                  <c:if test="${ledgerUser.managementType==0}">批发市场</c:if>
                 </div>
                </li></c:if>
                	<c:if test="${!empty ledgerUser.opeName}">
	                	<li class="ui-border-b clearfix">
	                  <div class="ui-list-info ui-col ui-col-1">
	                   经营户：
	                  </div>
	                  <div class="ui-list-action ui-list-info ui-col ui-col-3">${ledgerUser.opeName}</div>
	              	  </li>
	              	  </c:if>
                <li class="ui-border-b clearfix">
                  <div class="ui-list-info ui-col ui-col-1">
                   账号：
                  </div>
                  <div class="ui-list-action ui-list-info ui-col ui-col-3"><input readonly="readonly"  name="username" id="username"  type="text" value="${ledgerUser.username}" style="margin: 0;  padding: 0px;  border: 0;  "></div>
                </li>
                <li class="ui-border-b clearfix " id="password">
                  <div class="ui-list-info ui-col ui-col-1">
                   密码：
                  </div>
                  <div class="ui-list-action ui-list-info ui-col ui-col-3">
                  <input   type="password"    maxlength="12" readonly="readonly"  type="text"  value="123456" style="margin: 0;  padding: 0px;  border: 0;  ">  
                  <i class="icon iconfont icon-xiugai" onclick="showModel();"></i>
                   </div>
                </li>
                <div style="display:none;" class="pass-model">
                <li class="ui-border-b clearfix">
                  <div class="ui-list-info ui-col ui-col-1">
                   旧密码：
                  </div>
                  <div class="ui-list-action ui-list-info ui-col ui-col-3"><input   type="password" id="pwd"    maxlength="12"  type="text"  value="" style="margin: 0;  padding: 0px;  border: 0;  ">   </div>
                </li>
                <li class="ui-border-b clearfix">
                  <div class="ui-list-info ui-col ui-col-1">
                  新密码：
                  </div>
                  <div class="ui-list-action ui-list-info ui-col ui-col-3"><input name="pwd"   type="password"  id="pwd1"   maxlength="12"  type="text"  value="" style="margin: 0;  padding: 0px;  border: 0;  ">   </div>
                </li>
                <li class="ui-border-b clearfix">
                  <div class="ui-list-info ui-col ui-col-1">
                  确认密码：
                  </div>
                  <div class="ui-list-action ui-list-info ui-col ui-col-3"><input   type="password"   id="pwd2"  maxlength="12"  type="text"  value="" style="margin: 0;  padding: 0px;  border: 0;  ">   </div>
                </li>
			</div>
               <%--  <li class="ui-border-b clearfix">
                  <div class="ui-list-info ui-col ui-col-1">
                    所属检测点：
                  </div>
                  <div class="ui-list-action ui-list-info ui-col ui-col-3">${user.pname}</div>
                </li> --%>
              </ul>
            </div>
            <div class="pass-model" style="display:none;margin-top:35px;text-align: center;color: #fff;">
            
            <a class="btn btn-primary "  onclick="closeModel();" style="background: #d40000; color:#ffffff; border:1px solid #d40000;margin-right:5%; width:82px;  border-radius: 2px;">取消</a>
            <a class="btn btn-primary"   onclick="save();" style="background: #008ad4; color:#ffffff;    border-radius: 2px;">保存信息</a>
            
            </div>
        </section>
    </form>


    <!--   <div class="login-out col-md-10 col-md-offset-1 col-xs-10 col-xs-offset-1 btn btn-danger">
        退出登录
      </div> -->
   <div class="ui-footer" style="bottom: 0;width: 100%;height:60px; line-height:30px; text-align: center;padding:0;">
    <div><i style="font-size:12px;">广东中检达元检测技术有限公司提供技术支持</i></div>
  </div>
    </body>
    	<script src="${webRoot}/css/weixin/plugin/picker/js/mui.picker.js"></script>
	<script src="${webRoot}/css/weixin/plugin/picker/js/mui.poppicker.js"></script>
	<script src="${webRoot}/css/weixin/plugin/picker/js/mui.dtpicker.js"></script>
    <script type="text/javascript">
    function save() {
		var username=$("#username").val().trim();
		if(username==null ||username==""){
			mui.alert('请输入账号!', '消息', '确定', null, 'div');
			return ;
		}
		/* if(username.length<6){
			mui.alert('请输入至少6位账号!', '消息', '确定', null, 'div');
			return ;
		} */
		var pwd=$("#pwd").val().trim();
		console.log(pwd.length);
		if(pwd==null ||pwd==""){
			mui.alert('请输入旧密码!', '消息', '确定', null, 'div');
			return ;
		}
		var pwd1=$("#pwd1").val().trim();
		if(pwd1.length<6){
			mui.alert('请输入至少6位密码!!', '消息', '确定', null, 'div');
			return ;
		}
		var pwd2=$("#pwd2").val().trim();
		if(pwd1!=pwd2){
			mui.alert('确认密码和新密码不一致!', '消息', '确定', null, 'div');
			return ;
		}
		var old='${ledgerUser.pwd}';
		if(old!=pwd){
			mui.alert('旧密码不正确,请重新输入!', '消息', '确定', null, 'div');
			return ;
		}
		var old='${ledgerUser.pwd}';
		if(old==pwd1){
			mui.alert('新密码和旧密码一致，无需修改!', '消息', '确定', null, 'div');
			return ;
		}
	$.ajax({
		type : "POST",
		url : '${webRoot}' + "/ledger/wx/save.do",
		data : $('#saveform').serialize(),
		dataType : "json",
		success : function(data) {
			if (data.success) {
				mui.alert('保存成功!', '消息', '确定', null, 'div');
				window.location.reload();
			} else {
				mui.alert(data.msg, '消息', '确定', null, 'div');
			}
		}
	})
	
}

$(function(){
    
      pushHistory();  
  	    window.addEventListener("popstate", function(e) {  
  		//self.location="${webRoot}/ledger/wx/main.do";	 
  		history.back();
  	}, false);  
  	    function pushHistory() {  
  	        var state = {  
  	            title: "title",  
  	            url: "#"  
  	        };  
  	        window.history.pushState(state, "title", "#");  
  	    } 

  })
  
  //打开隐藏
  function showModel() {
	$(".pass-model").show();
	$("#password").hide();
	}

//关闭隐藏
  function closeModel() {
		$(".pass-model").hide();
		$("#password").show();
}
	$('input').blur(function() {

		$(window).scrollTop(0);

	})	
    </script>
</html>
