<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/common/resource.jsp"%>
<html>
  <head>
    <title>快检服务云平台</title>
  </head>
  <body>
 
		<div class="cs-col-lg clearfix">
          <!-- 面包屑导航栏  开始-->
            <ol class="cs-breadcrumb">
              <li class="cs-fl">
              <img src="${webRoot}/img/set.png" alt="" />
              <a href="javascript:">数据统计</a></li>
              <li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
              <li class="cs-b-active cs-fl">APP下载
              </li>
            </ol>
		</div>

      <div class="app_download">
        <h4>客户端APP下载二维码</h4>
        <br/>
        <img src="${webRoot}/img/appQrcode.png" style="width:100%;" alt="" />
      </div>
  </body>
</html>
