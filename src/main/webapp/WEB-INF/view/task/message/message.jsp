<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/common/resource.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="${webRoot}/css/fileinput.css" />
<link rel="stylesheet" type="text/css" href="${webRoot}/css/theme.css" />
</head>
<!-- 上传 -->
<script src="${webRoot}/js/sortable.js" type="text/javascript"></script>
<script src="${webRoot}/js/fileinput.js" type="text/javascript"></script>
<script src="${webRoot}/js/zh.js" type="text/javascript"></script>
<script src="${webRoot}/js/theme.js" type="text/javascript"></script>
<body>
<div>
<form id="sendmessage" enctype="multipart/form-data">
收件人id:<input type="text" name="groupID"/><br/>
<%--标题:<input type="text" name="title"/><br/>--%>

内容:<textarea rows="3" cols="30" name="content"></textarea><br/>

添加附件:
<div>
    <input type="file" name="file">
</div>
收件人类型:<input type="text" name="toUserType"/><br/>
</form>
<input class="cs-menu-btn cs-send-btn" id="btnSave" type="submit"/>保存
</div>
 <%@include file="/WEB-INF/view/common/confirm.jsp"%>
 <script src="${webRoot}/js/jquery.form.js"></script>
    <script src="${webRoot}/js/select/tabcomplete.min.js"></script>
    <script src="${webRoot}/js/select/livefilter.min.js"></script>
    <script src="${webRoot}/js/select/bootstrap-select.js"></script>
   <script src="${webRoot}/js/datagridUtil.js"></script>
<script type="text/javascript">

	$("#btnSave").on("click", function() {
		/* $("#sendmessage").submit();
		return false; */
		var formData = new FormData($('#sendmessage')[0]);
		$.ajax({
	        type: "POST",
	        url: '${webRoot}'+"/message/sendMessageOne.do",
	        data: formData,
	        contentType: false, //必须false才会避开jQuery对 formdata 的默认处理 XMLHttpRequest会对 formdata 进行正确的处理 
	        processData: false, //必须false才会自动加上正确的Content-Type
	        dataType: "json",
	        success: function(data){
	        	alert("123");
			},
			error: function(data){
				alert(data);
				window.location.href = '${webRoot}/message/messagefrom';
			}
	    });
		
	});
	
</script>
</body>
</html>