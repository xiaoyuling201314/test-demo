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

    iframe {
        border: 0;
    }

    .arrow {
        margin-top: 10px;
    }
    </style>
</head>
<body>
<div class="easyui-layout cs-ss" id="totalDiv">
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
            </ol>
            <!-- 面包屑导航栏 结束-->
            <div class="cs-search-box cs-fr">
                <form action="">
                    <div class="clearfix cs-fr" id="addSoftware">
                    </div>
                </form>
            </div>
        </div>
    </div>

    <div data-options="region:'west',split:true" style="width:200px; padding:0;">
        <div class="stock_info">
            <!-- <p>软件预览</p> -->
            <ul id="type">
                <c:forEach items="${appTypes}" var="appType">
                    <li name="type" data-type="${appType}" onclick="btnSelectedType(this)">
                        <div class="title"><a href="javascript:">${appType}</a></div>
                        <div class="arrow"><i class="icon iconfont icon-you"></i></div>
                    </li>
                </c:forEach>
            </ul>
        </div>
    </div>

    <%--右边的主体内容--%>
    <div data-options="region:'center'" id="div1" style="padding:0; border:0;" style="padding:0 10px;">
        <iframe id="iframePage" width="100%" height="100%" align="left">
        </iframe>

    </div>
</div>
<!--====================主体内容结束,以下是模态框=====================-->

<%@include file="/WEB-INF/view/common/modalBox.jsp" %>
<script>
    var AppType;
    var deletePermission = 0;
    var editPermission = 0;
    $(function () {
        $("#type li:first-child").addClass("active");//第一次进来就默认选中第一个
        var appType = $("#type li:first-child").data("type");
        //但是如果是从模态框那边过来,就另当别论
        if ("${appType}") {
            appType = "${appType}";
            $.each($("li[name='type']"), function (index, item) {
                if ($(item).data("type") == appType) {
                    $(item).addClass("active");
                } else {
                    $(item).attr("class", "");
                }
            });
        }
        AppType = appType;
        //$("#appType option[value='" + appType + "']").attr("selected", "selected");
        //遍历操作权限 增:1314-1 编:1314-2 删:1314-3
        for (var i = 0; i < childBtnMenu.length; i++) {
            if (childBtnMenu[i].operationCode == "1314-1") {//新增
                var html = '<a class="cs-menu-btn" onclick="btnAdd()" data-toggle="modal"><i class="icon iconfont icon-zengjia"></i>新增</a>';
                $("#addSoftware").html(html);
            } else if (childBtnMenu[i].operationCode == "1314-2") {
                editPermission = 1;
            } else if (childBtnMenu[i].operationCode == "1314-3") {
                deletePermission = 1;
            }
        }
        $("#appType option[value='" + appType + "']").attr("selected", "selected");
        $("#iframePage").attr("src", "${webRoot}/systemManager/index?appType=" + appType + "&editPermission=" + editPermission + "&deletePermission=" + deletePermission);
    });

    function btnSelectedType(obj) {//点击事件,当点击该li就先把所有的li样式去除,该li添加样式
        $.each($("li[name='type']"), function (index, item) {
            $(item).attr("class", "");
        });
        $(obj).addClass("active");
        var appType = $(obj).data("type");
        AppType = appType;
        //$("#appType option[value='" + appType + "']").attr("selected", "selected");
        $("#iframePage").attr("src", "${webRoot}/systemManager/index?appType=" + appType + "&editPermission=" + editPermission + "&deletePermission=" + deletePermission);
    }

    //新增打开模态框
    function btnAdd() {
        $("#appType option[value='" + AppType + "']").attr("selected", "selected");
        //调用一个方法实现模态框全屏
        showMbIframe("${webRoot}/systemManager/addModal.do?appType=" + AppType);
    }
    function btnAdd2(url) {
        //调用一个方法实现模态框全屏
        showMbIframe(url);
    }


    //====================================保存的表单验证=========================
    $(function () {
        $("#TSSMGForm").Validform({
            tiptype: 2, beforeSubmit: function () {
                var formData = new FormData($('#TSSMGForm')[0]);//拿到该表单对象
                formData.append("description", $("#editor").html());
                alert($("#editor").html());
                $.ajax({
                    type: "POST",
                    url: "${webRoot}/systemManager/saveOrUpdate.do",
                    data: formData,
                    contentType: false, //必须false才会避开jQuery对 formdata 的默认处理 XMLHttpRequest会对 formdata 进行正确的处理
                    processData: false, //必须false才会自动加上正确的Content-Type
                    dataType: "json",
                    success: function (data) {
                        if (data && data.success) {
                            $("#myModal-mid4").modal('hide');
                            //window.location.reload();
                            $("#iframePage").attr("src", "${webRoot}/systemManager/index?appType=" + AppType + "&editPermission=" + editPermission + "&deletePermission=" + deletePermission);
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

        //当隐藏模态框时调用该方法,先清空模态框
        $("#myModal-mid4").on('hidden.bs.modal', function () {
            $("#myModalLabel").html("新增");
            var form = $("#TSSMGForm");// 清空表单数据
            form.form("reset");
            $("input[name=id]").val("");
            $("textarea[name=introduce]").text("");
            $("textarea[name=description]").text("");
            $("#editor").html(' <textarea rows="3" cols="3" style="display: none;" name="description"></textarea>');
            $("#yn").hide();
            clearForm(form);
            $("#appType option").attr("selected", false);
        });
    });
</script>

<script type="text/javascript">
    //控制更新内容的伸展
    $(document).ready(function () {
        var show = 1;
        $('.cs-articale-show').click(function (event) {
            if (show == 1) {
                $(this).siblings('.cs-article-contian').addClass('cs-page-show')
                show = 0;
            }
            else {
                $(this).siblings('.cs-article-contian').removeClass('cs-page-show')

                show = 1;
            }
        });

    });

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


    //清空文本框内容
    function clearForm(form) {
        // input清空
        $(':input', form).each(function () {
            var type = this.type;
            var tag = this.tagName.toLowerCase();
            if (type == 'text' || type == 'password' || tag == 'textarea')
                this.value = "";
            // 多选checkboxes清空
            // select 下拉框清空
            else if (tag == 'select')
                this.selectedIndex = -1;
        });
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
