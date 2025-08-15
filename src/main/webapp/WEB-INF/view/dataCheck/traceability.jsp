<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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

input[type="file"] {
	color: #666;
}
</style>
</head>

<body>
	<div class="cs-col-lg clearfix">
		<!-- 面包屑导航栏  开始-->
		<ol class="cs-breadcrumb">
			<li class="cs-fl"><img src="../public/img/set.png" alt="" /> <a
				href="javascript:">检测数据</a></li>
			<li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
			<li class="cs-b-active cs-fl">溯源信息</li>
		</ol>
		<!-- 面包屑导航栏  结束-->
		<div class="cs-search-box cs-fr">
			<div class="cs-fr cs-ac">
				<a href="" class="cs-menu-btn" onclick="returnFun();"><i class="icon iconfont icon-fanhui"></i>返回</a>
			</div>
		</div>
	</div>

	<table class="cs-form-table cs-form-table-he"
		style="table-layout: fixed;">
		<tbody>
			<tr>
				<td class="cs-name" style="width: 160px;">食品名称：</td>
				<td class="cs-in-style" style="width: 34%; padding-left: 10px;">${ledgerStock.foodName}</td>
				<td class="cs-name" style="width: 160px;">产地：</td>
				<td class="cs-in-style" style="padding-left: 10px;" colspan="">${ledgerStock.productionPlace}</td>
			</tr>
			<tr>
				<td class="cs-name" style="width: 160px;">来源/市场：</td>
				<td class="cs-in-style" style="padding-left: 10px;">${ledgerStock.param1}</td>
				<td class="cs-name" style="width: 160px;">供货档口：</td>
				<td class="cs-in-style" style="padding-left: 10px;">${ledgerStock.supplier}</td>
			</tr>
			<tr>
				<td class="cs-name" style="width: 160px;">供货者名称</td>
				<td class="cs-in-style" style="padding-left: 10px;">${ledgerStock.supplierUser}</td>
				<td class="cs-name" style="width: 160px;">供货者联系方式：</td>
				<td class="cs-in-style" style="padding-left: 10px;"> ${ledgerStock.supplierTel}</td>
			</tr>
			<tr>
				<td class="cs-name" style="width: 160px;">批次：</td>
				<td class="cs-in-style" style="padding-left: 10px;" colspan="">${ledgerStock.batchNumber}</td>
				<td class="cs-name" style="width: 160px;">进货数量：</td>
				<td class="cs-in-style" style="padding-left: 10px;" colspan="">${ledgerStock.stockCount}${ledgerStock.size}</td>
			</tr>
			<tr>
				<td class="cs-name" style="width: 160px;">生产日期：</td>
				<td class="cs-in-style" style="padding-left: 10px;" colspan=""><fmt:formatDate type="date" value="${ledgerStock.productionDate}"/></td>
				<td class="cs-name" style="width: 160px;">进货日期：</td>
				<td class="cs-in-style" style="padding-left: 10px;" colspan=""><fmt:formatDate type="date" value="${ledgerStock.stockDate}"/></td>
			</tr>
			<tr>
				<td class="cs-name" style="width: 160px;">保质期：</td>
				<td class="cs-in-style" style="padding-left: 10px;" colspan="">${ledgerStock.expirationDate}</td>
				<td class="cs-name" style="width: 160px;">进货凭证：</td>
				<td class="cs-in-style cs-td-img" style="padding-left: 10px;">
					<c:if test="${!empty ledgerStock.stockProof_Img}">
						<c:forEach var="img" items="${fn:split(ledgerStock.stockProof_Img, ',')}">
							<a class="cs-img-link" href="${webRoot}/resources/stock/${img}">
			                    <img src="${webRoot}/resources/stock/${img}">
			                </a>
						</c:forEach>
					</c:if>
				</td>
			</tr>
			<tr>
				<td class="cs-name" style="width: 160px;">检验证明：</td>
				<td class="cs-in-style" style="padding-left: 10px;" colspan="">${ledgerStock.checkProof}</td>
				<td class="cs-name" style="width: 160px;">检验证明图片：</td>
				<td class="cs-in-style cs-td-img" style="padding-left: 10px;" colspan="">
					<c:if test="${!empty ledgerStock.checkProof_Img}">
						<c:forEach var="img" items="${fn:split(ledgerStock.checkProof_Img, ',')}">
							<a class="cs-img-link" href="${webRoot}/resources/stock/${img}">
			                    <img src="${webRoot}/resources/stock/${img}">
			                </a>
						</c:forEach>
					</c:if>
				</td>
			</tr>
			<tr>
				<td class="cs-name" style="width: 160px;">检疫证明：</td>
				<td class="cs-in-style" style="padding-left: 10px;" colspan="">${ledgerStock.quarantineProof}</td>
				<td class="cs-name" style="width: 160px;">检疫证明图片：</td>
				<td class="cs-in-style cs-td-img" style="padding-left: 10px;" colspan="">
					<c:if test="${!empty ledgerStock.quarantineProof_Img}">
						<c:forEach var="img" items="${fn:split(ledgerStock.quarantineProof_Img, ',')}">
							<a class="cs-img-link" href="${webRoot}/resources/stock/${img}">
			                    <img src="${webRoot}/resources/stock/${img}">
			                </a>
						</c:forEach>
					</c:if>
				</td>
			</tr>
		</tbody>
	</table>

	<!-- 图片插件 -->
    <script src="${webRoot}/js/jquery.min.js"></script>  
    <script src="${webRoot}/js/jquery.imgbox.pack.js"></script>  
	<script>
		$(function() {
			$(".cs-img-link").imgbox({
				'speedIn' : 0,
				'speedOut' : 0,
				'alignment' : 'center',
				'overlayShow' : true,
				'allowMultiple' : false
			});
		});
		
		//关闭当前iframe
		function returnFun(){
			window.parent.closeMbIframe();
		}
	</script>

</body>
</html>
