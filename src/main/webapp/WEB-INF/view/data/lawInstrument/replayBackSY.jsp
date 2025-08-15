<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/common/resource.jsp"%>
<%@page import="java.util.Date"%>
<html>
<head>
<title>快检服务云平台</title>
<link rel="stylesheet" type="text/css" href="${webRoot}/plug-in/easyui-1.5.2/tree.css">
<link rel="stylesheet" href="${webRoot}/plug-in/dateForsy/layui/css/layui.css" />
<link rel="stylesheet" href="${webRoot}/plug-in/dateForsy/css/public.css" />
<link rel="stylesheet" href="${webRoot}/plug-in/dateForsy/css/getdate.css" />
<style type="text/css">
	.cs-stat-search .cs-input-cont[type=text] {
		width: 85px;
		margin-left: 0;
	}

	.stock_info ul li {
		overflow: hidden;
	}

	.daytwo {
		display: none !important;
	}

	.cs-tb-box {
		height: 100%;
	}

	.warp_box {
		width: 100%;
		/* min-width: 280px; */
		margin: 0;
		padding: 0;
		border-top: 1px solid #ddd;
		height: auto;
		position: absolute;
		top: 189px;
		bottom: 0;
	}

	.date_box {
		padding: 5px 10px 10px 10px;
		min-height: auto;
		border-radius: 5px;
		border: 0;
		box-shadow: none;
		width: 220px;
		margin: 0 auto;
	}

	.date_box .day_item .day_list .day_center {
		line-height: 18px;
		width: 20px;
		height: 20px;
		padding: 0;
	}

	.date_box .day_item .day_list .day_center .dayone {
		line-height: 18px;
		font-size: 12px;
	}

	.date_box .date_center {
		padding: 0;
	}

	.date_box .date_top .date_action {
		margin: 0;
		display: flex;
		align-items: center;
		justify-content: center;
		flex: 1;
		text-align: center;
	}

	.date_box .date_top .date_action span {
		height: 26px;
		line-height: 26px;
		width: 110px;
	}

	.date_box .date_top {
		padding: 5px 10px;
		justify-content: space-around;
		align-items: center;
	}

	.date_box .date_top .date_action i {
		color: #006fce;
	}

	.replay-video-list {
		border-top: 1px solid #ddd;

	}

	.replay-video-title {
		line-height: 30px;
		padding: 0 5px;
		background: #f1f1f1;
		font-size: 12px;
		font-weight: bold;
	}

	.replay-video-file {
		position: absolute;
		top: 196px;
		left: 0;
		bottom: 0;
		overflow: auto;
		width: 100%;
	}

	.replay-video-file li {
		font-size: 14px;
		line-height: 36px;
		height: 38px;
		border-bottom: 1px dotted #D3D7DE;
		padding-left: 10px;
	}

	.replay-video-file li:hover {
		cursor: pointer;
	}

	.replay-video-file .iconfont {
		color: #f6aa06;
	}

	.video-center {
		align-items: center;
		justify-content: center;
		flex: 1;
		flex-direction: column;
	}

	.video-center .video-boxs {
		border: 1px solid #ddd;
	}

	.cs-search-btn {
		width: 40px;
	}

	.video-title {
		font-size: 18px;
		font-weight: bold;
		margin-bottom: 10px;
	}

	.date_box .day_item .day_list {
		height: 20px;
		padding: 0;
	}

	.stock_info {
		position: absolute;
		top: 40px;
		height: 150px;
		overflow: auto;
	}

	.stock_info ul li .title {
		height: 36px;
	}

	.stock_info ul li.active {
		background: transparent;
	}

	.cs-stat-search {
		padding: 5px;
	}

	.cs-search-filter,
	.cs-search-margin {
		margin: 0;
	}
</style>

</head>
<body class="easyui-layout">


<div data-options="region:'west',split:true,title:'检测点'" style="width:260px; overflow: hidden;">
	<div class="search-result">
		<div class="cs-stat-search" style="display: flex;flex-direction: row;justify-content: space-around;">
			<div class="cs-all-ps">
				<div class="cs-input-box" style="width:110px">
					<input type="text"  name="departName" id="departName" readonly="readonly" value="${report.departName }" title="${report.departName }" style="height: 30px;overflow: hidden; white-space: nowrap; text-overflow: ellipsis;width: 110px;padding-right: 0;">
				</div>
			</div>
			<div class="cs-search-filter clearfix">

				<input class="cs-input-cont cs-fl focusInput" type="text" name="pointName" id="pointName"
					   autocomplete="off" placeholder="请输入检测点名称">
				<input type="button" onclick="queryByFocus();" class="cs-search-btn cs-fl" href="javascript:;"
					   value="搜索">
			</div>
		</div>
	</div>
	<div class="stock_info">
		<!--左侧检测点列表-->
		<ul id="type">

		</ul>
	</div>
	<%--左侧视频回放日期列表--%>
	<div class="warp_box">
		<div class="replay-video-title">视频回放</div>
		<div class="date_box">
			<div class="cs-input-box" style="width:200px">
			<input name="checkDate" class="cs-time" autocomplete="off" type="text" onClick="WdatePicker({startDate:'%y-%M-%d %H:%m:%s',maxDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true})"
				  style="height: 30px;overflow: hidden; white-space: nowrap; text-overflow: ellipsis;padding-right: 0;"/>
			</div>
			<%--<div class="layui-row layui-col-space10">

				<div class="date_center">
					<div class="clearfix date_top is-flex">
						<!-- <div class="fl tody"></div> -->
						<!-- <div id="">
                            <i class="iconfont icon-kaoqin text-primary"></i> 日期查询
                        </div> -->
						<div class="date_action fl">
							<i class="layui-icon layui-icon-triangle-r icon_left"></i>
							<span class="today_span"></span>
							<i class="layui-icon layui-icon-triangle-r icon_right"></i>
						</div>
						<!-- <div class="rigth_action fr">
                            <span class="current"> 今天 </span>

                        </div> -->
					</div>
					<div class="clearfix date_header">
						<div class="week_item">日</div>
						<div class="week_item">一</div>
						<div class="week_item">二</div>
						<div class="week_item">三</div>
						<div class="week_item">四</div>
						<div class="week_item">五</div>
						<div class="week_item">六</div>
					</div>
					<div class="clearfix day_item" id="day_item">

					</div>
				</div>

			</div>--%>
		</div>
		<%--视频文件列表--%>
		<div class="replay-video-list">
			<div class="replay-video-file" style="top: 76px;">
				<ul class="video-list">

				</ul>
			</div>
		</div>

	</div>
</div>

<div data-options="region:'north',border:false" style="height:41px; border:none; overflow: hidden;">
	<div class="cs-col-lg clearfix" style="border-bottom:none;">
		<!-- 面包屑导航栏  开始-->
		<ol class="cs-breadcrumb">
			<li class="cs-fl">
				<img src="${webRoot}/public/img/set.png" alt="" />
				<a href="javascript:;">视频监控</a>
			</li>
			<li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
			<li class="cs-b-active cs-fl">视频回放
			</li>
		</ol>
		<!-- 面包屑导航栏  结束-->
		<%--<div class="cs-search-box cs-fr">
			<form action="">

				<div class="cs-search-filter clearfix cs-fl">
					<input class="cs-input-cont cs-fl" type="text" placeholder="请输入内容" />
					<input type="submit" class="cs-search-btn cs-fl" href="javascript:;" value="搜索">
				</div>

			</form>

		</div>--%>
	</div>

</div>
<div data-options="region:'center'">
	<div class="cs-tb-box is-flex" style="flex-direction: row;">



		<div class="video-center is-flex">
			<div class="video-title"><span class="play-pointName"></span> <span class="play-time"></span></div>
			<div class="video-boxs" style="width:80%;max-width: 800px;">
				<video id="videoid" width="" height="" controls="controls" style="width:100%">
					<source id="video_path"  src="" type="video/mp4" autoplay />
				</video>
			</div>
		</div>



	</div>

</div>
<!-- 引用模态框 -->
<%@include file="/WEB-INF/view/common/confirm.jsp"%>
<%@include file="/WEB-INF/view/detect/depart/selectDepartModel.jsp"%>
<script src="${webRoot}/plug-in/dateForsy/layui/layui.js"></script>
<script src="${webRoot}/plug-in/dateForsy/js/getData.js"></script>
<script src="${webRoot}/plug-in/dateForsy/js/date_week.js"></script>
<script type="text/javascript">
	var  departId=${report.departId};
	$(function(){
		$("input[name='checkDate']").val(new Date().format("yyyy-MM-dd"));
		loadPoints(departId);
		initVideoList();
	});
	function initVideoList(dateStr){
		if(dateStr==undefined){
			dateStr=new Date().format("yyyy-MM-dd");
		}
		$(".video-list").html();
		for (let i = 13; i <17; i++) {
			let dealDate=dateStr+" "+i+":00"
			let htmlStr='<li data-time="'+dealDate+'" onclick="replayVideo(this)"> <i class="iconfont icon-huifang" ></i>'+dealDate+'</li>';
			$(".video-list").append(htmlStr);
		}

	}
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
		loadPoints(id);
	}
	//根据机构Id查询检测点
	function loadPoints(departId){
		$.ajax({
			url: "${webRoot}/video/surveillance/selectPointByDepartId.do",
			type: "POST",
			data: {
				"departId": departId
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
		}else{
			$("#showBtn").removeClass("cs-hide");
			var json = eval(data);
			$.each(json, function(index, item) {
				htmlStr+='<li name="type" data-type='+item.id+' data-pointName="'+item.pointName+'" data-departId='+item.departId+' onclick="selectPoint(this)" >';
				htmlStr+='<div class="title"><a href="javascript:;" title='+item.pointName+'>';

				if(item.pointId && (item.videoType || item.videoType == 0) && item.videoType != 6){
					htmlStr+= '<i style="padding-left: 2px" class="icon iconfont icon-shexiangtou text-primary" title="已配置"></i>' + item.pointName;
				}else {
					htmlStr+= '<i style="padding-left: 2px" class="icon iconfont icon-shexiangtou text-gray" title="未配置"></i>' + item.pointName;
				}
				htmlStr+=' </a></div><div class="arrow"><i class="icon iconfont icon-you"></i></div></li>';
			});
			$("#type").append(htmlStr);
			//默认选中第一个检测点并加载摄像头数据
			if(htmlStr!=""){
				$("#type li:first-child").addClass("active");//第一次进来就默认选中第一个
				let departId= $("#type li:first-child").attr("data-departId");
				let pointName=$("#type li:first-child").attr("data-pointName");
				let playTime=$(".video-list").find("li:first-child").attr("data-time");
				$(".play-pointName").html(pointName);
				$(".play-time").html(playTime);
				if(departId==349){//标段二
					document.getElementById("videoid").src="${webRoot}/plug-in/dateForsy/video/标段二_DD49D000_ABC123_20220505_133554_0002.mp4" ;
				}else if(departId==350){//标段三
					document.getElementById("videoid").src="${webRoot}/plug-in/dateForsy/video/标段三_DD49D000_ABC123_20220505_134557_0004.mp4" ;
				}else{//默认，标段一
					document.getElementById("videoid").src="${webRoot}/plug-in/dateForsy/video/标段一_DD49D000_ABC123_20220505_134056_0003.mp4" ;
				}
				document.getElementById("videoid").play();
			}
		}
	}
	//播放视频
	function selectPoint(obj) {
		$.each($("li[name='type']"), function (index, item) {
			$(item).attr("class", "");
		});
		let departId = $(obj).attr("data-departId");
		let pointName=$(obj).attr("data-pointName");
		let playTime=$(".video-list").find("li:first-child").attr("data-time");
		$(".play-pointName").html(pointName);
		$(".play-time").html(playTime);
		if(departId==349){//标段二
			document.getElementById("videoid").src="${webRoot}/plug-in/dateForsy/video/标段二_DD49D000_ABC123_20220505_133554_0002.mp4" ;
		}else if(departId==350){//标段三
			document.getElementById("videoid").src="${webRoot}/plug-in/dateForsy/video/标段三_DD49D000_ABC123_20220505_134557_0004.mp4" ;
		}else{//默认，标段一
			document.getElementById("videoid").src="${webRoot}/plug-in/dateForsy/video/标段一_DD49D000_ABC123_20220505_134056_0003.mp4" ;
		}
		document.getElementById("videoid").play();
	}
	//点击事件列表播放视频
	function replayVideo(obj){
		let playTime= $(obj).attr("data-time");
		$(".play-time").html(playTime);
		if(departId==349){//标段二
			document.getElementById("videoid").src="${webRoot}/plug-in/dateForsy/video/标段二_DD49D000_ABC123_20220505_133554_0002.mp4" ;
		}else if(departId==350){//标段三
			document.getElementById("videoid").src="${webRoot}/plug-in/dateForsy/video/标段三_DD49D000_ABC123_20220505_134557_0004.mp4" ;
		}else{//默认，标段一
			document.getElementById("videoid").src="${webRoot}/plug-in/dateForsy/video/标段一_DD49D000_ABC123_20220505_134056_0003.mp4" ;
		}
		document.getElementById("videoid").play();
	}
</script>
</body>

</html>
