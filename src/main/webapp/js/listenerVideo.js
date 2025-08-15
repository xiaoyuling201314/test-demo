//判断用户是否正在浏览页面,离开页面时暂停播放器，浏览页面时自动播放
var hidden, visibilityChange;
if (typeof document.hidden !== "undefined") {
    hidden = "hidden";
    visibilityChange = "visibilitychange";
} else if (typeof document.mozHidden !== "undefined") {
    hidden = "mozHidden";
    visibilityChange = "mozvisibilitychange";
} else if (typeof document.msHidden !== "undefined") {
    hidden = "msHidden";
    visibilityChange = "msvisibilitychange";
} else if (typeof document.webkitHidden !== "undefined") {
    hidden = "webkitHidden";
    visibilityChange = "webkitvisibilitychange";
}
// 添加监听器
document.addEventListener(visibilityChange, function() {
    console.log("当前页面是否被隐藏：" + document[hidden]);
    //当前页面被隐藏，暂停播放
    if(document[hidden]){
        player.stop();
    }else{
        player.play();
    }
}, false);