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
              <li class="cs-b-active cs-fl">任务详情
              </li>
            </ol>
          <!-- 面包屑导航栏  结束-->
	          <div class="cs-search-box cs-fr">
				<div class="clearfix cs-fr">
					<a href="javascript:" class="cs-menu-btn returnBtn"><i class="icon iconfont icon-fanhui"></i>返回</a>
				</div>
	          </div>
          </div>

          <!-- 任务信息 开始 -->
          <div class="cs-col">
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
                    <td class="cs-name">任务类型：</td>
                    <td class="cs-al">
                    	<c:if test="${!empty recTask}">
                    		${recTask.taskType}
                    	</c:if>
                    </td>
                    <%-- <td class="cs-name">任务批次：</td>
                    <td class="cs-al">
                    	<c:if test="${!empty recTask}">
                    		${recTask.detailTotal}
                    	</c:if>批次
                    </td> --%>
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
                  	<%-- <td class="cs-name">状态：</td>
                    <td class="cs-al">
                    	<c:if test="${!empty recTask && recTask.taskStatus eq 1}">已接收</c:if>
                    </td> --%>
                    <td class="cs-name">任务来源：</td>
                    <td class="cs-al">
                    	<c:if test="${!empty recTask}">
                    		${recTask.taskSource}
                    	</c:if>
                    </td>
                  </tr>
                  <tr>
                      <td class="cs-name">发布人：</td>
                      <td class="cs-al">
                          <c:if test="${!empty recTask}">
                              ${recTask.announcer}
                          </c:if>
                      </td>
                      <td class="cs-name">发布时间：</td>
                      <td class="cs-al">
                          <c:if test="${!empty recTask}">
                              <fmt:formatDate type="both" value="${recTask.taskCdate}" />
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
                    <td class="cs-name">任务备注：</td>
                    <td class="cs-al" colspan="5">
                    	<c:if test="${!empty recTask}">
                    		${recTask.taskRemark}
                    	</c:if>
                    </td>
                  </tr>
                </table>
               <div class="cs-content2">
               	 <h3>任务内容</h3>
               </div>
               <table class="cs-form-table cs-detail-table cs-form-table-he">
                  <tr>
                    <td class="cs-name">食品种类：</td>
                    <td class="cs-al">
                    	<c:if test="${!empty recTask}">
                    		${recTask.sample}
                    	</c:if>
                    </td>
                    <td class="cs-name">检测项目：</td>
                    <td class="cs-al">
                    	<c:if test="${!empty recTask}">
                    		${recTask.item}
                    	</c:if>
                    </td>
                    <td class="cs-name">检测批次：</td>
                    <td class="cs-al">
                    	<c:if test="${!empty recTask}">
                    		${recTask.detailTotal}
                    	</c:if>批次
                    </td>
                  </tr>
                  <tr>
                    <td class="cs-name">已完成：</td>
                    <td class="cs-al">
                    	<c:if test="${!empty recTask}">
                    		${recTask.sampleNumber}
                    	</c:if>批次
                    </td>
                    <td class="cs-name">完成率：</td>
                    <td class="cs-al" colspan="3">
                    	<c:if test="${!empty recTask}">
                    		${recTask.schedule}
                    	</c:if>%
                    </td>
                  </tr>
                </table>

	<!-- JavaScript -->
	<script type="text/javascript">
	$(function(){
		//返回
		$(document).on("click", ".returnBtn", function(){
			self.location = '${webRoot}'+"/task/receiveList.do";
			//self.history.back();
		});
	});
	</script>
</body>
</html>