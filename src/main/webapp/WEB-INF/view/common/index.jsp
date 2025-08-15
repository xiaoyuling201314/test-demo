<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/common/resource.jsp"%>
<html>
<head>
	<title>${systemName}</title>
	<style type="text/css">
		.cs-list-text {
			display: inline-block;
			width: 60px;
			text-align: right;
		}

		.cs-li-info3 p {
			height: 110px;
			line-height: 110px;
			text-align: center;
		}

		.cs-navbar-header {
			padding: 10px 10px 0 10px;
		}

		.cs-li-bg,
		.cs-li-bg2 {
			height: 260px;
		}

		.cs-home-lp2 .cs-li-big-font {
			font-size: 20px;
		}
		.text-center{
			padding: 0;
		}
		.icon-top .iconfont{
			font-size: 30px;
		}
		.count-box{
			padding:10px;
		}
	</style>
</head>
<body>
<div class="cs-home-list clearfix">
	<!-- <div class="col-md-4 cs-home-lp" style="padding-bottom: 0px;">
    <div class="col-md-12 cs-li-bg">
        <div class="cs-li-ti">
            <span class="cs-li-icon"><span class="cs-icon-span"><i class="icon iconfont icon-project"></i></span></span> <span>当前项目</span>
        </div>
        <div class="cs-li-content">
            <div class="col-md-7 cs-li-info">
                <p>
                    <span class="cs-list-style cs-list-style-red"></span> <span class="cs-list-text">总任务：</span> <i
                        class="cs-li-big-font" id="aTasksNum"></i> 个
                </p>
                <p>
                    <span class="cs-list-style cs-list-style-yellow"></span> <span class="cs-list-text">执行中：</span> <i
                        class="cs-li-big-font cs-red-text" id="eTasksNum"></i> 个
                </p>
                <p>
                    <span class="cs-list-style cs-list-style-blue"></span> <span class="cs-list-text">已完成：</span> <i
                        class="cs-li-big-font" id="fTasksNum"></i> 个
                </p>
            </div>
            <div id="third" class="col-md-5"></div>
        </div>
    </div>
</div> -->
	<div class="col-md-4 col-sm-4  col-xs-4 cs-home-lp">
		<div class="col-md-12 col-sm-12  col-xs-12 cs-li-bg">
			<div class="cs-li-ti">
						<span class="cs-li-icon"><span class="cs-icon-span"><i
								class="icon iconfont icon-project"></i></span></span>
				<span>汇总统计</span>
			</div>

			<div class="cs-li-content">
				<div class="col-md-12 col-sm-12  col-xs-12 cs-li-info3">
					<div class="col-md-6 col-sm-6  col-xs-6 count-box cs-border-left cs-border-bottom">
						<div class="icon-top text-center">
							<span class="text-primary icon iconfont icon-tongjibaobiao"
								  style="color:#006fce;"></span>
						</div>
						<div class="text-center">
							<span class="cs-list-text2">检测总数</span>
						</div>
						<div class="text-center">
							<i class="cs-li-big-font jczs">0</i> 个
						</div>
					</div>

					<div class="col-md-6 col-sm-6  col-xs-6 count-box cs-border-bottom">
						<div class="icon-top text-center"><span class="text-success icon iconfont icon-renwu1" style="color:#d4a800;"></span></div>
						<div class="text-center"><span class="cs-list-text2">抽样单数</span></div>
						<div class="text-center"><i class="cs-li-big-font samplingTotal">0</i> 个</div>
					</div>
					<div class="col-md-6 col-sm-6  col-xs-6 count-box cs-border-left">
						<div class="icon-top text-center"><span class="text-danger icon iconfont icon-buhegeshu" style="color:#d63835;"></span></div>
						<div class="text-center"><span class="cs-list-text2">不 合 格</span></div>
						<div class="text-center"><i class="cs-li-big-font jcbhg">0</i> 个</div>
					</div>
					<div class="col-md-6 col-sm-6  col-xs-6 count-box">
						<div class="icon-top text-center"><span class="text-success icon iconfont icon-baifenbi"></span></div>
						<div class="text-center"><span class="cs-list-text2">合 格 率</span></div>
						<div class="text-center"><i class="cs-li-big-font hgl">0</i> %</div>
					</div>
					<div class="col-md-6 col-sm-6  col-xs-6">

					</div>
				</div>
			</div>
		</div>
	</div>

	<div class="col-md-4 col-sm-4  col-xs-4 cs-home-lp cs-home-lp2" style="padding: 10px 0;">
		<div class="col-md-12 col-sm-12  col-xs-12 cs-li-bg">
			<div class="cs-li-ti">
						<span class="cs-li-icon"><span class="cs-icon-span"><i
								class="icon iconfont icon-buhege"></i></span></span> <span>当月不合格处理</span>
			</div>

			<div class="cs-li-content">
				<div id="main" class="cs-chart-he" style="height:220px"></div>
			</div>
		</div>
	</div>
	<div class="col-md-4 col-sm-4  col-xs-4 cs-home-lp cs-home-lp2">
		<div class="col-md-12 col-sm-12  col-xs-12 cs-li-bg">
			<div class="cs-li-ti">
						<span class="cs-li-icon"><span class="cs-icon-span"><i
								class="icon iconfont icon-check"></i></span></span> <span>当月检测数据</span>
			</div>
			<div class="cs-li-content">
				<div class="col-md-7 col-sm-7  col-xs-7 cs-li-info" style="padding-top:42px;">
					<p>
						<span class="cs-list-style cs-list-style-yellow"></span><span
							class="cs-list-text">总数：</span><i class="cs-li-big-font" id="aRecording"></i> 个
					</p>
					<p>
						<span class="cs-list-style cs-list-style-blue"></span><span
							class="cs-list-text">合格：</span><i class="cs-li-big-font" id="qRecording"></i> 个
					</p>
					<p>
						<span class="cs-list-style cs-list-style-red"></span><span
							class="cs-list-text">不合格：</span><i class="cs-li-big-font cs-red-text"
															   id="uRecording"></i> 个
					</p>
				</div>
				<div id="second" class="col-md-5 col-sm-5  col-xs-5" style="height: 210px"></div>
			</div>
		</div>
	</div>
	<!-- <div class="col-md-4 cs-home-lp" style="padding-top: 0;">
    <div class="col-md-12 cs-li-bg2">
        <div class="cs-li-ti">
            <span class="cs-li-icon"><span class="cs-icon-span"><i class="icon iconfont icon-bell"></i></span></span> <span>消息提醒</span>
            <a class="cs-check-all cs-float-r" href="javascript:;">查看全部</a>
        </div>
        <div class="cs-li-content2">
            <ul id="list">

            </ul>
        </div>
    </div>
</div> -->
	<div class="col-md-12 col-sm-12  col-xs-12 cs-home-lp cs-home-lp2" style=" padding-top: 0;height:390px;">
		<div class="col-md-12 col-sm-12  col-xs-12 cs-li-bg2" style="height:390px;">
			<div class="cs-li-ti">
						<span class="cs-li-icon"><span class="cs-icon-span"><i
								class="icon iconfont icon-jichushujuguanli"></i></span></span>
				<span>检测量统计</span>
			</div>

			<div class="cs-li-content">
				<div id="sixth" class="cs-tongjizouxiang"></div>
				<div class="switch-btn left-btn is-flex" onclick="getRecordingNum(-1);"><i class="iconfont icon-zuo text-primary"></i></div>
				<div class="switch-btn right-btn is-flex" onclick="getRecordingNum(1);"><i class="iconfont icon-you text-primary"></i></div>
			</div>
		</div>
	</div>
</div>
<div class="cs-footer">
	<c:choose>
		<c:when test="${!empty systemCopyright}">
			<p>${systemCopyright}</p>
		</c:when>
		<c:otherwise>
			<p>${copyright}</p>
		</c:otherwise>
	</c:choose>
</div>

<!-- JavaScript -->
<script type="text/javascript">
	var url;
	var code;

	$(function() {
		$.ajax({
			type: "POST",
			url: "${webRoot}/message/selectIndex.do",
			dataType: "json",
			success: function(data) {
				var menus = JSON.parse('${menusStrs}');
				var code1, code2;
				//遍历登录的用户是否有消息提醒的已接收权限和任务管理的接收任务权限
				for (var i = 0; i < menus.length; i++) {
					if (menus[i].id == '1' || menus[i].id == '200') {
						var secMenus = menus[i].subMenu;
						for (var ii = 0; ii < secMenus.length; ii++) {
							if (secMenus[ii].id == '5' || secMenus[ii].id == '201') {
								var thrMenus = secMenus[ii].subMenu;
								for (var iii = 0; iii < thrMenus.length; iii++) {
									if (thrMenus[iii].id == '204') {
										code1 = "'200', '201','204',";
									} else if (thrMenus[iii].id == '4') {
										code2 = "'1','5','4',";
									}
								}
							}
						}
					}
				}

				if (data && data.success) {
					$.each(data.obj, function(k, v) {
						var html = ""; //new Date(v.sendtime).format("yyyy-MM-dd");
						var time = new Date(Date.parse(v.sendtime.replace(/-/g, "/")))
								.format("yyyy-MM-dd");
						var imge = v.flag == 1 ? 'misson' : 'warning';
						url = v.flag == 1 ? 'taskDetail/viewReceiveTask?id=' :
								'message/tomessagedetail?id=';
						code = v.flag == 1 ? code1 : code2;
						var test = code + "'${webRoot}/" + url + v.id + "'";
						if (v.flag == 1 && code1 != undefined) {
							html = "<li class='cs-divider'></li>" +
									"<li class='cs-message'>" +
									"<a class='cs-a-pad' onclick=\"parent.setIframeUrl(" + test +
									")\">" + "<img class='cs-fl' src='${webRoot}/img/" + imge +
									".png' alt=''/>" + "<span class='cs-mess cs-float-l'>" + v
											.title + "</span>" +
									"<span class='cs-timer cs-float-r cs-ar'>" + time +
									"</span>" + "</a>" + "</li>";
						} else if (v.flag != 1 && code2 != undefined) {
							html = "<li class='cs-divider'></li>" +
									"<li class='cs-message'>" +
									"<a class='cs-a-pad' onclick=\"parent.setIframeUrl(" + test +
									")\">" + "<img class='cs-fl' src='${webRoot}/img/" + imge +
									".png' alt=''/>" + "<span class='cs-mess cs-float-l'>" + v
											.title + "</span>" +
									"<span class='cs-timer cs-float-r cs-ar'>" + time +
									"</span>" + "</a>" + "</li>";
						}
						$("#list").append(html);
					});

				} else {
					console.log("查询失败");
				}
			},
			error: function() {
				console.log("查询失败");
			}
		});
	})

	//不合格处理
	$.ajax({
		type: "POST",
		url: "${webRoot}/system/getProcessing.do",
		dataType: "json",
		success: function(data) {
			if (data && data.success) {
				// 基于准备好的dom，初始化echarts实例
				var myChart = echarts.init(document.getElementById('main'), "shine");
				// 指定图表的配置项和数据
				option = {
					color: ['#3398DB'],
					tooltip: {
						trigger: 'axis',
						axisPointer: { // 坐标轴指示器，坐标轴触发有效
							type: 'shadow' // 默认为直线，可选为：'line' | 'shadow'
						}
					},
					grid: {
						left: '5%',
						right: '5%',
						bottom: '8%',
						top: '8%',
						containLabel: true
					},
					xAxis: [{

						type: 'category',
						data: ['待处理', '处理中', '已处理'],
						axisTick: {
							alignWithLabel: true
						},
						splitLine: {
							show: true
						},
						axisLine: {
							lineStyle: {
								/* color: '#3259B8' */
							}
						}
					}],
					yAxis: [{
						type: 'value',
						axisLine: {
							lineStyle: {
								/* color: '#3259B8' */
							}
						}

					}],
					series: [{
						name: '检测数量',
						type: 'bar',
						barWidth: '60%',
						data: [data.obj.untreated, data.obj.processing, data.obj.processed]
					}],
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
				};

				// 使用刚指定的配置项和数据显示图表。
				myChart.setOption(option);

			} else {
				console.log("查询失败");
			}
		}
	});

	//当月检测数据
	$.ajax({
		type: "POST",
		url: "${webRoot}/system/getCheckRecording.do",
		dataType: "json",
		success: function(data) {
			if (data && data.success) {
				$("#aRecording").text(data.obj.aRecording);
				$("#qRecording").text(data.obj.qRecording);
				$("#uRecording").text(data.obj.uRecording);

				// 基于准备好的dom，初始化echarts实例
				var myChart = echarts.init(document.getElementById('second'), "shine");

				option = {
					tooltip: {
						trigger: 'item',
						formatter: "{a} <br/>{b}: {c} ({d}%)"
					},
					legend: {
						show: false,
						orient: 'vertical',
						x: 'right',
						data: ['1月', '2月', '3月']
					},
					series: [{
						name: '检测比例',
						type: 'pie',
						radius: ['50%', '70%'],
						avoidLabelOverlap: false,
						label: {
							normal: {
								show: false,
								position: 'center'
							},
							emphasis: {
								show: true,
								textStyle: {
									fontSize: '18',
									fontWeight: 'bold'
								}
							}
						},
						labelLine: {
							normal: {
								show: false
							},
							emphasis: {
								show: false
							}
						},
						data: [{
							name: '合格',
							value: data.obj.qRecording
						}, {
							name: '不合格',
							value: data.obj.uRecording
						}],
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
					}]
				};
				// 使用刚指定的配置项和数据显示图表。
				myChart.setOption(option);
			} else {
				console.log("查询失败");
			}
		}
	});

	//任务数量
	/* $.ajax({
        type : "POST",
        url : "${webRoot}/system/getTasksNum.do",
				dataType : "json",
				success : function(data) {
					if (data && data.success) {
						$("#aTasksNum").text(data.obj.aTasksNum);
						$("#fTasksNum").text(data.obj.fTasksNum);
						$("#eTasksNum").text(data.obj.eTasksNum);
						// 基于准备好的dom，初始化echarts实例
						var myChart = echarts.init(document.getElementById('third'), "shine");
						option = {
							title : {
								text : '',
								subtext : '',
								x : ''
							},
							tooltip : {
								trigger : 'item',
								formatter : "{a} <br/>{b} : {c} ({d}%)"
							},
							legend : {
								shadowBlur : {
									shadowColor : 'rgba(0, 0, 0, 0.5)',
									shadowBlur : 10
								}
							},
							series : [ {
								type : 'pie',
								name : '我的任务',
								label : {
									normal : {
										show : false,
										position : 'outside'
									},
									emphasis : {
										show : false
									}
								},
								center : [ '50%', '50%' ],
								radius : "70%",
								data : [ {
									name : '已完成',
									value : data.obj.fTasksNum
								}, {
									name : '执行中',
									value : data.obj.eTasksNum
								} ]
							} ],
							itemStyle : {
								normal : {
									shadowBlur : 5,
									shadowOffsetX : 0,
									shadowOffsetY : -1,
									shadowColor : 'rgba(0, 0, 0, 0.4)'
								},
								emphasis : {
									shadowBlur : 10,
									shadowOffsetX : 0,
									shadowColor : 'rgba(0, 0, 0, 0.5)'
								}
							}
						};

						// 使用刚指定的配置项和数据显示图表。
						myChart.setOption(option);

					} else {
						console.log("查询失败");
					}
				}
			}); */

	//汇总统计
	$.ajax({
		type: "POST",
		url: "${webRoot}/system/getProjectMsg.do",
		dataType: "json",
		success: function(data) {
			if (data && data.success) {
				$(".samplingTotal").text(data.obj.samplingTotal);
				$(".jczs").text(data.obj.jczs);
				$(".jcbhg").text(data.obj.jcbhg);
				$(".hgl").text(data.obj.hgl);

			} else {
				console.log("查询失败");
			}
		}
	});

	var end = new Date();
	getRecordingNum();
	function getRecordingNum(j){
		if (j == 1) {
			end = end.DateAdd("d", 30);
			if (end.getTime() > new Date().getTime()) {
				end = new Date();
			}
		} else if (j == -1) {
			end = end.DateAdd("d", -30);
		}

		//检测量统计
		$.ajax({
			type: "POST",
			url: "${webRoot}/system/getRecordingNum.do",
			data: {"start": end.DateAdd("d", -30).format("yyyy-MM-dd"), "end": end.format("yyyy-MM-dd")},
			dataType: "json",
			success: function(data) {
				if (data && data.success) {
					// 基于准备好的dom，初始化echarts实例
					var days = [];
					var qualified = [];
					var unqualified = [];
					if (data.obj.quantity) {
						//var quantity = JSON.parse(data.obj.quantity);
						var quantity = data.obj.quantity;
						for (var i = 0; i < quantity.length; i++) {
							days[i] = quantity[i].days;
							qualified[i] = quantity[i].qualified;
							unqualified[i] = quantity[i].unqualified;
						}
					}
					var myChart = echarts.init(document.getElementById('sixth'), "shine");
					option = {
						// title: {
						//     text: '堆叠区域图'
						// },
						tooltip: {
							trigger: 'axis',
							axisPointer: {
								type: 'cross',
								label: {
									backgroundColor: '#6a7985'
								}
							}
						},
						legend: {
							data: ['合格', '不合格'],
							orient:'horizontal',
							x:'center',
							top:'10px'
						},
						grid: {
							left: '6%',
							right: '8%',
							bottom: '0%',
							top: '12%',
							containLabel: true
						},
						xAxis: [{
							type: 'category',
							boundaryGap: false,
							data: days,
							splitLine: {
								show: true
							},
							axisLabel: {
								//x轴文字的配置
								show: true,
								// interval: 0,//使x轴文字显示全
								showMinLabel: true,
								showMaxLabel: true
							},
							axisLine: {
								lineStyle: {
									/* color: '#3259B8' */
								},

							}
						}],
						yAxis: [{
							type: 'value',
							axisLine: {
								lineStyle: {
									/* color:'#3259B8' */
								}
							}
						}],
						series: [{
							name: '合格',
							type: 'line',
							stack: '总量1',
							areaStyle: {
								normal: {
									color: new echarts.graphic.LinearGradient(0, 0, 0, 0)
								}
							},
							data: qualified
						}, {
							name: '不合格',
							type: 'line',
							stack: '总量2',
							areaStyle: {
								normal: {
									color: new echarts.graphic.LinearGradient(0, 0, 0, 0)
								}
							},
							data: unqualified
						}, ]
					};
					myChart.setOption(option);

				} else {
					console.log("查询失败");
				}
			}
		});
	}
</script>
</body>
</html>
