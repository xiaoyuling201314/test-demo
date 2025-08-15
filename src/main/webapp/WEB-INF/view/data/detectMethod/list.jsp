<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/common/resource.jsp"%>
<html>
<head>
<title>快检服务云平台</title>
</head>
<body>
	<div class="cs-col-lg clearfix">
		<!-- 面包屑导航栏  开始-->
		<ol class="cs-breadcrumb">
			<li class="cs-fl"><img src="${webRoot}/img/set.png" alt="" /> <a href="javascript:">检测模块</a></li>
			<c:if test="${!empty detectModular }">
			<li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
			<li class="cs-b-active cs-fl">${detectModular }</li>
			</c:if>
			<li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
			<li class="cs-b-active cs-fl">检测方法管理</li>
		</ol>
		<!-- 面包屑导航栏  结束-->
		<div class="cs-search-box cs-fr">
			<form action="">
				<div class="cs-search-filter clearfix cs-fl">
					<a href="#myModal-mid" class="cs-menu-btn" data-toggle="modal" data-target="#myModal-mid3"><i class="icon iconfont icon-zengjia"></i>新增方法</a> <input class="cs-input-cont cs-fl focusInput" type="text" name="detectMethod" placeholder="请输入内容" /> <input type="button" onclick="datagridUtil.queryByFocus()" class="cs-search-btn cs-fl" href="javascript:;" value="搜索">
				</div>
				<div class="clearfix cs-fr" id="showBtn">
					<a href="javascript:" onclick="self.history.back();" class="cs-menu-btn"><i class="icon iconfont icon-fanhui"></i>返回</a>
				</div>
			</form>

		</div>
	</div>

	<div id="dataList"></div>

	<!-- 新增检测方法 -->
	<div class="modal fade intro2" id="myModal-mid3" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
		<div class="modal-dialog cs-lg-width" role="document">
			<div class="modal-content ">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">新增/编辑</h4>
				</div>
				<div class="modal-body cs-lg-height" style="padding: 10px 0;">
					<!-- 主题内容 -->
					<div class="cs-main">
						<div class="cs-wraper">
							<form class="saveform" id="saveform" method="post" action="">
								<div width="100%" class="cs-add-new">
									<input type="hidden" name="detectModularId" id="detectModularId" value="${detectModularId }"> <input type="hidden" name="id" id="uuid" value="">
									<ul class="cs-ul-form clearfix">
										<li class="cs-name col-md-2"><i class="cs-mred">*</i>方法名称：</li>
										<li class="cs-in-style col-md-6"><input name="detectMethod" id="detectMethod" type="text" value="" /></li>
										<li class="col-md-4 cs-text-nowrap"></li>
									</ul>
									<ul class="cs-ul-form clearfix" style="background: #e4f3e3;">
										<li class="cs-name col-md-2"><i class="cs-mred">*</i>标准曲线选择：</li>
										<li class="col-md-10 clearfix"><span class="checkbox-input col-md-4"> <i><input id="wavelength" name="showParameter" value="wavelength" type="checkbox" /></i> <label for="wavelength">选择波长</label>
										</span> <span class="checkbox-input col-md-4"> <i><input id="preTime" name="showParameter" value="preTime" type="checkbox" /></i> <label for="preTime">预热时间</label>
										</span> <span class="checkbox-input col-md-4"> <i><input id="decTime" name="showParameter" value="decTime" type="checkbox" /></i> <label for="decTime">检测时间</label>
										</span> <span class="checkbox-input col-md-4"> <i><input id="stda0" name="showParameter" value="stda0" type="checkbox" /></i> <label for="stda0">标准曲线1A0</label>
										</span> <span class="checkbox-input col-md-4"> <i><input id="stda1" name="showParameter" value="stda1" type="checkbox" /></i> <label for="stda1">标准曲线1A1</label>
										</span> <span class="checkbox-input col-md-4"> <i><input id="stda2" name="showParameter" value="stda2" type="checkbox" /></i> <label for="stda2">标准曲线1A2</label>
										</span> <span class="checkbox-input col-md-4"> <i><input id="stda3" name="showParameter" value="stda3" type="checkbox" /></i> <label for="stda3">标准曲线1A3</label>
										</span> <span class="checkbox-input col-md-4"> <i><input id="stdb0" name="showParameter" value="stdb0" type="checkbox" /></i> <label for="stdb0">标准曲线2B0</label>
										</span> <span class="checkbox-input col-md-4"> <i><input id="stdb1" name="showParameter" value="stdb1" type="checkbox" /></i> <label for="stdb1">标准曲线2B1</label>
										</span> <span class="checkbox-input col-md-4"> <i><input id="stdb2" name="showParameter" value="stdb2" type="checkbox" /></i> <label for="stdb2">标准曲线2B2</label>
										</span> <span class="checkbox-input col-md-4"> <i><input id="stdb3" name="showParameter" value="stdb3" type="checkbox" /></i> <label for="stdb3">标准曲线2B3</label>
										</span> <span class="checkbox-input col-md-4"> <i><input id="stda" name="showParameter" value="stda" type="checkbox" /></i> <label for="stda">矫正曲线A</label>
										</span> <span class="checkbox-input col-md-4"> <i><input id="stdb" name="showParameter" value="stdb" type="checkbox" /></i> <label for="stdb">矫正曲线B</label>
										</span> <span class="checkbox-input col-md-4"> <i><input id="nationalStdmin" name="showParameter" value="nationalStdmin,nationalStdmax" type="checkbox" /></i> <label for="nationalStdmin">国标值下限/上限</label>
										</span> <span class="checkbox-input col-md-4"> <i><input id="invalidValue" name="showParameter" value="invalidValue" type="checkbox" /></i> <label for="invalidValue">检测无效</label>
										</span> <span class="checkbox-input col-md-4"> <i><input id="yinMin" name="showParameter" value="yinMin,yinMax" type="checkbox" /></i> <label for="yinMin">阴性范围</label>
										</span> <span class="checkbox-input col-md-4"> <i><input id="yangMin" name="showParameter" value="yangMin,yangMax" type="checkbox" /></i> <label for="yangMin">阳性范围</label>
										</span> <span class="checkbox-input col-md-4"> <i><input id="yint" name="showParameter" value="yint" type="checkbox" /></i> <label for="yint">阴性T</label>
										</span> <span class="checkbox-input col-md-4"> <i><input id="yangt" name="showParameter" value="yangt" type="checkbox" /></i> <label for="yangt">阳性T</label>
										</span> <span class="checkbox-input col-md-4"> <i><input id="absx" name="showParameter" value="absx" type="checkbox" /></i> <label for="absx">absX</label>
										</span> <span class="checkbox-input col-md-4"> <i><input id="ctabsx" name="showParameter" value="ctabsx" type="checkbox" /></i> <label for="ctabsx">|C-T|>absX</label>
										</span> <span class="checkbox-input col-md-4"> <i><input id="division" name="showParameter" value="division" type="checkbox" /></i> <label for="division">分界值</label>
										</span> <span class="checkbox-input col-md-4"> <i><input id="parameter" name="showParameter" value="parameter" type="checkbox" /></i> <label for="parameter">带入参数</label>
										</span> <span class="checkbox-input col-md-4"> <i><input id="trailingedgec" name="showParameter" value="trailingedgec" type="checkbox" /></i> <label for="trailingedgec">连续下降沿点数C</label>
										</span> <span class="checkbox-input col-md-4"> <i><input id="trailingedget" name="showParameter" value="trailingedget" type="checkbox" /></i> <label for="trailingedget">连续下降沿点数T</label>
										</span> <span class="checkbox-input col-md-4"> <i><input id="suspiciousmin" name="showParameter" value="suspiciousmin,suspiciousmax" type="checkbox" /></i> <label for="suspiciousmin">数据可疑上限/下限</label>
										</span> <span class="checkbox-input col-md-4"> <i><input id="detectUnit" name="showParameter" value="detectUnit" type="checkbox" /></i> <label for="detectUnit">检测值单位</label>
										</span></li>
									</ul>
									<ul class="cs-ul-form clearfix">
										<li class="cs-name col-xs-2 col-md-2" width="20% "><i class="cs-mred">*</i>状态：</li>
										<li class="cs-al cs-modal-input"><input id="cs-check-radio2" type="radio" value="0" name="isCheck"><label for="cs-check-radio2">已审核</label> <input id="cs-check-radio" type="radio" value="1" name="isCheck" checked="checked"><label for="cs-check-radio">未审核</label></li>
									</ul>
								</div>
							</form>
						</div>
					</div>
				</div>
				<div class="modal-footer action">
					<button type="button" class="btn btn-success" id="btnSave">保存</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				</div>
			</div>
		</div>

	</div>
		<%@include file="/WEB-INF/view/common/confirm.jsp"%>
	<!-- JavaScript -->
	<script src="${webRoot}/js/datagridUtil.js"></script>
	<script type="text/javascript">
		var rootPath = "${webRoot}/data/detectMethod/";
		var edit = 0;
		var editObj;
		var del=0;
		var delObj;
		var deleteId;
		var detectModularId = '${detectModularId}';
		//遍历操作权限
		for (var i = 0; i < childBtnMenu.length; i++) {
			if (childBtnMenu[i].operationCode == "1366-1") {
				edit = 1;
				editObj = childBtnMenu[i];
			}
			if (childBtnMenu[i].operationCode == "1366-3") {
	    		del = 1;
	    		delObj=childBtnMenu[i];
			}
		}
		var op = {
			tableId : "dataList", //列表ID
			tableAction : '${webRoot}' + "/data/detectMethod/datagrid.do", //加载数据地址
			parameter : [ //列表拼接参数
			{
				columnCode : "detectMethod",
				columnName : "检测方法",
				query : 1
			}, {
				columnCode : "isCheck",
				columnName : "状态",
				customVal : {
					"0" : "已审核",
					"1" : "<span style='color:#E53333;'>未审核</span>",
					"default" : "<span style='color:#E53333;'>未审核</span>"
				},
				query : 1
			}, {
				columnCode : "createDate",
				columnName : "创建时间",
				query : 1,
				dateFormat : "yyyy-MM-dd",
				queryType : 3
			} ],
			funBtns : [ {
				show : edit,
				style : editObj,
				action : function(id) {
					getMethod(id);
					//self.location = '${webRoot}'+"/dataCheck/unqualified/goHandle.do?id="+id;
					$("#myModal-mid3").modal();
				}
			} ,
			{
				show : del,
				style : delObj,
				action : function(id) {
                    deleteId = id;
                    $("#confirm-delete").modal('toggle');
				}
			}
			], //功能按钮
			defaultCondition : [ //加载条件
			{
				queryCode : "detectModularId",
				queryVal : detectModularId
			} ]
		};
		datagridUtil.initOption(op);
		datagridUtil.query();
	</script>
	<script type="text/javascript">
        $(function(){
            //清空模态框输入框
            $('#myModal-mid3').on('hidden.bs.modal', function() {
                $("#saveform").form("clear");
                $("#uuid").val("");
                $("#detectModularId").val('${detectModularId}');
            });
            $('#myModal-mid3').on('show.bs.modal', function() {
                $("#cs-check-radio").prop("checked", true);
                $("#btnSave").removeAttr("disabled");
            });

            $("#btnSave").click(function(){
                var detectMethod = $("#detectMethod").val();
                if (detectMethod == null || detectMethod == "") {
                    $("#confirm-warnning .tips").text("检测方法名不能为空！");
                    $("#confirm-warnning").modal('toggle');
                    return;
                }

                var showParameter = $('input[type=checkbox]:checked').length;
                if (showParameter ==0) {
                    $("#confirm-warnning .tips").text("检测方法不能为空！");
                    $("#confirm-warnning").modal('toggle');
                    return;
                }

                if (detectModularId == null || detectModularId == "") {
                    $("#confirm-warnning .tips").text("获取检测模块失败,请返回重试！");
                    $("#confirm-warnning").modal('toggle');
                    return;
                } else {
                    $("#detectModularId").val(detectModularId);
                }
                $("#btnSave").attr("disabled","disabled");
                $.ajax({
                    type : "POST",
                    url : '${webRoot}' + "/data/detectMethod/save.do",
                    data : $('#saveform').serialize(),
                    dataType : "json",
                    success : function(data) {
                        if (data.success) {
                            $("#myModal-mid3").modal();
                            $("#confirm-warnning .tips").text(data.msg);
                            $("#confirm-warnning").modal('toggle');
                            self.location.reload();
                        } else {
                            $("#confirm-warnning .tips").text(data.msg);
                            $("#confirm-warnning").modal('toggle');
                            $("#btnSave").removeAttr("disabled");
                        }
                    }
                })
            });
        });

		function getMethod(id) {
			$.ajax({
				type : "POST",
				url : '${webRoot}' + "/data/detectMethod/queryById.do",
				data : {id : id},
				dataType : "json",
				success : function(data) {
					console.log(data);
					var obj = data.obj;
					if (obj) {
						$("#uuid").val(obj.id);
						$("#detectMethod").val(obj.detectMethod);
						if (obj.isCheck == 0) {
							$("#cs-check-radio2").prop("checked", true);
							$("#cs-check-radio").prop("checked", false);
						} else if (obj.isCheck == 1) {
							$("#cs-check-radio2").prop("checked", false);
							$("#cs-check-radio").prop("checked", true);
						}
						if (obj.showParameter) {//获取权限
							var myList = obj.showParameter.split(",");
							for (var i = 0; i < myList.length; i++) {
								var t = myList[i];
								$('#' + t).prop("checked", true);
								//$("#yin_max").prop("checked",true);
							}
						}
					}
				}
			})
		}

		  //删除函数
	    function deleteData(){
	    	$.ajax({
		        type: "POST",
		        url: '${webRoot}'+"/data/detectMethod/delete.do",
		        data: {"id":deleteId},
		        success: function(data){
		        	if(data && data.success){
		        		datagridUtil.query();
		        	}
				}
		    });
				$("#confirm-delete").modal('toggle');
			}
	</script>
</body>
</html>
