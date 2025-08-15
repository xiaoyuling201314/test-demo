<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/common/resource.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>快检服务云平台</title>
<style type="text/css">
</style>
</head>
<body style="background: #eee; padding-top:40px; overflow:hidden;" >
	<div class="cs-col-lg clearfix" style="position: absolute; left: 0; right: 0; top: 0; z-index: 1000;">
		<!-- 面包屑导航栏  开始-->
		<ol class="cs-breadcrumb">
			<li class="cs-fl"><img src="${webRoot}/img/set.png" alt="" /> <a href="javascript:">实时监控</a></li>
			<li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
			<li class="cs-b-active cs-fl">检测分布图</li>
		</ol>
		<div class="cs-fl" style="margin: 3px 0 0 15px;">
			<span class="check-date" style="display: inline;"> 
				<span class="cs-name">时间范围:</span> 
				<span class="cs-in-style cs-time-se cs-time-se">
					<input name="start" id="start" style="width: 110px;" class="cs-time Validform_error" type="text" onclick="WdatePicker()" datatype="date" value="${start}"> 
					<span style="padding: 0 5px;"> 至</span> 
					<input name="end" id="end" style="width: 110px;" class="cs-time Validform_error" type="text" onclick="WdatePicker()" datatype="date" value="${end}">
				</span>
			</span>
			<span> 
				<a href="javascript:" class="cs-menu-btn" style="margin: 0px 0 0 10px;" onclick="query1()"><i class="icon iconfont icon-chakan"></i>查询</a>
			</span>
		</div>
		<div class="cs-search-box cs-fr">
			<div class="cs-fr cs-ac">
				<div class="cs-fr cs-ac">
					<a id="setBtn" href="#myModal-mid" class="cs-menu-btn" data-toggle="modal" data-target="#myModal-md" onclick="getWarn()"><i class="icon iconfont icon-zengjia"></i>异常设置</a>
				</div>
			</div>
		</div>
	</div>
	<!-- Modal 3 小-->
	<form action="${webRoot}/dataCheck/recording/saveWarn" method="post" id="warnForm">
	<div class="modal fade intro2" id="myModal-md" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
		<div class="modal-dialog cs-sm-width" role="document">
			<div class="modal-content ">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
					<h4 class="modal-title" id="myModalLabel">异常设置</h4>
				</div>
				<div class="modal-body cs-alert-height">
					<!-- 主题内容 -->
					<div class="cs-tabcontent" >
						<div class="cs-content2">
							<div class=" cs-warn-box clearfix">
								<!-- <h5 class="cs-title-s">预警设置</h5> -->
								<div class="cs-fl cs-warn-r">
									黄色预警：<input type="text" class="cs-warn cs-warn-yellow" id="yellowLow" name="yellowLow" datatype="num" nullmsg="请输入最低预警值" errormsg="请输入正确的数字" /> 
									- <input type="text" class="cs-warn cs-warn-yellow" id="yellowHigh1" name="yellowHigh" onkeyup="$('#yellowHigh2').val(this.value)"/><i> %</i>
								</div>
								<div class="cs-fl cs-warn-r cs-warn-rh">
									红色预警：大于 <input type="text" class="cs-warn cs-warn-red" id="yellowHigh2" readonly="readonly"/><i> %</i>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-success" onclick="mySubmitWarn();">确定</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				</div>
			</div>
		</div>
	</div>
	</form>

	<!-- 左侧返回按钮 -->
	<div class="cs-map-btn">
		<a onclick="backUpLevel();" id="backBtn" class="btn btn-success" title="返回" style="display: none;"><i class="icon iconfont icon-icon-back"></i>返回</a>
	</div>
	
	<div class="all-layout clearfix" style="width:100%;height:100%;">
		<div class="center-layout" style="width:75%; height: 100%; float:left;">
			<div id="echat-map" style="height:100%;width:auto;" ></div>
		</div>
		<div title="地图信息" class="east-layout" id="eastW" style="width:300px;height:90%; float:right;">
			<div class="infoDiv2">
				<div class="cs-map-tg"><i class="icon iconfont icon-left"></i></div>
				<div class="cs-map-tg2"></div>
				
				<div class="cs-map-name">
					<h5 class="text-primary">
						<span class="infoTitle">地图信息</span>  
					</h5>
				</div>
				<div class="cs-map-info">
					<table class="cs-map-table">
						<thead>
							<tr>
								<th>地区</th>
								<th>抽检数</th>
								<th>不合格数</th>
								<th>不合格率</th>
							</tr>
						</thead>
						<tbody id="tbody">
							
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>

	<script type="text/javascript" src="${webRoot}/plug-in/echarts3-map/static/js/citymap.js"></script>
	<script type="text/javascript" src="${webRoot}/plug-in/echarts3-map/static/js/app1.js"></script>
	<script type="text/javascript">
		var eastWidth = $('#eastW').width();
		
		//地图容器
		var worldMapContainer = document.getElementById('echat-map');
		var level = 0;
		var province = "";
		var city = "";
		var county = "";
		//var region = "";
		var d = [];
		//用于使chart自适应高度和宽度,通过窗体高宽计算容器高宽
		var resizeWorldMapContainer = function () {
			worldMapContainer.style.width = window.innerWidth-eastWidth-5+'px';
			worldMapContainer.style.height = window.innerHeight-70+'px';
		};
		
		var resizeWorldMapContainer2 = function () {
			worldMapContainer.style.width = window.innerWidth+'px';
			worldMapContainer.style.height = window.innerHeight-70+'px';
		};
		//设置容器高宽
		resizeWorldMapContainer();
	
		var chart = echarts.init(worldMapContainer);
		var regionIds = eval("("+'${regionIds}'+")");
		window.onload=query1();
		function query1(){
			if(regionIds.length==1){
				drawProviceMap();
				$("#backBtn").attr('style','display:none');
				level = 1;
				//地图点击事件
				chart.on('click', function(params) {
					if (params.name in provinces) {
						drawCityMap(params.name,d);
						level = 2;
						//region = "中国";
						$("#backBtn").attr('style','display:""');
					} else if (params.seriesName in provinces) {
						//如果是【直辖市/特别行政区】只有二级下钻
						if (special.indexOf(params.seriesName) >= 0) {
							/* drawProviceMap();
							level =1;
							region = "中国";
							$("#backBtn").attr('style','display:none'); */
						} else {
							drawCountyMap(params.name,d);
							level =3;
							province = params.seriesName;
							city = params.name;
							//region = params.seriesName;
							$("#backBtn").attr('style','display:""');
						}
					} else if(params.name in counties ) {
						drawTownMap(params.seriesName,params.name,d);
						level =4;
						county = params.name;
						//region = params.seriesName;
						$("#backBtn").attr('style','display:""');
					} else {
						/* drawProviceMap();
						level =1;
						region = "中国";
						$("#backBtn").attr('style','display:none'); */
					}
				});
			}else if(regionIds.length==2){
				//绘制省市地图
				drawCityMap('${region.regionName}',d);
				$("#backBtn").attr('style','display:none');
				province = '${region.regionName}';
				//地图点击事件
				chart.on('click', function(params) {
					if (params.seriesName in provinces) {
						if (special.indexOf(params.seriesName) >= 0) {
							drawCityMap('${region.regionName}',d);
							$("#backBtn").attr('style','display:none');
						} else {
							drawCountyMap(params.name,d);
							//region = params.seriesName;
							city = params.name;
							level = 3;
							//region = params.seriesName;
							$("#backBtn").attr('style','display:""');
						}
					} else if(params.name in counties ) {
						drawTownMap(params.seriesName,params.name,d);
						county = params.seriesName;
						level = 4;
						$("#backBtn").attr('style','display:""');
					} else {
						//绘制省市地图
						/* drawCityMap('${region.regionName}',d);
						region = '${region.regionName}';
						level = 2;
						$("#backBtn").attr('style','display:none'); */
					} 
				});
			}else if(regionIds.length==3){
				drawCountyMap('${region.regionName}','${region.regionCode}',d);
				$("#backBtn").attr('style','display:none');
			}else if(regionIds.length==4){
			}
		}
		function backUpLevel(){
			if(regionIds.length==1){
				if(level==2){
					drawProviceMap();
					$("#backBtn").attr('style','display:none');
					level=1;
				}else if(level==3){
					drawCityMap(province,d);
					level=2;
				}else if(level==4){
					drawCountyMap(city,d);
					level=3;
				}
			}if(regionIds.length==2){
				if(level==3){
					drawCityMap(province,d);
					level=2;
					$("#backBtn").attr('style','display:none');
				}else if(level==4){
					level=3;
					drawCountyMap(city,d);
				}
			}if(regionIds.length==3){
				
			}if(regionIds.length==4){
				
			}
		}
		//绘制国-省地图
		function drawProviceMap() {
			$.getJSON('${webRoot}/plug-in/echarts3-map/static/map/china.json', function(data) {
				var rows;
				d = [];
				query(1,"中国",1,data,d);
				mapdata = d;
				//注册地图
				echarts.registerMap('china', data);
				//绘制地图
				renderMap('china',"中国", d);
			});
		}
		//绘制省-市地图
		function drawCityMap(provinceName,d){
			//如果点击的是34个省、市、自治区，绘制选中地区的二级地图
			$.getJSON('${webRoot}/plug-in/echarts3-map/static/map/province/' + provinces[provinceName] + '.json', function(data) {
				echarts.registerMap(provinceName, data);
				d = [];
				query(null,provinceName,2,data,d);
				renderMap(provinceName,provinceName, d);
			});
		}
		//绘制市-县地图
		function drawCountyMap(cityName,d){
			//绘制市-县地图
			$.getJSON('${webRoot}/plug-in/echarts3-map/static/map/city/'+cityMap[cityName]+'.json', function(data) {
				echarts.registerMap(cityName, data);
				d = [];
				query(null,cityName,3,data,d);
				renderMap(cityName,cityName, d);
			});
		}
		//绘制县-镇 地图
		function drawTownMap(seriesName,countyName,d){
			if(seriesName=='西安市'){
				$.getJSON('${webRoot}/plug-in/echarts3-map/static/map/county/changan.json', function(data){
					echarts.registerMap(countyName, data);
					var d = [];
					query(null,countyName,4,data,d);
					renderMap(countyName,countyName,d);
				});
			}
		}
		
		function query(regionId,regionName,level,data1,d){
			$.ajax({
				url:'${webRoot}/dataCheck/recording/getWarn.do',
				async:false,
				success:function(data){
					option.visualMap.pieces[0]={min:data.yellow_high};
					option.visualMap.pieces[1]={min:data.yellow_low,max:data.yellow_high};
					option.visualMap.pieces[2]={max:data.yellow_low};
				}
			});
			chart.clear();
			var start = $("#start").val();
			var end = $("#end").val();
			$.ajax({
				url:'${webRoot}/dataCheck/recording/checkDistributionData',
				data:{regionId:regionId,regionName:regionName,start:start,end:end,level:level},
				async:false,
				success:function(data){
					chart = echarts.init(worldMapContainer);
					chart.clear();
					dealMapData(data.obj,data1,d)
				}
			});
		}
		
		function dealMapData(rows,data,d) {
			$("#tbody").empty();
			var html = "";
			for (var j = 0; j < rows.length; j++) {
				var unqual = rows[j].unqualCount==undefined?0:rows[j].unqualCount;//不合格数量
				var count = rows[j].count==undefined?0:rows[j].count;//数量
				var avg ;
				if(count==0){
					avg = "-";
				}else{
					avg = (unqual/count*100).toFixed(2);
				}
				html += "<tr><td>"+rows[j].regionName+"</td>";
				html += "<td>"+count+"</td>";
				html += "<td>"+unqual+"</td>";
				if(count==0){
					html += "<td>-</td></tr>";
				}else{
					html += "<td>"+avg+"%</td></tr>";
				}
			}
			for( var i=0;i<data.features.length;i++ ){
				var p = data.features[i].properties;
				for (var j = 0; j < rows.length; j++) {
					if(p.name==rows[j].regionName){
						var unqual = rows[j].unqualCount==undefined?0:rows[j].unqualCount;//不合格数量
						var count = rows[j].count==undefined?0:rows[j].count;//数量
						var avg ;
						if(count==0){
							avg = "-";
						}else{
							avg = (unqual/count*100).toFixed(2);
						}
						d.push({
							name:p.name,
							value:avg,
							count:count,
							unqual:unqual
						});
					}
				} 
			}
			$("#tbody").html(html);
			mapdata = d;
		}
		window.onresize = function () {
			//重置容器高宽
			resizeWorldMapContainer();
			chart.resize();
		};
		
		function getWarn(){
			$.ajax({
				url:'${webRoot}/dataCheck/recording/getWarn.do',
				async:false,
				success:function(data){
					$("#yellowLow").val(data.yellow_low);
					$("#yellowHigh1").val(data.yellow_high);
					$("#yellowHigh2").val(data.yellow_high);
				}
			});
		}
		var warnValidform = $("#warnForm").Validform({
			tiptype:2,
			label:".label",
			showAllError:true,
			beforeSubmit:function(curform){
				var high = $("#yellowHigh1").val();
				var low = $("#yellowLow").val();
				if(parseInt(high)<parseInt(low)){
					alert("上限值不能小于下限值");
					return false;
				}
			},
			callback:function(data){
				if(data.success){
					$("#myModal-md").modal('hide');
					$.Hidemsg();
					self.location.reload();
				}else{
					$.Showmsg(data.msg);
				}
			}
		});
		function mySubmitWarn(){
			warnValidform.ajaxPost();
		}
		
		var hideTime = 1;
		$(document).on('click','.cs-map-tg',function(){
			if(hideTime){
			$('.center-layout').css('width','100%');
			$('.east-layout').css('marginRight','-300');
			$('.icon-right').removeClass('icon-right').addClass('icon-left');
			resizeWorldMapContainer2();
			chart.resize();
			//用于使chart自适应高度和宽度
			window.onresize = function () {
				//重置容器高宽
				resizeWorldMapContainer2();
				chart.resize();
			};
			hideTime = 0;
			}else{
				/* $('.cs-map-tg,.cs-map-tg2').css({'marginRight':'0'}); */
				$('.center-layout').css('width','75%');
				$('.east-layout').css('marginRight','0');
				$('.icon-left').removeClass('icon-left').addClass('icon-right');
				resizeWorldMapContainer();
				chart.resize();
				//用于使chart自适应高度和宽度
				window.onresize = function () {
					//重置容器高宽
					resizeWorldMapContainer();
					chart.resize();
				};
				hideTime = 1;	
			}
		});
		/* $(document).ready(function(){
			var center = $('.center-layout').width();
			var east = $('.east-layout').width();
			var math = center-east
			$('.center-layout').css('width',math);
		}) */
	</script>

</body>
</html>
