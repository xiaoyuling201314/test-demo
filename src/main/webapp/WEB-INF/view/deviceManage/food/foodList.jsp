<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/WEB-INF/view/deviceManage/resource.jsp" %>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title></title>
    <meta name="description" content="">
    <meta name="author" content="食安科技">
    <meta http-equiv="X-UA-Compatible" content="IE=Edge">
    <link rel="stylesheet" type="text/css" href="${webRoot}/device/plug-in/easyui/easyui.css">
    <link rel="stylesheet" type="text/css" href="${webRoot}/device/plug-in/easyui/icon.css">
    <link rel="stylesheet" type="text/css" href="${webRoot}/device/plug-in/easyui/tree.css">
    <link rel="stylesheet" type="text/css" href="${webRoot}/device/iconfont/iconfont.css"/>
    <link rel="stylesheet" type="text/css" href="${webRoot}/device/css/bootstrap.css"/>
    <link rel="stylesheet" type="text/css" href="${webRoot}/device/css/instrument.css"/>

    <style>
        .panel-tool, .tree-icon {
            display: none;
        }

        .cs-modal-box {
            position: fixed;
            top: 0;
            bottom: 0;
            height: 100%;
            width: 100%;
            left: 0;
            background: url(${webRoot}/device/img/bg.png) center bottom no-repeat;
            background-size: 100% 100%;
        }

    </style>
</head>

<body>
<div class="top-bar is-flex" >
    <div class="top-back text-left" onclick="returnBackkAndroid();"><img src="${webRoot}/device/img/new.png" alt=""> <span>食品分类</span></div>
    <div class="top-btn text-right select-type">
        <div class="cs-search-box cs-fr">
            <form action="">
                <div class="cs-search-filter clearfix cs-fl">
                    <input class="cs-input-cont cs-fl" type="text" placeholder="请输入食品名称" id="queryText"
                           autocomplete="off">
                    <input type="button" class="cs-search-btn cs-fl" onclick="queryFoodName();" value="搜索">
                </div>
            </form>
        </div>
        <input id="addBtn" type="button" disabled class="cs-search-btn cs-fl" style="border-radius: 0.25rem" onclick="add();" value="新增">
<%--        <a href="javascript:;" <img src="${webRoot}/device/img/add.png"></a>--%>
    </div>
</div>

<div class="easyui-layout">
    <div data-options="region:'west',split:true" style="width:300px;padding:10px;">
        <ul id="foodType" class="easyui-tree"></ul>
    </div>
    <div data-options="region:'center'" class="center-content">
        <table class="table-style">
            <thead>
            <tr>
                <th style="width: 3.5rem">序号</th>
                <th class="cs-header" style="width: 16%;" >种类</th>
                <th class="cs-header" style="width: 18%;">食品名称</th>
                <th class="cs-header" style="width: 35%;">常用别称</th>
                <th class="cs-header" style="width: 5rem;">状态</th>
                <th class="cs-header" style="width: 3.75rem">操作</th>
            </tr>
            </thead>
            <tbody id="foodsTbody"></tbody>
        </table>
    </div>
</div>

<%--新增编辑--%>
<div class="cs-modal-box cs-hide" id="saveBox">
    <div class="top-bar is-flex">
        <div class="top-back text-left">
            <a href="javascript:;" onclick="closeBox();"><img src="${webRoot}/device/img/new.png"></a>
            <span id="title1">新增食品</span></div>
        <div class="top-btn text-right"></div>
    </div>
    <div class="content">
        <form id="saveform">
            <div class="form-group">
                <div class="group-row">
                    <input type="hidden" name="userToken" value="${userToken}">
                    <input type="hidden" name="serialNumber" value="${serialNumber}">
                    <input type="hidden" name="id">
                    <input type="hidden" name="parentId">
                    <input type="hidden" name="isFood" value="1">
                    <label><span class="move-name">食品类别：</span><input type="text" name="foodTypeName"
                                                                      disabled="disabled"></label>
                </div>
                <div class="group-row">
                    <label><span class="move-name"><i class="text-danger">*</i>食品名称：</span><input type="text"
                                                                                                  name="foodName"
                                                                                                  autocomplete="off"></label>
                </div>
                <div class="group-row">
                    <label><span class="move-name">常用别称：</span><input type="text" name="foodNameOther"
                                                                      autocomplete="off"></label>
                </div>
                <div class="group-row group-row2">
                    <label><span class="move-name"><i class="text-danger">*</i>状态：</span>
                        <select name="checked">
                            <option value="1" checked>已审核</option>
                            <option value="0">未审核</option>
                        </select>
                    </label>
                </div>
                <%--
                <div class="group-row group-row2">
                    <label><span class="move-name"><i class="text-danger">*</i>状态：</span>
                        <select style="width: 50%;">
                            <option value="" checked>私有</option>
                            <option value="">共享</option>
                        </select>
                        <span>(只有本单位可见)</span>
                        <span class="cs-hide">(所有单位都可见)	</span>
                    </label>
                </div>
                --%>
                <div class="btn-list">
                    <a href="javascript:;" onclick="closeBox();" class="btn text-danger">取消</a>
                    <a href="javascript:;"  onclick="save();" class="btn">确定</a>
                </div>
                <div class="food-project" id="foodItems">
                    <h4><b>常用检测项目</b></h4>
                    <div class="project-list" style="overflow: auto">
                        <ul></ul>
                    </div>
                </div>
            </div>
        </form>
    </div>
</div>

<%--提醒--%>
<%--<div id="message" style="position: absolute; top: 50px; left: 0; right: 0;padding: 10px;display: none">
    <div class="alert alert-danger">no message</div>
</div>--%>
<%@include file="/WEB-INF/view/deviceManage/showMessage.jsp" %>
<script type="text/javascript" src="${webRoot}/device/js/jquery.min1.11.3.js"></script>
<script type="text/javascript" src="${webRoot}/device/plug-in/easyui/jquery.min.js"></script>
<script type="text/javascript" src="${webRoot}/device/plug-in/easyui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="${webRoot}/device/js/bootstrap.min.js"></script>
<%--<script src="${webRoot}/device/common/js/common.js"></script>--%>

<script type="text/javascript">

    //当前选中食品种类
    var foodTypeId, foodTypeName;

    $(function () {
        var ut = '${userToken}';
        if (!ut) {
            showMsg("用户token已失效，请重新登录！");
        } else {
            loadFoodTree();
        }

        //加载食品种类树形控件数据列表
        var treeLevel = 1;	//控制机构树加载二级数据
        function loadFoodTree() {
            $("#foodType").tree({
                checkbox: false,
                url: "${webRoot}/iDeviceManage/foodTree?userToken=${userToken}",
                animate: true,
                onClick: function (node) {
                    //清空查询食品名称
                    $("#queryText").val("");
                    //查询种类下食品名称
                    foodTypeId = node.id;
                    foodTypeName = node.text;
                    getFoods();

                    //控制新增按钮
                /*    if ($(this).tree('getChildren', node.target).length == 0) {
                        $("#addBtn").removeAttr("disabled");
                    } else {
                        $("#addBtn").attr("disabled","disabled");
                    }*/

                    //展开节点
                    $(this).tree('expand',node.target);
                },
                onLoadSuccess: function (node, data) {
                    //延迟执行自动加载二级数据，避免与异步加载冲突
                    setTimeout(function () {
                        if (data && treeLevel == 1) {
                            treeLevel++;
                            $(data).each(function (index, d) {
                                if (this.state == 'closed') {
                                    var children = $('#foodType').tree('getChildren');
                                    for (var i = 0; i < children.length; i++) {
                                        $('#foodType').tree('expand', children[i].target);
                                    }
                                }
                            });
                        }
                    }, 100);
                }
            });
        }
    });

    //查询种类下食品名称
    function getFoods() {
        $.ajax({
            type: "POST",
            url: "${webRoot}/iDeviceManage/getFoods",
            data: {"id": foodTypeId,"userToken":'${userToken}'},
            dataType: "json",
            success: function (data) {
                $("#foodsTbody").html("");
                //控制新增按钮
                if (data.obj.foodTypeCounts==0) {
                    $("#addBtn").removeAttr("disabled");
                } else {
                    $("#addBtn").attr("disabled","disabled");
                }
                var foodData=data.obj.foods;
                if (foodData && foodData.length > 0) {
                    $.each(foodData, function (index, value) {
                        var foodTr =
                            "<tr>" +
                            "<td class=\"number\">" + (index + 1) + "</td>" +
                            "<td class=\"foodType\">" + foodTypeName + "</td>" +
                            "<td class=\"foodName\">" + value.foodName + "</td>" +
                            "<td class=\"OtherName\">" + value.foodNameOther + "</td>" +
                            "<td class=\"checked\">" + (value.checked ? "已审核" : "<span style='color: red;'>未审核</span>") + "</td>" +
                            "<td>" +
                            "<a class=\"icon iconfont icon-xiugai\" onclick=\"edit('" + value.id + "','" + value.parentId + "','" + foodTypeName + "','" + value.foodName + "','" + value.foodNameOther + "','" + value.checked + "')\"></a>" +
                            "</td>" +
                            "</tr>";
                        $("#foodsTbody").append(foodTr);
                    });
                }
            }
        });
    }

    //查询食品名称
    function queryFoodName() {
       /* if (!($("#queryText").val())) {
            return;
        }*/
        $.ajax({
            type: "POST",
            url: "${webRoot}/iDeviceManage/queryFoodName",
            data: {"foodName": $("#queryText").val(),"userToken":'${userToken}'},
            dataType: "json",
            success: function (data) {
                $("#foodsTbody").html("");
                if (data && data.length > 0) {
                    $.each(data, function (index, value) {
                        var foodTr =
                            "<tr>" +
                            "<td class=\"number\">" + (index + 1) + "</td>" +
                            "<td class=\"foodType\">" + value.parentName + "</td>" +
                            "<td class=\"foodName\">" + value.foodName + "</td>" +
                            "<td class=\"OtherName\">" + value.foodNameOther + "</td>" +
                            "<td class=\"checked\">" + (value.checked ? "已审核" : "<span style='color: red;'>未审核</span>") + "</td>" +
                            "<td>" +
                            "<a class=\"icon iconfont icon-xiugai\" onclick=\"edit('" + value.id + "','" + value.parentId + "','" + value.parentName + "','" + value.foodName + "','" + value.foodNameOther + "','" + value.checked + "')\"></a>" +
                            "</td>" +
                            "</tr>";
                        $("#foodsTbody").append(foodTr);
                    });
                }
            }
        });
    }

    //新增页面
    function add() {
        $("#title1").text("新增食品");
        if (!foodTypeId) {
            showMsg("请先选择食品种类！");
            return;
        }
        $("#saveBox input[name=parentId]").val(foodTypeId);
        $("#saveBox input[name=foodTypeName]").val(foodTypeName);
        getFoodItem(foodTypeId);
        $("#saveBox").show();
    }

    //编辑页面
    function edit(id, parentId, parentName, foodName, otherName, checked) {
        $("#title1").text("编辑食品");
        $("#saveBox input[name=id]").val(id);
        $("#saveBox input[name=parentId]").val(parentId);
        $("#saveBox input[name=foodTypeName]").val(parentName);
        $("#saveBox input[name=foodName]").val(foodName);
        $("#saveBox input[name=foodNameOther]").val(otherName);
        $("#saveBox select[name=checked]").val(checked);
        getFoodItem(id);
        $("#saveBox").show();
    }

    //关闭新增编辑页面
    function closeBox() {
        $("#message").hide();
        $("#saveBox input").val("");
        $("#saveBox input[name=userToken]").val('${userToken}');
        $("#saveBox input[name=serialNumber]").val('${serialNumber}');
        $("#saveBox input[name=isFood]").val(1);
        $("#saveBox select[name=checked]").val(1);
        $("#saveBox").hide();
    }

    //新增编辑页面，展示食品常用检测项目。新增使用种类ID，编辑使用食品ID
    function getFoodItem(id) {
        $.ajax({
            type: "POST",
            url: "${webRoot}/iDeviceManage/getFoodItem",
            data: {"id": id,"userToken":'${userToken}'},
            dataType: "json",
            success: function (data) {
                if (data && data.length > 0) {
                    $("#foodItems").show();
                    $("#foodItems ul").html("");
                    $.each(data, function (index, value) {
                        $("#foodItems ul").append("<li>").append(value.detectName).append("</li>");
                    });
                } else {
                    $("#foodItems").hide();
                }
            }
        });
    }

    //保存
    function save() {
        var fn = $("#saveBox input[name=foodName]").val().trim();
        if (!fn) {
            showMsg("食品名称不能为空！");
        }else{
            $.ajax({
                type: "POST",
                url: '${webRoot}/iDeviceManage/save',
                data: $('#saveform').serialize(),
                dataType: "json",
                success: function (data) {
                    if (data.success) {
                        //刷新数据
                        getFoods();
                        //关闭编辑页面
                        closeBox();
                    } else {
                        showMsg("保存样品失败！"+data.msg);
                    }
                }
            });
        }
    }
    //返回仪器界面:需先在android软件上定义callByJS方法
    function returnBackkAndroid(){
        androidObj.callByJS();
    }

</script>
</body>
</html>
