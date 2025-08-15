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
	
 	#myContent2{display:none}  
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
	}
	.print-btns{
		padding-bottom: 0;
	}
	.print-current {
    background: #4887ef;
}
</style>
</head>

<body  style="tab-interval: 21pt; text-justify-trim: punctuation;"  >
	 <div class="zz-content" id="myContent1">
    	<div class="zz-title2">
			<img class="pull-left" src="${webRoot}/img/terminal/title2.png" alt=""><span >订单打印</span>
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
                   
               <div class="zz-name zz-input col-md-6 col-sm-6">
                     <div class="pull-left zz-name2">委托单位：${bean.regName }</div>
                     
                     </div>
                     <div class="zz-name zz-input col-md-6 col-sm-6">
                      <div class="pull-left zz-name2">联系电话：
						${bean.regLinkPhone }
                     </div>
                     </div>
                   <div class="zz-name zz-input col-md-6 col-sm-6">
                     <div class="pull-left zz-name2">送检单位：${unit.companyName }</div>
                     
                     </div>
                     <div class="zz-name zz-input col-md-6 col-sm-6">
                      <div class="pull-left zz-name2">联系电话：
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
							<c:when test="${tab1==0 && samplingDetail.reportNumber==null &&  samplingDetail.conclusion!=null}">
									<c:set var="tab1" value="1" />
							</c:when>
							<c:when test="${tab2==0 && samplingDetail.reportNumber!=null}">
									<c:set var="tab2" value="1" />
							</c:when>
							<c:when test="${tab3==0 && samplingDetail.collectCode!=null &&  samplingDetail.conclusion==null}">
									<c:set var="tab3" value="1" />
							</c:when>
							<c:when test="${tab4==0 && samplingDetail.collectCode==null}">
									<c:set var="tab4" value="1" />
							</c:when>
						</c:choose>
					</c:forEach>
					<c:if test="${tab1==1}"><div class="print-all" data-id="0">未打印</div></c:if>
					<c:if test="${tab2==1}"><div class="print-all" data-id="1">已打印</div></c:if>
					<c:if test="${tab3==1}"><div class="print-all" data-id="2">检测中</div></c:if>
					<c:if test="${tab4==1}"><div class="print-all" data-id="2">待送样</div></c:if>
				</div>
				<!-- tab 选项卡 start -->
				<!-- 未打印开始 2019-08-23 -->
				<c:if test="${tab1==1}">
					<div class="zz-printed zz-printed2 clearfix">
					<div class="zz-printed-hight">
						<div class="zz-printed-bg">
					<table style="margin-bottom: 0">
						<tr class="zz-tb-title">
							<th style="width: 150px">序号</th>
							<th style="width: 15%">样品名称</th>
							<th style="width: 15%">检测项目</th>
							<th style="width: 10%">检测结果</th>
							<th style="width: 20%">送样时间</th>
							<th style="width: 10%"> 操作 </th>
						</tr>
						</table>
						<c:set var="showSerial" value="0"/>
						<c:forEach items="${receiverNumbers}" var="receiveBean" >
							<c:set var="showOne" value="0"/>
							<c:set var="showNumbers" value="0" />
							<c:forEach items="${list}" var="samplingDetail" varStatus="index" >
								<c:if test="${samplingDetail.reportNumber==null && samplingDetail.conclusion!=null }">
									<c:set var="sampleTubeFirst">
										<fmt:formatDate value="${samplingDetail.sampleTubeTime }" pattern="yyyy-MM-dd HH:mm:ss"/>
									</c:set>
									<c:if test="${receiveBean.sampleTubeTime==sampleTubeFirst}">
										<c:set var="showNumbers" value="${showNumbers+1}" />
										<c:set var="showSerial" value="${showSerial+1}" />
										<input type="hidden" name="firstPrint" value="${samplingDetail.id }" data-report="${receiveBean.reportNumber}" />
										<c:if test="${showNumbers==1 }"><table></c:if>
											<tr>
												<td style="width: 150px">${showSerial}</td>
												<td style="width: 15%">${samplingDetail.foodName }</td>
												<td style="width: 15%">${samplingDetail.itemName }</td>
												<td style="width: 10%">${samplingDetail.conclusion }</td>
												<c:if test="${showOne==0}"> 
	 												<c:set var="showOne" value="1"/>
													<td rowspan="${receiveBean.receiveCount}" style="width: 20%">
														${receiveBean.sampleTubeTime}
													</td>
													<td rowspan="${receiveBean.receiveCount}" style="width: 10%"><div class="btn btn-primary" style="width: auto" onclick="printReport(${receiveBean.reportNumber});">打印</div></td>
												 	</c:if>  
											</tr>
										</c:if>
								
								</c:if>
								<c:if test="${fn:length(list)==index.index+1 }">
									</table>
								</c:if>
							</c:forEach> 
						</c:forEach>
					</div>
					</div>
					</div>
				</c:if>
				<!-- 未打印结束 -->
				<!-- 已打印开始 add by xiaoyl 2019-08-13 -->
				<c:if test="${tab2==1}">
					<div class="zz-printed zz-printed2 clearfix" style="display:none">
					<div class="zz-printed-hight">
						<div class="zz-printed-bg">
								<table style="margin-bottom: 0">
									<tr class="zz-tb-title">
										<th style="width: 150px">序号</th>
										<th style="width: 15%">样品名称</th>
										<th style="width: 15%">检测项目</th>
										<th style="width: 10%">检测结果</th>
										<th style="width: 20%">送样时间</th>
										<th style="width: 10%">操作</th>
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
										<c:if test="${showNumbers==1 }"><table></c:if>
											<c:set var="sampleTubeTime">
												<fmt:formatDate value="${samplingDetail.sampleTubeTime }" pattern="yyyy-MM-dd HH:mm:ss"/>
											</c:set>
											<tr>
												<td style="width: 150px">${showSerial}</td>
												<td style="width: 15%">${samplingDetail.foodName }</td>
												<td style="width: 15%">${samplingDetail.itemName }</td>
												<td style="width: 10%">${samplingDetail.conclusion }</td>
 												<c:if test="${showReport==0}"> 
 													<c:set var="showReport" value="1"/>
 													<td rowspan="${report.samplingCount}" style="width: 20%">
														${sampleTubeTime}
						          					</td>
					          						<td rowspan="${report.samplingCount}" style="width: 10%">
						          						<div class="btn btn-primary" style="width: auto" onclick="printReport(${report.reportNumber});">重打</div>
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
				</c:if>
				<!-- 已打印结束 -->
				<!-- 检测中开始 add by xiaoyl 2019-08-13 -->
				<c:if test="${tab3==1}">
					<div class="zz-printed zz-printed2 clearfix" style="display:none">
					<div class="zz-printed-hight">
						<div class="zz-printed-bg">
						<table style="margin-bottom: 0">
							<tr class="zz-tb-title">
								<th style="width: 150px">序号</th>
								<th style="width: 15%">样品名称</th>
								<th style="width: 15%">检测项目</th>
								<th style="width: 10%">检测结果</th>
								<th style="width: 20%">送样时间</th>
								</tr>
								</table>
								<c:set var="showSerial" value="0"/>
								<c:forEach items="${receiverNumbers}" var="receiveBean">
									<c:set var="showCheck" value="0"/>
									<c:set var="showNumbers" value="0" />
									<c:forEach items="${list}" var="samplingDetail" varStatus="index" >
									<c:if test="${samplingDetail.collectCode!=null && samplingDetail.conclusion==null}">
										<c:set var="sampleTubeTime">
											<fmt:formatDate value="${samplingDetail.sampleTubeTime }" pattern="yyyy-MM-dd HH:mm:ss"/>
										</c:set>
											<c:if test="${receiveBean.sampleTubeTime==sampleTubeTime}">
													<c:set var="showNumbers" value="${showNumbers+1}" />
													<c:set var="showSerial" value="${showSerial+1}" />
													<c:if test="${showNumbers==1 }"><table></c:if>
													<tr>
														<td style="width: 150px">${showSerial}</td>
														<td style="width: 15%">${samplingDetail.foodName }</td>
														<td style="width: 15%">${samplingDetail.itemName }</td>
														<td style="width: 10%">检测中...</td>
														<c:if test="${showCheck==0}"> 
			 												<c:set var="showCheck" value="1"/>
															<td style="width: 20%" rowspan="${receiveBean.receiveCount}">
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
								<th style="width: 150px">序号</th>
								<th>样品名称</th>
								<th>检测项目</th>
								</tr>
								<c:set var="showNumbers" value="0" />
								<c:forEach items="${list}" var="samplingDetail" varStatus="index" >
									<c:if test="${samplingDetail.collectCode==null}">
									<c:set var="showNumbers" value="${showNumbers+1}" />
										<tr>
											<td>${showNumbers}</td>
											<td>${samplingDetail.foodName }</td>
											<td>${samplingDetail.itemName }</td>
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
			<%-- <c:if test="${fn:length(firstPrint)>0 }">
				<a href="javascript:;" id="showPrintBtn" onclick="printReport();" class="btn btn-primary">打印</a>
			</c:if> --%>
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
				<%@include file="/WEB-INF/view/terminal/report/mergePrint.jsp"%>
				<!--EndFragment-->

				<%--分开打印--%>
				<!--StartFragment0-->
				<%@include file="/WEB-INF/view/terminal/report/replayReport.jsp"%>
				<!--EndFragment0-->
			</div>
		</div>
	 </div>

	 <%@include file="/WEB-INF/view/terminal/tips.jsp"%>
	 <%@include file="/WEB-INF/view/common/modalBox.jsp"%>
	 <%--<script type="text/javascript" src="${webRoot}/plug-in/jcp/jcpfree.js"></script>--%>
	 <script>
	 $('.print-all').eq(0).click();
	 $('.zz-printed').eq(0).show().siblings('.zz-printed').hide();
	 $('.print-all').eq(0).addClass('print-current')
	 var tabIndex=$('.print-all').eq(0).attr("data-id");
	 var reportNumber;//重打时的取报告码
	 var samplingDetailIds = "";
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
		 //打印
		 function preview(){

			 if (!!window.ActiveXObject || "ActiveXObject" in window) {
				 remove_ie_header_and_footer();
			 }

			$('html,body').css('width','auto');
			$('html,body').css('height','auto');
			
			$('#myContent1').hide();
			
			 var sprnstr = "";
			 var eprnstr = "";
			 if(tabIndex == 0){//0_合并打印
// 				 sprnstr="<!--StartFragment-->";
// 				 eprnstr="<!--EndFragment-->";
// 				 $('#page2').hide();
				$('#page2').hide();
				 $("._separately_print").hide();
				 $("._"+reportNumber).show();
				 sprnstr="<!--StartFragment-->";
				 eprnstr="<!--EndFragment-->";
			 }else if(tabIndex == 1){//1_重打
				 $('#page1').hide();
				 $("._separately_print").hide();
				 $("._"+reportNumber).show();
				 sprnstr="<!--StartFragment0-->";
				 eprnstr="<!--EndFragment0-->";

			 }else{
				 return;
			 }
			 
			 var bdhtml=window.document.body.innerHTML;
			 var prnhtml=bdhtml.substring(bdhtml.indexOf(sprnstr)+21);
			 prnhtml=prnhtml.substring(0,prnhtml.indexOf(eprnstr));
			  window.document.body.innerHTML=prnhtml;
			 setTimeout(function(){
				 window.print();
				 $("._separately_print").hide();
				 //location.reload();
				//打印成功
				 updatePrintRecord();
			},80);
		 }

		 //付款
		 function printReport(reportNumberData){
			 reportNumber=reportNumberData;
			 if(tabIndex==0){//首次打印
				 var cbs = document.getElementsByName("firstPrint");
				 for (var i = 0; i < cbs.length; i++) {
					 if($(cbs[i]).attr("data-report")==reportNumberData){
						 samplingDetailIds = samplingDetailIds+ $(cbs[i]).val() + ",";
					 }
				 }
				 samplingDetailIds = samplingDetailIds.substring(0, samplingDetailIds.length - 1);
				  preview();
			 }else{//重打
				  $("input[name='rowCheckBox']:checked").each(function () {
					 samplingDetailIds = samplingDetailIds + $(this).val() + ",";
				 });
				 samplingDetailIds = samplingDetailIds.substring(0, samplingDetailIds.length - 1);
				 showMbIframe("${webRoot}/reportPrint/payForPrinting?id=${bean.id}");
				 $("#myContent1").hide(); 
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
			 window.location.href = "${webRoot}/reportPrint/printSuccess?id=${bean.id}&printType="+tabIndex+"&samplingDetailIds="+samplingDetailIds+"&reportNumber="+reportNumber;
		 }
		 $(function(){
			 /* var afterPrint = function() {
				 setTimeout(function(){
					 {
						 //location.href="${webRoot}/reportPrint/print.do";
					 }
				 },500);

			 };
			 if (window.matchMedia) {
				 var mediaQueryList = window.matchMedia('print');
				 mediaQueryList.addListener(function(mql) {
					 if (mql.matches) {
						 // console.log("123");
					 } else {
						 afterPrint();
					 }
				 });
			 }
			 window.onafterprint = afterPrint;
			 $('.zz-rebtn').click(function(){
				 $('.zz-pay-fa').hide()
			 })
			 $('.zz-fa-btn').click(function(){
				 $('.zz-pay-fa').show()
			 })

			 
			 function centerModals() {
				 $('.intro2').each(function (i) {
					 var $clone = $(this).clone().css('display', 'block').appendTo('body');
					 var top = Math.round(($clone.height() - $clone.find('.modal-content').height()) / 2.4);
					 top = top > 0 ? top : 0;
					 $clone.remove();
					 $(this).find('.modal-content').css("margin-top", top);
				 });
			 }
			 $('.intro2').on('show.bs.modal', centerModals);
			 $(window).on('resize', centerModals);

			 $('.change-btn div').click(function(){

				 var eq = $(this).index();

				 $('.zz-price-all').eq(eq).show().siblings('.zz-price-all').hide();
				 if(eq==2){
					 $('.zz-tb-btns a').hide()
					 $('.zz-btn-sh').css('display','inline-block')
				 }else{
					 $('.zz-btn-sh').hide()
					 $('.zz-tb-btns a').show()
					 $('.zz-btn-sh').css('display','none')
				 }
			 })

			 $('.prints-choose span').click(function(){
				 var indexs = $(this).index();
				 $(this).addClass('zz-current').siblings('span').removeClass('zz-current');
				 $('.zz-table .zz-tb-bg').eq(indexs).show().siblings('.zz-tb-bg').hide();
				 setTimeout(function(){
					 alignmentFns.initialize()
				 },500)
			 })
			 */
		 })
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


