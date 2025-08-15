//方法调用方式
/*   $("#add").bind("click", function () {  
 $.MsgBox.Alert("消息", "签到成功！");
 });
 //回调函数可以直接写方法function(){}
 //方式1 直接函数
 $.MsgBox.Confirm("解绑用户", "确认解绑当前用户？", function () {
 console.log("天线宝宝")
 });
 //方式2 写函数名称即可
 $.MsgBox.Alert("消息", data.msg, xxoo);
 function xxoo() {
 alert("x_x o_o")
 };
 */
 

(function () {
	$.MsgBox = {
			Alert: function (title, msg, callback) {
				GenerateHtml("alert", title, msg);
				btnNo();
			},
			Confirm: function (title, msg,n, callback) {
				GenerateHtml("confirm", title, msg,n);
				btnNo();
			}
	}
	
	
	var GenerateHtml = function (type, title, msg,n) {
		var _html = "";
		_html += '<div class="zz-back-modal zz-back-modal3" id="mb_box"><div class="zz-del-warn">';
		_html += '<p class="zz-warn-text">'+title+'</p ><p class="zz-warn-text2">'+msg+'</p >';
		
		if (type == "alert") {
			_html += '<div class="zz-btns clearfix"><div class="zz-del-sure" style="width:100%; "  id="mb_btn_ok">确定</div></div>';
		}
		if (type == "confirm") {
			_html += '<div class="zz-btns clearfix">';
			_html += '<div class="zz-del-can" id="mb_btn_qx">取消</div>';
			_html += '<div class="zz-del-sure"  onclick="affirm('+n+');">确定</div>';
			_html += '</div>';
		}
		
		_html +='';
		_html += '</div></div>';
		
		$("body").append(_html);
		
	}
	
	//后续点击事件
	var btnNo = function () {
		$("#mb_btn_ok,#mb_btn_qx").click(function () {
			$("#mb_box,#mb_con").remove();
		});
	};   
	
	
	
})();  

//可传参回调方法
(function () {
    $.MsgBox1 = {
        Alert: function (title, msg, callback) {
            GenerateHtml("alert", title, msg,null,callback);
            btnNo();
        },
        Confirm: function (title, msg,n, callback) {
            GenerateHtml("confirm", title, msg,n,callback);
            btnNo();
        }
    }

    
           var GenerateHtml = function (type, title, msg,n,callback) {
               var _html = "";
               _html += '<div class="zz-back-modal zz-back-modal3" id="mb_box"><div class="zz-del-warn">';
               _html += '<p class="zz-warn-text">'+title+'</p ><p class="zz-warn-text2">'+msg+'</p >';
               
               if (type == "alert") {
//                   _html += '<div class="zz-btns clearfix"><div class="zz-del-sure" style="width:100%; "  id="mb_btn_ok">确定</div></div>';
                 if(callback!=undefined){
                	 _html += '<div class="zz-btns clearfix"><div class="zz-del-sure" style="width:100%; "  onclick="'+callback+';">确定</div></div>';
                 }else{
                	 _html += '<div class="zz-btns clearfix"><div class="zz-del-sure" style="width:100%; "  id="mb_btn_ok">确定</div></div>';
                 }
            	   
               }
               if (type == "confirm") {
            	   _html += '<div class="zz-btns clearfix">';
            	   _html += '<div class="zz-del-can" id="mb_btn_qx">取消</div>';
                   _html += '<div class="zz-del-sure"  onclick="'+callback+';">确定</div>';
                   _html += '</div>';
               }
               
               _html +='';
               _html += '</div></div>';

               $("body").append(_html);

           }

    //后续点击事件
    var btnNo = function () {
 
    $("#mb_btn_ok,#mb_btn_qx").click(function () {
        $("#mb_box,#mb_con").remove();
    });
    };   
 

 
})();  