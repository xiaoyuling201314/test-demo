<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
 <!-- 普通input输入框键盘 -->
 <div class="softkeys zz-hide" id="hide-b" data-target="input[name='code']"></div>
 <script type="text/javascript" src="${webRoot}/plug-in/jQueryKeyboard/js/softkeys-0.0.1.js"></script>        
 <script type="text/javascript">
 $(function(){
	 $('.inputData').click(function(){
			$('.softkeys').show()
			$('.inputData').attr('name','')
			$(this).attr('name','code');
	})
 });
 function Div(name) {
	    var my = document.getElementById(name);
	    if (my) {
	        $('#keyboard').remove()
	    }
	}

	Div("keyboard")
	//创建一个div
	var my = document.createElement("div");
	//添加到页面
	$('.key-box').append(my);
	my.id = "keyboard";
	my.className = "softkeys center-block";
	var attr = document.getElementById("keyboard");
	// attr.setAttribute("data-target", "input[id='form-account']")
	$('.softkeys').softkeys({
	    target: $('.softkeys').data('target'),
	    layout: [
	                    	 	[

		                            '1', '2', '3', '4', '5', '6', '7', '8', '9', '0',
		                            'close',
		                            'delete'
		                        ],

		                        [
		                            'q', 'w', 'e', 'r', 't', 'y', 'u', 'i', 'o', 'p'

		                        ],
		                        [

		                            'a', 's', 'd', 'f', 'g', 'h', 'j', 'k', 'l'

		                        ],
		                        [

		                            'z', 'x', 'c', 'v', 'b', 'n', 'm',
		                            '-', '_'
		                        ]

		                    ],
        notice:'', 
		                    
	});
	
	$(document).on('click', '.softkeys__btn[data-type="close"]', function () {
	    $('.softkeys').hide()
	})
$(document).click(function (e) {
	    if ($(e.target).hasClass("inputData") || $(e.target).hasClass('softkeys') || $(e.target).hasClass('softkeys__btn') || $(e.target).hasClass(
	            'm-key') || $(e.target).hasClass('cs-check-down') || $(e.target).hasClass('cs-down-input') || $(e.target).hasClass('notice')) {
	        e.stopPropagation();
	    } else if ($(e.target).attr("data-type") == "close") {
	        // $('.cs-check-down').show()
	        $('.softkeys').hide()
	    } else {
	        $('.softkeys,.cs-check-down').hide()
	    }

	})

</script>