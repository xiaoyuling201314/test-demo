<%@page import="com.alibaba.fastjson.JSONArray"%>
<%@page import="com.alibaba.fastjson.JSONObject"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/common/resource.jsp"%>
<!DOCTYPE html>
<html lang="en">
    <head>
    <meta charset="utf-8">
<style>
	.MsoNormal{
		font-family:'宋体';
	}
	.tr-height{
		height:46px;
	}
	.btn-print{
		display: none;
	}
</style>
</head>

<body lang=ZH-CN style='text-justify-trim:punctuation'>
<div class="cs-alert-form-btn">
	<span class="tipsMessage" ></span>
	 <a class="cs-menu-btn cs-fun-btn printBtn btn-print" onclick="preview();"><i class="icon iconfont icon-dayin"></i>打印</a>
      <a class="cs-menu-btn cs-fun-btn" href="javascript:" onclick="parent.closeMbIframe(1);" ><i class="icon iconfont icon-fanhui"></i>返回</a>
  </div>
<div class="cs-hd"></div>
<!--startprint-->
<c:forEach items="${list}" var="l">
	<input type="hidden" name="samplingId" value="${l.sampling.id }"/>
	<input type="hidden" name="printNum" value="${l.sampling.printNum }"/>
	<!-- 每页展示多少条数据 -->
	<c:set var="pageSize" value="11"/>
	<!-- 打印页数 -->
	<c:set var="printPage" value="${fn:length(l.samplingDetailList)%pageSize==0? fn:length(l.samplingDetailList)/pageSize : (fn:length(l.samplingDetailList)/pageSize+1)}"/>
	<c:set var="serialNumber" value="0"/>
	<c:forEach var="item" begin="1" end="${printPage>0? printPage : 1}" varStatus="pageNumber">
	<c:set var="pageSerialNumber" value="0"/>
 <c:choose>
	<c:when test="${l.sampling.personal==1}"><!-- 送样检测报告 -->
	 	<div class="Section0_${pageNumber.index}" style="layout-grid:15.6000pt; padding-top:20px;height: 1050px;">
	     <%-- <p class="MsoNormal" align=center style="margin-top:0.0000pt;margin-right:0.0000pt;margin-bottom:0.0000pt;
	      margin-left:0.0000pt;padding:0pt 0pt 0pt 0pt ;mso-pagination:widow-orphan;
	      text-align:center;">
	        <b>
	          <span style="mso-spacerun:'yes';font-family:宋体;letter-spacing:0.0000pt;
	          font-weight:bold;text-transform:none;font-size:16.0000pt;
	          mso-font-kerning:0.0000pt;">
	            <font face="宋体">常德市武陵区市场监督管理局</font></span>
	        </b>
	        <b>
	          <span style="mso-spacerun:'yes';font-family:宋体;letter-spacing:0.0000pt;
	          font-weight:bold;text-transform:none;font-size:16.0000pt;
	          mso-font-kerning:0.0000pt;">
	            <o:p></o:p>
	          </span>
	        </b>
	      </p>--%>
	      <!-- 头部表格开始 -->
	      <table class="MsoNormal"Table border=1 cellspacing=0 style="border-collapse:collapse;width:544.000pt;margin: 0 auto;
	      border:none;mso-border-left-alt:none;mso-border-top-alt:none;
	      mso-border-right-alt:none;mso-border-bottom-alt:none;mso-border-insideh:0.7500pt outset windowtext;
	      mso-border-insidev:0.7500pt outset windowtext;mso-padding-alt:0.0000pt 0.0000pt 0.0000pt 0.0000pt ;">
	        <tr style="height:27.1000pt;">
	          <td width=726 valign=top colspan=10 style="width:544.5000pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none;
	          mso-border-left-alt:none;border-right:none;mso-border-right-alt:none;
	          border-top:none;mso-border-top-alt:none;border-bottom:none;
	          mso-border-bottom-alt:none;background:rgb(255,255,255);">
	            <p class="MsoNormal" align=center style="margin-top:0.0000pt;margin-right:0.0000pt;margin-bottom:0.0000pt;
	            margin-left:0.0000pt;mso-pagination:widow-orphan;text-align:center;">
	              <b>
	                <span style="mso-spacerun:'yes';font-family:宋体;letter-spacing:0.0000pt;
	                font-weight:bold;text-transform:none;font-size:16.0000pt;
	                mso-font-kerning:0.0000pt;">食用农产品快速检验报告</span>
	              </b>
	              <span style="font-family:Calibri;mso-fareast-font-family:宋体;font-size:10.5000pt;
	              mso-font-kerning:1.0000pt;">
	                <o:p></o:p>
	              </span>
	            </p>
	          </td>
	        </tr>
	        <tr style="height:16.2500pt;">
	          <td width=403 valign=bottom colspan=5 style="width:302.2500pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none;
	          mso-border-left-alt:none;border-right:none;mso-border-right-alt:none;
	          border-top:none;mso-border-top-alt:none;border-bottom:1.0000pt solid windowtext;
	          mso-border-bottom-alt:1.0000pt solid windowtext;background:rgb(255,255,255);">
	            <p class="MsoNormal" style="margin-top:0.0000pt;margin-right:0.0000pt;margin-bottom:0.0000pt;
	            margin-left:0.0000pt;mso-pagination:widow-orphan;text-align:left;">
	              <span style="mso-spacerun:'yes';font-family:宋体;letter-spacing:0.0000pt;
	              text-transform:none;font-size:10.5000pt;mso-font-kerning:0.0000pt;">送样时间：</span>
	              <span style="mso-spacerun:'yes';font-family:Calibri;mso-fareast-font-family:'宋体';
	              letter-spacing:0.0000pt;text-transform:none;font-size:10.5000pt;
	              mso-font-kerning:0.0000pt;"><fmt:formatDate value="${l.sampling.samplingDate}" pattern="yyyy-MM-dd HH:mm:ss"/></span>
	              <span style="font-family:'宋体';mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;
	              mso-bidi-font-family:Calibri;letter-spacing:0.0000pt;text-transform:none;
	              font-size:10.5000pt;mso-font-kerning:0.0000pt;"></span>
	              <span style="mso-spacerun:'yes';font-family:Calibri;mso-fareast-font-family:'宋体';
	              letter-spacing:0.0000pt;text-transform:none;font-size:10.5000pt;
	              mso-font-kerning:0.0000pt;"></span>
	              <span style="font-family:Calibri;mso-fareast-font-family:宋体;font-size:10.5000pt;
	              mso-font-kerning:1.0000pt;">
	                <o:p></o:p>
	              </span>
	            </p>
	          </td>
	           <td width=323 valign=bottom colspan=5 style="width:242.2500pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none;
	          mso-border-left-alt:none;border-right:none;mso-border-right-alt:none;
	          border-top:none;mso-border-top-alt:none;border-bottom:1.0000pt solid windowtext;
	          mso-border-bottom-alt:1.0000pt solid windowtext;background:rgb(255,255,255);">
	            <p class="MsoNormal" align=justify style="margin-top:0.0000pt;margin-right:0.0000pt;margin-bottom:0.0000pt;
	            margin-left:0.0000pt;text-indent:42.0000pt;mso-char-indent-count:4.0000;
	            mso-pagination:widow-orphan;text-align:right;text-justify:inter-ideograph;">
	              <span style="mso-spacerun:'yes';font-family:宋体;letter-spacing:0.0000pt;
	              text-transform:none;font-size:10.5000pt;mso-font-kerning:0.0000pt;">单号：</span>
	              <span style="mso-spacerun:'yes';font-family:Calibri;mso-fareast-font-family:'宋体';
	              letter-spacing:0.0000pt;text-transform:none;font-size:10.5000pt;
	              mso-font-kerning:0.0000pt;">${l.sampling.samplingNo}</span>
	              <span style="font-family:Calibri;mso-fareast-font-family:宋体;font-size:10.5000pt;
	              mso-font-kerning:1.0000pt;">
	                <o:p></o:p>
	              </span>
	            </p>
	          </td>
	        </tr>
		  </table>
		  <table class="MsoNormal"Table border=1 cellspacing=0 style="border-collapse:collapse;width:544.000pt;margin: 0 auto;
	      border:none;mso-border-left-alt:none;mso-border-top-alt:none;
	      mso-border-right-alt:none;mso-border-bottom-alt:none;mso-border-insideh:0.7500pt outset windowtext;
	      mso-border-insidev:0.7500pt outset windowtext;mso-padding-alt:0.0000pt 0.0000pt 0.0000pt 0.0000pt ;">
	        <tr style="height:25.2000pt;">
	          <td width=124 valign=center colspan=2 style="width:146.1500pt;border-left:1.0000pt solid windowtext;
	          mso-border-left-alt:1.0000pt solid windowtext;border-right:1.0000pt solid windowtext;mso-border-right-alt:1.0000pt solid windowtext;
	          border-top:none;mso-border-top-alt:none;border-bottom:1.0000pt solid windowtext;
	          mso-border-bottom-alt:1.0000pt solid windowtext;background:rgb(255,255,255);">
	            <p class="MsoNormal" align=center style="margin-top:0.0000pt;margin-right:0.0000pt;margin-bottom:0.0000pt;
	            margin-left:0.0000pt;mso-pagination:widow-orphan;text-align:center;">
	              <span style="mso-spacerun:'yes';font-family:宋体;letter-spacing:0.0000pt;
	              text-transform:none;font-size:10.5000pt;mso-font-kerning:0.0000pt;">送样人</span>
	              <span style="font-family:Calibri;mso-fareast-font-family:宋体;font-size:10.5000pt;
	              mso-font-kerning:1.0000pt;">
	                <o:p></o:p>
	              </span>
	            </p>
	          </td>
	          <td width=467 valign=center colspan=6 style="width:350.9000pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none;
	          mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:1.0000pt solid windowtext;
	          border-top:none;mso-border-top-alt:none;border-bottom:1.0000pt solid windowtext;
	          mso-border-bottom-alt:1.0000pt solid windowtext;background:rgb(255,255,255);">
	            <p class="MsoNormal" style="margin-top:0.0000pt;margin-right:0.0000pt;margin-bottom:0.0000pt;
	            margin-left:0.0000pt;mso-pagination:widow-orphan;text-align:left;">
	              <span style="mso-spacerun:'yes';font-family:宋体;letter-spacing:0.0000pt;
	              text-transform:none;font-size:10.5000pt;mso-font-kerning:0.0000pt;">${l.sampling.regName}</span>
	              <span style="font-family:Calibri;mso-fareast-font-family:宋体;font-size:10.5000pt;
	              mso-font-kerning:1.0000pt;">
	                <o:p></o:p>
	              </span>
	            </p>
	          </td>
	          <td width=133 valign=center colspan=2 rowspan=4 style="width:100.4500pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none;
	          mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:1.0000pt solid windowtext;
	          border-top:none;mso-border-top-alt:none;border-bottom:1.0000pt solid windowtext;
	          mso-border-bottom-alt:1.0000pt solid windowtext;background:rgb(255,255,255);">
	            <p class="MsoNormal" align=center style="height: 95px;margin-top:0.0000pt;margin-right:0.0000pt;margin-bottom:0.0000pt;
	            margin-left:0.0000pt;mso-pagination:widow-orphan;text-align:center;">
	              <span style="font-family:Calibri;mso-fareast-font-family:'宋体';letter-spacing:0.0000pt;
	              text-transform:none;font-size:10.5000pt;mso-font-kerning:0.0000pt;">
	                <img width="103" height="99" src="${webRoot}/resources/${l.samplingQr}"></span>
	              <span style="font-family:Calibri;mso-fareast-font-family:宋体;font-size:10.5000pt;
	              mso-font-kerning:1.0000pt;">
	                </span>
	            </p>
	            <p class="MsoNormal" align=center style="margin-top:0.0000pt;margin-right:0.0000pt;margin-bottom:0.0000pt;
	            margin-left:0.0000pt;mso-pagination:widow-orphan;text-align:center;">
	              <span style="mso-spacerun:'yes';font-family:宋体;letter-spacing:0.0000pt;
	              text-transform:none;font-size:10.5000pt;mso-font-kerning:0.0000pt;">（查询二维码）</span>
	              <span style="font-family:Calibri;mso-fareast-font-family:宋体;font-size:10.5000pt;
	              mso-font-kerning:1.0000pt;"></span>
	            </p>
	          </td>
	        </tr>
	        <tr style="height:25.2000pt;">
	          <td width=124 valign=center colspan=2 style="width:93.1500pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:1.0000pt solid windowtext;
	          mso-border-left-alt:1.0000pt solid windowtext;border-right:1.0000pt solid windowtext;mso-border-right-alt:1.0000pt solid windowtext;
	          border-top:none;mso-border-top-alt:none;border-bottom:1.0000pt solid windowtext;
	          mso-border-bottom-alt:1.0000pt solid windowtext;background:rgb(255,255,255);">
	            <p class="MsoNormal" align=center style="margin-top:0.0000pt;margin-right:0.0000pt;margin-bottom:0.0000pt;
	            margin-left:0.0000pt;mso-pagination:widow-orphan;text-align:center;">
	              <span style="mso-spacerun:'yes';font-family:宋体;letter-spacing:0.0000pt;
	              text-transform:none;font-size:10.5000pt;mso-font-kerning:0.0000pt;">身份证号码</span>
	              <span style="font-family:Calibri;mso-fareast-font-family:宋体;font-size:10.5000pt;
	              mso-font-kerning:1.0000pt;">
	              </span>
	            </p>
	          </td>
	          <td width=467 valign=center colspan=6 style="width:350.9000pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none;
	          mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:1.0000pt solid windowtext;
	          border-top:none;mso-border-top-alt:none;border-bottom:1.0000pt solid windowtext;
	          mso-border-bottom-alt:1.0000pt solid windowtext;background:rgb(255,255,255);">
	            <p class="MsoNormal" style="margin-top:0.0000pt;margin-right:0.0000pt;margin-bottom:0.0000pt;
	            margin-left:0.0000pt;mso-pagination:widow-orphan;text-align:left;">
	              <span style="mso-spacerun:'yes';font-family:宋体;letter-spacing:0.0000pt;
	              text-transform:none;font-size:10.5000pt;mso-font-kerning:0.0000pt;">${l.sampling.regLicence}</span>
	              <span style="font-family:Calibri;mso-fareast-font-family:宋体;font-size:10.5000pt;
	              mso-font-kerning:1.0000pt;">
	              </span>
	            </p>
	          </td>
	        </tr>
	        <tr style="height:25.2000pt;">
	          <td width=124 valign=center colspan=2 style="width:93.1500pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:1.0000pt solid windowtext;
	          mso-border-left-alt:1.0000pt solid windowtext;border-right:1.0000pt solid windowtext;mso-border-right-alt:1.0000pt solid windowtext;
	          border-top:none;mso-border-top-alt:none;border-bottom:1.0000pt solid windowtext;
	          mso-border-bottom-alt:1.0000pt solid windowtext;background:rgb(255,255,255);">
	            <p class="MsoNormal" align=center style="margin-top:0.0000pt;margin-right:0.0000pt;margin-bottom:0.0000pt;
	            margin-left:0.0000pt;mso-pagination:widow-orphan;text-align:center;">
	              <span style="mso-spacerun:'yes';font-family:宋体;letter-spacing:0.0000pt;
	              text-transform:none;font-size:10.5000pt;mso-font-kerning:0.0000pt;">微&nbsp;&nbsp;信</span>
	              <span style="font-family:Calibri;mso-fareast-font-family:宋体;font-size:10.5000pt;
	              mso-font-kerning:1.0000pt;">
	              </span>
	            </p>
	          </td>
	          <td width=188 valign=center colspan=2 style="width:141.6500pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none;
	          mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:1.0000pt solid windowtext;
	          border-top:none;mso-border-top-alt:none;border-bottom:1.0000pt solid windowtext;
	          mso-border-bottom-alt:1.0000pt solid windowtext;background:rgb(255,255,255);">
	            <p class="MsoNormal" style="margin-top:0.0000pt;margin-right:0.0000pt;margin-bottom:0.0000pt;
	            margin-left:0.0000pt;mso-pagination:widow-orphan;text-align:left;">
	              <span style="mso-spacerun:'yes';font-family:宋体;mso-fareast-font-family:'宋体';
	              letter-spacing:0.0000pt;text-transform:none;font-size:10.5000pt;
	              mso-font-kerning:0.0000pt;">${l.sampling.opePhone}</span>
	              <span style="font-family:Calibri;mso-fareast-font-family:宋体;font-size:10.5000pt;
	              mso-font-kerning:1.0000pt;">
	              </span>
	            </p>
	          </td>
	          <td width=99 valign=center colspan=2 style="width:74.4500pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none;
	          mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:1.0000pt solid windowtext;
	          border-top:none;mso-border-top-alt:none;border-bottom:1.0000pt solid windowtext;
	          mso-border-bottom-alt:1.0000pt solid windowtext;background:rgb(255,255,255);">
	            <p class="MsoNormal" align=center style="margin-top:0.0000pt;margin-right:0.0000pt;margin-bottom:0.0000pt;
	            margin-left:0.0000pt;mso-pagination:widow-orphan;text-align:center;">
	              <span style="mso-spacerun:'yes';font-family:宋体;letter-spacing:0.0000pt;
	              text-transform:none;font-size:10.5000pt;mso-font-kerning:0.0000pt;">邮&nbsp;&nbsp;箱</span>
	              <span style="font-family:Calibri;mso-fareast-font-family:宋体;font-size:10.5000pt;
	              mso-font-kerning:1.0000pt;">
	              </span>
	            </p>
	          </td>
	          <td width=179 valign=center colspan=2 style="width:134.8000pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none;
	          mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:1.0000pt solid windowtext;
	          border-top:none;mso-border-top-alt:none;border-bottom:1.0000pt solid windowtext;
	          mso-border-bottom-alt:1.0000pt solid windowtext;background:rgb(255,255,255);">
				  <p class="MsoNormal" style="margin-top:0.0000pt;margin-right:0.0000pt;margin-bottom:0.0000pt;
	            margin-left:0.0000pt;mso-pagination:widow-orphan;text-align:left;">
	              <span style="mso-spacerun:'yes';font-family:Calibri;mso-fareast-font-family:'宋体';
	              letter-spacing:0.0000pt;text-transform:none;font-size:10.5000pt;
	              mso-font-kerning:0.0000pt;">${l.sampling.regLinkPerson}</span>
					  <span style="font-family:Calibri;mso-fareast-font-family:宋体;font-size:10.5000pt;
	              mso-font-kerning:1.0000pt;">
	              </span>
				  </p>
	          </td>
	        </tr>
	        <tr style="height:25.2000pt;">
	          <td width=124 valign=center colspan=2 style="width:93.1500pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:1.0000pt solid windowtext;
	          mso-border-left-alt:1.0000pt solid windowtext;border-right:1.0000pt solid windowtext;mso-border-right-alt:1.0000pt solid windowtext;
	          border-top:none;mso-border-top-alt:none;border-bottom:1.0000pt solid windowtext;
	          mso-border-bottom-alt:1.0000pt solid windowtext;background:rgb(255,255,255);">
	            <p class="MsoNormal" align=center style="margin-top:0.0000pt;margin-right:0.0000pt;margin-bottom:0.0000pt;
	            margin-left:0.0000pt;mso-pagination:widow-orphan;text-align:center;">
	              <span style="mso-spacerun:'yes';font-family:宋体;letter-spacing:0.0000pt;
	              text-transform:none;font-size:10.5000pt;mso-font-kerning:0.0000pt;">地&nbsp;&nbsp;址</span>
	              <span style="font-family:Calibri;mso-fareast-font-family:宋体;font-size:10.5000pt;
	              mso-font-kerning:1.0000pt;">
	              </span>
	            </p>
	          </td>
	          <td width=188 valign=center colspan=2 style="width:141.6500pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none;
	          mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:1.0000pt solid windowtext;
	          border-top:none;mso-border-top-alt:none;border-bottom:1.0000pt solid windowtext;
	          mso-border-bottom-alt:1.0000pt solid windowtext;background:rgb(255,255,255);">
	            <p class="MsoNormal" align=justify style="margin-top:0.0000pt;margin-right:0.0000pt;margin-bottom:0.0000pt;
	            margin-left:0.0000pt;mso-pagination:widow-orphan;text-align:justify;
	            text-justify:inter-ideograph;">
	              <span style="mso-spacerun:'yes';font-family:宋体;letter-spacing:0.0000pt;
	              text-transform:none;font-size:10.5000pt;mso-font-kerning:0.0000pt;">${l.sampling.opeShopName}</span>
	              <span style="font-family:Calibri;mso-fareast-font-family:宋体;font-size:10.5000pt;
	              mso-font-kerning:1.0000pt;">
	              </span>
	            </p>
	          </td>
	          <td width=99 valign=center colspan=2 style="width:74.4500pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none;
	          mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:1.0000pt solid windowtext;
	          border-top:none;mso-border-top-alt:none;border-bottom:1.0000pt solid windowtext;
	          mso-border-bottom-alt:1.0000pt solid windowtext;background:rgb(255,255,255);">
	            <p class="MsoNormal" align=center style="margin-top:0.0000pt;margin-right:0.0000pt;margin-bottom:0.0000pt;
	            margin-left:0.0000pt;mso-pagination:widow-orphan;text-align:center;">
	              <span style="mso-spacerun:'yes';font-family:宋体;letter-spacing:0.0000pt;
	              text-transform:none;font-size:10.5000pt;mso-font-kerning:0.0000pt;">联系电话</span>
	              <span style="font-family:Calibri;mso-fareast-font-family:宋体;font-size:10.5000pt;
	              mso-font-kerning:1.0000pt;">
	              </span>
	            </p>
	          </td>
	          <td width=179 valign=center colspan=2 style="width:134.8000pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none;
	          mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:1.0000pt solid windowtext;
	          border-top:none;mso-border-top-alt:none;border-bottom:1.0000pt solid windowtext;
	          mso-border-bottom-alt:1.0000pt solid windowtext;background:rgb(255,255,255);">
	            <p class="MsoNormal" style="margin-top:0.0000pt;margin-right:0.0000pt;margin-bottom:0.0000pt;
	            margin-left:0.0000pt;mso-pagination:widow-orphan;text-align:left;">
	              <span style="mso-spacerun:'yes';font-family:Calibri;mso-fareast-font-family:'宋体';
	              letter-spacing:0.0000pt;text-transform:none;font-size:10.5000pt;
	              mso-font-kerning:0.0000pt;">${l.sampling.regLinkPhone}</span>
	              <span style="font-family:Calibri;mso-fareast-font-family:宋体;font-size:10.5000pt;
	              mso-font-kerning:1.0000pt;">
	              </span>
	            </p>
	          </td>
	        </tr>
	        
	        </table>
	       <!-- 正文内容开始 -->
	        <table class="MsoNormal"Table border=1 cellspacing=0 style="border-collapse:collapse;width:544.0000pt;margin: 0 auto;
	      border:none;mso-border-left-alt:none;mso-border-top-alt:none;
	      mso-border-right-alt:none;mso-border-bottom-alt:none;mso-border-insideh:0.7500pt outset windowtext;
	      mso-border-insidev:0.7500pt outset windowtext;mso-padding-alt:0.0000pt 0.0000pt 0.0000pt 0.0000pt ;">
	     <tr style="height:21.9500pt;">
	          <td width=726 valign=center colspan=10 style="width:544.5000pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:1.0000pt solid windowtext;
	          mso-border-left-alt:1.0000pt solid windowtext;border-right:1.0000pt solid windowtext;mso-border-right-alt:1.0000pt solid windowtext;
	          border-top:none;mso-border-top-alt:none;border-bottom:1.0000pt solid windowtext;
	          mso-border-bottom-alt:1.0000pt solid windowtext;background:rgb(191,191,191);">
	            <p class="MsoNormal" align=center style="margin-top:0.0000pt;margin-right:0.0000pt;margin-bottom:0.0000pt;
	            margin-left:0.0000pt;mso-pagination:widow-orphan;text-align:center;">
	              <span style="mso-spacerun:'yes';font-family:宋体;letter-spacing:0.0000pt;
	              text-transform:none;font-size:12.0000pt;mso-font-kerning:0.0000pt;">检测信息</span>
	              <span style="font-family:Calibri;mso-fareast-font-family:宋体;font-size:12.0000pt;
	              mso-font-kerning:1.0000pt;">
	              </span>
	            </p>
	          </td>
	        </tr>
	        <tr style="height:31.4500pt;">
	          <td  valign=center style="width:34.0500pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:1.0000pt solid windowtext;
	          mso-border-left-alt:1.0000pt solid windowtext;border-right:1.0000pt solid windowtext;mso-border-right-alt:1.0000pt solid windowtext;
	          border-top:none;mso-border-top-alt:none;border-bottom:1.0000pt solid windowtext;
	          mso-border-bottom-alt:1.0000pt solid windowtext;background:rgb(255,255,255);">
	            <p class="MsoNormal" align=center style="margin-top:0.0000pt;margin-right:0.0000pt;margin-bottom:0.0000pt;
	            margin-left:0.0000pt;mso-pagination:widow-orphan;text-align:center;">
	              <span style="mso-spacerun:'yes';font-family:宋体;letter-spacing:0.0000pt;
	              text-transform:none;font-size:10.5000pt;mso-font-kerning:0.0000pt;">编号</span>
	              <span style="font-family:Calibri;mso-fareast-font-family:宋体;font-size:10.5000pt;
	              mso-font-kerning:1.0000pt;">
	              </span>
	            </p>
	          </td>
	          <td  valign=center  style="width:100.25pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none;
	          mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:1.0000pt solid windowtext;
	          border-top:none;mso-border-top-alt:none;border-bottom:1.0000pt solid windowtext;
	          mso-border-bottom-alt:1.0000pt solid windowtext;background:rgb(255,255,255);">
	            <p class="MsoNormal" align=center style="margin-top:0.0000pt;margin-right:0.0000pt;margin-bottom:0.0000pt;
	            margin-left:0.0000pt;mso-pagination:widow-orphan;text-align:center;">
	              <span style="mso-spacerun:'yes';font-family:宋体;letter-spacing:0.0000pt;
	              text-transform:none;font-size:10.5000pt;mso-font-kerning:0.0000pt;">样品名称</span>
	              <span style="font-family:Calibri;mso-fareast-font-family:宋体;font-size:10.5000pt;
	              mso-font-kerning:1.0000pt;">
	              </span>
	            </p>
	          </td>
	          <td  valign=center style="width:127.5pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none;
	          mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:1.0000pt solid windowtext;
	          border-top:none;mso-border-top-alt:none;border-bottom:1.0000pt solid windowtext;
	          mso-border-bottom-alt:1.0000pt solid windowtext;background:rgb(255,255,255);">
	            <p class="MsoNormal" align=center style="margin-top:0.0000pt;margin-right:0.0000pt;margin-bottom:0.0000pt;
	            margin-left:0.0000pt;mso-pagination:widow-orphan;text-align:center;">
	              <span style="mso-spacerun:'yes';font-family:宋体;letter-spacing:0.0000pt;
	              text-transform:none;font-size:10.5000pt;mso-font-kerning:0.0000pt;">检测项目</span>
	              <span style="font-family:Calibri;mso-fareast-font-family:宋体;font-size:10.5000pt;
	              mso-font-kerning:1.0000pt;">
	              </span>
	            </p>
	          </td>
	          <td valign=center style="width:152.75pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none;
	          mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:1.0000pt solid windowtext;
	          border-top:none;mso-border-top-alt:none;border-bottom:1.0000pt solid windowtext;
	          mso-border-bottom-alt:1.0000pt solid windowtext;background:rgb(255,255,255);">
	            <p class="MsoNormal" align=center style="margin-top:0.0000pt;margin-right:0.0000pt;margin-bottom:0.0000pt;
	            margin-left:0.0000pt;mso-pagination:widow-orphan;text-align:center;">
	              <span style="mso-spacerun:'yes';font-family:宋体;letter-spacing:0.0000pt;
	              text-transform:none;font-size:10.5000pt;mso-font-kerning:0.0000pt;">判定标准</span>
	              <span style="font-family:Calibri;mso-fareast-font-family:宋体;font-size:10.5000pt;
	              mso-font-kerning:1.0000pt;">
	              </span>
	            </p>
	          </td>
	          <td valign=center style="width: 65pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none;
	          mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:1.0000pt solid windowtext;
	          border-top:none;mso-border-top-alt:none;border-bottom:1.0000pt solid windowtext;
	          mso-border-bottom-alt:1.0000pt solid windowtext;background:rgb(255,255,255);">
	            <p class="MsoNormal" align=center style="margin-top:0.0000pt;margin-right:0.0000pt;margin-bottom:0.0000pt;
	            margin-left:0.0000pt;mso-pagination:widow-orphan;text-align:center;">
	              <span style="mso-spacerun:'yes';font-family:宋体;letter-spacing:0.0000pt;
	              text-transform:none;font-size:10.5000pt;mso-font-kerning:0.0000pt;">检测结果</span>
	              <span style="font-family:Calibri;mso-fareast-font-family:宋体;font-size:10.5000pt;
	              mso-font-kerning:1.0000pt;">
	              </span>
	            </p>
	          </td>
	          <td  valign=center style="width:75.5000pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none;
	          mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:1.0000pt solid windowtext;
	          border-top:none;mso-border-top-alt:none;border-bottom:1.0000pt solid windowtext;
	          mso-border-bottom-alt:1.0000pt solid windowtext;background:rgb(255,255,255);">
	            <p class="MsoNormal" align=center style="margin-top:0.0000pt;margin-right:0.0000pt;margin-bottom:0.0000pt;
	            margin-left:0.0000pt;mso-pagination:widow-orphan;text-align:center;">
	              <span style="mso-spacerun:'yes';font-family:宋体;letter-spacing:0.0000pt;
	              text-transform:none;font-size:10.5000pt;mso-font-kerning:0.0000pt;">判定结果</span>
	              <span style="font-family:Calibri;mso-fareast-font-family:宋体;font-size:10.5000pt;
	              mso-font-kerning:1.0000pt;">
	              </span>
	            </p>
	          </td>
	        </tr>
	       <c:forEach items="${l.samplingDetailList}"  var="detail" varStatus="index" begin="${(pageNumber.index-1)*pageSize }" end="${pageNumber.index*pageSize-1}"> 
	       <c:set var="serialNumber" value="${serialNumber+1}" />
	       <c:set var="pageSerialNumber" value="${pageSerialNumber+1}" />
	        <tr class="tr-height">
	          <td valign=center style=" padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:1.0000pt solid windowtext;
	          mso-border-left-alt:1.0000pt solid windowtext;border-right:1.0000pt solid windowtext;mso-border-right-alt:1.0000pt solid windowtext;
	          border-top:none;mso-border-top-alt:none;border-bottom:1.0000pt solid windowtext;
	          mso-border-bottom-alt:1.0000pt solid windowtext;background:rgb(255,255,255);">
	            <p class="MsoNormal" align=center style="text-align:center;">
	              <span style="font-family:'宋体';letter-spacing:0.0000pt;text-transform:none;
	              font-size:10.5000pt;mso-font-kerning:1.0000pt;">${serialNumber}
	               </span>
	            </p>
	          </td>
	          <td  valign=center  style="padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none;
	          mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:1.0000pt solid windowtext;
	          border-top:none;mso-border-top-alt:none;border-bottom:1.0000pt solid windowtext;
	          mso-border-bottom-alt:1.0000pt solid windowtext;background:rgb(255,255,255);">
	            <p class="MsoNormal" align=center style="text-align:center;">
	              ${detail.foodName}
	            </p>
	          </td>
	          <td  valign=center style="padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none;
	          mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:1.0000pt solid windowtext;
	          border-top:none;mso-border-top-alt:none;border-bottom:1.0000pt solid windowtext;
	          mso-border-bottom-alt:1.0000pt solid windowtext;background:rgb(255,255,255);">
	            <p class="MsoNormal" align=center style="text-align:center;">
	              <span style="font-family:'宋体';letter-spacing:0.0000pt;text-transform:none;
	              font-size:10.5000pt;mso-font-kerning:1.0000pt;">${detail.itemName}
	                </span>
	            </p>
	          </td>
	          <td valign=center style="padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none;
	          mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:1.0000pt solid windowtext;
	          border-top:none;mso-border-top-alt:none;border-bottom:1.0000pt solid windowtext;
	          mso-border-bottom-alt:1.0000pt solid windowtext;background:rgb(255,255,255);">
	            <p class="MsoNormal" align=center style="text-align:center;">
	              <span style="font-family:'宋体';letter-spacing:0.0000pt;text-transform:none;
	              font-size:10.5000pt;mso-font-kerning:1.0000pt;"><%--${fn:substring(detail.stdCode,0,26)}--%>
					 ${detail.stdCode}
	                </span>
	            </p>
	          </td>
	          <td valign=center style="padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none;
	          mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:1.0000pt solid windowtext;
	          border-top:none;mso-border-top-alt:none;border-bottom:1.0000pt solid windowtext;
	          mso-border-bottom-alt:1.0000pt solid windowtext;background:rgb(255,255,255);">
	            <p class="MsoNormal" align=center style="text-align:center;">
	              <span style="font-family:'宋体';letter-spacing:0.0000pt;text-transform:none;
	              font-size:10.5000pt;mso-font-kerning:1.0000pt;">
					   <%--add by xiaoyl 2022/04/11 检测结果有数值的增加单位组合显示，阴阳性的结果不做处理--%>
<%--					  ${detail.checkResult}<c:if test="${detail.checkResult ne '阳性' && detail.checkResult ne '阴性'}">${detail.checkUnit}</c:if>--%>
					  <c:catch>
						  <fmt:formatNumber value="${detail.checkResult}" pattern="0" var="myCheckResult"/>
						  <c:set var="passed" value="1"/>
					  </c:catch>
					  <c:choose>
						  <c:when test="${passed==1}"><%--有检测值，组合单位显示--%>
							  ${detail.checkResult}${detail.checkUnit}
						  </c:when>
						  <c:otherwise>
							  ${detail.checkResult}
						  </c:otherwise>
					  </c:choose>
				  </span>
	               <%--   <c:if test="${detail.checkResult eq '阳性'}">
	                	<span lang=EN-US style='font-family:"Arial",sans-serif;color:black'> ↑ </span>
		  			</c:if> --%>
	            </p>
	          </td>
	          <td valign=center style="padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none;
	          mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:1.0000pt solid windowtext;
	          border-top:none;mso-border-top-alt:none;border-bottom:1.0000pt solid windowtext;
	          mso-border-bottom-alt:1.0000pt solid windowtext;background:rgb(255,255,255);">
	            <p class="MsoNormal" align=center style="text-align:center;">
	              <span style="font-family:'宋体';letter-spacing:0.0000pt;text-transform:none;
	              font-size:10.5000pt;mso-font-kerning:1.0000pt;">${detail.conclusion}
	                </span>
	            </p>
	          </td>
	        </tr>
	        </c:forEach>
			<c:forEach var="i" begin="${pageSerialNumber+1}" end="${pageSize}">
			   <tr class="tr-height">
		          <td valign=center style="padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:1.0000pt solid windowtext;
		          mso-border-left-alt:1.0000pt solid windowtext;border-right:1.0000pt solid windowtext;mso-border-right-alt:1.0000pt solid windowtext;
		          border-top:none;mso-border-top-alt:none;border-bottom:1.0000pt solid windowtext;
		          mso-border-bottom-alt:1.0000pt solid windowtext;background:rgb(255,255,255);">
		            <p class="MsoNormal" align=center style="text-align:center;">
		              <span style="font-family:'宋体';letter-spacing:0.0000pt;text-transform:none;
		              font-size:10.5000pt;mso-font-kerning:1.0000pt;"> 
		                </span>
		            </p>
		          </td>
		          <td valign=center style="padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none;
		          mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:1.0000pt solid windowtext;
		          border-top:none;mso-border-top-alt:none;border-bottom:1.0000pt solid windowtext;
		          mso-border-bottom-alt:1.0000pt solid windowtext;background:rgb(255,255,255);">
		            <p class="MsoNormal" align=center style="text-align:center;">
		              <span style="font-family:'宋体';letter-spacing:0.0000pt;text-transform:none;
		              font-size:10.5000pt;mso-font-kerning:1.0000pt;"> 
		                </span>
		            </p>
		          </td>
		          <td valign=center style="padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none;
		          mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:1.0000pt solid windowtext;
		          border-top:none;mso-border-top-alt:none;border-bottom:1.0000pt solid windowtext;
		          mso-border-bottom-alt:1.0000pt solid windowtext;background:rgb(255,255,255);">
		            <p class="MsoNormal" align=center style="text-align:center;">
		              <span style="font-family:'宋体';letter-spacing:0.0000pt;text-transform:none;
		              font-size:10.5000pt;mso-font-kerning:1.0000pt;"> 
		                </span>
		            </p>
		          </td>
		          <td valign=center style="padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none;
		          mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:1.0000pt solid windowtext;
		          border-top:none;mso-border-top-alt:none;border-bottom:1.0000pt solid windowtext;
		          mso-border-bottom-alt:1.0000pt solid windowtext;background:rgb(255,255,255);">
		            <p class="MsoNormal" align=center style="text-align:center;">
		              <span style="font-family:'宋体';letter-spacing:0.0000pt;text-transform:none;
		              font-size:10.5000pt;mso-font-kerning:1.0000pt;"> 
		                </span>
		            </p>
		          </td>
		          <td valign=center style="padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none;
		          mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:1.0000pt solid windowtext;
		          border-top:none;mso-border-top-alt:none;border-bottom:1.0000pt solid windowtext;
		          mso-border-bottom-alt:1.0000pt solid windowtext;background:rgb(255,255,255);">
		            <p class="MsoNormal" align=center style="text-align:center;">
		              <span style="font-family:'宋体';letter-spacing:0.0000pt;text-transform:none;
		              font-size:10.5000pt;mso-font-kerning:1.0000pt;"> 
		                </span>
		            </p>
		          </td>
		          <td valign=center style="padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none;
		          mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:1.0000pt solid windowtext;
		          border-top:none;mso-border-top-alt:none;border-bottom:1.0000pt solid windowtext;
		          mso-border-bottom-alt:1.0000pt solid windowtext;background:rgb(255,255,255);">
		            <p class="MsoNormal" align=center style="text-align:center;">
		              <span style="font-family:'宋体';letter-spacing:0.0000pt;text-transform:none;
		              font-size:10.5000pt;mso-font-kerning:1.0000pt;"> 
		                </span>
		            </p>
		          </td>
		        </tr>
				</c:forEach>
			</table>
			<!-- 底部表格开始 -->
			<!-- 底部表格开始 -->
			<table class="MsoNormal"Table border=1 cellspacing=0 style="border-collapse:collapse;width:544.0000pt;margin: 0 auto;
	      border:none;mso-border-left-alt:none;mso-border-top-alt:none;
	      mso-border-right-alt:none;mso-border-bottom-alt:none;mso-border-insideh:0.7500pt outset windowtext;
	      mso-border-insidev:0.7500pt outset windowtext;mso-padding-alt:0.0000pt 0.0000pt 0.0000pt 0.0000pt ;">
				<tr style="height:58.3500pt;">
					<td width=412 valign=center colspan=6 style="width:260.2500pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:1.0000pt solid windowtext;
	          mso-border-left-alt:1.0000pt solid windowtext;border-right:1.0000pt solid windowtext;mso-border-right-alt:1.0000pt solid windowtext;
	          border-top:none;mso-border-top-alt:none;border-bottom:1.0000pt solid windowtext;
	          mso-border-bottom-alt:1.0000pt solid windowtext;background:rgb(255,255,255);">
						<p class="MsoNormal" align=justify style="margin-top:0.0000pt;margin-right:0.0000pt;margin-bottom:0.0000pt;
	            margin-left:0.0000pt;mso-pagination:widow-orphan;text-align:justify;
	            text-justify:inter-ideograph;">
	              <span style="mso-spacerun:'yes';font-family:宋体;letter-spacing:0.0000pt;
	              text-transform:none;font-size:10.5000pt;mso-font-kerning:0.0000pt;">检测：</span>
							<span style="mso-spacerun:'yes';font-family:'宋体';
	              letter-spacing:0.0000pt;text-transform:none;font-size:10.5000pt;
	              mso-font-kerning:0.0000pt;">
	              <c:forEach items="${l.recordings}" var="recording">
					  <c:choose>
						  <c:when test="${!empty recording.checkUserSignature && recording.checkUserSignature ne ''}">
							  <img height="50" width="70"  src="${resourcesUrl}/${recording.checkUserSignature}"/>
						  </c:when>
						  <c:otherwise>
							  ${recording.checkUsername}
						  </c:otherwise>
					  </c:choose>
				  </c:forEach>
			  	</span>
							<span style="font-family:'宋体';mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;
	              mso-bidi-font-family:Calibri;letter-spacing:0.0000pt;text-transform:none;
	              font-size:10.5000pt;mso-font-kerning:0.0000pt;">&nbsp;</span>
							<span style="font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;
	              mso-bidi-font-family:Calibri;font-size:10.5000pt;mso-font-kerning:1.0000pt;">
	                <o:p></o:p>
	              </span>
						</p>
					</td>
					<td width=313 valign=center colspan=4 rowspan=2 style="width:280.2500pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none;
	          mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:1.0000pt solid windowtext;
	          border-top:none;mso-border-top-alt:none;border-bottom:1.0000pt solid windowtext;
	          mso-border-bottom-alt:1.0000pt solid windowtext;background:rgb(255,255,255);position:relative;">
						<p class="MsoNormal" align=justify style="margin-top:0.0000pt;margin-right:0.0000pt;margin-bottom:0.0000pt;
	            margin-left:0.0000pt;mso-pagination:widow-orphan;text-align:justify;
	            text-justify:inter-ideograph;line-height:15.7500pt;">
	              <span style="font-family:Calibri;mso-fareast-font-family:'宋体';letter-spacing:0.0000pt;
	              text-transform:none;font-size:10.5000pt;mso-font-kerning:0.0000pt;">
	                <span style="position:absolute;z-index:1;left:0px;top:0px;
	                margin-left:150.9333px;margin-top:1.9333px;width:151.0000px;
	                height:151.0000px;">
	                 <c:if test="${l.signatureFilePicture!=''}">
						 <img width=151 height=151 src="${webRoot}/${l.signatureFilePicture}" alt="章"/>
					 </c:if>
	                  </span>
	              </span>
							<span style="font-family:Calibri;mso-fareast-font-family:宋体;font-size:10.5000pt;
	              mso-font-kerning:1.0000pt;">
	                <o:p>&nbsp;</o:p></span>
						</p>
						<p class="MsoNormal" align=justify style="margin-top:0.0000pt;margin-right:0.0000pt;margin-bottom:0.0000pt;
	            margin-left:0.0000pt;mso-pagination:widow-orphan;text-align:justify;
	            text-justify:inter-ideograph;line-height:15.7500pt;">
	              <span style="mso-spacerun:'yes';font-family:宋体;letter-spacing:0.0000pt;
	              text-transform:none;font-size:10.5000pt;mso-font-kerning:0.0000pt;">检测机构：常德市武陵区食品药品检验所</span>
							<span style="font-family:Calibri;mso-fareast-font-family:'宋体';letter-spacing:0.0000pt;
	              text-transform:none;font-size:10.5000pt;mso-font-kerning:0.0000pt;">
	                <o:p></o:p>
	              </span>
						</p>
						<p class="MsoNormal" align=justify style="margin-top:0.0000pt;margin-right:0.0000pt;margin-bottom:0.0000pt;
	            margin-left:0.0000pt;mso-pagination:widow-orphan;text-align:justify;
	            text-justify:inter-ideograph;line-height:15.7500pt;">
	              <span style="font-family:Calibri;mso-fareast-font-family:'宋体';letter-spacing:0.0000pt;
	              text-transform:none;font-size:10.5000pt;mso-font-kerning:0.0000pt;">
	                <o:p>&nbsp;</o:p></span>
						</p>
						<p class="MsoNormal" align=justify style="margin-top:0.0000pt;margin-right:0.0000pt;margin-bottom:0.0000pt;
	            margin-left:0.0000pt;mso-pagination:widow-orphan;text-align:justify;
	            text-justify:inter-ideograph;line-height:15.7500pt;">
	              <span style="font-family:Calibri;mso-fareast-font-family:'宋体';letter-spacing:0.0000pt;
	              text-transform:none;font-size:10.5000pt;mso-font-kerning:0.0000pt;">
	                <o:p>&nbsp;</o:p></span>
						</p>
						<p class="MsoNormal" align=justify style="margin-top:0.0000pt;margin-right:0.0000pt;margin-bottom:0.0000pt;
	            margin-left:0.0000pt;mso-pagination:widow-orphan;text-align:justify;
	            text-justify:inter-ideograph;line-height:15.7500pt;">
	              <span style="mso-spacerun:'yes';font-family:宋体;letter-spacing:0.0000pt;
	              text-transform:none;font-size:10.5000pt;mso-font-kerning:0.0000pt;">检测日期：</span>
							<span style="font-family:'宋体';mso-fareast-font-family:宋体;font-size:10.5000pt;
	              mso-font-kerning:1.0000pt;">
	                <c:if test="${fn:length(l.recordings) > 0}">
						<fmt:formatDate value="${l.recordings[0].uploadDate}" pattern="yyyy-MM-dd"/>
					</c:if>
	              </span>
						</p>
					</td>
				</tr>
				<tr style="height:57.3500pt;">
					<td width=412 valign=center colspan=6 style="width:260.2500pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:1.0000pt solid windowtext;
	          mso-border-left-alt:1.0000pt solid windowtext;border-right:1.0000pt solid windowtext;mso-border-right-alt:1.0000pt solid windowtext;
	          border-top:none;mso-border-top-alt:none;border-bottom:1.0000pt solid windowtext;
	          mso-border-bottom-alt:1.0000pt solid windowtext;background:rgb(255,255,255);">
						<p class="MsoNormal" align=justify style="margin-top:0.0000pt;margin-right:0.0000pt;margin-bottom:0.0000pt;
	            margin-left:0.0000pt;mso-pagination:widow-orphan;text-align:justify;
	            text-justify:inter-ideograph;line-height:15.7500pt;">
	              <span style="mso-spacerun:'yes';font-family:宋体;letter-spacing:0.0000pt;
	              text-transform:none;font-size:10.5000pt;mso-font-kerning:0.0000pt;">复核：
					  <c:choose>
						  <c:when test="${fn:contains(l.sampling.reviewSignature,'/' )}">
							  <img height="50" width="70"  src="${resourcesUrl}/${l.sampling.reviewSignature}"/>
						  </c:when>
						  <c:otherwise>${l.sampling.reviewSignature}</c:otherwise>
					  </c:choose>
					  &nbsp;&nbsp;&nbsp;&nbsp;
					  批准：
					  <c:choose>
						  <c:when test="${fn:contains(l.sampling.approvalSignature,'/' )}">
							  <img height="50" width="70"  src="${resourcesUrl}/${l.sampling.approvalSignature}"/>
						  </c:when>
						  <c:otherwise>${l.sampling.approvalSignature}</c:otherwise>
					  </c:choose>
				  </span>
							<span style="font-family:Calibri;mso-fareast-font-family:宋体;font-size:10.5000pt;
	              mso-font-kerning:1.0000pt;">
	                <o:p></o:p>
	              </span>
						</p>
					</td>
				</tr>
				<tr style="height:28.5000pt;">
					<td width=726 valign=center colspan=10 style="width:544.5000pt;padding:0.0000pt 0.0000pt 0.0000pt 0.0000pt ;border-left:none;
	          mso-border-left-alt:none;border-right:none;mso-border-right-alt:none;
	          border-top:none;mso-border-top-alt:none;border-bottom:none;
	          mso-border-bottom-alt:none;background:rgb(255,255,255);">
						<p class="MsoNormal" align=justify style="margin-top:0.0000pt;margin-right:0.0000pt;margin-bottom:0.0000pt;
	            margin-left:0.0000pt;mso-pagination:widow-orphan;text-align:justify;
	            text-justify:inter-ideograph;">
	              <span style="mso-spacerun:'yes';font-family:宋体;letter-spacing:0.0000pt;
	              text-transform:none;font-size:10.5000pt;mso-font-kerning:0.0000pt;">注：此检验报告仅对本次样品负责。</span>
							<span style="font-family:Calibri;mso-fareast-font-family:宋体;font-size:10.5000pt;
	              mso-font-kerning:1.0000pt;">
	                <o:p></o:p>
	              </span>
						</p>
					</td>
				</tr>
			</table>
	      <p class="MsoNormal">
	        <span style="mso-spacerun:'yes';font-family:Calibri;mso-fareast-font-family:宋体;
	        mso-bidi-font-family:'Times New Roman';font-size:10.5000pt;mso-font-kerning:1.0000pt;">
	          <o:p>&nbsp;</o:p></span>
	      </p>
	    </div>
	</c:when>
	<c:otherwise><!-- 抽样单检测报告 -->
	   <div class="Section0_${pageNumber.index}" style="layout-grid:15.6000pt; padding-top:20px;height: 1050px;">
	     <%-- <p class="MsoNormal" align=center style="margin-top:0.0000pt;margin-right:0.0000pt;margin-bottom:0.0000pt;
	      margin-left:0.0000pt;padding:0pt 0pt 0pt 0pt ;mso-pagination:widow-orphan;
	      text-align:center;">
	        <b>
	          <span style="mso-spacerun:'yes';font-family:宋体;letter-spacing:0.0000pt;
	          font-weight:bold;text-transform:none;font-size:16.0000pt;
	          mso-font-kerning:0.0000pt;">
	            <font face="宋体">常德市武陵区市场监督管理局</font></span>
	        </b>
	        <b>
	          <span style="mso-spacerun:'yes';font-family:宋体;letter-spacing:0.0000pt;
	          font-weight:bold;text-transform:none;font-size:16.0000pt;
	          mso-font-kerning:0.0000pt;">
	            <o:p></o:p>
	          </span>
	        </b>
	      </p>--%>
	      <!-- 头部表格开始 -->
	      <table class="MsoNormal"Table border=1 cellspacing=0 style="border-collapse:collapse;width:544.000pt;margin: 0 auto;
	      border:none;mso-border-left-alt:none;mso-border-top-alt:none;
	      mso-border-right-alt:none;mso-border-bottom-alt:none;mso-border-insideh:0.7500pt outset windowtext;
	      mso-border-insidev:0.7500pt outset windowtext;mso-padding-alt:0.0000pt 0.0000pt 0.0000pt 0.0000pt ;">
	        <tr style="height:27.1000pt;">
	          <td width=726 valign=top colspan=10 style="width:544.5000pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none;
	          mso-border-left-alt:none;border-right:none;mso-border-right-alt:none;
	          border-top:none;mso-border-top-alt:none;border-bottom:none;
	          mso-border-bottom-alt:none;background:rgb(255,255,255);">
	            <p class="MsoNormal" align=center style="margin-top:0.0000pt;margin-right:0.0000pt;margin-bottom:0.0000pt;
	            margin-left:0.0000pt;mso-pagination:widow-orphan;text-align:center;">
	              <b>
	                <span style="mso-spacerun:'yes';font-family:宋体;letter-spacing:0.0000pt;
	                font-weight:bold;text-transform:none;font-size:16.0000pt;
	                mso-font-kerning:0.0000pt;">食用农产品快速检验报告</span>
	              </b>
	              <span style="font-family:Calibri;mso-fareast-font-family:宋体;font-size:10.5000pt;
	              mso-font-kerning:1.0000pt;">
	                <o:p></o:p>
	              </span>
	            </p>
	          </td>
	        </tr>
	        <tr style="height:16.2500pt;">
	          <td width=403 valign=bottom colspan=5 style="width:302.2500pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none;
	          mso-border-left-alt:none;border-right:none;mso-border-right-alt:none;
	          border-top:none;mso-border-top-alt:none;border-bottom:1.0000pt solid windowtext;
	          mso-border-bottom-alt:1.0000pt solid windowtext;background:rgb(255,255,255);">
	            <p class="MsoNormal" style="margin-top:0.0000pt;margin-right:0.0000pt;margin-bottom:0.0000pt;
	            margin-left:0.0000pt;mso-pagination:widow-orphan;text-align:left;">
	              <span style="mso-spacerun:'yes';font-family:宋体;letter-spacing:0.0000pt;
	              text-transform:none;font-size:10.5000pt;mso-font-kerning:0.0000pt;">抽样时间：</span>
	              <span style="mso-spacerun:'yes';font-family:Calibri;mso-fareast-font-family:'宋体';
	              letter-spacing:0.0000pt;text-transform:none;font-size:10.5000pt;
	              mso-font-kerning:0.0000pt;"><fmt:formatDate value="${l.sampling.samplingDate}" pattern="yyyy-MM-dd HH:mm:ss"/></span>
	              <span style="font-family:'宋体';mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;
	              mso-bidi-font-family:Calibri;letter-spacing:0.0000pt;text-transform:none;
	              font-size:10.5000pt;mso-font-kerning:0.0000pt;"></span>
	              <span style="mso-spacerun:'yes';font-family:Calibri;mso-fareast-font-family:'宋体';
	              letter-spacing:0.0000pt;text-transform:none;font-size:10.5000pt;
	              mso-font-kerning:0.0000pt;"></span>
	              <span style="font-family:Calibri;mso-fareast-font-family:宋体;font-size:10.5000pt;
	              mso-font-kerning:1.0000pt;">
	                <o:p></o:p>
	              </span>
	            </p>
	          </td>
	          <td width=323 valign=bottom colspan=5 style="width:242.2500pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none;
	          mso-border-left-alt:none;border-right:none;mso-border-right-alt:none;
	          border-top:none;mso-border-top-alt:none;border-bottom:1.0000pt solid windowtext;
	          mso-border-bottom-alt:1.0000pt solid windowtext;background:rgb(255,255,255);">
	            <p class="MsoNormal" align=justify style="margin-top:0.0000pt;margin-right:0.0000pt;margin-bottom:0.0000pt;
	            margin-left:0.0000pt;text-indent:42.0000pt;mso-char-indent-count:4.0000;
	            mso-pagination:widow-orphan;text-align:right;text-justify:inter-ideograph;">
	              <span style="mso-spacerun:'yes';font-family:宋体;letter-spacing:0.0000pt;
	              text-transform:none;font-size:10.5000pt;mso-font-kerning:0.0000pt;">单号：</span>
	              <span style="mso-spacerun:'yes';font-family:Calibri;mso-fareast-font-family:'宋体';
	              letter-spacing:0.0000pt;text-transform:none;font-size:10.5000pt;
	              mso-font-kerning:0.0000pt;">${l.sampling.samplingNo}</span>
	              <span style="font-family:Calibri;mso-fareast-font-family:宋体;font-size:10.5000pt;
	              mso-font-kerning:1.0000pt;">
	                <o:p></o:p>
	              </span>
	            </p>
	          </td>
	        </tr>
		  </table>
		  <table class="MsoNormal"Table border=1 cellspacing=0 style="border-collapse:collapse;width:544.000pt;margin: 0 auto;
	      border:none;mso-border-left-alt:none;mso-border-top-alt:none;
	      mso-border-right-alt:none;mso-border-bottom-alt:none;mso-border-insideh:0.7500pt outset windowtext;
	      mso-border-insidev:0.7500pt outset windowtext;mso-padding-alt:0.0000pt 0.0000pt 0.0000pt 0.0000pt ;">
	        <tr style="height:25.2000pt;">
	          <td width=124 valign=center colspan=2 style="width:146.1500pt;border-left:1.0000pt solid windowtext;
	          mso-border-left-alt:1.0000pt solid windowtext;border-right:1.0000pt solid windowtext;mso-border-right-alt:1.0000pt solid windowtext;
	          border-top:none;mso-border-top-alt:none;border-bottom:1.0000pt solid windowtext;
	          mso-border-bottom-alt:1.0000pt solid windowtext;background:rgb(255,255,255);">
	            <p class="MsoNormal" align=center style="margin-top:0.0000pt;margin-right:0.0000pt;margin-bottom:0.0000pt;
	            margin-left:0.0000pt;mso-pagination:widow-orphan;text-align:center;">
	              <span style="mso-spacerun:'yes';font-family:宋体;letter-spacing:0.0000pt;
	              text-transform:none;font-size:10.5000pt;mso-font-kerning:0.0000pt;">被检单位（个人）</span>
	              <span style="font-family:Calibri;mso-fareast-font-family:宋体;font-size:10.5000pt;
	              mso-font-kerning:1.0000pt;">
	                <o:p></o:p>
	              </span>
	            </p>
	          </td>
	          <td width=467 valign=center colspan=6 style="width:350.9000pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none;
	          mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:1.0000pt solid windowtext;
	          border-top:none;mso-border-top-alt:none;border-bottom:1.0000pt solid windowtext;
	          mso-border-bottom-alt:1.0000pt solid windowtext;background:rgb(255,255,255);">
	            <p class="MsoNormal" style="margin-top:0.0000pt;margin-right:0.0000pt;margin-bottom:0.0000pt;
	            margin-left:0.0000pt;mso-pagination:widow-orphan;text-align:left;">
	              <span style="mso-spacerun:'yes';font-family:宋体;letter-spacing:0.0000pt;
	              text-transform:none;font-size:10.5000pt;mso-font-kerning:0.0000pt;">${l.sampling.regName}</span>
	              <span style="font-family:Calibri;mso-fareast-font-family:宋体;font-size:10.5000pt;
	              mso-font-kerning:1.0000pt;">
	                <o:p></o:p>
	              </span>
	            </p>
	          </td>
	          <td width=133 valign=center colspan=2 rowspan=4 style="width:100.4500pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none;
	          mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:1.0000pt solid windowtext;
	          border-top:none;mso-border-top-alt:none;border-bottom:1.0000pt solid windowtext;
	          mso-border-bottom-alt:1.0000pt solid windowtext;background:rgb(255,255,255);">
	            <p class="MsoNormal" align=center style="height: 95px;margin-top:0.0000pt;margin-right:0.0000pt;margin-bottom:0.0000pt;
	            margin-left:0.0000pt;mso-pagination:widow-orphan;text-align:center;">
	              <span style="font-family:Calibri;mso-fareast-font-family:'宋体';letter-spacing:0.0000pt;
	              text-transform:none;font-size:10.5000pt;mso-font-kerning:0.0000pt;">
	                <img width="103" height="99" src="${webRoot}/resources/${l.samplingQr}"></span>
	              <span style="font-family:Calibri;mso-fareast-font-family:宋体;font-size:10.5000pt;
	              mso-font-kerning:1.0000pt;">
	                </span>
	            </p>
	            <p class="MsoNormal" align=center style="margin-top:0.0000pt;margin-right:0.0000pt;margin-bottom:0.0000pt;
	            margin-left:0.0000pt;mso-pagination:widow-orphan;text-align:center;">
	              <span style="mso-spacerun:'yes';font-family:宋体;letter-spacing:0.0000pt;
	              text-transform:none;font-size:10.5000pt;mso-font-kerning:0.0000pt;">（查询二维码）</span>
	              <span style="font-family:Calibri;mso-fareast-font-family:宋体;font-size:10.5000pt;
	              mso-font-kerning:1.0000pt;"></span>
	            </p>
	          </td>
	        </tr>
	        <tr style="height:25.2000pt;">
	          <td width=124 valign=center colspan=2 style="width:93.1500pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:1.0000pt solid windowtext;
	          mso-border-left-alt:1.0000pt solid windowtext;border-right:1.0000pt solid windowtext;mso-border-right-alt:1.0000pt solid windowtext;
	          border-top:none;mso-border-top-alt:none;border-bottom:1.0000pt solid windowtext;
	          mso-border-bottom-alt:1.0000pt solid windowtext;background:rgb(255,255,255);">
	            <p class="MsoNormal" align=center style="margin-top:0.0000pt;margin-right:0.0000pt;margin-bottom:0.0000pt;
	            margin-left:0.0000pt;mso-pagination:widow-orphan;text-align:center;">
	              <span style="mso-spacerun:'yes';font-family:宋体;letter-spacing:0.0000pt;
	              text-transform:none;font-size:10.5000pt;mso-font-kerning:0.0000pt;">
					   <c:choose>
						   <c:when test="${systemFlag==1}">
							   摊位名称
						   </c:when>
						   <c:otherwise>
							   经营户名称
						   </c:otherwise>
					   </c:choose>
				  </span>
	              <span style="font-family:Calibri;mso-fareast-font-family:宋体;font-size:10.5000pt;
	              mso-font-kerning:1.0000pt;">
	              </span>
	            </p>
	          </td>
	          <td width=467 valign=center colspan=6 style="width:350.9000pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none;
	          mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:1.0000pt solid windowtext;
	          border-top:none;mso-border-top-alt:none;border-bottom:1.0000pt solid windowtext;
	          mso-border-bottom-alt:1.0000pt solid windowtext;background:rgb(255,255,255);">
	            <p class="MsoNormal" style="margin-top:0.0000pt;margin-right:0.0000pt;margin-bottom:0.0000pt;
	            margin-left:0.0000pt;mso-pagination:widow-orphan;text-align:left;">
	              <span style="mso-spacerun:'yes';font-family:宋体;letter-spacing:0.0000pt;
	              text-transform:none;font-size:10.5000pt;mso-font-kerning:0.0000pt;">${l.sampling.opeShopName}</span>
	              <span style="font-family:Calibri;mso-fareast-font-family:宋体;font-size:10.5000pt;
	              mso-font-kerning:1.0000pt;">
	              </span>
	            </p>
	          </td>
	        </tr>
	        <tr style="height:25.2000pt;">
	          <td width=124 valign=center colspan=2 style="width:93.1500pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:1.0000pt solid windowtext;
	          mso-border-left-alt:1.0000pt solid windowtext;border-right:1.0000pt solid windowtext;mso-border-right-alt:1.0000pt solid windowtext;
	          border-top:none;mso-border-top-alt:none;border-bottom:1.0000pt solid windowtext;
	          mso-border-bottom-alt:1.0000pt solid windowtext;background:rgb(255,255,255);">
	            <p class="MsoNormal" align=center style="margin-top:0.0000pt;margin-right:0.0000pt;margin-bottom:0.0000pt;
	            margin-left:0.0000pt;mso-pagination:widow-orphan;text-align:center;">
	              <span style="mso-spacerun:'yes';font-family:宋体;letter-spacing:0.0000pt;
	              text-transform:none;font-size:10.5000pt;mso-font-kerning:0.0000pt;">
					  <c:choose>
						  <c:when test="${systemFlag==1}">
							  摊位编号
						  </c:when>
						  <c:otherwise>
							  档口编号
						  </c:otherwise>
					  </c:choose>
				  </span>
	              <span style="font-family:Calibri;mso-fareast-font-family:宋体;font-size:10.5000pt;
	              mso-font-kerning:1.0000pt;">
	              </span>
	            </p>
	          </td>
	          <td width=188 valign=center colspan=2 style="width:141.6500pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none;
	          mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:1.0000pt solid windowtext;
	          border-top:none;mso-border-top-alt:none;border-bottom:1.0000pt solid windowtext;
	          mso-border-bottom-alt:1.0000pt solid windowtext;background:rgb(255,255,255);">
	            <p class="MsoNormal" style="margin-top:0.0000pt;margin-right:0.0000pt;margin-bottom:0.0000pt;
	            margin-left:0.0000pt;mso-pagination:widow-orphan;text-align:left;">
	              <span style="mso-spacerun:'yes';font-family:'宋体';mso-fareast-font-family:'宋体';
	              letter-spacing:0.0000pt;text-transform:none;font-size:10.5000pt;
	              mso-font-kerning:0.0000pt;">${l.sampling.opeShopCode}</span>
	              <span style="font-family:Calibri;mso-fareast-font-family:宋体;font-size:10.5000pt;
	              mso-font-kerning:1.0000pt;">
	              </span>
	            </p>
	          </td>
	          <td width=99 valign=center colspan=2 style="width:74.4500pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none;
	          mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:1.0000pt solid windowtext;
	          border-top:none;mso-border-top-alt:none;border-bottom:1.0000pt solid windowtext;
	          mso-border-bottom-alt:1.0000pt solid windowtext;background:rgb(255,255,255);">
	            <p class="MsoNormal" align=center style="margin-top:0.0000pt;margin-right:0.0000pt;margin-bottom:0.0000pt;
	            margin-left:0.0000pt;mso-pagination:widow-orphan;text-align:center;">
	              <span style="mso-spacerun:'yes';font-family:宋体;letter-spacing:0.0000pt;
	              text-transform:none;font-size:10.5000pt;mso-font-kerning:0.0000pt;">证照号码</span>
	              <span style="font-family:Calibri;mso-fareast-font-family:宋体;font-size:10.5000pt;
	              mso-font-kerning:1.0000pt;">
	              </span>
	            </p>
	          </td>
	          <td width=179 valign=center colspan=2 style="width:134.8000pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none;
	          mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:1.0000pt solid windowtext;
	          border-top:none;mso-border-top-alt:none;border-bottom:1.0000pt solid windowtext;
	          mso-border-bottom-alt:1.0000pt solid windowtext;background:rgb(255,255,255);">
	            <p class="MsoNormal" align=center style="text-align:center;">
	              <span style="font-family:'宋体';letter-spacing:0.0000pt;text-transform:none;
	              font-size:10.5000pt;mso-font-kerning:1.0000pt;">${l.sampling.regLicence}
	                </span>
	            </p>
	          </td>
	        </tr>
	        <tr style="height:25.2000pt;">
	          <td width=124 valign=center colspan=2 style="width:93.1500pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:1.0000pt solid windowtext;
	          mso-border-left-alt:1.0000pt solid windowtext;border-right:1.0000pt solid windowtext;mso-border-right-alt:1.0000pt solid windowtext;
	          border-top:none;mso-border-top-alt:none;border-bottom:1.0000pt solid windowtext;
	          mso-border-bottom-alt:1.0000pt solid windowtext;background:rgb(255,255,255);">
	            <p class="MsoNormal" align=center style="margin-top:0.0000pt;margin-right:0.0000pt;margin-bottom:0.0000pt;
	            margin-left:0.0000pt;mso-pagination:widow-orphan;text-align:center;">
	              <span style="mso-spacerun:'yes';font-family:宋体;letter-spacing:0.0000pt;
	              text-transform:none;font-size:10.5000pt;mso-font-kerning:0.0000pt;">经营者</span>
	              <span style="font-family:Calibri;mso-fareast-font-family:宋体;font-size:10.5000pt;
	              mso-font-kerning:1.0000pt;">
	              </span>
	            </p>
	          </td>
	          <td width=188 valign=center colspan=2 style="width:141.6500pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none;
	          mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:1.0000pt solid windowtext;
	          border-top:none;mso-border-top-alt:none;border-bottom:1.0000pt solid windowtext;
	          mso-border-bottom-alt:1.0000pt solid windowtext;background:rgb(255,255,255);">
	            <p class="MsoNormal" align=justify style="margin-top:0.0000pt;margin-right:0.0000pt;margin-bottom:0.0000pt;
	            margin-left:0.0000pt;mso-pagination:widow-orphan;text-align:justify;
	            text-justify:inter-ideograph;">
	              <span style="mso-spacerun:'yes';font-family:宋体;letter-spacing:0.0000pt;
	              text-transform:none;font-size:10.5000pt;mso-font-kerning:0.0000pt;">${l.sampling.opeName}</span>
	              <span style="font-family:Calibri;mso-fareast-font-family:宋体;font-size:10.5000pt;
	              mso-font-kerning:1.0000pt;">
	              </span>
	            </p>
	          </td>
	          <td width=99 valign=center colspan=2 style="width:74.4500pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none;
	          mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:1.0000pt solid windowtext;
	          border-top:none;mso-border-top-alt:none;border-bottom:1.0000pt solid windowtext;
	          mso-border-bottom-alt:1.0000pt solid windowtext;background:rgb(255,255,255);">
	            <p class="MsoNormal" align=center style="margin-top:0.0000pt;margin-right:0.0000pt;margin-bottom:0.0000pt;
	            margin-left:0.0000pt;mso-pagination:widow-orphan;text-align:center;">
	              <span style="mso-spacerun:'yes';font-family:宋体;letter-spacing:0.0000pt;
	              text-transform:none;font-size:10.5000pt;mso-font-kerning:0.0000pt;">联系电话</span>
	              <span style="font-family:Calibri;mso-fareast-font-family:宋体;font-size:10.5000pt;
	              mso-font-kerning:1.0000pt;">
	              </span>
	            </p>
	          </td>
	          <td width=179 valign=center colspan=2 style="width:134.8000pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none;
	          mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:1.0000pt solid windowtext;
	          border-top:none;mso-border-top-alt:none;border-bottom:1.0000pt solid windowtext;
	          mso-border-bottom-alt:1.0000pt solid windowtext;background:rgb(255,255,255);">
	            <p class="MsoNormal" style="margin-top:0.0000pt;margin-right:0.0000pt;margin-bottom:0.0000pt;
	            margin-left:0.0000pt;mso-pagination:widow-orphan;text-align:left;">
	              <span style="mso-spacerun:'yes';font-family:宋体;mso-fareast-font-family:'宋体';
	              letter-spacing:0.0000pt;text-transform:none;font-size:10.5000pt;
	              mso-font-kerning:0.0000pt;">${l.sampling.opePhone}</span>
	              <span style="font-family:Calibri;mso-fareast-font-family:宋体;font-size:10.5000pt;
	              mso-font-kerning:1.0000pt;">
	              </span>
	            </p>
	          </td>
	        </tr>
	        
	        </table>
	       <!-- 正文内容开始 -->
	        <table class="MsoNormal"Table border=1 cellspacing=0 style="border-collapse:collapse;width:544.0000pt;margin: 0 auto;
	      border:none;mso-border-left-alt:none;mso-border-top-alt:none;
	      mso-border-right-alt:none;mso-border-bottom-alt:none;mso-border-insideh:0.7500pt outset windowtext;
	      mso-border-insidev:0.7500pt outset windowtext;mso-padding-alt:0.0000pt 0.0000pt 0.0000pt 0.0000pt ;">
	        
	        <tr style="height:21.9500pt;">
	          <td width=726 valign=center colspan=10 style="width:544.5000pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:1.0000pt solid windowtext;
	          mso-border-left-alt:1.0000pt solid windowtext;border-right:1.0000pt solid windowtext;mso-border-right-alt:1.0000pt solid windowtext;
	          border-top:none;mso-border-top-alt:none;border-bottom:1.0000pt solid windowtext;
	          mso-border-bottom-alt:1.0000pt solid windowtext;background:rgb(191,191,191);">
	            <p class="MsoNormal" align=center style="margin-top:0.0000pt;margin-right:0.0000pt;margin-bottom:0.0000pt;
	            margin-left:0.0000pt;mso-pagination:widow-orphan;text-align:center;">
	              <span style="mso-spacerun:'yes';font-family:宋体;letter-spacing:0.0000pt;
	              text-transform:none;font-size:12.0000pt;mso-font-kerning:0.0000pt;">检测信息</span>
	              <span style="font-family:Calibri;mso-fareast-font-family:宋体;font-size:12.0000pt;
	              mso-font-kerning:1.0000pt;">
	              </span>
	            </p>
	          </td>
	        </tr>
	        <tr style="height:31.4500pt;">
	          <td  valign=center style="width:34.0500pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:1.0000pt solid windowtext;
	          mso-border-left-alt:1.0000pt solid windowtext;border-right:1.0000pt solid windowtext;mso-border-right-alt:1.0000pt solid windowtext;
	          border-top:none;mso-border-top-alt:none;border-bottom:1.0000pt solid windowtext;
	          mso-border-bottom-alt:1.0000pt solid windowtext;background:rgb(255,255,255);">
	            <p class="MsoNormal" align=center style="margin-top:0.0000pt;margin-right:0.0000pt;margin-bottom:0.0000pt;
	            margin-left:0.0000pt;mso-pagination:widow-orphan;text-align:center;">
	              <span style="mso-spacerun:'yes';font-family:宋体;letter-spacing:0.0000pt;
	              text-transform:none;font-size:10.5000pt;mso-font-kerning:0.0000pt;">编号</span>
	              <span style="font-family:Calibri;mso-fareast-font-family:宋体;font-size:10.5000pt;
	              mso-font-kerning:1.0000pt;">
	              </span>
	            </p>
	          </td>
	          <td valign=center style="width:100.25pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none;
	          mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:1.0000pt solid windowtext;
	          border-top:none;mso-border-top-alt:none;border-bottom:1.0000pt solid windowtext;
	          mso-border-bottom-alt:1.0000pt solid windowtext;background:rgb(255,255,255);">
	            <p class="MsoNormal" align=center style="margin-top:0.0000pt;margin-right:0.0000pt;margin-bottom:0.0000pt;
	            margin-left:0.0000pt;mso-pagination:widow-orphan;text-align:center;">
	              <span style="mso-spacerun:'yes';font-family:宋体;letter-spacing:0.0000pt;
	              text-transform:none;font-size:10.5000pt;mso-font-kerning:0.0000pt;">样品名称</span>
	              <span style="font-family:Calibri;mso-fareast-font-family:宋体;font-size:10.5000pt;
	              mso-font-kerning:1.0000pt;">
	              </span>
	            </p>
	          </td>
	          <td  valign=center style="width:127.5pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none;
	          mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:1.0000pt solid windowtext;
	          border-top:none;mso-border-top-alt:none;border-bottom:1.0000pt solid windowtext;
	          mso-border-bottom-alt:1.0000pt solid windowtext;background:rgb(255,255,255);">
	            <p class="MsoNormal" align=center style="margin-top:0.0000pt;margin-right:0.0000pt;margin-bottom:0.0000pt;
	            margin-left:0.0000pt;mso-pagination:widow-orphan;text-align:center;">
	              <span style="mso-spacerun:'yes';font-family:宋体;letter-spacing:0.0000pt;
	              text-transform:none;font-size:10.5000pt;mso-font-kerning:0.0000pt;">检测项目</span>
	              <span style="font-family:Calibri;mso-fareast-font-family:宋体;font-size:10.5000pt;
	              mso-font-kerning:1.0000pt;">
	              </span>
	            </p>
	          </td>
	          <td valign=center style="width:155.75pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none;
	          mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:1.0000pt solid windowtext;
	          border-top:none;mso-border-top-alt:none;border-bottom:1.0000pt solid windowtext;
	          mso-border-bottom-alt:1.0000pt solid windowtext;background:rgb(255,255,255);">
	            <p class="MsoNormal" align=center style="margin-top:0.0000pt;margin-right:0.0000pt;margin-bottom:0.0000pt;
	            margin-left:0.0000pt;mso-pagination:widow-orphan;text-align:center;">
	              <span style="mso-spacerun:'yes';font-family:宋体;letter-spacing:0.0000pt;
	              text-transform:none;font-size:10.5000pt;mso-font-kerning:0.0000pt;">判定标准</span>
	              <span style="font-family:Calibri;mso-fareast-font-family:宋体;font-size:10.5000pt;
	              mso-font-kerning:1.0000pt;">
	              </span>
	            </p>
	          </td>
	          <td valign=center style="width: 65pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none;
	          mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:1.0000pt solid windowtext;
	          border-top:none;mso-border-top-alt:none;border-bottom:1.0000pt solid windowtext;
	          mso-border-bottom-alt:1.0000pt solid windowtext;background:rgb(255,255,255);">
	            <p class="MsoNormal" align=center style="margin-top:0.0000pt;margin-right:0.0000pt;margin-bottom:0.0000pt;
	            margin-left:0.0000pt;mso-pagination:widow-orphan;text-align:center;">
	              <span style="mso-spacerun:'yes';font-family:宋体;letter-spacing:0.0000pt;
	              text-transform:none;font-size:10.5000pt;mso-font-kerning:0.0000pt;">检测结果</span>
	              <span style="font-family:Calibri;mso-fareast-font-family:宋体;font-size:10.5000pt;
	              mso-font-kerning:1.0000pt;">
	              </span>
	            </p>
	          </td>
	          <td valign=center style="width:75.5000pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none;
	          mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:1.0000pt solid windowtext;
	          border-top:none;mso-border-top-alt:none;border-bottom:1.0000pt solid windowtext;
	          mso-border-bottom-alt:1.0000pt solid windowtext;background:rgb(255,255,255);">
	            <p class="MsoNormal" align=center style="margin-top:0.0000pt;margin-right:0.0000pt;margin-bottom:0.0000pt;
	            margin-left:0.0000pt;mso-pagination:widow-orphan;text-align:center;">
	              <span style="mso-spacerun:'yes';font-family:宋体;letter-spacing:0.0000pt;
	              text-transform:none;font-size:10.5000pt;mso-font-kerning:0.0000pt;">判定结果</span>
	              <span style="font-family:Calibri;mso-fareast-font-family:宋体;font-size:10.5000pt;
	              mso-font-kerning:1.0000pt;">
	              </span>
	            </p>
	          </td>
	        </tr>
	       <c:forEach items="${l.samplingDetailList}"  var="detail" varStatus="index" begin="${(pageNumber.index-1)*pageSize }" end="${pageNumber.index*pageSize-1}"> 
	       <c:set var="serialNumber" value="${serialNumber+1}" />
	       <c:set var="pageSerialNumber" value="${pageSerialNumber+1}" />
	        <tr class="tr-height">
	          <td valign=center style="padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:1.0000pt solid windowtext;
	          mso-border-left-alt:1.0000pt solid windowtext;border-right:1.0000pt solid windowtext;mso-border-right-alt:1.0000pt solid windowtext;
	          border-top:none;mso-border-top-alt:none;border-bottom:1.0000pt solid windowtext;
	          mso-border-bottom-alt:1.0000pt solid windowtext;background:rgb(255,255,255);">
	            <p class="MsoNormal" align=center style="text-align:center;">
	              <span style="font-family:'宋体';letter-spacing:0.0000pt;text-transform:none;
	              font-size:10.5000pt;mso-font-kerning:1.0000pt;">${serialNumber}
	               </span>
	            </p>
	          </td>
	          <td valign=center style="padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none;
	          mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:1.0000pt solid windowtext;
	          border-top:none;mso-border-top-alt:none;border-bottom:1.0000pt solid windowtext;
	          mso-border-bottom-alt:1.0000pt solid windowtext;background:rgb(255,255,255);">
	            <p class="MsoNormal" align=center style="text-align:center;">
	              ${detail.foodName}
	            </p>
	          </td>
	          <td valign=center style="padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none;
	          mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:1.0000pt solid windowtext;
	          border-top:none;mso-border-top-alt:none;border-bottom:1.0000pt solid windowtext;
	          mso-border-bottom-alt:1.0000pt solid windowtext;background:rgb(255,255,255);">
	            <p class="MsoNormal" align=center style="text-align:center;">
	              <span style="font-family:'宋体';letter-spacing:0.0000pt;text-transform:none;
	              font-size:10.5000pt;mso-font-kerning:1.0000pt;">${detail.itemName}
	                </span>
	            </p>
	          </td>
	          <td valign=center style="padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none;
	          mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:1.0000pt solid windowtext;
	          border-top:none;mso-border-top-alt:none;border-bottom:1.0000pt solid windowtext;
	          mso-border-bottom-alt:1.0000pt solid windowtext;background:rgb(255,255,255);">
	            <p class="MsoNormal" align=center style="text-align:center;">
	              <span style="font-family:'宋体';letter-spacing:0.0000pt;text-transform:none;
	              font-size:10.5000pt;mso-font-kerning:1.0000pt;"><%--${fn:substring(detail.stdCode,0,26)}--%>
					  ${detail.stdCode}
	                </span>
	            </p>
	          </td>
	          <td valign=center style="padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none;
	          mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:1.0000pt solid windowtext;
	          border-top:none;mso-border-top-alt:none;border-bottom:1.0000pt solid windowtext;
	          mso-border-bottom-alt:1.0000pt solid windowtext;background:rgb(255,255,255);">
	            <p class="MsoNormal" align=center style="text-align:center;">
	              <span style="font-family:'宋体';letter-spacing:0.0000pt;text-transform:none;
	              font-size:10.5000pt;mso-font-kerning:1.0000pt;">
					  <%--add by xiaoyl 2022/04/11 检测结果有数值的增加单位组合显示，阴阳性的结果不做处理--%>
<%--					  ${detail.checkResult}<c:if test="${detail.checkResult ne '阳性' && detail.checkResult ne '阴性'}">${detail.checkUnit}</c:if>--%>
					  <c:catch>
						  <fmt:formatNumber value="${detail.checkResult}" pattern="0" var="myCheckResult"/>
						  <c:set var="passed" value="1"/>
					  </c:catch>
					  <c:choose>
						  <c:when test="${passed==1}"><%--有检测值，组合单位显示--%>
							  ${detail.checkResult}${detail.checkUnit}
						  </c:when>
						  <c:otherwise>
							  ${detail.checkResult}
						  </c:otherwise>
					  </c:choose>
				  </span>
	                <%-- <c:if test="${detail.checkResult eq '阳性'}">
	                	<span lang=EN-US style='font-family:"Arial",sans-serif;color:black'> ↑ </span>
		  			</c:if> --%>
	            </p>
	          </td>
	          <td valign=center style="padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none;
	          mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:1.0000pt solid windowtext;
	          border-top:none;mso-border-top-alt:none;border-bottom:1.0000pt solid windowtext;
	          mso-border-bottom-alt:1.0000pt solid windowtext;background:rgb(255,255,255);">
	            <p class="MsoNormal" align=center style="text-align:center;">
	              <span style="font-family:'宋体';letter-spacing:0.0000pt;text-transform:none;
	              font-size:10.5000pt;mso-font-kerning:1.0000pt;">${detail.conclusion}
	                </span>
	            </p>
	          </td>
	        </tr> 
	        </c:forEach>
			<c:forEach var="i" begin="${pageSerialNumber+1}" end="${pageSize}">
			   <tr class="tr-height">
		          <td valign=center style="padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:1.0000pt solid windowtext;
		          mso-border-left-alt:1.0000pt solid windowtext;border-right:1.0000pt solid windowtext;mso-border-right-alt:1.0000pt solid windowtext;
		          border-top:none;mso-border-top-alt:none;border-bottom:1.0000pt solid windowtext;
		          mso-border-bottom-alt:1.0000pt solid windowtext;background:rgb(255,255,255);">
		            <p class="MsoNormal" align=center style="text-align:center;">
		              <span style="font-family:'宋体';letter-spacing:0.0000pt;text-transform:none;
		              font-size:10.5000pt;mso-font-kerning:1.0000pt;"> 
		                </span>
		            </p>
		          </td>
		          <td valign=center style="padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none;
		          mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:1.0000pt solid windowtext;
		          border-top:none;mso-border-top-alt:none;border-bottom:1.0000pt solid windowtext;
		          mso-border-bottom-alt:1.0000pt solid windowtext;background:rgb(255,255,255);">
		            <p class="MsoNormal" align=center style="text-align:center;">
		              <span style="font-family:'宋体';letter-spacing:0.0000pt;text-transform:none;
		              font-size:10.5000pt;mso-font-kerning:1.0000pt;"> 
		                </span>
		            </p>
		          </td>
		          <td valign=center style="padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none;
		          mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:1.0000pt solid windowtext;
		          border-top:none;mso-border-top-alt:none;border-bottom:1.0000pt solid windowtext;
		          mso-border-bottom-alt:1.0000pt solid windowtext;background:rgb(255,255,255);">
		            <p class="MsoNormal" align=center style="text-align:center;">
		              <span style="font-family:'宋体';letter-spacing:0.0000pt;text-transform:none;
		              font-size:10.5000pt;mso-font-kerning:1.0000pt;"> 
		                </span>
		            </p>
		          </td>
		          <td valign=center style="padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none;
		          mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:1.0000pt solid windowtext;
		          border-top:none;mso-border-top-alt:none;border-bottom:1.0000pt solid windowtext;
		          mso-border-bottom-alt:1.0000pt solid windowtext;background:rgb(255,255,255);">
		            <p class="MsoNormal" align=center style="text-align:center;">
		              <span style="font-family:'宋体';letter-spacing:0.0000pt;text-transform:none;
		              font-size:10.5000pt;mso-font-kerning:1.0000pt;"> 
		                </span>
		            </p>
		          </td>
		          <td valign=center style="padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none;
		          mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:1.0000pt solid windowtext;
		          border-top:none;mso-border-top-alt:none;border-bottom:1.0000pt solid windowtext;
		          mso-border-bottom-alt:1.0000pt solid windowtext;background:rgb(255,255,255);">
		            <p class="MsoNormal" align=center style="text-align:center;">
		              <span style="font-family:'宋体';letter-spacing:0.0000pt;text-transform:none;
		              font-size:10.5000pt;mso-font-kerning:1.0000pt;"> 
		                </span>
		            </p>
		          </td>
		          <td valign=center style="padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none;
		          mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:1.0000pt solid windowtext;
		          border-top:none;mso-border-top-alt:none;border-bottom:1.0000pt solid windowtext;
		          mso-border-bottom-alt:1.0000pt solid windowtext;background:rgb(255,255,255);">
		            <p class="MsoNormal" align=center style="text-align:center;">
		              <span style="font-family:'宋体';letter-spacing:0.0000pt;text-transform:none;
		              font-size:10.5000pt;mso-font-kerning:1.0000pt;"> 
		                </span>
		            </p>
		          </td>
		        </tr>
				</c:forEach>
			</table>
			<!-- 底部表格开始 -->
			<table class="MsoNormal"Table border=1 cellspacing=0 style="border-collapse:collapse;width:544.0000pt;margin: 0 auto;
	      border:none;mso-border-left-alt:none;mso-border-top-alt:none;
	      mso-border-right-alt:none;mso-border-bottom-alt:none;mso-border-insideh:0.7500pt outset windowtext;
	      mso-border-insidev:0.7500pt outset windowtext;mso-padding-alt:0.0000pt 0.0000pt 0.0000pt 0.0000pt ;">
	        <tr style="height:58.3500pt;">
	          <td width=412 valign=center colspan=6 style="width:260.2500pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:1.0000pt solid windowtext;
	          mso-border-left-alt:1.0000pt solid windowtext;border-right:1.0000pt solid windowtext;mso-border-right-alt:1.0000pt solid windowtext;
	          border-top:none;mso-border-top-alt:none;border-bottom:1.0000pt solid windowtext;
	          mso-border-bottom-alt:1.0000pt solid windowtext;background:rgb(255,255,255);">
	            <p class="MsoNormal" align=justify style="margin-top:0.0000pt;margin-right:0.0000pt;margin-bottom:0.0000pt;
	            margin-left:0.0000pt;mso-pagination:widow-orphan;text-align:justify;
	            text-justify:inter-ideograph;">
	              <span style="mso-spacerun:'yes';font-family:宋体;letter-spacing:0.0000pt;
	              text-transform:none;font-size:10.5000pt;mso-font-kerning:0.0000pt;">检测：</span>
	              <span style="mso-spacerun:'yes';font-family:'宋体';
	              letter-spacing:0.0000pt;text-transform:none;font-size:10.5000pt;
	              mso-font-kerning:0.0000pt;">
	              <c:forEach items="${l.recordings}" var="recording">
					  <c:choose>
						  <c:when test="${!empty recording.checkUserSignature && recording.checkUserSignature ne ''}">
							  <img height="50" width="70"  src="${resourcesUrl}/${recording.checkUserSignature}"/>
						  </c:when>
						  <c:otherwise>
							  ${recording.checkUsername}
						  </c:otherwise>
					  </c:choose>
			  		</c:forEach>
			  	</span>
	              <span style="font-family:'宋体';mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;
	              mso-bidi-font-family:Calibri;letter-spacing:0.0000pt;text-transform:none;
	              font-size:10.5000pt;mso-font-kerning:0.0000pt;">&nbsp;</span>
	              <span style="font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;
	              mso-bidi-font-family:Calibri;font-size:10.5000pt;mso-font-kerning:1.0000pt;">
	                <o:p></o:p>
	              </span>
	            </p>
	          </td>
	          <td width=313 valign=center colspan=4 rowspan=2 style="width:280.2500pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none;
	          mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:1.0000pt solid windowtext;
	          border-top:none;mso-border-top-alt:none;border-bottom:1.0000pt solid windowtext;
	          mso-border-bottom-alt:1.0000pt solid windowtext;background:rgb(255,255,255);position:relative;">
	            <p class="MsoNormal" align=justify style="margin-top:0.0000pt;margin-right:0.0000pt;margin-bottom:0.0000pt;
	            margin-left:0.0000pt;mso-pagination:widow-orphan;text-align:justify;
	            text-justify:inter-ideograph;line-height:15.7500pt;">
	              <span style="font-family:Calibri;mso-fareast-font-family:'宋体';letter-spacing:0.0000pt;
	              text-transform:none;font-size:10.5000pt;mso-font-kerning:0.0000pt;">
	                <span style="position:absolute;z-index:1;left:0px;top:0px;
	                margin-left:150.9333px;margin-top:1.9333px;width:151.0000px;
	                height:151.0000px;">
	                 <c:if test="${l.signatureFilePicture!=''}">
					  	<img width=151 height=151 src="${webRoot}/${l.signatureFilePicture}" alt="章"/>
					  </c:if>
	                  </span>
	              </span>
	              <span style="font-family:Calibri;mso-fareast-font-family:宋体;font-size:10.5000pt;
	              mso-font-kerning:1.0000pt;">
	                <o:p>&nbsp;</o:p></span>
	            </p>
	            <p class="MsoNormal" align=justify style="margin-top:0.0000pt;margin-right:0.0000pt;margin-bottom:0.0000pt;
	            margin-left:0.0000pt;mso-pagination:widow-orphan;text-align:justify;
	            text-justify:inter-ideograph;line-height:15.7500pt;">
	              <span style="mso-spacerun:'yes';font-family:宋体;letter-spacing:0.0000pt;
	              text-transform:none;font-size:10.5000pt;mso-font-kerning:0.0000pt;">检测机构：常德市武陵区食品药品检验所</span>
	              <span style="font-family:Calibri;mso-fareast-font-family:'宋体';letter-spacing:0.0000pt;
	              text-transform:none;font-size:10.5000pt;mso-font-kerning:0.0000pt;">
	                <o:p></o:p>
	              </span>
	            </p>
	            <p class="MsoNormal" align=justify style="margin-top:0.0000pt;margin-right:0.0000pt;margin-bottom:0.0000pt;
	            margin-left:0.0000pt;mso-pagination:widow-orphan;text-align:justify;
	            text-justify:inter-ideograph;line-height:15.7500pt;">
	              <span style="font-family:Calibri;mso-fareast-font-family:'宋体';letter-spacing:0.0000pt;
	              text-transform:none;font-size:10.5000pt;mso-font-kerning:0.0000pt;">
	                <o:p>&nbsp;</o:p></span>
	            </p>
	            <p class="MsoNormal" align=justify style="margin-top:0.0000pt;margin-right:0.0000pt;margin-bottom:0.0000pt;
	            margin-left:0.0000pt;mso-pagination:widow-orphan;text-align:justify;
	            text-justify:inter-ideograph;line-height:15.7500pt;">
	              <span style="font-family:Calibri;mso-fareast-font-family:'宋体';letter-spacing:0.0000pt;
	              text-transform:none;font-size:10.5000pt;mso-font-kerning:0.0000pt;">
	                <o:p>&nbsp;</o:p></span>
	            </p>
	            <p class="MsoNormal" align=justify style="margin-top:0.0000pt;margin-right:0.0000pt;margin-bottom:0.0000pt;
	            margin-left:0.0000pt;mso-pagination:widow-orphan;text-align:justify;
	            text-justify:inter-ideograph;line-height:15.7500pt;">
	              <span style="mso-spacerun:'yes';font-family:宋体;letter-spacing:0.0000pt;
	              text-transform:none;font-size:10.5000pt;mso-font-kerning:0.0000pt;">检测日期：</span>
	              <span style="font-family:'宋体';mso-fareast-font-family:宋体;font-size:10.5000pt;
	              mso-font-kerning:1.0000pt;">
	                <c:if test="${fn:length(l.recordings) > 0}">
				  		<fmt:formatDate value="${l.recordings[0].uploadDate}" pattern="yyyy-MM-dd"/>
				  	</c:if>
	              </span>
	            </p>
	          </td>
	        </tr>
	        <tr style="height:57.3500pt;">
	          <td width=412 valign=center colspan=6 style="width:260.2500pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:1.0000pt solid windowtext;
	          mso-border-left-alt:1.0000pt solid windowtext;border-right:1.0000pt solid windowtext;mso-border-right-alt:1.0000pt solid windowtext;
	          border-top:none;mso-border-top-alt:none;border-bottom:1.0000pt solid windowtext;
	          mso-border-bottom-alt:1.0000pt solid windowtext;background:rgb(255,255,255);">
	            <p class="MsoNormal" align=justify style="margin-top:0.0000pt;margin-right:0.0000pt;margin-bottom:0.0000pt;
	            margin-left:0.0000pt;mso-pagination:widow-orphan;text-align:justify;
	            text-justify:inter-ideograph;line-height:15.7500pt;">
	              <span style="mso-spacerun:'yes';font-family:宋体;letter-spacing:0.0000pt;
	              text-transform:none;font-size:10.5000pt;mso-font-kerning:0.0000pt;">复核：
					  <c:choose>
						 <c:when test="${fn:contains(l.sampling.reviewSignature,'/' )}">
							 <img height="50" width="70"  src="${resourcesUrl}/${l.sampling.reviewSignature}"/>
						 </c:when>
						  <c:otherwise>${l.sampling.reviewSignature}</c:otherwise>
					  </c:choose>
					  &nbsp;&nbsp;&nbsp;&nbsp;
					  批准：
					  <c:choose>
						  <c:when test="${fn:contains(l.sampling.approvalSignature,'/' )}">
							  <img height="50" width="70"  src="${resourcesUrl}/${l.sampling.approvalSignature}"/>
						  </c:when>
						  <c:otherwise>${l.sampling.approvalSignature}</c:otherwise>
					  </c:choose>
				  </span>
	              <span style="font-family:Calibri;mso-fareast-font-family:宋体;font-size:10.5000pt;
	              mso-font-kerning:1.0000pt;">
	                <o:p></o:p>
	              </span>
	            </p>
	          </td>
	        </tr>
	        <tr style="height:28.5000pt;">
	          <td width=726 valign=center colspan=10 style="width:544.5000pt;padding:0.0000pt 0.0000pt 0.0000pt 0.0000pt ;border-left:none;
	          mso-border-left-alt:none;border-right:none;mso-border-right-alt:none;
	          border-top:none;mso-border-top-alt:none;border-bottom:none;
	          mso-border-bottom-alt:none;background:rgb(255,255,255);">
	            <p class="MsoNormal" align=justify style="margin-top:0.0000pt;margin-right:0.0000pt;margin-bottom:0.0000pt;
	            margin-left:0.0000pt;mso-pagination:widow-orphan;text-align:justify;
	            text-justify:inter-ideograph;">
	              <span style="mso-spacerun:'yes';font-family:宋体;letter-spacing:0.0000pt;
	              text-transform:none;font-size:10.5000pt;mso-font-kerning:0.0000pt;">注：此检验报告仅对本次样品负责。</span>
	              <span style="font-family:Calibri;mso-fareast-font-family:宋体;font-size:10.5000pt;
	              mso-font-kerning:1.0000pt;">
	                <o:p></o:p>
	              </span>
	            </p>
	          </td>
	        </tr>
	      </table>
	      <p class="MsoNormal">
	        <span style="mso-spacerun:'yes';font-family:Calibri;mso-fareast-font-family:宋体;
	        mso-bidi-font-family:'Times New Roman';font-size:10.5000pt;mso-font-kerning:1.0000pt;">
	          <o:p>&nbsp;</o:p></span>
	      </p>
	    </div>
  	</c:otherwise>
</c:choose>

</c:forEach>
</c:forEach>
<!--endprint-->
<div class="cs-hd"></div>
<div class="cs-alert-form-btn">
	<a class="cs-menu-btn cs-fun-btn printBtn btn-print" onclick="preview();"><i class="icon iconfont icon-dayin"></i>打印</a>
      <a class="cs-menu-btn cs-fun-btn" href="javascript:" onclick="parent.closeMbIframe(1);" ><i class="icon iconfont icon-fanhui"></i>返回</a>
  </div>
</body>
	<script type="text/javascript">
	var printNum=0;
	var limitPrint=false;
	$(function(){
		for (var i = 0; i < childBtnMenu.length; i++) {
			if (childBtnMenu[i].operationCode == "321-10") {
				$("#total").show();
			}else if (childBtnMenu[i].operationCode == "321-16" || childBtnMenu[i].operationCode == "1344-12") {
				limitPrint=true;
			}
		}
		if("${printNumber}"!="" && limitPrint){
			 printNum=${printNumber}-$("input[name=printNum]").val();
			$(".tipsMessage").html("剩余打印次数："+printNum+"次");
			if(printNum==0 || printNum<0){
				$(".printBtn").addClass("btn-print");
// 				$(".printBtn").removeAttr('onclick');
			}else{
				$(".printBtn").removeClass("btn-print");
			}
		}else{//未配置限制打印次数权限，直接开放打印按钮
			$(".printBtn").removeClass("btn-print");
		}
	});
	
		function preview(){  
			if (!!window.ActiveXObject || "ActiveXObject" in window) {
		        remove_ie_header_and_footer();
		    }
	        var bdhtml=window.document.body.innerHTML;    
	        var sprnstr="<!--startprint-->";    
	        var eprnstr="<!--endprint-->";    
	        var prnhtml=bdhtml.substring(bdhtml.indexOf(sprnstr)+17);    
	        prnhtml=prnhtml.substring(0,prnhtml.indexOf(eprnstr));    
	        window.document.body.innerHTML=prnhtml;    
	        window.print();
		        //setTimeout(location.reload(), 10);  
	        window.document.body.innerHTML=bdhtml; 
	        if(limitPrint){//有配置限制打印次数的角色才记录打印次数
	        	setTimeout(function (){
		        	$.ajax({
		    	        type: "POST",
		    	        url: "${webRoot}/sampling/updatePrintNumber.do",
		    	        data: {
		    	        	"samplingId":$("input[name=samplingId]").val()
		    	        },
		    	        dataType: "json",
		    	        success: function(data){
		    	        	if(data.success){
		    	        		if("${printNumber}"!=""){
			    	        		printNum=printNum-1;
			    	        		if(printNum==0 || printNum<0){
// 			    	        			$(".printBtn").css("display","none");
			    	        			$(".printBtn").addClass("btn-print");
			    	    			}
				    	    		$(".tipsMessage").html("当前还剩"+printNum+"次打印机会");
		    	        		}
		    	        		console.log("更新打印记录完成");
		    	        	}
		    			}
		        	});
		    	    } 
		        ,100); 
	        }
	        
		}
		//window.onload=autoRowSpan(0,0);
		//window.onload=autoRowSpan(0,1);
		//window.onload=autoRowSpan(0,2);
		function autoRowSpan(row,col) { 
			var lastValue=""; 
			var value=""; 
			var pos=1; 
			var tb = document.getElementById("tb");
			
			for(var i=row;i<tb.rows.length;i++){ 
				value = tb.rows[i].cells[col].innerText; 
				if(lastValue == value){ 
					tb.rows[i].deleteCell(col); 
					tb.rows[i-pos].cells[col].rowSpan = tb.rows[i-pos].cells[col].rowSpan+1; 
					pos++; 
				}else{ 
					lastValue = value; 
					pos=1; 
				}
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
		
	</script>


</html>
