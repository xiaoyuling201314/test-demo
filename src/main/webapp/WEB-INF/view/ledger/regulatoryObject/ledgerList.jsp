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
.cs-tabtitle li {
	height: 34px;
	line-height: 35px;
}

.cs-tabtitle ul {
	padding-top: 4px;
}
</style>
</head>
<body>
	<!-- 面包屑导航栏  开始-->
	<div class="cs-col-lg clearfix">
		<ol class="cs-breadcrumb">
			<li class="cs-fl"><img src="${webRoot}/img/set.png" /> <a href="javascript:">台账管理</a></li>
			<li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
			<li class="cs-b-active cs-fl" id="regTypeName">${regType}</li>
		</ol>
		<div class="cs-input-style cs-fl" style="margin: 3px 0 0 30px;">
			选择机构:
			<div class="cs-all-ps">
				<div class="cs-input-box">
					<input type="text" name="departNames">
					<div class="cs-down-arrow"></div>
				</div>
				<div class="cs-check-down cs-hide" style="display: none;">
					<ul id="tree" class="easyui-tree"></ul>
				</div>
			</div>
			<input name="departids" type="hidden">
			<!-- <select class="check-date cs-selcet-style" id="tree">
               
              </select>  -->

		</div>
		<!-- 面包屑导航栏  结束-->
		<div class="cs-search-box cs-fr">
			<form>
				<input class="cs-input-cont cs-fl focusInput" type="text" name="regulatoryObject.regName" placeholder="请输入企业名称" id="regNames" /> <input type="button" onclick="datagridUtil.queryByFocus();" class="cs-search-btn cs-fl" href="javascript:;" value="搜索">
				<!-- <div class="cs-search-filter clearfix cs-fl">
					<span class="cs-s-search cs-fl">高级搜索</span>
				</div> -->
				<div class="clearfix cs-fr" id="showBtn">
					<!-- 	<a href="#" class="cs-menu-btn" onclick="show();"><i class="icon iconfont icon-zengjia"></i>弹框新增</a> -->
				</div>
			</form>
		</div>
	</div>


	<div class="cs-tabtitle clearfix" id="tabtitle">
		<input type="hidden" id="getregType" name="setregType" value="${regTypeId}">
		<ul>
			<c:forEach items="${regulatoryTypes}" var="rtype">
			<c:if test="${reg eq null }">
				<c:choose>
					<c:when test="${rtype.id==regTypeId}">
						<li class="cs-tabhover" data-tabtitleNo="1" id="getregType1" onclick="setregType('${rtype.id}','${rtype.regType}','${rtype.showBusiness}','${rtype.stockType}');">${rtype.regType}</li>
						<input type="hidden" id="showType" value="${rtype.showBusiness}">
						<input type="hidden" id="showType1" value="${rtype.stockType}">
						
					</c:when>
					<c:otherwise>
						<li class="cs-taba" data-tabtitleNo="1" onclick="setregType('${rtype.id}','${rtype.regType}','${rtype.showBusiness}','${rtype.stockType}');">${rtype.regType}</li>
					</c:otherwise>
				</c:choose></c:if>
				<c:if test="${reg ne null }">
				<c:choose>
					<c:when test="${rtype.id==regTypeId}">
						<input type="hidden" id="showType" value="${rtype.showBusiness}">
						<input type="hidden" id="showType1" value="${rtype.stockType}">
					</c:when>
				</c:choose></c:if>
			</c:forEach>
		</ul>
	</div>
	<div id="dataList"></div>
	<div class="modal fade intro2" id="qrcodeModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog cs-lg-width">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
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
					<h4 class="modal-title" id="myModalLabel">新增</h4>
				</div>
				<div class="modal-body cs-mid-height">
					<!-- 主题内容 -->
					<div class="cs-main">
						<div class="cs-wraper">
							<form id="saveform" method="post">
								<input type="hidden" name="regId" id="regId">
								<input type="hidden" name="type" value="1">
								<input type="hidden" name="id" id="ledgerUserId">
								<div width="50%" class="cs-add-new">
									<ul class="cs-ul-form clearfix">
											<li class="cs-name col-xs-3 col-md-3">市场：</li>
											<li class="cs-in-style cs-modal-input"><input type="text" name="regName" id="regName" class="inputxt" readonly="readonly" ></li>
										</ul>
								
									<div id="user" >
										<ul class="cs-ul-form clearfix">
											<li class="cs-name col-xs-3 col-md-3">账号：</li>
											<li class="cs-in-style cs-modal-input"><input type="text" name="username" id="username" autocomplete="off" class="inputxt" min="6" nullmsg="请输入账号" errormsg="请输入账号"></li>
										</ul>
									<ul class="cs-ul-form clearfix">
											<li class="cs-name col-xs-3 col-md-3">密码：</li>
											<li class="cs-in-style cs-modal-input"><input type="password" name="pwd" datatype="*6-18" autocomplete="off" class="inputxt" plugin="passwordStrength" id="pwd"  nullmsg="请输入密码" errormsg="请输入密码"><i class="cs-pass-show  icon iconfont icon-chakan"></i></li>
										</ul>
											<ul class="cs-ul-form clearfix">
										<li class="cs-name col-xs-3 col-md-3">开通权限：</li>
										<li class="cs-al cs-modal-input"><input id="cs-check-radio" type="radio" value="1" name="status"   /><label for="cs-check-radio">启用</label> <input id="cs-check-radio2" type="radio" value="0" name="status" checked="checked"   /><label for="cs-check-radio2">停用</label></li>
									</ul>
										<ul class="cs-ul-form clearfix" style="display: none" id="jiebang">
										<li class="cs-name col-xs-3 col-md-3">微信绑定：</li>
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
	<%@include file="/WEB-INF/view/common/confirm.jsp"%>
	<%@include file="/WEB-INF/view/common/modalBox.jsp"%>
	<%@ include file="/WEB-INF/view/common/exportDialog.jsp" %>

	<!-- JavaScript -->
	<script src="${webRoot}/js/datagridUtil.js"></script>
	<script type="text/javascript">
		var showBusiness = false;
		var showStock=false;
		var showStock1=false;
		var qrcodeBtn = 0;
		var qrcodeObj;
		var stock = 0;//进货台帐
		var stockObj;
		var businessExports = 0;
		var businessExportObj;
		var objectExports = 0;
		var objectExportObj;
		var outobjectExports = 0;
		var outobjectExportObj;
		var sale=0;
		var saleObj;
		var wx=0;//监管对象微信权限
		var wxObj;
		var reguser='${reg}';
		for (var i = 0; i < childBtnMenu.length; i++) {
			if (childBtnMenu[i].operationCode == "1396-1" && reguser=='') {
			 	//新增
				var html = '<a class="cs-menu-btn" onclick="add();" ><i class="'+childBtnMenu[i].functionIcon+'"></i>新增</a>';
				$("#showBtn").append(html); 
			} else if (childBtnMenu[i].operationCode == "1396-2") {
				//编辑
				edit = 1;
				editObj = childBtnMenu[i];
			} else if (childBtnMenu[i].operationCode == "1396-3") {
				//删除
				deletes = 1;
				deleteObj = childBtnMenu[i];
			} else if (childBtnMenu[i].operationCode == "1396-5") {
				qrcodeBtn = 1;
				qrcodeObj = childBtnMenu[i];
			} else if (childBtnMenu[i].operationCode == "1396-6") {
				stock = 1;
				stockObj = childBtnMenu[i];
			}else if (childBtnMenu[i].operationCode == "1396-7") {
				sale = 1;
				saleObj = childBtnMenu[i];
			}else if (childBtnMenu[i].operationCode == "1396-8") {
				//监管对象导入
				objectExports = 1;
				objectExportObj = childBtnMenu[i];
			}else if (childBtnMenu[i].operationCode == "1396-11") {
				//监管对象导出
				outobjectExports = 1;
				outobjectExportObj = childBtnMenu[i];
			}else if (childBtnMenu[i].operationCode == "1396-21") {
				//微信
				wx = 1;
				wxObj = childBtnMenu[i];
			} 
		}
		$('#tree').tree({
			checkbox : false,
			url : "${webRoot}/detect/depart/getDepartTree.do",
			animate : true,
			onLoadSuccess: function (node, data) {
			    if (data.length > 0) {
			    	$("input[name='departNames']").val(data[0].text);
			    	$("input[name='departids']").val(data[0].id);
			             }
			      }, 
			onClick : function(node) {
				var did = node.id;
				$("input[name='departNames']").val(node.text);
				$("input[name='regulatoryObject.regName']").val("");
				$(".cs-check-down").hide();
				$("input[name='departids']").val(did);
				bigbang(did);
			},onSelect:function(node) {
    			var did=node.id;
    			$("input[name='departids']").val(node.id);
    		}
		});

		$(function() {
			//加载的时候取被选中的项值
			var showType=$("#showType").val();// 0是经营户 1是市场
			var showType1=$("#showType1").val();
			if(showType==1){
				showBusiness = true;
			}
			bigbang(0);
		})

		function setregType(e, b,showType,stockType) {
			$("#getregType").val(e);
			$("input[name='regulatoryObject.regName']").val("");
			$("#regTypeName").text(b);//标题
			if (showType == 1) {
				showBusiness = true;
			} else {
				showBusiness = false;
			}
			if(stockType==1){//为1时表示 针对市场录入台账
				showStock=true;
			}else{
				showStock=false;
			}
			bigbang(0);
		}

		function bigbang(e) {
			var did = e;
			if (did == 0) {
				var d = $("input[name='departids']").val();
				if (d != null && d != "") {
					did = d;
				}
			}
			var op = "";
			var getregType = $("#getregType").val();
			var sss = $("#regTypeName").text();//标题
			if (!showBusiness) {
				//其他单位
				if(showStock||showType1){//如果有台账权限
					op = {
							tableId : "dataList", //列表ID
							tableAction : '${webRoot}' + "/ledger/regulatoryObject/datagrid.do?did=" + did, //加载数据地址
							parameter : [ //列表拼接参数
									{
										columnCode : "departName",
										columnName : "所属机构"
									},
									{
										columnCode : "regName",
										columnName : "企业名称",
										customElement : "<a class=\"cs-link-text objStock\"  href=\"javascript:;\">?</a>",
										query : 1
									},
									{
										columnCode : "id",
										columnName : "二维码",
										customElement : "<a class=\"runcode qrcode\" data-value='?' href=\"javascript:;\"><img src=\"${webRoot}/img/2dcode.png\" alt=\"\" /></a>"
									}, {
										columnCode : "regAddress",
										columnName : "地址"
									}, {
										columnCode : "checked",
										columnName : "状态",
										customVal : {
											"0" : "<div class=\"text-danger\">未审核</div>",
											"1" : "<div class=\"text-primary\">已审核</div>"
										}
									} ],
							defaultCondition : [ //默认查询条件
							{
								queryCode : "regulatoryObject.regType",
								queryVal : getregType
							} ],
							funBtns : [
									{
										show : edit,
										style : editObj,
										action : function(id) {
											self.location = '${webRoot}/ledger/regulatoryObject/ledgerAddRegulatoryObject.do?regTypeId='
													+ getregType + '&id=' + id;
										}
									}, 
									{
										show : stock,//进货按钮
										style : stockObj,
										action : function(id) {
											var regId = '${regulatoryObject.id}';
											var src= '${webRoot}' + "/ledger/stock/add.do?winType=1&htmlType=1&regId="
													+ id+'&regTypeId='+ getregType;
											showMbIframe(src);
										}
									}, {
										show : sale,//销售按钮
										style : saleObj,
										action : function(id) {
											var regId = '${regulatoryObject.id}';
											var src='${webRoot}'+"/ledger/sale/add.do?winType=1&htmlType=1&regId="+id+'&regTypeId='+ getregType;
											showMbIframe(src);	
										}
									},{
										show : deletes,
										style : deleteObj,
										action : function(id) {
											if (id == '') {
												$("#confirm-warnning .tips").text("请选择监管对象");
												$("#confirm-warnning").modal('toggle');
											} else {
												deleteIds = id;
												$("#confirm-delete").modal('toggle');
											}
										}
									} , {
										show : wx,
										style : wxObj,
										action : function(id) {
											getRegName(id);
											$("#regId").val(id);
											$("#myModal").modal('toggle');
										}
									}], //操作列按钮 
							bottomBtns : [ {
								show : qrcodeBtn,
								style : qrcodeObj,
								action : function(ids) {
									if (ids == '') {
										$("#confirm-warnning .tips").text("请选择监管对象");
										$("#confirm-warnning").modal('toggle');
									} else {
										viewQrcode(ids);
									}
								}
							}, {
								show : deletes,
								style : deleteObj,
								action : function(ids) {
									if (ids == '') {
										$("#confirm-warnning .tips").text("请选择监管对象");
										$("#confirm-warnning").modal('toggle');
									} else {
										deleteIds = ids;
										$("#confirm-delete").modal('toggle');
									}
								}
							},{//导入监管对象按钮
								show : objectExports,
								style : objectExportObj,
								action : function(ids) {
									location.href = '${webRoot}/regulatory/regulatoryObject/toImport.do'
								}
							},{//导出监管对象按钮
								show : outobjectExports,
								style : outobjectExportObj,
								action : function(ids) {
									$("#exportModal").modal('toggle');
								}
							}
							]
						//底部按钮
						};
				}else{
					op = {
							tableId : "dataList", //列表ID
							tableAction : '${webRoot}' + "/ledger/regulatoryObject/datagrid.do?did=" + did, //加载数据地址
							parameter : [ //列表拼接参数
									{
										columnCode : "departName",
										columnName : "所属机构"
									},
									{
										columnCode : "regName",
										columnName : "企业名称",
										query : 1
									},
									{
										columnCode : "id",
										columnName : "二维码",
										customElement : "<a class=\"runcode qrcode\" data-value='?' href=\"javascript:;\"><img src=\"${webRoot}/img/2dcode.png\" alt=\"\" /></a>"
									}, {
										columnCode : "regAddress",
										columnName : "地址"
									}, {
										columnCode : "checked",
										columnName : "状态",
										customVal : {
											"0" : "<div class=\"text-danger\">未审核</div>",
											"1" : "<div class=\"text-primary\">已审核</div>"
										}
									} ],
							defaultCondition : [ //默认查询条件
							{
								queryCode : "regulatoryObject.regType",
								queryVal : getregType
							} ],
							funBtns : [
									{
										show : edit,
										style : editObj,
										action : function(id) {
											self.location = '${webRoot}/ledger/regulatoryObject/ledgerAddRegulatoryObject.do?regTypeId='
													+ getregType + '&id=' + id;
										}
									}, {
										show : deletes,
										style : deleteObj,
										action : function(id) {
											if (id == '') {
												$("#confirm-warnning .tips").text("请选择监管对象");
												$("#confirm-warnning").modal('toggle');
											} else {
												deleteIds = id;
												$("#confirm-delete").modal('toggle');
											}
										}
									} ], //操作列按钮 
							bottomBtns : [ {
								show : qrcodeBtn,
								style : qrcodeObj,
								action : function(ids) {
									if (ids == '') {
										$("#confirm-warnning .tips").text("请选择监管对象");
										$("#confirm-warnning").modal('toggle');
									} else {
										viewQrcode(ids);
									}
								}
							}, {
								show : deletes,
								style : deleteObj,
								action : function(ids) {
									if (ids == '') {
										$("#confirm-warnning .tips").text("请选择监管对象");
										$("#confirm-warnning").modal('toggle');
									} else {
										deleteIds = ids;
										$("#confirm-delete").modal('toggle');
									}
								}
							},{//导入监管对象按钮
								show : objectExports,
								style : objectExportObj,
								action : function(ids) {
									location.href = '${webRoot}/regulatory/regulatoryObject/toImport.do'
								}
							},{//导出监管对象按钮
								show : outobjectExports,
								style : outobjectExportObj,
								action : function(ids) {
									$("#exportModal").modal('toggle');
								}
							}
							]
						//底部按钮
						};
				}
				
			} else {
				//经营单位
				op = {
					tableId : "dataList", //列表ID
					tableAction : '${webRoot}' + "/ledger/regulatoryObject/datagrid.do?did=" + did, //加载数据地址
					parameter : [ //列表拼接参数
							{
								columnCode : "departName",
								columnName : "所属机构"
							},
							{
								columnCode : "regName",
								columnName : "市场名称",
								customElement : "<a class=\"cs-link-text objStock\"  href=\"javascript:;\">?</a>",
								query : 1
							},
							{
								columnCode : "id",
								columnName : "二维码",
								customElement : "<a class=\"runcode qrcode\" data-value='?' href=\"javascript:;\"><img src=\"${webRoot}/img/2dcode.png\" alt=\"\" /></a>",
								columnWidth : "70px"
							}, {
								columnCode : "businessNumber",
								columnName : "经营户",
								customElement : "<a class=\"cs-link-text businessNumber\" href=\"javascript:;\">?户</a>",
								columnWidth : "70px"
							},{
								columnCode : "yiwanc",
								columnName : "完成档口数",
								columnWidth : "120px",
								sortDataType:"int"
							},{
								columnCode : "managementType",
								columnName : "市场类型",
								customVal : {
									"0" : "批发市场",
									"1" : "农贸市场",
									"default" : ""
								},
								columnWidth : "80px"
							}, {
								columnCode : "regAddress",
								columnName : "地址"
							}, {
								columnCode : "checked",
								columnName : "状态",
								customVal : {
									"0" : "<div class=\"text-danger\">未审核</div>",
									"1" : "<div class=\"text-primary\">已审核</div>"
								},
								columnWidth : "80px"
							} ],
					defaultCondition : [ //默认查询条件
					{
						queryCode : "regulatoryObject.regType",
						queryVal : getregType
					} ],
					funBtns : [
							{
								show : edit,
								style : editObj,
								action : function(id) {
									self.location = '${webRoot}/ledger/regulatoryObject/ledgerAddRegulatoryObject.do?regTypeId=${regTypeId}&id='
											+ id;
								}
							},
							{
								show : stock,//进货按钮
								style : stockObj,
								action : function(id) {
									var regId = '${regulatoryObject.id}';
									var src= '${webRoot}' + "/ledger/stock/add.do?winType=1&htmlType=1&businessId=" + id + "&regId="
									+ id+'&regTypeId='+ getregType;
										showMbIframe(src);
								}
							}, {
								show : sale,//销售按钮
								style : saleObj,
								action : function(id) {
									var regId = '${regulatoryObject.id}';
									var src='${webRoot}'+"/ledger/sale/add.do?winType=1&htmlType=1&businessId="+id+"&regId="+id+'&regTypeId='+ getregType;
									showMbIframe(src);	
									}
							}, {
								show : deletes,
								style : deleteObj,
								action : function(id) {
									if (id == '') {
										$("#confirm-warnning .tips").text("请选择监管对象");
										$("#confirm-warnning").modal('toggle');
									} else {
										deleteIds = id;
										$("#confirm-delete").modal('toggle');
									}
								}
							}
							, {
								show : wx,
								style : wxObj,
								action : function(id) {
									getRegName(id);
									$("#regId").val(id);
									$("#myModal").modal('toggle');
								}
							}], //操作列按钮 
					bottomBtns : [ {
						show : qrcodeBtn,
						style : qrcodeObj,
						action : function(ids) {
							if (ids == '') {
								$("#confirm-warnning .tips").text("请选择监管对象");
								$("#confirm-warnning").modal('toggle');
							} else {
								viewQrcode(ids);
							}
						}
					}, {
						show : deletes,
						style : deleteObj,
						action : function(ids) {
							if (ids == '') {
								$("#confirm-warnning .tips").text("请选择监管对象");
								$("#confirm-warnning").modal('toggle');
							} else {
								deleteIds = ids;
								$("#confirm-delete").modal('toggle');
							}
						}
					},{//导入监管对象按钮
						show : objectExports,
						style : objectExportObj,
						action : function(ids) {
							location.href = '${webRoot}/regulatory/regulatoryObject/toImport.do'
						}
					},{//导出监管对象按钮
						show : outobjectExports,
						style : outobjectExportObj,
						action : function(ids) {
							$("#exportModal").modal('toggle');
						}
					} 

					], //底部按钮
					 onload: function(){
						/*  console.log(datagridOption);
						 for (var i = 0; i < datagridOption.obj.length; i++) {
								alert(datagridOption.obj[i].managementType);
							if(datagridOption.obj[i].managementType==1){
							
							}
							 
						} */
						var obj = datagridOption["obj"];
				    	$(".rowTr").each(function(){
					    	for(var i=0;i<obj.length;i++){
						    		if($(this).attr("data-rowId") == obj[i].id){
						    			if(obj[i].managementType==1){
							    			//隐藏编辑按钮
							    			$(this).find(".1396-7").hide();
							    		}
						    		}
					    		}
				    	});
					}
					
					
					//执行方法：
				/* 	function onload() {
						alert("2");
					} */
				};
			}

			datagridUtil.initOption(op);

			/* datagridUtil.query(); */
			datagridUtil.queryByFocus();
		}

		//查看经营户
		$(document).on("click", ".businessNumber", function() {
			self.location = '${webRoot}/ledger/business/ledgerList.do?regId=' + $(this).parents(".rowTr").attr("data-rowId");
		});
		//查看市场下的台账数据
		$(document).on("click", ".objStock", function() {
			if(sale==1||stock==1){
			var regId=$(this).parents(".rowTr").attr("data-rowId");
			var obj = datagridOption["obj"];
			var managementType=1;
		    	for(var i=0;i<obj.length;i++){
			    		if(regId == obj[i].id){
			    		managementType=obj[i].managementType;
			    		}
		    		}
		        var regType = $("#getregType").val();
		    	self.location = '${webRoot}/ledger/stock/list.do?htmlType=1&ledgerType='+managementType+'&regId=' +regId+'&regTypeId='+regType;
			}
		});

		//删除
		var deleteIds = "";
		function deleteData() {
			$.ajax({
				type : "POST",
				url : '${webRoot}' + "/ledger/regulatoryObject/delete.do",
				data : {
					"ids" : deleteIds.toString()
				},
				dataType : "json",
				success : function(data) {
					if (data && data.success) {
						self.location.reload();
					} else {
						$("#confirm-warnning .tips").text("删除失败");
						$("#confirm-warnning").modal('toggle');
					}
				}
			});
			$("#confirm-delete").modal('toggle');
		}

		$(document).on("click", ".qrcode", function() {
			viewQrcode($(this).attr("data-value"));
		});

		//查看二维码
		function viewQrcode(ids) {
			$("#qrcodeModal .modal-body").html("");
			$.ajax({
				type : "POST",
				url : '${webRoot}' + "/ledger/regulatoryObject/regObjectQrcode.do",
				data : {
					"ids" : ids.toString()
				},
				dataType : "json",
				success : function(data) {
					if (data && data.success) {
						for (var i = 0; i < data.obj.length; i++) {
							$("#qrcodeModal .modal-body").append(
									"<div class=\"cs-2dcode\"><img src=\"${webRoot}" + data.obj[i].qrcodeSrc
		        			+ "\" alt=\"\" width=\"150px\"><p>"
											+ data.obj[i].regName + "</p></div>");
						}
					}
				}
			});
			$('#qrcodeModal').modal('toggle');
		}

		//打印
		function preview() {
			if (!!window.ActiveXObject || "ActiveXObject" in window) {
				remove_ie_header_and_footer();
			}
			var bdhtml = window.document.body.innerHTML;
			var sprnstr = "<!--startprint-->";
			var eprnstr = "<!--endprint-->";
			var prnhtml = bdhtml.substring(bdhtml.indexOf(sprnstr) + 17);
			prnhtml = prnhtml.substring(0, prnhtml.indexOf(eprnstr));
			window.document.body.innerHTML = prnhtml;
			window.print();
			//setTimeout(location.reload(), 10);  
			window.document.body.innerHTML = bdhtml;

			window.location.reload();
		}
		//这是页面覆盖
		/* 	function show() {
				var src='${webRoot}'+"/ledger/regulatoryObject/goAddRegulatoryObject.do?regTypeId="+'${regTypeId}';
				alert(src);
				showMbIframe(src);
			} */
	/* 	function getType(e) {
			if (e == 1) {
				$("#user").hide();
			} else {
				$("#user").show();
			}
		}; */
		//导出方法
	    function exportFile() {
	        var radios = document.getElementsByName('inlineRadioOptions');
	        var ext = '';
	        for (var i = 0; i < radios.length; i++) {
	            if (radios[i].checked) {
	                ext = radios[i].value;
	            }
	        }
	        var regType = $("#getregType").val();
	        var departId=$("input[name='departids']").val();
	        location.href = '${webRoot}/regulatory/regulatoryObject/exportFile.do?types=' + ext + "&departId=" + departId+"&regName="+$("#regNames").val()+"&regType="+regType;
	        $("#exportModal").modal('hide');
	    }
	</script>
	<script type="text/javascript">
	function save() {
			var username=$("#username").val().trim();
			if(username==null ||username==""){
				$("#confirm-warnning .tips").text("请输入账号!");
				$("#confirm-warnning").modal('toggle');
				return ;
			}
			if(username.length<6){
				$("#confirm-warnning .tips").text("请输入至少6位账号!");
				$("#confirm-warnning").modal('toggle');
				return ;
			}
			var pwd=$("#pwd").val().trim();
			console.log(pwd.length);
			if(pwd==null ||pwd==""){
				$("#confirm-warnning .tips").text("请输入密码!");
				$("#confirm-warnning").modal('toggle');
				return ;
			}
			if(pwd.length<6){
				$("#confirm-warnning .tips").text("请输入至少6位密码!");
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
					//$.Showmsg(data.msg);
						if(data.obj!=null){
						$("#ledgerUserId").val(data.obj.id);
						}
						$("#myModal").modal('hide');
						datagridUtil.query();
				} else {
					$("#waringMsg>span").html(data.msg);
	        		$("#confirm-warnning").modal('toggle');
				}
			}
		})
		
	}
	$(function () {
		$('#myModal').on('hide.bs.modal', function () {
			$("#username").val("");
			$("#pwd").val("");//食品名称
			$("#ledgerUserId").val("");
			$("#regId").val("");
			$("input[name='status'][value='0']").prop('checked', true);
		 })
		 });
	
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
	//获取账号
	function getRegName(id) {
		var obj=datagridOption.obj;
		for (var i = 0; i < obj.length; i++) {
			if(obj[i].id==id){
				$("#regName").val(obj[i].regName);
			}
		}
		$.ajax({
			type : "POST",
			url : '${webRoot}' + "/ledger/regulatoryUser/getLedgerUser.do?regId=" + id,
			dataType : "json",
			success : function(data) {
				var obj = data.obj;
				if(obj!=null&&obj!=""){
				$("#user").show();
				$("input[name='status'][value="+obj.status+"]").prop('checked', true);
				$("#username").val(obj.username);
				$("#pwd").val(obj.pwd);//食品名称
				$("#ledgerUserId").val(obj.id);
				$("#regId").val(obj.regId);
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
	//根据不同的类型跳转
	function add() {
		var getregType=$("#getregType").val();
		self.location="${webRoot}/ledger/regulatoryObject/ledgerAddRegulatoryObject.do?regTypeId="+getregType;
	}
	
	//解除当前档口账号绑定
 
	function jiebang(id){
		var userId = $("#ledgerUserId").val();
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
