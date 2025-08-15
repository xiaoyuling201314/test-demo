<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/common/resource.jsp"%>
<html>
  <head>
    <title>快检服务云平台</title>
  </head>
  <body>

    <div id="dataList"></div>

    <script src="${webRoot}/js/datagridUtil2.js"></script>
    <script type="text/javascript">
    var dgu = datagridUtil.initOption({
		tableId: "dataList",
		tableAction: '${webRoot}'+"/taskDetail/datagrid.do",
        tableBar: {
            title: ["任务管理","接收任务"],
            hlSearchOff: 0,
            ele: [{
                eleShow: 1,
                eleName: "task.taskTitle",
                eleType: 0,
                elePlaceholder: "请输入任务名称"
            }]
        },
		parameter: [
			{
				columnCode: "taskTitle",
				columnName: "任务名称",
				query: 1
			},
			{
				columnCode: "taskDepart",
				columnName: "发布机构",
			},
			{
				columnCode: "taskStatus",
				columnName: "任务状态",
				customVal: {"-1":"已终止","0":"执行中","1":"执行中","2":"已完成"}
			},
			{
				columnCode: "sample",
				columnName: "样品种类"
			},
			{
				columnCode: "item",
				columnName: "检测项目"
			},
			{
				columnCode: "taskTotal",
				columnName: "检测任务量"
			},
			{
				columnCode: "sampleNumber",
				columnName: "已完成"
			},
			{
				columnCode: "schedule",
				columnName: "完成进度",
				customElement: "?%"
			},
			{
				columnCode: "taskSdate",
				columnName: "开始日期",
				queryType: 1
			},
			{
				columnCode: "taskEdate",
				columnName: "结束期限",
				queryType: 1
			}
			
		],
		funBtns: [
			{
                show: Permission.exist("204-1"),
                style: Permission.getPermission("204-1"),
				action: function(id){
					self.location = '${webRoot}/taskDetail/viewReceiveTask.do?id='+id; 
				}
			},
	    	{
                show: Permission.exist("204-02"),
                style: Permission.getPermission("204-02"),
	    		action: function(id){
	    			self.location = '${webRoot}/taskDetail/goTaskForward.do?id='+id; 
	    		}
	    	}
	    ]
	});
    dgu.query();
    </script>
  </body>
</html>
