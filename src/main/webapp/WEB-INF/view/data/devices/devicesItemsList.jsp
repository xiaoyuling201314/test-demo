<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/common/resource.jsp"%>
<html>
<head>
<title>快检服务云平台</title>
</head>
<body>
	<div class="cs-col-lg clearfix">
		<!-- 面包屑导航栏  开始-->
		<ol class="cs-breadcrumb">
			<li class="cs-fl"><img src="${webRoot}/img/set.png" alt="" /> <a
				href="javascript:">检测点管理</a></li>
			<li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
			<li class="cs-fl">快检点</li>
			<li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
			<li class="cs-fl">检测点详情</li>
			<li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
			<li class="cs-b-active cs-fl">仪器检测项目</li>
		</ol>
		<!-- 面包屑导航栏  结束-->
		<div class="cs-search-box cs-fr">
            <div class="clearfix cs-fr" id="showBtn">
	        	<a href="javascript:" onclick="self.history.back();" class="cs-menu-btn"><i class="icon iconfont icon-fanhui"></i>返回</a>
            </div>
		</div>
	</div>
	<div id="dataList"></div>
	<!-- 内容主体 结束 -->
	
	<!-- 引用模态框 -->
	<%@include file="/WEB-INF/view/common/confirm.jsp"%>
	
	<!-- JavaScript -->
	<script src="${webRoot}/js/datagridUtil.js"></script>
	<script type="text/javascript">
	/* 
	var view=0;
	var viewObj;
	for (var i = 0; i < childBtnMenu.length; i++) {
		if (childBtnMenu[i].operationCode == "391-4") {
  			//查看
			view = 1;
			viewObj=childBtnMenu[i];
  		}else if (childBtnMenu[i].operationCode == "391-2") {
			//编辑
			edit = 1;
			editObj=childBtnMenu[i];
		}else if (childBtnMenu[i].operationCode == "391-3") {
			//删除
			deletes = 1;
			deleteObj=childBtnMenu[i];
		}
	}
	 */
	
	var op = {
			tableId: "dataList",	//列表ID
			tableAction: '${webRoot}'+"/data/devicesItem/datagrid.do",	//加载数据地址
			parameter: [		//列表拼接参数
				{
					columnCode: "itemName",
					columnName: "检测项目",
					columnWidth: "20%"
				},
				{
					columnCode: "projectType",
					columnName: "检测模块",
					columnWidth: "20%"
				},
				{
					columnCode: "detectMethod",
					columnName: "检测方法",
					columnWidth: "20%"
				},
				{
					columnCode: "priority",
					columnName: "优先级别",
					columnWidth: "10%",
					customElement: "<input name='priority' type='text' value='?' data-value='?' disabled='disabled' style='width:50px;'>"
				},
				{
					columnCode: "checked",
					columnName: "状态",
					columnWidth: "10%",
					customElement: "<select class='itemChecked' data-value='?' disabled='disabled'><option value='1'>启用</option><option value='0'>禁用</option></select>"
				}
			],
			defaultCondition: [	//加载数据条件
				{
					queryCode: "baseBean.deviceId",
					queryVal: "${deviceId}"
				}
			],
			funBtns: [
		    	{
		    		show: (Permission.exist("391-19") ? Permission.exist("391-19") : Permission.exist("1497-19")),
					style: (Permission.exist("391-19") ? Permission.getPermission("391-19") : Permission.getPermission("1497-19")),
		    		action: function(id){
		    			$(".rowTr").each(function(){
		    				if($(this).attr("data-rowId") == id){
				    			//启用输入框
		    					$(this).find("input[name='priority']").removeAttr("disabled");
		    					$(this).find("select").removeAttr("disabled");
		    					
		    					var i = 0;	//按钮序号
				    			$(this).find(".operationButton").each(function(){
					    			if(i == 0){
						    			//隐藏编辑按钮
					    				$(this).hide();
					    			}else{
					    				//显示保存取消按钮
					    				$(this).show();
					    			}
					    			i++;
				    			});
		    				}
		    			});
		    		}
		    	},
		    	{
		    		show: 0,
		    		text: "<span class=\"cs-table-save text-primary\">保存</span>",
		    		action: function(id){
		    			$(".rowTr").each(function(){
		    				if($(this).attr("data-rowId") == id){
				    			//启用输入框
		    					$(this).find("input[name='priority']").attr("disabled","disabled");
		    					$(this).find("select").attr("disabled","disabled");
		    					
		    					var priority = $(this).find("input[name='priority']").val();
		    					var checked = $(this).find("select").val();
		    					
		    					var thisElement = $(this);
		    					//提交
		    					$.ajax({
				    		        type: "POST",
				    		        url: '${webRoot}'+"/data/devicesItem/save.do",
				    		        data: {"id":id,"priority":priority,"checked":checked},
				    		        dataType: "json",
				    		        async: false,
				    		        success: function(data){
				    		        	if(data && data.success){
				    		        		//重设input data-value
				    		        		thisElement.find("input[name='priority']").data("value",priority);
				    		        		thisElement.find("select").data("value",checked);
				    		        	}
				    				}
				    		    });
		    					
		    					
		    					var i = 0;	//按钮序号
				    			$(this).find(".operationButton").each(function(){
					    			if(i == 0){
					    				//隐藏保存取消按钮
					    				$(this).show();
					    			}else{
						    			//显示编辑按钮
					    				$(this).hide();
					    			}
					    			i++;
				    			});
		    				}
		    			});
		    		}
		    	},
		    	{
		    		show: 0,
		    		text: "<span class=\"cs-table-cancel text-muted\">取消</span>",
		    		action: function(id){
		    			$(".rowTr").each(function(){
		    				if($(this).attr("data-rowId") == id){
				    			//禁用输入框
		    					$(this).find("input[name='priority']").attr("disabled","disabled");
		    					$(this).find("select").attr("disabled","disabled");
		    					
		    					console.log($(this).find("input[name='priority']").val());
		    					//还原值
		    					$(this).find("input[name='priority']").val($(this).find("input[name='priority']").data("value"));
		    					$(this).find("select").val($(this).find("select").data("value"));
		    					
		    					var i = 0;	//按钮序号
				    			$(this).find(".operationButton").each(function(){
					    			if(i == 0){
					    				//隐藏保存取消按钮
					    				$(this).show();
					    			}else{
						    			//显示编辑按钮
					    				$(this).hide();
					    			}
					    			i++;
				    			});
		    				}
		    			});
		    		}
		    	}
		    ],
		    onload: function(){	//加载完成后执行函数
		    	//设置启用状态
		    	var ics = document.getElementsByClassName("itemChecked");
		    	for(var i=0;i<ics.length;i++){
		    		ics[i].value = ics[i].getAttribute("data-value");
		    	}
		    }
		};
		datagridUtil.initOption(op);
		
	    datagridUtil.query();
	    
		//删除仪器项目
		/* var deleteIds = "";
		function deleteData(){
			var idsStr = "{\"ids\":\""+deleteIds.toString()+"\"}";
    		$.ajax({
    	        type: "POST",
    	        url: '${webRoot}'+"/data/deviceSeries/detectParameter/delete.do",
   		        data: JSON.parse(idsStr),
   		        dataType: "json",
   		        success: function(data){
		        	$("#confirm-delete").modal('toggle');
   		        	if(data && data.success){
		        		//删除成功后刷新列表
		        		datagridUtil.query();
		        	}else{
		        		$("#confirm-warnning .tips").text('删除失败');
		        		$("#confirm-warnning").modal('toggle');
		        	}
				}
		    });
		} */
	</script>
</body>
</html>
