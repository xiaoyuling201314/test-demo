<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/common/resource.jsp"%>

<html>
<head>
<title>快检服务云平台</title>
<style type="text/css">
	.Validform_checktip{
		display:none;
	}
	.cs-gh li {
	/* line-height: 30px; */
	padding: 8px 0px 0px;
}
</style>
<style type="text/css">
/*a  upload */
.a-upload {
	padding: 4px 10px;
	height: 20px;
	line-height: 20px;
	position: relative;
	cursor: pointer;
	color: #888;
	background: #fafafa;
	border: 1px solid #ddd;
	border-radius: 4px;
	overflow: hidden;
	display: inline-block;
	*display: inline;
	*zoom: 1;
}

.a-upload  input {
	position: absolute;
	font-size: 100px;
	right: 0;
	top: 0;
	opacity: 0;
	filter: alpha(opacity = 0);
	cursor: pointer;
}

/*.a-upload:hover {
    color: #444;
    background: #eee;
    border-color: #ccc;
    text-decoration: none;
  }*/
.file {
	position: relative;
	display: inline-block;
	background: url(${webRoot}/img/input.png) no-repeat;
	/*border: 1px solid #99D3F5;*/
	border-radius: 4px;
	padding: 4px 12px;
	overflow: hidden;
	color: #1E88C7;
	text-decoration: none;
	text-indent: 0;
	height: 48px;
	width: 48px;
	line-height: 20px;
}

.file input {
	position: absolute;
	font-size: 100px;
	right: 0;
	top: 0;
	opacity: 0;
}
/*.file:hover {
    background: #AADFFD;
    border-color: #78C3F3;
    color: #004974;
    text-decoration: none;
}*/
.cs-img-upload {
	margin-top: 80px;
	display: inline-block;
}

.cs-obtain {
	width: 45px;
	height: 45px;
}

.cs-upload-info {
	background: #fff;
}

.cs-inline-blcok {
	display: block;
}
.cs-add-new select, .cs-add-new2 select {
    width: 200px;
    height: 29px;
   }
.ul-market-list {
	    height: 28px;
	    white-space: nowrap;
	    cursor: pointer;
	    line-height: 28px;
	    padding-top: 6px;
	    /* padding-left: 20px; */
}
.ul-market-list li{
	padding-left:10px;
}
.ul-market-list li.active{
	background: #f1f1f1;
   	color: #333;
}
.ul-market-list li:hover{    
	background: #ddd;
    color: #1dcc6a;
}
.cs-search-title{
	font-weight: bold;
    padding: 10px 0 5px 0px;
    border-bottom: 1px dotted #ddd;
}
.showDiv img{
	 max-height:90%; 
	max-width:90%;
}
.Validform_checktip{
	display:none;
}
.foodType-tree-list1 input{
	width:100%;
	height:32px;
}
.foodType-tree-list1 li{
	/* padding: 6px; */
    user-select: none;
    -webkit-user-select: none;
    }
.foodType-tree-list1 li:hover{
	background-color: #5897fb;
    color: white;
}
/* .foodType-tree-btn,.foodType-tree-btn2{
	position:absolute;
	right:10px;
	top:10px;
	height:32px;
	color:#006fce;
} */
.select2-container--default .select2-selection--multiple .select2-selection__rendered{
	height:30px;
}
.select2-container--default.select2-container--focus .select2-selection--multiple{
	border: 1px solid #468ad5;
}
.select2-dropdown {
    overflow: hidden;
}
.cs-select-search{
	position:relative;
}
.cs-down-box{
	position:absolute;
	top:30px;
	left:0;
	background:#fff;
	border:1px solid #468ad5;
	width:200px;
	/* height:180px; */
	max-height:260px;
	overflow:auto;
	z-index:999;
	background:#f1f1f1;
	box-shadow:0px 2px 2px #ddd;

}
.cs-down-box li{
	padding:0 0 0 10px;
	line-height: 28px;
}

.cs-down-box li:hover,.cs-down-box li.active{
    background-color: #1e90ff;
    color: #fff;
}
.combobox-item{
	padding:0 0 0 10px;
	line-height:28px;
	font-size:14px;
}
.textbox .textbox-text{
	font-size:14px;
	color:#333;
}


a.text-danger{
	color: #de2525;
}
.btn-danger{
	/*padding:0 10px;*/
}
.btn-danger a{
	color:#fff;
}
.food-selected{
	text-align:left;
	margin-left:-30px;
	color:#333;
}
.food-items .cs-gh{
	padding-left:30px;
}
.food-del{
  margin-top: -4px;
  height:26px;
  line-height: 26px;
}
.food-item-list .cs-gh:last-child{
  padding-bottom:10px;
}
.food-item-list tr{
  line-height: 30px;
}
.food-num input{
  width:100px;
}
.cs-obtain{
	position:relative;
}
.cs-obtain .icon-shanchu{
	position:absolute;
	right:0;
	top:0;
	background:rgba(0,0,0,0.5);
	border-radius:0 0 0 5px;
	cursor:pointer;
	height:18px;
	line-height:18px;
}
.text-danger{
	color: #d63835;
}
.tz-gallery .cs-name{
	line-height:45px;
}
</style>
</head>
<body>

	<div class="cs-col-lg clearfix">
		<!-- 面包屑导航栏  开始-->
		<ol class="cs-breadcrumb cs-fl">
			<li class="cs-fl"><img src="${webRoot}/img/set.png" alt="" />
			<li class="cs-fl">抽样管理</li>
			<li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
			<li class="cs-fl">抽样单</li>
			<li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
			<li class="cs-b-active cs-fl">新增抽样单</li>
		</ol>

		<!-- 面包屑导航栏  结束-->
		<div class="cs-search-box cs-fr">
			<button class="cs-menu-btn" onclick="parent.closeMbIframe();"><i class="icon iconfont icon-fanhui"></i>返回</button>
		</div>
	</div>
	<div class="cs-tb-box">
		<div class="cs-base-detail">
			<div class="cs-content2 clearfix">
				<form id="samplingForm" action="${webRoot}/sampling/save.do" method="post">
					<input type="hidden" name="details" id="details">
					<input type="hidden" name="regName" /> 
					<input type="hidden" name="opeId"/>
					<div class="cs-add-new cs-add-pad">
						<ul class="cs-ul-style clearfix">
					<%-- 		<li class="cs-name cs-sm-w"><i class="cs-mred">*</i>被检单位：</li>
							<li class="cs-in-style cs-md-w">
								<select name="regId" onchange="changeReg(this)" datatype="*" nullmsg="请选择被检单位">
									<option value="">--请选择--</option>
									<c:forEach items="${regObj}" var="reg">
										<option value="${reg.id}" data-name="${reg.regName}" data-user="${reg.linkUser}" data-phone="${reg.linkPhone }">${reg.regName}</option>
									</c:forEach>
								</select>
							</li> --%>
							
								<!-- <li class="cs-name cs-sm-w"><i class="cs-mred">*</i>被检单位：</li>
							<li class="cs-in-style cs-md-w cs-select-search">
								<select class="easyui-combobox  ObjList " name="regId" panelHeight="auto" panelMaxHeight="260px" style="height:29px; width:200px;">
								</select>
							</li> -->
								<li class="cs-name cs-sm-w"><i class="cs-mred">*</i>被检单位：</li>
							<li class="cs-in-style cs-md-w">
								<select class="js-select2-tags" name="regId" id="chooseRegObj" onchange="changeReg(this)" datatype="*" nullmsg="请选择被检单位" errormsg="请选择被检单位">
									<option value="">--请选择--</option>
									<c:forEach items="${regObj}" var="reg">
										<option value="${reg.id}" data-name="${reg.regName}" data-user="${reg.linkUser}" data-phone="${reg.linkPhone }">${reg.regName}</option>
									</c:forEach>
								</select>
							</li>
							<li class="cs-name cs-sm-w">单位负责人：</li>
							<li class="cs-in-style cs-md-w"><input type="text" value="" name="regLinkPerson"/></li>
							<li class="cs-name cs-sm-w">单位联系电话：</li>
							<li class="cs-in-style cs-md-w"><input type="text" value="" name="regLinkPhone"/></li>
							<li class="cs-name cs-sm-w">
								<c:choose>
									<c:when test="${systemFlag==1}">
										摊位编号：
									</c:when>
									<c:otherwise>
										档口编号：
									</c:otherwise>
								</c:choose>
							</li>
							<li class="cs-in-style cs-md-w">
								<select class="form-control js-select2-tags"  name="opeShopCode" id="opeShopCode" onchange="changeOpe(this)">
								</select>
							</li>
							<li class="cs-name cs-sm-w">
								<c:choose>
									<c:when test="${systemFlag==1}">
										摊位名称：
									</c:when>
									<c:otherwise>
										经营户名称：
									</c:otherwise>
								</c:choose>

							</li>
							<li class="cs-in-style cs-md-w"><input type="text" value="" name="opeShopName" /></li>
							<li class="cs-name cs-sm-w">经营者：</li>
							<li class="cs-in-style cs-md-w"><input type="text" value="" name="opeName"/></li>
							<li class="cs-name cs-sm-w">经营者电话：</li>
							<li class="cs-in-style cs-md-w"><input type="text" value="" name="opePhone" /></li>
							<li class="cs-name cs-sm-w cs-hide">任务名称：</li>
							<li class="cs-in-style cs-md-w cs-hide">
								<%--
								<select name="taskId">
									<option value="">--请选择--</option>
									<c:forEach items="${taskList}" var="task">
										<option value="${task.id}">${task.taskTitle}</option>
									</c:forEach>
								</select>
								--%>
								<select class="js-select2-tags" name="taskId">
									<option value="">--请选择--</option>
									<c:forEach items="${taskList}" var="task">
										<option value="${task.id}">${task.taskTitle}</option>
									</c:forEach>
								</select>
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
					    <th class="cs-header" width="80px">序号</th>
	                    <th class="cs-header" width="100px">样品名称</th>
	                    <th class="cs-header" width="150px">检测项目</th>
	                    <th class="cs-header" width="90px">进货日期</th>
	                    <th class="cs-header" width="85px">抽样数(KG)</th>
	                    <th class="cs-header" width="85px">进货数(KG)</th>
	                    <th class="cs-header gyfy" width="85px">购样费用(元)</th>
	                    <th class="cs-header">产地</th>
	                    <th class="cs-header">供应商</th>
	                    <th class="cs-header">批号</th>
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
							<input type="hidden" name="sampleCode" />
								<div width="100%" class="cs-add-new">
									<input type="hidden" id="foodName" name="foodName" />
									<input type="hidden" id="foodId" name="foodId" />
									<ul class="cs-ul-form clearfix">
										<li class="cs-name col-xs-4 col-md-4"><i class="cs-mred">*</i>样品名称 ：</li>
										<li class="cs-in-style cs-select-search cs-modal-input">
											<%@include file="/WEB-INF/view/data/foodType/selectFoodType2.jsp"%>
										</li>
										<li class="col-xs-4 col-md-4 cs-text-nowrap">
											<div class="Validform_checktip"></div>
											<div class="info"></div>
										</li>
									</ul>
									<ul class="cs-ul-form clearfix">
										<li class="cs-name col-xs-4 col-md-4" width="20% "><i class="cs-mred">*</i>检测项目：</li>
										<li class="cs-in-style cs-modal-input" width="210px">
<!-- 											<select id="detectName" name="itemId">datatype="*" nullmsg="请选择检测项目" >
											
											</select> -->
												<input id="detectName" type="text" style="width:200px;" name="itemId" readonly="readonly">
										</li>
										<li class="col-xs-4 col-md-4 cs-text-nowrap">
											<div class="Validform_checktip"></div>
											<div class="info"></div>
										</li>
									</ul>
									<ul class="cs-ul-form clearfix">
										<li class="cs-name col-xs-4 col-md-4"><i class="cs-mred">*</i>抽样数(KG)：</li>
										<li class="cs-in-style cs-modal-input" width="210px">
										<input type="text" value="0.2" name="sampleNumber" class="inputxt" datatype="*,/^\d*\.{0,1}\d*$/" nullmsg="请输入抽样数"  errormsg="请输入正确的数量！" /></li>
										<li class="col-xs-4 col-md-4 cs-text-nowrap">
											<div class="info"></div>
										</li>
									</ul>

									<ul class="cs-ul-form clearfix">
										<li class="cs-name col-xs-4 col-md-4"><i class="cs-mred" id="purchaseAmountShow">*</i>进货数(KG)：</li>
										<li class="cs-in-style cs-modal-input" width="210px">
										<input type="text" value="" name="purchaseAmount" class="inputxt" datatype="*,/^\d*\.{0,1}\d*$/" ignore="ignore" nullmsg="请输入进货数"  errormsg="请输入正确的数量！"   /></li>
										<li class="col-xs-4 col-md-4 cs-text-nowrap">
											<div class="info"></div>
										</li>
									</ul>
									<ul class="cs-ul-form clearfix gyfy">
										<li class="cs-name col-xs-4 col-md-4">购样费用(元)：</li>
										<li class="cs-in-style cs-modal-input" width="210px">
										<input type="text" value="" name="param1" class="inputxt" datatype="*,/^\d*\.{0,1}\d*$/" ignore="ignore" errormsg="请输入数字金额！" /></li>
									</ul>
									<ul class="cs-ul-form clearfix">
										<li class="cs-name col-xs-4 col-md-4" width="20% ">进货日期：</li>
										<li class="cs-in-style cs-modal-input" width="210px">
										<input class="cs-time" type="text" name="purchaseDate" class="inputxt" onClick="WdatePicker()" value="<fmt:formatDate value='<%=new Date() %>' pattern='yyyy-MM-dd'/>" /></li>
									</ul>
									<ul class="cs-ul-form clearfix">
										<li class="cs-name col-xs-4 col-md-4">批号：</li>
										<li class="cs-in-style cs-modal-input" width="210px">
										<input type="text" value="" name="batchNumber" class="inputxt" /></li>
									</ul>
									<ul class="cs-ul-form clearfix">
										<li class="cs-name col-xs-4 col-md-4">产地：</li>
										<li class="cs-in-style cs-modal-input" width="210px">
										<input type="text" value="" name="origin" class="inputxt" /></li>
									</ul>
									<ul class="cs-ul-form clearfix">
										<li class="cs-name col-xs-4 col-md-4">供应商：</li>
										<li class="cs-in-style cs-modal-input" width="210px">
										<input type="text" value="" name="supplier" class="inputxt" /></li>
									</ul>
									<%--
									<ul class="cs-ul-form clearfix">
										<li class="cs-name col-xs-3 col-md-3">供应商联系人：</li>
										<li class="cs-in-style col-xs-4 col-md-4">
										<input type="text" value="" name="supplierPerson" class="inputxt" /></li>
									</ul>
									--%>
									<ul class="cs-ul-form clearfix">
										<li class="cs-name col-xs-4 col-md-4">联系人电话：</li>
										<li class="cs-in-style cs-modal-input" width="210px">
										<input type="text" value="" name="supplierPhone" class="inputxt"/></li>
									</ul>
									<ul class="cs-ul-form clearfix">
										<li class="cs-name col-xs-4 col-md-4">供应商地址：</li>
										<li class="cs-in-style cs-modal-input" width="210px">
										<input type="text" value="" name="supplierAddress" class="inputxt" /></li>
									</ul>
									<%--
									<ul class="cs-ul-form clearfix">
										<li class="cs-name col-xs-3 col-md-3">档口名称：</li>
										<li class="cs-in-style col-xs-4 col-md-4">
										<input type="text" value="" name="opeShopName" class="inputxt" /></li>
									</ul>
									--%>
								</div>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-success" id="btnSaveMutl">确定并新增</button>
					<button type="button" class="btn btn-success" id="btnSave" style="color:#ffffff">保存</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				</div>
			</form>
			</div>
		</div>
	</div>
 <%@include file="/WEB-INF/view/common/confirm.jsp"%>
 <script type="text/javascript" src="${webRoot}/js/Select2-4.0.2/js/select2.full.min.js"></script>
	<script type="text/javascript">
	if (1 != '${showSampleCost}') {
		$(".gyfy").remove();
	}
	var foodList=null;//全部食品列表
	var demo;
	var details=[];
	var row=0;
	var editRow;//编辑或删除的数据行号
	var detectItemCount=0;//检测项目数量
	var rootPath="${webRoot}/sampling/";
	var addDetailBatch=0;//是否批量添加样品：0：否，1 是；批量添加的时候不关闭模态框
	var detectItemId;//上一次选择的检测项目ID
	$(function() {
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
    		        url: rootPath+"save.do",
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
				addDetailBatch=0;
				$(".textbox-prompt").attr({"datatype":"*","nullmsg":"请选择检测项目"});
				demo.submitForm(false);
				return false;
			});
			// 批量新增抽样明细
			$("#btnSaveMutl").on("click", function() {
				addDetailBatch=1;
				$(".textbox-prompt").attr({"datatype":"*","nullmsg":"请选择检测项目"});
				demo.submitForm(false);
				return false;
			});
			// 新增或修改
			$("#samplingBtnSave").on("click", function() {
				if($("#chooseRegObj").val()==""){//校验被检单位不能为空
					$("#waringMsg>span").html("请选择被检单位");
					$("#confirm-warnning").modal('toggle');
				}else if(details.length==0){
					$("#waringMsg>span").html("请先增加抽样明细");
					$("#confirm-warnning").modal('toggle');
				}else{
					$("#details").val(JSON.stringify(details));
					$("#samplingForm").submit();
				}
				return false;
			});
			// 关闭编辑模态框前重置表单，清空隐藏域
		 	$('#addModal').on('hidden.bs.modal', function(e) {
				var form = $("#saveForm");// 清空表单数据
				form.form("reset");
				$("input[name=parentId]").val("");
				$('#detectName').combobox('loadData', {});
				$('#food').select2({
			         placeholder: "请选择",
			         placeholderOption: "first",
			         allowClear: true
			      });
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
					$("#saveForm input[name=purchaseAmount]").removeAttr("ignore");
				}else{
					$("#purchaseAmountShow").addClass("cs-hide");
				}
				//foodSearch("demo");
			}); 
		
	});
	//选择被检单位，加载经营户名称
	function changeReg(cko){
		var opt = $(cko).find("option:selected");
		$("input[name=regName]").val($(opt).text());
		$("input[name=regLinkPerson]").val(opt.attr('data-user'));
		$("input[name=regLinkPhone]").val(opt.attr('data-phone'));
		$("input[name=opeShopCode]").val("");
		$("input[name=opeName]").val("");
		$("input[name=opePhone]").val("");
		var regId=$(cko).val();
		$.ajax({
			url:'${webRoot}/regulatory/business/queryByRegId.do?',
			method:'post',
			data:{"regId":regId},
			success:function(data){
				$("#opeShopCode").empty();
				var html = '<option value="">--请选择--</option>';
				if(data.success){
					var json=eval(data.obj);
					$.each(json, function (index, item) {
						if(item.checked==1){//审核的单位才显示，update by xiaoyl 2022/04/14
							html += '<option value="'+item.opeShopCode+'" data-opeId="'+item.id+'" data-opeShopName="'+item.opeShopName+'" data-opeName="'+item.opeName+'" data-opePhone="'+item.opePhone+'">'+item.opeShopCode+'</option>';
						}
					});
				}
				$("#opeShopCode").append(html);
			}
		});
	}
	// //选择食品名称
	// function changeFood(cko){
	// 	var opt = $(cko).find("option:selected");
	// 	var  foodName=$(opt).text();
	// 	 var foodId=opt.attr('food-id');
	// 	 getDetectItem(foodId);
	// 	 if(foodName){
	// 		 	if(foodName.indexOf("[")!=-1){//判断是否有类别 没有类别则为历史
	// 		 foodName=foodName.substring(5,foodName.length);
	// 		 }
	// 			if(foodName.indexOf("(")!=-1){//判断是否有别名
	// 				foodName=foodName.substring(0,foodName.indexOf("("));
	// 			}
	// 	 }
	// 	 $('input[name=foodName]').val(foodName);
	// 	 $("input[name=foodId]").val(foodId);
	// }
	//选择经营户信息
	function changeOpe(cko){
		var opt = $(cko).find("option:selected");
		$("input[name=opeShopName]").val(opt.attr('data-opeShopName'));
		$("input[name=opeId]").val(opt.attr('data-opeId'));
		$("input[name=opeName]").val(opt.attr('data-opeName'));
		$("input[name=opePhone]").val(opt.attr('data-opePhone'));
	}
	function addDetail(){
		var foodName=$("[name=foodName]").val()
		if(!foodName){
			$("#waringMsg>span").html("请选择样品名称");
			$("#confirm-warnning").modal('toggle');
			return false;
		}
		var itemId=$('#detectName').combobox('getValues').join(',');
		detectItemId=itemId;
		var itemName=$('#detectName').combobox('getText');
		var sampleNumber=$("[name=sampleNumber]").val();
		var purchaseAmount=$("[name=purchaseAmount]").val();
		var purchaseDate=$("[name=purchaseDate]").val();
		var batchNumber=$("[name=batchNumber]").val();
		var origin=$("[name=origin]").val();
		var supplier=$("[name=supplier]").val();
		var supplierPerson=$("[name=supplierPerson]").val();
		var supplierPhone=$("[name=supplierPhone]").val();
		var supplierAddress=$("[name=supplierAddress]").val();
		var param1=$("[name=param1]").val();
		detectItemCount+=itemId.split(",").length;
		// delete by xiaoyl 2020/11/02 武陵项目去掉每个抽样单10条记录限制
		// if(detectItemCount>=10){
		// 	$("#waringMsg>span").html("检测项目超过10个，请重新选择");
		// 	$("#confirm-warnning").modal('toggle');
		// }else{
			if(editRow==1){
				row=1;
			}else{
				row ++;
			}
		 	var detail = {sampleCode:row,foodId:$("[name=foodId]").val(),foodName:foodName,itemId:itemId.toString(),itemName:itemName,
		 			sampleNumber:sampleNumber,purchaseAmount:purchaseAmount,
		 			purchaseDate:purchaseDate,batchNumber:batchNumber,origin:origin,supplier:supplier,
		 			supplierPerson:supplierPerson,supplierPhone:supplierPhone,supplierAddress:supplierAddress,param1:param1};
			details.push(detail);
			var html="<tr data-row="+row+">";
				html+="<td class='dNo'>"+row+"</td><td>"+foodName+"</td><td>"+itemName+"</td>";
				html+="<td>"+purchaseDate+"</td><td>"+sampleNumber+"</td><td>"+purchaseAmount+"</td>";
				if (1 == '${showSampleCost}') {
					html+="<td>"+param1+"</td>";
				}
				html+="<td>"+origin+"</td><td>"+supplier+"</td><td>"+batchNumber+"</td>";
				html+="<td>";//<a class='cs-del cs-del-tr' title='编辑'><i class='icon iconfont icon-xiugai'></i></a> 
				html+="<a class='cs-del cs-del-tr' title='删除' onclick='removeDetail("+row+")' ><i class='icon iconfont icon-shanchu text-del'></i></a></td>";
				html+="</tr>";
			$(".tableDetail").append(html);
			if(addDetailBatch==0){//单个添加样品
				$("#addModal").modal("hide");
			}else{//批量添加样品
				$("input[name='foodId']").val("");
				$("input[name='foodName']").val("");
				cleanFoodSelected();
			}
		// }
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
	// 数组删除
	Array.prototype.remove = function(val) {
		var index = this.indexOf(val);
		if (index > -1) {
			this.splice(index, 1);
		}
	};
	//重新设置序号
	function resetNo(){
		var i = 1;
		$(".dNo").each(function(){
			$(this).text(i);
			i++;
		});
		row=i-1;
	}


	</script>
	<!-- 输入查询功能 -->
	<script type="text/javascript">
	// $(function() {//加载启动
	// 	var objall=0;
	// 	getFood();
	// });


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
	
	/*
	//设置食品列表
	function foodSearch(key) {
		$.fn.modal.Constructor.prototype.enforceFocus = function () {};
		$("#foodList").empty();
		var keyhtml="<option  >--请选择--</option>";
			var len=foodList.length;
 			for (var i = 0;i<len; i++) {
				var foodName = foodList[i].foodName;
				var id = foodList[i].id;
				var foodNameOther = foodList[i].foodNameOther;
				var otherName=foodList[i].foodNameOther;
				var foodNameEn=foodList[i].foodNameEn;
				var foodType=foodList[i].isFood;
				if(foodType==0){
					foodType='类别';
				}else{
					foodType='食品';
				}
				keyhtml += '<option data-value="'+foodName+'"  food-id="'+id+'" >['+foodType+']&nbsp;'+foodName;
				if(otherName&&!foodNameEn){
					keyhtml +=	'('+otherName+')';
				}else if(!otherName&&foodNameEn){
					keyhtml +=	'('+foodNameEn+')';
				}else if(otherName&&foodNameEn){
					keyhtml +=	'('+foodNameEn+'、'+otherName+')';
				}
				keyhtml+='</option>';
			}
			$("#food").append(keyhtml);

	}
	$(document).on('click','#foodName',function(){
	  $('.cs-select-down').siblings('.cs-down-box').show();
	});
	function getFood() {
		if(foodList==null){//当食品列表为空时获取
			$.ajax({
				type : "POST",
				  url: "${webRoot}/data/foodType/queryAll.do",
				data : "",
				contentType : false, //必须false才会避开jQuery对 formdata 的默认处理 XMLHttpRequest会对 formdata 进行正确的处理
				processData : false, //必须false才会自动加上正确的Content-Type
				dataType : "json",
				success : function(data) {
					if (data && data.success) {
						var obj = data.obj;
						foodList = null;
						foodList = data.obj;
						foodSearch("demo");
					}
				}
			});
		}
	};
	*/

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
			//add by xiaoyl 2020/11/05 批量添加抽样明细时，默认匹配上一次选择的检测项目，没有则默认选中第一个检测项目
			let data = $(this).combobox('getData');
			if(data.length>0){
				let chooseItem=0;
				if(detectItemId){//判断当前检测项目是否包含上一次选择的检测项目，包含的话就默认选择上一次的项目
					choseArray=detectItemId.split(",");
					for (let i = 0; i <data.length; i++) {
						for (let j = 0; j < choseArray.length; j++) {
							if(data[i].id==choseArray[j]){
								chooseItem++;
								$('#detectName').combobox('select',data[i].id);
							}
						}
					}
				}
				if(chooseItem==0){//默认选择第一个检测项目
					$('#detectName').combobox('select',data[0].id);
				}
			}
		}
	  });
	}
	 
	 $('.js-select2-tags').select2();
 
	</script>
</body>
</html>
