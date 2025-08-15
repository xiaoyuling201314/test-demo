<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/common/resource.jsp"%>
<html>
<head>
<title>快检服务云平台</title>
<style type="text/css">
    .cs-min-table th{
      background:#ddd;
      color:#333;
    }
    .cs-min-table tr,.cs-min-table th,.cs-min-table td{
      height:30px;
    }
    .report-chart-title{
      padding:15px;
      background: #fff;
      border-bottom: 1px solid #ddd;
    }
    .cs-schedule-mao{
    	min-height:394px;
    }
    .cs-schedule-mao2{
    	min-height:243px;
    }
</style>
</head>
<body style="background:#ebebeb;">
<div class="cs-col-lg clearfix">
	<!-- 面包屑导航栏  开始-->
	<ol class="cs-breadcrumb">
		<li class="cs-fl">
			<img src="${webRoot}/img/set.png" alt="" />
			<a href="javascript:">项目管理</a>
		</li>
		<li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
		<li class="cs-b-active cs-fl">项目统计</li>
	</ol>
	<!-- 面包屑导航栏  结束-->
	<div class="cs-search-box cs-fr">
		<form action="">
			<div class="cs-fr cs-ac">
				<div class="cs-fr cs-ac">
					<a href="${webRoot}/datastatistics/projectReport?id=${id}" class="cs-menu-btn"><i class="icon iconfont icon-fanhui"></i>返回</a>
				</div>
			</div>
		</form>
	</div>
</div>

<!-- 列表 -->
<div class="">
	<div class="cs-schedule-content clearfix">
		<div class="report-chart-title col-lg-12 col-md-12"> 
			<h3>${dataStatistics.statisticsName}</h3>
		</div>
		<div class="cs-schedule-mao cs-schedule-mao2 col-lg-12 col-md-12 clearfix">
			<div class="cs-number-include col-lg-6 col-md-6 clearfix">
				<div class="cs-include-title col-lg-12 col-md-12" >检测数据分析</div>
					<div class="all-num col-lg-5 col-md-5 clearfix" >
					<div class="inform-box col-lg-11 col-md-11 yellow-box"  >
						<span class="icon-circel">
							<span class="icon iconfont icon-baogao"></span>
						</span>
						<span class="circel-num">
							<p>总 &nbsp;&nbsp;&nbsp;数：
							<c:choose>  
								<c:when test="${!empty list}">
									<c:forEach items="${list}" var="menu">
										${menu.num}
									</c:forEach>
								</c:when>  
								   <c:otherwise>0</c:otherwise>  
							</c:choose>批次</p>
						</span>
					</div>
					<div class="blue-box inform-box col-lg-11 col-md-11">
						<span class="icon-circel" >
							<span class="icon iconfont icon-buhege2"></span>
						</span>
						<span class="circel-num">
							<p>合&nbsp;&nbsp;&nbsp;&nbsp;格：
							<c:choose>  
								<c:when test="${!empty list}">
									<c:forEach items="${list}" var="menu">
										${menu.qualified}
									</c:forEach>
								</c:when>  
								   <c:otherwise>0</c:otherwise>  
							</c:choose>批次</p>
						</span>
					</div>
					<div class="red-box inform-box col-lg-11 col-md-11">
						<span class="icon-circel">
							<span class="icon iconfont icon-buhege2"></span>
						</span>
						<span class="circel-num">
							<p>不合格：
							<c:choose>  
								<c:when test="${!empty list}">
									<c:forEach items="${list}" var="menu">
										${menu.unqualified}
									</c:forEach>
								</c:when>  
								   <c:otherwise>0</c:otherwise>  
							</c:choose>批次</p>
						</span>
					</div>
				</div>
				<div class="col-lg-7 col-md-7 clearfix" style="padding:10px 5px 5px 5px; border-right:1px solid #eee;" >
					<div id="progress1" class="col-lg-12 col-md-12" style="height:200px; "></div>
				</div>
			</div>
			<div class="cs-number-include col-lg-6 col-md-6 clearfix">
				<div class="cs-include-title col-lg-12 col-md-12">不合格处理</div>
				<div class="all-num col-lg-5 col-md-5 clearfix" >
					<div class="red-box inform-box col-lg-11 col-md-11">
						<span class="icon-circel">
							<span class="icon iconfont icon-buhege2"></span>
						</span>
						<span class="circel-num">
							<p>待处理：
							<c:choose>  
								<c:when test="${!empty list2}">
									<c:forEach items="${list2}" var="menu">
										${menu.deal}
									</c:forEach>
								</c:when>  
								   <c:otherwise>0</c:otherwise>  
							</c:choose>批次</p>
						</span>
					</div>
					<div class="inform-box col-lg-11 col-md-11 yellow-box">
						<span class="icon-circel">
							<span class="icon iconfont icon-baogao"></span>
						</span>
						
						<span class="circel-num">
							<p>处理中：
							<c:choose>  
								<c:when test="${!empty list2}">
									<c:forEach items="${list2}" var="menu">
										${menu.dealing}
									</c:forEach>
								</c:when>  
								   <c:otherwise>0</c:otherwise>  
							</c:choose>批次</p>
						</span>
					</div>
					<div class="blue-box inform-box col-lg-11 col-md-11">
						<span class="icon-circel" >
							<span class="icon iconfont icon-buhege2"></span>
						</span>
						<span class="circel-num">
							<p>已处理：
							<c:choose>  
								<c:when test="${!empty list2}">
									<c:forEach items="${list2}" var="menu">
										${menu.dealed}
									</c:forEach>
								</c:when>  
								   <c:otherwise>0</c:otherwise>  
							</c:choose>批次</p>
						</span>
						
					</div>
				</div>
				<div class="col-lg-7 col-md-7 clearfix" style="padding:10px 5px 5px 5px; border-right:1px solid #eee;" >
					<div id="progress2" class="col-lg-12 col-md-12" style="height:200px; "></div>
				</div>
			</div>
		</div>
		
		<div class="cs-schedule-mao cs-schedule-mao2 col-lg-12 col-md-12 clearfix">
			<div class="col-lg-12 col-md-12 clearfix" style="padding:0px 0px 10px 0px; " >
				<div class="cs-include-title col-lg-12 col-md-12" >检测趋势</div>
				<div id="progress3" style="height:300px;width:100%;"></div>
			</div>
		</div>
		
		<div class="cs-schedule-mao col-lg-12 col-md-12 clearfix" id="div4">
			<div class="col-lg-6 col-md-6 clearfix" style="padding:0px 0px 10px 0px; " >
				<div class="cs-include-title col-lg-12 col-md-12" >辖区检测汇总</div>
				<div id="progress4" style="height:350px;width:100%;"></div>
			</div>
			<div class="col-lg-6 col-md-6 clearfix" style="padding:0px 0px 10px 0px; border-right:1px solid #eee;" >
				<div class="cs-include-title cs-include-text col-lg-12 col-md-12" ><a class="text-primary">更多>></a></div>
				<table class="cs-table cs-table-hover table-striped cs-tablesorter cs-min-table" id="table4">
					<thead>
						<tr>
							<th>序号</th>
							<th>辖区名称</th>
							<th>检测批次</th>
							<th>合格批次</th>
							<th>合格率</th>
						</tr>
					</thead>
					<tbody>
						
					</tbody>
				</table>
			</div>
		</div>
		
		<div class="cs-schedule-mao col-lg-12 col-md-12 clearfix">
			<div class="col-lg-6 col-md-6 clearfix" style="padding:0px 0px 10px 0px; " >
				<div class="cs-include-title col-lg-12 col-md-12" >高合格率市场</div>
				<div id="progress5" style="height:350px;width:100%;"></div>
			</div>
			<div class="col-lg-6 col-md-6 clearfix" style="padding:0px 0px 10px 0px; border-right:1px solid #eee;" >
				<div class="cs-include-title cs-include-text  col-lg-12 col-md-12" ><a class="text-primary">更多>></a></div>
				<table class="cs-table cs-table-hover table-striped cs-tablesorter cs-min-table" id="table5">
					<thead>
						<tr>
							<th>序号</th>
							<th>监管单位</th>
							<th>检测批次</th>
							<th>合格批次</th>
							<th>合格率</th>
						</tr>
					</thead>
					<tbody>
						
					</tbody>
				</table>
			</div>
		</div>
		<div class="cs-schedule-mao col-lg-12 col-md-12 clearfix">
			<div class="col-lg-6 col-md-6 clearfix" style="padding:0px 0px 10px 0px; " >
				<div class="cs-include-title col-lg-12 col-md-12" >低合格率市场</div>
				<div id="progress6" style="height:350px;width:100%;"></div>
			</div>
			<div class="col-lg-6 col-md-6 clearfix" style="padding:0px 0px 10px 0px; border-right:1px solid #eee;" >
				<div class="cs-include-title cs-include-text  col-lg-12 col-md-12" ><a class="text-primary">更多>></a></div>
				<table class="cs-table cs-table-hover table-striped cs-tablesorter cs-min-table" id="table6">
					<thead>
						<tr>
							<th>序号</th>
							<th>监管单位</th>
							<th>检测批次</th>
							<th>不合格批次</th>
							<th>不合格率</th>
						</tr>
					</thead>
					<tbody>
						
					</tbody>
				</table>
			</div>
		</div>
		<div class="cs-schedule-mao col-lg-12 col-md-12 clearfix">
			<div class="col-lg-6 col-md-6 clearfix" style="padding:0px 0px 10px 0px; " >
				<div class="cs-include-title col-lg-12 col-md-12" >问题农产品</div>
				<div id="progress7" style="height:350px;width:100%;"></div>
			</div>
			<div class="col-lg-6 col-md-6 clearfix" style="padding:0px 0px 10px 0px; border-right:1px solid #eee;" >
				<div class="cs-include-title cs-include-text  col-lg-12 col-md-12" ><a class="text-primary">更多>></a></div>
				<table class="cs-table cs-table-hover table-striped cs-tablesorter cs-min-table" id="table7">
					<thead>
						<tr>
							<th>序号</th>
							<th>食品名称</th>
							<th>检测批次</th>
							<th>不合格批次</th>
							<th>不合格率</th>
						</tr>
					</thead>
					<tbody>
						
					</tbody>
				</table>
			</div>
		</div>
		<div class="cs-schedule-mao col-lg-12 col-md-12 clearfix">
			<div class="col-lg-6 col-md-6 clearfix" style="padding:0px 0px 10px 0px; " >
				<div class="cs-include-title col-lg-12 col-md-12" >有害问题</div>
				<div id="progress8" style="height:350px;width:100%;"></div>
			</div>
			<div class="col-lg-6 col-md-6 clearfix" style="padding:0px 0px 10px 0px; border-right:1px solid #eee;" >
				<div class="cs-include-title cs-include-text  col-lg-12 col-md-12" ><a class="text-primary">更多>></a></div>
				<table class="cs-table cs-table-hover table-striped cs-tablesorter cs-min-table" id="table8">
					<thead>
						<tr>
							<th>序号</th>
							<th>检测项目</th>
							<th>检测批次</th>
							<th>不合格批次</th>
							<th>不合格率</th>
						</tr>
					</thead>
					<tbody>
						
					</tbody>
				</table>
			</div>
		</div>
	
	</div>
</div>
<!-- 内容主体 结束 -->
<%@include file="/WEB-INF/view/common/confirm.jsp"%>
<script type="text/javascript">
	var marketName= [];
	var marketNamenum = [];
	var marketNamequalified=[];
	var marketNameunqualified=[];
	var marketNames= [];
	var marketNamesnum = [];
	var marketNamesqualified=[];
	var marketNamesunqualified=[];
	var foodName=[];
	var foodNamenum = [];
	var foodNamequalified=[];
	var foodNameunqualified=[];
	var itemName=[];
	var itemNamenum = [];
	var itemNamequalified=[];
	var itemNameunqualified=[];
	var dateTime=[];
	var dateTimenum=[];
	var dateTimequalified=[];
	var dateTimeunqualified=[];
	var checkqualified=0;
	var checkunqualified=0;
	var treatmentdeal=0;
	var treatmentdealing=0;
	var treatmentdealed=0;
	var departName=[];
	var departNamenum=[];
	var departNamequalified=[];
	var departNameunqualified=[];
	var maker=0;
	
	if('${list}'!=''){
		<c:forEach items="${list}" var="t">  
			checkqualified='${t.qualified}'
			checkunqualified='${t.unqualified}'
		</c:forEach>  
	}
	
	if('${list2}'!=''){
		<c:forEach items="${list2}" var="t2">
			treatmentdeal='${t2.deal}'
			treatmentdealing='${t2.dealing}'
			treatmentdealed='${t2.dealed}'
		</c:forEach>  
	}else {
		/* $("#confirm-warnning .tips").text("报表生成中，请稍后查看");
		$("#confirm-warnning").modal('toggle'); */
	}
	
	
	$(function () {
		$.ajax({
	        type: "POST",
	        url: '${webRoot}'+"/datastatistics/loadMarketName.do?type=4",
	        dataType: "json",
	        success: function(data){
	        	if(data && data.success){
	        			$.each(data.obj, function(k, v) {
	        				dateTime.push(v.dateTime);
	        				dateTimenum.push(v.num);
	        				dateTimequalified.push(v.qualified);
	        				dateTimeunqualified.push(v.unqualified);
	        			});
	        			if(data.obj.length>31){
	        				maker='auto';
	        			}
        				bigbang3();
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
	        url: '${webRoot}'+"/datastatistics/loadMarketName.do?type=6",
	        dataType: "json",
	        success: function(data){
	        	if(data && data.success){
	        		if(data.obj!=""){
	        			$.each(data.obj, function(k, v) {
	        				departName.push(v.departName);
	        				departNamenum.push(v.num);
	        				departNamequalified.push(v.qualified);
	        				departNameunqualified.push(v.unqualified);
							if (k<10) {
								var bigbang="<tr>"
		            	    		+"<td class='rowNo' style='width:50px;'>"+(k+1)+"</td>"
		                            +"<td>"+v.departName+"</td>"
		                            +"<td><p class='text-primary'>"+v.num+"</p></td>"
		                            +"<td><p class='text-primary'>"+v.unqualified+"</p></td>"
		                            +"<td><p class='text-primary'>"+((v.unqualified/v.num)*100).toFixed(2)+"%</p></td>"
		                          	+"</tr>"
		                          	$("#table4 tbody").append(bigbang);
							}
	        			});
	        			departName.splice(10);
	        			departNamenum.splice(10);
	        			departNamequalified.splice(10);
	        			departNameunqualified.splice(10);
        				bigbang4();
	        		}else {
						$("#div4").hide();
					}
	        			
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
	        url: '${webRoot}'+"/datastatistics/loadMarketName.do?type=1",
	        dataType: "json",
	        success: function(data){
	        	if(data && data.success){
	        			$.each(data.obj, function(k, v) {
	        				marketName.push(v.marketName);
	        				marketNamenum.push(v.num);
	        				marketNamequalified.push(v.qualified);
	        				marketNameunqualified.push(v.unqualified);
							if (k<10) {
								var bigbang="<tr>"
		            	    		+"<td class='rowNo' style='width:50px;'>"+(k+1)+"</td>"
		                            +"<td>"+v.marketName+"</td>"
		                            +"<td><p class='text-primary'>"+v.num+"</p></td>"
		                            +"<td><p class='text-primary'>"+v.qualified+"</p></td>"
		                            +"<td><p class='text-primary'>"+((v.qualified/v.num)*100).toFixed(2)+"%</p></td>"
		                          	+"</tr>"
		                          	$("#table5 tbody").append(bigbang);
							}
	        			});
	        			marketName.splice(10);
	        			marketNamenum.splice(10);
	        			marketNamequalified.splice(10);
	        			marketNameunqualified.splice(10);
        				bigbang5();
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
	        url: '${webRoot}'+"/datastatistics/loadMarketName.do?type=0",
	        dataType: "json",
	        success: function(data){
	        	if(data && data.success){
	        			$.each(data.obj, function(k, v) {
	        				marketNames.push(v.marketName);
	        				marketNamesnum.push(v.num);
	        				marketNamesqualified.push(v.qualified);
	        				marketNamesunqualified.push(v.unqualified);
							if (k<10) {
								var bigbang="<tr>"
		            	    		+"<td class='rowNo' style='width:50px;'>"+(k+1)+"</td>"
		                            +"<td>"+v.marketName+"</td>"
		                            +"<td><p class='text-primary'>"+v.num+"</p></td>"
		                            +"<td><p class='text-primary'>"+v.unqualified+"</p></td>"
		                            +"<td><p class='text-primary'>"+((v.unqualified/v.num)*100).toFixed(2)+"%</p></td>"
		                          	+"</tr>"
		                          	$("#table6 tbody").append(bigbang);
							}
	        			});
	        			marketNames.splice(10);
	        			marketNamesnum.splice(10);
	        			marketNamesqualified.splice(10);
	        			marketNamesunqualified.splice(10);
        				bigbang6();
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
	        url: '${webRoot}'+"/datastatistics/loadMarketName.do?type=2",
	        dataType: "json",
	        success: function(data){
	        	if(data && data.success){
	        			$.each(data.obj, function(k, v) {
	        				foodName.push(v.foodName);
	        				foodNamenum.push(v.num);
	        				foodNamequalified.push(v.qualified);
	        				foodNameunqualified.push(v.unqualified);
							if (k<10) {
								var bigbang="<tr>"
		            	    		+"<td class='rowNo' style='width:50px;'>"+(k+1)+"</td>"
		                            +"<td>"+v.foodName+"</td>"
		                            +"<td><p class='text-primary'>"+v.num+"</p></td>"
		                            +"<td><p class='text-primary'>"+v.unqualified+"</p></td>"
		                            +"<td><p class='text-primary'>"+((v.unqualified/v.num)*100).toFixed(2)+"%</p></td>"
		                          	+"</tr>"
		                          	$("#table7 tbody").append(bigbang);
							}
	        			});
	        			foodName.splice(10);
	        			foodNamenum.splice(10);
	        			foodNamequalified.splice(10);
	        			foodNameunqualified.splice(10);
        				bigbang7();
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
	        url: '${webRoot}'+"/datastatistics/loadMarketName.do?type=3",
	        dataType: "json",
	        success: function(data){
	        	if(data && data.success){
	        			$.each(data.obj, function(k, v) {
	        				itemName.push(v.itemName);
	        				itemNamenum.push(v.num);
	        				itemNamequalified.push(v.qualified);
	        				itemNameunqualified.push(v.unqualified);
							if (k<10) {
								var bigbang="<tr>"
		            	    		+"<td class='rowNo' style='width:50px;'>"+(k+1)+"</td>"
		                            +"<td>"+v.itemName+"</td>"
		                            +"<td><p class='text-primary'>"+v.num+"</p></td>"
		                            +"<td><p class='text-primary'>"+v.unqualified+"</p></td>"
		                            +"<td><p class='text-primary'>"+((v.unqualified/v.num)*100).toFixed(2)+"%</p></td>"
		                          	+"</tr>"
		                          	$("#table8 tbody").append(bigbang);
							}
	        			});
	        			itemName.splice(10);
	        			itemNamequalified.splice(10);
	        			itemNamenum.splice(10);
	        			itemNameunqualified.splice(10);
        				bigbang8();
	        	}else{
	        		console.log("查询失败");
	        	}
			},
			error: function(){
				console.log("查询失败");
			}
	    });
	});
			var myChart1 = echarts.init(document.getElementById('progress1'),"shine");
		      // 实际开销
		    option1 = {
		    title : {
		        text: '',
		        // subtext: '总数：15000',
		        x:'left',
		        textStyle: {
		        fontSize: 15,
		        padding: 10,                // 标题内边距，单位px，默认各方向内边距为5，       
		        itemGap: 0,               //主副标题纵向间隔，单位px，默认为10，
		        fontWeight: 'bolder',
		        color: '#333'          // 主标题文字颜色
		    },
		    },
		    tooltip : {
		        trigger: 'item',
		        formatter: "{a} <br/>{b} : {c} ({d}%)"
		    },
		    series : [
		        {
		            name: '合格率',
		            type: 'pie',
		            center :['50%', '50%'],
		            radius :"60%",
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
		            data:[
		                {value:checkqualified, name:'合格'},
		                {value:checkunqualified, name:'不合格'}
		                
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
		myChart1.setOption(option1);

	var myChart2 = echarts.init(document.getElementById('progress2'),"shine");
	option2 = {
	  title: {
	        text: '',
	        x:'left',
	        textStyle: {
	        fontSize: 15,
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
	    series : [
	        {
	            name: '不合格处理',
	            type: 'pie',
	            radius :['40%', '60%'],
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
	            data:[
	                {value:treatmentdealed, name:'已处理'},
	                {value:treatmentdeal, name:'待处理'},
	                {value:treatmentdealing, name:'处理中'}
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
	
	function bigbang3() {
		var myChart3 = echarts.init(document.getElementById('progress3'),"shine");
		//var maker=0//0 没有间隔并且不隐藏， 'auto'自动适应；
		option3 = {
		    title: {
		        text: '',
		        x:'left',
		        textStyle: {
		        fontSize: 15,
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
		        left: 'center',
		        data: ['合格','不合格','总数']
		    },
		    grid: {
		        left: '3%',
		        right: '6%',
		        bottom: '15%',
		        top:'12%',
		        containLabel: true
		    },
		    xAxis: {
		        type: 'category',
		        boundaryGap: false,
		        data: dateTime,
		        splitLine: {
		                    show: true
		                          },
		        axisLabel: {
		                     interval: maker, 
		                      rotate: 20, 
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
		            name:'合格',
		            type:'line',
		            stack: '总量1',
		            data:dateTimequalified
		        },
		        {
		            name:'不合格',
		            type:'line',
		            stack: '总量2',
		            data:dateTimeunqualified
		        },
		        {
		            name:'总数',
		            type:'line',
		            stack: '总量',
		            data:dateTimenum
		        }
		    ]
		};
		 // 使用刚指定的配置项和数据显示图表。
		myChart3.setOption(option3);
	} 
	
	function bigbang4() {
		var myChart4 = echarts.init(document.getElementById('progress4'),"shine");

		option4 = {
		  title : {
		        text: '',
		        x:'left',
		        textStyle: {
		        fontSize: 15,
		        padding: 10,                // 标题内边距，单位px，默认各方向内边距为5，       
		        itemGap: 0,               //主副标题纵向间隔，单位px，默认为10，
		        fontWeight: 'bolder',
		        color: '#333'          // 主标题文字颜色
		    }
		    },
		    tooltip : {
		        trigger: 'axis',
		        axisPointer : {            // 坐标轴指示器，坐标轴触发有效
		            type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
		        }
		    },
		    legend: {
		        orient: 'horizontal',
		        left: 'center',
		        data: ['合格','不合格']
		    },
		    grid: {
		        left: '3%',
		        right: '8%',
		        bottom: '10%',
		        top:'12%',
		        containLabel: true
		    },
		    xAxis : [
		        {
		            type : 'category',
		            data : departName,
		            axisLabel: {
		                show:true,
		                interval: 0, //强制所有标签显示
		                align:'right',
		                rotate:20,
		                textStyle: {
		                    color: "#000",
		                    lineHeight:16,
		                },
		                formatter: function (params){ 
		                    var index = 8;
		                    var newstr = '';
		                    for(var i=0;i<params.length;i+=index){
		                        var tmp=params.substring(i, i+index);
		                        newstr+=tmp;
		                    }
		                    if( newstr.length > 8)
		                        return newstr.substring(0,8) + '...';
		                    else
		                        return newstr;
		                },
		            },

		        }
		    ],
		    /* xAxis : [
		        {
		            type : 'category',
		            data : departName,
		            splitLine: {
		                              show: true
		                          },
		            axisLabel: {
		                     interval: 0, 
		                      rotate: -20, 
		                      show: true, 
		                      splitNumber: 15, 
		                      textStyle: {
		                          fontSize: 12
		                      }
		                  }
		        }
		    ], */
		    yAxis : [
		        {
		            type : 'value',
		            axisLabel: {
		                      show: true, 
		                  }
		        }
		    ],
		    series : [
		        {
		            name:'合格',
		            type:'bar',
		            stack: '辖区检测汇总',
		            data:departNamequalified
		        },
		        {
		            name:'不合格',
		            type:'bar',
		            stack: '辖区检测汇总',
		            data:departNameunqualified
		        },{ 
		          name: '合计总量', 
		          type: 'bar', 
		          stack: '辖区检测汇总', 
		          label: { 
		          normal: { 
		          offset:['50', '80'], 
		          show: true, 
		          position: 'insideBottom', 
		          formatter:'{c}', 
		          textStyle:{ color:'#000' } 
		          }
		          }, 
		          itemStyle:{ 
		          normal:{ 
		          color:'rgba(128, 128, 128, 0)' 
		          } 
		          }, 
		          data: departNamenum
		          }
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
		};
		 // 使用刚指定的配置项和数据显示图表。
		myChart4.setOption(option4);
	}
	 
	function bigbang5() {
		var myChart5 = echarts.init(document.getElementById('progress5'),"shine");
		option5 = {
		  title : {
		        text: '',
		        x:'left',
		        textStyle: {
		        fontSize: 15,
		        padding: 10,                // 标题内边距，单位px，默认各方向内边距为5，       
		        itemGap: 0,               //主副标题纵向间隔，单位px，默认为10，
		        fontWeight: 'bolder',
		        color: '#333'          // 主标题文字颜色
		    }
		    },
		    tooltip : {
		        trigger: 'axis',
		        axisPointer : {            // 坐标轴指示器，坐标轴触发有效
		            type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
		        }
		    },
		    legend: {
		        orient: 'horizontal',
		        left: 'center',
		        data: ['合格','不合格']
		    },
		    grid: {
		        left: '3%',
		        right: '8%',
		        bottom: '12%',
		        top:'12%',
		        containLabel: true
		    },
		    xAxis : [
		        {
		            type : 'category',
		            data : marketName,
		            axisLabel: {
		                show:true,
		                interval: 0, //强制所有标签显示
		                align:'right',
		                rotate:20,
		                textStyle: {
		                    color: "#000",
		                    lineHeight:16,
		                },
		                formatter: function (params){ 
		                    var index = 8;
		                    var newstr = '';
		                    for(var i=0;i<params.length;i+=index){
		                        var tmp=params.substring(i, i+index);
		                        newstr+=tmp;
		                    }
		                    if( newstr.length > 8)
		                        return newstr.substring(0,8) + '...';
		                    else
		                        return newstr;
		                },
		            },

		        }
		    ],
		    /* xAxis : [
		        {
		            type : 'category',
		            data : marketName,
		            splitLine: {
		                              show: true
		                          },
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
		    ], */
		    yAxis : [
		        {
		            type : 'value',
		            axisLabel: {
		                     
		                      show: true, 
		                      
		                  }
		        }
		    ],
		    series : [
		        {
		            name:'合格',
		            type:'bar',
		            stack: '高合格率市场',
		            data:marketNamequalified
		        },
		        {
		            name:'不合格',
		            type:'bar',
		            stack: '高合格率市场',
		            data:marketNameunqualified
		        },{ 
		          name: '合计总量', 
		          type: 'bar', 
		          stack: '高合格率市场', 
		          label: { 
		          normal: { 
		          offset:['50', '80'], 
		          show: true, 
		          position: 'insideBottom', 
		          formatter:'{c}', 
		          textStyle:{ color:'#000' } 
		          }
		          }, 
		          itemStyle:{ 
		          normal:{ 
		          color:'rgba(128, 128, 128, 0)' 
		          } 
		          }, 
		          data: marketNamenum
		          }
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
		};
		 // 使用刚指定的配置项和数据显示图表。
		myChart5.setOption(option5);
	}
	
	function bigbang6() {
		var myChart6 = echarts.init(document.getElementById('progress6'),"shine");
		option6 = {
		  title : {
		        text: '',
		        x:'left',
		        textStyle: {
		        fontSize: 15,
		        padding: 10,                // 标题内边距，单位px，默认各方向内边距为5，       
		        itemGap: 0,               //主副标题纵向间隔，单位px，默认为10，
		        fontWeight: 'bolder',
		        color: '#333'          // 主标题文字颜色
		    }
		    },
		    tooltip : {
		        trigger: 'axis',
		        axisPointer : {            // 坐标轴指示器，坐标轴触发有效
		            type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
		        }
		    },
		    legend: {
		        orient: 'horizontal',
		        left: 'center',
		        data: ['合格','不合格']
		    },
		    grid: {
		        left: '3%',
		        right: '8%',
		        bottom: '12%',
		        top:'12%',
		        containLabel: true
		    },
		    xAxis : [
		        {
		            type : 'category',
		            data : marketNames,
		            axisLabel: {
		                show:true,
		                interval: 0, //强制所有标签显示
		                align:'right',
		                rotate:20,
		                textStyle: {
		                    color: "#000",
		                    lineHeight:16,
		                },
		                formatter: function (params){ 
		                    var index = 8;
		                    var newstr = '';
		                    for(var i=0;i<params.length;i+=index){
		                        var tmp=params.substring(i, i+index);
		                        newstr+=tmp;
		                    }
		                    if( newstr.length > 8)
		                        return newstr.substring(0,8) + '...';
		                    else
		                        return newstr;
		                },
		            },

		        }
		    ],
		    /* xAxis : [
		        {
		            type : 'category',
		            data : marketNames,
		            splitLine: {
		                              show: true
		                          },
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
		    ], */
		    yAxis : [
		        {
		            type : 'value',
		            axisLabel: {
		                     
		                      show: true, 
		                      
		                  }
		        }
		    ],
		    series : [
		        {
		            name:'合格',
		            type:'bar',
		            stack: '低合格率市场',
		            data:marketNamesqualified
		        },
		        {
		            name:'不合格',
		            type:'bar',
		            stack: '低合格率市场',
		            data:marketNamesunqualified
		        },{ 
		          name: '合计总量', 
		          type: 'bar', 
		          stack: '低合格率市场', 
		          label: { 
		          normal: { 
		          offset:['50', '80'], 
		          show: true, 
		          position: 'insideBottom', 
		          formatter:'{c}', 
		          textStyle:{ color:'#000' } 
		          }
		          }, 
		          itemStyle:{ 
		          normal:{ 
		          color:'rgba(128, 128, 128, 0)' 
		          } 
		          }, 
		          data: marketNamesnum
		          }
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
		};
		 // 使用刚指定的配置项和数据显示图表。
		myChart6.setOption(option6);
	}
	
	function bigbang7() {
		var myChart7 = echarts.init(document.getElementById('progress7'),"shine");
		option7 = {
		  title : {
		        text: '',
		        x:'left',
		        textStyle: {
		        fontSize: 15,
		        padding: 10,                // 标题内边距，单位px，默认各方向内边距为5，       
		        itemGap: 0,               //主副标题纵向间隔，单位px，默认为10，
		        fontWeight: 'bolder',
		        color: '#333'          // 主标题文字颜色
		    }
		    },
		    tooltip : {
		        trigger: 'axis',
		        axisPointer : {            // 坐标轴指示器，坐标轴触发有效
		            type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
		        }
		    },
		    legend: {
		        orient: 'horizontal',
		        left: 'center',
		        data: ['合格','不合格']
		    },
		    grid: {
		        left: '3%',
		        right: '8%',
		        bottom: '12%',
		        top:'12%',
		        containLabel: true
		    },
		    xAxis : [
		        {
		            type : 'category',
		            data : foodName,
		            axisLabel: {
		                show:true,
		                interval: 0, //强制所有标签显示
		                align:'right',
		                rotate:20,
		                textStyle: {
		                    color: "#000",
		                    lineHeight:16,
		                },
		                formatter: function (params){ 
		                    var index = 8;
		                    var newstr = '';
		                    for(var i=0;i<params.length;i+=index){
		                        var tmp=params.substring(i, i+index);
		                        newstr+=tmp;
		                    }
		                    if( newstr.length > 8)
		                        return newstr.substring(0,8) + '...';
		                    else
		                        return newstr;
		                },
		            },

		        }
		    ],
		    /* xAxis : [
		        {
		            type : 'category',
		            data : foodName,
		            splitLine: {
		                              show: true
		                          },
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
		    ], */
		    yAxis : [
		        {
		            type : 'value',
		            axisLabel: {
		                     
		                      show: true, 
		                      
		                  }
		        }
		    ],
		    series : [
		        {
		            name:'合格',
		            type:'bar',
		            stack: '问题农产品',
		            data:foodNamequalified
		        },
		        {
		            name:'不合格',
		            type:'bar',
		            stack: '问题农产品',
		            data:foodNameunqualified
		        },{ 
		          name: '合计总量', 
		          type: 'bar', 
		          stack: '问题农产品', 
		          label: { 
		          normal: { 
		          offset:['50', '80'], 
		          show: true, 
		          position: 'insideBottom', 
		          formatter:'{c}', 
		          textStyle:{ color:'#000' } 
		          }
		          }, 
		          itemStyle:{ 
		          normal:{ 
		          color:'rgba(128, 128, 128, 0)' 
		          } 
		          }, 
		          data: foodNamenum
		          }
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
		};
		 // 使用刚指定的配置项和数据显示图表。
		myChart7.setOption(option7);
	}
	
	function bigbang8() {
		var myChart8 = echarts.init(document.getElementById('progress8'),"shine");
		option8 = {
		  title : {
		        text: '',
		        x:'left',
		        textStyle: {
		        fontSize: 15,
		        padding: 10,                // 标题内边距，单位px，默认各方向内边距为5，       
		        itemGap: 0,               //主副标题纵向间隔，单位px，默认为10，
		        fontWeight: 'bolder',
		        color: '#333'          // 主标题文字颜色
		    }
		    },
		    tooltip : {
		        trigger: 'axis',
		        axisPointer : {            // 坐标轴指示器，坐标轴触发有效
		            type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
		        }
		    },
		    legend: {
		        orient: 'horizontal',
		        left: 'center',
		        data: ['合格','不合格']
		    },
		    grid: {
		        left: '3%',
		        right: '8%',
		        bottom: '12%',
		        top:'12%',
		        containLabel: true
		    },
		    xAxis : [
		        {
		            type : 'category',
		            data : itemName,
		            axisLabel: {
		                show:true,
		                interval: 0, //强制所有标签显示
		                align:'right',
		                rotate:20,
		                textStyle: {
		                    color: "#000",
		                    lineHeight:16,
		                },
		                formatter: function (params){ 
		                    var index = 8;
		                    var newstr = '';
		                    for(var i=0;i<params.length;i+=index){
		                        var tmp=params.substring(i, i+index);
		                        newstr+=tmp;
		                    }
		                    if( newstr.length > 8)
		                        return newstr.substring(0,8) + '...';
		                    else
		                        return newstr;
		                },
		            },

		        }
		    ],
		    /* xAxis : [
		        {
		            type : 'category',
		            data : itemName,
		            splitLine: {
		                              show: true
		                          },
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
		    ], */
		    yAxis : [
		        {
		            type : 'value',
		            axisLabel: {
		                     
		                      show: true, 
		                      
		                  }
		        }
		    ],
		    series : [
		        {
		            name:'合格',
		            type:'bar',
		            stack: '问题农产品',
		            data:itemNamequalified
		        },
		        {
		            name:'不合格',
		            type:'bar',
		            stack: '问题农产品',
		            data:itemNameunqualified
		        },{ 
		          name: '合计总量', 
		          type: 'bar', 
		          stack: '问题农产品', 
		          label: { 
		          normal: { 
		          offset:['50', '80'], 
		          show: true, 
		          position: 'insideBottom', 
		          formatter:'{c}', 
		          textStyle:{ color:'#000' } 
		          }
		          }, 
		          itemStyle:{ 
		          normal:{ 
		          color:'rgba(128, 128, 128, 0)' 
		          } 
		          }, 
		          data: itemNamenum
		          }
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
		};
		 // 使用刚指定的配置项和数据显示图表。
		myChart8.setOption(option8);
	}
    

</script>
</body>
</html>