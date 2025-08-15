<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/common/resource.jsp"%>
<html>
<head>
	<title>快检服务云平台</title>
</head>
<body style="background:#ebebeb;">

<div class="cs-col-lg clearfix">
	<ol class="cs-breadcrumb">
		<li class="cs-fl">
			<img src="${webRoot}/img/set.png" alt="" />
			<a href="javascript:">财务管理</a></li>
		<li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
		<li class="cs-b-active cs-fl">订单统计</li>
	</ol>
	<%@include file="/WEB-INF/view/common/selectDate.jsp"%>
</div>

<div class="cs-cont">
	<div class="cs-schedule-content clearfix">
		<div class="cs-schedule-mao clearfix">
			<div class="col-lg-4 col-md-4 col-sm-4 clearfix all-font">
				<div class="col-lg-2 col-md-2 col-sm-2 clearfix all-side-icon">
					<i class="icon iconfont icon-dashuju"></i>
				</div>
				<div class="col-lg-10 col-md-10 col-sm-10 clearfix all-top">
					<div class="col-lg-12 col-md-12 col-sm-12 clearfix all-top-title">总收入：<b><fmt:formatNumber value="${totalIncome.income}" pattern="0.00"/> 元</b></div>
					<div class="col-lg-12 col-md-12 col-sm-12 clearfix all-bottom">
						<div class="col-lg-6 col-md-6 col-sm-6 clearfix">
							<p><span class="pull-left">订单总数：</span><span class="all-bottom-num pull-left">${totalIncome.order_number}个</span></p>

						</div>
						<div class="col-lg-6 col-md-6 col-sm-6 clearfix">
							<p><span class="pull-left">送检用户：</span><span class="all-bottom-num pull-left">${totalIncome.ins_user_number}个</span></p>

						</div>
						<%--<div class="col-lg-4 col-md-4 col-sm-4 clearfix">
							<p>订单总数</p>
							<p class="all-bottom-num">${totalIncome.order_number}份</p>
						</div>
						<div class="col-lg-4 col-md-4 col-sm-4 clearfix">
							<p>送检单位</p>
							<p class="all-bottom-num">${totalIncome.ins_unit_number}个</p>
						</div>--%>
						<%--<div class="col-lg-4 col-md-4 col-sm-4 clearfix">
							<p>委托单位</p>
							<p class="all-bottom-num">${totalIncome.req_unit_number}个</p>
						</div>--%>
					</div>
				</div>
			</div>

			<div class="col-lg-4 col-md-4 col-sm-4 clearfix all-font">
				<div class="col-lg-2 col-md-2 col-sm-2 clearfix all-side-icon">
					<i class="icon iconfont icon-benyue"></i>
				</div>
				<div class="col-lg-10 col-md-10 col-sm-10 clearfix all-top">
					<div class="col-lg-12 col-md-12 col-sm-12 clearfix all-top-title">本月收入：<b><fmt:formatNumber value="${monthIncome.income}" pattern="0.00"/>元</b></div>
					<div class="col-lg-12 col-md-12 col-sm-12 clearfix all-bottom">
						<div class="col-lg-6 col-md-6 col-sm-6 clearfix">
							<p><span class="pull-left">订单总数：</span><span class="all-bottom-num pull-left">${monthIncome.order_number}个</span></p>

						</div>
						<div class="col-lg-6 col-md-6 col-sm-6 clearfix">
							<p><span class="pull-left">送检用户：</span><span class="all-bottom-num pull-left">${monthIncome.ins_user_number}个</span></p>

						</div>
						<%--<div class="col-lg-4 col-md-4 col-sm-4 clearfix">
							<p>订单总数</p>
							<p class="all-bottom-num">${monthIncome.order_number}份</p>
						</div>
						<div class="col-lg-4 col-md-4 col-sm-4 clearfix">
							<p>送检单位</p>
							<p class="all-bottom-num">${monthIncome.ins_unit_number}个</p>
						</div>--%>
						<%--<div class="col-lg-4 col-md-4 col-sm-4 clearfix">
							<p>委托单位</p>
							<p class="all-bottom-num">${monthIncome.req_unit_number}个</p>
						</div>--%>
					</div>
				</div>
			</div>

			<div class="col-lg-4 col-md-4 col-sm-4 clearfix all-font">
				<div class="col-lg-2 col-md-2 col-sm-2 clearfix all-side-icon">
					<i class="icon iconfont icon-jintian"></i>
				</div>
				<div class="col-lg-10 col-md-10 col-sm-10 clearfix all-top">
					<div class="col-lg-12 col-md-12 col-sm-12 clearfix all-top-title">今日收入：<b><fmt:formatNumber value="${dayIncome.income}" pattern="0.00"/>元</b></div>
					<div class="col-lg-12 col-md-12 col-sm-12 clearfix all-bottom">
						<div class="col-lg-6 col-md-6 col-sm-6 clearfix">
							<p><span class="pull-left">订单总数：</span><span class=" all-bottom-num pull-left">${dayIncome.order_number}个</span></p>

						</div>
						<div class="col-lg-6 col-md-6 col-sm-6 clearfix">
							<p><span class="pull-left">送检用户：</span><span class=" all-bottom-num pull-left">${dayIncome.ins_user_number}个</span></p>

						</div>
						<%--<div class="col-lg-4 col-md-4 col-sm-4 clearfix">
							<p>订单总数</p>
							<p class="all-bottom-num">${dayIncome.order_number}份</p>
						</div>
						<div class="col-lg-4 col-md-4 col-sm-4 clearfix">
							<p>送检单位</p>
							<p class="all-bottom-num">${dayIncome.ins_unit_number}个</p>

						</div>--%>
						<%--<div class="col-lg-4 col-md-4 col-sm-4 clearfix">
							<p>委托单位</p>
							<p class="all-bottom-num">${dayIncome.req_unit_number}个</p>
						</div>--%>
					</div>
				</div>
			</div>
		</div>

		<div class="cs-schedule-mao clearfix">
			<div class="col-lg-4 col-md-4 clearfix" style="padding:10px 5px 5px 5px; border-right:1px solid #eee;" >
				<div id="progress4" style="height:230px;width:100%;"></div>
			</div>

			<div class="col-lg-8 col-md-8 clearfix" style="padding:10px 5px 5px 5px; border-right:1px solid #eee;" >
				<div id="progress2" style="height:230px;width:100%;"></div>
			</div>

			<%--<div class="col-lg-4 col-md-4 clearfix" style="padding:10px 5px 5px 5px; border-right:1px solid #eee;" >--%>
				<%--<div id="progress3" style="height:230px;width:100%;"></div>--%>
			<%--</div>--%>

		</div>

		<div class="cs-schedule-mao clearfix" style="position:relative;">
			<div class="col-lg-12 col-md-12 clearfix" style="padding:10px 5px 5px 5px; border-right:1px solid #eee;" >
				<div id="progress5" style="height:230px;width:100%;"></div>
			</div>
		</div>

		<div class="cs-schedule-mao clearfix">
			<div class="col-lg-12 col-md-12 clearfix" style="padding:10px 5px 5px 5px; border-right:1px solid #eee;" >
				<div id="progress6" style="height:230px;width:100%;"></div>
			</div>
		</div>
		<div class="cs-schedule-mao clearfix">
			<div class="col-lg-12 col-md-12 clearfix" style="padding:10px 5px 5px 5px; border-right:1px solid #eee;" >
				<div id="progress7" style="height:230px;width:100%;"></div>
			</div>
		</div>
	</div>
</div>

<%--<script src="${webRoot}/js/datagridUtil2.js"></script>--%>
<script type="text/javascript">
    //selectDate修改时间后执行函数
    selectDate.init(function (d) {
        var type = d.type;
        var year = d.year;
        var month = d.month;
        var season = d.season;
        var start = d.start;
        var end = d.end;
        $.ajax({
            type: "POST",
            url: "${webRoot}/orderStatistic/getChartData",
            data: {"yyyy":year,"mm":month,"season":season,"start":start,"end":end},
            dataType: "json",
            success: function(data){
                if(data && data.success){
                    var incomesDate = [];	//日期
                    var incomesAmount = [];	//收入金额
                    var ordersAmount = [];	//订单数量

                    var foodsName = [];
                    var foodsNumber = [];
                    var itemsName = [];
                    var itemsNumber = [];

                    var incomeTitle = "收入趋势";
                    var foodTitle = "送检样品";
                    var itemTitle = "检测项目";
                    var insUnitTitle = "委托单位订单";
                    // switch ($("#province").val()) {
                    // 	case "month":
                    // 		var year0 = $(".check-date:eq(1) [name='year']").val();
                    // 		var month0 = $(".check-date:eq(1) [name='month']").val();
                    // 		if (parseInt(month0)<10){
                    // 			month0 = "0"+month0;
                    // 		}
                    // 		incomeTitle += "("+year0+"年"+month0+"月)";
                    // 		foodTitle += "("+year0+"年"+month0+"月)";
                    // 		itemTitle += "("+year0+"年"+month0+"月)";
                    // 		insUnitTitle += "("+year0+"年"+month0+"月)";
                    // 		break;
                    //
                    // 	case "season":
                    // 		var year0 = $(".check-date:eq(2) [name='year']").val();
                    // 		var season0 = $(".check-date:eq(2) [name='season']").val();
                    // 		switch (season0) {
                    // 			case "1":
                    // 				season0 = "一";
                    // 				break;
                    // 			case "2":
                    // 				season0 = "二";
                    // 				break;
                    // 			case "3":
                    // 				season0 = "三";
                    // 				break;
                    // 			case "4":
                    // 				season0 = "四";
                    // 				break;
                    // 		}
                    // 		incomeTitle += "("+year0+"年 第"+season0+"季度)";
                    // 		foodTitle += "("+year0+"年 第"+season0+"季度)";
                    // 		itemTitle += "("+year0+"年 第"+season0+"季度)";
                    // 		insUnitTitle += "("+year0+"年 第"+season0+"季度)";
                    // 		break;
                    //
                    // 	case "year":
                    // 		var year0 = $(".check-date:eq(3) [name='year']").val();
                    // 		incomeTitle += "("+year0+"年)";
                    // 		foodTitle += "("+year0+"年)";
                    // 		itemTitle += "("+year0+"年)";
                    // 		insUnitTitle += "("+year0+"年)";
                    // 		break;
                    //
                    // 	case "diy":
                    // 		var start0 = $(".check-date:eq(4) [name='start']").val();
                    // 		var end0 = $(".check-date:eq(4) [name='end']").val();
                    // 		incomeTitle += "("+start0.replace(/-/g,"/")+"-"+end0.replace(/-/g,"/")+")";
                    // 		foodTitle += "("+start0.replace(/-/g,"/")+"-"+end0.replace(/-/g,"/")+")";
                    // 		itemTitle += "("+start0.replace(/-/g,"/")+"-"+end0.replace(/-/g,"/")+")";
                    // 		insUnitTitle += "("+start0.replace(/-/g,"/")+"-"+end0.replace(/-/g,"/")+")";
                    // 		break;
                    // }

                    var incomes = data.obj.incomes;
                    var foodMap = data.obj.foodMap;
                    var itemMap = data.obj.itemMap;
                    // var reqUnitMap = data.obj.reqUnitMap;

                    $.each(incomes, function(index, value){
                        incomesDate.push(!value.date ? "" : newDate(value.date).format("yyyy-MM-dd"));
                        incomesAmount.push(!value.incomeOrder ? "0" : value.incomeOrder.toFixed(2));
                        ordersAmount.push(!value.qtyOrder ? "0" : value.qtyOrder);
                    });

                    var foodsData = [];
                    var itemsData = [];
                    for (var key in foodMap) {
                        foodsData.push(foodMap[key]);
                    }
                    for (var key in itemMap) {
                        itemsData.push(itemMap[key]);
                    }
                    foodsData.sort(function(a, b){
                        if (a.number > b.number) {
                            return -1;
                        } else if (a.number < b.number) {
                            return 1;
                        } else {
                            return 0;
                        }
                    })
                    itemsData.sort(function(a, b){
                        if (a.number > b.number) {
                            return -1;
                        } else if (a.number < b.number) {
                            return 1;
                        } else {
                            return 0;
                        }
                    });
                    $.each(foodsData, function(index, value){
                        foodsName.push(value.name);
                        foodsNumber.push(value.number);
                    });
                    $.each(itemsData, function(index, value){
                        itemsName.push(value.name);
                        itemsNumber.push(value.number);
                    });

                    //下单方式
                    myChart4.setOption({
                        series: {
                            data: [
                                {value:data.obj.orderWx, name:'微信端'},
                                {value:data.obj.orderZd, name:'自助终端'}
                            ]
                        }
                    });

                    //订单趋势
                    myChart2.setOption({
                        xAxis: {
                            data: incomesDate
                        },
                        series: {
                            data: ordersAmount
                        }
                    });

                    //收入趋势
                    myChart5.setOption({
                        title: {
                            text: incomeTitle
                        },
                        xAxis: {
                            data: incomesDate
                        },
                        series: {
                            data: incomesAmount
                        }
                    });

                    //检测项目
                    myChart7.setOption({
                        title: {
                            text: itemTitle
                        },
                        xAxis: {
                            data: itemsName
                        },
                        series: {
                            data: itemsNumber
                        }
                    });

                    //送检样品
                    myChart6.setOption({
                        title: {
                            text: foodTitle
                        },
                        xAxis: {
                            data: foodsName
                        },
                        series: {
                            data: foodsNumber
                        },
                        dataZoom: [
                            {
                                start: 0,
                                end: (foodsNumber.length<30 ? 100 : Math.round(30 / foodsNumber.length * 100))
                            }
                        ],
                    });

                }
            }
        });
    });


	//检测项目
	var myChart6 = echarts.init(document.getElementById('progress6'),"shine");
	var option6 = {
		title : {
			text: '检测项目',
			x:'left',
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
			bottom: '18%',
			top:'18%',
			containLabel: true
		},
		xAxis: [{
			type: 'category',
			data: [],
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
				rotate: 25,
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
                end: 100,
                height:20,
                bottom:0
            }
        ],
		series: [
			{
				name: '数量',
				type: 'bar',
				data: [],
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
	myChart6.setOption(option6);

	//送检样品
	var myChart7 = echarts.init(document.getElementById('progress7'),"shine");
	var option7 = {
		title : {
			text: '送检样品',
			// subtext: '总收款：300万元',
			x:'left',
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
			bottom: '12%',
			top:'18%',
			containLabel: true
		},
		xAxis: [{
			type: 'category',
			data: [],
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
				rotate: 25,
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
				show: true,
				textStyle: {
					"color": "#7d838b"
				}
			}
		}],
		series: [
			{
				name: '数量',
				type: 'bar',
				data: [],
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
						color: '#fe7576'
					}
				}
			}
		]
	};
	myChart7.setOption(option7);


	//收入趋势
	var myChart5 = echarts.init(document.getElementById('progress5'),"shine");
	var option5 = {
		color: [ '#476fd4'],
		title: {
			text: '收入趋势',
			// subtext: '总收款：300万元',
			x:'left',
			textStyle: {
				fontSize: 14,
				padding: 10,                // 标题内边距，单位px，默认各方向内边距为5，
				itemGap: 0,               //主副标题纵向间隔，单位px，默认为10，
				fontWeight: 'bolder',
				color: '#333'          // 主标题文字颜色
			}
		},
		tooltip: {
			trigger: 'axis'
		},
		legend: {
			orient: 'horizontal',
			left: 'right',
			data: ['收入趋势'],
			show:false
		},
		grid: {
			left: '3%',
			right: '2%',
			bottom: '12%',
			top:'18%',
			containLabel: true
		},
		xAxis: {
			type: 'category',
			boundaryGap: false,
			data: [],
			splitLine: {
				show: true
			},
			axisLabel: {
				/*interval: 0,*/
				rotate: 30,
				show: true,
				splitNumber: 15,
				textStyle: {
					fontSize: 12
				}
			}
		},
		yAxis: {
			type: 'value',
			axisLabel: {

				show: true,

			}
		},
		series: [
			{
				name:'收入(元)',
				type:'line',
				stack: '总量1',
				label: {
					normal: {
						show: true,
						position: 'top'
					}
				},
				data:[]
			}
		]
	};

	myChart5.setOption(option5);

	/*
	//今日收入趋势
	var income_data = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
	if ('${trend}') {
		var income_trend = JSON.parse('${trend}');
		for (var i=0; i<income_trend.length; i++){
			var index = parseInt(income_trend[i].pay_hour);
			income_data[index] = income_trend[i].inspection_fee;
		}
	}
	var myChart3 = echarts.init(document.getElementById('progress3'),"shine");
	var data3 = [' 00:00',' 01:00',' 02:00',' 03:00',' 04:00',' 05:00',' 06:00',' 07:00',' 08:00',' 09:00',' 10:00',' 11:00',' 12:00',' 13:00',' 14:00',' 15:00',' 16:00',' 17:00',' 18:00',' 19:00',' 20:00',' 21:00',' 22:00',' 23:00']
	var option3 = {
		title: {
			text: '今日收入趋势',
			// subtext: '总收款：300万元',
			x:'left',
			textStyle: {
				fontSize: 14,
				padding: 10,                // 标题内边距，单位px，默认各方向内边距为5，
				itemGap: 0,               //主副标题纵向间隔，单位px，默认为10，
				fontWeight: 'bolder',
				color: '#333'          // 主标题文字颜色
			}
		},
		tooltip: {
			trigger: 'axis'
		},
		legend: {
			orient: 'horizontal',
			left: 'right',
			data: ['收入趋势']
		},
		grid: {
			left: '3%',
			right: '4%',
			bottom: '12%',
			top:'18%',
			containLabel: true
		},
		xAxis: {
			type: 'category',
			boundaryGap: false,

			data: data3,

			splitLine: {
				show: false
			},
			axisLabel: {

				rotate: 0,
				show: true,
				splitNumber: 15,
				textStyle: {
					fontSize: 12
				}
			}
		},
		yAxis: {
			type: 'value',
			axisLabel: {

				show: true,

			}
		},
		series: [
			{
				name:'收入(元)',
				type:'line',
				stack: '收入(元)',
				label: {
					normal: {
						show: true,
						position: 'top'
					}
				},
				data: income_data
			}
		]
	};

	myChart3.setOption(option3);


	//今日订单趋势
	if ('${trend}') {
		var order_trend = JSON.parse('${trend}');
		var order_data = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
		for (var i=0; i<order_trend.length; i++){
			var index = parseInt(order_trend[i].pay_hour);
			order_data[index] = order_trend[i].order_number;
		}
	}
	var myChart2 = echarts.init(document.getElementById('progress2'),"shine");
	var data2 = ['00:00','01:00','02:00','03:00','04:00','05:00','06:00','07:00','08:00','09:00','10:00','11:00','12:00','13:00','14:00','15:00','16:00','17:00','18:00','19:00','20:00','21:00','22:00','23:00']
	var option2 = {
		color: ['#fe7576', '#a9b0d3', '#476fd4'],
		title: {
			text: '今日订单趋势',
			x:'left',
			textStyle: {
				fontSize: 14,
				padding: 10,                // 标题内边距，单位px，默认各方向内边距为5，
				itemGap: 0,               //主副标题纵向间隔，单位px，默认为10，
				fontWeight: 'bolder',
				color: '#333'          // 主标题文字颜色
			}
		},
		tooltip: {
			trigger: 'axis'
		},
		legend: {
			orient: 'horizontal',
			left: 'right',
			data: ['今日订单趋势']
		},
		grid: {
			left: '3%',
			right: '4%',
			bottom: '12%',
			top:'18%',
			containLabel: true
		},
		xAxis: {
			type: 'category',
			boundaryGap: false,

			data: data2,

			splitLine: {
				show: false
			},
			axisLabel: {

				rotate: 0,
				show: true,
				splitNumber: 15,
				textStyle: {
					fontSize: 12
				}
			}
		},
		yAxis: {
			type: 'value',
			axisLabel: {
				show: true,
			}
		},
		series: [
			{
				name:'数量',
				type:'line',
				stack: '数量',
				label: {
					normal: {
						show: true,
						position: 'top'
					}
				},
				data: order_data
			}
		]
	};

	myChart2.setOption(option2);
	*/

	//订单趋势
	var myChart2 = echarts.init(document.getElementById('progress2'),"shine");
	var option2 = {
		color: [ '#476fd4'],
		title: {
			text: '订单趋势',
			x:'left',
			textStyle: {
				fontSize: 14,
				padding: 10,                // 标题内边距，单位px，默认各方向内边距为5，
				itemGap: 0,               //主副标题纵向间隔，单位px，默认为10，
				fontWeight: 'bolder',
				color: '#333'          // 主标题文字颜色
			}
		},
		tooltip: {
			trigger: 'axis'
		},
		legend: {
			orient: 'horizontal',
			left: 'right',
			data: ['收入趋势'],
			show:false
		},
		grid: {
			left: '3%',
			right: '2%',
			bottom: '12%',
			top:'18%',
			containLabel: true
		},
		xAxis: {
			type: 'category',
			boundaryGap: false,
			data: [],
			splitLine: {
				show: true
			},
			axisLabel: {
				rotate: 30,
				show: true,
				splitNumber: 15,
				textStyle: {
					fontSize: 12
				}
			}
		},
		yAxis: {
			type: 'value',
			axisLabel: {
				show: true,
			}
		},
		series: [
			{
				name:'数量',
				type:'line',
				stack: '总量1',
				label: {
					normal: {
						show: true,
						position: 'top'
					}
				},
				data:[]
			}
		]
	};

	myChart2.setOption(option2);



	//下单方式
	var myChart4 = echarts.init(document.getElementById('progress4'),"shine");
	var option4 = {
		color: ['#fe7576', '#476fd4', '#0098d9', '#0F347B', '#7F6AAD', '#009D85','#fe7576'],
		title: {
			text: '下单方式',
			// subtext: '总收款：300万元',
			x:'left',
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
			y:'',
			data:['微信支付','支付宝支付','余额支付','微信端','自助终端'],
			show:true
		},
		series: [
			{
				name:'订单来源',
				type:'pie',
				center:['40%','50%'],
				radius: ['45%', '65%'],
				label: {
					normal: {
						formatter: '{b}\n{d}%'
					},

				},
				data:[
					/*全部订单*/
					<%--{value:'${way.order_wx}', name:'微信端'},--%>
					<%--{value:'${way.order_zd}', name:'自助终端'}--%>

					/*时间范围内订单*/
					{value:0, name:'微信端'},
					{value:0, name:'自助终端'}
				]
			}
		]
	};

	myChart4.setOption(option4);


</script>
</body>
</html>
