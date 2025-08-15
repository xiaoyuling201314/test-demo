<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/common/resource.jsp"%>
<html>
<head>
	<title>快检服务云平台</title>
</head>
<style>
	.cs-cont{
		padding-bottom: 50px
	}
	.cs-bottom-tools2{
		position: static;
	}
	.cs-f-b li {
		color: #333;
	}
	.cs-all-stat{
		position: absolute;
		right: 10px;
	}
	.progress{
		background: #eaeaea;
	}
	.icon-zuo,.icon-you{
		position: absolute;
		left: 0px;
		top: 40%;
		font-size: 40px;
		cursor:pointer;
	}
	.icon-zuo:hover,.icon-you:hover{
		color: #006fce;
	}
	.icon-you{
		right: 0px;
		left: auto;
	}
	.progress {
		height: 28px;
		line-height: 28px;
	}
	.cs-line-h,.progress-bar {
		line-height: 28px
	}
	.all-st-tr td{
		font-weight: bold;
	}
	.cs-show-alls{
		cursor: pointer;
	}
	.progress-bar{
		text-shadow: 1px 1px 1px #000;
	}
	.all-bottom{
		text-align: center;
	}
	.all-bottom .icon{
		margin-right: 4px;
	}
	.all-top-title{
		padding: 0 20px;
	}
</style>
</head>

<body style="background:#ebebeb;">

<div class="cs-col-lg clearfix">
	<ol class="cs-breadcrumb">
		<li class="cs-fl">
			<img src="${webRoot}/img/set.png" alt="" />
			<a href="javascript:">财务管理</a></li>
		<li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
		<li class="cs-b-active cs-fl">收入统计
		</li>
	</ol>

	<%@include file="/WEB-INF/view/common/selectDate.jsp"%>

</div>

<div class="cs-cont">
	<div class="cs-schedule-content clearfix">
		<div class="cs-schedule-mao clearfix">
			
			<div class="col-lg-6 col-md-6 col-sm-6 clearfix all-font">
				<div class="col-lg-12 col-md-12 col-sm-12 clearfix ">
					<div class="col-lg-12 col-md-12 col-sm-12 clearfix all-top-title"><i class="icon iconfont icon-shengxiao"></i>实收统计:<b><span class="_real_income">0</span>元</b></div>
					<div class="col-lg-12 col-md-12 col-sm-12 clearfix all-bottom">
						<div class="col-lg-4 col-md-4 col-sm-4 clearfix">
							<p><i class="icon iconfont icon-weixin1" style="color:#02dc6e;"></i>微信</p>
							<p class="all-bottom-num"><span class="_real_income_wx">0</span>元</p>
						</div>
						<div class="col-lg-4 col-md-4 col-sm-4 clearfix">
							<p><i class="icon iconfont icon-zhifubao" style="color:#00a9ec;"></i>支付宝</p>
							<p class="all-bottom-num"><span class="_real_income_zfb">0</span>元</p>
						</div>
						<div class="col-lg-4 col-md-4 col-sm-4 clearfix">
							<p><i class="icon iconfont icon-qian2" style="color:#ff9000;"></i>充值</p>
							<p class="all-bottom-num"><span class="_real_income_cz">0</span>元</p>
						</div>
						<%--	隐藏退款费用 2020/03/13 Dz
                        <div class="col-lg-3 col-md-3 col-sm-3 clearfix">
                            <p><i class="icon iconfont icon-tuikuan" style="color:#ff4d4d;"></i>退款金额</p>
                            <p class="all-bottom-num"><span class="_real_refund">0</span>元</p>
                        </div>
						--%>
					</div>
				</div>
			</div>

			<div class="col-lg-6 col-md-6 col-sm-6 clearfix all-font">
				<div class="col-lg-12 col-md-12 col-sm-12 clearfix ">
					<div class="col-lg-12 col-md-12 col-sm-12 clearfix all-top-title"><i class="icon iconfont icon-shengxiao"></i>订单费用:<b><span class="_order_income">0</span>元</b></div>
					<div class="col-lg-12 col-md-12 col-sm-12 clearfix all-bottom">
                        <div class="col-lg-4 col-md-4 col-sm-4 clearfix">
                            <p><i class="icon iconfont icon-weixin1" style="color:#02dc6e;"></i>微信</p>
                            <p class="all-bottom-num"><span class="_real_income_wx">0</span>元</p>
                        </div>
                        <div class="col-lg-4 col-md-4 col-sm-4 clearfix">
                            <p><i class="icon iconfont icon-zhifubao" style="color:#00a9ec;"></i>支付宝</p>
                            <p class="all-bottom-num"><span class="_real_income_zfb">0</span>元</p>
                        </div>
                        <div class="col-lg-4 col-md-4 col-sm-4 clearfix">
                            <p><i class="icon iconfont icon-qian2" style="color:#ff9000;"></i>余额支付</p>
                            <p class="all-bottom-num"><span class="_order_income_ye">0</span>元</p>
                        </div>
						<%--	隐藏退款费用 2020/03/13 Dz
                        <div class="col-lg-3 col-md-3 col-sm-3 clearfix">
                            <p><i class="icon iconfont icon-tuikuan" style="color:#ff4d4d;"></i>退款金额</p>
                            <p class="all-bottom-num"><span class="_order_refund">0</span>元</p>
                        </div>
						--%>
					</div>
				</div>
			</div>
			
		</div>

		<div class="cs-schedule-mao clearfix">
			<div class="col-lg-6 col-md-6 clearfix" style="padding:10px 5px 5px 5px; border-right:1px solid #eee;" >
				<div id="progress4" style="height:250px;width:100%;"></div>
			</div>

			<div class="col-lg-6 col-md-6 clearfix" style="padding:10px 5px 5px 5px; border-right:1px solid #eee;" >
				<div id="progress6" style="height:250px;width:100%;"></div>
			</div>
		</div>
		<div class="cs-schedule-mao clearfix" style="position:relative;">
			<div class="col-lg-12 col-md-12 clearfix" style="padding:10px 5px 5px 5px; border-right:1px solid #eee;" >
				<div id="progress5" style="height:230px;width:100%;"></div>
			</div>
		</div>
		<div class="cs-schedule-mao clearfix" style="position:relative;">
			<div class="col-lg-12 col-md-12 clearfix" style="padding:10px 5px 5px 5px; border-right:1px solid #eee;" >
				<div id="progress2" style="height:230px;width:100%;"></div>
			</div>
		</div>
	</div>
</div>

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
            url: "${webRoot}/orderStatistic/getRealIncomeData",
            data: {"yyyy":year,"mm":month,"season":season,"start":start,"end":end},
            dataType: "json",
            success: function(data){
                if(data && data.success){
                    var incomeTitle = "收入趋势";
                    var czTitle = "充值趋势";
                    // switch ($("#province").val()) {
                    // 	case "month":
                    // 		var year0 = $(".check-date:eq(1) [name='year']").val();
                    // 		var month0 = $(".check-date:eq(1) [name='month']").val();
                    // 		if (parseInt(month0)<10){
                    // 			month0 = "0"+month0;
                    // 		}
                    // 		incomeTitle += "("+year0+"年"+month0+"月)";
                    // 		czTitle += "("+year0+"年"+month0+"月)";
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
                    // 		czTitle += "("+year0+"年 第"+season0+"季度)";
                    // 		break;
                    //
                    // 	case "year":
                    // 		var year0 = $(".check-date:eq(3) [name='year']").val();
                    // 		incomeTitle += "("+year0+"年)";
                    // 		czTitle += "("+year0+"年)";
                    // 		break;
                    //
                    // 	case "diy":
                    // 		var start0 = $(".check-date:eq(4) [name='start']").val();
                    // 		var end0 = $(".check-date:eq(4) [name='end']").val();
                    // 		incomeTitle += "("+start0.replace(/-/g,"/")+"-"+end0.replace(/-/g,"/")+")";
                    // 		czTitle += "("+start0.replace(/-/g,"/")+"-"+end0.replace(/-/g,"/")+")";
                    // 		break;
                    // }

                    $("._real_income").text(data.obj.real_income.toFixed(2));
                    $("._real_income_wx").text(data.obj.real_income_wx.toFixed(2));
                    $("._real_income_zfb").text(data.obj.real_income_zfb.toFixed(2));
                    $("._real_income_cz").text(data.obj.real_income_cz.toFixed(2));

                    $("._order_income").text(data.obj.order_income.toFixed(2));
                    $("._order_income_ye").text(data.obj.order_income_ye.toFixed(2));

                    // 隐藏退款费用 2020/03/13
                    // $("._real_refund").text(data.obj.real_refund.toFixed(2));
                    // $("._order_refund").text(data.obj.order_refund.toFixed(2));

                    //支付方式
                    myChart1.setOption({
                        series: {
                            data: [
                                {value: data.obj.pay_wx, name:'微信'},
                                {value: data.obj.pay_zfb, name:'支付宝'},
                                {value: data.obj.pay_ye, name:'余额'}
                            ]
                        }
                    });

                    //充值趋势
                    myChart2.setOption({
                        title: {
                            text: czTitle
                        },
                        xAxis: {
                            data: data.obj.dates
                        },
                        series: [{
                            data: data.obj.real_incomes_cz
                        },{
                            data: data.obj.cz_users_num
                        }]
                    });

                    //收入趋势
                    myChart3.setOption({
                        title: {
                            text: incomeTitle
                        },
                        xAxis: {
                            data: data.obj.dates
                        },
                        series: [{
                            data: data.obj.real_incomes
                        },{
                            data: data.obj.real_incomes_wx
                        },{
                            data: data.obj.real_incomes_zfb
                        },{
                            data: data.obj.real_incomes_cz
                        }]
                    });

                    //订单费用
                    myChart6.setOption({
                        series: {
                            data: [
                                {value: (data.obj.fee_check).toFixed(2), name:'检测费'},
                                {value: (data.obj.fee_report).toFixed(2), name:'报告费'},
                                {value: (data.obj.fee_print).toFixed(2), name:'重打费'},
                                {value: (data.obj.fee_take_sampling).toFixed(2), name:'上门服务费'}
                            ]
                        }
                    });

                }
            }
        });
    });


	//支付方式
	var myChart1 = echarts.init(document.getElementById('progress4'),"shine");
	var option1 = {
		color: ['#02dc6e', '#00a9ec', '#ff9000', '#0F347B', '#7F6AAD', '#009D85'],
		title: {
			text: '支付方式',
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
			data:['微信','支付宝','余额'],
			show:true
		},
		series: [
			{
				name:'支付方式',
				type:'pie',
				radius: ['40%', '60%'],
				label: {
					normal: {
						formatter: '{b}\n{d}%'
					}
				},
				data:[
					{value:0, name:'微信'},
					{value:0, name:'支付宝'},
					{value:0, name:'余额'}
				]
			}
		]
	};
	myChart1.setOption(option1);

	//充值趋势
	var myChart2 = echarts.init(document.getElementById('progress2'),"shine");
	var option2 = {
		color: [ '#476fd4'],
		title: {
			text: '充值趋势',
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
			data: ['充值收入','用户数量']
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
			show: true
		}
	},
	series: [
		{
			name:'充值收入',
			type:'line',
			stack: '总量1',
			label: {
				normal: {
					show: true,
					position: 'top'
				}
			},
			data:[]
			},
			{
				name:'用户数量',
				type:'line',
				stack: '总量2',
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

	//收入趋势
	var myChart3 = echarts.init(document.getElementById('progress5'),"shine");
	var option3 = {
		title: {
			text: '收入趋势',
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
			data: ['总收入','微信','支付宝','充值']
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
			data: [],
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
				name: '总收入',
				type: 'line',
				stack: '总数',
				label: {
					normal: {
						// textStyle: {
						// 	color: 'rgba(0,0,0,0)'
						// },
						show: true,
						position: 'top'
						// formatter: '{b}'
					}
				},
				// itemStyle: {
				// 	show: true,
				// 	normal: {
				// 		color: 'rgba(0,0,0,0)',
				// 		borderWidth: 0,
				// 		borderColor: 'rgba(0,0,0,0)'
				// 	}
				// },
				data:[]
			},
			{
				name:'微信',
				type:'line',
				stack: '微信',
				label: {
					normal: {
						show: true,
						position: 'top'
					}
				},
				data:[]
			},{
				name:'支付宝',
				type:'line',
				stack: '支付宝',
				label: {
					normal: {
						show: true,
						position: 'top'
					}
				},
				data:[]
			},{
				name:'充值',
				type:'line',
				stack: '充值',
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
	myChart3.setOption(option3);

	//订单费用
	var myChart6 = echarts.init(document.getElementById('progress6'),"shine");
	var option6 = {
		color: ['#fe7576', '#476fd4', '#0098d9', '#0F347B', '#7F6AAD', '#009D85'],
		title: {
			text: '订单费用',
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
			data:['检测费','报告费','重打费','上门服务费'],
			show:true
		},
		series: [
			{
				name:'订单费用',
				type:'pie',
				radius: ['40%', '60%'],
				label: {
					normal: {
						formatter: '{b}\n{d}%'
					}
				},
				data:[
					{value:0, name:'检测费'},
					{value:0, name:'报告费'},
					{value:0, name:'重打费'},
					{value:0, name:'上门服务费'}
				]
			}
		]
	};
	myChart6.setOption(option6);
</script>
</body>
</html>
