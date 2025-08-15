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
            <a href="javascript:">优惠时间</a></li>
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
	<input name="items" id="items" value="" type="hidden">
	<input name="status" value="0" type="hidden">
<div class="cs-content2 containter cs-add-new clearfix">
    <div class="cs-ul-bg clearfix">
        <ul class="cs-ul-style cs-ul-form clearfix">
            <li class="cs-name cs-sm-w"><i class="cs-mred">*</i>活动主题：</li>
            <li class="cs-in-style cs-md-w">
            	<input type="text" name="theme" id="theme" value="${bean.theme }"  placeholder="">
            </li>
         <%--    <li class="cs-name cs-sm-w"><i class="cs-mred">*</i>活动标题：</li>
            <li class="cs-in-style cs-md-w">
                <input type="text" name="title" id="title" value="${bean.title }" placeholder="">
            </li> --%>
            <li class="cs-name cs-sm-w"><i class="cs-mred">*</i>折扣率：</li>
            <li class="cs-in-style cs-modal-input cs-md-w">
                <input type="text" name="discount"  id="discount" value="${bean.discount }" placeholder="" style="width: 100px;margin-right: 5px">(小数)
            </li>
        <li class="cs-name cs-sm-w"><i class="cs-mred">*</i>开始时间：</li>
            <li class="cs-in-style cs-md-w">
               <input name="timeStart" id="start" style="width: 200px;" class="cs-time Validform_error focusInput" type="text" onclick="WdatePicker({onpicked:function(){changeTime();},dateFmt:'yyyy-MM-dd HH:mm:ss',maxDate:'#F{$dp.$D(\'end\')}'})" datatype="date"  value="<fmt:formatDate value='${bean.timeStart }' pattern='yyyy-MM-dd HH:mm:ss '/>" datatype="date" autocomplete="off" autocomplete="off">
            </li>
            <li class="cs-name cs-sm-w"><i class="cs-mred">*</i>结束时间：</li>
            <li class="cs-in-style cs-md-w">
            <input name="timeEnd" id="end" style="width: 200px;" class="cs-time Validform_error focusInput" type="text" onclick="WdatePicker({onpicked:function(){changeTime();},dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'#F{$dp.$D(\'start\')}'})" value="<fmt:formatDate value='${bean.timeEnd }' pattern='yyyy-MM-dd HH:mm:ss '/>" datatype="date" autocomplete="off">
            </li> 
           
             <%-- <c:if test="${bean.status==1 }">	
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
            </c:if> --%>
             <li  class="cs-name cs-sm-w">优惠项目：</li>
              <li class="cs-in-style cs-md-w">
			     <input id="cs-check-radio-items1" type="radio" value="0" name="applyAllItems" <c:if test="${ empty bean }"> checked="checked" </c:if> <c:if test="${ bean.applyAllItems==0 }"> checked="checked" </c:if> /><label for="cs-check-radio-items1">所有项目</label>
                <input id="cs-check-radio-items2" type="radio" value="1" name="applyAllItems" <c:if test="${bean.applyAllItems==1 }"> checked="checked" </c:if>/><label for="cs-check-radio-items2">自定义项目</label>
            </li>
            <li  class="cs-name cs-sm-w">审核状态：</li>
                    <li class="cs-in-style cs-md-w">
                    
                <input id="cs-check-radio" type="radio" value="1" name="checked" <c:if test="${ empty bean }"> checked="checked" </c:if> <c:if test="${ bean.checked==1 }"> checked="checked" </c:if>/><label for="cs-check-radio">通过</label>
			     <input id="cs-check-radio2" type="radio" value="0" name="checked" <c:if test="${bean.checked==0 }"> checked="checked" </c:if> /><label for="cs-check-radio2">不通过</label>
            </li>
            <li class="cs-name cs-sm-w" style="width: 11.4%;">备注：</li>
            <li class="cs-in-style cs-md-w" style="width: 88.6%; height: auto;">
            	<textarea name="remark" style="width: 93%;height:70px;">${bean.remark}</textarea>
            </li>
            
        </ul>
    </div>
    
</div>
 </form>
 	<div>
    	<div class="cs-content2 choseItem cs-hide">
           	<h3>检测项目
                           
                            <div class="cs-search-box cs-fr">
				              <form action="datagrid.do">
				                <div class="cs-search-filter clearfix cs-fl">
				                <input class="cs-input-cont cs-fl focusInput" type="text" id="search" placeholder="请输入检测项目">
				                <input type="button" onclick="searchKey();" class="cs-search-btn cs-fl" href="javascript:;" value="搜索">
				                </div>
				               <div class="clearfix cs-fr" id="showBtn">
				              <div id="addBtn" class="cs-fr cs-ac">
				              <c:if test="${empty bean || bean.status==0  }"> <a href="javascript:" onclick="addItem();" class="cs-menu-btn"><i class="icon iconfont icon-zengjia"></i>新增</a></c:if>
				              </div></div>
				              </form>
				              
				            </div>
                        </h3>
         </div>

		<div class="cs-tabcontent clearfix choseItem cs-hide" style="">
		<div class="cs-content2 cs-check-project" style="">
 
			<div class="table-roll">
			<table class="cs-table"  >
							<tr>
<!-- 						<th><input type="checkbox" /></th> -->
					    <th class="cs-header"  width="10%"><input type="checkbox" id="itemButton"/></th>
	                    <th class="cs-header" width="20%">检测项目</th>
	                    <th class="cs-header" width="20%">检测项目类型</th>
	                    <th class="cs-header" width="10%">原价(元)</th>
	                    <th class="cs-header" width="20%">优惠价(元)</th>
						<th class="cs-header" width="10%">操作</th>
					</tr>
		 	 <tbody id="dataList"></tbody>
			</table>
			</div>
		</div>

		<div class="cs-bottom-tools choseItem cs-hide">
		<a href="javascript:" class="cs-menu-btn" onclick="deleteItem();"><i class="icon iconfont icon-shanchu text-del"></i>删除</a></div>
	</div>
       </div>  	
    <%@include file="/WEB-INF/view/common/confirm.jsp"%>
    <%@include file="/WEB-INF/view/terminal/specialOffer/selectList.jsp" %>
    <script src="${webRoot}/js/datagridUtil.js"></script>
<script type="text/javascript">
/* $("#myUserModal").modal('toggle'); */

var id='${bean.id}';

var  winh=$(window).height();
var colh=$('.cs-ul-bg').height();
$('.table-roll').height(winh-colh-146);
 
rootPath="${webRoot}/data/detectItem/";
if("${bean.applyAllItems}"=="1"){
	$(".choseItem").removeClass("cs-hide");
}
if("${bean}"!="" && "${bean.status}"!=0){
	$(".containter input").attr("disabled","disabled")
	$(".containter textarea").attr("readonly","readonly")
}
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



$(document).on("input propertychange","#discount",function(){
    var limitNum = $(this).val().replace(/[^0-9.]+/g, "");
    if(limitNum>=0&&limitNum<=100){
        $(this).val(limitNum);
        searchKey();
    }else{
        $(this).val("");
    }
})
$("input[name=applyAllItems]").click(function(e){
	if($("input[name=applyAllItems]:checked").val()==1){
		$(".choseItem").removeClass("cs-hide");
	}else{
		$(".choseItem").addClass("cs-hide");
	}
});

var getItem=true;
function addItem() {
		var timeStart=$("#start").val();
  		if(timeStart==null||timeStart==""){
  			alert("请先选择开始时间!")
  			return;
  		}
  		var timeEnd=$("#end").val();
  		if(timeEnd==null||timeEnd==""){
  			alert("请先选择结束时间!")
  			return;
  		}
	if(getItem){
		getItemlist();
		getItem=false;
	}
	 $("#myUserModal").modal('show'); 
	 
}

var dataList = [];//最终数组列表

 

function workerConfirm() {
	var html='';
    //$("#checkedList tr").remove();
    for (var i = 0; i < itemArray.length; i++) {
    	var id=itemArray[i]["id"];
    	var name=itemArray[i]["name"];
    	var price=itemArray[i]["price"];
    	var typename=itemArray[i]["typename"];
    	var typeid=itemArray[i]["typeid"];
	 
		 addDataList(id, name,price,typename,typeid);//添加到数组
    }
 	
    $("#myUserModal").modal('hide'); 
}

//添加选中的检测项目
function addDataList(id, name,price,typename,typeid) {
	var html='';
	 var discount=$("#discount").val();
	 var dis=price*discount;
	 dis = dis.toFixed(2);
    if (dataList.length > 0) {
        for (var i = 0; i < dataList.length; i++) {
            if (dataList[i]["id"] == id) {
                //检测点ID已存在，不再添加  
                delpointsArray(id); 
                break;
            } else if (i == dataList.length - 1) {
            	
            	   dataList.push({"id": id, "name": name, "price": price, "typename": typename, "typeid": typeid});
            	   delpointsArray(id); 
            	   	 html+='<tr> <th style="width:40px;"><input value="'+id+'" type="checkbox"/>'+(dataList.length)+'</th>  <th>'+name+'</th><th>'+typename+'</th> <th  style="width:200px;">'+price+'</th> <th  style="width:200px;">'+dis+'</th>  <th style="width:40px;"><a class="cs-del cs-del-tr" title="删除" onclick="removeDetail(\''+id+'\')"><i class="icon iconfont icon-shanchu text-del"></i></a> </th></tr>';
            }
        }
    } else {
    	   dataList.push({"id": id, "name": name, "price": price, "typename": typename, "typeid": typeid});
    	   delpointsArray(id); 
    	   	 html+='<tr> <th style="width:40px;"><input value="'+id+'" type="checkbox"/>'+(dataList.length)+'</th>  <th>'+name+'</th><th>'+typename+'</th> <th  style="width:200px;">'+price+'</th> <th  style="width:200px;">'+dis+'</th>  <th style="width:40px;"><a class="cs-del cs-del-tr" title="删除" onclick="removeDetail(\''+id+'\')"><i class="icon iconfont icon-shanchu text-del"></i></a> </th></tr>';
    }
    $("#dataList").append(html);
}

function removeDetail(id) {
    //删除检测点数组元素
        for (var i = 0; i < dataList.length; i++) {
            if (dataList[i].id == id) {
            	itemList.push({"id": dataList[i].id, "detectItemName": dataList[i].name, "price":  dataList[i].price, "remark":  dataList[i].typename, "detectItemTypeid":  dataList[i].typeid});
            	dataList.splice(i, 1);
                break;
            }
        }
/*         
	$("#dataList").empty();
	var html='';
    for (var i = 0; i < dataList.length; i++) {
       	 html+='<tr> <th style="width:40px;"><input value="'+dataList[i]["id"]+'" type="checkbox"/>'+(i+1)+'</th>  <th>'+ dataList[i]["name"]+'</th> <th  style="width:200px;">100</th>  <th style="width:40px;"><a class="cs-del cs-del-tr" title="删除" onclick="removeDetail(\''+dataList[i]["id"]+'\')"><i class="icon iconfont icon-shanchu text-del"></i></a> </th></tr>';
        }
     	$("#dataList").append(html); */
        searchKey();
}

//清除基础列表
function  delpointsArray(id) {
    for (var i = 0; i < itemList.length; i++) {
        if (itemList[i].id == id) {
        	itemList.splice(i, 1);
            break;
        }
    }
}
 
 
 //提交
 function save() {
		var theme=$("#theme").val();
  		if(theme==null||theme==""){
  			 $("#waringMsg>span").html("活动主题不能为空!");
		$("#confirm-warnning").modal('toggle'); 
  			return;
  		}
/* 		var title=$("#title").val();
  		if(title==null||title==""){
  			 $("#waringMsg>span").html("活动标题不能为空!");
		$("#confirm-warnning").modal('toggle'); 
  			return;
  		} */
		var discount=$("#discount").val();
  		if(discount==null||discount==""){
  			 $("#waringMsg>span").html("折扣率不能为空!");
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
		 if(i!=(dataList.length-1)){
		 ids+= dataList[i].id +","   	
		 }else{
			 ids+= dataList[i].id ; 	
		 }
     }
	$("#items").val(ids);
	// update by xiaoyl 2020-04-09选择自定义项目，展示选择检测项目相关操作和列表
	if($("input[name=applyAllItems]:checked").val()==1){
		if(ids==""){
 			$("#waringMsg>span").html("请添加检测项目!");
 			$("#confirm-warnning").modal('toggle'); 
 	 			return;	
 		} 
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
	        url: "${webRoot}/specialOffer/save.do",
	        data: $("#saveForm").serialize(),
	        success: function(data){
	        	if(data && data.success){
	        		$("#waringMsg>span").html(data.msg);
	        		self.location="${webRoot}/specialOffer/list.do";
	        	}else{
	        		 $("#waringMsg>span").html(data.msg); 
	        	}
			}
	    }); 
}
 
 
	//获取当前活动检测项目
 function getItemlistById(id) {
 
			$.ajax({
		           type: "POST",
		           url: '${webRoot}' + "/specialOffer/getItemListById.do?id="+id,
		           data: {},
		           dataType: "json",
		           success: function (data) {
		               if (data && data.success) {
		            	   var obj=data.obj;
		            		$("#dataList").empty();
		            		var html='';
		            	    for (var i = 0; i < obj.length; i++) {
		            	   	 var id=obj[i].itemId;
		               		 var name=obj[i].itemName;
		               		 var price=obj[i].price;
		               		 var typeId=obj[i].typeId;
		               		 var typeName=obj[i].typeName;
		               		 dataList.push({"id": id, "name": name, "price": price, "remark":  typeName, "detectItemTypeid": typeId});
		            	        }
		            	    searchKey();
		         	  }
		           }
		       }); 	
	}
 	
	//搜索查询
	function searchKey() {
		var key= 	$("#search").val();
		if(key!=null&key!=""){
			$("#dataList").empty();
			var html='';
			var html1='';
			var html2='';
			var a=1;
			var ActCheck='${bean.status}';
		    for (var i = 0; i < dataList.length; i++) {
		    	var name=dataList[i]["name"];
		    	var id=dataList[i]["id"];
		    	var price=dataList[i]["price"];
		 		 var discount=$("#discount").val();
           		 var dis=price*discount;
           		dis = dis.toFixed(2);
		    	var typename=dataList[i]["remark"];
		    	if(typename==null||typename=="undefined"){
		    		typename=dataList[i]["typename"];
		    	}
			    	if (name.indexOf(key) != -1) {
						if(name==key&& html==""){//当key==name
							html+='<tr> <th style="width:40px;"><input type="checkbox" value="'+id+'" />'+a+'</th>  <th>'+ name+'</th> <th>'+ typename+'</th> <th >'+price+'</th> <th  >'+dis+'</th>  <th >';
							if(ActCheck!=1){//审核不通过
							html+='<a class="cs-del cs-del-tr" title="删除" onclick="removeDetail(\''+id+'\')"><i class="icon iconfont icon-shanchu text-del"></i></a> ';
							}
							html+='</th></tr>';
			        		 
						}else  if(name==key&& html!=""){//关键字去重
							
						}else if(name.indexOf(key)==0&&name!=key){
							html1+='<tr> <th style="width:40px;"><input type="checkbox" value="'+id+'" />'+a+'</th>  <th>'+ name+'</th><th>'+ typename+'</th> <th  >'+price+'</th> <th  >'+dis+'</th>  <th >'; 
							if(ActCheck!=1&&ActCheck!=2){// 活动不在进行中和已终止 才可以编辑
							html1+='<a class="cs-del cs-del-tr" title="删除" onclick="removeDetail(\''+id+'\')"><i class="icon iconfont icon-shanchu text-del"></i></a> ';
							}
							html1+='</th></tr>';
						}else {
							html2+='<tr> <th style="width:40px;"><input type="checkbox" value="'+id+'" />'+a+'</th>  <th>'+ name+'</th><th>'+ typename+'</th> <th  >'+price+'</th> <th  >'+dis+'</th>  <th >'; 
							if(ActCheck!=1){//审核不通过
							html2+='<a class="cs-del cs-del-tr" title="删除" onclick="removeDetail(\''+id+'\')"><i class="icon iconfont icon-shanchu text-del"></i></a> ';
							}
							html2+='</th></tr>';
						}
			    	a=a+1;
					}
		       }
		     	$("#dataList").append(html+html1+html2);
		}else{
			$("#dataList").empty();
			var html='';
		    for (var i = 0; i < dataList.length; i++) {
		    	var name=dataList[i]["name"];
		    	var id=dataList[i]["id"];
		    	var price=dataList[i]["price"];
		    	var typename=dataList[i]["remark"];
		    	if(typename==null||typename=="undefined"){
		    		typename=dataList[i]["typename"];
		    	}
		 		 var discount=$("#discount").val();
           		 var dis=price*discount;
           		dis = dis.toFixed(2);
		    	html+='<tr> <th style="width:40px;"><input type="checkbox" value="'+id+'" />'+(i+1)+'</th>  <th>'+ name+'</th><th>'+ typename+'</th> <th  style="width:200px;">'+price+'</th> <th  style="width:200px;">'+dis+'</th>  <th style="width:40px;"><a class="cs-del cs-del-tr" title="删除" onclick="removeDetail(\''+id+'\')"><i class="icon iconfont icon-shanchu text-del"></i></a> </th></tr>';
		        }
		     	$("#dataList").append(html);
		}
		
		
	}
	//绑定回车事件,避免搜索检测项目时回车返回json字符串 add by xiaoyl 2019-10-11
	$('#search').bind('keydown',function(event){
        if(event.keyCode == "13")    
        {
        	searchKey();
        }
        event.stopPropagation()
	 });
	$(function(){
		//getItemList();
		if(id){
		getItemlistById(id);
		}
 

	})
	
	function changeTime() {
		var timeStart=$("#start").val();
  		if(timeStart==null||timeStart==""){
  			return;
  		}
  		var timeEnd=$("#end").val();
  		if(timeEnd==null||timeEnd==""){
  		 
  			return;
  		}
		getItemlist();
		getItem=false;
 
	}
	
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
		 $("#dataList input[type='checkbox']").each(function () {
			  if ($(this).is(':checked')) {//删除已选中
				  deleteList($(this).val());
	            }
	        });
		  $("#itemButton").prop("checked", false);
		  searchKey();
	}
	
	
	//批量清除
	function deleteList(id) {
	    //删除检测点数组元素
        for (var i = 0; i < dataList.length; i++) {
            if (dataList[i].id == id) {
            	itemList.push({"id": dataList[i].id, "detectItemName": dataList[i].name, "price":  dataList[i].price, "remark":  dataList[i].typename, "detectItemTypeid":  dataList[i].typeid});
            	dataList.splice(i, 1);
                break;
            }
        }
		
	}
	
    //获取单个选择
    $(document).on("change", "#dataList input[type='checkbox']", function () {
        var all = dataList.length;	//全部数量
        var checkedList = $("#dataList input[type='checkbox']:checked").length;	//已选择检测点数量
        
        if (all == 0 ||checkedList==0|| all > checkedList) {
            $("#itemButton").prop("checked", false);
        } else {
            $("#itemButton").prop("checked", true);
        }
 
    });
</script>
</body>
</html>