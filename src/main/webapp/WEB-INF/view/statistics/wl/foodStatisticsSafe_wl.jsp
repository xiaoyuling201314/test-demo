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
              <li class="cs-b-active cs-fl">食品安全预警
              </li>
            </ol>
          <!-- 面包屑导航栏  结束-->
              <c:if test="${ empty session_user.pointId }">
                  <div class="cs-input-style cs-fl" style="margin:3px 0 0 15px;">
                      <div class="cs-all-ps">
                          <div class="cs-input-box">
                              <input type="hidden" id="did" value="${did}"/>
                              <input type="text" name="departName" value="${dname}" readonly="readonly" style="width: 100%;">
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
                          <%--检测室： --%><select class="js-select2-tags" name="pointId" id="point_select">
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
          <!--检测点类型条件-->
          <%@include file="/WEB-INF/view/statistics/selectPointType.jsp"  %>
              <!-- 顶部筛选 -->
          <%@include file="/WEB-INF/view/common/selectDate.jsp"%>
            </div>  
            
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
                    <th class="cs-header columnHeading" onclick="datagridUtil.orderBy2('table',1,'string')">食品名称<span class="sortIcon icon iconfont icon-sort"></span></th>
                    <th class="cs-header columnHeading" onclick="datagridUtil.orderBy2('table',2,'int')">抽检总数<span class="sortIcon icon iconfont icon-sort"></span></th>
                    <th class="cs-header columnHeading" onclick="datagridUtil.orderBy2('table',3,'int')">不合格数<span class="sortIcon icon iconfont icon-sort"></span></th>
                    <th class="cs-header columnHeading" onclick="datagridUtil.orderBy2('table',4,'float')">不合格率<span class="sortIcon icon iconfont icon-sort"></span></th>

                      <th class="cs-header columnHeading contextUnqual" onclick="datagridUtil.orderBy2('table',5,'float')">抽样基数(KG)<span class="sortIcon icon iconfont icon-sort"></span></th>
                      <th class="cs-header columnHeading contextNumber" onclick="datagridUtil.orderBy2('table',6,'float')">销毁数(KG)<span class="sortIcon icon iconfont icon-sort"></span></th>
                      <th class="cs-header columnHeading contextStyle" onclick="datagridUtil.orderBy2('table',7,'float')">阳性样品<span class="sortIcon icon iconfont icon-sort"></span></th>
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
    $('.js-select2-tags').select2();
	var foodId = [];
	var foodName = [];
	var foodNames = [];
	var num = [];
	var unqualified=[];
	var arr=[];
	var nums=0;
	var unqualifieds=0;
    var echartMaxLength1 = 20;
    var echartMaxLength2 = 10;
    if(Permission.exist("1348-1")){
        $("#pointType").removeClass("cs-hide");
    }
    if("${session_user.pointId}"=="" && Permission.exist("1348-2")){
        $("#pointDiv").removeClass("cs-hide");
        queryPoint(${session_user.departId});//查询当前机构下的检测点信息
    }
    $('#tree').tree({
        checkbox : false,
        url : "${webRoot}/detect/depart/getDepartTree.do",
        animate : true,
        onClick : function(node) {
            var did=node.id;
            $("#did").val(node.id);
            $("input[name='departName']").val(node.text);
            $(".cs-check-down").hide();
            $("#point_select").val("");
            queryPoint(node.id);//查询当前机构下的检测点信息
            selectDate.query();
        },
        onSelect:function(node) {
            var did=node.id;
            $("#did").val(node.id);
        }
    });
    //selectDate修改时间后执行函数
    selectDate.init(loadData);
    $("#pointType,#point_select").change(function(){
        selectDate.query();
    });
	function loadData(d) {
		$.ajax({
	        type: "POST",
	        url: '${webRoot}'+"/statistics/loadFood2.do",
	        data:{
                type:d.type,
                year:d.year,
                month:d.month,
                season:d.season,
                start:d.start,
                end:d.end,
                did:$("#did").val(),
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
	            	unqualified=[];
	            	arr=[];
	            	nums=0;
	            	unqualifieds=0;
                    purchaseAmounts=0;
                    destoryNumbers=0;
                    unqualifiedFoods="";
	            	$("#table tbody tr").remove();
        			$.each(data.obj, function(k, v) {
        				foodId.push(v.foodId);
        				foodName.push(v.foodName);
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
        				unqualifieds=unqualifieds+v.unqualified;
                        purchaseAmounts=purchaseAmounts+v.purchaseAmount;
                        destoryNumbers=destoryNumbers+v.destoryNumber;
                        if(v.unqualifiedFood){
                            unqualifiedFoods=unqualifiedFoods+v.unqualifiedFood+",";
                        }
        				var bigbang="<tr>"
            	    		+"<td class='rowNo' style='width:50px;'>"+(k+1)+"</td>"
                            +"<td class='firstContextStyle'>"+v.foodName+"</td>"
                            +"<td class='contextNumber'><a class='cs-link text-primary num' data-rowid="+v.foodId+">"+v.num+"</a></td>"
                            +"<td class='contextNumber'><a class='cs-link text-primary unqualified' data-rowid="+v.foodId+">"+v.unqualified+"</a></td>"
                            +"<td class='contextNumber'>"+((v.unqualified/v.num)*100).toFixed(2)+"%</td>"
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
                                "<td>"+unqualifieds+"</td>" +
                                "<td>"+(nums==0?0:((unqualifieds/nums)*100).toFixed(2))+"%</td>" +
                                "<td>"+purchaseAmounts.toFixed(2)+"</td>" +
                                "<td>"+destoryNumbers.toFixed(2)+"</td>" +
                                "<td>"+foodStr+"</td></tr>";
                            $("#table tbody").append(bigbang);
                        }
        				});
	        			// $("#table tbody").append("<tr><td style='width:50px;'>"+(data.obj.length+1)+"</td><td>合计</td><td>"+nums+"</td><td>"+unqualifieds+"</td><td>"+(nums==0?0:((unqualifieds/nums)*100).toFixed(2))+"%</td></tr>");

	        			arr.splice(echartMaxLength2);
	        			foodId.splice(echartMaxLength1);
	        			foodNames.splice(echartMaxLength2);
        				foodName.splice(echartMaxLength1);
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
        var pointId=$("#point_select").val();
    	if (typeObj!=undefined) {
    		showMbIframe(encodeURI('${webRoot}/statistics/listStatistics?foodId='+$(this).attr("data-rowId")+"&type="+type+"&month="+month+"&season="+season+"&year="+year+"&start="+start+"&end="+end+"&did="+did+"&dname="+dname+"&typeObj="+typeObj +"&pointId="+pointId));
		}else {
			showMbIframe(encodeURI('${webRoot}/statistics/listStatistics?foodId='+$(this).attr("data-rowId")+"&type="+type+"&month="+month+"&season="+season+"&year="+year+"&start="+start+"&end="+end+"&did="+did+"&dname="+dname +"&pointId="+pointId));
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
        var pointId=$("#point_select").val();
    	if (typeObj!=undefined) {
    		showMbIframe(encodeURI('${webRoot}/statistics/listStatistics?foodId='+$(this).attr("data-rowId")+"&type="+type+"&month="+month+"&season="+season+"&year="+year+"&start="+start+"&end="+end+"&did="+did+"&dname="+dname+"&conclusion=1"+"&typeObj="+typeObj +"&pointId="+pointId));
		}else {
			showMbIframe(encodeURI('${webRoot}/statistics/listStatistics?foodId='+$(this).attr("data-rowId")+"&type="+type+"&month="+month+"&season="+season+"&year="+year+"&start="+start+"&end="+end+"&did="+did+"&dname="+dname+"&conclusion=1" +"&pointId="+pointId));
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
			    text: '不合格数量',
			    // subtext: 'Monthly pass rate'
			},
			tooltip : {
			    trigger: 'axis',
			    axisPointer : {            // 坐标轴指示器，坐标轴触发有效
			        type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
			    }
			},
			legend: {
			    data:['不合格']
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
				      data: unqualified
				      }
			]
			};
			
			// 使用刚指定的配置项和数据显示图表。
			myChart1.setOption(third);
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
