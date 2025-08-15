<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/common/resource.jsp"%>
<html>
<style type="text/css">
	.cs-tittle-btn{
		margin-left:4px;
	}
	.cs-title-hs input{
		height:auto;
		margin-right:5px;
	}
	.qrcodes{
			height:94%;
			width:750px;
			margin:0 auto;
		}
		@media print {
		   .print-page{
		        height:auto;
		        width:100%;
		    }
		}
	
	#modal-box-iframe{
        width:100%;
        height: 100%;
        position: absolute;
        right:0;
        left: 0;
        top:0px;
        bottom: 0;
        border:0;
        border:none;
	}
	.cs-search-box{
      	position:absolute;
      	right:0px;
      	top:0px;
      	z-index:1;
	}
</style>
<head>
<title>快检服务云平台</title>


</head>
<body>
	<!-- 面包屑导航栏  开始-->
	<div class="cs-col-lg clearfix">
		<ol class="cs-breadcrumb">
			<li class="cs-fl"><img src="${webRoot}/img/set.png" /> <a href="javascript:">监管对象</a></li>
			<%--<li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
			<li class="cs-b-active cs-fl" id="regTypeName">${regType}</li>--%>
		</ol>
		<div class="cs-input-style cs-fl" style="margin: 3px 0 0 30px;">
			选择行政区:
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
				<input class="cs-input-cont cs-fl focusInput" type="text" name="regulatoryObject.regName" id="regNames" placeholder="请输入企业名称" /> <input type="button" onclick="datagridUtil.queryByFocus();" class="cs-search-btn cs-fl" href="javascript:;" value="搜索">
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
							<li class="cs-tabhover" data-tabtitleNo="1" id="getregType1" onclick="setregType('${rtype.id}','${rtype.regType}','${rtype.showBusiness}');">${rtype.regType}</li>
							<input type="hidden" id="showType" value="${rtype.showBusiness}">
						</c:when>
						<c:otherwise>
							<li class="cs-taba" data-tabtitleNo="1" onclick="setregType('${rtype.id}','${rtype.regType}','${rtype.showBusiness}');">${rtype.regType}</li>
						</c:otherwise>
					</c:choose></c:if>
				</c:forEach>
		</ul>
	</div>
	<div id="dataList"></div>
	 
	<div id="qrcodeModal" class="cs-modal-box cs-hide" style="padding:0;">
		<div class="cs-code-bb">
			<span>二维码尺寸：</span>
			<ul class="cs-code-box">
				<li class="cs-current" data-size="small">小</li>


				<li data-size="medium">中</li>
				<li data-size="large">大</li>
			</ul>
			<span class="cs-title-hs"><i class="pull-left">标题&nbsp; </i><input type="checkbox"></span>
			<div class="pull-right">
				<button type="button" class="btn btn-success" onclick="preview();">打印</button>
				<button type="button" class="btn btn-default" onclick="closeModal();">返回</button>
			</div>
			<div class="cs-title-ib cs-hide">
				<input id="qrcodeTitle" type="text" placeholder="请输入二维码标题"/>
				<button type="button" class="btn btn-success cs-tittle-btn">确定</button>
			</div>
		</div>
		<!--startprint-->
		<div class="qrcodes cs-lg-height cs-2dcode-box print-page clearfix" ></div>
		<!--endprint-->
	</div>

	<!-- 用户新增/编辑模态框 start-->
	<div class="modal fade intro2" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
		<div class="modal-dialog cs-sm-width" role="document">
			<div class="modal-content ">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">新增</h4>
				</div>
				<div class="modal-body cs-sm-height">
					<!-- 主题内容 -->
					<div class="cs-main">
						<div class="cs-wraper">
							<form id="saveform" method="post">
								<input type="hidden" name="regId" id="regId">
								<input type="hidden" name="type" value="0">
								<input type="hidden" name="id" id="ledgerUserId">
								<div width="50%" class="cs-add-new">
									<ul class="cs-ul-form clearfix">
											<li class="cs-name col-xs-3 col-md-3">市场：</li>
											<li class="cs-in-style cs-modal-input"><input type="text" name="regName" id="regName" class="inputxt" readonly="readonly" ></li>
										</ul>
									<ul class="cs-ul-form clearfix">
										<li class="cs-name col-xs-3 col-md-3">开通权限：</li>
										<li class="cs-al cs-modal-input"><input id="cs-check-radio" type="radio" value="1" name="status" onclick="getType(0);" /><label for="cs-check-radio">启用</label> <input id="cs-check-radio2" type="radio" value="0" name="status" checked="checked" onclick="getType(1);" /><label for="cs-check-radio2">停用</label></li>
									</ul>
									<div id="user" style="display: none">
										<ul class="cs-ul-form clearfix">
											<li class="cs-name col-xs-3 col-md-3">账号：</li>
											<li class="cs-in-style cs-modal-input"><input type="text" name="username" id="username" class="inputxt" nullmsg="请输入账号" errormsg="请输入账号"></li>
										</ul>
										<ul class="cs-ul-form clearfix">
											<li class="cs-name col-xs-3 col-md-3">密码：</li>
											<li class="cs-in-style cs-modal-input"><input type="password" name="pwd" datatype="*6-18" class="inputxt" plugin="passwordStrength" id="pwd"  nullmsg="请输入密码" errormsg="请输入密码"></li>
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
	<!-- 用户新增/编辑模态框  end -->
	<%@include file="/WEB-INF/view/common/confirm.jsp"%>
	<%@include file="/WEB-INF/view/common/modalBox.jsp"%>
	<%@ include file="/WEB-INF/view/common/exportDialog.jsp" %>
	<!-- JavaScript -->
	<script src="${webRoot}/js/datagridUtil.js"></script>
	<script type="text/javascript">
		var showBusiness = false;
		var stock = 0;//进货台帐
		var stockObj;
		var objectExports = 0;
		var objectExportObj;
		var outobjectExports = 0;
		var outobjectExportObj;
		var ledgerUser = 1;
		var ledgerUserObj = 1;
		var reguser='${reg}';
		var isshow=0;//查看预留字段
		var shichang=1;
		for (var i = 0; i < childBtnMenu.length; i++) {
			if (childBtnMenu[i].operationCode == "1373-1" && reguser=='') {
				//新增
				var html = '<a class="cs-menu-btn" onclick="add();" ><i class="'+childBtnMenu[i].functionIcon+'"></i>新增</a>';
				$("#showBtn").append(html);
			} else if (childBtnMenu[i].operationCode == "1373-2") {
				//编辑
				edit = 1;
				editObj = childBtnMenu[i];
			} else if (childBtnMenu[i].operationCode == "1373-3") {
				//删除
				deletes = 1;
				deleteObj = childBtnMenu[i];
			} else if (childBtnMenu[i].operationCode == "1373-6") {
				stock = 1;
				stockObj = childBtnMenu[i];
			} else if (childBtnMenu[i].operationCode == "1373-8") {
				//监管对象导入
				objectExports = 1;
				objectExportObj = childBtnMenu[i];
			} else if (childBtnMenu[i].operationCode == "1373-10") {
				//监管对象导出
				outobjectExports = 1;
				outobjectExportObj = childBtnMenu[i];
			} else if (childBtnMenu[i].operationCode == "1373-18") {
				//查看预留字段
				isshow=1;
				shichang=0;
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
			var showType=$("#showType").val();
			if(showType==1){
				showBusiness = true;
			}
			bigbang(0);
		})

	function setregType(e, b,showType) {
			$("#getregType").val(e);
			$("input[name='regulatoryObject.regName']").val("");
			$("#regTypeName").text(b);//标题
			if (showType == 1) {
				showBusiness = true;
			} else {
				showBusiness = false;
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
								customElement : "<a class=\"runcode qrcode\" data-value='?' href=\"javascript:;\"><img src=\"${webRoot}/img/2dcode.png\" alt=\"\" /></a>",
								show : Permission.exist('1373-5')
							}, {
								columnCode : "regAddress",
								columnName : "地址"
							}, {
								columnCode : "param1",
								columnName : "预留字段1",
								show:isshow
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
									self.location = '${webRoot}/ledger/regulatoryObject/goAddRegulatoryObject.do?regTypeId='
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
						show : Permission.exist('1373-5'),	//查看二维码
						style : Permission.getPermission('1373-5'),
						action : function(ids) {
							if (ids == '') {
								$("#confirm-warnning .tips").text("请选择监管对象");
								$("#confirm-warnning").modal('toggle');
							} else {
								viewQrcode(ids);
							}
						}
					}, {
						show : Permission.exist('1373-17'),	//导出二维码
						style : Permission.getPermission('1373-17'),
						action : function(ids) {
							if (!ids || ids.length == 0) {
								$("#confirm-warnning .tips").text("请选择监管对象");
								$("#confirm-warnning").modal('toggle');
								return;
							}
							location.href = '${webRoot}/regulatory/regulatoryObject/exportQrcode.do';
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
					}, {//导入监管对象按钮
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
								query : 1
							},
							{
								columnCode : "id",
								columnName : "二维码",
								customElement : "<a class=\"runcode qrcode\" data-value='?' href=\"javascript:;\"><img src=\"${webRoot}/img/2dcode.png\" alt=\"\" /></a>",
								columnWidth : "70px",
								show : Permission.exist('1373-5')
							}, {
								columnCode : "businessNumber",
								columnName : "经营户",
								customElement : "<a class=\"cs-link-text businessNumber\" href=\"javascript:;\">?户</a>",
								columnWidth : "70px"
							}, {
								columnCode : "managementType",
								columnName : "市场类型",
								customVal : {
									"0" : "批发市场",
									"1" : "农贸市场",
									"default" : ""
								},
								columnWidth : "100px",
								show:shichang
								
							}, {
								columnCode : "regAddress",
								columnName : "地址"
							}, {
								columnCode : "param1",
								columnName : "市场编码",
								columnWidth : "100px",
								show:isshow
							}, {
								columnCode : "checked",
								columnName : "状态",
								customVal : {
									"0" : "<div class=\"text-danger\">未审核</div>",
									"1" : "<div class=\"text-primary\">已审核</div>"
								},
								columnWidth : "100px"
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
									self.location = '${webRoot}/ledger/regulatoryObject/goAddRegulatoryObject.do?regTypeId='+ getregType + '&id='
											+ id;
								}
							},
							{
								show : stock,//进货按钮
								style : stockObj,
								action : function(id) {
									var regId = '${regulatoryObject.id}';
									window.location.href = '${webRoot}' + "/ledger/stock/edit.do?businessId=" + id + "&regId="
											+ id;
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
							}/* , {
								show : 1,
								style : editObj,
								action : function(id) {
									getRegName(id);
									$("#regId").val(id);
									$("#myModal").modal('toggle');
								}
							} */
							
							], //操作列按钮 
					bottomBtns : [ {
						show : Permission.exist('1373-5'),	//查看二维码
						style : Permission.getPermission('1373-5'),
						action : function(ids) {
							if (ids == '') {
								$("#confirm-warnning .tips").text("请选择监管对象");
								$("#confirm-warnning").modal('toggle');
							} else {
								viewQrcode(ids);
							}
						}
					}, {
						show : Permission.exist('1373-17'),	//导出二维码
						style : Permission.getPermission('1373-17'),
						action : function(ids) {
							location.href = '${webRoot}/regulatory/regulatoryObject/exportQrcode.do';
						}
					}, {
						show : deletes,	//删除监管对象
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
					}, {//导入监管对象按钮
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
				};
			}

			datagridUtil.initOption(op);

			/* datagridUtil.query(); */
			datagridUtil.queryByFocus();
		}
		
		//导出方法
	    function exportFile() {
	        var radios = document.getElementsByName('inlineRadioOptions');
	        var ext = '';
	        for (var i = 0; i < radios.length; i++) {
	            if (radios[i].checked) {
	                ext = radios[i].value;
	            }
	        }
	        if (ext!='') {
	        	var regType = $("#getregType").val();
		        var departId=$("input[name='departids']").val();
		        location.href = '${webRoot}/regulatory/regulatoryObject/exportFile.do?types=' + ext + "&departId=" + departId+"&regName="+$("#regNames").val()+"&regType="+regType;
		        $("#exportModal").modal('hide');
			}else {
				$("#exportModal").modal('hide');
				$("#confirm-warnning .tips").text("请选择导出格式!");
				$("#confirm-warnning").modal('toggle');
			}
	    }
		
		//查看经营户
		$(document).on("click", ".businessNumber", function() {
			self.location = '${webRoot}/ledger/business/list.do?regId=' + $(this).parents(".rowTr").attr("data-rowId");
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
			$("#qrcodeModal .qrcodes").html("");
			$.ajax({
				type : "POST",
				url : '${webRoot}' + "/ledger/regulatoryObject/regObjectQrcode.do",
				data : {
					"ids" : ids.toString()
				},
				dataType : "json",
				success : function(data) {
					if (data && data.success) {
						switch ($('.cs-code-box .cs-current').data("size")) {
		        		case "small":
				        	for (var i = 0; i < data.obj.length; i++) {
								$("#qrcodeModal .qrcodes").append("<div class=\"cs-2dcode\"><div class=\"cs-anshan-title\"  style=\"font-size:20px;\">"
						        	+$('#qrcodeTitle').val()+"</div><img src=\"${webRoot}" + data.obj[i].qrcodeSrc
			        				+ "\" alt=\"\" width=\"150px\"><p style=\"font-size:14px;\">"+ data.obj[i].regName + "</p></div>");
							}
		        			break;
		        		case "medium":
		        			for (var i = 0; i < data.obj.length; i++) {
								$("#qrcodeModal .qrcodes").append("<div class=\"cs-2dcode\"><div class=\"cs-anshan-title\"  style=\"font-size:24px;\">"
						        	+$('#qrcodeTitle').val()+"</div><img src=\"${webRoot}" + data.obj[i].qrcodeSrc
			        				+ "\" alt=\"\" width=\"250px\"><p style=\"font-size:18px;\">"+ data.obj[i].regName + "</p></div>");
							}
		        			break;
		        		case "large":
		        			for (var i = 0; i < data.obj.length; i++) {
								$("#qrcodeModal .qrcodes").append("<div class=\"cs-2dcode\"><div class=\"cs-anshan-title\"  style=\"font-size:28px;\">"
						        	+$('#qrcodeTitle').val()+"</div><img src=\"${webRoot}" + data.obj[i].qrcodeSrc
			        				+ "\" alt=\"\" width=\"400px\"><p style=\"font-size:22px;\">"+ data.obj[i].regName + "</p></div>");
							}
		        			break;
		        		}
					}
				}
			});
			$('#qrcodeModal').show();
			$('html').css('overflow','hidden');
		}
		
	  	//修改二维码大小
		$(document).on('click','.cs-code-box li',function(){
			$(this).addClass('cs-current').siblings().removeClass('cs-current');
			switch ($(this).data("size")) {
			case "small":
				$("#qrcodeModal .qrcodes img").attr("width","150px");
				$(".qrcodes p").css('font-size','14px');
				$(".cs-anshan-title").css('font-size','20px')
				break;
			case "medium":
				$("#qrcodeModal .qrcodes img").attr("width","250px");
				$(".qrcodes p").css('font-size','18px')
				$(".cs-anshan-title").css('font-size','24px')
				break;
			case "large":
				$("#qrcodeModal .qrcodes img").attr("width","400px");
				$(".qrcodes p").css('font-size','22px')
				$(".cs-anshan-title").css('font-size','28px')
				break;

			}
		});
	  	
		//修改二维码标题
		$(document).on('click','.cs-tittle-btn',function(){
			$("#qrcodeModal .qrcodes .cs-anshan-title").text($('#qrcodeTitle').val());
		});
		
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
			
			window.document.body.innerHTML = bdhtml;
			window.location.reload();
		}
		//这是页面覆盖
		/* 	function show() {
				var src='${webRoot}'+"/ledger/regulatoryObject/goAddRegulatoryObject.do?regTypeId="+'${regTypeId}';
				alert(src);
				showMbIframe(src);
			} */
		function getType(e) {
			if (e == 1) {
				$("#user").hide();
			} else {
				$("#user").show();
			}
		}
	</script>
	<script type="text/javascript">
	function save() {
		var status=$('input[name="status"]:checked').val();
		if(status==1){
			var username=$("#username").val();
			if(username==null ||username==""){
				$("#confirm-warnning .tips").text("请输入账号!");
				$("#confirm-warnning").modal('toggle');
				return ;
			}
			var pwd=$("#pwd").val();
			if(pwd==null ||pwd==""){
				$("#confirm-warnning .tips").text("请输入密码!");
				$("#confirm-warnning").modal('toggle');
				return ;
			}
		}else if(status==null ||status==""){
			return ;
		}
		$.ajax({
			type : "POST",
			url : '${webRoot}' + "/ledger/regulatoryUser/save.do",
			data : $('#saveform').serialize(),
			dataType : "json",
			success : function(data) {
				if (data.success) {
					$.Showmsg(data.msg);
						if(data.obj!=null){
						$("#ledgerUserId").val(data.obj.id);
						}
				} else {
					$.Showmsg(data.msg);
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
			$("#regId").val("");
			$("#user").hide();
		 })
		 });
	
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
				$("input[name='status'][value="+obj.status+"]").prop('checked', true);
				$("#username").val(obj.username);
				$("#pwd").val(obj.pwd);//食品名称
				$("#ledgerUserId").val(obj.id);
				$("#regId").val(obj.regId);
				if(obj.status==1){
					$("#user").show();
				}
				}
			}
		});
	}
	//根据不同的类型跳转
	function add() {
		var getregType=$("#getregType").val();
		self.location="${webRoot}/ledger/regulatoryObject/goAddRegulatoryObject.do?regTypeId="+getregType;
	}
	//二维码查看返回按钮
	function closeModal(){
		$("#qrcodeModal").hide();
		$('html').css('overflow','auto');
	}
	</script>
	<script type="text/javascript">
	$(document).on('click','.cs-code-box li',function(){
	$(this).addClass('cs-current').siblings().removeClass('cs-current');
	});
	$('.cs-title-hs input').click(function(){
		if($(this).prop('checked')){
			$('.cs-title-ib').show();
		}else{
			$('.cs-title-ib').hide();
	}
	})
	
	
	</script>
</body>
</html>
