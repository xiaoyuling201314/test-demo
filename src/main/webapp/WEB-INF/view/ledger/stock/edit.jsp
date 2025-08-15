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
	background-size:40px 40px;
	background-position:center center;
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
	/* height:200px; */
    overflow: hidden;
    border: 1px solid #ddd;
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
.combobox-item{
	padding:0 0 0 10px;
	line-height:28px;
	font-size:14px;
}
.textbox .textbox-text{
	font-size:14px;
	color:#333;
}
div.combo-panel{
	background:#f1f1f1;
}
.textbox-addon{
	display:block;
}
a.text-danger{
	color: #de2525;
}
.btn-danger{
	padding:0 10px;
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
.food-num input[type=text]{
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
.cs-obtain .icon{
	 position: absolute;
    right: 0px;
    top: -6px;
    height: 22px;
    border-radius: 0 0 0 1px;
    font-size:14px;
}
.uploader-box{
				display:inline-block;
				float:left;
			}
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
			<li class="cs-b-active cs-fl">进货台账</li>
		</ol>

		<!-- 面包屑导航栏  结束-->
		<div class="cs-search-box cs-fr">
			<a class="cs-menu-btn"  onclick="parent.closeMbIframe()"><i class="icon iconfont icon-fanhui"></i>返回</a>
		</div>
		
	</div>
	<div class="cs-tb-box">
		<div class="cs-base-detail">
			<div class="cs-content2 clearfix">
				<form id="stockForm" action="${webRoot}/ledger/stock/save1.do" method="post" enctype="multipart/form-data">
					<input type="hidden" name="details" id="details"> <input type="hidden" name="id" value="${bean.id }"> <input type="hidden" name="regName" /> <input type="hidden" id="businessId" name="businessId" value="${bean.businessId }" />
					<div class="cs-add-new cs-add-pad">
						<ul class="cs-ul-style clearfix">
							<li class="cs-name cs-sm-w"><i class="cs-mred">*</i>所在市场：</li>
							<li class="cs-in-style cs-md-w">
								<select class="js-select2-tags" name="regId" id="regId" onchange="changeReg()" datatype="*" nullmsg="请选择被检单位">
										<option value="">--请选择--</option>
										<c:forEach items="${regObj}" var="reg">
											<option value="${reg.id}" data-name="${reg.regName}" data-user="${reg.linkUser}" <c:if test="${reg.id==bean.regId }">selected</c:if> <c:if test="${reg.id==regId}">selected</c:if> data-phone="${reg.linkPhone }">${reg.regName}</option>
										</c:forEach>
								</select>
							</li>
							<c:if test="${showReg!=1}">
							<li class="cs-name cs-sm-w"><i class="cs-mred">*</i>档口编号：</li>
							<li class="cs-in-style cs-md-w"><select class="js-select2-tags" name="opeId" id="opeId" onchange="changeOpe1()" datatype="*" nullmsg="请选择档口编号"></select>
							<li class="cs-name cs-sm-w">经营户：</li>
							<li class="cs-in-style cs-md-w"><input type="text" style="padding-right: 0;" id="opeShopName" value="" datatype="*" nullmsg="" readonly="readonly"></li>
							</c:if>	</ul>


						
						<ul class=" cs-gh clearfix">
						<li class="cs-name cs-sm-w"><i class="cs-mred">*</i>食品名称：</li>
							<li class="cs-in-style cs-md-w cs-select-search"><%-- <input type="text"  id="foodName"  name="foodName"  value="${bean.foodName }" onclick="getFood();"datatype="*" nullmsg=""   readonly="readonly"/> --%>
								<input type="text" id="foodName"  name="foodName" onclick="getFoodHistory();" autocomplete="off" class="cs-select-down" value="${bean.foodName }" datatype="*" nullmsg=""   >
								<div class="cs-down-box cs-hide" id="foodBox">
								<input type="hidden" value="${bean.foodName }" id="food">
										<ul  id="foodList">
										</ul>
								</div>
							</li>
							<li class="cs-name cs-sm-w"><i class="cs-mred">*</i>进货数量：</li>
							<li class="cs-in-style cs-md-w"><input type="text" value="${bean.stockCount }" onkeyup="value=value.replace(/[^\d{1,}\.\d{1,}|\d{1,}]/g,'')"  autocomplete="off" name="stockCount" id="stockCount"  datatype="*" nullmsg=""  /></li>

						<li class="cs-name cs-sm-w"><i class="cs-mred">*</i>规格单位：</li>
							<li class="cs-in-style cs-md-w  cs-select-search">
							<input  class="cs-select-down"type="text"name="size" id="size" autocomplete="off"  <c:if test="${!empty bean.size }"> value="${bean.size }"</c:if>  <c:if test="${empty bean.size }"> value="KG"</c:if> datatype="*" />
							<div class="cs-down-box cs-hide">
										<ul  id="sizeList">
										<li>KG</li>
										<li>件</li>
										<li>箱</li>
										<li>只</li>
										<li>个</li>
										<li>头</li>
										</ul>
								</div>
							</li>
							<li class="cs-name cs-sm-w">进货日期：</li>
							<li class="cs-in-style cs-md-w"><input class="cs-time" type="text" name="stockDate" class="inputxt" onClick="WdatePicker({maxDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true})" 
							<c:if test="${empty bean.stockDate }">value="<fmt:formatDate value='<%=new Date()%>' pattern='yyyy-MM-dd'/>"</c:if>
							 	<c:if test="${!empty bean.stockDate }">value="<fmt:formatDate  value='${bean.stockDate }' pattern='yyyy-MM-dd'/>" </c:if>/>
							</li>
							<li class="cs-name cs-sm-w"><i class="cs-mred">*</i>来源市场：</li>
							<li class="cs-in-style cs-md-w cs-select-search">
								<%-- <input type="text" class="cs-select-down" autocomplete="off" onclick="getObjHistory(1);"  value="${bean.param1 }" name="param1" id="param1" datatype="*" nullmsg="来源市场不能为空">
								<div class="cs-down-box cs-hide" id="test">
										<ul  id="ObjList">
										</ul>
								</div> --%>
								<select class="easyui-combobox ObjList" name="param1" panelHeight="auto" panelMaxHeight="260px" style="height:29px; width:200px;">
								</select>
							</li>
							<li class="cs-name cs-sm-w">供应商：</li>
							<li class="cs-in-style cs-md-w cs-select-search">
							<%-- <input type="text" value="${bean.supplier }" readonly="readonly" onclick="getOpe();"  name="supplier" id="supplier"  autocomplete="off"/> --%>
							<%-- <input type="text" class="cs-select-down" autocomplete="off"  name="supplier" onclick="getObjHistory(0);" id="supplier" value="${bean.supplier }"> --%>
							<select class="easyui-combobox OpeList" name="supplier" panelHeight="auto" panelMaxHeight="260px"  style="height:29px; width:200px;">
								</select>
							</li>

							<li class="cs-name cs-sm-w">供货者名称：</li>
							<li class="cs-in-style cs-md-w"><input type="text" value="${bean.supplierUser }"id="supplierUser" name="supplierUser"   /></li>
							<li class="cs-name cs-sm-w">联系方式：</li>
							<li class="cs-in-style cs-md-w"><input type="text" value="${bean.supplierTel }" id="supplierTel" name="supplierTel"   /></li>
							<li class="cs-name cs-sm-w">产地：</li>
							<li class="cs-in-style cs-md-w"><input type="text" value="${bean.productionPlace }"  id="productionPlace"  name="productionPlace"  /></li>
							
							<li class="cs-name cs-sm-w">批号：</li>
							<li class="cs-in-style cs-md-w"><input type="text" value="${bean.batchNumber }" name="batchNumber" id="batchNumber"   /></li>
							
							<li class="cs-name cs-sm-w">保质期：</li>
							<li class="cs-in-style cs-md-w"><input type="text" value="${bean.expirationDate }" name="expirationDate"  id="expirationDate"      /></li>
							<li class="cs-name cs-sm-w">生产日期：</li>
							<li class="cs-in-style cs-md-w"><input class="cs-time" type="text"  name="productionDate"  id="productionDate"class="inputxt" onClick="WdatePicker({maxDate:'%y-%M-%d %H:%m:%s',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true})" 
								<c:if test="${empty bean.productionDate }">value="<fmt:formatDate value='<%=new Date()%>' pattern='yyyy-MM-dd'/>"</c:if>
							 	<c:if test="${!empty bean.productionDate }">value="<fmt:formatDate  value='${bean.productionDate }' pattern='yyyy-MM-dd'/>" </c:if>/></li>
						</ul>
						<ul class=" cs-gh clearfix">

							<li class="cs-name cs-sm-w"><label for="exampleInputFile">检验编号</label>：</li>
							<li class="cs-in-style cs-fl  cs-md-w">
								<div class="clearfix">
									<div class="clearfix">
										<span class="cs-inline-blcok clearfix"> <input class="cs-fl" type="text" value="${bean.checkProof }" name="checkProof"  id="checkProof"placeholder="请输入检疫证明" />
										</span>
									</div>
								</div>
							</li>
							<li class="cs-name cs-sm-w"><label for="exampleInputFile">检疫编号</label>：</li>
							<li class="cs-in-style cs-fl  cs-md-w">
								<div class=" clearfix">
									<div class="clearfix">
										<span class="cs-inline-blcok clearfix"> <input class="cs-fl" type="text" value="${bean.quarantineProof }" name="quarantineProof" id="quarantineProof" placeholder="请输入检疫证明" />
										</span>
									</div>
								</div>
							</li>

						</ul>
						<ul class=" cs-gh tz-gallery clearfix">
							<li class="cs-name cs-sm-w">检验证明：</li>
							<li class="cs-upload-index cs-in-style cs-md-w">
							<span class="cs-inline-blcok clearfix"> 
								<div class="uploader-box"   id="img2">
								<c:forEach items="${CImgList}" var="reg">
											<div class="cs-obtain cs-fl img2"  >
											<span class="del-img2 icon iconfont icon-close text-danger"></span>
												<img src="${webRoot}/resources/stock/${reg }" class="img1-img2" style="height: 100%;">
												<input style="display: none" name="checkProof_Img" value="${reg }">
											</div>
										</c:forEach>
								</div>
									
										
							<label   for="browerfile2" class="file cs-fl" id="Img2-add"  <c:if test="${fn:length(CImgList) >= 5}">style="display:none "</c:if>> <input type="file" id="browerfile2" name="Img2" accept="image/*" multiple></label>
							</span>
							</li>
							<li class="cs-name cs-sm-w">检疫证明：</li>
							<li class="cs-in-style cs-md-w">
							<span class="cs-inline-blcok clearfix" > 
							<div class="uploader-box"   id="img3">
									<c:forEach items="${QImgList}" var="reg">
										<div class="cs-obtain cs-fl img3"  >
										<span class="del-img3 icon iconfont icon-close text-danger"></span>
											<img src="${webRoot}/resources/stock/${reg }" class="img1-img3" style="height: 100%;">
											<input style="display: none" name="quarantineProof_Img" value="${reg }">
										</div>
									</c:forEach>
							</div>
										
								<label  for="browerfile3" class="file cs-fl" id="Img3-add" <c:if test="${fn:length(QImgList) >= 5}">style="display:none "</c:if>> <input type="file" id="browerfile3" name="Img3" accept="image/*"  multiple></label>	 
							</span>
							</li>
							<li class="cs-name cs-sm-w">进货凭证：</li>
							<li class="cs-in-style cs-md-w">
							<span class="cs-inline-blcok clearfix"> 
								<div class="uploader-box"   id="img1">
									<c:forEach items="${SImgList}" var="reg">
											<div class="cs-obtain cs-fl img3"  >
											<span class="del-img1 icon iconfont icon-close text-danger"></span>
												<img src="${webRoot}/resources/stock/${reg }" class="img1-img1" style="height: 100%;">
												<input style="display: none" name="stockProof_Img" value="${reg }">
											</div>
										</c:forEach>
								</div>
										
								<label  for="browerfile1" class="file cs-fl" id="Img1-add" <c:if test="${fn:length(SImgList) >= 5}">style="display:none "</c:if>> <input type="file" id="browerfile1" name="Img1" accept="image/*"  multiple></label>	 
							</span>
							</li>
							
						<%-- 	<li class="cs-name cs-sm-w"><label for="exampleInputFile">进货凭证</label>：</li>
							<li class="cs-in-style cs-fl  cs-md-w">
									<div class="clearfix">
										<span class="cs-fl" id="img1">
										<c:set value="${ fn:split(bean.stockProof_Img, ',') }" var="Slist" />
										<c:forEach items="${Slist}" var="reg">
											<div class="cs-obtain cs-fl img1"  >
											<span class="del-img1 icon iconfont icon-close text-danger"></span>
												<img src="${webRoot}/resources/stock/${reg }" class="img1-img2" style="height: 100%;">
												<input style="display: none" name="stockProof_Img" value="${reg }">
											</div>
										</c:forEach>
										<label  for="browerfile1" class="file cs-fl" id="Img1-add"<c:if test="${fn:length(SImgList) == 5}">style="display:none "</c:if>> <input type="file" id="browerfile1" name="Img1" accept="image/*" multiple></label>
										</span>
									</div>
							</li> --%>
						 
					</div>
				</form>
			</div>
		</div>
	</div>
	
							<div class="showDiv" id="showDiv" style="padding:20px; text-align:center; position:absolute; left:0; top:0; right:0; bottom:0; z-index:1000; background:rgba(0,0,0,0.5); width:100%;height:100%; display:none;">
    									<div style="width:100%;height:100%; overflow:auto;">
								    	<img src="" alt="" class="imgShow">
								    	</div>
								    </div>
	<!-- 底部导航 结束 -->
	<div class="cs-alert-form-btn clearfix">
	<c:if test="${showType!=1}">	<a href="javascript:" class="cs-menu-btn" id="stockBtnSave"><i class="icon iconfont icon-save"></i>保存</a> </c:if>
	<c:if test="${empty bean.id}">	<a href="javascript:" class="cs-menu-btn" id="stockBtnSaveself"><i class="icon iconfont icon-save"></i>保存并新增</a> </c:if>
		<a onclick="parent.closeMbIframe()" class="cs-menu-btn"><i class="icon iconfont icon-fanhui"></i>返回</a>
	</div>
	<%@include file="/WEB-INF/view/common/confirm.jsp"%>
	    <%-- <%@include file="/WEB-INF/view/common/modalBox.jsp"%> --%>
	<script type="text/javascript" src="${webRoot}/js/jquery.form.js"></script>
	<script type="text/javascript">
	var htmlType='${htmlType}';
	var listI = -1;
	var downList=-28;
	var showReg='${showReg}';//1是市场录入台账 0 经营户
	
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
					 $("#foodBox").hide();
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
		$(".cs-select-down").click(function(e){
			$(this).siblings('.cs-down-box').toggle();
		        e.stopPropagation();
		    });
		$(".cs-select-down").on('change',function(){
			$(this).siblings('.cs-down-box').show();
		});
		   $(window).click(function(){
		     $(".cs-down-box").hide();
		   });
		   var timer=null;
		   $(".cs-select-down").on('blur',function(){
			   timer=setTimeout(function(){
				   $(".cs-down-box").hide();
				   var foodName=$('#foodName').val();
					if(foodName){
				   checkFood(foodName);
					}
               },1000);
			});
           $(".cs-down-box ul li").mouseover(function(){
        	   clearTimeout(timer);
        	   $(".cs-down-box").show();
           });
			//单位列表点击
			$(document).on('click','#sizeList li',function(){
				 $(this).addClass('active').siblings().removeClass('active'); 
				 var size=$('#sizeList li.active').html();
				 $('#size').val(size);
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
	/* 		//市场列表点击
		$(document).on('click','#ObjList li',function(){
			 $(this).addClass('active').siblings().removeClass('active'); 
			 var param1=$('#ObjList li.active').html();
			 $('#param1').val(param1);
			$('.cs-select-down').siblings('.cs-down-box').hide();
		});
			//档口列表点击
		$(document).on('click','#OpeList li',function(){
			 $(this).addClass('active').siblings().removeClass('active'); 
			 var supplier=$('#OpeList li.active').html();
			 if(supplier){
				if(supplier.indexOf("(")!=-1){//判断是否有类别 没有类别则为历史
					supplier=supplier.substring(0,supplier.indexOf("("));
				}
			 }
			 $('#supplier').val(supplier);
			$('.cs-select-down').siblings('.cs-down-box').hide();
		});
			//单位列表点击
		$(document).on('click','#sizeList li',function(){
			 $(this).addClass('active').siblings().removeClass('active'); 
			 var size=$('#sizeList li.active').html();
			 $('#size').val(size);
			$('.cs-select-down').siblings('.cs-down-box').hide();
		}); */
					
		$(function() {//加载启动
				changeReg();
				getObjList();
					var  param1='${bean.param1}';
					if(param1){
					$('.ObjList').combobox('setValue',param1);
					}
					var supplier='${bean.supplier}';
					if(supplier){
							$('.OpeList').combobox('setValue',supplier);
							//$('.OpeList').combobox('setRawValue',supplier);
						}
				$("#foodName").bind('input porpertychange',function(){
					downList=-28;
					listI=-1;
					down=0;
					$(this).siblings('.cs-down-box').show();
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
				
			/* 	//市场输入框输入
				$("#param1").bind('input porpertychange',function(){
					var  key=$("#param1").val();
					if(key == null | key == ""){
						getObjHistory(1);
						return;
					}
					if(objList){
						objSearch(key);
					}else{
						getObjList();
						if(objList){
							objSearch(objList);
						}else{
							
						}
					}
					
				});
				 */
			/* 	 $(".ObjList").click(function(){
					 alert("2");
					 $(this).prev().combobox("showPanel");
					 }) */
				 //市场点击
			var 	 objall=0;
				   $('.ObjList').combobox('textbox').bind('click',function(){ 
					    $('.ObjList').combobox({    
			                onChange : function(n,o){
			                	if(objall==false){
			                		getObjHistory(1);
			                		objall=1;
			                	} /*else if(!obj){
			                		objSearch();
			                		 obj=true;
			                	}  */
			                } 
			            });  
		                getObjHistory(1);
		                objall=false;
		                $('.ObjList').combobox('showPanel');
		        });  
				 //市场输入
				   $('.OpeList').combobox('textbox').bind('click',function(){ 
		                $('.OpeList').combobox('showPanel');
		                getObjHistory(0);
		              //  $('.ObjList').combobox('textbox').focus();
		        }); 
				
			});
		//食品搜索
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
		/* function objSearch() {
			if(!objList){
				getObjList();
			}
			var dataList,json,value,text;
			 dataList = [];
			 if(objList){
			for (var i = 0; i < objList.length; i++) {
				var regName = objList[i].regName;
				if (regName) {
				value=regName;
				text=regName;
				  dataList.push({"text":text,"value": value});
				}
			}
			 $('.ObjList').combobox({    
	              	panelHeight:300,
	              		valueField: 'value',
	                      textField: 'text',
	                      data: dataList,
	                      editable:true  
	           }); 
				  $('.ObjList').combobox('showPanel');
				  $('.ObjList').combobox('textbox').focus();
				  obj=true;
			 }
		}; */
		
	</script>
	<script type="text/javascript">
		var saveOrUpdate = false;//保存或者保存并新增
		var demo;
		var details = [];
		var row = 0;
		var editRow;//编辑或删除的数据行号
		var detectItemCount = 0;//检测项目数量
		var rootPath = "${webRoot}/ledger/stock/";
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
			//提交前
			$("#stockForm").Validform(
					{
						tiptype : 2,
						beforeSubmit : function() {
							try {
										 var formData = new FormData($('#stockForm')[0]);
										   formData.delete("Img1");
										  formData.delete("Img2");
										  formData.delete("Img3");
										 for (var i = 0; i < img1fileArr.length; i++) {
										 
										   formData.set("Img1-"+i,img1fileArr[i]); 
										}
										 for (var i = 0; i < img2fileArr.length; i++) {
									 
												 formData.set("Img2-"+i,img2fileArr[i]); 
										}
										 for (var i = 0; i < img3fileArr.length; i++) {
										 
												 formData.set("Img3-"+i,img3fileArr[i]); 
										}
										 
							} catch (e) {
								//alert(e);
								console.log(e);
								$("#confirm-warnning .tips").text("该浏览器不支持图片压缩，建议您使用360、谷歌等浏览器!");
								$("#confirm-warnning").modal('toggle');
							}
							                	saveStock(formData);
										 return false;
						
							},callback:function(data){
							}
					
					});
			
			
			
	//保存数据		saveStock(formData);
		function saveStock(formData) {
			var regId = $("#regId").val();
			var businessId = $("#businessId").val();
			var regTypeId='${regTypeId}';
			$.ajax({
				type : "POST",
				url : rootPath + "save1.do",
				data : formData,
				contentType : false, //必须false才会避开jQuery对 formdata 的默认处理 XMLHttpRequest会对 formdata 进行正确的处理 
				processData : false, //必须false才会自动加上正确的Content-Type
				dataType : "json",
				success : function(data) {
					if (data && data.success) {
						if (saveOrUpdate) {//保存并且新增
							$("#confirm-warnning .tips").text(data.msg);
							$("#confirm-warnning").modal('toggle');
							clearInput();
						} else {
							if(htmlType==1){
							self.location = "${webRoot}/ledger/stock/list.do?regTypeId="+regTypeId+"&htmlType="+htmlType+"&regId="+ regId ;
							}else if(htmlType==3){
								self.location = "${webRoot}/ledger/stock/ledgerList.do?regTypeId="+regTypeId+"&htmlType="+htmlType+"&regId="+regId ;
							} else{
								self.location = "${webRoot}/ledger/stock/list.do?regTypeId="+regTypeId+"&regId=" + regId + "&businessId=" + businessId;
							}
						}
					} else {
						$("#waringMsg>span").html(data.msg);
						$("#confirm-warnning").modal('toggle');
					}
				}
			});
		}
			

			// 新增或修改
			$("#btnSave").on("click", function() {
				$(".textbox-prompt").attr({
					"datatype" : "*",
					"nullmsg" : "请选择检测项目"
				});
				demo.submitForm(false);
				return false;
			});
			// 新增或修改
			$("#stockBtnSave").on("click", function() {
				fangdianji();
				saveOrUpdate = false;
			var foodName=$('#foodName').val();
			if(!foodName){
				$("#confirm-warnning .tips").text("请选择食品名称!");
				$("#confirm-warnning").modal('toggle');
				return;
			}
				$("#stockForm").submit();
				return false;
			});
			$("#stockBtnSaveself").on("click", function() {
				fangdianji();
				saveOrUpdate = true;
				var foodName=$('#foodName').val();
				if(!foodName){
					$("#confirm-warnning .tips").text("请选择食品名称!");
					$("#confirm-warnning").modal('toggle');
					return;
				}
				$("#stockForm").submit();
				return false;
			});
			// 关闭编辑模态框前重置表单，清空隐藏域

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
			});
		}
		//选择市场，加载经营户名称
		function changeReg(){
			var opt = $("#regId").find("option:selected");
			$("input[name=regName]").val($(opt).text());
			$("input[name=regLinkPerson]").val(opt.attr('data-user'));
			$("input[name=regLinkPhone]").val(opt.attr('data-phone'));
			$("input[name=opeShopCode]").val("");
			$("input[name=opeName]").val("");
			$("input[name=opePhone]").val("");
			var regId = $("#regId").val();
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
					//$("#supplier").append(html);
					/* else{
						$("#waringMsg>span").html(data.msg);
						$("#confirm-warnning").modal('toggle');
					} */
				}
			});
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
		/* document.getElementById("supplier").onclick=function(){
			alert("2");
			}; */
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
					var num = '${bean.businessId}'; //获取input中输入的数字
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
			var stockCount = $("[name=stockCount]").val();
			var stockDate = $("[name=stockDate]").val();//进货日期
			var batchNumber = $("[name=batchNumber]").val();
			var expirationDate = $("[name=expirationDate]").val();//保质期
			var productionDate = $("[name=productionDate]").val();
			var productionPlace = $("[name=productionPlace]").val();
			var size = $("[name=size]").val();
			var detail = {
				foodName : foodName,
				stockCount : stockCount,
				stockDate : stockDate,
				size : size,
				batchNumber : batchNumber,
				expirationDate : expirationDate,
				productionDate : productionDate,
				productionPlace : productionPlace
			};
			details.push(detail);
			var html = "<tr data-row="+row+">";
			html += "<td>" + row + "</td><td>" + foodName + "</td>";
			html += "<td>" + stockCount + "</td><td></td>";
			html += "<td>" + productionDate + "</td><td>" + expirationDate + "</td><td>" + productionPlace + "</td><td>"
					+ batchNumber + "</td><td>" + stockDate + "</td>";
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
		$('#ModalList').on('hide.bs.modal', function () {
			$('.js-example-basic-single').select2({
				closeOnSelect: true
				});
		});
		$('#opeListModal').on('hide.bs.modal', function () {
			$('.js-example-basic-single').select2({
				closeOnSelect: true
				});
		});
	</script>
	<script>
	<!--将select的值赋给input框-->
		function qlcTrainS(idName) {
			var arrValue = document.getElementById(idName).options[document.getElementById(idName).selectedIndex].value;
			$("#" + idName + "").parent('span').next('span').children('input.ccdd').val(arrValue)
		}
	</script>
	<script type="text/javascript">
		function getObjectURL(file) {
			var url = null;
			if (window.createObjectURL != undefined) {
				url = window.createObjectURL(file);//basic
			} else if (window.URL != undefined) {
				url = window.URL.createObjectURL(file);
			} else if (window.webkitURL != undefined) {
				url = window.webkitURL.createObjectURL(file);
			}

			return url;
		}
		//实现功能代码 定义三个图片数组
		 var img1fileArr = [];
		 var img2fileArr = [];
		 var img3fileArr = [];
		 var formDataBox = new FormData($('#stockForm')[0]);
		 
		 window.onload=function(){//加载完把已上传的图片补进位置
			 var list1=$("#img1").children('.cs-obtain').length;
			 for (var i = 0; i < list1; i++) {
					img1fileArr.push("1111");
			}
			 var list2=$("#img2").children('.cs-obtain').length;
			 for (var i = 0; i < list2; i++) {
					img2fileArr.push("2222");
			}
			 var list3=$("#img3").children('.cs-obtain').length;
			 for (var i = 0; i < list3; i++) {
					img3fileArr.push("3333");
			}
	 }
		 
		$(function() {
	
			$("#browerfile1").change(function() {
				if($("#img1").children('.cs-obtain').length>=5){
					$("#waringMsg>span").html("每种证明最多上传5张图片!");
					$("#confirm-warnning").modal('toggle');
					return;
				}
				 for (var i = 0; i < this.files.length; i++) {//遍历多选文件
				var objUrl = getObjectURL(this.files[i]);
							if (objUrl) {
								var fileObj=this.files[i];
								if($("#img1").children('.cs-obtain').length==5){
									$("#Img1-add").hide();
									break;
								}
					//拼接预览图
					var html=' <div class="cs-obtain cs-fl img1" ><span class="del-img1 icon iconfont icon-close text-danger"></span>';
						 html+='<img src="'+objUrl+'" href="'+objUrl+'" class="img1-img2" style="height: 100%;"></div> ';
						 $("#img1").append(html);
						 if($("#img1").children('.cs-obtain').length>=5){
							 $("#Img1-add").hide();
							}
						 //图片存入文件
					      if(fileObj&&(((fileObj.size)/1024) > 1025)) {//img1图片大于1M
										 photoCompress(fileObj, { quality: 0.2  }, function(base64Codes){
								                //console.log("压缩后：" + base.length / 1024 + " " + base);
								                var bl = convertBase64UrlToBlob(base64Codes);
								                formDataBox.set("Img11", bl, "file_"+Date.parse(new Date())+".jpg"); // 文件对象
								                fileObj = formDataBox.get("Img11");//压缩存储
												img1fileArr.push(fileObj);
												if($("#img1").children('.cs-obtain').length==5){
													$("#Img1-add").hide();
													}
								            });
							 }else{
											 img1fileArr.push(fileObj);
							 }
				     		 //超过5个隐藏
							if($("#img1").children('.cs-obtain').length>=5){
							$("#Img1-add").hide();
							}
					}
				 }
				
			});
			$("#browerfile2").change(function() {
				
				if(img2fileArr.length>=5){
					$("#waringMsg>span").html("每种证明最多上传5张图片!");
					$("#confirm-warnning").modal('toggle');
					return;
				} 
				 for (var i = 0; i < this.files.length; i++) {//遍历多选文件
				var objUrl = getObjectURL(this.files[i]);
							if (objUrl) {
								var fileObj=this.files[i];
								if($("#img2").children('.cs-obtain').length>=5){
									$("#Img2-add").hide();
									break;
								}
							var html=' <div class="cs-obtain cs-fl img2" ><span class="del-img2 icon iconfont icon-close text-danger"></span>';
								 html+='<img src="'+objUrl+'" href="'+objUrl+'" class="img1-img2" style="height: 100%;"></div> ';
								 $("#img2").append(html);
								 if($("#img2").children('.cs-obtain').length>=5){
									 $("#Img2-add").hide();
									}
							//图片存入文件
						   		if(fileObj&&(((fileObj.size)/1024) > 1025)) {//img1图片大于1M
											 photoCompress(fileObj, {
									                quality: 0.2
									            }, function(base64Codes){
									                //console.log("压缩后：" + base.length / 1024 + " " + base);
									                var bl = convertBase64UrlToBlob(base64Codes);
									                formDataBox.set("Img21", bl, "file_"+Date.parse(new Date())+".jpg"); // 文件对象
									                fileObj = formDataBox.get("Img21");
													img2fileArr.push(fileObj);
													if($("#img2").children('.cs-obtain').length>=5){
														$("#Img2-add").hide();
														}
									            });
									 }else{
										 img2fileArr.push(fileObj);
									 }
							}
						 //超过5个隐藏
						if($("#img2").children('.cs-obtain').length>=5){
						$("#Img2-add").hide();
						}
				 }
			});
			$("#browerfile3").change(function() {
				if($("#img3").children('.cs-obtain').length>=5){
					$("#waringMsg>span").html("每种证明最多上传5张图片!");
					$("#confirm-warnning").modal('toggle');
					return;
				}
				var path = browerfile3.value;
				 for (var i = 0; i < this.files.length; i++) {//遍历多选文件
				var objUrl = getObjectURL(this.files[i]);
							if (objUrl) {
								var fileObj=this.files[i];
								if($("#img3").children('.cs-obtain').length>=5){
									$("#Img3-add").hide();
									break;
								}
							var html=' <div class="cs-obtain cs-fl img3" ><span class="del-img3 icon iconfont icon-close text-danger"></span>';
								 html+='<img src="'+objUrl+'" href="'+objUrl+'" class="img1-img2" style="height: 100%;"></div> ';
								 $("#img3").append(html);
								 if($("#img3").children('.cs-obtain').length==5){
									 $("#Img3-add").hide();
									}

							//图片存入文件
								  if(fileObj&&(((fileObj.size)/1024) > 1025)) {//img1图片大于1M
														 photoCompress(fileObj, {
												                quality: 0.2
												            }, function(base64Codes){
												                //console.log("压缩后：" + base.length / 1024 + " " + base);
												                var bl = convertBase64UrlToBlob(base64Codes);
												                formDataBox.set("Img31", bl, "file_"+Date.parse(new Date())+".jpg"); // 文件对象
												                fileObj = formDataBox.get("Img31");
																img3fileArr.push(fileObj);
																if($("#img3").children('.cs-obtain').length>=5){
																	$("#Img3-add").hide();
																	}
												            });
									  }else{
										  img3fileArr.push(fileObj);
									  }
								  //超过5个隐藏
								  if($("#img3").children('.cs-obtain').length>=5){
										$("#Img3-add").hide();
									}
							}
				 }
			});
		});
		//预览图片
		$(document).on('click','.img1-img1,.img1-img2,.img1-img3',function(){
			var objUrl=$(this).attr('src');
			if(objUrl!=null){
			$('.imgShow').attr("src", objUrl);
			$("#showDiv").show();
			}
		});
		//删除上传图片Img1
		$(document).on('click','.del-img1',function(e){
			//alert($(this).parent('.cs-obtain').index());
			var a=$(this).parent('.cs-obtain').index();
			img1fileArr.splice(a,1);//数据删除
			$(this).parent('.cs-obtain').remove();
			 var list1=$("#img1").children('.cs-obtain').length;
			if(list1<5){
			$("#Img1-add").show();
			}else{
				$("#Img1-add").hide();
			}
			e.preventDefault();
			})
			//删除上传图片Img2
		$(document).on('click','.del-img2',function(e){
			//alert($(this).parent('.cs-obtain').index());
			var a=$(this).parent('.cs-obtain').index();
			img2fileArr.splice(a,1);//数据删除
			$(this).parent('.cs-obtain').remove();
			 var list1=$("#img2").children('.cs-obtain').length;
				if(list1<5){
					$("#Img2-add").show();
				}else{
					$("#Img2-add").hide();
				}
			e.preventDefault();
			})
			//删除上传图片Img3
		$(document).on('click','.del-img3',function(e){
			//alert($(this).parent('.cs-obtain').index());
			var a=$(this).parent('.cs-obtain').index();
			img3fileArr.splice(a,1);//数据删除
			$(this).parent('.cs-obtain').remove();
			 var list1=$("#img3").children('.cs-obtain').length;
				if(list1<5){
					$("#Img3-add").show();
				}else{
					$("#Img3-add").hide();
				}
			e.preventDefault();
			})
			//关闭预览效果
		$(document).on('click','.showDiv',function(){
			$(this).hide();
		});
		
		/* $(function() {
			var stockProof_Img = "${!empty   bean.stockProof_Img}";//进货凭证图片
			var checkProof_Img = "${!empty   bean.checkProof_Img}";//检验证明图片
			var quarantineProof_Img = "${!empty   bean.quarantineProof_Img}";//检疫证明图片
			if (stockProof_Img == "true") {
				$(".img1").show();
			}
			if (checkProof_Img == "true") {
				$(".img2").show();
			}
			if (quarantineProof_Img == "true") {
				$(".img3").show();
			}
		}); */
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
			//$("#param1").val("");//来源
			//$("#productionPlace").val("");
			$("#expirationDate").val("");
			$("#size").val("");
			$("#stockCount").val("");
			//$("#productionDate").val("");
			$("#checkProof").val("");//检验证明
			$("#quarantineProof").val("");//检疫证明
			$("#batchNumber").val("");//批次
		}
		

	</script>
	<script type="text/javascript">
	   //选择市场


	//获取经营户、市场历史数据
	function getObjHistory(type) {
		var userId = $("#businessId").val();
		if(showReg==1){
			 userId = $("#regId").val();
			}
		if(userId!=null&&userId!=""){//当获取不到档口时不请求数据
		var regname="";//市场名称
		if(type==0){
			regname=$("input[name='param1']").val();
			if(!regname){
				return;
			}
		}else if(type==1){//市场
			regname=$("input[name='param1']").val();
			if(regname){
				return;
			}
		}
		$.ajax({
			type : "POST",
			url : "${webRoot}/ledger/wx/getObjHistory.do?type="+type+"&regname="+regname,
			dataType : "json",
			data : {
				userId : userId,
				userType : 0,//经营户
				keyType : 0,//进货
			},
			success : function(data) {
				if (data && data.success) {
					if(type==0){//档口
						$("#OpeList").empty();
						var dataList,json,value,text;
						 dataList = [];
						var obj = data.obj;
						$.each(obj, function(index, item) {
							if(obj[index].keyword){
								value =obj[index].keyword;
								text =obj[index].keyword;
								 dataList.push({"text":text,"value": value});
							}
						});
						$('.OpeList').combobox({    
			              	panelHeight:300,
			              		valueField: 'value',
			                      textField: 'text',
			                      data: dataList,
			                      editable:true  
			           }); 
						var supplier='${bean.supplier}';
						if(supplier){
								$('.OpeList').combobox('setValue',supplier);
								//$('.OpeList').combobox('setRawValue',supplier);
							}
						  $('.OpeList').combobox('showPanel');
						  $('.OpeList').combobox('textbox').focus();
					}else if(type==1){//市场
						$(".ObjList").empty();
						var dataList,json,orgValue,orgNameValue;
						 dataList = [];
						var obj = data.obj;
							$.each(obj, function(index, item) {
									if(obj[index].regname){
										value =obj[index].regname;
										text =obj[index].regname;
										 dataList.push({"text":text,"value": value});
									}
							});
							if(!objList){
								getObjList();
							}
							 if(objList){
							for (var i = 0; i < objList.length; i++) {
								var regName = objList[i].regName;
								if (regName) {
								value=regName;
								text=regName;
								  dataList.push({"text":text,"value": value});
								}
								}
							 }
						$('.ObjList').combobox({    
			              	panelHeight:300,
			              		valueField: 'value',
			                      textField: 'text',
			                      data: dataList,
			                      editable:true  
			           }); 
					 	var  param1='${bean.param1}';
						if(param1){
						$('.ObjList').combobox('setValue',param1);
						}
						  $('.ObjList').combobox('showPanel');
						  $('.ObjList').combobox('textbox').focus();
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
	/* $('.close').click(function(){
		$('#opeList,.select2-container,#ObjList').hide();
		}) */
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
					if(foodName){
						return;
					}
				if(userId!=null&&userId!=""){//当获取不到档口时不请求数据
					$.ajax({
						type : "POST",
						url : "${webRoot}/ledger/wx/getHistory.do",
						dataType : "json",
						data : {
							userId : userId,
							userType : 1,//进货台账
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
	</script>
	<!-- 压缩图片 -->
	<script type="text/javascript">
   /* 三个参数
    file：一个是文件(类型是图片格式)，
    w：一个是文件压缩的后宽度，宽度越小，字节越小
    objDiv：一个是容器或者回调函数
    photoCompress()
     */
    function photoCompress(file,w,objDiv){
        var ready=new FileReader();
        /*开始读取指定的Blob对象或File对象中的内容. 当读取操作完成时,readyState属性的值会成为DONE,如果设置了onloadend事件处理程序,则调用之.同时,result属性中将包含一个data: URL格式的字符串以表示所读取文件的内容.*/
        ready.readAsDataURL(file);
        ready.onload=function(){
            var re=this.result;
            canvasDataURL(re,w,objDiv);
        }
    }
    function canvasDataURL(path, obj, callback){
        var img = new Image();
        img.src = path;
        img.onload = function(){
            var that = this;
            // 默认按比例压缩
            var w = that.width,
                h = that.height,
                scale = w / h;
            w = obj.width || w;
            h = obj.height || (w / scale);
            var quality = 0.7;  // 默认图片质量为0.7
            //生成canvas
            var canvas = document.createElement('canvas');
            var ctx = canvas.getContext('2d');
            // 创建属性节点
            var anw = document.createAttribute("width");
            anw.nodeValue = w;
            var anh = document.createAttribute("height");
            anh.nodeValue = h;
            canvas.setAttributeNode(anw);
            canvas.setAttributeNode(anh);
            ctx.drawImage(that, 0, 0, w, h);
            // 图像质量
            if(obj.quality && obj.quality <= 1 && obj.quality > 0){
                quality = obj.quality;
            }
            // quality值越小，所绘制出的图像越模糊
            var base64 = canvas.toDataURL('image/jpeg', quality);
            // 回调函数返回base64的值
            callback(base64);
        }
    }
    /**
     * 将以base64的图片url数据转换为Blob
     * @param urlData
     *            用url方式表示的base64图片数据
     */
    function convertBase64UrlToBlob(urlData){
        var arr = urlData.split(','), mime = arr[0].match(/:(.*?);/)[1],
            bstr = atob(arr[1]), n = bstr.length, u8arr = new Uint8Array(n);
        while(n--){
            u8arr[n] = bstr.charCodeAt(n);
        }
        return new Blob([u8arr], {type:mime});
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
	 	$("#stockBtnSave").hide();
	 	$("#stockBtnSaveself").hide();
	 	 setTimeout(function(){
	 			$("#stockBtnSave").show();
	 			$("#stockBtnSaveself").show();
	 	 },1000);
	 }
	</script>
</body>
</html>
