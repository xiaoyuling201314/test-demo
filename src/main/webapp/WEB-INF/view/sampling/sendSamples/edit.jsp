<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/common/resource.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="${webRoot}/css/fileinput.css" />
<link rel="stylesheet" type="text/css" href="${webRoot}/css/theme.css" />
</head>
<!-- 上传 -->
<script src="${webRoot}/js/sortable.js" type="text/javascript"></script>
<script src="${webRoot}/js/fileinput.js" type="text/javascript"></script>
<script src="${webRoot}/js/zh.js" type="text/javascript"></script>
<script src="${webRoot}/js/theme.js" type="text/javascript"></script>

<title>快检服务云平台</title>
<style type="text/css">
	.Validform_checktip{
		display:none;
	}
</style>
</head>
<body>

	<div class="cs-col-lg clearfix">
		<!-- 面包屑导航栏  开始-->
		<ol class="cs-breadcrumb cs-fl">
			<li class="cs-fl"><img src="${webRoot}/img/set.png" alt="" />
			<li class="cs-fl">你送我检</li>
			<li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
			<li class="cs-fl">送检单</li>
			<li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
			<li class="cs-b-active cs-fl">新增送检单</li>
		</ol>

		<!-- 面包屑导航栏  结束-->
		<div class="cs-search-box cs-fr">
			<button class="cs-menu-btn" onclick="parent.closeMbIframe();"><i class="icon iconfont icon-fanhui"></i>返回</button>
		</div>
	</div>
	<div class="cs-tb-box">
		<div class="cs-base-detail">
			<div class="cs-content2 clearfix">
				<form id="samplingForm" action="${webRoot}/sampling/save.do" method="post" enctype="multipart/form-data">
				<input type="hidden" name="details" id="details">
				<input type="hidden" name="personal" value="1" />
					<div class="cs-add-new cs-add-pad">
						<ul class="cs-ul-style clearfix">
							<li class="cs-name cs-sm-w"><i class="cs-mred">*</i>送检人：</li>
							<li class="cs-in-style cs-md-w"><input type="text" name="regName" datatype="*" nullmsg="请输入送检人"/></li>
						
							<li class="cs-name cs-sm-w"><i class="cs-mred">*</i>联系电话：</li>
							<li class="cs-in-style cs-md-w"><input type="text" value="" name="regLinkPhone" datatype="m" nullmsg="请输入联系电话" errormsg="请输入正确的手机号码"/></li>
							<li class="cs-name cs-sm-w">身份证号码：</li>
							<li class="cs-in-style cs-md-w"><input type="text" value="" name="regLicence" /></li>
							<li class="cs-name cs-sm-w">微信：</li>
							<li class="cs-in-style cs-md-w"><input type="text" value="" name="opePhone" /></li>
							<li class="cs-name cs-sm-w">邮箱：</li>
							<li class="cs-in-style cs-md-w"><input type="text" value="" name="regLinkPerson" /></li>
							<li class="cs-name cs-sm-w">地址：</li>
							<li class="cs-in-style cs-md-w"><input type="text" value="" name="opeShopName" /></li>
							<li class="cs-name cs-sm-w">上传附件：</li>
							<li class="cs-in-style cs-md-w">
								<div class="kv-main">
									<input id="kv-explorer" type="file" name="filePath" multiple >
								</div>
							</li>
						</ul>
					</div>
			</div>

		</div>
	</div>
	<!-- 底部导航 结束 -->

	<!-- 抽样明细数据表 start-->
	<div class="cs-tabcontent clearfix" style="">
		<div class="cs-content2" style="overflow-x: auto;">
			<table class="cs-table cs-table-hover table-striped cs-tablesorter">
				<thead>
					<tr>
<!-- 						<th><input type="checkbox" /></th> -->
					    <th class="cs-header">序号</th>
	                    <th class="cs-header" >样品名称</th>
	                    <th class="cs-header" >检测项目</th>
	                    <th class="cs-header">送检数(KG)</th>
<!-- 	                    <th class="cs-header">送样日期</th> -->
	                    <th class="cs-header">购买日期</th>
	                    <th class="cs-header">购买地点</th>
<%--	                    <th class="cs-header">档口</th>--%>
						<th class="cs-header">操作</th>
					</tr>
				</thead>
				<tbody id="cs-add-unable" class="tableDetail">
				</tbody>
			</table>

		</div>

		<!-- 工具栏 -->
		<div class="cs-tools clearfix">
			<div class="clearfix cs-fl">
				<a href="#addModal"  data-toggle="modal" class="cs-menu-btn"><i class="icon iconfont icon-zengjia"></i>新增</a>
			</div>

		</div>
		<!-- 工具栏 -->
	</div>
	<!-- 抽样明细数据表 end-->
	<div class="cs-hd"></div>
	<div class="cs-alert-form-btn">
		<button class="cs-menu-btn" id="samplingBtnSave"><i class="icon iconfont icon-save"></i>保存</button> 
		<button class="cs-menu-btn" onclick="parent.closeMbIframe();"><i class="icon iconfont icon-fanhui"></i>返回</button>
	</div>
</form>
	<!-- 内容主体 结束 -->
	<div class="modal fade intro2" id="addModal"   role="dialog" aria-labelledby="myModalLabel">
		<div class="modal-dialog cs-lg-width" role="document">
			<div class="modal-content ">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">新增</h4>
				</div>
				<div class="modal-body cs-lg-height">
					<!-- 主题内容 -->
					<div class="cs-tabcontent"><!-- cs-main -->
						<div class="cs-content2"><!-- cs-wraper -->
							<form id="saveForm" method="post" action="">
							<input type="hidden" id="foodName" name="foodName" />
							<input type="hidden" id="foodId" name="foodId" />
							<input type="hidden" name="sampleCode" />
							<div width="100%" class="cs-add-new">
								<ul class="cs-ul-form clearfix">
									<li class="cs-name col-md-3" width="20% ">样品名称：</li>
									<li class="cs-in-style col-md-5" style="width: 210px;">
<%--										<select class="js-select2-tags" name="food" id="food" onchange="changeFood(this)" datatype="*" nullmsg="请选择样品名称"></select>--%>
										<%@include file="/WEB-INF/view/data/foodType/selectFoodType2.jsp"%>
									</li>
									<li class="col-xs-4 col-md-4 cs-text-nowrap">
										<div class="Validform_checktip"></div>
										<div class="info">
											<i class="cs-mred">*</i>请选择样品名称
										</div>
									</li>
								</ul>
								<ul class="cs-ul-form clearfix">
									<li class="cs-name col-md-3" width="20% ">检测项目：</li>
									<li class="cs-in-style col-md-5" style="width: 210px;">
											<input type="text" id="detectName" name="itemId" readonly="readonly">
									</li>
									<li class="col-md-4 cs-text-nowrap">
										<div class="Validform_checktip"></div>
										<div class="info">
											<i class="cs-mred">*</i>请选择检测项目
										</div>
									</li>
								</ul>
								<ul class="cs-ul-form clearfix">
									<li class="cs-name col-md-3">送检数(KG)：</li>
									<li class="cs-in-style col-md-5" style="width: 210px;">
									<input type="text" value="0.2" name="sampleNumber" class="inputxt" datatype="*,/^\d*\.{0,1}\d*$/" nullmsg="请输入送检数"  errormsg="请输入正确的数量！" /></li>
									<li class="col-md-4 cs-text-nowrap">
										<div class="info">
											<i class="cs-mred">*</i>请输入送检数
										</div>
									</li>
								</ul>
								<ul class="cs-ul-form clearfix" style="display: none;">
									<li class="cs-name col-md-3">进货数(KG)：</li>
									<li class="cs-in-style col-md-5">
									<input type="text" value="" name="purchaseAmount" class="inputxt" datatype="*,/^\d*\.{0,1}\d*$/" ignore="ignore" nullmsg="请输入进货数"  errormsg="请输入正确的数量！" /></li>
								</ul>
								<ul class="cs-ul-form clearfix">
									<li class="cs-name col-xs-3 col-md-3" width="20% ">购买日期：</li>
									<li class="cs-in-style col-md-5" style="width: 210px;">
									<input class="cs-time" type="text" name="purchaseDate" class="inputxt" onClick="WdatePicker()" value="<fmt:formatDate value='<%=new Date() %>' pattern='yyyy-MM-dd'/>" /></li>
								</ul>
								<ul class="cs-ul-form clearfix">
									<li class="cs-name col-xs-3 col-md-3">购买地点：</li>
									<li class="cs-in-style col-md-5">
									<input type="text" value="" name="origin" class="inputxt" /></li>
								</ul>
								<%--
								<ul class="cs-ul-form clearfix">
									<li class="cs-name col-xs-3 col-md-3">档口名称：</li>
									<li class="cs-in-style col-md-5">
									<input type="text" value="" id="opeShopName" name="opeShopName" class="inputxt" /></li>
								</ul>
								--%>
								<ul class="cs-ul-form clearfix">
									<li class="cs-name col-md-3">备注：</li>
									<li class="cs-in-style cs-modal-input" style="width: 210px;" >
									<textarea class="cs-remark" name="remark" id="" cols="30" rows="10"></textarea></li>
								</ul>
							</div>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-success" id="btnSave">确定</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				</div>
			</form>
			</div>
		</div>
	</div>
 <%@include file="/WEB-INF/view/common/confirm.jsp"%>
  <script type="text/javascript" src="${webRoot}/js/Select2-4.0.2/js/select2.full.min.js"></script>
	<script type="text/javascript">	
	
	var demo;
	var details=[];
	var row=0;
	var editRow;//编辑或删除的数据行号
	var detectItemCount=0;//检测项目数量
	var rootPath="${webRoot}/sampling/";
	$(function() {
		 $("#kv-explorer").fileinput({
	            'theme': 'explorer',
	            'uploadUrl': '#',
	            textEncoding:'UTF-8',
	            language: 'zh', 
	            overwriteInitial: false,
	            initialPreviewAsData: true,
	            dropZoneEnabled: false,
	            showClose:false,
	            maxFileCount:10,
	            browseLabel:'浏览',
	        });
		 var getInfoObj=function(){
		      return  $(this).parents("li").next().find(".info");
		    }
		  
		  $("[datatype]").focusin(function(){
		    if(this.timeout){clearTimeout(this.timeout);}
		    var infoObj=getInfoObj.call(this);
		    if(infoObj.siblings(".Validform_right").length!=0){
		      return; 
		    }
		    infoObj.show().siblings().hide();
		    
		  }).focusout(function(){
		    var infoObj=getInfoObj.call(this);
		    this.timeout=setTimeout(function(){
		      infoObj.hide().siblings(".Validform_wrong,.Validform_loading").show();
		    },0);
		    
		  });
		$("#samplingForm").Validform({
			tiptype:2,
    		beforeSubmit:function(){
    			var formData = new FormData($('#samplingForm')[0]);
    			$.ajax({
    		        type: "POST",
    		        url: rootPath+"saveSendSample.do",
    		        data: formData,
    		        contentType: false, //必须false才会避开jQuery对 formdata 的默认处理 XMLHttpRequest会对 formdata 进行正确的处理 
    		        processData: false, //必须false才会自动加上正确的Content-Type
    		        dataType: "json",
    		        success: function(data){
    		        	if(data && data.success){
    		        		parent.refreshData();	//父页面刷新表格
    		        		parent.closeMbIframe();	//关闭iframe
    		        	}else{
							if (data.msg.indexOf("样品数据异常") != -1) {
								$.removeCookie("FOOD_TYPE_SEL");
							}
    		        		$("#waringMsg>span").html(data.msg);
    		        		$("#confirm-warnning").modal('toggle');
    		        	}
    				},
    				beforeSend: function(){
    					//禁用按钮
    					$('.cs-menu-btn').attr('disabled',true);
    			    },
    			    complete: function(){
    			    	//启用按钮
    			    	$('.cs-menu-btn').attr('disabled',false);
    			    }
    		    });
    			return false;
    		}
		});
		demo = $("#saveForm").Validform({
				tiptype:2,
				beforeSubmit:function(curform){
					$.Hidemsg();
					demo.abort();
					addDetail();
					return false;
				}
			});
	
			// 新增或修改
			$("#btnSave").on("click", function() {
				$(".textbox-prompt").attr({"datatype":"*","nullmsg":"请选择检测项目"});
				demo.submitForm(false);
				return false;
			});
			// 新增或修改
			$("#samplingBtnSave").on("click", function() {
				if($("[name=regName]").val()==""){
					$("#confirm-warnning .tips").text("请填写送检人!");
	    			$("#confirm-warnning").modal('toggle');
				}else if($("[name=regLinkPhone]").val()==""){
					$("#confirm-warnning .tips").text("请填写联系电话!");
	    			$("#confirm-warnning").modal('toggle');
				}else if($(".Validform_error").attr("errormsg")!="" && typeof $(".Validform_error").attr("errormsg")!='undefined'){
					$("#waringMsg>span").html($(".Validform_error").attr("errormsg"));
					$("#confirm-warnning").modal('toggle');
				} else if(details.length!=0){
					$("#details").val(JSON.stringify(details));
					$("#samplingForm").submit();
				}else{
					$("#waringMsg>span").html("请先增加抽样明细");
					$("#confirm-warnning").modal('toggle');
				}
				//$("#waringMsg>span").html($(".Validform_error").attr("errormsg"));
				//$("#confirm-warnning").modal('toggle');
				
				return false;
			});
			// 关闭编辑模态框前重置表单，清空隐藏域
		 	$('#addModal').on('hidden.bs.modal', function(e) {
				$("#foodName").val("");
				$("#foodId").val("");
				 $('.js-select2-tags').select2('val','1');
				var form = $("#saveForm");// 清空表单数据
				form.form("reset");
				$("input[name=parentId]").val("");
				$('#detectName').combobox('loadData', {});
				$("#saveForm").Validform().resetForm();
	    		$("input").removeClass("Validform_error");
	    		$(".Validform_wrong").hide();
	    		$(".Validform_checktip").hide();
	    		$(".info").show();

				//清空样品选项
                cleanFoodSelected();
			});
			$("#addModal").on('show.bs.modal',function(e){
				$("#saveForm").Validform().resetForm();
				$("input").removeClass("Validform_error");
				$(".Validform_wrong").hide();
				$(".info").show();
				$("#detectName").empty();
				if("${systemFlag}"=="1"){
					$("#saveForm input[name=sampleNumber]").val("0.5");
				}
				// loadFood();
			}); 
		
	});

<%--	function changeFood(cko){--%>
<%--		var opt = $(cko).find("option:selected");--%>
<%--		var  foodName=$(opt).text();--%>
<%--		 var foodId=opt.attr('food-id');--%>
<%--		 getDetectItem(foodId);--%>
<%--		 if(foodName){--%>
<%--			 	if(foodName.indexOf("[")!=-1){//判断是否有类别 没有类别则为历史--%>
<%--			 foodName=foodName.substring(5,foodName.length);--%>
<%--			 }--%>
<%--				if(foodName.indexOf("(")!=-1){//判断是否有别名--%>
<%--					foodName=foodName.substring(0,foodName.indexOf("("));--%>
<%--				}--%>
<%--		 }--%>
<%--		 $('input[name=foodName]').val(foodName);--%>
<%--		 $("input[name=foodId]").val(foodId); --%>
<%--	}--%>
<%--	function loadFood(){--%>
<%--		//加载样品信息,选择样品后关联相关检测项目--%>
<%--	  	$("#tt").tree({--%>
<%--    		checkbox:false,--%>
<%--    		url : '${webRoot}' + "/data/foodType/queryFoodTree.do",--%>
<%--    		animate:true,--%>
<%--    		lines:false,--%>
<%--    		onClick : function(node){--%>
<%--//     			if(node.attributes.isFood!=0){//选择具体样品--%>
<%--    				$("#foodId").val(node.id);--%>
<%--        			$("#foodName").val(node.text);--%>
<%--        			$(".cs-check-down").hide();--%>
<%--        		    $("#detectName").combobox({--%>
<%--    					url:'${webRoot}/data/detectItem/queryByFoodId.do?foodId='+node.id,--%>
<%--    					valueField:'id',--%>
<%--    					textField:'detectItemName',--%>
<%--    					multiple: true,//允许在下拉列表里多选--%>
<%--    			      	onSelect:function(record){--%>
<%--    			      		//选择检测项目后关闭下拉选项框--%>
<%--    			      		/* if ($(".combo").prev().combobox("panel").is(":visible")) {--%>
<%--    			      			$(".combo").prev().combobox("hidePanel");--%>
<%--    			         	  } else {--%>
<%--    			         		 $(".combo").prev().combobox("showPanel");--%>
<%--    			         	  }	 */	   --%>
<%--    					},--%>
<%--    					onLoadSuccess:function(){--%>
<%--    						//在数据加载成功后绑定事件--%>
<%--    						$(".combo").click(function(event){--%>
<%--    						 	if(event.target.tagName == "A"){//判断是否为点击右侧倒三角形--%>
<%--    								  /* return false; */--%>
<%--  							     }--%>
<%--    							//点击输入框框显示下拉列表--%>
<%--    							if ($(this).prev().combobox("panel").is(":visible") && event.target.tagName != "INPUT") {--%>
<%--        			      			$(this).prev().combobox("hidePanel");--%>
<%--        			         	  } else {--%>
<%--        			         		 $(this).prev().combobox("showPanel");--%>
<%--        			         	  }	 --%>
<%--    						});--%>
<%--    					}--%>
<%--    				}); --%>
<%--//     			}else{--%>
<%--//     				$("#foodId").val("");--%>
<%--//         			$("#foodName").val("");--%>
<%--//     			}--%>
<%--    		}--%>
<%--    	});--%>
<%--	}--%>

	function addDetail(){
		if(editRow==1){
			row=1;
		}else{
			row ++;
		}
		var foodName=$("[name=foodName]").val()
		var itemId=$('#detectName').combobox('getValues').join(',');
		var itemName=$('#detectName').combobox('getText');
		var sampleNumber=$("[name=sampleNumber]").val();
		var purchaseAmount=$("[name=purchaseAmount]").val();
		var purchaseDate=$("[name=purchaseDate]").val();
		var origin=$("[name=origin]").val();
		var opeShopName=$("#opeShopName").val();
		var remark=$("[name=remark]").val();
		//var supplier=$("[name=supplier]").val();
		//var supplierPerson=$("[name=supplierPerson]").val();
		//var supplierPhone=$("[name=supplierPhone]").val();
		//var supplierAddress=$("[name=supplierAddress]").val();
		//var param1=$("[name=param1]").val();
		detectItemCount+=itemId.split(",").length;
		if(detectItemCount>=10){
			$("#waringMsg>span").html("检测项目超过10个，请重新选择");
			$("#confirm-warnning").modal('toggle');
		}else{
		 	var detail = {sampleCode:row,foodId:$("[name=foodId]").val(),foodName:foodName,itemId:itemId.toString(),itemName:itemName,
		 			sampleNumber:sampleNumber,purchaseAmount:purchaseAmount,
		 			purchaseDate:purchaseDate,origin:origin,opeShopName:opeShopName,remark:remark};
			details.push(detail);
			var html="<tr data-row="+row+">";
				html+="<td class='dNo'>"+row+"</td><td>"+foodName+"</td><td>"+itemName+"</td>";
				html+="<td>"+sampleNumber+"</td><td>"+purchaseDate+"</td>";
				html+="<td>"+origin+"</td>";
				html+="<td>";//<a class='cs-del cs-del-tr' title='编辑'><i class='icon iconfont icon-xiugai'></i></a> 
				html+="<a class='cs-del cs-del-tr' title='删除' onclick='removeDetail("+row+")' ><i class='icon iconfont icon-shanchu text-del'></i></a></td>";
				html+="</tr>";
			$(".tableDetail").append(html);
			$("#addModal").modal("hide");
		}
	}
	
	//获取检测项目
	function getDetectItem(id) {
		  $("#detectName").combobox({
				url:'${webRoot}/data/detectItem/queryByFoodId.do?foodId='+id,
				valueField:'id',
				textField:'detectItemName',
				multiple: true,//允许在下拉列表里多选
		      	onSelect:function(record){
				},
				onLoadSuccess:function(){
					//在数据加载成功后绑定事件
					$(".combo").click(function(event){
					 	if(event.target.tagName == "A"){//判断是否为点击右侧倒三角形
							  /* return false; */
						     }
						//点击输入框框显示下拉列表
						if ($(this).prev().combobox("panel").is(":visible") && event.target.tagName != "INPUT") {
			      			$(this).prev().combobox("hidePanel");
			         	  } else {
			         		 $(this).prev().combobox("showPanel");
			         	  }	 
					});
				}
		  }); 
	}
	function removeDetail(row){
		$("#confirm-delete").modal('toggle');
		editRow=row;
	}
	function deleteData() {
		for (var i = 0; i < details.length; i++) {
			if(details[i].sampleCode==editRow){
				detectItemCount=detectItemCount-details[i].itemId.split(",").length;
				details.remove(details[i]);
			}
		}
		var trs = $(".tableDetail").find("tr");
		for (var i = 0;i < trs.length; i++) {
			if($(trs[i]).attr('data-row')==editRow){
				$(trs[i]).remove();
				resetNo();
			}		
		}
		$("#confirm-delete").modal('toggle');
	}
	//重新设置序号
	function resetNo(){
			var i = 1;
			$(".dNo").each(function(){
				$(this).text(i);
				i++;
			});
	}
	// 数组删除
	Array.prototype.remove = function(val) {
		var index = this.indexOf(val);
		if (index > -1) {
			this.splice(index, 1);
		}
	};
	$('.js-select2-tags').select2();

	//选择食品名称
	$('#food_select2').on('select2:select', function (e) {
		var foodSel2Data = getFoodSelect2Data();
		var fid = foodSel2Data[0].id;
		var fname = foodSel2Data[0].name;
		if (-1 != fname.indexOf("(")) {
			fname = fname.substring(0, fname.indexOf("("));
		}
		if(fid){
			$("input[name='foodId']").val(fid);
			$("input[name='foodName']").val(fname);

			//获取样品检测项目
			getDetectItem(fid);
		}else{
			$("input[name='foodId']").val("");
			$("input[name='foodName']").val("");
			$("#detectName").html("");
		}
	});

	<%--getFood();--%>
	<%--function getFood() {--%>
	<%--	$.ajax({--%>
	<%--		type : "POST",--%>
	<%--		url: "${webRoot}/data/foodType/queryAll.do",--%>
	<%--		data : "",--%>
	<%--		contentType : false, //必须false才会避开jQuery对 formdata 的默认处理 XMLHttpRequest会对 formdata 进行正确的处理--%>
	<%--		processData : false, //必须false才会自动加上正确的Content-Type--%>
	<%--		dataType : "json",--%>
	<%--		success : function(data) {--%>
	<%--			if (data && data.success) {--%>
	<%--			var	foodList = data.obj;--%>
	<%--				if(foodList){--%>
	<%--					var len=foodList.length;--%>
	<%--					var foodhtml="<option selected='selected' >--请选择--</option>";--%>
	<%--					for (var i = 0;i<len; i++) {--%>
	<%--						var foodName = foodList[i].foodName;--%>
	<%--						var id = foodList[i].id;--%>
	<%--						var foodNameOther = foodList[i].foodNameOther;--%>
	<%--						var otherName=foodList[i].foodNameOther;--%>
	<%--						var foodNameEn=foodList[i].foodNameEn;--%>
	<%--						var foodType=foodList[i].isFood;--%>
	<%--						if(foodType==0){--%>
	<%--							foodType='类别';--%>
	<%--						}else{--%>
	<%--							foodType='食品';--%>
	<%--						}--%>
	<%--						foodhtml += '<option data-value="'+foodName+'"  food-id="'+id+'" >['+foodType+']&nbsp;'+foodName;--%>
	<%--						if(otherName&&!foodNameEn){--%>
	<%--							foodhtml +=	'('+otherName+')';--%>
	<%--						}else if(!otherName&&foodNameEn){--%>
	<%--							foodhtml +=	'('+foodNameEn+')';--%>
	<%--						}else if(otherName&&foodNameEn){--%>
	<%--							foodhtml +=	'('+foodNameEn+'、'+otherName+')';--%>
	<%--						}--%>
	<%--						foodhtml+='</option>';--%>

	<%--					}--%>
	<%--					$("#food").append(foodhtml);--%>
	<%--				}--%>
	<%--			}--%>
	<%--		}--%>
	<%--	});--%>
	<%--};--%>

	</script>
</body>
</html>
