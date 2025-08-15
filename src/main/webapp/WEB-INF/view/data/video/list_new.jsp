<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/common/resource.jsp"%>
<html>
<head>
<title>快检服务云平台</title>
<link rel="stylesheet" type="text/css" href="${webRoot}/plug-in/easyui-1.5.2/tree.css">
<style type="text/css">
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
	padding-top: 30px;
	height: 100%;
	padding:20px 2% 0;
}

.play-left-nav {
	width: 200px;
	background: #f1f1f1;
	overflow-y:auto;
	border-right:1px solid #ddd;
}

.play-right-video {
	vertical-align: top;
	text-align: center; 
	overflow: hidden;
	background: #fff;
}

.video-player {
	width: 100%;
	height:200px;
}



.play-list ul li {
	padding: 6px 12px 6px 10px;
	border-bottom: 1px dotted #ddd;
}

.play-list ul li:hover,.play-list ul li.active{
	background: #ddd;
	color: #05af50;
	cursor: pointer;
}

.play-left-nav h4 {
	padding: 6px;
	border-bottom: 1px solid #ddd;
	background: #f1f1f1;
	font-size:14px;
}
.textbox-addon {
	position: absolute;
	top: 0;
	width: 30px;
	text-align: center;
	background: #ddd;
	cursor: pointer;
	display: block;
}

.combo-arrow {
	width: 30px;
	background: url(http://localhost:8080/fc/img/tab_arrow.png) no-repeat center center;
}

.showDiv {
	height: 30px;
	width: 30px;
	text-align: center;
	z-index: 1000;
	background: rgba(0, 0, 0, 0.5);
	width: 100%;
	height: 100%;
	position: relative;
}

.showDiv p {
	cursor: pointer;
}

.cs-tab-icon ul {
	border-right: 1px solid #ddd;
}

.cs-tab-icon ul li {
	float: left;
	border-left: 1px solid #ddd;
}

.cs-tab-icon ul li a {
	display: inline-block;
	margin-top: -1px;
	padding: 0 20px;
	line-height: 41px;
	color: #999;
}

.cs-tab-icon ul li a:hover, .cs-tab-icon ul li a.active {
	color: #05af50;
}

.cs-tab3 {
	padding: 6px 0 0 10px;
	height: 40px;
	line-height: 40px;
}

.cs-tab3 li {
	float: left;
	height: 30px;
	color: #666;
	text-align: center;
	line-height: 34px;
	cursor: pointer;
	background: #fff;
	width: 110px;
}

.cs-tab3 li.cs-cur {
	height: 34px;
	border: 1px solid #ddd;
	border-bottom: none;
	color: #fff;
	background: #1dcc6a;
	border-radius: 4px 4px 0 0;
}

.cs-tab-box3 {
	display: none;
}

.cs-tab-box3.cs-on {
	display: block;
}
.cs-input-box .Validform_checktip{
	display:none;
}
.cs-bottom-tools{
	display:none;
}
.video-player-box{
	display:inline-block;
	position:relative;
	width: 49%;
	/* height:180px; */
    /* margin-left: 6%; */
    margin-bottom: 4%;
}
.video-player-box:nth-child(even){
	margin-left: 2%;
}
.video-player-box p{
	position:absolute;
	top:0;
	left:0;
	width:100%;
	height:24px;
	color: #fff;
    z-index: 10;
    padding:0 5px;
}

.play-center{
	width:100%;
	margin:0 auto;
	text-align: center;
}
.search-input{
	text-align:center;
}
.search-input input{
	width:90%;
	height:30px;
}
.stock_info{
	width:100%;
	overflow: auto;
	height: 90%;
	/*height: 100%;*/
}
.text-gray{
	color: #999999;
}
.text-danger {
	color: #d63835;
}
.stock_info ul li .title {
	width: 78%;
}

.cs-stat-search .cs-input-cont[type=text]{
	width:85px;
	margin-left:0;
}
.cs-search-btn{
	width:34px;
}
.cs-search-filter, .cs-search-margin {
	float: right;
	margin-right: 0;
}
#mse{
	overflow: hidden;
}


.playerVedio{
	margin:0 auto;
	margin-top:10px;
	height: 480px;
}
.styleDiv{
	padding:0;
	width: 800px;
	margin: 0 auto;
	box-sizing: border-box;
}
#playercontainerDingZhi{
	width: 800px;
	height: 480px;
	margin: 10px auto;
}

#playercontainerDingZhi iframe {
	position: relative;
	margin-bottom: 10px;
	overflow: hidden;
}

/*.player__panel {*/
/*	display:none;*/
/*}*/

.player__split{
	display: none !important;
}

</style>
</head>
<body class="easyui-layout">
	<div data-options="region:'west',split:false,title:'检测点'" style="width: 326px; padding:10px; padding-left:0; padding-right:0;overflow: hidden;">
		<div class="search-result">
			<div class="cs-stat-search col-md-12 col-sm-12 clearfix">
				<div class="cs-all-ps">
					<div class="cs-input-box" style="width:180px">
						<input type="text" name="departName" id="departName" readonly="readonly" value="${report.departName }" title="${report.departName }" style="height: 30px;overflow: hidden; white-space: nowrap; text-overflow: ellipsis;width: 180px;">
						<!-- 							<div class="cs-down-arrow"></div> -->
					</div>
					<!-- <div class="cs-check-down cs-hide" style="display: none;">
                        <ul id="trees" class="easyui-tree"></ul>
                    </div> -->
				</div>
				<div class="cs-search-filter clearfix cs-fr">
					<%--<input class="cs-input-cont cs-fl focusInput" type="hidden" name="pointId" id="pointId">--%>
					<input class="cs-input-cont cs-fl focusInput" type="text" name="pointName" id="pointName" id="search"  autocomplete="off" placeholder="请输入检测点名称">
					<input type="button" onclick="queryByFocus();"   class="cs-search-btn cs-fl" href="javascript:;" value="搜索">
				</div>
			</div>
		</div>
		<div class="stock_info">
		<!--左侧检测点列表-->
		<ul id="type">

        </ul>
        </div>
	</div>

	<div data-options="region:'north',border:false" style="top: 0px; border: none;">
		<div>
			<!-- 面包屑导航栏  开始-->
			<ol class="cs-breadcrumb">
				<li class="cs-fl"><img src="${webRoot}/img/set.png" alt="" /><a href="javascript:">视频监控</a></li>
				<li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
				<li class="cs-b-active cs-fl">监控管理</li>
			</ol>
			<!-- 面包屑导航栏  结束-->
			<div class="cs-search-box cs-fl choseStatus cs-hide">
				<span class="check-date cs-fl"><span class="cs-name" style="padding-right: 0px;">状态：</span>
					<span class="cs-input-style " style="margin-left: 0px;">
						<select type="text" name="onlineStatus" class="focusInput" id="choseOnlineStatus" onchange='choseOnlineStatus()' autocomplete="off" style="width: 80px" >
							<option value="">全部</option>
							<option value="1" selected="selected">在线</option>
							<option value="0">离线</option>
							<option value="-2">未配置</option>
							<option value="-1">异常</option>
						</select>
					</span>
				</span>
			</div>
			<div class="cs-tab-icon clearfix cs-fr">
			<ul class="tab-options">
				<li><a class="icon iconfont icon-tubiao active"></a></li>
				<li><a class="icon iconfont icon-liebiao"></a></li>
			</ul>
		</div>
		<div class="cs-search-box cs-fr">
			<div class="clearfix" id="showBtn">

			</div>
        </div>
		</div>
	</div>

	<div data-options="region:'center',split:false">
		<div id="videoPoint" class="text-center" style="font-size: 20px; line-height: 30px; margin-top: 10px;">
			<i class="icon iconfont icon-shexiangtou text-primary" style="font-size: 22px"></i>
			<span class="pointName">${bean.pointName}</span>
		</div>
	 	<div class="cs-col-lg-table cs-tab-box cs-on styleDiv">
	        <div id="playercontainer" ></div>
	        <div id="playercontainerlive"></div>
	        <div id="playercontainerDingZhi"></div>
        </div>
		<!-- 列表搜索条件 -->
		<div class="cs-tab-box">
		<input type="hidden" class="focusInput" name="departId">
		<div id="dataList"></div>
		</div>
	</div>
	
	<!-- 大弹窗 -->
	<div class="cs-modal-box cs-hide">
		<div class="cs-col-lg clearfix" style="position: absolute;left: 0;right: 0;top: 0;z-index: 1000;">
            <div class="cs-tab-icon clearfix cs-fl">
				<ul>
					<li><a class="icon iconfont icon-shipin active"></a></li>
					<li><a class="icon iconfont icon-huifang1"></a></li>
				</ul>
			</div>
            <div class="cs-search-box cs-fr">
				<div class="cs-fr cs-ac ">
					<a onclick="returnBack();" class="cs-monitor-close cs-menu-btn"><i class="icon iconfont icon-fanhui"></i>返回</a>
				</div>
			</div>
          </div>
           <!-- 列表 -->
          <div class="cs-col-lg-table cs-tab-box cs-hide">
            <div class="cs-table-responsive">
                <div class="play-back">
                  <div class="play-left-nav">
                    <h4>时间列表</h4>
                    <div class="play-list">
                      <ul>
                        <li class="play1"><i>1</i> <i class="pull-right">2018-8-22 13:26:40</i></li>
                        <li class="play2"><i>2</i> <i class="pull-right">2018-8-22 13:26:40</i></li>
                        <li><i>3</i> <i class="pull-right">2018-8-22 13:26:40</i></li>
                        <li><i>4</i> <i class="pull-right">2018-8-22 13:26:40</i></li>
                        <li><i>5</i> <i class="pull-right">2018-8-22 13:26:40</i></li>
                      </ul>
                    </div>
                  </div>
                  <div class="play-right-video">
                   <!--  <video src="../2.mp4" class="video-player" controls="controls">
                      
                    </video> -->
                  </div>
                </div>
            </div>
          </div>
	</div>
	
	<!-- Modal 3 大-->
	<form id="saveForm" action="${webRoot}/video/surveillance/saveVideo" autocomplete="off">
		<div class="modal fade intro2" id="addModal" role="dialog" aria-labelledby="myModalLabel">
			<div class="modal-dialog cs-mid-width" role="document">
				<div class="modal-content ">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
						<h4 class="modal-title" id="myModalLabel">监控设备</h4>
					</div>
					<div class="modal-body cs-mid-height">
						<!-- 主题内容 -->
						<div class="cs-tabcontent">
							<div class="cs-content2">
								<table class="cs-add-new">
								<input type="hidden" name="id">
								<input type="hidden" name="departId">
								<input type="hidden" name="pointId">
								<input type="hidden" name="onlineStatus" value="1" />
									<!-- <tr>
										<td class="cs-name"><font color="#FF0000">*</font>所属机构：</td>
										<td class="cs-in-style">
											<div class="cs-all-ps">
												<div class="cs-input-box">
													<input type="hidden" name="id">
													<input type="text" name="departPName" readonly="readonly" datatype="*" ignore="ignore" nullmsg="请选择所属机构" errormsg="请选择所属机构">
													<input type="hidden" name="departPid" datatype="*" ignore="ignore" nullmsg="请选择所属机构" errormsg="请选择所属机构">
													<div class="cs-down-arrow"></div>
												</div>
												<div class="cs-check-down cs-hide" style="display: none;">
													<ul id="myDeaprtTree" class="easyui-tree"></ul>
												</div>
											</div>
										</td>
									</tr>
									<tr>
										<td class="cs-name"><font color="#FF0000">*</font>所属检测点：</td>
										<td class="cs-in-style">
											<select id="pointSelect" name="pointId"  datatype="*" nullmsg="请选择所属检测点" errormsg="请选择所属检测点">
												<option value="">请选择</option>
											</select>
										</td>
									</tr> -->
									<tr>
										<td class="cs-name" style="width:200px;">检测室：</td>
										<td class="cs-in-style">
											<input type="text" name="pointName" readonly style="background: #fafafa;"  />
										</td>
									</tr>
									<tr>
										<td class="cs-name" style="width:200px;">监控类型：</td>
										<td class="cs-in-style">
											<select id="camera" name="videoType" datatype="*" nullmsg="请选择监控类型" errormsg="请选择监控类型">
												<%--<option value="">请选择</option>--%>
												<option value="0">乐橙API</option>
												<option value="1">乐橙云</option>
<!-- 												<option value="2">内网</option> -->
												<option value="3">萤石API</option>
												<option value="4">萤石云</option>
<%--												<option value="5">海康威视直播（定制）</option>--%>
<%--												<option value="6">海康威视回放（定制）</option>--%>
											</select>
										</td>
									</tr>
									
								</table>

							 	<table class="cs-add-new cs-lecheng">
							 	<tr>
										<td class="cs-name" style="width:200px;"><font color="#FF0000">*</font>乐橙账号：</td>
										<td class="cs-in-style">
											<select name="accountPhone" id="chooseUseraccount" ><!-- onchange="changeUserPhone();" -->
												<c:forEach items="${monitorConfig}" var="entry">
													<option value="${entry.key }">${entry.key }</option>
												</c:forEach>
											</select>
										</td>
									</tr>
							 		<tr>
										<td class="cs-name" style="width:200px;"><font color="#FF0000">*</font>设备序列号：</td>
										<td class="cs-in-style">
											<input type="text" name="dev" id="devNo" datatype="*" onkeyup="this.value=this.value.toUpperCase()"  nullmsg="请输入设备序列号" errormsg="请输入设备序列号"/>
											<span class="channelNumbers" style="color: #aaa;"></span>
											<input type="hidden" name="param1"  />
										</td>
									</tr>
								</table>

							 	<table class="cs-add-new cs-yingshi cs-hide">
									<tr>
										<td class="cs-name"  style="width:200px;"><font color="#FF0000">*</font>AppKey：</td>
										<td class="cs-in-style">
											<input type="text" name="userName" ignore="ignore" datatype="*" nullmsg="请输入AppKey" errormsg="请输入AppKey">
										</td>
									</tr>
									 <tr>
										<td class="cs-name"  style="width:200px;"><font color="#FF0000">*</font>Secret：</td>
										<td class="cs-in-style">
											<input type="text" name="pwd" ignore="ignore" datatype="*" nullmsg="请输入Secret" errormsg="请输入Secret" >
										</td>
									</tr>
                                    <%--
									<tr>
										<td class="cs-name" style="width:200px;"><font color="#FF0000">*</font>设备序列号：</td>
										<td class="cs-in-style">
											<input type="text" name="dev" datatype="*" nullmsg="请输入设备序列号" errormsg="请输入设备序列号"/>
										</td>
									</tr>
                                    --%>
								</table>

								<table class="cs-neiwang cs-add-new cs-hide">
									<tr>
										<td class="cs-name cs-neiwang"  style="width:200px;"><font color="#FF0000">*</font>视频URL：</td>
										<td class="cs-in-style">
											<input type="text" name="videoUrl" datatype="*" nullmsg="视频URL" errormsg="视频URL" ignore="ignore" disabled="disabled">
										</td>
									</tr>
								</table>

								<table class="cs-add-new">
									<tr>
										<td class="cs-name"><font color="#FF0000">*</font>设备名称：</td>
										<td class="cs-in-style">
											<input type="text" name="surveillanceName" datatype="*" nullmsg="请输入设备名称">
										</td>
									</tr>
									<tr>
										<td class="cs-name"  style="width:200px;">自动播放：</td>
										<td class="cs-al cs-modal-input" style="padding-top: 6px;">
											<input id="cs-check-radio" type="radio" value="1" name="autostart" checked="checked"/><label for="cs-check-radio">是</label>
											<input id="cs-check-radio2" type="radio" value="0" name="autostart" /><label for="cs-check-radio2">否</label>
										</td>
									</tr>
									<!-- <tr>
										<td class="cs-name" style="width:200px;">排序：</td>
										<td class="cs-in-style">
											<input type="text" name="sorting">
										</td>
									</tr> -->
								</table>
							</div>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-success" id="btnSave">确定</button>
						<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					</div>
				</div>
			</div>
		</div>
	</form>
	
	<!-- 引用模态框 -->
	<%@include file="/WEB-INF/view/common/confirm.jsp"%>
	<%@include file="/WEB-INF/view/detect/depart/selectDepartModel.jsp"%>
	<!-- 下拉插件 -->
	<script src="${webRoot}/js/select/tabcomplete.min.js"></script>
	<script src="${webRoot}/js/select/livefilter.min.js"></script>
	<script src="${webRoot}/js/select/bootstrap-select.js"></script>
	<script src="${webRoot}/js/select/filterlist.js"></script>
	<script src="${webRoot}/plug-in/player/cyberplayer.js"></script>
	<script src="${webRoot}/js/datagridUtil2.js"></script>
	<%@include file="/WEB-INF/view/common/modalBox.jsp"%>
	<script type="text/javascript">
		var  departId=${report.departId};
		var resetId;//重置校准时间的ID
		$(document).on("click", "#departName", function(){
			$('#myDepartModal').modal('toggle');
		});
		var dgu;
		var queryType =1;//查看类型：0 离线，1在线，-1设备号异常,-2未配置，'' 全部，默认为1 在线
				$(function(){
			dgu = datagridUtil.initOption({
				tableId : "dataList", //列表ID
				funColumnWidth:"80px",
				tableAction : "${webRoot}/video/surveillance/datagrid.do", //加载数据地址
				defaultCondition: [{			//附加请求参数
					queryCode: "pointId", 				//参数名
					queryVal: ""						//参数值
				}],
				onload: function(rows, pageData){
					//加载列表后执行函数
					$(".rowTr").each(function(){
						for(var i=0;i<rows.length;i++){
							if($(this).attr("data-rowId") == rows[i].id){
								if(rows[i].videoType!=0 || rows[i].onlineStatus==-1){
									//隐藏校准时间和回放按钮
									$(this).find(".1475-10").hide();
									$(this).find(".1475-11").hide();
								}
							}
						}
					});
				},
				parameter : [ //列表拼接参数
					{
						columnCode : "pointName",
						columnName : "检测室",
						columnWidth : "20%",
					},{
						columnCode : "surveillanceName",
						columnName : "设备名称",
						columnWidth : "20%",
					},{
						columnCode : "dev",
						columnName : "设备序列号",
						columnWidth : "20%",
					},{
						columnCode : "videoType",
						columnName : "监控类型",
						columnWidth : "10%",
						customVal: {"0":"乐橙API","1":"乐橙云","3":"萤石云API","4":"萤石云","5":"海康威视直播（定制）","6":"海康威视回放（定制）"}
					},  {
						columnCode : "param1",
						columnName : "通道数量",
						columnWidth : "80px",
					},  {
						columnCode : "onlineStatus",
						columnName : "状态",
						columnWidth : "80px",
						customVal: {"0":"<i title='#syncStatusDate#'>离线</i>","1":"<i title='#syncStatusDate#'>在线</i>","-1":"<i title='请检查设备号是否绑定在对应的账户下'>异常</i>","default":""}

					},
					/*{
                        columnCode : "dev",
                        columnName : "设备序列号",
                        columnWidth : "20%",
                    }, {
                        columnCode : "accountPhone",
                        columnName : "乐橙手机号码",
                        columnWidth : "120px",
                    },
					{
						columnCode : "registerDate",
						columnName : "注册时间",
						columnWidth : "20%",
					}*/ ],
				funBtns : [{
					show : Permission.exist("1475-7"),
					style : Permission.getPermission("1475-7"),
					action : function(id) {
						editVideo(id);
					}
				},
					/* {
                        show : Permission.exist("1475-6"),	//视频回放
                        style : Permission.getPermission("1475-6"),
                        action : function(id) {
                            location.href="${webRoot}/data/lawInstrument/viewPlayBack?id="+id+"&type=2";
                }
            },  */
					{//校准设备时间
						show : Permission.exist("1475-10"),
						style : Permission.getPermission("1475-10"),
						action : function(id) {
							resetId=id;
							$("#confirmModal .tips").text("确认校准摄像头时间吗？");
							$("#confirmModal").modal('toggle');
						}
					},{//本地录像回放
						show : Permission.exist("1475-11"),
						style : Permission.getPermission("1475-11"),
						action : function(id) {
							//TODO
							showMbIframe('${webRoot}/video/surveillance/replayBack?id='+id);
						}
					},{
						show : Permission.exist("1475-6"),
						style : Permission.getPermission("1475-6"),
						action : function(id) {
							if(id == ''){
								$("#confirm-warnning .tips").text("请选择监控摄像头");
								$("#confirm-warnning").modal('toggle');
							}else{
								deleteIds = id;
								$("#confirm-delete").modal('toggle');
							}
						}
					}],
				bottomBtns : [//底部按钮
					{
						show : Permission.exist("1475-6"),
						style : Permission.getPermission("1475-6"),
						action : function(ids) {
							if(ids == ''){
								$("#confirm-warnning .tips").text("请选择监控摄像头");
								$("#confirm-warnning").modal('toggle');
							}else{
								deleteIds = ids;
								$("#confirm-delete").modal('toggle');
							}
						}
					} ]
			});
			$('#surveillanceNameChose').select2();
			//初始化加载检测点
			loadPoints(${report.departId},queryType);
		});
		//选择机构，执行查询检测点操作
		function selDepart(id, text){
			$('#myDepartModal').modal('toggle');
			departId=id;
			$("#departId").val(id);
			$("input[name='departName']").val(text);
			$("input[name='departName']").attr("title",text);
			$(".cs-check-down").hide();
			loadPoints(id,queryType);
		}
		function choseOnlineStatus(){
			queryType = $("#choseOnlineStatus option:selected").val();//获取被选中的仪器类型
			loadPoints(departId,queryType);
		}
		//根据机构Id查询检测点
		function loadPoints(departId,queryType){
			$.ajax({
				url: "${webRoot}/video/surveillance/selectPointByDepartId.do",
				type: "POST",
				data: {
					"departId": departId,
					"queryType":queryType
				},
				dataType: "json",
				success: function (data) {
					dealHtml(data.obj);
				},
				error: function () {
					$("#waringMsg>span").html("操作失败");
					$("#confirm-warnning").modal('toggle');
				}
			})
		}
		//拼接左侧检测点列表
		function dealHtml(data){
			var htmlStr = "";
			$("#type").empty("");
			if(data=="") {
				$("#showBtn").addClass("cs-hide");
				$("#type").append(htmlStr);
				$(".pointName").html(htmlStr);
				$("#playercontainer").addClass("cs-hide");
			}else{
				$("#showBtn").removeClass("cs-hide");
				$("#playercontainer").removeClass("cs-hide");
				var json = eval(data);
				$.each(json, function(index, item) {
					htmlStr+='<li name="type" data-type='+item.id+' data-pointName='+item.pointName+' data-departId='+item.departId+' onclick="selectPoint(this)" >';
					htmlStr+='<div class="title"><a href="javascript:;" title='+item.pointName+'>';

					if(item.pointId && (item.videoType || item.videoType == 0) && item.videoType != 6 && item.onlineStatus==1){//在线
						htmlStr+= '<i style="padding-left: 2px" class="icon iconfont icon-shexiangtou text-primary" title="在线"></i>' + item.pointName;
					}else if(item.pointId && item.onlineStatus==0) {//离线
						htmlStr+= '<i style="padding-left: 2px" class="icon iconfont icon-shexiangtou text-gray" title="离线"></i>' + item.pointName;
					}else if(item.pointId && item.onlineStatus==-1){
						htmlStr+= '<i style="padding-left: 2px" class="icon iconfont icon-shexiangtou text-danger" title="异常"></i>' + item.pointName;
					}else{
						htmlStr+= '<i style="padding-left: 2px;padding-right: 2px;" class="icon iconfont icon-wuuiconsuoxiao text-gray" title="未配置"></i>' + item.pointName;
					}
					htmlStr+=' </a></div><div class="arrow"><i class="icon iconfont icon-you"></i></div></li>';
				});
				$("#type").append(htmlStr);
				//默认选中第一个检测点并加载摄像头数据
				if(htmlStr!=""){
					$("#type li:first-child").addClass("active");//第一次进来就默认选中第一个
					var id = $("#type li:first-child").data("type");
					$("#pointId").val(id);
					var pointName= $("#type li:first-child").attr("data-pointName")
					$(".pointName").html(pointName);
					dgu.addDefaultCondition("pointId", id);
					dgu.queryByFocus();
					playVedio(id);
				}
			}
		}
		//重置乐橙云摄像头的设备时间
		function confirmModal(){
			$.ajax({
				url: "${webRoot}/video/surveillance/resetDeviceTime.do",
				type: "POST",
				data: {
					"id": resetId,
				},
				dataType: "json",
				success: function (data) {
					if(!data.success){
						$("#waringMsg>span").html("操作失败,"+data.msg);
						$("#confirm-warnning").modal('toggle');
					}
				},
				error: function () {
					$("#waringMsg>span").html("操作失败");
					$("#confirm-warnning").modal('toggle');
				}
			})
		}
	</script>
    <script type="text/javascript">
		var player;
		var tabOptions="tubiao";
		var vedioRootPath="${webRoot}/plug-in/imouPlayer/static/";//轻应用插件static路径，imouplayer.js中引入statis中的js文件时使用
	//     $("#chooseUseraccount option:first").prop("selected","selected");//设置第一个手机号被选中
	//     changeUserPhone();
			//新增标签
		if(Permission.exist("1475-5")){
			$("#showBtn").append('<a class="cs-menu-btn" href="javascript:;" onclick="editVideo(0)"><i class="'+Permission.getPermission("1475-5").functionIcon+'"></i>新增</a>');
		}
		//摄像头状态查看权限
		if(Permission.exist("1475-9")){
			$(".choseStatus").removeClass("cs-hide");
		}


		//根据检测点ID查询摄像头设备信息以及轻应用播放kitTokenStr
		function playVedio(pointId){
			// 添加DOM容器
			if(player){
				player.destroy();
			}
			player = new ImouPlayer('#playercontainer');
			$("#playercontainerlive").html("");
			$("#playercontainerDingZhi").html("");
			$("#playercontainerDingZhi").addClass("cs-hide");
			$("#myPlayer").html("");
        	var urlArr = [];
            var urlStr="";
            var kitTokenStr="";
            $.ajax({
                url:'${webRoot}/video/surveillance/selectDeviceForImouPlayer?pointId='+pointId,
                async:false,
                success:function(data){
                    var kitTokenMap=data.attributes;
                    let flag1= false;
                    let multiScreen=0;
					var liveBroadArray=[];
                    if(data.obj.length>0){
                    	//萤石云API
                    	//var liveBroadArray4=new Array();
	                    for (var i = 0; i < data.obj.length; i++) {
							if(data.obj[i].accountPhone!="" && data.obj[i].videoType==0){
								//直播地址示例为: imou://open.lechange.com/deviceId/channelId/type?streamId=1  deviceId:设备序列号,channelId:设备通道号,type:播放类型： 1 直播（实时预览）； 2 云存储录像回放；streamId:清晰度： 0 高清 ；1 标清；
								//多个URL用%隔开，多个kitToken用%隔开
								for(let j = 0; j < data.obj[i].param1; j++){
									multiScreen++;
								    urlStr+="imou://open.lechange.com/"+data.obj[i].dev+"/"+j+"/1?streamId=0%";
								   getKitToken(data.obj[i].accountPhone,data.obj[i].dev,j);
									kitTokenStr+=kitToken+"%";
								}
								if(!flag1){
									flag1=data.obj[i].autostart==1 ? true : false
								}
							}else if(data.obj[i].videoUrl!="" && data.obj[i].videoType==3){
							    var urls = data.obj[i].videoUrl.split(",");
							    $.each(urls, function (index, item) {
                                    var copy = data.obj[i];
                                    copy.videoUrl = item;
                                    liveBroadArray.push(copy);
                                });

								//liveBroadArray4.push(data.obj[i]);

							//海康威视直播定制
							}else if(data.obj[i].videoUrl!="" && data.obj[i].videoType==5){
							    var urls = data.obj[i].videoUrl.split(",");
							    $.each(urls, function (index, item) {

									let ifr = document.createElement("iframe");
									ifr.src = item;
									$("#playercontainerDingZhi").removeClass("cs-hide");
									document.getElementById("playercontainerDingZhi").appendChild(ifr);

                                });

							}else if (data.obj[i].videoType != 6){
								liveBroadArray.push(data.obj[i]);
							}
	                    }
	                    // console.log("urlStr:"+urlStr);
	                    // console.log("kitTokenStr:"+kitTokenStr);
	                    
	                    if(urlStr!=""){
	                    	$("#playercontainer").addClass("playerVedio");
	                    	var width = $('#playercontainer').clientWidth;
		                    var height = parseInt(width * 9 / 16);
		                    urlStr=urlStr.substr(0,urlStr.lastIndexOf("%"));
		                    kitTokenStr=kitTokenStr.substr(0,kitTokenStr.lastIndexOf("%"));
		                    const urlArr = [];
		                    urlStr.split('%').forEach(function(item, index) {
		                      const obj = {
		                        url: item,
		                        kitToken: kitTokenStr.split('%')[index]
		                     };
		                      urlArr.push(obj)
		                    });
		                    player.setup({
		                    	  src: urlArr, // 播放地址
		                    	  width: width, // 播放器宽度
		                    	  height: height, // 播放器高度
		                    	  poster: '${webRoot}/img/video_bg_new.png', // 封面图url  ${webRoot}/img/video_bg_new.png
		                    	  autoplay: flag1, // 是否自动播放
		                    	  controls: true, // 是否展示控制栏
		                    	});
		                 // 设置多屏
		                    setTimeout(function(){
								if(multiScreen==1){
		                    		
		                    	}else if(multiScreen==2){
		                    		player.setMultiScreen(2);
		                    	}else if(multiScreen<=4){
		                    		player.setMultiScreen(4);
		                    	}else if(multiScreen<=9){
		                    		player.setMultiScreen(9);
		                    	}
		                    	
			        		},1000); 
						}else{
							$("#playercontainer").removeClass("playerVedio");
						}
					}
                    /*
                    for (var j=0; j<liveBroadArray4.length; j++) {
                    	$(".styleDiv").append("<div id='playWind"+j+"' class='playWind'></div>");
                    	var ll = liveBroadArray4[j].videoUrl.split(",").length;
                    	if (!ll || ll<=1) {
							ll = 1;
						} else if (ll<=4){
                    		ll = 4;
						} else {
                    		ll = 9;
						}
						var decoder = new EZUIKit.EZUIPlayer({
							id: 'playWind'+j,
							autoplay: true,
							url: liveBroadArray4[j].videoUrl,
							accessToken: liveBroadArray4[j].token,
							decoderPath: '.${webRoot}/plug-in/EZUIKit-JavaScript/',
							width: 1200,
							height: 800,
							splitBasis: ll, // 1*1 2*2 3*3 4*4
						});
                    	if(liveBroadArray4[j].autostart == '1'){
							decoder.play({});
						}
					}
                    */
                 	//处理直播方式播放窗口
                    if(liveBroadArray.length>0){
                    	$("#playercontainerlive").addClass("playerVedio");
                    	var wids=0;
                        var heis=0;
                        if(liveBroadArray.length>=2){
                            wids='48%';
                            heis=300;
                            $('.styleDiv').css("text-align","left")
                        }else if(liveBroadArray.length<2){
                            wids=640;
                            heis=480;
                            $('.styleDiv').css("text-align","center")
                        }
                    	for(let j=0;j<liveBroadArray.length;j++){
                    		 $("#playercontainerlive").append("<div class='video-player-box' id='_player_"+liveBroadArray[j].id+"'></div>");
                    		let flag= liveBroadArray[j].autostart==1 ? true : false;
                    		 cyberplayer("_player_"+liveBroadArray[j].id).setup({
                                 width: wids, // 宽度，也可以支持百分比（不过父元素宽度要有）
                                 height: heis, // 高度，也可以支持百分比
                                 title: liveBroadArray[j].surveillanceName, // 标题
                                 isLive: true, // 必须设置，表明是直播视频
                                 file: liveBroadArray[j].videoUrl, // //您的视频源的地址（目前是乐橙示例播放地址）
                                 image: "${webRoot}/${systemVideoBg}", // 预览图
                                 autostart: flag, // 是否自动播放
                                 stretching: "uniform", // 拉伸设置
                                 repeat: false, // 是否重复播放
                                 volume: 100, // 音量
                                 controls: true, // 是否显示控制栏
                                 hls: {
                                     reconnecttime: 5 // hls直播重连间隔秒数
                                 },
                                 ak: "39f82ac87fc3462ea4dcc78734450f57" // 百度智能云平台注册（https://cloud.baidu.com）即可获得accessKey
                             })
                    	}
                    }else{
                    	$("#playercontainerlive").removeClass("playerVedio");
                    }
                }
            });
		}

		function checkFullScreen() {
			var isFull = document.webkitIsFullScreen || document.mozFullScreen || document.msFullscreenElement || document.fullscreenElement;
			if (isFull == null || isFull == undefined) {
				isFull = false;
			}
			return isFull;
		}

		//使用
		window.onresize = function () {
			if(checkFullScreen()) {
				// console.log('全屏状态')
			} else {
				$('.playerVedio').height(480);
				$('.styleDiv').width(800);
				// console.log('缩小状态')
			}
		}

        //根据关键字和机构ID查询检测点
		function queryByFocus(){
            $.ajax({
                url: "${webRoot}/video/surveillance/selectPointByDepartId.do",
                type: "POST",
                data: {
                	"departId":departId,
					"queryType":queryType,
                    "pointName": $("#pointName").val()
                },
                dataType: "json",
                success: function (data) {
                    $("[name=type]").remove();
					dealHtml(data.obj);
                },
                error: function () {
                    $("#waringMsg>span").html("操作失败");
                    $("#confirm-warnning").modal('toggle');
                }
            })
        }

		//乐橙云轻应用直播插件获取kitToken
		var kitToken="";
		function getKitToken(accountPhone,dev,channelId){
			$.ajax({
				url: "${webRoot}/video/surveillance/getKitToken.do",
				type: "POST",
				data: {
					"accountPhone":accountPhone,
					"dev": dev,
					"channelId": channelId,
				},
				dataType: "json",
				async:false,
				success: function (data) {
					if(data.success){
						kitToken=data.obj;
					}else{
						$("#waringMsg>span").html(data.msg);
						$("#confirm-warnning").modal('toggle');
					}
				},
				error: function (data) {
					$("#waringMsg>span").html("操作失败"+data.msg);
					$("#confirm-warnning").modal('toggle');
				}
			})
		}
        //回车查询数据
        document.onkeydown=function(event){
            var e = event || window.event || arguments.callee.caller.arguments[0];
            if(e && e.keyCode==13){ //enter键
                var focusedElement = document.activeElement;//当前关键词元素
                if(focusedElement && focusedElement.className){
                    queryByFocus();
                }
                return false;
            }
        }
        function selectPoint(obj) {
            $.each($("li[name='type']"), function (index, item) {
                $(item).attr("class", "");
            });
            var id = $(obj).data("type");
            $("#pointId").val(id);
			var pointName=$(obj).data("pointname");
			$(".pointName").html(pointName);
			dgu.addDefaultCondition("pointId", id);
            $(obj).addClass("active");
            dgu.queryByFocus();
            playVedio(id);
           
        }
        $(document).ready(function() {
            $(".cs-tab-icon li").click(function() {
                $(".cs-tab-icon li").eq($(this).index()).children('a').addClass("active").parent('li').siblings().children('a').removeClass('active');
                $(".cs-tab-box").hide().eq($(this).index()).show();

                if($(this).children('a').hasClass('icon-tubiao')){
//                     $('#showBtn').css('display','none')
                	tabOptions="tubiao";
					player.play();
					$("#videoPoint").removeClass("cs-hide");
                }else{
                	tabOptions="liebiao";
                	player.stop();
                	$("#videoPoint").addClass("cs-hide");
                    $('#showBtn').css('display','block')
                }
            });
        });

        $(document).ready(function($) {
            if($('.play-right-video .video-player-box').length=='1'){
                $('.play-right-video').css('text-align','center')
            }else{
                $('.play-right-video').css('text-align','left')
            }
        });

        $("#camera").on("change",function(){
			changeVideoType();
        });
        
        function changeVideoType() {
			//轻应用套件
			if ($("#camera").val() == '0') {
				$('.cs-neiwang').hide();
				$('.cs-yingshi').hide();
				$('.cs-lecheng').show();

				$('.cs-lecheng input').removeAttr("ignore");
				$('.cs-neiwang input').attr("ignore","ignore");
				$('.cs-yingshi input').attr("ignore","ignore");
				$('.cs-lecheng input').removeAttr("disabled");
				$('.cs-neiwang input').attr("disabled","disabled");
				$('.cs-yingshi input').attr("disabled","disabled");

			//H5直播方式
			} else if($("#camera").val() == '1' || $("#camera").val() == '4'){
				$('.cs-lecheng').hide();
				$('.cs-yingshi').hide();
				$('.cs-neiwang').show();

				$('.cs-neiwang input').removeAttr("ignore");
				$('.cs-lecheng input').attr("ignore","ignore");
				$('.cs-yingshi input').attr("ignore","ignore");
				$('.cs-neiwang input').removeAttr("disabled");
				$('.cs-lecheng input').attr("disabled","disabled");
				$('.cs-yingshi input').attr("disabled","disabled");

			//萤石云API
			} else if($("#camera").val() == '3'){
				$('.cs-lecheng').hide();
				$('.cs-neiwang').hide();
				$('.cs-yingshi').show();

				$('.cs-yingshi input').removeAttr("ignore");
				$('.cs-lecheng input').attr("ignore","ignore");
				$('.cs-neiwang input').attr("ignore","ignore");
				$('.cs-yingshi input').removeAttr("disabled");
				$('.cs-lecheng input').attr("disabled","disabled");
				$('.cs-neiwang input').attr("disabled","disabled");

			//海康威视（定制）
			} else if($("#camera").val() == '5' || $("#camera").val() == '6'){
				$('.cs-lecheng').hide();
				$('.cs-yingshi').hide();
				$('.cs-neiwang').show();

				$('.cs-neiwang input').removeAttr("ignore");
				$('.cs-yingshi input').attr("ignore","ignore");
				$('.cs-lecheng input').attr("ignore","ignore");
				$('.cs-neiwang input').removeAttr("disabled");
				$('.cs-yingshi input').attr("disabled","disabled");
				$('.cs-lecheng input').attr("disabled","disabled");
			}
		}

       
        //验证
		var saveForm = $("#saveForm").Validform({
			beforeSubmit: function(data){
				if($("#camera").val()=="0" || $("#camera").val()=="3"){
					$("#saveForm input[name=videoUrl]").val("");
				}else{
					$("#saveForm input[name=dev]").attr("ignore","ignore");
					$("#saveForm input[name=dev]").val("");
				}
				$("#saveForm input[name=pointId]").val($("#type").find(".active").attr("data-type"));
				$("#saveForm input[name=departId]").val($("#type").find(".active").attr("data-departId"));
				var formData = new FormData($('#saveForm')[0]);
				$.ajax({
					type : "POST",
					url : "${webRoot}/video/surveillance/saveVideo.do",
					data : formData,
					contentType : false, //必须false才会避开jQuery对 formdata 的默认处理 XMLHttpRequest会对 formdata 进行正确的处理
					processData : false, //必须false才会自动加上正确的Content-Type
					dataType : "json",
					success : function(data) {
						if (data && data.success) {
							$("#addModal").modal('toggle');
							//重新加载左侧检测点列表，并默认播放第一个视频
							loadPoints(departId,queryType);
							if(tabOptions=="tubiao" && queryType==1){
								 playVedio($("#type").find(".active").attr("data-type"));
							}
							if(queryType!="-2"){//只要不是未配置状态，则刷新右侧数据列表
								dgu.queryByFocus();
							}
						} else {
							$("#confirm-warnning .tips").text("保存失败");
							$("#confirm-warnning").modal('toggle');
						}
					}
				});
				return false;
			}
		});

        //关闭编辑模态框前重置表单，清空隐藏域
        $('#addModal').on('hidden.bs.modal', function (e) {
            $("#saveForm").Validform().resetForm();
            $("#saveForm input[name=id]").val("");
			$(".channelNumbers").html("");
//             $("#surveillanceNameChose").select2("val", " ");
            $("#camera option").each(function (){
                $(this).attr("selected",false);
            });
            changeVideoType();
        });

        // 新增或修改
        $("#btnSave").on("click", function() {
            saveForm.submitForm();
        });

        function editVideo(id) {
			$("#saveForm input[name=pointName]").val($("#type").find(".active").attr("data-pointName"));
            if (id) {
                $.ajax({
                    url:'${webRoot}/video/surveillance/edit?id='+id,
                    success:function(data){
                        if(data.obj){
                            $("#saveForm input[name=id]").val(data.obj.id);
//                             $("#saveForm input[name=departPName]").val(data.obj.departName);
//                             $("#saveForm input[name=departPid]").val(data.obj.departId);
//                             changePoint(data.obj.departId);
//                             $("#saveForm select[name=pointId]").val(data.obj.pointId);
//                             $("#surveillanceNameChose").val([data.obj.surveillanceName]).trigger('change');
							$("#saveForm input[name=surveillanceName]").val(data.obj.surveillanceName);
                            $(".channelNumbers").html("通道数量("+data.obj.param1+")");
                            $("#saveForm input[name=videoUrl]").val(data.obj.videoUrl);
                            $("#saveForm input[name=ip]").val(data.obj.ip);
                            $("#saveForm input[name=dev]").val(data.obj.dev);
                            $("#saveForm select[name=accountPhone]").val(data.obj.accountPhone);
                            $("#saveForm input[name=param1]").val(data.obj.param1);
                            $("#saveForm input[name=userName]").val(data.obj.userName);
                            $("#saveForm input[name=pwd]").val(data.obj.pwd);
                            $("#saveForm input[name=sorting]").val(data.obj.sorting);
							$("#saveForm input[name=onlineStatus]").val(data.obj.onlineStatus);
                            $("#camera").val(data.obj.videoType);
							changeVideoType();
                            $("[name=autostart][value="+data.obj.autostart+"]").prop("checked","checked");

                        }
                    }
                });
            }
            $("#addModal").modal('toggle');
        }

        //重写确认模态框函数
        var deleteIds;
        function deleteData(){
            var idsStr = "{\"ids\":\""+deleteIds.toString()+"\"}";
            $.ajax({
                type: "POST",
                url: '${webRoot}'+"/video/surveillance/delete.do",
                data: JSON.parse(idsStr),
                dataType: "json",
                success: function(data){
                    if(data && data.success){
                        //删除成功后刷新列表
                        dgu.query();
                    }else{
                        $("#confirm-warnning .tips").text(data.msg);
                        $("#confirm-warnning").modal('toggle');
                    }
                }
            });
            $("#confirm-delete").modal('toggle');
        }
        $(document).ready(function(){

            if($('.play-center .video-player-box').length==1){
                $('.video-player-box').css('width','80%')
                $('.play-center').css('text-align','center')
            }
            var videoW = $('.video-player-box').width();
            $('.video-player-box').height(videoW/16*9);
        });
        // 新增或修改
        $("#devNo").on("blur", function() {
        	let phone=$("#chooseUseraccount").val();
        	let devNo=$("#devNo").val()
        	if(phone==""){
        		
        	}else if(devNo==""){
        		
        	}else{
        		$.ajax({
                    type: "POST",
                    url: '${webRoot}'+"/video/surveillance/selectDeviceNo.do",
                    data: {"phone":phone,"dev":devNo},
                    dataType: "json",
                    success: function(data){
                    	 $("#saveForm input[name=surveillanceName]").val("");
                        if(data && data.success){
                     	   	var json=eval(data.obj.result);
                     	   $("#saveForm input[name=surveillanceName]").val(json.data.devices[0].channels[0].channelName);
                     	   $(".channelNumbers").html("通道数量("+json.data.devices[0].channels.length+")");
                        	 $("#saveForm input[name=param1]").val(json.data.devices[0].channels.length);
                        }else{
                        	// console.log(data.msg);
                        	$("#saveForm input[name=dev]").val("");
                            $("#confirm-warnning .tips").text("请输入正确的设备序列号");
                            $("#confirm-warnning").modal('toggle');
                        }
                    }
                })
        	}
        	
        });
        //所属机构树
      /*
      var treeLoadTimes = 1; //控制获取顶级树
        var topNodeId = '';
        var topNodeText = '';
        $('#myDeaprtTree').tree({
            checkbox : false,
            url : '${webRoot}' + "/detect/depart/getDepartTree.do",
            animate : true,
            onClick : function(node) {
                $('#addModal').find("input[name='departPid']").val(node.id);
                $('#addModal').find("input[name='departPName']").val(node.text);
                $(".cs-check-down").hide();
                changePoint(node.id);
            },
            onLoadSuccess : function(node, data) {
                //设置新增所属机构为当前用户所属机构
                if (treeLoadTimes == 1) {
                    treeLoadTimes++;
                    var topNode = $('#myDeaprtTree').tree('getRoot');
                    topNodeId = topNode.id;
                    topNodeText = topNode.text;
                    $('#addModal').find("input[name='departPid']").val(topNode.id);
                    $('#addModal').find("input[name='departPName']").val(topNode.text);

					changePoint(topNodeId);
                }
            }
        });

        function changePoint(departId){
            $.ajax({
                url:'${webRoot}/detect/basePoint/queryByDepartId?departId='+departId,
                async:false,
                success:function(data){
                    var html = '<option value="">请选择</option>';
                    for (var i = 0; i < data.obj.length; i++) {
                        var o = data.obj[i];
                        html += '<option value="'+o.id+'">'+o.pointName+'</option>';
                    }
                    $("#pointSelect").html(html);
                }
            });
        }

     //更换乐橙手机号时，实时去乐橙后台查询设备列表
	function changeUserPhone(){
		 $.ajax({
             type: "POST",
             url: '${webRoot}'+"/video/surveillance/selectDeviceByPhone.do",
             data: {"phone":$("#chooseUseraccount").val()},
             dataType: "json",
             success: function(data){
             	 $("#surveillanceNameChose").empty("");
                 if(data && data.success){
              	   var json = eval(data.obj);
                     var htmlStr = '<option value=" ">--请选择--</option>';
                     $.each(json, function(index, item) {
                         htmlStr+='<option value="'+item.channelName+'" data-deviceId="'+item.deviceId+'" data-channelId="'+item.channelId+'" >'+item.channelName+'</option>';
                     });
                     $("#surveillanceNameChose").append(htmlStr);
                 }else{
                     $("#confirm-warnning .tips").text(data.msg);
                     $("#confirm-warnning").modal('toggle');
                 }
             }
         })
	}*/
    </script>
    <script src="${webRoot}/plug-in/imouPlayer/imouplayer.js"></script>
	<%--监听用户是否浏览页面--%>
	<script src="${webRoot}/js/listenerVideo.js"></script>
</body>
</html>
