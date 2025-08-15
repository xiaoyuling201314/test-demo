<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/common/resource.jsp"%>
<html>
  <head>
    <title>快检服务云平台</title>
 	<style>
		.is-flex{
			 display: flex;
			 justify-content: center;
			 align-items: center;
		 
		 }
		.way-table{
			background: #fff;
			padding:10px;
			margin-bottom: 10px;
		}
		.way-table table{
			width: 100%;
			background: #fff;
		}
		.way-title{
			background: #0f9bff;
			color: #fff;
			padding:5px 10px;
			/* margin-bottom: 5px; */
			font-weight: bold;
			
		}
		.way-content{
			/* background-color: #fff; */
			/* padding:10px; */
			width: 98%;
			margin: 10px auto;
			
		}
		/* tr:nth-child(even){
			background: #eaf6ff;
		}
		tr:nth-child(odd){
			background: #fff;
		} */
  	</style>
  </head>
	<body style="background:#f1f1f1;">
 <div class="cs-col-lg clearfix">
          <!-- 面包屑导航栏  开始-->
            <ol class="cs-breadcrumb">
              <li class="cs-fl">
              <img src="../public/img/set.png" alt="" />
              <a href="javascript:">数据统计</a></li>
              <li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
              <li class="cs-b-active cs-fl">任务统计
              </li>
               <li class="cs-fl"><i class="cs-sorrow">&gt;</i>
              <li class="cs-b-active cs-fl">
					<a href="javascript:">方法详情</a></li>
            </ol>
			<div class="cs-search-box cs-fr">
					<div class="cs-fr cs-ac">
						<a href="javascript:" onclick="parent.closeMbIframe();" class="cs-menu-btn"><i class="icon iconfont icon-fanhui"></i>返回</a>
					</div>
			</div>
		</div>
	<!-- 列表 -->
		<div class="cs-col-lg-table">
			<div class="way-content">
				<%--<div class="way-title">分光</div>--%>
				<div class="way-table">
                    <table>
                    	<thead>
	                        <tr>
	                            <th class="cs-header" style="width:60px">序号</th>
	                            <th class="cs-header" style="width:30%;">检测项目</th>
	                            <th class="cs-header">计划批次</th>
	                            <th class="cs-header">完成批次</th>
	                            <th class="cs-header">未完成批次</th>
	                            <th class="cs-header">完成率</th>
                        	</tr>
                        </thead>
                        <tbody>
	                        <tr>
	                            <td>1</td>
	                            <td>分光农残</td>
	                            <td>100</td>
	                            <td>99</td>
	                            <td>1</td>
	                            <td>99%</td>
	
	                        </tr>
	                        <tr>
	                            <td>2</td>
	                            <td>胶体金农残</td>
	                            <td>100</td>
	                            <td>96</td>
	                            <td>4</td>
	                            <td>96%</td>
	
	                        </tr>
	
	                        <tr>
	                            <td>3</td>
	                            <td>孔雀石绿</td>
	                            <td>100</td>
	                            <td>97</td>
	                            <td>3</td>
	                            <td>97%</td>
	
	                        </tr>
	                        <tr>
	                            <td>4</td>
	                            <td>二氧化硫</td>
	                            <td>100</td>
	                            <td>99</td>
	                            <td>1</td>
	                            <td>99%</td>
	
	                        </tr>
	                        <tr>
	                            <td>5</td>
	                            <td>莱克多巴胺</td>
	                            <td>100</td>
	                            <td>90</td>
	                            <td>10</td>
	                            <td>90%</td>
	
	                        </tr>
	                        <tr>
	                            <td>7</td>
	                            <td>盐酸克伦特罗</td>
	                            <td>100</td>
	                            <td>99</td>
	                            <td>1</td>
	                            <td>99%</td>
	
	                        </tr>
	                        <tr>
	                            <td>8</td>
	                            <td>亚硝酸盐</td>
	                            <td>100</td>
	                            <td>95</td>
	                            <td>5</td>
	                            <td>95%</td>
	
	                        </tr>
                        </tbody>
                    </table>
				</div>

			</div>

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
    </script>
  </body>
</html>
 