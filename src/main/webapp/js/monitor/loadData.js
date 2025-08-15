//机构、检测点、监管对象关键字搜索方法
function search() {
    var t = $('.cs-stat-selected').find('.cs-type').html();
    queryCount();
    if (t == "监管对象") {
        $(".ObjList").show();
        $("#Objpage").html("");
        queryObjData();
    } else if (t == "下级机构") {
        $(".OrgList").show();
        $("#Regpage").html("");
        queryData();
    } else if (t == "实验室") {
        $(".PointList").show();
        $("#Pointpage").html("");
        queryData1();
    }
}
//重置分页数量
function resetPageNumber() {
    pageSize = 20;
    pageNo = 1;
    pageCount = 1;
    pageSizeSel = 1;
    toPageNo = 1;
    navBtnNum = 1;	//导航页面序号按钮数量
    halfBtnNum = parseInt(navBtnNum / 2);
    rowTotal = 0;
}

//加载分页信息
function setPageInfo(funName, htmlId) {
    var html = "";
    pageNo = parseInt(pageNo);
    html += "<ul class=\"cs-pagination pull-left\" style='left: 0;width: auto;position: absolute;bottom: 0'>";
    html += "<li class=\"cs-distan\" style='line-height: 28px'>共" + pageCount + "页/" + rowTotal + "条</li></ul>";
    html += "<ul class=\"cs-pagination pull-right\" style='right: 2px;width: auto'>";
    //上一页
    if(pageNo==1){
        html += "<li class=\"cs-disabled cs-distan\" title='上一页'><span class=\"cs-b-nav-btn\" style='background: #f1eded;padding: 0 4px'>&lt;</span></li>";
    }else{
        html += "<li class=\"cs-disabled cs-distan\" title='上一页'><a class=\"cs-b-nav-btn\" style='padding: 0 4px' onclick=\"" + funName + "(-1);\">&lt;</a></li>";
    }
    //当前页
    html+="<li><span class=\"cs-b-nav-btn cs-n-active currentPage\" style='border-color:#468ad5;'>" + pageNo + "</span></li>";
    //下一页
    if(pageNo==pageCount){
        html += "<li class=\"cs-next \" title='下一页'><span class=\"cs-b-nav-btn\" style='background: #f1eded;padding: 0 4px'>&gt;</span></li>";
    }else{
        html += "<li class=\"cs-next \" title='下一页'><a class=\"cs-b-nav-btn\" style='padding: 0 4px' onclick=\"" + funName + "(1);\">&gt;</a></li>";
    }
    //跳转页面
    html+="<li class=\"cs-skip cs-distan\" style=\"margin-left: 2px;\"><input name=\"jumpPageNo\" type=\"text\" autocomplete=\"off\" placeholder=\"跳转\" style='height: 28px'></li>";
   //style="position: fixed; right: 2px;bottom: 9px;"
    html+="<li ><a class=\"cs-b-nav-btn cs-enter\" onclick=\"jumpPage(this,"+funName+")\">确定</a></li>";
    html += "</ul></div>";
    //刷新列表
    if (htmlId == 'Regpage') {
        $("#Regpage").html("");
        $("#Regpage").append(html);
    } else if (htmlId == 'Objpage') {
        $("#Objpage").html("");
        $("#Objpage").append(html);
    } else if (htmlId == 'Pointpage') {
        $("#Pointpage").html("");
        $("#Pointpage").append(html);
    } else if (htmlId == 'CheckDataPage') {
        $("#CheckDataPage").html("");
        $("#CheckDataPage").append(html);
    }
}
//跳转页面查看数据
function jumpPage(that,methodName){
    var jumpPageValue= $(that).parent('li').siblings('.cs-skip').children('input').val();
    if(jumpPageValue){
        var jumpPage=parseInt(jumpPageValue);
        if(jumpPage==0 || jumpPage>pageCount){
            alert("没有此页记录！");
            return false;
        }else if(jumpPage>0){
            methodName("",jumpPage)
        }
    }
}

//右侧tab选项卡切换
$(document).on("click", ".cs-stat-child",function () {
    $(this).addClass('cs-stat-selected').siblings().removeClass('cs-stat-selected');
    var t = $(this).find('.cs-type').html();
    $("#search").val("");
    $(".jg-box").hide();
    $(".jc-box").hide();
    $(".jgdx-box").hide();
    resetPageNumber();
    if (t == "监管对象") {
        $(".jgdx-box").show();
        queryObjData();
    } else if (t == "下级机构") {
        $(".jg-box").show();
        queryData();
    } else if (t == "实验室") {
        $(".jc-box").show();
        queryData1();
    }
    $("#videoModal").hide();
});
$(document).on("click", "#departName", function () {
    $('#myDepartModal').modal('toggle');
});
//选择机构
function selDepart(id, text) {
    $('#myDepartModal').modal('toggle');
    var departId = id;
    $("#departId").val(id);
    $("input[name='departName']").val(text);
    $("input[name='departName']").attr("title", text);
    $(".cs-check-down").hide();
    regLoad = true;//是否加载机构
    objLoad = true;//市场
    pointLoad = true;//检测点
    resetPageNumber();
    //查数据
    search();
}
//右侧tab项机构、实验室以及监管对象数量统计方法
function queryCount() {
    var departId = $("#departId").val();
    var search = $("#search").val();
    var dataStr = "{\"pageSize\":" + pageSize + ",\"pageNo\":" + 1
        + ",\"rowTotal\":" + rowTotal + ",\"type\":1,\"departId\": " + departId + ",\"pageCount\":" + pageCount + ",\"departName\":\"" + search + "\"}";
    $.ajax({
        type: "POST",
        url: rootPath + "/syMonitor/getData.do",
        data: JSON.parse(dataStr),
        dataType: "json",
        success: function (data) {
            if (data && data.success) {
                var pageModel = data.obj;
                var report = data.attributes.report;
                if (report) {
                    $(".infoTitle1").text(report.departName);
                    $(".departcount").text(report.departCount + "个");
                    $(".pointcount").text(report.pointCount + "个");
                    $(".objcount").text(report.regCount + "个");
                    $("#departPid").val(report.departPid);
                    $("#departId").val(report.departId);
                }
            }
        }
    });
}
/**************************************数据查询-start******************************************************************************/
var regList = null;
var pointList = null;
var objList = null;
var pageSize = 20;
var pageNo = 1;
var prevPageNo = 1;//上一层的页码数
var pageCount = 1;
var pageSizeSel = 1;
var toPageNo = 1;
var navBtnNum = 1;	//导航页面序号按钮数量
var halfBtnNum = parseInt(navBtnNum / 2);
var rowTotal = 0;
//项目预览主页-查询下级机构数据列表
function queryData(p, jumpPage) {
    if (jumpPage) {//跳转页码
        pageNo = jumpPage;
    } else if (!p) {
        pageNo = 1;
    } else {
        pageNo = pageNo + p;//上一页或上一页，当前页码数加减1
    }
    $(".currentPage").html(pageNo);
    var departId = $("#departId").val();
    var search = $("#search").val();
    var dataStr = "{\"pageSize\":" + pageSize + ",\"pageNo\":" + pageNo
        + ",\"rowTotal\":" + rowTotal + ",\"type\":1,\"departId\": " + departId + ",\"pageCount\":" + pageCount + ",\"departName\":\"" + search + "\"}";
    $.ajax({
        type: "POST",
        url: rootPath + "syMonitor/getData.do",//rootPath：${webRoot}/syMonitor/
        data: JSON.parse(dataStr),
        dataType: "json",
        success: function (data) {
            if (data && data.success) {
                var pageModel = data.obj;
                var report = data.attributes.report;
                if (report) {
                    $("#OrgList").html("");
                    $(".infoTitle1").text(report.departName);
                    $(".departcount").text(report.departCount + "个");
                    $(".pointcount").text(report.pointCount + "个");
                    $(".objcount").text(report.regCount + "个");
                    $("#departPid").val(report.departPid);
                    $("#departId").val(report.departId);
                    $("#departCode").val(report.departCode);
                }
                if (pageModel) {
                    //设置总记录数量
                    rowTotal = pageModel.rowTotal;
                    //设置总页数、当前页数
                    if (pageModel.pageCount <= 0) {
                        pageCount = 1;
                    } else if (pageModel.pageCount > pageCount) {
                        pageNo = pageCount;
                        pageCount = pageModel.pageCount;
                    } else {
                        pageCount = pageModel.pageCount;
                    }
                    pageNo = pageModel.pageNo;
                    //记录数据
                }
                setPageInfo("queryData", "Regpage");
                data_info = [];
                marker_arr = [];

                var infoTitle = "";
                var infoUl = "";
                var mlp = [];
                var departList = data.obj.results;
                if (departList) {
                    for (var i = 0; i < departList.length; i++) {
                        var mlp = [];
                        infoUl += "<li class=\"clearfix\"><div class=\"cs-fl\"><i class=\"local-bg-reg local-bg2\"></i></div>" +
                            "<p class=\"col-md-8 col-xs-8\"><i> </i><span class=\"text-primary\">" + departList[i].departName + "</span></p>" +
                            "<p class=\"col-md-10 col-xs-10\"><i> </i><span class=\"text-muted\">" + departList[i].address + "</span></p><span class=\"dep-detail\">详情</span></li>";

                        mlp[0] = departList[i].longitude;	//经度
                        mlp[1] = departList[i].latitude;	//纬度
                        mlp[2] = "<p style='font-size:16px;margin:0;line-height:1.5;font-weight:bold; color:#168ee6;'>" + departList[i].departName + "</p>" +	//定位信息
                            "<p style='margin:0;line-height:1.5;'>" + departList[i].address + "</p>" + "<div style='display:flex;justify-content:center;position: absolute;bottom: 0;width: 100%;'><div class='btn btn-primary btn-sm' onclick='getData(cont,dep)'>详情</div></div>";
                        mlp[3] = rootPath + "img/points/食药监.png";	//图标
                        mlp[4] = {"org": departList[i].departId};	//自定义属性-
                        data_info.push(mlp);
                        if (departList[i].isshow == 0) {
                        }
                    }
                }
                $(".infoDiv:eq(0) .infoTitle").text(infoTitle);
                $("#OrgList").html(infoUl);
                regLoad = false;
                setPageInfo("queryData", "Regpage");
                $(".infoDiv:eq(0)").show();//显示右侧信息栏（一级）
                $(".infoDiv:gt(0)").hide();//隐藏右侧信息栏（二级）
                setMapPoint();//在地图上标记定位
                getBoundary(cityLoaction);
            } else {
                console.log("查询失败");
            }
        },
        error: function () {
            console.log("查询失败");
        }
    });
}

//项目预览主页-查询检测点数据列表
function queryData1(p, jumpPage) {
    if (jumpPage) {//跳转页码
        pageNo = jumpPage;
    } else if (!p) {
        pageNo = 1;
    } else {
        pageNo = pageNo + p;//上一页或上一页，当前页码数加减1;
    }
    $(".currentPage").html(pageNo);
    var departId = $("#departId").val();
    var search = $("#search").val();
    var dataStr = "{\"pageSize\":" + pageSize + ",\"pageNo\":" + pageNo
        + ",\"rowTotal\":" + rowTotal + ",\"type\":1,\"map\":1,\"departId\": \"" + departId + "\",\"pageCount\":" + pageCount
        + ",\"baseBean.pointName\":\"" + search + "\",\"IsQueryVideoS\":\"1\",\"IsQueryUnqualified\":\"1\"}";
    $.ajax({
        type: "POST",
        url: rootPath + "/detect/basePoint/datagrid.do",
        data: JSON.parse(dataStr),
        dataType: "json",
        success: function (data) {
            if (data && data.success) {
                var pageModel = data.obj;
                data_info = [];
                marker_arr = [];
                var infoTitle = "";
                var infoUl = "";
                var points = data.obj.results;
                if (points) {
                    $("#PointList").html("");
                    infoTitle = "项目预览列表";
                    var point_i = 0;
                    for (var i = 0; i < points.length; i++) {
                        var serialIcon = "local-bg-point local-bg2";
                        if (points[i].placeX && points[i].placeY) {
                            var mlp = [];
                            point_i = point_i + 1;
                            mlp[0] = points[i].placeX;	//经度
                            mlp[1] = points[i].placeY;	//纬度
                            mlp[2] = "<p style='font-size:16px;margin:0;line-height:1.5;font-weight:bold; color:#168ee6;'><span class='pointNameTag'>" + point_i + "</span>" + points[i].pointName + "</p>" +	//定位信息
                                "<p style='margin:0;line-height:1.5;'>地址：" + points[i].address + "</p>" + "<div style='display:flex;justify-content:center;position: absolute;bottom: 0;width: 100%;'><div class='btn btn-primary btn-sm' onclick='getData(cont,dep)'>详情</div></div>";
                            var id = points[i].id;
                            if (id == 180 || id == 302) {
                                mlp[3] = "${webRoot}/img/points/检测中心.png";	//图标
                            } else {
                                if (points[i].unqualifiedNumber != 0) {
                                    serialIcon = "local-bg";
                                    mlp[3] = rootPath + "/img/points/检测室_warning.png";	//图标
                                } else {
                                    mlp[3] = rootPath + "/img/points/检测室.png";	//图标
                                }
                            }
                            mlp[4] = {"pointId": points[i].id};	//自定义属性-检测点ID
                            data_info.push(mlp);
                            infoUl += "<li class=\"clearfix\"><div class=\"cs-fl\"><i class='" + serialIcon + "'>" + (point_i) + "</i></div>" +
                                "<p class=\"col-md-8 col-xs-8\"><i> </i><span class=\"text-primary\">" + points[i].pointName + "</span></p>";
                            if (points[i].vedioNumbers > 0 && points[i].onlineStatus == 1) {
                                infoUl += '<i style="float: right;margin-right: 5px;" data-id=' + points[i].id + '  class="icon iconfont icon-shexiangtou text-primary playVedio" title="视频监控"></i>';
                            }
                            infoUl += "<p class=\"col-md-10 col-xs-10\"><i> </i><span class=\"text-muted\">" + points[i].address + "</span></p><span class=\"dep-detail\">详情</span></li>";
                        }
                    }
                }
                if (pageModel) {
                    //设置总记录数量
                    rowTotal = pageModel.rowTotal;
                    var pcount = parseInt(rowTotal / pageSize);
                    //设置总页数、当前页数
                    if (pcount <= 0) {
                        pageCount = 1;
                    } else if (pcount > pageCount) {
                        pageNo = pageCount;
                        pageCount = pageModel.pageCount;
                    } else {
                        pageCount = pageModel.pageCount;
                    }
                    pageNo = pageModel.pageNo;
                    //记录数据
                }
                setPageInfo("queryData1", "Pointpage");
                $(".infoDiv:eq(0) .infoTitle").text(infoTitle);
                $("#PointList").html(infoUl);
                pointLoad = false;
                $(".infoDiv:eq(0)").show();//显示右侧信息栏（一级）
                $(".infoDiv:gt(0)").hide();//隐藏右侧信息栏（二级）
                setMapPoint();//在地图上标记定位
                getBoundary(cityLoaction);
            } else {
                console.log("查询失败");
            }
        },
        error: function () {
            console.log("查询失败");
        }
    });
}

//项目预览主页-查询监管对象数据列表
function queryObjData(p, jumpPage) {
    if (jumpPage) {//跳转页码
        pageNo = jumpPage;
    } else if (!p) {
        pageNo = 1;
    } else {
        pageNo = pageNo + p;//上一页或上一页，当前页码数加减1
    }
    $(".currentPage").html(pageNo);
    var departId = $("#departId").val();
    var search = $("#search").val();
    var dataStr = "{\"pageSize\":" + pageSize + ",\"pageNo\":" + pageNo
        + ",\"rowTotal\":" + rowTotal + ",\"type\":1,\"map\":1,\"regulatoryObject.departId\": " + departId + ",\"pageCount\":" + pageCount
        + ",\"regulatoryObject.regName\":\"" + search + "\",\"IsQueryUnqualified\":\"1\"}";
    $.ajax({
        type: "POST",
        url: rootPath + "/ledger/regulatoryObject/datagrid2",
        data: JSON.parse(dataStr),
        dataType: "json",
        success: function (data) {
            if (data && data.success) {
                var pageModel = data.obj;
                $("#RegList").html("");
                data_info = [];
                marker_arr = [];
                var infoTitle = "";
                var infoUl = "";
                var mlp = [];
                var reg = data.obj.results;
                if (reg) {
                    infoTitle = "项目预览列表";
                    var reg_i = 0;
                    for (var i = 0; i < reg.length; i++) {
                        var serialIcon = "local-bg-point local-bg2";
                        if (reg[i].placeX && reg[i].placeY) {
                            if (reg[i].placeX && reg[i].placeY) {
                                var mlp = [];
                                reg_i = reg_i + 1;
                                mlp[0] = reg[i].placeX;	//经度
                                mlp[1] = reg[i].placeY;	//纬度
                                mlp[2] = "<p style='font-size:16px;margin:0;line-height:1.5;font-weight:bold; color:#168ee6;'>" + reg[i].regName + "</p>" +	//定位信息
                                    "<p style='margin:0;line-height:1.5;'>地址：" + reg[i].regAddress + "</p>" + "<div style='display:flex;justify-content:center;position: absolute;bottom: 0;width: 100%;'><div class='btn btn-primary btn-sm' onclick='getData(cont,dep)'>详情</div></div>";
                                var managementType = reg[i].managementType;
                                if (managementType == 1) {
                                    if (reg[i].unqualifiedNumber != 0) {
                                        serialIcon = "local-bg";
                                        mlp[3] = rootPath + "/img/points/农贸市场_warning.png";	//图标
                                    } else {
                                        mlp[3] = rootPath + "/img/points/农贸市场.png";	//图标
                                    }
                                } else {
                                    if (reg[i].unqualifiedNumber != 0) {
                                        serialIcon = "local-bg";
                                        mlp[3] = rootPath + "/img/points/批发市场_warning.png";	//图标
                                    } else {
                                        mlp[3] = rootPath + "/img/points/批发市场.png";	//图标
                                    }
                                }
                                mlp[4] = {"regId": reg[i].id};	//自定义属性-经营单位ID
                                data_info.push(mlp);

                                infoUl += "<li class=\"clearfix\"><div class=\"cs-fl\"><i class='" + serialIcon + "'>" + (reg_i) + "</i></div>" +
                                    "<p class=\"col-md-8 col-xs-8\"><i> </i><span class=\"text-primary\">" + reg[i].regName + "</span></p>" +
                                    "<p class=\"col-md-10 col-xs-10\"><i> </i><span class=\"text-muted\">" + reg[i].regAddress + "</span></p><span class=\"dep-detail\">详情</span></li>";
                            }
                        }
                    }
                }

                if (pageModel) {
                    //设置总记录数量
                    rowTotal = pageModel.rowTotal;
                    var pcount = parseInt(rowTotal / pageSize);
                    //设置总页数、当前页数
                    if (pcount <= 0) {
                        pageCount = 1;
                    } else if (pcount > pageCount) {
                        pageNo = pageCount;
                        pageCount = pageModel.pageCount;
                    } else {
                        pageCount = pageModel.pageCount;
                    }
                    pageNo = pageModel.pageNo;
                    //记录数据
                }
                setPageInfo("queryObjData", "Objpage");
                objLoad = false;
                $(".infoDiv:eq(0) .infoTitle").text(infoTitle);
                $("#RegList").html(infoUl);

                $(".infoDiv:eq(0)").show();//显示右侧信息栏（一级）
                $(".infoDiv:gt(0)").hide();//隐藏右侧信息栏（二级）
                setMapPoint();//在地图上标记定位
                getBoundary(cityLoaction);
            } else {
                console.log("查询失败");
            }
        },
        error: function () {
            console.log("查询失败");
        }
    });
}
/**************************************查看检测数据相关-start****************************************************************/
    //检测数据缓存
var checkDataCache;
var checkDataCacheType;
//获取详情数据
function getData(content, marker) {
    prevPageNo=pageNo;
    $("#CheckDataList").html("");
    $(".market-box").html("");
    $(".pointInfo .infoTitle").html("");
    var a = marker.myAttributes.org;
    var b = marker.myAttributes.pointId;
    var c = marker.myAttributes.regId;
    checkDataCache = [];
    if (a) {//机构
        // 点击地图上机构LOGO查看检测情况
        searchDepartId = marker.myAttributes.org;
        checkDataCacheType = "depart";
    }
    if (b) { //检测点
        searchPointId = marker.myAttributes.pointId;
        checkDataCacheType = "point";
    }
    if (c) { //查看监管对象详情
        searchRegId = marker.myAttributes.regId;
        checkDataCacheType = "reg";
    }
    loadMonitorData();
}
//根据传入的机构ID或检测点ID或者监管对象ID以及页码数进行数据查询
function loadMonitorData(p,jumpPage) {
    if(jumpPage){//跳转页码
        pageNo=jumpPage;
    }else if (!p) {
        pageNo = 1;
    }else{
        pageNo=pageNo+ p;//上一页或上一页，当前页码数加减1
    }
    $(".currentPage").html(pageNo);
    $.ajax({
        type: "POST",
        url: rootPath + "/syMonitor/loadCheckData",
        data: {"departId": searchDepartId,"pointId":searchPointId,"regId":searchRegId,"pageNo": pageNo,"pageSize":pageSize},
        dataType: "json",
        success: function (data) {
            $(".pointInfo").show();
            if (data && data.success) {
                if (data.obj.objectName) {
                    $(".pointInfo .infoTitle").html(data.obj.objectName);
                }
                var da1 = new Array();	//日期
                var da2 = new Array();	//合格数量
                var da3 = new Array();	//不合格数量
                var da4 = new Array();	//总数
                if (data.obj.quantity) {
                    var quantity = JSON.parse(data.obj.quantity);	//近7天合格/不合格检测数据
                    for (var i = 0; i < quantity.length; i++) {
                        da1.push(quantity[i].days);
                        da2.push(quantity[i].qualified);
                        da3.push(quantity[i].unqualified);
                        da4.push(quantity[i].total);
                    }
                }
                option.xAxis[0].data = da1;
                option.series[0].data = da2;
                option.series[1].data = da3;
                option.series[2].data = da4;
                setTimeout(loadingChart(), 100);//延迟加载图表，避免图	表尺寸变小
                checkDataCache = data.obj.recordings;
                rowTotal= data.obj.rowTotal;//设置总记录数量
                checkDataDetail(pageNo);
            }
        }
    });

}
//加载检测数据列表
function checkDataDetail(p) {
    //设置总页数
    var pcount = parseInt(rowTotal / pageSize);
    if (pcount <= 0) {
        pageCount = 1;
    } else {
        var ys = rowTotal % pageSize;
        if (ys > 0) {
            pageCount = pcount + 1;
        } else {
            pageCount = pcount;
        }
    }
    //设置当前页数
    if (!p) {
        pageNo = 1;
    } else if (p > pageCount) {
        pageNo = pageCount;
    } else {
        pageNo = p;
    }

    $("#CheckDataList").html("");
    setPageInfo("loadMonitorData", "CheckDataPage");
    if (checkDataCache) {
        var ii = 0;
        for (var i = 0; i < checkDataCache.length; i++) {
            ii++;
            if (checkDataCache[i].conclusion == '合格') {
                $("#CheckDataList").append("<li class=\"col-md-12 col-xs-12\">" +
                    "<div class=\"cs-fl\"><i class=\"local-bg-point local-bg2\">" + ii + "</i></div>" +
                    "<div class=\"check-label cs-fr\"><a href=\"javascript:;\" class=\"label label-primary\" onclick=\"viewDataCheckRecording('" + checkDataCache[i].rid + "')\">查看</a></div>" +
                    "<p class=\"col-md-8 col-xs-8\"><i>被检单位：</i><span class=\"text-muted\">" + checkDataCache[i].regName + "</span></p>" +
                    "<p class=\"col-md-8 col-xs-8\"><i>" + opeShopLabel + "：</i><span class=\"text-muted\">" + checkDataCache[i].opeShopName + "</span></p>" +
                    "<p class=\"col-md-8 col-xs-8\"><i>样品：</i><span class=\"text-muted\">" + checkDataCache[i].foodName + "</span></p>" +
                    "<p class=\"col-md-12 col-xs-12\"><i>项目：</i><span class=\"text-muted\">" + checkDataCache[i].itemName + "</span></p>" +
                    "<p class=\"col-md-8 col-xs-8\"><i>时间：</i><span class=\"text-muted\">" + checkDataCache[i].checkDate + "</span></p>" +
                    "<p class=\"col-md-4 col-xs-4\"><i>结果：</i><span class=\"cs-green-text\">" + checkDataCache[i].conclusion + "</span></p></li>");
            } else {
                $("#CheckDataList").append("<li class=\"col-md-12 col-xs-12\">" +
                    "<div class=\"cs-fl\"><i class=\"local-bg-point local-bg2\">" + ii + "</i></div>" +
                    "<div class=\"check-label cs-fr\"><a href=\"javascript:;\" class=\"label label-primary\" onclick=\"viewDataCheckRecording('" + checkDataCache[i].rid + "')\">查看</a></div>" +
                    "<p class=\"col-md-8 col-xs-8\"><i>被检单位：</i><span class=\"text-muted\">" + checkDataCache[i].regName + "</span></p>" +
                    "<p class=\"col-md-8 col-xs-8\"><i>" + opeShopLabel + "：</i><span class=\"text-muted\">" + checkDataCache[i].opeShopName + "</span></p>" +
                    "<p class=\"col-md-8 col-xs-8\"><i>样品：</i><span class=\"text-muted\">" + checkDataCache[i].foodName + "</span></p>" +
                    "<p class=\"col-md-12 col-xs-12\"><i>项目：</i><span class=\"text-muted\">" + checkDataCache[i].itemName + "</span></p>" +
                    "<p class=\"col-md-8 col-xs-8\"><i>时间：</i><span class=\"text-muted\">" + checkDataCache[i].checkDate + "</span></p>" +
                    "<p class=\"col-md-4 col-xs-4\"><i>结果：</i><span class=\"cs-red-text\">" + checkDataCache[i].conclusion + "</span></p></li>");
            }
        }
    }
}
/**************************************查看检测数据相关-end****************************************************************/
//检测数据列表的检测趋势图
var option = {
    tooltip: {
        trigger: 'axis',
        confine:true,//是否将 tooltip 框限制在图表的区域内。
        axisPointer: {
            type: 'cross',
            label: {
                show: true,
                backgroundColor: '#6a7985'
            }
        },formatter: function(params) {
            let str = '';
            params.forEach((item) => {
                str +='<p style="display: block;margin-right: 4px"><span style="display:inline-block;margin-right:5px;border-radius:50%;width:10px;height:10px;left:5px;background-color:' + item.color + '"></span>' + item.seriesName + ' : ' + item.value+'</p >';
            });
            return str;
        }
    },
    legend: {
        data: ['合格', '不合格']
    },
    grid: {
        left: '3%',
        right: '8%',
        bottom: '3%',
        top: '18%',
        containLabel: true
    },
    xAxis: [{
        type: 'category',
        boundaryGap: false,
        data: ['10-17', '10-18', '10-19', '10-20', '10-21', '10-22', '10-23'],
        splitLine: {
            show: true
        },
        axisLine: {
            lineStyle: {
                /* color: '#3259B8' */
            }
        },
        axisLabel: {
            /* interval: 0,  */
            rotate: 0,
            show: true,
            splitNumber: 15,
            textStyle: {
                fontSize: 12
            }
        }
    }],
    yAxis: [{
        type: 'value',
        axisLine: {
            lineStyle: {
                /* color:'#3259B8' */
            }
        }
    }],
    series: [{
        name: '合格',
        type: 'line',
        stack: '总量1',
        areaStyle: {
            normal: {
                color: new echarts.graphic.LinearGradient(0, 0, 0, 0)
            }
        },
        data: [220, 182, 191, 234, 290, 330, 310]
    },
        {
            name: '不合格',
            type: 'line',
            stack: '总量2',
            areaStyle: {
                normal: {
                    color: new echarts.graphic.LinearGradient(0, 0, 0, 0)
                }
            },
            data: [10, 3, 4, 15, 5, 7, 1]
        },
        {
            name: '合计总量',
            type: 'bar',
            stack: '食品种类',
            label: {
                normal: {
                    offset: ['50', '80'],
                    show: false,
                    position: 'insideBottom',
                    formatter: '{c}',
                    textStyle: {
                        color: '#000'
                    }
                }
            },
            itemStyle: {
                normal: {
                    color: 'rgba(128, 128, 128, 0)'
                }
            },
            data: [220, 182, 191, 234, 290, 330, 310]
        }]
};
function loadingChart() {
    //折线图
    var myChart = echarts.init(document.getElementById('sixth'), "shine");
    myChart.setOption(option);
}
//查看检测数据
function viewDataCheckRecording(id) {
    $("#iframe1").attr("src", rootPath + "/dataCheck/recording/checkDetail.do?source=monitor&id=" + id);
    $('.cs-modal-box').show();
}

//查看抽样单
function viewSampling(samplingNo) {
    $("#iframe1").attr("src", rootPath + "/samplingDetail/details.do?source=monitor&samplingNo=" + samplingNo);
    $('.cs-modal-box').show();
}
