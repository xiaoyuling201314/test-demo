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
	              <a href="javascript:">数据报表</a></li>
	              <li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
	              <li class="cs-b-active cs-fl">标签配置</li>
	            </ol>
	          	<div class="cs-search-box cs-fr">
	          		<!-- 
	                <div class="cs-search-filter clearfix cs-fl">
		                <input class="cs-input-cont cs-fl focusInput" type="text" placeholder="请输入任务名称" name="task.taskTitle" />
		                <input type="button" class="cs-search-btn cs-fl" href="javascript:;" value="搜索" onclick="datagridUtil.queryByFocus();">
		                <span class="cs-s-search cs-fl">高级搜索</span>
	                </div>
	                 -->
	              	<div class="clearfix cs-fr" id="showBtn">
			            <div class="clearfix cs-fr">
							<a href="javascript:" class="cs-menu-btn" onclick="parent.closeMbIframe();"><i class="icon iconfont icon-fanhui"></i>返回</a>
						</div>
	              	</div>
	            </div>
	        </div>
		</div>
		
		<div data-options="region:'west',split:true,title:'目录'" style="padding-top: 10px; width: 220px;">
			<div class="cs-list-all">
				<div class="cs-search-filter clearfix " style="padding-bottom: 6px;">
					<input class="cs-input-cont cs-fl focusInput" type="text" name="projectName" id="projectName" style="margin-left:1px; margin-right:0;"  placeholder="请输入项目名称">
					<input type="button" onclick="queryByFocus()" class="cs-search-btn cs-fl" href="javascript:;" style="width: 40px" value="搜索"> 
				</div>
				<div class="stock_info">
					<input type="hidden" id="pid"/>
					<ul id="types">
						<c:forEach items="${pProjects}" var="subMenu" varStatus="index">
						<li name="types" data-type="${subMenu.id}" onclick="btnSelectedReport(this)">
							<div class="title"><a href="javascript:" title="${subMenu.projectName}">
		                    	<c:choose>
									<c:when test="${subMenu.lid==null&&subMenu.id!=0}">
										<i style="padding-left: 2px" class="icon iconfont icon-weipeizhi text-del" title="未配置标签"></i>${subMenu.projectName}
									</c:when>
									<c:otherwise>
										${subMenu.projectName}
									</c:otherwise>
								</c:choose>
							</a></div>
							<div class="arrow"><i class="icon iconfont icon-you"></i></div>
						</li>
						</c:forEach>
					</ul>
				</div>
			</div>
			<input type="hidden" id="did"/>
			<ul id="departTree" class="easyui-tree"></ul>
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

if(Permission.exist("1422-6")){	//新增标签
	$("#showBtn").append('<div id="addBtn" class="cs-fr cs-ac"><a href="javascript:;" class="cs-menu-btn" data-toggle="modal" data-target="#myModal-mid"><i class="'+Permission.getPermission('1422-6').functionIcon+'"></i>新增</a></div>');
}

var did;
//控制机构树加载二级数据
var treeLevel = 1;
function loadDepartTree(){
	treeLevel = 1;
	$("#departTree").tree({
		url:"${webRoot}/detect/depart/getDepartTree.do",
		animate:true,
		onClick : function(node){
			$("#did").val(node.id);
			did=node.id;
			bigbang("",node.id);
		},
		onLoadSuccess: function (node, data) {
			if (treeLevel == 1) {
				//调用选中事件
				  var n = $('#departTree').tree('find', data[0].id);
				  $('#departTree').tree('select', n.target);//设置选中该节点  
		          $("#did").val(data[0].id);
				  did=data[0].id;
				  bigbang("",did);
			}
			//延迟执行自动加载二级数据，避免与异步加载冲突
			setTimeout(function(){
				if (data && treeLevel == 1) {
					treeLevel++;
			    	$(data).each(function (index, d) {
			         	if (this.state == 'closed') {
			        		var children = $('#departTree').tree('getChildren');
			        		for (var i = 0; i < children.length; i++) {
			            		$('#departTree').tree('expand', children[i].target);
			            	}
			         	}
			    	});
				}
			}, 100);
		}
	});
}

var pid;
function btnSelectedReport(obj) {
	$.each($("li[name='types']"), function (index, item) {
        $(item).attr("class", "");
    });
	var id = $(obj).data("type");
	pid=id;
	$("#pid").val(id);
	$(obj).addClass("active");
	bigbang(pid,"");
}

function queryByFocus(obj){
		$.ajax({
	        url: "${webRoot}/project/selectProjects.do",
	        type: "POST",
	        data: {
	            "projectName": $("#projectName").val()
	        },
	        dataType: "json",
	        success: function (data) {
	        	$("[name=types]").remove();
	             var json = eval(data.obj);
					var htmlStr = "";
					$.each(json, function(index, item) {
						htmlStr+='<li name="types" data-type='+item.id+' onclick="btnSelectedReport(this)" >';
						htmlStr+='<div class="title"><a href="javascript:;" title='+item.projectName+'>';
						htmlStr+=item.projectName;
						htmlStr+=' </a></div><div class="arrow"><i class="icon iconfont icon-you"></i></div></li>';
					});
					$("#types").append(htmlStr);
					//默认选中第一个项目
					$("#types li:nth-child(1)").addClass("active"); //第一次进来就默认选中第一个
				    var trainType = $("#type li:nth-child(1)").data("type");
				    AppType = trainType;
				    $("#pid").val(trainType);
				    pid=trainType;
				    $("#types option[value='" + trainType + "']").attr("selected", "selected");
				  	bigbang(pid,"");
	            },
	            error: function () {
	                $("#waringMsg>span").html("操作失败");
	                $("#confirm-warnning").modal('toggle');
	            }
	    })
	}

//回车查询数据
document.onkeydown=function(event){
  		var e = event || window.event || arguments.callee.caller.arguments[0];        
  		if(e && e.keyCode==13){ //enter键
  			var focusedElement = document.activeElement;//当前关键词元素
  			if(focusedElement && focusedElement.className){
  				queryByFocus();
  			}
  			return false;
  		}
}

$(function() {
	
	if('${pid}'!='0'){
	<c:forEach items="${pProjects}" var="item"> 
	   <c:if test="${item.id==pid}">
	    
	    for (var i = 0; i < $("#types li").length; i++) {
	    	if($("#types li").eq(i).data("type")=='${item.id}'){
	    		$("#types li").eq(i).addClass("active");
	    		var pids=$("#types li").eq(i).data("type");
	    	}
		}
	    
	   </c:if>
	</c:forEach>
	}else {
		$("#types li:first-child").addClass("active");//第一次进来就默认选中第一个
		var pids = $("#types li:first-child").data("type");
	}
	
	pid=pids;
	$("#pid").val(pids);
	if('[]' == '${pProjects}'){
		//加载组织机构树形控件数据列表
		loadDepartTree();
		$('.cs-list-all').hide();
	}
	if(pids!=null){
		bigbang(pid,"");
	}
	/* else {
		var dids=$("#did").val();
		did=dids;
		bigbang("",did);
	} */
	    
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

function bigbang(pid,did) {
	var op = {
			tableId: "dataList",	//列表ID
			tableAction: "${webRoot}/data/foodItemLabel/datagrid.do?foodItemLabel.projectId="+pid+"&foodItemLabel.departId="+did,	//加载数据地址
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
		    		show: Permission.exist("1422-7"),
		    		style: Permission.getPermission("1422-7"),
		    		action: function(id){
		    			edit(id);
		    		}
		    	},
		    	{
		    		show: Permission.exist("1422-8"),
		    		style: Permission.getPermission("1422-8"),
		    		action: function(id){
		    			deleteId = id;
		    			$("#delConfirm").modal('toggle');
		    		}
		    	}
		    ]
		};
	
		datagridUtil.initOption(op);
	    datagridUtil.query();
}

//检测项目树
function loadItemTree(foodIds){
	if(!foodIds){
		$('#itree').tree('options').url = "${webRoot}/data/detectItem/getDetectItemTree.do";
	}else{
		$('#itree').tree('options').url = "${webRoot}/data/detectItem/getDetectItemTree.do?foodId="+foodIds;
	}
	$('#itree').tree('reload');
}

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
        		$("#pid").val(data.projectId);
        		$("#did").val(data.departId);
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
	$("#pid").val(pid);
	$("#did").val(did);
	$("input[name='projectId']").val($("#pid").val());
	$("input[name='departId']").val($("#did").val());
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

</script>
	
</body>
</html>
