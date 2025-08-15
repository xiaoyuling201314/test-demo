<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/common/resource.jsp"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="description" content="">
    <meta name="author" content="食安科技">
    <meta http-equiv="X-UA-Compatible" content="IE=Edge">
    <title>快检服务云平台</title>
    <link rel="stylesheet" href="${webRoot}/plug-in/pictureView/preview.css" type="text/css">
    <style type="text/css">
	    #content{ width:500px; height:170px; margin:100px auto;}
	/*	#imgbox-loading {position: absolute;top: 0;left: 0; cursor: pointer;display: none;z-index: 90;}
		#imgbox-loading div {background: #FFF;width: 100%;height:100%;}
		#imgbox-overlay {position: absolute;top: 0; left: 0;width: 100%;height: 100%;background: #000;display: none;z-index: 80;}
		.imgbox-wrap {position: absolute;top: 0;left: 0;display: none; z-index: 90;}
		.imgbox-img {padding: 0;margin: 0;border: none;width: 100%; height: 100%;vertical-align: top; border:10px solid #fff;}
		.imgbox-title { padding-top: 10px;font-size: 11px;text-align: center;font-family: Arial;color: #333;display: none;}
		.imgbox-bg-wrap {position: absolute;padding: 0;margin: 0;display: none;}
		.imgbox-bg {position: absolute;width: 20px; height: 20px;}*/
        .cs-add-pad input[type=text], .android-search-input input[type=text] {
            max-width: 35px;
        }
        .close_bgmask{
            display: none;
        }
        #picture1 img,#picture2 img{
            vertical-align: top;cursor: pointer;
        }
        .cs-add-pad input[type=text], .android-search-input input[type=text] {
            max-width: 35px;
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
              <li class="cs-fl"><a href="javascript:" class="returnBtn">抽样单</a></li>
              <li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
              <li class="cs-b-active cs-fl">抽样单详情
              </li>
            </ol>
          <!-- 面包屑导航栏  结束-->
          <div class="cs-search-box cs-fr">
            <a href="javascript:" onclick="parent.closeMbIframe();" class="cs-menu-btn"><i class="icon iconfont icon-fanhui"></i>返回</a>
          </div>
  	  	</c:otherwise>
  	</c:choose>
  	
          </div>
          <div class="cs-tb-box">
             <div class="cs-base-detail">
      
    <div class="cs-content2 clearfix">
    <form class="registerform" action="">
      <div class="cs-input-bg">
            <h3>抽样单信息</h3>
      <table class="cs-form-table cs-form-table-he" >
        <tbody>
          <tr>
            <td class="cs-name" style="width:160px;">抽样单号：</td>
            <td class="cs-in-style" style="width:34%; padding-left:10px;">
                <c:if test="${!empty sampling}">${sampling.samplingNo}</c:if>
                <c:choose>
                    <c:when test="${sampling.orderPlatform==1}">
                        <i class="icon iconfont icon-weixin1" title="微信"></i>
                    </c:when>
                    <c:when test="${sampling.orderPlatform==0}">
                        <i class="icon iconfont icon-shouji" title="APP"></i>
                    </c:when>
                </c:choose>
                <!-- <a class="cs-icon-span" href="javascript:;"><i class="icon iconfont icon-local"></i></a> -->
            </td>
            <td class="cs-name" style="width:160px;">抽样时间：</td>
            <td class="cs-in-style" style=" padding-left:10px;">
                <c:if test="${!empty sampling && !empty sampling.samplingDate}">
                	<fmt:formatDate type="both" value="${sampling.samplingDate}" /></p>
                </c:if>
            </td>
            <td rowspan="3" style="text-align:center;width:110px;">
              <img src="${webRoot}/resources/qrcode/${sampling.qrcode}" alt="" style="height:100px;" style="display:inline-block;" />
            </td>
          </tr>
          <tr>
            <td class="cs-name" style="width:160px;">抽样人：</td>
              <td class="cs-in-style" style=" padding-left:10px;" <c:if test="${showSampleCost ne 1}">colspan="3"</c:if>>
                <c:if test="${!empty sampling}">${sampling.samplingUsername}</c:if>
            </td>
            <c:if test="${showSampleCost eq 1}">
                <td class="cs-name" style="width:160px;">抽样费用：</td>
                <td class="cs-in-style" style=" padding-left:10px;">
                    <c:if test="${!empty sampling && !empty sampling.param1}">￥${sampling.param1}</c:if>
                </td>
            </c:if>
          </tr>
          <tr style="height:px;">
            <td class="cs-name" style="width:140px;">进货凭证：</td>
            <td class="cs-in-style cs-td-img" colspan="3" >
                <div id="picture1">
            	<c:if test="${!empty files}">

            		<c:forEach items="${files}" var="file">
		             		<img src="${resourcesUrl}${file.filePath}">
            		</c:forEach>
                    </div>
            	</c:if>
            </td>
          </tr>
        </tbody>
      </table>
      <h3>被检单位信息</h3>
      <table class="cs-form-table cs-form-table-he" >
         <tbody>
            <tr>
	            <td class="cs-name" style="width:160px;">被检单位：</td>
	            <td class="cs-in-style" style="width:34%; padding-left:10px;">
					<c:if test="${!empty regObject}">${regObject.regName}</c:if>
	            </td>
	            <td class="cs-name" style="width:160px;">地址：</td>
	            <td class="cs-in-style" style=" padding-left:10px;">
					<c:if test="${!empty regObject}">${regObject.regAddress}</c:if>
	            </td>
          </tr>
          <tr>
          	<td class="cs-name" style="width:160px;">联系人：</td>
            <td class="cs-in-style" style=" padding-left:10px;">
				<c:if test="${!empty regObject}">${regObject.linkUser}</c:if>
            </td>
          	<td class="cs-name" style="width:160px;">联系人电话：</td>
	            <td class="cs-in-style" style=" padding-left:10px;">
				<c:if test="${!empty regObject}">${regObject.linkPhone}</c:if>
            </td>
          </tr>
          <tr>
            <td class="cs-name" style="width:160px;">
                <c:choose>
                    <c:when test="${systemFlag==1}">
                        摊位名称：
                    </c:when>
                    <c:otherwise>
                        经营户：
                    </c:otherwise>
                </c:choose>
            </td>
            <td class="cs-in-style" style=" padding-left:10px;">
                <c:if test="${!empty sampling}">${sampling.opeShopName}</c:if>
            </td>
          	<td class="cs-name" style="width:160px;">
                <c:choose>
                    <c:when test="${systemFlag==1}">
                        摊位编号：
                    </c:when>
                    <c:otherwise>
                        档口编号：
                    </c:otherwise>
                </c:choose>
            </td>
            <td class="cs-in-style" style=" padding-left:10px;">
                <c:if test="${!empty sampling}">${sampling.opeShopCode}</c:if>
            </td>
          </tr>
          <tr>
            <td class="cs-name" style="width:160px;">经营者：</td>
            <td class="cs-in-style" style=" padding-left:10px;">
				<c:if test="${!empty sampling}">${sampling.opeName}</c:if>
            </td>
          	<td class="cs-name" style="width:160px;">经营者电话：</td>
            <td class="cs-in-style" style=" padding-left:10px;">
                <c:if test="${!empty sampling}">${sampling.opePhone}</c:if>
            </td>
          </tr>
          <tr>
            <td class="cs-name" style="width:140px;">经营者签名：</td>
            <td class="cs-in-style cs-td-img" colspan="3">
            	<c:if test="${!empty sampling && !empty sampling.opeSignature}">
                    <div id="picture2">
		        		<img src="${resourcesUrl}opeSignaturePath/${sampling.opeSignature}">
                    </div>
            	</c:if>
            </td>
          </tr>
          </tbody></table>
      
      	<h3>抽样明细</h3>
		<div id="dataList" class="cs-fix-num"></div>
      </div>
  </form>
    </div>
  </div>
</div>
       <!-- 底部导航 结束 -->
</div>

<%@include file="/WEB-INF/view/common/modalBox.jsp"%>
<%@include file="/WEB-INF/view/common/confirm.jsp"%>
</body>
   <!-- JavaScript -->
   <%--<script src="${webRoot}/js/jquery.min.js"></script>
   <script src="${webRoot}/js/jquery.imgbox.pack.js"></script>--%>
   <script src="${webRoot}/plug-in/pictureView/preview.js"></script>
   <script src="${webRoot}/js/datagridUtil.js"></script>
   <script type="text/javascript">
$(function(){
    var pic1= document.getElementById("picture1");
    var pic2= document.getElementById("picture2");
    if(pic1){//进货凭证图片查看
        var preview1 = new Preview({
            imgWrap: 'picture1' // 指定该容器里的图片点击预览
        })
    }
    if(pic2){ //经营者签名图片查看
        var preview2 = new Preview({
            imgWrap: 'picture2' // 指定该容器里的图片点击预览
        })
    }


/*  $(".cs-img-link").imgbox({
    'speedIn'   : 0,
    'speedOut'    : 0,
    'alignment'   : 'center',
    'overlayShow' : true,
    'allowMultiple' : false
  });*/
  
	var op = {
			tableId: "dataList",	//列表ID
			tableAction: "${webRoot}/samplingDetail/datagrid.do?tbSampling.id=${sampling.id}",	//加载数据地址
			parameter: [		//列表拼接参数
				{
					columnCode: "foodName",
					columnName: "样品名称"
					
				},
				{
					columnCode: "itemName",
					columnName: "检测项目"
				},
				/* {
					columnCode: "purchaseDate",
					columnName: "进货日期"
				}, */
				{
					columnCode: "sampleNumber",
					columnName: "抽样数(kg)"
					
				},
				{
					columnCode: "purchaseAmount",
					columnName: "进货数(kg)"
					
				},
				{
					columnCode: "supplier",
					columnName: "供应商"
					
				},
				{
					columnCode: "origin",
					columnName: "产地"
					
				},
				{
					columnCode: "batchNumber",
					columnName: "批号"
				},
				{
					columnCode: "conclusion",
					columnName: "检测结果"
					
				},
				{
					columnCode: "recevieDevice",
					columnName: "仪器唯一标识"
					
				},
				{
					columnCode: "status",
					columnName: "检测任务",
					customVal: {"0":"未接收","1":"已接受"}
				}
			],
			funBtns: [
				{
					show: Permission.exist("321-12"),
					style: Permission.getPermission("321-12"),
					action: function(id){
						$.ajax({
					        type: "POST",
					        url: "${webRoot}/samplingDetail/checkTraceability.do",
					        data: {"sdId":id},
					        dataType: "json",
					        success: function(data){
					        	if(data && data.success){
									showMbIframe("${webRoot}/samplingDetail/traceability.do?sdId="+id);
					        	}else{
									//无溯源信息
					        		// alert("样品无溯源信息");
                                    $("#waringMsg>span").html("样品无溯源信息！");
                                    $("#confirm-warnning").modal('toggle');
					        	}
							}
					    });
					}
				},
				{
					show: Permission.exist("321-5"),
					style: Permission.getPermission("321-5"),
					action: function(id){
						var data = datagridOption.obj;
				    	for(var i=0;i<data.length;i++){
				    		if(data[i].id == id){
				    			//已检测
				    			if(data[i].conclusion){
				    				// alert("下发失败，样品已检测");
                                    $("#waringMsg>span").html("下发失败，样品已检测！");
                                    $("#confirm-warnning").modal('toggle');
				    			//未检测
				    			}else{
									$.ajax({
								        type: "POST",
								        url: "${webRoot}/samplingDetail/reissueCheckTask.do",
								        data: {"samplingDetailId":id,"serialNumber":data[i].recevieDevice},
								        dataType: "json",
								        success: function(data){
								        	if(data && data.success){
								        		datagridUtil.refresh();
								        	}else{
                                                $("#waringMsg>span").html("下发失败！");
                                                $("#confirm-warnning").modal('toggle');
								        	}
										}
								    });
				    			}
				    		}
				    	}
					}
				}
		    ]
		};
		datagridUtil.initOption(op);
		
	    datagridUtil.query();
	    
		//返回
		$('.returnBtn').click(function(){
			self.location = "${webRoot}/sampling/list.do";
		});
});

</script>
</html>
