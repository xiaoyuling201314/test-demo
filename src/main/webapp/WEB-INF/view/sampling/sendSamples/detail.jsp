<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/common/resource.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="description" content="">
<meta name="author" content="食安科技">
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<title>快检服务云平台</title>

<style type="text/css">
#content {
	width: 500px;
	height: 170px;
	margin: 100px auto;
}

#imgbox-loading {
	position: absolute;
	top: 0;
	left: 0;
	cursor: pointer;
	display: none;
	z-index: 90;
}

#imgbox-loading div {
	background: #FFF;
	width: 100%;
	height: 100%;
}

#imgbox-overlay {
	position: absolute;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background: #000;
	display: none;
	z-index: 80;
}

.imgbox-wrap {
	position: absolute;
	top: 0;
	left: 0;
	display: none;
	z-index: 90;
}

.imgbox-img {
	padding: 0;
	margin: 0;
	border: none;
	width: 100%;
	height: 100%;
	vertical-align: top;
	border: 10px solid #fff;
}

.imgbox-title {
	padding-top: 10px;
	font-size: 11px;
	text-align: center;
	font-family: Arial;
	color: #333;
	display: none;
}

.imgbox-bg-wrap {
	position: absolute;
	padding: 0;
	margin: 0;
	display: none;
}

.imgbox-bg {
	position: absolute;
	width: 20px;
	height: 20px;
}
.cs-add-pad input[type=text], .android-search-input input[type=text] {
	max-width: 35px;
}
</style>
</head>

<body>
	<div class="cs-maintab">
		<div class="cs-col-lg clearfix">
			<c:choose>
				<c:when test="${source eq 'monitor'}">
					<!-- 面包屑导航栏  开始-->
					<ol class="cs-breadcrumb">
						<li class="cs-fl"><img src="${webRoot}/img/set.png" alt="">
							检测结果详情</li>
					</ol>
				</c:when>
				<c:otherwise>
					<!-- 面包屑导航栏  开始-->
					<ol class="cs-breadcrumb">
						<li class="cs-fl"><img src="${webRoot}/img/set.png" alt="">
							<a href="javascript:">你送我检</a></li>
						<li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
						<li class="cs-fl"><a href="javascript:" class="returnBtn">送检单</a></li>
						<li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
						<li class="cs-b-active cs-fl">送检单详情</li>
					</ol>
					<!-- 面包屑导航栏  结束-->
					<div class="cs-search-box cs-fr">
						<a href="javascript:" onclick="parent.closeMbIframe();" class="cs-menu-btn"><i class="icon iconfont icon-fanhui"></i>返回</a>
					</div>
				</c:otherwise>
			</c:choose>

		</div>
		<div class="cs-tb-box">
			<div class="cs-base-detail">

				<div class="cs-content2 clearfix">
					<form class="registerform" action="">
						<div class="cs-add-pad cs-input-bg">
							<h3>送检信息</h3>
							<table class="cs-form-table cs-form-table-he">
								<tbody>
									<tr>
										<td class="cs-name" style="width: 160px;">送检单号：</td>
										<td class="cs-in-style"
											style="width: 20%; padding-left: 10px;"><c:if
												test="${!empty sampling}">${sampling.samplingNo}</c:if></td>
										<td class="cs-name" style="width: 160px;">检测时间：</td>
										<td class="cs-in-style" style="padding-left: 10px;"><c:if
												test="${!empty sampling && !empty sampling.samplingDate}">
												<fmt:formatDate type="both" value="${sampling.samplingDate}" />
												<!-- 												</p> -->
											</c:if></td>
										<td rowspan="3" style="text-align: center; width: 110px;">
											<img src="${webRoot}/resources/qrcode/${sampling.qrcode}"
											alt="" style="height: 100px;" style="display:inline-block;" />
										</td>
									</tr>
									<tr>
										<td class="cs-name" style="width: 160px;">送检人：</td>
										<td class="cs-in-style"
											style="width: 33%; padding-left: 10px;"><c:if
												test="${!empty sampling}">${sampling.regName}</c:if></td>
										<td class="cs-name" style="width: 160px;">联系电话：</td>
										<td class="cs-in-style" style="padding-left: 10px;"><c:if
												test="${!empty sampling}">${sampling.regLinkPhone}</c:if></td>
									</tr>
									<tr>
										<td class="cs-name" style="width: 160px;">身份证号码：</td>
										<td class="cs-in-style" style="padding-left: 10px;"><c:if
												test="${!empty sampling}">${sampling.regLicence}</c:if></td>
										<td class="cs-name" style="width: 160px;">微信：</td>
										<td class="cs-in-style" style="padding-left: 10px;"><c:if
												test="${!empty sampling}">${sampling.opePhone}</c:if></td>
									</tr>
									<tr>
										<td class="cs-name" style="width: 160px;">邮箱：</td>
										<td class="cs-in-style" style="padding-left: 10px;" colspan="">
											<c:if test="${!empty sampling}">${sampling.regLinkPerson}</c:if>
										</td>
										<td class="cs-name" style="width: 160px;">地址：</td>
										<td class="cs-in-style" style="padding-left: 10px;"
											colspan="3"><c:if test="${!empty sampling}">${sampling.opeShopName}</c:if>
										</td>
									</tr>
									<tr style="height: px;">
										<td class="cs-name" style="width: 160px;">购买凭证：</td>
										<td class="cs-in-style cs-td-img">
											<c:if test="${!empty files}">
												<c:forEach items="${files}" var="file">
													<a class="cs-img-link"
														href="${resourcesUrl}${file.filePath}"> <img
														src="${resourcesUrl}${file.filePath}">
													</a>
												</c:forEach>
											</c:if>
										</td>
										<td class="cs-name" style="width: 160px;">经营户签名：</td>
										<td class="cs-in-style cs-td-img" colspan="2">
											<c:if test="${!empty sampling && !empty sampling.opeSignature}">
							            		<a class="cs-img-link" href="${resourcesUrl}opeSignaturePath/${sampling.opeSignature}">
									        		<img src="${resourcesUrl}opeSignaturePath/${sampling.opeSignature}">
									        	</a>
							            	</c:if>
										</td>
									</tr>
								</tbody>
							</table>
							<h3>抽样明细</h3>
							<div id="dataList"></div>

						</div>
					</form>
				</div>
			</div>
		</div>
		<!-- 底部导航 结束 -->
	</div>

	<%@include file="/WEB-INF/view/common/modalBox.jsp"%>

</body>
   <!-- JavaScript -->
   <script src="${webRoot}/js/jquery.min.js"></script>
   <script src="${webRoot}/js/jquery.imgbox.pack.js"></script>
   <script src="${webRoot}/js/datagridUtil.js"></script>
   <script type="text/javascript">
				$(function() {
					$(".cs-img-link").imgbox({
						'speedIn' : 0,
						'speedOut' : 0,
						'alignment' : 'center',
						'overlayShow' : true,
						'allowMultiple' : false
					});

					var traceability = 0;
					var traceabilityObj;
					for (var i = 0; i < childBtnMenu.length; i++) {
						if (childBtnMenu[i].operationCode == "321-12") { //溯源
							traceability = 1;
							traceabilityObj = childBtnMenu[i];
						}
					}

					var op = {
						tableId : "dataList", //列表ID
						tableAction : "${webRoot}/samplingDetail/datagrid.do?tbSampling.id=${sampling.id}", //加载数据地址
						parameter : [ //列表拼接参数
						{
							columnCode : "foodName",
							columnName : "样品名称"

						}, {
							columnCode : "itemName",
							columnName : "检测项目"
						},
						 {
							columnCode: "purchaseDate",
							columnName: "购买日期",
							queryType: 1,
							dateFormat: "yyyy-MM-dd"
						},
						 {
							columnCode: "origin",
							columnName: "购买地点"
						}, 
						{
							columnCode : "sampleNumber",
							columnName : "送检数(KG)"

						},
						/*{
							columnCode : "purchaseAmount",
							columnName : "送检数(KG)"

						},*/
							{
							columnCode : "conclusion",
							columnName : "检测结果"

						}, {
							columnCode : "recevieDevice",
							columnName : "仪器唯一标识"

						}, {
							columnCode : "status",
							columnName : "检测任务",

							customVal : {
								"0" : "未接收",
								"1" : "已接受"
							}
						} ]
					};
					datagridUtil.initOption(op);

					datagridUtil.query();

					//返回
					$('.returnBtn').click(function() {
						self.location = "${webRoot}/sampling/list.do";
					});
				});
			</script>
</html>
