<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/common/resource.jsp"%>
<html>
  <head>
    <title>快检服务云平台</title>
    <style type="text/css">
    body{
		padding: 0px !important;
		}
    </style>
  </head>

  <body>

  <div id="dataList"></div>

	<!-- 编辑模态框 start -->
	<div class="modal fade intro2" id="uploadModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	  <div class="modal-dialog cs-mid-width" role="document">
	    <div class="modal-content ">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" id="myModalLabel">上传</h4>
	      </div>
	      <div class="modal-body cs-mid-height">
	    <div class="cs-tabcontent" >
	      <div class="cs-content2">
	      	<form id="saveForm" method="post" action="${webRoot}/dataCheck/recording/uploadData.do">
				<input type="hidden" name="samplingDetailId">
				<input type="hidden" name="dataSource" value="3">
			    <table class="cs-add-new">
			    <tr>
				  	<td class="cs-name"><i class="cs-mred">*</i>检测中心：</td>
				  	<td class="cs-in-style">
				  		<select id="pointSel" name="pointId" datatype="*" nullmsg="请选择检测中心" onchange="queryDevice();">
				  		</select>
				  	</td>
			      </tr>
			      <tr>
				  	<td class="cs-name"><i class="cs-mred">*</i>检测仪器：</td>
				  	<td class="cs-in-style">
				  		<select id="devicesSel" name="deviceId" datatype="*" nullmsg="请选择检测仪器" errormsg="请选择检测仪器"></select>
				  	</td>
			      </tr>
			      <tr id="deviceNameTr" style="display:none;">
				  	<td class="cs-name">仪器名称：</td>
				  	<td class="cs-in-style">
				  		<input type="text" id="deviceName" name="deviceName" autocomplete="off" />
				  	</td>
			      </tr>
			      <!-- <tr>
				  	<td class="cs-name"><i class="cs-mred">*</i>检测模块-方法：</td>
				  	<td class="cs-in-style">
				  		<select id="moduleSel" name="deviceParameterId" datatype="*" nullmsg="请选择检测模块-方法" errormsg="请选择检测模块-方法"></select>
				  	</td>
			      </tr> -->
			      <tr>
				  	<td class="cs-name"><i class="cs-mred"></i>检测模块-方法：</td>
				  	<td class="cs-in-style">
				  		<select id="moduleSel" name="deviceParameterId"></select>
				  	</td>
			      </tr>
			      <tr id="deviceMethodTr" style="display:none;">
				  	<td class="cs-name">检测模块：</td>
				  	<td class="cs-in-style">
				  		<!-- 其他检测项目，输入检测模块 -->
				  		<input type="text" name="deviceMethod"/>
				  	</td>
			      </tr>
			      <tr id="deviceModelTr" style="display:none;">
				  	<td class="cs-name">检测方法：</td>
				  	<td class="cs-in-style">
				  		<!-- 其他检测项目，输入检测方法 -->
				  		<input type="text" name="deviceModel"/>
				  	</td>
			      </tr>
			      <tr>
				  	<td class="cs-name"><i class="cs-mred">*</i>检测结果(检测值)：</td>
				  	<td class="cs-in-style">
				  		<input type="text" name="checkResult" datatype="*" nullmsg="请输入检测值" errormsg="请输入正确检测值"/>
				  	</td>
			      </tr>
			      <tr>
				  	<td class="cs-name"><i class="cs-mred">*</i>检测结论：</td>
				  	<td class="cs-in-style">
				  		<select name="conclusion">
				  			<option>合格</option>
				  			<option>不合格</option>
				  		</select>
				  	</td>
			      </tr>
			      <tr>
				  	<td class="cs-name"><i class="cs-mred">*</i>检测时间：</td>
				  	<td class="cs-in-style">
				  		<input name="checkDate" class="cs-time" type="text" onClick="WdatePicker({startDate:'%y-%M-%d %H:%m:%s',maxDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
				  			 datatype="*" nullmsg="请选择检测时间" errormsg="请选择检测时间"/>
				  	</td>
			      </tr>
			    </table>
			  </form>
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

    <%@include file="/WEB-INF/view/common/confirm.jsp"%>
    <script src="${webRoot}/js/datagridUtil2.js"></script>
    <script type="text/javascript">
	//上传检测结果的抽样单明细ID
    var uploadDetailId='';

	var dgu = datagridUtil.initOption({
		tableId: "dataList",
		tableAction: "${webRoot}/dataCheck/recording/datagridForOrder.do",
		tableBar: {
			title: ["检测数据","数据上传"],
			hlSearchOff: 0,
			ele: [{
				eleShow: 1,
				eleTitle: "范围",
				eleName: "samplingDate",
				eleType: 3,
				eleStyle: "width:110px;",
				eleDefaultDateMin: newDate().DateAdd("d", -6).format("yyyy-MM-dd"),
				eleDefaultDateMax: newDate().format("yyyy-MM-dd")
			},{
				eleShow: 1,
				eleName: "keyWords",
				eleType: 0,
				elePlaceholder: "请输入样品码/试管码"
			}]
		},
		parameter: [
			{
				columnCode: "samplingDetailCode",
				columnName: "样品编号",
				columnWidth: "12%"
			},
			{
				columnCode: "regName",
				columnName: "委托单位",
				columnWidth: "12%"
			},
			{
				columnCode: "tubeCode1",
				columnName: "试管码1",
				columnWidth: "8%"
			},{
				columnCode: "tubeCode2",
				columnName: "试管码2",
				columnWidth: "8%"
			},
			{
				columnCode: "foodName",
				columnName: "样品名称",
				columnWidth: "8%"
			},
			{
				columnCode: "itemName",
				columnName: "检测项目",
				columnWidth: "10%"
			},
			{
				columnCode: "samplingUsername",
				columnName: "送样人",
				columnWidth: "80px"
			}, {
				columnCode: "samplingDate",
				columnName: "下单时间",
				queryType: 1,
				columnWidth: "10%",
				dateFormat: "yyyy-MM-dd HH:mm:ss",
				sortDataType:"date"
			},
			{
				columnCode: "sampleTubeTime",
				columnName: "收样时间",
				queryType: 1,
				columnWidth: "10%",
				dateFormat: "yyyy-MM-dd HH:mm:ss",
                sortDataType:"date"
			}
		],
		defaultCondition : [
			{
				queryCode : "personal",
				queryVal : 2
			},
			{
				queryCode : "startDateStr",
				queryVal : ""
			},
			{
				queryCode : "endDateStr",
				queryVal : ""
			}
		],
		before: function(queryType){
			this.defaultCondition[1].queryVal = $("input[name='startDate']").val();
			this.defaultCondition[2].queryVal = $("input[name='endDate']").val();
		},
		funBtns: [
			{
				show: Permission.exist("1473-1"),
				style: Permission.getPermission("1473-1"),
	    		action: function(id){
	        		$("#pointSel").html("");
	        		$("#saveForm input[name != 'dataSource']").val("");
	        		$("#saveForm input[name='checkDate']").val(new Date().format("yyyy-MM-dd HH:mm:ss"));
	        		
	    			uploadDetailId = id;//id:抽样明细ID
	    			$("#saveForm input[name='samplingDetailId']").val(id);
	    			$.ajax({
				        type: "POST",
				        url: '${webRoot}'+"/detect/basePoint/queryByDepartId.do",
				        data: {"departId":0,"subset":"Y","pointName":""},
				        dataType: "json",
				        async:false,
				        success: function(data){
				        	if(data.obj){
					        	var hasPointId=false;
			        			for(var i=0;i<data.obj.length;i++){
					        	if("${session_user.pointId}"==data.obj[i].id.toString()){
		        					$("#pointSel").append("<option value=\""+data.obj[i].id+"\" selected=\"selected\">"+data.obj[i].pointName+"</option>");
		        					hasPointId=true;
					        	}else{
		        					$("#pointSel").append("<option value=\""+data.obj[i].id+"\">"+data.obj[i].pointName+"</option>");
		        				}
			        			if(!hasPointId){
			        				$("#pointSel option:first").prop("selected","selected");
			        			}
		        			}
			        	}
				        }
	    			});
	    			queryDevice();
	    			$("#uploadModal").modal("toggle");
	    		}
	    	}
	    ],
		onload: function (rows, pageData) {
			if (rows) {
				for (var i = 0; i < rows.length; i++) {
					//已进行订单分拣才能进行数据上传
					if (rows[i].itemName== "" || rows[i].sampleTubeTime== "") {
						$("tr[data-rowid=" + rows[i].id + "]").find(".1473-1").addClass('hide');
					}
				}
			}
		}
	});
	dgu.queryByFocus();
	function queryDevice(){
		$("#devicesSel").html("");
		$("#moduleSel").html("");
		$.ajax({
	        type: "POST",
	        url: '${webRoot}'+"/dataCheck/recording/queryUploadData.do",
	        data: {"samplingDetailId":uploadDetailId,"pointId":$("#pointSel option:selected").val()},
	        dataType: "json",
	        success: function(data){
	        	if(data && data.success){
	        		if(data.obj.devices){
	        			for(var i=0;i<data.obj.devices.length;i++){
	        				if(i==0){
	        					$("#devicesSel").append("<option value=\""+data.obj.devices[i].id+"\" selected=\"selected\">"+data.obj.devices[i].deviceName+"</option>");
	        				}else{
	        					$("#devicesSel").append("<option value=\""+data.obj.devices[i].id+"\">"+data.obj.devices[i].deviceName+"</option>");
	        				}
	        			}
	        		}
	        		if(data.obj.deviceParameters){
	        			for(var i=0;i<data.obj.deviceParameters.length;i++){
	        				if(i==0){
	        					$("#moduleSel").append("<option value=\""+data.obj.deviceParameters[i].id+"\" selected=\"selected\">"
	        							+data.obj.deviceParameters[i].projectType+"&nbsp;-&nbsp;"+data.obj.deviceParameters[i].detectMethod+"</option>");
	        				}else{
	        					$("#moduleSel").append("<option value=\""+data.obj.deviceParameters[i].id+"\">"
	        							+data.obj.deviceParameters[i].projectType+"&nbsp;-&nbsp;"+data.obj.deviceParameters[i].detectMethod+"</option>");
	        				}
	        			}
	        		}
	        		
	        		//模拟修改检测仪器事件，避免检测点仪器为空，页面控件错乱
	        		$("#devicesSel").trigger("change");
	        		
	        	}
			}
	    });
	}
	function loading(){
		if (dgu) {
			dgu.queryByFocus();
		}
	}
    
    $(function(){
    	//隐藏模态框，隐藏、清空仪器名称
	    $('#uploadModal').on('hidden.bs.modal', function () {
	    	$("#deviceNameTr").hide();
			$("#deviceName").val("");
	    });
    });
    //修改检测仪器，重新加载检测模块-方法
    $(document).on("change","#devicesSel",function(){
    	var qtyq = "N";	//选择其他仪器标识
    	if(!$(this).val()){
    		//其他仪器
    		qtyq = "Y";
    		$("#deviceNameTr").show();
    		$("#devicesSel").attr("ignore","ignore");//取消验证
    		$("#moduleSel").attr("ignore","ignore");
    	}else{
    		$("#deviceNameTr").hide();
    		$("#deviceName").val("");
    		$("#devicesSel").removeAttr("ignore");//恢复验证
    		$("#moduleSel").removeAttr("ignore");
    	}
    	
    	$.ajax({
	        type: "POST",
	        url: '${webRoot}'+"/dataCheck/recording/queryUploadData.do",
	        data: {"samplingDetailId":uploadDetailId,"deviceId":$(this).val(),"qt":qtyq},
	        dataType: "json",
	        success: function(data){
	        	if(data && data.success){
	        		$("#moduleSel").html("");
	        		if(data.obj.deviceParameters){
	        			for(var i=0;i<data.obj.deviceParameters.length;i++){
	        				if("其他" == data.obj.deviceParameters[i].projectType){
	        					$("#moduleSel").append("<option value=\""+data.obj.deviceParameters[i].id+"\">"
	        							+data.obj.deviceParameters[i].projectType+"</option>");
	        				}else{
	        					//仪器检测模块、方法
		        				if(i==0){
		        					$("#moduleSel").append("<option value=\""+data.obj.deviceParameters[i].id+"\" selected=\"selected\">"
		        							+data.obj.deviceParameters[i].projectType+"&nbsp;-&nbsp;"+data.obj.deviceParameters[i].detectMethod+"</option>");
		        				}else{
		        					$("#moduleSel").append("<option value=\""+data.obj.deviceParameters[i].id+"\">"
		        							+data.obj.deviceParameters[i].projectType+"&nbsp;-&nbsp;"+data.obj.deviceParameters[i].detectMethod+"</option>");
		        				}
	        				}
	        			}
	        		}
	        		$("#moduleSel").trigger("change");//触发 检测模块-方法 下拉框change事件
	        	}
			}
	    });
    });
    
    //修改检测模块-方法
    $(document).on("change","#moduleSel",function(){
    	
    	var deviceText = $("#devicesSel").find("option:selected").text();//检测仪器名称
    	var moduleText = $(this).find("option:selected").text();//检测模块-方法名称

    	//其他仪器，需要上传检测模块、方法；注册仪器只需上传检测项目ID
    	if(deviceText == "其他"){//其他仪器
    	
	    	if(moduleText == "其他"){
	    		//其他检测模块-方法,展示检测模块、检测方法输入框
	    		$("input[name='deviceMethod']").val("");
    			$("input[name='deviceModel']").val("");
	    		$("#deviceMethodTr").show();
	    		$("#deviceModelTr").show();
	    	}else{
	    		var moduleTextArr = moduleText.split("-");
	    		//非其他检测模块-方法,自动输入选中检测模块-方法
	    		$("input[name='deviceMethod']").val(moduleTextArr[0].trim());
	    		$("input[name='deviceModel']").val(moduleTextArr[1].trim());
	    		$("#deviceMethodTr").hide();
	    		$("#deviceModelTr").hide();
	    	}
    	
    	}else{
    		$("input[name='deviceMethod']").val("");
    		$("input[name='deviceModel']").val("");
    		$("#deviceMethodTr").hide();
    		$("#deviceModelTr").hide();
    	}
    	
    });
    
    //提交验证
	var sf = $("#saveForm").Validform({
		ajaxPost:true,
		callback:function(data){
			$.Hidemsg();
			$("#uploadModal").modal("toggle");
        	if(data && data.success){
				loading();
        		// $("#confirm-warnning .tips").text("上传成功");
    			// $("#confirm-warnning").modal('toggle');
        	}else{
        		$("#confirm-warnning .tips").text(data.msg);
    			$("#confirm-warnning").modal('toggle');
        	}
		}
	});
    
    //提交
    $(document).on("click","#btnSave",function(){
    	$.ajax({
	        type: "POST",
	        url: "${webRoot}/dataCheck/recording/checkUploadData.do",
	        data: $('#saveForm').serialize(),
	        dataType: "json",
	        success: function(data){
	        	
	        	if(data && data.success){
	        		sf.ajaxPost();
	            	return false;
	        	}else{
	        		$("#confirmModal .tips").text("样品已上传检测数据，是否重传？");
	    			$("#confirmModal").modal('toggle');
	        	}
	        	
			}
	    });
    	
    });
    
    //确认重传
	function confirmModal(){
		$("#confirmModal").modal('toggle');
		sf.ajaxPost();
    	return false;
	}
    </script>
  </body>
</html>
