<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/common/resource.jsp"%>
<html>
<head>
<title>快检服务云平台</title>
<style>
	#dataList_detectItem .cs-bottom-tools{
	position:absolute;
	bottom:0;
}
</style>

</head>
<body>
	<div id="dataList"></div>

	<!-- 选择检测项目模态框 start -->
	<div class="modal fade intro2" id="myModal2" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
		<div class="modal-dialog cs-lg-width" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title">请选择检测项目</h4>
				</div>
				<div class="modal-body cs-lg-height" style="overflow:hidden;">
					<div id="dataList_detectItem" style="overflow: auto;width:100%;height:300px;"></div>
				</div>
					<div class="modal-footer">
							<button type="button" class="btn btn-success" id="btnSave">确定</button>
							<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					</div>
			</div>
		</div>
	</div>
	<!-- 选择检测项目模态框 end -->
	<!-- 编辑检测项目参数 start -->
	<div class="modal fade intro2" id="editModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
		<div class="modal-dialog cs-mid-width" role="document">
			<div class="modal-content ">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">编辑</h4>
				</div>
				<div class="modal-body cs-mid-height">
					<!-- 主题内容 -->
					<div class="cs-tabcontent">
						<div class="cs-content2">
							<form id="saveForm" method="post" action="${webRoot}/data/foodType/detectItem/save.do">
								<input type="hidden" name="id">
								<table class="cs-add-new" style="">
									<tr>
										<td class="cs-name"><i class="cs-mred">*</i>使用默认值：</td>
										<td class="cs-in-style cs-radio"><input id="cs-check-radio" type="radio" value="0" name="useDefault"
											checked="checked" onclick="setingDefault('0')" /><label for="cs-check-radio">是</label> <input id="cs-check-radio2"
											type="radio" value="1" name="useDefault" onclick="setingDefault('1')" /><label for="cs-check-radio2">否</label></td>
									</tr>
									<tr>
										<td class="cs-name"><i class="cs-mred">*</i>检测项目：</td>
										<td class="cs-in-style"><input type="text" name="detectName" autofocus disabled="disabled"></td>
									</tr>
									<tr>
										<td class="cs-name"><i class="cs-mred">*</i>判定符号：</td>
										<td class="cs-in-style"><select class="cs-in-style isDisabled" id="checkSign" name="detectSign">
												<option value="&gt;">&gt;</option>
												<option value="&lt;">&lt;</option>
												<option value="&ge;">&ge;</option>
												<option value="&le;">&le;</option>
										</select></td>
									</tr>
									<tr>
										<td class="cs-name"><i class="cs-mred">*</i>检测标准值：</td>
										<td class="cs-in-style"><input type="text" name="detectValue" class="isDisabled" autofocus disabled="disabled"
											datatype="*,/^\d*\.{0,1}\d*$/" nullmsg="请输入标准值" errormsg="请输入数字类型"></td>
									</tr>
									<tr>
										<td class="cs-name"><i class="cs-mred">*</i>检测单位：</td>
										<td class="cs-in-style"><input type="text" name="detectValueUnit" class="isDisabled" autofocus disabled="disabled"
											datatype="*" nullmsg="请输入检测单位" errormsg="请输入检测单位"></td>
									</tr>
								</table>
							</form>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button class="btn btn-success" id="detectItem_btnSave">确定</button>
					<button class="btn btn-default" data-dismiss="modal" aria-hidden="true" id="btnCancel">关闭</button>
				</div>
			</div>
		</div>
	</div>
	<!-- 编辑检测项目参数 end -->

	<div class="modal fade intro2" id="confirm-sure" data-rowId="0" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog cs-alert-width">
			<div class="modal-content">
				<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
				        <h4 class="modal-title">确认提交</h4>
				</div>
				<div class="modal-body cs-alert-height cs-dis-tab">
					<div class="cs-text-algin" style="margin-left:-10px;">
					<img src="${webRoot}/img/sure.png" width="40px" alt="" />该类的子类也会继承已选择的检测项目
					</div>
				</div>
				<div class="modal-footer">
					<a class="btn btn-success btn-ok" onclick="BaseFood()">提交</a>
					<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
				</div>
			</div>
		</div>
	</div>
    <%@include file="/WEB-INF/view/common/confirm.jsp"%>
	<script src="${webRoot}/js/datagridUtil2.js"></script>
	<script type="text/javascript">
		var demo;

		rootPath="${webRoot}/data/foodType/detectItem/";
		if("${foodId.isfood}"=="0"){//类别
				$(".deleteChilds").removeClass("cs-hide");
		} else {
				$(".deleteChilds").addClass("cs-hide");
		}
		 function BaseFood() {
			var peakhours = document.getElementsByName("rowCheckBox");
			var detectItemList = "";
			for (var i = 0; i < peakhours.length; i++) {
				if (peakhours[i].checked || $(peakhours[i]).attr("checked")) {
					detectItemList += peakhours[i].value + ',';
				}
			}
			if (detectItemList != '') {//选择检测项目，写入数据库
				detectItemList = detectItemList.substr(0, detectItemList.length - 1);
				$.ajax({
					type : "POST",
					url : "addDetectItem.do",
					data : {
						"detectItemList" : detectItemList,
						"foodId" : "${foodId.id}"
					},
					dataType : "json",
					async : false,
					success : function(result) {
						if (result.success) {
							$('#myModal2').modal('hide');
						}
					}
				});
			}
			if($("#confirm-sure").attr("data-rowId")==1){
				$("#confirm-sure").modal('toggle');
			}
		}

		$(function() {

			if($("#isExtends").val()==1){
  				$("[name=isExtends]").prop("checked","checked");
  		  	}

			demo = $("#saveForm").Validform({
				callback : function(data) {
					$.Hidemsg();
					if (data.success) {
						$("#editModal").modal("hide");
						dgu1.queryByFocus();
					} else {
						$.Showmsg(data.msg);
					}
				}
			});
			$("#detectItem_btnSave").on("click", function() {
				demo.ajaxPost();
				return false;
			});
			//选择检测项目
			$("#btnSave").on("click", function() {
				$.ajax({
					url : "${webRoot}/data/foodType/detectItem/querylength.do",
					type : "POST",
					data : {
						"foodId" : "${foodId.id}"
					},
					dataType : "json",
					success : function(data) {
						if (data.obj>1) {
							$("#confirm-sure").attr("data-rowId",1);
							$("#confirm-sure").modal('toggle');
						}else{
							BaseFood();
						}
					},
					error : function() {
						$("#confirm-warnning").modal('toggle');
					}
				});
			});

			//关闭编辑模态框时，重置参数
			$('#myModal2').on('hidden.bs.modal', function(e) {
				$.Hidemsg();
				dgu1.queryByFocus();
			});
		});

		var dgu1 = datagridUtil.initOption({
			tableId : "dataList",
			tableAction : "${webRoot}/data/foodType/detectItem/datagrid.do",
			defaultCondition: [{
				queryCode: "baseBean.foodId",
				queryVal: "${foodId.id}"
			}],
			tableBar: {
				title: ["数据中心","食品分类","食品种类/食品名称:${foodId.foodName}"],
				hlSearchOff: 0,
				ele: [{
					eleShow: 1,
					eleName: "keyWords",
					eleType: 0,
					elePlaceholder: "请输入检测项目"
				}],
				topBtns: [{
					//添加检测项目
					show: Permission.exist("413-3"),
					// style: Permission.getPermission("413-3"),
					style: {"functionIcon":"icon iconfont icon-zengjia","operationName":"添加检测项目"},
					action: function(ids, rows){
						initModal();
						$('#myModal2').modal('show');
					}
				},{
					//返回
					show: 1,
					style: {"functionIcon":"icon iconfont icon-fanhui","operationName":"返回"},
					action: function(ids, rows){
						parent.hideIframe();
					}
				}]
			},
			parameter : [
				{
					columnCode : "detectName",
					columnName : "检测项目"
				}, {
					columnCode : "standardName",
					columnName : "检测标准"
				}, {
					columnCode : "detectStandardValue",
					columnName : "检测标准值"
				}
			],
			funBtns : [
				{
					show: Permission.exist("413-2"),
					style: Permission.getPermission("413-2"),
					action : function(id) {
						$("#editModal").modal("show");
						getId(id);
					}
				},
				{
					show: Permission.exist("413-10"),
					style: Permission.getPermission("413-10"),
					action: function(id){
						$(".choseOptions").prop("checked",false);
						idsStr="{\"ids\":\""+id.toString()+"\",\"foodIds\":\"${foodId.id}\",\"isDeleteChild\":\"\"}";
						$("#confirm-delete3").modal('toggle');
					}
				}
			],
			bottomBtns: [
				{ //删除函数
					show: Permission.exist("413-10"),
					style: Permission.getPermission("413-10"),
					action : function(ids) {
					    if(ids&&ids.length>0){
                            $(".choseOptions").prop("checked",false);
                            idsStr="{\"ids\":\""+ids.toString()+"\",\"foodIds\":\"${foodId.id}\",\"isDeleteChild\":\"\"}";
                            $("#confirm-delete3").modal('toggle');
						}else{
                            $("#waringMsg>span").html("请至少选择一条检测项目");
                            $("#confirm-warnning").modal('toggle');
						}

					}
				},
				 {	//导出函数
					show: Permission.exist("413-6"),
					style: Permission.getPermission("413-6"),
					action: function(ids){
						//alert("导出");
					}
			    }
			]
		});
		dgu1.queryByFocus();

		/**
		 * 查询检测标准信息
		 */
		function getId(e) {
			var id = e;
			$.ajax({
				url : "${webRoot}/data/foodType/detectItem/queryById.do",
				type : "POST",
				data : {
					"id" : id
				},
				dataType : "json",
				success : function(data) {
					var form = $('#saveForm');
					form.form('load', data.obj);
					setingDefault(data.obj.useDefault);//设置input是否可编辑
					$("[name=checked][value=" + data.obj.checked + "]").prop("checked", "checked");
				},
				error : function() {
					alert("操作失败");
				}
			})
		}
		/**
		 * 启用或禁用默认值
		 * @param e检测标准UUID
		 * @returns
		 */
		function setingDefault(e) {
			if (e == "0") {
				$(".isDisabled").attr("disabled", "disabled");
				$("input[name='useDefault']").eq(0).attr("checked", "checked");
				/* $.ajax({
					url : "${msUrl}/data/items/getId.do",
					type : "POST",
					dataType : "json",
					data : {"id":$("[name=detectIdStr]").val()},
					success : function(data) {
					 	  if(data.success==true){//添加成功，重新加载数据
					 		 $('#myModal').modal();
							 var form=$('#saveForm');//加载数据
							 $("#checkSign").val(data.data.checkSign);
							 $("[name=checkValue]").val(data.data.checkValue);
							 $("[name=checkValueunt]").val(data.data.checkValueUnit);
				    	  }
						},
						error:function(){
							dy.alert('提示','操作失败','error')
						}
					}) */
			} else {
				$("input[name='useDefault']").eq(1).attr("checked", "checked");
				$(".isDisabled").removeAttr("disabled");

			}
		}
		//初始化检测项目选择模态框
		function initModal() {
			var dgu2 = datagridUtil.initOption({
				tableId : "dataList_detectItem",
				tableAction : "${webRoot}/data/detectItem/datagrid.do?foodId=${foodId.id}",
				defaultCondition: [{
					queryCode: "baseBean.foodId",
					queryVal: "${foodId.id}"
				}],
				tableBar: {
					title: [],
					hlSearchOff: 0,
					ele: [{
						eleShow: 1,
						eleName: "keyWords",
						eleType: 0,
						elePlaceholder: "请输入检测项目"
					}]
				},
				parameter : [
					{
						columnCode : "detectItemName",
						columnName : "检测项目",
						query : 1
					}, {
						columnCode : "stdCode",
						columnName : "检测标准",
						query : 1
					}, {
						columnCode : "checkStandardValue",
						columnName : "检测标准值",
						query : 1
					}]
			});
			dgu2.queryByFocus();
		}
		function deleteData3() {
			var obj=JSON.parse(idsStr);
			obj.isDeleteChild=$(".choseOptions").is(":checked");
			//console.log(idsStr);
		    $.ajax({
		        type: "POST",
		        url: rootPath + "/delete.do",
		        data: obj,
		        dataType: "json",
		        success: function (data) {
		            $("#confirm-delete3").modal('toggle');
		            if (data && data.success) {
		                //删除成功后刷新列表
						dgu1.queryByFocus();
		            } else {
		                $("#waringMsg>span").html(data.msg);
		                $("#confirm-warnning").modal('toggle');
		            }
		        },
		        error: function (data) {
		            $("#confirm-warnning").modal('toggle');
		        }
		    });
		}
		//绑定回车事件
		//document.onkeydown = keyDownSearch;
	</script>
</body>
</html>
