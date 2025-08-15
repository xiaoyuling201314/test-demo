<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/WEB-INF/view/common/resource.jsp" %>

<!DOCTYPE html>
<head>
    <title>快检服务云平台</title>
  <style type="text/css">
    .Validform_checktip {
        display: none;
    }
    </style>
</head>

<body>
<div class="cs-maintab">
    <div class="cs-col-lg clearfix">
        <!-- 面包屑导航栏  开始-->
        <ol class="cs-breadcrumb">
            <li class="cs-fl">
                <img src="${webRoot}/img/set.png" alt=""/>
                <a href="javascript:">系统管理</a></li>
            <li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
            <li class="cs-b-active cs-fl">新增系统参数配置
            </li>
        </ol>
        <!-- 面包屑导航栏  结束-->
        <div class="cs-search-box cs-fr">
<!--             <button class="cs-menu-btn" onclick="parent.closeMbIframe(1);"><i class="icon iconfont icon-fanhui"></i>返回</button> -->
        </div>
    </div>
    <form id="saveForm" action="${webRoot}/system/save.do" method="post" autocomplete="off">
        		<input name="id" id="id" type="hidden" value="${bean.id}"/>
                <input type="hidden" name="configCode" value="${bean.configCode}"/>
                <div width="100%" class="cs-add-new">
                    <ul class="cs-ul-form clearfix">
                        <li class="cs-name col-xs-2 col-md-2">配置类型：</li>
                        <li class="cs-in-style  col-xs-3 col-md-3">
                            <select name="configTypeId" <c:if test="${bean!=null}">disabled="disabled"</c:if>>
                                <c:forEach items="${list}" var="rtype">
                                    <option value="${rtype.id}" <c:if test="${bean.configTypeId== rtype.id}">selected="selected"</c:if>>${rtype.configTypeName}</option>
                                </c:forEach>
                            </select>
                        </li>
                     </ul>
                     <ul class="cs-ul-form clearfix" id="introduceText">
                        <li class="cs-name col-md-2 col-xs-2" style="height:60px;">参数配置：
                        <br/><span title='{"id":"11111","content":"示例"}'>JSON格式&nbsp;&nbsp;</span>
                        
                        </li>
                        <li class="cs-in-style col-md-10 col-xs-10" style="height: auto;">
                            <textarea id="configParam" name="configParam" cols="30" rows="10" datatype="*" nullmsg="请输入JSON格式参数" 
                                      style="height:350px; width:90%;line-height: 25px;"></textarea>
                        </li>
                    </ul>
                    <ul class="cs-ul-form clearfix" id="introduceText">
                        <li class="cs-name col-md-2 col-xs-2">参数说明：</li>
                        <li class="cs-in-style col-md-10 col-xs-10" style="height: auto;">
                            <textarea id="description" name="description" cols="30" rows="10" datatype="*" nullmsg="请输入JSON参数说明" 
                                      style="height:100px; width:90%;line-height: 25px;">${bean.description}</textarea>
                        </li>
                    </ul>
                </div>
    </form>
    <!-- 底部导航 结束 -->
    <div class="cs-hd"></div>
    <div class="cs-alert-form-btn">
         <button type="button" class="cs-menu-btn" id="btnSave"><i class="icon iconfont icon-save"></i>提交</button>
        <button type="button" onclick="parent.closeMbIframe(1);" class="cs-menu-btn cs-fun-btn"><i class="icon iconfont icon-fanhui"></i>返回</button>
    </div>
    <!-- 引用模态框 -->
    <%@include file="/WEB-INF/view/common/confirm.jsp" %>
    
    <!-- Modal 提示窗-确认-->
	<div class="modal fade intro2" id="confirmShowModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog cs-alert-width">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
					<h4 class="modal-title">确认</h4>
				</div>
				<div class="modal-body cs-alert-height cs-dis-tab">
					<div class="cs-text-algin">
					请输入确认码：<input name="confirmCode" style="width: 120px;height: 29px; border-radius: 3px;"/>
						<span onclick="rand(1000,9999)" id="randNumber" style="border: solid 1px #ccc;padding: 5px 10px;letter-spacing:8px;"></span>
						<br/><sapn id="tips" style="color:red;"></sapn>
					</div>
				</div>
				<div class="modal-footer">
					<a class="btn btn-success btn-ok" onclick="confirmCheck()">确认</a>
					<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
				</div>
			</div>
		</div>
	</div>
</body>
<!-- JavaScript -->
<script type="text/javascript">
	var randNumber;
	if($("input[name=id]").val()!=''){
		console.log(${bean.configParam});
	    var jsonData=JSON.stringify(JSON.parse('${bean.configParam}'), null, 4);
	    $("#configParam").html(jsonData);
	}
    $(function () {
    	 <!--失去焦点的时候格式化 JSON 数据  -->
    	$('#configParam').blur(function() {
            var input;
            try {
                if ($('#configParam').val().length == 0) {
                        return;
                }
                input = eval('(' + $('#configParam').val() + ')');
            } catch (error) {
                return alert("Input data is not valid JSON, please check. Error: " + error);
            }
	         $('#configParam').val(JSON.stringify(input, null, 4));
        });
        //表单验证
        $("#saveForm").Validform({
            tiptype: 0,
            beforeSubmit: function () {
            	$("select[name=configTypeId]").removeAttr("disabled");
                var formData = new FormData($('#saveForm')[0]);
                $.ajax({
                    type: "POST",
                    url: "${webRoot}/system/save.do",
                    data: formData,
                    contentType: false, //必须false才会避开jQuery对 formdata 的默认处理 XMLHttpRequest会对 formdata 进行正确的处理
                    processData: false, //必须false才会自动加上正确的Content-Type
                    dataType: "json",
                    success: function (data) {
                        if (data && data.success) {
                            parent.closeMbIframe(1);//返回上一个界面并进行一次界面加载
                        } else {
                            $("#waringMsg>span").html(data.msg);
                            $("#confirm-warnning").modal('toggle');
                        }
                    }
                });
                return false;
            }
        });
        // 新增或修改
        $("#btnSave").on("click", function () {
        	if(${bean!=null}){
        		rand(1000,9999);
            	$("#confirmShowModal").modal('toggle');
        	}else{
        		$("#saveForm").submit();
        	}
            return false;
        });
    });
    function confirmCheck(){
    	var confirmCode=$("input[name=confirmCode]").val();
    	if(confirmCode==''){
    		$("#tips").html("请输入确认码！");
    		$("#tips").removeClass("cs-hide");
    	}else if (confirmCode!=randNumber){
    		$("#tips").html("确认码错误！");
    		$("#tips").removeClass("cs-hide");
    	}else{
    		$("#saveForm").submit();
    	}
    }
	function rand(min,max) {
		randNumber=Math.floor(Math.random()*(max-min))+min;
		$("#randNumber").html(randNumber);
    }
</script>
</html>
