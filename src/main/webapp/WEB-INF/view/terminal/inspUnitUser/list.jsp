<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/WEB-INF/view/common/resource.jsp" %>
<html>
<head>
    <title>快检服务云平台</title>
</head>
<body>
<div class="cs-col-lg clearfix">
    <ol class="cs-breadcrumb">
        <li class="cs-fl">
            <img src="${webRoot}/img/set.png" alt=""/>
            <a href="javascript:">客户管理</a></li>
        <li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
        <li class="cs-fl">经营者</li>
        <li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
        <li class="cs-b-active cs-fl">用户</li>
    </ol>
    <div class="cs-search-box cs-fr">
        <form>
            <div class="cs-search-filter clearfix cs-fl">
                <input class="cs-input-cont cs-fl focusInput" type="text" name="keyWords" placeholder="请输入姓名或账号"/>
                <input type="button" class="cs-search-btn cs-fl" onclick="datagridUtil.queryByFocus()" href="javascript:;" value="搜索">
                <%--<span class="cs-s-search cs-fl">高级搜索</span>--%>
            </div>
            <div class="clearfix cs-fr" id="showBtn">
                <a href="javascript:" onclick="parent.closeMbIframe();" class="cs-menu-btn"><i class="icon iconfont icon-fanhui"></i>返回</a>
            </div>
        </form>
    </div>
</div>

<div id="dataList1"></div>


<div class="modal fade intro2" id="addModal1" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog cs-mid-width" role="document">
        <div class="modal-content ">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">新增</h4>
            </div>
            <div class="modal-body cs-mid-height">
                <!-- 主题内容 -->
                <div class="cs-tabcontent">
                    <div class="cs-content2 cs-add-new">
                        <form id="userForm" method="post">
                            <input type="hidden" name="id" id="userId">
                            <input type="hidden" name="oldPassword">

                            <input type="hidden" name="coldUnitId" value="${coldUnitId}">
                            <input type="hidden" name="inspectionId" value="${inspUnitId}">
                            <ul class="cs-ul-form clearfix">
                                <li class="cs-name col-md-3" width="20%">用户编号：</li>
                                <li class="cs-in-style col-md-5 account" width="210px"></li>
                            </ul>
                            <ul class="cs-ul-form clearfix">
                                <li class="cs-name col-md-3" width="20%"><%--<i class="cs-mred">*</i>--%>用户姓名：</li>
                                <li class="cs-in-style col-md-5" width="210px">
                                    <input type="text" maxlength="18" name="realName" class="inputxt" <%--datatype="s2-18"--%> nullmsg="请输入用户姓名！"
                                           errormsg="用户姓名至少2个字符,最多18个字符！"/>
                                </li>
                                <li class="col-xs-4 col-md-4 cs-text-nowrap">
                                    <div class="Validform_checktip"></div>
                                    <div class="info"></div>
                                </li>
                            </ul>
                            <%--<ul class="cs-ul-form clearfix">
                                <li class="cs-name col-md-3" width="20%"><i class="cs-mred">*</i>登录账号：</li>
                                <li class="cs-in-style col-md-5" width="210px">
                                    <input type="text" maxlength="12" name="userName" id="userName" class="inputxt" datatype="s6-18"
                                           nullmsg="请输入登录账号！"
                                           errormsg="登录账号至少6个字符,最多12个字符！"/>
                                </li>
                                <li class="col-xs-4 col-md-4 cs-text-nowrap">
                                    <div class="Validform_checktip"></div>
                                    <div class="info"></div>
                                </li>
                            </ul>--%>
                            <ul class="cs-ul-form clearfix">
                                <li class="cs-name col-md-3" width="20%"><i class="cs-mred">*</i>登录手机：</li>
                                <li class="cs-in-style col-md-5" width="210px">
                                    <input type="text" datatype="m" id="phone" name="phone" nullmsg="请输入手机号码！" errormsg="请输入正确的手机号码！"/>
                                </li>
                                <li class="col-xs-4 col-md-4">
                                    <div class="Validform_checktip"></div>
                                    <div class="info"></div>
                                </li>
                            </ul>
                            <ul class="cs-ul-form clearfix">
                                <li class="cs-name col-md-3" width="20%"><i class="cs-mred">*</i>登录密码：</li>
                                <li class="cs-in-style col-md-5" width="210px">
                                    <input type="password" maxlength="18" name="password" class="inputxt checkPassword" plugin="passwordStrength"
                                           datatype="*6-18" nullmsg="请输入密码！" errormsg="密码至少6个字符,最多18个字符！"/>
                                </li>
                                <li class="col-xs-4 col-md-4">
                                    <div class="Validform_checktip"></div>
                                    <div class="info"></div>
                                </li>
                            </ul>
                            <ul class="cs-ul-form clearfix">
                                <li class="cs-name col-md-3" width="20%"><i class="cs-mred">*</i>密码确认：</li>
                                <li class="cs-in-style col-md-5" width="210px">
                                    <input type="password" maxlength="18" name="password0" class="inputxt checkPassword" autocomplete="new-password"
                                           recheck="password"
                                           datatype="*6-18" nullmsg="请确认密码！" errormsg="两次输入的密码不一致！"/>
                                </li>
                                <li class="col-xs-4 col-md-4">
                                    <div class="Validform_checktip"></div>
                                    <div class="info"></div>
                                </li>
                            </ul>


<%--                                <ul class="cs-ul-form clearfix"><li class="cs-name col-md-3" width="20%">用户角色：</li>--%>
<%--                                <li class="cs-in-style col-md-5" width="210px">--%>
<%--                                    <input id="_type_radio1" type="radio" name="type" value="0" checked="checked"/>--%>
<%--                                    <label for="_type_radio1">普通用户</label>--%>
<%--                                    <input id="_type_radio2" type="radio" name="type" value="1"/>--%>
<%--                                    <label for="_type_radio2">管理用户</label>--%>
<%--                                </li></ul>--%>

                            <ul class="cs-ul-form clearfix">
                                <!-- 用户类型选择 -->
                                <li class="cs-name col-md-3"><i class="cs-mred">*</i>用户类型：</li>
                                <li class="cs-in-style col-md-5">
                                    <label><input id="_type_radio1" type="radio" name="userType" value="0" checked /> 个人</label>
                                    <label><input id="_type_radio2" type="radio" name="userType" value="1" /> 企业</label>
                                </li>
                            </ul>

                            <ul class="cs-ul-form clearfix">
                                <li class="cs-name col-md-3" width="20%">用户角色：</li>
                                <li class="cs-in-style col-md-5" width="210px">
                                    <select name="type" class="form-control">
                                        <option value="0">普通用户</option>
                                        <option value="1">抽样人员</option>
                                        <option value="2">监管方</option>
                                        <option value="4">财务统计</option>
                                    </select>
                                </li>
                            </ul>

                        <%--                            <ul class="cs-ul-form clearfix">--%>
<%--                                <!-- 企业相关信息 -->--%>
<%--                                <li class="cs-name col-md-3 userType0 hide">公司名称：</li>--%>
<%--                                <li class="cs-in-style col-md-5 userType0 hide">--%>
<%--                                    <input type="text" name="companyName" id="search" class="show-list" autocomplete="off" />--%>
<%--                                    <div class="cs-check-down" id="saleslist" style="display: none;">--%>
<%--                                        <ul class="code-lists"></ul>--%>
<%--                                    </div>--%>
<%--                                </li>--%>
<%--                            </ul>--%>
<%--                            <ul class="cs-ul-form clearfix">--%>
<%--                                <li class="cs-name col-md-3 userType0 hide">信用代码：</li>--%>
<%--                                <li class="cs-in-style col-md-5 userType0 hide">--%>
<%--                                    <input type="text" name="creditCode" id="search2" class="show-list" autocomplete="off" />--%>
<%--                                    <div class="cs-check-down" id="saleslist2" style="display: none;">--%>
<%--                                        <ul class="code-lists"></ul>--%>
<%--                                    </div>--%>
<%--                                </li>--%>
<%--                            </ul>--%>
                            <ul class="cs-ul-form clearfix">
                                <!-- 个人相关信息 -->
                                <li class="cs-name col-md-3">身份证号：</li>
                                <li class="cs-in-style col-md-5">
                                    <input type="text" name="identifiedNumber" id="identifiedNumber" maxlength="20" />
                                    <div class="Validform_checktip" id="user_number"></div>
                                </li>
                            </ul>






                            <ul class="cs-ul-form clearfix">
                                <li class="cs-name col-md-3" width="20%">用户状态：</li>
                                <li class="cs-in-style col-md-5" width="210px">
                                    <input id="_check_radio1" type="radio" name="checked" value="0"/>
                                    <label for="_check_radio1">停用</label>
                                    <input id="_check_radio2" type="radio" name="checked" value="1" checked="checked"/>
                                    <label for="_check_radio2">启用</label>
                                </li>
                            </ul>
                        </form>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-success" id="_unit_sub_btn">确定</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
            </div>
        </div>
    </div>
</div>

<%@include file="/WEB-INF/view/common/modalBox.jsp" %>
<%@include file="/WEB-INF/view/common/confirm.jsp" %>

<script type="text/javascript" src="${webRoot}/js/datagridUtil.js"></script>
<%--表单插件--%>
<%--<script type="text/javascript" src="${webRoot}/js/jquery.form.js"></script>--%>
<%--校验插件--%>
<%--<script type="text/javascript" src="${webRoot}/plug-in/jquery.validation/1.14.0/jquery.validate.min.js"></script>
<script type="text/javascript" src="${webRoot}/plug-in/jquery.validation/1.14.0/validate-methods.js"></script>
<script type="text/javascript" src="${webRoot}/plug-in/jquery.validation/1.14.0/messages_zh.min.js"></script>--%>
<script type="text/javascript">
    if (Permission.exist("1439-4") == 1) {
        var html = '<a class="cs-menu-btn" onclick="addOrUpdateUser();"><i class="' + Permission.getPermission("1439-4").functionIcon + '"></i>新增</a>';
        $("#showBtn").prepend(html);
    }
    var op1 = {
        tableId: "dataList1",
        tableAction: "${webRoot}/inspUnitUser/datagrid?inspectionUnit.id=${inspUnitId}",
        parameter: [
            {
                columnCode: "account",
                columnName: "用户编号"
            },
            {
                columnCode: "realName",
                columnName: "用户姓名"
            },/* {
                columnCode: "userName",
                columnName: "登录账号"
            },*/
            {
                columnCode: "phone",
                columnName: "登录手机"
            },
            {
                columnCode: "userType",
                columnName: "用户类型",
                customVal: {"0": "个人用户", "1": "企业用户"}
            },
            {
                columnCode: "type",
                columnName: "用户角色",
                customVal: {"0": "普通用户", "1": "抽样人员", "2": "监管方", "4": "财务统计",}
            },
            {
                columnCode: "loginCount",
                columnName: "登录次数"
            },
            {
                columnCode: "loginTime",
                columnName: "最近登录"
            },
            {
                columnCode: "checked",
                columnName: "用户状态",
                customVal: {"0": '<span style="color:red">停用</span>', "1": "启用"}
            }
        ],

        funBtns: [
            {	//编辑
                show: Permission.exist("1439-4"),
                style: Permission.getPermission("1439-4"),
                action: function (id) {
                    addOrUpdateUser(id);
                }
            }
        ]

    };
    datagridUtil.initOption(op1);
    datagridUtil.query();

    //新增、更新用户
    function addOrUpdateUser(userId) {
        if (userId) {
            $("#addModal1 .modal-title").text("编辑");
            $("#userForm .account").parent().show();
            $.ajax({
                url: '${webRoot}/inspUnitUser/queryById',
                method: 'post',
                data: {"id": userId},
                success: function (data) {
                    if (data && data.success) {
                        $("#userForm input[name='id']").val(data.obj.id);
                        $("#userForm .account").text(data.obj.account);
                        //$("#userForm input[name='userName']").val(data.obj.userName);
                        $("#userForm input[name='phone']").val(data.obj.phone);
                        $("#userForm input[name='realName']").val(data.obj.realName);
                        $("#userForm input[name='password']").val(data.obj.password);
                        $("#userForm input[name='password0']").val(data.obj.password);
                        $("#userForm input[name='oldPassword']").val(data.obj.password);
                        $("#userForm input[name='identifiedNumber']").val(data.obj.identifiedNumber);
                        $("#userForm select[name='type']").val(data.obj.type);
                        $("#userForm input[name=password]").removeAttr("datatype");
                        $("#userForm input[name=password0]").removeAttr("datatype");
                        if (data.obj.userType == 0) {
                            $("#userForm input[name='userType']:eq(0)").prop("checked", true);
                        } else if (data.obj.userType == 1) {
                            $("#userForm input[name='userType']:eq(1)").prop("checked", true);
                        }

                        if (data.obj.checked == 0) {
                            $("#userForm input[name='checked']:eq(0)").prop("checked", true);
                        } else if (data.obj.checked == 1) {
                            $("#userForm input[name='checked']:eq(1)").prop("checked", true);
                        }
                    }
                }
            });

        } else {
            $("#addModal1 .modal-title").text("新增");
            $("#userForm .account").parent().hide();
        }
        $("#addModal1").modal("show");
    }

    //提交
    $("#_unit_sub_btn").on("click", function () {
        $("#userForm").submit();
        return false;
    });

    $(function () {
        var userForm = $("#userForm").Validform({
            tiptype: 2,
            usePlugin: {
                passwordstrength: {
                    minLen: 6,
                    maxLen: 18,
                    trigger: function (obj, error) {
                        if (error) {
                            obj.parent().next().find(".passwordStrength").hide().siblings(".info").show();
                        } else {
                            obj.removeClass("Validform_error").parent().next().find(".passwordStrength").show().siblings().hide();
                        }
                    }
                }
            },
            beforeSubmit: function (curform) {//判断密码是否被修改过；若没有则设置密码为空不进行修改
                if ($("input[name=oldPassword]").val() == $("input[name=password]").val()) {
                    $("input[name=password]").val("");
                    $("input[name=password]").removeAttr("datatype");
                }
                var formData = new FormData($('#userForm')[0]);
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
                            datagridUtil.query();
                        } else {
                            $("#addModal1").modal("hide");
                            $("#waringMsg>span").html(data.msg);
                            $("#confirm-warnning").modal('toggle');
                        }
                    }
                });
                return false;
            }
        });

        //隐藏用户表单
        $('#addModal1').on('hidden.bs.modal', function () {
            $("#userForm").Validform().resetForm();
            $("#userForm .account").text("");
            $("#userForm input[name='id']").val("");
        });
        $("#addModal1").on('show.bs.modal', function (e) {
            $("#_unit_sub_btn").removeAttr("disabled");
            $("#userForm").Validform().resetForm();
            $("input").removeClass("Validform_error");
            $(".passwordStrength").hide();
        });

        //修改了密码，则给密码输入框加上验证
        $(".checkPassword").on("blur", function () {
            if ($("input[name=oldPassword]").val() != $("input[name=password]").val()) {
                $("input[name=password]").attr("datatype", "*6-18");
                $("input[name=password0]").attr("datatype", "*6-18");
            }
        });
        //登录账号和联系方式的唯一性
        /*$("#userName").change(function () {//此处与微信公众号那边校验的正则表达式一致
            userForm.addRule([
                {
                    ele: "#userName",
                    datatype: /^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,}$/,
                    ajaxurl: "${webRoot}/inspUnitUser/selectByUsername.do?userId=" + $("#userId").val() + "&userName=" + $(this).val(),
                    nullmsg: "请输入登录账号！",
                    errormsg: "所填账号必须为6位以上字母加数字组合！"
                }
            ]);
        });*/
        $("#phone").change(function () {//此处与微信公众号那边校验的正则表达式一致
            userForm.addRule([
                {
                    ele: "#phone",
                    datatype: /^1[3456789]\d{9}$/,
                    ajaxurl: "${webRoot}/inspUnitUser/selectByPhone.do?userId=" + $("#userId").val() + "&phone=" + $(this).val(),
                    nullmsg: "请输入联系方式！",
                    errormsg: "请输入正确的联系方式！"
                }
            ]);
        });
    });

    //点击企业与个人的显示与隐藏
    $("input[type=radio][name=userType]").change(function () {
        showOrhide(this.value)
    });
    /**
     * 点击企业与个人的显示与隐藏
     * @param value
     */
    function showOrhide(value) {
        if (value == 1 || value == 2) {//企业或监供应商
            $(".userType0").removeClass("hide");
            $(".userType1").addClass("hide");
        } else if (value == 0) {//个人
            $(".userType1").removeClass("hide");
            $(".userType0").addClass("hide");

        }
    }
</script>
</body>
</html>
