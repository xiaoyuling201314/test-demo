<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<style type="text/css">
    .cs-tittle-btn {
        margin-left: 4px;
    }

    .cs-title-hs input {
        height: auto;
        margin-right: 5px;
    }

    .qrcodes {
        height: 94%;
        width: 750px;
        margin: 0 auto;
        overflow: auto;
    }

    @media print {
        .print-page {
            height: auto;
            width: 100%;
        }
    }

    #modal-box-iframe {
        width: 100%;
        height: 100%;
        position: absolute;
        right: 0;
        left: 0;
        top: 0px;
        bottom: 0;
        border: 0;
        border: none;
    }

    .cs-search-box {
        position: absolute;
        right: 0px;
        top: 0px;
        z-index: 1;
    }
</style>
<div id="qrcodeModal" class="cs-modal-box" style="padding:0; display: none">
    <div class="cs-code-bb">
        <span>二维码尺寸：</span>
        <ul class="cs-code-box">
            <li class="cs-current" data-size="small">小</li>
            <li data-size="medium">中</li>
            <li data-size="large">大</li>
        </ul>
        <span class="cs-title-hs"><i class="pull-left">标题&nbsp; </i><input type="checkbox"></span>
        <div class="pull-right">
            <button type="button" class="btn btn-success" onclick="preview();">打印</button>
            <button type="button" class="btn btn-success" onclick="exportcode();"><%--<i class="icon iconfont icon-daoru"></i>--%>导出</button>
            <button type="button" class="btn btn-default" onclick="returnBack();">返回</button>
        </div>
        <div class="cs-title-ib cs-hide">
            <input id="qrcodeTitle" type="text" placeholder="请输入二维码标题"/>
            <button type="button" class="btn btn-success cs-tittle-btn">确定</button>
        </div>
    </div>
    <!--startprint-->
    <div class="qrcodes cs-2dcode-box print-page clearfix"></div>
    <!--endprint-->
</div>
<script type="text/javascript" src="${webRoot}/js/qrcode/qrcode.js"></script>
<script type="text/javascript">
    var codeArr = [];
    var codeState = 1;
    //查看送检单位二维码相关代码
    $(document).on("click", ".qrcode", function () {
//         debugger;
        var id = $(this).data("value");
        var name = $(this).data("name");
        var name = $("tr[data-rowid=" + id + "]").find(".my_name").text();
        viewQrcode([{'id': id, 'name': name}]);
    });
    //修改二维码标题
    $(document).on('click', '.cs-tittle-btn', function () {
        $("#qrcodeModal .qrcodes .cs-anshan-title").text($('#qrcodeTitle').val());
    });

    $('.cs-title-hs input').click(function () {
        if ($(this).prop('checked')) {
            $('.cs-title-ib').show();
        } else {
            $('.cs-title-ib').hide();
        }
    });
    function returnBack() {
        $("#qrcodeModal").attr('style', 'display:none');
    }
    //切换查看二维码大小
    $(document).on('click', '.cs-code-box li', function () {
        $(this).addClass('cs-current').siblings().removeClass('cs-current');
        switch ($(this).data("size")) {
            case "small":
                codeState = 1;
                viewQrcode('', 1);
                $(".cs-anshan-title").css('font-size', '20px');
                $("#qrcodeModal .qrcodes .cs-anshan-title").text($('#qrcodeTitle').val());//设置名字大小赋值
                break;
            case "medium":
                codeState = 2;
                viewQrcode('', 2);
                $(".cs-anshan-title").css('font-size', '24px');
                $("#qrcodeModal .qrcodes .cs-anshan-title").text($('#qrcodeTitle').val());//设置名字大小赋值
                break;
            case "large":
                codeState = 3;
                viewQrcode('', 3);
                $(".cs-anshan-title").css('font-size', '28px');
                $("#qrcodeModal .qrcodes .cs-anshan-title").text($('#qrcodeTitle').val());//设置名字大小赋值
                break;

        }
    });
    /**查看二维码
     *@param arr 存储要展示的二维码信息 结构：[{id:1,name:食堂1},{id:2,name:食堂2}]
     *@param state 1：小 2：中 3：大
     */
    function viewQrcode(arr, state) {
        if (!state) {
            state = codeState;
        }
        if (arr) codeArr = arr;
        var imageSize = 100;
        var fontSize = 14;
        var marginSize = 40;
        if (state == 2) {
            imageSize = 150;
            fontSize = 18;
            marginSize = 50;
        } else if (state == 3) {
            imageSize = 250;
            fontSize = 22;
            marginSize = 60;
        }
        $("#qrcodeModal .qrcodes").html("");
        //二维码定位
        for (var i = 0; i < codeArr.length; i++) {
            var reqId =codeArr[i].id;
            $("#qrcodeModal .qrcodes").append('<div class="cs-2dcode" id="qrcode' + reqId + '"><div class=\"cs-anshan-title\"  style=\"font-size:20px;\"></div></div>');
            var qrcode = new QRCode(document.getElementById("qrcode" + reqId), {
                text: codeUrl+reqId,
                width: imageSize,
                height: imageSize,
                colorDark: "#000000",
                colorLight: "#ffffff",
                correctLevel: QRCode.CorrectLevel.H
            });
            $("#qrcode" + reqId).append('<p class="code_name" style="font-size:' + fontSize + 'px;">' + codeArr[i].name + '</p>');
            $("#qrcode" + reqId).find("img").attr("style", "margin:" + marginSize + "px")
        }
        $("#qrcodeModal").attr('style', 'display:bolck');
    }
    //打印
    function preview() {
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
        //window.location.reload();
    }
    //导出
    function exportcode() {
        var codeJsonArr = [];
        for (var i = 0; i < codeArr.length; i++) {
            var src = $("#qrcode" + codeArr[i].id).find("img").prop("src");
            if (src) {
                codeJsonArr.push({'src': src, 'name': codeArr[i].name});
            }
        }
        $.ajax({
            url: "${webRoot}/inspection/unit/export_code.do",
            method: 'post',
            data: {"codeJsonArr": JSON.stringify(codeJsonArr), 'codeState': codeState,'functionName':functionName},
            success: function (data) {
                if (data && data.success) {
                    console.log("${webRoot}/resources/" + data.obj);
                    window.location.href = "${webRoot}/resources/" + data.obj;
                } else {
                    alert("导出失败");
                }
            }
        });
    }
</script>