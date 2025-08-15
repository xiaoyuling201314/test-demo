<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div id="page2">
<c:forEach items="${reportNumbers}" var="report">
<c:set var="serialNumber" value="0"/>
	<div class="Section0 _separately_print _${report.reportNumber}" style="layout-grid:15.6000pt;">
	<table style="border-collapse:collapse;width:518.7000pt;mso-table-layout-alt:fixed; border:none;mso-border-left-alt:0.5000pt solid windowtext;mso-border-top-alt:0.5000pt solid windowtext; mso-border-right-alt:0.5000pt solid windowtext;mso-border-bottom-alt:0.5000pt solid windowtext;mso-border-insideh:0.5000pt solid windowtext; mso-border-insidev:0.5000pt solid windowtext;mso-padding-alt:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;">
			<tbody>
			<tr style="height: 36px;">
                  <td width="564" valign="center" colspan="3"
                      style="width:311.3000pt;padding:0.0000pt;padding-left: 80pt;border-left:none; mso-border-left-alt:none;border-right:none;mso-border-right-alt:none; border-top:none;mso-border-top-alt:none;border-bottom:none; mso-border-bottom-alt:none;text-align: center">
                      
                          <span style="mso-spacerun:'yes';font-family:宋体;color:rgb(0,0,0); letter-spacing:0.0000pt;text-transform:none;font-style:normal; font-size:19.0000pt;mso-font-kerning:1.0000pt;letter-spacing: -3px;font-weight: bold; margin-bottom: 10px;">广东中检达元检测技术有限公司</span>
                          <span style="font-family:宋体;color:rgb(0,0,0);letter-spacing:0.0000pt; text-transform:none;font-style:normal;font-size:14.0000pt; mso-font-kerning:1.0000pt;"><o:p></o:p></span>
                      <br>
                      <span style="font-family: 宋体; font-size:14.0000pt;font-weight: bold;">快 检 检 测 报 告</span >
                  </td>

                  <td width="116" valign="center"
                      style="position: relative;padding:0;border-left:none; mso-border-left-alt:none;border-right:none;mso-border-right-alt:none; border-top:none;mso-border-top-alt:none;border-bottom:none; mso-border-bottom-alt:none;">
                     
                          <%--< img width="67" height="67" src="${webRoot}/img/terminal/report_2.png"/>--%>
                          <span style="float:left;padding: 0px 0;position: absolute;left: 32px;z-index: 10; font-size:14px;top: 0px;">防<br>伪<br>码</span>
                          <img width="100" height="100" src="${webRoot}/pay/generatorQrCode?qrCode=${samplingQrPath}&reportNumber=${report.reportNumber}&scan=1" style="float:right; margin-right:-10px;position: absolute;top: -20px;left: 30px;" />
                      
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
						<span style="mso-spacerun:'yes';font-family:宋体;color:rgb(0,0,0); letter-spacing:0.0000pt;text-transform:none;font-style:normal; font-size:10.5000pt;mso-font-kerning:1.0000pt;background:rgb(255,255,255); mso-shading:rgb(255,255,255);">订单编号：${bean.samplingNo}</span>
					</p>
					<p class="MsoNormal" align="justify"
					   style="float: right; margin-right:5.6500pt;text-align:justify;text-justify:inter-ideograph;">
						<span style="mso-spacerun:'yes';font-family:宋体;color:rgb(0,0,0); letter-spacing:0.0000pt;text-transform:none;font-style:normal; font-size:10.5000pt;mso-font-kerning:1.0000pt;background:rgb(255,255,255); mso-shading:rgb(255,255,255);">打印时间：<fmt:formatDate value="<%=new java.util.Date()%>" pattern="yyyy-MM-dd HH:mm:ss"/></span>
					</p></td>
			</tr>
			<tr style="height: 36px;" >
				<td width="139" valign="center"
					style="text-align: center;width:104.7500pt;border-left:1.0000pt solid windowtext; mso-border-left-alt:0.5000pt solid windowtext;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
					
					<p class="MsoNormal" align="center"
					   style="display:inline; margin-right:5.6500pt;margin-left:5.6500pt;text-align:center;"><span
							style="mso-spacerun:'yes';font-family:宋体;color:rgb(0,0,0); letter-spacing:0.0000pt;text-transform:none;font-style:normal; font-size:12.0000pt;mso-font-kerning:1.0000pt;">委托单位</span><span
							style="font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri; mso-bidi-font-family:'Times New Roman';font-size:12.0000pt;mso-font-kerning:1.0000pt;">
    <o:p></o:p></span></p>
					</td>
				<td width="551" valign="center" colspan="6"
					style="width:413.9500pt;border-left:none; mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:1.0000pt solid windowtext;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
					<p class="MsoNormal MsoNormal2" align="center"
					   style="display:inline; margin-right:5.6500pt;text-align:center;"><span
							style="mso-spacerun:'yes';font-family:宋体;color:rgb(0,0,0); letter-spacing:0.0000pt;text-transform:none;font-style:normal; font-size:12.0000pt;mso-font-kerning:1.0000pt;">${bean.regName}</span><span
							style="font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri; mso-bidi-font-family:'Times New Roman';font-size:12.0000pt;mso-font-kerning:1.0000pt;">
    <o:p></o:p></span></p></td>
			</tr>
			<tr style="height: 36px;" >
				<td width="139" valign="center"
					style="text-align: center;width:104.7500pt;border-left:1.0000pt solid windowtext; mso-border-left-alt:0.5000pt solid windowtext;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
					<p class="MsoNormal" align="center"
					   style="display:inline; margin-right:5.6500pt;margin-left:5.6500pt;text-align:center;"><span
							style="mso-spacerun:'yes';font-family:宋体;color:rgb(0,0,0); letter-spacing:0.0000pt;text-transform:none;font-style:normal; font-size:12.0000pt;mso-font-kerning:1.0000pt;">联系电话</span><span
							style="font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri; mso-bidi-font-family:'Times New Roman';font-size:12.0000pt;mso-font-kerning:1.0000pt;">
    <o:p></o:p></span></p></td>
				<td width="551" valign="center" colspan="6"
					style="width:413.9500pt;border-left:none; mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
					<p class="MsoNormal MsoNormal2"
					   style="display:inline; text-align:left;"><span
							style="mso-spacerun:'yes';font-family:宋体;color:rgb(0,0,0); letter-spacing:0.0000pt;text-transform:none;font-style:normal; font-size:12.0000pt;mso-font-kerning:1.0000pt;">${bean.regLinkPhone}</span><span
							style="font-family:宋体;color:rgb(0,0,0);letter-spacing:0.0000pt; text-transform:none;font-style:normal;font-size:12.0000pt; mso-font-kerning:1.0000pt;">
    <o:p></o:p></span></p></td>
			</tr>
			<tr style="height: 36px;" >
				<td width="139" valign="center"
					style="text-align: center;width:104.7500pt;border-left:1.0000pt solid windowtext; mso-border-left-alt:0.5000pt solid windowtext;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
					<p class="MsoNormal" align="center"
					   style="margin-left:5.6500pt;margin-left:5.6500pt;mso-para-margin-right:0.0000gd; mso-para-margin-left:0.0000gd;text-align:center;">
						<span style="mso-spacerun:'yes';font-family:宋体;mso-ascii-font-family:Calibri; mso-hansi-font-family:Calibri;mso-bidi-font-family:'Times New Roman';font-size:12.0000pt; mso-font-kerning:1.0000pt;">送检单位</span><span
							style="font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri; mso-bidi-font-family:'Times New Roman';font-size:12.0000pt;mso-font-kerning:1.0000pt;"><o:p></o:p></span>
					</p></td>
				<td width="551" valign="center" colspan="6"
					style="width:413.9500pt;border-left:none; mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
					<p class="MsoNormal MsoNormal2" style="text-align:left;"><span
							style="mso-spacerun:'yes';font-family:宋体;color:rgb(0,0,0); letter-spacing:0.0000pt;text-transform:none;font-style:normal; font-size:12.0000pt;mso-font-kerning:1.0000pt;">${unit.companyName}</span><span
							style="font-family:宋体;color:rgb(0,0,0);letter-spacing:0.0000pt; text-transform:none;font-style:normal;font-size:12.0000pt; mso-font-kerning:1.0000pt;"><o:p></o:p></span>
					</p></td>
			</tr>
			<tr style="height: 36px;" >
				<td width="139" valign="center"
					style="text-align: center;width:104.7500pt;border-left:1.0000pt solid windowtext; mso-border-left-alt:0.5000pt solid windowtext;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
					<p class="MsoNormal" align="center"
					   style="margin-right:5.6500pt;margin-left:5.6500pt;mso-para-margin-right:0.0000gd; mso-para-margin-left:0.0000gd;text-align:center;">
						<span style="mso-spacerun:'yes';font-family:宋体;color:rgb(0,0,0); letter-spacing:0.0000pt;text-transform:none;font-style:normal; font-size:12.0000pt;mso-font-kerning:1.0000pt;">联系电话</span><span
							style="font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri; mso-bidi-font-family:'Times New Roman';font-size:12.0000pt;mso-font-kerning:1.0000pt;"><o:p></o:p></span>
					</p></td>
				<td width="551" valign="center" colspan="6"
					style="width:413.9500pt;border-left:none; mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
					<p class="MsoNormal MsoNormal2"
					   style="margin-right:5.6500pt;margin-left:5.6500pt;mso-para-margin-right:0.0000gd; mso-para-margin-left:0.0000gd;text-align:left;">
						<span style="mso-spacerun:'yes';font-family:宋体;color:rgb(0,0,0); letter-spacing:0.0000pt;text-transform:none;font-style:normal; font-size:12.0000pt;mso-font-kerning:1.0000pt;">${unit.linkPhone}</span><span
							style="font-family:宋体;color:rgb(0,0,0);letter-spacing:0.0000pt; text-transform:none;font-style:normal;font-size:12.0000pt; mso-font-kerning:1.0000pt;"><o:p></o:p></span>
					</p></td>
			</tr>
			<tr style="height: 36px;" >
				<td width="139" valign="center"
					style="text-align: center;width:104.7500pt;border-left:1.0000pt solid windowtext; mso-border-left-alt:0.5000pt solid windowtext;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
					<p class="MsoNormal" align="center"
					   style="margin-right:5.6500pt;margin-left:5.6500pt;mso-para-margin-right:0.0000gd; mso-para-margin-left:0.0000gd;text-align:center;">
						<span style="mso-spacerun:'yes';font-family:宋体;mso-ascii-font-family:Calibri; mso-hansi-font-family:Calibri;mso-bidi-font-family:'Times New Roman';font-size:12.0000pt; mso-font-kerning:1.0000pt;">单位地址</span><span
							style="font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri; mso-bidi-font-family:'Times New Roman';font-size:12.0000pt;mso-font-kerning:1.0000pt;"><o:p></o:p></span>
					</p></td>
				<td width="551" valign="center" colspan="6"
					style="width:413.9500pt;border-left:none; mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
					<p class="MsoNormal MsoNormal2" style="text-align:left;"><span
							style="mso-spacerun:'yes';font-family:宋体;color:rgb(0,0,0); letter-spacing:0.0000pt;text-transform:none;font-style:normal; font-size:12.0000pt;mso-font-kerning:1.0000pt;">${unit.companyAddress}</span><span
							style="font-family:宋体;color:rgb(0,0,0);letter-spacing:0.0000pt; text-transform:none;font-style:normal;font-size:12.0000pt; mso-font-kerning:1.0000pt;"><o:p></o:p></span>
					</p></td>
			</tr>
			<%-- <tr style="height: 36px;" >
				<td width="139" valign="center"
					style="text-align: center;width:104.7500pt;border-left:1.0000pt solid windowtext; mso-border-left-alt:0.5000pt solid windowtext;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
					<p class="MsoNormal" align="center"
					   style="margin-right:5.6500pt;margin-left:5.6500pt;mso-para-margin-right:0.0000gd; mso-para-margin-left:0.0000gd;text-align:center;">
						<span style="mso-spacerun:'yes';font-family:宋体;mso-ascii-font-family:Calibri; mso-hansi-font-family:Calibri;mso-bidi-font-family:'Times New Roman';font-size:12.0000pt; mso-font-kerning:1.0000pt;">送样时间</span><span
							style="font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri; mso-bidi-font-family:'Times New Roman';font-size:12.0000pt;mso-font-kerning:1.0000pt;"><o:p></o:p></span>
					</p></td>
				<td width="551" valign="center" colspan="6"
					style="width:413.9500pt;border-left:none; mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
					<p class="MsoNormal" style="text-align:left;"><span
							style="mso-spacerun:'yes';font-family:宋体;color:rgb(0,0,0); letter-spacing:0.0000pt;text-transform:none;font-style:normal; font-size:12.0000pt;mso-font-kerning:1.0000pt;">${receiveBean.sampleTubeTime}</span><span
							style="font-family:宋体;color:rgb(0,0,0);letter-spacing:0.0000pt; text-transform:none;font-style:normal;font-size:12.0000pt; mso-font-kerning:1.0000pt;"><o:p></o:p></span>
					</p></td>
			</tr> --%>
		</table>	
		<!-- 正文开始 -->
				<table style="border-collapse:collapse;width:518.7000pt;mso-table-layout-alt:fixed; border:none;mso-border-left-alt:0.5000pt solid windowtext;mso-border-top-alt:0.5000pt solid windowtext; mso-border-right-alt:0.5000pt solid windowtext;mso-border-bottom-alt:0.5000pt solid windowtext;mso-border-insideh:0.5000pt solid windowtext; mso-border-insidev:0.5000pt solid windowtext;mso-padding-alt:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;text-align: center;">	
								<tr style="height:30.3500pt;">
									<td width="691" valign="center" colspan="7"
										style="width:518.7000pt;border-left:none; mso-border-left-alt:none;border-right:none;mso-border-right-alt:none; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid rgb(0,0,0); mso-border-bottom-alt:0.5000pt solid rgb(0,0,0);border-left: 1.0000pt solid windowtext;border-right: 1.0000pt solid windowtext;">
										<p class="MsoNormal" align="center" style="text-align:center;"><b><span
												style="mso-spacerun:'yes';font-family:宋体;mso-ascii-font-family:Calibri; mso-hansi-font-family:Calibri;mso-bidi-font-family:'Times New Roman';font-weight:bold; font-size:10.5000pt;mso-font-kerning:1.0000pt;">检测结果</span></b><span
												style="font-family:宋体;color:rgb(0,0,0);letter-spacing:0.0000pt; text-transform:none;font-style:normal;font-size:10.5000pt; mso-font-kerning:1.0000pt;">
         <o:p></o:p></span></p></td>
								</tr>
								<tr style="height:30.3500pt;">
									<td width="59" valign="center"
										style="border-left:1.0000pt solid windowtext; mso-border-left-alt:0.5000pt solid windowtext;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
										<p class="MsoNormal" align="center" style="text-align:center;"><b><span
												style="mso-spacerun:'yes';font-family:宋体;mso-ascii-font-family:Calibri; mso-hansi-font-family:Calibri;mso-bidi-font-family:'Times New Roman';font-weight:bold; font-size:10.5000pt;mso-font-kerning:1.0000pt;">序号</span></b><b><span
												style="font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri; mso-bidi-font-family:'Times New Roman';font-weight:bold;font-size:10.5000pt; mso-font-kerning:1.0000pt;">
          <o:p></o:p></span></b></p></td>
									<td width="250" valign="center" colspan="2"
										style="border-left:none; mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:1.0000pt solid windowtext;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
										<p class="MsoNormal" align="center" style="text-align:center;"><b><span
												style="mso-spacerun:'yes';font-family:宋体;mso-ascii-font-family:Calibri; mso-hansi-font-family:Calibri;mso-bidi-font-family:'Times New Roman';font-weight:bold; font-size:10.5000pt;mso-font-kerning:1.0000pt;">样品名称</span></b><b><span
												style="font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri; mso-bidi-font-family:'Times New Roman';font-weight:bold;font-size:10.5000pt; mso-font-kerning:1.0000pt;">
          <o:p></o:p></span></b></p></td>
									<td width="255" valign="center"
										style="border-left:none; mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:1.0000pt solid windowtext;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
										<p class="MsoNormal" align="center" style="text-align:center;"><b><span
												style="mso-spacerun:'yes';font-family:宋体;mso-ascii-font-family:Calibri; mso-hansi-font-family:Calibri;mso-bidi-font-family:'Times New Roman';font-weight:bold; font-size:10.5000pt;mso-font-kerning:1.0000pt;">检测项目</span></b><b><span
												style="font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri; mso-bidi-font-family:'Times New Roman';font-weight:bold;font-size:10.5000pt; mso-font-kerning:1.0000pt;">
          <o:p></o:p></span></b></p></td>
									<td width="126" valign="center" colspan="3"
										style="border-left:none; mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:1.0000pt solid windowtext;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
										<p class="MsoNormal" align="center" style="text-align:center;"><b><span
												style="mso-spacerun:'yes';font-family:宋体;color:rgb(0,0,0); letter-spacing:0.0000pt;font-weight:bold;text-transform:none; font-style:normal;font-size:10.5000pt;mso-font-kerning:1.0000pt;">快检结果</span></b><b><span
												style="font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri; mso-bidi-font-family:'Times New Roman';font-weight:bold;font-size:10.5000pt; mso-font-kerning:1.0000pt;">
          <o:p></o:p></span></b></p></td>
								</tr>
								<c:forEach items="${list}" var="samplingDetail" varStatus="status" >
									<c:if test="${report.reportNumber==samplingDetail.reportNumber }">
									<c:set var="serialNumber" value="${serialNumber+1}" />
									<c:set var="checkUsername1" value="${samplingDetail.checkUsername}"/>
									<c:set var="checkDate1" value="${samplingDetail.checkDate}"/>
									<tr style="height:28.8500pt;">
										<td width="59" valign="center"
											style="padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:1.0000pt solid windowtext; mso-border-left-alt:0.5000pt solid windowtext;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
											<p class="MsoNormal" align="center" style="text-align:center;"><span
													style="font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri; mso-bidi-font-family:'Times New Roman';font-size:10.5000pt;mso-font-kerning:1.0000pt;">${serialNumber}</span><span
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
								</c:if>
								</c:forEach>
								<c:forEach var="i" begin="${serialNumber+1}" end="10">
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
		<!-- 正文结束 -->
		<table style="border-collapse:collapse;width:518.7000pt;mso-table-layout-alt:fixed; border:none;mso-border-left-alt:0.5000pt solid windowtext;mso-border-top-alt:0.5000pt solid windowtext; mso-border-right-alt:0.5000pt solid windowtext;mso-border-bottom-alt:0.5000pt solid windowtext;mso-border-insideh:0.5000pt solid windowtext; mso-border-insidev:0.5000pt solid windowtext;mso-padding-alt:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;">
								
								<tr style="height:29.8500pt;">
									<td width="139" valign="center"
										style="text-align: center;width:104.7500pt;border-left:1.0000pt solid windowtext; mso-border-left-alt:0.5000pt solid windowtext;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
										<p class="MsoNormal" align="center" style="text-align:center;"><span
												style="mso-spacerun:'yes';font-family:宋体;mso-ascii-font-family:Calibri; mso-hansi-font-family:Calibri;mso-bidi-font-family:'Times New Roman';font-size:12.0000pt; mso-font-kerning:1.0000pt;">检测人员</span><span
												style="font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri; mso-bidi-font-family:'Times New Roman';font-size:12.0000pt;mso-font-kerning:1.0000pt;"><o:p></o:p></span>
										</p></td>
									<td width="551" valign="center" colspan="6"
										style="width:413.9500pt;border-left:none; mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
										<p class="MsoNormal MsoNormal2" style="text-align:left;"><span
												style="mso-spacerun:'yes';font-family:宋体;mso-ascii-font-family:Calibri; mso-hansi-font-family:Calibri;mso-bidi-font-family:'Times New Roman';font-size:12.0000pt; mso-font-kerning:1.0000pt;">${checkUsername1}</span><span
												style="font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri; mso-bidi-font-family:'Times New Roman';font-size:12.0000pt;mso-font-kerning:1.0000pt;"><o:p></o:p></span>
										</p></td>
								</tr>
								<tr style="height:27.1000pt;">
									<td width="139" valign="center"
										style="text-align: center;width:104.7500pt;border-left:1.0000pt solid windowtext; mso-border-left-alt:0.5000pt solid windowtext;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
										<p class="MsoNormal" align="center"
										   style="margin-right:5.6500pt;margin-left:5.6500pt;mso-para-margin-right:0.0000gd; mso-para-margin-left:0.0000gd;text-align:center;">
											<span style="mso-spacerun:'yes';font-family:宋体;mso-ascii-font-family:Calibri; mso-hansi-font-family:Calibri;mso-bidi-font-family:'Times New Roman';font-size:12.0000pt; mso-font-kerning:1.0000pt;">检测时间</span><span
												style="font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri; mso-bidi-font-family:'Times New Roman';font-size:12.0000pt;mso-font-kerning:1.0000pt;"><o:p></o:p></span>
										</p></td>
									<td width="551" valign="center" colspan="6"
										style="width:413.9500pt;border-left:none; mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
										<p class="MsoNormal MsoNormal2" style="text-align:left;"><span
												style="mso-spacerun:'yes';font-family:宋体;color:rgb(0,0,0); letter-spacing:0.0000pt;text-transform:none;font-style:normal; font-size:12.0000pt;mso-font-kerning:1.0000pt;"><fmt:formatDate value="${checkDate1}" pattern="yyyy-MM-dd"/></span><span
												style="font-family:宋体;color:rgb(0,0,0);letter-spacing:0.0000pt; text-transform:none;font-style:normal;font-size:12.0000pt; mso-font-kerning:1.0000pt;"><o:p></o:p></span>
										</p></td>
								</tr>
							<tr style="height:27.1000pt;">
									<td width="139" valign="center"
										style="text-align: center;width:104.7500pt;border-left:1.0000pt solid windowtext; mso-border-left-alt:0.5000pt solid windowtext;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
										<p class="MsoNormal" align="center"
										   style="margin-right:5.6500pt;margin-left:5.6500pt;mso-para-margin-right:0.0000gd; mso-para-margin-left:0.0000gd;text-align:center;">
											<span style="mso-spacerun:'yes';font-family:宋体;mso-ascii-font-family:Calibri; mso-hansi-font-family:Calibri;mso-bidi-font-family:'Times New Roman';font-size:12.0000pt; mso-font-kerning:1.0000pt;">检测机构</span><span
												style="font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri; mso-bidi-font-family:'Times New Roman';font-size:12.0000pt;mso-font-kerning:1.0000pt;"><o:p></o:p></span>
										</p></td>
									<td width="551" valign="center" colspan="6"
										style="width:413.9500pt;border-left:none; mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
										<p class="MsoNormal MsoNormal2" style="text-align:left;"><span
												style="font-family:Calibri;mso-fareast-font-family:宋体;mso-bidi-font-family:'Times New Roman'; font-size:12.0000pt;mso-font-kerning:1.0000pt;"><span
												style="position:absolute;z-index:1;margin-left:229.0667px; margin-top: -93.4667px;width:151.0000px;height:151.0000px;"><img
												width="151" height="151" src="${webRoot}/img/terminal/report.png"/></span></span><span
												style="mso-spacerun:'yes';font-family:宋体;color:rgb(0,0,0); letter-spacing:0.0000pt;text-transform:none;font-style:normal; font-size:12.0000pt;mso-font-kerning:1.0000pt;">${samplingDetail.pointName }</span><span
												style="font-family:宋体;color:rgb(0,0,0);letter-spacing:0.0000pt; text-transform:none;font-style:normal;font-size:12.0000pt; mso-font-kerning:1.0000pt;"><o:p></o:p></span>
										</p></td>
								</tr>
									<tr style="height:27.1000pt;">
									<td width="139" valign="center"
										style="text-align: center;width:104.7500pt;border-left:1.0000pt solid windowtext; mso-border-left-alt:0.5000pt solid windowtext;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
										<p class="MsoNormal" align="center"
										   style="margin-right:5.6500pt;margin-left:5.6500pt;mso-para-margin-right:0.0000gd; mso-para-margin-left:0.0000gd;text-align:center;">
											<span style="mso-spacerun:'yes';font-family:宋体;mso-ascii-font-family:Calibri; mso-hansi-font-family:Calibri;mso-bidi-font-family:'Times New Roman';font-size:12.0000pt; mso-font-kerning:1.0000pt;">机构地址</span><span
												style="font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri; mso-bidi-font-family:'Times New Roman';font-size:12.0000pt;mso-font-kerning:1.0000pt;"><o:p></o:p></span>
										</p></td>
									<td width="551" valign="center" colspan="6"
										style="width:413.9500pt;border-left:none; mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:0.5000pt solid windowtext;">
										<p class="MsoNormal MsoNormal2" style="text-align:left;"><span
												style="mso-spacerun:'yes';font-family:宋体;color:rgb(0,0,0); letter-spacing:0.0000pt;text-transform:none;font-style:normal; font-size:12.0000pt;mso-font-kerning:1.0000pt;">${samplingDetail.pointAddress }</span><span
												style="font-family:宋体;color:rgb(0,0,0);letter-spacing:0.0000pt; text-transform:none;font-style:normal;font-size:12.0000pt; mso-font-kerning:1.0000pt;"><o:p></o:p></span>
										</p></td>
								</tr>
								<tr style="height:29.1000pt;"><!-- border-bottom: 1px dotted; -->
									<td width="691" valign="center" colspan="7"
										style="    padding-left: 38px;width:518.7000pt;border-left:none; mso-border-left-alt:none;border-right:none;mso-border-right-alt:none; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:none; mso-border-bottom-alt:none;">
										<p class="MsoNormal" style="text-align:left;">
											<span style="float: left; margin-top: 17px;mso-spacerun:'yes';font-family:宋体;color:rgb(0,0,0); letter-spacing:0.0000pt;text-transform:none;font-style:normal; font-size:10.5000pt;mso-font-kerning:1.0000pt;">
											审核人员：
											</span>
											<img  height="50" src="${webRoot}/img/terminal/signature.jpg" style="float:left;" />
										</p>
									</td>
								</tr>
								<tr style="height:29.1000pt;">
									<td width="691" valign="center" colspan="7"
										style="padding-left: 10px;padding-top: 10px;width:518.7000pt;border-left:none; mso-border-left-alt:none;border-right:none;mso-border-right-alt:none; border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:none; mso-border-bottom-alt:none;">
										<p class="MsoNormal" style="text-align:left;">
											<span style="mso-spacerun:'yes';font-family:宋体;color:rgb(0,0,0); letter-spacing:0.0000pt;text-transform:none;font-style:normal; font-size:10.5000pt;mso-font-kerning:1.0000pt;">
											注：1.检测报告仅对来样负责;<br/>
											&nbsp;&nbsp;&nbsp;&nbsp;2.检测结果手写无效;<br/>
											&nbsp;&nbsp;&nbsp;&nbsp;3.本报告复印无效;<br/>
											</span>
										</p>
									</td>
								</tr>
								</tbody>
							</table>
	</div>
</c:forEach>
	<!-- <c:forEach items="${list}" var="samplingDetail" varStatus="index">
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
							<span style="mso-spacerun:'yes';font-family:宋体;color:rgb(0,0,0); letter-spacing:0.0000pt;text-transform:none;font-style:normal; font-size:10.5000pt;mso-font-kerning:1.0000pt;background:rgb(255,255,255); mso-shading:rgb(255,255,255);">订单编号：${bean.samplingNo}</span>
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
	</c:forEach>-->
</div>