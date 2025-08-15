<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/WEB-INF/view/common/resource.jsp" %>

<!DOCTYPE html>
<head>
    <title>农产品合格证管理云平台</title>
    <link rel="stylesheet" type="text/css" href="${webRoot}/plug-in/uploader/css/uploader.css" />
    <style type="text/css">
        .Validform_checktip {
            display: none;
        }
        .img-upload{
            height: 54px;
            width: 58px;
            background-size: 60%;
            float: none;
        }

    </style>

</head>


<body>
<div class="cs-maintab">
    <div class="cs-col-lg clearfix">
        <!-- 面包屑导航栏  开始-->
        <div id="tab_bar"></div>
        <!-- 面包屑导航栏  结束-->
        <div class="cs-search-box cs-fr">
            <button class="cs-menu-btn" onclick="parent.closeMbIframe(1);"><i class="icon iconfont icon-fanhui"></i>返回
            </button>
        </div>
    </div>
    <form id="saveForm" action="${webRoot}/system/save.do" method="POST" enctype="multipart/form-data"
          autocomplete="off">
        <input name="id" id="id" type="hidden" value="${id}"/>
        <input type="hidden" name="isDefault" value="1"/>
        <div width="100%" class="cs-add-new">
            <ul class="cs-ul-form clearfix">
                <li class="cs-name col-xs-2 col-md-2">模板名称：</li>
                <li class="cs-in-style  col-xs-3 col-md-3">
                    <input type="text" name="templateName" datatype="*" errormsg="请输入模板名称"/>
                </li>
                <li class="cs-name col-xs-2 col-md-2">文件名称：</li>
                <li class="cs-in-style  col-xs-3 col-md-3">
                    <input type="text" name="fileName" placeholder="" datatype="*" errormsg="请输入文件名称"/>
                </li>
            </ul>
            <%-- <ul class="cs-ul-form clearfix">
                  <li class="cs-name col-xs-2 col-md-2">扫码页面标签：</li>
                <li class="cs-in-style  col-xs-3 col-md-3">
                    <input type="text" name="templateTag" placeholder="扫描查看对应页面的名称"  datatype="*" errormsg="请输入扫描查看对应页面的名称"/>
                </li>
             </ul>--%>
<%--            <ul class="cs-ul-form clearfix" id="introduceText">--%>
<%--                <li class="cs-name col-md-2 col-xs-2" style="height:60px;">打印指令：--%>
<%--                    <br/><span title='{"id":"11111","content":"示例"}'>JSON格式&nbsp;&nbsp;</span>--%>

<%--                </li>--%>
<%--                <li class="cs-in-style col-md-10 col-xs-10" style="height: auto;">--%>
<%--                            <textarea id="printInstructionContent" name="printInstructionContent" cols="30" rows="10"--%>
<%--                                      datatype="*" nullmsg="请输入JSON格式参数"--%>
<%--                                      style="height:350px; width:95%;line-height: 25px;"></textarea>--%>
<%--                </li>--%>
<%--            </ul>--%>
            <ul class="cs-ul-form clearfix">
                <li class="cs-name col-md-2 col-xs-2">审核状态：</li>
                <li class="cs-in-style  col-xs-3 col-md-3">
                    <label>
                        <input type="radio" name="checked" checked value="1"/>&nbsp;已审核
                    </label>
                    <label>
                        <input type="radio" name="checked" value="0"/>&nbsp;未审核
                    </label>
                </li>
            </ul>
            <%--<ul class="cs-ul-form clearfix">
               <li class="cs-name col-md-2 col-xs-2">默认模板： </li>
              <li class="cs-in-style  col-xs-3 col-md-3">
                    <label style="margin-left: 20px">
                           <input type="radio" name="isDefault" checked value="1"/>&nbsp;否
                       </label>
                       <label>
                           <input type="radio" name="isDefault" value="0"/>&nbsp;是
                       </label>
               </li>
           </ul> --%>
            <ul class="cs-ul-form clearfix" id="introduceText">
                <li class="cs-name col-md-2 col-xs-2">模板效果图：</li>
                <li class="cs-in-style col-md-10 col-xs-10" style="height: auto;">
                    <div class="f-fl item-ifo" style="width: 598px;">
                        <div class="release_up_pic">
                            <div class="cs-al cs-modal-input" id="upload"></div>
                            <div class="info-title2 upload-notice col-xs-12">
                                支持jpg、png、gif、jpeg格式图片，每张图片不大于2MB
                            </div>
                        </div>
                    </div>
                </li>
            </ul>

            <ul class="cs-ul-form clearfix" id="introduceText">
                <li class="cs-name col-md-2 col-xs-2">备注：</li>
                <li class="cs-in-style col-md-10 col-xs-10" style="height: auto;">
                            <textarea id="description" name="remark" cols="30" rows="10" datatype="*"
                                      nullmsg="请输入JSON参数说明"
                                      style="height:80px; width:90%;line-height: 25px;">${bean.description}</textarea>
                </li>
            </ul>


        </div>
    </form>
    <!-- 底部导航 结束 -->
    <div class="cs-hd"></div>
    <div class="cs-alert-form-btn">
        <button type="button" class="btn btn-success" id="btnSave">提交</button>
        <button type="button" onclick="parent.closeMbIframe(1);" class="cs-menu-btn cs-fun-btn"><i
                class="icon iconfont icon-fanhui"></i>返回
        </button>
    </div>
    <!-- 引用模态框 -->
    <%@include file="/WEB-INF/view/common/confirm.jsp" %>

    <!-- Modal 提示窗-确认-->
    <div class="modal fade intro2" id="confirmShowModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
         aria-hidden="true">
        <div class="modal-dialog cs-alert-width">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                            aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">确认</h4>
                </div>
                <div class="modal-body cs-alert-height cs-dis-tab">
                    <div class="cs-text-algin">
                        请输入确认码：<input name="confirmCode" style="width: 120px;height: 29px; border-radius: 3px;"/>
                        <span onclick="rand(1000,9999)" id="randNumber"
                              style="border: solid 1px #ccc;padding: 5px 10px;letter-spacing:8px;"></span>
                        <br/>
                        <sapn id="tips" style="color:red;"></sapn>
                    </div>
                </div>
                <div class="modal-footer">
                    <a class="btn btn-success btn-ok" onclick="confirmCheck()">确认</a>
                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                </div>
            </div>
        </div>
    </div>
</body>
<%--文件上传--%>
<script src="${webRoot}/plug-in/uploader/js/uploader.js"></script>
<%--layer--%>
<script src="${webRoot}/plug-in/layer/layer.js"></script>
<script type="text/javascript">

    //文件上传插件初始化
    let upload = uploader({
        id: "upload", //容器渲染的ID 必填
        accept: '.png,.jpg,.jpeg,.bmp,.gif,.tiff,.pcx,.ico',    //可上传的文件类型
        isImage: true,  //图片文件上传
        maxCount: 1,   //允许的最大上传数量
        maxSize: 1,  //允许的文件大小 单位：M
        multiple: false, //是否支持多文件上传
        name: 'file',   //后台接收的文件名称
        onAlert: function (msg) {
            layer.msg(msg, {
                icon: 7
            });
        }
    });


    var randNumber;
    initBar([{name: '系统管理'}, {name: "${empty id? "新增模板":"编辑模板"}"}]);
    if ($("input[name=id]").val() != '') {//编辑数据
        $.ajax({
            type: 'GET',
            url: '${webRoot}/report/template/${id}',
            dataType: 'json',
            success: res => {
                if (res.success) {
                    //数据回显
                    //1.判断是否供应商
                    let obj = res.obj;
                    console.log("图片返回",obj)
                    $('#saveForm').form('load', obj);
//                      $("#printInstructionContent").val("");
<%--                    if (obj.printInstructionContent != "") {--%>
<%--                        // var jsonData=JSON.stringify(JSON.parse('${bean.configParam}'), null, 4);--%>
<%--                        var jsonData = JSON.stringify(JSON.parse(obj.printInstructionContent), "", 4);--%>
<%--                        $("#printInstructionContent").val(jsonData);--%>
<%--                    }--%>

                    showImageHtml(upload, obj.previewImage, "${webRoot}");
                } else {
                    layer.msg("数据查询失败!", {icon: 2});
                }
            }
        });
    }
    $(function () {
        //失去焦点的时候格式化 JSON 数据
        $('#printInstructionContent').blur(function () {
            var input;
            try {
                if ($('#printInstructionContent').val().length == 0) {
                    return;
                }
                input = eval('(' + $('#printInstructionContent').val() + ')');
            } catch (error) {
                return alert("Input data is not valid JSON, please check. Error: " + error);
            }
            //$('#printInstructionContent').val(JSON.stringify(input, null, 4));
            $('#printInstructionContent').val(JSON.stringify(input, "", 4));
        });
        //表单验证
        $("#saveForm").Validform({
            tiptype: 0,
            beforeSubmit: function () {
                //获取formData对象,设置图片文件
                let formData = new FormData($("#saveForm")[0]);
                if (upload.files.length > 0) {
                    upload.files.forEach(function (file, index) {
                        formData.append('file', file);
                    })
                }
                $.ajax({
                    type: "POST",
                    url: "${webRoot}/report/template/saveOrUpdate",
                    data: formData,
                    contentType: false, //必须false才会避开jQuery对 formdata 的默认处理 XMLHttpRequest会对 formdata 进行正确的处理
                    processData: false, //必须false才会自动加上正确的Content-Type
                    dataType: "json",
                    success: function (data) {
                        if (data && data.success) {
                            parent.closeMbIframe(1);//返回上一个界面并进行一次界面加载
                        } else {
                            layer.msg(data.msg, {icon: 2});
                        }
                    }
                });
                return false;
            }
        });
        // 新增或修改
        $("#btnSave").on("click", function () {
            if (${bean!=null}) {
                rand(1000, 9999);
                $("#confirmShowModal").modal('toggle');
            } else {
                $("#saveForm").submit();
            }
            return false;
        });
    });

    function confirmCheck() {
        var confirmCode = $("input[name=confirmCode]").val();
        if (confirmCode == '') {
            $("#tips").html("请输入确认码！");
            $("#tips").removeClass("cs-hide");
        } else if (confirmCode != randNumber) {
            $("#tips").html("确认码错误！");
            $("#tips").removeClass("cs-hide");
        } else {
            $("#saveForm").submit();
        }
    }

    function rand(min, max) {
        randNumber = Math.floor(Math.random() * (max - min)) + min;
        $("#randNumber").html(randNumber);
    }
</script>
</html>
