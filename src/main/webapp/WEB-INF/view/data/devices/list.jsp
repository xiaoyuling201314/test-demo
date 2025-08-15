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
              <li class="cs-b-active cs-fl">检测设备
              </li>
            </ol>
          <!-- 面包屑导航栏  结束-->
            <div class="cs-search-box cs-fr">
              <form>
              	<input type="hidden" name="baseBean.pointId" class="qpinput" value="${pointId}" />
              	<input type="hidden" name="flag" class="qpinput" value="${flag}" />
                <div class="cs-search-filter clearfix cs-fl">
                <input class="cs-input-cont cs-fl qpinput" type="text" name="baseBean.standardName" placeholder="请输入内容" />
                <input type="button" onclick="datagridUtil.query()" class="cs-search-btn cs-fl" href="javascript:;" value="搜索">
                </div>
                <div class="cs-menu-btn cs-fr cs-ac">
                <a class="cs-add-btn  runcode" href="#myModal2"  data-toggle="modal" name="content_frm">新增</a>
              </div>
              </form>
              
            </div>
          </div>

	<div id="dataList"></div>
  	<div class="modal fade intro2" id="myModal2" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	  <div class="modal-dialog cs-mid-width" role="document">
	    <div class="modal-content ">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" id="myModalLabel">新增/编辑</h4>
	      </div>
	      <div class="modal-body cs-mid-height">
	         <!-- 主题内容 -->
	    <div class="cs-tabcontent" >
	      <div class="cs-content2">
	      <form id="saveForm" method="post" action="${webRoot}/data/standard/save.do">
			<input type="hidden" name="id" >
			<input type="hidden" name="standardCode" >
		    <table class="cs-add-new" style="">
		      <tr>
		        <td class="cs-name"><i class="cs-mred">*</i>标准名称：</td>
		        <td class="cs-in-style">
		          <input type="text" name="standardName" datatype="*" nullmsg="请输入标准名称" errormsg="请输入标准名称" />
		        </td>
		        </tr>
		        <tr>
		        	<td class="cs-name"><i class="cs-mred">*</i>标准信息：</td>
			        <td class="cs-in-style">
			          <input type="text" value="" name="standardInfo" datatype="*" nullmsg="请输入标准信息" errormsg="请输入标准信息"/>
			        </td>
		        </tr>
		        <tr>
		        <td class="cs-name"><i class="cs-mred">*</i>标准类型：</td>
		        <td class="cs-in-style">
					<select class="cs-in-style" name="standardType">
						<option>中国国家标准</option>
						<option>中国地方标准</option>
						<option>中国行业标准</option>
					</select>
				</td>
		      </tr>
		      <tr>
		      		<td class="cs-name"><i class="cs-mred">*</i>状态：</td>
			        <td class="cs-in-style cs-radio">
			        <input id="cs-check-radio" type="radio" value="1" name="checked" /><label for="cs-check-radio">已审核</label>
			        <input id="cs-check-radio2" type="radio" value="0" name="checked" checked="checked" />
			        <label for="cs-check-radio2">未审核</label>
		        </td>
		      </tr>
		      <tr>
		         <td class="cs-name">备注：</td>
		         <td class="cs-in-style "><textarea class="cs-remark" name="remark" id="" cols="30" rows="10"></textarea></td>
		      </tr> 
		    </table>
		    </form>
	      </div>
	    </div>
	      </div>
	      <div class="modal-footer">
	      	<button type="button" class="btn btn-success" id="btnSave">确定</button>
	        <button type="button" class="btn btn-default" data-dismiss="modal" id="btnCancel">关闭</button>
	      </div>
	    </div>
	  </div>
	</div>
 
	<script src="${webRoot}/js/datagridUtil.js"></script>
    <script type="text/javascript">
    var demo;
    $(function(){
    	demo=$("#saveForm").Validform({
    		callback:function(data){
   				$.Hidemsg();
    			if(data.success){
    				$("#myModal2").modal("hide");
					 datagridUtil.query();
    			}else{
    				$.Showmsg(data.msg);
    			}
    		}
    	});
    	// 新增或修改
    	$("#btnSave").on("click", function() {
    		demo.ajaxPost();
    		return false;
    	});
    	//关闭编辑模态框前重置表单，清空隐藏域
    	$('#myModal2').on('hidden.bs.modal', function (e) {
   			 $.Hidemsg();
			 var form = $("#saveForm");// 清空表单数据
	    	 form.form("reset");
    		 $("input[name=id]").val("");
			 $("input[name=standardCode]").val("");
    	})
    });
	var op = {
		tableId: "dataList",	//列表ID
		tableAction: '${webRoot}'+"/data/devices/datagrid.do",	//加载数据地址
		parameter: [		//列表拼接参数
			{
				columnCode: "deviceCode",
				columnName: "出厂编号",
				query: 1
			},
			{
				columnCode: "deviceName",
				columnName: "仪器名称",
				query: 1
			}
			/* ,
			{
				columnCode: "standardInfo",
				columnName: "标准信息",
				query: 1
			},
			
			{
				columnCode: "checked",
				columnName: "状态",
				query: 1,
				customVal:{"0":"未审核","1":"已审核"}
			} */
			
		],
		funBtns: [
	    	{
	    		imgSrc: '${webRoot}'+"/img/chakan.png", 
	    		imgTitle: "查看", 
	    		action: function(id){
	    			$("#myModal2").modal("show");
	    			getId(id);
	    		}
	    	}
	    ],	//功能按钮 
		rowTotal: 0,	//记录总数
		pageSize: pageSize,	//每页数量
		pageNo: 1,	//当前页序号
		pageCount: 1,	// 总页数
		deleteFun: {	//删除函数	
	    		show: 1, 
	    		action: function(ids){
	    			var idsStr = "{\"ids\":\""+ids.toString()+"\"}";
	    			$.dialog.confirm("确认删除？",function(){
		    			$.ajax({
		    		        type: "POST",
		    		        url: '${webRoot}'+"/data/standard/delete.do",
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
	    },
		exportFun: {	//导出函数
				show: 1, 
	    		action: function(ids){
	    			//alert("导出");
	    		}
	    }
	};
	datagridUtil.initOption(op);
	
    datagridUtil.query();
    
    /**
     * 查询检测标准信息
     */
    function getId(e){
    	var id=e;
    	$.ajax({
    	url:"${webRoot}/data/standard/queryById.do",
    	type:"POST",
    	data:{"id":id},
    	dataType:"json",
    	success:function(data){
    	      var form = $('#saveForm');
    		  form.form('load', data.obj);
    		  $("[name=checked][value="+data.obj.checked+"]").prop("checked","checked");
    	},
    	error:function(){
    		alert("操作失败");
    	}
    	})
    }
    //绑定回车事件
    //document.onkeydown=keyDownSearch;
    </script>
  </body>
</html>
