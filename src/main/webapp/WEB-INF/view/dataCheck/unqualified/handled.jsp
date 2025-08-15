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

       /* #imgbox-loading {
            position: absolute;
            top: 0;
            left: 0;
            cursor: pointer;
            display: none;
            z-index: 90;
        }

        #imgbox-loading div {
            background: #FFF;
            width: 100%;
            height: 100%;
        }

        #imgbox-overlay {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: #000;
            display: none;
            z-index: 80;
        }

        .imgbox-wrap {
            position: absolute;
            top: 0;
            left: 0;
            display: none;
            z-index: 90;
        }

        .imgbox-img {
            padding: 0;
            margin: 0;
            border: none;
            width: 100%;
            height: 100%;
            vertical-align: top;
            border: 10px solid #fff;
        }

        .imgbox-title {
            padding-top: 10px;
            font-size: 11px;
            text-align: center;
            font-family: Arial;
            color: #333;
            display: none;
        }

        .imgbox-bg-wrap {
            position: absolute;
            padding: 0;
            margin: 0;
            display: none;
        }

        .imgbox-bg {
            position: absolute;
            width: 20px;
            height: 20px;
        }
        .img-thumbnail{
            border: 0;
        }
        */

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
        <li class="cs-fl"><a href="javascript:" onclick="self.history.back();">已处理</a></li>
        <li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
        <li class="cs-b-active cs-fl">处理结果</li>
    </ol>
    <div class="cs-search-box cs-fr">
        <div class="cs-menu-btn cs-fr cs-ac ">
            <a href="javascript:;" onclick="parent.closeMbIframe();"><i class="icon iconfont icon-fanhui"></i>返回</a>
        </div>
    </div>
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
            <td class="cs-name">复检时间：</td>
            <td class="cs-in-style cs-td-detail" colspan="">
                <input type="text" class="cs-top-write" disabled="disabled" value="<fmt:formatDate type="both" value="${checkResult.checkDate}"/>"/>
            </td>
        </tr>
        <tr>
            <td class="cs-name">复检值：</td>
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
                  <%--  <c:if test="${!empty unqualifiedFile}">
                        <c:forEach items="${unqualifiedFile}" var="uf">
                            <c:choose>
                                <c:when test="${fn:contains(uf.filePath, '.jpg') || fn:contains(uf.filePath, '.png')}">
                                    <div class="cs-obtain cs-fl">
                                        <a class="cs-img-link" href="${resourcesUrl}/${uf.filePath}" style="width:100%; height:100%; display:flex; justify-content: center;align-items: center">
                                            <img src="${resourcesUrl}/${uf.filePath}" style="height:100%;">
                                        </a>
                                    </div>
                                </c:when>
                                <c:when test="${fn:contains(uf.filePath, '.mp4')}">
                                    <div class="cs-obtain cs-fl img-thumbnail">
                                        <a target="_blank" href="${resourcesUrl}/${uf.filePath}" style="width:100%; height:100%; display:flex; justify-content: center;align-items: center">
                                            <i class="icon iconfont icon-shipin" style="font-size:26px;"></i>
                                        </a>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="cs-obtain cs-fl">
                                        <a target="_blank" href="${resourcesUrl}/${uf.filePath}" style="height:100%; display:flex; justify-content: center;align-items: center">
                                            <i class="icon iconfont icon-baogao" style="font-size:26px;"></i>
                                        </a>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>
                    </c:if>--%>
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
                  <%--  <c:if test="${!empty unqualifiedFile}">
                        <c:forEach items="${unqualifiedFile}" var="uf">
                            <c:choose>
                                <c:when test="${fn:contains(uf.filePath, '.jpg') || fn:contains(uf.filePath, '.png')}">
                                    <div class="cs-obtain cs-fl">
                                        <a class="cs-img-link" href="${resourcesUrl}/${uf.filePath}" style="width:100%; height:100%; display:flex; justify-content: center;align-items: center">
                                            <img src="${resourcesUrl}/${uf.filePath}" style="height:100%;">
                                        </a>
                                    </div>
                                </c:when>
                                <c:when test="${fn:contains(uf.filePath, '.mp4')}">
                                    <div class="cs-obtain cs-fl img-thumbnail">
                                        <a target="_blank" href="${resourcesUrl}/${uf.filePath}" style="width:100%; height:100%; display:flex; justify-content: center;align-items: center">
                                            <i class="icon iconfont icon-shipin" style="font-size:26px;"></i>
                                        </a>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="cs-obtain cs-fl">
                                        <a target="_blank" href="${resourcesUrl}/${uf.filePath}" style="height:100%; display:flex; justify-content: center;align-items: center">
                                            <i class="icon iconfont icon-baogao" style="font-size:26px;"></i>
                                        </a>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>
                    </c:if>--%>
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
<div class="cs-alert-form-btn">
    <a href="javascript:;" onclick="parent.closeMbIframe();" class="cs-menu-btn"><i class="icon iconfont icon-fanhui"></i>返回</a>
</div>
<!-- 内容主体 结束 -->
<%--轮播图查看取证材料--%>
<%@include file="/WEB-INF/view/dataCheck/unqualified/affirmSwiperImage.jsp" %>
<script src="${webRoot}/js/jquery.min.js"></script>
<script src="${webRoot}/js/jquery.imgbox.pack.js"></script>
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
    /* function showOrClose(o) {
     var obj = $(o);
     $("#collapseExample").hasClass("in") ? obj.html("展开复检记录") : obj.html("收起复检记录");
     }*/

    //溯源信息
    /* function checkRecording() {
     if ("￥{rId}") {
     $.ajax({
     type: "POST",
     url: '￥{webRoot}' + "/dataCheck/unqualified/sourceData.do",
     data: {"rId": "￥{rId}"},
     dataType: "json",
     success: function (data) {
     if (data && data.success) {
     if (data.obj) {
     var sourceObj1 = data.obj;
     var sourceObj2 = data.obj.ledgerStock;
     var purchaseDate;
     var batchNumber;
     var origin;
     var supplier;
     var persion;
     var phone;
     var address;
     if (data.obj.souce == '1' && sourceObj2) {//台账溯源
     console.log("进货日期：" + sourceObj2.stockDate);
     console.log("生产批次：" + sourceObj2.batchNumber);
     console.log("产地：" + sourceObj2.param1);
     console.log("供货商：" + sourceObj2.supplier);
     console.log("供货商联系人：" + sourceObj2.supplierUser);
     console.log("联系电话：" + sourceObj2.supplierTel);
     console.log("供货商地址：" + sourceObj2.productionPlace);
     if (sourceObj2.stockDate) $("input[name=purchaseDate]").val(sourceObj2.stockDate); //进货日期
     if (sourceObj2.batchNumber) $("input[name=batchNumber]").val(sourceObj2.batchNumber);    //生产批次
     if (sourceObj2.origin) $("input[name=origin]").val(sourceObj2.origin);                   //产地
     if (sourceObj2.supplier) $("input[name=supplier]").val(sourceObj2.supplier);             //供货商
     if (sourceObj2.persion) $("input[name=persion]").val(sourceObj2.persion);                //供货商联系人
     if (sourceObj2.phone) $("input[name=phone]").val(sourceObj2.phone);                      //联系电话
     if (sourceObj2.address) $("input[name=address]").val(sourceObj2.address);                //供货商地址
     } else if (sourceObj1) {
     if (sourceObj1.purchaseDate) $("input[name=purchaseDate]").val(sourceObj1.purchaseDate); //进货日期
     if (sourceObj1.batchNumber) $("input[name=batchNumber]").val(sourceObj1.batchNumber);    //生产批次
     if (sourceObj1.origin) $("input[name=origin]").val(sourceObj1.origin);                   //产地
     if (sourceObj1.supplier) $("input[name=supplier]").val(sourceObj1.supplier);             //供货商
     if (sourceObj1.persion) $("input[name=persion]").val(sourceObj1.persion);                //供货商联系人
     if (sourceObj1.phone) $("input[name=phone]").val(sourceObj1.phone);                      //联系电话
     if (sourceObj1.address) $("input[name=address]").val(sourceObj1.address);                //供货商地址
     }
     }
     }
     }
     });
     }
     }*/

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
</script>
