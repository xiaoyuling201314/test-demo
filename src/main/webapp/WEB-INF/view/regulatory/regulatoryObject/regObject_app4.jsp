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
    <title>食品安全检测数据公示</title><%--${systemName}--%>
    <meta charset="utf-8">
    <meta name="viewport" content="initial-scale=1, maximum-scale=1, user-scalable=no">
    <meta name="format-detection" content="telephone=no">
    <link rel="stylesheet" href="${webRoot}/plug-in/swiperTab/css/swiper-3.2.7.min.css"/>
    <link rel="stylesheet" type="text/css" href="${webRoot}/css/iconfont/iconfont.css"/>
    <link rel="stylesheet" type="text/css" href="${webRoot}/css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="${webRoot}/plug-in/weui/lib/weui.min.css">
    <link rel="stylesheet" type="text/css" href="${webRoot}/plug-in/weui/css/jquery-weui.css">
    <link rel="stylesheet" type="text/css" href="${webRoot}/css/app/index2.css">
    <link rel="stylesheet" type="text/css" href="${webRoot}/css/app/regulatory-scan4.css">
    <style>
        body{
            background: #fff;
        }
    </style>
</head>
<body>
<div class="all-content content-padding">
   <%-- <h2 class="system-title text-center">
        食品安全检测数据公示
    </h2>--%>
    <div class="company-all-info zz-tp is-flex">
        <div class="stock-name is-flex">
            <div class="is-flex">
                <i class="iconfont icon-yemian" style="font-weight: normal;"></i>
                被检单位
            </div>
        </div>
        <c:if test="${!empty regPhoto}">
            <div class="company-img" style="background: #f5f5f5;">
                <img src="${resourcesUrl}${regPhoto}" alt="">
            </div>
        </c:if>
        <div class="company-all">
            <div class="company-name2">
                <b>${regName}</b>
            </div>

            <div class="address">
                <c:if test="${! empty regAddress}">
                    <p class="text-indent"><i class="icon iconfont icon-dingwei"></i><span><i
                            class="text-diy">${regAddress}</i></span></p>
                </c:if>
                <p class="is-flex stall-num"><i class="icon iconfont icon-108"></i>
                    <span>
                        <c:choose>
                            <c:when test="${systemFlag==1}">
                                摊位：
                            </c:when>
                            <c:otherwise>
                                档口：
                            </c:otherwise>
                        </c:choose>
                        <i class="text-diy">${businessNumber}个</i>
                    </span>
                </p>
            </div>


            <div class="statis-content">
                <div class=" is-flex">
                    <div class="swiper-container swiper1">
                        <div class="swiper-wrapper swiper-tab">
                            <div class="swiper-slide" onclick="jcl(1);">总检测量</div>
                            <div class="swiper-slide selected" onclick="jcl(2);">月检测量</div>
                            <div class="swiper-slide" onclick="jcl(3);">日检测量</div>
                        </div>
                    </div>
                </div>
                <div class="checked-data clearfix is-flex">
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
            </div>
        </div>
    </div>
    <%--检测数据 开始--%>
    <%--时间选项--%>
    <div class="new-list">
        <div class="stock-name is-flex">
            <div class="is-flex">
                <i class="iconfont icon-ceshi" style="font-weight: normal;"></i>
                检测数据
            </div>
            <div class="ui-data is-flex"><i class="icon iconfont icon-daka"></i>
                <div id="over-btn" class="ui-data-btn"><span class="ui-select-name">近3天</span><i
                        class="icon iconfont icon-xia1"></i></div>
                <ul class="ui-data-ul cs-hide" id="over-btn2">
                    <li class="ui-data-select">近3天</li>
                    <li class="ui-data-select">近7天</li>
                    <li class="ui-data-select">近15天</li>
                    <li class="ui-data-select customTime">自定义</li>
                </ul>
            </div>
            <%--<div class="ui-data is-flex">
                <i class="icon iconfont icon-daka"></i>
                <div id="over-btn" class="ui-data-btn"><span class="ui-select-name">近1个月</span><i
                        class="icon iconfont icon-xia1"></i></div>
                <ul class="ui-data-ul cs-hide" id="over-btn2">
                    <li class="ui-data-select">近1个月</li>
                    <li class="ui-data-select">近3个月</li>
                    <li class="ui-data-select">近1年</li>
                    <li class="ui-data-select on customTime">自定义</li>

                </ul>
            </div>--%>

            <div class="search-form is-flex">
                <input type="text" id="search2" class="ui-search-time" placeholder="输入食品|项目" autocomplete="off">
                <button class="btn btn-default" onclick="queryCheckData();">搜索</button>
            </div>
        </div>
        <div class="ui-dtpicker toggle-time is-flex clearfix cs-hide">

            <div class="search-form toggle-time is-flex">
                <div>
                    <i class="iconfont icon-lishi"></i>
                    <input type="text" id="startTime" class="ui-search-time" placeholder="开始日期" value="">
                </div>
                <span class="text-muted">&nbsp;-&nbsp;</span>
                <div>
                    <i class="iconfont icon-lishi"></i>
                    <input type="text" id="endTime" class="ui-search-time" placeholder="结束日期" value="">
                </div>
            </div>
        </div>

        <%--数据--%>
        <div class="invoice-list new-invoice-list clearfix" id="checkData">
            <div class="no-data" style="display: flex; align-items: center;justify-content: center;flex-direction: column;">
                <img src="${webRoot}/img/app/none2.png" alt="" style="width: 65%;">
            </div>
        </div>
    </div>
    <%--数据模板1--%>
    <div style="display: none" id="mb1">
        <div class="invoice-li invoice-control">
            <div class="is-flex">
                <div class="num-box text-primary"></div>
                <div class="zz-food dis-t">
                    <div class="invoice-top">
                        <span class="piao-detail" href="javascript:;">
                            <c:choose>
                                <c:when test="${systemFlag==1}">
                                    摊位：
                                </c:when>
                                <c:otherwise>
                                    档口：
                                </c:otherwise>
                            </c:choose>
                            <b class="_reg_user_name"></b></span>
                        <span class="pull-right text-muted _shop_name"></span>
                    </div>
                    <div class=" text-left invoice-info">
                        <p>食品：<span class="_food_name"></span> <span class="pull-right text-muted _check_date"></span>
                        </p>
                    </div>
                    <div class="text-left invoice-info check-project is-flex">
                        <p>项目：<span class="_item_name"></span></p>
                        <p><span class="check_conclusion"></span></p>
                    </div>
                    <div class=" text-left invoice-info _deal_content_show cs-hide">
                        <p>处置：<span class="_deal_content"></span></p>
                    </div>
                </div>
            </div>
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
    var isHideCheckDate = true;//是否隐藏检测具体时间，true表示隐藏时间，false表示显示时间
    var shopType = 1;//显示摊位名称或者经营者,默认为：0,说明：0 摊位名称，1经营者姓名


    $(function () {
        //获取元素高度
        let topH = $('.system-title').outerHeight(true)
        let comH = $('.company-all-info').outerHeight(true)
        let footerH = $('.company-footer').outerHeight(true)
        let windowH = $(window).height()
        //控制高度>=宽度的图片样式
        let img =  $('.company-img img');
        let imgH = img.height();
        let imgW = img.width();
        if(imgH>=imgW){
            img.attr("style","height: 100%;width: auto;")
        }
        let listH = windowH - topH - comH - footerH - 60;
        $('.invoice-list').css('min-height', listH)


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
            if ($(e.target).hasClass('ui-data-btn') || $(e.target).hasClass('ui-select-name') || $(e.target).hasClass('icon-daka') || $(e.target).hasClass('icon-xia1')) {
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
        if (regPhoto) {
            pb = $.photoBrowser({
                items: [
                    '${resourcesUrl}' + '${regPhoto}'
                ]
            });
        }
        $('.company-img').on('click', function () {
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
                        "id": '${regId}'
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
                // var st = newDate(values[0] + "-" + values[1] + "-" + values[2]).DateAdd("m", 3).DateAdd("d", -1);
                // var et = newDate($("#endTime").val());
                //
                // //时间跨度不能大于3个月
                // if (st.getTime() < et.getTime()) {
                //     $("#endTime").val(st.format("yyyy-MM-dd"));
                // }
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
                // var st = newDate($("#startTime").val());
                // var et = newDate(values[0] + "-" + values[1] + "-" + values[2]);
                //
                // //开始时间大于结束时间
                // if (st.getTime() > et.getTime()) {
                //     et = et.DateAdd("m", -3).DateAdd("d", 1);
                //     $("#startTime").val(et.format("yyyy-MM-dd"));
                //
                // } else {
                //     et = et.DateAdd("m", -3).DateAdd("d", 1);
                //     //时间跨度不能大于3个月
                //     if (st.getTime() < et.getTime()) {
                //         var td = newDate();
                //         if (et.getTime() > td.getTime()) {
                //             $("#startTime").val(td.format("yyyy-MM-dd"));
                //
                //         } else {
                //             $("#startTime").val(et.format("yyyy-MM-dd"));
                //         }
                //     }
                // }
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

            case "近1月":
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

            case "近15天":
                var queryStart0 = newDate().DateAdd("d", -14).format("yyyy-MM-dd");
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

            //近7天
            case "近7天":
                var queryStart0 = newDate().DateAdd("d", -6).format("yyyy-MM-dd");
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

            //近3天
            default:
                var queryStart0 = newDate().DateAdd("d", -2).format("yyyy-MM-dd");
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
            url: "${webRoot}/iRegulatory/regObjectApp4CheckDataJson",
            type: "post",
            data: {
                "id": '${regId}',
                "start": queryStart,
                "end": queryEnd,
                "keyword": keyword
            },
            success: function (data) {
                if (data && data.checkData && data.checkData.length > 0) {
                    pin(data.checkData);
                } else {
                    $("#checkData").html('<div class="no-data"><img src="${webRoot}/img/app/none2.png" alt=""></div>');
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
            var mb = $("#mb1").clone();
            if (checkDatas[i + yjz].unqual_count == 0) {
                mb.find(".check_conclusion").addClass("text-primary").text("合格");
            } else if (checkDatas[i + yjz].unqual_count > 0) {
                mb.find(".check_conclusion").addClass("text-danger").text("不合格");
                if (checkDatas[i + yjz].handName) {
                    mb.find("._deal_content_show").show();
                    let dealContemt = checkDatas[i + yjz].handName.split(";");
                    mb.find("._deal_content").text(dealContemt[0]);
                }
            }

            mb.find(".num-box").text(i + yjz + 1);
            mb.find("._food_name").text(checkDatas[i + yjz].food_name);
            mb.find("._item_name").text(checkDatas[i + yjz].item_name);
            let checkData=new Date(checkDatas[i + yjz].check_date.replace(/-/g, '/'));
            if(isHideCheckDate){
                mb.find("._check_date").text(checkData.format("yyyy-MM-dd"));
            }else{
                mb.find("._check_date").text(checkData.format("yyyy-MM-dd HH:mm:ss"));
            }

            if(!checkDatas[i + yjz].reg_user_name){
                mb.find(".piao-detail").hide();
            }
            mb.find("._reg_user_name").text(checkDatas[i + yjz].reg_user_name);
            if(shopType==1){//显示摊位名称或者经营者,默认为：0,说明：0 摊位名称，1经营者姓名
                mb.find("._shop_name").text(checkDatas[i + yjz].ope_name);
            }else{
                mb.find("._shop_name").text(checkDatas[i + yjz].ope_shop_name);

            }

            $("#checkData").append(mb.html());
        }

        if ((10 + yjz) < checkDatas.length) {
            $("#checkData").append($("#mb3").clone().html());
        }
        //计算底部版权高度
        footPos();
    }

    /*************************** 检测数据 结束 ***************************/

</script>
</html>
