<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/common/resource.jsp"%>
<html>
  <head>
    <title>快检服务云平台</title>
    <style type="text/css">
		.cs-col-lg{
			line-height: 40px;
		}
	</style>
  </head>
	<body>
 <div class="cs-col-lg clearfix">
          <!-- 面包屑导航栏  开始-->
            <ol class="cs-breadcrumb">
              <li class="cs-fl">
              <img src="../public/img/set.png" alt="" />
              <a href="javascript:">数据统计</a></li>
              <li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
              <li class="cs-b-active cs-fl">任务统计
              </li>
            </ol>
			<div class="cs-tb-box pull-left">
			 <div class="cs-input-style">请选择
			    <select id="province" class="cs-selcet-style"> 
			
			      <option value="月报表">月报表</option> 
			
			       <option value="季报表">季报表</option> 
			
			       <option value="年报表">年报表</option> 
			
			    </select> 
			
			  <select class="check-date cs-selcet-style cs-hide"> 
			  </select>
			
			     <select class="check-date cs-selcet-style"> 
			
			       <option>1月</option> 
			
			       <option>2月</option> 
			
			       <option>3月</option> 
			
			       <option>4月</option> 
			
			       <option>5月</option> 
			
			       <option>6月</option> 
			
			       <option>7月</option> 
			
			       <option selected="selected">8月</option>
			
			       <option>9月</option> 
			

			
			    </select>  
			
			    <select class="check-date cs-selcet-style cs-hide"> 
			
			       <option>第一季度</option> 
			
			       <option>第二季度</option> 
			
			       <option>第三季度</option> 
			
			       <option>第四季度</option> 
			
			
			    </select> 
			
			    <select class="check-date cs-selcet-style cs-hide"> 
			
			       <option>2015年</option> 
			
			       <option>2016年</option> 
			
			       <option>2017年</option> 
			
			    </select> 
			     
			  </div>
          </div>

          
          
                    <!-- 为 ECharts 准备一个具备大小（宽高）的 DOM -->
  <!-- <div style="border:1px solid #ddd; padding:10px 0; margin-bottom:10px; border-left:0; border-right:0; clear: both;">
    <div id="third" class="cs-echart" style="width: 50%;height:350px; display:inline-block;"></div>
    <div id="second" class="cs-echart" style="width: 48%;height:350px;display:inline-block; margin-left:1%;"></div>
  </div> -->



<div style="padding-bottom:50px;">
    <table class="cs-table cs-table-hover table-striped cs-tablesorter" >
        <thead>
        <tr>
            <th class="cs-header">序号</th>
            <th class="cs-header">检测点</th>
            <th class="cs-header">检测项目</th>
            <th class="cs-header">计划批次</th>
            <th class="cs-header">完成批次</th>
            <th class="cs-header">完成率</th>
            <th class="cs-header">操作</th>
        </tr>
        </thead>
        <tbody>
        <tr>
            <td>1</td>
            <td>桑园市场</td>
            <td>8</td>
            <td>3029</td>
            <td>2916</td>
            <td>93.33%</td>
            <td><a onclick="viewDetail();" class="icon iconfont icon-chakan"></a></td>
        </tr>
        <tr>
            <td>2</td>
            <td>大塘头市场</td>
            <td>8</td>
            <td>5063</td>
            <td>289</td>
            <td>95.32%</td>
            <td><a onclick="viewDetail();" class="icon iconfont icon-chakan"></a></td>
        </tr>
        <tr>
            <td>3</td>
            <td>九头村市场</td>
            <td>8</td>
            <td>12616</td>
            <td>11436</td>
            <td>95.2%</td>
            <td><a onclick="viewDetail();" class="icon iconfont icon-chakan"></a></td>
        </tr>
        <tr>
            <td>8</td>
            <td>中堂吴家涌市场检测点</td>
            <td>8</td>
            <td>8042</td>
            <td>7800</td>
            <td>96.8%</td>
            <td><a onclick="viewDetail();" class="icon iconfont icon-chakan"></a></td>
        </tr>
        <tr>
            <td>5</td>
            <td>桔洲检测室</td>
            <td>8</td>
            <td>3029</td>
            <td>2916</td>
            <td>93.33%</td>
            <td><a onclick="viewDetail();" class="icon iconfont icon-chakan"></a></td>
        </tr>
        <tr>
            <td>6</td>
            <td>天涯亭检测室</td>
            <td>8</td>
            <td>5063</td>
            <td>4289</td>
            <td>95.32%</td>
            <td><a onclick="viewDetail();" class="icon iconfont icon-chakan"></a></td>
        </tr>
        <tr>
            <td>7</td>
            <td>刘屋检测室</td>
            <td>8</td>
            <td>12616</td>
            <td>1136</td>
            <td>95.2%</td>
            <td><a onclick="viewDetail();" class="icon iconfont icon-chakan"></a></td>
        </tr>
        <tr>
            <td>8</td>
            <td>万江中心市场</td>
            <td>8</td>
            <td>8042</td>
            <td>7300</td>
            <td>96.8%</td>
            <td><a onclick="viewDetail();" class="icon iconfont icon-chakan"></a></td>
        </tr>
        <tr>
            <td>9</td>
            <td>万江蟹地市场</td>
            <td>8</td>
            <td>3029</td>
            <td>2816</td>
            <td>93.33%</td>
            <td><a onclick="viewDetail();" class="icon iconfont icon-chakan"></a></td>
        </tr>
        <tr>
            <td>10</td>
            <td>万江拔蛟窝市场</td>
            <td>8</td>
            <td>5063</td>
            <td>4600</td>
            <td>95.32%</td>
            <td><a onclick="viewDetail();" class="icon iconfont icon-chakan"></a></td>
        </tr>
        <tr>
            <td>11</td>
            <td>朗贝市场</td>
            <td>8</td>
            <td>12616</td>
            <td>11436</td>
            <td>95.2%</td>
            <td><a onclick="viewDetail();" class="icon iconfont icon-chakan"></a></td>
        </tr>
        <tr>
            <td>12</td>
            <td>木伦市场</td>
            <td>8</td>
            <td>12616</td>
            <td>11436</td>
            <td>95.2%</td>
            <td><a onclick="viewDetail();" class="icon iconfont icon-chakan"></a></td>
        </tr>
        <tr>
            <td>13</td>
            <td>寮厦市场检测室</td>
            <td>8</td>
            <td>12616</td>
            <td>11436</td>
            <td>95.2%</td>
            <td><a onclick="viewDetail();" class="icon iconfont icon-chakan"></a></td>
        </tr>
        <tr>
            <td>14</td>
            <td>涌口市场实验室</td>
            <td>8</td>
            <td>12616</td>
            <td>11436</td>
            <td>95.2%</td>
            <td><a onclick="viewDetail();" class="icon iconfont icon-chakan"></a></td>
        </tr>
        <tr>
            <td>15</td>
            <td>矮岭冚市场检测点</td>
            <td>8</td>
            <td>12616</td>
            <td>11436</td>
            <td>95.2%</td>
            <td><a onclick="viewDetail();" class="icon iconfont icon-chakan"></a></td>
        </tr>
        </tbody>
    </table>
</div>
 <!-- Button to trigger modal -->

 

 <!-- 底部导航 开始 -->
      <div class="cs-bottom-tools">
        <ul class="cs-pagination cs-fr">
                <li class="cs-distan">共1页/15条记录</li>
                <li class="cs-b-nav-btn cs-distan cs-selcet">
                <select name="page" id="">
                  <option value="page">10行/页</option>
                  <option value="page">20行/页</option>
                  <option value="page">30行/页</option>
                </select>
                </li>
                <li class="cs-disabled cs-distan"><a class="cs-b-nav-btn" href="#">«</a></li>
                <li><a class="cs-b-nav-btn cs-n-active" href="#">1</a></li>
                <li class="cs-next "><a class="cs-b-nav-btn" href="#">»</a></li>
                <li class="cs-skip cs-distan">跳转<input  type="text" />页</li>
                <li>
                  <a class="cs-b-nav-btn cs-enter cs-distan" href="javascript:">确定</a>
                </li>
              </ul>
      </div>
       <!-- 底部导航 结束 -->



            
             
  
          </div>

      <!-- 内容主体 结束 -->



       

    <!-- JavaScript -->
  <script src="${webRoot}/js/datagridUtil.js"></script>
    <script src="${webRoot}/plug-in/echarts/echarts.min.js"></script>
    <script src="${webRoot}/plug-in/echarts/shine.js"></script>
    <script src="${webRoot}/js/selectRow.js"></script>
    <%@include file="/WEB-INF/view/common/modalBox.jsp"%>
    <script type="text/javascript">
      var myChart = echarts.init(document.getElementById('second'),"shine");
option = {
  title: {
        text: '检测比例',
        // subtext: 'Monthly pass rate'
    },
    tooltip: {
        trigger: 'item',
        formatter: "{a} <br/>{b}: {c} ({d}%)"
    },
    legend: {
        orient: 'vertical',
        x: 'right',
        data:['天河','荔湾','越秀','海珠','白云','黄浦','增城','花都','从化','番禺','南沙']
    },
    series : [
        {
            name: '访问来源',
            type: 'pie',
            radius : '70%',
            center: ['40%', '55%'],
            data:[
                {value:123, name:'天河'},
                {value:231, name:'荔湾'},
                {value:132, name:'越秀'},
                {value:300, name:'海珠'},
                {value:216, name:'白云'},
                {value:289, name:'黄浦'},
                {value:436, name:'增城'},
                {value:300, name:'花都'},
                {value:216, name:'从化'},
                {value:335, name:'番禺'},
                {value:216, name:'南沙'}
            ],
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
        myChart.setOption(option);
    </script>

    <script type="text/javascript">

    var myChart = echarts.init(document.getElementById('third'),"shine");

option = {
  title: {
        text: '检测情况',
        // subtext: 'Monthly pass rate'
    },
    tooltip : {
        trigger: 'axis',
        axisPointer : {            // 坐标轴指示器，坐标轴触发有效
            type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
        }
    },
    legend: {
        data:['已检测','未检测']
    },
    grid: {
        left: '3%',
        right: '4%',
        bottom: '3%',
        containLabel: true
    },
    xAxis : [
        {
            type : 'category',
            data : ['天河','荔湾','越秀','海珠','白云','黄浦','增城','花都','从化','番禺','南沙']
        }
    ],
    yAxis : [
        {
            type : 'value'
        }
    ],
    series : [
        {
            name:'已检测',
            type:'bar',
            stack: '食品种类',
            data:[4980, 5063, 12616, 8042, 3029, 5063, 13423, 8042, 3029, 5063, 3984]
        },
        {
            name:'未检测',
            type:'bar',
            stack: '食品种类',
            data:[20, 132, 101, 134, 290, 230, 220, 101, 134, 290, 230]
        },
        { 
          name: '应检总数', 
          type: 'bar', 
          stack: '食品种类', 
          label: { 
          normal: { 
          offset:['50', '80'], 
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
          data: [5000, 5312, 12342, 8342, 3245, 5312, 12342, 8342, 3245, 5312, 4214]
          }
       
    ]
};


 // 使用刚指定的配置项和数据显示图表。
        myChart.setOption(option);
		 function viewDetail(){
			 showMbIframe('${webRoot}/task/statistics/detail.do');
		 }
    </script>
  </body>
</html>
 