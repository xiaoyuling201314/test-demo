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

        .cs-any-li li {
            width: auto;
        }

        .cs-border-right {
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .layout {
            z-index: auto;
        }
    </style>
</head>
<body>
<div class="cs-ss" id="context1">
    <!--机构用户分级查看监测点-->
    <div data-options="region:'north',border:false"style="height:41px; border: none; overflow:hidden;">
        <div class="cs-col-lg clearfix">
            <!-- 面包屑导航栏  开始-->
            <ol class="cs-breadcrumb">
                <li class="cs-fl">
                    <img src="${webRoot}/img/set.png" alt=""/>
                    <a href="javascript:">检测点管理</a>
                </li>
                <li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
                <li class="cs-b-active cs-fl">检测点</li>
                <li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
                <li class="cs-b-active cs-fl">${departName}</li>
            </ol>
            <div class="cs-col-nav clearfix cs-fl">
                <div class="cs-fl"><span class="cs-title-tip text-muted pointNumbers"></span>
                </div>
            </div>
            <!-- 面包屑导航栏  结束-->
            <div class="cs-search-box cs-fr">
                <form action="">
                    <input type="hidden" class="focusInput" name="baseBean.parentId" id="parentId"/>
                    <div class="cs-search-filter clearfix cs-fl">
                    </div>
                    <div class="clearfix cs-fr" id="showBtn">
                    </div>
                </form>
            </div>
        </div>
    </div>
    <div data-options="region:'center',split:false" id="departPannel">
        <ul class="cs-point-list">

        </ul>
    </div>
</div>

<!-- 内容主体 结束 -->
<!-- Modal 提示窗-删除-->
<div class="modal fade intro2" id="confirm-delete" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
     aria-hidden="true">
    <div class="modal-dialog cs-alert-width">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">确认删除</h4>
            </div>
            <div class="modal-body cs-alert-height cs-dis-tab">
                <div class="cs-text-algin">
                    <img src="${webRoot}/img/stop2.png" width="40px"/>确认删除该记录吗？
                </div>
            </div>
            <div class="modal-footer">
                <a class="btn btn-danger btn-ok" onclick="deletePoint()">删除</a>
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
            </div>
        </div>
    </div>
</div>
<%--检测点新增--%>
<%@include file="/WEB-INF/view/detect/departManage/point_add.jsp" %>
<!-- 选择地图定位 -->
<%@ include file="/WEB-INF/view/common/map/selectMapLocation.jsp" %>
<!-- JavaScript -->
<script src="${webRoot}/js/datagridUtil2.js"></script>
<script src="${webRoot}/js/jquery.form.js"></script>
<%@include file="/WEB-INF/view/common/modalBox.jsp" %>
<script type="text/javascript">
    var departId = "${departId}";//所选机构ID
    var departName = "${departName}";//所选机构名称

    if (Permission.exist("1497-1")) {
        let html = '<a class="cs-menu-btn" href="javascript:;" onclick="addPoint()"><i class="' + Permission.getPermission("1497-1").functionIcon + '"></i>' + Permission.getPermission("1497-1").operationName + '</a>';
        $("#showBtn").prepend(html);
        $("#showBtn").append('<a href="javascript:;" onclick="window.parent.closeMbIframe(1);" class="cs-menu-btn fanhui"><i class="icon iconfont icon-fanhui"></i>返回</a>');
    }

    $(function () {
        //加载组织机构树形控件数据列表
        viewBasePoint(departId);
    });

    //点击机构名称，查询直属检测点信息
    function viewBasePoint(id) {
        $.ajax({
            type: "POST",
            url: "${webRoot}/detect/basePoint/querySubPoint.do",
            data: {"departId": id},
            dataType: "json",
            success: function (data) {
                if (data && data.success) {
                    $(".cs-point-list").html("");
                    let html = "";
                    let json = eval(data.obj);
                    $.each(json, function (index, item) {
                        html += '<li class="cs-points">';
                        html += ' <div class="cs-img-box"><span class="cs-border-right">';
                        if (item.point.regulatoryId != "") {
                            html += '<i title="企业检测室" class="icon iconfont icon-gongsi cs-icon-head"></i>';
                        } else if (item.point.pointType == "0" && item.point.pointTypeId == "1") {
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
                        html += '<li><div class="temperature ' + (Permission.exist("1497-7") == true ? "" : "cs-hide") + '">温度：<a href="javascript:;"><span class="cs-name-co">${item.manage.temperature}℃</span></a></div></li> ' +
                            '<li><div class="humidity ' + (Permission.exist("1497-7") == true ? "" : "cs-hide") + '" >湿度：<a href="javascript:;"><span class="cs-name-co">${item.manage.humidity}%</span></a></div></li> ';
                        html += '</ul></div>';
                        html += '<div></div>';
                        html += '<div class="cs-info-list">';
                        if (item.point.pointType == "0"||item.point.pointType == "2") {
                            let addressStr = item.point.address;
                            html += '地址：<a href="javascript:;" title="' + addressStr + '" class="viewMap" data-id="' + item.point.id + '" data-showDudao="N" ><span class="cs-name-co">';
                            if (addressStr != "") {
                                if (addressStr.length > 26) {
                                    html += addressStr.substring(0, 27) + "...";
                                } else {
                                    html += item.point.address;
                                }
                            }
                            html += '</span></a>';
                            html += '<a class="localBtn ' + (Permission.exist("1497-2") == true ? "" : "cs-hide") + '" data-id="' + item.point.id + '" data-showDudao="N" onclick="setUpdatePointid(' + item.point.id + ',' + item.point.departId + ',\'' + item.point.placeX + '\',\'' + item.point.placeY + '\');">' +
                                '<span class="cs-icon-span"><i class="icon iconfont icon-local"></i></span></a>';
                        } else if (item.point.pointType == "1") {
                            html += '车牌：<a href="javascript:;" class="viewMap" data-id="' + item.point.id + '" data-showDudao="N"><span class="cs-name-co"> ';
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

                }
            }
        });
    }

    //查看设备
    function viewDevice(id) {
        showMbIframe('${webRoot}/data/devices/devicesList.do?type=point&id=' + id + "&showDudao=N&openIframe=Y");
    }

    //查看
    $(document).on("click", ".viewPoint", function () {
        let pointId = $(this).parent().siblings(".pointId").val();
        viewDevice(pointId);
    });
    //编辑
    $(document).on("click", ".editPoint", function () {
        let pointId = $(this).parent().siblings(".pointId").val();
        addPoint(pointId);
    });
    //删除
    $(document).on("click", ".deletePoint", function () {
        let pointId = $(this).parent().siblings(".pointId").val();
        openDeleteModal(pointId);
    });
    //点击地址查看地图
    $(document).on("click", ".cs-info-list .viewMap", function () {
        showMbIframe("${webRoot}/detect/location/replay.do?id=" + $(this).attr("data-id") + "&showDudao=" + $(this).attr("data-showDudao") + "&openIframe=Y");
    });
    var delectPointId;//要删除的检测点ID
    function openDeleteModal(id) {
        if (id) {
            delectPointId = id;
            $("#confirm-delete").modal('toggle');
        }
    }

    function deletePoint() {
        $.ajax({
            type: "POST",
            url: '${webRoot}' + "/detect/basePoint/delete.do",
            data: {"ids": delectPointId},
            dataType: "json",
            success: function (data) {
                if (data && data.success) {
                    viewBasePoint(departId);//重新加载界面
                }
            }
        });
        $("#confirm-delete").modal('toggle');
    }

    //设置更新检查点ID
    var updatePointid = '';	//检测点ID
    var updatePdid = '';	//检测点所属机构ID
    function setUpdatePointid(pid, pdid, x, y) {
        updatePointid = pid;
        updatePdid = pdid;
        mapLocationX = x;
        mapLocationY = y;
        $("#positionModal").modal('toggle');
    }

    //保存坐标
    function getCoordinate(coordinate, title, address) {
        var jw = coordinate.split(",");

        //修改坐标，地址为空，后台不更新地址
        var overwriteAddress = "0";	//更新
        if (!address) {
            overwriteAddress = "1";	//不更新
        }

        setTimeout(function () {
            $.ajax({
                type: "POST",
                url: '${webRoot}' + "/detect/basePoint/save.do",
                data: {
                    "id": updatePointid,
                    "departId": updatePdid,
                    "placeX": jw[0],
                    "placeY": jw[1],
                    "address": address,
                    "overwriteAddress": overwriteAddress,
                    "operator": "position"
                },
                dataType: "json",
                success: function (data) {
                    if (data && data.success) {
                        viewBasePoint(updatePdid);
                    }
                }
            });
        }, 200);
    }

</script>

</body>
</html>
