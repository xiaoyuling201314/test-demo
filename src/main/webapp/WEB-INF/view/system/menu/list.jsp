<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/WEB-INF/view/common/resource.jsp" %>
<html>
<head>
    <title>快检服务云平台</title>
    <style type="text/css">
        .cs-icon-span .text-del:hover {
            color: #f91717;
        }
    </style>
</head>
<body>
<div class="cs-col-lg clearfix">
    <!-- 面包屑导航栏  开始-->
    <ol class="cs-breadcrumb">
        <li class="cs-fl">
            <img src="${webRoot}/img/set.png" alt=""/>
            <a href="javascript:">系统管理</a></li>
        <li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
        <li class="cs-b-active cs-fl">菜单管理
        </li>
    </ol>
    <div class="cs-input-style cs-fl" style="margin:3px 0 0 30px;">
        菜单类型：
        <select class="cs-selcet-style" style="width: 120px;" id="qp_functionType" onchange="typeChange()">
            <option value="-1"> 请选择</option>
            <option value="0"> 云平台</option>
            <option value="1"> APP</option>
            <option value="2"> 工作站</option>
            <option value="3"> 公众号</option>
        </select>
        菜单状态：
        <select class="cs-selcet-style" style="width: 120px;" id="qp_deleteFlag" onchange="typeChange()">
            <option value="">--请选择--</option>
            <option value="1">停用</option>
            <option value="0">启用</option>
        </select>
    </div>
    <!-- 面包屑导航栏  结束-->
    <div class="cs-search-box cs-fr">
        <form action="datagrid.do">
            <div class="cs-search-filter clearfix cs-fl">
                <input class="cs-input-cont cs-fl focusInput" type="text" name="functionName" placeholder="请输入内容"/>
                <input type="button" onclick="datagridUtil.queryByFocus();" class="cs-search-btn cs-fl" href="javascript:;" value="搜索">
            </div>
            <div class="clearfix cs-fr" id="showBtn">
            </div>
        </form>

    </div>
</div>

<div id="dataList"></div>
<!-- 编辑模态框 start -->
<div class="modal fade intro2" id="addModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
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
                        <form id="saveForm" action="${webRoot}/system/menu/save.do" method="post">
                            <input type="hidden" name="parentId"/>
                            <input type="hidden" name="id" id="id"/>
                            <div width="100%" class="cs-add-new">
                                <ul class="cs-ul-form clearfix">
                                    <li class="cs-name col-xs-3 col-md-3">菜单类型：</li>
                                    <li class="cs-al cs-modal-input">
                                        <input id="cs-check-radio" type="radio" value="0" name="functionType" checked="checked" class="functionType"/><label
                                            for="cs-check-radio">云平台</label>
                                        <input id="cs-check-radio2" type="radio" value="1" name="functionType" class="functionType"/><label
                                            for="cs-check-radio2">APP</label>
                                        <input id="cs-check-radio3" type="radio" value="2" name="functionType" class="functionType"/><label
                                            for="cs-check-radio3">工作站</label>
                                        <input id="cs-check-radio4" type="radio" value="3" name="functionType"
                                               class="functionType"/><label
                                            for="cs-check-radio4">公众号</label>
                                    </li>
                                </ul>
                                <ul class="cs-ul-form clearfix">
                                    <li class="cs-name col-xs-3 col-md-3">父级菜单：</li>
                                    <li class="cs-in-style cs-modal-input">
                                        <div class="cs-all-ps">
                                            <div class="cs-input-box">
                                                <input type="text" id="choseMenu" readonly="readonly" class="cs-down-input">
                                                <div class="cs-down-arrow"></div>
                                            </div>
                                            <div id="divBtn" class="cs-check-down  cs-hide" style="display: none;">

                                                <!-- 树状图 -->
                                                <ul id="menuTree" class="easyui-tree">
                                                </ul>
                                                <!-- 树状图 -->
                                            </div>
                                        </div>
                                    </li>
                                </ul>
                                <ul class="cs-ul-form clearfix">
                                    <li class="cs-name col-xs-3 col-md-3" width="20% ">菜单名称：</li>
                                    <li class="cs-in-style cs-modal-input" width="210px">
                                        <input type="text" name="functionName" class="inputxt" datatype="*" nullmsg="请输入菜单名称"/></li>
                                    <li class="col-xs-4 col-md-4 cs-text-nowrap">
                                        <div class="Validform_checktip"></div>
                                        <div class="info"><i class="cs-mred">*</i>请输入菜单名称
                                        </div>
                                    </li>
                                </ul>
                                <ul class="cs-ul-form clearfix">
                                    <li class="cs-name col-xs-3 col-md-3" width="20% ">菜单图标：</li>
                                    <li class="cs-in-style cs-modal-input" width="210px">
                                        <input type="text" value="" name="functionIcon" class="inputxt"/></li>
                                </ul>
                                <ul class="cs-ul-form clearfix">
                                    <li class="cs-name col-xs-3 col-md-3">菜单url：</li>
                                    <li class="cs-in-style cs-modal-input">
                                        <input type="text" name="functionUrl" class="inputxt"/>
                                    </li>
                                </ul>
                                <ul class="cs-ul-form clearfix">
                                    <li class="cs-name col-xs-3 col-md-3">菜单备注：</li>
                                    <li class="cs-in-style cs-modal-input">
                                        <input type="text" name="remark" class="inputxt"/>
                                    </li>
                                </ul>
                                <ul class="cs-ul-form clearfix">
                                    <li class="cs-name col-xs-3 col-md-3" width="20% ">菜单序号：</li>
                                    <li class="cs-in-style cs-modal-input" width="210px">
                                        <input type="text" name="sorting" class="inputxt" datatype="n" ignore="ignore" nullmsg="请输入菜单序号"/></li>
                                </ul>
                                <ul class="cs-ul-form clearfix">
                                    <li class="cs-name col-xs-3 col-md-3">菜单状态：</li>
                                    <li class="cs-al cs-modal-input">
                                        <input id="radio" type="radio" value="0" name="deleteFlag" checked="checked"/><label
                                            for="radio">启用</label>
                                        <input id="radio2" type="radio" value="1" name="deleteFlag"/><label
                                            for="radio2">停用</label>
                                    </li>
                                </ul>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-success" id="btnSave">确定</button>
                <button type="button" class="btn btn-default" data-dismiss="modal" id="btnCancel">关闭</button>
            </div>
        </div>
    </div>
</div>
<%--停用模态框--%>
<div class="modal fade intro2" id="confirm-delete2" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog cs-alert-width">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">确认停用</h4>
            </div>
            <div class="modal-body cs-alert-height cs-dis-tab">
                <div class="cs-text-algin">
                    <img src="${webRoot}/img/stop2.png" width="40px"/>
                    <span class="tips">确认停用该菜单吗？</span>
                </div>
            </div>
            <div class="modal-footer">
                <a class="btn btn-danger btn-ok" onclick="deleteData()">停用</a>
                <button type="button" class="btn btn-" data-dismiss="modal">取消</button>
            </div>
        </div>
    </div>
</div>

<%--启用模态框--%>
<div class="modal fade intro2" id="confirm-enable" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <input type="hidden" name="id" id="currentId" value=""/>
    <div class="modal-dialog cs-alert-width">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">确认启用</h4>
            </div>
            <div class="modal-body cs-alert-height cs-dis-tab">
                <div class="cs-text-algin">
                    <img src="${webRoot}/img/sure.png" width="40px"/>
                    <span class="tips">确认启用该菜单吗？</span>
                </div>
            </div>
            <div class="modal-footer">
                <a class="btn btn-success btn-ok" onclick="enableStart()">启用</a>
                <button type="button" class="btn btn-" data-dismiss="modal">取消</button>
            </div>
        </div>
    </div>
</div>

<!-- 编辑模态框 end -->
<script src="${webRoot}/js/datagridUtil.js"></script>
<%@include file="/WEB-INF/view/common/confirm.jsp"%>
<script type="text/javascript">
    rootPath = '${webRoot}/system/menu/';
    var editId;
    var fType2;
    $(function () {
        var tHeight = $('.modal-header').height();
        var mHeight = $('.modal-body').height();
        var bHeight = $('.modal-footer').height();

        $('.modal').height(tHeight + mHeight + bHeight + '85px');

        if (Permission.exist("514-1")) {
            var html = '<a class="cs-menu-btn" onclick="getId();"><i class="' + Permission.getPermission("514-1").functionIcon + '"></i>新增</a>';
            $("#showBtn").append(html);
        }

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
        var sfv = $("#saveForm").Validform({
            tiptype: 2,
            beforeSubmit: function () {
            },
            callback:function(data){
                $.Hidemsg();
                if (data && data.success) {
                    $("#addModal").modal("hide");
                    datagridUtil.query();
                } else {
                    $("#waringMsg>span").html(data.msg);
                    $("#confirm-warnning").modal('toggle');
                }
            }
        });
        // 新增或修改
        $("#btnSave").on("click", function () {
            sfv.ajaxPost();
            return false;
        });
        // 关闭编辑模态框前重置表单，清空隐藏域
        $('#addModal').on('hidden.bs.modal', function (e) {
            var form = $("#saveForm");// 清空表单数据
            form.form("reset");
            $("input[name=parentId]").val("");
            $("input[name=id]").val("");
            $("#choseMenu").val("");
        });
        $("#addModal").on('show.bs.modal', function (e) {
            $(".registerform").Validform().resetForm();
            $("input").removeClass("Validform_error");
            $(".Validform_wrong").hide();
            $(".info").show();
            if (!editId) initMenuTree();//如果是新增才直接调用
        });

        $("input[name=functionType]").on("click", function () {
            $("input[name=parentId]").val("");
            $("#choseMenu").val("");
            initMenuTree();
        });
    });


    function getInfoObj() {
        return $(this).parents("li").next().find(".info");
    }

    // 加载权限树
    function initMenuTree(id, id2) {
        var url = id ? "${webRoot}/system/menu/menuTree.do?currentId=" + id : "${webRoot}/system/menu/menuTree.do";
        $("#menuTree").tree({
            checkbox: false,
            url: "${webRoot}/system/menu/menuTree.do?currentId=" + id,
            animate: true,
            lines: false,
            onClick: function (node) {
                $("input[name=parentId]").val(node.id);
                $("#choseMenu").val(node.text);
                $(".cs-check-down").hide();
            },
            onBeforeLoad: function (node, param) {
                if (id) {
                    param.functionType = id2;
                } else {
                    param.functionType = $("input:radio[name=functionType]:checked").val();
                }
            }
        });
    }

    function RefreshPage(ft, df) {
        var op = {
            tableId: "dataList", // 列表ID
            tableAction: "${webRoot}/system/menu/datagrid.do?functionType="+ft+"&deleteFlag="+df,
            parameter: [ // 列表拼接参数
                {
                    columnCode: "functionType",
                    columnName: "菜单类型",
                    columnWidth: '90px',
                    customVal: {
                        "0": "云平台",
                        "1": "APP",
                        "2": "工作站",
                        "3": "公众号"
                    }
                },
                {
                    columnCode: "parentStr",
                    columnName: "父级菜单",
                    columnWidth: '130px'

                }, {
                    columnCode: "functionName",
                    columnName: "菜单名称",
                    columnWidth: '220px',
                    query: 1
                }, {
                    columnCode: "sorting",
                    columnName: "排序",
                    sortDataType:"int",
                    columnWidth: '65px'
                }, {
                    columnCode: "deleteFlag",
                    columnName: "菜单状态",
                    columnWidth: '88px',
                    customVal: {
                        "0": "<span style='color: #0abf5a'>启用</span>",
                        "1": "<span style='color: red'>停用</span>",
                    }
                }, {
                    columnCode: "functionUrl",
                    columnName: "菜单url",
                    customStyle: "urlLeft",
                    customElement: "<span style='width: 100%;display: block;white-space: nowrap;overflow: hidden;text-overflow: ellipsis' title='?'>?</span>"
                }, {
                    columnCode: "remark",
                    columnName: "备注",
                    columnWidth: '120px'
                }],
            funBtns: [{
                show: Permission.exist("514-2"),
                style: Permission.getPermission("514-2"),
                action: function (id) {
                    editId = id;
                    getId(id);
                }
            }, {
                show: Permission.exist("514-3"),
                style: Permission.getPermission("514-3"),
                action: function (id) {
                    self.location = "${webRoot}/system/operation/list.do?id=" + id;
                }
            }, {
                show: Permission.exist("514-4"),
                style: Permission.getPermission("514-4"),
                action: function (id) {
                    idsStr = "{\"ids\":\"" + id.toString() + "\"}";
                    $("#confirm-delete2").modal('toggle');
                }
            }],
            bottomBtns: [
                {
                    show: Permission.exist("514-4"),
                    style: Permission.getPermission("514-4"),
                    action: function (ids) {
                        if(ids == ''){
                            $("#confirm-warnning .tips").text("请选择要删除的菜单");
                            $("#confirm-warnning").modal('toggle');
                        }else {
                        idsStr = "{\"ids\":\"" + ids.toString() + "\"}";
                        $("#confirm-delete2").modal('toggle');
                    }
                }
                }
            ], onload: function () {//加载成功之后才执行的方法
                $(".cs-bottom-tools").hide();//隐藏分页
                //实现菜单左对齐
                $(".urlLeft").each(function () {
                    $(this).attr("style", "text-align:left");
                });

                var obj = datagridOption.obj;
                // console.log(obj);
                if (obj) {
                    for (var i = 0; i < obj.length; i++) {
                        if (obj[i].deleteFlag == 1) {//如果状态为未启用那就按钮变灰
                            $("tr[data-rowid=" + obj[i].id + "]").find(".icon-guanbi").removeClass("icon-duigou text-del ").addClass("icon-duigou").attr("title", "启用").closest("span").attr("onclick", "enable(" + obj[i].id + ")");//class=icon-disabled
                            //如果状态为未启用，其子菜单按钮也要为停用状态
                        }
                    }
                }

            }
        };
        datagridUtil.initOption(op);
        datagridUtil.query();
    }

    //菜单状态改变事件
    function typeChange() {
        RefreshPage($("#qp_functionType option:selected").val(), $("#qp_deleteFlag option:selected").val());
    }
    $(function () {
        //进入界面查询数据
        RefreshPage(-1, '');
    });

    /**
     * 查询信息
     */
    function getId(functionId) {
        if (functionId) {
            $.ajax({
                url: "${webRoot}/system/menu/queryById.do",
                type: "POST",
                data: {"id": functionId},
                dataType: "json",
                success: function (data) {
                    $(".info").hide();
                    $('#saveForm').form('load', data.obj);
                    $("input[name=functionType][value=" + data.obj.functionType + "]").prop("checked", "checked");
                    $("input[name=deleteFlag][value=" + data.obj.deleteFlag + "]").prop("checked", "checked");
                    $("#choseMenu").val(data.obj.parentStr);
                    initMenuTree(functionId, data.obj.functionType);//解决选定菜单类型checked属性添加不上问题
                }
            });
            $("#addModal .modal-title").text("编辑");

        } else {
            $("#addModal .modal-title").text("新增");
        }
        $("#addModal").modal("show");
    }


    function deleteData() {
        $.ajax({
            type: "POST",
            url: rootPath + "/delete.do",
            data: JSON.parse(idsStr),
            dataType: "json",
            success: function (data) {
                $("#confirm-delete2").modal('toggle');
                if (data && data.success) {
                    //删除成功后刷新列表
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

    function enable(currentId) {
        $("#currentId").val(currentId);
        $("#confirm-enable").modal("show");
    }

    function enableStart() {
        $.ajax({
            type: "POST",
            url: "${webRoot}/system/menu/enable_start.do",
            data: {'id': $("#currentId").val()},
            dataType: "json",
            success: function (data) {
                if (data && data.success) {
                    $("#confirm-enable").modal("hide");
                    datagridUtil.query();
                } else {
                    $("#waringMsg>span").html(data.msg);
                    $("#confirm-warnning").modal('toggle');
                }
            }
        });
    }

</script>
</body>
</html>
