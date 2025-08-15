<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/wx/wxResource.jsp"%>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="initial-scale=1, maximum-scale=1, user-scalable=no">
	<meta name="format-detection" content="telephone=no">
<%--	<link rel="stylesheet" href="${webRoot}/plug-in/swiperTab/css/swiper-3.2.7.min.css" />--%>
	<link rel="stylesheet" type="text/css" href="${webRoot}/css/iconfont/iconfont.css" />
	<link rel="stylesheet" type="text/css" href="${webRoot}/css/bootstrap.css">
	<link rel="stylesheet" type="text/css" href="${webRoot}/css/index.css">
</head>
<body>
	<section class="ui-container">
		<div class="checked-data clearfix is-flex">
			<div class="top-statis is-flex">
				<div class="statis-list is-flex text-center">
					<div class="statis-part1">
						<div class="first-statis">
							<i class="icon iconfont icon-baobiao"></i>
							<p>检测总数</p>
							<b>${zs}批次</b>
						</div>
					</div>
					<div class="statis-part1">
						<div class="second-statis">
							<i class="icon iconfont icon-dingdanwancheng"></i>
							<p>不合格</p>
							<b>${bhg}批次</b>
						</div>
					</div>
					<div class="statis-part1">
						<div class="third-statis">
							<i class="icon iconfont icon-dingdanquxiao"></i>
							<p>合格率</p>
							<b>${hgl}%</b>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="">
			<div class="charts-insert">
				<div class="cs-schedule-mao clearfix">
					<div class="clearfix">
						<div id="progress11" style="height:280px;width:100%;"></div>
					</div>
				</div>
			</div>
		</div>
	</section>
</body>

<script type="text/javascript" src="${webRoot}/plug-in/echarts/echarts.min.js"></script>
<script type="text/javascript" src="${webRoot}/plug-in/echarts/shine.js"></script>
<%--<script type="text/javascript" src="${webRoot}/plug-in/swiperTab/js/swiper-3.4.0.jquery.min.js"></script>--%>
<script type="text/javascript">
	var myChart11 = echarts.init(document.getElementById('progress11'), "shine");
	var option11 = {
		title: {
			text: '合格率',
			x: 'left',
			textStyle: {
				fontSize: 14,
				padding: 10, // 标题内边距，单位px，默认各方向内边距为5，
				itemGap: 0, //主副标题纵向间隔，单位px，默认为10，
				fontWeight: 'bolder',
				color: '#333' // 主标题文字颜色
			},
		},
		tooltip: {
			trigger: 'item',
			formatter: "{a} <br/>{b} : {c} ({d}%)"
		},
		legend: {
			orient: 'vertical',
			left: 'right',
			show: true,
			data: ['合格', '不合格']
		},
		series: [{
			name: '合格率',
			type: 'pie',
			center: ['50%', '50%'],
			radius: ['35%', '50%'],
			labelLine: {
				normal: {
					length: 20,
					length2: 0,
				}

			},
			label: {
				normal: {
					formatter: '{d}%',
				}
			},
			data: [
				{
					value: ${hg},
					name: '合格'
				},{
					value: ${bhg},
					name: '不合格'
				}
			],
			itemStyle: {
				normal: {
					shadowBlur: 5,
					shadowOffsetX: 0,
					shadowOffsetY: -1,
					shadowColor: 'rgba(0, 0, 0, 0.4)',
					color: function(params) {
						//首先定义一个数组
						var colorList = [
							'#4ea4ff', '#ff676e', '#00ca51', '#EE9201', '#29AAE3',
							'#665efe', '#0AAF9F', '#E89589'
						];
						return colorList[params.dataIndex]
					},
				},
				emphasis: {
					shadowBlur: 10,
					shadowOffsetX: 0,
					shadowColor: 'rgba(0, 0, 0, 0.5)'
				}
			}
		}]
	};
	myChart11.setOption(option11);
</script>
</html>
