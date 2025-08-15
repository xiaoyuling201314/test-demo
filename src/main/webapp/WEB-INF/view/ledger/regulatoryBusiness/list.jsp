<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/common/resource.jsp"%>
<html>
  <head>
    <title>快检服务云平台</title>
    <style>
		.cs-tittle-btn{
			margin-left:4px;
		}
		.cs-title-hs input{
			height:auto;
			margin-right:5px;
		}
		.qrcodes{
			height:94%;
			width:750px;
			margin:0 auto;
		}
		@media print {
		   .print-page{
		        height:auto;
		        width:100%;
		    }
		}
			
		#modal-box-iframe{
	        width:100%;
	        height: 100%;
	        position: absolute;
	        right:0;
	        left: 0;
	        top:0px;
	        bottom: 0;
	        border:0;
	        border:none;
		}
		/*.cs-search-box{*/
	    /*  	position:absolute;*/
	    /*  	right:0px;*/
	    /*  	top:0px;*/
	    /*  	z-index:1;*/
		/*}*/
	.cs-modal-box{
		padding-bottom:50px;
	}
	.cs-modal-box .modal-footer{
		position:fixed;
		bottom:0;
		width:100%;
		z-index:100;
	}
	.cs-2dcode-box{
		height:100%;
		padding: 0 0 50px 0;
	}
		.cs-title-hs input {
			height: auto;
			margin-right: 5px;
		}

		.qrcodes {
			height: 94%;
			width: 750px;
			margin: 0 auto;
		}

		@media print {
			.print-page {
				height: auto;
				width: 100%;
			}
		}

		#modal-box-iframe {
			width: 100%;
			height: 100%;
			position: absolute;
			right: 0;
			left: 0;
			top: 0px;
			bottom: 0;
			border: 0;
			border: none;
		}

		.cs-search-box {
			line-height: 30px;
		}

		.cs-search-filter {
			margin-left: 4px;
		}

		.regTypeStr li {
			padding: 0 0 0 10px;
			height: 32px;
			line-height: 28px;
			font-size: 14px;
			border-bottom: 1px solid #eee;
			overflow-y: hidden;
		}

		.regTypeStr li input {
			width: 14px;
			height: 14px;
			margin-right: 4px;
		}

		.regTypeStr li.active {
			background: #1e90ff;
			color: #fff;
		}

		.regTypeStr label {
			display: block;
		}
		.release_up_pic2 .cs-modal-input{
			margin-top: -5px;
			width: auto;
			max-width: 200px;
		}
		.release_up_pic2 .upload-files span{
			width: 100px;
		}
		.release_up_pic2 .upload-files{
			padding-top: 1px;
		}
		.code-content {
			display: inline-block;
			min-width: 150px;
			margin-right: 10px;
			margin-bottom: 12px;
			border: 1px solid #000;
			padding: 10px 30px 20px 30px;

		}

		.qrcodes{
			padding: 20px 0;
		}

	</style>
  </head>
  <body>

		<div id="dataList"></div>
    
    <!-- Modal 新增经营户-->
	<div class="modal fade intro2" id="businessModal" tabindex="-1"
		role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="static">
		<div class="modal-dialog cs-xlg-width">
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
							<c:choose>
								<c:when test="${systemFlag==1}">
									<tr>
										<td class="cs-name"><i class="cs-mred">*</i> 摊位编号：</td>
										<td class="cs-in-style"><input type="text" name="regulatoryBusiness.opeShopCode"  id="ShopCode"  datatype="*" nullmsg="请输入摊位编号" errormsg="请请输入摊位编号" /></td>
										<td class="cs-name">摊位名称：</td>
										<td class="cs-in-style"><input type="text" name="regulatoryBusiness.opeShopName"  id="opeShopName"  datatype="*" nullmsg="请输入摊位名称" errormsg="请请输入摊位名称"/></td>
									</tr>
								</c:when>
								<c:otherwise>
									<tr>
										<td class="cs-name"><i class="cs-mred">*</i> 档口编号：</td>
										<td class="cs-in-style"><input type="text" name="regulatoryBusiness.opeShopCode"  id="ShopCode"  datatype="*" nullmsg="请输入档口编号" errormsg="请请输入档口编号" /></td>
										<td class="cs-name">档口名称：</td>
										<td class="cs-in-style"><input type="text" name="regulatoryBusiness.opeShopName"  id="opeShopName"  datatype="*" nullmsg="请输入档口名称" errormsg="请请输入档口名称"/></td>
									</tr>
								</c:otherwise>
							</c:choose>
					      <tr>
					      	<td class="cs-name">社会统一信用代码：</td>
					         <td class="cs-in-style"><input type="text" name="regulatoryBusiness.creditCode" /></td>
					         <td class="cs-name">经营者：</td>
					         <td class="cs-in-style"><input type="text" name="regulatoryBusiness.opeName" /></td>
					      </tr>
					      <tr>
					      <td class="cs-name">联系人：</td>
					         <td class="cs-in-style"><input type="text" name="regulatoryBusiness.contacts" /></td>
					      	<td class="cs-name">联系方式：</td>
					         <td class="cs-in-style"><input type="text" name="regulatoryBusiness.opePhone" /></td>
					      </tr>
					      <tr>
					      <td class="cs-name">经营者身份证：</td>
					         <td class="cs-in-style"><input type="text" name="regulatoryBusiness.opeIdcard" /></td>
					      	<td class="cs-name">信用等级：</td>
					         <td class="cs-in-style">
					         	<select name="regulatoryBusiness.creditRating" id="creditRating">
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
					         	<select name="regulatoryBusiness.monitoringLevel" id="monitoringLevel">
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
					      <td class="cs-name">经营范围：</td>
					         <td class="cs-in-style"><textarea name="regulatoryBusiness.businessCope" maxlength="100" rows="" cols="" style="width: 200px; height: 50px;"></textarea></td>
					      <td class="cs-name audit cs-hide">状态：</td>
							 <td class="cs-in-style audit cs-hide cs-radio">
								<input id="business-radio0" type="radio" value="0" name="regulatoryBusiness.checked" /><label for="business-radio0">未审核</label>
								<input id="business-radio1" type="radio" value="1" name="regulatoryBusiness.checked" checked="checked"/><label for="business-radio1">已审核</label>
							 </td>
					      </tr>
					      <tr>
					      	<td class="cs-name audit cs-hide">类型：</td>
							 <td class="cs-in-style audit cs-hide cs-radio">
								<input id="business-type0" type="radio" value="0" name="regulatoryBusiness.type" checked="checked"/><label for="business-type0">经营户</label>
								<input id="business-type1" type="radio" value="1" name="regulatoryBusiness.type"/><label for="business-type1">车辆</label>
							 </td>
					      </tr>
					       <tr class="trshow">
					      	<td >营业执照信息</td>
					      </tr>
					      <tr class="trshow">
					      	 <input type="hidden" name="regulatoryLicense.id" />
					         <td class="cs-name">法人名称：</td>
					         <td class="cs-in-style"><input type="text" name="regulatoryLicense.legalPerson" /></td>
					         <td class="cs-name">法人身份证：</td>
					         <td class="cs-in-style"><input type="text" name="regulatoryLicense.idcard" /></td>
					      </tr>
					      <tr class="trshow">
					         <td class="cs-name">营业执照名称：</td>
					         <td class="cs-in-style"><input type="text" name="regulatoryLicense.licenseName" /></td>
					         <td class="cs-name">注册资金（万）：</td>
					         <td class="cs-in-style"><input type="text" name="regulatoryLicense.capital" /></td>
					      </tr >
					      <tr class="trshow">
					         <td class="cs-name">营业执照编号：</td>
					         <td class="cs-in-style"><input type="text" name="regulatoryLicense.licenseCode" /></td>
					         <td class="cs-name">营业执照注册日期：</td>
					         <td class="cs-in-style"><input type="text" name="regulatoryLicense.licenseRdate" class="cs-time" 
									onClick="WdatePicker({startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true})"/></td>
					      </tr>
					      <tr class="trshow">
					         <td class="cs-name">营业执照发证日期：</td>
					         <td class="cs-in-style"><input type="text" name="regulatoryLicense.licenseSdate" class="cs-time" 
									onClick="WdatePicker({startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true})"/></td>
					         <td class="cs-name">营业执照有效期至：</td>
					         <td class="cs-in-style"><input type="text" name="regulatoryLicense.licenseEdate" class="cs-time" 
									onClick="WdatePicker({startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true})"/></td>
					      </tr>
					      <tr class="trshow">
					         <td class="cs-name">经营范围：</td>
					         <td class="cs-in-style"><input type="text" name="regulatoryLicense.scope" /></td>
					         <td class="cs-name">发证机关：</td>
					         <td class="cs-in-style"><input type="text" name="regulatoryLicense.authority" /></td>
					      </tr>
					      <tr class="trshow">
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

		<!-- Modal 提示窗-确认-->
		<div class="modal fade intro2" id="dcjyhqcModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog cs-alert-width">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
						<h4 class="modal-title">导出</h4>
					</div>
					<div class="modal-body cs-alert-height cs-dis-tab">
						<div class="cs-text-algin">
							<img src="${webRoot}/img/warn.png" width="40px"/>
							<span class="tips">您未选择经营户，是否导出全部？</span>
						</div>
					</div>
					<div class="modal-footer">
						<a class="btn btn-success btn-ok" data-dismiss="modal" onclick="dcjyhqc();">是</a>
						<button type="button" class="btn btn-default" data-dismiss="modal">否</button>
					</div>
				</div>
			</div>
		</div>
	
	<%@include file="/WEB-INF/view/common/confirm.jsp"%>
	<%@ include file="/WEB-INF/view/common/exportDialog.jsp" %>
	<%-- 查看二维码 --%>
	<%@include file="/WEB-INF/view/common/qrcode/viewQrcode.jsp" %>

    <!-- JavaScript -->
    <script src="${webRoot}/js/datagridUtil2.js"></script>
    <script src="${webRoot}/js/jquery.form.js"></script>
    <script type="text/javascript">
	//当manaType为0时是批发市场 只有批发市场才有销售
	var manaType=1;
	manaType='${manaType}';

	if (Permission.exist("1373-15")==1 || Permission.exist("1498-15")==1){
		//审核权限
		$(".audit").show();
	}
	if (Permission.exist("1373-16")==1 || Permission.exist("1498-16")==1){
		//经营户更多信息
		$(".trshow").show();
	}
	if (Permission.exist("1373-5")==1 || Permission.exist("1498-5")==1){
		//查看二维码-导出
		showDaoChu();
	}

	//监管对象ID
	var regulatoryId = "";
	if("${regulatoryObject}" && "${regulatoryObject.id}"){
		regulatoryId = "${regulatoryObject.id}";
	}
    var dgu3 = datagridUtil.initOption({
		tableId: "dataList",
		tableAction: "${webRoot}/ledger/business/datagrid.do",
		tableBar: {
			title: ["监管对象", '${regName}', "经营户"],
			hlSearchOff: 0,
			ele: [
				{
					eleTitle: "类型",
					eleName: "regulatoryBusiness.type",
					eleType: 2,
					eleOption: [{"text": "--全部--", "val": ""}, {"text": "经营户", "val": "0"}, {"text": "车辆", "val": "1"}],
					eleStyle: "width:85px;"
				}, {
					eleShow: 1,
					eleName: "regulatoryBusiness.opeShopName",
					eleType: 0,
					elePlaceholder: "${systemFlag}"=="1" ? "请输入摊位编号" :"请输入档口编号"
				}
			],
			topBtns: [
				{
					//新增
					show: Permission.exist("1373-12") || Permission.exist("1498-12"),
					style: Permission.getPermission("1498-12"),
					action: function (ids, rows) {
						if(!regulatoryId){
							return;
						}
						$("#businessModal .modal-title").text("新增");
						$("#businessModal").modal("toggle");
					}
				},
				{
					//返回
					show: 1,
					style: {"operationName":"返回","functionIcon":"icon iconfont icon-fanhui"},
					action: function (ids, rows) {
						if('N'=='${isNewMenu}'){
							self.location.href = "${webRoot}/ledger/regulatoryObject/list.do?regTypeCode=0";
						} else {
							self.history.back();
						}
					}
				}
			],
			init: function () {
			}
		},
		funColumnWidth : "150px",
		parameter: [
			{
				columnCode: "opeShopCode",
				columnName: "${systemFlag}"=="1" ? "摊位编号" :"档口编号",
				queryCode: "regulatoryBusiness.opeShopName",
				query: 1
			},
			{
				columnCode: "opeShopName",
				columnName: "${systemFlag}"=="1" ? "摊位名称" :"档口名称"
			},
			{
				show: Permission.exist("1373-5") || Permission.exist("1498-5"),
				columnCode: "id",
				columnName: "二维码",
				customElement: "<a class=\"runcode qrcode\" data-value='?' href=\"javascript:;\" onclick=\"ckQrcode1('?');\"><img src=\"${webRoot}/img/2dcode.png\" alt=\"\" /></a>"
			},
			{
				columnCode: "opeName",
				columnName: "经营者"
			},
			{
				columnCode: "type",
				columnName: "类型",
				customVal: {"0":"经营户","1":"车辆"}
			},
			{
				columnCode: "monitoringLevel",
				columnName: "监控级别",
				query: 1,
				queryType: 2,
				queryCode: "regulatoryBusiness.monitoringLevel",
				customVal: {"1":"安全","2":"轻微","3":"警惕","4":"严重"}
			},
			{
				columnCode: "checked",
				columnName: "状态",
				customVal: {"0":"<div class=\"text-danger\">未审核</div>","1":"<div class=\"text-primary\">已审核</div>"}
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
				//编辑
				show: Permission.exist("1373-13") || Permission.exist("1498-13"),
				style: Permission.getPermission("1498-13"),
				action: function(id, row){
					$.ajax({
						type: "POST",
						url: "${webRoot}/ledger/business/queryById.do",
						data: {"id":id},
						dataType: "json",
						success: function(data){
							if(data && data.success && data.obj){
								$("#businessModal .modal-title").text("编辑");
								$("#businessModal").modal("toggle");
								if(data.obj.regulatoryBusiness){
									$("#businessModal input[name='regulatoryBusiness.id']").val(data.obj.regulatoryBusiness.id);
									$("#businessModal input[name='regulatoryBusiness.opeShopName']").val(data.obj.regulatoryBusiness.opeShopName);
									$("#businessModal input[name='regulatoryBusiness.opeShopCode']").val(data.obj.regulatoryBusiness.opeShopCode);
									$("#businessModal input[name='regulatoryBusiness.creditCode']").val(data.obj.regulatoryBusiness.creditCode);
									$("#businessModal input[name='regulatoryBusiness.opeName']").val(data.obj.regulatoryBusiness.opeName);
									$("#businessModal input[name='regulatoryBusiness.contacts']").val(data.obj.regulatoryBusiness.contacts);
									$("#businessModal input[name='regulatoryBusiness.opePhone']").val(data.obj.regulatoryBusiness.opePhone);
									$("#businessModal input[name='regulatoryBusiness.opeIdcard']").val(data.obj.regulatoryBusiness.opeIdcard);
									/*$("#businessModal input[name='regulatoryBusiness.creditRating']").val(data.obj.regulatoryBusiness.creditRating);
									 $("#businessModal input[name='regulatoryBusiness.monitoringLevel']").val(data.obj.regulatoryBusiness.monitoringLevel);*/
									document.getElementById('creditRating').value=data.obj.regulatoryBusiness.creditRating;
									document.getElementById('monitoringLevel').value=data.obj.regulatoryBusiness.monitoringLevel;
									$("#businessModal textarea[name='regulatoryBusiness.remark']").val(data.obj.regulatoryBusiness.remark);
									$("#businessModal textarea[name='regulatoryBusiness.businessCope']").val(data.obj.regulatoryBusiness.businessCope);
									if(data.obj.regulatoryBusiness.checked == 0){
										$("#business-radio0").prop("checked", true);
									}else if(data.obj.regulatoryBusiness.checked == 1){
										$("#business-radio1").prop("checked", true);
									}
									if(data.obj.regulatoryBusiness.type == 0){
										$("#business-type0").prop("checked", true);
									}else if(data.obj.regulatoryBusiness.type == 1){
										$("#business-type1").prop("checked", true);
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
			}, {
				//删除
				show: Permission.exist("1373-14") || Permission.exist("1498-14"),
				style: Permission.getPermission("1498-14"),
				action: function(id, row){
					if(id == ''){
						$("#confirm-warnning .tips").text("请选择经营户");
						$("#confirm-warnning").modal('toggle');
					}else{
						deleteIds = id;
						$("#confirm-delete").modal('toggle');
					}
				}
			}, {
				//进货
				show: Permission.exist("1373-6") || Permission.exist("1498-6"),
				style: Permission.getPermission("1498-6"),
				action: function(id, row){
				var regId='${regulatoryObject.id}';
				window.location.href='${webRoot}'+"/ledger/stock/list.do?businessId="+id+"&regId="+regId;
				}
			}, {
				//销售台账
				show: Permission.exist("1373-7"),
				style: Permission.getPermission("1373-7"),
				action: function(id, row){
				var regId='${regulatoryObject.id}';
				window.location.href="${webRoot}/ledger/sale/list.do?businessId="+id+"&regId="+regId;
				}
			}

		],
		bottomBtns: [
			{
				//查看二维码
				show: Permission.exist("1373-5") || Permission.exist("1498-5"),
				style: Permission.getPermission("1498-5"),
				action: function(ids, rows){
					if(ids == ''){
						$("#confirm-warnning .tips").text("请选择经营户");
						$("#confirm-warnning").modal('toggle');
					}else{
						// viewQrcode(ids);
						viewBusQrcode('${regName}', ids, rows);
					}
				}
			}, {
				//导出二维码
				show: Permission.exist("1373-17") || Permission.exist("1498-17"),
				style: Permission.getPermission("1498-17"),
				action : function(ids, rows) {
					if (!ids || ids.length == 0) {
						$("#dcjyhqcModal .tips").text('您未选择经营户，是否导出全部('+dgu3.datagridOption.rowTotal+'条记录)？');
						$("#dcjyhqcModal").modal('toggle');
						return;
					} else {
						dcjyhqc(ids);
					}
				}
			}, {
				//删除
				show: Permission.exist("1373-14") || Permission.exist("1498-14"),
				style: Permission.getPermission("1498-14"),
				action: function(ids, rows){
					if(ids == ''){
						$("#confirm-warnning .tips").text("请选择经营户");
						$("#confirm-warnning").modal('toggle');
					}else{
						deleteIds = ids;
						$("#confirm-delete").modal('toggle');
					}
				}
			}, {
				//导入经营户
				show: Permission.exist("1373-9") || Permission.exist("1498-9"),
				style: Permission.getPermission("1498-9"),
				action : function(ids, rows) {
					 location.href = '${webRoot}/regulatory/business/toImport.do?isNewMenu=${isNewMenu}'
				}
			},{
				//导出经营户
				show: Permission.exist("1373-11") || Permission.exist("1498-11"),
				style: Permission.getPermission("1498-11"),
				action : function(ids, rows) {
					$("#exportModal").modal('toggle');
				}
			}
		]
	});
	dgu3.queryByFocus();

	//导出经营户二维码
	function dcjyhqc(ids){
		//导出全部
		if (!ids) {
			console.log(dgu3.getQueryParam());
			var qpOpeShopName = "";
			var qpType = "";
			if (dgu3) {
				var queryParam = dgu3.getQueryParam();
				if (queryParam["regulatoryBusiness.opeShopName"]) {
					qpOpeShopName = queryParam["regulatoryBusiness.opeShopName"];
				}
				if (queryParam["regulatoryBusiness.type"]) {
					qpType = queryParam["regulatoryBusiness.type"];
				}
			}
			location.href = '${webRoot}/regulatory/business/exportQrcode.do?regId='+regulatoryId+'&opeShopName='+qpOpeShopName+'&type='+qpType;
		//导出部分
		} else {
			location.href = '${webRoot}/regulatory/business/exportQrcode.do?regId='+regulatoryId+"&busIds="+ids;
		}
	}
    
  	<%--//导出方法--%>
    <%--function exportFile() {--%>
    <%--    var radios = document.getElementsByName('inlineRadioOptions');--%>
    <%--    var ext = '';--%>
    <%--    for (var i = 0; i < radios.length; i++) {--%>
    <%--        if (radios[i].checked) {--%>
    <%--            ext = radios[i].value;--%>
    <%--        }--%>
    <%--    }--%>
    <%--    if (ext!='') {--%>
	<%--		let regId='${regulatoryObject.id}';--%>
    <%--    	let opeShopName=$("input[name='regulatoryBusiness.opeShopName']").val();--%>
    <%--        location.href = '${webRoot}/regulatory/business/exportFile.do?types=' + ext + "&regId=" + regId+"&opeShopName="+opeShopName;--%>
    <%--        $("#exportModal").modal('hide');--%>
	<%--	}else {--%>
	<%--		$("#exportModal").modal('hide');--%>
	<%--		$("#confirm-warnning .tips").text("请选择导出格式!");--%>
	<%--		$("#confirm-warnning").modal('toggle');--%>
	<%--	}--%>
    <%--}--%>

	//查看单个二维码
	function ckQrcode1(busid){
		var row = [];
		$.each(dgu3.getData(), function (i, e) {
			if (busid == e.id) {
				row.push(e);
				viewBusQrcode('${regName}', busid, row);
				return false;
			}
		});
	}
    
	//清空输入框
	$('#businessModal').on('hidden.bs.modal', function () {
		$("#businessModal input[type!='hidden'][type!='radio']").val("");
		$("#businessModal input[name='regulatoryBusiness.id']").val("");
		$("#businessModal input[name='regulatoryLicense.id']").val("");
		$("#businessModal textarea").val("");
		$("#business-radio1").prop("checked", true);
		$("#creditRating option:first").prop("selected", 'selected');
		$("#monitoringLevel option:first").prop("selected", 'selected');
		
		var file = $("#businessModal input[name='filePathImage']"); 
		file.after(file.clone().val("")); 
		file.remove(); 
	});

	function addBusiness(){
		var ShopCode=$("#ShopCode").val();
		if(ShopCode==""||ShopCode==null){
			$("#confirm-warnning .tips").text("档口编号不能为空!");
			$("#confirm-warnning").modal('toggle');
			return;
		}
		/* var opeShopName=$("#opeShopName").val();
		if(opeShopName==""||opeShopName==null){
			$("#confirm-warnning .tips").text("档口名称不能为空!");
			$("#confirm-warnning").modal('toggle');
			return;
		} */
		$("#businessForm").ajaxSubmit({
			type:'post',
			url: "${webRoot}/ledger/business/save.do",
			success: function(data){
				if(data && data.success){
					$("#businessModal").modal("hide");
					dgu3.queryByFocus();
				}else{
					$("#confirm-warnning .tips").text(data.msg);
					$('#confirm-warnning').modal('toggle');
				}
			}
		});
	}
	
    //删除
    var deleteIds = "";
    function deleteData(){
    	$.ajax({
	        type: "POST",
	        url: '${webRoot}'+"/ledger/business/delete.do",
	        data: {"ids":deleteIds.toString()},
	        dataType: "json",
	        success: function(data){
	        	if(data && data.success){
		        	self.location.reload();
	        	}else{
	        		$("#confirm-warnning .tips").text("删除失败");
	    			$("#confirm-warnning").modal('toggle');
	        	}
			}
	    });
		$("#confirm-delete").modal('toggle');
    }
    
    
  	// //打印
    // function preview(){
	// 	if (!!window.ActiveXObject || "ActiveXObject" in window) {
	//         remove_ie_header_and_footer();
	//     }
    //     var bdhtml=window.document.body.innerHTML;
    //     var sprnstr="<!--startprint-->";
    //     var eprnstr="<!--endprint-->";
    //     var prnhtml=bdhtml.substring(bdhtml.indexOf(sprnstr)+17);
    //     prnhtml=prnhtml.substring(0,prnhtml.indexOf(eprnstr));
    //     window.document.body.innerHTML=prnhtml;
    //     window.print();
	//         //setTimeout(location.reload(), 10);
    //     window.document.body.innerHTML=bdhtml;
    //
    //     window.location.reload();
	// }
  	//
  	//
    // $('.cs-title-hs input').click(function(){
	// 	if($(this).prop('checked')){
	// 		$('.cs-title-ib').show();
	// 	}else{
	// 		$('.cs-title-ib').hide();
	// 	}
	// });
	// //二维码查看返回按钮
	// function closeModal(){
	// 	$("#qrcodeModal").hide();
	// 	$('html').css('overflow','auto');
	// }
    </script>
  </body>
</html>
