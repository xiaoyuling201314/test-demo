<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 根据样品选择检测项目 - 窗口（任务管理专用）、单选 -->
<div class="modal fade" id="myDetectItemModal"  role="dialog" aria-labelledby="myModalLabel" data-backdrop="static">
	<div class="modal-dialog cs-mid-width" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title">选择检测项目</h4>
			</div>
			<div class="modal-body cs-mid-height">
<%--				<select id="itemSelect2" class="js-example-basic-single" name="state" style="width:100%;">--%>
<%--					<option value="">--请选择检测项目--</option>--%>
<%--				</select>--%>
				<ul id="myDetectItemTree" class="easyui-tree"></ul>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-success" onclick="detectItemConfirm();">确定</button>
				<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
			</div>
		</div>
	</div>
</div>
<!-- JavaScript -->
<script type="text/javascript">
	$(document).ready(function() { 
		// $('#itemSelect2').select2();
		//
		// $('#myDetectItemModal').on('show.bs.modal', function () {
		// 	$("#itemSelect2").val("").select2();
		// });
		
		$('#myDetectItemModal').on('hide.bs.modal', function () {
			// $('.js-example-basic-single').select2({
			// 	closeOnSelect: true
			// });
		});

	});
	var itemNodeId = "";
	var itemNodeText = "";

	$(function() {
		//检测项目
		$('#myDetectItemTree').tree({
			checkbox : true,
			url : "${webRoot}/data/detectItem/getDetectItemTree2",
			onClick : function(node) {
				if(node.checked){//取消选中
					$(this).tree("uncheck",node.target)
				}else{//选中
					$(this).tree("check",node.target)
				}
			}
		});
		
	});
	
	//根据食品种类ID重新加载检测项目选项
	function myReload(foodId){
		//树
		$('#myDetectItemTree').tree('options').url = "${webRoot}/data/detectItem/getDetectItemTree2?foodId="+foodId;
		$('#myDetectItemTree').tree('reload');
		
		<%--//检索框--%>
		<%--$.ajax({--%>
	    <%--    type: "POST",--%>
	    <%--    url: "${webRoot}/data/detectItem/queryItemsByFoodId.do?foodId="+foodId,--%>
	    <%--    dataType: "json",--%>
	    <%--    success: function(data){--%>
	    <%--    	$("#itemSelect2").html("<option value=\"\">--请选择检测项目--</option>");--%>
	    <%--    	if(data && data.success){--%>
	    <%--    		for(var i=0;i<data.obj.length;i++){--%>
	    <%--    			$("#itemSelect2").append("<option value='"+data.obj[i].id+"'>"+data.obj[i].detectItemName+"</option>");--%>
	    <%--    		}--%>
	    <%--    	}--%>
		<%--	}--%>
	    <%--});--%>
	}
	
	// //确认检索结果
	// $(document).on("change","#itemSelect2",function(){
	// 	var options=$('#itemSelect2 option:selected'); //获取选中的项
	//
	// 	if(options.val() && options.text()){	//确认
	// 		itemNodeId = options.val();
	// 		itemNodeText = options.text();
	//
	// 		detectItemConfirm();
	// 	}
	// });
	
	//打开modal前，清空检索输入框
	/* 
	$('#myDetectItemModal').on('show.bs.modal', function () {		
		$("#selectNull").val("").select2();  
	});
	 */
	
	//确认
	function detectItemConfirm(){
		// selDetectItem(itemNodeId, itemNodeText);
		var checkedItems = [];
		if ($('#myDetectItemTree').tree("getChecked").length > 0) {
			$.each($('#myDetectItemTree').tree("getChecked"), function (index, val) {
				checkedItems.push({"itemNodeId" : val.id, "itemNodeText" : val.text});
			});
		}
		selDetectItem2(checkedItems);
		$("#myDetectItemModal").modal("hide");
	}
</script>
