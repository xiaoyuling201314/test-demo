<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<%@include file="/WEB-INF/view/common/resource.jsp" %>
<html>
<head>
    <title>委托单位</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<div class="cs-col-lg clearfix">
    <!-- 面包屑导航栏  开始-->
    <ol class="cs-breadcrumb">
        <li class="cs-fl">
            <img src="${webRoot}/img/set.png" alt=""/>
            <a href="javascript:">数据统计</a></li>
        <li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
        <li class="cs-b-active cs-fl">检测监控
        </li>
    </ol>
    <div class=" cs-input-style cs-fl" style="margin:3px 0 0 12px;">
        类型：
        <select class="cs-selcet-style" id="check" style="width: 90px;margin-right: 1px" onchange="changeType(this);">
            <option value="0">全部</option>
            <c:forEach items="${rutList}" var="req">
                <option value="${req.id}">${req.unitType}</option>
            </c:forEach>
        </select>
        <div class="cs-all-ps">
            <div class="cs-input-box">
                <input type="hidden" id="did"/>
                <input type="text" name="departName" readonly="readonly">
                <div class="cs-down-arrow"></div>
            </div>
            <div class="cs-check-down cs-hide" style="display: none;">
                <ul id="tree" class="easyui-tree"></ul>
            </div>
        </div>
    </div>
    <%@include file="/WEB-INF/view/common/selectDate.jsp" %>
    <!-- 面包屑导航栏  结束-->
    <div class="cs-search-box cs-fr">
        <form action="datagrid.do">
            <div class="cs-search-filter clearfix cs-fl">
                <input class="cs-input-cont cs-fl focusInput" type="text" name="requesterName" placeholder="单位名称">
                <input type="button" onclick="datagridUtil.queryByFocus();" class="cs-search-btn cs-fl" href="javascript:;" value="搜索">
            </div>
        </form>
    </div>
</div>
<div id="dataList"></div>
<%@include file="/WEB-INF/view/common/modalBox.jsp" %>
<script src="${webRoot}/js/datagridUtil2.js"></script>
<script>
    let monitoringType = 0;
    //机构树的初始化
    $('#tree').tree({
        checkbox: false,
        url: "${webRoot}/detect/depart/getDepartTree.do",
        animate: true,
        onClick: function (node) {
            let did = node.id;
            $("#did").val(node.id);
            $("input[name='departName']").val(node.text);
            $(".cs-check-down").hide();
            selectDate.query();
        },
        onSelect: function (node) {
            let did = node.id;
            $("#did").val(node.id);
        }
    });
    function changeType(obj) {
        monitoringType = obj.value;
        selectDate.query();
    }

    $(function () {
        project();//设置机构为当前登录用户的机构
        selectDate.init(loadData);//进行数据查询
    });
    function loadData(d) {
        let op = {
            tableId: "dataList",
            tableAction: "${webRoot}/checkMonitor/datagrid",
            defaultCondition: [
                {
                    queryCode: "type",
                    queryVal: d.type
                },
                {
                    queryCode: "year",
                    queryVal: d.year
                },
                {
                    queryCode: "month",
                    queryVal: d.month
                },
                {
                    queryCode: "season",
                    queryVal: d.season
                },
                {
                    queryCode: "start",
                    queryVal: d.start
                },
                {
                    queryCode: "end",
                    queryVal: d.end
                },
                {
                    queryCode: "did",
                    queryVal: $("#did").val()
                },
                {
                    queryCode: "unitType",
                    queryVal: monitoringType
                }
            ],
            parameter: [
                {
                    columnCode: "reqName",
                    columnName: "单位名称",
                },
                {
                    columnCode: "departName",
                    columnName: "所属机构",
                    columnWidth: "15%",
                },
                {
                    columnCode: "unitTypeName",
                    columnName: "单位类型",
                    columnWidth: "7%",
                },
                {
                    columnCode: "checkNumDaily",
                    columnName: "日测批次",
                    sortDataType: "int",
                    columnWidth: "7%",
                },
                {
                    columnCode: "planCheckNum",
                    columnName: "应送检数",
                    sortDataType: "int",
                    columnWidth: "7%",
                },
                {
                    columnCode: "checkNum",
                    columnName: "已送检数",
                    sortDataType: "int",
                    columnWidth: "7%",
                },
                {
                    columnCode: "unqualifiedNum",
                    columnName: "不合格数",
                    sortDataType: "int",
                    customStyle: "unqualified_num",
                    customVal: {"is-null": "0", "non-null": "<span style='color: red'>?</span>"},
                    columnWidth: "7%",
                },
                {
                    columnCode: "passRate",
                    columnName: "合格率",
                    customStyle: "pass_rate",
                    sortDataType: "float",
                    columnWidth: "6%",
                },
                {
                    columnCode: "checkRate",
                    columnName: "完成率",
                    sortDataType: "float",
                    customStyle: "check_rate",
                    columnWidth: "6%",
                }
            ], funBtns: [
                {
                    show: Permission.exist("1474-1"),    //查看详情
                    style: Permission.getPermission("1474-1"),
                    action: function (id) {
                        showMbIframe('${webRoot}/checkMonitor/details.do?id=' + id+"&type="+d.type+"&month="+d.month+"&season="+d.season+"&year="+d.year+"&start="+d.start+"&end="+d.end);
                    }
                }
            ], onload: function (rows, data) {
                //根据数据改变界面数据展示
                $(rows).each(function (index, value) {
                    let compareNum = 50;//比较值
                    let passRate = value.passRate == "" ? "-" : value.passRate;
                    let currentTd = $("tr[data-rowid=" + value.id + "]").find(".pass_rate");
                    if (passRate != '-') {
                        AddRed(passRate, compareNum,currentTd);
                    }else{
                        currentTd.html(passRate);
                    }


                    let checkRate = value.checkRate ? value.checkRate : 0;
                    currentTd = $("tr[data-rowid=" + value.id + "]").find(".check_rate");
                    AddRed(checkRate, compareNum,currentTd);

                    let unqualifiedNum = value.unqualifiedNum ? value.unqualifiedNum : 0;
                    currentTd = $("tr[data-rowid=" + value.id + "]").find(".unqualified_num");
                    //此处给定颜色，可解决排序不准确问题（因为排序获取的是innerHTML来对比排序，会获取到html代码，导致排序不准确）
                    if(unqualifiedNum>0)currentTd.css("color","red");
                    currentTd.html(unqualifiedNum);

                });

            }
        };
        datagridUtil.initOption(op);
        datagridUtil.query();
    }
    //num1<num2给出红色样式
    function AddRed(num1, num2,tdObj) {
        if(num1 < num2){
            tdObj.css("color","red")
        }
        tdObj.html(num1 + "%");
    }


    //获取机构数的数据并设置为选中状态
    function project() {
        $.ajax({
            type: "POST",
            url: "${webRoot}/reqUnitStatistic/querydepart.do",
            dataType: "json",
            success: function (data) {
                if (data && data.success) {
                    $("input[name='departName']").val(data.obj.departName);
                    var node = $('#tree').tree('find', data.obj.id);
                    $('#tree').tree('select', node.target);//设置选中该节点
                } else {
                    $("#confirm-warnning .tips").text(data.msg);
                    $("#confirm-warnning").modal('toggle');
                }
            }
        });
    }
</script>
</body>
</html>
