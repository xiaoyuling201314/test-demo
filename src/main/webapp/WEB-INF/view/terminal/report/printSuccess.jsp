<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/terminal/resource.jsp"%>
<!doctype html>
<html lang="en" class="no-js">
<head>
<meta charset="utf-8" />
<title>报告打印</title>
<meta http-equiv=Content-Type content="text/html; charset=gb2312">
<meta name=ProgId content=Word.Document>
<meta name=Generator content="Microsoft Word 14">
<meta name=Originator content="Microsoft Word 14">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
<link rel="stylesheet" type="text/css" href="${webRoot}/css/terminal/style.css" />
<style type="text/css">
	html{
		
		width:auto;
		min-height:1024px;
		
	}
</style> 

</head>

<body >
   <div class="zz-content">
   <div class="zz-title2">
        <img class="pull-left" src="${webRoot}/img/terminal/title2.png" alt=""><span >打印报告 </span>
        <i class="showTime cs-hide"></i>
    </div>
		<div class="zz-cont-box">
			<!-- <div class="zz-title2">
			<span >打印报告</span>
			<i class="showTime cs-hide" style="top: 35px;font-size:28px;font-weight:bold;color:#4373e0;border-color:#4373e0;"></i>
    	</div> -->
			<div class="zz-table zz-table2 col-md-12 col-sm-12" style="margin-top: 80px;">
				
				<div class="zz-pay zz-ok zz-no-margin">
					<img src="${webRoot}/img/terminal/dui.png" alt="" style="width: 40px">
					<p class="zz-ok-text" style="display: inline-block;">打印成功</p>
					</div>
					
				<div class="zz-paint-page ">
						<img src="${webRoot}/img/terminal/print2.png" alt="" style="width:260px; margin: 20px 0 10px 0;">
						<div class="zz-notice" style="line-height: 40px;font-size:20px;">
							请在打印口取走报告。
						</div>
						<div style="text-align: center; "> </div>
				</div>
			</div>
			
		<div class="zz-tb-btns zz-tb-btns2 col-md-12 col-sm-12 zz-tb-btns3">
		<c:choose>
				<c:when test="${outPrint==1}">
					<a href="${webRoot}/reportPrint/printNoLogin" class="btn btn-primary">继续打印</a>
					<a href="${webRoot}/terminal/index" type="" class="btn btn-primary" >返回首页</a>
				</c:when>
				<c:otherwise>
					<a href="${webRoot}/reportPrint/list" type="" class="btn btn-primary" >继续打印</a>
					<a href="${webRoot}/terminal/goHome" type="" class="btn btn-primary" >返回首页</a>
					<a href="${webRoot}/terminal/logout" type="" class="btn btn-primary" >退出登录</a>
				</c:otherwise>
			</c:choose>
		</div>
		
    </div>

</div>
</body>
<script type="text/javascript">
var timeCount=30;//总时长
var  showCount=20;//剩余多少秒时显示倒计时 
</script>
 <script type="text/javascript" src="${webRoot}/js/showTime.js"></script>
</html>


