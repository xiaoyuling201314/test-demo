<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 选择检测项目 窗口、多选 -->
<input type="text" id="selItemName" readonly="readonly" onclick="selectItems.show();" placeholder="--请选择检测项目--">
<div class="modal fade" id="selItemModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" data-backdrop="static">
	<div class="modal-dialog cs-mid-width" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title">选择检测项目</h4>
			</div>
			<div class="modal-body cs-mid-height">
				<ul id="selItemTree" class="easyui-tree"></ul>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-success" onclick="selectItems.comfirm();">确定</button>
				<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
			</div>
		</div>
	</div>
</div>
<!-- JavaScript -->
<script type="text/javascript">

	selectItems = (function () {
		let itemIds = "";
		let itemNames = "";

		return {
			init: function (f) {
				$('#selItemTree').tree({
					checkbox: true,
					onlyLeafCheck: true,
					url: "${webRoot}/data/detectItem/queryAllDetectItemTree.do",
					animate: true
				});
				if (f) {
					this.callback = f;
				}
			},
			comfirm: function () {
				itemIds = "";
				itemNames = "";
				let nodes = $('#selItemTree').tree('getChecked');
				$.each(nodes,function(i,v){
					itemIds += v.id+",";
					itemNames += v.text+",";
				});
				if (itemIds && itemIds.length>0) {
					itemIds = itemIds.substring(0, itemIds.length-1);
					itemNames = itemNames.substring(0, itemNames.length-1);
				}
				$("#selItemName").val(itemNames);
				$("#selItemModal").modal("hide");
				this.callback(this.getSelectDate());
			},
			//获取选中节点
			getCheckedNodes: function (){
				let selItemsData = [];
				let nodes = $('#selItemTree').tree('getChecked');
				$.each(nodes,function(i,v){
					selItemsData.push({"id":v.id,"text":v.text});
				});
				return selItemsData;
			},
			//获取选中数据
			getSelectDate: function (){
				return {"itemIds": itemIds, "itemNames": itemNames};
			},
			show: function (){
				this.uncheck();
				if (itemIds) {
					let itemIdArr = itemIds.split(",");
					$.each(itemIdArr,function(i,v){
						let node = $('#selItemTree').tree('find', v);
						$('#selItemTree').tree('check', node.target);
					});
				}
				$("#selItemModal").modal("show");
			},
			uncheck: function (id){
				if (id) {
					let node = $('#selItemTree').tree('find', id);
					$('#selItemTree').tree('uncheck', node.target);
				} else {
					let nodes = $('#selItemTree').tree('getChecked');
					$.each(nodes,function(i,v){
						$('#selItemTree').tree('uncheck', v.target);
					});
				}
			},
			callback: function (){}
		}
	})();

	//确认选择的检测项目
	function detectItemConfirm(){
		let selItemsData = [];
		let nodes = $('#selItemTree').tree('getChecked');
		let nodesText = "";
		$.each(nodes,function(i,v){
			nodesText += v.text+",";
			selItemsData.push({"id":v.id,"text":v.text});
		});
		if (nodesText && nodesText.length>0) {
			nodesText = nodesText.substring(0, nodesText.length-1);
		}
		$(".dItem").val(nodesText);
		$('#myDetectItemModal').modal('toggle');
	}
</script>
