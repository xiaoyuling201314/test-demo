<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/common/resource.jsp"%>
<html>
  <head>
    <title>快检服务云平台</title>
  </head>
  <body>
          <!-- 面包屑导航栏  开始-->
          <div class="cs-col-lg clearfix">
            <ol class="cs-breadcrumb">
              <li class="cs-fl">
              <img src="${webRoot}/img/set.png"/>
              <a href="javascript:">监管对象</a></li>
              <li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
              <li class="cs-b-active cs-fl">${regType}</li>
            </ol>
            <div class="cs-input-style cs-fl" style="margin:3px 0 0 30px;">
              	行政区:
              	<div class="cs-all-ps">
				                    <div class="cs-input-box">
				                    <input type="text" name="departNames">
				                      <div class="cs-down-arrow"></div>
				                    </div>
				                    <div class="cs-check-down cs-hide" style="display: none;">
				                      <ul id="tree" class="easyui-tree"></ul>
				                    </div>
			                    </div>
            </div>
          <!-- 面包屑导航栏  结束-->
            <div class="cs-search-box cs-fr">
              <form>
                <input class="cs-input-cont cs-fl focusInput" type="text" name="regulatoryObject.regName" placeholder="请输入企业名称" />
                <input type="button" onclick="datagridUtil.queryByFocus();" class="cs-search-btn cs-fl" href="javascript:;" value="搜索">
                <div class="cs-search-filter clearfix cs-fl">
                <!-- <span class="cs-s-search cs-fl">高级搜索</span> -->
                </div>
                <div class="clearfix cs-fr" id="showBtn"></div>
              </form>
            </div>
          </div>

		<div id="dataList"></div>
		
	<div class="modal fade intro2" id="qrcodeModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog cs-lg-width">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
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
    
    <%@include file="/WEB-INF/view/common/confirm.jsp"%>
    
    <!-- JavaScript -->
    <script src="${webRoot}/js/datagridUtil.js"></script>
    <script type="text/javascript">
	var qrcodeBtn=0;
	var qrcodeObj;
	var objectExports=0;
    var objectExportObj;
    var businessExports=0;
    var businessExportObj;
    for(var i = 0; i < childBtnMenu.length; i++) {
			if (childBtnMenu[i].operationCode == "331-1"||childBtnMenu[i].operationCode == "332-1"||
					childBtnMenu[i].operationCode == "333-1"||childBtnMenu[i].operationCode == "1315-1"||
					childBtnMenu[i].operationCode == "1352-1"||childBtnMenu[i].operationCode == "1353-1"||childBtnMenu[i].operationCode == "1354-1") {
				//新增
				var html='<a class="cs-menu-btn" href="${webRoot}/regulatory/regulatoryObject/goAddRegulatoryObject.do?regTypeId=${regTypeId}"><i class="'+childBtnMenu[i].functionIcon+'"></i>新增</a>';
				$("#showBtn").append(html);
			}else if (childBtnMenu[i].operationCode == "331-2"||childBtnMenu[i].operationCode == "332-2"||
					childBtnMenu[i].operationCode == "333-2"||childBtnMenu[i].operationCode == "1315-2"||
					childBtnMenu[i].operationCode == "1352-2"||childBtnMenu[i].operationCode == "1353-2"||childBtnMenu[i].operationCode == "1354-2") {
				//编辑
				edit = 1;
				editObj=childBtnMenu[i];
			}else if (childBtnMenu[i].operationCode == "331-3"||childBtnMenu[i].operationCode == "332-3"||
					childBtnMenu[i].operationCode == "333-3"||childBtnMenu[i].operationCode == "1315-3"||
					childBtnMenu[i].operationCode == "1352-3"||childBtnMenu[i].operationCode == "1353-3"||childBtnMenu[i].operationCode == "1354-3") {
				//删除
				deletes = 1;
				deleteObj=childBtnMenu[i];
			}else if (childBtnMenu[i].operationCode == "331-7") {
				qrcodeBtn = 1;
				qrcodeObj=childBtnMenu[i];
			}else if (childBtnMenu[i].operationCode == "331-9") {
				//监管对象导入
				objectExports = 1;
				objectExportObj=childBtnMenu[i];
			}else if (childBtnMenu[i].operationCode == "331-10") {
				//经营户导入
				businessExports = 1;
				businessExportObj=childBtnMenu[i];
			}
			
		}
    $('#tree').tree({
		checkbox : false,
		url : "${webRoot}/detect/depart/getDepartTree.do",
		animate : true,
		onClick : function(node) {
			var did=node.id;
			$("input[name='departNames']").val(node.text);
			$(".cs-check-down").hide();
			
			bigbang(did);
		}
	});
    
    $(function () {
		bigbang(0);
	})

    function bigbang(e) {
    	var did=e;
    	var op = "";
        if("${showBusiness}" == "false"){
        		//其他单位
        		op = {
        			tableId: "dataList",	//列表ID
        			tableAction: '${webRoot}'+"/regulatory/regulatoryObject/datagrid.do?did="+did,	//加载数据地址
        			parameter: [		//列表拼接参数
        			    {
        			    	columnCode: "departName",
        			    	columnName: "所属机构"
        			    },
        				{
        					columnCode: "regName",
        					columnName: "企业名称"
        				},
        				{
            				columnCode: "id",
            				columnName: "二维码",
            				customElement: "<a class=\"runcode qrcode\" data-value='?' href=\"javascript:;\"><img src=\"${webRoot}/img/2dcode.png\" alt=\"\" /></a>",
                            show: Permission.exist("331-7")
            			}, {
							columnCode : "regAddress",
							columnName : "地址"
						},
        				{
        					columnCode: "checked",
        					columnName: "状态",
        					customVal: {"0":"<div class=\"text-danger\">未审核</div>","1":"<div class=\"text-primary\">已审核</div>"}
        				}
        			],
        			defaultCondition: [	//默认查询条件
        				{
        					queryCode: "regulatoryObject.regType",
        					queryVal: '${regTypeId}'
        				}
        			],
        			funBtns: [
        				    	{
        				    		show: edit,
        				    		style: editObj,
        				    		action: function(id){
        				    			self.location = '${webRoot}/regulatory/regulatoryObject/goAddRegulatoryObject.do?regTypeId=${regTypeId}&id='+id;
        				    		}
        				    	},
        				    	{
        				    		show: deletes,
        				    		style: deleteObj,
        				    		action: function(id){
        				    			if(id == ''){
        	    			    			$("#confirm-warnning .tips").text("请选择监管对象");
        	    			    			$("#confirm-warnning").modal('toggle');
            			    			}else{
        	    			    			deleteIds = id;
        	    			    			$("#confirm-delete").modal('toggle');
            			    			}
        				    		}
        				    	}
        				    ],	//操作列按钮 
        		    bottomBtns: [//底部按钮
    						{
    							show: qrcodeBtn,
    							style: qrcodeObj,
    							action: function(ids){
    								if(ids == ''){
    									$("#confirm-warnning .tips").text("请选择监管对象");
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
    	    			    			$("#confirm-warnning .tips").text("请选择监管对象");
    	    			    			$("#confirm-warnning").modal('toggle');
        			    			}else{
    	    			    			deleteIds = ids;
    	    			    			$("#confirm-delete").modal('toggle');
        			    			}
        			    		}
        			    	},
        			    	{//导入监管对象按钮
        			    		show: objectExports,
        			         	style: objectExportObj,
        			    		action: function(ids){
        			    			location.href='${webRoot}/regulatory/regulatoryObject/toImport.do'
        			    		}
        			    	},
        			    	{//导入经营户按钮
        			    		show: businessExports,
        			         	style: businessExportObj,
        			    		action: function(ids){
        			    			location.href='${webRoot}/regulatory/regulatoryObject/toImport.do'
        			    		}
        			    	}
        			    ]	
        		};
        }else{
        	//经营单位
    		op = {
    			tableId: "dataList",	//列表ID
    			tableAction: '${webRoot}'+"/regulatory/regulatoryObject/datagrid.do?did="+did,	//加载数据地址
    			parameter: [		//列表拼接参数
    				{
    					columnCode: "departName",
    					columnName: "所属机构"
    				},
    				{
    					columnCode: "regName",
    					columnName: "企业名称",
    					queryCode: "regName",
    					query: 1
    				},
    				{
        				columnCode: "id",
        				columnName: "二维码",
        				customElement: "<a class=\"runcode qrcode\" data-value='?' href=\"javascript:;\"><img src=\"${webRoot}/img/2dcode.png\" alt=\"\" /></a>",
                        show: Permission.exist("331-7")
        			},
    				{
    					columnCode: "businessNumber",
    					columnName: "经营户",
    					customElement: "<a class=\"cs-link-text businessNumber\" href=\"javascript:;\">?户</a>",
    					columnWidth: "100px"
    				},
    				 {
						columnCode : "regAddress",
						columnName : "地址"
					},
    				{
    					columnCode: "checked",
    					columnName: "状态",
    					customVal: {"0":"<div class=\"text-danger\">未审核</div>","1":"<div class=\"text-primary\">已审核</div>"}
    				}
    			],
    			defaultCondition: [	//默认查询条件
    				{
    					queryCode: "regulatoryObject.regType",
    					queryVal: '${regTypeId}'
    				}
    			],
    			funBtns: [
    				    	{
    				    		show: edit,
    				    		style: editObj,
    				    		action: function(id){
    				    			self.location = '${webRoot}/regulatory/regulatoryObject/goAddRegulatoryObject.do?regTypeId=${regTypeId}&id='+id;
    				    		}
    				    	},
    				    	{
    				    		show: deletes,
    				    		style: deleteObj,
    				    		action: function(id){
    				    			if(id == ''){
    	    			    			$("#confirm-warnning .tips").text("请选择监管对象");
    	    			    			$("#confirm-warnning").modal('toggle');
        			    			}else{
    	    			    			deleteIds = id;
    	    			    			$("#confirm-delete").modal('toggle');
        			    			}
    				    		}
    				    	}
    				    ],	//操作列按钮 
    		    bottomBtns: [
    					{
    						show: qrcodeBtn,
    						style: qrcodeObj,
    						action: function(ids){
    							if(ids == ''){
    								$("#confirm-warnning .tips").text("请选择监管对象");
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
        			    			$("#confirm-warnning .tips").text("请选择监管对象");
        			    			$("#confirm-warnning").modal('toggle');
    			    			}else{
        			    			deleteIds = ids;
        			    			$("#confirm-delete").modal('toggle');
    			    			}
    			    		}
    			    	},
    			    	{//导入监管对象按钮
    			    		show: objectExports,
    			         	style: objectExportObj,
    			    		action: function(ids){
    			    			location.href='${webRoot}/regulatory/regulatoryObject/toImport.do'
    			    		}
    			    	},
    			    	{//导入经营户按钮
    			    		show: businessExports,
    			         	style: businessExportObj,
    			    		action: function(ids){
    			    			location.href='${webRoot}/regulatory/business/toImport.do'
    			    		}
    			    	}
    			    ],	//底部按钮
    		};
        }
        
    	datagridUtil.initOption(op);
    	
        datagridUtil.query();
	}
    
    
    
    //查看经营户
    $(document).on("click",".businessNumber",function(){
    	self.location = '${webRoot}/regulatory/business/list.do?regId='+$(this).parents(".rowTr").attr("data-rowId");
    });
    
    //删除
    var deleteIds = "";
    function deleteData(){
    	$.ajax({
	        type: "POST",
	        url: '${webRoot}'+"/regulatory/regulatoryObject/delete.do",
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
    
    $(document).on("click",".qrcode",function(){
    	viewQrcode($(this).attr("data-value"));
    });
    
  	//查看二维码
    function viewQrcode(ids){
    	$("#qrcodeModal .modal-body").html("");
    	$.ajax({
	        type: "POST",
	        url: '${webRoot}'+"/regulatory/regulatoryObject/regObjectQrcode.do",
	        data: {"ids":ids.toString()},
	        dataType: "json",
	        success: function(data){
	        	if(data && data.success){
		        	for(var i=0;i<data.obj.length;i++){
		        		$("#qrcodeModal .modal-body").append("<div class=\"cs-2dcode\"><img src=\"${webRoot}" + data.obj[i].qrcodeSrc
		        			+ "\" alt=\"\" width=\"150px\"><p>"+data.obj[i].regName+"</p></div>");
		        	}
	        	}
			}
	    });
    	$('#qrcodeModal').modal('toggle');
    }
  	
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
  </body>
</html>
