$(function(){
		 var jspurl = window.location.href;
			$.ajax({
				url: 'http://new.chinafst.cn/dykjfw/wx/sign/getsign', 
				//url: 'http://cola.cross.echosite.cn/dykjfw/wx/sign/getsign', 
		        type: "post",
		        data:{jspurl:jspurl},
		        success: function(data){
		        	var s =data.obj;
		        	wx.config({
		        	    debug: false,
		        	    beta: true,
		        	    appId: s.appId,  
		        	    timestamp: s.timestamp,  
		        	    nonceStr:s.nonceStr,  
		        	    signature: s.signature,  
		        	    jsApiList: [
		        	      'scanQRCode'
		        	    ]
		        	  });
		        	  wx.error(function (res) {
		        		  console.log(res.errMsg);
		        		 // $.MsgBox.Alert("消息", "获取扫码权限失败，请退出到主页!");
		        	  });
		        },
		    });
		});
 


	
  