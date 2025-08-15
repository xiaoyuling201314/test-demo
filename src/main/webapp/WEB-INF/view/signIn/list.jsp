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
              	
                <div class="cs-search-filter clearfix cs-fl">
	                <input class="cs-input-cont cs-fl focusInput" type="text" name="keyWords" placeholder="请输入内容" />
	                <input type="button" onclick="loadData();" class="cs-search-btn cs-fl" value="搜索">
                </div>
                 
                <div class="clearfix cs-fr" id="showBtn">
                	<div class="clearfix cs-fr cs-hide rtBtn">
						<a href="javascript:" class="cs-menu-btn "><i class="icon iconfont icon-fanhui"></i>返回</a>
					</div>
                </div>
              </form>
            </div>
            
            <div class="cs-input-style cs-fl" style="margin:3px 0 0 10px;margin-right: 10px;">
              <div class="cs-in-style cs-time-se" style="display:inline-block;"></div>
<!--               	机构： -->
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
				<span id="secondPermise" class="cs-hide">项目:
	            <select class="js-select2-tags" onchange="loadData();" style="width:200px;margin-left: 10px;" id="projectDepartId">
	            	
	            </select></span>
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
  	<%@include file="/WEB-INF/view/common/modalBox.jsp" %>
    <script src="${webRoot}/js/datagridUtil2.js"></script>
    <script type="text/javascript">
    var isQuery=false;
	if(Permission.exist("1346-2")){
		$('.js-select2-tags').select2();
		var html='<a class="cs-menu-btn" onclick="punchClock()" ><i class="'+Permission.getPermission("1346-2").functionIcon+'"></i>'+Permission.getPermission("1346-2").operationName+'</a>';
		$("#showBtn").append(html);
	}
  //根据权限判断是否显示二期项目相关信息
    if(Permission.exist("1426-1")){
    	 $('#secondPermise').removeClass("cs-hide");
	     $('.js-select2-tags').select2();
    }
    var app_sign=1;//app签到
	var sampling_sign=1;//抽样签到
	var commuting_sign=1;//上下班打卡签到
	if('${signType}'!='0'){
		var signType=JSON.parse('${signType}');
		app_sign=${signType.app_sign};
		sampling_sign=${signType.sampling_sign};
		commuting_sign=${signType.commuting_sign};
	}
	var dgu = datagridUtil.initOption({
		tableId: "dataList",
		tableAction: "${webRoot}/signIn/datagrid.do",
		onload: function(rows, pageData){
			//加载列表后执行函数
			$(".rowTr").each(function(){
				for(var i=0;i<rows.length;i++){
					if($(this).attr("data-rowId") == rows[i].id){
						if(rows[i].longitude==""||rows[i].latitude==""){
							//隐藏定位按钮
							$(this).find(".1346-1").hide();
						}
					}
				}
			});
		},
		parameter: [
				{
					columnCode: "realname",
					columnName: "姓名",
					customElement: "<a class=\"cs-link-text checkUserName\" href=\"javascript:;\">?</a>",
					customStyle:"realname",
					columnWidth:"120px"
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
					columnCode: "createDate",
					columnName: "最后签到时间",
					columnWidth: "150px",
				},
				{
					columnCode: "address",
					columnName: "最后签到地址"
				},
				{
					columnCode: "signCount",
					columnName: "签到次数",
					columnWidth: "90px",
					sortDataType:"int",
					customVal:{"is-null":"0","non-null":'<a class=\"cs-link-text viewSignDetail\" data-type=\"0\" href=\"javascript:;\">?</a>'},
					show:app_sign
				},
				{
					columnCode: "samplingCount",
					columnName: "抽样签到",
					columnWidth: "90px",
					sortDataType:"int",
					customVal:{"is-null":"0","non-null":'<a class=\"cs-link-text viewSignDetail\" data-type=\"1\" href=\"javascript:;\">?</a>'},
					show:sampling_sign
				},
				{
					columnCode: "punchCount",
					columnName: "上下班打卡",
					columnWidth: "90px",
					sortDataType:"int",
					customVal:{"is-null":"0","non-null":'<a class=\"cs-link-text viewSignDetail\" data-type=\"3\" href=\"javascript:;\">?</a>'},
					show:commuting_sign
				},
				{
					columnCode: "userId",
					columnName: "用户ID",
					customStyle:"userId",
					columnWidth: "120px",
					show:2
				},
				{
					columnCode: "longitude",
					columnName: "经度",
					customStyle:"longitude",
					columnWidth: "120px",
					show:2
				},
				{
					columnCode: "latitude",
					columnName: "纬度",
					customStyle:"latitude",
					columnWidth: "120px",
					show:2
				}
		], defaultCondition: [
			{
				queryCode: "keyWords",
				queryVal: ""
			}, {
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
            }
        ],
		funBtns: [
			{	//查看定位按钮
	    		show: Permission.exist("1346-1"),
                style: Permission.getPermission("1346-1"),
	    		action: function(id){
	    			 var obj = datagridUtil.getData();
	    		    for(var i=0;i<obj.length;i++){
	    		   		if(id == obj[i].id){
	    		   			mapX=obj[i].longitude;
	    		   			mapY=obj[i].latitude;
	    		   			$("#username").html(obj[i].realname);
	    		   			$("#signTime").html(obj[i].createDate);
	    		   			$("#address").html(obj[i].address);
			    			$('#position').modal("show");
	    		   			/* $.ajax({
	    				    	url:"${webRoot}/signIn/queryById.do",
	    				    	type:"POST",
	    				    	data:{"userId":obj[i].userId},
	    				    	dataType:"json",
	    				    	success:function(data){
	    				    		mapX=data.obj.longitude;
	    	    		   			mapY=data.obj.latitude;
	    	    		   			$("#username").html(data.obj.realname);
	    	    		   			$("#signTime").html(data.obj.createDate);
	    	    		   			$("#address").html(data.obj.address);
	    			    			$('#position').modal("show");
	    				    	}
	    			    	}); */
	    		   			
	    		   		}
	    		   	} 
	    		    
	    		}
	    	}
	    ]
	});
	dgu.queryByFocus();

    //查看检测员定位信息
     $(document).on("click",".checkUserName",function(){
     	let userId = $(this).parents(".rowTr").find("td.userId").html();
    	let realname = $(this).parents(".rowTr").find("td.realname").text();
		sessionStorage.setItem("type",$("#province").val());
		switch ($("#province").val()) {
		case "month":
			sessionStorage.setItem("year",$("#year1").val());
			break;
		case "season":
			sessionStorage.setItem("year",$("#year2").val());
			break;
		case "year":
			sessionStorage.setItem("year",$("#year3").val());
				break;
		default:
			break;
		}
		
		sessionStorage.setItem("month",$("#month").val());
		sessionStorage.setItem("season",$("#season").val());
		sessionStorage.setItem("start",$("#start").val());
		sessionStorage.setItem("end",$("#end").val());
    	showMbIframe("${webRoot}/signIn/sign_detail?userId=" +userId+"&realname="+realname);
    });
     //点击签到类型次数查看对应的签到明细
	$(document).on("click",".viewSignDetail",function(){
		let userId = $(this).parents(".rowTr").find("td.userId").html();
		let realname = $(this).parents(".rowTr").find("td.realname").text();
		let signType=$(this).attr("data-type");
		sessionStorage.setItem("type",$("#province").val());
		switch ($("#province").val()) {
			case "month":
				sessionStorage.setItem("year",$("#year1").val());
				break;
			case "season":
				sessionStorage.setItem("year",$("#year2").val());
				break;
			case "year":
				sessionStorage.setItem("year",$("#year3").val());
				break;
			default:
				break;
		}

		sessionStorage.setItem("month",$("#month").val());
		sessionStorage.setItem("season",$("#season").val());
		sessionStorage.setItem("start",$("#start").val());
		sessionStorage.setItem("end",$("#end").val());
		showMbIframe("${webRoot}/signIn/sign_detail?userId=" +userId+"&realname="+realname+"&signType="+signType);
	});
	//加载机构选项
    var defaultSelect = true;	//默认选中机构树第一项
    //selectDate修改时间后执行函数
    selectDate.init(function (d){
    	if(isQuery){//机构初始化完成后，手动查询数据，避免首次进入页面重复查询数据
    		if($("#projectDepartId").val()!=null && $("#projectDepartId").val()!=""){
    			   datagridUtil.addDefaultCondition("departId", $("#projectDepartId").val());
    		   }else{
    			   datagridUtil.addDefaultCondition("departId",$("input[name='departPid']").val());
    		 }
			datagridUtil.addDefaultCondition("type", d.type);
			datagridUtil.addDefaultCondition("year", d.year);
			datagridUtil.addDefaultCondition("season", d.season);
			datagridUtil.addDefaultCondition("month", d.month);
			datagridUtil.addDefaultCondition("start", d.start);
			datagridUtil.addDefaultCondition("end", d.end);
			datagridUtil.query();
    	}
    });
    function loadData(){
    	if($("#projectDepartId").val()!=null){
 		   datagridUtil.addDefaultCondition("departId", $("#projectDepartId").val());
 	   }else{
 		   datagridUtil.addDefaultCondition("departId",$("input[name='departPid']").val());
 	   }
		datagridUtil.addDefaultCondition("type", $("#province").val());
		var yearId;
		switch ($("#province").val()) {
		case "month":
			yearId="year1"
			break;
		case "season":
			yearId="year2"
			break;
		case "year":
			yearId="year3"
				break;
		default:
			break;
		}
		datagridUtil.addDefaultCondition("year", $("#"+yearId+"").val());
		datagridUtil.addDefaultCondition("season", $("#season").val());
		datagridUtil.addDefaultCondition("month", $("#month").val());
		datagridUtil.addDefaultCondition("start", $("#start").val());
		datagridUtil.addDefaultCondition("end", $("#end").val());
		datagridUtil.addDefaultCondition("keyWords", $("input[name=keyWords]").val());
		datagridUtil.query();
    }
	$('#myDeaprtTree').tree({
		checkbox : false,
		url : '${webRoot}' + "/detect/depart/getDepartTree.do",
		animate : true,
		onSelect : function(node) {
			$("input[name='departPid']").val(node.id);
			$("input[name='departPName']").val(node.text);
			$('#myDeaprtTree').parent().hide();
			$(".rtBtn").hide();
			loadData();
			//根据权限判断是否查询二期项目信息
			if(Permission.exist("1426-1")){
				$.ajax({
			    	url:"${webRoot}/project/queryProjectByDepartID.do",
			    	type:"POST",
			    	data:{"id":node.id},
			    	dataType:"json",
			    	success:function(data){
			    		 var json = eval(data.obj);
	                    var htmlStr ='<option value="">--全部--</option>';
	                    $("#projectDepartId").empty("");
	                     $.each(json, function(index, item) {
	                        htmlStr+='<option value='+item.departId+'>'+item.projectName+'</option>';
	                     });
			    		$("#projectDepartId").append(htmlStr);
			    		loadData();
			    	}
		    	});
			}
			/* op.defaultCondition=[{queryCode:"departId", queryVal:node.id}];
			
			datagridUtil.addDefaultCondition("type", $("#province").val());
			var yearId;
			switch ($("#province").val()) {
			case "month":
				yearId="year1"
				break;
			case "season":
				yearId="year2"
				break;
			case "year":
				yearId="year3"
					break;
			default:
				break;
			}
			datagridUtil.addDefaultCondition("year", $("#"+yearId+"").val());
			datagridUtil.addDefaultCondition("season", $("#season").val());
			datagridUtil.addDefaultCondition("month", $("#month").val());
			datagridUtil.addDefaultCondition("start", $("#start").val());
			datagridUtil.addDefaultCondition("end", $("#end").val());
			datagridUtil.query(); */
			isQuery=true;
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
			/* setTimeout(function(){
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
			}, 100); */
			
		}
	});
	//录入打卡信息
	function punchClock(){
		$("#addSignModal").modal("toggle");
		//重新拼接用户列表信息
		var obj = datagridUtil.getData();
		$("#signUser").empty();
		for(let i=0;i<obj.length;i++){
			$("#signUser").append('<option value="' + obj[i].userId + '" data-name="'+obj[i].realname+'" >' + obj[i].realname + '</option>');
		}
	}
    /*************************************百度地图相关*******************************************/
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
    </script>
  </body>
</html>
