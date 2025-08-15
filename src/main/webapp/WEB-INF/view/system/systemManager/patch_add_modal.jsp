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

    .arrow {
        margin-top: 10px;
    }

    .kv-hidden {
        display: none;
    }

    .cs-ul-form li {
        height: 36px;
    }

    .cs-soft-list li {
        padding-bottom: 4px;
    }

    #editor {
        max-height: 180px;
        height: 180px;
        width: 89%;
    }

    .cs-col-lg {
        height: 39px;
    }

    .Validform_checktip {
        display: none;
    }

    .fixed-footer {
        position: fixed;
        bottom: 0;
        left: 0;
        width: 100%;
    }
    </style>
</head>
<body>
<div data-options="region:'north',border:false" style="border: none; overflow: hidden; height: 39px; padding:0px;"
     title=""
     class="panel-body panel-body-noheader panel-body-noborder layout-body">
    <div class="cs-col-lg clearfix">
        <!-- 面包屑导航栏 开始-->
        <ol class="cs-breadcrumb">
            <li class="cs-fl">
                <img src="${webRoot}/img/set.png" alt=""/>
                <a href="javascript:">数据中心</a></li>
            <li class="cs-fl">
                <i class="cs-sorrow">&gt;</i></li>
            <li class="cs-b-active cs-fl">相关下载</li>
            <li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
            <c:choose>
                <c:when test="${show eq '1'}">
                    <li class="cs-b-active cs-fl">新增补丁包</li>
                </c:when>
                <c:otherwise>
                    <li class="cs-b-active cs-fl">编辑补丁包</li>
                </c:otherwise>
            </c:choose>

        </ol>
        <!-- 面包屑导航栏 结束-->
        <div class="cs-search-box cs-fr">
            <form action="">
                <div class="clearfix cs-fr">
                    <a href="${webRoot}/systemManager/patchDownload?type=${appType}&editPermission=${editPermission}&deletePermission=${deletePermission}"class="cs-menu-btn
                    returnBtn"><i class="icon iconfont icon-fanhui"></i>返回</a>
                </div>
            </form>
        </div>
    </div>
</div>
<div data-options="region:'center'" id="div1" style="padding:0; border:0;">
    <div class="cs-main">
        <div class="cs-wraper">
            <form class="registerform" id="TSSMGForm" method="post" enctype="multipart/form-data">
                <input name="id" id="id" type="hidden" value="${tsSystemManager.id}"/>
                <input type="hidden" name="fileSize"/>
                <input type="hidden" name="patchState" value="1"/>
                <input type="hidden" name="urlPath" value="${tsSystemManager.urlPath}"/>
                <div width="100%" class="cs-add-new">
                    <ul class="cs-ul-form clearfix">
                        <li class="cs-name col-xs-1 col-md-1">软件类型：</li>
                        <li class="cs-in-style  col-xs-3 col-md-3">
                            <select id="appType" name="appType" datatype="*" onchange="changeAppType(this)" nullmsg="请选择软件类型！" errormsg="请选择软件类型！">
                                <c:choose>
                                    <c:when test="${not empty appTypes}">
                                        <c:forEach items="${appTypes}" var="type">
                                            <option data-introduce="${type.introduce}" data-devicename="${type.device_series}"
                                                    value="${type.device_series}">${type.device_series}</option>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <option value="${appType}">${appType}</option>
                                    </c:otherwise>
                                </c:choose>
                            </select>
                        </li>
                        <li class="cs-name  col-xs-1 col-md-1">补丁名称：</li>
                        <li class="cs-in-style col-md-3 col-xs-3">
                            <input type="text" value="${tsSystemManager.appName}" id="appName" name="appName" class="inputxt"/>
                        </li>
                        <li class="cs-name col-xs-1 col-md-1">启用时间：</li>
                        <li class="cs-in-style  col-md-3 col-xs-3"><input
                                name="impDate" class="cs-time" type="text"
                                onFocus="WdatePicker({startDate:'%y-%M-%d %H:%m:%s',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
                                datatype="*" nullmsg="请选择启用时间" errormsg="请选择启用时间" value="${tsSystemManager.startTime2}">
                        </li>
                        <li class="cs-name col-xs-1 col-md-1">对内版本：</li>
                        <li class="cs-in-style  col-md-3 col-xs-3">
                            <input type="text" value="${tsSystemManager.version}" name="version" class="inputxt" datatype="*" nullmsg="请输入版本号"
                                   errormsg="请输入对内版本号"/>
                        </li>
                        <li class="cs-name col-xs-1 col-md-1">对外版本：</li>
                        <li class="cs-in-style  col-md-3 col-xs-3">
                            <input type="text" value="${tsSystemManager.param1}" name="param1" class="inputxt" datatype="*" nullmsg="请输入版本号"
                                   errormsg="请输入对外版本号"/>
                        </li>
                        <li class="cs-name col-xs-1 col-md-1">强制更新：</li>
                        <li class="col-md-3 col-xs-3 cs-check-radio cs-li-radio">
                            <input class="cs-piao1" id="y" type="radio" name="param2" value="1">
                            <label for="y">是</label>
                            <input class="cs-piao2" id="n" type="radio" name="param2" value="0" checked="checked">
                            <label for="n">否</label>
                            <script>
                                $("input[type='radio'][name='param2'][value=" + ${tsSystemManager.param2} +"]").prop("checked", "checked");
                            </script>
                        </li>
                        <ul id="files">
                            <li class="cs-name col-xs-1 col-md-1">补丁包：</li>
                            <li class="cs-in-style col-md-3 col-xs-3" width="210px">
                                <div class="kv-main">
                                    <input id="kv-explorer" name="file" type="file" onchange="fileChange(this);">
                                </div>
                            </li>
                        </ul>
                    </ul>
                    <ul class="cs-ul-form clearfix" style="display:none">
                        <li class="cs-name col-md-1 col-xs-1">软件简介：</li>
                        <li class="cs-in-style col-md-5 col-xs-5" style="height: auto;">
                            <textarea id="introduce" name="introduce" cols="30" rows="10"
                                      style="height:80px; width:80%;">${tsSystemManager.introduce}</textarea>
                        </li>
                        <li class="cs-name col-md-1 col-xs-1">更新摘要：</li>
                        <li class="cs-in-style col-md-5 col-xs-5" style="height: auto;">
                            <textarea name="description" cols="30" rows="10"
                                      style="height:80px; width:80%;">${tsSystemManager.description}</textarea>
                        </li>
                    </ul>
                    <ul class="clearfix">
                        <li class="cs-name col-md-1 col-xs-1">更新说明：</li>
                        <li class="cs-in-style col-md-11 col-xs-11" style="height: auto;">
                            <div class="hero-unit">
                                <div id="alerts"></div>
                                <div class="btn-toolbar" data-role="editor-toolbar" data-target="#editor">
                                    <div class="btn-group">
                                        <a class="btn dropdown-toggle" data-toggle="dropdown" title="Font"><i class="icon-font"></i><b
                                                class="caret"></b></a>
                                        <ul class="dropdown-menu">
                                        </ul>
                                    </div>
                                    <div class="btn-group">
                                        <a class="btn dropdown-toggle" data-toggle="dropdown" title="Font Size"><i
                                                class="icon-text-height"></i>&nbsp;<b class="caret"></b></a>
                                        <ul class="dropdown-menu">
                                            <li><a data-edit="fontSize 5"><font size="5">Huge</font></a></li>
                                            <li><a data-edit="fontSize 3"><font size="3">Normal</font></a></li>
                                            <li><a data-edit="fontSize 1"><font size="1">Small</font></a></li>
                                        </ul>
                                    </div>
                                    <div class="btn-group">
                                        <a class="btn" data-edit="bold" title="Bold (Ctrl/Cmd+B)"><i class="icon-bold"></i></a>
                                        <a class="btn" data-edit="italic" title="Italic (Ctrl/Cmd+I)"><i class="icon-italic"></i></a>
                                        <a class="btn" data-edit="strikethrough" title="Strikethrough"><i class="icon-strikethrough"></i></a>
                                        <a class="btn" data-edit="underline" title="Underline (Ctrl/Cmd+U)"><i class="icon-underline"></i></a>
                                    </div>
                                    <div class="btn-group">
                                        <a class="btn" data-edit="insertunorderedlist" title="Bullet list"><i
                                                class="icon-list-ul"></i></a>
                                        <a class="btn" data-edit="insertorderedlist" title="Number list"><i class="icon-list-ol"></i></a>
                                        <a class="btn" data-edit="outdent" title="Reduce indent (Shift+Tab)"><i
                                                class="icon-indent-left"></i></a>
                                        <a class="btn" data-edit="indent" title="Indent (Tab)"><i class="icon-indent-right"></i></a>
                                    </div>
                                    <div class="btn-group">
                                        <a class="btn" data-edit="justifyleft" title="Align Left (Ctrl/Cmd+L)"><i
                                                class="icon-align-left"></i></a>
                                        <a class="btn" data-edit="justifycenter" title="Center (Ctrl/Cmd+E)"><i
                                                class="icon-align-center"></i></a>
                                        <a class="btn" data-edit="justifyright" title="Align Right (Ctrl/Cmd+R)"><i
                                                class="icon-align-right"></i></a>
                                        <a class="btn" data-edit="justifyfull" title="Justify (Ctrl/Cmd+J)"><i
                                                class="icon-align-justify"></i></a>
                                    </div>
                                    <div class="btn-group">
                                        <a class="btn dropdown-toggle" data-toggle="dropdown" title="Hyperlink"><i class="icon-link"></i></a>
                                        <div class="dropdown-menu input-append">
                                            <input class="span2" placeholder="URL" type="text" data-edit="createLink"/>
                                            <button class="btn" type="button">Add</button>
                                        </div>
                                        <a class="btn" data-edit="unlink" title="Remove Hyperlink"><i class="icon-cut"></i></a>

                                    </div>

                                    <div class="btn-group">
                                        <a class="btn" title="Insert picture (or just drag & drop)" id="pictureBtn"><i
                                                class="icon-picture"></i></a>
                                        <input type="file" data-role="magic-overlay" data-target="#pictureBtn" data-edit="insertImage"/>
                                    </div>
                                    <div class="btn-group">
                                        <a class="btn" data-edit="undo" title="Undo (Ctrl/Cmd+Z)"><i class="icon-undo"></i></a>
                                        <a class="btn" data-edit="redo" title="Redo (Ctrl/Cmd+Y)"><i class="icon-repeat"></i></a>
                                    </div>
                                    <input type="text" data-edit="inserttext" id="voiceBtn" x-webkit-speech="">
                                </div>
                                <div id="editor" style="text-align:left;">
                                    ${tsSystemManager.updateContent}
                                </div>
                            </div>
                        </li>
                    </ul>
                </div>
            </form>
        </div>
        <div class="modal-footer action" style="margin-top: 40px;">
            <button type="button" class="btn btn-success" id="btnSave">确定</button>
            <button type="button" onclick="window.location.href='${webRoot}/systemManager/patchDownload?type=${appType}&editPermission=${editPermission}&deletePermission=${deletePermission}'"
                    class="btn btn-default"
                    data-dismiss="modal">关闭
            </button>
        </div>
    </div>
</div>

<!-- 操作失败或成功弹出框 -->
<div class="modal fade intro2" id="btn-warnning" tabindex="-1"
     role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog cs-alert-width">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"
                        aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title">上传进度</h4>
            </div>
            <div class="modal-body cs-alert-height cs-dis-tab" id="conment">
                <div class="progress">
                    <div id="progress" class="progress-bar" aria-valuenow="100" aria-valuemin="0" aria-valuemax="100">

                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <a class="btn btn-success btn-ok"
                   data-dismiss="modal" id="close">确定</a>
            </div>
        </div>
    </div>
</div>
<%@include file="/WEB-INF/view/common/modalBox.jsp" %>
<script>
    var appType = "${appType}";
    $("#appType option[value='" + appType + "']").attr("selected", "selected");
    var deviceName = $("#appType option[value='" + appType + "']").data("devicename");
    var introduce = $("#appType option[value='" + appType + "']").data("introduce");
    var id = $("#id").val();
    if (!id) {
        $("#appName").val(deviceName);
        $("#introduce").val(introduce);
    }
    //=====================================
    function changeAppType() {
        var device_series = $("#appType option:selected").val();//被选中的
        var deviceName = $("#appType option:selected").data("devicename");
        var introduce = $("#appType option:selected").data("introduce");
        if (!id) {
            $("#appName").val(deviceName);
            $("#introduce").val(introduce);
        }
    }
</script>
<script>
    //====================================保存的表单验证=========================
    $(function () {
        $("#TSSMGForm").Validform({
            tiptype: 2, beforeSubmit: function () {
                if (!$("#files .file-caption-name").val()) {
                    $("input[name=urlPath]").val("")
                }
                var formData = new FormData($('#TSSMGForm')[0]);//拿到该表单对象
                formData.append("updateContent", $("#editor").html());
                $("#btn-warnning").modal("show");
                $.ajax({
                    url: '${webRoot}/systemManager/saveOrUpdate.do',
                    type: 'POST',
                    //数据
                    data: formData,
                    //使jq不处理数据类型和不设置Content-Type请求头
                    cache: false,
                    contentType: false,
                    processData: false,
                    beforeSend: function () {
                        console.log('发送ajax前');
                    },
                    xhr: function () {//这里我们先拿到jQuery产生的 XMLHttpRequest对象，为其增加 progress 事件绑定，然后再返回交给ajax使用
                        myXhr = $.ajaxSettings.xhr();
                        if (myXhr.upload) {
                            myXhr.upload.addEventListener('progress', progressHandlingFunction, false)//progress事件会在浏览器接收新数据期间周期性地触发。而onprogress事件处理程序会接收到一个event对象，其target属性是XHR对象，但包含着三个额外的属性：lengthComputable、loaded和total。其中，lengthComputable是一个表示进度信息是否可用的布尔值，loaded表示已经接收的字节数，loaded表示根据Content-Length响应头部确定的预期字节数。
                        }
                        return myXhr; //xhr对象返回给jQuery使用
                    },
                    success: function (data) {
                        if (data.success) {
                            $("#conment").append("<center><span>上传成功</span></center>");
                            $("#close").attr("onclick", "window.location.href='${webRoot}/systemManager/patchDownload?type=${appType}&editPermission=${editPermission}&deletePermission=${deletePermission}'")
                        } else {
                            $("#conment").append('<center><span style="color: red">上传失败</span></center>');
                            $("#close").attr("onclick", "window.location.reload()");
                            var progress = $("#progress");
                            progress.addClass("progress-bar-danger");
                            progress.css("width", 50 + '%');
                            progress.html(50 + '%')

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

    //上传进度获取计算设置进度条
    function progressHandlingFunction(event) {
        if (event.lengthComputable) {
            var per = (event.loaded / event.total * 100 | 0);
            //计算百分比
            //per = parseInt(value);
            console.log(per);
            var progress = document.getElementById('progress');
            progress.style.width = per + '%';
            progress.innerHTML = per + "%";
        }
    }

    //后台文件名称的显示和隐藏
    function change(obj) {
        var selectedValue = $(obj).val();
        if (selectedValue == 0) {
            $("#yn").show();
            $("#files").hide();
            $("#fullName").attr("datatype", "*");
        } else {
            $("#fullName").removeAttr("datatype");
            $("#yn").hide();
            $("#files").show();
        }
    }
</script>

<script type="text/javascript">
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
        $(".file-caption-name").val("${tsSystemManager.packgeFileName}");
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
                $('#voiceBtn').css('position', 'absolute').offset({top: editorOffset.top, left: editorOffset.left + $('#editor').innerWidth() - 35});
            } else {
                $('#voiceBtn').hide();
            }
        }
        function showErrorAlert(reason, detail) {
            alert(3)
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
