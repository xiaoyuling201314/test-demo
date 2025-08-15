<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/WEB-INF/view/common/resource.jsp" %>
<html>
<head>
    <title>快检服务云平台</title>
</head>

<body>
<div class="cs-tabcontent clearfix">
    <div class="cs-content2">
        <div id="dataList"></div>
    </div>
</div>
<%@include file="/WEB-INF/view/common/confirm.jsp"%>
<%@include file="/WEB-INF/view/common/modalBox.jsp"%>
<script src="${webRoot}/js/datagridUtil2.js"></script>

<%--复制功能js的引入--%>
<script src="${webRoot}/plug-in/clipboard/clipboard.min.js"></script>
<script type="text/javascript">


    var dgu;
    dgu = datagridUtil.initOption({
        tableId: "dataList",
        tableAction: '${webRoot}' + "/sysLog/datagrid.do",
        funColumnWidth: "80px",
        funColumnStyle: "text-align: center;",
        tableBar: {
            title: ["日志管理","系统日志"],
            ele: [{
                eleShow: "${bean}"!="" ? 0 : 1,
                eleType: 4,
                eleHtml: "<span class=\"check-date cs-fl\">" +
                    "<span class=\"cs-name\" style=\"padding-right: 0px;\">操作模块：</span>" +
                    "<span class=\"cs-input-style \" style=\"margin-left: 0px;\">" +
                    "<select type=\"text\" name=\"sysLog.module\" class=\"choseModule focusInput\" onchange='choseRegType()' autocomplete=\"off\" style=\"width: 150px\" ></select>" +
                    "</span>" +
                    "</span>"
            },{
                eleTitle: "执行结果",
                eleName: "sysLog.operatorResult",
                eleShow: 0,
                eleType: 2,
                eleOption: ([
                    {
                    "text": "--全部--",
                    "val": ""
                    },
                    {"text": "成功", "val": "0"},
                    {"text": "失败", "val": "1"}]),
                eleStyle: "width:85px;"
            },{
                eleShow: 1,
                eleTitle: "时间范围",
                eleName: "operateTime",
                eleType: 3,
                eleStyle: "width:110px;",
                eleDefaultDateMin: ("${bean}"== "" ? new newDate().DateAdd("m",-1).format("yyyy-MM-dd") : ""),
                eleDefaultDateMax: ("${bean}"=="" ? new newDate().format("yyyy-MM-dd") : "")
            },{
                eleShow: 1,
                eleName: "keyWords",
                eleType: 0,
                elePlaceholder: "登录账号、IP、模块名称"
            }],
            switchSearch: function(queryType){
                if (queryType == 0) {
                    $("#dataList_checkDateStartDateInput").val($("#dataListcheckDateStart").val());
                    $("#dataList_checkDateEndDateInput").val($("#dataListcheckDateEnd").val());
                } else {
                    $("#dataListcheckDateStart").val(newDate($("#dataList_checkDateStartDateInput").val()).format("yyyy-MM-dd"));
                    $("#dataListcheckDateEnd").val(newDate($("#dataList_checkDateEndDateInput").val()).format("yyyy-MM-dd"));
                }
            }, topBtns: [{
                show: "${bean}"!="" ? 1 : 0,
                style: {"functionIcon":"icon iconfont icon-fanhui","operationName":"返回"},
                action: function(ids, rows){
                    parent.closeMbIframe();
                }
            }]
        },
        defaultCondition: [ //加载条件
            {
                queryCode: "sysLog.module",
                queryVal: "${bean.module}"
            },{
                queryCode: "sysLog.userName",
                queryVal: "${bean.userName}"
            },{
                queryCode: "sysLog.func",
                queryVal: "${bean.func}"
            },{
                queryCode: "sysLog.operatorResult",
                queryVal: "${bean.operatorResult}"
            }],
        before: function(queryType){
            //高级搜索
            if(queryType == 0){
                //清除时间范围查询条件
                dgu.delDefaultCondition("checkDateStartDateStr");
                dgu.delDefaultCondition("checkDateEndDateStr");
            }
        },
        parameter: [
            {
                columnCode: "userName",
                columnName: "操作账号",
                columnWidth: "10%",
                query: 1,
                queryCode: "sysLog.userName",
            },
            {
                columnCode: "remoteIp",
                customStyle: "remoteIp",
                columnName: "操作IP",
                columnWidth: "150px",
                query: 1
            },
            {
                columnCode: "param1",
                columnName: "归属地",
                // columnWidth: "16%",
                // query: 1
            },
            {
                columnCode: "module",
                columnName: "系统模块",
                columnWidth: "12%",
                query: 1,
                queryCode: "sysLog.module",
            },{
                columnCode: "func",
                columnName: "系统功能",
                columnWidth: "12%",
                query: 1,
                queryCode: "sysLog.func",
            },
            {
                columnCode: "requestParam",
                columnName: "请求参数",
                columnWidth: "15%",
                show:2
            },
            {
                columnCode: "operateTime",
                columnName: "操作时间",
                dateFormat: "yyyy-MM-dd HH:mm:ss",
                columnWidth: "160px",
                query: 1,
                queryCode: "operateTime",
                queryType: 3
            },
            {
                columnCode: "operatorResult",
                columnName: "执行结果",
                customVal: {"0": "<span>成功</span>", "1": "<span style='color: red'>失败</span>"},
                columnWidth: "90px",
                query: 1,
                queryType: 2,
                queryCode: "sysLog.operatorResult",
                sortDataType:'string'
            },
            {
                columnCode: "description",
                columnName: "描述信息",
                columnWidth: "15%",
                show:0
            },
            {
                columnCode: "exception",
                columnName: "异常信息",
                columnWidth: "15%",
                customStyle: "msgTd",
                show:2
            }
        ],
        funBtns: [{
            show: Permission.exist("22223-1"),
            style: Permission.getPermission("22223-1"),
            action: function (id) {
                showMbIframe("${webRoot}/sysLog/detail.do?id="+id);
            }
        }, {
            show: 0,
            style: Permission.getPermission("22223-2"),
            action: function (id) {
                //获取当前选中行的td文本
                var text = $("tr[data-rowid=" + id + "]").find(".msgTd").text();
                var clipboard = new ClipboardJS('.icon', {//通过样式拿到按钮对象
                    text: function () {
                        return text;//返回指定的text文本
                    }
                });
                clipboard.on('success', function (e) {
                    $("#confirm-warnning .tips").text("复制成功");
                    $("#confirm-warnning").modal('show');
                    setTimeout(function (){
                        $("#confirm-warnning").modal('hide');
                    },2000)
                    console.log("复制成功");//复制成功

                });
                clipboard.on('error', function (e) {
                    $("#confirm-warnning .tips").text("复制失败");
                    $("#confirm-warnning").modal('show');
                    setTimeout(function (){
                        $("#confirm-warnning").modal('hide');
                    },2000)
                    console.log("复制失败");//复制失败
                });
            }
        },{//刷新归属地
                show: Permission.exist("22223-3"),
                style: Permission.getPermission("22223-3"),
                action: function (id) {
                    refreshAddress(id);
                }
            }
        ],
        onload: function(obj, pageData){
            //加载列表后执行函数
            $(".rowTr").each(function(){
                for(var i=0;i<obj.length;i++){
                    if($(this).attr("data-rowId") == obj[i].id){
                        if(obj[i].exception == ''){
                            //隐藏查看按钮
                            $(this).find(".22223-2").hide();
                        }
                    }
                }
            });
        }
    });
    dgu.queryByFocus();
    $(function(){
        // 查询操作模块
        choseModule();
    });
    function choseModule(){
        $(".choseModule").empty();
        $.ajax({
            url: "${webRoot}/sysLog/queryAllModule.do",
            type: "POST",
            dataType: "json",
            success: function (data) {
                let html='<option value="">--全部--</option>';;
                 if(data.success){
                     let list = data.obj;
                     list.forEach(item=>{
                         html+='<option value="'+item+'">'+item+'</option>';
                         });
                     $(".choseModule").append(html);
                 }
            }
        });
    }
    //选择操作模块
    function choseRegType(){
        dgu.addDefaultCondition("module", $("#choseModule").val());
        dgu.queryByFocus();
    }
    function refreshAddress(id){
        $.ajax({
            url: "${webRoot}/sysLog/refreshAddress.do",
            type: "POST",
            data:{"id":id},
            dataType: "json",
            success: function (data) {
                if (data && data.success) {
                    // $("#tips-success").modal('toggle');
                } else {
                    $("#confirm-warnning").modal('toggle');
                }
                dgu.queryByFocus();
            }
        });
    }
</script>
</body>
</html>
