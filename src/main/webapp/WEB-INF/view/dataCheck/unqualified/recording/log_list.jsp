<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/WEB-INF/view/common/resource.jsp" %>
<link rel="stylesheet" href="${webRoot}/js/Select2-4.0.2/css/select2.min.css">
<html>
<head>
    <title>快检服务云平台</title>
</head>
<body>
<div id="dataList"></div>
<script src="${webRoot}/js/select/tabcomplete.min.js"></script>
<script src="${webRoot}/js/select/livefilter.min.js"></script>
<script src="${webRoot}/js/select/bootstrap-select.js"></script>
<script src="${webRoot}/js/datagridUtil2.js"></script>
<script src="${webRoot}/js/jquery.form.js"></script>
<script type="text/javascript">
    rootPath = "${webRoot}/dataCheck/unqualified/recording/log/";
    //进入界面加载数据
    $(function () {
        var dgu = datagridUtil.initOption({
            tableId: "dataList",
            tableAction: rootPath + "datagrid",
            funColumnWidth: "70px", 		//操作列宽度，默认100px
            defaultCondition: [{			//附加请求参数
                queryCode: "durId", 			//参数名
                queryVal: "${id}"						//参数值
            }],
            tableBar: {
                title: ["短信通知", "短信日志"],
                hlSearchOff: 0,
                ele: [{
                    eleShow: 1,
                    eleName: "keyWords",
                    eleType: 0,
                    elePlaceholder: "发送详情、发送人员"
                }, {
                    eleShow: 1,
                    eleType: 4,
                    eleHtml: '<a href="javascript:;" onclick="window.parent.closeMbIframe();" class="cs-menu-btn "><i class="icon iconfont icon-fanhui"></i>返回</a>'
                }],
            },
            parameter: [
                {
                    columnCode: "sampleCode",
                    columnName: "样品编号",
                    columnWidth: '15%',
                    customVal: {
                        "default": "${sampleCode}",
                    },
                },
                {
                    columnCode: "content",
                    columnName: "发送详情",
                    customStyle: 'text-left',
                },
                {
                    columnCode: "userName",
                    columnName: "发送人员",
                    columnWidth: '7%'
                }, {
                    columnCode: "updateDate",
                    columnName: "发送时间",
                    columnWidth: '12%'
                }, {
                    columnCode: "sendState",
                    columnName: "状态",
                    customVal: {
                        "0": "<div class=\"text-default\">待发</div>",
                        "2": "<div class=\"text-danger\">失败</div>",
                        "1": "<div class=\"text-success\">成功</div>",
                    },
                    columnWidth: "80px"
                },

            ],
            // funBtns: [
            //     {//编辑
            //         show: Permission.exist("1519-5"),
            //         style: Permission.getPermission("1519-5"),
            //         action: function (id, row) {
            //             idsStr = id;
            //             $("#confirm-delete2").modal('toggle');
            //         }
            //     }
            // ],
            onload: function (rows, pageData) {
            }
        });
        dgu.queryByFocus();
    });

</script>
</body>
</html>
