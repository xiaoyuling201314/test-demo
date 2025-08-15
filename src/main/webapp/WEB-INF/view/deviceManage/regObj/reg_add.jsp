<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/WEB-INF/view/deviceManage/resource.jsp" %>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>被检单位维护</title>
    <meta name="description" content="">
    <meta name="author" content="食安科技">
    <meta http-equiv="X-UA-Compatible" content="IE=Edge">
    <link rel="stylesheet" type="text/css" href="${webRoot}/device/iconfont/iconfont.css"/>
    <link rel="stylesheet" type="text/css" href="${webRoot}/device/css/bootstrap.css"/>
    <link rel="stylesheet" type="text/css" href="${webRoot}/device/css/instrument.css"/>
</head>

<body>
<div class="top-bar is-flex">
    <div class="top-back text-left" >
        <a href="javascript:window.history.back();"><img src="${webRoot}/device/img/new.png" alt=""></a>
        <span id="pageTitle">新增</span>被检单位
    </div>
    <div class="top-btn text-right">
    </div>
</div>
<div class="content">
    <form id="regForm" autocomplete="off">
        <input type="hidden" name="id">
        <input type="hidden" name="userToken" value="${userToken}">
        <div class="form-group">
            <div class="group-row">
                <label>
                    <span class="move-name"><i class="text-danger">*</i>被检单位：</span>
                    <input type="text" name="regName" maxlength="100">
                </label>
            </div>
            <div class="group-row group-row2">
                <label>
                    <span class="move-name"><i class="text-danger">*</i>单位类型：</span>
                    <select id="regTypes" name="regType">
                    </select>
                </label>
            </div>
            <div class="group-row">
                <label>
                    <span class="move-name">法人名称：</span>
                    <input type="text" name="legalPerson" maxlength="12">
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
                    <span class="move-name">联系人名称：</span>
                    <input type="text" name="linkUser" maxlength="20">
                </label>
            </div>
            <div class="group-row">
                <label>
                    <span class="move-name">联系人电话：</span>
                    <input type="text" name="linkPhone" maxlength="20">
                </label>
            </div>
            <div class="group-row">
                <label>
                    <span class="move-name">联系人身份证：</span>
                    <input type="text" name="linkIdcard" maxlength="20">
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
    var regId ='${id}';
    var $btnSave = $("#btnSave");
    $("#pageTitle").text(regId ? '编辑' : '新增');
    $(function () {
        //查询单位类型
        getRegTypes();
        if (regId) {
            queryById();
        }
    });

    //============================表单的提交_start========================
    function submitForm() {
        var regName=$("#regForm input[name=regName]").val().trim();
        if(regName==''){
            showMsg("请填写被检单位");
        }else if(checkRegName(regName)==false){
            showMsg("该单位已被注册");
        }else{
            $.ajax({
                type: "POST",
                url: "${webRoot}/iRegulatory/Object/saveOrUpdate",
                data: $('#regForm').serialize(),
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
    function checkRegName(regName){
        var isOk = false;
        $.ajax({
            type: "GET",
            url: '${webRoot}/iRegulatory/Object/reqName',
            data: {name: regName, id: regId, type: $("#regTypes").val(), "userToken":"${userToken}"},
            async: false,
            dataType: "json",
            success: function (data) {
                isOk = data;
            }
        });
    }
    //============================表单的校验和提交_end========================

    //根据ID查询数据回显
    function queryById() {
        $.ajax({
            type: "GET",
            url: '${webRoot}/iRegulatory/Object/queryById?userToken=${userToken}&id='+regId,
            dataType: "json",
            success:function (data) {
                if (data.success) {
                    $('#regForm').form('load', data.obj);
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
