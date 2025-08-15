<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/common/resource.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="${webRoot}/js/list.js"></script>
<style type="text/css">
	.symBol{
		border-radius: 4px;
		border: 1px solid #ddd;
		background: #fafafa;
		height: 32px;
		padding: 7px;
	}
</style>
</head>
<body>

	<div class="cs-col-lg clearfix">
		<!-- 面包屑导航栏  开始-->
		<ol class="cs-breadcrumb cs-fl">
			<li class="cs-fl"><img src="${webRoot}/img/set.png" alt="" />
			<li class="cs-fl">基础数据</li>
			<li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
			<li class="cs-fl">仪器类别维护</li>
			<li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
			<li class="cs-b-active cs-fl">${deviceType.deviceName}</li>
		</ol>

		<!-- 面包屑导航栏  结束-->
	</div>
	<div class="cs-tb-box">
		<div class="cs-base-detail">
			<div class="cs-content2 clearfix">
				<form class="registerform" id="saveForm" method="post" action="${webRoot}/data/deviceSeries/detectParameter/save.do">
					<input type="hidden" name="id" value="${data.obj.id}"/>
					<input type="hidden" name="deviceTypeId" value="${deviceType.id}" />
			        <input type="hidden" class="dItemId" name="itemId" value="${data.obj.itemId}"/>
			        <input type="hidden" name="projectType" value="${data.obj.projectType}"/>
			        <input type="hidden"  name="detectMethod" value="${data.obj.detectMethod}"/>
					<div class="cs-add-new cs-options cs-in-style clearfix ">
						<ul class="cs-ul-style clearfix">
							<li class="cs-name cs-sm-w"><i class="cs-mred">*</i>检测项目：</li>
							<li class="cs-md-w"><input type="text" value="${data.obj.itemName}" class="inputxt dItem" datatype="*" nullmsg="请选择检测项目" errormsg="请选择检测项目"/></li>

							<li class="cs-name cs-sm-w"><i class="cs-mred">*</i>检测模块：</li>
							<li class="cs-in-style cs-md-w">
								<select id="detect_modular" onchange="choseModular(this)" datatype="*" nullmsg="请选择检测模块" errormsg="请选择检测模块">
								</select>
							</li>
							<li class="cs-name cs-sm-w"><i class="cs-mred">*</i>检测方法：</li>
							<li class="cs-in-style cs-md-w">
								<select id="detect_method" onchange="choseMethod(this)" datatype="*" nullmsg="请选择检测方法" errormsg="请选择检测方法">
								</select>
							</li>
						</ul>
					</div>
					<div class="cs-add-new cs-add-pad">
						<ul class="cs-ul-style clearfix" id="controllerList">
							<%-- <li class="cs-name cs-sm-w"><i class="cs-mred">*</i>仪器操作密码：</li>
							<li class="cs-in-style cs-md-w"><input type="password" name="operationPassword" datatype="*" value="${data.obj.operationPassword}"/></li>
							<li class="cs-name cs-sm-w"><i class="cs-mred">*</i>样品编号：</li>
							<li class="cs-in-style cs-md-w"><input type="text" name="foodCode" value="${data.obj.foodCode}"/></li> --%>
							
							<li class="cs-name cs-sm-w wavelength choseShow"><i class="cs-mred">*</i>选择波长：</li>
							<li class="cs-in-style cs-md-w wavelength choseShow">
								<select name="wavelength"  datatype="*" nullmsg="请选择波长" errormsg="请选择波长">
								    <option value="410">410</option>
						            <option value="536">536</option>
						            <option value="595">595</option>
						            <option value="620">620</option>
								</select>
							</li>
							<li class="cs-name cs-sm-w preTime choseShow"><i class="cs-mred">*</i>预热时间(S)：</li>
							<li class="cs-in-style cs-md-w preTime choseShow">
								<input type="text" name="preTime" class="inputxt"  value="${data.obj.preTime}" onkeyup="clearNoNum2(this)" onblur="clearNoNum2(this)"
									   datatype="*" nullmsg="请输入预热时间" errormsg="请输入预热时间"/>
							</li>
							<li class="cs-name cs-sm-w decTime choseShow"><i class="cs-mred">*</i>检测时间(S)：</li>
							<li class="cs-in-style cs-md-w decTime choseShow">
								<input type="text" name="decTime" class="inputxt" value="${data.obj.decTime}" onkeyup="clearNoNum2(this)" onblur="clearNoNum2(this)"
									   datatype="*" nullmsg="请输入检测时间" errormsg="请输入检测时间"/>
							</li>

							<li class="cs-name cs-sm-w stda0 choseShow"><i class="cs-mred">*</i>标准曲线1A0：</li>
							<li class="cs-in-style cs-md-w stda0 choseShow">
								<input type="text" name="stda0" value="${data.obj.stda0}" datatype="*" nullmsg="请输入标准曲线1A0" errormsg="请输入标准曲线1A0"/>
							</li>
							<li class="cs-name cs-sm-w stda1 choseShow"><i class="cs-mred">*</i>标准曲线1A1：</li>
							<li class="cs-in-style cs-md-w stda1 choseShow">
								<input type="text" name="stda1" value="${data.obj.stda1}" datatype="*" nullmsg="请输入标准曲线1A1" errormsg="请输入标准曲线1A1"/>
							</li>
							<li class="cs-name cs-sm-w stda2 choseShow"><i class="cs-mred">*</i>标准曲线1A2：</li>
							<li class="cs-in-style cs-md-w stda2 choseShow">
								<input type="text" name="stda2" value="${data.obj.stda2}" datatype="*" nullmsg="请输入标准曲线1A2" errormsg="请输入标准曲线1A2"/>
							</li>

							<li class="cs-name cs-sm-w stda3 choseShow"><i class="cs-mred">*</i>标准曲线1A3：</li>
							<li class="cs-in-style cs-md-w stda3 choseShow">
								<input type="text" name="stda3" value="${data.obj.stda3}" datatype="*" nullmsg="请输入标准曲线1A3" errormsg="请输入标准曲线1A3"/>
							</li>
							<li class="cs-name cs-sm-w stdb0 choseShow"><i class="cs-mred">*</i>标准曲线2B0：</li>
							<li class="cs-in-style cs-md-w stdb0 choseShow">
								<input type="text" name="stdb0" value="${data.obj.stdb0}" datatype="*" nullmsg="请输入标准曲线2B0" errormsg="请输入标准曲线2B0"/>
							</li>
							<li class="cs-name cs-sm-w stdb1 choseShow"><i class="cs-mred">*</i>标准曲线2B1：</li>
							<li class="cs-in-style cs-md-w stdb1 choseShow">
								<input type="text" name="stdb1" value="${data.obj.stdb1}" datatype="*" nullmsg="请输入标准曲线2B1" errormsg="请输入标准曲线2B1"/>
							</li>

							<li class="cs-name cs-sm-w stdb2 choseShow"><i class="cs-mred">*</i>标准曲线2B2：</li>
							<li class="cs-in-style cs-md-w stdb2 choseShow">
								<input type="text" name="stdb2" value="${data.obj.stdb2}" datatype="*" nullmsg="请输入标准曲线2B2" errormsg="请输入标准曲线2B2"/>
							</li>
							<li class="cs-name cs-sm-w stdb3 choseShow"><i class="cs-mred">*</i>标准曲线2B3：</li>
							<li class="cs-in-style cs-md-w stdb3 choseShow">
								<input type="text" name="stdb3" value="${data.obj.stdb3}" datatype="*" nullmsg="请输入标准曲线2B3" errormsg="请输入标准曲线2B3"/>
							</li>
							<li class="cs-name cs-sm-w stda choseShow"><i class="cs-mred">*</i>矫正曲线A：</li>
							<li class="cs-in-style cs-md-w stda choseShow">
								<input type="text" name="stda" value="${data.obj.stda}" datatype="*" nullmsg="请输入矫正曲线A" errormsg="请输入矫正曲线A"/>
							</li>

							<li class="cs-name cs-sm-w choseShow stdb"><i class="cs-mred">*</i>矫正曲线B：</li>
							<li class="cs-in-style cs-md-w choseShow stdb">
								<input type="text"name="stdb" value="${data.obj.stdb}" datatype="*" nullmsg="请输入矫正曲线B" errormsg="请输入矫正曲线B"/>
							</li>
							<li class="cs-name cs-sm-w choseShow nationalStdmin"><i class="cs-mred">*</i>国标值下限：</li>
							<li class="cs-in-style cs-md-w choseShow nationalStdmin">
								<input type="text" value="${data.obj.nationalStdmin}" name="nationalStdmin" datatype="*" nullmsg="请输入国标值下限" errormsg="请输入国标值下限"/>
							</li>
							<li class="cs-name cs-sm-w choseShow nationalStdmax"><i class="cs-mred">*</i>国标值上限：</li>
							<li class="cs-in-style cs-md-w choseShow nationalStdmax">
								<input type="text" value="${data.obj.nationalStdmax}" name="nationalStdmax" datatype="*" nullmsg="请输入国标值上限" errormsg="请输入国标值上限"/>
							</li>

							<!-- 新增列 start -->
							<li class="cs-name cs-sm-w choseShow invalidValue"><i class="cs-mred">*</i>检测无效值：</li>
							<li class="cs-in-style cs-md-w choseShow invalidValue">
         						 <span class="symBol">C ≤</span>
								 <input type="text" value="${data.obj.invalidValue}" name="invalidValue" style="width: 155px;"
										datatype="*" nullmsg="请输入检测无效值" errormsg="请输入检测无效值"/>
							</li>
							<li class="cs-name cs-sm-w choseShow yinMin"><i class="cs-mred">*</i>阴性范围下限：</li>
							<li class="cs-in-style cs-md-w choseShow yinMin">
								<input type="text" value="${data.obj.yinMin}" name="yinMin" datatype="*" nullmsg="请输入阴性范围下限" errormsg="请输入阴性范围下限"/>
							</li>
							<li class="cs-name cs-sm-w choseShow yinMax"><i class="cs-mred">*</i>阴性范围上限：</li>
							<li class="cs-in-style cs-md-w choseShow yinMax">
								<input type="text" value="${data.obj.yinMax}" name="yinMax" datatype="*" nullmsg="请输入阴性范围上限" errormsg="请输入阴性范围上限"/>
							</li>
							
							<li class="cs-name cs-sm-w choseShow yangMin"><i class="cs-mred">*</i>阳性范围下限：</li>
							<li class="cs-in-style cs-md-w choseShow yangMin">
								<input type="text" value="${data.obj.yangMin}" name="yangMin" datatype="*" nullmsg="请输入阳性范围下限" errormsg="请输入阳性范围下限"/>
							</li>
							<li class="cs-name cs-sm-w choseShow yangMax"><i class="cs-mred">*</i>阳性范围上限：</li>
							<li class="cs-in-style cs-md-w choseShow yangMax">
								<input type="text" value="${data.obj.yangMax}" name="yangMax" datatype="*" nullmsg="请输入阳性范围上限" errormsg="请输入阳性范围上限"/>
							</li>
							<li class="cs-name cs-sm-w choseShow yint"><i class="cs-mred">*</i>阴性T：</li>
							<li class="cs-in-style cs-md-w choseShow yint">
         						 <span class="symBol">T&gt; </span>
								 <input type="text" value="${data.obj.yint}" name="yint" style="width: 155px;"
										datatype="*" nullmsg="请输入阴性T" errormsg="请输入阴性T"/>
							</li>
							
							<li class="cs-name cs-sm-w choseShow yangt"><i class="cs-mred">*</i>阳性T：</li>
							<li class="cs-in-style cs-md-w choseShow yangt">
         						 <span class="symBol">T≤ </span>
								<input type="text" value="${data.obj.yangt}" name="yangt" style="width: 155px;"
									   datatype="*" nullmsg="请输入阳性T" errormsg="请输入阳性T"/>
							</li>
							<li class="cs-name cs-sm-w choseShow absx"><i class="cs-mred">*</i>absX：</li>
							<li class="cs-in-style cs-md-w choseShow absx">
								<input type="text" value="${data.obj.absx}" name="absx" datatype="*" nullmsg="请输入absX" errormsg="请输入absX"/>
							</li>
							<li class="cs-name cs-sm-w choseShow ctabsx"><i class="cs-mred">*</i>|C-T|>absX：</li>
							<li class="cs-in-style cs-md-w choseShow ctabsx">
								<select name="ctabsx" datatype="*" nullmsg="请选择|C-T|>absX" errormsg="请选择|C-T|>absX">
					              <option value="1">阳性</option>
					              <option value="0">阴性</option>
					            </select>
							</li>
							
							<li class="cs-name cs-sm-w choseShow division"><i class="cs-mred">*</i>分界值：</li>
							<li class="cs-in-style cs-md-w choseShow division">
								<input type="text" value="${data.obj.division}" name="division" datatype="*" nullmsg="请输入分界值" errormsg="请输入分界值"/>
							</li>
							<li class="cs-name cs-sm-w choseShow parameter"><i class="cs-mred">*</i>带入参数：</li>
							<li class="cs-in-style cs-md-w choseShow parameter">
								<select name="parameter" datatype="*" nullmsg="请选择带入参数" errormsg="请选择带入参数">
					              <option value="0">A</option>
					              <option value="1">B</option>
					              <option value="2">C</option>
					              <option value="3">D</option>
					            </select>
							</li>
							<li class="cs-name cs-sm-w choseShow trailingedgec"><i class="cs-mred">*</i>连续下降沿点数C：</li>
							<li class="cs-in-style cs-md-w choseShow trailingedgec">
								<input type="text" value="${data.obj.trailingedgec}" name="trailingedgec"
									   datatype="*" nullmsg="请输入连续下降沿点数C" errormsg="请输入连续下降沿点数C"/>
							</li>
							
							<li class="cs-name cs-sm-w choseShow trailingedget"><i class="cs-mred">*</i>连续下降沿点数T：</li>
							<li class="cs-in-style cs-md-w choseShow trailingedget">
								<input type="text" value="${data.obj.trailingedget}" name="trailingedget"
									   datatype="*" nullmsg="请输入连续下降沿点数T" errormsg="请输入连续下降沿点数T"/>
							</li>
							<li class="cs-name cs-sm-w choseShow suspiciousmin"><i class="cs-mred">*</i>数据可疑下限：</li>
							<li class="cs-in-style cs-md-w choseShow suspiciousmin">
								<input type="text" value="${data.obj.suspiciousmin}" name="suspiciousmin"
									   datatype="*" nullmsg="请输入数据可疑下限" errormsg="请输入数据可疑下限"/>
							</li>
							<li class="cs-name cs-sm-w choseShow suspiciousmax"><i class="cs-mred">*</i>数据可疑上限：</li>
							<li class="cs-in-style cs-md-w choseShow suspiciousmax">
								<input type="text" value="${data.obj.suspiciousmax}" name="suspiciousmax"
									   datatype="*" nullmsg="请输入数据可疑上限" errormsg="请输入数据可疑上限"/>
							</li>
							<li class="cs-name cs-sm-w choseShow detectUnit"><i class="cs-mred">*</i>检测值单位：</li>
							<li class="cs-in-style cs-md-w choseShow detectUnit">
								<input type="text" name="detectUnit" value="${data.obj.detectUnit}" datatype="*" nullmsg="请输入检测值单位" errormsg="请输入检测值单位"/>
							</li>
							<!-- 新增列end -->
							<li class="cs-name cs-sm-w">预留字段1：</li>
							<li class="cs-in-style cs-md-w"><input type="text" value="${data.obj.reserved1}" name="reserved1"/></li>
							<li class="cs-name cs-sm-w">预留字段2：</li>
							<li class="cs-in-style cs-md-w"><input type="text" value="${data.obj.reserved2}" name="reserved2"/></li>
							<li class="cs-name cs-sm-w">预留字段3：</li>
							<li class="cs-in-style cs-md-w"><input type="text" value="${data.obj.reserved3}" name="reserved3"/></li>
							
							<li class="cs-name cs-sm-w">预留字段4：</li>
							<li class="cs-in-style cs-md-w"><input type="text" value="${data.obj.reserved4}" name="reserved4"/></li>
							<li class="cs-name cs-sm-w">预留字段5：</li>
							<li class="cs-in-style cs-md-w"><input type="text" value="${data.obj.reserved5}" name="reserved5"/></li>
							<li class="cs-name cs-sm-w">操作备注：</li>
							<li class="cs-in-style cs-md-w"><input type="text" value="${data.obj.remark}" name="remark"/></li>
						</ul>
					</div>

				</form>
			</div>

		</div>
	</div>
	<!-- 底部导航 结束 -->
	<div class="cs-hd"></div>
	<div class="cs-alert-form-btn">
		<a href="javascript:" id="btnSave" class="cs-menu-btn cs-fun-btn"><i class="icon iconfont icon-save"></i>保存</a>
		<a href="${webRoot}/data/deviceSeries/detectParameter/list.do?id=${deviceType.id}" class="cs-menu-btn cs-fun-btn"><i class="icon iconfont icon-fanhui" ></i>返回</a>
	</div>

	<!-- 内容主体 结束 -->
	<%@include file="/WEB-INF/view/common/confirm.jsp"%>
	<%@include file="/WEB-INF/view/data/detectItem/selectDetectItemForAll.jsp"%>
	<script type="text/javascript">
		$(".choseShow").addClass("cs-hide");
		$(function() {
			initForm();
			$.ajax({
				url : '${webRoot}/data/detectModular/queryAllDetectModular.do',
				type : 'post',
				dataType : "json",
				success : function(data) {
					var json = eval(data);
					$("#detect_modular").empty("");
					var htmlStr = "";
					$.each(json, function(index, item) {
						if(item.detectModular=="${data.obj.projectType}"){
							htmlStr += "<option value='"+item.id+"' selected='selected'>" + item.detectModular + "</option>";
						}else{
							htmlStr += "<option value='"+item.id+"'>" + item.detectModular + "</option>";
						}
					});
					$("#detect_modular").append(htmlStr);
					var modular = document.getElementById('detect_modular');
					modular.addEventListener("change", choseModular(modular), false);
				},
				error : function() {
					console.log("删除失败");
				}
			});
			//选择检测项目
			$(".dItem").on("click", function() {
				$('#myDetectItemModal').modal('toggle');
			});
			$("#saveForm").Validform({
				ignoreHidden: true,
				beforeSubmit: function(){
	    			var formData = new FormData($('#saveForm')[0]);
	    			$.ajax({
	    		        type: "POST",
	    		        url: "${webRoot}/data/deviceSeries/detectParameter/save.do",
	    		        data: formData,
	    		        contentType: false, //必须false才会避开jQuery对 formdata 的默认处理 XMLHttpRequest会对 formdata 进行正确的处理 
	    		        processData: false, //必须false才会自动加上正确的Content-Type
	    		        dataType: "json",
	    		        success: function(data){
	    		        	if(data && data.success){
	    		        		self.location = '${webRoot}/data/deviceSeries/detectParameter/list.do?id=${deviceType.id}';
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
		});
		function choseModular(e) {
			$.ajax({
				url : '${webRoot}/data/detectModular/queryByModularId.do',
				type : 'post',
				data : {
					"id" : $(e).val()
				},
				dataType : "json",
				success : function(data) {
					var json = eval(data);
					$("#detect_method").empty("");
					var htmlStr = "";
					$.each(json, function(index, item) {
						if(item.detectMethod=="${data.obj.detectMethod}"){
							htmlStr += "<option value='"+item.id+"' selected='selected'>" + item.detectMethod + "</option>";
						}else{
							htmlStr += "<option value='"+item.id+"'>" + item.detectMethod + "</option>";
						}
					});
					$("#detect_method").append(htmlStr);
					$("input[name=projectType]").val($(e).find("option:selected").text());
					var method = document.getElementById('detect_method');
					method.addEventListener("change", choseMethod(method), false);
				},
				error : function() {
					console.log("加载失败");
				}
			});
		}
		//选择检测项目
		function selDetectItem(id, text) {
			$(".dItem").val(text);
			$(".dItemId").val(id);
			$('#myDetectItemModal').modal('toggle');
		}
		//选择检测方法，控制input显示与隐藏
		function choseMethod(obj) {
			$("input[name=detectMethod]").val($(obj).find("option:selected").text());
			$(".choseShow").addClass("cs-hide");
			$.ajax({
				url : '${webRoot}/data/detectMethod/queryById.do',
				type : 'post',
				data : {
					"id" : $(obj).val()
				},
				dataType : "json",
				success : function(data) {
					if(data.obj.showParameter !=null && data.obj.showParameter!=''){//显示需要配置的参数
						var showList=data.obj.showParameter.split(",");
						for(var i in showList){
							$("."+showList[i]).removeClass("cs-hide");
						}
					}
				},
				error : function() {
					console.log("加载失败");
				}
			});
		}
		//编辑时初始化表单下拉选项
		function initForm(){
			if("${data.obj.wavelength}" !=null && "${data.obj.wavelength}"!=''){
				$("[name=wavelength]").val("${data.obj.wavelength}");
			}
			if("${data.obj.ctabsx}" !=null && "${data.obj.ctabsx}"!=''){
				$("[name=ctabsx]").val("${data.obj.ctabsx}");
			}
			if("${data.obj.parameter}" !=null && "${data.obj.parameter}"!=''){
				$("[name=parameter]").val("${data.obj.parameter}");
			}
		}
		//TODO shit 待确定界面bug
	</script>
</body>
</html>