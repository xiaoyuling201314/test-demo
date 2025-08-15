<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/common/resource.jsp"%>
<html>
<head>
<title>快检服务云平台</title>
<link rel="stylesheet" type="text/css" href="${webRoot}/plug-in/easyui-1.5.2/tree.css">
<style type="text/css">
	.layout-split-west {
		bottom: 50px;
	}
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
<body class="easyui-layout">
	<div data-options="region:'west',split:true,title:'组织机构'" style="width: 200px; padding: 10px;">
		<ul id="departTree" class="easyui-tree"></ul>
	</div>

	<div data-options="region:'north',border:false" style="top: 0px; border: none;">
		<div>
			<!-- 面包屑导航栏  开始-->
			<ol class="cs-breadcrumb">
				<li class="cs-fl"><img src="${webRoot}/img/set.png" alt="" /><a href="javascript:">视频监控</a></li>
				<li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
				<li class="cs-b-active cs-fl">监控管理</li>
			</ol>
			<!-- 面包屑导航栏  结束-->
			<div class="cs-search-box cs-fr">
				<form>
					<input class="cs-input-cont cs-fl focusInput" type="text" name="pointName" placeholder="请输入内容" />
					<input class="cs-search-btn cs-fl" onclick="datagridUtil.queryByFocus();" value="搜索">
					<div class="clearfix cs-fr" id="showBtn"></div>
				</form>
			</div>
		</div>
	</div>

	<div data-options="region:'center'">
		<!-- 列表搜索条件 -->
		<input type="hidden" class="focusInput" name="departId">
		<div id="dataList"></div>
	</div>
	
	<!-- 大弹窗 -->
	<div class="cs-modal-box cs-hide">
	<h5 class="cs-monitor-title text-primary cs-fl">
		<i class="icon iconfont icon-dingwei cs-red-text"></i>&nbsp;<span id="videoName"></span> 
	</h5>
		
		<div class="cs-search-box cs-fr">
			<div class="cs-fr cs-ac ">
				<a onclick="returnBack();" class="cs-monitor-close cs-menu-btn"><i class="icon iconfont icon-fanhui"></i>返回</a>
			</div>
		</div>
		<iframe id="iframe1" style="height:900px;"></iframe>
	</div>
	
	<!-- Modal 3 小-->
	<form id="saveForm" action="${webRoot}/video/surveillance/saveVideo.do" method="POST">
	<div class="modal fade intro2" id="addModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
		<div class="modal-dialog cs-mid-width" role="document">
			<div class="modal-content ">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">监控设备</h4>
				</div>
				<div class="modal-body cs-mid-height">
					<!-- 主题内容 -->
					<div class="cs-tabcontent">
						<div class="cs-content2">
							<table class="cs-add-new">
								<tr>
									<td class="cs-name">所属机构：</td>
									<td class="cs-in-style">
										<div class="cs-all-ps">
											<div class="cs-input-box">
												<input type="hidden" name="id">
												<input type="text" name="departPName" readonly="readonly" datatype="*" ignore="ignore" nullmsg="请选择所属机构" errormsg="请选择所属机构">
												<input type="hidden" name="departPid" datatype="*" ignore="ignore" nullmsg="请选择所属机构" errormsg="请选择所属机构">
												<div class="cs-down-arrow"></div>
											</div>
											<div class="cs-check-down cs-hide" style="display: none;">
												<ul id="myDeaprtTree" class="easyui-tree"></ul>
											</div>
										</div>
									</td>
								</tr>
								<tr>
									<td class="cs-name">所属检测点：</td>
									<td class="cs-in-style">
										<select id="pointSelect" name="pointId" datatype="*" nullmsg="请选择所属检测点" errormsg="请选择所属检测点">
											<option value="">请选择</option>
										</select>
									</td>
								</tr>
								<tr>
									<td class="cs-name">设备名称：</td>
									<td class="cs-in-style">
										<input type="text" name="surveillanceName" datatype="*" nullmsg="请输入设备名称" errormsg="请输入设备名称">
									</td>
								</tr>
								<tr>
									<td class="cs-name">设备IP：</td>
									<td class="cs-in-style">
										<input type="text" name="ip" datatype="*" nullmsg="请输入设备IP" errormsg="请输入设备IP">
									</td>
								</tr>
								<tr>
									<td class="cs-name">设备标识：</td>
									<td class="cs-in-style">
										<input type="text" name="dev" datatype="*" nullmsg="请输入设备标识" errormsg="请输入设备标识">
									</td>
								</tr>
								<tr>
									<td class="cs-name">设备用户名：</td>
									<td class="cs-in-style">
										<input type="text" name="userName" datatype="*" nullmsg="请输入设备用户名" errormsg="请输入设备用户名">
									</td>
								</tr>
								<tr>
									<td class="cs-name">设备密码：</td>
									<td class="cs-in-style">
										<input type="text" name="pwd" datatype="*" nullmsg="请输入设备密码" errormsg="请输入设备密码">
									</td>
								</tr>
							</table>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-success" id="btnSave">确定</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				</div>
			</div>
		</div>
	</div>
	</form>
	
	<!-- 引用模态框 -->
	<%@include file="/WEB-INF/view/common/confirm.jsp"%>

	<!-- 下拉插件 -->
	<script src="${webRoot}/js/select/tabcomplete.min.js"></script>
	<script src="${webRoot}/js/select/livefilter.min.js"></script>
	<script src="${webRoot}/js/select/bootstrap-select.js"></script>
	<script src="${webRoot}/js/select/filterlist.js"></script>
	<!-- JavaScript -->
	<script src="${webRoot}/js/datagridUtil.js"></script>
	<script type="text/javascript">
		var edit=0;
		var editObj;
		var del=0;
		var delObj;
		var monitor=0;
		var monitorObj;
		var replay=0;
		var replayObj;
		for (var i = 0; i < childBtnMenu.length; i++) {
			if (childBtnMenu[i].operationCode == "1375-1") {
				//新增
				var html = '<a class="cs-menu-btn" href="javascript:;" onclick="editVideo(0)"><i class="'+childBtnMenu[i].functionIcon+'"></i>新增</a>';
				$("#showBtn").append(html);
			} else if (childBtnMenu[i].operationCode == "1375-3") {
				//编辑
				edit = 1;
				editObj = childBtnMenu[i];
			} else if (childBtnMenu[i].operationCode == "1375-2") {
				//删除
				deletes = 1;
				deleteObj = childBtnMenu[i];
			} else if (childBtnMenu[i].operationCode == '1375-4'){
				monitor = 1;
				monitorObj = childBtnMenu[i];
			}else if(childBtnMenu[i].operationCode == "1375-6"){//视频回放
	        	replay = 1;
	        	replayObj = childBtnMenu[i];
	        }
		}

		//加载组织机构树形控件数据列表
		loadDepartTree();
		var treeLevel = 1; //控制机构树加载二级数据
		function loadDepartTree() {
			treeLevel = 1;
			$("#departTree").tree({
				url : "${webRoot}/detect/depart/getDepartTree.do",
				animate : true,
				onClick : function(node) {
					$("input[name='departId']").val(node.id);
					datagridUtil.queryByFocus();
				},
				onLoadSuccess : function(node, data) {
					//延迟执行自动加载二级数据，避免与异步加载冲突
					setTimeout(function() {
						if (data && treeLevel == 1) {
							treeLevel++;
							$(data).each(function(index, d) {
								if (this.state == 'closed') {
									var children = $('#departTree').tree('getChildren');
									for (var i = 0; i < children.length; i++) {
										$('#departTree').tree('expand', children[i].target);
									}
								}
							});
						}
					}, 100);
				}
			});
		}
		//所属机构树
		var treeLoadTimes = 1; //控制获取顶级树
		var topNodeId = '';
		var topNodeText = '';
		$('#myDeaprtTree').tree({
			checkbox : false,
			url : '${webRoot}' + "/detect/depart/getDepartTree.do",
			animate : true,
			onClick : function(node) {
				$('#addModal').find("input[name='departPid']").val(node.id);
				$('#addModal').find("input[name='departPName']").val(node.text);
				
				changePoint(node.id);
			},
			onLoadSuccess : function(node, data) {
				//设置新增所属机构为当前用户所属机构
				if (treeLoadTimes == 1) {
					treeLoadTimes++;
					var topNode = $('#myDeaprtTree').tree('getRoot');
					topNodeId = topNode.id;
					topNodeText = topNode.text;
					$('#addModal').find("input[name='departPid']").val(topNode.id);
					$('#addModal').find("input[name='departPName']").val(topNode.text);
				}
			}
		});

		var op = {
			tableId : "dataList", //列表ID
			tableAction : "${webRoot}/video/surveillance/datagrid.do", //加载数据地址
			parameter : [ //列表拼接参数
			{
				columnCode : "pointName",
				columnName : "检测点",
				query : 1
			}, {
				columnCode : "surveillanceName",
				columnName : "设备名称",
				columnWidth : "20%",
				query : 1
			}, {
				columnCode : "registerDate",
				columnName : "注册时间",
				columnWidth : "20%",
				query : 1
			} ],
			funBtns : [//操作列按钮 
			{
				show : monitor,
				style : monitorObj,
				action : function(id) {
					viewMonitor(id);
				}
			} ,{
				show : edit,
				style : editObj,
				action : function(id) {
					editVideo(id);
				}
			},{
				show : replay,
				style : replayObj,
				action : function(id) {
					location.href="${webRoot}/data/lawInstrument/viewPlayBack?id="+id+"&type=2";
				}
			}, {
				show : deletes,
				style : deleteObj,
				action : function(id) {
					if(id == ''){
	    				$("#confirm-warnning .tips").text("请选择监控摄像头");
	    				$("#confirm-warnning").modal('toggle');
	    			}else{
		    			deleteIds = id;
	    				$("#confirm-delete").modal('toggle');
	    			}
				}
			} ],
			bottomBtns : [//底部按钮 
			{
				show : deletes,
				style : deleteObj,
				action : function(ids) {
					if(ids == ''){
	    				$("#confirm-warnning .tips").text("请选择监控摄像头");
	    				$("#confirm-warnning").modal('toggle');
	    			}else{
		    			deleteIds = ids;
	    				$("#confirm-delete").modal('toggle');
	    			}
				}
			} ]
		};
		datagridUtil.initOption(op);

		datagridUtil.query();

		function editVideo(id) {
			if (id) {
				$.ajax({
					url:'${webRoot}/video/surveillance/edit?id='+id,
					success:function(data){
						if(data.obj){
							$("#saveForm input[name=id]").val(data.obj.id);
							$("#saveForm input[name=departPName]").val(data.obj.departName);
							$("#saveForm input[name=departPid]").val(data.obj.departId);
							changePoint(data.obj.departId);
							$("#saveForm select[name=pointId]").val(data.obj.pointId);
							$("#saveForm input[name=surveillanceName]").val(data.obj.surveillanceName);
							$("#saveForm input[name=ip]").val(data.obj.ip);
							$("#saveForm input[name=dev]").val(data.obj.dev);
							$("#saveForm input[name=userName]").val(data.obj.userName);
							$("#saveForm input[name=pwd]").val(data.obj.pwd);
						}
					}
				});
			}
			$("#addModal").modal('toggle');
		}
		
		function changePoint(departId){
			$.ajax({
				url:'${webRoot}/detect/basePoint/queryByDepartId?departId='+departId,
				async:false,
				success:function(data){
					var html = '<option value="">请选择</option>';
					for (var i = 0; i < data.obj.length; i++) {
						var o = data.obj[i];
						html += '<option value="'+o.id+'">'+o.pointName+'</option>';
					}
					$("#pointSelect").html(html);
				}
			});
		}
		
		//验证
		var saveForm=$("#saveForm").Validform({
			tiptype:3,
		    label:".label",
		    showAllError:true,
			callback:function(data){
				$.Hidemsg();
				if(data.success){
					$("#addModal").modal('toggle');
					loadDepartTree();
					//$("#saveForm")[0].reset();
					$("#saveForm select[name=id]").val('');
					$("#saveForm select[name=pointId]").val(data.obj.pointId);
					$("#saveForm input[name=surveillanceName]").val('');
					$("#saveForm input[name=ip]").val('');
					$("#saveForm input[name=dev]").val('');
					$("#saveForm input[name=userName]").val('');
					$("#saveForm input[name=pwd]").val('');
					datagridUtil.query();
					$(document).find("#myDeaprtTree").tree('reload');
				}else{
					$.Showmsg(data.msg);
				}
			}
		});
		
		// 新增或修改
		$("#btnSave").on("click", function() {
			saveForm.ajaxPost();
		});
		
		//查看监控摄像头
		function viewMonitor(id){
			var obj = datagridOption.obj;
			for (var i = 0; i < obj.length; i++) {
				if(obj[i].id==id){
					$("#videoName").text(obj[i].pointName+" "+ obj[i].surveillanceName);
				}
			}
			$("#iframe1").attr("src", "${webRoot}/video/surveillance/viewMonitor.do?id="+id);
			$('.cs-modal-box').show();
		}
		//关闭监控摄像头，返回list
		function returnBack(){
			$("#iframe1").attr("src", "");
			$('.cs-modal-box').hide();
		}
		
		//重写确认模态框函数
		var deleteIds;
		function deleteData(){
			var idsStr = "{\"ids\":\""+deleteIds.toString()+"\"}";
				$.ajax({
					type: "POST",
					url: '${webRoot}'+"/video/surveillance/delete.do",
					data: JSON.parse(idsStr),
					dataType: "json",
					success: function(data){
						if(data && data.success){
							//删除成功后刷新列表
							loadDepartTree();
							datagridUtil.query();
						}else{
							$("#confirm-warnning .tips").text(data.msg);
							$("#confirm-warnning").modal('toggle');
						}
					}
				});
			$("#confirm-delete").modal('toggle');
		}
	</script>
</body>
</html>
