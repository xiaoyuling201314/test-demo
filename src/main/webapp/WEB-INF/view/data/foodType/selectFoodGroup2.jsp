<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 选择食品种类(多选) -->
<input id="selFoodTypes" type="text" readonly="readonly" onclick="foodTypesSel.open();" placeholder="--请选择食品种类--">
<div class="modal fade" id="foodTypesModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" data-backdrop="static">
	<div class="modal-dialog cs-mid-width" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title">选择食品种类</h4>
			</div>
			<div class="modal-body cs-mid-height">
				<div class="cs-ul-boxc">
					<input id="cascadeCheckOff" class="cs-fl cs-ul-checkbox" type="checkbox" onchange="$('#foodTypesTree').tree({'cascadeCheck':$(this).is(':checked')})">
					<i class="cs-fl">是否包含下级</i>
				</div>
				<ul id="foodTypesTree" class="easyui-tree"></ul>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-success" onclick="foodTypesSel.confirm();">确定</button>
				<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">
	foodTypesSel = (function () {
		let inited = false;
		let foodIds = "";
		let foodNames = "";
		return {
			//加载tree, cascadeCheck[false/true]是否层叠选中状态, checkedRootNode[false/true]是否选择根节点, confirmFunc(nodes) 重写确认执行方法，参数选中节点
			init: function (cascadeCheck, checkedRootNode, confirmFunc){
				$("#foodTypesTree").tree({
					"url": "${webRoot}/data/foodType/foodTree.do",
					"animate": true,
					"checkbox": true,
					"cascadeCheck": (!cascadeCheck ? false : true),
					"onLoadSuccess": function (node, data){
						if (!inited) {
							//是否层叠选中状态
							if (cascadeCheck) {
								$("#cascadeCheckOff").prop("checked",true);
							} else {
								$("#cascadeCheckOff").prop("checked",false);
							}

							let rootNode = $('#foodTypesTree').tree('getRoot');
							//展开根节点
							$('#foodTypesTree').tree('expand', rootNode.target);
							//是否选择根节点
							if (checkedRootNode) {
								$('#foodTypesTree').tree('check', rootNode.target);
								$("#selFoodTypes").val(rootNode.text);
							}
						}

						inited = true;
						if (confirmFunc) {
							this.callback = confirmFunc;
						}

					}
				});
			},

			//打开窗口
			open: function (){
				if (!inited) {
					this.init();
				}
				$("#foodTypesModal").modal("show");
			},

			//确认
			confirm: function (){
				foodIds = "";
				foodNames = "";

				let nodes = $('#foodTypesTree').tree('getChecked');
				let nodesText = "";
				$.each(nodes,function(i,v){
					foodIds += v.id+",";
					foodNames += v.text+",";
					nodesText += v.text+",";
				});
				if (nodesText && nodesText.length>0) {
					foodIds = foodIds.substring(0, foodIds.length-1);
					foodNames = foodNames.substring(0, foodNames.length-1);
					nodesText = nodesText.substring(0, nodesText.length-1);
				}
				$("#selFoodTypes").val(nodesText);
				$("#foodTypesModal").modal("hide");
				this.callback(this.getSelectDate());
			},
			//获取选中节点
			getCheckedNodes: function (){
				let selFoodTypesData = [];
				let nodes = $('#foodTypesTree').tree('getChecked');
				$.each(nodes,function(i,v){
					selFoodTypesData.push({"id":v.id,"text":v.text});
				});
				return selFoodTypesData;
			},
			//获取选中数据
			getSelectDate: function (){
				return {"foodIds": foodIds, "foodNames": foodNames};
			},
			callback: function (){}
		}
	})();
	
</script>

