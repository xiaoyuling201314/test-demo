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
		.swiper1 {
			width: 100%;
		}

		.swiper1 .selected {
			color: #0098d9;
			border-bottom: 2px solid #0098d9;
			background-color: #fff;
		}

		.swiper1 .swiper-slide {
			text-align: center;
			font-size: 14px;
			height: 42px;
			line-height: 42px;
		}
	</style>
</head>
<body>

<div class="all-content">
	<div class="zz-tp">
		<div class="img-box2">
			<c:choose>
				<c:when test="${!empty regPhoto}">
					<img src="${resourcesUrl}${regPhoto}" alt="">
				</c:when>
				<c:otherwise>
					<img src="${webRoot}/img/app/market.png" alt="">
				</c:otherwise>
			</c:choose>
		</div>
		<div class="company-all">
			<div class="company-name2">
				<b>${regName}</b>
			</div>
			<div class="address">
				<i class="icon iconfont icon-dingwei"></i><span>${regAddress}</span>
			</div>
		</div>
	</div>
	<div class="swiper-container swiper1">
		<div class="swiper-wrapper swiper-tab" style="justify-content: center;text-align: center;">
			<div class="swiper-slide selected">检测汇总</div>
			<div class="swiper-slide">检测数据</div>
		</div>
	</div>

	<div class="swiper-container swiper2">
		<div class="swiper-wrapper">
			<div class="swiper-slide swiper-no-swiping">
				<iframe src="${webRoot}/iRegulatory/regObjectApp2Statistic?id=${regId}" style="height: 600px"></iframe>
			</div>
			<div class="swiper-slide swiper-no-swiping">
				<iframe src="${webRoot}/iRegulatory/regObjectApp2CheckData?id=${regId}" style="height: 600px"></iframe>
			</div>
		</div>
	</div>

</body>

<script type="text/javascript" src="${webRoot}/plug-in/echarts/echarts.min.js"></script>
<script type="text/javascript" src="${webRoot}/plug-in/echarts/shine.js"></script>
<script type="text/javascript" src="${webRoot}/plug-in/swiperTab/js/swiper-3.4.0.jquery.min.js"></script>

<script type="text/javascript">
	$(function() {
		function setCurrentSlide(ele, index) {
			$(".swiper1 .swiper-slide").removeClass("selected");
			ele.addClass("selected");
			//swiper1.initialSlide=index;
		}

		var swiper1 = new Swiper('.swiper1', {
			//					设置slider容器能够同时显示的slides数量(carousel模式)。
			//					可以设置为number或者 'auto'则自动根据slides的宽度来设定数量。
			//					loop模式下如果设置为'auto'还需要设置另外一个参数loopedSlides。
			slidesPerView: 3.8,
			paginationClickable: true, //此参数设置为true时，点击分页器的指示点分页器会控制Swiper切换。
			spaceBetween: 5, //slide之间的距离（单位px）。
			freeMode: true, //默认为false，普通模式：slide滑动时只滑动一格，并自动贴合wrapper，设置为true则变为free模式，slide会根据惯性滑动且不会贴合。
			loop: false, //是否可循环
			onTab: function(swiper) {
				var n = swiper1.clickedIndex;
			}
		});
		swiper1.slides.each(function(index, val) {
			var ele = $(this);
			ele.on("click", function() {
				setCurrentSlide(ele, index);
				swiper2.slideTo(index, 500, false);
				//mySwiper.initialSlide=index;
			});
		});

		var swiper2 = new Swiper('.swiper2', {
			//freeModeSticky  设置为true 滑动会自动贴合
			direction: 'horizontal', //Slides的滑动方向，可设置水平(horizontal)或垂直(vertical)。
			loop: false,
			//					effect : 'fade',//淡入
			//effect : 'cube',//方块
			//effect : 'coverflow',//3D流
			//					effect : 'flip',//3D翻转
			autoHeight: true, //自动高度。设置为true时，wrapper和container会随着当前slide的高度而发生变化。
			onSlideChangeEnd: function(swiper) { //回调函数，swiper从一个slide过渡到另一个slide结束时执行。
				var n = swiper.activeIndex;
				setCurrentSlide($(".swiper1 .swiper-slide").eq(n), n);
				swiper1.slideTo(n, 500, false);
			}
		});
	});
</script>
</html>
