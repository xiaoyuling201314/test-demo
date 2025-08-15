<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<link href="http://125.46.86.22:88/bootstrap/css/button.css" type="text/css" rel="stylesheet">
    <link href="http://125.46.86.22:88/808gps/open/css/video.css" rel="stylesheet">
    <script  type="text/javascript"  src="http://112.74.175.12/808gps/open/player/player.swf"></script>
    <script  type="text/javascript"  src="http://125.46.86.22:88/808gps/js/jquery.min.js"></script>
    <script  type="text/javascript"  src="http://125.46.86.22:88/808gps/open/player/jquery.query-2.1.7.js"></script>
    <script type="text/javascript" src="http://125.46.86.22:88/js/lhgdialog.min.js"></script>
    <script type="text/javascript"  src="http://125.46.86.22:88/808gps/open/player/swfobject.js"></script>
</head>
<body>
	<div id="flashExample">
  		<div id="cmsv6flash"></div>
  		<div></div>
  		<div id="eventTip"></div>
  			<div class="player-params">
    			<div class="player-param">
    					<a id="isPlay" class="button button-primary button-rounded button-small" onclick="checkIsPlaying();">播放状态</a>
    			</div>
    		</div>
  	</div>

	<script type='text/javascript'>
		var jsession;
		var isInitFinished = false;//视频插件是否加载完成
		var selectIndex = 0;
	  	var playingStatusArray = [];

		/**
		 * 用户登录
		 **/
		function userLogin() {
			var param = [];
			param.push({
				name : 'account',
				value : 'admin'
			});
			param.push({
				name : 'password',
				value : 'admin'
			});

			$.ajax({
				type : 'POST',
				url : 'http://125.46.86.22:88/808gps/StandardApiAction_login.action',
				data : param,
				cache : false,/*禁用浏览器缓存*/
				dataType : 'json',
				async:false,
				success : function(data) {
					if (data.result == 0) {
						jsession=data.jsession;
					} else {
						alert(lang.loginError);
					}
				},
				error : function(XMLHttpRequest, textStatus, errorThrown) {
					try {
						if (p.onError) p.onError(XMLHttpRequest, textStatus, errorThrown);
					} catch (e) {
					}
					alert(lang.loginError);
				}
			});
		}
		
		var lang = new langZhCn();
		function langZhCn() {
			this.videoExample = "视频用例";
			this.geSessionId = "获取会话号";
			this.userId = "用户名：";
			this.password = "密码：";
			this.login = "登陆";
			this.videoInit = "初始化";
			this.videoLang = "插件语言：";
			this.videoWidth = "插件宽度：";
			this.videoHeight = "插件高度：";
			this.serverIp = "服务器IP：";
			this.serverPort = "端口：";
			this.windowNumber = "窗口数目：";
			this.settings = "设置";
			this.videoLive = "实时视频";
			this.windowIndex = "窗口下标：";
			this.title = "标题：";
			this.jsession = "会话号：";
			this.stream = "码流：";
			this.devIdno = "设备号：";
			this.channel = "通道：";
			this.play = "播放";
			this.stop = "停止";
			this.reset = "重置";
			this.monitor = "监听";
			this.talkback = "对讲";
			this.url = "url链接：";
			this.playback = "远程回放";
			this.nullMic = "您的电脑上没有麦克风，无法启动对讲";
			this.micStop = "没有开启FLASH插件麦克风";
			this.loginError = "登陆失败";
			this.talkback_flashMicStep1 = "第一步，请在视频窗上右键菜单中选择设置";
			this.talkback_flashMicStep2 = "第二步在设置窗口中 选择 “允许”，并勾选“记住”";
			this.talkback_flashMicStep3 = "关闭设置，并重新启动对讲";
			this.bufferTimeDesc = "说明：主要用于调整视频延时，当缓存的数据达到了最小缓冲时长时（默认为2秒），则会进行播放，当到了最大缓冲时长（默认为6秒），则进行快放。";
			this.minBufferTime = "最小缓冲时长：";
			this.maxBufferTime = "最大缓冲时长：";
			this.vedioStatus = "选中窗口播放状态";
			this.vedioEventStart = '选中事件：选中第';
			this.vedioEventEnd = '个窗口';
			this.vedioPlay = "当前选中窗口正在进行视频播放";
			this.vedioNoPlay = "当前选中窗口未进行视频播放";
		}
		function loadLang() {
			document.title = lang.videoExample;
			$('#getJsessionTitle').text(lang.geSessionId);
			$('#accountTitle').text(lang.userId);
			$('#passwordTitle').text(lang.password);
			$('#userLoginBtn').text(lang.login);
			$('#isPlay').text(lang.vedioStatus);
			$('#videoInitTitle').text(lang.videoInit);
			$('#videoInitBtn').text(lang.videoInit);
			$('#videoLangTitle').text(lang.videoLang);
			$('#videoWidthTitle').text(lang.videoWidth);
			$('#videoHeightTitle').text(lang.videoHeight);
			$('#windowNumberTitle').text(lang.windowNumber);
			$('#videoLiveTitle').text(lang.videoLive);
			$('#videoTitleTitle').text(lang.title);
			$('#videoStreamTitle').text(lang.stream);
			$('#videoPlayBtn').text(lang.play);
			$('#videoResetBtn').text(lang.reset);
			$('#monitorTitle').text(lang.monitor);
			$('#monitorBtn').text(lang.monitor);
			$('#talkbackTitle').text(lang.talkback);
			$('#talkbackBtn').text(lang.talkback);
			$('#playbackTitle').text(lang.playback);
			$('#urlTitle').text(lang.url);
			$('#playbackBtn').text(lang.playback);
			$('#bufferTimeDesc').text(lang.bufferTimeDesc);

			$('.minBufferTimeTitle').text(lang.minBufferTime);
			$('.maxBufferTimeTitle').text(lang.maxBufferTime);
			$('.serverIp').text(lang.serverIp);
			$('.serverPort').text(lang.serverPort);
			$('.settings').text(lang.settings);
			$('.windowIndex').text(lang.windowIndex);
			$('.jsessionId').text(lang.jsession);
			$('.devIdnoTitle').text(lang.devIdno);
			$('.devChannelTitle').text(lang.channel);
			$('.stop').text(lang.stop);
		}

		/**
		 * 初始化视频插件
		 **/
		function initPlayerExample() {
			for (var i = 0; i < 101; i++) {
				playingStatusArray.push(false);
			}
			//视频参数
			var params = {
				allowFullscreen : "true",
				allowScriptAccess : "always",
				bgcolor : "#FFFFFF",
				wmode : "transparent"
			};
			//赋值初始化为未完成
			isInitFinished = false;
			//视频插件宽度
			var width = 1000;
			//视频插件高度
			var hieght = 600;
			//初始化flash
			swfobject.embedSWF("player.swf", "cmsv6flash", width, hieght, "11.0.0", null, null, params, null);
			initFlash();
		}
		/**
		 * 插件初始化完成后执行
		 **/
		function initFlash() {
			//初始化插件语言
			var language = "cn.xml";
			swfobject.getObjectById("cmsv6flash").setLanguage(language);
			//先将全部窗口创建好
			swfobject.getObjectById("cmsv6flash").setWindowNum(36);
			//再配置当前的窗口数目
			var windowNum = 1;
			swfobject.getObjectById("cmsv6flash").setWindowNum(windowNum);
			//设置服务器信息
			var serverIp = "125.46.86.22";
			var serverPort = 6605;
			swfobject.getObjectById("cmsv6flash").setServerInfo(serverIp, serverPort);
			isInitFinished = true;
		}

		//播放实时视频
		function playLiveVideo() {
			if (!isInitFinished) { return; }
			//窗口下标
			var index = 0;
			//jsession会话号
			//设备号
			var devIdno = '${instrument.devIdno}';
			//通道号
			var channel = 1;
			//码流
			var stream = 0;
			//最小缓冲时长
			var minBufferTime = 2;
			if (minBufferTime != '') {
				swfobject.getObjectById("cmsv6flash").setBufferTime(index, minBufferTime);
			}
			//最大缓冲时长
			var maxBufferTime = 6;
			if (maxBufferTime != '') {
				swfobject.getObjectById("cmsv6flash").setBufferTimeMax(index, maxBufferTime);
			}

			//先停止视频窗口
			swfobject.getObjectById("cmsv6flash").stopVideo(index);
			//设置窗口标题
			var title = '${instrument.devIdno}';
			swfobject.getObjectById("cmsv6flash").setVideoInfo(index, title);
			//播放视频
			swfobject.getObjectById("cmsv6flash").startVideo(index, jsession, devIdno, channel, stream, true);
		}

		$(function(){
			userLogin();
			initPlayerExample();
			playLiveVideo();
		});
	</script>
</body>
</html>