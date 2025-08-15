<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/common/resource.jsp"%>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="initial-scale=1, maximum-scale=1, user-scalable=no">
<meta name="format-detection" content="telephone=no">
<title>快检服务云平台</title>
<link rel="stylesheet" type="text/css" href="${webRoot}/css/app/bootstrap.css" />
<link rel="stylesheet" type="text/css" href="${webRoot}/css/app/index.css" />
</head>
<body ontouchstart="" style="padding-bottom: 10px;">
	<div class="ui-headed">
		<h4>
			<c:choose>
				<c:when test="${!empty regType}">${regType.regType}信息</c:when>
				<c:otherwise>监管对象信息</c:otherwise>
			</c:choose>
		</h4>
	</div>
	<section class="ui-container" style="padding: 10px 10px 0 10px;">
		<div class="ui-second-info clearfix">
			<ul class="ui-bg-white">
				<li class="ui-border-b clearfix">
					<div class="ui-list-info ui-col ui-col-1">经营单位：</div>
					<div class="ui-list-action ui-list-info ui-col ui-col-3">
						<c:if test="${!empty regObject}">${regObject.regName}</c:if>
					</div>
				</li>
				<li class="ui-border-b clearfix">
					<div class="ui-list-info ui-col ui-col-1">地址：</div>
					<div class="ui-list-action ui-list-info ui-col ui-col-3">
						<c:if test="${!empty regObject}">${regObject.regAddress}</c:if>
					</div>
				</li>
				<li class="ui-border-b clearfix">
					<div class="ui-list-info ui-col ui-col-1">所属机构：</div>
					<div class="ui-list-action ui-list-info ui-col ui-col-3">
						<c:if test="${!empty regObject}">${regObject.regName}</c:if>
					</div>
				</li>
				<li class="ui-border-b clearfix">
					<div class="ui-list-info ui-col ui-col-1">联系人名称：</div>
					<div class="ui-list-action ui-list-info ui-col ui-col-3">
						<c:if test="${!empty regObject}">${regObject.linkUser}</c:if>
					</div>
				</li>
				<li class="ui-border-b clearfix">
					<div class="ui-list-info ui-col ui-col-1">联系电话：</div>
					<div class="ui-list-action ui-list-info ui-col ui-col-3">
						<c:if test="${!empty regObject}">${regObject.linkPhone}</c:if>
					</div>
				</li>
				<li class="ui-border-b clearfix">
					<div class="ui-list-info ui-col ui-col-1">营业执照：</div>
					<div class="ui-list-action ui-list-info ui-col ui-col-3">
						<c:if test="${!empty regObject}">${regObject.regLicence}</c:if>
					</div>
				</li>
			</ul>
		</div>
		<div class="ui-headed" style="margin-top: 10px;">
			<h4>样品检测</h4>
		</div>
		<div class="ui-time clearfix">
			日期： <a href="javascript:;" class="ui-day-pre">&lt; 前一天</a> <input type="date" id="search" class="ui-search-time" /> <a href="javascript:" class="ui-day-next">后一天 &gt; </a>
		</div>

		<div id="recordings"></div>

		<div class="ui-footer">
			<a href="http://www.chinafst.cn/CH/index.php"></a> © 2018 广东中检达元检测技术有限公司 ®
			</p>
		</div>
	</section>

	<!-- 经营单位 -->
	<div id="template1" style="display: none;">
		<div class="ui-third-info clearfix  ui-b-none">
			<ul class="ui-bg-white  ui-pos-re  ui-border-dotted">
				<li class="ui-pos-ab ui-ab-wh ui-success itemNo"><span class="recordingNo">1</span></li>
				<li class="clearfix">
					<div class="ui-li-height ui-col-1">档口名称：</div>
					<div class="ui-list-action ui-li-height ui-col-3 opeShop"></div>
				</li>
				<li class="clearfix">
					<div class="ui-li-height ui-col-1">样品名称：</div>
					<div class="ui-list-action ui-li-height ui-col-3">
						<span class="ui-fl ui-back-width foodName"></span>
						<div class="ui-back-btn ui-fl">
							<a href="javascript:" class="ui-find ui-fr"> <span>溯源</span> <span class="glyphicon-style glyphicon glyphicon-menu-down"></span>
							</a>
						</div>
					</div>
				</li>
				<li class="clearfix">
					<div class="ui-li-height ui-col-1">检测项目：</div>
					<div class="ui-list-action ui-li-height ui-col-3 itemName"></div>
				</li>
				<li class="clearfix">
					<div class="ui-li-height ui-col-1">检测结果：</div>
					<div class="ui-list-action ui-li-height ui-col-3">
						<span class="conclusion"></span>
					</div>
				</li>
			</ul>
			<div class="ui-back-info ui-hide  ui-padding">
				<ul class="ui-bg-white  ui-pos-re ui-ul-pad  ui-border-left">
					<li>
						<h5>溯源信息</h5>
					</li>
					<li class="clearfix">
						<div class="ui-li-height ui-col-1">进货日期：</div>
						<div class="ui-list-action ui-li-height ui-col-3 purchaseDate"></div>
					</li>
					<li class="clearfix">
						<div class="ui-li-height ui-col-1">生产批次：</div>
						<div class="ui-list-action ui-li-height ui-col-3 batchNumer"></div>
					</li>
					<li class="clearfix">
						<div class="ui-li-height ui-col-1">产地：</div>
						<div class="ui-list-action ui-li-height ui-col-3">
							<span class="origin"></span>
						</div>
					</li>
					<li class="clearfix">
						<div class="ui-li-height ui-col-1">供货商：</div>
						<div class="ui-list-action ui-li-height ui-col-3">
							<span class="supplier"></span>
						</div>
					</li>
					<li class="clearfix">
						<div class="ui-li-height ui-col-1">供应商联系人：</div>
						<div class="ui-list-action ui-li-height ui-col-3">
							<span class="persion"></span>
						</div>
					</li>
					<li class="clearfix">
						<div class="ui-li-height ui-col-1">联系电话：</div>
						<div class="ui-list-action ui-li-height ui-col-3">
							<span class="phone"></span>
						</div>
					</li>
					<li class="clearfix">
						<div class="ui-li-height ui-col-1">供应商地址：</div>
						<div class="ui-list-action ui-li-height ui-col-3">
							<span class="address"></span>
						</div>
					</li>
				</ul>
				<div class="ui-border-radius">
					<a href="javascript:" class="ui-btn ui-btn-close">收起</a>
				</div>
			</div>
		</div>
	</div>

	<!-- 生产单位 -->
	<div id="template2" style="display: none;">
		<div class="ui-third-info clearfix  ui-b-none">
			<ul class="ui-bg-white  ui-pos-re  ui-border-dotted">
				<li class="ui-pos-ab ui-ab-wh ui-success itemNo"><span class="recordingNo">1</span></li>
				<li class="clearfix">
					<div class="ui-li-height ui-col-1">样品名称：</div>
					<div class="ui-list-action ui-li-height ui-col-3">
						<span class="ui-fl ui-back-width foodName"></span>
					</div>
				</li>
				<li class="clearfix">
					<div class="ui-li-height ui-col-1">检测项目：</div>
					<div class="ui-list-action ui-li-height ui-col-3 itemName"></div>
				</li>
				<li class="clearfix">
					<div class="ui-li-height ui-col-1">检测结果：</div>
					<div class="ui-list-action ui-li-height ui-col-3">
						<span class="conclusion"></span>
					</div>
				</li>
				<li class="clearfix">
					<div class="ui-li-height ui-col-1">生产日期：</div>
					<div class="ui-list-action ui-li-height ui-col-3 purchaseDate"></div>
				</li>
				<li class="clearfix">
					<div class="ui-li-height ui-col-1">生产批次：</div>
					<div class="ui-list-action ui-li-height ui-col-3 batchNumer"></div>
				</li>
			</ul>
		</div>
	</div>

	<!-- 餐饮单位 -->
	<div id="template3" style="display: none;">
		<div class="ui-third-info clearfix  ui-b-none">
			<ul class="ui-bg-white  ui-pos-re  ui-border-dotted">
				<li class="ui-pos-ab ui-ab-wh ui-success itemNo"><span class="recordingNo">1</span></li>
				<li class="clearfix">
					<div class="ui-li-height ui-col-1">样品名称：</div>
					<div class="ui-list-action ui-li-height ui-col-3">
						<span class="ui-fl ui-back-width foodName"></span>
					</div>
				</li>
				<li class="clearfix">
					<div class="ui-li-height ui-col-1">检测项目：</div>
					<div class="ui-list-action ui-li-height ui-col-3 itemName"></div>
				</li>
				<li class="clearfix">
					<div class="ui-li-height ui-col-1">生产日期：</div>
					<div class="ui-list-action ui-li-height ui-col-3 purchaseDate"></div>
				</li>
				<li class="clearfix">
					<div class="ui-li-height ui-col-1">检测结果：</div>
					<div class="ui-list-action ui-li-height ui-col-3">
						<span class="conclusion"></span>
					</div>
				</li>
			</ul>
		</div>
	</div>

</body>
<script type="text/javascript">
	$(document).on("click", ".ui-find", function() {
		$(this).parents('.ui-bg-white').siblings('.ui-back-info').toggle();
	});

	$(document).on("click", ".ui-btn-close", function() {
		$(this).parents('.ui-back-info').hide();
	});

	//修改时间
	$(document).on("change", "#search", function() {
		checkRecording();
	});
	//前一天
	$(document).on("click", ".ui-day-pre", function() {
		var date;
		if (!$("#search").val()) {
			date = new Date();//获取当前时间  
		} else {
			date = new Date($("#search").val());
		}
		date.setDate(date.getDate() - 1);//设置天数 -1 天  
		$("#search").val(date.format("yyyy-MM-dd"));
		checkRecording();
	});
	//后一天
	$(document).on("click", ".ui-day-next", function() {
		var date;
		if (!$("#search").val()) {
			date = new Date();//获取当前时间  
		} else {
			date = new Date($("#search").val());
		}
		date.setDate(date.getDate() + 1);//设置天数 +1 天  
		$("#search").val(date.format("yyyy-MM-dd"));
		checkRecording();
	});

	$(function() {
		if(!'${searchDay}'){
			$("#search").val(new Date().format("yyyy-MM-dd"));
		}else{
			$("#search").val(new Date('${searchDay}').format("yyyy-MM-dd"));
		}
		checkRecording();
	});

    //检测结果
    function checkRecording(){
    	var today = $("#search").val();
    	if(!today){
    		today = new Date().format("yyyy-MM-dd");
    	}
    	if("${regObject}"){
	    	$.ajax({
    	        type: "POST",
    	        url: '${webRoot}'+"/interfaces/dataChecking/queryDataCheckByRegobjId.do",
    	        data: {"regId":"${regObject.id}","checkDate":today},
    	        dataType: "json",
    	        success: function(data){
    	        	$("#recordings").html("");
    	        	if(data && data.success){
    	        		if(data.obj.recordings){
    	        			for(var i=0;i<data.obj.recordings.length;i++){
    	        				var template;
    	        				var regType = 2;	//默认餐饮单位
    	        				if('${regType}'){
    	        					regType = '${regType.regTypeCode}';
    	        				}
    	        				if(regType == '0'){
    	        					//经营单位
			    	        		template = $("#template1").clone();
			    	        		template.find(".recordingNo").text(i+1);
			    	        		template.find(".opeShop").text(data.obj.recordings[i].opeShopCode);
			    	        		template.find(".foodName").text(data.obj.recordings[i].foodName);
			    	        		template.find(".itemName").text(data.obj.recordings[i].itemName);
			    	        		template.find(".conclusion").text(data.obj.recordings[i].conclusion);
			    	        		template.find(".batchNumer").text(data.obj.recordings[i].batchNumer);
			    	        		if(data.obj.recordings[i].purchaseDate){
				    	        		template.find(".purchaseDate").text(new Date(data.obj.recordings[i].purchaseDate).format("yyyy-MM-dd"));
			    	        		}
			    	        		template.find(".origin").text(data.obj.recordings[i].origin);
			    	        		template.find(".supplier").text(data.obj.recordings[i].supplier);
			    	        		template.find(".address").text(data.obj.recordings[i].address);
			    	        		template.find(".persion").text(data.obj.recordings[i].persion);
			    	        		template.find(".phone").text(data.obj.recordings[i].phone);
			    	        		
    	        				}else if(regType == '1'){
    	        					//生产单位
    	        					template = $("#template2").clone();
    	        					template.find(".recordingNo").text(i+1);
			    	        		template.find(".foodName").text(data.obj.recordings[i].foodName);
			    	        		template.find(".itemName").text(data.obj.recordings[i].itemName);
			    	        		template.find(".conclusion").text(data.obj.recordings[i].conclusion);
			    	        		template.find(".batchNumer").text(data.obj.recordings[i].batchNumer);
			    	        		if(data.obj.recordings[i].purchaseDate){
				    	        		template.find(".purchaseDate").text(new Date(data.obj.recordings[i].purchaseDate).format("yyyy-MM-dd"));
			    	        		}
    	        					
    	        				}else{
    	        					//餐饮单位或其他
    	        					template = $("#template3").clone();
    	        					template.find(".recordingNo").text(i+1);
			    	        		template.find(".foodName").text(data.obj.recordings[i].foodName);
			    	        		template.find(".itemName").text(data.obj.recordings[i].itemName);
			    	        		template.find(".conclusion").text(data.obj.recordings[i].conclusion);
			    	        		if(data.obj.recordings[i].purchaseDate){
				    	        		template.find(".purchaseDate").text(new Date(data.obj.recordings[i].purchaseDate).format("yyyy-MM-dd"));
			    	        		}
    	        				}
		    	        		
		    	        		if(data.obj.recordings[i].conclusion == '合格'){
		    	        			template.find(".itemNo").attr("class","ui-pos-ab ui-ab-wh ui-success");
		    	        			template.find(".conclusion").attr("class","ui-green");
		    	        		}else if(data.obj.recordings[i].conclusion == '不合格'){
		    	        			template.find(".itemNo").attr("class","ui-pos-ab ui-ab-wh ui-danger");
		    	        			template.find(".conclusion").attr("class","ui-red");
		    	        		}else{
		    	        			template.find(".conclusion").text("未完成");
		    	        		}
		    	        		
		    	        		$("#recordings").append(template.html());
    	        			}
    	        		}
    	        	}
    			}
    	    });
    	}
    }
</script>
</html>
