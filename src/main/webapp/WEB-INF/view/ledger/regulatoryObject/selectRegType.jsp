<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 选择组织机构 -->
<div class="modal fade" id="myRegTypeModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" data-backdrop="static">
	<div class="modal-dialog cs-mid-width" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title">选择监管类型</h4>
			</div>
			<div class="modal-body cs-mid-height">
					<ul id="myRegTypeTree" class="easyui-tree"></ul>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-success" onclick="confirmChose();">确定</button>
				<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
			</div>
		</div>
	</div>
</div>
<!-- JavaScript -->
<script type="text/javascript">
	<!--模态框方式展示监管对象类型-->
	$(document).on("click", ".choseRegType", function(){
		$('#myRegTypeModal').modal('toggle');
	});
	//打开模态框事件
	$('#myDeaprtModal').on('show.bs.modal', function () {
        //取消 所有选中
	    var rootNodes = $('#myRegTypeModal').tree('getRoots');
	    for ( var i = 0; i < rootNodes.length; i++) {
	        var node = $('#myRegTypeModal').tree('find', rootNodes[i].id);
	        $('#myRegTypeModal').tree('uncheck', node.target);
	    }
	});
	
	$(function() {
		var departid = '';//当前用户组织机构ID
		if ('${sessionScope.org}') {
			departid = '${sessionScope.org.id}';
		}
		//组织机构树
		$('#myRegTypeTree').tree({
			url : '${webRoot}' + "/ledger/regulatoryObject/getRegTypeTree.do?",
			animate : true,
			checkbox: true,
			onClick : function(node) {
				//departNodeId = node.id;
				//departNodeText = node.text;
				if(node.checked){//取消选中
					$(this).tree("uncheck",node.target)
				}else{//选中
					$(this).tree("check",node.target)
				}
			},
			onLoadSuccess:function(node){
				var node = $('#myRegTypeTree').tree('getRoots');   // 获得根节点
				for ( var i = 0; i < node.length; i++) {
					var childrenNode =  $('#myRegTypeTree').tree('getChildren',node[i].target);
					for ( var j = 0; j < childrenNode.length; j++) {
						$('#myRegTypeTree').tree("check",childrenNode[j].target);  // 为某个节点设置勾选状态
					}
				}
			}
		});
	});
	
	//确认
	function confirmChose(){
		let nodes = $('#myRegTypeTree').tree('getChecked');
		let nodeIds = '';
		let nodeTexts = '';
		if(nodes.length==0){//全不选,设置监管类型为-1，
			nodeIds="-1";
			nodeTexts="--请选择--";
		}else if(nodes.length>0){
			if(nodes[0].id==""){//全选
				nodeTexts=nodes[0].text;
			}else{
				for(let i=0; i<nodes.length; i++){
					if (nodeIds != '') nodeIds += ',';
					nodeIds += nodes[i].id;
					if (nodeTexts != '') nodeTexts += ',';
					nodeTexts += nodes[i].text;
				}
			}
		}
		choseRegType(nodeIds, nodeTexts);//查询数据
		$('#myRegTypeModal').modal('toggle');//关闭选择模态框
	}
	//选择监管类型
	function choseRegType(nodeIds,nodeTexts){
		$(".choseRegType").val(nodeTexts);
		$("#regTypeIds").val(nodeIds);
		datagridUtil.queryByFocus();
	}
</script>