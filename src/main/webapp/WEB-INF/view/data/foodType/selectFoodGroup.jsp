<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 选择食品种类 -->
<div class="modal fade" id="myFoodTypeModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" data-backdrop="static">
	<div class="modal-dialog cs-mid-width" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title">选择食品种类</h4>
			</div>
			<div class="modal-body cs-mid-height">
				<ul id="myCostTypeTree" class="easyui-tree"></ul>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-success" onclick="footConfirm();">确定</button>
				<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
			</div>
		</div>
	</div>
</div>
<!-- JavaScript -->
<script type="text/javascript">
	var foodNodeId = "";
	var foodNodeText = "";
	var treeLevels = 1;	//控制机构树加载二级数据
	function loadGroupCostTree(){
		$("#myCostTypeTree").tree({
    		checkbox:false,
    		url : '${webRoot}' + "/data/foodType/foodTree.do",
    		animate:true,
    		onClick : function(node){
    			foodNodeId = node.id;
    			foodNodeText = node.text;
    		}
    	});
	}
	$(function() {
		loadGroupCostTree();
	});
	
</script>

