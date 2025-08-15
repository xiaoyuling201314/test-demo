<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript" src="https://api.map.baidu.com/api?v=2.0&ak=3VcDe6wDBzTnPp718D2O49QxfByP7e0W&s=1"></script>
	<!-- 定位-->
	<div class="modal fade intro2" id="position" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	  <div class="modal-dialog cs-lg-width" role="document">
	    <div class="modal-content ">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" id="myModalLabel">定位</h4>
	      </div>
	      <div class="modal-body cs-lg-height">
	        <!-- 主题内容 -->
		    <div class="cs-main">
			    <div class="cs-wraper clearfix">
			    	<div id="allmap" style="width:100%; height:94%;"></div>
			    </div>
				<div id="mapAddress"></div>
		    </div>
	      </div>
	      <div class="modal-footer action">
	        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
	      </div>
	    </div>
	  </div>
	</div>
<!-- JavaScript -->
<script type="text/javascript">
	var loadMap = true;	//加载地图
	var map;
	var mapX = 0, mapY = 0, mapAddress = "";
	$("#position").on("shown.bs.modal",function() {
		if(loadMap){
			loadMap = false;
			map = new BMap.Map("allmap");    // 创建Map实例
			//添加地图类型控件
			map.addControl(new BMap.MapTypeControl({
				mapTypes:[
					BMAP_NORMAL_MAP,
					BMAP_HYBRID_MAP
				]
			}));   
			map.addControl(new BMap.NavigationControl({
			    // 靠左上角位置
			    anchor: BMAP_ANCHOR_TOP_LEFT,
			    // LARGE类型
			    type: BMAP_NAVIGATION_CONTROL_LARGE
			}));  
			map.enableScrollWheelZoom(true);     //启用滚轮放大缩小，默认禁用
		}
		
		// 百度地图API功能
		map.clearOverlays();//清除覆盖物
		
		if(mapX && mapY && mapX != 0 && mapY != 0){	//设置点
			var point = new BMap.Point(mapX, mapY);	
			map.centerAndZoom(point,15);      // 初始化地图,用城市名设置地图中心点
			var marker = new BMap.Marker(point);  // 创建标注
			map.addOverlay(marker);               // 将标注添加到地图中
			marker.setAnimation(BMAP_ANIMATION_BOUNCE); //跳动的动画
			mapX = 0;
			mapY = 0;
		}else{
			map.centerAndZoom("广州",15);      // 初始化地图,用城市名设置地图中心点
		}

		if (mapAddress) {
			$("#mapAddress").text("检测地址：" + mapAddress);
		} else {
			$("#mapAddress").text("");
		}
	});

	$("#position").on("hidden.bs.modal",function() {
		$("#mapAddress").text("");
	});
</script>
</html>
