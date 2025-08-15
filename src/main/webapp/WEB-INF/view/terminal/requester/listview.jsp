<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/WEB-INF/view/common/resource.jsp" %>
<html>
<head>
    <title>委托单位</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<div class="cs-col-lg clearfix">
    <!-- 面包屑导航栏  开始-->
<%--     <ol class="cs-breadcrumb">
        <li class="cs-fl">
            <img src="${webRoot}/img/set.png" alt=""/>
            <a href="javascript:;">客户管理</a></li>
        <li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
        <li class="cs-b-active cs-fl">委托单位
        </li>
    </ol> --%>
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
    var codeUrl = "${requesterUnitPath}";
    var download = 0;
    var downloadObj;
    var reqExports = 0;
    var reqExportObj;
    rootPath = "${webRoot}/requester/unit/";

    if (Permission.exist("1437-4")) {
        reqExports = 1;
        reqExportObj = Permission.getPermission('1437-4');
    }
    var op = {
        tableId: "dataList",	//列表ID
        tableAction: rootPath + "/datagridView?samplingId=${samplingId}&filterDelete=${filterDelete}",	//加载数据地址
        parameter: [		//列表拼接参数
            {
                columnCode: "requesterName",
                columnName: "单位名称",
                customStyle: "my_name",
                query: 1
            },
            {
                columnCode: "requesterOtherName",
                columnName: "单位别称",
                query: 1
            },
/*             {
                columnCode: "id",
                columnName: "二维码",
                customElement: "<a class=\"runcode qrcode\" data-value='?' href=\"javascript:;\"><img src=\"${webRoot}/img/2dcode.png\" alt=\"\" /></a>",
                columnWidth: "70px"
            },
            {
                columnCode: "creditCode",
                columnName: "社会信用代码",
                query: 1
            },
            {
                columnCode: "legalPerson",
                columnName: "法人",
                columnWidth: "10%"
            }, */
            {
                columnCode: "linkUser",
                columnName: "联系人",
                columnWidth: "10%"
            }, /* {
                columnCode: "state",
                columnName: "单位状态",
                columnWidth: "8%",
                customVal: {0: "营业", 1: "<span class='text-danger'>停业</span>"}
            }, */
            {
                columnCode: "linkPhone",
                columnName: "联系方式",
                columnWidth: "15%"
            }
        ],
        rowTotal: 0,	//记录总数
        pageSize: pageSize,	//每页数量
        pageNo: 1,	//当前页序号
        pageCount: 1,	// 总页数


    };
    datagridUtil.initOption(op);
    datagridUtil.query();

    
    function getSelections(){

    	var peakhours = document.getElementsByName("rowCheckBox");
    	var obj={};
    	var objlist=[];
		var detectItemList = "";
		   for (var i = 0; i < peakhours.length; i++) {
		    if (peakhours[i].checked || $(peakhours[i]).attr("checked")) {
		     detectItemList += peakhours[i].value + ',';
		     obj.id=peakhours[i].value;
/* 		     obj.tx=$(peakhours[i]).parent().parent().next().text()
		     obj.txlb=$(peakhours[i]).parent().parent().next().next().text();
		     obj.tm=$(peakhours[i]).parent().parent().next().next().next().text();
		     obj.scorce=$(peakhours[i]).parent().parent().next().next().next().next().text(); */
		     objlist.push(obj);
		     obj={};
      }
     }
		  return objlist;
    }
</script>
</body>
</html>
