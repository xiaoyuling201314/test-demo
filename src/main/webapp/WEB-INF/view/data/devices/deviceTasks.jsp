<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/common/resource.jsp"%>
<html>
  <head>
    <title>快检服务云平台</title>
  </head>
  <body>
<%--          <div class="cs-col-lg clearfix">--%>
<%--            <ol class="cs-breadcrumb">--%>
<%--              <li class="cs-fl">--%>
<%--	              <img src="${webRoot}/img/set.png" alt="" />--%>
<%--	              <a href="javascript:;">检测点管理</a>--%>
<%--              </li>--%>
<%--              <li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>--%>
<%--              <li class="cs-b-active cs-fl">快检点</li>--%>
<%--              <li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>--%>
<%--              <li class="cs-b-active cs-fl">检测点详情</li>--%>
<%--              <li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>--%>
<%--              <li class="cs-b-active cs-fl">检测设备任务</li>--%>
<%--            </ol>--%>
<%--            <div class="cs-search-box cs-fr">--%>
<%--              <form>--%>
<%--                <div class="cs-search-filter clearfix cs-fl">--%>
<%--                	<span class="check-date cs-fl" style="display: inline;    margin-right: 10px;"> --%>
<%--						<span class="cs-name">状态:</span> --%>
<%--						<select class="check-date cs-selcet-style focusInput" style="width: 96px;" name="status"> --%>
<%--							<option value="" selected="selected">--请选择--</option>--%>
<%--							<option value="0">未接收</option>--%>
<%--							<option value="1">已接收</option>--%>
<%--						</select>--%>
<%--					</span>--%>
<%--	                <input class="cs-input-cont cs-fl focusInput" type="text" name="keyWords" placeholder="请输入关键词" />--%>
<%--	                <input class="cs-search-btn cs-fl" type="button" onclick="datagridUtil.queryByFocus()" href="javascript:;" value="搜索">--%>
<%--                </div>--%>
<%--                <div class="clearfix cs-fr">--%>
<%--					<a href="javascript:;" onclick="parent.closeMbIframe();" class="cs-menu-btn"><i class="icon iconfont icon-fanhui"></i>返回</a>--%>
<%--				</div>--%>
<%--              </form>--%>
<%--            </div>--%>
<%--          </div>--%>

	<div id="dataList"></div>
	
 	<%@include file="/WEB-INF/view/common/confirm.jsp"%>
 	
	<script src="${webRoot}/js/datagridUtil2.js"></script>
    <script type="text/javascript">
	var dgu = datagridUtil.initOption({
		tableId: "dataList",
		tableAction: "${webRoot}/samplingDetail/datagrid.do",
        tableBar: {
            title: ["检测点管理","检测点详情","检测设备任务"],
            hlSearchOff: 0,
            ele: [{
                eleShow: 1,
                eleTitle: "抽样日期",
                eleName: "samplingDate",
                eleType: 3,
                eleStyle: "width:110px;",
                eleDefaultDateMin: new newDate().DateAdd("w",-1).format("yyyy-MM-dd"),
                eleDefaultDateMax: new newDate().format("yyyy-MM-dd")
            },{
                eleShow: 1,
                eleTitle: "状态",
                eleName: "status",
                eleType: 2,
                eleOption: [{"text":"--全部--","val":""},{"text":"未接收","val":"0"},{"text":"已接收","val":"1"}],
                eleStyle: "width:85px;"
            },{
                eleShow: 1,
                eleName: "keyWords",
                eleType: 0,
                elePlaceholder: "请输入关键词"
            }],
            topBtns: [{
                show: 1,
                style: {"functionIcon":"icon iconfont icon-fanhui","operationName":"返回"},
                action: function(ids, rows){
                    parent.closeMbIframe();
                }
            }]
        },
		defaultCondition: [
			{
				"queryCode" : "recevieDevice",
				"queryVal": '${serialNumber}'
			}
		],
		parameter: [
			{
				columnCode: "sampleCode",
				columnName: "样品编号"
			},
			{
				columnCode: "foodName",
				columnName: "样品名称"
			},
			{
				columnCode: "itemName",
				columnName: "检测项目"
			},
			{
				columnCode: "status",
				columnName: "接收状态",
				customVal: {'0':'<span class="text-danger">未接收</span>','1':'<span class="text-success">已接收</span>'}
			},
			{
				columnCode: "conclusion",
				columnName: "检测结果",
				customVal: {'不合格':'<span class="text-danger">不合格</span>','合格':'<span class="text-success">合格</span>'}
			}
		],
		funBtns: [
			{
				show: Permission.exist("391-11") || Permission.exist("1497-11"),
				style: Permission.getPermission("1497-11"),
				action: function(id){
					if(!id){
	    				$("#confirm-warnning .tips").text("重置失败");
	    				$("#confirm-warnning").modal('toggle');
	    			}else{
	    				detailId = id;
	    				$("#confirmModal .tips").text("确认重置检测任务？");
	    				$("#confirmModal").modal('toggle');
	    			}
				}
			}
	    ],
	    onload: function(rows, pageData){
	    	$(".rowTr").each(function(){
		    	for(var i=0;i<rows.length;i++){
		    		if($(this).attr("data-rowId") == rows[i].id){
		    			//未接受任务无需重置
			    		if(rows[i].status == '0'){
			    			//隐藏重置按钮
			    			$(this).find(".391-11").hide();
			    			$(this).find(".1497-11").hide();
			    		}
			    		break;
		    		}
		    	}
	    	});
	    }
	});
    dgu.queryByFocus();
    
    //重置检测任务
    var detailId;
    function confirmModal(){
    	$.ajax({
    		type: "POST",
            url: "${webRoot}/data/devices/resetCheckTask.do",
            data: {'detailId':detailId},
            dataType: "json",
            success: function (data) {
                if (data && data.success) {
                    dgu.queryByFocus();
                } else {
                	$("#confirm-warnning .tips").text("重置失败");
    				$("#confirm-warnning").modal('toggle');
                }
            }
    	});
    	$("#confirmModal").modal('toggle');
    }
    </script>
  </body>
</html>
