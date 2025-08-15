<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 选择检测点 -->
<div class="modal fade intro2" id="myUserModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
 <div class="modal-dialog cs-xlg-width" role="document">
    <div class="modal-content" style="margin-top: 0px;">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
        <h4 class="modal-title">用户名</h4>
      </div>
      <div class="modal-body cs-xlg-height">
         <!-- 主题内容 -->
        <div class="cs-mechanism-list">
        <div class="cs-mechanism-list-title cs-font-weight">机构列表</div>
        <div class="cs-mechanism-list-content">
           <ul id="departUserTree" class="easyui-tree"></ul>
        </div>
      </div>

        <div class="cs-points-list">
          <div class="cs-mechanism-tab">
        </div>
        <div class="cs-mechanism-list-content" style="padding:0;">
        <div class="cs-mechanism-list-search clearfix">
          <div class="cs-selcet cs-fl" style="padding: 9px 0 0 0;">
            <input class="cs-fl" id="subsets" type="checkbox" /><label class="cs-fl" for="subsets" style="margin-left:4px; color:#666;">包含下级</label>
          </div>
          <div class="cs-fr">
              <div class="cs-search-margin clearfix cs-fl">
                <input class="cs-input-cont cs-fl" type="text" placeholder="请输入用户名" name="searchUserName">
                <input type="submit" class="cs-search-btn cs-fl" href="javascript:;" value="搜索" onclick="loadUsers();">
              </div>
  			</div>
        </div>
        <div class="cs-mechanism-table-box cs-mechanism-table-box2">
        <table class="cs-mechanism-table" width="100%" id="usersList">
          <tr>
            <th><input type="checkbox" /></th>
            <th>用户名</th>
          </tr>
        </table>
        </div>
        </div>
        </div>


        <div class="cs-secleted-list">
          <div class="cs-mechanism-list-title">
          <span class="cs-fl cs-font-weight">已选择用户：</span>
          <span class="cs-title-tip text-muted"><span class="checkedUserNumber">0</span>个</span>
          <a class="cs-fr cs-secleted-del" href="javascript:" onclick="deleteAllUser();"><i class="text-del">全部删除</i></a>
          </div>
          <div class="cs-mechanism-list-content">
            <table class="cs-mechanism-table" width="100%" id="checkedUsers">
	        </table>
          </div>
        </div>

      </div>
      <div class="modal-footer">
      <button type="button" class="btn btn-success" onclick="userConfirm();">确定</button>
        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
      </div>
    </div>
  </div>
</div>
<!-- JavaScript -->
<script type="text/javascript">
var tid = '';//当前用户组织机构ID
var pid = '';//当前用户父机构ID
if ('${sessionScope.org}') {
	tid = '${sessionScope.org.id}';
}
//人员数组
var usersArray = [];

//打开模态框事件
$('#myUserModal').on('show.bs.modal', function () {
	//刷新列表
	checkedDepartId = tid;
	loadDepartUserTree();
	//清空检测点名称查询条件
	$("input[name='searchUserName']").val("");
	//加载检测点列表
	loadUsers();
	//清空
	deleteAllUser();
});

//加载组织机构树形控件数据列表
var checkedDepartId = tid;//选中机构ID,默认当前用户机构
function loadDepartUserTree(){
	$("#departUserTree").tree({
		url:"${webRoot}/detect/depart/getDepartTree.do",
		animate:true,
		onClick : function(node){
			//设置选中机构ID
			checkedDepartId = node.id;
			//清空检测点名称查询条件
			$("input[name='searchUserName']").val("");
			//加载检测点列表
			loadUsers();
		},
	    onLoadSuccess: function (node, data) {
		      if (data) {
		          $(data).each(function (index,d) {
		          //只展开1级
						if(d.id==1&&d.state=="closed"){
			              var children = $("#departUserTree").tree("getChildren");
			              for (var i = 0; i < children.length; i++) {
			                $("#departUserTree").tree("expand", children[i].target);
			              }
			          	}
		           });
		        }
		      }
	});
}

//加载检测点列表
function loadUsers(){
	//是否包含子级检测点	N不包含,Y包含
	var subsets = "N";
	if($('#subsets').is(':checked')) {
		subsets = "Y";
	}
	
	//检测点名称查询条件
	var realname = $("input[name='searchUserName']").val();
	
	$.ajax({
        type: "POST",
        url: '${webRoot}'+"/queryByDepartId.do",
        data: {"departId":checkedDepartId,"subset":subsets,"realname":realname},
        dataType: "json",
        success: function(data){
        	if(data && data.success){
        		$("#usersList tr:gt(0)").remove();
        		$("#usersList input[type='checkbox']:eq(0)").prop("checked",false);
        		for(var i=0;i<data.obj.length;i++){
        			if(usersArray.length>0){
	        			for(var ii=0;ii<usersArray.length;ii++){
	        				if(data.obj[i].id == usersArray[ii]["id"]){
		        				//已选
	        					var html = "<tr><td><input type=\"checkbox\" checked=\"checked\" class=\"pointItem\" value=\""+data.obj[i].id+"\" data-userName=\""+data.obj[i].realname+"\"/></td>"
	            					+ "<td>"+data.obj[i].realname+"</td></tr>";
	        					$("#usersList").append(html);
	        					break;
	        				}else if(ii == usersArray.length-1){
	        					//未选
	        					var html = "<tr><td><input type=\"checkbox\" class=\"pointItem\" value=\""+data.obj[i].id+"\" data-userName=\""+data.obj[i].realname+"\"/></td>"
	            					+ "<td>"+data.obj[i].realname+"</td></tr>";
			        			$("#usersList").append(html);
	        				}
	        			}
        			}else{
	        			var html = "<tr><td><input type=\"checkbox\" class=\"pointItem\" value=\""+data.obj[i].id+"\" data-userName=\""+data.obj[i].realname+"\"/></td>"
	        				+ "<td>"+data.obj[i].realname+"</td></tr>";
	        			$("#usersList").append(html);
        			}
        		}
        	}
		}
    });
}

//包含下级检测点
$(document).on("change","#subsets",function(){
	//加载检测点列表
	loadUsers();
});

//全选
$(document).on("change","#usersList input[type='checkbox']:eq(0)",function(){
	if($(this).is(':checked')) {
		$("#usersList input[type='checkbox']:gt(0)").prop("checked",true);
		$("#usersList input[type='checkbox']:gt(0)").each(function(){
			addByUserValue($(this).val(),$(this).attr("data-userName"));
		});
	}else{
		$("#usersList input[type='checkbox']:gt(0)").prop("checked",false);
		$("#usersList input[type='checkbox']:gt(0)").each(function(){
			removeByUserValue($(this).val());
		});
	}
	loadCheckedUsers();
});

//获取已选择检测点
$(document).on("change","#usersList input[type='checkbox']:gt(0)",function(){
	var allUsers = $("#usersList input[type='checkbox']:gt(0)").length;	//所有检测点数量
	var checkedUsers = $("#usersList input[type='checkbox']:gt(0):checked").length;	//已选择检测点数量
	//控制全选
	if(allUsers == 0 || allUsers > checkedUsers){
		$("#usersList input[type='checkbox']:eq(0)").prop("checked",false);
	}else{
		$("#usersList input[type='checkbox']:eq(0)").prop("checked",true);
	}
	
	//添加/删除检测点数组元素
	if($(this).is(':checked')) {
		addByUserValue($(this).val(),$(this).attr("data-userName"));
	}else{
		removeByUserValue($(this).val());
	}
	loadCheckedUsers();
});

//加载检测点数组数据
function loadCheckedUsers(){
	$("#checkedUsers tr").remove();
	for(var i=0;i<usersArray.length;i++){
		var html = "<tr><td>"+ usersArray[i]["name"] +"</td><td><a href=\"javascript:;\" onclick=\"deleteOneUser('"+ usersArray[i]["id"] +"')\">"
			+ "<span class=\"cs-icon-span\"><i class=\"icon iconfont icon-shanchu text-del\"></i></span></a></td></tr>";
		$("#checkedUsers").append(html);
	}
	$(".checkedUserNumber").text(usersArray.length);
}

//添加检测点数组元素
function addByUserValue(id,name) {
	if(usersArray.length > 0){
		for(var i=0; i<usersArray.length; i++) {
			if(usersArray[i]["id"] == id){
				//检测点ID已存在，不再添加
				break;
			}else if(i == usersArray.length-1){
				usersArray.push({"id":id,"name":name});
			}
		}
	}else{
		usersArray.push({"id":id,"name":name});
	}
}

//删除检测点数组元素
function removeByUserValue(deleteUserId) {
  for(var i=0; i<usersArray.length; i++) {
	if(usersArray[i]["id"] == deleteUserId){
		usersArray.splice(i, 1);
		break;
	}
  }
}

//删除已选择检测点-删除图标
function deleteOneUser(deleteUserId){
	removeByUserValue(deleteUserId);
	loadCheckedUsers();
	//取消复选框选中
	$("#usersList input[type='checkbox']:gt(0)").each(function(){
		if($(this).val() == deleteUserId){
			$(this).prop("checked",false);
		}
	});
}

//删除已选择检测点-全部删除
function deleteAllUser(){
	usersArray.splice(0,usersArray.length);
	loadCheckedUsers();
	$("#usersList input[type='checkbox']").prop("checked",false);
}

//确认
function userConfirm(){
	selUser(usersArray);
}

</script>