<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/WEB-INF/view/common/resource.jsp" %>
<html>
<head>
    <title>快检服务云平台</title>
    <link rel="stylesheet" type="text/css" href="${webRoot}/plug-in/ztree/css/zTreeStyle.css"/>
</head>
<body>
<div class="cs-col-lg clearfix">
    <!-- 面包屑导航栏  开始-->
    <ol class="cs-breadcrumb">
        <li class="cs-fl">
            <img src="${webRoot}/img/set.png" alt=""/>
            <a href="javascript:">充值活动</a></li>
         <li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
        <li class="cs-b-active cs-fl">操作日志 
        </li>
        <li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
          <li class="cs-b-active cs-fl">${theme} 
           </li>
    </ol>
    <!-- 面包屑导航栏  结束-->
    <div class="cs-search-box cs-fr">
        <form action="datagrid.do">
           <!--  <div class="cs-search-filter clearfix cs-fl">
                <input class="cs-input-cont cs-fl focusInput" type="text" name="baseBean.rolename" placeholder="请输入内容"/>
                <input type="button" onclick="datagridUtil.queryByFocus();" class="cs-search-btn cs-fl" href="javascript:;" value="搜索">
            </div> -->
            <div class="clearfix cs-fr" id="showBtn">
            <a class="cs-menu-btn"  onclick="parent.closeMbIframe()"><i class="icon iconfont icon-fanhui"></i>返回</a>
            </div>
        </form>
    </div>
</div>
<div id="dataList"></div>

<!-- 编辑模态框 start -->
<div class="modal fade intro2" id="addModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog cs-lg-width" role="document">
        <div class="modal-content ">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">新增</h4>
            </div>
            <div class="modal-body cs-lg-height">
                <!-- 主题内容 -->
                <div class="cs-tabcontent">
                    <div class="cs-content2"> 
                        <form id="saveForm" action="${webRoot}/system/scheduled/save.do" method="post">
                            <input type="hidden" name="id">
                            <input type="hidden" name="oldOff" value="1">
                            <div width="100%" class="cs-add-new">
                                <ul class="cs-ul-form clearfix">
                                    <li class="cs-name col-xs-3 col-md-3" width="20% ">定时器名称：</li>
                                    <li class="cs-in-style col-xs-9 col-md-9"><input id="scheduledName" type="text" name="scheduledName"
                                                                                     class="inputxt" nullmsg="请输入定时器名称！"/></li>
                                </ul>
                                <ul class="cs-ul-form clearfix">
                                    <li class="cs-name col-xs-3 col-md-3" width="20% ">时间间隔：</li>
                                    <li class="cs-in-style col-xs-9 col-md-9"><input id="scheduled" type="text" name="scheduled" class="inputxt"/>
                                    </li>
                                </ul>
                                <ul class="cs-ul-form clearfix">
                                    <li class="cs-name col-xs-3 col-md-3" width="20% ">启用路径：</li>
                                    <li class="cs-in-style col-xs-9 col-md-9">
                                        <input id="param1" type="text" name="startUrl" class="inputxt"/>
                                    </li>
                                </ul>
                                <ul class="cs-ul-form clearfix">
                                    <li class="cs-name col-xs-3 col-md-3" width="20% ">搜索机构：</li>
                                    <li class="cs-in-style col-xs-9 col-md-9">
                                        <input placeholder="请输入机构名称" autocomplete="off" id="key" type="text" onfocus="showMenu()" class="inputxt"/>
                                    </li>
                                </ul>
                                <ul class="cs-ul-form clearfix hide">
                                    <li class="cs-name col-xs-3 col-md-3" width="20% ">机构ID：</li>
                                    <li class="cs-in-style col-xs-9 col-md-9">
                                        <input id="departIds" type="text" name="departIds" class="inputxt"/>
                                    </li>
                                </ul>
                                <ul class="cs-ul-form clearfix">
                                    <li class="cs-name col-xs-3 col-md-3">选择机构：</li>
                                    <li class="cs-in-style cs-modal-input">
                                        <div class="cs-all-ps">
                                            <div class="cs-input-box">
                                                <input type="text" id="departName" type="text" readonly="readonly" class="cs-down-input">
                                                <div class="cs-down-arrow"></div>
                                            </div>
                                            <div id="menuContent" class="cs-check-down cs-hide">
                                                <!-- 树状图 -->
                                                <ul id="myTree" class="ztree">
                                                </ul>
                                                <!-- 树状图 -->
                                            </div>
                                        </div>
                                    </li>
                                </ul>
                                <ul class="cs-ul-form clearfix">
                                    <li class="cs-name col-xs-3 col-md-3">状态：</li>
                                    <li class="cs-al cs-modal-input">
                                        <input id="cs-check-radio" type="radio" value="0" name="off"/><label for="cs-check-radio">启用</label>
                                        <input id="cs-check-radio2" type="radio" value="1" name="off" checked="checked"/><label for="cs-check-radio2">停用</label>
                                    </li>
                                </ul>
                            </div>
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

         	
         		<!-- Modal 提示窗-确认-DIY huht-->
	<div class="modal fade intro2" id="newconfirmModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog cs-alert-width">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
					<h4 class="modal-title">确认</h4>
				</div>
				<div class="modal-body cs-alert-height cs-dis-tab">
					<div class="cs-text-algin">
						<img src="${webRoot}/img/warn.png" width="40px"/>
						<span class="tips" id="tips"></span>
					</div>
				</div>
				<div class="modal-footer">
					<a class="btn btn-danger btn-ok" onclick="" id="affirm">确认</a>
					<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
				</div>
			</div>
		</div>
	</div>
<%@include file="/WEB-INF/view/common/confirm.jsp" %>
<script src="${webRoot}/js/datagridUtil.js"></script>
<%--引入ztree插件--%>
<script type="text/javascript" src="${webRoot}/plug-in/ztree/js/jquery.ztree.core.js"></script>
<script type="text/javascript" src="${webRoot}/plug-in/ztree/js/jquery.ztree.excheck.js"></script>
<script type="text/javascript" src="${webRoot}/plug-in/ztree/js/jquery.ztree.exhide.js"></script>
<script type="text/javascript" src="${webRoot}/plug-in/ztree/js/fuzzysearch.js"></script>
<script type="text/javascript">
 
    for (var i = 0; i < childBtnMenu.length; i++) {
 	 if (childBtnMenu[i].operationCode == "1451-2") {//删除
            deletes = 1;
            deleteObj = childBtnMenu[i];
        }
    }
var actId='${actId}';
    var op = {
        tableId: "dataList",	//列表ID
        tableAction: "${webRoot}/activitiesLog/datagrid.do?actId="+actId,	//加载数据地址
        parameter: [		//列表拼接参数
            {
                columnCode: "type",
                columnName: "操作",
                customVal: {0: "<span class='text-success'>新增</span>",
                	1: "<span class='text-success'>编辑</span>", 2: "<span class='text-danger'>开启</span>", 
                	3: "<span class='text-danger'>关闭</span>", 4: "<span class='text-danger'>删除</span>",
					5: "<span class='text-success'>定时计划</span>", 6: "<span class='text-success'>服务器重启</span>"},
                columnWidth: '8%'
            },
            {
                columnCode: "msg",
                columnName: "操作内容",
                columnWidth: '18%'
            },
            {
                columnCode: "description",
                columnName: "参数",
                columnWidth: '18%'
            },
            {
                columnCode: "createDate",
                columnName: "日志时间",
                dateFormat: "yyyy-MM-dd HH:mm:ss",
                columnWidth: '13%'
            },
            {
                columnCode: "userName",
                columnName: "操作人",
                columnWidth: '10%'
            } ,
            {
                columnCode: "result",
                columnName: "操作结果",
                customVal: {0: "<span class='text-success'>成功</span>", 1: "<span class='text-danger'>失败</span>"},
                columnWidth: '10%'
            } 
        ],
        funBtns: [
   /*         
            {
                show: deletes,
                style: deleteObj,
                action: function (id) {
                    idsStr = "{\"ids\":\"" + id.toString() + "\"}";
                    $("#confirm-delete").modal('toggle');
                }
            },  */
        ] 
    };
    datagridUtil.initOption(op);
    datagridUtil.query();

    
</script>
</body>
</html>