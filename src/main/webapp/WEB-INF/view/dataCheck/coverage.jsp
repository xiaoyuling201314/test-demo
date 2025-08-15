<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/common/resource.jsp"%>
<html>
<head>
<title>快检服务云平台</title>
<style type="text/css">
.textbox-addon {
	position: absolute;
	top: 0;
	width: 30px;
	text-align: center;
	background: #ddd;
	cursor: pointer;
	display: block;
}

.combo-arrow {
	width: 30px;
	background: url(${webRoot}/img/tab_arrow.png) no-repeat center center;
}

.showDiv {
	height: 30px;
	width: 30px;
	text-align: center;
	z-index: 1000;
	background: rgba(0, 0, 0, 0.5);
	width: 100%;
	height: 100%;
	position: relative;
}

.showDiv p {
	cursor: pointer;
}

.cs-tab-icon ul {
	border-right: 1px solid #ddd;
}

.cs-tab-icon ul li {
	float: left;
	border-left: 1px solid #ddd;
}

.cs-tab-icon ul li a {
	display: inline-block;
	margin-top: -1px;
	padding: 0 20px;
	line-height: 41px;
	color: #999;
}

.cs-tab-icon ul li a:hover, .cs-tab-icon ul li a.active {
	color: #05af50;
}

.cs-tab3 {
	padding: 6px 0 0 10px;
	height: 40px;
	line-height: 40px;
}

.cs-tab3 li {
	float: left;
	height: 30px;
	color: #666;
	text-align: center;
	line-height: 34px;
	cursor: pointer;
	background: #fff;
	width: 110px;
}

.cs-tab3 li.cs-cur {
	height: 34px;
	border: 1px solid #ddd;
	border-bottom: none;
	color: #fff;
	background: #1dcc6a;
	border-radius: 4px 4px 0 0;
}

.cs-tab-box3 {
	display: none;
}

.cs-tab-box3.cs-on {
	display: block;
}
</style>
</head>
<body>
	<div class="cs-col-lg clearfix">
		<!-- tab栏 -->
		<ol class="cs-breadcrumb">
			<li class="cs-fl"><img src="${webRoot}/img/set.png" alt="" /> <a href="javascript:">覆盖率</a></li>
			<li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
			<li class="cs-b-active cs-fl">市场覆盖</li>
		</ol>
		<span class="check-date"> <span class="cs-name">时间:</span> <span class="cs-in-style cs-time-se cs-time-se">
				<input id="start" style="width: 110px;" class="cs-time Validform_error" onclick="WdatePicker()" datatype="date"
				nullmsg="请选择任务起止时间" errormsg="请选择任务起止时间" value="${start}"> <span style="padding: 0 5px;">至</span> <input
				id="end" style="width: 110px;" class="cs-time Validform_error" onclick="WdatePicker()" datatype="date"
				nullmsg="请选择任务起止时间" errormsg="请选择任务起止时间" value="${end}">
		</span> <span> <a href="javascript:" class="cs-menu-btn" style="margin: 4px 0 0 10px;" onclick="query()"> <i
					class="icon iconfont icon-chakan"></i>查询
			</a>
		</span>
		</span>

		<div class="cs-tab-icon clearfix cs-fr">
			<ul>
				<li><a class="icon iconfont icon-tubiao active"></a></li>
				<li><a class="icon iconfont icon-liebiao"></a></li>
			</ul>
		</div>
	</div>

	<!-- 列表 -->
	<div class="cs-col-lg-table">
		<div class="cs-tab-box cs-on">
			<div style="border: 1px solid #ddd; padding: 10px 0; margin-bottom: 10px; border-left: 0; border-right: 0;">
				<div id="third" class="cs-echart"
					style="width: 35%; height: 320px; display: inline-block; border-right: 1px solid #ddd; border-bottom: 1px solid #ddd;"></div>
				<div id="first" class="cs-echart"
					style="width: 63%; height: 320px; display: inline-block; border-bottom: 1px solid #ddd;"></div>
				<div id="ford" class="cs-echart"
					style="width: 35%; height: 320px; display: inline-block; border-right: 1px solid #ddd;"></div>
				<div id="second" class="cs-echart" style="width: 63%; height: 320px; display: inline-block;"></div>
			</div>
		</div>
		<div class="cs-tab-box">
			<!-- 抽样覆盖 -->
			<table class="cs-table cs-table-hover table-striped cs-tablesorter">
				<thead>
					<tr>
						<th width="50px">
							<div class="cs-num-cod">
								<input name="rowCheckBox" type="checkbox" value="9" onchange="datagridUtil.changeBox()">
							</div>
						</th>
						<th class="cs-header">市场</th>
						<th class="cs-header">档口数</th>
						<th class="cs-header">未检测</th>
						<th class="cs-header">档口覆盖率</th>
						<th class="cs-header">检测食品</th>
						<th class="cs-header">未检测</th>
						<th class="cs-header">食品覆盖率</th>
						<!-- <th class="cs-header">操作</th> -->
					</tr>
				</thead>
				<tbody id="tbody">
				</tbody>
			</table>
		</div>
	</div>
	<div class="modal fade intro2" id="addModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
		<div class="modal-dialog cs-lg-width" role="document">
			<div class="modal-content ">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">未抽检情况</h4>
				</div>
				<div class="modal-body cs-lg-height">
					<!-- 主题内容 -->
					<div class="cs-tabcontent">
						<div class="cs-content2">
								<input type="hidden" name="id"> <input type="hidden" name="foodCode">

								<div style="clear: both; height: 40px;">
									<ul class="cs-tab3 clearfix cs-fl">
										<li class="cs-cur" data-tabtitleno="1">档口详情</li>
										<li data-tabtitleno="2">食品详情</li>
									</ul>
								</div>
								<div class="cs-tab-box3 cs-on">

									<table class="cs-table cs-table-hover table-striped cs-tablesorter">
										<thead>
											<tr>
												<th width="50px">
													<div class="cs-num-cod">
														<!-- <input name="rowCheckBox" type="checkbox" value="9" onchange="datagridUtil.changeBox()"> -->
													</div>
												</th>
												<th class="cs-header">档口编号</th>
												<th class="cs-header">档口名称</th>
												<th class="cs-header">状态</th>
											</tr>
										</thead>
										<tbody id="uncheckReg">
										</tbody>
									</table>
								</div>

								<div class="cs-tab-box3">
									<table class="cs-table cs-table-hover table-striped cs-tablesorter">
										<thead>
											<tr>
												<th width="50px">
													<div class="cs-num-cod">
														<!-- <input name="rowCheckBox" type="checkbox" value="9" onchange="datagridUtil.changeBox()"> -->
													</div>
												</th>
												<th class="cs-header">检测食品</th>
												<th class="cs-header">状态</th>
											</tr>
										</thead>
										<tbody id="uncheckFoods">
										</tbody>
									</table>
								</div>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-success" id="btnSave">确定</button>
					<button type="button" class="btn btn-default" data-dismiss="modal" id="btnCancel">关闭</button>
				</div>
			</div>
		</div>
	</div>
	<!-- 内容主体 结束 -->

	<script type="text/javascript">
		$(document).ready(function() {
			$(".cs-tab3 li").click(function() {
				$(".cs-tab3 li").eq($(this).index()).addClass("cs-cur").siblings().removeClass('cs-cur');
				$(".cs-tab-box3").hide().eq($(this).index()).show();
			});
		});
	</script>
	<script type="text/javascript">
		var first = echarts.init(document.getElementById('first'), "shine");
		var second = echarts.init(document.getElementById('second'), "shine");
		var third = echarts.init(document.getElementById('third'), "shine");
		var four = echarts.init(document.getElementById('ford'), "shine");
		$(function() {
			query();
		});
		function query() {
			start = $("#start").val();
			end = $("#end").val();
			$.ajax({
				url : '${webRoot}/dataCheck/recording/coverageData',
				data : {
					type : 4,/* value:val, */
					start : start,
					end : end
				},
				dataType : 'json',
				success : function(data) {
					var ds1 = data.coverage; //各市场的检测样品数量、检测档口数量
					var ds2 = data.foodCount; //各市场检测样品的总数量
					var ds3 = data.busCount; //各市场时间段内拥有档口的数量
					var ds4 = data.foodCount2;//所有市场检测的样品总数
					var ds5 = data.foodCount3;//所有市场时间段内抽样的样品总数
					var fs = [];//检测样品数量数组
					var rs = [];//检测档口数量数组
					var ns = [];//检测市场名称数组

					var notCheckFs = []; //各市场未检测的样品数量
					var totalCheckFs = [];//各市场总共检测的样品数量

					var notCheckBus = []; // 各市场未检测的档口数量
					var totalCheckBus = []; //各市场拥有的档口数量

					var totalBus = 0; //总档口检测数
					var totalCkBus = 0;//总档口数
					for (var i = 0; i < ds1.length; i++) {
						var d = ds1[i];
						fs.push(d.foodCount);
						rs.push(d.regUserCount);
						ns.push(d.reg_name);
						totalBus += d.regUserCount;

						for (var j = 0; j < ds2.length; j++) {
							var d2 = ds2[j];
							if (d2.reg_id == d.id) {
								totalCheckFs.push(d2.foodCount);
								notCheckFs.push(d2.foodCount - d.foodCount)
							}
						}
						for (var k = 0; k < ds3.length; k++) {
							var d3 = ds3[k];
							if (d3.reg_id == d.id) {
								totalCkBus += d3.busCount;
								totalCheckBus.push(d3.busCount);
								notCheckBus.push(d3.busCount - d.regUserCount)
							}
						}
					}
					option1.xAxis[0].data = ns;
					option1.series[0].data = rs;
					option1.series[1].data = notCheckBus;
					option1.series[2].data = totalCheckBus;
					first.setOption(option1);

					option2.xAxis[0].data = ns;
					option2.series[0].data = fs;
					option2.series[1].data = notCheckFs;
					option2.series[2].data = totalCheckFs;
					second.setOption(option2);

					option3.series[0].data[0].value = totalBus;
					option3.series[0].data[1].value = totalCkBus - totalBus;
					third.setOption(option3);

					option4.series[0].data[0].value = ds5[0].foodCount;
					option4.series[0].data[1].value = Math.abs(ds5[0].foodCount - ds4[0].foodCount);
					four.setOption(option4);
					dealHtml(ds1, ds2, ds3, notCheckFs, notCheckBus);

				}
			});
		}
		function dealHtml(ds1, ds2, ds3, notCheckFs, notCheckBus) {
			var start = $("#start").val();
			var end = $("#end").val();
			$("#tbody").empty();
			var html = "";
			for (var i = 0; i < ds1.length; i++) {
				for (var j = 0; j < ds2.length; j++) {
					if (ds2[j].reg_id == ds1[i].id) {
						html += "<tr>";
						html += "<td width=\"50px\">";
						html += "<div class=\"cs-num-cod\">";
						html += "<input name=\"rowCheckBox\" type=\"checkbox\" value=\"9\" onchange=\"datagridUtil.changeBox()\"><span>" + (i + 1) + "</span>";
						html += "</div>";
						html += "</td>";
						html += '<td><a class="cs-link text-primary"  data-toggle="modal" data-target="#addModal" onclick="seeUncheckDetail('+ds1[i].id+',\''+start+'\',\''+end+'\')">' + ds1[i].reg_name + '</a></td>';//href=\"market-detail.html\"
						html += "<td>" + ds3[i].busCount + "</td>";
						html += "<td>" + notCheckBus[i] + "</td>";
						if (ds3[i].busCount == 0) {
							html += "<td>-</td>";
						} else {
							html += "<td>" + (ds1[i].regUserCount / ds3[i].busCount * 100).toFixed(2) + "%</td>";
						}
						html += "<td>" + ds1[i].foodCount + "</td>";
						html += "<td>" + notCheckFs[i] + "</td>";
						if (ds2[j].foodCount == 0) {
							html += "<td>-</td>";
						} else {
							html += "<td>" + (ds1[i].foodCount / ds2[j].foodCount * 100).toFixed(2) + "%</td>";
						}
						html += "</tr>";
					}
				}
			}
			$("#tbody").html(html);
		}
		
		function seeUncheckDetail(regId,start,end){
			$.ajax({
				url:'${webRoot}/dataCheck/recording/coverageDetail',
				data:{"regId":regId,"start":start,"end":end},
				success:function(data){
					$("#uncheckReg").empty();
					$("#uncheckFoods").empty();
					var html1 = "";
					for (var i = 0; i < data.bus.length; i++) {
						var reg = data.bus[i];
						html1+='<tr>';
						html1+='<td width="50px">';
						html1+='<div class="cs-num-cod">';
						html1+='<span>'+(i+1)+'</span>';
						html1+='</div>';
						html1+='</td>';
						html1+='<td>'+reg.opeShopCode+'</td>';
						html1+='<td>'+reg.opeShopName+'</td>';
						html1+='<td class="text-primary">未抽检</td>';
						html1+='</tr>';
					}
					$("#uncheckReg").html(html1);
					
					var html2 = '';
					for (var i = 0; i < data.foods.length; i++) {
						var f = data.foods[i];
						html2 += '<tr>';
						html2 += '<td width="50px">';
						html2 += '<div class="cs-num-cod">';
						html2 += '<span>'+(i+1)+'</span>';
						html2 += '</div>';
						html2 += '</td>';
						html2 += '<td>'+f.food_name+'</td>';
						html2 += '<td class="text-primary">未抽检</td>';
						html2 += '</tr>';
					}
					$("#uncheckFoods").html(html2);
					
					//$("#addModal").modal("show");
				}
			});
		}
		
		option1 = {
			title : {
				text : '档口覆盖率',
			// subtext: 'Monthly pass rate'
			},
			tooltip : {
				trigger : 'axis',
				axisPointer : { // 坐标轴指示器，坐标轴触发有效
					type : 'shadow' // 默认为直线，可选为：'line' | 'shadow'
				}
			},
			legend : {
				data : [ '已检测', '未检测' ]
			},
			grid : {
				left : '3%',
				right : '4%',
				bottom : '15%',
				containLabel : true
			},
			xAxis : [ {
				axisLabel : {
					interval : 0,
					rotate : 30,
					show : true,
					splitNumber : 15,
					textStyle : {
						fontSize : 12
					}
				},
				type : 'category',
				data : []
			} ],
			yAxis : [ {
				type : 'value'
			} ],
			series : [ {
				name : '已检测',
				type : 'bar',
				stack : '食品种类',
				data : []
			}, {
				name : '未检测',
				type : 'bar',
				stack : '食品种类',
				data : []
			}, {
				name : '合计总量',
				type : 'bar',
				stack : '食品种类',
				label : {
					normal : {
						offset : [ '50', '80' ],
						show : true,
						position : 'insideBottom',
						//formatter : '{c}',
						textStyle : {
							color : '#000'
						}
					}
				},
				itemStyle : {
					normal : {
						color : 'rgba(128, 128, 128, 0)'
					}
				},
				data : []
			} ]
		};

		option2 = {
			title : {
				text : '食品覆盖率',
			// subtext: 'Monthly pass rate'
			},
			tooltip : {
				trigger : 'axis',
				axisPointer : { // 坐标轴指示器，坐标轴触发有效
					type : 'shadow' // 默认为直线，可选为：'line' | 'shadow'
				}
			},
			legend : {
				data : [ '已检测', '未检测' ]
			},
			grid : {
				left : '3%',
				right : '4%',
				bottom : '15%',
				containLabel : true
			},
			xAxis : [ {
				type : 'category',
				axisLabel : {
					interval : 0,
					rotate : 30,
					show : true,
					splitNumber : 15,
					textStyle : {
						fontSize : 12
					}
				},
				data : []
			} ],
			yAxis : [ {
				type : 'value'
			} ],
			series : [ {
				name : '已检测',
				type : 'bar',
				stack : '覆盖情况',
				data : []
			}, {
				name : '未检测',
				type : 'bar',
				stack : '覆盖情况',
				data : []
			}, {
				name : '合计总量',
				type : 'bar',
				stack : '覆盖情况',
				label : {
					normal : {
						offset : [ '50', '80' ],
						show : true,
						position : 'insideBottom',
						formatter : '{c}',
						textStyle : {
							color : '#000'
						}
					}
				},
				itemStyle : {
					normal : {
						color : 'rgba(128, 128, 128, 0)'
					}
				},
				data : []
			} ]
		};

		option3 = {
			title : {
				text : '总档口覆盖率',
			},
			tooltip : {
				trigger : 'item',
				formatter : "{a} <br/>{b}: {c} ({d}%)"
			},
			legend : {
				orient : 'vertical',
				x : 'right',
				data : [ '已检测', '未检测' ]
			},
			series : [ {
				name : '总档口覆盖率',
				type : 'pie',
				radius : '50%',
				center : [ '40%', '55%' ],
				labelLine : {
					normal : {
						length : 20,
						length2 : 50
					}

				},
				label : {
					normal : {
						formatter : '{a|{d}%}\n{b|{b}}',
						borderWidth : 0,
						borderRadius : 4,
						padding : [ 0, -50 ],
						rich : {
							a : {
								fontSize : 16,
								lineHeight : 20
							},
							hr : {
								width : '100%',
								borderWidth : 0.5,
								height : 0
							},
							b : {
								fontSize : 16,
								lineHeight : 20
							}
						}
					}
				},
				data : [ {
					value : 0,
					name : '已检测'
				}, {
					value : 0,
					name : '未检测'
				}

				],
				itemStyle : {
					emphasis : {
						shadowBlur : 10,
						shadowOffsetX : 0,
						shadowColor : 'rgba(0, 0, 0, 0.5)'
					}
				}
			} ]

		};

		option4 = {
			title : {
				text : '总食品覆盖率',
			// subtext: 'Monthly pass rate'
			},
			tooltip : {
				trigger : 'item',
				formatter : "{a} <br/>{b}: {c} ({d}%)"
			},
			legend : {
				orient : 'vertical',
				x : 'right',
				data : [ '已检测', '未检测' ]
			},
			series : [ {
				name : '总食品覆盖率',
				type : 'pie',
				radius : '50%',
				center : [ '40%', '55%' ],
				labelLine : {
					normal : {
						length : 20,
						length2 : 50
					}

				},
				label : {
					normal : {
						formatter : '{a|{d}%}\n{b|{b}}',
						borderWidth : 0,
						borderRadius : 4,
						padding : [ 0, -50 ],
						rich : {
							a : {
								fontSize : 16,
								lineHeight : 20
							},
							hr : {
								width : '100%',
								borderWidth : 0.5,
								height : 0
							},
							b : {
								fontSize : 16,
								lineHeight : 20
							}
						}
					}
				},
				data : [ {
					value : 123,
					name : '已检测'
				}, {
					value : 13,
					name : '未检测'
				}

				],
				itemStyle : {
					emphasis : {
						shadowBlur : 10,
						shadowOffsetX : 0,
						shadowColor : 'rgba(0, 0, 0, 0.5)'
					}
				}
			} ]

		};

		$(document).ready(function() {
			$(".cs-tab-icon li").click(function() {
				$(".cs-tab-icon li").eq($(this).index()).children('a').addClass("active").parent('li').siblings().children('a').removeClass('active');
				$(".cs-tab-box").hide().eq($(this).index()).show();

			});
		});
	</script>
</body>
</html>
