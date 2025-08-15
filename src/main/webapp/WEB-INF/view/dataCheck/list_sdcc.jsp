<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/common/resource.jsp"%>
<html>
<head>
<title>快检服务云平台</title>
	<style>
		.text-over{
			display: block;
			width:90px;
			overflow: hidden;
			text-overflow: ellipsis;
			white-space: nowrap;
		}
	</style>
</head>
<body>
	<div id="dataList"></div>

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

	<!-- Modal 提示窗-立即上传状态-->
	<div class="modal fade intro2" id="uploadConfirm" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
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
						<img src="${webRoot}/img/warn.png" width="40px" />确认上传数据？
					</div>
				</div>
				<div class="modal-footer">
					<a class="btn btn-danger btn-ok" onclick="upload()">确认</a>
					<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
				</div>
			</div>
		</div>
	</div>

	<%@include file="/WEB-INF/view/common/confirm.jsp"%>
	<%@include file="/WEB-INF/view/common/modalBox.jsp"%>
	<%@include file="/WEB-INF/view/ledger/regulatoryObject/selectRegType.jsp"%>
	<script src="${webRoot}/js/datagridUtil2.js"></script>
	<script type="text/javascript">
		var resetUploadId, uploadId;
		var dgu = datagridUtil.initOption({
			tableId: "dataList",
			tableAction: "${webRoot}/dataCheck/recording/datagrid.do?refrel=/dataCheck/recording/list.do",
			tableBar: {
				title: ["检测数据","山东菜场"],
				ele: [{
					eleTitle: "被检单位",
					eleName: "regId",
					eleType: 2,
					eleOption: JSON.parse('${regsSel}'),
					eleStyle: "width:100px;"
				},{
					eleTitle: "状态",
					eleName: "param2",
					eleType: 2,
					eleOption: [{"text":"--全部--","val":""},{"text":"未上传","val":"0"},{"text":"上传成功","val":"1"},{"text":"上传失败","val":"2"}],
					eleStyle: "width:100px;"
				},{
					eleShow: 1,
					eleTitle: "检测日期",
					eleName: "checkDate",
					eleType: 3,
					eleStyle: "width:110px;",
					eleDefaultDateMin: new newDate().DateAdd("m",-1).format("yyyy-MM-dd"),
					eleDefaultDateMax: new newDate().format("yyyy-MM-dd")
				},{
					eleShow: 1,
					eleName: "keyWords",
					eleType: 0,
					elePlaceholder: "样品编号、机构、检测点、市场"
				}],
				switchSearch: function(queryType){
					if (queryType == 0) {
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
					queryCode: "regIdsStr",
					queryVal: '${regIdsStr}'
				} ],
			parameter: [
				{
				// 	columnCode: "sampleCode",
				// 	columnName: "样品编号",
				// 	columnWidth: "94px",
				// 	//吉安平台隐藏此列，lz云服务隐藏此列
				// 	show: ((window.location.hostname == 'ja.chinafst.cn'||window.location.hostname == 'lz.chinafst.cn')? 0 : 1)
				// }, {
				// 	columnCode: "departName",
				// 	columnName: "检测机构",
				// 	queryCode: "departName",
				// 	query: 1
				// }, {
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
					columnWidth: "80px",
					sortDataType:"float"
				}, {
					columnCode: "conclusion",
					columnName: "检测结果",
					columnWidth: "80px",
					query: 1,
					queryType: 2,
					customVal: {
						"合格": "<div class=\"text-success\">合格</span>",
						"不合格": "<div class=\"text-danger\">不合格</span>"
					}
				}, {
					columnCode: "checkDate",
					columnName: "检测时间",
					columnWidth: "90px",
					dateFormat: "yyyy-MM-dd HH:mm:ss",
					queryCode: "checkDate",
					queryName: "检测日期",
					queryDateFormat: "yyyy-MM-dd",
					query: 1,
					queryType: 3,
					sortDataType:"date"
				}, {
					columnCode: "param2",
					columnName: "状态",
					customVal: {"0":"未上传","1":"<a title=\"上传时间：#time1#\">成功</a>","2":"<a title=\"上传时间：#time1#\">失败</a>"},
					columnWidth: "80px",
					query: 1,
					queryType: 2
				}, {
					columnCode: "param5",
					columnName: "失败原因",
					columnWidth: "100px",
					customElement: "<a title=\"?\" class=\"text-over\">?</a>"
				} ],
			funBtns: [{
				show: Permission.exist("311-1"),
				style: Permission.getPermission("311-1"),
				action: function(id, row) {
					showMbIframe('${webRoot}' + "/dataCheck/recording/checkDetail.do?id=" + id);
				}
			}, {
				//重置上传状态
				show: Permission.exist("1521-1"),
				style: Permission.getPermission("1521-1"),
				action: function(id, row) {
					resetUploadId = id;
					$("#resetUploadStatusConfirm").modal('toggle');
				}
			}, {
				//立即上传
				show: Permission.exist("1521-2"),
				style: Permission.getPermission("1521-2"),
				action: function(id, row) {
					uploadId = id;
					$("#uploadConfirm").modal('toggle');
				}
			} ],
			bottomBtns: [ {
				//重置上传状态
				show: Permission.exist("1521-1"),
				style: Permission.getPermission("1521-1"),
				action: function(ids) {
					resetUploadId = ids;
					$("#resetUploadStatusConfirm").modal('toggle');
				}
			}, {
				//立即上传
				show: Permission.exist("1521-2"),
				style: Permission.getPermission("1521-2"),
				action: function(ids) {
					uploadId = ids;
					$("#uploadConfirm").modal('toggle');
				}
			} ],
			onload: function(obj, pageData){
				$(".rowTr").each(function(){
					for(var i=0;i<obj.length;i++){
						if($(this).attr("data-rowId") == obj[i].id){
							if(obj[i].param2=="1"){//上传成功，隐藏上传按钮
								$(this).find(".1521-2").hide();
							}
							break;
						}
					}
				});
			},
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

		//重置上传状态
		function resetUploadStatus() {
			$.ajax({
				type: "POST",
				url: "${webRoot}/dataCheck/recording/resetUploadStatus",
				data: {
					"id": resetUploadId+""
				},
				success: function(data) {
					if (data && data.success) {
						dgu.query();
					}
				},
				error: function() {
					console.log("重置上传状态失败!");
				}
			});
			$("#resetUploadStatusConfirm").modal('toggle');
		}

		//立即上传
		function upload() {
			$.ajax({
				type: "POST",
				url: "${webRoot}/od/sdccUploadData",
				data: {
					"id": uploadId+""
				},
				success: function(data) {
					if (data && data.success) {
						dgu.query();
					}
				},
				error: function() {
					console.log("上传失败!");
				}
			});
			$("#uploadConfirm").modal('toggle');
		}
	</script>
</body>
</html>
