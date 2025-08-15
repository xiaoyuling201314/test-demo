<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/common/resource.jsp"%>
<html>
  <head>
    <title>快检服务云平台</title>
  </head>
  <body>
          <div class="cs-col-lg clearfix">
          <!-- 面包屑导航栏  开始-->
            <ol class="cs-breadcrumb">
              <li class="cs-fl">
              <img src="${webRoot}/img/set.png" alt="" />
              <a href="javascript:">系统管理</a></li>
                <li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
              <li class="cs-fl">菜单管理</li>
              <li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
              <li class="cs-fl cs-b-active">功能权限：${bean.functionName}</li>
              </li>
            </ol>
          <!-- 面包屑导航栏  结束-->
            <div class="cs-search-box cs-fr">
              <form action="datagrid.do">
                <div class="cs-search-filter clearfix cs-fl">
                <input type="hidden" class="focusInput" name="baseBean.functionId" value="${bean.id}"/>
                <input class="cs-input-cont cs-fl focusInput" type="text" name="baseBean.operationName" placeholder="请输入内容" />
                <input type="button" onclick="datagridUtil.queryByFocus();" class="cs-search-btn cs-fl" href="javascript:;" value="搜索">
                </div>
              	  <div class="clearfix cs-fr">
               		<a  id="showBtn" href="${webRoot}/system/menu/list.do" class="cs-menu-btn cs-fun-btn"><i class="icon iconfont icon-fanhui" ></i>返回</a>
	            </div>
              </form>
              
            </div>
          </div>

	<div id="dataList"></div>
	
	<!-- 编辑模态框 start -->
	<div class="modal fade intro2" id="addModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	  <div class="modal-dialog cs-mid-width" role="document">
	    <div class="modal-content ">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" id="myModalLabel">新增</h4>
	      </div>
	      <div class="modal-body cs-mid-height">
	         <!-- 主题内容 -->
	    <div class="cs-tabcontent" >
	      <div class="cs-content2">
	      	<form id="saveForm" method="post">
				<input type="hidden" name="id" >
				<input type="hidden" name="functionId" value="${bean.id}"/>
			    <table class="cs-add-new">
			    	 <ul class="cs-ul-form clearfix">
	                    <li  class="cs-name col-md-3" width="20% ">功能名称：</li>
	                    <li class="cs-in-style col-md-5" width="210px" >
	                    <input type="text" name="operationName" class="inputxt" datatype="*" nullmsg="请输入功能名称"/></li>
	                    <li class="col-md-4 cs-text-nowrap">
	                      <div class="Validform_checktip"></div>
	                        <div class="info"><i class="cs-mred">*</i>请输入功能名称
	                        </div>
	                    </li>
	                </ul>
			<!--        <ul class="cs-ul-form clearfix">
	                    <li  class="cs-name col-md-3" width="20% ">功能Code：</li>
	                    <li class="cs-in-style col-md-5" width="210px" >
	                    <input type="text" name="operationCode" class="inputxt" datatype="*" nullmsg="请输入功能Code"/></li>
	                    <li class="col-md-4 cs-text-nowrap">
	                      <div class="Validform_checktip"></div>
	                        <div class="info"><i class="cs-mred">*</i>请输入功能Code
	                        </div>
	                    </li>
	                </ul> -->
                   	<ul class="cs-ul-form clearfix">
	                    <li  class="cs-name col-md-3" width="20% ">图标：</li>
	                    <li class="cs-in-style col-md-5" width="210px" >
	                    <input type="text" name="functionIcon" class="inputxt" /></li>
				   	</ul>
                   	<ul class="cs-ul-form clearfix">
	                    <li  class="cs-name col-md-3" width="20% ">备注：</li>
	                    <li class="cs-in-style col-md-5" width="210px" >
	                    <input type="text" name="remark" class="inputxt" /></li>
				   	</ul>
                   	<ul class="cs-ul-form clearfix">
	                    <li  class="cs-name col-md-3" width="20% ">排序:</li>
	                    <li class="cs-in-style col-md-5" width="210px" >
	                    <input type="text" name="sorting" class="inputxt"/></li>
	               	</ul>
			    </table>
			</form>
	      </div>
	    </div>
	      </div>
	      <div class="modal-footer">
	      <button type="button" class="btn btn-success" id="btnSave">确定</button>
	        <button type="button" class="btn btn-default" data-dismiss="modal" id="btnCancel">关闭</button>
	      </div>

	    </div>
	  </div>
	</div>
	<!-- 编辑模态框 end -->
	<%@include file="/WEB-INF/view/common/confirm.jsp"%>
    <script src="${webRoot}/js/datagridUtil.js"></script>
    <script type="text/javascript">
    rootPath="${webRoot}/system/operation/";

    if (Permission.exist("514-1")) {
		var html='<a class="cs-menu-btn" onclick="getId();"><i class="'+Permission.getPermission("514-1").functionIcon+'"></i>新增</a>';
		$("#showBtn").before(html);
	}

    $(function(){
    	$("#saveForm").Validform({
    		tiptype:2,
    		 beforeSubmit:function(curform){//判断密码是否被修改过；若没有则设置密码为空不进行修改
   	    	  var formData = new FormData($('#saveForm')[0]);
	    			$.ajax({
	    		        type: "POST",
	    		        url: rootPath+"save.do",
	    		        data: formData,
	    		        contentType: false, //必须false才会避开jQuery对 formdata 的默认处理 XMLHttpRequest会对 formdata 进行正确的处理 
	    		        processData: false, //必须false才会自动加上正确的Content-Type
	    		        dataType: "json",
	    		        success: function(data){
	    		        	if(data && data.success){
	    		        		$("#addModal").modal("hide");
	    						 datagridUtil.query();
	    		        	}else{
	    		        		$("#waringMsg>span").html(data.msg);
	    		        		$("#confirm-warnning").modal('toggle');
	    		        	}
	    				}
	    		    });
 	    			return false;
   	    }
    	});
    	// 新增或修改
    	$("#btnSave").on("click", function() {
    		$("#saveForm").submit();
    		return false;
    	});
    	//关闭编辑模态框前重置表单，清空隐藏域
    	$('#addModal').on('hidden.bs.modal', function (e) {
			 var form = $("#saveForm");// 清空表单数据
	    	 form.form("reset");
	    	 $("input[name=id]").val("");
    	});
    	$("#addModal").on('show.bs.modal',function(e){
    		$(".registerform").Validform().resetForm();
    		$("input").removeClass("Validform_error");
    		$(".Validform_wrong").hide();
    		$(".info").show();
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
    })
    function getInfoObj(){
		return $(this).parents("li").next().find(".info");
	}
	var op = {
		tableId: "dataList",
		tableAction: "${webRoot}/system/operation/datagrid.do",
		parameter: [
			{
				columnCode: "operationName",
				columnName: "功能名称",
				query:1
			},
			{
				columnCode: "operationCode",
				columnName: "页面code"
			},
			{
				columnCode: "deleteFlag",
				columnName: "状态",
				customVal:{0:"可用",1:"禁用"}
			},
			{
				columnCode: "remark",
				columnName: "备注"
			}
		],
		funBtns: [
	    	{
				show: Permission.exist("514-2"),
				style: Permission.getPermission("514-2"),
	    		action: function(id){
	    			getId(id);
	    		}
	    	}, 
	    	{
				show: Permission.exist("514-4"),
				style: Permission.getPermission("514-4"),
	   			action : function(id) {
	   				idsStr = "{\"ids\":\"" + id.toString() + "\"}";
	   				$("#confirm-delete").modal('toggle');
   				}
	    	}
	    ],
		bottomBtns:[
			{
				show: Permission.exist("514-4"),
				style: Permission.getPermission("514-4"),
	    		action: function(ids){
	    			idsStr = "{\"ids\":\"" + ids.toString() + "\"}";
    				$("#confirm-delete").modal('toggle');
	    		}
			}
		]
	};
	datagridUtil.initOption(op);
    datagridUtil.queryByFocus();
    
    /**
     * 查询功能权限
     */
    function getId(id){
    	if(id){
	    	$.ajax({
		    	url:rootPath+"queryById.do",
		    	type:"POST",
		    	data:{"id":id},
		    	dataType:"json",
		    	success:function(data){
		    	      var form = $('#saveForm');
		    		  form.form('load', data.obj);
		    		  $(".info").hide();
		    	}
	    	});
	    	$("#addModal .modal-title").text("编辑");
	    	
		}else{
			$("#addModal .modal-title").text("新增");
		}
		$("#addModal").modal("show");
    }
    //绑定回车事件
    //document.onkeydown=keyDownSearch;
    </script>
  </body>
</html>
