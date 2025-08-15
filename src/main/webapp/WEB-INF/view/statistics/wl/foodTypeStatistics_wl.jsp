<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/common/resource.jsp"%>
<script type="text/javascript" src="${webRoot}/js/distinctFoodName.js"></script>
<html>
  <head>
    <title>快检服务云平台</title>
      <style type="text/css">
          .firstContextStyle{
              width:12%;
          }
          .contextStyle{
              /*   width:28%;*/
          }
          .contextNumber{
              width:8%;
          }
          .contextUnqual{
              width:10%;
          }
          .select2-container--default .select2-selection--single, .select2-container--default .select2-selection--single:focus{
              height: 30px;
          }
          .cs-check-down, .cs-check-down2,.cs-input-box,.select2-container{
              max-width: 150px;
          }
      </style>
  </head>
	<body>

          <div class="cs-col-lg clearfix">
          <!-- 面包屑导航栏  开始-->
            <ol class="cs-breadcrumb clearfix cs-fl" >
              <li class="cs-fl">
              <img src="${webRoot}/img/set.png" alt="" />
              <a href="javascript:">数据统计</a></li>
              <li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
              <li class="cs-b-active cs-fl">食品类别统计
              </li>
            </ol>
          <!-- 面包屑导航栏  结束-->
          <div class="cs-fl">
        <c:if test="${ empty session_user.pointId }">
          <div class="cs-input-style cs-fl" style="margin:3px 0 0 15px;">
              	<div class="cs-all-ps">
					<div class="cs-input-box">
						<input type="hidden" id="did"/>
						<input type="text" name="departName" readonly="readonly" style="width: 100%;">
						<div class="cs-down-arrow"></div>
					</div>
					<div class="cs-check-down cs-hide" style="display: none;">
						<ul id="tree" class="easyui-tree"></ul>
					</div>
			    </div>

          </div>
        </c:if>
      <div class="cs-input-style cs-fl cs-hide" style="margin:3px 0 0 15px;" id="pointDiv">
                  <div class="cs-all-ps">
                      <div class="cs-in-style" >
                          <%--检测室：--%>
                          <select class="js-select2-tags" name="pointId" id="point_select">
                          <c:choose>
                              <c:when test="${ ! empty session_user.pointId }">
                                  <option value="${session_user.pointId}">${session_user.pointName}</option>
                              </c:when>
                              <c:otherwise>
                                  <option value="">--请选择检测室--</option>
                              </c:otherwise>
                          </c:choose>

                      </select>
                      </div>
                  </div>
              </div>
          <div class="cs-input-style cs-fl" style="margin:3px 0 0 15px;">
              	<div class="cs-all-ps">
					<div class="cs-input-box">
						<input type="hidden" id="fid"/>
						<input type="text" name="foodName" readonly="readonly" style="width: 150px;">
						<a class="cs-ps-arrow"  href="#myModal-mid"  data-toggle="modal" data-target="#myModal-mid"></a>
					</div>
			    </div>

          </div>
          <div class="cs-input-style cs-fl" style="margin:3px 0 0 15px;" id="typeDiv">
          
          </div>
          <!--检测点类型条件-->
              <%@include file="/WEB-INF/view/statistics/selectPointType.jsp"  %>
              <!-- 顶部筛选 -->
          <div class="cs-input-style cs-fl" style="margin:3px 0 0 4px;">
          	  <input type="hidden" name="year" id="years"/>
              <select id="province" class="cs-selcet-style pull-left" style="width: 85px;margin-right:4px;"> 
              	<!-- <option value="day">日报表</option> --> 
              
				<option value="month">月报表</option> 
				
                <option value="season">季报表</option> 

                 <option value="year">年报表</option> 
                 
                 <option value="diy">自定义</option> 

              </select> 
			  <div class="check-date cs-hide">
              <select class="cs-selcet-style"></select> 
              </div>
			   <div class="check-date pull-left">
				<select class="theyear cs-selcet-style" id="year1" style="width: 98px;"> 
			        <option value="" >--请选择--</option>
		        </select>
               <select class="cs-selcet-style" id="month" style="width: 85px;"> 
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
			  
			  <div class="check-date pull-left cs-hide">
              <select class="theyear cs-selcet-style" id="year2" style="width: 98px;"> 
		      	<option value="">--请选择--</option>
	          </select>
              <select class="cs-selcet-style" id="season" style="width: 85px;"> 
				 <option value="">--请选择--</option>
				 
                 <option value="1">第一季度</option> 

                 <option value="2">第二季度</option> 

                 <option value="3">第三季度</option> 

                 <option value="4">第四季度</option> 

              </select> 
			  </div>
			  <div class="check-date pull-left cs-hide">
              <select class="theyear cs-selcet-style" id="year" style="width: 85px;"> 
				 <option value="">--请选择--</option>
				 
              </select> 
              </div>
            </div>  
            <span class="check-date cs-hide">
               <!-- <span class="cs-name"></span> -->
	                <span class="cs-in-style cs-time-se cs-time-se">
	                	<input name="task.taskSdate" style="width: 110px;" class="cs-time Validform_error" id="start" type="text" onclick="WdatePicker({maxDate:'#F{$dp.$D(end)}',startDate:'%y-%M-%d',maxDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true})" datatype="date" nullmsg="请选择任务起止时间" errormsg="请选择任务起止时间" value="">
	                	-
	                    <input name="task.taskSdate" style="width: 110px;" class="cs-time Validform_error" id="end" type="text" onclick="WdatePicker({minDate:'#F{$dp.$D(start)}',startDate:'%y-%M-%d',maxDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true})" datatype="date" nullmsg="请选择任务起止时间" errormsg="请选择任务起止时间" value="">
	                </span>
	                <span>
		        		<a href="javascript:" class="cs-menu-btn" style="margin:4px 0 0 10px;" onclick="departConfirms()"><i class="icon iconfont icon-chakan"></i>查询</a>
		        	</span>
                </span>
          </div>

          </div>
          <div class="cs-tb-box">
            
                    <!-- 为 ECharts 准备一个具备大小（宽高）的 DOM -->
  <div style="border:1px solid #ddd; padding:10px 0; margin-bottom:10px; border-left:0; border-right:0;">
    <div id="third" class="cs-echart" style="width: 63%;height:380px; display:inline-block;"></div>
    <div id="second" class="cs-echart" style="width: 35%;height:380px;display:inline-block; margin-left:1%;"></div>
  </div>

	<div style="padding-bottom:50px;">
             <table class="cs-table cs-table-hover table-striped cs-tablesorter" id="table">
                <thead>
                  <tr>
                    <th class="cs-header columnHeading" style='width:50px;'>序号</th>
                    <th class="cs-header columnHeading firstContextStyle" onclick="datagridUtil.orderBy2('table',1,'string')">食品种类<span class="sortIcon icon iconfont icon-sort"></span></th>
                    <th class="cs-header columnHeading contextNumber" onclick="datagridUtil.orderBy2('table',2,'int')">抽检总数<span class="sortIcon icon iconfont icon-sort"></span></th>
                    <th class="cs-header columnHeading contextNumber" onclick="datagridUtil.orderBy2('table',3,'int')">合格数<span class="sortIcon icon iconfont icon-sort"></span></th>
                    <th class="cs-header columnHeading contextNumber" onclick="datagridUtil.orderBy2('table',4,'int')">不合格数<span class="sortIcon icon iconfont icon-sort"></span></th>
                    <th class="cs-header columnHeading contextNumber" onclick="datagridUtil.orderBy2('table',5,'float')">合格率<span class="sortIcon icon iconfont icon-sort"></span></th>
                    <%-- <th class="cs-header columnHeading contextNumber" onclick="datagridUtil.orderBy2('table',6,'float')">不合格率<span class="sortIcon icon iconfont icon-sort"></span></th>--%>

                      <th class="cs-header columnHeading contextUnqual" onclick="datagridUtil.orderBy2('table',6,'float')">抽样基数(KG)<span class="sortIcon icon iconfont icon-sort"></span></th>
                      <th class="cs-header columnHeading contextNumber" onclick="datagridUtil.orderBy2('table',7,'float')">销毁数(KG)<span class="sortIcon icon iconfont icon-sort"></span></th>
                      <th class="cs-header columnHeading contextStyle" onclick="datagridUtil.orderBy2('table',8,'float')">阳性样品<span class="sortIcon icon iconfont icon-sort"></span></th>
                  </tr>
                </thead>
                <tbody>

                </tbody>
              </table>
	</div>
 <!-- Button to trigger modal -->

          </div>

      <!-- 内容主体 结束 -->
<!-- 选择组织机构 -->
<div class="modal fade" id="myDeaprtModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" data-backdrop="static">
	<div class="modal-dialog cs-mid-width" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title">选择检测机构</h4>
			</div>
			<div class="modal-body cs-mid-height">
				<ul id="myDeaprtTree" class="easyui-tree"></ul>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-success" onclick="departConfirm();">确定</button>
				<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
			</div>
		</div>
	</div>
</div>




<div class="modal fade intro2" id="myModal-mid" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog cs-mid-width" role="document">
    <div class="modal-content ">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">食品种类</h4>
      </div>
      <div class="modal-body cs-mid-height">
         <!-- 主题内容 -->
    <div class="cs-main">
    <div class="cs-wraper">
        <form class="registerform" method="post" action="">
            <div width="100%" class="cs-add-new">
            <div class="cs-ul-boxc">
				<input class="cs-fl cs-ul-checkbox" id="check" type="checkbox"  onchange="$('#tree2').tree({cascadeCheck:$(this).is(':checked')})"> 
				<i class="cs-fl">是否包含下级</i>
			</div>
				<ul id="tree2" class="easyui-tree" data-options="url:'tree_data1.json',method:'get',animate:true,checkbox:true,cascadeCheck:false,OnlyLeafCheck:false">
              
               </ul>
            </div>
      
        
    </div>
</div>
      </div>
      <div class="modal-footer action">
      	<button type="button" class="btn btn-success" onclick="departConfirm();">确定</button>
        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      </div>
      </form>
        
    </div>
  </div>
</div>




    <!-- JavaScript -->
    <script src="${webRoot}/js/datagridUtil.js"></script>
    <script src="${webRoot}/plug-in/echarts/echarts.min.js"></script>
    <script src="${webRoot}/plug-in/echarts/shine.js"></script>
    <script src="${webRoot}/js/selectRow.js"></script>
    <%@include file="/WEB-INF/view/common/modalBox.jsp"%>
    <script type="text/javascript">
    $('.js-select2-tags').select2();
    if(Permission.exist("1355-1")){
        var html='<select id="type" class="cs-selcet-style" style="width: 100px;"></select>';
        $("#typeDiv").append(html);
    }
    if(Permission.exist("1355-2")){
        $("#pointType").removeClass("cs-hide");
    }
    if("${session_user.pointId}"=="" && Permission.exist("1355-3")){
        $("#pointDiv").removeClass("cs-hide");
        queryPoint(${session_user.departId});//查询当前机构下的检测点信息
    }
	var foodId = [];
	var foodName = [];
	var foodNames = [];
	var num = [];
	var qualified=[];
	var unqualified=[];
	var arr=[];
	var foodname=[];
	var foodnames=[];
	var nums=0;
	var qualifiedss=0;
	var unqualifiedss=0;
    var echartMaxLength1 = 20;
    var echartMaxLength2 = 10;
	
	$('#tree').tree({
		checkbox : false,
		url : "${webRoot}/detect/depart/getDepartTree.do",
		animate : true,
		onClick : function(node) {
			var did=node.id;
			$("#did").val(node.id);
            $("#point_select").val("");
			$("input[name='departName']").val(node.text);
			$(".cs-check-down").hide();
            queryPoint(node.id);//查询当前机构下的检测点信息
            departConfirms();
		},
		onSelect:function(node) {
			var did=node.id;
			$("#did").val(node.id);
		}
	});
	
	$("#tree2").tree({
		checkbox:true,
		url:"${webRoot}/data/foodType/foodTree.do",
		animate:true,
		onClick : function(node){
			$("#fid").val(node.id);
			$("input[name='foodName']").val(node.text);
		}
	});
	
	function departConfirm(){
		foodname=[];
		foodnames=[];
		var ffname=[];
		var nodes = $('#tree2').tree('getChecked');
		if ($("#check").is(':checked')) {
			for(var i=1; i<nodes.length; i++){
				foodname.push({
	   	    		  key :nodes[i]["id"],
	   	    		  value :nodes[i]["text"]
	   	    		});
	           foodnames.push(nodes[i]["text"]); 
			}
		}else {
			for(var i=0; i<nodes.length; i++){
				foodname.push({
	   	    		  key :nodes[i]["id"],
	   	    		  value :nodes[i]["text"]
	   	    		});
	           foodnames.push(nodes[i]["text"]); 
			}
		}
		
		$("input[name='foodName']").val(foodnames);
		load(foodname);
		$("#myModal-mid").modal('toggle');
	}
	
	function departConfirms(){
		foodname=[];
		foodnames=[];
		var nodes = $('#tree2').tree('getChecked');
		if(nodes.length>0){
			if ($("#check").is(':checked')) {
				for(var i=1; i<nodes.length; i++){
			           foodname.push({
	      	   	    		  key :nodes[i]["id"],
	      	   	    		  value :nodes[i]["text"]
	      	   	    		});
			           foodnames.push(nodes[i]["text"]); 
				}
			}else {
				for(var i=0; i<nodes.length; i++){
				   foodname.push({
    	   	    		  key :nodes[i]["id"],
    	   	    		  value :nodes[i]["text"]
    	   	    		});
		           foodnames.push(nodes[i]["text"]);
				}
			}
			$("input[name='foodName']").val(foodnames);
			load(foodname);
		}else {
	        $.ajax({
		        type: "POST",
		        url: "${webRoot}/data/foodType/selectByParentId.do",
		        dataType: "json",
		      	success: function(data){
		      		if(data && data.success){
		      			$.each(data.obj, function(k, v) {
		      				if(v.isFood==0){
		      					foodnames.push(v.foodName);
			      				foodname.push({
		      	   	    		  key :v.id,
		      	   	    		  value :v.foodName
		      	   	    		});
		      				}
	        			});
		      			//maps=JSON.stringify(foodname);
		      	        $("input[name='foodName']").val(foodnames);
		      	      	load(foodname);
		        	}else{
		        		console.log("查询失败");
		        	}
				}
		    });
		}
	}
	
	$(function () {
		var date=new Date;
		var monthsss=date.getMonth()+1;
		var year=date.getFullYear();
		$("#month").find("option[value='"+monthsss+"']").attr("selected",true);
		$(".theyear").find("option[value='"+year+"']").attr("selected",true);
		
		if($("#province").val()=="month"){
			year=$("#year1").val();
		}else if ($("#province").val()=="season") {
			year=$("#year2").val();
		}else if ($("#province").val()=="year") {
			year=$("#year").val();
		}
    	$("#years").val(year);
    	var month = (now.getMonth()+1) < 10 ? "0"+(now.getMonth()+1) : (now.getMonth()+1);
		var date = now.getDate() < 10 ? "0"+now.getDate() : now.getDate();
		//时间段
		$("#start").val(now.getFullYear()+"-"+month+"-01");
		$("#end").val(now.getFullYear()+"-"+month+"-"+date);
		$.ajax({
	        type: "POST",
	        url: "${webRoot}/data/foodType/selectByParentId.do",
	        dataType: "json",
	      	success: function(data){
	      		if(data && data.success){
	      			$.each(data.obj, function(k, v) {
	      				if(v.isFood==0){
	      					foodnames.push(v.foodName);
		      				foodname.push({
	      	   	    		  key :v.id,
	      	   	    		  value :v.foodName
	      	   	    		});
	      				}
        			});
	      			maps=JSON.stringify(foodname);
	      	        $("input[name='foodName']").val(foodnames);
	      	      	loadType();
		      		project();
	        	}else{
	        		console.log("查询失败");
	        	}
			}
	    });
		
		/* var s1=new ObjData("1882","蔬菜类"); //创建键值对象
		var s2=new ObjData("2404","畜禽肉及副产品"); //创建键值对象
		var s3=new ObjData("2677","生干坚果与籽类食品"); //创建键值对象
		var s4=new ObjData("2430","鲜蛋"); //创建键值对象
		var s5=new ObjData("2446","水产品"); //创建键值对象
		var s6=new ObjData("195","水果类"); //创建键值对象
        foodname.push(s1); 
        foodname.push(s2); 
        foodname.push(s3); 
        foodname.push(s4); 
        foodname.push(s5); 
        foodname.push(s6);  */
        
        
        
	});
	
	$("#month,#year1,#season,#year,#type,#pointType,#type,#point_select").change(function(){
		departConfirms();
    });
	function project() {
		 $.ajax({
		        type: "POST",
		        url: "${webRoot}/statistics/querydepart.do",
		        dataType: "json",
		      	success: function(data){
		      		if(data && data.success){
		      			$("input[name='departName']").val(data.obj.departName);
		      			var node = $('#tree').tree('find', data.obj.id);
		      			$('#tree').tree('select', node.target);//设置选中该节点
		        	}else{
		        		$("#confirm-warnning .tips").text(data.msg);
						$("#confirm-warnning").modal('toggle');
		        	}
				}
		    });
	}
	
	function loadType() {
 		$.ajax({
	        type: "POST",
	        url: "${webRoot}/regulatory/regulatoryType/queryAll.do",
	        dataType: "json",
	      	success: function(data){
	      		if(data && data.success){
	      			var list=data.obj;
		   			$("#type").empty();
		   			$("#type").append('<option value="">-全部对象-</option>');
		            for (var i in list) {
						$("#type").append('<option value="' + list[i].id+ '">'+list[i].regType+ '</option>');
		            }
		            loads();
	        	}else{
	        		$("#confirm-warnning .tips").text(data.msg);
					$("#confirm-warnning").modal('toggle');
	        	}
			}
	    });
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
		
		if($("#province").val()!="diy"){
			load();
		}
	});
	
	function load(foodname) {
    	maps=JSON.stringify(foodname);
    	
    	var year;
    	if($("#province").val()=="month"){
			year=$("#year1").val();
		}else if ($("#province").val()=="season") {
			year=$("#year2").val();
		}else if ($("#province").val()=="year") {
			year=$("#year").val();
		}
    	$("#years").val(year);
		
		loads();
	}
	
	function loads() {
		$.ajax({
	        type: "POST",
	        url: '${webRoot}'+"/statistics/loadFoodType.do",
	        data:{type:$("#province option:selected").val(),
	        	month:$("#month option:selected").val(),
	        	season:$("#season option:selected").val(),
	        	year:$("#years").val(),
	        	typeObj:$("#type option:selected").val(),
	        	start:$("#start").val(),
	        	end:$("#end").val(),
	        	did:$("#did").val(),
	        	map:maps,
                pointType:$("select[name=pointType]").val(),
                pointId:$("#point_select").val(),
                systemFlag:1 //systemFlag：系统标志，默认为0;0 为通用系统，1 武陵定制系统
	        },
	        dataType: "json",
	        success: function(data){
	        	if(data && data.success){
                    $("#table thead .sortIcon").addClass("icon-sort");
                    $("#table thead .sortIcon").removeClass("icon-xia1");
                    $("#table thead .sortIcon").removeClass("icon-shang1");
                    document.getElementById("table").sortCol = -1;

	        		foodId = [];
	        		foodName = [];
	        		foodNames = [];
	            	num = [];
	            	qualified=[];
	            	unqualified=[];
	            	arr=[];
	            	nums=0;
	            	qualifiedss=0;
	            	unqualifiedss=0;
                    purchaseAmounts=0;
                    destoryNumbers=0;
                    unqualifiedFoods="";
	            	$("#table tbody tr").remove();
	        			$.each(data.obj, function(k, v) {
	        				foodName.push(v.foodName);
	        				qualified.push(v.qualified);
	        				num.push(v.num);
	        				unqualified.push(v.unqualified);
	        				if (v.unqualified>0) {
	        					foodNames.push(v.foodName);
	        					arr.push({
		        	   	    		  name :v.foodName,
		        	   	    		  value :v.unqualified
		        	   	    		});
							}
	        				
	        				var test=v.num==0?(0/1).toFixed(2):((v.qualified/v.num)*100).toFixed(2);
	        				var text=v.num==0?(0/1).toFixed(2):((v.unqualified/v.num)*100).toFixed(2);
	        				var qualifieds=v.qualified==""?0:v.qualified;
	        				var unqualifieds=v.unqualified==""?0:v.unqualified;
	        				nums=nums+v.num;
	        				qualifiedss=qualifiedss+v.qualified;
	        				unqualifiedss=unqualifiedss+v.unqualified;
                            purchaseAmounts=purchaseAmounts+v.purchaseAmount;
                            destoryNumbers=destoryNumbers+v.destoryNumber;
                            if(v.unqualifiedFood){
                                unqualifiedFoods=unqualifiedFoods+v.unqualifiedFood+",";
                            }
	        				var bigbang="<tr>"
	            	    		+"<td class='rowNo' style='width:50px;'>"+(k+1)+"</td>"
	                            +"<td class='firstContextStyle'>"+v.foodName+"</td>"
	                            +"<td class='contextNumber'><a class='cs-link text-primary num' data-rowid="+v.id+">"+v.num+"</a></td>"
	                            +"<td class='contextNumber'><a class='cs-link text-primary qualified' data-rowid="+v.id+">"+qualifieds+"</a></td>"
                                +"<td class='contextNumber'><a class='cs-link text-primary unqualified' data-rowid="+v.id+">"+unqualifieds+"</a></td>"
	                            +"<td class='contextNumber'>"+test+"%</td>"
	                           /* +"<td>"+text+"%</td>"*/
                                +"<td class='contextUnqual'>"+v.purchaseAmount.toFixed(2)+"</td>"
                                +"<td class='contextNumber'>"+v.destoryNumber.toFixed(2)+"</td>"
                                +"<td class='contextStyle'>"+v.unqualifiedFood+"</td>"
	                          	+"</tr>"
	                          	$("#table tbody").append(bigbang);
                            //汇总合计
                            if((data.obj.length-1)==k){
                                unqualifiedFoods=unqualifiedFoods.substring(0,unqualifiedFoods.lastIndexOf(','))
                                let foodStr=removeRepeatStr(unqualifiedFoods);
                                bigbang="<tr><td style='width:50px;'>"+(data.obj.length+1)+"</td>" +
                                    "<td>合计</td>" +
                                    "<td>"+nums+"</td>" +
                                    "<td>"+qualifiedss+"</td>" +
                                    "<td>"+unqualifiedss+"</td>" +
                                    "<td>"+(nums==0?0:((qualifiedss/nums)*100).toFixed(2))+"%</td>" +
                                    /*  "<td>"+(nums==0?0:((unqualifieds/nums)*100).toFixed(2))+"%</td>" +*/
                                    "<td>"+purchaseAmounts.toFixed(2)+"</td>" +
                                    "<td>"+destoryNumbers.toFixed(2)+"</td>" +
                                    "<td>"+foodStr+"</td></tr>";
                                $("#table tbody").append(bigbang);
                            }
	        				});
	        			// $("#table tbody").append("<tr><td style='width:50px;'>"+(data.obj.length+1)+"</td><td>合计</td><td>"+nums+"</td><td>"+qualifiedss+"</td><td>"+(nums==0?0:((qualifiedss/nums)*100).toFixed(2))+"%</td><td>"+unqualifiedss+"</td><td>"+(nums==0?0:((unqualifiedss/nums)*100).toFixed(2))+"%</td></tr>");
	        			
	        			arr.splice(echartMaxLength1);
	        			foodId.splice(echartMaxLength1);
	        			foodName.splice(echartMaxLength1);
        				qualified.splice(echartMaxLength1);
        				num.splice(echartMaxLength1);
        				unqualified.splice(echartMaxLength1);
	        			bigbang();
	        	}else{
	        		console.log("查询失败");
	        	}
			},
			error: function(){
				console.log("查询失败");
			}
	    });
	}
	
	//查看抽检总数
    $(document).on("click",".num",function(){
    	var type=$("#province option:selected").val();
    	var month=$("#month option:selected").val();
    	var season=$("#season option:selected").val();
    	var year=$("#years").val();
    	var start=$("#start").val();
    	var end=$("#end").val();
    	var did=$("#did").val();
    	var dname=$("input[name='departName']").val();
    	var typeObj=$("#type option:selected").val();
        var pointId=$("#point_select").val();
    	if (typeObj!=undefined) {
    		showMbIframe(encodeURI('${webRoot}/statistics/listStatistics?foodTypeId='+$(this).attr("data-rowId")+"&type="+type+"&month="+month+"&season="+season+"&year="+year+"&start="+start+"&end="+end+"&did="+did+"&dname="+dname+"&typeObj="+typeObj +"&pointId="+pointId));
		}else {
			showMbIframe(encodeURI('${webRoot}/statistics/listStatistics?foodTypeId='+$(this).attr("data-rowId")+"&type="+type+"&month="+month+"&season="+season+"&year="+year+"&start="+start+"&end="+end+"&did="+did+"&dname="+dname +"&pointId="+pointId));
		}
    });
  
    //查看合格数
    $(document).on("click",".qualified",function(){
    	var type=$("#province option:selected").val();
    	var month=$("#month option:selected").val();
    	var season=$("#season option:selected").val();
    	var year=$("#years").val();
    	var start=$("#start").val();
    	var end=$("#end").val();
    	var did=$("#did").val();
    	var dname=$("input[name='departName']").val();
    	var typeObj=$("#type option:selected").val();
        var pointId=$("#point_select").val();
    	if (typeObj!=undefined) {
    		showMbIframe(encodeURI('${webRoot}/statistics/listStatistics?foodTypeId='+$(this).attr("data-rowId")+"&type="+type+"&month="+month+"&season="+season+"&year="+year+"&start="+start+"&end="+end+"&did="+did+"&dname="+dname+"&conclusion=0"+"&typeObj="+typeObj +"&pointId="+pointId));
		}else {
			showMbIframe(encodeURI('${webRoot}/statistics/listStatistics?foodTypeId='+$(this).attr("data-rowId")+"&type="+type+"&month="+month+"&season="+season+"&year="+year+"&start="+start+"&end="+end+"&did="+did+"&dname="+dname+"&conclusion=0" +"&pointId="+pointId));
		}
    });
    
  //查看不合格数
    $(document).on("click",".unqualified",function(){
    	var type=$("#province option:selected").val();
    	var month=$("#month option:selected").val();
    	var season=$("#season option:selected").val();
    	var year=$("#years").val();
    	var start=$("#start").val();
    	var end=$("#end").val();
    	var did=$("#did").val();
    	var dname=$("input[name='departName']").val();
    	var typeObj=$("#type option:selected").val();
        var pointId=$("#point_select").val();
    	if (typeObj!=undefined) {
    		showMbIframe(encodeURI('${webRoot}/statistics/listStatistics?foodTypeId='+$(this).attr("data-rowId")+"&type="+type+"&month="+month+"&season="+season+"&year="+year+"&start="+start+"&end="+end+"&did="+did+"&dname="+dname+"&conclusion=1"+"&typeObj="+typeObj +"&pointId="+pointId));
		}else {
			showMbIframe(encodeURI('${webRoot}/statistics/listStatistics?foodTypeId='+$(this).attr("data-rowId")+"&type="+type+"&month="+month+"&season="+season+"&year="+year+"&start="+start+"&end="+end+"&did="+did+"&dname="+dname+"&conclusion=1" +"&pointId="+pointId));
		}
    });
	
		function bigbang() {
			var myChart = echarts.init(document.getElementById('second'),"shine");
			
		  	second = {
			title: {
			    text: '不合格比例',
			    // subtext: 'Monthly pass rate'
			},
			tooltip: {
			    trigger: 'item',
			    formatter: "{a} <br/>{b}: {c} ({d}%)"
			},
			legend: {
			    orient: 'vertical',
			    x: 'right',
			    itemGap:7 ,
			    data:foodNames
			},
			series : [
			    {
			        name: '食品种类',
			        type: 'pie',
			        radius : '45%',
			        center: ['50%', '60%'],
			        data:arr,
			        itemStyle: {
			            emphasis: {
			                shadowBlur: 10,
			                shadowOffsetX: 0,
			                shadowColor: 'rgba(0, 0, 0, 0.5)'
			            }
			        }
			    }
			]
			
			};
		
		   // 使用刚指定的配置项和数据显示图表。
		    myChart.setOption(second);
		
			var myChart1 = echarts.init(document.getElementById('third'),"shine");
			
			third = {
			title: {
			    text: '抽检数量',
			    // subtext: 'Monthly pass rate'
			},
			tooltip : {
			    trigger: 'axis',
			    axisPointer : {            // 坐标轴指示器，坐标轴触发有效
			        type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
			    }
			},
			legend: {
			    data:['合格','不合格']
			},
			grid: {
			    left: '6%',
			    right: '6%',
			    bottom: '10%',
			    containLabel: true
			},
			xAxis : [
		        {
		            type : 'category',
		            data : foodName,
		            axisLabel: {
		                show:true,
		                interval: 0, //强制所有标签显示
		                align:'right',
		                rotate:30,
		                textStyle: {
		                    color: "#000",
		                    lineHeight:16,
		                },
		                formatter: function (params){ 
		                    var index = 8;
		                    var newstr = '';
		                    for(var i=0;i<params.length;i+=index){
		                        var tmp=params.substring(i, i+index);
		                        newstr+=tmp;
		                    }
		                    if( newstr.length > 8)
		                        return newstr.substring(0,8) + '...';
		                    else
		                        return newstr;
		                },
		            },

		        }
		    ],
			/* xAxis : [
			    {
			        type : 'category',
			        data : foodName,
			        axisLabel: {
		                 interval: 0, 
		                  rotate: 20, 
		                  show: true, 
		                  splitNumber: 15, 
		                  textStyle: {
		                      fontSize: 12
		                  }
		              }
			    }
			], */
			yAxis : [
			    {
			        type : 'value'
			    }
			],
			series : [
			    {
			        name:'合格',
			        type:'bar',
			        stack: '食品种类',
			        data:qualified
			    },
			    {
			        name:'不合格',
			        type:'bar',
			        stack: '食品种类',
			        data:unqualified
			    },
			    { 
			      name: '合计总量', 
			      type: 'bar', 
			      stack: '食品种类', 
			      label: { 
			      normal: { 
			      show: true, 
			      position: 'insideBottom', 
			      formatter:'{c}', 
			      textStyle:{ color:'#000' } 
			      }
			      }, 
			      itemStyle:{ 
			      normal:{ 
			      color:'rgba(128, 128, 128, 0)' 
			      } 
			      }, 
			      data: num
			      }
			   
			]
			};
			
			// 使用刚指定的配置项和数据显示图表。
			myChart1.setOption(third);
		}
		
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
    /**
     *根据机构ID查询直属检测点信息
     * @param departId 机构ID
     */
    function queryPoint(departId) {
        var id = departId;
        $("#point_select").empty();
        $.ajax({
            url: "${webRoot}/system/user/getPoint.do",
            type: "POST",
            data: {"id": id},
            dataType: "json",
            async: false,
            success: function (data) {
                var list = data.obj;
                $("#point_select").append('<option value="">-全部检测室-</option>');
                for (var i in list) {
                    $("#point_select").append('<option value="' + list[i].id + '">' + list[i].pointName + '</option>');
                }
            },
            error: function () {
                $.Showmsg("操作失败");
            }
        });
    }
    </script>
  </body>
</html>
