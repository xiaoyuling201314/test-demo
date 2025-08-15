<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/WEB-INF/view/terminal/resource.jsp"%>

<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="initial-scale=1, maximum-scale=1, user-scalable=no">
    <meta name="format-detection" content="telephone=no">
    <title></title>
</head>
<body>
 <div class="zz-content">
		<div class="zz-cont-box" style="top:10px;">
			<div class="zz-title2">
			<span >审核状态</span>
    	</div>
			<div class="zz-table zz-table2 col-md-12 col-sm-12" style=" ">
				<%-- 
				<div class="zz-pay zz-ok zz-no-margin">
					<img src="${webRoot}/img/terminal/dui.png" alt="" style="width: 40px">
					<p class="zz-ok-text" style="display: inline-block;">打印成功</p>
					</div> --%>
					
				<div class="zz-paint-page ">
						<div class="zz-notice" style="line-height: 40px">
							账号审核中，请耐心等候。
						</div>
						<div style="text-align: center; "> </div>
				</div>
			</div>
			
		<div class="zz-tb-btns zz-tb-btns2 col-md-12 col-sm-12">
		<a href="${webRoot}/terminal/index" class="btn btn-default btn-danger">返回</a>
		</div>
		
    </div>
 </body>
</html>