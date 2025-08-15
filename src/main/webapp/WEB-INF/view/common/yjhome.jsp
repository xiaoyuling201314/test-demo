<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/common/resource.jsp"%>
<html>
  <head>
    <title>快检服务云平台</title>
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
  </style>
  </head>

  <body>
      <div id="wrapper" class="blue-style">
	  <!-- <div class="cs-top-line"></div> -->
      <div class="cs-topbar">
        <div class="cs-navbar-header">
          <a class="cs-navbar-brand" id="nav-logo" href="#">
          	<img src="${webRoot}/img/zbsystem/fst-logo.png" style="height:40px;" alt="" />
          	<span>达元快检数据预警分析软件</span>
          </a>
          
        </div>

        <div class="cs-collapse cs-navbar-collapse cs-navbar-ex1-collapse cs-re-box">
          <!-- 一级导航栏 开始-->
          <div class="cs-top-nav">
            <ul class="cs-nav-style">
            	<c:forEach items="${menus}" var="menu">
            		<c:if  test="${menu.id!='1'}">
	            		<c:if test="${menu.id=='0'}">
	            			<li class="firstMenu cs-active menusBtn" data-menuid="${menu.id}">
	            		</c:if>
	            		<c:if test="${menu.id!='0'}"> 
		            		<li class="firstMenu menusBtn" data-menuid="${menu.id}">
			        	</c:if>
								<a href="javascript:">
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
          <ul class="cs-nav-right cs-float-r">
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
              <a id="cs-user-show" href="#" title="${session_user.realname}" class="cs-dropdown-toggle cs-user-show" data-toggle="dropdown"><i title="用户" class="icon iconfont icon-yonghu" style="font-size: 23px;" data-menuid="${menu.id}"></i>
              
              </a>
            </li>
          <!-- 用户信息 结束--> 
            <li class="cs-self-menu cs-hide">
              <div class="cs-self-content">
                <a href="javascript:" data-toggle="modal" data-target="#myModal-mid2" >修改密码</a>
                <a href="javascript:" class="logout">退出系统</a>
              </div>
            </li>
            <p class="cs-user-name" style="text-align:center;">${session_user.realname}</p>
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
      <div class="modal-body cs-mid-height">
         <!-- 主题内容 -->
    <div class="cs-main">
      <div class="cs-wraper">
      <div class="cs-add-new clearfix">
      <form id="userForm" action="${webRoot}/system/user/updatePassword.do">
      		 <div width="100%" class="cs-add-new">
                <ul class="cs-ul-form clearfix">
                    <input type="hidden" name="id" value="${user.id}">
                    <li  class="cs-name col-md-3" width="20% " >账号：</li>
                    <li class="cs-in-style col-md-5" width="210px"  style="font-weight:bold;">${user.userName}</li>
                    <li class="col-md-4 cs-text-nowrap"></li>
                </ul>
                <ul class="cs-ul-form clearfix">
		          <li class="cs-name col-md-3" width="20% ">用户名：</li>
		          <li class="cs-in-style col-md-5" width="210px"  style="font-weight:bold;">${user.realname}</li>
		          <li class="col-md-4 cs-text-nowrap"></li>
		        </ul>
                <ul class="cs-ul-form clearfix">
                    <li  class="cs-name col-md-3">原密码：</li>
                    <li  class="cs-in-style col-md-5" >
                        <input type="password" value="" name="oldPassword"  class="inputxt" plugin="passwordStrength"  datatype="*6-18" nullmsg="请输入密码！" errormsg="密码至少6个字符,最多18个字符！" />
                    </li>
                    <li class="col-md-4 cs-text-nowrap">
                        <div class="Validform_checktip"></div>
                        <div class="passwordStrength" style="display:none;"><b>强度：</b> <span>弱</span><span>中</span><span class="last">强</span></div>
                        <div class="info"><i class="cs-mred">*</i>密码至少6-18个字符</div>
                    </li>
                </ul>
                <ul class="cs-ul-form clearfix">
                    <li  class="cs-name col-md-3">新密码：</li>
                    <li  class="cs-in-style col-md-5" >
                        <input type="password" value="" name="password"  class="inputxt" plugin="passwordStrength"  datatype="*6-18" nullmsg="请输入密码！" errormsg="密码至少6个字符,最多18个字符！" />
                    </li>
                    <li class="col-md-4 cs-text-nowrap">
                        <div class="Validform_checktip"></div>
                        <div class="passwordStrength" style="display:none;"><b>强度：</b> <span>弱</span><span>中</span><span class="last">强</span></div>
                        <div class="info"><i class="cs-mred">*</i>密码至少6-18个字符</div>
                    </li>
                </ul>
                <ul class="cs-ul-form clearfix">
                    
                    <li  class="cs-name col-md-3">确认密码：</li>
                    <li  class="cs-in-style col-md-5" ><input type="password" value="" name="password2" class="inputxt" recheck="password"  datatype="*6-18" nullmsg="请确认密码！" errormsg="两次输入的密码不一致！" /></li>
                    <li class="col-md-4">
                      <div class="Validform_checktip"></div>
                      <div class="info"><i class="cs-mred">*</i>请确认密码</div>
                    </li>
                </ul>           
            </div>
      </form>
      </div>
      </div>
    </div>
      </div>
      <div class="modal-footer action">
      <button type="submit" class="btn btn-success" onclick="mySubmit();">确定</button>
        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      </div>
    </div>
  </div>
</div>

<script type="text/javascript">
	var oldPasswordCheck = false;//原密码验证，false不通过，true通过
	
	$("#userForm").Validform({
		tiptype:2,
		ajaxPost:true,
		beforeSubmit:function(curform){
			if($("input[name='oldPassword']").val().length<6 || $("input[name='oldPassword']").val().length>18){
				oldPasswordCheck = false;
				//$("input[name='oldPassword']").parent().next().find("i").attr("class","icon iconfont icon-cuo text-del");
				return false;
			}
			if(!oldPasswordCheck){
				return false;
			}
		},
		callback:function(data){
			if(data.success){
				window.location.reload();
			}else{
				$.Showmsg(data.msg);
			}
		}
	});
	
	function mySubmit(){
		$("#userForm").submit();
	}

	$(function(){
		//修改密码
		$("input[name='oldPassword']").change(function(){	
			var userid = $("input[name='id']").val();
			var oldPassword = $(this).val().trim();
			if(oldPassword.length>=6 && oldPassword.length<=18){
				console.log(oldPassword.length>=6 && oldPassword.length<=18);
				$.ajax({
			        type: "POST",
			        url: '${webRoot}'+"/system/user/updatePassword.do",
			        data: {"id":userid,"oldPassword":oldPassword},
			        dataType: "json",
			        success: function(data){
			        	$.Showmsg(data.msg);
			        	if(data.success){
			        		oldPasswordCheck = true;
			        		//$("input[name='oldPassword']").parent().next().find("i").attr("class","icon iconfont icon-dui");
			        	}else{
			        		oldPasswordCheck = false;
			        		//$("input[name='oldPassword']").parent().next().find("i").attr("class","icon iconfont icon-cuo text-del");
			        	}
					}
			    });
			}else{
				//oldPasswordCheck = false;
				//$("input[name='oldPassword']").parent().next().find("i").attr("class","icon iconfont icon-cuo text-del");
			}
		});
		
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
					if(menus[i].id == 0){
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
		setInterval(num, 20000);
		unqual();
		setInterval(unqual, 20000);
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
	function unqual(){
		var today = new Date();
		//不合格处理
		$.ajax({
	        type: "POST",
	        url: '${webRoot}'+"/dataCheck/unqualified/datagrid.do",
	        data: {"conclusion":"不合格",/* "indexNum":"Y", */"dataType":0,"checkDateStartDateStr":today.format("yyyy-MM-dd")+" 00:00:00","checkDateEndDateStr":today.format("yyyy-MM-dd")},
	        	//"dateMap":{"checkDateStart":,"checkDateEnd":},
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
				console.log(url);
				$("#main_iframe",parent.document.body).attr("src", '${webRoot}'+url);
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


<!-- 输入框验证提醒 -->
<script type="text/javascript">
$(function(){
  //$(".registerform").Validform();  //就这一行代码！;
  
  var getInfoObj=function(){
      return  $(this).parents("li").next().find(".info");
    }
  
  $("[datatype]").focusin(function(){
    if(this.timeout){clearTimeout(this.timeout);}
    var infoObj=getInfoObj.call(this);
    if(infoObj.siblings(".Validform_right").length!=0){
      return; 
    }
    infoObj.show().siblings().hide();
    
  }).focusout(function(){
    var infoObj=getInfoObj.call(this);
    this.timeout=setTimeout(function(){
      infoObj.hide().siblings(".Validform_wrong,.Validform_loading").show();
    },0);
    
  });
  
  $(".registerform").Validform({
    tiptype:2,
    usePlugin:{
      passwordstrength:{
        minLen:6,
        maxLen:18,
        trigger:function(obj,error){
          if(error){
            obj.parent().next().find(".passwordStrength").hide().siblings(".info").show();
          }else{
            obj.removeClass("Validform_error").parent().next().find(".passwordStrength").show().siblings().hide();  
          }
        }
      }
    }
  });
  
})
</script>
<script type="text/javascript">
$(function(){
  //$(".registerform").Validform();  //就这一行代码！;
    
  var demo=$(".registerform").Validform({
    tiptype:3,
    label:".label",
    showAllError:true,
    datatype:{
      "zh1-6":/^[\u4E00-\u9FA5\uf900-\ufa2d]{1,6}$/
    },
    ajaxPost:true
  });
  
  //通过$.Tipmsg扩展默认提示信息;
  //$.Tipmsg.w["zh1-6"]="请输入1到6个中文字符！";
  demo.tipmsg.w["zh1-6"]="请输入1到6个中文字符！";
  
  demo.addRule([
  {
    ele:".inputxt:eq(0)",
    datatype:"*6-20"
  },
  {
    ele:".inputxt:eq(0)",
    datatype:"*6-20"
  },
  {
    ele:".inputxt:eq(1)",
    datatype:"*6-20",
    recheck:"userpassword"
  },
  {
    ele:"select",
    datatype:"*"
  },
  {
    ele:":radio:first",
    datatype:"*"
  },
  {
    ele:":checkbox:first",
    datatype:"*"
  }]);
  
})
</script>

</body>
</html>