<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/common/resource.jsp"%>
<html>
  <head>
    <title>快检服务云平台</title>
  </head>
  <body>

		<div id="dataList"></div>
	
	<!-- 引用模态框 -->
	<%@include file="/WEB-INF/view/common/confirm.jsp"%>
    
    <script src="${webRoot}/js/datagridUtil2.js"></script>
    <script type="text/javascript">

      var dgu = datagridUtil.initOption({
		tableId: "dataList",
		tableAction: '${webRoot}'+"/task/datagrid.do",
        tableBar: {
          title: ["任务管理","任务信息"],
          ele: [{
            eleShow: 1,
            eleName: "task.taskTitle",
            eleType: 0,
            elePlaceholder: "请输入任务名称"
          }],
          topBtns: [{
            show: Permission.exist("202-1"),
            style: Permission.getPermission("202-1"),
            action: function(ids, rows){
              self.location="${webRoot}/task/goAddTask";
            }
          }]
        },
		parameter: [
			{
				columnCode: "taskTitle",
				columnName: "任务名称",
				query: 1,
				columnWidth: "15%",
				queryCode: "task.taskTitle"
			},
			/* {
				columnCode: "taskDepartName",
				columnName: "发布机构",
			}, */
			{
				columnCode: "taskAnnouncerName",
				columnName: "发布人",
				columnWidth: "10%"
			},
			{
				columnCode: "taskStatus",
				columnName: "任务状态",
				query: 1,
				columnWidth: "8%",
				queryType: 2,
				queryCode: "task.taskStatus",
				customVal: {"-1":"终止","0":"暂存","1":"已下发","2":"已完成"}
			},
			{
				columnCode: "taskTotal",
				columnName: "检测任务量",
				columnWidth: "10%"
				
			},
			{
				columnCode: "sampleNumber",
				columnName: "已完成",
				columnWidth: "10%"
				// customElement: "<a class=\"cs-link-text finishNumber\" href=\"javascript:;\">?</a>"
			},
			{
				columnCode: "schedule",
				columnName: "完成进度",
				columnWidth: "10%",
				customElement: "?%"
			},
			{
				columnCode: "taskSdate",
				columnName: "开始日期",
				queryType: 1,
				columnWidth: "10%",
			},
			{
				columnCode: "taskEdate",
				columnName: "结束日期",
				queryType: 1,
				columnWidth: "10%",
			},
            {
              columnCode: "taskCdate",
              columnName: "下发时间",
              columnWidth: "15%",
              dateFormat: "yyyy-MM-dd HH:mm:ss"
            }
		],
		funBtns: [//操作列按钮 
			{//查看
                show: Permission.exist("202-06"),
                style: Permission.getPermission("202-06"),
				action: function(id, row){
                    //跳转到下达任务界面
                    self.location = '${webRoot}/task/goAddTask?id='+id;
				}
			},
	    	{//编辑
                show: Permission.exist("202-2"),
                style: Permission.getPermission("202-2"),
	    		action: function(id, row){
                    //跳转到下达任务界面
                    self.location = '${webRoot}/task/goAddTask?id='+id;
	    		}
	    	},
	    	{//下达
                show: Permission.exist("202-4"),
                style: Permission.getPermission("202-4"),
	    		action: function(id, row){
	    			deleteId = id;
	    			configType = 2;
	    			if(!id){
	    				$("#confirm-warnning .tips").text("下发任务失败");
	    				$("#confirm-warnning").modal('toggle');
	    			}else{
	    				$("#confirm-delete .tips").text("确认下发任务？");
	    				$("#confirm-delete .btn-ok").text("确认");
	    				$("#confirm-delete").modal('toggle');
	    			}
	    		}
	    	},
	    	{	//删除
                show: Permission.exist("202-3"),
                style: Permission.getPermission("202-3"),
	     		action: function(id, row){
	     			deleteId = id;
	     			configType = 1;
	    			if(!id){
	    				$("#confirm-warnning .tips").text("删除失败");
	    				$("#confirm-warnning").modal('toggle');
	    			}else{
	    				$("#confirm-delete .tips").text("确认删除任务？");
	    				$("#confirm-delete .btn-ok").text("确认");
	    				$("#confirm-delete").modal('toggle');
	    			}
	     		}
	     	},
	    	{	//终止函数	
                show: Permission.exist("202-5"),
                style: Permission.getPermission("202-5"),
	     		action: function(id, row){
	     			deleteId = id;
	    			configType = 3;
	    			if(!id){
	    				$("#confirm-warnning .tips").text("终止失败");
	    				$("#confirm-warnning").modal('toggle');
	    			}else{
	    				$("#confirm-delete .tips").text("确认终止任务？");
	    				$("#confirm-delete .btn-ok").text("确认");
	    				$("#confirm-delete").modal('toggle');
	    			}
	     		}
	     	}
	    ],
	    onload: function(obj, pageData){
	    	//加载列表后执行函数
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
	});
      dgu.queryByFocus();
    
    <%--//查看已完成检测结果--%>
    <%--$(document).on("click",".finishNumber",function(){--%>
    <%--	var taskId = $(this).parents(".rowTr").attr("data-rowId");--%>
    <%--	self.location = "${webRoot}/dataCheck/recording/list.do?taskId="+taskId;--%>
    <%--});--%>
    
    //确认提示框
    var deleteId = "";	//数据ID
    var configType;	//确认框类型
    function deleteData(){
    	if(configType == 1){
    		//删除
    		$.ajax({
    	        type: "POST",
    	        url: '${webRoot}'+"/task/delete.do",
    	        data: {"ids":deleteId},
    	        dataType: "json",
    	        success: function(data){
    	        	if(data && data.success){
    	        		$("#confirm-warnning .tips").text("删除成功");
    	    			$("#confirm-warnning").modal('toggle');
                        dgu.queryByFocus();
    	        	}else{
    	        		$("#confirm-warnning .tips").text(data.msg);
    	    			$("#confirm-warnning").modal('toggle');
    	        	}
    			}
    	    });
    	}else if(configType == 2){
    		//下达
    		$.ajax({
		        type: "POST",
		        url: '${webRoot}'+"/task/releaseTask.do",
		        data: {"id":deleteId},
		        dataType: "json",
		        success: function(data){
		        	if(data){
    		        	if(data.success){
    		        		//下达成功后刷新列表
    		        		$("#confirm-warnning .tips").text("下达成功");
							$("#confirm-warnning").modal('toggle');
                            dgu.queryByFocus();
    		        	}else{
    		        		$("#confirm-warnning .tips").text(data.msg);
    		    			$("#confirm-warnning").modal('toggle');
    		        	}
		        	}
				}
		    });
    	}else if(configType == 3){
    		//终止
    		$.ajax({
		        type: "POST",
		        url: '${webRoot}'+"/task/stopTask.do",
		        data: {"id":deleteId},
		        dataType: "json",
		        success: function(data){
		        	if(data){
    		        	if(data.success){
    		        		//下达成功后刷新列表
    		        		$("#confirm-warnning .tips").text("终止成功");
							$("#confirm-warnning").modal('toggle');
                            dgu.queryByFocus();
    		        	}else{
    		        		$("#confirm-warnning .tips").text(data.msg);
    		    			$("#confirm-warnning").modal('toggle');
    		        	}
		        	}
				}
		    });
    	}
		$("#confirm-delete").modal('toggle');
    }
    </script>
  </body>
</html>
