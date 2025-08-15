<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/WEB-INF/view/common/resource.jsp" %>
<html>
<head>
    <title>快检服务云平台</title>
    <style>
        .error {
            background-color: #ffe7e7;
        }

        .width-input input[type=text] {
            width: 300px;
        }
    </style>
</head>
<body>
<div id="dataList"></div>


<div class="modal fade intro2" id="sendSmsModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog cs-lg-width" role="document">
        <div class="modal-content ">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title">发送短信通知</h4>
            </div>
            <div class="modal-body cs-lg-height">
                <!-- 主题内容 -->
                <div class="cs-tabcontent">
                    <div class="cs-content2">
                        <form id="saveForm" method="post" autocomplete="off">
                            <input type="hidden" name="id">
                            <div width="100%" class="cs-add-new width-input">
                                <ul class="cs-ul-form clearfix">
                                    <li class="cs-name col-md-3 col-xs-3 " width="20% "><b class="text-danger">*</b>检测点名称：
                                    </li>
                                    <li class="cs-in-style cs-modal-input" style="width: 310px;">
                                        <input type="text" name="name" onkeyup="setName(this)"
                                               onblur="setName(this)" maxlength="100">
                                    </li>
                                    <li class="col-xs-3 col-md-3 cs-text-nowrap">
                                        <div class="Validform_checktip"></div>
                                    </li>
                                </ul>
                                <ul class="cs-ul-form clearfix">
                                    <li class="cs-name col-xs-3 col-md-3"><b class="text-danger">*</b>手机号码：</li>
                                    <li class="cs-in-style  col-xs-5 col-md-5" style="width: 330px;">
                                        <input type="text" name="phone" onkeyup="myClearForeZero(this)"
                                               onblur="myClearForeZero(this)">
                                        <a onclick="addHtml()">
                                            <i class="text-primary iconfont icon-zengjia2" title="添加"
                                               style="font-size: 20px;">
                                            </i>
                                        </a>
                                    </li>
                                    <li class="col-xs-3 col-md-3 cs-text-nowrap">
                                        <div class="Validform_checktip"></div>
                                    </li>
                                </ul>
                                <span id="phone"></span>
                                <ul class="cs-ul-form clearfix">
                                    <li class="cs-name col-md-3 col-xs-3 " width="20% "><b class="text-danger">*</b>不合格条数：
                                    </li>
                                    <li class="cs-in-style cs-modal-input" style="width: 310px;">
                                        <input type="text" name="number" onkeyup="myClearForeZero(this)"
                                               onblur="myClearForeZero(this)" value="1">
                                    </li>
                                    <li class="col-xs-3 col-md-3 cs-text-nowrap">
                                        <div class="Validform_checktip"></div>
                                    </li>
                                </ul>
                                <%--<ul class="cs-ul-form clearfix">--%>
                                <%--<li class="cs-name col-md-3 col-xs-3 " width="20% ">备注信息：</li>--%>
                                <%--<li class="cs-in-style cs-modal-input" width="210px">--%>
                                <%--<textarea class="cs-remark" name="remark" cols="30" rows="10"></textarea>--%>
                                <%--</li>--%>
                                <%--</ul>--%>
                                <ul class="cs-ul-form clearfix">
                                    <li class="cs-name col-md-3 col-xs-3 " width="20% ">短信模板：</li>
                                    <li class="cs-in-style cs-modal-input" style="width: 310px;">
                                        【中检达元】<span id="name">XX检测点</span> 出现<span id="number">1</span>条检测不合格，请登录平台进行处理！
                                    </li>
                                </ul>
                            </div>
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


<div class="modal fade intro2" id="confirm-warnning" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
     aria-hidden="true">
    <div class="modal-dialog cs-alert-width">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title">提示</h4>
            </div>
            <div class="modal-body cs-alert-height cs-dis-tab">
                <div class="cs-text-algin" id="waringMsg">
                    <img src="${webRoot}/img/warn.png" width="40px" alt="" id="myMsgImg"/>
                    <span class="tips">
                    </span>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-success btn-ok" data-dismiss="modal">关闭</button>
            </div>
        </div>
    </div>
</div>

<%--<div class="modal fade intro2" id="confirm-ok" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
     aria-hidden="true">
    <div class="modal-dialog cs-alert-width">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title">提示</h4>
            </div>
            <div class="modal-body cs-alert-height cs-dis-tab">
                <div class="cs-text-algin" id="okMsg">
                    <img src="${webRoot}/img/sure.png" width="40px" alt=""/>
                    <span class="tips"></span>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-success btn-ok" data-dismiss="modal">关闭</button>
            </div>
        </div>
    </div>
</div>--%>
<%@include file="/WEB-INF/view/common/modalBox.jsp" %>
<script src="${webRoot}/js/datagridUtil2.js"></script>
<script type="text/javascript">

    var datagrid1 = datagridUtil.initOption({
        tableId: "dataList",
        tableAction: "${webRoot}/dataCheck/unqualified/recording/datagrid.do",
        tableBar: {
            title: ["不合格处理", "短信通知"],
            hlSearchOff: 0,
            ele: [
                {
                    eleShow: Permission.exist("381-5"),
                    eleType: 4,
                    eleHtml: "<span class=\"check-date cs-fl\">" +
                    "<span class=\"cs-name\" style=\"padding-right: 0px;\">监管类型：</span>" +
                    "<span class=\"cs-input-style \" style=\"margin-left: 0px;\">" +
                    "<input type=\"hidden\" name=\"regTypeId\" value=\"\" id=\"regTypeIds\" class=\"focusInput\"/>" +
                    "<input type=\"text\" name=\"regTypeName\" class=\"choseRegType\" value=\"--全部--\" autocomplete=\"off\" style=\"width: 110px\" readonly/>" +
                    "</span>" +
                    "</span>"
                }, {
                    eleTitle: "发送状态",
                    eleName: "sendState",
                    eleType: 2,
                    eleOption: [
                        {"text": "--全部--", "val": ""},
                        {"text": "待发", "val": "0"},
                        {"text": "成功","val": "1"},
                        {"text": "失败", "val": "2"}
                    ],
                    eleStyle: "width:85px;"
                }, {
                    eleShow: 1,
                    eleTitle: "范围",
                    eleName: "treatmentDate",
                    eleType: 3,
                    eleStyle: "width:110px;",
                    eleDefaultDateMin: new newDate().DateAdd("m", -1).format("yyyy-MM-dd"),
                    eleDefaultDateMax: new newDate().format("yyyy-MM-dd")
                }, {
                    eleShow: 1,
                    eleName: "keyWords",
                    eleType: 0,
                    elePlaceholder: "样品编号、被检单位、档口编号、样品名称、检测项目"
                }]
        },
        parameter: [
            {
                columnCode: "rid",
                columnName: "编号",
                columnWidth: "90px",
                customElement: "<a class='text-primary cs-link check_reding_id'>?<a>",
            },
            {
                columnCode: "pointName",
                columnName: "检测点",
                columnWidth: "10%"
            },
            {
                columnCode: "regName",
                columnName: "被检单位",
                columnWidth: "10%"
            },
            {
                columnCode: "regUserName",
                columnName: "${systemFlag}" === "1" ? "摊位编号" : "档口编号",
                columnWidth: "7%"
            },
            {
                columnCode: "foodName",
                columnName: "样品名称",
                columnWidth: "8%"
            },
            {
                columnCode: "itemName",
                columnName: "检测项目",
                columnWidth: "12%"
            },
            {
                columnCode: "checkResult",
                columnName: "检测值",
                show:2,
                columnWidth: "70px"
            },
            {
                columnCode: "conclusion",
                columnName: "检测结果",
                customVal: {
                    "不合格": "<div class=\"text-danger\">不合格</div>",
                    "合格": "<div class=\"text-success\">合格</div>"
                },
                columnWidth: "80px"
            },
            {
                columnCode: "checkDate",
                columnName: "检测时间",
                columnWidth: "8%"
            },
            {
                columnCode: "sendState",
                columnName: "状态",
                customVal: {
                    "0": "<div class=\"text-default\">待发</div>",
                    "1": "<div class=\"text-success\">成功</div>",
                    "2": "<div class=\"text-danger\">失败</div>",

                },
                columnWidth: "60px"
            }, {
                columnCode: "param1",
                columnName: "删除",
                customVal: {
                    "0": "<div class=\"text-default\">未删除</div>",
                    "1": "<div class=\"text-danger\">已删除</div>",
                },
                columnWidth: "60px"
            },
        ],
        funBtns: [
            {
                //发送短信
                show: Permission.exist("1522-1"),
                style: Permission.getPermission("1522-1"),
                action: function (id, row) {
                    $("input[name=id]").val(id);
                    $("input[name=name]").val(row.pointName);
                    $("#name").text(row.pointName);
                    $("#sendSmsModal").modal("show");
                }
            },
            {//操作记录
                show: Permission.exist("1522-2"),
                style: Permission.getPermission("1522-2"),
                action: function (id, row) {
                    showMbIframe("${webRoot}/dataCheck/unqualified/recording/log/list?id=" + id + "&sampleCode=" + row.sampleCode);
                }
            }, {//检测历史
                show: Permission.exist("1522-3"),
                style: Permission.getPermission("1522-3"),
                action: function (id, row) {
                    showMbIframe("${webRoot}/dataCheck/unqualified/recording/history?id=" + row.rid + "&sampleCode=" + row.sampleCode);
                }
            }
        ],
        defaultCondition: [
            {
                queryCode: "conclusion",
                queryVal: "不合格"
            }, {
                queryCode: "dataType",
                queryVal: 0
            }
        ]
    });
    datagrid1.queryByFocus();


    //添加新手机号输入框
    function addHtml() {
        if ($("input[name=phone]").length <= 8) {
            $("#phone").append(
                `<ul class="cs-ul-form clearfix">
                    <li class="cs-name col-xs-3 col-md-3"><b class="text-danger">*</b>手机号码<span class="no_index"></span>：</li>
                    <li class="cs-in-style  col-xs-5 col-md-5" style="width: 330px;">
                    <input type="text" name="phone" onkeyup="myClearForeZero(this)" onblur="myClearForeZero(this)">
                    <i class="iconfont icon-shanchu text-danger" title="删除" onclick="deleIcon(this)" style="font-size:18px;"></i>
                    </li>
                    <li class="col-xs-3 col-md-3 cs-text-nowrap">
                        <div class="Validform_checktip"></div>
                    </li>
                </ul>`
            )
        }
    }


    $(function () {
        // 点击发送短信通知
        let $btnSave = $("#btnSave");
        $btnSave.on("click", function () {
            $("#saveForm").submit();
        });

        //解决多个相同name的校验问题
        if ($.validator) {
            $.validator.prototype.elements = function () {
                let validator = this,
                    rulesCache = {};
                return $(this.currentForm)
                    .find("input, select, textarea")
                    .not(":submit, :reset, :image, [disabled]")
                    .not(this.settings.ignore)
                    .filter(function () {
                        if (!this.name && validator.settings.debug && window.console) {
                            console.error("%o has no name assigned", this);
                        }
                        rulesCache[this.name] = true;
                        return true;
                    });
            }
        }
        //校验初始化
        let myValidate = $("#saveForm").validate({
            ignore: "",//表示校验隐藏字段
            rules: {
                name: {
                    required: true,
                },
                phone: {
                    required: true,
                    phone: true,
                },
                number: {
                    required: true,
                }
            },
            messages: {　　　　//验证错误信息
                name: {
                    required: "请输入检测点名称",
                },
                phone: {
                    required: "请输入手机号码",
                    phone: "请输入正确的手机号码"
                },
                number: {
                    required: "请输入不合格条数",
                }
            },
            errorPlacement: function (error, element) {
                $(element).closest("ul").find(".Validform_checktip").addClass("Validform_wrong").text(error[0].innerHTML).next().hide();
            },
            onfocusout: function (element) {//表示失去焦点时触发校验
                $(element).valid();
            },
            success: function (label, element) {
                $(element).closest("ul").find(".Validform_checktip").removeClass("Validform_wrong").text("").next().show();
            },
            submitHandler: function (form) { //校验通过之后回调
                $btnSave.attr("disabled", "disabled");
                $.ajax({
                    type: "POST",
                    url: "${webRoot}/dataCheck/unqualified/recording/sendSms",
                    data: $("#saveForm").serialize(),
                    dataType: "json",
                    success: function (data) {
                        console.log(data);
                        $btnSave.removeAttr("disabled");
                        datagridUtil.queryByFocus();//重新加载
                        if (data && data.success) {
                            $("#sendSmsModal").modal("hide");
                            $("#myMsgImg").attr("src", "${webRoot}/img/sure.png");
                            $("#waringMsg>span").html("发送成功");
                            $("#confirm-warnning").modal('show');
                        } else {
                            if (data.msg === "发送失败") {
                                $("#myMsgImg").attr("src", "${webRoot}/img/stop2.png");
                                $("#waringMsg>span").html(getMsgHtml(data, "发送失败", true));
                                $("#confirm-warnning").modal('show');
                            } else if (data.msg === "部分号码发送成功") {
                                $("#myMsgImg").attr("src", "${webRoot}/img/warn.png");
                                $("#waringMsg>span").html(getMsgHtml(data, "部分号码发送成功", false));
                                $("#confirm-warnning").modal('show');
                            } else {
                                $("#myMsgImg").attr("src", "${webRoot}/img/stop2.png");
                                $("#waringMsg>span").html(data.msg);
                                $("#confirm-warnning").modal('show');
                            }
                        }
                    }, error: res => {
                        $("#myMsgImg").attr("src", "${webRoot}/img/warn.png");
                        $("#waringMsg>span").html("请求失败");
                        $("#confirm-warnning").modal('show');
                        $btnSave.removeAttr("disabled");
                    }
                });
            }
        });
        //手机验证规则
        $.validator.addMethod('phone', function (value, element) {
            let phone = /^1[3456789]\d{9}$/;
            return this.optional(element) || (phone.test(value));
        });
    });

    function deleIcon(obj) {
        $(obj).closest("ul").remove();
    }


    /**
     * 获取发送失败的提示html
     * @param msg 失败的提示
     * @param failAll true:全部发送失败 false 部分发送失败
     */
    function getMsgHtml(data, msg, failAll) {
        let sendOk = data.obj.sendOk;
        let sendFail = data.obj.sendFail;
        let okPhoneHtml = "";
        let failPhoneHtml = "";
        if (!failAll) {
            okPhoneHtml += "</br>手机号：";
            for (let a = 0; a < sendOk.length; a++) {
                okPhoneHtml += sendOk[a].phone;
                if (a !== (sendOk.length - 1)) {
                    okPhoneHtml += ",";
                } else {
                    okPhoneHtml += "&nbsp;发送成功";
                }
            }
        }

        for (let b = 0; b < sendFail.length; b++) {
            failPhoneHtml += "</br>手机号：" + sendFail[b].phone + "&nbsp;" + sendFail[b].msg;
        }
        return msg + okPhoneHtml + failPhoneHtml;
    }


    //去掉字符串前面的0
    function myClearForeZero(obj) {
        //先把非数字的都替换掉，除了数字和.
        obj.value = obj.value.replace(/[^\d.]/g, "");
        //保证.不能出现
        obj.value = obj.value.replace(".", "");
        //把首位出现的0替换掉
        obj.value = obj.value.replace(/\b(0+)/gi, "");
        if ($(obj).attr("name") === "number") {
            $("#number").text(obj.value);
        }
    }


    //去掉字符串前面的0
    function setName(obj) {
        $("#name").text(obj.value?obj.value:"XX检测点");
    }


    //关闭编辑模态框前重置表单，清空隐藏域
    $('#sendSmsModal').on('hidden.bs.modal', function (e) {
        $("#btnSave").removeAttr("disabled");
        $("input[name=id]").val("");
        $("input[name=name]").val("");
        $("textarea[name=remark]").val("");
        $("#phone").html("");
        $("input[name=phone]").val("");
        $("input[name=number]").val("1")
        $("#name").text("XX检测点");
    });
    //查看检测详情
    $(document).on("click", ".check_reding_id", function () {
        let rid =$(this).text();// $(this).parents(".rowTr").attr("data-rowid");
        //增加source参数，从不合格处理相关页面进入检测详情页面时，隐藏甘肃项目数据有效性判断相关功能按钮。
        showMbIframe("${webRoot}/dataCheck/recording/checkDetail.do?id=" + rid+"&source=unqualified");
    });

    /*
    2.发短信模态框备注字段不要了，里面界面也去掉，全部叫做手机号码 完成
    3.发送状态：成功 失败 待发 删除：已删除 未删除 完成
    5.按钮名称：操作日志改成短信日志 完成
    6.所有界面都是按时间进行倒序的 完成
    4.列表位置 检测点放在被检单位前面，样品编号和检测项目宽度多给一点，尽量保证两行能够显示完，压缩被检单位和检测点 完成
    7.日志界面：列名字改为：发送时间 发送详情 ，备注去掉
    9.日志界面展示：样品编号 发送详情 发送人员 发送时间，删除的操作权限去掉 完成
    1.三个界面都要样品编号，界面加上“检测值”字段 完成
    8.日志展示方式：手动/自动 2021-09-23 16:14:22 成功：[{msg=发送成功, code=0X00000, phone=17722665293}]，失败：[] 完成
    10.检测历史：关联查询，除了历史，本次的检测情况也要查询出来 完成
    2.2.模态框的input框加长，短信内容横着放长 完成
    11.发送短信图标换一个 完成
    13.发送成功的提示框去掉，太丑了 完成

    */
</script>
</body>
</html>
