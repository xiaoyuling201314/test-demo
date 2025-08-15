<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/common/resource.jsp"%>
<html>
  <head>
    <title>快检服务云平台</title>
  </head>
  <body>
          <!-- 面包屑导航栏  开始-->
          <div class="cs-col-lg clearfix">
            <ol class="cs-breadcrumb">
              <li class="cs-fl">
              <img src="${webRoot}/img/set.png" alt="" />
              <a href="javascript:">任务管理</a></li>
              <li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
              <li class="cs-b-active cs-fl">任务信息
              </li>
            </ol>
          <!-- 面包屑导航栏  结束-->
            <div class="cs-search-box cs-fr">
              <form action="">
                
                <div class="cs-search-filter clearfix cs-fl">
                <input class="cs-input-cont cs-fl qpinput" type="text" placeholder="请输入任务名称" name="regName"/>
                <input type="button" class="cs-search-btn cs-fl" href="javascript:;" value="搜索" onclick="datagridUtil.query();">
                </div>
                <div class="cs-menu-btn cs-fr cs-ac">
                <a class="cs-add-btn" href="${webRoot}/regulatory/edits.do">新增</a>
              </div>
              </form>
            </div>
          </div>

		<div id="dataList"></div>
    
    <!-- JavaScript -->
    <script src="${webRoot}/js/datagridUtil.js"></script>
    <script type="text/javascript">
	
	var op = {
		tableId: "dataList",	//列表ID
		tableAction: '${webRoot}'+"/regulatory/datagrid.do",	//加载数据地址
		parameter: [		//列表拼接参数
			/* {
				columnCode: "id",
				columnName: "序号"    
			}, */
			{
				columnCode: "regName",
				columnName: "企业名称",
				query: 1,
				queryCode: "regul.regName",
			},
			{
				columnCode: "regType",
				columnName: "企业类型",
				query: 1,
				queryCode: "regul.regType",
			},
			{
				columnCode: "regLicence",
				columnName: "营业执照",
				query: 1,
				queryCode: "regul.regLicence",
			},
			{
				columnCode: "busEdate",
				columnName: "有效期至",
				query: 1,
				queryCode: "regul.busEdate",
			},
			{
				columnCode: "departid",
				columnName: "所属机构",
				query: 1,
				queryCode: "regul.departid",
			},
			{
				columnCode: "legalPerson",
				columnName: "经营户",
				query: 1,
				queryCode: "regul.legalPerson",
			},
			{
				columnCode: "checked",
				columnName: "状态",
				query: 1,
				queryCode: "regul.checked",
			}
		],
		funBtns: [
	    	{
	    		imgSrc: '${webRoot}'+"/img/change.png", 
	    		imgTitle: "编辑", 
	    		action: function(id){
	    			var obj = datagridOption.obj;
	    			if(obj){
	    				for(var i=0;i<obj.length;i++){
	    					if(obj[i].id == id){
	    						if(obj[i].taskDetailPid){
	    							//跳转到接收任务界面
	    							self.location = '${webRoot}/regulatory/edits.do';
	    						}else{
	    							//跳转到下达任务界面
					    			self.location = '${webRoot}/regulatory/edits.do'; 
	    						}
	    						break;
	    					}
	    				}
	    			}
	    		}
	    	},
	    	{
	    		imgSrc: '${webRoot}'+"/img/del_red.png", 
	    		imgTitle: "下发", 
	    		action: function(id){
	    		}
	    	}
	    ],	//功能按钮 
		deleteFun: {	//删除函数	
	    		show: 1, 
	    		action: function(ids){
	    			if(!ids || ids.length == 0){
	    				$.dialog.alert("请选择一条或多条记录");
	    			}else{
		    			var idsStr = "{\"ids\":\""+ids.toString()+"\"}";
		    			$.dialog.confirm("确认删除？",function(){
			    			$.ajax({
			    		        type: "POST",
			    		        url: '${webRoot}'+"/task/delete.do",
			    		        data: JSON.parse(idsStr),
			    		        dataType: "json",
			    		        success: function(data){
			    		        	if(data && data.success){
			    		        		//删除成功后刷新列表
			    		        		datagridUtil.query();
			    		        	}
			    				},
			    				error: function(){
			    					console.log("删除失败");
			    				}
			    		    });
		    			},function(){
		    				console.log("取消");
		    			});
	    			}
	    		}
	    }/*,
		 exportFun: {	//导出函数
				show: 1, 
	    		action: function(ids){
	    			//alert("导出");
	    		}
	    } */
	};
	datagridUtil.initOption(op);
    datagridUtil.query();
    </script>
  </body>
</html>
