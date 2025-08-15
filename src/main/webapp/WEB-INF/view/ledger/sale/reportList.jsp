<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/common/resource.jsp"%>
<%@page import="java.util.Date"%>
<html>
  <head>
    <title>快检服务云平台</title>
  </head>
	<body>

          <div class="cs-col-lg clearfix">
          <!-- 面包屑导航栏  开始-->
            <ol class="cs-breadcrumb">
              <li class="cs-fl">
              <img src="${webRoot}/img/set.png" alt="" />
              <a href="javascript:">台账管理</a></li>
              <li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
              <li class="cs-b-active cs-fl">销售台账统计
              </li>
            </ol>
          <div class="cs-input-style cs-fl" style="margin:5px 0 0 15px;">
              	机构:
              	<div class="cs-all-ps">
					<div class="cs-input-box" style="width: 220px">
						<input type="hidden" id="did"/>
						<input type="text" name="departName" readonly="readonly">
						<div class="cs-down-arrow"></div>
					</div>
					<div class="cs-check-down cs-hide" style="display: none;">
						<ul id="tree" class="easyui-tree"></ul>
					</div>
			    </div>
              <!-- <select id="projectName"> 
                 <option value="">全部</option>
              </select> --> 
          </div>
          <!-- 面包屑导航栏  结束-->
        <!-- 顶部筛选 -->
             <div class="cs-input-style cs-fl" style="margin:0 0 0 15px;">
              <select id="province" class="cs-selcet-style" style="width: 85px;display: none" > 
              <!-- 	<option value="day">日报表</option>  -->
				<!-- <option value="month" >月报表</option> 
				
                <option value="season">季报表</option> 

                 <option value="year">年报表</option>  -->
                 
                 <option value="diy" selected="selected">自定义</option> 
              </select> 
              <select class="check-date cs-selcet-style cs-hide" > 
              </select> 
                  <div class="cs-input-style cs-fl " style="margin: 3px 0 0 30px;">
			监管对象类型:
			<select   id="regType" onchange="load();" datatype="*" nullmsg="请选择监管类型" style="padding-left:8px;    width: 120px;"> 
									<c:forEach items="${regulatoryTypes}" var="type">
										<option value="${type.id}"  >${type.regType}</option>
									</c:forEach>
							</select>
			<input name="departids" type="hidden">
			</div>
            <span class="check-date cs-hide">
               <span class="cs-name">时间:</span>
	                <span class="cs-in-style cs-time-se cs-time-se">
	                	<input autocomplete="off" name="task.taskSdate" style="width: 110px;" class="cs-time Validform_error" id="start" type="text" onclick="WdatePicker({maxDate:'#F{$dp.$D(\'end\')}'})" datatype="date"  value="<fmt:formatDate value='<%=new Date()%>' pattern='yyyy-MM-dd'/>">
	                	<span style="padding:0 5px;">
	                                      至</span>
	                    <input autocomplete="off" name="task.taskSdate" style="width: 110px;" class="cs-time Validform_error" id="end" type="text" onclick="WdatePicker({maxDate:'%y-%M-%d',minDate:'#F{$dp.$D(\'start\')}'})" datatype="date" value="<fmt:formatDate value='<%=new Date()%>' pattern='yyyy-MM-dd'/>">
	                </span>
	                <span>
		            	<a href="javascript:" class="cs-menu-btn" style="margin:4px 0 0 10px;" onclick="load()"><i class="icon iconfont icon-chakan"></i>查询</a>
		            </span>
                </span>
          </div>
  		  
                    <!-- 为 ECharts 准备一个具备大小（宽高）的 DOM -->
  <div style="border:1px solid #ddd; padding:10px 0; margin-bottom:10px; border-left:0; border-right:0;">
    <div id="third" class="cs-echart" style="width: 100%;height:380px; display:inline-block;"></div>
     <div id="second" class="cs-echart" style="width: 100%;height:380px; display:inline-block;"></div>
  </div>

		<div style="padding-bottom:50px;">
             <table class="cs-table cs-table-hover table-striped cs-tablesorter" id="table">
                <thead>
                  <tr>
                    <th class="cs-header columnHeading rowNo" style="width: 50px" >序号</th>
                    <th class="cs-header columnHeading" onclick="datagridUtil.orderBy2('table',1,'string')" >监管对象<span class="sortIcon icon iconfont icon-sort"></span></th>
                    <th class="cs-header columnHeading" onclick="datagridUtil.orderBy2('table',2,'int')">档口数<span class="sortIcon icon iconfont icon-sort"></span></th>
                    <th class="cs-header columnHeading " onclick="datagridUtil.orderBy2('table',3,'int')">完成档口数<span class="sortIcon icon iconfont icon-sort"></span></th>
                    <th class="cs-header columnHeading" onclick="datagridUtil.orderBy2('table',4,'int')">未完成档口数<span class="sortIcon icon iconfont icon-sort"></span></th>
                    <th class="cs-header columnHeading"onclick="datagridUtil.orderBy2('table',5,'float')">完成率<span class="sortIcon icon iconfont icon-sort"></span></th>
                  </tr> 
                </thead>
                <tbody>
                  
                </tbody>
              </table>
                 <table class="cs-table cs-table-hover table-striped cs-tablesorter" id="table1">
                <thead>
                  <tr>
                    <th class="cs-header columnHeading rowNo" style="width: 50px" onclick="datagridUtil.orderBy2('table1',0,'int')" >序号</th>
                    <th class="cs-header columnHeading" onclick="datagridUtil.orderBy2('table1',1,'string')" >监管对象<span class="sortIcon icon iconfont icon-sort"></span></th>
                    <th class="cs-header columnHeading" onclick="datagridUtil.orderBy2('table1',2,'int')">台账数量<span class="sortIcon icon iconfont icon-sort"></span></th>
                  </tr> 
                </thead>
                <tbody id="b1">
                  
                </tbody>
              </table>
		</div>
 <!-- Button to trigger modal -->
      <!-- 内容主体 结束 -->
      
    <!-- JavaScript -->
    <script src="${webRoot}/plug-in/echarts/echarts.min.js"></script>
    <script src="${webRoot}/plug-in/echarts/shine.js"></script>
        <script src="${webRoot}/js/datagridUtil.js"></script>
   
	<script type="text/javascript">
	var regId = [];
 	var regName = [];
 	var num = [];
 	var qualified=[];
 	var unqualified=[];
 	var arr=[];
 	
 	$('#tree').tree({
		checkbox : false,
		url : "${webRoot}/detect/depart/getDepartTree.do",
		animate : true,
		onLoadSuccess: function (node, data) {
		    if (data.length > 0) {
		    	$("input[name='departName']").val(data[0].text);
		             }
		      }, 
		onClick : function(node) {
			var did=node.id;
			$("#did").val(node.id);
			$("input[name='departName']").val(node.text);
			$(".cs-check-down").hide();
			load();
		},
		onSelect:function(node) {
			var did=node.id;
			$("#did").val(node.id);
		}
	});
 	
 	$(function () {
 		var type;
    	var month;
    	var season;
    	var year;
    	var start;
    	var end;
    	var did;
    	var flag=1;
    	var dname;
    	
		if(flag==1){
			type="${type}";
        	month="${month}";
        	season="${season}";
        	year="${year}";
        	start="${start}";
        	end="${end}";
        	did="${did}";
        	dname="${dname}";
        	
        	$("input[name='departName']").val(dname);

  			$("#province").find("option[value='"+type+"']").attr("selected",true);
  			$("#month").find("option[value='"+month+"']").attr("selected",true);
  			$("#season").find("option[value='"+season+"']").attr("selected",true);
  			$("#year").find("option[value='"+year+"']").attr("selected",true);
  			$("#start").find("option[value='"+start+"']").attr("selected",true);
  			$("#end").find("option[value='"+end+"']").attr("selected",true);
  			$("#did").val(did);
  			
  			$("#province option").each(function(i){
                if($(this).val() == $("#province option:selected").val()){
                 $(".check-date").hide().val();
                 $(".check-date").eq(i+1).show();
               }
            });
		}else if (flag==0){
			var date=new Date;
    		var monthsss=date.getMonth()+1;
    		$("#month").find("option[value='"+monthsss+"']").attr("selected",true);
    		
			type=$("#province option:selected").val();
        	month=$("#month option:selected").val();
        	season=$("#season option:selected").val();
        	year=$("#year option:selected").val();
        	start=$("#start").val();
        	end=$("#end").val();
        	did=$("#did").val();
        	
        //project();
		}
		$("#start").val(getBeforeDate(3));
			loadData();
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
  	
  	$("#month").change(function(){
		load();
    });
	
	$("#season").change(function(){
		load();
    });
	
	$("#year").change(function(){
		load();
    });
 	
	function load() {
		regId = [];
		regName = [];
    	num = [];
    	qualified=[];
    	unqualified=[];
    	arr=[];
    	$("#table tbody tr").remove();

    	loadData();
	}
    
	function loadData() {
		var regTypeId=$('#regType option:selected') .val();
		if(!regTypeId){
			return;
		}
		$.ajax({
	        type: "POST",
	        url: '${webRoot}'+"//ledger/sale/loadRegReport.do",
	        data:{type:$("#province option:selected").val(),
	        	month:$("#month option:selected").val(),
	        	season:$("#season option:selected").val(),
	        	year:$("#year option:selected").val(),
	        	start:$("#start").val(),
	        	end:$("#end").val(),
	        	regTypeId:regTypeId,
	        	did:$("#did").val()
	        },
	        dataType: "json",
	        success: function(data){
	        	if(data && data.success){
	        		var  allNum=0;
	        		var allyiwanc=0;
	        		var allwwc=0;
	        		if(data.attributes.scstock==1){//市场录入数据
        				$("#third").hide();
        				$("#second").show();
        				$("#table").hide();
        				$("#table1").show();
        				$.each(data.obj, function(k, v) {
	        				var wwc=v.allCount-v.yiwanc;//未完成数量
	        				regId.push(v.reg_id);
	        				regName.push(v.reg_name);
	        				qualified.push(v.yiwanc);//已完成
	        				num.push(v.allCount);//总数
	        				unqualified.push(wwc);
	        				arr.push({
	        	   	    		  name :v.reg_name,
	        	   	    		  value :v.allCount-v.yiwanc
	        	   	    		});
							var allCount=v.allCount;
							var wcl=0.00;
							if(allCount!=0){
								wcl=((v.yiwanc/v.allCount)*100).toFixed(2);
							}
							allNum=allNum+v.yiwanc;
							allyiwanc=allyiwanc+v.yiwanc;
							allwwc=allwwc+wwc;
	        				var bigbang="<tr>"
	            	    		+"<td  class='rowNo' style='width:50px;'>"+(k+1)+"</td>"
	                            +"<td>"+v.reg_name+"</td>"
	                            +"<td>"+v.yiwanc+"</td>"
	                            		+"</tr>"
	                          	$("#b1").append(bigbang);
	        				});
	        			var allwcl=0;
						if(allNum!=0){
							allwcl=((allyiwanc/allNum)*100).toFixed(2);
						}
	        			$("#b1").append("<tr><td style='width:50px;'>"+(data.obj.length+1)+"</td><td>合计</td><td>"+allNum+"</td> </tr>");
	        		
	        			var n=33;//控制条数
	        			arr.splice(n);
	        			regId.splice(n);
	        			regName.splice(n);
        				qualified.splice(n);
        				num.splice(n);
        				unqualified.splice(n);
	        			bigbang1();
        			}else{
        				$("#table").show();
        				$("#second").hide();
        				$("#third").show();
        				$("#table1").hide();
	        			$.each(data.obj, function(k, v) {
	        				var wwc=v.allCount-v.yiwanc;//未完成数量
	        				regId.push(v.reg_id);
	        				regName.push(v.reg_name);
	        				qualified.push(v.yiwanc);//已完成
	        				num.push(v.allCount);//总数
	        				unqualified.push(wwc);
	        				arr.push({
	        	   	    		  name :v.reg_name,
	        	   	    		  value :v.allCount-v.yiwanc
	        	   	    		});
							var allCount=v.allCount;
							var wcl=0.00;
							if(allCount!=0){
								wcl=((v.yiwanc/v.allCount)*100).toFixed(2);
							}
							allNum=allNum+v.allCount;
							allyiwanc=allyiwanc+v.yiwanc;
							allwwc=allwwc+wwc;
	        				var bigbang="<tr>"
	            	    		+"<td  class='rowNo' style='width:50px;'>"+(k+1)+"</td>"
	                            +"<td>"+v.reg_name+"</td>"
	                            +"<td>"+v.allCount+"</td>"
	                            +"<td>"+v.yiwanc+"</td>"
	                            +'<td>'+wwc+'</td>'
	                            +"<td>"+wcl+"%</td>"
	                            		+"</tr>"
	                          	$("#table tbody").append(bigbang);
	        				});
	        			var allwcl=0;
						if(allNum!=0){
							allwcl=((allyiwanc/allNum)*100).toFixed(2);
						}
	        			$("#table tbody").append("<tr><td style='width:50px;'>"+(data.obj.length+1)+"</td><td>合计</td><td>"+allNum+"</td><td>"+allyiwanc+"</td><td>"+allwwc+"</td><td>"+allwcl+"%</td></tr>");
	        		
	        			var n=33;//控制条数
	        			arr.splice(n);
	        			regId.splice(n);
	        			regName.splice(n);
        				qualified.splice(n);
        				num.splice(n);
        				unqualified.splice(n);
	        			bigbang();
	        			 datagridUtil.orderBy2('table',4,'int'); 
		        			datagridUtil.orderBy2('table',5,'float');
		        			datagridUtil.orderBy2('table',5,'float');
        			}
	        	}else{
	        		console.log("查询失败");
	        	}
			},
			error: function(){
				console.log("查询失败");
			}
	    });
	}
	
  	//查看被检单位
    $(document).on("click",".aa",function(){
    	var type=$("#province option:selected").val();
    	var month=$("#month option:selected").val();
    	var season=$("#season option:selected").val();
    	var year=$("#year option:selected").val();
    	var start=$("#start").val();
    	var end=$("#end").val();
    	var did=$("#did").val();
    	var dname=$("input[name='departName']").val();
    	self.location = '${webRoot}/statistics/orgStatisticsMon?regId='+$(this).attr("data-rowId")+"&type="+type+"&month="+month+"&season="+season+"&year="+year+"&start="+start+"&end="+end+"&did="+did+"&dname="+dname;
    });
	
	function bigbang() {
	   // 使用刚指定的配置项和数据显示图表。
		var myChart1 = echarts.init(document.getElementById('third'),"shine");
		third = {
		title: {
		    text: '销售台账完成情况',
		},
		tooltip : {
		    trigger: 'axis',
		    axisPointer : {            // 坐标轴指示器，坐标轴触发有效
		        type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
		    }
		},
		legend: {
		    data:['完成','未完成']
		},
		grid: {
		    left: '3%',
		    right: '6%',
		    bottom: '25%',
		    containLabel: true
		},
		xAxis : [
		    {
		        type : 'category',
		        axisLabel: {
		            interval: 0, 
		            rotate: 35, 
		            show: true, 
		            splitNumber: 15, 
		            textStyle: {
		                fontSize: 12
		            }
		        }, 
		        data : regName
		    }
		],
		yAxis : [
		    {
		        type : 'value'
		    }
		],
		series : [
		    {
		        name:'完成',
		        type:'bar',
		        stack: '被检单位',
		        data:qualified
		    },
		    {
		        name:'未完成',
		        type:'bar',
		        stack: '被检单位',
		        data:unqualified
		    },
		    { 
		      name: '合计总量', 
		      type: 'bar', 
		      stack: '被检单位', 
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
	function getBeforeDate(n){
		var date = new Date() ;
		var year,month,day ;
		date.setDate(date.getDate()-n);
		year = date.getFullYear();
		month = date.getMonth()+1;
		day = date.getDate() ;
		s = year + '-' + ( month < 10 ? ( '0' + month ) : month ) + '-' + ( day < 10 ? ( '0' + day ) : day) ;
		return s ;
	} 
	
	function bigbang1() {
		   // 使用刚指定的配置项和数据显示图表。
			var myChart1 = echarts.init(document.getElementById('second'),"shine");
			second = {
			title: {
			    text: '销售台账完成情况',
			},
			tooltip : {
			    trigger: 'axis',
			    axisPointer : {            // 坐标轴指示器，坐标轴触发有效
			        type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
			    }
			},
			legend: {
			    data:['完成']
			},
			grid: {
			    left: '3%',
			    right: '6%',
			    bottom: '25%',
			    containLabel: true
			},
			xAxis : [
			    {
			        type : 'category',
			        axisLabel: {
			            interval: 0, 
			            rotate: 35, 
			            show: true, 
			            splitNumber: 15, 
			            textStyle: {
			                fontSize: 12
			            }
			        }, 
			        data : regName
			    }
			],
			yAxis : [
			    {
			        type : 'value'
			    }
			],
			series : [
			    {
			        name:'完成',
			        type:'bar',
			        stack: '被检单位',
			        data:qualified
			    } 
			]
			};
			// 使用刚指定的配置项和数据显示图表。
		    myChart1.setOption(second);
		}
    </script>
  </body>
</html>
