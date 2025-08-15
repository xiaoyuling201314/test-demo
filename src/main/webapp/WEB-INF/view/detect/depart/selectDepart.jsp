<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 选择组织机构(多选，仅显示下一级) -->
<div class="modal fade" id="myDeaprtModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" data-backdrop="static">
	<div class="modal-dialog cs-mid-width" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title">选择检测机构</h4>
			</div>
			<div class="modal-body cs-mid-height">
				<ul id="myDeaprtTree" class="easyui-tree"></ul>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-success" onclick="departConfirm();">确定</button>
				<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
			</div>
		</div>
	</div>
</div>
<!-- JavaScript -->
<script type="text/javascript">
	//var departNodeId = "";
	//var departNodeText = "";
	
	//打开模态框事件
	$('#myDeaprtModal').on('show.bs.modal', function () {
        //取消 所有选中
	    var rootNodes = $('#myDeaprtTree').tree('getRoots');
	    for ( var i = 0; i < rootNodes.length; i++) {
	        var node = $('#myDeaprtTree').tree('find', rootNodes[i].id);
	        $('#myDeaprtTree').tree('uncheck', node.target);
	    }
	});
	
	$(function() {
		var departid = '';//当前用户组织机构ID
		if ('${sessionScope.org}') {
			departid = '${sessionScope.org.id}';
		}
		//组织机构树
		$('#myDeaprtTree').tree({
			checkbox : false,
			url : '${webRoot}' + "/detect/depart/getSubDepart.do?id=" + departid,
			animate : true,
			checkbox: true,
			onClick : function(node) {
				//departNodeId = node.id;
				//departNodeText = node.text;
			},
			//延迟加载
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
	function departConfirm(){
		var nodes = $('#myDeaprtTree').tree('getChecked');
		/* var nodeIds = '';
		var nodeTexts = '';
		for(var i=0; i<nodes.length; i++){
			if (nodeIds != '') nodeIds += ',';
			nodeIds += nodes[i].id;
			if (nodeTexts != '') nodeTexts += ',';
			nodeTexts += nodes[i].text;
		}
		selOrg(nodeIds, nodeTexts); */

		//去除机构名称中的ID
		for (var i=0; i<nodes.length; i++) {
			var idx = nodes[i].text.indexOf("(");
			if (idx != -1) {
				nodes[i].text = nodes[i].text.substr(0, idx);
			}
		}
		selOrg(nodes);
	}
</script>