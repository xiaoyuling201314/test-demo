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
              	<!-- 
                <div class="cs-search-filter clearfix cs-fl">
	                <input class="cs-input-cont cs-fl focusInput" type="text" name="pointName" placeholder="请输入内容" />
	                <input type="button" onclick="datagridUtil.query()" class="cs-search-btn cs-fl" href="javascript:;" value="搜索">
	                <span class="cs-s-search cs-fl">高级搜索</span>
                </div>
                 -->
                <div class="clearfix cs-fr" id="showBtn">
                	<div class="clearfix cs-fr cs-hide rtBtn">
						<a href="javascript:" class="cs-menu-btn "><i class="icon iconfont icon-fanhui"></i>返回</a>
					</div>
                </div>
              </form>
            </div>
            
            <div class="cs-input-style cs-fl" style="margin:3px 0 0 30px;">
              <div class="cs-in-style cs-time-se" style="display:inline-block;"></div>
            	<td class="cs-in-style">
					<div class="cs-all-ps">
			        	<div class="cs-input-box">
			            	<input type="text" name="departPName">
			            	<input type="hidden" name="departPid">
			        		<div class="cs-down-arrow"></div>
			    		</div>
			    		<div class="cs-check-down cs-hide" style="display: none;">
			        		<ul id="myDeaprtTree" class="easyui-tree"></ul>
			    		</div>
		     		</div>
				</td>
            </div>
            	
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
		
    <script src="${webRoot}/js/datagridUtil.js"></script>
    <script type="text/javascript">
    
    var lt=0;
    var ltObj;
    //遍历操作权限
    for (var i = 0; i < childBtnMenu.length; i++) {
		if (childBtnMenu[i].operationCode == "1346-1") {
			lt = 1;
			ltObj=childBtnMenu[i];
		}
	} 
	var op = {
		tableId: "dataList",	//列表ID
		tableAction: '${webRoot}'+"/signIn/datagrid.do",	//加载数据地址
		parameter: [		//列表拼接参数
				{
					columnCode: "realname",
					columnName: "姓名",
					customElement: "<a class=\"cs-link-text checkUserName\" href=\"javascript:;\">?</a>"
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
					columnCode: "createDate",
					columnName: "签到时间",
					queryType: "1",
					dateFormat: "yyyy-MM-dd HH:mm:ss"
				},
				{
					columnCode: "longitude",
					columnName: "经度"
				},
				{
					columnCode: "latitude",
					columnName: "纬度"
				}
		],
		funBtns: [
	    	{	//查看定位按钮
	    		show: lt,
	    		style: ltObj,
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
	
	
    //查看检测员定位信息
    $(document).on("click",".checkUserName",function(){
    	var signId = $(this).parents(".rowTr").attr("data-rowId");
    	$.each(datagridOption["obj"],function(n,value){
    		if(signId == value.id){
    			$(".rtBtn").show();
    			delete op.parameter[0].customElement;//删除属性
    			op.defaultCondition=[{queryCode:"userId", queryVal:value.userId}];
    			
    			datagridUtil.initOption(op);
    			
    		    datagridUtil.query();
    		}
    	});
    });
    
  	//返回
    $(document).on("click",".rtBtn",function(){
		$(".rtBtn").hide();
    	op.parameter[0].customElement="<a class=\"cs-link-text checkUserName\" href=\"javascript:;\">?</a>";
		op.defaultCondition=[{queryCode:"departId", queryVal: $("input[name='departPid']").val()}];
		
		datagridUtil.initOption(op);
	    datagridUtil.query();
    });
    
    //加载机构选项
    var defaultSelect = true;	//默认选中机构树第一项
	$('#myDeaprtTree').tree({
		checkbox : false,
		url : '${webRoot}' + "/detect/depart/getDepartTree.do",
		animate : true,
		onSelect : function(node) {
			$("input[name='departPid']").val(node.id);
			$("input[name='departPName']").val(node.text);
			$('#myDeaprtTree').parent().hide();
			
			op.parameter[0].customElement="<a class=\"cs-link-text checkUserName\" href=\"javascript:;\">?</a>";
			op.defaultCondition=[{queryCode:"departId", queryVal:node.id}];
			$(".rtBtn").hide();
			
			datagridUtil.initOption(op);
			
		    datagridUtil.query();
			
		},
		loadFilter : function(data, parent) {
			var state = $.data(this, 'tree');
			function setData() {
				var serno = 1;
				var todo = [];
				for (var i = 0; i < data.length; i++) {
					todo.push(data[i]);
				}
				while (todo.length) {
					var node = todo.shift();
					if (node.id == undefined) {
						node.id = '_node_' + (serno++);
					}
					if (node.children) {
						node.state = 'open';
						node.children1 = node.children;
						node.children = undefined;
						todo = todo.concat(node.children1);
					}
				}
				state.tdata = data;
			}
			function find(id) {
				var data = state.tdata;
				var cc = [ data ];
				while (cc.length) {
					var c = cc.shift();
					for (var i = 0; i < c.length; i++) {
						var node = c[i];
						if (node.id == id) {
							return node;
						} else if (node.children1) {
							cc.push(node.children1);
						}
					}
				}
				return null;
			}

			setData();

			var t = $(this);
			var opts = t.tree('options');
			opts.onBeforeExpand = function(node) {
				var n = find(node.id);
				if (n && n.children && n.children.length) {
					return;
				}
				if (n && n.children1) {
					var filter = opts.loadFilter;
					opts.loadFilter = function(data) {
						return data;
					};
					t.tree('append', {
						parent : node.target,
						data : n.children1
					});
					opts.loadFilter = filter;
					n.children = n.children1;
				}
			};
			return data;
		},
		onLoadSuccess: function (node, data) {
			if (defaultSelect && data.length > 0) {
		    	//找到第一个元素
		    	var n = $('#myDeaprtTree').tree('find', data[0].id);
		    	//调用选中事件
		    	$('#myDeaprtTree').tree('select', n.target);
		    	defaultSelect = false;
		    }
		
			//延迟执行自动加载二级数据，避免与异步加载冲突
			setTimeout(function(){
				if (data) {
			    	$(data).each(function (index, d) {
			         	if (this.state == 'closed') {
			        		var children = $('#myDeaprtTree').tree('getChildren');
			        		for (var i = 0; i < children.length; i++) {
			            		$('#myDeaprtTree').tree('expand', children[i].target);
			            	}
			         	}
			    	});
				}
			}, 100);
			
		}
	});
    
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
	
    //绑定回车事件
    //document.onkeydown=keyDownSearch;
    </script>
  </body>
</html>
