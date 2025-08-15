<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/common/resource.jsp"%>

<!DOCTYPE html>
<head>
	<title>快检服务云平台</title>
</head>

<body>
	<div class="cs-maintab">
		<div class="cs-col-lg clearfix">
			<!-- 面包屑导航栏  开始-->
			<ol class="cs-breadcrumb">
				<li class="cs-fl"><img src="${webRoot}/img/set.png" alt=""><a href="javascript:">冷链单位</a></li>
				<c:if test="${!empty regulatoryType}">
					<li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
					<li class="cs-fl">${regulatoryType.regType}</li>
					<li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
					<li class="cs-b-active cs-fl">${regulatoryType.regType}详情</li>
				</c:if>
			</ol>
			<!-- 面包屑导航栏  结束-->
			<div class="cs-search-box cs-fr">
				<form>
					<div class=" cs-fr cs-ac ">
						<!--<a class="cs-menu-btn" href="javascript:" onclick="saveself();"><i class="icon iconfont icon-save"></i>保存并新增</a>-->

						<a class="cs-menu-btn" href="javascript:" onclick="save();"><i class="icon iconfont icon-save"></i>保存</a>
						<c:if test="${regTypeCode == 'coldUnits'}">
						<a class="cs-menu-btn" href="javascript:" onclick="self.location.href='${webRoot}/cold/unit/list'"><i class="icon iconfont icon-fanhui"></i>返回</a>
						</c:if>
<%--						 <a class="cs-menu-btn" href="javascript:;" onclick="self.history.back();"><i class="icon iconfont icon-fanhui"></i>返回</a>--%>
						<c:if test="${regTypeCode == null}">
						<a href="javascript:" onclick="parent.closeMbIframe(1);" class="cs-menu-btn cs-fun-btn"><i class="icon iconfont icon-fanhui"></i>返回</a>
						</c:if>
					</div>
				</form>
			</div>
		</div>
			<input type="hidden" name="savetype" id="savetype" value="0">
			<form id="regForm" action="${webRoot}/cold/unit/save.do" method="post">
			<input type="hidden" name="id" <c:if test="${!empty regulatoryObject}">value="${regulatoryObject.id}"</c:if>>
			<div class="cs-base-detail">
				<div class="cs-content2">
					<h3>基本信息</h3>
					<table class="cs-add-new">
						<tr>
							<td class="cs-name"><i class="cs-mred">*</i>单位名称：</td>
							<td class="cs-in-style">
								
							<div class="cs-all-ps">
									<div class="cs-input-box">
										<input type="text" name="regName" id="regName"
									<c:if test="${!empty regulatoryObject}">value="${regulatoryObject.regName}"</c:if>/>
										<div class="cs-map" data-toggle="modal" data-target="#positionModal" onclick="openMap1();"><span class="cs-icon-span"><i title="定位" class="icon iconfont icon-local"></i></span></div>
									</div>
								</div>
							</td>
							<td class="cs-name"><i class="cs-mred">*</i>单位类型：</td>
							<td class="cs-in-style">
								<select name="regType" datatype="*" nullmsg="请选择单位类型" errormsg="请选择单位类型">
									<option value="0">企业</option>
									<option value="1">个人</option>
								</select>
							</td>
							<td class="cs-name"><i class="cs-mred">*</i>所属机构：</td>
					      	<td class="cs-in-style">
					      	 	<div class="cs-all-ps">
				                    <div class="cs-input-box">
				                      <input type="text" name="departName" datatype="*" nullmsg="请选择所属机构" errormsg="请选择所属机构" autocomplete="off"
				                      	<c:if test="${!empty regulatoryObject}">value="${regulatoryObject.departName}"</c:if>>
				                      <input type="hidden" name="departId" <c:if test="${!empty regulatoryObject}">value="${regulatoryObject.departId}"</c:if>>
				                      <div class="cs-down-arrow"></div>
				                    </div>
				                    <div class="cs-check-down cs-hide" style="display: none;">
				                      <ul id="myDeaprtTree" class="easyui-tree"></ul>
				                    </div>
			                    </div>
					      	</td>
						</tr>

						<tr>
							<td class="cs-name">经度纬度：</td>
							<td class="cs-in-style">
								<div class="cs-all-ps">
									<div class="cs-input-box">
										<input type="text" name="placeXY" <c:if test="${!empty regulatoryObject}">value="${regulatoryObject.placeX},${regulatoryObject.placeY}"</c:if> readonly="readonly">
										<input type="hidden" name="placeX" <c:if test="${!empty regulatoryObject}">value="${regulatoryObject.placeX}"</c:if>>
										<input type="hidden" name="placeY" <c:if test="${!empty regulatoryObject}">value="${regulatoryObject.placeY}"</c:if>>
									</div>
								</div>
							</td>
							<td class="cs-name">详细地址：</td>
							<td class="cs-in-style">
								<input type="text" name="regAddress"  <c:if test="${!empty regulatoryObject}">value="${regulatoryObject.regAddress}"</c:if>/>
							</td>

							<td class="cs-name">统一社会信用代码：</td>
							<td class="cs-in-style">
								<input type="text" name="creditCode" <c:if test="${!empty regulatoryObject}">value="${regulatoryObject.creditCode}"</c:if>/>
							</td>
						</tr>

						<tr>
							<td class="cs-name">企业名称：</td>
							<td class="cs-in-style">
								<input type="text" name="companyName" <c:if test="${!empty regulatoryObject}">value="${regulatoryObject.companyName}"</c:if>/>
							</td>
							<td class="cs-name">法人姓名：</td>
							<td class="cs-in-style">
								<input type="text" name="legalPerson" <c:if test="${!empty regulatoryObject}">value="${regulatoryObject.legalPerson}"</c:if>/>
							</td>
							<td class="cs-name">法人联系方式：</td>
							<td class="cs-in-style">
								<input type="text" name="legalPhone" <c:if test="${!empty regulatoryObject}">value="${regulatoryObject.legalPhone}"</c:if>/>
							</td>
						</tr>




						<tr>
							<td class="cs-name">联系人名称：</td>
							<td class="cs-in-style">
								<input type="text" name="linkUser" <c:if test="${!empty regulatoryObject}">value="${regulatoryObject.linkUser}"</c:if>/>
							</td>
							<td class="cs-name">联系人电话：</td>
							<td class="cs-in-style">
								<input type="text" name="linkPhone" <c:if test="${!empty regulatoryObject}">value="${regulatoryObject.linkPhone}"</c:if>/>
							</td>
							<td class="cs-name">联系人身份证：</td>
							<td class="cs-in-style">
								<input type="text" name="linkIdcard" <c:if test="${!empty regulatoryObject}">value="${regulatoryObject.linkIdcard}"</c:if>/>
							</td>
						</tr>


						<tr>

							<td class="cs-name">备注：</td>
							<td class="cs-in-style">
								<input type="text" name="remark"  <c:if test="${!empty regulatoryObject}">value="${regulatoryObject.remark}"</c:if>/>
							</td>

							<td class="cs-name audit" style="display:none;">状态：</td>
							<td class="cs-in-style cs-radio audit" style="display:none;">
								<input id="cs-check-radio0" type="radio" value="0" name="checked" <c:if test="${!empty regulatoryObject && regulatoryObject.checked eq '0'}">checked="checked"</c:if>/><label for="cs-check-radio0">未审核</label>
								<input id="cs-check-radio1" type="radio" value="1" name="checked" <c:if test="${empty regulatoryObject || regulatoryObject.checked eq '1'}">checked="checked"</c:if>/><label for="cs-check-radio1">已审核</label>
							</td>
						</tr>

						<!-- 可选的隐藏字段（预留字段）
						<td class="cs-name">所属区域 ID：</td>
							<td class="cs-in-style">
								<input type="text" name="regionId" <c:if test="${!empty regulatoryObject}">value="${regulatoryObject.regionId}"</c:if>/>
						</td>
						<tr>
						<input type="hidden" name="param1" <c:if test="${!empty regulatoryObject}">value="${regulatoryObject.param1}"</c:if>/>
						<input type="hidden" name="param2" <c:if test="${!empty regulatoryObject}">value="${regulatoryObject.param2}"</c:if>/>
						<input type="hidden" name="param3" <c:if test="${!empty regulatoryObject}">value="${regulatoryObject.param3}"</c:if>/>
						<input type="hidden" name="filePath" <c:if test="${!empty regulatoryObject}">value="${regulatoryObject.filePath}"</c:if>/>
						<input type="hidden" name="qrcode" <c:if test="${!empty regulatoryObject}">value="${regulatoryObject.qrcode}"</c:if>/>
						</tr>
 						-->

					</table>
				</div>
			</div>
		</form>

		<div class="cs-tabtitle clearfix" id="tabtitle">
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
	<div class="modal fade intro2" id="licenseModal" tabindex="-1"
		role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="static">
		<div class="modal-dialog cs-lg-width">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title">证照信息</h4>
				</div>
				<div class="modal-body cs-lg-height">
					<form id="licenseForm" enctype="multipart/form-data">
						<input type="hidden" name="sourceId" <c:if test="${!empty regulatoryObject}">value="${regulatoryObject.id}"</c:if>>
						<input type="hidden" name="sourceType" value="0">
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
					         <td class="cs-in-style">
					         	<select name="licenseType">
					         		<option value="0">营业执照</option>
					         		<option value="1">许可证</option>
					         	</select>
					         </td>
					      	 <td class="cs-name">注册资金（万）：</td>
					         <td class="cs-in-style"><input type="text" name="capital" /></td>
					      </tr>
					      <tr>
					      	 <td class="cs-name">法人名称：</td>
					         <td class="cs-in-style"><input type="text" name="legalPerson" /></td>
					         <td class="cs-name">法人身份证号：</td>
					         <td class="cs-in-style"><input type="text" name="idcard" /></td>
					      </tr>
					      <tr>
					    	<td class="cs-name">注册日期：</td>
							<td class="cs-in-style">
								<input name="licenseRdate" class="cs-time" type="text" 
									onClick="WdatePicker({startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true})"/>
							</td>
							<td class="cs-name">发证日期：</td>
							<td class="cs-in-style">
								<input name="licenseSdate" class="cs-time" type="text" 
									onClick="WdatePicker({startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true})"/>
							</td>
					      </tr>
					      <tr>
					    	<td class="cs-name">有效期至：</td>
							<td class="cs-in-style">
								<input name="licenseEdate" class="cs-time" type="text" 
									onClick="WdatePicker({startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true})"/>
							</td>
							<td class="cs-name">发证机关：</td>
					        <td class="cs-in-style"><input type="text" name="authority" /></td>
					      </tr>
					      <tr>
					      	<td class="cs-name">经营范围：</td>
					        <td class="cs-in-style"><textarea name="scope"></textarea></td>
					        <td class="cs-name">证照图片：</td>
					        <td class="cs-in-style">
					        	<input type="file" name="filePathImage" datatype="*" nullmsg="请选择图片" />
					        </td>
					      </tr>
					      <tr>
					        <td class="cs-name">备注：</td>
					        <td class="cs-in-style"><textarea type="text" name="remark"></textarea></td>
					      	<td class="cs-name">状态：</td>
							<td class="cs-in-style cs-radio">
								<input id="license-radio0" type="radio" value="0" name="checked" /><label for="license-radio0">未审核</label>
								<input id="license-radio1" type="radio" value="1" name="checked" checked="checked"/><label for="license-radio1">已审核</label>
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
	<div class="modal fade intro2" id="personnelModal" tabindex="-1"
		role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="static">
		<div class="modal-dialog cs-mid-width">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
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
							<td class="cs-in-style">
								<input name="proofSdate" class="cs-time" type="text" 
									onClick="WdatePicker({startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true})"/>
							</td>
					      </tr>
					      <tr>
					      	<td class="cs-name">健康证有效期至：</td>
							<td class="cs-in-style">
								<input name="proofEdate" class="cs-time" type="text" 
									onClick="WdatePicker({startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true})"/>
							</td>
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
	<div class="modal fade intro2" id="businessModal" tabindex="-1"
		role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="static">
		<div class="modal-dialog cs-lg-width">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
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
					         <td class="cs-in-style">
					         	<select name="regulatoryBusiness.creditRating">
					         		<option value="1">A</option>
					         		<option value="2">B</option>
					         		<option value="3">C</option>
					         		<option value="4">D</option>
					         	</select>
					         </td>
					      </tr>
					      <tr>
					      	 <td class="cs-name">监控级别：</td>
					         <td class="cs-in-style">
					         	<select name="regulatoryBusiness.monitoringLevel">
					              <option value="1">安全</option>
					              <option value="2">轻微</option>
					              <option value="3">警惕</option>
					              <option value="4">严重</option>
					            </select>
					         </td>
					         <td class="cs-name">备注：</td>
					         <td class="cs-in-style"><textarea type="text" name="regulatoryBusiness.remark"></textarea></td>
					      </tr>
					      <tr>
					      	 <td class="cs-name">状态：</td>
							 <td class="cs-in-style cs-radio">
								<input id="business-radio0" type="radio" value="0" name="regulatoryBusiness.checked" /><label for="business-radio0">未审核</label>
								<input id="business-radio1" type="radio" value="1" name="regulatoryBusiness.checked" checked="checked"/><label for="business-radio1">已审核</label>
							 </td>
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
					         <td class="cs-in-style"><input type="text" name="regulatoryLicense.licenseRdate" class="cs-time" 
									onClick="WdatePicker({startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true})"/></td>
					      </tr>
					      <tr>
					         <td class="cs-name">营业执照发证日期：</td>
					         <td class="cs-in-style"><input type="text" name="regulatoryLicense.licenseSdate" class="cs-time" 
									onClick="WdatePicker({startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true})"/></td>
					         <td class="cs-name">营业执照有效期至：</td>
					         <td class="cs-in-style"><input type="text" name="regulatoryLicense.licenseEdate" class="cs-time" 
									onClick="WdatePicker({startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true})"/></td>
					      </tr>
					      <tr>
					         <td class="cs-name">经营范围：</td>
					         <td class="cs-in-style"><input type="text" name="regulatoryLicense.scope" /></td>
					         <td class="cs-name">发证机关：</td>
					         <td class="cs-in-style"><input type="text" name="regulatoryLicense.authority" /></td>
					      </tr>
					      <tr>
					      	 <td class="cs-name">营业执照图片：</td>
					         <td class="cs-in-style">
					        	<input type="file" name="filePathImage" datatype="*" nullmsg="请选择图片" />
					         </td>
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
    <%@ include file="/WEB-INF/view/common/map/selectMapLocation.jsp" %>

	<!-- JavaScript -->
	<script src="${webRoot}/js/datagridUtil.js"></script>
	<script src="${webRoot}/js/jquery.form.js"></script>
	<script type="text/javascript">
	$(function(){
		for (var i = 0; i < childBtnMenu.length; i++) {
	 		if (childBtnMenu[i].operationCode == "331-8" || childBtnMenu[i].operationCode == "332-4" || 
	 				childBtnMenu[i].operationCode == "333-4" || childBtnMenu[i].operationCode == "1315-4" || 
	 				childBtnMenu[i].operationCode == "1352-4" || childBtnMenu[i].operationCode == "1353-4" || 
	 				childBtnMenu[i].operationCode == "1354-4") {
	 			//审核权限
	 			$(".audit").show();
	 		}
	 	}
	});
	
	//验证
	var regFormValidform = $("#regForm").Validform({
		callback:function(data){
			$.Hidemsg();
			if(data && data.success){
				//$("#confirm-warnning").modal("toggle");
				var saveType=	$("#savetype").val();
				if(saveType==1){
					//单位类型表不再使用
					//self.location = '${webRoot}/cold/unit/goAddRegulatoryObject.do?regTypeId='+$("select[name='regType']").val();
					self.location = '${webRoot}/cold/unit/list';
				}else{
					//<%--self.location = '${webRoot}/cold/unit/goAddRegulatoryObject.do?id='+data.obj.id+'&regTypeId='+$("select[name='regType']").val();--%>
					self.location = '${webRoot}/cold/unit/goAddRegulatoryObject.do?regTypeCode=coldUnits&id='+data.obj.id;
				}
			
			}else{
				$("#waringMsg .tips").text(data.msg);
				$("#confirm-warnning").modal("toggle");
			}
		}
	});
	//验证
	
	
	//保存
	function save(){
		regFormValidform.ajaxPost();
	}
	function saveself(){
	$("#savetype").val("1");
		regFormValidform.ajaxPost();
	}
	
	/* var pid = '';//当前用户组织机构ID
	if ('${sessionScope.org}') {
		pid = '${sessionScope.org.departPid}';
	} */
	//组织机构树
	$('#myDeaprtTree').tree({
		checkbox : false,
		//url : '${webRoot}' + "/detect/depart/getDepartTree.do?pid=" + pid,
		url : "${webRoot}/detect/depart/getDepartTree.do",
		animate : true,
		onClick : function(node) {
			$('#regForm').find("input[name='departId']").val(node.id);
			$('#regForm').find("input[name='departName']").val(node.text);

			$(this).closest('.cs-check-down').hide();
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
		//地图选择页面返回的address为无效值
		//if (address) {
			//$("input[name='regAddress']").val(address);
		//}

		// var pt = new BMap.Point(jw[0], jw[1]);
		// var geoc = new BMap.Geocoder();
		//
		// //逆地址解析
		// geoc.getLocation(pt, function(rs) {
		// 	var addComp = rs.addressComponents;
		// 	$("input[name='regName']").val(rs.surroundingPois[0].title);
		// 	$("input[name='regAddress']").val(
		// 			addComp.province + addComp.city + addComp.district + addComp.street + addComp.streetNumber);
		// });
	}
	
	/*************************** 证照信息 **********************************/
		var regulatoryId = "";	//监管对象ID
		if("${regulatoryObject}" && "${regulatoryObject.id}"){
			regulatoryId = "${regulatoryObject.id}";
		}
		var op1 = {
		tableId: "dataList1",	//列表ID
		tableAction: '${webRoot}'+"/regulatory/regulatoryLicense/datagrid.do?",	//加载数据地址
		<%--tableAction: '${webRoot}'+"/regulatory/regulatoryLicense/queryById.do?ids=null",--%>

		parameter: [		//列表拼接参数
			{
				columnCode: "licenseName",
				columnName: "证件名称",
				query: 1
			},
			{
				columnCode: "licenseType",
				columnName: "证件类型",
				query: 1,
				customVal: {"0":"营业执照","1":"许可证"}
			},
			{
				columnCode: "licenseCode",
				columnName: "证件编号"
			},
			{
				columnCode: "legalPerson",
				columnName: "法人名称"
			},
			{
				columnCode: "licenseEdate",
				columnName: "有效期至",
				queryType: 1
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
				        url: '${webRoot}'+"/regulatory/regulatoryLicense/queryById.do",
				        data: {"id":id},
				        dataType: "json",
				        success: function(data){
				        	if(data && data.success && data.obj){
				    			$("#licenseModal").modal("toggle");
				    			$("#licenseModal input[name='id']").val(data.obj.id);
				    			$("#licenseModal input[name='licenseName']").val(data.obj.licenseName);
				    			$("#licenseModal input[name='licenseCode']").val(data.obj.licenseCode);
				    			$("#licenseModal select[name='licenseType']").val(data.obj.licenseType);
				    			$("#licenseModal input[name='capital']").val(data.obj.capital);
				    			$("#licenseModal input[name='legalPerson']").val(data.obj.legalPerson);
				    			$("#licenseModal input[name='idcard']").val(data.obj.idcard);
				    			if(data.obj.licenseRdate){
					    			$("#licenseModal input[name='licenseRdate']").val(new Date(data.obj.licenseRdate).format("yyyy-MM-dd"));
				    			}
								if(data.obj.licenseEdate){
					    			$("#licenseModal input[name='licenseEdate']").val(new Date(data.obj.licenseEdate).format("yyyy-MM-dd"));
				    			}
								if(data.obj.licenseSdate){
					    			$("#licenseModal input[name='licenseSdate']").val(new Date(data.obj.licenseSdate).format("yyyy-MM-dd"));
								}
				    			$("#licenseModal input[name='authority']").val(data.obj.authority);
				    			$("#licenseModal textarea[name='scope']").val(data.obj.scope);
				    			$("#licenseModal textarea[name='remark']").val(data.obj.remark);
				    			if(data.obj.checked == 0){
				    				$("#license-radio0").prop("checked", "checked");
				    			}else if(data.obj.checked == 1){
					    			$("#license-radio1").prop("checked", "checked");
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
	    		        url: '${webRoot}'+"/regulatory/regulatoryLicense/delete.do",
	    		        data: {"ids":id},
	    		        dataType: "json",
	    		        success: function(data){
	    		        	if(data && data.success){
	    		        		//删除成功后刷新列表
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
	 				$("#licenseModal").modal("toggle");
	 			}
	 		}
	 	]	//底部按钮
	};
	
	datagridUtil.initOption(op1);
	datagridUtil.query();
	
	//清空输入框
	$('#licenseModal').on('hidden.bs.modal', function () {
		$("#licenseModal input[type!='hidden']").val("");
		$("#licenseModal input[name='id']").val("");
		$("#licenseModal select[name='licenseType']").val("0");
		$("#licenseModal textarea").val("");
		$("#license-radio0").prop("checked", "checked");
		
		var file = $("#licenseModal input[name='filePathImage']"); 
		file.after(file.clone().val("")); 
		file.remove(); 
	});
	
	function addLicense(){
		$("#licenseForm").ajaxSubmit({
			type:'post',
			url: '${webRoot}'+"/regulatory/regulatoryLicense/save.do",
			success: function(data){
				$("#licenseModal").modal("hide");
				if(data && data.success){
					datagridUtil.query();
				}else{
					$('#confirm-warnning').modal('toggle');
				}
			}
		});
	}
	
	/*************************** 人员信息 **********************************/
	var op2 = {
		tableId: "dataList2",	//列表ID
		tableAction: '${webRoot}'+"/regulatory/regulatoryPersonnel/datagrid.do",	//加载数据地址
		//tableAction: '${webRoot}'+"/regulatory/regulatoryPersonnel/queryById.do?ids=null",
		parameter: [		//列表拼接参数
			{
				columnCode: "name",
				columnName: "人员名称",
			},
			{
				columnCode: "jobTitle",
				columnName: "职称",
			},
			{
				columnCode: "proofCode",
				columnName: "健康证编号"
			},
			{
				columnCode: "proofEdate",
				columnName: "有效期至",
				queryType: 1
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
						        url: '${webRoot}'+"/regulatory/regulatoryPersonnel/queryById.do",
						        data: {"id":id},
						        dataType: "json",
						        success: function(data){
						        	if(data && data.success && data.obj){
						    			$("#personnelModal").modal("toggle");
						    			$("#personnelModal input[name='id']").val(data.obj.id);
						    			$("#personnelModal input[name='name']").val(data.obj.name);
						    			$("#personnelModal input[name='jobTitle']").val(data.obj.jobTitle);
						    			$("#personnelModal input[name='idcard']").val(data.obj.idcard);
						    			$("#personnelModal input[name='phone']").val(data.obj.phone);
						    			$("#personnelModal input[name='proofCode']").val(data.obj.proofCode);
						    			if(data.obj.proofSdate){
							    			$("#personnelModal input[name='proofSdate']").val(new Date(data.obj.proofSdate).format("yyyy-MM-dd"));
						    			}
										if(data.obj.proofEdate){
							    			$("#personnelModal input[name='proofEdate']").val(new Date(data.obj.proofEdate).format("yyyy-MM-dd"));
						    			}
						    			$("#personnelModal textarea[name='remark']").val(data.obj.remark);
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
			    		        url: '${webRoot}'+"/regulatory/regulatoryPersonnel/delete.do",
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
					$("#personnelModal").modal("toggle");
				}
			}
		]	//底部按钮
	};
	
	//清空输入框
	$('#personnelModal').on('hidden.bs.modal', function () {
		$("#personnelModal input[type!='hidden']").val("");
		$("#personnelModal input[name='id']").val("");
		$("#personnelModal textarea").val("");
	});
	
	function addPersonnel(){
		$("#personnelForm").ajaxSubmit({
			type:'post',
			url: '${webRoot}'+"/regulatory/regulatoryPersonnel/save.do",
			success: function(data){
				$("#personnelModal").modal("hide");
				if(data && data.success){
					datagridUtil.query();
				}else{
					$('#confirm-warnning').modal('toggle');
				}
			}
		});
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
	$(".cs-tabtitle li").click(function(){
		var tabtitleNo = $(this).attr("data-tabtitleNo");
		if(tabtitleNo == "1"){
			datagridUtil.initOption(op1);
		}else if(tabtitleNo == "2"){
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
