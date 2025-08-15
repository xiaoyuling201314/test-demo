<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/common/resource.jsp"%>
<html>
  <head>
    <title>快检服务云平台</title>
<%--     <link rel="stylesheet" type="text/css" href="${webRoot}/css/gobal.css" /> --%>
    <link rel="stylesheet" type="text/css" href="${webRoot}/css/base.css" />
    <link rel="stylesheet" type="text/css" href="${webRoot}/css/index.css" />
  </head>
  <body>
          <!-- 面包屑导航栏  开始-->
          <div class="cs-col-lg clearfix">
            <ol class="cs-breadcrumb">
              <li class="cs-fl">
              <img src="${webRoot}/img/set.png" alt="" />
              <a href="javascript:">基础数据管理</a></li>
              <li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
              <li class="cs-b-active cs-fl">检测项目
              </li>
            </ol>
          <!-- 面包屑导航栏  结束-->
            <div class="cs-search-box cs-fr">
              <form action="">
                
                <div class="cs-search-filter clearfix cs-fl">
                <input class="cs-input-cont cs-fl" type="text" placeholder="请输入内容" />
                <input type="submit" class="cs-search-btn cs-fl" href="javascript:;" value="搜索">
                <span class="cs-s-search cs-fl">高级搜索</span>
                </div>
                <div class="cs-menu-btn cs-fr cs-ac">
                <a class="cs-add-btn" href="javascript:" >新增</a>
              </div>
              </form>
            </div>
          </div>

          <!-- 高级搜索框 -->
           
          <!-- 列表 -->
          <div id="dataList"></div>

    <!-- JavaScript -->
	<script src="${webRoot}/js/datagridUtil.js"></script>
    <script type="text/javascript">
    $(function(){
    });
    
	var op = {
		tableId: "dataList",	//列表ID
		tableAction: '${webRoot}'+"/base/detectItem/datagrid.do",	//加载数据地址
		parameter: [		//列表拼接参数
			{
				columnCode: "detectItemName",
				columnName: "检测项目名称",
				query: 1
			},
			{
				columnCode: "detectItemCode",
				columnName: "检测项目编号",
			},
			{
				columnCode: "detectSign",
				columnName: "检测标准判定符号",
			},
			{
				columnCode: "detectValue",
				columnName: "检测标准值",
			},
			{
				columnCode: "detectValueUnit",
				columnName: "检测标准值单位",
			},
			{
				columnCode: "createName",
				columnName: "创建人",
				query: 1
			},
			{
				columnCode: "remark",
				columnName: "备注",
			},
			
			
		],
		funBtns: [
	    	{
	    		imgSrc: '${webRoot}'+"/img/chakan.png", 
	    		imgTitle: "处理", 
	    		action: function(id){
	    			window.location = '${webRoot}'+"/dataCheck/goHandle.do?id="+id;
	    		}
	    	}
	    ],	//功能按钮 
		rowTotal: 0,	//记录总数
		pageSize: 10,	//每页数量
		pageNo: 1,	//当前页序号
		pageCount: 1,	// 总页数
		deleteFun: {	//删除函数	
	    		show: 1, 
	    		action: function(ids){
	    			alert("删除记录"+ids);
	    		}
	    },
		exportFun: {	//导出函数
				show: 1, 
	    		action: function(ids){
	    			alert("导出记录"+ids);
	    		}
	    }
	};
	datagridUtil.initOption(op);
	
    datagridUtil.query();
    </script>
  </body>
</html>
