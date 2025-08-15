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
 	.cs-xlg-width {
    	width: 900px;
	}
	.text-cursor{
		cursor:pointer;
	}
</style>
</head>

<body  style="tab-interval: 21pt; text-justify-trim: punctuation;"  >
	 <div class="zz-content" id="myContent1">
    	<div class="zz-title2">
			<img class="pull-left" src="${webRoot}/img/terminal/title2.png" alt=""><span >订单明细</span>
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
                         </c:if>
                        </div> 
                     </div>
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
                  <c:if test="${income.reportMoney!=0}">
                  	<div class="zz-name zz-input col-md-6 col-sm-6">
	                    	<div class="pull-left zz-name2">报告费用：<fmt:formatNumber value="${income.reportMoney }" pattern="0.00"/>元</div>
	                    </div>
                  </c:if>   
                  <c:if test="${income.takeSamplingMoney!=0}">
                  	<div class="zz-name zz-input col-md-6 col-sm-6">
		                      <div class="pull-left zz-name2">上门服务 ：
								<fmt:formatNumber value="${income.takeSamplingMoney }" pattern="0.00"/>元
		                     </div>
		               	</div>
                  </c:if>     
				
			</div>
			
			<div class="zz-table col-md-12 col-sm-12">
				<div class="zz-tb-bg zz-tb-bg2" style="height: 656px;">
					<table>
						<tr class="zz-tb-title">
							<th class="nums">序号</th>
							<th>样品名称</th>
							<c:if test="${showPurchaseNumber==1 || showPurchaseNumber==2}">
								<th style="width: 130px">进货数量(KG)</th>
							</c:if>
							<th style="width: 18%">检测项目</th>
							<!-- <th>来源市场</th>
							<th>来源档口</th> -->
							<th style="width: 120px">检测结果</th>
							<th style="width: 120px">检测费用(元)</th>
							<th style="width: 18%">送样时间</th>
							<th class="nums">样品进度</th>
						</tr>
						<c:forEach items="${list}" var="samplingDetail" varStatus="index" >
							<tr>
								<td>${index.index+1}</td>
								<td>${samplingDetail.foodName }</td>
								<c:if test="${showPurchaseNumber==1 || showPurchaseNumber==2}">
									<td>${samplingDetail.purchaseAmount }</td>
								</c:if>
								<td>${samplingDetail.itemName }</td>
								<%-- <td>${samplingDetail.supplier }</td>
								<td>${samplingDetail.opeShopName }</td> --%>
								<td>
								<c:choose>
									<c:when test="${samplingDetail.conclusion!='' && samplingDetail.conclusion!=null}">
										${samplingDetail.conclusion }
									</c:when>
									<%-- <c:when test="${samplingDetail.collectCode!=null}">
										检测中...
									</c:when> --%>
									<c:otherwise>
										
									</c:otherwise>
								</c:choose>
								</td>
								<td>￥${samplingDetail.inspectionFee }</td>
								<td><fmt:formatDate value="${samplingDetail.sampleTubeTime }" pattern="yyyy-MM-dd HH:mm:ss"/></td>
								<td>
									<c:choose>
										<c:when test="${samplingDetail.conclusion!='' && samplingDetail.conclusion!=null}">
											完成
										</c:when>
										<c:when test="${samplingDetail.collectCode!=null}">
											检测中
										</c:when>
										<c:otherwise>
											待送样
										</c:otherwise>
									</c:choose>
								</td>
								<c:if test="${printType==1}">
								<td class="demo-list">
									<ul>
										<li>
											<input id="input-${samplingDetail.id}" tabindex="${samplingDetail.id}" type="checkbox" name="rowCheckBox" onclick="changeBox()" value="${samplingDetail.id}">
										</li>
	              					</ul>
	          					</td>
								</c:if>
							</tr>
						</c:forEach>
					</table>

				</div>
				
			</div>
			<div class="zz-tb-btns col-md-12 col-sm-12">
				<a href="${webRoot}/reportPrint/list" class="btn btn-danger _cancel_btn">返回</a>
			</div>
		</div>

		<div class="zz-left"><img src="${webRoot}/img/terminal/left.png" alt=""></div>
		<div class="zz-right"><img src="${webRoot}/img/terminal/right.png" alt=""></div>
		
    </div>
 	 <%@include file="/WEB-INF/view/terminal/showUnitConfirm.jsp"%>

    <%@include file="/WEB-INF/view/terminal/keyboard_input.jsp"%> 
	 <%@include file="/WEB-INF/view/terminal/tips.jsp"%>
	 <%@include file="/WEB-INF/view/common/modalBox.jsp"%>
	<script type="text/javascript" src="${webRoot}/js/showTime.js"></script>
</body>
</html>


