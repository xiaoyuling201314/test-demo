<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/terminal/resource.jsp"%>
<!doctype html>
<html lang="en" class="no-js">
<head>
<meta charset="utf-8" />
<title>自助终端</title>
<meta name="description" content="">
<meta name="keywords" content="">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
<style type="text/css">
	html,body,.zz-content{/*
		overflow:hidden;
		min-height:1024px;
		height:auto;*/
		/* width:auto; */
	}
	
  	#myContent2{
 		display:none
 	}   
 	.zz-printed-hight{
		height: 614px;
		overflow: auto;
	}
	/* .zz-printed table{
	background: #ddd;	
	} */
	.zz-printed-bg{
		background: #e1e9f5;
	}

	div.zz-tb-bg{
		border-radius: 0;
	}
	.zz-printed-title{
		padding: 5px 10px;
		font-size: 20px;
		text-align: center;
	}
	.zz-printed2 table{
		margin-bottom: 10px;
	}
	.print-current{
		background: #f5a52d;
	}
	.print-all{
		border-radius: 5px 5px 0 0;
		line-height: 32px;
    	height: 46px;
    	font-size: 18px;
	}
	.print-btns{
		padding-bottom: 0;
	}
	.print-current {
    background: #4887ef;
}
#myContent2 tr td{
	padding:0 0px;
}
.text-cursor{
		cursor:pointer;
}
</style>
<script type="text/javascript">

</script>
 <script type="text/javascript" src="${webRoot}/plug-in/pazu/pReport.js"></script>
 <script type="text/javascript" src="${webRoot}/plug-in/pazu/pazuclient.js"></script>
 <script type="text/javascript" src="${webRoot}/js/showTime.js"></script>
</head>

<body  style="tab-interval: 21pt; text-justify-trim: punctuation;"  >
	 <div id="div_PAZU_Tips" style="color:red;background-color:yellow;padding:10px;border:1px solid red;" class="cs-hide">
	    *没有检测到PAZU云打印(位于localhost)，请<a href="${webRoot}/plug-in/pazu/PAZUCloud_Setup.exe">下载安装并刷新本页</a>
	    <br/>
	    安装程序会修改 hosts 文件（把 localhost.pazu.4fang 指向 127.0.0.1），请务必让杀毒允许此操作。
	</div> 	
	 <div class="zz-content" id="myContent1">
    	<div class="zz-title2">
			<img class="pull-left" src="${webRoot}/img/terminal/title2.png" alt=""><span >订单打印</span>
			<i class="showTime cs-hide"></i>
    	</div>
		<div class="zz-cont-box">
			<div class=""></div>
			<div class="zz-base-info col-md-12 col-sm-12">
			
			<div class="zz-name zz-input col-md-6 col-sm-6">
                     <div class="pull-left zz-name2">订单编号：${bean.samplingNo }</div>
                     
                     </div>
                     <div class="zz-name zz-input col-md-6 col-sm-6">
                      <div class="pull-left zz-name2">下单时间：
						<c:if test="${!empty bean && !empty bean.samplingDate}">
                             <fmt:formatDate type="both" value="${bean.samplingDate}" />
                         </c:if></div> 
                     </div>
                   
              <%--  <div class="zz-name zz-input col-md-6 col-sm-6">
                     <div class="pull-left zz-name2">委托单位：${bean.regName }</div>
                     
                     </div>
                     <div class="zz-name zz-input col-md-6 col-sm-6">
                      <div class="pull-left zz-name2">联系电话：
						${bean.regLinkPhone }
                     </div>
                     </div> --%>
                     <c:choose>
                     	<c:when test="${bean.unitsCount>1 }">
                     	 	<div class="zz-name zz-input col-md-6 col-sm-6">
		                    	<div class="pull-left zz-name2">委托单位：
		                    	<span class="text-primary text-cursor" onclick="showRequestUnits('${bean.id}')">${bean.regName }
		                    		<i class="icon iconfont icon-chakan"></i>
		                    	</span>
		                    	</div>
		                    </div>
		                     <div class="zz-name zz-input col-md-6 col-sm-6">
			                      <div class="pull-left zz-name2">订单金额：
									<fmt:formatNumber value="${bean.inspectionFee }" pattern="0.00"/>元
			                     </div>
		                     </div>
                     	</c:when>
                     	<c:otherwise>
                     		<div class="zz-name zz-input col-md-6 col-sm-6">
		                    	<div class="pull-left zz-name2">委托单位：${bean.regName }</div>
		                    </div>
		                     <div class="zz-name zz-input col-md-6 col-sm-6">
			                      <div class="pull-left zz-name2">订单金额：
									<fmt:formatNumber value="${bean.inspectionFee }" pattern="0.00"/>元
			                     </div>
		                     </div>
                     	</c:otherwise>
                    </c:choose>
                   <div class="zz-name zz-input col-md-6 col-sm-6">
                     <div class="pull-left zz-name2"><c:if test="${!empty bean.inspectionId}">送检单位</c:if><c:if test="${empty bean.inspectionId}">送检人员</c:if>：${bean.inspectionCompany }</div>
                     
                     </div>
                     <div class="zz-name zz-input col-md-6 col-sm-6">
                      <div class="pull-left zz-name2">送检电话：
						${bean.param3 }
                     </div>
                     
                  </div>           
				
			</div>
			
			<div class="zz-table col-md-12 col-sm-12" clearfix>
				<div class="zz-tb-bg zz-tb-bg2" >
				<div class="print-btns clearfix">
					<c:set var="tab1" value="0" />
					<c:set var="tab2" value="0" />
					<c:set var="tab3" value="0" />
					<c:set var="tab4" value="0" />
						<c:forEach items="${list}" var="samplingDetail">
							<c:choose>
								<c:when test="${tab1==0 && samplingDetail.collectCode!=null && samplingDetail.conclusion!=''}">
									<c:forEach items="${receiverNumbers}" var="receiveBean" >
										<c:if test="${receiveBean.collectCode==samplingDetail.collectCode  &&  receiveBean.isFinished==true}">
											<c:set var="tab1" value="1" />
										</c:if>
									</c:forEach>
								</c:when>
								 <c:when test="${tab3==0 && samplingDetail.collectCode!=null &&  samplingDetail.conclusion==''}">
										<c:set var="tab3" value="1" />
								</c:when> 
								<c:when test="${tab4==0 && samplingDetail.collectCode==null}">
										<c:set var="tab4" value="1" />
								</c:when>
							</c:choose>
					</c:forEach>
					<c:if test="${tab1==1}"><div class="print-all" data-id="0">待打印</div></c:if>
<%-- 					<c:if test="${tab2==1}"><div class="print-all" data-id="1">已打印</div></c:if> --%>
					<c:if test="${tab3==1}"><div class="print-all" data-id="2">检测中</div></c:if>
					<c:if test="${tab4==1}"><div class="print-all" data-id="1">待送样</div></c:if>
				</div>
				<!-- tab 选项卡 start -->
				<!-- 未打印开始 2019-08-23 -->
				<c:if test="${tab1==1}">
					<div class="zz-printed zz-printed2 clearfix" >
					<div class="zz-printed-hight">
						<div class="zz-printed-bg">
					<table style="margin-bottom: 0" >
						<tr class="zz-tb-title">
							<th class="nums" style="width: 60px">序号</th>
							<th style="width: 10%">样品名称</th>
							<c:choose>
								<c:when test="${showPurchaseNumber==1 || showPurchaseNumber==2}">
									<th style="width: 100px;">进货数量(KG)</th>
									<th style="width: 19%">检测项目</th>
								</c:when>
								<c:otherwise>
									<th style="width: 17%">检测项目</th>
								</c:otherwise>
							</c:choose>
							<th style="width: 80px">检测结果</th>
							<th style="width: 150px">送样时间</th>
							<th class="nums"> 操作 </th>
						</tr>
						</table>
						<c:set var="showSerial" value="0"/>
						<c:forEach items="${receiverNumbers}" var="receiveBean" >
							<c:set var="showOne" value="0"/>
							<c:set var="showNumbers" value="0" />
							<c:if test="${receiveBean.isFinished==true }">
							<c:forEach items="${list}" var="samplingDetail" varStatus="index" >
									<c:set var="sampleTubeFirst">
										<fmt:formatDate value="${samplingDetail.sampleTubeTime }" pattern="yyyy-MM-dd HH:mm:ss"/>
									</c:set>
									<c:if test="${receiveBean.sampleTubeTime==sampleTubeFirst}">
										<c:set var="showNumbers" value="${showNumbers+1}" />
										<c:set var="showSerial" value="${showSerial+1}" />
										<input type="hidden" name="firstPrint-${receiveBean.reportNumber}" value="${samplingDetail.id }" data-report="${receiveBean.reportNumber}" />
										<c:if test="${showNumbers==1 }"><table></c:if>
											<tr data-id="${samplingDetail.id }">
												<td class="nums" style="width: 60px">${showSerial}</td>
												<td style="width: 10%">${samplingDetail.foodName }</td>
												<c:choose>
													<c:when test="${showPurchaseNumber==1 || showPurchaseNumber==2}">
														<td style="width: 100px;">${samplingDetail.purchaseAmount }</td>
														<td style="width: 19%">${samplingDetail.itemName }</td>
													</c:when>
													<c:otherwise>
														<td style="width: 17%">${samplingDetail.itemName }</td>
													</c:otherwise>
												</c:choose>
												<td style="width: 80px">${samplingDetail.conclusion}</td>
												<c:if test="${showOne==0}"> 
	 												<c:set var="showOne" value="1"/>
													<td rowspan="${receiveBean.receiveCount}" style="width: 150px">
														${receiveBean.sampleTubeTime}
													</td>
													<td rowspan="${receiveBean.receiveCount}" class="nums">
													<div class="btn text-primary zz-show-btn1 _add_btn printBtn"  onclick="choseRequestUnits('${samplingDetail.samplingId }','${samplingDetail.collectCode}',${receiveBean.pageNo });">打印</div></td>
												</c:if>  
											</tr>
										</c:if>
								<c:if test="${fn:length(list)==index.index+1 }">
									</table>
								</c:if>
							</c:forEach> 
							</c:if>
						</c:forEach>
					</div>
					</div>
					</div>
				</c:if>
				<!-- 未打印结束 -->
				<!-- 已打印开始 add by xiaoyl 2019-08-13 -->
				<%-- <c:if test="${tab2==1}">
					<div class="zz-printed zz-printed2 clearfix" style="display:none">
					<div class="zz-printed-hight">
						<div class="zz-printed-bg">
								<table style="margin-bottom: 0">
									<tr class="zz-tb-title">
										<th class="nums">序号</th>
										<th style="width: 15%">样品名称</th>
										<th style="width: 15%">检测项目</th>
										<th style="width: 10%">检测结果</th>
										<th style="width: 20%">送样时间</th>
										<th class="nums">操作</th>
									</tr>
								</table>
								<c:set var="showSerial" value="0"/>
								<c:forEach items="${reportNumbers}" var="report">
									<c:set var="showReport" value="0"/>
									<c:set var="showNumbers" value="0" />
									<c:forEach items="${list}" var="samplingDetail" varStatus="index" >
										<c:if test="${report.reportNumber==samplingDetail.reportNumber }">
										<c:set var="showNumbers" value="${showNumbers+1}" />
										<c:set var="showSerial" value="${showSerial+1}" />
										<input type="hidden" name="replayPrint-${report.reportNumber}" value="${samplingDetail.id }" data-report="${report.reportNumber}" />
										<c:if test="${showNumbers==1 }"><table></c:if>
											<c:set var="sampleTubeTime">
												<fmt:formatDate value="${samplingDetail.sampleTubeTime }" pattern="yyyy-MM-dd HH:mm:ss"/>
											</c:set>
											<tr>
												<td class="nums">${showSerial}</td>
												<td style="width: 15%">${samplingDetail.foodName }</td>
												<td style="width: 15%">${samplingDetail.itemName }</td>
												<td style="width: 10%">${samplingDetail.conclusion }</td>
 												<c:if test="${showReport==0}"> 
 													<c:set var="showReport" value="1"/>
 													<td rowspan="${report.samplingCount}" style="width: 20%">
														${sampleTubeTime}
						          					</td>
					          						<td rowspan="${report.samplingCount}" class="nums">
						          						<div class="btn text-primary zz-show-btn1 _add_btn printBtn"  onclick="printReport(${report.reportNumber});">重打</div>
						          					</td>
 												 </c:if>  
												</tr>
										</c:if>
										<c:if test="${fn:length(list)==index.index+1 }">
											</table>
										</c:if>
									</c:forEach>
								</c:forEach>
						</div>
						</div>
					</div>
				</c:if> --%>
				<!-- 已打印结束 -->
				<!-- 检测中开始 add by xiaoyl 2019-08-13 -->
				 <c:if test="${tab3==1}">
					<div class="zz-printed zz-printed2 clearfix" style="display:none">
					<div class="zz-printed-hight">
						<div class="zz-printed-bg">
						<table style="margin-bottom: 0">
							<tr class="zz-tb-title">
								<th class="nums" style="width: 60px">序号</th>
								<th style="width: 15%">样品名称</th>
								<c:choose>
									<c:when test="${showPurchaseNumber==1 || showPurchaseNumber==2}">
										<th style="width: 100px;">进货数量(KG)</th>
										<th style="width: 19%">检测项目</th>
									</c:when>
									<c:otherwise>
										<th style="width: 17%">检测项目</th>
									</c:otherwise>
								</c:choose>
								<th style="width: 100px">检测结果</th>
								<th style="width: 15%">送样时间</th>
								</tr>
								</table>
								<c:set var="showSerial" value="0"/>
								<c:forEach items="${receiverNumbers}" var="receiveBean">
								<c:if test="${receiveBean.isFinished==false }">
									<c:set var="showCheck" value="0"/>
									<c:set var="showNumbers" value="0" />
									<c:forEach items="${list}" var="samplingDetail" varStatus="index" >
									<c:if test="${samplingDetail.collectCode!=null && samplingDetail.collectCode==receiveBean.collectCode}">
										<c:set var="sampleTubeTime">
											<fmt:formatDate value="${samplingDetail.sampleTubeTime }" pattern="yyyy-MM-dd HH:mm:ss"/>
										</c:set>
											<c:if test="${receiveBean.sampleTubeTime==sampleTubeTime}">
													<c:set var="showNumbers" value="${showNumbers+1}" />
													<c:set var="showSerial" value="${showSerial+1}" />
													<c:if test="${showNumbers==1 }"><table></c:if>
													<tr>
														<td class="nums" style="width: 60px">${showSerial}</td>
														<td style="width: 15%">${samplingDetail.foodName }</td>
														<c:choose>
															<c:when test="${showPurchaseNumber==1 || showPurchaseNumber==2}">
																<td style="width: 100px;">${samplingDetail.purchaseAmount }</td>
																<td style="width: 19%">${samplingDetail.itemName }</td>
															</c:when>
															<c:otherwise>
																<td style="width: 17%">${samplingDetail.itemName }</td>
															</c:otherwise>
														</c:choose>
														<td style="width: 100px">${samplingDetail.conclusion=="" ? "检测中" : samplingDetail.conclusion}</td>
														<c:if test="${showCheck==0}"> 
			 												<c:set var="showCheck" value="1"/>
															<td style="width: 15%" rowspan="${receiveBean.receiveCount}">
																${sampleTubeTime}
															</td>
	 												 	</c:if>  
													</tr>
												</c:if>
									
										</c:if>
										<c:if test="${fn:length(list)==index.index+1 }">
											</table>
										</c:if>
									</c:forEach> 
									</c:if>
								</c:forEach>
						</div>
						</div>
					</div>
				</c:if> 
				<!-- 检测中结束 -->
				<!-- 待收样开始 add by xiaoyl 2019-08-23 -->
				<c:if test="${tab4==1}">
					<div class="zz-printed zz-printed2 clearfix" style="display:none">
					<div class="zz-printed-hight">
						<div class="zz-printed-bg">
						<table>
							<tr class="zz-tb-title">
								<th class="nums" style="width: 60px">序号</th>
								<th style="width: 15%">样品名称</th>
								<c:choose>
									<c:when test="${showPurchaseNumber==1 || showPurchaseNumber==2}">
										<th style="width: 100px;">进货数量(KG)</th>
										<th style="width: 19%">检测项目</th>
									</c:when>
									<c:otherwise>
										<th style="width: 17%">检测项目</th>
									</c:otherwise>
								</c:choose>
								<th style="width: 20%">下单时间</th>
								</tr>
								<c:set var="showNumbers" value="0" />
								<c:forEach items="${list}" var="samplingDetail" varStatus="index" >
									<c:if test="${samplingDetail.collectCode==null}">
									<c:set var="showNumbers" value="${showNumbers+1}" />
										<tr>
											<td style="width: 60px">${showNumbers}</td>
											<td>${samplingDetail.foodName }</td>
											<c:choose>
												<c:when test="${showPurchaseNumber==1 || showPurchaseNumber==2}">
													<td style="width: 100px;">${samplingDetail.purchaseAmount }</td>
													<td style="width: 19%">${samplingDetail.itemName }</td>
												</c:when>
												<c:otherwise>
													<td style="width: 17%">${samplingDetail.itemName }</td>
												</c:otherwise>
											</c:choose>
											<td><fmt:formatDate value="${bean.samplingDate}" pattern="yyyy-MM-dd HH:mm:ss"/> </td>
										</tr>
									</c:if>
								</c:forEach> 
							</table>
						</div>
						</div>
					</div>
				</c:if>
				<!-- 待收样结束 -->
				<!-- tab 选项卡 end -->
				</div>
			</div>
		
			<div class="zz-tb-btns col-md-12 col-sm-12">
			<c:choose>
				<c:when test="${outPrint==1}">
					<a href="${webRoot}/reportPrint/printNoLogin" class="btn btn-danger _cancel_btn">返回</a>
				</c:when>
				<c:otherwise>
					<a href="${webRoot}/reportPrint/list" class="btn btn-danger _cancel_btn">返回</a>
				</c:otherwise>
			</c:choose>
			</div>
		</div>

		<div class="zz-left"><img src="${webRoot}/img/terminal/left.png" alt=""></div>
		<div class="zz-right"><img src="${webRoot}/img/terminal/right.png" alt=""></div>
		
    </div>

    <div class="zz-content" id="myContent2" style="text-justify-trim:punctuation;">
		<style media="print">#myContent2{display:block}</style>
		<div class="Section0" style="layout-grid: 15.6000pt;">
			<div align=center>
				<%--合并打印--%>
				<!--StartFragment-->
					<%@include file="/WEB-INF/view/terminal/report/printForMutl.jsp"%>
				<!--EndFragment-->
			</div>
		</div>
	 </div>
	 
	<%@include file="/WEB-INF/view/terminal/showUnitConfirm.jsp"%>
    <%@include file="/WEB-INF/view/terminal/report/choseUnitConfirm.jsp"%>
    <%@include file="/WEB-INF/view/terminal/keyboard_input.jsp"%> 
	 <%@include file="/WEB-INF/view/terminal/tips.jsp"%>
	 <%@include file="/WEB-INF/view/common/modalBox.jsp"%>
	 <script>
	 $('.print-all').eq(0).click();
	 $('.zz-printed').eq(0).show().siblings('.zz-printed').hide();
	 $('.print-all').eq(0).addClass('print-current')
	 var tabIndex=$('.print-all').eq(0).attr("data-id");
	 var requestList=[];//已选择委托单位集合
	 var samplingId;//订单Id
	 var collectCode;//收样批次
	 var requestIds;
	 var pageNo=1;
	 $(document).on('click','.print-all',function(){
			var ti=$(this).index();
			tabIndex=$(this).attr("data-id");
			$(this).addClass('print-current').siblings().removeClass('print-current')
			$('.zz-printed').eq(ti).show().siblings('.zz-printed').hide();
			if(tabIndex!=0){
				$("#showPrintBtn").hide();
			}else{
				$("#showPrintBtn").show();
			}
	});
	 //选择委托单位： id:订单ID，collectCode：收样批次编号,pageNo 打印页数
	 function choseRequestUnits(id,collectCodeNumber,pageNumber){
		 samplingId=id;
		 collectCode=collectCodeNumber;
		 pageNo=pageNumber;
		 $("#_chose_reg_modal").modal("show");
		
	 }
	 //打印
	 function preview(){
		 //调用后台方法，将base64生成图片存放在指定路径下${webRoot}/img/report
		 $.ajax({
		        type: "POST",
		        url: "${webRoot}/reportPrint/GeneratorImage",
		        data: {"rdataId":"${rdataId}"},
		        dataType: "json",
		        async:false,
		        success: function(data) {
		            if (data && data.success) {
		            	 chkPAZU();
		        		 if (!!window.ActiveXObject || "ActiveXObject" in window) {
		        			 remove_ie_header_and_footer();
		        		 }
		        		 requestIds="";
		        		 $("#_chose_reg_modal").modal("hide");
		        		 if("${reportConfig.print_signature}"!="0") {
			        			$(".signatureImageSpan").html("");
			        		}
		        		 doPagesetup();
		        		 for (var i = 0; i < requestList.length; i++) {
		        			  if(tabId==0){//首次打印
		        			 		requestIds+=requestList[i].requestId+","
		        			  }else{
		        				  requestIds+=requestList[i].printId+","
		        			  }
		        			 for(var j=1;j<=pageNo;j++){
// 		        				 PAZU.TPrinter.footer="第"+j+"页 - 共"+pageNo+"页";
// 		        				 PAZU.TPrinter.fontCSS="font-family: 宋体;font-size:9pt;margin-left:195px;";
			        			 $("._"+collectCode+"_"+j).find("#qrCodePath").attr("src","${webRoot}/pay/generatorQrCode?qrCode=${samplingQrPath}&collectCode="+collectCode+"&scan=1&unitId="+requestList[i].requestId)
			        			 $("._"+collectCode+"_"+j).find("#requesterName").html(requestList[i].requestName)
	//		        				 $("._"+collectCode).find("#requesterPhone").html(requestList[i].linkPhone)
			        			 $("._"+collectCode+"_"+j).find("#companyAddress").html(requestList[i].companyAddress)
			        			 $("._"+collectCode+"_"+j).find(".signatureImage").attr("src","${webRoot}/img/report/signatureImage.png");
			        			 $("._"+collectCode+"_"+j).find(".approveImage").attr("src","${webRoot}/img/report/approveImage.png");
			        			 $("._"+collectCode+"_"+j).find(".reviewImage").attr("src","${webRoot}/img/report/reviewImage.png");
			        			 var printHtml=$("._"+collectCode+"_"+j).html();
			        			 //参数说明：1：打印内容 ,2：注入json,3：css样式，4是否预览
			        			 PAZU.print(printHtml, null, ["${webRoot}/plug-in/pazu/print.css"], false);
		        			 }
		        		}
		        		//打印成功
		        		  setTimeout(function(){
		        			 updatePrintRecord();
		        		},2000); 
		            } else {
		               tips("生成失败，请联系管理员！");
		            }
		        },error:function(){
		        	console.log("error");
		        }
		    });
		 }
/* 		 //打印
		 function preview(){
			 chkPAZU();
			 if (!!window.ActiveXObject || "ActiveXObject" in window) {
				 remove_ie_header_and_footer();
			 }
			 requestIds="";
			 $("#_chose_reg_modal").modal("hide");
			 doPagesetup();
			 for (var i = 0; i < requestList.length; i++) {
				 var printHtml="";
				  if(tabId==0){//首次打印
				 		requestIds+=requestList[i].requestId+","
				  }else{
					  requestIds+=requestList[i].printId+","
				  }
				 $("._"+collectCode).find("#qrCodePath").attr("src","${webRoot}/pay/generatorQrCode?qrCode=${samplingQrPath}&collectCode="+collectCode+"&scan=1&unitId="+requestList[i].requestId)
				 $("._"+collectCode).find("#requesterName").html(requestList[i].requestName)
// 				 $("._"+collectCode).find("#requesterPhone").html(requestList[i].linkPhone)
				$("._"+collectCode).find("#companyAddress").html(requestList[i].companyAddress)
				 printHtml+=$("._"+collectCode).html();
				 //参数说明：1：打印内容 ,2：注入json,3：css样式，4是否预览
				 PAZU.print(printHtml, null, ["${webRoot}/plug-in/pazu/print.css"], false);
			}
			//打印成功
			  setTimeout(function(){
				 updatePrintRecord();
			},2000);  
	 } */

		 //准备打印
		  function sendPrintReport(){
			  $(".printBtn").attr("disabled","disabled");
			  requestList=[];
			  $.each($('._query_req_units_body input:checked'), function (index, item) {
				  requestList.push({requestId : parseInt($(item).attr("data-id")),requestName : $(item).attr("data-requestername"),linkPhone:$(item).attr("data-linkPhone"),companyAddress:$(item).attr("data-companyAddress"),printId:$(item).attr("data-printId")});
		       });
			  console.log(requestList);
			  if(requestList.length>0){
				  if(tabId==0){//首次打印
					  preview();
				  }else{
					 	 $("#_chose_reg_modal").modal("hide");
					    showMbIframe("${webRoot}/reportPrint/payForPrintingMutl?id=${bean.id}&requestCount="+requestList.length);
						 $("#myContent1").hide(); 
						 clearInterval(timeInterval);
				  }
			  }else{
				  tips("请选择需要打印的单位");
			  }
		 } 
		 function remove_ie_header_and_footer() {
			 var hkey_root, hkey_path, hkey_key;
			 hkey_path = "HKEY_CURRENT_USER\\Software\\Microsoft\\Internet Explorer\\PageSetup\\";
			 try {
				 var RegWsh = new ActiveXObject("WScript.Shell");
				 RegWsh.RegWrite(hkey_path + "header", "");
				 RegWsh.RegWrite(hkey_path + "footer", "");
			 } catch (e) {}
		 }

		 //打印成功，更新打印次数
		 function updatePrintRecord(){
			 tabIndex=$(".print-current2").attr("data-id");
			 requestIds = requestIds.substring(0,requestIds.length-1);
			 parent.location.href = "${webRoot}/reportPrint/printMutliSuccess?id=${bean.id}&printType="+tabIndex+"&detailIds="+requestIds+"&collectCode="+collectCode;
		 }
		 function checkedAll() {
			 var cbs = document.getElementsByName("rowCheckBox");
			 if (document.getElementById("mainCheckBox").checked) {
				 //全选
				 for (var i = 0; i < cbs.length; i++) {
					 cbs[i].checked = true;
				 }
			 } else {
				 //全不选
				 for (var i = 0; i < cbs.length; i++) {
					 cbs[i].checked = false;
				 }
			 }
		 }
		 function changeBox() {
			 var cbs = document.getElementsByName("rowCheckBox");
			 var mbStatus = true;	//选中全选复选框
			 for (var i = 0; i < cbs.length; i++) {
				 if (!cbs[i].checked) {
					 mbStatus = false;
					 break;
				 }
			 }
			 document.getElementById("mainCheckBox").checked = mbStatus;
		 }
	 </script>

</body>
</html>


