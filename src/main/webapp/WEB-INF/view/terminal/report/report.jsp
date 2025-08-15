<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path;
	String resourcesUrl = basePath + "/resources";
%>
<c:set var="webRoot" value="<%=basePath%>" />
<c:set var="resourcesUrl" value="<%=resourcesUrl%>" />
<%--<%@include file="/WEB-INF/view/terminal/resource.jsp"%>--%>

<meta charset="UTF-8">
<%-- <link rel="stylesheet" href="${webRoot}/plug-in/bootstrap/css/bootstrap.css"> --%>
<link rel="stylesheet" type="text/css" href="${webRoot}/css/iconfont/iconfont.css" />
<link rel="stylesheet" type="text/css" href="${webRoot}/css/index.css" />
<link rel="stylesheet" type="text/css" href="${webRoot}/css/blue.css" />
<!doctype html>
<html lang="en" class="no-js">
<head>
	<meta charset="utf-8" />
	<title>检测报告</title>
	<meta name="description" content="">
	<meta name="keywords" content="">
	<style>
		*,p{
			margin:0;
			padding:0;
		}
		.btn{
			width: 160px;
			font-size: 16px;
			line-height: 36px;
			padding: 0;
			border-radius: 38px;

		}
		.cs-hide{
			display:none;
		}
		/* table{
			table-layout:fixed;
		} */
		.auto-center{
			margin:0 auto !important;
		}
		.cs-menu-btn {
		    /* width: 62px; */
		    height: 29px;
		    line-height: 28px;
		    border: 1px solid #e8e8e8;
		    background: #eee;
		    border-radius: 4px;
		    /* margin-right: 8px; */
		    padding: 0 6px;
	        display: inline-block;
    		margin-left: 10px;
    		color: #000;
		    text-decoration: none;
		    font-size: 14px;
		}
		.cs-menu-btn:hover i{
			color:#fff;
		}
		.cs-hd {
		    border-top: 1px dotted #ddd;
		}
		 @page{
		  margin-top: 8mm;    
		  margin-bottom: 5mm;
		}
		@media print {
			#myContent2 tr{
				height:36px;
			}
			#myContent2 tr td{
				padding:0px;
			}
			.MsoNormal{
				display:inline;
			}
			.MsoNormal2{
				padding-left:20px;
			}
			p{
				padding:0;
				margin:0;
			}
		}
	</style>
</head>
 <script type="text/javascript" src="${webRoot}/plug-in/pazu/pReport.js"></script>
 <script type="text/javascript" src="${webRoot}/plug-in/pazu/pazuclient.js"></script>
<body  style="tab-interval: 21pt; text-justify-trim: punctuation; background: #fff">
<div class="zz-content" id="myContent2" style="text-justify-trim:punctuation;">
 <div id="div_PAZU_Tips" style="color:red;background-color:yellow;padding:10px;border:1px solid red;" class="cs-hide">
	    *没有检测到PAZU云打印(位于localhost)，请<a href="${webRoot}/plug-in/pazu/PAZUCloud_Setup.exe">下载安装并刷新本页</a>
	    <br/>
	    安装程序会修改 hosts 文件（把 localhost.pazu.4fang 指向 127.0.0.1），请务必让杀毒允许此操作。
	</div> 	
	<div class="Section0" style="layout-grid: 15.6000pt;">
		<div align=center style="padding-top:20px;">
			<%--合并打印--%>
			<c:if test="${print eq '1'}">
			<div class="cs-alert-form-btn" style="padding: 0px 0px 20px 0px;">
			      	<a class="cs-menu-btn cs-fun-btn" href="javascript:" onclick="parent.closeMbIframe();"><i class="icon iconfont icon-fanhui"></i>返回</a>
					<a class="cs-menu-btn cs-fun-btn" href="javascript:" onclick="downloadPDF();"><i class="icon iconfont icon-xiafa"></i>下载</a>
					<a class="cs-menu-btn cs-fun-btn" href="javascript:" onclick="preview();"><i class="icon iconfont icon-dayin"></i>打印</a>
				  </div>
				  <div class="cs-hd"></div>
			</c:if>
			<c:forEach var="obj" items="${reList}">
			<c:set var="serialNumber" value="0"/>
			<div id="page1" class="printPage_${obj.id }" data-request-id="${obj.id }">
			<!--StartFragment-->
			<c:forEach var="item" begin="1" end="${pageNo}" varStatus="pageNumber">
				<c:set var="pageSize" value="0"/>
				<br/>
				<div class="Section0 _separately_print_${pageNumber.index}" style="layout-grid:15.6000pt;">
			<c:choose>
			
			<c:when test="${print==null}"><!-- 查了电子报告 -->
						<c:if test="${empty print && !empty scanNum && pageNumber.index==1}">
							<div style="padding:20px 0; font-zise:16px;text-align:center;width:100%; color:blue;">第${scanNum}次查看电子报告</div>
						</c:if>
							<table style="border-collapse:collapse;width:518.7000pt;mso-table-layout-alt:fixed; border:none;mso-border-left-alt:0.5000pt solid windowtext;mso-border-top-alt:0.5000pt solid windowtext; mso-border-right-alt:0.5000pt solid windowtext;mso-border-bottom-alt:0.5000pt solid windowtext;mso-border-insideh:0.5000pt solid windowtext; mso-border-insidev:0.5000pt solid windowtext;mso-padding-alt:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;">
								<tbody>
						<tr style="">
							<td width="575" valign="center" colspan="3"
								style="width:311.3000pt;padding:0.0000pt;padding-left: 80pt;border-left:none; mso-border-left-alt:none;border-right:none;mso-border-right-alt:none; border-top:none;mso-border-top-alt:none;border-bottom:none; mso-border-bottom-alt:none;text-align: center">
								<p class="MsoNormal" align=""
								   style="mso-char-indent-count:1.0000;text-align:center;">
									<span style="mso-spacerun:'yes';font-family:宋体;color:rgb(0,0,0); letter-spacing:0.0000pt;text-transform:none;font-style:normal; font-size:19.0000pt;mso-font-kerning:1.0000pt;letter-spacing: -3px;">${reportConfig.report_title}</span>
									<span style="font-family:宋体;color:rgb(0,0,0);letter-spacing:0.0000pt; text-transform:none;font-style:normal;font-size:14.0000pt; mso-font-kerning:1.0000pt;"><o:p></o:p></span>
								</p>
								<p style="font-family: 宋体; font-size:14.0000pt;font-weight: bold;">快 检 检 测 报 告</p>
							</td>
							<td width="33" valign="center"
								style="width:25.4500pt;padding:0;border-left:none; mso-border-left-alt:none;border-right:none;mso-border-right-alt:none; border-top:none;mso-border-top-alt:none;border-bottom:none; mso-border-bottom-alt:none;">
								<p class="MsoNormal"
								   style="text-align:right; float: right;    width: 20px;font-size: 15pt;    line-height: 29px;">防伪码</p>
							</td>
							<td width="71" valign="center"
								style="width:53.5500pt;padding:0;border-left:none; mso-border-left-alt:none;border-right:none;mso-border-right-alt:none; border-top:none;mso-border-top-alt:none;border-bottom:none; mso-border-bottom-alt:none;">
								<p class="MsoNormal" style="text-align: left;height: 100px;width: 100px;position: relative;overflow: hidden;">
							 	<span style="font-family:宋体;color:rgb(0,0,0);letter-spacing:0.0000pt; text-transform:none;font-style:normal;font-size:14pt; mso-font-kerning:1.0000pt;">
									<%--<img width="67" height="67" src="${webRoot}/img/terminal/report_2.png"/>--%>
									<c:choose>
										<c:when test="${reportNumber!=null }">
											<img width="100" src="${webRoot}/pay/generatorQrCode?qrCode=${samplingQrPath}&rN=${reportNumber}&unitId=${obj.id}&scan=1" style="position: absolute;right: 0px;width: 100px;"/>
										</c:when>
										<c:when test="${collectCode!=null }">
											<img width="100" src="${webRoot}/pay/generatorQrCode?qrCode=${samplingQrPath}&collectCode=${collectCode}&unitId=${obj.id}&scan=1" style="position: absolute;right: 0px;width: 100px;"/>
										</c:when>
										<c:otherwise>
											<img width="100" src="${webRoot}/pay/generatorQrCode?qrCode=${samplingQrPath}&unitId=${obj.id}&scan=1" style="position: absolute;right: 0px;width: 100px;"/>
										</c:otherwise>
									</c:choose>
								</span>
								</p>
							</td>
						</tr>
						</tbody>
					</table>

						<table class="MsoTableGrid" border="1" cellspacing="0"
							   style="border-collapse:collapse;width:518.7000pt;mso-table-layout-alt:fixed; border:none;mso-border-left-alt:0.5000pt solid windowtext;mso-border-top-alt:0.5000pt solid windowtext; mso-border-right-alt:0.5000pt solid windowtext;mso-border-bottom-alt:0.5000pt solid windowtext;mso-border-insideh:0.5000pt solid windowtext; mso-border-insidev:0.5000pt solid windowtext;mso-padding-alt:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;">
							<tbody>
							<tr style="height:22.1000pt;">
								<td width="691" valign="center" colspan="7"
									style="width:518.7000pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none; mso-border-left-alt:none;border-right:none;mso-border-right-alt:none; border-top:none;mso-border-top-alt:none;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
									<p class="MsoNormal" align="justify"
									   style="float: left;margin-right:5.6500pt;text-align:justify;text-justify:inter-ideograph;">
										<span style="mso-spacerun:'yes';font-family:宋体;color:rgb(0,0,0); letter-spacing:0.0000pt;text-transform:none;font-style:normal; font-size:14pt;mso-font-kerning:1.0000pt;background:rgb(255,255,255); mso-shading:rgb(255,255,255);">订单编号：${bean.samplingNo}</span>
									</p>
									<p class="MsoNormal" align="justify"
									   style="float: right; margin-right:5.6500pt;text-align:justify;text-justify:inter-ideograph;">
										<span style="mso-spacerun:'yes';font-family:宋体;color:rgb(0,0,0); letter-spacing:0.0000pt;text-transform:none;font-style:normal; font-size:14pt;mso-font-kerning:1.0000pt;background:rgb(255,255,255); mso-shading:rgb(255,255,255);">打印时间：<fmt:formatDate value="<%=new java.util.Date()%>" pattern="yyyy-MM-dd HH:mm:ss"/></span>
									</p></td>
							</tr>
							<tr style="height:29.7000pt;">
								<td width="139" valign="center"
									style="width:104.7500pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:1.0000pt solid windowtext; mso-border-left-alt:0.5000pt solid windowtext;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
									<p class="MsoNormal" align="center"
									   style="margin-right:5.6500pt;margin-left:5.6500pt;text-align:center;"><span
											style="mso-spacerun:'yes';font-family:宋体;mso-ascii-font-family:Calibri; mso-hansi-font-family:Calibri;mso-bidi-font-family:'Times New Roman';font-size:14.0000pt; mso-font-kerning:1.0000pt;">委托单位</span><span
											style="font-family:宋体;color:rgb(0,0,0);letter-spacing:0.0000pt; text-transform:none;font-style:normal;font-size:14.0000pt; mso-font-kerning:1.0000pt;">
         <o:p></o:p></span></p></td>
								<td width="551" valign="center" colspan="6"
									style="width:413.9500pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none; mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:1.0000pt solid windowtext;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
									<p class="MsoNormal"
									   style="margin-right:5.6500pt;margin-left:5.6500pt;text-align:left;"><span
											style="mso-spacerun:'yes';font-family:宋体;color:rgb(0,0,0); letter-spacing:0.0000pt;text-transform:none;font-style:normal; font-size:14.0000pt;mso-font-kerning:1.0000pt;">${obj.requesterName}</span><span
											style="font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri; mso-bidi-font-family:'Times New Roman';font-size:14.0000pt;mso-font-kerning:1.0000pt;">
         <o:p></o:p></span></p></td>
							</tr>
							<!-- <tr style="height:28.4500pt;">
								<td width="139" valign="center"
									style="width:104.7500pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:1.0000pt solid windowtext; mso-border-left-alt:0.5000pt solid windowtext;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
									<p class="MsoNormal" align="center"
									   style="margin-right:5.6500pt;margin-left:5.6500pt;text-align:center;"><span
											style="mso-spacerun:'yes';font-family:宋体;color:rgb(0,0,0); letter-spacing:0.0000pt;text-transform:none;font-style:normal; font-size:14.0000pt;mso-font-kerning:1.0000pt;">联系电话</span><span
											style="font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri; mso-bidi-font-family:'Times New Roman';font-size:14.0000pt;mso-font-kerning:1.0000pt;">
         <o:p></o:p></span></p></td>
								<td width="551" valign="center" colspan="6"
									style="width:413.9500pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none; mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
									<p class="MsoNormal"
									   style="margin-right:5.6500pt;margin-left:5.6500pt;text-align:left;"><span
											style="mso-spacerun:'yes';font-family:宋体;color:rgb(0,0,0); letter-spacing:0.0000pt;text-transform:none;font-style:normal; font-size:14.0000pt;mso-font-kerning:1.0000pt;">${obj.linkPhone}</span><span
											style="font-family:宋体;color:rgb(0,0,0);letter-spacing:0.0000pt; text-transform:none;font-style:normal;font-size:14.0000pt; mso-font-kerning:1.0000pt;">
         <o:p></o:p></span></p></td>
							</tr> -->
							<tr style="height:28.4500pt;">
								<td width="139" valign="center"
									style="width:104.7500pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:1.0000pt solid windowtext; mso-border-left-alt:0.5000pt solid windowtext;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
									<p class="MsoNormal" align="center"
									   style="margin-right:5.6500pt;margin-left:5.6500pt;text-align:center;"><span
											style="mso-spacerun:'yes';font-family:宋体;color:rgb(0,0,0); letter-spacing:0.0000pt;text-transform:none;font-style:normal; font-size:14.0000pt;mso-font-kerning:1.0000pt;">单位地址</span><span
											style="font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri; mso-bidi-font-family:'Times New Roman';font-size:14.0000pt;mso-font-kerning:1.0000pt;">
         <o:p></o:p></span></p></td>
								<td width="551" valign="center" colspan="6"
									style="width:413.9500pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none; mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
									<p class="MsoNormal"
									   style="margin-right:5.6500pt;margin-left:5.6500pt;text-align:left;"><span
											style="mso-spacerun:'yes';font-family:宋体;color:rgb(0,0,0); letter-spacing:0.0000pt;text-transform:none;font-style:normal; font-size:14.0000pt;mso-font-kerning:1.0000pt;">${obj.companyAddress}</span><span
											style="font-family:宋体;color:rgb(0,0,0);letter-spacing:0.0000pt; text-transform:none;font-style:normal;font-size:14.0000pt; mso-font-kerning:1.0000pt;">
         <o:p></o:p></span></p></td>
							</tr>
							<tr style="height:27.1000pt;">
								<td width="139" valign="center"
					style="text-align: center;width:104.7500pt;border-left:1.0000pt solid windowtext; mso-border-left-alt:0.5000pt solid windowtext;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
					
					<p class="MsoNormal" align="center"
					   style="display:inline; margin-right:5.6500pt;margin-left:5.6500pt;text-align:center;"><span
							style="mso-spacerun:'yes';font-family:宋体;color:rgb(0,0,0); letter-spacing:0.0000pt;text-transform:none;font-style:normal; font-size:14pt;mso-font-kerning:1.0000pt;"><c:if test="${!empty bean.inspectionId}">送检单位</c:if><c:if test="${empty bean.inspectionId}">送检人员</c:if></span><span
							style="font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri; mso-bidi-font-family:'Times New Roman';font-size:14pt;mso-font-kerning:1.0000pt;"><o:p></o:p></span></p>
					</td>
								<td width="551" valign="center" colspan="6"
									style="width:413.9500pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none; mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
									<p class="MsoNormal"
									   style="margin-right:5.6500pt;margin-left:5.6500pt;text-align:left;"><span
											style="mso-spacerun:'yes';font-family:宋体;color:rgb(0,0,0); letter-spacing:0.0000pt;text-transform:none;font-style:normal; font-size:14.0000pt;mso-font-kerning:1.0000pt;">${bean.inspectionCompany}</span><span
											style="font-family:宋体;color:rgb(0,0,0);letter-spacing:0.0000pt; text-transform:none;font-style:normal;font-size:14.0000pt; mso-font-kerning:1.0000pt;">
         <o:p></o:p></span></p>
									</td>
							</tr>
							<tr style="height:27.1000pt;">
								<td width="139" valign="center"
									style="text-align: center;width:104.7500pt;border-left:1.0000pt solid windowtext; mso-border-left-alt:0.5000pt solid windowtext;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
									<p class="MsoNormal" align="center"
									   style="display:inline; margin-right:5.6500pt;margin-left:5.6500pt;text-align:center;"><span
											style="mso-spacerun:'yes';font-family:宋体;color:rgb(0,0,0); letter-spacing:0.0000pt;text-transform:none;font-style:normal; font-size:14pt;mso-font-kerning:1.0000pt;">送检电话</span><span
											style="font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri; mso-bidi-font-family:'Times New Roman';font-size:14pt;mso-font-kerning:1.0000pt;">
				    <o:p></o:p></span></p></td>
								<td width="551" valign="center" colspan="6"
									style="width:413.9500pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none; mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
									<p class="MsoNormal"
									   style="margin-right:5.6500pt;margin-left:5.6500pt;mso-para-margin-right:0.0000gd; mso-para-margin-left:0.0000gd;text-align:left;">
										<span style="mso-spacerun:'yes';font-family:宋体;color:rgb(0,0,0); letter-spacing:0.0000pt;text-transform:none;font-style:normal; font-size:14.0000pt;mso-font-kerning:1.0000pt;">${bean.param3}</span><span
											style="font-family:宋体;color:rgb(0,0,0);letter-spacing:0.0000pt; text-transform:none;font-style:normal;font-size:14.0000pt; mso-font-kerning:1.0000pt;"><o:p></o:p></span>
									</p></td>
							</tr>
				<%-- 			<tr style="height:27.1000pt;">
								<td width="139" valign="center"
									style="width:104.7500pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:1.0000pt solid windowtext; mso-border-left-alt:0.5000pt solid windowtext;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
									<p class="MsoNormal" align="center"
									   style="margin-right:5.6500pt;margin-left:5.6500pt;mso-para-margin-right:0.0000gd; mso-para-margin-left:0.0000gd;text-align:center;">
										<span style="mso-spacerun:'yes';font-family:宋体;mso-ascii-font-family:Calibri; mso-hansi-font-family:Calibri;mso-bidi-font-family:'Times New Roman';font-size:14.0000pt; mso-font-kerning:1.0000pt;">送检地址</span><span
											style="font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri; mso-bidi-font-family:'Times New Roman';font-size:14.0000pt;mso-font-kerning:1.0000pt;"><o:p></o:p></span>
									</p></td>
								<td width="551" valign="center" colspan="6"
									style="width:413.9500pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none; mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
									<p class="MsoNormal"
									   style="margin-right:5.6500pt;margin-left:5.6500pt;text-align:left;"><span
											style="mso-spacerun:'yes';font-family:宋体;color:rgb(0,0,0); letter-spacing:0.0000pt;text-transform:none;font-style:normal; font-size:14.0000pt;mso-font-kerning:1.0000pt;">${bean.param4}</span><span
											style="font-family:宋体;color:rgb(0,0,0);letter-spacing:0.0000pt; text-transform:none;font-style:normal;font-size:14.0000pt; mso-font-kerning:1.0000pt;">
         <o:p></o:p></span></p>
									</td>
							</tr> --%>
							</table>
				<!-- 查了电子报告 -->
				<table style="border-collapse:collapse;width:519.7000pt;mso-table-layout-alt:fixed; border:none;mso-border-left-alt:0.5000pt solid windowtext;mso-border-top-alt:0.5000pt solid windowtext; mso-border-right-alt:0.5000pt solid windowtext;mso-border-bottom-alt:0.5000pt solid windowtext;mso-border-insideh:0.5000pt solid windowtext; mso-border-insidev:0.5000pt solid windowtext;mso-padding-alt:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;text-align: center;">
								<tr style="height:30.3500pt;">
									<td width="691" valign="center" colspan="8"
										style="width:518.7000pt;border-left:none; mso-border-left-alt:none;border-right:none;mso-border-right-alt:none; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid rgb(0,0,0); mso-border-bottom-alt:0.5000pt solid rgb(0,0,0);border-left: 1.0000pt solid windowtext;border-right: 1.0000pt solid windowtext;">
										<p class="MsoNormal" align="center" style="text-align:center;"><b><span
												style="mso-spacerun:'yes';font-family:宋体;mso-ascii-font-family:Calibri; mso-hansi-font-family:Calibri;mso-bidi-font-family:'Times New Roman';font-weight:bold; font-size:14pt;mso-font-kerning:1.0000pt;">检测结果</span></b><span
												style="font-family:宋体;color:rgb(0,0,0);letter-spacing:0.0000pt; text-transform:none;font-style:normal;font-size:14pt; mso-font-kerning:1.0000pt;">
         <o:p></o:p></span></p></td>
								</tr>
								<tr style="height:30.3500pt;background: #f1f1f1">
									<td valign="center"
										style="width:50px;border-left:1.0000pt solid windowtext; mso-border-left-alt:0.5000pt solid windowtext;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
										<p class="MsoNormal" align="center" style="text-align:center;"><b><span
												style="mso-spacerun:'yes';font-family:宋体;mso-ascii-font-family:Calibri; mso-hansi-font-family:Calibri;mso-bidi-font-family:'Times New Roman';font-weight:bold; font-size:14pt;mso-font-kerning:1.0000pt;">序号</span></b><b><span
												style="font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri; mso-bidi-font-family:'Times New Roman';font-weight:bold;font-size:14pt; mso-font-kerning:1.0000pt;">
          <o:p></o:p></span></b></p></td>
									<td valign="center" colspan="2"
										style="border-left:none; mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:1.0000pt solid windowtext;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
										<p class="MsoNormal" align="center" style="text-align:center;"><b><span
												style="mso-spacerun:'yes';font-family:宋体;mso-ascii-font-family:Calibri; mso-hansi-font-family:Calibri;mso-bidi-font-family:'Times New Roman';font-weight:bold; font-size:14pt;mso-font-kerning:1.0000pt;">样品名称</span></b><b><span
												style="font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri; mso-bidi-font-family:'Times New Roman';font-weight:bold;font-size:14pt; mso-font-kerning:1.0000pt;">
          <o:p></o:p></span></b></p></td>
									<!--进货数量列-->
									<c:if test="${showPurchaseNumber==1 || showPurchaseNumber==2}">
										<td  valign="center" style="width:117px; border-left:none; mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:1.0000pt solid windowtext;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
											<p class="MsoNormal" align="center" style="text-align:center;"><b><span
													style="mso-spacerun:'yes';font-family:宋体;mso-ascii-font-family:Calibri; mso-hansi-font-family:Calibri;mso-bidi-font-family:'Times New Roman';font-weight:bold; font-size:14pt;mso-font-kerning:1.0000pt;">进货数量(KG)</span></b><b><span
													style="font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri; mso-bidi-font-family:'Times New Roman';font-weight:bold;font-size:14pt; mso-font-kerning:1.0000pt;">
         <o:p></o:p></span></b></p></td>
									</c:if>
									<!--检测项目列-->
									<c:choose>
										<c:when test="${showPurchaseNumber==1 || showPurchaseNumber==2}">
											<td  valign="center"
												 style="width:170px; border-left:none; mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:1.0000pt solid windowtext;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
												<p class="MsoNormal" align="center" style="text-align:center;"><b><span
														style="mso-spacerun:'yes';font-family:宋体;mso-ascii-font-family:Calibri; mso-hansi-font-family:Calibri;mso-bidi-font-family:'Times New Roman';font-weight:bold; font-size:14pt;mso-font-kerning:1.0000pt;">检测项目</span></b><b><span
														style="font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri; mso-bidi-font-family:'Times New Roman';font-weight:bold;font-size:14pt; mso-font-kerning:1.0000pt;">
         <o:p></o:p></span></b></p></td>
										</c:when>
										<c:otherwise>
											<td  valign="center"
												 style="width:200px; border-left:none; mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:1.0000pt solid windowtext;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
												<p class="MsoNormal" align="center" style="text-align:center;"><b><span
														style="mso-spacerun:'yes';font-family:宋体;mso-ascii-font-family:Calibri; mso-hansi-font-family:Calibri;mso-bidi-font-family:'Times New Roman';font-weight:bold; font-size:14pt;mso-font-kerning:1.0000pt;">检测项目</span></b><b><span
														style="font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri; mso-bidi-font-family:'Times New Roman';font-weight:bold;font-size:14pt; mso-font-kerning:1.0000pt;">
         <o:p></o:p></span></b></p></td>
										</c:otherwise>
									</c:choose>
									<!--检测标准列-->
									<c:choose>
										<c:when test="${showPurchaseNumber==1 || showPurchaseNumber==2}">
											<td valign="center"
												style="width:135px;border-left:none; mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:1.0000pt solid windowtext;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
												<p class="MsoNormal" align="center" style="text-align:center;"><b><span
														style="mso-spacerun:'yes';font-family:宋体;mso-ascii-font-family:Calibri; mso-hansi-font-family:Calibri;mso-bidi-font-family:'Times New Roman';font-weight:bold; font-size:14pt;mso-font-kerning:1.0000pt;">检测标准</span></b><b><span
														style="font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri; mso-bidi-font-family:'Times New Roman';font-weight:bold;font-size:14pt; mso-font-kerning:1.0000pt;">
          <o:p></o:p></span></b></p></td>
										</c:when>
										<c:otherwise>
											<td valign="center"
												style="width:200px;border-left:none; mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:1.0000pt solid windowtext;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
												<p class="MsoNormal" align="center" style="text-align:center;"><b><span
														style="mso-spacerun:'yes';font-family:宋体;mso-ascii-font-family:Calibri; mso-hansi-font-family:Calibri;mso-bidi-font-family:'Times New Roman';font-weight:bold; font-size:14pt;mso-font-kerning:1.0000pt;">检测标准</span></b><b><span
														style="font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri; mso-bidi-font-family:'Times New Roman';font-weight:bold;font-size:14pt; mso-font-kerning:1.0000pt;">
          <o:p></o:p></span></b></p></td>
										</c:otherwise>
									</c:choose>

									<td  valign="center" colspan="3"
										style="width:80px;border-left:none; mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:1.0000pt solid windowtext;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
										<p class="MsoNormal" align="center" style="text-align:center;"><b><span
												style="mso-spacerun:'yes';font-family:宋体;color:rgb(0,0,0); letter-spacing:0.0000pt;font-weight:bold;text-transform:none; font-style:normal;font-size:14pt;mso-font-kerning:1.0000pt;">快检结果</span></b><b><span
												style="font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri; mso-bidi-font-family:'Times New Roman';font-weight:bold;font-size:14pt; mso-font-kerning:1.0000pt;">
          <o:p></o:p></span></b></p></td>
								</tr>
								<!-- 查了电子报告 -->
								<c:forEach items="${list}" var="samplingDetail" varStatus="status" begin="${(pageNumber.index-1)*10 }" end="${pageNumber.index*10-1}">
								<c:set var="checkUsername1" value="${samplingDetail.checkUsername}"/>
								<c:set var="serialNumber" value="${serialNumber+1}" />
								<c:set var="pageSize" value="${pageSize+1}" />
								<c:set var="checkDate1" value="${samplingDetail.checkDate}"/>
								<c:set var="pointName" value="${samplingDetail.pointName}"/>
								<c:set var="pointAddress" value="${samplingDetail.pointAddress}"/>
								<c:set var="pointPhone" value="${samplingDetail.pointPhone}"/>
								<c:set var="reviewImage" value="${samplingDetail.reviewImage}"/>
								<c:set var="approveImage" value="${samplingDetail.approveImage}"/>
								<c:set var="signatureImage" value="${samplingDetail.signatureImage}"/>
								<tr style="height:43px;">
									<td  valign="center"
										style="width:50px;border-left:1.0000pt solid windowtext; mso-border-left-alt:0.5000pt solid windowtext;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
										<p class="MsoNormal" align="center" style="text-align:center;"><span
												style="font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri; mso-bidi-font-family:'Times New Roman';font-size:14pt;mso-font-kerning:1.0000pt;">${serialNumber}</span><span
												style="font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri; mso-bidi-font-family:'Times New Roman';font-size:14pt;mso-font-kerning:1.0000pt;">
         <o:p></o:p></span></p></td>
									<td valign="center" colspan="2"
										style="border-left:none; mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
										<p class="MsoNormal" align="center" style="text-align:center;"><span
												style="mso-spacerun:'yes';font-family:宋体;mso-ascii-font-family:Calibri; mso-hansi-font-family:Calibri;mso-bidi-font-family:'Times New Roman';font-size:14pt; mso-font-kerning:1.0000pt;">${samplingDetail.foodName}</span><span
												style="font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri; mso-bidi-font-family:'Times New Roman';font-size:14pt;mso-font-kerning:1.0000pt;">
         <o:p></o:p></span></p></td>
									<c:if test="${showPurchaseNumber==1 || showPurchaseNumber==2}">
										<td  valign="center" style="width:117px; font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri; mso-bidi-font-family:'Times New Roman';font-size:14pt;mso-font-kerning:1.0000pt;border-left:none; mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;"mso-spacerun:'yes';font-family:宋体;mso-ascii-font-family:Calibri; mso-hansi-font-family:Calibri;mso-bidi-font-family:'Times New Roman';font-size:14pt; mso-font-kerning:1.0000pt;">
										${samplingDetail.purchaseAmount}
										</td>
									</c:if>
									<c:choose>
										<c:when test="${showPurchaseNumber==1 || showPurchaseNumber==2}">
											<td  valign="center" style="width:170px; font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri; mso-bidi-font-family:'Times New Roman';font-size:14pt;mso-font-kerning:1.0000pt;border-left:none; mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;"mso-spacerun:'yes';font-family:宋体;mso-ascii-font-family:Calibri; mso-hansi-font-family:Calibri;mso-bidi-font-family:'Times New Roman';font-size:14pt; mso-font-kerning:1.0000pt;">
											${samplingDetail.itemName}
											</td>
										</c:when>
										<c:otherwise>
											<td  valign="center" style="width:200px; font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri; mso-bidi-font-family:'Times New Roman';font-size:14pt;mso-font-kerning:1.0000pt;border-left:none; mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;"mso-spacerun:'yes';font-family:宋体;mso-ascii-font-family:Calibri; mso-hansi-font-family:Calibri;mso-bidi-font-family:'Times New Roman';font-size:14pt; mso-font-kerning:1.0000pt;">
											${samplingDetail.itemName}
											</td>
										</c:otherwise>
									</c:choose>
									<c:choose>
										<c:when test="${showPurchaseNumber==1 || showPurchaseNumber==2}">
											<td valign="center" style="width:150px;border-left:none; mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
												<p class="MsoNormal" align="center" style="text-align:center;"><span
														style="mso-spacerun:'yes';font-family:宋体;mso-ascii-font-family:Calibri; mso-hansi-font-family:Calibri;mso-bidi-font-family:'Times New Roman';font-size:14pt; mso-font-kerning:1.0000pt;">${fn:substring(samplingDetail.stdCode,0,17)}</span><span
														style="font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri; mso-bidi-font-family:'Times New Roman';font-size:14pt;mso-font-kerning:1.0000pt;">
	         <o:p></o:p></span></p></td>
										</c:when>
										<c:otherwise>
											<td  valign="center" style="width:200px;border-left:none; mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
												<p class="MsoNormal" align="center" style="text-align:center;"><span
														style="mso-spacerun:'yes';font-family:宋体;mso-ascii-font-family:Calibri; mso-hansi-font-family:Calibri;mso-bidi-font-family:'Times New Roman';font-size:14pt; mso-font-kerning:1.0000pt;">${fn:substring(samplingDetail.stdCode,0,23)}</span><span
														style="font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri; mso-bidi-font-family:'Times New Roman';font-size:14pt;mso-font-kerning:1.0000pt;">
	         <o:p></o:p></span></p></td>
										</c:otherwise>
									</c:choose>

									<td  valign="center" colspan="3"
										style="border-left:none; mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
										<p class="MsoNormal" align="center" style="text-align:center;"><span
												style="mso-spacerun:'yes';font-family:宋体;color:rgb(0,0,0); letter-spacing:0.0000pt;text-transform:none;font-style:normal; font-size:14pt;mso-font-kerning:1.0000pt;">${samplingDetail.conclusion}</span><span
												style="font-family:宋体;color:rgb(0,0,0);letter-spacing:0.0000pt; text-transform:none;font-style:normal;font-size:14pt; mso-font-kerning:1.0000pt;">
         <o:p></o:p></span></p></td>
								</tr>
							</c:forEach>
							<c:forEach var="i" begin="${pageSize+1}" end="10">
								<tr style="height:43px;">
									<td valign="center"
										style="border-left:1.0000pt solid windowtext; mso-border-left-alt:0.5000pt solid windowtext;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
										<p class="MsoNormal" align="center" style="text-align:center;"><span
												style="font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri; mso-bidi-font-family:'Times New Roman';font-size:14pt;mso-font-kerning:1.0000pt;"></span><span
												style="font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri; mso-bidi-font-family:'Times New Roman';font-size:14pt;mso-font-kerning:1.0000pt;">
        <o:p></o:p></span></p></td>
									<td valign="center" colspan="2"
										style="border-left:none; mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
										<p class="MsoNormal" align="center" style="text-align:center;"><span
												style="mso-spacerun:'yes';font-family:宋体;mso-ascii-font-family:Calibri; mso-hansi-font-family:Calibri;mso-bidi-font-family:'Times New Roman';font-size:14pt; mso-font-kerning:1.0000pt;"></span><span
												style="font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri; mso-bidi-font-family:'Times New Roman';font-size:14pt;mso-font-kerning:1.0000pt;">
        <o:p></o:p></span></p></td>
									<c:if test="${showPurchaseNumber==1 || showPurchaseNumber==2}">
										<td  valign="center"
											 style="border-left:none; mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
											<p class="MsoNormal" align="center" style="text-align:center;"><span
													style="mso-spacerun:'yes';font-family:宋体;mso-ascii-font-family:Calibri; mso-hansi-font-family:Calibri;mso-bidi-font-family:'Times New Roman';font-size:14pt; mso-font-kerning:1.0000pt;"></span><span
													style="font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri; mso-bidi-font-family:'Times New Roman';font-size:14pt;mso-font-kerning:1.0000pt;">
         <o:p></o:p></span></p></td>
									</c:if>
									<td valign="center"
										style="border-left:none; mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
										<p class="MsoNormal" align="center" style="text-align:center;"><span
												style="mso-spacerun:'yes';font-family:宋体;mso-ascii-font-family:Calibri; mso-hansi-font-family:Calibri;mso-bidi-font-family:'Times New Roman';font-size:14pt; mso-font-kerning:1.0000pt;"></span><span
												style="font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri; mso-bidi-font-family:'Times New Roman';font-size:14pt;mso-font-kerning:1.0000pt;">
        <o:p></o:p></span></p></td>
        							<td  valign="center"
											style="border-left:none; mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
											<p class="MsoNormal" align="center" style="text-align:center;"><span
													style="mso-spacerun:'yes';font-family:宋体;mso-ascii-font-family:Calibri; mso-hansi-font-family:Calibri;mso-bidi-font-family:'Times New Roman';font-size:14pt; mso-font-kerning:1.0000pt;"></span><span
													style="font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri; mso-bidi-font-family:'Times New Roman';font-size:14pt;mso-font-kerning:1.0000pt;">
         <o:p></o:p></span></p></td>
									<td valign="center" colspan="3"
										style="border-left:none; mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
										<p class="MsoNormal" align="center" style="text-align:center;"><span
												style="mso-spacerun:'yes';font-family:宋体;color:rgb(0,0,0); letter-spacing:0.0000pt;text-transform:none;font-style:normal; font-size:14pt;mso-font-kerning:1.0000pt;"></span><span
												style="font-family:宋体;color:rgb(0,0,0);letter-spacing:0.0000pt; text-transform:none;font-style:normal;font-size:14pt; mso-font-kerning:1.0000pt;">
        <o:p></o:p></span></p></td>
								</tr>
							</c:forEach>
							</table>
	<!-- 正文结束 -->
		<table style="border-collapse:collapse;width:520.7000pt;margin-left:-1px;mso-table-layout-alt:fixed; border:none;mso-border-left-alt:0.5000pt solid windowtext;mso-border-top-alt:0.5000pt solid windowtext; mso-border-right-alt:0.5000pt solid windowtext;mso-border-bottom-alt:0.5000pt solid windowtext;mso-border-insideh:0.5000pt solid windowtext; mso-border-insidev:0.5000pt solid windowtext;mso-padding-alt:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;">
								<tr style="height:27.1000pt;">
									<td width="139" valign="center"
										style="text-align: center;width:104.7500pt;border-left:1.0000pt solid windowtext; mso-border-left-alt:0.5000pt solid windowtext;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
										<p class="MsoNormal" align="center"
										   style="margin-right:5.6500pt;margin-left:5.6500pt;mso-para-margin-right:0.0000gd; mso-para-margin-left:0.0000gd;text-align:center;">
											<span style="mso-spacerun:'yes';font-family:宋体;mso-ascii-font-family:Calibri; mso-hansi-font-family:Calibri;mso-bidi-font-family:'Times New Roman';font-size:14pt; mso-font-kerning:1.0000pt;">检测机构</span><span
												style="font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri; mso-bidi-font-family:'Times New Roman';font-size:14pt;mso-font-kerning:1.0000pt;"><o:p></o:p></span>
										</p></td>
								<td width="551" valign="center" colspan="6"
										style="width:413.9500pt;border-left:none; mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
										<p class="MsoNormal MsoNormal2" style="text-align:left;margin-left:10.65pt"><span
												style="font-family:Calibri;mso-fareast-font-family:宋体;mso-bidi-font-family:'Times New Roman'; font-size:14pt;mso-font-kerning:1.0000pt;">
												<span class="signatureImageSpan"
													  style="position:absolute;z-index:1;margin-left: 331.0667px;margin-top: -47.4667px;">
													<img width="197" height="197"  class="signatureImage" src="data:image/png;base64,${signatureImage}"/>
												</span></span><span
												style="mso-spacerun:'yes';font-family:宋体;color:rgb(0,0,0); letter-spacing:0.0000pt;text-transform:none;font-style:normal; font-size:14pt;mso-font-kerning:1.0000pt;">${reportConfig.orgin_name} <!-- ${pointName } --></span><span
												style="font-family:宋体;color:rgb(0,0,0);letter-spacing:0.0000pt; text-transform:none;font-style:normal;font-size:14pt; mso-font-kerning:1.0000pt;"><o:p></o:p></span>
										</p></td>
								</tr>
								<tr style="height:27.1000pt;">
									<td width="139" valign="center"
										style="text-align: center;width:104.7500pt;border-left:1.0000pt solid windowtext; mso-border-left-alt:0.5000pt solid windowtext;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
										<p class="MsoNormal" align="center"
										   style="margin-right:5.6500pt;margin-left:5.6500pt;mso-para-margin-right:0.0000gd; mso-para-margin-left:0.0000gd;text-align:center;line-height: 18px;">
											<span style="mso-spacerun:'yes';font-family:宋体;mso-ascii-font-family:Calibri; mso-hansi-font-family:Calibri;mso-bidi-font-family:'Times New Roman';font-size:14pt; mso-font-kerning:1.0000pt;">机构地址</span><span
												style="font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri; mso-bidi-font-family:'Times New Roman';font-size:14pt;mso-font-kerning:1.0000pt;"><o:p></o:p></span>
										</p></td>
									<td width="551" valign="center" colspan="6"
										style="width:413.9500pt;border-left:none; mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
										<p class="MsoNormal MsoNormal2" style="text-align:left;margin-left: 10.6500pt;"><span
												style="mso-spacerun:'yes';font-family:宋体;color:rgb(0,0,0); letter-spacing:0.0000pt;text-transform:none;font-style:normal; font-size:14pt;mso-font-kerning:1.0000pt;">${pointAddress }</span><span
												style="font-family:宋体;color:rgb(0,0,0);letter-spacing:0.0000pt; text-transform:none;font-style:normal;font-size:14pt; mso-font-kerning:1.0000pt;"><o:p></o:p></span>
										</p></td>
								</tr>
								<tr style="height:27.1000pt;">
									<td width="139" valign="center"
										style="text-align: center;width:104.7500pt;border-left:1.0000pt solid windowtext; mso-border-left-alt:0.5000pt solid windowtext;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
										<p class="MsoNormal" align="center"
										   style="margin-right:5.6500pt;margin-left:5.6500pt;mso-para-margin-right:0.0000gd; mso-para-margin-left:0.0000gd;text-align:center;">
											<span style="mso-spacerun:'yes';font-family:宋体;mso-ascii-font-family:Calibri; mso-hansi-font-family:Calibri;mso-bidi-font-family:'Times New Roman';font-size:14pt; mso-font-kerning:1.0000pt;">检测时间</span><span
												style="font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri; mso-bidi-font-family:'Times New Roman';font-size:14pt;mso-font-kerning:1.0000pt;"><o:p></o:p></span>
										</p></td>
									<td width="551" valign="center" colspan="6"
										style="width:413.9500pt;border-left:none; mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
										<p class="MsoNormal MsoNormal2" style="text-align:left;margin-left: 10.6500pt;"><span
												style="mso-spacerun:'yes';font-family:宋体;color:rgb(0,0,0); letter-spacing:0.0000pt;text-transform:none;font-style:normal; font-size:14pt;mso-font-kerning:1.0000pt;"><fmt:formatDate value="${checkDate1}" pattern="yyyy-MM-dd"/></span><span
												style="font-family:宋体;color:rgb(0,0,0);letter-spacing:0.0000pt; text-transform:none;font-style:normal;font-size:14pt; mso-font-kerning:1.0000pt;"><o:p></o:p></span>
										</p></td>
								</tr>
								<tr style="height:29.8500pt;">
									<td width="139" valign="center"
										style="text-align: center;width:104.7500pt;border-left:1.0000pt solid windowtext; mso-border-left-alt:0.5000pt solid windowtext;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
										<p class="MsoNormal" align="center" style="text-align:center;"><span
												style="mso-spacerun:'yes';font-family:宋体;mso-ascii-font-family:Calibri; mso-hansi-font-family:Calibri;mso-bidi-font-family:'Times New Roman';font-size:14pt; mso-font-kerning:1.0000pt;">联系电话</span><span
												style="font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri; mso-bidi-font-family:'Times New Roman';font-size:14pt;mso-font-kerning:1.0000pt;"><o:p></o:p></span>
										</p></td>
									<td width="551" valign="center" colspan="6"
										style="width:413.9500pt;border-left:none; mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
										<p class="MsoNormal MsoNormal2" style="text-align:left;margin-left: 10.6500pt;"><span
												style="white-space: nowrap;mso-spacerun:'yes';font-family:宋体;mso-ascii-font-family:Calibri; mso-hansi-font-family:Calibri;mso-bidi-font-family:'Times New Roman';font-size:14pt; mso-font-kerning:1.0000pt;">${pointPhone }</span><span
												style="font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri; mso-bidi-font-family:'Times New Roman';font-size:14pt;mso-font-kerning:1.0000pt;"><o:p></o:p></span>
										</p></td>
								</tr>
								<tr style="height:29.1000pt;">
									<td class="checkUserStyle" colspan="2" valign="center"
										style="text-align: center;width:204.7500pt;padding-left: 46px;  mso-border-left-alt:0.5000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:none;mso-border-top-alt:0.5000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;border: none;">
										<p class="MsoNormal" align="center"
										   style="float:left; margin-right:5.6500pt;mso-para-margin-right:0.0000gd; mso-para-margin-left:0.0000gd;text-align:left;width:200px;">
											<span style="mso-spacerun:'yes';font-family:宋体;mso-ascii-font-family:Calibri; mso-hansi-font-family:Calibri;mso-bidi-font-family:'Times New Roman';font-size:14.0000pt; mso-font-kerning:1.0000pt;">检测：${checkUsername1}</span><span
												style="font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri; mso-bidi-font-family:'Times New Roman';font-size:14.0000pt;mso-font-kerning:1.0000pt;"><o:p></o:p></span>
										</p>
									</td>
									<td>
										<p class="MsoNormal" align="justify" style="margin-right:5.6500pt;text-align:justify;text-justify:inter-ideograph;">
								<span style="float: left;margin-top: 14px;mso-spacerun:'yes';font-family:宋体;color:rgb(0,0,0); letter-spacing:0.0000pt;text-transform:none;font-style:normal; font-size:14pt;mso-font-kerning:1.0000pt;">
								审核：
								</span>
											<img  height="50" width="70" class="reviewImage" src="data:image/png;base64,${reviewImage}" style="float:left;" />
										</p>
									</td>
									<td>
										<p class="MsoNormal" align="justify" style="margin-right:-7.6500pt;text-align:justify;text-justify:inter-ideograph;">
								<span style="float: left; margin-top: 14px;mso-spacerun:'yes';font-family:宋体;color:rgb(0,0,0); letter-spacing:0.0000pt;text-transform:none;font-style:normal; font-size:14pt;mso-font-kerning:1.0000pt;">
								批准：
								</span>
											<img  height="50" width="70" class="approveImage"  src="data:image/png;base64,${approveImage}" style="float:left;" />
										</p>
									</td>
								</tr>
								<tr <%--style="height:29.1000pt;"--%>>
									<td width="691" valign="center" colspan="7"
										style="width:518.7000pt;border-left:none; mso-border-left-alt:none;border-right:none;mso-border-right-alt:none; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:none; mso-border-bottom-alt:none;">
										<p class="MsoNormal" style="text-align:left;margin-top: -10pt;">
											<span style="mso-spacerun:'yes';font-family:宋体;color:rgb(0,0,0); letter-spacing:0.0000pt;text-transform:none;font-style:normal; font-size:14pt;mso-font-kerning:1.0000pt;">
											注：1.该检测报告仅对来样有效<br/>
											&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2.检测结果手写无效
<!-- 											&nbsp;&nbsp;&nbsp;&nbsp;3.本报告复印无效<br/> -->
											</span>
										</p>
										
									</td>
								</tr>
								<tr <%--style="height:29.1000pt;"--%>>
									<td width="691" valign="center" colspan="7"
										style="padding-left: 10px;width:518.7000pt;border-left:none; mso-border-left-alt:none;border-right:none;mso-border-right-alt:none; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:none; mso-border-bottom-alt:none;">
										<p class="MsoNormal" style="text-align:center;margin-top: -10px;">
										<span style="font-family: 宋体; font-size:14pt;">
										第${pageNumber.index}页 -  共${pageNo}页
										</span>
									</p>
									</td>
								</tr>
								</tbody>
							</table>

				</c:when>
			<c:when test="${print eq '1'}"> <!-- 后台打印报告 -->
					<table class="auto-center" style="border-collapse:collapse;width:518.7000pt;mso-table-layout-alt:fixed; border:none;mso-border-left-alt:0.5000pt solid windowtext;mso-border-top-alt:0.5000pt solid windowtext; mso-border-right-alt:0.5000pt solid windowtext;mso-border-bottom-alt:0.5000pt solid windowtext;mso-border-insideh:0.5000pt solid windowtext; mso-border-insidev:0.5000pt solid windowtext;mso-padding-alt:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;">
						<tbody>
						<tr style="height: 36px;">
			                  <td width="564" valign="center" colspan="3"
			                      style="width:311.3000pt;height:50pt; padding:0.0000pt;padding-left: 0pt;border-left:none; mso-border-left-alt:none;border-right:none;mso-border-right-alt:none; border-top:none;mso-border-top-alt:none;border-bottom:none; mso-border-bottom-alt:none;text-align: center;position: relative;">
			                      
			                          <span style="mso-spacerun:'yes';font-family:宋体;color:rgb(0,0,0); letter-spacing:0.0000pt;text-transform:none;font-style:normal; font-size:20.0000pt;mso-font-kerning:1.0000pt;letter-spacing: -3px;font-weight: bold; margin-bottom: 10px;padding-left: 30px;position: absolute;width: 100%;left: 0;top: -5px;">${reportConfig.report_title}</span>
			                          <span style="font-family:宋体;color:rgb(0,0,0);letter-spacing:0.0000pt; text-transform:none;font-style:normal;font-size:14.0000pt; mso-font-kerning:1.0000pt;"><o:p></o:p></span>
			                      <br>
			                      <span style="font-family: 宋体; font-size:18.0000pt;font-weight: bold;margin-top: 14px;position: absolute;width: 100%;left: 0;top: 20px;padding-left: 30px;">快 检 检 测 报 告</span >
			                  </td>
			
			                  <td width="116" valign="center"
			                      style="position: relative;padding:0;border-left:none; mso-border-left-alt:none;border-right:none;mso-border-right-alt:none; border-top:none;mso-border-top-alt:none;border-bottom:none; mso-border-bottom-alt:none;">
			                          <span style="float:left;padding: 0px 0;position: absolute;left: 15px;z-index: 10; font-size:14pt; top: 0px;line-height: 30px;margin-left: -8px;">防<br>伪<br>码</span>
			                           <img src="${webRoot}/pay/generatorQrCode?qrCode=${samplingQrPath}&reportNumber=${receiveBean.reportNumber}&scan=1&collectCode=${collectCode}&unitId=${obj.id}" style="float:right; margin-right:-10px;position: absolute;top:-3px;left: 27px; width:100px;height:100px;" />
			                  </td>
			
						</tr>
						</tbody>
					</table>
					<table class="MsoTableGrid auto-center" border="1" cellspacing="0"
						   style="border-collapse:collapse;width:518.7000pt;mso-table-layout-alt:fixed; border:none;mso-border-left-alt:0.5000pt solid windowtext;mso-border-top-alt:0.5000pt solid windowtext; mso-border-right-alt:0.5000pt solid windowtext;mso-border-bottom-alt:0.5000pt solid windowtext;mso-border-insideh:0.5000pt solid windowtext; mso-border-insidev:0.5000pt solid windowtext;mso-padding-alt:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;">
						<tbody>
						<tr style="height: 36px;" ><!-- style="height:22.1000pt;" -->
							<td width="691" valign="center" colspan="7"
								style="padding-top: 26px;text-align: center;width:518.7000pt;border-left:none; mso-border-left-alt:none;border-right:none;mso-border-right-alt:none; border-top:none;mso-border-top-alt:none;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
								<p class="MsoNormal" align="justify"
								   style="float: left;margin-right:5.6500pt;text-align:justify;text-justify:inter-ideograph;">
									<span style="mso-spacerun:'yes';font-family:宋体;color:rgb(0,0,0); letter-spacing:0.0000pt;text-transform:none;font-style:normal; font-size:14pt;mso-font-kerning:1.0000pt;background:rgb(255,255,255); mso-shading:rgb(255,255,255);">订单编号：${bean.samplingNo}</span>
								</p>
								<p class="MsoNormal" align="justify"
								   style="float: right; margin-right:5.6500pt;text-align:justify;text-justify:inter-ideograph;">
									<span style="mso-spacerun:'yes';font-family:宋体;color:rgb(0,0,0); letter-spacing:0.0000pt;text-transform:none;font-style:normal; font-size:14pt;mso-font-kerning:1.0000pt;background:rgb(255,255,255); mso-shading:rgb(255,255,255);">打印时间：<fmt:formatDate value="<%=new java.util.Date()%>" pattern="yyyy-MM-dd HH:mm:ss"/></span>
								</p></td>
						</tr>
						<tr style="height: 36px;" >
							<td width="139" valign="center"
								style="text-align: center;width:104.7500pt;border-left:1.0000pt solid windowtext; mso-border-left-alt:0.5000pt solid windowtext;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
								
								<p class="MsoNormal" align="center"
								   style="display:inline; margin-right:5.6500pt;margin-left:5.6500pt;text-align:center;"><span
										style="mso-spacerun:'yes';font-family:宋体;color:rgb(0,0,0); letter-spacing:0.0000pt;text-transform:none;font-style:normal; font-size:14pt;mso-font-kerning:1.0000pt;">委托单位</span><span
										style="font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri; mso-bidi-font-family:'Times New Roman';font-size:14pt;mso-font-kerning:1.0000pt;">
			    <o:p></o:p></span></p>
								</td>
							<td width="551" valign="center" colspan="6"
								style="width:413.9500pt;border-left:none; mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:1.0000pt solid windowtext;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
								<p class="MsoNormal MsoNormal2" align="center"
								   style="display:inline; margin-right:5.6500pt;text-align:center;"><span
										style="mso-spacerun:'yes';font-family:宋体;color:rgb(0,0,0); letter-spacing:0.0000pt;text-transform:none;font-style:normal; font-size:14pt;mso-font-kerning:1.0000pt;">${obj.requesterName}</span><span
										style="font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri; mso-bidi-font-family:'Times New Roman';font-size:14pt;mso-font-kerning:1.0000pt;">
			    <o:p></o:p></span></p></td>
						</tr>
						<!--  <tr style="height: 36px;" >
							<td width="139" valign="center"
								style="text-align: center;width:104.7500pt;border-left:1.0000pt solid windowtext; mso-border-left-alt:0.5000pt solid windowtext;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
								<p class="MsoNormal" align="center"
								   style="display:inline; margin-right:5.6500pt;margin-left:5.6500pt;text-align:center;"><span
										style="mso-spacerun:'yes';font-family:宋体;color:rgb(0,0,0); letter-spacing:0.0000pt;text-transform:none;font-style:normal; font-size:14pt;mso-font-kerning:1.0000pt;">联系电话</span><span
										style="font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri; mso-bidi-font-family:'Times New Roman';font-size:14pt;mso-font-kerning:1.0000pt;">
			    <o:p></o:p></span></p></td>
							<td width="551" valign="center" colspan="6"
								style="width:413.9500pt;border-left:none; mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
								<p class="MsoNormal MsoNormal2"
								   style="display:inline; text-align:left;"><span
										style="mso-spacerun:'yes';font-family:宋体;color:rgb(0,0,0); letter-spacing:0.0000pt;text-transform:none;font-style:normal; font-size:14pt;mso-font-kerning:1.0000pt;">${obj.linkPhone}</span><span
										style="font-family:宋体;color:rgb(0,0,0);letter-spacing:0.0000pt; text-transform:none;font-style:normal;font-size:14pt; mso-font-kerning:1.0000pt;">
			    <o:p></o:p></span></p></td>
						</tr>-->
						<tr style="height: 36px;" >
							<td width="139" valign="center"
								style="text-align: center;width:104.7500pt;border-left:1.0000pt solid windowtext; mso-border-left-alt:0.5000pt solid windowtext;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
								<p class="MsoNormal" align="center"
								   style="display:inline; margin-right:5.6500pt;margin-left:5.6500pt;text-align:center;"><span
										style="mso-spacerun:'yes';font-family:宋体;color:rgb(0,0,0); letter-spacing:0.0000pt;text-transform:none;font-style:normal; font-size:14pt;mso-font-kerning:1.0000pt;">单位地址</span><span
										style="font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri; mso-bidi-font-family:'Times New Roman';font-size:14pt;mso-font-kerning:1.0000pt;">
			    <o:p></o:p></span></p></td>
							<td width="551" valign="center" colspan="6"
								style="width:413.9500pt;border-left:none; mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
								<p class="MsoNormal MsoNormal2"
								   style="display:inline; text-align:left;"><span
										style="mso-spacerun:'yes';font-family:宋体;color:rgb(0,0,0); letter-spacing:0.0000pt;text-transform:none;font-style:normal; font-size:14pt;mso-font-kerning:1.0000pt;">${obj.companyAddress}</span><span
										style="font-family:宋体;color:rgb(0,0,0);letter-spacing:0.0000pt; text-transform:none;font-style:normal;font-size:14pt; mso-font-kerning:1.0000pt;">
			    <o:p></o:p></span></p></td>
						</tr>
						<tr style="height: 36px;" >
							<td width="139" valign="center"
							style="text-align: center;width:104.7500pt;border-left:1.0000pt solid windowtext; mso-border-left-alt:0.5000pt solid windowtext;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
							<p class="MsoNormal" align="center"
							   style="display:inline; margin-right:5.6500pt;margin-left:5.6500pt;text-align:center;"><span
									style="mso-spacerun:'yes';font-family:宋体;color:rgb(0,0,0); letter-spacing:0.0000pt;text-transform:none;font-style:normal; font-size:14pt;mso-font-kerning:1.0000pt;"><c:if test="${!empty bean.inspectionId}">送检单位</c:if><c:if test="${empty bean.inspectionId}">送检人员</c:if></span><span
									style="font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri; mso-bidi-font-family:'Times New Roman';font-size:14pt;mso-font-kerning:1.0000pt;"><o:p></o:p></span></p>
							</td>
							<td width="551" valign="center" colspan="6"
								style="width:413.9500pt;border-left:none; mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
								<p class="MsoNormal MsoNormal2" style="text-align:left;"><span
										style="mso-spacerun:'yes';font-family:宋体;color:rgb(0,0,0); letter-spacing:0.0000pt;text-transform:none;font-style:normal; font-size:14pt;mso-font-kerning:1.0000pt;">${bean.inspectionCompany}</span><span
										style="font-family:宋体;color:rgb(0,0,0);letter-spacing:0.0000pt; text-transform:none;font-style:normal;font-size:14pt; mso-font-kerning:1.0000pt;"><o:p></o:p></span>
								</p></td>
						</tr>
						<tr style="height: 36px;" >
							<td width="139" valign="center"
								style="text-align: center;width:104.7500pt;border-left:1.0000pt solid windowtext; mso-border-left-alt:0.5000pt solid windowtext;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
								<p class="MsoNormal" align="center"
								   style="display:inline; margin-right:5.6500pt;margin-left:5.6500pt;text-align:center;"><span
										style="mso-spacerun:'yes';font-family:宋体;color:rgb(0,0,0); letter-spacing:0.0000pt;text-transform:none;font-style:normal; font-size:14pt;mso-font-kerning:1.0000pt;">送检电话</span><span
										style="font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri; mso-bidi-font-family:'Times New Roman';font-size:14pt;mso-font-kerning:1.0000pt;">
			    <o:p></o:p></span></p></td>
							<td width="551" valign="center" colspan="6"
								style="width:413.9500pt;border-left:none; mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
								<p class="MsoNormal MsoNormal2"
								   style="text-align:left;">
									<span style="mso-spacerun:'yes';font-family:宋体;color:rgb(0,0,0); letter-spacing:0.0000pt;text-transform:none;font-style:normal; font-size:14pt;mso-font-kerning:1.0000pt;">${bean.param3}</span><span
										style="font-family:宋体;color:rgb(0,0,0);letter-spacing:0.0000pt; text-transform:none;font-style:normal;font-size:14pt; mso-font-kerning:1.0000pt;"><o:p></o:p></span>
								</p></td>
						</tr>
					<%-- 	<tr style="height: 36px;" >
							<td width="139" valign="center"
								style="text-align: center;width:104.7500pt;border-left:1.0000pt solid windowtext; mso-border-left-alt:0.5000pt solid windowtext;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
								<p class="MsoNormal" align="center"
								   style="margin-right:5.6500pt;margin-left:5.6500pt;mso-para-margin-right:0.0000gd; mso-para-margin-left:0.0000gd;text-align:center;">
									<span style="mso-spacerun:'yes';font-family:宋体;mso-ascii-font-family:Calibri; mso-hansi-font-family:Calibri;mso-bidi-font-family:'Times New Roman';font-size:14pt; mso-font-kerning:1.0000pt;">送检地址</span><span
										style="font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri; mso-bidi-font-family:'Times New Roman';font-size:14pt;mso-font-kerning:1.0000pt;"><o:p></o:p></span>
								</p></td>
							<td width="551" valign="center" colspan="6"
								style="width:413.9500pt;border-left:none; mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
								<p class="MsoNormal MsoNormal2" style="text-align:left;"><span
										style="mso-spacerun:'yes';font-family:宋体;color:rgb(0,0,0); letter-spacing:0.0000pt;text-transform:none;font-style:normal; font-size:14pt;mso-font-kerning:1.0000pt;">${bean.param4}</span><span
										style="font-family:宋体;color:rgb(0,0,0);letter-spacing:0.0000pt; text-transform:none;font-style:normal;font-size:14pt; mso-font-kerning:1.0000pt;"><o:p></o:p></span>
								</p></td>
						</tr> --%>
					</table>	
					<!-- 正文开始 -->
						<table class="auto-center" style="border-collapse:collapse;width:520.7000pt;margin-left:-1px;mso-table-layout-alt:fixed; border:none;mso-border-left-alt:0.5000pt solid windowtext;mso-border-top-alt:0.5000pt solid windowtext; mso-border-right-alt:0.5000pt solid windowtext;mso-border-bottom-alt:0.5000pt solid windowtext;mso-border-insideh:0.5000pt solid windowtext; mso-border-insidev:0.5000pt solid windowtext;mso-padding-alt:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;text-align: center;">
							<tr style="height:30.3500pt;">
								<td width="691" valign="center" colspan="8"
									style="width:518.7000pt;border-left:none; mso-border-left-alt:none;border-right:none;mso-border-right-alt:none; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid rgb(0,0,0); mso-border-bottom-alt:0.5000pt solid rgb(0,0,0);border-left: 1.0000pt solid windowtext;border-right: 1.0000pt solid windowtext;">
									<p class="MsoNormal" align="center" style="text-align:center;"><b><span
											style="mso-spacerun:'yes';font-family:宋体;mso-ascii-font-family:Calibri; mso-hansi-font-family:Calibri;mso-bidi-font-family:'Times New Roman';font-weight:bold; font-size:14pt;mso-font-kerning:1.0000pt;">检测结果</span></b><span
											style="font-family:宋体;color:rgb(0,0,0);letter-spacing:0.0000pt; text-transform:none;font-style:normal;font-size:14pt; mso-font-kerning:1.0000pt;">
        <o:p></o:p></span></p></td>
							</tr>
							<tr style="height:30.3500pt;background: #f1f1f1">
								<td  valign="center"
									style="width:50px;border-left:1.0000pt solid windowtext; mso-border-left-alt:0.5000pt solid windowtext;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
									<p class="MsoNormal" align="center" style="text-align:center;"><b><span
											style="mso-spacerun:'yes';font-family:宋体;mso-ascii-font-family:Calibri; mso-hansi-font-family:Calibri;mso-bidi-font-family:'Times New Roman';font-weight:bold; font-size:14pt;mso-font-kerning:1.0000pt;">序号</span></b><b><span
											style="font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri; mso-bidi-font-family:'Times New Roman';font-weight:bold;font-size:14pt; mso-font-kerning:1.0000pt;">
         <o:p></o:p></span></b></p></td>
								<td  valign="center" colspan="2"
									style="border-left:none; mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:1.0000pt solid windowtext;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
									<p class="MsoNormal" align="center" style="text-align:center;"><b><span
											style="mso-spacerun:'yes';font-family:宋体;mso-ascii-font-family:Calibri; mso-hansi-font-family:Calibri;mso-bidi-font-family:'Times New Roman';font-weight:bold; font-size:14pt;mso-font-kerning:1.0000pt;">样品名称
			                  </span></b><b><span
											style="font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri; mso-bidi-font-family:'Times New Roman';font-weight:bold;font-size:14pt; mso-font-kerning:1.0000pt;">
         <o:p></o:p></span></b></p></td>
								<!--进货数量列-->
								<c:if test="${showPurchaseNumber==1 || showPurchaseNumber==2}">
									<td  valign="center" style="width:117px; border-left:none; mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:1.0000pt solid windowtext;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
										<p class="MsoNormal" align="center" style="text-align:center;"><b><span
												style="mso-spacerun:'yes';font-family:宋体;mso-ascii-font-family:Calibri; mso-hansi-font-family:Calibri;mso-bidi-font-family:'Times New Roman';font-weight:bold; font-size:14pt;mso-font-kerning:1.0000pt;">进货数量(KG)</span></b><b><span
												style="font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri; mso-bidi-font-family:'Times New Roman';font-weight:bold;font-size:14pt; mso-font-kerning:1.0000pt;">
         <o:p></o:p></span></b></p></td>
								</c:if>
								<!--检测项目列-->
								<c:choose>
									<c:when test="${showPurchaseNumber==1 || showPurchaseNumber==2}">
										<td  valign="center"
											 style="width:170px; border-left:none; mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:1.0000pt solid windowtext;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
											<p class="MsoNormal" align="center" style="text-align:center;"><b><span
													style="mso-spacerun:'yes';font-family:宋体;mso-ascii-font-family:Calibri; mso-hansi-font-family:Calibri;mso-bidi-font-family:'Times New Roman';font-weight:bold; font-size:14pt;mso-font-kerning:1.0000pt;">检测项目</span></b><b><span
													style="font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri; mso-bidi-font-family:'Times New Roman';font-weight:bold;font-size:14pt; mso-font-kerning:1.0000pt;">
         <o:p></o:p></span></b></p></td>
									</c:when>
									<c:otherwise>
										<td  valign="center"
											 style="width:200px; border-left:none; mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:1.0000pt solid windowtext;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
											<p class="MsoNormal" align="center" style="text-align:center;"><b><span
													style="mso-spacerun:'yes';font-family:宋体;mso-ascii-font-family:Calibri; mso-hansi-font-family:Calibri;mso-bidi-font-family:'Times New Roman';font-weight:bold; font-size:14pt;mso-font-kerning:1.0000pt;">检测项目</span></b><b><span
													style="font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri; mso-bidi-font-family:'Times New Roman';font-weight:bold;font-size:14pt; mso-font-kerning:1.0000pt;">
         <o:p></o:p></span></b></p></td>
									</c:otherwise>
								</c:choose>
								<!--检测标准列-->
								<c:choose>
									<c:when test="${showPurchaseNumber==1 || showPurchaseNumber==2}">
										<td valign="center"
											style="width:135px;border-left:none; mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:1.0000pt solid windowtext;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
											<p class="MsoNormal" align="center" style="text-align:center;"><b><span
													style="mso-spacerun:'yes';font-family:宋体;mso-ascii-font-family:Calibri; mso-hansi-font-family:Calibri;mso-bidi-font-family:'Times New Roman';font-weight:bold; font-size:14pt;mso-font-kerning:1.0000pt;">检测标准</span></b><b><span
													style="font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri; mso-bidi-font-family:'Times New Roman';font-weight:bold;font-size:14pt; mso-font-kerning:1.0000pt;">
          <o:p></o:p></span></b></p></td>
									</c:when>
									<c:otherwise>
										<td valign="center"
											style="width:200px;border-left:none; mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:1.0000pt solid windowtext;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
											<p class="MsoNormal" align="center" style="text-align:center;"><b><span
													style="mso-spacerun:'yes';font-family:宋体;mso-ascii-font-family:Calibri; mso-hansi-font-family:Calibri;mso-bidi-font-family:'Times New Roman';font-weight:bold; font-size:14pt;mso-font-kerning:1.0000pt;">检测标准</span></b><b><span
													style="font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri; mso-bidi-font-family:'Times New Roman';font-weight:bold;font-size:14pt; mso-font-kerning:1.0000pt;">
          <o:p></o:p></span></b></p></td>
									</c:otherwise>
								</c:choose>
								<td  valign="center" colspan="3"
									style="width:80px;border-left:none; mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:1.0000pt solid windowtext;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
									<p class="MsoNormal" align="center" style="text-align:center;"><b><span
											style="mso-spacerun:'yes';font-family:宋体;color:rgb(0,0,0); letter-spacing:0.0000pt;font-weight:bold;text-transform:none; font-style:normal;font-size:14pt;mso-font-kerning:1.0000pt;">快检结果</span></b><b><span
											style="font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri; mso-bidi-font-family:'Times New Roman';font-weight:bold;font-size:14pt; mso-font-kerning:1.0000pt;">
         <o:p></o:p></span></b></p></td>
							</tr>
							<!-- 后台打印报告 -->
							<c:forEach items="${list}" var="samplingDetail" varStatus="status" begin="${(pageNumber.index-1)*10 }" end="${pageNumber.index*10-1}">
							    <c:set var="serialNumber" value="${serialNumber+1}" />
								<c:set var="pageSize" value="${pageSize+1}" />
								<c:set var="checkUsername1" value="${samplingDetail.checkUsername}"/>
								<c:set var="checkDate1" value="${samplingDetail.checkDate}"/>
								<c:set var="pointName" value="${samplingDetail.pointName}"/>
								<c:set var="pointAddress" value="${samplingDetail.pointAddress}"/>
								<c:set var="pointPhone" value="${samplingDetail.pointPhone}"/>
								<c:set var="reviewImage" value="${samplingDetail.reviewImage}"/>
								<c:set var="approveImage" value="${samplingDetail.approveImage}"/>
								<c:set var="signatureImage" value="${samplingDetail.signatureImage}"/>
								<c:set var="rdataId" value="${samplingDetail.rdataId}"/>
								<tr style="height:43px;">
									<td valign="center"
										style="width:50px;border-left:1.0000pt solid windowtext; mso-border-left-alt:0.5000pt solid windowtext;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
										<p class="MsoNormal" align="center" style="text-align:center;"><span
												style="font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri; mso-bidi-font-family:'Times New Roman';font-size:14pt;mso-font-kerning:1.0000pt;">${serialNumber}</span><span
												style="font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri; mso-bidi-font-family:'Times New Roman';font-size:14pt;mso-font-kerning:1.0000pt;">
         <o:p></o:p></span></p></td>
									<td valign="center" colspan="2"
										style="border-left:none; mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
										<p class="MsoNormal" align="center" style="text-align:center;"><span
												style="mso-spacerun:'yes';font-family:宋体;mso-ascii-font-family:Calibri; mso-hansi-font-family:Calibri;mso-bidi-font-family:'Times New Roman';font-size:14pt; mso-font-kerning:1.0000pt;">${samplingDetail.foodName}</span><span
												style="font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri; mso-bidi-font-family:'Times New Roman';font-size:14pt;mso-font-kerning:1.0000pt;">
         <o:p></o:p></span></p></td>
									<c:if test="${showPurchaseNumber==1 || showPurchaseNumber==2}">
										<td  valign="center" style="width:117px; font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri; mso-bidi-font-family:'Times New Roman';font-size:14pt;mso-font-kerning:1.0000pt;border-left:none; mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;"mso-spacerun:'yes';font-family:宋体;mso-ascii-font-family:Calibri; mso-hansi-font-family:Calibri;mso-bidi-font-family:'Times New Roman';font-size:14pt; mso-font-kerning:1.0000pt;">
										${samplingDetail.purchaseAmount}
										</td>
									</c:if>
									<c:choose>
										<c:when test="${showPurchaseNumber==1 || showPurchaseNumber==2}">
											<td  valign="center" style="width:170px; font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri; mso-bidi-font-family:'Times New Roman';font-size:14pt;mso-font-kerning:1.0000pt;border-left:none; mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;"mso-spacerun:'yes';font-family:宋体;mso-ascii-font-family:Calibri; mso-hansi-font-family:Calibri;mso-bidi-font-family:'Times New Roman';font-size:14pt; mso-font-kerning:1.0000pt;">
													${samplingDetail.itemName}
											</td>
										</c:when>
										<c:otherwise>
											<td  valign="center" style="width:200px; font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri; mso-bidi-font-family:'Times New Roman';font-size:14pt;mso-font-kerning:1.0000pt;border-left:none; mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;"mso-spacerun:'yes';font-family:宋体;mso-ascii-font-family:Calibri; mso-hansi-font-family:Calibri;mso-bidi-font-family:'Times New Roman';font-size:14pt; mso-font-kerning:1.0000pt;">
											 ${samplingDetail.itemName}
											</td>
										</c:otherwise>
									</c:choose>
									<c:choose>
										<c:when test="${showPurchaseNumber==1 || showPurchaseNumber==2}">
											<td width="" valign="center"
												style="width:150px;border-left:none; mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
												<p class="MsoNormal" align="center" style="text-align:center;"><span
														style="mso-spacerun:'yes';font-family:宋体;mso-ascii-font-family:Calibri; mso-hansi-font-family:Calibri;mso-bidi-font-family:'Times New Roman';font-size:14pt; mso-font-kerning:1.0000pt;">${fn:substring(samplingDetail.stdCode,0,17)}</span><span
														style="font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri; mso-bidi-font-family:'Times New Roman';font-size:14pt;mso-font-kerning:1.0000pt;">
	         <o:p></o:p></span></p></td>
										</c:when>
										<c:otherwise>
											<td width="" valign="center"
												style="width:200px;border-left:none; mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
												<p class="MsoNormal" align="center" style="text-align:center;"><span
														style="mso-spacerun:'yes';font-family:宋体;mso-ascii-font-family:Calibri; mso-hansi-font-family:Calibri;mso-bidi-font-family:'Times New Roman';font-size:14pt; mso-font-kerning:1.0000pt;">${fn:substring(samplingDetail.stdCode,0,23)}</span><span
														style="font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri; mso-bidi-font-family:'Times New Roman';font-size:14pt;mso-font-kerning:1.0000pt;">
	         <o:p></o:p></span></p></td>
										</c:otherwise>
									</c:choose>
									<td  valign="center" colspan="3"
										style="border-left:none; mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
										<p class="MsoNormal" align="center" style="text-align:center;"><span
												style="mso-spacerun:'yes';font-family:宋体;color:rgb(0,0,0); letter-spacing:0.0000pt;text-transform:none;font-style:normal; font-size:14pt;mso-font-kerning:1.0000pt;">${samplingDetail.conclusion}</span><span
												style="font-family:宋体;color:rgb(0,0,0);letter-spacing:0.0000pt; text-transform:none;font-style:normal;font-size:14pt; mso-font-kerning:1.0000pt;">
         <o:p></o:p></span></p></td>
								</tr>
							</c:forEach>
							<c:forEach var="i" begin="${pageSize+1}" end="10">
								<tr style="height:43px;">
									<td valign="center"
										style="width:50px;border-left:1.0000pt solid windowtext; mso-border-left-alt:0.5000pt solid windowtext;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
										<p class="MsoNormal" align="center" style="text-align:center;"><span
												style="font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri; mso-bidi-font-family:'Times New Roman';font-size:14pt;mso-font-kerning:1.0000pt;"></span><span
												style="font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri; mso-bidi-font-family:'Times New Roman';font-size:14pt;mso-font-kerning:1.0000pt;">
        <o:p></o:p></span></p></td>
									<td valign="center" colspan="2"
										style="border-left:none; mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
										<p class="MsoNormal" align="center" style="text-align:center;"><span
												style="mso-spacerun:'yes';font-family:宋体;mso-ascii-font-family:Calibri; mso-hansi-font-family:Calibri;mso-bidi-font-family:'Times New Roman';font-size:14pt; mso-font-kerning:1.0000pt;"></span><span
												style="font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri; mso-bidi-font-family:'Times New Roman';font-size:14pt;mso-font-kerning:1.0000pt;">
        <o:p></o:p></span></p></td>
									<c:if test="${showPurchaseNumber==1 || showPurchaseNumber==2}">
										<td  valign="center"
											 style="border-left:none; mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
											<p class="MsoNormal" align="center" style="text-align:center;"><span
													style="mso-spacerun:'yes';font-family:宋体;mso-ascii-font-family:Calibri; mso-hansi-font-family:Calibri;mso-bidi-font-family:'Times New Roman';font-size:14pt; mso-font-kerning:1.0000pt;"></span><span
													style="font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri; mso-bidi-font-family:'Times New Roman';font-size:14pt;mso-font-kerning:1.0000pt;">
         <o:p></o:p></span></p></td>
									</c:if>
									<td valign="center"
										style="border-left:none; mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
										<p class="MsoNormal" align="center" style="text-align:center;"><span
												style="mso-spacerun:'yes';font-family:宋体;mso-ascii-font-family:Calibri; mso-hansi-font-family:Calibri;mso-bidi-font-family:'Times New Roman';font-size:14pt; mso-font-kerning:1.0000pt;"></span><span
												style="font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri; mso-bidi-font-family:'Times New Roman';font-size:14pt;mso-font-kerning:1.0000pt;">
        <o:p></o:p></span></p></td>
        							<td  valign="center"
											style="border-left:none; mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
											<p class="MsoNormal" align="center" style="text-align:center;"><span
													style="mso-spacerun:'yes';font-family:宋体;mso-ascii-font-family:Calibri; mso-hansi-font-family:Calibri;mso-bidi-font-family:'Times New Roman';font-size:14pt; mso-font-kerning:1.0000pt;"></span><span
													style="font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri; mso-bidi-font-family:'Times New Roman';font-size:14pt;mso-font-kerning:1.0000pt;">
         <o:p></o:p></span></p></td>
									<td valign="center" colspan="3"
										style="border-left:none; mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
										<p class="MsoNormal" align="center" style="text-align:center;"><span
												style="mso-spacerun:'yes';font-family:宋体;color:rgb(0,0,0); letter-spacing:0.0000pt;text-transform:none;font-style:normal; font-size:14pt;mso-font-kerning:1.0000pt;"></span><span
												style="font-family:宋体;color:rgb(0,0,0);letter-spacing:0.0000pt; text-transform:none;font-style:normal;font-size:14pt; mso-font-kerning:1.0000pt;">
        <o:p></o:p></span></p></td>
								</tr>
							</c:forEach>
						</table>
					<!-- 正文结束 -->
		<table class="auto-center" style="border-collapse:collapse;width:520.7000pt;margin-left:-1px;mso-table-layout-alt:fixed; border:none;mso-border-left-alt:0.5000pt solid windowtext;mso-border-top-alt:0.5000pt solid windowtext; mso-border-right-alt:0.5000pt solid windowtext;mso-border-bottom-alt:0.5000pt solid windowtext;mso-border-insideh:0.5000pt solid windowtext; mso-border-insidev:0.5000pt solid windowtext;mso-padding-alt:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;">
								<tr style="height:27.1000pt;">
									<td width="139" valign="center"
										style="text-align: center;width:104.7500pt;border-left:1.0000pt solid windowtext; mso-border-left-alt:0.5000pt solid windowtext;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
										<p class="MsoNormal" align="center"
										   style="margin-right:5.6500pt;margin-left:5.6500pt;mso-para-margin-right:0.0000gd; mso-para-margin-left:0.0000gd;text-align:center;">
											<span style="mso-spacerun:'yes';font-family:宋体;mso-ascii-font-family:Calibri; mso-hansi-font-family:Calibri;mso-bidi-font-family:'Times New Roman';font-size:14pt; mso-font-kerning:1.0000pt;">检测机构</span><span
												style="font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri; mso-bidi-font-family:'Times New Roman';font-size:14pt;mso-font-kerning:1.0000pt;"><o:p></o:p></span>
										</p></td>
											<td width="551" valign="center" colspan="6"
										style="width:413.9500pt;border-left:none; mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
										<p class="MsoNormal MsoNormal2" style="text-align:left;"><span
												style="font-family:Calibri;mso-fareast-font-family:宋体;mso-bidi-font-family:'Times New Roman'; font-size:14pt;mso-font-kerning:1.0000pt;">
												<span  class="signatureImageSpan"
													   style="position:absolute;z-index:1;margin-left: 331.0667px;margin-top: -47.4667px;"><img
												width="197" height="197"  class="signatureImage" src="data:image/png;base64,${signatureImage}"/></span></span><span
												style="mso-spacerun:'yes';font-family:宋体;color:rgb(0,0,0); letter-spacing:0.0000pt;text-transform:none;font-style:normal; font-size:14pt;mso-font-kerning:1.0000pt;">${reportConfig.orgin_name} <!-- ${pointName } --></span><span
												style="font-family:宋体;color:rgb(0,0,0);letter-spacing:0.0000pt; text-transform:none;font-style:normal;font-size:14pt; mso-font-kerning:1.0000pt;"><o:p></o:p></span>
										</p></td>
								</tr>
								<tr style="height:27.1000pt;">
									<td width="139" valign="center"
										style="text-align: center;width:104.7500pt;border-left:1.0000pt solid windowtext; mso-border-left-alt:0.5000pt solid windowtext;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
										<p class="MsoNormal" align="center"
										   style="margin-right:5.6500pt;mso-para-margin-right:0.0000gd; mso-para-margin-left:0.0000gd;text-align:center;line-height: 18px;">
											<span style="mso-spacerun:'yes';font-family:宋体;mso-ascii-font-family:Calibri; mso-hansi-font-family:Calibri;mso-bidi-font-family:'Times New Roman';font-size:14pt; mso-font-kerning:1.0000pt;">机构地址</span><span
												style="font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri; mso-bidi-font-family:'Times New Roman';font-size:14pt;mso-font-kerning:1.0000pt;"><o:p></o:p></span>
										</p></td>
									<td width="551" valign="center" colspan="6"
										style="width:413.9500pt;border-left:none; mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
										<p class="MsoNormal MsoNormal2" style="text-align:left;"><span
												style="mso-spacerun:'yes';font-family:宋体;color:rgb(0,0,0); letter-spacing:0.0000pt;text-transform:none;font-style:normal; font-size:14pt;mso-font-kerning:1.0000pt;">${pointAddress }</span><span
												style="font-family:宋体;color:rgb(0,0,0);letter-spacing:0.0000pt; text-transform:none;font-style:normal;font-size:14pt; mso-font-kerning:1.0000pt;"><o:p></o:p></span>
										</p></td>
								</tr>
								<tr style="height:27.1000pt;">
									<td width="139" valign="center"
										style="text-align: center;width:104.7500pt;border-left:1.0000pt solid windowtext; mso-border-left-alt:0.5000pt solid windowtext;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
										<p class="MsoNormal" align="center"
										   style="margin-right:5.6500pt;mso-para-margin-right:0.0000gd; mso-para-margin-left:0.0000gd;text-align:center;">
											<span style="mso-spacerun:'yes';font-family:宋体;mso-ascii-font-family:Calibri; mso-hansi-font-family:Calibri;mso-bidi-font-family:'Times New Roman';font-size:14pt; mso-font-kerning:1.0000pt;">检测时间</span><span
												style="font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri; mso-bidi-font-family:'Times New Roman';font-size:14pt;mso-font-kerning:1.0000pt;"><o:p></o:p></span>
										</p></td>
									<td width="551" valign="center" colspan="6"
										style="width:413.9500pt;border-left:none; mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
										<p class="MsoNormal MsoNormal2" style="text-align:left;"><span
												style="mso-spacerun:'yes';font-family:宋体;color:rgb(0,0,0); letter-spacing:0.0000pt;text-transform:none;font-style:normal; font-size:14pt;mso-font-kerning:1.0000pt;"><fmt:formatDate value="${checkDate1}" pattern="yyyy-MM-dd"/></span><span
												style="font-family:宋体;color:rgb(0,0,0);letter-spacing:0.0000pt; text-transform:none;font-style:normal;font-size:14pt; mso-font-kerning:1.0000pt;"><o:p></o:p></span>
										</p></td>
								</tr>
								<tr style="height:29.8500pt;">
									<td width="139" valign="center"
										style="text-align: center;width:104.7500pt;border-left:1.0000pt solid windowtext; mso-border-left-alt:0.5000pt solid windowtext;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
										<p class="MsoNormal" align="center" style="text-align:center;"><span
												style="mso-spacerun:'yes';font-family:宋体;mso-ascii-font-family:Calibri; mso-hansi-font-family:Calibri;mso-bidi-font-family:'Times New Roman';font-size:14pt; mso-font-kerning:1.0000pt;">联系电话</span><span
												style="font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri; mso-bidi-font-family:'Times New Roman';font-size:14pt;mso-font-kerning:1.0000pt;"><o:p></o:p></span>
										</p></td>
									<td width="551" valign="center" colspan="6"
										style="width:413.9500pt;border-left:none; mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
										<p class="MsoNormal MsoNormal2" style="text-align:left;"><span
												style="white-space: nowrap;mso-spacerun:'yes';font-family:宋体;mso-ascii-font-family:Calibri; mso-hansi-font-family:Calibri;mso-bidi-font-family:'Times New Roman';font-size:14pt; mso-font-kerning:1.0000pt;">${pointPhone }</span><span
												style="font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri; mso-bidi-font-family:'Times New Roman';font-size:14pt;mso-font-kerning:1.0000pt;"><o:p></o:p></span>
										</p></td>
								</tr>
								<tr style="height:29.1000pt;">
									<td class="checkUserStyle" colspan="2" valign="center"
										style="text-align: center;width:140.7500pt;padding-left: 46px; mso-border-left-alt:0.5000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:none;mso-border-top-alt:0.5000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;border: none;">
										<p class="MsoNormal" align="center"
										   style="float:left; margin-right:5.6500pt;mso-para-margin-right:0.0000gd; mso-para-margin-left:0.0000gd;text-align:left;width:200px;">
											<span style="mso-spacerun:'yes';font-family:宋体;mso-ascii-font-family:Calibri; mso-hansi-font-family:Calibri;mso-bidi-font-family:'Times New Roman';font-size:14.0000pt; mso-font-kerning:1.0000pt;">检测：${checkUsername1}</span><span
												style="font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri; mso-bidi-font-family:'Times New Roman';font-size:14.0000pt;mso-font-kerning:1.0000pt;"><o:p></o:p></span>
										</p>
									</td>
									<td>
									<p class="MsoNormal pizhunStyle" align="justify" style="margin-right:5.6500pt;text-align:justify;text-justify:inter-ideograph;">
											<span style="float: left;margin-top: 14px;mso-spacerun:'yes';font-family:宋体;color:rgb(0,0,0); letter-spacing:0.0000pt;text-transform:none;font-style:normal; font-size:14pt;mso-font-kerning:1.0000pt;">
											审核：
											</span>
											<img  height="50" width="70" class="reviewImage" src="data:image/png;base64,${reviewImage}" style="float:left;" />
										</p>
									</td>
									<td>
									<p class="MsoNormal" align="justify" style="margin-right:-7.6500pt;text-align:justify;text-justify:inter-ideograph;">
											<span style="float: left; margin-top: 14px;mso-spacerun:'yes';font-family:宋体;color:rgb(0,0,0); letter-spacing:0.0000pt;text-transform:none;font-style:normal; font-size:14pt;mso-font-kerning:1.0000pt;">
											批准：
											</span>
											<img  height="50" width="70" class="approveImage"  src="data:image/png;base64,${approveImage}" style="float:left;" />
										</p>
									</td>
								</tr>
							<tr style="">
									<td width="691" valign="center" colspan="7"
										style="width:518.7000pt;border-left:none; mso-border-left-alt:none;border-right:none;mso-border-right-alt:none; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:none; mso-border-bottom-alt:none;">
										<p class="MsoNormal notesContentStyle" style="text-align:left;margin-top: -10px;" >
											<span class="notesContent" style="mso-spacerun:'yes';font-family:宋体;color:rgb(0,0,0); letter-spacing:0.0000pt;text-transform:none;font-style:normal; font-size:14pt;mso-font-kerning:1.0000pt;">
											注：1.该检测报告仅对来样有效<br/>
											&nbsp;&nbsp;2.检测结果手写无效
<!-- 											&nbsp;&nbsp;&nbsp;&nbsp;3.本报告复印无效<br/> -->
											</span>
										</p>
									</td>
								</tr>
							 	<tr style="" class="footerLine">
									<td width="691" valign="center" colspan="7"
										style="padding-left: 10px;width:518.7000pt;border-left:none; mso-border-left-alt:none;border-right:none;mso-border-right-alt:none; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:none; mso-border-bottom-alt:none;">
										<p class="MsoNormal" style="text-align:left;">
										<span style="font-family: 宋体; font-size:14pt; display:inline-block;margin-left: 288px;">
										第${pageNumber.index}页 -  共${pageNo}页
										</span>
										</p>
									</td>
								</tr>
								</tbody>
							</table>
			
				</c:when>
			</c:choose>
				</div>
			</c:forEach>
			</div>
			</c:forEach>
			<!--EndFragment-->
			<c:if test="${print eq '1'}">
			<div class="cs-alert-form-btn">
		      	<a class="cs-menu-btn cs-fun-btn" href="javascript:" onclick="parent.closeMbIframe();"><i class="icon iconfont icon-fanhui"></i>返回</a>
				<a class="cs-menu-btn cs-fun-btn" href="javascript:" onclick="downloadPDF();"><i class="icon iconfont icon-xiafa"></i>下载</a>
				<a class="cs-menu-btn cs-fun-btn" href="javascript:" onclick="preview();"><i class="icon iconfont icon-dayin"></i>打印</a>
			  </div>
			</c:if>
		</div>
	</div>
</div>
<script type="text/javascript" src="${webRoot}/js/jquery-1.11.3.min.js"></script>
<script type="text/javascript" src="${webRoot}/plug-in/layer/layer.js"></script>
<script type="text/javascript">
var pageNo="${pageNo}";
function preview(){
	var requestIds="";
	if (window.PAZU) {//插件打印
		//调用后台方法，将base64生成图片存放在指定路径下${webRoot}/img/report
		 $.ajax({
		        type: "POST",
		        url: "${webRoot}/reportPrint/GeneratorImage",
		        data: {"rdataId":"${rdataId}"},
		        dataType: "json",
		        async:false,
		        success: function(data) {
		        	$(".footerLine").addClass("cs-hide");
		            if (data && data.success) {
		            	if (!!window.ActiveXObject || "ActiveXObject" in window) {
		        			remove_ie_header_and_footer();
		        		}
		        		 doPagesetup();
		        		var reList=$("div[class*='printPage_']");
		        		if("${reportConfig.print_signature}"!="0") {
		        			$(".signatureImageSpan").html("");
		        		}else{
		        			$(".signatureImageSpan").attr("style","position:absolute;z-index:1;margin-left:321.0667px; margin-top: -53.4667px;width:230.0000px;height:230.0000px;");
		        		}
		        		$(".notesContent").html("注：1.该检测报告仅对来样有效<br/>&nbsp;&nbsp;&nbsp;&nbsp;2.检测结果手写无效");
						for(var i=0;i<reList.length;i++){
		        			requestIds+=$(reList[i]).attr("data-request-id")+",";
		        			$(reList[i]).find(".signatureImage").attr("src","${webRoot}/img/report/signatureImage.png");
		        			$(reList[i]).find(".approveImage").attr("src","${webRoot}/img/report/approveImage.png");
		        			$(reList[i]).find(".reviewImage").attr("src","${webRoot}/img/report/reviewImage.png");
		        			for(var j=0;j<pageNo;j++){
// 		        				 PAZU.TPrinter.footer="第"+j+"页 - 共"+pageNo+"页";
// 		        				 PAZU.TPrinter.fontCSS="font-family: 宋体;font-size:9pt;margin-left:195px;";
					   			var prnhtml=$(reList[i]).find("div:eq("+j+")").html();
			        			 //参数说明：1：打印内容 ,2：注入json,3：css样式，4是否预览
			        		   PAZU.print(prnhtml, null, ["${webRoot}/plug-in/pazu/print.css"], false);
		        			}
		        		}
		            } else {
		               tips("生成失败，请联系管理员！");
		            }
		        },error:function(){
		        	console.log("error");
		        }
		    });
		
	}else{//普通打印机打印
		var sprnstr="<!--StartFragment-->";
		 var eprnstr = "<!--EndFragment-->";
		 var bdhtml=window.document.body.innerHTML;
		 var prnhtml=bdhtml.substring(bdhtml.indexOf(sprnstr)+21);
		 prnhtml=prnhtml.substring(0,prnhtml.indexOf(eprnstr));
		 window.document.body.innerHTML=prnhtml;
		 window.print();
	}
	//打印成功
	 setTimeout(function(){
		//更新打印次数
		 requestIds = requestIds.substring(0,requestIds.length-1);
		$.ajax({
			type: "POST",
			url: "${webRoot}/reportPrint/printMutliForManager",
			data: {"id":"${bean.id}", "collectCode": "${collectCode}", "printType": 0,"detailIds":requestIds},
			dataType: "json",
			success: function (data) {
				layer.ready(function() {
					layer.msg('打印成功', {
						icon : 1
					});
				});
				location.reload();
			}
		});
	},2000); 
}
function downloadPDF(){
	var reList=$("div[class*='printPage_']");
	var requestIds="";
	for(var i=0;i<reList.length;i++){
		requestIds+=$(reList[i]).attr("data-request-id")+",";
	}	
	requestIds = requestIds.substring(0,requestIds.length-1);
	location.href="${webRoot}/rpt/create_pdf.do?samplingId=${bean.id}&requestIds="+requestIds+"&collectCode=${collectCode}";
}
/* 	function preview(){
		var requestIds="";
		if (window.PAZU) {//插件打印
			if (!!window.ActiveXObject || "ActiveXObject" in window) {
				remove_ie_header_and_footer();
			}
			 doPagesetup();
			var reList=$("div[class*='printPage_']");
			for(var i=0;i<reList.length;i++){
				requestIds+=$(reList[i]).attr("data-request-id")+",";
				 //参数说明：1：打印内容 ,2：注入json,3：css样式，4是否预览
				 PAZU.print($(reList[i]).html(), null, ["${webRoot}/plug-in/pazu/print.css"], true);
				
			}
		}else{//普通打印机打印
			var sprnstr="<!--StartFragment-->";
			 var eprnstr = "<!--EndFragment-->";
			 var bdhtml=window.document.body.innerHTML;
			 var prnhtml=bdhtml.substring(bdhtml.indexOf(sprnstr)+21);
			 prnhtml=prnhtml.substring(0,prnhtml.indexOf(eprnstr));
			 window.document.body.innerHTML=prnhtml;
			 window.print();
		}
		//打印成功
		 setTimeout(function(){
			//更新打印次数
			 requestIds = requestIds.substring(0,requestIds.length-1);
			$.ajax({
				type: "POST",
				url: "${webRoot}/reportPrint/printMutliSuccess",
				data: {"id":"${bean.id}", "collectCode": "${collectCode}", "printType": 0,"detailIds":requestIds},
				dataType: "json",
				success: function (data) {
					layer.ready(function() {
						layer.msg('打印成功', {
							icon : 1
						});
					});
					location.reload();
				}
			});
		},2000); 
	} */
	//打印
	/*function preview(){
		 chkPAZU();
		if (!!window.ActiveXObject || "ActiveXObject" in window) {
			remove_ie_header_and_footer();
		}
		
		var sprnstr = "<!--StartFragment-->";
		var eprnstr = "<!--EndFragment-->";

		var bdhtml=window.document.body.innerHTML;
		var prnhtml=bdhtml.substring(bdhtml.indexOf(sprnstr)+21);
		prnhtml=prnhtml.substring(0,prnhtml.indexOf(eprnstr));
		 doPagesetup();
		 //参数说明：1：打印内容 ,2：注入json,3：css样式，4是否预览
		 PAZU.print(prnhtml, null, ["${webRoot}/plug-in/pazu/print.css"], true);
		//打印成功
		setTimeout(function(){
			//更新打印次数
			$.ajax({
				type: "POST",
				url: "${webRoot}/reportPrint/printSuccess",
				data: {"id":${bean.id}, "reportNumber": "${reportNumber}", "printType": 1},
				dataType: "json",
				success: function (data) {
				}
			});
		},2000);
	}*/
</script>

</body>
</html>


