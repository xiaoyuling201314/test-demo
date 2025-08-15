<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
    String resourcesUrl = basePath + "/resources";
%>
<c:set var="webRoot" value="<%=basePath%>"/>
<c:set var="resourcesUrl" value="<%=resourcesUrl%>"/>
<meta charset="UTF-8">
<html>
<head>
    <title>${systemName}</title>
    <meta charset="utf-8">
    <meta name="viewport" content="initial-scale=1, maximum-scale=1, user-scalable=no">
    <meta name="format-detection" content="telephone=no">
    <link rel="stylesheet" href="${webRoot}/plug-in/swiperTab/css/swiper-3.2.7.min.css"/>
    <link rel="stylesheet" type="text/css" href="${webRoot}/css/iconfont/iconfont.css"/>
    <link rel="stylesheet" type="text/css" href="${webRoot}/css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="${webRoot}/plug-in/weui/lib/weui.min.css">
    <link rel="stylesheet" type="text/css" href="${webRoot}/plug-in/weui/css/jquery-weui.css">
    <link rel="stylesheet" type="text/css" href="${webRoot}/css/app/index2.css">

    <style>
        .swiper1 {
            width: 100%;
        }



        .swiper1 .swiper-slide {
            text-align: center;
            font-size: 14px;
            height: 42px;
            line-height: 42px;
        }
    </style>
</head>
<body>
<div class="all-content content-padding">
    <h2 class="system-title text-center">
        食品安全检测数据公示
    </h2>
    <div class="company-all-info zz-tp is-flex">
        <div class="company-img">
            <c:choose>
                <c:when test="${!empty regPhoto}">
                    <img src="${resourcesUrl}${regPhoto}" alt="">
                </c:when>
                <c:otherwise>
                    <img src="${webRoot}/img/app/lost-img-01.png" alt="">
                </c:otherwise>
            </c:choose>
        </div>
        <div class="company-all">
            <div class="company-name2">
                <b>${regName}</b>
            </div>
            <div class="address">
                <p class="text-indent">
                    <span>商铺：<i class="text-diy"><b>${busCode}</b></i></span>
                </p>
                <p class="text-indent">
                    <span>名称：<i class="text-diy">${busName}</i></span>
                </p>
                <div class="address">
                    <p class="text-indent"><i class="icon iconfont icon-dingwei"></i><span><i
                            class="text-diy">${regAddress}</i></span></p>
                </div>
            </div>
        </div>
    </div>
    <div class="checked-data clearfix is-flex">
        <div class="swiper-container swiper1">
            <div class="swiper-wrapper swiper-tab" style="justify-content: center;text-align: center;">
                <div class="swiper-slide" onclick="jcl(1);">总检测量</div>
                <div class="swiper-slide selected" onclick="jcl(2);">月检测量</div>
                <div class="swiper-slide" onclick="jcl(3);">日检测量</div>
            </div>
        </div>
        <div class="top-statis is-flex">
            <div class="statis-list is-flex text-center">
                <div class="statis-parts">
                    <div>
                        <p>检测数量</p>
                        <b><span id="jclPc">0</span>批次</b>
                    </div>
                </div>
                <div class="statis-parts">
                    <div>
                        <p>不合格</p>
                        <b><span id="jclBhg">0</span>批次</b>
                    </div>
                </div>
                <div class="statis-parts">
                    <div>
                        <p>合格率</p>
                        <b><span id="jclHgl">0.00</span>%</b>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <%--检测数据 开始--%>
    <%--时间选项--%>
    <div class="new-list">
        <div class="stock-name is-flex">
            <div class="is-flex">
                <i class="iconfont icon-ceshi" style="font-weight: normal;"></i>食品检测数据
            </div>
            <div class="search-form is-flex">
                <input type="text" id="search2" class="ui-search-time" placeholder="输入食品|项目" autocomplete="off">
                <button class="btn btn-default" onclick="queryCheckData();">搜索</button>
            </div>
        </div>
        <div class="ui-dtpicker  is-flex">
            <div class="ui-data ui-data-btn is-flex"><i class="icon iconfont icon-daka"></i>
                <div id="over-btn" class="ui-data-btn"><span class="ui-select-name">近1月</span><i
                        class="icon iconfont icon-xia1"></i></div>
                <ul class="ui-data-ul cs-hide" id="over-btn2">
                    <li class="ui-data-select">近1月</li>
                    <li class="ui-data-select">近3月</li>
                    <li class="ui-data-select customTime">自定义</li>
                </ul>
            </div>
            <div class="search-form toggle-time is-flex cs-hide">
                <input type="text" id="startTime" class="ui-search-time" placeholder="请输入开始日期" autocomplete="off">
                <span class="text-muted">&nbsp;-&nbsp;</span>
                <input type="text" id="endTime" class="ui-search-time" placeholder="请输入结束日期" autocomplete="off">
            </div>
        </div>

        <%--数据--%>
        <div class="invoice-list new-invoice-list clearfix" id="checkData"></div>
    </div>

    <%--数据模板1--%>
    <div style="display: none" id="mb1">
        <div class="invoice-li invoice-control">
            <a class="is-flex" href="javascrpit:;">
                <div class="zz-food dis-t">
                    <div class="invoice-top">
                        <span class="piao-detail" href="javascript:;">食品：<b class="_food_name"></b></span>
                        <span class="pull-right text-muted _check_date"></span>
                    </div>
                    <div class=" text-left invoice-info">
                        <p>项目：<span class="_item_name"></span> <span class="pull-right text-primary">合格</span></p>
                    </div>
                </div>
            </a>
        </div>
    </div>
    <%--数据模板2--%>
    <div style="display: none" id="mb2">
        <div class="invoice-li invoice-control">
            <a class="is-flex" href="javascrpit:;">
                <div class="zz-food dis-t">
                    <div class="invoice-top">
                        <span class="piao-detail" href="javascript:;">食品：<b class="_food_name"></b></span>
                        <span class="pull-right text-muted _check_date"></span>
                    </div>
                    <div class=" text-left invoice-info">
                        <p>项目：<span class="_item_name"></span> <span class="pull-right text-danger">不合格</span></p>
                    </div>
                </div>
            </a>
        </div>
    </div>
    <%--数据模板3--%>
    <div style="display: none;width:100%;" id="mb3">
        <div class="weui-loadmore" style="width:100%;text-align:center;margin:15px auto 20px;">
            <span class="weui-loadmore__tips" onclick="pin();">加载更多</span>
        </div>
    </div>
    <%--检测数据 结束--%>

    <div class="company-footer">${copyright}</div>
</div>
</body>

<script type="text/javascript" src="${webRoot}/plug-in/echarts/echarts.min.js"></script>
<script type="text/javascript" src="${webRoot}/plug-in/echarts/shine.js"></script>
<script type="text/javascript" src="${webRoot}/plug-in/swiperTab/js/swiper-3.4.0.jquery.min.js"></script>

<script type="text/javascript" src="${webRoot}/plug-in/weui/lib/jquery-2.1.4.js"></script>
<script type="text/javascript" src="${webRoot}/plug-in/weui/js/jquery-weui.js"></script>
<script type="text/javascript" src="${webRoot}/plug-in/weui/lib/fastclick.js"></script>
<script type="text/javascript" src="${webRoot}/plug-in/weui/js/swiper.js"></script>

<script type="text/javascript" src="${webRoot}/js/dateUtil.js"></script>

<script type="text/javascript">
    $(function () {

        function setCurrentSlide(ele, index) {
            $(".swiper1 .swiper-slide").removeClass("selected");
            ele.addClass("selected");
            //swiper1.initialSlide=index;
        }

        var swiper1 = new Swiper('.swiper1', {
            //					设置slider容器能够同时显示的slides数量(carousel模式)。
            //					可以设置为number或者 'auto'则自动根据slides的宽度来设定数量。
            //					loop模式下如果设置为'auto'还需要设置另外一个参数loopedSlides。
            slidesPerView: 3.8,
            paginationClickable: true, //此参数设置为true时，点击分页器的指示点分页器会控制Swiper切换。
            spaceBetween: 5, //slide之间的距离（单位px）。
            freeMode: true, //默认为false，普通模式：slide滑动时只滑动一格，并自动贴合wrapper，设置为true则变为free模式，slide会根据惯性滑动且不会贴合。
            loop: false, //是否可循环
            onTab: function (swiper) {
                var n = swiper1.clickedIndex;
            }
        });
        swiper1.slides.each(function (index, val) {
            var ele = $(this);
            ele.on("click", function () {
                setCurrentSlide(ele, index);
                //mySwiper.initialSlide=index;
            });
        });

        $(document).click(function (e) {
            if ($(e.target).hasClass('ui-data-btn') || $(e.target).hasClass('ui-select-name') || $(e.target).hasClass('icon-daka')|| $(e.target).hasClass('icon-xia1')) {
                $("#over-btn2").show();
            } else {
                $("#over-btn2").hide();
            }
        });

        $(document).on('click', '.ui-data-ul li', function (event) {
            var val0 = $('.ui-select-name').text();

            $(this).addClass('ui-data-on').siblings().removeClass('ui-data-on');
            $('.ui-select-name').html(($(this).html()));

            //自定义时间
            if ($(this).hasClass('customTime')) {
                //查询数据
                queryCheckData();
                $('.toggle-time').show();
            } else {
                $('.toggle-time').hide();
            }
            //查询数据
            if (val0 != $(this).html() && !$(this).hasClass('customTime')) {
                queryCheckData();
            }
        });

        //放大市场图片
        var regPhoto = '${regPhoto}';
        var pb;
        if (regPhoto){
            pb = $.photoBrowser({
                items: [
                    '${resourcesUrl}'+'${regPhoto}'
                ]
            });
        }
        $('.company-img').on('click', function() {
            if (pb) {
                pb.open();
            }
        });

        //初始化时间控件
        startTimePicker();
        endTimePicker();

        //查询数据
        queryCheckData();

        //月检测量
        jcl(2);

    });


    /*************************** 检测量统计 开始 ***************************/
        //总检测量, 月检测量, 日检测量
    var zjcl, yjcl, rjcl;

    //查询检测量 t: 1_总检测量, 2_月检测量, 3_日检测量
    function jcl(t) {
        if (t == 1) {
            if (!zjcl) {
                $.ajax({
                    url: "${webRoot}/iRegulatory/regObjectApp3Statistic",
                    type: "post",
                    data: {
                        "id": '${regId}',
                        "busId": '${busId}'
                    },
                    success: function (data) {
                        if (data) {
                            zjcl = [data.jcl, data.bhg, (data.jcl - data.bhg > 0 ? ((data.jcl - data.bhg) / data.jcl * 100).toFixed(2) : '0.00')];
                            sxjcl(zjcl);
                        }
                    }
                });
            } else {
                sxjcl(zjcl);
            }

        } else if (t == 2) {
            if (!yjcl) {
                $.ajax({
                    url: "${webRoot}/iRegulatory/regObjectApp3Statistic",
                    type: "post",
                    data: {
                        "id": '${regId}',
                        "busId": '${busId}',
                        "start": newDate().format("yyyy-MM-01 00:00:00"),
                        "end": newDate().format("yyyy-MM-dd 23:59:59")
                    },
                    success: function (data) {
                        if (data) {
                            yjcl = [data.jcl, data.bhg, (data.jcl - data.bhg > 0 ? ((data.jcl - data.bhg) / data.jcl * 100).toFixed(2) : '0.00')];
                            sxjcl(yjcl);
                        }
                    }
                });
            } else {
                sxjcl(yjcl);
            }

        } else if (t == 3) {
            if (!rjcl) {
                $.ajax({
                    url: "${webRoot}/iRegulatory/regObjectApp3Statistic",
                    type: "post",
                    data: {
                        "id": '${regId}',
                        "busId": '${busId}',
                        "start": newDate().format("yyyy-MM-dd 00:00:00"),
                        "end": newDate().format("yyyy-MM-dd 23:59:59")
                    },
                    success: function (data) {
                        if (data) {
                            rjcl = [data.jcl, data.bhg, (data.jcl - data.bhg > 0 ? ((data.jcl - data.bhg) / data.jcl * 100).toFixed(2) : '0.00')];
                            sxjcl(rjcl);
                        }
                    }
                });
            } else {
                sxjcl(rjcl);
            }
        }
    }

    //刷新检测量
    function sxjcl(jcl0) {
        $("#jclPc").text(jcl0[0]);
        $("#jclBhg").text(jcl0[1]);
        $("#jclHgl").text(jcl0[2]);
    }
    /*************************** 检测量统计 结束 ***************************/

    /*************************** 检测数据 开始 ***************************/
    //初始化开始时间
    function startTimePicker() {
        $("#startTime").datetimePicker({
            title: '请选择开始日期',
            times: function () {
                //不用时间，只使用日期
                return;
            },
            max: function () {
                return $("#endTime").val();
            },
            value: newDate().format("yyyy-MM-01 "),
            onChange: function (picker, values, displayValues) {
            },
            onClose: function (picker) {
                var st = newDate(picker.value[0] + "-" + picker.value[1] + "-" + picker.value[2]);
                var et = newDate($("#endTime").val());

                st = st.DateAdd("m", 3);
                //时间跨度不能大于3个月
                if (st.getTime() <= et.getTime()) {
                    $.alert("时间跨度不能大于3个月");

                } else {
                    queryCheckData();
                }
            }
        });
    }

    //初始化结束时间
    function endTimePicker() {
        $("#endTime").datetimePicker({
            title: '请选择结束日期',
            times: function () {
                //不用时间，只使用日期
                return;
            },
            min: function () {
                return $("#startTime").val();
            },
            max: function () {
                return newDate().format("yyyy-MM-dd");
            },
            value: newDate().format("yyyy-MM-dd "),
            onChange: function (picker, values, displayValues) {
            },
            onClose: function (picker) {
                var st = newDate($("#startTime").val());
                var et = newDate(picker.value[0] + "-" + picker.value[1] + "-" + picker.value[2]);

                st = st.DateAdd("m", 3);
                //时间跨度不能大于3个月
                if (st.getTime() <= et.getTime()) {
                    $.alert("时间跨度不能大于3个月");

                } else {
                    queryCheckData();
                }
            }
        });
    }

    var queryStart = "";
    var queryEnd = "";
    var keyword = "";
    //查询数据
    function queryCheckData() {
        switch ($(".ui-select-name").text()) {
            case "自定义":
                //条件不变，不做查询
                if (queryStart == $("#startTime").val() && queryEnd == $("#endTime").val() && keyword == $("#search2").val()) {
                    return;
                } else {
                    queryStart = $("#startTime").val();
                    queryEnd = $("#endTime").val();
                    keyword = $("#search2").val();
                }
                break;

            case "近3月":
                var queryStart0 = newDate().DateAdd("m", -3).DateAdd("d", 1).format("yyyy-MM-dd");
                var queryEnd0 = newDate().format("yyyy-MM-dd");

                //条件不变，不做查询
                if (queryStart == queryStart0 && queryEnd == queryEnd0 && keyword == $("#search2").val()) {
                    return;
                } else {
                    queryStart = queryStart0;
                    queryEnd = queryEnd0;
                    keyword = $("#search2").val();
                }
                break;

            //近1月
            default:
                var queryStart0 = newDate().DateAdd("m", -1).DateAdd("d", 1).format("yyyy-MM-dd");
                var queryEnd0 = newDate().format("yyyy-MM-dd");

                //条件不变，不做查询
                if (queryStart == queryStart0 && queryEnd == queryEnd0 && keyword == $("#search2").val()) {
                    return;
                } else {
                    queryStart = queryStart0;
                    queryEnd = queryEnd0;
                    keyword = $("#search2").val();
                }
                break;
        }
        $.ajax({
            url: "${webRoot}/iRegulatory/regObjectApp2CheckDataJson",
            type: "post",
            data: {
                "id": '${regId}',
                "busId": '${busId}',
                "start": queryStart,
                "end": queryEnd,
                "keyword": keyword
            },
            success: function (data) {
                if (data && data.checkData && data.checkData.length>0) {
                    pin(data.checkData);
                } else {
                    $("#checkData").html('<div class="no-data"><img src="${webRoot}/img/app/none.png" alt=""></div>');
                    //计算底部版权高度
                    footPos();
                }
            }
        });
    }

    var checkDatas = [];
    //加载数据
    function pin(cd) {
        if (cd) {
            checkDatas = cd;
            $("#checkData").html("");
        }

        var yjz = $("#checkData ._food_name").length;

        $("#checkData .weui-loadmore").remove();

        for (var i = 0; (i + yjz) < checkDatas.length && i < 10; i++) {
            var mb;
            if ("合格" == checkDatas[i + yjz].conclusion) {
                mb = $("#mb1").clone();
            } else if ("不合格" == checkDatas[i + yjz].conclusion) {
                mb = $("#mb2").clone();
            }
            mb.find("._food_name").text(checkDatas[i + yjz].food_name);
            mb.find("._item_name").text(checkDatas[i + yjz].item_name);
            mb.find("._check_date").text(checkDatas[i + yjz].check_date);

            $("#checkData").append(mb.html());
        }

        if ((10 + yjz) < checkDatas.length) {
            $("#checkData").append($("#mb3").clone().html());
        }
        //计算底部版权高度
        footPos();
    }
    /*************************** 检测数据 结束 ***************************/
    function footPos(){
        //获取元素高度
        let topH = $('.system-title').outerHeight(true)
        let comH = $('.company-all-info').outerHeight(true)
        let footerH = $('.company-footer').outerHeight(true)
        let windowH = $(window).height()
        let listH = $('.invoice-list').outerHeight(true)
        let footH = windowH - topH - comH - listH;
        console.log(footH)
        if(footH<74){
            $('.company-footer').css('position','static')
        }else{
            $('.company-footer').css('position','fixed')
        }
    }
</script>
</html>
