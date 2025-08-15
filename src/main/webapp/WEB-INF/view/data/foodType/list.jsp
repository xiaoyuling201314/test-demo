<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/common/resource.jsp"%>
<html>
  <head>
    <title>快检服务云平台</title>
    <style>
    	.cs-ss{
    	 position:absolute;
    	 left:0;
    	 right:0;
    	 bottom:0;
    	 top:0;
    	 height:100%;
    	 width:100%;
    	 border:none;
    	 border:0;
    	}
    	.layout-split-west{
    	 bottom:50px;
    	}
    </style>
  </head>
 <body>
 <div class="easyui-layout cs-ss" id="context1">
	<div data-options="region:'west',split:true,title:'样品种类'" style="width: 200px; padding: 10px;">
		<ul id="foodType" class="easyui-tree" style="padding-bottom:40px;">
		</ul>
	</div>

	<div data-options="region:'north',border:false" style="height:41px; border: none; overflow:hidden;">
		<div class="cs-col-lg clearfix" style="border-bottom: none;">
			<!-- 面包屑导航栏  开始-->
			<ol class="cs-breadcrumb">
				    <li class="cs-fl">
              <img src="${webRoot}/img/set.png" alt="" />
              <a href="javascript:">数据中心</a></li>
				<li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
				<li class="cs-b-active cs-fl">食品分类</li>
			</ol>
			<!-- 面包屑导航栏  结束-->
			<div class="cs-search-box cs-fr">
				<form action="">
					<input type="hidden" class="focusInput" name="baseBean.parentId" id="parentId" />
					<div class="cs-search-filter clearfix cs-fl">
						 <input id="keyWords" class="cs-input-cont cs-fl" type="text" placeholder="请输入样品名称" />
						 <input type="button" onclick="query0();" class="cs-search-btn cs-fl" href="javascript:;" value="搜索">
					</div>
					<div class="clearfix cs-fr" id="showBtn"></div>
				</form>
			</div>
		</div>

	</div>
	
	<div data-options="region:'center'">
		<div id="dataList"></div>
	</div>
</div>

<div id="context2" style="display:none;" class="cs-ss">
	<iframe id="foodItemIframe" class="cs-ss"></iframe>
</div>
	<!-- 内容主体 结束 -->
	<!-- 食品种类新增 开始 -->

<div class="modal fade intro2" id="addModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog cs-lg-width" role="document">
    <div class="modal-content ">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">新增</h4>
      </div>
      <div class="modal-body cs-lg-height">
         <!-- 主题内容 -->
    <div class="cs-tabcontent" >
      <div class="cs-content2">
      	<form id="saveForm" action="${webRoot}/data/foodType/save" method="post" autocomplete="off">
			<input type="hidden" name="id"  >
			<input type="hidden" name="foodCode" >
		   <div width="100%" class="cs-add-new">
                <ul class="cs-ul-form clearfix">
                    <li  class="cs-name col-xs-3  col-md-3" width="20% ">所属类别：</li>
                    <li class="cs-in-style cs-modal-input" width="210px" >
			             <div class="cs-all-ps">
	                    <div class="cs-input-box">
	                       <input type="hidden" name="parentId" />
						   <input type="text" name="parentName" class="cs-down-input" datatype="*" nullmsg="请选择所属类别" errormsg="选择所属类别异常" />
	                      <div class="cs-down-arrow"></div>
	                    </div>
	                    <div id="divBtn" class="cs-check-down  cs-hide" style="display: none;">
	                      
	                      <!-- 树状图 -->
	                      <ul id="tt" class="easyui-tree">
	                    </ul>
						<!-- 树状图 -->
	
	                    </div>
	                    </div>
                    </li>
                </ul>
               <ul class="cs-ul-form clearfix">
                   <li  class="cs-name col-xs-3 col-md-3" width="20% ">食品名称：</li>
                   <li class="cs-in-style cs-modal-input" width="210px" >
                       <input type="text" name="foodName" datatype="*" nullmsg="请输入食品名称" errormsg="请输入食品名称" autocomplete="off" onblur="checkUniqueFoodName(this);"/>
                   </li>
                   <li class="col-md-4 col-xs-4  cs-text-nowrap">
                       <div class="Validform_checktip"></div>
                       <div class="info"><i class="cs-mred">*</i>请输入食品名称
                       </div>
                   </li>
               </ul>
				 <ul class="cs-ul-form clearfix">
                    <li  class="cs-name col-md-3 col-xs-3 " width="20% ">常用别称：</li>
                    <li class="cs-in-style cs-modal-input" width="210px" >
	                    <input type="text" name="foodNameOther" />
                    </li>
                </ul>
               <%--
                 <ul class="cs-ul-form clearfix">
                    <li  class="cs-name col-md-3 col-xs-3 " width="20% ">英文名称：</li>
                    <li class="cs-in-style cs-modal-input" width="210px" >
	                    <input type="text" name="foodNameEn" />
                    </li>
                </ul>
               --%>
                <ul class="cs-ul-form clearfix cs-hide">
                    <li  class="cs-name col-md-3 col-xs-3 " width="20% ">监控级别：</li>
                    <li class="cs-in-style cs-modal-input" width="210px" >
	                     <select name="cimonitorLevel">
			        	<option value="1">警惕</option>
			        	<option value="2">轻微</option>
			        	<option value="3">严重</option>
			        </select> 
                    </li>
                </ul>
                <ul class="cs-ul-form clearfix cs-hide">
                    <li class="cs-name col-md-3 col-xs-3 " width="20% ">种类类型：</li>
                    <li class="cs-al cs-modal-input" id="radioType">
	       			    <input id="cs-check-radio2" type="radio" value="1" name="isfood" checked="checked" /><label for="cs-check-radio2">食品名称</label>
                        <input id="cs-check-radio" type="radio" value="0" name="isfood" /><label for="cs-check-radio">食品种类</label>
                    </li>
                </ul>
                 <ul class="cs-ul-form clearfix cs-hide">
                    <li  class="cs-name col-md-3 col-xs-3 " width="20% ">状态：</li>
                    <li class="cs-al cs-modal-input">
	         		    <input id="cs-check-radio3" type="radio" value="1" name="checked" checked="checked" /><label for="cs-check-radio3">已审核</label>
		       			<input id="cs-check-radio4" type="radio" value="0" name="checked" /><label for="cs-check-radio4">未审核</label>
                    </li>
                </ul>
               <ul class="cs-ul-form clearfix cs-hide">
                   <li  class="cs-name col-md-3 col-xs-3 " width="20% ">序号：</li>
                   <li class="cs-in-style cs-modal-input" width="210px" >
                       <input type="text" name="sorting" datatype="n" ignore="ignore" errormsg="请输入正确的数字序号"/>
                   </li>
               </ul>
                <ul class="cs-ul-form clearfix cs-hide">
                    <li  class="cs-name col-md-3 col-xs-3 " width="20% ">检测项目：</li>
                    <li class="cs-al cs-modal-input">
                    	<input type="checkbox" id="CheckFoodItem" name="isExtends" checked="checked"/>
                    	<label>继承上级种类/类型检测项目</label>
                    </li>
                </ul>
		      <ul class="cs-ul-form clearfix">
                    <li  class="cs-name col-md-3 col-xs-3 " width="20% ">备注：</li>
                    <li class="cs-in-style cs-modal-input" width="210px">
	         		   <textarea class="cs-remark" name="remark" id="remark" cols="30" rows="10"></textarea>
                    </li>
                </ul>
		   </div>
		   
      </div>
    </div>
      </div>
      <div class="modal-footer">
      <button type="button" class="btn btn-success" id="btnSave">确定</button>
        <button type="button" class="btn btn-default" data-dismiss="modal" id="btnCancel">关闭</button>
      </div>
       </form>
    </div>
  </div>
</div>
	<!-- 食品种类新增 结束 -->
  <%@include file="/WEB-INF/view/data/foodType/selectFoodGroup.jsp"%>
  <%@include file="/WEB-INF/view/common/confirm.jsp"%>
	<script src="${webRoot}/js/datagridUtil2.js"></script>
	<script src="${webRoot}/js/jquery.form.js"></script>
	<script type="text/javascript">
rootPath="${webRoot}/data/foodType/";
var showFoodCode=0;//是否显示样品编号列
var foodType=0;

//新增样品种类拆分两个独立权限 Dz.20220224
//新增种类
if (Permission.exist("413-9")) {
    //新增按钮
    var html='<a class="cs-menu-btn" onclick="getId(-2);"><i class="'+Permission.getPermission("413-9").functionIcon+'"></i>'+Permission.getPermission("413-9").operationName+'</a>';
    $("#showBtn").append(html);

    foodType=1;
}
//新增样品
if (Permission.exist("413-1")) {
    var html='<a class="cs-menu-btn" onclick="getId(-1);"><i class="'+Permission.getPermission("413-1").functionIcon+'"></i>'+Permission.getPermission("413-1").operationName+'</a>';
    $("#showBtn").append(html);
}


if(Permission.exist("413-11")){
    showFoodCode=1;
}

$(function(){
	tree();
	$("#saveForm").Validform({
		tiptype:2,
		beforeSubmit:function(){
			var formData = new FormData($('#saveForm')[0]);
			$.ajax({
		        type: "POST",
		        url: "${webRoot}/data/foodType/save.do",
		        data: formData,
		        contentType: false, //必须false才会避开jQuery对 formdata 的默认处理 XMLHttpRequest会对 formdata 进行正确的处理 
		        processData: false, //必须false才会自动加上正确的Content-Type
		        dataType: "json",
		        success: function(data){
		        	if(data && data.success){
		        		$("#addModal").modal("hide");
                        dgu.query();
						loadFoodTree();
						tree();
		        	}else{
		        		$("#waringMsg>span").html(data.msg);
		        		$("#confirm-warnning").modal('toggle');
		        	}
				}
		    });
			return false;
		}
	});
	function tree() {
		$("#tt").tree({
			checkbox: false,
			url: "${webRoot}/data/foodType/foodTrees.do",
			animate: true,
			onClick: function(node){
				$("input[name=parentId]").val(node.id);
				$("input[name=parentName]").val(node.text);
				$(".cs-check-down").hide();
			},onLoadSuccess: function (node, data) {
				//延迟执行自动加载二级数据，避免与异步加载冲突
				setTimeout(function(){
						$(data).each(function (index, d) {
				         	if (this.state == 'closed') {
				        		var children = $('#tt').tree('getChildren');
				        		for (var i = 0; i < children.length; i++) {
				            		$('#tt').tree('expand', children[i].target);
				            	}
				         	}
				    	});
				}, 100);
			}
		});
	}
	
	// 新增或修改
	$("#btnSave").on("click", function() {
		if($("#CheckFoodItem").prop('checked')){
		  $("#CheckFoodItem").val("1");
		}
		$("#saveForm").submit();
		return false;
	});

    //关闭新增和编辑模态框时清空数据
   	$('#addModal').on('hidden.bs.modal', function (e) {
 		//清空隐藏域
 		$("input[name=id]").val("");
 		$("input[name=foodCode]").val("");
        $("#cs-check-radio3").prop("checked", "checked");
 		$("#saveForm").Validform().resetForm();
 		$("input").removeClass("Validform_error");
 		$(".Validform_wrong").hide();
 		$("#saveForm input[name=sorting]").parents("ul").hide();
 		$("#saveForm input[name=checked]").parents("ul").hide();
 		$(".Validform_checktip").hide();
 		$(".info").show();
 		var rootNodes = $("#tt").tree('getRoots');
 	    for(var i = 0; i < rootNodes.length; i++) {
 	        var node =$("#tt").tree('find', rootNodes[i].id);
 	       $("#tt").tree('uncheck', node.target);
 	    }
        dgu.queryByFocus();
   	});
   	$("[datatype]").focusin(function() {
		if (this.timeout) {
			clearTimeout(this.timeout);
		}
		var infoObj = getInfoObj.call(this);
		if (infoObj.siblings(".Validform_right").length != 0) {
			return;
		}
		infoObj.show().siblings().hide();

	}).focusout(function() {
		var infoObj = getInfoObj.call(this);
		this.timeout = setTimeout(function() {
			infoObj.hide().siblings(".Validform_wrong,.Validform_loading").show();
		}, 0);

	});
   	loadFoodTree();
});
function getInfoObj(){
	return $(this).parents("li").next().find(".info");
}
var dgu = datagridUtil.initOption({
		tableId: "dataList",
		tableAction: "${webRoot}/data/foodType/datagrid.do",
        defaultCondition: [{
            queryCode: "keyWords",
            queryVal: ""
        },{
            queryCode: "baseBean.parentId",
            queryVal: ""
        }],
		funColumnWidth:'120px',
		onload: function(rows, pageData){
            var obj = rows;
            $(".rowTr").each(function(){
                for(var i=0;i<obj.length;i++){
                    if($(this).attr("data-rowId") == obj[i].id){
                        if(obj[i].isfood ==0&&foodType==0){
                            //隐藏编辑按钮
                            $(this).find(".413-2").hide();
                        }
                        break;
                    }
                }
            });
        },
		parameter: [
			{
				columnCode: "parentName",
				columnName: "所属种类"
			},
			{
				columnCode: "foodName",
				columnName: "名称/种类"
			},
			{
				columnCode: "foodNameOther",
				columnName: "常用别称"
			},{
                columnCode: "foodCode",
                columnName: "样品编号",
                columnWidth: "120px",
                show:showFoodCode
            },
			{
				columnCode: "isfood",
				columnName: "类型",
				customVal:{"0":"类别","1":"名称"},
                columnWidth: "80px"
			},
			{
                //ys平台隐藏此列
                show: ((window.location.hostname == 'ys.chinafst.cn') ? 0 : 1),
				columnCode: "realName",
				columnName: "更新人",
                columnWidth: "80px"
			},
			{
				columnCode: "updateDate",
				columnName: "更新时间"
			},
			{
				columnCode: "checked",
				columnName: "状态",
				customVal: {"0":"<div class=\"text-danger\">未审核</div>","1":"<div class=\"text-primary\">已审核</div>"},
                columnWidth: "70px"
			}
			
		],
		funBtns: [
	    	{
                show: Permission.exist("413-2"),
                style: Permission.getPermission("413-2"),
	    		action: function(id){
	    			$("#addModal").modal("show");
	    			getId(id);
	    		}
	    	},
	    	{
                show: Permission.exist("413-3"),
                style: Permission.getPermission("413-3"),
	    		action: function(id){
	    			showIframe(id);
	    		}
	    	},
	    	{
                show: Permission.exist("413-4"),
                style: Permission.getPermission("413-4"),
	    		action: function(id){
	    			idsStr="{\"ids\":\""+id.toString()+"\"}";
	    			$("#confirm-delete").modal('toggle');
	    		}
	    	},
	    	{
                show: Permission.exist("413-7"),
                style: Permission.getPermission("413-7"),
	    		action: function(id){
	    			bigbang(id);
	    		}
	    	},
	    	{
                show: Permission.exist("413-8"),
                style: Permission.getPermission("413-8"),
	    		action: function(id){
	    			bigbang1(id);
	    		}
	    	}
	    ],
		bottomBtns: [
			{	//删除样品/种类
                show: Permission.exist("413-4"),
                style: Permission.getPermission("413-4"),
	    		action: function(ids){
                    if(ids == ''){
                        $("#confirm-warnning .tips").text("请选择要删除的食品");
                        $("#confirm-warnning").modal('toggle');
                    }else {
                        idsStr = "{\"ids\":\"" + ids.toString() + "\"}";
	    			$("#confirm-delete").modal('toggle');
	    		}
	    		}
	   		}, {	//样品种类移组
                show: Permission.exist("413-5"),
                style: Permission.getPermission("413-5"),
                action: function(ids){
                    if(ids == ''){
                        $("#confirm-warnning .tips").text("请选择食品");
                        $("#confirm-warnning").modal('toggle');
                    }else{
                        idsStr = ids.toString();
                        $("#myFoodTypeModal").modal('toggle');
                    }
                }
		    }, {    //清空样品/种类及下级样品的检测项目
                show: Permission.exist("413-10"),
                style: Permission.getPermission("413-10"),
                action: function(ids, rows){
                    //读取选中复选框是否含有类别；有，则显示删除下级样品检测项目选项
                    $(".deleteChilds").addClass("cs-hide");
                    for (var i=0; i<rows.length; i++) {
                        if (rows[i].isfood == 0) {
                            $(".deleteChilds").removeClass("cs-hide");
                            break;
                        }
                    }

                    $(".choseOptions").prop("checked",false);
                    dif = ids;
                    $("#confirm-delete3").modal('toggle');
                }
            }
		] 
	});
    dgu.queryByFocus();
    
    function bigbang(id) {
		$.ajax({
	        type: "POST",
	        url: "${webRoot}/data/foodType/changExtends.do",
	        data: {"id":id,flag:1},
	        dataType: "json",
	        success: function(data){
	        	if(data && data.success){
                    $("#tips-success").modal('toggle');
                    dgu.queryByFocus();
	        	}else{
	        		$("#waringMsg>span").html(data.msg);
	        		$("#confirm-warnning").modal('toggle');
	        	}
			}
	    });
	}
    function bigbang1(id) {
		$.ajax({
	        type: "POST",
	        url: "${webRoot}/data/foodType/changExtends.do",
	        data: {"id":id,flag:0},
	        dataType: "json",
	        success: function(data){
	        	if(data && data.success){
                    $("#tips-success").modal('toggle');
                    dgu.queryByFocus();
	        	}else{
	        		$("#waringMsg>span").html(data.msg);
	        		$("#confirm-warnning").modal('toggle');
	        	}
			}
	    });
	}
    //加载食品种类树形控件数据列表
  	var treeLevel = 1;	//控制机构树加载二级数据
    function loadFoodTree(){
    	$("#foodType").tree({
    		checkbox:false,
    		url:"${webRoot}/data/foodType/foodTree.do",
    		animate:true,
    		onClick : function(node){
    			$("#keyWords").val("");//清空关键字查询，直接查询下级食品
                dgu.addDefaultCondition("keyWords", "");
    			$("input[name=parentId]").val(node.id);
    			$("input[name=parentName]").val(node.text);
                dgu.datagridOption.pageNo = 1;
                dgu.addDefaultCondition("baseBean.parentId", node.id);
                dgu.queryByFocus();
    		}, onLoadSuccess: function (node, data) {
				//延迟执行自动加载二级数据，避免与异步加载冲突
				setTimeout(function(){
					if (data && treeLevel == 1) {
						treeLevel++;
						$(data).each(function (index, d) {   
				         	if (this.state == 'closed') {
				        		var children = $('#foodType').tree('getChildren');
				        		for (var i = 0; i < children.length; i++) {
				            		$('#foodType').tree('expand', children[i].target);
				            	}
				         	}
				    	});
					}
				}, 100);
    		}
    	});
    }
  //回车查询数据
  document.onkeydown=function(event){
    var e = event || window.event || arguments.callee.caller.arguments[0];
    if(e && e.keyCode==13){ //enter键
        var focusedElement = document.activeElement;//当前关键词元素
        if(focusedElement && focusedElement.className){
            query0();
        }
        return false;
    }
  }
  //点击查询进行搜索，清空左侧的食品种类parentId
  function query0(){
      dgu.addDefaultCondition("baseBean.parentId", "");
      dgu.addDefaultCondition("keyWords", $("#keyWords").val());
      dgu.queryByFocus();
  }
    /**
     * 查询信息
     */
    function getId(id){
    	if(-1 == id){
            $("#addModal .modal-title").text("新增食品名称");
            $("#cs-check-radio2").prop("checked", "checked");

		}else if (-2 == id){
            $("#addModal .modal-title").text("新增食品种类");
            $("#cs-check-radio").prop("checked", "checked");

		}else if (id){
            $("#addModal .modal-title").text("编辑");
            $("#saveForm input[name=sorting]").parents("ul").show();
            $("#saveForm input[name=checked]").parents("ul").show();
            $.ajax({
                url:"${webRoot}/data/foodType/queryById.do",
                type:"POST",
                data:{"id":id},
                dataType:"json",
                success:function(data){
                    $(".info").hide();
                    var form = $('#saveForm');
                    form.form('load', data.obj);
                    $("[name=checked][value="+data.obj.checked+"]").prop("checked","checked");
                    $("[name=isfood][value="+data.obj.isfood+"]").prop("checked","checked");
                    if(data.obj.isExtends==1){
                        $("[name=isExtends]").prop("checked","checked");
                    }
                    var n = $('#tt').tree('find',data.obj.parentId);
                    $('#tt').tree('select', n.target);//设置选中该节点
                }
            });
		}
		$("#addModal").modal("show");
    }
    //拼接食品种类下拉选项
   /*  function dealHtml(data){
    	var json = data;	
    	$("#foodTypeChose").empty();
    	var htmlStr="<option value=''>--请选择--</option>";
    	$.each(json, function (index, item) {
    		 	htmlStr+='<option value="'+item.id+'">'+item.foodName+'</option>';
    	});
    	$("#foodTypeChose").append(htmlStr);
    } */
	//确认，进行移组操作
	function footConfirm(){
		$.ajax({
	    	url:"${webRoot}/data/foodType/changeGroup.do",
	    	type:"POST",
	    	data:{"id":idsStr,"parentId":foodNodeId},
	    	dataType:"json",
	    	success:function(data){
	    		if(data.success){
	    			$('#myFoodTypeModal').modal('toggle');
	    			$("#confirm-warnning .tips").text(data.msg);
	    			$("#confirm-warnning").modal('toggle');
                    dgu.queryByFocus();
	    		    loadFoodTree();
	    		    //刷新移组模态框的食品种类信息
	    		    loadGroupFoodTree();
	    		} else {
                    $("#waringMsg>span").html(data.msg);
                    $("#confirm-warnning").modal('toggle');
                }
	    	},
	    	error:function(){
	    		alert("操作失败");
	    	}
    	});
		
	}
    
	function hideIframe(){
    	$("#context2").hide();
    	$("#context1").show();
    }
    
    function showIframe(id){
    	$("#foodItemIframe").attr("src","${webRoot}/data/foodType/detectItem/list.do?id="+id);
    	setTimeout(function(){
	    	$("#context1").hide();
			$("#context2").show();
    	}, 200);
    }

    /**
     * 清除检测项目
     */
    var dif;
    function deleteData3() {
        $.ajax({
            type: "POST",
            url: "${webRoot}/data/foodType/detectItem/delete",
            data: {"foodIds":dif.toString(), "isDeleteChild":$(".choseOptions").is(":checked")},
            dataType: "json",
            success: function (data) {
                $("#confirm-delete3").modal('toggle');
                if (data && data.success) {
                    //删除成功后刷新列表
                    dgu.queryByFocus();
                } else {
                    $("#waringMsg>span").html(data.msg);
                    $("#confirm-warnning").modal('toggle');
                }
            },
            error: function (data) {
                $("#confirm-warnning").modal('toggle');
            }
        });
    }
    //检查食品名称在当前类下是否重复
    function checkUniqueFoodName(e){
       let parentId=$("input[name=parentId]").val();
       let foodName=$(e).val();
        if(foodName){
            $.ajax({
                type: "POST",
                url: "${webRoot}/data/foodType/checkUniqueFoodName.do",
                data: {"foodName":foodName, "parentId":parentId},
                dataType: "json",
                success: function (data) {
                    if (data && !data.success) {//样品名称重复
                        $("#waringMsg>span").html(data.msg);
                        $("#confirm-warnning").modal('toggle');
                    }
                },
                error: function (data) {
                    $("#waringMsg>span").html(data.msg);
                    $("#confirm-warnning").modal('toggle');
                }
            });
        }
    }
	</script>
</body>
</html>
