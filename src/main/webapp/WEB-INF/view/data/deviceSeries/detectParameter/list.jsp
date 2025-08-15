<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/common/resource.jsp"%>
<html>
  <head>
    <title>快检服务云平台</title>
  </head>
  <body>
          <div class="cs-col-lg clearfix">
          <!-- 面包屑导航栏  开始-->
            <ol class="cs-breadcrumb">
              <li class="cs-fl">
              <img src="${webRoot}/img/set.png" alt="" />
              <a href="javascript:">数据中心</a></li>
              <li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
              <li class="cs-fl">仪器类型维护
              <li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
              <li class="cs-b-active cs-fl">仪器类别:${deviceType.deviceName}
              </li>
            </ol>
          <!-- 面包屑导航栏  结束-->
            <div class="cs-search-box cs-fr">
              <form action="datagrid.do">
                <div class="cs-search-filter clearfix cs-fl">
                <input type="hidden" name="baseBean.deviceTypeId" value="${deviceType.id}" class="focusInput" />
                <input class="cs-input-cont cs-fl focusInput" type="text" name="baseBean.itemId" id="searchKeys" placeholder="请输入内容" />
                <input type="button" onclick="datagridUtil.queryByFocus();" class="cs-search-btn cs-fl" href="javascript:;" value="搜索">
                </div>
              <div class="clearfix cs-fr" >
               		<a id="showBtn" href="${webRoot}/data/deviceSeries/list.do" class="cs-menu-btn cs-fun-btn"><i class="icon iconfont icon-fanhui" ></i>返回</a>
	            </div>
              </form>
              
            </div>
          </div>

	<div id="dataList"></div>
    <%@include file="/WEB-INF/view/common/modalBox.jsp"%>
    <%@include file="/WEB-INF/view/common/confirm.jsp"%>
    <%@include file="/WEB-INF/view/data/deviceSeries/detectParameter/exportDialog.jsp"%>
	<script src="${webRoot}/js/datagridUtil.js"></script>
    <script type="text/javascript">
    rootPath="${webRoot}/data/deviceSeries/detectParameter/"; 
    for (var i = 0; i < childBtnMenu.length; i++) {
   		if (childBtnMenu[i].operationCode == "414-1") {
   			var html='<a href="${webRoot}/data/deviceSeries/detectParameter/queryById.do?id=${deviceType.id}&type=add"  class="cs-menu-btn cs-fun-btn "><i class="'+childBtnMenu[i].functionIcon+'"></i>新增</a>';
   			$("#showBtn").before(html);
   		}else if (childBtnMenu[i].operationCode == "414-2") {
   			edit = 1;
   			editObj=childBtnMenu[i];
   		}else if (childBtnMenu[i].operationCode == "414-4") {
   			deletes = 1;
   			deleteObj=childBtnMenu[i];
   		}else if (childBtnMenu[i].operationCode == "414-5") {
   			exports = 1;
   			exportObj=childBtnMenu[i];
   		}
   	} 

    $(function(){
    	// 点击返回按钮
    	$('#btnReturn').on('click', function(event) {
    		event.preventDefault();
    		history.back();
    	});
    	
    });
	var op = {
		tableId: "dataList",	//列表ID
		tableAction: '${webRoot}'+"/data/deviceSeries/detectParameter/datagrid.do",	//加载数据地址
		parameter: [		//列表拼接参数
			{
				columnCode: "itemId",
				columnName: "检测项目",
				query: 1
			},
			{
				columnCode: "projectType",
				columnName: "检测模块",
				query: 1
			},
			{
				columnCode: "detectMethod",
				columnName: "检测方法",
				query: 1
			},
            {
              columnCode: "reserved3",
              columnName: "预留字段3",
              query: 1,
              columnWidth:'100px;',
              customVal: {"is-null":"","1":"扫描","2":"摄像头","3":"","4":"外置摄像头"}

            }
		],
		funBtns: [
	    	{
	    		show:1,
	    		style:{
	    			functionIcon:"icon iconfont icon-xiugai",
	    			operationName:"编辑"
	    		},
	    		action: function(id){
	    			self.location = '${webRoot}/data/deviceSeries/detectParameter/queryById.do?id='+id; 
	    		}
	    	},
	    	{
	    		show:1,
	    		style:{
	    			functionIcon:"icon iconfont icon-shanchu text-del",
	    			operationName:"删除"
	    		},
	    		action: function(id){
	    			idsStr="{\"ids\":\""+id.toString()+"\"}";
	    			$("#confirm-delete").modal('toggle');
	    		}
	    	}
	    ],	//功能按钮 
		rowTotal: 0,	//记录总数
		pageSize: pageSize,	//每页数量
		pageNo: 1,	//当前页序号
		pageCount: 1,	// 总页数
		bottomBtns: [
			{	//删除函数	
				show:deletes,
	    		style:deleteObj,
	    		action: function(ids){
	    			if(ids == ''){
		    			$("#confirm-warnning .tips").text("请选择食品");
		    			$("#confirm-warnning").modal('toggle');
	    			}else{
		    			idsStr = "{\"ids\":\""+ids.toString()+"\"}";
		    			$("#confirm-delete").modal('toggle');
	    			}
	    		}
	    },
		 {	//导出函数
				show: exports, 
				style:exportObj,
	    		action: function(ids){
                  exportIds = ids;
                  let numbers=exportIds.length>0 ? exportIds.length : datagridOption["rowTotal"];
                  $(".exportNumbers").text(numbers);
                  $("#exportModal").modal('toggle');
	    		}
	    },
          {	//导入函数
            show: Permission.exist("414-6"),
            style:Permission.getPermission("414-6"),
            action: function(){
              showMbIframe('${webRoot}/data/deviceSeries/detectParameter/toImport.do?deviceTypeId=${deviceType.id}');
            }
          }
		]
	};
	datagridUtil.initOption(op);
    datagridUtil.queryByFocus();
    
    var exportIds=[];//要导出检测项目ID
    function exportFile() {
        var exportFileUrl = "${webRoot}/data/deviceSeries/detectParameter/exportFile?baseBean.deviceTypeId=${deviceType.id}&ids="+exportIds+"&deviceName=${deviceType.deviceName}";
        var searchKeys=$("#searchKeys").val();
        if(searchKeys!=""){
          exportFileUrl+="&baseBean.itemName="+searchKeys;
        }
        location.href = exportFileUrl;
        $("#exportModal").modal('hide');
    }
    //绑定回车事件
    //document.onkeydown=keyDownSearch;
    </script>
  </body>
</html>
