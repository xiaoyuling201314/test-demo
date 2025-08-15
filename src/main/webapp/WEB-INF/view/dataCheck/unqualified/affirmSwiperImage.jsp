<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%--swiper图片轮播插件--%>
<link rel="stylesheet" href="${webRoot}/plug-in/swiper/swiper-bundle.css"/>
<script src='${webRoot}/plug-in/swiper/swiper-bundle.js'></script>
<style>
	html,
	body {
		position: relative;
		height: 100%;
	}

	#seeimg {
		background: rgb(0, 0, 0, 0.6);
	}

	.swiper {
		width: 100%;
		height: 100%;
	}
	.swiper-slide {
		overflow: hidden;
		text-align: center;
		font-size: 18px;
		background: rgb(0, 0, 0, 0.6);
	}

	.swiper-slide img {
		height: 92%;
		max-width: 100%;
		max-height: 100%;
		-ms-transform: translate(-50%, -50%);
		-webkit-transform: translate(-50%, -50%);
		-moz-transform: translate(-50%, -50%);
		transform: translate(-50%, -50%);
		position: absolute;
		left: 50%;
		top: 50%;
	}
	.swiper-slide video {
		height: 300px;
		max-width: 100%;
		max-height: 100%;
		-ms-transform: translate(-50%, -50%);
		-webkit-transform: translate(-50%, -50%);
		-moz-transform: translate(-50%, -50%);
		transform: translate(-50%, -50%);
		position: absolute;
		left: 50%;
		top: 50%;
	}
</style>
<%--轮播图查看取证材料_start--%>
<div id="seeimg" class="hide show-media">
	<div style="--swiper-navigation-color: #fff; --swiper-pagination-color: #fff" class="swiper mySwiper">
		<div class="swiper-wrapper">

		</div>
		<div class="swiper-button-next"></div>
		<div class="swiper-button-prev"></div>
		<div class="swiper-pagination"></div>
	</div>
	<%--关闭按钮--%>
	<span style="position: absolute;right: 40px;top: 20px; color:#fff;z-index: 1" onclick="closeSwiper()"><i class="iconfont icon-guanbi" style="cursor: pointer;font-size: 30px;"></i></span>
</div>
<%--轮播图查看取证材料_end--%>
<!-- JavaScript -->
<script type="text/javascript">
	var mySwiper;//Swiper对象
	//swiper初始化
	function initSwiper(){
		mySwiper=new Swiper(".mySwiper", {
			zoom: false,//设置为true会开启焦距功能：双击slide会放大
			lazy: true,
			pagination: {
				el: ".swiper-pagination",
				clickable: true,
			},
			navigation: {
				nextEl: ".swiper-button-next",
				prevEl: ".swiper-button-prev",
			},
			on: {
				slideChangeTransitionStart: function () {//左右切换事件
					let activeMode = $(".swiper-wrapper").find(".swiper-slide").eq(this.activeIndex);
					//获取当前播放的上一个对象
					let myVideoPrev = document.getElementsByName("video")[this.activeIndex - 1];
					//获取当前播放的下一个对象
					let myVideoNext = document.getElementsByName("video")[this.activeIndex + 1]
					if ($(activeMode).find(".swiper-image").length!=0) {//切换查看图片，暂停视频播放
						if (myVideoPrev!=undefined) myVideoPrev.pause();
						if (myVideoNext!=undefined) myVideoNext.pause();
					} else if ($(activeMode).find(".video").length!=0) {//切换查看视频，自动播放视频
						if (myVideoPrev!=undefined) myVideoPrev.pause();
						if (myVideoNext!=undefined) myVideoNext.pause();
						$(".swiper-wrapper").find(".swiper-slide-active .video")[0].play();
					}
				}
			},
		});
	}
	/**
	 *点击图片或者视频查看方法
	 * filesStr: 当前对象所有的文件字符串
	 * url：当前点击的url，打开模态框后自动显示对应的文件
	 */
	function openFile2(filesStr, url) {
		//重新初始化swiper轮播控件
		initSwiper();
		$(".swiper-wrapper").empty("");
		let childHtml = "";
		let activeIndex = 0;
		var files = filesStr.split(",");//拿到该文件对象集合
		for (var i = 0; i < files.length; i++) {
			childHtml = "";
			//表示是图片，拼接图片
			if (isAssetTypeAnImage(files[i])) {
				childHtml = '<div class="swiper-slide">' +
						// '            <div class="swiper-zoom-container">' +
						'            <img class="swiper-lazy" height="92%" data-src="${webRoot}/resources/' + files[i] + '" onerror="this.src=\'${webRoot}/img/load_faild.png\'" />' +
						'               <div class="swiper-lazy-preloader swiper-lazy-preloader-white"></div> '+
						'               <span class="swiper-lazy-context">加载中...</span>'+
						// '            </div>' +
						'        </div>';
				$(".swiper-wrapper").append(childHtml);
			} else {
				childHtml = '<div class="swiper-slide">' +
						// '            <div class="swiper-zoom-container">' +
						'            <video class=\'video swiper-lazy\' name=\'video\' controls muted autoplay height="300;">' +
						'                <source src="${webRoot}/resources/' + files[i] + '" type="video/mp4">' +
						'            </video>' +
						// '            </div>' +
						'        </div>';
				$(".swiper-wrapper").append(childHtml);
			}
			if (i != 0 && files[i] == url) {
				activeIndex = i;
			}

			$("#seeimg").removeClass("hide");
		}
		//切换到点击的图片或视频
		if (activeIndex > 0) {
			mySwiper.slideTo(activeIndex, 1000, false);//切换到第一个slide，速度为1秒
		}
	}

	//关闭swiper
	function closeSwiper() {
		$("#seeimg").addClass("hide");
		$(".swiper-wrapper").empty("");
		mySwiper.destroy(true,true);
	}
	/**
	 *根据文件名称校验是否为图片对象
	 * filePath: 要校验的文件名称
	 * add by xiaoyl 2022-03-15
	 */
	function isAssetTypeAnImage(filePath) {
		let ext = filePath.substr(filePath.lastIndexOf(".") + 1)
		return ['png', 'jpg', 'jpeg'].indexOf(ext.toLowerCase()) !== -1;
	}
</script>