<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/common/resource.jsp"%>
<html>
  <head>
    <title>快检服务云平台</title>
  </head>
  <body>
        <div class="cs-col-lg clearfix">
          <!-- 面包屑导航栏  开始-->
            <ol class="cs-breadcrumb">
              <li class="cs-fl">
              <img src="${webRoot}/img/set.png" alt="" />
              <a href="javascript:">检测点管理</a></li>
              <li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
              <li class="cs-b-active cs-fl">快检点
              </li>
            </ol>
          <!-- 面包屑导航栏  结束-->
          <div class="cs-col-nav clearfix cs-fl">
          		<!--
	           <div class="cs-input-style cs-fl" style="margin:3px 0 0 30px;">
	              	行政区:
	              	<div class="cs-all-ps">
						<div class="cs-input-box">
					    	<input type="text" name="departNames">
					    	<div class="cs-down-arrow"></div>
						</div>
						<div class="cs-check-down cs-hide" style="display: none;">
					    	<ul id="tree" class="easyui-tree"></ul>
						</div>
					</div>
	            </div>
	             -->

	           <div class="cs-fl"> <span class="cs-title-tip text-muted">共
					<c:choose>
					   <c:when test="${!empty pointInfos}">${fn:length(pointInfos)}</c:when>
					   <c:otherwise>0</c:otherwise>
					</c:choose>
					个检测点</span>
			   </div>

            </div>

            <div class="cs-search-box cs-fr">
              <form>
              	<div class="clearfix cs-fr" id="showBtn">
              		<c:if test="${returnBtn eq 'Y'}">
		              	<!-- <a href="javascript:;" onclick="self.history.back();" class="cs-menu-btn"><i class="icon iconfont icon-fanhui"></i>返回</a> -->
		              	<a href="javascript:" onclick="window.parent.closeMbIframe(1);" class="cs-menu-btn"><i class="icon iconfont icon-fanhui"></i>返回</a>
              		</c:if>
              	</div>
              </form>
            </div>
          </div>

           <div class="clearfix">
              <ul class="cs-point-list">
              <c:forEach items="${pointInfos}" var="pointInfo">
	            <li class="cs-points">
                  <div class="cs-img-box">
                    <span class="cs-border-right">
	                    <!-- 检测站 -->
		              	<c:if test="${pointInfo.point.pointType eq '0'}">
		              		<i title="cheliang" class="icon iconfont icon-loupan cs-icon-head"></i>
		              	</c:if>
		             	<!-- 检测车 -->
		           		<c:if test="${pointInfo.point.pointType eq '1'}">
		           			<i title="cheliang" class="icon iconfont icon-jianceche cs-icon-head"></i>
		              	</c:if>
	              	</span>
                  </div>
                  <div class="cs-points-info">
                    <div class="cs-info-title">
                    	<a href="javascript:" onclick="viewDevice('${pointInfo.point.id}')">${pointInfo.point.pointName}</a>
	                    <div class="cs-nor-btn cs-fr iBtns">
	                      <input class="pointId" type="hidden" value="${pointInfo.point.id}">
	                    </div>
                    </div>
					<div class="cs-info-list clearfix">
					  <c:if test="${empty hidePerson}">
							  <ul class="cs-any-li">
								  <li>督导：<span class="cs-name-co"><c:if test="${!empty pointInfo.manager}">${pointInfo.manager.workerName}</c:if></span></li>
								  <li>人员：<a href="javascript:" onclick="viewMember('${depart.id}','${pointInfo.point.id}')"><span class="cs-name-co">${pointInfo.membersSize}人</span></a></li>
							  </ul>
					  </c:if>
					</div>
                    <div class="cs-info-list clearfix">
                      <ul class="cs-any-li">
                        <li>仪器：<a href="javascript:" onclick="viewDevice('${pointInfo.point.id}')"><span class="cs-name-co">${pointInfo.devicesSize}台</span></a></li>
                        <li><div  class="temperature" style="display: none;">温度：<a href="javascript:"><span class="cs-name-co">${pointInfo.manage.temperature}℃</span></a></div></li>
                        <li ><div style="display: none;"class="humidity">湿度：<a href="javascript:"><span class="cs-name-co">${pointInfo.manage.humidity}%</span></a></div></li>
                      </ul>
                    </div>
                    <div></div>
                    <div class="cs-info-list">
                    	<!-- 检测站 -->
		              	<c:if test="${pointInfo.point.pointType eq '0'}">
		              		地址：
			              	<a href="${webRoot}/detect/location/replay.do?id=${pointInfo.point.id}">
			              		<span class="cs-name-co"><c:if test="${!empty pointInfo.point}">${pointInfo.point.address}</c:if></span>
			              	</a>
			              	<a class="localBtn cs-hide" data-toggle="modal" data-target="#positionModal" onclick="setMapLocation('${pointInfo.point.placeX}','${pointInfo.point.placeY}');setUpdatePointid('${pointInfo.point.id}','${pointInfo.point.departId}');">
		                    	<span class="cs-icon-span"><i class="icon iconfont icon-local"></i></span>
			              	</a>
		              	</c:if>

		              	<!-- 检测车 -->
		           		<c:if test="${pointInfo.point.pointType eq '1'}">
		           			车牌：
		           			<a href="${webRoot}/detect/location/replay.do?id=${pointInfo.point.id}">
		           				<span class="cs-name-co"><c:if test="${!empty pointInfo.point}">${pointInfo.point.licensePlate}</c:if></span>
		           			</a>
		           		</c:if>
                    </div>
                  </div>
                </li>
              </c:forEach>
              </ul>
            </div>
      <!-- 内容主体 结束 -->

    <!-- Modal 提示窗-删除-->
	<div class="modal fade intro2" id="confirm-delete" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog cs-alert-width">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
					<h4 class="modal-title" id="myModalLabel">确认删除</h4>
				</div>
				<div class="modal-body cs-alert-height cs-dis-tab">
					<div class="cs-text-algin">
						<img src="${webRoot}/img/stop2.png" width="40px"/>确认删除该记录吗？
					</div>
				</div>
				<div class="modal-footer">
					<a class="btn btn-danger btn-ok" onclick="deletePoint()">删除</a>
					<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
				</div>
			</div>
		</div>
	</div>

    <!-- 新增、编辑检测点模态框 -->
    <%@include file="/WEB-INF/view/detect/basePoint/addPoint.jsp"%>

    <!-- 选择地图定位 -->
    <%@ include file="/WEB-INF/view/common/map/selectMapLocation.jsp" %>

    <!-- JavaScript -->
    <script type="text/javascript">
  		for (var i = 0; i < childBtnMenu.length; i++) {
  			if (childBtnMenu[i].operationCode == "391-4") {
  	  			//查看
  				$(".iBtns").append('<span class="cs-icon-span"><i class="'+childBtnMenu[i].functionIcon+' viewPoint"></i></span>');
  	  		}else if (childBtnMenu[i].operationCode == "391-1") {
  				//新增
  				var html='<a class="cs-menu-btn" href="javascript:;" onclick="addPoint()"><i class="'+childBtnMenu[i].functionIcon+'"></i>'+childBtnMenu[i].operationName+'</a>';
  				$("#showBtn").prepend(html);
  			}else if (childBtnMenu[i].operationCode == "391-2") {
  				//编辑
  				$(".iBtns").append('<span class="cs-icon-span"><i class="'+childBtnMenu[i].functionIcon+' editPoint"></i></span>');
  				$(".localBtn").show();
  			}else if (childBtnMenu[i].operationCode == "391-3") {
  				//删除
  				$(".iBtns").append('<span class="cs-icon-span"><i class="'+childBtnMenu[i].functionIcon+' deletePoint"></i></span>');
  			}else if (childBtnMenu[i].operationCode == "391-7"||childBtnMenu[i].operationCode == "392-4") {
  				$(".temperature").show(); //显示温湿度数据信息
  				$(".humidity").show();
  			}

  		}
  		/* $('#tree').tree({
  			checkbox : false,
  			url : "${webRoot}/detect/depart/getDepartTree.do",
  			animate : true,
  			onClick : function(node) {
  				var did=node.id;
  				$("input[name='departNames']").val(node.text);
  				$(".cs-check-down").hide();
  				
  				//修改机构
  				if(node.id){
  	  				self.location = '${webRoot}/detect/basePoint/list.do?returnBtn=Y&id='+node.id;
  	  			}
  			}
  		}); */

  		//删除检测点
  		var delectPointId;
  		function openDeleteModal(id){
  			if(id){
  				delectPointId = id;
  				$("#confirm-delete").modal('toggle');
  			}
  		}
  		function deletePoint(){
  			$.ajax({
		        type: "POST",
		        url: '${webRoot}'+"/detect/basePoint/delete.do",
		        data: {"ids":delectPointId},
		        dataType: "json",
		        success: function(data){
		        	if(data && data.success){
			        	self.location.reload();
		        	}
				}
		    });
  			$("#confirm-delete").modal('toggle');
  		}

  		//设置更新检查点ID
  		var updatePointid = '';	//检测点ID
  		var updatePdid = '';	//检测点所属机构ID
  		function setUpdatePointid(pid, pdid){
  			updatePointid = pid;
  			updatePdid = pdid;
  		}
  		//保存坐标
  		function getCoordinate(coordinate, title, address){
  			var jw = coordinate.split(",");
  			// var address = "";
  			//
  			// var pt = new BMap.Point(jw[0], jw[1]);
  			// var geoc = new BMap.Geocoder();
			//
  			// //逆地址解析
			// geoc.getLocation(pt, function(rs){
  			// 	var addComp = rs.addressComponents;
  			// 	address = addComp.province + addComp.city + addComp.district + addComp.street + addComp.streetNumber;
  			// });

			//修改坐标，地址为空，后台不更新地址
  			var overwriteAddress = "0";	//更新
  			if (!address) {
				overwriteAddress = "1";	//不更新
			}
			setTimeout(function(){
	  			$.ajax({
			        type: "POST",
			        url: '${webRoot}'+"/detect/basePoint/save.do",
			        data: {"id":updatePointid,"departId":updatePdid,"placeX":jw[0],"placeY":jw[1],"address":address,"overwriteAddress":overwriteAddress},
			        dataType: "json",
			        success: function(data){
			        	if(data && data.success){
				        	self.location.reload();
			        	}
					}
			    });
			},200);
  		}

  		//查看
  	    $(document).on("click", ".viewPoint", function(){
			var pointId = $(this).parent().siblings(".pointId").val();
			viewDevice(pointId);
	    });
    	//编辑
		$(document).on("click", ".editPoint", function(){
			var pointId = $(this).parent().siblings(".pointId").val();
			addPoint(pointId);
	    });
    	//删除
    	$(document).on("click", ".deletePoint", function(){
			var pointId = $(this).parent().siblings(".pointId").val();
			openDeleteModal(pointId);
	    });
  		//查看设备
  	    function viewDevice(id){
  	    	self.location = '${webRoot}/data/devices/devicesList.do?type=point&id='+id;
  	    }
  		//查看检测点人员
  	    function viewMember(departId,pointId){
  	    	self.location = '${webRoot}/data/pointUser/list.do?departId='+departId+'&pointId='+pointId;
  	    }

    </script>
  </body>
</html>
