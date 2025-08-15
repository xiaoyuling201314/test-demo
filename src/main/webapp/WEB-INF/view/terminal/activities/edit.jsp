<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/WEB-INF/view/common/resource.jsp" %>
<html>
<head>
    <title>快检服务云平台</title>
    <link rel="stylesheet" type="text/css" href="${webRoot}/plug-in/ztree/css/zTreeStyle.css"/>
        <style type="text/css">
        .cs-tabcontent {
            padding-top: 0px;
        }
        table.cs-table{
        	width:100%;
        }
         table.cs-table td,.cs-mechanism-list-content table td{
			text-align: center;
			border: 1px solid #ddd;
        }
        .table-roll{
        	height: 300px;
        	overflow:auto;
        }
        </style>
</head>
<body>

<div class="cs-col-lg clearfix">
    <!-- 面包屑导航栏  开始-->
    <ol class="cs-breadcrumb">
        <li class="cs-fl">
           <img src="${webRoot}/img/set.png" alt="" />
            <a href="javascript:">充值</a></li>
        <li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
        <li class="cs-b-active cs-fl">新增活动
        </li>
    </ol>
    <!-- 面包屑导航栏  结束-->
    <div class="cs-search-box cs-fr">
        <form>
            <div class=" cs-fr cs-ac ">
               <c:if test="${empty bean || bean.status==0  }">  <a class="cs-menu-btn" href="javascript:" onclick="save();"><i class="icon iconfont icon-save"></i>保存</a> </c:if>
                <a class="cs-menu-btn" href="javascript:" onClick="javascript:history.back(-1);"><i class="icon iconfont icon-fanhui"></i>返回</a>
            </div>
        </form>
    </div>
</div>
<!-- -表单提交 -->
	<form id="saveForm"   method="post">
	<input name="id" value="${bean.id }" type="hidden">
	<input name="details" id="details" value="" type="hidden">
	<input name="status" value="0" type="hidden">
<div class="cs-content2 containter cs-add-new clearfix">
    <div class="cs-ul-bg clearfix">
        <ul class="cs-ul-style cs-ul-form clearfix">
            <li class="cs-name cs-sm-w"><i class="cs-mred">*</i>活动主题：</li>
            <li class="cs-in-style cs-md-w">
            	<input type="text" name="theme" id="theme" value="${bean.theme }"  placeholder="">
            </li>
        <li class="cs-name cs-sm-w"><i class="cs-mred">*</i>开始时间：</li>
            <li class="cs-in-style cs-md-w">
               <input name="timeStart" id="start" style="width: 200px;" class="cs-time Validform_error focusInput" type="text" onclick="WdatePicker({onpicked:function(){changeTime();},dateFmt:'yyyy-MM-dd HH:mm:ss',maxDate:'#F{$dp.$D(\'end\')}'})" datatype="date"  value="<fmt:formatDate value='${bean.timeStart }' pattern='yyyy-MM-dd HH:mm:ss '/>" datatype="date" autocomplete="off" autocomplete="off">
            </li>
            <li class="cs-name cs-sm-w"><i class="cs-mred">*</i>结束时间：</li>
            <li class="cs-in-style cs-md-w">
            <input name="timeEnd" id="end" style="width: 200px;" class="cs-time Validform_error focusInput" type="text" onclick="WdatePicker({onpicked:function(){changeTime();},dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'#F{$dp.$D(\'start\')}'})" value="<fmt:formatDate value='${bean.timeEnd }' pattern='yyyy-MM-dd HH:mm:ss '/>" datatype="date" autocomplete="off">
            </li> 
           <c:if test="${bean.status==1 }">	
               <li  class="cs-name cs-sm-w">活动状态：</li>
                    <li class="cs-in-style cs-md-w">
          		<input type="text"  value="进行中"  readonly="readonly">
            </li>
            </c:if>
        
           <c:if test="${bean.status==2 }">	
               <li  class="cs-name cs-sm-w">活动状态：</li>
                    <li class="cs-in-style cs-md-w">
          		<input type="text"  value="已终止"  readonly="readonly">
            </li>
            </c:if>
                <li  class="cs-name cs-sm-w">审核状态：</li>
                    <li class="cs-in-style cs-md-w">
                    
                <input id="cs-check-radio" type="radio" value="1" name="checked" <c:if test="${ empty bean }"> checked="checked" </c:if> <c:if test="${ bean.checked==1 }"> checked="checked" </c:if>/><label for="cs-check-radio">通过</label>
			     <input id="cs-check-radio2" type="radio" value="0" name="checked" <c:if test="${bean.checked==0 }"> checked="checked" </c:if> /><label for="cs-check-radio2">不通过</label>
            </li>
        </ul>
    </div>
    
</div>
 </form>
    	<div class="cs-content2">
           	<h3>充值选项
                           
                            <div class="cs-search-box cs-fr">
				              <form action="datagrid.do">
				                <div class="cs-search-filter clearfix cs-fl">
				                </div>
				               <div class="clearfix cs-fr" id="showBtn">
				              <div id="addBtn" class="cs-fr cs-ac">
				              <c:if test="${empty bean || bean.checked==0  }"> <a href="javascript:" onclick="addItem('add');" class="cs-menu-btn"><i class="icon iconfont icon-zengjia"></i>新增</a></c:if>
				              </div></div>
				              </form>
				              
				            </div>
                        </h3>
          	</div>

		<div class="cs-tabcontent clearfix" style="">
		<div class="cs-content2 cs-check-project" style="">
 
			<div class="table-roll">
			<table class="cs-table"  >
							<tr>
<!-- 						<th><input type="checkbox" /></th> -->
					    <th class="cs-header"  width="10%"><input type="checkbox" id="itemButton"/></th>
	                    <th class="cs-header" width="30%">充值金额（元）</th>
	                    <th class="cs-header" width="30%">赠送金额（元）</th>
	                  <!--   <th class="cs-header" width="20%">审核状态</th> -->
						<th class="cs-header" width="10%">操作</th>
					</tr>
		 	 <tbody id="dataList"></tbody>
			</table>
			</div>
		</div>

		<div class="cs-bottom-tools">
		<!-- <a href="javascript:;" class="cs-menu-btn" onclick="deleteItem();"><i class="icon iconfont icon-shanchu text-del"></i>删除</a></div> -->
	</div>
         	
         	<!-- Modal 3 小-->
<div class="modal fade intro2" id="myUserModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog cs-sm-width" role="document">
    <div class="modal-content ">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">充值额度设置</h4>
      </div>
	 <input  id="detailId" value="" type="hidden">
      <div class="modal-body cs-sm-height">
         <!-- 主题内容 -->
    
      <div class="cs-content2">
        <div class=" cs-warn-box clearfix">
          <!-- <h5 class="cs-title-s">预警设置</h5> -->
          
          <div class="cs-fl ">充值金额：<input type="text"  id="actualMoney" class="cs-warn " style="width: 100px" /><i> 元</i>
          </div>
          <div class="cs-fl cs-warn-r cs-warn-rh">赠送： <input type="text" id="giftMoney" class="cs-warn " style="width: 100px"  /><i>元</i>
          </div>
          
        </div>
        <div class=" cs-warn-box clearfix">
          <!-- <h5 class="cs-title-s">预警设置</h5> -->
          
          <div class="cs-fl ">   <span style="padding-left: 28px;">排序：</span><input type="text"  id="sorting" class="cs-warn " style="width: 100px" /><i> </i>
          </div>
        
          
        </div>
        <div class="text-danger" style="padding-left:72px;" id="MSG"></div>
<!--         <ul class="cs-ul-form clearfix">
                    <li class="cs-name col-xs-3 col-md-3" style="width: 72px">审核状态：</li>
                    <li class="cs-al cs-modal-input">
	         		    <input id="cs-check-radio2" type="radio" value="1" name="checked1"  checked="checked"><label for="cs-check-radio2">已审核</label>
     					<input id="cs-check-radio" type="radio" value="0" name="checked1"><label for="cs-check-radio">未审核</label>
                    </li>
                </ul> -->
        
      </div>
    
      </div>
      <div class="modal-footer">
      <button type="button"  onclick="add();" class="btn btn-success">确定</button>
        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      </div>
    </div>
  </div>
</div>
         	
    <%@include file="/WEB-INF/view/common/confirm.jsp"%> 
    <script src="${webRoot}/js/datagridUtil.js"></script>
<script type="text/javascript">
/* $("#myUserModal").modal('toggle'); */

var id='${bean.id}';

var  winh=$(window).height();
var colh=$('.cs-ul-bg').height();
$('.table-roll').height(winh-colh-146);
 
rootPath="${webRoot}/data/detectItem/";
for (var i = 0; i < childBtnMenu.length; i++) {
	if (childBtnMenu[i].operationCode == "411-1") {
	 
	}else if (childBtnMenu[i].operationCode == "411-2") {
		edit = 1;
		editObj=childBtnMenu[i];
	}else if (childBtnMenu[i].operationCode == "411-3") {
		deletes = 1;
		deleteObj=childBtnMenu[i];
	} else if (childBtnMenu[i].operationCode == "411-4") {
		exports = 1;
		exportObj=childBtnMenu[i];
	} 
} 
var dataList = [];//最终数组列表
var details=[];

$(function(){
	if(id){
	getItemlistById(id);
	}


})

	    //全选按钮
    $(document).on("change", "#itemButton", function () {
        if ($(this).is(':checked')) {
            $("#dataList input[type='checkbox']").prop("checked", true);
        } else {
            $("#dataList input[type='checkbox']").prop("checked", false);
       
        }
    });
    
//清除检测项目
function deleteItem() {
	var ids="";
	 $("#dataList input[type='checkbox']").each(function () {
		  if ($(this).is(':checked')) {//删除已选中
			  ids+=$(this).val()+",";
            }
        });
	  $("#itemButton").prop("checked", false);
	   console.log(ids);
}
    

//添加赠送额度
function add() {
	var id=$("#detailId").val();
 	var a=id;
 	if(a==""){
 		a=-1;
 	}
	var actualMoney=$("#actualMoney").val();
	var giftMoney=$("#giftMoney").val();
	var sorting=$("#sorting").val();
	var checked = $('input[name="checked1"]:checked').val();
	actualMoney=Number(actualMoney);
	giftMoney=Number(giftMoney);
	if(actualMoney==null||actualMoney==""){
		 alertMSG("充值金额不能为空!"); 
	  			return;
	}
	if(actualMoney<=0){
		 alertMSG("充值金额必须大于0!"); 
			return;
	}
	
	if(giftMoney==null||giftMoney==""){
		 alertMSG("赠送金额不能为空!"); 
	  		return;
	}
	if(giftMoney>actualMoney){
		 alertMSG("赠送金额不能大于充值金额!");  
  		return;
	}
	var extis=true;
    if (dataList.length > 0) {
        for (var i = 0; i < dataList.length; i++) {
            if (dataList[i]["id"]==a||dataList[i]["actualMoney"]==actualMoney) {
            	extis=false;
            	dataList[i]["actualMoney"]=actualMoney;
            	dataList[i]["giftMoney"]=giftMoney;
            	dataList[i]["checked"]=checked;
            	if(sorting!=(i+1)){//修改排序
            		dataList.splice(i, 1);
            		dataList.splice(sorting-1, 0, {"sorting":sorting,"id": id,"actualMoney": actualMoney, "giftMoney": giftMoney});
            	}
                break;
            }  
        }
    }
    var html="";
    if(extis){//如果额度不存在
    	var n=dataList.length+1;
    	if(sorting>=n){//最大值往后叠加
    		var check="";
    			if(checked==1){
    				check="已审核";
    			}else{
    				check="未审核";
    			}
	    	 dataList.push({"sorting":n,"id": a+n,"actualMoney": actualMoney, "giftMoney": giftMoney});
			 html+='<tr> <th style="width:40px;"><input value="'+n+'" type="checkbox"/>'+(n)+'</th>  <th>'+actualMoney+'</th><th>'+giftMoney+'</th><th style="width:40px;">';
			 html+='<a class="cs-del cs-del-tr" title="编辑" onclick="addItem(\''+n+'\')"><i class="icon iconfont icon-xiugai" style="margin-right: 5px;"></i></a>';
			 html+='<a class="cs-del cs-del-tr" title="删除" onclick="removeDetail(\''+n+'\')"><i class="icon iconfont icon-shanchu text-del"></i></a>';
			 html+='</th></tr>';
		  	$("#dataList").append(html);
    	}else {//小于n
    		sorting=sorting-1;
    		if(sorting<0){
    			sorting=0;                                                                                                              
    		}
    		dataList.splice(sorting, 0, {"sorting":sorting,"id": a,"actualMoney": actualMoney, "giftMoney": giftMoney});
    		resDataList();
    	}                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       
    }else{//询问是否覆盖!
    	resDataList();
    }
    $("#myUserModal").modal('hide'); 
}
function removeDetail(id) {
	//$("#confirm-delete").modal('toggle');
	 for (var i = 0; i < dataList.length; i++) {
        if (dataList[i].sorting == id) {
        	dataList.splice(i, 1);
        	resDataList();
            break;
        }
    }
}
function deleteData() {
	 //删除检测点数组元素
    for (var i = 0; i < dataList.length; i++) {
        if (dataList[i].sorting == id) {
        	dataList.splice(i, 1);
        	resDataList();
            break;
        }
    }
	
}

function resDataList() {
	$("#dataList").empty();
	var html='';
	var ActCheck='${bean.status}';//活动已审核状态
    for (var i = 0; i < dataList.length; i++) {
    	var actualMoney=dataList[i]["actualMoney"];
    	var id=dataList[i]["id"];
    	var giftMoney=dataList[i]["giftMoney"];
  		var n=i+1;
    	dataList[i]["sorting"]=n;
    	var checked=dataList[i]["checked"];
    	var check="";
		if(checked==1){
			check="已审核";
		}else{
			check="未审核";
		}
    	//html+='<tr> <th style="width:40px;"><input value="'+n+'" type="checkbox"/>'+n+'</th>  <th>'+actualMoney+'</th><th>'+giftMoney+'</th> <th  style="width:200px;">已审核</th><th style="width:40px;"><a class="cs-del cs-del-tr" title="删除" onclick="removeDetail(\''+n+'\')"><i class="icon iconfont icon-shanchu text-del"></i></a> </th></tr>';
		 html+='<tr> <th style="width:40px;"><input value="'+n+'" type="checkbox"/>'+(n)+'</th>  <th>'+actualMoney+'</th><th>'+giftMoney+'</th>  <th style="width:40px;">';
	
		if(ActCheck!=1&&ActCheck!=2){// 活动不在进行中和已终止 才可以编辑
		 html+='<a class="cs-del cs-del-tr" title="编辑" onclick="addItem(\''+n+'\')"><i class="icon iconfont icon-xiugai" style="margin-right: 5px;"></i></a>';
		 html+='<a class="cs-del cs-del-tr" title="删除" onclick="removeDetail(\''+n+'\')"><i class="icon iconfont icon-shanchu text-del"></i></a>';
		}
		 
		 html+='</th></tr>';    
    }
     	$("#dataList").append(html);
	
}


	function addItem(n) {
		if(n=="add"){//新增
		$("#actualMoney").val("");
		$("#detailId").val("");
		$("#giftMoney").val("");
		$("#sorting").val(dataList.length+1);
		}else{
			var i=n-1;
	    	$("#detailId").val(dataList[i]["id"]);
	    	$("#actualMoney").val(dataList[i]["actualMoney"]);
			$("#giftMoney").val(dataList[i]["giftMoney"]);
			$("#sorting").val(n);
		}
		 $("#myUserModal").modal('show'); 
	}

//显示提示框
function alertMSG(msg) {
	$("#MSG").html(msg);
	$("#MSG").show();
	setTimeout ('closeMSG();',2000);
}

//关闭提示框
function closeMSG() {
	$("#MSG").hide();
}

//提交
function save() {
		var theme=$("#theme").val();
 		if(theme==null||theme==""){
 			 $("#waringMsg>span").html("活动主题不能为空!");
		$("#confirm-warnning").modal('toggle'); 
 			return;
 		}
		var timeStart=$("#start").val();
 		if(timeStart==null||timeStart==""){
 			 $("#waringMsg>span").html("请先选择开始时间!");
		$("#confirm-warnning").modal('toggle'); 
 			return;
 		}
 	 
 		var timeEnd=$("#end").val();
 		if(timeEnd==null||timeEnd==""){
 		$("#waringMsg>span").html("请先选择结束时间!");
		$("#confirm-warnning").modal('toggle'); 
 			return;
 		}
	
	 var ids="";
	 for (var i = 0; i < dataList.length; i++) {
			var actualMoney=dataList[i]["actualMoney"];
	    	var sorting=i+1;
	    	var giftMoney=dataList[i]["giftMoney"];
	    	var id=dataList[i]["id"];
	    	var checked=0;
		var detail = {"id":id  ,"actualMoney":actualMoney,"giftMoney":giftMoney,"checked":checked,"sorting":sorting};
 		details.push(detail);
    }
 		$("#details").val(JSON.stringify(details));
 		
 		if(details.length==0){
 			$("#waringMsg>span").html("请添加充值选项!");
 			$("#confirm-warnning").modal('toggle'); 
 	 			return;	
 		}
 		
 		var checked = $('input[name="checked"]:checked').val();
 		 if(checked==1){
 		var now = new Date();
 		var s1 = (new Date(timeStart)).getTime();
 		var s2 = now.getTime();
 		var s3 = (new Date(timeEnd)).getTime();
 		
 			 if(s3<=s2){//结束时间不能大于当前时间
 				$("#waringMsg>span").html("活动结束时间已过，该活动不能保存!");
 				$("#confirm-warnning").modal('toggle'); 
 				return;
 			 }
 			 if(s1<=s2){//开始时间
 				$("#waringMsg>span").html("活动开始时间已过，活动将会在保存后立即开启!");
 				$("#confirm-warnning").modal('toggle'); 
 			 }
 		 }
	
	  $.ajax({
	        type: "POST",
	        url: "${webRoot}/activities/save.do",
	        data: $("#saveForm").serialize(),
	        success: function(data){
	        	if(data && data.success){
	        		$("#waringMsg>span").html(data.msg);
	        		$("#confirm-warnning").modal('toggle'); 
	        		self.location="${webRoot}/activities/list.do";
	        	}else{
	        		 $("#waringMsg>span").html(data.msg); 
	        		 $("#confirm-warnning").modal('toggle'); 
	        	}
			}
	    });
}

//获取当前活动 
function getItemlistById(id) {

			$.ajax({
		           type: "POST",
		           url: '${webRoot}' + "/activities/getByActId.do?id="+id,
		           data: {},
		           dataType: "json",
		           success: function (data) {
		               if (data && data.success) {
		            	   var obj=data.obj;
		            		$("#dataList").empty();
		            		var html='';
		            	    for (var i = 0; i < obj.length; i++) {
		            	   	 var id=obj[i].id;
		               		 var actualMoney=obj[i].actualMoney;
		               		 var giftMoney=obj[i].giftMoney;
		               		 dataList.push({"sorting":i+1,"id": id,  "actualMoney":  actualMoney, "giftMoney": giftMoney});
		            	        }
		            	    resDataList();
		         	  }
		           }
		       }); 	
	}
</script>
</body>
</html>