<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/WEB-INF/view/common/resource.jsp" %>
<html>
<head>
    <title>农产品合格证管理云平台</title>
    <%--复制功能js的引入--%>
    <script src="${webRoot}/plug-in/clipboard/clipboard.min.js"></script>
    <style>
        .cs-modal-box2 {
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: #fff;
            width: 100%;
            z-index: 100000;
        }

        .cs-table-responsive {
            padding-bottom: 65px;
        }

        .container {
            margin-left: 30px;
            margin-top: 20px;
        }

        .containers {
            margin-left: 30px;
            margin-top: 10px;
        }

        h1 {
            padding-bottom: 10px;
            color: darkmagenta;
            font-weight: bolder;
        }

        img {
            cursor: pointer;
        }

        #pic {
            position: absolute;
            display: none;
        }

        #pic1 {
            width: 100px;
            background-color: #fff;
            border-radius: 5px;
            -webkit-box-shadow: 5px 5px 5px 5px hsla(0, 0%, 5%, 1.00);
            box-shadow: 5px 5px 5px 0px hsla(0, 0%, 5%, 0.3);
        }

        #pic1 img {
            width: 100%;
        }
    </style>
</head>
<body>
<div class="cs-col-lg clearfix">
    <!-- 面包屑导航栏  开始-->
    <%--<div id="tab_bar"></div>--%>
    <!-- 面包屑导航栏  结束-->
    <%--<div class="cs-search-box cs-fr">
        <form action="datagrid.do">
            <div class="cs-search-filter clearfix cs-fl">
                <input class="cs-input-cont cs-fl focusInput" type="text" name="keyWords" placeholder="请输入内容"/>
                <input type="button" onclick="dgu.queryByFocus();" class="cs-search-btn cs-fl"
                       href="javascript:;" value="搜索">
            </div>
            <div class="clearfix cs-fr" id="showBtn">
            </div>
        </form>
    </div>--%>
</div>

<div id="dataList"></div>

<%@include file="/WEB-INF/view/common/confirm.jsp" %>
<%@include file="/WEB-INF/view/common/modalBox.jsp" %>
<script src="${webRoot}/js/datagridUtil2.js"></script>
<%--引入ztree插件--%>
<script type="text/javascript">
    rootPath = "${webRoot}/report/template/"
    //initBar([{name: '系统管理'}, {name: '模板配置'}]);
    // if (Permission.exist("1528-1") == 1) {
    //     var html = '<a class="cs-menu-btn"  href="javascript:;" onclick="getId()"><i class="' + Permission.getPermission("1528-1").functionIcon + '"></i>新增</a>';
    //     $("#showBtn").prepend(html);
    // }
    var dgu = datagridUtil.initOption({
        tableId: "dataList",	//列表ID
        tableAction: "${webRoot}/report/template/datagrid.do",	//加载数据地址
        funColumnWidth: "140px", 		//操作列宽度，默认100px
        tableBar: {
            title: ["企业管理", "报告模板管理"],
            hlSearchOff: 0,
            ele: [{
                eleShow: 1,
                eleName: "keyWords",
                eleType: 0,
                elePlaceholder: "模板名称"
            }],
            topBtns: [{
                show: Permission.exist("1528-1"),
                style: Permission.getPermission("1528-1"),
                action: function (ids, rows) {
                    getId();
                }
            }],
        },
        onload: function () {
            pic();
            var time = new Date(new Date).Format("yyyy-MM-dd");
            $("#dataList").val(time);
            var obj = dgu.getData();
            $(".rowTr").each(function () {
                for (var i = 0; i < obj.length; i++) {
                    if ($(this).attr("data-rowId") == obj[i].id) {
                        if (obj[i].isDefault == 0) {//隐藏默认模板的设置默认模板操作按钮
                            $(this).find(".1528-4").hide();
                            break;
                        }
                    }
                }
            });
        },
        parameter: [		//列表拼接参数
            {
                columnCode: "templateName",
                columnName: "模板名称",
                //columnWidth: '15%',
                customElement: "<a data-mysrc='#previewImage#' class='container'>#templateName#</a>"

            },
            // {
            //     columnCode: "pageSize",
            //     columnName: "纸张规格",
            //     columnWidth: '180px'
            // },
            /*  {
                 columnCode: "printInstructionContent",
                 columnName: "打印指令",
                 columnWidth: '30%',
                 customStyle: "configParam",
                 customElement: "<pre>?</pre>"
             },
             {
                 columnCode: "remark",
                 columnName: "备注",
                 columnWidth: '12%'
             },*/
            {
                columnCode: "isDefault",
                columnName: "默认模板",
                customStyle: "isDefault",
                customVal: {0: "<span class='text-danger'>是</span>", 1: "<span class='text-success'>否</span>"},
                columnWidth: '180px'
            }, {
                columnCode: "checked",
                columnName: "审核状态",
                customVal: {0: "<span class='text-danger'>未审核</span>", 1: "<span class='text-success'>已审核</span>"},
                columnWidth: '180px'
            }
            , {
                columnCode: "updateDate",
                columnName: "更新时间",
                dateFormat: "yyyy-MM-dd HH:mm:ss",
                sortDataType: "date",
                columnWidth: '15%'
            }
        ],
        funBtns: [
            {
                show: Permission.exist("1528-2"),
                style: Permission.getPermission("1528-2"),
                action: function (id) {
                    getId(id);
                }
            },
            /*{
                show: Permission.exist("1501-4"),
                style: Permission.getPermission("1501-4"),
                action: function (id) {
                	//获取当前选中行的td文本
                    var text = $("tr[data-rowid=" + id + "]").find(".configParam").text();
                    var clipboard = new ClipboardJS('.icon', {//通过样式拿到按钮对象
                        text: function () {
                            return text;//返回指定的text文本
                        }
                    });
                    clipboard.on('success', function (e) {
                        console.log("复制成功");//复制成功
                        $("#waringMsg .tips").html("复制成功")
                        $("#confirm-warnning").modal('show');
                    });
                    clipboard.on('error', function (e) {
                        console.log("复制失败");//复制失败
                        $("#waringMsg .tips").html("复制失败")
                        $("#confirm-warnning").modal('show');
                    });
                }
            },*/
            {//设为默认模板
                show: Permission.exist("1528-4"),
                style: Permission.getPermission("1528-4"),
                action: function (id) {
                    idsStr = id;
                    $("#confirmModal .tips").html("确认将该模板设为默认模板吗？");
                    $("#confirmModal").modal('toggle');
                }
            },
            {
                show: Permission.exist("1528-3"),
                style: Permission.getPermission("1528-3"),
                action: function (id) {
                    idsStr = "{\"ids\":\"" + id.toString() + "\"}";
                    $("#confirm-delete").modal('toggle');
                    // idsStr = id;
                    // $("#confirm-delete").modal('toggle');
                }
            }

        ],
        bottomBtns: [
            {	//删除函数
                show: Permission.exist("1528-3"),
                style: Permission.getPermission("1528-3"),
                action: function (ids) {
                    // idsStr = ids;
                    idsStr = "{\"ids\":\"" + ids.toString() + "\"}";
                    $("#confirm-delete").modal('toggle');
                }
            }
        ]
    });
    dgu.query();

    function getId(id) {
        if (id != null) {
            showMbIframe('${webRoot}/report/template/edit.do?id=' + id);
        } else {
            showMbIframe('${webRoot}/report/template/edit.do');
        }
    }

    //删除
    <%--function deleteData() {--%>
    <%--    $.ajax({--%>
    <%--        type: "POST",--%>
    <%--        url: "${webRoot}/report/template/delete.do",--%>
    <%--        data: JSON.parse(idsStr),--%>
    <%--        dataType: "json",--%>
    <%--        success: function (data) {--%>
    <%--            $("#confirm-delete").modal('toggle');--%>
    <%--            if (data && data.success) {--%>
    <%--                //删除成功后刷新列表--%>
    <%--                dgu.queryByFocus();--%>
    <%--            } else {--%>
    <%--                layer.msg(data.msg, {icon: 2});--%>
    <%--            }--%>
    <%--        }--%>
    <%--    });--%>
    <%--}--%>

    //设置默认模板
    function confirmModal() {
        $.ajax({
            type: "POST",
            url: "${webRoot}/report/template/setDefault.do",
            data: {"id": idsStr},
            dataType: "json",
            success: function (data) {
                if (data && data.success) {
                    //删除成功后刷新列表
                    dgu.queryByFocus();
                } else {
                    layer.msg(data.msg, {icon: 2});
                }
            }
        });
    }

    //查看模板图片
    function pic() {
        $(".container").hover(function () {
            var tImg = $(this).attr('data-mysrc');
            if (tImg) {
                tImg = "${webRoot}/resources/" + tImg;
            }
            $(this).append("<p id='pic'><img src='" + tImg + "' id='pic1' style='height: auto;width: 300px'></p>");
            $(".container").mousemove(function (e) {
                $("#pic").css({"top": (e.pageY - 23) + "px", "left": (e.pageX + 4) + "px"}).fadeIn("fast");
            });
        }, function () {
            $("#pic").remove();
        });
    }
</script>
</body>
</html>