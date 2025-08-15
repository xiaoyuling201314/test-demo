<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/common/resource.jsp"%>
<html>
<head>
    <title>快检服务云平台</title>
    <link rel="stylesheet" type="text/css" href="${webRoot}/plug-in/easyui-1.5.2/tree.css">
    <style type="text/css">
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
        .cs-input-box .Validform_checktip{
            display:none;
        }

        .search-input input{
            width:90%;
            height:30px;
        }
        .stock_info{
            width:100%;
            overflow: auto;
            height: 100%;
        }
        .text-gray{
            color: #999999;
        }
        .stock_info ul li .title {
            width: 78%;
        }
        .styleDiv{
            padding:0;
            height: 100%;
            box-sizing: border-box;
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
        #playercontainerDingZhi{
            width: 710px;
            height: 500px;
            margin: 0 auto;
        }

        #playercontainerDingZhi iframe {
            position: relative;
            width: 100%;
            height: 80%;
            margin-bottom: 10px;
            overflow: hidden;
        }
        .btn:hover, .btn:focus, .btn.focus{
            color: #fff;
        }
    </style>
</head>
<body class="easyui-layout">
<div data-options="region:'west',split:false,title:'检测点'" style="width: 326px; padding:10px; padding-left:0; padding-right:0;overflow: hidden;">
    <div class="search-result">
        <div class="cs-stat-search col-md-12 col-sm-12 clearfix">
            <div class="cs-all-ps">
                <div class="cs-input-box" style="width:180px">
                    <input type="text" name="departName" id="departName" readonly="readonly" value="${report.departName }" title="${report.departName}" style="height: 30px;overflow: hidden; white-space: nowrap; text-overflow: ellipsis;width: 180px;">
                </div>
            </div>
            <div class="cs-search-filter clearfix cs-fr">
                <input id="pointId" type="hidden">
                <input class="cs-input-cont cs-fl focusInput" type="text" name="pointName" id="pointName" id="search"  autocomplete="off" placeholder="请输入检测点名称">
                <input type="button" onclick="queryByFocus();"   class="cs-search-btn cs-fl" href="javascript:;" value="搜索">
            </div>
        </div>
    </div>
    <div class="stock_info">
        <!--左侧检测点列表-->
        <ul id="type"></ul>
    </div>
</div>

<div data-options="region:'north',border:false" style="top: 0px; border: none;">
    <div>
        <ol class="cs-breadcrumb">
            <li class="cs-fl"><img src="${webRoot}/img/set.png" alt="" /><a href="javascript:">视频监控</a></li>
            <li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
            <li class="cs-b-active cs-fl">视频回放</li>
        </ol>
    </div>
</div>

<div data-options="region:'center',split:false">

    <div class="cs-col-lg-table cs-tab-box cs-on styleDiv">
        <div class="cs-time-se cs-in-style" style="padding: 5px 10px; margin: 0 auto; width: 610px;">
            <div id="videoPoint" class="text-center" style="font-size: 20px; line-height: 30px; margin-top: 10px;">
                <i class="icon iconfont icon-shexiangtou text-primary" style="font-size: 22px"></i> <span class="pointName"></span>
            </div>
            回放时间：
            <input type="text" id="beginTime" autocomplete="off" class="cs-time" onclick="WdatePicker({maxDate:'#F{$dp.$D(\'endTime\')||\'%y-%M-%d %H:%m:%s\'}',dateFmt:'yyyy-MM-dd HH:mm:ss'})">
            &nbsp;至&nbsp;
            <input type="text" id="endTime" autocomplete="off" class="cs-time" onclick="WdatePicker({minDate:'#F{$dp.$D(\'beginTime\')}',maxDate:'#F{\'%y-%M-%d %H:%m:%s\'}',dateFmt:'yyyy-MM-dd HH:mm:ss'})">
            <span class="btn btn-primary" style="line-height: 18px; margin-top: -4px;" onclick="playVedio();"><i class="iconfont icon-chakan"></i>回放</span>
        </div>
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
</div>

<!-- 引用模态框 -->
<%@include file="/WEB-INF/view/common/confirm.jsp"%>
<%@include file="/WEB-INF/view/detect/depart/selectDepartModel.jsp"%>
<script type="text/javascript">
    var  departId=${report.departId};
    $(document).on("click", "#departName", function(){
        $('#myDepartModal').modal('toggle');
    });
    $(function(){
        $('#beginTime').val(newDate().DateAdd('h', -1).format("yyyy-MM-dd HH:mm:ss"));
        $('#endTime').val(newDate().format("yyyy-MM-dd HH:mm:ss"));

        $('#surveillanceNameChose').select2();
        //初始化加载检测点
        loadPoints(${report.departId});
    });

    //选择机构，执行查询检测点操作
    function selDepart(id, text){
        $('#myDepartModal').modal('toggle');
        departId=id;
        $("#departId").val(id);
        $("input[name='departName']").val(text);
        $("input[name='departName']").attr("title",text);
        $(".cs-check-down").hide();
        loadPoints(id);
    }
    //根据机构Id查询检测点
    function loadPoints(departId){
        $.ajax({
            url: "${webRoot}/video/surveillance/selectPointByDepartId.do",
            type: "POST",
            data: {
                "departId": departId,
                "videoType": 6
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
        }else{
            $("#showBtn").removeClass("cs-hide");
            var json = eval(data);
            $.each(json, function(index, item) {
                if(item.pointId && item.videoType == 6){
                    htmlStr+='<li name="type" data-type='+item.id+' data-pointName='+item.pointName+' data-departId='+item.departId+' onclick="selectPoint(this)" >';
                    htmlStr+='<div class="title"><a href="javascript:;" title='+item.pointName+'>';
                    htmlStr+='<i style="padding-left: 2px" class="icon iconfont icon-shexiangtou text-primary" title="已配置"></i>' + item.pointName;
                    htmlStr+=' </a></div><div class="arrow"><i class="icon iconfont icon-you"></i></div></li>';
                }
            });
            $.each(json, function(index, item) {
                if(!item.pointId ||  item.videoType != 6){
                    htmlStr+='<li name="type" data-type='+item.id+' data-pointName='+item.pointName+' data-departId='+item.departId+' onclick="selectPoint(this)" >';
                    htmlStr+='<div class="title"><a href="javascript:;" title='+item.pointName+'>';
                    htmlStr+= '<i style="padding-left: 2px" class="icon iconfont icon-shexiangtou text-gray" title="未配置"></i>' + item.pointName;
                    htmlStr+=' </a></div><div class="arrow"><i class="icon iconfont icon-you"></i></div></li>';
                }
            });
            $("#type").append(htmlStr);

            //默认选中第一个检测点并加载摄像头数据
            if ($("li[name='type']").length>0) {
                $("li[name='type']:eq(0)").click();
            }
        }
    }
</script>
<script type="text/javascript">
    var tabOptions="tubiao";
    //新增标签
    if(Permission.exist("1475-5")){
        $("#showBtn").append('<a class="cs-menu-btn" href="javascript:;" onclick="editVideo(0)"><i class="'+Permission.getPermission("1475-5").functionIcon+'"></i>新增</a>');
    }

    //根据检测点ID查询摄像头设备信息
    function playVedio(pointId){
        if (!pointId) {
            pointId = $("#pointId").val();
        }
        $("#playercontainerDingZhi").html("");
        $.ajax({
            url:'${webRoot}/video/surveillance/selectDeviceForImouPlayer?pointId='+pointId,
            async:false,
            success:function(data){
                let flag1= false;
                let multiScreen=0;
                var liveBroadArray=[];
                if(data.obj.length>0){
                    for (var i = 0; i < data.obj.length; i++) {
                        //海康威视直播定制
                        if(data.obj[i].videoUrl!="" && data.obj[i].videoType==6){
                            var urls = data.obj[i].videoUrl.split(",");
                            $.each(urls, function (index, item) {
                                let ifr = document.createElement("iframe");
                                ifr.src = item + "&beginTime="+$("#beginTime").val().replace(" ","T") + "&endTime="+$("#endTime").val().replace(" ","T");
                                document.getElementById("playercontainerDingZhi").appendChild(ifr);
                            });
                        }
                    }
                }
            }
        });
    }
    //根据关键字和机构ID查询检测点
    function queryByFocus(){
        $.ajax({
            url: "${webRoot}/video/surveillance/selectPointByDepartId.do",
            type: "POST",
            data: {
                "departId":departId,
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

    //选择检测室
    function selectPoint(obj) {
        $.each($("li[name='type']"), function (index, item) {
            $(item).attr("class", "");
        });
        var id = $(obj).data("type");
        $("#pointId").val(id);
        $(obj).addClass("active");

        if ($(obj).find(".icon-shexiangtou").hasClass("text-primary")) {
            $("#videoPoint i").removeClass("text-gray");
            $("#videoPoint i").addClass("text-primary");
        } else {
            $("#videoPoint i").removeClass("text-primary");
            $("#videoPoint i").addClass("text-gray");
        }
        $("#videoPoint .pointName").text($(obj).data("pointname"));

        playVedio(id);
    }

    $(document).ready(function() {
        $(".cs-tab-icon li").click(function() {
            $(".cs-tab-icon li").eq($(this).index()).children('a').addClass("active").parent('li').siblings().children('a').removeClass('active');
            $(".cs-tab-box").hide().eq($(this).index()).show();

            if($(this).children('a').hasClass('icon-tubiao')){
                tabOptions="tubiao";
            }else{
                tabOptions="liebiao";
                player.stop();
                $('#showBtn').css('display','block')
            }
        });
    });

    // //修改开始时间
    // function changeBeginTime(){
    //     let beginTime0 = newDate($("#beginTime").val());
    //     let endTime0 = beginTime0.DateAdd("n", 30);
    //     if (endTime0 > newDate()){
    //         endTime0 = newDate();
    //     }
    //     $("#endTime").val(endTime0.format("yyyy-MM-dd HH:mm:ss"));
    // }

</script>
</body>
</html>
