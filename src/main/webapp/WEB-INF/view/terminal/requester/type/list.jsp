<%@page import="java.util.Date"%>
<%@page import="org.apache.velocity.runtime.directive.Include"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/common/resource.jsp"%>
<html>
  <head>
    <title>快检服务云平台</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link rel="stylesheet" type="text/css" href="${webRoot}/css/fileinput.css" />
	<link rel="stylesheet" type="text/css" href="${webRoot}/css/theme.css" />
    <!-- 上传 -->
	<script src="${webRoot}/js/sortable.js" type="text/javascript"></script>
	<script src="${webRoot}/js/fileinput.js" type="text/javascript"></script>
	<script src="${webRoot}/js/zh.js" type="text/javascript"></script>
	<script src="${webRoot}/js/theme.js" type="text/javascript"></script>
  </head>
  <body>
          <div class="cs-col-lg clearfix">
          <!-- 面包屑导航栏  开始-->
            <ol class="cs-breadcrumb">
              <li class="cs-fl">
              <img src="${webRoot}/img/set.png" alt="" />
              <a href="javascript:">客户管理</a></li>
              <li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
              <li class="cs-b-active cs-fl">委托单位类型
              </li>
            </ol>
          <!-- 面包屑导航栏  结束-->
            <div class="cs-search-box cs-fr">
              <form action="datagrid.do">
                <div class="cs-search-filter clearfix cs-fl">
                <input class="cs-input-cont cs-fl focusInput" type="text" name="keyWords" placeholder="请输入内容" />
                <input type="button" onclick="datagridUtil.queryByFocus();" class="cs-search-btn cs-fl" href="javascript:;" value="搜索">
<!--                 <span class="cs-s-search cs-fl">高级搜索</span> -->
                </div>
               <div class="clearfix cs-fr" id="showBtn">
              </div>
              </form>
              
            </div>
          </div>

	<div id="dataList"></div>
	<!-- 新增编辑模态框 -->
  	<div class="modal fade intro2" id="myModal2" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
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
	      <form id="saveForm" enctype="multipart/form-data">
			<input type="hidden" name="id" >
			 <div width="100%" class="cs-add-new">
				 <ul class="cs-ul-form clearfix">
                    <li  class="cs-name col-xs-3 col-md-3" width="20% ">单位类型：</li>
                    <li class="cs-in-style cs-modal-input" width="210px" >
                    <input type="text" name="unitType" class="inputxt" datatype="*" nullmsg="请输入单位类型" /></li>
                    <li class="col-xs-4 col-md-4 cs-text-nowrap">
                      <div class="Validform_checktip"></div>
                        <div class="info"><i class="cs-mred">*</i>请输入单位类型
                        </div>
                    </li>
                </ul>
                 <ul class="cs-ul-form clearfix">
                    <li  class="cs-name col-xs-3 col-md-3" width="20% ">覆盖类型：</li>
                    <li class="cs-in-style cs-modal-input" width="210px" >
	                    <select class="cs-in-style" name="coverageType">
							<option value="0">日覆盖</option>
							<option value="1">周覆盖</option>
							<option value="2">月覆盖</option>
						</select>
                    </li>
                </ul>
                 <ul class="cs-ul-form clearfix">
                    <li  class="cs-name col-xs-3 col-md-3" width="20% ">排序：</li>
                    <li class="cs-in-style cs-modal-input" width="210px" >
                    <input type="text" name="sorting" class="inputxt" ignore="ignore" datatype="n" nullmsg="请输入序号"  errormsg="请输入正确的数字"/></li>
                </ul>
                 <ul class="cs-ul-form clearfix">
                    <li  class="cs-name col-xs-3 col-md-3" width="20% ">审核状态：</li>
                    <li class="cs-al cs-modal-input">
	         		    <input id="cs-check-radio2" type="radio" value="1" name="checked"  /><label for="cs-check-radio2" >已审核</label>
     					<input id="cs-check-radio" type="radio" value="0" name="checked" checked="checked" /><label for="cs-check-radio">未审核</label>
                    </li>
                </ul>
                 <ul class="cs-ul-form clearfix">
                    <li  class="cs-name col-xs-3 col-md-3" width="20% ">备注：</li>
                    <li class="cs-in-style cs-modal-input" width="210px" >
                    <textarea class="cs-remark" name="remark" id="" cols="30" rows="10"></textarea></li>
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
	<script src="${webRoot}/js/datagridUtil.js"></script>
    <script type="text/javascript">
    rootPath="${webRoot}/requester/type/";
	if(Permission.exist("1488-1")){
		var html='<a class="cs-menu-btn" onclick="getId();"><i class="'+Permission.getPermission("1488-1").functionIcon+'"></i>新增</a>';
		$("#showBtn").append(html);
	}
    $(function(){
    	//表单验证
    	$("#saveForm").Validform({
    		tiptype:2,
    		beforeSubmit:function(){
    			var formData = new FormData($('#saveForm')[0]);
    			$.ajax({
    		        type: "POST",
    		        url: "${webRoot}/requester/type/save.do",
    		        data: formData,
    		        contentType: false, //必须false才会避开jQuery对 formdata 的默认处理 XMLHttpRequest会对 formdata 进行正确的处理 
    		        processData: false, //必须false才会自动加上正确的Content-Type
    		        dataType: "json",
    		        success: function(data){
    		        	if(data && data.success){
    		        		$("#myModal2").modal("hide");
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
    	$('#myModal2').on('hidden.bs.modal', function (e) {
			 var form = $("#saveForm");// 清空表单数据
	    	 form.form("reset");
    		 $("input[name=id]").val("");
    		 form.Validform().resetForm();
    		$("input").removeClass("Validform_error");
    		$(".Validform_wrong").hide();
    		$(".Validform_checktip").hide();
    		$(".info").show();
    	})
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
    });
	var op = {
		tableId: "dataList",	//列表ID
		tableAction: "${webRoot}/requester/type/datagrid.do",	//加载数据地址
		parameter: [		//列表拼接参数
			{
				columnCode: "unitType",
				columnName: "类型名称",
				query: 1,
				columnWidth: "20%",
			},
			{
				columnCode: "coverageType",
				columnName: "覆盖类型",
				query: 1,
				columnWidth: "10%",
				customVal: {"0":"日覆盖","1":"周覆盖","2":"月覆盖"}
			},{
				columnCode: "sorting",
				columnName: "排序",
				query: 1,
				columnWidth: "8%",
			},{
				columnCode: "createDate",
				columnName: "创建日期",
				query: 1,
				queryType:1,
				columnWidth: "10%",
			},
			{
				columnCode: "checked",
				columnName: "状态",
				query: 1,
				columnWidth: "10%",
				customVal: {"0":"<div class=\"text-danger\">未审核</div>","1":"<div class=\"text-primary\">已审核</div>"},
			}
			
		],
		funBtns: [
	    	{
	    		show: Permission.exist("1488-2"),
	    		style: Permission.getPermission("1488-2"),
	    		action: function(id){
	    			$("#myModal2").modal("show");
	    			getId(id);
	    		}
	    	},
	    	{
	    		show: Permission.exist("1488-3"),
	    		style: Permission.getPermission("1488-3"),
	    		action: function(id){
	    			idsStr="{\"ids\":\""+id.toString()+"\"}";
	    			$("#confirm-delete").modal('toggle');
	    		}
	    	}
	    ],	//功能按钮 
		rowTotal: 0,	//记录总数
		pageSize: pageSize,	//每页数量
		pageNo: 1,	//当前页序号
		pageCount: 1,	// 总页数
		bottomBtns: [
			{	//删除函数	
					show: Permission.exist("1488-3"),
					style: Permission.getPermission("1488-3"),
		    		action: function(ids){
		    			if(ids == ''){
			    			$("#confirm-warnning .tips").text("请选择数据");
			    			$("#confirm-warnning").modal('toggle');
		    			}else{
			    			idsStr = "{\"ids\":\""+ids.toString()+"\"}";
			    			$("#confirm-delete").modal('toggle');
		    			}
		    		}
		    }
		]
		
	};
	datagridUtil.initOption(op);
	
    datagridUtil.query();
    
    /**
     * 查询检测标准信息
     */
    function getId(id){
    	if(id){
	    	$.ajax({
		    	url:"${webRoot}//requester/type/queryById.do",
		    	type:"POST",
		    	data:{"id":id},
		    	dataType:"json",
		    	success:function(data){
		   			  $(".info").hide();
		    	      var form = $('#saveForm');
		    		  form.form('load', data.obj);
		    		  $("[name=checked][value="+data.obj.checked+"]").prop("checked","checked");
		    	}
	    	});
			$("#myModal2 .modal-title").text("编辑");
			
		}else{
			$("#myModal2 .modal-title").text("新增");
		}
		$("#myModal2").modal("show");
    }
    </script>
  </body>
</html>
