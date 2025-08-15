<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/WEB-INF/view/common/resource.jsp" %>
<html>
<head>
    <title>快检服务云平台</title>
</head>

<body>
<div class="cs-col-lg clearfix">
    <ol class="cs-breadcrumb">
        <li class="cs-fl">
            <img src="${webRoot}/img/set.png" alt=""/>
            <a href="javascript:">日志管理</a></li>
        <li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
        <li class="cs-b-active cs-fl">系统日志</li>
    </ol>
    <div class="cs-search-box cs-fr">
        <form>
            <span class="check-date cs-fl" style="display: inline;">
					<span class="cs-name">时间范围:</span>
					<span class="cs-in-style cs-time-se cs-time-se">
						<input name="operateTimeStartDateStr" id="start" style="width: 110px;" class="cs-time Validform_error focusInput" type="text"
                               onclick="WdatePicker()" datatype="date" value="${start}" onblur="changeVAL1()" autocomplete="off">
						<span style="padding: 0 5px;">至</span>
						<input name="operateTimeEndDateStr" id="end" style="width: 110px;" class="cs-time Validform_error focusInput" type="text"
                               onclick="WdatePicker()" datatype="date" value="${end}" onblur="changeVAL2()" autocomplete="off">
						&nbsp;
					</span>
				</span>
            <div class="cs-search-filter clearfix cs-fl">
                <input class="cs-input-cont cs-fl focusInput" type="text" id="keyWords" name="keyWords" placeholder="请输入姓名或IP"/>
                <input type="button" class="cs-search-btn cs-fl" onclick="datagridUtil.queryByFocus()" href="javascript:;" value="搜索">
                <span class="cs-s-search cs-fl">高级搜索</span>
            </div>
        </form>
    </div>
</div>
<div class="cs-tabtitle clearfix" id="tabtitle">
    <ul>
        <li data-tabtitleNo="1" data-logType="0" class="cs-tabhover">用户操作</li>
        <li data-tabtitleNo="2" data-logType="1">报告打印</li>
        <li data-tabtitleNo="3" data-logType="2">付款详情</li>
    </ul>
</div>
<div class="cs-tabcontent clearfix">
    <div class="cs-content2">
        <div id="dataList1"></div>
    </div>
</div>
<div class="cs-tabcontent clearfix cs-hide">
    <div class="cs-content2">
        <div id="dataList2"></div>
    </div>
</div>
<div class="cs-tabcontent clearfix cs-hide">
    <div class="cs-content2">
        <div id="dataList3"></div>
    </div>
</div>
<script src="${webRoot}/js/datagridUtil.js"></script>
<script type="text/javascript">
    var logType = 0;
    if (Permission.exist("1439-1") == 1) {
    }
    var operateTimeStartDateStr = '${start}';
    var operateTimeEndDateStr = '${end}';
    //切换列表
    $(".cs-tabtitle li").click(function () {
        var tabtitleNo = $(this).attr("data-tabtitleNo");
        if (tabtitleNo == "1") {
            logType = 0;
            datagridUtil.initOption(op1_operation);
        } else if (tabtitleNo == "2") {
            logType = 1;
            datagridUtil.initOption(op2_print);
        } else if (tabtitleNo == "3") {
            logType = 2;
            datagridUtil.initOption(op3_pay);
        }
        datagridUtil.queryByFocus();
    });
    var op1_operation = {
            tableId: "dataList1",
            tableAction: "${webRoot}/sysManageLog/operation/datagrid",
            parameter: [
                {
                    columnCode: "param1",
                    columnName: "手机号/操作人",
                    columnWidth: "9%",
                    query: 1
                },
                {
                    columnCode: "remoteip",
                    columnName: "登录IP",
                    columnWidth: "10%",
                    query: 1
                },
                /*{
                 columnCode: "requesturi",
                 columnName: "请求地址",
                 columnWidth: "10%"
                 },*/
                {
                    columnCode: "operatorWay",
                    columnName: "日志来源",
                    customVal: {"0": "自助终端", "1": "APP", "2": "后台"},
                    columnWidth: "7%",
                    queryType: 2,
                    query: 1
                },
                {
                    columnCode: "module",
                    columnName: "操作模块",
                    customVal: {"用户管理": "用户管理", "订单管理": "订单管理", "收样模块": "收样模块", "前处理": "前处理", "后台操作": "后台操作"},
                    columnWidth: "6%",
                    queryType: 2,
                    query: 1
                },
                {
                    columnCode: "operatetime",
                    columnName: "操作时间",
                    dateFormat: "yyyy-MM-dd HH:mm:ss",
                    columnWidth: "12%",
                    query: 1,
                    queryCode: "operateTime",
                    queryType: 3
                },
                /*{
                 columnCode: "requestParam",
                 columnName: "提交参数",
                 columnWidth: "10%"
                 },*/
                {
                    columnCode: "operatorResult",
                    columnName: "执行结果",
                    customVal: {"0": "成功", "1": "<span style='color: red'>失败</span>"},
                    columnWidth: "6%",
                    queryType: 2,
                    query: 1
                },
                {
                    columnCode: "description",
                    columnName: "描述信息",
                    columnWidth: "15%"
                },
                {
                    columnCode: "exception",
                    columnName: "异常信息",
                    columnWidth: "15%"
                }
            ],
            rowTotal: 0,	//记录总数
            pageSize: pageSize,	//每页数量
            pageNo: 1,	//当前页序号
            pageCount: 1,	// 总页数
            bottomBtns: [{
                show: Permission.exist('1439-6'),	//查看二维码
                style: Permission.getPermission('1439-6'),
                action: function (ids) {
                }
            }], //功能按钮
            defaultCondition: [ //加载条件
                {
                    queryCode: "operateTimeStartDateStr",
                    queryVal: operateTimeStartDateStr
                }, {
                    queryCode: "operateTimeEndDateStr",
                    queryVal: operateTimeEndDateStr
                }], before: function (queryType) {
                if (queryType == 0) {	//高级搜索
                    //清除时间范围查询条件
                    datagridUtil.delDefaultCondition("operateTimeStartDateStr");
                    datagridUtil.delDefaultCondition("operateTimeEndDateStr");
                }
            }
        }
    ;
    //个人送检单位数据列表
    var op2_print = {
        tableId: "dataList2",
        tableAction: "${webRoot}/sysManageLog/print/datagrid",
        parameter: [
            {
                columnCode: "param1",
                columnName: "手机号码",
                columnWidth: "9%",
                query: 1
            },
            {
                columnCode: "remoteip",
                columnName: "登录IP",
                columnWidth: "10%",
                query: 1
            },
            /*{
             columnCode: "requesturi",
             columnName: "请求地址",
             columnWidth: "10%"
             },*/
            {
                columnCode: "operatorWay",
                columnName: "日志来源",
                customVal: {"0": "自助终端", "1": "APP", "2": "后台"},
                columnWidth: "7%",
                queryType: 2,
                query: 1
            },
            /*{
             columnCode: "module",
             columnName: "操作模块",
             columnWidth: "6%"
             },*/
            {
                columnCode: "operatetime",
                columnName: "操作时间",
                dateFormat: "yyyy-MM-dd HH:mm:ss",
                columnWidth: "12%",
                query: 1,
                queryCode: "operateTime",
                queryType: 3
            },
            {
                columnCode: "printcode",
                columnName: "电子报告",
                columnWidth: "10%"
            },
            {
                columnCode: "operatorResult",
                columnName: "执行结果",
                customVal: {"0": "成功", "1": "<span style='color: red'>失败</span>"},
                columnWidth: "6%",
                queryType: 2,
                query: 1
            },
            {
                columnCode: "description",
                columnName: "描述信息",
                columnWidth: "15%"
            },
            {
                columnCode: "exception",
                columnName: "异常信息",
                columnWidth: "15%"
            }
        ],
        rowTotal: 0,	//记录总数
        pageSize: pageSize,	//每页数量
        pageNo: 1,	//当前页序号
        pageCount: 1,	// 总页数
        bottomBtns: [{
            show: Permission.exist('1439-6'),	//查看二维码
            style: Permission.getPermission('1439-6'),
            action: function (ids) {
            }
        }], before: function (queryType) {
            if (queryType == 0) {	//高级搜索
                //清除时间范围查询条件
                datagridUtil.delDefaultCondition("operateTimeStartDateStr");
                datagridUtil.delDefaultCondition("operateTimeEndDateStr");
            }
        }
    };

    var op3_pay = {
        tableId: "dataList3",
        tableAction: "${webRoot}/sysManageLog/pay/datagrid",
        parameter: [
            {
                columnCode: "param1",
                columnName: "手机号码",
                columnWidth: "9%",
                query: 1
            },
            {
                columnCode: "remoteip",
                columnName: "登录IP",
                columnWidth: "10%",
                query: 1
            },
            /*{
             columnCode: "requesturi",
             columnName: "请求地址",
             columnWidth: "10%"
             },*/
            {
                columnCode: "operatorWay",
                columnName: "日志来源",
                customVal: {"0": "自助终端", "1": "APP", "2": "后台"},
                columnWidth: "7%",
                queryType: 2,
                query: 1
            },
            /*{
             columnCode: "module",
             columnName: "操作模块",
             columnWidth: "6%"
             },*/
            {
                columnCode: "operatetime",
                columnName: "操作时间",
                dateFormat: "yyyy-MM-dd HH:mm:ss",
                columnWidth: "9%",
                query: 1,
                queryCode: "operateTime",
                queryType: 3
            },
            {
                columnCode: "payNumber",
                columnName: "交易流水号",
                columnWidth: "10%"
            },
            {
                columnCode: "paySource",
                columnName: "支付方式",
                customVal: {"0": "微信", "1": "支付宝", "2": "余额"},
                columnWidth: "7%",
                queryType: 2,
                query: 1
            },
            {
                columnCode: "money",
                columnName: "收款金额",
                columnWidth: "8%"
            },
            {
                columnCode: "payAccount",
                columnName: "付款账号",
                columnWidth: "10%"
            },
            /*{
                columnCode: "operatorResult",
                columnName: "执行结果",
                customVal: {"0": "成功", "1": "<span style='color: red'>失败</span>"},
                columnWidth: "7%",
                queryType: 2,
                query: 1
            },*/
            {
                columnCode: "description",
                columnName: "描述信息",
                columnWidth: "10%"
            },
            {
                columnCode: "exception",
                columnName: "异常信息",
                columnWidth: "10%"
            }
        ],
        rowTotal: 0,	//记录总数
        pageSize: pageSize,	//每页数量
        pageNo: 1,	//当前页序号
        pageCount: 1,	// 总页数
        bottomBtns: [{
            show: Permission.exist('1439-6'),	//查看二维码
            style: Permission.getPermission('1439-6'),
            action: function (ids) {
            }
        }], before: function (queryType) {
            if (queryType == 0) {	//高级搜索
                //清除时间范围查询条件
                datagridUtil.delDefaultCondition("operateTimeStartDateStr");
                datagridUtil.delDefaultCondition("operateTimeEndDateStr");
            }
        }
    };
    datagridUtil.initOption(op1_operation);
    datagridUtil.queryByFocus();


    function changeVAL1() {
        operateTimeStartDateStr = $("#start").val();
        datagridUtil.addDefaultCondition("operateTimeStartDateStr", operateTimeStartDateStr);
    }
    function changeVAL2() {
        operateTimeEndDateStr = $("#end").val();
        datagridUtil.addDefaultCondition("operateTimeEndDateStr", operateTimeEndDateStr);
    }
</script>
</body>
</html>
