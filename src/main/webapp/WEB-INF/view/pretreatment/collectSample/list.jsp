<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/WEB-INF/view/pretreatment/resource.jsp" %>
<html>
<head>
    <title>快检服务云平台</title>
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
    </style>
</head>
<body style="background: #008ad4">
    <form id="_sample_form">
        <div class=" cs-form-table-he cs-form-table cs-font-top clearfix">
            <div class="zz-accept-title">
                <h2 class="col-md-6" style="margin: 0px;">
                    <%--<img src="${webRoot}/img/pfsystem/logo.png" style="width:40px;    margin-right: 5px;">达元快检数据预警分析软件--%>
                    <img src="${webRoot}/img/pfsystem/logo.png" style="width:40px;margin-right: 5px;" alt="" />${systemName}
                </h2>
                <div class="text-center center-text" style="position: absolute;width: 200px;left: 50%;top: 12px;margin-left: -100px;">收样登记</div>
                <!-- <div class="input-group input-group2" style="position: absolute;right:10px; top:0;">
                    <input type="text" class="form-control" id="_default_code_input" class="pull-right" style="width: 100%;text-transform:uppercase;" placeholder="请输入订单号或送检人手机号" onkeyup="this.value=this.value.toUpperCase()">
                    <span class="input-group-btn">
                    <button class="btn btn-primary" type="button" style="font-size: 16px;" id="_default_code_input_btn">查询</button>
                </span>
                </div> -->
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
                    <li><i class="icon iconfont icon-yiqianding"></i>应收样 <span class="_ying_shou_number">0</span>个</li>
                    <li><i class="icon iconfont icon-yiqianding"></i>已收样 <span class="_yi_shou_number">0</span>个</li>
                    <li><i class="icon iconfont icon-yiqianding"></i>未收样 <span class="_wei_shou_number">0</span>个</li>
                </ul>
                
              </div>
              <div class="input-group input-group2 pull-right" style="background: #fff;">
                <input type="text" class="form-control" id="_default_code_input" class="pull-right" style="width: 100%;text-transform:uppercase;" placeholder="请输入订单号或送检人联系电话" onkeyup="this.value=this.value.trim().toUpperCase()">
                    <span class="input-group-btn">
                    <button class="btn btn-primary" type="button" style="font-size: 16px;" id="_default_code_input_btn">确定</button>
                </span>
            </div>
            </div>
            
            

            <div style="position: absolute;left: 10px; top: 122px; width: 300px;bottom: 10px;background: #fff;box-shadow: 0 0 2px #ddd;overflow: auto;padding-top: 48px;padding-bottom: 40px;">

                <div style="position: absolute;top:0;width: 100%;height: 48px;line-height:48px;background:#13adff;font-size: 16px;color:#fff;text-align: center;font-weight: bold">订单号</div>
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
                    <%--
                    <div class="search-code search-active _order_no">
                        <i class="icon iconfont icon-wancheng text-success"></i><span clas="show-not"></span><span>Z201908120001</span><i class="icon iconfont icon-you"></i>
                    </div>
                    <div class="search-code _order_no">
                        <i class="icon iconfont icon-weiwancheng text-warning"></i><span clas="show-not"></span><span>Z201908120001</span><i class="icon iconfont icon-you"></i>
                    </div>
                    --%>
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

            <div class="zz-scan col-md-8" style="top: 256px;left: 312px; width:auto; right: 10px">

                <table id="_sample_table">
                    <thead>
                    <tr class="top-tr">
                        <th style="width:50px;">序号</th>
                        <th style="">送检样品</th>
                        <th style="width:200px;">检测项目</th>
                        <th style="width:210px;">样品条码</th>
                        <th style="width:176px;">收样时间</th>
                        <th style="width:90px;">状态</th>
                        <th style="width:80px;">打印凭证</th>
                        <%--
                        <th style="width:150px">食品来源</th>
                        <th style="width:150px">经营档口</th>
                        --%>
                    </tr>
                    </thead>

                    <tbody></tbody>
                </table>
                <div class="zz-scan3 col-md-4">
	                
	                <%--<div class="pull-left" style="margin-right:30px;"><i class="icon iconfont icon-dingdanquxiao"></i>未接收样品：<i class="text-danger">0</i> 个</div>--%>
	                <%--<div class="pull-left"><i class="icon iconfont icon-dingdanwancheng"></i>已接收样品：<i class="text-danger">0</i> 个</div>--%>

                    <%--<div class="pull-left">接收样品：<i class="text-danger" id="sampleNum">0</i> 个</div>--%>
                    <div id="_div_0" class="pull-right" style="padding: 10px;"><button type="button" class="btn btn-primary sure-btn" onclick="submitSampleForm();">确认</button></div>
                    <%--<div id="_print_proof_btn" class="pull-right" style="padding: 10px;display: none;"><button type="button" class="btn btn-primary sure-btn" onclick="printProof();">打印凭证</button></div>--%>
                </div>
            </div>

            <div class="zz-scan2 col-md-4" style="">

                <div style="position: absolute;top:0;width: 100%;height: 48px;line-height:48px;background:#13adff;font-size: 16px;color:#fff;text-align: center;font-weight: bold">订单信息</div>
                <%--<h3>订单信息</h3>--%>
                <div class="zz-scan-content">
                    <ul id="_sample_info" class="_to_submit clearfix">
                        <input type="hidden" name="tbSampling.id">
<%--                        <input type="hidden" name="tbSampling.regId">--%>
<%--                        <input type="hidden" name="tbSampling.regName">--%>
<%--                        <input type="hidden" name="tbSampling.regLinkPhone">--%>
                        <li>送检单号：<span class="_samplingNo"></span></li>
                        <li>下单时间：<span class="_samplingDate"></span></li>
                        <li>委托单位：<span class="_regName"></span><%--<a href="javascript:;" class="cs-menu-btn" href="#myModal-lg" data-toggle="modal" data-target="#_edit_reg_modal"><i class="icon iconfont icon-xiugai"></i></a>--%></li>
                    <%--<li>单位电话：<span class="_regLinkPhone"></span></li>--%>
                    <%--<li style="display: none;">送检单位：<span class="_inspectionUnitName"></span></li>--%>
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

    <%-- 一单一个委托单位 --%>
    <%--
    <div id="_edit_reg_modal" class="modal fade intro2" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog cs-mid-width">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">修改委托单位</h4>
                </div>
                <div class="modal-body cs-mid-height cs-dis-tab">
                    <ul class="cs-ul-form clearfix col-sm-12 col-md-12">
                        <li  class="cs-name col-sm-3 col-md-3"><i class="cs-mred">*</i>委托单位：</li>
                        <li class="zz-input col-sm-8 col-md-8">
                            <div class="cs-all-ps" style="width: 302px">
                                <button class="zz-clear-btn2" type="button"><i class="icon iconfont icon-close"></i></button>
                                <div class="cs-input-box">
                                    <input type="hidden"  name="_edit_reg_id" class="cs-input-id"/>
                                    <input type="hidden"  name="_edit_reg_phone" class="cs-input-id"/>
                                    <input type="text" id="inputDataReg" name="_edit_reg_name" class="cs-down-input inputData" autocomplete="off" placeholder="请输入首字母查找单位" />
                                </div>
                                <div class="cs-check-down" style="">
                                    <ul id="mySelectRegId" style="padding:0;">
                                    </ul>
                                </div>
                            </div>
                        </li>
                    </ul>
                </div>
                <div class="modal-footer" style="text-align:center; padding:10px; height: auto">
                    <button type="button" id="_save_reg" class="btn btn-primary btn-ok">确定</button>
                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                </div>
            </div>
        </div>
    </div>
    --%>

    <table style="display: none;">
        <tbody id="_sample_template">
            <tr>
                <input type="hidden" class="_sampling_detail_id" >
                <input type="hidden" class="_food_id" >
                <input type="hidden" class="_food_name" >
                <%--<input type="hidden" class="_code_time" >--%>
                <td class="_serial_number"></td>
                <td class="_food_name"></td>
                <td class="_item_name" data-itemid=""></td>
                <td style="text-align: left;padding-left: 20px;">
                    <input class="zz-form-input _bag_code _code_input" type="text" readonly="readonly" oncontextmenu="return false;" onpaste="return false;">

                    <i class="icon iconfont icon-xiugai _edit_code"></i>
                    <i class="icon iconfont icon-close text-danger"></i>
                </td>
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
    
    
    
    
<!-- 一单多个委托单位 -->
<div class="modal fade intro2" id="_edit_reg_modal1" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
 <div class="modal-dialog cs-xlg-width" role="document">
    <div class="modal-content" style="margin-top: 0px;">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
        <h4 class="modal-title" id="myModalLabel">委托单位管理</h4>
      </div>
      <div class="modal-body cs-xlg-height">
        <div class="cs-points-list" style="width:49%;">
          <div class="cs-mechanism-tab">
              <span class="cs-fl cs-font-weight">待选择委托单位：</span>
              <div class="cs-search-box pull-right">
                  <form>
                      <div class="cs-search-margin clearfix pull-left">
                          <input id="_query_unit" class="cs-input-cont pull-left" type="text" placeholder="请输入单位名称">
                          <input type="button" class="cs-search-btn pull-left" href="javascript:;" value="搜索" onclick="queryUnit();" >
                      </div>
                  </form>
              </div>
          </div>
        <div class="cs-mechanism-list-content" style="padding:0;">
        <div class="cs-mechanism-list-search clearfix">

        </div>
        <div class="cs-mechanism-table-box">
        <table class="cs-mechanism-table _query_req_units" width="100%">
          <tr>
            <th style="width: 40px;"><input type="checkbox" class="_qru_all" /></th>
            <th style="text-align: center;">委托单位</th>
          </tr>
          <%--<tr>
            <td><input type="checkbox" /></td>
            <td>
            广州市食品药品监督局
            </td>
          </tr>--%>
        </table>
        </div>
        </div>
        </div>


        <div class="cs-secleted-list" style="width:49%;">
          <div class="cs-mechanism-list-title">
          <span class="cs-fl cs-font-weight">已选择委托单位：</span>
              <span class="cs-title-tip text-muted _sel_unit_num"><span>0</span>/<span>0</span>个</span>
          <a class="pull-right cs-secleted-del" href="javascript:" onclick="delAllUnit();"><i class="text-del">清空</i></a>

          </div>
            <div class="cs-mechanism-list-content">
                <table class="cs-mechanism-table _selected_req_units" width="100%">
                    <%--<tr>
                        <td style="width: 30px;">1</td>
                        <td>
                            广州市食品药品监督局
                        </td>
                        <td class="tex-center"><a href="javascript:;"><span class="cs-icon-span"><i class="icon iconfont icon-shanchu text-danger"></i></span></a></td>
                    </tr>
                    --%>
                </table>
            </div>
        </div>
      </div>
      <div class="modal-footer">
      <button type="button" class="btn btn-success" onclick="saveUnit();">确定</button>
        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      </div>
    </div>
  </div>
</div>

    <%--  查看委托单位  --%>
    <%@include file="/WEB-INF/view/terminal/showUnitConfirm.jsp"%>
    <%--  提示框  --%>
    <%@include file="/WEB-INF/view/terminal/tips.jsp"%>


</body>
<script type="text/javascript" src="${webRoot}/js/printTicket.js"></script>
<script type="text/javascript" src="${webRoot}/js/scanner.js"></script>
<script type="text/javascript">
    //样品码
    var sampleRegExp = new RegExp("^(${sampleBarCode})([0-9A-Z])*$");
    //订单号
    var orderRegExp = new RegExp("^(${zdOrderCode}|${wxOrderCode})\\d{12,}$");
    //手机号
    var phoneRegExp = new RegExp("^1(3|4|5|6|7|8|9)\\d{9}$");

    //样品输入框事件
    var _selected_input;   //选中样品码输入框
    $(document).on("click","._code_input",function(event) {
        _selected_input = $(this);
        $("#_sample_table .select-input").removeClass("select-input");
        //$("#_sample_table ._selected_input0").removeClass("_selected_input0");
        $(this).addClass("select-input");
        $("._code_input").removeClass("info-disable");
    });

    //删除样品码
    $(document).on("click",".icon-close",function(event) {
        $(this).hide();
        var _this_code_input = $(this).siblings("._code_input");

        _this_code_input.removeClass("_"+_this_code_input.val());
        _this_code_input.val("");

        // _this_code_input.parent().siblings("._code_time").val("");
        // _this_code_input.parent().siblings("._code_time_text").text("");
        _this_code_input.click();
    });

    //点击订单号
    $(document).on("click","._order_no",function(event) {
        $("._order_no").removeClass("search-active");
        $(this).addClass("search-active");
        queryOrderByNo($(this).find("span").text());
    });

    //提示不能修改样品信息
    // $(document).on("click","._not_modify",function(event) {
    //     tips("不能修改样品信息");
    // });

    //输入订单号、联系电话或样品码
    $(document).on("keypress","#_default_code_input",function(event) {
        // console.log("_default_code_input keypress:"+String.fromCharCode(event.keyCode));
        if(event.keyCode == 13){    //回车
            if($(this).val()){
                //获取扫描条码
                var thisCode = $(this).val().toUpperCase();
                $(this).val("");   //扫描完成后立刻清除

                //校验条码
                checkCode(thisCode);
            }
        }
    });

    //查询输入框确认按钮事件
    $(document).on("click","#_default_code_input_btn",function(event) {
        if($("#_default_code_input").val()){
            //获取输入值
            var thisCode = $("#_default_code_input").val().toUpperCase();
            $("#_default_code_input").val("");

            //校验输入值
            checkCode(thisCode);
        }
    });

    //扫描枪输入事件
    $(function () {
        scanner.open({
            scanFunction: function (scanText) {
                // console.log("扫描文字："+scanText);
                //校验条码
                checkCode(scanText);
            }
        });
    });

    /***************************** 手动输入方式修改样品条码 - 开始 *****************************/
    var selEleVal;    //修改前Value
    $(document).on("click","._edit_code",function(event) {
        selEleVal = $(this).siblings("._code_input").val();
        console.log("selEleVal:"+selEleVal);
        $(this).siblings("._code_input").addClass("_edit_sample_code");
        $(this).siblings("._code_input").attr("readonly",false);
        $(this).siblings("._code_input").click(); //模拟输入框点击
        $(this).siblings("._code_input").focus();
    });
    $(document).on("blur","._edit_sample_code",function(event) {
        var selEle = $(this);
        //清空
        if (!selEle.val()) {
            selEle.removeClass("_"+selEleVal);
        //没修改样品码
        } else if (selEleVal == selEle.val()) {

        } else if(sampleRegExp.test(selEle.val())) {
            //页面验证样品码是否已使用
            if ($("._"+selEle.val()).length>0){
                var _tr0 = $("._"+selEle.val()+":eq(0)").parents("tr");
                //已收样
                if (_tr0.find("._code_time_text").text()){
                    tips("样品码已被使用");
                    selEle.val(selEleVal);

                //未收样
                } else {
                    var _tr0_food_id = _tr0.find("._food_id").val();
                    //样品不一样
                    if (_tr0_food_id != _selected_input.parents("tr").find("._food_id").val()) {
                        tips("样品码已被使用");
                        selEle.val(selEleVal);
                    }
                }

            } else {
                //后台查询样品码是否已使用
                $.ajax({
                    url: "${webRoot}/pretreatment/queryByBarCode",
                    type: "POST",
                    data: {"barcode":selEle.val()},
                    dataType: "json",
                    async: false,
                    success: function(data){
                        if(data && data.success && data.obj){
                            if(!data.obj.samplingDetails || data.obj.samplingDetails.length == 0){
                                selEle.removeClass("_"+selEleVal);
                                selEle.addClass("_"+selEle.val());
                                selEle.siblings(".icon-close").show();

                            } else {
                                tips("样品码已被使用");
                                selEle.val(selEleVal);
                            }
                        }else{
                            tips("样品码校验失败");
                            selEle.val(selEleVal);
                        }
                    }
                });
            }

        } else {
            tips("请输入正确样品码");
            selEle.val(selEleVal);
        }

        selEle.attr("readonly","readonly");
        selEleVal = "";
    });
    /***************************** 手动输入方式修改样品条码 - 结束 *****************************/

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
            url: "${webRoot}/collectSample/statistic",
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


    /******************************************* 修改样品、委托单位 start *******************************************/
    var foodList;
    var editFoodTr;
    $(document).on("click","._edit_food",function(event) {
        // if (!$(this).parents("tr").find("._bag_code").val()){
        //     tips("请先输入样品条码");
        //     return;
        // }
        editFoodTr = $(this).parents("tr");
        $("input[name='_edit_food_id']").val("");
        $("input[name='_edit_food_name']").val("");
        $("#inputDataFood").val("");
        $("#_edit_food_modal").modal("show");
        var itemId = $(this).parents("tr").find("._item_name").attr("data-itemid");
        $.ajax({
            type: "POST",
            url: "${webRoot}/data/foodType/queryFoodByItemId",
            data: {"itemId":itemId},
            dataType: "json",
            success: function(data){
                if(data && data.success){
                    foodList = data.obj;
                    detalHtml(1, foodList);
                }
            }
        });
    });

    /*一单一个委托单位*/
    <%--var requesterUnits;--%>
    <%--$(function () {--%>
    <%--    $.ajax({--%>
    <%--        type: "POST",--%>
    <%--        url: "${webRoot}/requester/unit/queryAll",--%>
    <%--        dataType: "json",--%>
    <%--        success: function(data){--%>
    <%--            if(data && data.success){--%>
    <%--                requesterUnits = data.obj;--%>
    <%--            }--%>
    <%--        }--%>
    <%--    });--%>
    <%--});--%>
    <%--$(document).on("click","._edit_reg",function(event) {--%>
    <%--    //提示不能修改委托单位--%>
    <%--    if ($("._not_modify").length>0){--%>
    <%--        tips("不能修改委托单位");--%>

    <%--        //修改委托单位--%>
    <%--    }else {--%>
    <%--        $("input[name='_edit_reg_id']").val("");--%>
    <%--        $("input[name='_edit_reg_name']").val("");--%>
    <%--        $("input[name='_edit_reg_phone']").val("");--%>
    <%--        $("#_edit_reg_modal").modal("show");--%>
    <%--        detalHtml(0, requesterUnits);--%>
    <%--    }--%>
    <%--});--%>

    $(".inputData").on("keyup",function(e){
        var currentId=$(this).attr("id");
        var keyWordStr=$(this).val().trim();
        switch (currentId) {
            case "inputDataReg":
                if(keyWordStr!=''){
                    queryOption=searchData(currentId,keyWordStr,requesterUnits);
                    queryOption.sort(function (a,b){
                        return a.requesterName.length-b.requesterName.length;
                    });
                }else{
                    queryOption=requesterUnits;
                }
                detalHtml(0,queryOption);
                break;
            case "inputDataFood":
                if(keyWordStr!=''){
                    queryOption=searchData(currentId,keyWordStr,foodList);
                    queryOption.sort(function (a,b){
                        return a.foodName.length-b.foodName.length;
                    });
                }else{
                    queryOption=foodList;
                }
                detalHtml(1, queryOption);
                break;
            default:
                break;
        }
    });
    //页面拼接出来
    function detalHtml(type,data){
        switch (type) {
            /*一单一个委托单位*/
            // case 0://拼接处理委托单位信息
            //     $("#mySelectRegId").empty();
            //     var html='';
            //     var json=eval(data);
            //     $.each(json, function (index, item) {
            //         html += '<li data-id="'+item.id+'" data-requesterName="'+item.requesterName+'" data-linkPhone="'+item.linkPhone+'">'+item.requesterName+'</li>';
            //     });
            //     $("#mySelectRegId").append(html);
            //     break;
            case 1://拼接处理样品信息
                $("#myFoodSelect").empty();
                var html='';
                var json=eval(data);
                $.each(json, function (index, item) {
                    html += '<li data-id="'+item.id+'" data-foodName="'+item.foodName+'" >'+item.foodName;
                    if(item.foodNameOther!='' ){
                        html+='&nbsp;['+item.foodNameOther+']';
                    }
                    html+='</li>';
                });
                $("#myFoodSelect").append(html);
                break;
            default:
                break;
        }
    }
    //根据用户输入关键首字母查询数据
    function searchData(currentSelect2Id,keyWord,dataList){
        var queryOption=[];
        $("#"+currentSelect2Id+"").empty("");
        var keyWordStr=keyWord.toUpperCase();
        $.each(dataList, function (index, item) {
            if(currentSelect2Id=="inputDataReg"){//委托单位处理
                if(item.requesterFirstLetter==keyWordStr){//首字母开头全匹配
                    queryOption.push(item);
                }else if(item.requesterFirstLetter.indexOf(keyWordStr)==0){//匹配首字母开头
                    queryOption.push(item);
                }else if(item.requesterFirstLetter.indexOf(keyWordStr)>-1){//匹配非首字母开头
                    queryOption.push(item);
                }else if(item.requesterFullLetter==keyWord.toUpperCase()){//匹配全拼音
                    queryOption.push(item);
                }else if(item.requesterFullLetter.indexOf(keyWordStr)>-1){//模糊匹配全拼音
                    queryOption.push(item);
                }else if(item.requesterName.indexOf(keyWordStr)>-1){//模糊匹配全称
                    queryOption.push(item);
                }
            }else if(currentSelect2Id=="inputDataFood") {//样品
                if(item.foodFirstLetter==keyWordStr){//首字母开头全匹配
                    queryOption.push(item);
                }else if(item.foodFirstLetter.indexOf(keyWordStr)==0){//匹配首字母开头
                    queryOption.push(item);
                }else if(item.foodFirstLetter.indexOf(keyWordStr)>-1){//匹配非首字母开头
                    queryOption.push(item);
                }else if(item.foodFullLetter==keyWord.toUpperCase()){//匹配全拼音
                    queryOption.push(item);
                }else if(item.foodName.indexOf(keyWordStr)>-1){//模糊匹配全称
                    queryOption.push(item);
                }
            }
        });
        return queryOption;
    }

    $(document).on("click","#myFoodSelect li",function(event) {
        $("input[name='_edit_food_id']").val($(this).attr("data-id"));
        $("input[name='_edit_food_name']").val($(this).attr("data-foodname"));
        $("#inputDataFood").val($(this).attr("data-foodname"));
    });
    $(document).on("click","#_save_food",function(event) {
        if(editFoodTr){
            editFoodTr.removeClass("_"+editFoodTr.find("._food_id").val());
            editFoodTr.addClass("_"+$("input[name='_edit_food_id']").val());

            editFoodTr.find("._food_id").val($("input[name='_edit_food_id']").val());
            editFoodTr.find("._food_name").val($("input[name='_edit_food_name']").val());
            editFoodTr.find("._food_name span").text($("input[name='_edit_food_name']").val());

            editFoodTr.find("._code_input").removeClass("_"+editFoodTr.find("._code_input").val());
            editFoodTr.find("._code_input").val("");
            editFoodTr.find(".icon-close").hide();
        }
        $("#_edit_food_modal").modal("hide");
    });

    /*一单一个委托单位*/
    // $(document).on("click","#mySelectRegId li",function(event) {
    //     $("input[name='_edit_reg_id']").val($(this).attr("data-id"));
    //     $("input[name='_edit_reg_name']").val($(this).attr("data-requestername"));
    //     $("input[name='_edit_reg_phone']").val($(this).attr("data-linkphone"));
    // });
    // $(document).on("click","#_save_reg",function(event) {
    //     $("#_sample_info input[name='tbSampling.regId']").val($("input[name='_edit_reg_id']").val());
    //     $("#_sample_info input[name='tbSampling.regName']").val($("input[name='_edit_reg_name']").val());
    //     $("#_sample_info input[name='tbSampling.regLinkPhone']").val($("input[name='_edit_reg_phone']").val());
    //     $("#_sample_info ._regName").html("<span>"+$("input[name='_edit_reg_name']").val()+"</span><i class='icon iconfont icon-xiugai text-primary _edit_reg'></i>");
    //     // $("#_sample_info ._regLinkPhone").text($("input[name='_edit_reg_phone']").val());
    //     $("#_edit_reg_modal").modal("hide");
    // });





    /*一单多个委托单位*/
    $(document).on("click","._edit_reg",function(event) {
        //提示不能修改委托单位
        if ($("._not_modify").length>0){
            tips("不能修改委托单位");

        //修改委托单位
        }else {
            $("#_edit_reg_modal1").modal("show");
            // detalHtml(0, requesterUnits);
        }
    });

    //已选择的委托单位HTML，未确认关闭窗口后还原页面
    var selUnitsHtml;
    //订单原委托单位
    var rUnits;
    //用户选择过的委托单位
    var rUnitsHis;
    //打开委托单位窗口
    $("#_edit_reg_modal1").on('show.bs.modal', function () {
        //停用历史委托单位 --Dz 20200111
        // queryHisUnit();
        queryUnit();

        //已选择的委托单位HTML，未确认关闭窗口后还原页面
        selUnitsHtml = $("#_edit_reg_modal1 ._selected_req_units").html();
    });
    //关闭委托单位窗口
    $("#_edit_reg_modal1").on('hide.bs.modal', function () {
        //未确认关闭窗口后还原页面
        if(selUnitsHtml){
            $("#_edit_reg_modal1 ._selected_req_units").html(selUnitsHtml);
        }
        //已选择数量
        $("#_edit_reg_modal1 ._sel_unit_num span:eq(0)").text($("#_edit_reg_modal1 ._selected_req_units tr").length);
    });
    //确认保存委托单位
    function saveUnit() {
        if (parseInt($("#_edit_reg_modal1 ._sel_unit_num span:eq(0)").text()) != parseInt($("#_edit_reg_modal1 ._sel_unit_num span:eq(1)").text())) {
            alert("委托单位数量必须与下单的委托单位数量一致");
            return false;
        }
        //清空还原html
        selUnitsHtml = "";
        $("#_edit_reg_modal1").modal("hide");
    }
    //停用历史委托单位 --Dz 20200111
    //查询历史委托单位
    function queryHisUnit() {
        $("#_query_unit").val("");
        $("#_edit_reg_modal1 ._query_req_units tr:gt(0)").remove();
        if(rUnitsHis) {
            //历史委托单位
            for(var i=0;i<rUnitsHis.length;i++){
                $("#_edit_reg_modal1 ._query_req_units").append("" +
                    "<tr>\n" +
                    "    <td><input class=\"_qru_"+rUnitsHis[i].id+"\" type=\"checkbox\" data-id=\""+rUnitsHis[i].id+"\" data-name=\""+rUnitsHis[i].requesterName+"\"/></td>\n" +
                    "    <td>"+rUnitsHis[i].requesterName+"</td>\n" +
                    "</tr>");
            }
            //勾选委托单位
            $("#_edit_reg_modal1 ._selected_req_units tr").each(function (index, value){
                var selUnitId0 = $(this).attr("data-id");
                $("#_edit_reg_modal1 ._query_req_units ._qru_"+selUnitId0).prop("checked",true);
            });
        }
    }

    //所有委托单位
    var allUnits;
    //查询委托单位
    function queryUnit(){
        //查询委托单位名称
        var queryUnitName = $("#_query_unit").val();
        if(!allUnits) {
            $.ajax({
                url: "${webRoot}/wx/order/getRequesterUnitsForTerminal",
                type: "POST",
                data: {},
                dataType: "json",
                async: false,
                success: function(data){
                    if(data && data.success){
                        allUnits = data.obj;
                    }
                }
            });
        }
        if (queryUnitName){
            $("#_edit_reg_modal1 ._query_req_units tr:gt(0)").remove();

            //显示符合条件的委托单位
            for (var i=0;i<allUnits.length;i++){
                if(allUnits[i].requesterName.indexOf(queryUnitName) != -1) {

                    $("#_edit_reg_modal1 ._query_req_units").append("" +
                        "<tr>\n" +
                        "    <td><input class=\"_qru_"+allUnits[i].id+"\" type=\"checkbox\" data-id=\""+allUnits[i].id+"\" data-name=\""+allUnits[i].requesterName+"\" data-phone=\""+allUnits[i].linkPhone+"\" data-address=\""+allUnits[i].companyAddress+"\"/></td>\n" +
                        "    <td>"+allUnits[i].requesterName+"</td>\n" +
                        "</tr>");
                }
            }
            //勾选委托单位
            $("#_edit_reg_modal1 ._selected_req_units tr").each(function (index, value){
                var selUnitId0 = $(this).attr("data-id");
                $("#_edit_reg_modal1 ._query_req_units ._qru_"+selUnitId0).prop("checked",true);
            });

        } else {
            //停用历史委托单位 --Dz 20200111
            // //显示历史委托单位
            // queryHisUnit();

            //*******************默认显示50个委托单位，通过单位名称查询查看更多*******************//
            //清空委托单位
            $("#_edit_reg_modal1 ._query_req_units tr:gt(0)").remove();
            //显示符合条件的委托单位
            for (var i=0;i<allUnits.length && i<50;i++){
                if(allUnits[i].requesterName.indexOf(queryUnitName) != -1) {

                    $("#_edit_reg_modal1 ._query_req_units").append("" +
                        "<tr>\n" +
                        "    <td><input class=\"_qru_"+allUnits[i].id+"\" type=\"checkbox\" data-id=\""+allUnits[i].id+"\" data-name=\""+allUnits[i].requesterName+"\" data-phone=\""+allUnits[i].linkPhone+"\" data-address=\""+allUnits[i].companyAddress+"\"/></td>\n" +
                        "    <td>"+allUnits[i].requesterName+"</td>\n" +
                        "</tr>");
                }
            }
            //勾选委托单位
            $("#_edit_reg_modal1 ._selected_req_units tr").each(function (index, value){
                var selUnitId0 = $(this).attr("data-id");
                $("#_edit_reg_modal1 ._query_req_units ._qru_"+selUnitId0).prop("checked",true);
            });

        }
    }

    $(document).on("change","#_edit_reg_modal1 ._query_req_units input[type='checkbox']",function(event) {
        //选择状态
        var selectStatus = $(this).prop("checked");

        //全选
        if($(this).hasClass("_qru_all")) {
            $("#_edit_reg_modal1 ._query_req_units input[type='checkbox']").prop("checked", selectStatus);
            //选中
            if (selectStatus) {
                $("#_edit_reg_modal1 ._query_req_units input[type='checkbox']:gt(0)").each(function(index, value){
                    addUnit($(this).attr("data-id"), $(this).attr("data-name"), $(this).attr("data-phone"), $(this).attr("data-address"));
                });

            //取消
            } else {
                $("#_edit_reg_modal1 ._query_req_units input[type='checkbox']:gt(0)").each(function(index, value){
                    delUnit($(this).attr("data-id"));
                });
            }

        //单独
        } else {
            //选中
            if (selectStatus) {
                addUnit($(this).attr("data-id"), $(this).attr("data-name"), $(this).attr("data-phone"), $(this).attr("data-address"));

            //取消
            } else {
                delUnit($(this).attr("data-id"));
            }
        }
    });

    //已选择委托单位
    function addUnit(id, name, phone,address) {
        if($("#_edit_reg_modal1 ._selected_req_units ._sel_unit_"+id).length == 0){
            var selUnitMaxLength = $("#_edit_reg_modal1 ._selected_req_units tr").length + 1;
            $("#_edit_reg_modal1 ._selected_req_units").append("" +
                "<tr class='_sel_unit_"+id+"' data-id='"+id+"' data-name='"+name+"' data-phone='"+phone+"' data-address='"+address+"'>\n" +
                "    <td style=\"width: 30px;\">"+selUnitMaxLength+"</td>\n" +
                "    <td>"+name+"</td>\n" +
                "    <td class=\"tex-center\">\n" +
                "        <a href=\"javascript:;\">\n" +
                "            <span class=\"cs-icon-span\">\n" +
                "                <i class=\"icon iconfont icon-shanchu text-danger\" onclick=\"delUnit('"+id+"')\"></i>\n" +
                "            </span>\n" +
                "        </a>\n" +
                "    </td>\n" +
                "</tr>");
            $("#_edit_reg_modal1 ._sel_unit_num span:eq(0)").text(selUnitMaxLength);
        }

        //勾上全选
        if ($("#_edit_reg_modal1 ._query_req_units :checked").length == $("#_edit_reg_modal1 ._query_req_units input[type='checkbox']:gt(0)").length) {
            $("#_edit_reg_modal1 ._query_req_units ._qru_all").prop("checked", true);
        }
    }
    //删除全部委托单位
    function delAllUnit() {
        $("#_edit_reg_modal1 ._selected_req_units tr").each(function(index, value){
            delUnit($(this).attr("data-id"));
        });
    }
    //删除委托单位
    function delUnit(id) {
        if ($("#_edit_reg_modal1 ._query_req_units ._qru_"+id).length > 0) {
            $("#_edit_reg_modal1 ._query_req_units ._qru_"+id).prop("checked", false);
            $("#_edit_reg_modal1 ._query_req_units ._qru_all").prop("checked", false);
        }

        $("#_edit_reg_modal1 ._selected_req_units ._sel_unit_"+id).remove();
        $("#_edit_reg_modal1 ._selected_req_units tr").each(function(index, value){
            $(this).find("td:eq(0)").text(index+1);
        });
        $("#_edit_reg_modal1 ._sel_unit_num span:eq(0)").text($("#_edit_reg_modal1 ._selected_req_units tr").length);

    }


    /******************************************* 修改样品、委托单位 end *******************************************/

    /******************************************* 根据联系电话查询订单 start *******************************************/

    resetTime();
    //重置查询开始、结束时间
    function resetTime() {
        var date1 = new Date();
        var date2 = new Date(date1.getTime() - 6*24*60*60*1000);
        $("#_start_time").val(date2.format("yyyy-MM-dd"));
        $("#_end_time").val(date1.format("yyyy-MM-dd"));
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
            url: "${webRoot}/collectSample/queryByPhone",
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

    //订单分页
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
                            $("#_orders_no").append('<div class="search-code search-active _order_no _'+value.samplingNo+'"> ' +
                                '            <i class="icon iconfont icon-weiwancheng text-warning"></i><span clas="show-not"></span><span>'+value.samplingNo+'</span><i class="icon iconfont icon-you"></i> ' +
                                '        </div>');
                        }else{
                            $("#_orders_no").append('<div class="search-code search-active _order_no _'+value.samplingNo+'"> ' +
                                '            <i class="icon iconfont icon-wancheng text-success"></i><span clas="show-not"></span><span>'+value.samplingNo+'</span><i class="icon iconfont icon-you"></i> ' +
                                '        </div>');
                        }
                        queryOrderByNo(value.samplingNo);
                    } else{
                        if(value.collectNum>0){ //有待收样品
                            $("#_orders_no").append('<div class="search-code _order_no _'+value.samplingNo+'"> ' +
                                '            <i class="icon iconfont icon-weiwancheng text-warning"></i><span clas="show-not"></span><span>'+value.samplingNo+'</span><i class="icon iconfont icon-you"></i> ' +
                                '        </div>');
                        }else{
                            $("#_orders_no").append('<div class="search-code _order_no _'+value.samplingNo+'"> ' +
                                '            <i class="icon iconfont icon-wancheng text-success"></i><span clas="show-not"></span><span>'+value.samplingNo+'</span><i class="icon iconfont icon-you"></i> ' +
                                '        </div>');
                        }
                    }
                }
            });
        }
    }

    /******************************************* 根据联系电话查询订单 end *******************************************/


    /******************************************* 打印凭证 start *******************************************/

    //打印收样凭证
    var _samplingId;
    function printProof(_collectCode){
        var orderNo = $("#_sample_info ._samplingNo").text();   //订单号
        var samplingUsername = $("#_sample_info ._samplingUsername").text();   //送检人员
        // var samplingDate = $("#_sample_info ._samplingDate").text();   //下单时间
        var collectTime = new Date().format("yyyy-MM-dd HH:mm:ss");    //送样时间
        var wtdw = $("#_sample_info ._regName").text();    //委托单位名称
        // var sjdw = $("#_sample_info ._inspectionUnitName").text();    //送检单位名称
        var qrcode = "${webRoot}/collectSample/detail?samplingId="+_samplingId+"&collectCode="+_collectCode;

        var n0 = 10;    //除标题外，每行文字最大长度
        var wtdwArr = [];
        if (wtdw.length <= n0){
            wtdwArr[0] = wtdw;
        } else {
            var n1 = Math.floor(wtdw.length/n0);
            var n2 = wtdw.length%n0;
            var n3 = n1 + (n2>0 ? 1:0); //行数

            for (var i=0; i<n3; i++){
                var n4 = (i+1)*n0;  //每行最后文字下标
                n4 = n4 >= wtdw.length ? wtdw.length : n4;
                wtdwArr[i] = wtdw.substring( i*n0, n4);
            }
        }

        // var sjdwArr = [];
        // if (sjdw.length <= n0){
        //     sjdwArr[0] = sjdw;
        // } else {
        //     var n1 = Math.floor(sjdw.length/n0);
        //     var n2 = sjdw.length%n0;
        //     var n3 = n1 + (n2>0 ? 1:0); //行数
        //
        //     for (var i=0; i<n3; i++){
        //         var n4 = (i+1)*n0;  //每行最后文字下标
        //         n4 = n4 >= sjdw.length ? sjdw.length : n4;
        //         sjdwArr[i] = sjdw.substring( i*n0, n4);
        //     }
        // }


        var _width = 58; //纸张宽度(mm)
        var _hight = 0; //纸张高度(mm)
        var _line_hight = 50;   //行高(mm)
        var _text_left = 30;   //左边距(mm)

        sendMessage = "CODEPAGE UTF-8\r\n" +
            "DIRECTION 1\r\n" +
            "CLS\r\n" +
            "TEXT "+_text_left+",20,\"TSS24.BF2\",0,1.8,2,\"************送样凭证************\"\r\n" +
            "TEXT "+_text_left+",80,\"TSS24.BF2\",0,1,1,\"订单编号："+orderNo+"\"\r\n";

        _hight = 80;
        // //一单多用 收样凭证不显示委托单位 --Dz 20200114
        // if (wtdwArr && wtdwArr.length>0){
        //     for (var j=0; j<wtdwArr.length; j++){
        //         _hight = _hight + _line_hight;
        //         if (j==0){
        //             sendMessage+="TEXT "+_text_left+","+_hight+",\"TSS24.BF2\",0,1,1,\"委托单位："+wtdwArr[j]+"\"\r\n";
        //         } else {
        //             sendMessage+="TEXT "+(_text_left+120)+","+_hight+",\"TSS24.BF2\",0,1,1,\""+wtdwArr[j]+"\"\r\n";
        //         }
        //
        //     }
        // }

        // if (sjdwArr && sjdwArr.length>0){
        //     for (var j=0; j<sjdwArr.length; j++){
        //         _hight = _hight + _line_hight;
        //         if (j==0){
        //             sendMessage+="TEXT 60,"+_hight+",\"TSS24.BF2\",0,1,1,\"送检单位："+sjdwArr[j]+"\"\r\n";
        //         } else {
        //             sendMessage+="TEXT 180,"+_hight+",\"TSS24.BF2\",0,1,1,\""+sjdwArr[j]+"\"\r\n";
        //         }
        //
        //     }
        // }

        _hight = _hight + _line_hight;
        sendMessage+="TEXT "+_text_left+","+_hight+",\"TSS24.BF2\",0,1,1,\"样品名称\"\r\n" +
            "TEXT "+(_text_left+140)+","+_hight+",\"TSS24.BF2\",0,1,1,\"检测项目\"\r\n";

        sendMessage+="BAR "+_text_left+","+(_hight + 40)+",380,1\r\n";

        //获取本次收样样品信息
        // $("#_sample_table ._to_submit").each(function (index, value) {
        $("#_sample_table ."+_collectCode).each(function (index, value) {
        	
           

        	
        
            var _code_0 = $(this).find("._bag_code").val();
            if(_code_0){
                _hight = _hight + _line_hight;
                sendMessage+="TEXT "+_text_left+","+_hight+",\"TSS24.BF2\",0,1,1,\""+$(this).find("._food_name").text()+"\"\r\n" +
                    "TEXT "+(_text_left+140)+","+_hight+",\"TSS24.BF2\",0,1,1,\""+$(this).find("._item_name").text().substring(0,10)+"\"\r\n";
                _hight = _hight + _line_hight-20;  
                
                var item_name = $(this).find("._item_name").text()
                if(item_name.length>10){
                	var i ;
                	i=item_name.substring(10,item_name.length);
                    
                sendMessage+="TEXT "+_text_left+","+_hight+",\"TSS24.BF2\",0,1,1,\""+"\"\r\n" +
                "TEXT "+(_text_left+140)+","+_hight+",\"TSS24.BF2\",0,1,1,\""+i+"\"\r\n";
              }
            }
        });

        sendMessage+="BAR "+_text_left+","+(_hight + 40)+",380,1\r\n";

        _hight = _hight + _line_hight;
        sendMessage+="TEXT "+_text_left+","+_hight+",\"TSS24.BF2\",0,1,1,\"送检人员："+samplingUsername+"\"\r\n";

        _hight = _hight + _line_hight;
        sendMessage+="TEXT "+_text_left+","+_hight+",\"TSS24.BF2\",0,1,1,\"送样时间："+collectTime+"\"\r\n";

        _hight = _hight + _line_hight;
        // sendMessage+="TEXT 60,"+_hight+",\"TSS24.BF2\",0,1,1,\"取报告码："+_collectCode+"(三天有效)\"\r\n";
        sendMessage+="TEXT "+_text_left+","+_hight+",\"TSS24.BF2\",0,1,1,\"取报告码：\"\r\n";
        sendMessage+="TEXT "+(_text_left+118)+","+(_hight+5)+",\"3.EFT\",0,1,1,\""+_collectCode+"\"\r\n";
        sendMessage+="TEXT "+(_text_left+210)+","+_hight+",\"TSS24.BF2\",0,1,1,\"(三天有效)\"\r\n";

        _hight = _hight + _line_hight;
        sendMessage+="QRCODE "+(_text_left+50)+","+_hight+",M,6,A,0,M2,\""+qrcode+"\"\r\n";

        _hight = _hight + 270;
        sendMessage+="TEXT "+_text_left+","+_hight+",\"TSS24.BF2\",0,1,1,\"(请在微信或终端机扫码查看报告)\"\r\n";

        _hight = _hight + _line_hight;
        sendMessage+="PRINT 1,1\r\n" +
            "SOUND 5,100\r\n" +
            "CUT\r\n"+
            "OUT \"ABCDE\"\r\n";


        sendMessage = "SIZE "+_width+" mm, "+Math.floor(_hight/8)+" mm\r\n" + sendMessage;

        // console.log(sendMessage);

        sendCommand();
    }

    /******************************************* 打印凭证 end *******************************************/


    //校验条码
    function checkCode(thisCode){
        if (thisCode) {
            thisCode = thisCode.toUpperCase();

            //样品码
            if(sampleRegExp.test(thisCode)) {
                console.log("样品码:"+thisCode);

                //页面验证样品码是否已使用
                if ($("._"+thisCode).length>0){
                    var _tr0 = $("._"+thisCode+":eq(0)").parents("tr");
                    //已收样
                    if (_tr0.find("._code_time_text").text()){
                        tips("样品码已被使用");
                        return false;

                    //未收样
                    } else {
                        var _tr0_food_id = _tr0.find("._food_id").val();
                        //样品不一样
                        if (_tr0_food_id != _selected_input.parents("tr").find("._food_id").val()) {
                            tips("样品码已被使用");
                            return false;
                        }
                    }
                }

                //后台查询样品码是否已使用
                $.ajax({
                    url: "${webRoot}/pretreatment/queryByBarCode",
                    type: "POST",
                    data: {"barcode":thisCode},
                    dataType: "json",
                    success: function(data){
                        if(data && data.success && data.obj){
                            if(!data.obj.samplingDetails || data.obj.samplingDetails.length == 0){
                                writeTubeCode(thisCode);
                            } else {
                                tips("样品码已被使用");
                            }
                        }else{
                            tips("样品码校验失败");
                        }
                    }
                });

            //联系电话
            }else if (phoneRegExp.test(thisCode)) {
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
                tips("请输入订单号或送检人联系电话");
            }
        }
    }

    //录入样品码
    function writeTubeCode(vbarCode){
        if (_selected_input) {
            //写入样品码前再次查重验证，避免网络差的情况下出现样品码重复
            //页面验证样品码是否已使用
            if ($("._"+vbarCode).length>0){
                var _tr0 = $("._"+vbarCode+":eq(0)").parents("tr");
                //已收样
                if (_tr0.find("._code_time_text").text()){
                    // tips("样品码已被使用");
                    return false;

                    //未收样
                } else {
                    var _tr0_food_id = _tr0.find("._food_id").val();
                    //样品不一样
                    if (_tr0_food_id != _selected_input.parents("tr").find("._food_id").val()) {
                        // tips("样品码已被使用");
                        return false;
                    }
                }
            }

            // _selected_input.attr("value", vbarCode);
            if (_selected_input.val()) {
                _selected_input.removeClass("_"+_selected_input.val());
            }
            _selected_input.val(vbarCode);
            _selected_input.addClass("_"+vbarCode);

            _selected_input.siblings(".icon-close").show();

            // var nowStr = new Date().format("yyyy-MM-dd HH:mm:ss");
            // _selected_input.parent().siblings("._code_time").val(nowStr);
            // _selected_input.parent().siblings("._code_time_text").text(nowStr);

            var _entry_food_id = _selected_input.parents("tr").find("._food_id").attr("value");	//当前样品ID
            var _entry_item_name = _selected_input.parents("tr").find("._item_name").text();	//当前检测项目
            //一个样品多个项目，复制样品码到与当前样品ID相同并且为空的样品码中
            if($("._"+_entry_food_id).length>1){
                //写入样品码
                $("._"+_entry_food_id).each(function(index, value){
                    var _et_bag_code = $(this).find("._bag_code");
                    var _et_item_name = $(this).find("._item_name").text();
                    if(!_et_bag_code.val() && _entry_item_name != _et_item_name){

                        // _et_bag_codeattr("value", vbarCode);
                        _et_bag_code.val(vbarCode);
                        _et_bag_code.addClass("_"+vbarCode);

                        // _et_bag_code.parent().siblings("._code_time").val(nowStr);
                        // _et_bag_code.parent().siblings("._code_time_text").text(nowStr);

                        _et_bag_code.siblings(".icon-close").show();
                    }
                });
            }

            //跳到下一个录入框
            $("#_sample_table ._to_submit ._code_input").each(function (value, index) {
                if(!$(this).val()){
                    $(this).click();
                    return false;
                }
            });
        } else {
            tips("请先输入订单号");
        }
    }


    // //订单明细排序
    // var compare = function (prop1, prop2, prop3) {
    //     return function (obj1, obj2) {
    //         var val1 = obj1[prop1];
    //         var val2 = obj2[prop1];
    //         if (!val1) {
    //             return 1;
    //         } else if (!val2) {
    //             return -1;
    //         } else if (val1 < val2) {
    //             return -1;
    //         } else if (val1 > val2) {
    //             return 1;
    //         } else {
    //             var val3 = obj1[prop2];
    //             var val4 = obj2[prop2];
    //             if (val3 < val4) {
    //                 console.log(val3+" > "+val4+" : "+(val3 > val4));
    //                 return -1;
    //             } else if (val3 > val4) {
    //                 console.log(val3+" < "+val4+" : "+(val3 < val4));
    //                 return 1;
    //             } else {
    //                 var val5 = obj1[prop3];
    //                 var val6 = obj2[prop3];
    //                 console.log(val5+" > "+val6+" : "+(val5 > val6));
    //                 if (val5 < val6) {
    //                     return -1;
    //                 } else if (val5 > val6) {
    //                     return 1;
    //                 } else {
    //                     return 0;
    //                 }
    //             }
    //         }
    //     }
    // }

    function mySort(sl, props){
        for(var i in props){
            sl.sort(function (obj1, obj2) {
                // console.log("=========================================");
                if (i==0 || obj1[props[i-1]] == obj2[props[i-1]]) {
                    console.log(i);
                    var val1 = obj1[props[i]];
                    var val2 = obj2[props[i]];
                    // console.log("0:"+props[i]+";"+val1+";"+val2);
                    if (!val1) {
                        // console.log("1:"+val1+";"+val2+";return:1");
                        return 1;
                    } else if (!val2) {
                        // console.log("2:"+val1+";"+val2+";return:-1");
                        return -1;
                    } else if (val1 < val2) {
                        // console.log("3:"+val1+";"+val2+";return:1");
                        return 1;
                    } else if (val1 > val2) {
                        // console.log("4:"+val1+";"+val2+";return:-1");
                        return -1;
                    }
                }
            });
            // console.log(sl);
        }
    }

        //根据订单号查询订单
        function queryOrderByNo(orderNo, printCollectCode){
            $("#_sample_table tbody tr").remove();
            $("#_sample_info ._reg_info").remove();
            $("#_edit_reg_modal1 ._query_req_units tr:gt(0)").remove();
            $("#_edit_reg_modal1 ._selected_req_units tr").remove();

            //隐藏打印凭证按钮
            // $("#_print_proof_btn").hide();

            console.log("订单号:"+orderNo);

            //查询订单信息
            $.ajax({
                url: "${webRoot}/collectSample/queryBySamplingNo",
                type: "POST",
                data: {"samplingNo":orderNo},
                dataType: "json",
                success: function(data){
                    if(data && data.success && data.obj && data.obj.order){
                        var tbSampling = data.obj.order;
                        var samplingDetails = tbSampling.samplingDetails;

                        //订单委托单位
                        rUnits = data.obj.rUnits;
                        var rUnitsLength = !rUnits ? 0 : rUnits.length;

                        //停用历史委托单位 --Dz 20200111
                        //用户选择过的委托单位
                        // rUnitsHis = data.obj.rUnitsHis;

                        // var inspectionUnitName = data.obj.inspectionUnitName;

                        //样品排序
                        // samplingDetails.sort(compare("sampleTubeTime", "foodName", "itemName"));
                        mySort(samplingDetails, ["sampleTubeTime", "foodName", "itemName"]);

                        //订单ID
                        _samplingId = tbSampling.id;

                        var collectNum = 0;    //待收样数量

                        //订单信息
                        $("#_sample_info ._samplingNo").text(tbSampling.samplingNo);
                        // $("#_sample_info ._regLinkPhone").text(tbSampling.regLinkPhone);
                        // $("#_sample_info ._inspectionUnitName").text(inspectionUnitName);
                        $("#_sample_info ._samplingUsername").text(tbSampling.samplingUsername);
                        $("#_sample_info ._samplingDate").text(tbSampling.samplingDate);
                        $("#_sample_info ._inspectionFee").text("￥"+tbSampling.inspectionFee);
                        $("#_sample_info ._param3").text(tbSampling.param3);
                        $("#_sample_info input[name='tbSampling.id']").val(tbSampling.id);
                        // $("#_sample_info input[name='tbSampling.regId']").val(tbSampling.regId);
                        // $("#_sample_info input[name='tbSampling.regName']").val(tbSampling.regName);
                        // $("#_sample_info input[name='tbSampling.regLinkPhone']").val(tbSampling.regLinkPhone);

                        var collectCodes = new Set();

                        for(var i=0;i<samplingDetails.length;i++){
                            //样品明细
                            if($("#"+samplingDetails[i].id).length==0){
                                var _sample_template = $("#_sample_template").clone();
                                _sample_template.find("tr").attr("id",samplingDetails[i].id);
                                //_sample_template.find("tr").addClass("_"+samplingDetails[i].sampleTubeCode);

                                _sample_template.find("._sampling_detail_id").attr("value",samplingDetails[i].id);
                                _sample_template.find("._food_id").attr("value",samplingDetails[i].foodId);
                                _sample_template.find("._food_name").attr("value",samplingDetails[i].foodName);
                                _sample_template.find("._item_name").text(samplingDetails[i].itemName);
                                _sample_template.find("._item_name").attr("data-itemid",samplingDetails[i].itemId);
                                // _sample_template.find("._code_time").attr("value",samplingDetails[i].sampleTubeTime);
                                _sample_template.find("._code_time_text").text(samplingDetails[i].sampleTubeTime);
                                _sample_template.find("tr").addClass("_"+samplingDetails[i].foodId);



                                //已收样、前处理、检测中或已检测等状态不可修改样品
                                if (samplingDetails[i].sampleTubeCode || samplingDetails[i].tubeCode1 || samplingDetails[i].conclusion) {

                                    //送样码Set
                                    collectCodes.add(samplingDetails[i].collectCode);
                                    //打印凭证
                                    _sample_template.find("tr").addClass(samplingDetails[i].collectCode);
                                    _sample_template.find("._print_btn").append("<button class=\"btn btn-primary\" type=\"button\" onclick=\"printProof('"+samplingDetails[i].collectCode+"');\">打印</button>");

                                    _sample_template.find("._food_name").text(samplingDetails[i].foodName);
                                    //不可修改
                                    _sample_template.find("._code_input").addClass("_not_modify");
                                    //清除清空条码按钮
                                    _sample_template.find("._code_input").removeClass("_code_input");
                                    _sample_template.find("._bag_code").siblings(".icon-close").hide();

                                    _sample_template.find("._bag_code").addClass("_"+samplingDetails[i].sampleTubeCode);
                                    _sample_template.find("._bag_code").attr("value",samplingDetails[i].sampleTubeCode);

                                    _sample_template.find("._edit_code").remove();

                                    //已检测
                                    if (samplingDetails[i].conclusion) {
                                        _sample_template.find("._order_status").text("已检测");

                                        //检测中
                                    }else if (samplingDetails[i].tubeCode1) {
                                        _sample_template.find("._order_status").text("检测中");

                                        //已收样
                                    }else if(samplingDetails[i].sampleTubeCode){
                                        _sample_template.find("._order_status").text("已收样");

                                        //待收样
                                    }else {
                                        _sample_template.find("._order_status").text("待收样");
                                    }

                                } else {
                                    //待收样数量+1
                                    collectNum++;

                                    //未收样前可修改样品
                                    _sample_template.find("._food_name").html("<span>"+samplingDetails[i].foodName+"</span><i class='icon iconfont icon-xiugai text-primary _edit_food'></i>");
                                    _sample_template.find("tr").addClass("_to_submit");

                                    //待收样
                                    _sample_template.find("._order_status").text("待收样");

                                    // if (samplingDetails[i].sampleTubeCode) {
                                    //     _sample_template.find("._bag_code").attr("value",samplingDetails[i].sampleTubeCode);
                                    //     //显示清空条码按钮
                                    //     _sample_template.find("._bag_code").siblings(".icon-close").show();
                                    // }
                                }

                                // 隐藏食品来源、档口
                                // _sample_template.find("._supplier").text(samplingDetails[i].supplier);
                                // _sample_template.find("._ope_shop_name").text(samplingDetails[i].opeShopName);

                                $("#_sample_table tbody").prepend(_sample_template.html());
                            }
                        }

                        if (collectNum == samplingDetails.length) {
                            //未收样，提供编辑委托单位功能
                            $("#_sample_info ._regName").html("<span>"+rUnitsLength+"个</span>"
                                + "<i class='icon iconfont icon-xiugai text-primary _edit_reg'></i>"
                                // + "<i class='icon iconfont icon-chakan text-primary' onclick=\"showRequestUnits(\'"+tbSampling.id+"\')\"></i>"
                            );

                        } else {
                            //已收样，提供查看委托单位功能
                            $("#_sample_info ._regName").html("<span>"+rUnitsLength+"个</span>"
                                // + "<i class='icon iconfont icon-xiugai text-primary _edit_reg'></i>"
                                + "<i class='icon iconfont icon-chakan text-primary' onclick=\"showRequestUnits(\'"+tbSampling.id+"\')\"></i>"
                            );
                        }

                        //订单列表添加订单号
                        if ($("#_orders_no ._"+tbSampling.samplingNo).length == 0) {
                            if(collectNum>0){
                                //有待收样品
                                $("#_orders_no").append("<div class=\"search-code search-active _order_no _"+tbSampling.samplingNo+"\"><i class=\"icon iconfont icon-weiwancheng text-warning\"></i><span>"+tbSampling.samplingNo+"</span><i class=\"icon iconfont icon-you\"></i></div>");
                            }else{
                                $("#_orders_no").append("<div class=\"search-code search-active _order_no _"+tbSampling.samplingNo+"\"><i class=\"icon iconfont icon-wancheng text-success\"></i><span>"+tbSampling.samplingNo+"</span><i class=\"icon iconfont icon-you\"></i></div>");
                            }

                        //修改订单列表订单状态
                        } else {
                            if(collectNum == 0){
                                $("#_orders_no ._"+tbSampling.samplingNo+" i:first()").attr("class", "icon iconfont icon-wancheng text-success");
                            }
                        }

                        //更新序号
                        updateSerialNumber();

                        //选择第一个样品条码输入框
                        if ($("#_sample_table ._to_submit").length>0){
                            $("#_sample_table ._to_submit ._code_input:first").click();
                        }


                        //合并打印按钮
                        if (collectCodes && collectCodes.size>0){
                            collectCodes.forEach(function (value, key, map) {
                                if (value && $("."+value).length>1){
                                    $("."+value+":first ._print_btn").attr("rowspan", $("."+value).length);
                                    $("."+value+" ._print_btn:gt(0)").remove();
                                }
                            });
                        }


                        //收样提交，刷新订单并打印凭证
                        if (printCollectCode){
                            printProof(printCollectCode);
                        }

                        _sample_template.find("tr").addClass("_to_submit");


                        //隐藏更改委托单位按钮
                        if ($("._not_modify").length>0){
                            $("._edit_reg").hide();

                        //加载更改委托单位窗口数据
                        } else {
                            //订单委托单位
                            if (rUnits) {
                                $("#_edit_reg_modal1 ._sel_unit_num span").text(rUnits.length);
                                for (var i=1;i<=rUnits.length;i++) {
                                    $("#_edit_reg_modal1 ._selected_req_units").append("" +
                                        "<tr class='_sel_unit_"+rUnits[i-1].requestId+"' data-id='"+rUnits[i-1].requestId+"' data-name='"+rUnits[i-1].requestName+"' data-phone='"+rUnits[i-1].param1+"' data-address='"+rUnits[i-1].param2+"'>\n" +
                                        "    <td style=\"width: 30px;\">"+i+"</td>\n" +
                                        "    <td>"+rUnits[i-1].requestName+"</td>\n" +
                                        "    <td class=\"tex-center\">\n" +
                                        "        <a href=\"javascript:;\">\n" +
                                        "            <span class=\"cs-icon-span\">\n" +
                                        "                <i class=\"icon iconfont icon-shanchu text-danger\" onclick=\"delUnit('"+rUnits[i-1].requestId+"')\"></i>\n" +
                                        "            </span>\n" +
                                        "        </a>\n" +
                                        "    </td>\n" +
                                        "</tr>");
                                }
                            }
                        }

                    }else{
                        //清空订单列表
                        tips("找不到该订单");
                    }

                    if ($("#_sample_table tbody ._to_submit").length>0){
                        $("#_div_0").show();
                    } else {
                        $("#_div_0").hide();
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
            /*
            //样品数量
            var sampleSet = new Set();
            $("#_sample_table ._bag_code").each(function () {
                if ($(this).attr("value")) {
                    sampleSet.add($(this).attr("value"));
                }
            });
            $("#sampleNum").text(sampleSet.size);
            */
        }

        //提交
        function submitSampleForm(){
            // var index = 0 ;
            // $("#_sample_table tbody ._to_submit").each(function () {
            //     //（同一订单）上次收样提交后，不刷新订单，再次收样，清除上传收样样品标识
            //     if ($(this).find("._code_time_text").text()){
            //        $(this).removeClass("_to_submit");
            //
            //    //修改input-name
            //    } else {
            //        $(this).find("._sampling_detail_id").attr("name","tbSamplingDetails["+index+"].id");
            //        $(this).find("._bag_code").attr("name","tbSamplingDetails["+index+"].sampleTubeCode");
            //        $(this).find("._food_id").attr("name","tbSamplingDetails["+index+"].foodId");
            //        $(this).find("._food_name").attr("name","tbSamplingDetails["+index+"].foodName");
            //        // $(this).find("._code_time").attr("name","tbSamplingDetails["+index+"].sampleTubeTime");
            //        index++;
            //    }
            // });


            //修改样品input-name
            $("#_sample_table tbody ._to_submit").each(function (index, value) {
                $(this).find("._sampling_detail_id").attr("name","tbSamplingDetails["+index+"].id");
                $(this).find("._bag_code").attr("name","tbSamplingDetails["+index+"].sampleTubeCode");
                $(this).find("._food_id").attr("name","tbSamplingDetails["+index+"].foodId");
                $(this).find("._food_name").attr("name","tbSamplingDetails["+index+"].foodName");
                // $(this).find("._code_time").attr("name","tbSamplingDetails["+index+"].sampleTubeTime");
            });

            //已选择委托单位
            $("#_edit_reg_modal1 ._selected_req_units tr").each(function(index, value){
                $("#_sample_info ._reg_info").remove();
                $("#_sample_info").append("" +
                    "   <input type=\"hidden\" class=\"_reg_info\" name=\"tbSamplingRequesters["+index+"].requestId\" value=\""+$(this).attr("data-id")+"\"> " +
                    "   <input type=\"hidden\" class=\"_reg_info\" name=\"tbSamplingRequesters["+index+"].requestName\" value=\""+$(this).attr("data-name")+"\"> " +
                    "   <input type=\"hidden\" class=\"_reg_info\" name=\"tbSamplingRequesters["+index+"].param1\" value=\""+$(this).attr("data-phone")+"\"> "+
                    "   <input type=\"hidden\" class=\"_reg_info\" name=\"tbSamplingRequesters["+index+"].param2\" value=\""+$(this).attr("data-address")+"\"> ");
            });


            $.ajax({
                type: "POST",
                url: "${webRoot}/collectSample/save",
                data: $("#_sample_form ._to_submit input").serialize(),
                dataType: "json",
                success: function(data){
                    if(data && data.success){
                        //保存成功
                        tips("保存成功", 0);

                        //刷新订单
                        queryOrderByNo($("#_sample_info ._samplingNo").text(), data.obj.collectCode);

                        //刷新应收样数量
                        myChart();

                        // var collectNum = 0;    //待收样数量
                        // //更新收样时间
                        // $("#_sample_table ._to_submit").each(function (index, value) {
                        //     var _code_0 = $(this).find("._bag_code").val();
                        //     if(_code_0){
                        //         $(this).find("._code_time_text").text(data.obj.collectTime);
                        //         $(this).find("._order_status").text("已收样");
                        //         //不可修改
                        //         $(this).find("._code_input").addClass("_not_modify");
                        //         //清除清空条码按钮
                        //         $(this).find("._code_input").removeClass("_code_input");
                        //     } else {
                        //         collectNum++;
                        //     }
                        // });
                        //
                        // //隐藏删除条码按钮
                        // $("._to_submit .select-input").removeClass("select-input");
                        // $("._to_submit .icon-close").hide();
                        //
                        // //订单号
                        // var _sampling_no_0 = $("#_sample_info ._samplingNo").text();
                        // //更新订单状态
                        // if(collectNum>0){
                        //     //有待收样品
                        //     $("._"+_sampling_no_0+" i:first").attr("class","icon iconfont icon-weiwancheng text-warning");
                        // }else{
                        //     $("._"+_sampling_no_0+" i:first").attr("class","icon iconfont icon-wancheng text-success");
                        // }
                        //
                        // //显示打印凭证按钮
                        // $("#_print_proof_btn").show();
                        //
                        // //打印凭证
                        // printProof();

                    }else{
                        tips(data.msg);
                    }
                }
            });
        }


        <%--//提示信息--%>
        <%--function tips(t, type) {--%>
        <%--    $("#_tips_modal .zz-notice").text(t);--%>
        <%--    switch (type) {--%>
        <%--        case 0:    //成功图标--%>
        <%--            $("#_tips_modal img").attr("src","${webRoot}/img/terminal/dui.png");--%>
        <%--            break;--%>
        <%--        default:   //警告图标--%>
        <%--            $("#_tips_modal img").attr("src","${webRoot}/img/terminal/wen.png");--%>
        <%--            break;--%>
        <%--    }--%>
        <%--    updateCloseTime(0);--%>
        <%--}--%>
        <%--//自动关闭提示倒计时--%>
        <%--var clostSecond = 3;    //提示关闭倒计时（秒）--%>
        <%--function updateCloseTime(waitSecond) {--%>
        <%--    if(waitSecond == 0){--%>
        <%--        $("#_tips_modal").modal("show");--%>
        <%--        $("#_tips_modal button").text("关闭("+clostSecond+"s)");--%>
        <%--        setTimeout(function () {--%>
        <%--            updateCloseTime(++waitSecond);--%>
        <%--        }, 1000);--%>

        <%--    }else if(waitSecond < clostSecond){--%>
        <%--        $("#_tips_modal button").text("关闭("+(clostSecond-waitSecond)+"s)");--%>
        <%--        setTimeout(function () {--%>
        <%--            updateCloseTime(++waitSecond);--%>
        <%--        }, 1000);--%>
        <%--    }else{--%>
        <%--        $("#_tips_modal").modal("hide");--%>
        <%--    }--%>
        <%--}--%>



</script>
</html>
