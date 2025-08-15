<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/common/resource.jsp"%>
<html>
  <head>
    <title>${systemName}</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <style type="text/css">
    iframe{
        width:100%;
        height: 100%;
        position: absolute;
        right:0;
        left: 0;
        top:0;
        bottom: 0;
      }
     .cs-navbar-header{
     	padding: 19px 10px 0 10px;
     }
      .password-rule{
          position: absolute;
          background: #fff;
          top: 5px;
          left: 20px;
          border: 1px solid #ddd;
          padding: 5px;
          line-height: 22px;
          z-index: 1;
      }
        .cs-self-menu span{
            display: block;
            height: 30px;
            line-height: 30px;
        }
        .cs-self-menu span:hover {
            color: #6bbbfe;
            cursor: pointer;
        }
  </style>
  </head>

  <body>
      <!--让浏览器自动填充到这个input-->
      <input type="password" style="display: none;">

      <div id="wrapper" class="blue-style">
	  <!-- <div class="cs-top-line"></div> -->
      <div class="cs-topbar">
        <div class="cs-navbar-header" style="padding: 10px 0px 0 5px; width:auto;">
          <div class="cs-navbar-brand" id="nav-logo" href="#" style="font-weight: bold; color: #fff;font-size: 18px;padding-right:10px;display: flex;align-items: center;flex-direction: row; ">
             <%-- <c:choose>
                  <c:when test="${empty systemLogo}"><img class="pull-left" src="${webRoot}/img/zbsystem/fst-logo.png" style="height:50px; margin-top: 5px;" alt="" /></c:when>
                  <c:otherwise><img class="pull-left" src="${resourcesUrl}${systemLogo}" style="height:50px; margin-top: 5px;" alt="" /></c:otherwise>
              </c:choose>--%>
              <c:if test="${! empty systemLogo}">
                  <img class="pull-left" src="${resourcesUrl}${systemLogo}" style="height:50px; margin-top: 5px;" alt="" />
              </c:if>
          	<div class="top-logo pull-left" style="">${homeSystemName}</div>
          </div>
        </div>

        <div class="cs-collapse cs-navbar-collapse cs-navbar-ex1-collapse cs-re-box">
          <!-- 一级导航栏 开始-->
          <div class="cs-top-nav">
            <ul class="cs-nav-style">
            	<c:forEach items="${menus}" var="menu">
            		<c:if  test="${menu.id!='1'}">
	            		<c:if test="${menu.id=='0'} || ${menu.id=='2'}">
	            			<li class="firstMenu cs-active menusBtn" data-menuid="${menu.id}">
	            		</c:if>
	            		<c:if test="${menu.id!='0'}"> 
		            		<li class="firstMenu menusBtn" data-menuid="${menu.id}">
			        	</c:if>
								<a>
									<i class="${menu.functionIcon}"></i>
									<p>${menu.functionName}</p>
								</a>
							</li>
            		</c:if>
            	</c:forEach>
            </ul>
          </div>
          <!-- 一级导航栏 结束-->

          <!-- 消息提醒 开始-->
          <ul class="cs-nav-right cs-float-r" style="width: 160px; border-left:1px solid #ddd;">
          	<c:forEach items="${menus}" var="menu">
          		<!-- 不合格提醒 开始-->
            	<c:if test="${menu.id=='300'}">
            		<c:forEach items="${menu.subMenu}" var="secMenu">
            			<c:if test="${secMenu.id=='380'}">
                            <li class="cs-buhege cs-messages-dropdown cs-dropdown-user" data-menuid="${menu.id}" style="border-left:0; "
		            				onclick="setIframeUrl('300','380','381','${webRoot}/dataCheck/unqualified/list.do');">
								<span class="cs-mail cs-icon-span cs-btn" data-menuid="${menu.id}">
									<i title="不合格" class="icon iconfont icon-jinggao" style="font-size: 22px;" data-menuid="${menu.id}"></i>
								</span>
								<span class="cs-badge badge cs-red" id="unqualifiedNum"></span>
							</li>
                            <%--
							<li class="cs-buhege cs-messages-dropdown cs-dropdown-user" data-menuid="${menu.id}" style="border-left:0; "
		            				onclick="setIframeUrl('1414','1415','1495','${webRoot}/waring/manage/list.do');">
								<span class="cs-mail cs-icon-span cs-btn" data-menuid="${menu.id}">
									<i title="预警信息" class="icon iconfont icon-jinggao" style="font-size: 22px;" data-menuid="${menu.id}"></i>
								</span>
								<span class="cs-badge badge cs-red" id="unqualifiedNumTotal">0</span>
							</li>
                            --%>
            			</c:if>
            		</c:forEach>
            	</c:if>
          		<!-- 不合格提醒  结束--> 
          		<!-- 消息提醒 开始-->
            	<c:if test="${menu.id=='1'}">
            		<li class="cs-xiaoxi cs-messages-dropdown cs-dropdown-user firstMenu menusBtn"  data-menuid="${menu.id}" style="">
						<span class="cs-mail cs-icon-span cs-btn firstMenu" data-menuid="${menu.id}">
							<i title="新消息" class="icon iconfont icon-youjian firstMenu" data-menuid="${menu.id}"></i>
						</span>
						<span class="cs-badge badge cs-red" id="num"></span>
					</li>
            	</c:if>
          		<!-- 消息提醒  结束--> 
            </c:forEach>
          <!-- 用户信息 开始--> 
            <li class="cs-messages-dropdown cs-dropdown-user" style="width:48px;">
              <a id="cs-user-show" href="#" title="${user.realname}" class="cs-dropdown-toggle cs-user-show" data-toggle="dropdown"><i title="用户" class="icon iconfont icon-yonghu" style="font-size: 23px;" data-menuid="${menu.id}"></i>
              
              </a>
            </li>
          <!-- 用户信息 结束--> 
            <li class="cs-self-menu cs-hide">
              <div class="cs-self-content">
                <span data-toggle="modal" data-target="#myModal-mid3" >个人信息</span>
                <span data-toggle="modal" data-target="#myModal-mid2" >修改密码</span>
                <span class="logout">退出系统</span>
              </div>
            </li>
            <p class="cs-user-name" style="text-align:center;">${user.realname}</p>
          </ul>
          <!-- 消息提醒 结束-->
          
        </div>
      </div>


<!-- 左侧导航栏 开始 -->
	<div id="leftNav"></div>
            	
<!-- 左侧导航栏 结束 -->

	<!-- 内容主体 开始 -->
    <div id="page-wrapper">
		<div class="cs-container">
        	<iframe id="main_iframe" name="main_iframe" frameborder="0"></iframe>
      	</div>
    </div>
    <!-- 内容主体 结束 -->
</div>

<!-- 修改密码-->
<div class="modal fade intro2" id="myModal-mid2" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog cs-mid-width" role="document">
    <div class="modal-content ">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">修改密码</h4>
      </div>
        <form id="userForm" action="${webRoot}/system/user/updatePassword.do">
          <div class="modal-body cs-mid-height">
            <div class="cs-main">
              <div class="cs-wraper">
              <div class="cs-add-new clearfix">
                  <div width="100%" class="cs-add-new">
                      <ul class="cs-ul-form clearfix">
                          <li  class="cs-name col-md-3 col-xs-3" width="20% ">单位：</li>
                          <li class="cs-in-style col-md-5 col-xs-5" width="210px"  style="font-weight:bold;">${user.departName}</li>
                          <li class="col-md-4 col-xs-4 cs-text-nowrap"></li>
                      </ul>
                      <c:if test="${!empty user.pointName}">
                          <ul class="cs-ul-form clearfix">
                              <li class="cs-name col-md-3 col-xs-3" width="20% ">检测室：</li>
                              <li class="cs-in-style col-md-5 col-xs-5" width="210px"  style="font-weight:bold;">${user.pointName}</li>
                              <li class="col-md-4 col-xs-4 cs-text-nowrap"></li>
                          </ul>
                      </c:if>
                      <ul class="cs-ul-form clearfix">
                          <input type="hidden" name="id" value="${user.id}">
                          <li  class="cs-name col-md-3 col-xs-3" width="20% " >账号：</li>
                          <li class="cs-in-style col-md-5 col-xs-5" width="210px"  style="font-weight:bold;">${user.userName}</li>
                          <li class="col-md-4 col-xs-4 cs-text-nowrap"></li>
                      </ul>
                      <ul class="cs-ul-form clearfix">
                          <li class="cs-name col-md-3 col-xs-3" width="20% ">用户名：</li>
                          <li class="cs-in-style col-md-5 col-xs-5" width="210px"  style="font-weight:bold;">${user.realname}</li>
                          <li class="col-md-4 col-xs-4 cs-text-nowrap"></li>
                      </ul>
                      <ul class="cs-ul-form clearfix">
                          <li  class="cs-name col-md-3 col-xs-3">原密码：</li>
                          <li  class="cs-in-style col-md-5 col-xs-5 ui-pos-re">
                              <input type="text"  name="oldPassword"  class="inputxt password" plugin="passwordStrength"  datatype="*" nullmsg="请输入原密码" errormsg="请输入原密码" placeholder="请输入原密码" autocomplete="off" />
                              <span class="iconfont icon-biyan pos-abs show-password"></span>
                          </li>
                          <li class="col-md-4 col-xs-4 cs-text-nowrap"></li>
                      </ul>
                      <ul class="cs-ul-form clearfix">
                          <li  class="cs-name col-md-3 col-xs-3">新密码：</li>
                          <li  class="cs-in-style col-md-5 col-xs-5 ui-pos-re" >
                              <input type="hidden" name="password">
                              <input type="text"  name="mpw1"  class="inputxt password" plugin="passwordStrength"  datatype="pw" nullmsg="请输入8-16位字符密码" errormsg="请输入8-16位符合规则密码" placeholder="请输入新密码" autocomplete="off" />
                              <span class="iconfont icon-biyan pos-abs show-password"></span>
                          </li>
                          <li class="col-md-4 col-xs-4 cs-relative">
                              <i class="iconfont icon-jinggao text-primary show-rule"></i>
                              <div class="password-rule cs-hide"><i class="cs-mred">*</i>密码规则：包含字母大写、字母小写、数字、特殊字符的组合，密码长度应不少于8位</div>
                          </li>
                      </ul>
                      <ul class="cs-ul-form clearfix">
                          <li  class="cs-name col-md-3 col-xs-3">确认密码：</li>
                          <li  class="cs-in-style col-md-5 col-xs-5 ui-pos-re" >
                              <input type="text"  name="mpw2" class="inputxt password" recheck="mpw1"  datatype="*" nullmsg="请确认密码" errormsg="两次输入的密码不一致"  placeholder="请确认密码" autocomplete="off" />
                              <span class="iconfont icon-biyan pos-abs show-password"></span>
                          </li>

                          <li class="col-md-4 col-xs-4 cs-text-nowrap"></li>
                      </ul>
                  </div>
              </div>
              </div>
            </div>
          </div>
          <div class="modal-footer action">
            <button type="submit" class="btn btn-success">保存</button>
            <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
          </div>
        </form>
    </div>
  </div>
</div>

<!-- 个人信息-->
<div class="modal fade intro2" id="myModal-mid3" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog cs-mid-width" role="document">
    <div class="modal-content ">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title">个人信息</h4>
      </div>
      <div class="modal-body cs-mid-height">
    <div class="cs-main">
      <div class="cs-wraper">
      <div class="cs-add-new clearfix">
      <form id="userInfoForm" action="${webRoot}/system/user/updateRealname">
      		 <div width="100%" class="cs-add-new">
                <ul class="cs-ul-form clearfix">
                    <input type="hidden" name="id" value="${user.id}">
                    <li  class="cs-name col-md-3" width="20% " >账号：</li>
                    <li class="cs-in-style col-md-5" width="210px"  style="font-weight:bold;">${user.userName}</li>
                    <li class="col-md-4 cs-text-nowrap"></li>
                </ul>
                <ul class="cs-ul-form clearfix">
                    <li  class="cs-name col-md-3" width="20% " >单位：</li>
                    <li class="cs-in-style col-md-5" width="210px"  style="font-weight:bold;">${user.departName}</li>
                    <li class="col-md-4 cs-text-nowrap"></li>
                </ul>
                 <c:if test="${!empty user.pointName}">
                     <ul class="cs-ul-form clearfix">
                         <li  class="cs-name col-md-3" width="20% " >检测室：</li>
                         <li class="cs-in-style col-md-5" width="210px"  style="font-weight:bold;">${user.pointName}</li>
                         <li class="col-md-4 cs-text-nowrap"></li>
                     </ul>
                 </c:if>
                 <ul class="cs-ul-form clearfix">
                     <li class="cs-name col-md-3">用户名：</li>
                     <li class="cs-in-style col-md-5" >
                         <input type="text" name="realname" class="inputxt" datatype="*2-18" nullmsg="请输入用户名！" errormsg="用户名至少2-18个字符！" value="${user.realname}" />
                     </li>
                     <li class="col-md-4 cs-text-nowrap username-wrong">
                         <div class="Validform_checktip"></div>
                         <div class="info"><i class="cs-mred">*</i>用户名至少2-18个字符</div>
                     </li>
                 </ul>
            </div>
      </form>
      </div>
      </div>
    </div>
      </div>
      <div class="modal-footer action">
      <button type="submit" class="btn btn-success" onclick="mySubmit2();">保存</button>
        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      </div>
    </div>
  </div>
</div>

<%-- MD5加密 --%>
<script type="text/javascript" src="${webRoot}/plug-in/blueimp-md5/md5.min.js"></script>
<script type="text/javascript">
    $('.show-password').click(function () {
        if($(this).hasClass('icon-yan')){
            $(this).addClass('icon-biyan').removeClass('icon-yan').siblings('.inputxt').addClass('password');
        }else{
            $(this).addClass('icon-yan').removeClass('icon-biyan').siblings('.inputxt').removeClass('password');
        }
    })
    //修改密码-密码规则
    $('.show-rule').hover(function () {
        $('.password-rule').show();
    },function () {
        $('.password-rule').hide();
    });

    var oldPw = "";
    var pw1 = "";
	var userFormVf = $("#userForm").Validform({
		tiptype:2,
		ajaxPost:true,
		beforeSubmit:function(){
            oldPw = $("#userForm input[name='oldPassword']").val();
            pw1 = $("#userForm input[name='mpw1']").val();
            $("#userForm input[name='oldPassword']").val(md5(oldPw).toLocaleUpperCase());
            $("#userForm input[name='password']").val(md5(pw1).toLocaleUpperCase());
            $("#userForm input[name='mpw1']").attr("disabled","disabled");
            $("#userForm input[name='mpw2']").attr("disabled","disabled");

		},
		callback:function(data){
			if(data.success){
				window.location.reload();
			}else{
                $("#userForm input[name='oldPassword']").val(oldPw);
                $("#userForm input[name='password']").val(pw1);
                $("#userForm input[name='mpw1']").removeAttr("disabled");
                $("#userForm input[name='mpw2']").removeAttr("disabled");
				$.Showmsg(data.msg);
			}
		}
	});
    $('#myModal-mid2').on('hidden.bs.modal', function () {
        userFormVf.resetForm();
    });

    var userInfoFormVf = $("#userInfoForm").Validform({
        tiptype:2,
        ajaxPost:true,
        beforeSubmit:function(curform){},
        callback:function(data){
            if(data.success){
                window.location.reload();
            }else{
                $.Showmsg(data.msg);
            }
        }
    });
    $('#myModal-mid3').on('hidden.bs.modal', function () {
        userInfoFormVf.resetForm();
        $("#userInfoForm input[name='realname']").val("${user.realname}");
    });
	function mySubmit2(){
		$("#userInfoForm").submit();
	}

	$(function(){
		//菜单集合
		var menus = JSON.parse('${menusStr}');
		//加载子菜单
		$(document).on("click", ".firstMenu", function(){
			var menuId = $(this).attr("data-menuid"); 
			for(var i=0;i<menus.length;i++){
				if(menus[i].id==menuId){
					//消息菜单，清空其他一级菜单激活样式
					if(menuId == '1'){
						$('.cs-nav-style li').removeClass('cs-active');
					}
					
					//二级菜单集合
					var secMenus = menus[i].subMenu;
					if(menus[i].id == 0 || menus[i].id == 2){
						//首页,清空子菜单
						//$("#leftNav").html("");
						$("#leftNav").hide();
						$("#main_iframe").parent().removeClass("cs-container");
						$("#main_iframe").parent().addClass("cs-container2");
						reloadIframe(menus[i].functionUrl);
					}else{
						$("#leftNav").show();
						$("#main_iframe").parent().removeClass("cs-container2");
						$("#main_iframe").parent().addClass("cs-container");
						//拼接二级菜单html
						var navhtml = "<div class=\"cs-left_nav\">";
						navhtml += "<ul class=\"cs-navbar-nav cs-side-nav\">";
						for(var ii=0;ii<secMenus.length;ii++){
							var thrMenus = secMenus[ii].subMenu;
							if(ii==0){
								//首个二级菜单组
								navhtml += "<li class=\"cs-dropdown cs-dropdown-title  clearfix\">";
								navhtml += "<a href=\"#\"  class=\"cs-dropdown-toggle cs-deploy secMenus menusBtn\" data-menuid=\""+secMenus[ii].id+"\">";
								navhtml += "<span class=\"cs-icon-span\"><i class=\"icon iconfont "+secMenus[ii].functionIcon+"\"></i></span> "+secMenus[ii].functionName+" <b class=\"cs-caret\"></b></a>";
								navhtml += "<ul class=\"cs-dropdown-menu cs-toggle\">";
								//拼接三级菜单html
								for(var iii=0;iii<thrMenus.length;iii++){
									if(iii==0){
										//刷新iframe，打开一级菜单，默认打开首个三级菜单页面
										reloadIframe(thrMenus[iii].functionUrl);
										navhtml += "<li class=\"cs-active menusBtn\" data-menuid=\""+thrMenus[iii].id+"\"><a onclick=\"reloadIframe('"+thrMenus[iii].functionUrl+"')\" class=\"cs-rwgl\">"+thrMenus[iii].functionName+"</a></li>";
									}else{
										navhtml += "<li class=\"menusBtn\" data-menuid=\""+thrMenus[iii].id+"\"><a onclick=\"reloadIframe('"+thrMenus[iii].functionUrl+"')\" class=\"cs-schedule\">"+thrMenus[iii].functionName+"</a></li>";
									}
								}
								navhtml += "</ul></li>";
							}else{
								navhtml += "<li class=\"cs-dropdown cs-dropdown-title  clearfix\">";
								navhtml += "<a href=\"#\"  class=\"cs-dropdown-toggle money secMenus menusBtn\" data-menuid=\""+secMenus[ii].id+"\">";
								navhtml += "<span class=\"cs-icon-span\"><i class=\"icon iconfont "+secMenus[ii].functionIcon+"\"></i></span> "+secMenus[ii].functionName+" <b class=\"cs-caret\"></b></a>";
								navhtml += "<ul class=\"cs-dropdown-menu\">";
								for(var iii=0;iii<thrMenus.length;iii++){
									navhtml += "<li class=\"menusBtn\" data-menuid=\""+thrMenus[iii].id+"\"><a onclick=\"reloadIframe('"+thrMenus[iii].functionUrl+"')\">"+thrMenus[iii].functionName+"</a></li>";
								}
								navhtml += "</ul></li>";
							}
						}
						
						navhtml += "</ul></div>";
						//刷新二级菜单
						$("#leftNav").html(navhtml);
					}
					break;
				}
			}
		});
		
		//系统退出
	   	$(".logout").click(function(){
			window.location="${webRoot}/system/user/logout.do";
	   	});
		
		//每10秒刷新任务提醒
		//refreshNotice();
		//setInterval(refreshNotice, 10000);
		num();
		setInterval(num, 60000);
		unqual();
		setInterval(unqual, 60000);
		//触发第一个菜单
		$('.cs-nav-style li:first').trigger("click");
	});
	function num() {
		//消息提醒
		$.ajax({
	        type: "POST",
	        url: '${webRoot}'+"/message/num.do",
	        dataType: "json",
	        success: function(data){
	        	if(data && data.success){
	        		var num1 = data.obj.pageCount;
	        		if(num1!=0){
	        			$("#num").text(num1);
	        		}else{
	        			$("#num").text("");
	        		}
	        	}
			}
	    });
	}
	var unqualifiedNumTotal=0;//不合格总计
	sessionStorage.unqualNumber=0;//不合格数量统计
	sessionStorage.unqualHandelNumber=0;//超时待处理统计
	sessionStorage.unqualHandelNoFile=0;//已处理未上传凭证统计
	//汇总查询所有的不合格数据统计
	/*function unqual(){
		var today = new Date();
		//重置检测数据变量
		unqualifiedNumTotal=0;
		sessionStorage.removeItem("unqualNumber");
		sessionStorage.removeItem("unqualHandelNumber");
		sessionStorage.removeItem("unqualHandelNoFile");
		 //初始化
		unqualifiedNumTotal+=4;//写死的不合格检测数据数量
 		//1.不合格数量
 		$.ajax({
 	        type: "POST",
 	        url: "${webRoot}/dataCheck/recording/datagrid.do?refrel=/dataCheck/recording/list.do",
 	        data: {"conclusion":"不合格","dataType":0,"checkDateStartDateStr":today.format("yyyy-MM-dd")+" 00:00:00","checkDateEndDateStr":today.format("yyyy-MM-dd")+" 23:59:59"},
 	        dataType: "json",
 	        async:false,
 	        success: function(data){
 	        	if(data && data.success){
                    let num2 = data.obj.rowTotal;
 	        		sessionStorage.unqualNumber= num2;
 	        		unqualifiedNumTotal+=parseInt(sessionStorage.getItem("unqualNumber"));
                    if(num2!=0){
                        $("#unqualifiedNum").text(num2);
                    }else{
                        $("#unqualifiedNum").text("");
                    }
 	        	}
 			}
 	    });
 		//2.查询待处理数据
 		$.ajax({
	        type: "POST",
	        url: "${webRoot}/dataCheck/unqualified/datagrid.do",
	        data: {"conclusion":"不合格","queryTimeOutHandel":1,"dataType":0,"treatmentDateStartDate":today.format("yyyy-MM-dd")+" 00:00:00","treatmentDateEndDate":today.format("yyyy-MM-dd")+" 23:59:59"},
	        dataType: "json",
	        async:false,
	        success: function(data){
	        	if(data && data.success){
	        		sessionStorage.unqualHandelNumber= data.obj.rowTotal;
 	        		unqualifiedNumTotal+=parseInt(sessionStorage.getItem("unqualHandelNumber"));
	        	}
			}
	    });
 		//3.查询已处理未上传凭证数据
 		$.ajax({
	        type: "POST",
	        url: "${webRoot}/dataCheck/unqualified/datagrid.do",
	        data: {"dealMethod":1,"queryNoneFile":1,"treatmentDateStartDate":today.format("yyyy-MM-dd")+" 00:00:00","treatmentDateEndDate":today.format("yyyy-MM-dd")+" 23:59:59"},
	        dataType: "json",
	        async:false,
	        success: function(data){
	        	if(data && data.success){
	        		sessionStorage.unqualHandelNoFile= data.obj.rowTotal;
 	        		unqualifiedNumTotal+=parseInt(sessionStorage.getItem("unqualHandelNoFile"));
	        	}
			}
	    });
 		if(unqualifiedNumTotal==0){
 			$("#unqualifiedNumTotal").text("");
 		}else{
	 		$("#unqualifiedNumTotal").text(unqualifiedNumTotal);
 		}
	}
	*/
    function unqual(){
        var today = new Date();
        //不合格处理
        $.ajax({
            type: "POST",
            url: "${webRoot}/dataCheck/unqualified/datagrid.do",
            data: {"conclusion":"不合格","dataType":0,"treatmentDateStartDate":today.format("yyyy-MM-dd"),"treatmentDateEndDate":today.format("yyyy-MM-dd"),"param7":1},
            dataType: "json",
            success: function(data){
                if(data && data.success){
                    var num2 = data.obj.rowTotal;
                    if(num2!=0){
                        $("#unqualifiedNum").text(num2);
                    }else{
                        $("#unqualifiedNum").text("");
                    }
                }
            }
        });
    }
	var reloadFlag = true;	//刷新iframe标识
	
	//修改菜单并跳转
	//irstMenuId一级菜单ID,subMenuId二级菜单ID,thrMenusId三级菜单ID,url打开地址
	function setIframeUrl(firstMenuId, subMenuId, thrMenusId, url){
		if(firstMenuId && subMenuId && thrMenusId){
			reloadFlag = false;
			$(".menusBtn").each(function(){
				if($(this).attr("data-menuid") == firstMenuId){
					//模拟一级菜单点击
					$(this).trigger("click");
					
					//消息菜单，清空其他一级菜单激活样式
					if(firstMenuId == '1'){
						$('.cs-nav-style li').removeClass('cs-active');
					}
					
					setTimeout(function(){
						$(".menusBtn").each(function(){
							if($(this).attr("data-menuid") == subMenuId){
								//模拟二级菜单点击
								$(this).trigger("click");
								
								setTimeout(function(){
									$(".menusBtn").each(function(){
										if($(this).attr("data-menuid") == thrMenusId){
											//模拟三级菜单点击
											$(this).trigger("click");
											//update by xiaoyl 2020/08/31 预警信息跳转页面
											 $("#main_iframe",parent.document.body).attr("src", url);
										}
									});
								}, 50);
								
							}
						});
					}, 50);
					
				}
			});
			reloadFlag = true;
			//刷新iframe
			$("#main_iframe",parent.document.body).attr("src", url);
		}
	}

	//刷新iframe
	function reloadIframe(url){
		if(reloadFlag){
			if(url&&url!="undefined"){
				// console.log(url);

				//订单分拣处理 | 收样登记 | 复检订单分拣
				if( url == "/newCollectSample/list" || url == "/newPretreatment/list" || url=="/newCollectSample/list_recheck" || url == "/pretreatment/list" || url == "/collectSample/list"){
                    window.open('${webRoot}'+url);
                //以http或https开头，直接打开
                }else if(url.indexOf("http")==0 || url.indexOf("https")==0){
                    // $("#main_iframe",parent.document.body).attr("src", url);
                    window.open(url);

                }else{
                    $("#main_iframe",parent.document.body).attr("src", '${webRoot}'+url);
                }
			}else{
				console.log("url为空");
			}
		}
	}
	
	//刷新iframe，打开二级菜单，默认打开首个三级菜单页面
	$(document).on("click", ".secMenus", function(){
		$(this).siblings('.cs-dropdown-menu').find('li:first a').trigger("click");
    });
	
	//消息提醒
  	/* function refreshNotice(){
  		$.ajax({
	        type: "POST",
	        url: '${webRoot}'+"/task/queryNewTasks.do",
	        dataType: "json",
	        success: function(data){
	        	if(data && data.success){
	        		var tasks = JSON.parse(data.obj);
	        		$("#notice li:gt(0)").remove();
	        		if(tasks.length>0){
		        		for(var i=0;i<tasks.length;i++){
		        			var html = "<li class=\"cs-message\">"
		        				+ "<a class=\"cs-a-pad\" href=\"javascript:;\" onclick=\"loadTask('"+tasks[i].id+"');\">"
		        				+ "<img class=\"cs-fl\" src=\"${webRoot}/img/new.png\" alt=\"\" />"
		        				+ "<span class=\"cs-mess cs-float-l\">"+tasks[i].taskTitle+"</span>"
		        				+ "<img class=\"cs-fl\" src=\"${webRoot}/img/warning.png\" alt=\"\" />"
		        				+ "<span class=\"cs-timer cs-float-r cs-ar\">"+ new Date(tasks[i].taskCdate).format("MM-dd HH:mm") +"</span>"
		        				+ "</a></li><li class=\"cs-divider\"></li>";
		        			$("#notice").append(html);
		        		}
	        		}else{
	        			var html = "<li class=\"cs-no-mess\"><p>您暂时没有站内消息</p></li>";
	        			$("#notice").append(html);
	        		}
	        	}
			}
	    });
	} */
	
	//跳转查看消息
	/* function loadTask(id){
		if(id){
			//任务明细
			$("#main_iframe",parent.document.body).attr("src", '${webRoot}/taskDetail/goTaskForward.do?id='+id);
		}else{
			//接收任务列表
			$("#main_iframe",parent.document.body).attr("src", '${webRoot}/task/receiveList.do');
		}
	  	$(".cs-warn-menu").hide();
	} */
</script>
</body>
</html>