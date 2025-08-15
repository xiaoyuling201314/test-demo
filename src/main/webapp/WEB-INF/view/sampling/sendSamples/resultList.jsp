<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/common/resource.jsp"%>
<html>
  <head>
    <title>快检服务云平台</title>
  </head>
  <body>
  <%--
	  <div class="cs-col-lg clearfix">
		<ol class="cs-breadcrumb">
		  <li class="cs-fl">
		  <img src="${webRoot}/img/set.png" alt="" />
		  <a href="javascript:;">你送我检</a></li>
		  <li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
		  <li class="cs-b-active cs-fl">检测结果
		  </li>
		</ol>
		<div class="cs-search-box cs-fr">
		  <form action="datagrid.do">
			  <span class="check-date cs-fl  cs-hide" id="regType">
				<span class="cs-name" style="padding-right: 0px;">监管类型：</span>
				<span class="cs-input-style " style="margin-left: 0px;">
					<input type="hidden" name="regTypeId" value="" id="regTypeIds" class="focusInput"/>
					<input type="text" name="regTypeName" class="choseRegType" value="--全部--" autocomplete="off" readonly/>
				</span>
			</span>
			<span class="check-date cs-fl" style="display: inline;">
				<span class="cs-name">范围:</span>
				<span class="cs-in-style cs-time-se cs-time-se">
					<input name="checkDateStartDateStr" id="start"style="width: 110px;" class="cs-time Validform_error focusInput" type="text" onclick="WdatePicker()" datatype="date" value="${start}" onchange="changeVAL1()" autocomplete="off">
					<span style="padding: 0 5px;">至</span>
					<input name="checkDateEndDateStr" id="end" style="width: 110px;" class="cs-time Validform_error focusInput" type="text" onclick="WdatePicker()" datatype="date" value="${end}" onchange="changeVAL2()" autocomplete="off">
					&nbsp;
				</span>
			</span>
			<div class="cs-search-filter clearfix cs-fl">
				<input class="cs-input-cont cs-fl focusInput" type="text" name="departName" id="departName" placeholder="请输入机构名称" />
				<input type="button" onclick="datagridUtil.queryByFocus()" class="cs-search-btn cs-fl" href="javascript:;" value="搜索">
				<span class="cs-s-search cs-fl">高级搜索</span>
			</div>
			<div class="clearfix cs-fr" id="showBtn"></div>
		  </form>
		</div>
	  </div>
--%>
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
	      	<form id="saveForm" action="${webRoot}/data/detectItem/save.do" method="post">
				<input type="hidden" name="id" >
				<input type="hidden" name="detectItemCode" >
			    <table class="cs-add-new">
			      <tr>
				        <td class="cs-name"><i class="cs-mred">*</i>项目名称：</td>
				        <td class="cs-in-style">
				          <input type="text" name="pointName" datatype="*" nullmsg="请输入项目名称" errormsg="请输入项目名称" />
				        </td>
			        </tr>
			        <tr>
			        	<td class="cs-name">项目类别：</td>
				        <td class="cs-in-style">
				          <select name="detectItemTypeid">
				           <c:forEach items="${itemList}" var="itemType">
				           		<option value="${itemType.id }">${itemType.itemName}</option>
				           </c:forEach>
				          </select>
				        </td>
			        </tr>
			        <tr>
			        <td class="cs-name">检测标准：</td>
			        <td class="cs-in-style">
			          <select name="standardId">
			           <c:forEach items="${standardList}" var="standard">
			           		<option value="${standard.id }">${standard.standardName}</option>
			           </c:forEach>
			          </select>
			        </td>
			      </tr>
			      <tr>
			      	 <td class="cs-name">判定符号：</td>
			        <td class="cs-in-style"><select name="detectSign">
			           <option value="&gt;">&gt;</option>
					   <option value="&lt;">&lt;</option>
					   <option value="&ge;">&ge;</option>
					   <option value="&le;">&le;</option>
			          </select>
			          </td>
			      </tr>
			      <tr>
			        <td class="cs-name"><i class="cs-mred">*</i>合格值：</td>
			        <td class="cs-in-style"><input type="text" name="detectValue" datatype="n" nullmsg="请输入合格值" errormsg="请输入数字类型" /></td>
			      </tr> 
			      <tr>
			      	 <td class="cs-name"><i class="cs-mred">*</i>合格值单位：</td>
			        <td class="cs-in-style"><input type="text" name="detectValueUnit" datatype="*" nullmsg="请输入合格值单位" errormsg="请输入标准名称" /></td>
			      </tr>
			      <tr>
			        <td class="cs-name">状态：</td>
			        <td class="cs-in-style cs-radio">
			        <input id="cs-check-radio" type="radio" value="1" name="status"/><label for="cs-check-radio">已审核</label>
			        <input id="cs-check-radio2" type="radio" value="0" name="status" checked="checked" /><label for="cs-check-radio2">未审核</label>
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
	<!-- 编辑模态框 end -->
	
	<!-- Modal 提示窗-删除-->
	<div class="modal fade intro2" id="confirm-delete" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="false">
		<div class="modal-dialog cs-alert-width">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
					<h4 class="modal-title" id="myModalLabel">确认删除</h4>
				</div>
				<div class="modal-body cs-alert-height cs-dis-tab">
					<div class="cs-text-algin">
						<img src="${webRoot}/img/stop2.png" width="40px"/>确认删除该记录吗？
					</div>
				</div>
				<div class="modal-footer">
					<a class="btn btn-danger btn-ok" onclick="deleteByID()">删除</a>
					<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
				</div>
			</div>
		</div>
	</div>
	<%@include file="/WEB-INF/view/common/modalBox.jsp"%>
    <%@ include file="/WEB-INF/view/common/exportDialog.jsp" %>
    <%@include file="/WEB-INF/view/common/exportStandingBook.jsp"%>
   <%@include file="/WEB-INF/view/ledger/regulatoryObject/selectRegType.jsp"%>
    <script src="${webRoot}/js/datagridUtil2.js"></script>
    <script type="text/javascript">
	// var dataType=1;
	// //选择监管对象类型 条件的权限
	// if (1 == Permission.exist("1345-9")) {
	// 	$("#regType").removeClass('cs-hide');
	// }
    var demo;
    var deleteId;
    $(function(){
    	demo=$("#saveForm").Validform({
    		callback:function(data){
   				$.Hidemsg();
    			if(data.success){
    				$("#addModal").modal("hide");
					dgu.query();
    			}else{
    				$.Showmsg(data.msg);
    			}
    		}
    	});
    	// 新增或修改
    	$("#btnSave").on("click", function() {
    		demo.ajaxPost();
    		return false;
    	});
    	//关闭编辑模态框前重置表单，清空隐藏域
    	$('#addModal').on('hidden.bs.modal', function (e) {
   			 $.Hidemsg();
			 var form = $("#saveForm");// 清空表单数据
	    	 form.form("reset");
	    	 $("input[name=id]").val("");
		 	 $("input[name=detectItemCode]").val("");
    	});
    });
 /*   function exportFile(){
		var radios = document.getElementsByName('inlineRadioOptions');
		var ext = '';
		for (var i = 0; i < radios.length; i++) {
			if(radios[i].checked){
				ext = radios[i].value;
			}
		}
		var form = $('#queryForm').serialize();
		form = decodeURIComponent(form,true);
		location.href='${webRoot}/dataCheck/recording/exportFile.do?'+form+'&type='+ext+'&keyWords='+$("#dataList input[name='keyWords']").val()+'&checkDateStartDateStr='+$("#dataListcheckDateStart").val()+'&checkDateEndDateStr='+$("#dataListcheckDateEnd").val()+"&dataType=1&exportDataType=1";
		$("#exportModal").modal('hide');
	}*/
    
	var dgu = datagridUtil.initOption({
		tableId: "dataList",
		tableAction: "${webRoot}/dataCheck/recording/datagrid.do?refrel=/sampling/sendResultList.do",
		tableBar: {
			title: ["你送我检","检测结果"],
			ele: [{
				//监管类型
				eleShow: Permission.exist("1345-9"),
				eleType: 4,
				eleHtml: "<span class=\"check-date cs-fl\">" +
						"<span class=\"cs-name\" style=\"padding-right: 0px;\">监管类型：</span>" +
						"<span class=\"cs-input-style \" style=\"margin-left: 0px;\">" +
						"<input type=\"hidden\" name=\"regTypeId\" value=\"\" id=\"regTypeIds\" class=\"focusInput\"/>" +
						"<input type=\"text\" name=\"regTypeName\" class=\"choseRegType\" value=\"--全部--\" autocomplete=\"off\" style=\"width: 110px\" readonly/>" +
						"</span>" +
						"</span>"
			},{
				eleShow: 1,
				eleTitle: "检测日期",
				eleName: "checkDate",
				eleType: 3,
				eleStyle: "width:110px;",
				eleDefaultDateMin: newDate().DateAdd("m",-1).format("yyyy-MM-dd"),
				eleDefaultDateMax: newDate().format("yyyy-MM-dd")
			},{
				eleShow: 1,
				eleName: "keyWords",
				eleType: 0,
				elePlaceholder: "送样单号、检测点、送检人、联系电话"
			}],
			switchSearch: function(queryType){
				if (queryType == 0) {
					$("#dataList_checkDateStartDateInput").val($("#dataListcheckDateStart").val()+" 00:00:00");
					$("#dataList_checkDateEndDateInput").val($("#dataListcheckDateEnd").val()+" 23:59:59");
				} else {
					$("#dataListcheckDateStart").val(newDate($("#dataList_checkDateStartDateInput").val()).format("yyyy-MM-dd"));
					$("#dataListcheckDateEnd").val(newDate($("#dataList_checkDateEndDateInput").val()).format("yyyy-MM-dd"));
				}
			}
		},
		parameter: [
				{
					columnCode: "sampleCode",
					columnName: "样品编号",
					columnWidth: "94px"
				}, {
					columnCode: "departName",
					columnName: "检测机构",
					queryCode:"departName",
					query: 1
				},
				{
					columnCode: "pointName",
					columnName: "检测点",
					queryCode:"pointName",
					query: 1
				},
				{
					columnCode: "regName",
					columnName: "送检人",
					queryCode:"regName",
					query: 1
				}
				 ,
				 /*{
					columnCode: "purchaseAmount",
					columnName: "送检数(KG)",
					queryCode:"purchaseAmount",
					query: 1
				},
				{
					columnCode: "sampleNumber",
					columnName: "抽样数(KG)",
					queryCode:"sampleNumber",
					query: 1
				},
				{
					columnCode: "purchaseDate",
					columnName: "购买日期",
					queryCode:"purchaseDate",
					query: 1
				},
				{
					columnCode: "origin",
					columnName: "购买地点"
				}, */
				
				{
					columnCode: "foodName",
					columnName: "样品名称",
					queryCode: "foodName",
					query: 1
				},
				{
					columnCode: "itemName",
					columnName: "检测项目",
					queryCode: "itemName",
					query: 1
				},
				{
					columnCode: "checkResult",
					columnName: "检测值"
				},
				{
					columnCode: "conclusion",
					columnName: "检测结果",
					query: 1,
					queryCode: "conclusion",
					queryType: 2,
					customVal: {"合格":"<div class=\"text-success\">合格</span>","不合格":"<div class=\"text-danger\">不合格</span>"}
					
				},
				{
					columnCode: "checkDate",
					columnName: "检测时间",
					dateFormat: "yyyy-MM-dd HH:mm:ss",
					query:1,
					queryCode: "checkDate",
					queryName: "检测日期",
					queryDateFormat: "yyyy-MM-dd",
					queryType:3
				},
				{
					columnCode: "checkUsername",
					columnName: "检测人员"
				}
		],
		funBtns: [
	    	{	//查看按钮
				show: Permission.exist("1345-1"),
				style: Permission.getPermission("1345-1"),
	    		action: function(id){
	    			//window.location = "${webRoot}/dataCheck/recording/checkDetail.do?id="+id;
	    			showMbIframe("${webRoot}/dataCheck/recording/checkDetail.do?id="+id);
	    		}
	    	}, {
	    		//删除按钮
				show: Permission.exist("1345-2"),
				style: Permission.getPermission("1345-2"),
	    		action: function(id){
	    			deleteId = id;
	  				$("#confirm-delete").modal('toggle');
	    		}
	    	}
	    ],
	    defaultCondition: [
  	    	{
  				queryCode: "udealType",
  				queryVal: "0"
  			}, {
				queryCode : "dataType",
				queryVal : 1
			}
  	    ],
		bottomBtns: [
			 {//导出函数
				 show: Permission.exist("1345-6"),
				 style: Permission.getPermission("1345-6"),
		    		action: function(ids, rows){
						exportIds = ids;
		    			$("#exportModal").modal('toggle');
		    		}
		    }, {//导出台账
				show: Permission.exist("1345-7"),
				style: Permission.getPermission("1345-7"),
				action: function(ids, rows) {
					//检测结果数量 > 300000
					if (dgu.datagridOption.rowTotal && dgu.datagridOption.rowTotal>300000) {
						$("#confirm-warnning .tips").text("每次导出数据不能大于30万条");
						$("#confirm-warnning").modal('toggle');
					}else {
						exportDataType = 2;
						$("#myModalLabel").html("导出台账");
						$("#exportStandBookModal").modal('toggle');
					}
				}
			}, {//导出快检公示
				show: Permission.exist("1345-8"),
				style: Permission.getPermission("1345-8"),
				action: function(ids, rows) {
					//检测结果数量 > 300000
					if (dgu.datagridOption.rowTotal && dgu.datagridOption.rowTotal>300000) {
						$("#confirm-warnning .tips").text("每次导出数据不能大于30万条");
						$("#confirm-warnning").modal('toggle');
					}else {
						exportDataType = 3;
						// $("#exportModal").modal('toggle');
						$("#myModalLabel").html("导出公示");
						$("#exportStandBookModal").modal('toggle');
					}
				}
			}
		] 
	});
	dgu.queryByFocus();

	var exportIds="";
	function exportFile() {
		var radios = document.getElementsByName('inlineRadioOptions');
		var ext = '';
		for (var i = 0; i < radios.length; i++) {
			if (radios[i].checked) {
				ext = radios[i].value;
			}
		}
		if(ext!=''){
			var form = $('#queryForm').serialize();
			form = decodeURIComponent(form, true);
			var queryParams = dgu.getQueryParam();
			var exportFileUrl = "${webRoot}/dataCheck/recording/exportFile?dataType=1&exportDataType=1&ids="+exportIds+"&type="+ext;
			if (queryParams){
				for (var key in queryParams) {
					switch (key) {
						case "dateMap":
							var dateMap = queryParams.dateMap;
							if (dateMap) {
								for (var dateMapKey in dateMap) {
									switch (dateMapKey) {
										case "checkDateStartDate":
											exportFileUrl += "&checkDateStartDateStr="+dateMap[dateMapKey];
											break;
										case "checkDateEndDate":
											exportFileUrl += "&checkDateEndDateStr="+dateMap[dateMapKey];
											break;
									}
								}
							}
							break;
						case "checkDateStartDate":
							exportFileUrl += "&checkDateStartDateStr="+queryParams[key]+" 00:00:00";
							break;
						case "checkDateEndDate":
							exportFileUrl += "&checkDateEndDateStr="+queryParams[key]+" 23:59:59";
							break;
						default:
							exportFileUrl += "&"+key+"="+queryParams[key];
							break;
					}
				}
			}
			location.href = exportFileUrl;

			//location.href = '${webRoot}/dataCheck/recording/exportFile.do?' + form + '&type=' + ext + '&keyWords=' + $("#dataList input[name='keyWords']").val()+'&checkDateStartDateStr='+$("#dataListcheckDateStart").val()+'&checkDateEndDateStr='+$("#dataListcheckDateEnd").val()+"&regTypeId="+$("#dataList input[name='regTypeId']").val()+"&dataType=${dataType}&exportDataType="+exportDataType+"&ids="+exportIds;
			$("#exportModal").modal('hide');
		}else {
			$("#exportModal").modal('hide');
			$("#confirm-warnning .tips").text("请选择导出格式!");
			$("#confirm-warnning").modal('toggle');
		}
	}
    /**
     * 查询检测标准信息
     */
    function getId(e){
    	var id=e;
    	$.ajax({
    	url: "${webRoot}/dataCheck/recording/queryById.do",
    	type:"POST",
    	data:{"id":id},
    	dataType:"json",
    	success:function(data){
    	      var form = $('#saveForm');
    		  form.form('load', data.obj);
    		  $("[name=checked][value="+data.obj.checked+"]").prop("checked","checked");
    	},
    	error:function(){
    		alert("操作失败");
    	}
    	})
    }
    
    //删除函数
    function deleteByID(){
    	$.ajax({
	        type: "POST",
	        url: "${webRoot}/dataCheck/recording/delete.do",
	        data: {"rid":deleteId},
	        success: function(data){
	        	if(data && data.success){
	        		//删除成功后刷新列表
					dgu.query();
	        	}
			},
			error: function(){
				console.log("删除失败!");
			}
	    });
			$("#confirm-delete").modal('toggle');
		}
    </script>
  </body>
</html>
