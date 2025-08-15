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
<meta charset="UTF-8" name="renderer" content="webkit">

<link rel="stylesheet" type="text/css" href="${webRoot}/plug-in/bootstrap/css/bootstrap.css">
<link rel="stylesheet" type="text/css" href="${webRoot}/css/iconfont/iconfont.css">
<link rel="stylesheet" type="text/css" href="${webRoot}/css/pretreatment/misson.css" />


<script type="text/javascript" src="${webRoot}/js/jquery-1.11.3.min.js"></script>
<script type="text/javascript" src="${webRoot}/plug-in/bootstrap/bootstrap.js"></script>
<script type="text/javascript" src="${webRoot}/js/dateUtil.js"></script>
<script type="text/javascript" src="${webRoot}/plug-in/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="${webRoot}/plug-in/My97DatePicker/lang/zh-cn.js"></script>
<!-- 
<script type="text/javascript" src="${webRoot}/js/vbar.js"></script>
<script type="text/javascript">
    $(function(){
        openwebsocket();
    });
</script>
 -->