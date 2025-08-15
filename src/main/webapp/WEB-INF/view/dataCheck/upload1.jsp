<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/common/resource.jsp"%>
<html>
  <head>
    <title>快检服务云平台</title>
	  <style>
		  .select2-dropdown{
			  max-width: 200px;
		  }
		  /*.up-label{*/
			/*  display: none;*/
		  /*}*/
		  .upload-form .img-upload{
			  height: 36px;
			  width: 36px;
			  background-size: 60%;
		  }
		  .myfile-list .upload-files{
			  height: 36px;
			  width: 36px;
			  overflow: hidden;
		  }
	  </style>
  </head>

  <!--文件上传样式-->
  <link rel="stylesheet" type="text/css" href="${webRoot}/plug-in/uploader/css/uploader.css" />
  <!--文件上传js-->
  <script src="${webRoot}/plug-in/uploader/js/uploader_svn4442.js"></script>	<%-- 其他人修改过通用版本，会影响本功能，特意保留使用svn4442版本 --%>
  <script src="${webRoot}/js/fileinput.js" type="text/javascript"></script>

  <body>
  <div class="cs-maintab">
  <div class="cs-col-lg clearfix">
	<!-- 面包屑导航栏  开始-->
	<ol class="cs-breadcrumb">
		<li class="cs-fl">
			<img src="${webRoot}/img/set.png" alt="">
			<a href="javascript:">快检数据</a>
		</li>
		<li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
		<li class="cs-fl"><a href="javascript:" class="returnBtn">检测数据</a></li>
		<li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
		<li class="cs-b-active cs-fl">数据录入</li>
	</ol>
  </div>
           
      
    <div class="cs-content2 cs-add-new cs-new-pad clearfix">
    	<form id="checkDataForm" method="post" action="${webRoot}/dataCheck/recording/uploadData1.do">
		      <ul class="cs-ul-style clearfix">
					<li class="cs-name cs-sm-w"><c:if test="${regRequired eq 0}"><i class="cs-mred">*</i></c:if>被检单位：</li>
					<li class="cs-in-style cs-md-w">
						<input type="hidden" name="regId" />
						<input type="hidden" name="regName" />
						<%--<select id="reg_select2" class="js-data-example-ajax" ></select>--%>
						<%@include file="/WEB-INF/view/regulatory/regulatoryObject/selectRegulatoryObject.jsp"%>
					</li>
					
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
						<input type="hidden" name="regUserId" />
						<input type="hidden" name="regUserName" />
						<%@include file="/WEB-INF/view/regulatory/regulatoryBusiness/selectRegulatoryBusiness.jsp"%>
					</li>
					
					<li class="cs-name cs-sm-w">经营者：</li>
					<li class="cs-in-style cs-md-w cs-input-bg"><input type="text" name="opeName" disabled="disabled" /></li>

					<li class="cs-name cs-sm-w"><i class="cs-mred">*</i>食品名称：</li>
					<li class="cs-in-style cs-md-w">
						<input type="hidden" name="foodId" />
						<input type="hidden" name="foodName" />
						<%@include file="/WEB-INF/view/data/foodType/selectFoodType2.jsp"%>
					</li>
		            
					<li class="cs-name cs-sm-w"><i class="cs-mred">*</i>检测项目：</li>
					<li class="cs-in-style cs-md-w">
						<input type="hidden" name="itemId" />
						<input type="hidden" name="itemName" />
						<%@include file="/WEB-INF/view/data/detectItem/selectDetectItem2.jsp"%>
					</li>

					<li class="cs-name cs-sm-w"><i class="cs-mred">*</i>检测值：</li>
					<li class="cs-in-style cs-md-w"><input type="text" name="checkResult" /></li>
		           
					<li class="cs-name cs-sm-w">限定值：</li>
					<li class="cs-in-style cs-md-w"><input type="text" name="limitValue" /></li>
		           
					<li class="cs-name cs-sm-w">限定值单位：</li>
					<li class="cs-in-style cs-md-w"><input type="text" name="checkUnit" /></li>

				  <li class="cs-name cs-sm-w"><i class="cs-mred">*</i>检测结论：</li>
				  <li class="cs-in-style cs-md-w cs-add-new">
					  <select name="conclusion" >
						  <option value="合格">合格</option>
						  <option value="不合格">不合格</option>
					  </select>
				  </li>

				  <li class="cs-name cs-sm-w">检测标准：</li>
				  <li class="cs-in-style cs-md-w"><input type="text" name="checkAccord"/></li>
					
					<li class="cs-name cs-sm-w">检测人员：</li>
					<li class="cs-in-style cs-md-w"><input type="text" name="checkUsername" /></li>
					
					<li class="cs-name cs-sm-w"><i class="cs-mred">*</i>检测时间：</li>
					<li class="cs-in-style cs-md-w"><input type="text" name="checkDate" autocomplete="off" class="cs-time" onClick="WdatePicker({startDate:'%y-%M-%d %H:%m:%s',maxDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})" value='<fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="<%=new java.util.Date()%>"/>' /></li>
					
					<li class="cs-name cs-sm-w">上报人员：</li>
					<li class="cs-in-style cs-md-w cs-input-bg"><input type="text"  value="${user.realname}" name="uploadName" readonly="readonly" /></li>
					
					<li class="cs-name cs-sm-w">上报时间：</li>
					<li class="cs-in-style cs-md-w cs-input-bg"><input type="text"  value='<fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="<%=new java.util.Date()%>"/>' name="uploadDate" readonly="readonly" /></li>
					
					<li class="cs-name cs-sm-w">检测单位：</li>
					<li class="cs-in-style cs-md-w cs-input-bg"><input type="text"  value="${user.departName}" name="departName" readonly="readonly" /></li>
					
					<li class="cs-name cs-sm-w">检测室：</li>
					<li class="cs-in-style cs-md-w cs-input-bg"><input type="text"  value="${user.pointName}" name="pointName" readonly="readonly"  /></li>
					<%--
					<li class="cs-name cs-sm-w">检测仪器：</li>
					<li class="cs-in-style cs-md-w"><input type="text" name="deviceName" /></li>
					
					<li class="cs-name cs-sm-w">仪器厂家：</li>
					<li class="cs-in-style cs-md-w"><input type="text" name="deviceCompany" /></li>
					
					<li class="cs-name cs-sm-w">检测模块：</li>
					<li class="cs-in-style cs-md-w"><input type="text" name="deviceModel" /></li>
					
					<li class="cs-name cs-sm-w">检测方法：</li>
					<li class="cs-in-style cs-md-w"><input type="text" name="deviceMethod" /></li>
					--%>
					<li class="cs-name cs-sm-w"><i class="cs-mred fjjy" style="display: none;">*</i>凭证：</li>
					<li class="cs-in-style cs-md-w">
						<div style="padding-top: 0px;" id="upload"></div>
						<c:if test="${serverName eq 'gs.chinafst.cn'}">
				  		<span class="text-danger fjjy" style="margin-left:10px;display: none;">(注：没有凭证视为无效数据)</span>
						<span style="position: relative;cursor: pointer;">
							<i class="iconfont icon-wuxiao" data-toggle="tooltip" data-index="1" data-type="1" style="color: #ffb20d;"></i>
							<div class="tooltip fade bottom in cs-hide" style="width:200px;right:70px;margin-right:-98px;line-height: 20px;">
								<div class="tooltip-arrow" style="left: 81%;"></div>
								<div class="tooltip-inner">
									<p><b>凭证要求：</b>手工试剂检测数据必须在24小时内上传，且须包含该批次检测证明照片，如：检测样品、胶体金卡或显色管等凭证，否则，将视为无效数据，不计入考核。</p>
								</div>
							</div>
						</span>
						</c:if>
					</li>

					<li class="cs-name cs-sm-w">备注：</li>
					<li class="cs-in-style cs-md-w"><textarea rows="3" cols="5" name="remark" ></textarea></li>
				</ul>
		</form>
	</div>
       <!-- 底部导航 结束 -->
	<div class="cs-alert-form-btn clearfix">
		<button class="cs-menu-btn" onclick="myValidForm(1);"><i class="icon iconfont icon-save"></i>保存</button>
		<button class="cs-menu-btn" onclick="myValidForm(2);"><i class="icon iconfont icon-save"></i>保存并新增</button>
		<button class="cs-menu-btn" onclick="retFun();"><i class="icon iconfont icon-fanhui"></i>返回</button>
		<button class="cs-menu-btn" onclick="clearFoodCache();"><i class="icon iconfont icon-qingchu"></i>清除缓存</button>
	</div>

	  <!-- Modal 附件校验确认-->
	  <div class="modal fade intro2" id="fjjyModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		  <div class="modal-dialog cs-alert-width">
			  <div class="modal-content">
				  <div class="modal-header">
					  <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
					  <h4 class="modal-title">提示</h4>
				  </div>
				  <div class="modal-body cs-alert-height cs-dis-tab">
					  <div class="cs-text-algin">
						  <img src="${webRoot}/img/warn.png" width="40px"/>
						  <span class="tips">手工试剂盒检测结果录入的数据，必须同时上传该批次检测证明照片，包括检测样品和胶体金卡或显色管等凭证。否认，将视为无效数据。请确认是否提交？</span>
					  </div>
				  </div>
				  <div class="modal-footer">
					  <a class="btn btn-success btn-ok" data-dismiss="modal" onclick="fjjyConfirm();">确认</a>
					  <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
				  </div>
			  </div>
		  </div>
	  </div>

     <%@include file="/WEB-INF/view/common/confirm.jsp"%>
    <script type="text/javascript">
		
	$('.icon-wuxiao').hover(function(){
		$('.tooltip').show()
	},function(){
		$('.tooltip').hide()
	})	
		
    $('.js-select2-tags').select2();

	//附件校验
	if (Permission.exist("1404-1")) {
		$(".fjjy").show();
	}

	//监管对象必填，0_必填，1_非必填
	var regRequired = '${regRequired}';

	//文件上传初始化
	let upload = uploader({
		id: "upload", //容器渲染的ID 必填
		accept: '.png,.jpg,.jpeg,.bmp,.gif,.tiff,.pcx,.ico', //可上传的文件类型
		isImage: true, //图片文件上传
		maxCount: 1, //允许的最大上传数量
		maxSize: 2, //允许的文件大小 单位：M
		multiple: false, //是否支持多文件上传
		previewWidth:36,
		name: 'file', //后台接收的文件名称
		onAlert: function(msg) {
			alert(msg);
		},
		onChange: function(file) {
		}
	});

	let saveType;
	//保存前验证
	function myValidForm(t) {
		if(regRequired == 0 && !$("input[name='regId']").val()){
			$("#confirm-warnning .tips").text("被检单位不能为空");
			$("#confirm-warnning").modal('toggle');
			return false;
		}
		if(!$("input[name='foodId']").val()){
			//再取一次选中样品
			var selfood = $('#food_select2').select2('data');
			if(selfood && selfood.length>0 && selfood[0].id && selfood[0].name){
				$("input[name='foodId']").val(selfood[0].id);
				$("input[name='foodName']").val(selfood[0].name);
			}

			if(!$("input[name='foodId']").val()){
				$("#confirm-warnning .tips").text("食品名称不能为空");
				$("#confirm-warnning").modal('toggle');
				return false;
			}
		}
		if(!$("input[name='itemId']").val()){
			//再取一次检测项目
			var selitem = $('#item_select2').select2('data');
			if(selitem && selitem.length>0 && selitem[0].id && selitem[0].name){
				$("input[name='itemId']").val(selitem[0].id);
				$("input[name='itemName']").val(selitem[0].name);
			}

			if(!$("input[name='itemId']").val()){
				$("#confirm-warnning .tips").text("检测项目不能为空");
				$("#confirm-warnning").modal('toggle');
				return false;
			}
		}
		if(!$("input[name='checkResult']").val().trim()){
			$("#confirm-warnning .tips").text("检测值不能为空");
			$("#confirm-warnning").modal('toggle');
			return false;
		}
		if(!$("input[name='checkDate']").val()){
			$("#confirm-warnning .tips").text("检测时间不能为空");
			$("#confirm-warnning").modal('toggle');
			return false;
		}

		let fileName = $("#checkDataForm input[name=file]").val();
		//附件校验
		if (Permission.exist("1404-1") && !fileName) {
			saveType = t;
			$("#fjjyModal").modal('show');
			return false;
		}

		if (t == 2) {
			//保存并新增
			saveAgainFun();
		} else {
			//保存
			saveFun();
		}
	}

	//没附件，确认提交
	function fjjyConfirm(){
		if (saveType == 2) {
			//保存并新增
			saveAgainFun();
		} else {
			//保存
			saveFun();
		}
	}

	//保存
    function saveFun(){
    	$.ajax({
			url: "${webRoot}/dataCheck/recording/uploadData1.do",
			type: "POST",
	        data: new FormData($('#checkDataForm')[0]),
			cache: false,
			processData: false,
			contentType: false,
	        success: function(data){
	        	if(data && data.success){
	        		retFun();
	        	}else{
	        		$("#confirm-warnning .tips").text(data.msg);
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
    }
	
  	//保存再新增
	function saveAgainFun(){
		$.ajax({
			url: "${webRoot}/dataCheck/recording/uploadData1.do",
			type: "POST",
			data: new FormData($('#checkDataForm')[0]),
			cache: false,
			processData: false,
			contentType: false,
	        success: function(data){
	        	if(data && data.success){
	        		$("input[type='hidden']").val("");
					$("#reg_select2").html("");
					$("#business_select2").html("");
					$("#food_select2").html("");
					$("#item_select2").html("");

					$("input[name='opeName']").val("");
					$("input[name='checkResult']").val("");
					$("input[name='checkAccord']").val("");
					$("input[name='limitValue']").val("");
					$("input[name='checkUnit']").val("");

					upload = uploader({
						id: "upload", //容器渲染的ID 必填
						accept: '.png,.jpg,.jpeg,.bmp,.gif,.tiff,.pcx,.ico', //可上传的文件类型
						isImage: true, //图片文件上传
						maxCount: 1, //允许的最大上传数量
						maxSize: 2, //允许的文件大小 单位：M
						multiple: false, //是否支持多文件上传
						previewWidth:36,
						name: 'file', //后台接收的文件名称
						onAlert: function(msg) {
							alert(msg);
						},
						onChange: function(file) {
						}
					});

	        	}else{
	        		$("#confirm-warnning .tips").text(data.msg);
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
	}
  
    //返回
    function retFun(){
    	//开启任务考核功能，0：开启，跳转甘肃定制的检测结果页面；1 关闭，否则则跳转到默认的检测结果页面；默认为1 未开启，
    	if("${assessmentState}"=="0"){
			self.location = "${webRoot}/dataCheck/recording/list3.do";
		}else{
			self.location = "${webRoot}/dataCheck/recording/list.do";
		}

    }

	//选择市场，加载档口编号
	$('#reg_select2').on('select2:select', function (e) {
		var regSel2Data = getRegSelect2Data();
		var rid = regSel2Data[0].id;
		var rname = regSel2Data[0].name;
		if(rid){
			if (rid < 0) {
				$("input[name='regId']").val("");
				$("input[name='regName']").val(rname.replace("[录]",""));
				setTimeout(function () {
					$("#select2-reg_select2-container").html(rname.replace("[录]",""));
				},10);
				getBusinessByRegId(null);
			} else {
				$("input[name='regId']").val(rid);
				$("input[name='regName']").val(rname);
				getBusinessByRegId(rid);
			}
		}else{
			$("input[name='regId']").val("");
			$("input[name='regName']").val("");
			$("input[name='opeName']").val("");
			$('#business_select2').html("");
		}
	});
		
	//选择档口编号，设置经营者
	$('#business_select2').on('select2:select', function (e) {
		var busSel2Data = getBusinessSelect2Data();
		var bid = busSel2Data[0].id;
		var bcode = busSel2Data[0].name;
		var bname = busSel2Data[0].opeName;
		if(bid){
			if (bid < 0) {
				$("input[name='regUserId']").val("");
				$("input[name='regUserName']").val(bcode.replace("[录]",""));
				$("input[name='opeName']").val("");
				setTimeout(function () {
					$("#select2-business_select2-container").html(bcode.replace("[录]",""));
				},10);

			} else {
				$("input[name='regUserId']").val(bid);
				$("input[name='regUserName']").val(bcode);
				$("input[name='opeName']").val(bname);
			}
		}else{
			$("input[name='regUserId']").val("");
			$("input[name='regUserName']").val("");
			$("input[name='opeName']").val("");
		}
	});
		
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
				getItemsByfoodId(fid);
			}else{
				$("input[name='foodId']").val("");
				$("input[name='foodName']").val("");
				$("#item_select2").html("");
			}
		});

	//选择检测项目
	$('#item_select2').on('select2:select', function (e) {
		var itemSel2Data = getItemSelect2Data();
		var iid = itemSel2Data[0].id;
		var iname = itemSel2Data[0].name;

		var foodSel2Data = getFoodSelect2Data();
		var fid = foodSel2Data[0].id;

		if(iid){
			$("input[name='itemId']").val(iid);
			$("input[name='itemName']").val(iname);

			//设置判定标准
			$.ajax({
				url: "${webRoot}/data/detectItem/queryById.do",
				method: "post",
				data: {"id": iid, "foodId": fid},
				success: function(data) {
					if (data && data.success) {
						$("input[name='checkAccord']").val(data.obj.stdCode);
						$("input[name='limitValue']").val(data.obj.detectSign + data.obj.detectValue);
						$("input[name='checkUnit']").val(data.obj.detectValueUnit);
					}
				}
			});

		}else{
			$("input[name='itemId']").val("");
			$("input[name='itemName']").val("");
		}
	});

	//清除样品缓存
	function clearFoodCache(){
		$.cookie("FOOD_TYPE_SEL", "");
		window.location.reload();
	}

</script>
    </body>
</html>
