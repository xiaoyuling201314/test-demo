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
            <a href="javascript:">优惠活动</a></li>
        <li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
        <li class="cs-b-active cs-fl">优惠活动
        </li>
    </ol>
    <!-- 面包屑导航栏  结束-->
    <div class="cs-search-box cs-fr">
        <form action="datagrid.do">
            <div class="cs-search-filter clearfix cs-fl">
                <input class="cs-input-cont cs-fl focusInput" type="text" name="theme" placeholder="请输入活动主题"/>
                <input type="button" onclick="datagridUtil.queryByFocus();" class="cs-search-btn cs-fl" href="javascript:;" value="搜索">
            </div>
            <div class="clearfix cs-fr" id="showBtn">
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
    <%@include file="/WEB-INF/view/common/modalBox.jsp"%>
<script src="${webRoot}/js/datagridUtil.js"></script>
<%--引入ztree插件--%>
<script type="text/javascript" src="${webRoot}/plug-in/ztree/js/jquery.ztree.core.js"></script>
<script type="text/javascript" src="${webRoot}/plug-in/ztree/js/jquery.ztree.excheck.js"></script>
<script type="text/javascript" src="${webRoot}/plug-in/ztree/js/jquery.ztree.exhide.js"></script>
<script type="text/javascript" src="${webRoot}/plug-in/ztree/js/fuzzysearch.js"></script>
<script type="text/javascript">
var closeNow=0;//立即关闭
var closeNowObj=null;
var openNow=0;//立即开启
var openNowObj=null;
var log=0;//立即开启
var logObj=null;
var chakan=0;//查看
var chakanObj=null;
    for (var i = 0; i < childBtnMenu.length; i++) {
        if (childBtnMenu[i].operationCode == "1451-1") {
            var html = '<a class="cs-menu-btn" href="${webRoot}/specialOffer/edit.do" ><i class="' + childBtnMenu[i].functionIcon + '"></i>新增</a>';
            $("#showBtn").append(html);
        } else if (childBtnMenu[i].operationCode == "1451-8") {
            edit = 1;
            editObj = childBtnMenu[i];
        } else if (childBtnMenu[i].operationCode == "1451-2") {//删除
            deletes = 1;
            deleteObj = childBtnMenu[i];
        }else if (childBtnMenu[i].operationCode == "1451-5") {//立即生效
            openNow = 1;
            openNowObj = childBtnMenu[i];
        }else if (childBtnMenu[i].operationCode == "1451-6") {//立即终止
            closeNow = 1;
            closeNowObj = childBtnMenu[i];
        }else if (childBtnMenu[i].operationCode == "1451-9") {//查看操作日志
        	log = 1;
        	logObj = childBtnMenu[i];
        }else if (childBtnMenu[i].operationCode == "1451-10") {//查看
        	chakan = 1;
        	chakanObj = childBtnMenu[i];
        }
    }

    var op = {
        tableId: "dataList",	//列表ID
        tableAction: "${webRoot}/specialOffer/datagrid.do",	//加载数据地址
        parameter: [		//列表拼接参数
            {
                columnCode: "theme",
                columnName: "活动主题",
                columnWidth: '20%'
            },
            {
                columnCode: "discount",
                columnName: "折扣率",
                columnWidth: '80px',
                sortDataType:"float"
            },
            {
                columnCode: "timeStart",
                columnName: "开始时间",
                dateFormat: "yyyy-MM-dd HH:mm:ss",
                columnWidth: '120px'
            },
            {
                columnCode: "timeEnd",
                columnName: "结束时间",
                dateFormat: "yyyy-MM-dd HH:mm:ss",
                columnWidth: '120px'
            }
           
            , {
                columnCode: "status",
                columnName: "活动状态",
                customVal: {0: "<span class='text-success'>未开启</span>", 1: "<span class='text-danger'>进行中</span>", 2: "<span class='text-success'>已终止</span>"},
                columnWidth: '80px'
            } ,
            {
                columnCode: "checked",
                columnName: "审核",
                customVal: {1: "<span class='text-success'>已审核</span>", 0: "<span class='text-danger'>未审核</span>"},
                columnWidth: '80px'
            }
        ],
        funBtns: [
            {
                show: edit,
                style: editObj,
                action: function (id) {
                	self.location="${webRoot}/specialOffer/edit.do?id="+id;
                }
            },
            {
                show: chakan,
                style: chakanObj,
                action: function (id) {
                	self.location="${webRoot}/specialOffer/edit.do?id="+id;
                }
            },
            {
                show: deletes,
                style: deleteObj,
                action: function (id) {
                    idsStr = "{\"ids\":\"" + id.toString() + "\"}";
                    $("#confirm-delete").modal('toggle');
                }
            },
            {
                show: openNow,
                style: openNowObj,
                action: function (id) {
                	$("#tips").html("确认要立即开启活动吗？");
                	$('#affirm').removeAttr('onclick');
                	$("#affirm").attr("onclick","satrtOffer("+id+");");
                    $("#newconfirmModal").modal('toggle');
                }
            },
            {
                show: closeNow,
                style: closeNowObj,
                action: function (id) {
                	$("#tips").html("确认要立即终止活动吗？");
                	$('#affirm').removeAttr('onclick');
                	$("#affirm").attr("onclick","stopOffer("+id+");");
                    $("#newconfirmModal").modal('toggle');
                }
            },
            {
                show: log,
                style: logObj,
                action: function (id) {
                    var src = '${webRoot}/specialOfferLog/list.do?offerId='+id;
	    			showMbIframe(src);
                }
            }
        ]/* ,
        bottomBtns: [
            {	//删除函数
                show: deletes,
                style: deleteObj,
                action: function (ids) {
                    idsStr = "{\"ids\":\"" + ids.toString() + "\"}";
                    $("#confirm-delete").modal('toggle');
                }
            }
        ], */, //底部按钮
		 onload: function(){
				/*  console.log(datagridOption);
				 for (var i = 0; i < datagridOption.obj.length; i++) {
						alert(datagridOption.obj[i].managementType);
					if(datagridOption.obj[i].managementType==1){
					
					}
					 
				} */
				var obj = datagridOption["obj"];
		    	$(".rowTr").each(function(){
			    	for(var i=0;i<obj.length;i++){
				    		if($(this).attr("data-rowId") == obj[i].id){
				    			var status=obj[i].status;//活动状态
				    			var checked=obj[i].checked;
				    		 
				    			if(status==0){//活动未开启 关闭按钮隐藏
				    				if(checked==1){//审核隐藏编辑
				    					$(this).find(".1451-2").hide();
				    				}else{
				    					$(this).find(".1451-10").hide();
				    					$(this).find(".1451-5").hide();
						    			$(this).find(".1451-6").hide();
				    				}
				    			}else if(status==1){//进行中 开启按钮隐藏
				    				$(this).find(".1451-5").hide();
				    				$(this).find(".1451-2").hide();
				    				$(this).find(".1451-8").hide();
					    		}else if(status==2){//2 已终止
					    			$(this).find(".1451-5").hide();
					    			$(this).find(".1451-6").hide();
					    			$(this).find(".1451-2").hide();
					    			$(this).find(".1451-8").hide();
					    		}
				    			
				    		}
				    			
			    		}
		    	});
				 
			}
    };
    datagridUtil.initOption(op);
    datagridUtil.query();

    
    //立即开启活动
    function satrtOffer(id) {
	                	 $("#newconfirmModal").modal('toggle');
		  $.ajax({
	            type: "POST",
	            url: "${webRoot}/specialOffer/startOffer.do?id="+id,
	            data: {},
	            dataType: "json",
	            success: function (data) {
	                if (data && data.success) {
	                    //删除成功后刷新列表
	                    datagridUtil.queryByFocus();
	                } else {
	                    $("#waringMsg>span").html(data.msg);
	                    $("#confirm-warnning").modal('toggle');
	                }
	            }
	        });
	}
    
    //立即关闭
    function stopOffer(id) {
   	 $("#newconfirmModal").modal('toggle');
	  $.ajax({
           type: "POST",
           url: "${webRoot}/specialOffer/stopCron.do?id="+id,
           data: {},
           dataType: "json",
           success: function (data) {
               if (data && data.success) {
                   //删除成功后刷新列表
                   datagridUtil.queryByFocus();
               } else {
                   $("#waringMsg>span").html(data.msg);
                   $("#confirm-warnning").modal('toggle');
               }
           }
       });
	}
 

    function getId(id) {
        if (id) {
            $("#addModal .modal-title").text("编辑");
            $.ajax({
                url: "${webRoot}/system/scheduled/queryById.do",
                type: "POST",
                data: {"id": id},
                dataType: "json",
                success: function (data) {
                    if (data && data.success) {
                        $('#saveForm').form('load', data.obj);
                        //选中机构的赋值
                        var v = "";
                        var treeObj = $.fn.zTree.getZTreeObj("myTree");
                        var nodes = treeObj.transformToArray(treeObj.getNodes());
                        //console.log(nodes);
                        var departIds = data.obj.departIds;
                        arrIds = departIds.split(",");
                        var len = arrIds.length;
                        var len2 = nodes.length;
                        if (len > 0) {
                            for (i = 0; i < len; i++) {
                                for (p = 0; p < len2; p++) {
                                    if (nodes[p].id == arrIds[i]) {//如果id相同就添加进入
                                        v += nodes[p].name + ",";
                                        treeObj.checkNode(nodes[p], true, true);
                                    }
                                }
                            }
                        }
                        //treeObj.checkAllNodes(false);//勾选或取消全部节点
                        if (v.length > 0) v = v.substring(0, v.length - 1);
                        $("#departName").val(v);

                    }
                }
            });
        } else {
            $("#addModal .modal-title").text("新增");
        }
        $("#addModal").modal("show");
    }


    $(function () {
        //验证
        var scheduledForm = $("#saveForm").Validform({
            tiptype: 3,
            callback: function (data) {
                if (data.success) {
                    self.location.reload();
                } else {
                    $.Showmsg(data.msg);
                }
                return false;
            }
        });

        // 新增或修改
        $("#btnSave").on("click", function () {
            scheduledForm.ajaxPost();
        });

        //关闭编辑模态框前重置表单，清空隐藏域
        $('#addModal').on('hidden.bs.modal', function (e) {
            scheduledForm.resetForm();
            scheduledForm.resetStatus();
            $("input[type='hidden']").val("");
            //从新初始化机构树,防止搜索功能的影响
            $.fn.zTree.init($("#myTree"), setting, zNodes);
        });
    });
    //删除
    function deleteData() {
        $.ajax({
            type: "POST",
            url: "${webRoot}/specialOffer/delete.do",
            data: JSON.parse(idsStr),
            dataType: "json",
            success: function (data) {
                $("#confirm-delete").modal('toggle');
                if (data && data.success) {
                    //删除成功后刷新列表
                    datagridUtil.queryByFocus();
                } else {
                    $("#waringMsg>span").html(data.msg);
                    $("#confirm-warnning").modal('toggle');
                }
            }
        });
    }
</script>
</body>
</html>