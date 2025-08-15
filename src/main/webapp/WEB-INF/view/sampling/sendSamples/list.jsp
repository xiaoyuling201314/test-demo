<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/common/resource.jsp"%>
<html>
  <head>
    <title>快检服务云平台</title>
  </head>

  <body>
<%--

      <div class="cs-col-lg clearfix">
        <ol class="cs-breadcrumb">
          <li class="cs-fl">
          <img src="${webRoot}/img/set.png" alt="" />
          <a href="javascript:;">你送我检</a></li>
          <li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
          <li class="cs-b-active cs-fl">送检单
          </li>
        </ol>
        <div class="cs-search-box cs-fr">
          <form action="list.do" method="post">

            <div class="cs-search-filter clearfix cs-fl">
            <input class="cs-input-cont cs-fl focusInput" type="text" name="tbSampling.samplingNo" placeholder="请输入内容" />
            <input type="button" class="cs-search-btn cs-fl" onclick="datagridUtil.queryByFocus()" href="javascript:;" value="搜索">
            <span class="cs-s-search cs-fl">高级搜索</span>
            </div>
            <div class="clearfix cs-fr" id="showBtn">
          </div>
          </form>
        </div>
      </div>
--%>
	<div id="dataList"></div>

<!-- Modal 3 小-->
	<form id="samplingDateForm">
	<div class="modal fade intro2" id="resetSamplingDate" tabindex="-1" role="dialog" aria-labelledby="rsdModalLabel">
		<div class="modal-dialog cs-sm-width" role="document">
			<div class="modal-content ">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
					<h4 class="modal-title" id="rsdModalLabel">修改送样时间</h4>
				</div>
				<div class="modal-body cs-alert-height">
					<!-- 主题内容 -->
					<div class="cs-tabcontent" >
						<div class="cs-content2">
							<div class=" cs-warn-box clearfix">
								<!-- <h5 class="cs-title-s">预警设置</h5> -->
								<div class="cs-fl cs-warn-r cs-in-style">
									<input name="id" type="hidden">
									送样时间：<input name="sDate" class="cs-time" type="text" onclick="WdatePicker({startDate:'%y-%M-%d %H:%m:%s',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})">
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-success rsdBtn">确定</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				</div>
			</div>
		</div>
	</div>
	</form>
    <%@include file="/WEB-INF/view/common/modalBox.jsp"%>
    <%@include file="/WEB-INF/view/common/confirm.jsp"%>
    <%@include file="/WEB-INF/view/common/map.jsp"%>
     <!--复核检测单-->
     <%@include file="/WEB-INF/view/sampling/reviewSampling.jsp"%>
    <!-- JavaScript -->
    <script src="${webRoot}/js/datagridUtil2.js"></script>
    <script type="text/javascript">
	rootPath="${webRoot}/sampling/";
    var isShowPrintNumber=2;//默认隐藏打印次数列
    var reviewSampling=0;//是否显示复核权限，只有武陵系统并且有复核权限时才显示
    var reviewObj;
    if("${systemFlag}"=="1" && Permission.exist("1344-13")){
        reviewSampling=1;
    }

    if (Permission.exist("1344-12") == 1) {
        isShowPrintNumber=1;
    }

    var dgu = datagridUtil.initOption({
		tableId: "dataList",
		tableAction: "${webRoot}/sampling/datagrid.do",
        tableBar: {
            title: ["你送我检","送检单"],
            hlSearchOff: 0,
            ele: [{
                eleShow: 1,
                eleTitle: "范围",
                eleName: "samplingDate",
                eleType: 3,
                eleStyle: "width:110px;",
                eleDefaultDateMin: newDate().DateAdd("m",-1).format("yyyy-MM-dd"),
                eleDefaultDateMax: newDate().format("yyyy-MM-dd")
            },{
                eleShow: 1,
                eleName: "keyWords",
                eleType: 0,
                elePlaceholder: "送样单号、检测点、送检人、联系电话"
            }],
            topBtns: [{
                show: Permission.exist("1344-3"),
                style: Permission.getPermission("1344-3"),
                action: function(ids, rows){
                    showMbIframe('${webRoot}/sampling/addSendSample.do');
                }
            }]
        },
		defaultCondition: [
			{
				"queryCode" : "tbSampling.personal",
				"queryVal": 1
			}
		],	onload: function(obj, pageData){
            $(".rowTr").each(function(){
                for(var i=0;i<obj.length;i++){
                    if(reviewSampling==1 && $(this).attr("data-rowId") == obj[i].id){//武陵系统权限控制：必须全部检测完成才能复核，复核完成后才能看到检测单按钮
                        if(obj[i].total!=obj[i].completionNum || obj[i].printNum>0){//未全部检测完成或者已经打印过，隐藏复核操作
                            $(this).find(".1344-13").hide();
                        }
                        if(obj[i].reviewSignature==""){//未进行复核，隐藏查看检测报告操作
                            $(this).find(".1344-8").hide();
                        }
                    }
                    if($(this).attr("data-rowId") == obj[i].id){
                        if((obj[i].placeX=="4.9E-324" && obj[i].placeY=="4.9E-324") || (obj[i].placeX=="" && obj[i].placeY=="")){//抽样单获取不到定位，隐藏定位按钮
                            $(this).find(".1344-9").hide();
                        }
                    }
                }
            });
        },
		parameter: [
			{
				columnCode: "samplingNo",
				columnName: "送样单号",
				query: 1,
				queryCode: "tbSampling.samplingNo",
				customElement: "<a class='text-primary cs-link samplingNoI'>?<a>",
                customStyle:"samplingNo",
			}, {
				columnCode: "pointName",
				columnName: "检测点",
				query: 1,
				queryCode: "tbSampling.pointName"
			}, {
				columnCode: "regName",
				columnName: "送检人",
				query: 1,
				queryCode: "tbSampling.regName"
			}, {
				columnCode: "regLinkPhone",
				columnName: "联系电话"
			}, {
				columnCode: "samplingDate",
				columnName: "送样时间",
				queryType: 1,
				columnWidth: '200px',
				dateFormat: "yyyy-MM-dd HH:mm:ss"
			}, {
				columnCode: "total",
				columnName: "总批次",
                customStyle:"total",
				columnWidth: '60px'
			}, {
				columnCode: "completionNum",
				columnName: "已完成",
                customStyle:"completionNum",
				columnWidth: '60px'
			}, {
				columnCode: "printNum",
				columnName: "打印次数",
				show:isShowPrintNumber,
                customStyle:"printNum",
				columnWidth: '80px'
			}, {
				columnCode: "samplingUsername",
				columnName: "抽样人",
                columnWidth: '80px',
			}, {
                columnCode: "reviewSignature",
                columnName: "复核人员",
                columnWidth: '80px',
                customStyle:"reviewSignature",
                show:2
            }
		],
		funBtns: [
			{
                show: Permission.exist("1344-9"),
                style: Permission.getPermission("1344-9"),
				action: function(id, obj){
	    		    for(var i=0;i<obj.length;i++){
	    		   		if(id == obj[i].id){
	    		   			mapX=obj[i].placeX;
	    		   			mapY=obj[i].placeY;
	    		   			$("#myModalLabel").text("送样定位");
			    			$('#position').modal("show");
	    		   		}
	    		   	}
				}
			},
			{
                show: Permission.exist("1344-7"),
                style: Permission.getPermission("1344-7"),
	    		action: function(id){
                    showMbIframe("${webRoot}/sampling/toWord.do?id="+ id+"&type=detail");
	    		}
	    	},
	    	{
                show: Permission.exist("1344-8"),
                style: Permission.getPermission("1344-8"),
	    		action: function(id){
                    showMbIframe("${webRoot}/sampling/toWord.do?id="+ id+"&type=report");
	    		}
	    	},{
                show: reviewSampling,
                style: Permission.getPermission("1344-13"),
                action: function(id){
                    $("#dataList .rowTr").each(function (index, value) {
                        if (id == $(this).attr("data-rowid")) {
                            let samplingNo= $(this).find(".samplingNo").text();//抽样单号
                            let reviewName= $(this).find(".reviewSignature").text();//复核人员姓名或者签名文件地址
                            reviewObj={id:id,samplingNo:samplingNo,reviewName:reviewName};
                            $("#reviewSamplingModal").modal('toggle');
                        }
                    });
                }
            },{
                show: Permission.exist("1344-2"),
                style: Permission.getPermission("1344-2"),
	    		action: function(id){
	    			idsStr="{\"ids\":\""+id.toString()+"\"}";
	    			$("#confirm-delete").modal('toggle');
	    		}
	    	},{
                show: Permission.exist("1344-10"),
                style: Permission.getPermission("1344-10"),
	    		action: function(id){
	    			$.ajax({
	    		        type: "POST",
	    		        url: "${webRoot}/sampling/issuedTask.do",
	    		        data: {"id":id},
	    		        dataType: "json",
	    		        success: function(data){
    		        		$("#waringMsg>span").html(data.msg);
    		        		$("#confirm-warnning").modal('toggle');
	    				}
	    		    });
	    		}
	    	},{
                show: Permission.exist("1344-11"),
                style: Permission.getPermission("1344-11"),
	    		action: function(id){
					$("#resetSamplingDate input[name='id']").val(id);
					$("#resetSamplingDate").modal('toggle');
	    		}
	    	}
	    	
	    ],
		bottomBtns: [
			{	//删除函数	
                show: Permission.exist("1344-2"),
                style: Permission.getPermission("1344-2"),
                action: function(ids){
                    idsStr = "{\"ids\":\""+ids.toString()+"\"}";
                    $("#confirm-delete").modal('toggle');
                }
		    }, {
                show: "${systemFlag}"=="1" ? 0 : Permission.exist("1344-7"),
                style: Permission.getPermission("1344-7"),
                action: function(id){
                    if(id.length>0){
                        showMbIframe("${webRoot}/sampling/toWord?id="+ id+"&type=detail");
                    }else{
                        $("#waringMsg>span").html("请先选择送检单！");
                        $("#confirm-warnning").modal('toggle');
                    }
                }
            }, {
                show: "${systemFlag}"=="1" ? 0 : Permission.exist("1344-8"),
                style: Permission.getPermission("1344-8"),
                action: function(id){
                    if(id.length>0){
                        showMbIframe("${webRoot}/sampling/toWord?id="+ id+"&type=report");
                    }else{
                        $("#waringMsg>span").html("请先选择送检单！");
                        $("#confirm-warnning").modal('toggle');
                    }
                }
            },{
                show: "${systemFlag}"=="1" ? 0 : Permission.exist("1344-13"),
                style: Permission.getPermission("1344-13"),
                action: function(ids){
                    if(ids.length>0){
                        let samplingNo="";
                        let reviewName="";
                        let reviewFlag=true;
                        $("#dataList .rowTr").each(function (index, value) {
                            if(reviewFlag){
                                for (let i = 0; i < ids.length; i++) {
                                    if (ids[i] == $(this).attr("data-rowid") && ($(this).find(".printNum").text()>0 || $(this).find(".total").text()!=$(this).find(".completionNum").text())) {
                                        reviewFlag=false;
                                        break;
                                    }else if (ids[i] == $(this).attr("data-rowid")){
                                        samplingNo+=$(this).attr("data-rowid") && $(this).find(".samplingNo").text()+",";
                                    }
                                }
                            }

                        });
                        if(reviewFlag){
                            samplingNo=samplingNo.substring(0,samplingNo.length-1)
                            reviewObj={id:ids.toString(),samplingNo:samplingNo,reviewName:reviewName};//ids.length+"个抽样单"
                            $("#reviewSamplingModal").modal('toggle');
                        }else{
                            $("#waringMsg>span").html("请勿选择未检测完成或已打印的订单！");//请选择待复核的抽样单！
                            $("#confirm-warnning").modal('toggle');
                        }

                    }else{
                        $("#waringMsg>span").html("请先选择抽样单！");
                        $("#confirm-warnning").modal('toggle');
                    }
                }
            }
		]
	});
    dgu.query();
    
    //刷新，iframe调用
    function refreshData(){
        dgu.query();
    }
    
    //查看抽样单明细
    $(document).on("click",".samplingNoI",function(){
    	showMbIframe("${webRoot}/samplingDetail/details.do?id="+$(this).parents(".rowTr").attr("data-rowId"));
    });
    
    //修改抽样时间
    $(document).on("click",".rsdBtn",function(){
    	$.ajax({
	        type: "POST",
	        url: "${webRoot}/sampling/resetSamplingDate.do",
	        data: $("#samplingDateForm").serialize(),
	        dataType: "json",
	        success: function(data){
	        	if(data.success){
                    dgu.query();
	        	}
	        	$("#resetSamplingDate").modal('toggle');
	        	$("#waringMsg>span").html(data.msg);
	        	$("#confirm-warnning").modal('toggle');
			}
	    });
    });
    </script>
  </body>
</html>
