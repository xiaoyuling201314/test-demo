<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/common/resource.jsp"%>
<html>
  <head>
    <title>快检服务云平台</title>
    <style type="text/css">
    .role-selcet i{
    	width:16px;
    	float:left;
    	margin-top: 4px;
    }
    .role-selcet label{
    	width:185px;
    	float:left;
    	word-break:keep-all;/* 不换行 */
		white-space:nowrap;/* 不换行 */
		overflow:hidden;/* 内容超出宽度时隐藏超出部分的内容 */
		text-overflow:ellipsis;/* 当对象内文本溢出时显示省略标记(...) ；需与overflow:hidden;一起使用。*/
    }
    </style>
  </head>
  <body>
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
	      	<form id="saveForm" action="${webRoot}/splitMember/save.do" method="post">
				<input type="hidden" name="id" >
			     <div width="100%" class="cs-add-new">
		          <ul class="cs-ul-form clearfix">
	                    <li  class="cs-name col-xs-3 col-md-3" width="20% ">子商户编号：</li>
	                    <li class="cs-in-style col-xs-4 col-md-5" >
							<input id="rolename" type="text" name="mbUserId" class="inputxt" datatype="*1-15" nullmsg="请输入子商户编号！" />
						</li>
					  <li class="col-md-4 col-xs-4 cs-text-nowrap">
						  <div class="Validform_checktip"></div>
						  <div class="info"><i class="cs-mred">*</i>请输入子商户编号
						  </div>
					  </li>
	                </ul>
                 	 <ul class="cs-ul-form clearfix">
	                    <li  class="cs-name col-xs-3 col-md-3" width="20% ">子商户名称：</li>
	                    <li class="cs-in-style col-xs-4 col-md-5" ><input type="text" name="mbUserName" class="inputxt" datatype="*1-15" nullmsg="请输入商户名称！"/></li>
						 <li class="col-md-4 col-xs-4 cs-text-nowrap">
							 <div class="Validform_checktip"></div>
							 <div class="info"><i class="cs-mred">*</i>请输入子商户名称
							 </div>
						 </li>
					 </ul>
			         <ul class="cs-ul-form clearfix">
	                    <li  class="cs-name col-xs-3 col-md-3" width="20% ">分账比例：</li>
	                    <li class="cs-in-style col-xs-4 col-md-5" >
							<input type="text" name="splitRate" class="inputxt" datatype="n" nullmsg="请输入1-100内的分账比例！" errormsg="请输入1-100的整数"
								   placeholder="请输入分账比例"  onkeyup="clearNoNum2(this)" onblur="clearNoNum2(this)" />
						</li>
						 <li class="col-md-4 col-xs-4 cs-text-nowrap">
							 <div class="Validform_checktip"></div>
							 <div class="info"><i class="cs-mred">*</i>请输入分账比例
							 </div>
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


	<%@include file="/WEB-INF/view/common/confirm.jsp"%>
    <script src="${webRoot}/js/datagridUtil2.js"></script>
    <script type="text/javascript">
    rootPath = '${webRoot}/splitMember/';

    $(function(){
    	//验证
    	var roleForm = $("#saveForm").Validform({
    		tiptype:3,
    		callback : function(data) {
				if (data.success) {
					self.location.reload();
				} else {
					$.Showmsg("操作失败："+data.msg);
				}
				return false;
			}
    	});

		// 新增或修改
		$("#btnSave").on("click", function(){
			roleForm.ajaxPost();
		});
		
		//关闭编辑模态框前重置表单，清空隐藏域
		$('#addModal').on('hidden.bs.modal', function(e){
			roleForm.resetForm();
			roleForm.resetStatus();
			$("input[type='hidden']").val("");
		});
		
    });

  	//关闭编辑模态框前重置表单，清空隐藏域
	$('#addModals').on('hidden.bs.modal', function(e){
		$("input[name=menuCheckBox]").prop("checked","");
		$("#roleId").val("");
	});
     
	var dgu = datagridUtil.initOption({
		tableId: "dataList",
		tableAction: "${webRoot}/splitMember/datagrid",
		funColumnWidth: "160px",
		tableBar: {
			title: ["系统管理","子商户管理"],
			hlSearchOff: 0,
			ele: [{
				eleShow: 1,
				eleName: "keyWords",
				eleType: 0,
				elePlaceholder: "请输入子商户编号或名称"
			}],
			topBtns: [{
				show: Permission.exist("1499-1"),
				style: Permission.getPermission("1499-1"),
				action: function(ids, rows){
					getId();
				}
			}]
		},
		parameter: [
   			{
   				columnCode: "mbUserId",
   				columnName: "子商户编号",
   				query: 1
   			},
   			{
   				columnCode: "mbUserName",
   				columnName: "子商户名称",
   				query: 1
   			},
   			{
   				columnCode: "splitRate",
   				columnName: "分账比例"
   			} 	
			
		],
		funBtns: [
	    	{
				show: Permission.exist("1499-2"),
				style: Permission.getPermission("1499-2"),
	    		action: function(id){
	    			getId(id);
	    		}
	    	},
	    	{
				show: Permission.exist("1499-3"),
				style: Permission.getPermission("1499-3"),
    			action : function(id) {
    				idsStr = "{\"ids\":\"" + id.toString() + "\"}";
    				$("#confirm-delete").modal('toggle');
    			}
    		}
	    ],
		bottomBtns:[]
		 
	});
	dgu.queryByFocus();
    
    /**
     * 新增/编辑角色
     */
    function getId(roleId){
    	if(roleId){
    		$("#addModal .modal-title").text("编辑");
	    	$.ajax({
		    	url: "${webRoot}/splitMember/queryById.do",
		    	type:"POST",
		    	data:{"id":roleId},
		    	dataType:"json",
		    	success:function(data){
		    		if (data && data.success) {
			    		$('#saveForm').form('load', data.obj);
			    		//编辑角色，不修改出厂编码情况下，不作验证
						$("#saveForm").find("input[name='rolename']").removeAttr("ajaxurl");
		    		}
		    	}
	    	});
    	}else{
    		$("#addModal .modal-title").text("新增");
    	}
    	$("#addModal").modal("show");
    }
    </script>
  </body>
</html>
