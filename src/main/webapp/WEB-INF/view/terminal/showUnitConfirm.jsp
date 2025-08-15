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
    height: 440px;
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
		height:408px;
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
	    height: 382px;
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
</style>
<!-- 一单多个委托单位 -->
<div class="modal fade intro2" id="_show_reg_modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="static" data-keyboard="false" style="display: none;">
 <div class="modal-dialog cs-xlg-width" role="document">
    <div class="modal-content" style="margin-top: 0px;">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
        <h4 class="modal-title" id="myModalLabel">委托单位查看</h4>
      </div>
      <div class="modal-body cs-xlg-height">
        <div class="cs-points-list" style="width:100%;">
          <div class="cs-mechanism-tab">
              <span class="cs-fl cs-font-weight"></span>
              <div class="cs-search-box pull-right">
                  <form>
                      <div class="cs-search-margin clearfix pull-left">
                          <input id="_query_unit_show" class="cs-input-cont pull-left inputData" type="text" placeholder="请输入首字母或全拼搜索">
                          <input type="button" class="cs-search-btn pull-left" href="javascript:;" value="搜索" onclick="loadUnitsData()">
                      </div>
                  </form>
              </div>
          </div>
        <div class="cs-mechanism-list-content" style="padding:0;">
        <div class="cs-mechanism-list-search clearfix">

        </div>
        <div class="cs-mechanism-table-box">
        <table class="cs-mechanism-table _query_req_units" width="100%">
          
        </table>
        </div>
        </div>
        </div>


        
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-danger" data-dismiss="modal">关闭</button>
<!--       <button type="button" class="btn btn-primary cs-hide" id="choseUnits" onclick="saveUnit();">确定</button> -->
      </div>
    </div>
  </div>
</div>
 <script type="text/javascript">
 var samplingId;//订单Id
 $(function(){
	/* if("${isChoose}"==true){
		$("#choseUnits").removeClass("cs-hide");
	} */
 });
 
//打开委托单位窗口
 $("#_show_reg_modal").on('show.bs.modal', function () {
	 loadUnitsData();
 });
 function showRequestUnits(id){
	 samplingId=id;
	 $("#_show_reg_modal").modal("show");
	
 }
 function loadUnitsData(){
	 var html="";
	 if("${isChoose}"==true){//报告打印，展示复选框和确定按钮
		 html+='<tr> <th style="width: 60px;"><input type="checkbox" class="_qru_all" /></th> <th >委托单位</th> <th style="text-align: center; width: 200px;">联系电话</th> </tr>';
	 }else{
		 html+='<tr> <th style="width: 60px;">序号</th> <th >委托单位</th> <th>单位地址</th> </tr>';
	 }
	 $.ajax({
         url: "${webRoot}/reportPrint/queryUnitsBySamplingId.do",
         type: "POST",
         data: {"id":samplingId,"keyWords":$("#_query_unit_show").val()},
         dataType: "json",
         success: function(data){
             if(data && data.success){
            	 $("._query_req_units").html("");
                var json= data.obj;
                $.each(json,function(index,item){
               		 html+='<tr>';
                	 if("${isChoose}"==true){//报告打印，展示复选框和确定按钮
                		 html+='<td><input  type="checkbox" data-id="'+item.requestId+'" />'+(index+1)+'</td><td>'+item.requestName+'</td>';
                		 html+='<td>'+item.param1+'</td>';
                	 }else{
                		 html+='<td>'+(index+1)+'</td><td>'+item.requestName+'</td>';
//                 		 html+='<td>'+item.param1+'</td>';
                		 html+='<td>'+item.param2+'</td>';
                	 }
               	 	html+='</tr>';
                });
                
				 $("._query_req_units").append(html);
             }
         }
     });
	
 }
//回车查询数据
 $(document).on("keydown","#_query_unit_show", function (event) {
     var e = event || window.event || arguments.callee.caller.arguments[0];
     if(e && e.keyCode==13){ //enter键
         loadUnitsData();
         return false;
     }
 });
 // document.onkeydown=function(event){
 //   		var e = event || window.event || arguments.callee.caller.arguments[0];
 //   		if(e && e.keyCode==13){ //enter键
 //   			loadUnitsData();
 //   			return false;
 //   		}
 // }
</script>