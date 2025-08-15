<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/common/resource.jsp"%>
<html>
<head>
<title>快检服务云平台</title>
	<style>
		.machine-title{
			width: 100%;
			justify-content: space-between;
			align-items: center;
		}
		.machine-name{
			align-items: center;
			flex: 1;
		}
		.cs-inst-title{
			padding: 0;
		}
		.machine-img img:first-child{
			max-width: 90px;
			width: 90px;
			height: auto;
			border-radius: 5px;
		}
		.machine-img .zz-jinzhi{
			width: 56px;
			height: 56px;
			transform: translate(-50%,-50%);
			margin: auto;
		}
		.machine-box{
			align-items: flex-start;
		}
		.machine-img{
			padding: 10px;
			align-self: center;
			position: relative;
		}
		.machine-info{
			padding: 5px;
		}
		.machine-info>div{
			padding: 3px 0;
		}
		.cs-inst-title{
			height: auto;
		}
		.cs-list-fl li{
			width: 32%;
		}
		.cs-img-content{
			min-height: 120px;
			height: auto;
		}
		.info-name{
			min-width: 76px;
		}
		.cs-inst-title .icon {
			margin: 0 2px;
		}
		.cs-list-fl{
			display: flex;
			flex-wrap: wrap;
		}
		.info-text{
			word-break: break-all;
		}
	</style>
</head>
<body>
	<div class="cs-col-lg clearfix">
		<!-- 面包屑导航栏  开始-->
		<ol class="cs-breadcrumb">
			<li class="cs-fl"><img src="${webRoot}/img/set.png" /> <a href="javascript:">检测点管理</a></li>
			<li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
			<li class="cs-fl">快检点</li>
			<li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
			<li class="cs-b-active cs-fl">检测点详情</li>
		</ol>
		<!-- 面包屑导航栏  结束-->
		<div class="cs-search-box cs-fr">
			<form>
				<div class="clearfix cs-fr" id="showBtn">
					<a href="javascript:" id="myBtnReturn" class="cs-menu-btn"><i class="icon iconfont icon-fanhui"></i>返回</a>
				</div>
				<div class="cs-menu-btn cs-fr cs-ac" id="adddev" style="display: none;">
					<a class="runcode" href="javascript:" onclick="getDev();" name="content_frm_srtc" data-toggle="modal" data-target="#myModal-mid"><i class="icon iconfont icon-zengjia"></i>编辑温湿度计</a>
				</div>
			</form>
		</div>
	</div>

	<table class="cs-detail-table">
		<tr>
			<td class="cs-name" width="120px">名称：</td>
			<td width="250px"><c:if test="${!empty point}">${point.pointName}</c:if></td>
			<td class="cs-name" width="120px">地址：</td>
			<td><c:if test="${!empty point}">${point.address}</c:if><img src="${webRoot}/img/di.png" /></td>
		</tr>
	</table>
	<div class="cs-tb-box">
		<ul class="cs-list-fl">
			<c:if test="${!empty devices}">
				<c:forEach items="${devices}" var="device">
					<li>

							<div>
								<div class="cs-inst-title" colspan="2">
									<div class="machine-title is-flex">
											<div class="cs-name-width is-flex machine-name">
										<c:choose>
											<c:when test="${device.status eq 0}"><i class="icon iconfont icon-dui1"></i></c:when>
											<c:otherwise><i class="icon iconfont icon-cuo1 cs-red-text"></i></c:otherwise>
										</c:choose>
										${device.deviceName}
									</div>
										<div class="cs-control cs-fr iBtns">
											<input class="deviceId" type="hidden" value="${device.id}">
										</div>
									</div>
								</div>
							</div>
							<div>
								<div class="cs-img-content">
									<div class="machine-box is-flex">
										<div class="machine-img">
										<c:forEach items="${deviceTypes}" var="deviceType">
											<c:if test="${deviceType.id eq device.deviceTypeId}">
												<c:if test="${empty deviceType.filePath}">
													<img src="${webRoot}/img/products/u91.jpg" />
												</c:if>
												<c:if test="${!empty deviceType.filePath}">
													<img src="${webRoot}${deviceType.filePath}" />
												</c:if>
											</c:if>
										</c:forEach>
											<c:if test="${device.status ne 0}">
												<img class="zz-jinzhi"  src="${webRoot}/img/jinzhi.png" title="停用" />
											</c:if>
										</div>
										<div class="machine-info">
											<div class="text-left is-flex"><div class="info-name">仪器系列：</div><div class="text-primary">${device.deviceSeries}</div></div>
											<div class="text-left is-flex"><div class="info-name">出厂编号：</div><div class="text-primary info-text">${device.deviceCode}</div></div>
											<div class="text-left is-flex"><div class="info-name">仪器标识：</div>
												<div class="text-primary info-text">${device.serialNumber}
												<c:if test="${! empty device.serialNumber}" ><span class="cs-icon-span unbindDevice cs-hide" onclick="confirmUnbind('${device.id}','${device.deviceCode}')" title="解绑"><i class="iconfont icon-close text-danger"></i></span></c:if>
												</div>
											</div>
											<div class="text-left is-flex"><div class="info-name">注册时间：</div><div class="text-primary"><fmt:formatDate type="both" value="${device.registerDate}"/></div></div>
											<div class="text-left is-flex"><div class="info-name">最后使用：</div><div class="text-primary"><fmt:formatDate type="both" value="${device.lastUploadDate}"/></div></div>
											<c:if test="${empty device.serialNumber}" >
												<div class="text-left is-flex"><div class="info-name">解绑时间：</div><div class="text-primary"><fmt:formatDate type="both" value="${device.unbindingDate}"/></div></div>
											</c:if>
										</div>
									</div>
								</div>
							</div>

					</li>
				</c:forEach>
			</c:if>
		</ul>
	</div>

	<!-- 新增、编辑注册仪器 -->
	<form id="register" action="${webRoot}/data/devices/save.do" method="post">
		<div class="modal fade intro2" id="registerModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" data-backdrop="static">
			<div class="modal-dialog cs-lg-width" role="document">
				<div class="modal-content ">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
						<h4 class="modal-title">新增仪器</h4>
					</div>
					<div class="modal-body cs-lg-height">
						<div class="cs-content">
							<table class="cs-add-new">
								<input type="hidden" name="id" />
								<input type="hidden" name="pointId" value="${point.id}" />
								<input type="hidden" name="deviceStyle" value="仪器设备" />
								<input type="hidden" name="uploadNumbers" value="" />
								<tr>
									<td class="cs-name"><i class="cs-mred">*</i>仪器名称：</td>
									<td class="cs-in-style"><input type="text" name="deviceName" datatype="*" nullmsg="请输入仪器名称" errormsg="请输入仪器名称" sucmsg="通过验证！"/></td>
								</tr>
								<tr>
									<td class="cs-name"><i class="cs-mred">*</i>仪器类别：</td>
									<td><select name="deviceTypeId" datatype="*" nullmsg="请选择仪器类型" errormsg="请选择仪器类型" sucmsg="通过验证！">
											<option value="" data-deviceSeries="">---请选择仪器类型---</option>
											<c:forEach items="${deviceTypes}" var="deviceType">
												<option value="${deviceType.id}" data-deviceSeries="${deviceType.deviceSeries}">${deviceType.deviceName}</option>
											</c:forEach>
									</select></td>
								</tr>
								<!-- 隐藏仪器系列编码          2019/04/15 -->
								<!-- 
								<tr>
									<td class="cs-name">仪器系列：</td>
									<td class="cs-in-style deviceSeries"></td>
								</tr>
								 -->
								<tr>
									<td class="cs-name"><i class="cs-mred">*</i>出厂编号：</td>
									<td class="cs-in-style"><input id="deviceCode" type="text" name="deviceCode" datatype="*" nullmsg="请输入仪器出厂编号" errormsg="请输入仪器出厂编号" sucmsg="通过验证！"/></td>
								</tr>

								<tr>
									<input type="hidden" name="macAddress">
									<td class="cs-name">MAC地址：</td>
									<td class="cs-in-style"><span class="macAddress"></span></td>
								</tr>
								<tr>
									<input type="hidden" name="serialNumber">
									<td class="cs-name">唯一标识：</td>
									<td class="cs-in-style"><span class="serialNumber"></span></td>
								</tr>
								<tr class="showRegister hide">
									<input type="hidden" name="registerDate">
									<td class="cs-name">注册时间：</td>
									<td class="cs-in-style"><span class="registerDate"></span></td>
								</tr>
								<tr class="showRegister hide">
									<input type="hidden" name="lastUploadDate">
									<td class="cs-name">最后使用：</td>
									<td class="cs-in-style"><span class="lastUploadDate"></span></td>
								</tr>
								<tr class="showUnbindDate hide">
									<input type="hidden" name="unbindingDate">
									<td class="cs-name">解绑时间：</td>
									<td class="cs-in-style"><span class="unbindingDate"></span></td>
								</tr>
								<tr>
									<td class="cs-name">状态：</td>
									<td class="cs-in-style">
										<input id="status0" type="radio" name="status" value="0">
										<label for="status0">启用</label>
										
										<input id="status1" type="radio" name="status" value="1">
										<label for="status1">停用</label>
									</td>
								</tr>
								<%--20220906 隐藏功能--%>
<%--								<tr>--%>
<%--									<td class="cs-name">出厂日期：</td>--%>
<%--									<td class="cs-in-style"><input type="text" name="useDate" class="cs-time" onClick="WdatePicker({startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true})" autocomplete="off"/></td>--%>
<%--								</tr>--%>
<%--								<tr>--%>
<%--									<td class="cs-name">保修期：</td>--%>
<%--									<td class="cs-in-style"><input type="text" name="warrantyPeriod" class="cs-time" onClick="WdatePicker({startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true})" autocomplete="off"/></td>--%>
<%--								</tr>--%>
								<tr>
									<td class="cs-name">描述说明：</td>
									<td class="cs-in-style"><textarea name="description"></textarea></td>
								</tr>
							</table>
						</div>
					</div>
					<div class="modal-footer action">
						<button type="submit" class="btn btn-success" onclick="mySubmit();">确定</button>
						<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					</div>
				</div>
			</div>
		</div>
	</form>


	<!-- Modal 2 中-->
	<form class="registerform" id="devForm" method="post" action="#">
		<div class="modal fade intro2" id="myModal-mid" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
			<div class="modal-dialog cs-mid-width" role="document">
				<div class="modal-content ">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
						<h4 class="modal-title" id="myModalLabel">新增</h4>
					</div>
					<div class="modal-body cs-mid-height">
						<!-- 主题内容 -->
						<div class="cs-main">
							<div class="cs-wraper">
								<input type="hidden" name="point_id" value="${point.id}"> <input type="hidden" name="id" id="devId" value="">
								<div width="100%" class="cs-add-new">
									<ul class="cs-ul-form clearfix">
										<li class="cs-name col-md-3">所属检测点：</li>
										<li class="cs-in-style col-md-5"><input type="text" id="pointName" value="<c:if test="${!empty point}">${point.pointName}</c:if>" name="" class="inputxt" datatype="s6-18" /></li>
									</ul>
									<ul class="cs-ul-form clearfix">
										<li class="cs-name col-md-3" width="20% ">仪器名称：</li>
										<li class="cs-in-style col-md-5" width="210px"><input type="text" value="" id="dev_name" name="dev_name" class="inputxt" /></li>
										<li class="col-md-4 cs-text-nowrap">
											<div class="Validform_checktip"></div>
											<div class="info">
												<i class="cs-mred">*</i>
											</div>
										</li>
									</ul>
									<ul class="cs-ul-form clearfix">
										<li class="cs-name col-md-3" width="20% ">仪器设备号：</li>
										<li class="cs-in-style col-md-5" width="210px"><input type="text" value="" id="dev_key" name="dev_key" class="inputxt" /></li>
										<li class="col-md-4 cs-text-nowrap">
											<div class="Validform_checktip"></div>
											<div class="info">
												<i class="cs-mred">*</i>
											</div>
										</li>
									</ul>
									<ul class="cs-ul-form clearfix">
										<li class="cs-name col-md-3" width="20% ">账号：</li>
										<li class="cs-in-style col-md-5" width="210px"><input type="text" value="" id="dev_userID" name="dev_userID" class="inputxt" /></li>
										<li class="col-md-4 cs-text-nowrap">
											<div class="Validform_checktip"></div>
											<div class="info">
												<i class="cs-mred">*</i>
											</div>
										</li>
									</ul>
									<ul class="cs-ul-form clearfix">
										<li class="cs-name col-md-3">密码：</li>
										<li class="cs-in-style col-md-5"><input type="text" value="" id="dev_password" name="dev_password" class="inputxt" datatype="*6-18" /></li>
										<li class="col-md-4 cs-text-nowrap">
											<div class="Validform_checktip"></div>
										</li>
									</ul>
								</div>
							</div>
						</div>
					</div>
					<div class="modal-footer action">
						<button type="button" class="btn btn-success" onclick="saveDev();">确定</button>
						<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					</div>
				</div>
			</div>
		</div>
	</form>

	<!-- 删除温湿度计模态框 start  2018-4-28 cola_hu-->
	<!-- Modal 提示窗-删除-->
	<div class="modal fade intro2" id="confirm-delete3" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog cs-alert-width">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title">确认删除</h4>
				</div>
				<div class="modal-body cs-alert-height cs-dis-tab">
					<div class="cs-text-algin">
						<img src="${webRoot}/img/stop2.png" width="40px" /> <span class="tips">确认解除温度计绑定么？</span>
					</div>
				</div>
				<div class="modal-footer">
					<a class="btn btn-danger btn-ok" onclick="del();">删除</a>
					<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
				</div>
			</div>
		</div>
	</div>

	<div class="modal fade intro2" id="confirm-warnning" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog cs-alert-width">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title">提示</h4>
				</div>
				<div class="modal-body cs-alert-height cs-dis-tab">
					<div class="cs-text-algin" id="waringMsg">
						<img src="${webRoot}/img/warn.png" width="40px" alt="" /> <span class="tips">操作失败</span>
					</div>
				</div>
				<div class="modal-footer">
					<a class="btn btn-primary btn-ok" data-dismiss="modal">关闭</a>
				</div>
			</div>
		</div>
	</div>
	<!-- end  -->

	<%--仪器解绑确认框 start--%>
	<div class="modal fade intro2" id="confirm-unbind" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog cs-alert-width">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
					<h4 class="modal-title">仪器解绑</h4>
				</div>
				<div class="modal-body cs-alert-height cs-dis-tab">
					<div class="cs-text-algin">
						<img src="${webRoot}/img/stop2.png" width="40px"/>
						<span class="tips">确认解绑该仪器吗？</span>
					</div>
				</div>
				<div class="modal-footer">
					<a class="btn btn-danger btn-ok" onclick="unbindDevice()">解绑</a>
					<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
				</div>
			</div>
		</div>
	</div>
	<%--仪器解绑确认框 end--%>
	<!-- 引用模态框 -->
	<%@include file="/WEB-INF/view/common/confirm.jsp"%>
	<%@include file="/WEB-INF/view/common/modalBox.jsp"%>

	<!-- JavaScript -->
	<script type="text/javascript">
		var functionIcon;//功能图标
		var operationName;//功能说明
		//查看仪器检测项目
		if(Permission.exist("391-5") || Permission.exist("1497-5")){
			functionIcon=Permission.exist("391-5")==1? Permission.getPermission("391-5").functionIcon : Permission.getPermission("1497-5").functionIcon;
			$(".iBtns").prepend('<span class="cs-icon-span"><i class="'+functionIcon+' viewDevice"></i></span>');
		}
		//新增仪器
		if(Permission.exist("391-17") || Permission.exist("1497-17")){
			 functionIcon=Permission.exist("391-17")==1? Permission.getPermission("391-17").functionIcon : Permission.getPermission("1497-17").functionIcon;
			 operationName=Permission.exist("391-17")==1? Permission.getPermission("391-17").operationName : Permission.getPermission("1497-17").operationName;
			var html = '<a class="cs-menu-btn" href="javascript:;" onclick="registerDevice();"><i class="'
				+ functionIcon+ '"></i>' + operationName + '</a>';
			$("#showBtn").prepend(html);
		}
		//编辑仪器
		if(Permission.exist("391-18") || Permission.exist("1497-18")){
			functionIcon=Permission.exist("391-18")==1? Permission.getPermission("391-18").functionIcon : Permission.getPermission("1497-18").functionIcon;
			$(".iBtns").prepend('<span class="cs-icon-span"><i class="'+functionIcon+' editDevice"></i></span>');
		}
		//查看检测任务
		if(Permission.exist("391-10") || Permission.exist("1497-10")){
			functionIcon=Permission.exist("391-10")==1? Permission.getPermission("391-10").functionIcon : Permission.getPermission("1497-10").functionIcon;
			$(".iBtns").prepend('<span class="cs-icon-span"><i class="'+functionIcon+' checkTask"></i></span>');
		}
		//删除仪器
		if(Permission.exist("391-12") || Permission.exist("1497-12")){
			functionIcon=Permission.exist("391-12")==1? Permission.getPermission("391-12").functionIcon : Permission.getPermission("1497-12").functionIcon;
			$(".iBtns").prepend('<span class="cs-icon-span"><i class="'+functionIcon+' deleteDevice"></i></span>');
		}
		//删除仪器唯一标识
		if(Permission.exist("391-6") || Permission.exist("1497-6")){
			functionIcon=Permission.exist("391-6")==1? Permission.getPermission("391-6").functionIcon : Permission.getPermission("1497-6").functionIcon;
			$(".serialNumber").parent().append('<span class="cs-icon-span" onclick=\"cleanSerialNumber()\"><i class="'+functionIcon+'  "></i></span>');
			$(".unbindDevice").removeClass("cs-hide");
		}
		//查看温湿度计
		if(Permission.exist("391-7") || Permission.exist("392-4") || Permission.exist("1497-7")){
			$("#temperature").show(); //显示温湿度数据信息
		}
		//设置温湿度计
		if(Permission.exist("391-8") || Permission.exist("392-5") ||Permission.exist("1497-8")){
			//$(".iBtns").append(	'<div class="cs-menu-btn cs-fr cs-ac"><a class="runcode" href="javascript:;" onclick="getDev();" name="content_frm_srtc" data-toggle="modal" data-target="#myModal-mid"><i class="icon iconfont icon-zengjia"></i>设置温湿度计</a></div>');
			$("#adddev").show();
		}
		//删除温湿度计
		if(Permission.exist("391-9") || Permission.exist("392-6") || Permission.exist("1497-9")){
			$("#del").show();
		}
		/* 
		for (var i = 0; i < childBtnMenu.length; i++) {
			if (childBtnMenu[i].operationCode == "391-5") {
				//检测项目
				$(".iBtns").prepend('<span class="cs-icon-span"><i class="'+childBtnMenu[i].functionIcon+' viewDevice"></i></span>');
			} else if (childBtnMenu[i].operationCode == "391-1") {
				//新增
				var html = '<a class="cs-menu-btn" href="javascript:;" onclick="registerDevice();"><i class="'+childBtnMenu[i].functionIcon+'"></i>'
						+ childBtnMenu[i].operationName + '</a>';
				$("#showBtn").prepend(html);
			} else if (childBtnMenu[i].operationCode == "391-2") {
				//编辑
				$(".iBtns").prepend('<span class="cs-icon-span"><i class="'+childBtnMenu[i].functionIcon+' editDevice"></i></span>');
			} else if (childBtnMenu[i].operationCode == "391-10") {
				//查看检测任务
				$(".iBtns").prepend('<span class="cs-icon-span"><i class="'+childBtnMenu[i].functionIcon+' checkTask"></i></span>');
			} else if (childBtnMenu[i].operationCode == "391-12") {
				//删除仪器
				$(".iBtns").append('<span class="cs-icon-span"><i class="'+childBtnMenu[i].functionIcon+' deleteDevice"></i></span>');
			} else if (childBtnMenu[i].operationCode == "391-6") {
				//删除仪器唯一标识
				$(".serialNumber").parent().append('<span class="cs-icon-span" onclick=\"cleanSerialNumber()\"><i class="'+childBtnMenu[i].functionIcon+'"></i></span>');
			} else if (childBtnMenu[i].operationCode == "391-7" || childBtnMenu[i].operationCode == "392-4") {//查看温湿度计
				$("#temperature").show(); //显示温湿度数据信息
			} else if (childBtnMenu[i].operationCode == "391-8" || childBtnMenu[i].operationCode == "392-5") {//设置温湿度计
				//$(".iBtns").append(	'<div class="cs-menu-btn cs-fr cs-ac"><a class="runcode" href="javascript:;" onclick="getDev();" name="content_frm_srtc" data-toggle="modal" data-target="#myModal-mid"><i class="icon iconfont icon-zengjia"></i>设置温湿度计</a></div>')
				$("#adddev").show();
			} else if (childBtnMenu[i].operationCode == "391-9" || childBtnMenu[i].operationCode == "392-6") {//删除温湿度计
				$("#del").show();
			}
		}
		*/

		//验证
		var registerValidform = $("#register").Validform({
			tiptype : 3,
			label : ".label",
			showAllError : true,
			callback : function(data) {
				if (data.success) {
					self.location.reload();
				} else {
					$.Showmsg(data.msg);
				}
				return false;
			}
		});

		$(document).on('change', '#deviceCode', function() {
			//出厂编码验证
			//checkDeviceCode();
			
			//根据系列和出厂编码查询仪器
			getDeviceBySeriesAndCode();
		});
		//返回按钮
		$('#myBtnReturn').on('click', function(event) {
			if("${openIframe}"=="N"){
				self.history.back();
			}else{
				parent.closeMbIframe();
				parent.viewBasePoint(parent.departId);
			}
		});
		//根据系列和出厂编码查询仪器
		function getDeviceBySeriesAndCode(){
			if($('select[name="deviceTypeId"]').val() && $('#deviceCode').val()){
				$.ajax({
					type : "POST",
					url : "${webRoot}/data/devices/queryBySeriesAndCode",
					data : {
						"deviceSeriesId" : $('select[name="deviceTypeId"]').val(),
						"deviceCode" : $('#deviceCode').val()
					},
					dataType : "json",
					success : function(data) {
						var obj = data.obj;
						if (obj) {
							if(!$("input[name='useDate']").val()){
								$("input[name='useDate']").val((newDate(obj.useDate)).format("yyyy-MM-dd"));
							}
							if(!$("input[name='warrantyPeriod']").val()){
								$("input[name='warrantyPeriod']").val(obj.warrantyPeriod);
							}
						}
					}
				});
			}
		}
		
		//修改出厂编码验证规则
		/* function checkDeviceCode() {
			//停用验证
			return false;
			
			//恢复出厂编码验证
			registerValidform.addRule([ 
				{
					ele : "#deviceCode",
					datatype : "*",
					ajaxurl : "${webRoot}/data/devices/queryByDeviceCode.do?deviceCode=" + $("input[name='deviceCode']").val()
							+ "&deviceId=" + $("#register input[name='id']").val(),
					nullmsg : "请输入出厂编号",
					errormsg : "出厂编号错误"
				} 
			]);
		} */

		//修改仪器类别
		$(document).on('change', 'select[name="deviceTypeId"]', function() {
			setDeviceSeries();
			
			//根据系列和出厂编码查询仪器
			getDeviceBySeriesAndCode();
		});
		//查看 
		$(document).on("click", ".viewDevice", function() {
			var deviceId = $(this).parent().siblings(".deviceId").val();
			devicesItems(deviceId);
		});
		//编辑
		$(document).on("click", ".editDevice", function() {
			var deviceId = $(this).parent().siblings(".deviceId").val();
			registerDevice(deviceId);
		});
		//查看检测任务
		$(document).on("click", ".checkTask", function() {
			var deviceId = $(this).parent().siblings(".deviceId").val();
			showMbIframe("${webRoot}/data/devices/deviceTasks.do?id=" + deviceId);
		});
		//删除
		$(document).on("click", ".deleteDevice", function() {
			var deviceId = $(this).parent().siblings(".deviceId").val();
			deleteDevice(deviceId);
		});

		//设置仪器系列
		function setDeviceSeries() {
			/**隐藏仪器系列编码          2019/04/15**/
			return;
			
			var deviceSeries = $('select[name="deviceTypeId"]').find("option:selected").attr("data-deviceSeries");
			$(".deviceSeries").text(deviceSeries);
		}

		//清空注册仪器模态框输入框
		$('#registerModal').on('hidden.bs.modal', function() {
			registerValidform.resetForm();
			registerValidform.resetStatus();
			$(".showRegister").addClass("hide");
			$(".showUnbindDate").addClass("hide");
			$("#register input[name='id']").val("");
			$("#register input[name='macAddress']").val("");
			$("#register input[name='serialNumber']").val("");
			$("#register input[name='registerDate']").val("");
			$("#register input[name='lastUploadDate']").val("");
			$("#register input[name='unbindingDate']").val("");
			$(".deviceSeries").text("");
		});

		//保存
		function mySubmit() {
			registerValidform.ajaxPost();
		}

		function getDev() {
			var pointId = "${point.id}";
			$.ajax({
				type : "POST",
				url : '${webRoot}' + "/environment/getDev.do",
				data : {
					pointId : pointId
				},
				dataType : "json",
				success : function(data) {
					var obj = data.obj;
					if (obj) {
						$("#dev_password").val(obj.dev_password);
						$("#dev_userID").val(obj.dev_userID);
						$("#dev_name").val(obj.dev_name);
						$("#dev_key").val(obj.dev_key);
						$("#devId").val(obj.id);
					}
				}
			});
		}

		function delete3() {
			$("#confirm-delete3").modal('toggle');
		}
		function del() {
			var id = '${manage.id}';
			var point_id = '${point.id}';
			if (id == null || id == "") {
				alert("删除失败！");
				return;
			}

			$.ajax({
				type : "POST",
				url : '${webRoot}' + "/environment/save.do",
				data : {
					id : id,
					delete_flag : 1,
					point_id : point_id
				},
				dataType : "json",
				success : function(data) {
					if (data.success) {
						alert("解除成功！");
					} else {
						alert("删除失败！");
					}
					self.location.reload();
				}
			})
		}
		function saveDev() {
			var dev_name = $("#dev_name").val();
			var dev_userID = $("#dev_userID").val();
			var dev_key = $("#dev_key").val();
			var dev_password = $("#dev_password").val();
			if (dev_name == null || dev_name == "") {
				alert("设备名称不能为空！");
				return;
			}
			if (dev_key == null || dev_key == "") {
				alert("设备号不能为空！");
				return;
			}
			if (dev_userID == null || dev_userID == "") {
				alert("账号不能为空！");
				return;
			}
			if (dev_password == null || dev_password == "") {
				alert("密码不能为空！");
				return;
			}
			$.ajax({
				type : "POST",
				url : '${webRoot}' + "/environment/save.do",
				data : $('#devForm').serialize(),
				dataType : "json",
				success : function(data) {
					if (data.success) {
						$("#myModal-mid").modal('hide');
						alert(data.msg);
					} else {
						alert(data.msg);
					}
					self.location.reload();
				}
			})
		}
		//注册仪器
		function registerDevice(id) {
			$("input[name='deviceStyle']").val("仪器设备");
			if (id) {
				$(".serialNumber").parents("tr").show();
				$(".macAddress").parents("tr").show();
				$("#registerModal .modal-title").text("编辑仪器");
				$.ajax({
					type : "POST",
					url : '${webRoot}' + "/data/devices/queryById.do",
					data : {
						"id" : id
					},
					dataType : "json",
					async: false,
					success : function(data) {
						if (data && data.success) {
							var obj = data.obj;
							if (obj) {
								$("#register").find("input[name='id']").val(obj.id);
								$("#register").find("select[name='deviceTypeId']").val(obj.deviceTypeId);
								$("#register").find("input[name='deviceName']").val(obj.deviceName);
								$("#register").find("input[name='deviceCode']").val(obj.deviceCode);

								$("#register").find(".macAddress").text(obj.macAddress);
								$("input[name='macAddress']").val(obj.macAddress);
								if (obj.serialNumber && obj.serialNumber != "") {
									$(".serialNumber").next().show();
									$(".showRegister").removeClass("hide");
									$(".showUnbindDate").addClass("hide");
								} else {
									$(".serialNumber").next().hide();
									if (obj.unbindingDate!=""){
										$(".showUnbindDate").removeClass("hide");
									}
									$(".showRegister").addClass("hide");
								}
								if (obj.useDate) {
									$("#register").find("input[name='useDate']").val(newDate(obj.useDate).format("yyyy-MM-dd"));
								}
								if (obj.warrantyPeriod) {
									$("#register").find("input[name='warrantyPeriod']").val(newDate(obj.warrantyPeriod).format("yyyy-MM-dd"));
								}
								$(".serialNumber").text(obj.serialNumber);
								$("input[name='serialNumber']").val(obj.serialNumber);
								$(".registerDate").text(obj.registerDate);
								$(".lastUploadDate").text(obj.lastUploadDate);
								$("#register").find("input[name='registerDate']").val(obj.registerDate);
								$("#register").find("input[name='lastUploadDate']").val(obj.lastUploadDate);
								$(".unbindingDate").text(obj.unbindingDate);
								$("#register").find("input[name='unbindingDate']").val(obj.unbindingDate);

								$("#register").find("textarea[name='description']").val(obj.description);
								if(0 == obj.status){
									$("input[name='status']:eq(0)").prop("checked",true);
								}else{
									$("input[name='status']:eq(1)").prop("checked",true);
								}
								setDeviceSeries();
								
								//编辑仪器，不修改出厂编码情况下，不作验证
								$("#register").find("input[name='deviceCode']").removeAttr("ajaxurl");
							}
						}
					}
				});
			} else {
				$("#register .modal-title").text("新增仪器");
				$(".serialNumber").parents("tr").hide();
				$(".macAddress").parents("tr").hide();
				$("input[name='status']:eq(0)").prop("checked",true);
				
				//新增仪器，需要验证出厂编码
				//checkDeviceCode();
			}
			
			$("#registerModal").modal('toggle');
		}

		//管理仪器项目
		function devicesItems(id) {
			self.location = '${webRoot}/data/devices/devicesItemsList.do?id=' + id;
		}

		//删除仪器
		var deleteId = "";
		function deleteDevice(id) {
			deleteId = id;
			$("#confirm-delete").modal('toggle');
		}

		//删除仪器
		function deleteData() {
			$.ajax({
				type : "POST",
				url : '${webRoot}' + "/data/devices/delete.do",
				data : {
					"ids" : deleteId
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

		//删除唯一标识
		function cleanSerialNumber() {
			$(".macAddress").text("");
			$(".serialNumber").text("");
			$("input[name='macAddress']").val("");
			$("input[name='serialNumber']").val("");
			$("input[name='uploadNumbers']").val('0');
			$(".registerDate").text("");
			$(".lastUploadDate").text("");
			$("input[name='registerDate']").val('');
			$("input[name='lastUploadDate']").val('');
			$("#register").find("input[name='unbindingDate']").val(new Date().format("yyyy-MM-dd HH:mm:ss"));
			$(".serialNumber").next().hide();
		}
		//仪器解绑确认
		var unbindDeviceId;
		function confirmUnbind(deviceId,deviceCode){
			unbindDeviceId=deviceId;
			$("#confirm-unbind .tips").text("确认解绑编号："+deviceCode+"仪器吗？");
			$("#confirm-unbind").modal('toggle');
		}
		//在对仪器进行解绑时，同时清空“注册时间”、“累计上传数量”以及“最后使用时间”等字段的数据，并记录解绑时间
		function unbindDevice(){
			$.ajax({
				type : "POST",
				url : '${webRoot}' + "/data/devices/unbindDevice.do",
				data : {
					"deviceId" : unbindDeviceId
				},
				dataType : "json",
				success : function(data) {
					if (data && data.success) {
						self.location.reload();
					} else {
						$("#confirm-unbind").modal('toggle');
						$("#confirm-warnning .tips").text('解绑失败');
						$("#confirm-warnning").modal('toggle');
					}
				}
			});
		}
	</script>
</body>
</html>
