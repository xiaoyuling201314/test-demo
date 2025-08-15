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
              <a href="javascript:">进货台账</a></li>
              <li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
              <li class="cs-b-active cs-fl">监管类型</li>
            </ol>
          <!-- 面包屑导航栏  结束-->
            <div class="cs-search-box cs-fr">
              <form action="datagrid.do">
                <div class="cs-search-filter clearfix cs-fl">
                <input class="cs-input-cont cs-fl focusInput" type="text" name="regulatoryType.regType" placeholder="请输入监管对象类型" />
                <input type="button" onclick="datagridUtil.queryByFocus();" class="cs-search-btn cs-fl" href="javascript:;" value="搜索">
                <!-- <span class="cs-s-search cs-fl">高级搜索</span> -->
                </div>
               <div class="clearfix cs-fr" id="showBtn">
              </div>
              </form>
            </div>
          </div>
	<div id="dataList"></div>
  	<div class="modal fade intro2" id="myModal2" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	  <div class="modal-dialog cs-mid-width" role="document">
	    <div class="modal-content ">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title">新增</h4>
	      </div>
	      <div class="modal-body cs-mid-height">
	         <!-- 主题内容 -->
	    <div class="cs-tabcontent" >
	      <div class="cs-content2">
	      <form id="saveForm" method="post" action="${webRoot}/ledger/regulatoryType/save.do">
			<input type="hidden" name="id" >
		    <table class="cs-add-new">
		      <tr>
		        <td class="cs-name"><i class="cs-mred">*</i>类型名称：</td>
		        <td class="cs-in-style">
		          <input type="text" name="regType" datatype="*" nullmsg="请输入监督对象类型名称" errormsg="请输入监督对象类型名称" />
		        </td>
		      </tr>
		      <tr>
		        <td class="cs-name"><i class="cs-mred">*</i>类型编码：</td>
		        <td class="cs-in-style">
		          <input type="text" name="regTypeCode" datatype="*" nullmsg="请输入监督对象类型编码" errormsg="请输入监督对象类型编码" />
		        </td>
		      </tr>
		      <tr>
		      	 <td class="cs-name"><i class="cs-mred">*</i>经营户：</td>
			     <td class="cs-in-style cs-radio">
			        <input id="business-radio0" type="radio" value="0" name="showBusiness" checked="checked"/><label for="business-radio0">无</label>
			        <input id="business-radio1" type="radio" value="1" name="showBusiness"/><label for="business-radio1">有</label>
		         </td>
		      </tr>
		      <tr>
		      	 <td class="cs-name"><i class="cs-mred">*</i>状态：</td>
			     <td class="cs-in-style cs-radio">
			        <input id="cs-check-radio1" type="radio" value="1" name="checked" checked="checked"/><label for="cs-check-radio1">已审核</label>
			        <input id="cs-check-radio0" type="radio" value="0" name="checked"/><label for="cs-check-radio0">未审核</label>
		         </td>
		      </tr>
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
    <%@include file="/WEB-INF/view/common/confirm.jsp"%>
	<script src="${webRoot}/js/datagridUtil.js"></script>
    <script type="text/javascript">
   	for (var i = 0; i < childBtnMenu.length; i++) {
   		if (childBtnMenu[i].operationCode == "1373-1") {
   			var html='<a class="cs-menu-btn" href="#myModal2"  data-toggle="modal"><i class="'+childBtnMenu[i].functionIcon+'"></i>新增</a>';
   			$("#showBtn").append(html);
   		}else if (childBtnMenu[i].operationCode == "1373-2") {
   			edit = 1;
   			editObj=childBtnMenu[i];
   		}else if (childBtnMenu[i].operationCode == "1373-3") {
   			deletes = 1;
   			deleteObj=childBtnMenu[i];
   		}
   	} 
   	var demo = $("#saveForm").Validform({
    		callback:function(data){
   				//$.Hidemsg();
    			if(data.success){
    				$("#myModal2").modal("hide");
					 datagridUtil.query();
    			}else{
    				//$.Showmsg(data.msg);
    			}
    		}
    	});
    	// 新增或修改
    	$("#btnSave").on("click", function() {
    		$("#saveForm").submit();
    		return false;
    	});
    	$("#saveForm").Validform(
				{
					tiptype : 2,
					beforeSubmit : function() {
						demo.ajaxPost();
						},callback:function(data){
						}
				
				});
    	//关闭编辑模态框前重置表单，清空隐藏域
    	$('#myModal2').on('hidden.bs.modal', function (e) {
    		$("#saveForm").form("reset");
    		$("#saveForm input[name='id']").val("");
    		$("#saveForm input[name='regType']").val("");
    		$("#saveForm input[name='regTypeCode']").val("");
    		$("#cs-check-radio1").prop("checked",true);
    		$("#business-radio0").prop("checked",true);
    	});
	var op = {
		tableId: "dataList",	//列表ID
		tableAction: '${webRoot}'+"/ledger/regulatoryType/datagrid.do",	//加载数据地址
		funColumnWidth: "150px",
		parameter: [		//列表拼接参数
			{
				columnCode: "regType",
				columnName: "类型名称"
			},
			{
				columnCode: "regTypeCode",
				columnName: "类型编码"
			},
			{
				columnCode: "checked",
				columnName: "状态",
				customVal:{"0":"<div class=\"text-danger\">未审核</div>","1":"<div class=\"text-primary\">已审核</div>"}
			}
		],
		funBtns: [
	    	{
	    		show: edit,
	    		style: editObj,
	    		action: function(id){
	    			$("#myModal2").modal("show");
	    			getId(id);
	    		}
	    	},
	    	 {
	    		show: deletes,
	    		style: deleteObj,
	    		action: function(id){
	    			deleteIds = id;
	    			$("#confirm-delete").modal('toggle');
	    		}
	    	}
	    ],	//功能按钮 
		bottomBtns: [
			{	//删除函数	
				show: deletes,
				style: deleteObj,
	    		action: function(ids){
	    			if(ids == ""){
	    				$("#confirm-warnning .tips").text("请选择监管类型");
		    			$("#confirm-warnning").modal('toggle');
	    			}else{
		    			deleteIds = ids;
		    			$("#confirm-delete").modal('toggle');
	    			}
	    		}
		    }
		] 
	};
	datagridUtil.initOption(op);
	
    datagridUtil.query();
    
    /**
     * 查询监管对象类型
     */
    function getId(id){
    	$.ajax({
	    	url:"${webRoot}/ledger/regulatoryType/queryById.do",
	    	type:"POST",
	    	data:{"id":id},
	    	dataType:"json",
	    	success:function(data){
	    		if(data && data.success && data.obj){
		    		$("#myModal2 input[name='id']").val(data.obj.id);
		    		$("#myModal2 input[name='regType']").val(data.obj.regType);
		    		$("#myModal2 input[name='regTypeCode']").val(data.obj.regTypeCode);
		    		if(data.obj.showBusiness == "1"){
			    		$("#business-radio1").prop("checked",true);
		    		}else{
		    			$("#business-radio0").prop("checked",true);
		    		}
		    		if(data.obj.checked == "1"){
			    		$("#cs-check-radio1").prop("checked",true);
		    		}else{
		    			$("#cs-check-radio0").prop("checked",true);
		    		}
	    		}
	    	}
    	});
    }
    
    //删除
    var deleteIds = "";
    function deleteData(){
    	$.ajax({
	        type: "POST",
	        url: '${webRoot}'+"/ledger/regulatoryType/delete.do",
	        data: {"ids":deleteIds.toString()},
	        dataType: "json",
	        success: function(data){
	        	if(data && data.success){
		        	datagridUtil.query();
	        	}else{
	        		$("#confirm-warnning .tips").text("删除失败");
	    			$("#confirm-warnning").modal('toggle');
	        	}
			}
	    });
		$("#confirm-delete").modal('toggle');
    }
    </script>
  </body>
</html>
