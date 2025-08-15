let userToken = "";//用户token
let serialNumber = "";//仪器唯一标识
(function () {
    //获取仪器传递过来的token并放入缓存
    let urlToken = GetQueryString("userToken");
    let urlDeviceId = GetQueryString("serialNumber");
    if (urlToken) {
        userToken = urlToken;
        serialNumber = urlDeviceId;
        sessionStorage.setItem("userToken", urlToken);
        sessionStorage.setItem("serialNumber", urlDeviceId);
    } else {
        userToken = sessionStorage.getItem("userToken");
        serialNumber = sessionStorage.getItem("serialNumber");
    }
    //处理网页的多标签页共享sessionStorage的问题（如果想要A页面能够单独访问，那么A页面需要引入该js代码）
    if (!sessionStorage.length) {
        // 这个调用能触发目标事件，从而达到共享数据的目的
        localStorage.setItem('getSessionStorage', Date.now());
    }

    // 该事件是核心
    window.addEventListener('storage', function (event) {
        if (event.key === 'getSessionStorage') {
            // 已存在的标签页会收到这个事件
            localStorage.setItem('sessionStorage', JSON.stringify(sessionStorage));
            localStorage.removeItem('sessionStorage');

        } else if (event.key === 'sessionStorage' && !sessionStorage.length) {
            // 新开启的标签页会收到这个事件
            let data = JSON.parse(event.newValue);

            for (key in data) {
                sessionStorage.setItem(key, data[key]);
            }
        }
    });
})();

/**
 * 获取请求时传递的参数值
 * @return {string}
 */
function GetQueryString(name) {
    let reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
    let r = window.location.search.substr(1).match(reg);
    if (r != null) return decodeURI(r[2]);
    return null;
}

/**
 * 提示框
 * @param message 提示内容
 * @param type: success、info、warning、danger
 * TODO 可优化，后续考虑
 */
function message(message) {
    let msgDefault = {
        message: "",
        type: "danger",
        time: 2000
    };
    let $message = $("#message");
    if (typeof message === "string") {
        msgDefault.message = message;
    } else {
        Object.assign(msgDefault, message)
    }
    $message.find("div").text(msgDefault.message).attr("class", "alert alert-" + msgDefault.type);
    $message.show();
    //关闭提示框
    setTimeout(function () {
        $message.hide();
    }, msgDefault.time);
}
