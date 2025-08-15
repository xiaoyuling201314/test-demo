<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/WEB-INF/view/pretreatment_new/resource.jsp" %>
<%-- select2 搜索 --%>
<script type="text/javascript" src="${webRoot}/plug-in/select2/js/select2.js"></script>
<title>${systemName}-复检分拣</title>
<html>
<head>
    <style>
        a:hover {
            text-decoration: none;
        }

        .sj-list {
            margin: 0;
            padding: 0;
        }

        .sj-list li {
            float: left;
            line-height: 48px;
            height: 48px;
            font-size: 18px;
            width: 200px;
            /* border-left: 1px solid #008ad4; */
            margin: 0;
            padding-left: 10px;
            text-align: left;
        }

        .sj-list li.time-all-se {
            font-size: 16px;
            line-height: 26px;
            padding: 0;
            padding-top: 5px;
        }

        .cs-input-style input {
            background: #f1f1f1;
            height: 36px;
            line-height: 36px;
            border: 1px solid #ddd;
            outline: 0;
            border-radius: 0;
        }

        .cs-input-style input:focus {
            background: #eee;
        }

        .time-set {
            /* margin-top: 10px; */
        }

        .sj-list li .icon {
            font-size: 20px;
            margin-right: 5px;
            color: #008ad4;
        }

        .time-btns {
            width: 34px;
            height: 36px;
            background: rgba(0, 0, 0, 0);
            border: 1px solid #ddd;
            float: left;
            border-radius: 4px;
            color: #008ad4;
        }

        .time-btns:active {
            border: 0;
            outline: 0;
            color: #fff;
            background: #13adff;
        }

        .time-btns:focus {
            outline: 0;
        }

        .time-all-se {
            width: 200px;
            float: left;
            /* margin-top: 10px; */
        }

        .sj-box {
            margin-right: 5px;
        }

        ul {
            padding: 0;
        }

        .select-input {
            border: 1px solid #1490d8;
        }

        .info-disable {
            border: 1px solid #d81414;
            background: #efcccc;
        }

        .icon-close {
            position: absolute;
            right: 10px;
            top: 15px;
            cursor: pointer;
            display: none;
        }

        td {
            position: relative;
        }

        .search-code {
            line-height: 48px;
            text-align: left;
            height: 48px;
            border-bottom: 1px solid #ddd;
            color: #337ab7;
            cursor: pointer;
            padding-left: 10px;
            font-size: 16px;
        }

        .search-code .icon {
            margin-right: 5px;
        }

        .search-code .icon-you {
            float: right;
        }

        .search-code:hover {
            color: #4da1e8;
            background: #f1f1f1;
        }

        .search-active {
            color: #4da1e8;
            background: #f1f1f1;
        }

        .cs-all-ps {
            position: relative;
        }

        .zz-clear-btn2 {
            position: absolute;
            right: 19px;
            top: 2px;
            height: 36px;
            /* border: 1px solid #999; */
            background: #fff;
            /* border-radius: 0 4px 4px 0; */
            width: 50px;
            /* font-size: 28px; */
            /* background: rgba(255,255,255,0); */
            line-height: 20px;
            border: 0;
        }

        .cs-all-ps .cs-input-box {
            width: 300px;
        }

        .cs-input-box .cs-down-input {
            background: #fff url(/img/tab_arrow.png) no-repeat 98% center;
            padding-right: 20px;
        }

        .zz-input input, .zz-input select {
            width: 100%;
            height: 40px;
            border-radius: 4px;
            outline: none;
            outline: 0;
            font-size: 20px;
            /* font-weight: bold; */
            padding: 0 5px;
            border: 1px solid #999;
        }

        .cs-all-ps .cs-check-down {
            width: 300px;
            top: 39px;
        }

        .cs-ul-form li div {
            padding: 0;
        }

        .col-md-12 div {
            /* padding: 5px; */
        }

        .cs-check-down, .cs-check-down2 {
            /* width: 200px; */
            border: 2px solid #4887ef;
            top: 46px;
            height: 200px;
            overflow: auto;
            z-index: 9999;
            position: absolute;
            background: #fff;
            margin-top: -1px;
            border-radius: 0 0 3px 3px;
        }

        .cs-all-ps .cs-check-down li, .cs-all-ps .cs-check-down2 li {
            font-size: 16px;
            padding: 0 10px;
        }

        .cs-ul-form li.cs-name {
            text-align: right;
            line-height: 40px;
            font-size: 18px;
        }

        .cs-ul-form .cs-name {
            padding-right: 0;
        }

        .cs-ul-form .zz-input, .cs-ul-form .cs-in-style {
            padding-left: 0;
        }

        .cs-check-down li {
            float: none;
        }

        .cs-check-down li:hover {
            background: #137eec;
            color: #fff;
        }

        .zz-scan2 {
            position: absolute;
            right: 10px;
            top: 60px;
            left: 312px;
            bottom: auto;
            width: auto;
            height: 53px;
            background: #fff;
            box-shadow: 0 0 2px #ddd;
            padding-top: 48px;
        }

        ._to_submit {
            background: #fff;
            padding: 10px 10px 10px 40px;
        }

        ul._to_submit li {
            float: left;
            width: 33%;
            white-space: nowrap;
            line-height: 32px;
            height: 32px;
        }

        .zz-scan3 {
            left: 312px;
            width: auto;
            right: 10px
        }

        .input-group2 {
            width: 330px;
        }

        .show-not {
            padding: 4px;
            background: red;
            color: #fff;
        }

        .text-warning {
            color: #eca11f;
        }

        .select-time {
            padding: 5px;
            /*border-bottom: 1px solid #ddd;*/
        }

        .select-time input {
            border: 1px solid #ddd;
            padding-left: 10px;
            height: 36px;
            width: 120px;
            float: left;

        }

        .select-time i {
            margin: 8px 5px;

        }

        .zz-pagination {
            position: fixed;
            bottom: 10px;
            left: 10px;
            width: 300px;
            padding-top: 5px;
            background: #fff;
            border-top: 1px solid #ddd;
            height: 28px;
            padding-left: 10px;
            padding-top: 5px;
        }

        .zz-pagination li {
            float: left;
            margin-right: 2px;
            line-height: 30px;
            cursor: pointer;
        }

        .zz-pagination a {
            text-decoration: none;
        }

        .zz-current-btn {
            background: #0a64f7;
            color: #fff;
        }

        .zz-current-btn:hover {
            background: #0a64f7;
            color: #fff;
        }

        .zz-distan {
            margin-left: 10px;
        }

        .zz-b-nav-btn {
            display: block;
            height: 28px;
            padding: 0 12px;
            border: 1px solid #ddd;
            text-align: center;
            line-height: 28px;
            border-radius: 2px;
        }

        .cs-form-table td {
            border: 1px solid #ddd;
        }

        .icon {
            cursor: pointer;
            /*font-size: 24px;
            color: #080b46;
            margin: 0 5px;*/
        }

        input.inputData {
            font-size: 16px;
        }

        .zz-scan4 {
            position: absolute;
            left: 10px;
            right: 10px;
            top: 60px;
            width: auto;
            height: 60px;
            line-height: 60px;
            font-size: 24px;
            background: #fff;
            padding: 0px;
            text-align: center;
            border-top: 1px solid #f1f1f1;
            padding: 0px;
        }

        .input-group2 {
            background: #f1f1f1;
            height: 59px;
            line-height: 0px;
            /* padding: 0; */
            padding: 11px;
        }

        .zz-scan2 {
            top: 122px;
        }

        .modal-footer {
            height: 45px;
            text-align: center;
            padding: 5px;
        }

        .btn-success {
            color: #fff;
            background-color: #4fa3ff;
            border-color: #4fa3ff;
        }

        .cs-input-cont {
            border: 1px solid #ddd;
            height: 30px;
            width: 150px;
            line-height: 30px;
            border-radius: 2px 0 0 2px;
            margin-right: 1px;
            background: #f4fbf5;
        }

        .cs-search-btn {
            margin-left: -1px;
            border: 1px solid #ddd;
            display: inline-block;
            height: 30px;
            line-height: 30px;
            width: 50px;
            text-align: center;
            border-radius: 0 2px 2px 0;
            color: rgba(0, 0, 0, 0);
            background: #fff;
            background: #fff url(${webRoot}/img/search.png) no-repeat center center;
        }

        .cs-search-margin {
            margin-top: 4px;
        }

        .cs-mechanism-list-search {
            padding: 0px 0 4px 6px;
            /* line-height: 35px; */
        }

        th {
            background: #f1f1f1;
            color: #000;
            font-weight: normal;
            font-size: 14px;
            padding: 10px;
        }

        td {
            padding: 10px;
        }

        th, td {
            border: 1px solid #ddd;
        }

        .tex-center {
            text-align: center;
        }

        .cs-mechanism-list, .cs-points-list, .cs-secleted-list {
            height: 408px;
        }

        .cs-mechanism-table-box {
            overflow: auto;
        }

        .cs-mechanism-list-title, .cs-points-list .cs-mechanism-tab {
            height: 39px;
            line-height: 39px;
            padding: 0 10px;

        }

        .cs-mechanism-list-content {
            width: 100%;
        }

        .sj-list li.time-all-se, .select-time > div, .zz-scan4 {
            display: flex;
        }

        button#next {
            float: right;
        }
        .select2-dropdown{
            max-width: 200px;
        }
        /*样品下拉框样式*/
        .cs-add-new select, .cs-add-new2 select {
            width: 200px;
            height: 29px;
        }
        .ul-market-list {
            height: 28px;
            white-space: nowrap;
            cursor: pointer;
            line-height: 28px;
            padding-top: 6px;
            /* padding-left: 20px; */
        }
        .ul-market-list li{
            padding-left:10px;
        }
        .ul-market-list li.active{
            background: #f1f1f1;
            color: #333;
        }
        .ul-market-list li:hover{
            background: #ddd;
            color: #1dcc6a;
        }
        .cs-search-title{
            font-weight: bold;
            padding: 10px 0 5px 0px;
            border-bottom: 1px dotted #ddd;
        }
        .showDiv img{
            max-height:90%;
            max-width:90%;
        }
        .Validform_checktip{
            display:none;
        }
        .select2-container--default .select2-selection--multiple .select2-selection__rendered{
            height:36px !important;
        }
    </style>
</head>
<body style="background: #008ad4">
<form id="_sample_form">
    <div class=" cs-form-table-he cs-form-table cs-font-top clearfix">
        <div class="zz-accept-title">
            <h2 class="col-md-6" style="margin: 0px;">
                <c:if test="${! empty systemLogo}">
                    <img class="pull-left" src="${resourcesUrl}${systemLogo}" style="height:50px; margin-top: 5px;" alt=""/>
                </c:if>
                ${homeSystemName}
            </h2>
            <div class="text-center center-text" style="position: absolute;width: 200px;left: 50%;top: 12px;margin-left: -100px;">复检订单分拣</div>
        </div>

        <div class="zz-scan4">
            <div class="sj-box pull-left text-center">
                <ul class="sj-list">
                    <li class="time-all-se cs-input-style" style="width: 370px">
                        <div class="pull-left" style="padding: 5px;">订单时间：</div>
                        <div class="select-time clearfix">
                            <div class="clearfix">
                                <%--, onpicked: function(dp) {$('#_start_time').trigger('change'); }--%>
                                <input id="_start_time" type="text" placeholder="开始时间" onclick="WdatePicker({skin:'default',maxDate:'#F{$dp.$D(\'_end_time\')||\'%y-%M-%d\'}',dateFmt:'yyyy-MM-dd', onpicked: loadData})">
                                <i class="pull-left">至</i>
                                <input id="_end_time" type="text" placeholder="结束时间" onclick="WdatePicker({minDate:'#F{$dp.$D(\'_start_time\')}',maxDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',
                                 onpicked: loadData })">
                            </div>
                        </div>
                    </li>
                    <li><i class="icon iconfont icon-yiqianding"></i>应分拣 <span class="_ying_shou_number">0</span>个</li>
                    <li><i class="icon iconfont icon-yiqianding"></i>已分拣 <span class="_yi_shou_number">0</span>个</li>
                    <li><i class="icon iconfont icon-yiqianding"></i>未分拣 <span class="_wei_shou_number">0</span>个</li>
                </ul>

            </div>
            <div class="input-group input-group2 pull-right" style="background: #fff;position: absolute;right: 10px;">
                <input type="text" class="form-control" id="_default_code_input" class="pull-right" style="text-transform:uppercase;" placeholder="请输入订单号" onkeyup="this.value=this.value.trim().toUpperCase()">
                <span class="input-group-btn">
                    <button class="btn btn-primary" type="button" style="font-size: 16px;" id="_default_code_input_btn">确定</button>
                </span>
            </div>
        </div>

        <div style="position: absolute;left: 10px; top: 122px; width: 300px;bottom: 10px;background: #fff;box-shadow: 0 0 2px #ddd;overflow: auto;padding-top: 0px;padding-bottom: 40px;">
            <%--左侧订单列表--%>
            <div style="position: absolute;top:0;width: 100%;height: 0px;line-height:0px;background:#13adff;font-size: 16px;color:#fff;text-align: center;font-weight: bold;border: 2px solid #13adff;"><%--复检订单--%></div>
            <div class="zz-code-lists" id="_orders_no"></div>

            <div class="zz-bottom-nav zz-pagination">
                <ul class="zz-pagination cs-fr" id="paging">
                    <li class="cs-distan">共1页/0条记录</li>
                    <li class="cs-disabled zz-distan">
                        <a class="zz-b-nav-btn" onclick="">‹</a>
                    </li>
                    <li>
                        <a class="zz-b-nav-btn zz-current-btn" onclick="">1</a>
                    </li>
                    <li class="cs-next ">
                        <a class="zz-b-nav-btn" onclick="">›</a>
                    </li>
                </ul>
            </div>
        </div>
        <%--右侧订单明细和抽样明细--%>
        <div class="zz-scan" style="top: 206px;left: 312px; width:auto; right: 10px">

            <table id="_sample_table">
                <thead>
                <tr class="top-tr">
                    <th style="width:50px;">序号</th>
                    <th style="">送检样品</th>
                    <th style="width:200px;">检测项目</th>
                    <th style="width:180px;">样品条码</th>
                    <th style="width:100px;">打印次数</th>
                    <th style="width:170px;">分拣时间</th>
                    <th style="width:90px;">状态</th>
<%--                    <th style="width:100px;">打印样品码</th>--%>
                </tr>
                </thead>

                <tbody></tbody>
            </table>
            <div class="zz-scan3">
                <div id="_div_0" class="pull-right" style="padding: 10px;">
                    <button type="button" class="btn btn-primary sure-btn" onclick="printSampleCode();">打印全部</button>
                </div>
            </div>
        </div>

        <div class="zz-scan2" style="padding-top: 0px;">

            <div style="position: absolute;top:0;width: 100%;height: 0px;line-height:0px;background:#13adff;font-size: 16px;color:#fff;text-align: center;font-weight: bold;border: 2px solid #13adff;"><%--订单信息--%></div>
            <%--<h3>订单信息</h3>--%>
            <div class="zz-scan-content">
                <ul id="_sample_info" class="_to_submit clearfix">
                    <input type="hidden" name="tbSampling.id">
                    <li>送检单号：<span class="_orderNumber"></span></li>
                    <li>下单时间：<span class="_samplingDate"></span></li>
                    <li>送检单位：<span class="_regName"></span>
                    <li>送检人员：<span class="_samplingUsername"></span></li>
                    <li>联系电话：<span class="_param3"></span></li>
                    <li>检测费用：<span class="_inspectionFee"></span></li>
                </ul>
            </div>
        </div>
    </div>
</form>

<table style="display: none;">
    <tbody id="_sample_template">
    <tr>
        <input type="hidden" class="_sampling_detail_id">
        <input type="hidden" class="_food_id">
        <input type="hidden" class="_food_name">
        <td class="_serial_number"></td>
        <td class="_food_name"></td>
        <td class="_item_name" data-itemid=""></td>
        <td class="_sample_code"></td>
        <td class="_print_num_text"></td>
        <td class="_code_time_text"></td>
        <td class="_order_status"></td>
<%--        <td class="_print_btn"></td>--%>
        <%--
        <td class="_supplier"></td>
        <td class="_ope_shop_name"></td>
        --%>
    </tr>
    </tbody>
</table>
<%--选择检测项目--%>
<%@include file="/WEB-INF/view/pretreatment_new/collectSample/selectDetectItem2.jsp"%>
<%--  提示框  --%>
<%@include file="/WEB-INF/view/terminal/tips.jsp" %>
</body>
<script type="text/javascript" src="${webRoot}/js/printTicket.js"></script>
<script type="text/javascript" src="${webRoot}/js/scanner.js"></script>
<script type="text/javascript">
    //订单号
    var orderRegExp = new RegExp("^(${wxOrderCode})\\d{10,}$");
    //手机号
    var phoneRegExp = new RegExp("^1(3|4|5|6|7|8|9)\\d{9}$");
    /***************************** 收样统计 - 开始 *****************************/
    $(function () {
        resetTime();
        loadData();
        //监听扫描枪事件
        scanner.open({
            scanFunction: function (scanText) {
                // console.log("扫描文字："+scanText);
                //判断是不是这个项目的二维码
                if (scanText) {
                    if (scanText.indexOf("guide?orderNumber") === -1) {
                        $.toast("请扫描正确的二维码!", "text");
                        return;
                    }
                    let code = getOrderNumberByRegex(scanText);
                    if (!code) {
                        $.toast("请扫描正确的二维码!", "text");
                        return;
                    }
                    //校验条码
                    checkCode(code);
                } else {
                    $.toast("请扫描正确的二维码!", "text");
                }

            }
        });
        //当天统计每30秒刷新数据
        setInterval(function () {
            myChart();
        }, 30 * 1000);
        //每2分钟刷新待收取列表
        setInterval(function () {
            queryReCheck();
        }, 2 * 60 * 1000);
        //连接打印机
        doConnect();
    })
    //选择日期
    $(document).on("change", "#start", function () {
        myChart();
    });

    //当天统计每30秒刷新数据
    function myChart() {
        $.ajax({
            type: "POST",
            url: "${webRoot}/newCollectSample/statisticReCheck",
            data: {"startTime": $("#_start_time").val(),"endTime":$("#_end_time").val()},
            dataType: "json",
            success: function (data) {
                if (data && data.success) {
                    $("._ying_shou_number").text(data.obj.yingShou);
                    $("._yi_shou_number").text(data.obj.yiShou);
                    $("._wei_shou_number").text(data.obj.weiShou);
                }
            }
        });
    }

    //初始化 查询开始、结束时间
    function resetTime() {
        var date1 = new Date();
        var date2 = new Date(date1.getTime() - 29 * 24 * 60 * 60 * 1000);
        $("#_start_time").val(date2.format("yyyy-MM-dd"));
        $("#_end_time").val(date1.format("yyyy-MM-dd"));
    }

    //查询输入框确认按钮事件
    $(document).on("click", "#_default_code_input_btn", function (event) {
        if ($("#_default_code_input").val()) {
            //获取输入值
            var thisCode = $("#_default_code_input").val().toUpperCase();
            //校验输入值
            checkCode(thisCode);

            $("#_default_code_input").val("");
        }
    });
    //点击订单号
    $(document).on("click", "._order_no", function (event) {
        $("._order_no").removeClass("search-active");
        $(this).addClass("search-active");
        queryOrderByNo($(this).find("span").text());
    });

    //校验条码
    function checkCode(thisCode) {
        if (thisCode) {
            thisCode = thisCode.toUpperCase();
            if (phoneRegExp.test(thisCode)) {
                queryReCheck();
                //订单号
            } else if (orderRegExp.test(thisCode)) {
                queryOrderByNo(thisCode);
                $("#_orders_no").html("");
            } else {
                tips("请输入正确的订单号");
            }
        }
    }

    //根据订单号查询订单
    function queryOrderByNo(orderNo) {
        $("#_sample_table tbody tr").remove();
        $("#_sample_info ._reg_info").remove();
        $("#_edit_reg_modal1 ._query_req_units tr:gt(0)").remove();
        $("#_edit_reg_modal1 ._selected_req_units tr").remove();
        console.log("订单号:" + orderNo);
        //查询订单信息
        $.ajax({
            url: "${webRoot}/newCollectSample/queryBySamplingNo",
            type: "POST",
            data: {"orderNumber": orderNo, "queryReCheck": 1},
            dataType: "json",
            success: function (data) {
                if (data && data.success && data.obj && data.obj.order) {
                    var tbSampling = data.obj.order;
                    var samplingDetails = tbSampling.samplingDetails;
                    //订单ID
                    _samplingId = tbSampling.id;
                    var collectNum = 0;    //待收样数量
                    //订单信息
                    $("#_sample_info ._orderNumber").text(tbSampling.orderNumber);
                    $("#_sample_info ._samplingUsername").text(tbSampling.orderUsername);
                    $("#_sample_info ._samplingDate").text(tbSampling.orderTime);
                    $("#_sample_info ._inspectionFee").text("￥" + (tbSampling.orderFees) / 100);
                    $("#_sample_info ._param3").text(tbSampling.orderUserPhone);
                    $("#_sample_info input[name='tbSampling.id']").val(tbSampling.id);
                    $("#_sample_info ._regName").html(tbSampling.iuName);

                    let printNum=0;//样品码打印次数
                    for (var i = 0; i < samplingDetails.length; i++) {
                        //样品明细
                        if ($("#" + samplingDetails[i].id).length == 0) {
                            var _sample_template = $("#_sample_template").clone();
                            _sample_template.find("tr").attr("id", samplingDetails[i].id);
                            _sample_template.find("._sampling_detail_id").attr("value", samplingDetails[i].id);
                            _sample_template.find("._food_id").attr("value", samplingDetails[i].foodId);
                            _sample_template.find("._food_name").text(samplingDetails[i].foodName);
                            if(samplingDetails[i].itemId==""){
                                _sample_template.find("._item_name").html("<i class='icon iconfont icon-xiugai text-primary _edit_item'></i>");
                            }else{
                                _sample_template.find("._item_name").text(samplingDetails[i].itemName);
                                _sample_template.find("._item_name").attr("data-itemid", samplingDetails[i].itemId);
                            }
                            _sample_template.find("._sample_code").text(samplingDetails[i].sampleCode);
                            _sample_template.find("._print_num_text").text(samplingDetails[i].printCodeNum);
                            _sample_template.find("._code_time_text").text(samplingDetails[i].printCodeTime);//samplingDetails[i].printCodeTime
                            _sample_template.find("tr").addClass("_" + samplingDetails[i].id);
                            // _sample_template.find("._print_btn").append("<button class=\"btn btn-primary\" type=\"button\" onclick=\"printSampleCode('" + samplingDetails[i].id + "');\">打印</button>");
                             printNum=samplingDetails[i].printCodeNum;//打印次数
                            //已收样、前处理、检测中或已检测等状态不可修改样品
                            if (tbSampling.isSampling || samplingDetails[i].tubeCode1 || samplingDetails[i].conclusion) {
                                //打印凭证
                                _sample_template.find("tr").addClass(samplingDetails[i].sampleCode);
                                //已检测
                                if (samplingDetails[i].conclusion) {
                                    _sample_template.find("._order_status").text("已检测");
                                    //检测中
                                } else if (samplingDetails[i].tubeCode1) {
                                    _sample_template.find("._order_status").text("检测中");
                                    //已收样
                                } else if (tbSampling.isSampling == 2) {
                                    _sample_template.find("._order_status").text("已收样");
                                    //待收样
                                } else {
                                    _sample_template.find("._order_status").text("待收样");
                                }
                            } else {
                                //待收样数量+1
                                collectNum++;
                                // _sample_template.find("._food_name").html("<span>"+samplingDetails[i].foodName+"</span><i class='icon iconfont icon-xiugai text-primary _edit_item'></i>");
                                _sample_template.find("tr").addClass("_to_submit");
                                //待收样
                                _sample_template.find("._order_status").text("待收样");
                            }

                            $("#_sample_table tbody").prepend(_sample_template.html());
                        }
                    }

                    //订单列表添加订单号
                    if ($("#_orders_no ._" + tbSampling.orderNumber).length == 0) {
                        if (tbSampling.collectNum>0) {
                            //有待收样品
                            $("#_orders_no").append("<div class=\"search-code search-active _order_no _" + tbSampling.orderNumber + "\"><i class=\"icon iconfont icon-weiwancheng text-warning\"></i><span>" + tbSampling.orderNumber + "</span><i class=\"icon iconfont icon-you\"></i></div>");
                        } else {
                            $("#_orders_no").append("<div class=\"search-code search-active _order_no _" + tbSampling.orderNumber + "\"><i class=\"icon iconfont icon-wancheng text-success\"></i><span>" + tbSampling.orderNumber + "</span><i class=\"icon iconfont icon-you\"></i></div>");
                        }

                        //修改订单列表订单状态
                    } else {
                        if (tbSampling.collectNum==0) {
                            $("#_orders_no ._" + tbSampling.orderNumber + " i:first()").attr("class", "icon iconfont icon-wancheng text-success");
                        }
                    }

                    //更新序号
                    updateSerialNumber();
                    _sample_template.find("tr").addClass("_to_submit");
                } else {
                    if (data.obj) {
                        tips(data.msg);
                    } else {
                        //清空订单列表
                        tips("找不到复检订单，请核实是否已申请复检！");
                    }
                }
            }
        });
    }

    //更新序号
    function updateSerialNumber() {
        var h = 1;
        $("#_sample_table ._serial_number").each(function () {
            $(this).text(h);
            h++;
        });
    }
    function getOrderNumberByRegex(url) {
        const regex = /orderNumber=([^&]+)/;
        const match = url.match(regex);
        return match ? match[1] : "";
    }
    //切换时间，刷新数据统计和订单列表
    function loadData(){
        myChart();
        queryReCheck();
    }
    //查询待复检订单
    var phoneOrderList; //订单数据
    function queryReCheck() {
        var _start_time = $("#_start_time").val();
        var _end_time = $("#_end_time").val();

        if (!_start_time || !_end_time) {
            tips("请选择订单时间范围");
            return;
        } else if (newDate(_start_time).getTime() > newDate(_end_time).getTime()) {
            tips("订单时间范围错误");
            return;
        }
        phoneOrderList = "";
        $.ajax({
            url: "${webRoot}/newCollectSample/queryReCheck",
            type: "POST",
            data: {"startTime": $("#_start_time").val(), "endTime": $("#_end_time").val()},
            dataType: "json",
            success: function (data) {
                if (data && data.success && data.obj && data.obj.length > 0) {
                    phoneOrderList = data.obj;
                    dealHtml(1);
                }
            }
        });
    }

    var pageItemNum = 10;//每页数量
    function dealHtml(pageNum) {
        var num0 = phoneOrderList ? phoneOrderList.length : 0;    //总记录数
        var num1 = Math.floor(num0 / pageItemNum);
        var num2 = num0 % pageItemNum;
        var num3 = num1 + (num2 > 0 ? 1 : 0);    //总页数
        //第一个按钮
        var htmlStr = '<li class="cs-distan">共' + num3 + '页/' + num0 + '条记录</li><li class="cs-disabled zz-distan"> ' +
            '            <a class="zz-b-nav-btn" onclick="dealHtml(' + (pageNum - 1) + ')">‹</a> ' +
            '        </li>';

        //中间按钮
        if (pageNum < 1) {
            htmlStr += '<li>' +
                '            <a class="zz-b-nav-btn zz-current-btn" onclick="dealHtml(1)">1</a> ' +
                '       </li>';
            pageNum = 1;
        } else if (pageNum > num3) {
            htmlStr += '<li>' +
                '            <a class="zz-b-nav-btn zz-current-btn" onclick="dealHtml(' + num3 + ')">' + num3 + '</a> ' +
                '       </li>';
            pageNum = num3;
        } else {
            htmlStr += '<li>' +
                '            <a class="zz-b-nav-btn zz-current-btn" onclick="dealHtml(' + pageNum + ')">' + pageNum + '</a> ' +
                '       </li>';
        }
        //最后按钮
        htmlStr += '<li class="cs-next "> ' +
            '       <a class="zz-b-nav-btn" onclick="dealHtml(' + (pageNum + 1) + ')">›</a> ' +
            '   </li>';

        $("#paging").html(htmlStr);
        $("#_orders_no").html("");
        if (phoneOrderList) {
            var sNum = (pageNum - 1) * pageItemNum;
            var eNum = pageNum * pageItemNum - 1;
            $.each(phoneOrderList, function (index, value) {
                if (index >= sNum && index <= eNum) {
                    if (index == 0) {
                        if (value.collectNum > 0) { //有待收样品
                            $("#_orders_no").append('<div class="search-code search-active _order_no _' + value.orderNumber + '"> ' +
                                '            <i class="icon iconfont icon-weiwancheng text-warning"></i><span clas="show-not"></span><span>' + value.orderNumber + '</span><i class="icon iconfont icon-you"></i> ' +
                                '        </div>');
                        } else {
                            $("#_orders_no").append('<div class="search-code search-active _order_no _' + value.orderNumber + '"> ' +
                                '            <i class="icon iconfont icon-wancheng text-success"></i><span clas="show-not"></span><span>' + value.orderNumber + '</span><i class="icon iconfont icon-you"></i> ' +
                                '        </div>');
                        }
                        queryOrderByNo(value.orderNumber);
                    } else {
                        if (value.collectNum > 0) { //有待收样品
                            $("#_orders_no").append('<div class="search-code _order_no _' + value.orderNumber + '"> ' +
                                '            <i class="icon iconfont icon-weiwancheng text-warning"></i><span clas="show-not"></span><span>' + value.orderNumber + '</span><i class="icon iconfont icon-you"></i> ' +
                                '        </div>');
                        } else {
                            $("#_orders_no").append('<div class="search-code _order_no _' + value.orderNumber + '"> ' +
                                '            <i class="icon iconfont icon-wancheng text-success"></i><span clas="show-not"></span><span>' + value.orderNumber + '</span><i class="icon iconfont icon-you"></i> ' +
                                '        </div>');
                        }
                    }
                }
            });
        }
    }

    //编辑检测项目
    /******************************************* 修改检测项目 *******************************************/
    var editFoodTr;
    $(document).on("click","._edit_item",function(event) {
          editFoodTr = $(this).parents("tr");
        $("#foodName").val(editFoodTr.find("._food_name").text());
        $("#samplingDetailId").val(editFoodTr.find("._sampling_detail_id").text());
        $("#_edit_Item_modal").modal("show");
    });
    //保存检测项目
    $(document).on("click","#_save_item",function(event) {
        if($('#item_select2').val()!=""){
            let itemName=$('#item_select2').select2('data')[0].name;
            editFoodTr.find("._item_name").html(itemName+"<i class='icon iconfont icon-xiugai text-primary _edit_item'></i>");
            editFoodTr.find("._item_name").attr("data-itemid", $('#item_select2').val());
            cleanItemSelected();
            $("#_edit_Item_modal").modal("hide");
        }else{
            tips("请选择检测项目！");
        }
    });
    /******************************************* 打印凭证 start *******************************************/
        //打印样品码
    var _samplingId;
    var recheckList;
    function printSampleCode(sampleDetailId){
        sendMessage="";
        recheckList=[];
        sendMessage += "SIZE 52mm,30mm\r\n" +
            "CODEPAGE UTF-8\r\n" +
            "DIRECTION 1\r\n" +
            "GAP 2 mm,0 mm\r\n";
        $("#_sample_table tbody tr").each(function (index, value) {
            let foodName=$(this).find("._food_name").text();
            let sampleCode=$(this).find("._sample_code").text()
            let samplingDetailId=$(this).find("._sampling_detail_id").val();
            let itemId=$(this).find("._item_name").attr("data-itemid");
            let itemName=$(this).find("._item_name").text()
            if(itemId==""){
                tips("请选择检测项目",0);
                return false;
            }else{
                recheckList.push({"id":samplingDetailId,"sampleCode":sampleCode,"itemId":itemId,"itemName":itemName});
            }
            sendMessage += "CLS\r\n" +
                "TEXT 140,10,\"TSS24.BF2\",0,2,2,\""+foodName+"\"\r\n" +
                "BARCODE 45,65,\"128\",100,0,0,2,2,\""+sampleCode+"\"\r\n"+
                "TEXT 35,170,\"TSS24.BF2\",0,2,2,\""+sampleCode+"\"\r\n"+
                "PRINT 1,1\r\n";
        });
        sendMessage +="SOUND 5,100\r\n";
        if(connectStatus!="已连接"){
            tips("打印机连接失败："+connectStatus);
        }else{
            sendCommand();
            savePrint();
        }
    }
    function savePrint(){
        $.ajax({
            type: "POST",
            url: "${webRoot}/newCollectSample/saveRecheck",
            data: {"result":JSON.stringify(recheckList)},
            dataType: "json",
            success: function(data){
                if(data && data.success){
                    tips("打印成功",0);
                    //刷新订单
                    queryOrderByNo($("#_sample_info ._orderNumber").text());
                    //刷新应收样数量
                    myChart();
                }else{
                    tips(data.msg);
                }
            }
        });
    }
    /******************************************* 打印凭证 end *******************************************/
</script>
</html>
