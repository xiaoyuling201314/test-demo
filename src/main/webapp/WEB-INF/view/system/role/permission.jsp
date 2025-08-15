<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@include file="/WEB-INF/view/common/resource.jsp" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <style>
        .cs-tb-box table {
            table-layout: fixed;
        }
    </style>
</head>
<body>

<div class="cs-col-lg clearfix">
    <!-- 面包屑导航栏  开始-->
    <ol class="cs-breadcrumb cs-fl">
        <li class="cs-fl"><img src="${webRoot}/img/set.png" alt=""/>
        <li class="cs-fl">数据中心</li>
        <li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
        <li class="cs-fl">角色管理</li>
        <li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
        <li class="cs-b-active cs-fl">权限配置:${bean.rolename}</li>
    </ol>

    <!-- 面包屑导航栏  结束-->
    <div class="cs-search-box cs-fr">
        <a href="list.do" class="cs-menu-btn"><i class="icon iconfont icon-fanhui"></i>返回</a>
    </div>
</div>
<div class="cs-tb-box">
    <div class="cs-base-detail">
        <div class="cs-search-box col-md-12">
            <ul class="cs-ul-form clearfix">
                <li class="cs-name col-xs-1 col-md-1">菜单类型：</li>
                <li class="col-xs-8 col-md-8"><input id="cs-check-radio" type="radio" value="0"
                                                     name="functionType" checked="checked" class="functionType"/><label
                        for="cs-check-radio">云平台</label> <input
                        id="cs-check-radio2" type="radio" value="1" name="functionType" class="functionType"/><label
                        for="cs-check-radio2">APP</label> <input id="cs-check-radio3" type="radio" value="2"
                                                                 name="functionType"
                                                                 class="functionType"/><label
                        for="cs-check-radio3">工作站</label>
                    <input id="cs-check-radio4" type="radio" value="3" name="functionType"
                           class="functionType"/><label for="cs-check-radio4">公众号</label></li>
            </ul>
        </div>
        <div class="cs-content2 clearfix">
            <form action="${webRoot}/system/role/addMunes.do" method="post">
                <input type="hidden" name="roleId" value="${bean.id}"/>
                <div class="cs-add-pad">
                    <table class="cs-per-table">
                        <tr>
                            <th class="cs-header" style="width: 120px;">一级菜单</th>
                            <th class="cs-header" style="width: 120px;">二级菜单</th>
                            <th class="cs-header" style="width: 150px;">三级菜单</th>
                            <th class="cs-header">操作功能</th>
                        </tr>
                        <c:forEach items="${firstMenu}" var="menu" varStatus="firstIndex">
                            <tr>
                            <!-- 首页 或者微信公众号-->
                            <c:if test="${menu.subTotal eq 0}">
                                <td rowspan="1" class="cs-a"><input type="checkbox" id="${menu.id}" value="${menu.id}"
                                                                    name="menuCheckBox" data-menu1="${firstIndex.index}"
                                                                    data-menuAll="${firstIndex.index}"/> <label
                                        for="${menu.id}">${menu.functionName}</label></td>
                                <td></td>
                                <td></td>
                                <c:if test="${functionType eq 3}">
                                    <c:choose>
                                        <c:when test="${fn:length(menu.operationList)>0}">
                                            <c:forEach items="${menu.operationList}" var="operation" varStatus="fourthIndex">
                                                <c:choose>
                                                    <c:when test="${fourthIndex.index==0}">
                                                        <td class="cs-a1-1 cs-fun-list">
                                                        <ul>
                                                        <li><input type="checkbox" id="${operation.id}" value="${operation.id}"
                                                                   name="btnCheckBox"
                                                                   data-menu1="${firstIndex.index}"
                                                                   data-menu3="x"
                                                                   data-menu4="${fourthIndex.index}"
                                                                   data-menuAll="${firstIndex.index}_${fourthIndex.index}_x_x"/>
                                                            <label
                                                                    for="${operation.id}">${operation.operationName}</label>
                                                        </li>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <li><input type="checkbox" id="${operation.id}" value="${operation.id}"
                                                                   name="btnCheckBox"
                                                                   data-menu1="${firstIndex.index}"
                                                                   data-menu3="x"
                                                                   data-menu4="${fourthIndex.index}"
                                                                   data-menuAll="${firstIndex.index}_${fourthIndex.index}_x_x"/>
                                                            <label
                                                                    for="${operation.id}">${operation.operationName}</label>
                                                        </li>
                                                    </c:otherwise>
                                                </c:choose>
                                                <c:if test="${fn:length(menu.operationList)==fourthIndex.index}">
                                                    </ul>
                                                    </td>
                                                </c:if>
                                            </c:forEach>
                                        </c:when>
                                        <c:otherwise>
                                            <td></td>
                                        </c:otherwise>
                                    </c:choose>
                                </c:if>

                                <c:if test="${functionType ne 3}">
                                    <td></td>
                                </c:if>
                            </c:if>
                            <c:if test="${menu.subTotal ne 0}">
                                <td rowspan="${menu.subTotal}" class="cs-a"><input type="checkbox" id="${menu.id}"
                                                                                   value="${menu.id}"
                                                                                   name="menuCheckBox"
                                                                                   data-menu1="${firstIndex.index}"
                                                                                   data-menuAll="${firstIndex.index}"/>
                                    <label
                                            for="${menu.id}">${menu.functionName}</label></td>
                            </c:if>
                            <c:forEach items="${menu.subMenu}" var="subMenu" varStatus="secondIndex">
                                <td rowspan="${subMenu.subTotal==0?1:subMenu.subTotal}"><input type="checkbox"
                                                                                               id="${subMenu.id}"
                                                                                               value="${subMenu.id}"
                                                                                               name="menuCheckBox"
                                                                                               data-menu1="${firstIndex.index}"
                                                                                               data-menu2="${secondIndex.index}"
                                                                                               data-menuAll="${firstIndex.index}_${secondIndex.index}"/>
                                    <label for="${subMenu.id}">${subMenu.functionName}</label>
                                </td>
                                <!-- add by xiaoyuling start 2017-09-18 -->
                                <!-- APP、工作站操作功能权限 -->
                                <c:if test="${subMenu.subTotal==0}">
                                    <td></td>
                                    <c:if test="${fn:length(subMenu.operationList)==0}">
                                        <td></td>
                                    </c:if>
                                    <c:forEach items="${subMenu.operationList}" var="operation" varStatus="fourthIndex">
                                        <c:choose>
                                            <c:when test="${fourthIndex.index==0}">
                                                <td class="cs-a1-1 cs-fun-list">
                                                <ul>
                                                <li><input type="checkbox" id="${operation.id}" value="${operation.id}"
                                                           name="btnCheckBox"
                                                           data-menu1="${firstIndex.index}"
                                                           data-menu2="${secondIndex.index}" data-menu3="x"
                                                           data-menu4="${fourthIndex.index}"
                                                           data-menuAll="${firstIndex.index}_${secondIndex.index}_x_x"/>
                                                    <label
                                                            for="${operation.id}">${operation.operationName}</label>
                                                </li>
                                            </c:when>
                                            <c:otherwise>
                                                <li><input type="checkbox" id="${operation.id}" value="${operation.id}"
                                                           name="btnCheckBox"
                                                           data-menu1="${firstIndex.index}"
                                                           data-menu2="${secondIndex.index}" data-menu3="x"
                                                           data-menu4="${fourthIndex.index}"
                                                           data-menuAll="${firstIndex.index}_${secondIndex.index}_x_x"/>
                                                    <label
                                                            for="${operation.id}">${operation.operationName}</label>
                                                </li>
                                            </c:otherwise>
                                        </c:choose>
                                        <c:if test="${fn:length(subMenu.operationList)==fourthIndex.index}">
                                            </ul>
                                            </td>
                                        </c:if>
                                    </c:forEach>
                                    <%-- <c:if test="${fn:length(subMenu.operationList)==secondIndex.index}">
                                        <td></td>
                                    </c:if> --%>
                                    <c:if test="${subMenu.subTotal==0}">
                                        </tr>
                                    </c:if>
                                </c:if>
                                <!-- add by xiaoyuling end 2017-09-18 -->
                                <c:forEach items="${subMenu.subMenu}" var="thirdMenu" varStatus="thirdIndex">
                                    <c:choose>
                                        <c:when test="${thirdIndex.index==0}">
                                            <td><input type="checkbox" id="${thirdMenu.id}" value="${thirdMenu.id}"
                                                       name="menuCheckBox"
                                                       data-menu1="${firstIndex.index}"
                                                       data-menu2="${secondIndex.index}"
                                                       data-menu3="${thirdIndex.index}"
                                                       data-menuAll="${firstIndex.index}_${secondIndex.index}_${thirdIndex.index}"/>
                                                <label for="${thirdMenu.id}">${thirdMenu.functionName}</label>
                                            </td>
                                            <!-- add by xiaoyuling 2017-11-06 start-->
                                            <c:if test="${fn:length(thirdMenu.operationList)==0}">
                                                <td></td>
                                            </c:if>
                                            <!-- add by xiaoyuling 2017-11-06 end-->
                                            <c:forEach items="${thirdMenu.operationList}" var="operation"
                                                       varStatus="fourthIndex">
                                                <c:choose>
                                                    <c:when test="${fourthIndex.index==0}">
                                                        <td class="cs-a1-1 cs-fun-list">
                                                        <ul>
                                                        <li><input type="checkbox" id="${operation.id}"
                                                                   value="${operation.id}" name="btnCheckBox"
                                                                   data-menu1="${firstIndex.index}"
                                                                   data-menu2="${secondIndex.index}"
                                                                   data-menu3="${thirdIndex.index}"
                                                                   data-menu4="${fourthIndex.index}"
                                                                   data-menuAll="${firstIndex.index}_${secondIndex.index}_${thirdIndex.index}_x"/>
                                                            <label
                                                                    for="${operation.id}">${operation.operationName}</label>
                                                        </li>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <li><input type="checkbox" id="${operation.id}"
                                                                   value="${operation.id}" name="btnCheckBox"
                                                                   data-menu1="${firstIndex.index}"
                                                                   data-menu2="${secondIndex.index}"
                                                                   data-menu3="${thirdIndex.index}"
                                                                   data-menu4="${fourthIndex.index}"
                                                                   data-menuAll="${firstIndex.index}_${secondIndex.index}_${thirdIndex.index}_x"/>
                                                            <label
                                                                    for="${operation.id}">${operation.operationName}</label>
                                                        </li>
                                                    </c:otherwise>
                                                </c:choose>
                                                <c:if test="${fn:length(thirdMenu.operationList)==fourthIndex.index}">
                                                    </ul>
                                                    </td>
                                                </c:if>
                                            </c:forEach>
                                        </c:when>
                                        <c:otherwise>
                                            <tr>
                                                <td><input type="checkbox" id="${thirdMenu.id}" value="${thirdMenu.id}"
                                                           name="menuCheckBox"
                                                           data-menu1="${firstIndex.index}"
                                                           data-menu2="${secondIndex.index}"
                                                           data-menu3="${thirdIndex.index}"
                                                           data-menuAll="${firstIndex.index}_${secondIndex.index}_${thirdIndex.index}"/>
                                                    <label
                                                            for="${thirdMenu.id}">${thirdMenu.functionName}</label></td>
                                                <c:if test="${fn:length(thirdMenu.operationList)==0}">
                                                    <td class="cs-a1-1 cs-fun-list">
                                                        <ul>
                                                        </ul>
                                                    </td>
                                                </c:if>
                                                <!-- add by xiaoyuling 2017-11-06 start-->
                                                    <%-- <c:if test="${fn:length(thirdMenu.operationList)==0}">
                                                        <td></td>
                                                    </c:if> --%>
                                                <!-- add by xiaoyuling 2017-11-06 end-->
                                                <c:forEach items="${thirdMenu.operationList}" var="operation"
                                                           varStatus="fourthIndex">
                                                    <c:choose>
                                                        <c:when test="${fourthIndex.index==0}">
                                                            <td class="cs-a1-1 cs-fun-list">
                                                            <ul>
                                                            <li><input type="checkbox" id="${operation.id}"
                                                                       value="${operation.id}" name="btnCheckBox"
                                                                       data-menu1="${firstIndex.index}"
                                                                       data-menu2="${secondIndex.index}"
                                                                       data-menu3="${thirdIndex.index}"
                                                                       data-menu4="${fourthIndex.index}"
                                                                       data-menuAll="${firstIndex.index}_${secondIndex.index}_${thirdIndex.index}_x"/>
                                                                <label
                                                                        for="${operation.id}">${operation.operationName}</label>
                                                            </li>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <li><input type="checkbox" id="${operation.id}"
                                                                       value="${operation.id}" name="btnCheckBox"
                                                                       data-menu1="${firstIndex.index}"
                                                                       data-menu2="${secondIndex.index}"
                                                                       data-menu3="${thirdIndex.index}"
                                                                       data-menu4="${fourthIndex.index}"
                                                                       data-menuAll="${firstIndex.index}_${secondIndex.index}_${thirdIndex.index}_x"/>
                                                                <label
                                                                        for="${operation.id}">${operation.operationName}</label>
                                                            </li>
                                                        </c:otherwise>
                                                    </c:choose>
                                                    <c:if test="${fn:length(thirdMenu.operationList)==fourthIndex.index}">
                                                        </ul>
                                                        </td>
                                                    </c:if>
                                                </c:forEach>
                                            </tr>
                                        </c:otherwise>
                                    </c:choose>
                                    <c:if test="${subMenu.subTotal==0}">
                                        <td></td>
                                        <td></td>
                                    </c:if>
                                    <c:if test="${subMenu.subTotal==1}">
                                        <!-- delete by xiaoyuling 2017-11-06 -->
                                        <!-- <td></td> -->
                                        </tr>
                                        <!-- delete by xiaoyuling 2018-10-18 -->
                                        <!-- <tr> -->
                                    </c:if>
                                </c:forEach>
                            </c:forEach>

                            </tr>
                        </c:forEach>

                    </table>
                </div>
                <!-- 底部导航 结束 -->
                <div class="cs-alert-form-btn clearfix">
                    <a href="javascript:" class="cs-menu-btn cs-fun-btn " id="btnSaveRight"
                       onclick="submitRole();"><i class="icon iconfont icon-save"></i>保存</a>
                    <a href="list.do" class="cs-menu-btn cs-fun-btn"><i class="icon iconfont icon-fanhui"></i>返回</a>
                </div>
            </form>
        </div>
    </div>
</div>
<!-- 内容主体 结束 -->
<%@include file="/WEB-INF/view/common/confirm.jsp" %>
<script type="text/javascript">
    rootPath = "${webRoot}/system/role/";
    $(function () {
        $('input:radio[name="functionType"]').eq("${functionType}").attr("checked", true);
        //根据角色ID加载已经配置好的权限，并设置已勾选 start
        $.ajax({
            type: "POST",
            url: rootPath + "queryRight.do",
            data: {
                "roleId": $("input[name=roleId]").val()
            },
            dataType: "json",
            success: function (data) {
                var json = eval(data.obj);
                $.each(json, function (index, item) {
                    $("#" + item.functionId).prop("checked", "checked");
                });
            },
            error: function () {
                $("#confirm-warnning").modal('toggle');
            }
        });

        //根据角色ID加载已经配置好的权限，并设置已勾选 end

        $("input[name=functionType]").on("click", function (e) {
            self.location = "${webRoot}/system/role/permission.do?id=${bean.id}&functionType=" + $("input:radio[name=functionType]:checked").val();
        });

        //选择框选择与取消事件
        $(":checkbox").change(function () {
            var boxName = $(this).attr("data-menuAll");
            var boxNameList = boxName.split("_");
            var checked = $(this).prop("checked");
            switch (boxNameList.length) {
                case 1:
                    $(":checkbox").each(function () {
                        //下级
                        if ($(this).attr("data-menu1") == boxNameList[0]) {
                            if (checked) { //选中
                                $(this).prop("checked", true);
                            } else { //取消
                                $(this).prop("checked", false);
                            }
                        }
                    });
                    break;
                case 2:
                    $(":checkbox").each(function () {
                        //选中上级
                        if (checked && $(this).attr("data-menu1") == boxNameList[0] && !$(this).attr("data-menu2")) {
                            $(this).prop("checked", true);
                        }
                        //下级
                        if ($(this).attr("data-menu1") == boxNameList[0] && $(this).attr("data-menu2") == boxNameList[1]) {
                            if (checked) { //选中
                                $(this).prop("checked", true);
                            } else { //取消
                                $(this).prop("checked", false);
                            }
                        }
                    });
                    break;
                case 3:
                    $(":checkbox").each(function () {
                        //选中上级
                        if (checked && $(this).attr("data-menu1") == boxNameList[0] && !$(this).attr("data-menu2")) {
                            $(this).prop("checked", true);
                        }
                        if (checked && $(this).attr("data-menu1") == boxNameList[0] && $(this).attr("data-menu2") == boxNameList[1] && !$(this).attr("data-menu3")) {
                            $(this).prop("checked", true);
                        }
                        //下级
                        if ($(this).attr("data-menu1") == boxNameList[0] && $(this).attr("data-menu2") == boxNameList[1] && $(this).attr("data-menu3") == boxNameList[2]) {
                            if (checked) { //选中
                                $(this).prop("checked", true);
                            } else { //取消
                                $(this).prop("checked", false);
                            }
                        }
                    });
                    break;
                case 4:
                    $(":checkbox").each(function () {
                        //选中上级
                        if (checked && $(this).attr("data-menu1") == boxNameList[0] && !$(this).attr("data-menu2")) {
                            $(this).prop("checked", true);
                        }
                        if (checked && $(this).attr("data-menu1") == boxNameList[0] && $(this).attr("data-menu2") == boxNameList[1] && !$(this).attr("data-menu3")) {
                            $(this).prop("checked", true);
                        }
                        if (checked && $(this).attr("data-menu1") == boxNameList[0] && $(this).attr("data-menu2") == boxNameList[1] && $(this).attr("data-menu3") == boxNameList[2] && !$(this).attr("data-menu4")) {
                            $(this).prop("checked", true);
                        }
                    });
                    break;
            }
        });

    });

    function submitRole() {
        //$("#btnSaveRight").on("click", function() {
        var disabledState = $("#btnSaveRight").attr('disabled');
        if ('disabled' == disabledState) {
            return;
        }
        $("#btnSaveRight").attr('disabled', 'disabled');

        $("#btnSaveRight").html('<i class="icon iconfont icon-save"></i>保存中...');
        var cbs = document.getElementsByName("menuCheckBox");
        var menuIds = [];
        var deleteMenuIds = [];
        for (var i = 0; i < cbs.length; i++) {
            if (cbs[i].checked == true) {
                menuIds.push(cbs[i].value);
            } else {
                deleteMenuIds.push(cbs[i].value);
            }
        }
        cbs = document.getElementsByName("btnCheckBox");
        operationIds = [];
        for (var i = 0; i < cbs.length; i++) {
            if (cbs[i].checked == true) {
                operationIds.push(cbs[i].value);
            } else {
                deleteMenuIds.push(cbs[i].value);
            }
        }
        var roleId = $("input[name=roleId]").val();
        idsStr = "{\"menuIds\":\"" + menuIds.toString() + "\",\"btnIds\":\"" + operationIds.toString() + "\",\"deleteIds\":\"" + deleteMenuIds.toString() + "\",\"roleId\":\"" + roleId + "\"}";
        $.ajax({
            type: "POST",
            url: rootPath + "addMunes.do",
            data: JSON.parse(idsStr),
            dataType: "json",
            success: function (data) {
                if (data && data.success) {
                    self.location = "${webRoot}/system/role/list.do";
                } else {
                    $("#confirm-warnning").modal('toggle');
                }
            },
            error: function () {
                $("#confirm-warnning").modal('toggle');
            }
        });
        //});
    }
</script>
</body>
</html>
