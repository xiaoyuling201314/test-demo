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
}
.text-gray{
	color: #999999;
}
.stock_info ul li .title {
	width: 78%;
}
#playercontainer{
	margin:0 auto; 
	margin-top:10px;
}
.styleDiv{
	padding:2%;
}
</style>
</head>
<body class="easyui-layout">
	<div data-options="region:'west',split:true,title:'检测点'" style="width: 300px; padding:10px; padding-left:0; padding-right:0;">
		<div class="cs-search-filter clearfix " style="padding-bottom: 6px;">
					<input class="cs-input-cont cs-fl focusInput" type="hidden" name="pointId" id="pointId">
					<input class="cs-input-cont cs-fl focusInput" type="text" name="pointName" id="pointName" style="margin-left:7px; margin-right:0;"  placeholder="请输入检测点">
					<input type="button" onclick="queryByFocus()" class="cs-search-btn cs-fl" href="javascript:;" value="搜索">
				</div>
		<div class="stock_info">
		<ul id="type">
			<c:if test="${!empty points}">  
					<c:forEach items="${points}" var="subMenu" varStatus="index">
	    			<li name="type" data-type="${subMenu.id}" onclick="selectPoint(this)">
			            <div class="title"><a href="javascript:" title="${subMenu.pointName}">
			            <%-- <c:if test="${fn:length(subMenu.pointName)>12}">
			            	<c:choose>
								<c:when test="${subMenu.pointId==null||subMenu.videoType!=0}">
									${fn:substring(subMenu.pointName, 0, 10)}...<i style="padding-left: 2px" class="icon iconfont icon-weipeizhi text-del" title="未配置"></i>
								</c:when>
								<c:otherwise>
									${fn:substring(subMenu.pointName, 0, 12)}...
								</c:otherwise>
							</c:choose>
	                    </c:if> --%>
	                    <%-- <c:if test="${fn:length(subMenu.pointName)<=12}"> --%>
	                    	<c:choose>
								<c:when test="${subMenu.pointId==null||subMenu.videoType!=0}">
									<i style="padding-left: 2px" class="icon iconfont icon-shexiangtou text-gray" title="未配置"></i>${subMenu.pointName}
								</c:when>
								<c:otherwise>
									<i style="padding-left: 2px" class="icon iconfont icon-shexiangtou text-primary" title="已配置"></i>${subMenu.pointName}
									<%--${subMenu.pointName}--%>
								</c:otherwise>
							</c:choose>
	                    <%-- </c:if> --%>
			            </a></div>
			            <div class="arrow"><i class="icon iconfont icon-you"></i></div>
		        	</li>     
			    </c:forEach>
			</c:if>
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

			<div class="cs-tab-icon clearfix cs-fr">
			<ul>
				<li><a class="icon iconfont icon-tubiao active"></a></li>
				<li><a class="icon iconfont icon-liebiao"></a></li>
			</ul>
		</div>
		<div class="cs-search-box cs-fr">
        	<div class="clearfix cs-hide" id="showBtn"></div>    
        </div>
		</div>
	</div>

	<div data-options="region:'center'">
		
	 	<div class="cs-col-lg-table cs-tab-box cs-on styleDiv">
	        <div id="playercontainer"></div>
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
	<form id="saveForm" action="${webRoot}/video/surveillance/saveVideo">
		<div class="modal fade intro2" id="addModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
			<div class="modal-dialog cs-lg-width" role="document">
				<div class="modal-content ">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
						<h4 class="modal-title" id="myModalLabel">监控设备</h4>
					</div>
					<div class="modal-body cs-lg-height">
						<!-- 主题内容 -->
						<div class="cs-tabcontent">
							<div class="cs-content2">
								<table class="cs-add-new">
									<tr>
										<td class="cs-name" style="width:200px;">监控类型：</td>
										<td class="cs-in-style">
											<select id="camera" name="videoType" datatype="*" nullmsg="请选择监控类型" errormsg="请选择监控类型">
												<%--<option value="">请选择</option>--%>
												<option value="0">乐橙云</option>
												<option value="1">校园网</option>
												<option value="2">内网</option>
											</select>
										</td>
									</tr>
									<tr>
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
											<select id="pointSelect" name="pointId" datatype="*" nullmsg="请选择所属检测点" errormsg="请选择所属检测点">
												<option value="">请选择</option>
											</select>
										</td>
									</tr>
									<tr>
										<td class="cs-name"><font color="#FF0000">*</font>设备名称：</td>
										<td class="cs-in-style">
											<input type="text" name="surveillanceName" datatype="*" nullmsg="请输入设备名称" errormsg="请输入设备名称">
										</td>
									</tr>
								</table>

								<table class="cs-add-new cs-lecheng">
									<tr>
										<td class="cs-name"  style="width:200px;"><font color="#FF0000">*</font>视频URL：</td>
										<td class="cs-in-style">
											<input type="text" name="videoUrl" datatype="*" nullmsg="视频URL" errormsg="视频URL">
										</td>
									</tr>
									<tr>
										<td class="cs-name"  style="width:200px;"><font color="#FF0000">*</font>是否自动播放：</td>
										<td class="cs-al cs-modal-input" style="padding-top: 6px;">
											<input id="cs-check-radio" type="radio" value="1" name="autostart"/><label for="cs-check-radio">是</label>
											<input id="cs-check-radio2" type="radio" value="0" name="autostart" checked="checked"/><label for="cs-check-radio2">否</label>
										</td>
									</tr>
								</table>

								<table class="cs-xiaoyuan cs-add-new cs-hide">
									<tr>
										<td class="cs-name"  style="width:200px;"><font color="#FF0000">*</font>设备IP：</td>
										<td class="cs-in-style">
											<input type="text" name="ip" datatype="*" nullmsg="请输入设备IP" errormsg="请输入设备IP" ignore="ignore" disabled="disabled">
										</td>
									</tr>
									<tr>
										<td class="cs-name"  style="width:200px;"><font color="#FF0000">*</font>设备标识：</td>
										<td class="cs-in-style">
											<input type="text" name="dev" datatype="*" nullmsg="请输入设备标识" errormsg="请输入设备标识" ignore="ignore" disabled="disabled">
										</td>
									</tr>
									<tr>
										<td class="cs-name"  style="width:200px;"><font color="#FF0000">*</font>设备用户名：</td>
										<td class="cs-in-style">
											<input type="text" name="userName" datatype="*" nullmsg="请输入设备用户名" errormsg="请输入设备用户名" ignore="ignore" disabled="disabled">
										</td>
									</tr>
									<tr>
										<td class="cs-name"  style="width:200px;"><font color="#FF0000">*</font>设备密码：</td>
										<td class="cs-in-style">
											<input type="text" name="pwd" datatype="*" nullmsg="请输入设备密码" errormsg="请输入设备密码" ignore="ignore" disabled="disabled">
										</td>
									</tr>
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
										<td class="cs-name" style="width:200px;">排序：</td>
										<td class="cs-in-style">
											<input type="text" name="sorting">
										</td>
									</tr>
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

	<!-- 下拉插件 -->
	<script src="${webRoot}/js/select/tabcomplete.min.js"></script>
	<script src="${webRoot}/js/select/livefilter.min.js"></script>
	<script src="${webRoot}/js/select/bootstrap-select.js"></script>
	<script src="${webRoot}/js/select/filterlist.js"></script>
	<%-- <script src="${webRoot}/player/sewise.player.min.js"></script> --%>
	<script src="${webRoot}/plug-in/player/cyberplayer.js"></script>
	<script src="${webRoot}/js/datagridUtil2.js"></script>

    <script type="text/javascript">
        //新增标签
        if(Permission.exist("1375-1")){
            $("#showBtn").append('<a class="cs-menu-btn" href="javascript:;" onclick="editVideo(0)"><i class="'+Permission.getPermission("1375-3").functionIcon+'"></i>新增</a>');
        }

        var dgu = datagridUtil.initOption({
            tableId : "dataList", //列表ID
            tableAction : "${webRoot}/video/surveillance/datagrid.do", //加载数据地址
            parameter : [ //列表拼接参数
                /* {
                    columnCode : "pointName",
                    columnName : "检测点",
                    query : 1
                }, */ {
                    columnCode : "surveillanceName",
                    columnName : "设备名称",
                    columnWidth : "20%",
                    query : 1
                }, {
                    columnCode : "registerDate",
                    columnName : "注册时间",
                    columnWidth : "20%",
                    query : 1
                } ],
            funBtns : [{
                show : Permission.exist("1375-3"),
                style : Permission.getPermission("1375-3"),
                action : function(id) {
                    editVideo(id);
                }
            },
                /* {
                    show : Permission.exist("1375-6"),	//视频回放
                    style : Permission.getPermission("1375-6"),
                    action : function(id) {
                        location.href="${webRoot}/data/lawInstrument/viewPlayBack?id="+id+"&type=2";
                }
            },  */
                {
                    show : Permission.exist("1375-2"),
                    style : Permission.getPermission("1375-2"),
                    action : function(id) {
                        if(id == ''){
                            $("#confirm-warnning .tips").text("请选择监控摄像头");
                            $("#confirm-warnning").modal('toggle');
                        }else{
                            deleteIds = id;
                            $("#confirm-delete").modal('toggle');
                        }
                    }
                } ],
            bottomBtns : [//底部按钮
                {
                    show : Permission.exist("1375-2"),
                    style : Permission.getPermission("1375-2"),
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
        dgu.query();

        $(function () {

            $("#type li:first-child").addClass("active");//第一次进来就默认选中第一个
            var id = $("#type li:first-child").data("type");
            $("#pointId").val(id);
            dgu.queryByFocus();

            if(id!=null){
                id=id;
            }else {
                id=0;
            }

            $.ajax({
                url:'${webRoot}/video/surveillance/selectByPointId?pointId='+id,
                async:false,
                success:function(data){

                    var wids=0;
                    var heis=0;
                    if(data.obj.length>=2){
                        wids='48%';
                        heis=300;
                        $('.styleDiv').css("text-align","left")
                    }else if(data.obj.length<2){
                        wids=640;
                        heis=480;
                        $('.styleDiv').css("text-align","center")
                    }

                    $("#playercontainer").html("");
                    for (var i = 0; i < data.obj.length; i++) {
                        var v = data.obj[i];
                        var flag;
                        if(v.autostart==0){
                            flag=false;
                        }else {
                            flag=true;
                        }
                        if (v.videoType==0) {
                            $("#playercontainer").append("<div class='video-player-box' id='_player_"+v.id+"'></div>");

                            cyberplayer("_player_"+v.id).setup({
                                width: wids, // 宽度，也可以支持百分比（不过父元素宽度要有）
                                height: heis, // 高度，也可以支持百分比
                                title: v.surveillanceName, // 标题
                                isLive: true, // 必须设置，表明是直播视频
                                file: v.videoUrl, // //您的视频源的地址（目前是乐橙示例播放地址）
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
                            });
                        }
                    }
                }
            });
        });

        function queryByFocus(){
            $.ajax({
                url: "${webRoot}/video/surveillance/queryPointArr.do",
                type: "POST",
                data: {
                    "pointName": $("#pointName").val()
                },
                dataType: "json",
                success: function (data) {
                    $("[name=type]").remove();
                    var json = eval(data.obj);
                    var htmlStr = "";
                    $.each(json, function(index, item) {
                        htmlStr+='<li name="type" data-type='+item.id+' onclick="selectPoint(this)" >';
                        htmlStr+='<div class="title"><a href="javascript:;" title='+item.pointName+'>';

                        if(item.pointId==""||item.videoType!=0){
                            htmlStr+= '<i style="padding-left: 2px" class="icon iconfont icon-shexiangtou text-gray" title="未配置"></i>' + item.pointName;
                        }else {
                            htmlStr+= '<i style="padding-left: 2px" class="icon iconfont icon-shexiangtou text-primary" title="已配置"></i>' + item.pointName;
                        }

                        // if(item.pointId==""||item.videoType!=0){
                        //     htmlStr+=item.pointName+'<i style="padding-left: 2px" class="icon iconfont icon-weipeizhi text-del" title="未配置"></i>';
                        // }else {
                        //     htmlStr+=item.pointName;
                        // }
                        htmlStr+=' </a></div><div class="arrow"><i class="icon iconfont icon-you"></i></div></li>';
                    });
                    $("#type").append(htmlStr);
                    //默认选中第一个项目并加装仪器系列信息
                    $("#type li:nth-child(1)").addClass("active"); //第一次进来就默认选中第一个
                    var trainType = $("#type li:nth-child(1)").data("type");
                    AppType = trainType;
                    $("#type option[value='" + trainType + "']").attr("selected", "selected");
                },
                error: function () {
                    $("#waringMsg>span").html("操作失败");
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
            $(obj).addClass("active");
            dgu.queryByFocus();

            $.ajax({
                url:'${webRoot}/video/surveillance/selectByPointId?pointId='+id,
                async:false,
                success:function(data){
                    var wids=0;
                    var heis=0;
                    if(data.obj.length>=2){
                        wids='48%';
                        heis=300;
                        $('.styleDiv').css("text-align","left")
                    }else if(data.obj.length<2){
                        wids=640;
                        heis=480;
                        $('.styleDiv').css("text-align","center")
                    }
                    $("#playercontainer").html("");
                    for (var i = 0; i < data.obj.length; i++) {
                        var v = data.obj[i];
                        var flag;
                        if(v.autostart==0){
                            flag=false;
                        }else {
                            flag=true;
                        }
                        if(v.videoType==0){
                            $("#playercontainer").append("<div class='video-player-box' id='_player_"+v.id+"'></div>");

                            cyberplayer("_player_"+v.id).setup({
                                width: wids, // 宽度，也可以支持百分比（不过父元素宽度要有）
                                height: heis, // 高度，也可以支持百分比
                                title: v.surveillanceName, // 标题
                                isLive: true, // 必须设置，表明是直播视频
                                file: v.videoUrl, // //您的视频源的地址（目前是乐橙示例播放地址）
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
                            });
                        }
                    }
                }
            });
            if($('.play-center .video-player-box').length==1){
                $('.video-player-box').css('width','80%')
                $('.play-center').css('text-align','center')
            }
            var videoW = $('.video-player-box').width();
            $('.video-player-box').height(videoW/16*9);
        }
        $(document).ready(function() {
            $(".cs-tab-icon li").click(function() {
                $(".cs-tab-icon li").eq($(this).index()).children('a').addClass("active").parent('li').siblings().children('a').removeClass('active');
                $(".cs-tab-box").hide().eq($(this).index()).show();

                if($(this).children('a').hasClass('icon-tubiao')){
                    $('#showBtn').css('display','none')
                }else{
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

            // if ($("option:selected",this).val() == '0') {
            //     $('.cs-lecheng').show();
			// 	$('.cs-lecheng input').removeAttr("ignore");
            //     $('.cs-xiaoyuan,.cs-neiwang').hide();
			// 	$('.cs-xiaoyuan,.cs-neiwang input').attr("ignore","ignore");
            // }else if($("option:selected",this).val() == '1'){
            //     $('.cs-xiaoyuan').show();
			// 	$('.cs-xiaoyuan input').removeAttr("ignore");
            //     $('.cs-lecheng,.cs-neiwang').hide();
			// 	$('.cs-lecheng,.cs-neiwang input').attr("ignore","ignore");
            // }else if($("option:selected",this).val() == '2'){
            //     $('.cs-neiwang').show();
			// 	$('.cs-neiwang input').removeAttr("ignore");
            //     $('.cs-xiaoyuan,.cs-lecheng').hide();
			// 	$('.cs-xiaoyuan,.cs-lecheng input').attr("ignore","ignore");
            // }
        });
        
        function changeVideoType() {
			if ($("#camera").val() == '0') {
				$('.cs-lecheng').show();
				$('.cs-xiaoyuan,.cs-neiwang').hide();

				$('.cs-lecheng input').removeAttr("ignore");
				$('.cs-xiaoyuan input').attr("ignore","ignore");
				$('.cs-neiwang input').attr("ignore","ignore");

				$('.cs-lecheng input').removeAttr("disabled");
				$('.cs-xiaoyuan input').attr("disabled","disabled");
				$('.cs-neiwang input').attr("disabled","disabled");
			}else if($("#camera").val() == '1'){
				$('.cs-xiaoyuan').show();
				$('.cs-lecheng,.cs-neiwang').hide();

				$('.cs-xiaoyuan input').removeAttr("ignore");
				$('.cs-lecheng input').attr("ignore","ignore");
				$('.cs-neiwang input').attr("ignore","ignore");

				$('.cs-xiaoyuan input').removeAttr("disabled");
				$('.cs-lecheng input').attr("disabled","disabled");
				$('.cs-neiwang input').attr("disabled","disabled");
			}else if($("#camera").val() == '2'){
				$('.cs-neiwang').show();
				$('.cs-xiaoyuan,.cs-lecheng').hide();

				$('.cs-neiwang input').removeAttr("ignore");
				$('.cs-xiaoyuan input').attr("ignore","ignore");
				$('.cs-lecheng input').attr("ignore","ignore");

				$('.cs-neiwang input').removeAttr("disabled");
				$('.cs-xiaoyuan input').attr("disabled","disabled");
				$('.cs-lecheng input').attr("disabled","disabled");
			}
		}

        //所属机构树
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

        //验证
		var saveForm = $("#saveForm").Validform({
			beforeSubmit: function(data){
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
							queryByFocus();
							dgu.query();
						} else {
							$("#confirm-warnning .tips").text("保存失败");
							$("#confirm-warnning").modal('toggle');
						}
					}
				});
				return false;
			}
		});
        // var saveForm = $("#saveForm").Validform({
        //     tiptype: 3,
        //     label: ".label",
        //     showAllError: true,
        //     callback: function(data){
        //         if (data && data.success) {
        //             $("#addModal").modal('toggle');
        //             dgu.query();
        //         } else {
        //             $("#confirm-warnning .tips").text("保存失败");
        //             $("#confirm-warnning").modal('toggle');
        //         }
		//
        //         // $.Hidemsg();
        //         // if(data.success){
        //         // 	$("#addModal").modal('toggle');
        //         // 	loadDepartTree();
        //         // 	$("#saveForm select[name=id]").val('');
        //         // 	$("#saveForm select[name=pointId]").val(data.obj.pointId);
        //         // 	$("#saveForm input[name=surveillanceName]").val('');
        //         // 	if ($("option:selected",this).val() == '0') {
        //         // 		$("#saveForm input[name=videoUrl]").val('');
        //         // 	}else if($("option:selected",this).val() == '1'){
        //         //
        //         // 	}else if($("option:selected",this).val() == '2'){
        //         // 		$("#saveForm input[name=ip]").val('');
        //         // 		$("#saveForm input[name=dev]").val('');
        //         // 		$("#saveForm input[name=userName]").val('');
        //         // 		$("#saveForm input[name=pwd]").val('');
        //         // 	}
        //         // 	dgu.query();
        //         // 	$(document).find("#myDeaprtTree").tree('reload');
        //         // }else{
        //         // 	$.Showmsg(data.msg);
        //         // }
        //     }
        // });

        //关闭编辑模态框前重置表单，清空隐藏域
        $('#addModal').on('hide.bs.modal', function (e) {
            $("#saveForm").Validform().resetForm();
            $("#saveForm input[name=id]").val("");
            $("#camera option").each(function (){
                $(this).attr("selected",false);
            });
        });

        // 新增或修改
        $("#btnSave").on("click", function() {
            saveForm.submitForm();

            <%--var formData = new FormData($('#saveForm')[0]);--%>
            <%--$.ajax({--%>
            <%--	type : "POST",--%>
            <%--	url : "${webRoot}/video/surveillance/saveVideo.do",--%>
            <%--	data : formData,--%>
            <%--	contentType : false, //必须false才会避开jQuery对 formdata 的默认处理 XMLHttpRequest会对 formdata 进行正确的处理 --%>
            <%--	processData : false, //必须false才会自动加上正确的Content-Type--%>
            <%--	dataType : "json",--%>
            <%--	success : function(data) {--%>
            <%--		if (data && data.success) {--%>
            <%--			$("#addModal").modal('toggle');--%>
            <%--			dgu.query();--%>
            <%--		} else {--%>
            <%--			$("#confirm-warnning .tips").text("保存失败");--%>
            <%--			$("#confirm-warnning").modal('toggle');--%>
            <%--		}--%>
            <%--	}--%>
            <%--});--%>
        });

        function editVideo(id) {
            if (id) {
                $.ajax({
                    url:'${webRoot}/video/surveillance/edit?id='+id,
                    success:function(data){
                        if(data.obj){
                            $("#saveForm input[name=id]").val(data.obj.id);
                            $("#saveForm input[name=departPName]").val(data.obj.departName);
                            $("#saveForm input[name=departPid]").val(data.obj.departId);
                            changePoint(data.obj.departId);
                            $("#saveForm select[name=pointId]").val(data.obj.pointId);
                            $("#saveForm input[name=surveillanceName]").val(data.obj.surveillanceName);
                            $("#saveForm input[name=videoUrl]").val(data.obj.videoUrl);
                            $("#saveForm input[name=ip]").val(data.obj.ip);
                            $("#saveForm input[name=dev]").val(data.obj.dev);
                            $("#saveForm input[name=userName]").val(data.obj.userName);
                            $("#saveForm input[name=pwd]").val(data.obj.pwd);
                            $("#saveForm input[name=sorting]").val(data.obj.sorting);
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


    </script>
</body>
</html>
