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
              <a href="javascript:">任务管理</a></li>
              <li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
              <li class="cs-b-active cs-fl">每月任务详情
              </li>
            </ol>
          <!-- 面包屑导航栏  结束-->
             <div class="cs-search-box cs-fr">
              <form action="">
                <div class="cs-search-filter clearfix cs-fl">
                <input class="cs-input-cont cs-fl focusInput" type="text" placeholder="请输入任务名称" name="task.taskTitle">
                <input type="button" class="cs-search-btn cs-fl" href="javascript:;" value="搜索" onclick="datagridUtil.queryByFocus();">
                </div>
                <div class="cs-fr cs-ac">
                <a href="${webRoot}/task/statisticsList.do" class="cs-menu-btn"><i class="icon iconfont icon-fanhui"></i>返回</a>
              </div>
              </form>
            </div>
            
          </div>

		<div class="cs-tabtitle clearfix" id="tabtitle">
			<ul>
				<li class="cs-tabhover" data-tabtitleNo="1">下发任务</li>
				<li data-tabtitleNo="2">接收任务</li>
			</ul>
		</div>
		<div class="cs-tabcontent clearfix">
			<div class="cs-content2">
				<div id="dataList1"></div>
			</div>
		</div>
		<div class="cs-tabcontent clearfix cs-hide">
			<div class="cs-content2">
				<div id="dataList2"></div>
			</div>
		</div>
	
	<!-- 引用模态框 -->
	<%@include file="/WEB-INF/view/common/confirm.jsp"%>
    
    <!-- JavaScript -->
    <script src="${webRoot}/js/datagridUtil.js"></script>
    <script type="text/javascript">
    // /dataCheck/recording/list.do
    var taskDate="${taskDate}";
	var view=0;
	var viewObj;
	for (var i = 0; i < childBtnMenu.length; i++) {
		 if (childBtnMenu[i].operationCode == "202-06") {
			//查看
			view = 1;
			viewObj=childBtnMenu[i];
		}
	}
	
	var op1 = {
		tableId: "dataList",	//列表ID
		tableAction: '${webRoot}'+"/task/datagrid.do",	//加载数据地址
		parameter: [		//列表拼接参数
			{
				columnCode: "taskCdate",
				columnName: "任务名称",
				queryType: 1,
				queryCode: "task.taskCdate",
				columnWidth: "15%",
				dateFormat: "yyyy-MM"
			},
			{
				columnCode: "taskAnnouncerName",
				columnName: "下发批次",
				columnWidth: "10%"
			},
			{
				columnCode: "taskStatus",
				columnName: "完成批次",
				query: 1,
				columnWidth: "8%"
			},
			{
				columnCode: "taskTotal",
				columnName: "下发检测点",
				columnWidth: "10%"
				
			},
			{
				columnCode: "",
				columnName: "完成检测点",
				columnWidth: "10%",
				customElement: "?%"
			},
			{
				columnCode: "",
				columnName: "完成进度",
				columnWidth: "10%",
				customElement: "?%"
			}
		],
		funBtns: [//操作列按钮 
			{//查看
				show: view,
				style: viewObj,
				action: function(id){
					var obj = datagridOption.obj;
					if(obj){
						for(var i=0;i<obj.length;i++){
							if(obj[i].id == id){
				    			self.location = '${webRoot}/task/goAddTask.do?id='+id; 
								break;
							}
						}
					}
				}
			}
	    ],
	    onload: function(){
	    	//加载列表后执行函数
	    	var obj = datagridOption["obj"];
	    	alert("123:${taskDate}")
	    	$(".rowTr").each(function(){
		    	for(var i=0;i<obj.length;i++){
		    		if($(this).attr("data-rowId") == obj[i].id){
			    		if(obj[i].taskStatus == '0'){
			    			//暂存
			    			//隐藏查看按钮
			    			$(this).find(".202-06").hide();
			    			//隐藏终止按钮
			    			$(this).find(".202-5").hide();
			    		}else if(obj[i].taskStatus == '1'){
			    			//已下达
			    			//隐藏编辑按钮
			    			$(this).find(".202-2").hide();
			    			//隐藏删除按钮
			    			$(this).find(".202-3").hide();
			    			//隐藏下达按钮
			    			$(this).find(".202-4").hide();
			    		}else{
			    			//隐藏终止按钮
			    			$(this).find(".202-5").hide();
			    			//隐藏编辑按钮
			    			$(this).find(".202-2").hide();
			    			//隐藏删除按钮
			    			$(this).find(".202-3").hide();
			    			//隐藏下达按钮
			    			$(this).find(".202-4").hide();
			    		}
			    		break;
		    		}
		    	}
	    	});
	    }
	};
	datagridUtil.initOption(op);
	
    datagridUtil.query();
    
    //查看已完成检测结果
    $(document).on("click",".finishNumber",function(){
    	var taskId = $(this).parents(".rowTr").attr("data-rowId");
    	self.location = "${webRoot}/dataCheck/recording/list.do?taskId="+taskId;
    });
    
  
    </script>
  </body>
</html>
