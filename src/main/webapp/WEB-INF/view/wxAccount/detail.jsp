<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/common/resource.jsp"%>
<%@page import="java.util.Date"%>
<html>
  <head>
    <title>快检服务云平台</title>
    <style type="text/css">
    	.Validform_checktip{
		display:none;
		}
		.check-date{
    		float:left;
    		margin-left:4px;
    	}
    	.check-date select{
    		margin-left:4px;
    	}
    </style>
    </head>
  <body>
          <div class="cs-col-lg clearfix">
          <!-- 面包屑导航栏  开始-->
          <ol class="cs-breadcrumb">
              <li class="cs-fl">
              <img src="${webRoot}/img/set.png" alt="" />
              <a href="javascript:">账号管理</a></li>
              <li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
              <li class="cs-b-active cs-fl">${wx.accountName }
              </li>
            </ol>
          <!-- 面包屑导航栏  结束-->
          <ul class="cs-f-b pull-left clearfix" style="height:40px; margin-left:20px; display:inline-block;">

              
                <li class="col-lg-12 col-md-12 cs-al" style="padding-right:0; line-height:40px; ; border-bottom:1px solid #ddd;">
                  
                  <%-- <span class="cs-name" style="padding-left:10px; padding-right:0;">公众号名称：</span>
                  ${wx.accountName } --%>
                  <span class="cs-name" style="padding-left:30px; padding-right:0;">用户总数：</span> 
                  <span id="count">   ${wx.count }</span>   
                  </li>
              </ul>
              
              
               <!-- 顶部筛选 -->
          <div class="cs-input-style cs-fl" style="margin:3px 0 0 15px; width:470px;">
              <div class="" >
				<input type="hidden" name="year" id="years"/>
				<select id="province" name="province" class="cs-selcet-style pull-left" style="width: 98px;"> 
					<option value="month">月报表</option> 
					
					<option value="season">季报表</option> 
					
					<option value="year">年报表</option> 
					
					<option value="diy">自定义</option>
				</select> 
				<div class="check-date cs-hide">
				<select class="cs-selcet-style"  style="width: 98px;"></select>
				</div>
				<div class="check-date">
				<select class=" cs-selcet-style pull-left" id="year1" style="width: 98px;"> 
			        <option value="">--请选择--</option>
			        <option value="2017">2017年</option> 
			
			        <option value="2018">2018年</option> 
			
			        <option value="2019">2019年</option> 
			        
			        <option value="2020">2020年</option> 
			        
			        <option value="2021">2021年</option> 
		        </select>
				<select class="cs-selcet-style pull-left" name="month" id="month" style="width: 98px;"> 
					<option value="">--请选择--</option>
					<option value="01">1月</option> 
					
					<option value="02">2月</option> 
					
					<option value="03">3月</option> 
					
					<option value="04">4月</option> 
					
					<option value="05">5月</option> 
					
					<option value="06">6月</option> 
					
					<option value="07">7月</option> 
					
					<option value="08">8月</option> 
					
					<option value="09">9月</option> 
					
					<option value="10">10月</option> 
					
					<option value="11">11月</option> 
					
					<option value="12">12月</option> 
				</select>  
				</div>
				<div class="check-date cs-hide">
				<select class=" cs-selcet-style pull-left" id="year2" style="width: 98px;"> 
			        <option value="">--请选择--</option>
			        <option value="2017">2017年</option> 
			
			        <option value="2018">2018年</option> 
			
			        <option value="2019">2019年</option> 
			         <option value="2020">2020年</option> 
			        <option value="2021">2021年</option> 
		        </select>
				<select class="cs-selcet-style pull-left" name="season" id="season" style="width: 98px;"> 
					<option value="">--请选择--</option>
					<option value="1">第一季度</option> 
					
					<option value="2">第二季度</option> 
					
					<option value="3">第三季度</option> 
					
					<option value="4">第四季度</option> 
				</select> 
				</div>
				<div class="check-date cs-hide">
				<select class="cs-selcet-style" id="year" style="width: 98px;"> 
					<option value="">--请选择--</option>
					<option value="2017">2017年</option> 
					
					<option value="2018">2018年</option> 
					
					<option value="2019">2019年</option> 
				</select> 
				</div>
			</div>  
            <span class="check-date cs-hide clearfix">
               
	                <span class="cs-time-se pull-left">
	                	<input name="task.taskSdate" id="start" style="width: 110px;" class="cs-time Validform_error pull-left" type="text" onclick="WdatePicker()" datatype="date" nullmsg="请选择任务起止时间" errormsg="请选择任务起止时间" value="">
	                	<span class="pull-left" style="padding:5px 5px 0 5px; ">
	                                      	至</span>
	                    <input name="task.taskSdate" id="end" style="width: 110px;" class="cs-time Validform_error pull-left" type="text" onclick="WdatePicker()" datatype="date" nullmsg="请选择任务起止时间" errormsg="请选择任务起止时间" value="">
	                </span>
	                <span class="pull-left">
		            	<a href="javascript:" class="cs-menu-btn" style="margin:0 0 0 10px;" onclick="getData();"><i class="icon iconfont icon-chakan"></i>查询</a>
		            </span>
                </span>
          </div>
          
          
          
          
            <div class="cs-search-box cs-fr">
              <form action="datagrid.do">
                <%-- <div class="cs-search-filter clearfix cs-fl" >
                <span class="check-date cs-fl" style="display: inline;"> 
				  <span class="cs-name">时间:</span>
	                <span class="cs-in-style cs-time-se cs-time-se">
	                	<input autocomplete="off" name="dateStart" style="width: 110px;" class="cs-time Validform_error focusInput " id="start"  onclick="WdatePicker({maxDate:'#F{$dp.$D(\'end\')}'})" datatype="date"  value="${start }">
	                	<span style="padding:0 5px;">
	                                      至</span>
	                    <input autocomplete="off" name="dateEnd" style="width: 110px;" class="cs-time Validform_error  focusInput" id="end"  onclick="WdatePicker({maxDate:'%y-%M-%d',minDate:'#F{$dp.$D(\'start\')}'})" datatype="date" value="${end}">
	                </span>
                </div> --%>
                <input class="cs-input-cont cs-fl focusInput" type="text" name="search" id="search" placeholder="请输入手机号搜索" />
                <input type="button" onclick="getData();" class="cs-search-btn cs-fl" href="javascript:;" value="搜索">
                </span>
           		 <div class="clearfix cs-fr" id="showBtn">
           		 <a class="cs-menu-btn" href="javascript:" onclick="self.history.back();"><i class="icon iconfont icon-fanhui"></i>返回</a>
	             </div>
              </form>
              
            </div>
          </div>
			<div class="cs-schedule-mao col-lg-12 col-md-12 clearfix">
                  
                  
                  <div class="col-lg-12 col-md-12 clearfix" style="padding:10px 5px 5px 5px; border-right:1px solid #eee;" >
                 <div id="progress5" style="height:230px;width:100%;"></div>
                 
                  </div>
                </div>
	<div id="dataList"></div>

     <%@include file="/WEB-INF/view/common/confirm.jsp"%>
     <%@ include file="/WEB-INF/view/common/exportDialog.jsp" %>
    <script src="${webRoot}/js/select/tabcomplete.min.js"></script>
    <script src="${webRoot}/js/select/livefilter.min.js"></script>
    <script src="${webRoot}/js/select/bootstrap-select.js"></script>
   <script src="${webRoot}/js/datagridUtil.js"></script>
    <script type="text/javascript">
    	 rootPath="${webRoot}/wx/";
    	var 	start='${start}';
		var	end='${end}';
    	 var wx=0;
    	 var  wxObj=0;
    	 var exports=0;
    	 var  exportObj;
    	 var getInfoObj=function(){
   	      return  $(this).parents("li").next().find(".info");
   	    }
 		for (var i = 0; i < childBtnMenu.length; i++) {
 		 if (childBtnMenu[i].operationCode == "1401-2") {
 				edit = 1;
 				editObj=childBtnMenu[i];
 			}else if (childBtnMenu[i].operationCode == "1401-3") {
 				deletes = 1;
 				deleteObj=childBtnMenu[i];
 			}else if (childBtnMenu[i].operationCode == "1401-4") {//微信解绑权限
 				wx = 1;
 				wxObj=childBtnMenu[i];
 			} else if (childBtnMenu[i].operationCode == "1401-5") {//导出
 				exports = 1;
 				exportObj=childBtnMenu[i];
 			}
 		
 		} 
   	  $("[datatype]").focusin(function(){
   	    if(this.timeout){clearTimeout(this.timeout);}
   	    var infoObj=getInfoObj.call(this);
   	    if(infoObj.siblings(".Validform_right").length!=0){
   	      return; 
   	    }
   	    infoObj.show().siblings().hide();
   	    
   	  }).focusout(function(){
   	    var infoObj=getInfoObj.call(this);
   	    this.timeout=setTimeout(function(){
   	      infoObj.hide().siblings(".Validform_wrong,.Validform_loading").show();
   	    },0);
   	    
   	  });
   	  
		var dateStart="";
		var dateEnd="";
   	  //初始化加载
   	  
   	  $(function() {
   		getData();
	});
   	  
 
   	  
   	  //点击事件
   	    document.querySelector('#month').onchange = function(){
   	    	setTime();
   	 }
   	    document.querySelector('#season').onchange = function(){
   	    	setTime();
   	 }
   	    document.querySelector('#year').onchange = function(){
   	    	setTime();
   	 }
   	    document.querySelector('#year1').onchange = function(){
   	    	setTime();
   	 }
   	    document.querySelector('#year2').onchange = function(){
   	    	setTime();
   	    	
   	 }
   	  
   	  function setTime() {
   		 dateStart="";
		 dateEnd="";
		var type=$("#province").val();
		//console.log(type);
		if(type=="month"){
			var year1=$("#year1").val();
			var month=$("#month").val();
			if(year1==null||year1==""||month==""){
				return;
			}
			dateStart=year1+"-"+month+"-01";
			dateEnd=year1+"-"+month+"-31";
			getData();
		}else if(type=="season"){
			var year2=$("#year2").val();
			var season=$("#season").val();
			if(year2==""||season==""){
				return;
			}
			if(season==1){
				dateStart=year2+"-01-01";
				dateEnd=year2+"-03-31";
			}else if(season==2){
				dateStart=year2+"-04-01";
				dateEnd=year2+"-06-31";
			}else if(season==3){
				dateStart=year2+"-07-01";
				dateEnd=year2+"-09-31";
			}else if(season==4){
				dateStart=year2+"-10-01";
				dateEnd=year2+"-12-31";
			}
			getData();
		}else if(type=="year"){
			var year=$("#year").val();
			if(year==""){
				return;
			}
			dateStart=year+"-01-01";
			dateEnd=year+"-12-31";
			getData();
		}else if(type=="diy"){
			var start=$("#start").val();
			var end=$("#end").val();
			if(start==""&&end==""){
				return;
			}
			dateStart=start;
			dateEnd=end;
			getData();
		}

   	  } 
   	  
   	  function getData() {
   		  var search=$("#search").val();
   		  if(search!=""){//有查询需要清除时间限制
   			 dateStart="";
   			 dateEnd="";
   		  }
	var op = {
		tableId: "dataList",	//列表ID
		tableAction: '${webRoot}'+"/wx/inspectionUser/datagrid.do?appId="+'${wx.accountAppid}'+'&dateStart='+dateStart+'&dateEnd='+dateEnd+'&search='+search,	//加载数据地址
		parameter: [		//列表拼接参数
				{
					columnCode: "userName",
					columnName: "机构名称",
					customVal:{"default":'${wx.departName}'} 
				},
				{
					columnCode: "nickName",
					columnName: "公众号名称",
					customVal:{"default":'${wx.accountName}'} 
				},
				{
					columnCode: "mobilePhone",
					columnName: "手机号码",
					query: 1
				},
				{
					columnCode: "nickName",
					columnName: "用户昵称",
					query: 1
				},
				/* {
					columnCode: "wxstatus",
					columnName: "微信绑定权限",
					customVal:{"1":"<span class='text-success'>有</span>","0":"<span class='text-danger'>无</span>","default":"<span class='text-danger'>无</span>" }
				}, */
				{
					columnCode: "bindTime",
					columnName: "绑定时间",
					
				}, 
				{
					columnCode: "relieveTime",
					columnName: "解绑时间",
				},
				{
					columnCode: "openid",
					columnName: "状态",
					customVal:{"is-null":"<span class='text-danger'>未绑定</span>","non-null":"<span class='text-success'>已绑定</span>"}
				},
			
			
		],
	
			
		/* funBtns: [
	     	{
	    		show: edit,
	    		style: editObj,
	    		action: function(id){
	    			getId(id);
	    		}
	    	}, 
	    	{
	    		show: deletes,
	    		style: deleteObj,
	    		action: function(id){
	    			idsStr="{\"ids\":\""+id.toString()+"\"}";
	    			$("#confirm-delete").modal('toggle');
	    		}
	    	},
	    	{
	    		show: wx,
	    		style:wxObj,
	    		action: function(id){
	    			$("#id").val(id);
	    			$("#confirm-delete3").modal('toggle');
	    		}
	    	}
	    ],	 *///功能按钮 
		rowTotal: 0,	//记录总数
		pageSize: pageSize,	//每页数量
		pageNo: 1,	//当前页序号
		pageCount: 1,	// 总页数
	/* 	bottomBtns: [
			 {	//删除函数	
		    		show: deletes, 
		    		style: deleteObj,
		    		action: function(ids){
		    			idsStr="{\"ids\":\""+ids.toString()+"\"}";
		    			$("#confirm-delete").modal('toggle');
		    		}
		    },
			 {	//导出函数
					show: exports, 
					style: exportObj,
		    		action: function(ids){
		    			 $("#exportModal").modal('toggle');
		    		}
		    }
		], */
		 onload: function(){
			 getByAppid();
				/*  console.log(datagridOption);
				 for (var i = 0; i < datagridOption.obj.length; i++) {
						alert(datagridOption.obj[i].managementType);
					if(datagridOption.obj[i].managementType==1){
					
					}
					 
				} */
				/*  var obj = datagridOption.rowTotal;
				$("#count").text(obj); */
				/*$(".rowTr").each(function(){
			    	for(var i=0;i<obj.length;i++){
				    		if($(this).attr("data-rowId") == obj[i].id){
				    			if(obj[i].openid==null||obj[i].openid==""){
					    			//隐藏编辑按钮
					    			$(this).find(".1401-4").css('visibility','hidden');
					    		}
				    		}
			    		}
		    	}); */
		 }
	};
	datagridUtil.initOption(op);
	
    datagridUtil.query();
  	} 
    
    /**
     * 查询用户信息
     */
    function getId(e){
    	var id=e;
    	$.ajax({
    	url:"${webRoot}/wx/queryByUserId.do",
    	type:"POST",
    	data:{"id":id},
    	dataType:"json",
    	success:function(data){
    		  $(".info").hide();
    		  $("#wxuserId").val(e);
    		  var user=data.obj;
    		  if(user!=null&&user!=""){
    			  var status=user.status;
    			  if(status==1){
    				  $("input[name='status'][value='1']").prop('checked', true);
    			  }else{
    				  $("input[name='status'][value='0']").prop('checked', true);
    			  }
    				document.getElementById('type').value=user.type;
    				if(user.userId){//2018-7-24 将一对一改为一对多账号绑定
    					//$("#userId").append('<option selected="selected"  value="'+user.userId+'">'+user.realname+'</option>');
    				 document.getElementById("userId").value=user.userId;
    				}
    			 	 $("#userName").val(user.userName);
    			 	 $("#id").val(user.id);
    			 	 $("#phone").val(user.phone);
    			 	 $("#nickName").val(user.nickName);
    			 	 $("#password").val(user.password);
    			 	 $("#password2").val(user.password);
    			 	 $("#oldPwd").val(user.password);
    				 $("#myModal").modal("show");
    		  }else{
    			  $("input[name='status'][value='0']").prop('checked', true);
    		  }
		},
    	error:function(){
    		alert("操作失败");
    	}
    	});
    }
    
    $("#tt").tree({
		checkbox:false,
		//url:"${webRoot}/detect/depart/getDepartTree.do?pid=${org.departPid}",
		url:"${webRoot}/detect/depart/getDepartTree.do",
		animate:true,
		lines:false,
		onClick : function(node){      
			$(".sPointId").val(node.id);
			$(".sPointName").val(node.text);
			datagridOption['pageNo']=1;
			datagridUtil.query();
			$(".cs-check-down").hide();
			setTimeout(function() {
    			queryPoint(node.id);
    			queryReg(node.id);
			}, 100);
		}
	}); 
    
    
	function delwx() {
		var id = $("#id").val();
		if (id == null || id	 == "") {
			alertMsg("解除失败","false");
			return;
		}

		$.ajax({
			type : "POST",
			url : '${webRoot}' + "/wx/deleteOpenid.do",
			data : {
				id : id,
			},
			dataType : "json",
			success : function(data) {
				if (data.success) {
					alertMsg("解除成功！","true");
					self.location.reload();
				} else {
					alertMsg("解除失败","false");
				}
			
			}
		})
	}
	
	
	
    //绑定回车事件
    //document.onkeydown=keyDownSearch;
    </script>
    <script type="text/javascript">
	//选择行政区
	$('#tree').tree({
		checkbox : false,
		url : "${webRoot}/detect/depart/getDepartTree.do",
		animate : true,
		onLoadSuccess: function (node, data) {
			if (data.length > 0) {
		    	$("input[name='departNames']").val(data[0].text);
			}
		}, 
		onClick : function(node) {
			var did = node.id;
			$("input[name='departNames']").val(node.text);
			$(".cs-check-down").hide();
			$("input[name='departids']").val(did);
			
			datagridUtil.addDefaultCondition("departId", did);
			datagridUtil.query();
		}
	});
		
		
    </script>
    <script type="text/javascript">
   //获取图表数据 
    function getByAppid(){
    	$.ajax({
			type : "POST",
			url : '${webRoot}' + "/wx/account/queryByAppid.do?appId="+'${wx.accountAppid}',
			dataType : "json",
			success : function(data) {
				if (data && data.success) {
					//test(data.obj);
					/* var days =  ['10-01','10-02','10-03','10-04','10-05','10-06','10-07','10-08','10-09','10-10','10-11','10-06','10-07','10-08','10-09','10-10','10-11'];
					var qualified = [20,  10, 31,12, 33, 14, 35, 17, 38, 19, 5,10, 54,99,0,1,88]; */
					var obj=data.obj;
					var days =  [];
					var num = [];
					for (var i = 0; i < obj.length; i++) {
						days[i]=obj[i].days;
							num[i]=obj[i].count;
					}
					test(days,num);
				} else {
					console.log("查询失败");
				}
			}
		});
	}

function test(days,num) {
	
/* 	var quantity = data.obj.quantity;
	for (var i = 0; i < quantity.length; i++) {
		days[i] = quantity[i].days;
		qualified[i] = quantity[i].qualified;
		unqualified[i] = quantity[i].unqualified;
	} */
    var myChart = echarts.init(document.getElementById('progress5'),"shine");
option = {
    title: {
        text: '绑定用户数量趋势',
        // subtext: '总收款：300万元',
        x:'center',
        textStyle: {
        fontSize: 14,
        padding: 10,                // 标题内边距，单位px，默认各方向内边距为5，       
        itemGap: 0,               //主副标题纵向间隔，单位px，默认为10，
        fontWeight: 'bolder',
        color: '#333'          // 主标题文字颜色
    }
    },
    tooltip: {
        trigger: 'axis'
    },
    legend: {
        orient: 'horizontal',
        left: 'right',
        data: []
    },
    grid: {
        left: '3%',
        right: '4%',
        bottom: '10%',
        top:'18%',
        containLabel: true
    },
    xAxis: {
        type: 'category',
        boundaryGap: false,
        data:days,
        splitLine: {
                              show: true
                          },
        axisLabel: {
                     interval: 0, 
                      rotate: -20, 
                      show: true, 
                      splitNumber: 15, 
                      textStyle: {
                          fontSize: 12
                      }
                  }
    },
    yAxis: {
        type: 'value',
        axisLabel: {
                     
                      show: true, 
                      
                  }
    },
    series: [
        {
            name:'绑定用户数量',
            type:'line',
            stack: '总量',
            itemStyle : {
            normal : {
              label: {
                      show: true,
                      position: 'top',
                      textStyle: {
                        color: '#0089ff'
                  }
               }
            },
          },
            data:num
        }
    ]
};


 // 使用刚指定的配置项和数据显示图表。
        myChart.setOption(option);
}
</script>
  </body>
</html>
