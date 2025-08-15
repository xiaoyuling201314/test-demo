<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/WEB-INF/view/common/resource.jsp" %>
<html>
<head>
    <title>快检服务云平台</title>
    <style>
        .cs-cont {
            padding-bottom: 50px
        }

        .cs-f-b li {
            color: #333;
        }

        .all-st-tr td {
            font-weight: bold;
        }

        .time-btns {
            width: 34px;
            height: 30px;
            background: #fff;
            border: 1px solid #ddd;
            float: left;
            margin: 0 5px;
            border-radius: 4px;
        }

        .time-btns:active {
            border: 0;
            outline: 0;
            color: #fff;
            background: #13adff;
        }

        .time-btns:focus {
            outline: 0;
            border-color: #ddd;
        }

        .time-all-se {
            width: 200px;
            float: left;
            margin-top: 5px;
            margin-left: 20px;
        }

        .swiper-slide {
            text-align: center;
            font-size: 14px;
            background: #fff;
            color: #007EEA;
            padding: 8px 20px;
            float: left;
            cursor: pointer;
        }

        .slide-active {
            background: #08bef8;
            color: #fff;
        }

        .swiper-box {
            background: #fff;
            border-bottom: 1px solid #ddd;

        }

        .cs-schedule-mao {
            margin: 0;
        }
    </style>
</head>
<body style="background:#ebebeb;">
<div class="cs-col-lg clearfix">
    <ol class="cs-breadcrumb">
        <li class="cs-fl">
            <img src="${webRoot}/img/set.png" alt=""/>
            <a>数据统计</a></li>
        <li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
        <li class="cs-b-active cs-fl">委托单位统计
        </li>
    </ol>
    <div class="cs-input-style cs-fl" style="margin:3px 0 0 30px;">
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
    <div class="cs-input-style cs-fl" style="margin:3px 0 0 15px;" id="typeDiv">

    </div>
    <!-- 面包屑导航栏  结束-->
    <!-- 顶部筛选 -->
    <%@include file="/WEB-INF/view/common/selectDate.jsp" %>
    <%--    <div class="time-all-se cs-input-style clearfix">
            <button id="previous" class="time-btns"><</button>
            <input id="start" style="width: 110px;" class="pull-left cs-time text-center" type="text"
                   onclick="WdatePicker({maxDate:'%y-%M-%d',onpicked:myChart})"/>
            <button id="next" class="time-btns">></button>
        </div>--%>
</div>
<div class="cs-cont" style="padding:10px;">
    <div class="cs-schedule-content clearfix">
        <div class="swiper-box clearfix" id="req_name_table"></div>
        <div class="cs-schedule-mao clearfix">
            <div class="col-lg-6 col-md-6 clearfix" style="padding:10px 5px 5px 5px; border-right:1px solid #eee;">
                <div id="third" style="height:230px;width:100%;"></div>
                <div class="cs-zong">
                    <p><span class="cs-list-style cs-list-style-yellow"></span>委托单位：<i id="req_units_max_num" class="text-primary">0</i> 个 </p>
                    <p><span class="cs-list-style cs-list-style-blue"></span>已送单位：<i id="req_units_check_num" class="text-primary">0</i> 个 </p>
                    <p><span class="cs-list-style cs-list-style-red"></span>未送单位：<i id="req_units_uncheck_num" class="text-danger">0</i> 个 </p>
                </div>
            </div>
            <div class="col-lg-6 col-md-6 clearfix" style="padding:10px 5px 5px 5px; border-right:1px solid #eee;">
                <div id="second" style="height:230px;width:100%;"></div>
                <div class="cs-zong">
                    <p><span class="cs-list-style cs-list-style-yellow"></span>应送总数：<i id="plan_check_num" class="text-primary">0</i> 个 </p>
                    <p><span class="cs-list-style cs-list-style-blue"></span>已送数量：<i id="check_num" class="text-primary">0</i> 个 </p>
                    <p><span class="cs-list-style cs-list-style-red"></span>未送数量：<i id="uncheck_num" class="text-danger">0</i> 个 </p>
                </div>
            </div>
        </div>
        <div class="cs-schedule-mao clearfix">
            <div class="col-lg-12 col-md-12 clearfix" style="padding:10px 5px 5px 5px; border-right:1px solid #eee;">
                <div id="progress6" style="height:280px;width:100%;"></div>
            </div>
        </div>
        <div id="dataList"></div>
    </div>
</div>
<%@include file="/WEB-INF/view/common/modalBox.jsp" %>
<script src="${webRoot}/js/datagridUtil2.js"></script>
<script type="text/javascript">
    $('#tree').tree({
        checkbox: false,
        url: "${webRoot}/detect/depart/getDepartTree.do",
        animate: true,
        onClick: function (node) {
            var did = node.id;
            $("#did").val(node.id);
            $("input[name='departName']").val(node.text);
            $(".cs-check-down").hide();
            selectDate.query();
        },
        onSelect: function (node) {
            var did = node.id;
            $("#did").val(node.id);
        }
    });
    //监控类型 1:餐饮 2:学校 3:食堂 4:供应商 9:其他
    let rutList = eval(${rutList});
    let unitTypeArr = [];
    let reqListMap;
    let monitoringType = 0;
    let startObj = $("#start");//只取一次值，后面重复使用，减少对象的创建
    let today = new Date();
    let searchData;
    startObj.val(today.format("yyyy-MM-dd"));
    $(function () {
        changeTab();
        project();
        selectDate.init(myChart);
        //myChart();


        $('.swiper-slide').click(function () {
            $(this).addClass('slide-active').siblings().removeClass('slide-active');
            let type = $(this).attr("data-type");
            if (monitoringType !== type) {
                monitoringType = type;
                initMyChart6(reqListMap["data" + type]);
                loadDataList();
            }
        })
    });
    function changeTab() {
        if (rutList.length > 0) {
            let html = "";
            for (i = 0; i < rutList.length; i++) {
                monitoringType = rutList[0].id;
                unitTypeArr.push(rutList[i].id);
                html += '<div class="swiper-slide ' + (i === 0 ? 'slide-active' : '') + '" data-type="' + rutList[i].id + '">' + rutList[i].unitType + '</div>';
            }
            $('#req_name_table').append(html)
        }
    }

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

    function myChart(d) {
        searchData = d;
        loadDataList(d);
        $.ajax({
            type: "POST",
            url: "${webRoot}/reqUnitStatistic/getData",
            traditional: true,//使得后台已原始的方式接收数组
            data: {
                type: d.type,
                year: d.year,
                month: d.month,
                season: d.season,
                start: d.start,
                end: d.end,
                did: $("#did").val(),
                unitTypeArr: unitTypeArr

            },
            dataType: "json",
            success: function (data) {
                if (data && data.success) {
                    let dataMap = data.obj;
                    $("#req_units_max_num").text(dataMap.req_units_max_num);
                    $("#req_units_check_num").text(dataMap.req_units_check_num);
                    $("#req_units_uncheck_num").text(dataMap.req_units_uncheck_num);
                    $("#plan_check_num").text(dataMap.plan_check_num);
                    $("#check_num").text(dataMap.check_num);
                    $("#uncheck_num").text(dataMap.uncheck_num);

                    let myChart1 = echarts.init(document.getElementById('third'), "shine");
                    let option1 = {
                        color: ['#476fd4'],
                        title: {
                            text: '送检情况',
                            textStyle: {
                                fontSize: 14,
                                padding: 10,                // 标题内边距，单位px，默认各方向内边距为5，
                                itemGap: 0,               //主副标题纵向间隔，单位px，默认为10，
                                fontWeight: 'bolder',
                                color: '#333'          // 主标题文字颜色
                            }
                        },
                        tooltip: {
                            trigger: 'item',
                            formatter: "{a} <br/>{b}: {c} ({d}%)"
                        },
                        legend: {
                            orient: 'vertical',
                            x: 'right',
                            data: ['已送检', '未送检']
                        },
                        series: [
                            {
                                name: '送检情况',
                                type: 'pie',
                                radius: ['40%', '60%'],
                                center: ['50%', '50%'],
                                data: [
                                    {value: dataMap.req_units_check_num, name: '已送检'},
                                    {value: dataMap.req_units_uncheck_num, name: '未送检'}
                                ],
                                itemStyle: {
                                    normal: {
                                        shadowBlur: 5,
                                        shadowOffsetX: 0,
                                        shadowOffsetY: -1,
                                        shadowColor: 'rgba(0, 0, 0, 0.4)'
                                    },
                                    emphasis: {
                                        shadowBlur: 10,
                                        shadowOffsetX: 0,
                                        shadowColor: 'rgba(0, 0, 0, 0.5)'
                                    }
                                },
                                labelLine: {
                                    normal: {
                                        length: 20,
                                        length2: 50,
                                    }
                                },
                                label: {
                                    normal: {
                                        formatter: '{a|{d}%}\n{b|{b}}',
                                        borderWidth: 0,
                                        borderRadius: 4,
                                        padding: [0, -50],
                                        rich: {
                                            a: {
                                                fontSize: 16,
                                                lineHeight: 20
                                            },
                                            hr: {
                                                width: '100%',
                                                borderWidth: 0.5,
                                                height: 0
                                            },
                                            b: {
                                                fontSize: 16,
                                                lineHeight: 20
                                            }
                                        }
                                    }
                                },
                            }
                        ]
                    };
                    // 使用刚指定的配置项和数据显示图表。
                    myChart1.setOption(option1);


                    let myChart2 = echarts.init(document.getElementById('second'), "shine");
                    let option2 = {
                        color: ['#476fd4'],
                        title: {
                            text: '应送检数情况',
                            textStyle: {
                                fontSize: 14,
                                padding: 10,                // 标题内边距，单位px，默认各方向内边距为5，
                                itemGap: 0,               //主副标题纵向间隔，单位px，默认为10，
                                fontWeight: 'bolder',
                                color: '#333'          // 主标题文字颜色
                            },
                        },
                        tooltip: {
                            trigger: 'item',
                            formatter: "{a} <br/>{b}: {c} ({d}%)"
                        },
                        legend: {
                            orient: 'vertical',
                            x: 'right',
                            data: ['已送检数', '未送检数']
                        },
                        series: [
                            {
                                name: '应送检数情况',
                                type: 'pie',
                                radius: ['40%', '60%'],
                                center: ['50%', '50%'],
                                labelLine: {
                                    normal: {
                                        length: 20,
                                        length2: 50,
                                    }
                                },
                                label: {
                                    normal: {
                                        formatter: '{a|{d}%}\n{b|{b}}',
                                        borderWidth: 0,
                                        borderRadius: 4,
                                        padding: [0, -50],
                                        rich: {
                                            a: {
                                                fontSize: 16,
                                                lineHeight: 20
                                            },
                                            hr: {
                                                width: '100%',
                                                borderWidth: 0.5,
                                                height: 0
                                            },
                                            b: {
                                                fontSize: 16,
                                                lineHeight: 20
                                            }
                                        }
                                    }
                                },
                                data: [
                                    {value: dataMap.check_num, name: '已送检数'},
                                    {value: dataMap.uncheck_num, name: '未送检数'}
                                ],
                                itemStyle: {
                                    normal: {
                                        shadowBlur: 5,
                                        shadowOffsetX: 0,
                                        shadowOffsetY: -1,
                                        shadowColor: 'rgba(0, 0, 0, 0.4)'
                                    },
                                    emphasis: {
                                        shadowBlur: 10,
                                        shadowOffsetX: 0,
                                        shadowColor: 'rgba(0, 0, 0, 0.5)'
                                    }
                                }
                            }
                        ]
                    };
                    // 使用刚指定的配置项和数据显示图表。
                    myChart2.setOption(option2);
                    reqListMap = dataMap;
                    initMyChart6(dataMap["data" + monitoringType]);
                } else {
                    alert("数据查询失败！")
                }
            }
        });
    }


    function initMyChart6(list) {
        let dataX = [];
        let dataY = [];
        if (list && list.length !== 0) {
            if (list.length >= 5 && list[4].checkNum === 0) {//如果数量不足5个或者第5个开始送检数就为0（目的是只展示5个）
                for (let i = 0; i < 5; i++) {
                    dataX.push(list[i].reqName);
                    dataY.push(list[i].checkNum);
                }
            } else if (list.length < 5) {//如果数量小于5就全部显示出去
                for (let i = 0; i < list.length; i++) {
                    dataX.push(list[i].reqName);
                    dataY.push(list[i].checkNum);
                }
            } else {
                for (let i = 0; i < list.length; i++) {//如果数量大于5，且第5个不为0就只展示存在数据的委托单位
                    if (list[i].checkNum > 0) {
                        dataX.push(list[i].reqName);
                        dataY.push(list[i].checkNum);
                    }
                }
            }
        }
        let option6 = {
            title: {
                text: '委托单位（送检数量）',
                x: 'left',
                textStyle: {
                    fontSize: 14,
                    padding: 10,                // 标题内边距，单位px，默认各方向内边距为5，
                    itemGap: 0,               //主副标题纵向间隔，单位px，默认为10，
                    fontWeight: 'bolder',
                    color: '#333'          // 主标题文字颜色
                },
            },
            tooltip: {
                trigger: 'axis',
                axisPointer: { // 坐标轴指示器，坐标轴触发有效
                    type: 'shadow', // 默认为直线，可选为：'line' | 'shadow'
                    label: {
                        show: true,
                        backgroundColor: '#333'
                    }
                },
            },
            grid: {
                left: '3%',
                right: '0%',
                bottom: '25%',
                top: '18%',
                containLabel: true
            },
            xAxis: [{
                type: 'category',
                data: dataX,
                axisPointer: {
                    type: "shadow"
                },
                splitLine: {
                    show: true
                },
                axisTick: {
                    show: false //X轴上面的刻度线
                },
                axisLine: {
                    show: true,
                    lineStyle: {
                        color: "#BCC2CA"
                    }
                },
                axisLabel: {
                    show: true,
                    interval: 0,
                    rotate: 15,
                    textStyle: {
                        "color": "#7d838b"
                    }
                }
            }],
            yAxis: [{
                type: 'value',
                axisLabel: {
                    show: true,
                    textStyle: {
                        color: "#7d838b"
                    }
                },
                splitLine: {
                    show: false //y轴的网格线
                },
                axisLine: {
                    show: true,
                    lineStyle: {
                        color: "#BCC2CA"
                    }
                },
                axisTick: { //y轴刻度线
                    show: false
                },
            }, {
                type: 'value',
                show: true,
                axisTick: { //y轴刻度线
                    "show": false
                },
                splitLine: {
                    show: false //y轴的网格线
                },
                axisLine: {
                    show: true,
                    lineStyle: {
                        color: "#BCC2CA"
                    }
                },
                axisLabel: {
                    show: false,
                    textStyle: {
                        "color": "#7d838b"
                    }
                }
            }],
            dataZoom: [
                {
                    show: true,
                    start: 0,
                    end: (dataY.length < 20 ? 100 : Math.round(20 / dataY.length * 100)),//控制宽度，最多看20个，个数越多可见比例越小
                    height: 20,
                    bottom: 0
                }
            ],
            series: [
                {
                    name: '送检数量',
                    type: 'bar',
                    data: dataY,
                    stack: '总量',
                    label: {
                        normal: {
                            show: true,
                            position: 'top'
                        }
                    },
                    itemStyle: {
                        normal: {
                            barBorderRadius: [2, 2, 0, 0],//柱形弧度
                            color: '#0098d9'
                        }
                    }
                }
            ]
        };
        let myChart6 = echarts.init(document.getElementById('progress6'), "shine");
        myChart6.setOption(option6);
    }


    function loadDataList(d) {
        d = d ? d : searchData;
        let datagrid1 = datagridUtil.initOption({
            tableId: "dataList",
            tableAction: "${webRoot}/reqUnitStatistic/datagrid2",
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
                    columnName: "委托单位",
                    //customElement: "<a class='text-primary cs-link req_details'>?<a>",
                },
                /*{
                 columnCode: "checkNumberDaily",
                 columnName: "应送检数"
                 },*/
                {
                    columnCode: "checkNum",
                    columnName: "已送检数",
                    sortDataType: "int",
                    columnWidth: "15%",
                },
                {
                    columnCode: "unqualifiedNum",
                    columnName: "不合格数",
                    sortDataType: "int",
                    customVal: {"is-null": "0", "non-null": "<span style='color: red'>?</span>"},
                    columnWidth: "15%",
                }/*,
                 {
                 columnCode: "checkRate",
                 columnName: "完成率",
                 customElement: "?%",
                 columnWidth: "15%",
                 }*/
                ,
                {
                    columnCode: "passRate",
                    columnName: "合格率",
                    customStyle: "pass_rate",
                    sortDataType: "float",
                    columnWidth: "15%",
                    //customVal: {"is-null": "0.00%", "non-null": "?%"}
                }
            ], onload: function (rows, data) {
                $(rows).each(function (index, value) {
                    let passRate = value.passRate==""?"-":(value.passRate+"%");
                    let currentTd = $("tr[data-rowid=" + value.id + "]").find(".pass_rate");
                    currentTd.html(passRate);
                });

            }
        });
        datagrid1.query();
    }

    //查看委托单位送检详情
    $(document).on("click", ".req_details", function () {
        showMbIframe("${webRoot}/reqUnitStatistic/list?id=" + $(this).parents(".rowTr").attr("data-rowId"));
    });

</script>
</body>
</html>
