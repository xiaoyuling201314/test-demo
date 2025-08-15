<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@include file="/WEB-INF/view/common/resource.jsp" %>

<link rel="stylesheet" type="text/css" href="${webRoot}/css/fileinput.css"/>
<link rel="stylesheet" type="text/css" href="${webRoot}/css/theme.css"/>

<link rel="stylesheet" type="text/css" href="${webRoot}/css/font/font-awesome.css" rel="stylesheet">

<link rel="stylesheet" type="text/css" href="${webRoot}/css/boot-slim.css"/>
<!-- 上传 -->

<script src="${webRoot}/js/sortable.js" type="text/javascript"></script>
<script src="${webRoot}/js/fileinput.js" type="text/javascript"></script>
<script src="${webRoot}/js/zh.js" type="text/javascript"></script>
<script src="${webRoot}/js/theme.js" type="text/javascript"></script>
<html>
<head>
    <title>快检服务云平台</title>
    <style type="text/css">.cs-ss {
        position: absolute;
        left: 0;
        right: 0;
        bottom: 0;
        top: 0;
        height: 100%;
        width: 100%;
        border: none;
        border: 0;
    }

    .cs-tabList {
        padding: 0;
    }

    .panel-primary {
        margin-bottom: 10px;
    }

    .panel {
        border-width: 1px;
    }

    .panel-body {
        /*border-width: 1px;*/

    }

    .panel-artic {
        padding: 0;
    }

    .cs-soft-download {
        height: auto;
    }

    .download-img {
        height: 126px;
    }

    .download-img {
        width: auto;
    }

    .cs-not-used {
        background: #f1f1f1 url(../img/2.png) no-repeat;
        background-position: right top;
        background-size: 50px;
    }
    </style>
</head>
<body>
<div data-options="region:'center'" id="div1" style="padding:3px 3px; border:0;">
    <div data-options="region:'north',border:false" style="border: none; overflow: hidden; width: 1213px; height: 39px; padding:0px;" title=""
         class="panel-body panel-body-noheader panel-body-noborder layout-body">
        <div class="cs-col-lg clearfix" style="border-bottom: none;">
            <!-- 面包屑导航栏 开始-->
            <ol class="cs-breadcrumb">
                <li class="cs-fl">
                    <img src="${webRoot}/img/set.png" alt=""/>
                    <a href="javascript:">数据中心</a></li>
                <li class="cs-fl">
                    <i class="cs-sorrow">&gt;</i></li>
                <li class="cs-b-active cs-fl">相关下载</li>
                <li class="cs-fl">
                    <i class="cs-sorrow">&gt;</i></li>
                <li class="cs-b-active cs-fl">补丁包下载</li>
            </ol>
            <!-- 面包屑导航栏 结束-->
            <div class="cs-search-box cs-fr">
                <form action="">
                    <div class="clearfix cs-fr" id="addSoftware">
                        <a href="${webRoot}/systemManager/appQrcode?appType=${appType}" class="cs-menu-btn returnBtn"><i
                                class="icon iconfont icon-fanhui"></i>返回</a>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <div class="panel-artic">
        <h3>补丁包下载</h3>
        <br>
    </div>
    <div class="panel panel-primary">
        <c:if test="${not empty tsSystemManager}">
        <div class="panel-body">
            <c:choose>
            <c:when test="${tsSystemManager.appType eq 'APP'}">
            <div class="col-sm-2 col-md-2">
                <div class="download-img">
                    <img src="${webRoot}/systemManager/appQrcodeImg.do?urlPath=${webRoot}/resources/${tsSystemManager.urlPath}" alt=""
                         style="width:100%; max-width:126px;">
                </div>
            </div>
            <div class="clearfix cs-used col-sm-10 col-md-10 cs-none-pr">
                <div class="cs-tabList clearfix " style="box-shadow:0 0 0 #fff;">
                    <div class="cs-tab-top clearfix">
                        <div class="cs-app-info cs-fl">
                            <div class="cs-app-span">
                                <span class="cs-app-ver">名称：<i class="text-primary">${tsSystemManager.appName}</i></span>
                                <span class="cs-app-ver">版本：<i class="text-primary">${tsSystemManager.versions}</i></span>
                                <span class="cs-app-ver">大小：<i class="text-primary">${tsSystemManager.fileSize}M</i></span>
                            </div>
                            <div class="cs-app-span">
                                <span class="cs-app-ver">启用时间：<i class="text-primary">${tsSystemManager.startTime2}</i></span>
                                <span class="cs-app-ver">强制更新：<i class="text-primary">${tsSystemManager.param2}</i></span>
                            </div>
                            
                        </div>
                        </c:when>
                        <c:otherwise>
                        <c:forEach items="${appTypeImgs}" var="appTypeImg">
                        <c:if test="${tsSystemManager.appType eq appTypeImg.deviceSeries}">
                        <div class="cs-tab-top clearfix">
                            <div class="col-sm-2 col-md-2">
                                <div class="download-img">
                                    <img src="${webRoot}${appTypeImg.filePath}" alt="" style="width:100%; max-width:126px;">
                                </div>
                            </div>
                            <div class="clearfix cs-used col-sm-10 col-md-10 cs-none-pr">
                                <div class="cs-tabList clearfix " style="box-shadow:0 0 0 #fff;">
                                    <div class="cs-tab-top clearfix">
                                        <div class="cs-app-info cs-fl">
                                            <div class="cs-app-span">
                                                <span class="cs-app-ver">名称：<i class="text-primary">${tsSystemManager.appName}</i></span>
                                                <span class="cs-app-ver">版本：<i class="text-primary">${tsSystemManager.versions}</i></span>
                                                <span class="cs-app-ver">大小：<i class="text-primary">${tsSystemManager.fileSize}M</i></span>
                                            </div>
                                            <div class="cs-app-span">
                                                <span class="cs-app-ver">启用时间：<i class="text-primary">${tsSystemManager.startTime2}</i></span>
                                                <span class="cs-app-ver">强制更新：<i class="text-primary">${tsSystemManager.param2}</i></span>
                                            </div>
                                            
                                        </div>
                                        </c:if>
                                        </c:forEach>
                                        </c:otherwise>
                                        </c:choose>
                                        <div class="cs-soft-download cs-fl" id="btn1">
                                            <c:if test="${editPermission eq '1'}">
                                                <a href="javascript:" class="" data-id="${tsSystemManager.id}" onclick="btnEdit(this)">
                              <span class="btn btn-success cs-tab-btn cs-tab-btnS"><i
                                      class="icon iconfont icon-xiugai"></i>编辑</span></a>
                                            </c:if>
                                            <a href="${webRoot}/resources/${tsSystemManager.urlPath}" class="">
                                     <span class="btn btn-primary cs-tab-btn text-primary cs-tab-btnS"><i
                                             class="icon iconfont icon-xiafa"></i>下载</span></a>
                                        </div>
                                    </div>
                                    <div class="cs-article-content">
                                        <div class="cs-articale-show"><a id="headingOne" role="button" data-toggle="collapse"
                                                                         data-parent="#accordion"
                                                                         href="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
                                            收起说明
                                            <i class="icon iconfont icon-icon-up"></i></a></div>
                                        <p class="cs-article-title">更新说明：</p>
                                        <div id="collapseOne" class="cs-article-contian cs-page-show in">
                                                ${tsSystemManager.updateContent}
                                        </div>
                                        <script>
                                            $('#collapseOne').on('hidden.bs.collapse', function () {
                                                $("#headingOne").html('展开阅读<i class="icon iconfont icon-icon-down"></i>');
                                            })
                                            $('#collapseOne').on('show.bs.collapse', function () {
                                                $("#headingOne").html('收起说明<i class="icon iconfont icon-icon-up"></i>');
                                            })
                                        </script>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    </c:if>
                </div>

                <%--未启用版本--%>
                <c:if test="${editPermission eq '1'}">
                <c:forEach items="${notEnableds}" var="notEnabled" varStatus="num">
                <div class="panel panel-primary">
                    <div class="panel-body cs-not-used">
                        <c:choose>
                        <c:when test="${notEnabled.appType eq 'APP'}">
                        <div class="col-sm-2 col-md-2">
                            <div class="download-img">
                                <img src="${webRoot}/systemManager/appQrcodeImg.do?urlPath=${webRoot}/resources/${notEnabled.urlPath}" alt=""
                                     style="width:100%; max-width:126px;">
                            </div>
                        </div>
                        <div class=" clearfix col-sm-10 col-md-10 cs-none-pr">
                            <div class="">
                                <div class="cs-tab-top clearfix">
                                    <div class="cs-app-info cs-fl">
                                        <div class="cs-app-span">
                                            <span class="cs-app-ver">启用时间：<i class="text-primary">${notEnabled.startTime}</i></span>
                                            <span class="cs-app-ver">大小：<i class="text-primary">${notEnabled.fileSize}M</i></span>
                                            <span class="cs-app-ver">版本：<i class="text-primary">${notEnabled.versions}</i></span>
                                        </div>
                                        <div class="cs-app-span">
                                            <span class="cs-app-ver">支持系统：<i class="text-primary">Android4.4以上</i></span>
                                            <span class="cs-app-ver">强制更新：<i class="text-primary">${notEnabled.param2}</i></span>
                                        </div>
                                        
                                    </div>
                                    </c:when>
                                    <c:otherwise>
                                    <c:forEach items="${appTypeImgs}" var="appTypeImg">
                                    <c:if test="${notEnabled.appType eq appTypeImg.deviceSeries}">
                                    <div class="cs-tab-top clearfix">
                                        <div class="col-sm-2 col-md-2">
                                            <div class="download-img">
                                                <img src="${webRoot}${appTypeImg.filePath}" alt="" style="width:100%; max-width:126px;">
                                            </div>
                                        </div>
                                        <div class=" clearfix col-sm-10 col-md-10 cs-none-pr">
                                            <div class="">
                                                <div class="cs-tab-top clearfix">
                                                    <div class="cs-app-info cs-fl">
                                                        <div class="cs-app-span">
                                                            <span class="cs-app-ver">启用时间：<i class="text-primary">${notEnabled.startTime}</i></span>
                                                            <span class="cs-app-ver">大小：<i class="text-primary">${notEnabled.fileSize}M</i></span>
                                                            <span class="cs-app-ver">版本：<i class="text-primary">${notEnabled.versions}</i></span>
                                                        </div>
                                                        <div class="cs-app-span">
                                                            <span class="cs-app-ver">支持仪器：<i
                                                                    class="text-primary">${appTypeImg.deviceSeries}</i></span>
                                                            <span class="cs-app-ver">强制更新：<i class="text-primary">${notEnabled.param2}</i></span>
                                                        </div>
                                                        
                                                    </div>
                                                    </c:if>
                                                    </c:forEach>
                                                    </c:otherwise>
                                                    </c:choose>
                                                    <div class="cs-soft-download cs-fl" id="btn1">
                                                        <c:if test="${editPermission eq '1'}">
                                                            <a href="javascript:" class="" data-id="${notEnabled.id}" onclick="btnEdit(this)">
                              <span class="btn btn-success cs-tab-btn cs-tab-btnS"><i
                                      class="icon iconfont icon-xiugai"></i>编辑</span></a>
                                                        </c:if>
                                                        <c:if test="${editPermission eq '1'}">
                                                            <a href="${webRoot}/resources/${notEnabled.urlPath}" class="">
                                       <span class="btn btn-primary cs-tab-btn text-primary cs-tab-btnS"><i
                                               class="icon iconfont icon-xiafa"></i>下载</span></a>
                                                        </c:if>
                                                        <c:if test="${deletePermission eq '1'}">
                                                            <a href="javascript:" data-id="${notEnabled.id}" onclick="btn(this)" class="">
                                       <span class="btn btn-danger cs-tab-btn text-danger cs-tab-btnS"><i
                                               class="icon iconfont icon-shanchu"></i>删除</span></a>
                                                        </c:if>
                                                    </div>
                                                </div>
                                                <div class="cs-article-content">
                                                    <div class="cs-articale-show"><a style=" color: #05af50;" id="headingOne${num.index}"
                                                                                     role="button"
                                                                                     data-toggle="collapse"
                                                                                     data-parent="#accordion"
                                                                                     href="#collapseOne${num.index}" aria-expanded="true"
                                                                                     aria-controls="collapseOne${num.index}">
                                                        收起说明
                                                        <i class="icon iconfont icon-icon-up"></i></a></div>
                                                    <p class="cs-article-title">更新说明：</p>
                                                    <div id="collapseOne${num.index}" class="cs-article-contian cs-page-show in">
                                                            ${notEnabled.updateContent}
                                                    </div>
                                                    <script>
                                                        $('#collapseOne${num.index}').on('hidden.bs.collapse', function () {
                                                            $("#headingOne${num.index}").html('展开阅读<i class="icon iconfont icon-icon-down"></i>');
                                                        });
                                                        $('#collapseOne${num.index}').on('show.bs.collapse', function () {
                                                            $("#headingOne${num.index}").html('收起说明<i class="icon iconfont icon-icon-up"></i>');
                                                        });
                                                    </script>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            </c:forEach>
                            </c:if>

                            <!-- 历史记录 -->
                            <c:if test="${not empty softwares}">
                            <div class="cs-history-line">------------------------------------- 历史补丁包下载 -------------------------------------</div>
                            <c:forEach items="${softwares}" var="software">
                            <div class="panel panel-primary panel-line">
                                <div class="panel-body">
                                    <div class="clearfix cs-history col-sm-10 col-md-10 cs-none-pr">
                                        <div class="cs-tabList clearfix " style="box-shadow:0 0 0 #fff;">
                                            <div class="cs-tab-top clearfix">
                                                <c:choose>
                                                <c:when test="${software.appType eq 'APP'}">
                                                    <div class="download-img cs-fl">
                                                        <img src="${webRoot}/systemManager/appQrcodeImg.do?urlPath=${webRoot}/resources/${software.urlPath}"
                                                             style="width:100%; max-width:126px;">
                                                    </div>
                                                    <div class="cs-app-info cs-fl">
                                                        <div class="cs-app-span">
                                                            <span class="cs-app-ver">名称：<i class="text-primary">${software.appName}</i></span>
                                                            <span class="cs-app-ver">版本：<i class="text-primary">${software.versions}</i></span>
                                                            <span class="cs-app-ver">大小：<i class="text-primary">${software.fileSize}M</i></span>
                                                        </div>
                                                        <div class="cs-app-span">
                                                            <span class="cs-app-ver">启用时间：<i class="text-primary">${software.startTime2}</i></span>
                                                            <span class="cs-app-ver">强制更新：<i class="text-primary">${software.param2}</i></span>
                                                        </div>
                                                        
                                                    </div>
                                                </c:when>
                                                <c:otherwise>
                                                <c:forEach items="${appTypeImgs}" var="appTypeImg">
                                                <c:if test="${software.appType eq appTypeImg.deviceSeries}">
                                                <div class="cs-tab-top clearfix">
                                                    <div class="download-img cs-fl">
                                                        <img src="${webRoot}${appTypeImg.filePath}" alt="" style="width:100%; max-width:126px;">
                                                    </div>
                                                    <div class="cs-app-info cs-fl">
                                                        <h5 class="cs-tab-title cs-font-weight"></h5>
                                                        <div class="cs-app-span">
                                                            <span class="cs-app-ver">名称：<i class="text-primary">${software.appName}</i></span>
                                                            <span class="cs-app-ver">版本：<i class="text-primary">${software.versions}</i></span>
                                                            <span class="cs-app-ver">大小：<i class="text-primary">${software.fileSize}M</i></span>
                                                        </div>
                                                        <div class="cs-app-span">
                                                            <span class="cs-app-ver">启用时间：<i class="text-primary">${software.startTime2}</i></span>
                                                            <span class="cs-app-ver">强制更新：<i class="text-primary">${software.param2}</i></span>
                                                        </div>
                                                        
                                                    </div>
                                                    </c:if>
                                                    </c:forEach>
                                                    </c:otherwise>
                                                    </c:choose>
                                                    <div class="cs-soft-download">
                                                        <a href="${webRoot}/resources/${software.urlPath}" class="">
                                    <span class="btn btn-primary cs-tab-btn text-primary cs-tab-btnS"><i
                                            class="icon iconfont icon-xiafa"></i>下载</span></a>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            </c:forEach>
                            </c:if>
                            <!-- Modal 提示窗-删除-->
                            <div class="modal fade intro2" id="softwares-delete" tabindex="-1"
                                 role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                                <div class="modal-dialog cs-alert-width">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <button type="button" class="close" data-dismiss="modal"
                                                    aria-label="Close">
                                                <span aria-hidden="true">&times;</span>
                                            </button>
                                            <h4 class="modal-title">确认删除</h4>
                                        </div>
                                        <div class="modal-body cs-alert-height cs-dis-tab">
                                            <div class="cs-text-algin">
                                                <img src="${webRoot}/img/stop2.png" width="40px"/>确认删除该记录吗？
                                            </div>
                                        </div>
                                        <div class="modal-footer">
                                            <a class="btn btn-danger btn-ok" onclick="deleteById()">删除</a>
                                            <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <%@include file="/WEB-INF/view/common/modalBox.jsp" %>
                            <script>
                                var id;
                                //删除方法
                                function btn(obj) {
                                    id = $(obj).data("id");
                                    $("#softwares-delete").modal('show');
                                }
                                function deleteById() {
                                    $.ajax({
                                        type: "POST",
                                        url: "${webRoot}/systemManager/delete.do",
                                        data: {'id': id},
                                        dataType: "json",
                                        success: function (data) {
                                            if (data.success) {
                                                $("#softwares-delete").modal("hide");
                                                window.location.reload();
                                            } else {
                                                alert("删除失败");
                                            }
                                        }
                                    });
                                }


                                //编辑方法
                                function btnEdit(obj) {
                                    var id = $(obj).data("id");
                                    var url = "${webRoot}/systemManager/patchAddModal.do?appType=${appType}&id=" + id + "&editPermission=${editPermission}&deletePermission=${deletePermission}";
                                    //window.parent.btnAdd2(url);
                                    window.location.href = url;
                                }


                                //====================================保存的表单验证=========================
                                $(function () {
                                    $("#TSSMGForm").Validform({
                                        tiptype: 2, beforeSubmit: function () {
                                            var formData = new FormData($('#TSSMGForm')[0]);//拿到该表单对象
                                            formData.append("updateContent", $("#editor").html());
                                            $.ajax({
                                                type: "POST",
                                                url: "${webRoot}/systemManager/saveOrUpdate.do",
                                                data: formData,
                                                contentType: false, //必须false才会避开jQuery对 formdata 的默认处理 XMLHttpRequest会对 formdata 进行正确的处理
                                                processData: false, //必须false才会自动加上正确的Content-Type
                                                dataType: "json",
                                                success: function (data) {
                                                    if (data.success) {
                                                        $("#myModal-mid4").modal('hide');
                                                        window.location.reload();
                                                    } else {
                                                        $("#btn-warnning").modal('toggle');
                                                    }
                                                }
                                            });
                                            return false;
                                        }
                                    });
                                    // 新增或修改
                                    $("#btnSave").on("click", function () {
                                        $("#TSSMGForm").submit();
                                        return false;
                                    });
                                });
                            </script>

                            <script type="text/javascript">
                                //控制更新内容的伸展
                                //    $(document).ready(function () {
                                //        var show = 1;
                                //        $('.cs-articale-show').click(function (event) {
                                //            if (show == 1) {
                                ////                $(this).siblings('.cs-article-contian').addClass('cs-page-show')
                                //                $(this).siblings('.cs-article-contian').collapse('hide');
                                //                show = 0;
                                //
                                //            }
                                //            else {
                                //                $(this).siblings('.cs-article-contian').collapse('show');
                                //                show = 1;
                                //            }
                                //        });
                                //    });

                                /*$('.cs-articale-show').on('hidden.bs.collapse', function () {

                                 })
                                 $('#collapseOne').on('shown.bs.collapse', function () {

                                 })*/

                                //控制选中文件的样式
                                $(document).ready(function () {
                                    $("#kv-explorer").fileinput({
                                        'theme': 'explorer',
                                        'uploadUrl': '#',
                                        textEncoding: 'UTF-8',
                                        language: 'zh',
                                        overwriteInitial: false,
                                        initialPreviewAsData: true,
                                        dropZoneEnabled: false,
                                        showClose: false,
                                        maxFileCount: 10,
                                        browseLabel: '浏览'
                                    });
                                });

                                //获取文件的大小
                                var isIE = /msie/i.test(navigator.userAgent) && !window.opera;
                                function fileChange(target) {
                                    var fileSize = 0;
                                    var filepath = target.value;
                                    var filemaxsize = 1024 * 1000;//1000M
                                    if (isIE && !target.files) {
                                        var filePath = target.value;
                                        var fileSystem = new ActiveXObject("Scripting.FileSystemObject");
                                        if (!fileSystem.FileExists(filePath)) {
                                            alert("文件不存在，请重新选择！");
                                            return false;
                                        }
                                        var file = fileSystem.GetFile(filePath);
                                        fileSize = file.Size;

                                    } else {
                                        fileSize = target.files[0].size;
                                    }
                                    var size = fileSize / 1024;
                                    if (size <= 0) {
                                        alert("文件大小不能为0M！");
                                        target.value = "";
                                        return false;
                                    }
                                    //赋值
                                    $("input[name=fileSize]").val(Math.round(size / 1024 * 100) / 100);
                                }
                            </script>
                            <!-- 富文本 -->
                            <script>
                                $(function () {
                                    function initToolbarBootstrapBindings() {
                                        var fonts = ['Serif', 'Sans', 'Arial', 'Arial Black', 'Courier',
                                                'Courier New', 'Comic Sans MS', 'Helvetica', 'Impact', 'Lucida Grande', 'Lucida Sans', 'Tahoma', 'Times',
                                                'Times New Roman', 'Verdana'],
                                            fontTarget = $('[title=Font]').siblings('.dropdown-menu');
                                        $.each(fonts, function (idx, fontName) {
                                            fontTarget.append($('<li><a data-edit="fontName ' + fontName + '" style="font-family:\'' + fontName + '\'">' + fontName + '</a></li>'));
                                        });
                                        $('a[title]').tooltip({container: 'body'});
                                        $('.dropdown-menu input').click(function () {
                                            return false;
                                        }).change(function () {
                                            $(this).parent('.dropdown-menu').siblings('.dropdown-toggle').dropdown('toggle');
                                        }).keydown('esc', function () {
                                            this.value = '';
                                            $(this).change();
                                        });
                                        $('[data-role=magic-overlay]').each(function () {
                                            var overlay = $(this), target = $(overlay.data('target'));
                                            overlay.css('opacity', 0).css('position', 'absolute').offset(target.offset()).width(target.outerWidth()).height(target.outerHeight());
                                        });
                                        if ("onwebkitspeechchange" in document.createElement("input")) {
                                            var editorOffset = $('#editor').offset();
                                            $('#voiceBtn').css('position', 'absolute').offset({
                                                top: editorOffset.top,
                                                left: editorOffset.left + $('#editor').innerWidth() - 35
                                            });
                                        } else {
                                            $('#voiceBtn').hide();
                                        }
                                    }
                                    function showErrorAlert(reason, detail) {
                                        var msg = '';
                                        if (reason === 'unsupported-file-type') {
                                            msg = "Unsupported format " + detail;
                                        }
                                        else {
                                            console.log("error uploading file", reason, detail);
                                        }
                                        $('<div class="alert"> <button type="button" class="close" data-dismiss="alert">&times;</button>' +
                                            '<strong>File upload error</strong> ' + msg + ' </div>').prependTo('#alerts');
                                    }
                                    initToolbarBootstrapBindings();
                                    $('#editor').wysiwyg({fileUploadError: showErrorAlert});
                                    window.prettyPrint && prettyPrint();
                                });
                            </script>
                            <script>
                                (function (i, s, o, g, r, a, m) {
                                    i['GoogleAnalyticsObject'] = r;
                                    i[r] = i[r] || function () {
                                            (i[r].q = i[r].q || []).push(arguments)
                                        }, i[r].l = 1 * new Date();
                                    a = s.createElement(o),
                                        m = s.getElementsByTagName(o)[0];
                                    a.async = 1;
                                    a.src = g;
                                    m.parentNode.insertBefore(a, m)
                                })(window, document, 'script', '', 'ga');
                                ga('create', 'UA-37452180-6', 'github.io');
                                ga('send', 'pageview');
                            </script>
                            <script>(function (d, s, id) {
                                var js, fjs = d.getElementsByTagName(s)[0];
                                if (d.getElementById(id)) return;
                                js = d.createElement(s);
                                js.id = id;
                                js.src = "";
                                fjs.parentNode.insertBefore(js, fjs);
                            }(document, 'script', 'facebook-jssdk'));
                            </script>

                            <script>
                                !function (d, s, id) {
                                    var js, fjs = d.getElementsByTagName(s)[0];
                                    if (!d.getElementById(id)) {
                                        js = d.createElement(s);
                                        js.id = id;
                                        js.src = "";
                                        fjs.parentNode.insertBefore(js, fjs);
                                    }
                                }(document, "script", "twitter-wjs");
                            </script>
</body>
</html>
