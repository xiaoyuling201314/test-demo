<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/common/resource.jsp"%>
<html>
<head>
<title>快检服务云平台</title>
<style type="text/css">
      .cs-ul-form{
        padding:5px 0;
      }
      .cs-beizhu{
        margin-top: 10px;
        float: left;
      }
      .cs-show-alls{
        /*line-height: 38px;
        border-bottom:1px solid #ddd;*/
        /*text-align: center;*/
        background: #ddd;
        margin-bottom: 20px;
        cursor:pointer;
        
      }
      .cs-show-alls i{
        font-size: 20px;
      }
      .cs-content2 h2{
        font-size: 18px;
        /*text-align: center;
        padding:15px 0;*/
        padding:10px;
        margin-top:10px;
        font-weight: bold;
      }
      .cs-content2 h3 {
        padding-left: 10px;
        border-left: 0px;
        /*padding:10px;*/
    }
      .cs-report-content{
        padding:20px;
        background:#f1f1f1;
      }
      .cs-report-content p{
        text-indent: 2em;
        font-size:16px;
      }
      .cs-report-content p i{
        color:#009a30;
      }
      .cs-content2 h3 a{
        font-weight: normal;
      }
      .cs-table th {
	    /* border-left: 0; */
	    background: #f1f1f1;
	    color: #008028;
		}
		.cs-schedule-mao {
    
	    margin-bottom: 0px;
	    padding-bottom: 10px;
	    padding-top: 0px;
	    }
	    .echarts{
	    	padding:10px 0;
	    }
      @media print{
        .cs-show-alls,.cs-col-lg{
            display: none;
        }
      }
    </style>
</head>
<body>
	<div class="cs-col-lg clearfix" style="border-bottom:;">
	<!-- 面包屑导航栏  开始-->
		<ol class="cs-breadcrumb">
			<li class="cs-fl">
			<img src="${webRoot}/img/set.png" alt="" />
			<a href="javascript:">数据报表</a></li>
			<li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
			<li class="cs-b-active cs-fl">项目总结</li>
		</ol>
	<!-- 面包屑导航栏  结束-->
		<div class="cs-search-box cs-fr">
				<form action="">
					<div class="cs-fr cs-ac" id="showBtn">
						<%-- <a href="${webRoot}/datastatistics/projectReport?id=${id}" class="cs-menu-btn"><i class="icon iconfont icon-fanhui"></i>导出</a> --%>
						<a href="javascript:" class="cs-menu-btn" onclick="outPic()"><i class="icon iconfont icon-daochu"></i>导出</a>
					</div>
				</form>
			</div>
	</div>


<div class="cs-tb-box">
	<div class="cs-content2 ">
		<h2>1.总结报告</h2>
	</div>    
	<div class="cs-report-content">
		<p id="part1"><i>${dataStatistics.start}
		<c:choose>  
			<c:when test="${!empty dataStatistics.end}">-${dataStatistics.end}</c:when>  
			   <c:otherwise></c:otherwise>  
		</c:choose>
		</i>，<i>广东中检达元检测技术有限公司</i>对<i>${dataStatistics.departName}</i>机构的</p>
		<p id="part2"></p>
		<p id="part3"></p>
		<p id="part4"></p>
		<p id="part5"></p>
		<p >在实际工作中，发现阳性品，与市场开办方及时通知档主并下架或销毁处理，及时控制问题农产品的食品安全危害。</p>
	</div>
	<!-- 各市场抽检情况（批次） -->
	<div>
		<div class="cs-content2 ">
			<h2>2.数据分析</h2>
		    <h3>2.1市场抽检情况（批次）</h3>
		</div>
		<table class="cs-table cs-table-hover table-striped cs-tablesorter a" id="table1">
	    <thead>
	    <tr id="tl1">
	       
	    </tr>
	    <tr id="tr1">
	
	    </tr>
		</thead>
		<tbody>
		  
		</tbody>
		</table>
		<div class="cs-show-alls text-center"><i class="icon iconfont icon-xia"></i></div>
	</div>
 <!-- 各市场抽检情况（批次） -->
 <!-- 各市场阳性情况（批次） -->
 <div>
	<div class="cs-content2 ">
	    <h3>2.2市场阳性情况（批次）</h3>
	</div>
	<table class="cs-table cs-table-hover table-striped cs-tablesorter a" id="table2">
    <thead>
    <tr id="tl2">
        
    </tr>
    <tr id="tr2">

    </tr>
  </thead>
  <tbody>
    
  </tbody>
</table>
<div class="cs-show-alls text-center"><i class="icon iconfont icon-xia"></i></div>
</div>
 <!-- 各市场阳性情况（批次） -->
 <!-- 各市场阳性率情况（批次） -->
 <div>
	<div class="cs-content2 ">
	    <h3>2.3市场阳性率情况（%）</h3>
	</div>
	<table class="cs-table cs-table-hover table-striped cs-tablesorter a" id="table3">
	    <thead>
		    <tr id="tl3">
		        
		    </tr>
		    <tr id="tr3">
		
		    </tr>
	  	</thead>
	  	<tbody>
	    
	  	</tbody>
	</table>
	<div class="cs-show-alls text-center"><i class="icon iconfont icon-xia"></i></div>
</div>
 <div>
	<div class="cs-content2 ">
        <h3>2.4市场检测及不合格处理情况（处理数量单位：公斤）</h3>
    </div>
     <table class="cs-table cs-table-hover table-striped cs-tablesorter b" id="table4">
        <thead>
          <tr id="foodType">
            <th class="cs-header" rowspan="2">序号</th>
            <th class="cs-header" rowspan="2">市场名称</th>
            <th colspan="4" class="cs-header">检测总数</th>
          </tr>
          <tr id="checkType">
            <th class="cs-header" >检测批次</th>
            <th class="cs-header">不合格</th>
            <th class="cs-header">合格率</th>
            <th class="cs-header">处理数量</th>
            
          </tr>
        </thead>
        <tbody id="foodData">

          
        </tbody>
      </table>
     <div class="cs-show-alls text-center"><i class="icon iconfont icon-xia"></i></div>
 </div>
 <div>
	<!-- 阳性样品信息表 -->
	<div class="cs-schedule-mao col-lg-12 col-md-12 clearfix"></div>
	<div class="cs-content2 col-md-12 col-sm-12">
		<h3>2.5已处理阳性样品信息表</h3>
	</div>
	<table class="cs-table cs-table-hover table-striped cs-tablesorter b" id="table5">
		<thead>
			<tr>
			<th class="cs-header" >序号</th>
			<th class="cs-header">市场名称</th>
			<th class="cs-header" >样品名</th>
			<th class="cs-header">样品分类</th>
			<th class="cs-header">档口</th>
			<th class="cs-header">经营者</th>
			<th class="cs-header" >不合格项目</th>
			<th class="cs-header">处理方法</th>
			<th class="cs-header">数量（KG）</th>
			<th class="cs-header">检测日期</th>
			</tr>
		</thead>
		<tbody id="dataList">
		
		</tbody>
	</table>
	<div class="cs-show-alls text-center"><i class="icon iconfont icon-xia"></i></div>
</div>
 <!-- 各市场阳性率情况（批次） -->
 	<div class="cs-content2 ">
		<h2>3.数据图表</h2>
	    <!-- <h3>3.1市场阳性率</h3> -->
	</div>
	<div class="cs-schedule-mao col-lg-12 col-md-12 clearfix">           
		<!-- <div class="cs-include-title col-lg-12 col-md-12" >市场阳性率</div> -->
		<div id="progress7" style="height:380px;width:100%;"></div>
	</div>
	
	<div class="cs-schedule-mao col-lg-12 col-md-12 clearfix" id="echarts">
		<div class="col-lg-6 col-md-6 clearfix" style="padding:0px 0px 30px 0px; border-right:1px solid #eee;" >
				<!-- <div class="cs-include-title col-lg-12 col-md-12" >品类阳性率（%）</div> -->
				<div id="progress0" class="echarts" style="height:380px;width:100%;"></div>
		</div>
	</div>
</div>
<%@include file="/WEB-INF/view/common/confirm.jsp"%>
<script src="${webRoot}/js/dateUtil.js"></script>
<script type="text/javascript">
/* if('${dataStatistics.state}'=='0'){
	$("#confirm-warnning .tips").text("项目总结正生成中，请稍后查看");
	$("#confirm-warnning").modal('toggle');  
} */
var MarketName=[];
var Unqualified=[];
$(function () {
	if('${dataStatistics.state}'=='1'){
		$.ajax({
	    	url:"${webRoot}/datastatistics/projectDataStatisticsList.do",
	    	type:"POST",
	    	/* data:{"id":id}, */
	    	dataType:"json",
	    	success:function(data){
	    		var row=1;
	    		var tl="<th class='cs-header' rowspan='2'>市场名称</th>"
	    		$.each(data.obj.labelMap, function(k, v) {
	    			tl+="<th colspan='"+v+"' class='cs-header'>"+k+"</th>"
	    			row+=v;
				});
	    		tl+="<th class='cs-header' rowspan='2' style='width:100px;'>小计</th>"
	    		$("#tl1").append(tl);
	    		$("#tl2").append(tl);
	    		$("#tl3").append(tl);
	    		var bigbang;
	    		$.each(data.obj.list, function(k, v) {
	    			//v.replace(/\d+$/,'')
	    			bigbang+="<th class='cs-header'>"+v.replace(/\d+$/,'')+"</th>"
				});
	    		$("#tr1").append(bigbang);
	    		$("#tr2").append(bigbang);
	    		$("#tr3").append(bigbang);
	    		var bigbang1;
	    		var sum1=0;
	    		$.each(data.obj.map, function(k, v) {
	    			sum1+=v.sum;
	    			bigbang1+="<tr class='num-tr'>";
	    			$.each(v, function(k, v1) {
	        			bigbang1+="<td><a title='"+v1+"'>"+v1+"</a></td>"
	    			});
	    			bigbang1+="</tr>";
				});
	    		bigbang1+='<tr><td colspan="'+row+'">合计</td><td>'+sum1+'</td></tr>';
	    		$("#table1 tbody").append(bigbang1);
	    		
	    		var bigbang2;
	    		var sum2=0;
	    		$.each(data.obj.map2, function(k, v) {
	    			sum2+=v.sum;
	    			bigbang2+="<tr class='num-tr'>";
	    			$.each(v, function(k, v1) {
	        			bigbang2+="<td>"+v1+"</td>"
	    			});
	    			bigbang2+="</tr>";
				});
	    		bigbang2+='<tr><td colspan="'+row+'">合计</td><td>'+sum2+'</td></tr>';
	    		$("#table2 tbody").append(bigbang2);
	    		
	    		var bigbang3;
	    		var sum3=0;
	    		$.each(data.obj.map3, function(k, v) {
	    			sum3+=v.sum;
	    			if(k<30){
	    				MarketName.push(v.reg_name);
	        			Unqualified.push(v.sum*100);
	    			}
	    			bigbang3+="<tr class='num-tr'>";
	    			$.each(v, function(k, v1) {
	        			bigbang3+="<td>"+v1+"</td>"
	    			});
	    			bigbang3+="</tr>";
				});
	    		bigbang3+='<tr><td colspan="'+row+'">合计</td><td>'+sum3.toFixed(2)+'</td></tr>';
	    		$("#table3 tbody").append(bigbang3);
	    		var item = [];
				var rate = [];
	    		$.each(data.obj.dataItems, function(k, v) {
	    			item.push(v.labelName);
					rate.push(v.unPercent*100);
				});
	    		loadData();
	    		setEcharts(0,item,rate,"品类阳性率（%）");
	    		
	    		var obj = $('.a .num-tr');
    		  	$(".a .num-tr").each(function(){
    				for(var i=0;i<obj.length;i++){
    					if($(this).children().eq(0).text().length>7){
    						var newText = $(this).children().eq(0).text().substring(0,7)+"…";
       						$(this).children().eq(0).text(newText);
    					}
    				}
    		 	}); 
    		  	
	    	 	for (var j = 0; j < $('.cs-tablesorter .num-tr').length; j++) {
	    	         if(j>=10){
	    	        	 $('#table1 .num-tr').eq(j).hide();
	    	        	 $('#table2 .num-tr').eq(j).hide();
	    	        	 $('#table3 .num-tr').eq(j).hide();
	    	         }
	    	     }
	    	},
	    	error:function(){
	    		$("#confirm-warnning").modal('toggle');
	    	}
	    	});
		 getData();
		 getDataCheck();
		 getTitle();
		 getData2();
		 
	}
});
//加载市场检测及不合格处理情况、总结报告第四段以及echarts图
function getData() {
	$.ajax({
				type : "POST",
				url: "${webRoot}/datastatistics/MarketData.do",
				contentType : false, //必须false才会避开jQuery对 formdata 的默认处理 XMLHttpRequest会对 formdata 进行正确的处理 
				processData : false, //必须false才会自动加上正确的Content-Type
				dataType : "json",
				success : function(data) {
					if (data && data.success) {
					var data=data.obj;
					var foodList=data.foodtypeList;//样品种类
					var result=data.result;//市场数据
					var list=data.list;//多个样品 检测项目数据
    						if(foodList){
    							var  foodTypehtml="";
    							var  checkTypehtml="";
    							var hejihtml="";
    							for (var i = 0; i < foodList.length; i++) {
    								if(foodList[i].labelName!='检测总数'){
    								foodTypehtml+='<th colspan="4" class="cs-header">'+foodList[i].labelName+'</th>';
    								checkTypehtml+='<th class="cs-header" >检测批次</th> <th class="cs-header">不合格</th>  <th class="cs-header">合格率</th> <th class="cs-header"> 处理数量</th>';
    								hejihtml+="<td> </td>";
    								}
    							}
    							$("#foodType").append(foodTypehtml);
    							$("#checkType").append(checkTypehtml);
    							$("#heji").append(hejihtml);
    						}
					
					var foodCount=foodList.length;
					try {
						if(result){
							var  resulthtml="";
							var  sss=(result.length/foodCount);
								for (var i = 0; i < result.length; i++) {
									var foodType=result[i].foodtype;
									var regId=result[i].regId;
									if(foodType==0){//快检总数
										resulthtml +='<tr class="num-tr">  <td>'+(i+1)+'</td>  <td>'+result[i].regName+'</td>  <td>'+result[i].checkCount+'</td> <td>'+result[i].unCount+'</td> <td>'+result[i].rate+'%</td>  <td>'+result[i].destroyCount+'</td>';
										for (var a = 1; a < foodList.length; a++) {
											for (var j = 0; j < result.length; j++) {
												if(regId==result[j].regId&&result[j].foodtype==a){
													resulthtml	+='<td>'+result[j].checkCount+'</td> <td>'+result[j].unCount+'</td> <td>'+result[j].rate+'%</td>  <td>'+result[j].destroyCount+'</td>';
													break;
												}
												if(j==result.length-1){
													resulthtml	+='<td>0 </td> <td> 0</td> <td>0.00%</td>  <td> 0.00</td>';
												}
													
											}
										
										}
											
										resulthtml+='</tr>';
									} 
								}
									$("#heji").html("");
									$("#foodData").prepend(resulthtml);
									for (var j = 0; j < $('.cs-tablesorter .num-tr').length; j++) {
						    	         if(j>=10){
						    	        	 $('#table4 .num-tr').eq(j).hide();
						    	         }	
						    	     }
									
									var obj2 = $('.b .num-tr');
								  	$(".b .num-tr").each(function(){
										for(var z=0;z<obj2.length;z++){
											if($(this).children().eq(1).text().length>7){
					    						var newText = $(this).children().eq(1).text().substring(0,7)+"…";
					       						$(this).children().eq(1).text(newText);
					    					}
										}
								 	}); 
						}
					} catch (e) {
						console.log(e);
					}
						//处理echarts柱状图
						try {
						if(list){
							var echartsHtml="";
							for (var i = 0; i < foodList.length; i++) {
								if(foodList[i].labelName!='检测总数'){
									echartsHtml="";
									echartsHtml+=' <div class="col-lg-6 col-md-6 clearfix" style="padding:0px 0px 30px 0px; border-right:1px solid #eee;" >'
								  +'<div id="progress'+(i+1)+'" style="height:380px;width:100%;"></div> </div>';
									$("#echarts").append(echartsHtml);
									  var item = [];
									  var rate = [];
									for (var a = 0; a < list.length; a++) {
											if(list[a].labelName==foodList[i].labelName){//标签相同
												item.push(list[a].itemName);
												rate.push(list[a].rate);
											}
									}
    								setEcharts(i+1,item,rate,foodList[i].labelName+"单项阳性率（%）");//生成报表
								}
							}
						}
						} catch (e) {
							console.log(e);
						}
						
						
						
						/* // 第一段全部数据 
						var reg=data.reg;
						if(reg){
						var reghtml='<i >'+reg.regCount+'</i>家市场的食用农产品，进行食品安全抽样检测，总共完成检测批次<i>'+reg.checkCount+'</i>个，合格率为<i>'+reg.rate+'%</i>，其中，阳性样品<i>'+reg.unCount+'</i>批次，阳性率为<i>'+reg.unrate+'%</i>，共销毁不合格食用农产品<i>'+reg.destroyCount+'</i>公斤。';
						$(part1).append(reghtml);
						}else{
							var reghtml='市场的食用农产品，进行食品安全抽样检测。 ';
							$(part1).append(reghtml);
						}
						//第二段 各个市场 数据
						var regList=data.regList;
							var len=regList.length;
						if(len>0){
							var regListhtml="";
							if(len>=6){
							 regListhtml +='抽检的<i>'+len+'</i>家市场，合格率最高的市场为:<i>'+regList[0].regName+'（'+regList[0].rate+'%），'+regList[1].regName+'（'+regList[1].rate+'%），'+regList[2].regName+'（'+regList[2].rate+'%）</i>；合格率最低的市场为:<i>'+regList[0].regName+'（'+regList[len-3].rate+'%），'+regList[len-3].regName+'（'+regList[len-2].rate+'%），'+regList[len-1].regName+'（'+regList[len-1].rate+'%）。';
							}else {
								 regListhtml +='抽检的<i>'+len+'</i>家市场，合格率从高到低分别是:';
								for (var i = 0; i < regList.length; i++) {
									if(i==regList.length-1){
										regListhtml +=' <i>'+regList[0].regName+'（'+regList[0].rate+'%） ';
									}else{
								 regListhtml +=' <i>'+regList[0].regName+'（'+regList[0].rate+'%）， ';
								 
									}
								}
								 regListhtml +=' 。 ';
							}
							$(part2).append(regListhtml);
							
						}
						
						//第三段 标签检测数据
						var labelNameList=data.labelNameList;
						if(labelNameList.length>0){
							var labelhtml='检测覆盖食用农产品<i>';
							var demo1Html='';
					 	for (var i = 0; i < labelNameList.length; i++) {
								if(i==0){
								labelhtml+=labelNameList[i].labelName;
								demo1Html+='<i>'+labelNameList[i].labelName+'</i>检测<i>'+labelNameList[i].checkCount+'</i>批次，合格率为<i>'+labelNameList[i].rate+'%</i>,';
									if(labelNameList[i].rate>50.00&&labelNameList[i].rate==100.00){//这里将合格率超过50%的
										demo1Html+='<i>合格率最高/未发现阳性品</i>；';
									}else if(labelNameList[i].rate>50.00&&labelNameList[i].rate!=100.00){
										demo1Html+='<i>合格率最高/有发现阳性品</i>；';
									}
								}else{
									labelhtml+='、'+labelNameList[i].labelName;
									demo1Html+='<i>'+labelNameList[i].labelName+'</i>检测<i>'+labelNameList[i].checkCount+'</i>批次，合格率为<i>'+labelNameList[i].rate+'%</i>；';
								}
							} 
							
						 labelhtml +='</i>，其中，'+demo1Html+'。';
							$(part3).append(labelhtml);
						} 
						
						if(list.length>0){
							var listhtml='从检测项目上来看， ';
							var len=list.length;
							if(len>5){
								len=5;
							}
							for (var i = 0; i < len; i++) {
								listhtml+='	<i>'+list[i].itemName+'</i>阳性率达到<i>'+list[i].unrate+'%，</i>';
							}
							listhtml+="。";
							$(part4).append(listhtml);
						}
						//第五段
						var foodList=data.foodList;//多个样品 检测项目数据
						if(foodList.length>0){
							var len=foodList.length;
							if(len>5){
								len=5;
							}
							var foodListhtml='从样品上来看，发现食用农产品问题最多的有： ';
								for (var i = 0; i < len; i++) {
									foodListhtml+='<i>'+foodList[i].foodName+'</i>阳性率达到<i>'+foodList[i].unrate+'%</i>，';
								}
									foodListhtml+='可作为下一阶段抽样检测重点。';
							$(part5).append(foodListhtml);
						} */
					}
				}
		});
}
//加载不合格阳性样品信息表
function getDataCheck() {
	$.ajax({
		type : "POST",
		url: "${webRoot}/datastatistics/getDataCheck.do",
		contentType : false, //必须false才会避开jQuery对 formdata 的默认处理 XMLHttpRequest会对 formdata 进行正确的处理 
		processData : false, //必须false才会自动加上正确的Content-Type
		dataType : "json",
		success : function(data) {
			if (data && data.success) {
			try {
				var data=data.obj;
				var list1=data.list1;//阳性检测数据-只统计销毁的
				if(list1){
					var dataListhtml="";
					var destroy=0;
					for (var i = 0; i < list1.length; i++) {
						dataListhtml+='<tr class="num-tr"> <td>'+(i+1)+'</td><td>'+list1[i].regName+'</td> <td>'+list1[i].foodName+'</td> <td>'+list1[i].foodTypeName+'</td>'
	                 	 +'<td>'+list1[i].opeShopName+'</td> <td>'+list1[i].opeName+'</td> <td>'+list1[i].itemName+'</td> <td>销毁</td> <td>'+list1[i].destroyCount+'</td> <td>'+newDate(list1[i].checkDate).format("yyyy-MM-dd")+'</td> </tr>	';
						destroy=destroy*1+list1[i].destroyCount*1;
					}
					dataListhtml+='<tr> <td colspan="8">合计</td> <td>'+destroy.toFixed(2)+'</td> <td> </td> </tr>	';
                  $("#dataList").html(dataListhtml);
                  for (var j = 0; j < $('.cs-tablesorter .num-tr').length; j++) {
		    	         if(j>=10){
		    	        	 $('#table5 .num-tr').eq(j).hide();
		    	         }
		    	  }
                  var obj2 = $('.b .num-tr');
				  	$(".b .num-tr").each(function(){
						for(var z=0;z<obj2.length;z++){
							if($(this).children().eq(1).text().length>7){
	    						var newText = $(this).children().eq(1).text().substring(0,7)+"…";
	       						$(this).children().eq(1).text(newText);
	    					}
						}
				 	});
				}
				} catch (e) {
					console.log(e);
				}
			}
		}
});
}
//加载总结报告第一段到第四段的数据
function getTitle() {
	$.ajax({
		type : "POST",
		url: "${webRoot}/datastatistics/getByStatisticsId2.do",
		contentType : false, //必须false才会避开jQuery对 formdata 的默认处理 XMLHttpRequest会对 formdata 进行正确的处理 
		processData : false, //必须false才会自动加上正确的Content-Type
		dataType : "json",
		success : function(data) {
			if (data && data.success) {
			var data=data.obj;
			// 第一段全部数据 
			var reg=data.reg;
			if(reg){
			var reghtml='<i >'+reg.regCount+'</i>家市场的食用农产品，进行食品安全抽样检测，总共完成检测批次<i>'+reg.checkCount+'</i>个，合格率为<i>'+reg.rate+'%</i>，其中，阳性样品<i>'+reg.unCount+'</i>批次，阳性率为<i>'+reg.unrate+'%</i>，共销毁不合格食用农产品<i>'+reg.destroyCount+'</i>公斤。';
			$(part1).append(reghtml);
			}else{
				var reghtml='市场的食用农产品，进行食品安全抽样检测。 ';
				$(part1).append(reghtml);
			}
			//第二段 各个市场 数据
			var regList=data.regList;
				var len=regList.length;
			if(len>0){
				var regListhtml="";
				if(len>=6){
				 regListhtml +='抽检的<i>'+len+'</i>家市场，合格率最高的市场为:<i>'+regList[0].regName+'（'+regList[0].rate+'%），'+regList[1].regName+'（'+regList[1].rate+'%），'+regList[2].regName+'（'+regList[2].rate+'%）</i>；合格率最低的市场为:<i>'+regList[len-3].regName+'（'+regList[len-3].rate+'%），'+regList[len-2].regName+'（'+regList[len-2].rate+'%），'+regList[len-1].regName+'（'+regList[len-1].rate+'%）。';
				}else {
					 regListhtml +='抽检的<i>'+len+'</i>家市场，合格率从高到低分别是:';
					for (var i = 0; i < regList.length; i++) {
						if(i==regList.length-1){
							regListhtml +=' <i>'+regList[i].regName+'（'+regList[i].rate+'%） ';
						}else{
					 regListhtml +=' <i>'+regList[i].regName+'（'+regList[i].rate+'%）， ';
					 
						}
					}
					 regListhtml +=' 。 ';
				}
				$(part2).append(regListhtml);
				
			}
			//第三段 标签检测数据
			var labelNameList=data.labelNameList;
			if(labelNameList.length>0){
				var labelhtml='检测覆盖食用农产品<i>';
				var demo1Html='';
			 	for (var i = 0; i < labelNameList.length; i++) {
						if(i==0){
						labelhtml+=labelNameList[i].labelName;
						demo1Html+='<i>'+labelNameList[i].labelName+'</i>检测<i>'+labelNameList[i].checkCount+'</i>批次，合格率为<i>'+labelNameList[i].rate+'%</i>,';
							if(labelNameList[i].rate>50.00&&labelNameList[i].rate==100.00){//这里将合格率超过50%的
								demo1Html+='<i>合格率最高,未发现阳性品</i>；';
							}else if(labelNameList[i].rate>50.00&&labelNameList[i].rate!=100.00){
								demo1Html+='<i>合格率最高</i>；';
							}
						}else if (i==(labelNameList.length-1)) {
							labelhtml+='、'+labelNameList[i].labelName;
							demo1Html+='<i>'+labelNameList[i].labelName+'</i>检测<i>'+labelNameList[i].checkCount+'</i>批次，合格率为<i>'+labelNameList[i].rate+'%</i>';
						}else{
							labelhtml+='、'+labelNameList[i].labelName;
							demo1Html+='<i>'+labelNameList[i].labelName+'</i>检测<i>'+labelNameList[i].checkCount+'</i>批次，合格率为<i>'+labelNameList[i].rate+'%</i>；';
						}
					} 
					
				 labelhtml +='</i>，其中，'+demo1Html+'。';
				 $(part3).append(labelhtml);
			} 
			//第四段 
			var list=data.list;//多个样品 检测项目数据
			if(list.length>0){
				var listhtml='从检测项目上来看， ';
				var len=list.length;
				if(len>5){
					len=5;
				}
				for (var i = 0; i < len; i++) {
					if(i==len-1){//最后一个无标点符号
						listhtml+='	<i>'+list[i].itemName+'</i>阳性率达到<i>'+list[i].unrate+'%</i>';
					}else{
						listhtml+='	<i>'+list[i].itemName+'</i>阳性率达到<i>'+list[i].unrate+'%，</i>';
					}
				}
				listhtml+="。";
				$(part4).append(listhtml);
			}
			
			}
		}
});
}
//加载总结报告第五段
function getData2() {
	$.ajax({
		type : "POST",
		  url: "${webRoot}/datastatistics/getTitleByStatisticsId.do",
		data : "",
		contentType : false, //必须false才会避开jQuery对 formdata 的默认处理 XMLHttpRequest会对 formdata 进行正确的处理 
		processData : false, //必须false才会自动加上正确的Content-Type
		dataType : "json",
		success : function(data) {
			if (data && data.success) {
				var data=data.obj;
				//第五段
				var foodList=data.foodList;//多个样品 检测项目数据
				if(foodList.length>0){
					var len=foodList.length;
					if(len>5){
						len=5;
					}
					var foodListhtml='从样品上来看，发现食用农产品问题最多的有： ';
						for (var i = 0; i < len; i++) {
							if(foodList[i].unrate!=0.00){
							foodListhtml+='<i>'+foodList[i].foodName+'</i>阳性率达到<i>'+foodList[i].unrate+'%</i>，';
							}
						}
							foodListhtml+='可作为下一阶段抽样检测重点。';
					$(part5).append(foodListhtml);
				}
			}
		}
});
}

var xx = []; 

function loadData() {
	var myChart1 = echarts.init(document.getElementById('progress7'),"shine");

	option = {
	  title : {
	        text: '市场阳性率（%）',
	        x:'center',
	        textStyle: {
	        fontSize: 15,
	        padding: 0,                // 标题内边距，单位px，默认各方向内边距为5， 
	        paddingLeft:10,
	        itemGap: 0,               //主副标题纵向间隔，单位px，默认为10，
	        fontWeight: 'bolder',
	        color: '#333'          // 主标题文字颜色
	    }
	    },
	    tooltip : {
	        trigger: 'axis',
	        axisPointer : {            // 坐标轴指示器，坐标轴触发有效
	            type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
	        }
	    },
	    grid: {
	        left: '5%',
	        right: '3%',
	        bottom: '20%',
	        top:'12%',
	        containLabel: true
	    },
	    xAxis : [
	        {
	            type : 'category',
	            
	            data : MarketName,
	            axisLabel: {
	                show:true,
	                interval: 0, //强制所有标签显示
	                align:'right',
	                rotate:20,
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
	    yAxis : [
	        {
	            type : 'value',
	            axisLabel: {
	                     
	                      show: true, 
	                      
	                  }
	        }
	    ],
	    series : [
	        {
	            name:'阳性率',
	            type:'bar',
	            stack: '阳性率',
	            data:Unqualified
	        }

	        
	       
	    ],
	    itemStyle: {
	                    normal: {
	                            shadowBlur: 5,
	                            shadowOffsetX: 0,
	                            shadowOffsetY: -1,
	                            shadowColor: 'rgba(0, 0, 0, 0.4)'
	                        },
	                            emphasis: {
	                                shadowBlur: 10,
	                                shadowOffsetX: 0,
	                                shadowColor: 'rgba(0, 0, 0, 0.5)'
	                            }
	                        }
		};
	// 使用刚指定的配置项和数据显示图表。
       myChart1.setOption(option);
	
       xx[0] = myChart1;
}

//创建图表方法

function setEcharts(i,item,rate,labelName) {
	var myChart2 = echarts.init(document.getElementById( 'progress'+i),"shine");
option = {
  title : {
        text: labelName,
        x:'center',
        textStyle: {
        fontSize: 15,
        padding: 10,                // 标题内边距，单位px，默认各方向内边距为5，       
        itemGap: 0,               //主副标题纵向间隔，单位px，默认为10，
        fontWeight: 'bolder',
        color: '#333'          // 主标题文字颜色
    }
    },
    tooltip : {
        trigger: 'axis',
        axisPointer : {            // 坐标轴指示器，坐标轴触发有效
            type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
        }
    },
    legend: {
        orient: 'horizontal',
        left: 'center',
        data: ['合格','不合格']
    },
    grid: {
        left: '3%',
        right: '8%',
        bottom: '10%',
        top:'12%',
        containLabel: true
    },
    xAxis : [
        {
            type : 'category',
            data : item,
            splitLine: {
                              show: true
                          },
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
    ],
    yAxis : [
        {
            type : 'value',
            axisLabel: {
                     formatter:'{value}(%)',
                      show: true, 
                      
                  }
        }
    ],
    series : [
        {
            name:'平均阳性率',
            type:'bar',
            stack: '阳性率',
            data:rate
        }

        
       
    ],
    itemStyle: {
                    normal: {
                            shadowBlur: 5,
                            shadowOffsetX: 0,
                            shadowOffsetY: -1,
                            shadowColor: 'rgba(0, 0, 0, 0.4)'
                        },
                            emphasis: {
                                shadowBlur: 10,
                                shadowOffsetX: 0,
                                shadowColor: 'rgba(0, 0, 0, 0.5)'
                            }
                        }
};
//使用刚指定的配置项和数据显示图表。
myChart2.setOption(option);

var xxnum = xx.length + 1;
xx[xxnum] = myChart2;
    }

    $(document).ready(function() {
      
        $(document).on('click','.cs-show-alls',function(){
                
            if($(this).children('i').hasClass('icon-shang')){
                for (var i = 0; i < $(this).siblings('.cs-tablesorter').find('.num-tr').length; i++) {
                if(i>=10){
                    $(this).siblings('.cs-tablesorter').find('.num-tr').eq(i).hide();
                }
            }
                $(this).html('<i class="icon iconfont icon-xia"></i>');
            }else if($(this).children('i').hasClass('icon-xia')){
                $(this).siblings('.cs-tablesorter').find('.num-tr').show();
                $(this).html('<i class="icon iconfont icon-shang"></i>');
            }
        })
    });
    
    function outPic() {
    	var picBase64Info = [];
    	var id=getQueryString("id");
        for (var i = 0; i < xx.length; i++) {
			if(xx[i]){
				picBase64Info.push(xx[i].getDataURL());
				//console.log(data);
				//data.picBase64Info1=xx[i].getDataURL();
			}
		}
        //self.location = '${webRoot}/datastatistics/exportReport.do?id='+id+'&picBase64Info='+data;
        /* $.ajax({
    		type : "POST",
    		url: "${webRoot}/datastatistics/exportReport.do",
    		data :{"picBase64Info":data,"id":id},
    		dataType : "json",
    		traditional: true,//防止深度序列化
    		success : function(data) {
    			console.log(data); 
    		}
    	}); */
        
        var queryForm = $("#queryTaizhangForm");
        var exportForm = $("<form action='${webRoot}/datastatistics/exportReport.do' method='post'></form>")     
        
        exportForm.append("<input type='hidden' name='id' value='"+id+"'/>")
        exportForm.append("<input type='hidden' name='picBase64Info' value='"+picBase64Info+"'/>")
        $(document.body).append(exportForm);
        exportForm.serialize();
        exportForm.submit();
        exportForm.remove();
	}
    
    function getQueryString(name) { 
    	var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i"); 
    	var r = window.location.search.substr(1).match(reg); 
    	if (r != null) return unescape(r[2]); return null; 
    } 
</script>
</body>
</html>