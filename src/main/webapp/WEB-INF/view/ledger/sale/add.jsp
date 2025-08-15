<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/common/resource.jsp"%>
<html>
<head>
<title>快检服务云平台</title>
<style type="text/css">
input[type="file"] {
	border: 0;
}

input[type="file"]:focus {
	outline: 0;
	border: 0;
}

#content {
	width: 500px;
	height: 170px;
	margin: 100px auto;
}

#imgbox-loading {
	position: absolute;
	top: 0;
	left: 0;
	cursor: pointer;
	display: none;
	z-index: 90;
}

#imgbox-loading div {
	background: #FFF;
	width: 100%;
	height: 100%;
}

#imgbox-overlay {
	position: absolute;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background: #000;
	display: none;
	z-index: 80;
}

.imgbox-wrap {
	position: absolute;
	top: 0;
	left: 0;
	display: none;
	z-index: 90;
}

.imgbox-img {
	padding: 0;
	margin: 0;
	border: none;
	width: 100%;
	height: 100%;
	vertical-align: top;
	border: 10px solid #fff;
}

.imgbox-title {
	padding-top: 10px;
	font-size: 11px;
	text-align: center;
	font-family: Arial;
	color: #333;
	display: none;
}

.imgbox-bg-wrap {
	position: absolute;
	padding: 0;
	margin: 0;
	display: none;
}

.imgbox-bg {
	position: absolute;
	width: 20px;
	height: 20px;
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
    .ul-size-list{
	    height: 28px;
	    white-space: nowrap;
	    cursor: pointer;
	    line-height: 28px;
	    padding-top: 6px;
	    /* padding-left: 20px; */
}
.ul-size-list li{
	padding: 0 0 0 10px ;
	line-height: 30px;
}
.ul-size-list li:hover{
	    color: #468ad5;
	    background:#ddd;
}
.cs-select-search{
	position:relative;
}
.cs-down-box{
	position:absolute;
	top:38px;
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
/* .cs-down-box li:first-child{
	color:#333;
	background:#fff;
} */
</style>

</head>
<body>

	<div class="cs-col-lg clearfix">
		<!-- 面包屑导航栏  开始-->
		<ol class="cs-breadcrumb cs-fl">
			<li class="cs-fl"><img src="${webRoot}/img/set.png" alt="" />
			<li class="cs-fl">台账管理</li>
			<li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
			<li class="cs-fl">监管对象</li>
		<c:if test="${showReg!=1}"><li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
			<li class="cs-fl">经营户</li></c:if>
			<li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
			<li class="cs-b-active cs-fl">销售台账</li>
		</ol>

		<!-- 面包屑导航栏  结束-->
		<div class="cs-search-box cs-fr">
			<!-- <a class="cs-menu-btn" href="javascript:history.go(-1);"><i class="icon iconfont icon-fanhui"></i>返回</a> -->
				<c:if test="${winType!=1 }">
			 <a class="cs-menu-btn" href="javascript:history.go(-1);"><i class="icon iconfont icon-fanhui"></i>返回</a> 
		</c:if>
		<c:if test="${winType==1 }">
		<a onclick="parent.closeMbIframe()" class="cs-menu-btn"><i class="icon iconfont icon-fanhui"></i>返回</a>
		</c:if>
		</div>
	</div>
	<div class="cs-tb-box">
		<div class="cs-base-detail">
			<div class="cs-content2 clearfix">
				<form id="saleForm" action="#" method="post"  enctype="multipart/form-data">
					<input type="hidden" name="details" id="details"> <input type="hidden" name="id" value="${sale.id }"> <input type="hidden" name="regName" /> <input type="hidden" id="businessId" name="businessId" value="${sale.businessId }" />
					<div class="cs-add-new cs-add-pad">
					<ul class="cs-ul-style clearfix">
							<li class="cs-name cs-sm-w"><i class="cs-mred">*</i>所在市场：</li>
							<li class="cs-in-style cs-md-w"><select class="js-select2-tags" name="regId" id="regId" onchange="changeReg()" datatype="*" nullmsg="请选择市场">
									<option value="">--请选择--</option>
									<c:forEach items="${regObj}" var="reg">
										<option value="${reg.id}" data-name="${reg.regName}" data-user="${reg.linkUser}" <c:if test="${reg.id==sale.regId }">selected</c:if> <c:if test="${reg.id==regId}">selected</c:if> data-phone="${reg.linkPhone }">${reg.regName}</option>
									</c:forEach>
							</select></li>
							<c:if test="${showReg!=1}">
							<li class="cs-name cs-sm-w"><i class="cs-mred">*</i>档口编号：</li>
							<li class="cs-in-style cs-md-w"><select class="js-select2-tags" name="opeId" id="opeId" onchange="changeOpe1()" datatype="*" nullmsg="请选择档口编号" errormsg=""></select>
							<li class="cs-name cs-sm-w">经营户：</li>
							<li class="cs-in-style cs-md-w"><input type="text" style="padding-right: 0;" id="opeShopName" value=""   readonly="readonly"></li>
							</c:if>	</ul>
						<ul class=" cs-gh clearfix">
						<%-- 	<li class="cs-name cs-sm-w"><i class="cs-mred">*</i>食品名称：</li>
							<li class="cs-in-style cs-md-w cs-select-search"><input type="text"  id="foodName"  name="foodName"  value="${bean.foodName }" onclick="getFood();"datatype="*" nullmsg=""   readonly="readonly"/>
								<input type="text" id="foodName"  name="foodName" onclick="getFoodHistory();" autocomplete="off" class="cs-select-down" value="${sale.foodName }" >
								<div class="cs-down-box cs-hide">
								
										<ul  id="foodList">
										</ul>
								</div>
							</li> --%>
								<li class="cs-name cs-sm-w"><i class="cs-mred">*</i>食品名称：</li>
							<li class="cs-in-style cs-md-w cs-select-search"><%-- <input type="text"  id="foodName"  name="foodName"  value="${bean.foodName }" onclick="getFood();"datatype="*" nullmsg=""   readonly="readonly"/> --%>
								<input type="text" id="foodName"  name="foodName" onclick="getFoodHistory();" autocomplete="off" class="cs-select-down food" value="${sale.foodName }" datatype="*" nullmsg=""   >
								<div class="cs-down-box cs-hide" id="foodBox">
								<input type="hidden" value="${sale.foodName }" id="food">
										<ul  id="foodList">
										</ul>
								</div>
							</li>
							<li class="cs-name cs-sm-w"><i class="cs-mred">*</i>销售数量：</li>
							<li class="cs-in-style cs-md-w"><input type="text" value="${sale.saleCount }" name="saleCount" id="saleCount"  datatype="*" nullmsg="供货商不能为空" /></li>
								<li class="cs-name cs-sm-w"><i class="cs-mred">*</i>规格单位：</li>
							<li class="cs-in-style cs-md-w" style="height: 38px;">
									<div class="cs-all-ps">
										<div class="cs-input-box">
												<input type="text"name="size" id="size"  autocomplete="off" <c:if test="${!empty sale.size }"> value="${sale.size }"</c:if>  <c:if test="${empty sale.size }"> value="KG"</c:if> datatype="*" />
											<input type="hidden" id="departId" name="departId" datatype="*" nullmsg=" " errormsg=" ">
											<div class="cs-down-arrow"></div>
										<span class="Validform_checktip Validform_wrong"> </span></div>
										<div class="cs-check-down cs-hide" style="display: none;">
											<ul id="sizeList" class="ul-size-list">
											<li>KG</li>
											<li>只</li>
											<li>个</li>
											<li>头</li>
											<li>件</li>
											<li>箱</li>
											</ul>
										</div>
									</div>
							</li>
							<li class="cs-name cs-sm-w">销售日期：</li>
							<li class="cs-in-style cs-md-w"><input class="cs-time" type="text" name="saleDate" class="inputxt" onClick="WdatePicker({maxDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true})" 
							<c:if test="${empty sale.saleDate }">value="<fmt:formatDate value='<%=new Date()%>' pattern='yyyy-MM-dd'/>"</c:if>
							 	<c:if test="${!empty sale.saleDate }">value="<fmt:formatDate  value='${sale.saleDate }' pattern='yyyy-MM-dd'/>" </c:if>/>
							</li>
							<li class="cs-name cs-sm-w"><i class="cs-mred">*</i>销售对象：</li>
							<li class="cs-in-style cs-md-w cs-select-search">
								<input type="text" class="cs-select-down" autocomplete="off" onclick="getObjHistory(1);"  value="${sale.cusRegName }" name="cusRegName" id="cusRegName">
								<div class="cs-down-box cs-hide">
										<ul  id="ObjList">
										</ul>
								</div>
							</li>
							<li class="cs-name cs-sm-w">销售档口：</li>
							<li class="cs-in-style cs-md-w cs-select-search">
							<input type="text" class="cs-select-down" autocomplete="off"  name="customer" onclick="getObjHistory(0);" id="customer" value="${sale.customer }">
								<div class="cs-down-box cs-hide">
										<ul  id="OpeList">
										</ul>
								</div>
							</li>
							<li class="cs-name cs-sm-w">联系电话：</li>
							<li class="cs-in-style cs-md-w"><input type="text" value="${sale.cusPhone }" name="cusPhone" id="cusPhone"  /></li>
										<li class="cs-name cs-sm-w" >备注：</li>
										<li class="cs-in-style cs-modal-input" width="210px"><textarea name="memo" id="memo"cols="30" rows="10" style="height: 80px;">${sale.memo }</textarea></li>
										<li class="col-xs-4 col-md-4 cs-text-nowrap">
											<div class="Validform_checktip"></div>

										</li>
						</ul>
					</div>
				</form>
			</div>
		</div>
	</div>
	<!-- 底部导航 结束 -->
	<div class="cs-alert-form-btn clearfix">
		<a href="javascript:" class="cs-menu-btn" id="saleBtnSave"><i class="icon iconfont icon-save"></i>保存</a>
	<c:if test="${empty sale.id}">	<a href="javascript:" class="cs-menu-btn" id="saleBtnSaveself"><i class="icon iconfont icon-save"></i>保存并新增</a> </c:if>
		<!-- <a href="javascript:history.go(-1);" class="cs-menu-btn"><i class="icon iconfont icon-fanhui"></i>返回</a> -->
	<c:if test="${winType!=1 }">
			 <a class="cs-menu-btn" href="javascript:history.go(-1);"><i class="icon iconfont icon-fanhui"></i>返回</a> 
		</c:if>
		<c:if test="${winType==1 }">
		<a onclick="parent.closeMbIframe()" class="cs-menu-btn"><i class="icon iconfont icon-fanhui"></i>返回</a>
		</c:if>
	</div>
	<%@include file="/WEB-INF/view/common/confirm.jsp"%>
		<script type="text/javascript" src="${webRoot}/js/jquery.form.js"></script>
	<script type="text/javascript">
	var htmlType='${htmlType}';
	var listI = -1;
	var downList=-28;
	var showReg='${showReg}';//1是市场录入台账 0 经营户
	var down=$('.cs-down-box li').eq(listI).height();
	$("#saveForm").Validform({
 		beforeSubmit:function(){
 		 
 		}
 	});
	document.onkeydown=function(event){
		var e = event || window.event || arguments.callee.caller.arguments[0];
		var display = $('.cs-down-box').css('display');
		var down=$('.cs-down-box li').eq(listI).height();
		 
		if(display=='block'){
			if(e && e.keyCode==13){
				    
					var foodName=$('.cs-down-box li.active').html();
					 if(foodName){
						 	if(foodName.indexOf("[")!=-1){//判断是否有类别 没有类别则为历史
						 foodName=foodName.substring(10,foodName.length);
						 }
							if(foodName.indexOf("(")!=-1){//判断是否有别名
								foodName=foodName.substring(0,foodName.indexOf("("));
							}
					 }
					 $('#foodName').val(foodName);
					 setTimeout(function(){
						 $("#foodBox").hide();
					 },100);
					 //$("#foodBox").hide();
			}else if(e && e.keyCode==38){
				listI--;
				if(listI<0){
					downList=-28;
					listI=-1;
					down=0;
				}
				downList-=down;
				$(".cs-down-box").scrollTop(downList);
				$('.cs-down-box li').eq(listI).addClass('active').siblings().removeClass('active');
				}
			else if(e && e.keyCode==40){
					listI++;
					downList+=down;
						$(".cs-down-box").scrollTop(downList); 
						/* alert($('.cs-down-box li').eq(listI).height()); */
					$('.cs-down-box li').eq(listI).addClass('active').siblings().removeClass('active');
					if(listI > $('.cs-down-box li').length){
						downList=-28;
						listI=-1;
						down=0;
						$('.cs-down-box li').eq(listI).addClass('active').siblings().removeClass('active');
						
					}
					
				}
				
			}
		
		}; 

		var foodList=null;//全部食品列表
		var foodHisList =null;//历史食品
		var objList=null;
			$(document).on('click','.cs-select-down',function(){
				$(this).siblings('.cs-down-box').toggle();
		       // e.stopPropagation();
		      
			})
			$(".cs-select-down").on('change',function(){
				$(this).siblings('.cs-down-box').show();
			});
			   /* $(window).click(function(){
			     $(".cs-down-box").hide();
			   }); */
			   var timer=null;
			   $(document).on('blur','.cs-select-down',function(){
				   var this_=$(this);
				   timer=setTimeout(function(){
					   this_.siblings(".cs-down-box").hide();
					   var foodName=$('#foodName').val();
						if(foodName){
					   checkFood(foodName);
						}
	               },300);
				});
	           $(".cs-down-box ul li").mouseover(function(){
	        	   clearTimeout(timer);
	        	   $(".cs-down-box").show();
	           });
	       	//市场列表点击
	   		$(document).on('click','#ObjList li',function(){
	   			 $(this).addClass('active').siblings().removeClass('active'); 
	   			 var cusRegName=$('#ObjList li.active').html();
	   			 $('#cusRegName').val(cusRegName);
	   			$('.cs-select-down').siblings('.cs-down-box').hide();
	   		});
	   			//档口列表点击
	   		$(document).on('click','#OpeList li',function(){
	   			 $(this).addClass('active').siblings().removeClass('active'); 
	   			 var customer=$('#OpeList li.active').html();
	   			 $('#customer').val(customer);
	   			$('.cs-select-down').siblings('.cs-down-box').hide();
	   		});
				//单位列表点击
				$(document).on('click','.sizeList li',function(){
					
					 $(this).addClass('active').siblings().removeClass('active'); 
					 
					 var size=$(this).html();
					 /* $('.size').val(size); */
					 $(this).parents('.cs-down-box').siblings('.cs-select-down').val(size);
					$('.cs-select-down').siblings('.cs-down-box').hide();
				});
			//食品列表点击
			$(document).on('click','#foodList li',function(){
				 $(this).addClass('cs-active').siblings().removeClass('cs-active'); 
				 var foodName=$('#foodList li.cs-active').html();
				 if(foodName){
					 	if(foodName.indexOf("[")!=-1){//判断是否有类别 没有类别则为历史
					 foodName=foodName.substring(10,foodName.length);
					 }
						if(foodName.indexOf("(")!=-1){//判断是否有别名
							foodName=foodName.substring(0,foodName.indexOf("("));
						}
				 }
				 $('#foodName').val(foodName);
				$('.cs-select-down').siblings('.cs-down-box').hide();
			});
					
		$(function() {//加载启动
			getFood();
				$("#foodName").bind('input porpertychange',function(){
					var  key=$("#foodName").val();
					if(key == null | key == ""){
						getFoodHistory();
						return;
					}
					
					if(foodList){
						foodSearch(key);
					}else{
						getFood();
						if(foodList){
							foodSearch(key);
						}else{
							
						}
					}
				});
				
				//市场输入框输入
				$("#cusRegName").bind('input porpertychange',function(){
					var  key=$("#cusRegName").val();
					if(key == null | key == ""){
						getObjHistory(1);
						return;
					}
					if(objList){
						objSearch(key);
					}else{
						//getObjList();
						if(objList){
							objSearch(objList);
						}else{
							
						}
					}
					
				}); 
				
			});
		function foodSearch(key) {
			$("#foodList").empty();
			var keyhtml="";
			var foodsearchhtmlS = "";
			var foodsearchhtml = "";
			for (var i = 0; i < foodList.length; i++) {
				if(foodList[i].isFood!=0){
				var foodName = foodList[i].foodName;
				var foodNameOther = foodList[i].foodNameOther;
				var otherName=foodList[i].foodNameOther;
    			var foodNameEn=foodList[i].foodNameEn;
    			var foodType=foodList[i].isFood;
    			if(foodType==0){
    				foodType='类别';
    			}else{
    				foodType='食品';
    			}
				if (foodName.indexOf(key) != -1 || foodNameOther.indexOf(key) != -1) {
					if(foodName==key&& keyhtml==""){//当key==foodName
		       				if(!otherName&&!foodNameEn){
		       					keyhtml += '<li data-value="'+foodName+'" class="mui-table-view-cell mui-indexed-list-item">['+foodType+']&nbsp;'+foodName+'</li>';
		        			}else if(otherName&&!foodNameEn){
		        				keyhtml += '<li data-value="'+foodName+'" class="mui-table-view-cell mui-indexed-list-item">['+foodType+']&nbsp;'+foodName+'('+otherName+')</li>';
		        			}else{
		        				keyhtml += '<li data-value="'+foodName+'" class="mui-table-view-cell mui-indexed-list-item">['+foodType+']&nbsp;'+foodName+'('+foodNameEn+'、'+otherName+')</li>';
		        			}
					}else  if(foodName==key&& keyhtml!=""){//关键字去重
						
					}else if(foodName.indexOf(key)==0&&foodName!=key){
	       				if(!otherName&&!foodNameEn){
	       					foodsearchhtmlS += '<li data-value="'+foodName+'" class="mui-table-view-cell mui-indexed-list-item">['+foodType+']&nbsp;'+foodName+'</li>';
	        			}else if(otherName&&!foodNameEn){
	        				foodsearchhtmlS += '<li data-value="'+foodName+'" class="mui-table-view-cell mui-indexed-list-item">['+foodType+']&nbsp;'+foodName+'('+otherName+')</li>';
	        			}else{
	        				foodsearchhtmlS += '<li data-value="'+foodName+'" class="mui-table-view-cell mui-indexed-list-item">['+foodType+']&nbsp;'+foodName+'('+foodNameEn+'、'+otherName+')</li>';
	        			}
					}else {
	       				if(!otherName&&!foodNameEn){
	       				foodsearchhtml += '<li data-value="'+foodName+'" class="mui-table-view-cell mui-indexed-list-item">['+foodType+']&nbsp;'+foodName+'</li>';
	        			}else if(otherName&&!foodNameEn){
	        				foodsearchhtml += '<li data-value="'+foodName+'" class="mui-table-view-cell mui-indexed-list-item">['+foodType+']&nbsp;'+foodName+'('+otherName+')</li>';
	        			}else{
	        			foodsearchhtml += '<li data-value="'+foodName+'" class="mui-table-view-cell mui-indexed-list-item">['+foodType+']&nbsp;'+foodName+'('+foodNameEn+'、'+otherName+')</li>';
	        			}
					}
				}
				}
			}
			$("#foodList").append(keyhtml+foodsearchhtmlS+foodsearchhtml);
		}
		//市场搜索
		function objSearch(key) {
			$("#ObjList").empty();
			var objsearchhtml = "";
			for (var i = 0; i < objList.length; i++) {
				var regName = objList[i].regName;
				if (regName.indexOf(key) != -1) {
					objsearchhtml+='<li>'+regName+'</li>';
				}
			}
			$("#ObjList").append(objsearchhtml);
		}
		
		var saveOrUpdate = false;//保存或者保存并新增
		var demo;
		var details = [];
		var row = 0;
		var editRow;//编辑或删除的数据行号
		var detectItemCount = 0;//检测项目数量
		var rootPath = "${webRoot}/ledger/sale/";
		$(function() {
			var getInfoObj = function() {
				return $(this).parents("li").next().find(".info");
			}

			$("[datatype]").focusin(function() {
				if (this.timeout) {
					clearTimeout(this.timeout);
				}
				var infoObj = getInfoObj.call(this);
				if (infoObj.siblings(".Validform_right").length != 0) {
					return;
				}
				infoObj.show().siblings().hide();

			}).focusout(function() {
				var infoObj = getInfoObj.call(this);
				this.timeout = setTimeout(function() {
					infoObj.hide().siblings(".Validform_wrong,.Validform_loading").show();
				}, 0);

			});
			function saveSale() {
				var showReg='${showReg}';
				var regId = $("#regId").val();
				if(regId == null || regId == ""){
					$("#confirm-warnning .tips").text("请选择市场!");
					$("#confirm-warnning").modal('toggle');
					return;
				}
				if(showReg!=1){
					var busid=$("#opeId").val();
					if(busid == null || busid == ""){
						$("#confirm-warnning .tips").text("请选择档口编号!");
						$("#confirm-warnning").modal('toggle');
						return;
					}
				}
				var foodName = $("#foodName").val();
				if (foodName == null || foodName == "") {
					//alert("检测模块名不能为空！");
					$("#confirm-warnning .tips").text("食品名称不能为空!");
					$("#confirm-warnning").modal('toggle');
					return;
				}
				var saleCount=$("#saleCount").val();
				if (saleCount == null || saleCount == "") {
					$("#confirm-warnning .tips").text("销售数量不能为空!");
					$("#confirm-warnning").modal('toggle');
					return;
				}
				var cusRegName=$("#cusRegName").val();
				if (cusRegName == null || cusRegName == "") {
					$("#confirm-warnning .tips").text("销售对象不能为空!");
					$("#confirm-warnning").modal('toggle');
					return;
				}
				
				var businessId = $("#businessId").val();
				var regTypeId='${regTypeId}';
				$.ajax({
					type : "POST",
					url : '${webRoot}'+"/ledger/sale/save.do",
					data : $('#saleForm').serialize(),
					dataType : "json",
					success : function(data) {
						if (data.success) {
							if(saveOrUpdate){
								clearInput();
								$("#confirm-warnning .tips").text(data.msg);
								$("#confirm-warnning").modal('toggle'); 
							}else{
							$.Showmsg(data.msg);
							if(htmlType==1){
								self.location = "${webRoot}/ledger/stock/list.do?regTypeId="+regTypeId+"&htmlType="+htmlType+"&ledgerType=2&regId=" + regId  ;
								}else if(htmlType==3){
									self.location = "${webRoot}/ledger/stock/htmlType="+htmlType+"&ledgerList.do?regTypeId="+regTypeId+"&regId="+regId ;
								} else{
									self.location = "${webRoot}/ledger/stock/list.do?regTypeId="+regTypeId+"&ledgerType=2&regId=" + regId + "&businessId=" + businessId;
								}
							}
						} else {
						$("#confirm-warnning .tips").text(data.msg);
							$("#confirm-warnning").modal('toggle');
						}
					}
				})
			}
			function changeReg1() {
				var opt = $("#regIds").find("option:selected");
				$("input[name=regName]").val($(opt).text());
				$("input[name=opeShopCode]").val("");
				$("input[name=opeName]").val("");
				$("input[name=opePhone]").val("");
				var regId = $("#regIds").val();
				var businessId = '${empty bean.businessId}';//这是查看
				if (businessId == "true") {
					businessId = '${businessId}';//新增获取
				} else {
					businessId = '${bean.businessId}';
				}
				$.ajax({
					url : '${webRoot}/regulatory/business/queryByRegId.do?',
					method : 'post',
					data : {
						"regId" : regId
					},
					success : function(data) {
						$("#companys").empty();
						var html = '<option value="">--请选择--</option>';
						if (data.success) {
							var json = eval(data.obj);
							$.each(json, function(index, item) {
								html += '<option value="' + item.opeShopCode+'"></option>';
							});
						}
						$("#companys").append(html);

					}
				});
			}
			// 新增或修改
			$("#saleBtnSave").on("click", function() {
				saveOrUpdate = false;
				//$("#saleForm").submit();
				fangdianji();
				saveSale();
				return false;
			});
			$("#saleBtnSaveself").on("click", function() {
				saveOrUpdate = true;
				fangdianji();
				//$("#saleForm").submit();
				saveSale();
				return false;
			});

		});
		function loadFood() {
			//加载样品信息,选择样品后关联相关检测项目
			$("#tt").tree({
				checkbox : false,
				url : '${webRoot}' + "/data/foodType/queryFoodTree.do",
				animate : true,
				lines : false,
				onClick : function(node) {
					//     			if(node.attributes.isFood!=0){//选择具体样品
					$("#foodId").val(node.id);
					$("#foodName").val(node.text);
					$(".cs-check-down").hide();
					$("#detectName").combobox({
						url : '${webRoot}/data/detectItem/queryByFoodId.do?foodId=' + node.id,
						valueField : 'id',
						textField : 'detectItemName',
						multiple : true,//允许在下拉列表里多选
						onSelect : function(record) {
						},
						onLoadSuccess : function() {
							//在数据加载成功后绑定事件
							$(".combo").click(function(event) {
								if (event.target.tagName == "A") {//判断是否为点击右侧倒三角形
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
			});
		}

		$(function() {
			changeReg();
			loadFood();
			getObj();
		});
		//选择市场，加载经营户名称
		function changeReg() {
			var opt = $("#regId").find("option:selected");
			$("input[name=regName]").val($(opt).text());
			$("input[name=regLinkPerson]").val(opt.attr('data-user'));
			$("input[name=regLinkPhone]").val(opt.attr('data-phone'));
			$("input[name=opeShopCode]").val("");
			$("input[name=opeName]").val("");
			$("input[name=opePhone]").val("");
			var regId = $("#regId").val();
			var businessId = '${empty sale.businessId}';//这是查看
			if (businessId == "true") {
				businessId = '${businessId}';//新增获取
			} else {
				businessId = '${sale.businessId}';
			}
			$.ajax({
				url : '${webRoot}/regulatory/business/queryByRegId.do?',
				method : 'post',
				data : {
					"regId" : regId
				},
				success : function(data) {
					$("#opeId").empty();
					var html = '<option value="">--请选择--</option>';
					if (data.success) {
						var json = eval(data.obj);
						$.each(json, function(index, item) {
							html += '<option value="' + item.id+ '"opeShopName="' + item.opeShopName + '" data-opeShopCode="' + item.opeShopCode + '" data-opeName="'
									+ item.opeName + '" data-opePhone="' + item.opePhone + '"';
							if (businessId == item.id) {
								html += 'selected';
								$("#businessId").val(item.id);
								$("#opeShopName").val(item.opeShopName);
							}
							html += '>' + item.opeShopCode + '</option>';
						});
					}
					$("#opeId").append(html);
				}
			});
		}

		//选择经营户信息
		function changeOpe(cko) {
			var opt = $(cko).find("option:selected");
			$("input[name=opeShopName]").val($(opt).text());
			$("input[name=opeShopCode]").val(opt.attr('data-opeShopCode'));
			$("input[name=opeName]").val(opt.attr('data-opeName'));
			$("input[name=opePhone]").val(opt.attr('data-opePhone'));
			var regId = $(cko).val();
			//加载营业执照信息
			$.ajax({
				url : '${webRoot}/regulatory/business/queryByRegId.do?',
				method : 'post',
				data : {
					"regId" : regId
				},
				success : function(data) {
					//$("#opeId").empty();
					var html = "<option value=''></option>";
					var num = '${sale.businessId}'; //获取input中输入的数字
					$.each(data, function(index, item) {
						var d = data[index];
						html += '<option value="' + d.id + '" <c:if test="d.id==num">selected</c:if>     data-opeShopCode="'
								+ d.opeShopCode + '" data-opeName="' + d.opeName + '" data-opePhone="' + d.opePhone + '">'
								+ d.opeShopCode + '</option>';
						if (d.id == num) {

						}

					});
					$("#supplier").append(html);
				}
			});
		}
		
		function changeOpe1() {//这是选择所在档口信息
			var opt = $("#opeId").find("option:selected").val();
			$("input[name=businessId]").val(opt);
			$("#opeShopName").val($("#opeId").find("option:selected").attr("opeShopName"));
		}
		function addDetail() {
			row++;
			var foodName = $("[name=foodName]").val()
			var saleCount = $("[name=saleCount]").val();
			var saleDate = $("[name=saleDate]").val();//进货日期
			var batchNumber = $("[name=batchNumber]").val();
			var expirationDate = $("[name=expirationDate]").val();//保质期
			var productionDate = $("[name=productionDate]").val();
			var productionPlace = $("[name=productionPlace]").val();
			var size = $("[name=size]").val();
			var detail = {
				foodName : foodName,
				saleCount : saleCount,
				saleDate : saleDate,
				size : size,
				batchNumber : batchNumber,
				expirationDate : expirationDate,
				productionDate : productionDate,
				productionPlace : productionPlace
			};
			details.push(detail);
			var html = "<tr data-row="+row+">";
			html += "<td>" + row + "</td><td>" + foodName + "</td>";
			html += "<td>" + saleCount + "</td><td></td>";
			html += "<td>" + productionDate + "</td><td>" + expirationDate + "</td><td>" + productionPlace + "</td><td>"
					+ batchNumber + "</td><td>" + saleDate + "</td>";
			html += "<td>";//<a class='cs-del cs-del-tr' title='编辑'><i class='icon iconfont icon-xiugai'></i></a> 
			html += "<a class='cs-del cs-del-tr' title='删除' onclick='removeDetail(" + row
					+ ")' ><i class='icon iconfont icon-shanchu text-del'></i></a></td>";
			html += "</tr>";
			$(".tableDetail").append(html);
			$("#addModal").modal("hide");
		}
		function removeDetail(row) {
			$("#confirm-delete").modal('toggle');
			editRow = row;
		}
		function deleteData() {
			for (var i = 0; i < details.length; i++) {
				if (details[i].sampleNO == editRow) {
					details.remove(details[i]);
				}
			}
			var trs = $(".tableDetail").find("tr");
			for (var i = 0; i < trs.length; i++) {
				if ($(trs[i]).attr('data-row') == editRow) {
					$(trs[i]).remove();
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
	</script>
	<script>
	<!--将select的值赋给input框-->
		function qlcTrainS(idName) {
			var arrValue = document.getElementById(idName).options[document.getElementById(idName).selectedIndex].value;
			$("#" + idName + "").parent('span').next('span').children('input.ccdd').val(arrValue)
		}
	</script>
	<script src="${webRoot}/js/jquery.imgbox.pack.js"></script>
	<script type="text/javascript">
		$(function() {
			$(".cs-img-link").imgbox({
				'speedIn' : 0,
				'speedOut' : 0,
				'alignment' : 'center',
				'overlayShow' : true,
				'allowMultiple' : false
			});
		});
		
		//保存并新增时情况输入
		function clearInput() {
			$("#id").val("");//清除主键id
			$("#foodName").val("");
			$("#saleCount").val("");
			$("#saleDate").val("");
			$("#customer").val("");
			$("#cusRegName").val("");
			$("#cusPhone").val("");
			$("#memo").val("");
		}
		
		//选择食品
	function getFood (){
			itemNo = $(this).parents("tr").find(".dNo").text();
			$('#myFootTypeModal').modal('toggle');
	    }
	    
	    
	    function selFoot(id,text){
			$("#foodName").val(text);
			$('#myFootTypeModal').modal('toggle');
	    }
	</script>
	<script type="text/javascript">
	function getObj(){
		getObjHistory(1);
		//getObjList();
		$('#select2-ObjList-container').show();
		$('#ModalList').modal('toggle');
		$('#ModalList').on('hide.bs.modal', function () {
			 $('#ObjList').hide()
		});
    }
    //获取档口数据
	function getOpe(){
		getObjHistory(0);
		$('.select2-container').show();
		$('#opeListModal').modal('toggle');
		$('#opeListModal').on('hide.bs.modal', function () {
			 $('#opeList').hide()
		});
    }
    var saveTxt;
	$(document).on('change','.select2-search__field',function(){
		saveTxt = $('.select2-search__field').val();
		
	});
    //市场弹出框确认
    function innerht(){
		if($('.ul-market-list li').hasClass('active')){
			$('#cusRegName').val($('.ul-market-list li.active').html());
			$('#ModalList').modal('hide');
		}else  if(saveTxt !=''){
			$('#cusRegName').val(saveTxt);
			$('#ModalList').modal('hide');
		}
	}
   
    //档口弹出框确认
    function opeSave(){
		if($('#opehistoryList li').hasClass('active')){
			$('#customer').val($('#opehistoryList li.active').html());
			$('#cusPhone').val($('#opehistoryList li.active').attr("p-value"));
			$('#opeListModal').modal('hide');
		}else{
			$('#customer').val($('#opeNameInput').val());
			$('#opeListModal').modal('hide');
		}
	}
	/* function getObjHistory(type) {
		var userId = $("#businessId").val();
		if(userId!=null&&userId!=""){//当获取不到档口时不请求数据
		var regname="";//市场名称
		if(type==0){
			regname=$("#cusRegName").val();
		}
		$.ajax({
			type : "POST",
			url : "${webRoot}/ledger/wx/getObjHistory.do?type="+type+"&regname="+regname,
			dataType : "json",
			data : {
				userId : userId,
				userType : 0,//经营户
				keyType : 1,//进货
			},
			success : function(data) {
				if (data && data.success) {
					if(type==0){//档口
						$("#opehistoryList").empty();
						var opehishtml = "";
						var obj = data.obj;
						$.each(obj, function(index, item) {
							if(obj[index].keyword){
							opehishtml += '<li s-value="' + obj[index].opeUser + '" p-value="' + obj[index].phone + '">' + obj[index].keyword + '</li>';
							}
						});
						$("#opehistoryList").append(opehishtml);
					}else if(type==1)//市场
						$("#historyList").empty();
					var hishtml = "";
					var obj = data.obj;
					$.each(obj, function(index, item) {
						if(obj[index].regname){
						hishtml += '<li>' + obj[index].regname + '</li>';
						}
					});
					$("#historyList").append(hishtml);
				}
			}
		});
		}
	};
	//获取经营户、市场数据
	function getObjList() {
		$.ajax({
					type : "POST",
					url : "${webRoot}/ledger/wx/queryAllObj.do",
					data : "",
					contentType : false, //必须false才会避开jQuery对 formdata 的默认处理 XMLHttpRequest会对 formdata 进行正确的处理 
					processData : false, //必须false才会自动加上正确的Content-Type
					dataType : "json",
					success : function(data) {
						if (data && data.success) {
							$("#objList").empty();
							objhtml = "";
							$("#nodata").hide();
							var obj = data.obj;
							objList = null;
							objList = data.obj;
							var l=objList.length;
							for (var index = 0; index < l; index++) {
								objhtml += ' <option value="'+obj[index].regName+'">'+obj[index].regName+'</option>';
							}
							$("#ObjList").append(objhtml);  
						
						} else {
							$("#nodata").show();
						}
					}
		});
	}; */
	//获取经营户、市场历史数据
	function getObjHistory(searchType) {
		var userId = $("#businessId").val();
		var type=0;
		if(showReg==1){
		 userId = $("#regId").val();
		 type=1;
		}
		if(userId!=null&&userId!=""){//当获取不到档口时不请求数据
		var regname="";//市场名称
		if(searchType==0){
			regname=$("#cusRegName").val();
			if(!regname){
				return;
			} 
		}else if(searchType==1){//市场
			regname=$("#cusRegName").val();
		}
		$.ajax({
			type : "POST",
			url : "${webRoot}/ledger/wx/getObjHistory.do?searchType="+searchType+"&regname="+regname,
			dataType : "json",
			data : {
				userId : userId,
				userType : 1,//经营、市场
				keyType : 1,//销售
				type : type
			},
			success : function(data) {
				if (data && data.success) {
					if(searchType==0){//档口
						$("#OpeList").empty();
						var opehishtml = "";
						var obj = data.obj;
						$.each(obj, function(index, item) {
							if(obj[index].keyword){
							opehishtml += '<li s-value="' + obj[index].opeUser + '" p-value="' + obj[index].phone + '">' + obj[index].keyword + '</li>';
							}
						});
						$("#OpeList").append(opehishtml);
					}else if(searchType==1){//市场
						$("#ObjList").empty();
						objList = data.obj;
					var hishtml = "";
					var obj = data.obj;
					$.each(obj, function(index, item) {
						if(obj[index].regname){
						hishtml += '<li>' + obj[index].regname + '</li>';
						}
					});
					$("#ObjList").append(hishtml);
				}
				}
			}
		});
		}
	}
	//获取经营户、市场数据
	function getObjList() {
		$.ajax({
					type : "POST",
					url : "${webRoot}/ledger/wx/queryAllObj.do",
					data : "",
					contentType : false, //必须false才会避开jQuery对 formdata 的默认处理 XMLHttpRequest会对 formdata 进行正确的处理 
					processData : false, //必须false才会自动加上正确的Content-Type
					dataType : "json",
					success : function(data) {
						if (data && data.success) {
							var obj = data.obj;
							objList = null;
							objList = data.obj;
						}
					}
		});
	}
	//档口检索结果
	$(document).on("change","#opeList",function(){
		var options=$('#opeList option:selected'); //获取选中的项
		if(options.val() && options.text()){	//确认
		$('#customer').val(options.text());
		$('#opeListModal').modal('hide');
		}else{
			alert("获取失败");
		}
	});
	//确认市场检索结果
	$(document).on("change","#ObjList",function(){
		var options=$('#ObjList option:selected'); //获取选中的项
		if(options.val() && options.text()){	//确认
		$('#cusRegName').val(options.text());
		$('#ModalList').modal('hide');
		}else{
			alert("获取失败");
		}
	});
	
	$('#sizeList li').on('click',function(){
		$(this).addClass('active').siblings().removeClass('active');
		$('#size').val($('#sizeList li.active').html());
		$('.cs-check-down').hide();
			});
	//获取全部样品
	function getFood() {
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
						}
					}
		});
	}
		//获取食品输入历史
		function getFoodHistory(){
				var userId = $("#businessId").val();
				if(showReg==1){
					 userId = $("#regId").val();
					}
				var  foodName=$("#foodName").val();
				if(foodName!=""&&foodName!=null){
					return;
				}
			if(userId!=null&&userId!=""){//当获取不到档口时不请求数据
				$.ajax({
					type : "POST",
					url : "${webRoot}/ledger/wx/getHistory.do",
					dataType : "json",
					data : {
						userId : userId,
						userType : 2,//进货台账
						keyType : 2,//食品
					},
					success : function(data) {
						if (data && data.success) {
								$("#foodList").empty();
								var foodHishtml = "";
								obj = data.obj;
								$.each(obj, function(index, item) {
										if(obj[index].keyword){
											foodHishtml+='<li>'+obj[index].keyword+'</li>';
										}
								});
								$("#foodList").append(foodHishtml);
						}
					}
				});
			}
		}
		//校验样品是否存在
		function checkFood(key) {
			var ischeck=false;
			if(!foodList){
				getFood();
			}
			if(foodList){
					for (var i = 0; i < foodList.length; i++) {
						var foodName = foodList[i].foodName;
						if(foodName.indexOf("(")>0){//判断是否有别名
							foodName=foodName.substring(0,foodName.indexOf("("));
						}
						if (key==foodName) {
							ischeck=true;
							return ischeck;
						}
					}
					if(ischeck==false){
						$("#foodName").val("");
						$("#confirm-warnning .tips").text("您输入的食品不存在，请重新选择!");
						$("#confirm-warnning").modal('toggle');
					}
			}
		}
		 $('.js-select2-tags').select2();
		//防止多次点击事件
		 function fangdianji() {
		 	$("#saleBtnSave").hide();
		 	$("#saleBtnSaveself").hide();
		 	 setTimeout(function(){
		 			$("#saleBtnSave").show();
		 			$("#saleBtnSaveself").show();
		 	 },1000);
		 }
	</script>
</body>
</html>
