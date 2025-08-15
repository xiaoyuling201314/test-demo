<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/WEB-INF/view/pretreatment_new/resource.jsp" %>
<title>${systemName}-订单分拣</title>
<html>
<head>
    <style>
        a:hover{
            text-decoration: none;
        }
        .sj-list{
          margin: 0;
          padding: 0;
        }
        .sj-list li{
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
        .sj-list li.time-all-se{
          font-size: 16px;
          line-height: 26px;
          padding: 0;
          padding-top: 5px;
        }
        .cs-input-style input{
          background: #f1f1f1;
          height: 36px;
          line-height: 36px;
          border: 1px solid #ddd;
          outline: 0;
          border-radius: 0;
        }
        .cs-input-style input:focus{
          background:#eee;
        }
        .time-set{
          /* margin-top: 10px; */
        }
        .sj-list li .icon{
          font-size: 20px;
          margin-right: 5px;
          color: #008ad4;
        }

          .time-btns{
            width: 34px;
            height: 36px;
            background: rgba(0,0,0,0);
            border: 1px solid #ddd;
            float: left;
            border-radius: 4px;
            color: #008ad4;
          }
        .time-btns:active{
            border: 0;
            outline: 0;
            color: #fff;
            background: #13adff;
        }
        .time-btns:focus{
            outline: 0;
        }
        .time-all-se{
            width: 200px;
            float: left;
            /* margin-top: 10px; */
        }
        .sj-box{
          margin-right: 5px;
        }
        ul{
            padding:0;
        }
        .select-input{
            border: 1px solid #1490d8;
        }
        .info-disable{
            border: 1px solid #d81414;
            background: #efcccc;
        }
        .icon-close{
            position:absolute;
            right:10px;
            top: 15px;
            cursor:pointer;
            display: none;
        }
        td{
            position: relative;
        }
        .search-code{
            line-height: 48px;
            text-align: left;
            height: 48px;
            border-bottom: 1px solid #ddd;
            color: #337ab7;
            cursor: pointer;
            padding-left: 10px;
            font-size: 16px;
        }
        .search-code .icon{
            margin-right: 5px;
        }
        .search-code .icon-you{
            float:right;
        }
        .search-code:hover{
            color:#4da1e8;
            background:#f1f1f1;
        }
        .search-active{
            color:#4da1e8;
            background:#f1f1f1;
        }
        .cs-all-ps{
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
            width:300px;
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
        .cs-check-down li{
            float: none;
        }
        .cs-check-down li:hover{
            background: #137eec;
            color: #fff;
        }
        .zz-scan2{
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
        ._to_submit{
            background: #fff;
            padding: 10px 10px 10px 40px;
        }
        ul._to_submit li{
            float: left;
            width: 33%;
            white-space: nowrap;
            line-height: 32px;
            height: 32px;
        }
        .zz-scan3{
            left: 312px;
            width:auto;
            right: 10px
        }
        .input-group2 {
            width: 330px;
        }
        .show-not{
            padding: 4px;
            background: red;
            color: #fff;
        }
        .text-warning{
            color:#eca11f;
        }
        .select-time{
            padding: 5px;
            border-bottom: 1px solid #ddd;
        }
        .select-time input{
            border: 1px solid #ddd;
            padding-left: 10px;
            height: 36px;
            width: 120px;
            float: left;

        }
        .select-time i{
            margin: 8px 5px;

        }
        .zz-pagination{
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
        .zz-pagination a{
            text-decoration: none;
        }
        .zz-current-btn{
            background: #0a64f7;
            color:#fff;
        }
        .zz-current-btn:hover{
            background: #0a64f7;
            color:#fff;
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
        .cs-form-table td{
            border: 1px solid #ddd;
        }
        .icon {
		    cursor: pointer;
		    /*font-size: 24px;
		    color: #080b46;
		    margin: 0 5px;*/
		}
        input.inputData{
            font-size:16px;
        }
        .zz-scan4{
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
		.input-group2{
		    background: #f1f1f1;
		    height: 59px;
		    line-height: 0px;
		    /* padding: 0; */
		    padding: 11px;
		}
		.zz-scan2{
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
		.cs-input-cont{
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
		    color: rgba(0,0,0,0);
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
		    font-size:14px;
		    padding:10px;
		}
		td{
			padding:10px;
		}
		th, td {
		    border: 1px solid #ddd;
		}
		.tex-center{
			text-align:center;
		}
		.cs-mechanism-list, .cs-points-list, .cs-secleted-list{
			height:408px;
		}
		.cs-mechanism-table-box{
			overflow:auto;
		}
        .cs-mechanism-list-title,.cs-points-list .cs-mechanism-tab{
        height: 39px;
        line-height: 39px;
        padding: 0 10px;

        }
        .cs-mechanism-list-content{
            width:100%;
        }
        .sj-list li.time-all-se,.select-time>div,.zz-scan4{
            display: flex;
        }

        button#next{
            float: right;
        }


    </style>
</head>
<body style="background: #008ad4">
    <form id="_sample_form">
        <div class=" cs-form-table-he cs-form-table cs-font-top clearfix">
            <div class="zz-accept-title">
                <h2 class="col-md-6" style="margin: 0px;">
<%--                    <img src="${webRoot}/img/pfsystem/logo.png" style="width:40px;margin-right: 5px;" alt="" />--%>
                    <c:if test="${! empty systemLogo}">
                        <img class="pull-left" src="${resourcesUrl}${systemLogo}" style="height:50px; margin-top: 5px;" alt="" />
                    </c:if>
                    ${homeSystemName}
                </h2>
                <div class="text-center center-text" style="position: absolute;width: 200px;left: 50%;top: 12px;margin-left: -100px;">订单分拣</div>

            </div>

            <div class="zz-scan4">
              <div class="sj-box pull-left text-center">
                <ul class="sj-list">
                    <li class="time-all-se cs-input-style" style="width: 300px">
                        <div class="pull-left" style="padding: 5px;">订单时间：</div>
                        <div class="time-set">
                            <button id="previous" class="time-btns" type="button"><</button>
                            <input id="start" style="width: 110px;" class="pull-left cs-time text-center" type="text" onclick="WdatePicker({maxDate:'%y-%M-%d',onpicked:myChart})" >
                            <button id="next" class="time-btns" type="button">></button>
                        </div>
                    </li>
                    <li><i class="icon iconfont icon-yiqianding"></i>应分拣 <span class="_ying_shou_number">0</span>个</li>
                    <li><i class="icon iconfont icon-yiqianding"></i>已分拣 <span class="_yi_shou_number">0</span>个</li>
                    <li><i class="icon iconfont icon-yiqianding"></i>未分拣 <span class="_wei_shou_number">0</span>个</li>
                </ul>
                
              </div>
              <div class="input-group input-group2 pull-right" style="background: #fff;position: absolute;right: 10px;">
                <input type="text" class="form-control" id="_default_code_input" class="pull-right" style="text-transform:uppercase;" placeholder="请输入订单号或送检人联系电话" onkeyup="this.value=this.value.trim().toUpperCase()">
                    <span class="input-group-btn">
                    <button class="btn btn-primary" type="button" style="font-size: 16px;" id="_default_code_input_btn">确定</button>
                </span>
            </div>
            </div>
            
            <div style="position: absolute;left: 10px; top: 122px; width: 300px;bottom: 10px;background: #fff;box-shadow: 0 0 2px #ddd;overflow: auto;padding-top: 10px;padding-bottom: 40px;">

                <div style="position: absolute;top:0;width: 100%;height: 0px;line-height:0px;background:#13adff;font-size: 16px;color:#fff;text-align: center;font-weight: bold;border: 2px solid #13adff;"><%--订单号--%></div>
                <div class="select-time clearfix">
                    <div class="clearfix">
                        <input id="_start_time" type="text" placeholder="开始时间" onclick="WdatePicker({maxDate:'#F{$dp.$D(\'_end_time\')||\'%y-%M-%d\'}',dateFmt:'yyyy-MM-dd'})">
                         <i class="pull-left">至</i>
                        <input id="_end_time" type="text" placeholder="结束时间" onclick="WdatePicker({minDate:'#F{$dp.$D(\'_start_time\')}',maxDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd'})">
                    </div>
                    <p style="margin: 0;margin-top: 6px;padding-right: 6px; line-height: 24px;">送检人联系电话：
                        <span id="_query_phone"></span>
                        <button class="btn btn-primary pull-right" type="button" style="font-size: 14px;height: 24px;line-height: 10px;margin-right: 20px;" onclick="queryOrderByPhone();">查询</button>
                    </p>
                </div>
                <div class="zz-code-lists" id="_orders_no">

                </div>

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
                        <th style="width:100px;">打印样品码</th>
                    </tr>
                    </thead>

                    <tbody></tbody>
                </table>
                <div class="zz-scan3">
                    <div id="_div_0" class="pull-right" style="padding: 10px;"><button type="button" class="btn btn-primary sure-btn" onclick="printSampleCode();">打印全部</button></div>
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

    <div id="_edit_food_modal" class="modal fade intro2" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog cs-mid-width">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">修改样品</h4>
                </div>
                <div class="modal-body cs-mid-height cs-dis-tab">
                    <ul class="cs-ul-form clearfix col-sm-12 col-md-12">
                        <li  class="cs-name col-sm-3 col-md-3"><i class="cs-mred">*</i>选择样品：</li>
                        <li class="zz-input col-sm-8 col-md-8">
                            <div class="cs-all-ps" style="width: 302px">
                                <button class="zz-clear-btn2" type="button"><i class="icon iconfont icon-close"></i></button>
                                <div class="cs-input-box">
                                    <input type="hidden"  name="_edit_food_id" class="cs-input-id"/>
                                    <input type="hidden"  name="_edit_food_name" class="cs-input-id"/>
                                    <input type="text" id="inputDataFood" class="cs-down-input inputData" autocomplete="off" placeholder="请输入首字母查找样品" />
                                </div>
                                <div class="cs-check-down" style="">
                                    <ul id="myFoodSelect" style="padding:0;">
                                    </ul>
                                </div>
                            </div>
                        </li>
                    </ul>
                </div>
                <div class="modal-footer" style="text-align:center; padding:10px; height: auto">
                    <button type="button" id="_save_food" class="btn btn-primary btn-ok">确定</button>
                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                </div>
            </div>
        </div>
    </div>

    <table style="display: none;">
        <tbody id="_sample_template">
            <tr>
                <input type="hidden" class="_sampling_detail_id" >
                <input type="hidden" class="_food_id" >
                <input type="hidden" class="_food_name" >
                <td class="_serial_number"></td>
                <td class="_food_name"></td>
                <td class="_item_name" data-itemid=""></td>
                <td class="_sample_code"> </td>
                <td class="_print_num_text"></td>
                <td class="_code_time_text"></td>
                <td class="_order_status"></td>
                <td class="_print_btn"></td>
                <%--
                <td class="_supplier"></td>
                <td class="_ope_shop_name"></td>
                --%>
            </tr>
        </tbody>
    </table>

    <%--  提示框  --%>
    <%@include file="/WEB-INF/view/terminal/tips.jsp"%>
</body>
<script type="text/javascript" src="${webRoot}/js/printTicket.js"></script>
<script type="text/javascript" src="${webRoot}/js/scanner.js"></script>
<script type="text/javascript">
    //订单号
    var orderRegExp = new RegExp("^(${wxOrderCode})\\d{10,}$");
    //手机号
    var phoneRegExp = new RegExp("^1(3|4|5|6|7|8|9)\\d{9}$");
    /***************************** 收样统计 - 开始 *****************************/
    var today = new Date();
    $("#start").val(today.format("yyyy-MM-dd"));
    myChart();

    //上一天
    $(document).on("click","#previous",function () {
        var date1 = newDate($("#start").val());
        date1 = date1.DateAdd("d", -1);
        $("#start").val(date1.format("yyyy-MM-dd"));
        myChart();
    });
    //下一天
    $(document).on("click","#next",function () {
        var date2 = newDate($("#start").val());
        if (today.format("yyyy-MM-dd") != date2.format("yyyy-MM-dd")) {
            date2 = date2.DateAdd("d", 1);
            $("#start").val(date2.format("yyyy-MM-dd"));
            myChart();
        }
    });
    //选择日期
    $(document).on("change","#start",function () {
        myChart();
    });
    //当天统计每30秒刷新数据
    setInterval(function(){
        if (today.format("yyyy-MM-dd") == $("#start").val()) {
            myChart();
        }
    }, 30 * 1000);
    function myChart() {
        $.ajax({
            type: "POST",
            url: "${webRoot}/newCollectSample/statistic",
            data: {"date" : $("#start").val()},
            dataType: "json",
            success: function(data) {
                if (data && data.success) {
                    $("._ying_shou_number").text(data.obj.yingShou);
                    $("._yi_shou_number").text(data.obj.yiShou);
                    $("._wei_shou_number").text(data.obj.weiShou);
                }
            }
        });
    }
    /***************************** 收样统计 - 结束 *****************************/
    //扫描枪输入事件
    $(function () {
        resetTime();
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
        //连接打印机
        doConnect();
    });
    function getOrderNumberByRegex(url) {
        const regex = /orderNumber=([^&]+)/;
        const match = url.match(regex);
        return match ? match[1] : "";
    }

    //查询输入框确认按钮事件
    $(document).on("click","#_default_code_input_btn",function(event) {
        if($("#_default_code_input").val()){
            //获取输入值
            var thisCode = $("#_default_code_input").val().toUpperCase();
            //校验输入值
            checkCode(thisCode);

            $("#_default_code_input").val("");
        }
    });
    //点击订单号
    $(document).on("click","._order_no",function(event) {
        $("._order_no").removeClass("search-active");
        $(this).addClass("search-active");
        queryOrderByNo($(this).find("span").text());
    });

    //校验条码
    function checkCode(thisCode){
        if (thisCode) {
            thisCode = thisCode.toUpperCase();
         if (phoneRegExp.test(thisCode)) {
                //记录查询条件-联系电话
                $("#_query_phone").text(thisCode);
                queryOrderByPhone();
                //订单号
            }else if (orderRegExp.test(thisCode)) {
                //清除查询条件-联系电话
                $("#_query_phone").text("");

                queryOrderByNo(thisCode);
                $("#_orders_no").html("");
                // $("#_orders_no").append("<div class=\"search-code search-active _order_no\"><span>"+thisCode+"</span><i class=\"icon iconfont icon-you\"></i></div>");
            }else{
                tips("请输入正确的订单号或送检人联系电话");
            }
        }
    }

    //根据订单号查询订单
    function queryOrderByNo(orderNo){
        $("#_sample_table tbody tr").remove();
        $("#_sample_info ._reg_info").remove();
        $("#_edit_reg_modal1 ._query_req_units tr:gt(0)").remove();
        $("#_edit_reg_modal1 ._selected_req_units tr").remove();

        console.log("订单号:"+orderNo);

        //查询订单信息
        $.ajax({
            url: "${webRoot}/newCollectSample/queryBySamplingNo",
            type: "POST",
            data: {"orderNumber":orderNo},
            dataType: "json",
            success: function(data){
                if(data && data.success && data.obj && data.obj.order){
                    var tbSampling = data.obj.order;
                    var samplingDetails = tbSampling.samplingDetails;
                    //订单ID
                    _samplingId = tbSampling.id;

                    var collectNum = 0;    //待收样数量

                    //订单信息
                    $("#_sample_info ._orderNumber").text(tbSampling.orderNumber);
                    $("#_sample_info ._samplingUsername").text(tbSampling.orderUsername);
                    $("#_sample_info ._samplingDate").text(tbSampling.orderTime);
                    $("#_sample_info ._inspectionFee").text("￥"+(tbSampling.orderFees)/100);
                    $("#_sample_info ._param3").text(tbSampling.orderUserPhone);
                    $("#_sample_info input[name='tbSampling.id']").val(tbSampling.id);
                    $("#_sample_info ._regName").html(tbSampling.iuName);

                    var collectCodes = new Set();

                    for(var i=0;i<samplingDetails.length;i++){
                        //样品明细
                        if($("#"+samplingDetails[i].id).length==0){
                            var _sample_template = $("#_sample_template").clone();
                            _sample_template.find("tr").attr("id",samplingDetails[i].id);
                            _sample_template.find("._sampling_detail_id").attr("value",samplingDetails[i].id);
                            _sample_template.find("._food_id").attr("value",samplingDetails[i].foodId);
                            _sample_template.find("._food_name").text(samplingDetails[i].foodName);
                            _sample_template.find("._item_name").text(samplingDetails[i].itemName);
                            _sample_template.find("._item_name").attr("data-itemid",samplingDetails[i].itemId);
                            _sample_template.find("._sample_code").text(samplingDetails[i].sampleCode);
                            _sample_template.find("._print_num_text").text(samplingDetails[i].printCodeNum);
                            _sample_template.find("._code_time_text").text(samplingDetails[i].printCodeTime);//samplingDetails[i].printCodeTime
                            _sample_template.find("tr").addClass("_"+samplingDetails[i].id);
                            _sample_template.find("._print_btn").append("<button class=\"btn btn-primary\" type=\"button\" onclick=\"printSampleCode('"+samplingDetails[i].id+"');\">打印</button>");

                            //已收样、前处理、检测中或已检测等状态不可修改样品
                            if (tbSampling.isSampling || samplingDetails[i].tubeCode1 || samplingDetails[i].conclusion) {
                                //打印凭证
                                _sample_template.find("tr").addClass(samplingDetails[i].sampleCode);
                                //已检测
                                if (samplingDetails[i].conclusion) {
                                    _sample_template.find("._order_status").text("已检测");
                                    //检测中
                                }else if (samplingDetails[i].tubeCode1) {
                                    _sample_template.find("._order_status").text("检测中");
                                    //已收样
                                }else if(tbSampling.isSampling==2){
                                    _sample_template.find("._order_status").text("已收样");
                                    //待收样
                                }else {
                                    _sample_template.find("._order_status").text("待收样");
                                }
                            } else {
                                //待收样数量+1
                                collectNum++;
                                // _sample_template.find("._food_name").html("<span>"+samplingDetails[i].foodName+"</span><i class='icon iconfont icon-xiugai text-primary _edit_food'></i>");
                                _sample_template.find("tr").addClass("_to_submit");
                                //待收样
                                _sample_template.find("._order_status").text("待收样");
                            }

                            $("#_sample_table tbody").prepend(_sample_template.html());
                        }
                    }

                    //订单列表添加订单号
                    if ($("#_orders_no ._"+tbSampling.orderNumber).length == 0) {
                        if(collectNum>0){
                            //有待收样品
                            $("#_orders_no").append("<div class=\"search-code search-active _order_no _"+tbSampling.orderNumber+"\"><i class=\"icon iconfont icon-weiwancheng text-warning\"></i><span>"+tbSampling.orderNumber+"</span><i class=\"icon iconfont icon-you\"></i></div>");
                        }else{
                            $("#_orders_no").append("<div class=\"search-code search-active _order_no _"+tbSampling.orderNumber+"\"><i class=\"icon iconfont icon-wancheng text-success\"></i><span>"+tbSampling.orderNumber+"</span><i class=\"icon iconfont icon-you\"></i></div>");
                        }

                        //修改订单列表订单状态
                    } else {
                        if(collectNum == 0){
                            $("#_orders_no ._"+tbSampling.orderNumber+" i:first()").attr("class", "icon iconfont icon-wancheng text-success");
                        }
                    }

                    //更新序号
                    updateSerialNumber();
                    _sample_template.find("tr").addClass("_to_submit");
                }else{
                    if(data.obj){
                        tips(data.msg);
                    }else{
                        //清空订单列表
                        tips("找不到订单信息");
                    }

                }
            }
        });
    }
    //更新序号
    function updateSerialNumber(){
        var h = 1;
        $("#_sample_table ._serial_number").each(function(){
            $(this).text(h);
            h++;
        });
    }
    //根据送检人手机号查询订单
    var phoneOrderList; //订单数据
    function queryOrderByPhone(){
        var phone = $("#_query_phone").text();
        var _start_time = $("#_start_time").val();
        var _end_time = $("#_end_time").val();

        if(!phone){
            tips("请输入送检人联系电话");
            return;
        }else if(!_start_time || !_end_time){
            tips("请选择订单时间范围");
            return;
        }else if(newDate(_start_time).getTime() > newDate(_end_time).getTime()){
            tips("订单时间范围错误");
            return;
        }

        console.log("送检人联系电话:"+phone);
        phoneOrderList = "";
        $.ajax({
            url: "${webRoot}/newCollectSample/queryByPhone",
            type: "POST",
            data: {"phone":phone,"startTime":$("#_start_time").val(),"endTime":$("#_end_time").val()},
            dataType: "json",
            success: function(data){
                if(data && data.success && data.obj && data.obj.length > 0){
                    phoneOrderList = data.obj;
                    dealHtml(1);
                }else{
                    tips("找不到订单信息");
                }
            }
        });
    }
    var pageItemNum = 10;//每页数量
    function dealHtml(pageNum) {
        var num0 = phoneOrderList ? phoneOrderList.length:0;    //总记录数
        var num1 = Math.floor(num0 / pageItemNum);
        var num2 = num0 % pageItemNum;
        var num3 = num1 + (num2>0 ? 1:0);    //总页数
        //第一个按钮
        var htmlStr = '<li class="cs-distan">共'+num3+'页/'+num0+'条记录</li><li class="cs-disabled zz-distan"> ' +
            '            <a class="zz-b-nav-btn" onclick="dealHtml('+(pageNum-1)+')">‹</a> ' +
            '        </li>';

        //中间按钮
        if (pageNum<1){
            htmlStr += '<li>' +
                '            <a class="zz-b-nav-btn zz-current-btn" onclick="dealHtml(1)">1</a> ' +
                '       </li>';
            pageNum = 1;
        } else if (pageNum > num3) {
            htmlStr += '<li>' +
                '            <a class="zz-b-nav-btn zz-current-btn" onclick="dealHtml('+num3+')">'+num3+'</a> ' +
                '       </li>';
            pageNum = num3;
        } else {
            htmlStr += '<li>' +
                '            <a class="zz-b-nav-btn zz-current-btn" onclick="dealHtml('+pageNum+')">'+pageNum+'</a> ' +
                '       </li>';
        }
        //最后按钮
        htmlStr += '<li class="cs-next "> ' +
            '       <a class="zz-b-nav-btn" onclick="dealHtml('+(pageNum+1)+')">›</a> ' +
            '   </li>';

        $("#paging").html(htmlStr);
        $("#_orders_no").html("");
        if (phoneOrderList){
            var sNum = (pageNum-1) * pageItemNum;
            var eNum = pageNum*pageItemNum -1;
            $.each(phoneOrderList, function(index, value){
                if (index>=sNum && index<=eNum) {
                    if (index==0){
                        if(value.collectNum>0){ //有待收样品
                            $("#_orders_no").append('<div class="search-code search-active _order_no _'+value.orderNumber+'"> ' +
                                '            <i class="icon iconfont icon-weiwancheng text-warning"></i><span clas="show-not"></span><span>'+value.orderNumber+'</span><i class="icon iconfont icon-you"></i> ' +
                                '        </div>');
                        }else{
                            $("#_orders_no").append('<div class="search-code search-active _order_no _'+value.orderNumber+'"> ' +
                                '            <i class="icon iconfont icon-wancheng text-success"></i><span clas="show-not"></span><span>'+value.orderNumber+'</span><i class="icon iconfont icon-you"></i> ' +
                                '        </div>');
                        }
                        queryOrderByNo(value.samplingNo);
                    } else{
                        if(value.collectNum>0){ //有待收样品
                            $("#_orders_no").append('<div class="search-code _order_no _'+value.orderNumber+'"> ' +
                                '            <i class="icon iconfont icon-weiwancheng text-warning"></i><span clas="show-not"></span><span>'+value.orderNumber+'</span><i class="icon iconfont icon-you"></i> ' +
                                '        </div>');
                        }else{
                            $("#_orders_no").append('<div class="search-code _order_no _'+value.orderNumber+'"> ' +
                                '            <i class="icon iconfont icon-wancheng text-success"></i><span clas="show-not"></span><span>'+value.orderNumber+'</span><i class="icon iconfont icon-you"></i> ' +
                                '        </div>');
                        }
                    }
                }
            });
        }
    }
    //重置查询开始、结束时间
    function resetTime() {
        var date1 = new Date();
        var date2 = new Date(date1.getTime() - 6*24*60*60*1000);
        $("#_start_time").val(date2.format("yyyy-MM-dd"));
        $("#_end_time").val(date1.format("yyyy-MM-dd"));
    }
    /******************************************* 打印凭证 start *******************************************/

        //打印样品码
    var _samplingId;
    function printSampleCode(sampleDetailId){
        sendMessage="";
        if(sampleDetailId){
            let foodName=$("#_sample_table ._"+sampleDetailId).find("._food_name").text();
            let sampleCode=$("#_sample_table ._"+sampleDetailId).find("._sample_code").text();
            sendMessage = "SIZE 52mm,30mm\r\n" +
                "CODEPAGE UTF-8\r\n" +
                "DIRECTION 1\r\n" +
                "GAP 2 mm,0 mm\r\n"+
                "CLS\r\n" +
                "TEXT 140,10,\"TSS24.BF2\",0,2,2,\""+foodName+"\"\r\n" +
                "BARCODE 45,65,\"128\",100,0,0,2,2,\""+sampleCode+"\"\r\n"+
                "TEXT 35,170,\"TSS24.BF2\",0,2,2,\""+sampleCode+"\"\r\n"+
                "PRINT 1,1\r\nSOUND 5,100\r\n";
        }else{
            sendMessage += "SIZE 52mm,30mm\r\n" +
                "CODEPAGE UTF-8\r\n" +
                "DIRECTION 1\r\n" +
                "GAP 2 mm,0 mm\r\n";////SET CUTTER BATCH
            $("#_sample_table tbody tr").each(function (index, value) {
                let foodName=$(this).find("._food_name").text();
                let sampleCode=$(this).find("._sample_code").text()
                sendMessage += "CLS\r\n" +
                    "TEXT 140,10,\"TSS24.BF2\",0,2,2,\""+foodName+"\"\r\n" +
                    "BARCODE 45,65,\"128\",100,0,0,2,2,\""+sampleCode+"\"\r\n"+
                    "TEXT 35,170,\"TSS24.BF2\",0,2,2,\""+sampleCode+"\"\r\n"+
                    "PRINT 1,1\r\n";
            });
            sendMessage +="SOUND 5,100\r\n";
        }
        if(connectStatus!="已连接"){
            tips("打印机连接失败："+connectStatus);
        }else{
            sendCommand();
            savePrint(sampleDetailId);
        }
    }
    function savePrint(sampleDetailId){
        let sampleCode= sampleDetailId==undefined ? "" : $("#_sample_table ._"+sampleDetailId).find("._sample_code").text();
        $.ajax({
            type: "POST",
            url: "${webRoot}/newCollectSample/save",
            data: {"samplId":_samplingId,"sampleDetailId":sampleDetailId,"sampleCode":sampleCode},
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
