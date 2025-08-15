<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/common/resource.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="${webRoot}/css/fileinput.css" />
<link rel="stylesheet" type="text/css" href="${webRoot}/css/theme.css" />
</head>
<!-- 上传 -->
<script src="${webRoot}/js/sortable.js" type="text/javascript"></script>
<script src="${webRoot}/js/fileinput.js" type="text/javascript"></script>
<script src="${webRoot}/js/zh.js" type="text/javascript"></script>
<script src="${webRoot}/js/theme.js" type="text/javascript"></script>
  <body>
          <div class="cs-col-lg clearfix">
          <!-- 面包屑导航栏  开始-->
            <ol class="cs-breadcrumb">
              <li class="cs-fl">
              <img src="${webRoot}/img/set.png" alt="" />
              <a href="javascript:">数据中心</a></li>
              <li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
              <li class="cs-b-active cs-fl">仪器类型维护
              </li>
            </ol>
          <!-- 面包屑导航栏  结束-->
            <div class="cs-search-box cs-fr">
              <form action="datagrid.do">
                <div class="cs-search-filter clearfix cs-fl">
                <input class="cs-input-cont cs-fl focusInput" type="text" name="baseBean.deviceName" placeholder="请输入内容" />
                <input type="button" onclick="datagridUtil.queryByFocus();" class="cs-search-btn cs-fl" href="javascript:;" value="搜索">
                </div>
               <div class="clearfix cs-fr" id="showBtn">
              </div>
              </form>
              
            </div>
          </div>

	<div id="dataList"></div>
	
	<!-- 编辑模态框 start -->
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
	      <form id="saveForm" method="post" action="${webRoot}/data/deviceSeries/save.do" enctype="multipart/form-data">
			<input type="hidden" name="id" >
		     <div width="100%" class="cs-add-new">
		       <ul class="cs-ul-form clearfix">
                    <li  class="cs-name col-xs-3 col-md-3" width="20% ">类型名称：</li>
                    <li class="cs-in-style cs-modal-input" width="210px" >
                    <input type="text" name="deviceName" datatype="*" nullmsg="请输入类型名称" />
                    </li>
                    <li class="col-xs-4 col-md-4 cs-text-nowrap">
                      <div class="Validform_checktip"></div>
                        <div class="info"><i class="cs-mred">*</i>请输入类型名称
                        </div>
                    </li>
                </ul>
				<ul class="cs-ul-form clearfix">
                    <li  class="cs-name col-xs-3 col-md-3" width="20% ">仪器系列：</li>
                    <li class="cs-in-style cs-modal-input" width="210px" >
                    <input type="text" value="" name="deviceSeries" datatype="*" nullmsg="请输入仪器系列" errormsg="请输入仪器系列"/>
                    </li>
                    <li class="col-xs-4 col-md-4 cs-text-nowrap">
                      <div class="Validform_checktip"></div>
                        <div class="info"><i class="cs-mred">*</i>请输入仪器系列
                        </div>
                    </li>
                </ul>
                <ul class="cs-ul-form clearfix">
                    <li  class="cs-name col-xs-3 col-md-3" width="20% ">生产厂家：</li>
                    <li class="cs-in-style cs-modal-input" width="210px" >
                    <input type="text" value="" name="deviceMaker" datatype="*" nullmsg="请输入生产厂家" errormsg="请输入生产厂家"/>
                    </li>
                    <li class="col-xs-4 col-md-4 cs-text-nowrap">
                      <div class="Validform_checktip"></div>
                        <div class="info"><i class="cs-mred">*</i>请输入生产厂家
                        </div>
                    </li>
                </ul>
                <ul class="cs-ul-form clearfix">
                    <li  class="cs-name col-xs-3 col-md-3" width="20% ">仪器图片：</li>
                    <li class="cs-in-style cs-modal-input" width="210px" >
                    <div style="width:200px;">
						<input type="file" id="myFile" name="filePathImage"/>
					</div>
                    </li>
                </ul>
                <ul class="cs-ul-form clearfix">
                    <li  class="cs-name col-xs-3 col-md-3" width="20% ">状态：</li>
                    <li class="cs-al cs-modal-input">
	         		    <input id="cs-check-radio" type="radio" value="1" name="checked" /><label for="cs-check-radio">已审核</label>
			        <input id="cs-check-radio2" type="radio" value="0" name="checked" checked="checked" /><label for="cs-check-radio2">未审核</label>
                    </li>
                </ul>
                <ul class="cs-ul-form clearfix">
                    <li  class="cs-name col-xs-3 col-md-3" width="20% ">功能描述：</li>
                    <li class="cs-in-style cs-modal-input" width="210px">
	         		  <textarea class="cs-remark" name="description" cols="30" rows="10"></textarea>
         		  </li>
                </ul>
		    </div>
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
	  <script src="${webRoot}/js/jquery.form.js"></script>
    <script src="${webRoot}/js/datagridUtil.js"></script>
    <script type="text/javascript">
    rootPath="${webRoot}/data/deviceSeries/";
    var checkItems=0;
    var checkItemObj;
   	for (var i = 0; i < childBtnMenu.length; i++) {
   		if (childBtnMenu[i].operationCode == "414-1") {
   			var html='<a class="cs-menu-btn" onclick="getId();"><i class="'+childBtnMenu[i].functionIcon+'"></i>新增</a>';
   			$("#showBtn").append(html);
   		}else if (childBtnMenu[i].operationCode == "414-2") {
   			edit = 1;
   			editObj=childBtnMenu[i];
   		}else if (childBtnMenu[i].operationCode == "414-3") {
   			checkItems = 1;
   			checkItemObj=childBtnMenu[i];
   		}else if (childBtnMenu[i].operationCode == "414-4") {
   			deletes = 1;
   			deleteObj=childBtnMenu[i];
   		}else if (childBtnMenu[i].operationCode == "414-5") {
   			exports = 1;
   			exportObj=childBtnMenu[i];
   		}
   	} 
    $(function(){
     	$("#saveForm").Validform({
     		tiptype:2,
     		beforeSubmit:function(curform){
				$("#saveForm").ajaxSubmit({
					type:'post',
					url:rootPath+'save.do',
					success: function(data){
		    			if(data.success){
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
    		$("#saveForm").submit()
    		return false;
    	});
    	//关闭编辑模态框前重置表单，清空隐藏域
    	$('#addModal').on('hidden.bs.modal', function (e) {
			 var form = $("#saveForm");// 清空表单数据
	    	 form.form("reset");
	    	 $("input[name=id]").val("");
	    	 $("#saveForm").Validform().resetForm();
    		$("input").removeClass("Validform_error");
    		$(".Validform_wrong").hide();
    		$(".Validform_checktip").hide();
    		$(".info").show();
    	})
    	//上传控件
    	 $("#myFile").fileinput({
	            'theme': 'explorer',
	            'uploadUrl': '#',
	            textEncoding:'UTF-8',
	            language: 'zh', 
	            overwriteInitial: false,
	            initialPreviewAsData: true,
	            dropZoneEnabled: false,
	            showClose:false,
	            showPreview:false,
	            //maxFileCount:10,
	            browseLabel:'浏览'
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
		tableId: "dataList",	//列表ID
		tableAction: '${webRoot}'+"/data/deviceSeries/datagrid.do",	//加载数据地址
		parameter: [		//列表拼接参数
				{
					columnCode: "deviceName",
					columnName: "类型名称"
				},
				{
					columnCode: "deviceSeries",
					columnName: "仪器系列",
					query: 1
				},
				{
					columnCode: "deviceMaker",
					columnName: "生产厂家"
				}
				,
				{
					columnCode: "checked",
					columnName: "状态",
					query: 1,
					customVal: {"0":"<div class=\"text-danger\">未审核</div>","1":"<div class=\"text-primary\">已审核</div>"},
                    columnWidth: "100px"		//列宽度
				}
			
		],
		funBtns: [
	    	{
	    		show: edit,
	    		style: editObj,
	    		action: function(id){
	    			$("#addModal").modal("show");
	    			getId(id);
	    		}
	    	},
	    	{
	    		show: checkItems,
	    		style: checkItemObj, 
	    		action: function(id){
	    			window.location = '${webRoot}'+"/data/deviceSeries/detectParameter/list.do?id="+id;
	    		}
	    	},
	    	{
	    		show: deletes,
	    		style: deleteObj,
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
				show: deletes,
    			style: deleteObj,
	    		action: function(ids){
                    if(ids == ''){
                        $("#confirm-warnning .tips").text("请选择要删除的仪器类型");
                        $("#confirm-warnning").modal('toggle');
                    }else {
                        idsStr = "{\"ids\":\"" + ids.toString() + "\"}";
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
		    	url:rootPath+"queryById.do",
		    	type:"POST",
		    	data:{"id":id},
		    	dataType:"json",
		    	success:function(data){
		    		  $(".info").hide();
		    	      var form = $('#saveForm');
		    		  form.form('load', data.obj);
		    		  $("[name=checked][value="+data.obj.checked+"]").prop("checked","checked");
		    		  data.obj.filePath=data.obj.filePath=='' ? "" : data.obj.filePath.substring(data.obj.filePath.lastIndexOf("/")+1,data.obj.filePath.length);
		//     		  $(".file-caption-name").html("<i class='glyphicon glyphicon-file kv-caption-icon'></i>"+data.obj.filePath);
		    		  $(".file-caption-name").val(data.obj.filePath);
		//     		  $("input[name=filePathImage]").append("<img alt='' src='${webRoot}"+data.obj.filePath+"'/>");
		    	}
	    	});
			$("#addModal .modal-title").text("编辑");
			
		}else{
			$("#addModal .modal-title").text("新增");
		}
		$("#addModal").modal("show");
    }
    //绑定回车事件
//     document.onkeydown=keyDownSearch;
    </script>
  </body>
</html>
