<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/common/resource.jsp"%>
<html>
<head>
</head>
<body>
	<div id="dataList"></div>

	<!-- 编辑模态框 start -->
	<div class="modal fade intro2" id="addModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
		<div class="modal-dialog cs-mid-width" role="document">
			<div class="modal-content ">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" >新增</h4>
				</div>
				<div class="modal-body cs-mid-height">
					<!-- 主题内容 -->
					<div class="cs-tabcontent">
						<div class="cs-content2">
							<form id="saveForm" action="${webRoot}/data/detectItem/save.do" method="post">
								<input type="hidden" name="id"> <input type="hidden" name="detectItemCode">
								<table class="cs-add-new">
									<tr>
										<td class="cs-name"><i class="cs-mred">*</i>项目名称：</td>
										<td class="cs-in-style"><input type="text" name="pointName" datatype="*" nullmsg="请输入项目名称"
											errormsg="请输入项目名称" /></td>
									</tr>
									<tr>
										<td class="cs-name">项目类别：</td>
										<td class="cs-in-style"><select name="detectItemTypeid">
												<c:forEach items="${itemList}" var="itemType">
													<option value="${itemType.id }">${itemType.itemName}</option>
												</c:forEach>
										</select></td>
									</tr>
									<tr>
										<td class="cs-name">检测标准：</td>
										<td class="cs-in-style"><select name="standardId">
												<c:forEach items="${standardList}" var="standard">
													<option value="${standard.id }">${standard.standardName}</option>
												</c:forEach>
										</select></td>
									</tr>
									<tr>
										<td class="cs-name">判定符号：</td>
										<td class="cs-in-style"><select name="detectSign">
												<option value="&gt;">&gt;</option>
												<option value="&lt;">&lt;</option>
												<option value="&ge;">&ge;</option>
												<option value="&le;">&le;</option>
										</select></td>
									</tr>
									<tr>
										<td class="cs-name"><i class="cs-mred">*</i>合格值：</td>
										<td class="cs-in-style"><input type="text" name="detectValue" datatype="n" nullmsg="请输入合格值"
											errormsg="请输入数字类型" /></td>
									</tr>
									<tr>
										<td class="cs-name"><i class="cs-mred">*</i>合格值单位：</td>
										<td class="cs-in-style"><input type="text" name="detectValueUnit" datatype="*" nullmsg="请输入合格值单位"
											errormsg="请输入标准名称" /></td>
									</tr>
									<tr>
										<td class="cs-name">状态：</td>
										<td class="cs-in-style cs-radio"><input id="cs-check-radio" type="radio" value="1" name="status" /><label
											for="cs-check-radio">已审核</label> <input id="cs-check-radio2" type="radio" value="0" name="status"
											checked="checked" /><label for="cs-check-radio2">未审核</label></td>
									</tr>
								</table>
							</form>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-success" id="btnSave">确定</button>
					<button type="button" class="btn btn-default" data-dismiss="modal" id="btnCancel">关闭</button>
				</div>
			</div>
		</div>
	</div>
	<!-- 编辑模态框 end -->

	<!-- Modal 提示窗-重置上传状态-->
	<div class="modal fade intro2" id="resetUploadStatusConfirm" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
		aria-hidden="false">
		<div class="modal-dialog cs-alert-width">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title">确认提示</h4>
				</div>
				<div class="modal-body cs-alert-height cs-dis-tab">
					<div class="cs-text-algin">
						<img src="${webRoot}/img/warn.png" width="40px" />确认重置上传状态？
					</div>
				</div>
				<div class="modal-footer">
					<a class="btn btn-danger btn-ok" onclick="resetUploadStatus()">确认</a>
					<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
				</div>
			</div>
		</div>
	</div>

	<!-- 更改检测结果 -->
	<div class="modal fade intro2" id="modifiedModal" tabindex="-1" role="dialog" aria-labelledby="modifiedModalLabel">
		<div class="modal-dialog cs-lg-width" role="document">
			<div class="modal-content ">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
					<h4 class="modal-title" id="modifiedModalLabel">更改检测结果</h4>
				</div>
				<div class="modal-body cs-lg-height">
					<div class="cs-tabcontent" >
						<div class="cs-content2">
							<form id="modifiedForm" method="post" action="${webRoot}/dataCheck/recording/modifiedData">
								<input type="hidden" name="dataSource" value="3">
								<table class="cs-add-new">
									<tr>
										<td class="cs-name">编号：</td>
										<td class="cs-in-style" colspan="2">
											<input  type="text" class="disabled-style" name="rid" readonly="readonly"/>
										</td>

									</tr>
									<tr>
										<td class="cs-name">样品名称：</td>
										<td class="cs-in-style" colspan="2">
											<input  type="text" class="disabled-style"  name="foodName" disabled="disabled"/>
										</td>
									</tr>
									<tr>
										<td class="cs-name">检测项目：</td>
										<td class="cs-in-style" colspan="2">
											<input  type="text" class="disabled-style" name="itemName" disabled="disabled"/>
										</td>
									</tr>
									<tr>
										<td class="cs-name"><i class="cs-mred">*</i>检测结果：</td>
										<td class="cs-in-style">
											<input type="text" name="checkResult" placeholder="请输入检测值" autocomplete="off" datatype="*" nullmsg="请输入检测值" errormsg="请输入正确检测值"/>&nbsp;
										</td>
										<td class="cs-text-nowrap username-wrong">
											<div class="Validform_checktip"></div>
										</td>
									</tr>
									<tr>
										<td class="cs-name"><i class="cs-mred">*</i>检测结论：</td>
										<td class="cs-in-style" colspan="2">
											<select name="conclusion">
												<option>合格</option>
												<option>不合格</option>
											</select>
										</td>
									</tr>
									<tr>
										<td class="cs-name"><i class="cs-mred">*</i>检测时间：</td>
										<td class="cs-in-style">
											<input name="checkDate" class="cs-time" type="text" onClick="WdatePicker({startDate:'%y-%M-%d %H:%m:%s',maxDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
												   datatype="*" nullmsg="请选择检测时间" errormsg="请选择检测时间"/>
										</td>
										<td class=" cs-text-nowrap username-wrong">
											<div class="Validform_checktip"></div>
										</td>
									</tr>
									<tr>
										<td class="cs-name"><i class="cs-mred">*</i>备注：</td>
										<td class="cs-in-style">
											<textarea class="cs-remark" name="modifiedRemark" cols="30" rows="10" datatype="*" nullmsg="请输入备注" errormsg="请输入备注"></textarea>
										</td>
										<td><span class="Validform_checktip"></span></td>
									</tr>
								</table>
							</form>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-success" id="submit1">确定</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				</div>
			</div>
		</div>
	</div>

	<%-- 删除检测数据 --%>
	<div class="modal modal2 fade intro2" id="deleteModal" tabindex="-1" role="dialog" aria-labelledby="deleteModalLabel">
		<div class="modal-dialog cs-mid-width" role="document">
			<div class="modal-content ">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
					<h4 class="modal-title" id="deleteModalLabel">删除</h4>
				</div>
				<div class="modal-body cs-mid-height">
					<div class="cs-tabcontent" >
						<div class="cs-content2">
							<form id="deleteForm" method="post" action="${webRoot}/dataCheck/recording/delete">
								<table class="cs-add-new">
									<tr>
										<input type="hidden" class="disabled-style" name="hasDeadline" value="0"/>
										<td class="cs-name" style="width: 150px;">编号：</td>
										<td class="cs-in-style" style="width: 210px;">
											<input  type="text" class="disabled-style" name="rid" readonly="readonly"/>
										</td>
										<td></td>
									</tr>
									<tr>
										<td class="cs-name">样品名称：</td>
										<td class="cs-in-style">
											<input  type="text" class="disabled-style"  name="foodName" disabled="disabled"/>
										</td>
										<td></td>
									</tr>
									<tr>
										<td class="cs-name">检测项目：</td>
										<td class="cs-in-style">
											<input  type="text" class="disabled-style" name="itemName" disabled="disabled"/>
										</td>
										<td></td>
									</tr>
									<tr>
										<td class="cs-name"><i class="cs-mred">*</i>备注：</td>
										<td class="cs-in-style">
											<textarea class="cs-remark" name="param4" cols="30" rows="10" datatype="*" nullmsg="请输入备注" errormsg="请输入备注" maxlength="180"></textarea>
										</td>
										<td></td>
									</tr>
								</table>
							</form>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-success" id="submit2">确定</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				</div>
			</div>
		</div>
	</div>

	<%@include file="/WEB-INF/view/common/confirm.jsp"%>
	<%@include file="/WEB-INF/view/common/exportDialog.jsp"%>
	<%@include file="/WEB-INF/view/common/exportStandingBook.jsp"%>
	<%@include file="/WEB-INF/view/common/modalBox.jsp"%>
	<%@include file="/WEB-INF/view/ledger/regulatoryObject/selectRegType.jsp"%>
	<%-- 定位 --%>
	<%@include file="/WEB-INF/view/common/map.jsp"%>
	<script src="${webRoot}/js/datagridUtil2.js"></script>
	<%@include file="/WEB-INF/view/detect/depart/selectDepartModel.jsp"%>
	<script type="text/javascript">

	/********************************************************** 抽样单检测数据 **********************************************************/
	var csd = '${start}';
	var ced = '${end}';
	if("${systemFlag}"=="2"){
		$("#myDepartModal").find(".modal-title").html("选择企业");
	}
	var dgu;
	//抽样单检测数据
	if ('${dataType}' == 0) {
		dgu = datagridUtil.initOption({
			tableId: "dataList",
			tableAction: "${webRoot}/dataCheck/recording/datagrid.do?refrel=/dataCheck/recording/list.do",
			funColumnWidth:'80px',
			showFunBtns: (Permission.exist("311-13") || Permission.exist("311-2") || Permission.exist("311-19") ? 1 : 0),
			tableBar: {
				title: ["检测数据","检测结果"],
				ele: [{
					eleShow: Permission.exist("311-15"),
					eleTitle: "检测点",
					eleName: "pointType",
					eleType: 2,
					eleOption: [{"text":"--全部--","val":""},{"text":"政府检测室","val":"0"},{"text":"企业检测室","val":"2"},{"text":"检测车","val":"1"}],
					eleStyle: "width:85px;"
				},{
					//监管类型
					eleShow: Permission.exist("311-8"),
					eleType: 4,
					eleHtml: "<span class=\"check-date cs-fl\">" +
							"<span class=\"cs-name\" style=\"padding-right: 0px;\">监管类型：</span>" +
							"<span class=\"cs-input-style \" style=\"margin-left: 0px;\">" +
							"<input type=\"hidden\" name=\"regTypeId\" value=\"\" id=\"regTypeIds\" class=\"focusInput\"/>" +
							"<input type=\"text\" name=\"regTypeName\" class=\"choseRegType\" value=\"--全部--\" autocomplete=\"off\" style=\"width: 110px\" readonly/>" +
							"</span>" +
							"</span>"
				},{
					eleShow: 1,
					eleTitle: "检测日期",
					eleName: "checkDate",
					eleType: 3,
					eleStyle: "width:110px;",
					eleDefaultDateMin: (!csd ? new newDate().DateAdd("m",-1).format("yyyy-MM-dd") : csd),
					eleDefaultDateMax: (!ced ? new newDate().format("yyyy-MM-dd") : ced)
				},{
					eleShow: 1,
					eleName: "keyWords",
					eleType: 0,
					elePlaceholder: "编号、样品编号、机构、检测点、市场"
				}],
				switchSearch: function(queryType){
					if (queryType == 0) {
						// $("#dataList_checkDateStartDateInput").val($("#dataListcheckDateStart").val()+" 00:00:00");
						// $("#dataList_checkDateEndDateInput").val($("#dataListcheckDateEnd").val()+" 23:59:59");
						$("#dataList_checkDateStartDateInput").val($("#dataListcheckDateStart").val());
						$("#dataList_checkDateEndDateInput").val($("#dataListcheckDateEnd").val());
					} else {
						$("#dataListcheckDateStart").val(newDate($("#dataList_checkDateStartDateInput").val()).format("yyyy-MM-dd"));
						$("#dataListcheckDateEnd").val(newDate($("#dataList_checkDateEndDateInput").val()).format("yyyy-MM-dd"));
					}
				}
			},
			defaultCondition: [
				{
					queryCode: "udealType",
					queryVal: "0"
				}, {
					queryCode: "dataType",
					queryVal: '${dataType}'
				}, {
					queryCode: "conclusion",
					queryVal: '${conclusion}'
				}, {
					queryCode: "regTypeId",
					queryVal: ''
				}, {
					queryCode: "departId",
					queryVal: ''
				} ],
			parameter: [
				{
					columnCode: "id",
					columnName: "编号",
					columnWidth: "80px",
					customElement: (Permission.exist("311-1") ? "<a class='text-primary cs-link' onclick='viewDetail(?);'>?</a>" : "?")
				}, {
					columnCode: "departName",
					columnName: "${systemFlag}"=="2" ? "企业名称" : "检测机构",
					queryCode: "departName",
					customStyle: "departName",
					query: 1
				}, {
					columnCode: "pointName",
					columnName: "检测点",
					queryCode: "pointName",
					query: 1
				}, {
					columnCode: "regName",
					columnName: "被检单位",
					queryCode: "regName",
					query: 1
				}, {
					columnCode: "opeShopName",
					columnName: "${systemFlag}"=="1" ? "摊位编号" : "档口编号",
					queryCode: "opeShopName",
					query: 1
				}, {
					columnCode: "foodName",
					columnName: "样品名称",
					query: 1
				}, {
					columnCode: "itemName",
					columnName: "检测项目",
					query: 1
				}, {
					columnCode: "checkResult",
					columnName: "检测值",
					columnWidth: "75px",
					customStyle: "checkResult",
                    sortDataType:"float"
				}, {
					columnCode: "conclusion",
					columnName: "结果",
					columnWidth: "60px",
					query: 1,
					queryType: 2,
					customVal: {
						"合格": "<span class=\"text-success\">合格</span>",
						"不合格": "<span class=\"text-danger\">不合格</span>"
					}
				}, {
					columnCode: "checkDate",
					columnName: "检测时间",
					columnWidth: "90px",
					dateFormat: "yyyy-MM-dd HH:mm:ss",
					query: 1,
					queryCode: "checkDate",
					queryName: "检测日期",
					queryDateFormat: "yyyy-MM-dd",
					queryType: 3,
                    sortDataType:"date"
				}, {
					columnCode: "checkUsername",
					columnName: "检测人员",
					columnWidth: "80px"
				}, {
					show: Permission.exist("311-9"),
					query: Permission.exist("311-9"),
					queryType: 2,
					columnCode: "param2",
					columnName: "上传状态",
					customVal: {"0":"<i title='未上传'>未上传</i>","1":"<i title='上传时间：#time1#' class='text-success'>上传成功</i>",
						"2":"<i title='上传时间：#time1#；原因：#param5#' class='text-danger'>上传失败</i>",
						"3":"<i title='上传时间：#time1#；原因：#param5#' class='text-danger'>重传失败</i>"},
				}, {
					show: Permission.exist("311-20"),
					columnCode: "sampleCode",
					columnName: "抽样编号",
					columnWidth: "86px",
					customStyle: 'sampleCode'
					// //吉安平台、lz云服务和晋城平台隐藏此列
					// show: ((window.location.hostname == 'ja.chinafst.cn'||window.location.hostname == 'lz.chinafst.cn'||window.location.hostname == 'spkj.jcgov.gov.cn')? 0 : 1)
				}, {
					columnCode: "reloadFlag",
					columnName: "复检",
					columnWidth: "54px",
					customStyle: "reloadFlag",
					show: Permission.exist("311-17"),
					sortDataType: "int",
					customVal: {"0":"<a class='text-primary reload-zero'>0</a>", "default":"<a class='text-primary cs-link reloadCount'>?</a>"}
				} ],
			funBtns: [{
				//定位
				show: Permission.exist("311-19"),
				style: Permission.getPermission("311-19"),
				action: function(id, row) {
					if (row.param8) {
						var dingwei = row.param8.split(",");
						if (dingwei.length >= 2 && dingwei[0] && dingwei[1]) {
							mapX = dingwei[0];
							mapY = dingwei[1];
							if (dingwei.length >= 3) {
								mapAddress = dingwei[2];
							} else {
								mapAddress = "";
							}
							$('#position').modal("show");
							return;

						}
					}

					$("#confirm-warnning .tips").text("未找到定位信息");
					$("#confirm-warnning").modal('toggle');
				}
			}, {
				//更改检测结果
				show: Permission.exist("311-13"),
				style: Permission.getPermission("311-13"),
				action: function(id, row) {
					$("#modifiedForm input[name=dcr.id]").val(row.id);
					$("#modifiedForm input[name=foodName]").val(row.foodName);
					$("#modifiedForm input[name=itemName]").val(row.itemName);
					$("#modifiedForm input[name=checkResult]").val(row.checkResult);
					$("#modifiedForm select[name=conclusion]").val(row.conclusion);
					$("#modifiedForm input[name=checkDate]").val(row.checkDate);
					$("#modifiedForm input[name=modifiedRemark]").val("");
					$("#modifiedModal").modal("show");
				}
			}, {
				//删除按钮
				show: Permission.exist("311-2"),
				style: Permission.getPermission("311-2"),
				action: function(id, row) {
					$("#deleteModal input[name='dcr.id']").val(row.id);
					$("#deleteModal input[name='foodName']").val(row.foodName);
					$("#deleteModal input[name='itemName']").val(row.itemName);
					$("#deleteModal textarea[name='param4']").val("");
					$("#deleteModal").modal('toggle');
				}
			}, {
				//重置上传状态
				show: Permission.exist("311-10"),
				style: Permission.getPermission("311-10"),
				action: function(id, row) {
					resetUploadId = id;
					$("#resetUploadStatusConfirm").modal('toggle');
				}
			} ],
			bottomBtns: [ {
				//导出
				show: Permission.exist("311-6"),
				style: Permission.getPermission("311-6"),
				action: function(ids) {
					//检测结果数量 > 300000
					if (dgu.datagridOption.rowTotal && dgu.datagridOption.rowTotal>300000) {
						$("#confirm-warnning .tips").text("每次导出数据不能大于30万条");
						$("#confirm-warnning").modal('toggle');
					}else {
						exportDataType = 1;
						exportIds = ids;
						$("#exportModal").modal('toggle');
					}
				}
			}, {
				//导出台账
				show: Permission.exist("311-11"),
				style: Permission.getPermission("311-11"),
				action: function(ids) {
					//检测结果数量 > 300000
					if (dgu.datagridOption.rowTotal && dgu.datagridOption.rowTotal>300000) {
						$("#confirm-warnning .tips").text("每次导出数据不能大于30万条");
						$("#confirm-warnning").modal('toggle');
					}else {
						exportDataType = 2;
						$("#myModalLabel").html("导出台账");
						$("#exportStandBookModal").modal('toggle');
					}
				}
			}, {
				//导出快检公示
				show: Permission.exist("311-12"),
				style: Permission.getPermission("311-12"),
				action: function(ids) {
					//检测结果数量 > 300000
					if (dgu.datagridOption.rowTotal && dgu.datagridOption.rowTotal>300000) {
						$("#confirm-warnning .tips").text("每次导出数据不能大于30万条");
						$("#confirm-warnning").modal('toggle');
					}else {
						exportDataType = 3;
						$("#myModalLabel").html("导出公示");
						$("#exportStandBookModal").modal('toggle');
					}
				}
			}, {
				//重置上传状态
				show: Permission.exist("311-10"),
				style: Permission.getPermission("311-10"),
				action: function(ids) {
					resetUploadId = ids;
					$("#resetUploadStatusConfirm").modal('toggle');
				}
			} ],
			before: function(queryType){
				//高级搜索
				if(queryType == 0){
					//清除时间范围查询条件
					dgu.delDefaultCondition("checkDateStartDateStr");
					dgu.delDefaultCondition("checkDateEndDateStr");
				}

				//设置监管对象类型
				if ($("#regType option:first").val()) {
					dgu.addDefaultCondition("regTypeId", "");
				} else {
					dgu.delDefaultCondition("regTypeId");
				}
			},onload: function(obj,data){
				//add by xiaoyl 2022/04/07 加载列表后执行函数,处理检测值和检测单位合并成一列展示
				if (obj) {
					for (var i = 0; i < obj.length; i++) {
						if (!isNaN(parseFloat(obj[i].checkResult)) && isFinite(obj[i].checkResult)){//判断检测值是否为数字
							$("tr[data-rowid=" + obj[i].id + "]").find(".checkResult").html(obj[i].checkResult+obj[i].checkUnit);
						}
						//判断定位信息是否为空
						if (!obj[i].param8){
							$("tr[data-rowid=" + obj[i].id + "] .311-19").remove();
						}
					}
				}
			}
		});
		dgu.queryByFocus();
	}
	$(document).on("click", "input[name=departName]", function(){
		$('#myDepartModal').modal('toggle');
	});
	//选择机构
	var departId;
	function selDepart(id, text){
		$('#myDepartModal').modal('toggle');
		departId=id;
		dgu.addDefaultCondition("departId", departId);
		$("input[name='departName']").val(text);
		$(".cs-check-down").hide();
	}
	$(function() {
		var demo = $("#saveForm").Validform({
			callback: function(data) {
				$.Hidemsg();
				if (data.success) {
					$("#addModal").modal("hide");
					dgu.queryByFocus();
				} else {
					$.Showmsg(data.msg);
				}
			}
		});
		// 新增或修改
		$("#btnSave").on("click", function() {
			demo.ajaxPost();
			return false;
		});
		//关闭编辑模态框前重置表单，清空隐藏域
		$('#addModal').on('hidden.bs.modal', function(e) {
			$.Hidemsg();
			var form = $("#saveForm");// 清空表单数据
			form.form("reset");
			$("input[name=id]").val("");
			$("input[name=detectItemCode]").val("");
		});
	});

	//导出数据类型；1_检测数据，2_台账，3_快检公示
	var exportDataType = 1;
	var exportIds;
	function exportFile() {
		var radios = document.getElementsByName('inlineRadioOptions');
		var ext = '';
		for (var i = 0; i < radios.length; i++) {
			if (radios[i].checked) {
				ext = radios[i].value;
			}
		}
		if(ext!=''){
			var form = $('#queryForm').serialize();
			form = decodeURIComponent(form, true);
			var queryParams = dgu.getQueryParam();
			var exportFileUrl = "${webRoot}/dataCheck/recording/exportFile?dataType=${dataType}&exportDataType="+exportDataType+"&ids="+exportIds+"&type="+ext;
			if (queryParams){
				for (var key in queryParams) {
					switch (key) {
						case "dateMap":
							var dateMap = queryParams.dateMap;
							if (dateMap) {
								for (var dateMapKey in dateMap) {
									switch (dateMapKey) {
										case "checkDateStartDate":
											exportFileUrl += "&checkDateStartDateStr="+dateMap[dateMapKey];
											break;
										case "checkDateEndDate":
											exportFileUrl += "&checkDateEndDateStr="+dateMap[dateMapKey];
											break;
									}
								}
							}
							break;
						case "checkDateStartDate":
							exportFileUrl += "&checkDateStartDateStr="+queryParams[key]+" 00:00:00";
							break;
						case "checkDateEndDate":
							exportFileUrl += "&checkDateEndDateStr="+queryParams[key]+" 23:59:59";
							break;
						default:
							exportFileUrl += "&"+key+"="+queryParams[key];
							break;
					}
				}
			}
			exportFileUrl += "&departId="+departId;
			location.href = exportFileUrl;

			//location.href = '${webRoot}/dataCheck/recording/exportFile.do?' + form + '&type=' + ext + '&keyWords=' + $("#dataList input[name='keyWords']").val()+'&checkDateStartDateStr='+$("#dataListcheckDateStart").val()+'&checkDateEndDateStr='+$("#dataListcheckDateEnd").val()+"&regTypeId="+$("#dataList input[name='regTypeId']").val()+"&dataType=${dataType}&exportDataType="+exportDataType+"&ids="+exportIds;
			$("#exportModal").modal('hide');
		}else {
			$("#exportModal").modal('hide');
			$("#confirm-warnning .tips").text("请选择导出格式!");
			$("#confirm-warnning").modal('toggle');
		}
	}

	//重置上传状态
	function resetUploadStatus() {
		// alert(resetUploadId);
		$.ajax({
			type: "POST",
			url: "${webRoot}/dataCheck/recording/resetUploadStatus",
			data: {
				"id": resetUploadId+""
			},
			success: function(data) {
				if (data && data.success) {
					//删除成功后刷新列表
					dgu.query();
				}
			},
			error: function() {
				console.log("重置上传状态失败!");
			}
		});
		$("#resetUploadStatusConfirm").modal('toggle');
	}

	//查看详情
	function viewDetail(id){
		showMbIframe("${webRoot}/dataCheck/recording/checkDetail.do?id=" + id);
	}

	/********************************************************** 订单检测数据 **********************************************************/
	//控制进货数量列是否显示
	var showPurchaseNumber=${showPurchaseNumber}!=0 ? 1 : 0;
	//订单检测数据
	if ('${dataType}' == 2) {
		dgu = datagridUtil.initOption({
			tableId: "dataList",
			tableAction: "${webRoot}/dataCheck/recording/datagrid",
			funColumnWidth: "80px",
			tableBar: {
				title: ["检测数据","检测结果"],
				ele: [{
					eleShow: 1,
					eleTitle: "检测日期",
					eleName: "checkDate",
					eleType: 3,
					eleStyle: "width:110px;",
					eleDefaultDateMin: (!csd ? new newDate().DateAdd("m",-1).format("yyyy-MM-dd") : csd),
					eleDefaultDateMax: (!ced ? new newDate().format("yyyy-MM-dd") : ced)
				},{
					eleShow: 1,
					eleName: "keyWords",
					eleType: 0,
					elePlaceholder: "样品编号、委托单位、样品名称、检测项目"
				}],
				switchSearch: function(queryType){
					if (queryType == 0) {
						// $("#dataList_checkDateStartDateInput").val($("#dataListcheckDateStart").val()+" 00:00:00");
						// $("#dataList_checkDateEndDateInput").val($("#dataListcheckDateEnd").val()+" 23:59:59");
						$("#dataList_checkDateStartDateInput").val($("#dataListcheckDateStart").val());
						$("#dataList_checkDateEndDateInput").val($("#dataListcheckDateEnd").val());
					} else {
						$("#dataListcheckDateStart").val(newDate($("#dataList_checkDateStartDateInput").val()).format("yyyy-MM-dd"));
						$("#dataListcheckDateEnd").val(newDate($("#dataList_checkDateEndDateInput").val()).format("yyyy-MM-dd"));
					}
				}
			},
			defaultCondition: [
				 {
					queryCode: "checkDateStartDateStr",
					queryVal: '${start}'
				}, {
					queryCode: "checkDateEndDateStr",
					queryVal: '${end}'
				}, {
					queryCode: "refrel",
					queryVal: "/dataCheck/recording/list2"
				} ],
			parameter: [
				{
					columnCode: "sampleCode",
					columnName: "样品编号",
					columnWidth: "140px"
				}, {
					columnCode: "departName",
					columnName: "检测机构",
					show: 0
				}, {
					columnCode: "pointName",
					columnName: "检测点",
					show: 0
				}, {
					columnCode: "regName",
					columnName: "委托单位",
					query: 1
				}, {
					columnCode: "foodName",
					columnName: "样品名称",
					query: 1
				},  {
					columnCode: "purchaseAmount",
					columnName: "进货数量(KG)",
					show: showPurchaseNumber,
					columnWidth: "120px"
				}, {
					columnCode: "itemName",
					columnName: "检测项目",
					query: 1
				}, {
					columnCode: "checkResult",
					columnName: "检测值",
					columnWidth: "80px",
					sortDataType:"float"
				}, {
					columnCode: "conclusion",
					columnName: "检测结果",
					columnWidth: "80px",
					query: 1,
					queryType: 2,
					customVal: {
						"合格": "<span class=\"text-success\">合格</span>",
						"不合格": "<span class=\"text-danger\">不合格</span>"
					}
				}, {
					columnCode: "checkDate",
					columnName: "检测时间",
					columnWidth: "100px",
					dateFormat: "yyyy-MM-dd HH:mm:ss",
					query: 1,
					queryCode: "checkDate",
					queryName: "检测日期",
					queryDateFormat: "yyyy-MM-dd",
					queryType: 3,
					sortDataType:"date"
				}, {
					columnCode: "checkUsername",
					columnName: "检测人员",
					columnWidth: "100px"
				} ],
			funBtns: [ { //查看按钮
				show: Permission.exist("1463-1"),
				style: Permission.getPermission("1463-1"),
				action: function(id, row) {
					showMbIframe('${webRoot}' + "/dataCheck/recording/checkDetail.do?id=" + id);
				}
			}, {
				//删除按钮
				show: Permission.exist("1463-2"),
				style: Permission.getPermission("1463-2"),
				action: function(rid, row) {
					$("#deleteModal input[name='rid']").val(row.id);
					$("#deleteModal input[name='foodName']").val(row.foodName);
					$("#deleteModal input[name='itemName']").val(row.itemName);
					$("#deleteModal textarea[name='param4']").val("");
					$("#deleteModal").modal('toggle');
				}
			} ],
			bottomBtns: [ {//导出
				show: Permission.exist("1463-3"),
				style: Permission.getPermission("1463-3"),
				action: function(ids) {
					//检测结果数量 > 300000
					if (dgu.datagridOption.rowTotal && dgu.datagridOption.rowTotal>300000) {
						$("#confirm-warnning .tips").text("每次导出数据不能大于30万条");
						$("#confirm-warnning").modal('toggle');
					}else {
						$("#exportModal").modal('toggle');
					}
				}
			} ],
			before: function(queryType){
				//高级搜索
				if(queryType == 0){
					//清除时间范围查询条件
					dgu.delDefaultCondition("checkDateStartDateStr");
					dgu.delDefaultCondition("checkDateEndDateStr");
				}

				//设置监管对象类型
				if ($("#regType option:first").val()) {
					dgu.addDefaultCondition("regTypeId", $("#regType option:first").val());
				} else {
					dgu.delDefaultCondition("regTypeId");
				}
			},
		});
		dgu.queryByFocus();
	}

	//更改检测结果
	var sf = $("#modifiedForm").Validform({
		tiptype:2,
		ajaxPost:true,
		callback:function(data){
			$.Hidemsg();
			if(data && data.success){
				$("#modifiedModal").modal("toggle");
				dgu.queryByFocus();
			}else{
				$("#confirm-warnning .tips").text(data.msg);
				$("#confirm-warnning").modal('toggle');
			}
		}
	});
	$(document).on("click","#submit1",function(){
		sf.ajaxPost();
	});

	//删除检测结果
	var df = $("#deleteForm").Validform({
		tiptype:2,
		ajaxPost:true,
		callback:function(data){
			$.Hidemsg();
			$("#deleteModal").modal("toggle");
			if(data && data.success){
				dgu.queryByFocus();
			}else{
				$("#confirm-warnning .tips").text(data.msg);
				$("#confirm-warnning").modal('toggle');
			}
		}
	});
	$(document).on("click","#submit2",function(){
		df.ajaxPost();
	});
	//查看复检记录
	$(document).on("click", ".reloadCount", function () {
		var id = $(this).parents(".rowTr").attr("data-rowid");
		var sampleCode= $(this).parents(".rowTr").find(".sampleCode").html();
		/*var sampleCode = "";
		var d = dgu.getData();
		if (d) {
			for (var i=0; i<d.length; i++) {
				var d0 = d[0];
				if (d0.id = id) {
					sampleCode = d0.sampleCode
					break;
				}
			}
		}*/
		var returnURL = encodeURI("${webRoot}/dataCheck/unqualified/history?id=" + id + "&sampleCode=" + sampleCode);
		showMbIframe(returnURL);
	});
	</script>
</body>
</html>
