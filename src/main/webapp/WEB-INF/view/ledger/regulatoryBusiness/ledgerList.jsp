<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/common/resource.jsp"%>
<html>
  <head>
    <title>快检服务云平台</title>
    <style>
    	.cs-pass-show{
    		position:absolute;
    		right:8px;
    		top:2px;
    	}
    	.cs-modal-input{
    		position:relative;
    	}
    	.trshow{
    	display: none
    	}
    </style>
  </head>
  <body>
          <!-- 面包屑导航栏  开始-->
          <div class="cs-col-lg clearfix">
            <ol class="cs-breadcrumb">
              <li class="cs-fl">
              <img src="${webRoot}/img/set.png"/>
              <a href="javascript:">台账管理</a></li>
              <li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
              <li class="cs-b-active cs-fl">经营单位</li>
             <c:if test="${!empty regName}">
               <li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
                <li class="cs-b-active cs-fl">${regName}</li>
                </c:if>
              <li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
              <li class="cs-b-active cs-fl">经营户</li>
            </ol>
          <!-- 面包屑导航栏  结束-->
            <div class="cs-search-box cs-fr">
              <form>
                <div class="cs-search-filter clearfix cs-fl">
                <!-- <input class="cs-input-cont cs-fl" type="text" placeholder="请输入任务名称" />
                <input type="submit" class="cs-search-btn cs-fl" href="javascript:;" value="搜索"> -->
                <input class="cs-input-cont cs-fl focusInput" type="text" placeholder="请输入经营户名称" name="regulatoryBusiness.opeShopName" id="opeShopNames" />
                <input type="button" class="cs-search-btn cs-fl" href="javascript:;" value="搜索" onclick="datagridUtil.queryByFocus();">
             <!--    <span class="cs-s-search cs-fl">高级搜索</span> -->
                </div>
                <div class="clearfix cs-fr" id="showBtn">
					<!-- <a class="cs-menu-btn" href="javascript:;" onclick="self.history.back();"><i class="icon iconfont icon-fanhui"></i>返回</a> -->
                <a href="${webRoot}/ledger/regulatoryObject/ledgerList.do?regTypeCode=0"  class="cs-menu-btn"><i class="icon iconfont icon-fanhui"></i>返回</a>   
                </div>
                <!-- <a class="cs-menu-btn" href="javascript:;" onclick="goBusiness();"><i class="icon iconfont icon-zengjia"></i>新增</a> -->
              </form>
            </div>
          </div>

		<div id="dataList"></div>
    
    <!-- Modal 新增经营户-->
	<div class="modal fade intro2" id="businessModal" tabindex="-1"
		role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="static">
		<div class="modal-dialog cs-xlg-width">
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
					         <td class="cs-name"><i class="cs-mred">*</i>档口编号：</td>
					         <td class="cs-in-style"><input type="text" name="regulatoryBusiness.opeShopCode"  id="ShopCode"  datatype="*" nullmsg="请输入档口标号" errormsg="请请输入档口标号" /></td>
					         <td class="cs-name">档口名称：</td>
					         <td class="cs-in-style"><input type="text" name="regulatoryBusiness.opeShopName"  id="opeShopName"  datatype="*" nullmsg="请输入档口名称" errormsg="请请输入档口名称"/></td>
					      </tr>
					      <tr>
					      	<td class="cs-name">社会统一信用代码：</td>
					         <td class="cs-in-style"><input type="text" name="regulatoryBusiness.creditCode" /></td>
					         <td class="cs-name">经营者：</td>
					         <td class="cs-in-style"><input type="text" name="regulatoryBusiness.opeName" /></td>
					         
					      </tr>
					         <tr>
					      <td class="cs-name">联系人：</td>
					         <td class="cs-in-style"><input type="text" name="regulatoryBusiness.contacts" /></td>
					      	<td class="cs-name">联系方式：</td>
					         <td class="cs-in-style"><input type="text" name="regulatoryBusiness.opePhone" /></td>
					         
					         
					      </tr>
					      <tr>
					      <td class="cs-name">经营者身份证：</td>
					         <td class="cs-in-style"><input type="text" name="regulatoryBusiness.opeIdcard" /></td>
					      	<td class="cs-name">信用等级：</td>
					         <td class="cs-in-style">
					         	<select name="regulatoryBusiness.creditRating" id="creditRating">
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
					         	<select name="regulatoryBusiness.monitoringLevel" id="monitoringLevel">
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
					      <td class="cs-name">经营范围：</td>
					         <td class="cs-in-style"><textarea name="regulatoryBusiness.businessCope" maxlength="100" rows="" cols="" style="width: 200px; height: 50px;"></textarea></td>
					      <td class="cs-name  audit cs-hide">状态：</td>
							 <td class="cs-in-style   audit cs-hide cs-radio">
								<input id="business-radio0" type="radio" value="0" name="regulatoryBusiness.checked" /><label for="business-radio0">未审核</label>
								<input id="business-radio1" type="radio" value="1" name="regulatoryBusiness.checked" checked="checked"/><label for="business-radio1">已审核</label>
							 </td>
					      </tr>
					      <tr class="trshow">
					      	<td >营业执照信息</td>
					      </tr>
					      <tr class="trshow">
					      	 <input type="hidden" name="regulatoryLicense.id" />
					         <td class="cs-name">法人名称：</td>
					         <td class="cs-in-style"><input type="text" name="regulatoryLicense.legalPerson" /></td>
					         <td class="cs-name">法人身份证：</td>
					         <td class="cs-in-style"><input type="text" name="regulatoryLicense.idcard" /></td>
					      </tr>
					      <tr class="trshow">
					         <td class="cs-name">营业执照名称：</td>
					         <td class="cs-in-style"><input type="text" name="regulatoryLicense.licenseName" /></td>
					         <td class="cs-name">注册资金（万）：</td>
					         <td class="cs-in-style"><input type="text" name="regulatoryLicense.capital" /></td>
					      </tr >
					      <tr class="trshow">
					         <td class="cs-name">营业执照编号：</td>
					         <td class="cs-in-style"><input type="text" name="regulatoryLicense.licenseCode" /></td>
					         <td class="cs-name">营业执照注册日期：</td>
					         <td class="cs-in-style"><input type="text" name="regulatoryLicense.licenseRdate" class="cs-time" 
									onClick="WdatePicker({startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true})"/></td>
					      </tr>
					      <tr class="trshow">
					         <td class="cs-name">营业执照发证日期：</td>
					         <td class="cs-in-style"><input type="text" name="regulatoryLicense.licenseSdate" class="cs-time" 
									onClick="WdatePicker({startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true})"/></td>
					         <td class="cs-name">营业执照有效期至：</td>
					         <td class="cs-in-style"><input type="text" name="regulatoryLicense.licenseEdate" class="cs-time" 
									onClick="WdatePicker({startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true})"/></td>
					      </tr>
					      <tr class="trshow">
					         <td class="cs-name">经营范围：</td>
					         <td class="cs-in-style"><input type="text" name="regulatoryLicense.scope" /></td>
					         <td class="cs-name">发证机关：</td>
					         <td class="cs-in-style"><input type="text" name="regulatoryLicense.authority" /></td>
					      </tr>
					      <tr class="trshow">
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
				<div class="modal-body cs-lg-height cs-2dcode-box"></div>
				<!--endprint-->
				<div class="modal-footer">
					<button type="button" class="btn btn-success" onclick="preview();">打印</button>
        			<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				</div>
			</div>
		</div>
	</div>
    <!-- 用户新增/编辑模态框 start-->
	<div class="modal fade intro2" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
		<div class="modal-dialog cs-mid-width" role="document">
			<div class="modal-content ">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">微信账号管理</h4>
				</div>
				<div class="modal-body cs-mid-height">
					<!-- 主题内容 -->
					<div class="cs-main">
						<div class="cs-wraper">
							<form id="saveform" method="post">
								<input type="hidden" name="opeId" id="busiId">
								<input type="hidden" name="regId" id="regId" value="${regulatoryObject.id}">
								<input type="hidden" name="regName" id="regName" value="${regulatoryObject.regName}">
								<input type="hidden" name="departId" id="departId" value="${regulatoryObject.departId}">
								<input type="hidden" name="departName" id="departName" value="${regulatoryObject.departName}">
								<input type="hidden" name="opeShopName" id="busiName">
								<input type="hidden" name="type" value="0">
								<input type="hidden" name="id" id="ledgerUserId">
								<div width="50%" class="cs-add-new">
									<ul class="cs-ul-form clearfix">
											<li class="cs-name col-xs-3 col-md-3">档口：</li>
											<li class="cs-in-style cs-modal-input"><input type="text" name="opeShopCode" id="busiCode" class="inputxt" readonly="readonly" ></li>
										</ul>
										<ul class="cs-ul-form clearfix">
											<li class="cs-name col-xs-3 col-md-3">账号：</li>
											<li class="cs-in-style cs-modal-input"><input type="text" name="username" id="username" class="inputxt" nullmsg="请输入账号" errormsg="请输入账号"></li>
										</ul>
										<ul class="cs-ul-form clearfix">
											<li class="cs-name col-xs-3 col-md-3">密码：</li>
											<li class="cs-in-style cs-modal-input"><input type="password" name="pwd" datatype="*6-18" class="inputxt" plugin="passwordStrength" id="pwd"  nullmsg="请输入密码" errormsg="请输入密码"><i class="cs-pass-show  icon iconfont icon-chakan"></i></li>
										</ul>
											<ul class="cs-ul-form clearfix">
										<li class="cs-name col-xs-3 col-md-3">开通权限：</li>
										<li class="cs-al cs-modal-input"><input id="cs-check-radio" type="radio" value="1" name="status"  /><label for="cs-check-radio">启用</label> <input id="cs-check-radio2" type="radio" value="0" name="status" checked="checked"  /><label for="cs-check-radio2">停用</label></li>
									</ul>
									<ul class="cs-ul-form clearfix" style="display: none" id="jiebang">
										<li class="cs-name col-xs-3 col-md-3"></li>
										<li class="cs-al cs-modal-input"><button type="button"  onclick="jiebang(1);" class="btn btn-danger"  >解除绑定</button>
										</li>
									</ul>
									<ul class="cs-ul-form clearfix" style="display: none" id="weibd">
										<li class="cs-name col-xs-3 col-md-3">微信绑定：</li>
										<li class="cs-al cs-modal-input"><button type="button"  class="btn btn-success"  >暂无绑定</button>
										</li>
									</ul>
								</div>
						</div>
					</div>
					</form>
				</div>
				<div class="modal-footer action">
					<button type="button" class="btn btn-success" id="Save" onclick="save();">保存</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				</div>
			</div>
		</div>
	</div>
	<!-- 用户新增/编辑模态框  end -->
	<%@include file="/WEB-INF/view/common/confirm.jsp"%>
    <!-- 用户新增/编辑模态框  end -->
<!-- 解除微信绑定模态框 start  2018-5-24 cola_hu-->
	<div class="modal fade intro2" id="confirm-delete3" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog cs-alert-width">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button> <input type="hidden" id="userId">
					<h4 class="modal-title">确认删除</h4>
				</div>
				<div class="modal-body cs-alert-height cs-dis-tab">
					<div class="cs-text-algin">
						<img src="${webRoot}/img/stop2.png" width="40px" /> <span class="tips">确认解除微信绑定么？</span>
					</div>
				</div>
				<div class="modal-footer">
					<a class="btn btn-danger btn-ok" onclick="delwx();">删除</a>
					<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
				</div>
			</div>
		</div>
	</div>

	<div class="modal fade intro2" id="confirm-warnning" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog cs-alert-width">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title">提示</h4>
				</div>
				<div class="modal-body cs-alert-height cs-dis-tab">
					<div class="cs-text-algin" id="false" style="display: none">
						<img src="${webRoot}/img/warn.png" width="40px" alt="" /> <span class="tips" id="waringMsg">操作失败</span>
					</div>
					<div class="cs-text-algin" id="true" style="display: none">
						<img src="${webRoot}/img/sure.png" width="40px" alt="" /> <span class="tips" id="successMsg">操作成功</span>
					</div>
				</div>
				<div class="modal-footer">
					<a class="btn btn-primary btn-ok" data-dismiss="modal">关闭</a>
				</div>
			</div>
		</div>
	</div>
	<!-- end  -->
    <!-- JavaScript -->
	<%@ include file="/WEB-INF/view/common/exportDialog.jsp" %>
	        <%@include file="/WEB-INF/view/common/modalBox.jsp"%>
    <script src="${webRoot}/js/datagridUtil.js"></script>
    <script src="${webRoot}/js/jquery.form.js"></script>
    <script type="text/javascript">
    var ledgerUser = 0;
	var ledgerUserObj;
	var qrcodeBtn=0;
	var qrcodeObj;
	var stock=0;
	var	stockObj;
	var sale=0;
	var saleObj;
	var businessExports = 0;
	var businessExportObj;
	var outbusinessExports = 0;
	var outbusinessExportObj;
	var manaType=1;//当manaType为0时是批发市场 只有批发市场才有销售
	manaType='${manaType}';
	for (var i = 0; i < childBtnMenu.length; i++) {
		if (childBtnMenu[i].operationCode == "1396-13") {
			//var html='<a class="cs-menu-btn" href="#addModal"  data-toggle="modal" ><i class="'+childBtnMenu[i].functionIcon+'"></i>新增</a>';
			$("#showBtn").prepend("<a class=\"cs-menu-btn\" href=\"javascript:;\" onclick=\"goBusiness();\"><i class=\""+childBtnMenu[i].functionIcon+"\"></i>新增</a>");
		}else if (childBtnMenu[i].operationCode == "1396-14") {
			edit = 1;
			editObj=childBtnMenu[i];
		}else if (childBtnMenu[i].operationCode == "1396-15") {
			deletes = 1;
			deleteObj=childBtnMenu[i];
		}else if (childBtnMenu[i].operationCode == "1396-5") {
			qrcodeBtn = 1;
			qrcodeObj=childBtnMenu[i];
		}
		else if (childBtnMenu[i].operationCode == "1396-6") {
			stock = 1;
			stockObj=childBtnMenu[i];
		}
		else if (childBtnMenu[i].operationCode == "1396-7" && manaType=="0") {
			sale = 1;
			saleObj=childBtnMenu[i];
		}
		else if (childBtnMenu[i].operationCode == "1396-10") {
			ledgerUser = 1;
			ledgerUserObj=childBtnMenu[i];
		}else if (childBtnMenu[i].operationCode == "1396-9") {
			//经营户导入
			businessExports = 1;
			businessExportObj = childBtnMenu[i];
		}
		else if (childBtnMenu[i].operationCode == "1396-12") {
			//经营户导出
			outbusinessExports = 1;
			outbusinessExportObj = childBtnMenu[i];
		}else if (childBtnMenu[i].operationCode == "1396-19") {
			//审核权限
			$(".audit").show();
		}else if (childBtnMenu[i].operationCode == "1396-20") {
			$(".trshow").show();  //经营户更多信息
		}
	}
    
	var regulatoryId = "";	//监管对象ID
	if("${regulatoryObject}" && "${regulatoryObject.id}"){
		regulatoryId = "${regulatoryObject.id}";
	}
		
    var op3 = {
    		tableId: "dataList",	//列表ID
    		tableAction: '${webRoot}'+"/ledger/business/datagrid.do",	//加载数据地址
    		funColumnWidth : "150px",
    		parameter: [		//列表拼接参数
    			{
    				columnCode: "opeShopCode",
    				columnName: "档口编号",
    				customElement : "<a class=\"cs-link-text yiwanc\" href=\"javascript:;\">?</a>"
    			},
    			{
    				columnCode: "opeShopName",
    				columnName: "经营户",
    				query: 1,
    				queryCode: "regulatoryBusiness.opeShopName"
    			},
    		
    			{
    				columnCode: "opeName",
    				columnName: "经营者"
    			},
    			{
    				columnCode: "id",
    				columnName: "二维码",
    				customElement: "<a class=\"runcode qrcode\" data-value='?' href=\"javascript:;\"><img src=\"${webRoot}/img/2dcode.png\" alt=\"\" /></a>"
    			},
    			{
    				columnCode: "username",
    				columnName: "微信账号",
    			},
    			{
    				columnCode: "yiwanc",
    				columnName: "台账录入数量",
    				
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
    						        url: '${webRoot}'+"/ledger/business/queryById.do",
    						        data: {"id":id},
    						        dataType: "json",
    						        success: function(data){
    						        	if(data && data.success && data.obj){
    						        		$("#businessModal .modal-title").text("编辑");
    						    			$("#businessModal").modal("toggle");
    						    			if(data.obj.regulatoryBusiness){
    							    			$("#businessModal input[name='regulatoryBusiness.id']").val(data.obj.regulatoryBusiness.id);
    						    				$("#businessModal input[name='regulatoryBusiness.opeShopName']").val(data.obj.regulatoryBusiness.opeShopName);
    						    				$("#businessModal input[name='regulatoryBusiness.opeShopCode']").val(data.obj.regulatoryBusiness.opeShopCode);
    						    				$("#businessModal input[name='regulatoryBusiness.creditCode']").val(data.obj.regulatoryBusiness.creditCode);
    						    				$("#businessModal input[name='regulatoryBusiness.opeName']").val(data.obj.regulatoryBusiness.opeName);
    						    				$("#businessModal input[name='regulatoryBusiness.contacts']").val(data.obj.regulatoryBusiness.contacts);
    						    				$("#businessModal input[name='regulatoryBusiness.opePhone']").val(data.obj.regulatoryBusiness.opePhone);
    						    				$("#businessModal input[name='regulatoryBusiness.opeIdcard']").val(data.obj.regulatoryBusiness.opeIdcard);
    						    				/*$("#businessModal input[name='regulatoryBusiness.creditRating']").val(data.obj.regulatoryBusiness.creditRating);
   						    				 $("#businessModal input[name='regulatoryBusiness.monitoringLevel']").val(data.obj.regulatoryBusiness.monitoringLevel);*/
   						    				document.getElementById('creditRating').value=data.obj.regulatoryBusiness.creditRating;
   						    				document.getElementById('monitoringLevel').value=data.obj.regulatoryBusiness.monitoringLevel;
    						    				$("#businessModal textarea[name='regulatoryBusiness.remark']").val(data.obj.regulatoryBusiness.remark);
    						    				$("#businessModal textarea[name='regulatoryBusiness.businessCope']").val(data.obj.regulatoryBusiness.businessCope); 
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
    			    	},
    			    	{
    			    		show: stock,//进货按钮
    			    		style: stockObj,
    			    		action: function(id){
    			    		var regId='${regulatoryObject.id}';
    			    		var  src='${webRoot}'+"/ledger/stock/add.do?businessId="+id+"&regId="+regId;
    			    		showMbIframe(src);	
    			    		}
    			    	},
    			    		{
        			    		show: sale,//销售台账按钮
        			    		style: saleObj,
        			    		action: function(id){
        			    		var regId='${regulatoryObject.id}';
        			    		var  src='${webRoot}'+"/ledger/sale/add.do?businessId="+id+"&regId="+regId;
        			    		showMbIframe(src);	
        			    		}
    			    		}, {
								show : ledgerUser,
								style : ledgerUserObj,
								action : function(id) {
									getRegName(id);
									$("#busiId").val(id);
									$("#userId").val(id);
									$("#myModal").modal('toggle');
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
    		    			    	}, {//导入经营户按钮
    		    						show : businessExports,
    		    						style : businessExportObj,
    		    						action : function(ids) {
    		    							location.href = '${webRoot}/regulatory/business/toImport.do'
    		    						}
    		    					},{//导出经营户按钮
    		    						show : outbusinessExports,
    		    						style : outbusinessExportObj,
    		    						action : function(ids) {
    		    							$("#exportModal").modal('toggle');
    		    						}
    		    					}
    		    			    ]	//底部按钮
    	};
	datagridUtil.initOption(op3);
	
    datagridUtil.query();
    
  //导出方法
    function exportFile() {
        var radios = document.getElementsByName('inlineRadioOptions');
        var ext = '';
        for (var i = 0; i < radios.length; i++) {
            if (radios[i].checked) {
                ext = radios[i].value;
            }
        }
        var regId='${regulatoryObject.id}';
        location.href = '${webRoot}/regulatory/business/exportFile.do?types=' + ext + "&regId=" + regId+"&opeShopName="+$("#opeShopNames").val();
        $("#exportModal").modal('hide');
    }
    $(document).on("click",".qrcode",function(){
    	viewQrcode($(this).attr("data-value"));
    });
	//查看经营户
	$(document).on("click", ".yiwanc", function() {
		if(stock==1||sale==1){
		var regId='${regulatoryObject.id}';
		self.location = '${webRoot}/ledger/stock/list.do?businessId=' + $(this).parents(".rowTr").attr("data-rowId")+'&regId='+regId;
		}
	});
    
  	//查看二维码
    function viewQrcode(ids){
    	$("#qrcodeModal .modal-body").html("");
    	$.ajax({
	        type: "POST",
	        url: '${webRoot}'+"/ledger/business/businessQrcode.do",
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
		$("#creditRating option:first").prop("selected", 'selected');
		$("#monitoringLevel option:first").prop("selected", 'selected');
		
		var file = $("#businessModal input[name='filePathImage']"); 
		file.after(file.clone().val("")); 
		file.remove(); 
	});
	
	function goBusiness(){
		if(!regulatoryId){
			return;
		}
		$("#businessModal .modal-title").text("新增");
		$("#businessModal").modal("toggle");
	}
	
	function addBusiness(){
		var ShopCode=$("#ShopCode").val();
		if(ShopCode==""||ShopCode==null){
			$("#confirm-warnning .tips").text("档口编号不能为空!");
			$("#confirm-warnning").modal('toggle');
			return;
		}
	/* 	var opeShopName=$("#opeShopName").val();
		if(opeShopName==""||opeShopName==null){
			$("#confirm-warnning .tips").text("档口名称不能为空!");
			$("#confirm-warnning").modal('toggle');
			return;
		} */
		$("#businessForm").ajaxSubmit({
			type:'post',
			url: '${webRoot}'+"/ledger/business/save.do",
			success: function(data){
				if(data && data.success){
					$("#businessModal").modal("hide");
					$("#confirm-warnning .tips").text(data.msg);
					$('#confirm-warnning').modal('toggle');
					datagridUtil.query();
				}else{
					$("#confirm-warnning .tips").text(data.msg);
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
	        url: '${webRoot}'+"/ledger/business/delete.do",
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
    	<script type="text/javascript">
    /* 	function getType(e) {
			if (e == 1) {
				$("#user").hide();
			} else {
				$("#user").show();
			}
		} */
	function save() {
			var username=$("#username").val();
			if(username==null ||username==""){
				$("#confirm-warnning .tips").text("请输入账号!");
				$("#confirm-warnning").modal('toggle');
				return ;
			}
			var pwd=$("#pwd").val();
			$("#pwd").val($.trim(pwd));
			 pwd=$("#pwd").val();
			if(pwd==null ||pwd==""){
				$("#confirm-warnning .tips").text("请输入密码!");
				$("#confirm-warnning").modal('toggle');
				return ;
		}
		$.ajax({
			type : "POST",
			url : '${webRoot}' + "/ledger/regulatoryUser/save.do",
			data : $('#saveform').serialize(),
			dataType : "json",
			success : function(data) {
				if (data.success) {
						if(data.obj!=null){
						$("#ledgerUserId").val(data.obj.id);
						}
						$("#myModal").modal('hide');
						datagridUtil.query();
				} else {
					//$.Showmsg(data.msg);
					$("#waringMsg>span").html(data.msg);
	        		$("#confirm-warnning").modal('toggle');
				}
			}
		})
		
	}
	$(function () {
		$('#myModal').on('hide.bs.modal', function () {
			$("input[name='status'][value='0']").prop('checked', true);
			$("#username").val("");
			$("#pwd").val("");//食品名称
			$("#ledgerUserId").val("");
			$("#userId").val("");
			$("#user").hide();
		 })
		 });
	
	function getRegName(id) {
		var obj=datagridOption.obj;
		for (var i = 0; i < obj.length; i++) {
			if(obj[i].id==id){
				$("#busiCode").val(obj[i].opeShopCode);
				$("#busiName").val(obj[i].opeShopName);
			}
		}
		$.ajax({
			type : "POST",
			url : '${webRoot}' + "/ledger/regulatoryUser/getLedgerUser.do?opeId=" + id,
			dataType : "json",
			success : function(data) {
				var obj = data.obj;
				if(obj!=null&&obj!=""){
				$("input[name='status'][value="+obj.status+"]").prop('checked', true);
				$("#username").val(obj.username);
				$("#pwd").val(obj.pwd);//食品名称
				$("#ledgerUserId").val(obj.id);
				$("#userId").val(obj.id);
				$("#regId").val(obj.regId);
				if(obj.status==1){
					$("#user").show();
				}
				if(obj.openid){
					$("#jiebang").show();
					$("#weibd").hide();
				}else{
					$("#weibd").show();
					$("#jiebang").hide();
				}
				}else{//没有账号绑定
					$("#weibd").show();
					$("#jiebang").hide();
				}
			}
		});
	}
	
	var showHide=1;
	$('.cs-pass-show').click(function(){
		if(showHide==1){
		$(this).removeClass('icon-chakan').addClass('icon-zengjia');
		$("#pwd").attr('type','text');
		showHide=0
		}else{
			$(this).removeClass('icon-zengjia').addClass('icon-chakan');
			$("#pwd").attr('type','password');
			showHide=1
		}
	})
	
	//解除当前档口账号绑定
	function jiebang(id) {
		//$("#confirm-delete3").modal("show");
			var userId = $("#userId").val();
		if (userId == null || userId	 == "") {
			alertMsg("解除失败","false");
			return;
		}
			$.ajax({
				type : "POST",
				url : '${webRoot}' + "/ledger/regulatoryUser/deleteOpenid.do",
				data : {
					id : userId,
				},
				dataType : "json",
				success : function(data) {
					if (data.success) {
						$("#weibd").show();
						$("#jiebang").hide();
					} else {
					 	alertMsg("解除失败","false"); 
					}
				
				}
			})
	}
	
	function delwx() {
	
		
	}
	function alertMsg(msg,rel) {
		if(rel=="true"){
			$("#true").show();
			$("#false").hide();
				$("#confirm-warnning").modal("show");
		}else if(rel=="false"){
			$("#waringMsg").text("绑定角色不能为空!");
			$("#false").show();
			$("#true").hide();
			$("#confirm-warnning").modal("show");
		}
	}
	
	</script>
  </body>
</html>
