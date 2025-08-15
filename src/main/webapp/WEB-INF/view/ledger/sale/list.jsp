<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/common/resource.jsp"%>
<%@page import="java.util.Date"%>
<html>
<head>
<title>快检服务云平台</title>
</head>
<body>
	<!-- 面包屑导航栏  开始-->
	<div class="cs-col-lg clearfix">
		<ol class="cs-breadcrumb">
			<li class="cs-fl"><img src="${webRoot}/img/set.png" alt="" /> <a href="javascript:">台账管理</a></li>
			<li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
			<li class="cs-b-active cs-fl">销售台账</li>
		</ol>
		<!-- 面包屑导航栏  结束-->
		<div class="cs-search-box cs-fr">
			<form>
				<input class="cs-input-cont cs-fl focusInput" type="text" name="foodName" placeholder="请输入食品名称" /> <input type="button" onclick="datagridUtil.queryByFocus();" class="cs-search-btn cs-fl" href="javascript:;" value="搜索">
				<!-- <div class="cs-search-filter clearfix cs-fl">
                <span class="cs-s-search cs-fl">高级搜索</span>
                </div> -->
				<div class="clearfix cs-fr" id="showBtn"></div>
				<a href="javascript:" onclick="self.history.back();" class="cs-menu-btn"><i class="icon iconfont icon-fanhui"></i>返回</a>
			</form>
		</div>
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
				<div class="modal-body cs-lg-height cs-dis-tab cs-2dcode-box"></div>
				<!--endprint-->
				<div class="modal-footer">
					<button type="button" class="btn btn-success" onclick="preview();">打印</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				</div>
			</div>
		</div>
	</div>
	<!-- 销售台账-->
	<div class="modal fade intro2" id="myModal-md" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
		<div class="modal-dialog cs-md-width" role="document">
			<div class="modal-content ">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">新增销售台账</h4>
				</div>
				<div class="modal-body cs-md-height">
					<!-- 主题内容 -->
					<div class="cs-tabcontent">
						<div class="cs-content2">
							<form id="saveForm" enctype="multipart/form-data">
								<input type="hidden" name="id" id="id"> <input type="hidden" name="businessId" id="businessId" value="${businessId }"> <input type="hidden" name="regId" id="regId" value="${regId }">
								<div width="100%" class="cs-add-new">
								<ul class="cs-ul-form clearfix">
										<li class="cs-name col-xs-3 col-md-3" width="20% ">商品名称：</li>
										<li class="cs-in-style col-xs-4 col-md-4">
											<div class="cs-all-ps">
												<div class="cs-input-box">
													<input type="hidden" id="foodId" name="foodId" /> <input type="text" name="foodName" id="foodName" autocomplete="off" class="cs-down-input" datatype="*" nullmsg="请选择食品名称" />
													<div class="cs-down-arrow"></div>
												</div>
												<div id="divBtn" class="cs-check-down  cs-hide" style="display: none;">

													<!-- 树状图 -->
													<ul id="tt" class="easyui-tree">
													</ul>
													<!-- 树状图 -->

												</div>
											</div>
										</li>
										<li class="col-xs-4 col-md-4 cs-text-nowrap">
											<div class="Validform_checktip"></div>
											<div class="info">
												<i class="cs-mred">*</i>请输入商品名称
											</div>
										</li>
									</ul>
									<ul class="cs-ul-form clearfix">
										<li class="cs-name col-xs-3 col-md-3" width="20% ">销售日期：</li>
										<li class="cs-in-style cs-modal-input" width="210px"><input class="cs-time" type="text" id="saleDate" name="saleDate" class="inputxt" onClick="WdatePicker({startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true})"
										value="<fmt:formatDate value='<%=new Date()%>' pattern='yyyy-MM-dd'/>" />
										<li class="col-xs-4 col-md-4 cs-text-nowrap">
											<div class="Validform_checktip"></div>
											<div class="info">
												<i class="cs-mred">*</i>请选择销售时间
											</div>
										</li>
									</ul>
										<ul class="cs-ul-form clearfix">
										<li class="cs-name col-xs-3 col-md-3" width="20% ">销售数量：</li>
										<li class="cs-in-style cs-modal-input" width="210px"><input type="text" name="saleCount" id="saleCount" class="inputxt" datatype="*" nullmsg="请输入销售数量"></li>
										<li class="col-xs-4 col-md-4 cs-text-nowrap">
											<div class="Validform_checktip"></div>
											<div class="info">
												<i class="cs-mred">*</i>请输入销售数量
											</div>
										</li>
									</ul>
									<ul class="cs-ul-form clearfix">
										<li class="cs-name col-xs-3 col-md-3" width="20% ">规格：</li>
										<li class="cs-in-style cs-modal-input" width="210px"><input type="text" name="size" value="KG" id="size" class="inputxt" datatype="*"></li>
									</ul>
									<ul class="cs-ul-form clearfix">
										<li class="cs-name col-xs-3 col-md-3" width="20% ">销售对象：</li>
										<li class="cs-in-style cs-modal-input" width="210px"><input type="text" name="customer" id="customer" class="inputxt" nullmsg="请输入销售对象"></li>
										<li class="col-xs-4 col-md-4 cs-text-nowrap">
											<div class="Validform_checktip"></div>

										</li>
									</ul>
											<ul class="cs-ul-form clearfix">
										<li class="cs-name col-xs-3 col-md-3" width="20% ">销售对象市场：</li>
										<li class="cs-in-style cs-modal-input" width="210px"><input type="text" name="cusRegName" id="cusRegName" class="inputxt" nullmsg="请输入销售对象"></li>
										<li class="col-xs-4 col-md-4 cs-text-nowrap">
											<div class="Validform_checktip"></div>
										</li>
									</ul>
											<ul class="cs-ul-form clearfix">
										<li class="cs-name col-xs-3 col-md-3" width="20% ">销售对象联系电话：</li>
										<li class="cs-in-style cs-modal-input" width="210px"><input type="text" name="cusPhone" id="cusPhone" class="inputxt" nullmsg="请输入销售对象"></li>
										<li class="col-xs-4 col-md-4 cs-text-nowrap">
											<div class="Validform_checktip"></div>
										</li>
									</ul>
										
									<ul class="cs-ul-form clearfix">
										<li class="cs-name col-xs-3 col-md-3" width="20% ">备注：</li>
										<li class="cs-in-style cs-modal-input" width="210px"><textarea name="memo" id="memo" cols="30" rows="10" style="height: 80px;"></textarea></li>
										<li class="col-xs-4 col-md-4 cs-text-nowrap">
											<div class="Validform_checktip"></div>

										</li>
									</ul>

								</div>
							</form>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-success" onclick="saveSale();">确定</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				</div>
			</div>
		</div>
	</div>

	<%@include file="/WEB-INF/view/common/confirm.jsp"%>

	<!-- JavaScript -->
	<script src="${webRoot}/js/datagridUtil.js"></script>
	<script src="${webRoot}/js/dateUtil.js"></script>
	<script type="text/javascript">
		var businessId = '${businessId}';
		var regId = '${regId}';
		for (var i = 0; i < childBtnMenu.length; i++) {
			if (childBtnMenu[i].operationCode == "1396-1" ) {
				//新增
				var html = '<a href="#myModal-mid" class="cs-menu-btn" data-toggle="modal" data-target="#myModal-md"><i class="icon iconfont icon-zengjia"></i>新增</a>';
				$("#showBtn").append(html);
			} else if (childBtnMenu[i].operationCode == "1396-2") {
				//编辑
				edit = 1;
				editObj = childBtnMenu[i];
			} else if (childBtnMenu[i].operationCode == "1396-3" ) {
				//删除
				deletes = 1;
				deleteObj = childBtnMenu[i];
			} 
		}
		$('#tree').tree({
			checkbox : false,
			url : "${webRoot}/detect/depart/getDepartTree.do",
			animate : true,
			onClick : function(node) {
				var did = node.id;
				$("input[name='departNames']").val(node.text);
				$(".cs-check-down").hide();

				bigbang(did);
			}
		});

		var op = "";
		//经营单位
		var foodName = $("#foodName").val();
		op = {
			tableId : "dataList", //列表ID
			tableAction : '${webRoot}' + "/ledger/sale/datagrid.do", //加载数据地址
			parameter : [ //列表拼接参数
			{
				columnCode : "foodName",
				columnName : "食品名称"
			}, {
				columnCode : "customer",
				columnName : "销售对象",
			}, {
				columnCode : "saleCount",
				columnName : "销售数量",
			}, {
				columnCode : "size",
				columnName : "规格",
				query : 1
			}, {
				columnCode : "saleDate",
				columnName : "销售日期",
				queryType:1
			} ],
			defaultCondition : [ //默认查询条件
			{
				queryCode : "businessId",
				queryVal: '${businessId}'
			} ],
			funBtns : [ {
				show : edit,
				style : editObj,
				action : function(id) {
					//queryById(id);
					self.location = '${webRoot}/ledger/sale/edit.do?id='+id;
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
			bottomBtns : [  {
				show : deletes,
				style : deleteObj,
				action : function(ids) {
					if (ids == '') {
						$("#confirm-warnning .tips").text("请选择销售台账");
						$("#confirm-warnning").modal('toggle');
					} else {
						deleteIds = ids;
						$("#confirm-delete").modal('toggle');
					}
				}
			} ], //底部按钮
		};
		datagridUtil.initOption(op);
		//datagridUtil.query();
		datagridUtil.queryByFocus();
		loadFood();
		//查看经营户
		$(document).on("click", ".businessNumber", function() {
			self.location = '${webRoot}/ledger/business/list.do?regId=' + $(this).parents(".rowTr").attr("data-rowId");
		});

		function saveSale() {
			var foodName = $("#foodName").val();
			if (foodName == null || foodName == "") {
				//alert("检测模块名不能为空！");
				$.Showmsg("商品名不能为空！");
				return;
			}
			$.ajax({
				type : "POST",
				url : '${webRoot}' + "/ledger/sale/save.do",
				data : $('#saveForm').serialize(),
				dataType : "json",
				success : function(data) {
					if (data.success) {
						$("#myModal-md").modal();
						$.Showmsg(data.msg);
						self.location.reload();
					} else {
						$.Showmsg(data.msg);
					}
				}
			})
		}

		//删除
		var deleteIds = "";
		function deleteData() {
			$.ajax({
				type : "POST",
				url : '${webRoot}' + "/ledger/sale/delete.do",
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

		function queryById(id) {
			$.ajax({
				type : "POST",
				url : '${webRoot}' + "/ledger/sale/queryById.do?id=" + id,
				dataType : "json",
				success : function(data) {
					var obj = data.obj;
					$("#id").val(obj.id);
					$("#foodName").val(obj.foodName);//食品名称
					$("#size").val(obj.size);//规格
					$("#customer").val(obj.customer);//销售对象
					$("#saleCount").val(obj.saleCount);
					$("#memo").val(obj.memo);
					$("#cusPhone").val(obj.cusPhone);
					$("#cusRegName").val(obj.cusRegName);
					var  now = new Date(); 
					$("#saleDate").val( now.format("yyyy-MM-dd"));//时间有问题
					
				}
			});
			$("#myModal-md").modal('toggle');
		}

		$(document).on("click", ".qrcode", function() {
			viewQrcode($(this).attr("data-value"));
		});
		//模态框关闭清空
		$('#myModal-md').on('hidden.bs.modal', function() {
			$("#id").val("");
			$("#foodName").val("");//食品名称
			$("#size").val("");//规格
			$("#customer").val("");//销售对象
			$("#saleCount").val("");
			$("#memo").val("");
			$("#saleDate").val("");
			$("#cusPhone").val("");
			$("#cusRegName").val("");
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

		function loadFood() {
			//加载样品信息,选择样品后关联相关检测项目
			$("#tt").tree({
				checkbox : false,
				url : '${webRoot}' + "/data/foodType/queryFoodTree.do",
				animate : true,
				lines : false,
				onClick : function(node) {
					//     			if(node.attributes.isFood!=0){//选择具体样品
					$("#foodId").val(node.id);
					$("#foodName").val(node.text);
					$(".cs-check-down").hide();
					$("#detectName").combobox({
						url : '${webRoot}/data/detectItem/queryByFoodId.do?foodId=' + node.id,
						valueField : 'id',
						textField : 'detectItemName',
						multiple : true,//允许在下拉列表里多选
						onSelect : function(record) {
							//选择检测项目后关闭下拉选项框
							/* if ($(".combo").prev().combobox("panel").is(":visible")) {
								$(".combo").prev().combobox("hidePanel");
							 } else {
							 $(".combo").prev().combobox("showPanel");
							 }	 */
						},
						onLoadSuccess : function() {
							//在数据加载成功后绑定事件
							$(".combo").click(function(event) {
								if (event.target.tagName == "A") {//判断是否为点击右侧倒三角形
									/* return false; */
								}
								//点击输入框框显示下拉列表
								if ($(this).prev().combobox("panel").is(":visible") && event.target.tagName != "INPUT") {
									$(this).prev().combobox("hidePanel");
								} else {
									$(this).prev().combobox("showPanel");
								}
							});
						}
					});
					//     			}else{
					//     				$("#foodId").val("");
					//         			$("#foodName").val("");
					//     			}
				}
			});
		}
	</script>
</body>
</html>
