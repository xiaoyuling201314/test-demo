<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 选择食品种类 - 窗口 -->
<style type="text/css">
	.select2-container--default .select2-results>.select2-results__options{
	padding-bottom: 30px;
}
</style>
<div class="modal fade" id="myFootTypeModal"   role="dialog" aria-labelledby="myModalLabel" data-backdrop="static">
	<div class="modal-dialog cs-mid-width" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title">选择食品种类</h4>
			</div>
			<div class="modal-body cs-mid-height">
				<select id="foodSelect2" class="js-example-basic-single" name="state" style="width:100%;">
					<option value="">--请选择食品种类--</option>
				</select>
				<ul id="myFootTypeTree" class="easyui-tree"></ul>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-success" onclick="footConfirm();">确定</button>
				<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
			</div>
		</div>
	</div>
</div>
<!-- JavaScript -->

<script type="text/javascript">
	/*
	$(document).ready(function() { 
		$('#foodSelect2').select2();
		
		$('#myFootTypeModal').on('show.bs.modal', function () {
			$("#foodSelect2").val("").select2();  
		});
		/!* $(document).on('click','.dSample', function () {
		$("#foodSelect2").val("").select2();  
	}); *!/
	});
	*/
	var footNodeId = "";
	var footNodeText = "";

	$(function() {
		initFoodSelect2();

        $('#myFootTypeModal').on('show.bs.modal', function () {
            initFoodSelect2();
        });

		//食品种类树
		$('#myFootTypeTree').tree({
			checkbox : false,
			url : "${webRoot}/data/foodType/queryFoodTree.do?topNode=hide",
			animate : true,
			onClick : function(node) {
				footNodeId = node.id;
				footNodeText = node.text;
				//selFoot(node.id, node.text);
			},
			loadFilter : function(data, parent) {
				var state = $.data(this, 'tree');
				function setData() {
					var serno = 1;
					var todo = [];
					for (var i = 0; i < data.length; i++) {
						todo.push(data[i]);
					}
					while (todo.length) {
						var node = todo.shift();
						if (node.id == undefined) {
							node.id = '_node_' + (serno++);
						}
						if (node.children) {
							node.state = 'closed';
							node.children1 = node.children;
							node.children = undefined;
							todo = todo.concat(node.children1);
						}
					}
					state.tdata = data;
				}
				function find(id) {
					var data = state.tdata;
					var cc = [ data ];
					while (cc.length) {
						var c = cc.shift();
						for (var i = 0; i < c.length; i++) {
							var node = c[i];
							if (node.id == id) {
								return node;
							} else if (node.children1) {
								cc.push(node.children1);
							}
						}
					}
					return null;
				}

				setData();

				var t = $(this);
				var opts = t.tree('options');
				opts.onBeforeExpand = function(node) {
					var n = find(node.id);
					if (n && n.children && n.children.length) {
						return;
					}
					if (n && n.children1) {
						var filter = opts.loadFilter;
						opts.loadFilter = function(data) {
							return data;
						};
						t.tree('append', {
							parent : node.target,
							data : n.children1
						});
						opts.loadFilter = filter;
						n.children = n.children1;
					}
				};
				return data;
			}
		});
		
		//检索输入框
		/*
		$.ajax({
	        type: "POST",
	        url: "${webRoot}/data/foodType/queryAll.do",
	        dataType: "json",
	        success: function(data){
	        	
	        	if(data && data.success){
	        		for(var i=0;i<data.obj.length;i++){
	        			var otherName=data.obj[i].foodNameOther;
	        			var foodNameEn=data.obj[i].foodNameEn;
	        			var foodType=data.obj[i].isFood;
	        			if(foodType==0){
	        				foodType='类别';
	        			}else{
	        				foodType='食品';
	        			}
	        			
	        			if(!otherName&&!foodNameEn){
	        			$("#foodSelect2").append("<option value='"+data.obj[i].id+"'>["+foodType+']&nbsp'+data.obj[i].foodName+"</option>");
	        			}else if(otherName&&!foodNameEn){
	        			$("#foodSelect2").append("<option value='"+data.obj[i].id+"'>["+foodType+']&nbsp'+data.obj[i].foodName+'('+otherName+")</option>");
	        			}else{
	        			$("#foodSelect2").append("<option value='"+data.obj[i].id+"'>["+foodType+']&nbsp'+data.obj[i].foodName+'('+foodNameEn+'、'+otherName+")</option>");
	        			}
	        		}
	        	}
			}
	    });
		*/
		
		// //确认检索结果
		// $(document).on("change","#foodSelect2",function(){
		// 	var options=$('#foodSelect2 option:selected'); //获取选中的项
		//
		// 	if(options.val() && options.text()){	//确认
		// 		footNodeId = options.val();
		// 		footNodeText = options.text();
		// 		footNodeText=footNodeText.substring(5,footNodeText.length);
		// 		if(footNodeText.indexOf("(")>0){//判断是否有别名
		// 			footNodeText=footNodeText.substring(0,footNodeText.indexOf("("));
		// 		}
		//
		// 		footConfirm();
		// 	}
		// });
		
		//打开modal前，清空检索输入框
		/* 
		$('#myFootTypeModal').on('show.bs.modal', function () {
			$("#selectNull").val("").select2();  
		});
		 */

        $("#foodSelect2").on("select2:select",function(e){
            footNodeId = e.params.data.id;
            footNodeText = e.params.data.name;
            if(footNodeText.indexOf("(")>0){//判断是否有别名
                footNodeText=footNodeText.substring(0,footNodeText.indexOf("("));
            }
            footConfirm();
        });
	});
	
	//确认
	function footConfirm(){
		selFoot(footNodeId, footNodeText);
	}
	$('#myFootTypeModal').on('hide.bs.modal', function () {
		$('.js-example-basic-single').select2({
			closeOnSelect: true
		});
	});

	/////////////////////////////////////////////////////////////////////////////////////////////////// -Dz 2020/09/27
	function initFoodSelect2(){
		$("#foodSelect2").select2({
			placeholder: '--请选择--',
			language: {
				errorLoading: function() {
					return "无法载入结果";
				},
				inputTooLong: function(e) {
					var t = e.input.length - e.maximum,
							n = "请删除" + t + "个字符";
					return n;
				},
				inputTooShort: function(e) {
					var t = e.minimum - e.input.length,
							n = "请输入至少" + t + "个字符";
					return n;
				},
				loadingMore: function() {
					return "载入更多结果…";
				},
				maximumSelected: function(e) {
					var t = "最多只能选择" + e.maximum + "个项目";
					return t;
				},
				searching: function() {
					return "搜索中...";
				},
				noResults: function() {
					return "没有搜索到结果!";
				}
			},
			width: "100%",
			ajax: {
				url: "${webRoot}/data/foodType/select2FoodData",
				dataType: 'json',
				delay: 250,
				data: function(params) {//发送到服务器的数据
					//params.term 是输入框中内容。
					//此对象的key就是发送到服务器的参数名。
					//所以这里你可以添加自定义参数，如：page: params.page
					params.page = params.page || 1; // 这个page会记录下来，且向下滚动翻页时会自增
					return {
						foodName: params.term, //后端取 key 它就是搜索关键字
						page: params.page || 1, //分页：当前页码
						row: 50	//每页数量
					};
				},
				processResults: function(data, params) {// 后端返数据的根是 data，params就是上面的查寻参数
					return {
						results: data.foods,
						pagination: { //分页
							//more: data.more // 是否还有后面页：true|false
							more: (params.page * 50) < data.total // 后端返回总数量 total 算出还有没
						}
					};
				},
				cache: true
			},
			minimumInputLength: 1,// 输入几个字时开始搜索
			templateResult: formatRepo,// 定制搜索结果列表的外面
			// templateResult 返回的数据要从 escapeMarkup 过，默认会被转成text，要想返回html如下覆写
			escapeMarkup: function(markup) {
				return markup;
			},
			templateSelection: formatRepoSelection // 定制所选结果的外观
		});
	}

	/**
	 * 搜索结果返回，列表中每个结果都调用此方法。repo 参数对应后端的一个 jsonObject。
	 * 此函数可以返回一个html元素字符串，或者一个对象(例如jQuery对象)，其中包含要显示的数据。
	 * 还可以返回null，这将阻止在结果列表中显示该选项(可以实现过滤某些值)
	 */
	function formatRepo(repo) {
		if (repo.loading) return repo.text;//如果loading中，直接返回提示信息
		var markup = "<div class='select2-result-repository clearfix'>" +
				"<div class='select2-result-repository__title'>" + repo.name + "</div>" +
				"</div>";
		return markup;
	}
	/**
	 * 将选择数据对象转换为字符串表示或jQuery对象（可以显示带图片的结果那种）
	 */
	function formatRepoSelection(repo) {
		return repo.name?repo.name:repo.text;//如果没有name返回提示信息
	}

	/**
	 * 获取已选数据数组
	 */
	function getFoodSelect2Data() {
		return $('#foodSelect2').select2('data');
	}
</script>
