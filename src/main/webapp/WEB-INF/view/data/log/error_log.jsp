<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@include file="/WEB-INF/view/common/resource.jsp" %>
<%--复制功能js的引入--%>
<script src="${webRoot}/plug-in/clipboard/clipboard.min.js"></script>
<html>
<head>
    <meta charset="utf-8">
    <meta name="description" content="">
    <meta name="author" content="食安科技">
    <meta http-equiv="X-UA-Compatible" content="IE=Edge">
    <title>快检服务云平台</title>
</head>
<body>
<div class="cs-col-lg clearfix">
    <!-- 面包屑导航栏  开始-->
    <ol class="cs-breadcrumb">
        <li class="cs-fl"><img src="${webRoot}/img/set.png" alt=""/> <a
                href="javascript:">系统管理</a></li>
        <li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
        <li class="cs-fl">日志管理</li>
    </ol>
    <!-- 面包屑导航栏  结束-->
    <div class="cs-fl " style="margin:3px 0 0 30px;">
        <select class="cs-selcet-style" style="width: 100px;" id="deviceType" name="status" onchange="deviceTypeChange()">
            <option value="APP">APP</option>
            <option value="">--全部--</option>
        </select>

        <span class="cs-custom cs-fr" style="margin-left: 5px;">
	                <span class="cs-in-style cs-time-se">
	                	<input placeholder="开始时间" id="d4311" name="startTime" class="cs-time" type="text" autocomplete="off"
                               onFocus="WdatePicker({maxDate:'#F{$dp.$D(\'d4312\')||\'%y-%M-%d %H:%m:%s\'}',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true,onpicked:function() {deviceTypeChange('')}})">
	                	<span style="padding:0 5px;">至</span>
	                    <input placeholder="结束时间" id="d4312" name="endTime" class="cs-time" type="text"  autocomplete="off"
                               onFocus="WdatePicker({minDate:'#F{$dp.$D(\'d4311\')||\'%y-%M-%d\'}',maxDate:'%y-%M-%d %H:%m:%s',startDate:'%y-%M-%d %H:%m:%s',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true,onpicked:function() {deviceTypeChange('')}})">
                    </span>
              </span>
        </span>
    </div>
    <div class="cs-search-box cs-fl" style="margin-left:5px; padding-top:3px;">
        <form action="datagrid.do">
            <div class="cs-search-filter clearfix cs-fl">
                <input class="cs-input-cont cs-fl focusInput" type="text" name="keyword" placeholder="请输入人员名称"/>
                <input type="button" onclick="datagridUtil.queryByFocus();" class="cs-search-btn cs-fl" href="javascript:;" value="搜索">
                <%-- <input class="cs-input-cont cs-fl" type="text" name="keyword" placeholder="请输入内容">--%>
                <%--<a href="javascript:;" class="cs-menu-btn" style="margin:0px 0 0 10px;" onclick="bigbang()"><i class="icon iconfont icon-chakan"></i>查询</a>--%>
            </div>
        </form>
    </div>
</div>
<!-- 列表 -->
<div class="cs-col-lg-table">
    <div class="cs-table-responsive" id="error_log">
    </div>
</div>

<!-- 底部导航 结束 -->
<!-- 内容主体 结束 -->
<%@include file="/WEB-INF/view/common/confirm.jsp" %>
<script src="${webRoot}/js/datagridUtil.js"></script>
<script type="text/javascript">
    var d = newDate();
    $("#d4312").val(d.format("yyyy-MM-dd HH:mm:ss"));
    d.DateAdd('d', -1);
    $("#d4311").val(d.format("yyyy-MM-dd 00:00:00"));

    var copy = 0;
    var copyObj;
    //遍历操作权限
    for (var i = 0; i < childBtnMenu.length; i++) {
        if (childBtnMenu[i].operationCode == "1397-1") {//复制
            copy = 1;
            copyObj = childBtnMenu[i];
            console.log(copyObj);
        }
    }
    //==========================页面显示=============================================
    $(function () {
        bigbang();
    });
    function bigbang(deviceType) {
        if (!deviceType) {
            deviceType = $("#deviceType option:selected").val();//获取被选中的仪器类型
        }
        var startTime = $("input[name=startTime]").val() + "";
        var endTime = $("input[name=endTime]").val() + "";
        console.log("--" + startTime + "--  --" + endTime + "--");
        //var keyword = $("input[name=keyword]").val();
        var op = {
            tableId: "error_log", //列表ID
            tableAction: '${webRoot}' + "/errorLog/datagrid.do?startTime=" + startTime + "&endTime=" + endTime + "&deviceType=" + deviceType, //加载数据地址
            onload: function () {

            },
            parameter: [ //列表拼接参数
                {
                    columnCode: "deviceType",
                    columnName: "仪器类型",
                    columnWidth: '8%'
                }, /*{
                 columnCode: "serialNumber",
                 columnName: "仪器唯一标识"
                 }, {
                 columnCode: "systemVersion",
                 columnName: "操作系统版本"
                 },*/ /*{
                 columnCode: "deviceVersion",
                 columnName: "仪器版本",
                 columnWidth: '4%'
                 }, */{
                    columnCode: "time",
                    columnName: "报错时间",
                    queryType: 1,
                    queryCode: "报错时间",
                    dateFormat: "yyyy-MM-dd HH:mm:ss",
                    columnWidth: '13%'
                }, {
                    columnCode: "createName",
                    columnName: "创建人",
                    columnWidth: '9%'
                }/*, {
                 columnCode: "createDate",
                 columnName: "createDate",
                 queryType: 1,
                 queryCode: "创建时间",
                 dateFormat: "yyyy-MM-dd HH:mm:ss",
                 columnWidth: '8%'
                 }*/, {
                    columnCode: "errorMessage",
                    columnName: "错误信息",
                    customStyle: "msgTd",
                    customElement: '<span></span>'

                }],
            funBtns: [{
                //复制按钮
                show: copy,
                style: copyObj,
                action: function (id) {
                    //获取当前选中行的td文本
                    var text = $("tr[data-rowid=" + id + "]").find(".msgTd").text();
                    var clipboard = new ClipboardJS('.icon', {//通过样式拿到按钮对象
                        text: function () {
                            return text;//返回指定的text文本
                        }
                    });
                    clipboard.on('success', function (e) {
                        console.log("复制成功");//复制成功
                    });
                    clipboard.on('error', function (e) {
                        console.log("复制失败");//复制失败
                    });
                }
            }],
            onload: function () {
                var obj = datagridOption.obj;
                if (obj) {
                    for (var i = 0; i < obj.length; i++) {
                        if (obj[i].id) {//迭代出所有不为空的id
                            //获取当前对应行的TD
                            var currentTd = $("tr[data-rowid=" + obj[i].id + "]").find(".msgTd");
                            //赋值
                            $("tr[data-rowid=" + obj[i].id + "]").find(".msgTd").text(obj[i].errorMessage);
                        }
                    }
                }
            }
        };
        datagridUtil.initOption(op);
        datagridUtil.queryByFocus();
    }

    //=======================仪器类型改变事件===================================
    function deviceTypeChange() {
        var deviceType = $("#deviceType option:selected").val();//获取被选中的仪器类型
        bigbang(deviceType);
    }
</script>
<i class="fa fa-copy"></i>
</body>
</html>
