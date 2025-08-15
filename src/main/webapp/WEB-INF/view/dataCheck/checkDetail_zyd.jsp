<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/common/resource.jsp"%>
<html>
  <head>
    <title>快检服务云平台</title>
    <style type="text/css">
    #content{ width:500px; height:170px; margin:100px auto;}
	#imgbox-loading {position: absolute;top: 0;left: 0; cursor: pointer;display: none;z-index: 90;}
	#imgbox-loading div {background: #FFF;width: 100%;height : 100%;}
	#imgbox-overlay {position: absolute;top: 0; left: 0;width: 100%;height: 100%;background: #000;display: none;z-index: 80;}
	.imgbox-wrap {position: absolute;top: 0;left: 0;display: none; z-index: 90;}
	.imgbox-img {padding: 0;margin: 0;border: none;width: 100%; height: 100%;vertical-align: top; border:10px solid #fff;}
	.imgbox-title { padding-top: 10px;font-size: 11px;text-align: center;font-family: Arial;color: #333;display: none;}
	.imgbox-bg-wrap {position: absolute;padding: 0;margin: 0;display: none;}
	.imgbox-bg {position: absolute;width: 20px; height: 20px;}
	input[type="file"]{
	  color:#666;

}
   </style>
  </head>

  <body>
  <div class="cs-maintab">
  <div class="cs-col-lg clearfix">
  	<c:choose>
  	  	<c:when test="${source eq 'monitor'}">
  	  		<!-- 面包屑导航栏  开始-->
  	  		<ol class="cs-breadcrumb">
              <li class="cs-fl">
              	<img src="${webRoot}/img/set.png" alt="">
              	检测结果详情
              </li>
            </ol>
  	  	</c:when>
  	  	<c:otherwise>
  	  		<!-- 面包屑导航栏  开始-->
            <ol class="cs-breadcrumb">
              <li class="cs-fl">
              <img src="${webRoot}/img/set.png" alt="">
              <a href="javascript:">快检服务</a></li>
              <li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
              <li class="cs-fl"><a href="javascript:">智云达检测数据</a></li>
              <li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
              <li class="cs-b-active cs-fl">检测结果详情
              </li>
            </ol>
          	<!-- 面包屑导航栏  结束-->
            <div class="cs-search-box cs-fr">
				<div class="cs-fr cs-ac ">
					<a href="javascript:" onclick="parent.closeMbIframe();" class="cs-menu-btn cs-fun-btn"><i class="icon iconfont icon-fanhui" ></i>返回</a>
				</div>
			</div>
  	  	</c:otherwise>
  	</c:choose>
  </div>
  <div class="cs-tb-box">
	 <div class="cs-base-detail">
    <div class="cs-content2 clearfix">
    <form class="registerform" action="">
      <div class="cs-add-new cs-add-pad cs-input-bg">
		      
		      <h3>检测信息</h3>
		      <ul class="cs-ul-style clearfix">
				  <li class="cs-name cs-sm-w">检测编号：</li>
				  <li class="cs-in-style cs-md-w"><input type="text" disabled="disabled" value="" name="id" /></li>

				  <li class="cs-name cs-sm-w">样品编号：</li>
				  <li class="cs-in-style cs-md-w"><input type="text" disabled="disabled" value="" name="sampleNo" /></li>

				  <li class="cs-name cs-sm-w">检测结论：</li>
				  <li class="cs-in-style cs-md-w"><input type="text" disabled="disabled" value="" name="testResult" /></li>

				  <li class="cs-name cs-sm-w">样品类型：</li>
				  <li class="cs-in-style cs-md-w"><input type="text" disabled="disabled" value="" name="itemInfoTypeName" /></li>

				  <li class="cs-name cs-sm-w">样品名称：</li>
				  <li class="cs-in-style cs-md-w"><input type="text" disabled="disabled" value="" name="fname" /></li>

				  <li class="cs-name cs-sm-w">检测项目：</li>
				  <li class="cs-in-style cs-md-w"><input type="text" disabled="disabled" value="" name="testProName" /></li>

				  <li class="cs-name cs-sm-w">区域名称：</li>
				  <li class="cs-in-style cs-md-w"><input type="text" disabled="disabled" value="" name="areaName" /></li>

				  <li class="cs-name cs-sm-w">检测机构：</li>
				  <li class="cs-in-style cs-md-w"><input type="text" disabled="disabled" value="" name="officeName" /></li>

				  <li class="cs-name cs-sm-w">检测点：</li>
				  <li class="cs-in-style cs-md-w"><input type="text" disabled="disabled" value="" name="useUnitName" /></li>

				  <li class="cs-name cs-sm-w">限定值：</li>
				  <li class="cs-in-style cs-md-w"><input type="text" disabled="disabled" value="" name="standardLimit" /></li>

				  <li class="cs-name cs-sm-w">检测值：</li>
				  <li class="cs-in-style cs-md-w"><input type="text" disabled="disabled" value="" name="contents" /></li>

				  <li class="cs-name cs-sm-w">检测人员：</li>
				  <li class="cs-in-style cs-md-w"><input type="text" disabled="disabled" value="" name="testPerson" /></li>
		         
				  <li class="cs-name cs-sm-w">检测时间：</li>
				  <li class="cs-in-style cs-md-w"><input type="text" disabled="disabled" value="" name="testTime" /></li>

				  <li class="cs-name cs-sm-w">抽样时间：</li>
				  <li class="cs-in-style cs-md-w"><input type="text" disabled="disabled" value="" name="sampleTime" /></li>

				  <li class="cs-name cs-sm-w">被检单位：</li>
				  <li class="cs-in-style cs-md-w"><input type="text" disabled="disabled" value="" /></li>

				  <li class="cs-name cs-sm-w">检测地址：</li>
				  <li class="cs-in-style cs-md-w"><input type="text" disabled="disabled" value="" name="reserve1" /></li>

				  <li class="cs-name cs-sm-w">抽样地址：</li>
				  <li class="cs-in-style cs-md-w"><input type="text" disabled="disabled" value="" name="reserve2" /></li>

				  <li class="cs-name cs-sm-w">生产企业：</li>
				  <li class="cs-in-style cs-md-w"><input type="text" disabled="disabled" value="" name="manuUnit" /></li>

				  <li class="cs-name cs-sm-w">预留参数3：</li>
				  <li class="cs-in-style cs-md-w"><input type="text" disabled="disabled" value="" name="reserve3" /></li>

				  <li class="cs-name cs-sm-w">预留参数4：</li>
				  <li class="cs-in-style cs-md-w"><input type="text" disabled="disabled" value="" name="reserve4" /></li>

				  <li class="cs-name cs-sm-w">预留参数5：</li>
				  <li class="cs-in-style cs-md-w"><input type="text" disabled="disabled" value="" name="reserve5" /></li>

			  </ul>
			  <ul class="cs-ul-style clearfix">
				  <li class="cs-name cs-sm-w">备注：</li>
				  <li class="cs-in-style cs-md-w" style="width: 49.1%;height: 80px;">
					  <textarea id="remarks" disabled="disabled" style="width: 100%; height: 80px;background-color: #fafafa;">

					  </textarea>
				  </li>
			  </ul>

		  <h3 class="device_info">检测设备</h3>
		  <ul class="cs-ul-style clearfix device_info">

			  <li class="cs-name cs-sm-w">仪器型号：</li>
			  <li class="cs-in-style cs-md-w"><input type="text" disabled="disabled" value="" name="instrument" /></li>

			  <li class="cs-name cs-sm-w">仪器编号：</li>
			  <li class="cs-in-style cs-md-w"><input type="text" disabled="disabled" value="" name="instrumentNo" /></li>

			  <li class="cs-name cs-sm-w">MAC：</li>
			  <li class="cs-in-style cs-md-w"><input type="text" disabled="disabled" value="" name="mac" /></li>

			  <li class="cs-name cs-sm-w">仪器厂家：</li>
			  <li class="cs-in-style cs-md-w"><input type="text" disabled="disabled" value="智云达" name="" /></li>

		  </ul>

		  <h3>处理数据</h3>
		  <ul class="cs-ul-style clearfix">
			  <li class="cs-name cs-sm-w">下载时间：</li>
			  <li class="cs-in-style cs-md-w"><input type="text" disabled="disabled" value="" name="dyDownloadTime" /></li>

			  <li class="cs-name cs-sm-w">处理时间：</li>
			  <li class="cs-in-style cs-md-w"><input type="text" disabled="disabled" value="" name="dyDealTime" /></li>

			  <li class="cs-name cs-sm-w">处理状态：</li>
			  <li class="cs-in-style cs-md-w"><input type="text" disabled="disabled" value="" name="dyStatus" /></li>

			  <li class="cs-name cs-sm-w cs-hide dyReason">失败原因：</li>
			  <li class="cs-in-style cs-md-w cs-hide dyReason" style="width: 49.1%;height: 80px;">
					  <textarea id="dyReason" disabled="disabled" style="width: 100%; height: 80px;background-color: #fafafa;">

					  </textarea>
			  </li>
		  </ul>
	  </div>

	</form>
    </div>

  </div>
</div>
       <!-- 底部导航 结束 -->
  <div class="cs-hd"></div>
	<c:choose>
		<c:when test="${source ne 'monitor'}">
		  <div class="cs-alert-form-btn">
		  	  <a href="javascript:" onclick="parent.closeMbIframe();" class="cs-menu-btn cs-fun-btn"><i class="icon iconfont icon-fanhui" ></i>返回</a>
		  </div>
  	  	</c:when>
  	</c:choose>

   <script src="${webRoot}/js/jquery.min.js"></script>
   <script src="${webRoot}/js/jquery.imgbox.pack.js"></script>
   <script>
	$(function(){
		$.ajax({
			type: "POST",
			url: syncDataUrl+"/zydCheckData/queryById.do",
			data: {"id":"${id}"},
			dataType: "json",
			success: function (data) {
				if (data && data.success) {
					let bean=data.obj;
					$(".registerform input[name=reserve1]").val(bean.reserve1);
					$(".registerform input[name=reserve2]").val(bean.reserve2);
					$(".registerform input[name=reserve3]").val(bean.reserve3);
					$(".registerform input[name=reserve4]").val(bean.reserve4);
					$(".registerform input[name=reserve5]").val(bean.reserve5);
					$(".registerform input[name=id]").val(bean.id);
					$(".registerform input[name=sampleNo]").val(bean.sampleNo);
					$(".registerform input[name=itemInfoTypeName]").val(bean.itemInfoTypeName);
					$(".registerform input[name=fname]").val(bean.fname);
					$(".registerform input[name=testProName]").val(bean.testProName);
					$(".registerform input[name=contents]").val(bean.contents);
					$(".registerform input[name=standardLimit]").val(bean.standardLimit);

					$(".registerform input[name=testResult]").val(bean.testResult);
					$(".registerform input[name=areaName]").val(bean.areaName);
					$(".registerform input[name=officeName]").val(bean.officeName);
					$(".registerform input[name=useUnitName]").val(bean.useUnitName);
					$(".registerform input[name=testPerson]").val(bean.testPerson);
					$(".registerform input[name=manuUnit]").val(bean.manuUnit);
					$(".registerform input[name=testTime]").val(new Date(bean.testTime).format("yyyy-MM-dd HH:mm:ss"));
					$(".registerform input[name=sampleTime]").val(new Date(bean.sampleTime).format("yyyy-MM-dd HH:mm:ss"));
					$(".registerform input[name=dyDownloadTime]").val(new Date(bean.dyDownloadTime).format("yyyy-MM-dd HH:mm:ss"));
					$(".registerform input[name=dyDealTime]").val(new Date(bean.dyDealTime).format("yyyy-MM-dd HH:mm:ss"));
					let dyStatus="";
					if(bean.dyStatus==2){
						dyStatus="成功";
					}else if(bean.dyStatus==3){
						dyStatus="失败";
						$("#dyReason").text(bean.dyReason);
						$(".dyReason").removeClass("cs-hide");
					}else{
						dyStatus="暂存";
					}
					$(".registerform input[name=dyStatus]").val(dyStatus);
					$(".registerform input[name=instrument]").val(bean.instrument);
					$(".registerform input[name=instrumentNo]").val(bean.instrumentNo);
					$(".registerform input[name=mac]").val(bean.mac);
					$("#remarks").val(bean.remarks);
				} else {

				}
			}
		});
	});
</script>
    </body>
</html>
