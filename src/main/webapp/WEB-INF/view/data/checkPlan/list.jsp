<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/common/resource.jsp"%>
<html>
<style type="text/css">
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
	.container{margin-left: 30px; margin-top: 20px;}
	.containers{margin-left: 30px; margin-top: 10px;}
	h1{padding-bottom: 10px; color: darkmagenta; font-weight: bolder;}
	img{cursor: pointer;}
	#pic{position: absolute; display: none;}
	#pic1{ width: 100px;background-color: #fff; border-radius: 5px; -webkit-box-shadow: 5px 5px 5px 5px hsla(0,0%,5%,1.00); box-shadow: 5px 5px 5px 0px hsla(0,0%,5%,0.3); }
	#pic1 img{
		width:100%;
	}
	.cs-table-responsive{
		padding-bottom: 80px;

	}
</style>
<head>
	<title>快检服务云平台</title>

</head>

<body>
<div id="dataList"></div>

<%@include file="/WEB-INF/view/common/modalBox.jsp"%>
<%@include file="/WEB-INF/view/common/confirm.jsp"%>
<!-- JavaScript -->
<script src="${webRoot}/js/datagridUtil2.js"></script>
<script type="text/javascript">
	rootPath="${webRoot}/checkPlan/";
	var dgu;
	dgu = datagridUtil.initOption({
		tableId: "dataList",
		tableAction: "${webRoot}/checkPlan/datagrid.do",
		funColumnWidth:"80px",
		tableBar: {
			title: ["数据中心","检测计划"],
			hlSearchOff: 0,
			ele: [{
				eleShow: 1,
				eleName: "keyWords",
				eleType: 0,
				elePlaceholder: "样品名称"
			}],
			topBtns: [],
		},
		onload: function(obj, pageData){},
		parameter: [
			{
				columnCode: "foodName",
				columnName: "样品名称"
			},
			{
				columnCode: "itemName1",
				columnName: "星期一",
			},
			{
				columnCode: "itemName2",
				columnName: "星期二",
			},
			{
				columnCode: "itemName3",
				columnName: "星期三",
			},
			{
				columnCode: "itemName4",
				columnName: "星期四",
			},
			{
				columnCode: "itemName5",
				columnName: "星期五",
			},
			{
				columnCode: "itemName6",
				columnName: "星期六",
			},
			{
				columnCode: "itemName7",
				columnName: "星期日",
			},
		],
		funBtns: [
			{
				show: Permission.exist("1502-1"),
				style: Permission.getPermission("1502-1"),
				action: function(id, obj){
					let paramStr="foodId="+obj.foodId+"&foodName="+obj.foodName;
					if(id){
						paramStr+="&id="+id;
					}
					showMbIframe("${webRoot}/checkPlan/add?"+paramStr,dgu);
				}
			}
		],
		bottomBtns: []
	});

	$(function(){
		dgu.queryByFocus();
	});
</script>
</body>
</html>
