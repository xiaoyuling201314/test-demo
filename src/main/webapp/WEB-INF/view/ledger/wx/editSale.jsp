<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt"%>
<%@page import="java.util.Date"%>
<%-- <%@include file="/WEB-INF/view/common/resource.jsp"%> --%>
<%@include file="/WEB-INF/view/ledger/wx/ledgerWxResource.jsp"%>


<html>
  <head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
		<title>销售台账</title>
		<script type="text/javascript" src="${webRoot}/js/jquery-1.11.3.min.js"></script>
		<script src="${webRoot}/css/weixin/js/mui.min.js"></script>
	
		<link href="${webRoot}/css/weixin/plugin/picker/css/mui.dtpicker.css" rel="stylesheet" />
		<link href="${webRoot}/css/weixin/plugin/picker/css/mui.picker.css" rel="stylesheet" />
		<link href="${webRoot}/css/weixin/plugin/picker/css/mui.poppicker.css" rel="stylesheet" />
		<link href="${webRoot}/css/weixin/css/mui.indexedlist.css" rel="stylesheet" />

		<style>
			html,
			body {
				background-color: #efeff4;
			}
			
			.title {
				margin: 20px 15px 10px;
				color: #6d6d72;
				font-size: 15px;
				padding-bottom: 51px;
			}
			.mui-bar {
    -webkit-box-shadow: none;
    box-shadow: none;
}
	.mui-list-show {
	    line-height: 37px;
	    padding:0  10px;
}
    .mui-content-padded{
    border-left: 1px solid #ddd;
    border-right: 1px solid #ddd;
}
.mui-input-row:first-child{
	border-radius:6px 6px 0 0;
}
.mui-input-row:last-child{
	border-radius:0 0 6px 6px;
}
.uploader-input-box2 {
    float: left;
    position: relative;
    margin-right: 5px;
    margin-bottom: 5px;
    width: 40px;
    height: 40px;
	border:1px solid #ddd;
	overflow: hidden;
}
.mui-input-row .mui-input-clear~.mui-icon-clear {
    font-size: 20px;
    position: absolute;
    z-index: 1;
    top: 4px;
    right: 55px;
    /* width: 50px; */
    /* height: 50px; */
    text-align: center;
    color: #999;
    font-size: 28px;
}
.mui-positon-btn {
    font-size: 20px;
    position: absolute;
    z-index: 1;
    top: 2px;
    right: 10px;
    width: 40px;
    height: 29px;
    text-align: center;
    background: #009FDE;
    border-radius: 5px;
}
.mui-positon-btn .mui-icon{
	color:#fff;
	font-size:30px;
}
		</style>
<!-- 漂浮 -->
		<style type="text/css">
			.ui-fixed-bg{
				background:rgba(0,0,0,0.5); 
				position:fixed; top:0; 
				bottom:0; width:100%; 
				height:100%; 
				z-index:10000; 
				line-height:100%; 
				text-align:center;
				display:table;
			}
			.ui-fixed-cell{
				display:table-cell;
				vertical-align:middle;
			}
			.ui-crcle-bg{
				background:rgba(255,255,255,1); 
				display:inline-block;
				height:50px; 
				width:50px; 
				line-height:40px;     
				border-radius: 10px;
				box-shadow: 0 0 5px #5bb85b;
			}
			.ui-crcle{
				margin-top: 12px;
			}
				.ui-notice{
				color:#fff; 
				margin-top:10px;
			}
		</style>
	</head>

	<body>
		<!--页面主结构开始-->
		<div id="app" class="mui-views">
			<div class="mui-view">
				<div class="mui-navbar">
				</div>
				<div class="mui-pages">
				</div>
			</div>
		</div>
		<!--页面主结构结束-->
		<!--单页面开始-->
		<div id="setting" class="mui-page">
			<!--页面标题栏开始-->

	<%@include file="/WEB-INF/view/ledger/wx/comusertitle.jsp" %>
			
			<!--页面标题栏结束-->
			<!--页面主内容区开始-->
			<div class="mui-page-content">
				
			</div>
			<!--页面主内容区结束-->
		</div>
		<div class="mui-content" style="padding: 44px 10px 0 10px;">
			<div class="mui-content-padded">
				<form class="mui-input-group">
					<div class="mui-input-row">
						<label>所在市场</label>
					<span class="mui-list-show " data-input-clear="5">${ledgerUser.regName }</span>
					</div>
							<c:if test="${stockType==0 }">
				<div class="mui-input-row">
					<label>档口：</label>   <input type="text" onclick="alertModel(3);" placeholder="" id="busCode" name="busCode" value="${ledgerUser.opeShopCode }" >
				</div>
				<div class="mui-input-row">
					<label>经营户：</label>   <input type="text"  placeholder="" id="busName" name="busName" value="${ledgerUser.opeShopName }" readonly="readonly" >
				</div>
				 </c:if>
				<c:if test="${stockType!=0 }"> 
		<c:if test="${ledgerUser.opeShopCode!=null }"><div class="mui-input-row">
					<label>档口编号：</label> <span class="mui-list-show " data-input-clear="5">${ledgerUser.opeShopCode }</span> <span class="mui-icon mui-icon-clear mui-hidden"></span>
				</div></c:if>	
			<c:if test="${ledgerUser.opeShopName!=null }"><div class="mui-input-row">
					<label>经营户：</label> <span class="mui-list-show " data-input-clear="5">${ledgerUser.opeShopName }</span><span class="mui-icon mui-icon-clear mui-hidden"></span>
				</div></c:if></c:if>
				</form>
			</div>
			<div class="mui-content-padded">
				<form class="mui-input-group" id="saveForm">
					<input type="hidden" name="id" id="id" value="${ledgerSale.id }">
					 <input type="hidden" name="businessId" id="businessId" value="${ledgerUser.opeId }"> 
					 <input type="hidden" name="businessName" id="businessName" value="${ledgerUser.opeShopName }"> 
					 <input type="hidden" name="regId" id="regId" value="${ledgerUser.regId }">
					 <input type="hidden" name="regName" id="regName" value="${ledgerUser.regName }">
					<div class="mui-input-row">
						<label><i style="color:red;">*</i>食品名称</label>
						<input type="text" placeholder="" onclick="alertModel(2);" value="${ledgerSale.foodName }" name="foodName" id="foodName" >
					</div>
					<div class="mui-input-row">
						<label><i style="color:red;">*</i>销售数量</label>
						<input type="text" placeholder="" value="${ledgerSale.saleCount }" name="saleCount" id="saleCount">
					</div>
					<div class="mui-input-row">
						<label><i style="color:red;">*</i>规格单位</label>
						<input type="text" name="size" value="KG" id="size" class="mui-input-clear" placeholder="" data-input-clear="5" ><span class="mui-icon mui-icon-clear mui-hidden"></span>
					</div>
					
					<div class="mui-input-row">
						<label>销售对象</label>
						<input type="text" name="cusRegName" onclick="alertModel(1);" id="cusRegName" value="${ledgerSale.cusRegName }" class="mui-input-clear" placeholder="" data-input-clear="5"><span class="mui-icon mui-icon-clear mui-hidden"></span>
					</div>
					<div class="mui-input-row">
						<label>销售档口</label>
						<input type="text" name="customer" onclick="alertModel(0);" id="customer" value="${ledgerSale.customer }" class="mui-input-clear" placeholder="" data-input-clear="5"><span class="mui-icon mui-icon-clear mui-hidden"></span>
					</div>
					<div class="mui-input-row">
						<label>联系电话</label>
						<input type="text" name="cusPhone" id="cusPhone" value="${ledgerSale.cusPhone }" placeholder="">
					</div>
						<div class="mui-input-row">
						<label>销售日期</label>
						<input type="text" class="mui-input-clear" d="saleDate" name="saleDate" placeholder="" data-input-clear="5" onClick="WdatePicker({startDate:'%y-%M-%d',maxDate:'%y-%M-%d', dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true})"
							<c:if test="${empty ledgerSale.saleDate}">value="<fmt:formatDate value='<%=new Date()%>' pattern='yyyy-MM-dd'/>"</c:if> <c:if test="${!empty ledgerSale.saleDate }">value="<fmt:formatDate  value='${ledgerSale.saleDate }' pattern='yyyy-MM-dd'/>" </c:if>><span class="mui-icon mui-icon-clear mui-hidden"></span>
					</div>
					<div class="mui-input-row" style="height: auto;">
						<label style="line-height: 62px;">备注</label>
						<textarea type="text"  name="memo" id="memo" maxlength="60" cols="30" rows="3"class="mui-input-clear" placeholder="" data-input-clear="5">${ledgerSale.memo }</textarea><span class="mui-icon mui-icon-clear mui-hidden"></span>
					</div>					
					
					<div class="mui-button-row">
						<button type="button" class="mui-btn mui-btn-primary" onclick="saveSale();" style="width:80%;">确认</button>&nbsp;&nbsp;
					</div>
				</form>
			</div>
		</div>
		



<!-- 弹出搜索 -->
	<div class="mui-postion" id="alertModel" style="display: none">
		<header class="mui-bar mui-bar-nav">
            <a class="mui-icon mui-icon-left-nav mui-pull-left" onclick="closeModel();"></a>
            <h1 class="mui-title">查询</h1>
        </header>
        <div class="mui-content">
            <div id='list' class="mui-indexed-list" style="overflow-y: auto;">
              <div class="mui-indexed-list-search mui-input-row mui-search"  id="search-1">
					<input type="search" id="search" class="mui-input-clear mui-indexed-list-search-input" placeholder="输入关键字搜索">
					<div class="mui-positon-btn">
					<span class="mui-icon mui-icon-checkmarkempty" onclick="saveSearch();"></span>
					</div>
					<input type="hidden" id="searchType" value="999">
					</div>
                <div class="mui-indexed-list-bar" style="display: none">
                    <a>A</a>
                    <a>B</a>
                    <a>C</a>
                    <a>D</a>
                    <a>E</a>
                    <a>F</a>
                    <a>G</a>
                    <a>H</a>
                    <a>I</a>
                    <a>J</a>
                    <a>K</a>
                    <a>L</a>
                    <a>M</a>
                    <a>N</a>
                    <a>O</a>
                    <a>P</a>
                    <a>Q</a>
                    <a>R</a>
                    <a>S</a>
                    <a>T</a>
                    <a>U</a>
                    <a>V</a>
                    <a>W</a>
                    <a>X</a>
                    <a>Y</a>
                    <a>Z</a>
                </div>
               	<div class="mui-indexed-list-alert"></div>
								<div class="mui-indexed-list-inner" id="food" style="height: auto; ">
									<div class="mui-indexed-list-empty-alert" style="display: none">没有数据</div>
									<div class="ui-history">
										<h5>
											历史记录 <!-- <a class="mui-icon mui-icon-trash mui-pull-right"></a> -->
										</h5>
										<div class="ui-history-list" onclick="" id="historyList"></div>
									</div>
									<ul class="mui-table-view" id="foodList" onclick="">
										<!-- id="foodList" -->
										<%-- <c:forEach items="${foodList}" var="list"  begin="0" end="49">
											<li data-value="${list.foodName }" class="mui-table-view-cell mui-indexed-list-item">${list.foodName }</li>
										</c:forEach> --%>
									 </ul>
								</div>
							<!-- 市场 数据列表 -->
								<div class="mui-indexed-list-inner" style="display: none" id="obj" style="height: auto;">
									<div class="mui-indexed-list-empty-alert">没有数据</div>
									<div class="ui-history">
										<h5>
											历史记录 
										</h5>
										<div class="ui-history-list" onclick="" id="objHistoryList"></div>
									</div>
									<ul class="mui-table-view" id="objList"  onclick="">
									 </ul>
								</div>
								<!--档口  数据列表 -->
								<div class="mui-indexed-list-inner" style="display: none" id="ope" style="height: auto;">
									<div class="mui-indexed-list-empty-alert">没有数据</div>
									<div class="ui-history">
										<h5>
											历史记录 
										</h5>
										<div class="ui-history-list" onclick="" id="opeHistoryList"></div>
									</div>
									<ul class="mui-table-view" id="opeList"  onclick="">
									 </ul>
								</div>
										<!--市场方录入 档口 数据列表 -->
								<div class="mui-indexed-list-inner" style="display: none" id="business" style="height: auto;">
									<div class="mui-indexed-list-empty-alert">没有数据</div>
									<ul class="mui-table-view" id="businessList"  onclick="">
										<c:forEach items="${businessList}" var="reg">
									<li data-value="${reg.opeShopCode}"  data-id="${reg.id}" data-name="${ reg.opeShopName}"  class="mui-table-view-cell mui-indexed-list-item">${reg.opeShopCode} </li>
									</c:forEach>
									 </ul>
								</div>
			</div>
		</div>
	</div>
	<!-- 悬浮 -->
		<div class="ui-fixed-bg" style="display: none" id="xuanfu">
			<div class="ui-fixed-cell">
			<div class="ui-crcle-bg" style="">
			<span class="ui-crcle mui-spinner"></span>
			<p class="ui-notice">正在提交...</p>
			</div>
			</div>
		</div>
		<!-- 漂浮 -->
		<script src="${webRoot}/css/weixin/js/util.js"></script>
		<script src="${webRoot}/css/weixin/js/mui.previewimage.js"></script>
		<script src="${webRoot}/css/weixin/js/mui.zoom.js"></script>
		<script src="${webRoot}/css/weixin/plugin/picker/js/mui.picker.js"></script>
		<script src="${webRoot}/css/weixin/plugin/picker/js/mui.poppicker.js"></script>
		<script src="${webRoot}/css/weixin/plugin/picker/js/mui.dtpicker.js"></script>
			<script src="${webRoot}/css/weixin/js/mui.indexedlist.js"></script>
			 <script type="text/javascript" charset="utf-8">
			 var html = "";
				var type;
				var userId;
				var foodList=null;
				var objList=null;
				var businessList='${businessList}';//经营户
				var stockType='${stockType}';
        mui.init();
        mui.ready(function() {
            var header = document.querySelector('header.mui-bar');
            var list = document.getElementById('list');
            //calc hieght
            list.style.height = (document.body.offsetHeight - header.offsetHeight) + 'px';
            //create
            window.indexedList = new mui.IndexedList(list);
        });
       
		$(document).on('click', '.mui-table-view li', function() {
			var  searchType=$("#searchType").val();
			$("#search-1").show();
			if(searchType==2){//食品
			$("#foodName").val($(this).attr("data-value"));
			}else if(searchType==1){//市场
				$("#cusRegName").val($(this).attr("data-value"));
			}else if(searchType==0){//档口
				$("#customer").val($(this).attr("data-value"));
				$("#cusPhone").val($(this).attr("p-value"));
			}else if(searchType==3){//经营户
				 $("#busCode").val($(this).attr("data-value"));
				 $("#businessId").val($(this).attr("data-id"));
				 $("#busName").val($(this).attr("data-name"));
			}
			$("#alertModel").css('display', 'none');
		});
		$(document).on('click', '.ui-history-list span', function() {
			var  searchType=$("#searchType").val();
			if(searchType==2){//食品
				$("#foodName").val($(this).html());
				}else if(searchType==1){//市场
					$("#cusRegName").val($(this).html());
				}else if(searchType==0){//档口
					$("#customer").val($(this).html());
					$("#cusPhone").val($(this).attr("p-value"));
				}
			$("#alertModel").css('display', 'none');
		});
			mui.previewImage();

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
							result.innerText = '选择日期: ' + rs.text;
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
						});
					}, false);
				});
			})(mui);
			
			function saveSale() {
				var foodName = $("#foodName").val();
				if (foodName == null || foodName == "") {
					mui.alert('食品名称不能为空!', '消息', '确定', null, 'div');
					return;
				}
				var saleCount = $("#saleCount").val();
				if (saleCount == null || saleCount == "") {
					mui.alert('销售数量不能为空!', '消息', '确定', null, 'div');
					return;
				}
				var size = $("#size").val();
				if (size == null || size == "") {
					mui.alert('规格不能为空!', '消息', '确定', null, 'div');
					return;
				}
				$("#xuanfu").show();
				$.ajax({
					type : "POST",
					url : '${webRoot}' + "/ledger/wx/saveSale.do",
					data : $('#saveForm').serialize(),
					dataType : "json",
					success : function(data) {
						$("#xuanfu").hide();
						if (data.success) {
							//$("#myModal-md").modal();
							//$.Showmsg(data.msg);
							mui.alert('保存成功','消息','确定',null,'div') ;
						self.location = "${webRoot}/ledger/wx/main.do?listType=sale";
						} else {
							mui.alert(data.msg,'消息','确定',null,'div') ;
						}
					}
				})
			}

		</script>
		<script type="text/javascript">
		function alertModel(type) {
			//document.getElementById("search").focus();//输入框失去焦点
			$("#search-1").show();
			$("#searchType").val(type);
			 $("#food").hide();
			 $("#obj").hide();
			 $("#ope").hide();
			$("#alertModel").show();
			$(".mui-indexed-list-inner").css("height", "auto");//列表高度自动
			$("#search").val("");
			if(type==2){//2食品
				if(!foodList){//列表不存在则获取食品列表
					 getFood();
				}
			getHistory(type);
			 $("#food").show();
			}else if(type==1){//市场
				getObjHistory(type);
				if(!objList){//列表不存在则获取市场列表
					getObjList();
				}
				$("#obj").show();
			}else if(type==0){//档口
				getObjHistory(type);
				if(!opeList){//列表不存在则获取档口列表
				}
				$("#ope").show();
			}else if(type==3){//经营户
				$("#search-1").hide();
				$("#business").show();
			}
			$("#search").focus();//获取焦点
		}
		function closeModel() {
			$("#alertModel").hide();
		}
	function getFood() {
		 $.ajax({
				type : "POST",
				url :  "${webRoot}/ledger/wx/queryLocalFood.do",
				data : "",
				contentType : false, //必须false才会避开jQuery对 formdata 的默认处理 XMLHttpRequest会对 formdata 进行正确的处理 
				processData : false, //必须false才会自动加上正确的Content-Type
				dataType : "json",
				success : function(data) {
					if (data && data.success) {
						html="";
						$("#nodata").hide();
						var obj=data.obj;
						foodList=data.obj;
						for (var index = 0; index < 50; index++) {
							var foodNameOther = obj[index].foodNameOther;
							if (foodNameOther) {//有别名
								html += '   <li data-value="'+obj[index].foodName+'"  class="mui-table-view-cell mui-indexed-list-item">'
										+ obj[index].foodName + '(' + foodNameOther + ')' + '</li>';
							} else {
								html += '   <li data-value="'+obj[index].foodName+'"  class="mui-table-view-cell mui-indexed-list-item">'
										+ obj[index].foodName + '</li>';
							}
						}
						$("#foodList").append(html); 
						/* $.each(obj, function(index, item) {
							html += '   <li data-value="'+obj[index].foodName+'"  class="mui-table-view-cell mui-indexed-list-item">'+obj[index].foodName+'</li>';
						});
						$("#foodList").append(html); */
					}else{
						$("#nodata").show();
					}
				}
			});  
	}
	function	closeModel(){
		$("#alertModel").hide();
	}
	//获取经营户、市场数据
	function getObjList() {
		$.ajax({
					type : "POST",
					url : "${webRoot}/ledger/wx/queryAllObj.do",
					data : "",
					contentType : false, //必须false才会避开jQuery对 formdata 的默认处理 XMLHttpRequest会对 formdata 进行正确的处理 
					processData : false, //必须false才会自动加上正确的Content-Type
					dataType : "json",
					success : function(data) {
						if (data && data.success) {
							$("#objList").empty();
							objhtml = "";
							$("#nodata").hide();
							var obj = data.obj;
							objList = null;
							objList = data.obj;
							var l=objList.length;
							if(l>50){
								l=50;
							}
						for (var index = 0; index < l; index++) {
									objhtml += '   <li data-value="'+obj[index].regName+'"  class="mui-table-view-cell mui-indexed-list-item">'
											+ obj[index].regName + '</li>';
							}
							$("#objList").append(objhtml);  
						
						} else {
							$("#nodata").show();
						}
					}
		});
	}
	function getHistory(type) {
	 	 var userId=$("#businessId").val();
	 	if(stockType==1){
				userId=$("#regId").val();
			}
			 $.ajax({
					type : "POST",
					url :  "${webRoot}/ledger/wx/getHistory.do",
					dataType : "json",
					data :{
						userId:userId,
						userType:2,
						keyType:type
					},
					success : function(data) {
						$("#historyList").empty();
						 if (data && data.success) {
						var	hishtml="";
							var obj=data.obj;
							$.each(obj, function(index, item) {
								hishtml += '<span>'+obj[index].keyword+'</span>';
							});
							$("#historyList").append(hishtml);
						} 
					}
				});  
		}
		$(function() {
			$("#search").bind('input porpertychange',function() {
						var key = $("#search").val();
						if (key == null | key == "") {
							return;
						}
							var foodsearchhtml = "";
						$("#foodList").empty();
						for (var i = 0; i < foodList.length; i++) {
							var foodName = foodList[i].foodName;
							var foodNameOther = foodList[i].foodNameOther;
							if (foodName.indexOf(key) != -1 || foodNameOther.indexOf(key) != -1) {
								if (foodNameOther) {//有别名
									foodsearchhtml += '<li data-value="'+foodName+'" class="mui-table-view-cell mui-indexed-list-item">'
											+ foodName + '(' + foodNameOther + ')' + '</li>';
								} else {//没有别名
									foodsearchhtml += '<li data-value="'+foodName+'" class="mui-table-view-cell mui-indexed-list-item">'
											+ foodName + '</li>';
								}
							}
						}
						$("#foodList").append(foodsearchhtml);
					});
			});
		//获取经营户、市场历史数据
		function getObjHistory(type) {
			 var userId=$("#businessId").val();
			 if(stockType==1){
	 				userId=$("#regId").val();
	 			}
			var regname="";//市场名称
			if(type==0){
				regname=$("#cusRegName").val();
			}
			$.ajax({
				type : "POST",
				url : "${webRoot}/ledger/wx/getObjHistory.do?type="+type+"&regname="+regname,
				dataType : "json",
				data : {
					userId : userId,
					userType : 0,//经营户
					keyType : 1,//进货
				},
				success : function(data) {
					if (data && data.success) {
						if(type==0){//档口
							$("#opeHistoryList").empty();
							var opehishtml = "";
							var obj = data.obj;
							$.each(obj, function(index, item) {
								if(obj[index].keyword){
								opehishtml += '<span  s-value="' + obj[index].opeUser + '" p-value="' + obj[index].phone + '">' + obj[index].keyword + '</span>';
								}
							});
							$("#opeHistoryList").append(opehishtml);
						}else if(type==1)//市场
							$("#objHistoryList").empty();
						var hishtml = "";
						var obj = data.obj;
						$.each(obj, function(index, item) {
							if(obj[index].regname){
							hishtml += '<span>' + obj[index].regname + '</span>';
							}
						});
						$("#objHistoryList").append(hishtml);
					}
				}
			});
		}
		$(function() {
			$("#search").bind('input porpertychange',function() {
						var key = $("#search").val();
						if (key == null | key == "") {
							return;
						}
						var searchType=$("#searchType").val();
						if(searchType==2){//食品
							foodSearch(key);
						}else if(searchType==1){//市场
							var objsearchhtml = "";
							$("#objList").empty();
							for (var i = 0; i < objList.length; i++) {
							var regName = objList[i].regName;
								if (regName.indexOf(key) != -1 ) {
									objsearchhtml += '<li data-value="'+regName+'" class="mui-table-view-cell mui-indexed-list-item">'
											+ regName + '</li>';
								}
							}
						$("#objList").append(objsearchhtml);
						}else if(searchType==1){//档口
							var opesearchhtml = "";
							$("#opeList").empty();
							for (var i = 0; i < objList.length; i++) {
							var keyword = objList[i].keyword;
								if (keyword.indexOf(key) != -1 ) {
									opesearchhtml += '<li data-value="'+keyword+'" s-value="李白" p-value="110" class="mui-table-view-cell mui-indexed-list-item">'
											+ keyword + '</li>';
								}
							}
						$("#opeList").append(opesearchhtml);
						}
					});
			});
		
		function foodSearch(key) {
			$("#foodList").empty();
			var keyhtml="";
			var foodsearchhtmlS = "";
			var foodsearchhtml = "";
			for (var i = 0; i < foodList.length; i++) {
				if(foodList[i].isFood!=0){
				var foodName = foodList[i].foodName;
				var foodNameOther = foodList[i].foodNameOther;
				var otherName=foodList[i].foodNameOther;
    			var foodNameEn=foodList[i].foodNameEn;
    			var foodType=foodList[i].isFood;
    			if(foodType==0){
    				foodType='类别';
    			}else{
    				foodType='食品';
    			}
				if (foodName.indexOf(key) != -1 || foodNameOther.indexOf(key) != -1) {
					if(foodName==key&& keyhtml==""){//当key==foodName
		       				if(!otherName&&!foodNameEn){
		       					keyhtml += '<li data-value="'+foodName+'" class="mui-table-view-cell mui-indexed-list-item">['+foodType+']&nbsp;'+foodName+'</li>';
		        			}else if(otherName&&!foodNameEn){
		        				keyhtml += '<li data-value="'+foodName+'" class="mui-table-view-cell mui-indexed-list-item">['+foodType+']&nbsp;'+foodName+'('+otherName+')</li>';
		        			}else{
		        				keyhtml += '<li data-value="'+foodName+'" class="mui-table-view-cell mui-indexed-list-item">['+foodType+']&nbsp;'+foodName+'('+foodNameEn+'、'+otherName+')</li>';
		        			}
					}else  if(foodName==key&& keyhtml!=""){//关键字去重
						
					}else if(foodName.indexOf(key)==0&&foodName!=key){
	       				if(!otherName&&!foodNameEn){
	       					foodsearchhtmlS += '<li data-value="'+foodName+'" class="mui-table-view-cell mui-indexed-list-item">['+foodType+']&nbsp;'+foodName+'</li>';
	        			}else if(otherName&&!foodNameEn){
	        				foodsearchhtmlS += '<li data-value="'+foodName+'" class="mui-table-view-cell mui-indexed-list-item">['+foodType+']&nbsp;'+foodName+'('+otherName+')</li>';
	        			}else{
	        				foodsearchhtmlS += '<li data-value="'+foodName+'" class="mui-table-view-cell mui-indexed-list-item">['+foodType+']&nbsp;'+foodName+'('+foodNameEn+'、'+otherName+')</li>';
	        			}
					}else {
	       				if(!otherName&&!foodNameEn){
	       				foodsearchhtml += '<li data-value="'+foodName+'" class="mui-table-view-cell mui-indexed-list-item">['+foodType+']&nbsp;'+foodName+'</li>';
	        			}else if(otherName&&!foodNameEn){
	        				foodsearchhtml += '<li data-value="'+foodName+'" class="mui-table-view-cell mui-indexed-list-item">['+foodType+']&nbsp;'+foodName+'('+otherName+')</li>';
	        			}else{
	        			foodsearchhtml += '<li data-value="'+foodName+'" class="mui-table-view-cell mui-indexed-list-item">['+foodType+']&nbsp;'+foodName+'('+foodNameEn+'、'+otherName+')</li>';
	        			}
					}
				}
				}
			}
			$("#foodList").append(keyhtml+foodsearchhtmlS+foodsearchhtml);
		}
		//保存搜索
		function saveSearch() {
		var search=  $("#search").val();
		var  searchType=$("#searchType").val();
		if(searchType==2){//食品
			$("#foodName").val(search);
			}else if(searchType==1){//市场
				$("#cusRegName").val(search);
			}else if(searchType==0){//档口
				$("#customer").val(search);
			}
		closeModel();
		}
	</script>
	</body>

</html>