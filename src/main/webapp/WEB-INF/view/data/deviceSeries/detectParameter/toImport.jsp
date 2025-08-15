<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <%@include file="/WEB-INF/view/common/resource.jsp" %>
    <%-- <link rel="stylesheet" href="${webRoot}/css/style.css"> --%>
    <title>数据导入</title>
    <link rel="stylesheet" type="text/css" href="${webRoot}/css/fileinput.css"/>
    <link rel="stylesheet" type="text/css" href="${webRoot}/css/theme.css"/>
</head>
<!-- 上传 -->
<script src="${webRoot}/js/sortable.js" type="text/javascript"></script>
<script src="${webRoot}/js/fileinput.js" type="text/javascript"></script>
<script src="${webRoot}/js/zh.js" type="text/javascript"></script>
<script src="${webRoot}/js/theme.js" type="text/javascript"></script>
<style type="text/css">
    .kv-fileinput-error {
        display: none;
    }

    .file-preview-status.text-center {
        padding: 0;
    }
</style>
</head>
<body>
<div class="main" style="width: 410px;margin: 0 auto;">
    <div class="wrapper">
        <form class="" id="saveForm" enctype="multipart/form-data">
            <input type="hidden" name="deviceTypeId" value="${deviceType.id}" />
            <div class="is-flex">
                <label class="control-label"></label>
                <div class="">
                    <p>
                        <b><font color="#000000" size="4">仪器检测项目导入要求：</font></b>
                    </p>
                    <p>
                        1、必须是EXCEL格式。 <a class="text-primary cs-link"
                                         href="${webRoot}/js/deviceparameter_importtemplate.xls">下载模版</a>
                        <br/> 2、模板文件中必填项为必填，否则，不允许导入。<br>
                    </p>
                </div>
            </div>
            <div class="form-groups is-flex">
                <label class="control-label">仪器类别：</label>
                <div class="">
                    <div class="cs-in-style">
                        <div class="cs-input-box cs-all-ps">
                            <input type="text" name="deviceName" readonly="readonly" value="${deviceType.deviceName}" >
                        </div>
                    </div>
                </div>
            </div>
            <div class="form-groups is-flex">
                <label class="control-label">导入文件：</label>
                <div class="kv-main">
                    <input id="kv-explorer" type="file" class="file-caption-name" name="file" accept=".xls,.xlsx"
                           style="color: #666;"/>
                </div>
            </div>

            <div class="form-btn is-flex">
                <button class="btn btn-success" id="btnSave" type="button">导入</button>
                <%--<a class="btn btn-default" href="javascript:history.back()"><i class="iconfont icon-fanhui text-primary"></i> 返回</a>--%>
                <a href="javascript:;" onclick="parent.closeMbIframe(1);" class="cs-menu-btn" style="">返回</a>
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
     data-backdrop="static" data-keyboard="false">
    <div class="modal-dialog cs-alert-width" role="document">
        <div class="modal-content ">
            <div class="modal-header">
                <h4 class="modal-title" id="myModalLabel">提示</h4>
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
    $(document).ready(function () {
        $("#kv-explorer").fileinput({
            'theme': 'explorer',
            'uploadUrl': '#',
            textEncoding: 'UTF-8',
            language: 'zh',
            overwriteInitial: false,
            initialPreviewAsData: false,
            dropZoneEnabled: false,
            showClose: false,
            // maxFileSize: 10240,
            maxFileCount: 0,
            browseLabel: '浏览',
        });
    });
    $("#btnSave").on("click", function () {
        // jquery 表单提交
        var formData = new FormData($('#saveForm')[0]);
        if ($("#kv-explorer").val() == '') {
            $("#confirm-warnning .tips").text("请选择要导入的文件！");
            $("#confirm-warnning").modal('toggle');
            return false;
        }
        $("#myModal-mid4").modal("show");
        $.ajax({
            type: "POST",
            url: '${webRoot}' + "/data/deviceSeries/detectParameter/importData",
            data: formData,
            contentType: false, //必须false才会避开jQuery对 formdata 的默认处理 XMLHttpRequest会对 formdata 进行正确的处理
            processData: false, //必须false才会自动加上正确的Content-Type
            dataType: "json",
            success: function (data) {
                $("#myModal-mid4").modal("hide");
                if (data.success == true) {
                    var importResult=JSON.parse(data.obj);
                    $("#myModalLabel").text("导入成功："+importResult.successCount+" 条，失败："+importResult.failCount+" 条");
                    $("#confirm-sure").find("img").attr("src"," ${webRoot}/img/sure.png")
                    $("#confirm-sure").modal('toggle');
                    if(importResult.failCount>0){
                        $("#myModalLabel").append('<br/><a href="${webRoot}/resources/'+importResult.errFile+'" class="downloadFile cs-hide" style="color: #468ad5;">下载文件查看导入失败原因</a>');
                        $(".downloadFile").removeClass("cs-hide");
                    }else{
                        //全部导入成功,返回上一个页面并刷新数据
                        parent.datagridUtil.queryByFocus();
                        setTimeout(function(){
                            parent.closeMbIframe();

                        },1000)
                    }
                    /*parent.closeMbIframe();
                    datagridUtil.queryByFocus();*/
                } else {
                    $("#confirm-sure").find("img").attr("src"," ${webRoot}/img/stop2.png")
                    $("#myModalLabel").text("导入失败,请检查模板格式！");
                    $("#confirm-sure").modal('toggle');
                }
            }, error: function (error) {
                $("#myModalLabel").text("导入失败");
                $("#confirm-sure").modal('toggle');
            }
        });
        return false;
    });
    document.getElementById("kv-explorer").addEventListener("change", function () {
        let fileSize = $("#kv-explorer")[0].files[0].size / 1024 / 1024;//M
        if (fileSize > 10) {
            $("#myModalLabel").text("文件大小超过200KB，当前文件为：" + fileSize.toFixed(0) + "M");
            $("#confirm-sure").modal('toggle');
        }
    });

</script>
</body>
</html>