<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<style type="text/css">
	html,body,.zz-content{/*
		overflow:hidden;
		min-height:1024px;
		height:auto;*/
		/* width:auto; */
	}
	
 	#myContent2{display:none}  
 	.cs-xlg-width {
    	width: 900px;
	}
	.cs-xlg-height {
    height: 600px;
    overflow: auto;
	}
	.tex-center{
		text-align:center;
	}
	.cs-mechanism-list, .cs-points-list, .cs-secleted-list{
	    
	    float: left;
	    width: 300px;
	    background: #ddd;
	    border: 1px solid #ddd;
	    overflow: hidden;
	    border-radius: 4px;
		height:568px;
	}
	.cs-mechanism-table-box{
		overflow:auto;
	}
     .cs-mechanism-list-title,.cs-points-list .cs-mechanism-tab{
     height: 39px;
     line-height: 39px;
     padding: 0 10px;
	 border-bottom: 1px solid #ddd;
	 text-align: left;
     }
     .cs-mechanism-list-content{
        width:100%;
	    background: #fff;
	    height: 520px;
	    overflow: auto;

     }
    .cs-search-box  .cs-input-cont {
    border: 1px solid #ddd;
    height: 30px;
    width: 200px;
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
.cs-mechanism-table tr {
    background: #fff;
    height: 32px;
}
.cs-mechanism-table th, .cs-mechanism-table td {
    border: 1px solid #ddd;
    padding:10px;
    
}
/* th {
    background: #f1f1f1;
    color: #000;
    font-weight: normal;
    font-size: 14px;
    padding: 10px;
} */

.cs-points-list .cs-search-box{
	position:static;
}
.zz-base-info .zz-input {
    line-height: 40px;
    height: 40px;
}
th.zz-tb-title {
    background: #4887ef;
    color: #fff;
}
.zz-xiugai {
    font-size: 20px;
    background: #156df8;
    height: 40px;
    width: 40px;
    display: inline-block;
    text-align: center;
    color: #fff;
    border-radius: 0 4px 4px 0;
    margin-left: 5px;
}
table {
    text-align: center;
}
.cs-mechanism-table th,.cs-mechanism-table td{
	text-align: center;
}
.print-all2{
	padding: 10px 70px;
/*     background: #ddd; */
    float: left;
    margin-right: 10px;
    cursor: pointer;
	border-radius: 5px 5px 0 0;
    line-height: 32px;
    height: 46px;
    font-size: 18px;
}
.print-current2 {
    background: #4887ef;
}
</style>
<!-- 一单多个委托单位 -->
<div class="modal fade intro2" id="_chose_reg_modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="static" data-keyboard="false" style="display: none;">
 <div class="modal-dialog cs-xlg-width" role="document">
    <div class="modal-content" style="margin-top: 0px;">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
        <h4 class="modal-title" id="myModalLabel">选择打印报告单位</h4>
      </div>
      <div class="modal-body cs-xlg-height">
        <div class="cs-points-list" style="width:100%;">
        <div class="print-btns clearfix">
        	<div class="print-all2 print-current2" data-id="0">待打印单位</div>
				<div class="print-all2" data-id="1">已打印单位</div>

			</div>
          <!-- <div class="cs-mechanism-tab">
              <span class="cs-fl cs-font-weight"></span>
              <div class="cs-search-box pull-right">
                  <form>
                      <div class="cs-search-margin clearfix pull-left">
                          <input id="_query_unit" class="cs-input-cont pull-left inputData" type="text" placeholder="请输入首字母或全拼搜索">
                          <input type="button" class="cs-search-btn pull-left" href="javascript:;" value="搜索" onclick="loadData()">
                      </div>
                  </form>
              </div>
          </div> -->
        <div class="cs-mechanism-list-content" style="padding:0;">
        <div class="cs-mechanism-list-search clearfix">

        </div>
        <div class="cs-mechanism-table-box">
        <table class="cs-mechanism-table" width="100%">
			<thead>
				<tr> <th style="width: 60px;"><input type="checkbox" class="_qru_all" id="checkAllUnits" onclick="checkedPrintAll();" /></th> 
				<th >委托单位</th> 
<!-- 				<th style="text-align: center; width: 200px;">联系电话</th> -->
				<th style="text-align: center; width: 200px;">单位地址</th>
				 </tr>
			</thead>
			<tbody class="_query_req_units_body">
			
			</tbody>
        </table>
        </div>
        </div>
        </div>


        
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-danger" data-dismiss="modal">返回</button>
      	<button type="button" class="btn btn-primary" id="choseUnits" onclick="sendPrintReport();">确定</button>
      </div>
    </div>
  </div>
</div>
 <script type="text/javascript">
 var choserequestList=[];//已选择委托单位列表
 var tabId;//0待打印，1已打印
 $(function(){
	 $(document).on('click','.print-all2',function(){
			var ti=$(this).index();
			tabIndex=$(this).attr("data-id");
			$(this).addClass('print-current2').siblings().removeClass('print-current2')
			loadChoseUnitsData(false);
// 			$('.zz-printed').eq(ti).show().siblings('.zz-printed').hide();
	});
	 $(document).on('change','input[name=checkBoxNamePrint]',function(){
		 var cbs = document.getElementsByName("checkBoxNamePrint");
         var mbStatus = true;	//选中全选复选框
         for (var i = 0; i < cbs.length; i++) {
             if (!cbs[i].checked) {
                 mbStatus = false;
                 break;
             }
         }
         document.getElementById("checkAllUnits").checked = mbStatus;
	});
 });
 
//打开委托单位窗口
 $("#_chose_reg_modal").on('show.bs.modal', function () {
	 loadChoseUnitsData(true);
 });

 function loadChoseUnitsData(isFirst){
	 var html="";
	 //tabId: 0待打印，1已打印
    tabId=$(".print-current2").attr("data-id");
		 $.ajax({
	         url: "${webRoot}/reportPrint/queryUnitsForPrint.do",
	         type: "POST",
	         data: {"id":samplingId,"printType":tabId,"collectCode":collectCode},//,"keyWords":$("#_query_unit").val()
	         dataType: "json",
	         success: function(data){
	             if(data && data.success){
	            	 $("._query_req_units_body").html("");
	            	 $("._qru_all").prop("checked",false);
	                var json= data.obj;
	                if(json.length!=0){
	                	$.each(json,function(index,item){
		               		/*  html+='<tr>';
		               		 html+='<td><input  type="checkbox"  name="checkBoxNamePrint" checked data-id="'+item.requestId+'" data-requesterName="'+item.requestName+'" data-linkPhone="'+item.param1+'" data-printId="'+item.printId+'"/>'+(index+1)+'</td><td>'+item.requestName+'</td>';
		               		 html+='<td>'+item.param1+'</td>';
		               	 	 html+='</tr>'; */
	                		 html+='<tr>';
		               		 html+='<td><input  type="checkbox"  name="checkBoxNamePrint" checked data-id="'+item.requestId+'" data-requesterName="'+item.requestName+'" data-linkPhone="'+item.param1+'" data-companyAddress="'+item.param2+'" data-printId="'+item.printId+'"/>'+(index+1)+'</td><td>'+item.requestName+'</td>';
		               		 html+='<td>'+item.param2+'</td>';
		               	 	 html+='</tr>';
		                });
						 $("._query_req_units_body").append(html);
						 $("._qru_all").prop("checked",true);
						 choserequestList=json;
	                }else if(tabId==0 && isFirst){
	                	//$(".print-all2").eq(0).addClass('cs-hide');
	                	$(".print-all2").eq(1).addClass('print-current2').siblings().removeClass('print-current2');
	                	loadChoseUnitsData();
	                }
	             }
	         }
	     });
    
	
 }
 function checkedPrintAll(){
	  if($("._qru_all").prop("checked")){
		  $("._query_req_units_body input[name=checkBoxNamePrint]").prop("checked", true);
	  }else{
		  $("._query_req_units_body input[name=checkBoxNamePrint]").prop("checked", false);
	  }
 }
//回车查询数据
 document.onkeydown=function(event){
   		var e = event || window.event || arguments.callee.caller.arguments[0];        
   		if(e && e.keyCode==13){ //enter键
   			loadUnitsData();
   			return false;
   		}
 }
</script>