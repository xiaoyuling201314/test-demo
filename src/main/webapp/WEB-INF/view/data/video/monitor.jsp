<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
	<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt"%>
	<% 
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path;
	String resourcesUrl = basePath + "/resources";
	%>
	<c:set var="webRoot" value="<%=basePath%>" />
	<c:set var="resourcesUrl" value="<%=resourcesUrl%>" />
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<script src="//libs.baidu.com/jquery/1.9.1/jquery.min.js" type="text/javascript" charset="utf-8"></script>
	<script src="${webRoot}/js/jq.getVideo.min.js" type="text/javascript" charset="utf-8"></script>
	<title></title>
	<style type="text/css">
		.video-wrap{height:500px;}
	</style>
</head>
<body>
	<div id="yst-video-box" style="width:800px;height: 450px;padding-top: 30px;margin: 0 auto;">
	</div>
	<script type='text/javascript'>
		+(function($) {
			$.fn.getVideo.ctrl = {
				//更多属性请参数上面说明部分
				msg: '${webRoot}/js/msg.json',
				swf: '${webRoot}/js/monitorFlashPlayerSN.swf',
				durationLimit:3000,
				//list:true,
				alert:true,
				ratio: 0.51,
				debug: true,
				logs: true,
				durationLimit:1000000,
				player: 1
			};
			$.fn.getVideo.callback = function(status) {
			switch(status) {
				case "onloadstart":
					console.log('加载视频中');
					break;
				case "onloadedmetadata":
					console.log('视频的元数据/视频信息已加载!');
					break;
				case "onplay":
					console.log('开始播放');
					break;
				case "onpause":
					console.log('暂停播放');
					break;
				case "onwaiting":
					console.log('视频缓冲中');
					break;
				case "onprogress":
					console.log('视频下载中');
					break;
				case "onerror":
					console.log('发生错误');
					break;
				case "onended":
					console.log('播放结束');
					break;
				case "onabort":
					console.log('放弃加载');
					break;
				default:
					break;
			}
			};
			//var dev=document.getElementById("dev").value;
			if('${video.dev}'==1){
				$('#yst-video-box').getVideo({
					ip: 'v9.cdn88.cn',
					user:'demo',
					password: '',
					dev: 'f445ce834bd6117e'
				});  
			}else{
				$('#yst-video-box').getVideo({
					ip: '${video.ip}',
					user:'${video.userName}',
					password: '${video.pwd}',
					dev: '${video.dev}'
				});  
			}
		})(jQuery);
	</script>
</body>
</html>