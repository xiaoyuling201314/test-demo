<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/common/resource.jsp"%>
<html>
<head>
<title>快检服务云平台</title>
<style type="text/css">
	 .check-date{
      float:left;
    }
    .check-date select{
      margin-right:3px;
    }
    #province{
     margin-right:3px;
    }
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
<body class="easyui-layout">
	<div data-options="region:'north',border:false" style="width:100%; height:41px; border:none; overflow:hidden;">
		<div class="cs-col-lg clearfix" style="border-bottom:none;">
		<!-- 面包屑导航栏  开始-->
			<ol class="cs-breadcrumb">
				<li class="cs-fl">
					<img src="${webRoot}/img/set.png" alt="" />
					<a href="javascript:">项目监管</a>
				</li>
				<li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
				<li class="cs-b-active cs-fl">覆盖率</li>
			</ol>
			<span class="check-date" style=" margin: 4px 0 0 0;">
				<span class="cs-name">统计时间:</span>
					<span class="cs-in-style cs-time-se cs-time-se">
					<input id="yyyyMM"  type="text" style="width: 110px;" class="cs-time" onclick="WdatePicker({dateFmt:'yyyy-MM',minDate:'2017-11',maxDate:'%y-%M',isShowClear:false,isShowToday:false,isShowOK:false,readOnly:true,ychanged:bigbang,Mchanged:bigbang})" datatype="date" autocomplete="off">
					</span>
			</span>
			<div class="cs-tab-icon clearfix cs-fr">
				<ul>
					<li><a class="icon iconfont icon-tubiao active"></a></li>
					<li><a class="icon iconfont icon-liebiao"></a></li>
				</ul>
			</div>
		</div>
	</div>
	<c:if test="${!empty pProjects && fn:length(pProjects) gt 1}">
		<div data-options="region:'west',split:true,title:'项目名称'" style="padding: 0px; width: 210px;">
			<div class="stock_info">
				<ul id="type">
					<c:forEach items="${pProjects}" var="subMenu" varStatus="index">
						<li name="type" data-type="${subMenu.id}" onclick="btnSelectedReport(this)">
							<div class="title"><a href="javascript:" title="${subMenu.projectName}">
								<c:if test="${fn:length(subMenu.projectName)>14}">
									${fn:substring(subMenu.projectName, 0, 14)}...
								</c:if>
								<c:if test="${fn:length(subMenu.projectName)<=14}">
									${subMenu.projectName}
								</c:if>
							</a></div>
							<div class="arrow"><i class="icon iconfont icon-you"></i></div>
						</li>
					</c:forEach>
				</ul>
			</div>
		</div>
	</c:if>
	<div data-options="region:'center'">
		<div class="cs-col-lg-table">
			<div class="cs-tab-box cs-on" style="width:100%;">
				<div style="width:100%; border: 1px solid #ddd; padding: 10px 0; margin-bottom: 10px; border-left: 0; border-right: 0;">
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
				<div id="dataList"></div>
			</div>
		</div>
	</div>

	<!-- Modal 1 大-->
	<div class="modal fade intro2" id="fModal" tabindex="-1" role="dialog" aria-labelledby="fModalLabel">
		<div class="modal-dialog cs-mid-width" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
					<h4 class="modal-title" id="fModalLabel">食品覆盖</h4>
				</div>
				<div class="modal-body cs-mid-height">
					<!-- 主题内容 -->
					<div id="dataList2"></div>

				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				</div>
			</div>
		</div>
	</div>

	<script src="${webRoot}/js/datagridUtil2.js"></script>
    <script src="${webRoot}/plug-in/echarts/echarts.min.js"></script>
    <script src="${webRoot}/plug-in/echarts/shine.js"></script>
    <script src="${webRoot}/js/selectRow.js"></script>
    <script type="text/javascript">
	var systemFlag="${systemFlag}";////系统标识：0通用系统，1 武陵定制系统，将所有页面档口修改为“摊位”
	var option1 = {
			title : {
				text : systemFlag==1 ? "摊位覆盖率" : '档口覆盖率',
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
				left : '5%',
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
					},
					formatter: function (params){ 
	                    var index = 8;
	                    var newstr = '';
	                    for(var i=0;i<params.length;i+=index){
	                        var tmp=params.substring(i, i+index);
	                        newstr+=tmp;
	                    }
	                    if( newstr.length > 8)
	                        return newstr.substring(0,8) + '.';
	                    else
	                        return '\n'+newstr;
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

	var option2 = {
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
				left : '5%',
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
					},
					formatter: function (params){ 
	                    var index = 8;
	                    var newstr = '';
	                    for(var i=0;i<params.length;i+=index){
	                        var tmp=params.substring(i, i+index);
	                        newstr+=tmp;
	                    }
	                    if( newstr.length > 8)
	                        return newstr.substring(0,8) + '.';
	                    else
	                        return '\n'+newstr;
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

	var option3 = {
			title : {
				text : systemFlag==1 ? '总摊位覆盖率' : '总档口覆盖率',
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
				name :  systemFlag==1 ? '总摊位覆盖率' : '总档口覆盖率',
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
				} ],
				itemStyle : {
					emphasis : {
						shadowBlur : 10,
						shadowOffsetX : 0,
						shadowColor : 'rgba(0, 0, 0, 0.5)'
					}
				}
			} ]
		};

	var option4 = {
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
					value : 0,
					name : '已检测'
				}, {
					value : 0,
					name : '未检测'
				} ],
				itemStyle : {
					emphasis : {
						shadowBlur : 10,
						shadowOffsetX : 0,
						shadowColor : 'rgba(0, 0, 0, 0.5)'
					}
				}
			} ]
		};
	
	var cpId = 0;//选中项目ID
	$(function(){
		//默认统计时间为上个月
		// $("#yyyyMM").val((new Date().DateAdd("m", -1)).format("yyyy-MM"));
		$("#yyyyMM").val((new Date()).format("yyyy-MM"));

		//右上角切换按钮
		$(".cs-tab-icon li").click(function() {
			$(".cs-tab-icon li").eq($(this).index()).children('a').addClass("active").parent('li').siblings().children('a').removeClass('active');
			$(".cs-tab-box").hide().eq($(this).index()).show();

		});
		
    	$("#type li:first-child").addClass("active");//第一次进来就默认选中第一个
    	cpId = $("#type li:first-child").data("type");
    	if(!cpId){
    		cpId = 0;
    	}
    	bigbang();
    	
	});
    
	
    function btnSelectedReport(obj) {
    	$.each($("li[name='type']"), function (index, item) {
            $(item).attr("class", "");
        });
    	cpId = $(obj).data("type");
		$(obj).addClass("active");
    	bigbang();
	}

    var echartsShowNum = 20;//柱状图最大显示数量
    function bigbang() {
    	setTimeout(function(){	//延迟100ms获取查询年月
	    	var yyyyMM = $("#yyyyMM").val();
	    	$.ajax({
		        type: "POST",
		        url: "${webRoot}/regStatistics/coverageData.do",
		        data: {"projectId":cpId,"yyyyMM":yyyyMM},
		        dataType: "json",
		        success: function(data){
		        	if(data && data.success){
		        		
		        		var regStatistics = data.obj.regStatistics;
		        		
		        		var dkyjc = 0;	//总档口已检测数量
		        		var dkwjc = 0;	//总档口未检测数量
		        		
		        		var dkscmc = [];	//市场名称(档口统计)
		        		var dksczs = [];	//市场档口总数量
		        		var dkscyjc = [];	//市场档口已检测数量
		        		var dkscwjc = [];	//市场档口未检测数量
		        		
		        		var spyjc = 0;	//总食品已检测数量
		        		var spwjc = 0;	//总食品未检测数量
		        		
		        		var spscmc = [];	//市场名称(食品统计)
		        		var spsczs = [];	//市场食品总数量
		        		var spscyjc = [];	//市场食品已检测数量
		        		var spscwjc = [];	//市场食品未检测数量
		        		

		        		//排序
		        		regStatistics.sort(function(a,b){
		        			//按检测档口数量倒序排列
		        		    if(a.stallCheckNum < b.stallCheckNum){
		        		       return 1;
		        		    }else if(a.stallCheckNum > b.stallCheckNum){
		        		        return -1;
		        		    }else{
		        		    	//若检测档口数量相等，按档口总数倒序排列
		        		    	if(a.stallAllNum < b.stallAllNum){
			        		       return 1;
			        		    }else if(a.stallAllNum > b.stallAllNum){
			        		        return -1;
			        		    }else{
				        		    return 0;
			        		    }
		        		    }
		        		});
		        		
		        		for(var i =0;i<regStatistics.length;i++){
		        			dkyjc += regStatistics[i].stallCheckNum;
		        			dkwjc += regStatistics[i].stallUncheckNum;
		        			
		        			if(i<echartsShowNum){
			        			dkscmc[i] = regStatistics[i].regName;
			        			dksczs[i] = regStatistics[i].stallAllNum;
			        			dkscyjc[i] = regStatistics[i].stallCheckNum;
			        			dkscwjc[i] = regStatistics[i].stallUncheckNum;
		        			}
		        		}

		        		//排序
		        		regStatistics.sort(function(a,b){
		        			//按检测样品数量倒序排列
		        		    if(a.foodCheckNum < b.foodCheckNum){
		        		       return 1;
		        		    }else if(a.foodCheckNum > b.foodCheckNum){
		        		        return -1;
		        		    }else{
		        		    	//若检测样品数量相等，按样品总数倒序排列
		        		    	if(a.foodAllNum < b.foodAllNum){
			        		       return 1;
			        		    }else if(a.foodAllNum > b.foodAllNum){
			        		        return -1;
			        		    }else{
				        		    return 0;
			        		    }
		        		    }
		        		});
		        		
		        		for(var i =0;i<regStatistics.length;i++){
		        			spyjc += regStatistics[i].foodCheckNum;
		        			spwjc += regStatistics[i].foodUncheckNum;
		        			
		        			if(i<echartsShowNum){
			        			spscmc[i] = regStatistics[i].regName;
			        			spsczs[i] = regStatistics[i].foodAllNum;
			        			spscyjc[i] = regStatistics[i].foodCheckNum;
			        			spscwjc[i] = regStatistics[i].foodUncheckNum;
		        			}
		        		}

		        	    
		        	    var first = echarts.init(document.getElementById('first'), "shine");
		        		var second = echarts.init(document.getElementById('second'), "shine");
		        		var third = echarts.init(document.getElementById('third'), "shine");
		        		var four = echarts.init(document.getElementById('ford'), "shine");
		        		
		        		option1.xAxis[0].data = dkscmc;
						option1.series[0].data = dkscyjc;
						option1.series[1].data = dkscwjc;
						option1.series[2].data = dksczs;
						first.setOption(option1);
	
						option2.xAxis[0].data = spscmc;
						option2.series[0].data = spscyjc;
						option2.series[1].data = spscwjc;
						option2.series[2].data = spsczs;
						second.setOption(option2);
		        			
		        		option3.series[0].data[0].value = dkyjc;
						option3.series[0].data[1].value = dkwjc;
						third.setOption(option3);
	
						option4.series[0].data[0].value = spyjc;
						option4.series[0].data[1].value = spwjc;
						four.setOption(option4);
		        		
		        	}else{
		        		console.log("覆盖率查询失败");
		        	}
				}
		    });
	    	
	    	var dgu1 = datagridUtil.initOption({
	   			tableId: "dataList", //列表ID
	   			tableAction: "${webRoot}/regStatistics/datagrid.do?projectId="+cpId+"&yyyyMM="+yyyyMM, //加载数据地址
	   			parameter: [ //列表拼接参数
	   				{
	       				columnCode: "regName",
	       				columnName: "市场"
	       			}, {
	       				columnCode: "stallAllNum",
	       				columnName: systemFlag==1 ? "摊位总数" : "档口总数",
						sortDataType: "int"
	       			}, {
	       				columnCode: "stallCheckNum",
	       				columnName: systemFlag==1 ? "已检摊位数" : "已检档口数",
						sortDataType: "int"
	       			}, {
	       				columnCode: "stallCheckRate",
	       				columnName: systemFlag==1 ? "摊位覆盖率" : "档口覆盖率",
						sortDataType: "float"
	       			}, {
	       				columnCode: "foodAllNum",
	       				columnName: "食品总数",
						sortDataType: "int"
	       			}, {
	       				columnCode: "foodCheckNum",
	       				columnName: "已检食品数",
						sortDataType: "int"
	       			}, {
	       				columnCode: "foodCheckRate",
	       				columnName: "食品覆盖率",
						sortDataType: "float",
						customElement: "<a class=\"under-line text-primary\" href=\"javascript:;\" onclick=\"foodCov('#regId#');\">?</a>"
	       			}
				],
				onload: function () {
	   			    //修改排序
					// dgu1.orderBy('mdataList',6,'int');
					// dgu1.orderBy('mdataList',6,'int');
				}
	   		});
			dgu1.queryByFocus();
    	}, 100);
	}
    
    $(document).on("click",".pp",function(){
    	self.location = '${webRoot}/datastatistics/reportStatistics?id='+$(this).parents(".rowTr").attr("data-rowId");
    });

	function foodCov(regId) {
        var dgu2 = datagridUtil.initOption({
            tableId: "dataList2",
            tableAction: "${webRoot}/regStatistics/foodDatagrid",
            pageOff: 1,
            defaultCondition: [{
                queryCode: "userRegId",
                queryVal: regId
            },{
                queryCode: "yyyyMM",
                queryVal: $("#yyyyMM").val()
            }],
            parameter: [
                {
                    columnCode: "f_name",
                    columnName: "食品名称"
                }, {
                    columnCode: "f_check_num",
                    columnName: "检测数量",
                    sortDataType: "int"
                }
            ]
        });
		dgu2.query();

		$("#fModal").modal('show');
	}
    
    
    </script>
</body>
</html>