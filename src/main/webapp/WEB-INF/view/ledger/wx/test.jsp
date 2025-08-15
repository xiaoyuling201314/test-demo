<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt"%>
<%@page import="java.util.Date"%>
<%@include file="/WEB-INF/view/ledger/wx/ledgerWxResource.jsp"%>

<c:set var="webRoot" value="<%=basePath%>" />
<c:set var="resourcesUrl" value="<%=resourcesUrl%>" />
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
<title>台账管理</title>
<script type="text/javascript" src="${webRoot}/js/jquery-1.11.3.min.js"></script>
<script type="text/javascript" src="${webRoot}/js/dateUtil.js"></script>
<script src="${webRoot}/css/weixin/js/mui.min.js"></script>

<link href="${webRoot}/css/weixin/js/picker/css/mui.dtpicker.css" rel="stylesheet" />
<link href="${webRoot}/css/weixin/js/picker/css/mui.picker.css" rel="stylesheet" />
<link href="${webRoot}/css/weixin/js/picker/css/mui.poppicker.css" rel="stylesheet" />
<%--  <link rel="stylesheet" href="${webRoot}/app/css/index.css"> --%>

<style>
.html, .body {
	background-color: #efeff4;
}

.title {
	margin: 20px 15px 10px;
	color: #6d6d72;
	font-size: 15px;
	padding-bottom: 51px;
}

.ui-add-btn {
	position: fixed;
	bottom: 40px;
	right: 20px;
	height: 30px;
	width: 30px;
}

.ui-add-btn a {
	font-size: 40px;
}

.mui-btn-blue {
	width: auto;
}

input[type=text] {
	line-height: 21px;
	width: 100%;
	height: 40px;
	margin-bottom: 15px;
	padding: 10px 15px;
	-webkit-user-select: text;
	border: 1px solid rgba(0, 0, 0, .2);
	border-radius: 3px;
	outline: 0;
	background-color: #fff;
	-webkit-appearance: none;
}

.mui-input-row {
	overflow: inherit;
}

.mui-input-group:after, .mui-input-group:before, .mui-input-group .mui-input-row:after {
	height: 0;
}

.tabClick {
	background: #f3f3f3;
	overflow: hidden
}

.tabClick li {
	height: 40px;
	line-height: 40px;
	width: 25%;
	float: left;
	text-align: center
}

.tabClick li.active {
	color: #099;
	transition: 0.1s;
	font-weight: bold
}

.tabCon {
	overflow: hidden
}

.tabBox {
	position: relative
}

.tabList {
	word-break: break-all;
	width: 100%;
	float: left;
	line-height: 100px;
	text-align: center;
	color: #D3D3D3;
	font-size: 36px;
	font-family: "Arial Black"
}

.lineBorder {
	height: 2px;
	overflow: hidden;
	border-bottom: 1px solid #099;
	background: #f3f3f3
}

.lineDiv {
	background: #099;
	height: 2px;
	width: 25%;
}

.btn-refresh {
	padding: 10px;
	width: 100%;
	text-align: center;
	font-size: 12px;
	color: #999;
}

.mui-content-padded {
	height: 42px;
}

.data-time {
	text-align: center;
	border: 0;
}

.mui-content-padded {
	border-bottom: 1px solid #ddd;
	margin:0;
}
.mui-control-content{
	border-top:1px solid #ddd;
	border-bottom: 1px solid #ddd;
}
.mui-position-center{
	position:absolute;
	left:50%;
	top:10px;
	margin-left:35px;
	z-index: 100;
}
.mui-ellipsis{
	overflow: auto; 
	line-height:22px;
}
.mui-table-view-cell{
	margin-bottom:0;
}
input[type=color], input[type=date], input[type=datetime-local], input[type=datetime], input[type=email], input[type=month], input[type=number], input[type=password], input[type=search], input[type=tel], input[type=text], input[type=time], input[type=url], input[type=week], select, textarea{
	width: auto;
	margin-bottom: 0;
}
input.ui-search-time{
    width: 140px;
    height: 34px;
    border: 1px solid #ddd;
    border-radius: 4px;
    padding: 0 4px;
    text-align: center;
} 

input.ui-search-time::-webkit-clear-button{
	display:none;
}
input.ui-search-time::-webkit-inner-spin-button{
	display:none;
}

.ui-dtpicker .ui-day-pre,.ui-dtpicker .ui-day-next{
	margin-top: 8px;
}
ul{
	background:rgba(0,0,0,0);
}
</style>
</head>

<body>
	<!--页面主结构开始-->
	<div id="app" class="mui-views">
		<div class="mui-view">
			<div class="mui-navbar"></div>
			<div class="mui-pages"></div>
		</div>
	</div>
	<!--单页面开始-->
	<div id="setting" class="mui-page">
		<!--页面标题栏开始-->
		<div class="mui-navbar-inner mui-bar mui-bar-nav">
			<h1 class="mui-center mui-title"><img src="${webRoot}/img/wx/logo.png"  height="36px" style="margin-right:5px; vertical-align:middle; margin-top:-5px;" />端州区食用农产品溯源系统</h1>
			<a class="mui-icon mui-icon-contact mui-icon-icon-contact-filled mui-pull-right" href="${webRoot}/ledger/wx/userCenter.do"></a>
		</div>
		<!--页面标题栏结束-->
		<div class="mui-page-content"></div>
	</div>
	<div class="mui-content" style="padding: 44px 0 0 0;">
		<div id="segmentedControl" class="mui-segmented-control">
			<a class="mui-control-item mui-active" href="#item1"> 进货台账 </a> <a class="mui-control-item" id="saleList" style="display: none" href="#item2"> 销售台账 </a>
		</div>
	</div>
	<div id="item1" class="mui-control-content mui-active">
		<div class="mui-content-padded">
			<div class="ui-dtpicker clearfix">
              <a href="javascript:" style="display:inline-block;" onclick="searchData(-1,1)" class="ui-day-pre">&lt; 前一天</a>
             <button id='result' style="width: 100px; display:inline-block; float:none; height:34px; border:1px solid #ddd;" data-options='{"type":"date","beginYear":2016,"endYear":2022}' class="data-time btn mui-btn mui-btn-block data-btn">2018-01-01</button>
              <a href="javascript:" style="display:inline-block;" onclick="searchData(1,1)" class="ui-day-next">后一天 &gt; </a>
            </div>
			<a href="${webRoot}/ledger/wx/editStock.do"><span class="mui-icon mui-icon-plus mui-positon  mui-pull-right" style="font-size: 28px; top: 4px; padding:4px;"></span></a>
		</div>
		<div id="tableDatas">
		</div>
		<div class="btn-refresh" id="stockStop" style="display: none">暂无更多数据</div>
		<div class="btn-refresh" id="stockLoad" onclick="getStockData();" style="display: none">
			点击加载 <span class="mui-icon mui-icon-arrowdown"></span>
		</div>
	</div>
	<div id="item2" class="mui-control-content">
		<div class="mui-content-padded">
			<div class="ui-dtpicker clearfix">
              <a href="javascript:" style="display:inline-block;" onclick="searchData(-1,2)" class="ui-day-pre">&lt; 前一天</a>
             <button id='result2' style="width: 100px; display:inline-block; float:none; height:34px; border:1px solid #ddd;" data-options='{"type":"date","beginYear":2016,"endYear":2022}' class="data-time btn2 mui-btn mui-btn-block data-btn">2018-01-01</button>
              <a href="javascript:" style="display:inline-block;" onclick="searchData(1,2)" class="ui-day-next">后一天 &gt; </a>
            </div>
			<a href="${webRoot}/ledger/wx/editSale.do"><span class="mui-icon mui-icon-plus mui-positon  mui-pull-right" style="font-size: 28px; top: 4px; padding:4px;"></span></a>
		</div>
		<div id="tableDatas2"></div>
		<div class="btn-refresh" id="saleStop" style="display: none">暂无更多数据</div>
		<div class="btn-refresh" id="saleLoad" onclick="getSaleData(); " style="display: none">
			点击加载 <span class="mui-icon mui-icon-arrowdown"></span>
		</div>
	</div>
	<!-- 弹出搜索 -->
	<div class="mui-postion" style="display: none;">
		<header class="mui-bar mui-bar-nav">
			<a class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left"></a>
			<h1 class="mui-title">搜索</h1>
		</header>
		<div class="mui-content" style="padding-top: 35px;">
			<div class="mui-content-padded" style="padding: 10px;">
				<h5>搜索内容</h5>
				<input type="text" />
				<h5>选择日期</h5>
				<button id="result" data-options="{&quot;type&quot;:&quot;date&quot;,&quot;beginYear&quot;:2014,&quot;endYear&quot;:2016}" class="btn mui-btn mui-btn-block" style="height: 40px; text-align: left;"></button>
			</div>
			<div style="text-align: center;">
				<button type="button" class="mui-btn mui-btn-primary" onclick="return false;">确认</button>
			</div>
		</div>
	</div>
	<input id="pageno" type="hidden" name="page" value="1" />
	<script src="${webRoot}/css/weixin/js/util.js"></script>
	<script src="${webRoot}/css/weixin/js/picker/js/mui.picker.js"></script>
	<script src="${webRoot}/css/weixin/js/picker/js/mui.poppicker.js"></script>
	<script src="${webRoot}/css/weixin/js/picker/js/mui.dtpicker.js"></script>

	<script type="text/javascript">
	var stockpages=1;
	var allstockpages=1;
	var salepages=1;
	var allsalepages=1;
			(function() {
				mui.init({
					swipeBack: true //启用右滑关闭功能
				});
				function alert1() {
				}
				mui.plusReady(function() {
					var self = plus.webview.currentWebview();
					var	leftPos = Math.ceil((window.innerWidth - 60) / 2); // 设置凸起大图标为水平居中
					var drawNativeIcon = util.drawNative('icon', {
						bottom: '5px',
						left: leftPos + 'px',
						width: '60px',
						height: '60px'
					}, [{
						tag: 'rect',
						id: 'bg',
						position: {
							top: '1px',
							left: '0px',
							width: '100%',
							height: '100%'
						},
						rectStyles: {
							color: '#fff',
							radius: '50%',
							borderColor: '#ccc',
							borderWidth: '1px'
						}
					}, {
						tag: 'rect',
						id: 'bg2',
						position: {
							bottom: '-0.5px',
							left: '0px',
							width: '100%',
							height: '45px'
						},
						rectStyles: {
							color: '#fff'
						}
					}, {
						tag: 'rect',
						id: 'iconBg',
						position: {
							top: '5px',
							left: '5px',
							width: '50px',
							height: '50px'
						},
						rectStyles: {
							color: '#d74b28',
							radius: '50%'
						}
					}, {
						tag: 'font',
						id: 'icon',
						text: '\ue600', //此为字体图标Unicode码'\e600'转换为'\ue600'
						position: {
							top: '0px',
							left: '5px',
							width: '50px',
							height: '100%'
						},
						textStyles: {
							fontSrc: '_www/fonts/iconfont.ttf',
							align: 'center',
							color: '#fff',
							size: '30px'
						}
					}]);
					// append 到父webview中
					self.append(drawNativeIcon);
					//自定义监听图标点击事件
					var active_color = '#fff';
					drawNativeIcon.addEventListener('click', function(e) {
						mui.alert('你点击了图标，你在此可以打开摄像头或者新窗口等自定义点击事件。', '悬浮球点击事件');
						// 重绘字体颜色
						if(active_color == '#fff') {
							drawNativeIcon.drawText('\ue600', {}, {
								fontSrc: '_www/fonts/iconfont.ttf',
								align: 'center',
								color: '#000',
								size: '30px'
							}, 'icon');
							active_color = '#000';
						} else {
							drawNativeIcon.drawText('\ue600', {}, {
								fontSrc: '_www/fonts/iconfont.ttf',
								align: 'center',
								color: '#fff',
								size: '30px'
							}, 'icon');
							active_color = '#fff';
						}

					});
					// 中间凸起图标绘制及监听点击完毕

					// 创建子webview窗口 并初始化
					var aniShow = {};
					util.initSubpage(aniShow);
					
					var 	nview = plus.nativeObj.View.getViewById('tabBar'),
						activePage = plus.webview.currentWebview(),
						targetPage,
						subpages = util.options.subpages,
						pageW = window.innerWidth,
						currIndex = 0;
					
						
					/**
					 * 根据判断view控件点击位置判断切换的tab
					 */
					nview.addEventListener('click', function(e) {
						var clientX = e.clientX;
						if(clientX > 0 && clientX <= parseInt(pageW * 0.25)) {
							currIndex = 0;
						} else if(clientX > parseInt(pageW * 0.25) && clientX <= parseInt(pageW * 0.45)) {
							currIndex = 1;
						} else if(clientX > parseInt(pageW * 0.45) && clientX <= parseInt(pageW * 0.8)) {
							currIndex = 2;
						} else {
							currIndex = 3;
						}
						// 匹配对应tab窗口	
						if(currIndex > 0) {
							targetPage = plus.webview.getWebviewById(subpages[currIndex - 1]);
						} else {
							targetPage = plus.webview.currentWebview();
						}

						if(targetPage == activePage) {
							return;
						}

						if(currIndex !== 3) { 
							//底部选项卡切换
							util.toggleNview(currIndex);
							// 子页面切换
							util.changeSubpage(targetPage, activePage, aniShow);
							//更新当前活跃的页面
							activePage = targetPage;
						} else {
							//第四个tab 打开新窗口
							plus.webview.open('html/new-webview.html', 'new', {}, 'slide-in-right', 200);
						}
					});
				});
			})();
		</script>
	<script type="text/javascript">
		(function($) {
			$.init();
			var result = $('#result')[0];
			var btns = $('.btn');
			btns.each(function(i, btn) {
				btn.addEventListener('tap', function() {
					var optionsJson = this.getAttribute('data-options') || '{}';
					var options = JSON.parse(optionsJson);
					var id = this.getAttribute('id');
					/*
					 * 首次显示时实例化组件
					 * 示例为了简洁，将 options 放在了按钮的 dom 上
					 * 也可以直接通过代码声明 optinos 用于实例化 DtPicker
					 */
					var picker = new $.DtPicker(options); 
					picker.show(function(rs) {
						/*
						 * rs.value 拼合后的 value
						 * rs.text 拼合后的 text
						 * rs.y 年，可以通过 rs.y.vaue 和 rs.y.text 获取值和文本
						 * rs.m 月，用法同年
						 * rs.d 日，用法同年
						 * rs.h 时，用法同年
						 * rs.i 分（minutes 的第二个字母），用法同年
						 */
						result.innerText = rs.text;
						/* 
						 * 返回 false 可以阻止选择框的关闭
						 * return false;
						 */
						/*
						 * 释放组件资源，释放后将将不能再操作组件
						 * 通常情况下，不需要示放组件，new DtPicker(options) 后，可以一直使用。
						 * 当前示例，因为内容较多，如不进行资原释放，在某些设备上会较慢。
						 * 所以每次用完便立即调用 dispose 进行释放，下次用时再创建新实例。
						 */
						picker.dispose();
						 stockpages=1;
						 allstockpages=1;
						getStockData();
					});
				}, false);
			});
		})(mui);


		(function($) {
			$.init();
			var result2 = $('#result2')[0];
			var btns2 = $('.btn2');
			btns2.each(function(i, btn2) {
				btn2.addEventListener('tap', function() {
					var optionsJson = this.getAttribute('data-options') || '{}';
					var options = JSON.parse(optionsJson);
					var id = this.getAttribute('id');
					/*
					 * 首次显示时实例化组件
					 * 示例为了简洁，将 options 放在了按钮的 dom 上
					 * 也可以直接通过代码声明 optinos 用于实例化 DtPicker
					 */
					var picker = new $.DtPicker(options);
					picker.show(function(rs) {
						/*
						 * rs.value 拼合后的 value
						 * rs.text 拼合后的 text
						 * rs.y 年，可以通过 rs.y.vaue 和 rs.y.text 获取值和文本
						 * rs.m 月，用法同年
						 * rs.d 日，用法同年
						 * rs.h 时，用法同年
						 * rs.i 分（minutes 的第二个字母），用法同年
						 */
						result2.innerText =  rs.text;
						/* 
						 * 返回 false 可以阻止选择框的关闭
						 * return false;
						 */
						/*
						 * 释放组件资源，释放后将将不能再操作组件
						 * 通常情况下，不需要示放组件，new DtPicker(options) 后，可以一直使用。
						 * 当前示例，因为内容较多，如不进行资原释放，在某些设备上会较慢。
						 * 所以每次用完便立即调用 dispose 进行释放，下次用时再创建新实例。
						 */
						picker.dispose();
						 salepages=1;
						 allsalepages=1;
						 getSaleData();
					});
				}, false);
			});
		})(mui);
		</script>
	<script type="text/javascript">
		
$(function(){
	var now = new Date();
	var managementType='${ledgerUser.managementType}';
	if(managementType==1){//零售市场
		$("#result").text(now.format("yyyy-MM-dd"));
		getStockData();
	}else if(managementType!='' && managementType==0){//批发市场
		$("#saleList").show();
		$("#result").text(now.format("yyyy-MM-dd"));
		getStockData();
		$("#result2").text(now.format("yyyy-MM-dd"));
		getSaleData();
	}else{//未获取到市场类型
		$("#saleList").show();
		$("#result").text(now.format("yyyy-MM-dd"));
		getStockData();
		$("#result2").text(now.format("yyyy-MM-dd"));
		getSaleData();
	}
	var listType='${listType}';
	if(listType=='sale'){
	$("#saleList,#item2").addClass('mui-active').siblings().removeClass('mui-active');
	}
	
});
	//前后一天点击事件 type=1是进货2销售
function searchData(add,type){
		if(type==1){//进货
				var day = $("#result").text();
			if(''!= add){
				day = daysJian(day,add);
				$("#result").text(day);
			}
			stockpages=1;
			getStockData(1);
		}else{//销售
			var day = $("#result2").text();
		if(''!= add){
			day = daysJian(day,add);
			$("#result2").text(day);
		}
		salepages=1;
		getSaleData(1);
		}
}
	function getStockData(dateChange){
		var date=$("#result").text();
		if(!dateChange){
			if(stockpages>allstockpages){
				$("#stockLoad").hide();
				$("#stockStop").show();
				return;
			}
			if(stockpages==1){
				$("#tableDatas").empty("");
				}
		}else{//这是上下一天
			$("#tableDatas").empty("");
		}
		var  opeId="${ledgerUser.opeId}";
		var  regId="${ledgerUser.regId}";
		$.ajax({
	        type: "POST",
	        url: '${webRoot}'+"/ledger/wx/getStockData.do?businessId="+opeId+"&regId="+regId+"&startDate="+date,
	        data: {
	        	pageNo:stockpages,
	        	pageSize:10
	        },
	        dataType: "json",
	        success: function(data){
	        	if(data && data.success){
		        	var obj=data.obj.results;
		        	if(obj.length==0){
				        		$("#stockLoad").hide();
				    			$("#stockStop").show();

		        	}else{
				        	var html = "";
				        	$.each(obj, function(index, item) {
								var d=/\d{4}-\d{1,2}-\d{1,2}/g.exec(obj[index].stockDate);
								html += '<a href="${webRoot}/ledger/wx/editStock.do?id='+equalsNull(obj[index].id)+'"><ul class="mui-table-view mui-table-view-striped mui-table-view-condensed">';
				        		html += '<li class="mui-table-view-cell"><div class="mui-table"> <div class="mui-table-cell mui-col-xs-8"><h4 class="mui-ellipsis">'+equalsNull(obj[index].foodName) +'</h4>';
				        		html += ' </div><div class="mui-table-cell mui-col-xs-6 mui-text-right"><span class="mui-h5">'+equalsNull(d) +'</span> </div></div>';
				        		html += '<div class="mui-table"> <div class="mui-table-cell mui-col-xs-12"><p>进货量：'+equalsNull(obj[index].stockCount)+equalsNull(obj[index].size)+'</p>';
				        		html += '<p>供货商：'+equalsNull(obj[index].param1) +'&nbsp'+equalsNull(obj[index].supplier)+'</p> </div> </div> </div> </li></ul></a>';
								});
								$("#tableDatas").append(html);
								allstockpages=data.obj.pageCount;
								stockpages=stockpages+1;
								$("#stockLoad").show();
				    			$("#stockStop").hide();
				        		}
	        			}
				}
	    });
		
	}
		function getSaleData(dateChange){
				var date=$("#result2").text();
				var  opeId="${ledgerUser.opeId}";
				var  regId="${ledgerUser.regId}";
				if(!dateChange){
					if(salepages>allsalepages){
					$("#saleLoad").html("暂无更多数据!");
					return;
					}
					if(salepages==1){
						$("#tableDatas2").empty("");
					}
				}else{//这是上下一天
					$("#tableDatas2").empty("");
				}
			$.ajax({
		        type: "POST",
		        url: '${webRoot}'+"/ledger/wx/getSaleData.do?businessId="+opeId+"&regId="+regId+"&startDate="+date,
		        data: {
		        	pageNo:salepages,
		        	pageSize:10
		        },
		        dataType: "json",
		        success: function(data){
	        	if(data && data.success){
		        	var obj=data.obj.results;
		        	if(obj.length==0){
		        		$("#saleLoad").hide();
		    			$("#saleStop").show();

		        	}else{
				        	var salehtml = "";
					        	$.each(obj, function(index, item) {
					        		var d=/\d{4}-\d{1,2}-\d{1,2}/g.exec(obj[index].saleDate);
									/* salehtml += '<a href="${webRoot}/ledger/wx/editSale.do?id='+equalsNull(obj[index].id)+'"><ul class="mui-table-view mui-table-view-striped mui-table-view-condensed">';
									salehtml += ' <li class="mui-table-view-cell"> <div class="mui-table"> <div class="mui-table-cell mui-col-xs-8">';
									salehtml += '  <h4 class="mui-ellipsis">'+equalsNull(obj[index].foodName) +'</h4> <p>销售量：'+equalsNull(obj[index].saleCount)+equalsNull(obj[index].size)+'</p> <p>销售对象：'+equalsNull(obj[index].cusRegName) +'</p>  </div>';
									salehtml += '    <div class="mui-table-cell mui-col-xs-6 mui-text-right"> <span class="mui-h5">'+equalsNull(d) +'</span>';
									salehtml += '     </div></div> </li></ul></a>'; */
									salehtml += '<a href="${webRoot}/ledger/wx/editSale.do?id='+equalsNull(obj[index].id)+'"><ul class="mui-table-view mui-table-view-striped mui-table-view-condensed">';
									salehtml += '<li class="mui-table-view-cell"><div class="mui-table"> <div class="mui-table-cell mui-col-xs-8"><h4 class="mui-ellipsis">'+equalsNull(obj[index].foodName) +'</h4>';
									salehtml += ' </div><div class="mui-table-cell mui-col-xs-6 mui-text-right"><span class="mui-h5">'+equalsNull(d) +'</span> </div></div>';
					        		salehtml += '<div class="mui-table"> <div class="mui-table-cell mui-col-xs-12"><p>销售量：'+equalsNull(obj[index].saleCount)+equalsNull(obj[index].size)+'</p>';
					        		salehtml += '<p>供货商：'+equalsNull(obj[index].cusRegName) +'&nbsp'+equalsNull(obj[index].customer)+'</p> </div> </div> </div> </li></ul></a>';
								});
								$("#tableDatas2").append(salehtml);
								allsalepages=data.obj.pageCount;
								salepages=salepages+1;
								$("#saleLoad").show();
				    			$("#saleStop").hide();
			        		}
			        	}
				}
	    });
		
	}
	  
	  function equalsNull(obj){
			if(obj==null || obj=='')return "";
			return obj;
		}
		$('.mui-action-back').click(function(event) {
			$('.mui-postion').hide()
		});
		$('.mui-icon-search').click(function(event) {
			$('.mui-postion').show()
		});
		
		
		
		function daysJian(day,diff) {
			var date = new Date(day);//获取当前时间  
			date.setDate(date.getDate() + diff);//设置天数 -1 天  
			var time = date.Format("yyyy-MM-dd");
			return time;
		}
		Date.prototype.Format = function (fmt) {  
			var o = {  
				"M+": this.getMonth() + 1, //月份   
				"d+": this.getDate(), //日   
				"h+": this.getHours(), //小时   
				"m+": this.getMinutes(), //分   
				"s+": this.getSeconds(), //秒   
				"q+": Math.floor((this.getMonth() + 3)/ 3),   
				"S": this.getMilliseconds() //毫秒   
			};  
			if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));  
			for (var k in o)  
				if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));  
			return fmt;  
		} 
		</script>
</body>

</html>
