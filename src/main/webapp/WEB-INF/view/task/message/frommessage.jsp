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
              <li class="cs-fl">
              <img src="${webRoot}/img/set.png" alt="" />
              <li class="cs-fl">信息发布
              </li>
              <li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
              <li class="cs-b-active cs-fl">已发布
              </li>
            </ol>
            
          <!-- 面包屑导航栏  结束-->
           <div class="cs-search-box cs-fr">
              <form action="">
                
                <div class="cs-search-filter clearfix cs-fl">
                <input class="cs-input-cont cs-fl focusInput" type="text" placeholder="请输入搜索内容..." name="tbTaskMessgae.content" />
                <input type="button" class="cs-search-btn cs-fl" href="javascript:;" value="搜索" onclick="datagridUtil.queryByFocus();">
                
                </div>
                <div class="cs-fr cs-ac">
                <a class="cs-menu-btn" href="${webRoot}/taskMessage/sendmessage" data-toggle="modal" name="content_frm"><i class="icon iconfont icon-zengjia"></i>发布</a>
              </div>
              </form>
              
            </div>
            
          </div>
      <div class="cs-tb-box">

      
      <div class="cs-content2 clearfix cs-main-content">
          <div class="cs-right-content">
            <div class="cs-toolbg cs-text-nowrap">
              <div class="cs-txt_title cs-fl">
              已发送
              <span id="_ut" class="f_size normal black">   (共&nbsp;
              <span id="allmessage" class="green">
              </span>&nbsp;封
              <span id="_ua" style="  display:;  ">
              </span>)
              </span>
              
              </div>
           
            </div>
            <div id="dataList" class="cs-mail-topPad"></div>
            <!-- 底部导航 开始 -->
      </div>
       <!-- 底部导航 结束 -->
          </div>
      </div>

      </div>
	<!-- Modal 提示窗-删除-->
	<div class="modal fade intro2" id="confirm-delete" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog cs-alert-width">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
					<h4 class="modal-title" id="myModalLabel">确认删除</h4>
				</div>
				<div class="modal-body cs-alert-height cs-dis-tab">
					<div class="cs-text-algin">
						<img src="${webRoot}/img/stop2.png" width="40px"/>确认删除该记录吗？
					</div>
				</div>
				<div class="modal-footer">
					<a class="btn btn-danger btn-ok" onclick="deleteByID()">删除</a>
					<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
				</div>
			</div>
		</div>
	</div>
    <!-- JavaScript -->
    <%@include file="/WEB-INF/view/common/confirm.jsp"%>
  	<script src="${webRoot}/js/select/tabcomplete.min.js"></script>
    <script src="${webRoot}/js/select/livefilter.min.js"></script>
    <script src="${webRoot}/js/select/bootstrap-select.js"></script>
   	<script src="${webRoot}/js/datagridUtil.js"></script>
   	
   	<script type="text/javascript">
   	
   	var view=0;
    var viewObj;
    var del=0;
    var delObj;
    var deleteId;
    var download=0;
    var downloadObj;
  //遍历操作权限
    for (var i = 0; i < childBtnMenu.length; i++) {
		if (childBtnMenu[i].operationCode == "1536-1") {
			view = 1;
			viewObj=childBtnMenu[i];
		}else if(childBtnMenu[i].operationCode == "1536-3"){
			del = 1;
			delObj=childBtnMenu[i];
		}else if(childBtnMenu[i].operationCode == "1536-2"){
			download = 1;
			downloadObj=childBtnMenu[i];
		}
		
	} 
  
   	var op={
			tableId: "dataList",	//列表ID
			tableAction: '${webRoot}'+"/message/frommessage.do",	//加载数据地址
            funColumnWidth: '100px',
			onload: function(){
		    	$("#allmessage").text(datagridOption["rowTotal"]);
		    	var obj = datagridOption["obj"];
		    	$(".rowTr").each(function(){
			    	for(var i=0;i<obj.length;i++){
			    		if($(this).attr("data-rowId") == obj[i].id){
				    		if(obj[i].filename==""){
				    			//隐藏下载按钮
				    			$(this).find(".1536-2").hide();
				    		}
				    		break;
			    		}
			    	}
		    	});
		    },
			parameter: [		//列表拼接参数
					{
						columnCode: "departName",
						columnName: "收件人",
						columnWidth:'15%'
					},
					{
						columnCode: "content",
						columnName: "任务内容",
						query: 1,
						columnWidth:'30%',
						queryCode: "tbTaskMessgae.content"
					},
					{
						columnCode: "filename",
						columnName: "附件",
						columnWidth:'15%',
						customStyle:'cs-td-width cs-text-nowrap'
					},
					{
						columnCode: "sendtime",
						columnName: "时间",
						columnWidth:'15%',
						dateFormat : "yyyy-MM-dd HH:mm:ss",
						queryType : 3
					},{
                    columnCode: "title",
                    columnName: "短信通知",
                    customVal: {0: "<span class='text-danger'>否</span>", 1: "<span class='text-success'>是</span>"},
                    columnWidth: '60px'
                }
				
			],funBtns: [
				{	//查看按钮
		    		show: view,
		    		style: viewObj,
		    		action: function(id){
		    			window.location = '${webRoot}'+"/taskMessage/frommessagedetail.do?id="+id;
		    		}
		    	},{
		    		show: download,
		    		style: downloadObj,
		    		action: function(id){
		    			self.location = '${webRoot}/message/download.do?id='+id;
		    		}
		    	},
		    	{
		    		//删除按钮
		    		show: del,
		    		style: delObj,
		    		action: function(id){
		    			deleteId = id;
		  				$("#confirm-delete").modal('toggle');
		    		}
		    	}
		    ]
			
		};
	datagridUtil.initOption(op);
    datagridUtil.query();
    
  //删除函数
    function deleteByID(){
    	$.ajax({
	        type: "POST",
	        url: '${webRoot}'+"/message/delete.do",
	        data: {"id":deleteId},
	        success: function(data){
	        	if(data && data.success){
	        		//删除成功后刷新列表
	        		datagridUtil.query();
	        	}
			},
			error: function(){
				console.log("删除失败!");
			}
	    });
			$("#confirm-delete").modal('toggle');
		}
   	</script>
</body>
</html>