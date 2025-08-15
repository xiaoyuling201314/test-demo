/**
 * 页面倒计时 
 * @author xiaoyl
 * @date 2019-09-11
 * @returns
 */
if(typeof timeCount=="undefined"){//页面未指定时设置默认值
	timeCount=90;
}
if(typeof showCount=="undefined"){//页面未指定时设置默认值
	showCount=30;
}
var currentTime=timeCount;//实时时长
var timeInterval;//定时器对象
$(function(){
	timeInterval=setInterval(function(){
		showDownTime();
		},1000);
});
function showDownTime(){
	currentTime=currentTime-1;
//	console.log("当前时间："+currentTime+"父类时间"+parent.currentTime);
	if(currentTime<=0){
		clearInterval(timeInterval);
		if(typeof callBackFunction=="undefined"){
			location.href=timeoutUrl;
		}else{
			callBackFunction();
		}
	}
	if(currentTime<=showCount && currentTime>0){
		$(".showTime").removeClass("cs-hide");
		$(".showTime").html(currentTime);
	}
}
$(document).click(function (e) {
	currentTime=timeCount;
	parent.currentTime=currentTime;
	$(".showTime").addClass("cs-hide");
	showDownTime();
});
