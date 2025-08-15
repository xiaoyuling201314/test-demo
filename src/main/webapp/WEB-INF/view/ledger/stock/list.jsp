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
              <img src="${webRoot}/img/set.png" alt="" />
              <a href="javascript:">台账管理</a></li>
              <c:if test="${!empty regName }">
              <li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
              </c:if>
              <li class="cs-b-active cs-fl">${regName }
              <c:if test="${!empty bus.opeShopName}">
              <li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
              <li class="cs-b-active cs-fl">${bus.opeShopName}
              <li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
              <li class="cs-b-active cs-fl">台账列表
              </li></c:if>
            </ol>
          <!-- 面包屑导航栏  结束-->
            <div class="cs-search-box cs-fr">
              <form>
                <input class="cs-input-cont cs-fl focusInput" type="text" id="search"    name="search" placeholder="请输入食品名称" />
                <input type="button" onclick="datagridUtil.queryByFocus();" class="cs-search-btn cs-fl" href="javascript:;" value="搜索">
                <div class="clearfix cs-fr" id="showBtn"></div>
         <%--        <c:if test="${!empty regId }">
				<a href="${webRoot}/ledger/business/ledgerList.do?regId=${regId}"  class="cs-menu-btn"><i class="icon iconfont icon-fanhui"></i>返回</a>              </form>
            	</c:if> --%>
                <c:choose>
                <c:when test="${!empty businessId }">
                <a href="${webRoot}/ledger/business/list.do?regId=${regId}"  class="cs-menu-btn"><i class="icon iconfont icon-fanhui"></i>返回</a>
                </c:when>
            	<c:otherwise>
            	<a href="${webRoot}/ledger/regulatoryObject/list.do?regTypeId=${regTypeId}"  class="cs-menu-btn"><i class="icon iconfont icon-fanhui"></i>返回</a>
            	</c:otherwise>
                </c:choose>
				 </form>
            	
            </div>
          </div>
          	<div class="cs-tabtitle clearfix" id="tabtitle">
		<input type="hidden" id="getregType" name="setregType" value="${regTypeId}">
		<ul>
				<li class="cs-taba" data-tabtitleNo="1" id="stock" onclick="getData(1);" style="display: none">进货台账</li>
				<li class="cs-taba" data-tabtitleNo="1" id="sale" onclick="getData(2);" style="display: none">销售台账</li>
		</ul>
	</div>
		<div id="stockdataList" style="display: none"></div>
		<div id="saledataList" style="display: none"></div>
		
    
    <%@include file="/WEB-INF/view/common/confirm.jsp"%>
        <%@include file="/WEB-INF/view/common/modalBox.jsp"%>
    
    <!-- JavaScript -->
    <script src="${webRoot}/js/datagridUtil.js"></script>
    <script type="text/javascript">
    var htmlType='${htmlType}';
    var  ledgerType=1;//台账类型
    ledgerType='${ledgerType}';
	var businessId='${businessId}';
	var regId='${regId}';
	var  regTypeId= '${regTypeId}';
	var manaType=1;//当manaType为0时是批发市场 只有批发市场才有销售
	manaType='${manaType}';
	//打开ifream页面
	function openHtml(src) {
		if(src){
		showMbIframe(src);
		}
	}
    for(var i = 0; i < childBtnMenu.length; i++) {
			if (childBtnMenu[i].operationCode == "1396-16") {
				//新增
			 var html='<a class="cs-menu-btn" href="${webRoot}/ledger/stock/add.do?htmlType='+htmlType+'&regTypeId='+regTypeId+'&businessId='+businessId+'&regId='+regId+'"><i class="'+childBtnMenu[i].functionIcon+'"></i>新增</a>';
				$("#showBtn").append(html); 
			/* var src="${webRoot}/ledger/stock/add.do?htmlType="+htmlType+"&regTypeId="+regTypeId+"&businessId="+businessId+"&regId="+regId;
				 var html=' <a class="cs-menu-btn" href="#" onclick="openHtml(\' '+src+' \');"><i class="iconfont icon-zengjia"></i>新增</a>';
				$("#showBtn").prepend(html);  */
			}else if (childBtnMenu[i].operationCode == "1396-17") {
				//编辑
				edit = 1;
				editObj=childBtnMenu[i];
			}else if (childBtnMenu[i].operationCode == "1396-18") {
				//删除
				deletes = 1;
				deleteObj=childBtnMenu[i];
			}	else if (childBtnMenu[i].operationCode == "1396-6") {
				stock = 1;
				stockObj=childBtnMenu[i];
				$("#stock").show();
			}
			else if (childBtnMenu[i].operationCode == "1396-7" && manaType=="0") {
				sale = 1;
				saleObj=childBtnMenu[i];
				$("#sale").show();
			}
		}
		$(function(){ //默认加载进货台账数据
			if(ledgerType==2){
				$('.cs-tabtitle li:nth-child(2)').addClass('cs-tabhover').siblings().removeClass('cs-tabhover');
				getData(2);
			}else if(stock==1){
				$('.cs-tabtitle li:nth-child(1)').addClass('cs-tabhover').siblings().removeClass('cs-tabhover');
				getData(1);
			}else if(sale==1){
				$('.cs-tabtitle li:nth-child(2)').addClass('cs-tabhover').siblings().removeClass('cs-tabhover');
				getData(2);
			}else{
				$('.cs-tabtitle li:nth-child(1)').addClass('cs-tabhover').siblings().removeClass('cs-tabhover');
				getData(1);
			}
		}); 
		function getData(type) {
			if(type==1){//进货台账
				$("#saledataList").hide();
				 $("#saledataList").empty()
				$("#stockdataList").show();
				ledgerType=1;
				$("#showBtn").empty("");
				//var src="${webRoot}/ledger/stock/add.do?htmlType="+htmlType+"&regTypeId="+regTypeId+"&businessId="+businessId+"&regId="+regId;
				 //var html1=' <a class="cs-menu-btn" href="#" onclick="openHtml(\' '+src+' \');"><i class="iconfont icon-zengjia"></i>新增</a>';
				var html1='<a class="cs-menu-btn" href="${webRoot}/ledger/stock/add.do?winType=2&htmlType='+htmlType+'&businessId='+businessId+'&regId='+regId+'"><i class="icon iconfont icon-zengjia"></i>新增</a>';
				$("#showBtn").prepend(html1);
				getStock();
			}else if(type==2){//销售台账
				$("#stockdataList").hide();
				 $("#stockdataList").empty()
				$("#saledataList").show();
				ledgerType=2;
				$("#showBtn").empty("");
				//var src="${webRoot}/ledger/sale/add.do?winType=1&htmlType="+htmlType+"&regTypeId="+regTypeId+"&businessId="+businessId+"&regId="+regId;
				// var html=' <a class="cs-menu-btn" href="#" onclick="openHtml(\' '+src+' \');"><i class="iconfont icon-zengjia"></i>新增</a>';
				 var html=' <a class="cs-menu-btn" href="${webRoot}/ledger/sale/add.do?winType=2&htmlType='+htmlType+'&businessId='+businessId+'&regId='+regId+'" ><i class="iconfont icon-zengjia"></i>新增</a>';
				$("#showBtn").prepend(html);
				getSale();
			}
		}
		
		var op = "";
		//获取销售台账数据列表
		function getSale() {
			//经营单位
			var search = $("#search").val();
			op = {
				tableId : "saledataList", //列表ID
				tableAction : '${webRoot}' + "/ledger/sale/datagrid.do", //加载数据地址
				parameter : [ //列表拼接参数
					{
						columnCode : "cusRegName",
						columnName : "销售对象",
					}, {
					columnCode : "foodName",
					customElement : "<a class=\"cs-link-text sale\" href=\"javascript:;\">?</a>",
					columnName : "食品名称"
				}, {
					columnCode : "saleCount",
					columnName : "数量",
					columnWidth : "55px"
				}, {
					columnCode : "size",
					columnName : "规格",
					columnWidth : "55px",
					query : 1
				}, {
					columnCode : "saleDate",
					columnName : "销售日期",
					queryType:1
				} ,
				{
					columnCode: "create_date",
					columnName: "录入时间",
					dateFormat: "yyyy-MM-dd HH:mm:ss"

				}],
				defaultCondition : [ //默认查询条件
				{
					queryCode : "businessId",
					queryVal: '${businessId}'
				},
				{
					queryCode: "regId",
					queryVal: '${regId}'
				} ],
				funBtns : [ {
					show : edit,
					style : editObj,
					action : function(id) {
						//queryById(id);
						//self.location = '${webRoot}/ledger/sale/edit.do?id='+id;
						    var src = '${webRoot}/ledger/sale/add.do?htmlType='+htmlType+'&id='+id+'&regTypeId='+regTypeId;
    				    			showMbIframe(src);
					}
				}, {
					show : deletes,
					style : deleteObj,
					action : function(id) {
						if (id == '') {
							$("#confirm-warnning .tips").text("请选择销售台账");
							$("#confirm-warnning").modal('toggle');
						} else {
							deleteIds = id;
							$("#confirm-delete").modal('toggle');
						}
					}
				} ], //操作列按钮 
				bottomBtns : [ ], //底部按钮
			};
			datagridUtil.initOption(op);
			//datagridUtil.query();
			datagridUtil.queryByFocus();
		}
		//获取进货台账数据列表
    function getStock() {
        	//经营单位
        	var search=$("#search").val();
    		op = {
    			tableId: "stockdataList",	//列表ID
    			tableAction: '${webRoot}'+"/ledger/stock/datagrid.do",	//加载数据地址
    			parameter: [		//列表拼接参数
    				{
    					columnCode: "foodName",
    					customElement : "<a class=\"cs-link-text stock\" href=\"javascript:;\">?</a>",
    					columnName: "食品名称"
    				},
    				{
    					columnCode: "stockCount",
    					columnName: "数量",
    					columnWidth : "55px"
    				},
    				{
    					columnCode: "size",
    					columnName: "规格",
    					columnWidth : "55px",
    					query: 1
    				},
    				{
    					columnCode: "param1",
    					columnName: "来源市场",
    					query: 1
    				},
    				{
        				columnCode: "supplier",
        				columnName: "供应商",
        			},
        		
        			{
    					columnCode: "productionPlace",
    					columnName: "产地",
    					query: 1
    				},
        			{
    					columnCode: "batchNumber",
    					columnName: "批次",
    					query: 1
    				},
    				{
    					columnCode: "stockDate",
    					columnName: "进货日期",
    					queryType:1
    				},
    				{
    					columnCode: "create_date",
    					columnName: "录入时间",
    					queryType:1,
    					dateFormat: "yyyy-MM-dd HH:mm:ss"

    				}
    			],
    			defaultCondition: [	//默认查询条件
    				{
    					queryCode: "businessId",
    					queryVal: '${businessId}'
    				},
    				{
    					queryCode: "regId",
    					queryVal: '${regId}'
    				}
    			],
    			funBtns: [
    				    	{
    				    		show: edit,
    				    		style: editObj,
    				    		action: function(id){
    				    		//	self.location = '${webRoot}/ledger/stock/edit.do?id='+id;
    				    		    var src = '${webRoot}/ledger/stock/edit.do?htmlType='+htmlType+'&id='+id+'&regTypeId='+regTypeId;
    				    			showMbIframe(src);
    				    		}
    				    	},
    				    	{
    				    		show: deletes,
    				    		style: deleteObj,
    				    		action: function(id){
    				    			if(id == ''){
    	    			    			$("#confirm-warnning .tips").text("请选择台账记录");
    	    			    			$("#confirm-warnning").modal('toggle');
        			    			}else{
    	    			    			deleteIds = id;
    	    			    			$("#confirm-delete").modal('toggle');
        			    			}
    				    		}
    				    	}
    				    ],	//操作列按钮 
    		    bottomBtns: [
    			   
    			    ],	//底部按钮
    		};
    	datagridUtil.initOption(op);
       //datagridUtil.query();
    	datagridUtil.queryByFocus();
	}
	//查看台账数据
	$(document).on("click", ".stock", function() {
		//self.location = '${webRoot}/ledger/stock/edit.do?showType=1&id=' + $(this).parents(".rowTr").attr("data-rowId");
		 var src = '${webRoot}/ledger/stock/edit.do?htmlType='+htmlType+'&showType=1&id=' + $(this).parents(".rowTr").attr("data-rowId")+'&regTypeId='+ regTypeId;
			showMbIframe(src);
	});
	$(document).on("click", ".sale", function() {
		//self.location = '${webRoot}/ledger/stock/edit.do?showType=1&id=' + $(this).parents(".rowTr").attr("data-rowId");
		 var src = '${webRoot}/ledger/sale/edit.do?htmlType='+htmlType+'&showType=1&id=' + $(this).parents(".rowTr").attr("data-rowId")+'&regTypeId='+ regTypeId;
			showMbIframe(src);
	});
	
    //删除
    var deleteIds = "";
    function deleteData(){
    	if(ledgerType==2){
    	$.ajax({
	        type: "POST",
	        url: '${webRoot}'+"/ledger/sale/delete.do",
	        data: {"ids":deleteIds.toString()},
	        dataType: "json",
	        success: function(data){
	        	if(data && data.success){
	        		self.location = "${webRoot}/ledger/stock/list.do?ledgerType=2&regId=" + regId + "&businessId="
					+ businessId;
	        	}else{
	        		$("#confirm-warnning .tips").text("删除失败");
	    			$("#confirm-warnning").modal('toggle');
	        	}
			}
	    });
		$("#confirm-delete").modal('toggle');
    	}else{
    		$.ajax({
    	        type: "POST",
    	        url: '${webRoot}'+"/ledger/stock/delete.do",
    	        data: {"ids":deleteIds.toString()},
    	        dataType: "json",
    	        success: function(data){
    	        	if(data && data.success){
    	        		self.location = "${webRoot}/ledger/stock/list.do?ledgerType=1&regId=" + regId + "&businessId="
						+ businessId;
    	        	}else{
    	        		$("#confirm-warnning .tips").text("删除失败");
    	    			$("#confirm-warnning").modal('toggle');
    	        	}
    			}
    	    });
    		$("#confirm-delete").modal('toggle');
    	}
    }
    
    $(document).on("click",".qrcode",function(){
    	viewQrcode($(this).attr("data-value"));
    });
    
    </script>
  </body>
</html>
