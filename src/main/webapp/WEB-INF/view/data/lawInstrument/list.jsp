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
      body{
      	text-align:center;
      }
	</style>
</head>
<body class="easyui-layout">
	<div data-options="region:'north',border:false" style="top: 0px; border: none;">
		<div>
			<!-- 面包屑导航栏  开始-->
			<ol class="cs-breadcrumb">
				<li class="cs-fl"><img src="${webRoot}/img/set.png" alt="" /><a href="javascript:">视频监控</a></li>
				<li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
				<li class="cs-b-active cs-fl">执法记录仪</li>
			</ol>
			<!-- 面包屑导航栏  结束-->
			<div class="cs-search-box cs-fr">
				 <form>
					<input class="cs-input-cont cs-fl focusInput" type="text" name="devIdno" placeholder="请输入内容" />
					<input class="cs-search-btn cs-fl" onclick="datagridUtil.queryByFocus();" value="搜索">
					<div class="clearfix cs-fr" id="showBtn"></div>
				</form> 
			</div>
		</div>
	</div>

	<div data-options="region:'center'">
		<div id="dataList"></div>
	</div>
	
	<!-- 大弹窗 -->
	<div class="cs-modal-box cs-hide" id="videoModal" style="margin: 0 auto;">
		<div data-options="region:'north',border:false" style="top: 0px; border: none;">
			<div class="cs-col-lg">
				<!-- 面包屑导航栏  开始-->
				<ol class="cs-breadcrumb">
					<li class="cs-fl"><img src="${webRoot}/img/set.png" alt="" /><a href="javascript:">视频监控</a></li>
					<li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
					<li class="cs-b-active cs-fl">执法记录仪</li>
				</ol>
			</div>
		</div>
		<div class="cs-search-box cs-fr">
			<div class="cs-fr cs-ac ">
				<a onclick="returnBack();" class="cs-monitor-close cs-menu-btn"><i class="icon iconfont icon-fanhui"></i>返回</a>
			</div>
		</div>
		
		<iframe id="iframe1" style="width: 730px;height:547px; padding: 40px;margin: 0 auto;"></iframe>
	</div>
	
	<!-- Modal 3 小-->
<form id="saveForm"   method="POST">
	<div class="modal fade intro2" id="addModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
		<div class="modal-dialog cs-mid-width" role="document">
			<div class="modal-content ">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">执法仪</h4>
				</div>
				<input type="hidden" name="id" id="id"  >
				<div class="modal-body cs-mid-height">
					<!-- 主题内容 -->
					<div class="cs-tabcontent">
						<div class="cs-content2">
							<table class="cs-add-new">
								<!-- <tr>
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
								<tr> -->
							
											<td class="cs-name"><i class="cs-mred">*</i>设备号：</td>
									<td class="cs-in-style">
										<input type="text" name="devIdno" id="devIdno" datatype="*" nullmsg="请输入设备号" errormsg="请输入设备号">
									</td>
								<tr>
									<td class="cs-name">设备名称：</td>
									<td class="cs-in-style">
										<input type="text" name="vehiIdno" id="vehiIdno" datatype="*" nullmsg="请输入设备名称" errormsg="请输入设备名称">
									</td>
								</tr>
							</table>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-success" id="btnSave" onclick="save();">确定</button>
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
	<%@include file="/WEB-INF/view/common/modalBox.jsp" %>
	<!-- JavaScript -->
	<script src="${webRoot}/js/datagridUtil.js"></script>
	<script type="text/javascript">
		var edit=0;
		var editObj;
		var del=0;
		var delObj;
		var monitor=0;
		var monitorObj;
		var playback=0;
		var playbackObj;
		for (var i = 0; i < childBtnMenu.length; i++) {
			if (childBtnMenu[i].operationCode == "1408-3") {
				var html='<a class="cs-menu-btn" onclick="getId();"><i class="'+childBtnMenu[i].functionIcon+'"></i>'+childBtnMenu[i].operationName+'</a>';
				$("#showBtn").append(html);
			}else if (childBtnMenu[i].operationCode == "1408-1") {
				monitor=1;
				monitorObj=childBtnMenu[i];
			}  else if (childBtnMenu[i].operationCode == "1408-2") {
				playback=1;
				playbackObj=childBtnMenu[i];
			} else if (childBtnMenu[i].operationCode == "1408-4") {
				//编辑
				edit = 1;
				editObj = childBtnMenu[i];
			} else if (childBtnMenu[i].operationCode == "1408-5" ) {
				//删除
				deletes = 1;
				deleteObj = childBtnMenu[i];
			}
		}


		var op = {
			tableId : "dataList", //列表ID
			tableAction : "${webRoot}/data/lawInstrument/datagrid.do", //加载数据地址
			parameter : [ //列表拼接参数
				  {
						columnCode : "devIdno",
						columnName : "设备号",
						query : 1
			},{
				columnCode : "vehiIdno",
				columnName : "设备名称",
				query : 1
			},{
				columnCode : "online",
				columnName : "在线状态",
				customVal: {"1":"在线","0":"离线"},
			columnWidth : "100px"
			}, {
				columnCode : "lastLoginDate",
				columnName : "最后登录时间"
			} ],
			funBtns : [//操作列按钮 
				{
					show : edit,
					style : editObj,
					action : function(id) {
						//queryById(id);
						getId(id);
					}
				},{
				show : monitor,
				style : monitorObj,
				action : function(id) {
					viewMonitor(id);
				}
			},{ 
				show : playback,
				style : playbackObj,
				action : function(id) {
					var url="${webRoot}/data/lawInstrument/viewPlayBack?id="+id+"&type=1";
			        showMbIframe(url);
				}
			}, {
				show : deletes,
				style : deleteObj,
				action : function(id) {
						deleteIds = id;
						$("#confirm-delete").modal('toggle');
				}
			} ]
		};
		datagridUtil.initOption(op);

		datagridUtil.query();

		//查看执法仪直播
 		function viewMonitor(id){
			$.ajax({
				url:'${webRoot}/data/lawInstrument/viewMonitor?id='+id,
				success:function(data){
					$("#iframe1").attr("src", "http://125.46.86.22:88/808gps/open/player/video.html?lang=zh&devIdno="+data.devIdno+"&account=gzdyxx&password=000000&chanel=1");
					$('#videoModal').show();
				}
			});
		} 
		//关闭监控摄像头，返回list
		function returnBack(){
			$("#iframe1").attr("src", "");
			$('.cs-modal-box').hide();
		}
		
		
		
		  function getId(id){
		    	if(id){
			    	$.ajax({
				    	url:'${webRoot}'+"/data/lawInstrument/queryById.do",
				    	type:"POST",
				    	data:{"id":id},
				    	dataType:"json",
				    	success:function(data){
				    	      if(data.obj){
				    	    	  $("#id").val(data.obj.id);
				    	    	  $("#devIdno").val(data.obj.devIdno);
				    	    	  $("#vehiIdno").val(data.obj.vehiIdno);
				    	      }
				    	}
			    	});
					$("#addModal .modal-title").text("编辑");
					
				}else{
					$("#addModal .modal-title").text("新增");
				}
				$("#addModal").modal("show");
		    }
		
		  
			//关闭编辑模态框前重置表单，清空隐藏域
	    	$('#addModal').on('hidden.bs.modal', function (e) {
				 var form = $("#saveForm");// 清空表单数据
		    	 form.form("reset");
	   
	    	})
	    	
 	function save() {
	    	var devIdno= 	$("#devIdno").val();
	    	if(devIdno==""||devIdno==null){
	    		$("#confirm-warnning .tips").text("设备号不能为空");
				$("#confirm-warnning").modal('toggle');
				return;
	    	}
  	    	 
	    		$.ajax({
					type : "POST",
					url : '${webRoot}'+"/data/lawInstrument/save.do",
					data : $('#saveForm').serialize(),
					dataType : "json",
					success : function(data) {
						if (data.success) {
							$("#addModal").modal("hide");
							 datagridUtil.query();
						} else {
						$("#confirm-warnning .tips").text(data.msg);
							$("#confirm-warnning").modal('toggle');
						}
					}
				})
	}
		 
				//删除仪器
				function deleteData() {
					$.ajax({
						type : "POST",
						url : '${webRoot}' + "/data/lawInstrument/delete.do",
						data : {
							"ids" : deleteIds
						},
						dataType : "json",
						success : function(data) {
							if (data && data.success) {
								self.location.reload();
							} else {
								$("#confirm-delete").modal('toggle');
								$("#confirm-warnning .tips").text('删除失败');
								$("#confirm-warnning").modal('toggle');
							}
						}
					});
				}
	</script>
</body>
</html>
