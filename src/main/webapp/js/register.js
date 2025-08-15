 var regPhone=/^[1][3,4,5,7,8][0-9]{9}$/;//验证手机号码
 var regPassword=/^\w{6,}$/;//验证密码：6位以上数字+英文+下拉线
 var checkPhone=false;//校验手机号码是否正确
 var checkPassword=false;//校验原密码是否正确
$(function(){
		openwebsocket();//连接扫描服务器
		
		$("#submitBtn").on("click",function(){
			var creditCode=$("#creditCodeCode").val()
			var userName=$("#userName").val();//"userName":userName,
			var password=$("#password").val();
			var phone=$("#phone").val();
			var rePassword=$("#rePassword").val();
			var userType=$(".userType:checked").val();
			if(phone==""){
				tips("请输入手机号码！");
			}else if(!regPhone.test(phone)){
				tips("请输入正确的手机号码！");
			}else if(password==""){
				tips("请输入登录密码！");
			}else if(!regPassword.test(password)){
				tips("请输入6位以上密码，可包含数字，字母和下划线！");
			}else if(rePassword==""){
				tips("请输入确认密码！");
			}else if(password!=rePassword){
				tips("两次密码输入不一致！");
			}else if(checkPhone==false){
				tips("该手机号码已被注册，请更换手机号码进行注册！");
			}else {
				var check=1;//是否审核:0未审核，1已审核 "realName":realName,
				$.ajax({
			        type: "POST",
			        url: webRoot+"/terminal/registerUserByPhone.do",
			        data: {"id":id,"realName":$("#realName").val(),"inspectionId":$("input[name=inspectionId]").val(),"password":$("#password").val(),"userType":userType,"identifiedNumber":creditCode,"phone":$("#phone").val(),"checked":check,"inspectionName":$("#companyName").val()},
    		        dataType: "json",
			        success: function(data){
			        	if(data && data.success){
			        		window.location = webRoot+"/terminal/goHome.do";
//			        		window.location = webRoot+"/terminal/checkPage?userName="+data.obj.phone+"&pwd="+data.obj.password;
			        	}else{
			        		tips(data.msg);
			        	}
					},error: function(e){
						console.log(e);
					}
			    });
			}
		});
		//修改用户基本信息
		$("#submitBtnForInfo").on("click",function(){
			var creditCode=$("#creditCodeCode").val()
//			var userName=$("#userName").val();//"userName":userName,
			var password=$("#password").val();
			var phone=$("#phone").val();
			var rePassword=$("#rePassword").val();
			var userType=$(".userType:checked").val();
			if(phone==""){
				tips("请输入手机号码！");
			}else if(!regPhone.test(phone)){
				tips("请输入正确的手机号码！");
			}
			/*else if($(".userType:checked").val()==1 && creditCode!=""  && $("#companyName").val()==""){
				tips("请输入公司名称！");
			}*/
			else if(checkPhone==false){
				tips("该手机号码已被注册，请更换手机号码进行注册！");
			}else{
				var check=1;//是否审核:0未审核，1已审核 "realName":realName,
				$.ajax({
			        type: "POST",
			        url: webRoot+"/terminal/registerUserByPhone.do",
			        data: {"id":id,"realName":$("#realName").val(),"inspectionId":$("input[name=inspectionId]").val(),"userType":userType,"identifiedNumber":creditCode,"phone":$("#phone").val(),"checked":check,"inspectionName":$("#companyName").val()},
    		        dataType: "json",
			        success: function(data){
			        	if(data && data.success){
			        		tips("修改成功");
//			        		window.location = webRoot+"/terminal/goHome.do";
//			        		window.location = webRoot+"/terminal/checkPage?userName="+data.obj.phone+"&pwd="+data.obj.password;
			        	}else{
			        		tips(data.msg);
			        	}
					},error: function(e){
						console.log(e);
					}
			    });
			}
		});
		//校验原密码是否正确
		 $("#oldPpassword").on("blur",function(){
			 var password=$("#oldPpassword").val();
				 if(password!=""){
					 $.ajax({
					        type: "POST",
					        url: webRoot+"/terminal/checkPassword.do",
					        data: {"id":id,"password":password},
					        dataType: "json",
					        success: function(data){
					        	if(!data.success){
					        		tips("原密码错误，请重新输入！");
					        	}else{
					        		checkPassword=true;
					        	}
							},error: function(e){
								console.log(e);
							}
					    });
				 }
		}); 
		//修改用户密码
		$("#submitBtnForpassword").on("click",function(){
			var password=$("#oldPpassword").val();
			var newPassword=$("#password").val();
			var rePassword=$("#rePassword").val();
			if(password==""){
				tips("请输入原密码！");
			}else if(checkPassword==false){
				tips("原密码错误，请重新输入！！");
			}else if(!regPassword.test(newPassword)){
				tips("请输入6位以上密码，可包含数字，字母和下划线！");
			}else if(rePassword==""){
				tips("请输入确认密码！");
			}else if(newPassword!=rePassword){
				tips("确认密码与密码不一致！");
			}else if(checkPassword==false){
				tips("请输入正确的原密码！");
			}else {
				$.ajax({
			        type: "POST",
			        url: webRoot+"/terminal/updatePassword.do",
			        data: {"id":id,"password":$("#password").val()},
    		        dataType: "json",
			        success: function(data){
			        	if(data && data.success){
//			        		window.location = webRoot+"/terminal/goHome.do";
			        		tips("密码修改成功");
			        	}else{
			        		tips(data.msg);
			        	}
					},error: function(e){
						console.log(e);
					}
			    });
			}
		});
		//校验手机号码是否正确
		 $("#phone").on("blur",function(){
			 var phone=$("#phone").val();
				 if(phone!="" && phone.length>=11 && !regPhone.test(phone)){
					 tips("请输入正确的手机号码！");
				 }else if(phone.length>=11){
					 $.ajax({
					        type: "POST",
					        url: webRoot+"/terminal/checkPhone.do",
					        data: {"phone":phone},
					        dataType: "json",
					        async:false,
					        success: function(data){
					        	if(data.obj!=null && data.obj.id==id){
					        		checkPhone=true;
					        	}else if(!data.success){
					        		tips("该手机号码已被注册，请更换手机号码进行注册！");
					        	}else{
					        		checkPhone=true;
					        	}
							},error: function(e){
								console.log(e);
							}
					    });
				 }
		}); 
		//根据社会信用代码信息查询送检单位信息
		 $("#creditCodeCode").on("blur",function(){
//			 $('.softkeys,.cs-check-down').hide();
			 var regCreditCode=/^[a-zA-Z0-9]{18}$/;//验证统一社会代码是否合格：数字+字母共18位
			 var creditCode=$("#creditCodeCode").val();
			 if($(".userType:checked").val()==1 || $(".userType:checked").val()==2){
				 if(creditCode!="" && creditCode.length<18){
					 tips("请输入正确的社会信用代码！");
					 $("#companyName").val("");
		        	  $("#legalPerson").val("");
				 }else if(creditCode.length==18 && !regCreditCode.test(creditCode)){
					 tips("请输入正确的社会信用代码！");
				 }else if(creditCode==""){
					 $("input[name=inspectionId]").val("");
		        		$("#companyName").val("");
		        		$("#legalPerson").val("");
				 }else{
					 $.ajax({
					        type: "POST",
					        url: webRoot+"/wx/order/checkCreditCode.do",
					        data: {"creditCode":creditCode},
					        dataType: "json",
					        success: function(data){
					        	if(data && data.success){
					        		if(data.obj!=""){
					        			$('.softkeys,.cs-check-down').hide();
					        			$("input[name=inspectionId]").val(data.obj.id);
						        		$("#companyName").val(data.obj.companyName);
						        		$("#legalPerson").val(data.obj.legalPerson);
						        		showCreditCode=creditCode;
						        		showCompany=data.obj.companyName;
					        		}else{
					        			$("#companyName").val("");
					        			tips("未查询到公司信息，请输入正确的社会信用代码！");
					        		}
					        	}else{
					        		tips(data.msg);
					        	}
							},error: function(e){
								console.log(e);
							}
					    });
				 }
			 }else{
				 regCreditCode=/^(^[1-9]\d{7}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}$)|(^[1-9]\d{5}[1-9]\d{3}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])((\d{4})|\d{3}[Xx])$)$/;//验证身份证号码是否正确：数字+1位字母共18位
				 if(!regCreditCode.test(creditCode) && creditCode!=""){
					 tips("请输入正确的身份证号码！");
				 }else{
					 identifiedNumber=creditCode;
				 }
				 
			 }
			
		}); 
	});
	//校验密码
	$("#password").on("blur",function(){
		 var password=$("#password").val();
		 var rePassword=$("#rePassword").val();
		if(password!="" && !regPassword.test(password)){
			tips("请输入6位以上密码，可包含数字，字母和下划线！");
		 }else if(rePassword!="" && password!=rePassword){
			tips("两次密码输入不一致！");
		 }
	}); 
	//校验确认密码
	$("#rePassword").on("blur",function(){
		 var password=$("#password").val();
		 var rePassword=$("#rePassword").val();
		 if(rePassword!="" && !regPassword.test(rePassword) ){
			tips("请输入6位以上密码，可包含数字，字母和下划线！");
		 }else if(password==""){
			 tips("请输入登录密码！");
		 }else if(password!=rePassword){
			tips("两次密码输入不一致！");
		 }
	}); 
	function websocket_decode(message){
		var sampleRegExp =  new RegExp("^("+inspectionUnitPath+")([0-9A-Z])*$");
		if(message.indexOf(inspectionUnitPath)==-1){
			  tips("请扫描正确的二维码！");
		  }else{
			  var id=message.substring(message.indexOf("id")+3,message.length);
			  $.ajax({
			        type: "POST",
			        url: webRoot+"/wx/register/checkUnit.do",
			        data: {"id":id},
			        dataType: "json",
			        success: function(data){
			        	if(data && data.success){
			        		$("input[name=inspectionId]").val(data.obj.id);
			        		$("#creditCodeCode").val(data.obj.creditCode);
			        		$("#companyName").val(data.obj.companyName);
			        		$("#legalPerson").val(data.obj.legalPerson);
			        	}else{
			        		tips(data.msg);
			        	}
					},error: function(e){
						console.log(e);
					}
			    });
		  }
	}