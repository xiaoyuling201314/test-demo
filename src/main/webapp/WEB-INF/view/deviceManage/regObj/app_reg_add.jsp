<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/WEB-INF/view/deviceManage/resource.jsp" %>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>被检单位维护</title>
    <meta name="description" content="">
    <meta name="author" content="食安科技">
    <meta name="viewport" content="initial-scale=1, maximum-scale=1, user-scalable=no">
    <meta name="format-detection" content="telephone=no">
    <link rel="stylesheet" type="text/css" href="${webRoot}/css/iconfont/iconfont.css"/>
    <link rel="stylesheet" href="${webRoot}/plug-in/weui/lib/weui.min.css">
    <link rel="stylesheet" href="${webRoot}/plug-in/weui/css/jquery-weui.css">
    <style>
        * {
            padding: 0;
            margin: 0;
        }

        a {
            text-decoration: none;
        }

        .btn {
            display: inline-block;
            padding: 6px 12px;
            margin-bottom: 0;
            font-size: 14px;
            font-weight: normal;
            line-height: 1.42857143;
            text-align: center;
            white-space: nowrap;
            vertical-align: middle;
            -ms-touch-action: manipulation;
            touch-action: manipulation;
            cursor: pointer;
            -webkit-user-select: none;
            -moz-user-select: none;
            -ms-user-select: none;
            user-select: none;
            background-image: none;
            border: 1px solid transparent;
            border-radius: 4px;
        }

        .ui-header h4 a:first-child,
        .ui-header h4,
        .ui-header .iconfont {
            color: #fff;
        }

        .ui-header h4 {
            background: #0095ff;
        }

        .ui-header h4 {
            /* background: #fff; */
            height: 50px;
            line-height: 50px;
            text-align: center;
            color: #000;
            padding: 0;
            margin: 0;
            font-size: 18px;
            position: relative;
            font-weight: normal;
        }

        .ui-header h4 a:first-child {
            position: absolute;
            /* color: #fff; */
            left: 10px;
            font-size: 20px;
            width: 36px;
            /* z-index: 1; */
            color: #000;
        }

        .ui-header h4 a:first-child,
        .ui-header h4,
        .ui-header .iconfont {
            color: #fff;
        }



        .cs-table-form {
            display: table;
            width: calc(100% - 20px);
            margin: 10px auto;
            background-color: #fff;
            border-radius: 5px;
            border: 1px solid #ddd;
            box-shadow: 0 0 4px #ccc;
            padding-top: 5px;
        }

        .zz-tp {
            padding: 0;
            margin-bottom: 5px;
        }

        .cs-table-row {
            border-bottom: 1px solid #f1f1f1;
        }

        .cs-table-row {
            display: flex;
            padding: 2px;
            border-bottom: 1px solid #eee;
        }

        .zz-tp .cs-table-cell {
            padding-top: 1px;
            vertical-align: middle;
        }

        .cs-first-name {
            text-align: right;
            padding-right: 0px;
            color: #000;
            width: 110px;
            font-size: 15px;
        }

        .cs-table-cell,
        .cs-table-cell2 {
            height: 38px;
            line-height: 38px;
            font-size: 14px;
            border-bottom: 0px solid #f1f1f1;
            padding-top: 5px;
            overflow: hidden;
            padding: 0 5px;
        }

        .cs-table-cell {
            position: relative;
        }

        .cs-table-row .cs-table-cell:nth-child(2) {
            flex-grow: 1;
        }

        .zz-tp .cs-table-cell {
            padding-top: 1px;
            vertical-align: middle;
        }

        .company-select {
            position: relative;
        }

        .cs-table-cell input[type="text"],
        .cs-table-cell input[type="number"],
        .cs-table-cell input[type="password"] {
            line-height: 30px;
            height: 30px;
            border: 0;
            outline: 0;
            width: 100%;
        }

        .sure-btns {
            text-align: center;
            margin: 20px 0;
        }

        .sure-btns>a:first-child {
            margin-right: 5px;
        }

        .sure-btns .btn {
            font-size: 14px;
            border-radius: 100px;
            line-height: 22px;
        }

        .sure-btns a,
        .sure-btns2 a {
            width: 50%;
        }

        .btn-default {
            border-color: #ddd;
        }

        .btn-default {
            border-color: #ddd;
        }

        .btn {
            font-size: 12px;
            border-radius: 100px;
            line-height: 16px;
        }

        .btn {
            font-size: 12px;
        }

        .btn {
            border-radius: 2px;
        }

        .btn-default {
            color: #333;
            background-color: #fff;
            border-color: #ccc;
        }

        .sure-btns .btn {
            font-size: 14px;
            border-radius: 6px;
            line-height: 22px;
        }

        .sure-btns a,
        .sure-btns2 a {
            width: 50%;
        }

        .btn {
            font-size: 12px;
            border-radius: 100px;
            line-height: 16px;
        }

        .btn {
            font-size: 12px;
        }

        .btn-primary {
            color: #fff;
            background-color: #608df4;
            border-color: #5179cf;
        }

        .text-danger {
            color: #fd7b7c;
        }

        .weui-textarea {
            display: block;
            border: 0;
            resize: none;
            width: 100%;
            color: inherit;
            font-size: 1em;
            line-height: inherit;
            outline: 0;
        }
    </style>
</head>

<body class="body-bg">
<div class="all-content">
    <div class="ui-header">
        <h4>
<%--            <a href="javascript:window.history.back();" class="icon iconfont icon-zuo miss-btn2"></a>--%>
            <span id="pageTitle">新增</span>被检单位
        </h4>
    </div>
    <div class="cs-table-form zz-tp">
        <form id="addRegForm" autocomplete="off">
            <input type="hidden" name="id">
            <input type="hidden" name="userToken" value="${userToken}">
            <div class="cs-table-row">
                <div class="cs-table-cell cs-first-name">
                    <b class="text-danger">*</b> 被检单位：
                </div>
                <div class="cs-table-cell company-select">
                    <input class="show-one-input" type="text" name="regName" autocomplete="off" placeholder="请输入被检单位名称" value="" />
                </div>
            </div>
            <div class="cs-table-row">
                <div class="cs-table-cell cs-first-name">
                    <b class="text-danger">*</b> 单位类型：
                </div>
                <div class="cs-table-cell company-select">
                    <input type="hidden" name="regType">
                    <input class="show-one-input" type="text" id="picker2" placeholder="请选择单位类型" value="" />
                </div>
            </div>
            <div class="cs-table-row">
                <div class="cs-table-cell cs-first-name">
                    统一信用代码：
                </div>
                <div class="cs-table-cell company-select">
                    <input class="show-one-input" type="text" name="creditCode" autocomplete="off" placeholder="请输入统一信用代码" value="" />
                </div>
            </div>
            <div class="cs-table-row">
                <div class="cs-table-cell cs-first-name">
                    法人名称：
                </div>
                <div class="cs-table-cell company-select">
                    <input class="show-one-input" type="text" name="legalPerson" autocomplete="off" placeholder="请输入法人名称" value="" />
                </div>
            </div>
            <div class="cs-table-row">
                <div class="cs-table-cell cs-first-name">
                    法人身份证：
                </div>
                <div class="cs-table-cell company-select">
                    <input class="show-one-input" type="text" name="linkIdcard" autocomplete="off" placeholder="请输入法人身份证" value="" />
                </div>
            </div>
            <div class="cs-table-row">
                <div class="cs-table-cell cs-first-name">
                    联系人名称：
                </div>
                <div class="cs-table-cell company-select">
                    <input class="show-one-input" type="text" name="linkUser" autocomplete="off" placeholder="请输入联系人名称" value="" />
                </div>
            </div>
            <div class="cs-table-row">
                <div class="cs-table-cell cs-first-name">
                    联系人电话：
                </div>
                <div class="cs-table-cell company-select">
                    <input class="show-one-input" type="text" name="linkPhone" autocomplete="off" placeholder="请输入联系人电话" value="" />
                </div>
            </div>
            <div class="cs-table-row">
                <div class="cs-table-cell cs-first-name">
                    单位地址：
                </div>
                <div class="cs-table-cell company-select">
                    <input class="show-one-input" type="text" name="regAddress" autocomplete="off" placeholder="请输入单位地址" value="" />
                </div>
            </div>
            <div class="cs-table-row">
                <div class="cs-table-cell cs-first-name">
                    <b class="text-danger">*</b> 状态：
                </div>
                <div class="cs-table-cell company-select">
                    <input type="hidden" name="checked" value="1">
                    <input class="" type="text" id="picker1" value="已审核" placeholder="请选择审核状态">
                </div>
            </div>
            <div class="btn-div sure-btns">
<%--                <a href="${webRoot}/iRegulatory/Object/regListApp?userToken=${userToken}" type="button" class=" btn btn-default ok-piao" style="width: 30%">返回</a>--%>
                <a href="javascript:window.history.back();" type="button" class=" btn btn-default ok-piao" style="width: 30%">返回</a>
                <button id="subBtn" type="button" class="btn btn-primary ok-piao" style="width: 30%" onclick="submitForm();">保存</button>
            </div>
        </form>
    </div>
</div>

<script type="text/javascript" src="${webRoot}/device/js/jquery.min1.11.3.js"></script>
<script type="text/javascript" src="${webRoot}/plug-in/weui/js/jquery-weui.js"></script>
<!--用于表单回显-->
<script src="${webRoot}/device/plug-in/easyui/jquery.easyui.min.js"></script>
<script type="text/javascript">

    var regId ='${id}';

    //监管对象类型(数组)
    var regTypes;
    //监管对象类型选项
    var p2Values = [];

    $(function () {
        $("#pageTitle").text(regId ? '编辑' : '新增');

        //查询单位类型
        getRegTypes();
        if (regId) {
            queryById();
        } else {
            initPicker();
        }
    });

    //============================表单的提交_start========================
    function submitForm(){
        var regName0=$("#addRegForm input[name=regName]").val().trim();
        // var regType0=$("#addRegForm input[name=regType]").val().trim();
        // var checked0=$("#addRegForm input[name=checked]").val().trim();
        if(!regName0){
            $.toast("请填写被检单位", "cancel");
        // }else if(!regType0){
        //     $.toast("请选择单位类型", "cancel");
        // }else if(!checked0){
        //     $.toast("请选择状态", "cancel");
        }else{
            $("#subBtn").attr("disabled", "disabled");
            $.ajax({
                type: "POST",
                url: "${webRoot}/iRegulatory/Object/saveOrUpdate",
                data: $('#addRegForm').serialize(),
                dataType: "json",
                success: function (data) {
                    if (data.success) {
                        $.toast(data.msg);
                        setTimeout(function () {
                            <%--window.location.href="${webRoot}/iRegulatory/Object/regListApp?userToken=${userToken}";--%>
                            window.history.back();
                        }, 600);
                    } else {
                        $.toast(data.msg, "cancel");
                    }
                },
                complete: function(){
                    $('#subBtn').removeAttr('disabled');
                }
            });
        }
    }

    //============================表单的校验和提交_end========================

    //根据ID查询数据回显
    function queryById() {
        $.ajax({
            type: "GET",
            url: '${webRoot}/iRegulatory/Object/queryById?userToken=${userToken}&id='+regId,
            async: false,
            dataType: "json",
            success:function (data) {
                if (data.success) {
                    //回写内容
                    $('#addRegForm').form('load', data.obj);

                    //选择类型
                    for (var i = 0; i < regTypes.length; i++){
                        if (regTypes[i].id == data.obj.regType) {
                            $("#picker2").val(regTypes[i].regType);
                            break;
                        }
                    }

                    //审核状态
                    if (data.obj.checked) {
                        $("#picker1").val("已审核");
                    } else {
                        $("#picker1").val("未审核");
                    }
                } else {
                    $.toast(data.msg, "cancel");
                }
            }
        });
        initPicker();
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
                if (data.success) {
                    regTypes = data.obj;

                    for (var i = 0; i < data.obj.length; i++) {
                        if (i==0) {
                            $("#picker2").val(data.obj[i].regType);
                            $("#addRegForm input[name=regType]").val(data.obj[i].id);
                        }
                        p2Values.push(data.obj[i].regType);
                    }
                } else {
                    $.toast(data.msg, "cancel");
                }
            },
            error: function (data) {
                $.toast(JSON.stringify(data), "cancel");
            }
        });
    }

    //初始化选项，先设置input的value，最后初始化选项，避免编辑时默认选中第一项
    function initPicker(){
        //初始化状态选项
        $("#picker1").picker({
            title: "请选择状态",
            cols: [{
                textAlign: 'center',
                values: [
                    '已审核', '未审核'
                ]
            }],
            onClose: function (res) {
                if ("未审核" == res.value[0]) {
                    $("#addRegForm input[name=checked]").val(0);
                } else {
                    $("#addRegForm input[name=checked]").val(1);
                }
            }
        });

        //初始化类型选项
        $("#picker2").picker({
            title: "请选择监管对象类型",
            cols: [{
                textAlign: 'center',
                values: p2Values
            }],
            onClose: function (res) {
                for (var i = 0; i < regTypes.length; i++){
                    if (regTypes[i].regType == res.value[0]) {
                        $("#addRegForm input[name=regType]").val(regTypes[i].id);
                        break;
                    }
                }
            }
        });
    }

</script>
</body>
</html>
