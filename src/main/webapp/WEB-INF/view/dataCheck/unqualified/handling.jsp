<%@page import="java.util.Date" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/WEB-INF/view/common/resource.jsp" %>
<html>
<head>
    <title>快检服务云平台</title>
 <%--   <link rel="stylesheet" type="text/css" href="${webRoot}/css/fileinput.css"/>
    <link rel="stylesheet" type="text/css" href="${webRoot}/css/theme.css"/>
    <!-- 上传 -->
    <script src="${webRoot}/js/sortable.js" type="text/javascript"></script>
    <script src="${webRoot}/js/fileinput.js" type="text/javascript"></script>
    <script src="${webRoot}/js/zh.js" type="text/javascript"></script>
    <script src="${webRoot}/js/theme.js" type="text/javascript"></script>--%>
    <link rel="stylesheet" type="text/css" href="${webRoot}/plug-in/uploader/css/uploader.css"/>
    <script src="${webRoot}/plug-in/uploader/js/uploader.js"></script>
    <style type="text/css">
        .upload-files2 {
            width: 200px;
            display: flex;
            flex-direction: row;
            line-height: 20px;
            margin: 5px 0px 5px 0px;
        }
        .upload-files2 span{
            overflow: hidden;
            white-space: nowrap;
            text-overflow: ellipsis;
        }
    </style>
</head>
<body>

<div class="cs-col-lg clearfix">
    <!-- 面包屑导航栏  开始-->
    <ol class="cs-breadcrumb cs-fl">
        <li class="cs-fl">
            <img src="${webRoot}/img/set.png" alt=""/>
        <li class="cs-fl">不合格处理
        </li>
        <li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
        <li class="cs-fl"><a href="javascript:;" class="returnBtn">处理中</a></li>
        <li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
        <li class="cs-b-active cs-fl">处理操作</li>
    </ol>
    <div class="cs-search-box cs-fr">
        <div class="cs-menu-btn cs-fr cs-ac ">
            <a href="javascript:;" onclick="self.history.back();"><i class="icon iconfont icon-fanhui"></i>返回</a>
        </div>
        <div class="cs-menu-btn cs-fr cs-ac ">
            <a href="javascript:;" id="saveUnqualified"><i class="icon iconfont icon-save"></i>保存</a>
        </div>
    </div>

    <!-- 面包屑导航栏  结束-->
</div>
<div class="cs-content2">
    <h3>基本信息</h3>
    <table class="cs-add-new">
        <tbody>
        <tr>
            <td class="cs-name">编号：</td>
            <td class="cs-in-style">
                <input type="text" class="cs-top-write" disabled="disabled" value="${checkResult.id}"></td>
            <td class="cs-name">检测样品：</td>
            <td class="cs-in-style">
                <input type="text" class="cs-top-write" disabled="disabled" value="${checkResult.foodName}"></td>
            <td class="cs-name">检测项目：</td>
            <td class="cs-in-style">
                <input type="text" class="cs-top-write" disabled="disabled" value="${checkResult.itemName}"></td>
        </tr>
        <tr>
            <td class="cs-name">受检单位：</td>
            <td class="cs-in-style">
                <input type="text" class="cs-top-write" disabled="disabled" value="${checkResult.regName}"></td>
            <td class="cs-name">
                <c:choose>
                    <c:when test="${systemFlag==1}">
                        摊位编号：
                    </c:when>
                    <c:otherwise>
                        档口编号：
                    </c:otherwise>
                </c:choose>
            </td>
            <td class="cs-in-style">
                <input type="text" class="cs-top-write" disabled="disabled" value="${checkResult.ope_shop_code}"></td>
            <td class="cs-name">
                <c:choose>
                    <c:when test="${systemFlag==1}">
                        摊位名称：
                    </c:when>
                    <c:otherwise>
                        经营户名称：
                    </c:otherwise>
                </c:choose>
            </td>
            <td class="cs-in-style">
                <input type="text" class="cs-top-write" disabled="disabled" value="${checkResult.opeName}"></td>
        </tr>
        <tr>
            <td class="cs-name">检测点：</td>
            <td class="cs-in-style">
                <input type="text" class="cs-top-write" disabled="disabled" value="${checkResult.pointName}"></td>
            <td class="cs-name">检测人员：</td>
            <td class="cs-in-style cs-td-detail" colspan="">
                <input type="text" class="cs-top-write" disabled="disabled" value="${checkResult.checkUsername}"/>
            </td>
            <td class="cs-name">复检时间：</td>
            <td class="cs-in-style cs-td-detail" colspan="">
                <input type="text" class="cs-top-write" disabled="disabled" value="<fmt:formatDate type="both" value="${checkResult.checkDate}"/>"/>
            </td>
        </tr>
        <tr>
            <td class="cs-name">复检值：</td>
            <td class="cs-in-style cs-td-detail">
                <input type="text" class="cs-top-write" disabled="disabled" value="${checkResult.checkResult}"/></td>
            <td class="cs-name">检测值单位：</td>
            <td class="cs-in-style cs-td-detail">
                <input type="text" class="cs-top-write" disabled="disabled" value="${checkResult.checkUnit}"/></td>
            <td class="cs-name">限定值：</td>
            <td class="cs-in-style cs-td-detail">
                <input type="text" class="cs-top-write" disabled="disabled" value="${checkResult.limitValue}"/></td>
        </tr>
        <tr>
            <td class="cs-name">复检结果：</td>
            <td class="cs-in-style">
                <c:choose>
                    <c:when test="${checkResult.conclusion == '合格'}">
                        <input type="text" class="cs-top-write cs-success" disabled="disabled" value="${checkResult.conclusion}"/>
                    </c:when>
                    <c:otherwise>
                        <input type="text" class="inputxt cs-danger" disabled="disabled" value="${checkResult.conclusion}"/>
                    </c:otherwise>
                </c:choose>
            </td>
            <td class="cs-name">检测标准：</td>
            <td class="cs-in-style cs-td-detail">
                <input type="text" class="cs-top-write" disabled="disabled" value="${checkResult.checkAccord}"/></td>
            <td class="cs-name">样品编号：</td>
            <td class="cs-in-style">
                <input type="text" class="cs-top-write" disabled="disabled" value="${checkResult.sampleCode}"></td>
        </tr>
        <tr>
            <td class="cs-name">备注：</td>
            <td class="cs-in-style" colspan="3">
                <textarea cols="30" rows="10" class="cs-text-for cs-top-write" disabled="disabled">${checkResult.remark}</textarea>
            </td>
        </tr>
        </tbody>
    </table>
</div>
<%--  处置过程信息  --%>
<div class="cs-content2">
    <h3>处置过程信息</h3>
    <table class="cs-add-new">
        <tbody>
        <tr>
            <%--<td class="cs-name">处理结果：</td>
            <td class="cs-in-style">
                <input type="text" class="cs-top-write text-danger" disabled="disabled" value="有异议"/>
            </td>--%>
            </td>
            <td class="cs-name">处理人：</td>
            <td class="cs-in-style">
                <input type="text" class="cs-top-write" disabled="disabled" value="${checkResult.dealUser}">
            </td>
            <td class="cs-name">处理时间：</td>
            <td class="cs-in-style">
                <input type="text" class="cs-top-write" disabled="disabled" value="<fmt:formatDate type="both" value="${checkResult.updateDate}"/>"/>
            </td>
                <td class="cs-name">接收报告时间：</td>
                <td class="cs-in-style" colspan="">
                    <input type="text" class="cs-top-write" disabled="disabled" value="<fmt:formatDate type="both" value="${checkResult.sendDate}"/>"/>
                </td>
        </tr>
        <tr>
            <td class="cs-name">复检机构：</td>
            <td class="cs-in-style cs-td-detail" colspan="">
                <input type="text" class="cs-top-write" disabled="disabled" value="${checkResult.recheckDepart}"/>
            </td>
            <td class="cs-name">送检人：</td>
            <td class="cs-in-style" colspan=""><input type="text" class="cs-top-write" disabled="disabled" value="${checkResult.spersonName}"/></td>
            <td class="cs-name">送检时间：</td>
            <td class="cs-in-style" colspan="">
                <input type="text" class="cs-top-write" disabled="disabled" value="<fmt:formatDate type="both" value="${checkResult.sendDate}"/>"/>
            </td>
        </tr>
        </tbody>
    </table>
</div>
<div class="cs-content2 clearfix ">
    <h3>处置信息</h3>
    <table class="cs-detail-table cs-form-table"></table>
    <div class="cs-add-new ">
        <table class="cs-form-table cs-form-table-he2">
            <tbody>
            <tr>
                <td class="cs-name" style="width: 100px;">复检结果：</td>
                <td class="cs-check-radio">
                    <input type="radio" id="ok" class="cs-you cs-normal-input cs-show-jigou" name="name" checked="true"><label for="ok">合格</label>
                    <input type="radio" id="no" class="cs-nore cs-normal-input cs-show-dian" name="name"><label for="no">不合格</label>
                </td>
            </tr>
            </tbody>
        </table>
        <div class="cs-hd clearfix"></div>

        <!-- 合格 -->
        <div class="cs-deliver-jigou">
            <form action="${webRoot}/dataCheck/unqualified/save.do" id="saveForm" method="post" enctype="multipart/form-data">
                <input class="cs-hide" type="text" name="treatment.id" value="${checkResult.dutId}"/>
                <input class="cs-hide" type="text" name="treatment.dealMethod" value="1"/>
                <input class="cs-hide" type="text" name="treatment.checkRecordingId" value="${checkResult.id}"/>
                <input class="cs-hide" type="text" name="treatment.dealType" value="2"/>
                <input class="cs-hide" type="text" name="treatment.recheckResult" value="合格"/>
                <table>
                    <tr>
                        <td class="cs-name " style="width:140px;"><i class="cs-mred">*</i>处理时间：</td>
                        <td class="cs-in-style ">
                            <input class="cs-time" type="text" name="treatment.updateDate"
                               value="<fmt:formatDate value='<%=new Date() %>' pattern='yyyy-MM-dd HH:mm:ss' />"
                               onfocus="WdatePicker({startDate:'%y-%M-%d %H:%m:%s',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true,minDate:'<fmt:formatDate type='both' value='${checkResult.sendDate}'/>'})"/>
                        </td>
                    </tr>
                    <tr>
                        <td class="cs-name " style="width:140px;"><i class="cs-mred">*</i>复检日期：</td>
                        <td class="cs-in-style ">
                            <input class="cs-time" type="text" name="treatment.recheckDate" datatype="*" nullmsg="请输入复检日期"
                                   onfocus="WdatePicker({minDate:'<fmt:formatDate type='both' value='${checkResult.sendDate}'/>',dateFmt:'yyyy-MM-dd HH:mm:ss'})"/>

                        </td>
                    </tr>
                    <tr>
                        <td class="cs-name " style="width:140px;"><i class="cs-mred">*</i>复检值：</td>
                        <td class="cs-in-style ">
                            <input name="treatment.recheckValue" type="text" datatype="*" nullmsg="请输入复检值" errormsg="请输入复检值！"/>
                        </td>
                    </tr>
                    <tr>
                        <td class="cs-name " style="width:140px;"><i class="cs-mred">*</i>监督人签名：</td>
                        <td class="cs-in-style ">
                            <input name="treatment.supervisor" type="text" datatype="*" nullmsg="请输入监督人签名"/>
                        </td>
                    </tr>
                    <tr>
                        <td class="cs-name " style="width:140px;">监督人联系方式：</td>
                        <td class="cs-in-style ">
                            <input name="treatment.supervisorPhone" type="text" ignore="ignore" datatype="*" nullmsg="请输入手机号码"/>
                        </td>
                    </tr>
                    <tr>
                        <td class="cs-name " style="width:140px;">报告 ：</td>
                        <td>
                            <div style="width:200px;margin-bottom: 10px;" id="dealImageUpload1">
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td class="cs-name " style="width:140px;">备注：</td>
                        <td class="cs-in-style " colspan="3">
                            <textarea name="treatment.remark" cols="30" rows="10" class="cs-inform-txt"></textarea>
                        </td>
                    </tr>
                </table>
                <%--            复检历史开始             --%>
                <c:if test="${fn:length(checkHistoryList)>=1}">
                    <div class="cs-content2">
                        <h3>
                            <a class="cs-link text-primary" data-toggle="collapse" href="#collapseExample1" <%--onclick="showOrClose1(this)"--%>
                               aria-expanded="false"
                               aria-controls="collapseExample">
                                复检记录
                            </a>
                        </h3>
                    </div>
                    <br/>
                </c:if>
                <div class="collapse" id="collapseExample1">
                    <c:forEach items="${checkHistoryList}" var="history" varStatus="num">
                        <c:choose>
                            <c:when test="${fn:length(checkHistoryList)>1}">
                                <p style="font-size: 12px;font-weight: bold;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;复检 ${num.index+1}</p>
                            </c:when>
                            <c:otherwise>
                                <p class="cs-article-title">&nbsp;&nbsp;复检信息</p>
                            </c:otherwise>
                        </c:choose>
                        <table class="cs-add-new">
                            <tbody>
                            <tr>
                                <td class="cs-name">检测点：</td>
                                <td class="cs-in-style">
                                    <input type="text" class="cs-top-write" disabled="disabled" value="${history.pointName}"></td>
                                <td class="cs-name">复检结果：</td>
                                <td class="cs-in-style cs-td-detail">
                                    <input type="text" class="cs-top-write" disabled="disabled" value="${history.checkResult}"/></td>
                                <td class="cs-name">复检结论：</td>
                                <td class="cs-in-style cs-td-detail">
                                    <c:choose>
                                        <c:when test="${history.conclusion == '合格'}">
                                            <input type="text" class="cs-top-write cs-success" disabled="disabled" value="${history.conclusion}"/>
                                        </c:when>
                                        <c:otherwise>
                                            <input type="text" class="inputxt cs-danger" disabled="disabled" value="${history.conclusion}"/>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                            <tr>
                                <td class="cs-name">复检时间：</td>
                                <td class="cs-in-style">
                                    <input type="text" class="cs-top-write" disabled="disabled"
                                           value="<fmt:formatDate type="both" value="${history.checkDate}"/>"/>
                                <td class="cs-name">复检人员：</td>
                                <td class="cs-in-style">
                                    <input type="text" class="cs-top-write" disabled="disabled" value="${history.checkUsername}"></td>
                                <td class="cs-name">上传时间：</td>
                                <td class="cs-in-style">
                                    <input type="text" class="cs-top-write" disabled="disabled"
                                           value="<fmt:formatDate type="both" value="${history.updateDate}"/>"/>
                            </tr>
                            </tbody>
                        </table>
                    </c:forEach>
                </div>
                <%--            复检历史结束             --%>
                <div class="cs-hd"></div>
                <div class="cs-alert-form-btn">
                    <a href="javascript:;" class="cs-menu-btn" id="btnSave" onclick="myValidform();"><i class="icon iconfont icon-save"></i>保存</a>
                    <a href="javascript:;" onclick="self.history.back();" class="cs-menu-btn"><i class="icon iconfont icon-fanhui"></i>返回</a>
                </div>
            </form>
        </div>

        <!-- 不合格 -->
        <div class="cs-deliver-dian cs-hide">
            <form action="${webRoot}/dataCheck/unqualified/save.do" id="saveForm2" method="post" enctype="multipart/form-data">
                <input class="cs-hide" type="text" name="treatment.id" value="${checkResult.dutId}"/>
                <input class="cs-hide" type="text" name="treatment.checkRecordingId" value="${checkResult.id}"/>
                <input class="cs-hide" type="text" name="treatment.dealMethod" value="1"/>
                <input class="cs-hide" type="text" name="treatment.dealType" value="3"/>
                <input class="cs-hide" type="text" name="treatment.recheckResult" value="不合格"/>
                <input class="cs-hide" type="text" name="dispose.unid" value="${checkResult.id}"/>
                <table>
                    <tr>
                        <td class="cs-name " style="width:140px;">
                            <i class="cs-mred">*</i>复检日期：
                        </td>
                        <td class="cs-in-style " style="width:250px;">
                            <input class="cs-time" type="text" datatype="*" nullmsg="请输入复检日期" name="treatment.recheckDate"
                                   onfocus="WdatePicker({minDate:'<fmt:formatDate type='both' value='${checkResult.sendDate}'/>',dateFmt:'yyyy-MM-dd HH:mm:ss'})"/>
                        </td>
                        <td class="cs-name" style="width:140px;">
                            <i class="cs-mred">*</i>处理方式：
                        </td>
                        <td class="cs-in-style cs-chioce-list" rowspan="20">
                            <!-- <div class="cs-all-ps"> -->
                            <div class="cs-input-box"></div>
                            <div id="divBtn" class="cs-check-downs ">
                                <ul style="margin-top: 10px;">
                                    <%-- <c:forEach items="${configList}" var="config">
                                      <li class="clearfix">
                                        <input id="${config.id}" class="cs-checkCk" type="checkbox" value="${config.id}">
                                        <span><label class="cs-text-nowrap" for="${config.id}">${config.handleName}</label></span>
                                           <div class="cs-down-value cs-hide">
                                                <c:if test="${not empty config.valueType}">
                                                    <input class="cs-hide" type="text" id="${config.id}" name="disposeList[${config.id}].disposeId" />
                                                  <input class="cs-hide" type="text" name="disposeList[${config.id}].disposeType" value="${config.valueType}" />
                                                  <input name="disposeList[${config.id}].disposeValue1" placeholder="请输入" type="text" onkeyup="if(isNaN(value))execCommand('undo')" onafterpaste="if(isNaN(value))execCommand('undo')">
                                              </c:if>
                                              <c:if test="${empty config.valueType}">
                                                  <input class="cs-hide" type="text" id="${config.id}" name="disposeList[${config.id}].disposeId" />
                                                  <input class="cs-hide" type="text" name="disposeList[${config.id}].disposeType" value="${config.valueType}" />
                                                  <input name="disposeList[${config.id}].disposeValue" placeholder="请输入备注" type="text">
                                              </c:if>
                                              <i>${config.valueType}</i>
                                            </div>
                                      </li>
                                  </c:forEach> --%>
                                    <c:forEach items="${configList}" var="config" varStatus="index">
                                        <li class="clearfix">
                                            <c:choose>
                                                <c:when test="${index.index==0 }">
                                                    <input id="${config.id}" class="cs-checkCk" name="checkCk" type="checkbox" value="${config.id}"
                                                           datatype="needChose" nullmsg="请选择处理方式">
                                                </c:when>
                                                <c:otherwise>
                                                    <input id="${config.id}" class="cs-checkCk" name="checkCk" type="checkbox" value="${config.id}">
                                                </c:otherwise>
                                            </c:choose>
                                            <span>
                                                <label class="cs-text-nowrap" for="${config.id}">${config.handleName}</label>
                                              </span>
                                            <div class="cs-down-value cs-hide">
                                                <input class="cs-hide" type="text" id="${config.id}" name="disposeList[${index.index}].disposeId"/>
                                                <input class="cs-hide" type="text" name="disposeList[${index.index}].disposeType"
                                                       value="${config.valueType}"/>

                                                <c:if test="${not empty config.valueType && config.handleType!=0}">
                                                    <input name="disposeList[${index.index}].disposeValue1" placeholder="请输入" type="text"
                                                           onkeyup="if(isNaN(value))execCommand('undo')"
                                                           onafterpaste="if(isNaN(value))execCommand('undo')">
                                                    <i>${config.valueType}</i>
                                                </c:if>
                                              <%--  <c:if test="${empty config.valueType}">
                                                    <input name="disposeList[${index.index}].disposeValue" placeholder="请输入" type="text">
                                                </c:if>--%>


                                            </div>
                                        </li>
                                    </c:forEach>
                                </ul>
                            </div>
                        </td>
                        <td class="cs-name ">
                        </td>
                        <td class="cs-in-style ">
                        </td>
                    </tr>
                    <tr>
                        <td class="cs-name"><i class="cs-mred">*</i>处理时间：</td>
                        <td class="cs-in-style " style="width:250px;">
                            <input type="text" name="treatment.updateDate" class="cs-time"
                               value="<fmt:formatDate value='<%=new Date() %>' pattern='yyyy-MM-dd HH:mm:ss' />"
                               onClick="WdatePicker({startDate:'%y-%M-%d %H:%m:%s',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true,minDate:'<fmt:formatDate type='both' value='${checkResult.sendDate}'/>'})"
                               datatype="*" nullmsg="请选择处理日期"/>
                        </td>
                    </tr>
                    <tr>
                        <td class="cs-name ">
                            <i class="cs-mred">*</i>复检值：
                        </td>
                        <td class="cs-in-style ">
                            <input class="inputxt" type="text" name="treatment.recheckValue" datatype="*" nullmsg="请输入复检值" errormsg="请输入复检值！"/>
                        </td>
                    </tr>
                    <tr>
                        <td class="cs-name ">
                            <i class="cs-mred">*</i> 监督人签名：
                        </td>
                        <td class="cs-in-style ">
                            <input type="text" name="treatment.supervisor" class="inputxt" datatype="*" nullmsg="请输入监督人签名"/>
                        </td>
                    </tr>
                    <tr>
                        <td class="cs-name ">
                            <!-- <i class="cs-mred">*</i> -->监督人联系方式：
                        </td>
                        <td class="cs-in-style ">
                            <input type="text" name="treatment.supervisorPhone" ignore="ignore" datatype="*" nullmsg="请输入手机号码"/></td>

                    </tr>
                    <tr>
                        <td class="cs-name ">
                            <!-- <i class="cs-mred">*</i> -->取证信息附件：
                        </td>
                        <td class="cs-in-style ">
                            <div style="width:200px;margin-bottom: 10px;" id="dealImageUpload2">
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td class="cs-name ">
                            <!-- <i class="cs-mred">*</i> -->备注：
                        </td>
                        <td class="cs-in-style " colspan="3">
                            <textarea class="cs-inform-txt" name="treatment.remark" cols="30" rows="10"></textarea>
                        </td>
                    </tr>
                </table>

                <%--            复检历史开始             --%>
                <c:if test="${fn:length(checkHistoryList)>=1}">
                    <div class="cs-content2">
                        <h3>
                            <a class="cs-link text-primary" data-toggle="collapse" href="#collapseExample" <%--onclick="showOrClose(this)"--%>
                               aria-expanded="false"
                               aria-controls="collapseExample">
                                复检记录
                            </a>
                        </h3>
                    </div>
                    <br/>
                </c:if>
                <div class="collapse" id="collapseExample">
                    <c:forEach items="${checkHistoryList}" var="history" varStatus="num">
                        <c:choose>
                            <c:when test="${fn:length(checkHistoryList)>1}">
                                <p style="font-size: 12px;font-weight: bold;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;复检 ${num.index+1}</p>
                            </c:when>
                            <c:otherwise>
                                <p class="cs-article-title">&nbsp;&nbsp;复检信息</p>
                            </c:otherwise>
                        </c:choose>
                        <table class="cs-add-new">
                            <tbody>
                            <tr>
                                <td class="cs-name">检测点：</td>
                                <td class="cs-in-style">
                                    <input type="text" class="cs-top-write" disabled="disabled" value="${history.pointName}"></td>
                                <td class="cs-name">复检结果：</td>
                                <td class="cs-in-style cs-td-detail">
                                    <input type="text" class="cs-top-write" disabled="disabled" value="${history.checkResult}"/></td>
                                <td class="cs-name">复检结论：</td>
                                <td class="cs-in-style cs-td-detail">
                                    <c:choose>
                                        <c:when test="${history.conclusion == '合格'}">
                                            <input type="text" class="cs-top-write cs-success" disabled="disabled" value="${history.conclusion}"/>
                                        </c:when>
                                        <c:otherwise>
                                            <input type="text" class="inputxt cs-danger" disabled="disabled" value="${history.conclusion}"/>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                            <tr>
                                <td class="cs-name">复检时间：</td>
                                <td class="cs-in-style">
                                    <input type="text" class="cs-top-write" disabled="disabled"
                                           value="<fmt:formatDate type="both" value="${history.checkDate}"/>"/>
                                <td class="cs-name">复检人员：</td>
                                <td class="cs-in-style">
                                    <input type="text" class="cs-top-write" disabled="disabled" value="${history.checkUsername}"></td>
                                <td class="cs-name">上传时间：</td>
                                <td class="cs-in-style">
                                    <input type="text" class="cs-top-write" disabled="disabled"
                                           value="<fmt:formatDate type="both" value="${history.updateDate}"/>"/>
                            </tr>
                            </tbody>
                        </table>
                    </c:forEach>
                </div>
                <%--            复检历史结束             --%>
                <div class="cs-hd"></div>
                <div class="cs-alert-form-btn">
                    <a href="javascript:;" class="cs-menu-btn" id="btnSave2" onclick="myValidform();"><i class="icon iconfont icon-save"></i>保存</a>
                    <a href="javascript:;" onclick="self.history.back();" class="cs-menu-btn"><i class="icon iconfont icon-fanhui"></i>返回</a>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Modal 附件校验确认-->
<div class="modal fade intro2" id="fjjyModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog cs-alert-width">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">提示</h4>
            </div>
            <div class="modal-body cs-alert-height cs-dis-tab">
                <div class="cs-text-algin">
                    <img src="${webRoot}/img/warn.png" width="40px"/>
                    <span class="tips">取证资料未上传，请确认是否提交？</span>
                </div>
            </div>
            <div class="modal-footer">
                <a class="btn btn-success btn-ok" data-dismiss="modal" onclick="mySave();">确认</a>
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
            </div>
        </div>
    </div>
</div>

<!-- 底部导航 结束 -->
<%@include file="/WEB-INF/view/common/confirm.jsp" %>
<%--处理中模态框--%>
<%@include file="/WEB-INF/view/dataCheck/unqualified/showWaiting.jsp" %>
<!-- 内容主体 结束 -->
<script type="text/javascript">
    //文件上传插件初始化
    let upload1 = uploader({
        id: "dealImageUpload1", //容器渲染的ID 必填
        maxCount: 5, //允许的最大上传数量
        maxSize: 50, //允许的文件大小 单位：M
        multiple: true, //是否支持多文件上传
        name: 'dealImgurlFile', //后台接收的文件名称
        onAlert: function (msg) {
            $("#waringMsg>span").html(msg);
            $("#confirm-warnning").modal('toggle');
        }
    });
    let upload2 = uploader({
        id: "dealImageUpload2", //容器渲染的ID 必填
        maxCount: 5, //允许的最大上传数量
        maxSize: 100, //允许的文件大小 单位：M
        multiple: true, //是否支持多文件上传
        name: 'dealImgurlFile', //后台接收的文件名称
        accept: ".png,.jpg,.jpeg,.mp4",
        onAlert: function (msg) {
            $("#waringMsg>span").html(msg);
            $("#confirm-warnning").modal('toggle');
        }
    });
    //保存类型,0合格,1不合格;(默认0合格)
    var saveType = 0;
    //有异议合格
    $(document).on("click", "#ok", function () {
        saveType = 0;
    });
    //有异议不合格
    $(document).on("click", "#no", function () {
        saveType = 1;
    });
    //返回
    $(document).on("click", ".returnBtn", function () {
        self.location = '${webRoot}' + "/dataCheck/unqualified/dissentList.do";
    });

    //校验
    function myValidform(){
        //附件校验
        let files;
        if (saveType == 0) {
            files = upload1.files;
        } else if (saveType == 1) {
            files = upload2.files;
        }
        if (files.length <= 0) {
            $("#fjjyModal").modal('show');
            return false;
        }

        mySave();
    }

    //保存
    function mySave(){
        if (saveType == 0) {
            $("#saveForm").submit();
        } else if (saveType == 1) {
            $("input[type='checkbox']:checked").each(function () {
                var iii = $(this).val();
                $("input[id=" + iii + "]").val(iii);
            });
            $("#saveForm2").submit();
        }

        return false;
    }

    $(function () {
        //表单验证
        $("#saveForm").Validform({
            beforeSubmit: function () {
                $("#saveUnqualified,#btnSave,#btnSave2").attr("disabled", "disabled");
                $("#myModal-waiting").modal("show");
                var formData = new FormData($('#saveForm')[0]);
                let files=upload1.files;
                if (files.length > 0) {
                    for (let i = 0; i < files.length; i++) {
                        formData.append("dealImgurlFile",files[i])
                    }
                }
                $.ajax({
                    type: "POST",
                    url: "${webRoot}/dataCheck/unqualified/save.do",
                    data: formData,
                    contentType: false, //必须false才会避开jQuery对 formdata 的默认处理 XMLHttpRequest会对 formdata 进行正确的处理
                    processData: false, //必须false才会自动加上正确的Content-Type
                    dataType: "json",
                    success: function (data) {
                        $("#myModal-waiting").modal("hide");
                        if (data && data.success) {
                            self.location = "${webRoot}/dataCheck/unqualified/dissentList.do";
                        } else {
                            $("#waringMsg>span").html(data.msg);
                            $("#confirm-warnning").modal('toggle');
                        }
                    },error: function(e){
                        $("#saveUnqualified,#btnSave,#btnSave2").removeAttr("disabled");
                        $("#myModal-waiting").modal("hide");
                        $("#waringMsg>span").html("处理失败！");
                        $("#confirm-warnning").modal('toggle');
                    }
                });
                return false;
            }
        });
        $("#saveForm2").Validform({
            datatype: {//验证处理方式必选一个
                "needChose": function (gets, obj, curform, regxp) {
                    var need = 1,
                        numselected = curform.find("input[name='" + obj.attr("name") + "']:checked").length;
                    return numselected >= need ? true : "请至少选择" + need + "项！";
                }
            },
            beforeSubmit: function () {
                var formData = new FormData($('#saveForm2')[0]);
                let files=upload2.files;
                if (files.length > 0) {
                    for (let i = 0; i < files.length; i++) {
                        formData.append("dealImgurlFile",files[i])
                    }
                }
                $.ajax({
                    type: "POST",
                    url: "${webRoot}/dataCheck/unqualified/save.do",
                    data: formData,
                    contentType: false, //必须false才会避开jQuery对 formdata 的默认处理 XMLHttpRequest会对 formdata 进行正确的处理
                    processData: false, //必须false才会自动加上正确的Content-Type
                    dataType: "json",
                    success: function (data) {
                        if (data && data.success) {
                            self.location = "${webRoot}/dataCheck/unqualified/dissentList.do";
                        } else {
                            $("#waringMsg>span").html(data.msg);
                            $("#confirm-warnning").modal('toggle');
                        }
                    }
                });
                return false;
            }
        });

    });
    /*function showOrClose1(o) {
     var obj = $(o);
     $("#collapseExample1").hasClass("in") ? obj.html("复检记录") : obj.html("复检记录");
     }
     function showOrClose(o) {
     var obj = $(o);
     $("#collapseExample").hasClass("in") ? obj.html("复检记录") : obj.html("复检记录");
     }*/

    var checkBox1 = function () {
    if ($('.cs-show-jigou').prop('checked') == true) {
        $('.cs-deliver-jigou').css('display', 'block');
        $('.cs-deliver-dian').css('display', 'none');
    } else {
        $('.cs-deliver-dian').css('display', 'block');
        $('.cs-deliver-jigou').css('display', 'none');
    }
}


    jQuery(document).ready(function ($) {
        checkBox1();
    });
</script>
</body>
</html>
 