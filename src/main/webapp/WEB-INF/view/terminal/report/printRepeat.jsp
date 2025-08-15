<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/terminal/resource.jsp"%>
<!doctype html>
<html lang="en" class="no-js">
<head>
<meta charset="utf-8" />
<title>自助终端</title>
<meta name="description" content="">
<meta name="keywords" content="">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">

</head>

<body>
	 <div class="zz-content">
    	<div class="zz-title2">
			<img class="pull-left" src="${webRoot}/img/terminal/title2.png" alt=""><span >订单打印</span>
    	</div>
		<div class="zz-cont-box">
			<div class=""></div>
			<div class="zz-base-info col-md-12 col-sm-12">
			<table class="zz-choose">
				<tr>
					<td class="zz-name">
						检测单号：
					</td>
					<td class="zz-input">
						${bean.samplingNo }
					</td>
					
					<td class="zz-name">
						委托单位：
					</td>
					<td class="zz-input">
						${bean.regName }
					</td>
				
					
					<td class="zz-name">
						联系电话：
					</td>
					<td class="zz-input">
						${bean.regLinkPhone }
					</td>
				</tr>
			</table>
			</div>
			
			<div class="zz-table col-md-12 col-sm-12">
				<div class="zz-tb-bg zz-tb-bg2">
					<table>
						<tr class="zz-tb-title">
							<th style="width: 100px">序号</th>
							<th>检测样品</th>
							<th>检测项目</th>
							<th>检测结果</th>
							<c:if test="${printType==1}">
								<th>费用</th>
								<th style="width: 150px">
								<ul>
								<li>
									<input tabindex="1" type="checkbox" id="input-1" >
								</li>
								</ul>
								</th>
							</c:if>
						</tr>
						<c:forEach items="${list}" var="samplingDetail" varStatus="index" >
							<tr>
								<td>${index.index+1}</td>
								<td>${samplingDetail.foodName }</td>
								<td>${samplingDetail.itemName }</td>
								<td>${samplingDetail.conclusion }</td>
								<c:if test="${printType==1}">
								<td>¥1</td>
								<td class="demo-list">
									<ul>
										<li>
										<input tabindex="${samplingDetail.id}" type="checkbox" id="input-${samplingDetail.id}" >
										</li>
	              					</ul>
	          					</td>
								</c:if>
							</tr>
						</c:forEach>
					</table>
						<div class="zz-stats zz-stats2">
						<p>共：</p><i class="text-success">1份报告</i>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i class="text-success"> 合计：1元</i>
						</div>	

				</div>
			</div>
			
			<div class="zz-tb-btns col-md-12 col-sm-12">
				<a href="${webRoot}/terminal/goHome.do" class="btn btn-danger">取消</a>
				<a href="pay2.html" class="btn btn-primary">结算</a>
			</div>
		</div>
		

		<div class="zz-left"><img src="${webRoot}/img/terminal/left.png" alt=""></div>
		<div class="zz-right"><img src="${webRoot}/img/terminal/right.png" alt=""></div>
		
    </div>

</body>
<script>
	$(function(){
		
		function bgH(zz){
			var conH=$('.zz-cont-box').height();
			var selectH=$('.zz-select').height();
			var btnsH=$('.zz-tb-btns').height();
			var codeH=$('.zz-code').height()
			// var priceH=$('.zz-price-all').height()
			$('.zz-tb-bg').height(conH-selectH-btnsH-codeH-225);
		}

		$(window).resize(function(){
			bgH();
		})
		bgH();
		
		$('.zz-rebtn').click(function(){
			$('.zz-pay-fa').hide()
		})
		$('.zz-fa-btn').click(function(){
			$('.zz-pay-fa').show()
		})
		
		/* center modal */
		function centerModals() {
		    $('.intro2').each(function (i) {
		        var $clone = $(this).clone().css('display', 'block').appendTo('body');
		        var top = Math.round(($clone.height() - $clone.find('.modal-content').height()) / 2.4);
		        top = top > 0 ? top : 0;
		        $clone.remove();
		        $(this).find('.modal-content').css("margin-top", top);
		    });
		}
		$('.intro2').on('show.bs.modal', centerModals);
		$(window).on('resize', centerModals);

		$('.change-btn div').click(function(){

			var eq = $(this).index();

			$('.zz-price-all').eq(eq).show().siblings('.zz-price-all').hide();
				bgH();
				if(eq!=0){
					bgH(110);
				}else{
					bgH(0);
				}
				if(eq==2){
					$('.zz-tb-btns a').hide()
					$('.zz-btn-sh').css('display','inline-block')
				}else{
					$('.zz-btn-sh').hide()
					$('.zz-tb-btns a').show()
					$('.zz-btn-sh').css('display','none')
				}
		})

		

		$('.prints-choose span').click(function(){
			var indexs = $(this).index();
			$(this).addClass('zz-current').siblings('span').removeClass('zz-current');
			$('.zz-table .zz-tb-bg').eq(indexs).show().siblings('.zz-tb-bg').hide();
			setTimeout(function(){
				alignmentFns.initialize()
			},500)
		})
	})


</script>
<script>

		// 自定义类型：参数为数组，可多条数据
		alignmentFns.createType([{"test": {"step" : 10, "min" : 10, "max" : 999, "digit" : 0}}]);
		
		// 初始化
		alignmentFns.initialize();
		
		// 销毁
		alignmentFns.destroy();
		
		// js动态改变数据
		$("#4").attr("data-max", "12")
		// 初始化
		alignmentFns.initialize();
		
	</script>

	<script>
          $(document).ready(function(){
            var callbacks_list = $('.demo-callbacks ul');
            $('.demo-list input').on('ifCreated ifClicked ifChanged ifChecked ifUnchecked ifDisabled ifEnabled ifDestroyed', function(event){
              callbacks_list.prepend('<li><span>#' + this.id + '</span> is ' + event.type.replace('if', '').toLowerCase() + '</li>');
            }).iCheck({
              checkboxClass: 'icheckbox_square-blue',
              radioClass: 'iradio_square-blue',
              increaseArea: '20%'
            });
          });
          </script>
</html>


