var rootPath;
var idsStr;//刪除数据列表
$(function () {
    // 点击取消按钮
    $('#btnReturn').on('click', function (event) {
        event.preventDefault();
        history.back();
    });
    $('.returnBtn').on('click', function (event) {
        self.location = rootPath + "list.do";
    });
});
//回车事件触发函数 add by xiaoyuling 2017-08-07
//function keyDownSearch(e) {
//	alert(code);
//	// 兼容FF和IE和Opera
//	var theEvent = e || window.event;
//	var code = theEvent.keyCode || theEvent.which || theEvent.charCode;
//	if (code == 13) {// 如果回车就执行查询事件
//		datagridUtil.query();
//		return false;
//	}
//	return true;
//}
function deleteData() {
    $.ajax({
        type: "POST",
        url: rootPath + "/delete.do",
        data: JSON.parse(idsStr),
        dataType: "json",
        success: function (data) {
            $("#confirm-delete").modal('toggle');
            if (data && data.success) {
                //删除成功后刷新列表
                if (typeof dgu!="undefined") {
                    dgu.queryByFocus();

                } else if (typeof dgu1!="undefined") {
                    dgu1.queryByFocus();

                } else {
                    datagridUtil.queryByFocus();
                }
            } else {
                $("#waringMsg>span").html(data.msg);
                $("#confirm-warnning").modal('toggle');
            }
        },
        error: function (data) {
            $("#confirm-warnning").modal('toggle');
        }
    });
}

//删除方法2 针对id为int类型的删除（调用参考：送检单位界面）
function deleteData2() {
    if (idsStr.length > 0) {
        $.ajax({
            type: "POST",
            url: rootPath + "/delete.do",
            traditional: true,
            data: {'ids': idsStr},
            dataType: "json",
            success: function (data) {
                $("#confirm-delete2").modal('toggle');
                if (data && data.success) {
                    //删除成功后刷新列表
                    if (typeof dgu!="undefined") {
                        dgu.queryByFocus();

                    } else if (typeof dgu1!="undefined") {
                        dgu1.queryByFocus();

                    } else {
                        datagridUtil.queryByFocus();
                    }
                } else {
                    $("#waringMsg>span").html(data.msg);
                    $("#confirm-warnning").modal('toggle');
                }
            },
            error: function (data) {
                $("#confirm-warnning").modal('toggle');
            }
        });
    } else {
        $("#confirm-delete2").modal('toggle');
        $("#waringMsg>span").html("请选择要删除的行");
        $("#confirm-warnning").modal('toggle');
    }
}


//键盘弹起事件onkeyup="clearNoNum(this)";
function clearNoNum(obj) {
    //先把非数字的都替换掉，除了数字和.
    obj.value = obj.value.replace(/[^\d.]/g, "");
    //必须保证第一个为数字而不是.
    obj.value = obj.value.replace(/^\./g, "");
    //保证只有出现一个.而没有多个.
    obj.value = obj.value.replace(/\.{2,}/g, ".");
    //保证.只出现一次，而不能出现两次以上
    obj.value = obj.value.replace(".", "$#$").replace(/\./g, "")
        .replace("$#$", ".");
}

//键盘弹起事件onkeyup="clearNoNum(this)"; 该方法不可输入小数点和负号
function clearNoNum2(obj) {
    //先把非数字的都替换掉，除了数字和.
    obj.value = obj.value.replace(/[^\d.]/g, "");
    //必须保证第一个为数字而不是.
    obj.value = obj.value.replace(/^\./g, "");
    //保证只有出现一个.而没有多个.
    obj.value = obj.value.replace(/\.{2,}/g, "");
    //保证.只出现一次，而不能出现两次以上
    obj.value = obj.value.replace(".", "");
}

//时间格式化
Date.prototype.Format = function (fmt) {
    var o = {
        "M+": this.getMonth() + 1, //月份
        "d+": this.getDate(), //日
        "h+": this.getHours(), //小时
        "m+": this.getMinutes(), //分
        "s+": this.getSeconds(), //秒
        "q+": Math.floor((this.getMonth() + 3) / 3),
        "S": this.getMilliseconds() //毫秒
    };
    if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
    for (var k in o)
        if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
    return fmt;
};
/**
 * 兼容IE的时间格式化方法
 * @param val
 * @param fmt
 */
function formatDate(val, fmt) {
    var arrays = new Array();
    var arrays2 = new Array();
    var arrays3 = new Array();
    arrays = val.split(" ");
    arrays2 = arrays[0].split("-");
    arrays3 = arrays[1].split(":");
    return new Date(arrays2[0], arrays2[1] - 1, arrays2[2], arrays3[0], arrays3[1], arrays3[2]).Format(fmt);
}

/**
 * 小数四舍五入方法（位数不足的自动补0）
 * @param value 传递的数值
 * @returns {number}
 */
function returnFloat(value) {
    var value = Math.round(parseFloat(value) * 100) / 100;
    var xsd = value.toString().split(".");
    if (xsd.length == 1) {
        value = value.toString() + ".00";
        return value;
    }
    if (xsd.length > 1) {
        if (xsd[1].length < 2) {
            value = value.toString() + "0";
        }
        return value;
    }
}

//进货数量失去焦点事件
//键盘弹起事件onkeyup="clearNoNum(this)";
function clearNoNum3(obj) {
    //先把非数字的都替换掉，除了数字和.
    obj.value = obj.value.replace(/[^\d.]/g, "");
    //必须保证第一个为数字而不是.
    obj.value = obj.value.replace(/^\./g, "");
    //保证只有出现一个.而没有多个.
    obj.value = obj.value.replace(/\.{2,}/g, ".");
    //保证.只出现一次，而不能出现两次以上
    obj.value = obj.value.replace(".", "$#$").replace(/\./g, "")
        .replace("$#$", ".");
    obj.value = obj.value <= 0 ? "" : obj.value;
}

/**
 * 创建头部导航栏
 * @param barArr
 * @param idStr
 * @param rootPath
 * @remark url用来完成菜单导航栏的跳转
 */
function initBar(barArr, idStr, rootPath) {
    idStr = idStr || "tab_bar";
    rootPath = rootPath || getRootPath();
    var tabBarId = document.getElementById(idStr);
    var html = '<ol class="cs-breadcrumb">';
    if (barArr && barArr.length) {
        var length = barArr.length;
        for (var i = 0; i < length; i++) {
            var name = barArr[i].name;
            var url= barArr[i].url;
            var click = barArr[i].click;
            var isEnd = (i + 1) === length;//是否循环结束
            html += '<li class="cs-fl ' + (isEnd ? 'cs-b-active' : '') + '">';//给最后一个加上高亮
            html += i === 0 ? '<img src="' + rootPath + '/img/set.png"/>' : '<i class="cs-sorrow">&gt;</i>';
            html += isEnd ? name : '<a ' + (url ? 'href="' + url + '"' : '') + '>' + name + '</a>';//如果是最后一个就不拼接a标签
            html += '</li>';
        }
    }
    html += '</ol>';
    tabBarId.innerHTML = html;
}
//获取项目路径
function getRootPath() {
    var curPageUrl = window.document.location.href;
    return curPageUrl.split("//")[0] + "//" + curPageUrl.split("//")[1].split("/")[0]
        + "/" + curPageUrl.split("//")[1].split("/")[1];
}
function getQueryString(name) {
    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
    var r = window.location.search.substr(1).match(reg);
    if (r != null) return unescape(r[2]); return null;
}