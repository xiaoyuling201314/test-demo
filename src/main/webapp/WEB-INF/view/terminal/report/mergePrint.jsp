<%@page import="java.util.Random"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
 <div id="page1">
 <c:if test="${tab1==1}">
 	<c:forEach items="${receiverNumbers}" var="receiveBean">
 	<c:if test="${receiveBean.printCount!=receiveBean.receiveCount}">
 		<c:set var="serialNumber" value="0"/>
	<c:forEach var="item" begin="1" end="${receiveBean.pageNo}" varStatus="pageNumber">
	<c:set var="pageSize" value="0"/>
	<div class="Section0 _separately_print _${receiveBean.reportNumber}_${pageNumber.index}" style="layout-grid:15.6000pt;">
		<table style="border-collapse:collapse;width:518.7000pt;mso-table-layout-alt:fixed; border:none;mso-border-left-alt:0.5000pt solid windowtext;mso-border-top-alt:0.5000pt solid windowtext; mso-border-right-alt:0.5000pt solid windowtext;mso-border-bottom-alt:0.5000pt solid windowtext;mso-border-insideh:0.5000pt solid windowtext; mso-border-insidev:0.5000pt solid windowtext;mso-padding-alt:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;">
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
                           <img width="100" height="100" src="${webRoot}/pay/generatorQrCode?qrCode=${samplingQrPath}&reportNumber=${receiveBean.reportNumber}&scan=1" style="float:right; margin-right:-10px;position: absolute;top: -6px;left: 30px;" />
                  </td>
			</tr>
			</tbody>
		</table>
		<table class="MsoTableGrid" border="1" cellspacing="0"
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
					<p class="MsoNormal MsoNormal2" style="text-align:left;">
						<span style="mso-spacerun:'yes';font-family:宋体;color:rgb(0,0,0); letter-spacing:0.0000pt;text-transform:none;font-style:normal; font-size:14pt;mso-font-kerning:1.0000pt;">${bean.regName}</span>
						<span style="font-family:宋体;color:rgb(0,0,0);letter-spacing:0.0000pt; text-transform:none;font-style:normal;font-size:14pt; mso-font-kerning:1.0000pt;"><o:p></o:p></span>
					</p>
				</td>
			</tr>
			<!-- <tr style="height: 36px;" >
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
							style="mso-spacerun:'yes';font-family:宋体;color:rgb(0,0,0); letter-spacing:0.0000pt;text-transform:none;font-style:normal; font-size:14pt;mso-font-kerning:1.0000pt;">${bean.regLinkPhone}</span><span
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
					<p class="MsoNormal MsoNormal2" style="text-align:left;">
						<span style="mso-spacerun:'yes';font-family:宋体;color:rgb(0,0,0); letter-spacing:0.0000pt;text-transform:none;font-style:normal; font-size:14pt;mso-font-kerning:1.0000pt;">${bean.takeSamplingAddress}</span>
						<span style="font-family:宋体;color:rgb(0,0,0);letter-spacing:0.0000pt; text-transform:none;font-style:normal;font-size:14pt; mso-font-kerning:1.0000pt;"><o:p></o:p></span>
					</p>
				</td>
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
						</p>
					</td>
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
						   style="margin-right:5.6500pt;mso-para-margin-right:0.0000gd; mso-para-margin-left:0.0000gd;text-align:left;">
							<span style="mso-spacerun:'yes';font-family:宋体;color:rgb(0,0,0); letter-spacing:0.0000pt;text-transform:none;font-style:normal; font-size:14pt;mso-font-kerning:1.0000pt;">${bean.param3}</span><span
								style="font-family:宋体;color:rgb(0,0,0);letter-spacing:0.0000pt; text-transform:none;font-style:normal;font-size:14pt; mso-font-kerning:1.0000pt;"><o:p></o:p></span>
						</p></td>
				</tr>
			 <%-- 		<tr style="height: 36px;" >
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
								style="mso-spacerun:'yes';font-family:宋体;color:rgb(0,0,0); letter-spacing:0.0000pt;text-transform:none;font-style:normal; font-size:14pt;mso-font-kerning:1.0000pt;">${unit.companyAddress}</span><span
								style="font-family:宋体;color:rgb(0,0,0);letter-spacing:0.0000pt; text-transform:none;font-style:normal;font-size:14pt; mso-font-kerning:1.0000pt;"><o:p></o:p></span>
						</p></td>
				</tr> --%>
			 <%-- <tr style="height: 36px;" >
					<td width="139" valign="center"
						style="text-align: center;width:104.7500pt;border-left:1.0000pt solid windowtext; mso-border-left-alt:0.5000pt solid windowtext;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
						<p class="MsoNormal" align="center"
						   style="margin-right:5.6500pt;margin-left:5.6500pt;mso-para-margin-right:0.0000gd; mso-para-margin-left:0.0000gd;text-align:center;">
							<span style="mso-spacerun:'yes';font-family:宋体;mso-ascii-font-family:Calibri; mso-hansi-font-family:Calibri;mso-bidi-font-family:'Times New Roman';font-size:14pt; mso-font-kerning:1.0000pt;">送样时间</span><span
								style="font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri; mso-bidi-font-family:'Times New Roman';font-size:14pt;mso-font-kerning:1.0000pt;"><o:p></o:p></span>
						</p></td>
					<td width="551" valign="center" colspan="6"
						style="width:413.9500pt;border-left:none; mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
						<p class="MsoNormal" style="text-align:left;"><span
								style="mso-spacerun:'yes';font-family:宋体;color:rgb(0,0,0); letter-spacing:0.0000pt;text-transform:none;font-style:normal; font-size:14pt;mso-font-kerning:1.0000pt;">${receiveBean.sampleTubeTime}</span><span
								style="font-family:宋体;color:rgb(0,0,0);letter-spacing:0.0000pt; text-transform:none;font-style:normal;font-size:14pt; mso-font-kerning:1.0000pt;"><o:p></o:p></span>
						</p></td>
				</tr> --%>
		</table>	
		<!-- 正文开始 -->
			<table style="border-collapse:collapse;width:520.7000pt;margin-left:-1px;mso-table-layout-alt:fixed; border:none;mso-border-left-alt:0.5000pt solid windowtext;mso-border-top-alt:0.5000pt solid windowtext; mso-border-right-alt:0.5000pt solid windowtext;mso-border-bottom-alt:0.5000pt solid windowtext;mso-border-insideh:0.5000pt solid windowtext; mso-border-insidev:0.5000pt solid windowtext;mso-padding-alt:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;text-align: center;">	
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
									<!--样品名称列-->
									<td  valign="center" colspan="2" style="border-left:none; mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:1.0000pt solid windowtext;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
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
											<td  valign="center" style="width:170px;border-left:none; mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:1.0000pt solid windowtext;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
												<p class="MsoNormal" align="center" style="text-align:center;"><b><span
														style="mso-spacerun:'yes';font-family:宋体;mso-ascii-font-family:Calibri; mso-hansi-font-family:Calibri;mso-bidi-font-family:'Times New Roman';font-weight:bold; font-size:14pt;mso-font-kerning:1.0000pt;">检测项目</span></b><b><span
														style="font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri; mso-bidi-font-family:'Times New Roman';font-weight:bold;font-size:14pt; mso-font-kerning:1.0000pt;">
         <o:p></o:p></span></b></p></td>
										</c:when>
										<c:otherwise>
											<td  valign="center" style="width:200px;border-left:none; mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:1.0000pt solid windowtext;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
												<p class="MsoNormal" align="center" style="text-align:center;"><b><span
														style="mso-spacerun:'yes';font-family:宋体;mso-ascii-font-family:Calibri; mso-hansi-font-family:Calibri;mso-bidi-font-family:'Times New Roman';font-weight:bold; font-size:14pt;mso-font-kerning:1.0000pt;">检测项目</span></b><b><span
														style="font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri; mso-bidi-font-family:'Times New Roman';font-weight:bold;font-size:14pt; mso-font-kerning:1.0000pt;">
         <o:p></o:p></span></b></p></td>
										</c:otherwise>
									</c:choose>
									<!--检测标准列-->
									<c:choose>
									<c:when test="${showPurchaseNumber==1 || showPurchaseNumber==2}">
										<td valign="center" style="width:135px;border-left:none; mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:1.0000pt solid windowtext;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
											<p class="MsoNormal" align="center" style="text-align:center;"><b><span
													style="mso-spacerun:'yes';font-family:宋体;mso-ascii-font-family:Calibri; mso-hansi-font-family:Calibri;mso-bidi-font-family:'Times New Roman';font-weight:bold; font-size:14pt;mso-font-kerning:1.0000pt;">检测标准</span></b><b><span
													style="font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri; mso-bidi-font-family:'Times New Roman';font-weight:bold;font-size:14pt; mso-font-kerning:1.0000pt;">
          <o:p></o:p></span></b></p></td>
									</c:when>
										<c:otherwise>
											<td valign="center" style="width:200px;border-left:none; mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:1.0000pt solid windowtext;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
												<p class="MsoNormal" align="center" style="text-align:center;"><b><span
														style="mso-spacerun:'yes';font-family:宋体;mso-ascii-font-family:Calibri; mso-hansi-font-family:Calibri;mso-bidi-font-family:'Times New Roman';font-weight:bold; font-size:14pt;mso-font-kerning:1.0000pt;">检测标准</span></b><b><span
														style="font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri; mso-bidi-font-family:'Times New Roman';font-weight:bold;font-size:14pt; mso-font-kerning:1.0000pt;">
          <o:p></o:p></span></b></p></td>
										</c:otherwise>
										</c:choose>
									<!--检测结果列-->
									<td  valign="center" colspan="3" style="width:80px;border-left:none; mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:1.0000pt solid windowtext;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
										<p class="MsoNormal" align="center" style="text-align:center;"><b><span
												style="mso-spacerun:'yes';font-family:宋体;color:rgb(0,0,0); letter-spacing:0.0000pt;font-weight:bold;text-transform:none; font-style:normal;font-size:14pt;mso-font-kerning:1.0000pt;">快检结果</span></b><b><span
												style="font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri; mso-bidi-font-family:'Times New Roman';font-weight:bold;font-size:14pt; mso-font-kerning:1.0000pt;">
          <o:p></o:p></span></b></p></td>
								</tr>
								<c:forEach items="${list}" var="samplingDetail" varStatus="status" begin="${(pageNumber.index-1)*10 }" end="${pageNumber.index*10-1}">
									<c:set var="sampleTubeFirst">
										<fmt:formatDate value="${samplingDetail.sampleTubeTime }" pattern="yyyy-MM-dd HH:mm:ss"/>
									</c:set>
									<c:if test="${samplingDetail.conclusion!='' && receiveBean.sampleTubeTime==sampleTubeFirst &&  samplingDetail.reportNumber==null}">
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
										<td  valign="center"
											style="border-left:1.0000pt solid windowtext; mso-border-left-alt:0.5000pt solid windowtext;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
											<p class="MsoNormal" align="center" style="text-align:center;"><span
													style="font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri; mso-bidi-font-family:'Times New Roman';font-size:14pt;mso-font-kerning:1.0000pt;">${serialNumber}</span><span
													style="font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri; mso-bidi-font-family:'Times New Roman';font-size:14pt;mso-font-kerning:1.0000pt;">
	         <o:p></o:p></span></p></td>
										<td width="" valign="center" colspan="2"
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
												<td  valign="center" style="width:150px;border-left:none; mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
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

										<td width="" valign="center" colspan="3"
											style="border-left:none; mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
											<p class="MsoNormal" align="center" style="text-align:center;"><span
													style="mso-spacerun:'yes';font-family:宋体;color:rgb(0,0,0); letter-spacing:0.0000pt;text-transform:none;font-style:normal; font-size:14pt;mso-font-kerning:1.0000pt;">${samplingDetail.conclusion}</span><span
													style="font-family:宋体;color:rgb(0,0,0);letter-spacing:0.0000pt; text-transform:none;font-style:normal;font-size:14pt; mso-font-kerning:1.0000pt;">
	         <o:p></o:p></span></p></td>
									</tr>
								</c:if>
								</c:forEach>
								<c:forEach var="i" begin="${pageSize+1}" end="10">
									<tr style="height:43px;">
										<td  valign="center"
											style="width:50px;border-left:1.0000pt solid windowtext; mso-border-left-alt:0.5000pt solid windowtext;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
											<p class="MsoNormal" align="center" style="text-align:center;"><span
													style="font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri; mso-bidi-font-family:'Times New Roman';font-size:14pt;mso-font-kerning:1.0000pt;"></span><span
													style="font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri; mso-bidi-font-family:'Times New Roman';font-size:14pt;mso-font-kerning:1.0000pt;">
         <o:p></o:p></span></p></td>
										<td  valign="center" colspan="2"
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
										<td  valign="center"
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
										<td  valign="center" colspan="3"
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
										<p class="MsoNormal MsoNormal2" style="text-align:left;"><span
												style="font-family:Calibri;mso-fareast-font-family:宋体;mso-bidi-font-family:'Times New Roman'; font-size:14pt;mso-font-kerning:1.0000pt;"><span
												style="position:absolute;z-index:1;margin-left: 325.0667px;margin-top: -47.4667px;"><img
												width="195" height="195" class="signatureImage" src="data:image/png;base64,${signatureImage}"/></span></span><span
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
										<p class="MsoNormal MsoNormal2" style="text-align:left;"><span
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
										style="text-align: center;width:140.7500pt;padding-left: 46px;  mso-border-left-alt:0.5000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:none;mso-border-top-alt:0.5000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;border: none;">
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
											&nbsp;&nbsp;&nbsp;&nbsp;2.检测结果手写无效
<!-- 											&nbsp;&nbsp;&nbsp;&nbsp;3.本报告复印无效<br/> -->
											</span>
										</p>
										
									</td>
								</tr>
							 	<tr <%--style="height:29.1000pt;"--%>>
									<td width="691" valign="center" colspan="7"
										style="padding-left: 10px;width:518.7000pt;border-left:none; mso-border-left-alt:none;border-right:none;mso-border-right-alt:none; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:none; mso-border-bottom-alt:none;">
										<p class="MsoNormal" style="text-align:left;margin-top: -10px;">
										<span style="font-family: 宋体; font-size:14pt; display:inline-block;margin-left: 288px;">
										第${pageNumber.index}页 -  共${receiveBean.pageNo}页
										</span>
									</p>
									</td>
								</tr> 
								</tbody>
							</table>
	</div>
	</c:forEach>
 	</c:if>
 	</c:forEach>
 </c:if>
</div>