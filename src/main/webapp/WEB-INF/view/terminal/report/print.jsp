<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/terminal/resource.jsp"%>
<!doctype html>
<html lang="en" class="no-js">
<head>
<meta charset="utf-8" />
<title>自助终端</title>
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

<body style="tab-interval: 21pt; text-justify-trim: punctuation;" >
 	<div class="zz-content" id="myContent1"  >
		<div class="zz-cont-box" style="top:10px;">
			<div class="zz-title2"><span >打印状态</span></div>
			<div class="zz-table zz-table2 col-md-12 col-sm-12" style="">
				<div class="zz-pay zz-ok zz-no-margin">
					<img src="${webRoot}/img/terminal/zhong.png" alt="" style="width: 40px">
					<p class="zz-ok-text" style="display: inline-block;">打印中...</p>
					</div>
				<div class="zz-paint-page ">
						<div class="zz-notice" style="line-height: 40px">正在打印中请稍后。</div>
						<div style="text-align: center;"></div>
				</div>
				<div style="text-align: center"><a href="print-status.html">打印成功</a> <a href="print-fail.html">打印失败</a></div>
			</div>
    	</div>
    </div> 
 
</body>

<script>
$(function(){
	setTimeout(function(){
			{
				location.href="${webRoot}/reportPrint/printSuccess.do";
			}
		},1500);
	function bgH(){
		var conH=$('.zz-cont-box').height();
		var selectH=$('.zz-select').height();
		var btnsH=$('.zz-tb-btns').height();
		var codeH=$('.zz-code').height()
		var priceH=$('.zz-price-all').height()
		$('.zz-tb-bg').height(conH-selectH-btnsH-codeH-priceH-40);
	}

	$(window).resize(function(){
		bgH();
	})
	bgH();
})
</script>
</html>


