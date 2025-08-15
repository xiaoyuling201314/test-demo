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
	      	<form id="saveForm" action="${webRoot}/system/role/save.do" method="post">
				<input type="hidden" name="id" >
			     <div width="100%" class="cs-add-new">
		          <ul class="cs-ul-form clearfix">
	                    <li  class="cs-name col-xs-3 col-md-3" width="20% ">角色名称：</li>
	                    <li class="cs-in-style col-xs-9 col-md-9" ><input id="rolename" type="text" name="rolename" class="inputxt" datatype="*1-15" nullmsg="请输入角色名称！" errormsg="角色名称至少1个字符,最多15个字符！" /></li>
	                </ul>
                 	 <ul class="cs-ul-form clearfix">
	                    <li  class="cs-name col-xs-3 col-md-3" width="20% ">角色描述：</li>
	                    <li class="cs-in-style col-xs-9 col-md-9" ><input type="text" name="remark" class="inputxt" /></li>
	                </ul>
			         <ul class="cs-ul-form clearfix">
	                    <li  class="cs-name col-xs-3 col-md-3" width="20% ">排序：</li>
	                    <li class="cs-in-style col-xs-9 col-md-9" >
							<input type="text" name="sorting" class="inputxt"  onkeyup="clearNoNum2(this)" onblur="clearNoNum2(this)"/>
						</li>
	                </ul>
			       <ul class="cs-ul-form clearfix">
	                   	<li  class="cs-name col-xs-3 col-md-3">角色状态：</li>
	                   	<li class="cs-al cs-modal-input">
				        	<input id="cs-check-radio" type="radio" value="0" name="status"/><label for="cs-check-radio">启用</label>
				        	<input id="cs-check-radio2" type="radio" value="1" name="status" checked="checked" /><label for="cs-check-radio2">停用</label>
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
	<!-- 角色配置 s -->
	<div class="modal fade intro2" id="addModals" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
		<div class="modal-dialog cs-lg-width" role="document">
			<div class="modal-content ">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabels">角色配置</h4>
				</div>
				<div class="modal-body cs-lg-height" style="padding: 10px 0;">
					<!-- 主题内容 -->
					<div class="cs-main">
						<div class="cs-wraper">
							<form class="saveform" id="saveforms">
								<input type="hidden" name="id" id="roleId">
								<div width="100%" class="cs-add-new">
									<ul class="cs-ul-form clearfix">
										<li class="cs-name col-md-2">当前角色：</li>
										<li class="cs-in-style col-md-6"><span name="detectMethod" id="detectMethod"></span></li>
										<li class="col-md-4 cs-text-nowrap"></li>
									</ul>
									<ul class="cs-ul-form clearfix role-selcet" style="background: #e4f3e3;">
										<li class="cs-name col-md-2">角色配置：</li>
										<li class="col-md-10 clearfix role-list">
											<%--<c:forEach items="${list}" var="listmenu" varStatus="firstIndex">
												<span class="checkbox-input col-md-4"><i><input id="${listmenu.id}" name="menuCheckBox" value="${listmenu.id}" type="checkbox"/></i><label title="${listmenu.rolename}" for="${listmenu.id}">${listmenu.rolename}</label></span>
											</c:forEach>--%>
										</li>
									</ul>
								</div>
							</form>
						</div>
					</div>
				</div>
				<div class="modal-footer action">
					<button type="button" class="btn btn-success" id="btnSaves">保存</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				</div>
			</div>
		</div>
	</div>
	<!-- 角色配置 e -->


	<%--复制角色--%>
	<div class="modal fade intro2" id="copyModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog cs-alert-width">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
					<h4 class="modal-title">确认</h4>
				</div>
				<div class="modal-body cs-alert-height cs-dis-tab">
					<div class="cs-text-algin">
						<img src="${webRoot}/img/warn.png" width="40px"/>
						<span class="tips">复制角色？</span>
					</div>
				</div>
				<div class="modal-footer">
					<a class="btn btn-success btn-ok" data-dismiss="modal" onclick="copyConfirm();">确认</a>
					<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
				</div>
			</div>
		</div>
	</div>

	<%@include file="/WEB-INF/view/common/confirm.jsp"%>
    <script src="${webRoot}/js/datagridUtil2.js"></script>
    <script type="text/javascript">
    rootPath = '${webRoot}/system/role/';

    for (var i = 0; i < childBtnMenu.length; i++) {
		if (childBtnMenu[i].operationCode == "512-5") {
			exports = 1;
			exportObj=childBtnMenu[i];
		}
	}
    
    $(function(){
    	//验证
    	var roleForm = $("#saveForm").Validform({
    		tiptype:3,
    		callback : function(data) {
				if (data.success) {
					self.location.reload();
				} else {
					$.Showmsg("操作失败");
				}
				return false;
			}
    	});
    	
		//角色名称验证
		$("#rolename").change(function(){
			roleForm.addRule([
				{
					ele: "#rolename",
					datatype: "*1-15",
					ajaxurl: "${webRoot}/system/role/selectByRoleName.do?roleId=" + $("input[name='id']").val() + "&roleName=" + $(this).val(),
					nullmsg: "请输入角色名称",
					errormsg: "角色名称至少1个字符,最多15个字符"
				}
			]);
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
    
    $("#btnSaves").on("click", function(){
    	//获取所有被勾选的角色id
		var cbs = document.getElementsByName("menuCheckBox");
		var menuIds = [];
		for (var i = 0; i < cbs.length; i++) {
			if (cbs[i].checked == true) {
				menuIds.push(cbs[i].value);
			}
		}
		var childrenId=menuIds.toString();
		$.ajax({
			type : "POST",
			url : "${webRoot}/system/role/save.do",
			data : {"childrenId":childrenId,"id":$("#roleId").val()},
			success : function(data) {
				if (data && data.success) {
					$("#addModals").modal('hide');
				} else {
					$("#confirm-warnning .tips").text("操作失败");
					$("#confirm-warnning").modal('toggle');
				}
			}
		});
	});
    
  	//关闭编辑模态框前重置表单，清空隐藏域
	$('#addModals').on('hidden.bs.modal', function(e){
		$("input[name=menuCheckBox]").prop("checked","");
		$("#roleId").val("");
	});
     
	var dgu = datagridUtil.initOption({
		tableId: "dataList",
		tableAction: "${webRoot}/system/role/datagrid",
		funColumnWidth: "160px",
		tableBar: {
			title: ["系统管理","角色管理"],
			hlSearchOff: 0,
			ele: [{
				eleShow: 1,
				eleName: "baseBean.rolename",
				eleType: 0,
				elePlaceholder: "请输入角色名称"
			}],
			topBtns: [{
				show: Permission.exist("512-1"),
				style: Permission.getPermission("512-1"),
				action: function(ids, rows){
					getId();
				}
			}]
		},
		parameter: [
   			{
   				columnCode: "rolename",
   				columnName: "角色名称",
   				query: 1
   			},
   			{
   				columnCode: "remark",
   				columnName: "角色描述",
   				query: 1
   			},
   			{
   				columnCode: "status",
   				columnName: "状态",
   				query: 1,
   				customVal:{0:"<span class='text-success'>启用</span>",1:"<span class='text-danger'>停用</span>"},
				columnWidth: '90px'
   			} 	
			
		],
		funBtns: [
	    	{
				show: Permission.exist("512-2"),
				style: Permission.getPermission("512-2"),
	    		action: function(id){
	    			getId(id);
	    		}
	    	},
	    	{
				show: Permission.exist("512-3"),
				style: Permission.getPermission("512-3"),
	    		action: function(id){
	    			self.location = "${webRoot}/system/role/permission.do?id=" + id+"&functionType=0";
	    		}
	    	},
    		{
				show: Permission.exist("512-6"),
				style: Permission.getPermission("512-6"),
    			action : function(id) {
    				$("#roleId").val(id);
    				getIds(id);
    				$("#addModals").modal('toggle');
    			}
    		},
    		{
				show: Permission.exist("512-7"),
				style: Permission.getPermission("512-7"),
    			action : function(id) {
					//复制角色
					copyRoleId = id;
					$("#copyModal").modal("show");
    			}
    		},
	    	{
				show: Permission.exist("512-4"),
				style: Permission.getPermission("512-4"),
    			action : function(id) {
    				idsStr = "{\"ids\":\"" + id.toString() + "\"}";
    				$("#confirm-delete").modal('toggle');
    			}
    		}
	    ],
		bottomBtns:[
			{
				show: Permission.exist("512-4"),
				style: Permission.getPermission("512-4"),
	    		action: function(ids){
					if(ids == ''){
						$("#confirm-warnning .tips").text("请选择要删除的角色");
						$("#confirm-warnning").modal('toggle');
					}else {
	    			idsStr = "{\"ids\":\"" + ids.toString() + "\"}";
    				$("#confirm-delete").modal('toggle');
	    		}
		    }
		    }
		]
		 
	});
	dgu.queryByFocus();
    
    /**
     * 新增/编辑角色
     */
    function getId(roleId){
    	if(roleId){
    		$("#addModal .modal-title").text("编辑");
	    	$.ajax({
		    	url: "${webRoot}/system/role/queryById.do",
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
    
    //循环勾选已配置角色
    function getIds(id){
    	$.ajax({
	    	url: "${webRoot}/system/role/queryByIds.do",
	    	type:"POST",
	    	data:{"id":id},
	    	dataType:"json",
	    	success:function(data){
	    		if (data && data.success) {
					$(".role-list").empty("");
	    			$("#detectMethod").text(data.attributes.role.rolename);
	    			let choseRoleIds=(data.attributes.role.childrenId).split(",")
	    			let list = data.obj;
					list.forEach(listmenu=>{
						let checked=false;
						let html='';
						if(choseRoleIds.length>0){
							for(let i=0; i<choseRoleIds.length; i++) {
								if(choseRoleIds[i]==listmenu.id){
									checked=true;
									break;
								}
							}
						}
						if(checked){
							html='<span class="checkbox-input col-md-4"><i><input id="'+listmenu.id+'" checked="'+checked+'" name="menuCheckBox" value="'+listmenu.id+'" type="checkbox"/></i><label title="'+listmenu.rolename+'" for="'+listmenu.id+'">'+listmenu.rolename+'</label></span>';
						}else{
							html='<span class="checkbox-input col-md-4"><i><input id="'+listmenu.id+'" name="menuCheckBox" value="'+listmenu.id+'" type="checkbox"/></i><label title="'+listmenu.rolename+'" for="'+listmenu.id+'">'+listmenu.rolename+'</label></span>';
						}
						$(".role-list").append(html);
					});
	    		}
	    	}
    	});
	}


	var copyRoleId;
    //复制角色
	function copyConfirm(){
		$.ajax({
			url: "${webRoot}/system/role/copyRole",
			type:"POST",
			data:{"id": copyRoleId},
			dataType:"json",
			success:function(data){
				if (data && data.success) {
					dgu.queryByFocus();
				} else {
					$("#confirm-warnning .tips").text(data.msg);
					$("#confirm-warnning").modal('toggle');
				}
			}
		});
	}
    </script>
  </body>
</html>
