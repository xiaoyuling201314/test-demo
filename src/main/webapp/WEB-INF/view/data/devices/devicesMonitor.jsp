<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/common/resource.jsp"%>
<html>
  <head>
  	<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <%--<meta http-equiv="X-UA-Compatible" content="IE=7"></meta>--%>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <title>快检服务云平台</title>
    <style type="text/css">
		#allmap {width: 100%;height: 100%;overflow: hidden;margin:0;font-family:"微软雅黑";}
		iframe{
        width:100%;
        height: 100%;
        position: absolute;
        right:0;
        left: 0;
        top:0px;
        bottom: 0;
        border:0;
        border:none;
      }
      .cs-search-box{
      	position:absolute;
      	right:0px;
      	top:0px;
      	z-index:1000;
      }
	</style>
  </head>
  
  <script type="text/javascript" src="https://api.map.baidu.com/api?v=2.0&ak=3VcDe6wDBzTnPp718D2O49QxfByP7e0W&s=1"></script>
  <body>
  	<div class="cs-col-lg clearfix" style="position:absolute; left:0; right:0; top:0; z-index:1000;">
          <!-- 面包屑导航栏  开始-->
            <ol class="cs-breadcrumb">
              <li class="cs-fl">
              <img src="${webRoot}/img/set.png" alt="" />
              <a href="javascript:">项目管理</a></li>
              <li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
              <li class="cs-b-active cs-fl">实时监控
              </li>
              </ol>
			</div>
		
		    
	<div id="allmap" style="left:0; right:0; top:40;"></div>
	
	<!-- 右侧信息栏（一级） -->
	<div class="cs-hide infoDiv">
		<div class="cs-map-tg"><i class="icon iconfont icon-right"></i></div>
		<div class="cs-map-tg2"></div>
		<div class="cs-map-name">
			<h5 class="text-primary">
				<span class="infoTitle">仪器监控</span>  
			</h5>
		</div>
		<div class="cs-map-info cs-map-infos">
			<div class="cs-stat-box clearfix col-sm-12 col-md-12">
                <div class="cs-stat-child cs-stat-child2 cs-stat-selected clearfix" data-type="devices">
                  <div class="cs-stat-jigou pull-left"><i class="icon iconfont icon-yiqi"></i></div>
                  <div class="pull-left">
                    <p class="cs-type">检测仪器</p>
                    <p class="text-muted departcount">
                    	<c:if test="${empty devices || fn:length(devices) eq 0}"> 0 </c:if>
                    	<c:if test="${!empty devices && fn:length(devices) gt 0}"> ${fn:length(devices)} </c:if>
                    	个</p>
                  </div>
                </div>
                
                <div class="cs-stat-child cs-stat-child2 clearfix" data-type="points">
                  <div class="cs-stat-jiance pull-left"><i class="icon iconfont icon-loupan"></i></div>
                  <div class="pull-left">
                    <p class="cs-type">实验室</p>
                    <p class="text-muted pointcount">
                    	<c:if test="${empty points || fn:length(points) eq 0}"> 0 </c:if>
                    	<c:if test="${!empty points && fn:length(points) gt 0}"> ${fn:length(points)} </c:if>
                    	个</p>
                  </div>
                </div>
            </div>
            
            <ul class="cs-map-ul cs-mechanism-ul cs-mechanism-ul2 cs-machine1 clearfix col-md-12 col-sm-12"></ul>
            
            <div class="search-result search-result2 clearfix">
	            <div class="cs-bottom-nav cs-pagination cs-pagination2" id="Pointpage">
	            	<ul class="cs-pagination cs-fr">
	            		<li class="cs-distan">共<span id="page"></span>页/<span id="rows"></span>条记录</li>
	            		<li class="cs-b-nav-btn cs-distan cs-selcet"></li>
	            		<li class="cs-disabled cs-distan"><a class="cs-b-nav-btn" onclick="beforePage();">&lt;</a></li>
	            		<li><a class="cs-b-nav-btn cs-n-active" id="pageNo">1</a></li>
	            		<li class="cs-next"><a class="cs-b-nav-btn" onclick="nextPage();">&gt;</a></li>
	            	</ul>
	            </div>
            </div>
		</div>
	</div>


	<!-- 大弹窗 -->
	<div class="cs-modal-box cs-hide">
		<div class="cs-search-box cs-fr">
			<div class="cs-fr cs-ac ">
				<a href="javascript:" class="cs-monitor-close cs-menu-btn"><i class="icon iconfont icon-fanhui"></i>返回</a>
			</div>
		</div>
		<iframe id="iframe1"></iframe>
	</div>

	<!-- JavaScript -->
	<script type="text/javascript">
		var g_devices = "${devices}";
		var g_points = "${points}";
		
		$(function(){
			loading(1);
		});
		
		var data_type = "devices";
		
		$('.cs-stat-child').click(function(){
	         $(this).addClass('cs-stat-selected').siblings().removeClass('cs-stat-selected');
	         
	         if($(this).attr("data-type")){
	        	 data_type = $(this).attr("data-type");
	         }
	         loading(1);
	         pageNo = 1;
		});
		
		//上一页
		function beforePage(){
			pageNo = (pageNo - 1) < 1 ? 1 : pageNo - 1;
			loading(pageNo);
		}
		//下一页
		function nextPage(){
			pageNo += 1;
			loading(pageNo);
		}
		
		
		var pageNo = 1;
		
		var data_info = [];	//定位数据
		var marker_arr = []; //地图marker
		function loading(_page){
			/* 
			var _data;
			switch (data_type) {
			case "devices":
				_data = g_devices;
				break;
				
			case "points":
				_data = g_points;
				break;

			default:
				return;
			}
			 
			var rowTotal = _data.length;		//记录总数
			var maxRows = 20;		//每页数量
			var pageCount = Math.ceil(rowTotal % maxRows);		//总页数
			var rowOffset = (_page - 1) * maxRows + 1;	//当前页起始记录(从1开始读取)
			var rowTail = _page * maxRows;		//当前页结束的记录(从1开始读取)
    		
			if(rowTail >= rowTotal){
				_data = _data.slice(rowOffset,);
			}else{
				_data = _data.slice(rowOffset,rowTail);
			}
			*/
			
			$.ajax({
    	        type: "POST",
    	        url: "${webRoot}/data/devices/monitorData",
    	        dataType: "json",
    	        success: function(data){
    	        	if(data){
    	        		data_info = [];
    	        		marker_arr = [];
    	        		
    	        		var infoTitle = "";
    	        		var infoUl = "";
    	        		
    	        		if(data_type == "devices"){
	    	        		var _data = data.devices;	//仪器
	    	        		var rowTotal = _data.length;		//记录总数
	    	    			var maxRows = 20;		//每页数量
	    	    			var pageCount = Math.ceil(rowTotal / maxRows);		//总页数
	    	    			_page = _page > pageCount ? pageCount : _page;
	    	    			var rowOffset = (_page - 1) * maxRows;	//当前页起始记录(从0开始读取)
	    	    			var rowTail = _page * maxRows;		//当前页结束的记录(从0开始读取)
	    	        		
	    	    			if(rowTail >= rowTotal){
	    	    				_data = _data.slice(rowOffset);
	    	    				pageNo = _page;
	    	    			}else{
	    	    				_data = _data.slice(rowOffset, rowTail);
	    	    			}
	    	    			
	    	    			$("#page").text(pageCount);
	    	    			$("#rows").text(rowTotal);
	    	    			$("#pageNo").text(pageNo);
	    	    			
    	            		infoTitle = "检测仪器";
    	           			for(var i=0;i<_data.length;i++){
    	           				if(_data[i].place_x && _data[i].place_y){
    	        	        		var mlp = [];
    	            				mlp[0] = _data[i].place_x;	//经度
    	            				mlp[1] = _data[i].place_y;	//纬度
    	            				if(_data[i].status == 0){ //启用仪器
	    	            				mlp[2] = "<p style='font-size:16px;margin:0;line-height:1.5;font-weight:bold; color:#168ee6;'>"+_data[i].device_name+"</p>"+	
	    	            							"<p style='margin:0;line-height:1.5;'>仪器编码："+_data[i].device_code+"</p>";
	    	            				mlp[3] = "${webRoot}/img/points/yiqi2.png";	//图标
    	            				}else{	//停用仪器
    	            					mlp[2] = "<p style='font-size:16px;margin:0;line-height:1.5;font-weight:bold; color:#168ee6;'>"+_data[i].device_name+"</p>"+	
            							"<p style='margin:0;line-height:1.5;'>仪器编码："+_data[i].device_code+"</p>";
            							mlp[3] = "${webRoot}/img/points/yiqi1.png";	//图标
    	            				}
    	            				mlp[4] = {"deviceId":_data[i].id};	//自定义属性-仪器ID
    	            				data_info.push(mlp);
    	            				
    	            				if(_data[i].status == 0){ //启用仪器
    	            					infoUl += "<li class=\"clearfix\" onclick=\"mapPanTo('"+_data[i].place_x+"','"+_data[i].place_y+"');\"><div class=\"cs-fl\"><i class=\"local-bg local-bg3\">"+(i+1)+"</i></div>"+
        	       						"<p class=\"col-md-8 col-xs-8\"><i>仪器名称：</i><span class=\"text-primary\">"+_data[i].device_name+"</span></p>"+
        	       						"<p class=\"col-md-10 col-xs-10\"><i>仪器编码：</i><span class=\"text-muted\">"+_data[i].device_code+"</span></p></li>";    	            					
    	            				}else{	//停用仪器
    	            					infoUl += "<li class=\"clearfix shut-down\" onclick=\"mapPanTo('"+_data[i].place_x+"','"+_data[i].place_y+"');\"><div class=\"cs-fl\"><i class=\"local-bg\">"+(i+1)+"</i></div>"+
        	       						"<p class=\"col-md-8 col-xs-8\"><i>仪器名称：</i><span class=\"text-primary\">"+_data[i].device_name+"</span></p>"+
        	       						"<p class=\"col-md-10 col-xs-10\"><i>仪器编码：</i><span class=\"text-muted\">"+_data[i].device_code+"</span></p></li>";
    	            				}
    	       	        		}
    	           			}
    	           			
    	           		}else if(data_type == "points"){
    	            		var _data = data.points;	//实验室
	    	        		var rowTotal = _data.length;		//记录总数
	    	    			var maxRows = 20;		//每页数量
	    	    			var pageCount = Math.ceil(rowTotal / maxRows);		//总页数
	    	    			_page = _page > pageCount ? pageCount : _page;
	    	    			var rowOffset = (_page - 1) * maxRows;	//当前页起始记录(从0开始读取)
	    	    			var rowTail = _page * maxRows;		//当前页结束的记录(从0开始读取)
	    	        		
	    	    			if(rowTail >= rowTotal){
	    	    				_data = _data.slice(rowOffset);
	    	    				pageNo = _page;
	    	    			}else{
	    	    				_data = _data.slice(rowOffset, rowTail);
	    	    			}
	    	    			
	    	    			$("#page").text(pageCount);
	    	    			$("#rows").text(rowTotal);
	    	    			$("#pageNo").text(pageNo);
	    	    			
    	            		infoTitle = "实验室";
    	           			for(var i=0;i<_data.length;i++){
    	           				if(_data[i].place_x && _data[i].place_y){
    	        	        		var mlp = [];
    	            				mlp[0] = _data[i].place_x;	//经度
    	            				mlp[1] = _data[i].place_y;	//纬度
    	            				mlp[2] = "<p style='font-size:16px;margin:0;line-height:1.5;font-weight:bold; color:#168ee6;'>"+_data[i].point_name+"</p>";
    	            				var pdcs = _data[i].point_devices_code.split(",");
    	            				$.each(pdcs, function(index,element){
    	            					mlp[2] += "<p style='margin:0;line-height:1.5;'>仪器编码"+(index+1)+"："+element+"</p>";
    	            				});
    	            				mlp[3] = "${webRoot}/img/points/point1.png";	//图标
    	            				mlp[4] = {"pointId":_data[i].id};	//自定义属性-仪器ID
    	            				data_info.push(mlp);
    	            				
    	            				infoUl += "<li class=\"clearfix\" onclick=\"mapPanTo('"+_data[i].place_x+"','"+_data[i].place_y+"');\"><div class=\"cs-fl\"><i class=\"local-bg\">"+(i+1)+"</i></div>"+
    	       						"<p class=\"col-md-8 col-xs-8\"><i>实验室：</i><span class=\"text-primary\">"+_data[i].point_name+"</span></p>"+
    	       						"<p class=\"col-md-10 col-xs-10\"><i>仪器数量：</i><span class=\"text-muted\">"+_data[i].device_num+"</span></p></li>";
    	       	        		}
    	           			}
    	           		}
    	        		
    	        		$(".infoDiv:eq(0) .cs-map-ul").html(infoUl);
    	        		$(".infoDiv:eq(0) .cs-map-ul li").each(function(){	//修改序号
    	        			$(this).find(".local-bg").text(($(this).index()+1));
    	        		});
    	        		
    	        		$(".infoDiv:eq(0)").show();//显示右侧信息栏（一级）
    	        		setMapPoint();//在地图上标记定位
    	        	}
    			}
    	    });
			
    		/* 
    		var infoTitle = "";
    		var infoUl = "";
    		
       		if(data_type == "devices"){
        		infoTitle = "检测仪器";
       			for(var i=0;i<_data.length;i++){
       				console.log(_data[i].place_x + ";" + _data[i].place_y);
       				if(_data[i].place_x && _data[i].place_y){
    	        		var mlp = new Array();
        				mlp[0] = _data[i].place_x;	//经度
        				mlp[1] = _data[i].place_y;	//纬度
        				mlp[2] = "<p style='font-size:16px;margin:0;line-height:1.5;font-weight:bold; color:#168ee6;'>"+_data[i].device_name+"</p>"+	
        							"<p style='margin:0;line-height:1.5;'>编码："+_data[i].device_code+"</p>";
        				mlp[3] = "${webRoot}/img/points/5.png";	//图标
        				mlp[4] = {"deviceId":_data[i].id};	//自定义属性-仪器ID
        				data_info.push(mlp);
        				
        				infoUl += "<li class=\"clearfix\"><div class=\"cs-fl\"><i class=\"local-bg\">"+(i+1)+"</i></div>"+
   						"<p class=\"col-md-8 col-xs-8\"><i>仪器名称：</i><span class=\"text-primary\">"+_data[i].device_name+"</span></p>"+
   						"<p class=\"col-md-10 col-xs-10\"><i>仪器编码：</i><span class=\"text-muted\">"+_data[i].device_code+"</span></p></li>";
   	        		}
       			}
       		}else if(data_type == "points"){
        		infoTitle = "实验室";
       			for(var i=0;i<points.length;i++){
       				if(points[i].placeX && points[i].placeY){
    	        		var mlp = new Array();
        				mlp[0] = points[i].placeX;	//经度
        				mlp[1] = points[i].placeY;	//纬度
        				mlp[2] = "<p style='font-size:16px;margin:0;line-height:1.5;font-weight:bold; color:#168ee6;'>"+points[i].pointName+"</p>"+	//定位信息
        							"<p style='margin:0;line-height:1.5;'>地址："+points[i].address+"</p>";
        				mlp[3] = "${webRoot}/img/points/5.png";	//图标
        				mlp[4] = {"pointId":points[i].id};	//自定义属性-检测点ID
        				data_info.push(mlp);
        				
        				infoUl += "<li class=\"clearfix\"><div class=\"cs-fl\"><i class=\"local-bg\">"+(i+1)+"</i></div>"+
   						"<p class=\"col-md-8 col-xs-8\"><i>检测点：</i><span class=\"text-primary\">"+points[i].pointName+"</span></p>"+
   						"<p class=\"col-md-10 col-xs-10\"><i>地址：</i><span class=\"text-muted\">"+points[i].address+"</span></p></li>";
   	        		}
       			}
       		}
    		
    		$(".infoDiv:eq(0) .cs-map-ul").html(infoUl);
    		$(".infoDiv:eq(0) .cs-map-ul li").each(function(){	//修改序号
    			$(this).find(".local-bg").text(($(this).index()+1));
    		});
    		
    		$(".infoDiv:eq(0)").show();//显示右侧信息栏（一级）
    		setMapPoint();//在地图上标记定位
			 */
    		
			/* 
			$.ajax({
    	        type: "POST",
    	        url: "${webRoot}/monitor/getLocations.do",
    	        data: {"signDate": $("input[name='signDate']").val()},
    	        dataType: "json",
    	        success: function(data){
    	        	if(data && data.success){
    	        		data_info = new Array();
    	        		marker_arr = new Array();
    	        		
    	        		var infoTitle = "";
    	        		var infoUl = "";
    	        		$('input[name="lti"]:checked').each(function(){
    	        			
	    	        		var points = data.obj.points;	//检测点
	    	        		if(points && $(this).val() == "1"){
		    	        		infoTitle = "检测点";
	    	        			for(var i=0;i<points.length;i++){
	    	        				if(points[i].placeX && points[i].placeY){
				    	        		var mlp = new Array();
		    	        				mlp[0] = points[i].placeX;	//经度
		    	        				mlp[1] = points[i].placeY;	//纬度
		    	        				mlp[2] = "<p style='font-size:16px;margin:0;line-height:1.5;font-weight:bold; color:#168ee6;'>"+points[i].pointName+"</p>"+	//定位信息
		    	        							"<p style='margin:0;line-height:1.5;'>地址："+points[i].address+"</p>";	
		    	        				mlp[3] = "${webRoot}/img/points/5.png";	//图标
		    	        				mlp[4] = {"pointId":points[i].id};	//自定义属性-检测点ID
		    	        				data_info.push(mlp);
		    	        				
		    	        				infoUl += "<li class=\"clearfix\"><div class=\"cs-fl\"><i class=\"local-bg\">"+(i+1)+"</i></div>"+
    	        						"<p class=\"col-md-8 col-xs-8\"><i>检测点：</i><span class=\"text-primary\">"+points[i].pointName+"</span></p>"+
    	        						"<p class=\"col-md-10 col-xs-10\"><i>地址：</i><span class=\"text-muted\">"+points[i].address+"</span></p></li>";
			    	        		}
	    	        			}
	    	        		}
	    	        		
    	        		});
    	        		
    	        		$(".infoDiv:eq(0) .cs-map-ul").html(infoUl);
    	        		$(".infoDiv:eq(0) .cs-map-ul li").each(function(){	//修改序号
    	        			$(this).find(".local-bg").text(($(this).index()+1));
    	        		});
    	        		
    	        		$(".infoDiv:eq(0)").show();//显示右侧信息栏（一级）
    	        		setMapPoint();//在地图上标记定位
    	        	}
    			}
    	    });
    		 */
    		
		}
	
	
		var map = new BMap.Map("allmap");    // 创建Map实例
		//添加地图类型控件
		map.addControl(new BMap.MapTypeControl({
			mapTypes:[
				BMAP_NORMAL_MAP,
				BMAP_HYBRID_MAP
			]
		}));
		
		var top_left_control = new BMap.ScaleControl({anchor: BMAP_ANCHOR_TOP_LEFT});// 左上角，添加比例尺
		var top_left_navigation = new BMap.NavigationControl();  //左上角，添加默认缩放平移控件
		map.addControl(top_left_control);        
		map.addControl(top_left_navigation);   
		
		map.enableScrollWheelZoom(true);     //开启鼠标滚轮缩放
		
		var opts = {
				width : 250,     // 信息窗口宽度
				height: 90,     // 信息窗口高度
				title : "" , // 信息窗口标题
				enableMessage:true//设置允许信息窗发送短息
			   };
		
		function mapPanTo(x,y){
			map.panTo(new BMap.Point(x, y));
		}
		
		function setMapPoint(){
			map.clearOverlays();//清除覆盖物
			marker_arr = [];
			
			if(data_info.length==0){
				map.centerAndZoom("广州",12);      // 初始化地图,设置地图中心点
			}
			
			for(var i=0;i<data_info.length;i++){
				var po = new BMap.Point(data_info[i][0],data_info[i][1]);	
				if(i==0){
					map.centerAndZoom(po,15);      // 初始化地图,设置地图中心点
				}
				
				
				var marker = new BMap.Marker(po);
				marker.setIcon(new BMap.Icon(data_info[i][3], new BMap.Size(46,57)));
				var label = new BMap.Label( (i+1) ,{offset:new BMap.Size( 32-((((i+1)+"").length-1)*3), 1 )});
				label.setStyle({background:'none',color:'#fff',border:'none',fontSize:'12px',fontWeight:'bold'});
				marker.setLabel(label);

				//var myIcon = new BMap.Icon(data_info[i][3], new BMap.Size(48,48));
				//var marker = new BMap.Marker(po, {icon:myIcon});  // 创建标注
				marker.myAttributes = data_info[i][4];	//自定义属性
				
				var content = data_info[i][2];		//标注提示内容
				map.addOverlay(marker);               // 将标注添加到地图中
				addClickHandler(content,marker);	//标注添加事件
				marker_arr.push(marker);
			}
		}
		
		//标注添加事件
		function addClickHandler(content,marker){
			marker.addEventListener("click",function(e){
				openInfo(content,e,marker);
			});
		}
		
		//创建打开信息窗口
		var searchDate = '';
		var searchUserId = '';
		var searchPointId = '';
		var searchRegId = '';
		function openInfo(content,e,marker){
			var p = e.target;
			var point = new BMap.Point(p.getPosition().lng, p.getPosition().lat);
			var infoWindow = new BMap.InfoWindow(content,opts);  // 创建信息窗口对象 
			map.openInfoWindow(infoWindow,point); //开启信息窗口
		}
		
		//关闭检测数据
		$(document).on('click','.cs-monitor-close',function(){
			$('.cs-modal-box').hide();
		});
		
		//关闭弹出窗
		$(document).on('click','.cs-close-btn',function(){
			closeInfo();
		});
		//关闭弹出窗
		function closeInfo(){
			searchUserId = '';//清空查询条件
			$('.signInfo').hide();//关闭右侧信息栏
			loading();//重新查询监控数据
		}
		
		var winH= $(window).height();
		$('#allmap').height(winH-45);
		var hideTime = 1;
		$(document).on('click','.cs-map-tg,.cs-map-tg2',function(){
			if(hideTime){
			$('.cs-map-info,.cs-map-name,.cs-map-tg,.cs-map-tg2').animate({'marginRight':'-346px'});
			$('.cs-map-info,.cs-map-name').hide(200);
			$('.icon-right').removeClass('icon-right').addClass('icon-left');
			$('#allmap').height(winH-45);
			hideTime = 0;
			}else{
				$('.cs-map-info,.cs-map-name,.cs-map-tg,.cs-map-tg2').animate({'marginRight':'0'});
				$('.cs-map-info,.cs-map-name').show();
				$('.icon-left').removeClass('icon-left').addClass('icon-right');
				$('#allmap').height(winH-45);
				hideTime = 1;	
			}
		});
		
	function fmtDate(obj){
	    var date =  new Date(obj);
	    var y = 1900+date.getYear();
	    var m = (date.getMonth()+1)<10?("0"+(date.getMonth()+1)):(date.getMonth()+1);
	    var d = date.getDate()<10?("0"+date.getDate()):date.getDate();
	    var h = date.getHours()<10?("0"+date.getHours()):date.getHours();
	    var mm = date.getMinutes()<10?("0"+date.getMinutes()):date.getMinutes();
	    var ss = date.getSeconds()<10?("0"+date.getSeconds()):date.getSeconds();
	    return y+"-"+m+"-"+d+" "+h+":"+mm+":"+ss;
	}
	
	</script>
  </body>
</html>
