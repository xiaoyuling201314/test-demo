<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/common/resource.jsp"%>

<!--文件上传样式-->
<link rel="stylesheet" type="text/css" href="${webRoot}/plug-in/uploader/css/uploader.css" />
<!--文件上传js-->
<script src="${webRoot}/plug-in/uploader/js/uploader.js"></script>

<html>
  <head>
    <title>快检服务云平台</title>
    <link rel="stylesheet" type="text/css" href="${webRoot}/plug-in/easyui-1.5.2/tree.css">
    <style type="text/css">
    	.layout-split-west{
    	 bottom:50px;
    	}
        .Validform_checktip{
            height: auto;
        }
        .cs-add-new .cs-name{
            width: 200px;
        }
		.img-upload{
			height: 50px;
			width: 50px;
		}
		.upload-files{
			display: flex;
			align-items: center;
			height: 50px;
			width: 50px;
			overflow: hidden;
			border-radius: 5px;
			margin-left: 5px;
		}
		.upload-files img{
			width: 100%;
		}
		.myfile-list li i{
			z-index: 1;
		}
		.show-media{
			z-index: 10;
		}
    </style>
  </head>
 <body class="easyui-layout">
	<div data-options="region:'west',split:true,title:'组织机构'" style="width: 200px; padding: 10px;">
		<ul id="departTree" class="easyui-tree" style="padding-bottom:40px;"></ul>
	</div>

	<div data-options="region:'north',border:false" style="top:0px; border: none;">
		<div >
			<!-- 面包屑导航栏  开始-->
			<ol class="cs-breadcrumb">
				<li class="cs-fl"><img src="${webRoot}/img/set.png" alt="" /><a href="javascript:">机构管理</a></li>
				<li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
				<li class="cs-b-active cs-fl">组织结构</li>
			</ol>
			<!-- 面包屑导航栏  结束-->
			<div class="cs-search-box cs-fr">
				<form>
					<div class="cs-search-filter clearfix cs-fl">
						 <input class="cs-input-cont cs-fl" type="text" id="showInput" placeholder="请输入内容" />
						 <input class="cs-input-cont cs-fl focusInput" name="depart.departName" id="departName"  type="hidden" />
						 <input type="button" onclick="query()" class="cs-search-btn cs-fl" href="javascript:;" value="搜索">
					</div>
					<div class="clearfix cs-fr" id="showBtn"></div>
				</form>
			</div>
		</div>
	</div>

	<div data-options="region:'center'">
		<!-- 列表搜索条件 -->
		<input type="hidden" class="focusInput" name="depart.departPid" id="departPid">
		<div id="dataList"></div>
	</div>

	<!-- 检测机构新增 开始 -->
	<div class="modal fade intro2" id="addDepartModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" data-backdrop="static">
	  <div class="modal-dialog cs-lg-width" role="document">
	    <div class="modal-content ">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" id="myModalLabel">新增检测机构</h4>
	      </div>
	      <div class="modal-body cs-lg-height">
	      	<form id="addDepartForm" action="${webRoot}/detect/depart/save.do" method="post" enctype="multipart/form-data">
	      	  <div class="cs-content">
			    <table class="cs-add-new">
			      <tr>
			      	<input type="hidden" name="id"/>
				  	<input type="hidden" name="deleteFlag" value="0"/>
				  	<input type="hidden" name="departCode"/>
			        <td class="cs-name"><i class="cs-mred">*</i>机构名称：</td>
			        <td class="cs-in-style"><input type="text" name="departName" datatype="*" nullmsg="请输入机构名称" errormsg="请输入机构名称"/></td>
			      </tr>
			      <tr>
			        <td class="cs-name">所属机构：</td>
			        <td class="cs-in-style">
						<div class="cs-all-ps">
							<div class="cs-input-box">
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

					<tr class="systemTr cs-hide">
						<td class="cs-name">系统LOGO：</td>
						<td class="cs-in-style">
							<div class="myfile-list clearfix" id="logoImg"></div>
							<input type="hidden" name="systemLogo">
						</td>
					</tr>
					<tr class="systemTr cs-hide">
						<td class="cs-name">系统名称：</td>
						<td class="cs-in-style"><input type="text" name="systemName"/></td>
					</tr>
					<tr class="systemTr cs-hide">
						<td class="cs-name">系统版权：</td>
						<td class="cs-in-style"><input type="text" name="systemCopyright"/></td>
					</tr>

			      <tr id="regionSetTR" style="display: none;">
			        <td class="cs-name">行政机构：</td>
			        <td class="cs-in-style">
			        	<select style="width: 80px;" name="regionId">
			        		<option value="${country.regionId}">${country.regionName}</option>
			        	</select>
			        	<select style="width: 100px;" name="regionId" id="province" onchange="changeProvince();">
			        		<option value="">--请选择--</option>
			        		<c:forEach items="${provinces}" var="r">
				        		<option value="${r.regionId}">${r.regionName}</option>
			        		</c:forEach>
			        	</select>
			        	<select style="width: 100px;" name="regionId" id="city" onchange="changeCity();">
			        		<option value="">--请选择--</option>
			        	</select>
			        	<select style="width: 100px;" name="regionId" id="county" onchange="changeCounty();">
			        		<option value="">--请选择--</option>
			        	</select>
			        	<select style="width: 100px;" name="regionId" id="town">
			        		<option value="">--请选择--</option>
			        	</select>
			        </td>
			      </tr>
			      <tr>
			        <td class="cs-name">机构描述：</td>
			        <td class="cs-in-style"><input type="text" name="description"/></td>
			      </tr>
			      <%-- <tr>
			        <td class="cs-name">负责人：</td>
			        <td class="cs-in-style">
				          <!-- 自定义下拉单选 -->
				          <input type="hidden" class="selectpickerValue" name="principalId">
						  <div class="fl cs-select-box">
							<div id="select2" class="selectpicker cs-select-style" data-clear="true" data-autoclose="false" data-live="true">
				              <a href="#" class="clear"><span class="fa fa-times"></span><span class="sr-only">Cancel the selection</span></a>
				              <button data-id="prov" type="button" class="btn btn-self  btn-default dropdown-toggle">
				              <span class="placeholder selectpickerText">请选择</span>
				              <span class="caret"></span>
				              </button>
				              <div class="dropdown-menu">
				                <div class="live-filtering" data-clear="true" data-autocomplete="true" data-keys="true">
				                  <label class="sr-only" for="input-bts-ex-5">Search in the list</label>
				                  <div class="search-box">
				                    <div class="input-group">
				                      <span class="fa fa-search"></span>
				                      <a href="#" class="fa fa-times hide filter-clear"><span class="sr-only">Clear filter</span></a>
				                      <input type="text" placeholder="请输入搜索内容" id="input-select3" class="form-control live-search" aria-describedby="search-icon8" tabindex="1" />
				                    </div>
				                  </div>
				                  <div class="list-to-filter">
				                    <ul class="list-unstyled">
				                      <li class="optgroup">
				                        <ul class="list-unstyled">
				                          <c:if test="${!empty workers}">
				                          	<c:forEach items="${workers}" var="worker">
				                          		<li class="filter-item items" data-filter="${worker.workerName}" data-value="${worker.id}">${worker.workerName}</li>
				                          	</c:forEach>
				                          </c:if>
				                        </ul>
				                      </li>
				                    </ul>
				                  </div>
				                </div>
				              </div>
				              <input type="hidden" name="bts-ex-5" value="">
				            </div>
				          </div>
						</td>
			      </tr> --%>
			      <tr>
			        <td class="cs-name">地址：</td>
			        <td class="cs-in-style"><input type="text" name="address"/></td>
			      </tr>
			      <tr>
			        <td class="cs-name">联系方式：</td>
			        <td class="cs-in-style"><input type="text" name="mobilePhone"/></td>
			      </tr>
			      <tr>
			        <td class="cs-name">序号：</td>
			        <td class="cs-in-style"><input type="text" name="sorting" class="inputxt" datatype="/^[0-9]{0,6}$/" errormsg="请输入不超过6位数字序号"/></td>
			      </tr>
			      <!-- <tr>
			        <td class="cs-name">备注：</td>
			        <td class="cs-in-style"><textarea name="remark"></textarea></td>
			      </tr>  -->
			    </table>
			  </div>
			</form>
	      </div>
	      <div class="modal-footer">
	      	<button type="button" class="btn btn-success" id="btnSave">确定</button>
	        <button type="button" class="btn btn-default" data-dismiss="modal" id="btnCancel">关闭</button>
	      </div>
	    </div>
	  </div>
	</div>
	<!-- 检测机构新增 结束 -->

	<!-- 批量新增检测机构 开始 -->
	<div class="modal fade intro2" id="addDepartModal2" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" data-backdrop="static">
	  <div class="modal-dialog cs-mid-width" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" id="myModalLabel2">批量新增检测机构</h4>
	      </div>
	      <div class="modal-body cs-mid-height">
	      	<form id="addDepartForm2" action="${webRoot}/detect/depart/batchAdd" method="post" enctype="multipart/form-data">
	      	  <div class="cs-content">
			    <table class="cs-add-new">
			      <tr>
			        <td class="cs-name">所属机构：</td>
			        <td class="cs-in-style">
						<div class="cs-all-ps">
							<div class="cs-input-box">
							  <input type="text" name="departPName" readonly="readonly" datatype="*" ignore="ignore" nullmsg="请选择所属机构" errormsg="请选择所属机构">
							  <input type="hidden" name="departPid" datatype="*" ignore="ignore" nullmsg="请选择所属机构" errormsg="请选择所属机构">
							  <div class="cs-down-arrow"></div>
							</div>
							<div class="cs-check-down cs-hide" style="display: none;">
							  <ul id="myDeaprtTree2" class="easyui-tree"></ul>
							</div>
						</div>
					 </td>
			      </tr>
					<tr>
						<td class="cs-name" style="vertical-align: top;"><i class="cs-mred" >*</i>机构名称：</td>
						<td class="cs-in-style">
							<textarea style="height: 80px" name="departNames" datatype="*" nullmsg="请输入机构名称(多个以,隔开)" errormsg="请输入机构名称(多个以,隔开)" placeholder="请输入机构名称(多个以,隔开)" ></textarea>
						</td>
					</tr>
			    </table>
			  </div>
			</form>
	      </div>
	      <div class="modal-footer">
	      	<button type="button" class="btn btn-success" id="btnSave2">确定</button>
	        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
	      </div>
	    </div>
	  </div>
	</div>
	<!-- 批量新增检测机构 结束 -->

	<div class="icon iconfont" id="hidevideo"></div>
	<div id="seeimg" class="hide show-media" onclick="hideLogo();">
		<img style="height: 80%" src="">
	</div>

	<!-- 引用模态框 -->
	<%@include file="/WEB-INF/view/common/confirm.jsp"%>
	<%@ include file="/WEB-INF/view/common/exportDialog.jsp" %>
	<!-- 下拉插件 -->
	<script src="${webRoot}/js/select/tabcomplete.min.js"></script>
	<script src="${webRoot}/js/select/livefilter.min.js"></script>
	<script src="${webRoot}/js/select/bootstrap-select.js"></script>
	<script src="${webRoot}/js/select/filterlist.js"></script>
	<!-- JavaScript -->
	<script src="${webRoot}/js/datagridUtil.js"></script>
	<script type="text/javascript">

	//新增
	if(Permission.exist("393-1")){
		var html='<a class="cs-menu-btn" href="javascript:;" onclick="addDepart();"><i class="'+Permission.getPermission("393-1").functionIcon+'"></i>'+Permission.getPermission("393-1").operationName+'</a>';
		$("#showBtn").append(html);
	}

	//批量新增
	if(Permission.exist("393-11")){
		var html='<a class="cs-menu-btn" href="javascript:;" onclick="addDepart2();"><i class="'+Permission.getPermission("393-11").functionIcon+'"></i>'+Permission.getPermission("393-11").operationName+'</a>';
		$("#showBtn").append(html);
	}

	if(Permission.exist("393-7")){
		$("#regionSetTR").attr('style','display:""');
	}

	if(Permission.exist("393-10")){
		$(".systemTr").show();
	}

	//点击查询进行搜索，清空左侧的机构的parentId
	  function query(){
		  $("#departPid").val("");
		  $("#departName").val($("#showInput").val());
		  datagridUtil.queryByFocus();
	  }

	//回车查询数据
	  document.onkeydown=function(event){
		var e = event || window.event || arguments.callee.caller.arguments[0];
		if(e && e.keyCode==13){ //enter键
			var focusedElement = document.activeElement;//当前关键词元素
			if(focusedElement && focusedElement.className){
				query();
			}
			return false;
		}
	  }

	//验证
	var addDepartValidform=$("#addDepartForm").Validform({
		tiptype:3,
	    label:".label",
	    showAllError:true,
		beforeSubmit: function () {
			var formData = new FormData($('#addDepartForm')[0]);
			let files = upload.files;
			if (files.length > 0) {
				for (let i = 0; i < files.length; i++) {
					formData.append("systemLogoImg",files[i])
				}
			}
			$.ajax({
				type: "POST",
				url: "${webRoot}/detect/depart/save.do",
				data: formData,
				contentType: false, //必须false才会避开jQuery对 formdata 的默认处理 XMLHttpRequest会对 formdata 进行正确的处理
				processData: false, //必须false才会自动加上正确的Content-Type
				dataType: "json",
				success: function (data) {
					if (data && data.success) {
						window.location.reload();
					} else {
						$("#waringMsg>span").html(data.msg);
						$("#confirm-warnning").modal('toggle');
					}
				}
			});
			return false;
		}
	});

	//验证
	var addDepartValidform2=$("#addDepartForm2").Validform({
		tiptype:3,
	    label:".label",
	    showAllError:true,
		beforeSubmit: function () {
			$.ajax({
				type: "POST",
				url: "${webRoot}/detect/depart/batchAdd",
				// data: new FormData($('#addDepartForm2')[0]),
				data: $('#addDepartForm2').serialize(),
				dataType: "json",
				success: function (data) {
					if (data && data.success) {
						window.location.reload();
					} else {
						$("#waringMsg>span").html(data.msg);
						$("#confirm-warnning").modal('toggle');
					}
				}
			});
			return false;
		}
	});

	// 新增或修改
	$("#btnSave").on("click", function() {
		$("#addDepartForm").submit();
	});

	// 新增或修改
	$("#btnSave2").on("click", function() {
		$("#addDepartForm2").submit();
	});

	//打开新增、编辑检查机构模态框
	function addDepart(id){
		//初始化上传LOGO控件
		initSystemLogoUploader();

		if(id){
			$("#addDepartModal .modal-title").text("编辑检测机构");
			$.ajax({
		        type: "POST",
		        url: "${webRoot}/detect/depart/queryById.do",
		        data: {"id":id},
		        dataType: "json",
		        success: function(data){
		        	if(data && data.success){
		        		var obj = data.obj;
		        		if(obj){
			        		if(obj.depart){
				        		$('#addDepartModal').find("input[name='id']").val(obj.depart.id);
				        		$('#addDepartModal').find("input[name='departCode']").val(obj.depart.departCode);
				        		$('#addDepartModal').find("input[name='departName']").val(obj.depart.departName);
				        		$('#addDepartModal').find("input[name='systemName']").val(obj.depart.systemName);
				        		$('#addDepartModal').find("input[name='systemCopyright']").val(obj.depart.systemCopyright);
				        		if (obj.depart.systemLogo) {
									$('#addDepartModal').find("input[name='systemLogo']").val(obj.depart.systemLogo);
									$(".up-label").hide();
									if ($("#file-list-logoImg .upload-files").length == 0) {
										$("#file-list-logoImg").append('<li class="upload-files"><i class="del-img icon iconfont icon-close shanchu del_image2"'
												+ '"></i> <img src="${resourcesUrl}' + obj.depart.systemLogo + '" width="70px"></li>');
									} else {
										$("#file-list-logoImg .upload-files").append('<i class="del-img icon iconfont icon-close shanchu del_image2"'
												+ '"></i> <img src="${resourcesUrl}' + obj.depart.systemLogo + '" width="70px">');
									}
								} else {
									$('#addDepartModal').find("input[name='systemLogo']").val("");
									$(".upload-files").html("");
									$(".up-label").show();
								}
				        		$('#addDepartModal').find("input[name='description']").val(obj.depart.description);
				        		$('#addDepartModal').find("input[name='address']").val(obj.depart.address);
				        		$('#addDepartModal').find("input[name='mobilePhone']").val(obj.depart.mobilePhone);
				        		$('#addDepartModal').find("input[name='sorting']").val(obj.depart.sorting);
				        		//$('#addDepartModal').find("textarea[name='remark']").val(obj.depart.remark);
				        		if(obj.regionIds[1]!= undefined && obj.regionIds[1] != ""){
					        		$("#province").val(obj.regionIds[1]);
				        			changeProvince();
				        		}
			        			if(obj.regionIds[2]!= undefined && obj.regionIds[2] != ""){
				        			$("#city").val(obj.regionIds[2]);
				        			changeCity();
			        			}
			        			if(obj.regionIds[3]!= undefined && obj.regionIds[3] != ""){
				        			$("#county").val(obj.regionIds[3]);
				        			changeCounty();
			        			}
			        			if(obj.regionIds[4]!= undefined && obj.regionIds[4] != ""){
				        			$("#town").val(obj.regionIds[4]);
			        			}
			        		}
			        		if(obj.superior){
			        			$('#addDepartModal').find("input[name='departPid']").val(obj.superior.id);
				        		$('#addDepartModal').find("input[name='departPName']").val(obj.superior.departName);
							}
							if(obj.principal){
								$('#select2').find(".selectpickerValue").val(obj.principal.id);
								$('#select2').find(".selectpickerText").text(obj.principal.workerName);
							}
		        		}
		        	}
				}
		    });
		}else{
			$("#addDepartModal .modal-title").text("新增检测机构");
		}
		$("#addDepartModal").modal('toggle');
	}

	//打开批量新增机构模态框
	function addDepart2(){
		$("#addDepartModal2").modal('toggle');
	}

	//上传系统LOGO
	let upload;

	//加载组织机构树形控件数据列表
	$(function(){
	    //setTimeout(function(){
    	loadDepartTree();
        //},500)

		$(document).on('click','.del_image',function(){
			$(".up-label").show();
		});
		$(document).on('click','.del_image2',function(){
			$('#addDepartModal').find("input[name='systemLogo']").val("");
			$(".upload-files").html("");
			$(".up-label").show();
		});
	});

	//上传系统LOGO控件
	function initSystemLogoUploader(){
		upload = uploader({
			id: "logoImg", //容器渲染的ID 必填
			accept: '.png,.jpg,.jpeg,.bmp,.gif,.tiff,.pcx,.ico', //可上传的文件类型
			isImage: true, //图片文件上传
			maxCount: 1, //允许的最大上传数量
			maxSize: 1, //允许的文件大小 单位：M
			multiple: false, //是否支持多文件上传
			name: 'systemLogoImg', //后台接收的文件名称
			onAlert: function(msg) {
				alert(msg);
			},
			onChange: function(file) {
				let reader = new FileReader();//读取文件的对象
				reader.readAsDataURL(file[0]);//读取文件的信息
				reader.onload = function (e) {
					var logo = new Image();
					logo.src = e.target.result;
					setTimeout(function(){
						if ($(".upload-files").length >= 1) {
							$(".up-label").hide();
						}
					}, 10);
				}
			}
		});
	}

	var treeLevel = 1;	//控制机构树加载二级数据
	function loadDepartTree(){
		treeLevel = 1;
		$("#departTree").tree({
			url:"${webRoot}/detect/depart/getDepartTree.do",
			animate:true,
			onClick : function(node){
				$("input[name='depart.departPid']").val(node.id);
				datagridUtil.queryByFocus();
			},
			onBeforeLoad:function(node, param){
				param.isJoinId=true;
			},
			onLoadSuccess: function (node, data) {
				//延迟执行自动加载二级数据，避免与异步加载冲突
				setTimeout(function(){
					if (data && treeLevel == 1) {
						treeLevel++;
				    	$(data).each(function (index, d) {
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
	var treeLoadTimes = 1;	//控制获取顶级树
	var topNodeId = '';
	var topNodeText = '';
	var treeLevels = 1;
	$('#myDeaprtTree').tree({
		checkbox : false,
		url : "${webRoot}/detect/depart/getDepartTree.do",
		animate : true,
		onClick : function(node) {
			$('#addDepartModal').find("input[name='departPid']").val(node.id);
			$('#addDepartModal').find("input[name='departPName']").val(node.text);
		},
		onLoadSuccess: function (node, data) {
			//设置新增所属机构为当前用户所属机构
			if(treeLoadTimes == 1 ){
				treeLoadTimes++;
				var topNode = $('#myDeaprtTree').tree('getRoot');
				topNodeId = topNode.id;
				topNodeText = topNode.text;
				$('#addDepartModal').find("input[name='departPid']").val(topNode.id);
				$('#addDepartModal').find("input[name='departPName']").val(topNode.text);

			}
			//延迟执行自动加载二级数据，避免与异步加载冲突
			setTimeout(function(){
				if (data && treeLevels == 1) {
					treeLevels++;
			    	$(data).each(function (index, d) {
			         	if (this.state == 'closed') {
			        		var children = $('#myDeaprtTree').tree('getChildren');
			        		for (var i = 0; i < children.length; i++) {
			            		$('#myDeaprtTree').tree('expand', children[i].target);
			            	}
			         	}
			    	});
				}
			}, 100);
		}
	});



	//批量新增
	var treeLoadTimes2 = 1;	//控制获取顶级树
	var topNodeId2 = '';
	var topNodeText2 = '';
	var treeLevels2 = 1;
	if(Permission.exist("393-11")){
		$('#myDeaprtTree2').tree({
			checkbox : false,
			url : "${webRoot}/detect/depart/getDepartTree.do",
			animate : true,
			onClick : function(node) {
				$('#addDepartModal2').find("input[name='departPid']").val(node.id);
				$('#addDepartModal2').find("input[name='departPName']").val(node.text);
			},
			onLoadSuccess: function (node, data) {
				//设置新增所属机构为当前用户所属机构
				if(treeLoadTimes2 == 1 ){
					treeLoadTimes2++;
					var topNode2 = $('#myDeaprtTree2').tree('getRoot');
					topNodeId2 = topNode2.id;
					topNodeText2 = topNode2.text;
					$('#addDepartModal2').find("input[name='departPid']").val(topNode2.id);
					$('#addDepartModal2').find("input[name='departPName']").val(topNode2.text);

				}
				//延迟执行自动加载二级数据，避免与异步加载冲突
				setTimeout(function(){
					if (data && treeLevels2 == 1) {
						treeLevels2++;
						$(data).each(function (index, d) {
							if (this.state == 'closed') {
								var children2 = $('#myDeaprtTree2').tree('getChildren');
								for (var i = 0; i < children2.length; i++) {
									$('#myDeaprtTree2').tree('expand', children2[i].target);
								}
							}
						});
					}
				}, 100);
			}
		});
	}

   	$('#addDepartModal').on('hidden.bs.modal', function (e) {
   		//清空隐藏域
  	  $("#addDepartModal input").val("");
	  $("#addDepartModal textarea").val("");
	  $('#select2').find(".selectpickerText").text("请选择");
	  addDepartValidform.resetForm();
	  $('#addDepartModal').find("input[name='departPid']").val(topNodeId);
	  $('#addDepartModal').find("input[name='departPName']").val(topNodeText);
   	});

   	$('#addDepartModal2').on('hidden.bs.modal', function (e) {
   		//清空隐藏域
  	  $("#addDepartModal2 input").val("");
  	  $("#addDepartModal2 textarea").val("");
	  addDepartValidform2.resetForm();
	  $('#addDepartModal2').find("input[name='departPid']").val(topNodeId2);
	  $('#addDepartModal2').find("input[name='departPName']").val(topNodeText2);
   	});

	var op = {
		tableId: "dataList",
		tableAction: "${webRoot}/detect/depart/datagrid.do",
		parameter: [
			{
				columnCode: "departNames",
				columnName: "机构名称",
				columnWidth: "20%"
			},
			{
				columnCode: "departPnames",
				columnName: "上级机构",
				columnWidth: "20%"
			},
			{
				columnCode: "mobilePhone",
				columnName: "联系方式"
			},
			{
				columnCode: "address",
				columnName: "地址"
			},
			{
				columnCode: "systemName",
				columnName: "系统名称",
				customStyle: 'system_name',
				show: Permission.exist("393-10")
			},
			{
				columnCode: "systemCopyright",
				columnName: "版权",
				show: Permission.exist("393-10")
			}
		],
		funBtns: [
	    	{
				show: Permission.exist("393-2"),
				style: Permission.getPermission("393-2"),
	    		action: function(id){
	    			addDepart(id);
	    		}
	    	},
	    	{
				show: Permission.exist("393-3"),
				style: Permission.getPermission("393-3"),
	    		action: function(id){
	    			if(id == ''){
	    				$("#confirm-warnning .tips").text("请选择检测机构");
	    				$("#confirm-warnning").modal('toggle');
	    			}else{
		    			deleteIds = id;
	    				$("#confirm-delete").modal('toggle');
	    			}
	    		}
	    	}
	    ],
	    bottomBtns: [
	    	{
				show: Permission.exist("393-3"),
				style: Permission.getPermission("393-3"),
	    		action: function(ids){
	    			if(ids == ''){
	    				$("#confirm-warnning .tips").text("请选择检测机构");
	    				$("#confirm-warnning").modal('toggle');
	    			}else{
		    			deleteIds = ids;
	    				$("#confirm-delete").modal('toggle');
	    			}
	    		}
	    	},
	    	{//导出
				show: Permission.exist("393-8"),
				style: Permission.getPermission("393-8"),
	    		action: function(ids){
	    			if($("#departPid").val()!=""){
	    				$("#exportModal").modal('toggle');
	    			}else {
	    				$("#confirm-warnning .tips").text("请选择机构!");
		    			$("#confirm-warnning").modal('toggle');
					}
	    		}
	    	},
	    	{//导入
				show: Permission.exist("393-9"),
				style: Permission.getPermission("393-9"),
	    		action: function(ids){
	    			location.href='${webRoot}/detect/depart/toImport.do'
	    		}
	    	}
    	], onload: function (rows, pageData) {
			if (rows) {
				for (var i = 0; i < rows.length; i++) {
					if (rows[i].id && rows[i].systemLogo) {//迭代出所有不为空的id
						var currentTd = $("tr[data-rowid=" + rows[i].id + "]").find(".system_name");//获取当前对应行的TD
						currentTd.html("<div style=\"display:flex;align-items:center;justify-content:center;padding:3px 0;\"><a onclick=\"showLogo('${resourcesUrl}" + rows[i].systemLogo + "');\" style=\"width: 40px;min-width: 40px;\"><img src=\"${resourcesUrl}" + rows[i].systemLogo + "\" class=\"img-thumbnail\" style=\"height:100%;\"></a><div style=\"padding-left:4px;text-align:left;\">" + rows[i].systemName+"</div></div>");
					}
				}
			}
		}
	};
	datagridUtil.initOption(op);

    datagridUtil.query();

  //导出方法
    function exportFile(){
		var radios = document.getElementsByName('inlineRadioOptions');
		var ext = '';
		for (var i = 0; i < radios.length; i++) {
			if(radios[i].checked){
				ext = radios[i].value;
			}
		}
		if (ext!='') {
			location.href='${webRoot}/detect/depart/exportFile.do?'+'&types='+ext+"&departId="+$("#departPid").val();
			$("#exportModal").modal('hide');
		}else {
			$("#exportModal").modal('hide');
			$("#confirm-warnning .tips").text("请选择导出格式!");
			$("#confirm-warnning").modal('toggle');
		}
	}

    //重写确认模态框函数
    var deleteIds;
    function deleteData(){
    	var idsStr = "{\"ids\":\""+deleteIds.toString()+"\"}";
			$.ajax({
		        type: "POST",
		        url: '${webRoot}'+"/detect/depart/delete.do",
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


	function changeProvince(){
		var provinceId = $("#province").val();
		$.ajax({
			url:'${webRoot}/region/queryRegionByRegionId?regionId='+provinceId,
			async:false,
			success:function(data){
				$("#city").empty();
				var html = '<option value="">--请选择--</option>';
				for (var i = 0; i < data.length; i++) {
					html += '<option value="'+data[i].regionId+'">'+data[i].regionName+'</option>';
				}
				$("#city").html(html);
				changeCity();
				changeCounty();
			}
		});
	}
	function changeCity(){
		var cityId = $("#city").val();
		$.ajax({
			url:'${webRoot}/region/queryRegionByRegionId?regionId='+cityId,
			async:false,
			success:function(data){
				$("#county").empty();
				var html = '<option value="">--请选择--</option>';
				for (var i = 0; i < data.length; i++) {
					html += '<option value="'+data[i].regionId+'">'+data[i].regionName+'</option>';
				}
				$("#county").html(html);
				changeCounty();
			}
		});
	}
	function changeCounty(){
		var countyId = $("#county").val();
		$.ajax({
			url:'${webRoot}/region/queryRegionByRegionId?regionId='+countyId,
			async:false,
			success:function(data){
				$("#town").empty();
				var html = '<option value="">--请选择--</option>';
				for (var i = 0; i < data.length; i++) {
					html += '<option value="'+data[i].regionId+'">'+data[i].regionName+'</option>';
				}
				$("#town").html(html);
			}
		});
	}
	function showLogo(url) {
		$("#seeimg").find("img").attr("src", url);
		$("#seeimg").removeClass("hide");
		$("#hidevideo").append(html);

	}
	function hideLogo() {
		$("#seeimg").addClass("hide");
	}
	</script>
</body>
</html>
