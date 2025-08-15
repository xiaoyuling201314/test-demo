<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/common/resource.jsp"%>
<html>
  <head>
    <title>快检服务云平台</title>
  </head>
  <body>
          <!-- 面包屑导航栏  开始-->
          <div class="cs-col-lg clearfix">
            <ol class="cs-breadcrumb">
              <li class="cs-fl">
              <img src="${webRoot}/img/set.png"/>
              <a href="javascript:">监管对象</a></li>
              <li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
              <li class="cs-b-active cs-fl">经营单位</li>
              <li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
              <li class="cs-b-active cs-fl">经营户</li>
            </ol>
          <!-- 面包屑导航栏  结束-->
            <div class="cs-search-box cs-fr">
              <form>
                <div class="cs-search-filter clearfix cs-fl">
                <!-- <input class="cs-input-cont cs-fl" type="text" placeholder="请输入任务名称" />
                <input type="submit" class="cs-search-btn cs-fl" href="javascript:;" value="搜索"> -->
                <input class="cs-input-cont cs-fl focusInput" type="text" placeholder="请输入经营户名称" name="regulatoryBusiness.opeShopName" />
                <input type="button" class="cs-search-btn cs-fl" href="javascript:;" value="搜索" onclick="datagridUtil.queryByFocus();">
                <span class="cs-s-search cs-fl">高级搜索</span>
                </div>
                <div class="clearfix cs-fr" id="showBtn">
					<a class="cs-menu-btn" href="javascript:" onclick="self.history.back();"><i class="icon iconfont icon-fanhui"></i>返回</a>
                </div>
                <!-- <a class="cs-menu-btn" href="javascript:;" onclick="goBusiness();"><i class="icon iconfont icon-zengjia"></i>新增</a> -->
              </form>
            </div>
          </div>

		<div id="dataList"></div>
    
    <!-- Modal 新增经营户-->
	<div class="modal fade intro2" id="businessModal" tabindex="-1"
		role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="static">
		<div class="modal-dialog cs-lg-width">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title">经营户信息</h4>
				</div>
				<div class="modal-body cs-lg-height">
					<form id="businessForm" enctype="multipart/form-data">
					  <input type="hidden" name="regulatoryBusiness.regId" <c:if test="${!empty regulatoryObject}">value="${regulatoryObject.id}"</c:if>>
					  <div class="cs-content">
					  	<input type="hidden" name="regulatoryBusiness.id">
					    <table class="cs-add-new">
					      <tr>
					      	<td>基本信息</td>
					      </tr>
					      <tr>
					         <td class="cs-name"><i class="cs-mred">*</i>档口名称：</td>
					         <td class="cs-in-style"><input type="text" name="regulatoryBusiness.opeShopName" /></td>
					         <td class="cs-name"><i class="cs-mred">*</i>档口编号：</td>
					         <td class="cs-in-style"><input type="text" name="regulatoryBusiness.opeShopCode" /></td>
					      </tr>
					      <tr>
					         <td class="cs-name">经营者名称：</td>
					         <td class="cs-in-style"><input type="text" name="regulatoryBusiness.opeName" /></td>
					         <td class="cs-name">经营者联系方式：</td>
					         <td class="cs-in-style"><input type="text" name="regulatoryBusiness.opePhone" /></td>
					      </tr>
					      <tr>
					         <td class="cs-name">经营者身份证：</td>
					         <td class="cs-in-style"><input type="text" name="regulatoryBusiness.opeIdcard" /></td>
					         <td class="cs-name">信用等级：</td>
					         <td class="cs-in-style">
					         	<select name="regulatoryBusiness.creditRating">
					         		<option value="1">A</option>
					         		<option value="2">B</option>
					         		<option value="3">C</option>
					         		<option value="4">D</option>
					         	</select>
					         </td>
					      </tr>
					      <tr>
					      	 <td class="cs-name">监控级别：</td>
					         <td class="cs-in-style">
					         	<select name="regulatoryBusiness.monitoringLevel">
					              <option value="1">安全</option>
					              <option value="2">轻微</option>
					              <option value="3">警惕</option>
					              <option value="4">严重</option>
					            </select>
					         </td>
					         <td class="cs-name">备注：</td>
					         <td class="cs-in-style"><textarea type="text" name="regulatoryBusiness.remark"></textarea></td>
					      </tr>
					      <tr>
					      	 <td class="cs-name">状态：</td>
							 <td class="cs-in-style cs-radio">
								<input id="business-radio0" type="radio" value="0" name="regulatoryBusiness.checked" checked="checked"/><label for="business-radio0">未审核</label>
								<input id="business-radio1" type="radio" value="1" name="regulatoryBusiness.checked"/><label for="business-radio1">已审核</label>
							 </td>
					      </tr>
					      <tr>
					      	<td>营业执照信息</td>
					      </tr>
					      <tr>
					      	 <input type="hidden" name="regulatoryLicense.id" />
					         <td class="cs-name">法人名称：</td>
					         <td class="cs-in-style"><input type="text" name="regulatoryLicense.legalPerson" /></td>
					         <td class="cs-name">法人身份证：</td>
					         <td class="cs-in-style"><input type="text" name="regulatoryLicense.idcard" /></td>
					      </tr>
					      <tr>
					         <td class="cs-name">营业执照名称：</td>
					         <td class="cs-in-style"><input type="text" name="regulatoryLicense.licenseName" /></td>
					         <td class="cs-name">注册资金（万）：</td>
					         <td class="cs-in-style"><input type="text" name="regulatoryLicense.capital" /></td>
					      </tr>
					      <tr>
					         <td class="cs-name">营业执照编号：</td>
					         <td class="cs-in-style"><input type="text" name="regulatoryLicense.licenseCode" /></td>
					         <td class="cs-name">营业执照注册日期：</td>
					         <td class="cs-in-style"><input type="text" name="regulatoryLicense.licenseRdate" class="cs-time" 
									onClick="WdatePicker({startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true})"/></td>
					      </tr>
					      <tr>
					         <td class="cs-name">营业执照发证日期：</td>
					         <td class="cs-in-style"><input type="text" name="regulatoryLicense.licenseSdate" class="cs-time" 
									onClick="WdatePicker({startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true})"/></td>
					         <td class="cs-name">营业执照有效期至：</td>
					         <td class="cs-in-style"><input type="text" name="regulatoryLicense.licenseEdate" class="cs-time" 
									onClick="WdatePicker({startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true})"/></td>
					      </tr>
					      <tr>
					         <td class="cs-name">经营范围：</td>
					         <td class="cs-in-style"><input type="text" name="regulatoryLicense.scope" /></td>
					         <td class="cs-name">发证机关：</td>
					         <td class="cs-in-style"><input type="text" name="regulatoryLicense.authority" /></td>
					      </tr>
					      <tr>
					      	 <td class="cs-name">营业执照图片：</td>
					         <td class="cs-in-style">
					        	<input type="file" name="filePathImage" datatype="*" nullmsg="请选择图片" />
					         </td>
					         <td class="cs-name">备注：</td>
					         <td class="cs-in-style"><textarea type="text" name="regulatoryLicense.remark"></textarea></td>
					      </tr>
					    </table>
					  </div>
					</form>
				</div>
				<div class="modal-footer">
					<a class="btn btn-success btn-ok" onclick="addBusiness()">保存</a>
					<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
				</div>
			</div>
		</div>
	</div>
	
	<div class="modal fade intro2" id="qrcodeModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog cs-lg-width">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
					<h4 class="modal-title">二维码</h4>
				</div>
				<!--startprint-->
				<div class="modal-body cs-lg-height cs-dis-tab cs-2dcode-box"></div>
				<!--endprint-->
				<div class="modal-footer">
					<button type="button" class="btn btn-success" onclick="preview();">打印</button>
        			<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				</div>
			</div>
		</div>
	</div>
    
	<%@include file="/WEB-INF/view/common/confirm.jsp"%>
    
    <!-- JavaScript -->
    <script src="${webRoot}/js/datagridUtil.js"></script>
    <script src="${webRoot}/js/jquery.form.js"></script>
    <script type="text/javascript">
	
    /* for (var i = 0; i < childBtnMenu.length; i++) {
			if (childBtnMenu[i].operationCode == "331-1") {
				//新增
				var html='<a class="cs-menu-btn" href="${webRoot}/regulatory/regulatoryObject/goAddRegulatoryObject.do"><i class="'+childBtnMenu[i].functionIcon+'"></i>新增</a>';
				$("#showBtn").append(html);
			}else if (childBtnMenu[i].operationCode == "331-2") {
				//编辑
				edit = 1;
				editObj=childBtnMenu[i];
			}else if (childBtnMenu[i].operationCode == "331-3") {
				//删除
				deletes = 1;
				deleteObj=childBtnMenu[i];
			}
		} */
	var qrcodeBtn=0;
	var qrcodeObj;
	for (var i = 0; i < childBtnMenu.length; i++) {
		if (childBtnMenu[i].operationCode == "331-1") {
			//var html='<a class="cs-menu-btn" href="#addModal"  data-toggle="modal" ><i class="'+childBtnMenu[i].functionIcon+'"></i>新增</a>';
			$("#showBtn").prepend("<a class=\"cs-menu-btn\" href=\"javascript:;\" onclick=\"goBusiness();\"><i class=\""+childBtnMenu[i].functionIcon+"\"></i>"+childBtnMenu[i].operationName+"</a>");
		}else if (childBtnMenu[i].operationCode == "331-2") {
			edit = 1;
			editObj=childBtnMenu[i];
		}else if (childBtnMenu[i].operationCode == "331-3") {
			deletes = 1;
			deleteObj=childBtnMenu[i];
		}else if (childBtnMenu[i].operationCode == "331-7") {
			qrcodeBtn = 1;
			qrcodeObj=childBtnMenu[i];
		}
	}
    
	var regulatoryId = "";	//监管对象ID
	if("${regulatoryObject}" && "${regulatoryObject.id}"){
		regulatoryId = "${regulatoryObject.id}";
	}
		
    var op3 = {
    		tableId: "dataList",	//列表ID
    		tableAction: '${webRoot}'+"/regulatory/business/datagrid.do",	//加载数据地址
    		parameter: [		//列表拼接参数
    			{
    				columnCode: "opeShopName",
    				columnName: "经营户名称",
    				query: 1,
    				queryCode: "regulatoryBusiness.opeShopName"
    			},
    			{
    				columnCode: "id",
    				columnName: "二维码",
    				customElement: "<a class=\"runcode qrcode\" data-value='?' href=\"javascript:;\"><img src=\"${webRoot}/img/2dcode.png\" alt=\"\" /></a>",
					show: Permission.exist("331-7")
    			},
    			{
    				columnCode: "opeShopCode",
    				columnName: "档口编号"
    			},
    			{
    				columnCode: "opeName",
    				columnName: "经营者"
    			},
    			{
    				columnCode: "creditRating",
    				columnName: "信用等级",
    				query: 1,
    				queryCode: "regulatoryBusiness.creditRating",
    				customVal: {"1":"A","2":"B","3":"C","4":"D"}
    			},
    			{
    				columnCode: "monitoringLevel",
    				columnName: "监控级别",
    				query: 1,
    				queryCode: "regulatoryBusiness.monitoringLevel",
    				customVal: {"1":"安全","2":"轻微","3":"警惕","4":"严重"}
    			},
    			{
    				columnCode: "checked",
    				columnName: "状态",
    				customVal: {"0":"<div class=\"text-danger\">未审核</div>","1":"<div class=\"text-primary\">已审核</div>"}
    			}
    		],
    		defaultCondition: [
    			{
    		    	queryCode: "regulatoryObject.id",
    		    	queryVal: regulatoryId
    		    }
    		],
    		funBtns: [
    			    	{
    			    		show: edit,
    			    		style: editObj,
    			    		action: function(id){
    			    			$.ajax({
    						        type: "POST",
    						        url: '${webRoot}'+"/regulatory/business/queryById.do",
    						        data: {"id":id},
    						        dataType: "json",
    						        success: function(data){
    						        	if(data && data.success && data.obj){
    						    			$("#businessModal").modal("toggle");
    						    			if(data.obj.regulatoryBusiness){
    							    			$("#businessModal input[name='regulatoryBusiness.id']").val(data.obj.regulatoryBusiness.id);
    						    				$("#businessModal input[name='regulatoryBusiness.opeShopName']").val(data.obj.regulatoryBusiness.opeShopName);
    						    				$("#businessModal input[name='regulatoryBusiness.opeShopCode']").val(data.obj.regulatoryBusiness.opeShopCode);
    						    				$("#businessModal input[name='regulatoryBusiness.opeName']").val(data.obj.regulatoryBusiness.opeName);
    						    				$("#businessModal input[name='regulatoryBusiness.opePhone']").val(data.obj.regulatoryBusiness.opePhone);
    						    				$("#businessModal input[name='regulatoryBusiness.opeIdcard']").val(data.obj.regulatoryBusiness.opeIdcard);
    						    				$("#businessModal input[name='regulatoryBusiness.creditRating']").val(data.obj.regulatoryBusiness.creditRating);
    						    				$("#businessModal input[name='regulatoryBusiness.monitoringLevel']").val(data.obj.regulatoryBusiness.monitoringLevel);
    						    				$("#businessModal textarea[name='regulatoryBusiness.remark']").val(data.obj.regulatoryBusiness.remark);
    						    				if(data.obj.regulatoryBusiness.checked == 0){
    							    				$("#business-radio0").prop("checked", true);
    							    			}else if(data.obj.regulatoryBusiness.checked == 1){
    								    			$("#business-radio1").prop("checked", true);
    							    			}
    						    			}
    						    			if(data.obj.regulatoryLicense){
    						    				$("#businessModal input[name='regulatoryLicense.id']").val(data.obj.regulatoryLicense.id);
    						    				$("#businessModal input[name='regulatoryLicense.legalPerson']").val(data.obj.regulatoryLicense.legalPerson);
    						    				$("#businessModal input[name='regulatoryLicense.idcard']").val(data.obj.regulatoryLicense.idcard);
    						    				$("#businessModal input[name='regulatoryLicense.licenseName']").val(data.obj.regulatoryLicense.licenseName);
    						    				$("#businessModal input[name='regulatoryLicense.capital']").val(data.obj.regulatoryLicense.capital);
    						    				$("#businessModal input[name='regulatoryLicense.licenseCode']").val(data.obj.regulatoryLicense.licenseCode);
    						    				if(data.obj.regulatoryLicense.licenseRdate){
    								    			$("#businessModal input[name='regulatoryLicense.licenseRdate']").val(new Date(data.obj.regulatoryLicense.licenseRdate).format("yyyy-MM-dd"));
    							    			}
    						    				if(data.obj.regulatoryLicense.licenseSdate){
    								    			$("#businessModal input[name='regulatoryLicense.licenseSdate']").val(new Date(data.obj.regulatoryLicense.licenseSdate).format("yyyy-MM-dd"));
    							    			}
    						    				if(data.obj.regulatoryLicense.licenseEdate){
    								    			$("#businessModal input[name='regulatoryLicense.licenseEdate']").val(new Date(data.obj.regulatoryLicense.licenseEdate).format("yyyy-MM-dd"));
    							    			}
    						    				$("#businessModal input[name='regulatoryLicense.scope']").val(data.obj.regulatoryLicense.scope);
    						    				$("#businessModal input[name='regulatoryLicense.authority']").val(data.obj.regulatoryLicense.authority);
    						    				$("#businessModal textarea[name='regulatoryLicense.remark']").val(data.obj.regulatoryLicense.remark);
    						    			}
    						        	}else{
    						        		$('#confirm-warnning').modal('toggle');
    						        	}
    								}
    						   });
    			    		}
    			    	},
    			    	{
    			    		show: deletes,
    			    		style: deleteObj,
    			    		action: function(id){
    			    			if(id == ''){
	    			    			$("#confirm-warnning .tips").text("请选择经营户");
	    			    			$("#confirm-warnning").modal('toggle');
    			    			}else{
	    			    			deleteIds = id;
	    			    			$("#confirm-delete").modal('toggle');
    			    			}
    			    		}
    			    	}
    			    ],	//操作按钮 
    			    bottomBtns: [
									{
										show: qrcodeBtn,
										style: qrcodeObj,
										action: function(ids){
											if(ids == ''){
												$("#confirm-warnning .tips").text("请选择经营户");
												$("#confirm-warnning").modal('toggle');
											}else{
												viewQrcode(ids);
											}
										}
									},
    		    			    	{
    		    			    		show: deletes,
    		    			    		style: deleteObj,
    		    			    		action: function(ids){
    		    			    			if(ids == ''){
    			    			    			$("#confirm-warnning .tips").text("请选择经营户");
    			    			    			$("#confirm-warnning").modal('toggle');
    		    			    			}else{
    		    			    				deleteIds = ids;
												$("#confirm-delete").modal('toggle');
    		    			    			}
    		    			    		}
    		    			    	}
    		    			    ]	//底部按钮
    	};
	datagridUtil.initOption(op3);
	
    datagridUtil.query();
    
    $(document).on("click",".qrcode",function(){
    	viewQrcode($(this).attr("data-value"));
    });
    
  	//查看二维码
    function viewQrcode(ids){
    	$("#qrcodeModal .modal-body").html("");
    	$.ajax({
	        type: "POST",
	        url: '${webRoot}'+"/regulatory/business/businessQrcode.do",
	        data: {"ids":ids.toString()},
	        dataType: "json",
	        success: function(data){
	        	if(data && data.success){
		        	for(var i=0;i<data.obj.length;i++){
		        		$("#qrcodeModal .modal-body").append("<div class=\"cs-2dcode\"><img src=\"${webRoot}" + data.obj[i].qrcodeSrc
		        			+ "\" alt=\"\" width=\"150px\"><p>"+data.obj[i].opeShopName+" "+data.obj[i].opeShopCode+"</p></div>");
		        	}
	        	}
			}
	    });
    	$('#qrcodeModal').modal('toggle');
    }
    
	//清空输入框
	$('#businessModal').on('hidden.bs.modal', function () {
		$("#businessModal input[type!='hidden'][type!='radio']").val("");
		$("#businessModal input[name='regulatoryBusiness.id']").val("");
		$("#businessModal input[name='regulatoryLicense.id']").val("");
		$("#businessModal textarea").val("");
		$("#business-radio0").prop("checked", true);
		
		var file = $("#businessModal input[name='filePathImage']"); 
		file.after(file.clone().val("")); 
		file.remove(); 
	});
	
	function goBusiness(){
		if(!regulatoryId){
			return;
		}
		$("#businessModal").modal("toggle");
	}
	
	function addBusiness(){
		$("#businessForm").ajaxSubmit({
			type:'post',
			url: '${webRoot}'+"/regulatory/business/save.do",
			success: function(data){
				$("#businessModal").modal("hide");
				if(data && data.success){
					datagridUtil.query();
				}else{
					$("#waringMsg .tips").text(data.msg);
					$('#confirm-warnning').modal('toggle');
				}
			}
		});
	}
	
    //删除
    var deleteIds = "";
    function deleteData(){
    	$.ajax({
	        type: "POST",
	        url: '${webRoot}'+"/regulatory/business/delete.do",
	        data: {"ids":deleteIds.toString()},
	        dataType: "json",
	        success: function(data){
	        	if(data && data.success){
		        	self.location.reload();
	        	}else{
	        		$("#confirm-warnning .tips").text("删除失败");
	    			$("#confirm-warnning").modal('toggle');
	        	}
			}
	    });
		$("#confirm-delete").modal('toggle');
    }
    
    
    //打印
    /* function preview(){
        var headhtml = "<html><head><title></title></head><body>";
        var foothtml = "</body>";
        // 获取div中的html内容
        var newhtml = document.all.item("printContent").innerHTML;
        // 获取div中的html内容，jquery写法如下
        // var newhtml= $("#printContent").html();

        // 获取原来的窗口界面body的html内容，并保存起来
        var oldhtml = document.body.innerHTML;

        // 给窗口界面重新赋值，赋自己拼接起来的html内容
        document.body.innerHTML = headhtml + newhtml + foothtml;
        // 调用window.print方法打印新窗口
        window.print();

        // 将原来窗口body的html值回填展示
        document.body.innerHTML = oldhtml;
        return false;
    } */
    
  	//打印
    function preview(){     
		if (!!window.ActiveXObject || "ActiveXObject" in window) {
	        remove_ie_header_and_footer();
	    }
        var bdhtml=window.document.body.innerHTML;    
        var sprnstr="<!--startprint-->";    
        var eprnstr="<!--endprint-->";    
        var prnhtml=bdhtml.substring(bdhtml.indexOf(sprnstr)+17);    
        prnhtml=prnhtml.substring(0,prnhtml.indexOf(eprnstr));    
        window.document.body.innerHTML=prnhtml;    
        window.print();
	        //setTimeout(location.reload(), 10);  
        window.document.body.innerHTML=bdhtml; 
        
        window.location.reload();
	}
    </script>
  </body>
</html>
