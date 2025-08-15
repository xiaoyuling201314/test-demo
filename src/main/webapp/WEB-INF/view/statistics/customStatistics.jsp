<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/WEB-INF/view/common/resource.jsp" %>
<html>
<head>
    <title>快检服务云平台</title>
    <style type="text/css">
        .is-flex{
            display: flex;
        }
    </style>
</head>
<body>
<div class="cs-col-lg clearfix">
    <ol class="cs-breadcrumb">
        <li class="cs-fl">
            <img src="${webRoot}/img/set.png" alt=""/>
            <a href="javascript:;">数据统计</a></li>
        <li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
        <li class="cs-b-active cs-fl">自定义统计</li>
    </ol>

    <div class="cs-input-style pull-right" style="margin:1px 0 2px 10px;">
        <div class="pull-left" style="padding: 3px 5px 0 0;">
            <!-- 机构 -->
            <%@include file="/WEB-INF/view/detect/depart/selectDepart2.jsp" %>
        </div>

        <div class="pull-left" style="padding: 3px 5px 0 0;">
            <!-- 食品种类 -->
            <%@include file="/WEB-INF/view/data/foodType/selectFoodGroup2.jsp" %>
        </div>

        <div class="pull-left" style="padding: 3px 5px 0 0;">
            <%--检测项目--%>
            <%@include file="/WEB-INF/view/data/detectItem/selectDetectItemForReport.jsp" %>
        </div>

        <div id="regTaskTypeDiv" class="is-flex pull-left" style="display: none;padding: 3px 5px 0 0;height: 32px; align-items: center;">
            <%--监管对象任务类型--%>
            <input id="regTaskType" type="checkbox" style="margin: 0"><label for="regTaskType" class="text-muted">任务类型</label>
        </div>

        <div class="pull-left">
            <!-- 时间范围 -->
            <%@include file="/WEB-INF/view/common/selectDateForReport.jsp" %>
        </div>
    </div>
</div>

<div class="chart-table" style="padding-bottom:50px;">
    <table class="cs-table cs-table-hover table-striped cs-tablesorter" id="table">
        <thead>
        <tr>
            <th class="cs-header columnHeading">序号</th>
            <th class="cs-header columnHeading" style="width: 25%;">市场企业</th>
            <th class="cs-header columnHeading" id="regTaskTypeTh" style="display:none;width: 80px;">任务类型</th>
            <th class="cs-header columnHeading">检测数量</th>
            <th class="cs-header columnHeading">不合格</th>
            <th class="cs-header columnHeading">不合格率</th>

            <th class="cs-header columnHeading qType0 qType1">样品种类</th>
            <th class="cs-header columnHeading qType0 qType2">检测项目</th>
            <th class="cs-header columnHeading qType0 qType9">检测数量</th>
            <th class="cs-header columnHeading qType0 qType9">不合格</th>
            <th class="cs-header columnHeading qType0 qType9">不合格率</th>
        </tr>
        </thead>
        <tbody>
        </tbody>
    </table>
</div>

<%-- 加载提示 --%>
<div class="loading-bg" style="display: none;">
    <div class="loading-box">
        <img src="${webRoot}/img/wait.gif">正在加载数据
    </div>
</div>

<!-- JavaScript -->
<script src="${webRoot}/js/datagridUtil.js"></script>
<script src="${webRoot}/plug-in/echarts/echarts.min.js"></script>
<script src="${webRoot}/plug-in/echarts/shine.js"></script>
<script src="${webRoot}/js/selectRow.js"></script>
<%@include file="/WEB-INF/view/common/modalBox.jsp" %>
<script type="text/javascript">
    //监管对象任务类型权限
    if (Permission.exist("1525-1") == 1) {
        $("#regTaskTypeDiv").show();
    }

    //监管对象任务类型：0_停用 1_启用
    let regTaskTypeFlag = 0;
    $(document).on("change","#regTaskType", function (){
        if ($(this).prop("checked")) {
            regTaskTypeFlag = 1;
        } else {
            regTaskTypeFlag = 0;
        }
    });

    $(function () {
        //加载机构选项
        departSel.init(false, false, true);

        //加载样品种类选项
        // foodTypesSel.init(false, false, loadData);
        foodTypesSel.init(false, false);

        //加载检测项目
        // selectItems.init(loadData);
        selectItems.init();

        //加载时间选项
        selectDate.init(false, 6, loadData);
        //禁用年统计
        selectDate.disableOption("year");

        setTimeout(function () {
            selectDate.query();
        }, 300);
    });

    function loadData() {
        //获取选中样品种类
        let selDepartData = departSel.getSelectDate();
        let departId = selDepartData.departId;

        //获取选中样品种类
        let selFoodTypesData = foodTypesSel.getSelectDate();
        let foodTypeIds = "";
        if (selFoodTypesData) {
            foodTypeIds = selFoodTypesData.foodIds;
        }

        //获取选中检测项目
        let selItemsData = selectItems.getSelectDate();
        let itemIds = "";
        if (selItemsData) {
            itemIds = selItemsData.itemIds;
        }

        //获取统计时间范围
        let d = selectDate.getSelectDate();

        $(".loading-bg").css('display', 'flex');
        $.ajax({
            type: "POST",
            url: "${webRoot}/statistics/getCustomStatistics",
            data: {
                "start": (d.start.length == 10 ? d.start + " 00:00:00" : d.start),
                "end": (d.end.length == 10 ? d.end + " 23:59:59" : d.end),
                "departId": departId,
                "foodTypeIds": foodTypeIds,
                "itemIds": itemIds,
                "regTaskTypeFlag": regTaskTypeFlag
            },
            dataType: "json",
            success: function (data) {
                $(".loading-bg").hide();

                if (regTaskTypeFlag == 1) {
                    $("#regTaskTypeTh").show();
                } else {
                    $("#regTaskTypeTh").hide();
                }

                if (data && data.success) {
                    //隐藏显示table列
                    $("#table .qType0").hide();
                    if (foodTypeIds) {
                        $("#table .qType9").show();
                        $("#table .qType1").show();
                    }
                    if (itemIds) {
                        $("#table .qType9").show();
                        $("#table .qType2").show();
                    }

                    var bl = data.obj.list;
                    var dealRegs = {};
                    for (var i = 0; i < bl.length; i++) {
                        var d = bl[i];
                        var dealReg0 = {};

                        var regTaskType0 = "";
                        //任务类型：0无、1省级、2市级、3县级、4街镇
                        switch (d.regTaskType) {
                            case "1":
                                regTaskType0 = "省级"
                                break;
                            case "2":
                                regTaskType0 = "市级"
                                break;
                            case "3":
                                regTaskType0 = "县级"
                                break;
                            case "4":
                                regTaskType0 = "街镇"
                                break;
                            default:
                                regTaskType0 = "无"
                                break;
                        }

                        if (dealRegs[d.regId + "-" + d.regName + "-" + regTaskType0]) {
                            dealReg0 = dealRegs[d.regId + "-" + d.regName + "-" + regTaskType0];
                        }
                        //样品名称+检测项目的key
                        var keyFoodItem = "";
                        var dealRegFoodItem0 = {};
                        if (d.foodName) {
                            keyFoodItem += d.foodName;
                        }
                        if (d.itemName) {
                            if (keyFoodItem) {
                                keyFoodItem += "," + d.itemName;
                            } else {
                                keyFoodItem += d.itemName;
                            }
                        }

                        if (dealReg0[keyFoodItem]) {
                            dealRegFoodItem0 = dealReg0[keyFoodItem];
                        }
                        dealRegFoodItem0["foodName"] = d.foodName;
                        dealRegFoodItem0["itemName"] = d.itemName;
                        dealRegFoodItem0[d.conclusion] = {"检测数量": d.zs, "有效检测": d.yx};

                        dealReg0[keyFoodItem] = dealRegFoodItem0;
                        dealRegs[d.regId + "-" + d.regName + "-" + regTaskType0] = dealReg0;
                    }

                    //合计检测数量
                    var jcsl0 = 0;
                    //合计有效检测
                    var yxjc0 = 0;
                    //合计不合格
                    var bhg0 = 0;
                    //监管对象
                    var regs = [];
                    $.each(dealRegs, function (k0, v0) {
                        //监管对象名称
                        var jgdx = k0.split("-")[1];
                        //监管对象任务类型
                        var jgdxlx = k0.split("-")[2];
                        //检测数量
                        var jcsl = 0;
                        //有效检测
                        var yxjc = 0;
                        //不合格
                        var bhg = 0;
                        //样品种类-检测项目
                        var yps = [];

                        $.each(v0, function (k1, v1) {
                            //样品检测数量
                            var ypjcsl = 0;
                            //样品有效检测
                            var ypyxjc = 0;
                            //样品不合格
                            var ypbhg = 0;
                            //样品种类
                            var ypzl = v1["foodName"];
                            //检测项目
                            var jcxm = v1["itemName"];

                            if (v1["合格"]) {
                                ypjcsl += v1["合格"]["检测数量"];
                                ypyxjc += v1["合格"]["有效检测"];
                            }
                            if (v1["不合格"]) {
                                ypjcsl += v1["不合格"]["检测数量"];
                                ypyxjc += v1["不合格"]["有效检测"];

                                ypbhg += v1["不合格"]["检测数量"];
                            }
                            jcsl += ypjcsl;
                            yxjc += ypyxjc;
                            bhg += ypbhg;
                            yps.push({
                                "ypmc": k1,
                                "ypzl": ypzl,
                                "jcxm": jcxm,
                                "ypjcsl": ypjcsl,
                                "ypyxjc": ypyxjc,
                                "ypbhg": ypbhg
                            });
                        });
                        jcsl0 += jcsl;
                        yxjc0 += yxjc;
                        bhg0 += bhg;
                        regs.push({"jgdx": jgdx, "jgdxlx": jgdxlx, "jcsl": jcsl, "yxjc": yxjc, "bhg": bhg, "yps": yps});
                    });

                    $("#table tbody tr").remove();
                    $.each(regs, function (k, v) {
                        var trhtml =
                            "          <tr> " +
                            "              <td class=\"rowNo\" style=\"width:50px;\" rowspan=\"" + v.yps.length + "\">" + (k + 1) + "</td> " +
                            "              <td class=\"jgdx\" rowspan=\"" + v.yps.length + "\">" + v.jgdx + "</td> " +
                            (regTaskTypeFlag == 1 ? " <td class=\"jgdxlx\" rowspan=\"" + v.yps.length + "\">" + v.jgdxlx + "</td> " : "") +
                            "              <td class=\"jcsl\" rowspan=\"" + v.yps.length + "\">" + v.jcsl + "</td> " +
                            "              <td class=\"bhg\" rowspan=\"" + v.yps.length + "\">" + v.bhg + "</td> " +
                            "              <td class=\"bhgl\" rowspan=\"" + v.yps.length + "\">" + (v.bhg == 0 || v.jcsl == 0 ? "0.00" : (v.bhg / v.jcsl * 100).toFixed(2)) + "%</td> " +
                            (v.yps[0].ypzl ? " <td class=\"ypzl\">" + v.yps[0].ypzl + "</td> " : "") +
                            (v.yps[0].jcxm ? " <td class=\"jcxm\">" + v.yps[0].jcxm + "</td> " : "") +
                            (v.yps[0].ypzl || v.yps[0].jcxm ?
                                " <td class=\"ypjcsl\">" + v.yps[0].ypjcsl + "</td> " +
                                " <td class=\"ypbhg\">" + v.yps[0].ypbhg + "</td> " +
                                " <td class=\"ypbhgl\">" + (v.yps[0].ypbhg == 0 || v.yps[0].ypjcsl == 0 ? "0.00" : (v.yps[0].ypbhg / v.yps[0].ypjcsl * 100).toFixed(2)) + "%</td> "
                                : "") +
                            "          </tr>";
                        if (v.yps.length > 1) {
                            for (var i = 1; i < v.yps.length; i++) {
                                trhtml +=
                                    "          <tr> " +
                                    (v.yps[i].ypzl ? " <td class=\"ypzl\">" + v.yps[i].ypzl + "</td> " : "") +
                                    (v.yps[i].jcxm ? " <td class=\"jcxm\">" + v.yps[i].jcxm + "</td> " : "") +
                                    (v.yps[i].ypzl || v.yps[i].jcxm ?
                                        " <td class=\"ypjcsl\">" + v.yps[i].ypjcsl + "</td> " +
                                        " <td class=\"ypbhg\">" + v.yps[i].ypbhg + "</td> " +
                                        " <td class=\"ypbhgl\">" + (v.yps[i].ypbhg == 0 || v.yps[i].ypjcsl == 0 ? "0.00" : (v.yps[i].ypbhg / v.yps[i].ypjcsl * 100).toFixed(2)) + "%</td> "
                                        : "") +
                                    "          </tr>";
                            }
                        }
                        $("#table tbody").append(trhtml);
                    });

                    $("#table tbody").append(
                        "          <tr> " +
                        "              <td class=\"rowNo\" style=\"width:50px;\">" + (regs.length + 1) + "</td> " +
                        (regTaskTypeFlag == 1 ? " <td <td colspan=\"2\">合计</td> " : " <td>合计</td> ") +
                        "              <td>" + jcsl0 + "</td> " +
                        "              <td>" + bhg0 + "</td> " +
                        "              <td>" + (bhg0 == 0 || jcsl0 == 0 ? "0.00" : (bhg0 / jcsl0 * 100).toFixed(2)) + "%</td> " +
                        (foodTypeIds || itemIds ? " <td colspan=\"5\">——</td> " : "") +
                        "          </tr>");
                } else {
                    console.log("查询失败");
                }
            },
            error: function () {
                console.log("查询失败");
            }
        });
    }
</script>
</body>
</html>
