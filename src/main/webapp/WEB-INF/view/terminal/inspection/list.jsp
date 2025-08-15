<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/WEB-INF/view/common/resource.jsp" %>
<html>
<head>
    <title>快检服务云平台</title>
</head>

<body>
<div class="cs-col-lg clearfix">
    <ol class="cs-breadcrumb">
        <li class="cs-fl">
            <img src="${webRoot}/img/set.png" alt=""/>
            <a href="javascript:">客户管理</a></li>
        <li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
        <li class="cs-b-active cs-fl">经营者</li>
    </ol>
    <div class="cs-search-box cs-fr">
        <form>
            <div class="cs-search-filter clearfix cs-fl">
                <input class="cs-input-cont cs-fl focusInput" type="text" id="keyWords" name="keyWords" placeholder="单位名称、社会信用代码"/>
                <input type="button" class="cs-search-btn cs-fl" onclick="datagridUtil.queryByFocus()" href="javascript:;" value="搜索">
            </div>
            <div class="clearfix cs-fr" id="showBtn">
                <c:choose>
                    <c:when test="${coldUnitId != null}">
                        <a class="cs-menu-btn" href="${webRoot}/cold/unit/list.do?regTypeCode=${regulatoryType.regTypeCode}"><i class="icon iconfont icon-fanhui"></i>返回</a>
                    </c:when>
                    <c:otherwise>
                        <!-- 其他情况可以为空，也可以显示默认内容 -->
                    </c:otherwise>
                </c:choose>
            </div>
        </form>

    </div>
</div>
<div class="cs-tabtitle clearfix" id="tabtitle">
    <ul>
        <li class="cs-tabhover" data-tabtitleNo="1" data-comanyType="0">企业</li>
        <li data-tabtitleNo="2" data-comanyType="1">个体户</li>
        <%--<li data-tabtitleNo="3" data-comanyType="2">供应商</li>--%>
    </ul>
</div>
<div class="cs-tabcontent clearfix">
    <div class="cs-content2">
        <div id="dataList"></div>
    </div>
</div>
<%@include file="/WEB-INF/view/terminal/qrcode.jsp" %>
<%@ include file="/WEB-INF/view/common/exportDialog.jsp" %>
<%@include file="/WEB-INF/view/common/modalBox.jsp" %>
<%@include file="/WEB-INF/view/common/confirm.jsp" %>
<script src="${webRoot}/js/datagridUtil.js"></script>
<script type="text/javascript">
    var qrcodeUrl = "${webRoot}/inspection/unit/inspectionQrcode.do";//生成二维码地址
    var codeUrl = "${inspectionUnitPath}";
    var functionName = "经营者二维码";
    rootPath = "${webRoot}/inspection/unit/";
    var companyType = 0;
    if (Permission.exist("1439-1") == 1) {
        var html = '<a class="cs-menu-btn" onclick="addOrUpdateUnit(0,-1);"><i class="' + Permission.getPermission("1439-1").functionIcon + '"></i>新增</a>';
        $("#showBtn").prepend(html);
    }

    var coldUnitId = '${coldUnitId}';
    var url = '${webRoot}/inspection/unit/datagrid.do?companyType='+companyType;
    if (coldUnitId && coldUnitId.trim() !== '') {
        url += '&coldUnitId=' + encodeURIComponent(coldUnitId);
    }


    //切换列表
    $(".cs-tabtitle li").click(function () {
        var tabtitleNo = $(this).attr("data-tabtitleNo");
        if (tabtitleNo == "1") {
            companyType = 0;

            url = '${webRoot}/inspection/unit/datagrid.do?companyType='+companyType;
            if (coldUnitId && coldUnitId.trim() !== '') {
                url += '&coldUnitId=' + encodeURIComponent(coldUnitId);
            }
            op.tableAction=url;
            datagridUtil.initOption(op);
        } else if (tabtitleNo == "2") {
            companyType = 1;

            url = '${webRoot}/inspection/unit/datagrid.do?companyType='+companyType;
            if (coldUnitId && coldUnitId.trim() !== '') {
                url += '&coldUnitId=' + encodeURIComponent(coldUnitId);
            }
            persopnOption.tableAction=url;
            datagridUtil.initOption(persopnOption);
        }/* else if (tabtitleNo == "3") {
            companyType = 2;
            datagridUtil.initOption(supplierOption);
        }*/
        datagridUtil.query();
        //$(".companyType[value='" + $(this).attr("data-comanyType") + "']").click();
    });



    var op = {
        tableId: "dataList",
        //tableAction: '${webRoot}'+"/inspection/unit/datagrid.do?companyType=0&coldUnitId="+${coldUnitId},
        tableAction:url,
        defaultCondition: [
            {
                "queryCode": "companyType",
                "queryVal": 0
            }
        ],
        parameter: [
            {
                columnCode: "companyName",
                columnName: "经营者名称",
                rowSpan: "2",
                customStyle: "my_name",
                columnWidth: "20%"
            },
            {
                columnCode: "companyCode",
                columnName: "仓库编号",
                columnWidth: "8%"
            },
            {
                columnCode: "companyType",
                columnName: "类型",
                customVal: {"0": "企业", "1": "个人"},
                columnWidth: "8%"
            },
            {
                columnCode: "creditCode",
                columnName: "统一信用代码",
                rowSpan: "2",
                columnWidth: "16%"
            },
            /*
            {
                columnCode: "legalPerson",
                columnName: "法定代表人",
                columnWidth: "10%"
            },
            {
                columnCode: "legalPhone",
                columnName: "法人联系方式",
                columnWidth: "10%"
            },*/
            {
                columnCode: "id",
                columnName: "二维码",
                customElement: "<a class=\"runcode qrcode\" data-value='?' href=\"javascript:;\"><img src=\"${webRoot}/img/2dcode.png\" alt=\"\" /></a>",
                columnWidth: "70px"
            },
            {
                columnCode: "companyAddress",
                columnName: "详细地址",
                columnWidth: "16%"
            },
            {
                columnCode: "linkUser",
                columnName: "联系人",
                columnWidth: "8%"
            },
            {
                columnCode: "linkPhone",
                columnName: "联系方式",
                columnWidth: "16%"
            },

            {
                columnCode: "userNumber",
                columnName: "用户",
                customElement: "<a class='text-primary cs-link _user_number'>?个<a>",
                columnWidth: "9%"
            },
            /*
            {
                columnCode: "reqNumber",
                columnName: "委托单位",
                customElement: "<a class='text-primary cs-link _req_number'>?个<a>",
                columnWidth: "9%"
            },
            */

            {
                columnCode: "checked",
                columnName: "审核状态",
                customVal: {"0": "<span class='text-danger'>未审核</span>", "1": "<span class='text-success'>已审核<span>"},
                columnWidth: "8%"
            }/*,
            {
                columnCode: "supplier",
                columnName: "是否供应商",
                customVal: {"1": "<span class='text-success'>是<span>", "0": "<span class='text-danger'>否</span>"},
                columnWidth: "8%"
            },
            {
                columnCode: "state",
                columnName: "营业状态",
                customVal: {"0": "开业", "1": "<span class='text-danger'>停业</span>"},
                columnWidth: "8%"
            }*/
        ],
        funBtns: [
            {	//编辑
                show: Permission.exist("1439-2"),
                style: Permission.getPermission("1439-2"),
                action: function (id) {
                    addOrUpdateUnit(id, 0);
                }
            }, {//删除
                show: Permission.exist("1439-3"),
                style: Permission.getPermission("1439-3"),
                action: function (id) {
                    idsStr = id;
                    $("#confirm-delete2").modal('toggle');
                }
            }
        ],
        rowTotal: 0,	//记录总数
        pageSize: pageSize,	//每页数量
        pageNo: 1,	//当前页序号
        pageCount: 1,	// 总页数
        bottomBtns: [{
            show: Permission.exist('1439-6'),	//查看二维码
            style: Permission.getPermission('1439-6'),
            action: function (ids) {
                if (ids == '') {
                    $("#confirm-warnning .tips").text("请选择委托单位");
                    $("#confirm-warnning").modal('toggle');
                } else {
                    var arr = [];
                    var obj = datagridOption.obj;
                    for (var i = 0; i < obj.length; i++) {
                        if (ids.indexOf(obj[i].id + "") != -1) {
                            arr.push({'id': obj[i].id, 'name': obj[i].companyName})
                        }
                    }
                    viewQrcode(arr);
                }
            }
        },
            {//导入送检单位（企业）按钮
                show: Permission.exist('1439-5'),
                style: Permission.getPermission('1439-5'),
                action: function (ids) {
                    location.href = '${webRoot}/inspection/unit/toImport.do?companyType=0'
                }
            },
            {//导出送检单位（企业）按钮
                show: Permission.exist('1439-7'),
                style: Permission.getPermission('1439-7'),
                action: function (ids) {
                    $("#exportModal").modal('show');
                }
            },
            {	//删除函数
                show: Permission.exist("1437-3"),
                style: Permission.getPermission("1437-3"),
                action: function (ids) {
                    if (ids == '') {
                        $("#confirm-warnning .tips").text("请选择送检单位");
                        $("#confirm-warnning").modal('toggle');
                    } else {
                        idsStr = ids;
                        $("#confirm-delete2").modal('toggle');
                    }
                }
            }
        ]

    };
    //个人送检单位数据列表
    var persopnOption = {
        tableId: "dataList",
        //tableAction: '${webRoot}'+"/inspection/unit/datagrid.do?companyType=1&coldUnitId="+${coldUnitId},
        tableAction:url,
        defaultCondition: [
            {
                "queryCode": "companyType",
                "queryVal": 1
            }
        ],
        parameter: [
            {
                columnCode: "companyName",
                columnName: "名称",
                customStyle: "my_name",
                columnWidth: "20%"
            },
            {
                columnCode: "companyCode",
                columnName: "仓库编号",
                columnWidth: "8%"
            },
            {
                columnCode: "companyType",
                columnName: "类型",
                customVal: {"0": "企业", "1": "个人"},
                columnWidth: "8%"
            },
            {
                columnCode: "creditCode",
                columnName: "身份证号码",
                columnWidth: "16%"
            },
            {
                columnCode: "id",
                columnName: "二维码",
                customElement: "<a class=\"runcode qrcode\" data-value='?' href=\"javascript:;\"><img src=\"${webRoot}/img/2dcode.png\" alt=\"\" /></a>",
                columnWidth: "70px"
            },
            /*
            {
                columnCode: "reqNumber",
                columnName: "委托单位",
                customElement: "<a class='text-primary cs-link _req_number'>?个<a>",
                columnWidth: "9%"
            },
             */
            {
                columnCode: "companyAddress",
                columnName: "详细地址",
                columnWidth: "16%"
            },
            {
                columnCode: "linkUser",
                columnName: "联系人",
                columnWidth: "8%"
            },
            {
                columnCode: "linkPhone",
                columnName: "联系方式",
                columnWidth: "16%"
            },
            {
                columnCode: "userNumber",
                columnName: "用户",
                customElement: "<a class='text-primary cs-link _user_number'>?个<a>",
                columnWidth: "10%"
            },
            {
                columnCode: "checked",
                columnName: "审核状态",
                customVal: {"0": "<span class='text-danger'>未审核</span>", "1": "已审核"},
                columnWidth: "8%"
            }
        ],
        funBtns: [
            {	//编辑
                show: Permission.exist("1439-2"),
                style: Permission.getPermission("1439-2"),
                action: function (id) {
                    addOrUpdateUnit(id, 1);
                }
            }, {//删除
                show: Permission.exist("1439-3"),
                style: Permission.getPermission("1439-3"),
                action: function (id) {
                    idsStr = id;
                    $("#confirm-delete2").modal('toggle');
                }
            }
        ],
        rowTotal: 0,	//记录总数
        pageSize: pageSize,	//每页数量
        pageNo: 1,	//当前页序号
        pageCount: 1,	// 总页数
        bottomBtns: [{
            show: Permission.exist('1439-6'),	//查看二维码
            style: Permission.getPermission('1439-6'),
            action: function (ids) {
                if (ids == '') {
                    $("#confirm-warnning .tips").text("请选择委托单位");
                    $("#confirm-warnning").modal('toggle');
                } else {
                    var arr = [];
                    var obj = datagridOption.obj;
                    for (var i = 0; i < obj.length; i++) {
                        if (ids.indexOf(obj[i].id + "") != -1) {
                            arr.push({'id': obj[i].id, 'name': obj[i].companyName})
                        }
                    }
                    viewQrcode(arr);
                }
            }
        },
            {//导入送检单位（个人）按钮
                show: Permission.exist('1439-5'),
                style: Permission.getPermission('1439-5'),
                action: function (ids) {
                    location.href = '${webRoot}/inspection/unit/toImport.do?companyType=1'
                }
            },
            {//导出送检单位（个人）按钮
                show: Permission.exist('1439-7'),
                style: Permission.getPermission('1439-7'),
                action: function (ids) {
                    $("#exportModal").modal('show');
                }
            },
            {	//删除函数
                show: Permission.exist("1437-3"),
                style: Permission.getPermission("1437-3"),
                action: function (ids) {
                    if (ids == '') {
                        $("#confirm-warnning .tips").text("请选择送检单位");
                        $("#confirm-warnning").modal('toggle');
                    } else {
                        idsStr = ids;
                        $("#confirm-delete2").modal('toggle');
                    }
                }
            }
        ]

    };
    //供应商数据列表
    /*var supplierOption = {
        tableId: "dataList",
        tableAction: "${webRoot}/inspection/unit/datagrid",
        defaultCondition: [
            {
                "queryCode": "companyType",
                "queryVal": 2
            }
        ],
        parameter: [
            {
                columnCode: "companyName",
                columnName: "单位名称",
                rowSpan: "2",
                customStyle: "my_name",
                columnWidth: "20%"
            },
            {
                columnCode: "creditCode",
                columnName: "社会信用代码",
                rowSpan: "2",
                columnWidth: "16%"
            },
            {
                columnCode: "legalPerson",
                columnName: "法定代表人",
                columnWidth: "10%"
            },
            {
                columnCode: "legalPhone",
                columnName: "法人联系方式",
                columnWidth: "10%"
            },
            {
                columnCode: "id",
                columnName: "二维码",
                customElement: "<a class=\"runcode qrcode\" data-value='?' href=\"javascript:;\"><img src=\"${webRoot}/img/2dcode.png\" alt=\"\" /></a>",
                columnWidth: "70px"
            },
            {
                columnCode: "userNumber",
                columnName: "送检用户",
                customElement: "<a class='text-primary cs-link _user_number'>?个<a>",
                columnWidth: "9%"
            },
            {
                columnCode: "reqNumber",
                columnName: "委托单位",
                customElement: "<a class='text-primary cs-link _req_number'>?个<a>",
                columnWidth: "9%"
            },
            {
                columnCode: "checked",
                columnName: "单位状态",
                customVal: {"0": "<span class='text-danger'>停用</span>", "1": "启用"},
                columnWidth: "8%"
            },
            {
                columnCode: "state",
                columnName: "营业状态",
                customVal: {"0": "开业", "1": "<span class='text-danger'>停业</span>"},
                columnWidth: "8%"
            }
        ],
        funBtns: [
            {	//编辑
                show: Permission.exist("1439-2"),
                style: Permission.getPermission("1439-2"),
                action: function (id) {
                    addOrUpdateUnit(id, 0);
                }
            }, {//删除
                show: Permission.exist("1439-3"),
                style: Permission.getPermission("1439-3"),
                action: function (id) {
                    idsStr = id;
                    $("#confirm-delete2").modal('toggle');
                }
            }
        ],
        rowTotal: 0,	//记录总数
        pageSize: pageSize,	//每页数量
        pageNo: 1,	//当前页序号
        pageCount: 1,	// 总页数
        bottomBtns: [{
            show: Permission.exist('1439-6'),	//查看二维码
            style: Permission.getPermission('1439-6'),
            action: function (ids) {
                if (ids == '') {
                    $("#confirm-warnning .tips").text("请选择委托单位");
                    $("#confirm-warnning").modal('toggle');
                } else {
                    var arr = [];
                    var obj = datagridOption.obj;
                    for (var i = 0; i < obj.length; i++) {
                        if (ids.indexOf(obj[i].id + "") != -1) {
                            arr.push({'id': obj[i].id, 'name': obj[i].companyName})
                        }
                    }
                    viewQrcode(arr);
                }
            }
        },
            {//导入送检单位（供应商）按钮
                show: Permission.exist('1439-5'),
                style: Permission.getPermission('1439-5'),
                action: function (ids) {
                    location.href = '${webRoot}/inspection/unit/toImport.do?companyType=2'
                }
            },
            {//导出送检单位（供应商）按钮
                show: Permission.exist('1439-7'),
                style: Permission.getPermission('1439-7'),
                action: function (ids) {
                    $("#exportModal").modal('show');
                }
            },
            {	//删除函数
                show: Permission.exist("1437-3"),
                style: Permission.getPermission("1437-3"),
                action: function (ids) {
                    if (ids == '') {
                        $("#confirm-warnning .tips").text("请选择送检单位");
                        $("#confirm-warnning").modal('toggle');
                    } else {
                        idsStr = ids;
                        $("#confirm-delete2").modal('toggle');
                    }
                }
            }
        ]

    };*/
    //console.log("datagridUtil: ", datagridUtil);
    datagridUtil.initOption(op);
    datagridUtil.query();

    //新增、更新送检单位
    function addOrUpdateUnit(id, type) {
        if (type < 0) {
            type = companyType;
        }
        var url = id ? "${webRoot}/inspection/unit/queryById?id=" + id + "&type=" + type : "${webRoot}/inspection/unit/queryById?type=" + type;
        showMbIframe(url);

    }

    //查看送检单位-用户
    $(document).on("click", "._user_number", function () {
        showMbIframe("${webRoot}/inspUnitUser/list?inspUnitId=" + $(this).parents(".rowTr").attr("data-rowId"));
    });
    //查看送检单位-委托单位
    $(document).on("click", "._req_number", function () {
        showMbIframe("${webRoot}/ins_req/queryByInspId?inspId=" + $(this).parents(".rowTr").attr("data-rowId"));
    });

    //导出方法
    function exportFile() {
        var radios = document.getElementsByName('inlineRadioOptions');
        var ext = '';
        for (var i = 0; i < radios.length; i++) {
            if (radios[i].checked) {
                ext = radios[i].value;
            }
        }
        if (ext != '') {
            location.href = "${webRoot}/inspection/unit/exportFile.do?types=" + ext + "&companyType=" + companyType + "&keyWords=" + $("#keyWords").val();
            $("#exportModal").modal('hide');
        } else {
            $("#exportModal").modal('hide');
            $("#confirm-warnning .tips").text("请选择导出格式!");
            $("#confirm-warnning").modal('toggle');
        }
    }

</script>
</body>
</html>
