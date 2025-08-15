<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/common/resource.jsp"%>
<html>
  <head>
    <title>快检服务云平台</title>
  </head>
  <body class="easyui-layout">
   	<div data-options="region:'west',split:true,title:'组织机构'" style="width: 200px; padding: 10px;">
		<ul id="departTree" class="easyui-tree"></ul>
	</div>
	<div data-options="region:'north',border:false" style="top:0px; border: none;">
		<div >
			<!-- 面包屑导航栏  开始-->
			<ol class="cs-breadcrumb">
				<li class="cs-fl"><img src="${webRoot}/img/set.png" alt="" /><a href="javascript:">检测点管理</a></li>
				<li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
				<li class="cs-b-active cs-fl">机构单位</li>
			</ol>
			<!-- 面包屑导航栏  结束-->
			<div class="cs-search-box cs-fr">
				<form>
					<div class="clearfix cs-fr" id="showBtn"></div>
				</form>
			</div>
		</div>
	</div>
          
        <div data-options="region:'center'">
          <div class="clearfix">  
              <ul class="cs-point-list">
              </ul>  
            </div>	
          </div>
          
          <!-- 下级机构 -->
          <div id="mb1" class="cs-hide">
              			<li class="cs-ovow cs-list-table">
		                  <div class="cs-li-title">  
		                    <span><i class="departName"></i></span>
		                  </div>  
		                  <div class="clearfix">  
		                  <div class="cs-fl cs-list-img clearfix"  style="width:25%;">   
		                  <i title="cheliang" class="icon iconfont icon-jigou cs-icon-head"></i>
		                  </div>
		                  <div class="cs-list-p cs-fl clearfix" style="width:74%;">    
		                      <p>
		                      	<span class="cs-outfit-name">直属快检点：</span>
		                      	<a class="text-muted subPointSize" href="javascript:" onclick="">个</a>
								<span class="text-muted subPointSize">0个</span>
		                      </p>
		                      <p>
		                      	<span class="cs-outfit-name">检测点人员：</span>
		                      	<span class="text-muted membersSize">人</span>
		                      </p>
		                      <p>
		                      	<span class="cs-outfit-name">下级机构：</span>
		                      	<a class="text-muted subDepartSize" href="javascript:" onclick="">个</a>
								<span class="text-muted subDepartSize">0个</span>
		                      </p>
		                  </div>
		                  </div>
		                </li>
          </div>
          
    <!-- 新增、编辑检测点模态框 -->
    <%@include file="/WEB-INF/view/detect/basePoint/addPoint.jsp"%>
    <%@include file="/WEB-INF/view/common/modalBox.jsp"%>
  
    <!-- JavaScript -->
    <script type="text/javascript">
    
	for (var i = 0; i < childBtnMenu.length; i++) {
		if (childBtnMenu[i].operationCode == "392-1") {
			//新增
			var html='<a class="cs-menu-btn" href="javascript:;" onclick="addPoint()"><i class="'+childBtnMenu[i].functionIcon+'"></i>'+childBtnMenu[i].operationName+'</a>';
			$("#showBtn").prepend(html);
		}
	}
	
	//加载组织机构树形控件数据列表
	loadDepartTree();
	var treeLevel = 1;	//控制机构树加载二级数据
	var ii = 0;
	function loadDepartTree(){
		treeLevel = 1;
		$("#departTree").tree({
			url:"${webRoot}/detect/depart/getDepartTree.do",
			animate:true,
			onClick : function(node){
				if(!$('#departTree').tree('isLeaf', node.target)){
					//有下级机构
					viewDepartOrPoint(node.id, 2);
				}else{
					viewPoint(node.id);
				}
			},
			onLoadSuccess: function (node, data) {
				//延迟执行自动加载二级数据，避免与异步加载冲突
				setTimeout(function(){
					if (data && treeLevel == 1) {
						treeLevel++;
						
							//初始化，加载第一个节点数据
							if(ii == 0){
								var topNode = $('#departTree').tree('getRoot');
								if(!$('#departTree').tree('isLeaf', topNode.target)){
									//有下级机构
									viewDepartOrPoint(topNode.id, 2);
								}else{
									viewPoint(topNode.id);
								}
								ii++;
							}
				    		
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
		});
	}
	
	
	//获取下级机构，如果没下级机构取获取检测点
	function viewDepartOrPoint(departId, dataType){
		$.ajax({
	        type: "POST",
	        url: "${webRoot}/detect/depart/queryByDepartId.do",
	        data: {"departId":departId, "dataType":dataType},
	        dataType: "json",
	        success: function(data){
	        	if(data && data.success){
	        		$(".cs-point-list").html("");
	        		
	        		var departInfos = data.obj.departInfos;
	        		if(departInfos){
	        			for(var i=0;i<departInfos.length;i++){
			        		var mb1 = $("#mb1").clone();
			        		
	        				mb1.find(".departName").html(departInfos[i].depart.departName);
	        				
	        				mb1.find(".subPointSize").html(departInfos[i].subPointSize + "个");
	        				if(departInfos[i].subPointSize == 0){
	        					mb1.find(".subPointSize:eq(0)").remove();
	        				}else{
	        					mb1.find(".subPointSize:eq(0)").attr("onclick","viewPoint('"+departInfos[i].depart.id+"')");
	        					mb1.find(".subPointSize:eq(1)").remove();
	        				}
	        				
	        				mb1.find(".membersSize").html(departInfos[i].membersSize + "人");
	        				
	        				mb1.find(".subDepartSize").html(departInfos[i].subDepartSize + "个");
	        				if(departInfos[i].subDepartSize == 0){
	        					mb1.find(".subDepartSize:eq(0)").remove();
	        				}else{
	        					mb1.find(".subDepartSize:eq(0)").attr("onclick","viewDepartOrPoint('"+departInfos[i].depart.id+"','2')");
	        					mb1.find(".subDepartSize:eq(1)").remove();
	        				}
	        				
	        				$(".cs-point-list").append(mb1.html());
	        			}
	        		}
	        		
	        		
	        	}
			}
	    });
	}
	
	
  	//查看直管检测点
    function viewPoint(id){
    	showMbIframe("${webRoot}/detect/basePoint/list.do?returnBtn=Y&id="+id);
    }
    //查看成员
    function viewMember(id){
    	showMbIframe("${webRoot}/data/pointUser/list.do?departId="+id);
    }
    </script>
  </body>
</html>
