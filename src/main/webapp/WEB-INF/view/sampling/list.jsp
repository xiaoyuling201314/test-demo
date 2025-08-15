<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/common/resource.jsp"%>
<html>
<style type="text/css">
	.cs-modal-box2 {
	    position: fixed;
	    top: 0;
	    left: 0;
	    right: 0;
	    bottom: 0;
	    background: #fff;
	    width: 100%;
	    z-index: 100000;
	}
	.container{margin-left: 30px; margin-top: 20px;}
        .containers{margin-left: 30px; margin-top: 10px;}
        h1{padding-bottom: 10px; color: darkmagenta; font-weight: bolder;}
        img{cursor: pointer;}
        #pic{position: absolute; display: none;}
		#pic1{ width: 100px;background-color: #fff; border-radius: 5px; -webkit-box-shadow: 5px 5px 5px 5px hsla(0,0%,5%,1.00); box-shadow: 5px 5px 5px 0px hsla(0,0%,5%,0.3); }
		#pic1 img{
			width:100%;
		}
		.cs-table-responsive{
			padding-bottom: 80px;

		}
</style>
  <head>
    <title>快检服务云平台</title>
    
  </head>

  <body>
	   <div id="dataList"></div>

	<form id="samplingDateForm">
	<div class="modal fade intro2" id="resetSamplingDate" tabindex="-1" role="dialog" aria-labelledby="rsdModalLabel">
		<div class="modal-dialog cs-sm-width" role="document">
			<div class="modal-content ">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
					<h4 class="modal-title" id="rsdModalLabel">修改抽样时间</h4>
				</div>
				<div class="modal-body cs-alert-height">
					<!-- 主题内容 -->
					<div class="cs-tabcontent" >
						<div class="cs-content2">
							<div class=" cs-warn-box clearfix">
								<!-- <h5 class="cs-title-s">预警设置</h5> -->
								<div class="cs-fl cs-warn-r cs-in-style">
									<input name="id" type="hidden">
									抽样时间：<input name="sDate" class="cs-time" type="text" onclick="WdatePicker({startDate:'%y-%M-%d %H:%m:%s',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})">
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
	
	<!-- 大弹窗 -->
	<div class="cs-modal-box2 cs-hide" style="margin: 0 auto;">
		<h5 class="cs-monitor-title text-primary cs-fl">
			<!-- <i class="icon iconfont icon-dingwei cs-red-text"></i>&nbsp;<span id="videoName"></span>  -->
		</h5>
		<div class="cs-col-lg clearfix">
			<!-- 面包屑导航栏  开始-->
			<ol class="cs-breadcrumb cs-fl">
				<li class="cs-fl"><img src="${webRoot}/img/set.png" alt="" />
				<li class="cs-fl">视频监控</li>
				<li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
				<li class="cs-fl">执法记录仪</li>
				<li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
				<li class="cs-b-active cs-fl">视频回放</li>
			</ol>
	
			<!-- 面包屑导航栏  结束-->
			<div class="cs-search-box cs-fr">
				<div class="cs-fr cs-ac ">
					<a onclick="returnBack();" class="cs-monitor-close cs-menu-btn"><i class="icon iconfont icon-fanhui"></i>返回</a>
				</div>
			</div>
		</div>
		<div style="text-align:center;"><video id="video" autoplay="autoplay" muted   poster="${webRoot}/img/video_bg.png" class="vjs-tech" preload="none" data-setup="{}" tabindex="-1" controls="controls" width="640" height="480"></video>
		</div>
	</div>
	
	<!-- Modal 3 签名-->
	<div class="modal fade intro2" id="sign" tabindex="-1" role="dialog" aria-labelledby="rsdModalLabel">
		<div class="modal-dialog cs-sm-width" role="document">
			<div class="modal-content ">
			<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
				<!-- <div class="modal-header" style="background:#fff;">
					
				</div> -->
				<div class="modal-body" style="padding:0;padding-top: 5px;">
					<!-- 主题内容 -->
					<div class="cs-tabcontent" >
						<div class="cs-content2" style="text-align:center;">
							<img src="${webRoot}/img/products/u91.jpg" alt="" style="width:100%;" />
						</div>
					</div>
				</div>
				
			</div>
		</div>
	</div>
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
	var reviewObj;

	if (Permission.exist("321-16") == 1) {
		isShowPrintNumber=1;
	}

	var dgu = datagridUtil.initOption({
		tableId: "dataList",
		tableAction: "${webRoot}/sampling/datagrid.do",
		tableBar: {
			title: ["抽样管理","抽样单"],
			hlSearchOff: 0,
			ele: [{
				eleShow: Permission.exist("321-19"),
				eleType: 4,
				eleHtml: "<span class=\"check-date cs-fl\">" +
						"<span class=\"cs-name\" style=\"padding-right: 0px;\">"+ Permission.getPermission("321-19").operationName +"：</span>" +
						"<div class=\"cs-all-ps\">\n" +
						"            <div class=\"cs-input-box\">\n" +
						"                <input type=\"text\" name=\"departNames\" autocomplete=\"off\">\n" +
						"                <div class=\"cs-down-arrow\"></div>\n" +
						"            </div>\n" +
						"            <div class=\"cs-check-down cs-hide\" style=\"display: none;\">\n" +
						"                <ul id=\"tree\" class=\"easyui-tree\"></ul>\n" +
						"            </div>\n" +
						"        </div>" +
						"</span>"
			}, {
				eleTitle: Permission.getPermission("321-20").operationName,
				eleName: "finish",
				eleType: 2,
				eleOption: [{"text": "--全部--", "val": "1"}, {"text": "未完成", "val": "2"}, {"text": "已完成", "val": "3"}],
				eleStyle: "width:85px;"
			}, {
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
				elePlaceholder: "抽样单号、检测点、被检单位、摊位编号、经营户"
			}],
			topBtns: [{
				show: Permission.exist("321-1"),
				style: Permission.getPermission("321-1"),
				action: function(ids, rows){
					showMbIframe("${webRoot}/sampling/queryById");
				}
			}],
			init: function () {
				//选择行政区
				$('#tree').tree({
					checkbox: false,
					url: "${webRoot}/detect/depart/getDepartTree.do",
					animate: true,
					onLoadSuccess: function (node, data) {
						if (data.length > 0) {
							$("input[name='departNames']").val(data[0].text);
						}
					},
					onClick: function (node) {
						var did = node.id;
						$("input[name='departNames']").val(node.text);
						$(".cs-check-down").hide();

						dgu.addDefaultCondition("departId", did);
						dgu.queryByFocus();
					}
				});
			}
		},
		defaultCondition: [
			{
				"queryCode" : "tbSampling.personal",
				"queryVal": 0
			}
		],
		onload: function(obj, pageData){
	    	//加载列表后执行函数
	    	$(".rowTr").each(function(){
		    	for(var i=0;i<obj.length;i++){
		    		if(Permission.exist("321-18")==1 && $(this).attr("data-rowId") == obj[i].id){//武陵系统权限控制：必须全部检测完成才能复核，复核完成后才能看到检测单按钮
						if(obj[i].total!=obj[i].completionNum || obj[i].printNum>0){//未全部检测完成或者已经打印过，隐藏复核操作
							$(this).find(".321-18").hide();
						}
						if(obj[i].reviewSignature==""){//未进行复核，隐藏查看检测报告操作
							$(this).find(".321-3").hide();
						}
					}
		    		if($(this).attr("data-rowId") == obj[i].id){
						if(obj[i].videoPath==null||obj[i].videoPath==""){
							//隐藏编辑按钮
							$(this).find(".321-13").hide();
						}else{//不为空 下载隐藏
							$(this).find(".321-14").hide();
						}
						if((obj[i].placeX=="4.9E-324" && obj[i].placeY=="4.9E-324") || (obj[i].placeX=="" && obj[i].placeY=="")){//抽样单获取不到定位，隐藏定位按钮
							$(this).find(".321-6").hide();
						}
		    		}
		    	}
	    	});
			pic();
	    },
		parameter: [
			{
				columnCode: "samplingNo",
				columnName: "抽样单号",
				queryCode: "tbSampling.samplingNo",
				customElement: "<a class='text-primary cs-link samplingNoI'>?<a>",
				customStyle:"samplingNo",
			},
			{
				columnCode: "pointName",
				columnName: "检测点"
			},
			{
				columnCode: "regName",
				columnName: "被检单位",
				queryCode: "tbSampling.regName"
			},
			{
				columnCode: "opeShopCode",
				columnName: "${systemFlag}"=="1" ? "摊位编号" : "档口编号",
				queryCode: "tbSampling.opeShopCode",
				columnWidth: '90px'
			},
			{
				columnCode: "opeShopName",
				columnName: "经营户",
				queryCode: "tbSampling.opeShopName",
				columnWidth: '90px'
			},
			{
				columnCode: "opeSignature",
				columnName: "签名",
				customStyle: 'container',
				columnWidth: '60px',
				customVal: {"non-null":"<b mYhref=\"${resourcesUrl}opeSignaturePath/?\" ><i class=\"icon iconfont icon-qian\"></i></b>"}
				/* customVal: {"non-null":"<a onclick=\"viewSign('${resourcesUrl}opeSignaturePath/?')\" ><i class=\"icon iconfont icon-qian\"></i></a>"} */
			},
			{
				columnCode: "samplingDate",
				columnName: "抽样时间",
				dateFormat: "yyyy-MM-dd HH:mm:ss"
			},
			{
				columnCode: "total",
				columnName: "总批次",
				customStyle:"total",
				columnWidth: '70px'
			},
			{
				columnCode: "completionNum",
				columnName: "已完成",
				customStyle:"completionNum",
				columnWidth: '70px'
			},{
				columnCode: "printNum",
				columnName: "打印次数",
				show:isShowPrintNumber,
				customStyle:"printNum",
				columnWidth: '80px'
			},
			{
				columnCode: "samplingUsername",
				columnName: "抽样人",
				columnWidth: '80px',
				customElement: "<p class=' downVideo'>?<p>"
			},
			/*{
				columnCode: "pointId",
				columnName: "检测点ID",
				columnWidth: '80px',
				customStyle:"pointId",
				show:2
			},*/
			{
				columnCode: "reviewSignature",
				columnName: "复核人员",
				columnWidth: '80px',
				customStyle:"reviewSignature",
				show:2
			},
			{
				columnCode: "orderPlatform",
				columnName: "来源",
				columnWidth: "50px",
				customVal: {"is-null":"<span class='text-primary'>APP</span>","1":"<span class='text-danger'>微信</span>","2":"网页"},
				show:Permission.exist("321-21")
			}
		],
		funBtns: [
			{
				show: Permission.exist("321-6"),
				style: Permission.getPermission("321-6"),
				action: function(id, obj){
					mapX=obj.placeX;
					mapY=obj.placeY;
					if (mapX && mapY) {
						$('#position').modal("show");
					} else {
						$("#waringMsg>span").html("未找到抽样定位信息");
						$("#confirm-warnning").modal('toggle');
					}
				}
			},
			{
				show: Permission.exist("321-2"),
				style: Permission.getPermission("321-2"),
	    		action: function(id){
	    			showMbIframe("${webRoot}/sampling/toWord.do?id="+ id+"&type=detail");
	    		}
	    	},
	    	{
				show: Permission.exist("321-3"),
				style: Permission.getPermission("321-3"),
	    		action: function(id){
	    			showMbIframe("${webRoot}/sampling/toWord.do?id="+ id+"&type=report");
	    		}
	    	},{
				show: Permission.exist("321-15"),
				style: Permission.getPermission("321-15"),
	    		action: function(id, obj){
					//update by xiaoyl 引用了datagridUtil2.js后播放视频传入的是当前对象，不再需要遍历
					$("#video").attr("src", "${webRoot}/resources/"+obj.videoPath);
					$('body').css('overflow', 'hidden');
					$('.cs-modal-box2').show();
			    	/*$(".rowTr").each(function(){
				    	for(var i=0;i<obj.length;i++){
                            if(id == obj[i].id){
                                $("#video").attr("src", "${webRoot}/resources/"+obj[i].videoPath);
                                $('body').css('overflow', 'hidden');
                                $('.cs-modal-box2').show();
                            }
                        }
			    	});*/

	    		}
	    	},{//下载检测报告权限
				show: Permission.exist("321-17"),
				style: Permission.getPermission("321-17"),
				action: function(id){
					location.href="${webRoot}/samp_rpt/create_pdf?samplingId="+id;
				}
			},{
				show: Permission.exist("321-14"),
				style: Permission.getPermission("321-14"),
	    		action: function(id){
	    			downLoad(id);
	    		}
	    	},{
				show: "${systemFlag}"=="1" ? Permission.exist("321-18") : 0 ,
				style: Permission.getPermission("321-18"),
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
				show: Permission.exist("321-4"),
				style: Permission.getPermission("321-4"),
	    		action: function(id){
	    			idsStr="{\"ids\":\""+id.toString()+"\"}";
	    			$("#confirm-delete").modal('toggle');
	    		}
	    	},{
				show: Permission.exist("321-5"),
				style: Permission.getPermission("321-5"),
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
				show: Permission.exist("321-11"),
				style: Permission.getPermission("321-11"),
	    		action: function(id){
					$("#resetSamplingDate input[name='id']").val(id);
					$("#resetSamplingDate").modal('toggle');
	    		}
	    	}

	    ],
		bottomBtns: [
			{	//删除
				show: Permission.exist("321-4"),
				style: Permission.getPermission("321-4"),
				action: function(ids){
					idsStr = "{\"ids\":\""+ids.toString()+"\"}";
					$("#confirm-delete").modal('toggle');
				}
		    }, {
				show: "${systemFlag}"=="1" ? 0 : Permission.exist("321-2"),
				style: Permission.getPermission("321-2"),
				action: function(id){
					if(id.length>0){
						showMbIframe("${webRoot}/sampling/toWord?id="+ id+"&type=detail");
					}else{
						$("#waringMsg>span").html("请先选择抽样单！");
						$("#confirm-warnning").modal('toggle');
					}
				}
		    }, {
				show: "${systemFlag}"=="1" ? 0 : Permission.exist("321-3"),
				style: Permission.getPermission("321-3"),
				action: function(id){
					if(id.length>0){
						showMbIframe("${webRoot}/sampling/toWord?id="+ id+"&type=report");
					}else{
						$("#waringMsg>span").html("请先选择抽样单！");
						$("#confirm-warnning").modal('toggle');
					}
				}
		    },{
				show: "${systemFlag}"=="1" ? 0 : Permission.exist("321-18"),
				style: Permission.getPermission("321-18"),
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
			},{//下载检测报告权限
				show: Permission.exist("321-17"),
				style: Permission.getPermission("321-17"),
				action: function(id){
					if(id!=""){
						location.href="${webRoot}/samp_rpt/create_pdf?samplingId="+id;
					}else{
						$("#waringMsg>span").html("请先选择需要下载的抽样单！");
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
    //隐藏点击事件 点击即可获取抽样单视频
    var videos=[];
    //下载视频
    function downLoad(samId) {
    	if(samId==null){
    		return;
    	}
   		//delete by xiaoyl 2020-07-22 恢复点击下载抽样单功能 start
//     	if(videos.indexOf(samId,0)==-1){
//     		videos.push(samId);
//     	}else{
//     		return;
//     	}
   		//delete by xiaoyl 2020-07-22 恢复点击下载抽样单功能 end
    	$.ajax({
	        type: "POST",
	        url: "${webRoot}/video/getVideo.do",
	        data: {
	        	"samId":samId
	        },
	        dataType: "json",
	        success: function(data){
	        	if(data.success){
	        		//刷新列表
					dgu.query();
	        	}
			}
	    });
	}

    //修改抽样时间
    $(document).on("click",".rsdBtn",function(){
    	$.ajax({
	        type: "POST",
	        url: "${webRoot}/sampling/resetSamplingDate.do",
	        data: $("#samplingDateForm").serialize(),
	        dataType: "json",
	        success: function(data){
	        	if(data.success){
	        		//刷新列表
					dgu.query();
	        	}
	        	$("#resetSamplingDate").modal('toggle');
	        	$("#waringMsg>span").html(data.msg);
	        	$("#confirm-warnning").modal('toggle');
			}
	    });
    });
  	//关闭监控摄像头，返回list
	function returnBack(){
		$("#iframe1").attr("src", "");
		$("#video").attr("src", "");
	/* 	  var myvideo=document.getElementById("video");
		  myvideo.pause();//关闭iframe 并关闭视频 */
		$('body').css('overflow', 'auto');
		$('.cs-modal-box2').hide();
	}

	//查看经营户签名
	function pic(){
        $(".container b").hover(function(){
        	var tImg = $(this).attr('myHref');
            $(this).append("<p id='pic'><img src='"+tImg+"' id='pic1'></p>");
            $(".container b").mousemove(function(e){
                $("#pic").css({
                    "top":(e.pageY-30)+"px",
                    "left":(e.pageX+20)+"px"
                }).fadeIn("fast");
            });
        },function(){
            $("#pic").remove();
        });
	}
    </script>
  </body>
</html>
