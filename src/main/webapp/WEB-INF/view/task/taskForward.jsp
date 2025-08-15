<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/common/resource.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<body>
		<!-- 内容主体 开始 -->
          <div class="cs-col-lg clearfix">
          <!-- 面包屑导航栏  开始-->
            <ol class="cs-breadcrumb">
              <li class="cs-fl">
              <img src="${webRoot}/img/set.png" alt="" />
              <a href="javascript:" class="returnBtn">任务管理</a></li>
              <li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
              <li class="cs-fl"><a href="javascript:" class="returnBtn">接收任务</a></li>
              <li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
              <li class="cs-b-active cs-fl">任务转发
              </li>
            </ol>
          <!-- 面包屑导航栏  结束-->
	          <div class="cs-search-box cs-fr">
				<div class="clearfix cs-fr">
					<!-- <a href="javascript:self.location.reload();" class="cs-menu-btn"><i class="icon iconfont icon-zengjia"></i>刷新</a> -->
					<a href="javascript:" class="cs-menu-btn returnBtn"><i class="icon iconfont icon-fanhui"></i>返回</a>
				</div>
	          </div>
          </div>
          
          <form id="taskForm" enctype="multipart/form-data">
          <!-- 任务信息 开始 -->
          <div class="cs-col">
            	<input name="task.id" type="hidden" value='<c:if test="${!empty task}">${task.id}</c:if>'>
            	<input name="task.taskStatus" type="hidden" value='<c:if test="${!empty task}">${task.taskStatus}</c:if>'>
            	<input name="task.taskDetailPid" type="hidden" value='<c:if test="${!empty recTask}">${recTask.id}</c:if>'>
            	<%-- <input name="task.taskDetailPid" type="hidden" value="${recTask.id}">
            	<input name="task.taskTitle" type="hidden" value="${recTask.taskTitle}">
            	<input name="task.taskType" type="hidden" value="${recTask.taskType}">
            	<input name="task.taskSource" type="hidden" value="上级任务">
            	<input name="task.taskTotal" type="hidden" value="${recTask.detailTotal}">
            	<input name="task.taskSdate" type="hidden" value='<fmt:formatDate type="date" value="${recTask.taskSdate}"/>'>
            	<input name="task.taskEdate" type="hidden" value='<fmt:formatDate type="date" value="${recTask.taskEdate}"/>'>
            	<input name="task.taskPdate" type="hidden" value='<fmt:formatDate type="date" value="${recTask.taskPdate}"/>'>
            	<input name="task.remark" type="hidden" value="${recTask.taskRemark}">
            	<input name="task.taskStatus" type="hidden" value="0">
            	<input name="task.sampleNumber" type="hidden" value="0">
            	<input name="task.deleteFlag" type="hidden" value="0"> --%>
            
          <div class="cs-content2">
           <h3>任务信息</h3>
          </div>
              <table class="cs-form-table cs-detail-table cs-form-table-he">
                  <tr>
                    <td class="cs-name">检测任务：</td>
                    <td class="cs-al cs-td-detail">
                    	<c:if test="${!empty recTask}">
                    		${recTask.taskTitle}
                    	</c:if>
                    </td>
                    <td class="cs-name">编制机构：</td>
                    <td class="cs-al cs-td-detail">
                    	<c:if test="${!empty recTask}">
                    		${recTask.depart}
                    	</c:if>
                    </td>
                    <td class="cs-name">任务批次：</td>
                    <td class="cs-al">
                    	<c:if test="${!empty recTask}">
                    		${recTask.detailTotal}
                    	</c:if>批次
                    </td>
                  </tr>
                  <tr>
                    <td class="cs-name">时间起止：</td>
                    <td class="cs-al">
                    	<c:if test="${!empty recTask}">
                    		<fmt:formatDate type="date" value="${recTask.taskSdate}" />
                    	</c:if>
                    	<span> 至 </span>
                    	<c:if test="${!empty recTask}">
                    		<fmt:formatDate type="date" value="${recTask.taskEdate}" />
                    	</c:if>
                    </td>
                    <td class="cs-name">报警时间：</td>
                    <td class="cs-al">
                    	<c:if test="${!empty recTask}">
                    		<fmt:formatDate type="both" value="${recTask.taskPdate}" />
                    	</c:if>
                    </td>
                  	<td class="cs-name">状态：</td>
                    <td class="cs-al">
                    	<c:if test="${empty task}">已接收</c:if>
                    	<c:if test="${!empty task && task.taskStatus eq -1}">转发任务-已终止</c:if>
                    	<c:if test="${!empty task && task.taskStatus eq 0}">转发任务-暂存</c:if>
                    	<c:if test="${!empty task && task.taskStatus eq 1}">转发任务-已下发</c:if>
                    	<c:if test="${!empty task && task.taskStatus eq 2}">转发任务-已完成</c:if>
                    </td>
                  </tr> 
                  <tr>
                    <td class="cs-name">任务类型：</td>
                    <td class="cs-al">
                    	<c:if test="${!empty recTask}">
                    		${recTask.taskType}
                    	</c:if>
                    </td>
                    <td class="cs-name">任务来源：</td>
                    <td class="cs-al">
                    	<c:if test="${!empty recTask}">
                    		${recTask.taskSource}
                    	</c:if>
                    </td>
                    <td class="cs-name">任务附件：</td>
                    <td class="cs-al">
						<c:if test="${!empty recTask.filePath}">
							<a href="${webRoot}${recTask.filePath}" download="">
								<img src="${webRoot}/img/word.png" width="20px" alt="">
								<span class="cs-file-box">${fileName}</span>
							</a>
						</c:if>
					</td>
                  </tr>
                  <tr>
                    <!-- <td class="cs-name">已完成：</td>
                    <td class="cs-al"></td>
                    <td class="cs-name">完成率：</td>
                    <td class="cs-al"></td> -->
                    <td class="cs-name">任务备注：</td>
                    <td class="cs-al" colspan="5">
                    	<c:if test="${!empty recTask}">
                    		${recTask.taskRemark}
                    	</c:if>
                    </td>
                  </tr>
                </table>
               <div class="cs-content2">
               	 <h3>转发任务信息</h3>
               </div>
           <table class="cs-form-table cs-form-table-he2">
				<tr>
					<td class="cs-name" style="width:100px;">接收对象：</td>
					<td class="cs-check-radio">
						<input class="cs-show-jigou" id="jigou" type="radio" name="name" checked="true" value="0"/><label for="jigou">机构</label>
						<input class="cs-show-dian" id="dian" type="radio" name="name" value="1"/><label for="dian">检测点</label>
					</td>
				</tr>
			</table>
                <div class="cs-deliver-jigou">
	                <table class="cs-table cs-table-hover table-striped cs-tablesorter" id="orgTable">
	                <thead>
	                  <tr>
	                    <th class="cs-header">序号</th>
	                    <th class="cs-header">食品种类</th>
	                    <th class="cs-header">检测项目</th>
	                    <th class="cs-header">批次</th>
	                    <th class="cs-header">转发机构/检测点</th>
	                    <!-- <th class="cs-header">已完成</th>
	                    <th class="cs-header">完成率</th> -->
	                    <c:if test="${empty task || task.taskStatus eq 0}">
	                    	<th class="cs-header">操作</th>
	                    </c:if>
	                  </tr>
	                </thead>
	                <c:forEach items="${details}" var="detail" varStatus="item">
						<tr
							<c:if test="${!empty detail.receivePointid}">class="orgItemTr depart-${detail.receivePointid}"</c:if>
							<c:if test="${!empty detail.receiveNodeid}">class="orgItemTr point-${detail.receiveNodeid}"</c:if>
						>
							<td class="dNo">${item.count}</td>
							<input type="hidden" class="dId" value="${detail.id}"/>
							<td>${detail.sample}
								<input type="hidden" class="dSample" readonly="readonly" value="${detail.sample}"/>
								<input type="hidden" class="dSampleId" readonly="readonly" value="${detail.sampleId}"/>
							</td>
							<td>${detail.item}
								<input type="hidden" class="dItem" readonly="readonly" value="${detail.item}"/>
								<input type="hidden" class="dItemId" readonly="readonly" value="${detail.itemId}"/>
							</td>
							<td class="cs-pici"><input type="text" class="dTotal" value="${detail.taskTotal}" datatype="n" nullmsg="请输入检测批次" errormsg="请输入检测批次"/></td>
							<td>
								<c:if test="${!empty detail.receivePointid}">
									${detail.receivePoint}
									<input type="hidden" class="dDepart" readonly="readonly" value="${detail.receivePoint}"/>
									<input type="hidden" class="dDepartId" readonly="readonly" value="${detail.receivePointid}"/>
								</c:if>
								<c:if test="${!empty detail.receiveNodeid}">
									${detail.receiveNode}
									<input type="hidden" class="dPoint" readonly="readonly" value="${detail.receiveNode}"/>
									<input type="hidden" class="dPointId" readonly="readonly" value="${detail.receiveNodeid}"/>
								</c:if>
							</td>
							<!-- <td>0批次</td>
							<td>0%</td> -->
							<c:if test="${empty task || task.taskStatus eq 0}">
								<td class="delBtn">
									<a href="javascript:"><img src="${webRoot}/img/del_red.png" title="删除"></a>
								</td>
							</c:if>
						</tr>
	                </c:forEach>
					<%--
	                <c:if test="${(empty task || task.taskStatus eq 0) && (empty details || fn:length(details) eq 0)}">
	                	<tr class="orgItemTr">
			                <td class="dNo">1</td>
							<input type="hidden" class="dId" />
							<td>${recTask.sample}
								<input type="hidden" class="dSample" readonly="readonly" value="${recTask.sample}"/>
								<input type="hidden" class="dSampleId" readonly="readonly" value="${recTask.sampleId}"/>
							</td>
							<td>${recTask.item}
								<input type="hidden" class="dItem" readonly="readonly" value="${recTask.item}"/>
								<input type="hidden" class="dItemId" readonly="readonly" value="${recTask.itemId}"/>
							</td>
							<td class="cs-pici"><input type="text" class="dTotal" datatype="n" nullmsg="请输入检测批次" errormsg="请输入检测批次"/></td>
							<td>
								<input type="text" class="dPoint" datatype="*" nullmsg="请选择接收机构" errormsg="请选择接收机构"/>
								<input type="hidden" class="dPointId" />
							</td>
							<!-- <td>0批次</td>
							<td>0%</td> -->
							<td class="delBtn">
								<a href="javascript:;"><img src="${webRoot}/img/del_red.png" title="删除"></a>
							</td>
						</tr>
	                </c:if>
					--%>
	              </table>
              </div>
            </div>
            </form>
            
            <div class="cs-table-tab">
              	<c:if test="${empty task || task.taskStatus eq 0}">
					<div id="orgItemBtn" class="cs-fl cs-ac">
						<a href="javascript:" class="cs-menu-btn"><i class="icon iconfont icon-zengjia"></i>添加</a>
					</div>
              	</c:if>
				<span class="cs-fr">剩余：<i class="cs-org-text"><span class="surplus">0</span>批次</i></span> <span
					class="cs-fr cs-text-red">已分配：<i class="cs-green-text"><span class="allocation">0</span>批次</i></span>
			</div>
			</div>
            <div class="cs-alert-form-btn">
	            <c:if test="${(empty task || task.taskStatus eq 0) && (!empty recTask && recTask.taskStatus != -1)}">
					<a href="javascript:" class="cs-menu-btn" id="orgSave1"><i class="icon iconfont icon-zengjia"></i>保存</a>
					<a href="javascript:" class="cs-menu-btn" id="orgSave2"><i class="icon iconfont icon-zhuanfa"></i>转发</a>
				</c:if>
				<a href="javascript:" class="cs-menu-btn returnBtn"><i class="icon iconfont icon-fanhui"></i>返回</a>
			</div>	
	
	<!-- 引用模态框 -->
	<%@include file="/WEB-INF/view/detect/depart/selectDepart.jsp"%>
	<%@include file="/WEB-INF/view/detect/basePoint/selectPoint.jsp"%>
	<%@include file="/WEB-INF/view/common/confirm.jsp"%>

	<!-- JavaScript -->
	<script type="text/javascript">
	$(function(){
		//计算总批次
		recalculate();

		//已下达任务，禁用所有控件
		if($("input[name='task.taskStatus']").val() && $("input[name='task.taskStatus']").val()!="0"){
			$("input").attr("disabled","disabled");
			$("select").attr("disabled","disabled");
			$("textarea").attr("disabled","disabled");
		}
	});
	
	//提交成功后刷新
	var reflashUrl;
	$('#confirm-warnning').on('hidden.bs.modal', function () {
		if(reflashUrl){
			//window.location.href= '${webRoot}'+"/task/list.do";
			self.location = reflashUrl;
		}
	});
		
		//任务验证
		$("#taskForm").Validform({
			beforeSubmit:function(curform){
				submitTask();
				return false;
			}
		});
		
		// //接收对象-机构事件
		// $(document).on("click",".cs-show-jigou",function(){
		// 	//禁止提交检测点任务验证
		// 	$("#orgTable input").removeAttr("ignore");
		// 	$("#pointTable input").attr("ignore","ignore");
		// 	//计算总批次
		// 	recalculate();
		// });
		//
		// //接收对象-检测点事件
		// $(document).on("click",".cs-show-dian",function(){
		// 	//禁止提交机构任务验证
		// 	$("#pointTable input").removeAttr("ignore");
		// 	$("#orgTable input").attr("ignore","ignore");
		// 	//计算总批次
		// 	recalculate();
		// });
		
		//添加接收对象
		$(document).on("click", "#orgItemBtn", function(){
			selectReceivingObject();
	    });
		$(document).on("click", ".dPoint", function(){
			selectReceivingObject();
	    });
		
		//选择接收对象
		function selectReceivingObject(){
			var orgType = $("input[type='radio'][name='name']:checked").val();
			if(orgType == "0"){
				//机构
				$('#myDeaprtModal').modal('toggle');
			}else if(orgType == "1"){
				//检测点
				$('#myPointModal').modal('toggle');
			}
		}
		
		//保存
		$(document).on("click", "#orgSave1", function(){
			$("input[name='task.taskStatus']").val("0");
			$("#taskForm").submit();
		});
		
		//下达
		$(document).on("click", "#orgSave2", function(){
			$("input[name='task.taskStatus']").val("1");
			$("#taskForm").submit();
		});
		
		//返回
		$(document).on("click", ".returnBtn", function(){
			self.location = '${webRoot}'+"/task/receiveList.do";
			//location.history.back();
		});
		
	//检测机构计算批次总数
	$(document).on("change", ".orgItemTr .dTotal", function(){
		//计算总批次
		recalculate();
	});
	
	//删除任务机构
	$(document).on("click", ".delBtn", function(){
		$(this).parent().remove();
		//重新设置序号
		resetNo();
		//计算总批次
		recalculate();
    });
	
	var dSample1 = '${recTask.sample}';
	var dSampleId1 = '${recTask.sampleId}';
	var dItem1 = '${recTask.item}';
	var dItemId1 = '${recTask.itemId}';
	//添加任务明细
	function addOrgItem(nodes){
		var orgType = $("input[type='radio'][name='name']:checked").val();
		if(orgType == "0"){
			//机构任务明细
			if(nodes){
				//删除无效转发对象
				$("#orgTable .orgItemTr").each(function(){
					for(var j=0; j<nodes.length; j++){
						if($(this).attr("data-trId") == nodes[j].id){
							//接收单位已存在，清空当前对象，避免生成重复转发对象
							nodes[j] = "";
							break;
						}else if(j==nodes.length-1){
							//删除转发对象
							$(this).remove();
						}
					}
				});

				for(var i=0; i<nodes.length; i++){
					if(nodes[i]){
						var orgItemHtml = "<tr class=\"orgItemTr\" data-trId=\"depart-"+nodes[i].id+"\"><td class=\"dNo\"></td>"
						 	+ "<input type=\"hidden\" class=\"dId\"/>"
						 	+ "<td>"+dSample1+"<input type=\"hidden\" class=\"dSample\" value=\""+dSample1+"\""
							+ "/><input type=\"hidden\" class=\"dSampleId\" value=\""+dSampleId1+"\"/></td>"
						 	+ "<td>"+dItem1+"<input type=\"hidden\" class=\"dItem\" value=\""+dItem1+"\""
							+ "/><input type=\"hidden\" class=\"dItemId\" value=\""+dItemId1+"\"/></td>"
						 	+ "<td class=\"cs-pici\"><input type=\"text\" class=\"dTotal\" datatype=\"n\" nullmsg=\"请输入检测批次\" errormsg=\"请输入检测批次\"/></td>"
						 	// + "<td>"+nodes[i].text+"<input type=\"hidden\" class=\"dDepartId\" value=\""+nodes[i].id+"\"/><input type=\"hidden\" class=\"dDepart\" value=\""+nodes[i].text+"\"/></td>"
						 	+ "<td>"+nodes[i].text+"<input type=\"hidden\" class=\"dDepart\" readonly=\"readonly\" value=\""+nodes[i].text+"\"/><input type=\"hidden\" class=\"dDepartId\" readonly=\"readonly\" value=\""+nodes[i].id+"\"/></td>"
						 	+ "<td class=\"delBtn\"><a href=\"javascript:;\">"
							+ "<img src=\"${webRoot}/img/del_red.png\" title=\"删除\">"
						 	+ "</a></td></tr>";
						$("#orgTable").append(orgItemHtml);
					}
				}
			}
		}else if(orgType == "1"){
			//检测点任务明细
			if(nodes){
				//删除无效转发对象
				$("#pointTable .orgItemTr").each(function(){
					for(var j=0; j<nodes.length; j++){
						if($(this).attr("data-trId") == nodes[j].id){
							//接收单位已存在，清空当前对象，避免生成重复转发对象
							nodes[j] = "";
							break;
						}else if(j==nodes.length-1){
							//删除转发对象
							$(this).remove();
						}
					}
				});
				for(var i=0; i<nodes.length; i++){
					if(nodes[i]){
						var orgItemHtml = "<tr class=\"orgItemTr\" data-trId=\"point-"+nodes[i].id+"\"><td class=\"dNo\"></td>"
						 	+ "<input type=\"hidden\" class=\"dId\" />"
						 	+ "<td>"+dSample1+"<input type=\"hidden\" class=\"dSample\" value=\""+dSample1+"\""
							+ "/><input type=\"hidden\" class=\"dSampleId\" value=\""+dSampleId1+"\"/></td>"
						 	+ "<td>"+dItem1+"<input type=\"hidden\" class=\"dItem\" value=\""+dItem1+"\""
							+ "/><input type=\"hidden\" class=\"dItemId\" value=\""+dItemId1+"\"/></td>"
						 	+ "<td class=\"cs-pici\"><input type=\"text\" class=\"dTotal\" datatype=\"n\" nullmsg=\"请输入检测批次\" errormsg=\"请输入检测批次\"/></td>"
						 	// + "<td>"+nodes[i]["name"]+"<input type=\"hidden\" class=\"dPointId\" value=\""+nodes[i]["id"]+"\"/><input type=\"hidden\" class=\"dPoint\" value=\""+nodes[i]["name"]+"\"/></td>"
						 	+ "<td>"+nodes[i]["name"]+"<input type=\"hidden\" class=\"dPoint\" readonly=\"readonly\" value=\""+nodes[i]["name"]+"\"/><input type=\"hidden\" class=\"dPointId\" readonly=\"readonly\" value=\""+nodes[i]["id"]+"\"/></td>"
						 	+ "<td class=\"delBtn\"><a href=\"javascript:;\">"
							+ "<img src=\"${webRoot}/img/del_red.png\" title=\"删除\">"
						 	+ "</a></td></tr>";
						$("#orgTable").append(orgItemHtml);
					}
				}
			}
		}
		
		//重新设置序号
		resetNo();
		//计算总批次
		recalculate();
	}
	
	//提交任务
	function submitTask(){
		//对input的name属性赋值
		var iii = 0;
		var ts = $("input[name='task.taskStatus']").val();//任务状态
		var orgType = $("input[type='radio'][name='name']:checked").val();
		
		//任务明细批次验证
		if(ts=="1" && surplus!=0){
			$("#confirm-warnning .tips").text("请分配剩余批次");
			$("#confirm-warnning").modal('toggle');
			return;
		}
		
		// if(orgType == "0"){
			//任务明细为空，取消下达
			if(ts=="1" && $("#orgTable .orgItemTr").length==0){
				$("#confirm-warnning .tips").text("任务明细不能为空");
    			$("#confirm-warnning").modal('toggle');
				return;
			}
			//机构
			$("#orgTable .orgItemTr").each(function(){
				$(this).find(".dId").attr("name","taskDetails["+iii+"].id");
				$(this).find(".dDepart").attr("name","taskDetails["+iii+"].receivePoint");
				$(this).find(".dDepartId").attr("name","taskDetails["+iii+"].receivePointid");
				$(this).find(".dPoint").attr("name","taskDetails["+iii+"].receiveNode");
				$(this).find(".dPointId").attr("name","taskDetails["+iii+"].receiveNodeid");
				$(this).find(".dSample").attr("name","taskDetails["+iii+"].sample");
				$(this).find(".dSampleId").attr("name","taskDetails["+iii+"].sampleId");
				$(this).find(".dItem").attr("name","taskDetails["+iii+"].item");
				$(this).find(".dItemId").attr("name","taskDetails["+iii+"].itemId");
				$(this).find(".dTotal").attr("name","taskDetails["+iii+"].taskTotal");
				iii++;
			});
		// 	//禁止提交检测点任务
		// 	$("#orgTable input").removeAttr("disabled");
		// 	$("#pointTable input").attr("disabled","disabled");
		// }else if(orgType == "1"){
		// 	//任务明细为空，取消下达
		// 	if(ts=="1" && $("#pointTable .orgItemTr").length==0){
		// 		$("#confirm-warnning .tips").text("任务明细不能为空");
    	// 		$("#confirm-warnning").modal('toggle');
		// 		return;
		// 	}
		// 	//检测点
		// 	$("#pointTable .orgItemTr").each(function(){
		// 		$(this).find(".dId").attr("name","taskDetails["+iii+"].id");
		// 		$(this).find(".dPoint").attr("name","taskDetails["+iii+"].receiveNode");
		// 		$(this).find(".dPointId").attr("name","taskDetails["+iii+"].receiveNodeid");
		// 		$(this).find(".dSample").attr("name","taskDetails["+iii+"].sample");
		// 		$(this).find(".dSampleId").attr("name","taskDetails["+iii+"].sampleId");
		// 		$(this).find(".dItem").attr("name","taskDetails["+iii+"].item");
		// 		$(this).find(".dItemId").attr("name","taskDetails["+iii+"].itemId");
		// 		$(this).find(".dTotal").attr("name","taskDetails["+iii+"].taskTotal");
		// 		iii++;
		// 	});
		// 	//禁止提交机构任务
		// 	$("#pointTable input").removeAttr("disabled");
		// 	$("#orgTable input").attr("disabled","disabled");
		// }
		
		var formData = new FormData($('#taskForm')[0]);
		$.ajax({
	        type: "POST",
	        url: '${webRoot}'+"/task/addTask.do",
	        data: formData,
	        contentType: false, //必须false才会避开jQuery对 formdata 的默认处理 XMLHttpRequest会对 formdata 进行正确的处理 
	        processData: false, //必须false才会自动加上正确的Content-Type
	        dataType: "json",
	        success: function(data){
	        	if(data && data.success){
	        		$("#confirm-warnning .tips").text("保存成功");
	    			$("#confirm-warnning").modal('toggle');
	    			reflashUrl = '${webRoot}/taskDetail/goTaskForward.do?id='+data.obj.taskDetailPid;
	    			//self.location = '${webRoot}/taskDetail/goTaskForward.do?id='+data.obj.taskDetailPid;
	        	}else{
	        		$("#confirm-warnning .tips").text("保存失败");
	    			$("#confirm-warnning").modal('toggle');
	        	}
			}
	    });
	}
	
	//重新设置序号
	function resetNo(){
		var j = 1;
		$("#orgTable .dNo").each(function(){
			$(this).text(j);
			j++;
		});
	}
	
	var surplus = 0;	//剩余批次
	var detailTotal = 0;	//任务总批次
	if('${recTask.detailTotal}'){
		detailTotal = parseInt('${recTask.detailTotal}');
	}
	//计算分配、剩余批次
	function recalculate(){
		var orgType = $("input[type='radio'][name='name']:checked").val();
		var totalBatch = 0;
		$("#orgTable .orgItemTr").each(function(){
			if($(this).find(".dTotal").val()){
				totalBatch += parseInt($(this).find(".dTotal").val());
			}
		});
		surplus = detailTotal - totalBatch;
		
		$(".allocation").text(totalBatch);
		$(".surplus").text(surplus);
	}
	
	//设置接收机构
	function selOrg(nodes){
		addOrgItem(nodes);
		$('#myDeaprtModal').modal('toggle');
	}
	//设置接收检测点
	function selPoint(pointsArray){
		addOrgItem(pointsArray);
		$('#myPointModal').modal('toggle');
	}
	
	
	</script>
</body>
</html>