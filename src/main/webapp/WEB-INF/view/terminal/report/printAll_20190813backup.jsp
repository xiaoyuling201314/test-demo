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
			<table class="zz-choose">
				<tr>
					<td class="zz-name">
						检测单号：
					</td>
					<td class="zz-input">
						${bean.samplingNo }
					</td>
					
					<td class="zz-name">
						委托单位：
					</td>
					<td class="zz-input">
						${bean.regName }
					</td>
				
					
					<td class="zz-name">
						联系电话：
					</td>
					<td class="zz-input">
						${bean.regLinkPhone }
					</td>
				</tr>
			</table>
			</div>
			
			<div class="zz-table col-md-12 col-sm-12">
				<div class="zz-tb-bg zz-tb-bg2" style="height: 750px;">
					<table>
						<tr class="zz-tb-title">
							<th style="width: 100px">序号</th>
							<th>检测样品</th>
							<th>检测项目</th>
							<th>检测结果</th>
							<c:if test="${printType==1}">
								<th style="width: 150px">
								<ul>
								<li>
									<input tabindex="1" type="checkbox" style="margin-right:43px;" onclick="checkedAll()" id="mainCheckBox" >
								</li>
								</ul>
								</th>
							</c:if>
						</tr>
						<c:forEach items="${list}" var="samplingDetail" varStatus="index" >
							<tr>
								<td>${index.index+1}</td>
								<td>${samplingDetail.foodName }</td>
								<td>${samplingDetail.itemName }</td>
								<td>${samplingDetail.conclusion }</td>
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
			<c:choose>
				<c:when test="${outPrint==1}">
					<a href="${webRoot}/reportPrint/printNoLogin" class="btn btn-danger _cancel_btn">取消</a>
				</c:when>
				<c:otherwise>
					<a href="${webRoot}/reportPrint/list" class="btn btn-danger _cancel_btn">取消</a>
				</c:otherwise>
			</c:choose>
				<a href="javascript:" onclick="printReport();" class="btn btn-primary">打印</a>
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
				<div id="page1">
					<div class="Section0 _separately_print" style="layout-grid:15.6000pt;">
						
							<table style="border-collapse:collapse;width:518.7000pt;mso-table-layout-alt:fixed; border:none;mso-border-left-alt:0.5000pt solid windowtext;mso-border-top-alt:0.5000pt solid windowtext; mso-border-right-alt:0.5000pt solid windowtext;mso-border-bottom-alt:0.5000pt solid windowtext;mso-border-insideh:0.5000pt solid windowtext; mso-border-insidev:0.5000pt solid windowtext;mso-padding-alt:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;">
								<tbody>
								<tr style="">
									<%-- <td width="160" valign="center" colspan="2" style="">
										<p class="MsoNormal" align="center" style="text-align:center;">
										 <span style="font-family:Calibri;mso-fareast-font-family:宋体;mso-bidi-font-family:'Times New Roman'; font-size:10.5000pt;mso-font-kerning:1.0000pt;">
											 <img width="150" height="50" src="${webRoot}/img/terminal/report_1.png" style="margin-top: 10px;" />
										 </span>
											<b><span style="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></b>
											<span style=""><o:p></o:p></span>
										</p>
									</td> --%>
									<td width="575" valign="center" colspan="3"
										style="width:311.3000pt;padding:0.0000pt;padding-left: 80pt;border-left:none; mso-border-left-alt:none;border-right:none;mso-border-right-alt:none; border-top:none;mso-border-top-alt:none;border-bottom:none; mso-border-bottom-alt:none;text-align: center">
										<p class="MsoNormal" align=""
										   style="mso-char-indent-count:1.0000;text-align:center;">
											<span style="mso-spacerun:'yes';font-family:宋体;color:rgb(0,0,0); letter-spacing:0.0000pt;text-transform:none;font-style:normal; font-size:19.0000pt;mso-font-kerning:1.0000pt;letter-spacing: -3px;">广东中检达元检测技术有限公司</span>
											<span style="font-family:宋体;color:rgb(0,0,0);letter-spacing:0.0000pt; text-transform:none;font-style:normal;font-size:14.0000pt; mso-font-kerning:1.0000pt;"><o:p></o:p></span>
										</p>
										<p style="font-family: 宋体; font-size:14.0000pt;font-weight: bold;">快 检 检 测 报 告</p>
									</td>
									<td width="33" valign="center"
										style="width:25.4500pt;padding:10.0000pt 8.4000pt 0.0000pt 5.4000pt ;border-left:none; mso-border-left-alt:none;border-right:none;mso-border-right-alt:none; border-top:none;mso-border-top-alt:none;border-bottom:none; mso-border-bottom-alt:none;">
										<p class="MsoNormal"
										   style="text-align:right; float: right;    width: 5px;font-size: 12px;">防伪码</p>
									</td>
									<td width="71" valign="center"
										style="width:53.5500pt;padding:0;border-left:none; mso-border-left-alt:none;border-right:none;mso-border-right-alt:none; border-top:none;mso-border-top-alt:none;border-bottom:none; mso-border-bottom-alt:none;">
										<p class="MsoNormal" style="text-align: left;height: 100px;width: 84px;position: relative;overflow: hidden;">
									 	<span style="font-family:宋体;color:rgb(0,0,0);letter-spacing:0.0000pt; text-transform:none;font-style:normal;font-size:10.5000pt; mso-font-kerning:1.0000pt;">
											<%--<img width="67" height="67" src="${webRoot}/img/terminal/report_2.png"/>--%>
											<img width="80" src="${webRoot}/pay/generatorQrCode?qrCode=${webRoot}/reportPrint/report?samplingId=${bean.id}" style="position: absolute;right: -16px;width: 116px;" />
										</span>
										</p>
									</td>
								</tr>
								</tbody>
							</table>
							<table class="MsoTableGrid" border="1" cellspacing="0"
								   style=" border-collapse:collapse;width:518.7000pt;mso-table-layout-alt:fixed; border:none;mso-border-left-alt:0.5000pt solid windowtext;mso-border-top-alt:0.5000pt solid windowtext; mso-border-right-alt:0.5000pt solid windowtext;mso-border-bottom-alt:0.5000pt solid windowtext;mso-border-insideh:0.5000pt solid windowtext; mso-border-insidev:0.5000pt solid windowtext;mso-padding-alt:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;">
								<tbody>
								<tr style="height:22.1000pt;">
									<td width="691" valign="center" colspan="7"
										style="padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none; mso-border-left-alt:none;border-right:none;mso-border-right-alt:none; border-top:none;mso-border-top-alt:none;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
										<p class="MsoNormal" align="justify"
										   style="float: left;margin-right:5.6500pt;text-align:justify;text-justify:inter-ideograph;">
											<span style="mso-spacerun:'yes';font-family:宋体;color:rgb(0,0,0); letter-spacing:0.0000pt;text-transform:none;font-style:normal; font-size:10.5000pt;mso-font-kerning:1.0000pt;background:rgb(255,255,255); mso-shading:rgb(255,255,255);">订单号：${bean.samplingNo}</span>
										</p>
										<p class="MsoNormal" align="justify"
										   style="float: right; margin-right:5.6500pt;text-align:justify;text-justify:inter-ideograph;">
											<span style="mso-spacerun:'yes';font-family:宋体;color:rgb(0,0,0); letter-spacing:0.0000pt;text-transform:none;font-style:normal; font-size:10.5000pt;mso-font-kerning:1.0000pt;background:rgb(255,255,255); mso-shading:rgb(255,255,255);">打印时间：<fmt:formatDate value="<%=new java.util.Date()%>" pattern="yyyy-MM-dd HH:mm:ss"/></span>
										</p></td>
								</tr>
								<tr style="height:29.7000pt;">
									<td width="139" valign="center"
										style="padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:1.0000pt solid windowtext; mso-border-left-alt:0.5000pt solid windowtext;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
										<p class="MsoNormal" align="center"
										   style="margin-right:5.6500pt;margin-left:5.6500pt;text-align:center;"><span
												style="mso-spacerun:'yes';font-family:宋体;mso-ascii-font-family:Calibri; mso-hansi-font-family:Calibri;mso-bidi-font-family:'Times New Roman';font-size:12.0000pt; mso-font-kerning:1.0000pt;">委托单位</span><span
												style="font-family:宋体;color:rgb(0,0,0);letter-spacing:0.0000pt; text-transform:none;font-style:normal;font-size:12.0000pt; mso-font-kerning:1.0000pt;">
         <o:p></o:p></span></p></td>
									<td width="551" valign="center" colspan="6"
										style="padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none; mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:1.0000pt solid windowtext;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
										<p class="MsoNormal"
										   style="margin-right:5.6500pt;margin-left:5.6500pt;text-align:left;"><span
												style="mso-spacerun:'yes';font-family:宋体;color:rgb(0,0,0); letter-spacing:0.0000pt;text-transform:none;font-style:normal; font-size:12.0000pt;mso-font-kerning:1.0000pt;">${bean.regName}</span><span
												style="font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri; mso-bidi-font-family:'Times New Roman';font-size:12.0000pt;mso-font-kerning:1.0000pt;">
         <o:p></o:p></span></p></td>
								</tr>
								<tr style="height:28.4500pt;">
									<td width="139" valign="center"
										style="padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:1.0000pt solid windowtext; mso-border-left-alt:0.5000pt solid windowtext;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
										<p class="MsoNormal" align="center"
										   style="margin-right:5.6500pt;margin-left:5.6500pt;text-align:center;"><span
												style="mso-spacerun:'yes';font-family:宋体;color:rgb(0,0,0); letter-spacing:0.0000pt;text-transform:none;font-style:normal; font-size:12.0000pt;mso-font-kerning:1.0000pt;">联系电话</span><span
												style="font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri; mso-bidi-font-family:'Times New Roman';font-size:12.0000pt;mso-font-kerning:1.0000pt;">
         <o:p></o:p></span></p></td>
									<td width="551" valign="center" colspan="6"
										style="padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none; mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
										<p class="MsoNormal"
										   style="margin-right:5.6500pt;margin-left:5.6500pt;text-align:left;"><span
												style="mso-spacerun:'yes';font-family:宋体;color:rgb(0,0,0); letter-spacing:0.0000pt;text-transform:none;font-style:normal; font-size:12.0000pt;mso-font-kerning:1.0000pt;">${bean.regLinkPhone}</span><span
												style="font-family:宋体;color:rgb(0,0,0);letter-spacing:0.0000pt; text-transform:none;font-style:normal;font-size:12.0000pt; mso-font-kerning:1.0000pt;">
         <o:p></o:p></span></p></td>
								</tr>
								
							</table>
								
								
								
								
								
							<table style="border-collapse:collapse;width:518.7000pt;mso-table-layout-alt:fixed; border:none;mso-border-left-alt:0.5000pt solid windowtext;mso-border-top-alt:0.5000pt solid windowtext; mso-border-right-alt:0.5000pt solid windowtext;mso-border-bottom-alt:0.5000pt solid windowtext;mso-border-insideh:0.5000pt solid windowtext; mso-border-insidev:0.5000pt solid windowtext;mso-padding-alt:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;">
								<tr style="height:30.3500pt;">
									<td width="691" valign="center" colspan="7"
										style="width:518.7000pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none; mso-border-left-alt:none;border-right:none;mso-border-right-alt:none; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid rgb(0,0,0); mso-border-bottom-alt:0.5000pt solid rgb(0,0,0);border-left: 1.0000pt solid windowtext;border-right: 1.0000pt solid windowtext;">
										<p class="MsoNormal" align="center" style="text-align:center;"><b><span
												style="mso-spacerun:'yes';font-family:宋体;mso-ascii-font-family:Calibri; mso-hansi-font-family:Calibri;mso-bidi-font-family:'Times New Roman';font-weight:bold; font-size:10.5000pt;mso-font-kerning:1.0000pt;">检测结果</span></b><span
												style="font-family:宋体;color:rgb(0,0,0);letter-spacing:0.0000pt; text-transform:none;font-style:normal;font-size:10.5000pt; mso-font-kerning:1.0000pt;">
         <o:p></o:p></span></p></td>
								</tr>
								<tr style="height:30.3500pt;">
									<td width="59" valign="center"
										style="padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:1.0000pt solid windowtext; mso-border-left-alt:0.5000pt solid windowtext;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
										<p class="MsoNormal" align="center" style="text-align:center;"><b><span
												style="mso-spacerun:'yes';font-family:宋体;mso-ascii-font-family:Calibri; mso-hansi-font-family:Calibri;mso-bidi-font-family:'Times New Roman';font-weight:bold; font-size:10.5000pt;mso-font-kerning:1.0000pt;">序号</span></b><b><span
												style="font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri; mso-bidi-font-family:'Times New Roman';font-weight:bold;font-size:10.5000pt; mso-font-kerning:1.0000pt;">
          <o:p></o:p></span></b></p></td>
									<td width="250" valign="center" colspan="2"
										style="padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none; mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:1.0000pt solid windowtext;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
										<p class="MsoNormal" align="center" style="text-align:center;"><b><span
												style="mso-spacerun:'yes';font-family:宋体;mso-ascii-font-family:Calibri; mso-hansi-font-family:Calibri;mso-bidi-font-family:'Times New Roman';font-weight:bold; font-size:10.5000pt;mso-font-kerning:1.0000pt;">样品名称</span></b><b><span
												style="font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri; mso-bidi-font-family:'Times New Roman';font-weight:bold;font-size:10.5000pt; mso-font-kerning:1.0000pt;">
          <o:p></o:p></span></b></p></td>
									<td width="255" valign="center"
										style="padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none; mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:1.0000pt solid windowtext;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
										<p class="MsoNormal" align="center" style="text-align:center;"><b><span
												style="mso-spacerun:'yes';font-family:宋体;mso-ascii-font-family:Calibri; mso-hansi-font-family:Calibri;mso-bidi-font-family:'Times New Roman';font-weight:bold; font-size:10.5000pt;mso-font-kerning:1.0000pt;">检测项目</span></b><b><span
												style="font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri; mso-bidi-font-family:'Times New Roman';font-weight:bold;font-size:10.5000pt; mso-font-kerning:1.0000pt;">
          <o:p></o:p></span></b></p></td>
									<td width="126" valign="center" colspan="3"
										style="padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none; mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:1.0000pt solid windowtext;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
										<p class="MsoNormal" align="center" style="text-align:center;"><b><span
												style="mso-spacerun:'yes';font-family:宋体;color:rgb(0,0,0); letter-spacing:0.0000pt;font-weight:bold;text-transform:none; font-style:normal;font-size:10.5000pt;mso-font-kerning:1.0000pt;">快检结果</span></b><b><span
												style="font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri; mso-bidi-font-family:'Times New Roman';font-weight:bold;font-size:10.5000pt; mso-font-kerning:1.0000pt;">
          <o:p></o:p></span></b></p></td>
								</tr>
								<c:forEach items="${list}" var="samplingDetail" varStatus="status" >
									<c:set var="checkUsername1" value="${samplingDetail.checkUsername}"/>
									<c:set var="checkDate1" value="${samplingDetail.checkDate}"/>
									<tr style="height:28.8500pt;">
										<td width="59" valign="center"
											style="padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:1.0000pt solid windowtext; mso-border-left-alt:0.5000pt solid windowtext;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
											<p class="MsoNormal" align="center" style="text-align:center;"><span
													style="font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri; mso-bidi-font-family:'Times New Roman';font-size:10.5000pt;mso-font-kerning:1.0000pt;">${status.index+1}</span><span
													style="font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri; mso-bidi-font-family:'Times New Roman';font-size:10.5000pt;mso-font-kerning:1.0000pt;">
         <o:p></o:p></span></p></td>
										<td width="250" valign="center" colspan="2"
											style="padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none; mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
											<p class="MsoNormal" align="center" style="text-align:center;"><span
													style="mso-spacerun:'yes';font-family:宋体;mso-ascii-font-family:Calibri; mso-hansi-font-family:Calibri;mso-bidi-font-family:'Times New Roman';font-size:10.5000pt; mso-font-kerning:1.0000pt;">${samplingDetail.foodName}</span><span
													style="font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri; mso-bidi-font-family:'Times New Roman';font-size:10.5000pt;mso-font-kerning:1.0000pt;">
         <o:p></o:p></span></p></td>
										<td width="255" valign="center"
											style="padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none; mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
											<p class="MsoNormal" align="center" style="text-align:center;"><span
													style="mso-spacerun:'yes';font-family:宋体;mso-ascii-font-family:Calibri; mso-hansi-font-family:Calibri;mso-bidi-font-family:'Times New Roman';font-size:10.5000pt; mso-font-kerning:1.0000pt;">${samplingDetail.itemName}</span><span
													style="font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri; mso-bidi-font-family:'Times New Roman';font-size:10.5000pt;mso-font-kerning:1.0000pt;">
         <o:p></o:p></span></p></td>
										<td width="126" valign="center" colspan="3"
											style="padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none; mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
											<p class="MsoNormal" align="center" style="text-align:center;"><span
													style="mso-spacerun:'yes';font-family:宋体;color:rgb(0,0,0); letter-spacing:0.0000pt;text-transform:none;font-style:normal; font-size:10.5000pt;mso-font-kerning:1.0000pt;">${samplingDetail.conclusion}</span><span
													style="font-family:宋体;color:rgb(0,0,0);letter-spacing:0.0000pt; text-transform:none;font-style:normal;font-size:10.5000pt; mso-font-kerning:1.0000pt;">
         <o:p></o:p></span></p></td>
									</tr>
								</c:forEach>
								<c:forEach var="i" begin="${fn:length(list)+1}" end="11">
									<tr style="height:28.8500pt;">
										<td width="59" valign="center"
											style="padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:1.0000pt solid windowtext; mso-border-left-alt:0.5000pt solid windowtext;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
											<p class="MsoNormal" align="center" style="text-align:center;"><span
													style="font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri; mso-bidi-font-family:'Times New Roman';font-size:10.5000pt;mso-font-kerning:1.0000pt;"></span><span
													style="font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri; mso-bidi-font-family:'Times New Roman';font-size:10.5000pt;mso-font-kerning:1.0000pt;">
         <o:p></o:p></span></p></td>
										<td width="250" valign="center" colspan="2"
											style="padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none; mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
											<p class="MsoNormal" align="center" style="text-align:center;"><span
													style="mso-spacerun:'yes';font-family:宋体;mso-ascii-font-family:Calibri; mso-hansi-font-family:Calibri;mso-bidi-font-family:'Times New Roman';font-size:10.5000pt; mso-font-kerning:1.0000pt;"></span><span
													style="font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri; mso-bidi-font-family:'Times New Roman';font-size:10.5000pt;mso-font-kerning:1.0000pt;">
         <o:p></o:p></span></p></td>
										<td width="255" valign="center"
											style="padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none; mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
											<p class="MsoNormal" align="center" style="text-align:center;"><span
													style="mso-spacerun:'yes';font-family:宋体;mso-ascii-font-family:Calibri; mso-hansi-font-family:Calibri;mso-bidi-font-family:'Times New Roman';font-size:10.5000pt; mso-font-kerning:1.0000pt;"></span><span
													style="font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri; mso-bidi-font-family:'Times New Roman';font-size:10.5000pt;mso-font-kerning:1.0000pt;">
         <o:p></o:p></span></p></td>
										<td width="126" valign="center" colspan="3"
											style="padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none; mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
											<p class="MsoNormal" align="center" style="text-align:center;"><span
													style="mso-spacerun:'yes';font-family:宋体;color:rgb(0,0,0); letter-spacing:0.0000pt;text-transform:none;font-style:normal; font-size:10.5000pt;mso-font-kerning:1.0000pt;"></span><span
													style="font-family:宋体;color:rgb(0,0,0);letter-spacing:0.0000pt; text-transform:none;font-style:normal;font-size:10.5000pt; mso-font-kerning:1.0000pt;">
         <o:p></o:p></span></p></td>
									</tr>
								</c:forEach>
							</table>
							
							
							
							
							<table style="border-collapse:collapse;width:518.7000pt;mso-table-layout-alt:fixed; border:none;mso-border-left-alt:0.5000pt solid windowtext;mso-border-top-alt:0.5000pt solid windowtext; mso-border-right-alt:0.5000pt solid windowtext;mso-border-bottom-alt:0.5000pt solid windowtext;mso-border-insideh:0.5000pt solid windowtext; mso-border-insidev:0.5000pt solid windowtext;mso-padding-alt:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;">

								<tr style="height:27.1000pt;">
									<td width="139" valign="center"
										style="width:104.7500pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:1.0000pt solid windowtext; mso-border-left-alt:0.5000pt solid windowtext;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
										<p class="MsoNormal" align="center"
										   style="margin-left:5.6500pt;margin-left:5.6500pt;mso-para-margin-right:0.0000gd; mso-para-margin-left:0.0000gd;text-align:center;">
											<span style="mso-spacerun:'yes';font-family:宋体;mso-ascii-font-family:Calibri; mso-hansi-font-family:Calibri;mso-bidi-font-family:'Times New Roman';font-size:12.0000pt; mso-font-kerning:1.0000pt;">送检单位</span><span
												style="font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri; mso-bidi-font-family:'Times New Roman';font-size:12.0000pt;mso-font-kerning:1.0000pt;"><o:p></o:p></span>
										</p></td>
									<td width="551" valign="center" colspan="6"
										style="width:413.9500pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none; mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
										<p class="MsoNormal" style="text-align:left;"><span
												style="mso-spacerun:'yes';font-family:宋体;color:rgb(0,0,0); letter-spacing:0.0000pt;text-transform:none;font-style:normal; font-size:12.0000pt;mso-font-kerning:1.0000pt;">${unit.companyName}</span><span
												style="font-family:宋体;color:rgb(0,0,0);letter-spacing:0.0000pt; text-transform:none;font-style:normal;font-size:12.0000pt; mso-font-kerning:1.0000pt;"><o:p></o:p></span>
										</p></td>
								</tr>
								<tr style="height:27.1000pt;">
									<td width="139" valign="center"
										style="width:104.7500pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:1.0000pt solid windowtext; mso-border-left-alt:0.5000pt solid windowtext;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
										<p class="MsoNormal" align="center"
										   style="margin-right:5.6500pt;margin-left:5.6500pt;mso-para-margin-right:0.0000gd; mso-para-margin-left:0.0000gd;text-align:center;">
											<span style="mso-spacerun:'yes';font-family:宋体;color:rgb(0,0,0); letter-spacing:0.0000pt;text-transform:none;font-style:normal; font-size:12.0000pt;mso-font-kerning:1.0000pt;">联系电话</span><span
												style="font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri; mso-bidi-font-family:'Times New Roman';font-size:12.0000pt;mso-font-kerning:1.0000pt;"><o:p></o:p></span>
										</p></td>
									<td width="551" valign="center" colspan="6"
										style="width:413.9500pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none; mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
										<p class="MsoNormal"
										   style="margin-right:5.6500pt;margin-left:5.6500pt;mso-para-margin-right:0.0000gd; mso-para-margin-left:0.0000gd;text-align:left;">
											<span style="mso-spacerun:'yes';font-family:宋体;color:rgb(0,0,0); letter-spacing:0.0000pt;text-transform:none;font-style:normal; font-size:12.0000pt;mso-font-kerning:1.0000pt;">${unit.linkPhone}</span><span
												style="font-family:宋体;color:rgb(0,0,0);letter-spacing:0.0000pt; text-transform:none;font-style:normal;font-size:12.0000pt; mso-font-kerning:1.0000pt;"><o:p></o:p></span>
										</p></td>
								</tr>
								<tr style="height:27.1000pt;">
									<td width="139" valign="center"
										style="width:104.7500pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:1.0000pt solid windowtext; mso-border-left-alt:0.5000pt solid windowtext;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
										<p class="MsoNormal" align="center"
										   style="margin-right:5.6500pt;margin-left:5.6500pt;mso-para-margin-right:0.0000gd; mso-para-margin-left:0.0000gd;text-align:center;">
											<span style="mso-spacerun:'yes';font-family:宋体;mso-ascii-font-family:Calibri; mso-hansi-font-family:Calibri;mso-bidi-font-family:'Times New Roman';font-size:12.0000pt; mso-font-kerning:1.0000pt;">单位地址</span><span
												style="font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri; mso-bidi-font-family:'Times New Roman';font-size:12.0000pt;mso-font-kerning:1.0000pt;"><o:p></o:p></span>
										</p></td>
									<td width="551" valign="center" colspan="6"
										style="width:413.9500pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none; mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
										<p class="MsoNormal" style="text-align:left;"><span
												style="mso-spacerun:'yes';font-family:宋体;color:rgb(0,0,0); letter-spacing:0.0000pt;text-transform:none;font-style:normal; font-size:12.0000pt;mso-font-kerning:1.0000pt;">${unit.companyAddress}</span><span
												style="font-family:宋体;color:rgb(0,0,0);letter-spacing:0.0000pt; text-transform:none;font-style:normal;font-size:12.0000pt; mso-font-kerning:1.0000pt;"><o:p></o:p></span>
										</p></td>
								</tr>
								<tr style="height:27.1000pt;">
									<td width="139" valign="center"
										style="width:104.7500pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:1.0000pt solid windowtext; mso-border-left-alt:0.5000pt solid windowtext;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
										<p class="MsoNormal" align="center"
										   style="margin-right:5.6500pt;margin-left:5.6500pt;mso-para-margin-right:0.0000gd; mso-para-margin-left:0.0000gd;text-align:center;">
											<span style="mso-spacerun:'yes';font-family:宋体;mso-ascii-font-family:Calibri; mso-hansi-font-family:Calibri;mso-bidi-font-family:'Times New Roman';font-size:12.0000pt; mso-font-kerning:1.0000pt;">检测机构</span><span
												style="font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri; mso-bidi-font-family:'Times New Roman';font-size:12.0000pt;mso-font-kerning:1.0000pt;"><o:p></o:p></span>
										</p></td>
									<td width="551" valign="center" colspan="6"
										style="width:413.9500pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none; mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
										<p class="MsoNormal" style="text-align:left;"><span
												style="font-family:Calibri;mso-fareast-font-family:宋体;mso-bidi-font-family:'Times New Roman'; font-size:12.0000pt;mso-font-kerning:1.0000pt;"><span
												style="position:absolute;z-index:1;margin-left:375.0667px; margin-top:-55.4667px;width:151.0000px;height:151.0000px;"><img
												width="151" height="151" src="${webRoot}/img/terminal/report.png"/></span></span><span
												style="mso-spacerun:'yes';font-family:宋体;color:rgb(0,0,0); letter-spacing:0.0000pt;text-transform:none;font-style:normal; font-size:12.0000pt;mso-font-kerning:1.0000pt;">广东中检达元检测技术有限公司</span><span
												style="font-family:宋体;color:rgb(0,0,0);letter-spacing:0.0000pt; text-transform:none;font-style:normal;font-size:12.0000pt; mso-font-kerning:1.0000pt;"><o:p></o:p></span>
										</p></td>
								</tr>
								<tr style="height:29.8500pt;">
									<td width="139" valign="center"
										style="width:104.7500pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:1.0000pt solid windowtext; mso-border-left-alt:0.5000pt solid windowtext;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
										<p class="MsoNormal" align="center" style="text-align:center;"><span
												style="mso-spacerun:'yes';font-family:宋体;mso-ascii-font-family:Calibri; mso-hansi-font-family:Calibri;mso-bidi-font-family:'Times New Roman';font-size:12.0000pt; mso-font-kerning:1.0000pt;">检测人员</span><span
												style="font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri; mso-bidi-font-family:'Times New Roman';font-size:12.0000pt;mso-font-kerning:1.0000pt;"><o:p></o:p></span>
										</p></td>
									<td width="551" valign="center" colspan="6"
										style="width:413.9500pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none; mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
										<p class="MsoNormal" style="text-align:left;"><span
												style="mso-spacerun:'yes';font-family:宋体;mso-ascii-font-family:Calibri; mso-hansi-font-family:Calibri;mso-bidi-font-family:'Times New Roman';font-size:12.0000pt; mso-font-kerning:1.0000pt;">${checkUsername1}</span><span
												style="font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri; mso-bidi-font-family:'Times New Roman';font-size:12.0000pt;mso-font-kerning:1.0000pt;"><o:p></o:p></span>
										</p></td>
								</tr>
								<tr style="height:27.1000pt;">
									<td width="139" valign="center"
										style="width:104.7500pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:1.0000pt solid windowtext; mso-border-left-alt:0.5000pt solid windowtext;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
										<p class="MsoNormal" align="center"
										   style="margin-right:5.6500pt;margin-left:5.6500pt;mso-para-margin-right:0.0000gd; mso-para-margin-left:0.0000gd;text-align:center;">
											<span style="mso-spacerun:'yes';font-family:宋体;mso-ascii-font-family:Calibri; mso-hansi-font-family:Calibri;mso-bidi-font-family:'Times New Roman';font-size:12.0000pt; mso-font-kerning:1.0000pt;">检测时间</span><span
												style="font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri; mso-bidi-font-family:'Times New Roman';font-size:12.0000pt;mso-font-kerning:1.0000pt;"><o:p></o:p></span>
										</p></td>
									<td width="551" valign="center" colspan="6"
										style="width:413.9500pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none; mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
										<p class="MsoNormal" style="text-align:left;"><span
												style="mso-spacerun:'yes';font-family:宋体;color:rgb(0,0,0); letter-spacing:0.0000pt;text-transform:none;font-style:normal; font-size:12.0000pt;mso-font-kerning:1.0000pt;"><fmt:formatDate value="${checkDate1}" pattern="yyyy-MM-dd"/></span><span
												style="font-family:宋体;color:rgb(0,0,0);letter-spacing:0.0000pt; text-transform:none;font-style:normal;font-size:12.0000pt; mso-font-kerning:1.0000pt;"><o:p></o:p></span>
										</p></td>
								</tr>
								
								<tr style="height:29.1000pt;">
									<td width="691" valign="center" colspan="7"
										style="width:518.7000pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none; mso-border-left-alt:none;border-right:none;mso-border-right-alt:none; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:none; mso-border-bottom-alt:none;">
										<p class="MsoNormal" style="text-align:left;"><span
												style="mso-spacerun:'yes';font-family:宋体;color:rgb(0,0,0); letter-spacing:0.0000pt;text-transform:none;font-style:normal; font-size:10.5000pt;mso-font-kerning:1.0000pt;">注：本报告</span><span
												style="mso-spacerun:'yes';font-family:宋体;mso-ascii-font-family:Verdana; mso-hansi-font-family:Verdana;mso-bidi-font-family:Verdana;color:rgb(51,51,51); letter-spacing:0.0000pt;text-transform:none;font-style:normal; font-size:10.5000pt;mso-font-kerning:1.0000pt;background:rgb(255,255,255); mso-shading:rgb(255,255,255);">复印无效、涂改无效、检测报告仅对来样负责。</span><span
												style="font-family:宋体;color:rgb(0,0,0);letter-spacing:0.0000pt; text-transform:none;font-style:normal;font-size:10.5000pt; mso-font-kerning:1.0000pt;"><o:p></o:p></span>
										</p></td>
								</tr>
								</tbody>
							</table>
							
						</div>
				</div>
				<!--EndFragment-->

				<%--分开打印--%>
				<!--StartFragment0-->
				<div id="page2">
					<c:forEach items="${list}" var="samplingDetail" varStatus="index">
						<div class="Section0 _separately_print _${samplingDetail.id}" style="layout-grid:15.6000pt;">
							<table style="border-collapse:collapse;width:518.7000pt;mso-table-layout-alt:fixed; border:none;mso-border-left-alt:0.5000pt solid windowtext;mso-border-top-alt:0.5000pt solid windowtext; mso-border-right-alt:0.5000pt solid windowtext;mso-border-bottom-alt:0.5000pt solid windowtext;mso-border-insideh:0.5000pt solid windowtext; mso-border-insidev:0.5000pt solid windowtext;mso-padding-alt:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;">
								<tbody>
								<tr style="">
									<%-- <td width="160" valign="center" colspan="2" style="">
										<p class="MsoNormal" align="center" style="text-align:center;">
										 <span style="font-family:Calibri;mso-fareast-font-family:宋体;mso-bidi-font-family:'Times New Roman'; font-size:10.5000pt;mso-font-kerning:1.0000pt;">
											 <img width="150" height="50" src="${webRoot}/img/terminal/report_1.png" style="margin-top: 10px;" />
										 </span>
											<b><span style="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></b>
											<span style=""><o:p></o:p></span>
										</p>
									</td> --%>
									<td width="575" valign="center" colspan="3"
										style="width:311.3000pt;padding:0.0000pt;padding-left: 80pt;border-left:none; mso-border-left-alt:none;border-right:none;mso-border-right-alt:none; border-top:none;mso-border-top-alt:none;border-bottom:none; mso-border-bottom-alt:none;text-align: center">
										<p class="MsoNormal" align=""
										   style="mso-char-indent-count:1.0000;text-align:center;">
											<span style="mso-spacerun:'yes';font-family:宋体;color:rgb(0,0,0); letter-spacing:0.0000pt;text-transform:none;font-style:normal; font-size:19.0000pt;mso-font-kerning:1.0000pt;letter-spacing: -3px;">广东中检达元检测技术有限公司</span>
											<span style="font-family:宋体;color:rgb(0,0,0);letter-spacing:0.0000pt; text-transform:none;font-style:normal;font-size:14.0000pt; mso-font-kerning:1.0000pt;"><o:p></o:p></span>
										</p>
										<p style="font-family: 宋体; font-size:14.0000pt;font-weight: bold;">快 检 检 测 报 告</p>
									</td>
									<td width="33" valign="center"
										style="width:25.4500pt;padding:10.0000pt 8.4000pt 0.0000pt 5.4000pt ;border-left:none; mso-border-left-alt:none;border-right:none;mso-border-right-alt:none; border-top:none;mso-border-top-alt:none;border-bottom:none; mso-border-bottom-alt:none;">
										<p class="MsoNormal"
										   style="text-align:right; float: right;    width: 5px;font-size: 12px;">防伪码</p>
									</td>
									<td width="71" valign="center"
										style="width:53.5500pt;padding:0;border-left:none; mso-border-left-alt:none;border-right:none;mso-border-right-alt:none; border-top:none;mso-border-top-alt:none;border-bottom:none; mso-border-bottom-alt:none;">
										<p class="MsoNormal" style="text-align: left;height: 100px;width: 84px;position: relative;overflow: hidden;">
									 	<span style="font-family:宋体;color:rgb(0,0,0);letter-spacing:0.0000pt; text-transform:none;font-style:normal;font-size:10.5000pt; mso-font-kerning:1.0000pt;">
											<%--<img width="67" height="67" src="${webRoot}/img/terminal/report_2.png"/>--%>
											<img width="80" src="${webRoot}/pay/generatorQrCode?qrCode=${webRoot}/reportPrint/report?samplingId=${bean.id}" style="position: absolute;right: -16px;width: 116px;" />
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
											<span style="mso-spacerun:'yes';font-family:宋体;color:rgb(0,0,0); letter-spacing:0.0000pt;text-transform:none;font-style:normal; font-size:10.5000pt;mso-font-kerning:1.0000pt;background:rgb(255,255,255); mso-shading:rgb(255,255,255);">订单号：${bean.samplingNo}</span>
										</p>
										<p class="MsoNormal" align="justify"
										   style="float: right; margin-right:5.6500pt;text-align:justify;text-justify:inter-ideograph;">
											<span style="mso-spacerun:'yes';font-family:宋体;color:rgb(0,0,0); letter-spacing:0.0000pt;text-transform:none;font-style:normal; font-size:10.5000pt;mso-font-kerning:1.0000pt;background:rgb(255,255,255); mso-shading:rgb(255,255,255);">打印时间：<fmt:formatDate value="<%=new java.util.Date()%>" pattern="yyyy-MM-dd HH:mm:ss"/></span>
										</p></td>
								</tr>
								<tr style="height:29.7000pt;">
									<td width="139" valign="center"
										style="width:104.7500pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:1.0000pt solid windowtext; mso-border-left-alt:0.5000pt solid windowtext;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
										<p class="MsoNormal" align="center"
										   style="margin-right:5.6500pt;margin-left:5.6500pt;text-align:center;"><span
												style="mso-spacerun:'yes';font-family:宋体;mso-ascii-font-family:Calibri; mso-hansi-font-family:Calibri;mso-bidi-font-family:'Times New Roman';font-size:12.0000pt; mso-font-kerning:1.0000pt;">委托单位</span><span
												style="font-family:宋体;color:rgb(0,0,0);letter-spacing:0.0000pt; text-transform:none;font-style:normal;font-size:12.0000pt; mso-font-kerning:1.0000pt;">
         <o:p></o:p></span></p></td>
									<td width="551" valign="center" colspan="6"
										style="width:413.9500pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none; mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:1.0000pt solid windowtext;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
										<p class="MsoNormal"
										   style="margin-right:5.6500pt;margin-left:5.6500pt;text-align:left;"><span
												style="mso-spacerun:'yes';font-family:宋体;color:rgb(0,0,0); letter-spacing:0.0000pt;text-transform:none;font-style:normal; font-size:12.0000pt;mso-font-kerning:1.0000pt;">${bean.regName}</span><span
												style="font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri; mso-bidi-font-family:'Times New Roman';font-size:12.0000pt;mso-font-kerning:1.0000pt;">
         <o:p></o:p></span></p></td>
								</tr>
								<tr style="height:28.4500pt;">
									<td width="139" valign="center"
										style="width:104.7500pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:1.0000pt solid windowtext; mso-border-left-alt:0.5000pt solid windowtext;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
										<p class="MsoNormal" align="center"
										   style="margin-right:5.6500pt;margin-left:5.6500pt;text-align:center;"><span
												style="mso-spacerun:'yes';font-family:宋体;color:rgb(0,0,0); letter-spacing:0.0000pt;text-transform:none;font-style:normal; font-size:12.0000pt;mso-font-kerning:1.0000pt;">联系电话</span><span
												style="font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri; mso-bidi-font-family:'Times New Roman';font-size:12.0000pt;mso-font-kerning:1.0000pt;">
         <o:p></o:p></span></p></td>
									<td width="551" valign="center" colspan="6"
										style="width:413.9500pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none; mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
										<p class="MsoNormal"
										   style="margin-right:5.6500pt;margin-left:5.6500pt;text-align:left;"><span
												style="mso-spacerun:'yes';font-family:宋体;color:rgb(0,0,0); letter-spacing:0.0000pt;text-transform:none;font-style:normal; font-size:12.0000pt;mso-font-kerning:1.0000pt;">${bean.regLinkPhone}</span><span
												style="font-family:宋体;color:rgb(0,0,0);letter-spacing:0.0000pt; text-transform:none;font-style:normal;font-size:12.0000pt; mso-font-kerning:1.0000pt;">
         <o:p></o:p></span></p></td>
								</tr>
								
							</table>	
							
							
							
							
							
							
							<table style="border-collapse:collapse;width:518.7000pt;mso-table-layout-alt:fixed; border:none;mso-border-left-alt:0.5000pt solid windowtext;mso-border-top-alt:0.5000pt solid windowtext; mso-border-right-alt:0.5000pt solid windowtext;mso-border-bottom-alt:0.5000pt solid windowtext;mso-border-insideh:0.5000pt solid windowtext; mso-border-insidev:0.5000pt solid windowtext;mso-padding-alt:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;">	
								<tr style="height:30.3500pt;">
									<td width="691" valign="center" colspan="7"
										style="width:518.7000pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none; mso-border-left-alt:none;border-right:none;mso-border-right-alt:none; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid rgb(0,0,0); mso-border-bottom-alt:0.5000pt solid rgb(0,0,0);border-left: 1.0000pt solid windowtext;border-right: 1.0000pt solid windowtext;">
										<p class="MsoNormal" align="center" style="text-align:center;"><b><span
												style="mso-spacerun:'yes';font-family:宋体;mso-ascii-font-family:Calibri; mso-hansi-font-family:Calibri;mso-bidi-font-family:'Times New Roman';font-weight:bold; font-size:10.5000pt;mso-font-kerning:1.0000pt;">检测结果</span></b><span
												style="font-family:宋体;color:rgb(0,0,0);letter-spacing:0.0000pt; text-transform:none;font-style:normal;font-size:10.5000pt; mso-font-kerning:1.0000pt;">
         <o:p></o:p></span></p></td>
								</tr>
								<tr style="height:30.3500pt;">
									<td width="59" valign="center"
										style="padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:1.0000pt solid windowtext; mso-border-left-alt:0.5000pt solid windowtext;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
										<p class="MsoNormal" align="center" style="text-align:center;"><b><span
												style="mso-spacerun:'yes';font-family:宋体;mso-ascii-font-family:Calibri; mso-hansi-font-family:Calibri;mso-bidi-font-family:'Times New Roman';font-weight:bold; font-size:10.5000pt;mso-font-kerning:1.0000pt;">序号</span></b><b><span
												style="font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri; mso-bidi-font-family:'Times New Roman';font-weight:bold;font-size:10.5000pt; mso-font-kerning:1.0000pt;">
          <o:p></o:p></span></b></p></td>
									<td width="250" valign="center" colspan="2"
										style="padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none; mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:1.0000pt solid windowtext;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
										<p class="MsoNormal" align="center" style="text-align:center;"><b><span
												style="mso-spacerun:'yes';font-family:宋体;mso-ascii-font-family:Calibri; mso-hansi-font-family:Calibri;mso-bidi-font-family:'Times New Roman';font-weight:bold; font-size:10.5000pt;mso-font-kerning:1.0000pt;">样品名称</span></b><b><span
												style="font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri; mso-bidi-font-family:'Times New Roman';font-weight:bold;font-size:10.5000pt; mso-font-kerning:1.0000pt;">
          <o:p></o:p></span></b></p></td>
									<td width="255" valign="center"
										style="padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none; mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:1.0000pt solid windowtext;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
										<p class="MsoNormal" align="center" style="text-align:center;"><b><span
												style="mso-spacerun:'yes';font-family:宋体;mso-ascii-font-family:Calibri; mso-hansi-font-family:Calibri;mso-bidi-font-family:'Times New Roman';font-weight:bold; font-size:10.5000pt;mso-font-kerning:1.0000pt;">检测项目</span></b><b><span
												style="font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri; mso-bidi-font-family:'Times New Roman';font-weight:bold;font-size:10.5000pt; mso-font-kerning:1.0000pt;">
          <o:p></o:p></span></b></p></td>
									<td width="126" valign="center" colspan="3"
										style="padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none; mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:1.0000pt solid windowtext;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
										<p class="MsoNormal" align="center" style="text-align:center;"><b><span
												style="mso-spacerun:'yes';font-family:宋体;color:rgb(0,0,0); letter-spacing:0.0000pt;font-weight:bold;text-transform:none; font-style:normal;font-size:10.5000pt;mso-font-kerning:1.0000pt;">快检结果</span></b><b><span
												style="font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri; mso-bidi-font-family:'Times New Roman';font-weight:bold;font-size:10.5000pt; mso-font-kerning:1.0000pt;">
          <o:p></o:p></span></b></p></td>
								</tr>
								<tr style="height:28.8500pt;">
									<td width="59" valign="center"
										style="padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:1.0000pt solid windowtext; mso-border-left-alt:0.5000pt solid windowtext;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
										<p class="MsoNormal" align="center" style="text-align:center;"><span
												style="font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri; mso-bidi-font-family:'Times New Roman';font-size:10.5000pt;mso-font-kerning:1.0000pt;">1</span><span
												style="font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri; mso-bidi-font-family:'Times New Roman';font-size:10.5000pt;mso-font-kerning:1.0000pt;">
         <o:p></o:p></span></p></td>
									<td width="250" valign="center" colspan="2"
										style="padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none; mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
										<p class="MsoNormal" align="center" style="text-align:center;"><span
												style="mso-spacerun:'yes';font-family:宋体;mso-ascii-font-family:Calibri; mso-hansi-font-family:Calibri;mso-bidi-font-family:'Times New Roman';font-size:10.5000pt; mso-font-kerning:1.0000pt;">${samplingDetail.foodName}</span><span
												style="font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri; mso-bidi-font-family:'Times New Roman';font-size:10.5000pt;mso-font-kerning:1.0000pt;">
         <o:p></o:p></span></p></td>
									<td width="255" valign="center"
										style="padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none; mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
										<p class="MsoNormal" align="center" style="text-align:center;"><span
												style="mso-spacerun:'yes';font-family:宋体;mso-ascii-font-family:Calibri; mso-hansi-font-family:Calibri;mso-bidi-font-family:'Times New Roman';font-size:10.5000pt; mso-font-kerning:1.0000pt;">${samplingDetail.itemName}</span><span
												style="font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri; mso-bidi-font-family:'Times New Roman';font-size:10.5000pt;mso-font-kerning:1.0000pt;">
         <o:p></o:p></span></p></td>
									<td width="126" valign="center" colspan="3"
										style="padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none; mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
										<p class="MsoNormal" align="center" style="text-align:center;"><span
												style="mso-spacerun:'yes';font-family:宋体;color:rgb(0,0,0); letter-spacing:0.0000pt;text-transform:none;font-style:normal; font-size:10.5000pt;mso-font-kerning:1.0000pt;">${samplingDetail.conclusion}</span><span
												style="font-family:宋体;color:rgb(0,0,0);letter-spacing:0.0000pt; text-transform:none;font-style:normal;font-size:10.5000pt; mso-font-kerning:1.0000pt;">
         <o:p></o:p></span></p></td>
								</tr>
								<c:forEach var="i" begin="1" end="11">
									<tr style="height:28.8500pt;">
										<td width=59 valign="center"
											style="padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:1.0000pt solid windowtext; mso-border-left-alt:0.5000pt solid windowtext;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
											<p class="MsoNormal" align="center" style="text-align:center;"><span
													style="font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri; mso-bidi-font-family:'Times New Roman';font-size:10.5000pt;mso-font-kerning:1.0000pt;"></span><span
													style="font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri; mso-bidi-font-family:'Times New Roman';font-size:10.5000pt;mso-font-kerning:1.0000pt;">
         <o:p></o:p></span></p></td>
										<td width="250" valign="center" colspan="2"
											style="padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none; mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
											<p class="MsoNormal" align="center" style="text-align:center;"><span
													style="mso-spacerun:'yes';font-family:宋体;mso-ascii-font-family:Calibri; mso-hansi-font-family:Calibri;mso-bidi-font-family:'Times New Roman';font-size:10.5000pt; mso-font-kerning:1.0000pt;"></span><span
													style="font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri; mso-bidi-font-family:'Times New Roman';font-size:10.5000pt;mso-font-kerning:1.0000pt;">
         <o:p></o:p></span></p></td>
										<td width="255" valign="center"
											style="padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none; mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
											<p class="MsoNormal" align="center" style="text-align:center;"><span
													style="mso-spacerun:'yes';font-family:宋体;mso-ascii-font-family:Calibri; mso-hansi-font-family:Calibri;mso-bidi-font-family:'Times New Roman';font-size:10.5000pt; mso-font-kerning:1.0000pt;"></span><span
													style="font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri; mso-bidi-font-family:'Times New Roman';font-size:10.5000pt;mso-font-kerning:1.0000pt;">
         <o:p></o:p></span></p></td>
										<td width="126" valign="center" colspan="3"
											style="padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none; mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
											<p class="MsoNormal" align="center" style="text-align:center;"><span
													style="mso-spacerun:'yes';font-family:宋体;color:rgb(0,0,0); letter-spacing:0.0000pt;text-transform:none;font-style:normal; font-size:10.5000pt;mso-font-kerning:1.0000pt;"></span><span
													style="font-family:宋体;color:rgb(0,0,0);letter-spacing:0.0000pt; text-transform:none;font-style:normal;font-size:10.5000pt; mso-font-kerning:1.0000pt;">
         <o:p></o:p></span></p></td>
									</tr>
								</c:forEach>
							</table>
								
								
								
							<table style="border-collapse:collapse;width:518.7000pt;mso-table-layout-alt:fixed; border:none;mso-border-left-alt:0.5000pt solid windowtext;mso-border-top-alt:0.5000pt solid windowtext; mso-border-right-alt:0.5000pt solid windowtext;mso-border-bottom-alt:0.5000pt solid windowtext;mso-border-insideh:0.5000pt solid windowtext; mso-border-insidev:0.5000pt solid windowtext;mso-padding-alt:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;">
								<tr style="height:27.1000pt;">
									<td width="139" valign="center"
										style="width:104.7500pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:1.0000pt solid windowtext; mso-border-left-alt:0.5000pt solid windowtext;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
										<p class="MsoNormal" align="center"
										   style="margin-left:5.6500pt;margin-left:5.6500pt;mso-para-margin-right:0.0000gd; mso-para-margin-left:0.0000gd;text-align:center;">
											<span style="mso-spacerun:'yes';font-family:宋体;mso-ascii-font-family:Calibri; mso-hansi-font-family:Calibri;mso-bidi-font-family:'Times New Roman';font-size:12.0000pt; mso-font-kerning:1.0000pt;">送检单位</span><span
												style="font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri; mso-bidi-font-family:'Times New Roman';font-size:12.0000pt;mso-font-kerning:1.0000pt;"><o:p></o:p></span>
										</p></td>
									<td width="551" valign="center" colspan="6"
										style="width:413.9500pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none; mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
										<p class="MsoNormal" style="text-align:left;"><span
												style="mso-spacerun:'yes';font-family:宋体;color:rgb(0,0,0); letter-spacing:0.0000pt;text-transform:none;font-style:normal; font-size:12.0000pt;mso-font-kerning:1.0000pt;">${unit.companyName}</span><span
												style="font-family:宋体;color:rgb(0,0,0);letter-spacing:0.0000pt; text-transform:none;font-style:normal;font-size:12.0000pt; mso-font-kerning:1.0000pt;"><o:p></o:p></span>
										</p></td>
								</tr>
								<tr style="height:27.1000pt;">
									<td width="139" valign="center"
										style="width:104.7500pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:1.0000pt solid windowtext; mso-border-left-alt:0.5000pt solid windowtext;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
										<p class="MsoNormal" align="center"
										   style="margin-right:5.6500pt;margin-left:5.6500pt;mso-para-margin-right:0.0000gd; mso-para-margin-left:0.0000gd;text-align:center;">
											<span style="mso-spacerun:'yes';font-family:宋体;color:rgb(0,0,0); letter-spacing:0.0000pt;text-transform:none;font-style:normal; font-size:12.0000pt;mso-font-kerning:1.0000pt;">联系电话</span><span
												style="font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri; mso-bidi-font-family:'Times New Roman';font-size:12.0000pt;mso-font-kerning:1.0000pt;"><o:p></o:p></span>
										</p></td>
									<td width="551" valign="center" colspan="6"
										style="width:413.9500pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none; mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
										<p class="MsoNormal"
										   style="margin-right:5.6500pt;margin-left:5.6500pt;mso-para-margin-right:0.0000gd; mso-para-margin-left:0.0000gd;text-align:left;">
											<span style="mso-spacerun:'yes';font-family:宋体;color:rgb(0,0,0); letter-spacing:0.0000pt;text-transform:none;font-style:normal; font-size:12.0000pt;mso-font-kerning:1.0000pt;">${unit.linkPhone}</span><span
												style="font-family:宋体;color:rgb(0,0,0);letter-spacing:0.0000pt; text-transform:none;font-style:normal;font-size:12.0000pt; mso-font-kerning:1.0000pt;"><o:p></o:p></span>
										</p></td>
								</tr>
								<tr style="height:27.1000pt;">
									<td width="139" valign="center"
										style="width:104.7500pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:1.0000pt solid windowtext; mso-border-left-alt:0.5000pt solid windowtext;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
										<p class="MsoNormal" align="center"
										   style="margin-right:5.6500pt;margin-left:5.6500pt;mso-para-margin-right:0.0000gd; mso-para-margin-left:0.0000gd;text-align:center;">
											<span style="mso-spacerun:'yes';font-family:宋体;mso-ascii-font-family:Calibri; mso-hansi-font-family:Calibri;mso-bidi-font-family:'Times New Roman';font-size:12.0000pt; mso-font-kerning:1.0000pt;">单位地址</span><span
												style="font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri; mso-bidi-font-family:'Times New Roman';font-size:12.0000pt;mso-font-kerning:1.0000pt;"><o:p></o:p></span>
										</p></td>
									<td width="551" valign="center" colspan="6"
										style="width:413.9500pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none; mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
										<p class="MsoNormal" style="text-align:left;"><span
												style="mso-spacerun:'yes';font-family:宋体;color:rgb(0,0,0); letter-spacing:0.0000pt;text-transform:none;font-style:normal; font-size:12.0000pt;mso-font-kerning:1.0000pt;">${unit.companyAddress}</span><span
												style="font-family:宋体;color:rgb(0,0,0);letter-spacing:0.0000pt; text-transform:none;font-style:normal;font-size:12.0000pt; mso-font-kerning:1.0000pt;"><o:p></o:p></span>
										</p></td>
								</tr>
								<tr style="height:27.1000pt;">
									<td width="139" valign="center"
										style="width:104.7500pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:1.0000pt solid windowtext; mso-border-left-alt:0.5000pt solid windowtext;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
										<p class="MsoNormal" align="center"
										   style="margin-right:5.6500pt;margin-left:5.6500pt;mso-para-margin-right:0.0000gd; mso-para-margin-left:0.0000gd;text-align:center;">
											<span style="mso-spacerun:'yes';font-family:宋体;mso-ascii-font-family:Calibri; mso-hansi-font-family:Calibri;mso-bidi-font-family:'Times New Roman';font-size:12.0000pt; mso-font-kerning:1.0000pt;">检测机构</span><span
												style="font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri; mso-bidi-font-family:'Times New Roman';font-size:12.0000pt;mso-font-kerning:1.0000pt;"><o:p></o:p></span>
										</p></td>
									<td width="551" valign="center" colspan="6"
										style="width:413.9500pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none; mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
										<p class="MsoNormal" style="text-align:left;"><span
												style="font-family:Calibri;mso-fareast-font-family:宋体;mso-bidi-font-family:'Times New Roman'; font-size:12.0000pt;mso-font-kerning:1.0000pt;"><span
												style="position:absolute;z-index:1;margin-left:375.0667px; margin-top:-55.4667px;width:151.0000px;height:151.0000px;"><img
												width="151" height="151" src="${webRoot}/img/terminal/report.png"/></span></span><span
												style="mso-spacerun:'yes';font-family:宋体;color:rgb(0,0,0); letter-spacing:0.0000pt;text-transform:none;font-style:normal; font-size:12.0000pt;mso-font-kerning:1.0000pt;">广东中检达元检测技术有限公司</span><span
												style="font-family:宋体;color:rgb(0,0,0);letter-spacing:0.0000pt; text-transform:none;font-style:normal;font-size:12.0000pt; mso-font-kerning:1.0000pt;"><o:p></o:p></span>
										</p></td>
								</tr>
								<tr style="height:29.8500pt;">
									<td width="139" valign="center"
										style="width:104.7500pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:1.0000pt solid windowtext; mso-border-left-alt:0.5000pt solid windowtext;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
										<p class="MsoNormal" align="center" style="text-align:center;"><span
												style="mso-spacerun:'yes';font-family:宋体;mso-ascii-font-family:Calibri; mso-hansi-font-family:Calibri;mso-bidi-font-family:'Times New Roman';font-size:12.0000pt; mso-font-kerning:1.0000pt;">检测人员</span><span
												style="font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri; mso-bidi-font-family:'Times New Roman';font-size:12.0000pt;mso-font-kerning:1.0000pt;"><o:p></o:p></span>
										</p></td>
									<td width="551" valign="center" colspan="6"
										style="width:413.9500pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none; mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
										<p class="MsoNormal" style="text-align:left;"><span
												style="mso-spacerun:'yes';font-family:宋体;mso-ascii-font-family:Calibri; mso-hansi-font-family:Calibri;mso-bidi-font-family:'Times New Roman';font-size:12.0000pt; mso-font-kerning:1.0000pt;">${samplingDetail.checkUsername}</span><span
												style="font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri; mso-bidi-font-family:'Times New Roman';font-size:12.0000pt;mso-font-kerning:1.0000pt;"><o:p></o:p></span>
										</p></td>
								</tr>
								<tr style="height:27.1000pt;">
									<td width="139" valign="center"
										style="width:104.7500pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:1.0000pt solid windowtext; mso-border-left-alt:0.5000pt solid windowtext;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
										<p class="MsoNormal" align="center"
										   style="margin-right:5.6500pt;margin-left:5.6500pt;mso-para-margin-right:0.0000gd; mso-para-margin-left:0.0000gd;text-align:center;">
											<span style="mso-spacerun:'yes';font-family:宋体;mso-ascii-font-family:Calibri; mso-hansi-font-family:Calibri;mso-bidi-font-family:'Times New Roman';font-size:12.0000pt; mso-font-kerning:1.0000pt;">检测时间</span><span
												style="font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri; mso-bidi-font-family:'Times New Roman';font-size:12.0000pt;mso-font-kerning:1.0000pt;"><o:p></o:p></span>
										</p></td>
									<td width="551" valign="center" colspan="6"
										style="width:413.9500pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none; mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
										<p class="MsoNormal" style="text-align:left;"><span
												style="mso-spacerun:'yes';font-family:宋体;color:rgb(0,0,0); letter-spacing:0.0000pt;text-transform:none;font-style:normal; font-size:12.0000pt;mso-font-kerning:1.0000pt;"><fmt:formatDate value="${samplingDetail.checkDate}" pattern="yyyy-MM-dd"/></span><span
												style="font-family:宋体;color:rgb(0,0,0);letter-spacing:0.0000pt; text-transform:none;font-style:normal;font-size:12.0000pt; mso-font-kerning:1.0000pt;"><o:p></o:p></span>
										</p></td>
								</tr>
								
								<tr style="height:29.1000pt;">
									<td width="691" valign="center" colspan="7"
										style="width:518.7000pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none; mso-border-left-alt:none;border-right:none;mso-border-right-alt:none; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:none; mso-border-bottom-alt:none;">
										<p class="MsoNormal" style="text-align:left;"><span
												style="mso-spacerun:'yes';font-family:宋体;color:rgb(0,0,0); letter-spacing:0.0000pt;text-transform:none;font-style:normal; font-size:10.5000pt;mso-font-kerning:1.0000pt;">注：本报告</span><span
												style="mso-spacerun:'yes';font-family:宋体;mso-ascii-font-family:Verdana; mso-hansi-font-family:Verdana;mso-bidi-font-family:Verdana;color:rgb(51,51,51); letter-spacing:0.0000pt;text-transform:none;font-style:normal; font-size:10.5000pt;mso-font-kerning:1.0000pt;background:rgb(255,255,255); mso-shading:rgb(255,255,255);">复印无效、涂改无效、检测报告仅对来样负责。</span><span
												style="font-family:宋体;color:rgb(0,0,0);letter-spacing:0.0000pt; text-transform:none;font-style:normal;font-size:10.5000pt; mso-font-kerning:1.0000pt;"><o:p></o:p></span>
										</p></td>
								</tr>
								</tbody>
							</table>
							
						</div>
					</c:forEach>
				</div>
				<!--EndFragment0-->
			</div>
		</div>
	 </div>

	 <%@include file="/WEB-INF/view/terminal/tips.jsp"%>
	 <%@include file="/WEB-INF/view/common/modalBox.jsp"%>
	 <%--<script type="text/javascript" src="${webRoot}/plug-in/jcp/jcpfree.js"></script>--%>
	 <script>

		 //打印
		 function preview(){

			 if (!!window.ActiveXObject || "ActiveXObject" in window) {
				 remove_ie_header_and_footer();
			 }

			$('html,body').css('width','auto');
			$('html,body').css('height','auto');
			
			$('#myContent1').hide();
			
			 var samplingDetailIds = "";
			 var sprnstr = "";
			 var eprnstr = "";
			 //0_合并打印
			 if('${printType}' == 0){
				 sprnstr="<!--StartFragment-->";
				 eprnstr="<!--EndFragment-->";
				 $('#page2').hide();

			 //1_分开打印
			 }else if('${printType}' == 1){
				 $('#page1').hide();

				 if($("input[name='rowCheckBox']:checked").length == 0){
					 tips("请选择检测结果");
					 return;
				 }else{
					 $("._separately_print").hide();
					 $("input[name='rowCheckBox']:checked").each(function () {
						 $("._"+$(this).val()).show();
						 samplingDetailIds = samplingDetailIds + $(this).val() + ",";
					 });
					 samplingDetailIds = samplingDetailIds.substring(0, samplingDetailIds.length-1);
				 }
				 
				 sprnstr="<!--StartFragment0-->";
				 eprnstr="<!--EndFragment0-->";

			 }else{
				 return;
			 }
			 
			 var bdhtml=window.document.body.innerHTML;
			 var prnhtml=bdhtml.substring(bdhtml.indexOf(sprnstr)+21);
			 prnhtml=prnhtml.substring(0,prnhtml.indexOf(eprnstr));
			 window.document.body.innerHTML=prnhtml;
			 window.print();
			 location.reload();
/* 
			 var bdhtml=window.document.body.innerHTML;
			 var prnhtml=bdhtml.substring(bdhtml.indexOf(sprnstr)+21);
			 prnhtml=prnhtml.substring(0,prnhtml.indexOf(eprnstr));
			 window.document.body.innerHTML=prnhtml;
			 window.print();
			 window.document.body.innerHTML=bdhtml;
 */
			/*
			 var jcp = getJCP();
			 var myDoc = {
				 settings : {
					 pageFrom : 0,
					 pageTo : 0
				 },
				 documents: document,
				 copyrights: '版权声明'
			 };

			 //0_合并打印
			 if('${printType}' == 0){
				 myDoc.settings.pageFrom = 1;
				 myDoc.settings.pageTo = 1;

			 //1_分开打印
			 }else if('${printType}' == 1){
				 myDoc.settings.pageFrom = 2;
				 myDoc.settings.pageTo = 2;

			 }else{
				 return;
			 }
			 // jcp.printPreview(myDoc, false);
			 // jcp.print(myDoc, false);
			 */

			 //打印成功
			 updatePrintRecord(samplingDetailIds);
		 }

		 //付款
		 function printReport(){
			 var samplingDetailIds = "";
			 //1_分开打印
			 if('${printType}' == 1) {
				 if ($("input[name='rowCheckBox']:checked").length == 0) {
					 tips("请选择检测结果");
					 return;
				 } else {
					 $("input[name='rowCheckBox']:checked").each(function () {
						 samplingDetailIds = samplingDetailIds + $(this).val() + ",";
					 });
					 samplingDetailIds = samplingDetailIds.substring(0, samplingDetailIds.length - 1);
				 }
			 }

			 $.ajax({
				 type: "POST",
				 url: "${webRoot}/reportPrint/isCharge",
				 data: {"id":"${bean.id}","samplingDetailIds":samplingDetailIds},
				 dataType: "json",
				 success: function(data){
					 if(data && data.success){
					 	if (data.obj > 0){
					 		//打开付款页面
							showMbIframe("${webRoot}/reportPrint/payForPrinting?id=${bean.id}&samplingDetailIds="+samplingDetailIds);
							$("#myContent1").hide();
							<%--window.location.href = "${webRoot}/reportPrint/payForPrinting?id=${bean.id}&samplingDetailIds="+samplingDetailIds;--%>
						} else {
							preview();
						}
					 }else{
						 $("#waringMsg>span").html(data.msg);
						 $("#confirm-warnning").modal('toggle');
					 }
				 }
			 });

			 // preview();
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
		 function updatePrintRecord(samplingDetailIds){
			 window.location.href = "${webRoot}/reportPrint/printSuccess?id=${bean.id}&printType=${printType}&samplingDetailIds="+samplingDetailIds;
			 /*
			 $.ajax({
				 type: "POST",
				 url: "${webRoot}/reportPrint/updatePrintRecord",
				 data: {"id":"${bean.id}","printType":"${printType}","samplingDetailIds":samplingDetailIds},
				 dataType: "json",
				 success: function(data){
					 if(data && data.success){
						 window.location = "${webRoot}/reportPrint/printSuccess";
					 }else{
						 $("#waringMsg>span").html(data.msg);
						 $("#confirm-warnning").modal('toggle');
					 }
				 }
			 });
			 */
		 }
		 $(function(){
// 			preview();
			 var afterPrint = function() {
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

			 /* center modal */
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


