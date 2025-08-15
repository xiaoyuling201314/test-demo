<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@include file="/WEB-INF/view/common/resource.jsp" %>
<%--<link rel="stylesheet" href="http://code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css" />
&lt;%&ndash;<script src="http://code.jquery.com/jquery-1.9.1.js"></script>&ndash;%&gt;
<script src="http://code.jquery.com/ui/1.11.4/jquery-ui.js"></script>--%>

<html>
<head>
    <title>快检服务云平台</title>
    <style>
        .input-style input[type="radio"], .input-style input[type="checkbox"] {
            float: left;
            margin-top: 8px;
            margin-right: 3px;
        }

        .wenzi {
            overflow: hidden;
            white-space: nowrap;
            text-overflow: ellipsis;
            width: 100%;
            display: block;
        }

        .tooltip {
            background: rgba(0, 0, 0, 0);
            border: 0;
        }

        .tooltip-inner {
            background: #ffefcb;
            color: #000;
        }

        .tooltip.top .tooltip-arrow {

            border-top-color: #ffefcb;
        }

        .tooltip.in {
            opacity: 1;
        }
    </style>
</head>
<body style="height: 100%;">
<%--解决layer不居中加 style="height:100%;"--%>
<div class="cs-col-lg clearfix">
    <ol class="cs-breadcrumb">
        <li class="cs-fl"><img src="${webRoot}/img/set.png" alt=""/> <a
                href="javascript:">客户管理</a></li>
        <li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
        <li class="cs-b-active cs-fl">送检用户</li>
    </ol>
    <form>
        <div class="cs-input-style cs-fl" style="margin: 3px 0 0 30px;">
            用户类型:
            <select class="check-date cs-selcet-style" id="userType" onchange="loadTypeChange(this.value)">
                <option value="-1">全部</option>
                <option value="0" selected>送检用户</option>
                <option value="3">上门取样</option>
                <option value="1">抽样人员</option>
<%--                <option value="2">监管方</option>--%>
<%--                <option value="4">财务统计</option>--%>
            </select>
        </div>
        <div class="cs-search-box cs-fr">
            <div class="cs-search-filter clearfix cs-fl">
                <input class="cs-input-cont cs-fl focusInput" type="text" name="keyWords" placeholder="请输入姓名或手机号"/>
                <input type="button" class="cs-search-btn cs-fl" onclick="datagridUtil.queryByFocus()" href="javascript:;" value="搜索">
                <%--<span class="cs-s-search cs-fl">高级搜索</span>--%>
            </div>
            <div class="clearfix cs-fr" id="showBtn"></div>
        </div>
    </form>
</div>

<div id="dataList1"></div>

<!-- 解除微信绑定模态框 start  -->
<div class="modal fade intro2" id="openid_confirm" tabindex="-1"
     role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog cs-alert-width">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"
                        aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <input type="hidden" name="id">
                <h4 class="modal-title"></h4>
            </div>
            <div class="modal-body cs-alert-height cs-dis-tab">
                <div class="cs-text-algin"></div>
            </div>
            <div class="modal-footer">
                <a class="btn btn-danger btn-ok" onclick="delwx();">确定</a>
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
            </div>
        </div>
    </div>
</div>
<!-- 解除微信绑定模态框 end  -->

<!-- 清除支付密码模态框 start  -->
<div class="modal fade intro2" id="reset_confirm" tabindex="-1"
     role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog cs-alert-width">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"
                        aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <input type="hidden" name="id">
                <h4 class="modal-title"></h4>
            </div>
            <div class="modal-body cs-alert-height cs-dis-tab">
                <div class="cs-text-algin"></div>
            </div>
            <div class="modal-footer"></div>
        </div>
    </div>
</div>

<%--停用模态框--%>
<div class="modal fade intro2" id="confirm-delete3" tabindex="-1"
     role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog cs-alert-width">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"
                        aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title">确认停用</h4>
            </div>
            <div class="modal-body cs-alert-height cs-dis-tab">
                <div class="cs-text-algin">
                    <img src="${webRoot}/img/stop2.png" width="40px"/> <span
                        class="tips stop_conment">确认停用该用户吗？</span>
                </div>
            </div>
            <div class="modal-footer">
                <a class="btn btn-danger btn-ok" onclick="stopOrOpen()">停用</a>
                <button type="button" class="btn btn-" data-dismiss="modal">取消</button>
            </div>
        </div>
    </div>
</div>

<!-- 清除支付密码模态框 end  -->
<%@include file="/WEB-INF/view/common/modalBox.jsp" %>
<%@include file="/WEB-INF/view/common/confirm.jsp" %>
<script type="text/javascript" src="${webRoot}/js/datagridUtil.js"></script>
<script type="text/javascript" src="${webRoot}/plug-in/layer/layer.js"></script>
<script type="text/javascript">
    if (Permission.exist("1464-4") == 1) {
        var html = '<a class="cs-menu-btn" onclick="addOrUpdateUser();"><i class="' + Permission.getPermission("1464-4").functionIcon + '"></i>新增</a>';
        $("#showBtn").prepend(html);
    }
    var jbstate = 1;
    $(function () {
        loadTypeChange(0);
        //$('.js-select2-tags').select2();//select2初始化
        $("input[type=radio][name=userType]").change(function () {
            var value = this.value;
            showOrhide(value)
        });

        $("input[name=type1]").change(function () {
            var selValArr = [];
            $("input[name=type1]:checked").each(function (i, v) {
                selValArr.push(parseInt(v.value));
            });
            if (selValArr && selValArr.length > 0) {
                selValArr.sort();    //排序
                var selVal = "";
                $(selValArr).each(function (i1, v1) {
                    selVal = v1 + selVal;
                });
                showAffiliation(selVal);
            }
        })

    });

    function loadTypeChange(type) {
        var op1 = {
            tableId: "dataList1",
            tableAction: "${webRoot}/inspUnitUser/datagrid_all",
            defaultCondition: [ //加载条件
                {
                    queryCode: "type",
                    queryVal: type
                }],
            parameter: [
                {
                    columnCode: "account",
                    columnName: "用户编号",
                    columnWidth: "7%",
                    show:0
                },
                {
                    columnCode: "phone",
                    columnName: "登录手机",
                    customStyle: 'phone text-left',
                    customElement: "<a title='查看余额流水' class='text-primary cs-link account_id'>?<a>",
                    columnWidth: "9%"
                }, {
                    columnCode: "realName",
                    customStyle: 'user_name',
                    columnName: "用户姓名",
                    columnWidth: "7%"
                }, {
                    columnCode: "companyName",
                    columnName: "单位/个人",
                    columnWidth: "18%",
                    customElement: '<a data-toggle="tooltip" data-placement="top" title="?"  class="wenzi gys">?</a>',
                    customStyle: 'text-left',
                }, {
                    columnCode: "loginCount",
                    columnName: "次数",
                    sortDataType: "int",
                    columnWidth: "60"
                }, {
                    columnCode: "loginTime",
                    columnName: "最近登录",
                    columnWidth: "10%"
                }, {
                    columnCode: "createDate",
                    columnName: "注册时间",
                    queryType: 1,
                    dateFormat: "yyyy-MM-dd",
                    columnWidth: "8%"
                }, {
                    columnCode: "checked",
                    columnName: "状态",
                    customVal: {
                        "0": "<span style='color: red'>停用</span>",
                        "1": "启用"
                    },
                    columnWidth: "4%"
                }, {
                    columnCode: "remark",
                    columnName: "备注",
                    customElement: '<a data-toggle="tooltip" data-placement="top" title="?" class="wenzi">?</a>',
                    columnWidth: "10%",
                    customStyle: 'text-left',
                },{
                    columnCode: "type",
                    columnName: "用户类型",
                    columnWidth: "60px",
                    customVal: {
                        "0": "送检用户",
                        "1": "抽样人员",
                        // "2": "监管方",
                        "3": "上门取样",
                        // "4": "财务统计",
                    }
                }],
            funBtns: [
                { //编辑
                    show: Permission.exist("1464-3"),
                    style: Permission.getPermission("1464-3"),
                    action: function (id) {
                        addOrUpdateUser(id);
                    }
                },
                { //启用停用
                    show: Permission.exist("1464-6"),
                    style: Permission.getPermission("1464-6"),
                },
                { //查看流水
                    show: Permission.exist("1464-5"),
                    style: Permission.getPermission("1464-5"),
                    action: function (id) {
                        showMbIframe("${webRoot}/balanceMgt/flow?isok=&userId="
                            + id);
                    }
                },
                { //清除支付密码
                    show: Permission.exist("1464-2"),
                    style: Permission.getPermission("1464-2"),
                    action: function (id) {
                        jbstate = 1;
                        var currentTr = $("tr[data-rowid='" + id + "']");//拿到所选行的TR对象
                        var phone = currentTr.find(".phone").text();
                        var userName = currentTr.find(".user_name").text();
                        $("#reset_confirm input[name=id]").val(id);
                        $("#reset_confirm .modal-title").text("清除支付密码");
                        $("#reset_confirm .cs-text-algin").html('<img src="${webRoot}/img/stop2.png" width="40px"/><p>用户信息（'
                            + phone + (userName ? "/" + userName : "") + '）</p><span class="tips">确定清除该用户支付密码？</span>');
                        $("#reset_confirm .modal-footer").html(' <a class="btn btn-danger btn-ok" onclick="resetpwd('
                            + phone + ',\'' + userName + '\');">确定</a><button type="button" class="btn btn-default" data-dismiss="modal">取消</button>');
                        $("#reset_confirm").modal('show');
                    }
                },
                { //微信解绑
                    show: Permission.exist("1464-1"),
                    style: Permission.getPermission("1464-1"),
                    action: function (id) {
                        jbstate = 1;
                        var currentTr = $("tr[data-rowid='" + id + "']");//拿到所选行的TR对象
                        var phone = currentTr.find(".phone").text();
                        var userName = currentTr.find(".user_name").text();
                        $("#openid_confirm input[name=id]").val(id);
                        $("#openid_confirm .modal-title").text("解除绑定");
                        $("#openid_confirm .cs-text-algin")
                            .html(
                                '<img src="${webRoot}/img/stop2.png" width="40px"/><p>用户信息（'
                                + phone + (userName ? "/" + userName : "") + '）</p><span class="tips">确定解除该用户微信绑定？</span>');
                        $("#openid_confirm .modal-footer")
                            .html(
                                ' <a class="btn btn-danger btn-ok" onclick="delopenid('
                                + phone + ',\'' + userName + '\');">确定</a><button type="button" class="btn btn-default" data-dismiss="modal">取消</button>');
                        $("#openid_confirm").modal('show');
                    }
                }],
            onload: function () {
                $('[data-toggle="tooltip"]').tooltip();//初始化tip
                var obj = datagridOption["obj"];
                if (obj) {
                    for (var i = 0; i < obj.length; i++) {
                        //隐藏解绑按钮
                        if (obj[i].openId == null || obj[i].openId == "") {
                            $("tr[data-rowid=" + obj[i].id + "]").find(".icon-jiebang").addClass('hide');
                        }
                        //隐藏清除按钮
                        if (obj[i].payPassword == null || obj[i].payPassword == "") {
                            $("tr[data-rowid=" + obj[i].id + "]").find(".icon-qingchu").addClass('hide');
                        }

                        if (obj[i].checked == 1) {//如果状态为未启用那就按钮变灰
                            $("tr[data-rowid=" + obj[i].id + "]").find(".icon-guanbi").removeClass("icon-duigou").addClass("icon iconfont text-del icon-guanbi").attr("title", "停用").closest("span").attr("onclick", "openStopModel(" + obj[i].id + "," + obj[i].checked + ")");
                        } else {
                            $("tr[data-rowid=" + obj[i].id + "]").find(".icon-guanbi").removeClass("icon-duigou text-del ").addClass("icon-duigou").attr("title", "启用").closest("span").attr("onclick", "openStopModel(" + obj[i].id + "," + obj[i].checked + ")");
                        }
                        //给供应商用户添加图标supplier
                       /* if (obj[i].supplier == 1 && obj[i].userType == 1) {//如果为企业类型且企业为供应商就添加图标
                            $("tr[data-rowid=" + obj[i].id + "]").find(".gys").prepend('<i class="icon iconfont icon-gongyingshang" style="margin-right: 4px;color:#9571e9;"></i>');
                        }*/
                    }
                }
            }
        };
        datagridUtil.initOption(op1);
        datagridUtil.query();
    }

    //新增、更新用户
    function addOrUpdateUser(userId) {
        userId ? showMbIframe("${webRoot}/inspUnitUser/saveOrUpdate?id=" + userId) : showMbIframe("${webRoot}/inspUnitUser/saveOrUpdate");
        /*        if (userId) {
         $("#addModal1 .modal-title").text("编辑");
         $("#userForm .account").parent().show();
         $
         .ajax({
         url: '
        {webRoot}/inspUnitUser/queryById',
         method: 'post',
         data: {
         "id": userId
         },
         success: function (data) {
         if (data && data.success) {

         console.log(data.obj);
         $("#userForm input[name='id']").val(
         data.obj.id);
         $("#userForm .account").text(
         data.obj.account);
         $("#userForm input[name='phone']").val(
         data.obj.phone);
         $("#userForm input[name='realName']").val(
         data.obj.realName);
         $("#userForm input[name='password']").val(
         data.obj.password);
         $("#userForm input[name='password0']").val(
         data.obj.password);
         $("#userForm input[name='oldPassword']")
         .val(data.obj.password);
         $(
         "#userForm input[name='identifiedNumber']")
         .val(data.obj.identifiedNumber);
         $("#userForm input[name='departId']").val(
         data.obj.departId);

         $("#userForm input[name='departName']")
         .val(data.obj.departName);

         $("#userForm input[name=password]")
         .removeAttr("datatype");
         $("#userForm input[name=password0]")
         .removeAttr("datatype");
         $("#userForm input[name='userType'][value=" + data.obj.userType + "]").prop("checked", true);
         $("#userForm input[name='checked'][value=" + data.obj.checked + "]").prop("checked", true);
         //$("#userForm select[name='type'][value="+ data.obj.type + "]").prop("checked", true);
         $("select[name='type']").val(data.obj.type);

         //企业与个人的显示隐藏
         showOrhide(data.obj.userType);
         showAffiliation(data.obj.type + "");

         $("select[name=type1] option").each(function (i, v) {
         var t = data.obj.monitoringType + "";
         if (t.indexOf($(this).attr("value")) == -1) {
         $(this).removeAttr("selected");
         } else {
         $(this).attr("selected", "selected");
         }
         });

         $("input[name=type2]:checkbox").each(function (i, v) {
         var t = data.obj.monitoringType + "";

         if (t.indexOf($(this).attr("value")) == -1) {
         $(this).removeAttr("checked");
         } else {
         $(this).attr("checked", "checked");
         }
         });

         //当未企业的时候进行回显
         if (data.obj.userType == 1
         || data.obj.userType == 2) {
         $("input[name=inspectionId]").val(data.obj.inspectionId);
         var inspectionId = data.obj.inspectionId;
         var InspectionUnitsList = eval('
        ${inspectionListObj}');
         for (var i = 0; i < InspectionUnitsList.length; i++) {
         var obj = InspectionUnitsList[i];
         if (inspectionId == obj.id) {
         $("input[name=creditCode]")
         .val(obj.creditCode);
         $("input[name=companyName]")
         .val(obj.companyName);
         }
         }
         }
         }
         }
         });

         } else {
         $("#addModal1 .modal-title").text("新增");
         $("input[name=type1]").attr("checked", false);
         $("#sjyh").attr("checked", true);
         $("#userForm .account").parent().hide();

         }
         $("#addModal1").modal("show");*/
    }

    //提交
    $("#_unit_sub_btn")
        .on(
            "click",
            function () {
                //提交时：当选择为个人，且身份证验证通过了才能提交
                if ($("input[name=userType]:checked").val() == 0
                    && nunber($("input[name=identifiedNumber]")
                        .val())) {
                    $("#userForm").submit();
                }
                //当为企业的时候不做校验
                else if ($("input[name=userType]:checked").val() == 1
                    || $("input[name=userType]:checked").val() == 2) {
                    $("#userForm").submit();
                }
                return false;
            });

    $(function () {

        var userForm = $("#userForm").Validform(
            {
                tiptype: 2,
                usePlugin: {
                    passwordstrength: {
                        minLen: 6,
                        maxLen: 18,
                        trigger: function (obj, error) {
                            if (error) {
                                obj.parent().next().find(
                                    ".passwordStrength").hide()
                                    .siblings(".info").show();
                            } else {
                                obj.removeClass("Validform_error")
                                    .parent().next().find(
                                    ".passwordStrength")
                                    .show().siblings().hide();
                            }
                        }
                    }
                },
                beforeSubmit: function (curform) {
                    //判断身份证号码是否正确
                    /*if ($("input[name=userType]:checked").val() == 0 && !nunber($("input[name=identifiedNumber]").val())) {
                     return false;
                     }*/
                    /* else if ($("input[name=userType]:checked").val() == 1 && !$("input[name=inspectionId]").val()) {
                     $("#shit1").show().addClass("Validform_wrong");
                     $("#shit2").show().addClass("Validform_wrong");
                     return false;
                     }*/
                    /*else {*/
                    //判断密码是否被修改过；若没有则设置密码为空不进行修改
                    if ($("input[name=oldPassword]").val() == $(
                            "input[name=password]").val()) {
                        $("input[name=password]").val("");
                        $("input[name=password]")
                            .removeAttr("datatype");
                    }
                    //获取所有name为demand的对象
                    var obj = document.getElementsByName('type2');
                    var demand = '';

                    for (var i = 0; i < obj.length; i++) {
                        if (obj[i].checked) {
                            demand += obj[i].value;//如果选中，将value添加到变量s中
                        }
                    }

                    var formData = new FormData($('#userForm')[0]);
                    formData.append("monitoringType", demand);
                    $("#_unit_sub_btn").attr("disabled", "disabled");//禁用按钮
                    $.ajax({
                        type: "POST",
                        url: "${webRoot}/inspUnitUser/save.do",
                        data: formData,
                        contentType: false, //必须false才会避开jQuery对 formdata 的默认处理 XMLHttpRequest会对 formdata 进行正确的处理
                        processData: false, //必须false才会自动加上正确的Content-Type
                        dataType: "json",
                        success: function (data) {
                            if (data && data.success) {
                                $("#addModal1").modal("hide");
                                $("input[name=type1]").attr("checked", false);
                                $("#sjyh").attr("checked", true);
                                datagridUtil.query();
                            } else {
                                $("#addModal1").modal("hide");
                                $("#waringMsg>span").html(data.msg);
                                $("#my_confirm").modal('toggle');
                            }
                        }
                    });
                    return false;
                    /*}*/
                }
            });

        //隐藏用户表单
        $('#addModal1').on('hidden.bs.modal', function () {
            $("#userForm").Validform().resetForm();
            $("#userForm .account").text("");
            $("#userForm input[name='id']").val("");
            $("#userForm input[name='inspectionId']").val("");
            showOrhide(1);
        });
        $("#addModal1").on('show.bs.modal', function (e) {
            $("#_unit_sub_btn").removeAttr("disabled");
            $("#userForm").Validform().resetForm();
            $("input").removeClass("Validform_error");
            $(".passwordStrength").hide();
            $("input[name=type1]").attr("checked", false);
            $("input[name=type2]").attr("checked", false);
            $("#jg").hide();
            $("#sjyh").attr("checked", true);
        });

        //修改了密码，则给密码输入框加上验证
        $(".checkPassword")
            .on(
                "blur",
                function () {
                    if ($("input[name=oldPassword]").val() != $(
                            "input[name=password]").val()) {
                        $("input[name=password]").attr("datatype",
                            "*6-18");
                        $("input[name=password0]").attr("datatype",
                            "*6-18");
                    }
                });
        //电话号码的校验
        $("#phone")
            .change(
                function () {//此处与微信公众号那边校验的正则表达式一致
                    userForm
                        .addRule([{
                            ele: "#phone",
                            datatype: /^1[3456789]\d{9}$/,
                            ajaxurl: "${webRoot}/inspUnitUser/selectByPhone.do?userId="
                            + $("#userId").val()
                            + "&phone=" + $(this).val(),
                            nullmsg: "请输入联系方式！",
                            errormsg: "请输入正确的联系方式！"
                        }]);
                });

        //身份证唯一的校验（当输入的身份证不为空，且身份证号码符合，如果为空直接过）
        $("#identifiedNumber")
            .change(
                function () {
                    var identifiedNumber = $(this).val();
                    if (identifiedNumber
                        && nunber(identifiedNumber)) {
                        userForm
                            .addRule([{
                                ele: "#identifiedNumber",
                                datatype: "*",
                                ajaxurl: "${webRoot}/inspUnitUser/checkNumber?id="
                                + $("input[name=id]")
                                    .val()
                                + "&identifiedNumber="
                                + identifiedNumber,
                                nullmsg: "请输入联系方式！",
                                errormsg: "该身份证号码已被使用！"
                            }]);
                    } else {
                        $("#identifiedNumber").removeAttr(
                            "datatype");
                    }
                });

        //查看送检单位-用户
        $(document)
            .on(
                "click",
                ".account_id",
                function () {
                    showMbIframe("${webRoot}/balanceMgt/flow?isok=&userId="
                        + $(this).parents(".rowTr").attr(
                            "data-rowId"));
                });
    });


    //微信解绑
    function delopenid(phone, userName) {
        if (jbstate == 1) {
            $("#openid_confirm .cs-text-algin")
                .html(
                    '<img src="${webRoot}/img/warn.png" width="40px" alt=""/><p>用户信息（'
                    + phone + (userName ? "/" + userName : "") + '）</p><span class="tips">操作人需对本次解绑操作负责！</span>');
            jbstate = 2;
        } else {
            var id = $("#openid_confirm input[name=id]").val();
            if (id == null || id == "") {
                $("#openid_confirm .modal-title").text("提示");
                $("#openid_confirm .cs-text-algin")
                    .html(
                        '<img src="${webRoot}/img/warn.png" width="40px" alt=""/> <span class="tips" id="waringMsg">'
                        + data.msg + '</span>');
                $("#openid_confirm .modal-footer")
                    .html(
                        '<a class="btn btn-primary btn-ok" data-dismiss="modal">关闭</a>');
                return;
            }
            $
                .ajax({
                    type: "POST",
                    url: '${webRoot}' + "/inspUnitUser/del_openid",
                    data: {
                        id: id
                    },
                    dataType: "json",
                    success: function (data) {
                        if (data.success) {
                            $("#openid_confirm").modal("hide");
                            layer.ready(function () {
                                layer.msg('解绑成功', {
                                    icon: 1
                                });
                            });
                            datagridUtil.queryByFocus();
                        } else {
                            $("#openid_confirm .modal-title")
                                .text("提示");
                            $("#openid_confirm .cs-text-algin")
                                .html(
                                    '<img src="${webRoot}/img/warn.png" width="40px" alt=""/> <span class="tips" id="waringMsg">'
                                    + data.msg
                                    + '</span>');
                            $("#openid_confirm .modal-footer")
                                .html(
                                    '<a class="btn btn-primary btn-ok" data-dismiss="modal">关闭</a>');
                        }
                    }
                })
        }
    }

    //清除支付密码
    function resetpwd(phone, userName) {
        if (jbstate == 1) {
            $("#reset_confirm .cs-text-algin")
                .html(
                    '<img src="${webRoot}/img/warn.png" width="40px" alt=""/><p>用户信息（'
                    + phone + (userName ? "/" + userName : "") + '）</p><span class="tips">操作人需对本次清除密码操作负责！</span>');
            jbstate = 2;
        } else {
            var id = $("#reset_confirm input[name=id]").val();
            if (id == null || id == "") {
                $("#reset_confirm .modal-title").text("提示");
                $("#reset_confirm .cs-text-algin").html(
                    '<img src="${webRoot}/img/warn.png" width="40px" alt=""/> <span class="tips">'
                    + data.msg + '</span>');
                $("#reset_confirm .modal-footer")
                    .html(
                        '<a class="btn btn-primary btn-ok" data-dismiss="modal">关闭</a>');
                return;
            }
            $
                .ajax({
                    type: "POST",
                    url: '${webRoot}' + "/inspUnitUser/resetpwd",
                    data: {
                        id: id
                    },
                    dataType: "json",
                    success: function (data) {
                        if (data.success) {
                            $("#reset_confirm").modal("hide");
                            layer.ready(function () {
                                layer.msg('清除成功', {
                                    icon: 1
                                });
                            });
                            datagridUtil.queryByFocus();
                        } else {
                            $("#reset_confirm .modal-title").text("提示");
                            $("#reset_confirm .cs-text-algin").html(
                                '<img src="${webRoot}/img/warn.png" width="40px" alt=""/> <span class="tips">'
                                + data.msg + '</span>');
                            $("#reset_confirm .modal-footer")
                                .html(
                                    '<a class="btn btn-primary btn-ok" data-dismiss="modal">关闭</a>');
                        }

                    }
                })
        }
    }

    /*function change(o) {
     var value = o.value;
     $("#creditCode").val(value).select2();
     $("#companyName").val(value).select2();
     }*/
    function showOrhide(value) {

        if (value == 1 || value == 2) {//企业或监供应商
            $("#creditCode_ul").removeClass("hide").find("select").attr(
                "datatype", "*");
            $("#companyName_ul").removeClass("hide").find("select").attr(
                "datatype", "*");
            $("#identifiedNumber_ul").addClass("hide")
            $("#identifiedNumber").removeAttr("datatype");
        } else if (value == 0) {//个人
            $("#creditCode_ul").addClass("hide").find("select").removeAttr(
                "datatype");
            $("#companyName_ul").addClass("hide").find("select")
                .removeAttr("datatype");
            $("#identifiedNumber").attr("datatype", "*");
            $("#identifiedNumber_ul").removeClass("hide")
        }
    }

    function showAffiliation(value) {
        $("input[name=type]").val(value);
        //alert(value);
        $("#jg").hide();
        $("input[name=departName]").removeAttr("datatype");
        if (value.indexOf("1") != -1) {//委托单位
            $("#gly").attr("checked", 'checked');
        }
        if (value.indexOf("3") != -1) {//上门取样
            $("#smqy").attr("checked", 'checked');
        }
        if (value.indexOf("4") != -1) {//财务统计
            $("#cwtj").attr("checked", 'checked');
        }
        if (value.indexOf("2") != -1) {//监管方
            $("#jg").show();
            $("#jgf").attr("checked", 'checked');
            $(".requestType").removeClass("cs-hide");
            $("input[name=departName]").attr("datatype", "*");
        } else {
            $(".requestType").addClass("cs-hide");
        }

        /*
         if (value.indexOf("2") != -1){  //个人或者管理员
         $("#jg").hide();
         $("input[name=departName]").removeAttr("datatype");
         } else {
         $("#jg").show();
         $("input[name=departName]").attr("datatype", "*");
         } */

        // if (value != 2) {//个人或者管理员
        //     $("#jg").hide();
        //     $("input[name=departName]").removeAttr("datatype");
        // } else if (value == 2) {
        //     $("#jg").show();
        //     $("input[name=departName]").attr("datatype", "*");
        // }
    }


    //用户的停用与启用
    var stopId;
    var stopChecked;
    function openStopModel(id, checked) {
        stopId = id;
        if (checked) {
            stopChecked = 0;
            $("#confirm-delete3").find(".stop_conment").text("确认停用该用户吗？");
            $("#confirm-delete3").find(".btn-ok")
                .removeClass("btn-success").addClass("btn-danger")
                .text("停用");
        } else {
            stopChecked = 1;
            $("#confirm-delete3").find(".stop_conment").text("确认启用该用户吗？");
            $("#confirm-delete3").find(".btn-ok").removeClass("btn-danger")
                .addClass("btn-success").text("启用");
        }
        $("#confirm-delete3").modal("show");
    }
    function stopOrOpen() {
        $.ajax({
            type: "POST",
            url: "${webRoot}/inspUnitUser/stop.do",
            data: {
                'stopId': stopId,
                'checked': stopChecked
            },
            dataType: "json",
            success: function (data) {
                $("#confirm-delete3").modal('toggle');
                if (data && data.success) {
                    //操作成功后刷新列表
                    datagridUtil.queryByFocus();
                } else {
                    $("#waringMsg>span").html(data.msg);
                    $("#confirm-warnning").modal('toggle');
                }
            },
            error: function (data) {
                $("#confirm-warnning").modal('toggle');
            }
        });
    }
</script>
<%--自定义下拉查询功能--%>
<script>
    $(function () {
        //方法一：
        $("#search")
            .bind(
                "input propertychange",
                function () {
                    var value = $(this).val();
                    $("input[name=inspectionId]").val("");
                    if (value) {
                        $("#saleslist").find("ul").empty();
                        var keyhtml = "";
                        var searchhtmlS = "";
                        var searchhtml = "";
                        var InspectionUnitsList = eval('${inspectionListObj}');
                        for (var i = 0; i < InspectionUnitsList.length; i++) {
                            var obj = InspectionUnitsList[i];
                            var name = obj.companyName;//公司名称
                            var code = obj.creditCode;//公司名称
                            var id = obj.id;//
                            if (name.indexOf(value) != -1) {
                                if ((name == value && keyhtml == "")) {//当key==name
                                    $("input[name=inspectionId]")
                                        .val(id);
                                    $("input[name=companyName]")
                                        .val(name);
                                    $("input[name=creditCode]")
                                        .val(code);
                                    $("#shit1").hide();
                                    $("#shit2").hide();
                                    keyhtml += '<li onclick="checkInspection('
                                        + id
                                        + ',\''
                                        + name
                                        + '\',\''
                                        + code
                                        + '\')" data-id="'
                                        + id
                                        + '">' + name + '</li>';
                                } else if (name == value
                                    && keyhtml != "") {//关键字去重

                                } else if ((name.indexOf(value) == 0 && name != value)) {
                                    searchhtmlS += '<li onclick="checkInspection('
                                        + id
                                        + ',\''
                                        + name
                                        + '\',\''
                                        + code
                                        + '\')" data-id="'
                                        + id
                                        + '">' + name + '</li>';
                                } else {
                                    searchhtml += '<li onclick="checkInspection('
                                        + id
                                        + ',\''
                                        + name
                                        + '\',\''
                                        + code
                                        + '\')" data-id="'
                                        + id
                                        + '">' + name + '</li>';
                                }
                            }
                        }
                        $("#saleslist").find("ul").append(
                            keyhtml + searchhtmlS + searchhtml);
                        $("#saleslist").show();

                    } else {
                        $("#saleslist").hide();
                    }
                });

        $("#search2")
            .bind(
                "input propertychange",
                function () {
                    $("input[name=inspectionId]").val("");
                    var value = $(this).val();
                    if (value) {
                        $("#saleslist2").find("ul").empty();
                        var keyhtml = "";
                        var searchhtmlS = "";
                        var searchhtml = "";
                        var InspectionUnitsList = eval('${inspectionListObj}');
                        for (var i = 0; i < InspectionUnitsList.length; i++) {
                            var obj = InspectionUnitsList[i];
                            var name = obj.companyName;//公司名称
                            var code = obj.creditCode;//公司名称
                            var id = obj.id;//
                            if (code.indexOf(value) != -1) {
                                if ((code == value && keyhtml == "")) {//当key==name
                                    $("input[name=inspectionId]")
                                        .val(id);
                                    $("input[name=companyName]")
                                        .val(name);
                                    $("input[name=creditCode]")
                                        .val(code);
                                    $("#shit1").hide();
                                    $("#shit2").hide();
                                    keyhtml += '<li onclick="checkInspection('
                                        + id
                                        + ',\''
                                        + name
                                        + '\',\''
                                        + code
                                        + '\')" data-id="'
                                        + id
                                        + '">' + code + '</li>';
                                } else if (code == value
                                    && keyhtml != "") {//关键字去重
                                } else if ((code.indexOf(value) == 0 && code != value)) {
                                    searchhtmlS += '<li onclick="checkInspection('
                                        + id
                                        + ',\''
                                        + name
                                        + '\',\''
                                        + code
                                        + '\')" data-id="'
                                        + id
                                        + '">' + code + '</li>';
                                } else {
                                    searchhtml += '<li onclick="checkInspection('
                                        + id
                                        + ',\''
                                        + name
                                        + '\',\''
                                        + code
                                        + '\')" data-id="'
                                        + id
                                        + '">' + code + '</li>';
                                }
                            }
                        }
                        $("#saleslist2").find("ul").append(
                            keyhtml + searchhtmlS + searchhtml);
                        $("#saleslist2").show();
                    } else {
                        $("#saleslist2").hide();
                    }
                });
    });
    function checkInspection(id, name, code) {
        $("input[name=inspectionId]").val(id);
        $("input[name=companyName]").val(name);
        $("input[name=creditCode]").val(code);
        $("#shit1").hide();
        $("#shit2").hide();
        $("#saleslist").hide();
    }
</script>
<script>
    //以下为身份证号码的校验
    function nunber(allowancePersonValue) {
        debugger;
        if (allowancePersonValue == '') {
            $("#identifiedNumber").removeAttr("datatype");
            $("#user_number").removeClass("Validform_wrong").html("");
            $("#identifiedNumber").removeAttr("datatype", "*");
            return true;
        }
        //校验长度，类型
        else if (isCardNo(allowancePersonValue) === false) {
            $("#user_number").addClass("Validform_wrong");
            $("#user_number").html("您输入的身份证号码不正确，请重新输入");
            $("#identifiedNumber").attr("datatype", "*");
            return false;
        }
        //检查省份
        else if (checkProvince(allowancePersonValue) === false) {
            $("#user_number").addClass("Validform_wrong");
            $("#user_number").html("您输入的身份证号码不正确,请重新输入");
            $("#identifiedNumber").attr("datatype", "*");
            return false;

        }
        //校验生日
        else if (checkBirthday(allowancePersonValue) === false) {
            $("#user_number").addClass("Validform_wrong");
            $("#user_number").html("您输入的身份证号码生日不正确,请重新输入");
            $("#identifiedNumber").attr("datatype", "*");
            return false;
        }
        //检验位的检测
        else if (checkParity(allowancePersonValue) === false) {
            $("#user_number").addClass("Validform_wrong");
            $("#user_number").html("您的身份证校验位不正确,请重新输入");
            $("#identifiedNumber").attr("datatype", "*");
            return false;
        } else {
            $("#user_number").removeClass("Validform_wrong").html("");
            $("#identifiedNumber").attr("datatype", "*");
            return true;
        }
    }

    //身份证省的编码
    var vcity = {
        11: "北京",
        12: "天津",
        13: "河北",
        14: "山西",
        15: "内蒙古",
        21: "辽宁",
        22: "吉林",
        23: "黑龙江",
        31: "上海",
        32: "江苏",
        33: "浙江",
        34: "安徽",
        35: "福建",
        36: "江西",
        37: "山东",
        41: "河南",
        42: "湖北",
        43: "湖南",
        44: "广东",
        45: "广西",
        46: "海南",
        50: "重庆",
        51: "四川",
        52: "贵州",
        53: "云南",
        54: "西藏",
        61: "陕西",
        62: "甘肃",
        63: "青海",
        64: "宁夏",
        65: "新疆",
        71: "台湾",
        81: "香港",
        82: "澳门",
        91: "国外"
    };

    //检查号码是否符合规范，包括长度，类型
    function isCardNo(card) {
        //身份证号码为15位或者18位，15位时全为数字，18位前17位为数字，最后一位是校验位，可能为数字或字符X
        var reg = /(^\d{15}$)|(^\d{17}(\d|X)$)/;
        if (reg.test(card) === false) {
            //alert("demo");
            return false;
        }
        return true;
    }

    //取身份证前两位,校验省份
    function checkProvince(card) {
        var province = card.substr(0, 2);
        if (vcity[province] == undefined) {
            return false;
        }
        return true;
    }

    //检查生日是否正确
    function checkBirthday(card) {
        var len = card.length;
        //身份证15位时，次序为省（3位）市（3位）年（2位）月（2位）日（2位）校验位（3位），皆为数字
        if (len == '15') {
            var re_fifteen = /^(\d{6})(\d{2})(\d{2})(\d{2})(\d{3})$/;
            var arr_data = card.match(re_fifteen);
            var year = arr_data[2];
            var month = arr_data[3];
            var day = arr_data[4];
            var birthday = new Date('19' + year + '/' + month + '/' + day);
            return verifyBirthday('19' + year, month, day, birthday);
        }
        //身份证18位时，次序为省（3位）市（3位）年（4位）月（2位）日（2位）校验位（4位），校验位末尾可能为X
        if (len == '18') {
            var re_eighteen = /^(\d{6})(\d{4})(\d{2})(\d{2})(\d{3})([0-9]|X)$/;
            var arr_data = card.match(re_eighteen);
            var year = arr_data[2];
            var month = arr_data[3];
            var day = arr_data[4];
            var birthday = new Date(year + '/' + month + '/' + day);
            return verifyBirthday(year, month, day, birthday);
        }
        return false;
    }

    //校验日期
    function verifyBirthday(year, month, day, birthday) {
        var now = new Date();
        var now_year = now.getFullYear();
        //年月日是否合理
        if (birthday.getFullYear() == year
            && (birthday.getMonth() + 1) == month
            && birthday.getDate() == day) {
            //判断年份的范围（3岁到100岁之间)
            var time = now_year - year;
            if (time >= 3 && time <= 100) {
                return true;
            }
            return false;
        }
        return false;
    }

    //校验位的检测
    function checkParity(card) {
        //15位转18位
        card = changeFivteenToEighteen(card);
        var len = card.length;
        if (len == '18') {
            var arrInt = [7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10,
                5, 8, 4, 2];
            var arrCh = ['1', '0', 'X', '9', '8', '7', '6', '5',
                '4', '3', '2'];
            var cardTemp = 0, i, valnum;
            for (i = 0; i < 17; i++) {
                cardTemp += card.substr(i, 1) * arrInt[i];
            }
            valnum = arrCh[cardTemp % 11];
            if (valnum == card.substr(17, 1)) {
                return true;
            }
            return false;
        }
        return false;
    }

    //15位转18位身份证号
    function changeFivteenToEighteen(card) {
        if (card.length == '15') {
            var arrInt = [7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10,
                5, 8, 4, 2];
            var arrCh = ['1', '0', 'X', '9', '8', '7', '6', '5',
                '4', '3', '2'];
            var cardTemp = 0, i;
            card = card.substr(0, 6) + '19'
                + card.substr(6, card.length - 6);
            for (i = 0; i < 17; i++) {
                cardTemp += card.substr(i, 1) * arrInt[i];
            }
            card += arrCh[cardTemp % 11];
            return card;
        }
        return card;
    }

    $("#tt").tree({
        checkbox: false,
        //url:"${webRoot}/detect/depart/getDepartTree.do?pid=${org.departPid}",
        url: "${webRoot}/detect/depart/getDepartTree.do",
        animate: true,
        lines: false,
        onClick: function (node) {
            $(".sPointId").val(node.id);
            $(".sPointName").val(node.text);
//             datagridOption['pageNo'] = 1;
//             datagridUtil.query();
            $(".cs-check-down").hide();
//             setTimeout(function () {
//                 queryPoint(node.id);
//                 queryReg(node.id);
//             }, 100);

        }
    });
</script>
</body>
</html>
