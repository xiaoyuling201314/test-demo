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
              <li class="cs-b-active cs-fl">收费汇总
              </li>
            </ol>
            <div class="cs-search-box cs-fr">
				<form>
				<!-- 	<span class="check-date cs-fl" style="display: inline;">
					<span class="cs-name">时间范围:</span> 
					<span class="cs-in-style cs-time-se cs-time-se">
						<input name="checkDateStartDateStr" style="width: 110px;" class="cs-time Validform_error focusInput" type="text"
                               onclick="WdatePicker()" datatype="date">
						<span style="padding: 0 5px;">至</span> 
						<input name="checkDateEndDateStr"  style="width: 110px;" class="cs-time Validform_error focusInput" type="text"
                               onclick="WdatePicker()" datatype="date">
					</span>
				</span>
						&nbsp;<input type="button" class="cs-search-btn cs-fl" onclick="loadData();" href="javascript:;" value="搜索">
				 -->
				</form>
			</div>
          <div class="cs-input-style cs-fl" style="margin:3px 0 0 30px;">
              	<div class="cs-all-ps">
					
			    </div>
          </div>
          <div class="cs-input-style cs-fl" style="margin:3px 0 0 15px;" id="typeDiv">
          
          </div>
          <!-- 面包屑导航栏  结束-->
          <!-- 顶部筛选 按月、季度、年进行数据查找 -->
		<%@include file="/WEB-INF/view/common/selectDate.jsp"%>
          </div>
  		  
          </div>
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
    <script src="${webRoot}/js/datagridUtil2.js"></script>
    <script src="${webRoot}/plug-in/echarts/echarts.min.js"></script>
    <script src="${webRoot}/plug-in/echarts/shine.js"></script>
    <script src="${webRoot}/js/selectRow.js"></script>
    <%@include file="/WEB-INF/view/common/modalBox.jsp"%>
	<script type="text/javascript">


    var datagrid1 = datagridUtil.initOption({
        tableId: "dataList",	//列表ID
        tableAction: "${webRoot}/income/datagrid.do",	//加载数据地址
        onload: function(obj){
            totalCheck=0;
            totalPrint=0;
            totalCount=0;
            $(".rowTr").each(function(){
                totalCheck+=parseFloat($(this).children('.checkMoney').text());
                totalPrint+=parseFloat($(this).children('.printMoney').text());
                totalCount+=parseFloat($(this).children('.total').text());
            });
            //
            $("#mdataList").append('<tr class="rowTr" data-rowid="undefined"><td style="width:50px;"><div class="cs-num-cod"><input name="rowCheckBox" type="checkbox" value="undefined" onchange="datagridUtil.changeBox()"><span class="rowNo">'+(obj.length+1)+'</span></div></td><td>合计</td><td class="checkMoney">'+totalCheck.toFixed(2)+'</td><td class="printMoney">'+totalPrint.toFixed(2)+'</td><td class="total">'+totalCount.toFixed(2)+'</td></tr>');
        },
        parameter: [		//列表拼接参数
            {
                columnCode: "payDate",
                columnName: "日期",
                query: 1,
                columnWidth: "10%",
                customElement: "<a class=\"cs-link text-primary pp\" href=\"javascript:;\">?</a>"
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
            },*/

            {
                columnCode: "checkMoney",
                columnName: "订单金额(元)",
                query: 1,
                queryCode: "baseBean.stdCode",
                columnWidth: "12%",
                sortDataType:"float",
                customStyle:"checkMoney"
            },
            {
                columnCode: "printMoney",
                columnName: "重打费用(元)",
                query: 1,
                columnWidth: "12%",
                sortDataType:"float",
                customStyle:"printMoney"
            },
            {
                columnCode: "total",
                columnName: "小计(元)",
                query: 1,
                columnWidth: "8%",
                sortDataType:"float",
                customStyle:"total"
            }
        ],
        defaultCondition: [
            {
                queryCode: "type",
                queryVal: ""
            }, {
                queryCode: "month",
                queryVal: ""
            }, {
                queryCode: "season",
                queryVal: ""
            }, {
                queryCode: "year",
                queryVal: ""
            }, {
                queryCode: "start",
                queryVal: ""
            }, {
                queryCode: "end",
                queryVal: ""
            }
        ],
        rowTotal: 0,	//记录总数
        pageSize: pageSize,	//每页数量
        pageNo: 1,	//当前页序号
        pageCount: 1,	// 总页数
        bottomBtns: []

    });
    //selectDate修改时间后执行函数
    selectDate.init(function (d){
        datagrid1.addDefaultCondition("type", d.type);
        datagrid1.addDefaultCondition("year", d.year);
        datagrid1.addDefaultCondition("season", d.season);
        datagrid1.addDefaultCondition("month", d.month);
        datagrid1.addDefaultCondition("start", d.start);
        datagrid1.addDefaultCondition("end", d.end);
        datagrid1.query();
    });

    $(document).on("click",".pp",function(){
    	//showMbIframe('${webRoot}/income/detailList.do?dateStr='+$(this).text());
    	self.location='${webRoot}/income/samplingList.do?payDate='+$(this).text();
    });	
    </script>
  </body>
</html>
