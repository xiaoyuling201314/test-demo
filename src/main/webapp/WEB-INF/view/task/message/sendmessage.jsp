<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@include file="/WEB-INF/view/common/resource.jsp"%>
<html>
<head>
<title>快检服务云平台</title>
<link rel="stylesheet" type="text/css" href="${webRoot}/css/fileinput.css" />
<link rel="stylesheet" type="text/css" href="${webRoot}/css/theme.css" />
<link rel="stylesheet" type="text/css" href="${webRoot}/css/font/font-awesome.css" rel="stylesheet">
<style>
.cs-send-btn{
	background:#fff;
}
.cs-divtxt{
    height: auto;
    min-height:28px;
    line-height: auto;
}
#content{
	height:150px;
}
</style>
</head>
<!-- 上传 -->
<script src="${webRoot}/js/sortable.js" type="text/javascript"></script>
<script src="${webRoot}/js/fileinput.js" type="text/javascript"></script>
<script src="${webRoot}/js/zh.js" type="text/javascript"></script>
<script src="${webRoot}/js/theme.js" type="text/javascript"></script>
<body>
	 <div class="cs-col-lg clearfix">
          <!-- 面包屑导航栏  开始-->
            <ol class="cs-breadcrumb cs-fl">
              <li class="cs-fl">
              <img src="${webRoot}/img/set.png" alt="" />
              <li class="cs-fl">任务管理
              </li>
              <li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
              <li class="cs-b-active cs-fl">信息发布
              </li>
            </ol>
            
          <!-- 面包屑导航栏  结束-->
         <div class="clearfix cs-fr" id="showBtn">
             <a href="${webRoot}/taskMessage/messagefrom" class="cs-menu-btn"><i class="icon iconfont icon-fanhui"></i>返回</a></div>
         </div>
          </div>
      <div class="cs-tb-box cs-box-pos">

      
      <div class="cs-content2 clearfix cs-main-content">
      	<form id="sendmessage" enctype="multipart/form-data" >
            <input type="hidden" name="toUserType" id="toUserType"/>
          <table class="cs-mail-content">
            <tr>
              <td class="cs-mail-name"  style="width:100px;">收件人：</td>
              <!--  <input type="text" name="groupID" id="toUserId"/>-->
              <td class="cs-no-bd" style="padding-right:40px;">
              
              
              	<div class="input-group">
                  <div class="cs-divtxt" id="toUserId">
	                <input type="hidden" name="groupID" id="groupID"/>
	              </div>
                  
                  <div class="input-group-btn">
                    <button type="button" class="btn btn-default" value="0" onclick="showUser()" name="name" id="button">接收人</button>
                    <button type="button" class="btn btn-default" value="1" onclick="showGroup()" name="name" id="button2">接收机构</button>
                    <button type="button" class="btn btn-default" value="2" onclick="showPoint()" name="name" id="button3">接收检测点</button>
                  </div>
              </div>

              </td>
              </tr>

       <%--     <tr>
            
              <td class="cs-mail-name">标题：</td>
              <td class="cs-mail-inpTxt" colspan="2" style="padding-right:40px;"><input type="text" name="title" id="title"/></td>
            </tr>--%>
            <tr>
              <td class="cs-mail-name cs-mail-top">任务内容：</td>
              <td class="cs-mail-inpTxt cs-mail-texteare"  style="padding-right:40px;">
                  <textarea rows="3" cols="3" style="" name="content" id="content" ></textarea>
                  <%--  <div class="hero-unit">
                     <div id="alerts"></div>
                      <div class="btn-toolbar" data-role="editor-toolbar" data-target="#editor">
                         <div class="btn-group">
                           <a class="btn dropdown-toggle" data-toggle="dropdown" title="Font"><i class="icon-font"></i><b class="caret"></b></a>
                             <ul class="dropdown-menu">
                             </ul>
                           </div>
                         <div class="btn-group">
                           <a class="btn dropdown-toggle" data-toggle="dropdown" title="Font Size"><i class="icon-text-height"></i>&nbsp;<b class="caret"></b></a>
                             <ul class="dropdown-menu">
                             <li><a data-edit="fontSize 5"><font size="5">Huge</font></a></li>
                             <li><a data-edit="fontSize 3"><font size="3">Normal</font></a></li>
                             <li><a data-edit="fontSize 1"><font size="1">Small</font></a></li>
                             </ul>
                         </div>
                         <div class="btn-group">
                           <a class="btn" data-edit="bold" title="Bold (Ctrl/Cmd+B)"><i class="icon-bold"></i></a>
                           <a class="btn" data-edit="italic" title="Italic (Ctrl/Cmd+I)"><i class="icon-italic"></i></a>
                           <a class="btn" data-edit="strikethrough" title="Strikethrough"><i class="icon-strikethrough"></i></a>
                           <a class="btn" data-edit="underline" title="Underline (Ctrl/Cmd+U)"><i class="icon-underline"></i></a>
                         </div>
                         <div class="btn-group">
                           <a class="btn" data-edit="insertunorderedlist" title="Bullet list"><i class="icon-list-ul"></i></a>
                           <a class="btn" data-edit="insertorderedlist" title="Number list"><i class="icon-list-ol"></i></a>
                           <a class="btn" data-edit="outdent" title="Reduce indent (Shift+Tab)"><i class="icon-indent-left"></i></a>
                           <a class="btn" data-edit="indent" title="Indent (Tab)"><i class="icon-indent-right"></i></a>
                         </div>
                         <div class="btn-group">
                           <a class="btn" data-edit="justifyleft" title="Align Left (Ctrl/Cmd+L)"><i class="icon-align-left"></i></a>
                           <a class="btn" data-edit="justifycenter" title="Center (Ctrl/Cmd+E)"><i class="icon-align-center"></i></a>
                           <a class="btn" data-edit="justifyright" title="Align Right (Ctrl/Cmd+R)"><i class="icon-align-right"></i></a>
                           <a class="btn" data-edit="justifyfull" title="Justify (Ctrl/Cmd+J)"><i class="icon-align-justify"></i></a>
                         </div>
                         <div class="btn-group">
                         <a class="btn dropdown-toggle" data-toggle="dropdown" title="Hyperlink"><i class="icon-link"></i></a>
                           <div class="dropdown-menu input-append">
                             <input class="span2" placeholder="URL" type="text" data-edit="createLink"/>
                             <button class="btn" type="button">Add</button>
                           </div>
                           <a class="btn" data-edit="unlink" title="Remove Hyperlink"><i class="icon-cut"></i></a>

                         </div>

                         <div class="btn-group">
                           <a class="btn" title="Insert picture (or just drag & drop)" id="pictureBtn"><i class="icon-picture"></i></a>
                           <input type="file" data-role="magic-overlay" data-target="#pictureBtn" data-edit="insertImage" />
                         </div>
                         <div class="btn-group">
                           <a class="btn" data-edit="undo" title="Undo (Ctrl/Cmd+Z)"><i class="icon-undo"></i></a>
                           <a class="btn" data-edit="redo" title="Redo (Ctrl/Cmd+Y)"><i class="icon-repeat"></i></a>
                         </div>
                         <input type="text" data-edit="inserttext" id="voiceBtn" x-webkit-speech="">
                       </div>

                       <div id="editor" style="text-align:left;">
                         <textarea rows="3" cols="3" style="display: none;" name="content" id="content"></textarea>
                       </div>
                     </div>--%>

              </td>
            </tr>
              <tr>
                  <td class="cs-mail-name">附件：</td>
                  <td class="cs-mail-inpTxt" >
                      <div class="kv-main2">
                          <input id="kv-explorer" type="file" name="file" onchange="fileChange(this);" multiple="multiple">
                      </div>
                  </td>
              </tr>
              <tr>
                  <td class="cs-mail-name"></td>
                  <td class="" >
                      <input type="hidden" name="title" value="0"/>
                      <span class="checkbox-input" style="float: left;">
                          <i><input  name="sendMesage" value="1" type="checkbox" id="sendMesage"></i>
                          <label title="短信通知" for="sendMesage">短信通知</label></span>
                        <span style="color: red;float: left;margin-left: 10px;padding-top: 4px;">短信内容：食品安全检测数据平台有新任务，请上平台查收！</span>
                     <%-- <div style="width: 200px;">
                          <input type="checkbox"/> 短信通知
                      </div>--%>

                  </td>
              </tr>
              <tr>
            	<td colspan="2" style="padding-left: 100px; text-align:center;">
                    <a class="cs-menu-btn cs-send-btn" id="btnSave"><i class="icon iconfont icon-fasong" ></i>发送</a>
<%--                    <a class="cs-menu-btn cs-send-btn" id="btnMessageSave"><i class="icon iconfont icon-duanxin" ></i>发送短信</a>--%>
                </td>
            </tr>
          </table>
      	</form>
      </div>
      </div>
      
     
 




  

<!-- 接收机构 -->
  <div class="modal fade intro2" id="myModal-mid2" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog cs-mid-width" role="document">
    <div class="modal-content ">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">发送对象</h4>
      </div>
      <div class="modal-body cs-mid-height">
         <!-- 主题内容 -->
      <!-- 树状图 -->
                      <ul id="tt2" class="easyui-tree">
                        
                    </ul>
                    <!-- 树状图 -->
      </div>
      <div class="modal-footer action">
      <button type="submit" class="btn btn-success">确定</button>
      <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
        
        
      </div>
        
    </div>
  </div>
</div>

    <div class="modal fade intro2" id="confirm-sure" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="z-index:10000" data-backdrop="static" data-keyboard="false">
		<div class="modal-dialog cs-alert-width">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
					<h4 class="modal-title">提示</h4>
				</div>
				<div class="modal-body cs-alert-height cs-dis-tab">
					<div class="cs-text-algin">
						<img src="${webRoot}/img/sure.png" width="40px"/>
						<span class="tips"></span>
						</div>
				</div>
				<div class="modal-footer">
					<a class="btn btn-danger btn-ok" data-dismiss="modal">关闭</a>
				</div>
			</div>
		</div>
	</div>
	<script src="${webRoot}/js/datagridUtil.js"></script>
   	<script src="${webRoot}/js/jquery.form.js"></script>
   <!-- JavaScript -->
    <script src="${webRoot}/js/jquery-ui.min.js"></script>
   
    <!-- 上传 -->
    <script src="${webRoot}/js/sortable.js" type="text/javascript"></script>
    <script src="${webRoot}/js/fileinput.js" type="text/javascript"></script>
    <script src="${webRoot}/js/zh.js" type="text/javascript"></script>
    <script src="${webRoot}/js/theme.js" type="text/javascript"></script>
    <!-- 下拉插件 -->
    <script src="${webRoot}/js/select/tabcomplete.min.js"></script>
    <script src="${webRoot}/js/select/livefilter.min.js"></script>
    <script src="${webRoot}/js/select/bootstrap-select.js"></script>
    <script src="${webRoot}/js/select/plugins.js"></script>
    <!-- 自定义插件 -->

    <!-- icheck -->
    <script src="${webRoot}/js/icheck.js"></script>
    <!-- 时间插件 -->
	<%@include file="/WEB-INF/view/common/confirm.jsp"%>
	<%@include file="/WEB-INF/view/message/selectUser.jsp"%>
	<%@include file="/WEB-INF/view/message/selectGroup.jsp"%>
	<%@include file="/WEB-INF/view/message/selectPoint.jsp"%>
   	
 	<script type="text/javascript">
 	function fileChange(target) {
 	    var fileSize = 0;  
 	    var isIE = /msie/i.test(navigator.userAgent) && !window.opera; 
 	     if (isIE && !target.files) {     
 	       var filePath = target.value;     
 	       var fileSystem = new ActiveXObject("Scripting.FileSystemObject");        
 	       var file = fileSystem.GetFile (filePath);     
 	       fileSize = file.Size;    
 	     } else {
 	      for (var i = 0; i < target.files.length; i++) {
 	    	 fileSize += target.files[i].size;
			}
 	     }
 	      var size = fileSize / 1024;
 	      if(size>102400){
 	       $("#confirm-warnning .tips").text("附件不能大于100M");
	  	   $("#confirm-warnning").modal('toggle');
 	       target.value="";
 	       return
 	      }
 	 } 
 	
  $('#_easyui_textbox_input1').click(function(event) {
    $('.panel-htop').css('display', 'block');
  }); 
   $("#btnSave").on("click", function() {
	  	// $("#content").val($("#editor").html());
	  	if($("#groupID").val()!=""){
	  		// if($("#title").val()!=""){
		  		// jquery 表单提交
                if($("#sendMesage").is(':checked')){
                    $("input[name=title]").val("1");
                }
	  			var formData = new FormData($('#sendmessage')[0]);
	  			$.ajax({
	  		        type: "POST",
	  		        url: '${webRoot}'+"/message/sendMessageOne.do",
	  		        data: formData,
	  		        contentType: false, //必须false才会避开jQuery对 formdata 的默认处理 XMLHttpRequest会对 formdata 进行正确的处理 
	  		        processData: false, //必须false才会自动加上正确的Content-Type
	  		        dataType: "json",
	  				success: function(data){
	  					/* $("#confirm-sure .tips").text("发送成功!");
	  					$("#confirm-sure").modal('show'); */
	  					window.location.href = '${webRoot}/taskMessage/messagefrom';
	  				},
	  				error: function(data){
	  					$("#confirm-warnning .tips").text("发送失败!");
	  			  		$("#confirm-warnning").modal('toggle');
	  				}
	  		    });
	  		// }else{
	  		// 	$("#confirm-warnning .tips").text("请填写标题!");
			//   	$("#confirm-warnning").modal('toggle');
	  		// }
	  	}else {
			$("#confirm-warnning .tips").text("请填写收件人!");
		  	$("#confirm-warnning").modal('toggle');
		}
	});

    $("#btnMessageSave").on("click", function() {
        $("#confirm-sure .tips").text("发送成功!");
        $("#confirm-sure").modal('show');
    })
   //选择接收对象
	function selectReceivingObject(){
			var orgType = $("input[type='radio'][name='name']:checked").val();
			if(orgType == "1"){
				//机构
				$('#myDeaprtModal').modal('toggle');
			}else if(orgType == "0"){
				//人员
				$('#myUserModal').modal('toggle');
			}else if(orgType == "2"){
				//检测点
				$('#myPointModal').modal('toggle');
			}
	}
	
	function showUser() {
		$('#myUserModal').modal('toggle');
	}
	
	function showGroup() {
		$('#myDeaprtModal').modal('toggle');
	}
	
	function showPoint() {
		$('#myPointModal').modal('toggle');
	}
	//设置接收机构
	function selOrg(nodes){
		addOrgItems(nodes);
		$('#myDeaprtModal').modal('toggle');
	}
	//设置接收人
	function selUser(usersArray) {
		addOrgItem(usersArray);
		$('#myUserModal').modal('toggle');
	}
	//设置接收检测点
	function selPoint(pointsArray){
		addPointItem(pointsArray);
		$('#myPointModal').modal('toggle');
	}
	function addOrgItems(nodes){
		var orgType = $("#button2").val();
		$("#toUserType").attr("value",orgType);
		var orgItemHtml=[];
		$("#toUserId .cs-mail-point").remove();
		if(orgType == "1"){
			//机构
			if($("#check").is(':checked')){
				if(nodes){
					for(var i=1; i<nodes.length; i++){
						orgItemHtml[i] = "<span class=\"cs-mail-point cs-icon-span\">"+nodes[i]["text"]+"<input type=\"hidden\" name=\"groupIDs\" value=\""+nodes[i]["id"]+"\"/><i class=\"cs-x-this icon iconfont icon-close\"></i>;</span>"
					}
					$("#toUserId").append(orgItemHtml);
				}
			}else {
				if(nodes){
					for(var i=0; i<nodes.length; i++){
						orgItemHtml[i] = "<span class=\"cs-mail-point cs-icon-span\">"+nodes[i]["text"]+"<input type=\"hidden\" name=\"groupIDs\" value=\""+nodes[i]["id"]+"\"/><i class=\"cs-x-this icon iconfont icon-close\"></i>;</span>"
					}
					$("#toUserId").append(orgItemHtml);
				}
			}
		}
		var arr=[];
		var test=[];
		arr=$("input[name='groupIDs']");
		for(var i=0;i<arr.length;i++){
			test[i]=$(arr[i]).val();//获取value值
		}
		$("#groupID").attr("value",test);
	}
	function addOrgItem(nodes){
		var orgType =$("#button").val();
		$("#toUserType").attr("value",orgType);
		var orgItemHtml=[];
		$("#toUserId .cs-mail-point").remove();
		if(orgType == "0"){
			if(nodes){
				for(var i=0; i<nodes.length; i++){
					orgItemHtml[i] ="<span class=\"cs-mail-point cs-icon-span\">"+nodes[i]["name"]+"<input type=\"hidden\" name=\"groupIDs\" value=\""+nodes[i]["id"]+"\"/><i class=\"cs-x-this icon iconfont icon-close\"></i>;</span>"
				}
				$("#toUserId").append(orgItemHtml);
			}
		}else if (orgType == "2") {
			if(nodes){
				for(var i=0; i<nodes.length; i++){
					orgItemHtml[i] ="<span class=\"cs-mail-point cs-icon-span\">"+nodes[i]["name"]+"<input type=\"hidden\" name=\"groupIDs\" value=\""+nodes[i]["id"]+"\"/><i class=\"cs-x-this icon iconfont icon-close\"></i>;</span>"
				}
				$("#toUserId").append(orgItemHtml);
			}
		}
		var arr=[];
		var test=[];
		arr=$("input[name='groupIDs']");
		for(var i=0;i<arr.length;i++){
			test[i]=$(arr[i]).val();//获取value值
		}
		$("#groupID").attr("value",test);
	}
	
	function addPointItem(nodes){
		var orgType = $("#button3").val();
		$("#toUserType").attr("value",orgType);
		var orgItemHtml=[];
		$("#toUserId .cs-mail-point").remove();
		if (orgType == "2") {
			if(nodes){
				for(var i=0; i<nodes.length; i++){
					orgItemHtml[i] ="<span class=\"cs-mail-point cs-icon-span\">"+nodes[i]["name"]+"<input type=\"hidden\" name=\"groupIDs\" value=\""+nodes[i]["id"]+"\"/><i class=\"cs-x-this icon iconfont icon-close\"></i>;</span>"
				}
				$("#toUserId").append(orgItemHtml);
			}
		}
		var arr=[];
		var test=[];
		arr=$("input[name='groupIDs']");
		for(var i=0;i<arr.length;i++){
			test[i]=$(arr[i]).val();//获取value值
		}
		$("#groupID").attr("value",test);
	}
	
</script>

    
 <script type="text/javascript">
$(function(){
  
  var getInfoObj=function(){
      return  $(this).parents("li").next().find(".info");
    }
  
  $("[datatype]").focusin(function(){
	    if(this.timeout){clearTimeout(this.timeout);}
	    var infoObj=getInfoObj.call(this);
	    if(infoObj.siblings(".Validform_right").length!=0){
	      return; 
	    }
	    infoObj.show().siblings().hide();
	    
	  }).focusout(function(){
	    var infoObj=getInfoObj.call(this);
	    this.timeout=setTimeout(function(){
	      infoObj.hide().siblings(".Validform_wrong,.Validform_loading").show();
	    },0);
    
  });
  
  $(".registerform").Validform({
    tiptype:2,
    usePlugin:{
      passwordstrength:{
        minLen:6,
        maxLen:18,
        trigger:function(obj,error){
          if(error){
            obj.parent().next().find(".passwordStrength").hide().siblings(".info").show();
          }else{
            obj.removeClass("Validform_error").parent().next().find(".passwordStrength").show().siblings().hide();  
          }
        }
      }
    }
  });
})




</script>
<script type="text/javascript">
$(function(){
    
  var demo=$(".registerform").Validform({
    tiptype:3,
    label:".label",
    showAllError:true,
    datatype:{
      "zh1-6":/^[\u4E00-\u9FA5\uf900-\ufa2d]{1,6}$/
    },
    ajaxPost:true
  });
  
  //通过$.Tipmsg扩展默认提示信息;
  //$.Tipmsg.w["zh1-6"]="请输入1到6个中文字符！";
  demo.tipmsg.w["zh1-6"]="请输入1到6个中文字符！";
  
  demo.addRule([{
    ele:".inputxt:eq(0)",
    datatype:"zh2-4"
  },
  {
    ele:".inputxt:eq(1)",
    datatype:"*6-20"
  },
  {
    ele:".inputxt:eq(2)",
    datatype:"*6-20",
    recheck:"userpassword"
  },
  {
    ele:"select",
    datatype:"*"
  },
  {
    ele:":radio:first",
    datatype:"*"
  },
  {
    ele:":checkbox:first",
    datatype:"*"
  }]);
  
})
</script>
<script>

    $("#file-1").fileinput({
        uploadUrl: '#', // you must set a valid URL here else you will get an error
        allowedFileExtensions: ['jpg', 'png', 'gif'],
        overwriteInitial: false,
        maxFileSize: 1000,
        maxFilesNum: 10,
        slugCallback: function (filename) {
            return filename.replace('(', '_').replace(']', '_');
        }
    });
    
    $("#file-4").fileinput({
        uploadExtraData: {kvId: '10'}
    });
    $(".btn-warning").on('click', function () {
        var $el = $("#file-4");
        if ($el.attr('disabled')) {
            $el.fileinput('enable');
        } else {
            $el.fileinput('disable');
        }
    });
    $(".btn-info").on('click', function () {
        $("#file-4").fileinput('refresh', {previewClass: 'bg-info'});
    });
    $(document).ready(function () {
        $("#test-upload").fileinput({
            'showPreview': false,
            'allowedFileExtensions': ['jpg', 'png', 'gif'],
            'elErrorContainer': '#errorBlock'
        });
        $("#kv-explorer").fileinput({
            'theme': 'explorer',
            'uploadUrl': '#',
            textEncoding:'UTF-8',
            language: 'zh', 
            overwriteInitial: false,
            initialPreviewAsData: true,
            dropZoneEnabled: false,
            showClose:false,
            maxFileCount:10,
            browseLabel:'浏览',
        });
    });
</script>
 <script>
            $(document).ready(function(){
              $('.skin-square input').iCheck({
                checkboxClass: 'icheckbox_square-green',
                radioClass: 'iradio_square-green',
                increaseArea: '20%'
              });
            });
            </script>
            
            
            
            
            
            
  <!-- 富文本 -->
<script>
  $(function(){
    function initToolbarBootstrapBindings() {
      var fonts = ['Serif', 'Sans', 'Arial', 'Arial Black', 'Courier', 
            'Courier New', 'Comic Sans MS', 'Helvetica', 'Impact', 'Lucida Grande', 'Lucida Sans', 'Tahoma', 'Times',
            'Times New Roman', 'Verdana'],
            fontTarget = $('[title=Font]').siblings('.dropdown-menu');
      $.each(fonts, function (idx, fontName) {
          fontTarget.append($('<li><a data-edit="fontName ' + fontName +'" style="font-family:\''+ fontName +'\'">'+fontName + '</a></li>'));
      });
      $('a[title]').tooltip({container:'body'});
      $('.dropdown-menu input').click(function() {return false;})
        .change(function () {$(this).parent('.dropdown-menu').siblings('.dropdown-toggle').dropdown('toggle');})
        .keydown('esc', function () {this.value='';$(this).change();});

      $('[data-role=magic-overlay]').each(function () { 
        var overlay = $(this), target = $(overlay.data('target')); 
        overlay.css('opacity', 0).css('position', 'absolute').offset(target.offset()).width(target.outerWidth()).height(target.outerHeight());
      });
      if ("onwebkitspeechchange"  in document.createElement("input")) {
        var editorOffset = $('#editor').offset();
        $('#voiceBtn').css('position','absolute').offset({top: editorOffset.top, left: editorOffset.left+$('#editor').innerWidth()-35});
      } else {
        $('#voiceBtn').hide();
      }
  };
  function showErrorAlert (reason, detail) {
    var msg='';
    if (reason==='unsupported-file-type') { msg = "Unsupported format " +detail; }
    else {
      console.log("error uploading file", reason, detail);
    }
    $('<div class="alert"> <button type="button" class="close" data-dismiss="alert">&times;</button>'+ 
     '<strong>File upload error</strong> '+msg+' </div>').prependTo('#alerts');
  };
    initToolbarBootstrapBindings();  
  $('#editor').wysiwyg({ fileUploadError: showErrorAlert} );
    window.prettyPrint && prettyPrint();
  });
</script>
<script>
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','','ga');
  ga('create', 'UA-37452180-6', 'github.io');
  ga('send', 'pageview');
</script>
<script>(function(d, s, id) {
  var js, fjs = d.getElementsByTagName(s)[0];
  if (d.getElementById(id)) return;
  js = d.createElement(s); js.id = id;
  js.src = "";
  fjs.parentNode.insertBefore(js, fjs);
  }(document, 'script', 'facebook-jssdk'));
 </script>

<script>!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0];if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src="";fjs.parentNode.insertBefore(js,fjs);}}(document,"script","twitter-wjs");</script>


  </body>
</body>
</html>