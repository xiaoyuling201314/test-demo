<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/common/resource.jsp"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<!-- <meta name="viewport" content="width=device-width, initial-scale=1.0"> -->
<meta name="description" content="">
<meta name="author" content="食安科技">
<meta http-equiv="X-UA-Compatible" content="IE=Edge">

<title>快检服务云平台</title>
<!-- <link rel="stylesheet" type="text/css" href="../../public/css/gobal.css" /> -->
<link rel="stylesheet" type="text/css" href="../../public/css/base.css" />
<link rel="stylesheet" type="text/css" href="../../public/css/index.css" />
<link rel="stylesheet" type="text/css" href="../../public/css/misson.css" />
<script type="text/javascript">
	(function() {
		var _skin, _lhgcore;
		var _search = window.location.search;
		if (_search) {
			_skin = _search.split('demoSkin=')[1];
		}


		document.write('<scr' + 'ipt src="../../public/lhgdialog/lhgdialog.min.js?skin=' + (_skin || 'default')
				+ '"></sc'+'ript>');
		window._isDemoSkin = !!_skin;
	})();
</script>

</head>

<body>
	<div class="cs-maintab">
		<div class="cs-lcon">

			<!-- <ul class="cs-tabtitle">
      <li class="cs-tabhover"><a href="#">基本信息</a></li>
       <li class="cs-taba"><a href="#">证照信息</a></li>
       <li class="cs-taba"><a href="#">选择标题3</a></li>
       <li class="cs-taba"><a href="#">选择标题4</a></li>
       <li class="cs-taba"><a href="#">选择标题5</a></li>
    </ul> -->
		</div>
		<div class="cs-col-lg clearfix">
			<!-- 面包屑导航栏  开始-->
			<ol class="cs-breadcrumb">
				<li class="cs-fl"><img src="../../public/img/set.png" alt=""> <a href="javascript:">项目管理</a></li>
				<li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
				<li class="cs-fl">监管对象</li>
				<li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
				<li class="cs-fl">生产企业
				<li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
				<li class="cs-b-active cs-fl">生产企业详情</li>
			</ol>
			<!-- 面包屑导航栏  结束-->
			<div class="cs-search-box cs-fr">
				<form action="">

					<!-- <div class="cs-search-filter clearfix cs-fl">
						<input class="cs-input-cont cs-fl" type="text" placeholder="请输入内容"> <input type="submit" class="cs-search-btn cs-fl" href="javascript:;" value="搜索">
					</div> -->
					<div class="cs-fr cs-ac ">
						<a href="../supervision-object.html" class="cs-menu-btn"><i class="icon iconfont icon-fanhui"></i>返回</a>
						<a href="javascript:" class="cs-menu-btn" id="pointSave"><i class="icon iconfont icon-save"></i>保存</a>
					</div>
				</form>

			</div>
		</div>


		<form id="regForm">
		<input name="regType" type="hidden" value=''>
			<div class="cs-base-detail">
				<div class="cs-content2">
					<h3>基本信息</h3>
					<table class="cs-add-new">
						<tr>
							<td class="cs-name">企业名称：</td>
							<td class="cs-in-style">
							<input name="regul.regName" type="text" value=""maxlength="25" datatype="*" nullmsg="请输入任务标题" errormsg="请输入任务标题"/>
							</td>
							<td class="cs-name">组织结构代码：</td>
							<td class="cs-in-style">
							<input type="text"   name="regul.departid" value="" maxlength="25" datatype="*" nullmsg="请输入任务标题" errormsg="请输入任务标题"/>
							</td>
							<td class="cs-name">企业类型：</td>
							<td class="cs-in-style"><select name="regul.regNature" id="">
									<option value="食品加工">食品加工</option>
									<option value="食品">食品</option>
									<option value="生产基地">生产基地</option>
							</select></td>
						</tr>
						<tr>

							<td class="cs-name">所属机构：</td>
							<td class="cs-in-style">
	<input type="text"   name="regul.departId" value="" maxlength="25" datatype="*" nullmsg="请输入任务标题" errormsg="请输入任务标题"/>
</td>
							<td class="cs-name">联系人：</td>
							<td class="cs-in-style">
						<input type="text"   name="regul.linkUser" value="" maxlength="25" datatype="*" nullmsg="请输入任务标题" errormsg="请输入任务标题"/>
							</td>
							<td class="cs-name">联系电话：</td>
							<td class="cs-in-style">
							<input type="text"   name="regul.linkPhone" value="" maxlength="25" datatype="*" nullmsg="请输入任务标题" errormsg="请输入任务标题"/>
							</td>
						</tr>

						<tr>
							<td class="cs-name">微信：</td>
							<td class="cs-in-style"><input type="text" value="" /></td>
							<td class="cs-name">邮箱：</td>
							<td class="cs-in-style"><input type="text" /></td>
							<td class="cs-name">传真：</td>
							<td class="cs-in-style"><input type="text" value="" /></td>
						</tr>
						<tr>





							<td class="cs-name">经度纬度：</td>
							<td class="cs-in-style">
								<div class="cs-all-ps">
									<div class="cs-input-box">
										<input type="text" id="txtHandle">
										<div class="cs-map" id="content_frm3">
											<span class="cs-icon-span"><i title="定位" class="icon iconfont icon-local"></i></span>
										</div>
									</div>
								</div>
							</td>

							<td class="cs-name">状态：</td>
							<td class="cs-in-style cs-radio"><input id="cs-check-radio" type="radio" value="1" name="check" /><label for="cs-check-radio">已审核</label> <input id="cs-check-radio2" type="radio" value="1" name="check" /><label for="cs-check-radio2">未审核</label></td>
						</tr>
					</table>
				</div>
			</div>
		</form>

		<div class="cs-tabtitle clearfix">
			<ul>
				<li class="cs-tabhover">证照信息</li>
				<li>人员信息</li>
			</ul>
		</div>
		<div class="cs-tabcontent clearfix" style="">
			<div class="cs-content2">


				<!-- 弹出 -->
				<div class="cs-licence" style="display: none;">
					<table class="cs-add-new">
						<tr>
							<td class="cs-name">企业名称：</td>
							<td class="cs-in-style"><input type="text" value="" /></td>
							<td class="cs-name">营业执照号：</td>
							<td class="cs-in-style"><input type="text" value="" /></td>
						</tr>
						<tr>
							<td class="cs-name">企业类型：</td>
							<td class="cs-in-style"><select name="" id="">
									<option value="food">食品加工</option>
									<option value="1">食品</option>
									<option value="1">生产基地</option>
							</select></td>
							<td class="cs-name">法定代表人：</td>
							<td class="cs-in-style"><input type="text" value="" /></td>
						</tr>
						<tr>
							<td class="cs-name">法定代表人住所：</td>
							<td class="cs-in-style"><input type="text" value="" /></td>
							<td class="cs-name">法定代表人身份证：</td>
							<td class="cs-in-style"><input type="text" value="" /></td>
						</tr>
						<tr>
							<td class="cs-name">注册资本(万)：</td>
							<td class="cs-in-style"><input type="text" value="" /></td>
							<td class="cs-name">注册日期：</td>
							<td class="cs-in-style"><input type="text" /></td>
						</tr>
						<tr>
							<td class="cs-name">有效期始：</td>
							<td class="cs-in-style"><input type="text" value="" /></td>
							<td class="cs-name">有效期终：</td>
							<td class="cs-in-style"><input type="text" value="" /></td>
						</tr>
						<tr>
							<td class="cs-name">经营范围：</td>
							<td class="cs-in-style"><input type="text" value="" /></td>
							<td class="cs-name">处理类型：</td>
							<td class="cs-in-style"><select name="" id="">
									<option value="food">年审</option>
									<option value="1">更换</option>
							</select></td>
						</tr>
						<tr>
							<td class="cs-name">处理人：</td>
							<td class="cs-in-style"><input type="text" value="" /></td>
							<td class="cs-name">处理时间：</td>
							<td class="cs-in-style"><input type="text" value="" /></td>
						</tr>
						<tr>
							<td class="cs-name">文件上传：</td>
							<td class="cs-in-style" colspan=""><input type="file" /></td>
							<td></td>
							<td></td>
						</tr>
					</table>
				</div>




				<table class="cs-table cs-table-hover table-striped cs-tablesorter">
					<thead>
						<tr>
							<th><input type="checkbox" /></th>
							<th class="cs-header">序号</th>
							<th class="cs-header">证照类型</th>
							<th class="cs-header">企业名称</th>
							<th class="cs-header">企业类型</th>
							<th class="cs-header">证照号码</th>
							<th class="cs-header">有效期至</th>
							<th class="cs-header">所属机构</th>
							<th class="cs-header">状态</th>
							<th class="cs-header">操作</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td><input type="checkbox" /></td>
							<td>1</td>
							<td>营业执照</td>
							<td>德庄实业集团食品生产基地</td>
							<td>生产基地</td>
							<td>SC123323323</td>
							<td>2021-02-10</td>
							<td>南岸区分局</td>
							<td>已审核</td>
							<td><a class="cs-rewrite" href="javascript:;"><img src="../../public/img/change.png" alt="" /></a> <a class="cs-del" href="javascript:"><img src="../../public/img/del_red.png" alt="" /></a></td>
						</tr>
						<tr>
							<td><input type="checkbox" /></td>
							<td>2</td>
							<td>许可证</td>
							<td>德庄实业集团食品生产基地</td>
							<td>生产基地</td>
							<td>SC123323323</td>
							<td>2021-02-10</td>
							<td>南岸区分局</td>
							<td>已审核</td>
							<td><a class="cs-rewrite" href="javascript:;"><img src="../../public/img/change.png" alt="" /></a> <a class="cs-del" href="javascript:"><img src="../../public/img/del_red.png" alt="" /></a></td>
						</tr>
					</tbody>
				</table>


			</div>
			<!-- 工具栏 -->
			<div class="cs-tools clearfix">

				<div class="cs-menu-btn cs-fl cs-ac">
					<a class="cs-add-btn runcode" href="javascript:" name="content_frm2">新增</a>
				</div>

				<div class="cs-menu-btn cs-fl cs-ac ">
					<a class="cs-delet" href="javascript:">删除</a>
				</div>
				<div class="cs-menu-btn cs-fl cs-ac cs-distan">
					<a class="cs-export" href="javascript:">导出</a>
				</div>
				<ul class="cs-pagination cs-fr">
					<li class="cs-distan">共5页/48条记录</li>
					<li class="cs-b-nav-btn cs-distan cs-selcet"><select name="page" id="">
							<option value="page">10行/页</option>
							<option value="page">20行/页</option>
							<option value="page">30行/页</option>
					</select></li>
					<li class="cs-disabled cs-distan"><a class="cs-b-nav-btn" href="#">«</a></li>
					<li><a class="cs-b-nav-btn cs-n-active" href="#">1</a></li>
					<li><a class="cs-b-nav-btn" href="#">2</a></li>
					<li><a class="cs-b-nav-btn" href="#">3</a></li>
					<li><a class="cs-b-nav-btn" href="#">4</a></li>
					<li><a class="cs-b-nav-btn" href="#">5</a></li>
					<li class="cs-next "><a class="cs-b-nav-btn" href="#">»</a></li>
					<li class="cs-skip cs-distan">跳转<input type="text">页
					</li>
					<li><a class="cs-b-nav-btn cs-enter cs-distan" href="javascript:">确定</a></li>
				</ul>
			</div>
			<!-- 工具栏 -->
		</div>

		<!-- 弹出2 -->
		<div class="cs-licence2" style="display: none;">
			<table class="cs-add-new">
				<tr>
					<td class="cs-name">企业名称：</td>
					<td class="cs-in-style"><input type="text" value="" /></td>
					<td class="cs-name">许可证号：</td>
					<td class="cs-in-style"><input type="text" value="" /></td>
				</tr>
				<tr>
					<td class="cs-name">证照类型：</td>
					<td class="cs-in-style"><select name="" id="">
							<option value="food">食品经营许可证</option>
							<option value="1">食品生产许可证</option>
					</select></td>
					<td class="cs-name">法定代表人：</td>
					<td class="cs-in-style"><input type="text" value="" /></td>
				</tr>
				<tr>
					<td class="cs-name">企业负责人：</td>
					<td class="cs-in-style"><input type="text" value="" /></td>
					<td class="cs-name">注册地址：</td>
					<td class="cs-in-style"><input type="text" value="" /></td>
				</tr>
				<tr>
					<td class="cs-name">有效期始：</td>
					<td class="cs-in-style"><input type="text" value="" /></td>
					<td class="cs-name">有效期终：</td>
					<td class="cs-in-style"><input type="text" /></td>
				</tr>
				<tr>
					<td class="cs-name">发照机关：</td>
					<td class="cs-in-style"><input type="text" value="" /></td>
					<td class="cs-name">证照年审日期：</td>
					<td class="cs-in-style"><input type="text" value="" /></td>
				</tr>
				<tr>
					<td class="cs-name">更换人员：</td>
					<td class="cs-in-style"><input type="text" value="" /></td>
					<td class="cs-name">更换时间：</td>
					<td class="cs-in-style"><input type="text" /></td>
				</tr>
				<tr>
					<td class="cs-name">文件上传：</td>
					<td class="cs-in-style" colspan=""><input type="file" /></td>
					<td></td>
					<td></td>
				</tr>
			</table>
		</div>



		<div class="cs-tabcontent clearfix cs-hide" style="">
			<div class="cs-content2">

				<!-- <table class="cs-add-new3">
      <tr>
        <td class="cs-name">
          姓名：
        </td>
        <td class="cs-in-style">
          <input type="text" value="" />
        </td>
        <td class="cs-name">职称：</td>
        <td class="cs-in-style">
          <input type="text" value="" />
        </td>
        </tr>
        <tr>
        <td class="cs-name">证件号码：</td>
        <td class="cs-in-style"><input type="text" value="" /></td>
        <td class="cs-name">电子邮件：</td>
         <td class="cs-in-style"><input type="text" value="" /> </td>
      </tr>
      <tr> 
         <td class="cs-name">手机号码：</td>
        <td class="cs-in-style"><input type="text" value="" /></td>
        <td class="cs-name">办公电话：</td>
        <td class="cs-in-style"><input type="text" value="" /></td>
      </tr>
    </table> -->
				<table class="cs-table cs-table-hover table-striped cs-tablesorter">
					<thead>
						<tr>
							<th><input type="checkbox" /></th>
							<th class="cs-header">序号</th>
							<th class="cs-header">姓名</th>
							<th class="cs-header">职称</th>
							<th class="cs-header">证件号</th>
							<th class="cs-header">电子邮件</th>
							<th class="cs-header">手机号码</th>
							<th class="cs-header">办公电话</th>
							<th class="cs-header">操作</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td><input type="checkbox" /></td>
							<td>1</td>
							<td>李莫愁</td>
							<td>食品营养师</td>
							<td>23123323323</td>
							<td>3821023@qq.com</td>
							<td>13760234921</td>
							<td>已审核</td>
							<td><a class="cs-rewrite" href="javascript:"><img src="../../public/img/change.png" alt="" /></a> <a class="cs-del" href="javascript:;"><img src="../../public/img/del_red.png" alt="" /></a></td>
						</tr>
					</tbody>
				</table>

			</div>

			<!-- 工具栏 -->
			<div class="cs-tools clearfix">
				<div class="cs-menu-btn cs-fl cs-ac">
					<a class="cs-add-btn runcode" href="javascript:" name="content_frm2">新增</a>
				</div>
				<div class="cs-menu-btn cs-fl cs-ac ">
					<a class="cs-delet" href="javascript:">删除</a>
				</div>
				<div class="cs-menu-btn cs-fl cs-ac cs-distan">
					<a class="cs-export" href="javascript:">导出</a>
				</div>
				<ul class="cs-pagination cs-fr">
					<li class="cs-distan">共5页/48条记录</li>
					<li class="cs-b-nav-btn cs-distan cs-selcet"><select name="page" id="">
							<option value="page">10行/页</option>
							<option value="page">20行/页</option>
							<option value="page">30行/页</option>
					</select></li>
					<li class="cs-disabled cs-distan"><a class="cs-b-nav-btn" href="#">«</a></li>
					<li><a class="cs-b-nav-btn cs-n-active" href="#">1</a></li>
					<li><a class="cs-b-nav-btn" href="#">2</a></li>
					<li><a class="cs-b-nav-btn" href="#">3</a></li>
					<li><a class="cs-b-nav-btn" href="#">4</a></li>
					<li><a class="cs-b-nav-btn" href="#">5</a></li>
					<li class="cs-next "><a class="cs-b-nav-btn" href="#">»</a></li>
					<li class="cs-skip cs-distan">跳转<input type="text">页
					</li>
					<li><a class="cs-b-nav-btn cs-enter cs-distan" href="javascript:">确定</a></li>
				</ul>
			</div>
			<!-- 工具栏 -->
		</div>

		<div class="cs-alert-form-btn cs-hide">
			<a href="javascript:" class="cs-menu-btn cs-fun-btn cs-save" id="pointSave1">保存</a><a href="../supervision-object.html" class="cs-menu-btn cs-fun-btn cs-return">返回</a>
		</div>
	</div>


	<!-- 弹出窗3 地图坐标 -->
	<div class="cs-map-content">
		<div class="cs-map-top"></div>
		<div class="cs-map-bottom"></div>
	</div>


	<pre id="content_frm" style="display: none;">
               $.dialog({
              maxBtn:false,
              top:'20%',
              title:'新增',
              width:700,
              height:400,
              content: $(".cs-licence").html(),
              ok: function(){
              return false;
              },
              cancelVal: '关闭',
              cancel: true
              });

              </pre>


	<pre id="content_frm2" style="display: none;">
               $.dialog({
              maxBtn:false,
              top:'20%',
              title:'新增',
              width:700,
              height:400,
              content: $(".cs-licence2").html(),
              ok: function(){
              return false;
              },
              cancelVal: '关闭',
              cancel: true
              });

              </pre>




	<%@include file="/WEB-INF/view/detect/depart/selectDepart.jsp"%>
	<%@include file="/WEB-INF/view/data/detectItem/selectDetectItem.jsp"%>
	<%@include file="/WEB-INF/view/data/foodType/selectFoodType.jsp"%>
	<!-- JavaScript -->
	<script>
		_isDemoSkin && window._demoSkin && _demoSkin();
	</script>
	<script type="text/javascript">
	//保存
	$(document).on("click", "#pointSave", function(){
		$("#regForm").submit();
		$.ajax({
	        type: "POST",
	        url: '${webRoot}'+"/regulatory/addReg.do",
	        data: $("#regForm").serialize(),
	        dataType: "json",
	        success: function(data){
	        	if(data && data.success){
	        		$('#confirm-session').modal('toggle');
	        	}else{
	        		$('#confirm-fail').modal('toggle');
	        	}
			}
	    }); 	
	});
	
	
	</script>
	<script type="text/javascript">
		// 配置lhgdialog全局默认参数(可选)
		var model = (function(config) {
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
	</script>
	<script type="text/javascript">
		var editBtn = function(editbtn, name, url) {
			$(document).on('click', editbtn, function(event) {
				$.dialog({
					maxBtn : false,
					top : '20%',
					title : name,
					width : 700,
					height : 400,
					content : url,
					ok : function() {
						return false;
					},
					cancelVal : '关闭',
					cancel : true
				});
			});
		};

		editBtn('#content_frm3', '坐标定位', $(".cs-map-content").html());
	</script>
</body>
</html>
