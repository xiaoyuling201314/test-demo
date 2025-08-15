<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt"%>
<% 
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path;
String resourcesUrl = basePath + "/resources";
%>
<c:set var="webRoot" value="<%=basePath%>" />
<c:set var="resourcesUrl" value="<%=resourcesUrl%>" />
<meta charset="UTF-8">
<!-- css -->
<link rel="stylesheet" href="${webRoot}/css/iconfont/iconfont.css">
<link rel="stylesheet" href="${webRoot}/css/app/bootstrap.css">
<link rel="stylesheet" href="${webRoot}/css/weixin/css/mui.min.css" />
<link rel="stylesheet" href="${webRoot}/css/app/home.css">
<link rel="stylesheet" href="${webRoot}/css/app/index.css">
<link rel="stylesheet" href="${webRoot}/app/css/bootstrap.css">
<link rel="stylesheet" href="${webRoot}/app/css/index.css">
<link rel="stylesheet" href="${webRoot}/css/weixin/css/self.css"  />
<!-- 端州 -->
<link rel="stylesheet" href="${webRoot}/css/app/app-blue.css">

<!-- js -->
<script type="text/javascript" src="${webRoot}/js/jquery-1.11.3.min.js"></script>
<script type="text/javascript" src="${webRoot}/js/dateUtil.js"></script>