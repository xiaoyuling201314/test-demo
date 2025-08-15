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
              <a href="javascript:">财务管理</a></li>
              <li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
              <li class="cs-b-active cs-fl">收费流水
              </li>
            </ol>
         <div class="cs-search-box cs-fr">
			<form>
			<div class="cs-search-filter clearfix cs-fl">
            <span style="float: left;    line-height: 30px;" >日期：</span>
			<c:choose>
			   <c:when test="${payDate!=null}">
			   	<span class="cs-in-style cs-time-se cs-time-se" style="float: left; margin-right: 20px;"> <input
				name="currentMonth" id="currentMonth" style="width: 110px;"
				class="cs-time Validform_error" type="text" onclick="WdatePicker({dateFmt:'yyyy-M-dd'})"
				value="${payDate}">
				</span>
			   </c:when>
			   <c:otherwise>
			   <span class="cs-in-style cs-time-se cs-time-se" style="float: left;margin-right: 20px;"> <input
				name="beginDate" id="beginDate" style="width: 110px;" class="cs-time Validform_error" type="text" onclick="WdatePicker({startDate:'%y-%M-01 00:00:00',maxDate:'#F{$dp.$D(\'endDate\')}',maxDate:'%y-%M-%d'})">
				-
				<input name="endDate"  id="endDate" style="width: 110px;" class="cs-time Validform_error" type="text" onclick="WdatePicker({minDate:'#F{$dp.$D(\'beginDate\')}',maxDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd'})" >
		     </span> 
			   </c:otherwise>
			</c:choose>
	         
					<input class="cs-input-cont cs-fl focusInput" type="text" name="keyWords" placeholder="请输入关键词" />
					<input type="button" class="cs-search-btn cs-fl" onclick="getList()" href="javascript:;" value="搜索">
				</div>
				<div class="clearfix cs-fr" id="showBtn">
				</div>
				<div class="cs-fr cs-ac">
					<span id="showBtn"></span>

				</div>
			</form>
		</div>
          
          </div>
          <!-- 面包屑导航栏  结束-->
         <!--  
          <div class="cs-input-style cs-fl" style="margin:3px 0 0 4px;">
              <input type="hidden" name="year" id="years"/>
              <select id="province" class="cs-selcet-style pull-left" style="width: 85px;margin-right:4px;"> 
              
				<option value="month" selected="selected">月汇总</option> 
				
                <option value="season">季汇总</option> 

                 <option value="year">年汇总</option> 
                 
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
               <span class="cs-name">时间:</span>
	                <span class="cs-in-style cs-time-se cs-time-se">
	                	<input name="task.taskSdate" style="width: 110px;" class="cs-time Validform_error" id="start" type="text" onclick="WdatePicker()" datatype="date" nullmsg="请选择任务起止时间" errormsg="请选择任务起止时间" value="">
	                	<span style="padding:0 5px;">至</span>
	                    <input name="task.taskSdate" style="width: 110px;" class="cs-time Validform_error" id="end" type="text" onclick="WdatePicker()" datatype="date" nullmsg="请选择任务起止时间" errormsg="请选择任务起止时间" value="">
	                </span>
	                <span>
		            	<a href="javascript:;" class="cs-menu-btn" style="margin:4px 0 0 10px;" onclick="load()"><i class="icon iconfont icon-chakan"></i>查询</a>
		            </span>
                </span>
          </div>
  		  
          </div> -->
                    <!-- 为 ECharts 准备一个具备大小（宽高）的 DOM -->
  
<!-- <div style="border:1px solid #ddd; padding:10px 0; margin-bottom:10px; border-left:0; border-right:0;">
    <div id="third" class="cs-echart" style="width: 63%;height:380px; display:inline-block;"></div>
    <div id="second" class="cs-echart" style="width: 35%;height:380px;display:inline-block; margin-left:1%;"></div>
  </div> -->
<div style="padding-bottom:50px;" id="dataList">
            
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
	$(function(){
		if("${payDate}"){
			$("#showBtn").append('<a href="${webRoot}/income/moneyStatistics" class="cs-menu-btn cs-fun-btn" id="back"><i class="icon iconfont icon-fanhui" ></i>返回</a>');
		}
		getList();
	});
	

	function getList(){
		var day1 = new Date();
		var beginDate = $("#beginDate").val();
		var dates ="";
	    if("${payDate}"==''&&beginDate==''){
			$("#beginDate").val(getPreMonth(new Date()));
			$("#endDate").val(day1.getFullYear()+"-" + (day1.getMonth()+1) + "-" + day1.getDate());
	    }
	    beginDate = $("#beginDate").val();
	    var  endDate = $("#endDate").val();
	    var currentMonth = $("#currentMonth").val()

	    if(typeof(beginDate)== "undefined"){

	    	beginDate = "";
	    }
	    if(typeof(endDate) == "undefined"){
	    	endDate =  "";
	    }
	    if(typeof(currentMonth) == "undefined"){
	    	currentMonth =  "";
	    }
	    
	var op = {
			tableId: "dataList",	//列表ID
			tableAction: "${webRoot}/income/samplingDatagrid"+"?beginDate="+beginDate+"&endDate="+endDate+"&currentMonth="+currentMonth,	//加载数据地址
			onload: function(){
				var obj = datagridOption["obj"];
				inspectionFee=0;
				printingFee=0;
				totalFee=0;
				$(".rowTr").each(function(){
					inspectionFee+=parseFloat($(this).children('.inspectionFee').text());
					printingFee+=parseFloat($(this).children('.printingFee').text());
					totalFee+=parseFloat($(this).children('.totalFee').text());
		    	});  		
			    $("#mdataList").append('<tr class="rowTr" data-rowid="undefined"><td style="width:50px;"><div class="cs-num-cod"><input name="rowCheckBox" type="checkbox" value="undefined" onchange="datagridUtil.changeBox()"><span class="rowNo">'+(obj.length+1)+'</span></div></td><td>合计</td><td></td><td></td><td class="inspectionFee">'+inspectionFee.toFixed(2)+'</td><td class="printingFee">'+printingFee.toFixed(2)+'</td><td class="totalFee">'+totalFee.toFixed(2)+'</td></tr>');
			},
			parameter: [		//列表拼接参数
				{
					columnCode: "samplingNo",
					columnName: "订单编号",
					query: 1,
					columnWidth: "10%",
					customElement: "<a class=\"cs-link text-primary pp\" href=\"javascript:;\">?</a>"
				},
				{
					columnCode: "samplingDate",
					columnName: "下单时间",
					query: 1,
					columnWidth: "12%"
				},
				{
					columnCode: "orderPlatform",
					columnName: "下单方式",
					query: 1,
					columnWidth: "8%",
					queryType: 2,
					customVal: {"0":"自助终端","1":"公众号"}
				},
				
				/*{
					columnCode: "checkCount",
					columnName: "下单次数",
					query: 1,
					queryCode: "baseBean.stdName",
					columnWidth: "12%"
				},
				{
					columnCode: "printCount",
					columnName: "打印次数",
					query: 1,
					queryCode: "baseBean.stdName",
					columnWidth: "12%"
				},
				
				{
					columnCode: "samplingDate",
					columnName: "下单时间",
					query: 1,
					columnWidth: "12%"
				},
			{
					columnCode: "samplingUsername",
					columnName: "送检人",
					query: 1,
					columnWidth: "12%"
				},
				{
					columnCode: "regName",
					columnName: "委托单位",
					query: 1,
					columnWidth: "8%"
				},*/
				{
					columnCode: "inspectionFee",
					columnName: "订单金额(元)",
					query: 1,
					columnWidth: "8%",
					sortDataType:"float",
					customStyle:"inspectionFee"
				},
				{
					columnCode: "printingFee",
					columnName: "重打费用(元)",
					query: 1,
					columnWidth: "8%",
					sortDataType:"float",
					customStyle:"printingFee"
				},
				{
					columnCode: "totalFee",
					columnName: "小计(元)",
					query: 1,
					columnWidth: "8%",
					sortDataType:"float",
					customStyle:"totalFee"
				}
			],
		   defaultCondition: [
			   {
				    queryCode: "payDate",
				    queryVal: "${payDate}"
				}
  			],
			rowTotal: 0,	//记录总数
			pageSize: pageSize,	//每页数量
			pageNo: 1,	//当前页序号
			pageCount: 1,	// 总页数
			bottomBtns: []
			
		};
		datagridUtil.initOption(op);
    	datagridUtil.queryByFocus();
	}
  
    	$(document).on("click",".pp",function(){
    		var samplingId=parseInt($(this).parents(".rowTr").attr("data-rowId"));
        	showMbIframe('${webRoot}/income/detailList.do?samplingId='+samplingId+'&payDate=${payDate}');
        });	
    	
    	
        function getPreMonth(dates) {
        	var date = dateToString(dates);
            var arr = date.split('-');
            var year = arr[0]; //获取当前日期的年份
            var month = arr[1]; //获取当前日期的月份
            var day = arr[2]; //获取当前日期的日
            var days = new Date(year, month, 0);
            days = days.getDate(); //获取当前日期中月的天数
            var year2 = year;
            var month2 = parseInt(month) - 1;
            if (month2 == 0) {
                year2 = parseInt(year2) - 1;
                month2 = 12;
            }
            var day2 = day;
            var days2 = new Date(year2, month2, 0);
            days2 = days2.getDate();
            if (day2 > days2) {
                day2 = days2;
            }
            if (month2 < 10) {
                month2 = '0' + month2;
            }
            var t2 = year2 + '-' + month2 + '-' + day2;
            return t2;
        }
        function dateToString(date){ 
        	  var year = date.getFullYear(); 
        	  var month =(date.getMonth() + 1).toString(); 
        	  var day = (date.getDate()).toString();  
        	  if (month.length == 1) { 
        	      month = "0" + month; 
        	  } 
        	  if (day.length == 1) { 
        	      day = "0" + day; 
        	  }
        	  var dateTime = year + "-" + month + "-" + day;
        	  return dateTime; 
        	}
        
    </script>
  </body>
</html>
