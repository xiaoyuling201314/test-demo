<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/common/resource.jsp"%>
<html>
<head>
<title>快检服务云平台</title>
<link rel="stylesheet" type="text/css" href="${webRoot}/css/fileinput.css" />
<link rel="stylesheet" type="text/css" href="${webRoot}/css/theme.css" />
</head>
<!-- 上传 -->
<script src="${webRoot}/js/sortable.js" type="text/javascript"></script>
<script src="${webRoot}/js/fileinput.js" type="text/javascript"></script>
<script src="${webRoot}/js/zh.js" type="text/javascript"></script>
<script src="${webRoot}/js/theme.js" type="text/javascript"></script>
<body>
	<div class="cs-col-lg clearfix">
          <!-- 面包屑导航栏  开始-->
            <ol class="cs-breadcrumb cs-fl">
              <li class="cs-fl">
              <img src="${webRoot}/img/set.png" alt="" />
              <li class="cs-fl">已发送
              </li>
              <li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
              <li class="cs-b-active cs-fl">消息详情
              </li>
            </ol>
            <div class="cs-search-box cs-fr">
              
               <div class="clearfix cs-fr" id="showBtn">
              <a href="${webRoot}/message/messagefrom" class="cs-menu-btn"><i class="icon iconfont icon-fanhui"></i>返回</a></div>
             
              
            </div>
          <!-- 面包屑导航栏  结束-->
            
          </div>
      <div class="cs-tb-box">

      
      <div class="cs-content2 clearfix cs-main-content">
          <table class="cs-mail-content">
            <tr>
              <td class="cs-mail-title cs-al" style="width:100%;" colspan="4">
              <h5><span class="cs-mail-info">${tbTaskMessgae.title}</span></h5>
              </td>
              
            </tr>
            <tr>
              <td class=" cs-al" style="width:80px;">
              <span class="cs-mail-info">收件人：
                  <i class="green">
                      ${tbTaskMessgae.departName}
                  </i>
                  <noreply@kycloud.me>
              </span><br>
              <span class="cs-mail-info">时间:${time}</span>
             </td>
            </tr>
            <tr>
              <td class="cs-mail-info cs-al" colspan="4"><span class="cs-mail-info">附件： <a class="blue" onclick="deail()">${tbTaskMessgae.filename}</a></span></td>
              
            </tr>
          </table>
          <div>
            </div>
      </div>
      <div style="padding:10px ;">
        ${tbTaskMessgae.content}
      </div>


      </div>
      
      
 


 
	<!--  <div class="cs-bottom-tools">
        <div class=" cs-fl cs-ac ">
            <a href="rev-detail.html" class="cs-menu-btn"><i class="icon iconfont icon-shanchu"></i>回复</a>
            <a href="javascript:;" class="cs-menu-btn"><i class="icon iconfont icon-shanchu"></i>转发</a>
            <a href="javascript:;" class="cs-menu-btn"><i class="icon iconfont icon-shanchu"></i>删除</a>
        </div>
     </div>-->
      <%@include file="/WEB-INF/view/common/confirm.jsp"%>
      <script src="${webRoot}/js/datagridUtil.js"></script>
	  <script type="text/javascript">
	  
	  	function deail() {
	  		self.location = '${webRoot}/message/download.do?id='+${tbTaskMessgae.id};
		}
	  </script>
</body>
</html>