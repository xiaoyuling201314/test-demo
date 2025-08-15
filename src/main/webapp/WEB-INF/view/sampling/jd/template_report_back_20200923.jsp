<%@page import="com.alibaba.fastjson.JSONArray" %>
<%@page import="com.alibaba.fastjson.JSONObject" %>
<%@page import="java.util.Date" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@include file="/WEB-INF/view/common/resource.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <style>

        /* Font Definitions */
        @font-face {
            font-family: 宋体;
            panose-1: 2 1 6 0 3 1 1 1 1 1;
        }

        @font-face {
            font-family: "Cambria Math";
            panose-1: 2 4 5 3 5 4 6 3 2 4;
        }

        @font-face {
            font-family: 等线;
            panose-1: 2 1 6 0 3 1 1 1 1 1;
        }

        @font-face {
            font-family: Calibri;
            panose-1: 2 15 5 2 2 2 4 3 2 4;
        }

        @font-face {
            font-family: "\@宋体";
            panose-1: 2 1 6 0 3 1 1 1 1 1;
        }

        @font-face {
            font-family: "\@等线";
            panose-1: 2 1 6 0 3 1 1 1 1 1;
        }

        /* Style Definitions */
        p.MsoNormal, li.MsoNormal, div.MsoNormal {
            margin: 0cm;
            margin-bottom: .0001pt;
            text-align: justify;
            text-justify: inter-ideograph;
            font-size: 10.5pt;
            font-family: "Calibri", sans-serif;
        }

        p.MsoHeader, li.MsoHeader, div.MsoHeader {
            mso-style-link: "页眉 字符";
            margin: 0cm;
            margin-bottom: .0001pt;
            text-align: center;
            layout-grid-mode: char;
            border: none;
            padding: 0cm;
            font-size: 9.0pt;
            font-family: "Calibri", sans-serif;
        }

        p.MsoFooter, li.MsoFooter, div.MsoFooter {
            mso-style-link: "页脚 字符";
            margin: 0cm;
            margin-bottom: .0001pt;
            layout-grid-mode: char;
            font-size: 9.0pt;
            font-family: "Calibri", sans-serif;
        }

        span.a {
            mso-style-name: "页眉 字符";
            mso-style-link: 页眉;
        }

        span.a0 {
            mso-style-name: "页脚 字符";
            mso-style-link: 页脚;
        }

        .MsoChpDefault {
            font-size: 10.0pt;
            font-family: "Calibri", sans-serif;
        }

        /* Page Definitions */
        @page WordSection1 {
            size: 595.3pt 841.9pt;
            margin: 42.5pt 90.0pt 2.0cm 90.0pt;
            layout-grid: 15.6pt;
        }

        div.WordSection1 {
            page: WordSection1;
        }

        .reportBorder {
            border: 1px solid #000;
            margin: 0 auto;
            margin-bottom: 50px;
        }

        @media print {
            .reportBorder {
                border-width: 0;
                margin-bottom: 0;
            }
        }
        .tr-height{
            height: 54px;
        }
    </style>

</head>

<body lang=ZH-CN style='text-justify-trim:punctuation'>
<div class="cs-alert-form-btn">
    <a class="cs-menu-btn cs-fun-btn" href="javascript:" onclick="preview();"><i class="icon iconfont icon-dayin"></i>打印</a>
    <a class="cs-menu-btn cs-fun-btn" href="javascript:" onclick="parent.closeMbIframe();"><i class="icon iconfont icon-fanhui"></i>返回</a>
</div>
<div class="cs-hd"></div>
<div class=WordSection1 style='layout-grid:15.6pt;text-align: center'>
    <!--startprint-->

    <c:forEach items="${list}" var="l">
        <!--公共变量-->
        <!-- 每页展示多少条数据 -->
        <c:set var="pageSize" value="15"/>
        <!-- 打印页数 -->
        <c:set var="printPage" value="${fn:length(l.samplingDetailList)%pageSize==0? fn:length(l.samplingDetailList)/pageSize : (fn:length(l.samplingDetailList)/pageSize+1)}"/>
        <c:set var="serialNumber" value="0"/>
        <!-- 京东定制报告封面开始 -->
        <div class="reportBorder" style=" width: 730px; height: 1065px; position: relative;">
            <div align="center">
                <table class=MsoTableGrid border=1 cellspacing=0 style="border-collapse:collapse;width:492.8500pt;border:none;
                mso-border-left-alt:0.5000pt solid windowtext;mso-border-top-alt:0.5000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext;
                mso-border-bottom-alt:0.5000pt solid windowtext;mso-border-insideh:0.5000pt solid windowtext;mso-border-insidev:0.5000pt solid windowtext;
                mso-padding-alt:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;">
                    <tr style="height:65.9500pt;">
                        <td width=466 valign=center style="width:350.1000pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none;
                        mso-border-left-alt:none;border-right:none;mso-border-right-alt:none;
                        border-top:none;mso-border-top-alt:none;border-bottom:none;
                        mso-border-bottom-alt:none;">
                            <p class=MsoNormal align=justify style="text-align:justify;text-justify:inter-ideograph;line-height:200%;">
                                <span style="font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri; mso-bidi-font-family:'Times New Roman';font-size:10.5000pt;mso-font-kerning:1.0000pt;">
                                <img width="217" height="85" src="${webRoot}/img/jd/logo.png" align="left" hspace="12"></span>
                                <span style="font-family:微软雅黑;line-height:200%;letter-spacing:0.0000pt; font-weight:normal;font-size:12.0000pt;mso-font-kerning:1.0000pt;"> </span>
                            </p>
                        </td>
                        <td width=190 valign=center style="width:142.7500pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none;
                        mso-border-left-alt:none;border-right:none;mso-border-right-alt:none;
                        border-top:none;mso-border-top-alt:none;border-bottom:none;
                        mso-border-bottom-alt:none;">
                            <p class=MsoNormal align=right style="text-align:right;">
                                <b>
                              <span style="mso-spacerun:'yes';font-family:微软雅黑;line-height:200%; letter-spacing:0.0000pt;font-weight:bold;font-size:18.0000pt; mso-font-kerning:1.0000pt;">检 测 报 告</span>
                                </b>
                                <b>
                                <span style="font-family:微软雅黑;line-height:200%;letter-spacing:0.0000pt; font-weight:bold;font-size:15.0000pt;mso-font-kerning:1.0000pt;"> </span>
                                </b>
                            </p>
                            <p class=MsoNormal align=right style="text-align:right;">
                                <span style="font-family:微软雅黑;line-height:200%;letter-spacing:0.0000pt; font-weight:normal;font-size:12.0000pt;mso-font-kerning:1.0000pt;">（</span>
                                <span style="mso-spacerun:'yes';font-family:微软雅黑;line-height:200%; letter-spacing:0.5500pt;font-weight:normal;font-size:12.0000pt; mso-font-kerning:1.0000pt;">Test Report</span>
                                <span style="font-family:微软雅黑;line-height:200%;letter-spacing:0.0000pt; font-weight:normal;font-size:12.0000pt;mso-font-kerning:1.0000pt;">）</span>
                                <span style="font-family:微软雅黑;line-height:200%;letter-spacing:0.0000pt; font-weight:normal;font-size:12.0000pt;mso-font-kerning:1.0000pt;"> </span>
                            </p>
                        </td>
                    </tr>
                    <tr class="tr-height">

                    </tr>
                </table>
            </div>
            <p class=MsoNormal>
                <span style="mso-spacerun:'yes';font-family:宋体;mso-ascii-font-family:Calibri; mso-hansi-font-family:Calibri;mso-bidi-font-family:'Times New Roman';font-size:16.0000pt; mso-font-kerning:1.0000pt;"> </span>
            </p>
            <p class=MsoNormal align=center style="text-align:center;">
                <span style="mso-spacerun:'yes';font-family:宋体;mso-ascii-font-family:Calibri; mso-hansi-font-family:Calibri;mso-bidi-font-family:'Times New Roman';font-size:16.0000pt; mso-font-kerning:1.0000pt;">
                  <font face="宋体">报告编号</font>( ReportID )
                  <font face="宋体">：</font>
                  <font face="Calibri">${l.sampling.samplingNo}</font></span>
                <span style="mso-spacerun:'yes';font-family:宋体;mso-ascii-font-family:Calibri; mso-hansi-font-family:Calibri;mso-bidi-font-family:'Times New Roman';font-size:16.0000pt; mso-font-kerning:1.0000pt;"> </span>
            </p>
            <p class=MsoNormal style="text-align:left;line-height:150%;">
                <span style="mso-spacerun:'yes';font-family:微软雅黑;line-height:150%; letter-spacing:0.0000pt;font-weight:normal;font-size:12.0000pt; mso-font-kerning:1.0000pt;"> </span>
            </p>
            <p class=MsoNormal style="text-align:left;line-height:150%;">
                <span style="mso-spacerun:'yes';font-family:微软雅黑;line-height:150%; letter-spacing:0.0000pt;font-weight:normal;font-size:12.0000pt; mso-font-kerning:1.0000pt;"> </span>
            </p>
            <p class=MsoNormal style="text-align:left;line-height:150%;">
                <span style="mso-spacerun:'yes';font-family:微软雅黑;line-height:150%; letter-spacing:0.0000pt;font-weight:normal;font-size:12.0000pt; mso-font-kerning:1.0000pt;"> </span>
            </p>
            <p class=MsoNormal align=center style="text-align:center;margin-top:50px;">
                <b>
                <span style="mso-spacerun:'yes';font-family:微软雅黑;letter-spacing:0.0000pt; font-weight:bold;font-size:36.0000pt;mso-font-kerning:1.0000pt;">
                    <font face="微软雅黑">检</font>
                    <font face="微软雅黑">测</font>
                    <font face="微软雅黑">报</font>
                    <font face="微软雅黑">告</font></span>
                </b>
                <b>
                <span style="mso-spacerun:'yes';font-family:微软雅黑;letter-spacing:0.0000pt; font-weight:bold;font-size:36.0000pt;mso-font-kerning:1.0000pt;"> </span>
                </b>
            </p>
            <p class=MsoNormal align=center style="text-align:center;">
                <span style="mso-spacerun:'yes';font-family:微软雅黑;letter-spacing:0.0000pt; font-weight:normal;font-size:22.0000pt;mso-font-kerning:1.0000pt;"> <font face="微软雅黑">（</font></span>
                <span style="mso-spacerun:'yes';font-family:微软雅黑;letter-spacing:0.5500pt; font-weight:normal;font-size:22.0000pt;mso-font-kerning:1.0000pt;">Test Report</span>
                <span style="mso-spacerun:'yes';font-family:微软雅黑;letter-spacing:0.0000pt; font-weight:normal;font-size:22.0000pt;mso-font-kerning:1.0000pt;"> <font face="微软雅黑">）</font></span>
                <span style="mso-spacerun:'yes';font-family:微软雅黑;letter-spacing:0.0000pt; font-weight:normal;font-size:22.0000pt;mso-font-kerning:1.0000pt;"> </span>
            </p>
            <p class=MsoNormal style="text-align:left;line-height:150%;">
                <span style="mso-spacerun:'yes';font-family:微软雅黑;line-height:150%; letter-spacing:0.0000pt;font-weight:normal;font-size:12.0000pt; mso-font-kerning:1.0000pt;"> </span>
            </p>
            <p class=MsoNormal style="text-align:left;line-height:150%;">
                <span style="mso-spacerun:'yes';font-family:微软雅黑;line-height:150%; letter-spacing:0.0000pt;font-weight:normal;font-size:12.0000pt; mso-font-kerning:1.0000pt;"> </span>
            </p>
            <p class=MsoNormal  style="margin-top:160px; padding-left:165px;">
                <span style="mso-spacerun:'yes';font-family:微软雅黑;letter-spacing:2.2500pt; font-weight:normal;font-size:15.0000pt;mso-font-kerning:1.0000pt;"> <font face="微软雅黑">样品名称：</font></span>
                <u>
                    <span style="mso-spacerun:'yes';font-family:微软雅黑;letter-spacing:2.2500pt; font-weight:normal;font-size:15.0000pt;mso-font-kerning:1.0000pt; width:275px; display: inline-block;border-bottom: 2px solid #000">
                    <font face="微软雅黑">${reportModel.foodNae}</font>
                    </span>
                </u>
                <u>
                 <span style="mso-spacerun:'yes';font-family:微软雅黑;letter-spacing:2.2500pt; font-weight:normal;text-decoration:underline;text-underline:single; font-size:15.0000pt;mso-font-kerning:1.0000pt;">  </span>
                </u>
            </p>

            <p class=MsoNormal  style="margin-top:30px; padding-left:165px;">
                <span style="mso-spacerun:'yes';font-family:微软雅黑;letter-spacing:2.2500pt; font-weight:normal;font-size:15.0000pt;mso-font-kerning:1.0000pt;"> <font face="微软雅黑">检测日期：</font></span>
                <u>
                    <span style="mso-spacerun:'yes';font-family:微软雅黑;letter-spacing:2.2500pt; font-weight:normal; width:275px; display: inline-block;border-bottom: 2px solid #000; font-size:15.0000pt;mso-font-kerning:1.0000pt;">
                      <c:if test="${fn:length(l.recordings) > 0}">
                          <fmt:formatDate value="${l.recordings[0].uploadDate}" pattern="yyyy/MM/dd"/>
                      </c:if>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    </span>
                </u>
                <u>
                    <span style="mso-spacerun:'yes';font-family:微软雅黑;letter-spacing:2.2500pt; font-weight:normal;text-decoration:underline;text-underline:single; font-size:15.0000pt;mso-font-kerning:1.0000pt;">  </span>
                </u>
            </p>
            <p class="MsoNormal" align="center" style="text-align:center; position:absolute; bottom:10px;left:0; width:100%;">
                <span style="mso-spacerun:'yes';font-family:微软雅黑;letter-spacing:0.5500pt; font-weight:normal;font-size:14.0000pt;mso-font-kerning:1.0000pt;">
                    <font face="微软雅黑">广东中检达元检测技术有限公司</font></span>
                <u>
                <span style="mso-spacerun:'yes';font-family:微软雅黑;letter-spacing:0.5500pt; font-weight:normal;text-decoration:underline;text-underline:single; font-size:14.0000pt;mso-font-kerning:1.0000pt;"> </span>
                </u>
            </p>
        </div>

        <!--检测报告第二页-->
        <div class="reportBorder" style=" width: 730px; height: 1065px; position: relative;">

            <div align=center>
                <table class=MsoTableGrid border=1 cellspacing=0 style="border-collapse:collapse;width:497.1000pt;border:none;
                    mso-border-left-alt:0.5000pt solid windowtext;mso-border-top-alt:0.5000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext;
                    mso-border-bottom-alt:0.5000pt solid windowtext;mso-border-insideh:0.5000pt solid windowtext;mso-border-insidev:0.5000pt solid windowtext;
                    mso-padding-alt:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;">
                    <tr style="height:65.9500pt;">
                        <td width=469 valign=center colspan=4 style="width:352.2500pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none;
                        mso-border-left-alt:none;border-right:none;mso-border-right-alt:none;
                        border-top:none;mso-border-top-alt:none;border-bottom:none;
                        mso-border-bottom-alt:none;">
                            <p class=MsoNormal align=justify style="text-align:justify;text-justify:inter-ideograph;line-height:200%;">
                                <span style="font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri; mso-bidi-font-family:'Times New Roman';font-size:10.5000pt;mso-font-kerning:1.0000pt;">
                                <img width="217" height="85" src="${webRoot}/img/jd/logo.png" align="left" hspace="12"></span>
                                <span style="font-family:微软雅黑;line-height:200%;letter-spacing:0.0000pt; font-weight:normal;font-size:12.0000pt;mso-font-kerning:1.0000pt;"> </span>
                            </p>
                        </td>
                        <td width=193 valign=center colspan=2 style="width:144.8500pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none;
                        mso-border-left-alt:none;border-right:none;mso-border-right-alt:none;
                        border-top:none;mso-border-top-alt:none;border-bottom:none;
                        mso-border-bottom-alt:none;">
                            <p class=MsoNormal align=right style="text-align:right;">
                                <b> <span style="mso-spacerun:'yes';font-family:微软雅黑;line-height:200%; letter-spacing:0.0000pt;font-weight:bold;font-size:18.0000pt; mso-font-kerning:1.0000pt;">检 测 报 告</span></b>
                                <b> <span style="font-family:微软雅黑;line-height:200%;letter-spacing:0.0000pt; font-weight:bold;font-size:15.0000pt;mso-font-kerning:1.0000pt;"> </span></b>
                            </p>
                            <p class=MsoNormal align=right style="text-align:right;">
                                <span style="font-family:微软雅黑;line-height:200%;letter-spacing:0.0000pt; font-weight:normal;font-size:12.0000pt;mso-font-kerning:1.0000pt;">（</span>
                                <span style="mso-spacerun:'yes';font-family:微软雅黑;line-height:200%; letter-spacing:0.5500pt;font-weight:normal;font-size:12.0000pt; mso-font-kerning:1.0000pt;">Test Report</span>
                                <span style="font-family:微软雅黑;line-height:200%;letter-spacing:0.0000pt; font-weight:normal;font-size:12.0000pt;mso-font-kerning:1.0000pt;">）</span>
                                <span style="font-family:微软雅黑;line-height:200%;letter-spacing:0.0000pt; font-weight:normal;font-size:12.0000pt;mso-font-kerning:1.0000pt;"> </span>
                            </p>
                            <p class=MsoNormal align=center style="text-align:center;">
                                <span style="font-family:微软雅黑;line-height:200%;letter-spacing:0.0000pt; font-weight:normal;font-size:12.0000pt;mso-font-kerning:1.0000pt;"> </span>
                            </p>
                        </td>
                    </tr>
                    <tr class="tr-height">

                    </tr>
                    <tr style="height:4.5000pt;">
                        <td width=469 valign=top colspan=4 style="width:352.2500pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none;
                        mso-border-left-alt:none;border-right:none;mso-border-right-alt:none;
                        border-top:none;mso-border-top-alt:none;border-bottom:1.0000pt solid windowtext;
                        mso-border-bottom-alt:0.5000pt solid windowtext;">
                            <p class=MsoNormal align=justify style="text-align:justify;text-justify:inter-ideograph;line-height:200%;">
                                <span style="mso-spacerun:'yes';font-family:宋体;line-height:200%; font-size:12.0000pt;mso-font-kerning:1.0000pt;">报告编号( ReportID )：${l.sampling.samplingNo}</span>
                                <span style="font-family:微软雅黑;line-height:200%;letter-spacing:0.0000pt; font-weight:normal;font-size:12.0000pt;mso-font-kerning:1.0000pt;"> </span>
                            </p>
                        </td>
                        <td width=193 valign=top colspan=2 style="width:144.8500pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none;
                        mso-border-left-alt:none;border-right:none;mso-border-right-alt:none;
                        border-top:none;mso-border-top-alt:none;border-bottom:1.0000pt solid windowtext;
                        mso-border-bottom-alt:0.5000pt solid windowtext;">
                            <p class=MsoNormal align=right style="text-align:right;line-height:200%;">
                                <span style="mso-spacerun:'yes';font-family:宋体;line-height:200%; font-size:12.0000pt;mso-font-kerning:1.0000pt;">第1页 共<fmt:formatNumber value="${printPage+(printPage % 1 == 0 ? 0 : -0.5)+1}" type="number" pattern="#" />页</span>
                                <span style="font-family:微软雅黑;line-height:200%;letter-spacing:0.0000pt; font-weight:normal;font-size:12.0000pt;mso-font-kerning:1.0000pt;"> </span>
                            </p>
                        </td>
                    </tr>
                    <tr style="height:54.6500pt;">
                        <td width=60 valign=center rowspan=3 style="width:45.4500pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:1.0000pt solid windowtext;
                        mso-border-left-alt:0.5000pt solid windowtext;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext;
                        border-top:none;mso-border-top-alt:none;border-bottom:1.0000pt solid windowtext;
                        mso-border-bottom-alt:0.5000pt solid windowtext;">
                            <p class=MsoNormal align=center style="text-align:center;line-height:150%;">
                            <span style="font-family:微软雅黑;line-height:200%;font-size:14.0000pt; mso-font-kerning:1.0000pt;">样</span>
                                <span style="font-family:微软雅黑;line-height:200%;font-size:14.0000pt; mso-font-kerning:1.0000pt;"> </span>
                            </p>
                            <p class=MsoNormal align=center style="text-align:center;line-height:150%;">
                                <span style="font-family:微软雅黑;line-height:200%;font-size:14.0000pt; mso-font-kerning:1.0000pt;">品</span>
                                <span style="font-family:微软雅黑;line-height:200%;font-size:14.0000pt; mso-font-kerning:1.0000pt;"> </span>
                            </p>
                            <p class=MsoNormal align=center style="text-align:center;line-height:150%;">
                                <span style="font-family:微软雅黑;line-height:200%;font-size:14.0000pt; mso-font-kerning:1.0000pt;">信</span>
                                <span style="font-family:微软雅黑;line-height:200%;font-size:14.0000pt; mso-font-kerning:1.0000pt;"> </span>
                            </p>
                            <p class=MsoNormal align=center style="text-align:center;line-height:150%;">
                                <span style="font-family:微软雅黑;line-height:200%;font-size:14.0000pt; mso-font-kerning:1.0000pt;">息</span>
                                <span style="font-family:微软雅黑;line-height:200%;font-size:14.0000pt; mso-font-kerning:1.0000pt;"> </span>
                            </p>
                        </td>
                        <td width=156 valign=center style="width:117.3000pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none;
                        mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext;
                        border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext;
                        mso-border-bottom-alt:0.5000pt solid windowtext;">
                            <p class=MsoNormal align=center style="text-align:center;line-height:150%;">
                                <span style="mso-spacerun:'yes';font-family:微软雅黑;line-height:200%; font-size:14.0000pt;mso-font-kerning:1.0000pt;">样品名称</span>
                                <span style="font-family:微软雅黑;line-height:200%;font-size:14.0000pt; mso-font-kerning:1.0000pt;"> </span>
                            </p>
                        </td>
                        <td width=445 valign=center colspan=4 style="width:334.3500pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none;
                        mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext;
                        border-top:1.0000pt solid windowtext;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext;
                        mso-border-bottom-alt:0.5000pt solid windowtext;">
                            <p class=MsoNormal align=justify style="text-align:justify;text-justify:inter-ideograph;line-height:150%;width: 160px;word-break: break-all;">
                                <span style="font-family:微软雅黑;line-height:200%;font-size:14.0000pt; mso-font-kerning:1.0000pt;">${reportModel.foodNae}</span>
                            </p>
                        </td>
                    </tr>
                    <tr style="height:54.6500pt;">
                        <td width=156 valign=center style="width:117.3000pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none;
                        mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext;
                        border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext;
                        mso-border-bottom-alt:0.5000pt solid windowtext;">
                            <p class=MsoNormal align=center style="text-align:center;line-height:150%;">
                                <span style="mso-spacerun:'yes';font-family:微软雅黑;line-height:200%; font-size:14.0000pt;mso-font-kerning:1.0000pt;">生产/包装日期</span>
                                <span style="font-family:微软雅黑;line-height:200%;font-size:14.0000pt; mso-font-kerning:1.0000pt;"> </span>
                            </p>
                        </td>
                        <td width=172 valign=center style="width:129.7000pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none;
                        mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext;
                        border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext;
                        mso-border-bottom-alt:0.5000pt solid windowtext;">
                            <p class=MsoNormal align=justify style="text-align:justify;text-justify:inter-ideograph;line-height:150%;">
                                <span style="font-family:微软雅黑;line-height:200%;font-size:14.0000pt; mso-font-kerning:1.0000pt;"><fmt:formatDate value="${reportModel.purchaseDate}" pattern="yyyy/MM/dd"/></span>
                            </p>
                        </td>
                        <td width=94 valign=center colspan=2 style="width:70.5000pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none;
                        mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext;
                        border-top:1.0000pt solid windowtext;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext;
                        mso-border-bottom-alt:0.5000pt solid windowtext;">
                            <p class=MsoNormal align=center style="text-align:center;line-height:150%;">
                                <span style="mso-spacerun:'yes';font-family:微软雅黑;line-height:200%; font-size:14.0000pt;mso-font-kerning:1.0000pt;">SKU号</span>
                                <span style="font-family:微软雅黑;line-height:200%;font-size:14.0000pt; mso-font-kerning:1.0000pt;"> </span>
                            </p>
                        </td>
                        <td width=178 valign=center style="width:134.1500pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none;
                        mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext;
                        border-top:1.0000pt solid windowtext;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext;
                        mso-border-bottom-alt:0.5000pt solid windowtext;">
                            <p class=MsoNormal align=justify style="text-align:justify;text-justify:inter-ideograph;line-height:100%;width: 160px;word-break: break-all;">
                                <span style="font-family:微软雅黑;line-height:200%;font-size:14.0000pt; mso-font-kerning:1.0000pt;">${reportModel.batchNumber}</span>
                            </p>
                        </td>
                    </tr>
                    <tr style="height:54.6500pt;">
                        <td width=156 valign=center style="width:117.3000pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none;
                        mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext;
                        border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext;
                        mso-border-bottom-alt:0.5000pt solid windowtext;">
                            <p class=MsoNormal align=center style="text-align:center;line-height:150%;">
                                <span style="mso-spacerun:'yes';font-family:微软雅黑;line-height:200%; font-size:14.0000pt;mso-font-kerning:1.0000pt;">到样日期</span>
                                <span style="font-family:微软雅黑;line-height:200%;font-size:14.0000pt; mso-font-kerning:1.0000pt;"> </span>
                            </p>
                        </td>
                        <td width=172 valign=center style="width:129.7000pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none;
                        mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext;
                        border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext;
                        mso-border-bottom-alt:0.5000pt solid windowtext;">
                            <p class=MsoNormal align=justify style="text-align:justify;text-justify:inter-ideograph;line-height:150%;">
                                <span style="font-family:微软雅黑;line-height:200%;font-size:14.0000pt; mso-font-kerning:1.0000pt;">
                                    <fmt:formatDate value="${l.sampling.samplingDate}" pattern="yyyy/MM/dd"/>
                                </span>
                            </p>
                        </td>
                        <td width=94 valign=center colspan=2 style="width:70.5000pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none;
                        mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext;
                        border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext;
                        mso-border-bottom-alt:0.5000pt solid windowtext;">
                            <p class=MsoNormal align=center style="text-align:center;line-height:150%;">
                                <span style="mso-spacerun:'yes';font-family:微软雅黑;line-height:200%; font-size:14.0000pt;mso-font-kerning:1.0000pt;">检测日期</span>
                                <span style="font-family:微软雅黑;line-height:200%;font-size:14.0000pt; mso-font-kerning:1.0000pt;"> </span>
                            </p>
                        </td>
                        <td width=178 valign=center style="width:134.1500pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none;
                        mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext;
                        border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext;
                        mso-border-bottom-alt:0.5000pt solid windowtext;">
                            <p class=MsoNormal align=justify style="text-align:justify;text-justify:inter-ideograph;line-height:150%;">
                                <span style="font-family:微软雅黑;line-height:200%;font-size:14.0000pt; mso-font-kerning:1.0000pt;">
                                    <c:if test="${fn:length(l.recordings) > 0}">
                                        <fmt:formatDate value="${l.recordings[0].uploadDate}" pattern="yyyy/MM/dd"/>
                                    </c:if>
                                </span>
                            </p>
                        </td>
                    </tr>
                    <tr style="height:54.6500pt;">
                        <td width=60 valign=center rowspan=4 style="width:45.4500pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:1.0000pt solid windowtext;
                        mso-border-left-alt:0.5000pt solid windowtext;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext;
                        border-top:none;mso-border-top-alt:none;border-bottom:1.0000pt solid windowtext;
                        mso-border-bottom-alt:0.5000pt solid windowtext;">
                            <p class=MsoNormal align=center style="text-align:center;line-height:150%;">
                                <span style="font-family:微软雅黑;line-height:200%;font-size:14.0000pt; mso-font-kerning:1.0000pt;">检</span>
                                <span style="font-family:微软雅黑;line-height:200%;font-size:14.0000pt; mso-font-kerning:1.0000pt;"> </span>
                            </p>
                            <p class=MsoNormal align=center style="text-align:center;line-height:150%;">
                                <span style="font-family:微软雅黑;line-height:200%;font-size:14.0000pt; mso-font-kerning:1.0000pt;">测</span>
                                <span style="font-family:微软雅黑;line-height:200%;font-size:14.0000pt; mso-font-kerning:1.0000pt;"> </span>
                            </p>
                            <p class=MsoNormal align=center style="text-align:center;line-height:150%;">
                                <span style="font-family:微软雅黑;line-height:200%;font-size:14.0000pt; mso-font-kerning:1.0000pt;">信</span>
                                <span style="font-family:微软雅黑;line-height:200%;font-size:14.0000pt; mso-font-kerning:1.0000pt;"> </span>
                            </p>
                            <p class=MsoNormal align=center style="text-align:center;line-height:150%;">
                                <span style="font-family:微软雅黑;line-height:200%;font-size:14.0000pt; mso-font-kerning:1.0000pt;">息</span>
                                <span style="font-family:微软雅黑;line-height:200%;font-size:14.0000pt; mso-font-kerning:1.0000pt;"> </span>
                            </p>
                        </td>
                        <td width=156 valign=center style="width:117.3000pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none;
                        mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext;
                        border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext;
                        mso-border-bottom-alt:0.5000pt solid windowtext;">
                            <p class=MsoNormal align=center style="text-align:center;line-height:150%;">
                                <span style="mso-spacerun:'yes';font-family:微软雅黑;line-height:200%; font-size:14.0000pt;mso-font-kerning:1.0000pt;">检测类型</span>
                                <span style="font-family:微软雅黑;line-height:200%;font-size:14.0000pt; mso-font-kerning:1.0000pt;"> </span>
                            </p>
                        </td>
                        <td width=172 valign=center style="width:129.7000pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none;
                        mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext;
                        border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext;
                        mso-border-bottom-alt:0.5000pt solid windowtext;">
                            <p class=MsoNormal align=justify style="text-align:justify;text-justify:inter-ideograph;line-height:150%;">
                                <span style="font-family:微软雅黑;line-height:200%;font-size:14.0000pt; mso-font-kerning:1.0000pt;">内部抽检 </span>
                            </p>
                        </td>
                        <td width=94 valign=center colspan=2 style="width:70.5000pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none;
                        mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext;
                        border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext;
                        mso-border-bottom-alt:0.5000pt solid windowtext;">
                            <p class=MsoNormal align=center style="text-align:center;line-height:150%;">
                                <span style="mso-spacerun:'yes';font-family:微软雅黑;line-height:200%; font-size:14.0000pt;mso-font-kerning:1.0000pt;">抽检人</span>
                                <span style="font-family:微软雅黑;line-height:200%;font-size:14.0000pt; mso-font-kerning:1.0000pt;"></span>
                            </p>
                        </td>
                        <td width=178 valign=center style="width:134.1500pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none;
                        mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext;
                        border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext;
                        mso-border-bottom-alt:0.5000pt solid windowtext;">
                            <p class=MsoNormal align=justify style="text-align:justify;text-justify:inter-ideograph;line-height:150%;width: 160px;word-break: break-all;">
                                <span style="font-family:微软雅黑;line-height:200%;font-size:14.0000pt; mso-font-kerning:1.0000pt;">${l.sampling.samplingUsername}</span>
                            </p>
                        </td>
                    </tr>
                    <tr style="height:54.6500pt;">
                        <td width=156 valign=center style="width:117.3000pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none;
                        mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext;
                        border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext;
                        mso-border-bottom-alt:0.5000pt solid windowtext;">
                            <p class=MsoNormal align=center style="text-align:center;line-height:150%;">
                                <span style="mso-spacerun:'yes';font-family:微软雅黑;line-height:200%; font-size:14.0000pt;mso-font-kerning:1.0000pt;">检测项目</span>
                                <span style="font-family:微软雅黑;line-height:200%;font-size:14.0000pt; mso-font-kerning:1.0000pt;"> </span>
                            </p>
                        </td>
                        <td width=445 valign=center colspan=4 style="width:334.3500pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none;
                        mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext;
                        border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext;
                        mso-border-bottom-alt:0.5000pt solid windowtext;">
                            <p class=MsoNormal align=justify style="text-align:justify;text-justify:inter-ideograph;line-height:150%;width: 160px;word-break: break-all;">
                                <span style="font-family:微软雅黑;line-height:200%;font-size:14.0000pt; mso-font-kerning:1.0000pt;">${reportModel.itemName}</span>
                            </p>
                        </td>
                    </tr>
                    <tr style="height:54.6500pt;">
                        <td width=156 valign=center style="width:117.3000pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none;
                        mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext;
                        border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext;
                        mso-border-bottom-alt:0.5000pt solid windowtext;">
                            <p class=MsoNormal align=center style="text-align:center;line-height:150%;">
                                <span style="mso-spacerun:'yes';font-family:微软雅黑;line-height:200%; font-size:14.0000pt;mso-font-kerning:1.0000pt;">检测设备</span>
                                <span style="font-family:微软雅黑;line-height:200%;font-size:14.0000pt; mso-font-kerning:1.0000pt;"> </span>
                            </p>
                        </td>
                        <td width=445 valign=center colspan=4 style="width:334.3500pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none;
                        mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext;
                        border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext;
                        mso-border-bottom-alt:0.5000pt solid windowtext;">
                            <p class=MsoNormal align=justify style="text-align:justify;text-justify:inter-ideograph;line-height:150%;">
                                <span style="mso-spacerun:'yes';font-family:微软雅黑;line-height:200%; font-size:14.0000pt;mso-font-kerning:1.0000pt;">
                                    <c:forEach items="${l.recordings}" var="recording">
                                        ${recording.deviceName}
                                    </c:forEach>
                                </span>
                                <span style="font-family:微软雅黑;line-height:200%;font-size:14.0000pt; mso-font-kerning:1.0000pt;"> </span>
                            </p>
                        </td>
                    </tr>
                    <tr style="height:54.6500pt;">
                        <td width=156 valign=center style="width:117.3000pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none;
                        mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext;
                        border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext;
                        mso-border-bottom-alt:0.5000pt solid windowtext;">
                            <p class=MsoNormal align=center style="text-align:center;line-height:150%;">
                                <span style="mso-spacerun:'yes';font-family:微软雅黑;line-height:200%; font-size:14.0000pt;mso-font-kerning:1.0000pt;">结果判断</span>
                                <span style="font-family:微软雅黑;line-height:200%;font-size:14.0000pt; mso-font-kerning:1.0000pt;"> </span>
                            </p>
                        </td>
                        <td width=445 valign=center colspan=4 style="width:334.3500pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none;
                        mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext;
                        border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext;
                        mso-border-bottom-alt:0.5000pt solid windowtext;">
                            <p class=MsoNormal align=justify style="text-align:justify;text-justify:inter-ideograph;line-height:150%;">
                                <span style="mso-spacerun:'yes';font-family:微软雅黑;line-height:200%; font-size:14.0000pt;mso-font-kerning:1.0000pt;">
                                    <c:forEach items="${l.recordings}" var="recording">
                                        <c:choose>
                                            <c:when test="${fn:contains(recording.conclusion,'不合格')==true}">不合格</c:when>
                                            <c:otherwise>合格</c:otherwise>
                                        </c:choose>
                                    </c:forEach>
                                </span>
                                <span style="font-family:微软雅黑;line-height:200%;font-size:14.0000pt; mso-font-kerning:1.0000pt;"> </span>
                            </p>
                        </td>
                    </tr>
                    <tr style="height:72.7500pt;">
                        <td width=217 valign=center colspan=2 rowspan=2 style="width:162.7500pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:1.0000pt solid windowtext;
                        mso-border-left-alt:0.5000pt solid windowtext;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext;
                        border-top:none;mso-border-top-alt:none;border-bottom:1.0000pt solid windowtext;
                        mso-border-bottom-alt:0.5000pt solid windowtext;">
                            <p class=MsoNormal align=center style="text-align:center;line-height:150%;">
                                <span style="font-family:微软雅黑;line-height:200%;font-size:14.0000pt; mso-font-kerning:1.0000pt;">
                                <img width="147" height="148" src="${webRoot}/${l.signatureFilePicture}"></span>
                                <span style="font-family:微软雅黑;line-height:200%;font-size:14.0000pt; mso-font-kerning:1.0000pt;"> </span>
                            </p>
                        </td>
                        <td width=172 valign=center style="width:129.7000pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none;
                        mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext;
                        border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext;
                        mso-border-bottom-alt:0.5000pt solid windowtext;">
                            <p class=MsoNormal align=center style="text-align:center;line-height:150%;">
                                <span style="mso-spacerun:'yes';font-family:微软雅黑;line-height:200%; font-size:14.0000pt;mso-font-kerning:1.0000pt;">编制人</span>
                                <span style="font-family:微软雅黑;line-height:200%;font-size:14.0000pt; mso-font-kerning:1.0000pt;"> </span>
                            </p>
                        </td>
                        <td width=272 valign=center colspan=3 style="width:204.6500pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none;
                        mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext;
                        border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext;
                        mso-border-bottom-alt:0.5000pt solid windowtext;">
                            <p class=MsoNormal align=justify style="text-align:justify;text-justify:inter-ideograph;line-height:150%;">
                                <span style="font-family:微软雅黑;line-height:200%;font-size:14.0000pt; mso-font-kerning:1.0000pt;">
                                 <c:forEach items="${l.recordings}" var="recording">
                                     ${recording.checkUsername}
                                 </c:forEach>
                                </span>
                            </p>
                        </td>
                    </tr>
                    <tr style="height:70.2500pt;">
                        <td width=172 valign=center style="width:129.7000pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none;
                        mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext;
                        border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext;
                        mso-border-bottom-alt:0.5000pt solid windowtext;">
                            <p class=MsoNormal align=center style="text-align:center;line-height:150%;">
                                <span style="mso-spacerun:'yes';font-family:微软雅黑;line-height:200%; font-size:14.0000pt;mso-font-kerning:1.0000pt;">审批人</span>
                                <span style="font-family:微软雅黑;line-height:200%;font-size:14.0000pt; mso-font-kerning:1.0000pt;"> </span>
                            </p>
                        </td>
                        <td width=272 valign=center colspan=3 style="width:204.6500pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none;
                        mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext;
                        border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext;
                        mso-border-bottom-alt:0.5000pt solid windowtext;">
                            <p class=MsoNormal style="text-align:left;line-height:150%;">
                                <span style="font-family:微软雅黑;line-height:200%;font-size:14.0000pt; mso-font-kerning:1.0000pt;">
                                    <img width="68" height="31" src="${webRoot}/img/jd/approval.png"></span>
                                <span style="font-family:微软雅黑;line-height:200%;font-size:14.0000pt; mso-font-kerning:1.0000pt;"> </span>
                            </p>
                        </td>
                    </tr>
                </table>

                <p class="MsoNormal" align="center" style="text-align:center; position:absolute; bottom:10px;left:0; width:100%;">
                    <span style="mso-spacerun:'yes';font-family:微软雅黑;letter-spacing:0.5500pt; font-weight:normal;font-size:14.0000pt;mso-font-kerning:1.0000pt;">
                        <font face="微软雅黑">广东中检达元检测技术有限公司</font>
                    </span>
                    <u>
                      <span style="mso-spacerun:'yes';font-family:微软雅黑;letter-spacing:0.5500pt;
                      font-weight:normal;text-decoration:underline;text-underline:single;
                      font-size:14.0000pt;mso-font-kerning:1.0000pt;">
                      </span>
                    </u>
                </p>
            </div>
        </div>
        <!-- 京东报告封面结束 -->

        <!--正文开始-->
        <div class="clearfix" style="display:inline-block; text-align:center;">
            <c:forEach var="item" begin="1" end="${printPage>0? printPage : 1}" varStatus="pageNumber">
                <c:set var="pageSerialNumber" value="0"/>
                <div class="reportBorder" style=" width: 730px; height: 1065px; position: relative;">
                    <div align=center>
                        <table class=MsoTableGrid border=1 cellspacing=0 style="border-collapse:collapse;width:492.8500pt;border:none;
                            mso-border-left-alt:0.5000pt solid windowtext;mso-border-top-alt:0.5000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext;
                            mso-border-bottom-alt:0.5000pt solid windowtext;mso-border-insideh:0.5000pt solid windowtext;mso-border-insidev:0.5000pt solid windowtext;
                            mso-padding-alt:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;">
                            <tr style="height:65.9500pt;">
                                <td  valign=center colspan=8 style="width:350.1000pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none;
                                mso-border-left-alt:none;border-right:none;mso-border-right-alt:none;
                                border-top:none;mso-border-top-alt:none;border-bottom:none;
                                mso-border-bottom-alt:none;">
                                    <p class=MsoNormal align=justify style="text-align:justify;text-justify:inter-ideograph;line-height:200%;">
                                        <span style="font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri; mso-bidi-font-family:'Times New Roman';font-size:10.5000pt;mso-font-kerning:1.0000pt;">
                                        <img width="217" height="85" src="${webRoot}/img/jd/logo.png" align="left" hspace="12"></span>
                                        <span style="font-family:微软雅黑;line-height:200%;letter-spacing:0.0000pt; font-weight:normal;font-size:12.0000pt;mso-font-kerning:1.0000pt;"> </span>
                                    </p>
                                </td>
                                <td width=190 valign=center colspan=2 style="width:142.7500pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none;
                                mso-border-left-alt:none;border-right:none;mso-border-right-alt:none;
                                border-top:none;mso-border-top-alt:none;border-bottom:none;
                                mso-border-bottom-alt:none;">
                                    <p class=MsoNormal align=right style="text-align:right;">
                                        <b>
                                      <span style="mso-spacerun:'yes';font-family:微软雅黑;line-height:200%;
                                      letter-spacing:0.0000pt;font-weight:bold;font-size:18.0000pt;
                                      mso-font-kerning:1.0000pt;">检 测 报 告</span>
                                        </b>
                                        <b>
                                            <span style="font-family:微软雅黑;line-height:200%;letter-spacing:0.0000pt; font-weight:bold;font-size:15.0000pt;mso-font-kerning:1.0000pt;"> </span>
                                        </b>
                                    </p>
                                    <p class=MsoNormal align=right style="text-align:right;">
                                        <span style="font-family:微软雅黑;line-height:200%;letter-spacing:0.0000pt;
                                        font-weight:normal;font-size:12.0000pt;mso-font-kerning:1.0000pt;">（</span>
                                        <span style="mso-spacerun:'yes';font-family:微软雅黑;line-height:200%; letter-spacing:0.5500pt;font-weight:normal;font-size:12.0000pt; mso-font-kerning:1.0000pt;">Test Report</span>
                                        <span style="font-family:微软雅黑;line-height:200%;letter-spacing:0.0000pt;
                                            font-weight:normal;font-size:12.0000pt;mso-font-kerning:1.0000pt;">）</span>
                                        <span style="font-family:微软雅黑;line-height:200%;letter-spacing:0.0000pt;
                                        font-weight:normal;font-size:12.0000pt;mso-font-kerning:1.0000pt;"> </span>
                                    </p>
                                    <p class=MsoNormal align=center style="text-align:center;">
                                        <span style="font-family:微软雅黑;line-height:200%;letter-spacing:0.0000pt; font-weight:normal;font-size:12.0000pt;mso-font-kerning:1.0000pt;"> </span>
                                    </p>
                                </td>
                            </tr>
                            <tr>
                                <td width=466 valign=top colspan=8 style="width:350.1000pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none;
                                    mso-border-left-alt:none;border-right:none;mso-border-right-alt:none;
                                    border-top:none;mso-border-top-alt:none;border-bottom:1.0000pt solid windowtext;
                                    mso-border-bottom-alt:0.5000pt solid windowtext;">
                                    <p class=MsoNormal align=justify style="text-align:justify;text-justify:inter-ideograph;line-height:200%;">
                                        <span style="mso-spacerun:'yes';font-family:宋体;line-height:200%; font-size:12.0000pt;mso-font-kerning:1.0000pt;">报告编号( ReportID )：${l.sampling.samplingNo}</span>
                                        <span style="font-family:微软雅黑;line-height:200%;letter-spacing:0.0000pt; font-weight:normal;font-size:12.0000pt;mso-font-kerning:1.0000pt;"> </span>
                                    </p>
                                </td>
                                <td width=190 valign=top colspan=2 style="width:142.7500pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none;
                                    mso-border-left-alt:none;border-right:none;mso-border-right-alt:none;
                                    border-top:none;mso-border-top-alt:none;border-bottom:1.0000pt solid windowtext;
                                    mso-border-bottom-alt:0.5000pt solid windowtext;">
                                    <p class=MsoNormal align=right style="text-align:right;line-height:200%;">
                                        <span style="mso-spacerun:'yes';font-family:宋体;line-height:200%; font-size:12.0000pt;mso-font-kerning:1.0000pt;">第${item+1}页 共<fmt:formatNumber value="${printPage+(printPage % 1 == 0 ? 0 : -0.5)+1}" type="number" pattern="#" />页</span>
                                        <span style="font-family:微软雅黑;line-height:200%;letter-spacing:0.0000pt; font-weight:normal;font-size:12.0000pt;mso-font-kerning:1.0000pt;"> </span>
                                    </p>
                                </td>
                            </tr>
                            <tr style="height:29.2500pt;">
                                <td width=52 valign=center colspan=2 style="width:39.1000pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:1.0000pt solid windowtext;
                                mso-border-left-alt:0.5000pt solid windowtext;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext;
                                border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext;
                                mso-border-bottom-alt:0.5000pt solid windowtext;background:rgb(215,215,215);">
                                    <p class=MsoNormal align=center style="text-align:center;line-height:150%;">
                                        <span style="mso-spacerun:'yes';font-family:微软雅黑;line-height:200%; letter-spacing:0.5500pt;font-weight:normal;font-size:12.0000pt; mso-font-kerning:1.0000pt;">序号</span>
                                        <span style="font-family:微软雅黑;line-height:200%;letter-spacing:0.5500pt; font-weight:normal;font-size:12.0000pt;mso-font-kerning:1.0000pt;"> </span>
                                    </p>
                                </td>
                                <td width=169 valign=center colspan=2 style="width:126.7500pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none;
                                mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext;
                                border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext;
                                mso-border-bottom-alt:0.5000pt solid windowtext;background:rgb(215,215,215);">
                                    <p class=MsoNormal align=center style="text-align:center;line-height:150%;">
                                        <span style="mso-spacerun:'yes';font-family:微软雅黑;line-height:200%; letter-spacing:0.5500pt;font-weight:normal;font-size:12.0000pt; mso-font-kerning:1.0000pt;">检测项目</span>
                                        <span style="font-family:微软雅黑;line-height:200%;letter-spacing:0.5500pt; font-weight:normal;font-size:12.0000pt;mso-font-kerning:1.0000pt;"> </span>
                                    </p>
                                </td>
                                <td width=86 valign=center style="width:64.5000pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none;
                                mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext;
                                border-top:1.0000pt solid windowtext;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext;
                                mso-border-bottom-alt:0.5000pt solid windowtext;background:rgb(215,215,215);">
                                    <p class=MsoNormal align=center style="text-align:center;line-height:150%;">
                                        <span style="mso-spacerun:'yes';font-family:微软雅黑;line-height:200%; letter-spacing:0.5500pt;font-weight:normal;font-size:12.0000pt; mso-font-kerning:1.0000pt;">标准限值</span>
                                        <span style="font-family:微软雅黑;line-height:200%;letter-spacing:0.5500pt; font-weight:normal;font-size:12.0000pt;mso-font-kerning:1.0000pt;"> </span>
                                    </p>
                                </td>
                                <td width=87 valign=center colspan=2 style="width:65.2500pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none;
                                mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext;
                                border-top:1.0000pt solid windowtext;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext;
                                mso-border-bottom-alt:0.5000pt solid windowtext;background:rgb(215,215,215);">
                                    <p class=MsoNormal align=center style="text-align:center;line-height:150%;">
                                        <span style="mso-spacerun:'yes';font-family:微软雅黑;line-height:200%; letter-spacing:0.5500pt;font-weight:normal;font-size:12.0000pt; mso-font-kerning:1.0000pt;">检测结果</span>
                                        <span style="font-family:微软雅黑;line-height:200%;letter-spacing:0.5500pt; font-weight:normal;font-size:12.0000pt;mso-font-kerning:1.0000pt;"> </span>
                                    </p>
                                </td>
                                <td width=92 valign=center colspan=2 style="width:69.0000pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none;
                                mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext;
                                border-top:1.0000pt solid windowtext;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext;
                                mso-border-bottom-alt:0.5000pt solid windowtext;background:rgb(215,215,215);">
                                    <p class=MsoNormal align=center style="text-align:center;line-height:150%;">
                                        <span style="mso-spacerun:'yes';font-family:微软雅黑;line-height:200%; letter-spacing:0.5500pt;font-weight:normal;font-size:12.0000pt; mso-font-kerning:1.0000pt;">单项判断</span>
                                        <span style="font-family:微软雅黑;line-height:200%;letter-spacing:0.5500pt; font-weight:normal;font-size:12.0000pt;mso-font-kerning:1.0000pt;"> </span>
                                    </p>
                                </td>
                                <td width=171 valign=center style="width:128.2500pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none;
                                mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext;
                                border-top:1.0000pt solid windowtext;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext;
                                mso-border-bottom-alt:0.5000pt solid windowtext;background:rgb(215,215,215);">
                                    <p class=MsoNormal align=center style="text-align:center;line-height:150%;">
                                        <span style="mso-spacerun:'yes';font-family:微软雅黑;line-height:200%; letter-spacing:0.5500pt;font-weight:normal;font-size:12.0000pt; mso-font-kerning:1.0000pt;">检测方法</span>
                                        <span style="font-family:微软雅黑;line-height:200%;letter-spacing:0.5500pt; font-weight:normal;font-size:12.0000pt;mso-font-kerning:1.0000pt;"> </span>
                                    </p>
                                </td>
                            </tr>
               <!--检测明细处理-->
                <c:forEach items="${l.samplingDetailList}"  var="detail" varStatus="index" begin="${(pageNumber.index-1)*pageSize }" end="${pageNumber.index*pageSize-1}">
                    <c:set var="serialNumber" value="${serialNumber+1}" />
                    <c:set var="pageSerialNumber" value="${pageSerialNumber+1}" />
                 <%--   <c:if test="${pageSerialNumber==1 and detail.isCustomItem==1}">
                        <c:set var="itemNumber" value="${detail.itemNumber}" />
                    </c:if>
                    <c:if test="${detail.isCustomItem==1 and detail.itemNumber-(pageNumber*pageSize)>=0}">
                        <c:set var="rowspanNumber" value="${pageNumber*pageSize}" />
                        <c:set var="itemNumber" value="${itemNumber-(pageNumber*pageSize)}" />
                    </c:if>--%>
                    <tr class="tr-height">
                        <td width=52 valign=center colspan=2 style="width:39.1000pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:1.0000pt solid windowtext;
                        mso-border-left-alt:0.5000pt solid windowtext;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext;
                        border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext;
                        mso-border-bottom-alt:0.5000pt solid windowtext;">
                            <p class=MsoNormal align=center style="text-align:center;line-height:150%;">
                                <span style="font-family:微软雅黑;line-height:200%;letter-spacing:0.5500pt; font-weight:normal;font-size:10.5000pt;mso-font-kerning:1.0000pt;">${serialNumber}</span>
                                <span style="font-family:微软雅黑;line-height:200%;letter-spacing:0.5500pt; font-weight:normal;font-size:10.5000pt;mso-font-kerning:1.0000pt;"> </span>
                            </p>
                        </td>
                        <td width=169 valign=center colspan=2 style="width:126.7500pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none;
                            mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext;
                            border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext;
                            mso-border-bottom-alt:0.5000pt solid windowtext;">
                            <p class=MsoNormal align=center style="text-align:center;line-height:150%;">
                                <span style="mso-spacerun:'yes';font-family:微软雅黑;line-height:150%; letter-spacing:0.5500pt;font-weight:normal;font-size:10.5000pt; mso-font-kerning:1.0000pt;">${detail.itemName}</span>
                                <span style="font-family:微软雅黑;line-height:150%;letter-spacing:0.5500pt; font-weight:normal;font-size:10.5000pt;mso-font-kerning:1.0000pt;"> </span>
                            </p>
                        </td>
                        <td width=86 valign=center style="width:64.5000pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none;
                        mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext;
                        border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext;
                        mso-border-bottom-alt:0.5000pt solid windowtext;">
                            <p class=MsoNormal align=center style="text-align:center;line-height:150%;">
                                <span style="mso-spacerun:'yes';font-family:微软雅黑;line-height:200%; letter-spacing:0.5500pt;font-weight:normal;font-size:10.5000pt; mso-font-kerning:1.0000pt;">${detail.limitValue}&nbsp;${detail.checkUnit}</span>
                                <span style="font-family:微软雅黑;line-height:200%;letter-spacing:0.5500pt; font-weight:normal;font-size:10.5000pt;mso-font-kerning:1.0000pt;"> </span>
                            </p>
                        </td>
                        <td width=87 valign=center colspan=2 style="width:65.2500pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none;
                        mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext;
                        border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext;
                        mso-border-bottom-alt:0.5000pt solid windowtext;">
                            <p class=MsoNormal align=center style="text-align:center;line-height:150%;">
                                <span style="mso-spacerun:'yes';font-family:微软雅黑;line-height:200%; letter-spacing:0.5500pt;font-weight:normal;font-size:10.5000pt; mso-font-kerning:1.0000pt;">${detail.checkResult}</span>
                                <span style="font-family:微软雅黑;line-height:200%;letter-spacing:0.5500pt; font-weight:normal;font-size:10.5000pt;mso-font-kerning:1.0000pt;"> </span>
                            </p>
                        </td>
                        <td width=92 valign=center colspan=2 style="width:69.0000pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none;
                            mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext;
                            border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext;
                            mso-border-bottom-alt:0.5000pt solid windowtext;">
                            <p class=MsoNormal align=center style="text-align:center;line-height:150%;">
                                <span style="mso-spacerun:'yes';font-family:微软雅黑;line-height:200%; letter-spacing:0.5500pt;font-weight:normal;font-size:10.5000pt; mso-font-kerning:1.0000pt;">${detail.conclusion}</span>
                                <span style="font-family:微软雅黑;line-height:200%;letter-spacing:0.5500pt; font-weight:normal;font-size:10.5000pt;mso-font-kerning:1.0000pt;"> </span>
                            </p>
                        </td>
                        <td width=171 valign=center style="width:128.2500pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none;
                        mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext;
                        border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext;
                        mso-border-bottom-alt:0.5000pt solid windowtext;">
                            <p class=MsoNormal align=center style="text-align:center;">
                            <span style="mso-spacerun:'yes';font-family:微软雅黑;line-height:150%; letter-spacing:0.5500pt;font-weight:normal;font-size:10.5000pt; mso-font-kerning:1.0000pt;">${fn:substring(detail.stdCode,0,25)}</span>
                                <span style="font-family:微软雅黑;line-height:150%;letter-spacing:0.5500pt; font-weight:normal;font-size:10.5000pt;mso-font-kerning:1.0000pt;"> </span>
                            </p>
                        </td>
                    </tr>

                </c:forEach>
                <!--自动补全当前页-->
                <c:forEach var="i" begin="${pageSerialNumber+1}" end="${pageSize}">
                    <tr class="tr-height">
                        <td width=52 valign=center colspan=2 style="width:39.1000pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:1.0000pt solid windowtext;
                            mso-border-left-alt:0.5000pt solid windowtext;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext;
                            border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext;
                            mso-border-bottom-alt:0.5000pt solid windowtext;">
                            <p class=MsoNormal align=center style="text-align:center;line-height:150%;">
                                <span style="font-family:微软雅黑;line-height:200%;letter-spacing:0.5500pt;font-weight:normal;font-size:10.5000pt;mso-font-kerning:1.0000pt;"></span>
                                <span style="font-family:微软雅黑;line-height:200%;letter-spacing:0.5500pt;font-weight:normal;font-size:10.5000pt;mso-font-kerning:1.0000pt;"></span>
                            </p>
                        </td>
                        <td width=169 valign=center colspan=2 style="width:126.7500pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none;
                            mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext;
                            border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext;
                            mso-border-bottom-alt:0.5000pt solid windowtext;">
                            <p class=MsoNormal align=center style="text-align:center;line-height:150%;">
                                <span style="mso-spacerun:'yes';font-family:微软雅黑;line-height:150%; letter-spacing:0.5500pt;font-weight:normal;font-size:10.5000pt; mso-font-kerning:1.0000pt;"></span>
                                <span style="font-family:微软雅黑;line-height:150%;letter-spacing:0.5500pt; font-weight:normal;font-size:10.5000pt;mso-font-kerning:1.0000pt;"></span>
                            </p>
                        </td>
                        <td width=86 valign=center style="width:64.5000pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none;
                        mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext;
                        border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext;
                        mso-border-bottom-alt:0.5000pt solid windowtext;">
                            <p class=MsoNormal align=center style="text-align:center;line-height:150%;">
                                 <span style="mso-spacerun:'yes';font-family:微软雅黑;line-height:200%; letter-spacing:0.5500pt;font-weight:normal;font-size:10.5000pt; mso-font-kerning:1.0000pt;"></span>
                                <span style="font-family:微软雅黑;line-height:200%;letter-spacing:0.5500pt; font-weight:normal;font-size:10.5000pt;mso-font-kerning:1.0000pt;"></span>
                            </p>
                        </td>
                        <td width=87 valign=center colspan=2 style="width:65.2500pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none;
                        mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext;
                        border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext;
                        mso-border-bottom-alt:0.5000pt solid windowtext;">
                            <p class=MsoNormal align=center style="text-align:center;line-height:150%;">
                                <span style="mso-spacerun:'yes';font-family:微软雅黑;line-height:200%; letter-spacing:0.5500pt;font-weight:normal;font-size:10.5000pt; mso-font-kerning:1.0000pt;"></span>
                                <span style="font-family:微软雅黑;line-height:200%;letter-spacing:0.5500pt;font-weight:normal;font-size:10.5000pt;mso-font-kerning:1.0000pt;"></span>
                            </p>
                        </td>
                        <td width=92 valign=center colspan=2 style="width:69.0000pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none;
                        mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext;
                        border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext;
                        mso-border-bottom-alt:0.5000pt solid windowtext;">
                            <p class=MsoNormal align=center style="text-align:center;line-height:150%;">
                                <span style="mso-spacerun:'yes';font-family:微软雅黑;line-height:200%;letter-spacing:0.5500pt;font-weight:normal;font-size:10.5000pt;mso-font-kerning:1.0000pt;"></span>
                                <span style="font-family:微软雅黑;line-height:200%;letter-spacing:0.5500pt;font-weight:normal;font-size:10.5000pt;mso-font-kerning:1.0000pt;"></span>
                            </p>
                        </td>
                        <td width=171 valign=center style="width:128.2500pt;padding:0.0000pt 5.4000pt 0.0000pt 5.4000pt ;border-left:none;
                        mso-border-left-alt:none;border-right:1.0000pt solid windowtext;mso-border-right-alt:0.5000pt solid windowtext;
                        border-top:none;mso-border-top-alt:0.5000pt solid windowtext;border-bottom:1.0000pt solid windowtext;
                        mso-border-bottom-alt:0.5000pt solid windowtext;">
                            <p class=MsoNormal align=center style="text-align:center;">
                                <span style="mso-spacerun:'yes';font-family:微软雅黑;line-height:150%; letter-spacing:0.5500pt;font-weight:normal;font-size:10.5000pt; mso-font-kerning:1.0000pt;"></span>
                                <span style="font-family:微软雅黑;line-height:150%;letter-spacing:0.5500pt; font-weight:normal;font-size:10.5000pt;mso-font-kerning:1.0000pt;"> </span>
                            </p>
                        </td>
                    </tr>

                </c:forEach>
                        </table>
                    </div>
                    <p class="MsoNormal" align="center" style="text-align:center; position:absolute; bottom:10px;left:0; width:100%;">
                        <span style="mso-spacerun:'yes';font-family:微软雅黑;letter-spacing:0.5500pt; font-weight:normal;font-size:14.0000pt;mso-font-kerning:1.0000pt;">
                            <font face="微软雅黑">广东中检达元检测技术有限公司</font></span>

                    </p>
                </div>
            </c:forEach>
            <!--正文结束-->
        </div>
    </c:forEach>
    <!--endprint-->


</div>
<div class="cs-hd"></div>
<div class="cs-alert-form-btn">
    <a class="cs-menu-btn cs-fun-btn" href="javascript:" onclick="preview();"><i class="icon iconfont icon-dayin"></i>打印</a>
    <a class="cs-menu-btn cs-fun-btn" href="javascript:" onclick="parent.closeMbIframe();"><i class="icon iconfont icon-fanhui"></i>返回</a>
</div>
</body>
<script type="text/javascript">
    var printNum = 0;
    $(function () {
        for (var i = 0; i < childBtnMenu.length; i++) {
            if (childBtnMenu[i].operationCode == "321-10") {
                $("#total").show();
            }
        }
    });

    function preview() {
        if (!!window.ActiveXObject || "ActiveXObject" in window) {
            remove_ie_header_and_footer();
        }
        var bdhtml = window.document.body.innerHTML;
        var sprnstr = "<!--startprint-->";
        var eprnstr = "<!--endprint-->";
        var prnhtml = bdhtml.substring(bdhtml.indexOf(sprnstr) + 17);
        prnhtml = prnhtml.substring(0, prnhtml.indexOf(eprnstr));
        window.document.body.innerHTML = prnhtml;
        window.print();
        //setTimeout(location.reload(), 10);
        window.document.body.innerHTML = bdhtml;
    }

    //window.onload=autoRowSpan(0,0);
    //window.onload=autoRowSpan(0,1);
    //window.onload=autoRowSpan(0,2);
    function autoRowSpan(row, col) {
        var lastValue = "";
        var value = "";
        var pos = 1;
        var tb = document.getElementById("tb");

        for (var i = row; i < tb.rows.length; i++) {
            value = tb.rows[i].cells[col].innerText;
            if (lastValue == value) {
                tb.rows[i].deleteCell(col);
                tb.rows[i - pos].cells[col].rowSpan = tb.rows[i - pos].cells[col].rowSpan + 1;
                pos++;
            } else {
                lastValue = value;
                pos = 1;
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
        } catch (e) {
        }
    }

</script>


</html>
