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
            <a href="javascript:">财务管理</a></li>
        <li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
        <li class="cs-fl">余额管理</li>
        <li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
        <li class="cs-b-active cs-fl">账户流水</li>
    </ol>
    <div class="cs-search-box cs-fr">
        <form>
            <div class="cs-search-filter clearfix cs-fl">
                <span class="check-date cs-fl" style="display: inline;">
					<span class="cs-name">交易时间:</span>
					<span class="cs-in-style cs-time-se cs-time-se">
						<input name="payDateStart" style="width: 110px;" class="cs-time focusInput" type="text" onclick="WdatePicker()"
                               datatype="date" autocomplete="off">
						<span style="padding: 0 5px;">至</span>
						<input name="payDateEnd" style="width: 110px;" class="cs-time focusInput" type="text" onclick="WdatePicker()" datatype="date"
                               autocomplete="off">
						&nbsp;
					</span>
				</span>
                <input class="cs-input-cont cs-fl focusInput" type="text" name="keyWords" placeholder="请输入交易流水号"/>
                <input type="button" class="cs-search-btn cs-fl" onclick="datagridUtil.queryByFocus()" href="javascript:;" value="搜索">
                <%--<span class="cs-s-search cs-fl">高级搜索</span>--%>
            </div>
            <div class="clearfix cs-fr" id="showBtn">
                <a href="javascript:" onclick="parent.closeMbIframe();" class="cs-menu-btn"><i class="icon iconfont icon-fanhui"></i>返回</a>
            </div>
        </form>
    </div>
</div>

<div id="dataList2"></div>

<script type="text/javascript" src="${webRoot}/js/datagridUtil2.js"></script>
<script type="text/javascript">
    $(function () {
        var d1 = new Date();
        $("input[name='payDateEnd']").val(d1.format("yyyy-MM-dd"));
        d1 = d1.DateAdd("m", -1);
        //$("input[name='payDateStart']").val(d1.format("yyyy-MM-dd"));//默认进来不要开始时间，查询的是所有的数据

        var datagrid2 = datagridUtil.initOption({
            tableId: "dataList2",
            tableAction: "${webRoot}/balanceMgt/flowDatagrid?isok=${isok}",
            defaultCondition: [{
                queryCode: "userId",
                queryVal: "${userId}"
            }],
            parameter: [
                {
                    columnCode: "payNumber",
                    columnName: "交易流水号",
                    customStyle: 'text-left',
                    columnWidth: "17%",
                    //columnWidth: "190px"

                },
                {
                    columnCode: "number",
                    columnName: "订单号",
                    customStyle: 'text-left',
                    columnWidth: "17%",
                },
                {
                    columnCode: "payDate",
                    columnName: "交易时间",
                    queryType: "1",
                    dateFormat: "yyyy-MM-dd HH:mm:ss",
                    customStyle: 'text-left',
                    columnWidth: "8%"
                },
                {
                    columnCode: "flowState",
                    columnName: "类型",
                    customVal: {"0": "支出", "1": "收入", "is-null": "支出"},
                    columnWidth: "5%",
                },
                {
                    columnCode: "money",
                    columnName: "交易金额",
                    columnWidth: "7%",
                    sortDataType: "float",
                    customVal: {"is-null": "￥0.00", "non-null": "￥?"}
                },
                {
                    columnCode: "giftMoney",
                    columnName: "赠送金额",
                    columnWidth: "7%",
                    sortDataType: "float",
                    customVal: {"is-null": "￥0", "non-null": "￥?"}
                },
                {
                    columnCode: "balance",
                    columnName: "余额",
                    columnWidth: "7%",
                    sortDataType: "float",
                    customVal: {"is-null": "￥0.00", "non-null": "￥?"}
                },
                {
                    columnCode: "payMode",
                    columnName: "交易方式",
                    columnWidth: "7%",
                },
                {
                    columnCode: "status",
                    columnName: "状态",
                    customVal: {"0": "待支付", "1": "成功", "2": "失败", "3": "关闭"},
                    columnWidth: "6%",
                },
                /*{
                 columnCode: "activityTheme",
                 columnName: "充值活动",
                 columnWidth: "8%",
                 customVal: {"is-null":"", "non-null":"#activityTheme#：充值满￥#activityMoney#送￥#activityGiftMoney#"}
                 },*/
                {
                    columnCode: "remark",
                    columnName: "备注",
                    columnWidth: "16%",
                    customStyle: 'remark',
                }
            ],onload: function (obj, pageData) {
               /* if (obj) {
                    for (let i = 0; i < obj.length; i++) {
                        if (obj[i].activityTheme) {//如果为企业类型且企业为供应商就添加图标
                            $("tr[data-rowid=" + obj[i].id + "]").find(".remark").html(obj[i].activityTheme+"：充值满¥"+obj[i].activityMoney+"送¥"+obj[i].activityGiftMoney);
                        }
                    }
                }*/
            }
        });
        datagrid2.queryByFocus();

    });
</script>
</body>
</html>
