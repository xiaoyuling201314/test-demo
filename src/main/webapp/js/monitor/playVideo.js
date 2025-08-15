//检测室摄像头播放
var player;
var vedioRootPath = rootPath + "/plug-in/imouPlayer/static/";//轻应用插件static路径，imouplayer.js中引入statis中的js文件时使用
//add by xiaoyl 2022/03/29 在乐橙播放器初始化完成后获取视频播放窗口初始化宽度和高度
var videoWidth;
var videoHeight;
//根据用户点击的检测点查看实时视频监控 add by xiaoyl 2020-04-23
$(document).on('click', '.playVedio', function (e) {
    $('#playVedioBypoint').addClass("cs-hide");
    $('#playVedioBypoint').html("");
    $('#playercontainerDingZhi').html("");

    //定位检测点为中心点
    var cm = marker_arr[$(this).parent().index()];	//marker
    var mp = cm.getPosition();	//point
    map.centerAndZoom(mp, 18);	//设置地图中心点
    $(this).parent().addClass("selceted-point");
    $(this).parent().siblings("li").removeClass("selceted-point");

    $("#videoModal").show();
    $("#videoModal").addClass("cs-modal-box-vedio");
    var pointId = $(this).attr("data-id");
    // 添加DOM容器
    if (player) {
        player.destroy();
    }
    var urlArr = [];
    var urlStr = "";
    var kitTokenStr = "";
    $.ajax({
        url:  rootPath + '/video/surveillance/selectDeviceForImouPlayer?pointId=' + pointId,
        async: false,
        success: function (data) {
            var accoumtMap = data.attributes;
            let flag1 = false;
            let multiScreen = 0;
            if (data.obj.length > 0) {
                var liveBroadArray = new Array();
                for (var i = 0; i < data.obj.length; i++) {
                    if (data.obj[i].accountPhone != "" && data.obj[i].videoType == 0) {
                        //直播地址示例为: imou://open.lechange.com/deviceId/channelId/type?streamId=1  deviceId:设备序列号,channelId:设备通道号,type:播放类型： 1 直播（实时预览）； 2 云存储录像回放；streamId:清晰度： 0 高清 ；1 标清；
                        //多个URL用%隔开，多个kitToken用%隔开
                        for (let j = 0; j < data.obj[i].param1; j++) {
                            multiScreen++;
                            urlStr += "imou://open.lechange.com/" + data.obj[i].dev + "/" + j + "/1?streamId=0%";
                            getKitToken(data.obj[i].accountPhone, data.obj[i].dev, j);
                            kitTokenStr += kitToken + "%";
                        }
                        if (!flag1) {
                            flag1 = data.obj[i].autostart == 1 ? true : false
                        }

                        //海康威视直播定制
                    } else if (data.obj[i].videoUrl != "" && data.obj[i].videoType == 5) {
                        var urls = data.obj[i].videoUrl.split(",");
                        $.each(urls, function (index, item) {

                            let ifr = document.createElement("iframe");
                            ifr.src = item;
                            document.getElementById("playercontainerDingZhi").appendChild(ifr);

                        });

                    } else if (data.obj[i].videoType != 6) {
                        liveBroadArray.push(data.obj[i]);
                    }
                }
                if (urlStr != "") {
                    $('#playVedioBypoint').removeClass("cs-hide");
                    player = new ImouPlayer('#playVedioBypoint');
                    console.log("urlStr:" + urlStr);
                    console.log("kitTokenStr:" + kitTokenStr);
                    var width = $('#playVedioBypoint').clientWidth;
                    var height = parseInt(width * 9 / 16);
                    urlStr = urlStr.substr(0, urlStr.lastIndexOf("%"));
                    kitTokenStr = kitTokenStr.substr(0, kitTokenStr.lastIndexOf("%"));
                    const urlArr = [];
                    urlStr.split('%').forEach(function (item, index) {
                        const obj = {
                            url: item,
                            kitToken: kitTokenStr.split('%')[index]
                        };
                        urlArr.push(obj)
                    });
                    player.setup({
                        src: urlArr, // 播放地址
                        width: width, // 播放器宽度
                        height: height, // 播放器高度
                        poster:  rootPath + '/img/video_bg_new.png', // 封面图url  ${webRoot}/img/video_bg_new.png
                        autoplay: flag1, // 是否自动播放
                        controls: true, // 是否展示控制栏
                    });
                    // 设置多屏
                    setTimeout(function () {
                        if (multiScreen == 1) {

                        } else if (multiScreen == 2) {
                            player.setMultiScreen(2);
                        } else if (multiScreen <= 4) {
                            player.setMultiScreen(4);
                        } else if (multiScreen <= 9) {
                            player.setMultiScreen(9);
                        }
                        //add by xiaoyl 2022/03/29 在乐橙播放器初始化完成后获取视频播放窗口初始化宽度和高度
                        videoWidth = $('#videoModal').width();
                        videoHeight = parseInt(videoWidth * 9 / 16);
                    }, 1000);

                } else {
                    if (liveBroadArray.length > 0) {
                        var wids = 0;
                        var heis = 0;
                        if (liveBroadArray.length >= 2) {
                            wids = '48%';
                            heis = 300;
                            $('.styleDiv').css("text-align", "left")
                        } else if (liveBroadArray.length < 2) {
                            wids = 474;
                            heis = 278.5;
                            $('.styleDiv').css("text-align", "center")
                        }
                        for (let j = 0; j < liveBroadArray.length; j++) {
                            $("#playVedioBypoint").append("<div class='video-player-box' id='_player_" + liveBroadArray[j].id + "'></div>");
                            let flag = liveBroadArray[j].autostart == 1 ? true : false;
                            cyberplayer("_player_" + liveBroadArray[j].id).setup({
                                width: wids, // 宽度，也可以支持百分比（不过父元素宽度要有）
                                height: heis, // 高度，也可以支持百分比
                                title: liveBroadArray[j].surveillanceName, // 标题
                                isLive: true, // 必须设置，表明是直播视频
                                file: liveBroadArray[j].videoUrl, // //您的视频源的地址（目前是乐橙示例播放地址）
                                image:  rootPath + "/${systemVideoBg}", // 预览图
                                autostart: flag, // 是否自动播放
                                stretching: "uniform", // 拉伸设置
                                repeat: false, // 是否重复播放
                                volume: 100, // 音量
                                controls: true, // 是否显示控制栏
                                hls: {
                                    reconnecttime: 5 // hls直播重连间隔秒数
                                },
                                ak: "39f82ac87fc3462ea4dcc78734450f57" // 百度智能云平台注册（https://cloud.baidu.com）即可获得accessKey
                            });
                        }
                    }
                }
            }
        }
    });
    e.stopPropagation();
});

function closeVedio() {
    $("#videoModal").hide();
    $("#videoModal").removeClass("cs-modal-box-vedio");
    player.destroy();
}
//乐橙云轻应用直播插件获取kitToken
var kitToken = "";
function getKitToken(accountPhone, dev, channelId) {
    $.ajax({
        url:  rootPath + "/video/surveillance/getKitToken.do",
        type: "POST",
        data: {
            "accountPhone": accountPhone,
            "dev": dev,
            "channelId": channelId,
        },
        dataType: "json",
        async: false,
        success: function (data) {
            kitToken = data.obj;
        },
        error: function (data) {
            $("#waringMsg>span").html("操作失败" + data.msg);
            $("#confirm-warnning").modal('toggle');
        }
    })
}
//设置摄像头在地图上的位置，适配笔记本和大屏显示器
function reWindow() {
    var winW = $(window).width();
    var winH = $(window).height();
    $('#allmap').width(winW - 350);
    $('#allmap').css('height', winH - 40);
    if (winW <= 1366) {//设置最小播放窗口
        $('#videoModal').width("392px");
        $('#videoModal').css('height', "258.5px");
    } else if (winW >= 1920) {//设置超出1920分辨率时播放器窗口大小设置为固定值
        $('#videoModal').width("669.5px");
        $('#videoModal').css('height', "399px");
    } else {
        //add by xiaoyl 2022/03/29设置视频播放窗口大小，有初始宽度时表示缩放窗口，将初始宽高赋值为播放窗口
        if (videoWidth != undefined) {
            $('#videoModal').width(videoWidth);
            $('#videoModal').css('height', videoHeight);
        } else {
            $('#videoModal').width((winW - 400) / 2);
            $('#videoModal').css('height', (winH - 40) / 2);
        }
    }
}