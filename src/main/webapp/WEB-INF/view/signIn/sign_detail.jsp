<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/common/resource.jsp"%>
<html>
  <head>
    <title>快检服务云平台</title>
  </head>
  <script type="text/javascript" src="https://api.map.baidu.com/api?v=2.0&ak=3VcDe6wDBzTnPp718D2O49QxfByP7e0W&s=1"></script>
  <body>
          <div class="cs-col-lg clearfix">
          <!-- 面包屑导航栏  开始-->
            <ol class="cs-breadcrumb">
              <li class="cs-fl">
              <img src="${webRoot}/img/set.png" alt="" />
              <a href="javascript:">人员管理</a></li>
              <li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
              <li class="cs-b-active cs-fl">人员签到
              </li>
            </ol>
          <!-- 面包屑导航栏  结束-->
            <div class="cs-search-box cs-fr">
              <form>
                <div class="clearfix cs-fr" id="showBtn">
                	<div class="clearfix cs-fr rtBtn">
						<a href="javascript:" onclick="parent.closeMbIframe(1);" class="cs-menu-btn"><i class="icon iconfont icon-fanhui"></i>返回</a>
					</div>
                </div>
              </form>
            </div>
            
            <div class="cs-input-style cs-fl" style="margin:3px 0 0 30px;margin-right: 10px;">
              <div class="cs-in-style">
	              <select id="signType" onchange="searchType()" style="width:120px;">
	               	  <option value="">--全部--</option>
					  <c:if test="${signTypeConfig.app_sign==1}">
						  <option value="0" >APP签到</option>
					  </c:if>
					  <c:if test="${signTypeConfig.sampling_sign==1}">
						  <option value="1">APP抽样</option>
					  </c:if>
					  <c:if test="${signTypeConfig.weixin_sign==1}">
						  <option value="2">微信签到</option>
					  </c:if>
					  <c:if test="${signTypeConfig.commuting_sign==1}">
						  <option value="3">打卡签到</option>
					  </c:if>
	              </select>
              </div>
            </div>
            	 <%@include file="/WEB-INF/view/common/selectDate.jsp"%>
          </div>

		<div id="dataList"></div>
		
	<!-- 定位-->
	<div class="modal fade intro2" id="position" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	  <div class="modal-dialog cs-lg-width" role="document">
	    <div class="modal-content ">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" id="myModalLabel">定位信息</h4>
	      </div>
	      <div class="modal-body cs-lg-height">
	        <!-- 主题内容 -->
		    <div class="cs-main">
			    <div class="cs-wraper clearfix">
			    	<div class="cs-info-line">
				    	<div class="cs-fl cs-addr">姓名：<i class="text-primary" id="username"></i></div>
				    	<div class="cs-fl cs-addr">签到时间：<i class="text-primary" id="signTime"></i></div>
				    	<div class="cs-addr">签到地址：<i class="text-primary" id="address"></i></div>
			    	</div>
			    	<hr/>
			    	<div id="allmap" style="width:100%; height:315px;"></div>
			    </div>
		    </div>
	      </div>
	      <div class="modal-footer action">
	        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
	      </div>
	    </div>
	  </div>
	</div>
	<%@include file="/WEB-INF/view/signIn/addSignModal.jsp"%>
    <script src="${webRoot}/js/datagridUtil.js"></script>
    <script type="text/javascript">
		if(Permission.exist("1346-2")){
			var html='<a class="cs-menu-btn" onclick="punchClock()" ><i class="'+Permission.getPermission("1346-2").functionIcon+'"></i>'+Permission.getPermission("1346-2").operationName+'</a>';
			$("#showBtn").append(html);
		}
		$(function(){
			$("#signType").val("${signType}");
		});
   var isFirstQuery=true;
    var optionDetail = {
			tableId: "dataList",	//列表ID
			tableAction: '${webRoot}'+"/signIn/datagrid.do",	//加载数据地址
			onload: function(){
				//加载列表后执行函数
				var obj = datagridOption["obj"];
				$(".rowTr").each(function(){
					for(var i=0;i<obj.length;i++){
						if($(this).attr("data-rowId") == obj[i].id){
							if(obj[i].longitude==""||obj[i].latitude==""){
								//隐藏定位按钮
								$(this).find(".1346-1").hide();
							}
						}
					}
				});
			},
			parameter: [		//列表拼接参数
					{
						columnCode: "realname",
						columnName: "姓名",
						columnWidth:"100px"
					},
					{
						columnCode: "departName",
						columnName: "所属机构"
					},
					{
						columnCode: "pointName",
						columnName: "所属检测点"
					},
					{
						columnCode: "address",
						columnName: "地址"
					},
					{
						columnCode: "signType",
						columnName: "签到类型",
						customVal: {"0":"app签到","1":"app抽样","2":"微信签到","3":"上班打卡","4":"下班打卡"},
						columnWidth:"100px"
					},{
						columnCode: "param1",
						columnName: "签到方式",
						customVal: {"0":"APP","1":"APP","2":"APP","3":"APP","4":"APP","5":"WEB"},
						columnWidth:"100px"
					},
					{
						columnCode: "createDate",
						columnName: "签到时间",
						queryType: "1",
						dateFormat: "yyyy-MM-dd HH:mm:ss",
						columnWidth:"160px"
					},
					{
						columnCode: "longitude",
						columnName: "经度",
						columnWidth:"110px"
					},
					{
						columnCode: "latitude",
						columnName: "纬度",
						columnWidth:"110px"
					}
			],defaultCondition: [
	            {
	                queryCode: "type",
	                queryVal: ""
	            }, {
	                queryCode: "month",
	                queryVal: ""
	            }, {
	                queryCode: "season",
	                queryVal: ""
	            }, {
	                queryCode: "year",
	                queryVal: ""
	            }, {
	                queryCode: "start",
	                queryVal: ""
	            }, {
	                queryCode: "end",
	                queryVal: ""
	            }, {
	                queryCode: "userId",
	                queryVal: ""
	            }, {
	                queryCode: "signType",
	                queryVal: ""
	            }
	        ],
	        funColumnWidth:"80px",
			funBtns: [
		    	{	//查看定位按钮
		    		show: Permission.exist("1346-1"),
	                style: Permission.getPermission("1346-1"),
		    		action: function(id){
		    			var obj = datagridOption["obj"];
		    		    for(var i=0;i<obj.length;i++){
		    		   		if(id == obj[i].id){
		    		   			mapX=obj[i].longitude;
		    		   			mapY=obj[i].latitude;
		    		   			$("#username").html(obj[i].realname);
		    		   			$("#signTime").html(obj[i].createDate);
		    		   			$("#address").html(obj[i].address);
				    			$('#position').modal("show");
		    		   		}
		    		   	}
		    		    
		    		}
		    	}
		    ]
		};
  //初始化日期
    selectDate.init(function (d){
    	 datagridUtil.initOption(optionDetail);
    	if(isFirstQuery){//第一次进入明细页面，初始化主页面的时间数据
    		$("#province").val(sessionStorage.type);
    		$("#province").change();
    		var year;
    		switch (sessionStorage.type) {
			case "month":
				 $("#year1").val(sessionStorage.year);
				 $("#year1").change();
				break;
			case "season":
				 $("#year2").val(sessionStorage.year);
				 $("#year2").change();
				break;
			case "year":
				 $("#year3").val(sessionStorage.year);	
				 $("#year3").change();
					break;
			default:
				break;
			}
    		datagridUtil.addDefaultCondition("year", sessionStorage.year);
   		    $("#season").val(sessionStorage.season);
   		    $("#month").val(sessionStorage.month);
   		 	$("#province").change();
   		    $("#start").val(sessionStorage.start);
   		    $("#end").val(sessionStorage.end);
   		   isFirstQuery=false;
    	}
	   
	    datagridUtil.addDefaultCondition("type", $("#province").val());
		datagridUtil.addDefaultCondition("season", $("#season").val());
		datagridUtil.addDefaultCondition("month", $("#month").val());
		datagridUtil.addDefaultCondition("start", $("#start").val());
		datagridUtil.addDefaultCondition("end", $("#end").val());
		datagridUtil.addDefaultCondition("userId","${userId}");
		datagridUtil.addDefaultCondition("signType","${signType}");
		datagridUtil.query();
    });
  //根据类型分类查看
  function searchType(){
	  var signType=$("#signType").val();
	  datagridUtil.addDefaultCondition("signType",signType);
	  datagridUtil.query();
  }
    var loadMap = true;	//加载地图
    var map;
    var mapX = 0, mapY = 0;
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
			//添加地图平移缩放控件
			map.addControl(new BMap.NavigationControl());
			//开启鼠标滚轮缩放
			map.enableScrollWheelZoom(true);     
		}
		
		// 百度地图API功能
		map.clearOverlays();//清除覆盖物
		
		if(mapX && mapY && mapX != 0 && mapY != 0){	//设置点
			var point = new BMap.Point(mapX, mapY);	
			map.centerAndZoom(point,18);      // 初始化地图,用标注设置地图中心点
			var marker = new BMap.Marker(point);  // 创建标注
			map.addOverlay(marker);               // 将标注添加到地图中
			marker.setAnimation(BMAP_ANIMATION_BOUNCE); //跳动的动画
			mapX = 0;
			mapY = 0;
		}else{
			map.centerAndZoom("广州",12);      // 初始化地图,用城市名设置地图中心点
		}
	});
		//录入打卡信息
		function punchClock(){
			$("#addSignModal").modal("toggle");
		}
    </script>
  </body>
</html>
