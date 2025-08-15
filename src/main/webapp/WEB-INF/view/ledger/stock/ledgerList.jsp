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
              <li class="cs-fl">
              <img src="${webRoot}/img/set.png" alt="" />
              <a href="javascript:">台账数据</a></li>
              <c:if test="${!empty regName }">
              <li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
              </c:if>
              <li class="cs-b-active cs-fl">${regName }
              <c:if test="${!empty bus.opeShopName}">
              <li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
              <li class="cs-b-active cs-fl">${bus.opeShopName}
              <li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
              <li class="cs-b-active cs-fl">台账管理
              </li></c:if>
            </ol>
            <div class="cs-input-style cs-fl " style="margin: 3px 0 0 30px;">
			监管对象类型:
			<select  id="regType"  onchange="load();"   style="padding-left:8px;    width: 120px;"> 
								<option value="">--请选择--</option>
									<c:forEach items="${regulatoryTypes}" var="type">
										<option value="${type.id}" <c:if test="${regTypeId==type.id}"> selected</c:if>>${type.regType}</option>
									</c:forEach>
							</select>
			<input name="departids" type="hidden">
			</div>
			
         <%--     <div class="cs-input-style cs-fl " style="margin: 3px 0 0 30px;">
			选择市场:
			<select name="regId" id="regId" onchange="changeReg()"  style="padding-left:8px;"> 
									<option value="">--请选择--</option>
									<c:forEach items="${regObj}" var="reg">
										<option value="${reg.id}" data-name="${reg.regName}" data-mType="${reg.managementType}" data-user="${reg.linkUser}" <c:if test="${reg.id==bean.regId }">selected</c:if> <c:if test="${reg.id==regId}">selected</c:if> data-phone="${reg.linkPhone }">${reg.regName}</option>
									</c:forEach>
							</select>
			<input name="departids" type="hidden">
		</div>  --%>
			<div class="cs-input-style cs-fl " style="margin: 3px 0 0 30px;">
					<span class="cs-name">时间范围:</span> 
					<span class="cs-in-style cs-time-se cs-time-se">
						<input name="stockDateStartDate" id="start" style="width: 110px;" class="cs-time Validform_error focusInput" type="text" onclick="WdatePicker({maxDate:'#F{$dp.$D(\'end\')}'})" datatype="date"  value="<fmt:formatDate value='<%=new Date()%>' pattern='yyyy-MM-dd'/>"  autocomplete="off"> 
						<span style="padding: 0 5px;">至</span> 
						<input name="stockDateEndDate" id="end" style="width: 110px;" class="cs-time Validform_error focusInput" type="text" onclick="WdatePicker({maxDate:'%y-%M-%d',minDate:'#F{$dp.$D(\'start\')}'})" datatype="date" value="<fmt:formatDate value='<%=new Date()%>' pattern='yyyy-MM-dd'/>"    autocomplete="off">
						&nbsp;
					</span>
					</div>
				</span> 
          <!-- 面包屑导航栏  结束-->
            <div class="cs-search-box cs-fr">
              <form>
                <input class="cs-input-cont cs-fl focusInput" type="text" id="search"    name="search" placeholder="请输入食品名称" />
                <input type="button" onclick="query();" class="cs-search-btn cs-fl" href="javascript:;" value="搜索">
                <span class="cs-s-search cs-fl">高级搜索</span>
               <c:if test="${!empty regId }"> <a class="cs-menu-btn" href="javascript:" onclick="self.location.href='${webRoot}/ledger/regulatoryObject/ledgerList.do?regTypeCode=0'"><i class="icon iconfont icon-fanhui"></i>返回</a></c:if>
                <div class="clearfix cs-fr" id="showBtn">
                </div>
                </form>
            </div>
          </div>
          	<div class="cs-tabtitle clearfix" id="tabtitle" style="height:39px;padding-top:4px;">
		<input type="hidden" id="getregType" name="setregType" value="${regTypeId}">
		<ul>
				<li class="cs-taba" data-tabtitleNo="1" id="stock" onclick="getData(1);" >进货台账</li>
				<li class="cs-taba" data-tabtitleNo="1" style="display: none" id="sale" onclick="getData(2);">销售台账</li>
		</ul>
	</div>
		<div id="stockdataList" style="display: none"></div>
		<div id="saledataList" style="display: none"></div>
		
    
    <%@include file="/WEB-INF/view/common/confirm.jsp"%>
    <%@include file="/WEB-INF/view/common/modalBox.jsp"%>
    
    <!-- JavaScript -->
    <script src="${webRoot}/js/datagridUtil.js"></script>
    <script type="text/javascript">
    var  ledgerType=1;//台账类型
    ledgerType='${ledgerType}';
	var businessId='${businessId}';
	var  regTypeId= '${regTypeId}';
	var regId=$('#regId option:selected').val();
	var manaType=1;//当manaType为0时是批发市场 只有批发市场才有销售
	manaType='${ledgerType}';
	if(manaType==0||manaType==2){
		$("#sale").show();
	}else{
		$("#sale").hide();
	}
	function openHtml(src) {
		if(src){
		showMbIframe(src);
		}
	}
	var view = 0;
	var viewObj;
    for(var i = 0; i < childBtnMenu.length; i++) {
			if (childBtnMenu[i].operationCode == "1396-16") {
				//新增
			/* 	var src='${webRoot}/ledger/stock/add.do?htmlType=3&regTypeId='+regTypeId+'&businessId='+businessId+'&regId='+regId;
				 var html=' <a class="cs-menu-btn" href="#" onclick="openHtml(\' '+src+' \');"><i class="iconfont icon-zengjia"></i>新增</a>';
				$("#showBtn").append(html);  */
			}else if (childBtnMenu[i].operationCode == "1396-17") {
				//编辑
				edit = 1;
				editObj=childBtnMenu[i];
			}/* else if (childBtnMenu[i].operationCode == "1396-18") {
				//删除
				deletes = 1;
				deleteObj=childBtnMenu[i];
			} */else if (childBtnMenu[i].operationCode == "1409-4") {
				//查看
				view = 1;
				viewObj = childBtnMenu[i];
			}	else if (childBtnMenu[i].operationCode == "1396-61") {
				stock = 1;
				stockObj=childBtnMenu[i];
				$("#stock").show();
			}
			else if (childBtnMenu[i].operationCode == "1396-71" && manaType=="0") {
				sale = 1;
				saleObj=childBtnMenu[i];
				$("#sale").show();
			}
		}
		$(function(){ //默认加载进货台账数据
				$("#start").val(getBeforeDate(3));
				query();
		}); 
		
		function query() {
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
		}
		function getData(type) {
			if(type==1){//进货台账
				$("#saledataList").hide();
				 $("#saledataList").empty()
				$("#stockdataList").show();
				ledgerType=1;
			/* 	$("#showBtn").empty("");
				var src=' ${webRoot}/ledger/stock/add.do?htmlType=3&regTypeId='+regTypeId+'&businessId='+businessId+'&regId='+regId ;
				 var html1=' <a class="cs-menu-btn" href="#" onclick="openHtml(\' '+src+' \');"><i class="iconfont icon-zengjia"></i>新增</a>';
					$("#showBtn").append(html1); */
				getStock();
			}else if(type==2){//销售台账
				$("#stockdataList").hide();
				 $("#stockdataList").empty()
				$("#saledataList").show();
				ledgerType=2;
			/* 	$("#showBtn").empty("");
				var src='${webRoot}/ledger/sale/add.do?htmlType=3&regTypeId='+regTypeId+'&businessId='+businessId+'&regId='+regId;
				 var html=' <a class="cs-menu-btn" href="#" onclick="openHtml(\' '+src+' \');"><i class="iconfont icon-zengjia"></i>新增</a>';
					$("#showBtn").append(html); */
				getSale();
			}
		}
		//获取销售台账数据列表
		function getSale() {
			var op = "";
			//经营单位
			var search = $("#search").val();
			var regTypeId=$("#regType option:selected").val();
			 var start=$("#start").val();
			 var	 end=$("#end").val();
			op = {
				tableId : "saledataList", //列表ID
				tableAction : '${webRoot}' + "/ledger/sale/datagrid.do", //加载数据地址
				parameter : [ //列表拼接参数
					{
						columnCode : "reg_name",
						columnName : "市场/企业",
						query : 1
					},{
						columnCode : "opeShopCode",
						columnName : "档口",
						query : 1
					},{
						columnCode : "cusRegName",
						columnName : "销售对象",
						query : 1
					}, {
					columnCode : "foodName",
					customElement : "<a class=\"cs-link-text sale\" href=\"javascript:;\">?</a>",
					columnName : "食品名称",
					query : 1
				}, {
					columnCode : "saleCount",
					columnName : "数量",
					columnWidth : "55px"
				}, {
					columnCode : "size",
					columnName : "规格",
					columnWidth : "55px"
				}, {
					columnCode : "saleDate",
					columnName : "销售日期",
					queryType:1
				},
				{
					columnCode: "create_date",
					columnName: "录入时间",
					dateFormat: "yyyy-MM-dd HH:mm:ss"

				} 
				],
				defaultCondition : [ //默认查询条件
				{
					queryCode : "businessId",
					queryVal: '${businessId}'
				},
				{
					queryCode : "regtype",
					queryVal: regTypeId
				},
				{
					queryCode : "saleDateStartDate",
					queryVal: $("#start").val()
				},
				{
					queryCode : "saleDateEndDate",
					queryVal: $("#end").val()
				}],
				funBtns : [
					{
						show : view,
						style : viewObj,
						action : function(id) {
							//queryById(id);
						//	self.location = '${webRoot}/ledger/sale/edit.do?id='+id+'&showType=1';
							var src = '${webRoot}/ledger/sale/edit.do?htmlType=3&id='+id+'&regTypeId='+regTypeId;
			    			showMbIframe(src);
						}
					}, {
					show : edit,
					style : editObj,
					action : function(id) {
						//queryById(id);
						var src = '${webRoot}/ledger/sale/edit.do?htmlType=3&id='+id+'&regTypeId='+regTypeId;
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
	
		
		function getBeforeDate(n){
			var date = new Date() ;
			var year,month,day ;
			date.setDate(date.getDate()-n);
			year = date.getFullYear();
			month = date.getMonth()+1;
			day = date.getDate() ;
			s = year + '-' + ( month < 10 ? ( '0' + month ) : month ) + '-' + ( day < 10 ? ( '0' + day ) : day) ;
			return s ;
		} 
		//获取进货台账数据列表
    function getStock() {
    	var op = "";
        	//经营单位
        	var search=$("#search").val();
        	var regTypeId=$("#regType option:selected").val();
        	 var start=$("#start").val();
			 var	 end=$("#end").val();
    		op = {
    			tableId: "stockdataList",	//列表ID
    			tableAction: '${webRoot}'+"/ledger/stock/datagrid.do",	//加载数据地址
    			parameter: [		//列表拼接参数
    				{
    					columnCode: "reg_name",
    					columnName: "市场",
    					query : 1
    				},
    				{
    					columnCode: "opeShopCode",
    					columnName: "档口",
    					query : 1
    				},
    				{
    					columnCode: "foodName",
    					customElement : "<a class=\"cs-link-text stock\" href=\"javascript:;\">?</a>",
    					columnName: "食品名称",
    					query : 1
    				},
    				{
    					columnCode: "stockCount",
    					columnName: "数量",
    					columnWidth : "55px"
    				},
    				{
    					columnCode: "size",
    					columnName: "规格",
    					columnWidth : "55px"
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
    					columnName: "产地"
    				},
        			{
    					columnCode: "batchNumber",
    					columnName: "批次"
    				},
    				{
    					columnCode: "stockDate",
    					columnName: "进货日期",
    					queryType:1
    				},
    				{
    					columnCode: "create_date",
    					columnName: "录入时间",
    					dateFormat: "yyyy-MM-dd HH:mm:ss"

    				}
    			],
    			defaultCondition: [	//默认查询条件
    				{
    					queryCode: "businessId",
    					queryVal: '${businessId}'
    				},
    				{
    					queryCode : "regtype",
    					queryVal: regTypeId
    				},
    				{
    					queryCode : "stockDateStartDate",
    					queryVal: start
    				},
    				{
    					queryCode : "stockDateEndDate",
    					queryVal: end
    				}],
    			funBtns: [{
					show : view,
					style : viewObj,
					action : function(id) {
						//queryById(id);
						self.location = '${webRoot}/ledger/stock/edit.do?htmlType=3&id='+id+'&showType=1&regTypeId='+regTypeId;
					}
				},{
    				    		show: edit,
    				    		style: editObj,
    				    		action: function(id){
    				    			//self.location = '${webRoot}/ledger/stock/edit.do?id='+id;
    				    var src = '${webRoot}/ledger/stock/edit.do?htmlType=3&id='+id+'&regTypeId='+regTypeId;
    				    			showMbIframe(src)
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
		var regTypeId=$("#regType option:selected").val();
		//self.location = '${webRoot}/ledger/stock/edit.do?showType=1&id=' + $(this).parents(".rowTr").attr("data-rowId");
		 var src = '${webRoot}/ledger/stock/edit.do?htmlType=3&showType=1&id=' + $(this).parents(".rowTr").attr("data-rowId")+'&regTypeId='+ regTypeId;
			showMbIframe(src);
	});
	$(document).on("click", ".sale", function() {
		var regTypeId=$("#regType option:selected").val();
		//self.location = '${webRoot}/ledger/stock/edit.do?showType=1&id=' + $(this).parents(".rowTr").attr("data-rowId");
		 var src = '${webRoot}/ledger/sale/edit.do?htmlType=3&showType=1&id=' + $(this).parents(".rowTr").attr("data-rowId")+'&regTypeId='+ regTypeId;
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
	        		self.location = "${webRoot}/ledger/stock/ledgerList.do?ledgerType=2&regId=" + regId + "&businessId="
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
    	        		self.location = "${webRoot}/ledger/stock/ledgerList.do?ledgerType=1&regId=" + regId + "&businessId="
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
    //切换市场
    	function	changeReg(){
    	var title = $(".cs-tabhover").html();
   		 var  mType=	$("#regId").find("option:selected").attr("data-mType");
   		if(mType==1){
    		$("#sale").hide();
    		$('.cs-tabtitle li:nth-child(1)').addClass('cs-tabhover').siblings().removeClass('cs-tabhover');
    		}else{
    		$("#sale").show();	
    		}
    	if(title=='进货台账'){
    		 getStock();
    	}else{
    		if(mType==0){
    		getSale();
    		}
    	}
   		 }
   		 
   		function load() {
   			var regTypeId=$("#regType option:selected").val();
   			$("#regId").html("");
   			 $.ajax({
    	        type: "POST",
    	        url: '${webRoot}'+"/ledger/stock/queryAllObj.do",
    	        data: {"regTypeId":regTypeId},
    	        dataType: "json",
    	        success: function(data){
    	        	if(data.obj){
    	        		var html = "<option value=''>请选择</option>";
    	        		$.each(data.obj, function(index, item) {
    	        			var d = data.obj[index];
    	        			html += '<option value="' + d.id + '" <c:if test="d.id==num">selected</c:if>     data-name="'
    	        					+ d.regName + '" data-mType="' + d.managementType + '" data-user="' + d.linkUser + '">'
    	        					+ d.regName + '</option>';
    	        		});
    	        		$("#regId").html(html);
    	        	}
    	        	var title = $(".cs-tabhover").html();
    	           	if(title=='进货台账'){
    	           		 getStock();
    	           	}else{
    	           		getSale();
    	           	}
    			}
    	    }); 
   			 
   		}
   		
   		
   	//$("#opeId").empty();
	
    </script>
  </body>
</html>
