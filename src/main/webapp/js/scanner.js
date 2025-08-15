/**
 * 扫描枪工具
 * @author Dz
 *
 */
scanner = (function () {
    var defaultParameters = {
        "effectiveInputTime": 50,       //有效输入时间间隔50ms
        "scanFunction": undefined       //扫描后执行方法 - 必填
    };

    return {
        /**
         * 开启
         * @param parameters
         */
        open: function(parameters){
            if (parameters && parameters.effectiveInputTime) {
                defaultParameters.effectiveInputTime = parameters.effectiveInputTime;
            }
            if (parameters.scanFunction) {
                defaultParameters.scanFunction = parameters.scanFunction;
            }

            var scanText = "";  //扫描文字
            var lastKeyPressTime;   //最后扫描时间

            $(document).on("keypress",function(event) {
                // console.log("document keypress:"+event.keyCode+";$(\":focus\").length:"+$(":focus").length);
                //输入框没选中
                if ($("input:focus").length==0 || $("input:focus").attr("readonly") == "readonly"){
                    //回车键表示内容读取结束
                    if(event.keyCode == 13){
                        // if (lastKeyPressTime){
                        //     console.log("1:::::::输入时间间隔："+(new Date().getTime() - lastKeyPressTime)+"ms:::::::输入回车键");
                        // } else {
                        //     console.log("1:::::::输入回车键");
                        // }
                        if (scanText && parameters.scanFunction && (new Date().getTime() - lastKeyPressTime <= defaultParameters.effectiveInputTime)) {
                            parameters.scanFunction(scanText);
                        }
                        scanText = "";
                        lastKeyPressTime = undefined;
                        return;
                    }

                    //第一次扫描或重新扫描
                    if (!lastKeyPressTime || (new Date().getTime() - lastKeyPressTime > defaultParameters.effectiveInputTime)){
                        // if (lastKeyPressTime){
                        //     console.log("2:::::::输入时间间隔："+(new Date().getTime() - lastKeyPressTime)+"ms:::::::输入：" + String.fromCharCode(event.keyCode));
                        // } else {
                        //     console.log("2:::::::输入：" + String.fromCharCode(event.keyCode));
                        // }
                        lastKeyPressTime = new Date().getTime();
                        scanText = String.fromCharCode(event.keyCode);

                    //接收输入文字
                    } else {
                        // console.log("3:::::::输入时间间隔："+(new Date().getTime() - lastKeyPressTime)+"ms:::::::输入："+String.fromCharCode(event.keyCode)+":::::::合并："+scanText);
                        lastKeyPressTime = new Date().getTime();
                        scanText += String.fromCharCode(event.keyCode);
                    }
                }
            });
        },
        /**
         * 关闭
         */
        close: function(){
            $(document).unbind("keypress");
        }
    }

})();