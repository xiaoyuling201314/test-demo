<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<style type="text/css">
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

    /*.cs-search-box {*/
    /*    position: absolute;*/
    /*    right: 0px;*/
    /*    top: 0px;*/
    /*    z-index: 1;*/
    /*}*/
    .cs-modal-box{
        position: fixed;
        top: 0;
        bottom: 0;
        height: 100%;
        width: 100%;
        left: 0;
    }
</style>
<!-- 大弹窗 -->
<div class="cs-modal-box cs-hide" id="contentBox">
    <iframe id="modal-box-iframe"></iframe>
</div>

<script type="text/javascript">
    let dguObj2;
    function refreshMbIframe() {
        $("#modal-box-iframe").attr("src", $("#modal-box-iframe").attr("src"));
        setTimeout(function () {
            $('body').css('overflow', 'hidden');
            $("#contentBox").show();
        }, 200);
    }

    function showMbIframe(src, d) {
        $("#modal-box-iframe").attr("src", src);
        dguObj2 = d;
        setTimeout(function () {
            $('body').css('overflow', 'hidden');
            $(".cs-modal-box").show();
        }, 200);
    }

    function closeMbIframe(state) {
        $('body').css('overflow', 'auto');
        //$("#contentBox").hide();
        $(".cs-modal-box").hide();
        //state为真，就对界面进行一次加载
        if (state && dguObj2) {
            dguObj2.queryByFocus();
        }
    }

    /** iframe的POST请求方式（可解决URL过长和中文乱码问题）
     *
     * 在主界面写一个from表单，使iframe的name属性值和from的target属性值保持一致
     * 主界面提交from表单即可完成post请求
     * @param name from的target属性值
     */
    function showMbIframePost(name) {
        $("#modal-box-iframe").attr("name", name);
        setTimeout(function () {
            $('body').css('overflow', 'hidden');
            $("#contentBox").show();
        }, 200);
    }
</script>