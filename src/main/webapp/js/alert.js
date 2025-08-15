//方法调用方式
/*   $("#add").bind("click", function () {  
 $.MsgBox.Alert("消息", "签到成功！");
 });
 //回调函数可以直接写方法function(){}
 //方式1 直接函数
 $.MsgBox.Confirm("解绑用户", "确认解绑当前用户？", function () {
 console.log("天线宝宝")
 });
 //方式2 写函数名称即可
 $.MsgBox.Alert("消息", data.msg, xxoo);
 function xxoo() {
 alert("x_x o_o")
 };
 */


(function () {
    $.MsgBox = {
        Alert: function (title, msg, callback) {
            GenerateHtml("alert", title, msg);
            btnOk(callback);
            btnNo();
        },
        Confirm: function (title, msg, callback) {
            GenerateHtml("confirm", title, msg);
            btnOk(callback);
            btnNo();
        }
    }

    var GenerateHtml = function (type, title, msg) {
        var _html = "";
        _html += '<div id="mb_box"></div><div id="mb_con"><span id="mb_tit">' + title + '</span>';
        _html += '<a id="mb_ico">x</a><div id="mb_msg">' + msg + '</div><div id="mb_btnbox">';
        if (type == "alert") {
            _html += '<input id="mb_btn_ok" type="button" value="确定" />';
        }
        if (type == "confirm") {
            _html += '<input id="mb_btn_ok" type="button" value="确定" />';
            _html += '<input id="mb_btn_no" type="button" value="取消" />';
        }
        _html += '</div></div>';

        $("body").append(_html);

        GenerateCss();
    }


    var GenerateCss = function () {
        $("#mb_box").css({
            width: '100%', height: '100%', zIndex: '99999', position: 'fixed',
            filter: 'Alpha(opacity=60)', backgroundColor: 'black', top: '0', left: '0', opacity: '0.6'
        });
        $("#mb_con").css({
            zIndex: '999999', width: '280px', position: 'fixed',
            backgroundColor: 'White', borderRadius: '6px'
        });
        $("#mb_tit").css({
            textAlign: 'center', display: 'block', fontSize: '14px', color: '#444', padding: '10px 15px',
            backgroundColor: '#edf3f0', borderRadius: '6px 6px 0 0',
            fontWeight: 'bold'
        });
        $("#mb_msg").css({
            textAlign: 'center', padding: '20px', lineHeight: '20px',
            borderBottom: '1px dashed #DDD', fontSize: '13px'
        });
        $("#mb_ico").css({
            display: 'none', position: 'absolute', right: '10px', top: '9px',
            border: '1px solid Gray', width: '18px', height: '18px', textAlign: 'center',
            lineHeight: '16px', cursor: 'pointer', borderRadius: '12px', fontFamily: ''
        });
        $("#mb_btnbox").css({margin: '15px 0 10px 0', textAlign: 'center'});
        $("#mb_btn_ok,#mb_btn_no").css({width: '85px', height: '30px', color: 'white', border: 'none'});
        /*$("#mb_btn_ok").css({ backgroundColor: '#21ba5c',borderRadius: '4px' });*/
        $("#mb_btn_no").css({backgroundColor: '#999', marginLeft: '20px', borderRadius: '4px'});

        $("#mb_ico").hover(function () {
            $(this).css({backgroundColor: 'Red', color: 'White'});
        }, function () {
            $(this).css({backgroundColor: '#DDD', color: 'black'});
        });
        var _widht = document.documentElement.clientWidth;
        var _height = document.documentElement.clientHeight;
        var boxWidth = $("#mb_con").width();
        var boxHeight = $("#mb_con").height();

        $("#mb_con").css({top: (_height - boxHeight) / 2 + "px", left: (_widht - boxWidth) / 2 + "px"});
    }

    var btnOk = function (callback) {
        $("#mb_btn_ok").click(function () {
            $("#mb_box,#mb_con").remove();
            if (typeof (callback) == 'function') {
                callback();
            }
        });
    }

    var btnNo = function () {
        $("#mb_btn_no,#mb_ico,#mb_box").click(function () {
            $("#mb_box,#mb_con").remove();
        });
    }
})();  