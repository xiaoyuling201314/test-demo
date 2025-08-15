<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<%
    String path2 = request.getContextPath();
    String basePath2;
    if (request.getServerPort() == 80) {
        basePath2 = request.getScheme() + "://" + request.getServerName() + path2;
    } else {
        basePath2 = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path2;
    }
%>
<c:set var="webRoot2" value="<%=basePath2%>"/>
<%@include file="/WEB-INF/view/common/resource.jsp" %>
<html>
<head>
    <title>委托单位</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<div class="cs-col-lg clearfix">
    <!-- 面包屑导航栏  开始-->
    <ol class="cs-breadcrumb">
        <li class="cs-fl">
            <img src="${webRoot}/img/set.png" alt=""/>
            <a href="javascript:">客户管理</a></li>
        <li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
        <li class="cs-b-active cs-fl">委托单位
        </li>
    </ol>
    <div class=" cs-fl" style="margin:3px 0 0 30px;">
			<select class="check-date cs-selcet-style" id="check" style="width: 120px;" onchange="changeType();"> 
				<option value="1" selected="selected">已审核</option>
				<option value="0">未审核</option>
				<option value="2">全部</option>
			</select>
		</div>
    <!-- 面包屑导航栏  结束-->
    <div class="cs-search-box cs-fr">
        <form action="datagrid.do">
            <div class="cs-search-filter clearfix cs-fl">
                <input class="cs-input-cont cs-fl focusInput" type="text" name="requesterName" placeholder="单位名称、社会信用代码"/>
                <input type="button" onclick="datagridUtil.queryByFocus();" class="cs-search-btn cs-fl" href="javascript:;" value="搜索">
            </div>
            <div class="clearfix cs-fr" id="showBtn">
            </div>
        </form>
    </div>
</div>
<div id="dataList"></div>
<%--委托单位查看二维码--%>
<%@include file="/WEB-INF/view/terminal/qrcode.jsp" %>
<%@include file="/WEB-INF/view/common/confirm.jsp" %>
<%@include file="/WEB-INF/view/common/modalBox.jsp" %>
<script src="${webRoot}/js/datagridUtil.js"></script>
<script type="text/javascript">
    var qrcodeUrl = "${webRoot}/requester/unit/requesterQrcode.do";//生成二维码地址
    var functionName = "委托单位二维码";
    //var codeUrl = "${requesterUnitPath}";
    var codeUrl = "${webRoot2}/rpt/sc";
    var reqExports = 0;
    var reqExportObj;
    var checked=1;//默认查询已审核的单位
    rootPath = "${webRoot}/requester/unit/";
    if (Permission.exist("1437-1")) {	//新增标签
        $("#showBtn").append('<div id="addBtn" class="cs-fr cs-ac"><a href="javascript:;" class="cs-menu-btn"><i class="' + Permission.getPermission('1437-1').functionIcon + '"></i>新增</a></div>');
    }
    if (Permission.exist("1437-4")) {
        reqExports = 1;
        reqExportObj = Permission.getPermission('1437-4');
    }
    function loadData(){
	    var op = {
	        tableId: "dataList",	//列表ID
	        tableAction: rootPath + "/datagrid.do?checked="+checked,	//加载数据地址
	        parameter: [		//列表拼接参数
	            {
	                columnCode: "requesterName",
	                columnName: "单位名称",
	                customStyle: "my_name",
	                query: 1
	            },
	            /*{
	                columnCode: "requesterOtherName",
	                columnName: "单位别称",
	                query: 1
	            },*/
	            {
	                columnCode: "departNameForList",
	                columnName: "所属机构",
	                query: 1,
	                columnWidth: "15%"
	            },
	            {
	                columnCode: "unitTypeName",
	                columnName: "类型",
	                query: 1,
	                columnWidth: "90px"
	            },            
	            {
	                columnCode: "id",
	                columnName: "二维码",
	                customElement: "<a class=\"runcode qrcode\" data-value='?' href=\"javascript:;\"><img src=\"${webRoot}/img/2dcode.png\" alt=\"\" /></a>",
	                columnWidth: "70px"
	            },
	            {
	                columnCode: "checkNum",
	                columnName: "日测批次",
                    sortDataType:"int",
	                query: 1,
	                columnWidth: "7%"
	            },
	            {
	                columnCode: "scope",
	                columnName: "就餐人数",
                    sortDataType:"int",
	                columnWidth: "7%"
	            },
	            {
	                columnCode: "linkUser",
	                columnName: "联系人",
	                columnWidth: "80px"
	            },
	            {
	                columnCode: "linkPhone",
	                columnName: "联系方式",
	                columnWidth: "110px"
	            },
	            {
	                columnCode: "checked",
	                columnName: "审核",
	                columnWidth: "80px",
	                customVal: {0: "<span class='text-danger'>未审核</span>", 1: "已审核"}
	            }
	            
	        ],
	        funBtns: [
	            {
	                show: Permission.exist("1437-2"),//编辑
	                style: Permission.getPermission("1437-2"),
	                action: function (id) {
	                    showMbIframe('${webRoot}/requester/unit/queryById.do?id=' + id);
	                }
	            },
	            {
	                show: Permission.exist("1437-3"),//删除
	                style: Permission.getPermission("1437-3"),
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
	        bottomBtns: [{
	            show: Permission.exist('1437-5'),	//查看二维码
	            style: Permission.getPermission('1437-5'),
	            action: function (ids) {
	                if (ids == '') {
	                    $("#confirm-warnning .tips").text("请选择委托单位");
	                    $("#confirm-warnning").modal('toggle');
	                } else {
	                    var arr = [];
	                    var obj = datagridOption.obj;
	                    for (var i = 0; i < obj.length; i++) {
	                        if (ids.indexOf(obj[i].id + "") != -1) {
	                            arr.push({'id': obj[i].id, 'name': obj[i].requesterName})
	                        }
	                    }
	                    viewQrcode(arr);
	                }
	            }
	        }, {//导入委托单位
	            show: Permission.exist('1437-4'),
	            style: Permission.getPermission('1437-4'),
	            action: function (ids) {
	                location.href = '${webRoot}/requester/unit/toImport.do'
	            }
	        }, {//批量删除函数
	            show: Permission.exist("1437-3"),
	            style: Permission.getPermission("1437-3"),
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
	        ]
	
	    };
	    datagridUtil.initOption(op);
	    datagridUtil.query();
    }
    $("#addBtn").click(function () {
        showMbIframe('${webRoot}/requester/unit/queryById.do');
    });
    $(function(){
    	loadData();
    });
    
    //状态选择栏
     function changeType() {
          checked="";
 	    var	 value = $('#check option:selected').val(); // 选中值
 	    if(value==0||value==1){
 	 	   checked=value;
 	    }
 	 	loadData();
   	}
</script>
</body>
</html>
