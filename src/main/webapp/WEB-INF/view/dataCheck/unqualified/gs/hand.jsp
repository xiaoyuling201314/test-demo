<%@page import="java.util.Date" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/WEB-INF/view/common/resource.jsp" %>
<html>
<head>
    <title>快检服务云平台</title>
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
        <li class="cs-fl">不合格处理</li>
        <li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
        <li class="cs-fl"><a href="javascript:;" class="returnBtn">待处理</a></li>
        <li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
        <li class="cs-b-active cs-fl">处理操作</li>
    </ol>
<%--    <div class="cs-search-box cs-fr">--%>
<%--        <div class="cs-fr cs-ac ">--%>
<%--            <a href="javascript:;" id="saveUnqualified" class="cs-menu-btn"><i class="icon iconfont icon-save"></i>保存</a>--%>
<%--            <a href="javascript:;" onclick="self.history.back();" class="cs-menu-btn returnBtn"><i class="icon iconfont icon-fanhui"></i>返回</a>--%>
<%--        </div>--%>
<%--    </div>--%>
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
                <input type="text" class="cs-top-write" disabled="disabled" value="${checkResult.limitValue}"/></td>
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
            <td class="cs-name">检测标准：</td>
            <td class="cs-in-style cs-td-detail">
                <input type="text" class="cs-top-write" disabled="disabled" value="${checkResult.checkAccord}"/>
            </td>
            <td class="cs-name">抽样编号：</td>
            <td class="cs-in-style">
                <input type="text" class="cs-top-write" disabled="disabled" value="${checkResult.sampleCode}"></td>
        </tr>
        <tr>
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
                <td class="cs-name" style="width: 100px;">处理结果：</td>
                <td class="cs-check-radio">
                    <input type="radio" id="ok" name="shit" checked="true">
                    <label for="ok">无异议</label>
                    <input type="radio" id="no" name="shit">
                    <label for="no">有异议</label>
                </td>
            </tr>
            </tbody>
        </table>
        <div class="cs-hd clearfix"></div>
        <!-- 无异议 -->
        <div>
            <form action="${webRoot}/dataCheck/unqualified/save.do" id="saveForm" method="post" enctype="multipart/form-data">
                <input class="cs-hide" type="text" name="treatment.id" value="${checkResult.dutId}"/>
                <input class="cs-hide" type="text" name="treatment.checkRecordingId" value="${checkResult.id}"/>
                <input class="cs-hide" type="text" name="treatment.dealType" value="1"/>
                <input class="cs-hide" type="text" name="treatment.dealMethod" value="1"/>
                <input class="cs-hide" type="text" name="treatment.recheckResult" value=""/>
                <table>
                    <tr>
                        <td class="cs-name" style="width:140px;">
                            <i class="cs-mred">*</i>接收报告时间：
                        </td>
                        <td class="cs-in-style " style="width:250px;">
                            <input class="cs-time" type="text" name="treatment.sendDate"
                                   value="<fmt:formatDate value='<%=new Date() %>' pattern='yyyy-MM-dd HH:mm:ss' />"
                                   onClick="WdatePicker({startDate:'%y-%M-%d %H:%m:%s',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true,minDate:'<fmt:formatDate type='both' value='${checkResult.checkDate}'/>'})"
                                   datatype="*" nullmsg="请选择接受报告日期"/>
                        <td class="cs-name handle_mode" style="width:140px;">
                            <i class="cs-mred">*</i>处理方式：
                        </td>
                        <td class="cs-in-style cs-chioce-list" rowspan="20">
                            <div class="cs-input-box"></div>
                            <div id="divBtn" class="cs-check-downs ">
                                <ul style="margin-top: 10px;">
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
                                                <c:if test="${not empty config.valueType}">
                                                    <input name="disposeList[${index.index}].disposeValue1" placeholder="请输入" type="text"
                                                           onkeyup="if(isNaN(value))execCommand('undo')"
                                                           onafterpaste="if(isNaN(value))execCommand('undo')">
                                                </c:if>
                                                <c:if test="${empty config.valueType}">
                                                    <input name="disposeList[${index.index}].disposeValue" placeholder="请输入" type="text">
                                                </c:if>
                                                <i>${config.valueType}</i>
                                            </div>
                                        </li>
                                    </c:forEach>
                                </ul>
                            </div>
                        </td>
                        <td class="cs-name "></td>
                        <td class="cs-in-style "></td>
                    </tr>
                    <tr>
                        <td class="cs-name"><i class="cs-mred">*</i>处理时间：</td>
                        <td class="cs-in-style " style="width:250px;">
                            <input type="text" name="treatment.updateDate" class="cs-time"
                                   value="<fmt:formatDate value='<%=new Date() %>' pattern='yyyy-MM-dd HH:mm:ss' />"
                                   onClick="WdatePicker({startDate:'%y-%M-%d %H:%m:%s',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true,minDate:'<fmt:formatDate type='both' value='${checkResult.checkDate}'/>'})"
                                   datatype="*" nullmsg="请选择处理日期"/>
                        </td>
                    </tr>
                    <tr>
                        <td class="cs-name " id="supervise1"><i class="cs-mred">*</i>监督人签名：</td>
                        <td class="cs-in-style " id="supervise2">
                            <input type="text" name="treatment.supervisor" datatype="*" nullmsg="请输入监督人签名" class="inputxt"/>
                        </td>
                        <td class="cs-name hide" id="sperson1"><i class="cs-mred">*</i>送检人签名：</td>
                        <td class="cs-in-style hide" id="sperson2">
                        </td>
                    </tr>
                    <tr>
                        <td class="cs-name phone1">监督人联系方式：</td>
                        <td class="cs-in-style phone2">
                            <input type="text" name="treatment.supervisorPhone" value="" ignore="ignore" datatype="*" nullmsg="请输入手机号码"/></td>
                        <td class="cs-name depart1 hide">复检机构：</td>
                        <td class="cs-in-style depart2 hide">
                            <input type="text" name="treatment.recheckDepart" id="departName">
                        </td>
                    </tr>
                    <tr>
                        <td class="cs-name">取证信息附件：</td>
                        <td>
                            <div style="width:200px;margin-bottom: 10px;" id="dealImageUpload">

                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td class="cs-name remark">备注：</td>
                        <td class="cs-in-style " colspan="3">
                            <textarea class="cs-inform-txt" name="treatment.remark" cols="30" rows="10"></textarea>
                        </td>
                    </tr>
                </table>
                <div class="cs-hd"></div>
                <div class="cs-alert-form-btn">
                    <a href="javascript:;" class="cs-menu-btn" id="btnSave" onclick="myValidform();"><i class="icon iconfont icon-save"></i>保存</a>
                    <a href="${webRoot}/dataCheck/unqualified/list" class="cs-menu-btn"><i
                            class="icon iconfont icon-fanhui"></i>返回</a>
                </div>
            </form>
        </div>
    </div>
    <!-- 有异议 -->
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
<!-- 内容主体 结束 -->
<%@include file="/WEB-INF/view/common/confirm.jsp" %>
<%--处理中模态框--%>
<%@include file="/WEB-INF/view/dataCheck/unqualified/showWaiting.jsp" %>
<!-- JavaScript -->
<script type="text/javascript">
    //文件上传插件初始化
    let upload = uploader({
        id: "dealImageUpload", //容器渲染的ID 必填
        maxCount: 5, //允许的最大上传数量
        maxSize: 50, //允许的文件大小 单位：M
        multiple: true, //是否支持多文件上传
        name: 'dealImgurlFile', //后台接收的文件名称
        accept: ".png,.jpg,.jpeg,.mp4",
        onAlert: function (msg) {
            $("#waringMsg>span").html(msg);
            $("#confirm-warnning").modal('toggle');
        }
    });
    //保存类型,1无异议,0有异议(默认0)
    var saveType = 0;
    $(document).on("click", "#ok", function () {//有异议
        saveType = 0;
        hideOrShow(saveType);

    });

    $(document).on("click", "#no", function () {//无异议
        saveType = 1;
        hideOrShow(saveType);


    });

    //控制展示和隐藏
    function hideOrShow(state) {
        if (state) {//有异议
            upload.cleanModalHtml();
            //隐藏处理方式
            $(".handle_mode").addClass("hide");
            $(".cs-chioce-list").addClass("hide");
            //隐藏监督人签名
            $("#supervise1").addClass("hide");
            $("#supervise2").addClass("hide");
            $(".phone1").addClass("hide");
            $(".phone2").addClass("hide");
            //显示送检相关信息
            $("#sperson1").removeClass("hide");
            $("#sperson2").removeClass("hide");
            $(".remark").text("复检备注");
            $(".depart1").removeClass("hide");
            $(".depart2").removeClass("hide");
            //去除必填功能并设置值为空
            $("#sperson2").html(' <input name="treatment.spersonName" datatype="*" nullmsg="请输入送检人签名" type="text" value=""/>');
            $("#supervise2").html('');
            $("input[name=checkCk]").removeAttr("datatype");
            //$("#divBtn").html('');

            //$("a").removeAttr("onclick");
            //设置值
            $("input[name='treatment.dealMethod']").val(0);
            $("input[name='treatment.recheckResult']").val("处理中");

        } else {//无异议
            upload.cleanModalHtml();
            //展示处理方式
            $(".handle_mode").removeClass("hide");
            $(".cs-chioce-list").removeClass("hide");
            //展示监督人信息
            $("#sperson1").addClass("hide");
            $("#sperson2").addClass("hide");
            $(".remark").text("备注");
            $(".phone1").removeClass("hide");
            $(".phone2").removeClass("hide");
            //隐藏送检信息
            $("#sperson1").addClass("hide");
            $("#sperson2").addClass("hide");
            $("#supervise1").removeClass("hide");
            $("#supervise2").removeClass("hide");
            $(".depart1").addClass("hide");
            $(".depart2").addClass("hide");
            //去除送检人的必填功能并设置值为空
            $("#sperson2").html('');
            $("#supervise2").html('<input type="text" name="treatment.supervisor" datatype="*" nullmsg="请输入监督人签名" class="inputxt"/>');
            $("input[name=checkCk]").attr("datatype","needChose");
            //设置值
            $("input[name='treatment.dealMethod']").val(1);
            $("input[name='treatment.recheckResult']").val("");
        }
    }

    //校验
    function myValidform(){
        //附件校验
        let files = upload.files;
        if (files.length <= 0) {
            $("#fjjyModal").modal('show');
            return false;
        }

        mySave();
    }

    //保存
    function mySave(){
        if (saveType == 0) {
            $("input[type='checkbox']:checked").each(function () {
                var iii = $(this).val();
                $("input[id=" + iii + "]").val(iii);//设置处理方式的value
            });
            $("#saveForm").submit();
        } else if (saveType == 1) {
            $("#saveForm").submit();
        }
    }

    $(function () {
        //表单验证
        $("#saveForm").Validform({
            datatype: {//验证处理方式必选一个
                "needChose": function (gets, obj, curform, regxp) {
                    var need = 1,
                        numselected = curform.find("input[name='" + obj.attr("name") + "']:checked").length;
                    return numselected >= need ? true : "请至少选择" + need + "项！";
                }
            },
            beforeSubmit: function () {
                $("#confirmModal .tips").text("请确认上传的内容不涉及国家秘密。");
                $("#confirmModal").modal('toggle');
                return false;
            }
        });
    });

    // 确认保存
    function confirmModal() {
        $("#saveUnqualified,#btnSave").attr("disabled", "disabled");
        $("#myModal-waiting").modal("show");
        var formData = new FormData($('#saveForm')[0]);
        let files = upload.files;
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
                    self.history.back(-1);
                } else {
                    $("#waringMsg>span").html(data.msg);
                    $("#confirm-warnning").modal('toggle');
                }
            },error: function(e){
                $("#saveUnqualified,#btnSave").removeAttr("disabled");
                $("#myModal-waiting").modal("hide");
                $("#waringMsg>span").html("处理失败！");
                $("#confirm-warnning").modal('toggle');
            }
        });
    }

    //返回
    $(document).on("click", ".returnBtn", function () {
        self.history.back();
    });

    var pid = '';//当前用户组织机构ID
    if ('${sessionScope.org}') {
        pid = '${sessionScope.org.departPid}';
    }

    //组织机构树
    $('#myDeaprtTree').combotree({
        url: '${webRoot}' + "/detect/depart/getDepartTree.do?pid=" + pid,
        multiple: false,//定义是否多选
        onChange: function () {
            //setDepart();
        }
    })

    function setDepart() {
        var id = $('#myDeaprtTree').combotree('getValue');
        var text = $('#myDeaprtTree').combotree('getText');
        $('#saveForm2').find("input[id='departId']").val(id);
        $('#saveForm2').find("input[id='departName']").val(text);
    }
</script>

</body>
</html>
 