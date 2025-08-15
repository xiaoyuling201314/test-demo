<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html lang="en">
<head>
    <style>
        .qrcodes{
            padding: 20px 0;
        }
    </style>

</head>
<body>

<div id="qrcodeModal" class="cs-modal-box cs-hide" style="padding:0;">
    <div class="cs-code-bb">
        <div class="pull-right">
            <button type="button" class="btn btn-success cs-hide daoChu" onclick="daoChu();">导出</button>
            <button type="button" class="btn btn-success" onclick="preview();">打印</button>
            <button type="button" class="btn btn-default" onclick="(function(){$('#qrcodeModal').hide();})();">返回</button>
        </div>
    </div>
    <!--startprint-->
    <div class="qrcodes cs-lg-height cs-2dcode-box print-page clearfix"></div>
    <!--endprint-->
</div>

<div id="regQrcodeTemplement" style="display: none;">
    <div class="card-content code-content">
        <p class="text1" style="margin: 10px 0;"></p>
        <p class="text2" style="margin: 5px 0"></p>
        <div class="qrcodeCanvas"></div>
        <p class="text3" style="margin: 5px 0"></p>
    </div>
</div>

<!-- 二维码 -->
<script type="text/javascript" src="${webRoot}/plug-in/qrcode2/qrcode.js"></script>
<script>

//显示导出按钮
function showDaoChu(){
    $("#qrcodeModal .daoChu").show();
}

//查看的监管对象、经营户
var vRegIds, vBusRegId, vBusIds;
//导出
function daoChu(){
    //导出监管对象
    if (vRegIds) {
        location.href = '${webRoot}/regulatory/regulatoryObject/exportQrcode?regIds='+vRegIds;

    //导出经营户
    } else if (vBusIds) {
        location.href = '${webRoot}/regulatory/business/exportQrcode.do?regId='+vBusRegId+"&busIds="+vBusIds;
    }
}

//查看监管对象二维码
function viewRegQrcode(ids, regs) {
    $("#qrcodeModal .qrcodes").html("");
    vRegIds = ids;
    vBusIds = "";

    $.ajax({
        url: "${webRoot}/ledger/regulatoryObject/getRegQrcodeStyle",
        type: "POST",
        dataType: "json",
        success: function (data) {
            if (data && data.obj) {
                var regQrcodeUrl = data.obj.regQrcodeUrl;
                var regQrcodeStyle = data.obj.regQrcodeStyle;
                //添加文字
                var title = regQrcodeStyle.title ? regQrcodeStyle.title : "";
                //文字尺寸
                var fontSize = regQrcodeStyle.fontSize ? regQrcodeStyle.fontSize : "14px";
                //二维码尺寸
                var size = regQrcodeStyle.size ? regQrcodeStyle.size : "120";
                //logo
                var logoData = "";
                if (regQrcodeStyle.logoNo && regQrcodeStyle.logos) {
                    logoData = regQrcodeStyle.logos[regQrcodeStyle.logoNo];
                }

                $.each(regs, function(i, e){
                    var regQrcodeTemplement = $("#regQrcodeTemplement").clone();
                    regQrcodeTemplement.find(".code-content").attr("id", e.id);
                    regQrcodeTemplement.find(".text1").css("font-size", fontSize).text(title);
                    regQrcodeTemplement.find(".text2").css("font-size", fontSize).text(e.regName);
                    $("#qrcodeModal .qrcodes").append(regQrcodeTemplement.html());
                    $("#"+e.id +" .qrcodeCanvas").qrcode({
                        render : "canvas",
                        text : regQrcodeUrl+e.id,
                        width : size,
                        height : size,
                        background : "#ffffff",
                        foreground : "#000000",
                        src: logoData
                    });
                });
            }
        }
    });
    $('#qrcodeModal').show();
    $('html').css('overflow', 'hidden');
}

//查看经营户二维码
function viewBusQrcode(regName, ids, buss) {
    $("#qrcodeModal .qrcodes").html("");
    vRegIds = "";
    vBusIds = ids;
    vBusRegId = buss[0].regId;

    $.ajax({
        url: "${webRoot}/ledger/regulatoryObject/getRegQrcodeStyle",
        type: "POST",
        dataType: "json",
        success: function (data) {
            if (data && data.obj) {
                var busQrcodeUrl = data.obj.busQrcodeUrl;
                var regQrcodeStyle = data.obj.regQrcodeStyle;
                //添加文字
                var title = regQrcodeStyle.title ? regQrcodeStyle.title : "";
                //文字尺寸
                var fontSize = regQrcodeStyle.fontSize ? regQrcodeStyle.fontSize : "14px";
                //二维码尺寸
                var size = regQrcodeStyle.size ? regQrcodeStyle.size : "120";
                //logo
                var logoData = "";
                if (regQrcodeStyle.logoNo && regQrcodeStyle.logos) {
                    logoData = regQrcodeStyle.logos[regQrcodeStyle.logoNo];
                }

                $.each(buss, function(i, e){
                    var regQrcodeTemplement = $("#regQrcodeTemplement").clone();
                    regQrcodeTemplement.find(".code-content").attr("id", e.id);
                    regQrcodeTemplement.find(".text1").css("font-size", fontSize).text(title);
                    regQrcodeTemplement.find(".text2").css("font-size", fontSize).text(regName);
                    regQrcodeTemplement.find(".text3").css("font-size", fontSize).text(e.opeShopCode);
                    $("#qrcodeModal .qrcodes").append(regQrcodeTemplement.html());
                    $("#"+e.id +" .qrcodeCanvas").qrcode({
                        render : "canvas",
                        text : busQrcodeUrl+e.id,
                        width : size,
                        height : size,
                        background : "#ffffff",
                        foreground : "#000000",
                        src: logoData
                    });
                });
            }
        }
    });
    $('#qrcodeModal').show();
    $('html').css('overflow', 'hidden');
}

//打印
function preview() {
    $(".qrcodes canvas").each(function(i, e){
        // 获取画布的父对象(div)
        var parent = e.parentElement;
        // 根据画布内容生成图片
        var image = e.toDataURL("image/png");
        // 创建一个img图片对象元素
        var img = e.nextSibling ? e.nextSibling : document.createElement("img");
        // 将画布生成的图片内容给img图片对象元素
        img.src = image;
        // 将画布宽度给img图片对象元素宽度
        img.width = e.width;
        // 将画布高度给img图片对象元素高度
        img.height = e.height;
        // 将生成的图片内容加载到画布所在父元素的内容里
        parent.appendChild(img);
    });
    $(".qrcodes canvas").hide();

    setTimeout(function(){
        if (!!window.ActiveXObject || "ActiveXObject" in window) {
            remove_ie_header_and_footer();
        }
        var bdhtml = window.document.body.innerHTML;
        var sprnstr = "<!--startprint-->";
        var eprnstr = "<!--endprint-->";
        var prnhtml = bdhtml.substring(bdhtml.indexOf(sprnstr) + 17);
        prnhtml = prnhtml.substring(0, prnhtml.indexOf(eprnstr));
        window.document.body.innerHTML = prnhtml;
        window.print();

        window.document.body.innerHTML = bdhtml;
        window.location.reload();
    }, 300);
}
</script>

</body>
</html>