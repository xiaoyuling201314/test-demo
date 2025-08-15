<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 下拉插件 -->
<script src="${webRoot}/js/select/tabcomplete.min.js"></script>
<script src="${webRoot}/js/select/livefilter.min.js"></script>
<script src="${webRoot}/js/select/bootstrap-select.js"></script>
<script src="${webRoot}/js/select/filterlist.js"></script>
<link rel="stylesheet" type="text/css" href="${webRoot}/plug-in/myUpload/css/easyupload.css"/>
 <script src="${webRoot}/plug-in/myUpload/js/easyupload.js" type="text/javascript"></script>
<style type="text/css">
	.cs-input-box .Validform_checktip{
		display:none;
	}
	   .file-name-span {
            color: blue;
        }

        .file-name-span:hover {
            color: #3033ff;
            cursor: pointer;
        }
        .cs-add-new{
        	table-layout: fixed;
        }
        .cs-add-new .cs-name{
        	width:200px;
        }
</style>

<!-- 新增、编辑检测点模态框 -->
<form id="addPointForm" action="${webRoot}/detect/basePoint/save.do" method="post">
	<div class="modal fade" id="addPointModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
		data-backdrop="static">
		<div class="modal-dialog cs-lg-width" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title">新增检测点</h4>
				</div>
				<div class="modal-body cs-lg-height">
					<div class="cs-content">
						<table class="cs-add-new">
							<tr>
								<td class="cs-name"><i class="cs-mred">*</i>名称：</td>
								<td class="cs-in-style"><input type="hidden" name="id" /> 
									<input type="hidden" name="deleteFlag" value="0" />
									<input type="text" name="pointName" datatype="*" nullmsg="请输入名称" errormsg="请输入名称" />
								</td>
							</tr>
							<tr>
								<td class="cs-name"><i class="cs-mred">*</i>所属机构：</td>
								<td class="cs-in-style">
									<div class="cs-all-ps">
										<div class="cs-input-box">
											<input type="text" id="departName" name="departName" datatype="*" nullmsg=" " errormsg=" " readonly="readonly" onchange="changeSelOrg()"> 
											<input type="hidden" id="departId" name="departId" datatype="*" nullmsg=" " errormsg=" ">
											<div class="cs-down-arrow"></div>
										</div>
										<div class="cs-check-down cs-hide" style="display: none;">
											<ul id="myDeaprtTree" class="easyui-tree"></ul>
										</div>
									</div>
								</td>
							</tr>
							<tr>
								<td class="cs-name"><i class="cs-mred">*</i>检测点类型：</td>
								<td>
									<select name="pointType">
										<option value="0">检测站</option>
										<option value="1">检测车</option>
									</select>
								</td>
							</tr>
							<tr>
								<td class="cs-name"><i class="cs-mred">*</i>检测点性质：</td>
								<td>
									<select name="pointTypeId" id="pointTypeId" onchange="changeSelOrg();">
										<c:forEach items="${types}" var="t">
											<option value="${t.id}" data-regulatory="${t.regulatory}"
											data-regualtoryTypeId="${t.regualtoryTypeId}">${t.pointType}</option>
										</c:forEach>
									</select>
								</td>
							</tr>
							<tr id="regTR" style="display: none;">
								<td class="cs-name"><i class="cs-mred">*</i>被检单位：</td>
								<td>
									<select name="regulatoryId" id="regulatoryId" datatype="*" nullmsg="请选择被检单位" errormsg="请选择被检单位" >
									</select>
								</td>
							</tr>
							<tr id="sampleDelivery" class="cs-hide">
								<td class="cs-name">送样：</td>
								<td class="cs-check-radio cs-li-radio">
									<label for="sd1">
										<input id="sd1" type="radio" name="sampleDelivery" value="0" checked="checked">不接受
									</label>
									<label for="sd2">
										<input id="sd2" type="radio" name="sampleDelivery" value="1">接受
									</label>
								</td>
							</tr>
							<tr id="signatureType" class="cs-hide">
								<td class="cs-name">电子章设置：</td>
								<td class="cs-check-radio cs-li-radio">
									<label for="type1">
										<input id="type1" type="radio" name="signatureType" value="0" checked="checked"/>默认
									</label>
									<label for="type2">
										<input id="type2" type="radio" name="signatureType" value="1"/>自定义
									</label>
									<label for="type3">
										<input id="type3" type="radio" name="signatureType" value="2"/>无
									</label>
								</td>
							</tr>
							<tr id="customizeSignature" class="cs-hide">
								<!-- <td class="cs-name">电子签章：</td>
								<td class="cs-in-style"><input type="file" name="urlPathFile" style="width:200px;" /></td> -->
							 <td class="cs-name">附件：</td>
		                        <td class="cs-in-style">
		                            <div id='uploaderFile'></div>
		                        </td>
							</tr>
							<tr id="principal">
								<td class="cs-name">督导：</td>
								<td class="cs-in-style"><select name="managerId"  id="pointUserItems"></select></td>
							</tr>
							<tr class="vehicleAttr">
								<td class="cs-name">车牌：</td>
								<td class="cs-in-style"><input type="text" name="licensePlate" ignore="ignore" datatype="vehicleNum"
									errormsg="请输入正确车牌" /></td>
							</tr>
							<tr class="vehicleAttr">
								<td class="cs-name">IMEI：</td>
								<td class="cs-in-style"><input type="text" name="imei" /></td>
							</tr>
							<tr>
								<td class="cs-name">电话：</td>
								<td class="cs-in-style"><input type="text" name="phone" /></td>
							</tr>
							<tr>
								<td class="cs-name">地址：</td>
								<td class="cs-in-style"><input type="text" name="address" /></td>
							</tr>
							<tr>
								<td class="cs-name">备注：</td>
								<td class="cs-in-style"><textarea name="remark"></textarea></td>
							</tr>
							<tr>
								<td class="cs-name">序号：</td>
								<td class="cs-in-style"><input type="text" name="sorting" class="inputxt" datatype="n" ignore="ignore"
									errormsg="请输入数字序号" /></td>
							</tr>
						</table>
					</div>
				</div>
				<div class="modal-footer">
					<button type="submit" class="btn btn-success">确定</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				</div>
			</div>
		</div>
	</div>
</form>

<!-- JavaScript -->
<script type="text/javascript">
var uploaderobj = [];
$(function () {
	if(Permission.exist("391-20")){//送样配置
		$("#sampleDelivery").removeClass("cs-hide");
	}
	if(Permission.exist("391-21")){//电子章配置
		$("#signatureType").removeClass("cs-hide");
	}
    uploaderobj = easyUploader({
        id: "uploaderFile", //容器渲染的ID 必填
        accept: '*',    //可上传的文件类型
        maxCount: 5,   //允许的最大上传数量
        maxSize: 1024,  //允许的文件大小 单位：M
        multiple: true, //是否支持多文件上传
        name: "files",     //后台接收的文件名称
        isEncrypt: false,//是否加密
        onChange: function (fileList) {
            //input选中时触发
        },
        onAlert: function (msg) {
            $("#confirm-warnning .tips").text(msg);
            $("#confirm-warnning").modal('toggle');
        }
    });
});
	//验证
	var addPointValidform = $("#addPointForm").Validform({
		tiptype : 3,
		label : ".label",
		showAllError : true,
		 beforeSubmit: function () {
             var formData = new FormData($('#addPointForm')[0]);
             var fileList = uploaderobj.files;
             for (var i = 0; i < fileList.length; i++) {
                 formData.append("urlPathFile", fileList[i]);
             }
           $.ajax({
                 type: "POST",
                 url: "${webRoot}/detect/basePoint/save.do",
                 data: formData,
                 contentType: false, //必须false才会避开jQuery对 formdata 的默认处理 XMLHttpRequest会对 formdata 进行正确的处理
                 processData: false, //必须false才会自动加上正确的Content-Type
                 dataType: "json",
                 success: function (data) {
                     if (data && data.success) {
                    	 self.location.reload();
                     } else {
                    	 $.Showmsg(data.msg);
                     }
                 }
             });
             return false;
		 }
	});

	//清空新增检测点模态框输入框
	$('#addPointModal').on('hidden.bs.modal', function() {
		$("#file-list-" + uploaderobj.configs.id).html('');
		$("#customizeSignature").addClass("cs-hide");
		addPointValidform.resetForm();
		addPointValidform.resetStatus();
	});

	//修改检测点类型
	$(document).on("change", "select[name='pointType']", function() {
		changePointType();
	});
	//修改电子章配置
	$(document).on("change", "input[name=signatureType]", function(e) {
		if($("input[name=signatureType]:checked").val()==1){//自定义电子章
			$("#customizeSignature").removeClass("cs-hide");
		}else{
			$("#customizeSignature").addClass("cs-hide");
		}
	});
	function changePointType() {
		var pointType = $("select[name='pointType']").val();
		if (pointType == 0) {
			//检测站
			$(".vehicleAttr").hide();
			$(".vehicleAttr input").val("");
		} else if (pointType == 1) {
			//检测车
			$(".vehicleAttr").show();
		}
	}

	//组织机构树
	$('#myDeaprtTree').tree({
		checkbox : false,
		url : "${webRoot}/detect/depart/getDepartTree.do",
		animate : true,
		onClick : function(node) {
			$('#addPointModal').find("input[name='departId']").val(node.id);
			$('#addPointModal').find("input[name='departName']").val(node.text);
			$(".cs-check-down").hide();
			
			changeSelOrg();
		},
		loadFilter : function(data, parent) {
			var state = $.data(this, 'tree');
			function setData() {
				var serno = 1;
				var todo = [];
				for (var i = 0; i < data.length; i++) {
					todo.push(data[i]);
				}
				while (todo.length) {
					var node = todo.shift();
					if (node.id == undefined) {
						node.id = '_node_' + (serno++);
					}
					if (node.children) {
						node.state = 'closed';
						node.children1 = node.children;
						node.children = undefined;
						todo = todo.concat(node.children1);
					}
				}
				state.tdata = data;
			}
			function find(id) {
				var data = state.tdata;
				var cc = [ data ];
				while (cc.length) {
					var c = cc.shift();
					for (var i = 0; i < c.length; i++) {
						var node = c[i];
						if (node.id == id) {
							return node;
						} else if (node.children1) {
							cc.push(node.children1);
						}
					}
				}
				return null;
			}

			setData();

			var t = $(this);
			var opts = t.tree('options');
			opts.onBeforeExpand = function(node) {
				var n = find(node.id);
				if (n && n.children && n.children.length) { return; }
				if (n && n.children1) {
					var filter = opts.loadFilter;
					opts.loadFilter = function(data) {
						return data;
					};
					t.tree('append', {
						parent : node.target,
						data : n.children1
					});
					opts.loadFilter = filter;
					n.children = n.children1;
				}
			};
			return data;
		}
	});

	//打开新增、编辑检查点模态框
	function addPoint(id) {
		if (id) {
			$("#addPointModal .modal-title").text("编辑检测点");
			$("#principal").show();
			$.ajax({
				type : "POST",
				url : '${webRoot}' + "/detect/basePoint/queryById.do",
				data : {
					"id" : id
				},
				dataType : "json",
				success : function(data) {
					if (data && data.success) {
						var obj = data.obj;
						if (obj) {
							if (obj.depart) {
								$('#addPointModal').find("input[name='departId']").val(obj.depart.id);
								$('#addPointModal').find("input[name='departName']").val(obj.depart.departName);
							}
							if (obj.baseBean) {
								$('#addPointModal').find("input[name='id']").val(obj.baseBean.id);
								$('#addPointModal').find("input[name='pointName']").val(obj.baseBean.pointName);
								$('#addPointModal').find("select[name='pointType']").val(obj.baseBean.pointType);
								$('#addPointModal').find("input[name='address']").val(obj.baseBean.address);
								$('#addPointModal').find("input[name='phone']").val(obj.baseBean.phone);
								$('#addPointModal').find("input[name='licensePlate']").val(obj.baseBean.licensePlate);
								$('#addPointModal').find("input[name='imei']").val(obj.baseBean.imei);
								$('#addPointModal').find("textarea[name='remark']").val(obj.baseBean.remark);
								$('#addPointModal').find("input[name='sorting']").val(obj.baseBean.sorting);
								if(obj.baseBean.sampleDelivery == 1){
									$('#addPointModal').find("input[name='sampleDelivery']:eq(1)").prop("checked",true);
								}else{
									$('#addPointModal').find("input[name='sampleDelivery']:eq(0)").prop("checked",true);
								}
								$('#addPointModal').find("input[name='signatureType']:eq("+obj.baseBean.signatureType+")").prop("checked",true);
								if(obj.baseBean.signatureType==1){
									$("#customizeSignature").removeClass("cs-hide");
								}
								$('#pointTypeId').val(obj.baseBean.pointTypeId);
								changeSelOrg(obj.baseBean.regulatoryId);
								if(obj.baseBean.signatureFile){
									$("#file-list-" + uploaderobj.configs.id).html('');
									editFileHtmlList(obj.baseBean.signatureFile, uploaderobj, '${webRoot}');
								}
							}

							$("#pointUserItems").html("");
							var optionHtml = "";
							if (obj.pointUsers) {
								var optionHtml = "<option value=\"\">---请选择督导---</option>";
								for (var i = 0; i < obj.pointUsers.length; i++) {
									optionHtml += "<option value=\"" + obj.pointUsers[i].userId + "\"";
									if (obj.baseWorkers && obj.baseWorkers.id == obj.pointUsers[i].userId) {
										optionHtml += " selected=\"selected\"";
									}
									optionHtml += ">" + obj.pointUsers[i].workerName + "</option>";
								}
								$("#pointUserItems").append(optionHtml);
							}
							
							changePointType();
							/* 
							if(obj.regs.length>0){
								$("#regTR").attr("style","display:''");
								$("#regulatoryId").removeAttr("disabled");
								$("#regulatoryId").empty();
								var html = "<option value=''>---请选择被检单位---</option>";
								for (var i = 0; i < obj.regs.length; i++) {
									var reg = obj.regs[i];
									html += "<option value='"+reg.id+"'>"+reg.regName+"</option>";
								}
								$("#regulatoryId").html(html);
								$('#regulatoryId').val(obj.baseBean.regulatoryId);
							}
							 */
						}
					}
				}
			});
		} else {
			$("#addPointModal .modal-title").text("新增检测点");
			$("#principal").hide();
// 			$("#addPointForm input").val("");
			changePointType();
		}
		$('#addPointModal').modal('toggle');
	}

	//保存
// 	function mySubmit() {
// 		addPointValidform.ajaxPost();
// 	}
	function changeSelOrg(rid){
		var departId = $("#departId").val();
		var regulatory = $("#pointTypeId").find("option:selected").attr("data-regulatory");
		var regualtoryTypeId = $("#pointTypeId").find("option:selected").attr("data-regualtoryTypeId");
		var regulatoryName = $("#pointTypeId").find("option:selected").text();
		if(regulatory == '1' && (regulatoryName == '农批市场' || regulatoryName == '农贸市场')){		//只有农批市场、农贸市场才有被检单位
			$("#regTR").attr("style","display:''");
			//$("#regulatoryId").removeAttr("disabled");
			$("#regulatoryId").removeAttr("ignore");
			$.ajax({
				url:'${webRoot}/regulatory/regulatoryObject/queryRegByDepartId',
				data:{departId:departId,regualtoryTypeId:regualtoryTypeId},
				success:function(data){
					var regs = data.obj;
					$("#regulatoryId").empty();
					var html = "<option value=''>---请选择被检单位---</option>";
					for (var i = 0; i < regs.length; i++) {
						var reg = regs[i];
						html += "<option value='"+reg.id+"'>"+reg.regName+"</option>";
					}
					$("#regulatoryId").html(html);
					
					if(rid){//编辑检测点-选中被检单位
						$('#regulatoryId').val(rid);
					}
				}
			});
		}else{
			$("#regTR").attr("style","display:none");
			//$("#regulatoryId").attr("disabled","disabled");
			$('#regulatoryId').val("");
			$("#regulatoryId").attr("ignore","ignore");
		}
	}
	function editFileHtmlList(files, uploader, root) {
        var html = '';
          var fileName = files;
          var showName = fileName;
          if (fileName.length > 14) {
              showName = fileName.substring(0, 14) + "...";
          }
          html += '<div class="upload-files clearfix">';
          html += '<span class="file-name-span"  title="' + fileName + '">' + showName + '</span>';
          html += '<a class="icon iconfont icon-chushaixuanxiang shanchu"  data-fileid="files_0" data-uploadid="#' + uploader.configs.id + '" onclick="removeFile(this)" title="删除"></a>';
          html += '</div>';
        $("#file-list-" + uploader.configs.id).append(html);
    }
</script>
