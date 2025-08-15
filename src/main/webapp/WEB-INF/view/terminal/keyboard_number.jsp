<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<style>
	.softkeys__btn[data-type="delete"]{
	    width: 66px;
    	padding: 0;
	}
	.softkeys__btn:nth-child(15){
		background:#ddd;
	}
</style>
 <div class="softkeys zz-hide" id="hide-b" data-target="input[name='code']" style="width: 400px;"></div>
 <script type="text/javascript" src="${webRoot}/plug-in/jQueryKeyboard/js/softkeys-0.0.1.js"></script>        
 <script type="text/javascript">
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

		                            '1', '2', '3',  
		                            'close'
		                        ],

		                        [
		                        	'4','5', '6',
		                        ],
		                        [
		                        	'7','8', '9',
		                        ],
		                        [
		                        	'','0', 'delete'
		                        ]

		                    ]
	});
	$(".inputData").on("focus", function (e) {
		$(".inputData").removeAttr("name");
		$(this).attr("name","code");
	    $('.cs-check-down,.softkeys').hide();
	    $(this).parents('.cs-input-box').siblings('.cs-check-down').show();
	    $('.softkeys').show();
	});
	$(".inputData").on("click", function (e) {
		$(".inputData").removeAttr("name");
		$(this).attr("name","code");
	    $('.cs-check-down,.softkeys').hide();
	    $(this).parents('.cs-input-box').siblings('.cs-check-down').show();
	    $('.softkeys').show();
	});
	$(document).on('click', '.softkeys__btn[data-type="close"]', function () {
	    $('.softkeys').hide()
	})


	$(document).click(function (e) {
	    if ($(e.target).hasClass('softkeys') || $(e.target).hasClass('softkeys__btn') || $(e.target).hasClass(
	            'm-key') || $(e.target).hasClass('cs-check-down') || $(e.target).hasClass('cs-down-input') || $(e.target).hasClass('notice')
	            || $(e.target).hasClass('pay-input') || $(e.target).hasClass('inputData')) {
	        e.stopPropagation();
	    } else if ($(e.target).attr("data-type") == "close") {
	        // $('.cs-check-down').show()
	        clearNoChose();
	        $('.softkeys').hide()
	    } else {
	    	var html=$(e.target).context;
	    	if(html.className=='icon iconfont icon-close'){//点击清除按钮时不关闭键盘
		        $('.cs-check-down').hide()
	    	}else{
		        $('.softkeys,.cs-check-down').hide()
	    	}
	    }

	})
	$(document).on('click', '.cs-check-down ul li', function () {
	    $(this).parents('.cs-check-down').siblings('.cs-input-box').children('.cs-down-input').val($(this).text());
	    $('.cs-check-down').hide();
	})
	$(document).on('click', '.cs-down-arrow', function () {
	    $(this).parents('.cs-input-box').siblings('.cs-check-down').show()
	})
</script>