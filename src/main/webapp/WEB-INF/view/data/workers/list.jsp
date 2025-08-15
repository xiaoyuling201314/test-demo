<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/WEB-INF/view/common/resource.jsp" %>
<html>
<head>
    <title>快检服务云平台</title>
</head>
<body>
<div class="cs-col-lg clearfix">
    <!-- 面包屑导航栏  开始-->
    <ol class="cs-breadcrumb">
        <li class="cs-fl">
            <img src="${webRoot}/img/set.png" alt=""/>
            <a href="javascript:">数据中心</a></li>
        <li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
        <li class="cs-b-active cs-fl">人员管理
        </li>
    </ol>
    <div class="cs-input-style cs-fl" style="margin:3px 0 0 30px;">
        <select class="cs-selcet-style" style="width: 80px;" id="selectedStatus" name="baseBean.status" onchange="statusChange()">
            <option value="0"> 在职</option>
            <option value="1"> 离职</option>
        </select>
    </div>
    <!-- 面包屑导航栏  结束-->
    <div class="cs-search-box cs-fr">
        <form action="datagrid.do">
            <div class="cs-search-filter clearfix cs-fl">
                <input class="cs-input-cont cs-fl focusInput" type="text" name="baseBean.workerName" id="workerName" placeholder="请输入人员名称"/>
                <input type="button" onclick="datagridUtil.queryByFocus();" class="cs-search-btn cs-fl" href="javascript:;" value="搜索">
            </div>
            <div class="clearfix cs-fr" id="showBtn">
            </div>
        </form>

    </div>
</div>
<div id="dataList"></div>
<div class="modal fade intro2" id="myModal2" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog cs-lg-width" role="document">
        <div class="modal-content ">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">新增</h4>
            </div>
            <div class="modal-body cs-lg-height">
                <!-- 主题内容 -->
                <div class="cs-tabcontent">
                    <div class="cs-content2">
                        <form id="saveForm" method="post" action="${webRoot}/data/workers/save.do">
                            <input type="hidden" name="id">
                            <div width="100%" class="cs-add-new">
                                <ul class="cs-ul-form clearfix">
                                    <li class="cs-name col-xs-3 col-md-3" width="20% ">人员名称：</li>
                                    <li class="cs-in-style cs-modal-input" width="210px">
                                        <input type="text" name="workerName" datatype="*" nullmsg="请输入人员名称" errormsg="请输入人员名称"/>
                                    </li>
                                    <li class="col-xs-4 col-md-4 cs-text-nowrap">
                                        <div class="Validform_checktip"></div>
                                        <div class="info"><i class="cs-mred">*</i>请输入用户名
                                        </div>
                                    </li>
                                </ul>
                                <ul class="cs-ul-form clearfix">
                                    <li class="cs-name col-xs-3 col-md-3" width="20% ">性别：</li>
                                    <li class="cs-al cs-modal-input">
                                        <input id="cs-check-radio" type="radio" value="0" name="gender" checked="checked"/><label
                                            for="cs-check-radio">男</label>
                                        <input id="cs-check-radio2" type="radio" value="1" name="gender"/><label for="cs-check-radio2">女</label>
                                    </li>
                                </ul>
                                <ul class="cs-ul-form clearfix">
                                    <li class="cs-name col-xs-3 col-md-3" width="20% ">手机号码：</li>
                                    <li class="cs-in-style cs-modal-input" width="210px">
                                        <input type="text" name="mobilePhone" onkeyup="clearNoNum(this)" datatype="*" nullmsg="请输入手机号码"
                                               errormsg="请输入正确的手机号码"/>
                                    </li>
                                    <li class="col-xs-4 col-md-4 cs-text-nowrap">
                                        <div class="Validform_checktip"></div>
                                        <div class="info"><i class="cs-mred">*</i>请输入手机号码
                                        </div>
                                    </li>
                                </ul>
                                <ul class="cs-ul-form clearfix">
                                    <li class="cs-name col-xs-3 col-md-3" width="20% ">职位：</li>
                                    <li class="cs-in-style cs-modal-input" width="210px">
                                        <select name="position">
                                            <option value="">---请选择职位---</option>
                                            <c:if test="${!empty position}">
                                                <c:forEach items="${position.tsTypes}" var="p">
                                                    <option value="${p.typeValue}">${p.typeName}</option>
                                                </c:forEach>
                                            </c:if>
                                        </select>
                                    </li>
                                </ul>
                                <ul class="cs-ul-form clearfix">
                                    <li class="cs-name col-xs-3 col-md-3" width="20% ">人员类型：</li>
                                    <li class="cs-in-style cs-modal-input" width="210px">
                                        <select name="jobState">
                                            <option value="正式">正式</option>
                                            <option value="实习">实习</option>
                                            <option value="试用">试用</option>
                                        </select>
                                    </li>
                                </ul>
                                <ul class="cs-ul-form clearfix">
                                    <li class="cs-name col-xs-3 col-md-3" width="20% ">状态：</li>
                                    <li class="cs-al cs-modal-input">
                                        <input id="cs-check-radio3" type="radio" value="0" name="status" checked="checked"/>
                                        <label for="cs-check-radio3">在职</label>
                                        <input id="cs-check-radio4" type="radio" value="1" name="status"/><label for="cs-check-radio4">离职</label>
                                    </li>
                                </ul>
                                <ul class="cs-ul-form clearfix">
                                    <li class="cs-name col-xs-3 col-md-3" width="20% ">证件号码：</li>
                                    <li class="cs-in-style cs-modal-input" width="210px">
                                        <input type="text" name="idNumber" datatype="/(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)/" ignore="ignore"
                                               nullmsg="请输入证件号码" errormsg="请输入正确的身份证号码"/>
                                    </li>
                                </ul>
                                <ul class="cs-ul-form clearfix">
                                    <li class="cs-name col-xs-3 col-md-3" width="20% ">办公座机：</li>
                                    <li class="cs-in-style cs-modal-input" width="210px">
                                        <input type="text" value="" name="officePhone"/>
                                    </li>
                                </ul>
                                <ul class="cs-ul-form clearfix">
                                    <li class="cs-name col-xs-3 col-md-3" width="20% ">微信号：</li>
                                    <li class="cs-in-style cs-modal-input" width="210px">
                                        <input type="text" value="" name="wechat"/>
                                    </li>
                                </ul>
                                <ul class="cs-ul-form clearfix">
                                    <li class="cs-name col-xs-3 col-md-3" width="20% ">邮箱：</li>
                                    <li class="cs-in-style cs-modal-input" width="210px">
                                        <input type="text" value="" name="email" datatype="e" ignore="ignore" errormsg="请输入正确的邮箱格式"/>
                                    </li>
                                </ul>
                                <ul class="cs-ul-form clearfix">
                                    <li class="cs-name col-xs-3 col-md-3" width="20% ">地址：</li>
                                    <li class="cs-in-style cs-modal-input" width="210px">
                                        <input type="text" value="" name="address"/>
                                    </li>
                                </ul>
                                <!-- <tr>
                                   <td class="cs-name">备注：</td>
                                   <td class="cs-in-style "><textarea class="cs-remark" name="remark" id="" cols="30" rows="10"></textarea></td>
                                </tr>  -->
                            </div>

                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-success" id="btnSave">确定</button>
                <button type="button" class="btn btn-default" data-dismiss="modal" id="btnCancel">关闭</button>
            </div>
            </form>
        </div>
    </div>
</div>
<%@include file="/WEB-INF/view/common/confirm.jsp" %>
<%@ include file="/WEB-INF/view/common/exportDialog.jsp" %>
<script src="${webRoot}/js/datagridUtil.js"></script>
<script type="text/javascript">
    rootPath = "${webRoot}/data/workers/";
    var inExports = 0;
    var inExportObj;
    var details = false;//查看人员详情权限
    for (var i = 0; i < childBtnMenu.length; i++) {
        if (childBtnMenu[i].operationCode == "415-1") {
            var html = '<a class="cs-menu-btn" onclick="getId();"><i class="' + childBtnMenu[i].functionIcon + '"></i>新增</a>';
            $("#showBtn").append(html);
        } else if (childBtnMenu[i].operationCode == "415-2") {
            edit = 1;
            editObj = childBtnMenu[i];
        } else if (childBtnMenu[i].operationCode == "415-3") {
            deletes = 1;
            deleteObj = childBtnMenu[i];
        } else if (childBtnMenu[i].operationCode == "415-4") {
            exports = 1;
            exportObj = childBtnMenu[i];
        } else if (childBtnMenu[i].operationCode == "415-5") {
            inExports = 1;
            inExportObj = childBtnMenu[i];
        } else if (childBtnMenu[i].operationCode == "415-6") {
            details = true;
        }
    }
    $(function () {
        //在进入就加载一次
        loadPage(0);
        $("#saveForm").Validform({
            tiptype: 2,
            beforeSubmit: function () {
                var formData = new FormData($('#saveForm')[0]);
                $.ajax({
                    type: "POST",
                    url: rootPath + "save.do",
                    data: formData,
                    contentType: false, //必须false才会避开jQuery对 formdata 的默认处理 XMLHttpRequest会对 formdata 进行正确的处理
                    processData: false, //必须false才会自动加上正确的Content-Type
                    dataType: "json",
                    success: function (data) {
                        if (data && data.success) {
                            $("#myModal2").modal("hide");
                            datagridUtil.query();
                        } else {
                            $("#waringMsg>span").html(data.msg);
                            $("#confirm-warnning").modal('toggle');
                        }
                    }
                });
                return false;
            }
        });
        // 新增或修改
        $("#btnSave").on("click", function () {
            $("#saveForm").submit();
            return false;
        });
        //关闭编辑模态框前重置表单，清空隐藏域
        $('#myModal2').on('hidden.bs.modal', function (e) {
            var form = $("#saveForm");// 清空表单数据
            form.form("reset");
            $("input[name=id]").val("");
            $("input[name=standardCode]").val("");
            $("#saveForm").Validform().resetForm();
            $("input").removeClass("Validform_error");
            $(".Validform_wrong").hide();
            $(".Validform_checktip").hide();
            $(".info").show();
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
    });
    function getInfoObj() {
        return $(this).parents("li").next().find(".info");
    }

    function loadPage(status) {
        var op = {
            tableId: "dataList",	//列表ID
            tableAction: '${webRoot}' + "/data/workers/datagrid.do?baseBean.status=" + status,	//加载数据地址
            parameter: [		//列表拼接参数
                {
                    columnCode: "workerName",
                    columnName: "人员名称",
                    query: 1,
                    customElement: "<a class=\"cs-link text-primary dj\" href=\"javascript:;\">?</a>",
                    columnWidth: '100px'
                },
                {
                    columnCode: "mobilePhone",
                    columnName: "手机号码",
                    query: 1,
                    columnWidth: '120px'
                },
                {
                    columnCode: "position",
                    columnName: "职位",
                    query: 1,
                    columnWidth: '120px'
                },
                {
                    columnCode: "departNameStr",
                    columnName: "所属机构",
                    query: 1,
                    columnWidth: '20%'
                },
                {
                    columnCode: "pointsNameStr",
                    columnName: "所属检测点",
                    query: 1,
                   
                },
                {
                    columnCode: "status",
                    columnName: "状态",
                    query: 1,
                    customVal: {"0": "在职", "1": "离职"},
                    columnWidth: '100px'
                }
            ],
            funBtns: [
                {
                    show: edit,
                    style: editObj,
                    action: function (id) {
                        $("#myModal2").modal("show");
                        getId(id);
                    }
                },
                {
                    show: deletes,
                    style: deleteObj,
                    action: function (id) {
                        idsStr = "{\"ids\":\"" + id.toString() + "\"}";
                        $("#confirm-delete").modal('toggle');
                    }
                }
            ],	//功能按钮
            bottomBtns: [
                {	//删除函数
                    show: deletes,
                    style: deleteObj,
                    action: function (ids) {
                        if (ids == '') {
                            $("#confirm-warnning .tips").text("请选择人员");
                            $("#confirm-warnning").modal('toggle');
                        } else {
                            idsStr = "{\"ids\":\"" + ids.toString() + "\"}";
                            $("#confirm-delete").modal('toggle');
                        }
                    }
                },
                {	//导入函数
                    show: inExports,
                    style: inExportObj,
                    action: function (ids) {
                        location.href = '${webRoot}/data/workers/toImport.do'
                    }
                }, {//导出函数
                    show: exports,
                    style: exportObj,
                    action: function (ids) {
                        $("#exportModal").modal('toggle');
                    }
                }
            ]
        };
        datagridUtil.initOption(op);
        datagridUtil.queryByFocus();
    }
    //导出方法
    function exportFile() {
        var radios = document.getElementsByName('inlineRadioOptions');
        var ext = '';
        for (var i = 0; i < radios.length; i++) {
            if (radios[i].checked) {
                ext = radios[i].value;
            }
        }
        /* var form = $('#queryForm').serialize();
         form = decodeURIComponent(form,true); */
         if (ext!='') {
        	 location.href = '${webRoot}/data/workers/exportFile.do?types=' + ext + "&workerName=" + $("#workerName").val() + "&status=" + $("#selectedStatus").val();
             $("#exportModal").modal('hide');
		}else {
			$("#exportModal").modal('hide');
			$("#confirm-warnning .tips").text("请选择导出格式!");
			$("#confirm-warnning").modal('toggle');
		}
        
    }

    /**
     * 查询人员
     */
    function getId(id) {
        if (id) {
            $.ajax({
                url: "${webRoot}/data/workers/queryById.do",
                type: "POST",
                data: {"id": id},
                dataType: "json",
                success: function (data) {
                    $(".info").hide();
                    var form = $('#saveForm');
                    form.form('load', data.obj);
                    $("[name=gender][value=" + data.obj.checked + "]").prop("checked", "checked");
                    $("[name=status][value=" + data.obj.checked + "]").prop("checked", "checked");
                }
            });
            $("#myModal2 .modal-title").text("编辑");

        } else {
            $("#myModal2 .modal-title").text("新增");
        }
        $("#myModal2").modal("show");
    }

    //点击人员查看人员详细信息
    //查看人员考核
    $(document).on("click", ".dj", function () {
        if (details) {
            self.location = '${webRoot}/personnel_baseWorkers/personnelBaseworkersDetails?state=1&route=1&userId=' + $(this).parents(".rowTr").attr("data-rowId");
        }
    });
    //绑定回车事件
    function statusChange() {
        var selectedVal = $("#selectedStatus option:selected").val();
        loadPage(selectedVal);
    }

    //------------------------输入限制------------------------------
    //键盘谈起时间onkeyup="clearNoNum(this)";
    function clearNoNum(obj) {
        //先把非数字的都替换掉，除了数字和.
        obj.value = obj.value.replace(/[^\d.]/g, "");
        //必须保证第一个为数字而不是.
        obj.value = obj.value.replace(/^\./g, "");
        //保证只有出现一个.而没有多个.
        obj.value = obj.value.replace(/\.{2,}/g, ".");
        //保证.只出现一次，而不能出现两次以上
        obj.value = obj.value.replace(".", "$#$").replace(/\./g, "")
            .replace("$#$", ".");
    }

</script>
</body>
</html>
