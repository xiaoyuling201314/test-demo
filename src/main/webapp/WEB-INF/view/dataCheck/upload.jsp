<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/common/resource.jsp"%>
<html>
  <head>
    <title>快检服务云平台</title>
	  <style>
		  .disabled-style{
			  background: #fafafa;
		  }
		  .cs-add-new .cs-name{
			  width: 37%;
		  }
	  </style>
  </head>

  <body>
  <%--<div class="cs-col-lg clearfix">
	  <ol class="cs-breadcrumb">
		  <li class="cs-fl">
			  <img src="${webRoot}/img/set.png" alt="" />
			  <a href="javascript:;">检测数据</a>
		  </li>
		  <li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
		  <li class="cs-b-active cs-fl">数据上传</li>
	  </ol>
	  <div class="cs-search-box cs-fr">
		  <form action="datagrid.do">
			  <div class="cs-input-style cs-fl">
				  类型:
				  <select class="check-date cs-selcet-style focusInput" name="personal" style="width: 100px;">
					  <option value="">--请选择--</option>
					  <option value="0">抽样单</option>
					  <option value="1">送检单</option>
					  <option value="2">订单</option>
				  </select>
			  </div>
			  <span class="check-date cs-fl" style="display: inline;">
				<span class="cs-name">时间范围:</span>
				<span class="cs-in-style cs-time-se cs-time-se">
					<input name="startDate" id="startDate" style="width: 110px;" class="cs-time" type="text" onclick="WdatePicker({maxDate:'#F{$dp.$D(\'endDate\')||\'%y-%M-%d\'}',dateFmt:'yyyy-MM-dd'})">
					<span style="padding:0 5px;">-</span>
					<input name="endDate" id="endDate" style="width: 110px;" class="cs-time" type="text" onclick="WdatePicker({minDate:'#F{$dp.$D(\'startDate\')}',maxDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd'})">
					&nbsp;
				</span>
			  </span>
			  <div class="cs-search-filter clearfix cs-fr">
				  <input class="cs-input-cont cs-fl focusInput" type="text" name="keyWords" placeholder="请输入单号" />
				  <input type="button" onclick="loading();" class="cs-search-btn cs-fl" href="javascript:;" value="搜索">
				  &lt;%&ndash;<span class="cs-s-search cs-fl">高级搜索</span>&ndash;%&gt;
			  </div>
		  </form>
	  </div>
  </div>--%>
  <div id="dataList"></div>

	<!-- 上传 -->
	<div class="modal fade intro2" id="uploadModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	  <div class="modal-dialog cs-lg-width" role="document">
	    <div class="modal-content ">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" id="myModalLabel">上传</h4>
	      </div>
	      <div class="modal-body cs-lg-height">
	    <div class="cs-tabcontent" >
	      <div class="cs-content2">
	      	<form id="saveForm" method="post" action="${webRoot}/dataCheck/recording/uploadData.do">
				<input type="hidden" name="samplingDetailId">
				<input type="hidden" name="dataSource" value="3">
			    <table class="cs-add-new">
					<tr  >
						<td class="cs-name">样品编号：</td>
						<td class="cs-in-style">
							<input  type="text" class="disabled-style" name="samplingDetailCode" disabled="disabled"/>
						</td>
					</tr>
					<tr>
						<td class="cs-name">样品名称：</td>
						<td class="cs-in-style">
							<input  type="text" class="disabled-style"  name="foodName" disabled="disabled"/>
						</td>
					</tr>
					<tr>
						<td class="cs-name">检测项目：</td>
						<td class="cs-in-style">
							<input  type="text" class="disabled-style" name="itemName" disabled="disabled"/>
						</td>
					</tr>
				  <!--
			      <tr>
				  	<td class="cs-name"><i class="cs-mred">*</i>检测仪器：</td>
				  	<td class="cs-in-style">
				  		<select id="devicesSel" name="deviceId" datatype="*" nullmsg="请选择检测仪器" errormsg="请选择检测仪器"></select>
				  	</td>
			      </tr>
			      <tr id="deviceNameTr" style="display:none;">
				  	<td class="cs-name">仪器名称：</td>
				  	<td class="cs-in-style">
				  		<input  type="text" id="deviceName" name="deviceName"/>
				  	</td>
			      </tr>
			      <tr>
				  	<td class="cs-name"><i class="cs-mred">*</i>检测模块-方法：</td>
				  	<td class="cs-in-style">
				  		<select id="moduleSel" name="deviceParameterId" datatype="*" nullmsg="请选择检测模块-方法" errormsg="请选择检测模块-方法"></select>
				  	</td>
			      </tr>
			      -->
			      <tr class="cs-hide">
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
				  	<td class="cs-name"><i class="cs-mred">*</i>检测结果：</td>
				  	<td class="cs-in-style">
				  		<input type="text" name="checkResult" datatype="*" nullmsg="请输入检测值" errormsg="请输入正确检测值"/>&nbsp;&nbsp;(检测值,不用单位)
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

  <!-- 批量上传 -->
  <div class="modal fade intro2" id="uploadModal2" tabindex="-1" role="dialog" aria-labelledby="myModalLabel2">
      <div class="modal-dialog cs-mid-width" role="document">
          <div class="modal-content ">
              <div class="modal-header">
                  <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                  <h4 class="modal-title" id="myModalLabel2">批量上传</h4>
              </div>
              <div class="modal-body cs-mid-height">
                  <div class="cs-tabcontent">
                      <div class="cs-content2">
                          <form id="saveForm2" method="post" action="${webRoot}/dataCheck/recording/uploadData2">
                              <input type="hidden" name="ids">
                              <input type="hidden" name="dataSource" value="3">
                              <table class="cs-add-new">
                                  <tr  >
                                      <td class="cs-name">已选样品：</td>
                                      <td class="cs-in-style">
                                          <input type="text" name="uploadNumber" class="disabled-style" value="0个" readonly="readonly"/>
                                      </td>
                                  </tr>
                                  <tr>
                                      <td class="cs-name">检测结果：</td>
                                      <td class="cs-in-style">
                                          <input type="text" name="checkResult" value="阴性" readonly="readonly"/>
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
                  <button type="button" class="btn btn-success" id="btnSave2">确定</button>
                  <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
              </div>
          </div>
      </div>
  </div>




    <%@include file="/WEB-INF/view/common/confirm.jsp"%>
    <script src="${webRoot}/js/datagridUtil2.js"></script>
    <script type="text/javascript">
	//时间段
	$("input[name='startDate']").val(new Date().DateAdd("d", -6).format("yyyy-MM-dd"));
	$("input[name='endDate']").val(new Date().format("yyyy-MM-dd"));

    var uploadDetailId = '';	//上传检测结果的抽样单明细ID
	var dgu = datagridUtil.initOption({
		tableId: "dataList",
		tableAction: "${webRoot}/dataCheck/recording/datagrid1.do",
		tableBar: {
			title: ["检测数据","数据上传"],
			hlSearchOff: 0,
			ele: [{
				eleShow: Permission.exist("311-15"),
				eleTitle: "类型",
				eleName: "personal",
				eleType: 2,
				eleOption: [{"text":"--全部--","val":""},{"text":"抽样单","val":"0"},{"text":"送检单","val":"1"},{"text":"订单","val":"2"}],
				eleStyle: "width:85px;"
			},{
				eleShow: 1,
				eleTitle: "范围",
				eleName: "samplingDate",
				eleType: 3,
				eleStyle: "width:110px;",
				eleDefaultDateMin: new newDate().DateAdd("m",-1).format("yyyy-MM-dd"),
				eleDefaultDateMax: new newDate().format("yyyy-MM-dd")
			},{
				eleShow: 1,
				eleName: "keyWords",
				eleType: 0,
				elePlaceholder: "样品编号、被检单位、摊位编号、样品名称、检测项目"
			}]
		},
		parameter: [
			{
				columnCode: "samplingDetailCode",
				columnName: "样品编号",
				customStyle:"samplingDetailCode"
			},
			{
				columnCode: "regName",
				columnName: "被检单位 / 委托单位"
			},
			{
				columnCode: "regUserCode",
				columnName: "${systemFlag}"=="1" ? "摊位编号" : "档口编号",
				columnWidth: "8%"
			},
			{
				columnCode: "foodName",
				columnName: "样品名称",
				customStyle:"foodName"
			},
			{
				columnCode: "itemName",
				columnName: "检测项目",
				customStyle:"itemName"
			},
			{
				columnCode: "samplingUsername",
				columnName: "抽样 / 送样人",
				columnWidth: "10%"
			},
			{
				columnCode: "samplingDate",
				columnName: "抽样时间",
				queryType: 1,
				columnWidth: "10%",
				dateFormat: "yyyy-MM-dd HH:mm:ss"
			}
		],
		defaultCondition : [
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
			this.defaultCondition[0].queryVal = $("input[name='startDate']").val();
			this.defaultCondition[1].queryVal = $("input[name='endDate']").val();
		},
		funBtns: [
			{
				show: Permission.exist("1312-1"),
	    		style: Permission.getPermission("1312-1"),
	    		action: function(id){
	    			$("#devicesSel").html("");
	        		$("#moduleSel").html("");
	        		$("#saveForm input[name != 'dataSource']").val("");
	        		$("#saveForm input[name='checkDate']").val(new Date().format("yyyy-MM-dd HH:mm:ss"));
	    			uploadDetailId = id;//id:抽样明细ID
	    			$("#saveForm input[name='samplingDetailId']").val(id);
	    			//遍历查询样品信息
					var rowList=$(".rowTr");
					for (let i = 0; i < rowList.length; i++) {
						if($(rowList[i]).attr("data-rowId")==id){
							$("#saveForm input[name='samplingDetailCode']").val($(rowList[i]).find(".samplingDetailCode").html());
							$("#saveForm input[name='foodName']").val($(rowList[i]).find(".foodName").html());
							$("#saveForm input[name='itemName']").val($(rowList[i]).find(".itemName").html());
							break;
						}
					}
	    			$.ajax({
				        type: "POST",
				        url: '${webRoot}'+"/dataCheck/recording/queryUploadData.do",
				        data: {"samplingDetailId":id},
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
	    			$("#uploadModal").modal("toggle");
	    		}
	    	}
	    ],
		bottomBtns: [{
			show: Permission.exist("1312-1"),
			style: Permission.getPermission("1312-1"),
			action: function(ids, rows){
				if (!rows || rows.length < 1) {
					$("#confirm-warnning .tips").text("请选择数据");
					$("#confirm-warnning").modal('toggle');
					return;
				}

				//抽样单明细ID
				var ids = "";
				for (var i=0; i<rows.length; i++) {
                    ids += rows[i].id + ",";
                }
				ids = ids.substring(0, ids.length-1);

				$("#saveForm2 input[name='ids']").val(ids);
				$("#saveForm2 input[name='uploadNumber']").val(rows.length + "个");
                $("#saveForm2 input[name='checkResult']").val("阴性");
                $("#saveForm2 select[name='conclusion']").val("合格");
                $("#saveForm2 input[name='checkDate']").val(new Date().format("yyyy-MM-dd HH:mm:ss"));
				$("#uploadModal2").modal("show");

			}
		}]
	});
	dgu.queryByFocus();

	//批量上传更改检测结果
	$(document).on("change", "#saveForm2 select[name='conclusion']", function(){
	    if ("合格" == $(this).val()) {
            $("#saveForm2 input[name='checkResult']").val("阴性");
        } else {
            $("#saveForm2 input[name='checkResult']").val("阳性");
        }
    });

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
				dgu.queryByFocus();
        		// delete by xiaoyl 2020/10/19 武陵项目提出去掉弹框提示
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


    //批量上传
    var uf = $("#saveForm2").Validform({
        tiptype:2,
        ajaxPost:true,
        callback:function(data){
            $.Hidemsg();
            $("#uploadModal2").modal("toggle");
            if(data && data.success){
                dgu.queryByFocus();
            }else{
                $("#confirm-warnning .tips").text(data.msg);
                $("#confirm-warnning").modal('toggle');
            }
        }
    });
    $(document).on("click","#btnSave2",function(){
        uf.ajaxPost();
    });

    </script>
  </body>
</html>
