<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 下拉插件 -->
<script src="${webRoot}/js/select/tabcomplete.min.js"></script>
<script src="${webRoot}/js/select/livefilter.min.js"></script>
<script src="${webRoot}/js/select/bootstrap-select.js"></script>
<script src="${webRoot}/js/select/filterlist.js"></script>
<link rel="stylesheet" type="text/css" href="${webRoot}/plug-in/myUpload/css/easyupload.css"/>
<script src="${webRoot}/plug-in/myUpload/js/easyupload.js" type="text/javascript"></script>
<style type="text/css">
    .cs-input-box .Validform_checktip {
        display: none;
    }

    .file-name-span {
        color: blue;
    }

    .file-name-span:hover {
        color: #3033ff;
        cursor: pointer;
    }

    .cs-add-new {
        table-layout: fixed;
    }

    .cs-add-new .cs-name {
        width: 160px;
    }
</style>

<!-- 新增、编辑检测点模态框 -->
<form id="addPointForm" method="post">
    <input type="hidden" name="id"/>
    <input type="hidden" name="departId" value="${departId}">
    <input type="hidden" name="deleteFlag" value="0"/>
    <input type="hidden" name="pointTypeId" value="3"/><%--检测点性质->企业--%>
    <input type="hidden" name="pointType" value="2"/><%--检测点类型->企业检测室--%>
    <input type="hidden" name="regulatoryId" value="${regulatoryId}"/><%--被检单位ID--%>
    <input type="hideden" name="sampleDelivery" value="0"><%--不接受送样--%>
    <div class="modal fade" id="addPointModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
         data-backdrop="static">
        <div class="modal-dialog cs-mid-width" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h4 class="modal-title">新增检测点</h4>
                </div>
                <div class="modal-body cs-mid-height">
                    <div class="cs-content">
                        <table class="cs-add-new">
                            <tr>
                                <td class="cs-name">所属企业：</td>
                                <td class="cs-in-style">
                                    ${departName}
                                </td>
                            </tr>
                            <tr>
                                <td class="cs-name"><i class="cs-mred">*</i>检测室名称：</td>
                                <td class="cs-in-style">
                                    <input type="text" name="pointName" datatype="*" nullmsg="请输入检测室名称" errormsg="请输入检测室名称"/>
                                </td>
                            </tr>
                            <tr id="signatureType" class="cs-hide">
                                <td class="cs-name">电子章设置：</td>
                                <td class="cs-check-radio cs-li-radio">
                                    <label for="type1">
                                        <input id="type1" type="radio" name="signatureType" value="0"
                                               checked="checked"/>默认
                                    </label>
                                    <label for="type2">
                                        <input id="type2" type="radio" name="signatureType" value="1"/>自定义
                                    </label>
                                    <label for="type3">
                                        <input id="type3" type="radio" name="signatureType" value="2"/>无
                                    </label>
                                </td>
                            </tr>
                            <tr id="customizeSignature" class="cs-hide">
                                <td class="cs-name">附件：</td>
                                <td class="cs-in-style">
                                    <div id='uploaderFile'></div>
                                </td>
                            </tr>
                            <tr>
                                <td class="cs-name">地址：</td>
                                <td class="cs-in-style"><input type="text" name="address"/></td>
                            </tr>
                            <tr>
                                <td class="cs-name">备注：</td>
                                <td class="cs-in-style">
                                    <textarea name="remark" cols="30" rows="10" style="height: 80px;"></textarea>
                                </td>
                            </tr>
                            <tr class="show_sorting hide">
                                <td class="cs-name">序号：</td>
                                <td class="cs-in-style">
                                    <input type="text" name="sorting" id="sorting" ignore="ignore" class="inputxt"
                                           onkeyup="clearNoNum2(this)" onblur="clearNoNum2(this)"/>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-success" id="btnSave">确定</button>
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                </div>
            </div>
        </div>
    </div>
</form>

<!-- JavaScript -->
<script type="text/javascript">
    var uploaderobj = [];
    $(function () {
        if (Permission.exist("1497-20")) {//送样配置
            $("#sampleDelivery").removeClass("cs-hide");
        }
        if (Permission.exist("1497-21")) {//电子章配置
            $("#signatureType").removeClass("cs-hide");
        }
        uploaderobj = easyUploader({
            id: "uploaderFile", //容器渲染的ID 必填
            accept: '*',    //可上传的文件类型
            maxCount: 5,   //允许的最大上传数量
            maxSize: 1024,  //允许的文件大小 单位：M
            multiple: true, //是否支持多文件上传
            name: "files",     //后台接收的文件名称
            isEncrypt: false,//是否加密
            onChange: function (fileList) {
                //input选中时触发
            },
            onAlert: function (msg) {
                $("#confirm-warnning .tips").text(msg);
                $("#confirm-warnning").modal('toggle');
            }
        });
    });
    $("#btnSave").click(function () {
        $("#addPointForm").submit();
    });
    //验证
    var addPointValidform = $("#addPointForm").Validform({
        tiptype: 3,
        label: ".label",
        showAllError: true,
        beforeSubmit: function () {
            $("#btnSave").attr("disabled", "disabled");
            var formData = new FormData($('#addPointForm')[0]);
            var fileList = uploaderobj.files;
            for (var i = 0; i < fileList.length; i++) {
                formData.append("urlPathFile", fileList[i]);
            }
            $.ajax({
                type: "POST",
                url: "${webRoot}/detect/basePoint/save.do",
                data: formData,
                contentType: false, //必须false才会避开jQuery对 formdata 的默认处理 XMLHttpRequest会对 formdata 进行正确的处理
                processData: false, //必须false才会自动加上正确的Content-Type
                dataType: "json",
                success: function (data) {
                    if (data && data.success) {
                        $('#addPointModal').modal('hide');
                        viewBasePoint(departId);
                    } else {
                        $.Showmsg(data.msg);
                        $("#btnSave").removeAttr("disabled");
                    }
                },
                error: function () {
                    $("#btnSave").removeAttr("disabled");
                }
            });
            return false;
        }
    });

    //清空新增检测点模态框输入框
    $('#addPointModal').on('hidden.bs.modal', function () {
        $("#btnSave").removeAttr("disabled");
        $("#file-list-" + uploaderobj.configs.id).html('');
        $("#customizeSignature").addClass("cs-hide");
        addPointValidform.resetForm();
        addPointValidform.resetStatus();
    });

    //修改电子章配置
    $(document).on("change", "input[name=signatureType]", function (e) {
        if ($("input[name=signatureType]:checked").val() == 1) {//自定义电子章
            $("#customizeSignature").removeClass("cs-hide");
        } else {
            $("#customizeSignature").addClass("cs-hide");
        }
    });

    //打开新增、编辑检查点模态框
    function addPoint(id) {
        $("input[name=id]").val("");
        if (id) {
            $(".show_sorting").removeClass("hide");//显示排序
            $("#addPointModal .modal-title").text("编辑检测室");
            $("#principal").show();
            $.ajax({
                type: "POST",
                url: '${webRoot}' + "/detect/basePoint/queryById.do",
                data: {
                    "id": id
                },
                dataType: "json",
                success: function (data) {
                    if (data && data.success) {
                        let obj = data.obj;
                        if (obj) {
                            if (obj.depart) {
                                $('#addPointForm').find("input[name='departId']").val(obj.depart.id);
                                $('#addPointForm').find("input[name='departName']").val(obj.depart.departName);
                            }
                            if (obj.baseBean) {
                                $('#addPointForm').find("input[name='id']").val(obj.baseBean.id);
                                $('#addPointForm').find("input[name='pointName']").val(obj.baseBean.pointName);
                                if (obj.baseBean.pointType == "0" && obj.baseBean.regulatoryId != "") {//企业快检室，特殊处理
                                    $('#addPointForm').find("select[name='pointType']").val("2");
                                } else {
                                    $('#addPointForm').find("select[name='pointType']").val(obj.baseBean.pointType);
                                }

                                $('#addPointForm').find("input[name='address']").val(obj.baseBean.address);
                                $('#addPointForm').find("input[name='phone']").val(obj.baseBean.phone);
                                $('#addPointForm').find("input[name='licensePlate']").val(obj.baseBean.licensePlate);
                                $('#addPointForm').find("input[name='imei']").val(obj.baseBean.imei);
                                $('#addPointForm').find("textarea[name='remark']").val(obj.baseBean.remark);
                                $('#addPointForm').find("input[name='sorting']").val(obj.baseBean.sorting);
                                if (obj.baseBean.sampleDelivery == 1) {
                                    $('#addPointForm').find("input[name='sampleDelivery']:eq(1)").prop("checked", true);
                                } else {
                                    $('#addPointForm').find("input[name='sampleDelivery']:eq(0)").prop("checked", true);
                                }
                                $('#addPointForm').find("input[name='signatureType']:eq(" + obj.baseBean.signatureType + ")").prop("checked", true);
                                if (obj.baseBean.signatureType == 1) {
                                    $("#customizeSignature").removeClass("cs-hide");
                                }
                                $('#pointTypeId').val(obj.baseBean.pointTypeId);
                                changeSelOrg(obj.baseBean.regulatoryId);
                                if (obj.baseBean.signatureFile) {
                                    $("#file-list-" + uploaderobj.configs.id).html('');
                                    editFileHtmlList(obj.baseBean.signatureFile, uploaderobj, '${webRoot}');
                                }
                            }
                        }
                    }
                }
            });
        } else {
            $(".show_sorting").addClass("hide");//隐藏排序
            $("#addPointModal .modal-title").text("新增检测室");
            $("#principal").hide();
            //设置默认选择的机构
            $('#addPointForm').find("input[name='departId']").val(departId);
            $('#addPointForm').find("input[name='departName']").val(departName);
            $("input[name=sorting]").val("-1");
        }
        $('#addPointModal').modal('toggle');
    }

    //选择企业检测点时需关联相关的被检单位
    function changeSelOrg(rid) {
        let pointType = $("select[name=pointType]").val();
        if (pointType == 0) {
            $("input[name=pointTypeId]").val("1");
        }
        if (pointType == 2) {		//只有企业检测室才有被检单位
            $("input[name=pointTypeId]").val("2");
            $("#regTR").attr("style", "display:''");
            $("#regulatoryId").removeAttr("ignore");
            $.ajax({
                url: '${webRoot}/regulatory/regulatoryObject/queryRegByDepartId',
                data: {departId: $('#addPointModal').find("input[name='departId']").val()},
                success: function (data) {
                    var regs = data.obj;
                    $("#regulatoryId").empty();
                    var html = "<option value=''>---请选择被检单位---</option>";
                    for (var i = 0; i < regs.length; i++) {
                        var reg = regs[i];
                        html += "<option value='" + reg.id + "'>" + reg.regName + "</option>";
                    }
                    $("#regulatoryId").html(html);
                    if (rid) {//编辑检测点-选中被检单位
                        $('#regulatoryId').val(rid);
                    }
                }
            });
        } else {
            $("#regTR").attr("style", "display:none");
            $('#regulatoryId').val("");
            $("#regulatoryId").attr("ignore", "ignore");
        }
    }

    function editFileHtmlList(files, uploader, root) {
        var html = '';
        var fileName = files;
        var showName = fileName;
        if (fileName.length > 14) {
            showName = fileName.substring(0, 14) + "...";
        }
        html += '<div class="upload-files clearfix">';
        html += '<span class="file-name-span"  title="' + fileName + '">' + showName + '</span>';
        html += '<a class="icon iconfont icon-chushaixuanxiang shanchu"  data-fileid="files_0" data-uploadid="#' + uploader.configs.id + '" onclick="removeFile(this)" title="删除"></a>';
        html += '</div>';
        $("#file-list-" + uploader.configs.id).append(html);
    }
</script>
