<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 选择食品种类 - 窗口 -->
<style type="text/css">
	.select2-container--default .select2-results>.select2-results__options{
	padding-bottom: 30px;
}
</style>
<div class="modal fade" id="myDepartModal"   role="dialog" aria-labelledby="myModalLabel" data-backdrop="static" style="z-index: 999999;">
	<div class="modal-dialog cs-mid-width" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title">选择机构</h4>
			</div>
			<div class="modal-body cs-mid-height">
				<!-- <select id="departSelect2" class="js-example-basic-single" name="state" style="width:100%;">
					<option value="">--请选择机构--</option>
				</select> -->
				<ul id="myTree" class="easyui-tree"></ul>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-success" onclick="dmConfirm();">确定</button>
				<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
			</div>
		</div>
	</div>
</div>
<!-- JavaScript -->

<script type="text/javascript">
	$(document).ready(function() { 
		$('#departSelect2').select2();
		
		$('#myDepartModal').on('show.bs.modal', function () {
			$("#departSelect2").val("").select2();  
		});
		/* $(document).on('click','.dSample', function () {
		$("#departSelect2").val("").select2();  
	}); */
	});
	
	var id = "";
	var text = "";
	var treeLevel = 1;	//控制机构树加载二级数据
	$(function() {
		//食品种类树
		$('#myTree').tree({
			checkbox : false,
			url : "${webRoot}/detect/depart/getDepartTree.do",
			animate : true,
			onClick : function(node) {
				id = node.id;
				text = node.text;
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
			}, onLoadSuccess: function (node, data) {
				//延迟执行自动加载二级数据，避免与异步加载冲突
				setTimeout(function(){
					if (data && treeLevel == 1) {
						treeLevel++;
						$(data).each(function (index, d) {   
				         	if (this.state == 'closed') {
				        		var children = $('#myTree').tree('getChildren');
				        		for (var i = 0; i < children.length; i++) {
				            		$('#myTree').tree('expand', children[i].target);
				            	}
				         	}
				    	});
					}
				}, 100);
    		}
		});
		
		//确认检索结果
		$(document).on("change","#departSelect2",function(){
			var options=$('#departSelect2 option:selected'); //获取选中的项
			
			if(options.val() && options.text()){	//确认
				id = options.val();
				text = options.text();
				text=text.substring(5,text.length);
				if(text.indexOf("(")>0){//判断是否有别名
					text=text.substring(0,text.indexOf("("));
				}
				
				dmConfirm();
			}
		});
		
		//打开modal前，清空检索输入框
		/* 
		$('#myDepartModal').on('show.bs.modal', function () {
			$("#selectNull").val("").select2();  
		});
		 */
	});
	
	//确认
	function dmConfirm(){
		selDepart(id, text);
	}
	$('#myDepartModal').on('hide.bs.modal', function () {
		$('.js-example-basic-single').select2({
			closeOnSelect: true
		});
	});
</script>
