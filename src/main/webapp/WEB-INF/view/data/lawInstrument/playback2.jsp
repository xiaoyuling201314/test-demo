<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/common/resource.jsp"%>
<html>
<head>
<title>快检服务云平台</title>
<link rel="stylesheet" type="text/css" href="${webRoot}/plug-in/easyui-1.5.2/tree.css">
<style type="text/css">
	.layout-split-west {
		bottom: 50px;
	}
		#allmap {width: 100%;height: 100%;overflow: hidden;margin:0;font-family:"微软雅黑";}
		iframe{
        width:100%;
        height: 100%;
        position: absolute;
        right:0;
        left: 0;
        top:0px;
        bottom: 0;
        border:0;
        border:none;
      }
      .cs-search-box{
      	position:absolute;
      	right:0px;
      	top:0px;
      	z-index:1000;
      }
	</style>
</head>
<body class="easyui-layout">
	<div data-options="region:'north',border:false" style="top: 0px; border: none;">
		<div>
			<!-- 面包屑导航栏  开始-->
			<ol class="cs-breadcrumb">
				<li class="cs-fl"><img src="${webRoot}/img/set.png" alt="" /><a href="javascript:">视频监控</a></li>
				<li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
				<li class="cs-b-active cs-fl">执法记录仪</li>
			</ol>
			<!-- 面包屑导航栏  结束-->
			<div class="cs-search-box cs-fr">
				<!-- <form>
					<input class="cs-input-cont cs-fl focusInput" type="text" name="pointName" placeholder="请输入内容" />
					<input class="cs-search-btn cs-fl" onclick="javascript:datagridUtil.queryByFocus();" value="搜索">
					<div class="clearfix cs-fr" id="showBtn"></div>
				</form> -->
				<a onclick="history.back()" class="cs-monitor-close cs-menu-btn"><i class="icon iconfont icon-fanhui"></i>返回</a>
			</div>
		</div>
	</div>

	<div data-options="region:'center'">
		<div id="dataList"></div>
	</div>
	
	<!-- 大弹窗 -->
	<div class="cs-modal-box cs-hide" style="margin: 0 auto;">
		<h5 class="cs-monitor-title text-primary cs-fl">
			<!-- <i class="icon iconfont icon-dingwei cs-red-text"></i>&nbsp;<span id="videoName"></span>  -->
		</h5>
		<div class="cs-col-lg clearfix">
		<!-- 面包屑导航栏  开始-->
		<ol class="cs-breadcrumb cs-fl">
			<li class="cs-fl"><img src="${webRoot}/img/set.png" alt="" />
			<li class="cs-fl">视频监控</li>
			<li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
			<li class="cs-fl">执法记录仪</li>
			<li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
			<li class="cs-b-active cs-fl">视频回放</li>
		</ol>

		<!-- 面包屑导航栏  结束-->
		<div class="cs-search-box cs-fr">
			<div class="cs-fr cs-ac ">
				<a onclick="returnBack();" class="cs-monitor-close cs-menu-btn"><i class="icon iconfont icon-fanhui"></i>返回</a>
			</div>
		</div>
	</div>
		
		<!-- <iframe id="iframe1" style="height:900px;width: 1000px;padding: 40px;margin: 0 auto;"></iframe> -->
		<div style="text-align:center;"><video id="video" autoplay="autoplay" muted   class="vjs-tech" preload="none" data-setup="{}" tabindex="-1" controls="controls" width="640" height="480"></video>
		</div>
	</div>
	
	<!-- 引用模态框 -->
	<%@include file="/WEB-INF/view/common/confirm.jsp"%>
	<!-- JavaScript -->
	<script src="${webRoot}/js/datagridUtil.js"></script>
	<script type="text/javascript">
		var edit=0;
		var editObj;
		var del=0;
		var delObj;
		var monitor=0;
		var monitorObj;
		var playback=0;
		var playbackObj;
		for (var i = 0; i < childBtnMenu.length; i++) {
			if (childBtnMenu[i].operationCode == "1408-2") {
				monitor=1;
				monitorObj=childBtnMenu[i];
			}
		}

		var op = {
			tableId : "dataList", //列表ID
			tableAction : "${webRoot}/data/lawInstrument/playbackDatagrid.do?instrumentId=${instrumentId}", //加载数据地址
			parameter : [ //列表拼接参数
			{
				columnCode : "devidno",
				columnName : "设备号",
				query : 1
			}, {
				columnCode : "file",
				columnName : "文件名"
			}, {
				columnCode : "time",
				columnName : "时间"
			}/* , {
				columnCode : "fileSize",
				columnName : "大小(MB)"
			}  */],
			funBtns : [//操作列按钮 
			{
				show : monitor,
				style : monitorObj,
				action : function(id) {
					viewMonitor(id);
				}
			}]
		};
		datagridUtil.initOption(op);

		datagridUtil.query();

		//查看执法仪直播
		function viewMonitor(id){
			$.ajax({
				url:'${webRoot}/data/lawInstrument/viewPlayback?id='+id,
				success:function(data){
					$("#video").attr("src", "${webRoot}/resources/"+data.file);
					$('.cs-modal-box').show();
				}
			});
		}
		//关闭监控摄像头，返回list
		function returnBack(){
			$("#iframe1").attr("src", "");
			$('.cs-modal-box').hide();
		}
		
	</script>
</body>
</html>
