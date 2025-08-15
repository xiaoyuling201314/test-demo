<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/WEB-INF/view/common/resource.jsp" %>
<link rel="stylesheet" href="${webRoot}/js/Select2-4.0.2/css/select2.min.css">
<html>
<head>
    <title>快检服务云平台</title>
    <style>
        .cs-content2 .cs-in-style {
            width: 268px;
        }

        .cs-ul-form .cs-in-style input[type=text] {
            width: 262px;
        }
    </style>
</head>
<body>

<div id="dataList"></div>
<div class="modal fade intro2" id="addDepartModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog cs-lg-width" role="document">
        <div class="modal-content ">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="addDepartModalLabel">新增检测机构</h4>
            </div>
            <div class="modal-body cs-lg-height">
                <!-- 主题内容 -->
                <form id="addDepartForm" method="post" autocomplete="off">
                    <input type="hidden" name="departPid" value="1"/>
                    <input type="hidden" name="id"/>
                    <input type="hidden" name="dmId" id="dmId"/>
                    <input type="hidden" name="deleteFlag" value="0"/>
                    <input type="hidden" name="departCode"/>
                    <input type="hidden" name="lat" id="lat"/>
                    <input type="hidden" name="lng" id="lng"/>
                    <input type="hidden" name="regionId" value="1,,,,"/>
                    <div class="cs-tabcontent">
                        <div class="cs-content2">
                            <div class="col-xs-12 col-md-12 cs-monitor-box">
                                <div class="cs-fl cs-warn-r  cs-in-style2">
                                    <ul class="cs-ul-form col-xs-12 col-md-12 clearfix">
                                        <li class="cs-name col-xs-3 col-md-3"><i class="cs-mred">*</i>企业名称：</li>
                                        <li class="col-xs-4 col-md-4 cs-in-style">
                                            <input type="text" name="departName" datatype="*" nullmsg="请输入企业名称"
                                                   width="250px"
                                                   errormsg="请输入企业名称"/>
                                        </li>
                                        <li class="col-xs-4 col-md-4 cs-text-nowrap">
                                            <div class="Validform_checktip"></div>
                                        </li>
                                    </ul>
                                    <ul class="cs-ul-form col-xs-12 col-md-12 clearfix">
                                        <li class="cs-name col-xs-3 col-md-3"><i class="cs-mred">*</i>使用期限：</li>
                                        <li class="col-xs-7 col-md-7 cs-in-style" style="width: 268px;">
                                            <input name="startDate" id="start" class="cs-time" type="text"
                                                   onClick="WdatePicker({maxDate:'#F{$dp.$D(\'end\')}',dateFmt:'yyyy-MM-dd',onpicked:selectDate})"
                                                   datatype="myDate" nullmsg="请选择使用期限" errormsg="请选择使用期限"
                                                   style="width: 120px"/>
                                            至
                                            <input name="endDate" id="end" class="cs-time" type="text"
                                                   onClick="WdatePicker({minDate:'#F{$dp.$D(\'start\')}',dateFmt:'yyyy-MM-dd',onpicked:selectDate})"
                                                   datatype="myDate" nullmsg="请选择使用期限" errormsg="请选择使用期限"
                                                   ondurationchange="changeDate()"
                                                   style="width: 120px"/>
                                        </li>
                                        <li class="col-xs-2 col-md-2 cs-text-nowrap">
                                            <div id="data_error" class="Validform_checktip">请选择使用期限</div>
                                        </li>
                                        <script>
                                            //选中日期后把其隐藏起来
                                            function selectDate() {
                                                if ($("#start").val() && $("#end").val()) {
                                                    $("#data_error").attr("class", "Validform_checktip");
                                                } else {
                                                    $("#data_error").attr("class", "Validform_checktip Validform_wrong");
                                                }
                                            }

                                            function changeDate() {
                                                console.log($("#start").val());
                                                console.log($("#end").val())
                                            }
                                        </script>
                                    </ul>
                                    <ul class="cs-ul-form col-xs-12 col-md-12 clearfix">
                                        <li class="cs-name col-xs-3 col-md-3"><i class="cs-mred">*</i>负责人：</li>
                                        <li class="col-xs-4 col-md-4 cs-in-style">
                                            <input type="text" name="person" datatype="*" nullmsg="请输入负责人"
                                                   errormsg="请输入负责人"/>
                                        </li>
                                        <li class="col-xs-4 col-md-4 cs-text-nowrap">
                                            <div class="Validform_checktip"></div>
                                        </li>
                                    </ul>
                                    <ul class="cs-ul-form col-xs-12 col-md-12 clearfix">
                                        <li class="cs-name col-xs-3 col-md-3">手机号码：</li>
                                        <li class="col-xs-4 col-md-4 cs-in-style">
                                            <input type="text" name="mobilePhone" datatype="phone"
                                                   nullmsg="请输入正确的手机号码" errormsg="请输入正确的手机号码"/>
                                        </li>
                                        <li class="col-xs-4 col-md-4 cs-text-nowrap">
                                            <div class="Validform_checktip"></div>
                                        </li>
                                    </ul>
                                    <ul class="cs-ul-form col-xs-12 col-md-12 clearfix">
                                        <li class="cs-name col-xs-3 col-md-3">企业地址：</li>
                                        <li class="col-xs-4 col-md-4 cs-in-style">
                                            <input type="text" name="address" id="address"/>
                                        </li>
                                    </ul>
                                    <ul class="cs-ul-form col-xs-12 col-md-12 clearfix">
                                        <li class="cs-name col-xs-3 col-md-3">企业描述：</li>
                                        <li class="col-xs-4 col-md-4 cs-in-style">
                                            <textarea type="text" name="description" style="width:262px"></textarea>
                                        </li>
                                    </ul>

                                   <%-- <ul class="cs-ul-form col-xs-12 col-md-12 clearfix">
                                        <li class="cs-name col-xs-3 col-md-3">启用停用：</li>
                                        <li class="col-xs-4 col-md-4 cs-check-radio cs-li-radio">
                                            <input id="yes" type="radio" name="state" value="0" checked="checked">
                                            <label for="yes">启用</label>
                                            <input id="no" type="radio" name="state" value="1">
                                            <label for="no">停用</label>
                                        </li>
                                        <li class="col-xs-4 col-md-4 cs-text-nowrap"></li>
                                    </ul>--%>
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-success" id="btnSave">确定</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
            </div>
        </div>
    </div>
</div>
<!-- 新增企业模态框_end   -->


<!-- 设置企业有效时间模态框_start -->
<%--<div class="modal fade intro2" id="setTimeModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog cs-mid-width" role="document">
        <div class="modal-content ">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">修改</h4>
            </div>
            <div class="modal-body cs-mid-height">
                <!-- 主题内容 -->
                <form id="setTimeForm" method="post" autocomplete="off">
                    <input type="hidden" name="id">
                    <div class="cs-tabcontent">
                        <div class="cs-content2">
                            <div class="col-xs-12 col-md-12 cs-monitor-box">
                                <div class="cs-fl cs-warn-r  cs-in-style2">
                                    <ul class="cs-ul-form col-xs-12 col-md-12 clearfix">
                                        <li class="cs-name col-xs-3 col-md-3"><i class="cs-mred">*</i>开始时间：</li>
                                        <li class="col-xs-4 col-md-4 cs-in-style">
                                            <input name="startDate" id="start" class="cs-time" type="text"
                                                   onClick="WdatePicker({maxDate:'#F{$dp.$D(\'end\')}',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true})"
                                                   datatype="*" nullmsg="请选择开始时间" errormsg="请选择开始时间"/>
                                        </li>
                                        <li class="col-xs-4 col-md-4 cs-text-nowrap">
                                            <div class="Validform_checktip"></div>
                                        </li>
                                    </ul>
                                    <ul class="cs-ul-form col-xs-12 col-md-12 clearfix">
                                        <li class="cs-name col-xs-3 col-md-3"><i class="cs-mred">*</i>结束时间：</li>
                                        <li class="col-xs-4 col-md-4 cs-in-style">
                                            <input name="endDate" id="end" class="cs-time" type="text"
                                                   onClick="WdatePicker({minDate:'#F{$dp.$D(\'start\')}',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true})"
                                                   datatype="*" nullmsg="请选择结束时间" errormsg="请选择结束时间"/>
                                        </li>
                                        <li class="col-xs-4 col-md-4 cs-text-nowrap">
                                            <div class="Validform_checktip"></div>
                                        </li>
                                    </ul>
                                    <ul class="cs-ul-form col-xs-12 col-md-12 clearfix">
                                        <li class="cs-name col-xs-3 col-md-3">备注信息：</li>
                                        <li class="col-xs-4 col-md-4 cs-in-style">
                                            <textarea rows="" cols="" name="remark" style="height: 80px;"></textarea>
                                        </li>
                                    </ul>
                                </div>
                                <ul class="cs-ul-form col-xs-12 col-md-12 clearfix">
                                    <li class="cs-name col-xs-3 col-md-3">是否启用：</li>
                                    <li class="col-xs-4 col-md-4 cs-check-radio cs-li-radio">
                                        <input id="yes" type="radio" name="state" value="0" checked="checked">
                                        <label for="yes">启用</label>
                                        <input id="no" type="radio" name="state" value="1">
                                        <label for="no">不启用</label>
                                    </li>
                                    <li class="col-xs-4 col-md-4 cs-text-nowrap"></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-success" id="btnSetTime">确定</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
            </div>
        </div>
    </div>
</div>--%>

<%--配置弹窗——start --%>
<div class="modal fade intro2" id="temConfigModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
     aria-hidden="true" data-backdrop="static" style="display: none;">
    <div class="modal-dialog cs-xlg-width" role="document">
        <div class="modal-content" style="margin-top: 0px;">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">×</span></button>
                <h4 class="modal-title" id="myModalLabel">请选择检测报告模板</h4>
            </div>
            <div class="modal-body cs-xlg-height">
                <!-- 主题内容 -->
                <div class="cs-points-list" style="width: 49.5%">
                    <div class="cs-mechanism-list-content" style="padding:0;height: 418px;">
                        <div class="cs-mechanism-table-box">
                            <table class="cs-mechanism-table" width="100%">
                                <thead>
                                <tr>
                                    <th style="width:60px;">
                                        <div class="cs-num-cod">
                                            <%--<input type="checkbox" id="checkTemAll">--%>
                                        </div>
                                    </th>
                                    <th style="width:80%;">模板名称</th>
                                </tr>
                                </thead>
                                <tbody id="temDataList">
                                <tr>
                                    <td>
                                        <div class="cs-num-cod">
                                            <input name="checkTem" type="checkbox">
                                            <span class="rowNo">1</span>
                                        </div>
                                    </td>
                                    <td>广州市食品药品监督局</td>
                                </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                <div class="cs-secleted-list" style="width: 49.5%">
                    <div class="cs-mechanism-list-content"
                         style="height: 100%;display: flex;justify-content: center;align-items: center;">
                        <img id="temImg"/>
                    </div>
                </div>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-success" id="btnSave2" onclick="saveTem()">确定</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
            </div>
        </div>
    </div>
</div>
<!-- 设置企业有效时间模态框_end   -->
<%@include file="/WEB-INF/view/common/confirm.jsp" %>
<%@include file="/WEB-INF/view/common/modalBox.jsp" %>
<script src="${webRoot}/js/select/tabcomplete.min.js"></script>
<script src="${webRoot}/js/select/livefilter.min.js"></script>
<script src="${webRoot}/js/select/bootstrap-select.js"></script>
<script src="${webRoot}/js/datagridUtil2.js"></script>
<script src="${webRoot}/js/jquery.form.js"></script>
<%--<script type="text/javascript"
        src="http://api.map.baidu.com/api?type=webgl&v=3.0&ak=3VcDe6wDBzTnPp718D2O49QxfByP7e0W"></script>--%>
<script type="text/javascript">
    //创建地址解析器实例
    //var myGeo = new BMapGL.Geocoder();
    //进入界面加载数据
    $(function () {
        var dgu = datagridUtil.initOption({
            tableId: "dataList",
            tableAction: "${webRoot}/depart/manage/datagrid",
            tableBar: {
                title: ["企业管理", "企业管理"],
                hlSearchOff: 0,
                ele: [{
                    eleShow: 0,
                    eleType: 4,
                    eleHtml: "<span class=\"check-date cs-fl\">" +
                    "<span class=\"cs-name\" style=\"padding-right: 0px;\">所属企业：</span>" +
                    "<div class=\"cs-all-ps\">\n" +
                    "            <div class=\"cs-input-box\">\n" +
                    "                <input type=\"text\" name=\"departNames\" autocomplete=\"off\">\n" +
                    "                <div class=\"cs-down-arrow\"></div>\n" +
                    "            </div>\n" +
                    "            <div class=\"cs-check-down cs-hide\" style=\"display: none;\">\n" +
                    "                <ul id=\"tree\" class=\"easyui-tree\"></ul>\n" +
                    "            </div>\n" +
                    "        </div>" +
                    "</span>"
                }, {
                    eleShow: 1,
                    eleName: "keyWords",
                    eleType: 0,
                    elePlaceholder: "企业名称、负责人、联系方式"
                }],
                topBtns: [{
                    show: Permission.exist("1519-1"),
                    style: Permission.getPermission("1519-1"),
                    action: function (ids, rows) {
                        getId();
                    }
                }],
                init: function () {
                    //选择行政区
                    $('#tree').tree({
                        checkbox: false,
                        url: "${webRoot}/detect/depart/getDepartTree.do",
                        animate: true,
                        onLoadSuccess: function (node, data) {
                            if (data.length > 0) {
                                $("input[name='departNames']").val(data[0].text);
                            }
                        },
                        onClick: function (node) {
                            var did = node.id;
                            $("input[name='departNames']").val(node.text);
                            $(".cs-check-down").hide();
                            dgu.addDefaultCondition("departId", did);
                            dgu.queryByFocus();
                        }
                    });
                }
            },
            parameter: [
                {
                    columnCode: "departName",
                    columnName: "企业名称",
                    columnWidth: "22%",
                },
                {
                    columnCode: "person",
                    columnName: "负责人",
                    columnWidth: "8%",
                },
                {
                    columnCode: "mobilePhone",
                    columnName: "联系方式",
                    columnWidth: "11%",
                },
                {
                    columnCode: "pointNumbers",
                    columnName: "检测点",
                    sortDataType: "int",
                    customElement: '<a class="text-primary cs-link show_point" data-id="#id#" data-name="#departName#">#pointNumbers#</a>',
                    columnWidth: "80px"
                },
                {
                    columnCode: "deviceNumbers",
                    columnName: "仪器数量",
                    sortDataType: "int",
                    customElement: '<span>#deviceNumbers#</span>',
                    columnWidth: "80px"
                },
                {
                    columnCode: "userNumbers",
                    columnName: "用户数量",
                    sortDataType: "int",
                    customElement: '<a class="text-primary cs-link show_user" data-id="#id#" data-name="#departName#">#userNumbers#</a>',
                    columnWidth: "80px"
                },
                {
                    columnCode: "createDate",
                    columnName: "创建时间",
                    columnWidth: "9%",
                    dateFormat: "yyyy-MM-dd HH:mm:ss"
                },
                {
                    columnCode: "startDate",
                    columnName: "开始时间",
                    columnWidth: "9%",
                    dateFormat: "yyyy-MM-dd HH:mm:ss"
                },
                {
                    columnCode: "endDate",
                    columnName: "结束时间",
                    columnWidth: "9%",
                    dateFormat: "yyyy-MM-dd HH:mm:ss"
                },
                {
                    columnCode: "state",
                    columnName: "状态",
                    customVal: {0: "<span class='text-success'>启用</span>", 1: "<span class='text-danger'>停用</span>"},
                    columnWidth: "60px"
                }
            ],
            funBtns: [
                {//编辑
                    show: Permission.exist("1519-2"),
                    style: Permission.getPermission("1519-2"),
                    action: function (id, row) {
                        $("#addDepartModal").modal("show");
                        $("#dmId").val(row.dmId);
                        getId(id);
                    }
                },
                {//设置
                    show: 0,//Permission.exist("1519-3"),
                    style: Permission.getPermission("1519-3"),
                    action: function (id, row) {
                        $("#setTimeForm input[name=id]").val(row.dmId);
                        $("#setTimeModal").modal("show");
                    }
                },
                {//操作记录
                    show: Permission.exist("1519-4"),
                    style: Permission.getPermission("1519-4"),
                    action: function (id, row) {
                        showMbIframe("${webRoot}/depart/manage/log/list?id=" + row.dmId);
                    }
                },
                {//模板配置
                    show: Permission.exist("1519-6"),
                    style: Permission.getPermission("1519-6"),
                    action: function (id, row) {
                        <%--showMbIframe("${webRoot}/depart/manage/log/list?id=" + row.dmId);--%>
                        $("#temConfigModal").modal("show");
                        dataGridTem(id);
                    }
                }
            ]
        });
        dgu.queryByFocus();
    });

    $(function () {
        let $btnSave = $("#btnSave");
        $btnSave.on("click", function () {
            $("#addDepartForm").submit();
        });
        $("#addDepartForm").Validform({
            tiptype: 2,
            datatype: {//传入自定义datatype类型，可以是正则，也可以是函数（函数内会传入一个参数）;
                "phone": function (gets, obj, curform, regxp) {
                    //参数gets是获取到的表单元素值，obj为当前表单元素，curform为当前验证的表单，regxp为内置的一些正则表达式的引用;
                    var reg1 = /^1[3456789]\d{9}$/;
                    if (gets == "" || reg1.test(gets)) {
                        return true;
                    }
                    return false;
                    //注意return可以返回true 或 false 或 字符串文字，true表示验证通过，返回字符串表示验证失败，字符串作为错误提示显示，返回false则用errmsg或默认的错误提示;
                },
                "myDate": function () {
                    if ($("#start").val() && $("#end").val()) {
                        return true;
                    }
                    return false;
                }
            },
            beforeSubmit: function (curform) {//判断密码是否被修改过；若没有则设置密码为空不进行修改
                $btnSave.attr("disabled", "disabled");
                // 将地址解析结果的经纬度设置进入lat和lng
                var formData = new FormData($('#addDepartForm')[0]);
                console.log('提交表单！');
                $.ajax({
                    type: "POST",
                    url: "${webRoot}/depart/manage/save.do",
                    data: formData,
                    contentType: false,
                    processData: false,
                    dataType: "json",
                    success: function (data) {
                        $btnSave.removeAttr("disabled");
                        if (data && data.success) {
                            $("#addDepartModal").modal("hide");
                            datagridUtil.query();
                        } else {
                            $("#waringMsg>span").html(data.msg);
                            $("#confirm-warnning").modal('toggle');
                        }
                    }, error: function () {
                        $btnSave.removeAttr("disabled");
                        $("#waringMsg>span").html("请求失败！");
                        $("#confirm-warnning").modal('toggle');
                    }
                });
                return false;
            }
        });

        $("[datatype]").focusin(function () {
            if (this.timeout) {
                clearTimeout(this.timeout);
            }
            var infoObj = getInfoObj.call(this);
            if (infoObj.siblings(".Validform_right").length != 0) {
                return;
            }
            infoObj.show().siblings().hide();

        }).focusout(function () {
            var infoObj = getInfoObj.call(this);
            this.timeout = setTimeout(function () {
                infoObj.hide().siblings(".Validform_wrong,.Validform_loading").show();
            }, 0);

        });

        function getInfoObj() {
            return $(this).parents("li").next().find(".info");
        }

        //关闭编辑模态框前重置表单，清空隐藏域
        $('#addDepartModal').on('hidden.bs.modal', function (e) {
            $("#btnSave").removeAttr("disabled");
            /* $("#addDepartForm").resetForm();
             $("input[name=id]").val("");*/

            var form = $("#addDepartForm");// 清空表单数据
            form.form("reset");
            $("input[name=id]").val("");
            $("#addDepartForm").Validform().resetForm();
            $("input").removeClass("Validform_error");
            //$(".Validform_wrong").hide();
            //$(".Validform_checktip").hide();
            //$(".info").show();

        });

        //===============设置时间_start=================
        $("#setTimeModal").on('show.bs.modal', function (e) {
            $("#setTimeForm").Validform().resetForm();
        });

        let $btnSetTime = $("#btnSetTime");
        $btnSetTime.on("click", function () {
            $("#setTimeForm").submit();
        });

        var setTimeForm = $("#setTimeForm").Validform({
            tiptype: 2,
            beforeSubmit: function (curform) {
                $btnSetTime.attr("disabled", "disabled");
                $("#setTimeModal").modal("hide");
                $("#setTimeForm").ajaxSubmit({
                    type: 'post',
                    url: " ${webRoot}/depart/manage/setTime",
                    success: function (data) {
                        $btnSetTime.removeAttr("disabled");
                        if (data.success) {
                            $("#setTimeModal").modal("hide");
                            datagridUtil.query();
                        } else {
                            $("#waringMsg>span").html(data.msg);
                            $("#confirm-warnning").modal('toggle');
                        }
                    }, error: function () {
                        $btnSetTime.removeAttr("disabled");
                        $("#waringMsg>span").html("请求失败！");
                        $("#confirm-warnning").modal('toggle');
                    }
                });
                return false;
            }
        });
        //===============设置时间_end  =================
    });


    /**
     * 查询用户信息
     */
    function getId(id) {
        if (id) {
            $.ajax({
                type: "POST",
                url: "${webRoot}/depart/manage/queryById.do",
                data: {"id": id},
                dataType: "json",
                success: function (data) {
                    if (data && data.success) {
                        let obj = data.obj;
                        if (obj) {
                            let form = $('#addDepartForm');
                            form.form('load', data.obj);
                        }
                    }
                }
            });
            $("#addDepartModal .modal-title").text("编辑企业");
        } else {
            let now = new Date();
            $("#start").val(now.format("yyyy-MM-dd"));
            now.setFullYear(now.getFullYear() + 1);
            $("#end").val(now.format("yyyy-MM-dd"));
            $("#addDepartModal .modal-title").text("新增企业");
        }
        $("#addDepartModal").modal("show");

    }

    /*    $("#address").blur(function () {
            if (this.value && this.value.length > 4) {
                myGeo.getPoint(this.value, function (point) {
                    if (point) {
                        console.log(point);
                        //设置经纬度
                        $("#lat").val(point.lat);
                        $("#lng").val(point.lng);
                    } else {
                        console.log('地址解析失败！');
                    }
                });
            }
        });*/

    $(document).on("click", ".show_point", function () {
        showMbIframe("${webRoot}/depart/manage/point?departId=" + $(this).data("id") + "&departName=" + encodeURI($(this).data("name")));
    });
    $(document).on("click", ".show_user", function () {
        showMbIframe("${webRoot}/depart/manage/user_list?departId=" + $(this).data("id") + "&departName=" + encodeURI($(this).data("name")));
    })

    let temList = [];//模板数据集合
    let selectEtpId;
    function dataGridTem(etpId) {
        selectEtpId = etpId;
        $.ajax({
            url: "${webRoot}/report/template/datagrid",
            method: 'POST',
            data: {"pageSize": 100, "pageNo": 1, "enterpriseId": etpId},
            dataType: 'json',
            success: function (data) {
                if (data && data.success) {
                    //获取默认模板
                    let detaultTem = data.attributes.etc;
                    let detaultId = detaultTem.id;
                    let dataList = data.obj.results;
                    $("#temDataList").empty();//先清空数据列表
                    if (dataList && dataList.length) {
                        let html = '';
                        temList = dataList;
                        console.log("666",temList)
                        for (let i = 0; i < dataList.length; i++) {
                            let item = dataList[i];
                            if (detaultId === item.id) {
                                showTem(item);
                            }
                            html += ` <tr>
                                        <td>
                                                <label>
                                            <div class="cs-num-cod">
                                                <input name="checkTem" value="` + item.id + `" onchange="checkedTem(this,` + i + `)" type="checkbox"` + (detaultId === item.id ? `checked` : ``) + `>
                                                <span class="rowNo">` + (i + 1) + `</span>
                                            </div>
                                                 </label>
                                        </td>
                                        <td>` + item.templateName +`</td>
                                < /tr>`;
                        }

                        $("#temDataList").append(html);
                    }
                } else {
                    layer.msg(data.msg, {icon: 2});
                }
            }, error: function () {
                layer.msg("请求失败", {icon: 2});
            }
        });
    }
    //保存企业模板配置
    function saveTem() {
        $("#btnSave2").attr("disabled", "disabled");
        let temId = $("input[name=checkTem]:checked").val();
        if (!temId) {
            layer.msg("模板ID不能为空", {icon: 7});
        }
        $.ajax({
            url: "${webRoot}/enterprise/config/saveOrUpdate",
            method: 'POST',
            data: {
                "templateId": temId,
                "enterpriseId": selectEtpId
            },
            dataType: 'json',
            success: function (data) {
                $("#btnSave2").removeAttr("disabled");
                if (data && data.success) {
                    $("#temConfigModal").modal("hide");
                } else {
                    layer.msg(data.msg, {icon: 2});
                }
            }, error: function () {
                $("#btnSave2").removeAttr("disabled");
                layer.msg("请求失败", {icon: 2});
            }
        });
    }
    //显示右边模板图片方法
    function showTem(temObj) {
        let src = temObj.previewImage;
        src = "${webRoot}/resources/" + src;
        let styleArr = [70, 90];//默认设置为70*90的宽高
        styleArr = temObj.pageSize ? temObj.pageSize.split("*") : styleArr;
        let style = "width: " + styleArr[0] + "%;height: " + styleArr[1] + "%";
        $("#temImg").attr("src", src).attr("style", style);
    }
    //绑定并改变为单选事假
    function checkedTem(o, index) {
        //先把所有的改成不选中
        $("input[name=checkTem]").prop("checked", false);
        //然后把当前改成选中
        $(o).prop("checked", true);
        showTem(temList[index]);
    }
</script>
</body>
</html>
