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
              <li class="cs-fl">
              <img src="${webRoot}/img/set.png" alt="" />
              <a href="javascript:">汇总统计</a></li>
              <li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
              <li class="cs-b-active cs-fl">送检单
              </li>
            </ol>
          <!-- 面包屑导航栏  结束-->
            <div class="cs-search-box cs-fr">
              <form action="list.do" method="post">
                
                <div class="cs-search-filter clearfix cs-fl">
                <input class="cs-input-cont cs-fl focusInput" type="text" name="search" placeholder="请输入内容" />
                <input type="button" class="cs-search-btn cs-fl" onclick="datagridUtil.queryByFocus()" href="javascript:;" value="搜索">
                <span class="cs-s-search cs-fl">高级搜索</span>
                </div>
                <div class="clearfix cs-fr" id="showBtn">
                 <a class="cs-menu-btn " href="javascript:" onclick="self.history.back();"><i class="icon iconfont icon-fanhui"></i>返回</a>
              </div>
              </form>
            </div>
          </div>

           <!-- 列表 -->
           <div id="dataList"></div>
      <!-- 内容主体 结束 -->


<!-- Modal 3 小-->
	<form id="samplingDateForm">
	<div class="modal fade intro2" id="resetSamplingDate" tabindex="-1" role="dialog" aria-labelledby="rsdModalLabel">
		<div class="modal-dialog cs-sm-width" role="document">
			<div class="modal-content ">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
					<h4 class="modal-title" id="rsdModalLabel">修改送样时间</h4>
				</div>
				<div class="modal-body cs-alert-height">
					<!-- 主题内容 -->
					<div class="cs-tabcontent" >
						<div class="cs-content2">
							<div class=" cs-warn-box clearfix">
								<!-- <h5 class="cs-title-s">预警设置</h5> -->
								<div class="cs-fl cs-warn-r cs-in-style">
									<input name="id" type="hidden">
									送样时间：<input name="sDate" class="cs-time" type="text" onclick="WdatePicker({startDate:'%y-%M-%d %H:%m:%s',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})">
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-success rsdBtn">确定</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				</div>
			</div>
		</div>
	</div>
	</form>
    <%@include file="/WEB-INF/view/common/modalBox.jsp"%>
    <%@include file="/WEB-INF/view/common/confirm.jsp"%>
    <%@include file="/WEB-INF/view/common/map.jsp"%>

    <!-- JavaScript -->
    <script src="${webRoot}/js/datagridUtil.js"></script>
    <script type="text/javascript">
    rootPath="${webRoot}/sampling/";
    var detect=0;
    var detectObj;
    var issued=0;
    var issuedObj;
    var position=0;
    var positionObj;
    var resetSamplingDate=0;
    var resetSamplingDateObj;
    for (var i = 0; i < childBtnMenu.length; i++) {
		if (childBtnMenu[i].operationCode == "1420-1") {
			var html='<a class="cs-menu-btn" onclick="showMbIframe(\'${webRoot}/sampling/addSendSample.do\')"><i class="'+childBtnMenu[i].functionIcon+'"></i>新增</a>';
			$("#showBtn").prepend(html);
		}else if (childBtnMenu[i].operationCode == "1420-4") {//抽样单
			edit = 1;
			editObj=childBtnMenu[i];
		}else if (childBtnMenu[i].operationCode == "1420-5") {//检测单
			detect = 1;
			detectObj=childBtnMenu[i];
		}else if (childBtnMenu[i].operationCode == "1420-3") {
			deletes = 1;
			deleteObj=childBtnMenu[i];
		}else if (childBtnMenu[i].operationCode == "1420-7") {//下发
			issued = 1;
			issuedObj=childBtnMenu[i];
		}else if (childBtnMenu[i].operationCode == "1420-6") {//定位
			position = 1;
			positionObj=childBtnMenu[i];
		}else if (childBtnMenu[i].operationCode == "1420-8") {//修改送检时间
			resetSamplingDate = 1;
			resetSamplingDateObj=childBtnMenu[i];
		}
		
	}
	var op = {
		tableId: "dataList",	//列表ID
		tableAction: '${webRoot}'+"/wx/account/datagrid2.do",	//加载数据地址
		defaultCondition: [
			{
				"queryCode" : "id",
				"queryVal": '${wx.id}'
			}
		],
		parameter: [		//列表拼接参数
			{
				columnCode: "samplingNo",
				columnName: "送样单号",
				query: 1,
				queryCode: "samplingNo",
				customElement: "<a class='text-primary cs-link samplingNoI'>?<a>"
			},
			{
				columnCode: "accountName",
				columnName: "公众号",
			},
			{
				columnCode: "regName",
				columnName: "送检人",
				query: 1,
				queryCode: "regName"
			},
			{
				columnCode: "regLinkPhone",
				columnName: "联系电话"
			},
			
			{
				columnCode: "samplingDate",
				columnName: "送样时间",
				queryType: 1,
				columnWidth: '200px',
				dateFormat: "yyyy-MM-dd HH:mm:ss"
			},
			{
				columnCode: "total",
				columnName: "总批次",
				columnWidth: '60px'
			},
			{
				columnCode: "completionNum",
				columnName: "已完成",
				columnWidth: '60px'
			},
			{
				columnCode: "samplingUsername",
				columnName: "抽样人"
			},
			
		],
		funBtns: [
			{
				show: position,
				style: positionObj,
				action: function(id){
					//window.location = "${webRoot}/sampling/samplingMap.do?samplingId="+id;
					
					var obj = datagridOption["obj"];
	    		    for(var i=0;i<obj.length;i++){
	    		   		if(id == obj[i].id){
		    		    	console.log(obj[i].id);
	    		   			mapX=obj[i].placeX;
	    		   			mapY=obj[i].placeY;
			    			$('#position').modal("show");
	    		   		}
	    		   	}
				}
			},
			{
				show: edit,
	    		style: editObj,
	    		action: function(id){
	    			showMbIframe("${webRoot}/sampling/toWord.do?id="+ id+"&type=detail");
	    		}
	    	},
	    	{
	    		show: detect,
	    		style: detectObj, 
	    		action: function(id){
	    			showMbIframe("${webRoot}/sampling/toWord.do?id="+ id+"&type=report");
	    		}
	    	},{
	    		show: deletes,
	    		style: deleteObj, 
	    		action: function(id){
	    			idsStr="{\"ids\":\""+id.toString()+"\"}";
	    			$("#confirm-delete").modal('toggle');
	    		}
	    	},{
	    		show: issued,
	    		style: issuedObj, 
	    		action: function(id){
	    			$.ajax({
	    		        type: "POST",
	    		        url: rootPath+"issuedTask.do",
	    		        data: {"id":id},
	    		        dataType: "json",
	    		        success: function(data){
    		        		$("#waringMsg>span").html(data.msg);
    		        		$("#confirm-warnning").modal('toggle');
	    				}
	    		    });
	    		}
	    	},{
	    		show: resetSamplingDate,
	    		style: resetSamplingDateObj, 
	    		action: function(id){
					$("#resetSamplingDate input[name='id']").val(id);
					$("#resetSamplingDate").modal('toggle');
	    		}
	    	}
	    	
	    ],
		bottomBtns: [
			{	//删除函数	
					show: deletes,
					style: deleteObj,
		    		action: function(ids){
		    			idsStr = "{\"ids\":\""+ids.toString()+"\"}";
		    			$("#confirm-delete").modal('toggle');
		    		}
		    }
		]
	};
	datagridUtil.initOption(op);
	
    datagridUtil.query();
    
    //刷新，iframe调用
    function refreshData(){
    	datagridUtil.query();
    }
    
    //查看抽样单明细
    $(document).on("click",".samplingNoI",function(){
    	showMbIframe("${webRoot}/samplingDetail/details.do?id="+$(this).parents(".rowTr").attr("data-rowId"));
    });
    
    //修改抽样时间
    $(document).on("click",".rsdBtn",function(){
    	$.ajax({
	        type: "POST",
	        url: "${webRoot}/sampling/resetSamplingDate.do",
	        data: $("#samplingDateForm").serialize(),
	        dataType: "json",
	        success: function(data){
	        	if(data.success){
	        		//刷新列表
	        		datagridUtil.query();
	        	}
	        	$("#resetSamplingDate").modal('toggle');
	        	$("#waringMsg>span").html(data.msg);
	        	$("#confirm-warnning").modal('toggle');
			}
	    });
    });
    
    
    </script>
  </body>
</html>
