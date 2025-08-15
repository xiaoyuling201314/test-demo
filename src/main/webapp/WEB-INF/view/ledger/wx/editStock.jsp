<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt"%>
<%@page import="java.util.Date"%>
<%@include file="/WEB-INF/view/ledger/wx/ledgerWxResource.jsp"%>
<%-- <% 
String serverName=request.getServerName()+":"+request.getServerPort();
%>
<c:set var="wxUrl" value="<%=serverName%>" />
<c:set var="webRoot" value="<%=basePath%>" /> --%>

<c:set var="webRoot" value="<%=basePath%>" />
<c:set var="resourcesUrl" value="<%=resourcesUrl%>" />

<html>

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
<title>进货台账</title>
<script type="text/javascript" src="${webRoot}/js/jquery-1.11.3.min.js"></script>
<script type="text/javascript" src="${webRoot}/js/dateUtil.js"></script>
<script src="${webRoot}/css/weixin/js/mui.min.js"></script>
<link href="${webRoot}/css/weixin/plugin/picker/css/mui.dtpicker.css" rel="stylesheet" />
<link href="${webRoot}/css/weixin/plugin/picker/css/mui.picker.css" rel="stylesheet" />
<link href="${webRoot}/css/weixin/plugin/picker/css/mui.poppicker.css" rel="stylesheet" />
<link href="${webRoot}/css/weixin/css/mui.indexedlist.css" rel="stylesheet" />

<style>
html, body {
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
	padding: 0 10px;
}

.mui-content-padded {
	border-left: 1px solid #ddd;
	border-right: 1px solid #ddd;
}

.mui-input-row:first-child {
	border-radius: 6px 6px 0 0;
}

.mui-input-row:last-child {
	border-radius: 0 0 6px 6px;
}
.uploader-input-box2 {
    float: left;
    position: relative;
    margin-right: 3px;
    margin-bottom: 0px;
    width: 40px;
    height: 50px;
	border:1px solid #ddd;
	overflow: hidden;
	text-align:center;
}
.uploader-input-box2 .icon{
	position: absolute;
    top:-4px;
    right: 0;
    /* width: 100%; */
    height: 22px;
    font-size: 14px;
	
}
.text-danger {
    color: #fb0500;
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

mui-icon 
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
			.uploader-box{
				display:inline-block;
				float:left;
				padding-left: 4px;
			}
			label{
				margin:0;
			}
			.mui-input-group .upload-row{
				padding-top:0;
			}
			.uploader-input-box {
			    float: left;
			    position: relative;
			    margin-right: 2px;
			    margin-bottom: 0px;
			    width: 40px;
			    height: 50px;
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
	<!--页面主结构结束-->
	<!--单页面开始-->
	<div id="setting" class="mui-page">
		<!--页面标题栏开始-->

	<%@include file="/WEB-INF/view/ledger/wx/comusertitle.jsp" %>
		<!--页面标题栏结束-->
		<!--页面主内容区开始-->
		<div class="mui-page-content"></div>
		<!--页面主内容区结束-->
	</div>
	<div class="mui-content" style="padding: 44px 10px 0 10px;">
		<div class="mui-content-padded">
			<form class="mui-input-group">
				<div class="mui-input-row">
					<label>所在市场：</label> <span class="mui-list-show " data-input-clear="5">${ledgerUser.regName }</span>
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
			<form class="mui-input-group" id="stockform" enctype="multipart/form-data">
				<input type="hidden" name="id" value="${ledgerStock.id }"> <input type="hidden" name="regName" />
				 <input type="hidden" id="regId" name="regId" value="${ledgerUser.regId }" />
				 <input type="hidden" id="businessId" name="businessId" value="${ledgerUser.opeId }" /> 
				<div class="mui-input-row">
					<label><i style="color:red;">*</i> 食品名称:</label> <input type="text" onclick="alertModel(2);" placeholder="" id="foodName" name="foodName" value="${ledgerStock.foodName }">
				</div>
				<div class="mui-input-row">
					<label><i style="color:red;">*</i> 进货数量:</label> <input type="text" value="${ledgerStock.stockCount }" name="stockCount" id="stockCount" class="mui-input-clear" placeholder="" data-input-clear="5"><span class="mui-icon mui-icon-clear mui-hidden"></span>
				</div>
				<div class="mui-input-row">
					<label><i style="color:red;">*</i>规格单位:</label> <input type="text" name="size" id="size" <c:if test="${!empty ledgerStock.stockDate }"> value="${ledgerStock.size }"</c:if> <c:if test="${empty ledgerStock.stockDate }"> value="KG"</c:if> class="mui-input-clear" placeholder="" data-input-clear="5"><span class="mui-icon mui-icon-clear mui-hidden"></span>
				</div>
				<%-- <div class="mui-input-row">
					<label>供货市场:</label> <input type="text" class="mui-input-clear" placeholder="" value="${ledgerStock.supplier }" name="" data-input-clear="5"><span class="mui-icon mui-icon-clear mui-hidden"></span>
				</div> --%>
				<div class="mui-input-row">
					<label>来源/市场:</label> <input type="text" value="${ledgerStock.param1 }" onclick="alertModel(1);" name="param1" id="param1" class="mui-input-clear" placeholder="" data-input-clear="5"><span class="mui-icon mui-icon-clear mui-hidden"></span>
				</div>
				<div class="mui-input-row">
					<label>供货档口:</label> <input type="text" class="mui-input-clear" value="${ledgerStock.supplier }" id="supplier" onclick="alertModel(0);" name="supplier" placeholder="" data-input-clear="5"><span class="mui-icon mui-icon-clear mui-hidden"></span>
				</div>
				<div class="mui-input-row">
					<label>供货者名称:</label> <input type="text" placeholder="" value="${ledgerStock.supplierUser }" name="supplierUser" id="supplierUser">
				</div>
				<div class="mui-input-row">
					<label>联系方式:</label> <input type="text" value="${ledgerStock.supplierTel }" name="supplierTel" id="supplierTel" class="mui-input-clear" placeholder="" data-input-clear="5"><span class="mui-icon mui-icon-clear mui-hidden"></span>
				</div>
				<div class="mui-input-row">
					<label>产地:</label> <input type="text" placeholder="" value="${ledgerStock.productionPlace }" id="productionPlace" name="productionPlace">
				</div>
				<div class="mui-input-row">
					<label>批号:</label> <input type="text" value="${ledgerStock.batchNumber }" name="batchNumber" id="batchNumber" class="mui-input-clear" placeholder="" data-input-clear="5"><span class="mui-icon mui-icon-clear mui-hidden"></span>
				</div>
				<div class="mui-input-row">
					<label>保质期:</label> <input type="text" value="${ledgerStock.expirationDate }" name="expirationDate" id="expirationDate" class="mui-input-clear" placeholder="" data-input-clear="5"><span class="mui-icon mui-icon-clear mui-hidden"></span>
				</div>
				<div class="mui-input-row">
					<label>进货日期</label> <input type="text" placeholder="" name="stockDate" class="inputxt" onClick="WdatePicker({startDate:'%y-%M-%d',maxDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true})" <c:if test="${empty ledgerStock.stockDate }">value="<fmt:formatDate value='<%=new Date()%>' pattern='yyyy-MM-dd'/>"</c:if> <c:if test="${!empty ledgerStock.stockDate }">value="<fmt:formatDate  value='${ledgerStock.stockDate }' pattern='yyyy-MM-dd'/>" </c:if>>
				</div>
				<div class="mui-input-row">
					<label>生产日期:</label> <input type="text" placeholder="" name="productionDate" id="productionDate" class="inputxt" onClick="WdatePicker({startDate:'%y-%M-%d %H:%m:%s', maxDate:'%y-%M-%d', dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true})" <c:if test="${empty ledgerStock.productionDate }">value="<fmt:formatDate value='<%=new Date()%>' pattern='yyyy-MM-dd'/>"</c:if> <c:if test="${!empty ledgerStock.productionDate }">value="<fmt:formatDate  value='${ledgerStock.productionDate }' pattern='yyyy-MM-dd'/>" </c:if>>
				</div>
				<div class="mui-input-row">
					<label>检验编号:</label> <input type="text" value="${ledgerStock.checkProof }" name="checkProof" id="checkProof" class="mui-input-clear" placeholder="" data-input-clear="5"><span class="mui-icon mui-icon-clear mui-hidden"></span>
				</div>
				<div class="mui-input-row upload-row" style="height: auto;" >
					<label style="height: 51px;line-height: 30px;" >检验证明:</label>
					<div class="uploader-box"  id="img2">
							<c:forEach items="${CImgList}" var="reg">
							<div class="uploader-input-box2" >
							 <a target="self" href="${webRoot}/resources/stock/${reg}">	<img src="${webRoot}/resources/stock/${reg}" class="img1-img2" style="height: 100%;"></a> 
							<input style="display: none" name="checkProof_Img" value="${reg }">
							<i onclick="" class="icon iconfont icon-close text-danger del-img2"></i>
							</div>
						</c:forEach>
					</div>
					<div class="uploader-input-box" id="Img2-add" <c:if test="${fn:length(CImgList) == 5}">style="display:none "</c:if>>
						<input id="browerfile2" class="uploader-input" type="file" name="Img2" accept="image/*"   multiple>
					</div>
					
				</div>
				<div class="mui-input-row">
					<label>检疫编号:</label> 
					<input type="text" value="${ledgerStock.quarantineProof }" name="quarantineProof" id="quarantineProof" class="mui-input-clear" placeholder="" data-input-clear="5"><span class="mui-icon mui-icon-clear mui-hidden"></span>
					
				</div>
				<div class="mui-input-row upload-row" style="height: auto;">
					<label style="height: 51px;line-height: 30px;">检疫证明:</label>
					<div class="uploader-box"  id="img3">
							<c:forEach items="${QImgList}" var="reg">
								<div class="uploader-input-box2 " >
								 <a target="self" href="${webRoot}/resources/stock/${reg}">	<img src="${webRoot}/resources/stock/${reg}" class="img1-img2" style="height: 100%;"></a> 
								<input style="display: none" name="quarantineProof_Img" value="${reg }">
								<i onclick="" class="icon iconfont icon-close text-danger del-img3"></i>
								</div>
							</c:forEach>
					</div>
					<div class="uploader-input-box" <c:if test="${fn:length(QImgList) == 5}">style="display:none "</c:if> id="Img3-add">
						<input type="file" id="browerfile3" class="uploader-input" name="Img3" accept="image/*" multiple>
					</div>
						
				</div>
				<div class="mui-input-row upload-row" style="height: auto;">
					<label style="height: 51px;line-height: 30px;">进货凭证:</label>
					<div class="uploader-box"  id="img1">
							<c:forEach items="${SImgList}" var="reg">
								<div class="uploader-input-box2" >
								 <a target="self" href="${webRoot}/resources/stock/${reg}">	<img src="${webRoot}/resources/stock/${reg}" class="img1-img2" style="height: 100%;"></a> 
								<input style="display: none" name="stockProof_Img" value="${reg }">
								<i onclick="" class="icon iconfont icon-close text-danger del-img1"></i>
								</div>
							</c:forEach>
					</div>
					<div class="uploader-input-box" <c:if test="${fn:length(SImgList) == 5}">style="display:none "</c:if> id="Img1-add">
						<input type="file" id="browerfile1" class="uploader-input" name="Img1" accept="image/*" multiple>
					</div>
						
				</div>
				<div class="mui-button-row" id="sbutton"  >
					<button type="button" class="mui-btn mui-btn-primary" onclick="photo();" style="width: 80%;">确认</button>
				</div>
			</form>
		</div>
	</div>



	<!-- 弹出搜索 -->
	<div class="mui-postion" id="alertModel" style="display: none">
		<header class="mui-bar mui-bar-nav">
			<a href="javascript:" class="mui-icon mui-icon-left-nav mui-pull-left" onclick="closeModel();"></a>
			<h1 class="mui-title">查询</h1>
		</header>
		<div class="mui-content">
			<div id='list' class="mui-indexed-list" style="overflow-y: auto;">
				<div class="mui-indexed-list-search mui-input-row mui-search" id="search-1">
					<input type="search" id="search" class="mui-input-clear mui-indexed-list-search-input" placeholder="输入关键字搜索">
					<div class="mui-positon-btn">
					<span class="mui-icon mui-icon-checkmarkempty" onclick="saveSearch();"></span>
					</div>
					<input type="hidden" id="searchType" value="999">
				</div>
				<div class="mui-indexed-list-bar" style="display: none">
					<a>A</a> <a>B</a> <a>C</a> <a>D</a> <a>E</a> <a>F</a> <a>G</a> <a>H</a> <a>I</a> <a>J</a> <a>K</a> <a>L</a> <a>M</a> <a>N</a> <a>O</a> <a>P</a> <a>Q</a> <a>R</a> <a>S</a> <a>T</a> <a>U</a> <a>V</a> <a>W</a> <a>X</a> <a>Y</a> <a>Z</a>
				</div>
				<div class="mui-indexed-list-alert"></div>
								<div class="mui-indexed-list-inner" style="display: none" id="food" style="height: auto;">
									<div class="mui-indexed-list-empty-alert">没有数据</div>
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
			</div>
			<p class="ui-notice">正在提交...</p>
			</div>
		</div>
		<!-- 漂浮 -->
	<script src="${webRoot}/css/weixin/js/util.js"></script>
	<script src="${webRoot}/css/weixin/js/mui.previewimage.js"></script>
	<script src="${webRoot}/css/weixin/js/mui.zoom.js"></script>
	<script src="${webRoot}/css/weixin/plugin/picker/js/mui.picker.js"></script>
	<script src="${webRoot}/css/weixin/plugin/picker/js/mui.poppicker.js"></script>
	<script src="${webRoot}/css/weixin/plugin/picker/js/mui.dtpicker.js"></script>
	<script type="text/javascript" src="${webRoot}/plug-in/My97DatePicker/WdatePicker.js"></script>
	<script type="text/javascript">
var u = navigator.userAgent;
var isAndroid = u.indexOf('Android') > -1 || u.indexOf('Adr') > -1; //android终端
/* if(isAndroid){
	$("#browerfile1").attr('capture','camera');
	$("#browerfile2").attr('capture','camera');
	$("#browerfile3").attr('capture','camera');
	
} */
//var isiOS = !!u.match(/\(i[^;]+;( U;)? CPU.+Mac OS X/); //ios终端
/* alert('是否是Android：'+isAndroid);
alert('是否是iOS：'+isiOS); */
</script>
	<script type="text/javascript" charset="utf-8">
	
		var html = "";
		var type;
		var userId;
		var foodList=null;
		var objList=null;
		var businessList='${businessList}'//经营户
		var stockType='${stockType}';
		mui.init();
		mui.ready(function() {
			var header = document.querySelector('header.mui-bar');
			var list = document.getElementById('list');
			list.style.height = (document.body.offsetHeight - header.offsetHeight) + 'px';
			mui('body').on('tap', 'a', function() {
				document.location.href = this.href;
				});
			/* window.indexedList = new mui.IndexedList(list); */
		});

		$(document).on('click', '.mui-table-view li', function() {
			var  searchType=$("#searchType").val();
			$("#search-1").show();
			if(searchType==2){//食品
			$("#foodName").val($(this).attr("data-value"));
			}else if(searchType==1){//市场
				$("#param1").val($(this).attr("data-value"));
			}else if(searchType==0){//档口
				$("#supplier").val($(this).attr("data-value"));
				$("#supplierUser").val($(this).attr("s-value"));
				$("#supplierTel").val($(this).attr("p-value"));
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
					$("#param1").val($(this).html());
				}else if(searchType==0){//档口
					$("#supplier").val($(this).html());
					$("#supplierUser").val($(this).attr("s-value"));
					$("#supplierTel").val($(this).attr("p-value"));
				}
			$("#alertModel").css('display', 'none');
		});
		mui.previewImage();
	</script>
	<script type="text/javascript">
		var saveOrUpdate = false;//保存或者保存并新增
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
		
			//检查是否需要压缩
			function photo() {
				 $("#browerfile1").attr("name","");
					$("#browerfile2").attr("name","");
					$("#browerfile3").attr("name",""); 
				var  formData = new FormData($('#stockform')[0]);
				try {
						 for (var i = 0; i < img1fileArr.length; i++) {
						 
						   formData.append("Img1-"+i,img1fileArr[i]); 
						}
						 for (var i = 0; i < img2fileArr.length; i++) {
					 
								 formData.append("Img2-"+i,img2fileArr[i]); 
						}
						 for (var i = 0; i < img3fileArr.length; i++) {
						 
								 formData.append("Img3-"+i,img3fileArr[i]); 
						}
		                	saveStock(formData);
					 
				} catch (e) {
					saveStock(formData);
				}
		}
		
		
		function saveStock(formData) {
			var foodName = $("#foodName").val();
			if (foodName == null || foodName == "") {
				mui.alert('食品名称不能为空!', '消息', '确定', null, 'div');
				return;
			}
			var stockCount = $("#stockCount").val();
			if (stockCount == null || stockCount == "") {
				mui.alert('进货数量不能为空!', '消息', '确定', null, 'div');
				return;
			}
			var size = $("#size").val();
			if (size == null || size == "") {
				mui.alert('规格不能为空!', '消息', '确定', null, 'div');
				return;
			}
			 //var reg=/^[1-9]\d*$|^0$/;
			 var reg = /^\d+(\.\d+)?$/;
			 if (!reg.test(stockCount)) { 
				mui.alert('进货数量只能输入数字!', '消息', '确定', null, 'div');
				return ;
	} 
			if(formData==null || formData=='undefined'){
			 formData = new FormData($('#stockform')[0]);
			}
			//photo(formData);
			var regId = $("#regId").val();
			var businessId = $("#businessId").val();
			$("#xuanfu").show();
			$.ajax({
				type : "POST",
				url : "${webRoot}/ledger/wx/saveStock.do",
				data : formData,
				contentType : false, //必须false才会避开jQuery对 formdata 的默认处理 XMLHttpRequest会对 formdata 进行正确的处理 
				processData : false, //必须false才会自动加上正确的Content-Type
				dataType : "json",
				success : function(data) {
					if (data && data.success) {
						if (saveOrUpdate) {//保存并且新增
							$("#xuanfu").hide();
							mui.alert(data.msg, '消息', '确定', null, 'div');
						} else {
							$("#xuanfu").hide();
							mui.alert(data.msg, '消息', '确定', null, 'div');
							self.location = "${webRoot}/ledger/wx/main.do";
						}
					} else {
						$("#xuanfu").hide();
						$("#waringMsg>span").html(data.msg);
						$("#confirm-warnning").modal('toggle');
					}
				}
			});
		}
	</script>
	<script type="text/javascript">
		function getObjectURL(file) {
			var url = null;
			if (window.createObjectURL != undefined) {
				url = window.createObjectURL(file);//basic
			} else if (window.URL != undefined) {
				url = window.URL.createObjectURL(file);
			} else if (window.webkitURL != undefined) {
				url = window.webkitURL.createObjectURL(file);
			}
			return url;
		}
		 var img1fileArr = [];
		 var img2fileArr = [];
		 var img3fileArr = [];
		$(function() {
			$("#browerfile1").change(function() {
				if($("#img1").children('.uploader-input-box2').length>=5){
					mui.alert('每种证明最多上传5张图片!', '消息', '确定', null, 'div');
					return;
				} 
				var path = browerfile2.value;
				 for (var i = 0; i < this.files.length; i++) {
				var objUrl = getObjectURL(this.files[i]);
				if (objUrl) {//文件存在
					var fileObj=this.files[i];
					if($("#img1").children('.uploader-input-box2').length==5){
						break;
					}
					//图片存入文件
					try {
					   	var size=fileObj.size;
					   	var formData1 = new FormData($('#stockForm')[0]);
					   	formData1.append("Img1-110", fileObj); 
						 formData1.set("1", 1);
						  		 if(fileObj&&((size/1024) > 1025)) {//img1图片大于1M
										 photoCompress(fileObj, {   quality: 0.2  }, function(base64Codes){
								                try {
								                	
								                    var bl = convertBase64UrlToBlob(base64Codes);
									          		var fileOfBlob = new File([bl],"file_"+Date.parse(new Date())+".jpg");
									                  formData1.append("Img1", bl, "file_"+Date.parse(new Date())+".jpg"); // 文件对象
									          // 	var fileOfBlob = new File([bl], {type : "image/jpeg"});
									                //alert("合成压缩方法"+fileOfBlob.name+"-------"+fileOfBlob.size);
													img1fileArr.push(fileOfBlob);  
												} catch (e) {
													for(var pair of formData1.entries()) {
														if(pair[0]=="Img1-110"){
															img1fileArr.push(pair[1]); 
									    				   console.log(pair[0]+ ', '+ pair[1]+"length:"+img1fileArr.length); 
														}
									    			}
												}
								            });
								 }else{
									 //alert(e)
									 img1fileArr.push(fileObj);
								 } 
						  		var html=' <div class="uploader-input-box2" ><a target="self" href="'+objUrl+'"> <img src="'+objUrl+'" class="img1-img1" style="height: 100%;"></a>'
								html+='<i onclick="" class="icon iconfont icon-close text-danger del-img1"></i></div>';
							 $("#img1").append(html);	 
							
					} catch (e) {
						for (var i = 0; i < this.files.length; i++) {
							var objUrl = getObjectURL(this.files[i]);
							if (objUrl) {//文件存在
								var fileObj=this.files[i];
								img1fileArr.push(fileObj);
								if($("#img1").children('.uploader-input-box2').length==5){
									break;
								}
								var html=' <div class="uploader-input-box2" ><a target="self" href="'+objUrl+'"> <img src="'+objUrl+'" class="img1-img1" style="height: 100%;"></a>'
								html+='<i onclick="" class="icon iconfont icon-close text-danger del-img1"></i></div>';
								
							 $("#img1").append(html);
							}
						}
					}
	          }
					 //超过5个隐藏
					if($("#img1").children('.uploader-input-box2').length==5){
						$("#Img1-add").hide();
					}
				}
			});
			
			
			$("#browerfile2").change(function() {
				
				if($("#img2").children('.uploader-input-box2').length>=5){
					mui.alert('每种证明最多上传5张图片!', '消息', '确定', null, 'div');
					return;
				} 
				var path = browerfile2.value;
				 for (var i = 0; i < this.files.length; i++) {
				var objUrl = getObjectURL(this.files[i]);
				if (objUrl) {//文件存在
					var fileObj=this.files[i];
					if($("#img2").children('.uploader-input-box2').length==5){
						break;
					}
					try {
					   	var size=fileObj.size;
					   	var formData1 = new FormData($('#stockForm')[0]);
						formData1.append("Img1-120", fileObj); 
						 formData1.set("1", 1);
						  		if(fileObj&&((size/1024) > 1025)) {//img1图片大于1M
										 photoCompress(fileObj, {   quality: 0.2  }, function(base64Codes){
								                //console.log("压缩后：" + base.length / 1024 + " " + base);
								               try {
								            	   var bl = convertBase64UrlToBlob(base64Codes);
									          		var fileOfBlob = new File([bl],"file_"+Date.parse(new Date())+".jpg");
									             formData1.append("Img2", bl, "file_"+Date.parse(new Date())+".jpg"); // 文件对象
								                img2fileArr.push(fileOfBlob);
											} catch (e) {
												//console.log(e);
											img2fileArr.push(fileObj);
												for(var pair of formData1.entries()) {
													if(pair[0]=="Img1-120"){
														img2fileArr.push(pair[1]); 
													}
								    			}
											}
								            });
								 }else{
									 img2fileArr.push(fileObj);
								 }
						  		var html=' <div class="uploader-input-box2" ><a target="self" href="'+objUrl+'">	<img src="'+objUrl+'" class="img1-img2" style="height: 100%;"></a>';
								html+='<i onclick="" class="icon iconfont icon-close text-danger del-img2"></i></div>';	 
								//$("#img2").append(html);
								 $("#img2").append(html);
								//图片存入文件
							
					} catch (e) {
						 console.log(e);
							for (var i = 0; i < this.files.length; i++) {
								var objUrl = getObjectURL(this.files[i]);
								if (objUrl) {//文件存在
									var fileObj=this.files[i];
									img2fileArr.push(fileObj);
									if($("#im2").children('.uploader-input-box2').length==5){
										break;
									}
									var html=' <div class="uploader-input-box2" ><a target="self" href="'+objUrl+'"> <img src="'+objUrl+'" class="img1-img2" style="height: 100%;"></a>'
									html+='<i onclick="" class="icon iconfont icon-close text-danger del-img1"></i></div>';
								 $("#img2").append(html);
								}
							}
						}
	          }
					 //超过5个隐藏
					if($("#img2").children('.uploader-input-box2').length==5){
						$("#Img2-add").hide();
					}
				}
			
			});
			$("#browerfile3").change(function() {

				if($("#img3").children('.uploader-input-box2').length>=5){
					mui.alert('每种证明最多上传5张图片!', '消息', '确定', null, 'div');
					return;
				} 
				var path = browerfile3.value;
				 for (var i = 0; i < this.files.length; i++) {
				var objUrl = getObjectURL(this.files[i]);
				if (objUrl) {//文件存在
					var fileObj=this.files[i];
					if($("#img3").children('.uploader-input-box2').length==5){
						break;
					}
					//图片存入文件
					try {
					   	var size=fileObj.size;
					   	var formData1 = new FormData($('#stockForm')[0]);
					  	formData1.append("Img1-130", fileObj); 
						 formData1.set("1", 1);
						  		if(fileObj&&((size/1024) > 1025)) {//img1图片大于1M
										 photoCompress(fileObj, {   quality: 0.2  }, function(base64Codes){
											   try {
								                	
								                    var bl = convertBase64UrlToBlob(base64Codes);
									          		var fileOfBlob = new File([bl],"file_"+Date.parse(new Date())+".jpg");
									                  formData1.append("Img3", bl, "file_"+Date.parse(new Date())+".jpg"); // 文件对象
													img3fileArr.push(fileOfBlob);  
												} catch (e) {
													for(var pair of formData1.entries()) {
														if(pair[0]=="Img1-130"){
															img1fileArr.push(pair[1]); 
									    				   console.log(pair[0]+ ', '+ pair[1]+"length:"+img3fileArr.length); 
														}
									    			}
												}
								            });
								 }else{
									 img3fileArr.push(fileObj);
								 }
						  		var html=' <div class="uploader-input-box2" ><a target="self" href="'+objUrl+'">	<img src="'+objUrl+'" class="img1-img3" style="height: 100%;"></a> ';
								html+='<i onclick="" class="icon iconfont icon-close text-danger del-img3"></i></div>';	
								$("#img3").append(html);
					} catch (e) {
						 console.log(e);
							for (var i = 0; i < this.files.length; i++) {
								var objUrl = getObjectURL(this.files[i]);
								if (objUrl) {//文件存在
									var fileObj=this.files[i];
									img3fileArr.push(fileObj);
									if($("#im3").children('.uploader-input-box2').length==5){
										break;
									}
									var html=' <div class="uploader-input-box2" ><a target="self" href="'+objUrl+'"> <img src="'+objUrl+'" class="img1-img3" style="height: 100%;"></a>'
									html+='<i onclick="" class="icon iconfont icon-close text-danger del-img1"></i></div>';
									
								 $("#img3").append(html);
								}
							}
						}
					}
					 //超过5个隐藏
					if($("#img3").children('.uploader-input-box2').length==5){
						$("#Img3-add").hide();
					}
				}
			})
		});
		
		//删除上传图片Img1
		$(document).on('click','.del-img1',function(e){
			var a=$(this).parent('.uploader-input-box2').index();
			img1fileArr.splice(a,1);//数据删除
			$("#Img1-add").show();
			$(this).parent('.uploader-input-box2').remove();
			e.preventDefault();
			})
			//删除上传图片Img2
		$(document).on('click','.del-img2',function(e){
			var a=$(this).parent('.uploader-input-box2').index();
			img2fileArr.splice(a,1);//数据删除
			$("#Img2-add").show();
			$(this).parent('.uploader-input-box2').remove();
			e.preventDefault();
			})
			//删除上传图片Img3
		$(document).on('click','.del-img3',function(e){
			var a=$(this).parent('.uploader-input-box2').index();
			img3fileArr.splice(a,1);//数据删除
			$("#Img3-add").show();
			$(this).parent('.uploader-input-box2').remove();
			e.preventDefault();
			})
	</script>

	<script type="text/javascript">
		function alertModel(type) {
			//document.getElementById("search").focus();//输入框失去焦点
			$("#searchType").val(type);
			$("#search-1").show();
			 $("#food").hide();
			 $("#obj").hide();
			 $("#ope").hide();
			 $("#business").hide();//经营户列表
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
						url : "${webRoot}/ledger/wx/queryLocalFood.do",
						data : "",
						contentType : false, //必须false才会避开jQuery对 formdata 的默认处理 XMLHttpRequest会对 formdata 进行正确的处理 
						processData : false, //必须false才会自动加上正确的Content-Type
						dataType : "json",
						success : function(data) {
							if (data && data.success) {
								$("#foodList").empty();
								html = "";
								$("#nodata").hide();
								var obj = data.obj;
								foodList = null;
								foodList = data.obj;
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
								/*  $.each(obj,function(index, item) {
													var foodNameOther = obj[index].foodNameOther;
													if (foodNameOther) {//有别名
														html += '   <li data-value="'+obj[index].foodName+'"  class="mui-table-view-cell mui-indexed-list-item">'
																+ obj[index].foodName + '(' + foodNameOther + ')' + '</li>';
													} else {
														html += '   <li data-value="'+obj[index].foodName+'"  class="mui-table-view-cell mui-indexed-list-item">'
																+ obj[index].foodName + '</li>';

													}
												});
								$("#foodList").append(html);  */
							} else {
								$("#nodata").show();
							}
						}
			});
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
 		//获取食品历史数据
		function getHistory(type) {
 			
			var userId=$("#businessId").val();
			var type=0;
 			if(stockType==1&&userId!=null){
 				userId=$("#regId").val();
 				type=1;
 			}
			$.ajax({
				type : "POST",
				url : "${webRoot}/ledger/wx/getHistory.do",
				dataType : "json",
				data : {
					userId : userId,
					userType : 1,
					keyType : 2,
					type:type
				},
				success : function(data) {
					$("#historyList").empty();
					if (data && data.success) {
						var hishtml = "";
						var obj = data.obj;
						$.each(obj, function(index, item) {
							if(obj[index].keyword){
							hishtml += '<span>' + obj[index].keyword + '</span>';
							}
						});
						$("#historyList").append(hishtml);
					}
				}
			});
		}
		//获取经营户、市场历史数据
		function getObjHistory(searchType) {
			var userId=$("#businessId").val();
			if(stockType==1){
 				userId=$("#regId").val();
 			}
			var regname="";//市场名称
			if(searchType==0){
				regname=$("#param1").val();
			}
			$.ajax({
				type : "POST",
				url : "${webRoot}/ledger/wx/getObjHistory.do?searchType="+searchType+"&regname="+regname,
				dataType : "json",
				data : {
					userId : userId,
					userType : 0,//经营户
					keyType : 0,//进货
					type : type
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
						/* if (key == null | key == "") {
							return;
						} */
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
						}else if(searchType==0){//档口
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
						}/* else if(searchType==3){//经营户
							var bussearchhtml = "";
							$("#businessList").empty();
							 $(businessList).each(function(i,dic){
							       console.log("opeShopCode:"+dic.opeShopCode);//遍历自定义对象，并输出自定义对象的dicName属性
							         });
							for (var i = 0; i < businessList.length; i++) {
							var keyword = businessList[i].opeName;
								if (keyword.indexOf(key) != -1 ) {
									opesearchhtml += '<li data-value="'+opeName+'" s-value="李白" p-value="110" class="mui-table-view-cell mui-indexed-list-item">'
											+ opeName + '</li>';
								}
							}
						$("#businessList").append(bussearchhtml);
						} */
					});
			});
		//保存搜索
		function saveSearch() {
		var search=  $("#search").val();
		var  searchType=$("#searchType").val();
		if(searchType==2){//食品
			//$("#foodName").val(search);
			}else if(searchType==1){//市场
				$("#param1").val(search);
			}else if(searchType==0){//档口
				$("#supplier").val(search);
			}
		closeModel();
		}
		
		
		
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
	</script>
	
	<script type="text/javascript">
   /* 三个参数
    file：一个是文件(类型是图片格式)，
    w：一个是文件压缩的后宽度，宽度越小，字节越小
    objDiv：一个是容器或者回调函数
    photoCompress()
     */
    function photoCompress(file,w,objDiv){
	   try {
		  // alert("开始压缩");
		   var ready=new FileReader();
	        /*开始读取指定的Blob对象或File对象中的内容. 当读取操作完成时,readyState属性的值会成为DONE,如果设置了onloadend事件处理程序,则调用之.同时,result属性中将包含一个data: URL格式的字符串以表示所读取文件的内容.*/
	        ready.readAsDataURL(file);
	        ready.onload=function(){
	            var re=this.result;
	            canvasDataURL(re,w,objDiv);
	        }
	} catch (e) {
		//alert(e);
	}
        
    }
    function canvasDataURL(path, obj, callback){
    	try {
    		//alert("canvasDataURL");
        var img = new Image();
        img.src = path;
        img.onload = function(){
            var that = this;
            // 默认按比例压缩
            var w = that.width,
                h = that.height,
                scale = w / h;
            w = obj.width || w;
            h = obj.height || (w / scale);
            var quality = 0.7;  // 默认图片质量为0.7
            //生成canvas
            var canvas = document.createElement('canvas');
            var ctx = canvas.getContext('2d');
            // 创建属性节点
            var anw = document.createAttribute("width");
            anw.nodeValue = w;
            var anh = document.createAttribute("height");
            anh.nodeValue = h;
            canvas.setAttributeNode(anw);
            canvas.setAttributeNode(anh);
            ctx.drawImage(that, 0, 0, w, h);
            // 图像质量
            if(obj.quality && obj.quality <= 1 && obj.quality > 0){
                quality = obj.quality;
            }
            // quality值越小，所绘制出的图像越模糊
            var base64 = canvas.toDataURL('image/jpeg', quality);
            // 回调函数返回base64的值
            	//alert(base64);
            callback(base64);
        }
    	
		} catch (e) {
			//alert(e);
		}
    }
    /**
     * 将以base64的图片url数据转换为Blob
     * @param urlData
     *            用url方式表示的base64图片数据
     */
    function convertBase64UrlToBlob(urlData){
        var arr = urlData.split(','), mime = arr[0].match(/:(.*?);/)[1],
            bstr = atob(arr[1]), n = bstr.length, u8arr = new Uint8Array(n);
        while(n--){
            u8arr[n] = bstr.charCodeAt(n);
        }
        return new Blob([u8arr], {type:mime});
    }

	
	</script>
</body>
<script type="text/javascript" src="${webRoot}/js/alert.js"></script>
<script src="${webRoot}/css/weixin/js/mui.indexedlist.js"></script>
</html>