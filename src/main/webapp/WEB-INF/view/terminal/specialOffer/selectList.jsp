<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!-- 选择检测点 -->
<div class="modal fade intro2" id="myUserModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog cs-xlg-width" role="document">
        <div class="modal-content" style="margin-top: 0px;">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
                <h4 class="modal-title">配置检测项目</h4>
            </div>
            <div class="modal-body cs-xlg-height">
                <!-- 主题内容 -->
                <div class="cs-mechanism-list" style=" width: 150px;">
                    <div class="cs-mechanism-list-title cs-font-weight">检测项目类型列表</div>
                    <div class="cs-mechanism-list-content">
                        <ul  class="type-tree"  id="typeList">
                        <li onclick="getType(this,0);">查看全部</li>
                         <c:forEach items="${itemList}" var="itemType">
                        <li onclick="getType(this,${itemType.id });">${itemType.itemName}</li>
				           </c:forEach>
						</ul>
                    </div>
                </div>

                <div class="cs-points-list cs-points-list2" style="width: 57%;">
                    
                    <div class="cs-mechanism-list-content cs-mechanism-list-content2" style="padding:0;height:418px;">
                        <div class="cs-mechanism-list-search clearfix">
                            <!-- <div class="cs-selcet cs-fl" style="padding: 9px 0 0 0;">
                              <input class="cs-fl" id="subset" type="checkbox" /><label class="cs-fl" for="subset" style="margin-left:4px; color:#666;">包含下级</label>
                            </div> -->
                            <div class="cs-fr">
                                <div class="cs-search-margin clearfix cs-fl">
                                    <input class="cs-input-cont cs-fl" type="text" placeholder="请输入检测项目" id="searchItemName" >
                                    <input type="submit" class="cs-search-btn cs-fl" href="javascript:;" value="搜索" onclick="searchItem();">
                                </div>
                            </div>
                        </div>
                        <div class="cs-mechanism-table-box cs-mechanism-table-box2" style="    height: 376px;">
                            <table class="cs-mechanism-table" width="100%" style="table-layout:;fixed">
                                 <tr> <th style="width:40px;"><input type="checkbox" id="itemCheck"/></th> <th style="width:200px;">检测项目</th><th style="width:150px;">类型</th> <th  style="width:100px;">价格(元)</th></tr>
                                 <tbody id="itemList" ></tbody>
                            </table>
                        </div>
                    </div>
                </div>


                <div class="cs-secleted-list" style="width:210px;">
                    <div class="cs-mechanism-list-title">
                        <span class="cs-fl cs-font-weight">已选择项目：</span>
                        <span class="cs-title-tip text-muted"><span class="checkedNumber">0</span>个</span>
                        <a class="cs-fr cs-secleted-del" href="javascript:" onclick="deleteAll();"><i class="text-del">全部删除</i></a>
                    </div>
                    <div class="cs-mechanism-list-content"     style="height:390px;;" >
                        <table class="cs-mechanism-table" width="100%" id="checkedList">
                        </table>
                    </div>
                </div>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-success" onclick="workerConfirm();">确定</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
            </div>
        </div>
    </div>
</div>

 

<!-- 提示框 -->
<div class="modal fade intro2" id="myTipsModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog cs-alert-width">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">提示</h4>
            </div>
            <div class="modal-body cs-alert-height cs-dis-tab">
                <div class="cs-text-algin" id="waringMsg">
                    <img src="${webRoot}/img/warn.png" width="40px" alt=""/>
                    <span class="tips">操作失败</span>
                </div>
            </div>
            <div class="modal-footer">
                <a class="btn btn-primary btn-ok" data-dismiss="modal">关闭</a>
            </div>
        </div>
    </div>
</div>
<!-- JavaScript -->
<script type="text/javascript">
    var lock = true;
    var itemArray = [];
    var itemList=[];
    //打开模态框事件
    $('#myUserModal').on('show.bs.modal', function () {
    	itemArray = [];
    	 $(".checkedNumber").text(itemArray.length);
    	 dealHtml();
  	 	$("#itemCheck").prop("checked", false);
      
    });

    //进入页面打开模态框拼接界面功能
    function dealHtml() {
    	$("#typeList").children(":first").addClass('action');
    	$("#typeList").children(":first").siblings().removeClass('action');
    	var html=' ';
    	$("#itemList").empty();
    	$("#checkedList").empty();
   	 for (var i = 0; i <itemList.length; i++) { 
   		 var id=itemList[i].id;
   		 var name=itemList[i].detectItemName;
   		 var price=itemList[i].price;
   		 var remark=itemList[i].remark;
   		 var itemType=itemList[i].detectItemTypeid;
   		 html+='<tr> <th ><input type="checkbox" value="'+id+'" data-itemName="'+name+'" data-price="'+price+'"   data-typename="'+remark+'"  data-typeid="'+itemType+'"/><span>'+(i+1)+'</span></th>  <th>'+name+'</th><th>'+remark+'</th> <th >'+price+'</th>  </tr>';
 	  	 }
   	$("#itemList").append(html);
	}
    
  	//获取检测项目列表
    function getItemlist() {
  		var timeStart=$("#start").val();
  		if(timeStart==null||timeStart==""){
  			alert("请先选择开始时间!")
  			return;
  		}
  		var timeEnd=$("#end").val();
  		if(timeEnd==null||timeEnd==""){
  			alert("请先选择结束时间!")
  			return;
  		}
    	   $.ajax({
    		   async: false,
              type: "POST",
              url: '${webRoot}' + "/specialOffer/getItemList.do?offerId="+id,
              data: {
            	  timeStart:timeStart,
            	  timeEnd:timeEnd
              },
              dataType: "json",
              success: function (data) {
                  if (data && data.success) {
                	  itemList=data.obj;
                	
            	  }
              }
          }); 
		
	}
    

    //全选
    $(document).on("change", "#itemCheck", function () {
        if ($(this).is(':checked')) {
            $("#itemList input[type='checkbox']").prop("checked", true);
            $("#itemList input[type='checkbox']").each(function () {
                addByValue($(this).val(), $(this).attr("data-itemName"), $(this).attr("data-price"), $(this).attr("data-typename"), $(this).attr("data-typeid"));
            });
        } else {
            $("#itemList input[type='checkbox']").prop("checked", false);
            $("#itemList input[type='checkbox']").each(function () {
                removeByValue($(this).val());
            });
        }
        loadCheckedPoints();
    });

    //获取已选择检测点
    $(document).on("change", "#itemList input[type='checkbox']", function () {
        var allPoints = $("#itemList input[type='checkbox']").length;	//所有检测点数量
        var checkedList = $("#itemList input[type='checkbox']:checked").length;	//已选择检测点数量
        //控制全选
        if (allPoints == 0 ||checkedList==0|| allPoints > checkedList) {
            $("#itemCheck").prop("checked", false);
        } else {
            $("#itemCheck").prop("checked", true);
        }
	
        //添加/删除检测点数组元素
        if ($(this).is(':checked')) {
        	   addByValue($(this).val(), $(this).attr("data-itemName"), $(this).attr("data-price"), $(this).attr("data-typename"), $(this).attr("data-typeid"));
        } else {
            removeByValue($(this).val());
        }
        loadCheckedPoints();
    });

    //加载检测点数组数据
    function loadCheckedPoints() {
        $("#checkedList tr").remove();
        for (var i = 0; i < itemArray.length; i++) {
            var html = "<tr><td style=\"width:86%;\">" + itemArray[i]["name"] + "</td><td><a href=\"javascript:;\" onclick=\"deleteOne('" + itemArray[i]["id"] + "')\">"
                + "<span class=\"cs-icon-span\"><i class=\"icon iconfont icon-shanchu text-del\"></i></span></a></td></tr>";
            $("#checkedList").append(html);
        }
        $(".checkedNumber").text(itemArray.length);
        if(itemArray.length==0){
        	  $("#itemCheck").prop("checked", false);
        }
    }

    //添加检测点数组元素
    function addByValue(id, name,price,typename,typeid) {
        if (itemArray.length > 0) {
            for (var i = 0; i < itemArray.length; i++) {
                if (itemArray[i]["id"] == id) {
                    //检测点ID已存在，不再添加
                    break;
                } else if (i == itemArray.length - 1) {
                    itemArray.push({"id": id, "name": name, "price": price, "typename": typename, "typeid": typeid});
                }
            }
        } else {
        	   itemArray.push({"id": id, "name": name, "price": price, "typename": typename, "typeid": typeid});
        }
    }

    //删除检测点数组元素
    function removeByValue(deletePointId) {
        for (var i = 0; i < itemArray.length; i++) {
            if (itemArray[i]["id"] == deletePointId) {
                itemArray.splice(i, 1);
                break;
            }
        }
    }

    //删除已选择检测点-删除图标
    function deleteOne(deletePointId) {
        removeByValue(deletePointId);
        loadCheckedPoints();
        //取消全选
        $("#itemCheck").prop("checked", false);
        //取消复选框选中
        $("#itemList input[type='checkbox']").each(function () {
            if ($(this).val() == deletePointId) {
                $(this).prop("checked", false);
            }
        });
    }

    //删除已选择检测点-全部删除
    function deleteAll() {
        itemArray.splice(0, itemArray.length);
        loadCheckedPoints();
        $("#itemList input[type='checkbox']").prop("checked", false);
    }

	//搜索拼接界面功能
	function searchItem() {
    	var key=$("#searchItemName").val();
        let num = 0;
    	if(key!=null&&key!=""){//关键字不为空
    		$("#itemList").empty();
           		 var html="";
    		 for (var i = 0; i <itemList.length; i++){
           		 var name=itemList[i].detectItemName;
           		 var price=itemList[i].price;
           		 var remark=itemList[i].remark;
           		 var itemType=itemList[i].detectItemTypeid;
    	    		 if(name.indexOf(key) != -1){
                         num++;
    	    		 var id=itemList[i].id;
    	       		 html+='<tr> <th ><input type="checkbox" value="'+id+'" data-itemName="'+name+'" data-price="'+price+'"  data-typename="'+remark+'"  data-typeid="'+itemType+'"/><span>'+num+'</span></th>  <th>'+name+'</th> <th>'+remark+'</th><th  >'+price+'</th>  </tr>';
    	    		 }
         	  	 }
    	    	$("#itemList").append(html);
    	}else{
    		$("#itemList").empty();
    		 for (var i = 0; i <itemList.length; i++){
           		 var name=itemList[i].detectItemName;
           		 var price=itemList[i].price;
    	    		 var id=itemList[i].id;
    	    		 var remark=itemList[i].remark;
    	     		 var itemType=itemList[i].detectItemTypeid;
    	       		 html+='<tr> <th ><input type="checkbox" value="'+id+'" data-itemName="'+name+'" data-price="'+price+'"   data-typename="'+remark+'"  data-typeid="'+itemType+'"/><span>'+(i+1)+'</span></th>  <th>'+name+'</th><th>'+remark+'</th> <th  >'+price+'</th>  </tr>';
         	  	 }
    	    	$("#itemList").append(html);
    	}
    	
   
	}
	//绑定回车事件,避免搜索检测项目时回车返回json字符串 add by xiaoyl 2019-10-11
	 $('#searchItemName').bind('keydown',function(event){
        if(event.keyCode == "13")    
        {
        	searchItem();
        }
        event.stopPropagation()
	 }); 
	
	/* function getItemList() {
		var html='<li> <span onclick="getItemList();">类型1</span> </li>';
	    $("#typeList").html(html);
		
	} */

    //点击检测项目类型拼接界面功能
	function getType(obj,typeid) {
		$(obj).addClass('action');
		$(obj).siblings().removeClass('action');
		$("#itemList").empty();
		 var html="";
		 let num = 0;
		 for (var i = 0; i <itemList.length; i++){
       		 var name=itemList[i].detectItemName;
       		 var price=itemList[i].price;
	    		 var id=itemList[i].id;
	    		 var itemType=itemList[i].detectItemTypeid;
	    		 var remark=itemList[i].remark;
	    		 if(typeid==0||itemType==typeid){
                     num++;
	       		 html+='<tr> <th ><input type="checkbox" value="'+id+'" data-itemName="'+name+'" data-price="'+price+'"   data-typename="'+remark+'"  data-typeid="'+itemType+'"/><span>'+num+'</span></th>  <th>'+name+'</th><th>'+remark+'</th> <th >'+price+'</th>  </tr>';
	    		 }
     	  	 }
	    	$("#itemList").append(html); 
   	}
   	
		
	
	
</script>