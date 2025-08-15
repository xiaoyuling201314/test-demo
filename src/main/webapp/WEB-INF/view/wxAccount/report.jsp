<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/common/resource.jsp"%>
<html>
  <head>
    <title>快检服务云平台</title>
    <style type="text/css">
    .cs-lg-style input,.cs-lg-style textarea{
    	width:400px;
    }
    </style>
  </head>
  <body>
	<div id="dataList"></div>
  	<div class="modal fade intro2" id="myModal2" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog cs-lg-width" role="document">
      <div class="modal-content ">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
          <h4 class="modal-title" id="myModal2">新增</h4>
        </div>
        <div class="modal-body cs-xlg-height" >
           <!-- 主题内容 -->
      <div class="cs-tabcontent" >
        <div class="cs-content2">
        <form id="saveForm" enctype="multipart/form-data" action="save.do">
      <input type="hidden" name="id"  id="id">
       <div width="100%" class="cs-add-new">
        <ul class="cs-ul-form clearfix">
            <li class="cs-name col-xs-3 col-md-3">所属机构：</li>
            <li class="cs-in-style cs-modal-input">
                <div class="cs-all-ps">
                    <div class="cs-input-box">
                        <input type="hidden"  name="departId" value=""/>
                        <input type="text" name="departNames" readonly="readonly" class="sPointName cs-down-input" datatype="*" nullmsg="请选择机构" errormsg="机构错误!"/>
                        <div class="cs-down-arrow"></div>
                    </div>
                    <div id="divBtn" class="cs-check-down  cs-hide" style="display: none;">
                        <ul id="tt" class="easyui-tree"></ul>
                    </div>
                </div>
            </li>
            <li class="col-xs-4 col-md-4 cs-text-nowrap">
                <div class="Validform_checktip"></div>
                <div class="info"><i class="cs-mred">*</i>请选择机构</div>
            </li>
        </ul>
         <ul class="cs-ul-form clearfix">
                    <li  class="cs-name col-xs-3 col-md-3" width="20% ">公众号名称：</li>
                    <li class="cs-in-style cs-modal-input" width="210px" >
                    <input type="text" name="accountName" class="inputxt" autocomplete="off" datatype="*" nullmsg="请输入公众号名称" /></li>
                    <li class="col-xs-4 col-md-4 cs-text-nowrap">
                      <div class="Validform_checktip"></div>
                        <div class="info"><i class="cs-mred">*</i>请输入公众号名称
                        </div>
                    </li>
                </ul>
                <ul class="cs-ul-form clearfix">
                    <li  class="cs-name col-xs-3 col-md-3" width="20% ">公众号appId：</li>
                    <li class="cs-in-style cs-modal-input" width="210px" >
                    <input type="text" name="accountAppid" class="inputxt" autocomplete="off"  datatype="*" nullmsg="请输入公众号ID" /></li>
                    <li class="col-xs-4 col-md-4 cs-text-nowrap">
                      <div class="Validform_checktip"></div>
                        <div class="info"><i class="cs-mred">*</i>请输入公众号appId
                    </li>
                </ul>
                <ul class="cs-ul-form clearfix">
                    <li  class="cs-name col-xs-3 col-md-3" width="20% ">公众号密码：</li>
                    <li class="cs-in-style cs-modal-input" width="210px" >
                    <input name="accountAppsecret" class="inputxt" datatype="*" autocomplete="off"  nullmsg="请输入公众号密码" /></li>
                    <li class="col-xs-4 col-md-4 cs-text-nowrap">
                      <div class="Validform_checktip"></div>
                        <div class="info"><i class="cs-mred">*</i>请输入公众号密码
                    </li>
                </ul>
                 <ul class="cs-ul-form clearfix">
                    <li  class="cs-name col-xs-3 col-md-3" width="20% ">负责人信息：</li>
                    <li class="cs-in-style cs-modal-input" width="210px" >
                    <input type="text" name="accountUser" class="inputxt" datatype="*" autocomplete="off"  nullmsg="请输入负责人信息" /></li>
                    <li class="col-xs-4 col-md-4 cs-text-nowrap">
                      <div class="Validform_checktip"></div>
                        <div class="info"><i class="cs-mred">*</i>请输入负责人信息
                    </li>
                </ul>
                 <ul class="cs-ul-form clearfix">
                    <li  class="cs-name col-xs-3 col-md-3" width="20% ">联系电话：</li>
                    <li class="cs-in-style cs-modal-input" width="210px" >
                    <input type="text" name="accountUserPhone" class="inputxt" datatype="*" autocomplete="off"  nullmsg="请输入联系电话" /></li>
                    <li class="col-xs-4 col-md-4 cs-text-nowrap">
                      <div class="Validform_checktip"></div>
                        <div class="info"><i class="cs-mred">*</i>联系电话
                    </li>
                </ul>
                <ul class="cs-ul-form clearfix">
                    <li  class="cs-name col-xs-3 col-md-3" width="20% ">跳转url：</li>
                    <li class="cs-in-style cs-lg-style cs-modal-input"  style="width: 400px;">
                    <input type="text" name="redirectUrl" class="inputxt"autocomplete="off"  datatype="*" nullmsg="请输入跳转url" /></li>
                    <li class="col-xs-2 col-md-2 cs-text-nowrap">
                      <div class="Validform_checktip"></div>
                      <div class="info"><i class="cs-mred">*</i>请输入跳转url
                      </div>
                    </li>
                </ul>
               <ul class="cs-ul-form clearfix">
                    <li  class="cs-name col-xs-3 col-md-3" width="20% ">短信签名：</li>
                    <li class="cs-in-style cs-lg-style cs-modal-input"  style="width: 400px;">
                    <input type="text" name="signName" class="inputxt"autocomplete="off"  /></li>
                    <li class="col-xs-2 col-md-2 cs-text-nowrap">
                      <div class="Validform_checktip"></div>
                      
                    </li>
                </ul>
               <ul class="cs-ul-form clearfix">
                    <li  class="cs-name col-xs-3 col-md-3" width="20% ">短信模板ID：</li>
                    <li class="cs-in-style cs-lg-style cs-modal-input"  style="width: 400px;">
                    <input type="text" name="templateCode" class="inputxt"autocomplete="off"  /></li>
                    <li class="col-xs-2 col-md-2 cs-text-nowrap">
                      <div class="Validform_checktip"></div>
                    </li>
                </ul>
                <ul class="cs-ul-form clearfix">
                    <li  class="cs-name col-xs-3 col-md-3" width="20% ">访问密钥ID：</li>
                    <li class="cs-in-style cs-lg-style cs-modal-input"  style="width: 400px;">
                    <input type="text" name="accessKeyid" class="inputxt"autocomplete="off"  /></li>
                    <li class="col-xs-2 col-md-2 cs-text-nowrap">
                      <div class="Validform_checktip"></div>
                    </li>
                </ul>
                <ul class="cs-ul-form clearfix">
                    <li  class="cs-name col-xs-3 col-md-3" width="20% ">访问密钥：</li>
                    <li class="cs-in-style cs-lg-style cs-modal-input"  style="width: 400px;">
                    <input type="text" name="accessKeysecret" class="inputxt"autocomplete="off"  /></li>
                    <li class="col-xs-2 col-md-2 cs-text-nowrap">
                      <div class="Validform_checktip"></div>
                    </li>
                </ul>
                 
                 <ul class="cs-ul-form clearfix">
                    <li  class="cs-name  col-xs-3 col-md-3" width="20%">备注：</li>
                    <li class="cs-in-style cs-lg-style cs-modal-input" >
                    <textarea class="cs-remark" name="remark" id="remark" ></textarea></li>
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
    <%@include file="/WEB-INF/view/common/confirm.jsp"%>
    
	<script src="${webRoot}/js/datagridUtil2.js"></script>
    <script type="text/javascript">
   	var demo = $("#saveForm").Validform({
    		callback:function(data){
   				$.Hidemsg();
    			if(data.success){
    				$("#myModal2").modal("hide");
                    dgu.query();
    			}else{
    				$.Showmsg(data.msg);
    			}
    		}
    	});
    	// 新增或修改
    	$("#btnSave").on("click", function() {
    		demo.ajaxPost();
    		return false;
    	});
    	//关闭编辑模态框前重置表单，清空隐藏域
    	$('#myModal2').on('hidden.bs.modal', function (e) {
    		clear();
    	});
	var dgu = datagridUtil.initOption({
		tableId: "dataList",
		tableAction: "${webRoot}/wx/account/getReport.do",
        tableBar: {
            title: ["你送我检","汇总统计"],
            hlSearchOff: 0,
            ele: [{
                eleShow: 1,
                eleName: "keyWords",
                eleType: 0,
                elePlaceholder: "请输入公众号名称"
            }]
        },
		funColumnWidth: "150px",
		parameter: [
			{
				columnCode: "accountName",
				columnName: "公众号名称",
				customElement : "<a class=\"cs-link-text wxaccount\" href=\"javascript:;\">?</a>"
			},
			{
				columnCode: "count",
				columnName: "用户数量"
			},
			{
				columnCode: "samUserNum",
				columnName: "送检人数"
			},
			{
				columnCode: "samNum",
				columnName: "抽样单数",
				customElement : "<a class=\"cs-link-text sampling\" href=\"javascript:;\">?</a>"
			},
			{
				columnCode: "recordingNum",
				columnName: "检测批次"
			}
			
		]  
	});
	
	//查看公众号关注人数
	$(document).on("click", ".wxaccount", function() {
		self.location = '${webRoot}/wx/account/detail.do?id=' + $(this).parents(".rowTr").attr("data-rowId");
	});
    //选择行政区
    $('#tt').tree({
        checkbox: false,
        url: "${webRoot}/detect/depart/getDepartTree.do",
        animate: true,
        onLoadSuccess: function (node, data) {
            if (data.length > 0) {
                $("input[name='departNames']").val(data[0].text);
                $("input[name='departId']").val(data[0].id);
            }
        },
        onClick: function (node) {
            var did = node.id;
            $("input[name='departNames']").val(node.text);
            $(".cs-check-down").hide();
            $("input[name='departId']").val(did);
        }
    });
    dgu.query();
    
    /**
     * 查询用户信息
     */
    function getId(id) {
        if (id) {
            $.ajax({
                url: "${webRoot}/wx/account/queryById.do",
                type: "POST",
                data: {"id": id},
                dataType: "json",
                success: function (data) {
                    $(".info").hide();
                   var obj=data.obj;
                   if(obj){
                	     $("input[name=accountName]").val(obj.accountName);//公众号名称
                	     $("input[name=accountAppid]").val(obj.accountAppid);//appId
                	     $("input[name=accountAppsecret]").val(obj.accountAppsecret);//密码
                	     $("input[name=accountUser]").val(obj.accountUser);//负责人信息
                	     $("input[name=accountUserPhone]").val(obj.accountUserPhone);//负责人联系方式
                	     $("input[name=redirectUrl]").val(obj.redirectUrl);//跳转url
                	     $("input[name=signName]").val(obj.signName);//短信签名
                	     $("input[name=templateCode]").val(obj.templateCode);//短信模板id
                	     $("input[name=accessKeyid]").val(obj.accessKeyid);//密匙id
                	     $("input[name=accessKeysecret]").val(obj.accessKeysecret);//密匙
                	     $("#remark").text(obj.remark);//备注
                	     $("#id").val(obj.id);//id
                   }
                }
            });
            $("#myModal2 .modal-title").text("编辑");
        }  else{
            $("#myModal2 .modal-title").text("新增");
            
        }
        $("#myModal2").modal("show");

    }
    
  //查看公众号关注人数
	$(document).on("click", ".wxaccount", function() {
		self.location = '${webRoot}/wx/account/detail.do?id=' + $(this).parents(".rowTr").attr("data-rowId");
	});
	//查看公众号送检单
	$(document).on("click", ".sampling", function() {
		self.location = '${webRoot}/wx/account/samplingList.do?id=' + $(this).parents(".rowTr").attr("data-rowId");
	});
    function deleteData(){
    	$.ajax({
	        type: "POST",
	        url: '${webRoot}'+"/wx/account/delete.do",
	        data: {"ids":deleteIds.toString()},
	        dataType: "json",
	        success: function(data){
	        	if(data && data.success){
	        		self.location = "${webRoot}/wx/account/list.do";
	        	}else{
	        		$("#confirm-warnning .tips").text("删除失败");
	    			$("#confirm-warnning").modal('toggle');
	        	}
			}
	    });
		$("#confirm-delete").modal('toggle');
    }

    //清空表单
    function clear() {
 	     $("input[name=accountName]").val("");//公众号名称
 	     $("input[name=accountAppid]").val("");
 	     $("input[name=accountAppsecret]").val("");
 	     $("input[name=accountUser]").val("");
 	     $("input[name=accountUserPhone]").val("");//负责人联系方式
 	     $("input[name=redirectUrl]").val("");
	     $("input[name=signName]").val("");//短信签名
	     $("input[name=templateCode]").val("");//短信模板id
	     $("input[name=accessKeyid]").val("");//密匙id
	     $("input[name=accessKeysecret]").val("");//密匙
 	     $("#remark").text("");//备注
 	     $("#id").val("");//id
 	     $("#departId").val("");//id
 	     $("#departNames").val("");//id
	}
    </script>
  </body>
</html>
