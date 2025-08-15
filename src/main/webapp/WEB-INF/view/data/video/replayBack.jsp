<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/common/resource.jsp"%>
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
.stock_info ul li .title {
	width: 78%;
}

.cs-stat-search .cs-input-cont[type=text]{
	width:85px;
	margin-left:0;
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
				<a href="javascript:;" onclick="parent.closeMbIframe();" class="cs-menu-btn cs-fun-btn" id="back"><i class="icon iconfont icon-fanhui" ></i>返回</a>
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
			回放日期：
			<input type="text" id="replayDate" autocomplete="off" class="cs-time" onclick="WdatePicker({maxDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd'})">
			<span class="btn btn-primary" style="line-height: 18px; margin-top: -4px;" onclick="playVedio();"><i class="iconfont icon-chakan"></i>回放</span>

		</div>
	 	<div class="cs-col-lg-table cs-tab-box cs-on styleDiv">
	        <div id="playercontainer" ></div>
        </div>
	</div>
	
	<!-- 引用模态框 -->
	<%@include file="/WEB-INF/view/common/confirm.jsp"%>
    <script type="text/javascript">
		var player;
		//乐橙云轻应用直播插件获取kitToken
		var kitToken;
		$(function(){
			//默认回放当天的数据
			$("#replayDate").val(new Date().format("yyyy-MM-dd"));
			playVedio();
		});
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

		function playVedio(){
			// 添加DOM容器
			if(player){
				player.destroy();
			}
			player = new ImouPlayer('#playercontainer');
            //视频回放不能跨天，最多只能查看一天的记录
			let startDate=$("#replayDate").val()+" 00:00:00";
			let endDate=$("#replayDate").val()+" 23:59:59";
			//官方文档：https://open.imou.com/book/zh/http/device/record/lightNew/sdk.html，使用2022-07-12发布的新版轻应用组件
			//云录像播放地址示例为：imou://open.lechange.com/deviceId/channelId/2?streamId=1&beginTime=2021-08-08 09:00:00&endTime=2021-08-08 10:00:00
			var recordType="";//默认是云存储回放
			if("${bean.dev}"=="1"){//本地回放
				recordType="recordType=localRecord&";
			}
			var urlStr= "imou://open.lechange.com/${bean.dev}/0/2?"+recordType+"streamId=1&beginTime="+startDate+"&endTime="+endDate;
			//乐橙云轻应用直播插件获取kitToken
			getKitToken("${bean.accountPhone}","${bean.dev}",0);
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

		function checkFullScreen() {
			var isFull = document.webkitIsFullScreen || document.mozFullScreen || document.msFullscreenElement || document.fullscreenElement;
			if (isFull == null || isFull == undefined) {
				isFull = false;
			}
			return isFull;
		}
		window.onresize = function () {
			if(checkFullScreen()) {
				// console.log('全屏状态')
			} else {
				$('.playerVedio').height(480);
				$('.styleDiv').width(800);
				// console.log('缩小状态')
			}
		}
		//根据手机号码、设备号、通道号获取kitToken；注意：每个通道都有自己的kittoken
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
    </script>
    <script src="${webRoot}/plug-in/imouPlayer2/imouplayer.js"></script>
	<%--监听用户是否浏览页面--%>
	<script src="${webRoot}/js/listenerVideo.js"></script>
</body>
</html>
