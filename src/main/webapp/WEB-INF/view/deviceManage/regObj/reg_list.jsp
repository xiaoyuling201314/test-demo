<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/WEB-INF/view/deviceManage/resource.jsp" %>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>被检单位管理</title>
    <meta name="description" content="">
    <meta name="author" content="食安科技">
    <meta http-equiv="X-UA-Compatible" content="IE=Edge">
    <link rel="stylesheet" type="text/css" href="${webRoot}/device/iconfont/iconfont.css"/>
    <link rel="stylesheet" type="text/css" href="${webRoot}/device/css/bootstrap.css"/>
    <link rel="stylesheet" type="text/css" href="${webRoot}/device/css/instrument.css"/>
</head>

<body>
<div class="top-bar is-flex">
    <div class="top-back text-left" onclick="returnBackkAndroid();" >
        <a href="javascript:window.history.back();"><img src="${webRoot}/device/img/new.png" alt=""></a>
        <span>被检单位</span>
    </div>
    <div class="top-btn text-right select-type">
        <label><span class="move-name">单位类型：</span>
            <select id="regTypes" onchange="search()"></select>
        </label>
        <div class="cs-search-box cs-fr">
            <div class="cs-search-filter clearfix cs-fl">
                <input class="cs-input-cont cs-fl" id="keywords" type="text" placeholder="请输入内容">
                <input type="submit" class="cs-search-btn cs-fl" onclick="search()" value="搜索">
            </div>
        </div>
        <input type="button" id="regAdd" class="cs-search-btn cs-fl" style="border-radius: 0.25rem;display: none;"
               onclick="window.location.href='${webRoot}/iRegulatory/Object/regAdd?userToken=${userToken}'" value="新增">
    </div>
</div>

<div class="content">
    <table class="table-style">
        <thead>
        <tr>
            <th style="width: 3.75rem">序号</th>
            <th class="cs-header">被检单位</th>
            <th class="cs-header" style="width: 8.75rem;">单位类型</th>
            <th class="cs-header" style="width: 6.25rem;">经营户</th>
            <!--<th class="cs-header">地址</th>-->
            <th class="cs-header" style="width: 6.25rem;">状态</th>
            <th class="cs-header" style="width: 6.25rem;">操作</th>
        </tr>
        </thead>
        <tbody id="tableData">

        </tbody>
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
            getRegTypes();
            loadData();
        }

    });
    function getRegTypes() {
        $.ajax({
            type: "POST",
            url: "${webRoot}/iRegulatory/Object/regTypes",
            data: {"userToken":"${userToken}"},
            dataType: "json",
            success: function (data)  {
                 $("#regTypes").html("");
                 if (data.success) {
                     var html = '<option value="">全部</option>';
                     for (var i = 0; i < data.obj.length; i++) {
                         html += '<option value="'+data.obj[i].id+'">'+data.obj[i].regType+'</option>'
                     }
                     $("#regTypes").append(html);
                 } else {
                     showMsg(data.msg)
                 }
            },error: function (data) {
                showMsg(JSON.stringify(data))
            }
        });
    }
    function search() {
        pageConfig.pageNo = 1;
        loadData();
    }
    function loadData() {
        $.ajax({
            type: "GET",
            url: "${webRoot}/iRegulatory/Object/datagrid",
            data: {
                pageSize: pageConfig.pageSize,
                pageNo: pageConfig.pageNo,
                regName: $("#keywords").val(),
                regType: $("#regTypes").val(),
                "userToken":"${userToken}"
            },
            dataType: "json",
            success: function(data) {
                if (data.success) {
                    var html = '';
                    for (var i = 0; i < data.obj.results.length; i++) {
                        var item = data.obj.results[i];
                        html +='<tr><td>'+(i + 1)+'</td>';
                        html +='<td>'+item.regName+'</td>';
                        html +='<td>'+item.regTypeName+'</td>';
                        html +='<td>';
                        if (item.showBusiness == '1') {//显示经营户列数据
                            html +='<a href="${webRoot}/iRegulatory/Object/reg_bus_list?regId='+item.id+'&regName='+encodeURI(item.regName)+'&userToken=${userToken}" class="text-primary text-under">'+item.businessNumber+'户</a>';
                        }
                        html+='</td>';
                        html +='<td>'+(item.checked == 1 ? '<span>已审核</span>' : '<span class="text-danger">未审核</span>' )+'</td>';
                        html +='<td><a href="${webRoot}/iRegulatory/Object/regAdd?id='+item.id+'&userToken=${userToken}" class="icon iconfont icon-xiugai"></a></td>';
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
    //返回仪器界面:需先在android软件上定义callByJS方法
    function returnBackkAndroid(){
        androidObj.callByJS();
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
