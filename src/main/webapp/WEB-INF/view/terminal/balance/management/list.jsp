<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/WEB-INF/view/common/resource.jsp" %>
<html>
<head>
    <title>快检服务云平台</title>
    <style>
        .has-pdb-40 {
            padding-bottom: 40px;
        }

        .input-style input[type="radio"], .input-style input[type="checkbox"] {
            float: left;
            margin-top: 8px;
            margin-right: 3px;
        }
    </style>
</head>
<body>
<div class="cs-col-lg clearfix">
    <ol class="cs-breadcrumb">
        <li class="cs-fl">
            <img src="${webRoot}/img/set.png" alt=""/>
            <a href="javascript:">财务管理</a></li>
        <li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
        <li class="cs-b-active cs-fl">账户余额</li>
    </ol>
    <div class="cs-fl" style="margin: 9px 0 0 20px;">
        <label>有交易 <input class="pull-left" type="checkbox" name="ishave" value="0" id="ishave"></label>
    </div>
    <div class="cs-search-box cs-fr">
        <form>
            <div class="cs-search-filter clearfix cs-fl">
                <input class="cs-input-cont cs-fl focusInput" type="text" name="phone" placeholder="请输入联系方式"/>
                <input type="button" class="cs-search-btn cs-fl" onclick="datagridUtil.queryByFocus()" href="javascript:;" value="搜索">
                <%--<span class="cs-s-search cs-fl">高级搜索</span>--%>
            </div>
        </form>
    </div>
</div>
<div class="cs-col-lg-table has-pdb-40">
    <div id="dataList1"></div>
    <div class="cs-bottom-tools cs-btm-ts2" style="bottom: 50px;border-bottom: 1px solid #ddd;height: 36px;padding: 7px 22px;text-align:right;">
        <span onclick="">充值金额合计：<i id="actualMoney">0（元）</i></span>
        <i>|&nbsp;</i>
        <span onclick="">赠送金额合计：<i id="giftMoney">0（元）</i></span>
        <i>|&nbsp;</i>
        <span onclick="">总计：<i id="totalMoney">0（元）</i></span>
    </div>
</div>

<%--修改余额模态框 start--%>
<div class="modal fade intro2" id="addModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog cs-mid-width" role="document">
        <div class="modal-content ">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">余额操作</h4>
            </div>
            <div class="modal-body cs-mid-height">
                <!-- 主题内容 -->
                <div class="cs-tabcontent">
                    <div class="cs-content2 cs-add-new">
                        <form id="saveForm" method="post">
                            <input type="hidden" name="id">
                            <input type="hidden" name="createBy">
                            <input type="hidden" name="realName">
                            <input type="hidden" name="phone">
                            <ul class="cs-ul-form clearfix">
                                <li class="cs-name col-md-3" width="20%"><i class="cs-mred">*</i>费用类型：</li>
                                <li class="cs-al cs-modal-input">
                                    <label><input type="radio" value="5" name="transactionType" checked="checked"/>增加金额</label>
                                    <label><input type="radio" value="6" name="transactionType"/>减少金额</label>
                                </li>
                            </ul>
                            <ul class="cs-ul-form clearfix  showPerson1">
                                <li class="cs-name col-md-3" width="20%"><i class="cs-mred">*</i>金额(元)：</li>
                                <li class="cs-in-style col-md-5" width="210px"><%--大于0 最多两位小数--%>
                                    <input type="text" name="money" datatype="/^([1-9]\d*(.\d{1,2})?)$|^(0.\d?[1-9])$|^(0.[1-9]\d?)$/" maxlength="8"
                                           onblur="clearNoNum(this)" onkeyup="clearNoNum(this)"
                                           nullmsg="请输入金额"/>
                                </li>
                                <li class="col-md-4 col-xs-4  cs-text-nowrap">
                                    <div class="Validform_checktip"></div>
                                    <div class="info">
                                    </div>
                                </li>
                            </ul>
                            <ul class="cs-ul-form clearfix">
                                <li class="cs-name col-md-3" width="20%"><i class="cs-mred">*</i>备注信息：</li>
                                <li class="cs-in-style col-md-5" width="210px">
                                    <textarea type="text" datatype="*" nullmsg="请输入备注信息" name="remark" maxlength="236" cols="50" rows="20"
                                              style="height:110px;"></textarea>
                                </li>
                                <li class="col-md-4 col-xs-4  cs-text-nowrap">
                                    <div class="Validform_checktip"></div>
                                    <div class="info">
                                    </div>
                                </li>
                            </ul>
                        </form>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-success" id="btnSave">确定</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
            </div>
        </div>
    </div>
</div>
<%--修改余额模态框 end--%>

<%--查看用户信息模态框 start--%>
<div class="modal fade intro2" id="showUser" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog cs-lg-width" role="document">
        <div class="modal-content ">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">用户信息</h4>
            </div>
            <div class="modal-body cs-lg-height">
                <!-- 主题内容 -->
                <div class="cs-tabcontent">
                    <div class="cs-content2 cs-add-new">
                        <ul class="cs-ul-form clearfix">
                            <li class="cs-name col-md-3" width="20%">用户编号：</li>
                            <li class="cs-in-style col-md-5 account" width="210px"></li>
                        </ul>
                        <ul class="cs-ul-form clearfix">
                            <li class="cs-name col-md-3" width="20%">用户姓名：</li>
                            <li class="cs-in-style col-md-5" width="210px">
                                <input type="text" disabled="disabled" name="realName"/>
                            </li>
                        </ul>
                        <ul class="cs-ul-form clearfix">
                            <li class="cs-name col-md-3" width="20%">登录手机：</li>
                            <li class="cs-in-style col-md-5" width="210px">
                                <input type="text" disabled="disabled" name="phone"/>
                            </li>
                        </ul>

                        <ul class="cs-ul-form clearfix">
                            <li class="cs-name col-md-3" width="20%">用户类型：</li>
                            <li class="cs-in-style input-style col-md-5" style="width:430px">
                                <input type="hidden" name="type" value="0">
                                <div>
                                    <label> <input type="checkbox" name="type1" value="0" id="sjyh" checked disabled="true">送检用户</label>
                                    &nbsp;
                                    <label><input type="checkbox" name="type1" value="3" id="smqy" disabled="true">上门取样</label>
                                    &nbsp;
                                    <label><input type="checkbox" name="type1" value="1" id="gly" disabled="true">委托单位</label>
                                    &nbsp;
                                    <label><input type="checkbox" name="type1" value="4" id="cwtj" disabled="true">财务统计</label>
                                </div>
                                <div>
                                    <label class="pull-left"><input type="checkbox" name="type1" value="2" id="jgf" disabled="true">监管方</label>
                                    <div class="cs-all-ps" id="jg">
                                        <div class="cs-input-box" style="width:168px;float:left;margin-right: 10px;">
                                            <input type="hidden" class="sPointId" name="departId"/>
                                            <input type="text" name="departName" readonly="readonly"
                                                   class="sPointName cs-down-input" datatype="*"
                                                   nullmsg="请选择机构" errormsg="机构错误!" style="width:168px,padding-right:0px;" disabled="true"/>
                                        </div>


                                        <div id="divBtn" class="cs-check-down  cs-hide"
                                             style="display: none;">

                                            <!-- 树状图 -->
                                            <ul id="tt" class="easyui-tree">
                                            </ul>
                                            <!-- 树状图 -->

                                        </div>


                                    </div>
                                </div>
                                <div class="requestType cs-hide" style="padding-left: 64px; ">
                                    <c:forEach var="req" items="${reqListType}">
                                        <label> <input type="checkbox" name="type2" value="${req.id}" disabled="true">${req.unitType}</label>
                                    </c:forEach>
                                </div>
                                <%--    <label><input type="radio" name="type" value="0" checked="checked"/>送检用户</label>
                                    <label><input type="radio" name="type" value="1"/>管理员</label>
                                    <label><input type="radio" name="type" value="2"/> 监管方</label>--%>
                            </li>
                        </ul>
                        <!--  <ul id="jg" class="cs-ul-form clearfix">
                             <li class="cs-name col-md-3" width="20%">所属机构：</li>
                             <li class="cs-in-style col-md-5" width="210px">
                                 <input type="text" disabled="disabled" name="departName"/>
                             </li>
                         </ul> -->
                        <ul class="cs-ul-form clearfix">
                            <li class="cs-name col-md-3" width="20%">用户状态：</li>
                            <li class="cs-in-style col-md-5" width="210px">
                                <label><input type="radio" disabled="disabled" name="checked" value="1" checked="checked"/> 启用</label>
                                <label><input type="radio" disabled="disabled" name="checked" value="0"/> 停用</label>
                            </li>
                        </ul>
                        <ul class="cs-ul-form clearfix">
                            <li class="cs-name col-md-3" width="20%">用户类别：</li>
                            <li class="cs-in-style col-md-5" width="210px">
                                <label><input type="radio" disabled="disabled" name="userType" value="0" checked="checked"/> 个人</label>
                                <label><input type="radio" disabled="disabled" name="userType" value="1"/> 企业</label>
                            </li>
                        </ul>
                        <ul class="cs-ul-form clearfix hide" id="identifiedNumber_ul">
                            <li class="cs-name col-md-3" width="20%">身份证号：</li>
                            <li class="cs-in-style col-md-5" width="210px">
                                <input type="text" disabled="disabled" name="identifiedNumber"/>
                            </li>
                        </ul>
                        <ul class="cs-ul-form clearfix" id="companyName_ul">
                            <li class="cs-name col-md-3" width="20%">公司名称：</li>
                            <li class="cs-in-style col-md-5" width="210px">
                                <input type="text" disabled="disabled" name="companyName"/>
                            </li>
                        </ul>
                        <ul class="cs-ul-form clearfix" id="creditCode_ul">
                            <li class="cs-name col-md-3" width="20%">社会信用代码：</li>
                            <li class="cs-in-style col-md-5" width="210px">
                                <input type="text" disabled="disabled" name="creditCode"/>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
            </div>
        </div>
    </div>
</div>
<%--查看用户信息模态框 end--%>

<%@include file="/WEB-INF/view/common/modalBox.jsp" %>
<%@include file="/WEB-INF/view/common/confirm.jsp" %>
<script type="text/javascript" src="${webRoot}/js/datagridUtil2.js"></script>
<script type="text/javascript">

    $(function () {
        loadData(0);

        //点击“无交易不显示”进行数据筛选
        $("#ishave").click(function () {
            loadData(this.checked ? 1 : 0);
        });
    });

    function loadData(ishave) {
        var datagrid1 = datagridUtil.initOption({
            tableId: "dataList1",
            tableAction: "${webRoot}/balanceMgt/datagrid",
            defaultCondition: [			//附加请求参数
                {
                    queryCode: "ishave",
                    queryVal: ishave
                }
            ],
            parameter: [
                {
                    columnCode: "account",
                    columnName: "用户编号",
                    columnWidth: "10%",
                    sortDataType: "int",
                    customElement: "<a href=\"javascript:;\" title='用户信息' class=\"cs-link text-primary\" onclick=\"seeUser(\'#accountId#\')\">#account#</a>"
                },
                {
                    columnCode: "phone",
                    columnName: "登录账号",
                    columnWidth: "12%"
                },
                {
                    columnCode: "realName",
                    columnName: "用户名称",
                    customElement: "<span class='real_name' data-phone=\"#phone#\" data-realname=\"#realName#\" data-userid=\"#userId#\">#realName#</span>",
                    columnWidth: "12%"
                },
                {
                    columnCode: "totalMoney",
                    columnName: "总金额",
                    sortDataType: "float",
                    customVal: {"is-null": "￥0.00", "non-null": "￥?"}
                },
                {
                    columnCode: "actualMoney",
                    columnName: "充值余额",
                    sortDataType: "float",
                    customVal: {"is-null": "￥0.00", "non-null": "￥?"}
                },
                {
                    columnCode: "giftMoney",
                    columnName: "赠送余额",
                    sortDataType: "float",
                    customVal: {"is-null": "￥0.00", "non-null": "￥?"}
                },
                {
                    columnCode: "rechargeCount",
                    columnName: "充值记录",
                    columnWidth: "8%",
                    sortDataType: "int",
                    customElement: "<a href=\"javascript:;\" class=\"cs-link text-primary\" onclick=\"flow(this,\'#userId#\')\">#rechargeCount#</a>"
                },
                {
                    columnCode: "flowCount",
                    columnName: "交易记录",
                    columnWidth: "8%",
                    sortDataType: "int",
                    customElement: "<a href=\"javascript:;\" class=\"cs-link text-primary\" onclick=\"flowAll(this,\'#userId#\')\">#flowCount#</a>"
                },{
                    columnCode: "status",
                    columnName: "状态",
                    customVal: {"0": "正常", "1": "冻结"},
                    columnWidth: "5%"
                },
            ],
            funBtns: [
                {	//编辑
                    show: Permission.exist("1460-1"),
                    style: Permission.getPermission("1460-1"),
                    action: function (id) {
                        var userId = $("tr[data-rowid=" + id + "]").find(".real_name").data("userid");
                        var realName = $("tr[data-rowid=" + id + "]").find(".real_name").data("realname");
                        var phone = $("tr[data-rowid=" + id + "]").find(".real_name").data("phone");
                        addOrUpdateMoney(id, userId, realName, phone);
                    }
                },
                {	//流水
                    show: Permission.exist("1460-2"),
                    style: Permission.getPermission("1460-2"),
                    action: function (id) {
                        let userId = $("tr[data-rowid=" + id + "]").find(".real_name").data("userid");
                        showMbIframe("${webRoot}/balanceMgt/flow?isok=&userId=" + userId);
                    }
                }
            ], onload: function (rows, data) {
                var actualMoney = 0;//充值金额合计
                var giftMoney = 0;//赠送金额合计
                var totalMoney = 0;//总计
                $(rows).each(function (index, value) {
                    actualMoney += value.actualMoney;
                    giftMoney += value.giftMoney;
                });
                actualMoney = actualMoney != 0 ? actualMoney.toFixed(2) : 0;
                giftMoney = giftMoney != 0 ? giftMoney.toFixed(2) : 0;
                $("#actualMoney").html(actualMoney + "（元）");
                $("#giftMoney").html(giftMoney + "（元）");
                totalMoney = parseFloat(actualMoney) + parseFloat(giftMoney);
                totalMoney = totalMoney != 0 ? totalMoney.toFixed(2) : 0;
                $("#totalMoney").html(totalMoney + "（元）");
            }
        });
        datagrid1.query();
    }

    //查看用户基本信息
    function seeUser(userId) {
        $("#showUser").modal("show");
        $.ajax({
            url: '${webRoot}/inspUnitUser/queryByUserId',
            method: 'post',
            data: {"userId": userId},
            success: function (data) {
                if (data && data.success) {
                    let obj = data.obj;
                    $("#showUser .account").text(obj.account);
                    $("#showUser input[name='phone']").val(obj.phone);
                    $("#showUser input[name='realName']").val(obj.realName);
                    $("#showUser input[name='identifiedNumber']").val(obj.identifiedNumber);
                    $("#showUser input[name='departName']").val(obj.departName);
                    $("#showUser input[name='userType'][value=" + obj.userType + "]").prop("checked", true);
                    $("#showUser input[name='checked'][value=" + obj.checked + "]").prop("checked", true);
//                     $("#showUser input[name='type'][value=" + obj.type + "]").prop("checked", true);
                    $("#showUser input[name=creditCode]").val(obj.creditCode);
                    $("#showUser input[name=companyName]").val(obj.inspectionName);
                    //企业与个人的显示隐藏
                    showOrhide(obj.userType);
                    showAffiliation(obj.type + "");
                    $("input[name=type2]:checkbox").each(function (i, v) {
                        var t = data.obj.monitoringType + "";

                        if (t.indexOf($(this).attr("value")) == -1) {
                            $(this).removeAttr("checked");
                        } else {
                            $(this).attr("checked", "checked");
                        }
                    });
                }
            }
        });

    }
    //查看用户充值记录
    function flow(obj, userId) {
        if (obj.text != 0) {
            showMbIframe("${webRoot}/balanceMgt/flow?isok=1&userId=" + userId);
        }
    }
    //查看用户交易记录
    function flowAll(obj, userId) {
        if (obj.text != 0) {
            showMbIframe("${webRoot}/balanceMgt/flow?isok=&userId=" + userId);
        }
    }
    function showOrhide(value) {
        if (value == 1) {//企业
            $("#creditCode_ul").removeClass("hide");
            $("#companyName_ul").removeClass("hide");
            $("#identifiedNumber_ul").addClass("hide")
        } else if (value == 0) {//个人
            $("#creditCode_ul").addClass("hide");
            $("#companyName_ul").addClass("hide");
            $("#identifiedNumber_ul").removeClass("hide")
        }
    }

    function addOrUpdateMoney(id, userId, realName, phone) {
        $("input[name=id]").val(id);
        $("input[name=createBy]").val(userId);
        $("input[name=realName]").val(realName);
        $("input[name=phone]").val(phone);
        $("#addModal").modal("show");
    }

    $(function () {
        $("#btnSave").click(function () {
            $("#saveForm").submit();
        });

        //表单校验和提交
        $("#saveForm").Validform({
            tiptype: 2,
            beforeSubmit: function () {
                var formData = new FormData($('#saveForm')[0]);
                $("#btnSave").attr("disabled", "disabled");//禁用按钮
                $.ajax({
                    type: "POST",
                    url: "${webRoot}/balanceMgt/addOrUpdateMoney",
                    data: formData,
                    contentType: false,
                    processData: false,
                    dataType: "json",
                    success: function (data) {
                        if (data && data.success) {
                            $("#addModal").modal("hide");
                            datagridUtil.queryByFocus();
                        } else {
                            $("#addModal").modal("hide");
                            $("#waringMsg>span").html(data.msg);
                            $("#confirm-warnning").modal('toggle');
                            $("#btnSave").removeAttr("disabled");//启用按钮
                        }
                    }
                });
                return false;
            }
        });

        //清空模态框输入框
        $('#addModal').on('hidden.bs.modal', function () {
            $("#saveForm").form("reset");
            $("#btnSave").removeAttr("disabled");//启用按钮
        });
    });

    //键盘弹起事件onkeyup="clearNoNum(this)";
    function clearNoNum(obj) {
        //先把非数字的都替换掉，除了数字和.
        obj.value = obj.value.replace(/[^\d.]/g, "");
        //必须保证第一个为数字而不是.
        obj.value = obj.value.replace(/^\./g, "");
        //保证只有出现一个.而没有多个.
        obj.value = obj.value.replace(/\.{2,}/g, ".");
        //超出3位小数就替换为空
        obj.value = obj.value.replace(/(\d*\.?\d{0,2})?.*$/, '$1');
        //obj.value = obj.value.replace(/^\D*([1-9]\d*\.?\d{0,2})?.*$/,'$1');
        //保证.只出现一次，而不能出现两次以上
        obj.value = obj.value.replace(".", "$#$").replace(/\./g, "")
            .replace("$#$", ".");
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
    }
</script>
</body>
</html>
