<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/WEB-INF/view/common/resource.jsp" %>
<html>
<head>
    <meta charset="utf-8">
    <style type="text/css">
        #content {
            width: 500px;
            height: 170px;
            margin: 100px auto;
        }
        /*以下为查看签名样式*/

        h1 {
            padding-bottom: 10px;
            color: darkmagenta;
            font-weight: bolder;
        }

        img {
            cursor: pointer;
        }

        #pic {
            position: absolute;
            display: none;
        }

        #pic1 {
            width: 160px;
            border-radius: 5px;
            -webkit-box-shadow: 5px 5px 5px 5px hsla(0, 0%, 5%, 1.00);
            box-shadow: 5px 5px 5px 0px hsla(0, 0%, 5%, 0.3);
        }

        #pic1 img {
            width: 100%;
        }
    </style>
</head>
<title>快检服务云平台</title>
<div class="cs-col-lg clearfix">
    <!-- 面包屑导航栏  开始-->
    <ol class="cs-breadcrumb cs-fl">
        <li class="cs-fl">
            <img src="${webRoot}/img/set.png" alt=""/>
        <li class="cs-fl">不合格处理
        </li>
        <li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
        <li class="cs-fl"><a href="javascript:;" onclick="self.history.back();">已处理</a></li>
        <li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
        <li class="cs-b-active cs-fl">处理结果</li>
    </ol>
<%--    <div class="cs-search-box cs-fr" id="showBtn">--%>
<%--        <div class="cs-menu-btn cs-fr cs-ac " >--%>
<%--            <a href="javascript:;" onclick="parent.closeMbIframe();"><i class="icon iconfont icon-fanhui"></i>返回</a>--%>
<%--        </div>--%>
<%--    </div>--%>
    <!-- 面包屑导航栏  结束-->
</div>
<%--==========================================以下为检测信息==============================================--%>
<div class="cs-content2 clearfix ">
    <h3>检测信息</h3>
    <table class="cs-add-new">
        <tbody>
        <tr>

            <td class="cs-name">编号：</td>
            <td class="cs-in-style">
                <input type="text" class="cs-top-write" disabled="disabled" value="${checkResult.id}"></td>
            <td class="cs-name">检测样品：</td>
            <td class="cs-in-style">
                <input type="text" class="cs-top-write" disabled="disabled" value="${checkResult.foodName}">
            </td>
            <td class="cs-name">检测项目：</td>
            <td class="cs-in-style">
                <input type="text" class="cs-top-write" disabled="disabled" value="${checkResult.itemName}">
            </td>
        </tr>
        <tr>
            <td class="cs-name">受检单位：</td>
            <td class="cs-in-style">
                <input type="text" class="cs-top-write" disabled="disabled" value="${checkResult.regName}">
            </td>
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
                <input type="text" class="cs-top-write" disabled="disabled" value="${checkResult.ope_shop_code}">
            </td>
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
                <input type="text" class="cs-top-write" disabled="disabled" value="${checkResult.opeName}">
            </td>
        </tr>
        <tr>
            <td class="cs-name">检测点：</td>
            <td class="cs-in-style">
                <input type="text" class="cs-top-write" disabled="disabled" value="${checkResult.pointName}"></td>
            <td class="cs-name">检测人员：</td>
            <td class="cs-in-style cs-td-detail" colspan="">
                <input type="text" class="cs-top-write" disabled="disabled" value="${checkResult.checkUsername}"/>
            </td>
            <td class="cs-name">检测时间：</td>
            <td class="cs-in-style cs-td-detail" colspan="">
                <input type="text" class="cs-top-write" disabled="disabled" value="<fmt:formatDate type="both" value="${checkResult.checkDate}"/>"/>
            </td>
        </tr>
        <tr>
            <td class="cs-name">检测值：</td>
            <td class="cs-in-style cs-td-detail">
                <input type="text" class="cs-top-write" disabled="disabled" value="${checkResult.checkResult}"/>
            </td>
            <td class="cs-name">检测值单位：</td>
            <td class="cs-in-style cs-td-detail">
                <input type="text" class="cs-top-write" disabled="disabled" value="${checkResult.checkUnit}"/>
            </td>
            <td class="cs-name">限定值：</td>
            <td class="cs-in-style cs-td-detail">
                <input type="text" class="cs-top-write" disabled="disabled" value="${checkResult.limitValue}"/>
            </td>
        </tr>
        <tr>
            <td class="cs-name">检测结果：</td>
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
            <td class="cs-name">接收检验报告日期：</td>
            <td class="cs-in-style cs-td-detail" colspan="">
                <input type="text" class="cs-top-write" disabled="disabled"
                       value="<fmt:formatDate pattern='yyyy-MM-dd HH:mm:ss'  value="${checkResult.sendDate}"/>"/>
            </td>
            <td class="cs-name">检测标准：</td>
            <td class="cs-in-style cs-td-detail">
                <input type="text" class="cs-top-write" disabled="disabled" value="${checkResult.checkAccord}"/>
            </td>
        </tr>
        <tr>
            <td class="cs-name">抽样编号：</td>
            <td class="cs-in-style">
                <input type="text" class="cs-top-write" disabled="disabled" value="${checkResult.sampleCode}">
            </td>
            <td class="cs-name">数据来源：</td>
            <td class="cs-in-style">
                <input type="text" class="cs-top-write" disabled="disabled"
                        <c:choose>
                            <c:when test="${checkResult.dataSource == 0}">value="检测工作站"</c:when>
                            <c:when test="${checkResult.dataSource == 1}">value="达元仪器"</c:when>
                            <c:when test="${checkResult.dataSource == 2}">value="监管通APP"</c:when>
                            <c:when test="${checkResult.dataSource == 3}">value="手工录入"</c:when>
                            <c:when test="${checkResult.dataSource == 4}">value="导入"</c:when>
                            <c:when test="${checkResult.dataSource == 9}">value="第三方仪器"</c:when>
                            <c:otherwise>value="第三方仪器"</c:otherwise>
                        </c:choose> />
            </td>
            <td class="cs-name">有效性：</td>
            <td class="cs-in-style">
                <input type="text" class="cs-top-write" disabled="disabled"
                        <c:choose>
                            <c:when test="${checkResult.param6 == 0}">value="正常数据"</c:when>
                            <c:when test="${checkResult.param6 == 1}">value="上传超时"</c:when>
                            <c:when test="${checkResult.param6 == 2}">value="无附件"</c:when>
                            <c:when test="${checkResult.param6 == 3}">value="超时且无附件"</c:when>
                            <c:when test="${checkResult.param6 == 4}">value="人工审核无效"</c:when>
                            <c:when test="${checkResult.param6 == 9}">value="造假数据"</c:when>
                            <c:otherwise>value="其他"</c:otherwise>
                        </c:choose> />
            </td>
        </tr>
        <tr>
            <td class="cs-name">考核状态：</td>
            <td class="cs-in-style">
                <input type="text" class="cs-top-write" disabled="disabled"
                        <c:choose>
                            <c:when test="${checkResult.handledAssessment == 0}">value="正常"</c:when>
                            <c:when test="${checkResult.handledAssessment == 1}">value="超时未处理"</c:when>
                            <c:when test="${checkResult.handledAssessment == 2}">value="超时处理"</c:when>
                            <c:when test="${checkResult.handledAssessment == 3}">value="处理不规范"</c:when>
                            <c:when test="${checkResult.handledAssessment == 4}">value="超时不规范"</c:when>
                            <c:when test="${checkResult.handledAssessment == 5}">value="造假"</c:when>
                            <c:when test="${checkResult.handledAssessment==null}">value="待处理"</c:when>
                            <c:otherwise>value="其他"</c:otherwise>
                        </c:choose> />
            </td>
            <td class="cs-name">考核说明：</td>
            <td class="cs-in-style" colspan="3">
                <input type="text" class="cs-top-write" disabled="disabled" value="${checkResult.handledRemark}"/>
            </td>
        </tr>
        <%-- <tr>
             <td class="cs-name cs-vertical-top">备注：</td>
             <td class="cs-in-style" colspan="3">
                 <textarea cols="30" rows="10" class="cs-text-for cs-top-write" disabled="disabled">${checkResult.remark}</textarea>
             </td>
         </tr>--%>
        </tbody>
    </table>
</div>
<%--==========================================以下为有异议复检信息，包含送检信息==============================================--%>
<c:if test="${checkResult.udealType!=1}">
    <div class="cs-content2 clearfix">
        <h3>复检信息</h3>
        <table class="cs-add-new cs-form-table">
            <tbody>
            <tr>
                <td class="cs-name">复检机构：</td>
                <td class="cs-in-style cs-td-detail" colspan="">
                    <input type="text" class="cs-top-write" disabled="disabled" value="${checkResult.recheckDepart}">
                </td>
                <td class="cs-name">复检时间：</td>
                <td class="cs-in-style">
                    <input type="text" class="cs-top-write" disabled="disabled" value=" ${fn:substring(checkResult.recheckDate,0,10)}"/>
                <td class="cs-name">复检值：</td>
                <td class="cs-in-style cs-td-detail">
                    <input type="text" class="cs-top-write" disabled="disabled" value="${checkResult.recheckValue}"/>
                </td>
            </tr>
            <tr>
                <td class="cs-name">复检结果：</td>
                <td class="cs-in-style cs-td-detail" colspan="">
                    <!--  1不合格处理 2有异议合格处理 3有异议不合格处理   -->
                    <c:choose>
                        <c:when test="${checkResult.recheckResult == '合格'}">
                            <input type="text" class="cs-top-write cs-success" disabled="disabled" value="${checkResult.recheckResult}"/>
                        </c:when>
                        <c:otherwise>
                            <input type="text" class="inputxt cs-danger" disabled="disabled" value="${checkResult.recheckResult}"/>
                        </c:otherwise>
                    </c:choose>
                </td>
                <td class="cs-name">送检人：</td>
                <td class="cs-in-style cs-td-detail" colspan="">
                    <input type="text" class="cs-top-write" disabled="disabled" value="${checkResult.spersonName}">
                </td>
                <td class="cs-name">送检时间：</td>
                <td class="cs-in-style cs-td-detail" colspan="">
                    <input type="text" class="cs-top-write" disabled="disabled"
                           value="<fmt:formatDate pattern='yyyy-MM-dd HH:mm:ss'  value="${checkResult.sendDate}"/>"/>
                </td>
            </tr>
            <tr>
                <!--  1不合格处理 2有异议合格处理 3有异议不合格处理   -->
                    <%--只有在情况3的时候才会出现送检人签名--%>
                <c:if test="${checkResult.udealType !=1}">
                    <td class="cs-name">送检人签名：</td>
                    <td colspan="1">
                        <c:if test="${!empty unqualifiedSign && fn:length(unqualifiedSign)>=2&&(fn:contains(unqualifiedSign[0].filePath, '.jpg') || fn:contains(unqualifiedSign[0].filePath, '.png'))}">
                            <div class="cs-obtain cs-fl container">
                                <a url="${resourcesUrl.concat(unqualifiedSign[0].filePath)}" style="width:100%; height:100%; display:flex; justify-content: center;align-items: center">
                                    <img src="${resourcesUrl.concat(unqualifiedSign[0].filePath)}" class="img-thumbnail" style="height:48px;">
                                </a>
                            </div>
                        </c:if>
                    </td>
                </c:if>

                <td class="cs-name cs-vertical-top" style="padding-top: 4px;">材料信息：</td>
                <td colspan="3" style="padding-top: 4px;" id="showSwiperImage">
                </td>
            </tr>
            </tbody>
        </table>
    </div>
</c:if>

<%--==========================================以下为处理信息==============================================--%>
<div class="cs-content2 clearfix ">
    <h3>处理信息</h3>
    <table class="cs-add-new cs-form-table">
        <!--  1不合格处理 2有异议合格处理 3有异议不合格处理   -->
        <tr>
            <td class="cs-name">处理机构：</td>
            <td class="cs-in-style cs-td-detail" colspan="">
                <input type="text" class="cs-top-write" disabled="disabled" value="${checkResult.dealDepart}"/>
            </td>
            <td class="cs-name">处理结果：</td>
            <td class="cs-in-style cs-td-detail" colspan="">
                <c:choose>
                    <c:when test="${checkResult.udealType == '1'}">
                        <input type="text" class="cs-top-write text-primary" disabled="disabled" value="无异议"/>
                    </c:when>
                    <c:otherwise>
                        <input type="text" class="cs-top-write text-danger" disabled="disabled" value="有异议"/>
                    </c:otherwise>
                </c:choose>
            </td>
            <td class="cs-name">处理人：</td>
            <td class="cs-in-style cs-td-detail" colspan="">
                <input type="text" class="cs-top-write" disabled="disabled" value="${checkResult.dealUser}"/>
            </td>
        </tr>
        <tr>
            <td class="cs-name">处理时间：</td>
            <td class="cs-in-style cs-td-detail" colspan="">
                <input type="text" class="cs-top-write" disabled="disabled"
                       value="<fmt:formatDate value='${checkResult.updateDate}' pattern='yyyy-MM-dd HH:mm:ss' />"/>
            </td>
            <td class="cs-name">监督人：</td>
            <td class="cs-in-style cs-td-detail" colspan="">
                <input type="text" class="cs-top-write" disabled="disabled" value="${checkResult.supervisor}"/>
            </td>
            <td class="cs-name">监督人签名：</td>
            <td colspan="1">
                <%--已处理： 此处的监督人签名，当只有一个签名，必定是监督人签名，存在送检人签名就必定存在监督人签名，监督人签名在后面，根据创建时间来判断 --%>
                <c:if test="${!empty unqualifiedSign}">
                    <c:choose>
                        <c:when test="${fn:length(unqualifiedSign) == 1&&(fn:contains(unqualifiedSign[0].filePath, '.jpg') || fn:contains(unqualifiedSign[0].filePath, '.png'))}">
                            <div class="cs-obtain cs-fl container">
                                <a url="${resourcesUrl}/${unqualifiedSign[0].filePath}" style="width:100%; height:100%; display:flex; justify-content: center;align-items: center">
                                    <img src="${resourcesUrl}/${unqualifiedSign[0].filePath}" style="width:100%;">
                                </a>
                            </div>
                        </c:when>
                        <c:when test="${fn:length(unqualifiedSign) >= 2 &&(fn:contains(unqualifiedSign[1].filePath, '.jpg') || fn:contains(unqualifiedSign[1].filePath, '.png'))}">
                            <div class="cs-obtain cs-fl container">
                                <a url="${resourcesUrl}/${unqualifiedSign[1].filePath}" style="width:100%; height:100%; display:flex; justify-content: center;align-items: center">
                                    <img src="${resourcesUrl}/${unqualifiedSign[1].filePath}" style="width:100%;">
                                </a>
                            </div>
                        </c:when>
                    </c:choose>
                </c:if>
            </td>
        </tr>
        <tr>
            <td class="cs-name">监督联系方式：</td>
            <td class="cs-in-style cs-td-detail" colspan="">
                <input type="text" class="cs-top-write" disabled="disabled" value="${checkResult.supervisorPhone}"/>
            </td>
            <td class="cs-name">处置结果：</td>
            <td class="cs-in-style cs-td-detail" colspan="5">
                <input class="cs-top-write" style="width:600px;" type="text" disabled="disabled" value="${checkResult.handName}"/>
            </td>
        </tr>
        <c:if test="${checkResult.udealType==1}">
            <tr>
                <td class="cs-name cs-vertical-top" style="padding-top: 4px;">取证信息：</td>
                <td colspan="3" style="padding-top: 4px;" id="showSwiperImage">
                </td>
            </tr>
        </c:if>
        <tr>
            <td class="cs-name cs-vertical-top">备注：</td>
            <td class="cs-in-style" colspan="3">
                <textarea cols="30" rows="10" class="cs-text-for cs-top-write" disabled="disabled">${checkResult.remark}</textarea>
            </td>
        </tr>
    </table>
</div>


<%--========================================== 以下为溯源信息 ==============================================--%>
<%--<div class="cs-content2" id="sourceId">
    <h3>溯源信息</h3>
    <table class="cs-add-new">
        <tbody>
        <tr>
            <td class="cs-name">进货日期：</td>
            <td class="cs-in-style cs-td-detail" colspan="">
                <input type="text" class="cs-top-write" disabled="disabled" name="purchaseDate"/>
            </td>
            <td class="cs-name">生产批次：</td>
            <td class="cs-in-style">
                <input type="text" class="cs-top-write" disabled="disabled" name="batchNumber"/>
            <td class="cs-name">产地：</td>
            <td class="cs-in-style cs-td-detail">
                <input type="text" class="cs-top-write" disabled="disabled" name="origin"/>
            </td>
        </tr>
        <tr>
            <td class="cs-name">供货商：</td>
            <td class="cs-in-style cs-td-detail" colspan="">
                <input type="text" class="cs-top-write" disabled="disabled" name="supplier"/>
            </td>
            <td class="cs-name">供应商联系人：</td>
            <td class="cs-in-style cs-td-detail" colspan="">
                <input type="text" class="cs-top-write" disabled="disabled" name="persion"/>
            </td>
            <td class="cs-name">联系电话：</td>
            <td class="cs-in-style cs-td-detail" colspan="">
                <input type="text" class="cs-top-write" disabled="disabled" name="phone"/>
            </td>
        </tr>
        <tr>
            <td class="cs-name">供应商地址：</td>
            <td class="cs-in-style cs-td-detail" colspan="5">
                <input class="cs-top-write" style="width:600px;" type="text" disabled="disabled" name="address"/>
            </td>
        </tr>
        </tbody>
    </table>
</div>--%>

<%--==========================================以下为复检历史信息==============================================--%>
<c:if test="${fn:length(checkHistoryList)>=1}">
    <div class="cs-content2">
        <h3>
            <a class="cs-link text-primary" data-toggle="collapse" href="#collapseExample" <%--onclick="showOrClose(this)"--%> aria-expanded="false"
               aria-controls="collapseExample">
                历史记录
            </a>
        </h3>
    </div>
    <br/>
</c:if>
<div class="collapse" id="collapseExample">
    <c:forEach items="${checkHistoryList}" var="history" varStatus="num">
        <c:choose>
            <c:when test="${fn:length(checkHistoryList)>1}">
                <p style="font-size: 12px;font-weight: bold;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;历史 ${num.index+1}</p>
            </c:when>
            <c:otherwise>
                <p class="cs-article-title">&nbsp;&nbsp;历史1</p>
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
                    <input type="text" class="cs-top-write" disabled="disabled" value="<fmt:formatDate type="both" value="${history.checkDate}"/>"/>
                <td class="cs-name">复检人员：</td>
                <td class="cs-in-style">
                    <input type="text" class="cs-top-write" disabled="disabled" value="${history.checkUsername}"></td>
                <td class="cs-name">上传时间：</td>
                <td class="cs-in-style">
                    <input type="text" class="cs-top-write" disabled="disabled" value="<fmt:formatDate type="both" value="${history.updateDate}"/>"/>
            </tr>
            </tbody>
        </table>
    </c:forEach>
</div>
<!-- 底部导航 结束 -->
<div class="cs-hd"></div>
<div class="cs-alert-form-btn" id="showBtn2">
    <a href="javascript:;" onclick="parent.closeMbIframe();" class="cs-menu-btn"><i class="icon iconfont icon-fanhui"></i>返回</a>
</div>
<!-- 内容主体 结束 -->

<%--轮播图查看取证材料--%>
<%@include file="/WEB-INF/view/dataCheck/unqualified/affirmSwiperImage.jsp" %>
<%--人工审核判定考核状态--%>
<%@include file="/WEB-INF/view/dataCheck/unqualified/gs/assessment.jsp" %>
<%--<script src="${webRoot}/js/jquery.min.js"></script>--%>
<script src="${webRoot}/js/jquery.imgbox.pack.js"></script>
<%@include file="/WEB-INF/view/common/modalBox.jsp" %>
</body>
</html>
<script type="text/javascript">
    $(function () {
        //checkRecording();
        $(".cs-img-link").imgbox({
            'speedIn': 0,
            'speedOut': 0,
            'alignment': 'center',
            'overlayShow': true,
            'allowMultiple': false,
            'height': 60
        });
        showThumbnail();
        if(Permission.exist("383-10")){
            let html = '<div class="cs-menu-btn cs-fr cs-ac "><a href="javascript:;" onclick="showAssessment()"><i class="' + Permission.getPermission("383-10").functionIcon + '"></i>' + Permission.getPermission("383-10").operationName + '</a></div>';
            $("#showBtn").append(html);
            //底部审核按钮
            let html2 = '<a class="cs-menu-btn" href="javascript:;" onclick="showAssessment()"><i class="' + Permission.getPermission("383-10").functionIcon + '"></i>' + Permission.getPermission("383-10").operationName + '</a>';
            $("#showBtn2").prepend(html);
        }
        //注册加载失败事件,再次加载时先重新设置url,在清空原先的注册加载失败事件
        <%--$("img").attr("onerror","this.src='${webRoot}/img/default.png'");--%>
    });

    var filesStr="";
    //展示取证材料的缩略图
    function showThumbnail(){
        var files=eval('${unqualifiedFile}');
        //取证材料采用swiper轮播图方式查看
        if(files.length>0){
            $("#showSwiperImage").empty("")
            files.forEach(function(item){
                let html='';
                let url=item.filePath;
                filesStr+=url+","
                let thumbnailPath = url.replace("Enforce/", "Enforce/thumbnail/");
                if (url.indexOf(".png") >= 0 || url.indexOf(".jpg") >= 0 || url.indexOf(".jpeg") >= 0) {//图片
                    html = '<div class="cs-obtain cs-obtain2 cs-fl"><a ' + "onclick='openHandleFile(" + '"' + url + '"' + ")'" + 'class="cs-img-link"><img src="${webRoot}/resources/' + thumbnailPath + '" title="取证材料" class="img-thumbnail" style="height:100%;" onerror="this.src=\'${webRoot}/img/default.png\'" /></a></div>';
                } else if (url.indexOf(".mp4") >= 0) {//视频
                    html = '<div class="cs-obtain cs-obtain2 cs-fl img-thumbnail"><a ' + "onclick='openHandleFile(" + '"' + url + '"' + ")'" + ' style="width:100%; height:100%; display:inline-block;" target="_blank"><i class="icon iconfont icon-shipin" style="height:100%;font-size:16px;"></i> </a></div>';
                } else {
                    html = '<div class="cs-obtain cs-obtain2 cs-fl"><a href="${webRoot}/resources/' + url + '" class="cs-img-link" target="_blank"><i title="取证材料" class="img-thumbnail icon iconfont icon-baogao" style="height:100%;"></i></a></div>';
                }
                $("#showSwiperImage").append(html);
            })

        }
    }
    /**
     *点击图片或者视频查看方法
     * filesStr: 当前对象所有的文件字符串
     * url：当前点击的url，打开模态框后自动显示对应的文件
     */
    function openHandleFile(url) {
        //重新初始化swiper轮播控件
        initSwiper();
        $(".swiper-wrapper").empty("");
        let childHtml = "";
        let activeIndex = 0;
        var files = filesStr.split(",");//拿到该文件对象集合
        for (var i = 0; i < files.length; i++) {
            if(files[i]==''){
                continue;
            }
            childHtml = "";
            //表示是图片，拼接图片
            if (isAssetTypeAnImage(files[i])) {
                childHtml = '<div class="swiper-slide">' +
                    // '            <div class="swiper-zoom-container">' +
                    '            <img class="swiper-lazy" height="92%" data-src="${webRoot}/resources/' + files[i] + '" onerror="this.src=\'${webRoot}/img/load_faild.png\'"/>' +
                    '               <div class="swiper-lazy-preloader swiper-lazy-preloader-white"></div> '+
                    '               <span class="swiper-lazy-context">加载中...</span>'+
                    // '            </div>' +
                    '        </div>';
                $(".swiper-wrapper").append(childHtml);
            } else {
                childHtml = '<div class="swiper-slide">' +
                    // '            <div class="swiper-zoom-container">' +
                    '            <video class=\'video swiper-lazy\' name=\'video\' controls muted autoplay height="300;">' +
                    '                <source src="${webRoot}/resources/' + files[i] + '" type="video/mp4">' +
                    '            </video>' +
                    // '            </div>' +
                    '        </div>';
                $(".swiper-wrapper").append(childHtml);
            }
            if (i != 0 && files[i] == url) {
                activeIndex = i;
            }

            $("#seeimg").removeClass("hide");
        }
        //切换到点击的图片或视频
        if (activeIndex > 0) {
            mySwiper.slideTo(activeIndex, 1000, false);//切换到第一个slide，速度为1秒
        }
    }
    setTimeout(function () {
        $(".container a").hover(function () {
            $(this).append("<p id='pic'><img src='" + $(this).attr("url") + "' id='pic1'></p>");
            $(".container a").mousemove(function (e) {
                $("#pic").css({
                    "top": (e.pageY + 10) + "px",
                    "left": (e.pageX + 20) + "px"
                }).fadeIn("fast");
                $("#pic").fadeIn("fast");
            });
        }, function () {
            $("#pic").remove();
        });
    }, 1000)
    //打开人工审核窗口
    function showAssessment(){
        $("#assessmentForm input[name='id']").val("${checkResult.id}");
        $("#assessmentForm input[name='checkRecordingId']").val("${checkResult.id}");
        $("#assessmentForm input[name='foodName']").val("${checkResult.foodName}");
        $("#assessmentForm input[name='itemName']").val("${checkResult.itemName}");
        $("#assessmentForm select[name='handledAssessment']").val("${checkResult.handledAssessment}");
        $("#assessmentForm textarea[name='handledRemark']").val("${checkResult.handledRemark}");
        $("#assessmentModal").modal('toggle');
    }
    function reloadBack(){
       self.location.reload();
    }
</script>
