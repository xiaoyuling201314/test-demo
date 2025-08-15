<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/common/resource.jsp"%>
<html>
<head>
<title>快检服务云平台</title>
</head>
<body>
	<div class="cs-col-lg clearfix">
      <!-- 面包屑导航栏 开始-->
      <ol class="cs-breadcrumb">
        <li class="cs-fl">
          <img src="${webRoot}/img/set.png" alt="" />
          <a href="javascript:">数据统计</a></li>
        <li class="cs-fl">
          <i class="cs-sorrow">&gt;</i></li>
        <li class="cs-fl">检测点统计</li>
        </ol>
     
      <div class="cs-input-style cs-fl" style="margin:3px 0 0 4px;">
      	<input type="hidden" id="typeObj">
      	<input type="hidden" name="year" id="years"/>
        <select id="province" class="cs-selcet-style pull-left" style="width: 85px;margin-right:4px;">
          <option value="month">月报表</option>
          <option value="season">季报表</option>
          <option value="year">年报表</option>
          <option value="diy">自定义</option></select>
        <div class="check-date cs-hide">
        	<select class="cs-selcet-style" style="display: none;"></select>
        </div>
        <div class="check-date pull-left">
        <select class="theyear cs-selcet-style" id="year1" style="width: 98px;"> 
			<option value="" >--请选择--</option>
		</select>
        <select class="cs-selcet-style" id="month" style="width: 85px;">
          <option value="">--请选择--</option>
          <option value="1">1月</option>
          <option value="2">2月</option>
          <option value="3">3月</option>
          <option value="4">4月</option>
          <option value="5">5月</option>
          <option value="6">6月</option>
          <option value="7">7月</option>
          <option value="8">8月</option>
          <option value="9">9月</option>
          <option value="10">10月</option>
          <option value="11">11月</option>
          <option value="12">12月</option>
        </select>
        </div>
        <div class="check-date pull-left cs-hide">
        <select class="theyear cs-selcet-style" id="year2" style="width: 98px;"> 
      		<option value="">--请选择--</option>
        </select>
        <select class="cs-selcet-style" id="season" style="width: 85px;">
          <option value="">--请选择--</option>
          <option value="1">第一季度</option>
          <option value="2">第二季度</option>
          <option value="3">第三季度</option>
          <option value="4">第四季度</option>
        </select>
        </div>
        <div class="check-date pull-left cs-hide">
        <select class="theyear cs-selcet-style" id="year" style="width: 85px;">
          <option value="">--请选择--</option>
        </select>
        </div>
      </div>
      <span class="check-date pull-left cs-hide">
          <!-- <span class="cs-name">时间:</span> -->
          <span class="cs-in-style cs-time-se cs-time-se">
            <input name="start" id="start" style="width: 120px;" class="cs-time Validform_error" type="text" onclick="WdatePicker()" datatype="date" nullmsg="请选择任务起止时间" errormsg="请选择任务起止时间" value="" autocomplete="off">
            <!-- <span style="padding:0 5px;">至</span> -->
            <input name="end" id="end" style="width: 120px;" class="cs-time Validform_error" type="text" onclick="WdatePicker()" datatype="date" nullmsg="请选择任务起止时间" errormsg="请选择任务起止时间" value="" autocomplete="off"></span>
            <span>
		        <a href="javascript:" class="cs-menu-btn" style="margin:4px 0 0 10px;" onclick="load()">
		        <i class="icon iconfont icon-chakan"></i>查询</a>
		      </span>
        </span>
      <div class="cs-search-box cs-fr">
                <div class="cs-alert cs-fr cs-ac "> 
                <a onclick="parent.closeMbIframe();" class="cs-menu-btn"><i class="icon iconfont icon-fanhui"></i>返回</a>
                </div>
            </div>
    </div>
    <!-- 为 ECharts 准备一个具备大小（宽高）的 DOM -->
    <div class="charts" style="border:1px solid #ddd; padding:10px 0; margin-bottom:10px; border-left:0; border-right:0;">
      <div id="sixth" class="cs-echart" style="width: 63%;height:350px; display:inline-block;"></div>
      <div id="second" class="cs-echart" style="width: 35%;height:350px;display:inline-block; margin-left:1%;"></div>
    </div>
    <div class="chart-table" style="padding-bottom:50px;" id="dataList">
      
    </div>
    
    <!-- 内容主体 结束 -->
   	<script src="${webRoot}/plug-in/echarts/echarts.min.js"></script>
    <script src="${webRoot}/plug-in/echarts/shine.js"></script>
    <script src="${webRoot}/js/datagridUtil.js"></script>
    <script type="text/javascript">

	var dates = [];
	var num = [];
	var qualified=[];
	var unqualified=[];
	var qualifieds;
	var unqualifieds;
    
    $(function () {
		$("#province").find("option[value='"+'${type}'+"']").attr("selected",true);
		$("#month").find("option[value='"+'${month}'+"']").attr("selected",true);
		$("#season").find("option[value='"+'${season}'+"']").attr("selected",true);
		$(".theyear").find("option[value='"+'${year}'+"']").attr("selected",true);
		
		var type=$("#province option:selected").val();
    	var month=$("#month option:selected").val();
    	var season=$("#season option:selected").val();
    	//var year=$("#year option:selected").val();
    	var start="${start}";
    	$("#start").val("${start}");
    	var end="${end}";
    	$("#end").val("${end}");
    	var typeObj="${typeObj}";
    	$("#typeObj").val("${typeObj}");
    	
    	var year;
    	if($("#province").val()=="month"){
			year=$("#year1").val();
		}else if ($("#province").val()=="season") {
			year=$("#year2").val();
		}else if ($("#province").val()=="year") {
			year=$("#year").val();
		}
    	$("#years").val(year);
    	
    	$("#province option").each(function(i,o){
            if($(this).val() == $("#province option:selected").val()){
             $(".check-date").hide().val();
             $(".check-date").eq(i+1).show();
           }
         });
    	
		bigbang(type,month,season,year,start,end,typeObj);
		
		loadData();
	});
    $("#month").change(function(){
		load();
    });
	
	$("#season").change(function(){
		load();
    });
	
	$("#year").change(function(){
		load();
    });
	
	function callback() {
		self.location = encodeURI("${webRoot}/statistics/areaStatistics?type="+'${type}'+"&month="+'${month}'+"&season="+'${season}'+"&year="+'${year}'+"&start="+'${start}'+"&end="+'${end}'+"&did="+'${did}'+"&dname="+'${dname}'+"&typeObj="+'${typeObj}'+"&flag=1");
	}
    
    function load() {
    	var year;
    	if($("#province").val()=="month"){
			year=$("#year1").val();
		}else if ($("#province").val()=="season") {
			year=$("#year2").val();
		}else if ($("#province").val()=="year") {
			year=$("#year").val();
		}
    	$("#years").val(year);
    	
    	var type=$("#province option:selected").val();
    	var month=$("#month option:selected").val();
    	var season=$("#season option:selected").val();
    	//var year=$("#year option:selected").val();
    	var start=$("#start").val();
    	var end=$("#end").val();
    	var typeObj=$("#typeObj").val();
		bigbang(type,month,season,year,start,end,typeObj);
		
		loadData();
	}
    
    function loadData() {
    	$.ajax({
	        type: "POST",
	        url: '${webRoot}'+"/statistics/selectDataForDate.do",
	        data:{type:$("#province option:selected").val(),
	        	month:$("#month option:selected").val(),
	        	season:$("#season option:selected").val(),
	        	year:$("#years").val(),
	        	start:$("#start").val(),
	        	end:$("#end").val(),
	        	typeObj:$("#typeObj").val()
	        },
	        dataType: "json",
	        success: function(data){
	        	if(data && data.success){
	        		dates = [];
	            	num = [];
	            	qualified=[];
	            	unqualified=[];
        			$.each(data.obj, function(k, v) {
        				dates.push(v.date);
        				qualified.push(v.qualified);
        				num.push(v.num);
        				unqualified.push(v.unqualified);
        			});
        			
        			bigbang1();
	        	}else{
	        		console.log("查询失败");
	        	}
			},
			error: function(){
				console.log("查询失败");
			}
	    });
		
		$.ajax({
	        type: "POST",
	        url: '${webRoot}'+"/statistics/selectDataForDates.do",
	        data:{type:$("#province option:selected").val(),
	        	month:$("#month option:selected").val(),
	        	season:$("#season option:selected").val(),
	        	year:$("#years").val(),
	        	start:$("#start").val(),
	        	end:$("#end").val(),
	        	typeObj:$("#typeObj").val()
	        },
	        dataType: "json",
	        success: function(data){
	        	if(data && data.success){
	        		$.each(data.obj, function(k, v) {
	        			qualifieds=v.qualified;
	        			unqualifieds=v.unqualified;
        			});
	        			
	        		bigbang2();
	        	}else{
	        		console.log("查询失败");
	        	}
			},
			error: function(){
				console.log("查询失败");
			}
	    });
	}
    
    function bigbang1() {
    	var myChart1 = echarts.init(document.getElementById('sixth'), "shine");

        option1 = {
          title: {
              text: '检测量统计'
          },
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
            data: ['合格', '不合格']
          },
          grid: {
            left: '3%',
            right: '6%',
            bottom: '10%',
            top: '12%',
            containLabel: true
          },
          xAxis: [{
            type: 'category',
            boundaryGap: false,
            data: dates,
            splitLine: {
              show: true
            },
            /* axisLine: {
              lineStyle: {
              }
            }, */
            axisLabel: {
                  interval: 'auto', 
                  rotate: 20, 
                  show: true, 
                  splitNumber: 15, 
                  textStyle: {
                      fontSize: 12
                  }
              }
          }],
          yAxis: [{
            type: 'value',
            axisLine: {
              lineStyle: {
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
          },
          {
            name: '不合格',
            type: 'line',
            stack: '总量2',
            areaStyle: {
              normal: {
                color: new echarts.graphic.LinearGradient(0, 0, 0, 0)
              }
            },
            data: unqualified
          },
          {
            name: '合计总量',
            type: 'bar',
            stack: '检测数量',
            label: {
              normal: {
                show: false,
                position: 'insideBottom',
                formatter: '{c}',
                textStyle: {
                  color: '#000'
                }
              }
            },
            itemStyle: {
              normal: {
                color: 'rgba(128, 128, 128, 0)'
              }
            },
            data: num
          }]
        };
        myChart1.setOption(option1);
	}
    
    function bigbang2() {
    	var myChart = echarts.init(document.getElementById('second'), "shine");

        option = {
          title: {
            text: '不合格比例',
          },
          tooltip: {
            trigger: 'item',
            formatter: "{a} <br/>{b}: {c} ({d}%)"
          },
          legend: {
            orient: 'vertical',
            x: 'right',
            data: ['合格', '不合格']
          },
          series: [{
            name: '检测数据比例',
            type: 'pie',
            radius: '50%',
            center: ['40%', '55%'],
              label: {
                  normal: {
                      formatter: '{d}%',
                  }
              },
            data: [{
              value: qualifieds,
              name: '合格'
            },
            {
              value: unqualifieds,
              name: '不合格'
            }],
            itemStyle: {
              normal: {
                  shadowBlur: 2,
                  shadowOffsetX: -1,
                  shadowColor: 'rgba(0, 0, 0, 0.5)'
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
	}
      
      function bigbang(type,month,season,year,start,end,typeObj) {
    	  var op = {
    				tableId: "dataList",	//列表ID
    				tableAction: '${webRoot}'+"/statistics/loadDatadatagrid.do?type="+type+"&month="+month+"&season="+season+"&year="+year+"&start="+start+"&end="+end+"&typeObj="+typeObj,	//加载数据地址
    				parameter: [		//列表拼接参数
    						{
    							columnCode: "pointName",
    							columnWidth:'10%',
    							columnName: "检测单位"
    						},
    						{
    							columnCode: "checkUsername",
    							columnWidth:'10%',
    							columnName: "检测人员"
    						},
    						{
    							columnCode: "regName",
    							columnWidth:'10%',
    							columnName: "被检单位"
    						},
    						{
    							columnCode: "regUserName",
    							columnWidth:'10%',
    							columnName: "${systemFlag}"=="1" ? "摊位名称" : "档口名称"
    						},
    						
    						{
    							columnCode: "foodName",
    							columnWidth:'10%',
    							columnName: "样品名称"
    						},
    						{
    							columnCode: "itemName",
    							columnWidth:'10%',
    							columnName: "检测项目"
    						},
    						{
    							columnCode: "checkResult",
    							columnWidth:'10%',
    							columnName: "检测结果值",
                                sortDataType: "float"
    						},
    						{
    							columnCode: "conclusion",
    							columnName: "检测结果",
    							query: 1,
    							columnWidth:'10%',
    							queryType: 2,
    							customVal: {"合格":"<div class=\"text-success\">合格</span>","不合格":"<div class=\"text-danger\">不合格</span>"}
    							
    						},
    						{
    							columnCode: "checkDate",
    							columnWidth:'15%',
    							columnName: "检测时间",
    							dateFormat: "yyyy-MM-dd HH:mm:ss",
                                sortDataType: "date"
    							
    						}
    				]
    			};
    			datagridUtil.initOption(op);
    		    datagridUtil.query();
		}
      var selyear = $(".theyear");
      var startYear=2017;
      var now = new Date();
      var year = now.getFullYear(); //获取当前年份  
      var betYear = year-startYear+1;
      for (var i = 0; i < betYear; i++) {
          var option = $("<option>").val(startYear).text(startYear+"年"); //给option添加value值与文本值  
          selyear.append(option);  //添加到select下     
          var startYear = startYear+1;       //年份+1，再添加一次
      }
    </script>
</body>
</html>