<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/WEB-INF/view/common/resource.jsp" %>
<html>
<head>
    <title>委托单位</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<!-- 面包屑导航栏  开始-->
<ol class="cs-breadcrumb">
    <li class="cs-fl">
        <img src="${webRoot}/img/set.png" alt=""/>
        <a href="javascript:">客户管理</a></li>
    <li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
    <li class="cs-b-active cs-fl">送检单位</li>
    <li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
    <li class="cs-b-active cs-fl">配置委托单位</li>
</ol>
<!-- 面包屑导航栏  结束-->
<div class="cs-search-box cs-fr">
    <form action="datagrid.do">
        <div class="cs-search-filter clearfix cs-fl">
            <input class="cs-input-cont cs-fl focusInput" type="text" name="requesterName" placeholder="请输入内容"/>
            <input type="button" onclick="datagridUtil.queryByFocus();" class="cs-search-btn cs-fl" href="javascript:;" value="搜索">
        </div>
        <div class="clearfix cs-fr" id="showBtn">
            <a href="javascript:" onclick="parent.closeMbIframe(1);" class="cs-menu-btn"><i class="icon iconfont icon-fanhui"></i>返回</a>
        </div>
    </form>
</div>
</div>
<div id="dataList"></div>

<%--委托单位查看二维码--%>
<%@include file="/WEB-INF/view/common/confirm.jsp" %>
<script src="${webRoot}/js/datagridUtil.js"></script>
<script type="text/javascript" src="${webRoot}/plug-in/layer/layer.js"></script>
<script type="text/javascript">
    rootPath = "${webRoot}/ins_req";
    var reqIds;
    if (Permission.exist("1439-8")) {
        let html = '<a id="addRequest" class="cs-menu-btn"><i class="' + Permission.getPermission('1439-8').functionIcon + '"></i>添加</a>';
        $("#showBtn").prepend(html);
    }
    $(function () {
        var op = {
            tableId: "dataList",	//列表ID
            tableAction: rootPath + '/datagridByInspId.do',	//加载数据地址
            defaultCondition: [	//默认查询条件
                {
                    queryCode: "inspId",
                    queryVal: '${inspId}'
                }],
            parameter: [		//列表拼接参数
                {
                    columnCode: "requestName",
                    columnName: "单位名称",
                    customStyle: "my_name"
                },
                {
                    columnCode: "creditCode",
                    columnName: "社会信用代码",
                    query: 1
                },
                {
                    columnCode: "state",
                    columnName: "单位状态",
                    columnWidth: "8%",
                    customVal: {0: "营业", 1: "<span class='text-danger'>停业</span>"}
                }
            ],
            funBtns: [
                {
                    show: Permission.exist("1439-9"),
                    style: Permission.getPermission("1439-9"),
                    action: function (id) {
                        idsStr = id;
                        $("#confirm-delete2").modal('toggle');
                    }
                }
            ],	//功能按钮
            rowTotal: 0,	//记录总数
            pageSize: pageSize,	//每页数量
            pageNo: 1,	//当前页序号
            pageCount: 1,	// 总页数
            bottomBtns: [
                {	//删除函数
                    show: Permission.exist("1439-9"),
                    style: Permission.getPermission("1439-9"),
                    action: function (ids) {
                        if (ids == '') {
                            $("#confirm-warnning .tips").text("请选择委托单位");
                            $("#confirm-warnning").modal('toggle');
                        } else {
                            idsStr = ids;
                            $("#confirm-delete2").modal('toggle');
                        }
                    }
                }
            ], onload: function () {
                //每次进行删除或者重新查询的时候都重新赋值
                var obj = datagridOption["obj"];
                reqIds = obj?obj[0].reqIdStr:"";
            }
        };
        datagridUtil.initOption(op);
        datagridUtil.query();

        //送检单位添加全局委托单位
        $("#addRequest").click(function () {
            //iframe层-父子操作
            layer.open({
                title: '<strong>添加委托单位</strong>',
                type: 2,//0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
                area: ['80%', "95%"],//宽高
                offset: '20px',//水平保持居中,距离顶部保持20px
                scrollbar: false,//是否允许浏览器出现滚动条, true:允许,false:屏蔽
                fixed: false, //不固定
                maxmin: true, //可放大
                content: rootPath + '/listAll.do',//子页面路径
                btn: ['确定', '关闭'], //可以无限个按钮
                btnAlign: 'c',//按钮居中
                shadeClose: true,//点击遮罩关闭
                anim: 5,//渐显动画
                resize: true,//允许拖拽
                success: (layero, index) => {//层弹出后的成功回调方法
                    let body = layer.getChildFrame('body', index);//建立父子联系[核心]
                    body.find("input[name=reqIds]").val(reqIds);//父界面传递已选择的委托单位ID到子界面
                },
                yes: (index, layero) => {//确定按钮回调方法
                    let iframeWin = window[layero.find('iframe')[0]['name']];//父页面获取子页面的window对象[核心]
                    let addReqIds = iframeWin.getReqIds();    //调用子页面的方法获取选中的委托单位ID
                    //console.log(addReqIds);
                    layer.close(index);			//手动关闭弹出层
                    //发送异步请求去保存中间表数据
                    $.ajax({
                        type: "POST",
                        url: rootPath + '/add.do',
                        async: true,
                        traditional: true,
                        data: {'reqIds': addReqIds, 'inspectionId': '${inspId}'},
                        dataType: 'json',
                        success: (data) => {
                            if (data.success) {
                                layer.ready(function () {
                                    layer.msg('添加成功', {icon: 1});
                                });
                                datagridUtil.query();
                            } else {
                                layer.ready(function () {
                                    layer.msg('添加失败', {icon: 2});
                                });
                            }
                        }
                    });
                }
            });
        });
    })
</script>
</body>
</html>
