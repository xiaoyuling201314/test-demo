<div id="message" style="position: absolute; top: 50px; left: 0; right: 0;padding: 10px;display: none">
    <div class="alert alert-danger">no message</div>
</div>
<script type="text/javascript">
    /**
     * 提示框
     * @param message 提示内容
     * @param type: success、info、warning、danger
     * TODO 可优化，后续考虑
     */
    function showMsg(message) {
        var msgDefault = {
            message: "",
            type: "danger",
            time: 2000
        };
        var $message = $("#message");
        if (typeof message == "string") {
            msgDefault.message = message;
        }else{
            msgDefault.message=message.message;
        }
        if(message.type!=undefined){
            msgDefault.type=message.type;
        }
        $message.find("div").text(msgDefault.message).attr("class", "alert alert-" + msgDefault.type);
        $message.show();
        //关闭提示框
        setTimeout(function () {
            $message.hide();
        }, msgDefault.time);
    }
</script>
