<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/WEB-INF/view/common/resource.jsp" %>

<!DOCTYPE html>
<head>
    <title>快检服务云平台</title>
    <link rel="stylesheet" type="text/css" href="${webRoot}/plug-in/myUpload/css/easyupload.css"/>
    <script src="${webRoot}/plug-in/myUpload/js/easyupload.js" type="text/javascript"></script>
    <style>
        .file-name-span {
            color: blue;
        }

        .file-name-span:hover {
            color: #3033ff;
            cursor: pointer;
        }

    </style>
</head>

<body>
<div class="cs-maintab">
    <div class="cs-col-lg clearfix">
        <!-- 面包屑导航栏  开始-->
        <ol class="cs-breadcrumb">
            <li class="cs-fl">
                <img src="${webRoot}/img/set.png" alt=""/>
                <a href="javascript:">客户管理</a></li>
            <li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
            <li class="cs-b-active cs-fl">委托单位</li>
            <li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
            <c:if test="${empty id}">
                <li class="cs-b-active cs-fl">新增
                </li>
            </c:if>
            <c:if test="${!empty id}">
                <li class="cs-b-active cs-fl">编辑
                </li>
            </c:if>
        </ol>
        <!-- 面包屑导航栏  结束-->
        <div class="cs-search-box cs-fr">
            <button class="cs-menu-btn" onclick="parent.closeMbIframe(1);"><i class="icon iconfont icon-fanhui"></i>返回</button>
        </div>
    </div>
    <form id="saveForm" action="${webRoot}/regulatory/regulatoryObject/save.do" method="post" autocomplete="off">
        <input type="hidden" name="id" value="${id}">
        <div class="cs-base-detail">
            <div class="cs-content2">
                <table class="cs-add-new">
                    <tr>
                        <td class="cs-name"><i class="cs-mred">*</i>单位名称：</td>
                        <td class="cs-in-style">
                            <input type="text" datatype="*" nullmsg="请输入单位名称" name="requesterName"/>
                        </td>
                        <td class="cs-name">单位类型：</td>
                        <td class="cs-in-style">
                            <select name="unitType" <%--onchange="changeType(this)"--%>>
                                <c:forEach items="${list}" var="rtype">
                                    <option value="${rtype.id}">${rtype.unitType}</option>
                                </c:forEach>
                            </select>
                        </td>

                       <td class="cs-name">所属机构：</td>
                          <td class="cs-in-style">
                              <li class="cs-in-style cs-md-w">
                                  <div class="cs-all-ps">
                                      <div class="cs-input-box">
                                          <input type="text" name="departName" readonly="readonly" ignore="ignore">
                                          <input type="hidden" name="departId" ignore="ignore">
                                          <div class="cs-down-arrow"></div>
                                      </div>
                                      <div class="cs-check-down cs-hide" style="display: none;">
                                          <ul id="myDeaprtTree" class="easyui-tree"></ul>
                                      </div>
                                  </div>
                              </li>
                          </td>

                    </tr>
                    <tr>
                        <td class="cs-name">统一社会信用代码：</td>
                        <td class="cs-in-style">
                            <input type="text" name="creditCode"/>
                        </td>
                        <td class="cs-name">单位别称：</td>
                        <td class="cs-in-style">
                            <input type="text" name="requesterOtherName"/>
                        </td>
                        <td class="cs-name">单位状态：</td>
                        <td class="cs-in-style">
                            <label><input type="radio" name="state" value="0" checked="checked"/> 营业</label>
                            <label><input type="radio" name="state" value="1"/> 停业</label>
                        </td>
                    </tr>
                    <tr>
                        <td class="cs-name">服务许可证：</td>
                        <td class="cs-in-style">
                            <input type="text" name="serviceLicense"/>
                        </td>
                        <td class="cs-name">法人名称：</td>
                        <td class="cs-in-style">
                            <input type="text" name="legalPerson"/>
                        </td>
                        <td class="cs-name">经营范围：</td>
                        <td class="cs-in-style">
                            <input type="text" name="businessCope"/>
                        </td>
                    </tr>
                    <tr>
                        <td class="cs-name">联系人：</td>
                        <td class="cs-in-style">
                            <input type="text" name="linkUser"/>
                        </td>
                        <td class="cs-name">联系方式：</td>
                        <td class="cs-in-style">
                            <input type="text" name="linkPhone"/>
                        </td>
                        <td class="cs-name">通讯地址：</td>
                        <td class="cs-in-style">
                            <input type="text" name="companyAddress"/>
                        </td>
                    </tr>
                    <tr>
                        <td class="cs-name">就餐人数：</td>
                        <td class="cs-in-style">
                            <input type="text" name="scope" value="0"/>
                        </td>
                        <td class="cs-name">日检测量：</td>
                        <td class="cs-in-style">
                            <input type="text" name="checkNum" datatype="/^([1]?\d{1,10})$/"  value="1" errormsg="请输入整数"/>
                        </td>
                    </tr>
                    <tr>
                        <td class="cs-name">审核状态：</td>
                        <td class="cs-in-style">
                            <label><input type="radio" name="checked" value="0" /> 未审核</label>
                            <label><input type="radio" name="checked" value="1" checked="checked"/> 已审核</label>
                        </td>
                        <td class="cs-name">周末是否上班：</td>
                        <td class="cs-in-style">
                            <label><input type="radio" name="weekendWork" value="0" checked="checked"/> 否</label>
                            <label><input type="radio" name="weekendWork" value="1" /> 是</label>
                        </td>
                        <td class="cs-name">附件：</td>
                        <td class="cs-in-style" style="width:250px;">
                            <div id='uploaderFile'></div>
                        </td>
                    </tr>
                    
                    <tr >
                      <td class="cs-name">备注：</td>
                      <td class="cs-in-style" colspan="5">
                           <textarea name="remark" style="width: 90%;height:70px;"></textarea>
                        
                      </td>
                    </tr>
                </table>
            </div>
        </div>
    </form>
    <!-- 底部导航 结束 -->
    <div class="cs-alert-form-btn">
        <a href="javascript:" id="btnSave" class="cs-menu-btn cs-fun-btn"><i class="icon iconfont icon-save"></i>保存</a>
        <a href="javascript:" onclick="parent.closeMbIframe(1);" class="cs-menu-btn cs-fun-btn"><i class="icon iconfont icon-fanhui"></i>返回</a>
    </div>

    <!-- 引用模态框 -->
    <%@include file="/WEB-INF/view/common/confirm.jsp" %>

</body>
<!-- JavaScript -->
<script type="text/javascript">
    var uploaderobj = [];
    $(function () {
        uploaderobj = easyUploader({
            id: "uploaderFile", //容器渲染的ID 必填
            accept: '*',    //可上传的文件类型
            maxCount: 5,   //允许的最大上传数量
            maxSize: 1024,  //允许的文件大小 单位：M
            multiple: true, //是否支持多文件上传
            name: "files",     //后台接收的文件名称
            isEncrypt: false,//是否加密
            onChange: function (fileList) {
                //input选中时触发
            },
            onAlert: function (msg) {
                $("#confirm-warnning .tips").text(msg);
                $("#confirm-warnning").modal('toggle');
            }
        });
        //表单验证
        $("#saveForm").Validform({
            tiptype: 0,
            beforeSubmit: function () {
                var formData = new FormData($('#saveForm')[0]);
                var fileList = uploaderobj.files;
                for (var i = 0; i < fileList.length; i++) {
                    formData.append("files", fileList[i]);
                }
                $.ajax({
                    type: "POST",
                    url: "${webRoot}/requester/unit/save.do",
                    data: formData,
                    contentType: false, //必须false才会避开jQuery对 formdata 的默认处理 XMLHttpRequest会对 formdata 进行正确的处理
                    processData: false, //必须false才会自动加上正确的Content-Type
                    dataType: "json",
                    success: function (data) {
                        if (data && data.success) {
                            parent.closeMbIframe(1);//返回上一个界面并进行一次界面加载
                        } else {
                            $("#waringMsg>span").html(data.msg);
                            $("#confirm-warnning").modal('toggle');
                        }
                    }
                });
                return false;
            }
        });
        // 新增或修改
        $("#btnSave").on("click", function () {
            $("#saveForm").submit();
            return false;
        });

        //如果是编辑就去查询数据回显
        var id = $("input[name=id]").val();
        if (id) {
            $.ajax({
                type: 'POST',
                url: "${webRoot}/requester/unit/edit_echo.do",
                data: {'id': id},
                dataType: 'json',
                success: function (data) {
                    if (data && data.success) {
                        var obj = data.obj;
                        $('#saveForm').form('load', obj);
                        //编辑回显，展示已上传的文件
                        $("#file-list-" + uploaderobj.configs.id).html('');
                        editFileHtmlList(obj.tbFiles, uploaderobj, '${webRoot}');

                    } else {
                        $("#confirm-warnning2").modal('toggle');
                    }
                }
            });
        }
    });


    //组织机构树
    //所属机构树
    var treeLoadTimes = 1;	//控制获取顶级树
    var treeLevels = 1;
    $('#myDeaprtTree').tree({
        checkbox: false,
        url: '${webRoot}' + "/detect/depart/getDepartTree.do",
        animate: true,
        onClick: function (node) {
            $("input[name='departId']").val(node.id);
            $("input[name='departName']").val(node.text);
            $(".cs-check-down").hide();
        },
        onLoadSuccess: function (node, data) {
            //设置新增所属机构为当前用户所属机构
            if (treeLoadTimes == 1) {
                treeLoadTimes++;
                var topNode = $('#myDeaprtTree').tree('getRoot');
                $("input[name='departId']").val(topNode.id);
                $("input[name='departName']").val(topNode.text);
            }
            //延迟执行自动加载二级数据，避免与异步加载冲突
            setTimeout(function () {
                if (data && treeLevels == 1) {
                    treeLevels++;
                    $(data).each(function (index, d) {
                        if (this.state == 'closed') {
                            var children = $('#myDeaprtTree').tree('getChildren');
                            for (var i = 0; i < children.length; i++) {
                                $('#myDeaprtTree').tree('expand', children[i].target);
                            }
                        }
                    });
                }
            }, 100);
        }
    });


    function editFileHtmlList(files, uploader, root) {
        var html = '';
        for (var b = 0; b < files.length; b++) {
            var Dhtml = "";
            Dhtml += '<a class="icon iconfont icon-chushaixuanxiang shanchu" data-fileid="' + files[b].id + '" data-uploadid="#' + uploader.configs.id + '" onclick="removeFile(this)"  title="删除"></a>';
            var fileName = files[b].fileName;
            var path = files[b].filePath;
            if (fileName == null || fileName == "") {
                continue;
            }
            if (path == null || path == "") {
                continue;
            }
            var showName = fileName;
            if (fileName.length > 14) {
                showName = fileName.substring(0, 14) + "...";
            }
            html += '<div class="upload-files clearfix">';
            html += '<span class="file-name-span" onclick="downloadFile(\'' + path + '\')" title="' + fileName + '">' + showName + '</span>';
            html += '<a class="icon iconfont icon-chushaixuanxiang shanchu"  data-fileid="' + files[b].id + '" data-uploadid="#' + uploader.configs.id + '" onclick="removeFile(this)" title="删除"></a>';
            html += '</div>';
        }
        $("#file-list-" + uploader.configs.id).append(html);
    }
    function downloadFile(path) {
        window.location.href = '${webRoot}/requester/unit/download?path=' + path;
    }
</script>
</html>
