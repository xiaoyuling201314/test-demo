<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
 <div class="softkeys zz-hide" id="hide-b" data-target="input[name='code']"></div>
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
	            || $(e.target).hasClass('chongzhiMoneyShow')) {
	        e.stopPropagation();
	    } else if ($(e.target).attr("data-type") == "close") {
	        // $('.cs-check-down').show()
	        clearNoChose();
	        $('.softkeys').hide()
	    } else {
	    	var html=$(e.target).context;
	    	if(html.className=='icon iconfont icon-close'){//点击清除按钮时不关闭键盘
	    		clearNoChose();
		        $('.cs-check-down').hide()
	    	}else{
		    	clearNoChose();
		        $('.softkeys,.cs-check-down').hide()
	    	}
	    }

	})
	function clearNoChose(){
		var reg=new RegExp("^[a-z0-9]*$");
		/* if(reg.test($("#inputDataReg").val())){
			$("#inputDataReg").val("");
		} */
		if(reg.test($("#inputDataFood").val())){
			$("#inputDataFood").val("");
		}
		if(reg.test($("#inputDataRegObj").val())){
			$("#inputDataRegObj").val("");
		}
	}
	$(document).on('click', '.cs-check-down ul li', function () {
	    $(this).parents('.cs-check-down').siblings('.cs-input-box').children('.cs-down-input').val($(this).text());
	    $('.cs-check-down').hide();
	})
	$(document).on('click', '.cs-down-arrow', function () {
	    $(this).parents('.cs-input-box').siblings('.cs-check-down').show()
	})
</script>