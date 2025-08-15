<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/WEB-INF/view/pretreatment/resource.jsp" %>
<html>
<head>
    <title>快检服务云平台</title>
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

        .cs-mechanism-table {}

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
        .select-time>div,
        .zz-scan4 {
            display: flex;
        }

        button#next {
            float: right;
        }

        .zz-scan,.zz-scan2 {
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

        .setting-box>box,.zz-scan {
            flex: 1;
        }
        .zz-scan2{
            width: 300px;
        }
    </style>
</head>
<body style="background: #008ad4">
<div class=" cs-form-table-he cs-form-table cs-font-top clearfix">
    <div class="zz-accept-title">
        <h2 class="col-md-6" style="margin: 0px;">
            <%--<img src="${webRoot}/img/pfsystem/logo.png" style="width:40px;    margin-right: 5px;">达元快检数据预警分析软件--%>
            <img src="${webRoot}/img/pfsystem/logo.png" style="width:40px;margin-right: 5px;"
                 alt="" />${systemName}
        </h2>
        <div class="col-md-4 text-center center-text"
             style="position: absolute;width: 200px;left: 50%;top: 12px;margin-left: -100px;">前处理</div>
    </div>

    <div class="zz-scan4">
        <div class="sj-box pull-left text-center">
            <ul class="sj-list">
                <li class="time-all-se cs-input-style" style="width: 300px">
                    <div class="pull-left" style="padding: 5px;">收样时间：</div>
                    <div class="time-set pull-left">
                        <button id="previous" class="time-btns" type="button">&lt;</button>
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
        <div class="input-group input-group2 pull-right" style="background: #fff;">
            <input type="text" class="form-control" id="_default_code_input" class="pull-right"
                   style="text-transform:uppercase;" placeholder="请输入条码"
                   onkeyup="this.value=this.value.trim().toUpperCase()">
            <span class="input-group-btn">
						<button class="btn btn-primary" type="button" style="font-size: 16px;"
                                id="_default_code_input_btn">确定</button>
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
                        <!-- 停用试管条码3 -->
                        <!-- <th style="width:150px">试管条码3</th> -->
                        <!-- 停用试管条码4 -->
                        <!-- <th style="width:150px">试管条码4</th> -->
                        <th style="width:100px">上传状态</th>
                        <th style="width: 80px;">操作</th>
                    </tr>
                    </thead>
                    <tbody></tbody>
                </table>
            </form>
            <%-- <div class="zz-scan3 col-md-4">

    <div class="pull-left" style="margin-right:30px;"><i class="icon iconfont icon-dingdanquxiao"></i>未处理样品：<i class="text-danger _untreated_number">0</i> 个</div>
    <div class="pull-left"><i class="icon iconfont icon-dingdanwancheng"></i>已处理样品：<i class="text-danger">0</i> 个</div>

    <!-- <div class="pull-right"><button id="_submit_confirm_btn" type="button" class="btn btn-primary sure-btn">确定</button></div> -->
</div> --%>
        </div>

        <div class="zz-scan2">
            <!-- <div class="input-group input-group2" style="width: 100%;background: #f1f1f1;">
    <input type="text" class="form-control" id="_default_code_input" class="pull-right" style="width: 100%;text-transform:uppercase;" placeholder="请输入样品码或试管码" onkeyup="this.value=this.value.toUpperCase()">
    <span class="input-group-btn">
        <button class="btn btn-primary" type="button" style="font-size: 16px;" id="_default_code_input_btn">确定</button>
    </span>
</div> -->

            <h3>样品信息</h3>
            <div class="zz-scan-content">
                <ul id="_sample_info">
                    <li>送检单号：<span class="_samplingNo"></span></li>
                    <li>委托单位：<span class="_regName"></span>
                    </li>
                    <li style="display: none;">联系电话：<span class="_regLinkPhone"></span></li>
                    <li>单位地址：<span class="_takeSamplingAddress"></span></li>
                    <li>送检人员：<span class="_samplingUsername"></span></li>
                    <li style="display: none;">食品来源：<span class="_supplier"></span></li>
                    <li style="display: none;">经营档口：<span class="_opeShopName"></span></li>
                    <li>下单时间：<span class="_samplingDate"></span></li>
                    <li>检测费用：<span class="_inspectionFee"></span></li>
                </ul>
            </div>
        </div>
    </div>
</div>
<table style="display: none;">
    <tbody id="_sample_template">
    <tr data-samplingNo="" data-regName="" data-regLinkPhone="" data-samplingUsername="" data-supplier=""
        data-opeShopName="" data-samplingDate="" data-inspectionFee="">
        <input type="hidden" class="_sampling_detail_id">
        <td class="_serial_number"></td>
        <td class="_food_name"></td>
        <td class="_item_name"></td>
        <td><input class="zz-form-input _bag_code" type="text" readonly="readonly"></td>
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
        <!-- 停用试管条码3 -->
        <!--
<td>
<input class="zz-form-input _code_input _tube_code3" type="text" readonly="readonly">
<input type="hidden" class="_tube_code_time3" >
<i class="icon iconfont icon-close text-danger"></i>
</td>
-->
        <!-- 停用试管条码4 -->
        <!--
<td>
<input class="zz-form-input _code_input _tube_code4" type="text" readonly="readonly">
<input type="hidden" class="_tube_code_time4" >
<i class="icon iconfont icon-close text-danger"></i>
</td>
-->
        <td>
            <img alt="" src="${webRoot}/img/sure.png" class="_success" style="width:30px;display:none;">
            <i class="icon iconfont icon-guanlian1 text-primary _resubmit" style="font-size: 30px;"></i>
        </td>
        <td>
            <i class="icon iconfont icon-shanchu text-danger _delete_tr" style="font-size: 30px;"></i>
        </td>
    </tr>
    </tbody>
</table>


<!-- 提示 -->
<%--<div class="modal fade intro2" id="_tips_modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="static" data-keyboard="false">
<div class="modal-dialog cs-alert-width">
<div class="modal-content">
    <div class="modal-body cs-alert-height zz-dis-tab2 " style="height:auto;    text-align: center;">
        <div class="zz-pay zz-ok zz-no-margin">
            <img src="${webRoot}/img/terminal/wen.png" alt="" style="width: 40px">
        </div>
        <div class="zz-notice" style="height: 40px; line-height: 40px;">
            操作失败，请联系工作人员。
        </div>
        <div class="modal-footer" style="text-align:center; padding:10px;">
            <button type="" class="btn btn-primary" data-dismiss="modal">关闭</button>
        </div>
    </div>
</div>
</div>
</div>--%>


<!-- 查看委托单位 -->
<div class="modal fade intro2" id="mid_modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
     aria-hidden="true" data-backdrop="static" data-keyboard="false">
    <div class="modal-dialog cs-alert-width">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">×</span></button>
                <h4 class="modal-title" id="myModalLabel">委托单位列表</h4>
            </div>
            <div class="modal-body cs-mid-height zz-dis-tab2 " style="padding: 10px;">
                <div class="zz-w-list" style="height:210px; overflow:auto;">
                    <ul id="req_names">
                    </ul>
                </div>
                <div class="modal-footer" style="text-align:center; padding:10px;">
                    <button type="" class="btn btn-primary" data-dismiss="modal">关闭</button>
                </div>
            </div>
        </div>
    </div>
</div>
<%@include file="/WEB-INF/view/terminal/tips.jsp" %>
<%@include file="/WEB-INF/view/terminal/showUnitConfirm.jsp"%>
</body>
<script type="text/javascript" src="${webRoot}/js/scanner.js"></script>
<script type="text/javascript">
    //样品码编码
    var sampleRegExp = new RegExp("^(" + "${sampleBarCode}" + ")([0-9A-Z])*$");
    //试管码编码
    var tubeRegExp = new RegExp("^(" + "${tubeBarCode}" + ")([0-9A-Z])*$");

    // $("#_default_code_input").focus();
    // $(document).on("blur","#_default_code_input",function(event) {
    //     $("#_default_code_input").focus();
    // });

    //试管输入框事件
    var _selected_input; //选中试管码输入框
    $(document).on("click", "._code_input", function(event) {
        _selected_input = $(this);
        $("#_sample_table .select-input").removeClass("select-input");
        //$("#_sample_table ._selected_input0").removeClass("_selected_input0");
        $(this).addClass("select-input");

        $(".selected-color").removeClass("selected-color");
        $(this).parents("tr").addClass("selected-color");

        $("._code_input").removeClass("info-disable");

        //送检信息
        $("#_sample_info ._samplingNo").text($(this).parents("tr").attr("data-samplingNo"));
        //$("#_sample_info ._regName").text($(this).parents("tr").attr("data-regName"));
        //shit 更改
        var regNum = $(this).parents("tr").attr("data-unitsCount");
        var smId = $(this).parents("tr").attr("data-samplingId");

        var regNameHtml = regNum > 1 ? $(this).parents("tr").attr("data-regName") +
            '<i class="icon iconfont icon-chakan text-primary" onclick="showReq(' + smId + ')"></i>' : $(this)
            .parents("tr").attr("data-regName");
        $("#_sample_info ._regName").html(regNameHtml);

        $("#_sample_info ._regLinkPhone").text($(this).parents("tr").attr("data-regLinkPhone"));

        $("#_sample_info ._takeSamplingAddress").text($(this).parents("tr").attr("data-takeSamplingAddress"));
        $("#_sample_info ._samplingUsername").text($(this).parents("tr").attr("data-samplingUsername"));
        $("#_sample_info ._supplier").text($(this).parents("tr").attr("data-supplier"));
        $("#_sample_info ._opeShopName").text($(this).parents("tr").attr("data-opeShopName"));
        $("#_sample_info ._samplingDate").text($(this).parents("tr").attr("data-samplingDate"));
        $("#_sample_info ._inspectionFee").text("￥" + $(this).parents("tr").attr("data-inspectionFee"));
    });
    //删除试管码
    $(document).on("click", ".icon-close", function(event) {
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
    $(document).on("click", "._delete_tr", function(event) {
        $(this).parents("tr").remove();
        updateSerialNumber();
    });
    //重新上传
    $(document).on("click", "._resubmit", function(event) {
        // $("._to_submit").removeClass("_to_submit");
        // $(this).parents("tr").addClass("_to_submit");
        // $(this).parents("tr").find("._success").hide();
        // submitSampleForm();
        $(this).parents("tr").addClass("_to_submit_this");
        $(this).parents("tr").find("._success").hide();
        submitSampleForm("_to_submit_this");
    });

    //录入试管码
    function writeTubeCode(vbarCode) {
        //扫码时间改为后台时间 -- 2019/10/16
        // var sweepTime = (new Date()).format("yyyy-MM-dd HH:mm:ss");	//扫码时间
        _selected_input.attr("value", vbarCode);
        _selected_input.addClass("_" + vbarCode);

        //扫码时间改为后台时间 -- 2019/10/16
        // _selected_input.next().attr("value", sweepTime);
        _selected_input.siblings(".icon-close").show();

        //修改上传状态
        _selected_input.parents("tr").find("._success").hide();
        _selected_input.parents("tr").find("._resubmit").show();

        _selected_input.parents("tr").addClass("_to_submit");

        var _entry_bag_code = _selected_input.parents("tr").find("._bag_code").attr("value"); //当前样品码
        //一个样品多个项目，当前录入框在第一行并且相同列的试管码都为空，复制试管码到这个样品下相同列的试管码
        if ($("._" + _entry_bag_code).length > 1) {
            var _entry_tube_code = ""; //当前试管号数
            if (_selected_input.hasClass("_tube_code1")) {
                _entry_tube_code = "_tube_code1";
            } else if (_selected_input.hasClass("_tube_code2")) {
                _entry_tube_code = "_tube_code2";

            <
                !--停用试管条码3-- >
                /*
                 }else if(_selected_input.hasClass("_tube_code3")){
                 _entry_tube_code = "_tube_code3";
                 */
                <
                !--停用试管条码4-- >
                /*
                 }else if(_selected_input.hasClass("_tube_code4")){
                 _entry_tube_code = "_tube_code4";
                 */
            }

            //写入试管码
            if (_entry_tube_code) {
                $("._" + _entry_bag_code + " ." + _entry_tube_code).each(function(index, value) {
                    if (!$(this).attr("value")) {
                        $(this).attr("value", vbarCode);
                        $(this).addClass("_" + vbarCode);

                        //扫码时间改为后台时间 -- 2019/10/16
                        //$(this).next().attr("value", sweepTime);
                        $(this).siblings(".icon-close").show();

                        //修改上传状态
                        $(this).parents("tr").find("._success").hide();
                        $(this).parents("tr").find("._resubmit").show();

                        $(this).parents("tr").addClass("_to_submit");
                    }
                });
            }
        }

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

    //条码输入框事件
    $(document).on("keypress", "#_default_code_input", function(event) {
        if (event.keyCode == 13) { //回车
            if ($(this).val()) {
                checkCode($(this).val().toUpperCase());
                $(this).val("");
            }
        }
    });

    //条码输入确认按钮事件
    $(document).on("click", "#_default_code_input_btn", function(event) {
        if ($("#_default_code_input").val()) {
            checkCode($("#_default_code_input").val().toUpperCase());
            $("#_default_code_input").val("");
        }
    });

    //扫描枪输入事件
    $(function() {
        scanner.open({
            scanFunction: function(scanText) {
                // console.log("扫描文字："+scanText);
                //校验条码
                checkCode(scanText);
            }
        });

    });

    //点击放大镜查看委托单位shit
    function showReq(smId) {
        showRequestUnits(smId);
    }

    //校验条码
    var _sample_code; //最近一次录入样品码
    function checkCode(thisCode) {
        //样品码
        if (sampleRegExp.test(thisCode)) {
            //console.log("样品码:"+thisCode);

            //提交上个样品条码
            // var _submit_tr = $("#_sample_table tbody ._next_submit:first ._bag_code").attr("value");   //获取待提交样品码
            // if(_submit_tr && thisCode != _submit_tr){  //新录入样品码与上次录入样品码不一致，提交上次数据
            //     $("._to_submit").removeClass("_to_submit");    //清空已提交标识
            //     $("._next_submit").removeClass("_next_submit");    //清空待提交标识
            //     $("._"+_submit_tr).addClass("_to_submit"); //标识这次提交数据
            //     submitSampleForm();    //提交
            // }

            //提交全部未上传数据
            if (_sample_code && thisCode != _sample_code) {
                submitSampleForm("_to_submit"); //提交
                $("#_sample_table tbody tr").remove(); //清除上个A码数据，防止长时间使用后，B码页面判重验证不通过
            }
            _sample_code = thisCode;

            //增加样品
            $.ajax({
                url: "${webRoot}/pretreatment/queryByBarCode",
                type: "POST",
                data: {
                    "barcode": thisCode
                },
                dataType: "json",
                success: function(data) {
                    if (data && data.success && data.obj) {
                        var tbSampling = data.obj.tbSampling;
                        var samplingDetails = data.obj.samplingDetails;

                        if (tbSampling) {
                            var thisSelectedInput;
                            for (var i = 0; i < samplingDetails.length; i++) {
                                if ($("#" + samplingDetails[i].id).length == 0) {
                                    var _sample_template = $("#_sample_template").clone();
                                    _sample_template.find("tr").attr("id", samplingDetails[i].id);
                                    _sample_template.find("tr").attr("data-samplingId", tbSampling.id);
                                    _sample_template.find("tr").attr("data-samplingNo", tbSampling
                                        .samplingNo);
                                    _sample_template.find("tr").attr("data-regName", tbSampling.regName);
                                    _sample_template.find("tr").attr("data-unitsCount", tbSampling
                                        .unitsCount);

                                    _sample_template.find("tr").attr("data-regLinkPhone", tbSampling
                                        .regLinkPhone);
                                    // 增加显示委托单位地址信息
                                    _sample_template.find("tr").attr("data-takeSamplingAddress", tbSampling
                                        .takeSamplingAddress);
                                    _sample_template.find("tr").attr("data-samplingUsername", tbSampling
                                        .samplingUsername);
                                    _sample_template.find("tr").attr("data-supplier", samplingDetails[i]
                                        .supplier);
                                    _sample_template.find("tr").attr("data-opeShopName", samplingDetails[i]
                                        .opeShopName);
                                    _sample_template.find("tr").attr("data-samplingDate", tbSampling
                                        .samplingDate);
                                    _sample_template.find("tr").attr("data-inspectionFee", samplingDetails[i]
                                        .inspectionFee);

                                    _sample_template.find("tr").addClass("_" + samplingDetails[i]
                                        .sampleTubeCode);
                                    _sample_template.find("tr").addClass("_to_submit"); //未上传样品标识
                                    // _sample_template.find("tr").addClass("_next_submit");  //新录入样品码标识

                                    _sample_template.find("._sampling_detail_id").attr("value",
                                        samplingDetails[i].id);
                                    _sample_template.find("._bag_code").attr("value", samplingDetails[i]
                                        .sampleTubeCode);
                                    _sample_template.find("._food_name").text(samplingDetails[i].foodName);
                                    _sample_template.find("._item_name").text(samplingDetails[i].itemName);


                                    //var sweepTime0 = (new Date()).format("yyyy-MM-dd HH:mm:ss");
                                    if (samplingDetails[i].tubeCode1) {
                                        _sample_template.find("._tube_code1").attr("value", samplingDetails[i]
                                            .tubeCode1);
                                        _sample_template.find("._tube_code1").addClass("_" + samplingDetails[
                                            i].tubeCode1);
                                        _sample_template.find("._tube_code1").next().attr("value",
                                            samplingDetails[i].tubeCodeTime1);
                                        _sample_template.find("._tube_code1").siblings(".icon-close").css(
                                            "display", "block");

                                        _sample_template.find("._success").css("display", "inline-block");
                                        _sample_template.find("._resubmit").css("display", "none");
                                    }
                                    if (samplingDetails[i].tubeCode2) {
                                        _sample_template.find("._tube_code2").attr("value", samplingDetails[i]
                                            .tubeCode2);
                                        _sample_template.find("._tube_code2").addClass("_" + samplingDetails[
                                            i].tubeCode2);
                                        _sample_template.find("._tube_code2").next().attr("value",
                                            samplingDetails[i].tubeCodeTime2);
                                        _sample_template.find("._tube_code2").siblings(".icon-close").css(
                                            "display", "block");
                                    }

                                    $("#_sample_table tbody").prepend(_sample_template.html());

                                    $("#_sample_table ._tube_code1:first").click();

                                    //样品已存在
                                } else {
                                    //选中样品
                                    $("#" + samplingDetails[i].id + " ._code_input:first").click();
                                }
                            }
                            updateSerialNumber();
                            // $("#_sample_table ._tube_code1:first").click();
                        } else {
                            tips("找不到样品信息");
                        }
                    } else {
                        tips("获取样品信息失败，请联系管理员！");
                    }
                }
            });

            //试管码
        } else if (tubeRegExp.test(thisCode)) {
            console.log("试管码:" + thisCode);

            //试管码重复
            if ($("._" + thisCode).length > 0) {
                var _this_tr = _selected_input.parents("tr"); //当前试管码输入框tr
                var _this_bag_code = _this_tr.find("._bag_code").attr("value");
                var _other_bag_code = $("._" + thisCode + ":eq(0)").parents("tr").find("._bag_code").attr("value");

                //样品条码相同，允许试管码重复
                if (_this_bag_code == _other_bag_code) {
                    var _this_tube_code1 = _this_tr.find("._tube_code1").attr("value");
                    var _this_tube_code2 = _this_tr.find("._tube_code2").attr("value"); <
						!--停用试管条码3-- >
                /* var _this_tube_code3 = _this_tr.find("._tube_code3").attr("value"); */
                    <
						!--停用试管条码4-- >
                /* var _this_tube_code4 = _this_tr.find("._tube_code4").attr("value"); */

                //一行内试管码不允许重复
                if (thisCode == _this_tube_code1) {
                    if (!_selected_input.hasClass("_tube_code1")) {
                    $("._code_input").removeClass("info-disable");
                    _this_tr.find("._tube_code1").addClass("info-disable");
                }
                } else if (thisCode == _this_tube_code2) {
                    if (!_selected_input.hasClass("_tube_code2")) {
                    $("._code_input").removeClass("info-disable");
                    _this_tr.find("._tube_code2").addClass("info-disable");
                }

                    <
                    !--停用试管条码3-- >
                    /*
                    }else if(thisCode == _this_tube_code3){
                        if(!_selected_input.hasClass("_tube_code3")){
                        $("._code_input").removeClass("info-disable");
                        _this_tr.find("._tube_code3").addClass("info-disable");
                    }
                        */
                        <
                        !--停用试管条码4-- >
                        /*
                        }else if(thisCode == _this_tube_code4){
                            if(!_selected_input.hasClass("_tube_code4")){
                            $("._code_input").removeClass("info-disable");
                            _this_tr.find("._tube_code4").addClass("info-disable");
                        }
                            */

                        } else {
                            writeTubeCode(thisCode);
                        }


                        //提示试管码重复
                        } else {
                            $("._code_input").removeClass("info-disable");
                            $("._" + thisCode).addClass("info-disable");
                            //tips("试管码["+thisCode+"]已使用");
                        }

                        //本地试管码不重复，后台验证是否重复
                        } else {
                            $.ajax({
                                url: "${webRoot}/pretreatment/queryByTubeCode",
                                type: "POST",
                                data: {
                                    "tubecode": thisCode
                                },
                                dataType: "json",
                                success: function(data) {
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
                        }

                        } else {
                            tips("无效条码:" + thisCode);
                        }
                        }

    //更新序号
    function updateSerialNumber() {
        var h = 1;
        // var h = $("#_sample_table ._serial_number").length;
        $("#_sample_table ._serial_number").each(function() {
            $(this).text(h);
            h++;
            // h--;
        });

        //样品数量
        var sampleSet = new Set();
        $("#_sample_table ._bag_code").each(function() {
            sampleSet.add($(this).attr("value"));
        });
        $("#sampleNum").text(sampleSet.size);
    }

    //提交
    function submitSampleForm(_submit_tr_class_name) {
        //修改input-name
        $("._code_input").attr("name", "");
        $("._tube_code_time1").attr("name", "");
        $("._tube_code_time2").attr("name", "");
        $("._tube_code_time3").attr("name", "");
        $("._tube_code_time4").attr("name", "");

        // var _this_to_submit = $("#_sample_table tbody ._to_submit");
        var _this_to_submit = $("#_sample_table tbody ." + _submit_tr_class_name);

        if (_this_to_submit.length == 0) {
            return false;
        }

        _this_to_submit.each(function(index, value) {
            $(this).find("._sampling_detail_id").attr("name", "samplingDetailCodes[" + index +
                "].samplingDetailId");
            $(this).find("._bag_code").attr("name", "samplingDetailCodes[" + index + "].bagCode");

            var tubeNum = 0; //录入试管条码数量
            if ($(this).find("._tube_code1").attr("value")) {
                tubeNum++;
                $(this).find("._tube_code1").attr("name", "samplingDetailCodes[" + index + "].tubeCode" +
                    tubeNum);
                $(this).find("._tube_code_time1").attr("name", "samplingDetailCodes[" + index + "].tubeCodeTime" +
                    tubeNum);
            }
            if ($(this).find("._tube_code2").attr("value")) {
                tubeNum++;
                $(this).find("._tube_code2").attr("name", "samplingDetailCodes[" + index + "].tubeCode" +
                    tubeNum);
                $(this).find("._tube_code_time2").attr("name", "samplingDetailCodes[" + index + "].tubeCodeTime" +
                    tubeNum);
            } <
				!--停用试管条码3-- >
        /*
        if($(this).find("._tube_code3").attr("value")){
            tubeNum++;
            $(this).find("._tube_code3").attr("name","samplingDetailCodes["+index+"].tubeCode"+tubeNum);
            $(this).find("._tube_code_time3").attr("name","samplingDetailCodes["+index+"].tubeCodeTime"+tubeNum);
        }
        */
            <
				!--停用试管条码4-- >
        /*
        if($(this).find("._tube_code4").attr("value")){
            tubeNum++;
            $(this).find("._tube_code4").attr("name","samplingDetailCodes["+index+"].tubeCode"+tubeNum);
            $(this).find("._tube_code_time4").attr("name","samplingDetailCodes["+index+"].tubeCodeTime"+tubeNum);
        }
        */
        });

        $.ajax({
            type: "POST",
            url: "${webRoot}/pretreatment/save",
            data: $("#_sample_form ." + _submit_tr_class_name + " input").serialize(),
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

    // $("#_tips_modal").on('hidden.bs.modal',function(){
    // 	$("#_default_code_input").focus();
    // });

    // //提示信息
    //  function tips(t) {
    //      $("#_tips_modal .zz-notice").text(t);
    //      updateCloseTime(0);
    //  }
    //  //自动关闭提示倒计时
    //  var clostSecond = 3;    //提示关闭倒计时（秒）
    //  function updateCloseTime(waitSecond) {
    //      if(waitSecond == 0){
    //          $("#_tips_modal").modal("show");
    //          $("#_tips_modal button").text("关闭("+clostSecond+"s)");
    //          setTimeout(function () {
    //              updateCloseTime(++waitSecond);
    //          }, 1000);
    //
    //      }else if(waitSecond < clostSecond){
    //          $("#_tips_modal button").text("关闭("+(clostSecond-waitSecond)+"s)");
    //          setTimeout(function () {
    //              updateCloseTime(++waitSecond);
    //          }, 1000);
    //      }else{
    //          $("#_tips_modal").modal("hide");
    //      }
    //  }

    //更新未处理数量
    getUntreatedNumber();
    //获取未处理数量
    function getUntreatedNumber() {
        $.ajax({
            url: "${webRoot}/pretreatment/getUntreatedNumber",
            type: "POST",
            success: function(data) {
                $("._untreated_number").text(data);
            }
        });
    }

    /***************************** 前处理 - 开始 *****************************/
    var today = new Date();
    $("#start").val(today.format("yyyy-MM-dd"));
    myChart();

    //上一天
    $(document).on("click", "#previous", function() {
        var date1 = newDate($("#start").val());
        date1 = date1.DateAdd("d", -1);
        $("#start").val(date1.format("yyyy-MM-dd"));
        myChart();
    });
    //下一天
    $(document).on("click", "#next", function() {
        var date2 = newDate($("#start").val());
        if (today.format("yyyy-MM-dd") != date2.format("yyyy-MM-dd")) {
            date2 = date2.DateAdd("d", 1);
            $("#start").val(date2.format("yyyy-MM-dd"));
            myChart();
        }
    });
    //选择日期
    $(document).on("change", "#start", function() {
        myChart();
    });
    //当天统计每30秒刷新数据
    setInterval(function() {
        if (today.format("yyyy-MM-dd") == $("#start").val()) {
            myChart();
        }
    }, 30 * 1000);

    function myChart() {
        $.ajax({
            type: "POST",
            url: "${webRoot}/pretreatment/statistic",
            data: {
                "date": $("#start").val()
            },
            dataType: "json",
            success: function(data) {
                if (data && data.success) {
                    $("._ying_chu_li_number").text(data.obj.yingChuLi);
                    $("._yi_chu_li_number").text(data.obj.yiChuLi);
                    $("._wei_chu_li_number").text(data.obj.weiChuLi);
                }
            }
        });
    }
    /***************************** 前处理统计 - 结束 *****************************/
</script>
</html>