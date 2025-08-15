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
            <img src="${webRoot}/img/set.png"/>
            <a href="javascript:">检测点管理</a></li>
        <li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
        <li class="cs-fl">快检点</li>
        <li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
        <li class="cs-b-active cs-fl">人员管理<c:if test="${!empty pointName}">：${pointName}</c:if>
        </li>
    </ol>
    <!-- 面包屑导航栏  结束-->
    <div class="cs-search-box cs-fr">
        <form action="datagrid.do">
            <div class="clearfix cs-fr" id="showBtn">
                <!--  <a href="javascript:;" onclick="self.location.href='${webRoot}/detect/basePoint/list.do'" class="cs-menu-btn"><i class="icon iconfont icon-fanhui"></i>返回</a> -->
                <a href="javascript:" onclick="self.history.back();" class="cs-menu-btn"><i class="icon iconfont icon-fanhui"></i>返回</a>
            </div>
        </form>
    </div>
</div>

<div id="dataList"></div>

<!-- 查看模态框 -->
<div class="modal fade intro2" id="viewModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog cs-mid-width" role="document">
        <div class="modal-content ">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">查看</h4>
            </div>
            <div class="modal-body cs-mid-height">
                <!-- 主题内容 -->
                <div class="cs-tabcontent">
                    <div class="cs-content2">
                        <form id="workerForm">
                            <table class="cs-add-new">
                                <tr>
                                    <td class="cs-name">用户名：</td>
                                    <td class="cs-in-style">
                                        <input type="text" name="workerName" disabled="disabled"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="cs-name">证件号码：</td>
                                    <td class="cs-in-style">
                                        <input type="text" name="reserved1" disabled="disabled"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="cs-name">职位：</td>
                                    <td class="cs-in-style">
                                        <input type="text" name="position" disabled="disabled"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="cs-name">联系电话：</td>
                                    <td class="cs-in-style">
                                        <input type="text" name="mobilePhone" disabled="disabled"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="cs-name">办公座机：</td>
                                    <td class="cs-in-style">
                                        <input type="text" name="officePhone" disabled="disabled"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="cs-name">微信号：</td>
                                    <td class="cs-in-style">
                                        <input type="text" name="wechat" disabled="disabled"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="cs-name">邮箱：</td>
                                    <td class="cs-in-style">
                                        <input type="text" name="email" disabled="disabled"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="cs-name">地址：</td>
                                    <td class="cs-in-style">
                                        <input type="text" name="address" disabled="disabled"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="cs-name">性别：</td>
                                    <td class="cs-in-style cs-radio">
                                        <input id="cs-check-radio" type="radio" value="0" name="gender" checked="checked" disabled="disabled"/><label
                                            for="cs-check-radio">男</label>
                                        <input id="cs-check-radio2" type="radio" value="1" name="gender" disabled="disabled"/><label
                                            for="cs-check-radio2">女</label>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="cs-name">状态：</td>
                                    <td class="cs-in-style cs-radio">
                                        <input id="cs-check-radio" type="radio" value="0" name="status" checked="checked" disabled="disabled"/><label
                                            for="cs-check-radio">在职</label>
                                        <input id="cs-check-radio2" type="radio" value="1" name="status" disabled="disabled"/><label
                                            for="cs-check-radio2">离职</label>
                                    </td>
                                </tr>
                            </table>
                        </form>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <!-- <button type="button" class="btn btn-success" id="btnSave">确定</button> -->
                <button type="button" class="btn btn-default" data-dismiss="modal" id="btnCancel">关闭</button>
            </div>
        </div>
    </div>
</div>

<!-- 关联人员模态框 -->
<div class="modal fade intro2" id="workersModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog cs-lg-width">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title">新增</h4>
            </div>
            <div class="modal-body cs-lg-height">
                <div id="dataList1"></div>
            </div>
            <div class="modal-footer">
                <a class="btn btn-danger btn-ok">确认</a>
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
            </div>
        </div>
    </div>
</div>

<!-- 引用模态框 -->
<%@include file="/WEB-INF/view/common/confirm.jsp" %>
<%@include file="/WEB-INF/view/data/workers/selectWorker.jsp" %>

<script src="${webRoot}/js/datagridUtil.js"></script>
<script type="text/javascript">
    //新增仪器
    if (Permission.exist("391-13")) {
        var html = '<a class="cs-menu-btn" href="javascript:;" onclick="addPersonnel();"><i class="'
            + Permission.getPermission("391-13").functionIcon + '"></i>' + Permission.getPermission("391-13").operationName + '</a>';
        $("#showBtn").prepend(html);
    }
    /* 
     var addBtn=0;
     var addBtnObj;
     var view=0;
     var viewObj;
     for (var i = 0; i < childBtnMenu.length; i++) {
     if (childBtnMenu[i].operationCode == "391-4") {
     //查看
     view = 1;
     viewObj=childBtnMenu[i];
     }else if (childBtnMenu[i].operationCode == "391-1") {
     //新增
     var html='<a class="cs-menu-btn" href="javascript:;" onclick="addPersonnel();"><i class="'+childBtnMenu[i].functionIcon+'"></i>添加人员</a>';
     $("#showBtn").prepend(html);
     addBtn = 1;
     addBtnObj=childBtnMenu[i];
     }else if (childBtnMenu[i].operationCode == "391-2") {
     //编辑
     edit = 1;
     editObj=childBtnMenu[i];
     }else if (childBtnMenu[i].operationCode == "391-3") {
     //删除
     deletes = 1;
     deleteObj=childBtnMenu[i];
     }
     }
     */

    //关闭编辑模态框前重置表单，清空隐藏域
    $('#viewModal').on('hidden.bs.modal', function (e) {
        $("input[name=id]").val("");
        $("input[name=standardCode]").val("");
    });

    //机构人员列表
    var op = {
        tableId: "dataList",	//列表ID
        tableAction: '${webRoot}' + "/data/pointUser/datagrid.do",	//加载数据地址
        parameter: [		//列表拼接参数
            {
                columnCode: "workerName",
                columnName: "人员名称",
                query: 1
            },
            {
                columnCode: "positionCode",
                columnName: "职位",
                query: 1
            },
            {
                columnCode: "mobilePhone",
                columnName: "联系电话",
                query: 1
            },
            {
                columnCode: "remark",
                columnName: "工作内容",
                query: 1
            }
        ],
        defaultCondition: [	//默认查询条件
            {
                queryCode: "depart.id",
                queryVal: '${departId}'
            },
            {
                queryCode: "point.id",
                queryVal: '${pointId}'
            }
        ],
        funBtns: [	//功能按钮
            {//编辑
                show: Permission.exist("391-14"),
                style: Permission.getPermission("391-14"),
                action: function (id) {
                    $.ajax({
                        type: 'POST',
                        url: '${webRoot}/data/pointUser/queryById.do',
                        data: {"id": id},
                        dataType: 'json',
                        success: function (data) {
                            if (data && data.success) {
                                $(".registerform input[name='id']").val(id);
                                $(".registerform .workerName").text(data.obj.workerName);
                                $(".registerform select[name='positionCode']").val(data.obj.positionCode);
                                $(".registerform textarea[name='remark']").val(data.obj.remark);
                                $("#myEditUserModal").modal("show");
                            } else {
                                $("#confirm-warnning .tips").text(data.msg);
                                $("#confirm-warnning").modal('toggle');
                            }
                        }
                    });
                }
            },
            {
                show: Permission.exist("391-16"),
                style: Permission.getPermission("391-16"),
                action: function (id) {
                    $("#viewModal").modal("show");
                    for (var i = 0; i < datagridOption["obj"].length; i++) {
                        if (id == datagridOption["obj"][i].id) {
                            getId(datagridOption["obj"][i].userId, datagridOption["obj"][i].positionCode);
                            break;
                        }
                    }
                }
            }
        ],
        bottomBtns: [
            {//删除人员
                show: Permission.exist("391-15"),
                style: Permission.getPermission("391-15"),
                action: function (ids) {
                    deleteDevice(ids);
                }
            }
        ]
    };
    datagridUtil.initOption(op);

    datagridUtil.query();

    //添加人员
    function addPersonnel() {
        $('#myUserModal').modal('toggle');
    }

    function selPoint(pointsArray) {

    }

    //查看人员模态框隐藏时执行函数
    $('#viewModal').on('hidden.bs.modal', function () {
        $("#viewModal input[type!='radio']").val("");
        $("#viewModal input[type='radio']").removeProp("checked");
    });
    /**
     * 查询人员信息
     */
    function getId(id, position) {
        $.ajax({
            url: "${webRoot}/data/workers/queryById.do",
            type: "POST",
            data: {"id": id},
            dataType: "json",
            success: function (data) {
                if (data && data.success) {
                    var obj = data.obj;
                    if (obj) {
                        $("#workerForm").form('load', obj);

                        //人员在当前检测点下职位
                        $("#viewModal input[name='position']").val(position);
                    }
                }
            }
        });
    }

    //删除人员
    var userIds = "";
    function deleteDevice(ids) {
        if (ids == '') {
            $("#confirm-warnning .tips").text('请选择删除人员');
            $("#confirm-warnning").modal('toggle');
        } else {
            userIds = ids;
            $("#confirm-delete").modal('toggle');
        }
    }

    function deleteData(ids) {
        var idsStr = "{\"ids\":\"" + userIds.toString() + "\"}";
        $.ajax({
            type: "POST",
            url: '${webRoot}' + "/data/pointUser/delete.do",
            data: JSON.parse(idsStr),
            dataType: "json",
            success: function (data) {
                if (data && data.success) {
                    self.location.reload();
                } else {
                    $("#confirm-delete").modal('toggle');
                    $("#confirm-warnning .tips").text('删除失败');
                    $("#confirm-warnning").modal('toggle');
                }
            }
        });
    }

    //添加人员
    function selWorker(pointsArray) {
        if (!pointsArray || pointsArray.length == 0) {
            $("#myUserModal").modal('toggle');
            $("#confirm-warnning .tips").text('添加失败，未选择添加人员');
            $("#confirm-warnning").modal('toggle');
            lock = true;
        } else {
            var ids = '';
            for (var i = 0; i < pointsArray.length; i++) {
                ids += pointsArray[i].id + ",";
            }
            if (ids) {
                ids = ids.substring(0, ids.length - 1);
            }
            var idsStr = "{\"ids\":\"" + ids + "\",\"pointId\":\"${pointId}\",\"departId\":\"${departId}\"}";
            $.ajax({
                type: "POST",
                url: '${webRoot}' + "/data/pointUser/save.do",
                data: JSON.parse(idsStr),
                dataType: "json",
                success: function (data) {
                    if (data && data.success) {
                        self.location.reload();
                        lock = true;
                    } else {
                        $('#myUserModal').modal('toggle');
                        $("#confirm-warnning .tips").text('添加人员失败');
                        $("#confirm-warnning").modal('toggle');
                        lock = true;
                    }
                }
                ,
                error: function () {
                    lock = true;
                }
            });
        }
    }
</script>
</body>
</html>
