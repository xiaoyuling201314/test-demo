<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/common/resource.jsp"%>
<html>
  <head>
    <title>快检服务云平台</title>
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
	      	<form id="saveForm" action="${webRoot}/dataCheck/unqualified/config/save.do" method="post">
				<input type="hidden" name="id" >
			     <div width="100%" class="cs-add-new">
			     <ul class="cs-ul-form clearfix">
                    <li  class="cs-name col-xs-3 col-md-3" width="20% ">处置方法：</li>
                    <li class="cs-in-style cs-modal-input" width="210px" >
                    <input type="text" name="handleName" class="inputxt" datatype="*" nullmsg="请输入处置方法" /></li>
                    <li class="col-xs-4 col-md-4 cs-text-nowrap">
                      <div class="Validform_checktip"></div>
                        <div class="info"><i class="cs-mred">*</i>请输入处置方法
                        </div>
                    </li>
                </ul>
			     <ul class="cs-ul-form clearfix">
                    <li  class="cs-name col-xs-3 col-md-3" width="20% ">处置类型：</li>
                    <li class="cs-in-style cs-modal-input" width="210px" >
                     <select name="handleType">
				           	<option value="0">无框</option>
				           	<option value="1">文本输入框-无单位</option>
				           	<option value="2">数字输入框-单位公斤</option>
				           	<option value="3">货币输入框-单位元</option>
				           	<option value="4">数字输入框-单位天</option>
				          </select>
				          </li>
                </ul>
			     <ul class="cs-ul-form clearfix">
                    <li  class="cs-name col-xs-3 col-md-3" width="20% ">数据单位：</li>
                    <li class="cs-in-style cs-modal-input" width="210px" >
                     <input type="text" name="valueType"  /></li>
                </ul>   
		       <ul class="cs-ul-form clearfix">
                    <li  class="cs-name col-xs-3 col-md-3" width="20% ">排序：</li>
                    <li class="cs-in-style cs-modal-input" width="210px" >
                    <input type="text" name="sorting" class="inputxt" ignore="ignore" datatype="n" nullmsg="请输入标题"  errormsg="请输入正确的数字"/></li>
                </ul>
                 <ul class="cs-ul-form clearfix">
                    <li  class="cs-name col-xs-3 col-md-3" width="20% ">状态：</li>
                    <li class="cs-al cs-modal-input">
	         		    <input id="cs-check-radio2" type="radio" value="1" name="checked"  /><label for="cs-check-radio2" >已审核</label>
     					<input id="cs-check-radio" type="radio" value="0" name="checked" checked="checked" /><label for="cs-check-radio">未审核</label>
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
    <script src="${webRoot}/js/datagridUtil2.js"></script>
    <script type="text/javascript">
		rootPath = "${webRoot}/dataCheck/unqualified/config/";
    $(function(){
		rootPath = "${webRoot}/dataCheck/unqualified/config/";
    	demo=$("#saveForm").Validform({
    		tiptype:2,
    		beforeSubmit:function(){
    			var formData = new FormData($('#saveForm')[0]);
    			$.ajax({
    		        type: "POST",
    		        url: "${webRoot}/dataCheck/unqualified/config/save.do",
    		        data: formData,
    		        contentType: false, //必须false才会避开jQuery对 formdata 的默认处理 XMLHttpRequest会对 formdata 进行正确的处理 
    		        processData: false, //必须false才会自动加上正确的Content-Type
    		        dataType: "json",
    		        success: function(data){
    		        	if(data && data.success){
    		        		$("#addModal").modal("hide");
							dgu.query();
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
	    	 $("#saveForm").Validform().resetForm();
    		$("input").removeClass("Validform_error");
    		$(".Validform_wrong").hide();
    		$(".Validform_checktip").hide();
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
    });
    var dgu = datagridUtil.initOption({
		tableId: "dataList",
		tableAction: "${webRoot}/dataCheck/unqualified/config/datagrid.do",
        tableBar: {
            title: ["不合格处理","处理规则"],
            hlSearchOff: 0,
            ele: [{
                eleShow: 1,
                eleName: "baseBean.handleName",
                eleType: 0,
                elePlaceholder: "请输入处理方式"
            }],
            topBtns: [{
                show: Permission.exist("384-1"),
                style: Permission.getPermission("384-1"),
                action: function(ids, rows){
                    $("#addModal").modal("show");
                }
            }]
        },
		parameter: [
            {
                columnCode: "handleName",
                columnName: "处理方式"
            }, {
                columnCode: "handleType",
                columnName: "处理类型",
                customVal:{
                0:"无框",
                1:"文本输入框-无单位",
                2:"数字输入框-单位公斤",
                3:"货币输入框-单位元",
                4:"数字输入框-单位天"
                }
            }, {
                columnCode: "valueType",
                columnName: "单位",
                query: 1
            }, {
                columnCode: "sorting",
                columnName: "排序",
                query: 1
            }, {
                columnCode: "checked",
                columnName: "审核",
                customVal:{0:"<span class='text-danger'>未审核</span>",1:"<span class='text-success'>已审核</span>"}
            }
		],
		funBtns: [
			{
                show: Permission.exist("384-2"),
                style: Permission.getPermission("384-2"),
				action: function(id){
					$("#addModal").modal("show");
					getId(id);
				}
			}, {
                show: Permission.exist("384-3"),
                style: Permission.getPermission("384-3"),
				action: function(id){
					idsStr="{\"ids\":\""+id.toString()+"\"}";
	    			$("#confirm-delete").modal('toggle');
				}
			}
	    ],
		bottomBtns: [
			{	//删除函数	
                show: Permission.exist("384-3"),
                style: Permission.getPermission("384-3"),
                action: function(ids){
                    if(ids == ''){
                        $("#confirm-warnning .tips").text("请选择处理规则");
                        $("#confirm-warnning").modal('toggle');
                    }else{
                        idsStr = "{\"ids\":\""+ids.toString()+"\"}";
                        $("#confirm-delete").modal('toggle');
                    }
                }
		    }
		]
	});
    dgu.query();
    
    /**
     * 查询检测标准信息
     */
    function getId(e){
    	var id=e;
    	$.ajax({
    	url:"${webRoot}/dataCheck/unqualified/config/queryById.do",
    	type:"POST",
    	data:{"id":id},
    	dataType:"json",
    	success:function(data){
    		  $(".info").hide();
    	      var form = $('#saveForm');
    		  form.form('load', data.obj);
    		  $("[name=checked][value="+data.obj.checked+"]").prop("checked","checked");
    	},
    	error:function(){
    		alert("操作失败");
    	}
    	})
    }
    function getInfoObj(){
		return $(this).parents("li").next().find(".info");
	}
    </script>
  </body>
</html>
