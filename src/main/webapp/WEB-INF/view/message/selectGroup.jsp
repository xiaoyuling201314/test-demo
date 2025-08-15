<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 选择组织机构 -->
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
				<div class="cs-ul-boxc">
					<input class="cs-fl cs-ul-checkbox" id="check" type="checkbox"  onchange="$('#myDeaprtTree').tree({cascadeCheck:$(this).is(':checked')})"> 
					<i class="cs-fl">是否包含下级</i>
				</div>
				<ul id="myDeaprtTree" class="easyui-tree" data-options="url:'tree_data1.json',method:'get',animate:true,checkbox:true,cascadeCheck:false,OnlyLeafCheck:false"></ul>
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
			url : '${webRoot}' + "/detect/depart/getDepartTree.do",
			animate : true,
			checkbox: true,
			onClick : function(node) {
			},  
			onLoadSuccess: function (node, data) {
			      if (data) {
			          $(data).each(function (index, d) {
			        	  if(d.id==1&&d.state=="closed"){
				              var children = $("#myDeaprtTree").tree("getChildren");
				              for (var i = 0; i < children.length; i++) {
				                $("#myDeaprtTree").tree("expand", children[i].target);
				              }
				          	}
			           });
			        }
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
		selOrg(nodes);
	}
</script>