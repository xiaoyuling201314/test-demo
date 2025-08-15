<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/common/resource.jsp"%>
<html>
<head>
<title>快检服务云平台</title>
</head>
<body>

	<div class="cs-col-lg clearfix">
		<!-- 面包屑导航栏  开始-->
		<ol class="cs-breadcrumb cs-fl">
			<li class="cs-fl"><img src="${webRoot}/img/set.png" alt="" />
			<li class="cs-fl">台账管理</li>
			<li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
			<li class="cs-fl">经营单位</li>
			<li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
			<li class="cs-fl">经营户</li>
			<li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
			<li class="cs-b-active cs-fl">进货台账</li>
		</ol>

		<!-- 面包屑导航栏  结束-->
		<div class="cs-search-box cs-fr">
			<a class="cs-menu-btn" href="javascript:" onclick="self.history.back();"><i class="icon iconfont icon-fanhui"></i>返回</a>
		</div>
	</div>
	<div class="cs-tb-box">
		<div class="cs-base-detail">
			<div class="cs-content2 clearfix">
				<form id="stockForm" action="${webRoot}/ledger/stock/saveList.do" method="post">
					<input type="hidden" name="details" id="details"> <input type="hidden" name="regName" /> <input type="hidden" name="businessId" />
					<div class="cs-add-new cs-add-pad">
						<ul class="cs-ul-style clearfix">
							<li class="cs-name cs-sm-w"><i class="cs-mred">*</i>所在市场：</li>
							<li class="cs-in-style cs-md-w"><select name="regId" onchange="changeReg(this)" datatype="*" nullmsg="请选择被检单位">
									<option value="">--请选择--</option>
									<c:forEach items="${regObj}" var="reg">
										<option value="${reg.id}" data-name="${reg.regName}" data-user="${reg.linkUser}" data-phone="${reg.linkPhone }">${reg.regName}</option>
									</c:forEach>
							</select></li>
							<li class="cs-name cs-sm-w">所在档口：</li>
							<li class="cs-in-style cs-md-w"><select name="opeId" id="opeId" onchange="changeOpe1(this)"></select>
							</ul>
							
				<ul class="cs-ul-style clearfix">			
				<li class="cs-name cs-sm-w">			  
              供货商：
              	</li>
              	<li class="cs-in-style cs-fl  cs-md-w" >
              	<div class="cs-all-ps">
				                    <div class="cs-input-box">
				                    <input type="text" name="supplier">
				                      <div class="cs-down-arrow"></div>
				                    </div>
				                    <div class="cs-check-down cs-hide" style="display: none;">
				                      <ul id="supplier" class="easyui-tree"></ul>
				                    </div>
			                    </div>
              <!-- <select class="check-date cs-selcet-style" id="tree">
               
              </select>  -->
            </li>
							
							
							<li class="cs-name cs-sm-w">供货商档口编号：</li>
							<li class="cs-in-style cs-md-w"><input type="text" value="" name="opeShopCode" /></li>
							<li class="cs-name cs-sm-w">供货商经营者：</li>
							<li class="cs-in-style cs-md-w"><input type="text" value="" name="supplierUser" /></li>
							<li class="cs-name cs-sm-w">经营者电话：</li>
							<li class="cs-in-style cs-md-w"><input type="text" value="" name="supplierTel" /></li>
						</ul>
					</div>
	</form>
			</div>
		</div>
	</div>
	<!-- 底部导航 结束 -->

	<!-- 台账明细数据表 start-->
	<div class="cs-tabcontent clearfix" style="">
		<div class="cs-content2" style="overflow-x: auto;">
			<table class="cs-table cs-table-hover table-striped cs-tablesorter">
				<thead>
					<tr>
						<!-- 						<th><input type="checkbox" /></th> -->
						<th class="cs-header">序号</th>
						<th class="cs-header" width="100px">食品名称</th>
						<th class="cs-header" width="85px">进货数量</th>
						<th class="cs-header">供货商</th>
						<th class="cs-header" width="90px">生产日期</th>
						<th class="cs-header">保质期</th>
						<th class="cs-header">产地</th>
						<th class="cs-header">批号</th>
						<th class="cs-header" width="90px">进货日期</th>
						<th class="cs-header">操作</th>
					</tr>
				</thead>
				<tbody id="cs-add-unable" class="tableDetail">
				</tbody>
			</table>

		</div>

		<!-- 工具栏 -->
		<div class="cs-tools clearfix">
			<div class="clearfix cs-fl">
				<a href="#addModal" data-toggle="modal" class="cs-menu-btn"><i class="icon iconfont icon-zengjia"></i>新增</a>
			</div>

		</div>
		<!-- 工具栏 -->
	</div>
	<!-- 抽样明细数据表 end-->
	<div class="cs-hd"></div>
	<div class="cs-alert-form-btn">
		<a href="javascript:" class="cs-menu-btn" id="samplingBtnSave"><i class="icon iconfont icon-save"></i>保存</a> <a class="cs-menu-btn" href="javascript:;" onclick="self.history.back();"><i class="icon iconfont icon-fanhui"></i>返回</a>
	</div>

	<!-- 内容主体 结束 -->
	<div class="modal fade intro2" id="addModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
		<div class="modal-dialog cs-lg-width" role="document">
			<div class="modal-content ">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">新增</h4>
				</div>
				<div class="modal-body cs-lg-height">
					<!-- 主题内容 -->
					<div class="cs-tabcontent">
						<!-- cs-main -->
						<div class="cs-content2">
							<!-- cs-wraper -->
							<form id="saveForm" method="post" action="">
								<input type="hidden" name="sampleCode" />
								<div width="100%" class="cs-add-new">
									<ul class="cs-ul-form clearfix">
										<li class="cs-name col-xs-3 col-md-3">食品名称：</li>
										<li class="cs-in-style col-xs-4 col-md-4">
											<div class="cs-all-ps">
												<div class="cs-input-box">
													<input type="hidden" id="foodId" name="foodId" /> <input type="text" name="foodName" id="foodName" autocomplete="off" class="cs-down-input" datatype="*" nullmsg="请选择食品名称" readonly="readonly" />
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
										<li class="col-xs-4 col-md-4">
											<div class="Validform_checktip"></div>
											<div class="info">
												<i class="cs-mred">*</i>请选择食品名称
											</div>
										</li>
									</ul>
									<ul class="cs-ul-form clearfix">
										<li class="cs-name col-xs-3 col-md-3">产地：</li>
										<li class="cs-in-style col-xs-4 col-md-4"><input type="text" value="" name="productionPlace" class="inputxt" /></li>
									</ul>
									<ul class="cs-ul-form clearfix">
										<li class="cs-name col-xs-3 col-md-3">进货数量：</li>
										<li class="cs-in-style col-xs-4 col-md-4"><input type="text" value="" name="stockCount" class="inputxt" /></li>
									</ul>
									<ul class="cs-ul-form clearfix">
										<li class="cs-name col-xs-3 col-md-3">规格：</li>
										<li class="cs-in-style col-xs-4 col-md-4"><input type="text" value="" name="size" class="inputxt" /></li>
									</ul>
									<ul class="cs-ul-form clearfix">
										<li class="cs-name col-xs-3 col-md-3" width="20% ">进货日期：</li>
										<li class="cs-in-style col-xs-4 col-md-4" width="210px"><input class="cs-time" type="text" name="stockDate" class="inputxt" onClick="WdatePicker()" value="<fmt:formatDate value='<%=new Date()%>' pattern='yyyy-MM-dd'/>" /></li>
									</ul>
									<ul class="cs-ul-form clearfix">
										<li class="cs-name col-xs-3 col-md-3">批号：</li>
										<li class="cs-in-style col-xs-4 col-md-4"><input type="text" value="" name="batchNumber" class="inputxt" /></li>
									</ul>
									<ul class="cs-ul-form clearfix">
										<li class="cs-name col-xs-3 col-md-3">保质期：</li>
										<li class="cs-in-style col-xs-4 col-md-4"><input type="text" value="" name="expirationDate" class="inputxt" /></li>
									</ul>
										<ul class="cs-ul-form clearfix">
										<li class="cs-name col-xs-3 col-md-3" width="20% ">生产日期：</li>
										<li class="cs-in-style col-xs-4 col-md-4" width="210px"><input class="cs-time" type="text" name="productionDate" class="inputxt" onClick="WdatePicker()" value="" /></li>
									</ul>
								</div>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-success" id="btnSave">确定</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				</div>
				</form>
			</div>
		</div>
	</div>
	<%@include file="/WEB-INF/view/common/confirm.jsp"%>
	<script type="text/javascript">
		var demo;
		var details = [];
		var row = 0;
		var editRow;//编辑或删除的数据行号
		var detectItemCount = 0;//检测项目数量
		var rootPath = "${webRoot}/ledger/stock/";
		$(function() {
			var getInfoObj = function() {
				return $(this).parents("li").next().find(".info");
			}

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
			$("#stockForm").Validform({
				tiptype : 2,
				beforeSubmit : function() {
					var formData = new FormData($('#stockForm')[0]);
					$.ajax({
						type : "POST",
						url : rootPath + "saveList.do",
						data : formData,
						contentType : false, //必须false才会避开jQuery对 formdata 的默认处理 XMLHttpRequest会对 formdata 进行正确的处理 
						processData : false, //必须false才会自动加上正确的Content-Type
						dataType : "json",
						success : function(data) {
							if (data && data.success) {
								self.location = "${webRoot}/ledger/stock/list.do";
							} else {
								$("#waringMsg>span").html(data.msg);
								$("#confirm-warnning").modal('toggle');
							}
						}
					});
					return false;
				}
			});
			demo = $("#saveForm").Validform({
				tiptype : 2,
				beforeSubmit : function(curform) {
					$.Hidemsg();
					demo.abort();
					addDetail();
					return false;
				}
			});

			// 新增或修改
			$("#btnSave").on("click", function() {
				$(".textbox-prompt").attr({
					"datatype" : "*",
					"nullmsg" : "请选择检测项目"
				});
				demo.submitForm(false);
				return false;
			});
			// 新增或修改
			$("#samplingBtnSave").on("click", function() {
				if (details.length != 0) {
					$("#details").val(JSON.stringify(details));
					$("#stockForm").submit();
				} else {
					$("#waringMsg>span").html("请先增加抽样明细");
					$("#confirm-warnning").modal('toggle');
				}
				return false;
			});
			// 关闭编辑模态框前重置表单，清空隐藏域
			$('#addModal').on('hidden.bs.modal', function(e) {
				var form = $("#saveForm");// 清空表单数据
				form.form("reset");
				$("input[name=parentId]").val("");
				$('#detectName').combobox('loadData', {});

				$("#saveForm").Validform().resetForm();
				$("input").removeClass("Validform_error");
				$(".Validform_wrong").hide();
				$(".Validform_checktip").hide();
				$(".info").show();
			});
			$("#addModal").on('show.bs.modal', function(e) {
				$("#saveForm").Validform().resetForm();
				$("input").removeClass("Validform_error");
				$(".Validform_wrong").hide();
				$(".info").show();
				$("#detectName").empty();
				loadFood();
			});

		});
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
		//选择市场，加载经营户名称
		function changeReg(cko) {
			var opt = $(cko).find("option:selected");
			$("input[name=regName]").val($(opt).text());
			$("input[name=regLinkPerson]").val(opt.attr('data-user'));
			$("input[name=regLinkPhone]").val(opt.attr('data-phone'));
			$("input[name=opeShopCode]").val("");
			$("input[name=opeName]").val("");
			$("input[name=opePhone]").val("");
			var regId = $(cko).val();
			$
					.ajax({
						url : '${webRoot}/regulatory/business/queryByRegId.do?',
						method : 'post',
						data : {
							"regId" : regId
						},
						success : function(data) {
							$("#opeId").empty();
							var html = '<option value="">--请选择--</option>';
							if (data.success) {
								var json = eval(data.obj);
								$
										.each(
												json,
												function(index, item) {
													html += '<option value="'+item.id+'" data-opeShopCode="'+item.opeShopCode+'" data-opeName="'+item.opeName+'" data-opePhone="'+item.opePhone+'">'
															+ item.opeShopName + '</option>';
												});
								$("input[name=regLicence]").val(data.attributes.license.licenseCode)
							}
							$("#opeId").append(html);
							$("#supplier").append(html);
							/* else{
								$("#waringMsg>span").html(data.msg);
								$("#confirm-warnning").modal('toggle');
							} */
						}
					});
		}
		//选择经营户信息
		function changeOpe(cko) {
			var opt = $(cko).find("option:selected");
			$("input[name=opeShopName]").val($(opt).text());
			$("input[name=opeShopCode]").val(opt.attr('data-opeShopCode'));
			$("input[name=opeName]").val(opt.attr('data-opeName'));
			$("input[name=opePhone]").val(opt.attr('data-opePhone'));
			var regId = $(cko).val();
			//加载营业执照信息
			$
					.ajax({
						url : '${webRoot}/regulatory/business/queryByRegId.do?',
						method : 'post',
						data : {
							"regId" : regId
						},
						success : function(data) {
							//$("#opeId").empty();
							var html = "<option value=''></option>";
							$
									.each(
											data,
											function(index, item) {
												var d = data[index];
												html += '<option value="'+d.id+'" data-opeShopCode="'+d.opeShopCode+'" data-opeName="'+d.opeName+'" data-opePhone="'+d.opePhone+'">'
														+ d.opeShopName + '</option>';
											});
							$("#supplier").append(html);
						}
					});
		}
		function changeOpe1(cko) {//这是选择所在档口信息
			var opt = $(cko).find("option:selected");
			$("input[name=businessId]").val(opt.attr('data-id'));
		}
		function addDetail() {
			row++;
			var foodName = $("[name=foodName]").val()
			var stockCount = $("[name=stockCount]").val();
			var stockDate = $("[name=stockDate]").val();//进货日期
			var batchNumber = $("[name=batchNumber]").val();
			var expirationDate = $("[name=expirationDate]").val();//保质期
			var productionDate = $("[name=productionDate]").val();
			var productionPlace = $("[name=productionPlace]").val();
			var size = $("[name=size]").val();
				var detail = {
					foodName : foodName,
					stockCount : stockCount,
					stockDate : stockDate,
					size : size,
					batchNumber:batchNumber,
					expirationDate : expirationDate,
					productionDate : productionDate,
					productionPlace : productionPlace
				};
				details.push(detail);
				var html = "<tr data-row="+row+">";
				html += "<td>" + row + "</td><td>" + foodName + "</td>";
				html += "<td>" + stockCount + "</td><td></td>";
				html += "<td>" + productionDate + "</td><td>" + expirationDate + "</td><td>" + productionPlace + "</td><td>" + batchNumber + "</td><td>" + stockDate + "</td>";
				html += "<td>";//<a class='cs-del cs-del-tr' title='编辑'><i class='icon iconfont icon-xiugai'></i></a> 
				html += "<a class='cs-del cs-del-tr' title='删除' onclick='removeDetail(" + row
						+ ")' ><i class='icon iconfont icon-shanchu text-del'></i></a></td>";
				html += "</tr>";
				$(".tableDetail").append(html);
				$("#addModal").modal("hide");
			}
		function removeDetail(row) {
			$("#confirm-delete").modal('toggle');
			editRow = row;
		}
		function deleteData() {
			for (var i = 0; i < details.length; i++) {
				if (details[i].sampleNO == editRow) {
					details.remove(details[i]);
				}
			}
			var trs = $(".tableDetail").find("tr");
			for (var i = 0; i < trs.length; i++) {
				if ($(trs[i]).attr('data-row') == editRow) {
					$(trs[i]).remove();
				}
			}
			$("#confirm-delete").modal('toggle');
		}
		// 数组删除
		Array.prototype.remove = function(val) {
			var index = this.indexOf(val);
			if (index > -1) {
				this.splice(index, 1);
			}
		};
	</script>
	<script>  
    <!--将select的值赋给input框-->  
    function qlcTrainS(idName) {  
            var arrValue=document.getElementById(idName).options[document.getElementById(idName).selectedIndex].value;  
            $("#"+idName+"").parent('span').next('span').children('input.ccdd').val(arrValue)  
    }  
  
</script> 
</body>
</html>
