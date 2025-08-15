<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- <%@include file="/WEB-INF/view/common/resource.jsp"%> --%>
<%@include file="/WEB-INF/view/wx/wxResource.jsp"%>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="initial-scale=1, maximum-scale=1, user-scalable=no">
<meta name="format-detection" content="telephone=no">
<title>快检服务云平台</title>
<%-- <link rel="stylesheet" type="text/css" href="${webRoot}/css/app/bootstrap.css" />
<link rel="stylesheet" type="text/css" href="${webRoot}/css/app/index.css" /> --%>
</head>
 <script type="text/javascript" src="${webRoot}/js/dy-switch.js"></script>
 <style type="text/css">
	.traceability {
	    display: none;
	}
	.ui-col-1 {
		width: 34%;
		max-width: 120px;
		text-align: right;
		float: left;
		white-space: nowrap;
	}
	.ui-col-3 {
		width: 66%;
		text-align: left;
		float: left;
	}
	.ui-ul-pad {
		padding-left: 8%;
	}
	.ui-ab-wh{
		display: flex;
		align-items: center;
		justify-content: center;
	}

 </style>
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
			<%--	<li class="ui-border-b clearfix">
					<div class="ui-list-info ui-col ui-col-1">联系电话：</div>
					<div class="ui-list-action ui-list-info ui-col ui-col-3">
						<c:if test="${!empty regObject}">${regObject.linkPhone}</c:if>
					</div>
				</li>--%>
				<li class="ui-border-b clearfix">
					<div class="ui-list-info ui-col ui-col-1">社会信用代码：</div>
					<div class="ui-list-action ui-list-info ui-col ui-col-3">
						<c:if test="${!empty regObject}">${regObject.creditCode}</c:if>
					</div>
				</li>
			</ul>
		</div>
		<div class="ui-headed" style="margin-top: 10px;">
			<h4>样品检测</h4>
		</div>
		<div class="ui-time clearfix" style=" text-align: center;">
		 <a href="javascript:;" class="ui-day-pre">&lt; 前一天</a> <input type="date" id="search" class="ui-search-time" /> <a href="javascript:" class="ui-day-next">后一天 &gt; </a>
		</div>
	
		<div id="recordings"></div>

		<div class="ui-footer" style="font-size: 14px;">
			<a href="http://www.chinafst.cn/CH/index.php"></a>${copyright}
		</div>
	</section>

	<!-- 经营单位 -->
	<div id="template1" style="display: none;">
		<div class="ui-third-info clearfix  ui-b-none">
			<ul class="ui-bg-white  ui-pos-re  ui-border-dotted">
				<li class="ui-pos-ab ui-ab-wh ui-success itemNo">
					<div class="cs-dis-table">
						<span class="recordingNo">1</span>
					</div>
				</li>
				<li class="clearfix">
					<div class="ui-li-height ui-col-1">
						<c:choose>
							<c:when test="${systemFlag==1}">
								摊位名称：
							</c:when>
							<c:otherwise>
								档口名称：
							</c:otherwise>
						</c:choose>

					</div>
					<div class="ui-list-action ui-li-height ui-col-3 opeShop"></div>
				</li>
				<li class="clearfix">
					<div class="ui-li-height ui-col-1">样品名称：</div>
					<div class="ui-list-action ui-li-height ui-col-3">
						<span class="ui-fl ui-back-width foodName"></span>
						<div class="ui-back-btn ui-fl traceability">
							<a href="javascript:" class="ui-find ui-fr"> <span>溯源</span> <span class="iconfont icon-xia"></span>
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
				<li class="clearfix">
					<div class="ui-li-height ui-col-1">检测时间：</div>
					<div class="ui-list-action ui-li-height ui-col-3 checkDate"></div>
				</li>
			</ul>
			<div class="ui-back-info ui-hide  ui-padding">
				<ul class="ui-bg-white  ui-pos-re ui-ul-pad  ui-border-left ">
					<li>
						<h5>溯源信息</h5>
					</li>
					
					<li class="clearfix tzsyli">
	                  <div class="ui-li-height ui-col-1">来源/市场：</div>
	                  <div class="ui-list-action ui-li-height ui-col-3">
							<span class="market"></span>
						</div>
	                </li>
					<li class="clearfix">
						<div class="ui-li-height ui-col-1">
							<c:choose>
								<c:when test="${systemFlag==1}">
									供货摊位：
								</c:when>
								<c:otherwise>
									供货档口：
								</c:otherwise>
							</c:choose>
						</div>
						<div class="ui-list-action ui-li-height ui-col-3">
							<span class="supplier"></span>
						</div>
					</li>
					<li class="clearfix">
						<div class="ui-li-height ui-col-1">供货者名称：</div>
						<div class="ui-list-action ui-li-height ui-col-3">
							<span class="persion"></span>
						</div>
					</li>
					<li class="clearfix">
						<div class="ui-li-height ui-col-1">供货者电话：</div>
						<div class="ui-list-action ui-li-height ui-col-3">
							<span class="phone"></span>
						</div>
					</li>
					<!-- 
					<li class="clearfix">
						<div class="ui-li-height ui-col-1">供应商地址：</div>
						<div class="ui-list-action ui-li-height ui-col-3">
							<span class="address"></span>
						</div>
					</li>
					 -->
					<li class="clearfix tzsyli">
						<div class="ui-li-height ui-col-1">生产日期：</div>
						<div class="ui-list-action ui-li-height ui-col-3 productionDate"></div>
					</li>
					<li class="clearfix">
						<div class="ui-li-height ui-col-1">进货日期：</div>
						<div class="ui-list-action ui-li-height ui-col-3 purchaseDate"></div>
					</li>
					<%--<li class="clearfix">
						<div class="ui-li-height ui-col-1">保质期：</div>
						<div class="ui-list-action ui-li-height ui-col-3 expirationDate"></div>
					</li>--%>
					<li class="clearfix">
						<div class="ui-li-height ui-col-1">产地：</div>
						<div class="ui-list-action ui-li-height ui-col-3">
							<span class="origin"></span>
						</div>
					</li>
					<li class="clearfix">
						<div class="ui-li-height ui-col-1">批次：</div>
						<div class="ui-list-action ui-li-height ui-col-3 batchNumer"></div>
					</li>
					<li class="clearfix">
						<div class="ui-li-height ui-col-1">进货数量：</div>
						<div class="ui-list-action ui-li-height ui-col-3 purchaseAmount"></div>
					</li>
					
					<!-- 台账溯源 -->
					<li class="clearfix tzsyli">
	                  <div class="ui-li-height ui-col-1">
	                  	检验编码：
	                  </div>
	                  <div class="ui-list-action ui-li-height ui-col-3">
	                  	<span class="checkProof"></span>
	                  </div>
	                </li>
	                <li class="clearfix tzsyli">
	                  <div class="ui-li-height ui-col-1">
	                  	检验证明图片：
	                  </div>
	                  <div class="ui-list-action ui-li-height ui-col-3">
		                  <span class="ui-img-box checkProof_img_box">
		                 	<!-- <a class="checkProof_a">
		                 		<img alt="" class="checkProof_img">
		                 	</a> -->
		                  </span>
	                  </div>
	                </li>
	                <li class="clearfix tzsyli">
	                  <div class="ui-li-height ui-col-1">
	                  	检疫编码：
	                  </div>
	                  <div class="ui-list-action ui-li-height ui-col-3">
	                  	<span class="quarantineProof"></span>
	                  </div>
	                </li>
	                <li class="clearfix tzsyli">
	                  <div class="ui-li-height ui-col-1">
	                  	检疫证明图片：
	                  </div>
	                  <div class="ui-list-action ui-li-height ui-col-3">
		                  <span class="ui-img-box quarantineProof_img_box">
		                 	<!-- <a class="quarantineProof_a">
		                 		<img alt="" class="quarantineProof_img">
		                 	</a> -->
		                  </span>
	                  </div>
	                </li>
	                <li class="clearfix tzsyli">
	                  <div class="ui-li-height ui-col-1">
	                  	进货凭证图片：
	                  </div>
	                  <div class="ui-list-action ui-li-height ui-col-3">
	                  	<span class="ui-img-box stockProof_img_box">
			                 <!-- <a class="stockProof_a">
			                 	<img alt="" class="stockProof_img">
			                 </a> -->
	                  	</span>
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
					<div class="ui-li-height ui-col-1">检测时间：</div>
					<div class="ui-list-action ui-li-height ui-col-3 checkDate"></div>
				</li>
			<%--	<li class="clearfix">
					<div class="ui-li-height ui-col-1">生产日期：</div>
					<div class="ui-list-action ui-li-height ui-col-3 purchaseDate"></div>
				</li>
				<li class="clearfix">
					<div class="ui-li-height ui-col-1">批次：</div>
					<div class="ui-list-action ui-li-height ui-col-3 batchNumer"></div>
				</li>--%>
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
				<%--<li class="clearfix">
					<div class="ui-li-height ui-col-1">生产日期：</div>
					<div class="ui-list-action ui-li-height ui-col-3 purchaseDate"></div>
				</li>--%>
				<li class="clearfix">
					<div class="ui-li-height ui-col-1">检测结果：</div>
					<div class="ui-list-action ui-li-height ui-col-3">
						<span class="conclusion"></span>
					</div>
				</li>
				<li class="clearfix">
					<div class="ui-li-height ui-col-1">检测时间：</div>
					<div class="ui-list-action ui-li-height ui-col-3 checkDate"></div>
				</li>
			</ul>
		</div>
	</div>
	
	<div id="img_template" style="display: none;">
		<a>
   			<img>
       	</a>
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
			date = newDate();//获取当前时间  
		} else {
			date = newDate($("#search").val());
		}
		date.setDate(date.getDate() - 1);//设置天数 -1 天  
		$("#search").val(date.format("yyyy-MM-dd"));
		checkRecording();
	});
	//后一天
	$(document).on("click", ".ui-day-next", function() {
		var date;
		if (!$("#search").val()) {
			date = newDate();//获取当前时间  
		} else {
			date = newDate($("#search").val());
		}
		date.setDate(date.getDate() + 1);//设置天数 +1 天  
		$("#search").val(date.format("yyyy-MM-dd"));
		checkRecording();
	});

	$(function() {
		var sday = '${searchDay}';
    	if(!sday){
			$("#search").val(newDate().format("yyyy-MM-dd"));
		}else{
			$("#search").val(newDate(sday).format("yyyy-MM-dd"));
		}
		checkRecording();
	});

    //检测结果
    function checkRecording(){
    	var today = $("#search").val();
    	if(!today){
    		today = newDate().format("yyyy-MM-dd");
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
    	        				if(regType == '0' || regType == '01' || regType == '11'){
    	        					//经营单位、冷库
			    	        		template = $("#template1").clone();
			    	        		template.find(".recordingNo").text(i+1);
			    	        		template.find(".opeShop").text(data.obj.recordings[i].opeShopCode);
			    	        		template.find(".foodName").text(data.obj.recordings[i].foodName);
			    	        		template.find(".itemName").text(data.obj.recordings[i].itemName);
			    	        		template.find(".conclusion").text(data.obj.recordings[i].conclusion);
			    	        		template.find(".batchNumer").text(data.obj.recordings[i].batchNumer);
									template.find(".checkDate").text(newDate(data.obj.recordings[i].checkDate).format("yyyy-MM-dd HH:mm:ss"));
			    	        		if(data.obj.recordings[i].purchaseDate){
				    	        		template.find(".purchaseDate").text(newDate(data.obj.recordings[i].purchaseDate).format("yyyy-MM-dd"));
			    	        		}
			    	        		template.find(".origin").text(data.obj.recordings[i].origin);
			    	        		template.find(".supplier").text(data.obj.recordings[i].supplier);
			    	        		//template.find(".address").text(data.obj.recordings[i].address);
			    	        		template.find(".persion").text(data.obj.recordings[i].persion);
			    	        		template.find(".phone").text(data.obj.recordings[i].phone);
                                    if(data.obj.recordings[i].purchaseAmount){
                                        template.find(".purchaseAmount").text(data.obj.recordings[i].purchaseAmount+" kg");
                                    }
			    	        		if(data.obj.souce == '1' && data.obj.recordings[i].ledgerStock){//台账溯源
			    	        			
			    	        			if(data.obj.recordings[i].ledgerStock.param1){
				    	        			template.find(".market").text(data.obj.recordings[i].ledgerStock.param1);
				    	        		}
			    	        			if(data.obj.recordings[i].ledgerStock.productionDate){
					    	        		template.find(".productionDate").text(newDate(data.obj.recordings[i].ledgerStock.productionDate).format("yyyy-MM-dd"));
				    	        		}
				    	        		if(data.obj.recordings[i].ledgerStock.stockDate){
					    	        		template.find(".purchaseDate").text(newDate(data.obj.recordings[i].ledgerStock.stockDate).format("yyyy-MM-dd"));
				    	        		}
				    	        		/*if(data.obj.recordings[i].ledgerStock.expirationDate){
					    	        		template.find(".expirationDate").text(data.obj.recordings[i].ledgerStock.expirationDate);
				    	        		}*/
				    	        		if(data.obj.recordings[i].ledgerStock.batchNumber){
				    	        			template.find(".batchNumer").text(data.obj.recordings[i].ledgerStock.batchNumber);
				    	        		}
			    	        			if(data.obj.recordings[i].ledgerStock.productionPlace){
					    	        		template.find(".origin").text(data.obj.recordings[i].ledgerStock.productionPlace);
				    	        		}
				    	        		if(data.obj.recordings[i].ledgerStock.supplier){
					    	        		template.find(".supplier").text(data.obj.recordings[i].ledgerStock.supplier);
				    	        		}
				    	        		if(data.obj.recordings[i].ledgerStock.supplierUser){
					    	        		template.find(".persion").text(data.obj.recordings[i].ledgerStock.supplierUser);
				    	        		}
				    	        		if(data.obj.recordings[i].ledgerStock.supplierTel){
					    	        		template.find(".phone").text(data.obj.recordings[i].ledgerStock.supplierTel);
				    	        		}
				    	        		if(data.obj.recordings[i].ledgerStock.stockCount){
					    	        		template.find(".purchaseAmount").text(data.obj.recordings[i].ledgerStock.stockCount + data.obj.recordings[i].ledgerStock.size);
				    	        		}
			    	        			
			    	        			template.find(".checkProof").text(data.obj.recordings[i].ledgerStock.checkProof);
			    	        			template.find(".quarantineProof").text(data.obj.recordings[i].ledgerStock.quarantineProof);
			    	        			
			    	        			if(data.obj.recordings[i].ledgerStock.checkProof_Img){
			    	        				var imgs = data.obj.recordings[i].ledgerStock.checkProof_Img.split(",");
			    	        				$.each(imgs,function(i,val){
			    	        					var imgTemplate = $("#img_template").clone();
			    	        					imgTemplate.find("a").attr("href", '${webRoot}/resources/stock/' + val);
			    	        					imgTemplate.find("img").attr("src", '${webRoot}/resources/stock/' + val);
			    	        					
			    	        					template.find(".checkProof_img_box").append(imgTemplate.html());
			    	        				});
			    	        			}
			    	        			
			    	        			if(data.obj.recordings[i].ledgerStock.quarantineProof_Img){
			    	        				var imgs = data.obj.recordings[i].ledgerStock.quarantineProof_Img.split(",");
			    	        				$.each(imgs,function(i,val){
			    	        					var imgTemplate = $("#img_template").clone();
			    	        					imgTemplate.find("a").attr("href", '${webRoot}/resources/stock/' + val);
			    	        					imgTemplate.find("img").attr("src", '${webRoot}/resources/stock/' + val);
			    	        					
			    	        					template.find(".quarantineProof_img_box").append(imgTemplate.html());
			    	        				});
			    	        			}
			    	        			
			    	        			if(data.obj.recordings[i].ledgerStock.stockProof_Img){
			    	        				var imgs = data.obj.recordings[i].ledgerStock.stockProof_Img.split(",");
			    	        				$.each(imgs,function(i,val){
			    	        					var imgTemplate = $("#img_template").clone();
			    	        					imgTemplate.find("a").attr("href", '${webRoot}/resources/stock/' + val);
			    	        					imgTemplate.find("img").attr("src", '${webRoot}/resources/stock/' + val);
			    	        					
			    	        					template.find(".stockProof_img_box").append(imgTemplate.html());
			    	        				});
			    	        			}
			    	        		}else{
			    	        			template.find(".tzsyli").remove();
			    	        		}
			    	        		
    	        				}else if(regType == '1'){
    	        					//生产单位
    	        					template = $("#template2").clone();
    	        					template.find(".recordingNo").text(i+1);
			    	        		template.find(".foodName").text(data.obj.recordings[i].foodName);
			    	        		template.find(".itemName").text(data.obj.recordings[i].itemName);
			    	        		template.find(".conclusion").text(data.obj.recordings[i].conclusion);
			    	        		template.find(".batchNumer").text(data.obj.recordings[i].batchNumer);
									template.find(".checkDate").text(newDate(data.obj.recordings[i].checkDate).format("yyyy-MM-dd HH:mm:ss"));
			    	        		if(data.obj.recordings[i].purchaseDate){
				    	        		template.find(".purchaseDate").text(newDate(data.obj.recordings[i].purchaseDate).format("yyyy-MM-dd"));
			    	        		}
    	        					
    	        				}else{
    	        					//餐饮单位或其他
    	        					template = $("#template3").clone();
    	        					template.find(".recordingNo").text(i+1);
			    	        		template.find(".foodName").text(data.obj.recordings[i].foodName);
			    	        		template.find(".itemName").text(data.obj.recordings[i].itemName);
			    	        		template.find(".conclusion").text(data.obj.recordings[i].conclusion);
									template.find(".checkDate").text(newDate(data.obj.recordings[i].checkDate).format("yyyy-MM-dd HH:mm:ss"));
			    	        		if(data.obj.recordings[i].purchaseDate){
				    	        		template.find(".purchaseDate").text(newDate(data.obj.recordings[i].purchaseDate).format("yyyy-MM-dd"));
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
    	        			
    	        			//扫描抽样单、监管对象、经营户二维码进入的页面溯源权限控制
    	        			if(DySwitch.traceability()){
    	        				$(".traceability").show();
    	        			}else{
    	        				$(".traceability").hide();
    	        			}
    	        			
    	        		}
    	        	}
    			}
    	    });
    	}
    }
</script>
</html>
