<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 选择检测项目 窗口、单选-->
<div class="modal fade" id="myDetectItemModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" data-backdrop="static">
	<div class="modal-dialog cs-mid-width" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title">选择检测项目</h4>
			</div>
			<div class="modal-body cs-mid-height">
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
	var itemNodeId = "";
	var itemNodeText = "";

	$(function() {
		//检测项目
		$('#myDetectItemTree').tree({
			checkbox : false,
			url : '${webRoot}' + "/data/detectItem/queryAllDetectItemTree.do",
			animate : true,
			onClick : function(node) {
				//判断是否是叶子节点
				if ($('#myDetectItemTree').tree('isLeaf', node.target)) {
					//选择检测项目
					itemNodeId = node.id;
					itemNodeText = node.text;
					//selDetectItem(node.id, node.text);
				} else {
					$('#myDetectItemTree').tree('toggle', node.target);
				}
			},
			loadFilter : function(data, parent) {
				var state = $.data(this, 'tree');
				function setData() {
					var serno = 1;
					var todo = [];
					for (var i = 0; i < data.length; i++) {
						todo.push(data[i]);
					}
					while (todo.length) {
						var node = todo.shift();
						if (node.id == undefined) {
							node.id = '_node_' + (serno++);
						}
						if (node.children) {
							node.state = 'closed';
							node.children1 = node.children;
							node.children = undefined;
							todo = todo.concat(node.children1);
						}
					}
					state.tdata = data;
				}
				function find(id) {
					var data = state.tdata;
					var cc = [ data ];
					while (cc.length) {
						var c = cc.shift();
						for (var i = 0; i < c.length; i++) {
							var node = c[i];
							if (node.id == id) {
								return node;
							} else if (node.children1) {
								cc.push(node.children1);
							}
						}
					}
					return null;
				}

				setData();

				var t = $(this);
				var opts = t.tree('options');
				opts.onBeforeExpand = function(node) {
					var n = find(node.id);
					if (n && n.children && n.children.length) {
						return;
					}
					if (n && n.children1) {
						var filter = opts.loadFilter;
						opts.loadFilter = function(data) {
							return data;
						};
						t.tree('append', {
							parent : node.target,
							data : n.children1
						});
						opts.loadFilter = filter;
						n.children = n.children1;
					}
				};
				return data;
			}
		});
	});
	
	//确认
	function detectItemConfirm(){
		selDetectItem(itemNodeId, itemNodeText);
	}
</script>
