<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/WEB-INF/view/common/resource.jsp" %>
<link rel="stylesheet" href="${webRoot}/js/Select2-4.0.2/css/select2.min.css">
<html>
<head>
    <title>快检服务云平台</title>
</head>
<body>
<div id="dataList"></div>
<th rowspan="2" colspan="1"></th>
<%@include file="/WEB-INF/view/common/confirm.jsp" %>
<%@include file="/WEB-INF/view/common/modalBox.jsp" %>
<script src="${webRoot}/js/select/tabcomplete.min.js"></script>
<script src="${webRoot}/js/select/livefilter.min.js"></script>
<script src="${webRoot}/js/select/bootstrap-select.js"></script>
<script src="${webRoot}/js/datagridUtil2.js"></script>
<script src="${webRoot}/js/jquery.form.js"></script>
<script type="text/javascript">
    rootPath = "${webRoot}/depart/manage/log/";
    //进入界面加载数据
    $(function () {
        var dgu = datagridUtil.initOption({
            tableId: "dataList",
            tableAction: "${webRoot}/depart/manage/log/datagrid",
            funColumnWidth: "50px", 		//操作列宽度，默认100px
            defaultCondition: [{			//附加请求参数
                queryCode: "departManageId", 				//参数名
                queryVal: "${id}"						//参数值
            }],
            tableBar: {
                title: ["企业管理", "操作日志"],
                hlSearchOff: 0,
                ele: [{
                    eleShow: 1,
                    eleName: "keyWords",
                    eleType: 0,
                    elePlaceholder: "修改人、联系方式"
                }, {
                    eleShow: 1,
                    eleType: 4,
                    eleHtml: '<a href="javascript:;" onclick="window.parent.closeMbIframe();" class="cs-menu-btn "><i class="icon iconfont icon-fanhui"></i>返回</a>'
                }],
            },
            parameter: [
                {
                    columnCode: "userName",
                    columnName: "修改人",
                    columnWidth: '6%'
                }, {
                    columnCode: "updateDate",
                    columnName: "修改时间",
                    columnWidth: '10%'
                }, {
                    columnCode: "phone",
                    columnName: "联系方式",
                    sortDataType: "string",
                    columnWidth: '7%'
                }
                , {
                    columnCode: "remark",
                    columnName: "备注信息",
                    customStyle: 'text-left',
                    columnWidth: '40%'
                }
            ],
            funBtns: [
                {//编辑
                    show: Permission.exist("1519-5"),
                    style: Permission.getPermission("1519-5"),
                    action: function (id, row) {
                        idsStr = id;
                        $("#confirm-delete2").modal('toggle');
                    }
                }
            ],
            onload: function (rows, pageData) {
            }
        });
        dgu.queryByFocus();
    });

</script>
</body>
</html>
