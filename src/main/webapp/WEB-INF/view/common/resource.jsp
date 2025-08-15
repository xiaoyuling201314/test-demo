<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt"%>
<% 
String path = request.getContextPath();
String serverName = request.getServerName();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path;
String resourcesUrl = basePath + "/resources/";
%>
<c:set var="webRoot" value="<%=basePath%>" />
<c:set var="serverName" value="<%=serverName%>" />
<c:set var="resourcesUrl" value="<%=resourcesUrl%>" />
<meta charset="UTF-8">
<title>${systemName}</title>
<link rel="shortcut icon" href="${webRoot}/img/favicon.ico">
<%-- css --%>
<link rel="stylesheet" type="text/css" href="${webRoot}/css/iconfont/iconfont.css" />
<link rel="stylesheet" type="text/css" href="${webRoot}/css/password.css" />
<link rel="stylesheet" type="text/css" href="${webRoot}/plug-in/easyui-1.5.2/easyui.css">
<link rel="stylesheet" type="text/css" href="${webRoot}/plug-in/easyui-1.5.2/icon.css">
<link rel="stylesheet" type="text/css" href="${webRoot}/css/validform.css" media="all" />
<link rel="stylesheet" type="text/css" href="${webRoot}/css/bootstrap.css" />
<link rel="stylesheet" type="text/css" href="${webRoot}/css/bootstrap-responsive.css" />
<link rel="stylesheet" type="text/css" href="${webRoot}/js/external/google-code-prettify/prettify.css" />
<link rel="stylesheet" type="text/css" href="${webRoot}/plug-in/select2/css/select2.min.css">
<link rel="stylesheet" type="text/css" href="${webRoot}/css/baguetteBox.min.css" />
<link rel="stylesheet" type="text/css" href="${webRoot}/plug-in/edit-select/jquery-editable-select.css" />

<link rel="stylesheet" type="text/css" href="${webRoot}/css/base.css" />
<link rel="stylesheet" type="text/css" href="${webRoot}/css/index.css" />
<link rel="stylesheet" type="text/css" href="${webRoot}/css/misson.css" />
<link rel="stylesheet" type="text/css" href="${webRoot}/css/blue.css" />

<%-- 达元快检数据预警分析软件（平台） --%>
<%-- <link rel="stylesheet" type="text/css" href="${webRoot}/css/iconfont2/iconfont.css" />
<link rel="stylesheet" type="text/css" href="${webRoot}/css/black.css" />  --%>

<%-- 达元食品安全监督执法软件 --%>
<%-- <link rel="stylesheet" type="text/css" href="${webRoot}/css/light.css" />  --%>


<%-- 4.	达元农批市场台账管理软件  --%>
<%-- <link rel="stylesheet" type="text/css" href="${webRoot}/css/left.css" /> --%>

<%--footable --%>
<link rel="stylesheet" type="text/css" href="${webRoot}/plug-in/footable/footable.core.css">
<%-- <link rel="stylesheet" type="text/css" href="${webRoot}/plug-in/lhgdialog/skins/default.css"> --%>


<%-- javascript --%>

<script type="text/javascript" src="${webRoot}/js/jquery-3.5.1.min.js"></script>
<script type="text/javascript" src="${webRoot}/plug-in/edit-select/jquery-editable-select.js"></script>
<%-- 验证插件 --%>
<script src="${webRoot}/plug-in/validate/jquery-migrate-3.5.0.min.js"></script>
<%--<script src="${webRoot}/plug-in/validate/jquery-git.js"></script>--%>
<script src="${webRoot}/plug-in/validate/jquery.validate.min.js"></script>
<script src="${webRoot}/plug-in/validate/messages_zh.js"></script>

<script type="text/javascript" src="${webRoot}/js/sortable.js"></script>
<script type="text/javascript" src="${webRoot}/js/fileinput.js"></script>
<script type="text/javascript" src="${webRoot}/plug-in/easyui-1.5.2/jquery.easyui.min.js"></script>
<script type="text/javascript" src="${webRoot}/plug-in/easyui-1.5.2/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="${webRoot}/plug-in/bootstrap/bootstrap-4.6.2.js"></script>
<script type="text/javascript" src="${webRoot}/plug-in/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="${webRoot}/plug-in/My97DatePicker/lang/zh-cn.js"></script>
<script type="text/javascript" src="${webRoot}/js/dateUtil.js"></script>
<script type="text/javascript" src="${webRoot}/js/index.js"></script>
<%-- <script type="text/javascript" src="${webRoot}/plug-in/lhgdialog/lhgdialog.min.js?self=true&skin=default"></script>  --%>
<script type="text/javascript" src="${webRoot}/plug-in/Validform_v5.3.2/Validform_v5.3.2.js"></script>
<script type="text/javascript" src="${webRoot}/plug-in/Validform_v5.3.2/Validform_Datatype.js"></script>

<%-- yuling --%>
<%-- <script type="text/javascript" src="${webRoot}/js/menuList.js"></script> --%>
<script type="text/javascript" src="${webRoot}/js/list.js"></script>

<%-- 图片预览 --%>
<script type="text/javascript" src="${webRoot}/js/baguetteBox.min.js"></script>


<script type="text/javascript" src="${webRoot}/plug-in/echarts/echarts.min.js"></script> 
<script type="text/javascript" src="${webRoot}/plug-in/echarts/shine.js"></script>

<%-- 上传 --%>
<script type="text/javascript" src="${webRoot}/js/external/jquery.hotkeys.js"></script>
<script type="text/javascript" src="${webRoot}/js/external/google-code-prettify/prettify.js"></script>
<script type="text/javascript" src="${webRoot}/js/bootstrap-wysiwyg.js"></script>
<script type="text/javascript" src="${webRoot}/js/theme.js"></script>


<%-- select2 搜索 --%>
<script type="text/javascript" src="${webRoot}/plug-in/select2/js/select2.js"></script>

<%-- 窗口拖拽 --%>
<script type="text/javascript" src="${webRoot}/plug-in/drag/drag.js"></script>
<%-- footable --%>
<script type="text/javascript" src="${webRoot}/plug-in/footable/footable.all.min.js"></script>

<%-- 进度 --%>
<%-- <script type="text/javascript" src="${webRoot}/js/jquery-ui-1.8.16.custom.min.js"></script> --%>
<%-- <script type="text/javascript" src="${webRoot}/js/zh.js"></script> --%>
<script type="text/javascript" src="${webRoot}/js/layer/layer.js"></script>
<script type="text/javascript" src="${webRoot}/js/jeeplus.js"></script>
<script type="text/javascript">
<%--
/*********** 配置lhgdialog全局默认参数(可选) ***********/
(function(config){
	config['drag'] = true;
    config['extendDrag'] = true; // 注意，此配置参数只能在这里使用全局配置，在调用窗口的传参数使用无效
    config['lock'] = true;
    config['fixed'] = true;
    config['okVal'] = "确认";
    config['cancelVal'] = "取消";
    config['min'] = false;
    config['max'] = false;
    config['esc'] = false;
    config['resize'] = false;
    // [more..]
})($.dialog.setting);
--%>
<%-- 分页每页记录数量 --%>
var pageSize = window.localStorage.pageSize == null ? 10 : window.localStorage.pageSize;
<%-- 操作按钮控制 --%>
var edit = 0;		//是否显示编辑按钮
var deletes = 0;  	//是否显示删除按钮
var exports = 0;  	//是否显示导出按钮
var deleteObj;  	//删除按钮对象，属性同TSOperation，有功能名称和图标
var editObj;		//编辑按钮对象，属性同TSOperation
var exportObj;		//导出按钮对象，属性同TSOperation
<%-- var menus = '${menusStr}'; --%>
var childBtnMenu = eval('${btnList}');

<%--  读取用户权限 --%>
var Permission = (function(){
    // var m = {};
    // if(menus){
    //     for (var i = 0; i < menus.length; i++) {
    //         m[menus[i].id] = menus[i];
    //     }
    // }

	var permissionsObj = {};
	if(childBtnMenu){
        for (var i = 0; i < childBtnMenu.length; i++) {
            permissionsObj[childBtnMenu[i].operationCode] = childBtnMenu[i];
        }
    }

	return {
		<%-- 根据编码查询是否有权限 --%>
		exist: function(pCode){
			if(!permissionsObj[pCode]){
				return 0;//没有权限
			}else{
				return 1;
			}
		},
		<%-- 根据编码获取权限 --%>
		getPermission: function(pCode){
			if(!permissionsObj[pCode]){
				return '';//没有权限
			}else{
				return permissionsObj[pCode];
			}
        }
	}
})();

<%-- 同步数据地址 --%>
var syncDataUrl="";
</script>
