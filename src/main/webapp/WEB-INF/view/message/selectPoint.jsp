<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 选择检测点 -->
<div class="modal fade intro2" id="myPointModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
 <div class="modal-dialog cs-xlg-width" role="document">
    <div class="modal-content" style="margin-top: 0px;">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
        <h4 class="modal-title">选择检测点</h4>
      </div>
      <div class="modal-body cs-xlg-height">
         <!-- 主题内容 -->
        <div class="cs-mechanism-list">
        <div class="cs-mechanism-list-title cs-font-weight">机构列表</div>
        <div class="cs-mechanism-list-content">
           <ul id="departTree" class="easyui-tree"></ul>
        </div>
      </div>

        <div class="cs-points-list cs-points-list2">
          <div class="cs-mechanism-tab">
        </div>
        <div class="cs-mechanism-list-content cs-mechanism-list-content2" style="padding:0;">
        <div class="cs-mechanism-list-search clearfix">
          <div class="cs-selcet cs-fl" style="padding: 9px 0 0 0;">
            <input class="cs-fl" id="subset" type="checkbox" /><label class="cs-fl" for="subset" style="margin-left:4px; color:#666;">包含下级</label>
          </div>
          <div class="cs-fr">
              <div class="cs-search-margin clearfix cs-fl">
                <input class="cs-input-cont cs-fl" type="text" placeholder="请输入检测点名称" name="searchPointName">
                <input type="submit" class="cs-search-btn cs-fl" href="javascript:;" value="搜索" onclick="loadPoints();">
              </div>
  			</div>
        </div>
        <div class="cs-mechanism-table-box cs-mechanism-table-box2">
        <table class="cs-mechanism-table" width="100%" id="pointsList">
          <tr>
            <th><input type="checkbox" /></th>
            <th>检测点</th>
          </tr>
        </table>
        </div>
        </div>
        </div>


        <div class="cs-secleted-list">
          <div class="cs-mechanism-list-title">
          <span class="cs-fl cs-font-weight">已选择检测点：</span>
          <span class="cs-title-tip text-muted"><span class="checkedNumber">0</span>个</span>
          <a class="cs-fr cs-secleted-del" href="javascript:" onclick="deleteAll();"><i class="text-del">全部删除</i></a>
          </div>
          <div class="cs-mechanism-list-content">
            <table class="cs-mechanism-table" width="100%" id="checkedPoints">
	        </table>
          </div>
        </div>

      </div>
      <div class="modal-footer">
      <button type="button" class="btn btn-success" onclick="pointConfirm();">确定</button>
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
	//alert(pid);
	//pid = '${sessionScope.org.departPid}';
}
//检测点数组
var pointsArray = [];

//打开模态框事件
$('#myPointModal').on('show.bs.modal', function () {
	//刷新列表
	checkedDepartId = tid;
	loadDepartTree();
	//清空检测点名称查询条件
	$("input[name='searchPointName']").val("");
	//加载检测点列表
	loadPoints();
	//清空
	deleteAll();
	iii=0;
});

//加载组织机构树形控件数据列表
var checkedDepartId = tid;//选中机构ID,默认当前用户机构
var iii=0;
function loadDepartTree(){
	$("#departTree").tree({
		url:"${webRoot}/detect/depart/getDepartTree.do",
		animate:true,
		onClick : function(node){
			//设置选中机构ID
			checkedDepartId = node.id;
			//清空检测点名称查询条件
			$("input[name='searchPointName']").val("");
			//加载检测点列表
			loadPoints();
		},
		onLoadSuccess: function (node, data) {
			//延迟执行自动加载二级数据，避免与异步加载冲突
			if(iii < 1){//默认展开一级
				iii++;
				setTimeout(function(){
					if (data) {
				    	$(data).each(function (index, d) {
				         	if (this.state == 'closed') {
				        		var children = $('#departTree').tree('getChildren');
				        		for (var i = 0; i < children.length; i++) {
				            		$('#departTree').tree('expand', children[i].target);
				            	}
				         	}
				    	});
					}
				}, 100);
			}
		}
	});
}

//加载检测点列表
function loadPoints(){
	//是否包含子级检测点	N不包含,Y包含
	var subset = "N";
	if($('#subset').is(':checked')) {
		subset = "Y";
	}
	
	//检测点名称查询条件
	var pointName = $("input[name='searchPointName']").val();
	
	$.ajax({
        type: "POST",
        url: '${webRoot}'+"/detect/basePoint/queryByDepartId.do",
        data: {"departId":checkedDepartId,"subset":subset,"pointName":pointName},
        dataType: "json",
        success: function(data){
        	if(data && data.success){
        		$("#pointsList tr:gt(0)").remove();
        		$("#pointsList input[type='checkbox']:eq(0)").prop("checked",false);
        		for(var i=0;i<data.obj.length;i++){
        			if(pointsArray.length>0){
	        			for(var ii=0;ii<pointsArray.length;ii++){
	        				if(data.obj[i].id == pointsArray[ii]["id"]){
		        				//已选
	        					var html = "<tr><td><input type=\"checkbox\" checked=\"checked\" class=\"pointItem\" value=\""+data.obj[i].id+"\" data-pointName=\""+data.obj[i].pointName+"\"/></td>"
	            					+ "<td>"+data.obj[i].pointName+"</td></tr>";
	        					$("#pointsList").append(html);
	        					break;
	        				}else if(ii == pointsArray.length-1){
	        					//未选
	        					var html = "<tr><td><input type=\"checkbox\" class=\"pointItem\" value=\""+data.obj[i].id+"\" data-pointName=\""+data.obj[i].pointName+"\"/></td>"
	            					+ "<td>"+data.obj[i].pointName+"</td></tr>";
			        			$("#pointsList").append(html);
	        				}
	        			}
        			}else{
	        			var html = "<tr><td><input type=\"checkbox\" class=\"pointItem\" value=\""+data.obj[i].id+"\" data-pointName=\""+data.obj[i].pointName+"\"/></td>"
	        				+ "<td>"+data.obj[i].pointName+"</td></tr>";
	        			$("#pointsList").append(html);
        			}
        		}
        	}
		}
    });
}

//包含下级检测点
$(document).on("change","#subset",function(){
	//加载检测点列表
	loadPoints();
});

//全选
$(document).on("change","#pointsList input[type='checkbox']:eq(0)",function(){
	if($(this).is(':checked')) {
		$("#pointsList input[type='checkbox']:gt(0)").prop("checked",true);
		$("#pointsList input[type='checkbox']:gt(0)").each(function(){
			addByValue($(this).val(),$(this).attr("data-pointName"));
		});
	}else{
		$("#pointsList input[type='checkbox']:gt(0)").prop("checked",false);
		$("#pointsList input[type='checkbox']:gt(0)").each(function(){
			removeByValue($(this).val());
		});
	}
	loadCheckedPoints();
});

//获取已选择检测点
$(document).on("change","#pointsList input[type='checkbox']:gt(0)",function(){
	var allPoints = $("#pointsList input[type='checkbox']:gt(0)").length;	//所有检测点数量
	var checkedPoints = $("#pointsList input[type='checkbox']:gt(0):checked").length;	//已选择检测点数量
	//控制全选
	if(allPoints == 0 || allPoints > checkedPoints){
		$("#pointsList input[type='checkbox']:eq(0)").prop("checked",false);
	}else{
		$("#pointsList input[type='checkbox']:eq(0)").prop("checked",true);
	}
	
	//添加/删除检测点数组元素
	if($(this).is(':checked')) {
		addByValue($(this).val(),$(this).attr("data-pointName"));
	}else{
		removeByValue($(this).val());
	}
	loadCheckedPoints();
});

//加载检测点数组数据
function loadCheckedPoints(){
	$("#checkedPoints tr").remove();
	for(var i=0;i<pointsArray.length;i++){
		var html = "<tr><td>"+ pointsArray[i]["name"] +"</td><td><a href=\"javascript:;\" onclick=\"deleteOne('"+ pointsArray[i]["id"] +"')\">"
			+ "<span class=\"cs-icon-span\"><i class=\"icon iconfont icon-shanchu text-del\"></i></span></a></td></tr>";
		$("#checkedPoints").append(html);
	}
	$(".checkedNumber").text(pointsArray.length);
}

//添加检测点数组元素
function addByValue(id,name) {
	if(pointsArray.length > 0){
		for(var i=0; i<pointsArray.length; i++) {
			if(pointsArray[i]["id"] == id){
				//检测点ID已存在，不再添加
				break;
			}else if(i == pointsArray.length-1){
				pointsArray.push({"id":id,"name":name});
			}
		}
	}else{
		pointsArray.push({"id":id,"name":name});
	}
}

//删除检测点数组元素
function removeByValue(deletePointId) {
  for(var i=0; i<pointsArray.length; i++) {
	if(pointsArray[i]["id"] == deletePointId){
		pointsArray.splice(i, 1);
		break;
	}
  }
}

//删除已选择检测点-删除图标
function deleteOne(deletePointId){
	removeByValue(deletePointId);
	loadCheckedPoints();
	//取消复选框选中
	$("#pointsList input[type='checkbox']:gt(0)").each(function(){
		if($(this).val() == deletePointId){
			$(this).prop("checked",false);
		}
	});
}

//删除已选择检测点-全部删除
function deleteAll(){
	pointsArray.splice(0,pointsArray.length);
	loadCheckedPoints();
	$("#pointsList input[type='checkbox']").prop("checked",false);
}

//确认
function pointConfirm(){
	selPoint(pointsArray);
}

</script>