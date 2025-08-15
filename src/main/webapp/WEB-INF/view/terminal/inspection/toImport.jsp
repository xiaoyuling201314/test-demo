<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <%@include file="/WEB-INF/view/common/resource.jsp" %>
    <title>数据导入</title>
    <link rel="stylesheet" type="text/css" href="${webRoot}/css/fileinput.css"/>
    <link rel="stylesheet" type="text/css" href="${webRoot}/css/theme.css"/>
</head>
<!-- 上传 -->
<script src="${webRoot}/js/sortable.js" type="text/javascript"></script>
<script src="${webRoot}/js/fileinput.js" type="text/javascript"></script>
<script src="${webRoot}/js/zh.js" type="text/javascript"></script>
<script src="${webRoot}/js/theme.js" type="text/javascript"></script>
</head>
<body>
<div class="main" style="width: 410px;margin: 0 auto;">
    <div class="wrapper">
        <form class="" id="saveForm" enctype="multipart/form-data">
            <input type="hidden" name="type" value="${type}">
            <%--<div class="form-group col-sm-12 col-md-12">--%>
            <%--<label class="col-sm-4 control-label"></label>--%>
            <%--<div class="col-sm-8">--%>
            <%--<p>--%>
            <%--<b>--%>
            <%--<font color="#000000" size="4">--%>

            <%--</font>--%>
            <%--</b>--%>
            <%--</p>--%>
            <%--<p>--%>
            <%--<font color="#000000">1、文件必须是EXCEL格式。--%>
            <%--<a href="${webRoot}/js/inspection_importtemplate${type+1}.xlsx"--%>
            <%--style="text-decotation: underline; color: #FF0000;">点击此处下载模版</a>--%>
            <%--</font> <br/> 2、表格中标识为必填项的必须填写,不写则导入失败。<br>--%>
            <%--</p>--%>
            <%--</div>--%>
            <%--</div>--%>
            <div class="is-flex">
                <label class="control-label"></label>
                <div class="">
                    <!--
                    <p>
                        <b><font color="#000000" size="4">
                            <c:if test="${type eq '0'}">
                                送检单位（<span style="color: red">企业</span>）导入要求：
                            </c:if>
                            <c:if test="${type eq '1'}">
                                送检单位（<span style="color: red">个体户</span>）导入要求：
                            </c:if>
                            <c:if test="${type eq '2'}">
                                送检单位（<span style="color: red">供应商</span>）导入要求：
                            </c:if>
                        </font></b>
                    </p>-->
                    <p>
                        <b><font color="#000000" size="4">经营者导入要求：</font></b>
                    </p>

                    <p>
                        1、必须是EXCEL格式。 <a class="text-primary cs-link"
                                         href="${webRoot}/js/inspectiontocold_importtemplate.xlsx">下载模版</a>
                        <br/> 2、模板文件中必填项为必填，否则，不允许导入。<br>
                        3、导入最大记录数量为<b style="color: #FF0000;">2000条（约200KB）</b>，超出不允许导入！
                    </p>
                </div>
            </div>
            <div class="form-groups is-flex">
                <label class="control-label">导入文件：</label>
                <div class="kv-main">
                    <input id="kv-explorer" type="file" class="file-caption-name" name="file" accept=".xls,.xlsx"
                           style="color: #666;" multiple/>
                </div>
            </div>

            <div class="form-btn is-flex">
                <div class="">
                    <button class="btn btn-success" id="btnSave" type="button">导入</button>
                    <a class="btn btn-default" href="javascript:history.back()"><i class="iconfont icon-fanhui text-primary"></i>返回</a>
                </div>
            </div>
        </form>
    </div>
</div>

<div class="modal fade intro2" id="confirm-sure" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
     aria-hidden="false" style="z-index: 10000" data-backdrop="static" data-keyboard="false">
    <div class="modal-dialog cs-alert-width">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title">提示</h4>
            </div>
            <div class="modal-body cs-alert-height cs-dis-tab">
                <div class="cs-text-algin">
                    <img src="${webRoot}/img/stop2.png" width="40px"/> <span class="tips" id="myModalLabel"></span>
                </div>
            </div>
            <div class="modal-footer">
                <a class="btn btn-danger btn-ok" data-dismiss="modal">关闭</a>
            </div>
        </div>
    </div>
</div>
<div class="modal fade intro2" id="myModal-mid4" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
     data-backdrop="static"
     data-keyboard="false">
    <div class="modal-dialog cs-alert-width" role="document">
        <div class="modal-content ">
            <div class="modal-header">
                <h4 class="modal-title">提示</h4>
            </div>
            <div class="modal-body cs-alert-height cs-dis-tab">
                <div class="cs-text-algin" style="">
                    <img src="${webRoot}/img/wait.gif" alt=""><i class="cs-font-io text-primary">正在导入......</i>
                </div>
            </div>

        </div>
    </div>
</div>
<%@include file="/WEB-INF/view/common/confirm.jsp" %>
<script type="text/javascript">
    $("#btnSave").on("click", function () {
        var formData = new FormData($('#saveForm')[0]);
        if ($("#kv-explorer").val() == '') {
            $("#confirm-warnning .tips").text("请选择要导入的文件！");
            $("#confirm-warnning").modal('toggle');
            return false;
        }
        $("#myModal-mid4").modal("show");
        $.ajax({
            type: "POST",
            url: '${webRoot}' + "/inspection/unit/importData.do",
            data: formData,
            contentType: false,
            processData: false,
            dataType: "json",
            success: function (data) {
                $("#myModal-mid4").modal("hide");
                if (data.success == true) {
                    $("#myModalLabel").text("导入成功");
                    $("#confirm-sure").modal('toggle');
                    if('${fromPage}'=='cold'){
                        location.href = "${webRoot}/cold/unit/list";
                    }else{
                    location.href = "${webRoot}/inspection/unit/list";
                    }
                } else {
                    if (data.obj == "失败") {//如果为失败则直接下载失败详情文档给用户
                        window.location.href = "${webRoot}/resources/" + data.msg;
                    }
                    $("#myModalLabel").text("导入失败");
                    $("#confirm-sure").modal('toggle');
                }
            }, error: function (error) {
                $("#myModal-mid4").modal("hide");
                $("#myModalLabel").text("导入失败");
                $("#confirm-sure").modal('toggle');
            }
        });
        return false;
    });
    //上传控件
    $("#file-1").fileinput({
        uploadUrl: '#',
        allowedFileExtensions: ['xls', 'xlsx'],
        overwriteInitial: false,
        maxFileSize: 1000,
        maxFilesNum: 10,
        slugCallback: function (filename) {
            return filename.replace('(', '_').replace(']', '_');
        }
    });
    $("#file-4").fileinput({
        uploadExtraData: {kvId: '10'}
    });
    $(".btn-warning").on('click', function () {
        var $el = $("#file-4");
        if ($el.attr('disabled')) {
            $el.fileinput('enable');
        } else {
            $el.fileinput('disable');
        }
    });
    $(".btn-info").on('click', function () {
        $("#file-4").fileinput('refresh', {previewClass: 'bg-info'});
    });
    $(document).ready(function () {
        $("#test-upload").fileinput({
            'showPreview': false,
            'allowedFileExtensions': ['xls', 'xlsx'],
            'elErrorContainer': '#errorBlock'
        });
        $("#kv-explorer").fileinput({
            'theme': 'explorer',
            'uploadUrl': '#',
            textEncoding: 'UTF-8',
            language: 'zh',
            overwriteInitial: false,
            initialPreviewAsData: true,
            dropZoneEnabled: false,
            showClose: false,
            maxFileCount: 10,
            browseLabel: '浏览',
        });
    });
</script>
</body>
</html>