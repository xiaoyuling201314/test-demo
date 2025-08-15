<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/WEB-INF/view/deviceManage/resource.jsp" %>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>经营户管理</title>
    <meta name="description" content="">
    <meta name="author" content="食安科技">
    <meta http-equiv="X-UA-Compatible" content="IE=Edge">
    <link rel="stylesheet" type="text/css" href="${webRoot}/device/iconfont/iconfont.css"/>
    <link rel="stylesheet" type="text/css" href="${webRoot}/device/css/bootstrap.css"/>
    <link rel="stylesheet" type="text/css" href="${webRoot}/device/css/instrument.css"/>
</head>

<body>
<div class="top-bar is-flex">
    <div class="top-back text-left">
        <a href="javascript:window.history.back();"><img src="${webRoot}/device/img/new.png" alt=""></a>
        <span id="regName"></span>
    </div>
    <div class="top-btn text-right select-type">
        <div class="cs-search-box cs-fr">
            <div class="cs-search-filter clearfix cs-fl">
                <input class="cs-input-cont cs-fl" type="text" id="keywords" placeholder="请输入内容">
                <input type="submit" class="cs-search-btn cs-fl" onclick="search()" value="搜索">
            </div>
        </div>
        <!--<a id="add_bus_href"><img src="../img/add.png"></a>-->
        <input type="button" class="cs-search-btn cs-fl" style="border-radius: 0.25rem" onclick="addBus()" value="新增">
    </div>
</div>
<div class="content">
    <table class="table-style">
        <thead>
        <tr>
            <th style="width: 3.75rem">序号</th>
            <th class="cs-header" style="width: 10rem;">摊位编号</th>
            <th class="cs-header">摊位名称</th>
            <th class="cs-header" style="width: 8.25rem;">经营者</th>
            <th class="cs-header" style="width: 8.25rem;">联系方式</th>
            <th class="cs-header" style="width: 6.25rem;">状态</th>
            <th class="cs-header" style="width: 6.25rem;">操作</th>
        </tr>
        </thead>
        <tbody id="tableData"></tbody>
    </table>
</div>
<div id="noData" class="no-data cs-hide">
    <img src="${webRoot}/device/img/logo.png" alt="" style="width: 60px">
    <p style="font-size:16px;margin-top: 5px;">暂无数据</p>
</div>
<%@include file="/WEB-INF/view/deviceManage/showMessage.jsp" %>
<script type="text/javascript" src="${webRoot}/device/js/jquery.min1.11.3.js"></script>
<script type="text/javascript" src="${webRoot}/device/js/bootstrap.min.js"></script>

<script type="text/javascript">
    var regId = '${regId}';
    var regName = '${regName}';
    $("#regName").text("经营户（" + regName + "）");

    function addBus() {
        window.location.href = "${webRoot}/iRegulatory/Object/reg_bus_add?userToken=${userToken}&regId=" + regId + "&regName=" + encodeURI(regName);
    }
    var pageConfig = {
        pageSize: 10000,
        pageNo: 1,
        rowTotal: 0,
        pageCount: 0,
    };
    var $tableData = $("#tableData");
    var $noData = $("#noData");
    $(document).ready(function(){
        var ut = '${userToken}';
        if (!ut) {
            showMsg("用户token已失效，请重新登录！");
        } else {
            loadData();
        }
    });
    function search() {
        pageConfig.pageSize = 10;
        pageConfig.pageNo = 1;
        loadData();
    }
    function loadData() {
        $.ajax({
            type: "GET",
            url: "${webRoot}/iRegulatory/Object/bus",
            data: {
                pageSize: pageConfig.pageSize,
                pageNo: pageConfig.pageNo,
                opeShopName: $("#keywords").val(),
                regId: regId,
                "userToken":"${userToken}"
            },
            dataType: "json",
            success: function(data) {
                if (data.success) {
                    var html = '';
                    for (var i = 0; i < data.obj.results.length; i++) {
                        var item = data.obj.results[i];
                        html +='<tr><td>'+(i + 1)+'</td>';
                        html +='<td>'+item.opeShopCode+'</td>';
                        html +='<td>'+item.opeShopName+'</td>';
                        html +='<td>'+item.opeName+'</td>';
                        html +='<td>'+item.opePhone+'</td>';
                        html +='<td>'+(item.checked == 1 ? '<span>已审核</span>' : '<span class="text-danger">未审核</span>' )+'</td>';
                        html +='<td><a href="${webRoot}/iRegulatory/Object/reg_bus_add?id='+item.id+'&regId='+regId+'&regName='+encodeURI(regName)+'&userToken=${userToken}" class="icon iconfont icon-xiugai  icon-xiugai"></a></td>';
                        html +='</tr>';
                    }
                    $tableData.html(html);
                    html ? $noData.addClass("cs-hide") : $noData.removeClass("cs-hide");
                } else {
                    showMsg(msg)
                }
            }
        });
    }
    //从编辑页面返回：延迟刷新数据
    window.addEventListener('pageshow', function (event) {
        //event.persisted属性为true时，表示当前文档是从往返缓存中获取
        //window.performance.navigation.type === 2: 网页通过“前进”或“后退”按钮加载
        if (event.persisted || window.performance && window.performance.navigation.type === 2) {
            setTimeout(function () {
                loadData();//当网页是从缓存中获取时需要重新加载数据
            }, 200)
        }
    }, false);
</script>
</body>
</html>
