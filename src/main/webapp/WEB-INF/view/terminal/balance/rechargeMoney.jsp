<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/WEB-INF/view/terminal/resource.jsp"%>

<html>
<head>
    <title>快检服务云平台</title>
    <style>
.zz-prices{
    float: left;
    background: #fff;
    border: 1px solid #999;
    padding: 20px 10px;
    margin-right: 20px;
    margin-bottom: 20px;
    border-radius: 4px;
    font-size: 24px;
    width: 185px;
    height: 140px;
    position: relative;
   }
.zz-etc{
	padding:10px 14px;
	/* padding-top: 30px; */
	clear: both;
	padding-left: 120px;
}
.zz-etc .active{
	background: #299afb;
	color:#fff;
}
.zz-etc .active p,.zz-etc .active .icon{
	color:#fff;
}

.pay-title{
	padding: 0px 10px 10px 10px;;
	font-size: 20px;
}
.zz-prices .icon{
	color: #f5c000;
    font-size: 22px;
}
.top-tip{
	position: absolute;
	left: 0;
	top: 0;
	background: #fb9329;
	color: #fff;
	border-radius: 0 0 0 4px;
    font-size: 16px;
    padding: 3px 5px;
} 
.zz-code{
	padding: 0;
}
.zz-list{
	margin-bottom: 20px;
}
.zz-etc-title{
	font-size: 24px;
    margin-top: 30px;
}
.etc-diy{
	padding:0 10px 10px 10px;
	margin-bottom: 30px;
	position: relative;
}
.etc-diy .icon{
	color: #f5c000;
	font-size: 22px;
}
::-webkit-input-placeholder { /* WebKit, Blink, Edge */    font-size:20; }

:-moz-placeholder { /* Mozilla Firefox 4 to 18 */    font-size:20; }

::-moz-placeholder { /* Mozilla Firefox 19+ */    font-size:20; }

:-ms-input-placeholder { /* Internet Explorer 10-11 */    font-size:20; }

.active .text-danger{
	color:#fff;
}
</style>
</head>
<body>
  <div class="zz-content">
  <div class="zz-title2">
		        <img class="pull-left" src="${webRoot}/img/terminal/title2.png" alt=""><span >充值 </span>
		        <i class="showTime cs-hide"></i>
    		</div>
		<div class="zz-cont-box">
		
			
    		<div class="zz-table zz-center-pay clearfix" style="background: #fff; height: 78%;    margin-top: 30px; padding-top:30px;">
    				<div class="text-left" style="font-size:20px; padding-bottom: 10px;">选择金额：</div>
					<div class="clearfix zz-etc text-center">
					
		            <div class="zz-prices inputData" id="customize">
		            	<i class="icon iconfont icon-qian2"></i>
		            	<p>其他</p>
		            	<p><input type="hidden" class="chongzhiMoney"  data-giftMoney="" data-activite-id="" data-activite-detailId=""></p>
		            </div>
		         	</div>
					<div class="etc-diy" style="margin:0;margin-top: 5px;padding-bottom: 15px;font-size: 20px">
		            	<p style="font-size:30px;"><div style="padding-bottom: 10px;float:left;margin-top:13px;">充值金额：</div>
		            	<div style="padding:10px;float:left;">
		            		¥<input type="text" placeholder="" autocomplete="off" style="text-align:center;font-size:30px;width: 180px;height: 30px;border-bottom: 1px solid #666;border-radius: 0;background: rgba(0,0,0,0);color: #299afb;" class="chongzhiMoneyShow inputData">元<!-- class="chongzhiMoneyShow inputData" --> 
						<i class="text-danger zengsongMoney" style="font-size: 18px;padding-left:10px "></i>
						</div>
		            	</p>
		            </div>
			</div>
		
			<div class="zz-tb-btns col-md-12 " style="position: absolute; bottom: 65px">
				<c:choose>
					<c:when test="${incomeId!=null }">
						<a href="${webRoot}/pay/list.do?incomeId=${incomeId}"  class="btn btn-danger">返回</a>
					</c:when>
					<c:otherwise>
						<a href="${webRoot}/balance/list"  class="btn btn-danger">返回</a>
					</c:otherwise>
				</c:choose> 
				
				<a href="javascript:void(0);" id="rechargeMoney" class="btn btn-primary">下一步</a>
			</div>
</div>

</body>
<%@include file="/WEB-INF/view/terminal/tips.jsp"%>
<%@include file="/WEB-INF/view/terminal/keyboard_number.jsp"%> 
 <script src="${webRoot}/js/num-alignment.js"></script>
<script src="${webRoot}/plug-in/iCheck/icheck.js?v=1.0.2"></script>
<script src="${webRoot}/plug-in/iCheck/js/custom.min.js?v=1.0.2"></script> 
<%@include file="/WEB-INF/view/terminal/tips.jsp"%>
<script type="text/javascript">
var rechargeOption =[];
var rechargeMoney="";//充值金额
var zengsongMoney=0;//赠送金额
var topupId=0;//活动ID
var topupDetailId=0;//活动明细ID 
var activitie;
var topupRemark="";//充值备注
function sortUniqueArray(a, b) {
	return a.actualMoney - b.actualMoney;
}
$(function(){
	if('${activitie}'!=''){// 循环读取优惠充值选项
		activitie=JSON.parse('${activitie}');
		rechargeOption =eval(activitie.detailList); 
		rechargeOption.sort(sortUniqueArray);//顺序排序
		for (var i = 0; i < rechargeOption.length; i++) {
			var html='<div class="zz-prices">';
				html+='<span class="top-tip">优惠</span>';
				html+='	<i class="icon iconfont icon-qian2"></i>';
				html+='<p >'+rechargeOption[i].actualMoney+'元</p>';
				html+='	<p><i class="text-danger" style="font-size: 16px">送'+rechargeOption[i].giftMoney+'元</i></p>';
				html+='	<input type="hidden" class="chongzhiMoney" value="'+rechargeOption[i].actualMoney+'" data-giftMoney="'+rechargeOption[i].giftMoney+'" data-activite-id="'+rechargeOption[i].actId+'" data-activite-detailId="'+rechargeOption[i].id+'"/>';
				html+='</div>';
				$("#customize").before(html);
		}
	}else{// 循环读取默认的充值选项
		rechargeOption = eval('${rechargeConfig}');
		for (var i = 0; i < rechargeOption.length; i++) {
			var html='<div class="zz-prices">';
				html+='	<i class="icon iconfont icon-qian2"></i>';
				html+='<p >'+rechargeOption[i].option+'元</p>';
				html+='	<input type="hidden" class="chongzhiMoney" value="'+rechargeOption[i].option+'" data-activite-id="" data-activite-detailId=""/>';
				html+='</div>';
				$("#customize").before(html);
		}
	}
	//选择充值金额
	$(document).on('click','.zz-etc .zz-prices',function(e){
	    $(this).addClass('active').siblings().removeClass('active');
	    $(".chongzhiMoneyShow").val("");
		 $(".zengsongMoney").text("");
		 topupRemark="";
	    if($(this).attr("id")!="customize"){
	    	$(".chongzhiMoneyShow").attr("disabled","disabled");
			rechargeMoney=$(this).find(".chongzhiMoney").val();
			if('${activitie}'!=''){
				topupId=$(this).find(".chongzhiMoney").attr("data-activite-id");
				topupDetailId=$(this).find(".chongzhiMoney").attr("data-activite-detailId");
				zengsongMoney=$(this).find(".chongzhiMoney").attr("data-giftMoney");
		 	   $(".zengsongMoney").text("送"+zengsongMoney+"元");
		 	  topupRemark=activitie.theme+":充值满¥"+rechargeMoney+"送¥"+zengsongMoney;
			}
		    $(".chongzhiMoneyShow").val(rechargeMoney);
	    }else{
	    	$(".chongzhiMoneyShow").removeAttr("disabled");
	    	$(".inputData").trigger("focus");
	    	e.stopPropagation();
	    }
	  });
	//输入自定义金额
	$(".chongzhiMoneyShow").on("keyup",function(){
		topupId=0;
		topupDetailId=0;
		topupRemark="";
		rechargeMoney=parseFloat($(".chongzhiMoneyShow").val()); 
		var reg =new RegExp('^([1-9][0-9]{0,5})$');
		$(".zengsongMoney").text("");
		if(!reg.test(rechargeMoney) && $(".chongzhiMoneyShow").val()!=""){
			console.log($(".chongzhiMoneyShow").val().substr(0,6));
			$(".chongzhiMoneyShow").val($(".chongzhiMoneyShow").val().substr(0,6));
		}
		for (var i =rechargeOption.length-1; i>=0 ; i--) {
			if(rechargeMoney>=rechargeOption[i].actualMoney){
				zengsongMoney=rechargeOption[i].giftMoney;
				$(".zengsongMoney").text("送"+zengsongMoney+"元");
				topupId=rechargeOption[i].actId;
				topupDetailId=rechargeOption[i].id;
				topupRemark=activitie.theme+":充值满¥"+rechargeOption[i].actualMoney+"送¥"+zengsongMoney;
				break;
			}
		}
	});
	//默认选中第一个面值
	$(".zz-etc .zz-prices").eq(0).click();
	//点击充值
	$(document).on('click','#rechargeMoney',function(){
		if($(".chongzhiMoneyShow").val()==""){
			tips("请选择或输入充值金额！");
		}else{
			rechargeMoney=parseFloat($(".chongzhiMoneyShow").val());
		    $.ajax({
	            type: "POST",
	            url: "${webRoot}/balance/prepareRecharge.do",
	            data: {"rechargeMoney":rechargeMoney,"topupId":topupId,"topupDetailId":topupDetailId,"activitieUuid":"${activitieUuid}","topupRemark":topupRemark},
	            dataType: "json",
	            success: function (data) {
	            	if(data.resultCode=="10005"){
	            		tips("充值活动已结束，请重新选择！");
	            		location.reload();
	            	}else if(data && data.success){
	                     //跳到支付页面
	                     location.href="${webRoot}/balance/rechargeList.do?incomeId="+data.obj.id+"&topupDetailId="+topupDetailId;
	                 }
	            }
	        });
		}
	  });
/* 	$(document).on('click','.chongzhiMoney',function(){
		$('.softkeys').show()
		$('.inputData').attr('name','')
		$(this).attr('name','code');
	  });   */
});

</script>
<script type="text/javascript" src="${webRoot}/js/showTime.js"></script>
</html>
