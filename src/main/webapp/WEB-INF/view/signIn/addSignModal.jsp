<%@ page import="java.util.Date" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!--录入上下班打卡信息-->
<div class="modal fade intro2" id="addSignModal" role="dialog" aria-labelledby="myModalLabel">
	<div class="modal-dialog cs-mid-width" role="document">
		<div class="modal-content ">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
				<h4 class="modal-title" id="mySignModalLabel">新增</h4>
			</div>
			<div class="modal-body cs-mid-height">
				<!-- 主题内容 -->
				<div class="cs-tabcontent" >
					<div class="cs-content2">
						<form id="saveSignForm" action="${webRoot}/system/role/save.do" method="post">
							<input type="hidden" name="createBy" value="${userId}"  >
							<div width="100%" class="cs-add-new">
								<c:choose>
									<c:when test="${session_user.pointId=='' || session_user.pointId==null}">
										<%--<ul class="cs-ul-form clearfix">
											<li  class="cs-name col-xs-4 col-md-4" width="20% "><i class="cs-mred">*</i>姓名：</li>
											<li class="cs-in-style cs-modal-input" >
												<input type="text" name="realName" readonly="readonly" value="${realname}" style="background-color:#fafafa;"/>
											</li>
										</ul>--%>
										<ul class="cs-ul-form clearfix" id="pointSelUl">
											<li class="cs-name col-xs-4 col-md-4"><i class="cs-mred">*</i>姓名：</li>
											<li class="cs-in-style cs-modal-input">
												<select class="js-select2-tags" name="realName" id="signUser" datatype="*" nullmsg="请选择打卡人员!">
												</select>
											</li>
											<li class="col-xs-4 col-md-4 cs-text-nowrap">
												<div class="Validform_checktip"></div>
												<div class="info"></div>
											</li>
										</ul>
										<ul class="cs-ul-form clearfix">
											<li  class="cs-name col-xs-4 col-md-4" width="20% "><i class="cs-mred">*</i>打卡时间：</li>
											<li class="cs-in-style cs-modal-input" >
												<input class="cs-time" type="text" name="createDate" readonly="readonly" onClick="WdatePicker({startDate:'%y-%M-%d %H:%m:%s',maxDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})" datatype="*" nullmsg="请选择打卡时间" /></li>
											</li>
										</ul>
									</c:when>
									<c:otherwise>
										<ul class="cs-ul-form clearfix">
											<li  class="cs-name col-xs-4 col-md-4" width="20% "><i class="cs-mred">*</i>姓名：</li>
											<li class="cs-in-style cs-modal-input" >
												<input type="text" readonly="readonly" value="${session_user.realname}" style="background-color:#fafafa;"/>
											</li>
										</ul>
										<%--<ul class="cs-ul-form clearfix">
											<li  class="cs-name col-xs-4 col-md-4" width="20% "><i class="cs-mred">*</i>打卡时间：</li>
											<li class="cs-in-style cs-modal-input" >
												<input type="text" name="createDate" readonly="readonly" style="background-color:#fafafa;"/>
											</li>
										</ul>--%>
									</c:otherwise>
								</c:choose>
								<ul class="cs-ul-form clearfix">
									<li  class="cs-name col-xs-4 col-md-4">打卡类型：</li>
									<li class="cs-al cs-modal-input">
										<input id="cs-check-radio" type="radio" value="3" name="signType" checked="checked" /><label for="cs-check-radio">上班打卡</label>
										<input id="cs-check-radio2" type="radio" value="4" name="signType" /><label for="cs-check-radio2">下班打卡</label>
									</li>
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
<script>
	//录入打卡信息
	$("#saveSignForm").Validform({
		tiptype:1,
		beforeSubmit:function(){
			let userId="";//打卡人ID
			let realName="";//打卡人姓名，代打卡时需要传入，自己打卡是不用理会
			if("${session_user.pointId}"!=""){//检测点用户，直接获取用户ID
				userId="${session_user.id}";
			}else{//机构用户
				userId=$("#signUser option:selected").val();
				realName=$("#signUser option:selected").text();
			}

			let signType=$("#saveSignForm input[name=signType]:checked").val();
			let createDate=$("#saveSignForm input[name=createDate]").val();
			if(typeof(createDate)=='undefined'){
				createDate=new Date().format("yyyy-MM-dd HH:mm:ss");
			}
			$.ajax({
				type : "POST",
				url : "${webRoot}/signIn/save.do",
				data : {"createBy":userId,"signType":signType,"createDate":createDate,"realName":realName},
				success : function(data) {
					if (data && data.success) {
						$("#addSignModal").modal('hide');
						datagridUtil.query();
					} else {
						$("#confirm-warnning .tips").text("操作失败");
						$("#confirm-warnning").modal('toggle');
					}
				}
			});
			return false;
		}
	});
	//表单提交
	$("#btnSave").on("click", function () {
		$("#saveSignForm").submit();
	});
	//关闭编辑模态框前重置表单，清空隐藏域
	$('#addSignModal').on('hidden.bs.modal', function(e) {
		$("#saveSignForm").Validform().resetForm();
		$("input").removeClass("Validform_error");
		$(".Validform_wrong").hide();
		$(".Validform_checktip").hide();
	});
	//打开模态框，设置打卡时间
	$('#addSignModal').on('show.bs.modal', function(e) {
		if("${realname}"!=""){//项目预览中查看打卡签到详情链接进行补录
			$("#signUser").append('<option value=" ${userId}" data-name="${realname}" >${realname}</option>');
		}else{//在项目预览主页和数据中心打开模态框，默认为当前用户
			$("#signUser").append('<option value=" ${session_user.id}" data-name="${session_user.realname}" >${session_user.realname}</option>');
		}
		$("#saveSignForm input[name='createDate']").val(new Date().format("yyyy-MM-dd HH:mm:ss"));
	});
</script>
