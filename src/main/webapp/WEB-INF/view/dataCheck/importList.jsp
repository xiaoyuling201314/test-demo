<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/WEB-INF/view/common/resource.jsp" %>
<html>
<head>
    <title>快检服务云平台</title>
</head>
<body>
<div class="cs-col-lg clearfix">
    <!-- 面包屑导航栏  开始-->
    <ol class="cs-breadcrumb">
        <li class="cs-fl"><img src="${webRoot}/img/set.png" alt=""/> <a href="javascript:">数据中心</a></li>
        <li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
        <li class="cs-b-active cs-fl">基础数据导入</li>
    </ol>
    <div class=" cs-fl" style="margin:3px 0 0 30px;">
        <select class="check-date cs-selcet-style" id="type" style="width: 120px;" onchange="changeType();">
           <%-- <option value="1">检测数据</option>--%>
            <option value="2">监管对象</option>
            <option value="3">经营户</option>
           <%--这边只做查询，没有做导入功能--%>
            <option value="7">仪器检测项目</option>
               <%--update by xiaoyl 2022/05/20 注释掉以下数据导入入口，目前各个平台都没有使用这两个导入功能--%>
           <%-- <option value="4">人员信息</option>
            <option value="6">送检单位</option>--%>
        </select>
    </div>
    <!-- 面包屑导航栏  结束-->
    <div class="cs-search-box cs-fr">
        <form>
            <div class="cs-search-filter clearfix cs-fl">
                <input class="cs-input-cont cs-fl focusInput" type="text" name="departName" id="departName" placeholder="请输入机构名称"/>
                <input type="button" onclick="changeType()" class="cs-search-btn cs-fl" href="javascript:;" value="搜索">
            </div>
            <a id="importBtn" class="cs-menu-btn" href="${webRoot}/dataCheck/recording/toImport"><i class="icon iconfont icon-zengjia"></i>导入</a>
            <div class="clearfix cs-fr" id="showBtn"></div>
        </form>
    </div>
</div>
<div id="dataList"></div>

<!-- Modal 提示窗-删除-->
<div class="modal fade intro2" id="confirm-delete" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
     aria-hidden="false">
    <div class="modal-dialog cs-alert-width">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">确认删除</h4>
            </div>
            <div class="modal-body cs-alert-height cs-dis-tab">
                <div class="cs-text-algin">
                    <img src="${webRoot}/img/stop2.png" width="40px"/>确认删除该记录吗？
                </div>
            </div>
            <div class="modal-footer">
                <a class="btn btn-danger btn-ok" onclick="deleteByID()">删除</a>
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
            </div>
        </div>
    </div>
</div>
<script src="${webRoot}/js/datagridUtil.js"></script>
<%@ include file="/WEB-INF/view/common/exportDialog.jsp" %>
<script type="text/javascript">
    var del = 0;
    var delObj;
    var deleteId;
    var exports = 0;
    var exportObj;
    //遍历操作权限
    for (var i = 0; i < childBtnMenu.length; i++) {
        if (childBtnMenu[i].operationCode == "1379-1") {
            del = 1;
            delObj = childBtnMenu[i];
        }
    }

    $(function () {
        $("#type").val('${importType}' == '' ? 2 : '${importType}');
        changeType();
    });

    function changeType() {
        var op = {
            tableId: "dataList", //列表ID
            tableAction: "${webRoot}/dataCheck/recording/importListData.do", //加载数据地址
            onload: function () {
                var type = $("#type").val();
                var link = '${webRoot}/resources/';
                /*if(type=='1'){
                 link = '
                ${webRoot}/resources/checkdata/';
                 }else if(type=='2'){
                 link = '
                ${webRoot}/resources/object/';
                 }else if(type=='3'){
                 link = '
                ${webRoot}/resources/business/';
                 }else if(type=='4'){
                 link = '
                ${webRoot}/resources/workers/';
                 }*/
                var obj = datagridOption["obj"];
                $(".rowTr").each(function () {
                    for (var i = 0; i < obj.length; i++) {
                        if ($(this).attr("data-rowId") == obj[i].id) {
                            //$(this).children('td').eq(3).html();
                            var right = obj[i].sourceFile;
                            if (right != '') {
                                var sourceName = right.substring(right.lastIndexOf("/") + 1);
                                if (sourceName && sourceName != 'null') {
                                    $(this).children('td').eq(3).html("<a class=\"cs-text-detailed cs-text-nowrap\" style=\"text-align: center;\" title=\"" + sourceName + "\" href='" + link + right + "'>" + sourceName + "</a>");
                                } else {
                                    $(this).children('td').eq(3).html('');
                                }
                            }
                            var err = obj[i].errFile;
                            if (obj[i].failCount != 0) {
                                var sourceName = right.substring(err.lastIndexOf("/") + 1);
                                if (sourceName && sourceName != 'null') {
                                    $(this).children('td').eq(5).html("<a class=\"cs-link text-primary\"  style=\"text-align: center;\" title=\"" + sourceName + "\" href='" + link + err + "'>" + obj[i].failCount + "</a>");
                                } else {
                                    $(this).children('td').eq(5).html('');
                                }
                            }
                        }
                    }
                });
            },
            parameter: [ //列表拼接参数
                {
                    columnCode: "departName",
                    columnName: "所选机构"
                }, {
                    columnCode: "username",
                    columnName: "导入人员",
                    columnWidth: '12%'
                }, {
                    columnCode: "sourceFile",
                    columnName: "导入文件",
                    columnWidth: '15%'
                }, {
                    columnCode: "successCount",
                    columnName: "成功",
                    columnWidth: '5%'
                }, {
                    columnCode: "failCount",
                    columnName: "失败",
                    columnWidth: '5%'
                }, {
                    columnCode: "remark",
                    columnName: "备注",
                    columnWidth: '14%'
                }, {
                    columnCode: "importDate",
                    columnName: "开始时间",
                    queryType: 4,
                    columnWidth: '14%',
                    dateFormat: "yyyy-MM-dd HH:mm:ss"
                }, {
                    columnCode: "endDate",
                    columnName: "结束时间",
                    queryType: 4,
                    columnWidth: '14%',
                    dateFormat: "yyyy-MM-dd HH:mm:ss"
                }],
            funBtns: [/* {
             //删除按钮
             show : del,
             style : delObj,
             action : function(id) {
             deleteId = id;
             $("#confirm-delete").modal('toggle');
             }
             }  */],
            defaultCondition: [  //加载条件
                {
                    queryCode: "importType",
                    queryVal: 1
                }
            ]
        };
        datagridUtil.initOption(op);
        //datagridUtil.query();


        var type = $("#type").val();
        var link = '';
        if (type == '1') {
            link = '${webRoot}/dataCheck/recording/toImport';
        } else if (type == '2') {
            link = '${webRoot}/regulatory/regulatoryObject/toImport?type=2';
        } else if (type == '3') {
            link = '${webRoot}/regulatory/business/toImport?type=3';
        } else if (type == '4') {
            link = '${webRoot}/data/workers/toImport?type=4';
        } else if (type == '6') {
            link = '${webRoot}/inspection/unit/toImport2.do'
        }
        $("#importBtn").attr("href", link);
        datagridOption.defaultCondition[0].queryVal = type;
        datagridUtil.queryByFocus();
    }

    //删除函数
    function deleteByID() {
        $.ajax({
            type: "POST",
            url: '${webRoot}' + "/dataCheck/recording/deleteImport.do",
            data: {
                "id": deleteId
            },
            success: function (data) {
                if (data && data.success) {
                    datagridUtil.query();
                }
            },
            error: function () {
                console.log("删除失败!");
            }
        });
        $("#confirm-delete").modal('toggle');
    }
</script>
</body>
</html>
