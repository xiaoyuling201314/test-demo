<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/WEB-INF/view/terminal/resource.jsp"%>

<html>
<head>
    <title>快检服务云平台</title>
</head>
<body>
 <div class="zz-content">
		<div class="zz-cont-box" style="top:10px;">
			<div class="zz-title2">
			<span >收银台</span>
			 <i class="showTime cs-hide"></i>
    	</div>
			<div class="zz-table zz-table2 col-md-12 col-sm-12" style="">
				<div class="zz-pay zz-ok zz-no-margin">
						<div style="display:table; width: 100%;">
							<div style="display:table-cell; font-size: 20px;font-weight: 600;line-height: 40px; ">
							<img src="${webRoot}/img/terminal/dui.png" alt="" style="width: 40px"><span style="margin-left:10px;font-size:20px; font-weight:bold;">支付成功</span>
							</div>
						</div>
						<div style="text-align:left;margin-top:20px;">
							<p class="zz-ok-text" >订单编号：${tbSampling.samplingNo } </p>
							<p class="zz-ok-text" >支付流水：${bean.number }</p>
						</div>
						</div>
					<div class="zz-paint-page ">
						<div class="zz-notice" style="line-height: 40px">
							<img src="${webRoot}/pay/generatorBarCode.do?qrCode=${tbSampling.samplingNo}&width=300&height=100" style="width: 250px;" alt="">
							 <br>
							 ${tbSampling.samplingNo}
							<%-- 打印报告唯一码：<i class="text-code">${tbSampling.reportCode}</i> --%>
							<p>
								<!-- <i class="text-danger">（二维码和唯一码可用于打印报告，用手机拍照保存以便使用）</i><br> -->
							<i class="text-danger">（条形码用于收样窗口使用，请用手机拍照保存以便使用）</i><br>
							</p>
							<p id="printMsg"></p>
						</div>
						<div style=" text-align: center; "></div>
				</div>
				<div class="zz-paint-page ">
						<img src="${webRoot}/img/terminal/print3.png" alt="" style="width:260px; margin: 20px 0 10px 0;">
						<div class="zz-notice" style="line-height: 40px;font-size:20px;">
							请将下单凭证与样品拿到收样窗口收样。
						</div>
						<div style="text-align: center; "> </div>
				</div>
			</div>
			<div class="zz-tb-btns zz-tb-btns2 zz-tb-btns3 col-md-12 col-sm-12">
			    <a onclick="printTicket();" type="" class="btn btn-primary" id="printTicket" >打印凭证</a>
				<a href="${webRoot}/order/terminalOrder" type="" class="btn btn-primary" >继续下单</a>
				<a href="${webRoot}/terminal/goHome" type="" class="btn btn-primary" >返回首页</a>
				<a href="${webRoot}/terminal/logout" type="" class="btn btn-primary" >退出登录</a>
			</div>
    </div>

</div>
</body>
<script type="text/javascript" src="${webRoot}/js/printTicket.js"></script>
<script type="text/javascript">
var timeCount=30;//总时长
var  showCount=20;//剩余多少秒时显示倒计时
$(function(){

	//获取打印机状态
   /*   bytes=new Uint8Array(3);
     bytes[0]=0x1b;
     bytes[1]=0x21;
     bytes[2]=0x3f;
	console.log(bytes); */
	printTicket();
});
var printNum=0;
function printTicket(){
	printNum+=1;
	if(printNum<=3){
		//发送打印命令
		var sublength=10;
	 	var line="${tbSampling.inspectionName}".length/sublength;
		var printLine="${tbSampling.inspectionName}".length%sublength==0 ? line : parseInt(line)+1;
		var d=new Date().format("yyyy/MM/dd HH:mm:ss")
		var inspectionName="${tbSampling.inspectionName}";
	 	sendMessage = "SIZE 58 mm, "+(40+(printLine*5))+" mm\r\n CODEPAGE UTF-8\r\n CLS\r\n" ;
		for(var i=0;i<=printLine-1;i++){
			if(i==0){
				sendMessage+="TEXT 60,"+((i+1)*60)+",\"TSS24.BF2\",0,1,1,\"送检单位:"+inspectionName.substr((i*sublength),sublength)+"\"\r\n" ;
			}else{
				sendMessage+="TEXT 160,"+((i+1)*50)+",\"TSS24.BF2\",0,1,1,\""+inspectionName.substr((i*sublength),sublength)+"\"\r\n" ;
			}
			if(i==printLine-1){//拼接打印时间和一维码
				sendMessage+="TEXT 60,"+(((printLine+1))*50)+",\"TSS24.BF2\",0,1,1,\"打印时间:"+d+"\"\r\n" ;
				sendMessage+="BARCODE 60,"+((printLine+2)*50)+",\"128\",100,2,0,3,7,\"${tbSampling.samplingNo}\"\r\n";
				sendMessage+="TEXT 60,"+((printLine+5)*50)+",\"TSS24.BF2\",0,1,1,\"温馨提示:请向收样窗口出示此码\"\r\n" ;
			}
		}
		sendMessage+="PRINT 1,1\r\n" ;
		sendMessage+="SOUND 5,100\r\n" ;
		sendMessage+="CUT\r\n";
		sendMessage+="OUT \"ABCDE\"\r\n";  
		//	$("#printMsg").text(sendMessage);
	  	sendCommand(); 
	}else{
		$("#printTicket").attr("disabled","disabled")
	}
	
}
//将字符串转为 Array byte数组
function stringToByte(str) {  
	    var bytes = [];
	    var len, c;  
	    len = str.length;  
	    for(var i = 0; i < len; i++) {  
	        c = str.charCodeAt(i);  
	        if(c >= 0x010000 && c <= 0x10FFFF) {  
	            bytes.push(((c >> 18) & 0x07) | 0xF0);  
	            bytes.push(((c >> 12) & 0x3F) | 0x80);  
	            bytes.push(((c >> 6) & 0x3F) | 0x80);  
	            bytes.push((c & 0x3F) | 0x80);  
	        } else if(c >= 0x000800 && c <= 0x00FFFF) {  
	            bytes.push(((c >> 12) & 0x0F) | 0xE0);  
	            bytes.push(((c >> 6) & 0x3F) | 0x80);  
	            bytes.push((c & 0x3F) | 0x80);  
	        } else if(c >= 0x000080 && c <= 0x0007FF) {  
	            bytes.push(((c >> 6) & 0x1F) | 0xC0);  
	            bytes.push((c & 0x3F) | 0x80);  
	        } else {  
	            bytes.push(c & 0xFF);  
	        }  
	    }  
	    return bytes;  
	}
//byte数组转字符串
function byteToString(arr) {
	if(typeof arr === 'string') {
		return arr;
	}
	var str = '',
		_arr = arr;
	for(var i = 0; i < _arr.length; i++) {
		var one = _arr[i].toString(2),
			v = one.match(/^1+?(?=0)/);
		if(v && one.length == 8) {
			var bytesLength = v[0].length;
			var store = _arr[i].toString(2).slice(7 - bytesLength);
			for(var st = 1; st < bytesLength; st++) {
				store += _arr[st + i].toString(2).slice(2);
			}
			str += String.fromCharCode(parseInt(store, 2));
			i += bytesLength - 1;
		} else {
			str += String.fromCharCode(_arr[i]);
		}
	}
return str;
}
</script>
<script type="text/javascript" src="${webRoot}/js/showTime.js"></script>
</html>
