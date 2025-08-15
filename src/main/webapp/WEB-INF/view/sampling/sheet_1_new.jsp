<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/common/resource.jsp"%>
<html>
<head>
<meta charset="utf-8">
<style>
	.MsoNormal{
		font-family:'宋体';
	}
	.tr-height{
		height:46px;
	}
</style>
</head>
<body lang=ZH-CN style='text-justify-trim:punctuation'>
<div class="cs-alert-form-btn">
	<span class="tipsMessage" ></span>
	 <a class="cs-menu-btn cs-fun-btn printBtn" href="javascript:" onclick="preview();"><i class="icon iconfont icon-dayin"></i>打印</a>
      <a class="cs-menu-btn cs-fun-btn" href="javascript:" onclick="parent.closeMbIframe();" ><i class="icon iconfont icon-fanhui"></i>返回</a>
  </div>
<div class="cs-hd"></div>
<!--startprint-->
<c:forEach items="${list}" var="l">
<!-- 每页展示多少条数据 -->
<c:set var="pageSize" value="11"/>
<!-- 打印页数 -->
<c:set var="printPage" value="${fn:length(l.samplingDetailList)%pageSize==0? fn:length(l.samplingDetailList)/pageSize : (fn:length(l.samplingDetailList)/pageSize+1)}"/>
<c:set var="serialNumber" value="0"/>
<c:forEach var="item" begin="1" end="${printPage>0? printPage : 1}" varStatus="pageNumber">
<c:set var="pageSerialNumber" value="0"/>
 <c:choose>
	<c:when test="${l.sampling.personal==1}">
	 	 <div class="Section0_${pageNumber.index}" style="layout-grid:15.6000pt; padding-top:20px;height: 1050px;">
	      <p class=MsoNormal align=center style="margin-top:0.0000pt;margin-right:0.0000pt;margin-bottom:0.0000pt;
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
	      </p>
	      <!-- 头部表格开始 -->
	      <table class=MsoNormalTable border=1 cellspacing=0 style="border-collapse:collapse;width:543.5000pt;margin: 0 auto;
	      border:none;mso-border-left-alt:none;mso-border-top-alt:none;
	      mso-border-right-alt:none;mso-border-bottom-alt:none;mso-border-insideh:0.7500pt outset windowtext;
	      mso-border-insidev:0.7500pt outset windowtext;mso-padding-alt:0.0000pt 0.0000pt 0.0000pt 0.0000pt ;">
	        <tr style="height:27.1000pt;">
	          <td width=726 valign=top colspan=10 style="width:544.5000pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none;
	          mso-border-left-alt:none;border-right:none;mso-border-right-alt:none;
	          border-top:none;mso-border-top-alt:none;border-bottom:none;
	          mso-border-bottom-alt:none;background:rgb(255,255,255);">
	            <p class=MsoNormal align=center style="margin-top:0.0000pt;margin-right:0.0000pt;margin-bottom:0.0000pt;
	            margin-left:0.0000pt;mso-pagination:widow-orphan;text-align:center;">
	              <b>
	                <span style="mso-spacerun:'yes';font-family:宋体;letter-spacing:0.0000pt;
	                font-weight:bold;text-transform:none;font-size:16.0000pt;
	                mso-font-kerning:0.0000pt;">食用农产品送样单</span>
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
	            <p class=MsoNormal style="margin-top:0.0000pt;margin-right:0.0000pt;margin-bottom:0.0000pt;
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
	            <p class=MsoNormal align=justify style="margin-top:0.0000pt;margin-right:0.0000pt;margin-bottom:0.0000pt;
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
	        <tr style="height:25.2000pt;">
	          <td width=124 valign=center colspan=2 style="width:146.1500pt;border-left:1.0000pt solid windowtext;
	          mso-border-left-alt:1.0000pt solid windowtext;border-right:1.0000pt solid windowtext;mso-border-right-alt:1.0000pt solid windowtext;
	          border-top:none;mso-border-top-alt:none;border-bottom:1.0000pt solid windowtext;
	          mso-border-bottom-alt:1.0000pt solid windowtext;background:rgb(255,255,255);">
	            <p class=MsoNormal align=center style="margin-top:0.0000pt;margin-right:0.0000pt;margin-bottom:0.0000pt;
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
	            <p class=MsoNormal style="margin-top:0.0000pt;margin-right:0.0000pt;margin-bottom:0.0000pt;
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
	            <p class=MsoNormal align=center style="height: 95px;margin-top:0.0000pt;margin-right:0.0000pt;margin-bottom:0.0000pt;
	            margin-left:0.0000pt;mso-pagination:widow-orphan;text-align:center;">
	              <span style="font-family:Calibri;mso-fareast-font-family:'宋体';letter-spacing:0.0000pt;
	              text-transform:none;font-size:10.5000pt;mso-font-kerning:0.0000pt;">
	                <img width="103" height="99" src="${webRoot}/resources/${l.samplingQr}"></span>
	              <span style="font-family:Calibri;mso-fareast-font-family:宋体;font-size:10.5000pt;
	              mso-font-kerning:1.0000pt;">
	                </span>
	            </p>
	            <p class=MsoNormal align=center style="margin-top:0.0000pt;margin-right:0.0000pt;margin-bottom:0.0000pt;
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
	            <p class=MsoNormal align=center style="margin-top:0.0000pt;margin-right:0.0000pt;margin-bottom:0.0000pt;
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
	            <p class=MsoNormal style="margin-top:0.0000pt;margin-right:0.0000pt;margin-bottom:0.0000pt;
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
	            <p class=MsoNormal align=center style="margin-top:0.0000pt;margin-right:0.0000pt;margin-bottom:0.0000pt;
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
	            <p class=MsoNormal style="margin-top:0.0000pt;margin-right:0.0000pt;margin-bottom:0.0000pt;
	            margin-left:0.0000pt;mso-pagination:widow-orphan;text-align:left;">
	              <span style="mso-spacerun:'yes';font-family:Calibri;mso-fareast-font-family:'宋体';
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
	            <p class=MsoNormal align=center style="margin-top:0.0000pt;margin-right:0.0000pt;margin-bottom:0.0000pt;
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
	            <p class=MsoNormal align=center style="text-align:center;">
	              <span style="font-family:'宋体';letter-spacing:0.0000pt;text-transform:none;
	              font-size:10.5000pt;mso-font-kerning:1.0000pt;">${l.sampling.regLinkPerson}
	                </span>
	            </p>
	          </td>
	        </tr>
	        <tr style="height:25.2000pt;">
	          <td width=124 valign=center colspan=2 style="width:93.1500pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:1.0000pt solid windowtext;
	          mso-border-left-alt:1.0000pt solid windowtext;border-right:1.0000pt solid windowtext;mso-border-right-alt:1.0000pt solid windowtext;
	          border-top:none;mso-border-top-alt:none;border-bottom:1.0000pt solid windowtext;
	          mso-border-bottom-alt:1.0000pt solid windowtext;background:rgb(255,255,255);">
	            <p class=MsoNormal align=center style="margin-top:0.0000pt;margin-right:0.0000pt;margin-bottom:0.0000pt;
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
	            <p class=MsoNormal align=justify style="margin-top:0.0000pt;margin-right:0.0000pt;margin-bottom:0.0000pt;
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
	            <p class=MsoNormal align=center style="margin-top:0.0000pt;margin-right:0.0000pt;margin-bottom:0.0000pt;
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
	            <p class=MsoNormal style="margin-top:0.0000pt;margin-right:0.0000pt;margin-bottom:0.0000pt;
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
	        <table class=MsoNormalTable border=1 cellspacing=0 style="border-collapse:collapse;width:544.5000pt;margin: 0 auto;
	      border:none;mso-border-left-alt:none;mso-border-top-alt:none;
	      mso-border-right-alt:none;mso-border-bottom-alt:none;mso-border-insideh:0.7500pt outset windowtext;
	      mso-border-insidev:0.7500pt outset windowtext;mso-padding-alt:0.0000pt 0.0000pt 0.0000pt 0.0000pt ;">
	        
	        <tr style="height:21.9500pt;">
	          <td width=726 valign=center colspan=10 style="width:544.5000pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:1.0000pt solid windowtext;
	          mso-border-left-alt:1.0000pt solid windowtext;border-right:1.0000pt solid windowtext;mso-border-right-alt:1.0000pt solid windowtext;
	          border-top:none;mso-border-top-alt:none;border-bottom:1.0000pt solid windowtext;
	          mso-border-bottom-alt:1.0000pt solid windowtext;background:rgb(191,191,191);">
	            <p class=MsoNormal align=center style="margin-top:0.0000pt;margin-right:0.0000pt;margin-bottom:0.0000pt;
	            margin-left:0.0000pt;mso-pagination:widow-orphan;text-align:center;">
	              <span style="mso-spacerun:'yes';font-family:宋体;letter-spacing:0.0000pt;
	              text-transform:none;font-size:12.0000pt;mso-font-kerning:0.0000pt;">样品信息</span>
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
	            <p class=MsoNormal align=center style="margin-top:0.0000pt;margin-right:0.0000pt;margin-bottom:0.0000pt;
	            margin-left:0.0000pt;mso-pagination:widow-orphan;text-align:center;">
	              <span style="mso-spacerun:'yes';font-family:宋体;letter-spacing:0.0000pt;
	              text-transform:none;font-size:10.5000pt;mso-font-kerning:0.0000pt;">编号</span>
	              <span style="font-family:Calibri;mso-fareast-font-family:宋体;font-size:10.5000pt;
	              mso-font-kerning:1.0000pt;">
	              </span>
	            </p>
	          </td>
	       <td  valign=center style="width:101.2500pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none;
	          mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:1.0000pt solid windowtext;
	          border-top:none;mso-border-top-alt:none;border-bottom:1.0000pt solid windowtext;
	          mso-border-bottom-alt:1.0000pt solid windowtext;background:rgb(255,255,255);">
	            <p class=MsoNormal align=center style="margin-top:0.0000pt;margin-right:0.0000pt;margin-bottom:0.0000pt;
	            margin-left:0.0000pt;mso-pagination:widow-orphan;text-align:center;">
	              <span style="mso-spacerun:'yes';font-family:宋体;letter-spacing:0.0000pt;
	              text-transform:none;font-size:10.5000pt;mso-font-kerning:0.0000pt;">样品名称</span>
	              <span style="font-family:Calibri;mso-fareast-font-family:宋体;font-size:10.5000pt;
	              mso-font-kerning:1.0000pt;">
	              </span>
	            </p>
	          </td>
	           <td  valign=center style="width:137.5000pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none;
	          mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:1.0000pt solid windowtext;
	          border-top:none;mso-border-top-alt:none;border-bottom:1.0000pt solid windowtext;
	          mso-border-bottom-alt:1.0000pt solid windowtext;background:rgb(255,255,255);">
	            <p class=MsoNormal align=center style="margin-top:0.0000pt;margin-right:0.0000pt;margin-bottom:0.0000pt;
	            margin-left:0.0000pt;mso-pagination:widow-orphan;text-align:center;">
	              <span style="mso-spacerun:'yes';font-family:宋体;letter-spacing:0.0000pt;
	              text-transform:none;font-size:10.5000pt;mso-font-kerning:0.0000pt;">检测项目</span>
	              <span style="font-family:Calibri;mso-fareast-font-family:宋体;font-size:10.5000pt;
	              mso-font-kerning:1.0000pt;">
	              </span>
	            </p>
	          </td>
	         <td valign=center  style="width:88.5000pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none;
	          mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:1.0000pt solid windowtext;
	          border-top:none;mso-border-top-alt:none;border-bottom:1.0000pt solid windowtext;
	          mso-border-bottom-alt:1.0000pt solid windowtext;background:rgb(255,255,255);">
	            <p class=MsoNormal align=center style="margin-top:0.0000pt;margin-right:0.0000pt;margin-bottom:0.0000pt;
	            margin-left:0.0000pt;mso-pagination:widow-orphan;text-align:center;">
	              <span style="mso-spacerun:'yes';font-family:宋体;letter-spacing:0.0000pt;
	              text-transform:none;font-size:10.5000pt;mso-font-kerning:0.0000pt;">抽样数量（KG）</span>
	              <span style="font-family:Calibri;mso-fareast-font-family:宋体;font-size:10.5000pt;
	              mso-font-kerning:1.0000pt;">
	              </span>
	            </p>
	          </td>
	          <td valign=center  style="width:88.5000pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none;
	          mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:1.0000pt solid windowtext;
	          border-top:none;mso-border-top-alt:none;border-bottom:1.0000pt solid windowtext;
	          mso-border-bottom-alt:1.0000pt solid windowtext;background:rgb(255,255,255);">
	            <p class=MsoNormal align=center style="margin-top:0.0000pt;margin-right:0.0000pt;margin-bottom:0.0000pt;
	            margin-left:0.0000pt;mso-pagination:widow-orphan;text-align:center;">
	              <span style="mso-spacerun:'yes';font-family:宋体;letter-spacing:0.0000pt;
	              text-transform:none;font-size:10.5000pt;mso-font-kerning:0.0000pt;">进货数量（KG）</span>
	              <span style="font-family:Calibri;mso-fareast-font-family:宋体;font-size:10.5000pt;
	              mso-font-kerning:1.0000pt;">
	              </span>
	            </p>
	          </td>
	          <td  valign=center style="width:95.4500pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none;
	          mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:1.0000pt solid windowtext;
	          border-top:none;mso-border-top-alt:none;border-bottom:1.0000pt solid windowtext;
	          mso-border-bottom-alt:1.0000pt solid windowtext;background:rgb(255,255,255);">
	            <p class=MsoNormal align=center style="margin-top:0.0000pt;margin-right:0.0000pt;margin-bottom:0.0000pt;
	            margin-left:0.0000pt;mso-pagination:widow-orphan;text-align:center;">
	              <span style="mso-spacerun:'yes';font-family:宋体;letter-spacing:0.0000pt;
	              text-transform:none;font-size:10.5000pt;mso-font-kerning:0.0000pt;">购买地点</span>
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
	            <p class=MsoNormal align=center style="text-align:center;">
	              <span style="font-family:'宋体';letter-spacing:0.0000pt;text-transform:none;
	              font-size:10.5000pt;mso-font-kerning:1.0000pt;">${serialNumber}
	               </span>
	            </p>
	          </td>
	          <td valign=center style="padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none;
	          mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:1.0000pt solid windowtext;
	          border-top:none;mso-border-top-alt:none;border-bottom:1.0000pt solid windowtext;
	          mso-border-bottom-alt:1.0000pt solid windowtext;background:rgb(255,255,255);">
	            <p class=MsoNormal align=center style="text-align:center;">
	              ${detail.foodName}
	            </p>
	          </td>
	          <td valign=center style="padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none;
	          mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:1.0000pt solid windowtext;
	          border-top:none;mso-border-top-alt:none;border-bottom:1.0000pt solid windowtext;
	          mso-border-bottom-alt:1.0000pt solid windowtext;background:rgb(255,255,255);">
	            <p class=MsoNormal align=center style="text-align:center;">
	              <span style="font-family:'宋体';letter-spacing:0.0000pt;text-transform:none;
	              font-size:10.5000pt;mso-font-kerning:1.0000pt;">${detail.itemName}
	                </span>
	            </p>
	          </td>
	          <td valign=center style="padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none;
	          mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:1.0000pt solid windowtext;
	          border-top:none;mso-border-top-alt:none;border-bottom:1.0000pt solid windowtext;
	          mso-border-bottom-alt:1.0000pt solid windowtext;background:rgb(255,255,255);">
	            <p class=MsoNormal align=center style="text-align:center;">
	              <span style="font-family:'宋体';letter-spacing:0.0000pt;text-transform:none;
	              font-size:10.5000pt;mso-font-kerning:1.0000pt;">${detail.sampleNumber}
	                </span>
	            </p>
	          </td>
	          <td valign=center style="padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none;
	          mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:1.0000pt solid windowtext;
	          border-top:none;mso-border-top-alt:none;border-bottom:1.0000pt solid windowtext;
	          mso-border-bottom-alt:1.0000pt solid windowtext;background:rgb(255,255,255);">
	            <p class=MsoNormal align=center style="text-align:center;">
	              <span style="font-family:'宋体';letter-spacing:0.0000pt;text-transform:none;
	              font-size:10.5000pt;mso-font-kerning:1.0000pt;">${detail.purchaseAmount}
	                </span>
	            </p>
	          </td>
	          <td valign=center style="padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none;
	          mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:1.0000pt solid windowtext;
	          border-top:none;mso-border-top-alt:none;border-bottom:1.0000pt solid windowtext;
	          mso-border-bottom-alt:1.0000pt solid windowtext;background:rgb(255,255,255);">
	            <p class=MsoNormal align=center style="text-align:center;">
	              <span style="font-family:'宋体';letter-spacing:0.0000pt;text-transform:none;
	              font-size:10.5000pt;mso-font-kerning:1.0000pt;">${detail.origin}
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
		            <p class=MsoNormal align=center style="text-align:center;">
		              <span style="font-family:'宋体';letter-spacing:0.0000pt;text-transform:none;
		              font-size:10.5000pt;mso-font-kerning:1.0000pt;"> 
		                </span>
		            </p>
		          </td>
		          <td valign=center style="padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none;
		          mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:1.0000pt solid windowtext;
		          border-top:none;mso-border-top-alt:none;border-bottom:1.0000pt solid windowtext;
		          mso-border-bottom-alt:1.0000pt solid windowtext;background:rgb(255,255,255);">
		            <p class=MsoNormal align=center style="text-align:center;">
		              <span style="font-family:'宋体';letter-spacing:0.0000pt;text-transform:none;
		              font-size:10.5000pt;mso-font-kerning:1.0000pt;"> 
		                </span>
		            </p>
		          </td>
		          <td valign=center style="padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none;
		          mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:1.0000pt solid windowtext;
		          border-top:none;mso-border-top-alt:none;border-bottom:1.0000pt solid windowtext;
		          mso-border-bottom-alt:1.0000pt solid windowtext;background:rgb(255,255,255);">
		            <p class=MsoNormal align=center style="text-align:center;">
		              <span style="font-family:'宋体';letter-spacing:0.0000pt;text-transform:none;
		              font-size:10.5000pt;mso-font-kerning:1.0000pt;"> 
		                </span>
		            </p>
		          </td>
		          <td valign=center style="padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none;
		          mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:1.0000pt solid windowtext;
		          border-top:none;mso-border-top-alt:none;border-bottom:1.0000pt solid windowtext;
		          mso-border-bottom-alt:1.0000pt solid windowtext;background:rgb(255,255,255);">
		            <p class=MsoNormal align=center style="text-align:center;">
		              <span style="font-family:'宋体';letter-spacing:0.0000pt;text-transform:none;
		              font-size:10.5000pt;mso-font-kerning:1.0000pt;"> 
		                </span>
		            </p>
		          </td>
		          <td valign=center style="padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none;
		          mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:1.0000pt solid windowtext;
		          border-top:none;mso-border-top-alt:none;border-bottom:1.0000pt solid windowtext;
		          mso-border-bottom-alt:1.0000pt solid windowtext;background:rgb(255,255,255);">
		            <p class=MsoNormal align=center style="text-align:center;">
		              <span style="font-family:'宋体';letter-spacing:0.0000pt;text-transform:none;
		              font-size:10.5000pt;mso-font-kerning:1.0000pt;"> 
		                </span>
		            </p>
		          </td>
		          <td valign=center style="padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none;
		          mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:1.0000pt solid windowtext;
		          border-top:none;mso-border-top-alt:none;border-bottom:1.0000pt solid windowtext;
		          mso-border-bottom-alt:1.0000pt solid windowtext;background:rgb(255,255,255);">
		            <p class=MsoNormal align=center style="text-align:center;">
		              <span style="font-family:'宋体';letter-spacing:0.0000pt;text-transform:none;
		              font-size:10.5000pt;mso-font-kerning:1.0000pt;"> 
		                </span>
		            </p>
		          </td>
		        </tr>
				</c:forEach>
			</table>
			<!-- 底部表格开始 -->
	        <table class="MsoNormalTable" border="1" cellspacing="0" style="border-collapse:collapse;width:544.5000pt;margin: 0 auto; border:none;mso-border-left-alt:none;mso-border-top-alt:none; mso-border-right-alt:none;mso-border-bottom-alt:none;mso-border-insideh:0.7500pt outset windowtext; mso-border-insidev:0.7500pt outset windowtext;mso-padding-alt:0.0000pt 0.0000pt 0.0000pt 0.0000pt ;">
	            <tr style="height:116.1000pt;">
	                <td width="362" valign="center" colspan="5" style="position: relative;width:271.9000pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:1.0000pt solid windowtext; mso-border-left-alt:1.0000pt solid windowtext;border-right:1.0000pt solid windowtext;mso-border-right-alt:1.0000pt solid windowtext; border-top:none;mso-border-top-alt:none;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:1.0000pt solid windowtext;background:rgb(255,255,255);">
	                    <p class="MsoNormal" align="justify" style="margin-top:0.0000pt;margin-right:0.0000pt;margin-bottom:0.0000pt; margin-left:0.0000pt;mso-pagination:widow-orphan;text-align:justify; text-justify:inter-ideograph;">
	                        <b><span style="mso-spacerun:'yes';font-family:宋体;color:rgb(0,0,0); letter-spacing:0.0000pt;font-weight:bold;text-transform:none; font-style:normal;font-size:10.5000pt;mso-font-kerning:1.0000pt; background:rgb(255,255,255);mso-shading:rgb(255,255,255);">被检单位（个人）对抽样程序、过程、封样状态及上述内容无异议。</span></b>
	                    </p>
	                    <p class="MsoNormal" align="justify" style="margin-top:0.0000pt;margin-right:0.0000pt;margin-bottom:0.0000pt; margin-left:0.0000pt;mso-pagination:widow-orphan;text-align:justify; text-justify:inter-ideograph;">
	                        <b><span style="font-family:宋体;color:rgb(0,0,0);letter-spacing:0.0000pt; font-weight:bold;text-transform:none;font-style:normal; font-size:10.5000pt;mso-font-kerning:1.0000pt;background:rgb(255,255,255); mso-shading:rgb(255,255,255);">&nbsp;</span></b>
	                    </p>
	                    <p class="MsoNormal" align="justify" style="margin-top:0.0000pt;margin-right:0.0000pt;margin-bottom:0.0000pt; margin-left:0.0000pt;mso-pagination:widow-orphan;text-align:justify; text-justify:inter-ideograph;">
	                        <b><span style="font-family:宋体;color:rgb(0,0,0);letter-spacing:0.0000pt; font-weight:bold;text-transform:none;font-style:normal; font-size:10.5000pt;mso-font-kerning:1.0000pt;background:rgb(255,255,255); mso-shading:rgb(255,255,255);">&nbsp;</span></b>
	                    </p>
	                    <p class="MsoNormal" align="justify" style="margin-top:0.0000pt;margin-right:0.0000pt;margin-bottom:0.0000pt; margin-left:0.0000pt;mso-pagination:widow-orphan;text-align:justify; text-justify:inter-ideograph;line-height:15.7500pt;">
	                        <span style="mso-spacerun:'yes';font-family:宋体;letter-spacing:0.0000pt; text-transform:none;font-size:10.5000pt;mso-font-kerning:0.0000pt;">送样人签名：
						  	<span style='position:absolute; z-index:251659264;left:60px;margin-left:100px;margin-top:1px;width:143px; height:40px;top:90px;'>
							  <c:if test="${l.sampling.opeSignature!=''}">
								  <img src="${webRoot}/resources/${l.sampling.opeSignature}" alt="" style="height:100%;" />
							  </c:if>
							  </span>
						  </span>
	                    </p>
	                </td>
	                <td width="363" valign="center" colspan="4" style="width:272.6000pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none; mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:1.0000pt solid windowtext; border-top:none;mso-border-top-alt:none;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:1.0000pt solid windowtext;background:rgb(255,255,255);position: relative;">
	                    <p class="MsoNormal" align="justify" style="margin-top:0.0000pt;margin-right:0.0000pt;margin-bottom:0.0000pt; margin-left:0.0000pt;mso-pagination:widow-orphan;text-align:justify; text-justify:inter-ideograph;line-height:15.7500pt;">
	                        <span style="font-family:Calibri;mso-fareast-font-family:Helvetica;letter-spacing:0.0000pt; text-transform:none;font-size:10.5000pt;mso-font-kerning:0.0000pt;"><span style="position:absolute;z-index:1;left:0px;top: 0; margin-left:113.9333px;margin-top:1.9333px;width:151.0000px; height:151.0000px;">
	                         <c:if test="${l.signatureFilePicture!=''}">
							  	<img width=151 height=151 src="${webRoot}/${l.signatureFilePicture}" alt="章"/>
							  </c:if>
	                        </span></span> <span style="font-family:Calibri;mso-fareast-font-family:宋体;font-size:10.5000pt; mso-font-kerning:1.0000pt;">&nbsp;</span>
	                    </p>
	                    <p class="MsoNormal" align="justify" style="margin-top:0.0000pt;margin-right:0.0000pt;margin-bottom:0.0000pt; margin-left:0.0000pt;mso-pagination:widow-orphan;text-align:justify; text-justify:inter-ideograph;line-height:15.7500pt;">
	                        <span style="mso-spacerun:'yes';font-family:宋体;letter-spacing:0.0000pt; text-transform:none;font-size:10.5000pt;mso-font-kerning:0.0000pt;">抽样人员：${l.sampling.samplingUsername}</span>
	                    </p>
	                    <p class="MsoNormal" align="justify" style="margin-top:0.0000pt;margin-right:0.0000pt;margin-bottom:0.0000pt; margin-left:0.0000pt;mso-pagination:widow-orphan;text-align:justify; text-justify:inter-ideograph;line-height:15.7500pt;">
	                        <span style="font-family:Calibri;mso-fareast-font-family:Helvetica;letter-spacing:0.0000pt; text-transform:none;font-size:10.5000pt;mso-font-kerning:0.0000pt;">&nbsp;</span>
	                    </p>
	                    <p class="MsoNormal" align="justify" style="margin-top:0.0000pt;margin-right:0.0000pt;margin-bottom:0.0000pt; margin-left:0.0000pt;mso-pagination:widow-orphan;text-align:justify; text-justify:inter-ideograph;line-height:15.7500pt;">
	                        <span style="font-family:Calibri;mso-fareast-font-family:Helvetica;letter-spacing:0.0000pt; text-transform:none;font-size:10.5000pt;mso-font-kerning:0.0000pt;">&nbsp;</span>
	                    </p>
	                    <p class="MsoNormal" align="justify" style="margin-top:0.0000pt;margin-right:0.0000pt;margin-bottom:0.0000pt; margin-left:0.0000pt;mso-pagination:widow-orphan;text-align:justify; text-justify:inter-ideograph;line-height:15.7500pt;">
	                        <span style="mso-spacerun:'yes';font-family:宋体;letter-spacing:0.0000pt; text-transform:none;font-size:10.5000pt;mso-font-kerning:0.0000pt;">抽样单位（公章）：</span>
	                    </p>
	                </td>
	            </tr>
	            <tr style="height:28.5000pt;">
	                <td width="726" valign="center" colspan="10" style="width:544.5000pt;padding:0.0000pt 0.0000pt 0.0000pt 0.0000pt ;border-left:none; mso-border-left-alt:none;border-right:none;mso-border-right-alt:none; border-top:none;mso-border-top-alt:none;border-bottom:none; mso-border-bottom-alt:none;background:rgb(255,255,255);">
	                    <p class="MsoNormal" align="justify" style="margin-top:0.0000pt;margin-right:0.0000pt;margin-bottom:0.0000pt; margin-left:0.0000pt;mso-pagination:widow-orphan;text-align:justify; text-justify:inter-ideograph;">
	                        <span style="mso-spacerun:'yes';font-family:宋体;letter-spacing:0.0000pt; text-transform:none;font-size:10.5000pt;mso-font-kerning:0.0000pt;">注：本样品单由被检单位（个人）协助抽样人员如实填写。</span>
	                    </p>
	                </td>
	            </tr>
	        </table>
	      <p class=MsoNormal>
	        <span style="mso-spacerun:'yes';font-family:Calibri;mso-fareast-font-family:宋体;
	        mso-bidi-font-family:'Times New Roman';font-size:10.5000pt;mso-font-kerning:1.0000pt;">
	          <o:p>&nbsp;</o:p></span>
	      </p>
	    </div>
	</c:when>
	<c:otherwise>
	   <div class="Section0_${pageNumber.index}" style="layout-grid:15.6000pt; padding-top:20px;height: 1050px;">
	      <p class=MsoNormal align=center style="margin-top:0.0000pt;margin-right:0.0000pt;margin-bottom:0.0000pt;
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
	      </p>
	      <!-- 头部表格开始 -->
	      <table class=MsoNormalTable border=1 cellspacing=0 style="border-collapse:collapse;width:543.5000pt;margin: 0 auto;
	      border:none;mso-border-left-alt:none;mso-border-top-alt:none;
	      mso-border-right-alt:none;mso-border-bottom-alt:none;mso-border-insideh:0.7500pt outset windowtext;
	      mso-border-insidev:0.7500pt outset windowtext;mso-padding-alt:0.0000pt 0.0000pt 0.0000pt 0.0000pt ;">
	        <tr style="height:27.1000pt;">
	          <td width=726 valign=top colspan=10 style="width:544.5000pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none;
	          mso-border-left-alt:none;border-right:none;mso-border-right-alt:none;
	          border-top:none;mso-border-top-alt:none;border-bottom:none;
	          mso-border-bottom-alt:none;background:rgb(255,255,255);">
	            <p class=MsoNormal align=center style="margin-top:0.0000pt;margin-right:0.0000pt;margin-bottom:0.0000pt;
	            margin-left:0.0000pt;mso-pagination:widow-orphan;text-align:center;">
	              <b>
	                <span style="mso-spacerun:'yes';font-family:宋体;letter-spacing:0.0000pt;
	                font-weight:bold;text-transform:none;font-size:16.0000pt;
	                mso-font-kerning:0.0000pt;">食用农产品抽样单</span>
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
	            <p class=MsoNormal style="margin-top:0.0000pt;margin-right:0.0000pt;margin-bottom:0.0000pt;
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
	            <p class=MsoNormal align=justify style="margin-top:0.0000pt;margin-right:0.0000pt;margin-bottom:0.0000pt;
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
	        <tr style="height:25.2000pt;">
	          <td width=124 valign=center colspan=2 style="width:146.1500pt;border-left:1.0000pt solid windowtext;
	          mso-border-left-alt:1.0000pt solid windowtext;border-right:1.0000pt solid windowtext;mso-border-right-alt:1.0000pt solid windowtext;
	          border-top:none;mso-border-top-alt:none;border-bottom:1.0000pt solid windowtext;
	          mso-border-bottom-alt:1.0000pt solid windowtext;background:rgb(255,255,255);">
	            <p class=MsoNormal align=center style="margin-top:0.0000pt;margin-right:0.0000pt;margin-bottom:0.0000pt;
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
	            <p class=MsoNormal style="margin-top:0.0000pt;margin-right:0.0000pt;margin-bottom:0.0000pt;
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
	            <p class=MsoNormal align=center style="height: 95px;margin-top:0.0000pt;margin-right:0.0000pt;margin-bottom:0.0000pt;
	            margin-left:0.0000pt;mso-pagination:widow-orphan;text-align:center;">
	              <span style="font-family:Calibri;mso-fareast-font-family:'宋体';letter-spacing:0.0000pt;
	              text-transform:none;font-size:10.5000pt;mso-font-kerning:0.0000pt;">
	                <img width="103" height="99" src="${webRoot}/resources/${l.samplingQr}"></span>
	              <span style="font-family:Calibri;mso-fareast-font-family:宋体;font-size:10.5000pt;
	              mso-font-kerning:1.0000pt;">
	                </span>
	            </p>
	            <p class=MsoNormal align=center style="margin-top:0.0000pt;margin-right:0.0000pt;margin-bottom:0.0000pt;
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
	            <p class=MsoNormal align=center style="margin-top:0.0000pt;margin-right:0.0000pt;margin-bottom:0.0000pt;
	            margin-left:0.0000pt;mso-pagination:widow-orphan;text-align:center;">
	              <span style="mso-spacerun:'yes';font-family:宋体;letter-spacing:0.0000pt;
	              text-transform:none;font-size:10.5000pt;mso-font-kerning:0.0000pt;">经营户名称</span>
	              <span style="font-family:Calibri;mso-fareast-font-family:宋体;font-size:10.5000pt;
	              mso-font-kerning:1.0000pt;">
	              </span>
	            </p>
	          </td>
	          <td width=467 valign=center colspan=6 style="width:350.9000pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none;
	          mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:1.0000pt solid windowtext;
	          border-top:none;mso-border-top-alt:none;border-bottom:1.0000pt solid windowtext;
	          mso-border-bottom-alt:1.0000pt solid windowtext;background:rgb(255,255,255);">
	            <p class=MsoNormal style="margin-top:0.0000pt;margin-right:0.0000pt;margin-bottom:0.0000pt;
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
	            <p class=MsoNormal align=center style="margin-top:0.0000pt;margin-right:0.0000pt;margin-bottom:0.0000pt;
	            margin-left:0.0000pt;mso-pagination:widow-orphan;text-align:center;">
	              <span style="mso-spacerun:'yes';font-family:宋体;letter-spacing:0.0000pt;
	              text-transform:none;font-size:10.5000pt;mso-font-kerning:0.0000pt;">档口编号</span>
	              <span style="font-family:Calibri;mso-fareast-font-family:宋体;font-size:10.5000pt;
	              mso-font-kerning:1.0000pt;">
	              </span>
	            </p>
	          </td>
	          <td width=188 valign=center colspan=2 style="width:141.6500pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none;
	          mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:1.0000pt solid windowtext;
	          border-top:none;mso-border-top-alt:none;border-bottom:1.0000pt solid windowtext;
	          mso-border-bottom-alt:1.0000pt solid windowtext;background:rgb(255,255,255);">
	            <p class=MsoNormal style="margin-top:0.0000pt;margin-right:0.0000pt;margin-bottom:0.0000pt;
	            margin-left:0.0000pt;mso-pagination:widow-orphan;text-align:left;">
	              <span style="mso-spacerun:'yes';font-family:宋体;mso-fareast-font-family:'宋体';
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
	            <p class=MsoNormal align=center style="margin-top:0.0000pt;margin-right:0.0000pt;margin-bottom:0.0000pt;
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
	            <p class=MsoNormal align=center style="text-align:center;">
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
	            <p class=MsoNormal align=center style="margin-top:0.0000pt;margin-right:0.0000pt;margin-bottom:0.0000pt;
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
	            <p class=MsoNormal align=justify style="margin-top:0.0000pt;margin-right:0.0000pt;margin-bottom:0.0000pt;
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
	            <p class=MsoNormal align=center style="margin-top:0.0000pt;margin-right:0.0000pt;margin-bottom:0.0000pt;
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
	            <p class=MsoNormal style="margin-top:0.0000pt;margin-right:0.0000pt;margin-bottom:0.0000pt;
	            margin-left:0.0000pt;mso-pagination:widow-orphan;text-align:left;">
	              <span style="mso-spacerun:'yes';font-family:Calibri;mso-fareast-font-family:'宋体';
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
	        <table class=MsoNormalTable border=1 cellspacing=0 style="border-collapse:collapse;width:544.5000pt;margin: 0 auto;
	      border:none;mso-border-left-alt:none;mso-border-top-alt:none;
	      mso-border-right-alt:none;mso-border-bottom-alt:none;mso-border-insideh:0.7500pt outset windowtext;
	      mso-border-insidev:0.7500pt outset windowtext;mso-padding-alt:0.0000pt 0.0000pt 0.0000pt 0.0000pt ;">
	        
	        <tr style="height:21.9500pt;">
	          <td width=726 valign=center colspan=10 style="width:544.5000pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:1.0000pt solid windowtext;
	          mso-border-left-alt:1.0000pt solid windowtext;border-right:1.0000pt solid windowtext;mso-border-right-alt:1.0000pt solid windowtext;
	          border-top:none;mso-border-top-alt:none;border-bottom:1.0000pt solid windowtext;
	          mso-border-bottom-alt:1.0000pt solid windowtext;background:rgb(191,191,191);">
	            <p class=MsoNormal align=center style="margin-top:0.0000pt;margin-right:0.0000pt;margin-bottom:0.0000pt;
	            margin-left:0.0000pt;mso-pagination:widow-orphan;text-align:center;">
	              <span style="mso-spacerun:'yes';font-family:宋体;letter-spacing:0.0000pt;
	              text-transform:none;font-size:12.0000pt;mso-font-kerning:0.0000pt;">样品信息</span>
	              <span style="font-family:Calibri;mso-fareast-font-family:宋体;font-size:12.0000pt;
	              mso-font-kerning:1.0000pt;">
	              </span>
	            </p>
	          </td>
	        </tr>
	        <tr style="height:31.4500pt;">
	          <td width=42 valign=center style="width:34.0500pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:1.0000pt solid windowtext;
	          mso-border-left-alt:1.0000pt solid windowtext;border-right:1.0000pt solid windowtext;mso-border-right-alt:1.0000pt solid windowtext;
	          border-top:none;mso-border-top-alt:none;border-bottom:1.0000pt solid windowtext;
	          mso-border-bottom-alt:1.0000pt solid windowtext;background:rgb(255,255,255);">
	            <p class=MsoNormal align=center style="margin-top:0.0000pt;margin-right:0.0000pt;margin-bottom:0.0000pt;
	            margin-left:0.0000pt;mso-pagination:widow-orphan;text-align:center;">
	              <span style="mso-spacerun:'yes';font-family:宋体;letter-spacing:0.0000pt;
	              text-transform:none;font-size:10.5000pt;mso-font-kerning:0.0000pt;">编号</span>
	              <span style="font-family:Calibri;mso-fareast-font-family:宋体;font-size:10.5000pt;
	              mso-font-kerning:1.0000pt;">
	              </span>
	            </p>
	          </td>
	          <td valign=center style="width:101.2500pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none;
	          mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:1.0000pt solid windowtext;
	          border-top:none;mso-border-top-alt:none;border-bottom:1.0000pt solid windowtext;
	          mso-border-bottom-alt:1.0000pt solid windowtext;background:rgb(255,255,255);">
	            <p class=MsoNormal align=center style="margin-top:0.0000pt;margin-right:0.0000pt;margin-bottom:0.0000pt;
	            margin-left:0.0000pt;mso-pagination:widow-orphan;text-align:center;">
	              <span style="mso-spacerun:'yes';font-family:宋体;letter-spacing:0.0000pt;
	              text-transform:none;font-size:10.5000pt;mso-font-kerning:0.0000pt;">样品名称</span>
	              <span style="font-family:Calibri;mso-fareast-font-family:宋体;font-size:10.5000pt;
	              mso-font-kerning:1.0000pt;">
	              </span>
	            </p>
	          </td>
	          <td valign=center style="width:137.5000pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none;
	          mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:1.0000pt solid windowtext;
	          border-top:none;mso-border-top-alt:none;border-bottom:1.0000pt solid windowtext;
	          mso-border-bottom-alt:1.0000pt solid windowtext;background:rgb(255,255,255);">
	            <p class=MsoNormal align=center style="margin-top:0.0000pt;margin-right:0.0000pt;margin-bottom:0.0000pt;
	            margin-left:0.0000pt;mso-pagination:widow-orphan;text-align:center;">
	              <span style="mso-spacerun:'yes';font-family:宋体;letter-spacing:0.0000pt;
	              text-transform:none;font-size:10.5000pt;mso-font-kerning:0.0000pt;">检测项目</span>
	              <span style="font-family:Calibri;mso-fareast-font-family:宋体;font-size:10.5000pt;
	              mso-font-kerning:1.0000pt;">
	              </span>
	            </p>
	          </td>
	          <td valign=center style="width:88.5000pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none;
	          mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:1.0000pt solid windowtext;
	          border-top:none;mso-border-top-alt:none;border-bottom:1.0000pt solid windowtext;
	          mso-border-bottom-alt:1.0000pt solid windowtext;background:rgb(255,255,255);">
	            <p class=MsoNormal align=center style="margin-top:0.0000pt;margin-right:0.0000pt;margin-bottom:0.0000pt;
	            margin-left:0.0000pt;mso-pagination:widow-orphan;text-align:center;">
	              <span style="mso-spacerun:'yes';font-family:宋体;letter-spacing:0.0000pt;
	              text-transform:none;font-size:10.5000pt;mso-font-kerning:0.0000pt;">抽样数量（KG）</span>
	              <span style="font-family:Calibri;mso-fareast-font-family:宋体;font-size:10.5000pt;
	              mso-font-kerning:1.0000pt;">
	              </span>
	            </p>
	          </td>
	          <td valign=center style="width:88.5000pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none;
	          mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:1.0000pt solid windowtext;
	          border-top:none;mso-border-top-alt:none;border-bottom:1.0000pt solid windowtext;
	          mso-border-bottom-alt:1.0000pt solid windowtext;background:rgb(255,255,255);">
	            <p class=MsoNormal align=center style="margin-top:0.0000pt;margin-right:0.0000pt;margin-bottom:0.0000pt;
	            margin-left:0.0000pt;mso-pagination:widow-orphan;text-align:center;">
	              <span style="mso-spacerun:'yes';font-family:宋体;letter-spacing:0.0000pt;
	              text-transform:none;font-size:10.5000pt;mso-font-kerning:0.0000pt;">进货数量（KG）</span>
	              <span style="font-family:Calibri;mso-fareast-font-family:宋体;font-size:10.5000pt;
	              mso-font-kerning:1.0000pt;">
	              </span>
	            </p>
	          </td>
	          <td valign=center style="width:95.4500pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none;
	          mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:1.0000pt solid windowtext;
	          border-top:none;mso-border-top-alt:none;border-bottom:1.0000pt solid windowtext;
	          mso-border-bottom-alt:1.0000pt solid windowtext;background:rgb(255,255,255);">
	            <p class=MsoNormal align=center style="margin-top:0.0000pt;margin-right:0.0000pt;margin-bottom:0.0000pt;
	            margin-left:0.0000pt;mso-pagination:widow-orphan;text-align:center;">
	              <span style="mso-spacerun:'yes';font-family:宋体;letter-spacing:0.0000pt;
	              text-transform:none;font-size:10.5000pt;mso-font-kerning:0.0000pt;">产地</span>
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
	            <p class=MsoNormal align=center style="text-align:center;">
	              <span style="font-family:'宋体';letter-spacing:0.0000pt;text-transform:none;
	              font-size:10.5000pt;mso-font-kerning:1.0000pt;">${serialNumber}
	               </span>
	            </p>
	          </td>
	          <td valign=center style="padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none;
	          mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:1.0000pt solid windowtext;
	          border-top:none;mso-border-top-alt:none;border-bottom:1.0000pt solid windowtext;
	          mso-border-bottom-alt:1.0000pt solid windowtext;background:rgb(255,255,255);">
	            <p class=MsoNormal align=center style="text-align:center;">
	              ${detail.foodName}
	            </p>
	          </td>
	          <td valign=center style="padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none;
	          mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:1.0000pt solid windowtext;
	          border-top:none;mso-border-top-alt:none;border-bottom:1.0000pt solid windowtext;
	          mso-border-bottom-alt:1.0000pt solid windowtext;background:rgb(255,255,255);">
	            <p class=MsoNormal align=center style="text-align:center;">
	              <span style="font-family:'宋体';letter-spacing:0.0000pt;text-transform:none;
	              font-size:10.5000pt;mso-font-kerning:1.0000pt;">${detail.itemName}
	                </span>
	            </p>
	          </td>
	          <td valign=center style="padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none;
	          mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:1.0000pt solid windowtext;
	          border-top:none;mso-border-top-alt:none;border-bottom:1.0000pt solid windowtext;
	          mso-border-bottom-alt:1.0000pt solid windowtext;background:rgb(255,255,255);">
	            <p class=MsoNormal align=center style="text-align:center;">
	              <span style="font-family:'宋体';letter-spacing:0.0000pt;text-transform:none;
	              font-size:10.5000pt;mso-font-kerning:1.0000pt;">${detail.sampleNumber}
	                </span>
	            </p>
	          </td>
	          <td valign=center style="padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none;
	          mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:1.0000pt solid windowtext;
	          border-top:none;mso-border-top-alt:none;border-bottom:1.0000pt solid windowtext;
	          mso-border-bottom-alt:1.0000pt solid windowtext;background:rgb(255,255,255);">
	            <p class=MsoNormal align=center style="text-align:center;">
	              <span style="font-family:'宋体';letter-spacing:0.0000pt;text-transform:none;
	              font-size:10.5000pt;mso-font-kerning:1.0000pt;">${detail.purchaseAmount}
	                </span>
	            </p>
	          </td>
	          <td valign=center style="padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none;
	          mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:1.0000pt solid windowtext;
	          border-top:none;mso-border-top-alt:none;border-bottom:1.0000pt solid windowtext;
	          mso-border-bottom-alt:1.0000pt solid windowtext;background:rgb(255,255,255);">
	            <p class=MsoNormal align=center style="text-align:center;">
	              <span style="font-family:'宋体';letter-spacing:0.0000pt;text-transform:none;
	              font-size:10.5000pt;mso-font-kerning:1.0000pt;">${detail.origin}
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
		            <p class=MsoNormal align=center style="text-align:center;">
		              <span style="font-family:'宋体';letter-spacing:0.0000pt;text-transform:none;
		              font-size:10.5000pt;mso-font-kerning:1.0000pt;"> 
		                </span>
		            </p>
		          </td>
		          <td valign=center style="padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none;
		          mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:1.0000pt solid windowtext;
		          border-top:none;mso-border-top-alt:none;border-bottom:1.0000pt solid windowtext;
		          mso-border-bottom-alt:1.0000pt solid windowtext;background:rgb(255,255,255);">
		            <p class=MsoNormal align=center style="text-align:center;">
		              <span style="font-family:'宋体';letter-spacing:0.0000pt;text-transform:none;
		              font-size:10.5000pt;mso-font-kerning:1.0000pt;"> 
		                </span>
		            </p>
		          </td>
		          <td valign=center style="padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none;
		          mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:1.0000pt solid windowtext;
		          border-top:none;mso-border-top-alt:none;border-bottom:1.0000pt solid windowtext;
		          mso-border-bottom-alt:1.0000pt solid windowtext;background:rgb(255,255,255);">
		            <p class=MsoNormal align=center style="text-align:center;">
		              <span style="font-family:'宋体';letter-spacing:0.0000pt;text-transform:none;
		              font-size:10.5000pt;mso-font-kerning:1.0000pt;"> 
		                </span>
		            </p>
		          </td>
		          <td valign=center style="padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none;
		          mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:1.0000pt solid windowtext;
		          border-top:none;mso-border-top-alt:none;border-bottom:1.0000pt solid windowtext;
		          mso-border-bottom-alt:1.0000pt solid windowtext;background:rgb(255,255,255);">
		            <p class=MsoNormal align=center style="text-align:center;">
		              <span style="font-family:'宋体';letter-spacing:0.0000pt;text-transform:none;
		              font-size:10.5000pt;mso-font-kerning:1.0000pt;"> 
		                </span>
		            </p>
		          </td>
		          <td valign=center style="padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none;
		          mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:1.0000pt solid windowtext;
		          border-top:none;mso-border-top-alt:none;border-bottom:1.0000pt solid windowtext;
		          mso-border-bottom-alt:1.0000pt solid windowtext;background:rgb(255,255,255);">
		            <p class=MsoNormal align=center style="text-align:center;">
		              <span style="font-family:'宋体';letter-spacing:0.0000pt;text-transform:none;
		              font-size:10.5000pt;mso-font-kerning:1.0000pt;"> 
		                </span>
		            </p>
		          </td>
		          <td valign=center style="padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none;
		          mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:1.0000pt solid windowtext;
		          border-top:none;mso-border-top-alt:none;border-bottom:1.0000pt solid windowtext;
		          mso-border-bottom-alt:1.0000pt solid windowtext;background:rgb(255,255,255);">
		            <p class=MsoNormal align=center style="text-align:center;">
		              <span style="font-family:'宋体';letter-spacing:0.0000pt;text-transform:none;
		              font-size:10.5000pt;mso-font-kerning:1.0000pt;"> 
		                </span>
		            </p>
		          </td>
		        </tr>
				</c:forEach>
			</table>
			<!-- 底部表格开始 -->
	        <table class="MsoNormalTable" border="1" cellspacing="0" style="border-collapse:collapse;width:544.5000pt;margin: 0 auto; border:none;mso-border-left-alt:none;mso-border-top-alt:none; mso-border-right-alt:none;mso-border-bottom-alt:none;mso-border-insideh:0.7500pt outset windowtext; mso-border-insidev:0.7500pt outset windowtext;mso-padding-alt:0.0000pt 0.0000pt 0.0000pt 0.0000pt ;">
	            <tr style="height:116.1000pt;">
	                <td width="362" valign="center" colspan="5" style="position: relative;width:271.9000pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:1.0000pt solid windowtext; mso-border-left-alt:1.0000pt solid windowtext;border-right:1.0000pt solid windowtext;mso-border-right-alt:1.0000pt solid windowtext; border-top:none;mso-border-top-alt:none;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:1.0000pt solid windowtext;background:rgb(255,255,255);">
	                    <p class="MsoNormal" align="justify" style="margin-top:0.0000pt;margin-right:0.0000pt;margin-bottom:0.0000pt; margin-left:0.0000pt;mso-pagination:widow-orphan;text-align:justify; text-justify:inter-ideograph;">
	                        <b><span style="mso-spacerun:'yes';font-family:宋体;color:rgb(0,0,0); letter-spacing:0.0000pt;font-weight:bold;text-transform:none; font-style:normal;font-size:10.5000pt;mso-font-kerning:1.0000pt; background:rgb(255,255,255);mso-shading:rgb(255,255,255);">被检单位（个人）对抽样程序、过程、封样状态及上述内容无异议。</span></b>
	                    </p>
	                    <p class="MsoNormal" align="justify" style="margin-top:0.0000pt;margin-right:0.0000pt;margin-bottom:0.0000pt; margin-left:0.0000pt;mso-pagination:widow-orphan;text-align:justify; text-justify:inter-ideograph;">
	                        <b><span style="font-family:宋体;color:rgb(0,0,0);letter-spacing:0.0000pt; font-weight:bold;text-transform:none;font-style:normal; font-size:10.5000pt;mso-font-kerning:1.0000pt;background:rgb(255,255,255); mso-shading:rgb(255,255,255);">&nbsp;</span></b>
	                    </p>
	                    <p class="MsoNormal" align="justify" style="margin-top:0.0000pt;margin-right:0.0000pt;margin-bottom:0.0000pt; margin-left:0.0000pt;mso-pagination:widow-orphan;text-align:justify; text-justify:inter-ideograph;">
	                        <b><span style="font-family:宋体;color:rgb(0,0,0);letter-spacing:0.0000pt; font-weight:bold;text-transform:none;font-style:normal; font-size:10.5000pt;mso-font-kerning:1.0000pt;background:rgb(255,255,255); mso-shading:rgb(255,255,255);">&nbsp;</span></b>
	                    </p>
	                    <p class="MsoNormal" align="justify" style="margin-top:0.0000pt;margin-right:0.0000pt;margin-bottom:0.0000pt; margin-left:0.0000pt;mso-pagination:widow-orphan;text-align:justify; text-justify:inter-ideograph;line-height:15.7500pt;">
	                        <span style="mso-spacerun:'yes';font-family:宋体;letter-spacing:0.0000pt; text-transform:none;font-size:10.5000pt;mso-font-kerning:0.0000pt;">被检单位（个人）签名：
						  	<span style='position:absolute; z-index:251659264;left:60px;margin-left:100px;margin-top:1px;width:143px; height:40px;top:90px;'>
							  <c:if test="${l.sampling.opeSignature!=''}">
								  <img src="${webRoot}/resources/${l.sampling.opeSignature}" alt="" style="height:100%;" />
							  </c:if>
							  </span>
						  </span>
	                    </p>
	                </td>
	                <td width="363" valign="center" colspan="4" style="width:272.6000pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none; mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:1.0000pt solid windowtext; border-top:none;mso-border-top-alt:none;border-bottom:1.0000pt solid windowtext; mso-border-bottom-alt:1.0000pt solid windowtext;background:rgb(255,255,255);position: relative;">
	                    <p class="MsoNormal" align="justify" style="margin-top:0.0000pt;margin-right:0.0000pt;margin-bottom:0.0000pt; margin-left:0.0000pt;mso-pagination:widow-orphan;text-align:justify; text-justify:inter-ideograph;line-height:15.7500pt;">
	                        <span style="font-family:Calibri;mso-fareast-font-family:Helvetica;letter-spacing:0.0000pt; text-transform:none;font-size:10.5000pt;mso-font-kerning:0.0000pt;"><span style="position:absolute;z-index:1;left:0px;top: 0; margin-left:113.9333px;margin-top:1.9333px;width:151.0000px; height:151.0000px;">
	                         <c:if test="${l.signatureFilePicture!=''}">
							  	<img width=151 height=151 src="${webRoot}/${l.signatureFilePicture}" alt="章"/>
							  </c:if>
	                        </span></span> <span style="font-family:Calibri;mso-fareast-font-family:宋体;font-size:10.5000pt; mso-font-kerning:1.0000pt;">&nbsp;</span>
	                    </p>
	                    <p class="MsoNormal" align="justify" style="margin-top:0.0000pt;margin-right:0.0000pt;margin-bottom:0.0000pt; margin-left:0.0000pt;mso-pagination:widow-orphan;text-align:justify; text-justify:inter-ideograph;line-height:15.7500pt;">
	                        <span style="mso-spacerun:'yes';font-family:宋体;letter-spacing:0.0000pt; text-transform:none;font-size:10.5000pt;mso-font-kerning:0.0000pt;">抽样人员：${l.sampling.samplingUsername}</span>
	                    </p>
	                    <p class="MsoNormal" align="justify" style="margin-top:0.0000pt;margin-right:0.0000pt;margin-bottom:0.0000pt; margin-left:0.0000pt;mso-pagination:widow-orphan;text-align:justify; text-justify:inter-ideograph;line-height:15.7500pt;">
	                        <span style="font-family:Calibri;mso-fareast-font-family:Helvetica;letter-spacing:0.0000pt; text-transform:none;font-size:10.5000pt;mso-font-kerning:0.0000pt;">&nbsp;</span>
	                    </p>
	                    <p class="MsoNormal" align="justify" style="margin-top:0.0000pt;margin-right:0.0000pt;margin-bottom:0.0000pt; margin-left:0.0000pt;mso-pagination:widow-orphan;text-align:justify; text-justify:inter-ideograph;line-height:15.7500pt;">
	                        <span style="font-family:Calibri;mso-fareast-font-family:Helvetica;letter-spacing:0.0000pt; text-transform:none;font-size:10.5000pt;mso-font-kerning:0.0000pt;">&nbsp;</span>
	                    </p>
	                    <p class="MsoNormal" align="justify" style="margin-top:0.0000pt;margin-right:0.0000pt;margin-bottom:0.0000pt; margin-left:0.0000pt;mso-pagination:widow-orphan;text-align:justify; text-justify:inter-ideograph;line-height:15.7500pt;">
	                        <span style="mso-spacerun:'yes';font-family:宋体;letter-spacing:0.0000pt; text-transform:none;font-size:10.5000pt;mso-font-kerning:0.0000pt;">抽样单位（公章）：</span>
	                    </p>
	                </td>
	            </tr>
	            <tr style="height:28.5000pt;">
	                <td width="726" valign="center" colspan="10" style="width:544.5000pt;padding:0.0000pt 0.0000pt 0.0000pt 0.0000pt ;border-left:none; mso-border-left-alt:none;border-right:none;mso-border-right-alt:none; border-top:none;mso-border-top-alt:none;border-bottom:none; mso-border-bottom-alt:none;background:rgb(255,255,255);">
	                    <p class="MsoNormal" align="justify" style="margin-top:0.0000pt;margin-right:0.0000pt;margin-bottom:0.0000pt; margin-left:0.0000pt;mso-pagination:widow-orphan;text-align:justify; text-justify:inter-ideograph;">
	                        <span style="mso-spacerun:'yes';font-family:宋体;letter-spacing:0.0000pt; text-transform:none;font-size:10.5000pt;mso-font-kerning:0.0000pt;">注：本样品单由被检单位（个人）协助抽样人员如实填写。</span>
	                    </p>
	                </td>
	            </tr>
	        </table>
	      <p class=MsoNormal>
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
	<a class="cs-menu-btn cs-fun-btn printBtn" href="javascript:" onclick="preview();"><i class="icon iconfont icon-dayin"></i>打印</a>
      <a class="cs-menu-btn cs-fun-btn" href="javascript:" onclick="parent.closeMbIframe();" ><i class="icon iconfont icon-fanhui"></i>返回</a>
  </div>
</body>
	<script type="text/javascript">
	$(function(){
		for (var i = 0; i < childBtnMenu.length; i++) {
			if (childBtnMenu[i].operationCode == "321-10") {
				$("#total").show();
			}
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
