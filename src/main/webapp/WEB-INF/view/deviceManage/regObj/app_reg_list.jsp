<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/WEB-INF/view/deviceManage/resource.jsp" %>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>被检单位管理</title>
    <meta name="description" content="">
    <meta name="author" content="食安科技">
    <meta name="viewport" content="initial-scale=1, maximum-scale=1, user-scalable=no">
    <meta name="format-detection" content="telephone=no">
    <link rel="stylesheet" type="text/css" href="${webRoot}/css/iconfont/iconfont.css"/>
    <link rel="stylesheet" href="${webRoot}/plug-in/weui/lib/weui.min.css">
    <link rel="stylesheet" href="${webRoot}/plug-in/weui/css/jquery-weui.css">
    <link rel="stylesheet" type="text/css" href="${webRoot}/device/css/bootstrap.css"/>

    <style>
        *{
            outline:0
        }
        body {
            /* background: #f5f5f5; */
            min-width: 320px;
            /* max-width: 480px; */
            margin: 0 auto;
            position: relative;
            min-height: 100%;
            padding-bottom: 56px;
            height: 100%;
            font-size: 14px;
            overflow: auto;
        }

        .stats-search2 .icon-chakan {
            left: 10px;
            position: absolute;
            top: 1px;
            color: #1f93f7;
        }

        .badge-wraming {
            background: #299afb;
        }

        .new-type {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            bottom: 0;
        }

        .ui-header h4 a:first-child,
        .ui-header h4,
        .ui-header .iconfont {
            color: #fff;
        }

        .ui-header h4 {
            background: #0095ff;
        }

        .ui-header h4 {
            /* background: #fff; */
            height: 50px;
            line-height: 50px;
            text-align: center;
            color: #000;
            padding: 0;
            margin: 0;
            font-size: 18px;
            position: relative;
            font-weight: normal;
        }

        .select-all {
            line-height: 48px;
            padding-left: 10px;
            position: absolute;
            top: 0;
        }


        .ui-header h4 a:first-child {
            position: absolute;
            /* color: #fff; */
            left: 10px;
            font-size: 20px;
            width: 36px;

            /* z-index: 1; */
        }

        .iconfont {
            font-weight: normal;
        }

        .ui-header h4 a:first-child,
        .ui-header h4,
        .ui-header .iconfont {
            color: #fff;
        }

        .addSample {
            position: absolute;
            right: 20px;
            top: 0;
            height: 48px;
        }

        .ui-header h4 a:first-child,
        .ui-header h4,
        .ui-header .iconfont {
            color: #fff;
        }

        .add-item {
            font-size: 15px;
            color: #fff;
        }


        .stats-search {
            box-shadow: none;
            background: rgba(255, 255, 255, 0.6);
            box-shadow: 0 0 4px #ddd;
            position: relative;
            text-align: center;
            align-items: center;
            justify-content: space-between;
            padding: 0 10px;
        }

        .stats-search2 input {
            border: 0;
            box-shadow: 0 0 4px #ccc;
        }

        .stats-search input {
            width: calc(100% - 62px);
            padding: 8px 4px;
            margin: 6px 0;
            margin-right: 0;
            border: 1px solid #eee;
            padding-left: 30px;
            border-radius: 5px;

        }

        input,
        button,
        select,
        textarea {
            font-family: inherit;
            font-size: inherit;
            line-height: inherit;
        }

        .refresh-all {
            padding: 0 10px 0 10px;
        }

        .invoice-list {
            overflow: auto;
            position: fixed;
            top: 105px;
            bottom: 0;
            left: 0;
            right: 0;
            padding: 5px 10px;
        }

        .invoice-li {
            box-shadow: 0 0 4px #ccc;
            /* box-shadow: none; */
            margin-bottom: 10px;
            background: #fff;
            border-radius: 5px;
        }

        .risk-check {
            padding: 10px;
        }

        .is-flex {
            display: flex;
        }

        .round-check {
            padding: 0;
            align-items: center;
            width: 100%;
        }

        .num-box {
            font-size: 14px;
            font-weight: bold;
            padding-right: 5px;
            position: relative;
            display: flex;
            align-items: center;
            width: 40px;
            justify-content: center
        }

        .text-primary {
            color: #4076f0;
        }

        .round-info {
            flex-direction: column;
            flex: 1;
            position: relative;
            padding-left: 10px;
        }

        .cut-line {
            background: #ddd;
            width: 1px;
            height: 100%;
            position: absolute;
            top: 0;
            bottom: 0;
            left: 0;
        }

        div.invoice-info p {
            line-height: 22px;
            margin: 5px 0 0 0;
        }

        .round-info {
            flex-direction: column;
            flex: 1;
            position: relative;
            padding-left: 10px;
        }
        .list-btn{
            line-height: 50px;
            width: 40px;
            justify-content: end;
        }
        .btn-primary{
            height:38px;
            background-color: #0089ff;
            border-color: #0069c5;
        }
    </style>
</head>

<body class="body-bg">
    <div class="all-content new-type">
        <div class="ui-header first-header">
            <h4>
<%--                <a href="javascript:window.history.back();" class="icon iconfont icon-zuo"></a>--%>
                被检单位管理
                <a href="${webRoot}/iRegulatory/Object/regAddApp?userToken=${userToken}" class="addSample check-detail" style="right:10px;left: auto;width: auto;">
                    <i class="iconfont icon-zengjia text-primary"></i><span class="add-item">新增</span>
                </a>
            </h4>
        </div>
        <div class="stats-search stats-search2 is-flex">
            <a href="#" class="pull-left clearfix select-all">
                <i class="icon iconfont icon-chakan"></i>
            </a>
            <input id="keywords" class="insert-company" type="text" placeholder="请输被检单位">
            <button class="btn btn-primary" onclick="loadData();">搜索</button>
        </div>
        <div id="pull-refresh" class="refresh-all" ontouchstart>
            <div id="regList" class="invoice-list clearfix"></div>
        </div>
    </div>

    <div id="regTemplete" style="display: none;">
        <div class="invoice-li invoice-control weui-cell_swiped">
            <div class="law-box risk-check is-flex">
                <div class="round-check is-flex">
                    <div class="num-box text-primary"></div>
                    <div class="round-info is-flex">
                        <div class="cut-line"></div>
                        <div><b class="regName"></b></div>
                        <div class=" text-left invoice-info">
                            <p>
                                <a class="goBusList"><span class="text-primary busNum"></span></a>
                            </p>
                        </div>
                    </div>
                    <div class="list-btn is-flex">
                        <a class="editReg"><i class="iconfont icon-xiugai text-primary"></i></a>
                    </div>
                </div>
            </div>
        </div>
    </div>


<script type="text/javascript" src="${webRoot}/device/js/jquery.min1.11.3.js"></script>
<script type="text/javascript" src="${webRoot}/plug-in/weui/js/jquery-weui.js"></script>
<script type="text/javascript">
    var pageConfig = {
        pageSize: 10000,
        pageNo: 1,
        rowTotal: 0,
        pageCount: 0,
    };
    $(function(){
        var ut = '${userToken}';
        if (!ut) {
            $.toast("用户token已失效，请重新登录！", "cancel");
        } else {
            loadData();
        }
    });

    // $(document).on('change', '#keywords', function(){
    //     loadData();
    // });

    function loadData() {
        $.ajax({
            type: "GET",
            url: "${webRoot}/iRegulatory/Object/datagrid",
            data: {
                "pageSize": pageConfig.pageSize,
                "pageNo": pageConfig.pageNo,
                "regName": $("#keywords").val(),
                "userToken":"${userToken}"
            },
            dataType: "json",
            success: function(data) {
                if (data.success) {
                    if (data.obj.results.length > 0){
                        $("#regList").html("");
                        for (var i = 0; i < data.obj.results.length; i++) {
                            var item = data.obj.results[i];

                            var regIt = $("#regTemplete").clone();
                            regIt.find(".num-box").text((i + 1));
                            regIt.find(".regName").text(item.regName);
                            regIt.find(".editReg").attr("href","${webRoot}/iRegulatory/Object/regAddApp?id="+item.id+"&userToken=${userToken}");
                            if (item.showBusiness == '1') {
                                regIt.find(".goBusList").attr("href","${webRoot}/iRegulatory/Object/busListApp?regId="+item.id+"&regName="+encodeURI(item.regName)+"&userToken=${userToken}");
                                regIt.find(".busNum").text("经营户："+item.businessNumber+"户");
                            }
                            $("#regList").append(regIt.html());
                        }

                    } else {
                        $("#regList").html('<div class="invoice-li invoice-control weui-cell_swiped"><div class="law-box risk-check is-flex"><div class="round-check is-flex">暂无数据</div></div></div>');
                    }
                } else {
                    $.toast(msg, "cancel");
                }
            }
        });
    };

    //从编辑页面返回：延迟刷新数据
    window.addEventListener('pageshow', function (event) {
        //event.persisted属性为true时，表示当前文档是从往返缓存中获取
        //window.performance.navigation.type === 2: 网页通过“前进”或“后退”按钮加载
        if (event.persisted || window.performance && window.performance.navigation.type === 2) {
            setTimeout(function () {
                loadData();//当网页是从缓存中获取时需要重新加载数据
            }, 200)
        }
    }, false);

</script>

</body>
</html>
