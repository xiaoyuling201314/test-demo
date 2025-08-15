<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/wx/wxResource.jsp"%>
<c:set var="webRoot" value="<%=basePath%>" />
<html>
  <head>
  		 <meta charset="utf-8">
        <meta name="viewport" content="initial-scale=1, maximum-scale=1, user-scalable=no">
        <meta name="format-detection" content="telephone=no">
        <title>抽检单</title>
  </head>
  <script type="text/javascript" src="${webRoot}/js/dy-switch.js"></script>
  <style type="text/css">
	.traceability {
	    display: none;
	}
  </style>
 <body ontouchstart="" style="padding-bottom:10px;">
    <div class="ui-headed">
        <h4>抽样单</h4>
    </div>
        <section class="ui-container" style="padding:10px;">

            <div class="ui-first-info clearfix">
              <ul class="ui-bg-white">
                <li class="ui-border-b clearfix">
                  <div class="ui-list-info ui-col ui-col-1">
                	    抽样单号：
                  </div>
                  <div class="ui-list-action ui-list-info ui-col ui-col-3 ">${sampling.samplingNo}</div>
                </li>
                <li class="ui-border-b clearfix">
                  <div class="ui-list-info ui-col ui-col-1">
                 	 抽样时间：
                  </div>
                  <div class="ui-list-action ui-list-info ui-col ui-col-3"><fmt:formatDate value="${sampling.samplingDate}" pattern="yyyy-MM-dd HH:mm:ss"/></div>
                </li>
                <li class="ui-border-b clearfix">
                  <div class="ui-list-info ui-col ui-col-1">
                 	 抽样单位：
                  </div>
                  <div class="ui-list-action ui-list-info ui-col ui-col-3"><c:if test="${!empty point}">${point.pointName}</c:if></div>
                </li>
                <li class="ui-border-b clearfix">
                  <div class="ui-list-info ui-col ui-col-1">
                 	 抽样人：
                  </div>
                  <div class="ui-list-action ui-list-info ui-col ui-col-3">${sampling.samplingUsername}</div>
                </li>
                </ul>
            </div>
            <c:choose>
            	<c:when test="${sampling.personal==1}">
            		<div class="ui-second-info clearfix">
		              <ul class="ui-bg-white">
		                <li class="ui-border-b clearfix">
		                  <div class="ui-list-info ui-col ui-col-1">
		                 	   送检人：
		                  </div>
		                  <div class="ui-list-action ui-list-info ui-col ui-col-3">${sampling.regName}</div>
		                </li>
		                <li class="ui-border-b clearfix">
		                  <div class="ui-list-info ui-col ui-col-1">
		                   	联系电话：
		                  </div>
		                  <div class="ui-list-action ui-list-info ui-col ui-col-3">${sampling.regLinkPhone}</div>
		                </li>
		                <li class="ui-border-b clearfix">
		                  <div class="ui-list-info ui-col ui-col-1">
		                 	   微信：
		                  </div>
		                  <div class="ui-list-action ui-list-info ui-col ui-col-3">${sampling.opePhone}</div>
		                </li>
		                <li class="clearfix">
		                  <div class="ui-list-info ui-col ui-col-1">
		                 	 地址：
		                  </div>
		                  <div class="ui-list-action ui-list-info ui-col ui-col-3">${sampling.opeShopName}</div>
		                </li>
		              </ul>
		            </div>
            	</c:when>
            	<c:otherwise>
		            <div class="ui-second-info clearfix">
		              <ul class="ui-bg-white">
		                <li class="ui-border-b clearfix">
		                  <div class="ui-list-info ui-col ui-col-1">
		                 	   被检单位：
		                  </div>
		                  <div class="ui-list-action ui-list-info ui-col ui-col-3">${sampling.regName}</div>
		                </li>
		                <li class="ui-border-b clearfix">
		                  <div class="ui-list-info ui-col ui-col-1">
							  <c:choose>
								  <c:when test="${systemFlag==1}">
									  摊位名称：
								  </c:when>
								  <c:otherwise>
									  经营户名称：
								  </c:otherwise>
							  </c:choose>
		                  </div>
		                  <div class="ui-list-action ui-list-info ui-col ui-col-3">${sampling.opeShopName}</div>
		                </li>
		                <li class="ui-border-b clearfix">
		                  <div class="ui-list-info ui-col ui-col-1">
		                 	  <span class="customizeShopCode">
								   	<c:choose>
										<c:when test="${systemFlag==1}">
											摊位编号
										</c:when>
										<c:otherwise>
											档口编号
										</c:otherwise>
									</c:choose>

							   </span>：
		                  </div>
		                  <div class="ui-list-action ui-list-info ui-col ui-col-3">${sampling.opeShopCode}</div>
		                </li>
		                <%--
		                <li class="ui-border-b clearfix">
		                  <div class="ui-list-info ui-col ui-col-1">
		                  	证件号码：
		                  </div>
		                  <div class="ui-list-action ui-list-info ui-col ui-col-3">${sampling.regLicence}</div>
		                </li>
		                 --%>
		                <li class="clearfix">
		                  <div class="ui-list-info ui-col ui-col-1">
		                 	   经营者：
		                  </div>
		                  <div class="ui-list-action ui-list-info ui-col ui-col-3">${sampling.opeName}</div>
		                </li>
		              </ul>
		            </div>
            	</c:otherwise>
            </c:choose>
            <div class="page-header clearfix">
              <h4 class="ui-pos-re">样品检测
                  <!-- <div class="ui-line ui-pos-ab"></div> -->
              </h4>
            </div>

			<c:forEach items="${details}" var="detail" varStatus="index">
		        <div class="ui-third-info clearfix ui-b-none">
	                <ul class="ui-bg-white  ui-pos-re ui-border-dotted">
						<%--
	                 <c:choose>
	                  	<c:when test="${detail.detectCount<detail.samplingCount}">
	                  		<li class="ui-pos-ab ui-ab-wh ui-default">
	                  	</c:when>
	                  	<c:when test="${detail.unqualifiedCount>0}">
	                  		<li class="ui-pos-ab ui-ab-wh ui-danger">
	                  	</c:when>
	                  	<c:otherwise>
	                  		<li class="ui-pos-ab ui-ab-wh ui-success">
	                  	</c:otherwise>
	                  </c:choose>
						--%>
						<c:choose>
							<c:when test="${detail.conclusion eq '合格'}">
						 		<li class="ui-pos-ab ui-ab-wh ui-success">
							 </c:when>
							 <c:when test="${detail.conclusion eq '不合格'}">
						 		<li class="ui-pos-ab ui-ab-wh ui-danger">
							 </c:when>
							 <c:otherwise>
						 		<li class="ui-pos-ab ui-ab-wh ui-default">
							 </c:otherwise>
						</c:choose>
	                  <div class="cs-dis-table">
	                  <span>${index.index+1}</span>
	                  </div>
	                </li>
	                <li class="clearfix">
	                  <div class="ui-li-height ui-col-1">
	                	    样品名称：
	                  </div>
	                  <div class="ui-list-action ui-li-height ui-col-3"><span class="ui-fl ui-back-width">${detail.foodName}</span>
	                  	<div class="ui-back-btn ui-fl traceability">
	                        <a href="javascript:" class="ui-find ui-fr"><span>溯源</span><span class="iconfont icon-xia"></span></a>
	                  	</div>
	                  </div>
	                </li>
	                <li class="clearfix">
	                  <div class="ui-li-height ui-col-1">
	                  	  检测项目：
	                  </div>
	                  <div class="ui-list-action ui-li-height ui-col-3">${detail.itemName}</div>
	                </li>
	                <li class="clearfix">
	                  <div class="ui-li-height ui-col-1">
	                 	   检测结果：
	                  </div>
	                  <div class="ui-list-action ui-li-height ui-col-3">
						  <%--
	                  <c:choose>
                  		<c:when test="${detail.detectCount<detail.samplingCount}">
	                  		<span >未完成</span>
	                  	</c:when>
	                  	<c:when test="${detail.unqualifiedCount>0}">
	                  		<span class="ui-red">不合格</span>
	                  	</c:when>
	                  	<c:otherwise>
	                  		<span class="ui-green">合格</span>
	                  	</c:otherwise>
	                  </c:choose>
						  --%>
						<c:choose>
						  	<c:when test="${detail.conclusion eq '合格'}">
								<span class="ui-green">合格</span>
							</c:when>
							<c:when test="${detail.conclusion eq '不合格'}">
								<span class="ui-red">不合格</span>
							</c:when>
							<c:otherwise>
								<span >未完成</span>
							</c:otherwise>
						</c:choose>
	                  </div>
	                </li>
	                <li class="clearfix">
	                  <div class="ui-li-height ui-col-1">
	                  	  检测状态：
	                  </div>
	                  <div class="ui-list-action ui-li-height ui-col-3">
                      		<div class="ui-fl ui-state-list clearfix">
		                        <span class="ui-state-active">[已抽样]</span>
		                        <span>→</span>
								<%--
		                      <c:if test="${detail.recevieCount<detail.samplingCount }">
				                        <span class="ui-warning">[分配中]</span>
				                        <span>→</span>
				                        <span>[检测中]</span>
				                        <span>→</span>
				                        <span>[完成]</span>
		                      </c:if>
		                      <c:if test="${detail.recevieCount==detail.samplingCount}">
	                      			<c:choose>
	                      				<c:when test="${detail.detectCount<detail.samplingCount}">
	                      					<span>[分配中]</span>
					                        <span>→</span>
					                        <span class="ui-warning">[检测中]</span>
					                        <span>→</span>
					                        <span>[完成]</span>
	                      				</c:when>
	                      				<c:otherwise>
	                      					<span>[分配中]</span>
					                        <span>→</span>
					                        <span>[检测中]</span>
					                        <span>→</span>
					                        <span class="ui-active-comp">[完成]</span>
	                      				</c:otherwise>
	                      			</c:choose>
		                      </c:if>
								--%>
								<c:choose>
									<c:when test="${detail.conclusion eq '合格' or detail.conclusion eq '不合格'}">
										<span>[分配中]</span>
										<span>→</span>
										<span>[检测中]</span>
										<span>→</span>
										<span class="ui-active-comp">[完成]</span>
									</c:when>
									<c:when test="${detail.recevieCount<detail.samplingCount}">
										<span class="ui-warning">[分配中]</span>
										<span>→</span>
										<span>[检测中]</span>
										<span>→</span>
										<span>[完成]</span>
									</c:when>
									<c:otherwise>
										<span>[分配中]</span>
										<span>→</span>
										<span class="ui-warning">[检测中]</span>
										<span>→</span>
										<span>[完成]</span>
									</c:otherwise>
								</c:choose>
	                      </div>

	                  </div>
	                </li>
	              </ul>

				<c:choose>
					<c:when test="${souce==1 && !empty list[index.index]}"><!-- 当获取进货台账溯源信息时 -->
					<div class="ui-back-info ui-hide ui-padding">
	                <ul class="ui-bg-white  ui-pos-re ui-ul-pad  ui-border-left ui-name-width">
                	<li><h5 class="ui-border-dotted">溯源信息</h5></li>
	                <li class="clearfix">
	                  <div class="ui-li-height ui-col-1">
	                  	  来源/市场：
	                  </div>
	                  <div class="ui-list-action ui-li-height ui-col-3">
	                  <span>${list[index.index].param1}</span>
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
	                  <span>${list[index.index].supplier}</span>
	                  </div>
	                </li>
	                <li class="clearfix">
	                  <div class="ui-li-height ui-col-1">
	                   	 供货者名称：
	                  </div>
	                  <div class="ui-list-action ui-li-height ui-col-3">
	                  <span>${list[index.index].supplierUser}</span>
	                  </div>
	                </li>
	                <li class="clearfix">
	                  <div class="ui-li-height ui-col-1">
	                	供货者电话：
	                  </div>
	                  <div class="ui-list-action ui-li-height ui-col-3">
	                  <span>${list[index.index].supplierTel}</span>
	                  </div>
	                </li>
	                <li class="clearfix">
	                  <div class="ui-li-height ui-col-1">
	               	     生产日期：
	                  </div>
	                  <div class="ui-list-action ui-li-height ui-col-3"><fmt:formatDate value="${list[index.index].productionDate}" pattern="yyyy-MM-dd"/></div>
	                </li>
	                <li class="clearfix">
	                  <div class="ui-li-height ui-col-1">
	               	     进货日期：
	                  </div>
	                  <div class="ui-list-action ui-li-height ui-col-3"><fmt:formatDate value="${list[index.index].stockDate}" pattern="yyyy-MM-dd"/></div>
	                </li>
	                <li class="clearfix">
	                  <div class="ui-li-height ui-col-1">
	                 	   保质期：
	                  </div>
	                  <div class="ui-list-action ui-li-height ui-col-3">
	                    <span>${list[index.index].expirationDate}</span></div>
	                </li>
	                <li class="clearfix">
	                  <div class="ui-li-height ui-col-1">
	                 	   产地：
	                  </div>
	                  <div class="ui-list-action ui-li-height ui-col-3">
	                  <span>${list[index.index].productionPlace}</span>
	                  </div>
	                </li>
	                <li class="clearfix">
	                  <div class="ui-li-height ui-col-1">
	                 	   批次：
	                  </div>
	                  <div class="ui-list-action ui-li-height ui-col-3">
	                    <span>${list[index.index].batchNumber}</span></div>
	                </li>
	                <li class="clearfix">
	                  <div class="ui-li-height ui-col-1">
	                 	   进货数量：
	                  </div>
	                  <div class="ui-list-action ui-li-height ui-col-3">
	                    <span>${list[index.index].stockCount}${list[index.index].size}</span></div>
	                </li>
	                <li class="clearfix">
	                  <div class="ui-li-height ui-col-1">
	                  	检验编码：
	                  </div>
	                  <div class="ui-list-action ui-li-height ui-col-3">
	                  <span>${list[index.index].checkProof}</span>
	                  </div>
	                </li>
	                  <li class="clearfix">
	                  <div class="ui-li-height ui-col-1">
	                  	检验证明图片：
	                  </div>
                   <div class="ui-list-action ui-li-height ui-col-3">
                  <span class="ui-img-box">
                 <c:if test="${!empty  list[index.index].checkProof_Img }">
					<c:forEach var="img" items="${fn:split(list[index.index].checkProof_Img, ',')}">
						<a class="cs-img-link" href="${webRoot}/resources/stock/${img}">
		                    <img src="${webRoot}/resources/stock/${img}">
		                </a>
					</c:forEach>
                 </c:if>  
                  </span>
                  </div>
	                </li>
	                  <li class="clearfix">
	                  <div class="ui-li-height ui-col-1">
	                  	检疫编码：
	                  </div>
	                  <div class="ui-list-action ui-li-height ui-col-3">
	                  <span>${list[index.index].quarantineProof}</span>
	                  </div>
	                </li>
	                  <li class="clearfix">
	                  <div class="ui-li-height ui-col-1">
	                  	检疫证明图片：
	                  </div>
                   <div class="ui-list-action ui-li-height ui-col-3">
                  <span class="ui-img-box">
                   <c:if test="${!empty  list[index.index].quarantineProof_Img }">
					<c:forEach var="img" items="${fn:split(list[index.index].quarantineProof_Img, ',')}">
						<a class="cs-img-link" href="${webRoot}/resources/stock/${img}">
		                    <img src="${webRoot}/resources/stock/${img}">
		                </a>
					</c:forEach>
                   </c:if>
                  </span>
                  </div>
	                </li>
	                   <li class="clearfix">
	                  <div class="ui-li-height ui-col-1">
	                 进货凭证：
	                  </div>
                   <div class="ui-list-action ui-li-height ui-col-3">
                  <span class="ui-img-box">
                 <c:if test="${!empty  list[index.index].stockProof_Img }">
					<c:forEach var="img" items="${fn:split(list[index.index].stockProof_Img, ',')}">
						<a class="cs-img-link" href="${webRoot}/resources/stock/${img}">
		                    <img src="${webRoot}/resources/stock/${img}">
		                </a>
					</c:forEach>
                 </c:if>
                  </span>
                  </div>
	                </li>
	                <%-- <li class="clearfix">
	                  <div class="ui-li-height ui-col-1">
	                    	进货凭证：
	                  </div>
	                  <div class="ui-list-action ui-li-height ui-col-3">
	                  <span class="ui-img-box">
	                  	<c:if test="${!empty shoppingRecs}">
	                  		<c:set var="shoppingRecList" value="${fn:split(shoppingRecs, ',')}" />
	                  		<c:forEach items="shoppingRecList" var="shoppingRec">
			                    <a href="${webRoot}/resoured${shoppingRec}"><img src="${webRoot}/resoured${shoppingRec}"/></a>
	                  		</c:forEach>
	                  	</c:if>
	                  </span>
	                  </div>
	                </li> --%>
	              </ul>
	              <div class="ui-border-radius"><a href="javascript:" class="ui-btn ui-btn-close">收起</a></div>
	              </div>
				</c:when>
					<%-- =送检信息= --%>
					<c:when test="${sampling.personal==1}">
						<div class="ui-back-info ui-hide ui-padding">
							<ul class="ui-bg-white  ui-pos-re ui-ul-pad  ui-border-left">
								<li><h5 class="ui-border-dotted">溯源信息</h5></li>
								<li class="clearfix">
									<div class="ui-li-height ui-col-1">
										购买地点：
									</div>
									<div class="ui-list-action ui-li-height ui-col-3">
										<span>${detail.origin}</span>
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
									<div class="ui-list-action ui-li-height ui-col-3">
										<span>${detail.opeShopName}</span>
									</div>
								</li>
								<li class="clearfix">
									<div class="ui-li-height ui-col-1">
										送检日期：
									</div>
									<div class="ui-list-action ui-li-height ui-col-3"><fmt:formatDate value="${detail.purchaseDate}" pattern="yyyy-MM-dd"/></div>
								</li>
								<li class="clearfix">
									<div class="ui-li-height ui-col-1">
										送检数量：
									</div>
									<div class="ui-list-action ui-li-height ui-col-3">
										<span>${detail.purchaseAmount}</span></div>
								</li>
							</ul>
							<div class="ui-border-radius"><a href="javascript:" class="ui-btn ui-btn-close">收起</a></div>
						</div>
					</c:when>

					<%-- === --%>
					<c:otherwise>
					<div class="ui-back-info ui-hide ui-padding">
	                <ul class="ui-bg-white  ui-pos-re ui-ul-pad  ui-border-left">
                	<li><h5 class="ui-border-dotted">溯源信息</h5></li>
	                <li class="clearfix">
	                  <div class="ui-li-height ui-col-1">
	                  	  供货商：
	                  </div>
	                  <div class="ui-list-action ui-li-height ui-col-3">
	                  <span>${detail.supplier}</span>
	                  </div>
	                </li>
	                <li class="clearfix">
	                  <div class="ui-li-height ui-col-1">
	                   	供货者名称：
	                  </div>
	                  <div class="ui-list-action ui-li-height ui-col-3">
	                  <span>${detail.supplierPerson}</span>
	                  </div>
	                </li>
	                <li class="clearfix">
	                  <div class="ui-li-height ui-col-1">
	                	供货者电话：
	                  </div>
	                  <div class="ui-list-action ui-li-height ui-col-3">
	                  <span>${detail.supplierPhone}</span>
	                  </div>
	                </li>
	                <li class="clearfix">
	                  <div class="ui-li-height ui-col-1">
	                  	  供应商地址：
	                  </div>
	                  <div class="ui-list-action ui-li-height ui-col-3">
	                  <span>${detail.supplierAddress}</span>
	                  </div>
	                </li>
	                <li class="clearfix">
	                  <div class="ui-li-height ui-col-1">
	               	     进货日期：
	                  </div>
	                  <div class="ui-list-action ui-li-height ui-col-3"><fmt:formatDate value="${detail.purchaseDate}" pattern="yyyy-MM-dd"/></div>
	                </li>
	                <li class="clearfix">
	                  <div class="ui-li-height ui-col-1">
                          进货数量：
	                  </div>
	                  <div class="ui-list-action ui-li-height ui-col-3">
	                    <span>${detail.purchaseAmount}<c:if test="${!empty detail.purchaseAmount}">&nbsp;&nbsp;kg</c:if></span>
					  </div>
	                </li>
	                <li class="clearfix">
	                  <div class="ui-li-height ui-col-1">
	                 	   生产批次：
	                  </div>
	                  <div class="ui-list-action ui-li-height ui-col-3">${detail.batchNumber}</div>
	                </li>
	                <li class="clearfix">
	                  <div class="ui-li-height ui-col-1">
	                 	   产地：
	                  </div>
	                  <div class="ui-list-action ui-li-height ui-col-3">
	                  <span>${detail.origin}</span>
	                  </div>
	                </li>
	              </ul>
	              <div class="ui-border-radius"><a href="javascript:" class="ui-btn ui-btn-close">收起</a></div>
	              </div>
					</c:otherwise>
					</c:choose>

	            </div>
			</c:forEach>
			<div class="ui-footer">
				<div><a href="http://www.chinafst.cn/CH/index.php">${copyright}</a></div>
            </div>
        </section>

    </body>
    <script type="text/javascript" src="${webRoot}/app/js/jquery.min1.11.3.js"></script>
    <script type="text/javascript">
    $('.ui-find').click(function(){
      $(this).parents('.ui-bg-white').siblings('.ui-back-info').toggle();
    });
    $('.ui-btn-close').click(function(){
      $(this).parents('.ui-back-info').hide();
    });

    $(function(){
	  	//扫描抽样单、监管对象、经营户二维码进入的页面溯源权限控制
		if(DySwitch.traceability()){
			$(".traceability").show();
		}else{
			$(".traceability").hide();
		}
		//自定义档口编号
		$(".customizeShopCode").text(DySwitch.getShopCode());

    });
    </script>
</html>