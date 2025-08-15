<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/WEB-INF/view/common/resource.jsp" %>
<html>
<head>
    <title>快检服务云平台</title>
    <style type="text/css">
        #content {
            width: 500px;
            height: 170px;
            margin: 100px auto;
        }
        .cs-add-pad input[type=text], .android-search-input input[type=text], .cs-add-pad select, .cs-add-pad .js-data-example-ajax, .cs-add-pad .select2-container {
            width: 100%;
            max-width: 300px;
        }
    </style>
</head>

<body>
<div class="cs-maintab">
    <div class="cs-col-lg clearfix">
        <ol class="cs-breadcrumb">
            <li class="cs-fl">
                <img src="${webRoot}/img/set.png" alt="">
                <a href="javascript:;">系统管理</a></li>
            <li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
            <li class="cs-fl"><a href="javascript:;">操作日志</a></li>
            <li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
            <li class="cs-b-active cs-fl">日志详情
            </li>
        </ol>
        <!-- 面包屑导航栏  结束-->
        <div class="cs-search-box cs-fr">
            <div class="cs-fr cs-ac ">
                <a href="javascript:;" onclick="parent.closeMbIframe();" class="cs-menu-btn cs-fun-btn"><i class="icon iconfont icon-fanhui" ></i>返回</a>
            </div>
        </div>
    </div>
    <div class="cs-tb-box">
        <div class="cs-base-detail">
            <div class="cs-content2 clearfix">
                <form id="showForm" action="">
                    <div class="cs-add-new cs-add-pad cs-input-bg">
                        <ul class="cs-ul-form clearfix">
                            <li class="cs-name col-xs-2 col-md-2">用户姓名：</li>
                            <li class="cs-in-style  col-xs-3 col-md-3">
                                <input type="text" disabled="disabled" name="userName"/>
                            </li>
                            <li class="cs-name col-xs-2 col-md-2">操作IP：</li>
                            <li class="cs-in-style  col-xs-3 col-md-3">
                                <input type="text" disabled="disabled" name="remoteIp"/>
                            </li>
                        </ul>
                        <ul class="cs-ul-form clearfix">
                            <li class="cs-name col-xs-2 col-md-2">系统模块：</li>
                            <li class="cs-in-style  col-xs-3 col-md-3">
                                <input type="text" disabled="disabled" name="module"/>
                            </li>
                            <li class="cs-name col-xs-2 col-md-2">系统功能：</li>
                            <li class="cs-in-style  col-xs-3 col-md-3">
                                <input type="text" disabled="disabled" name="func"/>
                            </li>
                        </ul>
                        <ul class="cs-ul-form clearfix">
                            <li class="cs-name col-xs-2 col-md-2">操作时间：</li>
                            <li class="cs-in-style  col-xs-3 col-md-3">
                                <input type="text" disabled="disabled" name="operateTime"/>
                            </li>
                            <li class="cs-name col-xs-2 col-md-2">执行结果：</li>
                            <li class="cs-in-style  col-xs-3 col-md-3">
                                <input type="text" disabled="disabled" name="operatorResult"/>
                            </li>
                        </ul>
                        <ul class="cs-ul-form clearfix">
                            <li class="cs-name col-xs-2 col-md-2">归属地：</li>
                            <li class="cs-in-style  col-md-3 col-xs-3">
                                <input type="text" disabled="disabled" name="param1"/>
                            </li>
                        </ul>
                        <ul class="cs-ul-form clearfix" id="requestParam">
                            <li class="cs-name col-md-2 col-xs-2">请求参数：</li>
                            <li class="cs-in-style col-md-10 col-xs-10" style="height: auto;">
                            <textarea name="requestParam" disabled="disabled" cols="30" rows="10" style="height:80px; width:90%;line-height: 25px;"></textarea>
                            </li>
                        </ul>
                        <ul class="cs-ul-form clearfix" id="description">
                            <li class="cs-name col-md-2 col-xs-2">返回结果：</li>
                            <li class="cs-in-style col-md-10 col-xs-10" style="height: auto;">
                                <textarea name="description" disabled="disabled" cols="30" rows="10" style="height:80px; width:90%;line-height: 25px;"></textarea>
                            </li>
                        </ul>
                        <ul class="cs-ul-form clearfix" id="beforeData">
                            <li class="cs-name col-md-2 col-xs-2">修改前数据：</li>
                            <li class="cs-in-style col-md-10 col-xs-10" style="height: auto;">
                                <textarea name="beforeData" disabled="disabled" cols="30" rows="10" style="height:80px; width:90%;line-height: 25px;"></textarea>
                            </li>
                        </ul>
                        <ul class="cs-ul-form clearfix" id="afterData">
                            <li class="cs-name col-md-2 col-xs-2">修改后数据：</li>
                            <li class="cs-in-style col-md-10 col-xs-10" style="height: auto;">
                                <textarea name="afterData" disabled="disabled" cols="30" rows="10" style="height:80px; width:90%;line-height: 25px;"></textarea>
                            </li>
                        </ul>
                        <ul class="cs-ul-form clearfix" id="exception">
                            <li class="cs-name col-md-2 col-xs-2">异常信息：</li>
                            <li class="cs-in-style col-md-10 col-xs-10" style="height: auto;">
                                <textarea name="exception" disabled="disabled" cols="30" rows="10" style="height:80px; width:90%;line-height: 25px;"></textarea>
                            </li>
                        </ul>
                    </div>
                </form>
            </div>

        </div>
    </div>
    <!-- 底部导航 结束 -->
      <div class="cs-hd"></div>
          <div class="cs-alert-form-btn">
              <a href="javascript:;" onclick="parent.closeMbIframe();" class="cs-menu-btn cs-fun-btn"><i class="icon iconfont icon-fanhui" ></i>返回</a>
          </div>
</div>
<script>
    $(function () {
        choseModule();
    });

    function choseModule() {
        $(".choseModule").empty();
        $.ajax({
            url: "${webRoot}/sysLog/queryById.do",
            type: "POST",
            dataType: "json",
            data:{id:${id}},
            success: function (data) {
                var form = $('#showForm');
                form.form('load', data.obj);
                if(data.obj.operatorResult==0){
                    $("#showForm input[name=operatorResult]").val("成功");
                }else{
                    $("#showForm input[name=operatorResult]").val("失败");
                }
            }
        });
    }
</script>
</body>
</html>
