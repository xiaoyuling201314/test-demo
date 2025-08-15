<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/WEB-INF/view/common/resource.jsp" %>
<html>
<head>
    <title>快检服务云平台</title>
    <%--复制功能js的引入--%>
<script src="${webRoot}/plug-in/clipboard/clipboard.min.js"></script>
</head>
<body>
<div class="cs-col-lg clearfix">
    <!-- 面包屑导航栏  开始-->
    <ol class="cs-breadcrumb">
        <li class="cs-fl">
            <img src="${webRoot}/img/set.png" alt=""/>
            <a href="javascript:">系统管理</a></li>
        <li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
        <li class="cs-b-active cs-fl">系统参数配置
        </li>
    </ol>
    <!-- 面包屑导航栏  结束-->
    <div class="cs-search-box cs-fr">
        <form action="datagrid.do">
            <div class="cs-search-filter clearfix cs-fl">
                <input class="cs-input-cont cs-fl focusInput" type="text" name="keyWords" placeholder="请输入内容"/>
                <input type="button" onclick="datagridUtil.queryByFocus();" class="cs-search-btn cs-fl" href="javascript:;" value="搜索">
            </div>
            <div class="clearfix cs-fr" id="showBtn">
            </div>
        </form>
    </div>
</div>
<div id="dataList"></div>

<%@include file="/WEB-INF/view/common/confirm.jsp" %>
<%@include file="/WEB-INF/view/common/modalBox.jsp" %>
<script src="${webRoot}/js/datagridUtil.js"></script>
<%--引入ztree插件--%>
<script type="text/javascript">
    if (Permission.exist("1455-1") == 1) {
        var html = '<a class="cs-menu-btn"  href="javascript:;" onclick="getId()"><i class="' + Permission.getPermission("1455-1").functionIcon + '"></i>新增</a>';
        $("#showBtn").prepend(html);
    }
    var op = {
        tableId: "dataList",	//列表ID
        tableAction: "${webRoot}/system/datagrid.do",	//加载数据地址
        funColumnWidth:"80px",
        parameter: [		//列表拼接参数
            {
                columnCode: "configTypeName",
                columnName: "配置类型",
                columnWidth: '120px'
            },
            {
                columnCode: "configParam",
                columnName: "配置参数",
                customStyle: "configParam",
                customElement: "<pre>?</pre>" 
            },
            {
                columnCode: "description",
                columnName: "参数说明",
                columnWidth: '45%'
            },
            {
                columnCode: "updateDate",
                columnName: "更新时间",
                dateFormat: "yyyy-MM-dd HH:mm:ss",
                sortDataType:"date",
                columnWidth: '100px'
            }
        ],
        funBtns: [
            {
                show: Permission.exist("1455-2"),
                style: Permission.getPermission("1455-2"),
                action: function (id) {
                    getId(id);
                }
            },{
                show: Permission.exist("1455-4"),
                style: Permission.getPermission("1455-4"),
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
            },{
                show: Permission.exist("1455-3"),
                style: Permission.getPermission("1455-3"),
                action: function (id) {
                    idsStr = "{\"ids\":\"" + id.toString() + "\"}";
                    $("#confirm-delete").modal('toggle');
                }
            }
            
        ],
        bottomBtns: [
            {	//删除函数
            	show: Permission.exist("1455-3"),
                style: Permission.getPermission("1455-3"),
                action: function (ids) {
                    if(ids == ''){
                        $("#confirm-warnning .tips").text("请选择要删除的配置类型");
                        $("#confirm-warnning").modal('toggle');
                    }else {
                    idsStr = "{\"ids\":\"" + ids.toString() + "\"}";
                    $("#confirm-delete").modal('toggle');
                }
            }
            }
        ]
    };
    datagridUtil.initOption(op);
    datagridUtil.query();

    function getId(id) {
        if (id!=null) {
        	showMbIframe('${webRoot}/system/queryById.do?id='+id);
        } else {
        	showMbIframe('${webRoot}/system/queryById.do');
        }
    }

    //删除
    function deleteData() {
        $.ajax({
            type: "POST",
            url: "${webRoot}/system/delete.do",
            data: JSON.parse(idsStr),
            dataType: "json",
            success: function (data) {
                $("#confirm-delete").modal('toggle');
                if (data && data.success) {
                    //删除成功后刷新列表
                    datagridUtil.queryByFocus();
                } else {
                    $("#waringMsg>span").html(data.msg);
                    $("#confirm-warnning").modal('toggle');
                }
            }
        });
    }
</script>
</body>
</html>