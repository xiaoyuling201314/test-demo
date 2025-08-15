<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<%@include file="/WEB-INF/view/common/resource.jsp"%>
	<title>数据导入</title>
	<link rel="stylesheet" type="text/css" href="${webRoot}/css/fileinput.css" />
	<link rel="stylesheet" type="text/css" href="${webRoot}/css/theme.css" />
	</head>
	<!-- 上传 -->
	<script src="${webRoot}/js/sortable.js" type="text/javascript"></script>
	<script src="${webRoot}/js/fileinput.js" type="text/javascript"></script>
	<script src="${webRoot}/js/zh.js" type="text/javascript"></script>
	<script src="${webRoot}/js/theme.js" type="text/javascript"></script>
</head>
<body>
<div class="main" style="width: 410px;margin: 0 auto;">
		<div class="wrapper">
			<form class="" id="saveForm" enctype="multipart/form-data">
				<div class="is-flex">
					<label class="control-label"></label>
					<div class="">
						<p>
							<b><font color="#000000" size="4">机构导入要求：</font></b>
						</p>
						<p>
							1、必须是EXCEL格式。 <a class="text-primary cs-link" href="${webRoot}/js/depart_importtemplate.xlsx">下载模版</a>
							<br /> 2、模板文件中必填项为必填，否则，不允许导入。<br>
							3、导入最大记录数量为<b style="color: #FF0000;">2000条（约200KB）</b>，超出不允许导入！
						</p>
					</div>
				</div>
					<%--<label class="col-sm-4 control-label"></label>--%>
					<%--<div class="col-sm-8">--%>
						<%--<p><b><font color="#000000" size="4">机构批量导入注意事项：</font></b></p>--%>
						<%--<p><font color="#000000">1、文件必须是EXCEL格式。--%>
						<%--<a href="${webRoot}/js/depart_importtemplate.xlsx" style="text-decotation:underline;color:#FF0000;">点击此处下载模版</a></font>--%>
						<%--<br />--%>
						  <%--2、表格中所有的列为必填项,不写则导入失败。<br>--%>
					<%--</p>--%>
					<!-- 选择机构：
					<div class="cs-input-box">
						<input type="text" name="departName" id="departName" datatype="*" nullmsg="请选择所属机构" errormsg="请选择所属机构"/> 
						<input type="hidden" name="departId" id="departId">
						<div class="cs-down-arrow"></div>
					</div>
					<div class="cs-check-down cs-hide" style="display: none;">
						<ul id="myDeaprtTree" class="easyui-tree"></ul>
					</div>
					</div> -->
				<%--</div>--%>
				<div class="form-groups is-flex">
					<label class="control-label">机构名称：</label>
					<div class="">
						<div class="cs-in-style">
							<div class="cs-input-box cs-all-ps">
								<input type="text" id="departName" name="departNames" readonly="readonly" datatype="*" ignore="ignore" nullmsg="请选择所属机构" errormsg="请选择所属机构">
								<input type="hidden" id="departId" name="departId" datatype="*" ignore="ignore" nullmsg="请选择所属机构" errormsg="请选择所属机构">
								<div class="cs-down-arrow"></div>
							</div>
							<div class="cs-check-down cs-hide" style="display: none;">
								<ul id="myDeaprtTree" class="easyui-tree"></ul>
							</div>
						</div>
					</div>
				</div>
				<div class="form-groups is-flex">
					<label class="control-label">导入文件：</label>
					<div class="kv-main">
						<input id="kv-explorer" type="file" name="xlsx" accept=".xls,.xlsx" style="color: #666;" multiple/>
					</div>
				</div>
				

				<div class="form-btn is-flex">
					<div  class="">
						<button class="btn btn-success" id="btnSave" type="button">导入</button>
						<a class="btn btn-default" href="${webRoot}/detect/depart/departManagementList.do"><i class="iconfont icon-fanhui text-primary"></i> 返回</a>
					</div>
				</div>
			</form>
		</div>
	</div>
	
	<div class="modal fade intro2" id="confirm-sure" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="z-index:10000" data-backdrop="static" data-keyboard="false">
		<div class="modal-dialog cs-alert-width">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
					<h4 class="modal-title">提示</h4>
				</div>
				<div class="modal-body cs-alert-height cs-dis-tab">
					<div class="cs-text-algin">
						<img src="${webRoot}/img/sure.png" width="40px"/>
						<span class="tips" id="myModalLabel"></span>
						</div>
				</div>
				<div class="modal-footer">
					<a class="btn btn-danger btn-ok" data-dismiss="modal">关闭</a>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade intro2" id="myModal-mid4" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"  data-backdrop="static" data-keyboard="false">
		<div class="modal-dialog cs-alert-width" role="document">
			<div class="modal-content ">
				<div class="modal-header">
					<h4 class="modal-title" id="myModalLabel">提示</h4>
				</div>
				<div class="modal-body cs-alert-height cs-dis-tab">
					<div class="cs-text-algin" style="">
						<img src="${webRoot}/img/wait.gif" alt=""><i class="cs-font-io text-primary">正在导入......</i>
					</div>
				</div>
			</div>
		</div>
	</div>
	<%@include file="/WEB-INF/view/common/confirm.jsp"%>
	<script type="text/javascript">
		$("#btnSave").on("click", function() {
			if($("#departId").val()!=""){
				if($("#kv-explorer").val()!=""){
					// jquery 表单提交 
					$("#myModal-mid4").modal("show");
		  			var formData = new FormData($('#saveForm')[0]);
		  			$.ajax({
		  		        type: "POST",
		  		        url: '${webRoot}'+"/detect/depart/importData",
		  		        data: formData,
		  		        contentType: false, //必须false才会避开jQuery对 formdata 的默认处理 XMLHttpRequest会对 formdata 进行正确的处理 
		  		        processData: false, //必须false才会自动加上正确的Content-Type
		  		        dataType: "json",
		  		      	success: function(data){
		  		      		$("#myModal-mid4").modal("hide");
		  		      		if(data.msg==""){
			  		      		$("#myModalLabel").text("导入成功");
			  		      		$("#confirm-sure").modal('toggle');
		  		      		}else {
		  		      			window.location.href="${webRoot}/resources/depart/"+data.msg;
							}
						}
		  		    });
		  			return false;
				}else {
					$("#confirm-warnning .tips").text("请选择要导入的文件！");
		    		$("#confirm-warnning").modal('toggle');
				}
			}else {
				$("#confirm-warnning .tips").text("请选择机构！");
	    		$("#confirm-warnning").modal('toggle');
			}
	    });
	    
	    $('#myDeaprtTree').tree({
			checkbox : false,
			url : "${webRoot}/detect/depart/getDepartTree.do",
			animate : true,
			onClick : function(node) {
				$('#departId').val(node.id);
				$('#departName').val(node.text);
				$(".cs-check-down").hide();
			}
	});
	    
	    
	    
	    
	    
	  //上传控件
	    $("#file-1").fileinput({
	        uploadUrl: '#', // you must set a valid URL here else you will get an error
	        allowedFileExtensions: ['jpg', 'png', 'gif'],
	        overwriteInitial: false,
	        maxFileSize: 1000,
	        maxFilesNum: 10,
	        //allowedFileTypes: ['image', 'video', 'flash'],
	        slugCallback: function (filename) {
	            return filename.replace('(', '_').replace(']', '_');
	        }
	    });
	    $("#file-4").fileinput({
	        uploadExtraData: {kvId: '10'}
	    });
	    $(".btn-warning").on('click', function () {
	        var $el = $("#file-4");
	        if ($el.attr('disabled')) {
	            $el.fileinput('enable');
	        } else {
	            $el.fileinput('disable');
	        }
	    });
	    $(".btn-info").on('click', function () {
	        $("#file-4").fileinput('refresh', {previewClass: 'bg-info'});
	    });
	    $(document).ready(function () {
	        $("#test-upload").fileinput({
	            'showPreview': false,
	            'allowedFileExtensions': ['jpg', 'png', 'gif'],
	            'elErrorContainer': '#errorBlock'
	        });
	        $("#kv-explorer").fileinput({
	            'theme': 'explorer',
	            'uploadUrl': '#',
	            textEncoding:'UTF-8',
	            language: 'zh', 
	            overwriteInitial: false,
	            initialPreviewAsData: true,
	            dropZoneEnabled: false,
	            showClose:false,
	            maxFileCount:10,
	            browseLabel:'浏览',
	        });
	    });
	</script>
</body>
</html>