<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html lang="en">
<head>
    <!--文件上传样式-->
    <link rel="stylesheet" type="text/css" href="${webRoot}/plug-in/uploader/css/uploader.css" />
    <!--文件上传js-->
    <script src="${webRoot}/plug-in/uploader/js/uploader.js"></script>
    <style>
        .cs-ul-form li {
            /* line-height: 36px; */
        }
        .cs-code-box li{
            width: 56px;
        }
        .check-style input {
            /* margin-top: 12px; */
        }

        .input-group-addon {
            padding: 6px 6px;
            padding-left: 10px;
        }

        .input-group-addon {
            position: relative;
        }

        .ui-data-ul {
            position: absolute;
            top: 28px;
            left: 0px;
            width: 60px;
        }

        .icon-xia1 {
            font-size: 14px;
        }

        .cs-ul-form3 {
            margin-top: 0px;
        }

        .cs-ul-form3 li {
            line-height: 28px;
            padding: 0;
        }

        div.cs-add-new {
            width: 460px;
            margin: 0 auto;
            /* background: #eff7f4; */
            padding-top: 5px;

        }

        div.cs-add-new3 {
            padding-top: 14px;
            border-bottom: 0;
            height: 100%;
        }

        .file-input-new .fileinput-remove-button {
            display: inline-block;
        }

        .code-style .cs-ul-form {
            height: 44px;
        }

        .is-flex {
            display: flex;
        }

        .left-insert {
            border-right: 1px solid #eee;
            flex: 1;
        }


        .right-insert {
            padding: 5px 20px;
        }
        .check-show-btn{
            padding:9px;
        }
        #upload .img-upload {
            height: 62px;
            width: 62px;
            background-size: 60%;
            color: #000;
            padding: 0px 15px;
        }
        #upload .img{
            height: 54px;
            width: 54px;
        }
        .qrcode .cs-ul-form3 .upload-files {
            border: 0;
            width: 62px;
        }
        .upload-files .upload-img{
            width: 60px;
            height: 60px;
            display: flex;
            justify-content: center;
            align-items: center;
            overflow: hidden;
            flex-direction: column;
            border: 1px solid #ddd;
            border-radius: 3px;
            box-sizing: border-box;
        }
        .new-img .active{
            border: 2px solid #478ad5;
        }

        .qrcode .up-label{
            position: static;
        }
        .myfile-list li i{
            width: 18px;
            height: 18px;
            line-height: 18px;
        }
        .upload-files{
            border: 1px solid #ddd;
            border-radius: 3px;
            box-sizing: border-box;
        }
        #upload .upload-files{
            border: 0;
            display: none;
        }

        .new-img .upload-files{
            padding: 3px;
        }

        .upload-form{
            padding:0;
        }
        .upload-files img{
            max-width: 60px;
        }
        .text-kb{
            color: #666;
            line-height: 14px;
        }
    </style>
</head>

<body>
<div class="modal fade intro2" id="qrcodeStyle" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog cs-lg-width" role="document">
        <div class="modal-content ">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">二维码参数</h4>
            </div>
            <div class="modal-body cs-lg-height qrcode" style="height: 420px;">
                <!-- 主题内容 -->
                <div class="cs-tabcontent">
                    <div class="is-flex" style="height: 335px;">
                        <div class="left-insert" style="width: 380px;">
                            <div class="card-title text-center" style="font-size: 16px;">
                                二维码参数
                            </div>
                            <div width="100%" class="cs-add-new cs-add-new3 code-style">
                                <ul class="cs-ul-form cs-ul-form3 clearfix">
                                    <li class="cs-name col-md-2 col-sx-2">规格：</li>
                                    <li class="cs-in-style col-md-9 col-xs-9">
                                        <ul class="cs-code-box" id="qrcodeSize">
                                            <li class="cs-current" data-size="100" data-font-size="14px">小</li>
                                            <li data-size="150" data-font-size="16px">中</li>
                                            <li data-size="200" data-font-size="20px">大</li>
                                        </ul>
                                    </li>
                                </ul>
                                <ul class="cs-ul-form cs-ul-form3 clearfix">
                                    <li class="cs-name col-md-2 col-sx-2">添加文字：</li>
                                    <li class="cs-in-style col-md-9 col-xs-9">
                                        <input id="qrcodeTitle2" type="text" style="width: 280px" placeholder="请输入添加文字" autocomplete="off">
                                    </li>
                                </ul>
                                <ul class="cs-ul-form cs-ul-form3 clearfix">
                                    <li class="cs-name col-md-2 col-sx-2">LOGO：</li>
                                    <li class="cs-in-style col-md-9 col-xs-9">
                                        <div class="myfile-list clearfix" id="logoImg" style="padding-bottom: 10px;"></div>
                                        <div class="clearfix">
                                            <div class="new-img pull-left clearfix" >
                                                <ul class="myfile-list pull-left clearfix" id="logos">

                                                </ul>
                                            </div>
                                            <div class="pull-left" style="padding-top: 0px;" id="upload">上传图片</div>
                                        </div>
                                    </li>
                                </ul>
                            </div>
                        </div>

                        <div class="right-insert text-center" style="width: 340px;">
                            <div class="qualified-card">
                                <div class="card-title text-center" style="font-size: 16px;">
                                    二维码预览
                                </div>
                                <div class="card-content">
                                    <p id="title2" style="margin: 10px 0"></p>
                                    <div id="qrcodeCanvas"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-success" onclick="setQrcodeStyle()">确定</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
            </div>
        </div>
    </div>
</div>

<div id="selLogoTemplement1" style="display: none">
    <li class="upload-files">
        <div class="upload-img">
            <img src="${webRoot}/img/qrcode-logo.png" width="" height="">
        </div>
        <div>
            <p class="text-center text-kb"></p>
        </div>
    </li>
</div>
<div id="selLogoTemplement2" style="display: none">
    <li class="upload-files">
        <div class="upload-img">
            <i class="del-img icon iconfont icon-close shanchu del_image2"></i>
            <img src="" width="" height="">
        </div>
        <div>
            <p class="text-center text-kb"></p>
        </div>
    </li>
</div>

<!-- 上传 -->
<script src="${webRoot}/js/sortable.js" type="text/javascript"></script>
<script src="${webRoot}/js/fileinput.js" type="text/javascript"></script>
<script src="${webRoot}/js/zh.js" type="text/javascript"></script>
<script src="${webRoot}/js/theme.js" type="text/javascript"></script>

<!-- 二维码 -->
<script type="text/javascript" src="${webRoot}/plug-in/qrcode2/qrcode.js"></script>

<script>
    //二维码地址
    let qrcodeUrl = "qrcodeUrl";
    //添加文字
    let title = "";
    //文字尺寸
    let fontSize = "";
    //二维码尺寸
    let size = "";
    //使用logo序号
    let logoNo = "";

    $("#qrcodeStyle").on("show.bs.modal", function () {
        //文件上传初始化
        let upload = uploader({
            id: "upload", //容器渲染的ID 必填
            accept: '.png,.jpg,.jpeg,.bmp,.gif,.tiff,.pcx,.ico', //可上传的文件类型
            isImage: true, //图片文件上传
            maxCount: 1, //允许的最大上传数量
            maxSize: 0.02, //允许的文件大小 单位：M
            multiple: false, //是否支持多文件上传
            name: 'file', //后台接收的文件名称
            onAlert: function(msg) {
                alert(msg);
            },
            onChange: function(file) {
                let reader = new FileReader();//读取文件的对象
                reader.readAsDataURL(file[0]);//读取文件的信息
                reader.onload = function (e) {
                    var logo = new Image();
                    logo.src = e.target.result;
                    setTimeout(function(){
                        let selLogoTemplement = $("#selLogoTemplement2").clone();
                        selLogoTemplement.find("img").attr("src", e.target.result);
                        selLogoTemplement.find(".text-center").text(logo.width+"*"+logo.height);
                        $("#logos").append(selLogoTemplement.html());
                        if ($("#logos li").length == 4) {
                            $("#upload").hide();
                        }

                        //刷新预览二维码
                        myQrcode();
                    }, 200);
                }
            }
        });

        $("#kv-explorer").fileinput({
            'theme': 'explorer',
            'uploadUrl': '#',
            textEncoding: 'UTF-8',
            language: 'zh',
            overwriteInitial: true,
            initialPreviewAsData: true,
            dropZoneEnabled: false,
            showClose: true,
            maxFileCount: 10,
            browseLabel: '浏览',
        });
    });

    $("#qrcodeStyle").on("hidden.bs.modal", function () {
        $("#qrcodeTitle2").val("");
        $("#qrcodeSize li:eq(0)").trigger("click");
        $("#logoImg").html("");
    });

    //参数事件
    $(document).on("click", "#qrcodeSize li", function(){
        myQrcode();
    });
    $(document).on("blur", "#qrcodeTitle2", function(){
        myQrcode();
    });
    $(document).on("click", "#logos .upload-img", function(){
        $(this).parent().siblings("li").find('.upload-img').removeClass("active");
        $(this).addClass("active");

        $("#logoImg").html("");
        let logoImg = $("#selLogoTemplement2").clone();
        logoImg.find("img").attr("src", $(this).find("img").attr("src"));
        $("#logoImg").append(logoImg.html());

        //刷新预览二维码
        myQrcode();
    });
    $(document).on("click", ".del_image2", function(event){
        event.stopPropagation();
        //删除使用logo
        if ($(this).parents("#logoImg").length>0) {
            $(".active").removeClass("active");
        }
        //删除已选择logo
        if ($(this).parents(".upload-img").hasClass("active")) {
            $("#logoImg").html("");
        }
        //删除库中logo
        $(this).parents(".upload-files").remove();

        //刷新预览二维码
        myQrcode();

        if ($("#logos li").length < 4) {
            $("#upload").show();
        }
    });


    //打开页面
    function showQrcodeStyle() {
        $("#qrcodeStyle").modal("show");
        $.ajax({
            url: "${webRoot}/ledger/regulatoryObject/getRegQrcodeStyle",
            type: "POST",
            dataType: "json",
            success: function (data) {
                if (data && data.obj) {
                    let regQrcodeStyle = data.obj.regQrcodeStyle;
                    //二维码地址
                    qrcodeUrl = data.obj.regQrcodeUrl;
                    //添加文字
                    title = regQrcodeStyle.title ? regQrcodeStyle.title : "";
                    //文字尺寸
                    fontSize = regQrcodeStyle.fontSize ? regQrcodeStyle.fontSize : "14px";
                    //二维码尺寸
                    size = regQrcodeStyle.size ? regQrcodeStyle.size : "100";

                    $("#logos").html("");

                    //写入LOGO

                    //第一个LOGO
                    let selLogoTemplement = $("#selLogoTemplement1").clone();
                    $("#logos").append(selLogoTemplement.html());
                    var logo0 = new Image();
                    logo0.src = selLogoTemplement.find("img").attr("src");
                    logo0.onload = function() {
                        var canvas = document.createElement("canvas");
                        canvas.width = logo0.width;
                        canvas.height = logo0.height;
                        var ctx = canvas.getContext("2d");
                        ctx.drawImage(logo0, 0, 0, logo0.width, logo0.height);

                        $("#logos img:eq(0)").attr("src", canvas.toDataURL());
                        $("#logos .text-center:eq(0)").text(logo0.width+"*"+logo0.height);
                    }

                    //其他LOGO
                    if(regQrcodeStyle.logos && regQrcodeStyle.logos.length > 1) {
                        for (let i=1; i< regQrcodeStyle.logos.length; i++) {
                            let selLogoTemplement = $("#selLogoTemplement2").clone();
                            selLogoTemplement.find("img").attr("src",regQrcodeStyle.logos[i]);
                            $("#logos").append(selLogoTemplement.html());

                            var logo1 = new Image();
                            logo1.src = regQrcodeStyle.logos[i];
                            $("#logos .text-center:eq("+i+")").text(logo1.width+"*"+logo1.height);
                        }
                    }

                    if (regQrcodeStyle.logoNo) {
                        $("#logos li:eq("+regQrcodeStyle.logoNo+") img").trigger("click");
                    }


                    $("#qrcodeTitle2").val(title);
                    switch (regQrcodeStyle.size) {
                        case "200":
                            $("#qrcodeSize li:eq(2)").trigger("click");
                            break;
                        case "150":
                            $("#qrcodeSize li:eq(1)").trigger("click");
                            break;
                        default:
                            $("#qrcodeSize li:eq(0)").trigger("click");
                            break;
                    }

                    if ($("#logos li").length == 4) {
                        $("#upload").hide();
                    }
                }
            }
        });
    }

    //预览
    function myQrcode() {
        setTimeout(function(){
            title = $("#qrcodeTitle2").val();
            fontSize = $("#qrcodeSize .cs-current").attr("data-font-size");
            if (title) {
                $("#title2").css("font-size", fontSize);
                $("#title2").text(title);
            } else {
                $("#title2").text("");
            }

            size = $("#qrcodeSize .cs-current").attr("data-size") ? $("#qrcodeSize .cs-current").attr("data-size") : "120";
            let logoData = "";
            if ($("#logoImg img").length > 0) {
                logoData = $("#logoImg img").attr("src");
            }
            $("#qrcodeCanvas").html("");
            $("#qrcodeCanvas").qrcode({
                render : "canvas",
                text : qrcodeUrl,
                width : size,
                height : size,
                background : "#ffffff",
                foreground : "#000000",
                src: logoData
            });
        }, 100);
    }

    function getBase64Image(img) {
        let canvas = document.createElement("canvas");
        canvas.width = img.width;
        canvas.height = img.height;
        let ctx = canvas.getContext("2d");
        ctx.drawImage(img, 0, 0, img.width, img.height);
        let dataURL = canvas.toDataURL("image/png");
        return dataURL;
    }

    //提交
    function setQrcodeStyle() {
        let logos = [];
        logoNo = "";
        $("#logos .upload-img").each(function(i, e){
            if (i==0) {
                logos.push(e.children[0].currentSrc);
            } else {
                logos.push(e.children[1].currentSrc);
            }
            if (e.classList.contains("active")) {
                logoNo = i;
            }
        });
        setTimeout(function(){
            $.ajax({
                url: "${webRoot}/ledger/regulatoryObject/setRegQrcodeStyle",
                type: "POST",
                data: {"title": title, "fontSize": fontSize, "size": size, "logoNo": logoNo, "logos": JSON.stringify(logos)},
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.success) {
                        $("#qrcodeStyle").modal("hide");
                    } else {
                        alert("操作失败");
                    }
                },
                error: function () {
                    alert("操作失败");
                }
            });
        }, 200);
    }
</script>

</body>
</html>