<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/common/resource.jsp"%>
<html>
<head>
<title>快检服务云平台</title>
	<style>
	html input[disabled]{
		background: #eee;
	}
	</style>
</head>
<body>
	<div id="dataList"></div>
	<!-- 更改检测结果 -->
	<div class="modal fade intro2" id="modifiedModal" tabindex="-1" role="dialog" aria-labelledby="modifiedModalLabel">
		<div class="modal-dialog cs-lg-width" role="document">
			<div class="modal-content ">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
					<h4 class="modal-title" id="modifiedModalLabel">修改检测结果</h4>
				</div>
				<div class="modal-body cs-lg-height">
					<div class="cs-tabcontent" >
						<div class="cs-content2">
							<form id="modifiedForm" method="post" action="">
								<input type="hidden" name="id">
								<table class="cs-add-new">
									<tr  >
										<td class="cs-name">样品编号：</td>
										<td class="cs-in-style" colspan="2">
											<input  type="text" class="disabled-style" name="sampleNo" disabled="disabled"/>
										</td>

									</tr>
									<tr>
										<td class="cs-name">检测机构：</td>
										<td class="cs-in-style" colspan="2">
											<input  type="text" class="disabled-style"  name="officeName" disabled="disabled"/>
										</td>
									</tr>
									<tr>
										<td class="cs-name">检测点：</td>
										<td class="cs-in-style" colspan="2">
											<input  type="text" class="disabled-style"  name="useUnitName" disabled="disabled"/>
										</td>
									</tr>
									<tr>
										<td class="cs-name">样品类型：</td>
										<td class="cs-in-style" colspan="2">
											<input  type="text" class="disabled-style"  name="itemInfoTypeName" disabled="disabled"/>
										</td>
									</tr>
									<tr>
										<td class="cs-name"><i class="cs-mred">*</i>样品名称：</td>
										<td class="cs-in-style">
											<input  type="text" name="fname" placeholder="请输入样品名称" autocomplete="off" datatype="*" nullmsg="请输入样品名称" errormsg="请输入样品名称"/>
										</td>
                                        <td class="cs-text-nowrap username-wrong">
                                            <div class="Validform_checktip"></div>
                                        </td>
									</tr>
									<tr>
										<td class="cs-name">检测项目：</td>
										<td class="cs-in-style" colspan="2">
											<input  type="text" class="disabled-style" name="testProName" disabled="disabled"/>
										</td>
									</tr>
									<tr>
										<td class="cs-name"><i class="cs-mred">*</i>检测结果：</td>
										<td class="cs-in-style">
											<input type="text" name="contents" placeholder="请输入检测值" autocomplete="off" datatype="*" nullmsg="请输入检测值" errormsg="请输入正确检测值"/>&nbsp;
										</td>
										<td class="cs-text-nowrap username-wrong">
											<div class="Validform_checktip"></div>
										</td>
									</tr>
									<tr>
										<td class="cs-name"><i class="cs-mred">*</i>检测结论：</td>
										<td class="cs-in-style" colspan="2">
											<select name="testResult">
												<option>合格</option>
												<option>不合格</option>
											</select>
										</td>
									</tr>
									<tr>
										<td class="cs-name"><i class="cs-mred">*</i>检测时间：</td>
										<td class="cs-in-style">
											<input name="testTime" class="cs-time" type="text" onClick="WdatePicker({startDate:'%y-%M-%d %H:%m:%s',maxDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
												   datatype="*" nullmsg="请选择检测时间" errormsg="请选择检测时间"/>
										</td>
										<td class=" cs-text-nowrap username-wrong">
											<div class="Validform_checktip"></div>
										</td>
									</tr>
                                    <%--
									<tr>
										<td class="cs-name"><i class="cs-mred">*</i>备注：</td>
										<td class="cs-in-style">
                                            <input type="text" name="remarks" placeholder="请输入备注" autocomplete="off" datatype="*" nullmsg="请输入备注" errormsg="请输入备注"/>&nbsp;
										</td>
                                        <td class="cs-text-nowrap username-wrong">
                                            <div class="Validform_checktip"></div>
                                        </td>
									</tr>
                                    --%>
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
						<img src="${webRoot}/img/warn.png" width="40px" />确认重置同步状态？
					</div>
				</div>
				<div class="modal-footer">
					<a class="btn btn-danger btn-ok" onclick="resetUploadStatus()">确认</a>
					<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
				</div>
			</div>
		</div>
	</div>
	<%@include file="/WEB-INF/view/common/confirm.jsp"%>
	<%@include file="/WEB-INF/view/common/exportDialog.jsp"%>
	<%@include file="/WEB-INF/view/common/exportStandingBook.jsp"%>
	<%@include file="/WEB-INF/view/common/modalBox.jsp"%>
	<%@include file="/WEB-INF/view/ledger/regulatoryObject/selectRegType.jsp"%>
	<script src="${webRoot}/js/datagridUtil2.js"></script>
	<script type="text/javascript">

	/********************************************************** 智云达检测数据 **********************************************************/
	var csd = '${start}';
	var ced = '${end}';

	var permission0 = JSON.parse(JSON.stringify(Permission.getPermission("1508-3")));
	if (permission0) {
		permission0.operationName = "重置全部数据";
	}

    //表单验证
    var modifiedFormVlf = $("#modifiedForm").Validform({
        tiptype : 2,
        beforeSubmit : function() {
            lock = false;
            var formData = new FormData($('#modifiedForm')[0]);
            $.ajax({
                type: "POST",
                url: syncDataUrl+"/zydCheckData/modifiedData.do",
                data: formData,
                contentType: false, //必须false才会避开jQuery对 formdata 的默认处理 XMLHttpRequest会对 formdata 进行正确的处理
                processData: false, //必须false才会自动加上正确的Content-Type
                dataType: "json",
                success: function (data) {
                    if (data && data.success) {
                        dgu.queryByFocus();
                        $("#modifiedModal").modal('hide');
                    } else {
                        $("#confirm-warnning .tips").text(data.msg);
                        $("#confirm-warnning").modal('toggle');
                    }
                }
            });
            return false;
        }
    });

	var dgu;
	//抽样单检测数据
	if ('${dataType}' == 0) {
		dgu = datagridUtil.initOption({
			tableId: "dataList",
			tableAction: syncDataUrl+"/zydCheckData/datagrid.do",
			funColumnWidth: "80px",
			tableBar: {
				title: ["检测数据","检测结果"],
				ele: [
				{
					eleShow: 1,
					eleTitle: "状态",
					eleName: "dyStatus",
					eleType: 2,
					eleOption: [{"text":"--全部--","val":""},{"text":"暂存","val":"1"},{"text":"成功","val":"2"},{"text":"失败","val":"3"}],
					eleStyle: "width:85px;"
				},{
					eleShow: 1,
					eleTitle: "检测日期",
					eleName: "query",
					eleType: 3,
					eleStyle: "width:110px;",
					eleDefaultDateMin: (!csd ? new newDate().DateAdd("m",-1).format("yyyy-MM-dd") : csd),
					eleDefaultDateMax: (!ced ? new newDate().format("yyyy-MM-dd") : ced)
				},{
					eleShow: 1,
					eleName: "keyWords",
					eleType: 0,
					elePlaceholder: "样品编号、机构、检测点、市场"
				}],
				init: function(){
					//默认查询同步失败数据
					//$("#dataList select[name='dyStatus']").val("3");
				},
				switchSearch: function(queryType){
					if (queryType == 0) {
						$("#dataList_testTimeStartDateInput").val($("#dataListtestTimeStart").val());
						$("#dataList_testTimeEndDateInput").val($("#dataListtestTimeEnd").val());
					} else {
						$("#dataListtestTimeStart").val(newDate($("#dataList_testTimeStartDateInput").val()).format("yyyy-MM-dd"));
						$("#dataListtestTimeEnd").val(newDate($("#dataList_testTimeEndDateInput").val()).format("yyyy-MM-dd"));
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
				} ],
			parameter: [
				{
					columnCode: "sampleNo",
					columnName: "样品编号",
					columnWidth: "94px",
					query: 1,
					queryCode: "sampleNo",
					//吉安平台隐藏此列
					show: (window.location.hostname == 'ja.chinafst.cn'? 0 : 1)
				},
				/*{
					columnCode: "areaName",
					columnName: "区域名称",
					queryCode: "areaName",
					query: 1
				}, */
				{
					columnCode: "officeName",
					columnName: "检测机构",
                    columnWidth: "8%",
					queryCode: "officeName",
					query: 1
				}, {
					columnCode: "useUnitName",
					columnName: "检测点",
					queryCode: "useUnitName",
					query: 1
				}, {
					columnCode: "reserve1",
					columnName: "检测地址",
					queryCode: "reserve1",
					columnWidth: "10%",
					query: 1
				// }, {
				// 	columnCode: "itemInfoTypeName",
				// 	columnName: "样品类型"
				}, {
					columnCode: "fname",
					columnName: "样品名称",
					query: 1
				}, {
					columnCode: "testProName",
					columnName: "检测项目",
					query: 1
				}, {
					columnCode: "contents",
					columnName: "检测值",
					columnWidth: "75px",
                    sortDataType:"float"
				}, {
					columnCode: "testResult",
					columnName: "检测结果",
					columnWidth: "75px",
					query: 1,
					queryType: 2,
					customVal: {
						"合格": "<div class=\"text-success\">合格</span>",
						"不合格": "<div class=\"text-danger\">不合格</span>",
						"default": "#testResult#"
					}
				}, {
					columnCode: "testTime",
					columnName: "检测时间",
					columnWidth: "90px",
					dateFormat: "yyyy-MM-dd HH:mm:ss",
					query: 1,
					queryCode: "testTime",
					queryName: "检测日期",
					queryDateFormat: "yyyy-MM-dd",
					queryType: 3,
                    sortDataType:"date"
				/*}, {
					columnCode: "testPerson",
					columnName: "检测人员",
					columnWidth: "80px"*/
				}, {
					columnCode: "dyDownloadTime",
					columnName: "下载时间",
					columnWidth: "90px",
					dateFormat: "yyyy-MM-dd HH:mm:ss",
					queryType: 3,
					sortDataType:"date"
				},
				/*{
					columnCode: "dyDealTime",
					columnName: "处理时间",
					columnWidth: "90px",
					dateFormat: "yyyy-MM-dd HH:mm:ss",
					queryType: 3,
					sortDataType:"date"
				},*/
				{
					queryType: 2,
					columnCode: "dyStatus",
					columnName: "状态",
					query: 1,
					columnWidth: "55px",
					/*customVal: {"1":"暂存","2":"成功","3":"失败"}*/
					customVal: {
						"1":"暂存",
						"2": "<div class=\"text-success\">成功</span>",
						"3": "<a class=\"text-danger\" href=\"javascript:;\" title=\"#dyReason#\">失败</a>"
					}
				}  ],
			funBtns: [{
				show: Permission.exist("1508-1"),
				style: Permission.getPermission("1508-1"),
				action: function(id, row) {
					showMbIframe('${webRoot}' + "/dataCheck/recording/checkDetail_zyd.do?id=" + id);
				}
			}, {
				//更改检测结果
				show: Permission.exist("1508-2"),
				style: Permission.getPermission("1508-2"),
				action: function(id, row) {
                    modifiedFormVlf.resetForm();
                    modifiedFormVlf.resetStatus();
					$("#modifiedForm input[name=id]").val(row.id);
					$("#modifiedForm input[name=sampleNo]").val(row.sampleNo);
					$("#modifiedForm input[name=officeName]").val(row.officeName);
					$("#modifiedForm input[name=useUnitName]").val(row.useUnitName);
					$("#modifiedForm input[name=itemInfoTypeName]").val(row.itemInfoTypeName);
					$("#modifiedForm input[name=fname]").val(row.fname);
					$("#modifiedForm input[name=testProName]").val(row.testProName);
					$("#modifiedForm input[name=contents]").val(row.contents);
					$("#modifiedForm select[name=testResult]").val(row.testResult);
					$("#modifiedForm input[name=testTime]").val(newDate(row.testTime).format("yyyy-MM-dd HH:mm:ss"));
					// $("#modifiedForm input[name=remarks]").val(row.remarks);
					$("#modifiedModal").modal("show");
				}
			}, {
				//重置上传状态
				show: Permission.exist("1508-3"),
				style: Permission.getPermission("1508-3"),
				action: function(id, row) {
					resetUploadId = id;
					$("#resetUploadStatusConfirm").modal('toggle');
				}
			}],
			bottomBtns: [
			{//重置上传状态
				show: Permission.exist("1508-3"),
				style: Permission.getPermission("1508-3"),
				action: function(ids) {
					resetUploadId = ids;
					$("#resetUploadStatusConfirm").modal('toggle');
				}
			},
			{//重置失败数据上传状态
				show: Permission.exist("1508-3"),
				style: permission0,
				action: function(ids) {
					resetUploadId = "";
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
			}
		});
		dgu.queryByFocus();
	}
	//修改检测结果
	$("#submit1").on("click", function() {
		lock = true;
		if (lock) {
			//提交表单前设置内容
			$("#modifiedForm").submit();
		}
		return false;
	});
	//重置上传状态
	function resetUploadStatus() {
		$.ajax({
			type: "POST",
			url: syncDataUrl+"/zydCheckData/resetDyStatus.do",
			data: {
				"id": resetUploadId+""
			},
			success: function(data) {
				if (data && data.success) {
					dgu.queryByFocus();
				}
			},
			error: function() {
				console.log("重置上传状态失败!");
			}
		});
		$("#resetUploadStatusConfirm").modal('toggle');
	}
	</script>
</body>
</html>
