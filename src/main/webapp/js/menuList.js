$(function() {
	$("[datatype]").focusin(function() {
		if (this.timeout) {
			clearTimeout(this.timeout);
		}
		var infoObj = getInfoObj.call(this);
		if (infoObj.siblings(".Validform_right").length != 0) {
			return;
		}
		infoObj.show().siblings().hide();

	}).focusout(function() {
		var infoObj = getInfoObj.call(this);
		this.timeout = setTimeout(function() {
			infoObj.hide().siblings(".Validform_wrong,.Validform_loading").show();
		}, 0);

	});
	$("#saveForm").Validform({
		tiptype:2,
		beforeSubmit:function(){
			var formData = new FormData($('#saveForm')[0]);
			$.ajax({
		        type: "POST",
		        url: rootPath+"save.do",
		        data: formData,
		        contentType: false, //必须false才会避开jQuery对 formdata 的默认处理 XMLHttpRequest会对 formdata 进行正确的处理 
		        processData: false, //必须false才会自动加上正确的Content-Type
		        dataType: "json",
		        success: function(data){
		        	if(data && data.success){
		        		$("#addModal").modal("hide");
						 datagridUtil.query();
		        	}else{
		        		$("#waringMsg>span").html(data.msg);
		        		$("#confirm-warnning").modal('toggle');
		        	}
				}
		    });
			return false;
		}
	});
	// 新增或修改
	$("#btnSave").on("click", function() {
		$("#saveForm").submit();
		return false;
	});
	// 关闭编辑模态框前重置表单，清空隐藏域
	$('#addModal').on('hidden.bs.modal', function(e) {
		var form = $("#saveForm");// 清空表单数据
		form.form("reset");
		$("input[name=parentId]").val("");
		$("input[name=id]").val("");
		$("#choseMenu").val("");
	});
	$("#addModal").on('show.bs.modal',function(e){
		$(".registerform").Validform().resetForm();
		$("input").removeClass("Validform_error");
		$(".Validform_wrong").hide();
		$(".info").show();
		initMenuTree();
	});
	$("input[name=functionType]").on("click",function(){
		$("input[name=parentId]").val("");
		$("#choseMenu").val("");
		initMenuTree();
	});
	//新增操作权限 start
	/*demoOperator = $("#saveOperatorForm").Validform({
			tiptype : 2,
			callback : function(data) {
				$.Hidemsg();
				if (data.success) {
					$("#myModalOperator").modal("hide");
					datagridUtil.query();
				} else {
					$("#confirm-warnning").modal('toggle');
				}
			}
		});
		// 新增或修改
		$("#btnSaveOperator").on("click", function() {
			demoOperator.ajaxPost();
			return false;
		});
		// 关闭编辑模态框前重置表单，清空隐藏域
		$('#myModalOperator').on('hidden.bs.modal', function(e) {
			var form = $("#saveOperatorForm");// 清空表单数据
			form.form("reset");
			$("input[name=functionId]").val("");
		})*/
	//新增操作权限end
})
function getInfoObj(){
		return $(this).parents("li").next().find(".info");
	}
// 加载权限树
function initMenuTree() {
	$("#menuTree").tree({
		checkbox : false,
		url : rootPath + "menuTree.do",
		//data:{"functionType":$("input:radio[name=functionType]:checked").val()},
		animate : true,
		lines : false,
		onClick : function(node) {
			$("input[name=parentId]").val(node.id);
			$("#choseMenu").val(node.text);
			$(".cs-check-down").hide();
		},
		onBeforeLoad: function(node,param){
			param.functionType=$("input:radio[name=functionType]:checked").val();
		}
	});
}
/**
 * 查询信息
 */
function getId(e) {
	var id = e;
	$.ajax({
		url : rootPath + "queryById.do",
		type : "POST",
		data : {
			"id" : id
		},
		dataType : "json",
		success : function(data) {
			$(".info").hide();
			var form = $('#saveForm');
			form.form('load', data.obj);
			$("input[name=functionType][value=" + data.obj.functionType + "]").prop("checked", "checked");
			$("#choseMenu").val(data.obj.parentStr);
			
		},
		error : function() {
			alert("操作失败");
		}
	})
}
// 绑定回车事件
//document.onkeydown = keyDownSearch;
// 页面处理拼接函数
datagridUtil.spliceHtml = function() {

	//获取当前配置参数
	var tableId = datagridOption["tableId"];
	var parameter = datagridOption["parameter"];
	var funBtns = datagridOption["funBtns"];
	var rowTotal = datagridOption["rowTotal"];
	var pageSize = datagridOption["pageSize"];
	var pageNo = datagridOption["pageNo"];
	var pageCount = datagridOption["pageCount"];
	var obj = datagridOption["obj"];
	var addFun = datagridOption["addFun"];
	var deleteFun = datagridOption["deleteFun"];
	var exportFun = datagridOption["exportFun"];
	var showQuery = datagridOption["showQuery"];
	var onload = datagridOption["onload"];
	var funColumnWidth = datagridOption["funColumnWidth"];
	var bottomBtns = datagridOption["bottomBtns"];
	
	
	//清空列表
	$("#"+tableId).html("");
	
	//拼接搜索栏html
	var queryNum = 0;	//查询条件数量
	var html = "";	//拼接html
	var lineNum = 4;	//每行显示查询条件数量(可修改)
	for(var i=0;i<parameter.length;i++){
		if(parameter[i].query==1){
			queryNum++;
			//拼接搜索开始区域
			if(queryNum==1){
				if(showQuery && showQuery==1){
					html += "<div class=\"cs-search-inform\">";
				}else{
					html += "<div class=\"cs-search-inform cs-hide\">";
				}
				html += "<table class=\"cs-search-table cs-input-style\">";
			}
			
			var queryNo = queryNum % lineNum;
			//拼接换行开始符
			if(queryNo==1){
				html += "<tr>";
			}
			
			//拼接搜索框
			html += "<td>"+parameter[i].columnName+"：</td><td class=\"cs-in-style\">";
			//判断查询条件类型
			if(!parameter[i].queryType || parameter[i].queryType==0){
				//文本类型
				html += "<input class=\""+tableId+"-qpinput\" name=\"";
				
				//设置查询输入框 name属性
				if(!parameter[i].queryCode){
					//默认input name
					html += parameter[i].columnCode;
				}else{
					//自定义input name
					html += parameter[i].queryCode;
				}
				html += "\" type=\"text\" ";
				
				//设置查询值
				if(parameter[i].queryVal){
					html += "value=\""+parameter[i].queryVal+"\"";
				}
				html += "></td>";
			}else if(parameter[i].queryType==1){
				//日期类型
				html += "<input class=\"cs-time "+tableId+"-qpinput\" name=\""+parameter[i].columnCode+"\" type=\"text\"></td>";
				
				//时间搜索框
				//设置查询输入框 name属性
				//设置查询值
			}
			
			//拼接换行结束符
			if(queryNo==0){
				if(queryNum == lineNum){
					//首行，拼接搜索按钮
					html += "<td><a class=\"cs-avd-search-btn \" onclick=\"datagridUtil.query()\">搜索</a></td></tr>"
				}else{
					//非首行
					html += "</tr>";
				}
			}
		}
		
		//拼接搜索结束区域
		if(i == parameter.length-1 && queryNum > 0){
			//查询条件数量小于3拼接换行结束符
			if(queryNo!=0){
				if(queryNum < lineNum){
					//首行，拼接搜索按钮
					html += "<td><a class=\"cs-avd-search-btn \" onclick=\"datagridUtil.query()\">搜索</a></td></tr>";
				}else{
					//非首行
					html += "</tr>";
				}
			}
			html += "</table></div>";
		}
		
	}
          
	//拼接列表html
	html += "<div class=\"cs-col-lg-table\">";
	html += "<div class=\"cs-table-responsive\">";
	html += "<table class=\"cs-table cs-table-hover table-striped cs-tablesorter\">";
	html += "<thead><tr>";
	html += "<th style=\"width:50px;\"><div class=\"cs-num-cod\"><input id=\"mainCheckBox\" type=\"checkbox\" onchange=\"datagridUtil.checkedAll()\"/></div></th>";
	//遍历列名
	for(var i=0;i<parameter.length;i++){
		html += "<th class=\"cs-header\" ";
			if(parameter[i].columnWidth){
				html += "style=\"width:"+parameter[i].columnWidth+";\"";
			}
		html += ">"+parameter[i].columnName+"</th>";
	}
	//拼接操作列
	if(funBtns && funBtns.length>0){
		//html += "<th class=\"cs-header\">操作</th>";
		html += "<th class=\"cs-header\" style=\"";
		if(!funColumnWidth){
			html += "150px";
		}else{
			html += funColumnWidth;
		}
		html += "\">操作</th>";
	}
	//遍历列内容
	html += "</tr></thead><tbody>";
	if(obj){
		for(var i=0;i<obj.length;i++){
			html += "<tr class=\"rowTr\" data-rowId=\""+obj[i].id+"\"><td style=\"width:50px;\"><div class=\"cs-num-cod\"><input name=\"rowCheckBox\" type=\"checkbox\" value=\""+obj[i].id+"\" onchange=\"datagridUtil.changeBox()\"/><span>"+(i+1)+"</span></div></td>";
			//拼接数据
			for(var ii=0;ii<parameter.length;ii++){
				for (var key in obj[i])
				{
					if(key == parameter[ii].columnCode){
						if(parameter[ii].customElement){
							//自定义html
							html += "<td>"+parameter[ii].customElement.replace(/\?/g, obj[i][key])+"</td>";
						}else if(parameter[ii].customVal){
							//使用自定义值
							var customVal = '';
							for (var key1 in parameter[ii].customVal){
								if(key1 == obj[i][key]){
									customVal = parameter[ii].customVal[key1];
									break;
								}
							}
							html += "<td>"+customVal+"</td>";
						}else{
							//使用对象属性值
							if(!parameter[ii].queryType || parameter[ii].queryType == 0){
								//文字类型
								/*html += "<td>"+(obj[i][key] == null ? "" : obj[i][key])+"</td>";*/
								if (obj[i].functionLevel == 1 && key == "functionName") {
									html += "<td style='text-align:left;'>" + (obj[i][key] == null ? "" : obj[i][key])
									+ "</td>";
								}else if (obj[i].functionLevel == 2 && key == "functionName") {
									html += "<td style='text-align:left;padding-left:50px;'>" + (obj[i][key] == null ? "" : obj[i][key])
											+ "</td>";
								} else if (obj[i].functionLevel == 3 && key == "functionName") {
									html += "<td style='text-align:left;padding-left:80px;'>" + (obj[i][key] == null ? "" : obj[i][key])
											+ "</td>";
								} else {
									html += "<td>" + (obj[i][key] == null ? "" : obj[i][key]) + "</td>";
								}
							}else{
								//日期类型
								if(!obj[i][key]){
									html += "<td></td>";
								}else{
									if(!parameter[ii].dateFormat){
										html += "<td>"+new Date(obj[i][key]).format("yyyy-MM-dd")+"</td>";
									}else{
										html += "<td>"+new Date(obj[i][key]).format(parameter[ii].dateFormat)+"</td>";
									}
								}
							}
						}
						break;
					}
				} 
			}
			//拼接操作按钮
			if(funBtns && funBtns.length>0){
				html += "<td>";
				for(var iii=0;iii<funBtns.length;iii++){
//					if(funBtns[iii].show == undefined || funBtns[iii].show == 1 ){
//						//显示操作按钮
//						html += "<a class=\"cs-chakan\" href=\"javascript:;\"" +
//							"onclick=\"datagridUtil.customizeFun('"+obj[i].id+"','"+iii+"')\"" +
//							"><img src=\""+funBtns[iii].imgSrc+"\" title=\""+funBtns[iii].imgTitle+"\" /></a>";
//					}else{
//						//隐藏操作按钮
//						html += "<a class=\"cs-chakan\" href=\"javascript:;\" style=\"display: none;\"" +
//						"onclick=\"datagridUtil.customizeFun('"+obj[i].id+"','"+iii+"')\"" +
//						"><img src=\""+funBtns[iii].imgSrc+"\" title=\""+funBtns[iii].imgTitle+"\" /></a>";
//					
					if(funBtns[iii].show == undefined || funBtns[iii].show == 1 ){
						html += "<span class=\"cs-icon-span\"";
						//设置按钮样式
						if(funBtns[iii] && funBtns[iii].style ){
							html += " onclick=\"datagridUtil.customizeFun('"+obj[i].id+"','"+iii+"')\"><i class=\""+funBtns[iii].style.functionIcon+"\" title=\""+funBtns[iii].style.operationName+"\"></i></span>";
						}else{
							html += " onclick=\"datagridUtil.customizeFun('"+obj[i].id+"','"+iii+"')\"><i></i></span>";
						}
					}
				}
				html += "</td>";
			}
			html += "</tr>";
		}
	}
	html += "</tbody></table></div></div>";
	
	//拼接底部导航
	var navBtnNum = 5;	//导航页面序号按钮数量
	var halfBtnNum = parseInt(navBtnNum/2);
	html += "<div class=\"cs-bottom-tools\">";
//	//新增按钮
//	if(addFun && addFun.show && addFun.show==1){
//		html += "<div class=\"cs-menu-btn cs-fl cs-ac \">";
//		html += "<a onclick=\"datagridUtil.addRows()\"><i class=\"icon iconfont icon-zengjia\"></i>新增</a></div>";
//	}
//	//删除按钮
//	if(deleteFun && deleteFun.show && deleteFun.show==1){
//		html += "<div class=\"cs-menu-btn cs-fl cs-ac \">";
//		html += "<a onclick=\"datagridUtil.delRows()\"><i class=\"icon iconfont icon-delete\"></i>删除</a></div>";
//	}
//	//导出按钮
//	if(exportFun && exportFun.show && exportFun.show==1){
//		html += "<div class=\"cs-menu-btn cs-fl cs-ac cs-distan\">";
//		html += "<a onclick=\"datagridUtil.expRows()\"><i class=\"icon iconfont icon-daochu\"></i>导出</a></div>";
//	}

	//拼接底部按钮
	if(bottomBtns && bottomBtns.length>0){
		for(var i=0;i<bottomBtns.length;i++){
			html += "<a href=\"javascript:;\" class=\"cs-menu-btn\"";
			if(bottomBtns[i] && bottomBtns[i].show == 0 ){
				//隐藏操作按钮
				html += " style=\"display: none;\"";
			}
			//设置按钮样式
			if(bottomBtns[i] && bottomBtns[i].style ){
				html += " onclick=\"datagridUtil.bottomBtnFun('"+i+"')\"><i class=\""+bottomBtns[i].style.functionIcon+"\"></i>"+bottomBtns[i].style.operationName+"</a>";
			}else{
				html += " onclick=\"datagridUtil.bottomBtnFun('"+i+"')\"><i></i></a>";
			}
		}
	}
	
	html += "<ul class=\"cs-pagination cs-fr\">";
	html += "<li class=\"cs-distan\">共"+pageCount+"页/"+rowTotal+"条记录</li>";
	html += "<li class=\"cs-b-nav-btn cs-distan cs-selcet\">";
	html += "<select id=\""+datagridOption["pageSizeSel"]+"\" onchange=\"datagridUtil.resetPageSize();\">";
	html += "<option value=\"10\" ";
	if(pageSize==10){
		html += "selected=\"selected\"";
	}
	html += ">10行/页</option>";
	html += "<option value=\"20\" ";
	if(pageSize==20){
		html += "selected=\"selected\"";
	}
	html += ">20行/页</option>";
	html += "<option value=\"30\" ";
	if(pageSize==30){
		html += "selected=\"selected\"";
	}
	html += ">30行/页</option>";
	html += "<option value=\"40\" ";
	if(pageSize==40){
		html += "selected=\"selected\"";
	}
	html += ">40行/页</option>";
	html += "<option value=\"50\" ";
	if(pageSize==50){
		html += "selected=\"selected\"";
	}
	html += ">50行/页</option>";
	html += "</select></li>";
		
	html += "<li class=\"cs-disabled cs-distan\"><a class=\"cs-b-nav-btn\" " +
			"onclick=\"datagridUtil.toPage('"+1+"');\">«</a></li>";
	pageNo=parseInt(pageNo);
	//导航页面序号居中
	if((pageCount < navBtnNum) || (pageNo - halfBtnNum <= 0)){
		//总页数少于5或最前几页显示
		for(var i=1;i<=(pageCount>navBtnNum?navBtnNum:pageCount);i++){
			html += "<li><a class=\"cs-b-nav-btn";
			if(pageNo==i){
				html += " cs-n-active";
			}
			html += "\" onclick=\"datagridUtil.toPage('"+i+"');\">"+i+"</a></li>";
		}
	}else{
		if(pageNo + halfBtnNum >= pageCount){
			//最后几页
			var i = pageNo-halfBtnNum;
			if(i==pageCount){
				for(i;i<=pageCount;i++){
					html += "<li><a class=\"cs-b-nav-btn";
					if(pageNo==i){
						html += " cs-n-active";
					}
					html += "\" onclick=\"datagridUtil.toPage('"+i+"');\">"+i+"</a></li>";
				}
			}else if(i<pageCount){
				for(var ii=pageCount-navBtnNum+1;ii<=pageCount;ii++){
					html += "<li><a class=\"cs-b-nav-btn";
					if(pageNo==ii){
						html += " cs-n-active";
					}
					html += "\" onclick=\"datagridUtil.toPage('"+ii+"');\">"+ii+"</a></li>";
				}
			}
		}else{
			//中间几页
			if(navBtnNum%2==0){
				//偶数按钮数量
				for(var i=pageNo-halfBtnNum+1;i<=pageNo+halfBtnNum;i++){
    				html += "<li><a class=\"cs-b-nav-btn";
    				if(pageNo==i){
    					html += " cs-n-active";
    				}
    				html += "\" onclick=\"datagridUtil.toPage('"+i+"');\">"+i+"</a></li>";
    			}
			}else{
				//奇数按钮数量
				for(var i=pageNo-halfBtnNum;i<=pageNo+halfBtnNum;i++){
    				html += "<li><a class=\"cs-b-nav-btn";
    				if(pageNo==i){
    					html += " cs-n-active";
    				}
    				html += "\" onclick=\"datagridUtil.toPage('"+i+"');\">"+i+"</a></li>";
    			}
			}
		}
	}
	html += "<li class=\"cs-next \"><a class=\"cs-b-nav-btn\" " +
			"onclick=\"datagridUtil.toPage('"+pageCount+"');\">»</a></li>";
	html += "<li class=\"cs-skip cs-distan\">跳转<input id=\"toPageNo\" type=\"text\" />页</li>";
	html += "<li><a class=\"cs-b-nav-btn cs-enter cs-distan\" " +
			"onclick=\"datagridUtil.toPage();\">确定</a></li>";
	html += "</ul></div>";
	
	//刷新列表
	$("#"+tableId).append(html);
	
	//加载完成后,执行自定义函数
	if(onload){
		onload();
	}
}