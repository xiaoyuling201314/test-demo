<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/WEB-INF/view/pretreatment_new/resource.jsp" %>
<title>${systemName}-前处理</title>
<html>
<head>
    <style>
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

        .icon-dingdanquxiao {
            cursor: pointer;
            font-size: 24px;
            color: #080b46;
            margin: 0 5px;
        }

        .cs-form-table td {
            background: rgba(0, 0, 0, 0);
        }

        .cs-form-table .selected-color {
            background: #dbf3ff;
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

        .zz-scan,
        .zz-scan2 {
            top: 122px;
        }

        .zz-scan {
            width: auto;
            right: 392px
        }

        .zz-scan2 {
            width: 380px;
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

        .zz-w-list ul {
            padding-left: 10px;
        }

        .zz-w-list ul li {
            line-height: 32px;
            border-bottom: 1px solid #ddd;
        }

        .cs-mechanism-table {
        }

        .cs-mechanism-table th,
        .cs-mechanism-table td {
            text-align: center;
        }

        .modal-footer {
            text-align: center;
            height: 48px;
            padding: 7px;
        }

        .modal-footer .btn {
            height: 36px;
        }

        .sj-list li.time-all-se,
        .select-time > div,
        .zz-scan4 {
            display: flex;
        }

        button#next {
            float: right;
        }

        .zz-scan, .zz-scan2 {
            position: static;
        }

        .setting-box {
            display: flex;
            height: auto;
            position: absolute;
            top: 122px;
            bottom: 10px;
            left: 10px;
            right: 10px;
        }

        .setting-box > box, .zz-scan {
            flex: 1;
        }

        .zz-scan2 {
            width: 300px;
        }
        .clear-history{
            position: absolute;
            right: 20px;
            top: 10px;
            font-size: 26px;
            color: #fff;
        }
    </style>
</head>
<body style="background: #008ad4">
<div class=" cs-form-table-he cs-form-table cs-font-top clearfix">
    <div class="zz-accept-title">
        <h2 class="col-md-6" style="margin: 0px;">
<%--            <img src="${webRoot}/img/pfsystem/logo.png" style="width:40px;margin-right: 5px;"alt=""/>${systemName}--%>
        <c:if test="${! empty systemLogo}">
            <img class="pull-left" src="${resourcesUrl}${systemLogo}" style="height:50px; margin-top: 5px;" alt="" />
        </c:if>
        ${homeSystemName}
        </h2>
        <div class="col-md-4 text-center center-text" style="position: absolute;width: 200px;left: 50%;top: 12px;margin-left: -100px;">前处理
        </div>
        <%--清空前处理列表--%>
        <span class="iconfont icon-qingchu clear-history" title="清空记录" onclick="clearHistory();">
<%--            <b style="font-size: 16px;">清空记录</b>--%>
        </span>
    </div>

    <div class="zz-scan4">
        <div class="sj-box pull-left text-center">
            <ul class="sj-list">
                <li class="time-all-se cs-input-style" style="width: 300px">
                    <div class="pull-left" style="padding: 5px;">收样时间：</div>
                    <div class="time-set pull-left">
                        <button id="previous" class="time-btns" type="button"><</button>
                        <input id="start" style="width: 110px;" class="pull-left cs-time text-center"
                               type="text" onclick="WdatePicker({maxDate:'%y-%M-%d',onpicked:myChart})">
                        <button id="next" class="time-btns" type="button">></button>
                    </div>
                </li>
                <li><i class="icon iconfont icon-yiqianding"></i>应处理 <span class="_ying_chu_li_number">0</span>个
                </li>
                <li><i class="icon iconfont icon-yiqianding"></i>已处理 <span class="_yi_chu_li_number">0</span>个
                </li>
                <li><i class="icon iconfont icon-yiqianding"></i>未处理 <span class="_wei_chu_li_number">0</span>个
                </li>
            </ul>

        </div>
        <div class="input-group input-group2 pull-right" style="position: absolute;right: 10px;background: #fff;">
            <input type="text" class="form-control" id="_default_code_input" class="pull-right"
                   style="text-transform:uppercase;" placeholder="请输入条码"
                   onkeyup="this.value=this.value.trim().toUpperCase()">
            <span class="input-group-btn">
                <button class="btn btn-primary" type="button" style="font-size: 16px;" id="_default_code_input_btn">确定</button>
            </span>
        </div>
    </div>

    <div class="setting-box">
        <div class="zz-scan">
            <form id="_sample_form">
                <table id="_sample_table">
                    <thead>
                    <tr class="top-tr">
                        <th style="width:50px">序号</th>
                        <th style="width:110px">送检样品</th>
                        <th style="">检测项目</th>
                        <th style="width:150px">样品条码</th>
                        <th style="width:150px">试管条码1</th>
                        <th style="width:150px">试管条码2</th>
                        <th style="width:100px">上传状态</th>
                        <th style="width: 80px;">操作</th>
                    </tr>
                    </thead>
                    <tbody></tbody>
                </table>
            </form>
        </div>

        <div class="zz-scan2">
            <h3>订单信息</h3>
            <div class="zz-scan-content">
                <ul id="_sample_info">
                    <li>送检单号：<span class="_order_number"></span></li>
                    <li>下单时间：<span class="_order_time"></span></li>
                    <li>送检单位：<span class="_ccu_name"></span></li>
                    <li>送检人员：<span class="_order_username"></span></li>
                    <li >联系电话：<span class="_order_user_phone"></span></li>
                    <li>检测费用：<span class="_order_fees"></span></li>
                </ul>
            </div>
        </div>
    </div>
</div>
<table style="display: none;">
    <tbody id="_sample_template">
    <tr data-orderNumber="" data-regName="" data-regLinkPhone="" data-samplingUsername="" data-supplier=""
        data-opeShopName="" data-orderTime="" data-inspectionFee="">
        <input type="hidden" class="_sampling_detail_id">
        <td class="_serial_number"></td>
        <td class="_food_name"></td>
        <td class="_item_name"></td>
        <td class="_bag_code"></td>
        <td>
            <input class="zz-form-input _code_input _tube_code1" type="text" readonly="readonly">
            <input type="hidden" class="_tube_code_time1">
            <i class="icon iconfont icon-close text-danger"></i>
        </td>
        <td>
            <input class="zz-form-input _code_input _tube_code2" type="text" readonly="readonly">
            <input type="hidden" class="_tube_code_time2">
            <i class="icon iconfont icon-close text-danger"></i>
        </td>
        <td>
            <img alt="" src="${webRoot}/img/sure.png" class="_success" title="绑定成功" style="width:30px;display:none;">
            <i class="icon iconfont icon-guanlian1 text-primary _resubmit" title="点击绑定" style="font-size: 30px;"></i>
        </td>
        <td>
            <i class="icon iconfont icon-shanchu text-danger _delete_tr" style="font-size: 30px;"></i>
        </td>
    </tr>
    </tbody>
</table>
<%@include file="/WEB-INF/view/terminal/tips.jsp" %>
<%@include file="/WEB-INF/view/terminal/showUnitConfirm.jsp" %>
</body>
<script type="text/javascript" src="${webRoot}/js/scanner.js"></script>
<script type="text/javascript">
    //样品码编码
    var sampleRegExp = new RegExp("^(" + "${sampleBarCode}" + ")([0-9]){10}-[0-9]{2}$");
    //试管码编码
    var tubeRegExp = new RegExp("^(" + "${tubeBarCode}" + ")([0-9]){8}$");
    /***************************** 前处理 - 开始 *****************************/
    var today = new Date();
    $("#start").val(today.format("yyyy-MM-dd"));
    //上一天
    $(document).on("click", "#previous", function () {
        var date1 = newDate($("#start").val());
        date1 = date1.DateAdd("d", -1);
        $("#start").val(date1.format("yyyy-MM-dd"));
        myChart();
    });
    //下一天
    $(document).on("click", "#next", function () {
        var date2 = newDate($("#start").val());
        if (today.format("yyyy-MM-dd") != date2.format("yyyy-MM-dd")) {
            date2 = date2.DateAdd("d", 1);
            $("#start").val(date2.format("yyyy-MM-dd"));
            myChart();
        }
    });
    //选择日期
    $(document).on("change", "#start", function () {
        myChart();
    });
    //当天统计每60秒刷新数据
    setInterval(function () {
        if (today.format("yyyy-MM-dd") == $("#start").val()) {
            myChart();
        }
    }, 60 * 1000);

    function myChart() {
        $.ajax({
            type: "POST",
            url: "${webRoot}/newPretreatment/statistic",
            data: {
                "date": $("#start").val()
            },
            dataType: "json",
            success: function (data) {
                if (data && data.success) {
                    $("._ying_chu_li_number").text(data.obj.yingChuLi);
                    $("._yi_chu_li_number").text(data.obj.yiChuLi);
                    $("._wei_chu_li_number").text(data.obj.weiChuLi);
                }
            }
        });
    }

    /***************************** 前处理统计 - 结束 *****************************/
    //条码输入框事件
    $(document).on("keypress", "#_default_code_input", function (event) {
        if (event.keyCode == 13) { //回车
            if ($(this).val()) {
                checkCode($(this).val().toUpperCase());
                $(this).val("");
            }
        }
    });

    //条码输入确认按钮事件
    $(document).on("click", "#_default_code_input_btn", function (event) {
        if ($("#_default_code_input").val()) {
            checkCode($("#_default_code_input").val().toUpperCase());
            $("#_default_code_input").val("");
        }
    });

    $(function () {
        myChart();
        //扫描枪输入事件
        scanner.open({
            scanFunction: function (scanText) {
                //校验条码
                checkCode(scanText);
            }
        });

    });
    //校验条码
    var _sample_code; //最近一次录入样品码
    function checkCode(thisCode) {
        //样品码
        if (sampleRegExp.test(thisCode)) {
            //提交全部未上传数据
            if (_sample_code && thisCode != _sample_code) {
                submitSampleForm("_to_submit"); //提交
                // $("#_sample_table tbody tr").remove(); //清除上个A码数据，防止长时间使用后，B码页面判重验证不通过
            }
            _sample_code = thisCode.trim();
            //校验样品码是否存在，如果已经存在给出相应的提示信息
            if(checkFoodCodeExists(_sample_code)){
                tips("样品码[" + _sample_code + "]已存在！");
                return;
            }
            //查询样品
            $.ajax({
                url: "${webRoot}/newPretreatment/queryByBarCode",
                type: "POST",
                data: {
                    "barcode": thisCode
                },
                dataType: "json",
                success: function (data) {
                    if (data && data.success && data.obj) {
                        var tbSampling = data.obj.tbSampling;
                        var samplingDetails = data.obj.samplingDetails;
                        if (tbSampling) {
                            for (var i = 0; i < samplingDetails.length; i++) {
                                    var _sample_template = $("#_sample_template").clone();
                                    //存储右侧订单信息
                                    let orderFees=parseFloat(tbSampling.orderFees)/100;
                                    _sample_template.find("tr").attr("id", samplingDetails[i].id);
                                    _sample_template.find("tr").attr("data-samplingId", tbSampling.id);
                                    _sample_template.find("tr").attr("data-orderNumber", tbSampling.orderNumber);
                                    _sample_template.find("tr").attr("data-iuName", tbSampling.iuName);
                                    _sample_template.find("tr").attr("data-orderUsername", tbSampling.orderUsername);
                                    _sample_template.find("tr").attr("data-orderUserPhone", tbSampling.orderUserPhone);
                                    _sample_template.find("tr").attr("data-orderTime", tbSampling.orderTime);
                                    _sample_template.find("tr").attr("data-orderFees", orderFees);

                                    //检测样品信息
                                    _sample_template.find("._sampling_detail_id").attr("value",samplingDetails[i].id);
                                    _sample_template.find("._bag_code").text(samplingDetails[i].sampleCode);
                                    _sample_template.find("tr").addClass("_" + samplingDetails[i].sampleCode);
                                    _sample_template.find("tr").addClass("_to_submit"); //未上传样品标识
                                    _sample_template.find("._food_name").text(samplingDetails[i].foodName);
                                    _sample_template.find("._item_name").text(samplingDetails[i].itemName);
                                    //已经前处理，设置试管条码
                                    if (samplingDetails[i].tubeCode1) {
                                        _sample_template.find("._tube_code1").attr("value", samplingDetails[i].tubeCode1);
                                        _sample_template.find("._tube_code1").addClass("_" + samplingDetails[ i].tubeCode1);
                                        _sample_template.find("._tube_code1").next().attr("value",samplingDetails[i].tubeCodeTime1);
                                        _sample_template.find("._tube_code1").siblings(".icon-close").css("display", "block");
                                        _sample_template.find("._success").css("display", "inline-block");
                                        _sample_template.find("._resubmit").css("display", "none");
                                    }
                                    if (samplingDetails[i].tubeCode2) {
                                        _sample_template.find("._tube_code2").attr("value", samplingDetails[i].tubeCode2);
                                        _sample_template.find("._tube_code2").addClass("_" + samplingDetails[i].tubeCode2);
                                        _sample_template.find("._tube_code2").next().attr("value",samplingDetails[i].tubeCodeTime2);
                                        _sample_template.find("._tube_code2").siblings(".icon-close").css("display", "block");
                                    }
                                    $("#_sample_table tbody").prepend(_sample_template.html());

                                    $("#_sample_table ._tube_code1:first").click();
                            }
                            updateSerialNumber();
                        } else {
                            tips("找不到样品信息");
                        }
                    } else {
                        tips("获取样品信息失败，"+data.msg);
                    }
                }
            });
            //试管码
        } else if (tubeRegExp.test(thisCode)) {
            console.log("试管码:" + thisCode);
            $.ajax({
                url: "${webRoot}/newPretreatment/queryByTubeCode",
                type: "POST",
                data: {
                    "tubecode": thisCode
                },
                dataType: "json",
                success: function (data) {
                    if (data && data.success) {
                        if (data.obj.length > 0) {
                            tips("试管码[" + thisCode + "]已使用");
                        } else {
                            writeTubeCode(thisCode);
                        }

                    } else {
                        tips("试管码[" + thisCode + "]异常，请更换试管");
                    }
                }
            });
        } else {
            tips("无效条码:" + thisCode);
        }
    }

    //更新序号
    function updateSerialNumber() {
        var h = 1;
        $("#_sample_table ._serial_number").each(function () {
            $(this).text(h);
            h++;
        });
        /*//样品数量
        var sampleSet = new Set();
        $("#_sample_table ._bag_code").each(function () {
            sampleSet.add($(this).attr("value"));
        });
        $("#sampleNum").text(sampleSet.size);*/
    }
    var _selected_input; //选中试管码输入框
    //点击数据行，增加选中样式，并且更新右侧的订单信息 #_sample_table tr,
    $(document).on("click", "._code_input", function (event) {
        _selected_input =$(this);// $(this).find("._tube_code1");
        $("#_sample_table .select-input").removeClass("select-input");
        $(this).addClass("select-input");

        $(".selected-color").removeClass("selected-color");
        $(this).parents("tr").addClass("selected-color");
        $("._code_input").removeClass("info-disable");
        //右侧订单信息
        let sampleObj=$("#_sample_info");
        let foodObj=$(this).parents("tr");//$(this);
        sampleObj.find("._order_number").text(foodObj.attr("data-orderNumber"));
        sampleObj.find("._ccu_name").text(foodObj.attr("data-iuName"));
        sampleObj.find("._order_username").text(foodObj.attr("data-orderUsername"));
        sampleObj.find("._order_user_phone").text(foodObj.attr("data-orderUserPhone"));
        sampleObj.find("._order_time").text(foodObj.attr("data-orderTime"));
        sampleObj.find("._order_fees").text("￥"+foodObj.attr("data-orderFees"));
    });
    //删除试管码
    $(document).on("click", ".icon-close", function (event) {
        $(this).hide();
        var _this_code_input = $(this).siblings("._code_input");
        _this_code_input.removeClass("_" + _this_code_input.attr("value"));
        _this_code_input.attr("value", "");
        _this_code_input.next().attr("value", "");
        _this_code_input.click();
        //修改上传状态
        $(this).parents("tr").find("._success").hide();
        $(this).parents("tr").find("._resubmit").show();
        $(this).parents("tr").addClass("_to_submit");
    });
    //删除样品
    $(document).on("click", "._delete_tr", function (event) {
        $(this).parents("tr").remove();
        updateSerialNumber();
    });
    //重新上传
    $(document).on("click", "._resubmit", function (event) {
        // submitSampleForm();
        $(this).parents("tr").addClass("_to_submit_this");
        $(this).parents("tr").find("._success").hide();
        submitSampleForm("_to_submit_this");
    });

    //录入试管码
    function writeTubeCode(vbarCode) {
        _selected_input.attr("value", vbarCode);
        _selected_input.addClass("_" + vbarCode);
        _selected_input.siblings(".icon-close").show();
        //修改上传状态
        _selected_input.parents("tr").find("._success").hide();
        _selected_input.parents("tr").find("._resubmit").show();
        _selected_input.parents("tr").addClass("_to_submit");
        //跳到下一个录入框
        var xyg = _selected_input.parent().next().find("._code_input");
        if (xyg.length > 0) {
            //下一个
            if (!xyg.attr("value")) {
                xyg.click();
            }
        } else {
            //下一行
            var xyh = _selected_input.parents("tr").next();
            if (xyh.length > 0) {
                if (!xyh.find("._tube_code1").attr("value")) {
                    xyh.find("._tube_code1").click();
                }
            }
        }
    }
    //提交
    function submitSampleForm(_submit_tr_class_name) {
        //修改input-name
        $("._code_input").attr("name", "");
        $("._tube_code_time1").attr("name", "");
        $("._tube_code_time2").attr("name", "");
        $("._tube_code_time3").attr("name", "");
        $("._tube_code_time4").attr("name", "");
        let _this_to_submit = $("#_sample_table tbody ." + _submit_tr_class_name);
        if (_this_to_submit.length == 0) {
            return false;
        }
        _this_to_submit.each(function (index, value) {
            //有试管码并且没有上传的才提交,去掉过滤条件，不然清除试管码的时候没法保存
            if ($(this).find("._tube_code1").attr("value")) {
                $(this).find("._sampling_detail_id").attr("name", "samplingDetailCodes[" + index +"].samplingDetailId");
                $(this).find("._bag_code").attr("name", "samplingDetailCodes[" + index + "].bagCode");
                var tubeNum = 0; //录入试管条码数量
                if ($(this).find("._tube_code1").attr("value")) {
                    tubeNum++;
                    $(this).find("._tube_code1").attr("name", "samplingDetailCodes[" + index + "].tubeCode" +tubeNum);
                    $(this).find("._tube_code_time1").attr("name", "samplingDetailCodes[" + index + "].tubeCodeTime" + tubeNum);
                }
                if ($(this).find("._tube_code2").attr("value")) {
                    tubeNum++;
                    $(this).find("._tube_code2").attr("name", "samplingDetailCodes[" + index + "].tubeCode" +
                        tubeNum);
                    $(this).find("._tube_code_time2").attr("name", "samplingDetailCodes[" + index + "].tubeCodeTime" +
                        tubeNum);
                }
            }
        });

        let formData=$("#_sample_form ." + _submit_tr_class_name + " input").serialize();
        if(formData!=""){
            $.ajax({
                type: "POST",
                url: "${webRoot}/newPretreatment/save",
                data: formData,
                dataType: "json",
                success: function(data) {
                    if (data && data.success) {
                        $(_this_to_submit).each(function(index, value) {
                            $(this).find("._success").show();
                            $(this).find("._resubmit").hide();
                            //清除待上传样品标识
                            $(this).removeClass(_submit_tr_class_name);
                            $(this).removeClass("_to_submit");
                        });
                        //刷新应处理数量
                        myChart();

                    } else {
                        $(_this_to_submit).each(function(index, value) {
                            $(this).find("._success").hide();
                            $(this).find("._resubmit").show();
                        });
                        tips(data.msg);
                    }
                    //更新未处理数量
                    getUntreatedNumber();
                }
            });
        }

    }
    //更新未处理数量
    getUntreatedNumber();

    //获取未处理数量
    function getUntreatedNumber() {
        $.ajax({
            url: "${webRoot}/newPretreatment/getUntreatedNumber",
            type: "POST",
            success: function (data) {
                $("._untreated_number").text(data);
            }
        });
    }
    function checkFoodCodeExists(sampleCode){
        let checkFlag=false;
        $("#_sample_table tbody tr").each(function (index, item) {
            if(sampleCode==$(item).find("._bag_code").text()){
                checkFlag=true;
                return;
            }
        });
        return checkFlag;
    }
    //清空历史数据表
    function clearHistory(){
        $("#_sample_table tbody").empty("");
        //右侧订单信息
        let sampleObj=$("#_sample_info");
        sampleObj.find("._order_number").text("");
        sampleObj.find("._ccu_name").text("");
        sampleObj.find("._order_username").text("");
        sampleObj.find("._order_user_phone").text("");
        sampleObj.find("._order_time").text("");
        sampleObj.find("._order_fees").text("");
    }
</script>
</html>