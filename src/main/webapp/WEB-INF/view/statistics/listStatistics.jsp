<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/common/resource.jsp"%>
<html>
<head>
<title>快检服务云平台</title>
</head>
<body>
	<div class="cs-col-lg clearfix">
		<ol class="cs-breadcrumb">
		    <li class="cs-fl">
		      <img src="${webRoot}/img/set.png" alt="" />
		      <a href="javascript:">数据统计</a></li>
		    <!-- <li class="cs-fl">
		      <i class="cs-sorrow">&gt;</i></li>
		    <li class="cs-fl">检测点统计</li> -->
	    </ol>
	    <div class="cs-search-box cs-fr">
            <div class="cs-alert cs-fr cs-ac "> 
            <a href="javascript:" onclick="parent.closeMbIframe();" class="cs-menu-btn"><i class="icon iconfont icon-fanhui"></i>返回</a>
            </div>
        </div>
    </div>
	<div id="dataList"></div>
	<script src="${webRoot}/js/datagridUtil.js"></script>
	<%@include file="/WEB-INF/view/common/modalBox.jsp"%>
	<script type="text/javascript">
	$(function () {
		var op = {
				tableId: "dataList",	//列表ID
				tableAction: '${webRoot}'+"/statistics/loadDatadatagrid.do?type="+'${type}'+"&month="+'${month}'+"&season="+'${season}'+"&year="+'${year}'+"&start="+'${start}'+"&end="+'${end}'+"&typeObj="+'${typeObj}'+"&conclusion="+'${conclusion}'+"&did=${did}"+"&pointType=${pointType}&param7=1",	//加载数据地址
				parameter: [		//列表拼接参数
						{
							columnCode: "pointName",
							columnWidth:'10%',
							columnName: "检测单位"
						},
						{
							columnCode: "checkUsername",
							columnWidth:'10%',
							columnName: "检测人员"
						},
						{
							columnCode: "regName",
							columnWidth:'10%',
							columnName: "被检单位"
						},
						{
							columnCode: "regUserName",
							columnWidth:'10%',
							columnName: "${systemFlag}"=="1" ? "摊位名称" : "档口名称"
						},
						
						{
							columnCode: "foodName",
							columnWidth:'10%',
							columnName: "样品名称"
						},
						{
							columnCode: "itemName",
							columnWidth:'10%',
							columnName: "检测项目"
						},
						{
							columnCode: "checkResult",
							columnWidth:'10%',
							columnName: "检测结果值",
							sortDataType: "float"
						},
						{
							columnCode: "conclusion",
							columnName: "检测结果",
							query: 1,
							columnWidth:'10%',
							queryType: 2,
							customVal: {"合格":"<div class=\"text-success\">合格</span>","不合格":"<div class=\"text-danger\">不合格</span>"}
							
						},
						{
							columnCode: "checkDate",
							columnWidth:'15%',
							columnName: "检测时间",
							dateFormat: "yyyy-MM-dd HH:mm:ss",
                            sortDataType:"date"
							
						}
				]
			};
			datagridUtil.initOption(op);
		    datagridUtil.query();
	});
	</script>
</body>
</html>