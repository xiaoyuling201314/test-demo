<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 选择组织机构 -->
<input id="selDepart" type="text" readonly="readonly" onclick="departSel.open();" placeholder="--请选择机构--">
<div class="modal fade" id="departModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" data-backdrop="static">
	<div class="modal-dialog cs-mid-width" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title">选择食品种类</h4>
			</div>
			<div class="modal-body cs-mid-height">
				<ul id="departTree" class="easyui-tree"></ul>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-success" onclick="departSel.confirm();">确定</button>
				<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
	departSel = (function () {
		let inited = false;
		let departId = "";
		let departName = "";
		let checkboxTree = false;
		return {
			//加载tree, checkbox[false/true]显示复选框, cascadeCheck[false/true]层叠选中状态, checkedRootNode[false/true]选中根节点, confirmFunc(nodes) 重写确认执行方法，参数选中节点
			init: function (checkbox, cascadeCheck, checkedRootNode, confirmFunc){
				$("#departTree").tree({
					"url": "${webRoot}/detect/depart/getDepartTrees.do",
					"animate": true,
					"checkbox": (!checkbox ? false : true),
					"cascadeCheck": (!cascadeCheck ? false : true),
					"onLoadSuccess": function (node, data){
						checkboxTree = (!checkbox ? false : true);
						if (!inited) {
							let rootNode = $('#departTree').tree('getRoot');
							//展开根节点
							$('#departTree').tree('expand', rootNode.target);

							// //是否选择根节点
							if (checkedRootNode) {
								departId = rootNode.id;
								departName = rootNode.text;
								$('#departTree').tree('check', rootNode.target);
								$("#selDepart").val(rootNode.text);
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
				$("#departModal").modal("show");
			},

			//确认
			confirm: function (){
				departId = "";
				departName = "";

				let nodesText = "";
				if (checkboxTree) {
					let nodes = $('#departTree').tree('getChecked');
					$.each(nodes,function(i,v){
						departId += v.id+",";
						departName += v.text+",";
						nodesText += v.text+",";
					});
					if (nodesText && nodesText.length>0) {
						departId = departId.substring(0, departId.length-1);
						departName = departName.substring(0, departName.length-1);
						nodesText = nodesText.substring(0, nodesText.length-1);
					}

				} else {
					let node = $('#departTree').tree('getSelected');
					departId = node.id;
					departName = node.text;
					nodesText = node.text;
				}

				$("#selDepart").val(nodesText);
				$("#departModal").modal("hide");
				this.callback(this.getSelectDate());
			},
			//获取选中节点
			getCheckedNodes: function (){
				let selDepartData = [];
				let nodes = $('#departTree').tree('getChecked');
				$.each(nodes,function(i,v){
					selDepartData.push({"id":v.id,"text":v.text});
				});
				return selDepartData;
			},
			//获取选中数据
			getSelectDate: function (){
				return {"departId": departId, "departName": departName};
			},
			callback: function (){}
		}
	})();
</script>