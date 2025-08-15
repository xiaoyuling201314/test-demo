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

<link rel="stylesheet" href="${webRoot}/plug-in/bootstrap/css/bootstrap.css">
<link rel="stylesheet" href="${webRoot}/css/iconfont/iconfont.css">
<link rel="stylesheet" href="${webRoot}/plug-in/iCheck/css/custom.css?v=1.0.2">
<link rel="stylesheet" href="${webRoot}/plug-in/iCheck/skins/all.css?v=1.0.2">
<link rel="stylesheet" href="${webRoot}/plug-in/select2/css/select2.css">
<link rel="stylesheet" href="${webRoot}/plug-in/jQueryKeyboard/css/softkeys-0.0.1.css">
<link rel="stylesheet" href="${webRoot}/css/terminal/style.css" />


<script type="text/javascript" src="${webRoot}/js/jquery-1.11.3.min.js"></script>
<script type="text/javascript" src="${webRoot}/plug-in/bootstrap/bootstrap.js"></script>
<script type="text/javascript" src="${webRoot}/plug-in/iCheck/icheck.js?v=1.0.2"></script>
<script type="text/javascript" src="${webRoot}/plug-in/iCheck/js/custom.min.js?v=1.0.2"></script>
<script type="text/javascript" src="${webRoot}/plug-in/select2/js/PingYin.js"></script>
<script type="text/javascript" src="${webRoot}/plug-in/select2/js/select2.js"></script>
<script type="text/javascript" src="${webRoot}/js/vbar.js"></script>
<script type="text/javascript" src="${webRoot}/js/dateUtil.js"></script>
<input type="hidden" value="未连接" style="font-size:15px;height:30px;"  id="wsocket"/>
<script type="text/javascript">
	var timeoutUrl="${webRoot}/terminal/logout.do";
</script>