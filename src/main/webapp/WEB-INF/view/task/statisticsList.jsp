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
              <li class="cs-b-active cs-fl">任务统计
              </li>
            </ol>
          <!-- 面包屑导航栏  结束-->
             <!-- 顶部筛选 -->
          <!-- 顶部筛选 -->
          <div class="cs-input-style cs-fl" style="margin:5px 0 0 15px;">
              <select id="province" class="cs-selcet-style" style="width: 85px;"> 
              	<!-- <option value="day">日报表</option> --> 
				<option value="month">月报表</option> 
                 <option value="diy">自定义</option> 
              </select> 
               
              <select class="check-date cs-selcet-style cs-hide"> 

              </select>
			
               <select class="check-date cs-selcet-style" id="month" style="width: 85px;"> 
				 <option value="">--请选择--</option>
                 <option value="1">1月</option> 

                 <option value="2">2月</option> 

                 <option value="3">3月</option> 

                 <option value="4">4月</option> 

                 <option value="5">5月</option> 

                 <option value="6">6月</option> 

                 <option value="7">7月</option> 

                 <option value="8">8月</option> 

                 <option value="9">9月</option> 

                 <option value="10">10月</option> 

                 <option value="11">11月</option> 

                 <option value="12">12月</option> 

              </select>  
            </div>  
            <span class="check-date cs-hide">
               <span class="cs-name">时间:</span>
	                <span class="cs-in-style cs-time-se cs-time-se">
	                	<input name="task.taskSdate" id="startTime" style="width: 110px;" class="cs-time Validform_error" type="text" onclick="WdatePicker()" datatype="date" nullmsg="请选择任务起止时间" errormsg="请选择任务起止时间" value="">
	                	<span style="padding:0 5px;">
	                                      至</span>
	                    <input name="task.taskSdate" id="endTime" style="width: 110px;" class="cs-time Validform_error" type="text" onclick="WdatePicker()" datatype="date" nullmsg="请选择任务起止时间" errormsg="请选择任务起止时间" value="">
	                </span>
	                <span>
		            	<a href="javascript:" class="cs-menu-btn" style="margin:4px 0 0 10px;" onclick="load()"><i class="icon iconfont icon-chakan"></i>查询</a>
		            </span>
                </span>
</div>
		<div class="cs-schedule-mao clearfix">
        <div class="col-lg-6 col-md-6 clearfix" style="padding: 15px 10px; border-right: 1px solid #eee; height: 120px;">
          <h5 class="cs-fl" style="font-weight: 600; color: #444;">下发任务进度</h5>
          <div class="col-md-10 col-lg-10 col-md-offset-1 col-lg-offset-1" style="margin-top: 10px;">
            <div class="progress">
              
                <div class="progress-bar progress-bar-success progress-bar-striped" aria-valuenow="60" role="progressbar" 
                id="missionProcess" aria-valuemin="0" aria-valuemax="100" >
                </div>
              
            </div>
          </div>
          <div class="col-md-12 col-lg-12" style="margin-top: 15px;">
            <div class="col-md-4 col-lg-4" style="text-align: center; border-right: 1px solid #ddd;">
              <p style="color: #666;" class="cs-dis-inline">下发任务数量：</p>
              <p class="text-primary cs-dis-inline" style="font-weight: bold; font-size: 14px;" id="missionNum">0个</p>
            </div>
            <div class="col-md-4 col-lg-4" style="text-align: center; border-right: 1px solid #ddd;">
              <p style="color: #666;" class="cs-dis-inline">下发完成数量：</p>
              <p class="text-primary cs-dis-inline" style="font-weight: bold; font-size: 14px;" id="missionFinish">0个</p>
            </div>
            <div class="col-md-4 col-lg-4" style="text-align: center;">
              <p style="color: #666;" class="cs-dis-inline">下发未完成数量：</p>
              <p class="text-danger cs-dis-inline" style="font-weight: bold; font-size: 14px;" id="missionUnqualified">0个</p>
            </div>
          </div>
        </div>

        <div class="col-lg-6 col-md-6 clearfix" style="padding: 15px 10px; border-right: 1px solid #eee; height: 120px;">
          <h5 style="font-weight: 600; color: #444;">接收任务进度</h5>
          <div class="col-md-10 col-lg-10 col-md-offset-1 col-lg-offset-1" style="margin-top: 10px;">
            <div class="progress">
              
              
                <div class="progress-bar progress-bar-success progress-bar-striped" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" id="receivedProcess"
                  color:#000">
                </div>
              
            </div>
          </div>
          <div class="col-md-12 col-lg-12" style="margin-top: 15px;">
            <div class="col-md-4 col-lg-4" style="text-align: center; border-right: 1px solid #ddd;">
              <p style="color: #666;" class="cs-dis-inline">接收任务数量：</p>
              <p class="text-primary cs-dis-inline" style="font-weight: bold; font-size: 14px;" id="receivedNum">0个</p>
            </div>
            <div class="col-md-4 col-lg-4" style="text-align: center; border-right: 1px solid #ddd;">
              <p style="color: #666;" class="cs-dis-inline">接收完成数量：</p>
              <p class="text-primary cs-dis-inline" style="font-weight: bold; font-size: 14px;" id="receivedFinish">0个</p>
            </div>
            <div class="col-md-4 col-lg-4" style="text-align: center;">
              <p style="color: #666;" class="cs-dis-inline">接收未完成数量：</p>
              <p class="text-danger cs-dis-inline" style="font-weight: bold; font-size: 14px;" id="receivedUnqualified">0个</p>
            </div>
          </div>
        </div>
      </div>

      <div style="padding-bottom:50px;">
             <table class="cs-table cs-table-hover table-striped cs-tablesorter" id="table">
                <thead>
                  <tr>
                    <th class="cs-header" style='width:50px;'>序号</th>
                    <th class="cs-header">日期</th>
                    <th class="cs-header" onclick="orderByName('table',2,'int')">下发任务数量</th>
                    <th class="cs-header" onclick="orderByName('table',3,'int')">下发完成数量</th>
                    <th class="cs-header" onclick="orderByName('table',4,'float')">下发未完成数量</th>
                    <th class="cs-header" onclick="orderByName('table',5,'float')">下发完成率</th>
                    <th class="cs-header" onclick="orderByName('table',6,'float')">接收任务数量</th>
                    
                    <th class="cs-header" onclick="orderByName('table',7,'float')">接收完成数量</th>
                    <th class="cs-header" onclick="orderByName('table',8,'int')">接收未完成数量</th>
                    <th class="cs-header" onclick="orderByName('table',9,'float')">接收完成率</th>
                    <th class="cs-header" onclick="orderByName('table',10,'string')">操作</th>
                  </tr>
                </thead>
                <tbody>

                </tbody>
              </table>
</div>
	
	<!-- 引用模态框 -->
	<%@include file="/WEB-INF/view/common/confirm.jsp"%>
    
    <!-- JavaScript -->
    <script src="${webRoot}/js/datagridUtil.js"></script>
    <script type="text/javascript">
    // /dataCheck/recording/list.do
    var type;
   	var month;
   	var season;
   	var year;
   	var startTime;
   	var endTime;
   	var flag=${flag};
   	var view=0;
   	var viewObj;
	for (var i = 0; i < childBtnMenu.length; i++) {
	 if (childBtnMenu[i].operationCode == "1382-1") {
			//查看
			view = 1;
			viewObj=childBtnMenu[i];
		}
	}
	
	
    $(function () {
		if(flag==1){
			type="${type}";
        	month="${month}";
        	startTime="${startTime}";
        	endTime="${endTime}";
        	
        	$("input[name='departName']").val(dname);
  			
  			$("#province").find("option[value='"+type+"']").attr("selected",true);
  			$("#month").find("option[value='"+month+"']").attr("selected",true);
  			$("#startTime").find("option[value='"+startTime+"']").attr("selected",true);
  			$("#endTime").find("option[value='"+endTime+"']").attr("selected",true);
  			
  			$("#province option").each(function(i){
                if($(this).val() == $("#province option:selected").val()){
                 $(".check-date").hide().val();
                 $(".check-date").eq(i+1).show();
               }
            });
		}else if (flag==0){
			var date=new Date;
    		var monthsss=date.getMonth()+1;
    		$("#month").find("option[value='"+monthsss+"']").attr("selected",true);
    		
			type=$("#province option:selected").val();
        	month=$("#month option:selected").val();
        	season=$("#season option:selected").val();
        	year=$("#year option:selected").val();
        	startTime=$("#startTime").val();
        	endTime=$("#endTime").val();
		}
	}); 
    function load() {
    	$("#table tbody tr").remove();
    	loadData();
	}
	$("#month").change(function(){
		load();
    });
	$(function () {
		var date=new Date;
		var monthsss=date.getMonth()+1;
		$("#month").find("option[value='"+monthsss+"']").attr("selected",true);
		loadData();
	});
    function loadData() {
    	$.ajax({
	        type: "POST",
	        url: '${webRoot}'+"/task/statisticsDatagrid.do",
	        data:{type:$("#province option:selected").val(),
	        	month:$("#month option:selected").val(),
	        	startTime:$("#startTime").val(),
	        	endTime:$("#endTime").val()
	        },
	        dataType: "json",
	        success: function(data){
	        	if(data && data.success){
	        			$.each(data.obj.results, function(k, o) {
	        				var html="<tr>";
	        					html+="<td style='width:50px;'>"+(k+1)+"</td>";
	        					html+="<td>"+o.taskDate+"</td>";
	        					html+="<td>"+o.missionNum+"</td>";
	        					html+="<td>"+o.missionFinish+"</td>";
	        					html+="<td>"+o.missionUnqualified+"</td>";
	        					html+="<td>"+o.mCompletionRate+"%</td>";
	        					html+="<td>"+o.receivedNum+"</td>";
	        					html+="<td>"+o.receivedFinish+"</td>";
	        					html+="<td>"+o.receivedUnqualified+"</td>";
	        					html+="<td>"+o.rCompletionRate+"%</td>";
	                            if(view==1){
	                            	html+="<td><a href='${webRoot}/task/statisticsDetail.do?taskDate="+o.taskDate+"' class='operationButton cs-icon-span 331-2'><i class='icon iconfont icon-chakan' title='编辑'></i></a></td>";
	                            }else{
	                            	html+="<td></td>";
	                            }
	        					html+="</tr>";
	                          	$("#table tbody").append(html);
	        				});
	        			//设置下发任务进度
	        			var taskObj=data.obj.obj;
	        			var process=((taskObj.missionFinish/taskObj.missionNum)*100).toFixed(2);
	        	    	if(isNaN(process)) process=0
	        			$("#missionProcess").css("width",process+"%");
	        			$("#missionProcess").html(process+"%");
        	    		process=taskObj.missionFinish/taskObj.missionNum;
	        	    	if(process==0 || isNaN(process)){
	        	    		$("#missionProcess").css("color","#000");
	        	    	}
	        	    	$("#missionNum").html(taskObj.missionNum+"个");
	        	    	$("#missionFinish").html(taskObj.missionFinish+"个");
	        	    	$("#missionUnqualified").html(taskObj.missionNum-taskObj.missionFinish+"个");
	        	    	
	        	    	//设置接收任务进度
	        	    	process=((taskObj.receivedFinish/taskObj.receivedNum)*100).toFixed(2);
	        	    	if(isNaN(process)) process=0
	        	    	$("#receivedProcess").css("width",process+"%");
	        	    	$("#receivedProcess").html(process+"%");
	        	    	process=taskObj.receivedFinish/taskObj.receivedNum;
	        	    	if(process==0 || isNaN(process)){
	        	    		$("#receivedProcess").css("color","#000");
	        	    	}
	        	    	$("#receivedNum").html(taskObj.receivedNum+"个");
	        	    	$("#receivedFinish").html(taskObj.receivedFinish+"个");
	        	    	$("#receivedUnqualified").html((taskObj.receivedNum-taskObj.receivedFinish)+"个");
	        	}else{
	        		console.log("查询失败");
	        	}
			},
			error: function(){
				console.log("查询失败");
			}
	    });
	}
	
    </script>
  </body>
</html>
