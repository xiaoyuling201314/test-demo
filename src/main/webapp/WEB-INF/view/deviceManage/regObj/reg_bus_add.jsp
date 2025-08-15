<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/WEB-INF/view/deviceManage/resource.jsp" %>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>被检单位</title>
    <meta name="description" content="">
    <meta name="author" content="食安科技">
    <meta http-equiv="X-UA-Compatible" content="IE=Edge">
    <link rel="stylesheet" type="text/css" href="${webRoot}/device/iconfont/iconfont.css"/>
    <link rel="stylesheet" type="text/css" href="${webRoot}/device/css/bootstrap.css"/>
    <link rel="stylesheet" type="text/css" href="${webRoot}/device/css/instrument.css"/>
</head>

<body>
<div class="top-bar is-flex">
    <div class="top-back text-left"><a href="javascript:window.history.back();"><img src="${webRoot}/device/img/new.png" alt="">
    </a><span id="pageTitle"></span>
    </div>
    <div class="top-btn text-right">
    </div>
</div>
<div class="content">
    <form id="busForm" autocomplete="off">
        <input type="hidden" name="id">
        <input type="hidden" name="regId">
        <input type="hidden" name="creditRating" value="1"><!--信用等级,默认值A-->
        <input type="hidden" name="monitoringLevel" value="1"><!--监控级别,默认值安全-->
        <input type="hidden" name="userToken" value="${userToken}">
        <div class="form-group">
            <div class="group-row">
                <label>
                    <span class="move-name"><i class="text-danger">*</i>摊位编号：</span>
                    <input type="text" name="opeShopCode" maxlength="50">
                </label>
            </div>
            <div class="group-row">
                <label>
                    <span class="move-name"><i class="text-danger">*</i>摊位名称：</span>
                    <input type="text" name="opeShopName" maxlength="100">
                </label>
            </div>
            <div class="group-row">
                <label>
                    <span class="move-name">经营者：</span>
                    <input type="text" name="opeName" maxlength="20">
                </label>
            </div>
            <div class="group-row">
                <label>
                    <span class="move-name">统一社会信用代码：</span>
                    <input type="text" name="creditCode" maxlength="100">
                </label>
            </div>
            <div class="group-row">
                <label>
                    <span class="move-name">经营者身份证：</span>
                    <input type="text" name="opeIdcard" maxlength="100">
                </label>
            </div>
            <div class="group-row">
                <label>
                    <span class="move-name">联系人：</span>
                    <input type="text" name="contacts" maxlength="12">
                </label>
            </div>
            <div class="group-row">
                <label>
                    <span class="move-name">联系方式：</span>
                    <input type="text" name="opePhone" maxlength="50">
                </label>
            </div>
            <div class="group-row">
                <label>
                    <span class="move-name">经营范围：</span>
                    <input type="text" name="businessCope" maxlength="300">
                </label>
            </div>
            <div class="group-row">
                <label>
                    <span class="move-name">备注：</span>
                    <input type="text" name="remark" maxlength="200">
                </label>
            </div>
            <div class="group-row group-row2">
                <label>
                    <span class="move-name">类型：</span>
                    <select name="type">
                        <option value="0">经营户</option>
                        <option value="1">车辆</option>
                    </select>
                </label>
            </div>
            <div class="group-row group-row2">
                <label>
                    <span class="move-name">状态：</span>
                    <select name="checked">
                        <option value="1">已审核</option>
                        <option value="0">未审核</option>
                    </select>
                </label>
            </div>
            <div class="btn-list">
                <a href="javascript:window.history.back();" class="btn">取消</a>
                <a class="btn" id="btnSave" onclick="submitForm();">确定</a>
            </div>
        </div>
    </form>
</div>
<%@include file="/WEB-INF/view/deviceManage/showMessage.jsp" %>
<script type="text/javascript" src="${webRoot}/device/js/jquery.min1.11.3.js"></script>
<script type="text/javascript" src="${webRoot}/device/js/bootstrap.min.js"></script>
<!--用于表单回显-->
<script src="${webRoot}/device/plug-in/easyui/jquery.easyui.min.js"></script>
<script type="text/javascript">
    var busId = '${id}';
    var regId ='${regId}';
    $("input[name=regId]").val(regId);
    var regName = '${regName}';
    $("#pageTitle").html((busId ? '编辑' : '新增') + '经营户（' + regName + '）');
    var $btnSave = $("#btnSave");
    $(function () {
        if (busId) {
            queryById();
        }
    });


    //============================表单的校验和提交_start========================
    //提交表单
    function submitForm() {
        var opeShopCode=$("#busForm input[name=opeShopCode]").val().trim();
        var opeShopName=$("#busForm input[name=opeShopName]").val().trim();
        if(opeShopName==''){
            showMsg("请填写摊位编号");
        }else if(opeShopName==''){
            showMsg("请填写摊位名称");
        }else {
            $.ajax({
                type: "POST",
                url: "${webRoot}/iRegulatory/Object/saveOrUpdateBus",
                data: $('#busForm').serialize(),
                dataType: "json",
                success: function (data) {
                    if (data.success) {
                        showMsg({message: data.msg, type: "success"});
                        setTimeout(function () {
                            window.history.back();
                        }, 600);
                    } else {
                        showMsg(data.msg)
                    }
                }
            });
        }
    }

    //============================表单的校验和提交_end========================

    //根据ID查询数据回显
    function queryById() {
        $.ajax({
            type: "GET",
            url: '${webRoot}/iRegulatory/Object/queryBusById?userToken=${userToken}&id='+busId,
            dataType: "json",
            success:function (data) {
                if (data.success) {
                    $('#busForm').form('load', data.obj);
                } else {
                    showMsg(data.msg)
                }
            }
        });
    }

    //查询单位类型
    function getRegTypes() {
        $.ajax({
            type: "GET",
            url: "${webRoot}/iRegulatory/Object/regTypes",
            async: false,
            data: {"userToken":"${userToken}"},
            dataType: "json",
            success: function (data) {
                $("#regTypes").html("");
                if (data.success) {
                    var html = '<option value="">全部</option>';
                    for (var i = 0; i < data.obj.length; i++) {
                        html += '<option value="'+data.obj[i].id+'">'+data.obj[i].regType+'</option>'
                    }
                    $("#regTypes").append(html);
                } else {
                    showMsg(data.msg)
                }
            },error: function (data) {
                showMsg(JSON.stringify(data))
            }
        });
    }

</script>
</body>
</html>
