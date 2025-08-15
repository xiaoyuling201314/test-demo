<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt"%>
<%
	String path = request.getContextPath();
	String serverName = request.getServerName();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path;
	String resourcesUrl = basePath + "/resources/";
%>
<c:set var="webRoot" value="<%=basePath%>" />
<c:set var="serverName" value="<%=serverName%>" />
<c:set var="resourcesUrl" value="<%=resourcesUrl%>" />
<meta charset="UTF-8">
<title>${systemName}</title>
<link rel="shortcut icon" href="${webRoot}/img/favicon.ico">
<!-- css -->
<link rel="stylesheet" type="text/css" href="${webRoot}/css/iconfont/iconfont.css" />
<link rel="stylesheet" type="text/css" href="${webRoot}/plug-in/easyui-1.5.2/easyui.css">
<link rel="stylesheet" type="text/css" href="${webRoot}/plug-in/easyui-1.5.2/icon.css">
<link rel="stylesheet" type="text/css" href="${webRoot}/css/bootstrap.css" />
<link rel="stylesheet" type="text/css" href="${webRoot}/css/bootstrap-responsive.css" />
<link rel="stylesheet" type="text/css" href="${webRoot}/plug-in/select2/css/select2.min.css">

<link rel="stylesheet" type="text/css" href="${webRoot}/css/base.css" />
<link rel="stylesheet" type="text/css" href="${webRoot}/css/index.css" />
<link rel="stylesheet" type="text/css" href="${webRoot}/css/misson.css" />

<%--footable--%>
<link rel="stylesheet" type="text/css" href="${webRoot}/plug-in/footable/footable.core.css">
<%-- TODO 备注：更新系统的时候注意去掉jquery-3.0.0.min.js后面的版本号，不然会和乐橙轻应用插件冲突--%>
<script type="text/javascript" src="${webRoot}/plug-in/imouPlayer2/static/jquery-min.js"></script>

<script type="text/javascript" src="${webRoot}/plug-in/easyui-1.5.2/jquery.easyui.min.js"></script>
<script type="text/javascript" src="${webRoot}/plug-in/easyui-1.5.2/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="${webRoot}/plug-in/bootstrap/bootstrap.js"></script>
<script type="text/javascript" src="${webRoot}/plug-in/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="${webRoot}/plug-in/My97DatePicker/lang/zh-cn.js"></script>
<script type="text/javascript" src="${webRoot}/js/dateUtil.js"></script>
<script type="text/javascript" src="${webRoot}/js/index.js"></script>
<!--select2 搜索-->
<script type="text/javascript" src="${webRoot}/plug-in/select2/js/select2.js"></script>

<%--窗口拖拽--%>
<script type="text/javascript" src="${webRoot}/plug-in/drag/drag.js"></script>
<%--footable--%>
<script type="text/javascript" src="${webRoot}/plug-in/footable/footable.all.min.js"></script>
<html>
<head>
	<title>快检服务云平台</title>
	<link rel="stylesheet" type="text/css" href="${webRoot}/plug-in/easyui-1.5.2/tree.css">
	<style type="text/css">
		iframe {
			width: 100%;
			height: 100%;
			position: absolute;
			right: 0;
			left: 0;
			top: 0px;
			bottom: 0;
			border: 0;
			border: none;
		}

		.play-list ul li {
			padding: 6px 12px 6px 10px;
			border-bottom: 1px dotted #ddd;
		}

		.play-list ul li:hover,.play-list ul li.active{
			background: #ddd;
			color: #05af50;
			cursor: pointer;
		}

		.play-left-nav h4 {
			padding: 6px;
			border-bottom: 1px solid #ddd;
			background: #f1f1f1;
			font-size:14px;
		}
		.showDiv p {
			cursor: pointer;
		}

		.cs-tab-icon ul {
			border-right: 1px solid #ddd;
		}

		.cs-tab-icon ul li {
			float: left;
			border-left: 1px solid #ddd;
		}

		.cs-tab-icon ul li a {
			display: inline-block;
			margin-top: -1px;
			padding: 0 20px;
			line-height: 41px;
			color: #999;
		}

		.cs-tab-icon ul li a:hover, .cs-tab-icon ul li a.active {
			color: #05af50;
		}

		.cs-tab3 li {
			float: left;
			height: 30px;
			color: #666;
			text-align: center;
			line-height: 34px;
			cursor: pointer;
			background: #fff;
			width: 110px;
		}

		.cs-tab3 li.cs-cur {
			height: 34px;
			border: 1px solid #ddd;
			border-bottom: none;
			color: #fff;
			background: #1dcc6a;
			border-radius: 4px 4px 0 0;
		}
		.video-player-box p{
			position:absolute;
			top:0;
			left:0;
			width:100%;
			height:24px;
			color: #fff;
			z-index: 10;
			padding:0 5px;
		}
		.search-input input{
			width:90%;
			height:30px;
		}
		.stock_info{
			width:100%;
			overflow: auto;
			height: 90%;
			/*height: 100%;*/
		}

		.stock_info ul li .title {
			width: 78%;
		}

		.cs-stat-search .cs-input-cont[type=text]{
			width:85px;
			margin-left:0;
		}
		.cs-search-btn{
			width:34px;
		}
		.cs-search-filter, .cs-search-margin {
			float: right;
			margin-right: 0;
		}

		.playerVedio{
			margin:0 auto;
			margin-top:10px;
			height: 480px;
		}
		.styleDiv{
			padding:0;
			width: 800px;
			margin: 0 auto;
			box-sizing: border-box;
		}
	</style>
</head>
<body class="easyui-layout">
<div data-options="region:'west',split:false,title:'检测点'" style="width: 326px; padding:10px; padding-left:0; padding-right:0;overflow: hidden;">
	<div class="search-result">
		<div class="cs-stat-search col-md-12 col-sm-12 clearfix">
			<div class="cs-all-ps">
				<div class="cs-input-box" style="width:180px">
					<input type="text" name="departName" id="departName" readonly="readonly" value="${report.departName }" title="${report.departName }" style="height: 30px;overflow: hidden; white-space: nowrap; text-overflow: ellipsis;width: 180px;">
					<!-- 							<div class="cs-down-arrow"></div> -->
				</div>

			</div>
			<div class="cs-search-filter clearfix cs-fr">
				<%--<input class="cs-input-cont cs-fl focusInput" type="hidden" name="pointId" id="pointId">--%>
				<input class="cs-input-cont cs-fl focusInput" type="text" name="pointName" id="pointName" id="search"  autocomplete="off" placeholder="请输入检测点名称">
				<input type="button" onclick="queryByFocus();"   class="cs-search-btn cs-fl" href="javascript:;" value="搜索">
			</div>
		</div>
	</div>
	<div class="stock_info">
		<!--左侧检测点列表-->
		<ul id="type">

		</ul>
	</div>
</div>

<div data-options="region:'north',border:false" style="top: 0px; border: none;">
	<div>
		<!-- 面包屑导航栏  开始-->
		<ol class="cs-breadcrumb">
			<li class="cs-fl"><img src="${webRoot}/img/set.png" alt="" /><a href="javascript:;">视频监控</a></li>
			<li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
			<li class="cs-b-active cs-fl">视频回放</li>
		</ol>
		<div class="cs-search-box cs-fr">
			<div class="clearfix" id="showBtn">

			</div>
		</div>
	</div>
</div>

<div data-options="region:'center',split:false">
	<div id="videoPoint" class="text-center" style="font-size: 20px; line-height: 30px; margin-top: 10px;">
		<i class="icon iconfont icon-shexiangtou text-primary" style="font-size: 22px"></i>
		<span class="pointName">${bean.pointName}</span>
	</div>
	<div class="cs-time-se cs-in-style" style="padding: 5px 10px; margin: 0 auto; width: 610px;text-align: center;">
		回放时间：
		<input type="text" id="replayDate" autocomplete="off" class="cs-time" onclick="WdatePicker({startDate:'%y-%M-%d %H:%m:%s',maxDate:'%y-%M-%d %H:%m:%s',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})">
		<a class="cs-menu-btn" href="javascript:;" onclick="playVedio();"><i class="icon iconfont icon-chakan"></i>搜索</a>
		<%--<span class="btn btn-primary" style="line-height: 18px; margin-top: -4px;" onclick="playVedio();"><i class="iconfont icon-chakan"></i>搜索</span>--%>

	</div>
	<div class="cs-col-lg-table cs-tab-box cs-on styleDiv">
		<div id="playercontainer" ></div>
	</div>
</div>
<!-- 引用模态框 -->
<%@include file="/WEB-INF/view/common/confirm.jsp"%>
<%@include file="/WEB-INF/view/detect/depart/selectDepartModel.jsp"%>
<%@include file="/WEB-INF/view/common/modalBox.jsp"%>
<!-- 下拉插件 -->
<script src="${webRoot}/js/select/tabcomplete.min.js"></script>
<script src="${webRoot}/js/select/livefilter.min.js"></script>
<script src="${webRoot}/js/select/bootstrap-select.js"></script>
<script src="${webRoot}/js/select/filterlist.js"></script>
<script src="${webRoot}/plug-in/player/cyberplayer.js"></script>
<script src="${webRoot}/js/datagridUtil2.js"></script>

<script type="text/javascript">
	//add by xiaoyl 2023-1-5:非东营系统，动态引入blue.css
	if("${webRoot}".indexOf("dy.chinafst.cn")==-1){
		$("head").append('<link rel="stylesheet" type="text/css" href="${webRoot}/css/blue.css" />');
	}

	var  departId=${report.departId};
	var queryType =9;//查看类型：0 离线，1在线，-1设备号异常,-2未配置，'' 全部,9 回放
	var pointId;//选择的检测点ID
	$(function(){
		//默认回放当天的数据
		$("#replayDate").val(new Date().DateAdd("n",-30).format("yyyy-MM-dd HH:mm:ss"));
		$('#surveillanceNameChose').select2();
		//初始化加载检测点
		loadPoints(${report.departId},queryType);
	});
	$(document).on("click", "#departName", function(){
		$('#myDepartModal').modal('toggle');
	});
	//选择机构，执行查询检测点操作
	function selDepart(id, text){
		$('#myDepartModal').modal('toggle');
		departId=id;
		$("#departId").val(id);
		$("input[name='departName']").val(text);
		$("input[name='departName']").attr("title",text);
		$(".cs-check-down").hide();
		loadPoints(id,queryType);
	}
	//根据机构Id查询检测点
	function loadPoints(departId,queryType){
		$.ajax({
			url: "${webRoot}/video/surveillance/selectPointByDepartId.do",
			type: "POST",
			data: {
				"departId": departId,
				"queryType":queryType
			},
			dataType: "json",
			success: function (data) {
				dealHtml(data.obj);
			},
			error: function () {
				$("#waringMsg>span").html("操作失败");
				$("#confirm-warnning").modal('toggle');
			}
		})
	}
	//拼接左侧检测点列表
	function dealHtml(data){
		var htmlStr = "";
		$("#type").empty("");
		if(data=="") {
			$("#showBtn").addClass("cs-hide");
			$("#type").append(htmlStr);
			$(".pointName").html(htmlStr);
			$("#playercontainer").addClass("cs-hide");
		}else{
			$("#showBtn").removeClass("cs-hide");
			var json = eval(data);
			$.each(json, function(index, item) {
				htmlStr+='<li name="type" data-type='+item.id+' data-pointName='+item.pointName+' data-departId='+item.departId+' onclick="selectPoint(this)" >';
				htmlStr+='<div class="title"><a href="javascript:;" title='+item.pointName+'>';
				// htmlStr += '<i style="padding-left: 2px" class="icon iconfont icon-shexiangtou text-primary" title="在线"></i>' + item.pointName;
				if(item.storageType==1){//内存卡
					htmlStr += '<i style="padding-left: 2px" class="icon iconfont icon-sdka text-primary" title="内存卡"></i>'+ item.pointName;
				}else if(item.storageType==2){//云存储
					htmlStr += '<i style="padding-left: 2px" class="icon iconfont icon-yunduan text-primary" title="云储存"></i>'+ item.pointName;
				}
				htmlStr+=' </a></div><div class="arrow"><i class="icon iconfont icon-you"></i></div></li>';
			});
			$("#type").append(htmlStr);
			//默认选中第一个检测点并加载摄像头数据
			if(htmlStr!=""){
				$("#type li:first-child").addClass("active");//第一次进来就默认选中第一个
				var id = $("#type li:first-child").data("type");
				pointId=id;
				$("#pointId").val(id);
				var pointName= $("#type li:first-child").attr("data-pointName")
				$(".pointName").html(pointName);
				playVedio();
			}
		}
	}
</script>
<script type="text/javascript">
	var player;
	var vedioRootPath="${webRoot}/plug-in/imouPlayer2/";//轻应用路径，imouplayer.js中引入statis中的js文件时使用
	var playerOption = {
		isEdit: false,
		url: 'imou://open.lechange.com/6H0BXXXXXXX3D90/0/1?streamId=1',
		kitToken: 'Kt_3baccxxxxxxxxxxxxxxxxxxxxxa183e',
		// 是否自动播放
		autoplay: true,
		// 是否显示控制台
		controls: true,
		// 是否开启静音
		automute: false,
		themeData: [{
			area: 'header',
			fontColor: '#F18D00',
			backgroundColor: '#FFFFFF',
			activeButtonColor: '#0E72FF',
			buttonList: [{
				show: true,
				id: 'deviceName',
				name: '设备名称',
				position: 'left',
				showName:"",
			}, {
				show: true,
				id: 'channalId',
				name: '设备通道',
				position: 'left',
			}, {
				show: true,
				id: 'cloudVideo',
				name: '云录像',
				position: 'right',
			}, {
				show: true,
				id: 'localVideo',
				name: '本地录像',
				position: 'right',
			}]
		}, {
			area: 'footer',
			fontColor: '#F18D00',
			backgroundColor: '#FFFFFF',
			activeButtonColor: '#0E72FF',
			buttonList: [{
				show: true,
				id: 'play',
				name: '播放',
				position: 'left',
			}, {
				show: true,
				id: 'mute',
				name: '音量控制',
				position: 'left',
			}, {
				show: true,
				id: 'talk',
				name: '语音对讲',
				position: 'left',
			}, {
				show: true,
				id: 'capture',
				name: '截图',
				position: 'left',
			}, {
				show: true,
				id: 'definition',
				name: '清晰度控制',
				position: 'right',
			}, {
				show: true,
				id: 'PTZ',
				name: '云台控制',
				position: 'right',
			}, {
				show: false,
				id: 'webExpend',
				name: '网页全屏',
				position: 'right',
			}, {
				show: true,
				id: 'extend',
				name: '全屏控制',
				position: 'right',
			}]
		}],
	};
	//根据检测点ID查询摄像头设备信息以及轻应用播放kitTokenStr
	function playVedio(){
		// 添加DOM容器
		if(player){
			player.destroy();
		}
		player = new ImouPlayer('#playercontainer');
		$.ajax({
			url:'${webRoot}/video/surveillance/selectDeviceForImouPlayer?pointId='+pointId,
			async:false,
			success:function(data){
				if(data.obj.length>0){
					//备注：一个检测点配置多个摄像头，目前只支持第一个摄像头第一个通道回放
					for (var i = 0; i < data.obj.length; i++) {
						if(data.obj[i].accountPhone!="" && data.obj[i].videoType==0 && i==0){
							//视频回放不能跨天，最多只能查看一天的记录
							let startDate=$("#replayDate").val();
							let endDate=new Date(startDate).format("yyyy-MM-dd")+" 23:59:59";
							var recordType="";
							if(data.obj[i].storageType==1){//本地SD卡回放
								recordType="recordType=localRecord&";
								//SD卡回放，控制播放器右上角云储存图标隐藏，SDK图标显示
								playerOption.themeData[0].buttonList[2].show=false;
								playerOption.themeData[0].buttonList[3].show=true;
							}else{
								//云存储回放，控制播放器右上角SDK图标隐藏，云储存图标显示
								playerOption.themeData[0].buttonList[2].show=true;
								playerOption.themeData[0].buttonList[3].show=false;
							}
							playerOption.themeData[0].buttonList[0].showName=data.obj[i].pointName;
							var urlStr= "imou://open.lechange.com/"+data.obj[i].dev+"/0/2?"+recordType+"streamId=1&beginTime="+startDate+"&endTime="+endDate;
							//乐橙云轻应用直播插件获取kitToken
							getKitToken(data.obj[i].accountPhone,data.obj[i].dev,0);
							$("#playercontainer").addClass("playerVedio");
							var width = $('#playercontainer').clientWidth;
							var height = parseInt(width * 9 / 16);
							player.setup({
								src: [{
									url: urlStr,
									kitToken: kitToken
								}], // 播放地址
								width: width, // 播放器宽度
								height: height, // 播放器高度
								poster: '${webRoot}/img/video_bg_new.png', // 封面图url  ${webRoot}/img/video_bg_new.png
								autoplay: true, // 是否自动播放
								controls: true, // 是否展示控制栏
								isEdit: playerOption.isEdit,
								automute: playerOption.automute,
								themeData: playerOption.themeData
							});
						}
					}
				}else{
					$("#playercontainer").removeClass("playerVedio");
				}
			}
		});
	}

	function checkFullScreen() {
		var isFull = document.webkitIsFullScreen || document.mozFullScreen || document.msFullscreenElement || document.fullscreenElement;
		if (isFull == null || isFull == undefined) {
			isFull = false;
		}
		return isFull;
	}

	//使用
	window.onresize = function () {
		if(checkFullScreen()) {
			// console.log('全屏状态')
		} else {
			$('.styleDiv').width(800);
			// console.log('缩小状态')
			setTimeout(function(){
				$('#playercontainer').height(480);
			},1000);
		}
	}

	//根据关键字和机构ID查询检测点
	function queryByFocus(){
		$.ajax({
			url: "${webRoot}/video/surveillance/selectPointByDepartId.do",
			type: "POST",
			data: {
				"departId":departId,
				"queryType":queryType,
				"pointName": $("#pointName").val()
			},
			dataType: "json",
			success: function (data) {
				$("[name=type]").remove();
				dealHtml(data.obj);
			},
			error: function () {
				$("#waringMsg>span").html("操作失败");
				$("#confirm-warnning").modal('toggle');
			}
		})
	}
	//回车查询数据
	document.onkeydown=function(event){
		var e = event || window.event || arguments.callee.caller.arguments[0];
		if(e && e.keyCode==13){ //enter键
			var focusedElement = document.activeElement;//当前关键词元素
			if(focusedElement && focusedElement.className){
				queryByFocus();
			}
			return false;
		}
	}
	//乐橙云轻应用直播插件获取kitToken
	var kitToken="";
	function getKitToken(accountPhone,dev,channelId){
		$.ajax({
			url: "${webRoot}/video/surveillance/getKitToken.do",
			type: "POST",
			data: {
				"accountPhone":accountPhone,
				"dev": dev,
				"channelId": channelId,
			},
			dataType: "json",
			async:false,
			success: function (data) {
				if(data.success){
					kitToken=data.obj;
				}else{
					$("#waringMsg>span").html(data.msg);
					$("#confirm-warnning").modal('toggle');
				}
			},
			error: function (data) {
				$("#waringMsg>span").html("操作失败"+data.msg);
				$("#confirm-warnning").modal('toggle');
			}
		})
	}

	function selectPoint(obj) {
		$.each($("li[name='type']"), function (index, item) {
			$(item).attr("class", "");
		});
		var id = $(obj).data("type");
		pointId=id;
		var pointName=$(obj).data("pointname");
		$(".pointName").html(pointName);
		$("#pointId").val(id);
		$(obj).addClass("active");
		playVedio();

	}
</script>
<script src="${webRoot}/plug-in/imouPlayer2/imouplayer.js"></script>
<%--监听用户是否浏览页面--%>
<script src="${webRoot}/js/listenerVideo.js"></script>
</body>
</html>
