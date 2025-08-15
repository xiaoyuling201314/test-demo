<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/WEB-INF/view/common/resource.jsp" %>
<html>
<head>
    <title>快检服务云平台</title>
    <style>
        .error {
            background-color: #ffe7e7;
        }
    </style>
</head>
<body>
<div id="dataList"></div>
<script src="${webRoot}/js/datagridUtil2.js"></script>
<script type="text/javascript">

    var datagrid1 = datagridUtil.initOption({
        tableId: "dataList",
        tableAction: "${webRoot}/dataCheck/unqualified/recording/history/datagrid.do",
        defaultCondition: [{			//附加请求参数
            queryCode: "id", 				//参数名
            queryVal: "${id}"						//参数值
        }],
        tableBar: {
            title: ["短信通知", "检测历史"],
            hlSearchOff: 0,
            ele: [
                {
                    eleShow: 1,
                    eleName: "keyWords",
                    eleType: 0,
                    elePlaceholder: "样品名称、检测项目"
                },
                {
                    eleShow: 1,
                    eleType: 4,
                    eleHtml: '<a href="javascript:;" onclick="window.parent.closeMbIframe();" class="cs-menu-btn "><i class="icon iconfont icon-fanhui"></i>返回</a>'
                }]
        },
        parameter: [
            {
                columnCode: "sampleCode",
                columnName: "样品编号",
                customVal: {
                    "default": "${sampleCode}",
                },
            },
            {
                columnCode: "pointName",
                columnName: "检测点",
                columnWidth: "13%"
            },
            {
                columnCode: "regName",
                columnName: "被检单位",
                columnWidth: "12%"
            },
            {
                columnCode: "regUserName",
                columnName: "${systemFlag}" === "1" ? "摊位编号" : "档口编号",
                columnWidth: "8%"
            },
            {
                columnCode: "foodName",
                columnName: "样品名称",
                columnWidth: "9%"
            },
            {
                columnCode: "itemName",
                columnName: "检测项目",
                columnWidth: "13%"
            },
            {
                columnCode: "checkResult",
                columnName: "检测值",
                columnWidth: "70px"
            },
            {
                columnCode: "conclusion",
                columnName: "检测结果",
                customVal: {"不合格": "<div class=\"text-danger\">不合格</div>","合格": "<div class=\"text-success\">合格</div>"},
                columnWidth: "80px"
            },
            // {
            //     columnCode: "checkUsername",
            //     columnName: "检测人员",
            //     columnWidth: "7%"
            // },
            {
                columnCode: "checkDate",
                columnName: "检测时间",
                columnWidth: "8%"
            },
            {
                columnCode: "uploadDate",
                columnName: "上传时间",
                columnWidth: "8%"
            },
        ]
    });
    datagrid1.queryByFocus();
</script>
</body>
</html>
