<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/wx/wxResource.jsp"%>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="initial-scale=1, maximum-scale=1, user-scalable=no">
	<meta name="format-detection" content="telephone=no">
	<link rel="stylesheet" href="${webRoot}/plug-in/swiperTab/css/swiper-3.2.7.min.css" />
	<link rel="stylesheet" type="text/css" href="${webRoot}/css/iconfont/iconfont.css" />
	<link rel="stylesheet" type="text/css" href="${webRoot}/css/bootstrap.css">
	<link rel="stylesheet" type="text/css" href="${webRoot}/css/index.css">
	<style>
		.weui-loadmore {
			width: 65%;
			margin: 1.5em auto;
			line-height: 1.6em;
			font-size: 14px;
			text-align: center;
		}

		.weui-loadmore__tips {
			display: inline-block;
			vertical-align: middle;
		}

	</style>
</head>
<body>
<div class="ui-dtpicker is-flex clearfix" style="border-bottom:1px solid #ddd;" id="_cd_div">
	<div class="ui-data is-flex"><i class="icon iconfont icon-daka"></i>
		<div id="over-btn" class="ui-data-btn"><span class="ui-select-name">近1个月</span><i class="icon iconfont icon-xia1"></i></div>
		<ul class="ui-data-ul cs-hide" id="over-btn2">
			<li class="ui-data-select ui-data-on">近1年</li>
			<li class="ui-data-select ui-data-on">近3个月</li>
			<li class="ui-data-select">近1个月</li>
		</ul>
	</div>
	<div class="search-form is-flex">
		<input type="text" id="search2" class="ui-search-time" placeholder="输入搜索关键词" autocomplete="off">
		<button class="btn btn-default" onclick="query1();">搜索</button>
	</div>
</div>
<div class="invoice-list clearfix" id="checkData"></div>

<div style="display: none" id="mb1">
	<div class="invoice-li invoice-control">
		<a class="is-flex" href="#">
			<div class="zz-food dis-t">
				<div class="invoice-top is-flex">
					<span class="text-primary piao-detail" href="javascript:;"><b class="_food_name"></b></span>
				</div>
				<div class=" text-left invoice-info">
					<p>检测项目：<span class="_item_name"></span></p>
				</div>
				<div class=" text-left invoice-info">
					检测结果：<i class="text-primary">合格</i>
				</div>
				<div class=" text-left invoice-info">
					检测时间：<span class="_check_date"></span>
				</div>
				<div class=" text-left invoice-info">
					档口编号：<span class="_reg_user_name"></span>
				</div>
			</div>
		</a>
	</div>
</div>
<div style="display: none" id="mb2">
	<div class="invoice-li invoice-control">
		<a class="is-flex" href="#">
			<div class="zz-food dis-t">
				<div class="invoice-top is-flex">
					<span class="text-primary piao-detail" href="javascript:;"><b class="_food_name"></b></span>
				</div>
				<div class=" text-left invoice-info">
					<p>检测项目：<span class="_item_name"></span></p>
				</div>
				<div class=" text-left invoice-info">
					检测结果：<i class="text-danger">不合格</i>
				</div>
				<div class=" text-left invoice-info">
					检测时间：<span class="_check_date"></span>
				</div>
                <div class=" text-left invoice-info">
                    档口编号：<span class="_reg_user_name"></span>
                </div>
			</div>
		</a>
	</div>
</div>
<div style="display: none;width:100%;" id="mb3">
	<div class="weui-loadmore" style="width:100%;text-align:center;margin:15px auto 20px;">
		<span class="weui-loadmore__tips" onclick="pin();">加载更多</span>
	</div>
</div>
</body>
<script type="text/javascript" src="${webRoot}/plug-in/swiperTab/js/swiper-3.4.0.jquery.min.js"></script>
<script type="text/javascript">

	$(document).click(function(e) {
		if ($(e.target).hasClass('ui-data-btn') || $(e.target).hasClass('ui-select-name')){
			$("#over-btn2").show();
		}else{
			$("#over-btn2").hide();
		}

	});

	$(document).on('click', '.ui-data-ul li', function(event) {
		var val0 = $('.ui-select-name').text();

		$(this).addClass('ui-data-on').siblings().removeClass('ui-data-on');
		$('.ui-select-name').html(($(this).html()));

		if (val0 != $(this).html()) {
			query1();
		}
	});


	var regId = ${regId};
	query1();
	function query1() {
		var start = "";
		switch ($(".ui-select-name").text()) {
			case "近1年":
				start = newDate().DateAdd("y", -1).format("yyyy-MM-dd");
				break;
			case "近3个月":
				start = newDate().DateAdd("m", -3).format("yyyy-MM-dd");
				break;
			default:
				start = newDate().DateAdd("m", -1).format("yyyy-MM-dd");
				break;
		}
		$.ajax({
			url: "${webRoot}/iRegulatory/regObjectApp2CheckDataJson",
			type : "post",
			data:{"id":regId, "start":start, "end":newDate().format("yyyy-MM-dd"), "keyword":$("#search2").val(), "keyword":$("#search2").val()},
			success : function(data) {
				$("#checkData").html("");
				if (data && data.checkData) {
					pin(data.checkData);
					// for (var i=0; i<data.checkData.length; i++) {
					// 	var mb;
					// 	if ("合格" == data.checkData[i].conclusion) {
					// 		mb = $("#mb1").clone();
					// 	} else if ("不合格" == data.checkData[i].conclusion) {
					// 		mb = $("#mb2").clone();
					// 	}
					// 	mb.find("._food_name").text(data.checkData[i].food_name);
					// 	mb.find("._item_name").text(data.checkData[i].item_name);
					// 	mb.find("._check_date").text(data.checkData[i].check_date);
					//
					// 	$("#checkData").append(mb.html());
					// }
				}
			}
		});
	}

	var checkDatas = [];
	function pin(cd){
		if (cd) {
			checkDatas = cd;
			$("#checkData").html("");
		}

		var yjz =  $("#checkData ._food_name").length;

		$("#checkData .weui-loadmore").remove();

		for (var i=0; (i+yjz)<checkDatas.length && i<10; i++) {
			var mb;
			if ("合格" == checkDatas[i+yjz].conclusion) {
				mb = $("#mb1").clone();
			} else if ("不合格" == checkDatas[i+yjz].conclusion) {
				mb = $("#mb2").clone();
			}
			mb.find("._food_name").text(checkDatas[i+yjz].food_name);
			mb.find("._item_name").text(checkDatas[i+yjz].item_name);
			mb.find("._check_date").text(checkDatas[i+yjz].check_date);
			if (checkDatas[i+yjz].reg_user_name) {
                mb.find("._reg_user_name").text(checkDatas[i+yjz].reg_user_name);
            } else {
                mb.find("._reg_user_name").parent().remove();
            }

			$("#checkData").append(mb.html());
		}

		if ((10+yjz)<checkDatas.length) {
			$("#checkData").append($("#mb3").clone().html());
		}
	}
</script>
</html>
