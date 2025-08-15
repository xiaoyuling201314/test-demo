<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/common/resource.jsp"%>
<html>
  <head>
    <title>${systemName}</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <style type="text/css">
      html,body{
          background: #f1f1f1;
          height: 100%;
      }
  </style>
  </head>

  <body>
  <!--让浏览器自动填充到这个input-->
  <input type="password" style="display: none;">

  <div class="cs-main">
      <div class="cs-wraper">
          <div class="cs-add-new clearfix" style="width: 555px;margin: 0 auto;margin-top: 50px;border: 1px solid #ddd;padding: 20px 20px;border-radius: 5px;background: #fff;height: auto;">
              <div>
                  <h4 class="text-center" style="font-weight: bold">修改密码</h4>
              </div>
              <form id="userForm" action="${webRoot}/system/user/updatePassword2.do">
                  <div width="100%" class="cs-add-new">
                      <ul class="cs-ul-form clearfix">
                          <li  class="cs-name col-md-3">单位：</li>
                          <li class="cs-in-style col-md-5" width="210px"  style="font-weight:bold;">${departName}</li>
                          <li class="col-md-4 cs-text-nowrap"></li>
                      </ul>
                      <c:if test="${!empty pointName}">
                          <ul class="cs-ul-form clearfix">
                              <li class="cs-name col-md-3">检测室：</li>
                              <li class="cs-in-style col-md-5" width="210px"  style="font-weight:bold;">${pointName}</li>
                              <li class="col-md-4 cs-text-nowrap"></li>
                          </ul>
                      </c:if>
                      <ul class="cs-ul-form clearfix">
                          <input type="hidden" name="id" value="${userId}">
                          <li  class="cs-name col-md-3">账号：</li>
                          <li class="cs-in-style col-md-5" width="210px"  style="font-weight:bold;">${userName}</li>
                          <li class="col-md-4 cs-text-nowrap"></li>
                      </ul>
                      <ul class="cs-ul-form clearfix">
                          <li class="cs-name col-md-3">用户名：</li>
                          <li class="cs-in-style col-md-5" width="210px"  style="font-weight:bold;">${realName}</li>
                          <li class="col-md-4 cs-text-nowrap"></li>
                      </ul>
                      <ul class="cs-ul-form clearfix">
                          <li  class="cs-name col-md-3">新密码：</li>
                          <li  class="cs-in-style col-md-5 ui-pos-re" >
                              <input type="hidden" name="password">
                              <input type="text"  name="mpw1"  class="inputxt password" plugin="passwordStrength"  datatype="pw" sucmsg="" nullmsg="请输入8-16位字符密码" errormsg="请输入8-16位符合规则密码" style="width: 210px" placeholder="请输入新密码" autocomplete="off"/>
                              <span class="iconfont icon-biyan pos-abs show-password" style="right: 10px"></span>
                          </li>
                          <li class="col-md-4 cs-relative">
                              <i class="iconfont icon-jinggao text-primary show-rule"></i>
                              <div class="password-rule cs-hide"><i class="cs-mred">*</i>密码规则：包含字母大写、字母小写、数字、特殊字符的组合，密码长度应不少于8位</div>
                          </li>
                      </ul>
                      <ul class="cs-ul-form clearfix">
                          <li  class="cs-name col-md-3">确认密码：</li>
                          <li  class="cs-in-style col-md-5 ui-pos-re" >
                              <input type="text" name="mpw2" class="inputxt password" recheck="mpw1" datatype="*" sucmsg="" nullmsg="请确认密码" errormsg="两次输入的密码不一致" style="width: 210px" placeholder="请确认密码" autocomplete="off"/>
                              <span class="iconfont icon-biyan pos-abs show-password" style="right: 10px"></span>
                          </li>
                          <li class="col-md-4 cs-text-nowrap"></li>
                      </ul>
                      <div class="action" style="margin-top: 20px;text-align: center">
                          <button type="submit" class="btn btn-success">确认修改</button>
                      </div>
                  </div>
              </form>
          </div>
      </div>
  </div>


  <%-- MD5加密 --%>
  <script type="text/javascript" src="${webRoot}/plug-in/blueimp-md5/md5.min.js"></script>
  <script type="text/javascript">
      $('.show-password').click(function () {
          if($(this).hasClass('icon-yan')){
              $(this).addClass('icon-biyan').removeClass('icon-yan').siblings('.inputxt').addClass('password');
          }else{
              $(this).addClass('icon-yan').removeClass('icon-biyan').siblings('.inputxt').removeClass('password');
          }
      })
      //修改密码-密码规则
      $('.show-rule').hover(function () {
          $('.password-rule').show();
      },function () {
          $('.password-rule').hide();
      });

	var userFormVf = $("#userForm").Validform({
		tiptype:2,
		ajaxPost:true,
		beforeSubmit:function(curform){
		    $("input[name='password']").val(md5($("input[name='mpw1']").val()).toLocaleUpperCase());
		    $("input[name='mpw1']").attr("disabled","disabled");
		    $("input[name='mpw2']").attr("disabled","disabled");
		},
		callback:function(data){
			if(data.success){
				window.location.href = "${webRoot}";
			}else{
                $("input[name='mpw1']").removeAttr("disabled");
                $("input[name='mpw2']").removeAttr("disabled");
				$.Showmsg(data.msg);
			}
		}
	});
    function mySubmit(){
        $("#userForm").submit();
    }
</script>

</body>
</html>