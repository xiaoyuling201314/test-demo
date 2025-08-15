<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/common/resource.jsp"%>
<html>

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
    {font-family:Calibri;
    panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
    {font-family:"\@宋体";
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
    mso-style-link:页眉;
    font-family:"Calibri",sans-serif;}
span.a0
    {mso-style-name:"页脚 字符";
    mso-style-link:页脚;
    font-family:"Calibri",sans-serif;}
.MsoChpDefault
    {font-size:10.0pt;
    font-family:"Calibri",sans-serif;}
 /* Page Definitions */
 @page WordSection1
    {size:595.3pt 841.9pt;
    margin:42.5pt 90.0pt 72.0pt 90.0pt;
    layout-grid:15.6pt;}
div.WordSection1
    {page:WordSection1;}

</style>

</head>

<body lang=ZH-CN style='text-justify-trim:punctuation'>
<div class="cs-hd"></div>
<div class="WordSection1 clearfix" style='layout-grid:15.6pt; text-align:center;'>

<div class="clearfix" style="display:inline-block; text-align:center;">
<!--startprint-->
<c:choose>
	<c:when test="${msg !=null }">
	<p class=MsoNormal align=center style='text-align:center'><span
	  style='font-size:22.0pt;font-family:宋体;font-weight: bolder;'>${msg}</span></p>
	</c:when>
	
	<c:when test="${sampling.personal eq 1}">
	<table class=MsoTableGrid border=1 cellspacing=0 cellpadding=0 align=left
	 width=728 style='border-collapse:collapse;border:none;margin-left:6.75pt;
	 margin-right:6.75pt'>
	 <tr style='height:22.6pt'>
	  <td width=728 colspan=9 style='width:545.85pt;border:none;padding:0cm 5.4pt 0cm 5.4pt;
	  height:22.6pt'>
	  <p class=MsoNormal align=center style='text-align:center'><span
	  style='font-size:22.0pt;font-family:宋体;font-weight: bolder;'>快检送样单</span></p>
	  </td>
	 </tr>
	 <tr style='height:17.35pt'>
	  <td width=454 colspan=6 style='width:12.0cm;border:none;border-bottom:solid black 1.5pt;
	  padding:0cm 5.4pt 0cm 5.4pt;height:17.35pt'>
	  <p class=MsoNormal><span style='font-family:宋体'>送样时间：</span><span lang=EN-US><fmt:formatDate value="${sampling.samplingDate}" pattern="yyyy-MM-dd HH:mm:ss"/></span></p>
	  </td>
	  <td width=274 colspan=3 style='width:205.65pt;border:none;border-bottom:solid black 1.5pt;
	  padding:0cm 5.4pt 0cm 5.4pt;height:17.35pt'>
	  <p class=MsoNormal align=center style='text-align:center'><span
	  style='font-family:宋体'>送样单号：</span><span lang=EN-US>${sampling.samplingNo}</span></p>
	  </td>
	 </tr>
	 <tr style='height:31.2pt'>
	  <td width=139 colspan=2 style='width:104.25pt;border-top:none;border-left:
	  solid black 1.5pt;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
	  padding:0cm 5.4pt 0cm 5.4pt;height:31.2pt'>
	  <p class=MsoNormal align=center style='text-align:center'><span
	  style='font-family:宋体'>送样人</span></p>
	  </td>
	  <td width=459 colspan=6 style='width:344.25pt;border-top:none;border-left:
	  none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
	  padding:0cm 5.4pt 0cm 5.4pt;height:31.2pt'>
	  <p class=MsoNormal align=left style='text-align:left'><span style='font-family:
	  宋体'>${sampling.regName}</span></p>
	  </td>
	  <td width=130 rowspan=4 style='width:97.35pt;border-top:none;border-left:
	  none;border-bottom:solid black 1.0pt;border-right:solid black 1.5pt;
	  padding:0cm 5.4pt 0cm 5.4pt;height:31.2pt'>
	  <p class=MsoNormal align=center style='text-align:center'><span lang=EN-US><img
	  width=103 height=99 id="图片 5" src="${webRoot}/resources/${samplingQr}"></span></p>
	  <p class=MsoNormal align=center style='text-align:center'><span
	  style='font-family:宋体'>（查询二维码）</span></p>
	  </td>
	 </tr>
	 <tr style='height:31.2pt'>
	  <td width=139 colspan=2 style='width:104.25pt;border-top:none;border-left:
	  solid black 1.5pt;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
	  padding:0cm 5.4pt 0cm 5.4pt;height:31.2pt'>
	  <p class=MsoNormal align=center style='text-align:center'><span
	  style='font-family:宋体'>身份证号码</span></p>
	  </td>
	  <td width=459 colspan=6 style='width:344.25pt;border-top:none;border-left:
	  none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
	  padding:0cm 5.4pt 0cm 5.4pt;height:31.2pt'>
	  <p class=MsoNormal align=left style='text-align:left'><span
	  style='font-family:宋体'>${sampling.regLicence}</span></p>
	  </td>
	 </tr>
	 <tr style='height:31.2pt'>
	  <td width=139 colspan=2 style='width:104.25pt;border-top:none;border-left:
	  solid black 1.5pt;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
	  padding:0cm 5.4pt 0cm 5.4pt;height:31.2pt'>
	  <p class=MsoNormal align=center style='text-align:center'><span
	  style='font-family:宋体'>微&nbsp;&nbsp;信</span></p>
	  </td>
	  <td width=143 style='width:107.0pt;border-top:none;border-left:none;
	  border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;padding:0cm 5.4pt 0cm 5.4pt;
	  height:31.2pt'>
	  <p class=MsoNormal align=left style='text-align:left'><span lang=EN-US>${sampling.opePhone}</span></p>
	  </td>
	  <td width=124 colspan=2 style='width:93.0pt;border-top:none;border-left:none;
	  border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;padding:0cm 5.4pt 0cm 5.4pt;
	  height:31.2pt'>
	  <p class=MsoNormal align=center style='text-align:center'><span
	  style='font-family:宋体'>邮&nbsp;&nbsp;箱</span></p>
	  </td>
	  <td width=192 colspan=3 style='width:144.25pt;border-top:none;border-left:
	  none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
	  padding:0cm 5.4pt 0cm 5.4pt;height:31.2pt'>
	  <p class=MsoNormal align=left style='text-align:left'><span lang=EN-US>${sampling.regLinkPerson}</span></p>
	  </td>
	 </tr>
	 <tr style='height:31.2pt'>
	  <td width=139 colspan=2 style='width:104.25pt;border-top:none;border-left:
	  solid black 1.5pt;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
	  padding:0cm 5.4pt 0cm 5.4pt;height:31.2pt'>
	  <p class=MsoNormal align=center style='text-align:center'><span
	  style='font-family:宋体'>地&nbsp;&nbsp;址</span></p>
	  </td>
	  <td width=143 style='width:107.0pt;border-top:none;border-left:none;
	  border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;padding:0cm 5.4pt 0cm 5.4pt;
	  height:31.2pt'>
	  <p class=MsoNormal><span style='font-family:宋体'>${sampling.opeShopName}</span></p>
	  </td>
	  <td width=124 colspan=2 style='width:93.0pt;border-top:none;border-left:none;
	  border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;padding:0cm 5.4pt 0cm 5.4pt;
	  height:31.2pt'>
	  <p class=MsoNormal align=center style='text-align:center'><span
	  style='font-family:宋体'>联系电话</span></p>
	  </td>
	  <td width=192 colspan=3 style='width:144.25pt;border-top:none;border-left:
	  none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
	  padding:0cm 5.4pt 0cm 5.4pt;height:31.2pt'>
	  <p class=MsoNormal align=left style='text-align:left'><span lang=EN-US>${sampling.regLinkPhone}</span></p>
	  </td>
	 </tr>
	 <tr style='height:28.8pt'>
	  <td width=44 style='width:33.0pt;border-top:none;border-left:solid black 1.5pt;
	  border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;background:
	  #BFBFBF;padding:0cm 5.4pt 0cm 5.4pt;height:28.8pt'>
	  <p class=MsoNormal align=center style='text-align:center'><span
	  style='font-family:宋体'>编号</span></p>
	  </td>
	  <td width=95 style='width:71.25pt;border-top:none;border-left:none;
	  border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;background:
	  #BFBFBF;padding:0cm 5.4pt 0cm 5.4pt;height:28.8pt'>
	  <p class=MsoNormal align=center style='text-align:center'><span
	  style='font-family:宋体'>样品</span></p>
	  </td>
	  <td width=143 style='width:107.0pt;border-top:none;border-left:none;
	  border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;background:
	  #BFBFBF;padding:0cm 5.4pt 0cm 5.4pt;height:28.8pt'>
	  <p class=MsoNormal align=center style='text-align:center'><span
	  style='font-family:宋体'>检测项目</span></p>
	  </td>
	  <td width=62 style='width:46.5pt;border-top:none;border-left:none;border-bottom:
	  solid black 1.0pt;border-right:solid black 1.0pt;background:#BFBFBF;
	  padding:0cm 5.4pt 0cm 5.4pt;height:28.8pt'>
	  <p class=MsoNormal align=center style='text-align:center'><span
	  style='font-family:宋体'>抽样数量</span><span lang=EN-US>(KG)</span></p>
	  </td>
	  <td width=62 style='width:46.5pt;border-top:none;border-left:none;border-bottom:
	  solid black 1.0pt;border-right:solid black 1.0pt;background:#BFBFBF;
	  padding:0cm 5.4pt 0cm 5.4pt;height:28.8pt'>
	  <p class=MsoNormal align=center style='text-align:center'><span
	  style='font-family:宋体'>进货数量</span><span lang=EN-US>(KG)</span></p>
	  </td>
	  <td width=85 colspan=2 style='width:63.75pt;border-top:none;border-left:none;
	  border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;background:
	  #BFBFBF;padding:0cm 5.4pt 0cm 5.4pt;height:28.8pt'>
	  <p class=MsoNormal align=center style='text-align:center'><span
	  style='font-family:宋体'>进货日期</span></p>
	  </td>
	  <td width=107 style='width:80.5pt;border-top:none;border-left:none;
	  border-bottom:solid black 1.0pt;border-right:solid windowtext 1.0pt;
	  background:#BFBFBF;padding:0cm 5.4pt 0cm 5.4pt;height:28.8pt'>
	  <p class=MsoNormal align=center style='text-align:center'><span
	  style='font-family:宋体'>产地</span></p>
	  </td>
	  <td width=130 style='width:97.35pt;border-top:none;border-left:none;
	  border-bottom:solid black 1.0pt;border-right:solid black 1.5pt;background:
	  #BFBFBF;padding:0cm 5.4pt 0cm 5.4pt;height:28.8pt'>
	  <p class=MsoNormal align=center style='text-align:center'><span
	  style='font-family:宋体'>备注</span></p>
	  </td>
	 </tr>
	 <c:forEach items="${samplingDetailList}" var="detail" varStatus="index">
	 		<tr style='height:29.2pt'>
			  <td width=44 style='width:33.0pt;border-top:none;border-left:solid black 1.5pt;
			  border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;padding:0cm 5.4pt 0cm 5.4pt;
			  height:29.2pt'>
			  <p class=MsoNormal align=center style='text-align:center'><span lang=EN-US>${index.index+1}</span></p>
			  </td>
			  <td width=95 style='width:71.25pt;border-top:none;border-left:none;
			  border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;padding:0cm 5.4pt 0cm 5.4pt;
			  height:29.2pt'>
			  <p class=MsoNormal align=left style='text-align:left'><span style='font-family:
			  宋体;color:black'>${detail.foodName}</span></p>
			  </td>
			  <td width=143 style='width:107.0pt;border-top:none;border-left:none;
			  border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;padding:0cm 5.4pt 0cm 5.4pt;
			  height:29.2pt'>
			  <p class=MsoNormal align=center style='text-align:center'><span
			  style='font-family:宋体;color:black'>${detail.itemName}</span></p>
			  </td>
			  <td width=62 style='width:46.5pt;border-top:none;border-left:none;border-bottom:
			  solid black 1.0pt;border-right:solid black 1.0pt;padding:0cm 5.4pt 0cm 5.4pt;
			  height:29.2pt'>
			  <p class=MsoNormal align=center style='text-align:center'><span lang=EN-US
			  style='color:black'>${detail.sampleNumber}</span></p>
			  </td>
			  <td width=62 style='width:46.5pt;border-top:none;border-left:none;border-bottom:
			  solid black 1.0pt;border-right:solid black 1.0pt;padding:0cm 5.4pt 0cm 5.4pt;
			  height:29.2pt'>
			  <p class=MsoNormal align=center style='text-align:center'><span lang=EN-US
			  style='color:black'>${detail.purchaseAmount}</span></p>
			  </td>
			  <td width=85 colspan=2 style='width:63.75pt;border-top:none;border-left:none;
			  border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;padding:0cm 5.4pt 0cm 5.4pt;
			  height:29.2pt'>
			  <p class=MsoNormal align=center style='text-align:center'><span lang=EN-US
			  style='color:black'><fmt:formatDate value="${detail.purchaseDate}" pattern="yyyy-MM-dd"/> </span></p>
			  </td>
			  <td width=107 style='width:80.5pt;border-top:none;border-left:none;
			  border-bottom:solid black 1.0pt;border-right:solid windowtext 1.0pt;
			  padding:0cm 5.4pt 0cm 5.4pt;height:29.2pt'>
			  <p class=MsoNormal align=center style='text-align:center'><span
			  style='font-family:宋体;color:black'>${detail.origin}</span></p>
			  </td>
			  <td width=130 style='width:97.35pt;border-top:none;border-left:none;
			  border-bottom:solid black 1.0pt;border-right:solid black 1.5pt;background:
			  white;padding:0cm 5.4pt 0cm 5.4pt;height:29.2pt'>
			  <p class=MsoNormal align=center style='text-align:center'><span
			  style='font-family:宋体;color:black'>${detail.remark}</span></p>
			  </td>
			 </tr>
	 </c:forEach>
	 <c:forEach begin="${fn:length(samplingDetailList)}" end="9" var="i">
	 	 		<tr style='height:29.2pt'>
			  <td width=44 style='width:33.0pt;border-top:none;border-left:solid black 1.5pt;
			  border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;padding:0cm 5.4pt 0cm 5.4pt;
			  height:29.2pt'>
			  <p class=MsoNormal align=center style='text-align:center'><span lang=EN-US></span></p>
			  </td>
			  <td width=95 style='width:71.25pt;border-top:none;border-left:none;
			  border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;padding:0cm 5.4pt 0cm 5.4pt;
			  height:29.2pt'>
			  <p class=MsoNormal align=left style='text-align:left'><span style='font-family:
			  宋体;color:black'></span></p>
			  </td>
			  <td width=143 style='width:107.0pt;border-top:none;border-left:none;
			  border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;padding:0cm 5.4pt 0cm 5.4pt;
			  height:29.2pt'>
			  <p class=MsoNormal align=center style='text-align:center'><span
			  style='font-family:宋体;color:black'></span></p>
			  </td>
			  <td width=62 style='width:46.5pt;border-top:none;border-left:none;border-bottom:
			  solid black 1.0pt;border-right:solid black 1.0pt;padding:0cm 5.4pt 0cm 5.4pt;
			  height:29.2pt'>
			  <p class=MsoNormal align=center style='text-align:center'><span lang=EN-US
			  style='color:black'></span></p>
			  </td>
			  <td width=62 style='width:46.5pt;border-top:none;border-left:none;border-bottom:
			  solid black 1.0pt;border-right:solid black 1.0pt;padding:0cm 5.4pt 0cm 5.4pt;
			  height:29.2pt'>
			  <p class=MsoNormal align=center style='text-align:center'><span lang=EN-US
			  style='color:black'></span></p>
			  </td>
			  <td width=85 colspan=2 style='width:63.75pt;border-top:none;border-left:none;
			  border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;padding:0cm 5.4pt 0cm 5.4pt;
			  height:29.2pt'>
			  <p class=MsoNormal align=center style='text-align:center'><span lang=EN-US
			  style='color:black'></span></p>
			  </td>
			  <td width=107 style='width:80.5pt;border-top:none;border-left:none;
			  border-bottom:solid black 1.0pt;border-right:solid windowtext 1.0pt;
			  padding:0cm 5.4pt 0cm 5.4pt;height:29.2pt'>
			  <p class=MsoNormal align=center style='text-align:center'><span
			  style='font-family:宋体;color:black'></span></p>
			  </td>
			  <td width=130 style='width:97.35pt;border-top:none;border-left:none;
			  border-bottom:solid black 1.0pt;border-right:solid black 1.5pt;background:
			  white;padding:0cm 5.4pt 0cm 5.4pt;height:29.2pt'>
			  <p class=MsoNormal align=center style='text-align:center'><span
			  style='font-family:宋体;color:black'></span></p>
			  </td>
			 </tr>
	 </c:forEach>
	 <tr style='height:115.05pt'>
	  <td width=344 colspan=4 style='width:257.75pt;border-top:none;border-left:
	  solid black 1.5pt;border-bottom:solid black 1.5pt;border-right:solid black 1.0pt;
	  padding:0cm 5.4pt 0cm 5.4pt;height:115.05pt; position:relative;'>
	  <p class=MsoNormal style='line-height:150%; margin-top:-30px;'><span style='font-family:宋体;font-weight: bolder;'>受检单位（个人）对抽样程序、过程、封样状态及上述内容无异议。</span></p>
	  <p class=MsoNormal><span lang=EN-US>&nbsp;</span></p>
	  <p class=MsoNormal style="margin-top:25px;"><span style='font-family:宋体'>送样人签名：<span style='position:absolute;
	  z-index:251659264;left:0;margin-left:85px;margin-top:1px;width:143px;
	  height:143px;top:50px;'>
	  <c:if test="${sampling.opeSignature!=''}">
	  <img src="${webRoot}/resources/${signaturePath}" alt="" style="width:160px;height: 100px;" />
	  </c:if>
	  </span></span> <span lang=EN-US>&nbsp;&nbsp;&nbsp;&nbsp;</span></p>
	  </td>
	  <td width=384 colspan=5 style='width:288.1pt;border-top:none;border-left:
	  none;border-bottom:solid black 1.5pt;border-right:solid black 1.5pt;
	  padding:0cm 5.4pt 0cm 5.4pt;height:115.05pt;position:relative;'>
	  <p class=MsoNormal style='line-height:150%'><span style='position:absolute;
	  z-index:251659264;left:0px;margin-left:135px;margin-top:1px;width:143px;
	  height:143px;top:3px;'><img width=143 height=143
	  src="${webRoot}/img/sheet_img/image002.gif" alt=章></span><span style='font-family:
	  宋体'>抽样人员：${sampling.samplingUsername}</span> </p>
	  <p class=MsoNormal style='line-height:150%'><span lang=EN-US>&nbsp;</span></p>
	  <p class=MsoNormal style='line-height:150%'><span style='font-family:宋体'>抽样单位（公章）：</span><span
	  lang=EN-US>&nbsp;&nbsp; </span></p>
	  </td>
	 </tr>
	 <tr height=0>
	  <td colspan="20" style="border:0;"><p class=MsoNormal><span style='font-family:宋体'>注：本样品单由受检单位/个人协助抽样人员如实填写。</span></p></td>
	 </tr>
	</table>
	</c:when>
	
	<c:otherwise>
	<table class=MsoTableGrid border=1 cellspacing=0 cellpadding=0 align=left
	 width=728 style='border-collapse:collapse;border:none;margin-left:6.75pt;
	 margin-right:6.75pt'>
	 <tr style='height:22.6pt'>
	  <td width=728 colspan=9 style='width:545.85pt;border:none;padding:0cm 5.4pt 0cm 5.4pt;
	  height:22.6pt'>
	  <p class=MsoNormal align=center style='text-align:center'><span
	  style='font-size:22.0pt;font-family:宋体;font-weight: bolder;'>快检抽样单</span></p>
	  </td>
	 </tr>
	 <tr style='height:17.35pt'>
	  <td width=454 colspan=6 style='width:12.0cm;border:none;border-bottom:solid black 1.5pt;
	  padding:0cm 5.4pt 0cm 5.4pt;height:17.35pt'>
	  <p class=MsoNormal><span style='font-family:宋体'>抽样时间：</span><span lang=EN-US><fmt:formatDate value="${sampling.samplingDate}" pattern="yyyy-MM-dd HH:mm:ss"/></span></p>
	  </td>
	  <td width=274 colspan=3 style='width:205.65pt;border:none;border-bottom:solid black 1.5pt;
	  padding:0cm 5.4pt 0cm 5.4pt;height:17.35pt'>
	  <p class=MsoNormal align=center style='text-align:center'><span
	  style='font-family:宋体'>抽样单号：</span><span lang=EN-US>${sampling.samplingNo}</span></p>
	  </td>
	 </tr>
	 <tr style='height:31.2pt'>
	  <td width=139 colspan=2 style='width:104.25pt;border-top:none;border-left:
	  solid black 1.5pt;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
	  padding:0cm 5.4pt 0cm 5.4pt;height:31.2pt'>
	  <p class=MsoNormal align=center style='text-align:center'><span
	  style='font-family:宋体'>受检单位（个人）</span></p>
	  </td>
	  <td width=459 colspan=6 style='width:344.25pt;border-top:none;border-left:
	  none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
	  padding:0cm 5.4pt 0cm 5.4pt;height:31.2pt'>
	  <p class=MsoNormal align=left style='text-align:left'><span style='font-family:
	  宋体'>${sampling.regName}</span></p>
	  </td>
	  <td width=130 rowspan=4 style='width:97.35pt;border-top:none;border-left:
	  none;border-bottom:solid black 1.0pt;border-right:solid black 1.5pt;
	  padding:0cm 5.4pt 0cm 5.4pt;height:31.2pt'>
	  <p class=MsoNormal align=center style='text-align:center'><span lang=EN-US><img
	  width=103 height=99 id="图片 5" src="${webRoot}/resources/${samplingQr}"></span></p>
	  <p class=MsoNormal align=center style='text-align:center'><span
	  style='font-family:宋体'>（查询二维码）</span></p>
	  </td>
	 </tr>
	 <tr style='height:31.2pt'>
	  <td width=139 colspan=2 style='width:104.25pt;border-top:none;border-left:
	  solid black 1.5pt;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
	  padding:0cm 5.4pt 0cm 5.4pt;height:31.2pt'>
	  <p class=MsoNormal align=center style='text-align:center'><span
	  style='font-family:宋体'>
		   <c:choose>
			   <c:when test="${systemFlag==1}">
				   摊位名称
			   </c:when>
			   <c:otherwise>
				   经营户名称
			   </c:otherwise>
		   </c:choose>
	  </span></p>
	  </td>
	  <td width=459 colspan=6 style='width:344.25pt;border-top:none;border-left:
	  none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
	  padding:0cm 5.4pt 0cm 5.4pt;height:31.2pt'>
	  <p class=MsoNormal align=left style='text-align:left'><span
	  style='font-family:宋体'>${sampling.opeShopName}</span></p>
	  </td>
	 </tr>
	 <tr style='height:31.2pt'>
	  <td width=139 colspan=2 style='width:104.25pt;border-top:none;border-left:
	  solid black 1.5pt;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
	  padding:0cm 5.4pt 0cm 5.4pt;height:31.2pt'>
	  <p class=MsoNormal align=center style='text-align:center'><span
	  style='font-family:宋体'>
		   <c:choose>
			   <c:when test="${systemFlag==1}">
				   摊位编号
			   </c:when>
			   <c:otherwise>
				   档口编号
			   </c:otherwise>
		   </c:choose>
	  </span></p>
	  </td>
	  <td width=143 style='width:107.0pt;border-top:none;border-left:none;
	  border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;padding:0cm 5.4pt 0cm 5.4pt;
	  height:31.2pt'>
	  <p class=MsoNormal align=left style='text-align:left'><span lang=EN-US>${sampling.opeShopCode}</span></p>
	  </td>
	  <td width=124 colspan=2 style='width:93.0pt;border-top:none;border-left:none;
	  border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;padding:0cm 5.4pt 0cm 5.4pt;
	  height:31.2pt'>
	  <p class=MsoNormal align=center style='text-align:center'><span
	  style='font-family:宋体'>证照号码</span></p>
	  </td>
	  <td width=192 colspan=3 style='width:144.25pt;border-top:none;border-left:
	  none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
	  padding:0cm 5.4pt 0cm 5.4pt;height:31.2pt'>
	  <p class=MsoNormal align=left style='text-align:left'><span lang=EN-US>${sampling.regLicence}</span></p>
	  </td>
	 </tr>
	 <tr style='height:31.2pt'>
	  <td width=139 colspan=2 style='width:104.25pt;border-top:none;border-left:
	  solid black 1.5pt;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
	  padding:0cm 5.4pt 0cm 5.4pt;height:31.2pt'>
	  <p class=MsoNormal align=center style='text-align:center'><span
	  style='font-family:宋体'>经营者</span></p>
	  </td>
	  <td width=143 style='width:107.0pt;border-top:none;border-left:none;
	  border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;padding:0cm 5.4pt 0cm 5.4pt;
	  height:31.2pt'>
	  <p class=MsoNormal><span style='font-family:宋体'>${sampling.opeName}</span></p>
	  </td>
	  <td width=124 colspan=2 style='width:93.0pt;border-top:none;border-left:none;
	  border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;padding:0cm 5.4pt 0cm 5.4pt;
	  height:31.2pt'>
	  <p class=MsoNormal align=center style='text-align:center'><span
	  style='font-family:宋体'>联系电话</span></p>
	  </td>
	  <td width=192 colspan=3 style='width:144.25pt;border-top:none;border-left:
	  none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
	  padding:0cm 5.4pt 0cm 5.4pt;height:31.2pt'>
	  <p class=MsoNormal align=left style='text-align:left'><span lang=EN-US>${sampling.opePhone}</span></p>
	  </td>
	 </tr>
	 <tr style='height:28.8pt'>
	  <td width=44 style='width:33.0pt;border-top:none;border-left:solid black 1.5pt;
	  border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;background:
	  #BFBFBF;padding:0cm 5.4pt 0cm 5.4pt;height:28.8pt'>
	  <p class=MsoNormal align=center style='text-align:center'><span
	  style='font-family:宋体'>编号</span></p>
	  </td>
	  <td width=95 style='width:71.25pt;border-top:none;border-left:none;
	  border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;background:
	  #BFBFBF;padding:0cm 5.4pt 0cm 5.4pt;height:28.8pt'>
	  <p class=MsoNormal align=center style='text-align:center'><span
	  style='font-family:宋体'>样品</span></p>
	  </td>
	  <td width=143 style='width:107.0pt;border-top:none;border-left:none;
	  border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;background:
	  #BFBFBF;padding:0cm 5.4pt 0cm 5.4pt;height:28.8pt'>
	  <p class=MsoNormal align=center style='text-align:center'><span
	  style='font-family:宋体'>检测项目</span></p>
	  </td>
	  <td width=62 style='width:46.5pt;border-top:none;border-left:none;border-bottom:
	  solid black 1.0pt;border-right:solid black 1.0pt;background:#BFBFBF;
	  padding:0cm 5.4pt 0cm 5.4pt;height:28.8pt'>
	  <p class=MsoNormal align=center style='text-align:center'><span
	  style='font-family:宋体'>抽样数量</span><span lang=EN-US>(KG)</span></p>
	  </td>
	  <td width=62 style='width:46.5pt;border-top:none;border-left:none;border-bottom:
	  solid black 1.0pt;border-right:solid black 1.0pt;background:#BFBFBF;
	  padding:0cm 5.4pt 0cm 5.4pt;height:28.8pt'>
	  <p class=MsoNormal align=center style='text-align:center'><span
	  style='font-family:宋体'>进货数量</span><span lang=EN-US>(KG)</span></p>
	  </td>
	  <td width=85 colspan=2 style='width:63.75pt;border-top:none;border-left:none;
	  border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;background:
	  #BFBFBF;padding:0cm 5.4pt 0cm 5.4pt;height:28.8pt'>
	  <p class=MsoNormal align=center style='text-align:center'><span
	  style='font-family:宋体'>进货日期</span></p>
	  </td>
	  <td width=107 style='width:80.5pt;border-top:none;border-left:none;
	  border-bottom:solid black 1.0pt;border-right:solid windowtext 1.0pt;
	  background:#BFBFBF;padding:0cm 5.4pt 0cm 5.4pt;height:28.8pt'>
	  <p class=MsoNormal align=center style='text-align:center'><span
	  style='font-family:宋体'>产地</span></p>
	  </td>
	  <td width=130 style='width:97.35pt;border-top:none;border-left:none;
	  border-bottom:solid black 1.0pt;border-right:solid black 1.5pt;background:
	  #BFBFBF;padding:0cm 5.4pt 0cm 5.4pt;height:28.8pt'>
	  <p class=MsoNormal align=center style='text-align:center'><span
	  style='font-family:宋体'>备注</span></p>
	  </td>
	 </tr>
	 <c:forEach items="${samplingDetailList}" var="detail" varStatus="index">
	 		<tr style='height:29.2pt'>
			  <td width=44 style='width:33.0pt;border-top:none;border-left:solid black 1.5pt;
			  border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;padding:0cm 5.4pt 0cm 5.4pt;
			  height:29.2pt'>
			  <p class=MsoNormal align=center style='text-align:center'><span lang=EN-US>${index.index+1}</span></p>
			  </td>
			  <td width=95 style='width:71.25pt;border-top:none;border-left:none;
			  border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;padding:0cm 5.4pt 0cm 5.4pt;
			  height:29.2pt'>
			  <p class=MsoNormal align=left style='text-align:left'><span style='font-family:
			  宋体;color:black'>${detail.foodName}</span></p>
			  </td>
			  <td width=143 style='width:107.0pt;border-top:none;border-left:none;
			  border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;padding:0cm 5.4pt 0cm 5.4pt;
			  height:29.2pt'>
			  <p class=MsoNormal align=center style='text-align:center'><span
			  style='font-family:宋体;color:black'>${detail.itemName}</span></p>
			  </td>
			  <td width=62 style='width:46.5pt;border-top:none;border-left:none;border-bottom:
			  solid black 1.0pt;border-right:solid black 1.0pt;padding:0cm 5.4pt 0cm 5.4pt;
			  height:29.2pt'>
			  <p class=MsoNormal align=center style='text-align:center'><span lang=EN-US
			  style='color:black'>${detail.sampleNumber}</span></p>
			  </td>
			  <td width=62 style='width:46.5pt;border-top:none;border-left:none;border-bottom:
			  solid black 1.0pt;border-right:solid black 1.0pt;padding:0cm 5.4pt 0cm 5.4pt;
			  height:29.2pt'>
			  <p class=MsoNormal align=center style='text-align:center'><span lang=EN-US
			  style='color:black'>${detail.purchaseAmount}</span></p>
			  </td>
			  <td width=85 colspan=2 style='width:63.75pt;border-top:none;border-left:none;
			  border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;padding:0cm 5.4pt 0cm 5.4pt;
			  height:29.2pt'>
			  <p class=MsoNormal align=center style='text-align:center'><span lang=EN-US
			  style='color:black'><fmt:formatDate value="${detail.purchaseDate}" pattern="yyyy-MM-dd"/> </span></p>
			  </td>
			  <td width=107 style='width:80.5pt;border-top:none;border-left:none;
			  border-bottom:solid black 1.0pt;border-right:solid windowtext 1.0pt;
			  padding:0cm 5.4pt 0cm 5.4pt;height:29.2pt'>
			  <p class=MsoNormal align=center style='text-align:center'><span
			  style='font-family:宋体;color:black'>${detail.origin}</span></p>
			  </td>
			  <td width=130 style='width:97.35pt;border-top:none;border-left:none;
			  border-bottom:solid black 1.0pt;border-right:solid black 1.5pt;background:
			  white;padding:0cm 5.4pt 0cm 5.4pt;height:29.2pt'>
			  <p class=MsoNormal align=center style='text-align:center'><span
			  style='font-family:宋体;color:black'>${detail.remark}</span></p>
			  </td>
			 </tr>
	 </c:forEach>
	 <c:forEach begin="${fn:length(samplingDetailList)}" end="9" var="i">
	 	 		<tr style='height:29.2pt'>
			  <td width=44 style='width:33.0pt;border-top:none;border-left:solid black 1.5pt;
			  border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;padding:0cm 5.4pt 0cm 5.4pt;
			  height:29.2pt'>
			  <p class=MsoNormal align=center style='text-align:center'><span lang=EN-US></span></p>
			  </td>
			  <td width=95 style='width:71.25pt;border-top:none;border-left:none;
			  border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;padding:0cm 5.4pt 0cm 5.4pt;
			  height:29.2pt'>
			  <p class=MsoNormal align=left style='text-align:left'><span style='font-family:
			  宋体;color:black'></span></p>
			  </td>
			  <td width=143 style='width:107.0pt;border-top:none;border-left:none;
			  border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;padding:0cm 5.4pt 0cm 5.4pt;
			  height:29.2pt'>
			  <p class=MsoNormal align=center style='text-align:center'><span
			  style='font-family:宋体;color:black'></span></p>
			  </td>
			  <td width=62 style='width:46.5pt;border-top:none;border-left:none;border-bottom:
			  solid black 1.0pt;border-right:solid black 1.0pt;padding:0cm 5.4pt 0cm 5.4pt;
			  height:29.2pt'>
			  <p class=MsoNormal align=center style='text-align:center'><span lang=EN-US
			  style='color:black'></span></p>
			  </td>
			  <td width=62 style='width:46.5pt;border-top:none;border-left:none;border-bottom:
			  solid black 1.0pt;border-right:solid black 1.0pt;padding:0cm 5.4pt 0cm 5.4pt;
			  height:29.2pt'>
			  <p class=MsoNormal align=center style='text-align:center'><span lang=EN-US
			  style='color:black'></span></p>
			  </td>
			  <td width=85 colspan=2 style='width:63.75pt;border-top:none;border-left:none;
			  border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;padding:0cm 5.4pt 0cm 5.4pt;
			  height:29.2pt'>
			  <p class=MsoNormal align=center style='text-align:center'><span lang=EN-US
			  style='color:black'></span></p>
			  </td>
			  <td width=107 style='width:80.5pt;border-top:none;border-left:none;
			  border-bottom:solid black 1.0pt;border-right:solid windowtext 1.0pt;
			  padding:0cm 5.4pt 0cm 5.4pt;height:29.2pt'>
			  <p class=MsoNormal align=center style='text-align:center'><span
			  style='font-family:宋体;color:black'></span></p>
			  </td>
			  <td width=130 style='width:97.35pt;border-top:none;border-left:none;
			  border-bottom:solid black 1.0pt;border-right:solid black 1.5pt;background:
			  white;padding:0cm 5.4pt 0cm 5.4pt;height:29.2pt'>
			  <p class=MsoNormal align=center style='text-align:center'><span
			  style='font-family:宋体;color:black'></span></p>
			  </td>
			 </tr>
	 </c:forEach>
	 <tr style='height:115.05pt'>
	  <td width=344 colspan=4 style='width:257.75pt;border-top:none;border-left:
	  solid black 1.5pt;border-bottom:solid black 1.5pt;border-right:solid black 1.0pt;
	  padding:0cm 5.4pt 0cm 5.4pt;height:115.05pt; position:relative;'>
	  <p class=MsoNormal style='line-height:150%; margin-top:-30px;'><span style='font-family:宋体;font-weight: bolder;'>受检单位（个人）对抽样程序、过程、封样状态及上述内容无异议。</span></p>
	  <p class=MsoNormal><span lang=EN-US>&nbsp;</span></p>
	  <p class=MsoNormal style="margin-top:25px;"><span style='font-family:宋体'>经营户签名：<span style='position:absolute;
	  z-index:251659264;left:0;margin-left:85px;margin-top:1px;width:143px;
	  height:143px;top:50px;'>
	  <c:if test="${sampling.opeSignature!=''}">
	  <img src="${webRoot}/resources/${signaturePath}" alt="" style="width:160px;height: 100px;" />
	  </c:if>
	  </span></span> <span lang=EN-US>&nbsp;&nbsp;&nbsp;&nbsp;</span></p>
	  </td>
	  <td width=384 colspan=5 style='width:288.1pt;border-top:none;border-left:
	  none;border-bottom:solid black 1.5pt;border-right:solid black 1.5pt;
	  padding:0cm 5.4pt 0cm 5.4pt;height:115.05pt;position:relative;'>
	  <p class=MsoNormal style='line-height:150%'><span style='position:absolute;
	  z-index:251659264;left:0px;margin-left:135px;margin-top:1px;width:143px;
	  height:143px;top:3px;'><img width=143 height=143
	  src="${webRoot}/img/sheet_img/image002.gif" alt=章></span><span style='font-family:
	  宋体'>抽样人员：

	  <c:choose>
		  <c:when test="${not empty samplSignatureFile and  samplSignatureFile!=''}">
			  <img height="50" width="70" src="${webRoot}/resources/${samplSignatureFile}" alt="章"/>
		  </c:when>
		  <c:otherwise>
			  ${sampling.samplingUsername}
		  </c:otherwise>
	  </c:choose>
	  </span> </p>
	  <p class=MsoNormal style='line-height:150%'><span lang=EN-US>&nbsp;</span></p>
	  <p class=MsoNormal style='line-height:150%'><span style='font-family:宋体'>抽样单位（公章）：</span><span
	  lang=EN-US>&nbsp;&nbsp; </span></p>
	  </td>
	 </tr>
	 <tr height=0>
	  <td colspan="20" style="border:0;"><p class=MsoNormal><span style='font-family:宋体'>注：本样品单由受检单位/个人协助抽样人员如实填写。</span></p></td>
	 </tr>
	</table>
	</c:otherwise>
</c:choose>
<!--endprint-->
</div>



</div>
<div class="cs-hd"></div>
<%-- <div class="cs-alert-form-btn">
	  <a class="cs-menu-btn cs-fun-btn" href="javascript:;" onclick="preview();"><i class="icon iconfont icon-dayin"></i>打印</a>
      <a class="cs-menu-btn cs-fun-btn" href="${webRoot}/sampling/list.do" ><i class="icon iconfont icon-fanhui"></i>返回</a>
  </div>
 --%>
</body>
</html>
