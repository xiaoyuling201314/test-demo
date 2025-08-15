<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/WEB-INF/view/common/resource.jsp" %>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="description" content="">
    <meta name="author" content="食安科技">
    <meta http-equiv="X-UA-Compatible" content="IE=Edge">
    <title>快检服务云平台</title>
</head>

<body>
<div class="cs-maintab">
    <div class="cs-col-lg clearfix">
        <ol class="cs-breadcrumb">
            <li class="cs-fl">
                <img src="${webRoot}/img/set.png" alt=""/>
                <a href="javascript:">数据统计</a></li>
            <li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
            <li class="cs-b-active cs-fl">检测监控</li>
            <li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
            <li class="cs-b-active cs-fl">送检详情</li>
        </ol>
        <div class="cs-fl" style="margin:3px 0 0 30px;">
            <%@include file="/WEB-INF/view/common/selectDate.jsp" %>
        </div>
        <div class="cs-search-box cs-fr">
            <a onclick="parent.closeMbIframe(1);" class="cs-menu-btn"><i class="icon iconfont icon-fanhui"></i>返回</a>
        </div>
    </div>

    <div class="cs-tb-box">
        <div class="cs-base-detail">
            <div class="cs-content2 clearfix">
                <div class="cs-add-pad cs-input-bg">
                    <h3>单位信息</h3>
                    <table class="cs-form-table cs-form-table-he">
                        <tbody>
                        <tr>
                            <td class="cs-name" style="width:160px;">单位名称：</td>
                            <td class="cs-in-style" style="width:34%; padding-left:10px;">
                                ${reqUnit.requesterName}
                            </td>
                            <td class="cs-name" style="width:160px;">社会统一信用代码：</td>
                            <td class="cs-in-style" style=" padding-left:10px;" colspan="2">
                                ${reqUnit.creditCode}
                            </td>
                        </tr>
                        <tr>
                            <td class="cs-name" style="width:160px;">所属机构：</td>
                            <td class="cs-in-style" style=" padding-left:10px;">
                                ${reqUnit.departName2}
                            </td>
                            <td class="cs-name" style="width:160px;">法人名称：</td>
                            <td class="cs-in-style" style=" padding-left:10px;" colspan="2">
                                ${reqUnit.legalPerson}
                            </td>
                        </tr>
                        <tr>
                            <td class="cs-name" style="width:160px;">单位类型：</td>
                            <td class="cs-in-style" style=" padding-left:10px;">
                                <c:forEach items="${rutList}" var="req">
                                    <c:if test="${req.id==reqUnit.unitType}">
                                        ${req.unitType}
                                    </c:if>
                                </c:forEach>
                            </td>
                            <td class="cs-name" style="width:160px;">审核状态：</td>
                            <td class="cs-in-style" style=" padding-left:10px;" colspan="2">
                                ${reqUnit.checked==0?'<span style="color:red">未审核</span>':"已审核"}
                            </td>
                        </tr>
                        <tr>
                            <td class="cs-name" style="width:160px;">单位状态：</td>
                            <td class="cs-in-style" style=" padding-left:10px;">
                                ${reqUnit.state==0?"开业":'<span style="color:red">停业</span>'}
                            </td>
                            <td class="cs-name" style="width:160px;">经营范围：</td>
                            <td class="cs-in-style" style=" padding-left:10px;">
                                ${reqUnit.businessCope}
                            </td>
                        </tr>
                        <tr>
                            <td class="cs-name" style="width:160px;">日测批次：</td>
                            <td class="cs-in-style" style=" padding-left:10px;">
                                ${reqUnit.checkNum}
                            </td>
                            <td class="cs-name" style="width:160px;">就餐人数：</td>
                            <td class="cs-in-style" style=" padding-left:10px;" colspan="2">
                                ${reqUnit.scope}
                            </td>
                        </tr>
                        <tr>
                            <td class="cs-name" style="width:160px;">联系人：</td>
                            <td class="cs-in-style" style=" padding-left:10px;">
                                ${reqUnit.linkUser}
                            </td>
                            <td class="cs-name" style="width:160px;">联系方式：</td>
                            <td class="cs-in-style" style=" padding-left:10px;" colspan="2">
                                ${reqUnit.linkPhone}
                            </td>
                        </tr>
                        <td class="cs-name" style="width:160px;">通讯地址：</td>
                        <td class="cs-in-style" style=" padding-left:10px;" colspan="3">
                            ${reqUnit.companyAddress}
                        </td>
                        </tbody>
                    </table>
                    <h3>检测数据</h3>
                    <div id="dataList" class="cs-fix-num">
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
<script src="${webRoot}/js/datagridUtil.js"></script>
<script type="text/javascript">
    //设置初始值
    $(function () {
        setDate({type: "${type}", month: "${month}", season: "${season}", year: "${year}", start: "${start}", end: "${end}"});
    });
    function loadData(d) {
        //d = {type: "year", month: "", season: "", year: "2020", start: "2020-04-01", end: "2020-04-01"};
        console.log(d);
        let op = {
            tableId: "dataList",
            tableAction: "${webRoot}/checkMonitor/datagrid_details",
            defaultCondition: [
                {
                    queryCode: "id",
                    queryVal: "${id}"
                },
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
                }
            ],
            parameter: [
                {
                    columnCode: "opeShopName",
                    columnName: "样品编号",
                    columnWidth: "13%",
                },
                {
                    columnCode: "foodName",
                    columnName: "样品名称",
                },
                {
                    columnCode: "itemName",
                    columnName: "检测项目",
                    columnWidth: "20%",
                },
                {
                    columnCode: "checkResult",
                    columnName: "检测值",
                    sortDataType: "float",
                    columnWidth: "7%",
                },
                {
                    columnCode: "samplingDate",
                    columnName: "下单时间",
                    sortDataType: "date",
                    columnWidth: "13%",
                },
                {
                    columnCode: "checkDate",
                    columnName: "检测时间",
                    sortDataType: "date",
                    columnWidth: "13%",
                },
                {
                    columnCode: "conclusion",
                    columnName: "检测结果",
                    sortDataType: "int",
                    columnWidth: "7%",
                    customVal: {
                        "合格": "<div class=\"text-success\">合格</span>",
                        "不合格": "<div class=\"text-danger\">不合格</span>"
                    }
                },
                {
                    columnCode: "checkUsername",
                    columnName: "检测人员",
                    columnWidth: "8%",
                }
            ]
        };
        datagridUtil.initOption(op);
        datagridUtil.query();
    }

    function setDate(d) {
        var selyear = $(".theyear");
        var startYear = 2017;
        var now = new Date();
        var year = now.getFullYear(); //获取当前年份
        var betYear = year - startYear + 1;
        for (var i = 0; i < betYear; i++) {
            var option = $("<option>").val(startYear).text(startYear + "年"); //给option添加value值与文本值
            selyear.append(option);  //添加到select下
            startYear = startYear + 1;       //年份+1，再添加一次
        }

        var monthsss = now.getMonth() + 1;
        if (d.season) {
            $("#season").val(d.season);
        } else {
            switch (now.getMonth()) {
                case 0, 1, 2:
                    $("#season").val("1");
                    break;
                case 3, 4, 5:
                    $("#season").val("2");
                    break;
                case 6, 7, 8:
                    $("#season").val("3");
                    break;
                case 9, 10, 11:
                    $("#season").val("4");
                    break;
            }
        }
        if (d.month) {
            $("#month").val(d.month);
        } else {
            $("#month").find("option[value='" + monthsss + "']").attr("selected", true);
        }

        //时间段
        var month = (now.getMonth() + 1) < 10 ? "0" + (now.getMonth() + 1) : (now.getMonth() + 1);
        var date = now.getDate() < 10 ? "0" + now.getDate() : now.getDate();
        if (d.type == "diy") {
            if (d.start) {
                $("#start").val(d.start);
            } else {

            }
            if (d.end) {
                $("#end").val(d.end);
            } else {

            }
        } else {
            $("#start").val(now.getFullYear() + "-" + month + "-01");
            $("#end").val(now.getFullYear() + "-" + month + "-" + date);
        }
        if (d.year) {
            $(".theyear").find("option[value='" + d.year + "']").attr("selected", true);
        } else {
            $(".theyear").find("option[value='" + year + "']").attr("selected", true);
        }
        $("#province").val(d.type).change();
        selectDate.query = function () {
            loadData(selectDate.getSelectDate())
        };
        selectDate.query();
    }

</script>
</html>
