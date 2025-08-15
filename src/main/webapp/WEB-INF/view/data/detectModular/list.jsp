<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/WEB-INF/view/common/resource.jsp" %>
<html>
<head>
    <title>快检服务云平台</title>
</head>
<body>
<div class="cs-col-lg clearfix">
    <!-- 面包屑导航栏  开始-->
    <ol class="cs-breadcrumb">
        <li class="cs-fl">
            <img src="${webRoot}/img/set.png" alt=""/>
            <a href="javascript:">检测模块</a></li>
        <li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
        <li class="cs-b-active cs-fl">检测模块管理
        </li>
    </ol>
    <!-- 面包屑导航栏  结束-->
    <div class="cs-search-box cs-fr">
        <form id="myForm1">
            <div class="cs-search-filter clearfix cs-fl">
                <input class="cs-input-cont cs-fl focusInput" type="text" name="detectModular" placeholder="请输入内容"/>
                <input type="button" onclick="datagridUtil.queryByFocus()" class="cs-search-btn cs-fl" href="javascript:;" value="搜索">
            </div>
        </form>

    </div>
</div>

<div id="dataList"></div>

<!-- Modal 2 中-->
<form class="registerform" id="saveform" method="post" action="#">
    <div class="modal fade intro2" id="myModal-mid3" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog cs-mid-width" role="document">
            <div class="modal-content ">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h4 class="modal-title" id="myModalLabel">新增</h4>
                </div>
                <div class="modal-body cs-mid-height">
                    <!-- 主题内容 -->
                    <div class="cs-main">
                        <div class="cs-wraper">
                            <input type="hidden" name="id" id="ModularId" value="">
                            <div width="100%" class="cs-add-new">
                                <ul class="cs-ul-form clearfix">
                                    <li class="cs-name col-md-3"><i class="cs-mred">*</i>检测模块名称：</li>
                                    <li class="cs-in-style col-md-5">
                                        <input type="text" autocomplete="off" id="detectModular"
                                               name="detectModular" class="inputxt" datatype="*" nullmsg="请输入检测模块名称"/>
                                    </li>
                                    <li class="col-md-4 col-xs-4  cs-text-nowrap">
                                        <div class="Validform_checktip"></div>
                                        <div class="info">
                                        </div>
                                    </li>
                                </ul>
                                <ul class="cs-ul-form clearfix">
                                    <li class="cs-name col-xs-2 col-md-2" width="20% "><i class="cs-mred">*</i>状态：</li>
                                    <li class="cs-al cs-modal-input">
                                        <input id="cs-check-radio2" type="radio" value="0" name="isCheck">
                                        <label for="cs-check-radio2">已审核</label>
                                        <input id="cs-check-radio" type="radio" value="1" name="isCheck" checked="checked">
                                        <label for="cs-check-radio">未审核</label></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer action">
                    <button type="button" class="btn btn-success" id="btnSave">确定</button>
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                </div>
            </div>
        </div>
    </div>
</form>
<!-- JavaScript -->
<%@include file="/WEB-INF/view/common/confirm.jsp" %>
<script src="${webRoot}/js/datagridUtil.js"></script>
<script type="text/javascript">
    //新增权限
    if (1 == Permission.exist("1366-4")) {
        $("#myForm1").append("<a href=\"#myModal-mid\" class=\"cs-menu-btn\" onclick=\"getModular();\"><i class=\""+Permission.getPermission("1366-4").functionIcon+"\"></i>"+Permission.getPermission("1366-4").operationName+"</a>");
    }

    var deleteId;
    var op = {
        tableId: "dataList",	//列表ID
        tableAction: "${webRoot}/data/detectModular/datagrid.do",	//加载数据地址
        parameter: [		//列表拼接参数
            {
                columnCode: "detectModular",
                columnName: "检测模块",
                query: 1
            },
            {
                columnCode: "isCheck",
                columnName: "状态",
                customVal: {"0": "已审核", "1": "<span style='color:#E53333;'>未审核</span>", "default": "<span style='color:#E53333;'>未审核</span>"},
                query: 1
            },

            {
                columnCode: "createDate",
                columnName: "创建时间",
                dateFormat: "yyyy-MM-dd",
                query: 1,
                queryType: 3
            }
        ],
        funBtns: [
            {
                show: Permission.exist("1366-1"),
                style: Permission.getPermission("1366-1"),
                action: function (id) {
                    getModular(id);
                }
            },
            {
                show: Permission.exist("1366-2"),
                style: Permission.getPermission("1366-2"),
                action: function (id) {
                    self.location = "${webRoot}/data/detectMethod/list.do?detectModularId=" + id;
                }
            },
            {
                show: Permission.exist("1366-3"),
                style: Permission.getPermission("1366-3"),
                action: function (id) {
                    deleteId = id;
                    $("#confirm-delete").modal('toggle');
                }
            }
        ],	//功能按钮
        defaultCondition: [  //加载条件
            {
                queryCode: "",
                queryVal: ""
            }
        ]
    };
    datagridUtil.initOption(op);
    datagridUtil.query();
    $(function () {
        //点击提交表单
        $("#btnSave").click(function () {
            $("#saveform").submit();
            return false;
        });
        //进行表单校验并异步请求保存数据
        //表单验证
        $("#saveform").Validform({
            tiptype: 2,
            beforeSubmit: function () {
                var formData = new FormData($('#saveform')[0]);
                $("#btnSave").attr("disabled", "disabled");//禁用按钮
                $.ajax({
                    type: "POST",
                    url: "${webRoot}/data/detectModular/save.do",
                    data: formData,
                    contentType: false, //必须false才会避开jQuery对 formdata 的默认处理 XMLHttpRequest会对 formdata 进行正确的处理
                    processData: false, //必须false才会自动加上正确的Content-Type
                    dataType: "json",
                    success: function (data) {
                        $('#myModal-mid3').modal("hide");
                        if (data && data.success) {
                            datagridUtil.queryByFocus();
                        } else {
                            $("#waringMsg>span").html(data.msg);
                            $("#confirm-warnning").modal('toggle');
                            $("#btnSave").removeAttr("disabled");//启用按钮
                        }
                    }
                });
                return false;
            }
        });

        //清空模态框输入框
        $('#myModal-mid3').on('hidden.bs.modal', function () {
            $("#saveform").form("clear");
        });
        $('#myModal-mid3').on('show.bs.modal', function () {
            $("#cs-check-radio").prop("checked", true);
            $("#btnSave").removeAttr("disabled");
        });
    });

    //编辑回显
    function getModular(id) {
        if (id) {
            $.ajax({
                type: "POST",
                url: "${webRoot}/data/detectModular/queryById.do",
                data: {"id": id},
                dataType: "json",
                success: function (data) {
                    var obj = data.obj;
                    if (obj) {
                        $("#ModularId").val(obj.id);
                        $("#detectModular").val(obj.detectModular);
                        if (obj.isCheck == 0) {
                            $("#cs-check-radio2").prop("checked", true);
                            $("#cs-check-radio").prop("checked", false);
                        } else if (obj.isCheck == 1) {
                            $("#cs-check-radio2").prop("checked", false);
                            $("#cs-check-radio").prop("checked", true);
                        }
                    }
                }
            });
            $("#myModal-mid3 .modal-title").text("编辑");
        } else {
            $("#myModal-mid3 .modal-title").text("新增");
        }
        $("#myModal-mid3").modal();
    }

    //删除函数
    function deleteData() {
        $.ajax({
            type: "POST",
            url: "${webRoot}/data/detectModular/delete.do",
            data: {"id": deleteId},
            success: function (data) {
                if (data && data.success) {
                    datagridUtil.query();
                }
            }
        });
        $("#confirm-delete").modal('toggle');
    }
</script>
<!--   <script type="text/javascript">
  /**
   * @author Van
   * @Version: 1.0
   * @DateTime: 2012-11-11
   */

  function $package(dy) {
      if (typeof(ns) != "string")
          return;
      ns = ns.split(".");
      var o, ni;
      for (var i = 0, len = ns.length;i < len, ni = ns[i]; i++) {
          try {
              o = (o ? (o[ni] = o[ni] || {}) : (eval(ni + "=" + ni + "||{}")))
          } catch (e) {
              o = eval(ni + "={}")
          }
      }
  }
  var dy={
      /*Json 工具类*/
      isJson:function(str){
          var obj = null;
          try{
              obj = dy.paserJson(str);
          }catch(e){
              return false;
          }
          var result = typeof(obj) == "object" && Object.prototype.toString.call(obj).toLowerCase() == "[object object]" && !obj.length;
          return result;
      },
      paserJson:function(str){
          return eval("("+str+")");
      },
      /*弹出框*/
      alert:function(title, msg, icon, callback){
          $.messager.alert(title,msg,icon,callback);
      },
      /*弹出框*/
      confirm:function(title, msg,callback){
          $.messager.defaults = { ok: "确认", cancel: "取消" };
          $.messager.confirm(title,msg,callback);
      },
      /*弹出框*/
      confirm1:function(title, msg,callback){
          $.messager.defaults = { ok: "确认", cancel: "继续增加" };
          $.messager.confirm(title,msg,callback);
      },
      progress:function(title,msg){
           var win = $.messager.progress({
              title: title ||'Please waiting',
              msg: msg ||'Loading data...'
           });
      },
      closeProgress:function(){
          $.messager.progress('close');
      },
      /*重新登录页面*/
      toLogin:function(){
          window.top.location= urls['msUrl']+"/login.shtml";
      },
      checkLogin:function(data){//检查是否登录超时
          if (data==null ){
              dy.alert('提示',"登录异常,请检查网络无误后联系管理员",'error',dy.toLogin);
              return false;
          }else if(data.logoutFlag){
              dy.closeProgress();
              dy.alert('提示',"登录超时,点击确定重新登录.",'error',dy.toLogin);
              return false;
          }
          return true;
      },
      ajaxSubmit:function(form,option){
          form.ajaxSubmit(option);
      },
      ajaxJson: function(url,option,callback){
          $.ajax(url,{
              type:'post',
                   dataType:'json',
                   data:option,
                   success:function(data){
                       //坚持登录
                       if(!dy.checkLogin(data)){
                           return false;
                       }
                       if($.isFunction(callback)){
                           callback(data);
                       }
                   },
                   error:function(response, textStatus, errorThrown){
                       try{
                           dy.closeProgress();
                           var data = $.parseJSON(response.responseText);
                           //检查登录
                           if(!dy.checkLogin(data)){
                               return false;
                           }else{
                               dy.alert('提示', data.msg || "请求出现异常,请联系管理员",'error');
                           }
                       }catch(e){
                           alert(e);
                           dy.alert('提示',"请求出现异常,请联系管理员",'error');
                       }
                   },
                   complete:function(){

                   }
          });
      },
      submitForm:function(form,callback,dataType){
              var option =
              {
                   type:'post',
                   dataType: dataType||'json',
                   success:function(data){
                       if($.isFunction(callback)){
                           callback(data);
                       }
                   },
                   error:function(response, textStatus, errorThrown){
                       try{
                           dy.closeProgress();
                           var data = $.parseJSON(response.responseText);
                           //检查登录
                           if(!dy.checkLogin(data)){
                               return false;
                           }else{
                               dy.alert('提示', data.msg || "请求出现异常,请联系管理员",'error');
                           }
                       }catch(e){
                           alert(e);
                           dy.alert('提示',"请求出现异常,请联系管理员1",'error');
                       }
                   },
                   complete:function(){

                   }
               }
               dy.ajaxSubmit(form,option);
      },
      saveForm:function(form,callback){
          if(form.form('validate')){
              dy.progress('Please waiting','Save ing...');
              //ajax提交form
              dy.submitForm(form,function(data){
                  dy.closeProgress();
                   if(data.success){
                       if(callback){
                           dy.alert('提示',data.msg,'info');//xuanaiwu add
                             callback(data);
                      }else{
                             dy.alert('提示','保存成功.','info');
                      }
                  }else{
                        dy.alert('提示',data.msg,'error');
                  }
              });
           }
      },
      /**
       *
       * @param {} url
       * @param {} option {id:''}
       */
      getById:function(url,option,callback){
          dy.progress();
          dy.ajaxJson(url,option,function(data){
              dy.closeProgress();
              if(data.success){
                  if(callback){
                         callback(data);
                  }
              }else{
                  dy.alert('提示',data.msg,'error');
              }
          });
      },
      deleteForm:function(url,option,callback){
          dy.progress();
          dy.ajaxJson(url,option,function(data){
                  dy.closeProgress();
                  if(data.success){
                      if(callback){
                             callback(data);
                      }
                  }else{
                      dy.alert('提示',result.msg,'error');
                  }
          });
      }
  }

  /* 自定义验证*/
  $.extend($.fn.validatebox.defaults.rules, {
      equals: {//自定义密码验证
          validator: function(value,param){
              return value == $(param[0]).val();
          },
          message: '两个密码不相等.'
      },
      isNum: { //自定义是否为数字验证
          validator: function(value){
              return !isNaN(value);
          },
          message: '请输入数字.'
      }
  });

  /*表单转成json数据*/
  $.fn.serializeObject = function() {
      var o = {};
      var a = this.serializeArray();
      $.each(a, function() {
          if (o[this.name]) {
              if (!o[this.name].push) {
                  o[this.name] = [ o[this.name] ];
              }
              o[this.name].push(this.value || '');
          } else {
              o[this.name] = this.value || '';
          }
      });
      return o;
  }

  /* easyui datagrid 添加和删除按钮方法*/
  $.extend($.fn.datagrid.methods, {
      addToolbarItem: function(jq, items){
          return jq.each(function(){
              var toolbar = $(this).parent().prev("div.datagrid-toolbar");
              for(var i = 0;i<items.length;i++){
                  var item = items[i];
                  if(item === "-"){
                      toolbar.append('<div class="datagrid-btn-separator"></div>');
                  }else{
                      var btn=$("<a href=\"javascript:void(0)\"></a>");
                      btn[0].onclick=eval(item.handler||function(){});
                      btn.css("float","left").appendTo(toolbar).linkbutton($.extend({},item,{plain:true}));
                  }
              }
              toolbar = null;
          });
      },
      removeToolbarItem: function(jq, param){
          return jq.each(function(){
              var btns = $(this).parent().prev("div.datagrid-toolbar").children("a");
              var cbtn = null;
              if(typeof param == "number"){
                  cbtn = btns.eq(param);
              }else if(typeof param == "string"){
                  var text = null;
                  btns.each(function(){
                      text = $(this).data().linkbutton.options.text;
                      if(text == param){
                          cbtn = $(this);
                          text = null;
                          return;
                      }
                  });
              }
              if(cbtn){
                  var prev = cbtn.prev()[0];
                  var next = cbtn.next()[0];
                  if(prev && next && prev.nodeName == "DIV" && prev.nodeName == next.nodeName){
                      $(prev).remove();
                  }else if(next && next.nodeName == "DIV"){
                      $(next).remove();
                  }else if(prev && prev.nodeName == "DIV"){
                      $(prev).remove();
                  }
                  cbtn.remove();
                  cbtn= null;
              }
          });
      }
  });
  dy.alert('提示','保存成功.','info');
  </script>-->
</body>
</html>
