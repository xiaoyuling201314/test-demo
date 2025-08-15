<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/WEB-INF/view/common/resource.jsp" %>
<html>
<head>
    <title>快检服务云平台</title>
    <style>
        .cs-ss {
            position: absolute;
            left: 0;
            right: 0;
            bottom: 0;
            top: 0;
            height: 100%;
            width: 100%;
            border: none;
            border: 0;
        }

        .layout-split-west {
            bottom: 0px;
        }

        .cs-points {
            height: 110px;
        }
        .cs-any-li li{
            width: auto;
        }
        .cs-border-right{
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .layout{
            z-index: auto;
        }
    </style>
</head>
<body>
<div class="easyui-layout cs-ss" id="context1">
    <c:choose>
        <c:when test="${!empty session_user.pointName}"><!--检测点用户查看-->
            <div class="cs-col-lg clearfix">
                <!-- 面包屑导航栏  开始-->
                <ol class="cs-breadcrumb">
                    <li class="cs-fl">
                        <img src="${webRoot}/img/set.png" alt="" />
                        <a href="javascript:">检测室管理</a></li>
                    <li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
                    <li class="cs-b-active cs-fl">检测室
                    </li>
                </ol>
            </div>
            <div class="clearfix">
                <ul class="cs-point-list">
                </ul>
            </div>
        </c:when>
        <c:otherwise><!--机构用户分级查看监测点-->
            <div id="contentLeft"  data-options="region:'west',split:true,title:'组织机构'" style="width: 250px; padding: 10px;">
                <ul id="departTree" class="easyui-tree" style="padding-bottom:40px;">
                </ul>
            </div>

            <div data-options="region:'north',border:false" style="height:41px; border: none; overflow:hidden;">
                <div class="cs-col-lg clearfix" style="border-bottom: none;">
                    <!-- 面包屑导航栏  开始-->
                    <ol class="cs-breadcrumb">
                        <li class="cs-fl">
                            <img src="${webRoot}/img/set.png" alt=""/>
                            <a href="javascript:">检测室管理</a></li>
                        <li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
                        <li class="cs-b-active cs-fl">检测室</li>
                    </ol>
                    <div class="cs-col-nav clearfix cs-fl">
                        <div class="cs-fl"> <span class="cs-title-tip text-muted pointNumbers"></span>
                        </div>
                    </div>
                    <!-- 面包屑导航栏  结束-->
                    <div class="cs-search-box cs-fr">
                        <form action="">
                            <input type="hidden" class="focusInput" name="baseBean.parentId" id="parentId"/>
                            <%--机构用户开放查询输入框--%>
                                <c:if test="${empty session_user.pointName}">
                                    <div class="cs-search-filter clearfix cs-fl">
                                        <input class="cs-input-cont cs-fl" type="text" name="pointName"  placeholder="请输入检测点名称" />
                                        <input type="button" onclick="viewBasePoint()" class="cs-search-btn cs-fl" value="搜索">
                                    </div>
                                </c:if>
                            <div class="clearfix cs-fr" id="showBtn">
                            </div>
                        </form>
                    </div>
                </div>

            </div>

            <div data-options="region:'center',split:false"  id="departPannel">
                <ul class="cs-point-list">

                </ul>
            </div>
        </div>
        </c:otherwise>
    </c:choose>

<!-- 内容主体 结束 -->
<!-- Modal 提示窗-删除-->
<div class="modal fade intro2" id="confirm-delete" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog cs-alert-width">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">确认删除</h4>
            </div>
            <div class="modal-body cs-alert-height cs-dis-tab">
                <div class="cs-text-algin">
                    <img src="${webRoot}/img/stop2.png" width="40px"/>
                    <span>确认删除该记录吗？</span>
                </div>
            </div>
            <div class="modal-footer">
                <a class="btn btn-danger btn-ok" onclick="deletePoint()">删除</a>
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
            </div>
        </div>
    </div>
</div>
<%@include file="/WEB-INF/view/detect/basePoint/addPoint_new.jsp" %>
<!-- 选择地图定位 -->
<%@ include file="/WEB-INF/view/common/map/selectMapLocation.jsp" %>
<!-- JavaScript -->
<script src="${webRoot}/js/datagridUtil2.js"></script>
<script src="${webRoot}/js/jquery.form.js"></script>
<%@include file="/WEB-INF/view/common/modalBox.jsp"%>
<%-- <script src="${webRoot}/js/easyform.js"></script> --%>
<script type="text/javascript">
    if (Permission.exist("1497-1")) {
        let html = '<a class="cs-menu-btn" href="javascript:;" onclick="addPoint()"><i class="' + Permission.getPermission("1497-1").functionIcon + '"></i>' + Permission.getPermission("1497-1").operationName + '</a>';
        $("#showBtn").prepend(html);
    }

    $(function () {
        //加载组织机构树形控件数据列表
        if(${empty session_user.pointName}){//机构用户，加载机构树
            loadDepartTree();
        }else{
            viewBasePoint(${session_user.departId});
        }
    });
    var treeLevel = 1;	//控制机构树加载二级数据
    var ii = 0;
    var departId;//所选机构ID
    var departName;//所选机构名称
    var parentFather;//所选机构父节点，用户新增检测点后刷新左侧树形机构
    function loadDepartTree() {
        treeLevel = 1;
        $("#departTree").tree({
            url: "${webRoot}/detect/depart/getDepartTreeForPoint.do",
            animate: true,
            onClick: function (node) {
                if (!$('#departTree').tree('isLeaf', node.target)) {

                }
                //点击左侧机构加载子级检测点的时候，清空右边搜索输入框的值
                $("input[name=pointName]").val("");
                //查询点击机构下的直属检测点
                viewBasePoint(node.id);
                departId=node.id;
                departName=node.attributes.departName;
                parentFather=$('#departTree').tree('getParent', node.target);
            },
            onBeforeLoad:function(node, param){
                param.isQueryPoint=true;
            },
            onLoadSuccess: function (node, data) {
                //延迟执行自动加载二级数据，避免与异步加载冲突
                setTimeout(function () {
                    if (data && treeLevel == 1) {
                        treeLevel++;
                        //初始化，加载第一个节点数据
                        if (ii == 0) {
                            var topNode = $('#departTree').tree('getRoot');
                            viewBasePoint(topNode.id);
                            departId=topNode.id;
                            departName=topNode.attributes.departName;
                            ii++;
                        }

                        $(data).each(function (index, d) {
                            if (this.state == 'closed') {
                                var children = $('#departTree').tree('getChildren');
                                for (var i = 0; i < children.length; i++) {
                                    $('#departTree').tree('expand', children[i].target);
                                }
                            }
                        });
                    }
                }, 100);
            }
        });
    }
    //点击机构名称，查询直属检测点信息
    function viewBasePoint(id) {
        $.ajax({
            type: "POST",
            url: '${webRoot}' + "/detect/basePoint/querySubPoint.do",
            data: {"departId": id,"pointName": $("input[name=pointName]").val()},
            dataType: "json",
            success: function (data) {
                let pointNumbers=0;//直属检测点数量
                if (data && data.success) {
                    $(".cs-point-list").html("");
                    let html = "";
                    let json = eval(data.obj);
                    pointNumbers=json.length;
                    $.each(json, function (index, item) {
                        html += '<li class="cs-points">';
                        html += ' <div class="cs-img-box"><span class="cs-border-right">';
                        if (item.point.regulatoryId!="") {
                            html += '<i title="企业检测室" class="icon iconfont icon-gongsi cs-icon-head"></i>';
                        }else  if (item.point.pointType == "0" && item.point.pointTypeId == "1") {
                            html += '<i title="政府检测室" class="icon iconfont icon-loupan cs-icon-head"></i>';
                        } else if (item.point.pointType == "1") {
                            html += '<i title="检测车" class="icon iconfont icon-jianceche cs-icon-head"></i>';
                        }
                        html += '</span></div>';
                        html += '<div class="cs-points-info">';
                        html += ' <div class="cs-info-title">' +
                            '     <a href="javascript:;" onclick="viewDevice(' + item.point.id + ')">' + item.point.pointName + '</a>' +
                            '     <div class="cs-nor-btn cs-fr iBtns">' +
                            '      <input class="pointId" type="hidden" value="' + item.point.id + '">';
                        if (Permission.exist("1497-2")) {//编辑
                            html += '<span class="cs-icon-span"><i class="' + Permission.getPermission("1497-2").functionIcon + ' editPoint"></i></span>';
                        }
                        if (Permission.exist("1497-3")) {//删除
                            html += '<span class="cs-icon-span"><i class="' + Permission.getPermission("1497-3").functionIcon + ' deletePoint"></i></span>';
                        }
                        if (Permission.exist("1497-4")) {//查看
                            html += '<span class="cs-icon-span"><i class="' + Permission.getPermission("1497-4").functionIcon + ' viewPoint"></i></span>';
                        }
                        html += '</div></div>';
                        html += '<div class="cs-info-list clearfix">' +
                            '       <ul class="cs-any-li">' +
                            '       <li>仪器：<a href="javascript:;" onclick="viewDevice(' + item.point.id + ')"><span class="cs-name-co">' + item.devicesSize + '台</span></a></li> ';
                        html += '<li><div class="temperature '+(Permission.exist("1497-7")==true ? "" : "cs-hide")+'">温度：<a href="javascript:;"><span class="cs-name-co">${item.manage.temperature}℃</span></a></div></li> ' +
                                '<li><div class="humidity '+(Permission.exist("1497-7")==true ? "" : "cs-hide")+'" >湿度：<a href="javascript:;"><span class="cs-name-co">${item.manage.humidity}%</span></a></div></li> ' ;
                        html +='</ul></div>';
                        html += '<div></div>';
                        html += '<div class="cs-info-list">';
                        if (item.point.pointType == "0") {
                            let addressStr=item.point.address;
                            html += '地址：<a href="javascript:;" title="'+addressStr+'" class="viewMap" data-id="'+item.point.id+'" data-showDudao="N" ><span class="cs-name-co">';
                            if (addressStr != "") {
                                if(addressStr.length>26){
                                    html += addressStr.substring(0,27)+"...";
                                }else{
                                    html += item.point.address;
                                }
                            }
                            html += '</span></a>';
                            html += '<a class="localBtn '+(Permission.exist("1497-2")==true ? "" : "cs-hide")+'" data-id="'+item.point.id+'" data-showDudao="N" onclick="setUpdatePointid(' + item.point.id + ',' + item.point.departId + ',\''+ item.point.placeX+'\',\''+ item.point.placeY+'\');">' +
                                '<span class="cs-icon-span"><i class="icon iconfont icon-local"></i></span></a>';
                        } else if (item.point.pointType == "1") {
                            html += '车牌：<a href="javascript:;" class="viewMap" data-id="'+item.point.id+'" data-showDudao="N"><span class="cs-name-co"> ';
                            if (item != "") {
                                html += item.point.licensePlate;
                            }
                            html += '</span></a>';
                        }
                        html += ' </div>';
                        html += ' </div>';
                        html += '</li>';
                    });
                    $(".cs-point-list").append(html);

                }else{
                    alert(data.msg)
                }
                // $(".pointNumbers").html("共"+pointNumbers+"个检测点");
            }
        });
    }

    //查看设备
    function viewDevice(id) {
        showMbIframe('${webRoot}/data/devices/devicesList.do?type=point&id=' + id+"&showDudao=N&openIframe=Y");
    }
    //查看
    $(document).on("click", ".viewPoint", function(){
        let pointId = $(this).parent().siblings(".pointId").val();
        viewDevice(pointId);
    });
    //编辑
    $(document).on("click", ".editPoint", function(){
        let pointId = $(this).parent().siblings(".pointId").val();
        addPoint(pointId);
    });
    //删除
    $(document).on("click", ".deletePoint", function(){
        let pointId = $(this).parent().siblings(".pointId").val();
        openDeleteModal(pointId);
    });
    //点击地址查看地图
    $(document).on("click",".cs-info-list .viewMap",function(){
        showMbIframe("${webRoot}/detect/location/replay.do?id="+$(this).attr("data-id")+"&showDudao="+$(this).attr("data-showDudao")+"&openIframe=Y");
    });
    var delectPointId;//要删除的检测点ID
    function openDeleteModal(id){
        if(id){
            delectPointId = id;
            $("#confirm-delete").modal('toggle');
        }
    }
    function deletePoint(){
        $.ajax({
            type: "POST",
            url: '${webRoot}'+"/detect/basePoint/delete.do",
            data: {"ids":delectPointId},
            dataType: "json",
            success: function(data){
                if(data && data.success){
                    viewBasePoint(departId);
                    if(parentFather!=undefined){
                        let n = $('#departTree').tree('find', parentFather.id);
                        //删除子节点下的检测室时重新加载左侧机构节点，刷新检测点数量
                        $('#departTree').tree('reload', n.target);
                    }else{//删除最高节点下的检测室时刷新整个树节点
                         treeLevel = 1;	//控制机构树加载二级数据
                         ii = 0;
                        $('#departTree').tree('reload');
                    }
                }
            }
        });
        $("#confirm-delete").modal('toggle');
    }
    //设置更新检查点ID
    var updatePointid = '';	//检测点ID
    var updatePdid = '';	//检测点所属机构ID
    function setUpdatePointid(pid, pdid,x,y){
        updatePointid = pid;
        updatePdid = pdid;
        mapLocationX = x;
        mapLocationY = y;
        $("#positionModal").modal('toggle');
    }
    //保存坐标
    function getCoordinate(coordinate, title, address){
        var jw = coordinate.split(",");

        //修改坐标，地址为空，后台不更新地址
        var overwriteAddress = "0";	//更新
        if (!address) {
            overwriteAddress = "1";	//不更新
        }

        setTimeout(function(){
            $.ajax({
                type: "POST",
                url: '${webRoot}'+"/detect/basePoint/save.do",
                data: {"id":updatePointid,"departId":updatePdid,"placeX":jw[0],"placeY":jw[1],"address":address,"overwriteAddress":overwriteAddress,"operator":"position"},
                dataType: "json",
                success: function(data){
                    if(data && data.success){
                        viewBasePoint(updatePdid);
                    }
                }
            });
        },200);
    }
    $('#contentLeft').resizable({
        onStopResize:function(e){
            var cont = $(window).width() - $('#contentLeft').width();
            if(cont>800){
                $('.cs-points').css('width','31.999%')
            }else{
                $('.cs-points').css('width','48.8%')
            }
        }
    });
    //回车查询数据
    document.onkeydown=function(event){
        var e = event || window.event || arguments.callee.caller.arguments[0];
        if(e && e.keyCode==13){ //enter键
            var focusedElement = document.activeElement;//当前关键词元素
            if(focusedElement && focusedElement.className){
               viewBasePoint();
            }
            return false;
        }
    }
</script>

</body>
</html>
