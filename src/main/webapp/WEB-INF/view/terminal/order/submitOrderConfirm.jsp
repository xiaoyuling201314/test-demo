<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<style type="text/css">
	.pay-info-list{
            margin-top: 10px;
          }
          .pay-info-list li{
            line-height: 28px;
            text-align: left;
            padding-left: 35px;
          }
          .all-pay{
            font-size: 16px;
            line-height: 40px;
            height: 40px;
            border-top: 1px dashed #ddd;
            margin: 10px 0;
            padding-left: 35px;
          }
          .zz-code-bg{
            height: 240px;
            margin-top: -150px;

          }
          .text-pray{
            color: #666;
          }
          .all-pay-btn{
            padding: 10px;
          }
          .six-font{
            font-size: 16px;
          }
          div.modal-footer{
          	    border: 0px;
          }
</style>
<!-- 清空提示 -->
<div class="modal fade intro2" id="confirm-delete2" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="static" data-keyboard="false">
    <div class="modal-dialog cs-alert-width">
        <div class="modal-content">
            <div class="cs-alert-height zz-dis-tab2 " style="">
                <div class="zz-pay zz-ok zz-no-margin zz-title-bg">
                    <%-- <img src="${webRoot}/img/terminal/wen.png" alt="" style="width: 40px"> --%>
                    <p class="zz-ok-text" style="display: inline-block;">提示</p>
                </div>
                <div class="zz-notice">
                   <img src="${webRoot}/img/terminal/wen.png" alt="" style="width: 40px">  确定删除当前记录？
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
            <div class="cs-alert-height zz-dis-tab2 " style="">
                <div class="zz-pay zz-ok zz-no-margin zz-title-bg">
                    <%-- <img src="${webRoot}/img/terminal/wen.png" alt="" style="width: 40px"> --%>
                    <p class="zz-ok-text" style="display: inline-block;">确认订单</p>
                </div>
                <!-- <div class="zz-notice">
                    样品登记完成，确定提交订单进行结算？
                </div> -->
                <c:choose>
				  <c:when test="${session_user_terminal.terminalUserType==1 }">
				  		<div class="zz-pay-content">
				            <ul class="pay-info-list">
				              <li class="six-font">检测费用：<i class="six-font text-primary" id="inspection-money"></i></li>
				               <li class="six-font" id="showReportMoney">报告费用：<i class="six-font text-primary" id="report-money"></i></li>
				            </ul>
				    
				          </div>
				          <div class="all-pay text-left">合计费用：<i class="text-primary" id="total-money"></i></div>
				  </c:when>
				 <c:otherwise>
				 		<div class="zz-pay-content">
				            <ul class="pay-info-list">
				              <li class="six-font">检测费用：<i class="six-font text-primary" id="inspection-money"></i></li>
				               <li class="six-font">样品数量：<i class="six-font text-primary" id="food-number"></i></li>
				            </ul>
				    
				          </div>
				          <div class="all-pay text-left">合计费用：<i class="text-primary" id="total-money"></i></div>
				 
				 </c:otherwise>
		  		</c:choose>
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
            <div class="cs-alert-height zz-dis-tab2 " style="">
                <div class="zz-pay zz-ok zz-no-margin zz-title-bg">
                    <%-- <img src="${webRoot}/img/terminal/cuo.png" alt="" style="width: 40px"> --%>
                    <p class="zz-ok-text" style="display: inline-block;">提示</p>
                </div>
                <div class="zz-notice">
                    <img src="${webRoot}/img/terminal/cuo.png" alt="" style="width: 40px"> 结算失败，请联系工作人员。
                </div>
                <div class="modal-footer">
                    <button type="" class="btn btn-primary" data-dismiss="modal">关闭</button>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- 送检要求 -->
<div class="modal fade intro2" id="confirm-request" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="static" data-keyboard="false">
    <div class="modal-dialog cs-alert-width">
        <div class="modal-content">
            <div class="cs-alert-height zz-dis-tab2 " style="">
                <div class="zz-pay zz-ok zz-no-margin zz-title-bg">
                    <p class="zz-ok-text" style="display: inline-block;">送样要求</p>
                </div>
                <div class="zz-notice" >
                  	<table class="food-list-table">
		            </table>
                </div>
                <div class="modal-footer">
                    <button type="" class="btn btn-danger" data-dismiss="modal">关闭</button>
                </div>
            </div>
        </div>
    </div>
</div>
 <script type="text/javascript">
 //送样要求
 var dealMessage=0;
 var foodArray=new Map();//样品数量
 function showRequest(){
 	if(dealMessage==0){
	    	var rechargeOption =eval('${sampleWeight}');
	    	 var html="<tr style='text-align:center;font-weight:600;'><td>样品种类</td><td>送检样品量(克)</td></tr>";
	    	$(".food-list-table").empty("");
	    	for (var i = 0; i < rechargeOption.length; i++) {
	    		var requestWeight=rechargeOption[i].request_weight.replace(";",";<br/>");
	    		if(rechargeOption[i].length==1){
		    		html+="<tr><td>"+rechargeOption[i].food_type+"</td><td>"+requestWeight+"</td></tr>";
	    		}else{
	    			var foods=rechargeOption[i].food_type.split(",");
	    			for(var j = 0; j < foods.length; j++){
	    				if(j==0){
			    			html+="<tr ><td>"+foods[j]+"</td><td rowspan='"+rechargeOption[i].length+"'>"+requestWeight+"</td></tr>";
	    				}else{
	    					html+="<tr ><td>"+foods[j]+"</td></tr>";
	        				
	    				}
	    			}
	    		}
	    	}
	    	$(".food-list-table").append(html); 
	    	dealMessage=1;
 	}
 	$("#confirm-request").modal("show");
 }
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
 //更新序号
 function updateSerialNumber(){
     foodArray=new Map();
     var h = 1;
     $("#_food_table ._serial_number").each(function(){
         $(this).text(h);
         h++;
     });
     //add by xiaoyl 2020-03-23 当检测项目小于10个时只显示10行，当检测项目数量大于等于10时，自动保留一个添加的数据行
     var dataNumbers=$("#_food_table ._have_data").length;//几个检测项目
     if(dataNumbers>=10){
    	 $("#_food_table tr:gt("+(dataNumbers+1)+")").remove();
     }else{
    	 $("#_food_table tr:gt(10)").remove();
     }
     //合计项目数量
     $("#totalNum").text($("#_food_table ._have_data").length);
   	//合计样品数量
  // add by xiaoyl 2020-02-21 提交订单时统计样品数量与检测费用
     //合计检测费用
     var totalCost = 0;
     $("#_food_table ._have_data").each(function () {
         totalCost += parseFloat($(this).find("._inspection_fee_input").val());
         foodArray.set($(this).find("input[name=_food_id]").val(),1);
     });
     $("#foodNum").text(foodArray.size);
     $("input[name='inspectionFee']").val(totalCost);
     $("#totalCost").text(totalCost.toFixed(2));
 }
 
</script>