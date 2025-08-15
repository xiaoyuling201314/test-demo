<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/common/resource.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="${webRoot}/css/fileinput.css" />
<link rel="stylesheet" type="text/css" href="${webRoot}/css/theme.css" />
	<style>
		table td.cs-time-se input[type=text]{
			width: 105px;
		}

	</style>
</head>
<!-- 上传 -->
<script src="${webRoot}/js/sortable.js" type="text/javascript"></script>
<script src="${webRoot}/js/fileinput.js" type="text/javascript"></script>
<script src="${webRoot}/js/zh.js" type="text/javascript"></script>
<script src="${webRoot}/js/theme.js" type="text/javascript"></script>

<body>
	<!-- 内容主体 开始 -->
	<div class="cs-col-lg clearfix">
		<!-- 面包屑导航栏  开始-->
		<ol class="cs-breadcrumb">
			<li class="cs-fl"><img src="${webRoot}/img/set.png"/>
				<a href="javascript:" class="returnBtn">任务管理</a></li>
			<li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
			<li class="cs-fl"><a href="javascript:" class="returnBtn">任务信息</a></li>
			<li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
			<c:if test="${empty task}">
				<li class="cs-b-active cs-fl">新建任务</li>
			</c:if>
			<c:if test="${!empty task}">
				<li class="cs-b-active cs-fl">查看任务</li>
			</c:if>
			
		</ol>
		<!-- 面包屑导航栏  结束-->
		<div class="cs-search-box cs-fr">
			<div class="clearfix cs-fr">
				<a href="javascript:" class="cs-menu-btn returnBtn"><i class="icon iconfont icon-fanhui"></i>返回</a>
			</div>
        </div>
	</div>

	<form id="taskForm" enctype="multipart/form-data">
	<!-- 任务信息 开始 -->
	<div class="cs-col">
		<div class="cs-content2">
        	<h3>任务信息</h3>
        </div>
			<input name="task.id" type="hidden" value='<c:if test="${!empty task}">${task.id}</c:if>'>
			<input name="task.taskTotal" type="hidden" value='<c:if test="${!empty task}">${task.taskTotal}</c:if>'/>
			<input name="task.taskStatus" type="hidden" value='<c:if test="${!empty task}">${task.taskStatus}</c:if>'>
			
			<table class="cs-form-table cs-form-table-he">
				<tr>
					<td class="cs-name"><i class="cs-mred">*</i>检测任务：</td>
					<td class="cs-in-style">
						<input name="task.taskTitle" type="text" value='<c:if test="${!empty task}">${task.taskTitle}</c:if>'
							maxlength="25" datatype="*" nullmsg="请输入任务标题" errormsg="请输入任务标题"/>
					</td>
					<td class="cs-name">任务来源：</td>
					<td class="cs-in-style">
						<select class="cs-selcet-style" name="task.taskSource">
                            <c:forEach items="${taskSource}" var="ts">
                                <option value="${ts}" <c:if test="${!empty task and task.taskSource eq ts}">selected="selected"</c:if>>${ts}</option>
                            </c:forEach>
                            <%--
							<option value="紧急" <c:if test="${!empty task and task.taskSource == '紧急'}">selected="selected"</c:if>>紧急</option>
							<option value="上级任务" <c:if test="${!empty task and task.taskSource == '上级任务'}">selected="selected"</c:if>>上级任务</option>
							<option value="其他" <c:if test="${!empty task and task.taskSource == '其他'}">selected="selected"</c:if>>其他</option>
                            --%>
						</select>
					</td>

				</tr>
				<tr>
					<td class="cs-name"><i class="cs-mred">*</i>起止日期：</td>
					<td class="cs-in-style cs-time-se">
						<input name="task.taskSdate" class="cs-time" type="text" onClick="WdatePicker()" datatype="date" nullmsg="请选择任务起止时间" errormsg="请选择任务起止时间"
						value='<c:if test="${!empty task}"><fmt:formatDate type="date" value="${task.taskSdate}" /></c:if>' autocomplete="off" /> 至 
						<input name="task.taskEdate" class="cs-time" type="text" onClick="WdatePicker()" datatype="date" nullmsg="请选择任务起止时间" errormsg="请选择任务起止时间"
						value='<c:if test="${!empty task}"><fmt:formatDate type="date" value="${task.taskEdate}" /></c:if>' autocomplete="off" /></td>
					<td class="cs-name">任务类型：</td>
					<td class="cs-in-style">
						<select name="task.taskType" class="cs-selcet-style">
                            <c:forEach items="${taskType}" var="tt">
                                <option value="${tt}" <c:if test="${!empty task and task.taskType eq tt}">selected="selected"</c:if>>${tt}</option>
                            </c:forEach>
                            <%--
							<option value="日常检查" <c:if test="${!empty task and task.taskType == '日常检查'}">selected="selected"</c:if>>日常检查</option>
							<option value="专项检查" <c:if test="${!empty task and task.taskType == '专项检查'}">selected="selected"</c:if>>专项检查</option>
							<option value="其他" <c:if test="${!empty task and task.taskType == '其他'}">selected="selected"</c:if>>其他</option>
                            --%>
						</select>
					</td>
				</tr>
				<tr>
					<td class="cs-name">报警时间：</td>
					<td class="cs-in-style"><input name="task.taskPdate" class="cs-time" type="text" onClick="WdatePicker({startDate:'%y-%M-%d %H:%m:%s',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})" 
						value='<c:if test="${!empty task}"><fmt:formatDate type="both" value="${task.taskPdate}" /></c:if>'/></td>
					<td class="cs-name">任务附件：</td>
					<td>
						<c:choose>
							<c:when test="${!empty task.taskStatus && task.taskStatus ne 0}">
								<c:if test="${!empty task.filePath}">
									<a href="${webRoot}${task.filePath}" download="">
										<img src="${webRoot}/img/word.png" width="20px" alt="">
										<span class="cs-file-box">${fileName}</span>
									</a>
								</c:if>

							</c:when>
							<c:otherwise>
								<div class="kv-main">
									<input id="kv-explorer" type="file" name="filePathImage">
								</div>
							</c:otherwise>
						</c:choose>

					</td>
					<%-- <td class="cs-name">抽检总批次：</td>
					<td class="cs-in-style"><input name="task.taskTotal" type="text" ignore="ignore" datatype="n" nullmsg="请输入抽检批次" errormsg="请输入抽检批次"
						value='<c:if test="${!empty task}">${task.taskTotal}</c:if>' readonly="readonly" style="background: #E8E8E8;width:100px;"/></td> --%>
				</tr>
				<tr>
					<td class="cs-name">任务备注：</td>
					<td class="cs-in-style" colspan="3" style="padding-top: 5px;padding-bottom: 5px;">
						<textarea class="cs-remark" name="task.remark" cols="" rows="" maxlength="200"><c:if test="${!empty task}">${task.remark}</c:if></textarea>
					</td>
				</tr>
				<c:if test='${task.taskStatus>0}'>
					<tr>
						<td class="cs-name">发布人：</td>
						<td class="cs-in-style">
							<input name="task.taskTitle" type="text" value='<c:if test="${!empty task}">${task.taskAnnouncerName}</c:if>'/>
						</td>
						<td class="cs-name">发布时间：</td>
						<td class="cs-in-style">
							<input name="task.taskTitle" type="text" value='<c:if test="${!empty task}"><fmt:formatDate type="both" value="${task.taskCdate}" /></c:if>'/>
						</td>

					</tr>
					<tr>
						<td class="cs-name">发布机构：</td>
						<td class="cs-in-style" colspan="3">
							<input name="task.taskTitle" type="text" value='<c:if test="${!empty task}">${task.taskDepartName}</c:if>'/>
						</td>
					</tr>
				</c:if>
			</table>
			<div class="cs-content2">
            	<h3>分配任务信息</h3>
            </div>

			<c:choose>
				<c:when test="${empty task || task.taskStatus eq 0}">
					<!-- 新任务或未下发任务 -->
					<table class="cs-deliver-table cs-form-table-he2" id="orgItemTable">
				</c:when>
				<c:otherwise>
					<!-- 已下发、已完成或已终止任务 -->
					<table class="cs-deliver-table cs-form-table-he2 cs-hide" id="orgItemTable">
				</c:otherwise>
			</c:choose>
				<tr class="cs-yaoqiu-title orgItemTr">
					<td class="dNo" style="display:none;">0</td>
					<td class="cs-name" style="width: 100px;"><i class="cs-mred">*</i>食品种类：</td>
					<td class="cs-al"><input type="text" class="dSample" readonly="readonly"/><input type="hidden" class="dSampleId"/></td>
					<td class="cs-name" style="width: 100px;">检测项目：</td>
					<td class="cs-al"><input type="text" class="dItem" readonly="readonly"/><input type="hidden" class="dItemId"/></td>
					<td class="cs-name" style="width: 100px;"><i class="cs-mred">*</i>检测批次：</td>
					<td class="cs-al"><input class="cs-yaoqiu-sort dTotal" type="text"/></td>
					<td class="cs-name" style="width:100px;"><i class="cs-mred">*</i>接收对象：</td>
					<td class="cs-check-radio">
						<input id="jigou" type="radio" name="name" value="0" style="width:auto; margin-top:5px;" /><label for="jigou">机构</label>
						<input id="dian" type="radio" name="name" checked="checked" value="1" style="width:auto; margin-top:5px;"  /><label for="dian">检测点</label>
					</td>
					<td><a href="javascript:" class="cs-menu-btn" onclick="selectReceivingObject();"><i class="icon iconfont icon-zengjia"></i>增加</a></td>
				</tr>
			</table>


		<div class="cs-deliver-jigou">
            <table class="cs-deliver-table" id="orgTable">
                <tr>
                    <th style="width: 10%;">序号</th>
                    <th style="width: 20%;">接收机构/检测点</th>
                    <th style="width: 20%;">食品种类</th>
                    <th style="width: 20%;">检测项目</th>
                    <th style="width: 20%;">检测批次</th>
                    <c:if test="${!empty task && task.taskStatus ne 0}"><th style="width: 10%;">已完成批次</th></c:if>
                    <c:if test="${empty task || task.taskStatus eq 0}"><th style="width: 10%;">操作</th></c:if>
                </tr>
                <c:forEach items="${details}" var="detail" varStatus="item">
                    <tr
                        <c:if test="${!empty detail.receivePointid}"> class="orgItemTr depart-${detail.receivePointid}-${detail.sampleId}-${detail.itemId}" </c:if>
                        <c:if test="${!empty detail.receiveNodeid}"> class="orgItemTr point-${detail.receiveNodeid}-${detail.sampleId}-${detail.itemId}" </c:if>
                    >
                        <td class="dNo">${item.count}</td>
                        <td>${detail.receivePoint}${detail.receiveNode}
                            <input type="hidden" class="dDepartId" value="${detail.receivePointid}"/>
                            <input type="hidden" class="dDepart" value="${detail.receivePoint}"/>
                            <input type="hidden" class="dPointId" value="${detail.receiveNodeid}"/>
                            <input type="hidden" class="dPoint" value="${detail.receiveNode}"/>
                        </td>
                        <input type="hidden" class="dId" value="${detail.id}"/>
                        <td>${detail.sample}<input type="hidden" class="dSample" value="${detail.sample}"/>
                            <input type="hidden" class="dSampleId" value="${detail.sampleId}"/></td>
                        <td><input type="text" class="dItem" value="${detail.item}"/>
                            <input type="hidden" class="dItemId" value="${detail.itemId}"/></td>
                        <td class="cs-pici"><input type="text" class="dTotal" value="${detail.taskTotal}" datatype="n" nullmsg="请输入检测批次" errormsg="请输入检测批次"/></td>
                        <c:if test="${!empty task && task.taskStatus ne 0}">
                            <td>${detail.sampleNumber}</td>
                        </c:if>
                        <c:if test="${empty task || task.taskStatus eq 0}">
                            <td class="delBtn">
                                <a href="javascript:"><img src="${webRoot}/img/del_red.png" title="删除"></a>
                            </td>
                        </c:if>
                    </tr>
                </c:forEach>
            </table>
		</div>
	</div>
	</form>
	
	<div class="cs-table-tab">
		<span class="cs-fr"><em>已完成：</em><strong class="cs-green-text "><span class="totalBatch"><c:if test="${empty task || empty task.sampleNumber}">0</c:if><c:if test="${!empty task}">${task.sampleNumber}</c:if></span>批次</strong></span>
		<span class="cs-fr"><em>总批次：</em><strong class="cs-blue-text"><span class="totalBatch"><c:if test="${empty task || empty task.taskTotal}">0</c:if><c:if test="${!empty task}">${task.taskTotal}</c:if></span>批次</strong></span>
	</div>
	<div class="cs-alert-form-btn clearfix">
		<c:if test="${empty task || task.taskStatus eq 0}">
			<a href="javascript:" class="cs-menu-btn" id="orgSave1">
				<i class="icon iconfont icon-save"></i>保存</a>
			<a href="javascript:" class="cs-menu-btn" id="orgSave2">
				<i class="icon iconfont icon-xiafa"></i>下发</a>
		</c:if>
		<a href="javascript:" class="cs-menu-btn returnBtn">
			<i class="icon iconfont icon-fanhui"></i>返回</a>
	</div>
	
	<!-- 引用模态框 -->
	<%@include file="/WEB-INF/view/detect/depart/selectDepart.jsp"%>
	<%@include file="/WEB-INF/view/detect/basePoint/selectPoint.jsp"%>
	<%@include file="/WEB-INF/view/data/detectItem/selectDetectItem3.jsp"%>
	<%@include file="/WEB-INF/view/data/foodType/selectFoodType.jsp"%>
	<%@include file="/WEB-INF/view/common/confirm.jsp"%>

	<script type="text/javascript">
	
	$(function() {

		//已下达任务，禁用所有控件
		if($("input[name='task.taskStatus']").val() && $("input[name='task.taskStatus']").val()!="0"){
			$("input").attr("disabled","disabled");
			$("select").attr("disabled","disabled");
			$("textarea").attr("disabled","disabled");
		}

	});
	
	//任务验证
	$("#taskForm").Validform({
		beforeSubmit:function(){
			submitTask();
			return false;
		}
	});
			
        //删除任务机构
        $(document).on("click", ".delBtn", function(){
            $(this).parent().remove();
            //重新设置序号
            resetNo();
            //计算总批次
            recalculate();
        });

        //检测机构计算批次总数
        $(document).on("change", ".orgItemTr .dTotal", function(){
            if($(this).parents("tr").find(".dNo").text() != "0"){
                // //重设class
                // var itemSampleId1 = $(this).parents("tr").find(".dSampleId").val();
                // var detectItemId1 = $(this).parents("tr").find(".dItemId").val();
                // var ItemTotal1 = $(this).val();
                // $(this).parents("tr").attr("class", "orgItemTr "+itemSampleId1+"-"+detectItemId1+"-"+ItemTotal1);

                //计算总批次
                recalculate();
            }
        });

        //选择食品
        $(document).on("click", ".dSample", function(){
            itemNo = $(this).parents("tr").find(".dNo").text();
            $('#myFootTypeModal').modal('toggle');
        });

        //选择检测项目
        $(document).on("click", ".dItem", function(){
            itemNo = $(this).parents("tr").find(".dNo").text();
            var itemSampleId1 = $(this).parents("tr").find(".dSampleId").val();
            if(!itemSampleId1){
                $("#confirm-warnning .tips").text("请先选择食品种类");
                $("#confirm-warnning").modal('toggle');
                return;
            }else{
                //根据食品种类重新加载检测项目选项
                myReload(itemSampleId1);
            }
            $('#myDetectItemModal').modal('toggle');
        });

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
		
		//选择接收对象
		function selectReceivingObject(){
			if(!$("#orgItemTable").find(".dSampleId").val()){
				$("#confirm-warnning .tips").text("请先选择食品种类");
    			$("#confirm-warnning").modal('toggle');
			// }else if(!$("#orgItemTable").find(".dItemId").val()){
			// 	$("#confirm-warnning .tips").text("请先选择检测项目");
    		// 	$("#confirm-warnning").modal('toggle');
			}else if(!$("#orgItemTable").find(".dTotal").val()){
				$("#confirm-warnning .tips").text("请先输入检测批次");
    			$("#confirm-warnning").modal('toggle');
			}else if($("#orgItemTable").find(".dTotal").val() == 0 || !$("#orgItemTable").find(".dTotal").val().match(/^\d+$/)){
				$("#confirm-warnning .tips").text("请输入正确检测批次");
    			$("#confirm-warnning").modal('toggle');
			}else{
				var orgType = $("input[type='radio'][name='name']:checked").val();
				if(orgType == "0"){
					//机构
					$('#myDeaprtModal').modal('toggle');
				}else if(orgType == "1"){
					//检测点
					$('#myPointModal').modal('toggle');
				}
			}
		}
		
		//清空任务明细模板
		function cleanTemplate(){
			$(".orgItemTr").each(function(){
				var no = $(this).find(".dNo").text();
				if(no == "0"){
					$(this).find("input").val("");
				}
			});
		}
		
		//添加机构任务
		function addOrgItem(nodes){
			var orgType = $("input[type='radio'][name='name']:checked").val();

            var dSample1 = $("#orgItemTable").find(".dSample").val();
            var dSampleId1 = $("#orgItemTable").find(".dSampleId").val();
            var dTotal1 = $("#orgItemTable").find(".dTotal").val();

            if (itemsInfo) {
                //无检测项目
                if (itemsInfo.length == 0) {
                    itemsInfo.push({"itemNodeText":"","itemNodeId":""});
                }
                $.each(itemsInfo, function(index, val){
                    var dItem1 = val.itemNodeText;
                    var dItemId1 = val.itemNodeId;
                    if(orgType == "0"){
                        //机构
                        if(nodes){
                            //机构任务明细
                            // $("#orgTable .depart-"+dSampleId1+"-"+dItemId1+"-"+dTotal1).remove();
                            for(var i=0; i<nodes.length; i++){
                                if ($("#orgTable .depart-"+nodes[i].id+"-"+dSampleId1+"-"+dItemId1).length == 0) {
                                    var orgItemHtml = "<tr class=\"orgItemTr depart-"+nodes[i].id+"-"+dSampleId1+"-"+dItemId1+"\"><td class=\"dNo\"></td>"
                                        + "<input type=\"hidden\" class=\"dId\" />"
                                        + "<td>"+nodes[i].text+"<input type=\"hidden\" class=\"dDepartId\" value=\""+nodes[i].id+"\"/><input type=\"hidden\" class=\"dDepart\" value=\""+nodes[i].text+"\"/></td>"
                                        + "<td>"+dSample1+"<input type=\"hidden\" class=\"dSample\" value=\""+dSample1+"\""
                                        + "/><input type=\"hidden\" class=\"dSampleId\" value=\""+dSampleId1+"\"/></td>"
                                        + "<td><input type=\"text\" readonly=\"readonly\" class=\"dItem\" value=\""+dItem1+"\""
                                        + "/><input type=\"hidden\" class=\"dItemId\" value=\""+dItemId1+"\"/></td>"
                                        + "<td class=\"cs-pici\"><input type=\"text\" class=\"dTotal\" value=\""+dTotal1+"\" datatype=\"n\" nullmsg=\"请输入检测批次\" errormsg=\"请输入检测批次\"/></td>"
                                        + "<td class=\"delBtn\"><a href=\"javascript:;\">"
                                        + "<img src=\"${webRoot}/img/del_red.png\" title=\"删除\">"
                                        + "</a></td></tr>";
                                    $("#orgTable").append(orgItemHtml);
                                }
                            }
                        }
                    }else if(orgType == "1"){
                        //检测点
                        if(nodes){
                            //检测点任务明细
                            // $("#orgTable .point-"+dSampleId1+"-"+dItemId1+"-"+dTotal1).remove();
                            for(var i=0; i<nodes.length; i++){
                                if ($("#orgTable .point-"+nodes[i]["id"]+"-"+dSampleId1+"-"+dItemId1).length == 0) {
                                    var orgItemHtml = "<tr class=\"orgItemTr point-"+nodes[i]["id"]+"-"+dSampleId1+"-"+dItemId1+"\"><td class=\"dNo\"></td>"
                                    + "<input type=\"hidden\" class=\"dId\" />"
                                    + "<td>"+nodes[i]["name"]+"<input type=\"hidden\" class=\"dPointId\" value=\""+nodes[i]["id"]+"\"/><input type=\"hidden\" class=\"dPoint\" value=\""+nodes[i]["name"]+"\"/></td>"
                                    + "<td>"+dSample1+"<input type=\"hidden\" class=\"dSample\" value=\""+dSample1+"\""
                                    + "/><input type=\"hidden\" class=\"dSampleId\" value=\""+dSampleId1+"\"/></td>"
                                    + "<td><input type=\"text\" readonly=\"readonly\" class=\"dItem\" value=\""+dItem1+"\""
                                    + "/><input type=\"hidden\" class=\"dItemId\" value=\""+dItemId1+"\"/></td>"
                                    + "<td class=\"cs-pici\"><input type=\"text\" class=\"dTotal\" value=\""+dTotal1+"\" datatype=\"n\" nullmsg=\"请输入检测批次\" errormsg=\"请输入检测批次\"/></td>"
                                    + "<td class=\"delBtn\"><a href=\"javascript:;\">"
                                    + "<img src=\"${webRoot}/img/del_red.png\" title=\"删除\">"
                                    + "</a></td></tr>";
                                    $("#orgTable").append(orgItemHtml);
                                }
                            }
                        }
                    }
                });
            }

			//重新设置序号
			resetNo();
			//计算总批次
			recalculate();
			
			//清空模板
			//cleanTemplate();
		}
		
		//提交任务
		function submitTask(){
			//对input的name属性赋值
			var iii = 0;
			var ts = $("input[name='task.taskStatus']").val();//任务状态
			var orgType = $("input[type='radio'][name='name']:checked").val();

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
			
			var formData = new FormData($('#taskForm')[0]);
			$.ajax({
		        type: "POST",
		        url: '${webRoot}'+"/task/addTask",
		        data: formData,
		        contentType: false, //必须false才会避开jQuery对 formdata 的默认处理 XMLHttpRequest会对 formdata 进行正确的处理
		        processData: false, //必须false才会自动加上正确的Content-Type
		        dataType: "json",
		        success: function(data){
		        	if(data && data.success){
		        		$("#confirm-warnning .tips").text("保存成功");
		    			$("#confirm-warnning").modal('toggle');
		    			self.location = '${webRoot}'+"/task/list";
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
		
		//计算总批次
		function recalculate(){
			var orgType = $("input[type='radio'][name='name']:checked").val();
			var totalBatch = 0;
            $("#orgTable .orgItemTr").each(function(){
                if($(this).find(".dTotal").val()){
                    totalBatch += parseInt($(this).find(".dTotal").val());
                }
            });
			//总批次
			$("input[name='task.taskTotal']").val(totalBatch);
			$(".totalBatch:eq(0)").text('0');
			$(".totalBatch:eq(1)").text(totalBatch);
		}
		
		var itemNo;//接收对象列表序号
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
		//设置检测食品
		function selFoot(id,text){
			//清空检测项目
			$("#orgItemTable").find(".dItem").val("");
			$("#orgItemTable").find(".dItemId").val("");
            itemsInfo = [];
			
			if(itemNo=="0"){
				//检测点任务检测食品
				$("#orgItemTable").find(".dSample").val(text);
				$("#orgItemTable").find(".dSampleId").val(id);
				$('#myFootTypeModal').modal('toggle');
			}else{
				//机构任务检测食品
				$(".orgItemTr").each(function(){
					var no = $(this).find(".dNo").text();
					if(no == itemNo){
						$(this).find(".dSample").val(text);
						$(this).find(".dSampleId").val(id);
						
						//重设class
						var detectItemId1 = $(this).find(".dItemId").val();
						var ItemTotal1 = $(this).find(".dTotal").val();
						$(this).attr("class", "orgItemTr "+id+"-"+detectItemId1+"-"+ItemTotal1);
						$('#myFootTypeModal').modal('toggle');
					}
				});
			}
		}
		// //设置检测项目
		// function selDetectItem(id,text){
		// 	if(itemNo=="0"){
		// 		//检测点
		// 		$("#orgItemTable").find(".dItem").val(text);
		// 		$("#orgItemTable").find(".dItemId").val(id);
		// 		$('#myDetectItemModal').modal('toggle');
		// 	}else{
		// 		//机构
		// 		$(".orgItemTr").each(function(){
		// 			var no = $(this).find(".dNo").text();
		// 			if(no==itemNo){
		// 				$(this).find(".dItem").val(text);
		// 				$(this).find(".dItemId").val(id);
		//
		// 				//重设class
		// 				var itemSampleId1 = $(this).find(".dSampleId").val();
		// 				var ItemTotal1 = $(this).find(".dTotal").val();
		// 				$(this).attr("class", "orgItemTr "+itemSampleId1+"-"+id+"-"+ItemTotal1);
		// 				$('#myDetectItemModal').modal('toggle');
		// 			}
		// 		});
		// 	}
		// }


        //设置检测项目
        var itemsInfo = [];
        function selDetectItem2(data){
            if(itemNo=="0"){
                itemsInfo = data;
                if (itemsInfo && itemsInfo.length > 0) {
                    var ins = "";
                    $.each(itemsInfo, function(index, val){
                        ins += val.itemNodeText + ",";
                    });
                    ins = ins.substr(0, ins.length-1);
                    $("#orgItemTable").find(".dItem").val(ins);

                } else {
                    $("#orgItemTable").find(".dItem").val("");
                }
            } else {
                if (!data || data.length == 0) {
                    $(".orgItemTr").each(function(){
                        var no = $(this).find(".dNo").text();
                        if(no==itemNo){
                            //重设class
                            var tcns = $(this).attr("class").split(" ");
                            for (var jj=0; jj<tcns.length; jj++) {
                                var ocn = tcns[jj];
                                if (ocn.indexOf("point-") == 0 || ocn.indexOf("depart-") == 0 ) {
                                    var ncn = ocn.substr(0, ocn.lastIndexOf("-")+1);

                                    if ($("."+ncn).length > 0) {
                                        $("#confirm-warnning .tips").text("存在相同任务");
                                        $("#confirm-warnning").modal('toggle');
                                        return;
                                    }

                                    $(this).find(".dItem").val("");
                                    $(this).find(".dItemId").val("");
                                    // $(this).attr("class", ("orgItemTr " + ncn));

                                    $(this).addClass(ncn);
                                    $(this).removeClass(ocn);
                                }
                            }
                        }
                    });
                } else if (data.length == 1) {
                    $(".orgItemTr").each(function(){
                        var no = $(this).find(".dNo").text();
                        if(no==itemNo){

                            //重设class
                            var tcns = $(this).attr("class").split(" ");
                            for (var jj=0; jj<tcns.length; jj++) {
                                var ocn = tcns[jj];
                                if (ocn.indexOf("point-") == 0 || ocn.indexOf("depart-") == 0 ) {
                                    var ncn = ocn.substr(0, ocn.lastIndexOf("-")+1) + data[0].itemNodeId;

                                    if ($("."+ncn).length > 0) {
                                        $("#confirm-warnning .tips").text("存在相同任务");
                                        $("#confirm-warnning").modal('toggle');
                                        return;
                                    }

                                    $(this).find(".dItem").val(data[0].itemNodeText);
                                    $(this).find(".dItemId").val(data[0].itemNodeId);
                                    // $(this).attr("class", ("orgItemTr " + ncn));

                                    $(this).addClass(ncn);
                                    $(this).removeClass(ocn);
                                }
                            }
                        }
                    });
                } else {
                    $("#confirm-warnning .tips").text("请选择一个检测项目");
                    $("#confirm-warnning").modal('toggle');
                }
            }
        }
		
		//返回
		$(document).on("click", ".returnBtn", function(){
			self.location = '${webRoot}'+"/task/list.do";
		});
		
		//上传控件
	    $("#file-1").fileinput({
	        uploadUrl: '#', // you must set a valid URL here else you will get an error
	        allowedFileExtensions: ['jpg', 'png', 'gif'],
	        overwriteInitial: false,
	        maxFileSize: 1000,
	        maxFilesNum: 10,
	        //allowedFileTypes: ['image', 'video', 'flash'],
	        slugCallback: function (filename) {
	            return filename.replace('(', '_').replace(']', '_');
	        }
	    });
	    $("#file-4").fileinput({
	        uploadExtraData: {kvId: '10'}
	    });
	    $(".btn-warning").on('click', function () {
	        var $el = $("#file-4");
	        if ($el.attr('disabled')) {
	            $el.fileinput('enable');
	        } else {
	            $el.fileinput('disable');
	        }
	    });
	    $(".btn-info").on('click', function () {
	        $("#file-4").fileinput('refresh', {previewClass: 'bg-info'});
	    });
	    $(document).ready(function () {
	        $("#test-upload").fileinput({
	            'showPreview': false,
	            'allowedFileExtensions': ['jpg', 'png', 'gif'],
	            'elErrorContainer': '#errorBlock'
	        });
	        $("#kv-explorer").fileinput({
	            'theme': 'explorer',
	            'uploadUrl': '#',
	            textEncoding:'UTF-8',
	            language: 'zh', 
	            overwriteInitial: false,
	            initialPreviewAsData: true,
	            dropZoneEnabled: false,
	            showClose:false,
	            maxFileCount:10,
	            browseLabel:'浏览',
	        });

			<%--//附件名称--%>
			<%--var filePath0 = '${task.filePath}';--%>
			<%--if (filePath0) {--%>
			<%--	$('.file-caption-name').val(filePath0);--%>
			<%--}--%>
	    });

	</script>
</body>
</html>