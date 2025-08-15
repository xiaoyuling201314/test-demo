//main.js start
(function ($, window, document, undefined) {
    //配置参数
    var defaults = {
        totalData: 0,      //数据总条数
        showData: 4,       //每页显示的条数
        pageCount: 10,      //总页数,默认为10
        current: 1,        //当前第几页
        prevCls: 'prev',     //上一页class
        nextCls: 'next',     //下一页class
        prevContent: '<',    //上一页内容
        nextContent: '>',    //下一页内容
        activeCls: 'active',   //当前页选中状态
        coping: true,     //首页和尾页
        homePage: '首页',      //首页节点内容
        endPage: '末页',       //尾页节点内容
        count: 3,        //当前页前后分页个数
        jump: true,       //跳转到指定页数
        jumpIptCls: 'form-control',  //文本框样式名称
        jumpBtnCls: 'go',  //跳转按钮样式名称
        jumpBtn: 'GO',     //跳转按钮文本
        callback: function () {
        } //回调
    };

    var Pagination = function (element, options) {
        //全局变量
        var opts = options,//配置
            current,//当前页
            $document = $(document),
            $obj = $(element);//容器

        /**
         * 设置总页数
         * @param int page 页码
         * @return opts.pageCount 总页数配置
         */
        this.setTotalPage = function (page) {
            return opts.pageCount = page;
        };

        /**
         * 获取总页数
         * @return int p 总页数
         */
        this.getTotalPage = function () {
            var p = opts.totalData || opts.showData ? Math.ceil(parseInt(opts.totalData) / opts.showData) : opts.pageCount;
            return p;
        };

        //获取当前页
        this.getCurrent = function () {
            return current;
        };

        /**
         * 填充数据
         * @param int index 页码
         */
        this.filling = function (index) {
            var html = '';
            var pageCount = this.getTotalPage();
//      html += '<span class="total">每页&nbsp;'+opts.showData+'&nbsp;条/共&nbsp;'+opts.totalData+'&nbsp;条记录&nbsp;-&nbsp;第&nbsp;'+index+'&nbsp;页/共&nbsp;'+pageCount+'&nbsp;页</span>';
            current = index || opts.current; //当前页码
            if (current > 1) { //上一页
                html += '<a href="javascript:;" class="' + opts.prevCls + '">' + opts.prevContent + '</a>';
            } else {
                $obj.find('.' + opts.prevCls) && $obj.find('.' + opts.prevCls).remove();
            }
            if (current >= opts.count * 2 && current != 1 && pageCount != opts.count) {
                var home = opts.coping && opts.homePage ? opts.homePage : '1';
                html += opts.coping ? '<a href="javascript:;" data-page="1">' + home + '</a><span>...</span>' : '';
            }
            var start = current - opts.count,
                end = current + opts.count;
            ((start > 1 && current < opts.count) || current == 1) && end++;
            (current > pageCount - opts.count && current >= pageCount) && start++;
            for (; start <= end; start++) {
                if (start <= pageCount && start >= 1) {
                    if (start != current) {
                        html += '<a href="javascript:;" data-page="' + start + '">' + start + '</a>';
                    } else {
                        html += '<span class="' + opts.activeCls + '">' + start + '</span>';
                    }
                }
            }
            if (current + opts.count < pageCount && current >= 1 && pageCount > opts.count) {
                var end = opts.coping && opts.endPage ? opts.endPage : pageCount;
                html += opts.coping ? '<span>...</span><a href="javascript:;" data-page="' + pageCount + '">' + end + '</a>' : '';
            }
            if (current < pageCount) {//下一页
                html += '<a href="javascript:;" class="' + opts.nextCls + '">' + opts.nextContent + '</a>'
            } else {
                $obj.find('.' + opts.nextCls) && $obj.find('.' + opts.nextCls).remove();
            }
//      html += opts.jump ? '<span class="text">跳转到：</span><input type="text" class="'+opts.jumpIptCls+'"><span>页</span><a href="javascript:;" class="'+opts.jumpBtnCls+'">'+opts.jumpBtn+'</a>' : '';
            $obj.empty().html(html);
        };

        //绑定事件
        this.eventBind = function () {
            var self = this;
            var pageCount = this.getTotalPage();//总页数
            $obj.off().on('click', 'a', function () {
                if ($(this).hasClass(opts.nextCls)) {
                    var index = parseInt($obj.find('.' + opts.activeCls).text()) + 1;
                } else if ($(this).hasClass(opts.prevCls)) {
                    var index = parseInt($obj.find('.' + opts.activeCls).text()) - 1;
                } else if ($(this).hasClass(opts.jumpBtnCls)) {
                    if ($obj.find('.' + opts.jumpIptCls).val() !== '') {
                        var index = parseInt($obj.find('.' + opts.jumpIptCls).val());
                    } else {
                        return;
                    }
                } else {
                    var index = parseInt($(this).data('page'));
                }
                self.filling(index);
                typeof opts.callback === 'function' && opts.callback(self);
            });
            //输入跳转的页码
            $obj.on('input propertychange', '.' + opts.jumpIptCls, function () {
                var $this = $(this);
                var val = $this.val();
                var reg = /[^\d]/g;
                if (reg.test(val)) {
                    $this.val(val.replace(reg, ''));
                }
                (parseInt(val) > pageCount) && $this.val(pageCount);
                if (parseInt(val) === 0) {//最小值为1
                    $this.val(1);
                }
            });
            //回车跳转指定页码
            $document.keydown(function (e) {
                var self = this;
                if (e.keyCode == 13 && $obj.find('.' + opts.jumpIptCls).val()) {
                    var index = parseInt($obj.find('.' + opts.jumpIptCls).val());
                    self.filling(index);
                    typeof opts.callback === 'function' && opts.callback(self);
                }
            });
        };

        //初始化
        this.init = function () {
            this.filling(opts.current);
            this.eventBind();
        };
        this.init();
    };

    $.fn.pagination = function (parameter, callback) {
        if (typeof parameter == 'function') {//重载
            callback = parameter;
            parameter = {};
        } else {
            parameter = parameter || {};
            callback = callback || function () {
                };
        }
        var options = $.extend({}, defaults, parameter);
        return this.each(function () {
            var pagination = new Pagination(this, options);
            callback(pagination);
        });
    };

})(jQuery, window, document);

// 设备检测模块
var ua = navigator.userAgent;
var detectModule = {
    ie8: function () {
        if (ua.indexOf("MSIE 8.0") > 0) {
            return true;
        }
    }
}

//main.js end
// 收缩展开效果
$(function () {
    queryLocation("", "");
    // 默认隐藏div
    $(".text").hide();
    $(".text2").hide();
    //$(".text1").hide();
    $(".delete").hide();
    $("#btn-search").on("click", function () {
        $(".text").show();
    });
    //显示查询数量信息
    $("#allmap").on("click", function () {
        //$(".text1").hide();
        if (!$(".text").is(":hidden")) {
            $(".text").hide();
            $(".text2").show();
        }
    });
    //鼠标悬停在查询结果列表，显示数据集列表
    $(".text2,#selectOrgOrPoint").on("mouseover", function () {
        if($(".text").is(":hidden")){
            $(".text").animate({
                height: 'toggle',
                opacity: 'toggle'
            }, "slow");
            $(".text2").hide();
        }
    });
    // 显示删除按钮
    $('#selectOrgOrPoint').on("blur", function () {
        if ($('#selectOrgOrPoint').val() != "") {
            $(".delete").show();
        }
    });
    $('#selectOrgOrPoint').on("click", function () {//focus
        if ($('#selectOrgOrPoint').val() == "") {
            //$(".text1").show();
            $(".text").hide();
            $(".text2").hide();
            $(".delete").hide();
        }
    });
    $('.delete').click(function () {
        $('#selectOrgOrPoint').val("");
        $(".text").hide();
        $(".text2").hide();
        $(".delete").hide();
    });
    // 键盘释放触发事件
    $("#selectOrgOrPoint").keyup(function (event) {
        var str = $('#selectOrgOrPoint').val().trim();
        currentPage = 1;
       // if (str != "") {
            $(".text").hide();
            //$(".text1").hide();
            $(".text2").hide();
            $(".delete").show();
            var deviceName = $("[name=deviceName]").val();
            var departId = $("[name=departId]").val();
            queryLocation(deviceName, departId);
            /*  } else {
           $(".text1").show();
            $(".text").hide();
            $(".text2").hide();
            $(".delete").hide();

        }*/
        var e = event || window.event || arguments.callee.caller.arguments[0];
        if (e && e.keyCode == 8) { // 按 Backspace
            if (str == "") {
                map.clearOverlays();
                //$(".text1").show();
                $(".text").hide();
                $(".text2").hide();
                $(".delete").hide();
            }
        }
    });
    // 组织机构代码 start

});


var pageNum = 4;//每页4条数据
var currentPage = 1;//当所在页
var dataList = [];
// 用经纬度设置地图中心点
function queryLocation(deviceName, departId) {
    // 异步ajax请求快检车的经纬度
    $.ajax({
        url: msUrl + "/detect_car_location/dataList",
        type: "POST",
        data: {
            "deviceName": deviceName,
            "departId": departId
        },
        dataType: "json",
        success: function (data) {
            if (data && data.success) {
                var obj = data.obj;
                dataList = obj;
                dealHtml(obj);
                //$(".text1").hide();// 默认隐藏div
                $(".text2").hide();
                $(".text").show();
                if (obj.length >= 4) {
                    pageTab(obj.length, deviceName, departId);
                } else {
                    pageTab(0, deviceName, departId);
                }
            } else {
                $("#waringMsg>span").html(data.msg);
                $("#confirm-warnning").modal('toggle');
            }
        },
        error: function (e) {
            $("#waringMsg>span").html("查询失败!");
            $("#confirm-warnning").modal('toggle');
        }
    })
}

function BMapOneMarker(point, msg, img) {
    var opts = {
        width: 250
    };
    var infoWindow = new BMap.InfoWindow(msg, opts);// 创建信息窗口对象
    var marker = new BMap.Marker(point, {
        icon: myIcon
    });
    map.addOverlay(marker);
    marker.addEventListener("mouseover", function () {
        map.openInfoWindow(infoWindow, point);// 打开信息窗口
    });
}
function queryById(carImei) {
    $.ajax({
        url: rootPath + "/queryById",
        type: "POST",
        data: {"carImei": carImei},
        dataType: "json",
        success: function (data) {
            if (data && data.success) {
                var obj = data.obj;
                $(".text").hide();
                $(".text2").show();
                map.clearOverlays();
                var html = "";
                var htmlStr = "";
                var resulthtmlStr = "";
                var new_point = new BMap.Point(obj.longitude, obj.latitude);
                html = "<span style='margin-bottom:0;'>设备信息</span><hr/>";
                html += "<span style='margin-top:0;'>IMEI：" + obj.carImei + "</span><br/>";
                html += "车牌号码：" + obj.licensePlate + "<br/>";
                html += "车&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;速：" + obj.speed + "KM/h<br/>";
                html += "定位时间：" + obj.uDate + "<br/>";
                html += "<a href='"+rootPath+"/replay?id=" + obj.pointId+ "' style='color:#006def;'>轨迹回放</a> ";
                BMapOneMarker(new_point, html, msUrl + "/img/car.png");
                map.panTo(new_point);
                arrayList = [];
                arrayList.push(new_point);
                $("#tableList li").removeClass("clickStyle");
                $("#" + obj.carImei + "").addClass("clickStyle");
                //点击某一辆车信息，自动打开信息窗口 start
                var opts = {
                    width: 250
                };
                var infoWindow = new BMap.InfoWindow(html, opts);// 创建信息窗口对象
                map.openInfoWindow(infoWindow, new_point);// 打开信息窗口
                //点击某一辆车信息，自动打开信息窗口 end
                map.setViewport(arrayList);
            } else {
                $("#waringMsg>span").html(data.msg);
                $("#confirm-warnning").modal('toggle');
            }
        },
        error: function () {
            $("#waringMsg>span").html("查询失败!");
            $("#confirm-warnning").modal('toggle');
        }
    })
}
//分页
function pageTab(total, deviceName, departId) {
    $('#pagination').pagination({
        totalData: total,
        callback: function (api) {
            currentPage = api.getCurrent();
            dealHtml(dataList);
        }
    });
}
function dealHtml(json) {
    //debugger;
    var total = json.length ? json.length : 0;
    $("#tableList").empty("");
    map.clearOverlays();
    var html = "";
    var new_point;
    var arrayList = [];
    var space = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
    var htmlStr = "";//"<li class='list-group-item'>车牌号码"+space+"负责人"+space+"联系方式</li>";
    var resulthtmlStr = "";
    var startNum = (currentPage - 1) * pageNum;
    var endNum = (currentPage * pageNum) > total ? total : (currentPage * pageNum);
    for (var index = startNum; index < endNum; index++) {
        var item = json[index];
        new_point = new BMap.Point(item.longitude, item.latitude);
        html = "<span style='margin-bottom:0;'>设备信息</span><hr/>";
        html += "<span style='margin-top:0;'>IMEI：" + item.carImei + "</span><br/>";
        html += "车牌号码：" + item.licensePlate + "<br/>";
        html += "车&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;速：" + item.speed + "KM/h<br/>";
        html += "定位时间：" + item.uDate + "<br/>";
        html += "<a  href='"+rootPath+"/replay?id=" + item.pointId+ "' style='color:#006def;'>轨迹回放</a> ";
        BMapOneMarker(new_point, html, msUrl + "/img/car.png");//添加标注
        //map.panTo(new_point); //自动移动，缩放地图
        arrayList.push(new_point);//<span class='badge'>"+(index+1)+"</span>  &nbsp;"+"车牌号"+item.licensePlate + "
        var deviceName = "";
        if (item.deviceName.length > 7) {
            deviceName = (item.deviceName).substring(0, 7) + '...';
        } else {
            deviceName = item.deviceName;
        }
        htmlStr += "<li class='list-group-item' id='" + item.carImei + "' onclick='queryById(\"" + item.carImei + "\");' title='" + item.deviceName + "'><span>" + deviceName + "(" + item.licensePlate + ")<span/>";
        if (item.message != "") {//<span style='float:right;margin-right:15px;color:red;'></span>
            htmlStr += "" + item.message + "";
        }
        htmlStr += "<br/>" + "负责人：" + '迎宾路综合批发市场检测员' + space + "</br> 联系方式：" + item.phone + "</li>";
    }
    map.setViewport(arrayList);
    if (total == 0) {
        htmlStr += "<li class='list-group-item'><a>暂无车辆信息</a></li>";
        $("#pagination").hide();
    }else if(total <4){
        $("#pagination").hide();
    }else{
        $("#pagination").show();
    }
    $("#tableListResult").empty();
    resulthtmlStr += "<li class='list-group-item'><a>共找到" + total + "辆车辆信息</a></li>";
    $("#tableList").append(htmlStr);
    $("#tableListResult").append(resulthtmlStr);

}