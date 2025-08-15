$(function() {
//	var date=new Date();
//	$(".datepicker").datepicker({
//		language:'zh-CN',
//		format : 'yyyy-mm-dd',
//		autoclose : true,
//		todayHighlight : true ,
//		endDate:date//结束时间，在这时间之后都不可选
//	});
////	$(".datepicker").datepicker("setDate",new Date());
//	var yy = date.getFullYear();
//	var mm = date.getMonth() + 1+"";
//	var dd = date.getDate()+"";
//	if(mm.length<2){
//		mm="0"+mm;
//	}
//	if(dd.length<2){
//		dd="0"+dd;
//	}
//	$("[name=startTime]").val(yy+"-"+mm+"-"+dd);//设置默认时间
	queryById($("[name=id]").val());// 加载最后定位位置
	$("#replayDate").combobox({
		url:rootPath+'queryGroupDateByCarImei.do?carImei='+$("[name=carImei]").val(),
		valueField:'id',
		textField:'showDate',
		multiple: false,//允许在下拉列表里多选
      	onSelect:function(record){
      		//选择日期后关闭下拉选项框
      		 if ($(".combo").prev().combobox("panel").is(":visible")) {
      			$(".combo").prev().combobox("hidePanel");
         	  } else {
         		 $(".combo").prev().combobox("showPanel");
         	  }	 	   
		},
		onLoadSuccess:function(){
			//在数据加载成功后绑定事件
			$(".combo").click(function(event){
			 	if(event.target.tagName == "A"){//判断是否为点击右侧倒三角形
					  return false;
				     }
				//点击输入框框显示下拉列表
				if ($(this).prev().combobox("panel").is(":visible") && event.target.tagName != "INPUT") {
	      			$(this).prev().combobox("hidePanel");
	         	  } else {
	         		 $(this).prev().combobox("showPanel");
	         	  }	 
			});
		}
	}); 
});

var locationArray = [];
var myPoint;
var driverSpeed = 10;
var dataSource=[];//保存路线时间
var label =null;
var i=0;
var carMk ;
var ptsArray=[];
var viewList=[];
var timet;
var stopList=[];//保存停车位置信息
var listRegulaList=[];
function reloadData() {
	clearTimeout(timet);
	i = 0;
	carMk;
	ptsArray = [];
	viewList = [];
	dataSource=[];
	locationArray=[];
	var regulaArrayList=[];
	var startDate=$("#replayDate").val();
	var startTime=$("[name=startTime]").val();
	var endTime=$("[name=endTime]").val();
	if(startDate==""){
		startDate=new Date().format("yyyy-MM-dd");
		$("#replayDate").combobox('setValue', startDate);
	}
	if(startTime==""){
		startTime="00:01:00";
		$("[name=startTime]").val(startTime)
	}
	if(endTime==""){
		endTime="23:59:59";
		$("[name=endTime]").val(endTime)
	}
	startTime=startDate+" "+startTime;
	endTime=startDate+" "+endTime;
	$.ajax({
		url : rootPath+"replayDataList.do",
    	type:"POST",
    	data:{"carImei":$("[name=carImei]").val(),"startTime":startTime,"endTime":endTime},
    	dataType:"json",
    	success : function(data) {
			for (var i = 0; i < data.obj.length; i++) {
				myPoint = new BMap.Point(data.obj[i].longitude, data.obj[i].latitude)
				locationArray.push(myPoint);
				dataSource.push(data.obj[i]);
			}
			stopList=data.attributes.stopList;
			listRegulaList=data.attributes.listRegula;
			if (data.obj.length > 0 && locationArray.length>2) {
				$("#stopOrReplay").val("暂停")
				map.clearOverlays(); // 清除地图上所有的覆盖物
				driveLine();// 加载路线
			}
			if(locationArray.length < 2){
				alert("该时间段无行驶记录");
			}
		},
    	error:function(){
    		alert("操作失败");
    	}
    	});
}

driveLine = function() {
//	var driving = new BMap.DrivingRoute(map); // 创建驾车实例
	if (locationArray.length < 2) {
		alert("该时间段无行驶记录");
		return;
	} else{
		map.clearOverlays(); // 清除地图上所有的覆盖物
		var new_point = new BMap.Point(locationArray[0].lng, locationArray[0].lat);
		map.panTo(new_point);
		var m1 = new BMap.Marker(locationArray[0], {
			icon : myStartIcon
		});
		map.addOverlay(m1);
		m1 = new BMap.Marker(locationArray[locationArray.length - 1], {
			icon : myEndIcon
		});
		map.addOverlay(m1);
		carMk = new BMap.Marker(locationArray[0], {
			icon : myIcon
		});
		map.addOverlay(carMk);
	}
	setTimeout(driveCallBack(), 500);
	if (locationArray.length == 2) {
		carMk = new BMap.Marker(locationArray[1], {
			icon : myIcon
		});
		map.addOverlay(carMk);
	}
}
function driveCallBack() {
	if(carMk!= undefined){
		carMk.remove();
	}
	var polyline;
	var poliy=[];
	var count=0;
	if(i==0){
		count=locationArray.length-i;
	}else{
		count=locationArray.length-i-1;
	}
	if(count%10!=0){//是否能被10整除
		if(locationArray.length-i>driverSpeed){//剩余数据是否大于10/20/30条，大于的话则先添加driverSpeed条数据
			for (var j = 0; j < driverSpeed; j++) {
				poliy.push(locationArray[i]);
				i++;
			}
			i--;
		}else {//否则的话把剩下的数据都添加到地图上
			for (var j = 0; j <=count; j++) {
				poliy.push(locationArray[i]);
				i++;
			}
		}
	}else {//不能被10整除
		if(locationArray.length-i>driverSpeed){//剩余数据是否大于10/20/30条，大于的话则先添加driverSpeed条数据
			for (var j = 0; j < driverSpeed; j++) {
				poliy.push(locationArray[i]);
				i++;
			}
			i--;
		}else {//否则的话把剩下的数据都添加到地图上
			for (var j = 0; j <=count; j++) {
				poliy.push(locationArray[i]);
				i++;
			}
		}
	}
	polyline= new BMap.Polyline(poliy, {strokeColor:"blue", strokeWeight:6, strokeOpacity:0.5});  //定义折线
	map.addOverlay(polyline);     //添加折线到地图上
	if (i < locationArray.length - 1 && i != locationArray.length - 1) {
		carMk = new BMap.Marker(locationArray[i], {
			icon : myIcon
		});
	}else{
		carMk = new BMap.Marker(locationArray[i-1], {
			icon : myIcon
		});
	}
	
	map.addOverlay(carMk);
	if(dataSource[i]!=undefined && dataSource[i].speed==0){
		//绘制停车点
		for (var j = 0; j < stopList.length; j++) {
			if(stopList[j].updateDate==dataSource[i].updateDate){
				var myPoint2 = new BMap.Point(stopList[j].longitude, stopList[j].latitude)
				var marker = new BMap.Marker(myPoint2, {
					icon : myStopIcon
				});
				map.addOverlay(marker);
				var circle = new BMap.Circle(myPoint2,1000,{fillColor:"blue", strokeWeight: 1 ,fillOpacity: 0.3, strokeOpacity: 0.3});
//			    map.addOverlay(circle);
			    //绘制监管对象信息
				if(listRegulaList!=null){
					for (var k = 0; k < listRegulaList.length; k++) {
						myPoint2 = new BMap.Point(listRegulaList[k].longitude, listRegulaList[k].latitude)
						if (BMapLib.GeoUtils.isPointInCircle(myPoint2, circle)) {
							marker = new BMap.Marker(myPoint2, {
								icon : regularStopIcon
							});
							map.addOverlay(marker);
							label = new BMap.Label(listRegulaList[k].regName, {
								offset: new BMap.Size(15, -25)
								});
							label.setStyle({
								width: "120px",
								color: '#fff',
								background: '#006def',
								border: '1px solid "#ff8355"',
								borderRadius: "5px",
								textAlign: "center",
								height: "26px",
								lineHeight: "26px"
								});
							marker.setLabel(label); //为标注添加一个标签
						}
					}
				}
			   
			}
		}
	}
	label = new BMap.Label(dataSource[i]!=dataSource[i]?dataSource[i].updateDate:dataSource[i-1].updateDate, {
		offset: new BMap.Size(15, -25)
		});
	label.setStyle({
		width: "120px",
		color: '#fff',
		background: '#006def',
		border: '1px solid "#ff8355"',
		borderRadius: "5px",
		textAlign: "center",
		height: "26px",
		lineHeight: "26px"
		});
	carMk.setLabel(label); //为标注添加一个标签
	for (var j = 0; j < i; j++) {
		viewList.push(locationArray[j]);
	}
	map.setViewport(viewList); // 调整到最佳视野
	 if (i < locationArray.length - 1 && i != locationArray.length - 1) {
		timet = setTimeout(function() {//回调绘制路线的方法
			driveCallBack();
		}, 500);
	} else {
//		dy.confirm('确认', '确定要重播吗?', function(r) {
//			if (r) {
//				i=0;
//				driveLine();// 加载路线
//			}
//		})
	}
}
function stopPlay() {
	if ($("#stopOrReplay").val() == "暂停") {
		clearTimeout(timet);
		$("#stopOrReplay").val("播放")
	} else {
		driveCallBack();
		$("#stopOrReplay").val("暂停")
	}
}

function BMapOneMarker(point, msg, img) {
	var opts = {
		width : 250
	};
	var infoWindow = new BMap.InfoWindow(msg, opts);// 创建信息窗口对象
	var myIcon = new BMap.Icon(img, new BMap.Size(40, 40), {    //小车图片
		//offset: new BMap.Size(0, -5),    //相当于CSS精灵
		imageOffset: new BMap.Size(0, 0)    //图片的偏移量。为了是图片底部中心对准坐标点。
	  });
	var marker = new BMap.Marker(point, {
		icon : myIcon
	});
	map.addOverlay(marker);
	marker.addEventListener("click", function() {
		map.openInfoWindow(infoWindow, point);// 打开信息窗口
	});
};
function queryById(carId) {
	$.ajax({
		url : rootPath+"queryById.shtml",
		type : "POST",
		data : {
			"id" : carId
		},
		dataType : "json",
		success : function(data) {
			var html = "";
			var htmlStr = "";
			var resulthtmlStr = "";
			if(data.obj.longitude!="" && data.obj.latitude!=""){
				map.clearOverlays();
				var new_point = new BMap.Point(data.obj.longitude, data.obj.latitude);
				if(point.pointType==1){
					html = "<span style='margin-bottom:0;'>设备信息</span><hr/>";
					html += "<span style='margin-top:0;'>IMEI：" + data.obj.carImei + "</span><br/>";
					html += "车牌号码：" + data.obj.licensePlate + "<br/>";
					html += "车&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;速：" + data.obj.speed + "KM/h<br/>";
					html += "定位时间：" + data.obj.updateDate + "<br/>";
					BMapOneMarker(new_point, html, msUrl +"/img/carpic/car.png");
				}else{
					html = "<span style='margin-bottom:0;'>快检点信息</span><hr/>";
					html += "<span style='margin-top:0;'>名称：" + point.pointName + "</span><br/>";
					html += "<span style='margin-top:0;'>地址：" + point.address + "</span><br/>";
					if(showDudao=="Y"){
						html += "<span style='margin-top:0;'>督导：" + point.manager + "</span><br/>";
					}

					html += "<span style='margin-top:0;'>联系方式：" + point.phone + "</span><br/>";
					BMapOneMarker(new_point, html, msUrl +"/img/house4.png");
				}
				map.panTo(new_point);
				arrayList=[];
				arrayList.push(new_point);
				//点击某一辆车信息，自动打开信息窗口 start
				var opts = {
					width : 250
				};
				var infoWindow = new BMap.InfoWindow(html, opts);// 创建信息窗口对象
				map.openInfoWindow(infoWindow, new_point);// 打开信息窗口
				map.setViewport(arrayList);
			}
			
		},
		error : function() {
			dy.alert('提示', '操作失败', 'error')
		}
	})
}
// 加快播放速度
function fastSpeed() {
	if (driverSpeed < 30) {
		driverSpeed = driverSpeed +10;
		if (driverSpeed > 10) {
			$("#slow").removeAttr("disabled");
		}
		if (driverSpeed==30) {
			$("#fast").attr("disabled","disabled");
		}
	}else{
		$("#fast").attr("disabled","disabled");
		$("#slow").removeAttr("disabled");
	}
}
// 减慢播放速度
function slowSpeed() {
	if (driverSpeed >10) {
		driverSpeed = driverSpeed -10;
		if (driverSpeed==10) {
			$("#slow").attr("disabled","disabled");
		}
	}else{
		$("#slow").attr("disabled","disabled");
		$("#fast").removeAttr("disabled");
	}
	if (driverSpeed > 10) {
		$("#fast").removeAttr("disabled");
	}
}