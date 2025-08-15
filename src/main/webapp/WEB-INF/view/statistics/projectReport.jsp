<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/common/resource.jsp"%>
<html>
<head>
<title>快检服务云平台</title>
<style type="text/css">
	 .check-date{
      float:left;
    }
    .check-date select{
      margin-right:3px;
    }
    #province{
     margin-right:3px;
    }
    .stock_info .icon-baobiao{
    color:#006fce;
    }
</style>
</head>
<body class="easyui-layout">
	<div data-options="region:'north',border:false" style="height:41px; border:none; overflow:hidden;">
		<div class="cs-col-lg clearfix" style="border-bottom:none;">
		<!-- 面包屑导航栏  开始-->
			<ol class="cs-breadcrumb">
				<li class="cs-fl">
					<img src="${webRoot}/img/set.png" alt="" />
					<a href="javascript:">数据报表</a>
				</li>
				<li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
				<li class="cs-b-active cs-fl">报表自定义生成</li>
			</ol>
		<!-- 面包屑导航栏  结束-->
			<div class="cs-search-box cs-fr">
				<form action="">
					<!-- <div class="cs-search-filter clearfix cs-fl">
						<input class="cs-input-cont cs-fl" type="text" placeholder="请输入内容" />
						<input type="submit" class="cs-search-btn cs-fl" href="javascript:;" value="搜索">
					</div> -->
					<div class="cs-fr cs-ac" id="showBtn">
						
					</div>
				</form>
			</div>
		</div>
	</div>
	<div data-options="region:'west',split:true,title:'项目名称'" style="padding-top: 10px; width: 220px;">
		<div class="cs-search-filter clearfix " style="padding-bottom: 6px;">
			<input class="cs-input-cont cs-fl focusInput" type="text" name="projectName" id="projectName" style="margin-left:1px; margin-right:0;"  placeholder="请输入项目名称">
			<input type="button" onclick="queryByFocus()" class="cs-search-btn cs-fl" href="javascript:;" style="width: 39px" value="搜索"> 
		</div>
		<div class="stock_info">
			<ul id="types">
				<c:forEach items="${pProjects}" var="subMenu" varStatus="index">
				<li name="types" data-type="${subMenu.id}" onclick="btnSelectedReport(this)">
					<div class="title"><a href="javascript:" title="${subMenu.projectName}">
                    	<c:choose>
							<c:when test="${subMenu.lid==null&&subMenu.id!=0}">
								<i style="padding-left: 2px" class="icon iconfont icon-weipeizhi text-del" title="未配置标签"></i>
								<c:if test="${subMenu.sid!=null}">
									<i style="padding-left: 2px" class="icon iconfont icon-baobiao" title="图表"></i>
								</c:if>
								${subMenu.projectName}
							</c:when>
							<c:when test="${subMenu.sid!=null&&subMenu.id!=0}">
								<i style="padding-left: 2px" class="icon iconfont icon-baobiao" title="图表"></i>
								<c:if test="${subMenu.lid==null}">
									<i style="padding-left: 2px" class="icon iconfont icon-weipeizhi text-del" title="未配置标签"></i>
								</c:if>
								${subMenu.projectName}
							</c:when>
							<c:otherwise>
								${subMenu.projectName}
							</c:otherwise>
						</c:choose>
					</a></div>
					<div class="arrow"><i class="icon iconfont icon-you"></i></div>
				</li>
				</c:forEach>
			</ul>
		</div>
	</div>
	<div data-options="region:'center'">
		<div class="cs-tb-box cs-re-box">
			<div class="cs-table-responsive" id="dataList">
				
			</div>
		</div>
	</div>
	<!-- 内容主体 结束 -->
	<!-- 新增报表 -->
	<form id="saveForm">
	<div class="modal fade intro2" id="myModal-mid" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
		<div class="modal-dialog cs-mid-width" role="document">
			<div class="modal-content ">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
					<h4 class="modal-title" id="myModalLabel">设置</h4>
				</div>
			<div class="modal-body cs-mid-height">
				<div class="cs-main">
					<div class="cs-wraper">
						<div class="cs-add-new clearfix">
							<ul class="cs-ul-form clearfix">
								<li  class="cs-name col-xs-3 col-md-3" width="20% ">报表名称：</li>
								<li class="cs-in-style cs-modal-input" width="210px" >
									<input type="hidden" name="id">
									<input type="text" name="statisticsName" id="statisticsName" class="inputxt"/>
								</li>
								<li class="col-xs-4 col-md-4 cs-text-nowrap">
									<div class="Validform_checktip"></div><div class="info"><i class="cs-mred">*</i>请输入报表名称</div>
								</li>
							</ul>
							<ul class="cs-ul-form clearfix" id="ul1" style="display: none;">
								<li class="cs-name col-xs-3 col-md-3">所属机构：</li>
								<li class="cs-in-style cs-modal-input">
									<div class="cs-all-ps">
										<div class="cs-input-box">
											<input type="hidden" name="departId"/>
											<input type="text" id="departId" readonly="readonly">
											<div class="cs-down-arrow"></div>
										</div>
										<div class="cs-check-down cs-hide" style="display: none;">
											<ul id="tree" class="easyui-tree"></ul>
										</div>
									</div>
								</li>
								<li class="col-xs-4 col-md-4 cs-text-nowrap">
									<div class="Validform_checktip"></div>
									<div class="info"><i class="cs-mred">*</i>请选择机构</div>
								</li>
							</ul>
							<ul class="cs-ul-form clearfix" id="ul2">
								<li class="cs-name col-xs-3 col-md-3">所属项目：</li>
								<li class="cs-in-style cs-modal-input">
									<input type="hidden" name="projectName" id="projectNames"/>
									<select name="projectId" id="project">
									
									</select>
								</li>
								<li class="col-xs-4 col-md-4 cs-text-nowrap">
									<div class="Validform_checktip"></div>
									<div class="info"><i class="cs-mred">*</i>请选择项目</div>
								</li>
							</ul>
							<ul class="cs-ul-form clearfix" id="ul4">
								<li class="cs-name col-xs-3 col-md-3">报表类型：</li>
								<li class="cs-in-style cs-modal-input">
									<select id="type" name="type"> 
											<option value="0">数据报表</option> 
											
											<option value="1">项目总结</option> 
									</select>
								</li>
								<li class="col-xs-4 col-md-4 cs-text-nowrap">
									<div class="Validform_checktip"></div>
									<div class="info"><i class="cs-mred">*</i>报表类型</div>
								</li>
							</ul>
							<ul class="cs-ul-form clearfix" id="ul3">
								<li  class="cs-name col-xs-3 col-md-3" width="20% ">报表时间：</li>
								<li class="cs-in-style cs-modal-input" style="width: 310px;" >
								<!-- 顶部筛选 -->
									<div class="" >
										<input type="hidden" name="year" id="years"/>
										<select id="province" name="province" class="cs-selcet-style pull-left" style="width: 98px;"> 
											<option value="month">月报表</option> 
											
											<option value="season">季报表</option> 
											
											<option value="year">年报表</option>
											
											<option value="diy">自定义</option> 
										</select> 
										<div class="check-date cs-hide">
										<select class="cs-selcet-style"  style="width: 98px;"></select>
										</div>
										<div class="check-date">
										<select class="theyear cs-selcet-style pull-left" id="year1" style="width: 98px;"> 
									        <option value="" >--请选择--</option>
								        </select>
										<select class="cs-selcet-style pull-left" name="month" id="month" style="width: 98px;"> 
											<option value="">--请选择--</option>
											<option value="1">1月</option> 
											
											<option value="2">2月</option> 
											
											<option value="3">3月</option> 
											
											<option value="4">4月</option> 
											
											<option value="5">5月</option> 
											
											<option value="6">6月</option> 
											
											<option value="7">7月</option> 
											
											<option value="8">8月</option> 
											
											<option value="9">9月</option> 
											
											<option value="10">10月</option> 
											
											<option value="11">11月</option> 
											
											<option value="12">12月</option> 
										</select>  
										</div>
										<div class="check-date cs-hide">
										<select class="theyear cs-selcet-style pull-left" id="year2" style="width: 98px;"> 
									        <option value="">--请选择--</option>
								        </select>
										<select class="cs-selcet-style pull-left" name="season" id="season" style="width: 98px;"> 
											<option value="">--请选择--</option>
											<option value="1">第一季度</option> 
											
											<option value="2">第二季度</option> 
											
											<option value="3">第三季度</option> 
											
											<option value="4">第四季度</option> 
										</select> 
										</div>
										<div class="check-date cs-hide">
										<select class="theyear cs-selcet-style" id="year" style="width: 98px;"> 
											<option value="">--请选择--</option>
										</select> 
										</div>
										<span class="check-date cs-hide">
								                <span class="cs-in-style cs-time-se cs-time-se">
								                	<input name="start" id="start" style="width: 98px;" class="cs-time Validform_error" type="text" onclick="WdatePicker()" datatype="date" nullmsg="请选择任务起止时间" errormsg="请选择任务起止时间" autocomplete="off">
								                	<!-- <span>至</span> -->
								                    <input name="end" id="end" style="width: 98px;" class="cs-time Validform_error" type="text" onclick="WdatePicker()" datatype="date" nullmsg="请选择任务起止时间" errormsg="请选择任务起止时间" autocomplete="off">
								                </span>
							            </span>
									</div>  
								</li>
							</ul>
							<ul class="cs-ul-form clearfix">
								<li  class="cs-name col-xs-3 col-md-3" width="20% ">备注：</li>
								<li class="cs-in-style cs-modal-input" width="210px" >
									<textarea name="remark" id="remark" cols="30" rows="10" style="height:80px;"></textarea>
								</li>
								<li class="col-xs-4 col-md-4 cs-text-nowrap"><div class="Validform_checktip"></div></li>
							</ul>
						</div>
					</div>
				</div>
			</div>
				<div class="modal-footer action">
					<button type="button" class="btn btn-success" id="btnSave">确定</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				</div>
			</div>
		</div>
	</div>
	</form>
	<div class="modal fade intro2" id="confirm-sure" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog cs-alert-width">
			<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
				<h4 class="modal-title">提示</h4>
			</div>
			<div class="modal-body cs-alert-height cs-dis-tab">
				<div class="cs-text-algin" style="margin-left:-10px;">
					<img src="${webRoot}/img/sure.png" width="40px" alt="" />报表更新成功！
				</div>
			</div>
			</div>
		</div>
	</div>
    <%@include file="/WEB-INF/view/common/confirm.jsp"%>
    <%@include file="/WEB-INF/view/common/modalBox.jsp"%>
	<script src="${webRoot}/js/datagridUtil.js"></script>
    <script src="${webRoot}/plug-in/echarts/echarts.min.js"></script>
    <script src="${webRoot}/plug-in/echarts/shine.js"></script>
    <script src="${webRoot}/js/selectRow.js"></script>
    <script type="text/javascript">
    var edit=0;
	var editObj;
	var del=0;
	var delObj;
	var deleteId;
	var monitor=0;
	var monitorObj;
	var projectID;
	for (var i = 0; i < childBtnMenu.length; i++) {
		if (childBtnMenu[i].operationCode == "1422-1") {
			//新增
			var html = '<a class="cs-menu-btn" data-toggle="modal" onclick="showModel()"><i class="'+childBtnMenu[i].functionIcon+'"></i>新增</a>';
			$("#showBtn").append(html);
		} else if (childBtnMenu[i].operationCode == "1422-2") {
			//编辑
			edit = 1;
			editObj = childBtnMenu[i];
		} else if (childBtnMenu[i].operationCode == '1422-4'){
			//刷新
			monitor = 1;
			monitorObj = childBtnMenu[i];
		} else if (childBtnMenu[i].operationCode == "1422-3") {
			//删除
			deletes = 1;
			deleteObj = childBtnMenu[i];
		} 
	}
	
	if(Permission.exist("1422-5")){	//标签配置
		$("#showBtn").append('<a class="cs-menu-btn" onclick="setLabel()"><i class="'+Permission.getPermission('1422-5').functionIcon+'"></i>标签</a>');
	}
	
	function setLabel(){
		if(projectID==undefined){
			showMbIframe('${webRoot}/data/foodItemLabel/list.do?id=0');
		}else {
			showMbIframe('${webRoot}/data/foodItemLabel/list.do?id='+projectID);
		}
		
	}
	
	function showModel() {
		$("#saveForm").Validform().resetForm();
    	$("#projectName").val("");
    	$("#saveForm input[name=id]").val("");
    	$("#ul2").show();
		$("#ul3").show();
		$("#ul4").show();
		showOrHide();
		$('.check-date').eq(1).siblings().hide();
		$('.check-date').eq(1).show().find('select').removeAttr('disabled');
		$('.check-date').eq(0).hide().find('select').removeAttr('disabled');
		$('#province').show();
		
		$("#myModal-mid").modal('toggle');
	}
	
	$('#tree').tree({
  		checkbox : false,
  		url : "${webRoot}/detect/depart/getDepartTree.do",
  		animate : true,
  		onClick : function(node) {
  			var did=node.id;
  			$("input[name='departId']").val(node.id);
  			$("#departId").val(node.text);
  			$(".cs-check-down").hide();
  		}
  	});
	
	function queryByFocus(obj){
  		$.ajax({
  	        url: "${webRoot}/project/selectProjects.do",
  	        type: "POST",
  	        data: {
  	            "projectName": $("#projectName").val()
  	        },
  	        dataType: "json",
  	        success: function (data) {
  	        	$("[name=types]").remove();
  	             var json = eval(data.obj);
  					var htmlStr = "";
  					$.each(json, function(index, item) {
  						htmlStr+='<li name="types" data-type='+item.id+' onclick="btnSelectedReport(this)" >';
  						htmlStr+='<div class="title"><a href="javascript:;" title='+item.projectName+'>';
  						htmlStr+=item.projectName;
  						/* if(item.projectName.length>12){
  							
  							htmlStr+=item.projectName.substring(0,12)+'...';
  						}else{
  							
  							htmlStr+=item.projectName;
  						}  */
  						htmlStr+=' </a></div><div class="arrow"><i class="icon iconfont icon-you"></i></div></li>';
  					});
  					$("#types").append(htmlStr);
  					//默认选中第一个项目
  					$("#types li:nth-child(1)").addClass("active"); //第一次进来就默认选中第一个
  				    var trainType = $("#type li:nth-child(1)").data("type");
  				    AppType = trainType;
  				    projectID=trainType;
  				    $("#types option[value='" + trainType + "']").attr("selected", "selected");
  				  	bigbang(trainType);
  	            },
  	            error: function () {
  	                $("#waringMsg>span").html("操作失败");
  	                $("#confirm-warnning").modal('toggle');
  	            }
  	    })
  	}
	
	//回车查询数据
	document.onkeydown=function(event){
	  		var e = event || window.event || arguments.callee.caller.arguments[0];        
	  		if(e && e.keyCode==13){ //enter键
	  			var focusedElement = document.activeElement;//当前关键词元素
	  			if(focusedElement && focusedElement.className){
	  				queryByFocus();
	  			}
	  			return false;
	  		}
	}
	
	$("#province").change(function(){
		var date=new Date;
		var monthsss=date.getMonth()+1;
		var year=date.getFullYear();
		var season;
		
		if(monthsss < 4) {
			season=1;
        }else if(monthsss< 7) {
        	season=2;
        }else if(monthsss<10) {
        	season=3;
        }else if(monthsss<13) {
        	season=4;
        }
		
		$("#month").find("option[value='"+monthsss+"']").attr("selected",true);
		$("#season").find("option[value='"+season+"']").attr("selected",true);
		$(".theyear").find("option[value='"+year+"']").attr("selected",true);
	});
	
	/* $("#year1").change(function(){
		$("#year1 option").each(function (){  
            $(this).attr("selected",false); 
     	}); 
	}); */
	
    $(function () {
    	$("#types li:first-child").addClass("active");//第一次进来就默认选中第一个
    	var id = $("#types li:first-child").data("type");
    	projectID=id;
    	showOrHide();
    	var date=new Date;
		var monthsss=date.getMonth()+1;
		var year=date.getFullYear();
		
		$("#month").find("option[value='"+monthsss+"']").attr("selected",true);
		$(".theyear").find("option[value='"+year+"']").attr("selected",true);
		
    	if(id!=null){
    		bigbang(id);
    	}else {
    		bigbang("");
		}
	});
    
    function showOrHide() {
    	$("#project").html("");
    	$.ajax({
	        type: "POST",
	        url: "${webRoot}/project/selectProjects.do",
	        dataType: "json",
	      	success: function(data){
	      		if(data && data.success){
	      			var list=data.obj;
	      			if(data.obj==""){
	      				$(".layout-split-west").hide();
	      				$("#ul1").show();
	      				$("#ul2").hide();
	      				//$("#ul4").hide();
	      				$(window).resize();
	      			}else if (list.length==1) {
	      				$(".layout-split-west").hide();
	      				$(window).resize();
	      				for (var i in list) {
		                	$("#project").append('<option value="' + list[i].id+ '">'+list[i].projectName+ '</option>');
		                }
					}else {
	      				for (var i in list) {
		                	$("#project").append('<option value="' + list[i].id+ '">'+list[i].projectName+ '</option>');
		                }
	      				$("#project").val(projectID);
	      		    	$("#projectNames").val($("#project option:selected").text());
					}
	      		}
	      	}
		});
	}
    
    function btnSelectedReport(obj) {
    	$.each($("li[name='types']"), function (index, item) {
            $(item).attr("class", "");
        });
		var id = $(obj).data("type");
		projectID=id;
		$(obj).addClass("active");
    	bigbang(id);
	}
    
    function bigbang(id) {
    	var op = {
    			tableId : "dataList", //列表ID
    			tableAction : "${webRoot}/datastatistics/datagrid.do?projectId="+id, //加载数据地址
    			onload: function(){
 					//加载列表后执行函数
 			    	var obj = datagridOption["obj"];
 			    	$(".rowTr").each(function(){
 				    	for(var i=0;i<obj.length;i++){
 				    		if($(this).attr("data-rowId") == obj[i].id){
 					    		if(obj[i].type==0){
 					    			$(this).children('td').eq(1).html("<a class=\"cs-link text-primary pp\" data-value='"+obj[i].id+"'>"+obj[i].statisticsName+"</a>");
 					    		}else if (obj[i].type==1) {
 					    			$(this).children('td').eq(1).html("<a class=\"cs-link text-primary bb\" data-value='"+obj[i].id+"'>"+obj[i].statisticsName+"</a>");
								}
 					    		break;
 				    		}
 				    	}
 			    	});
 			    },
    			parameter : [ //列表拼接参数
    			{
    				columnCode : "statisticsName",
    				columnName : "报表名称",
    				columnWidth : "20%",
    				query : 1
    			},{
					columnCode: "type",
					columnName: "报表类型",
					queryType: 2,
					query: 1,
					customVal: {"0":"<span>数据报表</span>","1":"<span>项目总结</span>"},
					columnWidth:'10%'
				},{
    				columnCode : "createBy",
    				columnName : "创建人",
    				columnWidth : "10%",
    				query : 1
    			}, {
    				columnCode : "remark",
    				columnName : "备注",
    				columnWidth : "10%",
    				query : 1
    			}, {
    				columnCode : "createDate",
    				columnName : "生成时间",
    				columnWidth : "10%",
    				query : 1
    			} ],
    			funBtns : [{
    				show : edit,
    				style : editObj,
    				action : function(id) {
    					editData(id);
    				}
    			},
    			{
    				show : deletes,
    				style : deleteObj,
    				action : function(id) {
    					deleteId = id;
    	   				$("#confirm-delete").modal('toggle');
    				}
    			},
    			{
    				show : monitor,
    				style : monitorObj,
    				action : function(id) {
    					updateData(id);
    				}
    			} ]
    		};
    		datagridUtil.initOption(op);
    		datagridUtil.query();
	}
    
    //查看数据报表
    $(document).on("click",".pp",function(){
    	var id=$(this).parents(".rowTr").attr("data-rowId");
    	$.ajax({
			type : "POST",
			url : "${webRoot}/datastatistics/queryReport.do?id="+id,
			dataType : "json",
			success : function(data) {
				if (data && data.success) {
					if(data.obj.list2==""){
						$("#confirm-warnning .tips").text("报表生成中，请稍后查看");
						$("#confirm-warnning").modal('toggle');
					}else {
						self.location = '${webRoot}/datastatistics/reportStatistics?id='+id;
					}
				}else {
					$("#confirm-warnning .tips").text(data.msg);
					$("#confirm-warnning").modal('toggle');
				}
			}
		});
    });
    //查看项目总结
    $(document).on("click",".bb",function(){
    	var id=$(this).attr("data-value");
    	$.ajax({
			type : "POST",
			url : "${webRoot}/datastatistics/queryReport.do?id="+id,
			dataType : "json",
			success : function(data) {
				if (data && data.success) {
					if(data.obj.dataStatistics.state==0){
						$("#confirm-warnning .tips").text("项目总结正生成中，请稍后查看");
						$("#confirm-warnning").modal('toggle');
					}else {
				    	window.open('${webRoot}/datastatistics/projectDataStatistics?id='+id);
					}
				}else {
					$("#confirm-warnning .tips").text(data.msg);
					$("#confirm-warnning").modal('toggle');
				}
			}
		});
    }); 
    
 	// 新增或修改
	$("#btnSave").on("click", function() {
		if ($("#statisticsName").val()!="") {
			if ($("#project").val()==null&&$("#saveForm input[name=departId]").val()=="") {
				$("#confirm-warnning .tips").text("请选择机构!");
				$("#confirm-warnning").modal('toggle');
			}else if ($("#project").val()==""&&$("#saveForm input[name=departId]").val()==null) {
				$("#confirm-warnning .tips").text("请选择项目!");
				$("#confirm-warnning").modal('toggle');
			}else{
				if ($("#saveForm input[name=id]").val()=="") {
					if($("#province").val()=="month"&&$("#year1").val()!=""&&$("#month").val()!=""){
						saveAjax();
					}else if ($("#province").val()=="season"&&$("#year2").val()!=""&&$("#season").val()!="") {
						saveAjax();
					}else if ($("#province").val()=="year"&&$("#year").val()!="") {
						saveAjax();
					}else if ($("#province").val()=="diy"&&$("#start").val()!=""&&$("#end").val()!="") {
						saveAjax();
					}else {
						$("#confirm-warnning .tips").text("请选择报表类型!");
						$("#confirm-warnning").modal('toggle');
					}
				}else {
					saveAjax();
				}
			}
		}else {
			$("#confirm-warnning .tips").text("请填写报表名称!");
			$("#confirm-warnning").modal('toggle');
		}
	});
 	
 	function saveAjax() {
 		if($("#saveForm input[name=id]").val()==""){
 			var year;
 			if($("#province").val()=="month"){
 				year=$("#year1").val();
 			}else if ($("#province").val()=="season") {
 				year=$("#year2").val();
 			}else if ($("#province").val()=="year") {
 				year=$("#year").val();
 			}
 			$("#years").val(year);
 			$("#projectNames").val($("#project option:selected").text());
 		}
		var formData = new FormData($('#saveForm')[0]);
 		$.ajax({
			type : "POST",
			url : "${webRoot}/datastatistics/save.do",
			data : formData,
			contentType : false, //必须false才会避开jQuery对 formdata 的默认处理 XMLHttpRequest会对 formdata 进行正确的处理 
			processData : false, //必须false才会自动加上正确的Content-Type
			dataType : "json",
			success : function(data) {
				if (data && data.success) {
					$("#myModal-mid").modal('toggle');
					datagridUtil.query();
					if($("#saveForm input[name=id]").val()==""&&$("#type").val()==0){
						saveReport();
					}else if ($("#saveForm input[name=id]").val()==""&&$("#type").val()==1) {
						saveProjectDataReport();
					}else {
						saveReport();
					}
				}else {
					$("#confirm-warnning .tips").text(data.msg);
					$("#confirm-warnning").modal('toggle');
				}
			}
		});
	}
 	
 	function saveReport() {
 		var year;
 		if($("#province").val()=="month"){
			year=$("#year1").val();
		}else if ($("#province").val()=="season") {
			year=$("#year2").val();
		}else if ($("#province").val()=="year") {
			year=$("#year").val();
		}
		$("#years").val(year);
		$("#projectNames").val($("#project option:selected").text());
 		var formData = new FormData($('#saveForm')[0]);
 		$.ajax({
			type : "POST",
			url : "${webRoot}/datastatistics/saveReport.do",
			data : formData,
			contentType : false, //必须false才会避开jQuery对 formdata 的默认处理 XMLHttpRequest会对 formdata 进行正确的处理 
			processData : false, //必须false才会自动加上正确的Content-Type
			dataType : "json",
			success : function(data) {
				if (data && data.success) {
					$("#saveForm").Validform().resetForm();
			    	$("#projectName").val("");
			    	$("#saveForm input[name=id]").val("");
				} else {
					$("#confirm-warnning .tips").text("报表生成失败");
					$("#confirm-warnning").modal('toggle');
				}
			}
		});
	}
 	
 	function saveProjectDataReport() {
 		var year;
 		if($("#province").val()=="month"){
			year=$("#year1").val();
		}else if ($("#province").val()=="season") {
			year=$("#year2").val();
		}else if ($("#province").val()=="year") {
			year=$("#year").val();
		}
		$("#years").val(year);
		$("#projectNames").val($("#project option:selected").text());
 		var formData = new FormData($('#saveForm')[0]);
 		$.ajax({
			type : "POST",
			url : "${webRoot}/datastatistics/saveProjectDataReport.do",
			data : formData,
			contentType : false, //必须false才会避开jQuery对 formdata 的默认处理 XMLHttpRequest会对 formdata 进行正确的处理 
			processData : false, //必须false才会自动加上正确的Content-Type
			dataType : "json",
			success : function(data) {
				if (data && data.success) {
					$("#saveForm").Validform().resetForm();
			    	$("#projectName").val("");
			    	$("#saveForm input[name=id]").val("");
				} else {
					$("#confirm-warnning .tips").text("项目总结生成失败");
					$("#confirm-warnning").modal('toggle');
				}
			}
		});
	}
 	
 	function updateData(id) {
 		$.ajax({
			type : "POST",
			url : "${webRoot}/datastatistics/updateData.do?id="+id,
			success : function(data) {
				if (data && data.success) {
					$("#confirm-sure").modal('toggle');
				} else {
					$("#confirm-warnning .tips").text("报表更新失败");
					$("#confirm-warnning").modal('toggle');
				}
			}
		});
	}
 	
	//删除函数
    function deleteData(){
    	$.ajax({
	        type: "POST",
	        url: '${webRoot}'+"/datastatistics/delete.do",
	        data: {"ids":deleteId},
	        success: function(data){
	        	if(data && data.success){
	        		//删除成功后刷新列表
	        		document.location.reload();
	        	}
			},
			error: function(){
				$("#confirm-warnning").modal('toggle');
			}
	    });
			$("#confirm-delete").modal('toggle');
	}
	
	function editData(id) {
		$.ajax({
			url:'${webRoot}/datastatistics/edit?id='+id,
			success:function(data){
				if(data.obj){
					var form = $('#saveForm');
		    		form.form('load', data.obj);
					$("#saveForm input[name=id]").val(data.obj.id);
					$("#statisticsName").val(data.obj.statisticsName);
					$("#remark").val(data.obj.remark);
					$("#ul1").hide();
					$("#ul2").hide();
					$("#ul3").hide();
					$("#ul4").hide();
					$("#myModal-mid").modal('toggle');
				}
			}
		});
	}
	//关闭编辑模态框前重置表单，清空隐藏域
 	$('#myModal-mid').on('hide.bs.modal', function (e) {
	    	/* $("#saveForm").Validform().resetForm();
	    	$("#projectName").val("");
	    	$("#saveForm input[name=id]").val("");
	    	$("#ul2").show();
			$("#ul3").show(); */
 	});
	
 	var selyear = $(".theyear");
    var startYear=2017;
    var now = new Date();
    var year = now.getFullYear(); //获取当前年份  
    var betYear = year-startYear+1;
    for (var i = 0; i < betYear; i++) {
        var option = $("<option>").val(startYear).text(startYear+"年"); //给option添加value值与文本值  
        selyear.append(option);  //添加到select下     
        var startYear = startYear+1;       //年份+1，再添加一次
    }
    </script>
</body>
</html>