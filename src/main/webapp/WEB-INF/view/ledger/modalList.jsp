<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link rel="stylesheet" href="${webRoot}/css/baguetteBox.min.css">
<script type="text/javascript" src="${webRoot}/js/baguetteBox.min.js"></script>
<style type="text/css">
	.ul-market-list {
	    height: 28px;
	    white-space: nowrap;
	    cursor: pointer;
	    line-height: 28px;
	    padding-top: 6px;
	    /* padding-left: 20px; */
	}
	.ul-market-list li{
		padding-left:10px;
	}
	.ul-market-list li.active{
		background: #f1f1f1;
    	color: #333;
	}
	.ul-market-list li:hover{    
		background: #ddd;
	    color: #1dcc6a;
	}
	.cs-search-title{
		font-weight: bold;
	    padding: 10px 0 5px 0px;
	    border-bottom: 1px dotted #ddd;
	}
	#opeNameInput{
    display: block;
    padding-left: 8px;
    padding-right: 20px;
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
    color: #444;
    line-height: 28px;
    width: 100%;
    border-radius: 3px
}
</style>


<div class="modal fade" id="ModalList"   role="dialog" aria-labelledby="myModalLabel" data-backdrop="static">
	<div class="modal-dialog cs-mid-width" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title">选择市场</h4>
			</div>
			<div class="modal-body cs-mid-height">
				<select id="ObjList" class="js-example-basic-single" name="state" style="width:100%;">
				<option value="">--请选择市场--</option>
				</select>
				<h5 class="cs-search-title">历史记录</h5>
				<ul id="historyList" class="ul-market-list">
				</ul>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-success" onclick="innerht()">确定</button>
				<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
			</div>
		</div>
	</div>
</div>

<!-- 档口弹出框 -->
<div class="modal fade" id="opeListModal"   role="dialog" aria-labelledby="myModalLabel" data-backdrop="static">
	<div class="modal-dialog cs-mid-width" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title">选择档口</h4>
			</div>
			<div class="modal-body cs-mid-height">
					<input type="text" id="opeNameInput" placeholder="请输入档口" >
				<h5 class="cs-search-title">历史记录</h5>
				<ul id="opehistoryList" class="ul-market-list">
				</ul>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-success" onclick="opeSave()">确定</button>
				<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">


		$(document).on('click','.ul-market-list li',function(){
			$(this).addClass('active').siblings().removeClass('active');
		});
		
		$('#ObjList').select2();
		$('#ObjList').on('show.bs.modal', function () {
			$("#ObjList").val("").select2();  
		});
		/* $(document).on('click','.dSample', function () {
		$("#foodSelect2").val("").select2();  
	}); */
	$('#ObjList').on('show.bs.modal', function () {
		$("#selectNull").val("").select2();  
	});
</script>
<script type="text/javascript">
//确认档口检索结果

		$(document).on('click','#opehistoryList li',function(){
			$(this).addClass('active').siblings().removeClass('active');
			$('#opeNameInput').val($('#opehistoryList li.active').html());
		});
		
		$('#opeList').select2();
		$('#opeList').on('show.bs.modal', function () {
			$("#opeList").val("").select2();  
		});
		/* $(document).on('click','.dSample', function () {
		$("#foodSelect2").val("").select2();  
	}); */
	$('#opeList').on('show.bs.modal', function () {
		$("#selectNull").val("").select2();  
	});
	$(function() {//手动输入时取消选中
		$("#opeNameInput").bind('input porpertychange',function() {
			$('#opehistoryList li.active').removeClass('active');
				});
		});
</script>

