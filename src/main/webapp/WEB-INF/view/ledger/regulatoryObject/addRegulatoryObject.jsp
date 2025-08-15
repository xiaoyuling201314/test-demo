<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/common/resource.jsp"%>

<!DOCTYPE html>
<head>
<title>快检服务云平台</title>
<style type="text/css">
.cs-gh li {
	padding: 0;
	line-height: 38px;
}
.cs-gh .cs-map{
	background: #dddddd;
}
.cs-gh .cs-map,.cs-gh .cs-down-arrow{
	height: 27px;
	border-radius: 0 2px 2px 0;
}
.cs-add-new select, .cs-add-new2 select {
	width: 200px;
	height: 29px;
	border-radius: 4px;
	border: 1px solid #ddd;
	padding: 0 30px 0 8px;
}
	.audit input[type='radio']{
		margin-top: 12px;
	}
	.cs-add-new .cs-name{
		padding-right: 0;
	}

</style>
</head>

<body>
	<div class="cs-maintab">
		<div class="cs-col-lg clearfix">
			<!-- 面包屑导航栏  开始-->
			<ol class="cs-breadcrumb">
				<li class="cs-fl"><img src="${webRoot}/img/set.png" alt=""><a href="javascript:">监管对象</a></li>
				<c:if test="${!empty regulatoryType}">
					<li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
					<li class="cs-fl">${regulatoryType.regType}</li>
					<li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
					<li class="cs-b-active cs-fl"><c:if test="${!empty regulatoryObject}">编辑${regulatoryObject.regName}</c:if><c:if test="${empty regulatoryObject}">新增${regulatoryType.regType}</c:if></li>
				</c:if>
			</ol>
			<!-- 面包屑导航栏  结束-->
			<div class="cs-search-box cs-fr">
				<form>
					<div class=" cs-fr cs-ac ">
						<a class="cs-menu-btn" href="javascript:" onclick="saveself();"><i class="icon iconfont icon-save"></i>保存并新增</a>
						<a class="cs-menu-btn" href="javascript:" onclick="save();"><i class="icon iconfont icon-save"></i>保存</a>
						<c:choose>
							<c:when test="${isNewMenu=='N'}">
								<a class="cs-menu-btn" href="javascript:" onclick="self.location.href='${webRoot}/ledger/regulatoryObject/list.do?regTypeCode=${regulatoryType.regTypeCode}'"><i class="icon iconfont icon-fanhui"></i>返回</a>
							</c:when>
							<c:when test="${isNewMenu=='Y'}">
								<a class="cs-menu-btn" href="javascript:" onclick="parent.closeMbIframe();"><i class="icon iconfont icon-fanhui"></i>返回</a>
							</c:when>
						</c:choose>
					</div>
				</form>
			</div>
		</div>
		<input type="hidden" name="savetype" id="savetype" value="0">
		<form id="regForm" action="${webRoot}/ledger/regulatoryObject/save.do" method="post">
			<input type="hidden" name="id" <c:if test="${!empty regulatoryObject}">value="${regulatoryObject.id}"</c:if>>
			<div class="cs-base-detail">
				<div class="cs-content2 cs-add-new">
					<h3>基本信息</h3>
					<ul class=" cs-gh cs-add-new clearfix">
						<li class="cs-name cs-sm-w"><i class="cs-mred">*</i>监管对象：</li>
						<li class="cs-in-style cs-fl  cs-md-w">
							<div class="cs-all-ps">
								<div class="cs-input-box">
									<input type="text" name="regName" id="regName" class="resetClass" datatype="*" nullmsg="请输入市场名称" errormsg="请输入企业名称" <c:if test="${!empty regulatoryObject}">value="${regulatoryObject.regName}"</c:if> autocomplete="off" />
									<div class="cs-map" data-toggle="modal" data-target="#positionModal" onclick="openMap1();">
										<span class="cs-icon-span"><i title="定位" class="icon iconfont icon-local"></i></span>
									</div>
								</div>
							</div>
						</li>
						<li class="cs-name cs-sm-w">企业名称：</li>
						<li class="cs-in-style cs-md-w  cs-add-new">
							<input type="text" name="companyName" class="resetClass"   <c:if test="${!empty regulatoryObject}">value="${regulatoryObject.companyName}"</c:if> />
						</li>
						<li>
						<li class="cs-name cs-sm-w"><i class="cs-mred">*</i>企业类型：</li>
						<li class="cs-in-style cs-md-w  cs-add-new"><select name="regType" id="regType" onchange="changeregType();"   datatype="*" nullmsg="请选择企业类型" errormsg="请选择企业类型">
								<c:forEach items="${regulatoryTypes}" var="rtype">
									<option value="${rtype.id}"  <c:if test="${ rtype.id == regulatoryType.id }">selected='selected'</c:if>>${rtype.regType}</option>
								</c:forEach>
						</select></li>
						<li>
							<li class="cs-name cs-sm-w  mType"  style="display: none" ><i class="cs-mred">*</i>市场类型：</li>
						<li class="cs-in-style cs-md-w  cs-add-new mType" style="display: none"><select name="managementType"  id="managementType" >
									<option value="" >--请选择市场类型--</option>
									<option value="1" <c:if test="${regulatoryObject.managementType==1 }">selected="selected"</c:if>>农贸市场</option>
									<option value="0" <c:if test="${regulatoryObject.managementType==0 }">selected="selected"</c:if>>批发市场</option>
						</select></li>	
						<li class="cs-name cs-sm-w"><i class="cs-mred">*</i>所属机构：</li>
						<li class="cs-in-style cs-md-w">
							<div class="cs-all-ps">
								<div class="cs-input-box">
									<input type="text" name="departName" datatype="*" nullmsg="请选择所属机构" errormsg="请选择所属机构" autocomplete="off"
										<c:choose>
										   <c:when test="${!empty regulatoryObject}">value="${regulatoryObject.departName}"</c:when>
										   <c:otherwise>value="${user.departName}"</c:otherwise>
										</c:choose>
									>
									<input type="hidden" name="departId"
										<c:choose>
											<c:when test="${!empty regulatoryObject}">value="${regulatoryObject.departId}"</c:when>
											<c:otherwise>value="${user.departId}"</c:otherwise>
										</c:choose>
									>
									<div class="cs-down-arrow"></div>
								</div>
								<div class="cs-check-down cs-hide" style="display: none;">
									<ul id="myDeaprtTree" class="easyui-tree"></ul>
								</div>
							</div>
						</li>

						<li class="cs-name cs-sm-w">社会统一信用代码：</li>
						<li class="cs-in-style cs-md-w"><input type="text" name="creditCode" class="resetClass"  <c:if test="${!empty regulatoryObject}">value="${regulatoryObject.creditCode}"</c:if> /></li>
						<li class="cs-name cs-sm-w">法人名称：</li>
						<li class="cs-in-style cs-md-w"><input type="text" name="legalPerson" class="resetClass"  <c:if test="${!empty regulatoryObject}">value="${regulatoryObject.legalPerson}"</c:if> /></li>
						<li class="cs-name cs-sm-w">联系人名称：</li>
						<li class="cs-in-style cs-md-w"><input type="text" name="linkUser" class="resetClass"  <c:if test="${!empty regulatoryObject}">value="${regulatoryObject.linkUser}"</c:if> /></li>

						<li class="cs-name cs-sm-w">联系人电话：</li>
						<li class="cs-in-style cs-md-w"><input type="text" name="linkPhone" class="resetClass"  <c:if test="${!empty regulatoryObject}">value="${regulatoryObject.linkPhone}"</c:if> /></li>

						<li class="cs-name cs-sm-w">联系人身份证：</li>
						<li class="cs-in-style cs-md-w"><input type="text" name="linkIdcard" class="resetClass"  <c:if test="${!empty regulatoryObject}">value="${regulatoryObject.linkIdcard}"</c:if> /></li>
						<li class="cs-name cs-sm-w">传真：</li>
						<li class="cs-in-style cs-md-w"><input type="text" name="fax" class="resetClass" <c:if test="${!empty regulatoryObject}">value="${regulatoryObject.fax}"</c:if> /></li>
						<li class="cs-name cs-sm-w">排序：</li>
						<li class="cs-in-style cs-md-w"><input type="text" name="sorting" class="resetClass" <c:if test="${!empty regulatoryObject}">value="${regulatoryObject.sorting}"</c:if> /></li>

						<li class="cs-name cs-sm-w">邮编：</li>
						<li class="cs-in-style cs-md-w"><input type="text" name="post" class="resetClass"  <c:if test="${!empty regulatoryObject}">value="${regulatoryObject.post}"</c:if> /></li>
						<li class="cs-name cs-sm-w">通讯地址：</li>
						<li class="cs-in-style cs-md-w"><input type="text" name="regAddress" class="resetClass"  <c:if test="${!empty regulatoryObject}">value="${regulatoryObject.regAddress}"</c:if> /></li>
						<li class="cs-name cs-sm-w">经度纬度：</li>
						<li class="cs-in-style cs-md-w">
							<div class="cs-all-ps">
								<div class="cs-input-box">
									<input type="text" name="placeXY" class="resetClass"  <c:if test="${!empty regulatoryObject}">value="${regulatoryObject.placeX},${regulatoryObject.placeY}"</c:if> readonly="readonly"> <input type="hidden" name="placeX" <c:if test="${!empty regulatoryObject}">value="${regulatoryObject.placeX}"</c:if>> <input type="hidden" name="placeY" <c:if test="${!empty regulatoryObject}">value="${regulatoryObject.placeY}"</c:if>>
								</div>
							</div>
						</li>
						<li class="cs-name cs-sm-w" style="line-height: 18px">经营范围：</li>
						<li class="cs-in-style cs-md-w"><textarea name="businessCope" class="resetClass" maxlength="100" rows="" cols="" style="width: 200px; height: 50px;">${regulatoryObject.businessCope}</textarea></li>

						<li class="cs-name cs-sm-w taskType cs-hide ">任务类型：</li>
						<li class="cs-in-style cs-md-w  cs-add-new taskType cs-hide">
							<select name="taskType" id="taskType" >
								<%--<option value="0" >无</option>--%>
									<option value="1" >省级</option>
									<option value="2" >市级</option>
									<option value="3" >县级</option>
									<option value="4" >街镇</option>
							</select>
						</li>

						<li class="cs-name cs-sm-w audit cs-hide">状态：</li>
						<li class="cs-in-style cs-md-w audit cs-hide cs-radio">
							<input id="cs-check-radio0" type="radio" value="0" name="checked" <c:if test="${!empty regulatoryObject && regulatoryObject.checked eq '0'}">checked="checked"</c:if> /><label for="cs-check-radio0">未审核</label>
							<input id="cs-check-radio1" type="radio" value="1" name="checked" <c:if test="${empty regulatoryObject ||  regulatoryObject.checked eq '1'}">checked="checked"</c:if> /><label for="cs-check-radio1">已审核</label></li>
						</ul>
						<ul class=" cs-gh clearfix" style="height:80px;">

						<li class="cs-name cs-sm-w  yuliu"  style="display: none">预留字段1：</li>
						<li class="cs-in-style cs-md-w yuliu" style="display: none"><input type="text" name="param1" readonly="readonly"<c:if test="${!empty regulatoryObject}">value="${regulatoryObject.param1}"</c:if> /></li>
						
						<li class="cs-name cs-sm-w yuliu" style="display: none">预留字段2：</li>
						<li class="cs-in-style cs-md-w yuliu" style="display: none"><input type="text" name="param2" readonly="readonly" <c:if test="${!empty regulatoryObject}">value="${regulatoryObject.param2}"</c:if> /></li>
						
						<li class="cs-name cs-sm-w yuliu" style="display: none">预留字段3：</li>
						<li class="cs-in-style cs-md-w yuliu" style="display: none"><input type="text" name="param3" readonly="readonly" <c:if test="${!empty regulatoryObject}">value="${regulatoryObject.param3}"</c:if> /></li>
					
					</ul>
				</div>
			</div>
		</form>

		<div class="cs-tabtitle clearfix" id="tabtitle" style="margin-top: 10px;">
			<ul>
				<li class="cs-tabhover" data-tabtitleNo="1">证照信息</li>
				<li data-tabtitleNo="2">人员信息</li>
				<!-- <li data-tabtitleNo="3">经营户信息</li> -->
			</ul>
		</div>
		<div class="cs-tabcontent clearfix">
			<div class="cs-content2">
				<div id="dataList1"></div>
			</div>
		</div>
		<div class="cs-tabcontent clearfix cs-hide">
			<div class="cs-content2">
				<div id="dataList2"></div>
			</div>
		</div>
		<!-- <div class="cs-tabcontent clearfix cs-hide">
			<div class="cs-content2">
				<div id="dataList3"></div>
			</div>
		</div> -->
	</div>

	<!-- 弹出窗3 地图坐标 -->
	<div class="cs-map-content">
		<div class="cs-map-top"></div>
		<div class="cs-map-bottom"></div>
	</div>

	<!-- Modal 新增证照-->
	<div class="modal fade intro2" id="licenseModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="static">
		<div class="modal-dialog cs-lg-width">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title">证照信息</h4>
				</div>
				<div class="modal-body cs-lg-height">
					<form id="licenseForm" enctype="multipart/form-data">
						<input type="hidden" name="sourceId" <c:if test="${!empty regulatoryObject}">value="${regulatoryObject.id}"</c:if>> <input type="hidden" name="sourceType" value="0">
						<div class="cs-content">
							<input type="hidden" name="id">
							<table class="cs-add-new">
								<tr>
									<td class="cs-name"><i class="cs-mred">*</i>证件名称：</td>
									<td class="cs-in-style"><input type="text" name="licenseName" /></td>
									<td class="cs-name"><i class="cs-mred">*</i>证件编号：</td>
									<td class="cs-in-style"><input type="text" name="licenseCode" /></td>
								</tr>
								<tr>
									<td class="cs-name"><i class="cs-mred">*</i>证件类型：</td>
									<td class="cs-in-style"><select name="licenseType">
											<option value="0">营业执照</option>
											<option value="1">许可证</option>
											<option value="3">税务登记证</option>
									</select></td>
									<td class="cs-name">注册资金（万）：</td>
									<td class="cs-in-style"><input type="text" name="capital" onkeyup="clearNoNum3(this)" /></td>
								</tr>
								<tr>
									<td class="cs-name">法人名称：</td>
									<td class="cs-in-style"><input type="text" name="legalPerson" /></td>
									<td class="cs-name">法人身份证号：</td>
									<td class="cs-in-style"><input type="text" name="idcard" /></td>
								</tr>
								<tr>
									<td class="cs-name">注册日期：</td>
									<td class="cs-in-style"><input name="licenseRdate" class="cs-time" type="text" onClick="WdatePicker({startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true})" /></td>
									<td class="cs-name">发证日期：</td>
									<td class="cs-in-style"><input name="licenseSdate" class="cs-time" type="text" onClick="WdatePicker({startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true})" /></td>
								</tr>
								<tr>
									<td class="cs-name">有效期至：</td>
									<td class="cs-in-style"><input name="licenseEdate" class="cs-time" type="text" onClick="WdatePicker({startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true})" /></td>
									<td class="cs-name">发证机关：</td>
									<td class="cs-in-style"><input type="text" name="authority" /></td>
								</tr>
								<tr>
									<td class="cs-name">经营范围：</td>
									<td class="cs-in-style"><textarea name="scope"></textarea></td>
									<td class="cs-name">证照图片：</td>
									<td class="cs-in-style"><input type="file" name="filePathImage" datatype="*" nullmsg="请选择图片" /></td>
								</tr>
								<tr>
									<td class="cs-name">备注：</td>
									<td class="cs-in-style"><textarea type="text" name="remark"></textarea></td>
									<td class="cs-name">状态：</td>
									<td class="cs-in-style cs-radio">
										<label for="license-radio0"><input id="license-radio0" type="radio" value="0" name="checked" />
										未审核</label>
										<label for="license-radio1"><input id="license-radio1" type="radio" value="1" name="checked"  checked="checked"/>
										已审核</label>
									</td>
								</tr>
							</table>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<a class="btn btn-success btn-ok" onclick="addLicense()">保存</a>
					<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
				</div>
			</div>
		</div>
	</div>

	<!-- Modal 新增人员-->
	<div class="modal fade intro2" id="personnelModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="static">
		<div class="modal-dialog cs-mid-width">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title">人员信息</h4>
				</div>
				<div class="modal-body cs-mid-height">
					<form id="personnelForm">
						<input type="hidden" name="regId" <c:if test="${!empty regulatoryObject}">value="${regulatoryObject.id}"</c:if>>
						<div class="cs-content">
							<input type="hidden" name="id">
							<table class="cs-add-new">
								<tr>
									<td class="cs-name"><i class="cs-mred">*</i>人员名称：</td>
									<td class="cs-in-style"><input type="text" name="name" /></td>
								</tr>
								<tr>
									<td class="cs-name">职称：</td>
									<td class="cs-in-style"><input type="text" name="jobTitle" /></td>
								</tr>
								<tr>
									<td class="cs-name">身份证：</td>
									<td class="cs-in-style"><input type="text" name="idcard" /></td>
								</tr>
								<tr>
									<td class="cs-name">联系方式：</td>
									<td class="cs-in-style"><input type="text" name="phone" /></td>
								</tr>
								<tr>
									<td class="cs-name">健康证编号：</td>
									<td class="cs-in-style"><input type="text" name="proofCode" /></td>
								</tr>
								<tr>
									<td class="cs-name">健康证发证日期：</td>
									<td class="cs-in-style"><input name="proofSdate" class="cs-time" type="text" onClick="WdatePicker({startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true})" /></td>
								</tr>
								<tr>
									<td class="cs-name">健康证有效期至：</td>
									<td class="cs-in-style"><input name="proofEdate" class="cs-time" type="text" onClick="WdatePicker({startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true})" /></td>
								</tr>
								<tr>
									<td class="cs-name">备注：</td>
									<td class="cs-in-style"><textarea type="text" name="remark"></textarea></td>
								</tr>
							</table>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<a class="btn btn-success btn-ok" onclick="addPersonnel()">保存</a>
					<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
				</div>
			</div>
		</div>
	</div>

	<!-- Modal 新增经营户-->
	<div class="modal fade intro2" id="businessModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="static">
		<div class="modal-dialog cs-lg-width">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title">经营户信息</h4>
				</div>
				<div class="modal-body cs-lg-height">
					<form id="businessForm" enctype="multipart/form-data">
						<input type="hidden" name="regulatoryBusiness.regId" <c:if test="${!empty regulatoryObject}">value="${regulatoryObject.id}"</c:if>>
						<div class="cs-content">
							<input type="hidden" name="regulatoryBusiness.id">
							<table class="cs-add-new">
								<tr>
									<td>基本信息</td>
								</tr>
								<tr>
									<td class="cs-name"><i class="cs-mred">*</i>档口名称：</td>
									<td class="cs-in-style"><input type="text" name="regulatoryBusiness.opeShopName" /></td>
									<td class="cs-name"><i class="cs-mred">*</i>档口编号：</td>
									<td class="cs-in-style"><input type="text" name="regulatoryBusiness.opeShopCode" /></td>
								</tr>
								<tr>
									<td class="cs-name">经营者名称：</td>
									<td class="cs-in-style"><input type="text" name="regulatoryBusiness.opeName" /></td>
									<td class="cs-name">经营者联系方式：</td>
									<td class="cs-in-style"><input type="text" name="regulatoryBusiness.opePhone" /></td>
								</tr>
								<tr>
									<td class="cs-name">经营者身份证：</td>
									<td class="cs-in-style"><input type="text" name="regulatoryBusiness.opeIdcard" /></td>
									<td class="cs-name">信用等级：</td>
									<td class="cs-in-style"><select name="regulatoryBusiness.creditRating">
											<option value="1">A</option>
											<option value="2">B</option>
											<option value="3">C</option>
											<option value="4">D</option>
									</select></td>
								</tr>
								<tr>
									<td class="cs-name">监控级别：</td>
									<td class="cs-in-style"><select name="regulatoryBusiness.monitoringLevel">
											<option value="1">安全</option>
											<option value="2">轻微</option>
											<option value="3">警惕</option>
											<option value="4">严重</option>
									</select></td>
									<td class="cs-name">备注：</td>
									<td class="cs-in-style"><textarea type="text" name="regulatoryBusiness.remark"></textarea></td>
								</tr>
								<tr>
									<td class="cs-name">状态：</td>
									<td class="cs-in-style cs-radio">
										<input id="business-radio0" type="radio" value="0" name="regulatoryBusiness.checked" /><label for="business-radio0">未审核</label>
										<input id="business-radio1" type="radio" value="1" name="regulatoryBusiness.checked" checked="checked" /><label for="business-radio1">已审核</label></td>
								</tr>
								<tr>
									<td>营业执照信息</td>
								</tr>
								<tr>
									<input type="hidden" name="regulatoryLicense.id" />
									<td class="cs-name">法人名称：</td>
									<td class="cs-in-style"><input type="text" name="regulatoryLicense.legalPerson" /></td>
									<td class="cs-name">法人身份证：</td>
									<td class="cs-in-style"><input type="text" name="regulatoryLicense.idcard" /></td>
								</tr>
								<tr>
									<td class="cs-name">营业执照名称：</td>
									<td class="cs-in-style"><input type="text" name="regulatoryLicense.licenseName" /></td>
									<td class="cs-name">注册资金（万）：</td>
									<td class="cs-in-style"><input type="text" name="regulatoryLicense.capital" /></td>
								</tr>
								<tr>
									<td class="cs-name">营业执照编号：</td>
									<td class="cs-in-style"><input type="text" name="regulatoryLicense.licenseCode" /></td>
									<td class="cs-name">营业执照注册日期：</td>
									<td class="cs-in-style"><input type="text" name="regulatoryLicense.licenseRdate" class="cs-time" onClick="WdatePicker({startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true})" /></td>
								</tr>
								<tr>
									<td class="cs-name">营业执照发证日期：</td>
									<td class="cs-in-style"><input type="text" name="regulatoryLicense.licenseSdate" class="cs-time" onClick="WdatePicker({startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true})" /></td>
									<td class="cs-name">营业执照有效期至：</td>
									<td class="cs-in-style"><input type="text" name="regulatoryLicense.licenseEdate" class="cs-time" onClick="WdatePicker({startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true})" /></td>
								</tr>
								<tr>
									<td class="cs-name">经营范围：</td>
									<td class="cs-in-style"><input type="text" name="regulatoryLicense.scope" /></td>
									<td class="cs-name">发证机关：</td>
									<td class="cs-in-style"><input type="text" name="regulatoryLicense.authority" /></td>
								</tr>
								<tr>
									<td class="cs-name">营业执照图片：</td>
									<td class="cs-in-style"><input type="file" name="filePathImage" datatype="*" nullmsg="请选择图片" /></td>
									<td class="cs-name">备注：</td>
									<td class="cs-in-style"><textarea type="text" name="regulatoryLicense.remark"></textarea></td>
								</tr>
							</table>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<a class="btn btn-success btn-ok" onclick="addBusiness()">保存</a>
					<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
				</div>
			</div>
		</div>
	</div>

	<!-- 引用模态框 -->
	<%@include file="/WEB-INF/view/common/confirm.jsp"%>

	<!-- 选择地图定位 -->
	<%@ include file="/WEB-INF/view/common/map/selectMapLocation.jsp"%>

	<!-- JavaScript -->
	<script src="${webRoot}/js/datagridUtil.js"></script>
	<script src="${webRoot}/js/jquery.form.js"></script>
	<script type="text/javascript">
		changeregType();

		$(function() {
			if (Permission.exist("1373-4") || Permission.exist("1498-4")) {
				//审核权限
				$(".audit").show();
			}
			if (Permission.exist("1373-18")) {
				//查看预留字段
				$(".yuliu").show();
			}
			if(Permission.exist("1498-20")){
				$(".taskType").show();
			}
			$("#taskType").val(${regulatoryObject.taskType});
		});

		//验证
		var regFormValidform = $("#regForm").Validform({
			callback : function(data) {
				if (data && data.success) {
					var saveType = $("#savetype").val();
					if("${isNewMenu}"=="N"){
						if (saveType == 1) {//保存并新增，不重置已选择企业类型和所属机构
							/*self.location = '${webRoot}/ledger/regulatoryObject/goAddRegulatoryObject.do?regTypeId='+ $("select[name='regType']").val();*/
							$("#Validform_msg").hide()
							$(".resetClass").val("");
						} else {
							self.location = '${webRoot}/ledger/regulatoryObject/list';
						}

					}else{//从监管对象新菜单进入新增页面
                        parent.dguQuery();
						if (saveType == 1) {//保存并新增，不重置已选择企业类型和所属机构
							<%--parent.showMbIframe("${webRoot}/ledger/regulatoryObject/goAddRegulatoryObject?isNewMenu=Y");--%>
							$("#Validform_msg").hide()
							$(".resetClass").val("");
						} else {
							parent.closeMbIframe();
						}
					}


				} else {
					$("#confirm-warnning").modal("toggle");
				}
			}
		});

		//保存
		function save() {
			var opt = $("#regType").find("option:selected").text();
			if(opt=="经营单位"){
			var managementType=$("#managementType").find("option:selected").val();
				if(managementType==null||managementType==""){
					$.Showmsg("市场类型不能为空!");
				return;
				}
			}
			regFormValidform.ajaxPost();
		}
		function saveself() {
			$("#savetype").val("1");
			save();
		}

		//组织机构树
		$('#myDeaprtTree').tree({
			checkbox : false,
			url : "${webRoot}/detect/depart/getDepartTree.do",
			animate : true,
			onClick : function(node) {
				$('#regForm').find("input[name='departId']").val(node.id);
				$('#regForm').find("input[name='departName']").val(node.text);
			}
		});

		//打开地图
		function openMap1() {
			setMapLocation($("input[name='placeX']").val(), $("input[name='placeY']").val());
		}

		//保存坐标
		function getCoordinate(coordinate, title, address) {
			var jw = coordinate.split(",");
			$("input[name='placeXY']").val(coordinate);
			$("input[name='placeX']").val(jw[0]);
			$("input[name='placeY']").val(jw[1]);

			if (title && !$("input[name='regName']").val()) {
				$("input[name='regName']").val(title);
			}
			if (address) {
				$("input[name='regAddress']").val(address);
			}
		}

		/*************************** 证照信息 **********************************/
		var regulatoryId = 0; //监管对象ID
		if ("${regulatoryObject}" && "${regulatoryObject.id}") {
			regulatoryId = "${regulatoryObject.id}";
		}
		var op1 = {
			tableId : "dataList1", //列表ID
			tableAction : '${webRoot}' + "/ledger/regulatoryLicense/datagrid.do", //加载数据地址
			parameter : [ //列表拼接参数
			{
				columnCode : "licenseName",
				columnName : "证件名称",
				query : 1
			}, {
				columnCode : "licenseType",
				columnName : "证件类型",
				query : 1,
				customVal : {
					"0" : "营业执照",
					"1" : "许可证",
					"2" : "统一社会信用代码",
					"3" : "税务登记证"
				}
			}, {
				columnCode : "licenseCode",
				columnName : "证件编号"
			}, {
				columnCode : "legalPerson",
				columnName : "法人名称"
			}, {
				columnCode : "licenseEdate",
				columnName : "有效期至",
				queryType : 1
			} ],
			defaultCondition : [ {
				queryCode : "regulatoryObject.id",
				queryVal : regulatoryId
			} ],
			funBtns : [
					{
						style : {
							functionIcon : "icon iconfont icon-xiugai",
							operationName : "编辑"
						},
						action : function(id) {
							$.ajax({
								type : "POST",
								url : '${webRoot}' + "/ledger/regulatoryLicense/queryById.do",
								data : {
									"id" : id
								},
								dataType : "json",
								success : function(data) {
									if (data && data.success && data.obj) {
										$("#licenseModal").modal("toggle");
										$("#licenseModal input[name='id']").val(data.obj.id);
										$("#licenseModal input[name='licenseName']").val(data.obj.licenseName);
										$("#licenseModal input[name='licenseCode']").val(data.obj.licenseCode);
										$("#licenseModal select[name='licenseType']").val(data.obj.licenseType);
										$("#licenseModal input[name='capital']").val(data.obj.capital);
										$("#licenseModal input[name='legalPerson']").val(data.obj.legalPerson);
										$("#licenseModal input[name='idcard']").val(data.obj.idcard);
										if (data.obj.licenseRdate) {
											$("#licenseModal input[name='licenseRdate']").val(
													new Date(data.obj.licenseRdate).format("yyyy-MM-dd"));
										}
										if (data.obj.licenseEdate) {
											$("#licenseModal input[name='licenseEdate']").val(
													new Date(data.obj.licenseEdate).format("yyyy-MM-dd"));
										}
										if (data.obj.licenseSdate) {
											$("#licenseModal input[name='licenseSdate']").val(
													new Date(data.obj.licenseSdate).format("yyyy-MM-dd"));
										}
										$("#licenseModal input[name='authority']").val(data.obj.authority);
										$("#licenseModal textarea[name='scope']").val(data.obj.scope);
										$("#licenseModal textarea[name='remark']").val(data.obj.remark);
										if (data.obj.checked == 0) {
											$("#license-radio0").prop("checked", "checked");
										} else if (data.obj.checked == 1) {
											$("#license-radio1").prop("checked", "checked");
										}
									} else {
										$('#confirm-warnning').modal('toggle');
									}
								}
							});
						}
					}, {
						style : {
							functionIcon : "icon iconfont icon-shanchu text-del",
							operationName : "删除"
						},
						action : function(id) {
							$.ajax({
								type : "POST",
								url : '${webRoot}' + "/regulatory/regulatoryLicense/delete.do",
								data : {
									"ids" : id
								},
								dataType : "json",
								success : function(data) {
									if (data && data.success) {
										//删除成功后刷新列表
										datagridUtil.query();
									} else {
										//删除失败
									}
								}
							});
						}
					} ], //操作按钮 
			bottomBtns : [ {
				style : {
					functionIcon : "icon iconfont icon-zengjia",
					operationName : "新增"
				},
				action : function(ids) {
					if (!regulatoryId) {
						alert("请先保存基本信息");
						return;
					}
					$("#licenseModal").modal("toggle");
				}
			} ]
		//底部按钮
		};

		datagridUtil.initOption(op1);
		datagridUtil.query();

		//清空输入框
		$('#licenseModal').on('hidden.bs.modal', function() {
			$("#licenseModal input[type!='hidden']").val("");
			$("#licenseModal input[name='id']").val("");
			$("#licenseModal select[name='licenseType']").val("0");
			$("#licenseModal textarea").val("");
			$("#license-radio0").prop("checked", "checked");

			var file = $("#licenseModal input[name='filePathImage']");
			file.after(file.clone().val(""));
			file.remove();
		});

		function addLicense() {
			$("#licenseForm").ajaxSubmit({
				type : 'post',
				url : '${webRoot}' + "/regulatory/regulatoryLicense/save.do",
				success : function(data) {
					$("#licenseModal").modal("hide");
					if (data && data.success) {
						datagridUtil.query();
					} else {
						$('#confirm-warnning').modal('toggle');
					}
				}
			});
		}

		/*************************** 人员信息 **********************************/
		var op2 = {
			tableId : "dataList2", //列表ID
			tableAction : '${webRoot}' + "/ledger/regulatoryPersonnel/datagrid.do", //加载数据地址
			parameter : [ //列表拼接参数
			{
				columnCode : "name",
				columnName : "人员名称",
			}, {
				columnCode : "jobTitle",
				columnName : "职称",
			}, {
				columnCode : "proofCode",
				columnName : "健康证编号"
			}, {
				columnCode : "proofEdate",
				columnName : "有效期至",
				queryType : 1
			} ],
			defaultCondition : [ {
				queryCode : "regulatoryObject.id",
				queryVal : regulatoryId
			} ],
			funBtns : [
					{
						style : {
							functionIcon : "icon iconfont icon-xiugai",
							operationName : "编辑"
						},
						action : function(id) {
							$.ajax({
								type : "POST",
								url : '${webRoot}' + "/ledger/regulatoryPersonnel/queryById.do",
								data : {
									"id" : id
								},
								dataType : "json",
								success : function(data) {
									if (data && data.success && data.obj) {
										$("#personnelModal").modal("toggle");
										$("#personnelModal input[name='id']").val(data.obj.id);
										$("#personnelModal input[name='name']").val(data.obj.name);
										$("#personnelModal input[name='jobTitle']").val(data.obj.jobTitle);
										$("#personnelModal input[name='idcard']").val(data.obj.idcard);
										$("#personnelModal input[name='phone']").val(data.obj.phone);
										$("#personnelModal input[name='proofCode']").val(data.obj.proofCode);
										if (data.obj.proofSdate) {
											$("#personnelModal input[name='proofSdate']").val(
													new Date(data.obj.proofSdate).format("yyyy-MM-dd"));
										}
										if (data.obj.proofEdate) {
											$("#personnelModal input[name='proofEdate']").val(
													new Date(data.obj.proofEdate).format("yyyy-MM-dd"));
										}
										$("#personnelModal textarea[name='remark']").val(data.obj.remark);
									} else {
										$('#confirm-warnning').modal('toggle');
									}
								}
							});
						}
					}, {
						style : {
							functionIcon : "icon iconfont icon-shanchu text-del",
							operationName : "删除"
						},
						action : function(id) {
							$.ajax({
								type : "POST",
								url : '${webRoot}' + "/ledger/regulatoryPersonnel/delete.do",
								data : {
									"ids" : id
								},
								dataType : "json",
								success : function(data) {
									if (data && data.success) {
										//刷新列表
										datagridUtil.query();
									} else {
										//删除失败
									}
								}
							});
						}
					} ], //操作按钮 
			bottomBtns : [ {
				style : {
					functionIcon : "icon iconfont icon-zengjia",
					operationName : "新增"
				},
				action : function(ids) {
					if (!regulatoryId) {
						alert("请先保存基本信息");
						return;
					}
					$("#personnelModal").modal("toggle");
				}
			} ]
		//底部按钮
		};

		//清空输入框
		$('#personnelModal').on('hidden.bs.modal', function() {
			$("#personnelModal input[type!='hidden']").val("");
			$("#personnelModal input[name='id']").val("");
			$("#personnelModal textarea").val("");
		});

		function addPersonnel() {
			$("#personnelForm").ajaxSubmit({
				type : 'post',
				url : '${webRoot}' + "/ledger/regulatoryPersonnel/save.do",
				success : function(data) {
					$("#personnelModal").modal("hide");
					if (data && data.success) {
						datagridUtil.query();
					} else {
						$('#confirm-warnning').modal('toggle');
					}
				}
			});
		}

		function changeregType() {
			var opt = $("#regType").find("option:selected").text();
			if(opt=="经营单位" || opt=="流通-农批市场"){
				$("li.mType").show();
				//document.getElementById("managementType").options.selectedIndex = 1;
			}else{
				$("li.mType").hide();
				document.getElementById("managementType").options.selectedIndex = 0;
				// $("#managementType").selectpicker('refresh');
			}
			
		}
		
		
		/*************************** 经营户信息 **********************************/
		/* var op3 = {
			tableId: "dataList3",	//列表ID
			tableAction: '${webRoot}'+"/regulatory/business/datagrid.do",	//加载数据地址
			parameter: [		//列表拼接参数
				{
					columnCode: "opeShopName",
					columnName: "经营户名称",
				},
				{
					columnCode: "opeShopCode",
					columnName: "档口号",
				},
				{
					columnCode: "opeName",
					columnName: "经营者"
				},
				{
					columnCode: "creditRating",
					columnName: "信用等级",
					customVal: {"1":"A","2":"B","3":"C","4":"D"}
				},
				{
					columnCode: "monitoringLevel",
					columnName: "监控级别",
					customVal: {"1":"安全","2":"轻微","3":"警惕","4":"严重"}
				},
				{
					columnCode: "checked",
					columnName: "状态",
					customVal: {"0":"未审核","1":"已审核"}
				}
			],
			defaultCondition: [
				{
			    	queryCode: "regulatoryObject.id",
			    	queryVal: regulatoryId
			    }
			],
			funBtns: [
				    	{
				    		style: {
				    			functionIcon: "icon iconfont icon-xiugai",
				    			operationName: "编辑"
				    		}, 
				    		action: function(id){
				    			$.ajax({
							        type: "POST",
							        url: '${webRoot}'+"/regulatory/business/queryById.do",
							        data: {"id":id},
							        dataType: "json",
							        success: function(data){
							        	if(data && data.success && data.obj){
							    			$("#businessModal").modal("toggle");
							    			if(data.obj.regulatoryBusiness){
								    			$("#businessModal input[name='regulatoryBusiness.id']").val(data.obj.regulatoryBusiness.id);
							    				$("#businessModal input[name='regulatoryBusiness.opeShopName']").val(data.obj.regulatoryBusiness.opeShopName);
							    				$("#businessModal input[name='regulatoryBusiness.opeShopCode']").val(data.obj.regulatoryBusiness.opeShopCode);
							    				$("#businessModal input[name='regulatoryBusiness.opeName']").val(data.obj.regulatoryBusiness.opeName);
							    				$("#businessModal input[name='regulatoryBusiness.opePhone']").val(data.obj.regulatoryBusiness.opePhone);
							    				$("#businessModal input[name='regulatoryBusiness.opeIdcard']").val(data.obj.regulatoryBusiness.opeIdcard);
							    				$("#businessModal input[name='regulatoryBusiness.creditRating']").val(data.obj.regulatoryBusiness.creditRating);
							    				$("#businessModal input[name='regulatoryBusiness.monitoringLevel']").val(data.obj.regulatoryBusiness.monitoringLevel);
							    				$("#businessModal textarea[name='regulatoryBusiness.remark']").val(data.obj.regulatoryBusiness.remark);
							    				if(data.obj.regulatoryBusiness.checked == 0){
								    				$("#business-radio0").prop("checked", "checked");
								    			}else if(data.obj.regulatoryBusiness.checked == 1){
									    			$("#business-radio1").prop("checked", "checked");
								    			}
							    			}
							    			if(data.obj.regulatoryLicense){
							    				$("#businessModal input[name='regulatoryLicense.id']").val(data.obj.regulatoryLicense.id);
							    				$("#businessModal input[name='regulatoryLicense.legalPerson']").val(data.obj.regulatoryLicense.legalPerson);
							    				$("#businessModal input[name='regulatoryLicense.idcard']").val(data.obj.regulatoryLicense.idcard);
							    				$("#businessModal input[name='regulatoryLicense.licenseName']").val(data.obj.regulatoryLicense.licenseName);
							    				$("#businessModal input[name='regulatoryLicense.capital']").val(data.obj.regulatoryLicense.capital);
							    				$("#businessModal input[name='regulatoryLicense.licenseCode']").val(data.obj.regulatoryLicense.licenseCode);
							    				if(data.obj.regulatoryLicense.licenseRdate){
									    			$("#businessModal input[name='regulatoryLicense.licenseRdate']").val(new Date(data.obj.regulatoryLicense.licenseRdate).format("yyyy-MM-dd"));
								    			}
							    				if(data.obj.regulatoryLicense.licenseSdate){
									    			$("#businessModal input[name='regulatoryLicense.licenseSdate']").val(new Date(data.obj.regulatoryLicense.licenseSdate).format("yyyy-MM-dd"));
								    			}
							    				if(data.obj.regulatoryLicense.licenseEdate){
									    			$("#businessModal input[name='regulatoryLicense.licenseEdate']").val(new Date(data.obj.regulatoryLicense.licenseEdate).format("yyyy-MM-dd"));
								    			}
							    				$("#businessModal input[name='regulatoryLicense.scope']").val(data.obj.regulatoryLicense.scope);
							    				$("#businessModal input[name='regulatoryLicense.authority']").val(data.obj.regulatoryLicense.authority);
							    				$("#businessModal textarea[name='regulatoryLicense.remark']").val(data.obj.regulatoryLicense.remark);
							    			}
							        	}else{
							        		$('#confirm-warnning').modal('toggle');
							        	}
									}
							   });
				    		}
				    	},
				    	{
				    		style: {
				    			functionIcon: "icon iconfont icon-shanchu text-del",
				    			operationName: "删除"
				    		}, 
				    		action: function(id){
				    			$.ajax({
				    		        type: "POST",
				    		        url: '${webRoot}'+"/regulatory/business/delete.do",
				    		        data: {"ids":id},
				    		        dataType: "json",
				    		        success: function(data){
				    		        	if(data && data.success){
				    		        		//刷新列表
				    		        		datagridUtil.query();
				    		        	}else{
				    		        		//删除失败
				    		        	}
				    				}
				    		    });
				    		}
				    	}
				    ],	//操作按钮 
		    bottomBtns: [
				{
					style: {
						functionIcon: "icon iconfont icon-zengjia",
		     	 		operationName: "新增"
		     	 	}, 
		     	 	action: function(ids){
		     	 		if(!regulatoryId){
		    				alert("请先保存基本信息");
		    				return;
		    			}
						$("#businessModal").modal("toggle");
					}
				}
			]	//底部按钮
		};
		
		//清空输入框
		$('#businessModal').on('hidden.bs.modal', function () {
			$("#businessModal input[type!='hidden']").val("");
			$("#businessModal input[name='regulatoryBusiness.id']").val("");
			$("#businessModal input[name='regulatoryLicense.id']").val("");
			$("#businessModal textarea").val("");
			$("#business-radio0").prop("checked", "checked");
			
			var file = $("#businessModal input[name='filePathImage']"); 
			file.after(file.clone().val("")); 
			file.remove(); 
		});
		
		function addBusiness(){
			$("#businessForm").ajaxSubmit({
				type:'post',
				url: '${webRoot}'+"/regulatory/business/save.do",
				success: function(data){
					console.log(data.success);
					$("#businessModal").modal("hide");
					if(data && data.success){
						datagridUtil.query();
					}else{
						$('#confirm-warnning').modal('toggle');
					}
				}
			});
		} */

		//切换列表
		$(".cs-tabtitle li").click(function() {
			var tabtitleNo = $(this).attr("data-tabtitleNo");
			if (tabtitleNo == "1") {
				datagridUtil.initOption(op1);
			} else if (tabtitleNo == "2") {
				datagridUtil.initOption(op2);
			}
			/* else if(tabtitleNo == "3"){
				datagridUtil.initOption(op3);
			} */
			datagridUtil.query();
		});

		//展示经营户列表
		/* function showBusiness(){
			var regType = $("#regForm select[name='regType']").val();
			if(regType = '0'){
				tabtitle
				$("#tabtitle")
			}else{
				
			}
		} */
	</script>
</body>
</html>
