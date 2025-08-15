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

 /* Font Definitions */
 @font-face
    {font-family:宋体;
    panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
    {font-family:"Cambria Math";
    panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
    {font-family:等线;
    panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
    {font-family:Calibri;
    panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
    {font-family:"\@宋体";
    panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
    {font-family:"\@等线";
    panose-1:2 1 6 0 3 1 1 1 1 1;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
    {margin:0cm;
    margin-bottom:.0001pt;
    text-align:justify;
    text-justify:inter-ideograph;
    font-size:10.5pt;
    font-family:"Calibri",sans-serif;}
p.MsoHeader, li.MsoHeader, div.MsoHeader
    {mso-style-link:"页眉 字符";
    margin:0cm;
    margin-bottom:.0001pt;
    text-align:center;
    layout-grid-mode:char;
    border:none;
    padding:0cm;
    font-size:9.0pt;
    font-family:"Calibri",sans-serif;}
p.MsoFooter, li.MsoFooter, div.MsoFooter
    {mso-style-link:"页脚 字符";
    margin:0cm;
    margin-bottom:.0001pt;
    layout-grid-mode:char;
    font-size:9.0pt;
    font-family:"Calibri",sans-serif;}
span.a
    {mso-style-name:"页眉 字符";
    mso-style-link:页眉;}
span.a0
    {mso-style-name:"页脚 字符";
    mso-style-link:页脚;}
.MsoChpDefault
    {font-size:10.0pt;
    font-family:"Calibri",sans-serif;}
 /* Page Definitions */
 @page WordSection1
    {size:595.3pt 841.9pt;
    margin:42.5pt 90.0pt 2.0cm 90.0pt;
    layout-grid:15.6pt;}
div.WordSection1
    {page:WordSection1;}
.reportBorder{
	border: 1px solid #000;
	margin:0 auto;
	margin-bottom: 50px;
}
@media   print   {  
  .reportBorder{ 
  		border-width:0;
   		margin-bottom: 0; 
  	}
  }
</style>

</head>

<body lang=ZH-CN style='text-justify-trim:punctuation'>
<div class="cs-alert-form-btn">
	 <a class="cs-menu-btn cs-fun-btn" href="javascript:" onclick="preview();"><i class="icon iconfont icon-dayin"></i>打印</a>
      <a class="cs-menu-btn cs-fun-btn" href="javascript:" onclick="parent.closeMbIframe();" ><i class="icon iconfont icon-fanhui"></i>返回</a>
  </div>
<div class="cs-hd"></div>
<div class=WordSection1 style='layout-grid:15.6pt;text-align: center'>
<!--startprint-->

<c:forEach items="${list}" var="l">
	<div class="clearfix" style="display:inline-block; text-align:center;">
	<input type="hidden" name="samplingId" value="${l.sampling.id }"/>
	<input type="hidden" name="printNum" value="${l.sampling.printNum }"/>
<table class=MsoTableGrid border=1 cellspacing=0 cellpadding=0 width=726
 style='border-collapse:collapse;border:none;'>
 <tr style='height:29.9pt'>
  <td width=726 colspan=13 valign=top style='width:544.35pt;border:none;
  padding:0cm 5.4pt 0cm 5.4pt;height:29.9pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:22.0pt;font-family:宋体;font-weight: bolder;'>快检检测单</span></p>
  </td>
 </tr>
 <c:choose>
 	<c:when test="${l.sampling.personal==1}">
	 <tr style='height:16.25pt'>
		  <td width=470 colspan=9 valign=bottom style='width:352.45pt;border:none;
		  border-bottom:solid windowtext 1.0pt;padding:0cm 5.4pt 0cm 5.4pt;height:16.25pt'>
		  <p class=MsoNormal align=left style='text-align:left'><span style='font-family:
		  宋体'>送样时间：</span><span lang=EN-US><fmt:formatDate value="${l.sampling.samplingDate}" pattern="yyyy-MM-dd HH:mm:ss"/></span></p>
		  </td>
		  <td width=256 colspan=4 valign=bottom style='width:191.9pt;border:none;
		  border-bottom:solid windowtext 1.0pt;padding:0cm 5.4pt 0cm 5.4pt;height:16.25pt'>
		  <p class=MsoNormal><span style='font-family:宋体'>送样单号：</span><span lang=EN-US>${l.sampling.samplingNo}
		  </span></p>
		  </td>
		 </tr>
		 <tr style='height:31.2pt'>
		  <td width=131 colspan=3 style='width:98.2pt;border:solid windowtext 1.0pt;
		  border-top:none;padding:0cm 5.4pt 0cm 5.4pt;height:31.2pt'>
		  <p class=MsoNormal align=center style='text-align:center'><span
		  style='font-family:宋体'>送样人</span></p>
		  </td>
		  <td width=466 colspan=8 style='width:349.5pt;border-top:none;border-left:
		  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
		  padding:0cm 5.4pt 0cm 5.4pt;height:31.2pt'>
		  <p class=MsoNormal align=left style='text-align:left'><span style='font-family:
		  宋体'>${l.sampling.regName}</span></p>
		  </td>
		  <td width=129 colspan=2 rowspan=4 style='width:96.65pt;border-top:none;
		  border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
		  padding:0cm 5.4pt 0cm 5.4pt;height:31.2pt'>
		  <p class=MsoNormal align=center style='text-align:center'><span lang=EN-US><img
		  width=103 height=99  src="${webRoot}/resources/${l.samplingQr}"></span></p>
		  <p class=MsoNormal align=center style='text-align:center'><span
		  style='font-family:宋体'>（查询二维码）</span></p>
		  </td>
		 </tr>
		 <tr style='height:31.2pt'>
		  <td width=131 colspan=3 style='width:98.2pt;border:solid windowtext 1.0pt;
		  border-top:none;padding:0cm 5.4pt 0cm 5.4pt;height:31.2pt'>
		  <p class=MsoNormal align=center style='text-align:center'><span
		  style='font-family:宋体'>身份证号码</span></p>
		  </td>
		  <td width=466 colspan=8 style='width:349.5pt;border-top:none;border-left:
		  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
		  padding:0cm 5.4pt 0cm 5.4pt;height:31.2pt'>
		  <p class=MsoNormal align=left style='text-align:left'><span
		  style='font-family:宋体'>${l.sampling.regLicence}</span></p>
		  </td>
		 </tr>
		 <tr style='height:31.2pt'>
		  <td width=131 colspan=3 style='width:98.2pt;border:solid windowtext 1.0pt;
		  border-top:none;padding:0cm 5.4pt 0cm 5.4pt;height:31.2pt'>
		  <p class=MsoNormal align=center style='text-align:center'><span
		  style='font-family:宋体'>微&nbsp;&nbsp;信</span></p>
		  </td>
		  <td width=200 colspan=3 style='width:150.0pt;border-top:none;border-left:
		  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
		  padding:0cm 5.4pt 0cm 5.4pt;height:31.2pt'>
		  <p class=MsoNormal align=left style='text-align:left'><span lang=EN-US>${l.sampling.opePhone}</span></p>
		  </td>
		  <td width=109 colspan=1 style='width:81.75pt;border-top:none;border-left:
		  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
		  padding:0cm 5.4pt 0cm 5.4pt;height:31.2pt'>
		  <p class=MsoNormal align=center style='text-align:center'><span
		  style='font-family:宋体'>邮&nbsp;&nbsp;箱</span></p>
		  </td>
		  <td width=157 colspan=4 style='width:117.75pt;border-top:none;border-left:
		  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
		  padding:0cm 5.4pt 0cm 5.4pt;height:31.2pt'>
		  <p class=MsoNormal align=left style='text-align:left'><span lang=EN-US>${l.sampling.regLinkPerson}</span></p>
		  </td>
		 </tr>
		 <tr style='height:31.2pt'>
		  <td width=131 colspan=3 style='width:98.2pt;border:solid windowtext 1.0pt;
		  border-top:none;padding:0cm 5.4pt 0cm 5.4pt;height:31.2pt'>
		  <p class=MsoNormal align=center style='text-align:center'><span
		  style='font-family:宋体'>地&nbsp;&nbsp;址</span></p>
		  </td>
		  <td width=200 colspan=3 style='width:150.0pt;border-top:none;border-left:
		  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
		  padding:0cm 5.4pt 0cm 5.4pt;height:31.2pt'>
		  <p class=MsoNormal><span style='font-family:宋体'>${l.sampling.opeShopName}</span></p>
		  </td>
		  <td width=109 colspan=1 style='width:81.75pt;border-top:none;border-left:
		  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
		  padding:0cm 5.4pt 0cm 5.4pt;height:31.2pt'>
		  <p class=MsoNormal align=center style='text-align:center'><span
		  style='font-family:宋体'>联系电话</span></p>
		  </td>
		  <td width=157 colspan=4 style='width:117.75pt;border-top:none;border-left:
		  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
		  padding:0cm 5.4pt 0cm 5.4pt;height:31.2pt'>
		  <p class=MsoNormal align=left style='text-align:left'><span lang=EN-US>${l.sampling.regLinkPhone}</span></p>
		  </td>
		 </tr>
 	</c:when>
 	<c:otherwise>
		 <tr style='height:16.25pt'>
		  <td width=470 colspan=9 valign=bottom style='width:352.45pt;border:none;
		  border-bottom:solid windowtext 1.0pt;padding:0cm 5.4pt 0cm 5.4pt;height:16.25pt'>
		  <p class=MsoNormal align=left style='text-align:left'><span style='font-family:
		  宋体'>抽样时间：</span><span lang=EN-US><fmt:formatDate value="${l.sampling.samplingDate}" pattern="yyyy-MM-dd HH:mm:ss"/></span></p>
		  </td>
		  <td width=256 colspan=4 valign=bottom style='width:191.9pt;border:none;
		  border-bottom:solid windowtext 1.0pt;padding:0cm 5.4pt 0cm 5.4pt;height:16.25pt'>
		  <p class=MsoNormal><span style='font-family:宋体'>抽样单号：</span><span lang=EN-US>${l.sampling.samplingNo}
		  </span></p>
		  </td>
		 </tr>
		 <tr style='height:31.2pt'>
		  <td width=131 colspan=3 style='width:98.2pt;border:solid windowtext 1.0pt;
		  border-top:none;padding:0cm 5.4pt 0cm 5.4pt;height:31.2pt'>
		  <p class=MsoNormal align=center style='text-align:center'><span
		  style='font-family:宋体'>受检单位（个人）</span></p>
		  </td>
		  <td width=466 colspan=8 style='width:349.5pt;border-top:none;border-left:
		  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
		  padding:0cm 5.4pt 0cm 5.4pt;height:31.2pt'>
		  <p class=MsoNormal align=left style='text-align:left'><span style='font-family:
		  宋体'>${l.sampling.regName}</span></p>
		  </td>
		  <td width=129 colspan=2 rowspan=4 style='width:96.65pt;border-top:none;
		  border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
		  padding:0cm 5.4pt 0cm 5.4pt;height:31.2pt'>
		  <p class=MsoNormal align=center style='text-align:center'><span lang=EN-US><img
		  width=103 height=99  src="${webRoot}/resources/${l.samplingQr}"></span></p>
		  <p class=MsoNormal align=center style='text-align:center'><span
		  style='font-family:宋体'>（查询二维码）</span></p>
		  </td>
		 </tr>
		 <tr style='height:31.2pt'>
		  <td width=131 colspan=3 style='width:98.2pt;border:solid windowtext 1.0pt;
		  border-top:none;padding:0cm 5.4pt 0cm 5.4pt;height:31.2pt'>
		  <p class=MsoNormal align=center style='text-align:center'><span
		  style='font-family:宋体'>经营户名称</span></p>
		  </td>
		  <td width=466 colspan=8 style='width:349.5pt;border-top:none;border-left:
		  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
		  padding:0cm 5.4pt 0cm 5.4pt;height:31.2pt'>
		  <p class=MsoNormal align=left style='text-align:left'><span
		  style='font-family:宋体'>${l.sampling.opeShopName}</span></p>
		  </td>
		 </tr>
		 <tr style='height:31.2pt'>
		  <td width=131 colspan=3 style='width:98.2pt;border:solid windowtext 1.0pt;
		  border-top:none;padding:0cm 5.4pt 0cm 5.4pt;height:31.2pt'>
		  <p class=MsoNormal align=center style='text-align:center'><span
		  style='font-family:宋体'>档口编号</span></p>
		  </td>
		  <td width=200 colspan=3 style='width:150.0pt;border-top:none;border-left:
		  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
		  padding:0cm 5.4pt 0cm 5.4pt;height:31.2pt'>
		  <p class=MsoNormal align=left style='text-align:left'><span lang=EN-US style="font-family:宋体">${l.sampling.opeShopCode}</span></p>
		  </td>
		  <td width=109 colspan=1 style='width:81.75pt;border-top:none;border-left:
		  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
		  padding:0cm 5.4pt 0cm 5.4pt;height:31.2pt'>
		  <p class=MsoNormal align=center style='text-align:center'><span
		  style='font-family:宋体'>证照号码</span></p>
		  </td>
		  <td width=157 colspan=4 style='width:117.75pt;border-top:none;border-left:
		  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
		  padding:0cm 5.4pt 0cm 5.4pt;height:31.2pt'>
		  <p class=MsoNormal align=left style='text-align:left'><span lang=EN-US style="font-family:宋体">${l.sampling.regLicence}</span></p>
		  </td>
		 </tr>
		 <tr style='height:31.2pt'>
		  <td width=131 colspan=3 style='width:98.2pt;border:solid windowtext 1.0pt;
		  border-top:none;padding:0cm 5.4pt 0cm 5.4pt;height:31.2pt'>
		  <p class=MsoNormal align=center style='text-align:center'><span
		  style='font-family:宋体'>经营者</span></p>
		  </td>
		  <td width=200 colspan=3 style='width:150.0pt;border-top:none;border-left:
		  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
		  padding:0cm 5.4pt 0cm 5.4pt;height:31.2pt'>
		  <p class=MsoNormal><span style='font-family:宋体'>${l.sampling.opeName}</span></p>
		  </td>
		  <td width=109 colspan=1 style='width:81.75pt;border-top:none;border-left:
		  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
		  padding:0cm 5.4pt 0cm 5.4pt;height:31.2pt'>
		  <p class=MsoNormal align=center style='text-align:center'><span
		  style='font-family:宋体'>联系电话</span></p>
		  </td>
		  <td width=157 colspan=4 style='width:117.75pt;border-top:none;border-left:
		  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
		  padding:0cm 5.4pt 0cm 5.4pt;height:31.2pt'>
		  <p class=MsoNormal align=left style='text-align:left'><span lang=EN-US>${l.sampling.opePhone}</span></p>
		  </td>
		 </tr>
 	
 	</c:otherwise>
 </c:choose>
 <tr style='height:26.95pt'>
  <td width=269 colspan=5 style='width:202.1pt;border:solid windowtext 1.0pt;
  border-top:none;background:#BFBFBF;padding:0cm 5.4pt 0cm 5.4pt;height:26.95pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:14.0pt;font-family:宋体'>样品信息</span></p>
  </td>
  <td width=456 colspan=8 style='width:342.25pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  background:#BFBFBF;padding:0cm 5.4pt 0cm 5.4pt;height:26.95pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:14.0pt;font-family:宋体'>检测信息</span></p>
  </td>
 </tr>
 <tr style='height:31.45pt'>
  <td width=47 style='width:35.6pt;border:solid windowtext 1.0pt;border-top:
  none;padding:0cm 5.4pt 0cm 5.4pt;height:31.45pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-family:宋体'>编号</span></p>
  </td>
  <td width=99 colspan=2 style='width:74.25pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:31.45pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-family:宋体'>样品名称</span></p>
  </td>
  <td width=62 style='width:54.75pt;border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0cm 5.4pt 0cm 5.4pt;
  height:31.45pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-family:宋体'>抽样数量（KG）</p>
  </td>
  <td width=61 style='width:54.75pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:31.45pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-family:宋体'>进货数量（KG）</p>
  </td>
  <td width=81 colspan=2 style='width:60.9pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:31.45pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-family:宋体'>检测时间</span></p>
  </td>
  <td width=193 colspan=3 style='width:144.95pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:31.45pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-family:宋体'>检测项目</span></p>
  </td>
  <td width=53 style='width:39.75pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:31.45pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-family:宋体'>检测结果</span></p>
  </td>
  <td width=55 style='width:41.25pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:31.45pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-family:宋体'>判定标准</span></p>
  </td>
  <td width=74 style='width:55.4pt;border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0cm 5.4pt 0cm 5.4pt;
  height:31.45pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-family:宋体'>判定结果</span></p>
  </td>
 </tr>
 <c:forEach items="${l.samplingDetailList}"  var="detail" varStatus="index">
 	 <tr style='height:24.95pt'>
		  <td width=47 style='width:35.6pt;border:solid windowtext 1.0pt;border-top:
		  none;padding:0cm 5.4pt 0cm 5.4pt;height:24.95pt'>
		  <p class=MsoNormal align=center style='text-align:center'><span lang=EN-US>${index.index+1}</span></p>
		  </td>
		  <td width=99 colspan=2 style='width:74.25pt;border-top:none;border-left:none;
		  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
		  padding:0cm 5.4pt 0cm 5.4pt;height:24.95pt'>
		  <p class=MsoNormal align=center style='text-align:center'><span
		  style='font-family:宋体;color:black'>${detail.foodName}</span></p>
		  </td>
		  <td width=62 style='width:54.75pt;border-top:none;border-left:none;border-bottom:
		  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0cm 5.4pt 0cm 5.4pt;
		  height:24.95pt'>
		  <p class=MsoNormal align=center style='text-align:center'><span lang=EN-US
		  style='color:black'>${detail.sampleNumber}</span></p>
		  </td>
		  <td width=61 style='width:54.75pt;border-top:none;border-left:none;
		  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
		  padding:0cm 5.4pt 0cm 5.4pt;height:24.95pt'>
		  <p class=MsoNormal align=center style='text-align:center'><span lang=EN-US
		  style='color:black'>${detail.purchaseAmount}</span></p>
		  </td>
		  <td width=81 colspan=2 style='width:60.9pt;border-top:none;border-left:none;
		  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
		  padding:0cm 5.4pt 0cm 5.4pt;height:24.95pt'>
		  <p class=MsoNormal align=center style='text-align:center'><span lang=EN-US
		  style='color:black'><fmt:formatDate value="${detail.checkDate}" pattern="yyyy-MM-dd"/></span></p>
		  </td>
		  <td width=193 colspan=3 style='width:144.95pt;border-top:none;border-left:
		  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
		  padding:0cm 5.4pt 0cm 5.4pt;height:24.95pt'>
		  <p class=MsoNormal align=center style='text-align:center'><span
		  style='font-family:宋体;color:black'>${detail.itemName}</span></p>
		  </td>
		  <td width=53 style='width:39.75pt;border-top:none;border-left:none;
		  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
		  padding:0cm 5.4pt 0cm 5.4pt;height:24.95pt'>
		  <p class=MsoNormal align=center style='text-align:center'><span lang=EN-US
		  style='color:black'>${detail.checkResult}</span><span lang=EN-US style='font-family:"Arial",sans-serif;
		  color:black'><c:if test="${detail.checkResult eq '阳性'}">↑</c:if>
		  </span></p>
		  </td>
		  <td width=55 style='width:41.25pt;border-top:none;border-left:none;
		  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
		  padding:0cm 5.4pt 0cm 5.4pt;height:24.95pt'>
		  <p class=MsoNormal align=center style='text-align:center'><span lang=EN-US
		  style='color:black'>${detail.limitValue}</span></p>
		  </td>
		  <td width=74 style='width:55.4pt;border-top:none;border-left:none;border-bottom:
		  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0cm 5.4pt 0cm 5.4pt;
		  height:24.95pt'>
		  <p class=MsoNormal align=center style='text-align:center'><span
		  style='font-size:9.0pt;font-family:宋体;color:black'>${detail.conclusion}</span></p>
		  </td>
		 </tr>
 </c:forEach>

	<c:choose>
		<c:when test="${fn:length(l.samplingDetailList) lt 15}">
			<c:forEach begin="1" end="${15 - fn:length(l.samplingDetailList)}">
				<tr style='height:24.95pt'>
					<td width=47 style='width:35.6pt;border:solid windowtext 1.0pt;border-top:
		  none;padding:0cm 5.4pt 0cm 5.4pt;height:24.95pt'>
						<p class=MsoNormal align=center style='text-align:center'><span lang=EN-US></span></p>
					</td>
					<td width=99 colspan=2 style='width:74.25pt;border-top:none;border-left:none;
		  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
		  padding:0cm 5.4pt 0cm 5.4pt;height:24.95pt'>
						<p class=MsoNormal align=center style='text-align:center'><span
								style='font-family:宋体;color:black'></span></p>
					</td>
					<td width=62 style='width:54.75pt;border-top:none;border-left:none;border-bottom:
		  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0cm 5.4pt 0cm 5.4pt;
		  height:24.95pt'>
						<p class=MsoNormal align=center style='text-align:center'><span lang=EN-US
																						style='color:black'></span></p>
					</td>
					<td width=61 style='width:54.75pt;border-top:none;border-left:none;
		  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
		  padding:0cm 5.4pt 0cm 5.4pt;height:24.95pt'>
						<p class=MsoNormal align=center style='text-align:center'><span lang=EN-US
																						style='color:black'></span></p>
					</td>
					<td width=81 colspan=2 style='width:60.9pt;border-top:none;border-left:none;
		  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
		  padding:0cm 5.4pt 0cm 5.4pt;height:24.95pt'>
						<p class=MsoNormal align=center style='text-align:center'><span lang=EN-US
																						style='color:black'></span></p>
					</td>
					<td width=193 colspan=3 style='width:144.95pt;border-top:none;border-left:
		  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
		  padding:0cm 5.4pt 0cm 5.4pt;height:24.95pt'>
						<p class=MsoNormal align=center style='text-align:center'><span
								style='font-family:宋体;color:black'></span></p>
					</td>
					<td width=53 style='width:39.75pt;border-top:none;border-left:none;
		  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
		  padding:0cm 5.4pt 0cm 5.4pt;height:24.95pt'>
						<p class=MsoNormal align=center style='text-align:center'><span lang=EN-US
																						style='color:black'></span><span lang=EN-US style='font-family:"Arial",sans-serif;
		  color:black'></span></p>
					</td>
					<td width=55 style='width:41.25pt;border-top:none;border-left:none;
		  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
		  padding:0cm 5.4pt 0cm 5.4pt;height:24.95pt'>
						<p class=MsoNormal align=center style='text-align:center'><span lang=EN-US
																						style='color:black'></span></p>
					</td>
					<td width=74 style='width:55.4pt;border-top:none;border-left:none;border-bottom:
		  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0cm 5.4pt 0cm 5.4pt;
		  height:24.95pt'>
						<p class=MsoNormal align=center style='text-align:center'><span
								style='font-size:9.0pt;font-family:宋体;color:black'></span></p>
					</td>
				</tr>
			</c:forEach>
		</c:when>
		<c:when test="${fn:length(l.samplingDetailList) gt 15 and fn:length(l.samplingDetailList) lt 23}">
			<c:forEach begin="1" end="${23 - fn:length(l.samplingDetailList)}">
				<tr style='height:24.95pt'>
					<td width=47 style='width:35.6pt;border:solid windowtext 1.0pt;border-top:
		  none;padding:0cm 5.4pt 0cm 5.4pt;height:24.95pt'>
						<p class=MsoNormal align=center style='text-align:center'><span lang=EN-US></span></p>
					</td>
					<td width=99 colspan=2 style='width:74.25pt;border-top:none;border-left:none;
		  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
		  padding:0cm 5.4pt 0cm 5.4pt;height:24.95pt'>
						<p class=MsoNormal align=center style='text-align:center'><span
								style='font-family:宋体;color:black'></span></p>
					</td>
					<td width=62 style='width:54.75pt;border-top:none;border-left:none;border-bottom:
		  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0cm 5.4pt 0cm 5.4pt;
		  height:24.95pt'>
						<p class=MsoNormal align=center style='text-align:center'><span lang=EN-US
																						style='color:black'></span></p>
					</td>
					<td width=61 style='width:54.75pt;border-top:none;border-left:none;
		  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
		  padding:0cm 5.4pt 0cm 5.4pt;height:24.95pt'>
						<p class=MsoNormal align=center style='text-align:center'><span lang=EN-US
																						style='color:black'></span></p>
					</td>
					<td width=81 colspan=2 style='width:60.9pt;border-top:none;border-left:none;
		  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
		  padding:0cm 5.4pt 0cm 5.4pt;height:24.95pt'>
						<p class=MsoNormal align=center style='text-align:center'><span lang=EN-US
																						style='color:black'></span></p>
					</td>
					<td width=193 colspan=3 style='width:144.95pt;border-top:none;border-left:
		  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
		  padding:0cm 5.4pt 0cm 5.4pt;height:24.95pt'>
						<p class=MsoNormal align=center style='text-align:center'><span
								style='font-family:宋体;color:black'></span></p>
					</td>
					<td width=53 style='width:39.75pt;border-top:none;border-left:none;
		  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
		  padding:0cm 5.4pt 0cm 5.4pt;height:24.95pt'>
						<p class=MsoNormal align=center style='text-align:center'><span lang=EN-US
																						style='color:black'></span><span lang=EN-US style='font-family:"Arial",sans-serif;
		  color:black'></span></p>
					</td>
					<td width=55 style='width:41.25pt;border-top:none;border-left:none;
		  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
		  padding:0cm 5.4pt 0cm 5.4pt;height:24.95pt'>
						<p class=MsoNormal align=center style='text-align:center'><span lang=EN-US
																						style='color:black'></span></p>
					</td>
					<td width=74 style='width:55.4pt;border-top:none;border-left:none;border-bottom:
		  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0cm 5.4pt 0cm 5.4pt;
		  height:24.95pt'>
						<p class=MsoNormal align=center style='text-align:center'><span
								style='font-size:9.0pt;font-family:宋体;color:black'></span></p>
					</td>
				</tr>
			</c:forEach>
		</c:when>
	</c:choose>

 <tr style='height:41.55pt'>
  <td width=146 colspan=3 style='width:109.85pt;border:solid windowtext 1.0pt;
  border-top:none;padding:0cm 5.4pt 0cm 5.4pt;height:41.55pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-family:宋体'>备</span><span lang=EN-US>&nbsp; </span><span
  style='font-family:宋体'>注</span></p>
  </td>
  <td width=579 colspan=10 style='width:434.5pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:41.55pt'>
  <p class=MsoNormal><span lang=EN-US style='font-size:9.0pt'>&nbsp;</span></p>
  </td>
 </tr>
 <tr style='height:58.35pt'>
  <td width=351 colspan=7 style='width:263.0pt;border:solid windowtext 1.0pt;
  border-top:none;padding:0cm 5.4pt 0cm 5.4pt;height:116.35pt;position:relative;'>
<%--   <p class=MsoNormal><span style='font-family:宋体';margin-bottom:20px;>抽样人员：</span>${l.sampling.samplingUsername}</p> --%>
  <p class=MsoNormal style='line-height:150%'><span style='font-family:宋体'>检验人员：</span>
  	<c:forEach items="${l.recordings}" var="recording">
		<c:choose>
			<c:when test="${!empty recording.checkUserSignature && recording.checkUserSignature ne ''}">
				<img height="50" width="70" src="${webRoot}/resources/${recording.checkUserSignature}" alt="章"/>
			</c:when>
			<c:otherwise>
				${recording.checkUsername}
			</c:otherwise>
		</c:choose>
  	</c:forEach>
  </p>
  </td>
  <td width=375 colspan=6 style='width:281.35pt;border-top:none;
  border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:58.35pt;position:relative;'>
  <p class=MsoNormal style='line-height:150%'><span style='position:absolute;
  z-index:251658240;left:0px;top:0px;margin-left:113px;margin-top:1px;width:151px;
  height:151px'>
  <c:if test="${l.signatureFilePicture!=''}">
  	<img width=151 height=151 src="${webRoot}/${l.signatureFilePicture}" alt="章"/>
  </c:if>
  </span></p>
  <p class=MsoNormal style='line-height:150%'><span style='font-family:宋体'>检测机构：
	  <c:choose>
		  <c:when test="${!empty l.checkDepart && l.checkDepart ne ''}">${l.checkDepart}</c:when>
		  <c:otherwise>广东中检达元检测技术有限公司</c:otherwise>
	  </c:choose>
  </span><span
  lang=EN-US>&nbsp; </span></p>
  <p class=MsoNormal style='line-height:150%'><span lang=EN-US>&nbsp;</span></p>
  <p class=MsoNormal style='line-height:150%'><span style='font-family:宋体'>检测时间：</span>
  <span lang=EN-US>
  	<c:if test="${fn:length(l.recordings) > 0}">
  		<fmt:formatDate value="${l.recordings[0].uploadDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
  	</c:if>
  </span>
  </p>
  </td>
 </tr>
 
 <tr>
  <td colspan="20" style="border:0;">
  <p class=MsoNormal><span style='font-family:宋体'>注：此检测结果只对本次样品负责，复印无效。↑为超出判定标准。</span></p>
  </td>
 </tr>
</table>

	</div>
</c:forEach>
<!--endprint-->




</div>
<div class="cs-hd"></div>
<div class="cs-alert-form-btn">
	<a class="cs-menu-btn cs-fun-btn" href="javascript:" onclick="preview();"><i class="icon iconfont icon-dayin"></i>打印</a>
      <a class="cs-menu-btn cs-fun-btn" href="javascript:" onclick="parent.closeMbIframe();" ><i class="icon iconfont icon-fanhui"></i>返回</a>
  </div>
</body>
	<script type="text/javascript">
	var printNum=0;
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
