<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/WEB-INF/view/deviceManage/resource.jsp" %>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>被检单位</title>
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
<%--                <a href="javascript:window.history.back();" class="icon iconfont icon-zuo miss-btn2"></a>--%>
                <span id="pageTitle"></span>经营户
            </h4>
        </div>
        <form id="busForm" autocomplete="off">
            <input type="hidden" name="id">
            <input type="hidden" name="regId" value="${regId}">
            <input type="hidden" name="creditRating" value="1"><!--信用等级,默认值A-->
            <input type="hidden" name="monitoringLevel" value="1"><!--监控级别,默认值安全-->
            <input type="hidden" name="userToken" value="${userToken}">
            <div class="cs-table-form zz-tp">
                <div class="cs-table-row">
                    <div class="cs-table-cell cs-first-name">
                        被检单位：
                    </div>
                    <div class="cs-table-cell company-select">
                        <input class="show-one-input" type="text" readonly="readonly" value="${regName}" />
                    </div>
                </div>
                <div class="cs-table-row">
                    <div class="cs-table-cell cs-first-name">
                        <b class="text-danger">*</b> 摊位编号：
                    </div>
                    <div class="cs-table-cell company-select">
                        <input class="show-one-input" type="text" name="opeShopCode" autocomplete="off" placeholder="" value="" />
                    </div>
                </div>
                <div class="cs-table-row">
                    <div class="cs-table-cell cs-first-name">
                        摊位名称：
                    </div>
                    <div class="cs-table-cell company-select">
                        <input class="show-one-input" type="text" name="opeShopName" autocomplete="off" placeholder="" value="" />
                    </div>
                </div>
                <div class="cs-table-row">
                    <div class="cs-table-cell cs-first-name">
                        经营者：
                    </div>
                    <div class="cs-table-cell company-select">
                        <input class="show-one-input" type="text" name="opeName" autocomplete="off" placeholder="" value="" />
                    </div>
                </div>
                <div class="cs-table-row">
                    <div class="cs-table-cell cs-first-name">
                        联系方式：
                    </div>
                    <div class="cs-table-cell company-select">
                        <input class="show-one-input" type="text" name="opePhone" autocomplete="off" placeholder="" value="" />
                    </div>
                </div>
                <div class="cs-table-row">
                    <div class="cs-table-cell cs-first-name">
                        经营者身份证：
                    </div>
                    <div class="cs-table-cell company-select">
                        <input class="show-one-input" type="text" name="opeIdcard" autocomplete="off" placeholder="" value="" />
                    </div>
                </div>
                <div class="cs-table-row">
                    <div class="cs-table-cell cs-first-name">
                        统一信用代码：
                    </div>
                    <div class="cs-table-cell company-select">
                        <input class="show-one-input" type="text" name="creditCode" autocomplete="off" placeholder="" value="" />
                    </div>
                </div>
                <div class="cs-table-row">
                    <div class="cs-table-cell cs-first-name">
                        经营范围：
                    </div>
                    <div class="cs-table-cell company-select">
                        <input class="show-one-input" type="text" name="businessCope" autocomplete="off" placeholder="" value="" />
                    </div>
                </div>
                <div class="cs-table-row">
                    <div class="cs-table-cell cs-first-name">
                        备注：
                    </div>
                    <div class="cs-table-cell company-select">
                        <textarea name="remark" autocomplete="off" cols="30" rows="10" style="width: 100%;height: 36px;border: 0;"></textarea>
                    </div>
                </div>
                <div class="cs-table-row">
                    <div class="cs-table-cell cs-first-name">
                        <b class="text-danger">*</b> 类型：
                    </div>
                    <div class="cs-table-cell company-select">
                        <input type="hidden" name="type" value="0"/>
                        <input class="show-one-input" type="text" id="picker2" placeholder="" value="经营户" />
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
<%--                    <a href="${webRoot}/iRegulatory/Object/busListApp?regId=${regId}&regName=${regName}&userToken=${userToken}" type="button" class=" btn btn-default ok-piao" style="width: 30%">返回</a>--%>
                    <a href="javascript:window.history.back();" type="button" class=" btn btn-default ok-piao" style="width: 30%">返回</a>
                    <button id="subBtn" type="button" class="btn btn-primary ok-piao" style="width: 30%" onclick="submitForm();">保存</button>
                </div>
            </div>
        </form>
    </div>

    <script type="text/javascript" src="${webRoot}/device/js/jquery.min1.11.3.js"></script>
    <script type="text/javascript" src="${webRoot}/plug-in/weui/js/jquery-weui.js"></script>

    <!--用于表单回显-->
    <script src="${webRoot}/device/plug-in/easyui/jquery.easyui.min.js"></script>
<script type="text/javascript">
    var busId = '${id}';
    var regId ='${regId}';
    var regName = '${regName}';

    $(function () {
        $("#pageTitle").text(busId ? '编辑' : '新增');

        if (busId) {
            queryById();
        } else {
            initPicker()
        }
    });


    //============================表单的校验和提交_start========================
    //提交表单
    function submitForm() {
        var opeShopCode=$("#busForm input[name=opeShopCode]").val().trim();
        if(!opeShopCode){
            $.toast("请填写摊位编号", "cancel");
        }else {
            $.ajax({
                type: "POST",
                url: "${webRoot}/iRegulatory/Object/saveOrUpdateBus",
                data: $('#busForm').serialize(),
                dataType: "json",
                success: function (data) {
                    if (data.success) {
                        $.toast(data.msg);

                        setTimeout(function () {
                            <%--window.location.href="${webRoot}/iRegulatory/Object/busListApp?regId=${regId}&regName="+encodeURI('${regName}')+"&userToken=${userToken}";--%>
                            window.history.back();
                        }, 600);
                    } else {
                        $.toast(data.msg, "cancel");
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
            async: false,
            dataType: "json",
            success:function (data) {
                if (data.success) {
                    $('#busForm').form('load', data.obj);

                    //类型
                    if (data.obj.type == 1) {
                        $("#picker2").val("车辆");
                    } else {
                        $("#picker2").val("经营户");
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

    //初始化选项，先设置input的value，最后初始化选项，避免编辑时默认选中第一项
    function initPicker(){
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
                    $("#busForm input[name=checked]").val(0);
                } else {
                    $("#busForm input[name=checked]").val(1);
                }
            }
        });
        $("#picker2").picker({
            title: "请选择状态",
            cols: [{
                textAlign: 'center',
                values: [
                    '经营户',
                    '车辆',
                ]
            }],
            onClose: function (res) {
                if ("车辆" == res.value[0]) {
                    $("#busForm input[name=type]").val(1);
                } else {
                    $("#busForm input[name=type]").val(0);
                }
            }
        });
    }

</script>
</body>
</html>
