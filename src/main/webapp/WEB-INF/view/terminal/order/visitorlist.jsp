<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/WEB-INF/view/terminal/resource.jsp" %>
<%-- <link rel="stylesheet" type="text/css" href="${webRoot}/css/misson.css" /> --%>

<html>
<head>
    <title>快检服务云平台</title>
    <style type="text/css">
        input::-webkit-input-placeholder {
       			/* color: red; */
			    font-size:16px;
		}
		input::-moz-placeholder {
			font-size:16px;
　　		}
	　　input::-moz-placeholder {
				font-size:16px;
	　　}
	　　input::-ms-input-placeholder {
				font-size:16px;
	　　}
	.readStyle{
    	    border: 1px solid #999;
    		background: #f0f5ff;
    		border-radius: 4px;
    }
    </style>
</head>
<body style="width:1280px;height: 1024px;">
<div class="zz-content">
    <div class="zz-title2">
        <img class="pull-left" src="${webRoot}/img/terminal/title2.png" alt=""><span >样品登记</span>
    </div>
    <form id="orderForm">
        <div class="zz-cont-box">
            <div class="zz-choose  col-md-12 col-sm-12">
                <div class="col-md-12 col-sm-12" style="padding-right: 0;">
                    <input type="hidden" name="printNum" value="0">
                    <input type="hidden" name="expedited" value="0">
                    <input type="hidden" name="orderStatus" value="0">
                    <input type="hidden" name="scanNum" value="0">
                    <input type="hidden" name="inspectionFee" value="0">
                    
              		<div class="zz-name zz-input col-md-6 col-sm-6">
                     <div class="pull-left zz-name2"><i class="cs-mred">*</i>送检单位</div>
                     <div class="pull-left cs-all-ps">
                        <button class="zz-clear-btn2" type="button"><i class="icon iconfont icon-close"></i></button>
	                    <div class="cs-input-box">
		                     <input type="hidden"  name="regId" class="cs-input-id" />
							 <input type="text" id="inputDataReg" class="cs-down-input inputData" autocomplete="off" placeholder="请输入首字母查找单位"/>
						 </div>
						 <div id="divBtn" class="cs-check-down" style="display:none;">
		                      <ul id="mySelectRegId">
		                   	  </ul>
	                    </div>
	                    </div>
                     </div>
                    
				
                    <div class="zz-name col-md-2 col-sm-2"><i class="cs-mred">*</i>联系电话</div>
                    <div class="zz-input col-md-4 col-sm-4">
                        <input name="regLinkPhone" type="text" class="cs-input-id">
                    </div>
                </div> 
                 <div class="col-md-12 col-sm-12" style="padding-right: 0;">
                    <input type="hidden" name="printNum" value="0">
                    <input type="hidden" name="expedited" value="0">
                    <input type="hidden" name="orderStatus" value="0">
                    <input type="hidden" name="scanNum" value="0">
                    <input type="hidden" name="inspectionFee" value="0">
                    
              		<div class="zz-name zz-input col-md-6 col-sm-6">
                     <div class="pull-left zz-name2"><i class="cs-mred">*</i>委托单位</div>
                     <div class="pull-left cs-all-ps">
                        <button class="zz-clear-btn2" type="button"><i class="icon iconfont icon-close"></i></button>
	                    <div class="cs-input-box">
		                     <input type="hidden"  name="regId" class="cs-input-id" />
							 <input type="text" id="inputDataReg" class="cs-down-input inputData" autocomplete="off" placeholder="请输入首字母查找单位"/>
						 </div>
						 <div id="divBtn" class="cs-check-down" style="display:none;">
		                      <ul id="mySelectRegId">
		                   	  </ul>
	                    </div>
	                    </div>
                     </div>
                    
				
                    <div class="zz-name col-md-2 col-sm-2">联系电话</div>
                    <div class="zz-input col-md-4 col-sm-4">
                        <input name="regLinkPhone" type="text" class="cs-input-id readStyle" readonly="readonly" >
                    </div>
                </div> 
                <%--
                <div class="zz-btn-head col-md-12 col-sm-12">
                    <div class="btn btn-primary show-modal-btn _add_btn" ><i class="icon iconfont icon-zengjia1"></i>增加样品</div>
                </div>
                --%>
            </div>


            <div class="zz-table col-md-12 col-sm-12">
                <div class="zz-tb-bg zz-tb-bg2 zz-tb-bg3" style="height: 730px;">
                    <table id="_food_table">
                        <tr class="zz-tb-title">
                            <th class="nums">序号</th>
                            <th>检测样品</th>
                            <th>检测项目</th>
                            <th class="cons">检测费用</th>
                           <!--  delete by xiaoyl 2019-08-06 取消自助终端扫描样品码功能
                           <th class="cons2 text-left">包装袋条码</th> -->
                            <th class="scan" style="width: 180px;">操作</th>
                        </tr>
                        <tr class="">
                            <td><i class="_serial_number">1</i></td>
                            <td class="_food_name"></td>
                            <td class="_item_name"></td>
                            <td class="_inspection_fee"></td>
                            <!-- delete by xiaoyl 2019-08-06 取消自助终端扫描样品码功能
                            <td class="scan code-wirite"></td> -->
                            <td classs="cons2"><i class="btn text-primary zz-show-btn1 _add_btn">添加</i></td>
                        </tr>
                        <tr class="">
                            <td><i class="_serial_number">2</i></td>
                            <td class="_food_name"></td>
                            <td class="_item_name"></td>
                            <td class="_inspection_fee"></td>
                           <!-- delete by xiaoyl 2019-08-06 取消自助终端扫描样品码功能
                            <td class="scan code-wirite"></td> -->
                            <td classs="cons2"><i class="btn text-primary zz-show-btn1 _add_btn" >添加</i></td>
                        </tr>
                        <tr class="">
                            <td><i class="_serial_number">3</i></td>
                            <td class="_food_name"></td>
                            <td class="_item_name"></td>
                            <td class="_inspection_fee"></td>
                           <!--delete by xiaoyl 2019-08-06 取消自助终端扫描样品码功能
                             <td class="scan code-wirite"></td> -->
                            <td classs="cons2"><i class="btn text-primary zz-show-btn1 _add_btn" >添加</i></td>
                        </tr>
                        <tr class="">
                            <td><i class="_serial_number">4</i></td>
                            <td class="_food_name"></td>
                            <td class="_item_name"></td>
                            <td class="_inspection_fee"></td>
                            <!--delete by xiaoyl 2019-08-06 取消自助终端扫描样品码功能
                             <td class="scan code-wirite"></td> -->
                            <td classs="cons2"><i class="btn text-primary zz-show-btn1 _add_btn" >添加</i></td>
                        </tr>
                        <tr class="">
                            <td><i class="_serial_number">5</i></td>
                            <td class="_food_name"></td>
                            <td class="_item_name"></td>
                            <td class="_inspection_fee"></td>
                            <!--delete by xiaoyl 2019-08-06 取消自助终端扫描样品码功能
                             <td class="scan code-wirite"></td> -->
                            <td classs="cons2"><i class="btn text-primary zz-show-btn1 _add_btn" >添加</i></td>
                        </tr>
                        <tr class="">
                            <td><i class="_serial_number">6</i></td>
                            <td class="_food_name"></td>
                            <td class="_item_name"></td>
                            <td class="_inspection_fee"></td>
                            <!--delete by xiaoyl 2019-08-06 取消自助终端扫描样品码功能
                             <td class="scan code-wirite"></td> -->
                            <td classs="cons2"><i class="btn text-primary zz-show-btn1 _add_btn" >添加</i></td>
                        </tr>
                        <tr class="">
                            <td><i class="_serial_number">7</i></td>
                            <td class="_food_name"></td>
                            <td class="_item_name"></td>
                            <td class="_inspection_fee"></td>
                           <!--delete by xiaoyl 2019-08-06 取消自助终端扫描样品码功能
                             <td class="scan code-wirite"></td> -->
                            <td classs="cons2"><i class="btn text-primary zz-show-btn1 _add_btn" >添加</i></td>
                        </tr>
                        <tr class="">
                            <td><i class="_serial_number">8</i></td>
                            <td class="_food_name"></td>
                            <td class="_item_name"></td>
                            <td class="_inspection_fee"></td>
                            <!--delete by xiaoyl 2019-08-06 取消自助终端扫描样品码功能
                             <td class="scan code-wirite"></td> -->
                            <td classs="cons2"><i class="btn text-primary zz-show-btn1 _add_btn" >添加</i></td>
                        </tr>
                        <tr class="">
                            <td><i class="_serial_number">9</i></td>
                            <td class="_food_name"></td>
                            <td class="_item_name"></td>
                            <td class="_inspection_fee"></td>
                            <!--delete by xiaoyl 2019-08-06 取消自助终端扫描样品码功能
                             <td class="scan code-wirite"></td> -->
                            <td classs="cons2"><i class="btn text-primary zz-show-btn1 _add_btn" >添加</i></td>
                        </tr>
                        <tr class="">
                            <td><i class="_serial_number">10</i></td>
                            <td class="_food_name"></td>
                            <td class="_item_name"></td>
                            <td class="_inspection_fee"></td>
                            <!--delete by xiaoyl 2019-08-06 取消自助终端扫描样品码功能
                             <td class="scan code-wirite"></td> -->
                            <td classs="cons2"><i class="btn text-primary zz-show-btn1" >添加</i></td>
                        </tr>
                    </table>
                    <div class="zz-stats">
                        <p>共：</p><p><span id="totalNum">0</span>个检测项目</p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <p>检测费用：¥<span id="totalCost">0</span></p>
                    </div>
                    <div class="zz-sure-notice">
                    	<div class="col-md-1" style="width: 118px;padding:0;">
                    		<i class="icon iconfont icon-dengpao"></i><b>温馨提示：</b>
                    	</div>
                    	<div class="col-md-10">
                    		<p>1、每个订单最多添加10项；</p>
                    		<p>2、请确认无误之后提交订单，订单一旦提交之后将无法返回修改。</p>
                    	</div>
                    </div>
                </div>
                <div class="zz-price-all zz-hide">
                    <div><img src="${webRoot}/img/terminal/code2.png" style="display: none; border: 1px solid #00911f" alt=""></div>
                </div>
            </div>


            <div class="zz-tb-btns col-md-12 col-sm-12">
                <button id="_back" type="button" class="btn btn-danger">返回</button>
                <button id="_settlement" type="button" class="btn btn-primary">提交订单</button><br/>
                <div class="zz-text-wran text-danger clearfix" id="showErrorMsg"></div>
            </div>
        </div>
    </form>

    <table style="display: none;">
        <tbody id="_add_food_template1">
        <tr class="_have_data">
            <input type="hidden" name="_supplier_name" class="_supplier_name_input">
            <input type="hidden" name="_supplier_id" class="_supplier_name_id">
            <input type="hidden" name="_stall_name" class="_stall_name_input">
            <input type="hidden" name="_food_id" class="_food_id_input">
            <input type="hidden" name="_food_name" class="_food_name_input">
            <input type="hidden" name="_item_id" class="_item_id_input">
            <input type="hidden" name="_item_name" class="_item_name_input">
            <input type="hidden" name="_inspection_fee" class="_inspection_fee_input">
           <!--  delete by xiaoyl 2019-08-06 取消自助终端扫描样品码功能
            <input type="hidden" class="_code_input" /> -->
            <td><i class="_serial_number"></i></td>
            <td class="_food_name"></td>
            <td class="_item_name"></td>
            <td class="_inspection_fee_name text-danger"></td>
          <!--   delete by xiaoyl 2019-08-06 取消自助终端扫描样品码功能
            <td class="scan code-wirite"></td> -->
            <td classs="cons2"><i class="btn text-danger zz-show-btn2 _clean_btn">清空</i></td>
        </tr>
        </tbody>
        <tbody id="_add_food_template2">
        <tr>
            <td><i class="_serial_number"></i></td>
            <td class="_food_name"></td>
            <td class="_item_name"></td>
            <td class="_inspection_fee"></td>
           <!--  delete by xiaoyl 2019-08-06 取消自助终端扫描样品码功能
            <td class="scan code-wirite"></td> -->
            <td classs="cons2"><i class="btn text-primary zz-show-btn1 _add_btn">添加</i></td>
        </tr>
        </tbody>
    </table>

    <div class="zz-left"><img src="${webRoot}/img/terminal/left.png" alt=""></div>
    <div class="zz-right"><img src="${webRoot}/img/terminal/right.png" alt=""></div>

    <div id="_add_modal" class="show-modal zz-hide" >
        <div width="100%" style="border-bottom: 1px solid #ccc;" class="cs-add-new clearfix">
			
            <div class="cs-ul-form clearfix col-sm-12 col-md-12" style="padding: 0; padding-bottom: 30px; border-right:1px solid #ccc;">
            	<div class="zz-add-title" style="padding:10px;">样品信息</div>
            	<ul class="cs-ul-form clearfix col-sm-12 col-md-12">
                <li  class="cs-name col-sm-4 col-md-4"><i class="cs-mred">*</i>选择样品：</li>
                <li class="zz-input col-sm-8 col-md-8">
                    <!-- <select name="_food" id="myFoodSelect" class="js-example-basic-single" style="width: 360px">
                        <option value="" data-foodName="">--请选择--</option>
                    </select> -->
                    <div class="cs-all-ps" style="width: 402px">
                    	<button class="zz-clear-btn2" type="button"><i class="icon iconfont icon-close"></i></button>
	                    <div class="cs-input-box">
	                    	<input type="hidden"  name="foodId" class="cs-input-id"/>
	                    	<input type="hidden"  name="foodName" class="cs-input-id"/>
							 <input type="text" id="inputDataFood" class="cs-down-input inputData" autocomplete="off" placeholder="请输入首字母查找样品" />
						 </div>
						 <div id="divBtn" class="cs-check-down" style="display:none;">
		                      <!-- 树状图 -->
		                      <ul id="myFoodSelect">
		                   	  </ul>
							  <!-- 树状图 -->
	                    </div>
	                    </div>
                   <!--  <div class="zz-text-wran text-danger" id="_food_msg" style="display:inline;"></div> -->
                    <div class="zz-text-wran text-danger col-sm-12">（送检样品至少保留200克并独立包装，否则视为无效样品）</div>
                </li>
                </ul>
                <ul class="cs-ul-form clearfix col-sm-12 col-md-12" style="min-height:85px;">
                <li class="cs-name zz-lh col-sm-4 col-md-4"><i class="cs-mred">*</i>检测项目：</li>
                <li  class="cs-in-style col-sm-8 col-md-8" style="padding-top: 4px;">
                <div id="_item_ul" class="zz-all-project clearfix" style="display: none;width:402px;" ></div>
                </li>
                </ul>
                <!-- 
                delete by xiaoyl 2019-08-06 取消自助终端扫描样品码功能
                <ul class="cs-ul-form clearfix col-sm-12 col-md-12">
                <li class="cs-name zz-lh col-sm-3 col-md-3"><i class="cs-mred">*</i>条形码扫描：</li>
                <li class="cs-in-style code-wirite col-sm-8 col-md-8" style="padding-top: 2px;">
                <div class="cs-all-ps" style="width: 360px">
	                <button class="zz-clear-btn" type="button"><i class="icon iconfont icon-tiaoxingma"></i></button>
					<input class="btn text-left _code_input" readonly="readonly" id="output" style="text-transform:uppercase; width: 348px;">
	                  <div class="zz-text-wran text-danger col-sm-12">（请将样品袋条形码放置扫描口进行扫描）</div>
	                  <div class="zz-text-wran text-danger col-sm-12" id="codeRepeat" style="height:30px"></div>
		         </div>

                </li>
                </ul> -->
            </div>
            <!-- <div class="cs-ul-form col-sm-6 col-md-6 clearfix" style="padding:0;">
                <div class="zz-add-title">来源信息</div>
                  <ul class="cs-ul-form clearfix col-sm-12 col-md-12" style="padding:0; min-height: 80px">
                <li  class="cs-name col-sm-3 col-md-3">样品来源：</li>
                <li class="zz-input col-sm-8 col-md-8">
                    <select name="_supplier" id="mySupplierSelect" class="js-example-basic-single"  style="width: 360px">
                    </select>
                    <div class="cs-all-ps" style="width: 402px">
                    	<button class="zz-clear-btn2" type="button"><i class="icon iconfont icon-close"></i></button>
	                    <div class="cs-input-box">
		                     <input type="hidden"  name="supplierId" class="cs-input-id"/>
							 <input type="text" id="inputDataRegObj" class="cs-down-input inputData" autocomplete="off" placeholder="请输入首字母查找样品来源"/>
						 </div>
						 <div id="divBtn" class="cs-check-down" style="display:none;">
		                      树状图
		                      <ul id="myRegObjSelect">
		                   	  </ul>
							  树状图
	                    </div>
	                    </div>
                </li>
                </ul>
                <ul class="cs-ul-form clearfix col-sm-12 col-md-12" style="padding:0;">
                <li  class="cs-name col-sm-3 col-md-3">经营档口：</li>
                <li class="zz-input col-sm-8 col-md-8" style="height: 86px;">
                    <div class="cs-all-ps" style="width: 402px">
                    	<button class="zz-clear-btn2" type="button"><i class="icon iconfont icon-close"></i></button>
	                    <div class="cs-input-box">
							 <input type="text" id="inputDataOpeShop" class="cs-down-input inputData" autocomplete="off" placeholder="请输入首字母查找档口"/>
						 </div>
						 <div id="divBtn" class="cs-check-down" style="display:none;">
		                      树状图
		                      <ul id="myShopSelect">
		                   	  </ul>
							  树状图
	                    </div>
	                    </div>
                </li>
                </ul>
              
            </div> -->

            <div id="_add_item_template2" style="display: none;">
                <div class="zz-marginB col-md-12 col-sm-12">
                    <label class="clearfix">
                        <div class="col-md-8 col-sm-8">
                            <div class="demo-list">
                                <ul>
                                    <li>
                                        <input tabindex="1" type="checkbox" >
                                    </li>
                                </ul>
                            </div>
                            <span class="_item_name"></span>
                        </div>
                        <div class="col-md-4 col-sm-4 text-price">
                            <span class="_inspection_fee"></span>
                        </div>
                    </label>
                </div>
            </div>

           <%--  <ul class="cs-ul-form clearfix">
                <li class="cs-name zz-lh col-sm-2 col-md-2"><i class="cs-mred">*</i>条形码扫描：</li>
                <li class="cs-in-style code-wirite col-sm-8 col-md-8" style="padding-top: 2px;">
                    <input class="btn pull-left text-left _code_input" readonly="readonly" id="output" style="text-transform:uppercase;width: 360px;">
                    
                      <a onclick="scanCode();" class="clear-btn zz-first-btn">扫描</a>
                    <a href="javascirpt:;" class="clear-btn">录入</a>
                    <div class="zz-text-wran text-danger col-sm-12">（条形码可以扫描也可以手动输入）</div>
                   
                  <!-- <div class="zz-text-wran text-danger" id="codeRepeat"></div> -->
                  <div class="zz-text-wran text-danger col-sm-12">（请将样品袋条形码放置扫描口进行扫描）</div>
                </li>

            </ul> --%>

        </div>

        <div class="zz-tb-btns col-md-12 col-sm-12" style="margin-top: 50px;">
            <a href="javascirpt:;" class="modal-close btn btn-danger">返回</a>

            <a href="javascirpt:;" class="modal-confirm btn btn-primary">确定</a>
        </div>
    </div>

</div>


<!-- 清空提示 -->
<div class="modal fade intro2" id="confirm-delete2" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="static" data-keyboard="false">
    <div class="modal-dialog cs-alert-width">
        <div class="modal-content">
            <div class="modal-body cs-alert-height zz-dis-tab2 " style="">
                <div class="zz-pay zz-ok zz-no-margin">
                    <img src="${webRoot}/img/terminal/wen.png" alt="" style="width: 40px">
                    <p class="zz-ok-text" style="display: inline-block;">提示</p>
                </div>
                <div class="zz-notice">
                    确定清空当前记录？
                </div>
            </div>
            <div class="modal-footer">
                <button type="" class="btn btn-danger" data-dismiss="modal">取消</button>
                <button type="submit" class="btn btn-primary _clean_confirm_btn" data-dismiss="modal">确定</button>
            </div>
        </div>
    </div>
</div>

<!-- 结算提示 -->
<div class="modal fade intro2" id="confirm-delete3" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="static" data-keyboard="false">
    <div class="modal-dialog cs-alert-width">
        <div class="modal-content">
            <div class="modal-body cs-alert-height zz-dis-tab2 " style="">
                <div class="zz-pay zz-ok zz-no-margin">
                    <img src="${webRoot}/img/terminal/wen.png" alt="" style="width: 40px">
                    <p class="zz-ok-text" style="display: inline-block;">提示</p>
                </div>
                <div class="zz-notice">
                    样品登记完成，确定提交订单进行结算？
                </div>
            </div>
            <div class="modal-footer">
                <button type="" class="btn btn-danger" data-dismiss="modal">取消</button>
                <button type="submit" class="btn btn-primary _bill_confirm_btn" data-dismiss="modal">确定</button>
            </div>
        </div>
    </div>
</div>

<!-- 结算失败提示 -->
<div class="modal fade intro2" id="confirm-delete4" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="static" data-keyboard="false">
    <div class="modal-dialog cs-alert-width">
        <div class="modal-content">
            <div class="modal-body cs-alert-height zz-dis-tab2 " style="">
                <div class="zz-pay zz-ok zz-no-margin">
                    <img src="${webRoot}/img/terminal/cuo.png" alt="" style="width: 40px">
                    <p class="zz-ok-text" style="display: inline-block;">提示</p>
                </div>
                <div class="zz-notice">
                    结算失败，请联系工作人员。
                </div>
                <div class="modal-footer">
                    <button type="" class="btn btn-primary" data-dismiss="modal">关闭</button>
                </div>
            </div>
        </div>
    </div>
</div>
<%@include file="/WEB-INF/view/terminal/tips.jsp"%>
<%@include file="/WEB-INF/view/terminal/keyboard.jsp"%> 
<script type="text/javascript" src="${webRoot}/js/PinyinUtil.js"></script>
<script type="text/javascript" src="${webRoot}/js/selectSearch.js"></script>
<script>
var requesterHistory=null;//委托单位历史纪录
var foodHistoryList=null;//样品历史纪录
var regHistoryList=null;//样品来源历史纪录
var shopHistoryList=null;//档口历史纪录

var queryOption=null;
var webRoot="${webRoot}";
    $(function(){
    	openwebsocket();//连接扫描服务器
    	//默认加载历史纪录
    	queryHistory(true,true,true);
        /* center modal */
        function centerModals() {
            $('.intro2').each(function (i) {
                var $clone = $(this).clone().css('display', 'block').appendTo('body');
                var top = Math.round(($clone.height() - $clone.find('.modal-content').height()) / 2.4);
                top = top > 0 ? top : 0;
                $clone.remove();
                $(this).find('.modal-content').css("margin-top", top);
            });
        }
        $('.intro2').on('show.bs.modal', centerModals);
        $(window).on('resize', centerModals);

    
        $(document).on("mousemove","#_food_table tr:gt(0)",function(){
            $(this).siblings().removeClass("tr-current")
            $(this).addClass("tr-current");
        });

        //选择委托单位
		$(document).on('click', '#mySelectRegId li', function () {
			$("input[name='regLinkPhone']").val($(this).attr("data-linkPhone"));
			 $("input[name='regId']").val($(this).attr("data-id"));
		})
        //选择来源市场
        $(document).on('click', '#myRegObjSelect li', function () {
			var regId=$(this).attr("data-regId");
			var regName=$(this).attr("data-regName");
			$("input[name='supplierId']").val(regId);
			//查询历史记录
            $.ajax({
				type : "POST",
				url: "${webRoot}/order/getHistory.do",
				data: {"userType":1,"HistoryType":3,"regName":regName},
				dataType : "json",
				success : function(data) {
					if (data && data.success) {
						shopHistoryList = data.obj;
						dealShopHtml()
					}
				}
			});
            queryOpeShopName(regId);//查询该来源下所有的档口信息
		})

        //选择检测样品
        $(document).on('click', '#myFoodSelect li', function () {
        	var foodId=$(this).attr("data-id");
        	$("input[name='foodId']").val(foodId);
        	$("input[name='foodName']").val($(this).attr("data-foodName"));
        	 //清空检测项目
            $("#_item_ul").html("");
          //刷新检测项目
            $.ajax({
                type: "POST",
                url: "${webRoot}/data/foodType/detectItem/queryListByFoodId",
                data: {"foodId":foodId},
                dataType: "json",
                success: function(data){
                    if(data && data.success){
                        var obj = data.obj;
                        if(obj && obj.length>0){
                            for (var i=0;i<obj.length;i++){
                                var itemLi = $("#_add_item_template2").clone();
                                itemLi.find("label").attr("for","input-"+i);
                                itemLi.find("input").attr("id","input-"+i);
                                itemLi.find("input").val(obj[i].itemId);
                                itemLi.find("input").attr("data-itemName",obj[i].detectName);
                                itemLi.find("input").attr("data-inspectionFee",obj[i].price);
                                itemLi.find("._item_name").text(obj[i].detectName);
                                itemLi.find("._inspection_fee").text("￥"+obj[i].price+"元");
                                if(obj.length==1){
                                	 itemLi.find("input").attr("checked","checked");
                                }
                                $("#_item_ul").append(itemLi.html());
                            }
                            //重新初始化ICheck
                            initICheck();
                        }
                    }
                }
            });
            $('.zz-all-project').show();
		})

        //清空确认
        var cleanEle;
        $(document).on("click","._clean_btn",function(){
            cleanEle = $(this);
            $("#confirm-delete2").modal("show");
        });
        //清空
        $(document).on("click","._clean_confirm_btn",function(){
            cleanEle.parents("tr").remove();
            var _add_food_template = $("#_add_food_template2").clone();
            $("#_food_table").append(_add_food_template.html());
            updateSerialNumber();
        });

        //增加样品 - 打开
        $(document).on("click","._add_btn",function(){
            $('#_add_modal').show();
        });
      	//增加样品 - 关闭
      	$('.modal-close').click(function(){
            $('#_add_modal').hide();
          	setTimeout(function(){
           //重新加载历史纪录
          	    clearModal();
          	},500);
        });
      	//增加样品 - 确认
        $('.modal-confirm').click(function(){
        	if($("#inputDataFood").val()==""){
// 				showMsg("请选择样品！");
				 tips("请选择样品！");
        	}else if($("#output").val()==""){
//         		showMsg("请扫描样品袋条形码！");
        		tips("请扫描样品袋条形码！");
        	}else if($("#_item_ul input:checkbox:checked").length==0){
//         		showMsg("请选择检测项目！");
        		tips("请选择检测项目！");
        	}else{
	            $.each($("#_item_ul input:checkbox:checked"),function(){
	                var _add_food_template = $("#_add_food_template1").clone();
	
	                
	                _add_food_template.find("._food_id_input").val($("input[name='foodId']").val());
	                _add_food_template.find("._food_name_input").val($("input[name='foodName']").val());
	
	                _add_food_template.find("._supplier_name_id").val($("input[name='supplierId']").val());
	                _add_food_template.find("._supplier_name_input").val($("#inputDataRegObj").val());
	                
	                _add_food_template.find("._stall_name_input").val($("#inputDataOpeShop").val());
	
	                _add_food_template.find("._item_id_input").val($(this).attr("value"));
	                _add_food_template.find("._item_name_input").val($(this).attr("data-itemName"));
	                _add_food_template.find("._inspection_fee_input").val($(this).attr("data-inspectionFee"));
	
	              /*   delete by xiaoyl 2019-08-06 取消自助终端扫描样品码功能
	                _add_food_template.find("._code_input").attr("value",$("#_add_modal ._code_input").val());
	                _add_food_template.find(".code-wirite").text($("#_add_modal ._code_input").val()); */
	                
	                _add_food_template.find("._inspection_fee_name").text("￥"+$(this).attr("data-inspectionFee"));
	                _add_food_template.find("._food_name").text($("input[name='foodName']").val());
	                _add_food_template.find("._item_name").text($(this).attr("data-itemName"));
	
	                if($("#_food_table ._have_data").length>0){
	                    $("#_food_table ._have_data:last").after(_add_food_template.html());
	                }else{
	                    $("#_food_table .zz-tb-title").after(_add_food_template.html());
	                }
	            });
	            clearModal();
	            //最多10个检测样品
	            $("#_food_table tr:gt(10)").remove();
	            updateSerialNumber();
	            $('#_add_modal').hide();
        	}
        });
      	function clearModal(){
            //恢复样品和数据来源
             $("#_item_ul").hide();
            $("#inputDataFood,#inputDataRegObj,#inputDataOpeShop").val("");
            queryHistory(false,true,true);
            //清空已选检测项目
            $("#_item_ul").html("");
//	            //清空已选检测项目
//	            $("#_item_ul input:checkbox:checked").iCheck('uncheck');
            //清空条码
            $("#_add_modal ._code_input").val("");
      	}
        //更新序号
        function updateSerialNumber(){
            var h = 1;
            $("#_food_table ._serial_number").each(function(){
                $(this).text(h);
                h++;
            });
            //合计项目数量
            $("#totalNum").text($("#_food_table ._have_data").length);
            //合计检测费用
            var totalCost = 0;
            $("#_food_table ._have_data ._inspection_fee_input").each(function () {
                totalCost += parseFloat($(this).val());
            });
            $("input[name='inspectionFee']").val(totalCost);
            $("#totalCost").text(totalCost.toFixed(2));
        }
        
        $(document).on("click","#_back",function() {
        	window.location.href = "${webRoot}/terminal/goHome";
        });
		//点击结算：验证必填项        
        $(document).on("click","#_settlement",function() {
        	 if($("input[name=regId]").val()==""){
        		tips("请选择委托单位！");
        	}else if($("#_food_table ._have_data").length==0){
        		tips("请添加样品");
        	}else{
	        	$("#confirm-delete3").modal("show");
        	}
        	setTimeout(function(){
        		$("#showErrorMsg").html("");
        	},3000); 
        });
        
        //结算
        $(document).on("click","._bill_confirm_btn",function() {
        	$("#_back").attr("disabled",true);
        	$("#_settlement").attr("disabled",true);
        	$("#inputDataReg").attr("name","regName");
            //修改input-name
            $("#_food_table ._have_data").each(function (index, value) {
                $(this).find("._supplier_name_input").attr("name","samplingDetails["+index+"].supplier");
                $(this).find("._supplier_name_id").attr("name","samplingDetails["+index+"].supplierId");
                
                $(this).find("._stall_name_input").attr("name","samplingDetails["+index+"].opeShopName");

                $(this).find("._food_id_input").attr("name","samplingDetails["+index+"].foodId");
                $(this).find("._food_name_input").attr("name","samplingDetails["+index+"].foodName");

                $(this).find("._item_id_input").attr("name","samplingDetails["+index+"].itemId");
                $(this).find("._item_name_input").attr("name","samplingDetails["+index+"].itemName");
                $(this).find("._inspection_fee_input").attr("name","samplingDetails["+index+"].inspectionFee");

                /* delete by xiaoyl 2019-08-06 取消自助终端扫描样品码功能
                $(this).find("._code_input").attr("name","samplingDetails["+index+"].sampleTubeCode"); */
            });
            
            $.ajax({
                type: "POST",
                url: "${webRoot}/order/save",
                data: $("#orderForm").serialize(),
                dataType: "json",
                success: function(data){
                    if(data && data.success){
                        //跳到支付页面
                        location.href="${webRoot}/pay/list.do?incomeId="+data.obj.id;
                    }else{
                        $("#confirm-delete4 .zz-notice").text(data.msg);
                        $("#confirm-delete4").modal("show");
                    }
                },
                complete:  function(){
                	$("#_back").attr("disabled",false);
                	$("#_settlement").attr("disabled",false);
                }
            });
        });

        //条码输入框
        var keyIn = 1;//0_输入中,1_输入完成
        $(document).on("keypress","._code_input",function(event) {
            if(keyIn == 1){
                $(this).val("");
                keyIn = 0;
            }
            if(event.keyCode == 13){    //回车
                if($(this).val()){
                    $(this).val($(this).val().toUpperCase());
                }
                keyIn = 1;
                // console.log('你输入的内容为：' + $(this).val());
            }
        });
    });
    $(document).ready(function(){
        initICheck();
    });
    //初始化ICheck
    function initICheck() {
     /*    var callbacks_list = $('.demo-callbacks ul');
        $('.demo-list input').on('ifCreated ifClicked ifChanged ifChecked ifUnchecked ifDisabled ifEnabled ifDestroyed', function(event){
            callbacks_list.prepend('<li><span>#' + this.id + '</span> is ' + event.type.replace('if', '').toLowerCase() + '</li>');
        }).iCheck({
            checkboxClass: 'icheckbox_square-blue',
            radioClass: 'iradio_square-blue',
            increaseArea: '20%'
        }); */
    }
    //接收扫码结果处理
    /*delete by xiaoyl 2019-08-06 取消自助终端扫描样品码功能
    function websocket_decode(message){
    	var sampleRegExp =  new RegExp("^("+"${sampleBarCode}"+")([0-9A-Z])*$");
	  if($('#_add_modal').css('display')!="block"){//模态框未打开不处理扫描数据
		 
	  }else if(!sampleRegExp.test(message)){
		  $("#codeRepeat").html("请扫描正确的样品码！");
	  }else{
		  //1.校验前台是否重复扫码
		  var repeat=0;
		   $("#_food_table ._have_data").each(function (index, value) {
			   if(message==$(this).find("._code_input").val()){
				   repeat=1;
				   return false;
			   }
            });
		   if(repeat==0){
			 //2.后台校验样品码是否重复
				  $("#output").focus();
			      $("#output").val("");
			      $("#codeRepeat").html("");
				  $.ajax({
			             type: "POST",
			             url: "${webRoot}/order/queryByCheck",
			             data: {"sampleTubeCode":message},
			             dataType: "json",
			             success: function(data){
			                 if(data && data.success){
			                	 $("#output").val(message);
			                	 $("#codeRepeat").html("");
			                 }else{
			                     $("#codeRepeat").html("&nbsp;&nbsp;&nbsp;&nbsp;"+data.msg);
			                     setTimeout(function(){
			                    	 $("#codeRepeat").html("");
			                     },3000);
			                 }
			             }
	         }); 
		   }
	  }
    }*/
    
    $(document).on('click','.zz-clear-btn2',function(){
    	$(this).siblings('.cs-input-box').children('.cs-down-input').val('');
    	$(this).siblings('.cs-input-box').children('.cs-input-id').val('');
    	if($(this).siblings('.cs-input-box').children('.cs-down-input').attr("id")=="inputDataFood"){
    		 $("#_item_ul").html("");
    		 $("#_item_ul").hide();
    	}
    	fireKeyEvent($(this).parent().find(".inputData")[0],"keyup",8);
    })
    function showMsg(msg){
    	$("#codeRepeat").html(msg);
        setTimeout(function(){
       	 $("#codeRepeat").html("");
        },3000);
    }
</script>

</body>
</html>
