<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/common/resource.jsp"%>
<html>
  <head>
    <title>快检服务云平台</title>
  </head>
  <body>
          <!-- 面包屑导航栏  开始-->
          <div class="cs-col-lg clearfix">
            <ol class="cs-breadcrumb">
              <li class="cs-fl">
              <img src="${webRoot}/img/set.png" alt="" />
              <a href="javascript:">任务管理</a></li>
               <li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
              <li class="cs-fl">任务统计
              <li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
              <li class="cs-b-active cs-fl">下发任务统计
              </li>
            </ol>
          <!-- 面包屑导航栏  结束-->
             <!-- 顶部筛选 -->
          <!-- 顶部筛选 -->
          <div class="cs-input-style cs-fl" style="margin:5px 0 0 15px;">
              <select id="province" class="cs-selcet-style" style="width: 85px;" onchange="load();"> 
              	<!-- <option value="day">日报表</option> --> 
				<option value="year">年报表</option>
                 <option value="diy">自定义</option> 
              </select> 
              <select class="check-date cs-selcet-style cs-hide"></select>
              <select class="check-date cs-selcet-style" id="year" style="width: 85px;" onchange="load();"></select>
            </div>  
            <span class="check-date cs-hide">
               <span class="cs-name">时间:</span>
	                <span class="cs-in-style cs-time-se cs-time-se">
	                	<input  id="startTime" style="width: 110px;" class="cs-time Validform_error" type="text" onclick="WdatePicker({dateFmt:'yyyy-MM'})" datatype="date" nullmsg="请选择任务起止时间" errormsg="请选择任务起止时间" value="">
	                	<span style="padding:0 5px;">
	                                      至</span>
	                    <input  id="endTime" style="width: 110px;" class="cs-time Validform_error" type="text" onclick="WdatePicker({dateFmt:'yyyy-MM'})" datatype="date" nullmsg="请选择任务起止时间" errormsg="请选择任务起止时间" value="">
	                </span>
	                <span>
		            	<a href="javascript:" class="cs-menu-btn" style="margin:4px 0 0 10px;" onclick="load()"><i class="icon iconfont icon-chakan"></i>查询</a>
		            </span>
                </span>
</div>
 <div style="border:1px solid #ddd; padding:10px 0; margin-bottom:10px; border-left:0; border-right:0;">
    <div id="third" class="cs-echart" style="width: 50%;height:280px; display:inline-block;"></div>
    <div id="second" class="cs-echart" style="width: 48%;height:280px;display:inline-block; margin-left:1%;"></div>
  </div>

      <div style="padding-bottom:50px;">
             <table class="cs-table cs-table-hover table-striped cs-tablesorter" id="table">
                <thead>
                  <tr>
                    <th class="cs-header" style='width:50px;'>序号</th>
                    <th class="cs-header">日期</th>
                    <th class="cs-header" onclick="orderByName('table',2,'int')">下发任务数量</th>
                    <th class="cs-header" onclick="orderByName('table',3,'int')">下发完成数量</th>
                    <th class="cs-header" onclick="orderByName('table',4,'float')">下发未完成数量</th>
                    <th class="cs-header" onclick="orderByName('table',5,'float')">下发完成率</th>
                  </tr>
                </thead>
                <tbody>

                </tbody>
              </table>
</div>
	
	<!-- 引用模态框 -->
	<%@include file="/WEB-INF/view/common/confirm.jsp"%>
    
    <!-- JavaScript -->
    <script src="${webRoot}/js/datagridUtil.js"></script>
    <script type="text/javascript">
    // /dataCheck/recording/list.do
   	var arr=[];
   	var date=[];
   	var finish=[];
   	var unqualified=[];
   	var view=0;
   	var viewObj;
	for (var i = 0; i < childBtnMenu.length; i++) {
	 if (childBtnMenu[i].operationCode == "1382-1") {
			//查看
			view = 1;
			viewObj=childBtnMenu[i];
		}
	}
	
    $(function () {
        var date = newDate();
        for(var i=2017; i<=date.getFullYear(); i++){
            $("#year").append("<option value=\""+i+"\">"+i+"年</option>");
        }
    	$("#year").find("option[value='"+date.getFullYear()+"']").attr("selected",true);
    	load();
	}); 
    function load() {
    	$("#table tbody tr").remove();
    	loadData();
	}
    function loadData() {
    	arr=[];
    	date=[];//柱状图要显示的时间列表
       	finish=[];//柱状图要显示的已完成数据列表
       	unqualified=[];//柱状图要显示的未完成数据列表
       	missionFinish=0;//统计总的完成量，用于填充饼图数据
       	missionUnqualified=0;//统计总的未完成数量，用于填充饼图数据
    	$.ajax({
	        type: "POST",
	        url: '${webRoot}'+"/task/statisticsDatagrid.do",
	        data:{type:$("#province option:selected").val(),
	        	year:$("#year option:selected").val(),
	        	startTime:$("#startTime").val(),
	        	endTime:$("#endTime").val(),
	        	missionOrRecevied:0
	        },
	        dataType: "json",
	        success: function(data){
	        	if(data && data.success){
        			$.each(data.obj.results, function(k, o) {
						var html="<tr>";
						html+="<td style='width:50px;'>"+(k+1)+"</td>";
						html+="<td>"+o.taskDate+"</td>";
						html+="<td>"+o.missionNum+"</td>";
						html+="<td>"+o.missionFinish+"</td>";
						html+="<td>"+o.missionUnqualified+"</td>";
						html+="<td>"+o.mCompletionRate+"%</td>";
						html+="</tr>";
						$("#table tbody").append(html);
						date.push(o.taskDate);
						finish.push(o.missionFinish);
						unqualified.push(o.missionUnqualified);
						missionFinish+=o.missionFinish;
						missionUnqualified+=o.missionUnqualified
					});
					var taskObj=data.obj.obj;
					arr.push({ name : "完成率",value : missionFinish});
					arr.push({ name : "未完成率",value : missionUnqualified});
			    	fillData();
	        	}else{
	        		console.log("查询失败");
	        	}
			},
			error: function(){
				console.log("查询失败");
			}
	    });
	}
	function fillData(){
		//饼图参数设置
		var myChart = echarts.init(document.getElementById('second'),"shine");
	  	second = {
		title: {
		    text: '完成率统计'
		},
		tooltip: {
		    trigger: 'item',
		    formatter: "{a} <br/>{b}: {c} ({d}%)"
		},
		legend: {
		    orient: 'vertical',
		    x: 'right',
		    itemGap:7 ,
		    data:['完成率','未完成率']
		},
		series : [
		    {
		        name: '任务进度',
		        type: 'pie',
		        radius : '45%',
		        center: ['50%', '60%'],
		        data:arr,
		        itemStyle: {
	                normal: {
	                    label:{
	                      show:true,
	                      formatter: '{c} ({d}%)',//{b} :
	                      testStyle:{
	                        fontFamily:'宋体',
	                        fontSize:20,
	                        fontWeight:'bold'
	                      }
	                    },
	                    labelLine:{show:true}
	                }
	            }
		    }
		]
		
		};
	
	   // 使用刚指定的配置项和数据显示图表。
	    myChart.setOption(second);
	   //柱状图参数设置
	    var myChart1 = echarts.init(document.getElementById('third'),"shine");
		
		third = {
		title: {
		    text: '任务数量',
		},
		tooltip : {
		    trigger: 'axis',
		    axisPointer : {            // 坐标轴指示器，坐标轴触发有效
		        type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
		    }
		},
		legend: {
		    data:['完成','未完成']
		},
		grid: {
		    left: '3%',
		    right: '4%',
		    bottom: '6%',
		    containLabel: true
		},
		xAxis : [
		    {
		        type : 'category',
		        data : date,
		        axisLabel: {
	                 interval: 0, 
	                  rotate: 20, 
	                  show: true, 
	                  splitNumber: 15, 
	                  textStyle: {
	                      fontSize: 12
	                  }
	              }
		    }
		],
		yAxis : [
		    {
		        type : 'value'
		    }
		],
		series : [
		    {
		        name:"完成数",
		    	type:'bar',
		        stack: 'task',
		        data:finish,
		        itemStyle: {
	                normal: {
	                    label:{
	                      show:true,
	                      formatter: '{c}',//{b} :
	                      testStyle:{
	                        fontFamily:'宋体',
	                        fontSize:20,
	                        fontWeight:'bold'
	                      }
	                    },
	                    labelLine:{show:true}
	                }
	            }
		    },
		    {
		    	 name:"未完成数",
		    	type:'bar',
		        stack: 'task',
		        data:unqualified,
		        itemStyle: {
	                normal: {
	                    label:{
	                      show:true,
	                      formatter: '{c}',//{b} :
	                      testStyle:{
	                        fontFamily:'宋体',
	                        fontSize:20,
	                        fontWeight:'bold'
	                      }
	                    },
	                    labelLine:{show:true}
	                }
	            }
		    }
		   
		]
		};
		
		// 使用刚指定的配置项和数据显示图表。
		myChart1.setOption(third);
	}
    </script>
  </body>
</html>
