<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/common/resource.jsp"%>
<%@page import="java.util.Date"%>
<html>
<head>
<title>快检服务云平台</title>
<link rel="stylesheet" type="text/css" href="${webRoot}/plug-in/easyui-1.5.2/tree.css">
<style type="text/css">
.layout-split-west {
	bottom: 50px;
}

#allmap {
	width: 100%;
	height: 100%;
	overflow: hidden;
	margin: 0;
	font-family: "微软雅黑";
}

iframe {
	width: 100%;
	height: 100%;
	position: absolute;
	right: 0;
	left: 0;
	top: 0px;
	bottom: 0;
	border: 0;
	border: none;
}

.cs-search-box {
	position: absolute;
	right: 0px;
	top: 0px;
	z-index: 1000;
}
</style>
<style type="text/css">
.play-back {
	display: table;
	position: absolute;
	left: 0;
	right: 0;
	bottom: 0;
	top: 0px;
	width: 100%;
	height: 100%;
	overflow: hidden;
}

.play-left-nav, .play-right-video {
	display: table-cell;
	padding-top: 40px;
	height: 100%;
}

.play-left-nav {
	width: 300px;
	background: #f1f1f1;
	overflow:hidden;
	border-right:1px solid #ddd;
	position:relative;
}

.play-right-video {
	vertical-align: top;
	text-align: center;
	overflow: hidden;
	background: #fff;
}

.video-player {
	width: 640px;
	height: 480px;
}

body {
	background: #000;
}

.play-list ul li {
	padding: 6px 12px 6px 10px;
	border-bottom: 1px dotted #ddd;
}
.cs-pagination ul li{
	padding:0;
	border-bottom:0;
}
.cs-bottom-nav{
	padding:5px;
	position: absolute;
    bottom: 0;
    width: 100%;
}
.play-list ul li:hover,.play-list ul li.active{
	background: #ddd;
	color: #05af50;
	cursor: pointer;
}
.cs-pagination ul li,.cs-pagination ul li:hover,.cs-pagination ul li.active{
	background:#fff;
	color:#333;
}
.play-left-nav h4 {
	padding: 6px;
	border-bottom: 1px solid #ddd;
	background: #f1f1f1;
	font-size:14px;
}
.play-list{
    overflow-y: auto;
    height: 100%;
    padding-bottom: 75px;
}
#ulList li i{
	display: inline-block;
    width: 90%;
}
</style>
</head>
<body class="easyui-layout">
	<div class="cs-col-lg clearfix" style="position: absolute; left: 0; right: 0; top: 0; z-index: 1000;">
		<!-- 面包屑导航栏  开始-->
		<ol class="cs-breadcrumb">
			<li class="cs-fl"><img src="${webRoot}/img/set.png" alt="" />
			<c:if test="${type==1}">
			<a href="javascript:">执法记录仪</a>
			</c:if>
			<c:if test="${type==2}">
			<a href="javascript:">实时监控</a>
			</c:if>
			</li>
			<li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
			<li class="cs-b-active cs-fl">视频回放</li>
		</ol>
		<!-- 面包屑导航栏  结束-->
	<!-- 面包屑导航栏  结束-->
		<div class="cs-search-box cs-fr">
			<form >
               <span class="cs-name">时间:</span>
	                <span class="cs-in-style cs-time-se cs-time-se">
	                	<input autocomplete="off" name="start" style="width:169px;" class="cs-time Validform_error" id="start" type="text" onclick="WdatePicker({dateFmt:'yyyy-M-d H:mm:ss',maxDate:'#F{$dp.$D(\'end\')}'})" datatype="time"  value="<fmt:formatDate value='<%=new Date()%>' pattern='yyyy-MM-01 00:00:00'/>">
	                	<span style="padding:0 5px;">
	                                      至</span>
	                    <input autocomplete="off" name="end" style="width: 169px;" class="cs-time Validform_error" id="end" type="text" onclick="WdatePicker({dateFmt:'yyyy-M-d H:mm:ss',maxDate:'%y-%M-%d',minDate:'#F{$dp.$D(\'start\')}'})" datatype="time" value="<fmt:formatDate value='<%=new Date()%>' pattern='yyyy-MM-dd HH:mm:ss'/>">
	                </span>
	                <span>
		            	<a href="javascript:" class="cs-menu-btn" style="margin:4px 0 0 10px;" onclick="queryData()"><i class="icon iconfont icon-chakan"></i>查询</a>
            <button class="cs-menu-btn" onclick="parent.closeMbIframe(1);"><i class="icon iconfont icon-fanhui"></i>返回</button>
                </span>
        
			</form>

		</div>
	</div>
	<div class="cs-col-lg-table">
		<div class="cs-table-responsive">
			<div class="play-back">
				<div class="play-left-nav">
					<h4>时间列表</h4>
					<div class="play-list">
						
						 <ul id="ulList">
						</ul> 
						<div class="cs-bottom-nav cs-pagination"  id="Page">
						</div>
					</div>
				</div>
				<div class="play-right-video">
					<video id="video" src="" autoplay="autoplay" muted   class="video-player" autoplay="autoplay" controls="controls">

					</video>
				</div>
			</div>
		</div>
	</div>
	<!-- 引用模态框 -->
	<%@include file="/WEB-INF/view/common/confirm.jsp"%>
	<!-- JavaScript -->
	<script src="${webRoot}/js/datagridUtil.js"></script>
	<script type="text/javascript">
		var edit = 0;
		var editObj;
		var del = 0;
		var delObj;
		var monitor = 0;
		var monitorObj;
		var playback = 0;
		var playbackObj;
		for (var i = 0; i < childBtnMenu.length; i++) {
			if (childBtnMenu[i].operationCode == "1408-2") {
				monitor = 1;
				monitorObj = childBtnMenu[i];
			}
		}

		$(function() {
			$("#start").val(	getBeforeDate(30));
				queryData();
			});
			
			
			function getBeforeDate(n){
				var date = new Date() ;
				var year,month,day ;
				date.setDate(date.getDate()-n);
				year = date.getFullYear();
				month = date.getMonth()+1;
				day = date.getDate() ;
				s = year + '-' + ( month < 10 ? ( '0' + month ) : month ) + '-' + ( day < 10 ? ( '0' + day ) : day) +' 0:00:00' ;
				return s ;
			} 
		
		//获取视频数据列表
		function searchData() {
			var start=$("#start").val();
			var end=$("#end").val();
			$.ajax({
				url : '${webRoot}/data/lawInstrument/playbackDatagrid.do?instrumentId=${instrumentId}&type=${type}&start='+start+'&end='+end,
				success : function(data) {
					$("#ulList").empty();
					var list = data.obj.results;
					var html = "";
					for (var i = 0; i < list.length; i++) {
						var o = list[i];
						var file=o.file;
						var name=file;
						if(file){
						var  s=	file.split("/");
						name=s[2];
						}
						html += '<li><i onclick="play(\''+o.file+'\')">'+(i+1)+'   '+o.time+'</i>';
						var path="${webRoot}/resources/" + o.file;
						html += '<a class="pull-right icon iconfont icon-xiafa" title="下载"  href="'+path+'" download="'+name+'"></a></li>';
					}
					$("#ulList").html(html);
					if(list.length>0){
						play(list[0].file);
					}
					$('.play-list li').eq(0).addClass('active');
				}
			});
		}
		
		
		function  creatHtml(list) {
			$("#ulList").empty();
		
			var html = "";
			for (var i = 0; i < list.length; i++) {
				var o = list[i];
				var file=o.file;
				var name=file;
				if(file){
				var  s=	file.split("/");
				name=s[2];
				}
				html += '<li><i onclick="play(\''+o.file+'\')">'+(i+1)+'&nbsp;&nbsp;&nbsp;&nbsp;'+o.time+'</i>';
				var path="${webRoot}/resources/" + o.file;
				html += '<a class="pull-right icon iconfont icon-xiafa" title="下载"  href="'+path+'" download="'+name+'"></a></li>';
			}
			$("#ulList").html(html);
			if(list.length>0){
				play(list[0].file);
			}
			$('.play-list li').eq(0).addClass('active');
		}
		
		function play(file){
			$("#video").attr('src',"${webRoot}/resources/" + file);
		}
		
		//查看执法仪直播
		function viewMonitor(id) {
			$.ajax({
				url : '${webRoot}/data/lawInstrument/viewPlayback?id=' + id,
				success : function(data) {
					$("#video").attr("src", "${webRoot}/resources/" + data.file);
					$('.cs-modal-box').show();
				}
			});
		}
		//关闭监控摄像头，返回list
		/* function returnBack() {
			$("#iframe1").attr("src", "");
			$('.cs-modal-box').hide();
		}
		var rH=$('.play-right-video').height();
	    $('.video-player').height(rH-10);
	    $(window).resize(function(event) {
	      $('.video-player').height(rH-10);
	    }); */
	    $(document).on('click','.play-list li',function(){
	    	$(this).addClass('active').siblings().removeClass('active');
	    })
	</script>
	
	
	<script type="text/javascript">
	 //查询功能
	 
	     var pageSize = 10;
    var pageNo =1;
    var pageCount = 1;
    var pageSizeSel = 1;
    var toPageNo = 1;
    var navBtnNum = 2;	//导航页面序号按钮数量
    var halfBtnNum = parseInt(navBtnNum / 2);
    var rowTotal=0;
	  function queryData(p) {
			$("#video").attr('src',"");
	    	if(!p){
	    		p=1;
	    	}
			var start=$("#start").val();
			var end=$("#end").val();
		  var dataStr = "{\"pageSize\":" + pageSize + ",\"pageNo\":" + p
	      + ",\"rowTotal\":" + rowTotal + ",\"type\":1,\"map\":1,\"start\": \""+start+"\",\"pageCount\":" +pageCount+",\"end\":\""  +end+"\"}";
	     $.ajax({
	                type: "POST",
	                url: "${webRoot}/data/lawInstrument/playbackDatagrid.do?instrumentId=${instrumentId}&type=${type}",
	                data: JSON.parse(dataStr) ,
	                dataType: "json",
	                success: function (data) {
	                    if (data && data.success) {
	                    	var list = data.obj.results;
	                    	creatHtml(list);
	                    	
	                        var pageModel = data.obj;
	                        getPage(pageModel);
		    	        	 
	                    } else {
	                        console.log("查询失败");
	                    }
	                },
	                error: function () {
	                    console.log("查询失败");
	                }
	            });
	    }
		 //查询功能
		  function getPage(pageModel) {
				if (pageModel) {
	              //设置总记录数量
	             rowTotal = pageModel.rowTotal;
	              pcount=parseInt(rowTotal/pageSize);
	              //设置总页数、当前页数
	              if (pcount <= 0) {
	              	pageCount= 1;
	              } else if (pcount > pageCount) {
	              	pageNo = pageCount;
	                  pageCount = pageModel.pageCount;
	              } else {
	              	pageCount = pageModel.pageCount;
	              }
	              pageNo=pageModel.pageNo;
	              //记录数据
	          }
				  setPage();//重置分页导航
		    }
		
		    function setPage() {
				  sss="queryData";
			var html="";
		    html += "<ul class=\"cs-pagination cs-fr\">";
		    html += "<li class=\"cs-distan\">共" + pageCount + "页/" + rowTotal + "条记录</li>";
		    html += "<li class=\"cs-b-nav-btn cs-distan cs-selcet\">";
		    html += "<li class=\"cs-disabled cs-distan\"><a class=\"cs-b-nav-btn\" " +
		        "onclick=\""+sss+"('" + pageSizeSel + "');\">«</a></li>";
		    pageNo = parseInt(pageNo);
		    //导航页面序号居中
		    if ((pageCount < navBtnNum) || (pageNo - halfBtnNum <= 0)) {
		        //总页数少于5或最前几页显示
		        for (var i = 1; i <= (pageCount > navBtnNum ? navBtnNum : pageCount); i++) {
		            html += "<li><a class=\"cs-b-nav-btn";
		            if (pageNo == i) {
		                html += " cs-n-active";
		            }
		            html += "\" onclick=\""+sss+"('" + i + "');\">" + i + "</a></li>";
		        }
		    } else {
		        if (pageNo + halfBtnNum >= pageCount) {
		            //最后几页
		            var i = pageNo - halfBtnNum;
		            if (i == pageCount) {
		                for (i; i <= pageCount; i++) {
		                    html += "<li><a class=\"cs-b-nav-btn";
		                    if (pageNo == i) {
		                        html += " cs-n-active";
		                    }
		                    html += "\" onclick=\""+sss+"('" + i + "');\">" + i + "</a></li>";
		                }
		            } else if (i < pageCount) {
		                for (var ii = pageCount - navBtnNum + 1; ii <= pageCount; ii++) {
		                    html += "<li><a class=\"cs-b-nav-btn";
		                    if (pageNo == ii) {
		                        html += " cs-n-active";
		                    }
		                    html += "\" onclick=\""+sss+"('" + ii + "');\">" + ii + "</a></li>";
		                }
		            }
		        } else {
		            //中间几页
		            if (navBtnNum % 2 == 0) {
		                //偶数按钮数量
		                for (var i = pageNo - halfBtnNum + 1; i <= pageNo + halfBtnNum; i++) {
		                    html += "<li><a class=\"cs-b-nav-btn";
		                    if (pageNo == i) {
		                        html += " cs-n-active";
		                    }
		                    html += "\" onclick=\""+sss+"('" + i + "');\">" + i + "</a></li>";
		                }
		            } else {
		                //奇数按钮数量
		                for (var i = pageNo - halfBtnNum; i <= pageNo + halfBtnNum; i++) {
		                    html += "<li><a class=\"cs-b-nav-btn";
		                    if (pageNo == i) {
		                        html += " cs-n-active";
		                    }
		                    html += "\" onclick=\""+sss+"('" + i + "');\">" + i + "</a></li>";
		                }
		            }
		        }
		    }
		    html += "<li class=\"cs-next \"><a class=\"cs-b-nav-btn\" " +
		        "onclick=\""+sss+"('" + pageCount + "');\">»</a></li>";
		    html += "</ul></div>";
		    //刷新列表
			    	   $("#Page").html("");
			    	$("#Page").append(html);
			}
		
	</script>
</body>
</html>
