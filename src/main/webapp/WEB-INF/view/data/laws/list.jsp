<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/common/resource.jsp"%>
<html>
  <head>
    <title>快检服务云平台</title>
<%--   	 <link rel="stylesheet" href="${webRoot}/css/fileinput.min.css">--%>
	 <link rel="stylesheet" type="text/css" href="${webRoot}/css/fileinput.css" />
<%--	 <link rel="stylesheet" type="text/css" href="${webRoot}/css/theme.css" />--%>
     <!-- 上传 -->
<%--	<script src="${webRoot}/js/sortable.js" type="text/javascript"></script>--%>
<%--	<script src="${webRoot}/js/fileinput.js" type="text/javascript"></script>--%>
	<script src="${webRoot}/js/zh.js" type="text/javascript"></script>
	<script src="${webRoot}/js/theme.js" type="text/javascript"></script>
  </head>
  <body>
  <div class="cs-col-lg clearfix">
          <!-- 面包屑导航栏  开始-->
           <%-- <ol class="cs-breadcrumb">
              <li class="cs-fl">
              <img src="${webRoot}/img/set.png" alt="" />
              <a href="javascript:;">数据中心</a></li>
              <li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
              <li class="cs-b-active cs-fl">法律法规
              </li>
            </ol>--%>
          <!-- 面包屑导航栏  结束-->
           <%-- <div class="cs-search-box cs-fr">
              <form>
                <div class="cs-search-filter clearfix cs-fl">
                <input class="cs-input-cont cs-fl focusInput" type="text" name="baseBean.lawName" placeholder="请输入内容" />
                <input type="button" onclick="datagridUtil.queryByFocus();" class="cs-search-btn cs-fl" href="javascript:;" value="搜索">
                <span class="cs-s-search cs-fl">高级搜索</span>
                </div>
              <div class="clearfix cs-fr" id="showBtn">
              </div>
              </form>

            </div>
          </div>--%>

	<div id="dataList"></div>
  	<div class="modal fade intro2" id="myModal2" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
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
	      	<form id="saveForm" enctype="multipart/form-data">
			<input type="hidden" name="id" >
			 <div width="100%" class="cs-add-new">
                <ul class="cs-ul-form clearfix">
                    <li  class="cs-name col-xs-3 col-md-3" width="20% ">法律名称：</li>
                    <li class="cs-in-style cs-modal-input" width="210px" >
                    <input type="text" name="lawName" class="inputxt" datatype="*" nullmsg="请输入法律名称" /></li>
                    <li class="col-xs-4 col-md-4 cs-text-nowrap">
                      <div class="Validform_checktip"></div>
                        <div class="info"><i class="cs-mred">*</i>请输入法律名称
                        </div>
                    </li>
                </ul>
                 <ul class="cs-ul-form clearfix">
                    <li  class="cs-name col-xs-3 col-md-3" width="20% ">发布单位：</li>
                    <li class="cs-in-style cs-modal-input" width="210px" >
                    <input type="text" name="lawUnit" class="inputxt" datatype="*" nullmsg="请输入发布单位" /></li>
                    <li class="col-xs-4 col-md-4 cs-text-nowrap">
                      <div class="Validform_checktip"></div>
                        <div class="info"><i class="cs-mred">*</i>请输入发布单位
                        </div>
                    </li>
                </ul>
                 <ul class="cs-ul-form clearfix">
                    <li  class="cs-name col-xs-3 col-md-3" width="20% ">法律类型：</li>
                    <li class="cs-in-style cs-modal-input" width="210px" >
	                    <select class="cs-in-style" name="lawType">
							<option value="国家法律">国家法律</option>
							<option value="国家法规">国家法规</option>
							<option value="相关法规">相关法规</option>
							<option value="法规动态">法规动态</option>
							<option value="地方法规">地方法规</option>
						</select>
                    </li>
                </ul>
                 <ul class="cs-ul-form clearfix">
                    <li  class="cs-name col-xs-3 col-md-3" width="20% ">发布文号：</li>
                    <li class="cs-in-style cs-modal-input" width="210px" >
                    <input type="text" name="lawNum" class="inputxt" /></li>
                </ul>
                 <ul class="cs-ul-form clearfix">
                    <li  class="cs-name col-xs-3 col-md-3" width="20% ">状态：</li>
                    <li class="cs-in-style cs-modal-input" width="210px" >
	                    <select class="cs-in-style" name="lawStatus" id="lawStatus">
							<option value="现行">现行</option>
							<option value="即将实施">即将实施</option>
							<option value="失效/废止">失效/废止</option>
						</select>
                    </li>
                </ul>
                <ul class="cs-ul-form clearfix">
                    <li  class="cs-name col-xs-3 col-md-3" width="20% ">发布日期：</li>
                    <li class="cs-in-style cs-modal-input" width="210px" >
                    <input class="cs-time" type="text" name="relDate" onClick="WdatePicker()" value="<fmt:formatDate value='<%=new Date() %>' pattern='yyyy-MM-dd'/>" datatype="*" nullmsg="请选择发布日期" /></li>
                    <li class="col-md-4 cs-text-nowrap">
                      <div class="Validform_checktip"></div>
                        <div class="info"><i class="cs-mred">*</i>请选择发布日期
                        </div>
                    </li>
                </ul>
                <ul class="cs-ul-form clearfix">
                    <li  class="cs-name col-xs-3 col-md-3" width="20% ">实施日期：</li>
                    <li class="cs-in-style cs-modal-input" width="210px" >
                    <input class="cs-time" type="text" name="impDate" onClick="WdatePicker()" datatype="*" nullmsg="请选择实施日期" /></li>
                    <li class="col-md-4 cs-text-nowrap">
                      <div class="Validform_checktip"></div>
                        <div class="info"><i class="cs-mred">*</i>请选择实施日期
                        </div>
                    </li>
                </ul>
                <ul class="cs-ul-form clearfix cs-hide" id="failureDate">
                    <li  class="cs-name col-xs-3 col-md-3" width="20% ">失效日期：</li>
                    <li class="cs-in-style cs-modal-input" width="210px" >
                    <input class="cs-time" type="text" name="failureDate" onClick="WdatePicker()"/></li>
                </ul>
                <ul class="cs-ul-form clearfix">
                    <li  class="cs-name col-xs-3 col-md-3" width="20% ">法律文件：</li>
                    <li class="cs-in-style cs-modal-input" width="210px" >
                    	<div style="width:200px;">
							<input type="file" id="myFile" name="urlPathFile"/>
						</div>
					</li>
                </ul>
                 <ul class="cs-ul-form clearfix">
                    <li  class="cs-name col-xs-3 col-md-3" width="20% ">使用状态：</li>
                    <li class="cs-al cs-modal-input">
	         		    <input id="cs-check-radio2" type="radio" value="1" name="useStatus"  /><label for="cs-check-radio2" >使用</label>
     					<input id="cs-check-radio" type="radio" value="0" name="useStatus" checked="checked" /><label for="cs-check-radio">未使用</label>
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
   <script src="${webRoot}/js/jquery.form.js"></script>
	<script src="${webRoot}/js/datagridUtil2.js"></script>
    <script type="text/javascript">
    rootPath="${webRoot}/data/laws/";
    $(function(){
    	//表单验证
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
    		        		$("#myModal2").modal("hide");
                            dgu.queryByFocus();
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
    		 $("#saveForm").Validform().resetForm();
    		$("input").removeClass("Validform_error");
    		$(".Validform_wrong").hide();
    		$(".Validform_checktip").hide();
    		$(".info").show();
    	});
    	//上传控件
   	 $("#myFile").fileinput({
	            'theme': 'explorer',
	            'uploadUrl': '#',
	            textEncoding:'UTF-8',
	            language: 'zh',
	            overwriteInitial: false,
	            initialPreviewAsData: true,
	            showPreview:false,
	            dropZoneEnabled: false,
	            showClose:false,
	            showRemove : true,
	            maxFileCount:1,
	            browseLabel:'浏览'
	        });
    	$("#lawStatus").on("change", function() {
    		if ($("#lawStatus").val() == '失效/废止') {
    			$("#failureDate").removeClass("cs-hide");
    		}else{
    			$("#failureDate").addClass("cs-hide");
    		}
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
    function getInfoObj(){
		return $(this).parents("li").next().find(".info");
	}
	var dgu = datagridUtil.initOption({
		tableId: "dataList",	//列表ID
		tableAction: '${webRoot}'+"/data/laws/datagrid.do",	//加载数据地址
        tableBar: {
            title: ["数据中心","法律法规"],
            ele: [{
                eleShow: 1,
                eleName: "baseBean.lawName",
                eleType: 0,
                elePlaceholder: "请输入内容"
            }],
            topBtns: [{
                show: Permission.exist("416-1"),
                style: Permission.getPermission("416-1"),
                action: function (ids, rows) {
                    getId();
                }
            }]
        },
		parameter: [		//列表拼接参数
			 {
				columnCode: "lawType",
				columnName: "类型",
                columnWidth: "80px",
				query: 1,
				queryType: 2,
				queryCode: "baseBean.lawType",
				customVal: {"国家法律":"国家法律","国家法规":"国家法规","相关法规":"相关法规","法规动态":"法规动态","地方法规":"地方法规"}
			},
			{
				columnCode: "lawName",
				columnName: "名称",
				query: 1,
				queryCode: "baseBean.lawName",
				columnWidth: "25%"
			},
			{
				columnCode: "lawNum",
				columnName: "发布文号",
				queryCode: "baseBean.lawNum",
				columnWidth: "10%"
			},
			{
				columnCode: "lawUnit",
				columnName: "发布单位",
				queryCode: "baseBean.lawUnit",
				columnWidth: "15%"
			},
			{
				columnCode: "lawStatus",
				columnName: "法律状态",
                columnWidth: "80px",
				query: 1,
				queryType: 2,
				queryCode: "baseBean.lawStatus",
				customVal: {"现行":"现行","即将实施":"即将实施","失效/废止":"失效/废止"}
			},
			{
				columnCode: "relDate",
				columnName: "发布日期",
                columnWidth: "90px",
				sortDataType:"date",
				queryType: 1
			},
			{
				columnCode: "impDate",
				columnName: "实施日期",
                columnWidth: "90px",
				sortDataType:"date",
				queryType: 1
			},
			{
				columnCode: "useStatus",
				columnName: "状态",
                columnWidth: "60px",
				query: 1,
				queryType:2,
				queryCode: "baseBean.useStatus",
				customVal: {"0":"<div class=\"text-danger\">未使用</div>","1":"<div class=\"text-primary\">使用</div>"}
			}

		],
		funBtns: [
	    	{
	    		show: Permission.exist("416-2"),
	    		style: Permission.getPermission("416-2"),
	    		action: function(id){
	    			$("#myModal2").modal("show");
	    			getId(id);
	    		}
	    	},{//在线预览pdf
                show: Permission.exist("416-10"),
                style: Permission.getPermission("416-10"),
                action: function(id,rowNo){
                    //转义特殊字符[]
                    var path=(rowNo.urlPath).replace("[","%5B").replace("]","%5D");
                    var filePath=encodeURIComponent("http://fst.chinafst.cn:9002/pdf/法律法规/"+path);
                    window.open("${webRoot}/pdf/preview?file=" + filePath);
                }
            },
	    	{
	    		show: Permission.exist("416-3"),
	    		style: Permission.getPermission("416-3"),
	    		action: function(id){
	    			self.location = '${webRoot}'+"/data/laws/download.do?id="+id;
	    		}
	    	},
	    	{
	    		show: Permission.exist("416-4"),
	    		style: Permission.getPermission("416-4"),
	    		action: function(id){
	    			idsStr="{\"ids\":\""+id.toString()+"\"}";
	    			$("#confirm-delete").modal('toggle');
	    		}
	    	}
	    ],
		bottomBtns: [
			{	//删除
				show: Permission.exist("416-4"),
    			style: Permission.getPermission("416-4"),
	    		action: function(ids){
	    			if(ids == ''){
		    			$("#confirm-warnning .tips").text("请选择法律法规");
		    			$("#confirm-warnning").modal('toggle');
	    			}else{
		    			idsStr = "{\"ids\":\""+ids.toString()+"\"}";
		    			$("#confirm-delete").modal('toggle');
	    			}
	    		}
		    }
		],
        onload : function(rows,data) {
            //加载列表后执行函数
            $(".rowTr").each(function(){
                //目前仅支持pdf文件预览，其他类型格式暂不支持所以隐藏预览按钮
                var urlPath=$(this).find(".urlPath").html();
                if(urlPath.indexOf(".pdf")==-1){
                    $(this).find(".416-10").hide();
                }
            });
        },
	});
    dgu.queryByFocus();

    /**
     * 查询检测标准信息
     */
    function getId(id){
    	if(id){
	    	$.ajax({
		    	url:"${webRoot}/data/laws/queryById.do",
		    	type:"POST",
		    	data:{"id":id},
		    	dataType:"json",
		    	success:function(data){
		    		  $(".info").hide();
		    	      var form = $('#saveForm');
		    	      data.obj.relDate=data.obj.relDate!="" ? new Date(data.obj.relDate).format("yyyy-MM-dd") : "";
		    	      data.obj.impDate=data.obj.impDate !="" ? new Date(data.obj.impDate).format("yyyy-MM-dd") : "";
		    		  form.form('load', data.obj);
		    		  $(".file-caption-name").val(data.obj.urlPath);
		    		  if ($("#status").val() == 1) {
		    				$("#expirationDate").removeClass("cs-hide");
		    				 data.obj.failureDate=data.obj.failureDate !="" ? new Date(data.obj.failureDate).format("yyyy-MM-dd") : "";
		   			  }else{
		    				$("#expirationDate").addClass("cs-hide");
		   			  }
		    	}
	    	});
			$("#myModal2 .modal-title").text("编辑");

		}else{
			$("#myModal2 .modal-title").text("新增");
		}
		$("#myModal2").modal("show");
    }
    //绑定回车事件
    //document.onkeydown=keyDownSearch;
    </script>
  </body>
</html>
