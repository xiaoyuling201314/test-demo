<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <!-- Modal -->
   <style>
        .pay-password-set input[type=text], .pay-password-set input[type=password] {
            border: 1px solid #999;
        }

        .reset-btn {
            height: 39px;
            width: 80px;
            font-size: 16px;
            margin-left: 10px;
            display: inline-block;
            float: right;
        }

        .time-form i {
            right: 100px;
        }
    </style>
<div class="modal fade intro2" id="confirm-setPassword" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="static" data-keyboard="false">
<div class="modal-dialog cs-alert-width">
<div class="modal-content">

<div class="modal-body cs-sm-height pay-password-set" style="">
	<div>
		<p class="zz-ok-text" style="display: inline-block;padding: 10px;">支付密码设置</p>
	</div>
	<ul class="cs-ul-form clearfix">
                    
                    <li class="cs-name col-sm-3 col-md-3"><i class="text-danger">*</i>支付密码：</li>
                    <li class="cs-in-style col-sm-8 col-md-8">
                    	<input type="password" name="payPassword" id="payPassword" class="inputData show-password" autocomplete="off" placeholder="请输入6位数支付密码" maxlength="6">
                    	 <span class="zz-show-btn"><i class="icon iconfont icon-yan"></i> </span>
                    </li>
                </ul>
                <!-- <ul class="cs-ul-form clearfix">
                    
                    <li class="cs-name col-sm-3 col-md-3"><i class="text-danger">*</i>手机号：</li>
                    <li class="cs-in-style col-sm-8 col-md-8">
                    	<input type="text">
						<div class="btn btn-primary" style="position: absolute;right: 10px;top: 10px; line-height: 38px; border-radius: 0 4px 4px 0;width: 110px;">发送消息</div>
                    </li>
                </ul> -->
                <ul class="cs-ul-form clearfix">
                    
                    <li class="cs-name col-sm-3 col-md-3"><i class="text-danger">*</i>确认密码：</li>
                    <li class="cs-in-style col-sm-8 col-md-8">
                    	<input type="password" name="configPassword" id="configPassword" class="inputData show-password" autocomplete="off"  placeholder="请输入确认密码" maxlength="6">
                    </li>
                </ul>
                 <div class="zz-sure-notice" style="padding-top: 10px;">
                    	<div class="col-md-10">
                    		<p><i class="icon iconfont icon-dengpao"></i><b>温馨提示：</b>避免设置与登录密码相同的密码。</p>
                    	</div>
                    </div>
</div>
<div class="modal-footer">
	<button type="button" class="btn btn-danger" data-dismiss="modal">取消</button>
	<button type="button" class="btn btn-primary" id="saveBtn">确定</button>
</div>
</div>
</div>
</div>
 <script type="text/javascript">
 var payType="balance";
 var regExp =  new RegExp("^[0-9]{6}$");
$(function(){
	var i = 0;
	$('.zz-show-btn').click(function(){
		if(i==0){
			$(this).children('i').addClass('icon-biyan').removeClass('icon-yan')
			$('.show-password').prop('type','text');
			i=1;
		}else{
			$(this).children('i').addClass('icon-yan').removeClass('icon-biyan')
			$('.show-password').prop('type','password');
			i=0;
		}
	});
	//校验密码
	$("#payPassword").on("blur",function(){
		 var password=$("#payPassword").val();
		 var configPassword=$("#configPassword").val();
		if(password!="" && !regExp.test(password) ){
			tips("请输入6位数密码！");
		 }else if(configPassword!="" && password!=configPassword){
			tips("两次密码输入不一致！");
		 }
	}); 
	//校验确认密码
	$("#configPassword").on("blur",function(){
		 var password=$("#payPassword").val();
		 var configPassword=$("#configPassword").val();
		 if(configPassword!="" && !regExp.test(configPassword) ){
			tips("请输入6位数密码！");
		 }else if(password==""){
			 tips("请输入支付密码！");
		 }else if(configPassword!="" && password!=configPassword){
			tips("两次密码输入不一致！");
		 }
	}); 
	 $("#saveBtn").click(function(){
		 var payPassword=$("#payPassword").val();
		 var configPassword=$("#configPassword").val();
		 if(!regExp.test(payPassword)){//
			 tips("请输入6位数密码");
		 	return false;
		 }else if(payPassword!=configPassword){
			 tips("两次密码输入不一致");
			 return false;
		 }
		 $.ajax({
			 type: "POST",
             url: "${webRoot}/balance/setPayPassword",
             data: {"payPassword":payPassword},
             dataType: "json",
             success: function (data) {
                 if (data && data.success) {
	                  $("#confirm-setPassword").modal("hide");
                	 if(payType=="balance"){
		                  $("#setBtn").attr("style","display:none;");
                	 }else if(payType=="checkMoney" || payType=="printMoney"){
                		 $(".showInputDiv").removeClass("cs-hide");
                		 $(".showInputPassword").addClass("cs-hide");
                	 }else if(payType=="rechargeSuccess"){
                		 if("${incomeId}"!=""){
                			 location.href="${webRoot}/pay/list.do?incomeId=${incomeId}";
                		 }else{
	                		 location.href="${webRoot}/balance/list";
                		 }
                	 }
                 }else {
                    tips(data.msg);
                 }
             }
		 });
	 });
	//关闭编辑模态框前重置表单，清空隐藏域
	 $('#confirm-setPassword').on('hidden.bs.modal', function (e) {
	 	 $("#payPassword").val("");
	 	 $("#configPassword").val("");
	 });
	 
	 $("#payPassword,#configPassword").on("keyup",function(){
			if($(this).attr("id")=="payPassword"){
			 	var password=$("#payPassword").val(); 
				if(password.length>6){
					$("#payPassword").val(password.substr(0,6));

				}
			}else if($(this).attr("id")=="configPassword"){
			 	var password=$("#configPassword").val(); 
				if(password.length>6){
					$("#configPassword").val(password.substr(0,6));

				}
			}
		});
});
</script>