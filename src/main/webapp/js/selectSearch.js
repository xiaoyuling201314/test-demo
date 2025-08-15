//是否搜索过
var isSearch=false;
$(function(){
	 $(".inputData").on("keyup",function(e){
			  var currentId=$(this).attr("id");
			  var keyWordStr=$(this).val().trim();
		switch (currentId) {
			case "inputDataReg"://委托单位查询
				if(keyWordStr!=''){
					requesterUnits=JSON.parse(sessionStorage.requesterUnits);
					  queryOption=searchData(currentId,keyWordStr,requesterUnits);
					  queryOption.sort(function (a,b){
						  return a.requesterName.length-b.requesterName.length;
					  });
				 }else{
					  queryOption=requesterHistory;
				 }
					  detalHtml(0,queryOption);
				break;
			case "inputDataRegLabel"://委托单位标签查询
				if(keyWordStr!=''){
					  queryOption=searchData(currentId,keyWordStr,requesterLabelHistory);
					  queryOption.sort(function (a,b){
						  return a.labelName.length-b.labelName.length;
					  });
					  detalHtml(4,queryOption,true);
				 }else{
					 queryOption=requesterLabelHistory;
					 detalHtml(4,queryOption,false);
				 }
				break;
			case "inputDataRegSearch"://委托单位待选列表查询
				if(keyWordStr!=''){
					  requesterUnits=JSON.parse(sessionStorage.requesterUnits);
					  queryOption=searchData("inputDataReg",keyWordStr,requesterUnits);
					  queryOption.sort(function (a,b){
						  return a.requesterName.length-b.requesterName.length;
					  });
					  detalHtml(5,queryOption);
					  isSearch=true;
				 }else{
					 if(operator=="edit" && !isSearch){
					    	loadInspectionUnit(true);
			    	 }else if(isSearch){//清空左侧待选列表
			    		 isSearch=false;
			    		 $("#tableFirst").html("");
			    		 $("#tableFirst").append(parent.toSelectedListStr);
//			    		 dealHtml(null,parent.toSelectedList,parent.requestList);
			    	 }else{
			    		dealHtml(null,parent.requestList,JSON.parse(sessionStorage.requesterUnits));
			    	 }
				 }
				break;
			case "inputDataFood"://样品查询
				if(keyWordStr!=''){
					 foodList=JSON.parse(sessionStorage.foodList);
					  queryOption=searchData(currentId,keyWordStr,foodList);
					  queryOption.sort(function (a,b){
						  return a.foodName.length-b.foodName.length;
					  });
				 }else{
					  queryOption=foodHistoryList;
				   }
					  detalHtml(1,queryOption);
				break;
			case "inputDataRegObj"://样品来源
				if(keyWordStr!=''){
					regObjectList=JSON.parse(sessionStorage.regObjectList);
					  queryOption=searchData(currentId,keyWordStr,regObjectList);
					  queryOption.sort(function (a,b){
						  return a.regName.length-b.regName.length;
					  });
					  detalHtml(2,queryOption);
				 }else{
					  dealRegObjHtml();
				   }
				break;
			case "inputDataOpeShop"://档口
				if(keyWordStr!=''){
					 opeShopNameList=JSON.parse(sessionStorage.opeShopNameList);
					  queryOption=searchData(currentId,keyWordStr,opeShopNameList);
					  queryOption.sort(function (a,b){
						  return a.opeShopCode.length-b.opeShopCode.length;
					  });
					  detalHtml(3,queryOption);
				 }else{
					  dealShopHtml();
				   }
				break;
			default:
				break;
			}
		  
	  });
});
function queryHistory(request,food,regObj,userLabel){
	//异步加载委托单位信息
	if(request){
	    $.ajax({
	               type: "POST",
	               url: webRoot+"/wx/order/getHistory.do",
	               data: {"userType":1,"HistoryType":1},
	               dataType: "json",
	               success: function(data){
	                   if(data && data.success){
	                	   requesterHistory=data.obj;
	 	            	   detalHtml(0,requesterHistory);
	                   }
	               }
	           });
	}
	//异步加载样品历史信息
	if(food){
	    $.ajax({
	               type: "POST",
	               url: webRoot+"/wx/order/getHistory.do",
	               data: {"userType":1,"HistoryType":4},
	               dataType: "json",
	               success: function(data){
	                   if(data && data.success){
	                	   foodHistoryList=data.obj;
	 	            	   detalHtml(1,foodHistoryList);
	                   }
	               }
	           });
	}
	//异步加载样品来源历史信息
	if(regObj){
	    $.ajax({
	               type: "POST",
	               url: webRoot+"/wx/order/getHistory.do",
	               data: {"userType":1,"HistoryType":2},
	               dataType: "json",
	               success: function(data){
	                   if(data && data.success){
	                	   regHistoryList=data.obj;
	                	   dealRegObjHtml();
	                   }
	               }
	           });
	}
	//加载委托单位标签信息
	if(userLabel){
		$.ajax({
            type: "POST",
            url: webRoot+"/wx/order/getUserLabelForTerminal.do",
            dataType: "json",
            success: function(data){
                if(data && data.success){
                	requesterLabelHistory=data.obj;
	               detalHtml(4,requesterLabelHistory,true);
                }
            }
        });
	}
}
//页面拼接出来
function detalHtml(type,data,isFirst){
	switch (type) {
	case 0://拼接处理委托单位信息
		$("#mySelectRegId").empty();
		var html='';
    	var json=eval(data);
		$.each(json, function (index, item) {
			html += '<li data-id="'+item.id+'" data-requesterName="'+item.requesterName+'" data-linkPhone="'+item.linkPhone+'" data-address="'+item.companyAddress+'">'+item.requesterName+'</li>';
		});
		$("#mySelectRegId").append(html);
		break;
	case 1://拼接处理样品信息
		$("#myFoodSelect").empty();
		var html='';
    	var json=eval(data);
		$.each(json, function (index, item) {
			html += '<li data-id="'+item.id+'" data-foodName="'+item.foodName+'" >'+item.foodName;
			if(item.foodNameOther!='' ){
				html+='【'+item.foodNameOther+'】';	
			}
			html+='</li>';
		});
		$("#myFoodSelect").append(html);
		break;
	case 2://拼接处理样品来源信息
		$("#myRegObjSelect").empty();
		var html='';
    	var json=eval(data);
		$.each(json, function (index, item) {
			html += '<li data-id="'+item.id+'" data-regId="'+item.id+'" data-regName="'+item.regName+'" >'+item.regName+'</li>';
		});
		$("#myRegObjSelect").append(html);
		break;
	case 3://拼接处理经营档口信息
		$("#myShopSelect").empty();
		var html='';
    	var json=eval(data);
		$.each(json, function (index, item) {
			html += '<li data-id="'+item.id+'" >'+item.opeShopCode+'</li>';
		});
		$("#myShopSelect").append(html);
		break;
	case 4://拼接处理委托单位标签信息
		$("#mySelectLabelId").empty();
		var html='';
		var isDefault=false;
    	var json=eval(data);
		$.each(json, function (index, item) {
			if(item.isdefault==1){
				html += '<li data-id="'+item.id+'" data-requesterName="'+item.labelName+'【'+item.num+'】">'+item.labelName+'【'+item.num+'】<i class="text-danger">（默认）</i></li>';
				if(isFirst && requestList.length==0){
					isDefault=true;
					$("input[name=labelId]").val(item.id);
					$("#inputDataRegLabel").val(item.labelName+'【'+item.num+'】');
				}
			}else{
				html += '<li data-id="'+item.id+'" data-requesterName="'+item.labelName+'【'+item.num+'】">'+item.labelName+'【'+item.num+'】</li>';
			}
		});
		$("#mySelectLabelId").append(html);
		if(!isDefault && isFirst && requestList.length==0){
			$("input[name=labelId]").val(0);
			$("#mySelectLabelId li:eq(0)").click();
		}
			loadRequestList($("input[name=labelId]").val());
		
		break;
	case 5://拼接处理委托单位待选列表信息
		$("#tableFirst").empty();
		var json=eval(data);
		var html='';
		$.each(json, function (index, item) {
			var isAppend=true;
			$.each($('#tableSecond input'), function (index, item2) {
	            if(parseInt($(item2).attr("id"))==item.id){
	            	isAppend=false;
	            }
	        });
            if(isAppend){
            	html+='<li><label for="'+item.id+'"><input type="checkbox" id="'+item.id+'" name="checkBoxName" data-name="'+item.requesterName+'" data-linkPhone="'+item.linkPhone+'" data-companyAddress="'+item.companyAddress+'">'+item.requesterName+'</label> </li>';
            }
		});
		$("#tableFirst").append(html);
		break;	
	default:
		break;
	}
   
}
//样品来源历史拼接
function dealRegObjHtml(){
	$("#myRegObjSelect").empty();
		var html='';
	var json=eval(regHistoryList);
	$.each(json, function (index, item) {
		html += '<li data-id="'+item.keyId+'" data-regId="'+item.keyId+'" data-regName="'+item.keyword+'">'+item.keyword+'</li>';
	});
	$("#myRegObjSelect").append(html);
}
//档口来源历史拼接
function dealShopHtml(){
	 $("#myShopSelect").empty();
	var html='';
	var json=eval(shopHistoryList);
	$.each(json, function (index, item) {
		html += '<li data-id="'+item.keyword+'" >'+item.keyword+'</li>';
	});
	$("#myShopSelect").append(html);
}
//查询所有的基础数据
function queryAllData(){
//	if(sessionStorage.getItem("foodList")==null){
		$.ajax({
			type : "POST",
			 url: webRoot+"/wx/order/getFoodsForTerminal.do",
			data : {"md5Str":sessionStorage.foodMD5Str},
			dataType : "json",
			success : function(data) {
				if (data.success && data.resultCode!=sessionStorage.foodMD5Str) {//校验MD5值是否一致，不一致则进行更新
					sessionStorage.foodList = JSON.stringify(data.obj);
					sessionStorage.foodMD5Str=data.resultCode;
				}
			}
		});
//	}
//	if(sessionStorage.getItem("requesterUnits") == null){
		$.ajax({
			type : "POST",
			 url: webRoot+"/wx/order/getRequesterUnitsForTerminal.do",
			 data : {"md5Str":sessionStorage.foodMD5Str},
			dataType : "json",
			success : function(data) {
				if (data && data.success && data.resultCode!=sessionStorage.requestUnitMD5Str) {
					sessionStorage.requesterUnits = JSON.stringify(data.obj);
					sessionStorage.requestUnitMD5Str=data.resultCode;
				}
			}
		});
//	}	
	//查询样品来源
//	if(sessionStorage.getItem("regObjectList") == null){
		$.ajax({
			type : "POST",
			url: webRoot+"/wx/order/getRegobjForTerminal.do",
			data : {"md5Str":sessionStorage.foodMD5Str},
			dataType : "json",
			success : function(data) {
				if (data && data.success && data.resultCode!=sessionStorage.RegObjMD5Str) {
					sessionStorage.regObjectList = JSON.stringify(data.obj);
					sessionStorage.RegObjMD5Str=data.resultCode;
				}
			}
		});
//	}			
}
function queryOpeShopName(regId){
	 $.ajax({
         type: "POST",
         url: webRoot+"/wx/order/getOpes",
         data: {"regId":regId},
         dataType: "json",
         success: function(data){
             if(data && data.success){
                 var obj = data.obj;
                 if(obj && obj.length>0){
                	 sessionStorage.opeShopNameList = null;
 					 sessionStorage.opeShopNameList = JSON.stringify(data.obj);
                 }
             }
         }
     });
}
//根据用户输入关键首字母查询数据
function searchData(currentSelect2Id,keyWord,dataList){
	  var queryOption=new Array();
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
		  }else if(item.requesterFullLetter.indexOf(keyWordStr.toUpperCase())>-1){//模糊匹配全拼音
			  queryOption.push(item);
		  }
	  }else if(currentSelect2Id=="inputDataRegLabel"){//委托单位标签查询处理 add by xiaoyl 2020/1/8
		  if(item.labelFirstLetter==keyWordStr){//首字母开头全匹配
			  queryOption.push(item);
		  }else if(item.labelFirstLetter.indexOf(keyWordStr)==0){//匹配首字母开头
			  queryOption.push(item);
		  }else if(item.labelFirstLetter.indexOf(keyWordStr)>-1){//匹配非首字母开头
			  queryOption.push(item);
		  }else if(item.labelFullLetter==keyWord.toUpperCase()){//匹配全拼音
			  queryOption.push(item);
		  }else if(item.labelFullLetter.indexOf(keyWordStr.toUpperCase())>-1){//模糊匹配全拼音
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
		  }else if(item.foodFullLetter.indexOf(keyWordStr.toUpperCase())>-1){//模糊匹配全拼音
			  queryOption.push(item);
		  }
	  }else if(currentSelect2Id=="inputDataRegObj") {//样品来源
		  if(item.regFirstLetter==keyWordStr){//首字母开头全匹配
			  queryOption.push(item);
		  }else if(item.regFirstLetter.indexOf(keyWordStr)==0){//匹配首字母开头
			  queryOption.push(item);
		  }else if(item.regFirstLetter.indexOf(keyWordStr)>-1){//匹配非首字母开头
			  queryOption.push(item);
		  }else if(item.regFullLetter==keyWord.toUpperCase()){//匹配全拼音
			  queryOption.push(item);
		  }else if(item.regFullLetter.indexOf(keyWordStr.toUpperCase())>-1){//模糊匹配全拼音
			  queryOption.push(item);
		  }
	  }else if(currentSelect2Id=="inputDataOpeShop") {//经营档口
		 // var result = pinyin.getFullChars(item.opeShopCode).toUpperCase();//全拼
		 // var resultSamp=pinyin.getCamelChars(item.opeShopCode).toUpperCase();//首字母简拼
		  if(item.businessFirstLetter==keyWordStr){//首字母开头全匹配
			  queryOption.push(item);
		  }else if(item.businessFirstLetter.indexOf(keyWordStr)==0){//匹配首字母开头
			  queryOption.push(item);
		  }else if(item.businessFirstLetter.indexOf(keyWordStr)>-1){//匹配非首字母开头
			  queryOption.push(item);
		  }else if(item.businessFullLetter==keyWord){//匹配全拼音
			  queryOption.push(item);
		  }else if(item.businessFullLetter.indexOf(keyWordStr.toUpperCase())>-1){//模糊匹配全拼音
			  queryOption.push(item);
		  }else if(item.opeShopCode.indexOf(keyWord)>-1){//匹配档口号
			  queryOption.push(item);
		  }
	  }
	  
	});
	  return queryOption;
}
//根据委托单位标签查询委托单位列表
function loadRequestList(labelId){
	$.ajax({
        type: "POST",
        url: webRoot+"/inspUnitUser/loadRequestByLableId.do",
        data: {"id":labelId},
        dataType: "json",
        success: function(data){
        	requestList=[];
        	var json=data.obj;
        	$.each(json,function(index,item){
        		requestList.push({"requestId":item.requestId,"requestName":item.requestName,"param1":item.linkPhone,"param2":item.companyAddress});
        	});
        	console.log(requestList);
		}
    });
}