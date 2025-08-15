<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/WEB-INF/view/common/resource.jsp" %>
<html>
<head>
    <title>快检服务云平台</title>
    <link rel="stylesheet" type="text/css" href="${webRoot}/plug-in/ztree/css/zTreeStyle.css"/>
    <style type="text/css">
        .cs-icon-span .text-del:hover {
            color: #f91717;
        }
    </style>
</head>
<body>

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
                        <form id="saveForm" action="${webRoot}/system/scheduled/save.do" method="post">
                            <input type="hidden" name="id">
                            <input type="hidden" name="oldOff" value="1">
                            <div width="100%" class="cs-add-new">
                                <ul class="cs-ul-form clearfix">
                                    <li class="cs-name col-xs-3 col-md-3" width="20% ">定时器名称：</li>
                                    <li class="cs-in-style col-xs-9 col-md-9"><input id="scheduledName" type="text" name="scheduledName"
                                                                                     class="inputxt" nullmsg="请输入定时器名称！"/></li>
                                </ul>
                                <ul class="cs-ul-form clearfix">
                                    <li class="cs-name col-xs-3 col-md-3" width="20% ">时间间隔：</li>
                                    <li class="cs-in-style col-xs-9 col-md-9"><input id="scheduled" type="text" name="scheduled" class="inputxt"/>
                                    </li>
                                </ul>
                                <ul class="cs-ul-form clearfix">
                                    <li class="cs-name col-xs-3 col-md-3" width="20% ">启用路径：</li>
                                    <li class="cs-in-style col-xs-9 col-md-9">
                                        <input id="param1" type="text" name="startUrl" class="inputxt"/>
                                    </li>
                                </ul>
                                <ul class="cs-ul-form clearfix">
                                    <li class="cs-name col-xs-3 col-md-3" width="20% ">搜索机构：</li>
                                    <li class="cs-in-style col-xs-9 col-md-9">
                                        <input placeholder="请输入机构名称" autocomplete="off" id="key" type="text" onfocus="showMenu()" class="inputxt"/>
                                    </li>
                                </ul>
                                <ul class="cs-ul-form clearfix hide">
                                    <li class="cs-name col-xs-3 col-md-3" width="20% ">机构ID：</li>
                                    <li class="cs-in-style col-xs-9 col-md-9">
                                        <input id="departIds" type="text" name="departIds" class="inputxt"/>
                                    </li>
                                </ul>
                                <ul class="cs-ul-form clearfix">
                                    <li class="cs-name col-xs-3 col-md-3">选择机构：</li>
                                    <li class="cs-in-style cs-modal-input">
                                        <div class="cs-all-ps">
                                            <div class="cs-input-box">
                                                <input type="text" id="departName" type="text" readonly="readonly" class="cs-down-input">
                                                <div class="cs-down-arrow"></div>
                                            </div>
                                            <div id="menuContent" class="cs-check-down cs-hide">
                                                <!-- 树状图 -->
                                                <ul id="myTree" class="ztree">
                                                </ul>
                                                <!-- 树状图 -->
                                            </div>
                                        </div>
                                    </li>
                                </ul>
                                <ul class="cs-ul-form clearfix">
                                    <li class="cs-name col-xs-3 col-md-3">状态：</li>
                                    <li class="cs-al cs-modal-input">
                                        <input id="cs-check-radio" type="radio" value="0" name="off"/><label for="cs-check-radio">启用</label>
                                        <input id="cs-check-radio2" type="radio" value="1" name="off" checked="checked"/><label for="cs-check-radio2">停用</label>
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
<%@include file="/WEB-INF/view/common/confirm.jsp" %>
<%@include file="/WEB-INF/view/system/scheduled/schedule_confirm.jsp" %>
<script src="${webRoot}/js/datagridUtil2.js"></script>
<%--引入ztree插件--%>
<script type="text/javascript" src="${webRoot}/plug-in/ztree/js/jquery.ztree.core.js"></script>
<script type="text/javascript" src="${webRoot}/plug-in/ztree/js/jquery.ztree.excheck.js"></script>
<script type="text/javascript" src="${webRoot}/plug-in/ztree/js/jquery.ztree.exhide.js"></script>
<script type="text/javascript" src="${webRoot}/plug-in/ztree/js/fuzzysearch.js"></script>
<script type="text/javascript">

    // if (Permission.exist("1424-1") == 1) {
    //     var html = '<a class="cs-menu-btn" onclick="getId();"><i class="' + childBtnMenu[i].functionIcon + '"></i>新增</a>';
    //     $("#showBtn").append(html);
    // }

    var dgu = datagridUtil.initOption({
        tableId: "dataList",
        tableAction: "${webRoot}/system/scheduled/datagrid.do",
        tableBar: {
            title: ["系统管理", "定时管理"],
            hlSearchOff: 0,
            ele: [{
                eleShow: 1,
                eleName: "keyWords",
                eleType: 0,
                elePlaceholder: "请输入定时器名称"
            }],
            topBtns: [{
                show: Permission.exist("1424-1"),
                style: Permission.getPermission("1424-1"),
                action: function (ids, rows) {
                    getId();
                }
            }]
        },
        parameter: [
            {
                columnCode: "scheduledName",
                columnName: "定时器名称"
            },
            {
                columnCode: "scheduled",
                columnName: "cron表达式",
                columnWidth: '120px'
            },
            {
                columnCode: "off",
                columnName: "状态",
                customVal: {0: "<span class='text-success'>启用</span>", 1: "<span class='text-danger'>停用</span>"},
                columnWidth: '52px'
            },
            {
                columnCode: "startUrl",
                columnName: "启动路径",
                columnWidth: '150px'
            },
            {
                columnCode: "updateDate",
                columnName: "更新时间",
                dateFormat: "yyyy-MM-dd HH:mm:ss",
                columnWidth: '90px'
            }, {
                columnCode: "departIds",
                columnName: "机构名称(微信配置)",
                customStyle: "dn",
                columnWidth: '200px'
            }
        ],
        funBtns: [
            {
                show: Permission.exist("1424-2"),
                style: Permission.getPermission("1424-2"),
                action: function (id) {
                    getId(id);
                }
            },
            {
                show: Permission.exist("1424-3"),
                style: Permission.getPermission("1424-3"),
                action: function (id) {
                    idsStr = "{\"ids\":\"" + id.toString() + "\"}";
                    $("#confirm-delete").modal('toggle');
                }
            },{
                show: Permission.exist("1424-4"),
                style: Permission.getPermission("1424-4"),
                action: function (id,row) {
                    taskId = id;
                    $("#confirm-stopTask .tips").html('确认停用【'+row.scheduledName+'】定时任务吗？');
                    $("#confirm-stopTask").modal('toggle');
                }
            }
        ],
        bottomBtns: [
            {
                show: Permission.exist("1424-3"),
                style: Permission.getPermission("1424-3"),
                action: function (ids) {
                    if(ids == ''){
                        $("#confirm-warnning .tips").text("请选择要删除的定时器");
                        $("#confirm-warnning").modal('toggle');
                    }else {
                    idsStr = "{\"ids\":\"" + ids.toString() + "\"}";
                    $("#confirm-delete").modal('toggle');
                }
            }
            }
        ],
        onload: function (rows, pageData) {
            var obj = rows;
            if (obj) {
                for (var i = 0; i < obj.length; i++) {
                    if (obj[i].off == 1) {//如果状态为未启用那就按钮变灰
                        $("tr[data-rowid=" + obj[i].id + "]").find(".icon-guanbi").removeClass("icon-duigou text-del ").addClass("icon-duigou").attr("title", "启用").closest("span").attr("onclick", "startTask(" + obj[i].id + ",'"+obj[i].startUrl+"','"+obj[i].scheduledName+"')");//class=icon-disabled
                    }
                }
            }
        }
    });
    dgu.queryByFocus();
    function getId(id) {
        if (id) {
            $("#addModal .modal-title").text("编辑");
            $.ajax({
                url: "${webRoot}/system/scheduled/queryById.do",
                type: "POST",
                data: {"id": id},
                dataType: "json",
                success: function (data) {
                    if (data && data.success) {
                        $('#saveForm').form('load', data.obj);
                    }
                }
            });
        } else {
            $("#addModal .modal-title").text("新增");
        }
        $("#addModal").modal("show");
    }

    $(function () {
        //验证
        var scheduledForm = $("#saveForm").Validform({
            tiptype: 3,
            callback: function (data) {
                if (data.success) {
                    self.location.reload();
                } else {
                    $.Showmsg(data.msg);
                }
                return false;
            }
        });

        // 新增或修改
        $("#btnSave").on("click", function () {
            scheduledForm.ajaxPost();
        });

        //关闭编辑模态框前重置表单，清空隐藏域
        $('#addModal').on('hidden.bs.modal', function (e) {
            scheduledForm.resetForm();
            scheduledForm.resetStatus();
            $("input[type='hidden']").val("");
        });
    });
    //删除
    function deleteData() {
        $.ajax({
            type: "POST",
            url: "${webRoot}/system/scheduled/delete.do",
            data: JSON.parse(idsStr),
            dataType: "json",
            success: function (data) {
                $("#confirm-delete").modal('toggle');
                if (data && data.success) {
                    dgu.queryByFocus();
                } else {
                    $("#waringMsg>span").html(data.msg);
                    $("#confirm-warnning").modal('toggle');
                }
            }
        });
    }

    var taskId;//要处理的任务ID
    var startUrl;//定时任务启动路径
    //传入任务ID，启动地址，任务名称
    function startTask(currentId,myUrl,scheduledName) {
        taskId=currentId;
        startUrl=myUrl;
        $("#confirm-startTask .tips").html('确认启用【'+scheduledName+'】定时任务吗？');
        $("#confirm-startTask").modal("show");
    }
    //手动开启定时任务，先修改定时器任务为启用，然后延迟执行开启定时器操作
    function enableStart() {
        $("#confirm-startTask").modal("hide");
        if(startUrl!=""){
            updateTaskStatus(0);
            setTimeout(function(){
                $.ajax({
                    type: "POST",
                    url: "${webRoot}/"+startUrl,
                    // data: {},
                    dataType: "json",
                    success: function (data) {
                        if (data && data.success) {
                            $("#waringMsg>span").html("任务开启成功");
                            $("#confirm-warnning").modal('toggle');
                        } else {
                            $("#waringMsg>span").html(data.msg);
                            $("#confirm-warnning").modal('toggle');
                        }
                    }
                });
            },10000);
        }else{
            $("#waringMsg>span").html("请先配置定时任务的启动路径！");
            $("#confirm-warnning").modal('toggle');
        }
    }
    //停止定时任务,先停止定时器在修改任务表的状态信息
    function stopTask() {
        $("#confirm-stopTask").modal('toggle');
        $.ajax({
            type: "POST",
            url:"${webRoot}/MonthlyStatisticsTask/stopSchedule.do",
            data: {"taskId":taskId},
            dataType: "json",
            success: function (data) {
                if (data && data.success) {
                    updateTaskStatus(1)
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

    /**
     * 更新定时任务表的运行状态
     * @param status:状态：0启用，1停用
     */
    function updateTaskStatus(status){
        $.ajax({
            type: "POST",
            url: "${webRoot}/system/scheduled/updateTaskStatus.do",
            data: {"id":taskId,"off":status},
            dataType: "json",
            success: function (data) {
                if (data && data.success) {
                    dgu.queryByFocus();
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