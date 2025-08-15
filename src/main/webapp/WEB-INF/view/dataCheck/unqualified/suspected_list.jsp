<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/WEB-INF/view/common/resource.jsp" %>
<html>
<head>
    <title>快检服务云平台</title>
</head>
<body>

<div id="dataList"></div>
<!-- Modal 提示窗-审核数据-->
<div class="modal fade intro2" id="confirm-review" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog cs-alert-width">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">疑似不合格审核</h4>
            </div>
            <div class="modal-body cs-alert-height cs-dis-tab">
                <div class="cs-text-algin">
                    <img src="${webRoot}/img/warn.png" width="40px"/>确认审核该记录吗？
                </div>
            </div>
            <div class="modal-footer">
                <a class="btn btn-danger btn-ok" onclick="updateReviewStatus()">确定</a>
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
            </div>
        </div>
    </div>
</div>
<%@include file="/WEB-INF/view/common/modalBox.jsp" %>
<%@include file="/WEB-INF/view/ledger/regulatoryObject/selectRegType.jsp" %>
<%@include file="/WEB-INF/view/common/confirm.jsp" %>
<script src="${webRoot}/js/datagridUtil2.js"></script>
<script src="${webRoot}/js/unqualified.js" ></script>
<script type="text/javascript">
    var rootPath="${webRoot}";
    var idsStr = [];
    var datagrid1 = datagridUtil.initOption({
        tableId: "dataList",
        tableAction: "${webRoot}/dataCheck/unqualified/datagrid.do",
        funColumnWidth:'70px',
        tableBar: {
            title: ["检测数据", "疑似阳性"],
            hlSearchOff: 0,
            ele: [{
                eleShow: Permission.exist("22242-1"),
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
                eleShow: Permission.exist("22242-2"),
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
                eleDefaultDateMin: (new newDate().DateAdd("m", -1).format("yyyy-MM-dd")),
                eleDefaultDateMax: (new newDate().format("yyyy-MM-dd"))
            }, {
                eleShow: 1,
                eleName: "keyWords",
                eleType: 0,
                elePlaceholder: "编号、样品编号、被检单位、档口编号、样品名称、检测项目"
            }],
            init: function () {
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
                customElement: "<a class='text-primary cs-link check_reding_id'>?<a>",
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
                columnName: "检测值",
                customStyle: "checkResult",
                columnWidth: "80px"
            },
            {
                columnCode: "conclusion",
                columnName: "检测结果",
                customVal: {"合格": "<div class=\"text-success\">合格</span>","不合格": "<div class=\"text-danger\">不合格</span>"},
                columnWidth: "80px"
            },
            {
                columnCode: "pointName",
                columnName: "检测点"
            },
            {
                columnCode: "checkDate",
                columnName: "检测时间",
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
                sortDataType: "int",
                customVal: {"0":"<a class='text-primary reload-zero'>0</a>", "default":"<a class='text-primary cs-link reloadCount'>?</a>"}
            }
        ],
        funBtns: [
            {
                //审核
                show: Permission.exist("22242-3"),
                style: Permission.getPermission("22242-3"),
                action: function (id, row) {
                    idsStr = id;
                    $("#confirm-review").modal('toggle');
                }
            },
        ],bottomBtns: [ {
            //审核
            show: Permission.exist("22242-3"),
            style: Permission.getPermission("22242-3"),
            action: function(ids) {
                idsStr = ids;
                if (idsStr.length > 0) {
                    $("#confirm-review").modal('toggle');
                } else {
                    $("#confirm-review").modal('toggle');
                    $("#waringMsg>span").html("请选择要审核的数据");
                    $("#confirm-warnning").modal('toggle');
                }

            }
        }],
        defaultCondition: [
            {
                queryCode: "suspected",
                queryVal: 1
            }, {
                queryCode: "dataType",
                queryVal: 0
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
    //删除函数
    function updateReviewStatus() {
        $.ajax({
            type: "POST",
            url: "${webRoot}/dataCheck/unqualified/updateReviewStatus.do",
            traditional: true,
            data: {'ids': idsStr},
            dataType: "json",
            success: function (data) {
                $("#confirm-review").modal('toggle');
                if (data && data.success) {
                    //删除成功后刷新列表
                    datagridUtil.queryByFocus();
                } else {
                    $("#waringMsg>span").html(data.msg);
                    $("#confirm-warnning").modal('toggle');
                }
            },
            error: function (data) {
                $("#confirm-warnning").modal('toggle');
            }
        });
    }
</script>
</body>
</html>
