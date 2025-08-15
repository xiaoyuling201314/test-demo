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
              <a href="javascript:">数据中心</a></li>
              <li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
              <li class="cs-b-active cs-fl">检测项目
              </li>
            </ol>
            		<div class=" cs-fl" style="margin:3px 0 0 30px;">
			<select class="check-date cs-selcet-style" id="check" style="width: 120px;" onchange="changeType();"> 
				<option value="1" selected="selected">已审核</option>
				<option value="0">未审核</option>
				<option value="2">全部</option>
			</select>
		</div>
          <!-- 面包屑导航栏  结束-->
            <div class="cs-search-box cs-fr">
              <form action="datagrid.do">
                <div class="cs-search-filter clearfix cs-fl">
                <input class="cs-input-cont cs-fl focusInput" type="text" name="baseDetectItem.detectItemName" placeholder="请输入内容" />
                <input type="button" onclick="datagridUtil.queryByFocus()" class="cs-search-btn cs-fl" href="javascript:;" value="搜索">
                </div>
              	<div class="clearfix cs-fr" id="showBtn">
              	</div>
              </form>
              
            </div>
          </div>

	<div id="dataList"></div>
	
	<!-- 编辑模态框 start -->
	<div class="modal fade intro2" id="addModal"  role="dialog" aria-labelledby="myModalLabel">
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
	      	<form id="saveForm" action="${webRoot}/data/detectItem/save.do" method="post">
				<input type="hidden" name="id" >
				<input type="hidden" name="detectItemCode" >
			  <div width="100%" class="cs-add-new">
			   <ul class="cs-ul-form clearfix">
                    <li  class="cs-name col-xs-3 col-md-3" width="20% ">项目名称：</li>
                    <li class="cs-in-style cs-modal-input" width="210px" >
                    <input type="text" name="detectItemName" datatype="*" nullmsg="请输入项目名称" errormsg="请输入项目名称" />
                    </li>
                    <li class="col-md-4 col-xs-4 cs-text-nowrap">
                      <div class="Validform_checktip"></div>
                        <div class="info"><i class="cs-mred">*</i>请输入项目名称
                        </div>
                    </li>
               </ul>
			   <ul class="cs-ul-form clearfix">
                    <li  class="cs-name col-xs-3 col-md-3" width="20% ">项目俗称：</li>
                    <li class="cs-in-style cs-modal-input" width="210px" >
                        <input type="text" name="detectItemVulgo"/>
                    </li>
               </ul>
               	 <ul class="cs-ul-form clearfix" id="showPrice">
	                 
	              </ul>
           	   <ul class="cs-ul-form clearfix">
                    <li  class="cs-name col-xs-3 col-md-3" width="20% ">项目类别：</li>
                    <li class="cs-in-style cs-modal-input" width="210px" >
                   <select name="detectItemTypeid">
				           <c:forEach items="${itemList}" var="itemType">
				           		<option value="${itemType.id }">${itemType.itemName}</option>
				           </c:forEach>
				          </select>
                    </li>
                </ul>
                <ul class="cs-ul-form clearfix">
                    <li  class="cs-name col-xs-3 col-md-3" width="20% ">检测标准：</li>
                    <li class="cs-in-style cs-modal-input" width="210px" >
<%--                       <select name="standardId">--%>
<%--                           <c:forEach items="${standardList}" var="standard">--%>
<%--                                <option value="${standard.id }">${standard.stdCode}</option>--%>
<%--                           </c:forEach>--%>
<%--                          </select>--%>
                        <input type="hidden" name="standardId">
                        <%@include file="/WEB-INF/view/data/standard/selectStandard.jsp"%>
                    </li>
                </ul>
                 <ul class="cs-ul-form clearfix">
                    <li  class="cs-name col-xs-3 col-md-3" width="20% ">判定符号：</li>
                    <li class="cs-in-style cs-modal-input" width="210px" >
                   <select name="detectSign">
			           <option value="&gt;">&gt;</option>
					   <option value="&lt;">&lt;</option>
					   <option value="&ge;">&ge;</option>
					   <option value="&le;">&le;</option>
			          </select>
                    </li>
                </ul>
                <ul class="cs-ul-form clearfix">
                    <li  class="cs-name col-xs-3 col-md-3" width="20% ">合格值：</li>
                    <li class="cs-in-style cs-modal-input" width="210px" >
                   <input type="text" name="detectValue" datatype="*,/^\d*\.{0,1}\d*$/" nullmsg="请输入合格值" errormsg="请输入数字类型" />
                    </li>
                    <li class="col-xs-4 col-md-4 cs-text-nowrap">
                      <div class="Validform_checktip"></div>
                        <div class="info"><i class="cs-mred">*</i>请输入合格值
                        </div>
                    </li>
                </ul>
                 <ul class="cs-ul-form clearfix">
                    <li  class="cs-name col-xs-3 col-md-3" width="20% ">合格值单位：</li>
                    <li class="cs-in-style cs-modal-input" width="210px" >
                   <input type="text" name="detectValueUnit" datatype="*" nullmsg="请输入合格值单位" />
                    </li>
                    <li class="col-xs-4 col-md-4 cs-text-nowrap">
                      <div class="Validform_checktip"></div>
                        <div class="info"><i class="cs-mred">*</i>请输入合格值单位
                        </div>
                    </li>
                </ul>
			     <ul class="cs-ul-form clearfix">
                    <li  class="cs-name col-xs-3 col-md-3" width="20% ">状态：</li>
                    <li class="cs-al cs-modal-input">
	         		    <input id="cs-check-radio" type="radio" value="1" name="checked"/><label for="cs-check-radio">已审核</label>
			        	<input id="cs-check-radio2" type="radio" value="0" name="checked" checked="checked" /><label for="cs-check-radio2">未审核</label>
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
    <script src="${webRoot}/js/datagridUtil.js"></script>
    <script type="text/javascript">
    rootPath="${webRoot}/data/detectItem/";

    if (Permission.exist("411-1")) {
        var html='<a class="cs-menu-btn" onclick="getId();"><i class="'+Permission.getPermission("411-1").functionIcon+'"></i>新增</a>';
        $("#showBtn").append(html);
    }

    if (Permission.exist("411-5")) {
        var html='<li  class="cs-name col-xs-3 col-md-3" width="20% ">检测费用：</li>';
        html+='<li class="cs-in-style cs-modal-input" width="210px" >';
        html+=' <input type="text" name="price" datatype="/^[0-9]+([.]{1}[0-9]+){0,1}$/" nullmsg="请输入检测费用" />';
        html+='</li><li class="col-xs-4 col-md-4 cs-text-nowrap">';
        html+=' <div class="Validform_checktip"></div>';
        html+='<div class="info"><i class="cs-mred">*</i>请输入检测费用</div></li>';
        $("#showPrice").append(html);
    }

    $(function(){
    	getData();
    	$("#saveForm").Validform({
    		tiptype:2,
    		beforeSubmit:function(){
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
		 	 $("input[name=detectItemCode]").val("");
		 	$("#saveForm").Validform().resetForm();
    		$("input").removeClass("Validform_error");
    		$(".Validform_wrong").hide();
    		$(".Validform_checktip").hide();
    		$(".info").show();

    		//清空检测标准选项
            cleanStandardSelected();
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
    })
    function getInfoObj(){
		return $(this).parents("li").next().find(".info");
	}
    var checked=1;
    function getData() {
	
 
	var op = {
		tableId: "dataList",	//列表ID
		tableAction: "${webRoot}/data/detectItem/datagrid.do?baseDetectItem.checked="+checked,	//加载数据地址
		parameter: [		//列表拼接参数
				{
					columnCode: "detectItemTypeName",
					columnName: "项目类别",
                    columnWidth: '120px'
				},
				{
					columnCode: "detectItemName",
					columnName: "检测项目",
					query: 1
				},
				{
					columnCode: "detectItemVulgo",
					columnName: "项目俗称"
				},
				{
					columnCode: "stdCode",
					columnName: "检测标准"
				}
				,
				{
					columnCode: "detectSign",
					columnName: "判定符号",
                    columnWidth: '90px'
				},
				{
					columnCode: "detectValue",
					columnName: "标准值",
					sortDataType:"float",
                    columnWidth: '100px'
				},
				{
					columnCode: "detectValueUnit",
					columnName: "标准值单位",
                    columnWidth: '100px'
				},
				{
                    show: Permission.exist("411-5"),
					columnCode: "price",
					columnName: "检测费用(元)",
					query: 1,
					sortDataType:"float",
                    columnWidth: '120px'
				},
				{
					columnCode: "checked",
					columnName: "状态",
					query: 1,
					customVal: {"0":"<div class=\"text-danger\">未审核</div>","1":"<div class=\"text-primary\">已审核</div>"},
                    columnWidth: '90px'
				}
		],
		funBtns: [
	    	{
                show: Permission.exist("411-2"),
                style: Permission.getPermission("411-2"),
	    		action: function(id){
	    			$("#addModal").modal("show");
	    			getId(id);
	    		}
	    	},
	    	{
                 show: Permission.exist("411-3"),
                 style: Permission.getPermission("411-3"),
	    		action: function(id){
	    			idsStr="{\"ids\":\""+id.toString()+"\"}";
	    			$("#confirm-delete").modal('toggle');
	    		}
	    	}
	    ],
		bottomBtns: [
			{
                show: Permission.exist("411-3"),
                style: Permission.getPermission("411-3"),
	    		action: function(ids){
	    			if(ids == ''){
		    			$("#confirm-warnning .tips").text("请选择检测项目");
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
    } 
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
		    		  $("#select2-standard_select2-container").text(data.obj.stdCode);
		    		  $("[name=checked][value="+data.obj.checked+"]").prop("checked","checked");
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
    
    
    
    //状态选择栏
    function changeType() {
         checked="";
	    var	 value = $('#check option:selected').val(); // 选中值
	    if(value==0||value==1){
	 	   checked=value;
	    }
	    getData();
	}

    //选择检测标准
    $('#standard_select2').on('select2:select', function (e) {
        var standardSel2Data = getStandardSelect2Data();
        var sid = standardSel2Data[0].id;
        var sname = standardSel2Data[0].name;
        if(sid){
            $("input[name='standardId']").val(sid);
        }else{
            $("input[name='standardId']").val("");
        }
    });
    </script>
  </body>
</html>
