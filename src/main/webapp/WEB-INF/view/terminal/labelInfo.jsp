<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/WEB-INF/view/terminal/resource.jsp" %>
<%-- <link rel="stylesheet" type="text/css" href="${webRoot}/css/misson.css" /> --%>

<html>
<head>
    <title>快检服务云平台</title>
    <style type="text/css">
   .search-bar{
	    height: 60px;
	    padding: 5px;
	    
	}
	.search-con input[type=text],.search-con button{
		border: 1px solid #999;
	}
	.select-box{
		/* border-top: 1px solid #999; */
	    /* padding-top: 15px; */
	}
	.select-title{
	    
	   
	}
	.select-part{
		
		padding: 0;
		
	}
	.select-list{
		height: 650px;
		overflow: auto;
	    background: #f1f1f1;
    	padding: 1px;
   	    border: 1px solid #999;
	}
	.btn{
		border-radius: 4px;
	}
	.select-list li{
		line-height: 50px;
		height: 50px;
		border-bottom: 1px solid #999;
		padding-left: 10px;
		/* padding-right: 10px; */
		
		background: #fff;
	}
	.select-all{
		line-height: 52px;
    	height: 52px;
    	border-left: 1px solid #999;
    	border-right: 1px solid #999;
		/* border-bottom: 1px solid #999; */
	}
	.col-lg-5{
		width: 45%;
    	overflow: hidden;
    	/* border: 2px solid #999; */
	}
	.defualt-btn,.defualt-all{
		cursor: pointer;
		color: #337ab7;
	    padding: 0 15px;
	    height: 48px;

	}
	.del-all-btn,.del-btn{
		
	    color: #d9534f;
	    padding: 0 15px;
	    height: 48px;
		cursor: pointer;
	}
	.customize{
		height: 100%;
		padding-top: 280px;
	}
	.customize-btn{
		text-align: center;
	    border: 1px solid #999;
	    border-radius: 4px;
	    height: 40px;
	    line-height: 40px;
	    margin-bottom: 10px;
	    cursor: pointer;
	}
	.defualt-btn{
		font-size: 20px;
	}
	.defualts-btn input[type=radio]{
	    margin: 10px 5px 0 5px;
		height: 20px;
		width: 20px;
	}
	.zz-default{
		padding-left: 48px;
		padding-top: 10px;
	}
	.check-radio{
		display: inline-block;
		padding: 0px 15px;
		background: #fff;
		border: 1px solid #999;
		margin-right: 10px;
		border-radius: 4px;
		cursor: pointer;
		height: 40px;
		line-height: 40px;
	}
	
	.check-radio.active{
		background: #4887ef;
		color: #fff;
	}
	.zz-add-title{
		background:#4887ef;
		color: #fff;
	}
	
    </style>
</head>
<body style="width:1280px;height: 1024px;">
<div class="zz-content">
    	<div class="zz-title2">
			<img class="pull-left" src="${webRoot}/img/terminal/title2.png" alt=""><span >选择单位</span>
			<i class="showTime cs-hide" style="top: 35px;font-size:28px;font-weight:bold;color:#4373e0;border-color:#4373e0;"></i>
    	</div>
		<div class="zz-left"><img src="${webRoot}/img/terminal/left.png" alt=""></div>
		<div class="zz-right"><img src="${webRoot}/img/terminal/right.png" alt=""></div>

<div class="show-modal" >

	<!-- <div class="col-lg-6  search-bar">
	    <div class="input-group search-con">
	      <input type="text" id="inputDataRegLabel" class="form-control inputData" id="keyWords" placeholder="搜索委托单位" autocomplete="off">
	      <span class="input-group-btn">
	        <button class="btn btn-primary" type="button" onclick="loadInspectionUnit(false);">搜索</button>
	      </span>
	    </div>/input-group



  	</div> --><!-- /.col-lg-6 -->
  	<div class="zz-name zz-input col-md-6 col-sm-6" style="padding:10px; padding-left:20px;">
         <div class="pull-left zz-name2" id="labelName">分组名称： </div>
         
    </div>
	<div class="zz-name zz-default col-md-6 col-sm-6 cs-hide" id="setDefault">
          <div class="pull-left zz-name2">设为默认</div>
         <div class="pull-left defualts-btn">
            <span class="pull-left check-radio  active isDefault" data-status="0">否</span>
            <span class="pull-left check-radio  isDefault" data-status="1">是</span> 
           </div> 
      </div>	
    <div class="col-lg-12">
    	<div class="zz-add-title col-lg-6" style="padding:10px;width: 45%;margin-bottom:0;">待选列表</div>
    	<div class="zz-add-title col-lg-6" style="padding:10px;width: 45%;margin-left: 123px;margin-bottom:0;">已选列表</div>
    </div>
	<div class="col-lg-12 select-box">
		<div class="col-lg-5 select-part">
			
			<div class="col-lg-12 select-all">
			<label for="checkedAll1"><input type="checkbox" id="checkedAll1" onclick="checkedAll('left')" >全选</label>
			<div class="pull-right  search-bar" style=" width: 300px;">
			    <div class="input-group search-con">
			      <input type="text" class="form-control inputData" id="inputDataRegSearch" placeholder="请输入首字母或全拼查找单位" autocomplete="off">
			      <span class="input-group-btn">
			        <button class="btn btn-primary" type="button">搜索</button>
			      </span>
			    </div>
		
		  	</div>
			</div>
			<div class="col-lg-12 select-list">
				<ul id="tableFirst">
					
				</ul>
			</div>
		</div>
		<div class="col-lg-1" style="width: 10%; height: 732px">
			<div class="customize">
				<div class="customize-btn btn-primary" onclick="selectNumber();">添加<i class="icon iconfont icon-you"></i></div>
				<div class="customize-btn btn-danger" onclick="deleteNumber('center');"><i class="icon iconfont icon-zuo"></i>移除</div>
				<!-- <div class="customize-btn text-primary" onclick="delAll();">清空</div> -->
			</div>
		</div>
		<div class="col-lg-5 select-part">
			
			<div class="col-lg-12 select-all"><label for="checkedAll2"><input type="checkbox" id="checkedAll2" onclick="checkedAll('right')">全选</label>
				
				<div class="pull-right select-title" style="width: 440px;"><span id="totalNumber"></span>
				<i class="text-primary" id="selectedNumber"></i> <i class="pull-right text-danger" onclick="delAll();">清空</i></div>
			
			</div>
			<div class="col-lg-12 select-list">
				<ul id="tableSecond">
					
				</ul>
			</div>
		</div>
	</div>

	<div class="zz-tb-btns col-md-12 col-sm-12" style="position: absolute; bottom: 20px">
		<a href="javascirpt:;" onclick="returnBack();" class="modal-close btn btn-danger">返回</a>
		
		<a href="javascirpt:;" id="btnSubmit" class="modal-close btn btn-primary">确定</a>
	</div>
</div>

<%@include file="/WEB-INF/view/terminal/returnConfirm.jsp"%>
<%@include file="/WEB-INF/view/terminal/tips.jsp"%>
<%@include file="/WEB-INF/view/terminal/keyboard_input.jsp"%> 
<script type="text/javascript" src="${webRoot}/js/selectSearch.js"></script>
<script type="text/javascript" src="${webRoot}/js/showTime.js"></script>
<script>
var webRoot="${webRoot}";
var list;//待选列表
var labelList;//已选列表
var labelId="${bean}"=="" ? 0 : "${bean.id}"
var operator="${operatorType}";
$(function(){
		parent.currentTime=currentTime;
    	if(operator=="edit"){
	    	loadInspectionUnit(true);
    	}else{
    		dealHtml(null,parent.requestList,JSON.parse(sessionStorage.requesterUnits));
    	}
    	if("${bean}"!="" && !parent.isModify){
    		$("#setDefault").removeClass("cs-hide");
	    	$(".isDefault[data-status='${bean.isdefault}']").addClass("active").siblings().removeClass('active');
    	}
    	$("#labelName").html("分组名称："+$("#inputDataRegLabel", parent.document).val());
    });

    $(document).on('click', '.isDefault', function () {
         $(this).addClass('active').siblings().removeClass('active');
     });
    //isQuery 是否查询用户个人标签
    function loadInspectionUnit(isQuery){
    	$.ajax({
            type: "POST",
            url: webRoot+"/inspUnitUser/loadInspectionUnit.do",
            dataType: "json",
            data:{"id":labelId,"keyWords":$("#inputDataRegSearch").val(),"isQuery":isQuery},
            success: function(data){
                if(data && data.success){
                	if(labelId!=0){
                		list=data.attributes.list;
                		labelList=parent.requestList==null? data.attributes.labelList : parent.requestList;
                	}else if(labelId==0){//默认选择全部
                		list=null;
                		labelList=parent.requestList==null? data.attributes.list : parent.requestList
                	}
	                	dealHtml(list,labelList);
                }
            }
        });
    }
    //list:待选列表，labelList：已选列表，allRequest：所有委托单位
    function dealHtml(list,labelList,allRequest){
    	var tableFirst = $("#tableFirst");
        var tableSecond = $("#tableSecond");
        var selectedListStr=JSON.stringify(labelList);
    	if(list!=null){
            var html="";
            tableFirst.html("");
            for (var i = 0; i < list.length; i++) {
            	if(selectedListStr.indexOf(list[i].requestId)<0){
	            	html+='<li><label for="'+list[i].requestId+'"><input type="checkbox" id="'+list[i].requestId+'" name="checkBoxName" data-name="'+list[i].requestName+'" data-linkPhone="'+list[i].linkPhone+'" data-companyAddress="'+list[i].companyAddress+'">'+list[i].requestName+'</label> </li>';
            	}
            }
            tableFirst.append(html);
    	}else if(parent.toSelectedListStr!=""){
    		$("#tableFirst").append(parent.toSelectedListStr);
    	}else{
    		 tableFirst.html("");
    	}
    	if(labelList!=null){
            var html="";
            tableSecond.html("");
            for (var i = 0; i <labelList.length; i++) {
            	html+='<li><label for="'+labelList[i].requestId+'"><input type="checkbox" id="'+labelList[i].requestId+'" name="checkBoxName" data-name="'+labelList[i].requestName+'" data-linkPhone="'+labelList[i].param1+'" data-companyAddress="'+labelList[i].param2+'" data-userlabel-id="'+labelList[i].id+'">'+labelList[i].requestName+'</label><span class="pull-right text-danger del-btn" onclick="deleteNumber(this);">移除</span></li>';
            }
            tableSecond.append(html);
          //计算一下总人数
            var totalPNumber = $("#tableFirst input").length + $("#tableSecond input").length;//总单位数量
            var selectPNumber =  $("#tableSecond input").length;//已选单位数量
//             $("#totalNumber").html("共" + totalPNumber + "个，");
             $("#totalNumber").html("共" + JSON.parse(sessionStorage.requesterUnits).length + "个，");
            $("#selectedNumber").html("已选择"+selectPNumber+"个");
    	}
    	var showNumber=0;
    	if(allRequest!=null){
    		 var html="";
             tableFirst.html("");
             for (var i = 0; i < allRequest.length; i++) {
            	 if(showNumber<50){
            		 if(labelList.length>0){
	            		 console.log(JSON.stringify(list));
	            		 if(selectedListStr.indexOf(allRequest[i].id)<0){
		            		showNumber++;
		             		html+='<li><label for="'+allRequest[i].id+'"><input type="checkbox" id="'+allRequest[i].id+'" name="checkBoxName" data-name="'+allRequest[i].requesterName+'" data-linkPhone="'+allRequest[i].linkPhone+'" data-companyAddress="'+allRequest[i].companyAddress+'" >'+allRequest[i].requesterName+'</label> </li>';
	            		 }
            		 }else{
            			 showNumber++;
		             	 html+='<li><label for="'+allRequest[i].id+'"><input type="checkbox" id="'+allRequest[i].id+'" name="checkBoxName" data-name="'+allRequest[i].requesterName+'" data-linkPhone="'+allRequest[i].linkPhone+'" data-companyAddress="'+allRequest[i].companyAddress+'">'+allRequest[i].requesterName+'</label> </li>';
            		 }
            	 }else{
            		 break;
            	 }
             }
             tableFirst.append(html);
    	}
    }
    //返回
    function returnBack(){
    	parent.toSelectedListStr=$('#tableFirst li').closest("li");
    	 $(".zz-content" , parent.document).show();
    	 parent.currentTime=currentTime;
    	 $(".showTime", parent.document).addClass("cs-hide");
    	 parent.closeMbIframe();
    }
  
  //计算被被选中的数量
    function calculationNumber() {
        var selectedNumber = $('#tableSecond input').length;
        $("#selectedNumber").html('已选择'+selectedNumber+'个');
        $("input[name=checkBoxName]").prop("checked", false);
    }
  //添加单位
    function selectNumber() {
	    var li = $('#tableFirst li input:checked').closest("li");
        li.find("label").after('<span class="pull-right text-danger del-btn" onclick="deleteNumber(this);">移除</span>');
        li.appendTo($("#tableSecond"));
        $("#checkedAll1,#checkedAll2").prop("checked", false);
        calculationNumber();//计算选中的数量 
    }
  //全部删除
    function delAll() {
        //把右边所有的tr移动到左边
        $.each($('#tableSecond li'), function (index, item) {
            var li = $(item).closest("li");
            li.find("span").remove();
            li.appendTo("#tableFirst");
        });
        $("#checkedAll2").prop("checked", false);
        calculationNumber();//计算选中的数量
    }
  function checkedAll(direction){
	  if(direction=='left'){
		  if($("#checkedAll1").prop("checked")){
			  $("#tableFirst input[name=checkBoxName]").prop("checked", true);
		  }else{
			  $("#tableFirst input[name=checkBoxName]").prop("checked", false);
		  }
	  }else if(direction=='right'){
		  if($("#checkedAll2").prop("checked")){
		  	$("#tableSecond input[name=checkBoxName]").prop("checked", true);
		  }else{
			  $("#tableSecond input[name=checkBoxName]").prop("checked", false);
		  }
	  }
  }
  //删除选中的单位
    function deleteNumber(obj) {
    	 var li;
	  if(obj!='center'){
		   li=$(obj).closest("li");
	  }else{
          li = $('#tableSecond li input:checked').closest("li");
	  }
        li.find("span").remove();
        li.appendTo("#tableFirst");
        calculationNumber();//计算选中的数量
    }
    //当点击确认按钮,获取右边所有的input中的id,传递该id数组到后台进行迭代保存
    $("#btnSubmit").click(function () {
    	clearInterval(timeInterval);
    	 parent.currentTime=currentTime;
    	 $(".showTime", parent.document).addClass("cs-hide");
        //拿到右边有的
        var arryList = [];
        var deleteArrId = [];
        parent.toSelectedListStr=$('#tableFirst li').closest("li");
        $.each($('#tableSecond input'), function (index, item) {
            arryList.push({requestId : parseInt($(item).attr("id")),requestName : $(item).attr("data-name"),param1:$(item).attr("data-linkPhone"),param2:$(item).attr("data-companyAddress")});
            
        });
        $.each($('#tableFirst input'), function (index, item) {
        	var deleteId=$(item).attr("data-userlabel-id");
        	if(deleteId!=undefined){
	        	deleteArrId[index] = deleteId;
        	}
        });
        if(arryList.length>0){
	        saveLabel(arryList,deleteArrId);
        }else{
        	tips("请选择委托单位");
        }
    });

    //批量保存ajax请求
    function saveLabel(ids,deleteArrId) {
    	if("${operatorType}"=="0"){//编辑单位标签
    		 $.ajax({
 	            type: 'POST',
 	            url: "${webRoot}/inspUnitUser/saveLabel.do",
 	            traditional: true,//如果Post是string数组或者int数组，则ajax中traditional: true,如果Post是对象数组，则ajax中traditional: false,否则对象将为空
 	            data: {
 	            	"id":"${bean.id}",
 	            	"labelName":"${bean.labelName}",
 	            	"isdefault":$(".defualts-btn").find(".active").attr("data-status"),
 	            	"details":JSON.stringify(ids),
 	            	"deleteIds":deleteArrId,
 	            },
 	            dataType: 'json',
 	            success: function (data) {
 	                if (data.success) {
 	                	 $(".zz-content" , parent.document).show();
 	                	 parent.loadLabels();
 	                	 parent.closeMbIframe();
 	                } else {
 	                   tips(data.msg);
 	                }
 	            }
 	        });
    	}else{
    		 $(".zz-content" , parent.document).show();
        	 parent.closeMbIframe();
			if(parent.requestList.sort().toString()!=ids.sort().toString()){//判断用户是否修改过单位，修改后表示显示N个委托单位
				if(ids.length>1){
					$("#inputDataRegLabel", parent.document).val(ids.length+'个委托单位');
				}else{
					$("#inputDataRegLabel", parent.document).val(ids[0].requestName);
				}
	        	 parent.requestList=ids;
	        	 parent.isModify=true;
			}
			if($(".defualts-btn").find(".active").attr("data-status")!="${bean.isdefault}" && labelId!=0){//修改过是否默认标签
				$.ajax({
	 	            type: 'POST',
	 	            url: "${webRoot}/inspUnitUser/setDefaultlabel.do",
	 	            data: { "id":"${bean.id}","isdefault":$(".defualts-btn").find(".active").attr("data-status") },
	 	            dataType: 'json',
	 	            success: function (data) {
	 	                if (data.success) {
	 	                	console.log("设置默认标签成功");
	 	                	parent.queryHistory(true,true,true,true);
	 	                } else {
	 	                	console.log("设置默认标签失败");
	 	                }
	 	            }
	 	        });
			}
     		 console.log(parent.requestList);
    	}
    }
    function callBackFunction(){
    	parent.location.href="${webRoot}/terminal/logout.do";
	}
</script>
</body>
</html>
