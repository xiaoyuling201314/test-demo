<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/WEB-INF/view/common/resource.jsp" %>
<html>
<head>
    <title>快检服务云平台</title>
</head>
<body>

<div id="dataList"></div>
<%@include file="/WEB-INF/view/common/modalBox.jsp" %>
<%@include file="/WEB-INF/view/ledger/regulatoryObject/selectRegType.jsp" %>

<script src="${webRoot}/js/datagridUtil2.js"></script>
<script src="${webRoot}/js/unqualified.js" ></script>
<script type="text/javascript">
    var rootPath="${webRoot}";
    var csd = '${start}';
    var ced = '${end}';
    var datagrid1 = datagridUtil.initOption({
        tableId: "dataList",
        tableAction: "${webRoot}/dataCheck/unqualified/datagrid.do",
        funColumnWidth:'70px',
        tableBar: {
            title: ["不合格处理", "待处理"],
            hlSearchOff: 0,
            ele: [{
                eleShow: Permission.exist("381-8"),
                eleType: 4,
                eleHtml: "<span class=\"check-date cs-fl\">" +
                    "<span class=\"cs-name\" style=\"padding-right: 0px;\">"+ Permission.getPermission("321-19").operationName +"：</span>" +
                    "<div class=\"cs-all-ps\">\n" +
                    "            <div class=\"cs-input-box\">\n" +
                    "                <input type=\"text\" name=\"departNames\" autocomplete=\"off\">\n" +
                    "                <div class=\"cs-down-arrow\"></div>\n" +
                    "            </div>\n" +
                    "            <div class=\"cs-check-down cs-hide\" style=\"display: none;\">\n" +
                    "                <ul id=\"tree\" class=\"easyui-tree\"></ul>\n" +
                    "            </div>\n" +
                    "        </div>" +
                    "</span>"
            },{
                eleShow: Permission.exist("381-5"),
                eleType: 4,
                eleHtml: "<span class=\"check-date cs-fl\">" +
                    "<span class=\"cs-name\" style=\"padding-right: 0px;\">监管类型：</span>" +
                    "<span class=\"cs-input-style \" style=\"margin-left: 0px;\">" +
                    "<input type=\"hidden\" name=\"regTypeId\" value=\"\" id=\"regTypeIds\" class=\"focusInput\"/>" +
                    "<input type=\"text\" name=\"regTypeName\" class=\"choseRegType\" value=\"--全部--\" autocomplete=\"off\" style=\"width: 110px\" readonly/>" +
                    "</span>" +
                    "</span>"
            }, {
                eleShow: 1,
                eleTitle: "范围",
                eleName: "treatmentDate",
                eleType: 3,
                eleStyle: "width:110px;",
                eleDefaultDateMin: (!csd ? new newDate().DateAdd("m", -1).format("yyyy-MM-dd") : csd),
                eleDefaultDateMax: (!ced ? new newDate().format("yyyy-MM-dd") : ced)
            }, {
                eleShow: 1,
                eleName: "keyWords",
                eleType: 0,
                elePlaceholder: "编号、样品编号、被检单位、档口编号、样品名称、检测项目"
            }], init: function () {
                //选择行政区
                $('#tree').tree({
                    checkbox: false,
                    url: "${webRoot}/detect/depart/getDepartTree.do",
                    animate: true,
                    onLoadSuccess: function (node, data) {
                        if (data.length > 0) {
                            $("input[name='departNames']").val(data[0].text);
                        }
                    },
                    onClick: function (node) {
                        var did = node.id;
                        $("input[name='departNames']").val(node.text);
                        $(".cs-check-down").hide();

                        datagrid1.addDefaultCondition("departId", did);
                        datagrid1.queryByFocus();
                    }
                });
            }
        },
        parameter: [
            {
                columnCode: "id",
                columnName: "编号",
                columnWidth: "90px",
                customElement: (Permission.getPermission("381-7") ? "<a class='text-primary cs-link check_reding_id'>?<a>" : "?" ),
            },
            {
                columnCode: "regName",
                columnName: "被检单位"
            },
            {
                columnCode: "ope_shop_code",
                columnName: "${systemFlag}" == "1" ? "摊位编号" : "档口编号",
                columnWidth: "7%"
            },
            {
                columnCode: "foodName",
                columnName: "样品名称",
            },
            {
                columnCode: "itemName",
                columnName: "检测项目"
            },
            {
                columnCode: "checkResult",
                columnName: "复检值",
                customStyle: "checkResult",
                columnWidth: "80px"
            },
            {
                columnCode: "conclusion",
                columnName: "复检结果",
                customVal: {"不合格": "<div class=\"text-danger\">不合格</div>"},
                columnWidth: "80px"
            },
            {
                columnCode: "pointName",
                columnName: "检测点"
            },
            {
                columnCode: "checkDate",
                columnName: "复检时间",
                columnWidth: "90px"
            },{
                columnCode: "sampleCode",
                columnName: "抽样编号",
                customStyle: 'sampleCode',
                columnWidth: "90px"
            },
            {
                columnCode: "reloadFlag",
                columnName: "复检",
                columnWidth: "60px",
                customStyle: "reloadFlag",
                show: Permission.exist("381-6"),
                sortDataType: "int",
                customVal: {"0":"<a class='text-primary reload-zero'>0</a>", "default":"<a class='text-primary cs-link reloadCount'>?</a>"}
            }
        ],
        funBtns: [
            {
                //处置
                show: Permission.exist("381-1"),
                style: Permission.getPermission("381-1"),
                action: function (id, row) {
                    self.location = "${webRoot}/dataCheck/unqualified/goHandle.do?id=" + id;
                }
            },
            {
                //溯源
                show: Permission.exist("383-6"),
                style: Permission.getPermission("383-6"),
                action: function (id, row) {
                    showMbIframe("${webRoot}/dataCheck/recording/checkDetail.do?id=" + id);
                }
            }
        ],
        defaultCondition: [
            {
                queryCode: "conclusion",
                queryVal: "不合格"
            }, {
                queryCode: "dataType",
                queryVal: 0
            }, {
                queryCode: "queryTimeOutHandel",
                queryVal: '${queryTimeOutHandel}'
            }, {
                queryCode: "param7",
                queryVal: 1
            }
        ], onload: function (obj, pageData) {//加载成功之后才执行的方法
            if (obj) {
                for (var i = 0; i < obj.length; i++) {
                    /*if (obj[i].reloadFlag == 0) {//如果复检次数为0，取消复检次数的点击事件
                        $("tr[data-rowid=" + obj[i].id + "]").find(".reloadFlag").html(obj[i].reloadFlag);
                    }*/
                    if (!isNaN(parseFloat(obj[i].checkResult)) && isFinite(obj[i].checkResult)){//判断检测值是否为数字
                        $("tr[data-rowid=" + obj[i].id + "]").find(".checkResult").html(obj[i].checkResult+obj[i].checkUnit);
                    }
                }
            }
        }
    });
    datagrid1.queryByFocus();
</script>
</body>
</html>
