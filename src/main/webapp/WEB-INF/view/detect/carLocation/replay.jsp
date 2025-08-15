<%@page import="com.ibm.icu.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fm" %>
<%@page import="java.util.Date" %>
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>快检车定位管理</title>
	<%@include file="/WEB-INF/view/common/resource.jsp"%>
<style type="text/css">
body, html,#allmap {width: 100%;height: 100%;overflow: hidden;margin:0;font-family:"微软雅黑";}
#allmap label{max-width:none;}
.choseDate{
    border: 1px solid #ddd;
    height: 30px;
    width: 100px;
    line-height: 30px;
    border-radius: 2px 0 0 2px;
}
.labelStyle{
	margin-left: 10px;
	margin-right: 10px;
	margin-top: 5px;
}
</style>
<script src="${webRoot}/js/GeoUtils_min.js" type="text/javascript"></script>
<script type="text/javascript" src="https://api.map.baidu.com/api?v=2.0&ak=3VcDe6wDBzTnPp718D2O49QxfByP7e0W&s=1"></script>
<title>可视区域内的搜素</title>
</head>
<body>
 <div class="cs-col-lg clearfix">
          <!-- 面包屑导航栏  开始-->
            <ol class="cs-breadcrumb">
              <li class="cs-fl">
              <img src="${webRoot}/img/set.png" alt="" />
              <a href="javascript:">检测室管理</a></li>
 			 <li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
              <li class="cs-fl">检测室管理
              <li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
              <li class="cs-b-active cs-fl">检测室:${point.pointName}
              </li>
            </ol>
            <input type="hidden" class="focusInput" name="id" value="${point.id}">
            <c:if test="${point.pointType==1}">
          <!-- 面包屑导航栏  结束-->
            <div class="cs-fr" style="padding-top: 4px;">
              <form id="searchForm">
                <div class="clearfix" style="position: relative;float: left;">
                	<input type="hidden" class="focusInput" name="carImei" value="${point.imei}">
<!--                		<input id="detectName" name="itemId" placeholder=""> -->
	               		<div class="cs-fl" style="height: 30px;line-height: 30px;border-radius: 2px 0 0 2px;">
		               		<label class="cs-fl labelStyle" for="replayDate">选择日期:</label>
		               		<input id="replayDate" class="easyui-combobox" style="width:120px;"/>
	               		</div>
	               		<div class="cs-fl">
		               		<label class="labelStyle">开始时间:</label> 
		               		<input name="startTime" id="startTime" class="cs-time choseDate" type="text" onClick="WdatePicker({dateFmt:'HH:mm:ss'})" value="00:00:00"/>
	               		</div>
	               		<div class="cs-fl">
	     	 			 <label class="cs-fl labelStyle">结束时间:</label>
	     	 			 <input name="endTime" id="endTime" class="cs-time choseDate" type="text" onClick="WdatePicker({startDate:'%H:%m:%s',dateFmt:'HH:mm:ss',alwaysUseStartDate:true,minDate:'#F{$dp.$D(\'startTime\',{H:0})}'})" value="23:59:59"/>
                 		</div>
	                 	<input type="button" class="btn btn-info" value="回放" onClick="reloadData();" style="margin-left:10px;" />
	                 	<input type="button" class="btn btn-info" id="stopOrReplay" value="暂停" onclick="stopPlay()" />
						 <input type="button" class="btn btn-info" id="fast" value="加速" onclick="fastSpeed()" />
						  <input type="button" class="btn btn-info" id="slow" value="减速" onclick="slowSpeed()" />
	           			 <input type="button" id="myBtnReturn" class="btn btn-info" value="返回"/>
                </div>
              </form>
            </div>
            </c:if>
            <c:if test="${point.pointType!=1}">
            	<div class="clearfix cs-fr" id="showBtn">
           			 <%--<input type="button" id="myBtnReturn" class="btn btn-info" value="返回"/>--%>
                    <button class="cs-menu-btn" id="myBtnReturn"><i class="icon iconfont icon-fanhui"></i>返回</button>
              </div>
            </c:if>
          </div>
		<div id="allmap"></div>
<script type="text/javascript">
rootPath="${webRoot}/detect/location/";
var msUrl="${webRoot}";
var point={pointType:"${point.pointType}",pointName:"${point.pointName}",address:"${point.address}",phone:"${point.phone}",manager:"${manager.workerName}"};
var map = new BMap.Map("allmap");
map.centerAndZoom(new BMap.Point(116.404, 39.915), 15);
map.addControl(new BMap.NavigationControl());               // 添加平移缩放控件
map.addControl(new BMap.ScaleControl());                    // 添加比例尺控件
map.addControl(new BMap.OverviewMapControl());              //添加缩略地图控件
map.enableScrollWheelZoom(true);
var myIcon = new BMap.Icon(msUrl+"/img/carpic/car.png", new BMap.Size(40, 40), {    //小车图片
	//offset: new BMap.Size(0, -5),    //相当于CSS精灵
	imageOffset: new BMap.Size(0, 0)    //图片的偏移量。为了是图片底部中心对准坐标点。
  });
var myStartIcon = new BMap.Icon(msUrl+"/img/carpic/start.png", new BMap.Size(32, 32), {    //小车图片 
	imageOffset: new BMap.Size(0, 0)    //图片的偏移量。为了是图片底部中心对准坐标点。
  });
var myEndIcon = new BMap.Icon(msUrl+"/img/carpic/end.png", new BMap.Size(32, 32), {    //小车图片
	imageOffset: new BMap.Size(0, 0)    //图片的偏移量。为了是图片底部中心对准坐标点。
  });
var myStopIcon = new BMap.Icon(msUrl+"/img/carpic/flag.png", new BMap.Size(32, 32), {    //小车图片
	imageOffset: new BMap.Size(0, 0)    //图片的偏移量。为了是图片底部中心对准坐标点。
  });
var regularStopIcon = new BMap.Icon(msUrl+"/img/carpic/regular.png", new BMap.Size(32, 32), {    //小车图片
		imageOffset: new BMap.Size(0, 0)    //图片的偏移量。为了是图片底部中心对准坐标点。
	  });
 locationArray = [];
 myPoint=null;
 driverSpeed = 1000;
 dataSource=[];//保存路线所有数据
 label =null;
 i=0;
 carMk =null;
 ptsArray=[];
 viewList=[];
 timet=null;
var showDudao="${showDudao}";
 $(function(){
	//返回按钮
	$('#myBtnReturn').on('click', function(event) {
        if("${openIframe}"=="N"){
            self.history.back();
        }else{
            parent.closeMbIframe();
        }
	});
});
</script>
<script type="text/javascript" src="${webRoot}/js/replay.js"></script>
</body>
</html>