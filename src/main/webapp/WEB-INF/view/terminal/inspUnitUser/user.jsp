<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/WEB-INF/view/common/resource.jsp" %>
<!DOCTYPE html>
<head>
    <title>快检服务云平台</title>
</head>
<body>
<div class="cs-maintab">
    <div class="cs-col-lg clearfix">
        <!-- 面包屑导航栏  开始-->
        <ol class="cs-breadcrumb">
            <li class="cs-fl">
                <img src="${webRoot}/img/set.png" alt=""/>
                <a href="javascript:">财务管理</a></li>
            <li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
            <li class="cs-b-active cs-fl">账户余额
            </li>
            <li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
            <li class="cs-b-active cs-fl">用户信息
            </li>
        </ol>
        <!-- 面包屑导航栏  结束-->
        <div class="cs-search-box cs-fr">
            <button class="cs-menu-btn" onclick="parent.closeMbIframe(1);"><i class="icon iconfont icon-fanhui"></i>返回</button>
        </div>
    </div>
    <div class="cs-base-detail">
        <div class="cs-content2">
            <table class="cs-add-new">
                <tr>
                    <td class="cs-name showPerson1">用户编号：</td>
                    <td class="cs-in-style" id="id"></td>
                    <td class="cs-name">用户姓名(该界面暂时无用)：</td>
                    <td class="cs-in-style" id="realName"></td>
                    <td class="cs-name">联系方式：</td>
                    <td class="cs-in-style" id="phone"></td>
                </tr>
                <tr>
                    <td class="cs-name">用户状态：</td>
                    <td class="cs-in-style">
                        <label><input disabled="disabled" type="radio" name="checked" value="1"/>启用</label>
                        <label><input disabled="disabled" type="radio" name="checked" value="0"/>停用</label>
                    </td>
                    <td class="cs-name">用户类型：</td>
                    <td class="cs-in-style">
                        <label><input disabled="disabled" type="radio" name="userType" value="1"/>企业</label>
                        <label><input disabled="disabled" type="radio" name="userType" value="0"/>个人</label>
                    </td>
                    <td class="cs-name">用户角色：</td>
                    <td class="cs-in-style">
                        <label><input disabled="disabled" type="radio" name="type" value="0"/> 普通用户</label>
                        <label><input disabled="disabled" type="radio" name="type" value="1"/> 管理用户</label>
                    </td>
                </tr>
                <tr id="showCompany1">
                    <td class="cs-name">公司名称：</td>
                    <td class="cs-in-style" id="inspectionName"></td>
                    <td class="cs-name">社会信用代码：</td>
                    <td class="cs-in-style" id="creditCode"></td>
                </tr>
                <tr id="showCompany2">
                    <td class="cs-name">身份证号：</td>
                    <td class="cs-in-style" id="identifiedNumber"></td>
                </tr>
            </table>
        </div>
    </div>
    <!-- 底部导航 结束 -->
    <div class="cs-hd"></div>
    <div class="cs-alert-form-btn">
        <a href="javascript:" onclick="parent.closeMbIframe(1);" class="cs-menu-btn cs-fun-btn"><i class="icon iconfont icon-fanhui"></i>返回</a>
    </div>
</body>
<!-- 引用模态框 -->
<%@include file="/WEB-INF/view/common/confirm.jsp" %>
<script>
    //如果是编辑就去查询数据回显

    $(function () {
        var userId = "${userId}";
        if (userId) {
            $.ajax({
                type: 'POST',
                url: "${webRoot}/inspUnitUser/queryByUserId.do",
                data: {'userId': userId},
                dataType: 'json',
                success: function (data) {
                    if (data && data.success) {
                        var obj = data.obj;
                        $("#id").text(obj.id);
                        $("#realName").text(obj.realName);
                        $("#phone").text(obj.phone);
                        $("#inspectionName").text(obj.inspectionName);
                        $("#creditCode").text(obj.creditCode);
                        $("#identifiedNumber").text(obj.identifiedNumber);
                        $("input[name=checked][value="+obj.checked+"]").prop("checked", "checked");
                        $("input[name=userType][value="+obj.userType+"]").prop("checked", "checked");
                        $("input[name=type][value="+obj.type+"]").prop("checked", "checked");
                        if(obj.userType==1){
                            $("#showCompany1").removeClass("hide");
                            $("#showCompany2").addClass("hide");
                        }else{
                            $("#showCompany2").removeClass("hide");
                            $("#showCompany1").addClass("hide");
                        }
                    } else {
                        $("#waringMsg>span").html(data.msg);
                        $("#confirm-warnning").modal('toggle');
                    }
                }
            });
        }
    })

</script>
</html>
