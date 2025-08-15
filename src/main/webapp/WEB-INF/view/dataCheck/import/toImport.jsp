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
            <div class="is-flex">
                <label class="control-label"></label>
                <div class="">
                    <p>
                        <b><font color="#000000" size="4">检测数据导入要求：</font></b>
                    </p>
                    <p>
                        1、必须是EXCEL格式。 <a class="text-primary cs-link"
                                         href="${webRoot}/js/checkdata_importtemplate.xlsx">下载模版</a>
                        <br/> 2、模板文件中必填项为必填，否则，不允许导入。<br>
                        3、导入最大记录数量为<b style="color: #FF0000;">2000条（约200KB）</b>，超出不允许导入！
                        <c:if test="${serverName eq 'gs.chinafst.cn'}">
						    4、导入检测数据无法提供检测凭据，会被视为<b style="color: #FF0000;">无效数据</b>。如需导入有效数据，请<b style="color: #FF0000;">向省局申请</b>，申请成功后，把上传数据的账号和申请凭据提供给平台维护方配置。
                        </c:if>
                    </p>
                </div>
            </div>
            <div class="form-groups is-flex">
                <label class="control-label">机构名称：</label>
                <div class="">
                    <div class="cs-in-style">
                        <div class="cs-input-box cs-all-ps">
                            <input type="text" id="departName" name="departName" readonly="readonly" datatype="*"
                                   ignore="ignore"
                                   nullmsg="请选择所属机构" errormsg="请选择所属机构"> <input type="hidden" id="departId"
                                                                                name="departId" datatype="*"
                                                                                ignore="ignore" nullmsg="请选择所属机构"
                                                                                errormsg="请选择所属机构">
                            <div class="cs-down-arrow"></div>
                        </div>
                        <div class="cs-check-down cs-hide" style="display: none;">
                            <ul id="myDeaprtTree" class="easyui-tree"></ul>
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
                <a class="btn btn-default" href="javascript:history.back()"><i class="iconfont icon-fanhui text-primary"></i> 返回</a>
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
            <%--url : '${webRoot}' + "/dataCheck/recording/importData",--%>
            url: '${webRoot}' + "/import/importData",
            data: formData,
            contentType: false, //必须false才会避开jQuery对 formdata 的默认处理 XMLHttpRequest会对 formdata 进行正确的处理
            processData: false, //必须false才会自动加上正确的Content-Type
            dataType: "json",
            success: function (data) {
                $("#myModal-mid4").modal("hide");
                if (data.success == true) {
                    $("#myModalLabel").text("导入成功");
                    $("#confirm-sure").modal('toggle');
                    location.href = "${webRoot}/import/list";
                } else {
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
    var treeLoadTimes = 1; //控制获取顶级树
    var topNodeId = '';
    var topNodeText = '';
    $('#myDeaprtTree').tree({
        checkbox: false,
        url: '${webRoot}' + "/detect/depart/getDepartTree.do?isJoinId=true",
        animate: true,
        onClick: function (node) {
            $('#departId').val(node.id);
            $('#departName').val(node.text);
            $(".cs-check-down").hide();
        },
        onLoadSuccess: function (node, data) {
            //设置新增所属机构为当前用户所属机构
            if (treeLoadTimes == 1) {
                treeLoadTimes++;
                var topNode = $('#myDeaprtTree').tree('getRoot');
                topNodeId = topNode.id;
                topNodeText = topNode.text;
                $('#departId').val(topNode.id);
                $('#departName').val(topNode.text);
            }
        }
    });

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
            maxFileSize: 200,
            maxFileCount: 0,
            browseLabel: '浏览',
        });
    });
    document.getElementById("kv-explorer").addEventListener("change", function () {
        let fileSize = $("#kv-explorer")[0].files[0].size / 1024;//KB
        if (fileSize > 200) {
            $("#myModalLabel").text("文件大小超过200KB，当前文件为：" + fileSize.toFixed(0) + "KB");
            $("#confirm-sure").modal('toggle');
        }
    });

</script>
</body>
</html>