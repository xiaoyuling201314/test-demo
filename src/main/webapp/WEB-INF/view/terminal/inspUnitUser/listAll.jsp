<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@include file="/WEB-INF/view/common/resource.jsp" %>

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
<script type="text/javascript" src="${webRoot}/js/datagridUtil2.js"></script>
<script type="text/javascript" src="${webRoot}/plug-in/layer/layer.js"></script>
<script type="text/javascript">
    var dgu;
    var jbstate = 1;
    $(function () {
        loadTypeChange();
    });

    function loadTypeChange() {
        dgu = datagridUtil.initOption({
            tableId: "dataList1",
            tableAction: "${webRoot}/inspUnitUser/datagrid_all",
            tableBar: {
                title: ["客户管理", "送检用户"],
                hlSearchOff: 0,
                ele: [{
                    eleTitle: "用户角色",
                    eleName: "type",
                    eleType: 2,
                    eleOption: [{"text":"--全部--","val":"-1"},{"text":"普通用户","val":"0"},{"text":"抽样人员","val":"1"},{"text":"监管方","val":"2"},{"text":"上门取样","val":"3"},{"text":"财务统计","val":"4"}],
                    eleStyle: "width:85px;margin-right: 10px;"
                }, {
                    eleShow: 1,
                    eleName: "keyWords",
                    eleType: 0,
                    elePlaceholder: "用户名、机构、检测点、监管对象"
                }],
                topBtns: [{
                    show: Permission.exist("1464-4"),
                    style: Permission.getPermission("1464-4"),
                    action: function (ids, rows) {
                        addOrUpdateUser();
                    }
                }],
            },
            defaultCondition: [ //加载条件
                {
                    queryCode: "type",
                    queryVal: $("select[name=userType]").val()
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
                    //customElement: "<a title='查看余额流水' class='text-primary cs-link account_id'>?<a>",
                    columnWidth: "12%"
                }, {
                    columnCode: "realName",
                    customStyle: 'user_name',
                    columnName: "用户姓名",
                    columnWidth: "10%"
                }, {
                    columnCode: "coldName",
                    columnName: "冷链单位",
                },{
                    columnCode: "inspectionName",
                    columnName: "经营单位/个人",
                    columnWidth: "12%",
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
                    columnWidth: "6%"
                }, {
                    show:0,
                    columnCode: "remark",
                    columnName: "备注",
                    customElement: '<a data-toggle="tooltip" data-placement="top" title="?" class="wenzi">?</a>',
                    columnWidth: "10%",
                    customStyle: 'text-left',
                },{
                    columnCode: "type",
                    columnName: "用户角色",
                    columnWidth: "80px",
                    customVal: {
                        "0": "普通用户",
                        "1": "抽样人员",
                        "2": "监管方",
                        "3": "上门取样",
                        "4": "财务统计",
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
            onload: function (rows, pageData) {
                if (rows) {
                    for (var i = 0; i < rows.length; i++) {
                        let obj=rows[i];
                        //隐藏解绑按钮
                        if (obj.openId == null || obj.openId == "") {
                            $("tr[data-rowid=" + obj.id + "]").find(".icon-jiebang").addClass('hide');
                        }
                        //隐藏清除按钮
                        if (obj.payPassword == null || obj.payPassword == "") {
                            $("tr[data-rowid=" + obj.id + "]").find(".icon-qingchu").addClass('hide');
                        }

                        if (obj.checked == 1) {//如果状态为未启用那就按钮变灰
                            $("tr[data-rowid=" + obj.id + "]").find(".icon-guanbi").removeClass("icon-duigou").addClass("icon iconfont text-del icon-guanbi").attr("title", "停用").closest("span").attr("onclick", "openStopModel(" + obj.id + "," + obj.checked + ")");
                        } else {
                            $("tr[data-rowid=" + obj.id + "]").find(".icon-guanbi").removeClass("icon-duigou text-del ").addClass("icon-duigou").attr("title", "启用").closest("span").attr("onclick", "openStopModel(" + obj.id + "," + obj.checked + ")");
                        }
                    }
                }
            }
        });
        dgu.queryByFocus();
    }

    //新增、更新用户
    function addOrUpdateUser(userId) {
        userId ? showMbIframe("${webRoot}/inspUnitUser/saveOrUpdate?id=" + userId,dgu) : showMbIframe("${webRoot}/inspUnitUser/saveOrUpdate",dgu);
    }

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
                    dgu.queryByFocus();
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

</body>
</html>
