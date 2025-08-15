<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/common/resource.jsp"%>
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
              <a href="javascript:">数据统计</a></li>
              <li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
              <li class="cs-b-active cs-fl">辖区统计
              </li>
            </ol>
          <!-- 面包屑导航栏  结束-->
          <div class="cs-input-style cs-fl" style="margin:3px 0 0 30px;">
              	<div class="cs-all-ps">
					<div class="cs-input-box">
						<input type="hidden" id="did"/>
						<input type="text" name="departName" readonly="readonly">
						<div class="cs-down-arrow"></div>
					</div>
					<div class="cs-check-down cs-hide" style="display: none;">
						<ul id="tree" class="easyui-tree"></ul>
					</div>
			    </div>
          </div>
          <div class="cs-input-style cs-fl" style="margin:3px 0 0 15px;" id="typeDiv">
          
          </div>
          <!--检测点类型条件-->
          <%@include file="selectPointType.jsp"  %>
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
              <select class="cs-selcet-style"> 


              </select>
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
               <!-- <span class="cs-name">时间:</span> -->
	                <span class="cs-in-style cs-time-se cs-time-se">
	                	<input name="task.taskSdate" id="start" style="width: 120px;" class="cs-time Validform_error" type="text" onclick="WdatePicker()" datatype="date" nullmsg="请选择任务起止时间" errormsg="请选择任务起止时间" value="" autocomplete="off">
	                	<!-- <span style="padding:0 5px;">至</span> -->
	                    <input name="task.taskSdate" id="end" style="width: 120px;" class="cs-time Validform_error" type="text" onclick="WdatePicker()" datatype="date" nullmsg="请选择任务起止时间" errormsg="请选择任务起止时间" value="" autocomplete="off">
	                </span>
	                <span>
		            	<a href="javascript:" class="cs-menu-btn" style="margin:4px 0 0 10px;" onclick="load()"><i class="icon iconfont icon-chakan"></i>查询</a>
		            </span>
                </span>
          </div>
  		  
          </div>
                    <!-- 为 ECharts 准备一个具备大小（宽高）的 DOM -->
		  <div class="charts" style="border:1px solid #ddd; padding:10px 0; margin-bottom:10px; border-left:0; border-right:0;">
		    <div id="third" class="cs-echart" style="width: 63%;height:400px; display:inline-block; padding-bottom:0;"></div>
		    <div id="second" class="cs-echart" style="width: 35%;height:400px;display:inline-block; margin-left:1%;"></div>
		  </div>

		<div class="chart-table" style="padding-bottom:50px;">
             <table class="cs-table cs-table-hover table-striped cs-tablesorter" id="table">
                <thead>
                  <tr>
                  	<th class="cs-header columnHeading" style='width:50px;'>序号</th>
                    <th class="cs-header columnHeading" onclick="datagridUtil.orderBy2('table',1,'string')">辖区<span class="sortIcon icon iconfont icon-sort"></span></th>
                    <th class="cs-header columnHeading" onclick="datagridUtil.orderBy2('table',2,'int')">抽检总数<span class="sortIcon icon iconfont icon-sort"></span></th>
                    <th class="cs-header columnHeading" onclick="datagridUtil.orderBy2('table',3,'int')">合格数<span class="sortIcon icon iconfont icon-sort"></span></th>
                    <th class="cs-header columnHeading" onclick="datagridUtil.orderBy2('table',4,'float')">合格率<span class="sortIcon icon iconfont icon-sort"></span></th>
                    <th class="cs-header columnHeading" onclick="datagridUtil.orderBy2('table',5,'int')">不合格数<span class="sortIcon icon iconfont icon-sort"></span></th>
                    <th class="cs-header columnHeading" onclick="datagridUtil.orderBy2('table',6,'float')">不合格率<span class="sortIcon icon iconfont icon-sort"></span></th>
                  </tr>
                </thead>
                <tbody>
                </tbody>
              </table>
		</div>
		
    </div>

    <!-- 内容主体 结束 -->
    <!-- JavaScript -->
    <script src="${webRoot}/js/datagridUtil.js"></script>
    <script src="${webRoot}/plug-in/echarts/echarts.min.js"></script>
    <script src="${webRoot}/plug-in/echarts/shine.js"></script>
    <script src="${webRoot}/js/selectRow.js"></script>
    <%@include file="/WEB-INF/view/common/modalBox.jsp"%>
    <script type="text/javascript">
    for (var i = 0; i < childBtnMenu.length; i++) {
		if(childBtnMenu[i].operationCode == "1369-1"){
			var html='<select id="type" class="cs-selcet-style" style="width: 85px;"></select>';
			$("#typeDiv").append(html);
		}
	}
    if(Permission.exist("1369-2")){
        $("#pointType").removeClass("cs-hide");
    }
    	var departName=[];
    	var departNames=[];
    	var num=[];
    	var qualified=[];
    	var unqualified=[];
    	var arr=[];
    	var nums=0;
    	var qualifieds=0;
    	var unqualifieds=0;
        var echartMaxLength1 = 20;
        var echartMaxLength2 = 10;
    	
    	$('#tree').tree({
    		checkbox : false,
    		url : "${webRoot}/detect/depart/getDepartTree.do",
    		animate : true,
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
        	var flag=${flag};
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
        		year=date.getFullYear();
        		$("#month").find("option[value='"+monthsss+"']").attr("selected",true);
        		$(".theyear").find("option[value='"+year+"']").attr("selected",true);
    			type=$("#province option:selected").val();
            	month=$("#month option:selected").val();
            	season=$("#season option:selected").val();
            	//year=$("#year option:selected").val();
            	start=$("#start").val();
            	end=$("#end").val();
            	did=$("#did").val();
            	
            	if($("#province").val()=="month"){
    				year=$("#year1").val();
    			}else if ($("#province").val()=="season") {
    				year=$("#year2").val();
    			}else if ($("#province").val()=="year") {
    				year=$("#year").val();
    			}
    	    	$("#years").val(year);
            	
            	project();
			}
    		loadType();
		});

        $("#month,#season,#year,#type,#pointType").change(function(){
            load();
        });
    	/*
    	$("#season").change(function(){
    		load();
        });
    	
    	$("#year").change(function(){
    		load();
        });
    	
    	$("#type").change(function(){
        	load();
        });*/
    	
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
    		   			$("#type").append('<option value="">-全部-</option>');
    		            for (var i in list) {
    						$("#type").append('<option value="' + list[i].id+ '">'+list[i].regType+ '</option>');
    		            }
    		            loadData();
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
    	
		function load() {
	    	var year;
	    	if($("#province").val()=="month"){
				year=$("#year1").val();
			}else if ($("#province").val()=="season") {
				year=$("#year2").val();
			}else if ($("#province").val()=="year") {
				year=$("#year").val();
			}
	    	$("#years").val(year);
	    	loadData();
		}
		
		function loadData() {
			$.ajax({
		        type: "POST",
		        url: '${webRoot}'+"/statistics/loadDepart.do",
		        data:{type:$("#province option:selected").val(),
		        	month:$("#month option:selected").val(),
		        	season:$("#season option:selected").val(),
		        	year:$("#years").val(),
		        	typeObj:$("#type option:selected").val(),
		        	start:$("#start").val(),
		        	end:$("#end").val(),
		        	did:$("#did").val(),
                    pointType:$("select[name=pointType]").val()
		        },
		        dataType: "json",
		        success: function(data){
		        	if(data && data.success){
                        $("#table thead .sortIcon").addClass("icon-sort");
                        $("#table thead .sortIcon").removeClass("icon-xia1");
                        $("#table thead .sortIcon").removeClass("icon-shang1");
                        document.getElementById("table").sortCol = -1;

		        		departName = [];
	        	    	departNames=[];
	        	    	num = [];
	        	    	qualified=[];
	        	    	unqualified=[];
	        	    	arr=[];
	        	    	nums=0;
	        	    	qualifieds=0;
	        	    	unqualifieds=0;
	        	    	$("#table tbody tr").remove();
		        		$.each(data.obj.list, function(k, v) {
				        		departName.push(v.departName);
		        				qualified.push(v.qualified);
		        				num.push(v.num);
		        				unqualified.push(v.unqualified);
		        				
		        				if (v.unqualified>0) {
		        					departNames.push(v.departName);
		        					arr.push({
			        	   	    		  name :v.departName,
			        	   	    		  value :v.unqualified
			        	   	    		});
								}
		        				
		        				var qnum;
		        				var unum;
		        				if(v.num==0){
		        					qnum=(0/1).toFixed(2);
		        					unum=(0/1).toFixed(2);
		        				}else {
		        					qnum=((v.qualified/v.num)*100).toFixed(2);
		        					unum=((v.unqualified/v.num)*100).toFixed(2);
								}
		        				nums=nums+v.num;
		        				qualifieds=qualifieds+v.qualified;
		        				unqualifieds=unqualifieds+v.unqualified;
		        				var bigbang="<tr>"
		            	    		+"<td class='rowNo' style='width:50px;'>"+(k+1)+"</td>"
		                            +"<td>"+v.departName+"</a></td>"
		                            +"<td><a class='cs-link text-primary num' data-rowid="+v.departId+">"+v.num+"</a></td>"
		                            +"<td><a class='cs-link text-primary qualified' data-rowid="+v.departId+">"+v.qualified+"</a></td>"
		                            +"<td>"+qnum+"%</td>"
		                            +"<td><a class='cs-link text-primary unqualified' data-rowid="+v.departId+">"+v.unqualified+"</a></td>"
		                            +"<td>"+unum+"%</td>"
		                          	+"</tr>"
		                          	$("#table tbody").append(bigbang);
		        				});
	        				$("#table tbody").append("<tr><td style='width:50px;'>"+(data.obj.list.length+1)+"</td><td>合计</td><td>"+nums+"</td><td>"+qualifieds+"</td><td>"+(nums==0?0:((qualifieds/nums)*100).toFixed(2))+"%</td><td>"+unqualifieds+"</td><td>"+(nums==0?0:((unqualifieds/nums)*100).toFixed(2))+"%</td></tr>");
		        			arr.splice(echartMaxLength2);
		        			departNames.splice(echartMaxLength2);
		        			departName.splice(echartMaxLength1);
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
            var pointType=$("select[name=pointType]").val();
	    	if (typeObj!=undefined) {
	    		showMbIframe(encodeURI('${webRoot}/statistics/listStatistics?departId='+$(this).attr("data-rowId")+"&type="+type+"&month="+month+"&season="+season+"&year="+year+"&start="+start+"&end="+end+"&did="+did+"&dname="+dname+"&typeObj="+typeObj +"&pointType="+pointType));
			}else {
				showMbIframe(encodeURI('${webRoot}/statistics/listStatistics?departId='+$(this).attr("data-rowId")+"&type="+type+"&month="+month+"&season="+season+"&year="+year+"&start="+start+"&end="+end+"&did="+did+"&dname="+dname +"&pointType="+pointType));
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
            var pointType=$("select[name=pointType]").val();
	    	if (typeObj!=undefined) {
	    		showMbIframe(encodeURI('${webRoot}/statistics/listStatistics?departId='+$(this).attr("data-rowId")+"&type="+type+"&month="+month+"&season="+season+"&year="+year+"&start="+start+"&end="+end+"&did="+did+"&dname="+dname+"&conclusion=0"+"&typeObj="+typeObj +"&pointType="+pointType));
			}else {
				showMbIframe(encodeURI('${webRoot}/statistics/listStatistics?departId='+$(this).attr("data-rowId")+"&type="+type+"&month="+month+"&season="+season+"&year="+year+"&start="+start+"&end="+end+"&did="+did+"&dname="+dname+"&conclusion=0" +"&pointType="+pointType));
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
            var pointType=$("select[name=pointType]").val();
	    	if (typeObj!=undefined) {
	    		showMbIframe(encodeURI('${webRoot}/statistics/listStatistics?departId='+$(this).attr("data-rowId")+"&type="+type+"&month="+month+"&season="+season+"&year="+year+"&start="+start+"&end="+end+"&did="+did+"&dname="+dname+"&conclusion=1"+"&typeObj="+typeObj +"&pointType="+pointType));
			}else {
				showMbIframe(encodeURI('${webRoot}/statistics/listStatistics?departId='+$(this).attr("data-rowId")+"&type="+type+"&month="+month+"&season="+season+"&year="+year+"&start="+start+"&end="+end+"&did="+did+"&dname="+dname+"&conclusion=1" +"&pointType="+pointType));
			}
	    });
		
    	function bigbang() {
    		var myChart = echarts.init(document.getElementById('third'),"shine");
            third = {
    	      title: {
    	            text: '抽检数量',
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
    		            data : departName,
    		            axisLabel: {
    		                show:true,
    		                interval: 0, //强制所有标签显示
    		                align:'right',
    		                rotate:25,
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
    	                data : departName,
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
    	              data:num
    	              }
    	        ]
    	    };


         // 使用刚指定的配置项和数据显示图表。
         myChart.setOption(third);
         
        
        var myChart1 = echarts.init(document.getElementById('second'),"shine");
         
     	second = {
           title: {
                 text: '不合格比例',
             },
             tooltip: {
                 trigger: 'item',
                 formatter: "{a} <br/>{b}: {c} ({d}%)"
             },
             legend: {
                 orient: 'vertical',
                 x: 'right',
                 itemGap:7 ,
                 data:departNames,
                 formatter: function (params){
                     if(params.length > 8)
                         return params.substring(0,8) + '...';
                     else
                         return params;
                 }
             },
             series : [
                 {
                     name: '不合格',
                     type: 'pie',
                     radius : '45%',
                     center: ['40%', '55%'],
                     data:arr,
                     label: {
                         normal: {
                             formatter: '{d}%',
                         }
                     },
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
        myChart1.setOption(second);
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
    </script>
  </body>
</html>
