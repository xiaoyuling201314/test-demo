<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/common/resource.jsp"%>
<html>
  <head>
    <title>快检服务云平台</title>
  </head>
 <body class="easyui-layout">
 		<div data-options="region:'north',border:false" style="height:41px; border:none; overflow:hidden;">
	        <div class="cs-col-lg clearfix" style="border-bottom:none;">
	            <ol class="cs-breadcrumb">
	              <li class="cs-fl">
	              <img src="${webRoot}/img/set.png" alt="" />
	              <a href="javascript:">项目管理</a></li>
	              <li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
	              <li class="cs-b-active cs-fl">样品配置</li>
	              <li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
	              <li class="cs-b-active cs-fl">${project.projectName}</li>
	            </ol>
	          	<div class="cs-search-box cs-fr">
	          	<form action="datagrid.do">
	          		 <div class="cs-search-filter clearfix cs-fl">
	                <input class="cs-input-cont cs-fl focusInput" type="text" placeholder="请输入标签名称" name="foodItemLabel.labelName"/>
	                <input type="button" class="cs-search-btn cs-fl" href="javascript:;" value="搜索" onclick="datagridUtil.queryByFocus();">
	                </div>
	              	<div class="clearfix cs-fr" id="showBtn">
			            <div class="clearfix cs-fr">
							<a href="javascript:" onclick="parent.closeMbIframe();" class="cs-menu-btn" ><i class="icon iconfont icon-fanhui"></i>返回</a>
						</div>
	              	</div>
              	</form>
	            </div>
	        </div>
		</div>
		
		<div data-options="region:'center'">
			<div class="cs-tb-box cs-re-box">
				<div class="cs-table-responsive" id="dataList"></div>
			</div>
		</div>
		
<div class="modal fade intro2" id="myModal-mid" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog cs-lg-width" role="document">
    <div class="modal-content ">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">新增</h4>
      </div>
      <div class="modal-body cs-xlg-height" style="padding: 10px 70px;">
         <!-- 主题内容 -->
    <div class="cs-tabcontent" >
      <div class="cs-content2">
      <form id="saveForm" enctype="multipart/form-data">
      	<input type="hidden" name="id">
      	<input type="hidden" name="projectId">
      	<input type="hidden" name="departId">
      	<input type="hidden" name="foodTypeId">
      	<input type="hidden" name="foodTypeName">
      	<input type="hidden" name="detectItemId">
      	<input type="hidden" name="detectItemName">
        <div class="col-xs-12 col-md-12">
          <div class="cs-food-type col-xs-6 col-md-6 clearfix">
              <div class="cs-in-style col-xs-12 col-md-12 clearfix">
                <ul class="cs-ul-form clearfix">
                <li  class="cs-name col-xs-3 col-md-3" style="width:auto;">标签名称：</li>
                <li class="cs-in-style cs-modal-input" width="210px" >
                  <input type="text" name="labelName" class="inputxt"/>
                </li>
                <li class="cs-food-tname cs-in-style col-xs-3 col-md-3">
                  <div class="info cs-text-nowrap" style="overflow: inherit;"></div>
                </li>                
              </ul>
              </div>
              <div class="pull-left clearfix" style="height: 30px; line-height:30px;">
                食品种类选择：
              </div>
              <div class="col-xs-12 col-md-12 clearfix" style="height: 260px;width: 292px;border: 1px solid #ddd;padding: 10px; overflow:auto;background:#f1f1f1;">
                  <ul id="ftree" class="easyui-tree" data-options="checkbox:true"></ul>
                </div>
            </div>

          <div class="cs-food-type col-xs-6 col-md-6 clearfix">
              <div class="cs-in-style col-xs-12 col-md-12 clearfix">
                <ul class="cs-ul-form clearfix">
                <li  class="cs-name col-xs-2 col-md-2" style="width:auto;">排序：</li>
                <li class="cs-in-style cs-modal-input" width="210px" >
                  <input type="text" name="sorting" class="inputxt" maxlength="5" onkeyup="value=value.replace(/[^\d]/g,'')"/>
                </li>
                <li class="cs-food-tname cs-in-style col-xs-3 col-md-3">
                  <div class="info cs-text-nowrap" style="overflow: inherit;"></div>
                </li>                
              </ul>
              </div>
              <div class="pull-left clearfix" style="line-height: 30px; line-height:30px;">
                检测项目选择：
              </div>
              <div class="col-xs-12 col-md-12 clearfix" style="height: 260px;width: 292px;border: 1px solid #ddd;padding: 10px; overflow:auto; background:#f1f1f1;">
              	<ul id="itree" class="easyui-tree"></ul>
              </div>
            </div>
            <div class="cs-beizhu col-xs-12 col-md-12">
            <ul class="cs-ul-form clearfix">
                <li  class="cs-name col-xs-3 col-md-3" style="width:auto;">备注：</li>
                <li class="cs-in-style cs-modal-input">
                  <textarea name="remark" cols="30" rows="10" style="width: 550px;height: 60px;"></textarea>
                </li>
              </ul>
              </div>
          </div>
        </form>
      </div>
    </div>
      </div>
      <div class="modal-footer">
      	<button type="button" class="btn btn-success" id="submitBtn" onclick="save();">确定</button>
        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      </div>
    </div>
  </div>
</div>

<div class="modal fade intro2" id="delConfirm" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog cs-alert-width">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
				<h4 class="modal-title">确认删除</h4>
			</div>
			<div class="modal-body cs-alert-height cs-dis-tab">
				<div class="cs-text-algin">
					<img src="${webRoot}/img/stop2.png" width="40px"/>
					<span class="tips">确认删除该记录吗？</span>
				</div>
			</div>
			<div class="modal-footer">
				<a class="btn btn-danger btn-ok delBtn">删除</a>
				<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
			</div>
		</div>
	</div>
</div>
	
<%@include file="/WEB-INF/view/common/confirm.jsp"%>

<script src="${webRoot}/js/datagridUtil.js"></script>
<script type="text/javascript">
if(Permission.exist("1317-13")){	//新增标签
	$("#showBtn").append('<div id="addBtn" class="cs-fr cs-ac"><a href="javascript:;" class="cs-menu-btn" data-toggle="modal" data-target="#myModal-mid"><i class="'+Permission.getPermission('1317-13').functionIcon+'"></i>新增</a></div>');
}
var op = {
		tableId: "dataList",	//列表ID
		tableAction: "${webRoot}/data/foodItemLabel/datagrid.do?foodItemLabel.projectId=${project.id}",	//加载数据地址 &foodItemLabel.departId=${project.departId}
		funColumnWidth:'120px',
		parameter: [		//列表拼接参数
			{
				columnCode: "labelName",
				columnName: "标签名称"
			},
			{
				columnCode: "foodTypeName",
				columnName: "样品类别"
			},
			{
				columnCode: "detectItemName",
				columnName: "重点检测项目"
			},
			{
				columnCode: "remark",
				columnName: "备注"
			}
		],
		funBtns: [
	    	{
	    		show: Permission.exist("1317-4"),
	    		style: Permission.getPermission("1317-4"),
	    		action: function(id){
	    			edit(id);
	    		}
	    	},
	    	{
	    		show: Permission.exist("1317-8"),
	    		style: Permission.getPermission("1317-8"),
	    		action: function(id){
	    			deleteId = id;
	    			$("#delConfirm").modal('toggle');
	    		}
	    	}
	    ]
	};

	datagridUtil.initOption(op);
    datagridUtil.query();
    $(function() {
        $('#ftree').tree({
    		checkbox : true,
    		url : "${webRoot}/data/foodType/foodTrees.do?showFood=0",
    		animate : true,
    		onCheck : function(node) {
    			var foodIds = "";
    			var foodNames = "";
    			
    			var nodes = $('#ftree').tree('getChecked');
    			for(var i=0;i<nodes.length;i++){
    				foodIds += nodes[i].id +",";
    				foodNames += nodes[i].text +",";
    			}
    			if(foodIds.length>0){
    				foodIds = foodIds.substring(0, foodIds.length-1);
    				foodNames = foodNames.substring(0, foodNames.length-1);
    			}
    			
    		},
    		onLoadSuccess: function (node, data) {
    	      if (data) {
    	        $(data).each(function (index, d) {
    	          	if (this.state == 'closed') {
    	            	var children = $('#ftree').tree('getChildren');
    		            for (var i = 0; i < children.length; i++) {
    		            	$('#ftree').tree('expand', children[i].target);
    		            }
    	          	}
    	         });
    	      }
    		}
    	});
        $('#itree').tree({
    		checkbox : true,
    		url : "${webRoot}/data/detectItem/getDetectItemTree.do",
    		animate : true,
    		onLoadSuccess: function (node, data) {
    	      if (data) {
    	        $(data).each(function (index, d) {
    	          	if (this.state == 'closed') {
    	            	var children = $('#itree').tree('getChildren');
    		            for (var i = 0; i < children.length; i++) {
    		            	$('#itree').tree('expand', children[i].target);
    		            }
    	          	}
    	         });
    	        
    	      }
    	    }
    	});
    });

    $('#myModal-mid').on('show.bs.modal', function () {
    	//展示两级食品树
    	$('#ftree').tree("collapseAll");
    	var roots = $('#ftree').tree('getRoots');
        for (var i = 0; i < roots.length; i++) {
        	$('#ftree').tree('expand', roots[i].target);
        }
        $('#itree').tree("expandAll");
    });
    $('#myModal-mid').on('hidden.bs.modal', function () {
    	//清空表单
    	$('#saveForm')[0].reset();
    	$("input[type='hidden']").val('');
    	
    	//清空树选中
        var checked = $('#ftree').tree('getChecked');
        for (var i = 0; i < checked.length; i++) {
        	$('#ftree').tree('uncheck', checked[i].target);
        }
        checked = $('#itree').tree('getChecked');
        for (var i = 0; i < checked.length; i++) {
        	$('#itree').tree('uncheck', checked[i].target);
        }
    });
  //新增
    function add(){
    	$("#myModal-mid").modal('toggle');
    }
  //编辑
    function edit(labelId){
    	$.ajax({
            type: "POST",
            url: "${webRoot}/data/foodItemLabel/queryById.do",
            data: {"id":labelId},
            dataType: "json",
            success: function(data){
            	if(data){
            		$("input[name='id']").val(labelId);
            		$("input[name='projectId']").val(data.projectId);
            		$("input[name='departId']").val(data.departId);
            		$("input[name='labelName']").val(data.labelName);
            		$("input[name='sorting']").val(data.sorting);
            		$("textarea[name='remark']").val(data.remark);
            		setTimeout(function(){
    	        		if(data.foodTypeId){
    	        			
    		        		var foodTypeIds = data.foodTypeId.split(",");
    	        			$(foodTypeIds).each(function(index, value){
    	        				var node = $('#ftree').tree('find', value);
    	        				if(node){
    		        				$('#ftree').tree('check', node.target);
    	        				}
    	        			});
    	        			
    	        			var foodIds = "";
    	    				var fnodes = $('#ftree').tree('getChecked');
    	    				for(var i=0;i<fnodes.length;i++){
    	    					foodIds += fnodes[i].id +",";
    	    				}
    	    				if(foodIds.length>0){
    	    					foodIds = foodIds.substring(0, foodIds.length-1);
    	    				}
    	    				
    	        		}
    	        		
    		        	if(data.detectItemId){
    		        		var detectItemIds = data.detectItemId.split(",");
    	        			$(detectItemIds).each(function(index, value){
    	        				var fnode = $('#itree').tree('find', value);
    	        				if(fnode){
    		        				$('#itree').tree('check', fnode.target);
    	        				}
    	        			});
    		        	}
            			
            		},300);
            		
            		$("#myModal-mid").modal('toggle');
            	}else{
            		$("#confirm-warnning .tips").text("操作异常");
        			$("#confirm-warnning").modal('toggle');
            	}
    		}
        });
    }
  //提交
    function save(){
    	if(!$("input[name='labelName']").val()) {
    		$("#confirm-warnning .tips").text("请输入标签名称");
    		$("#confirm-warnning").modal('toggle');
    		return;
    	}
    	$("input[name='projectId']").val("${project.id}");
    	$("input[name='departId']").val("${project.departId}");
    	var foodIds = "";
    	var foodNames = "";
    	var pfIds1 = {};
    	var pfIds2 = {};
    	var pfIds3 = {};
    	var fNodes = $('#ftree').tree('getChecked');
    	for(var i=0;i<fNodes.length;i++){
    		pfIds1[fNodes[i].parentId] = fNodes[i].parentId;
    	}
    	for(var i=0;i<fNodes.length;i++){
    		if(pfIds1[fNodes[i].id]){
    			pfIds2[fNodes[i].id] = fNodes[i].id;
    		}
    	}
    	for (var key in pfIds1) {
    		if(!pfIds2[key]){
    			pfIds3[key] = pfIds1[key];
    		}
    	}
    	for(var i=0;i<fNodes.length;i++){
    		if(pfIds3[fNodes[i].parentId]){
    			foodIds += fNodes[i].id +",";
    			foodNames += fNodes[i].text +",";
    		}
    	}
    	if(foodIds.length>0){
    		foodIds = foodIds.substring(0, foodIds.length-1);
    		foodNames = foodNames.substring(0, foodNames.length-1);
    	}

    	$("input[name='foodTypeId']").val(foodIds);
    	$("input[name='foodTypeName']").val(foodNames);
    	
    	var itemIds = "";
    	var itemNames = "";
    	var iNodes = $('#itree').tree('getChecked');
    	for(var i=0;i<iNodes.length;i++){
    		if($('#itree').tree('isLeaf', iNodes[i].target)){
    			itemIds += iNodes[i].id +",";
    			itemNames += iNodes[i].text +",";
    		}
    	}
    	if(itemIds.length>0){
    		itemIds = itemIds.substring(0, itemIds.length-1);
    		itemNames = itemNames.substring(0, itemNames.length-1);
    	}
    	
    	$("input[name='detectItemId']").val(itemIds);
    	$("input[name='detectItemName']").val(itemNames);
    	
    	$.ajax({
            type: "POST",
            url: "${webRoot}/data/foodItemLabel/saveOrUpdate.do",
            data: $('#saveForm').serialize(),
            dataType: "json",
            success: function(data){
            	if(data && data.success){
    	       		$("#myModal-mid").modal('toggle');
            		datagridUtil.query();
            	}else{
            		$("#confirm-warnning .tips").text(data.msg);
        			$("#confirm-warnning").modal('toggle');
            	}
    		},
    		beforeSend: function(){
    			//禁用按钮
    			$('#submitBtn').attr('disabled',true);
    	    },
    	    complete: function(){
    	    	//启用按钮
    	    	$('#submitBtn').attr('disabled',false);
    	    }
        });
    }

    //删除
    var deleteId = '';
    $(document).on('click','.delBtn',function(){
    	$.ajax({
    		type : "POST",
    		url : "${webRoot}/data/foodItemLabel/delete.do",
    		data : {"ids" : deleteId},
    		dataType : "json",
    		success : function(data) {
    			$("#delConfirm").modal('toggle');
    			if (data && data.success) {
    				datagridUtil.query();
    			} else {
    				$("#confirm-warnning .tips").text('删除失败');
    				$("#confirm-warnning").modal('toggle');
    			}
    		}
    	});
    });
</script>
	
</body>
</html>
