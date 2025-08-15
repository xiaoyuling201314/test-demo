<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/terminal/resource.jsp"%>
<!doctype html>
<html lang="en" class="no-js">
<head>
<meta name="apple-mobile-web-app-capable" content="yes">
<meta charset="utf-8" />
<title>自助终端</title>
<meta name="description" content="">
<meta name="keywords" content="">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
<style type="text/css">
	.zz-input input{
    width: 74%;
    height: 40px;
    border-radius: 4px;
    outline: none;
    outline: 0;
    font-size: 20px;
    /* font-weight: bold; */
    padding: 0 5px;
    border: 1px solid #999;
    float: left;
    border-radius:  4px 0  0 4px; 
}
.zz-tiqu{
	margin:0;
	border-radius:0 4px 4px 0; 
	margin-left: -1px;
	float: left;
	width:120px;
}
</style>
</head>

<body style="width:1280px;height: 1024px;">
	 <div class="zz-content">
    	<div class="zz-title2">
			<img class="pull-left" src="${webRoot}/img/terminal/title2.png" alt=""><span >打印报告</span>
			 <i class="showTime cs-hide"></i>
    	</div>
		<div class="zz-cont-box">
			
		<div class="zz-tb-bg zz-iframe" style="height:800px;" >
			<div class="col-lg-12 col-md-12 col-sm-12">
				<div class="zz-choose1 col-lg-6 col-md-6 col-sm-6">
					<h3>方式一：</h3>
					<p class="">请扫描二维码获取报告信息</p>
					<img src="${webRoot}/img/terminal/mechine2.png" alt="">

				</div>
				<div class="zz-choose1 zz-input col-lg-6 col-md-6 col-sm-6">
					<h3>方式二：</h3>
					<input type="text" id="reportCode" class="inputData" placeholder="请输入订单号或取报告码" style="text-transform: uppercase">
					<a href="javascirpt:;" class="btn btn-primary zz-tiqu" style="" id="searchOrder">确定</a>
				</div>
				<!-- <div>模拟：<a href="javascirpt:;" data-toggle="modal" data-target="#myModal-lg">未打印过</a> <a href="javascirpt:;" data-toggle="modal" data-target="#myModal-lg2">已打印过</a></div> -->
			</div>
				
			</div>
			<div class="zz-tb-btns col-md-12 col-sm-12">
				<a href="${webRoot}/terminal/index.do" class="btn btn-danger">返回</a>
			</div>

    </div>
		<div class="zz-left"><img src="${webRoot}/img/terminal/left.png" alt=""></div>
		<div class="zz-right"><img src="${webRoot}/img/terminal/right.png" alt=""></div>
    </div>
        <%@include file="/WEB-INF/view/terminal/keyboard_input.jsp"%>
        <%@include file="/WEB-INF/view/common/confirm.jsp"%>
</body>
<%@include file="/WEB-INF/view/terminal/tips.jsp"%>
<script type="text/javascript" src="${webRoot}/js/showTime.js"></script>
<script>
$(function(){
	openwebsocket();//连接扫描服务器
});
//接收扫码结果处理打印
function websocket_decode(message){
// 	var sampleRegExp =  new RegExp("^([Z|X])([0-9A-Z])*$");
	if(message.indexOf("samplingId=")>0 && message.indexOf("collectCode=")>0){
		var samplingId=message.substring(message.indexOf("samplingId=")+11,message.indexOf("&"));
		var collectCode=message.substring(message.indexOf("collectCode=")+12,message.length);
	 	  if(samplingId!='' && collectCode!=''){
	 		$.ajax({
	 			url:"${webRoot}/reportPrint/queryOrder",
	 			data:{"samplingId":samplingId,"collectCode":collectCode},
	 			type:"post",
	 			dataType:"json",
	 			success:function(data){
	 				if(data.success && data.obj!="" && data.obj.length>0){
	 					if(data.attributes.requestCount==1){
			 				location.href="${webRoot}/reportPrint/printAll?samplingId="+samplingId+"&collectCode="+collectCode;
	 					}else{
	 						location.href="${webRoot}/reportPrint/printAllMutl?samplingId="+samplingId+"&collectCode="+collectCode;
	 					}
	 				}else{
	 					tips(data.msg);
	 				}
	 			}
	 		});
	 	}  
	}else{
		tips("请扫描正确的二维码！");
	}
	
}
//输入取报告码打印
$("#searchOrder").on("click",function(){
	if($("#reportCode").val()!=''){
		$.ajax({
 			url:"${webRoot}/reportPrint/queryOrder",
 			data:{"collectCode":$("#reportCode").val().toUpperCase()},
 			type:"post",
 			dataType:"json",
 			success:function(data){
 				if(data.obj!=""){
	 				//location.href="${webRoot}/reportPrint/printBefore?samplingId="+data.obj.id;
	 				var rootPath="";
 					if(data.attributes.requestCount==1){
 						rootPath="${webRoot}/reportPrint/printAll";
	 				}else{//一单多用打印
	 					rootPath="${webRoot}/reportPrint/printAllMutl";
	 				}
	 				if($("#reportCode").val().length>9){
	 					location.href=rootPath+"?samplingId="+data.obj.id;
	 				}else{
	 					location.href=rootPath+"?samplingId="+data.obj.id+"&collectCode="+$("#reportCode").val().toUpperCase();
	 				}
 				}else{
 					tips("报告码过期或输入错误！");
 				}
 			}
 		});
	}
});
</script>
</html>


