<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/common/resource.jsp"%>
<html>
  <head>
    <title>快检服务云平台</title>
  </head>
	<body>

          <div class="cs-col-lg clearfix">
          <!-- 面包屑导航栏  开始-->
            <ol class="cs-breadcrumb clearfix cs-fl" >
              <li class="cs-fl">
              <img src="${webRoot}/img/set.png" alt="" />
              <a href="javascript:">数据统计</a></li>
              <li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
              <li class="cs-b-active cs-fl">食品名称统计
              </li>
            </ol>
          <!-- 面包屑导航栏  结束-->
          <div class="cs-fl">
          <div class="cs-input-style cs-fl" style="margin:3px 0 0 15px;">
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
              <!-- <select id="projectName"> 
                 <option value="">全部</option>
              </select> --> 
          </div>
          <div class="cs-input-style cs-fl" style="margin:3px 0 0 15px;">
              	<div class="cs-all-ps">
					<div class="cs-input-box">
						<input type="hidden" id="fid"/>
						<input type="text" name="foodName" readonly="readonly"> 
						<div class="cs-down-arrow"></div>
					</div>
					<div class="cs-check-down cs-hide" style="display: none;">
						<ul id="trees" class="easyui-tree"></ul>
					</div>
			    </div>
          </div>
          <div class="cs-input-style cs-fl" style="margin:3px 0 0 15px;" id="typeDiv">

          </div>
          <!--检测点类型条件-->
          <%@include file="selectPointType.jsp"  %>
          <!-- 顶部筛选 -->
         <%@include file="/WEB-INF/view/common/selectDate.jsp"%>
          </div>

            </div>
          </div>
          </div>
          <div class="cs-tb-box">
            
                    <!-- 为 ECharts 准备一个具备大小（宽高）的 DOM -->
  <div class="charts">
    <div id="third" class="cs-echart" style="width: 63%;height:380px; display:inline-block;"></div>
    <div id="second" class="cs-echart" style="width: 35%;height:380px;display:inline-block; margin-left:1%;"></div>
  </div>

<div class="chart-table">
             <table class="cs-table cs-table-hover table-striped cs-tablesorter" id="table">
                <thead>
                  <tr>
                    <th class="cs-header columnHeading" style='width:50px;'>序号</th>
                    <th class="cs-header columnHeading" onclick="datagridUtil.orderBy2('table',1,'string')">食品名称<span class="sortIcon icon iconfont icon-sort"></span></th>
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
 <!-- Button to trigger modal -->

          </div>

      <!-- 内容主体 结束 -->


    <!-- JavaScript -->
    <script src="${webRoot}/js/datagridUtil.js"></script>
    <script src="${webRoot}/plug-in/echarts/echarts.min.js"></script>
    <script src="${webRoot}/plug-in/echarts/shine.js"></script>
    <script src="${webRoot}/js/selectRow.js"></script>
    <%@include file="/WEB-INF/view/common/modalBox.jsp"%>
    <script type="text/javascript">
    var echartMaxLength1 = 20;
    var echartMaxLength2 = 10;

    $(function () {
    for (var i = 0; i < childBtnMenu.length; i++) {
		if(childBtnMenu[i].operationCode == "1310-1"){
			var html='<select id="type" class="cs-selcet-style" style="width: 85px;"></select>';
			$("#typeDiv").append(html);
		}
	}
    if(Permission.exist("1310-2")){
        $("#pointType").removeClass("cs-hide");
    }
    //选择监管对象类型
    $(document).on("change","#type",function(){
        selectDate.query();
    });
	var foodId = [];
	var foodName = [];
	var foodNames = [];
	var num = [];
	var qualified=[];
	var unqualified=[];
	var arr=[];
	var nums=0;
	var qualifieds=0;
	var unqualifieds=0;

	var treeLevel = 1;	//控制机构树加载二级数据
	$('#tree').tree({
		checkbox : false,
		url : "${webRoot}/detect/depart/getDepartTree.do",
		animate : true,
		onClick : function(node) {
			var did=node.id;
			$("#did").val(node.id);
			$("input[name='departName']").val(node.text);
			$(".cs-check-down").hide();
			// loadQuery();
            selectDate.query();
		},
		onSelect:function(node) {
			var did=node.id;
			$("#did").val(node.id);
		},onLoadSuccess: function (node, data) {
			//延迟执行自动加载二级数据，避免与异步加载冲突
			setTimeout(function(){
				if (data && treeLevel == 1) {
					treeLevel++;
					$(data).each(function (index, d) {
			         	if (this.state == 'closed') {
			        		var children = $('#tree').tree('getChildren');
			        		for (var i = 0; i < children.length; i++) {
			            		$('#tree').tree('expand', children[i].target);
			            	}
			         	}
			    	});
				}
			}, 100);
		}
	});
	var treeLevels = 1;	//控制机构树加载二级数据
	$("#trees").tree({
		checkbox:false,
		url:"${webRoot}/data/foodType/foodTree.do",
		animate:true,
		onClick : function(node){
			var fid=node.id;
			$("#fid").val(node.id);
			$("input[name='foodName']").val(node.text);
			$(".cs-check-down").hide();
			// loadQuery();
            selectDate.query();
			//alert(node.id+"===="+node.parentId);
		},
		onSelect:function(node) {
			var fid=node.id;
			$("#fid").val(node.id);
		},
		onLoadSuccess: function (node, data) {
			 if (data[0].parentId!=null&& treeLevels == 2) {
				//调用选中事件
				  var n = $('#trees').tree('find', data[0].id);
				  $('#trees').tree('select', n.target);//设置选中该节点  
		          $("input[name='foodName']").val(data[0].text);
		          // loadData();
		          selectDate.query();
			}  
			//延迟执行自动加载二级数据，避免与异步加载冲突
			setTimeout(function(){
				if (data && treeLevels == 1) {
					treeLevels++;
					$(data).each(function (index, d) {
			         	if (this.state == 'closed') {
			        		var children = $('#trees').tree('getChildren');
			        		for (var i = 0; i < children.length; i++) {
			            		$('#trees').tree('expand', children[i].target);
			            	}
			         	}
			    	});
				}
			}, 100);
		}
	});

		
		project();
		loadType();
		//selectDate修改时间后执行函数
        selectDate.init(loadData);
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
		   			$("#type").append('<option value="">-全部-</option>');
		            for (var i in list) {
						$("#type").append('<option value="' + list[i].id+ '">'+list[i].regType+ '</option>');
		            }
	        	}else{
	        		$("#confirm-warnning .tips").text(data.msg);
					$("#confirm-warnning").modal('toggle');
	        	}
			}
	    });
	}

    function loadData(d) {
    	$.ajax({
	        type: "POST",
	        url: '${webRoot}'+"/statistics/loadFood.do",
	        data:{
                type:d.type,
                year:d.year,
                month:d.month,
                season:d.season,
                start:d.start,
                end:d.end,
                typeObj:$("#type option:selected").val(),
	        	did:$("#did").val(),
	        	fid:$("#fid").val(),
                pointType:$("select[name=pointType]").val()
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
	            	qualifieds=0;
	            	unqualifieds=0;
	            	$("#table tbody tr").remove();
        			$.each(data.obj, function(k, v) {
        				foodId.push(v.foodId);
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
        				
        				nums=nums+v.num;
        				qualifieds=qualifieds+v.qualified;
        				unqualifieds=unqualifieds+v.unqualified;
        				var bigbang="<tr>"
            	    		+"<td class='rowNo' style='width:50px;'>"+(k+1)+"</td>"
                            +"<td>"+v.foodName+"</td>"
                            +"<td><a class='cs-link text-primary num' data-rowid="+v.foodId+">"+v.num+"</a></td>"
                            +"<td><a class='cs-link text-primary qualified' data-rowid="+v.foodId+">"+v.qualified+"</a></td>"
                            +"<td>"+((v.qualified/v.num)*100).toFixed(2)+"%</td>"
                            +"<td><a class='cs-link text-primary unqualified' data-rowid="+v.foodId+">"+v.unqualified+"</a></td>"
                            +"<td>"+((v.unqualified/v.num)*100).toFixed(2)+"%</td>"
                          	+"</tr>";
                          	$("#table tbody").append(bigbang);
        				});
	        			$("#table tbody").append("<tr><td style='width:50px;'>"+(data.obj.length+1)+"</td><td>合计</td><td>"+nums+"</td><td>"+qualifieds+"</td><td>"+(nums==0?0:((qualifieds/nums)*100).toFixed(2))+"%</td><td>"+unqualifieds+"</td><td>"+(nums==0?0:((unqualifieds/nums)*100).toFixed(2))+"%</td></tr>");
	        			
	        			arr.splice(echartMaxLength2);
	        			foodId.splice(echartMaxLength1);
	        			foodNames.splice(echartMaxLength2);
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
    	var year=$("#year"+($("#province option:selected").index()+1)).val();
    	var start=$("#start").val();
    	var end=$("#end").val();
    	var did=$("#did").val();
    	var dname=$("input[name='departName']").val();
    	var typeObj=$("#type option:selected").val();
        var pointType=$("select[name=pointType]").val();
    	if (typeObj!=undefined) {
    		showMbIframe(encodeURI('${webRoot}/statistics/listStatistics?foodId='+$(this).attr("data-rowId")+"&type="+type+"&month="+month+"&season="+season+"&year="+year+"&start="+start+"&end="+end+"&did="+did+"&dname="+dname+"&typeObj="+typeObj+"&pointType="+pointType));
		}else {
			showMbIframe(encodeURI('${webRoot}/statistics/listStatistics?foodId='+$(this).attr("data-rowId")+"&type="+type+"&month="+month+"&season="+season+"&year="+year+"&start="+start+"&end="+end+"&did="+did+"&dname="+dname+"&pointType="+pointType));
		}
    });
  
    //查看合格数
    $(document).on("click",".qualified",function(){
    	var type=$("#province option:selected").val();
    	var month=$("#month option:selected").val();
    	var season=$("#season option:selected").val();
    	var year=$("#year"+($("#province option:selected").index()+1)).val();
    	var start=$("#start").val();
    	var end=$("#end").val();
    	var did=$("#did").val();
    	var dname=$("input[name='departName']").val();
    	var typeObj=$("#type option:selected").val();
        var pointType=$("select[name=pointType]").val();
    	if (typeObj!=undefined) {
    		showMbIframe(encodeURI('${webRoot}/statistics/listStatistics?foodId='+$(this).attr("data-rowId")+"&type="+type+"&month="+month+"&season="+season+"&year="+year+"&start="+start+"&end="+end+"&did="+did+"&dname="+dname+"&conclusion=0"+"&typeObj="+typeObj+"&pointType="+pointType));
		}else {
			showMbIframe(encodeURI('${webRoot}/statistics/listStatistics?foodId='+$(this).attr("data-rowId")+"&type="+type+"&month="+month+"&season="+season+"&year="+year+"&start="+start+"&end="+end+"&did="+did+"&dname="+dname+"&conclusion=0"+"&pointType="+pointType));
		}
    });
    
  //查看不合格数
    $(document).on("click",".unqualified",function(){
    	var type=$("#province option:selected").val();
    	var month=$("#month option:selected").val();
    	var season=$("#season option:selected").val();
    	var year=$("#year"+($("#province option:selected").index()+1)).val();
    	var start=$("#start").val();
    	var end=$("#end").val();
    	var did=$("#did").val();
    	var dname=$("input[name='departName']").val();
    	var typeObj=$("#type option:selected").val();
        var pointType=$("select[name=pointType]").val();
    	if (typeObj!=undefined) {
    		showMbIframe(encodeURI('${webRoot}/statistics/listStatistics?foodId='+$(this).attr("data-rowId")+"&type="+type+"&month="+month+"&season="+season+"&year="+year+"&start="+start+"&end="+end+"&did="+did+"&dname="+dname+"&conclusion=1"+"&typeObj="+typeObj+"&pointType="+pointType));
		}else {
			showMbIframe(encodeURI('${webRoot}/statistics/listStatistics?foodId='+$(this).attr("data-rowId")+"&type="+type+"&month="+month+"&season="+season+"&year="+year+"&start="+start+"&end="+end+"&did="+did+"&dname="+dname+"&conclusion=1"+"&pointType="+pointType));
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
			    data:foodNames,
                formatter: function (params){
                    if(params.length > 8)
                        return params.substring(0,8) + '...';
                    else
                        return params;
                }
			},
			series : [
			    {
			        name: '食品种类',
			        type: 'pie',
			        radius : '45%',
			        center: ['50%', '60%'],
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
			    left: '4%',
			    right: '4%',
			    bottom: '6%',
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
    </script>
  </body>
</html>
