<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/WEB-INF/view/common/resource.jsp" %>
<link rel="stylesheet" href="${webRoot}/js/Select2-4.0.2/css/select2.min.css">
<!-- 上传附件控件 -->
<link rel="stylesheet" type="text/css" href="${webRoot}/css/fileinput.css"/>
<link rel="stylesheet" type="text/css" href="${webRoot}/css/theme.css"/>
<script type="text/javascript" src="${webRoot}/js/sortable.js"></script>
<script type="text/javascript" src="${webRoot}/js/fileinput.js"></script>
<script type="text/javascript" src="${webRoot}/js/zh.js"></script>
<script type="text/javascript" src="${webRoot}/js/theme.js"></script>
<%-- MD5加密 --%>
<script type="text/javascript" src="${webRoot}/plug-in/blueimp-md5/md5.min.js"></script>
<html>
<head>
    <title>快检服务云平台</title>
    <style type="text/css">
        .cs-modal-box2 {
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: #fff;
            width: 100%;
            z-index: 100000;
        }

        .cs-table-responsive {
            padding-bottom: 65px;
        }

        .container {
            margin-left: 30px;
            margin-top: 20px;
        }

        .containers {
            margin-left: 30px;
            margin-top: 10px;
        }

        h1 {
            padding-bottom: 10px;
            color: darkmagenta;
            font-weight: bolder;
        }

        img {
            cursor: pointer;
        }

        #pic {
            position: absolute;
            display: none;
        }

        #pic1 {
            width: 100px;
            background-color: #fff;
            border-radius: 5px;
            -webkit-box-shadow: 5px 5px 5px 5px hsla(0, 0%, 5%, 1.00);
            box-shadow: 5px 5px 5px 0px hsla(0, 0%, 5%, 0.3);
        }

        #pic1 img {
            width: 100%;
        }
    </style>
</head>
<body>
<!--让浏览器自动填充到这个input-->
<input type="password" style="display: none;">

<div id="dataList"></div>
<!-- 用户新增/编辑模态框 start-->
<div class="modal fade intro2" id="myModal" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="static">
    <div class="modal-dialog cs-lg-width" role="document">
        <div class="modal-content ">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">新增</h4>
            </div>
            <div class="modal-body cs-lg-height">
                <!-- 主题内容 -->
                <div class="cs-main">
                    <div class="cs-wraper">
                        <form action="${webRoot}/system/user/save" id="saveForm" method="post"
                              enctype="multipart/form-data">
                            <input type="hidden" name="id">
                            <input type="hidden" name="password">
                            <input type="hidden" name="signatureFile">
                            <input type="hidden" name="haveSignature" value="0">
                            <div width="100%" class="cs-add-new">
                                <ul class="cs-ul-form clearfix">
                                    <li class="cs-name col-xs-4 col-md-4"><i class="cs-mred">*</i>所属机构：</li>
                                    <li class="cs-in-style cs-modal-input">
                                        <div class="cs-all-ps">
                                            <div class="cs-input-box">
                                                <input type="hidden" class="sPointId" name="departId"/>
                                                <input type="text" name="departName" readonly="readonly"
                                                       class="sPointName cs-down-input" datatype="*"
                                                       nullmsg="请选择机构!" errormsg="请选择机构!"/>
                                                <div class="cs-down-arrow"></div>
                                            </div>
                                            <div id="divBtn" class="cs-check-down  cs-hide" style="display: none;">
                                                <ul id="tt" class="easyui-tree"></ul>
                                            </div>
                                        </div>
                                    </li>
                                    <li class="col-xs-4 col-md-4 cs-text-nowrap"></li>
                                </ul>

                                <ul class="cs-ul-form clearfix">
                                    <li class="cs-name col-xs-4 col-md-4"><i class="cs-mred">*</i>类型：</li>
                                    <li class="cs-al cs-modal-input">
                                        <input id="departUser" type="radio" value="0" name="userType"
                                               checked="checked"/><label for="departUser">机构</label>
                                        <input id="pointUser" type="radio" value="1" name="userType"/><label
                                            for="pointUser">检测点</label>
                                        <input id="regUser" type="radio" value="2" name="userType"/><label
                                            for="regUser">监管对象</label>
                                    </li>
                                </ul>

                                <ul class="cs-ul-form clearfix cs-hide" id="pointSelUl">
                                    <li class="cs-name col-xs-4 col-md-4"><i class="cs-mred">*</i>所属检测点：</li>
                                    <li class="cs-in-style cs-modal-input">
                                        <select class="js-select2-tags" name="pointId" id="point_select">
                                            <option value="">--请选择--</option>
                                        </select>
                                    </li>
                                </ul>

                                <ul class="cs-ul-form clearfix cs-hide" id="regSelUl">
                                    <li class="cs-name col-xs-4 col-md-4"><i class="cs-mred">*</i>所属监管对象：</li>
                                    <li class="cs-in-style cs-modal-input">
                                        <select class="js-select2-tags" name="regId" id="reg_select">
                                            <option value="">--请选择--</option>
                                        </select>
                                    </li>
                                </ul>
                                <ul class="cs-ul-form clearfix">
                                    <li class="cs-name col-xs-4 col-md-4" width="20% "><i class="cs-mred">*</i>用户名：</li>
                                    <li class="cs-in-style cs-modal-input" width="210px">
                                        <input type="text" value="" name="realname" class="inputxt" datatype="s2-18"
                                               nullmsg="请输入用户名" errormsg="请输入2-18位字符用户名" placeholder="请输入用户名" autocomplete="off"/></li>
                                    <li class="col-xs-4 col-md-4 cs-text-nowrap"></li>
                                </ul>
                                <ul class="cs-ul-form clearfix">
                                    <li class="cs-name col-xs-4 col-md-4" width="20% "><i class="cs-mred">*</i>登录账号：</li>
                                    <li class="cs-in-style cs-modal-input" width="210px">
                                        <input type="text" name="userName" id="userName" class="inputxt"
                                               datatype="s5-18" nullmsg="请输入登录账号" errormsg="请输入5-18位字符账号" placeholder="请输入登录账号" autocomplete="off"/>
                                    </li>
                                    <li class="col-xs-4 col-md-4 cs-text-nowrap"></li>
                                </ul>
                                <ul class="cs-ul-form clearfix">
                                    <li class="cs-name col-xs-4 col-md-4"><i class="cs-mred">*</i>密码：</li>
                                    <li class="cs-in-style cs-modal-input ui-pos-re">
                                        <input type="text" name="mpw1" class="inputxt checkPassword password" plugin="passwordStrength"
                                               datatype="pw" nullmsg="请输入8-16位字符密码" errormsg="请输入8-16位符合规则密码" placeholder="请输入新密码" autocomplete="off"/>
                                        <span class="iconfont icon-biyan pos-abs show-password" style="right: 10px"></span>
                                    </li>
                                    <li class="col-xs-4 col-md-4">
                                         <i class="iconfont icon-jinggao text-primary show-rule"></i>
                                        <div class="password-rule cs-hide"><i class="cs-mred">*</i>密码规则：包含字母大写、字母小写、数字、特殊字符的组合，密码长度应不少于8位</div>
                                    </li>
                                </ul>
                                <ul class="cs-ul-form clearfix">
                                    <li class="cs-name col-xs-4 col-md-4"><i class="cs-mred">*</i>确认密码：</li>
                                    <li class="cs-in-style cs-modal-input ui-pos-re">
                                        <input type="text" value="" name="mpw2" class="inputxt checkPassword password"
                                               recheck="mpw1" datatype="*" nullmsg="请确认密码" errormsg="两次输入的密码不一致" placeholder="请确认密码" autocomplete="off"/>
                                        <span class="iconfont icon-biyan pos-abs show-password" style="right: 10px"></span>
                                    </li>
                                    <li class="col-xs-4 col-md-4 cs-text-nowrap"></li>
                                </ul>
                                <ul class="cs-ul-form clearfix">
                                    <li class="cs-name col-xs-4 col-md-4"><i class="cs-mred">*</i>所属角色：</li>
                                    <li class="cs-in-style cs-modal-input">
                                        <select name="roleId" id="roleId">
                                            <c:forEach items="${roleList}" var="role">
                                                <option value="${role.id}">${role.rolename}</option>
                                            </c:forEach>
                                        </select>
                                    </li>
                                </ul>
                                <ul class="cs-ul-form clearfix cs-hide" id="signatureFileId">
                                    <li class="cs-name col-xs-4 col-md-4">签名文件：</li>
                                    <li class="cs-in-style cs-modal-input">
                                        <div style="width:200px;">
                                            <input type="file" id="myFile" name="signatureFilePath"/>
                                        </div>
                                    </li>
                                </ul>
                                <ul class="cs-ul-form clearfix">
                                    <li class="cs-name col-xs-4 col-md-4">排序：</li>
                                    <li class="cs-in-style cs-modal-input">
                                        <input type="text" value="" name="sorting" ignore="ignore" class="inputxt"
                                               datatype="n" nullmsg="请输入排序号"
                                               errormsg="请输入正确的排序号！"/>
                                    </li>
                                </ul>
                                <ul class="cs-ul-form clearfix">
                                    <li class="cs-name col-xs-4 col-md-4">状态：</li>
                                    <li class="cs-al cs-modal-input">
                                        <input id="cs-check-radio" type="radio" value="0" name="status"/><label
                                            for="cs-check-radio">启用</label>
                                        <input id="cs-check-radio2" type="radio" value="1" name="status"
                                               checked="checked"/><label
                                            for="cs-check-radio2">停用</label>
                                    </li>
                                </ul>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
            <div class="modal-footer action">
                <button type="submit" class="btn btn-success" id="btnSave">确定</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
            </div>
        </div>
    </div>
</div>
<!-- 用户新增/编辑模态框  end -->
<!-- 解除微信绑定模态框 start  -->
<div class="modal fade intro2" id="openid_confirm" tabindex="-1"
     role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog cs-alert-width">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"
                        aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <input type="hidden" name="id">
                <h4 class="modal-title"></h4>
            </div>
            <div class="modal-body cs-alert-height cs-dis-tab">
                <div class="cs-text-algin"></div>
            </div>
            <div class="modal-footer">
                <a class="btn btn-danger btn-ok" onclick="delwx();">确定</a>
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
            </div>
        </div>
    </div>
</div>
<!-- 解除微信绑定模态框 end  -->
<!-- 恢复已删除用户模态框 start  -->
<div class="modal fade intro2" id="recovery_confirm" tabindex="-1"
     role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog cs-alert-width">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"
                        aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <input type="hidden" name="id">
                <h4 class="modal-title">恢复已删除用户</h4>
            </div>
            <div class="modal-body cs-alert-height cs-dis-tab">
                <div class="cs-text-algin">
                    <img src="${webRoot}/img/warn.png" width="40px"/>
                    <span class="tips"></span>
                </div>
            </div>
            <div class="modal-footer">
                <a class="btn btn-danger btn-ok" onclick="recoveryUser();">确定</a>
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
            </div>
        </div>
    </div>
</div>
<!-- 恢复已删除用户模态框 end  -->

<!-- 修改备注 -->
<div class="modal fade intro2" id="remarkModal" tabindex="-1" role="dialog" aria-labelledby="remarkModalLabel">
    <div class="modal-dialog cs-lg-width" role="document">
        <div class="modal-content ">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="remarkModalLabel">修改备注</h4>
            </div>
            <div class="modal-body cs-lg-height">
                <div class="cs-tabcontent" >
                    <div class="cs-content2">
                        <form id="remarkForm" method="post">
                            <input type="hidden" name="id">
                            <table class="cs-add-new">
                                <tr>
                                    <td class="cs-name">登录名：</td>
                                    <td class="cs-in-style" colspan="2">
                                        <input type="text" name="userName" class="disabled-style" disabled="disabled" style="width: 500px;"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="cs-name">用户名：</td>
                                    <td class="cs-in-style" colspan="2">
                                        <input type="text" name="realname" class="disabled-style" disabled="disabled" style="width: 500px;"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="cs-name">所属机构：</td>
                                    <td class="cs-in-style" colspan="2">
                                        <input type="text" name="departName" class="disabled-style" disabled="disabled" style="width: 500px;"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="cs-name">所属检测点：</td>
                                    <td class="cs-in-style" colspan="2">
                                        <input type="text" name="pointName" class="disabled-style" disabled="disabled" style="width: 500px;"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="cs-name">备注：</td>
                                    <td class="cs-in-style" colspan="2">
                                        <textarea class="cs-remark" name="remark" cols="30" rows="10" maxlength="200" style="width: 500px;"></textarea>
                                    </td>
                                </tr>
                            </table>
                        </form>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-success" id="submitRemarkForm" onclick="submitRemark();">确定</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
            </div>
        </div>
    </div>
</div>

<%@include file="/WEB-INF/view/common/confirm.jsp" %>
<%@include file="/WEB-INF/view/common/modalBox.jsp"%>
<script src="${webRoot}/js/select/tabcomplete.min.js"></script>
<script src="${webRoot}/js/select/livefilter.min.js"></script>
<script src="${webRoot}/js/select/bootstrap-select.js"></script>
<script src="${webRoot}/js/datagridUtil2.js"></script>
<script src="${webRoot}/js/jquery.form.js"></script>
<script type="text/javascript">
    $('.show-password').click(function () {
        if ("********9_AAAAAA" == $(this).siblings('.inputxt').val()) {
            return false;
        }
        if($(this).hasClass('icon-yan')){
            $(this).addClass('icon-biyan').removeClass('icon-yan').siblings('.inputxt').addClass('password');
        }else{
            $(this).addClass('icon-yan').removeClass('icon-biyan').siblings('.inputxt').removeClass('password');
        }
    });

    //密码规则
    $('.show-rule').hover(function () {
        $('.password-rule').show();
    },function () {
        $('.password-rule').hide();
    });

    var jbstate = 1;
    var showSignatureFile = 0;//用户签名文件字段是否显示，默认：是，0_否，1_是，2_隐藏列
    var roleListJson = eval('${roleListJson}');

    $('.js-select2-tags').select2();

    //配置用户签名权限
    if (1 == Permission.exist("511-6")) {
        showSignatureFile = 1;
        $("#saveForm input[name=haveSignature]").val("1");
        $("#signatureFileId").removeClass("cs-hide");
        //上传控件初始化
        $("#myFile").fileinput({
            'theme': 'explorer',
            'uploadUrl': '#',
            textEncoding: 'UTF-8',
            language: 'zh',
            overwriteInitial: false,
            initialPreviewAsData: true,
            dropZoneEnabled: false,
            showClose: false,
            showPreview: false,
            maxFileCount: 1,
            browseLabel: '浏览'
        });
    }


    var dgu;
    //进入界面加载数据
    $(function () {
        dgu = datagridUtil.initOption({
            tableId: "dataList",
            tableAction: "${webRoot}/system/user/datagrid",
            tableBar: {
                title: ["用户管理", "用户信息"],
                hlSearchOff: 0,
                ele: [{
                    eleShow: Permission.exist("511-10"),
                    eleTitle: "用户状态",
                    eleName: "deleteFlag",
                    eleType: 2,
                    eleOption: [{"text":"--全部--","val":"-1"},{"text":"未删除","val":"0"},{"text":"已删除","val":"1"}],
                    eleStyle: "width:85px;margin-right: 10px;"
                },{
                    eleTitle: "用户类型",
                    eleName: "usetType",
                    eleType: 2,
                    eleOption: (Permission.exist("511-7") == 1 ? [{"text": "--全部--", "val": "1"}, {
                        "text": "机构",
                        "val": "2"
                    }, {"text": "检测点", "val": "3"}, {"text": "监管对象", "val": "4"}, {
                        "text": "检测车",
                        "val": "6"
                    }, {"text": "政府检测室", "val": "5"}, {"text": "企业检测室", "val": "7"}] : [{
                        "text": "--全部--",
                        "val": "1"
                    }, {"text": "机构", "val": "2"}, {"text": "检测点", "val": "3"}, {
                        "text": "检测车",
                        "val": "6"
                    }, {"text": "政府检测室", "val": "5"}, {"text": "企业检测室", "val": "7"}]),
                    eleStyle: "width:85px;"
                }, {
                    eleShow: Permission.exist("511-11"),
                    eleType: 4,
                    eleHtml: "<span class=\"check-date cs-fl\">" +
                    "<span class=\"cs-name\" style=\"padding-right: 0px;\">行政区：</span>" +
                    "<div class=\"cs-all-ps\">\n" +
                    "            <div class=\"cs-input-box\">\n" +
                    "                <input type=\"text\" name=\"departNames\" autocomplete=\"off\">\n" +
                    "                <div class=\"cs-down-arrow\"></div>\n" +
                    "            </div>\n" +
                    "            <div class=\"cs-check-down cs-hide\" style=\"display: none;\">\n" +
                    "                <ul id=\"tree\" class=\"easyui-tree\"></ul>\n" +
                    "            </div>\n" +
                    "        </div>" +
                    "</span>"
                }, {
                    eleShow: 1,
                    eleName: "keyWords",
                    eleType: 0,
                    elePlaceholder: "用户名、机构、检测点、监管对象"
                }],
                topBtns: [{
                    show: Permission.exist("511-1"),
                    style: Permission.getPermission("511-1"),
                    action: function (ids, rows) {
                        getId();
                    }
                }],
                init: function () {
                    //选择行政区
                    $('#tree').tree({
                        checkbox: false,
                        url: "${webRoot}/detect/depart/getDepartTree.do",
                        animate: true,
                        onLoadSuccess: function (node, data) {
                            if (data.length > 0) {
                                $("input[name='departNames']").val(data[0].text);
                            }
                        },
                        onClick: function (node) {
                            var did = node.id;
                            $("input[name='departNames']").val(node.text);
                            $(".cs-check-down").hide();

                            dgu.addDefaultCondition("departId", did);
                            dgu.queryByFocus();
                        }
                    });
                }
            },
            parameter: [
                {
                    columnCode: "departName",
                    columnName: "所属机构"
                },
                {
                    columnCode: "pointName",
                    columnName: "所属检测点"
                },
                {
                    show: Permission.exist("511-7"),
                    columnCode: "regName",
                    columnName: "所属监管对象"
                },
                {
                    columnCode: "userName",
                    columnName: "登录名",
                    customStyle: 'user_name',
                    columnWidth: "120px"
                },
                {
                    columnCode: "realname",
                    columnName: "用户名",
                    columnWidth: "150px"
                },
                {
                    columnCode: "rolename",
                    columnName: "用户角色",
                    columnWidth: "120px"
                },
                {
                    show: Permission.exist("511-12"),
                    columnCode: "nickName",
                    columnName: "昵称"
                },
                {
                    show: Permission.exist("511-13"),
                    columnCode: "remark",
                    columnName: "备注",
                    hideOverText: 1,
                    tdTitle: '?',
                    customVal: {
                        "is-null":"<i class=\"icon iconfont icon-kaohejilu\" onclick=\"editRemark(\'#id#\')\"></i>",
                        "non-null":"<a class=\"text-primary cs-link reloadCount\" onclick=\"editRemark(\'#id#\')\">?</a>"
                    },
                    columnWidth: "100px"
                },
                {
                    columnCode: "signatureFile",
                    columnName: "签名文件",
                    columnWidth: "80px",
                    show: showSignatureFile,
                    customStyle: 'container',
                    customVal: {"non-null": "<b mYhref=\"${resourcesUrl}/?\" ><i class=\"icon iconfont icon-qian\"></i></b>"}
                },
                {
                    columnCode: "loginCount",
                    columnName: "登录",
                    customElement: Permission.exist("511-9") ? "<a class='text-primary cs-link loginCount'>?<a>" : '',
                    sortDataType: "int",
                    columnWidth: "60px"
                },
                {
                    columnCode: "status",
                    columnName: "状态",
                    customVal: {0: "<span class='text-success' title='#updateBy#,#updateDate#'>启用</span>", 1: "<span class='text-danger' title='#updateBy#,#updateDate#'>停用</span>"},
                    columnWidth: '60px'
                }
            ],
            funBtns: [
                { //微信解绑
                    show: Permission.exist("511-8"),
                    style: Permission.getPermission("511-8"),
                    action: function (id) {
                        jbstate = 1;
                        var currentTr = $("tr[data-rowid='" + id + "']");//拿到所选行的TR对象
                        var userName = currentTr.find(".user_name").text();
                        $("#openid_confirm input[name=id]").val(id);
                        $("#openid_confirm .modal-title").text("解除绑定");
                        $("#openid_confirm .cs-text-algin").html('<img src="${webRoot}/img/stop2.png" width="40px"/><p>用户信息（' + userName + '）</p><span class="tips">确定解除该用户微信绑定？</span>');
                        $("#openid_confirm .modal-footer").html(' <a class="btn btn-danger btn-ok" onclick="delopenid(\'' + userName + '\');">确定</a><button type="button" class="btn btn-default" data-dismiss="modal">取消</button>');
                        $("#openid_confirm").modal('show');
                    }
                },
                {
                    show: Permission.exist("511-2"),
                    style: Permission.getPermission("511-2"),
                    action: function (id, row) {
                        $("#myModal").modal("show");
                        let haveRoleId = false;
                        if (roleListJson&&roleListJson.length) {
                            for(let i = 0;i<roleListJson.length;i++){
                                if(roleListJson[i].id==row.roleId){
                                    haveRoleId = true;
                                }
                            }
                        }
                        if(!haveRoleId&&row.roleId){
                            $("#roleId").prepend('<option class="add_option" value="'+row.roleId+'">'+row.rolename+'</option>');
                        }
                        getId(id);
                    }
                },
                {
                    show: Permission.exist("511-3"),
                    style: Permission.getPermission("511-3"),
                    action: function (id, row) {
                        idsStr = "{\"ids\":\"" + id.toString() + "\"}";
                        $("#confirm-delete").modal('toggle');
                    }
                },
                {
                    show: Permission.exist("511-5"),
                    style: Permission.getPermission("511-5"),
                    action: function (id, row) {
                        unlock(row.userName);
                    }
                },
                {//恢复已删除用户权限：对于已经删除的用户进行恢复操作
                    show: Permission.exist("511-10"),
                    style: Permission.getPermission("511-10"),
                    action: function (id, row) {
                        recoveryId=id;
                        $("#recovery_confirm .tips").text("确定要恢复【"+row.realname+"】用户吗？");
                        $("#recovery_confirm").modal('toggle');
                    }
                }
            ],	//功能按钮
            bottomBtns: [
                {	//删除函数
                    show: Permission.exist("511-3"),
                    style: Permission.getPermission("511-3"),
                    action: function (ids) {
                        if(ids == ''){
                            $("#confirm-warnning .tips").text("请选择要删除的用户");
                            $("#confirm-warnning").modal('toggle');
                        }else {
                            idsStr = "{\"ids\":\"" + ids.toString() + "\"}";
                            $("#confirm-delete").modal('toggle');
                        }
                    }
                }
            ],
            before: function (rows, pageData) {
                var ut = $("#dataList select[name='usetType']").val();
                switch (ut) {
                    case "2":   //机构
                        dgu.datagridOption.parameter[0].show = 1;
                        dgu.datagridOption.parameter[1].show = 0;
                        dgu.datagridOption.parameter[2].show = 0;
                        break;
                    case "3":
                    case "5":
                    case "6":
                    case "7":   //检测室
                        // case "3","5","6","7":   //检测室
                        dgu.datagridOption.parameter[0].show = 1;
                        dgu.datagridOption.parameter[1].show = 1;
                        dgu.datagridOption.parameter[2].show = 0;
                        break;
                    case "4":   //监管对象
                        dgu.datagridOption.parameter[0].show = 1;
                        dgu.datagridOption.parameter[1].show = 0;
                        dgu.datagridOption.parameter[2].show = 1;
                        break;
                    default:    //全部
                        dgu.datagridOption.parameter[0].show = 1;
                        dgu.datagridOption.parameter[1].show = 1;
                        dgu.datagridOption.parameter[2].show = Permission.exist("511-7");
                        break;
                }
            },
            onload: function (rows, pageData) {
                pic();
                if (rows) {
                    for (var i = 0; i < rows.length; i++) {
                        var $td= $("tr[data-rowid=" + rows[i].id + "]");
                        //隐藏解绑按钮
                        if (rows[i].wxOpenid == null || rows[i].wxOpenid == "") {
                            $("tr[data-rowid=" + rows[i].id + "]").find(".icon-guanlian1").addClass('hide');
                            $("tr[data-rowid=" + rows[i].id + "]").find(".511-8").addClass('hide');
                        }
                        if (rows[i].deleteFlag==1) {//用户已删除，隐藏编辑、删除等操作按钮
                            //编辑，删除、导出、解除锁定、解绑
                            $td.find(".511-2").addClass('hide');
                            $td.find(".511-3").addClass('hide');
                            $td.find(".511-4").addClass('hide');
                            $td.find(".511-5").addClass('hide');
                            $td.find(".511-8").addClass('hide');

                            //修改状态信息
                            $("tr[data-rowid=" + rows[i].id + "] .datagrid_status").html("<span class='text-danger' title='"+rows[i].updateBy+","+rows[i].updateDate+"'>已删除</span>");
                        }else{//用户未删除，隐藏“恢复用户”操作按钮
                            $td.find(".511-10").addClass('hide');
                        }
                    }
                }
            }
        });
        setTimeout(function () {
            dgu.queryByFocus();
        }, 200);
    });

    $(function () {
        var saveForm = $("#saveForm").Validform({
            tiptype: 2,
            beforeSubmit: function () {
                if ($("input[name=mpw1]").val() != "********9_AAAAAA") {
                    $("input[name=password]").val(md5($("input[name=mpw1]").val()).toLocaleUpperCase());
                }

                $("#saveForm input[name='mpw1']").attr("disabled","disabled");
                $("#saveForm input[name='mpw2']").attr("disabled","disabled");

                if ($(".file-caption-name").val() == "") {
                    $("input[name=signatureFile]").val("");
                }
                $("#btnSave").attr("disabled", "disabled");
                $("#saveForm").ajaxSubmit({
                    type: 'post',
                    url: "${webRoot}/system/user/save",
                    success: function (data) {
                        if (data.success) {
                            $("#myModal").modal("hide");
                            dgu.query();
                        } else {
                            $("#waringMsg>span").html(data.msg);
                            $("#confirm-warnning").modal('toggle');
                            $("#btnSave").removeAttr("disabled");
                        }
                    },
                    complete: function(){
                        $("#saveForm input[name='mpw1']").removeAttr("disabled");
                        $("#saveForm input[name='mpw2']").removeAttr("disabled");
                    }
                });
                return false;
            }
        });
        // 新增或修改
        $("#btnSave").on("click", function () {
            $("#saveForm").submit();
        });
        //关闭编辑模态框前重置表单，清空隐藏域
        $('#myModal').on('hidden.bs.modal', function (e) {
            $("#btnSave").removeAttr("disabled");
            saveForm.resetForm();
            $("input[name=id]").val("");
            $("input[name=password]").val("");
            $("input[name=departId]").val("");
            $("option[class='add_option']").remove();

            $('.show-password').each(function (ele, index) {
                $(this).addClass('icon-biyan').removeClass('icon-yan').siblings('.inputxt').addClass('password');
            });
        });
        $("#myModal").on('show.bs.modal', function (e) {
            saveForm.resetForm();
            $("#point_select").empty();
            $("#point_select").append('<option value="">-未选择-</option>');
        });
        $("#tt").tree({
            checkbox: false,
            //url:"${webRoot}/detect/depart/getDepartTree.do?pid=${org.departPid}",
            url: "${webRoot}/detect/depart/getDepartTree.do",
            animate: true,
            lines: false,
            onClick: function (node) {
                $(".sPointId").val(node.id);
                $(".sPointName").val(node.text);
                $(".cs-check-down").hide();
                setTimeout(function () {
                    // queryPoint(node.id);
                    // queryReg(node.id);
                    $("#myModal input[name='userType']").trigger("change");
                }, 100);
            }
        });
        //修改类型
        $("input[name='userType']").on("change", function () {
            selUserType($("input[name='userType']:checked").val());
        });
    });

    /**
     *修改用户类型
     */
    function selUserType(userTypeCode) {

        if (!userTypeCode || userTypeCode == '0') {
            //机构用户或userTypeCode为空时，修改类型为机构，隐藏清空所属检测点和所属监管对象选项
            $("input[name='userType']:eq(0)").prop("checked", 'checked');
            $("#regSelUl").hide();
            $("#reg_select").val("");
            $("#pointSelUl").hide();
            $("#point_select").val("");
        } else if (userTypeCode == '1') {
            //检测点用户
            $("input[name='userType']:eq(1)").prop("checked", 'checked');
            $("#pointSelUl").show();
            $("#regSelUl").hide();
            $("#reg_select").val("");
            queryPoint($("#myModal input[name='departId']").val());
        } else if (userTypeCode == '2') {
            //监管对象用户
            $("input[name='userType']:eq(2)").prop("checked", 'checked');
            $("#regSelUl").show();
            $("#pointSelUl").hide();
            $("#point_select").val("");
            queryReg($("#myModal input[name='departId']").val());
        }
    }

    function queryPoint(e) {
        var id = e;
        $("#point_select").empty();
        $.ajax({
            url: "${webRoot}/system/user/getPoint.do",
            type: "POST",
            data: {"id": id},
            dataType: "json",
            async: false,
            success: function (data) {
                var list = data.obj;
                $("#point_select").append('<option value="">-未选择-</option>');
                for (var i in list) {
                    $("#point_select").append('<option value="' + list[i].id + '">' + list[i].pointName + '</option>');
                }
            },
            error: function () {
                $.Showmsg("操作失败");
            }
        });
    }

    function queryReg(e) {
        var id = e;
        $("#reg_select").empty();
        $.ajax({
            url: "${webRoot}/regulatory/regulatoryObject/queryCheckedReg.do",
            type: "POST",
            data: {"departId": id},
            dataType: "json",
            async: false,
            success: function (data) {
                var list = data.obj;
                $("#reg_select").append('<option value="">-未选择-</option>');
                for (var i in list) {
                    $("#reg_select").append('<option value="' + list[i].id + '">' + list[i].regName + '</option>');
                }
            },
            error: function () {
                $.Showmsg("操作失败");
            }
        });
    }

    /**
     * 查询用户信息
     */
    function getId(userId) {
        if (userId) {
            $.ajax({
                url: "${webRoot}/system/user/queryById.do",
                type: "POST",
                data: {"id": userId},
                dataType: "json",
                success: function (data) {
                    var form = $('#saveForm');
                    queryPoint(data.obj.departId);
                    queryReg(data.obj.departId);
                    setTimeout(function () {
                        form.form('load', data.obj);
                        //设置用户类型
                        if (data.obj.pointId) {
                            selUserType('1');	//检测点
                            $("#point_select").select2('val', data.obj.pointId);
                        } else if (data.obj.regId) {
                            selUserType('2');	//监管对象
                            $("#reg_select").select2('val', data.obj.regId);
                        } else {
                            selUserType('0');	//机构
                        }
                        $("[name=checked][value=" + data.obj.checked + "]").prop("checked", "checked");
                        // $("input[name=password]").val(data.obj.password);
                        $("input[name=password]").val("");
                        $("input[name=mpw1]").val("********9_AAAAAA");
                        $("input[name=mpw2]").val("********9_AAAAAA");
                        //设置签名文件
                        if (showSignatureFile == 1 && !$("#signatureFileId").hasClass("cs-hide")) {
                            data.obj.signatureFile = data.obj.signatureFile == '' ? "" : data.obj.signatureFile.substring(data.obj.signatureFile.lastIndexOf("/") + 1, data.obj.signatureFile.length);
                            $(".file-caption-name").val(data.obj.signatureFile);
                        }
                    }, 500);
                }
            });
            $("#myModal .modal-title").text("编辑");

        } else {
            selUserType();
            $("#myModal .modal-title").text("新增");
        }
        $("#myModal").modal("show");

    }

    function deleteData() {
        $.ajax({
            type: "POST",
            url: "${webRoot}/system/user/delete.do",
            data: JSON.parse(idsStr),
            dataType: "json",
            success: function (data) {
                $("#confirm-delete").modal('toggle');
                if (data && data.success) {
                    //删除成功后刷新列表
                    dgu.queryByFocus();
                } else {
                    $("#waringMsg>span").html(data.msg);
                    $("#confirm-warnning").modal('toggle');
                }
            }
        });
    }

    /**
     * 打开备注编辑窗口
     */
    function editRemark(id) {
        if (id) {
            var rows = dgu.getData();
            if (rows) {
                for (var i = 0; i < rows.length; i++) {
                    if (rows[i].id == id) {
                        $("#remarkForm input[name=id]").val(rows[i].id);
                        $("#remarkForm input[name=departName]").val(rows[i].departName);
                        $("#remarkForm input[name=pointName]").val(rows[i].pointName);
                        $("#remarkForm input[name=userName]").val(rows[i].userName);
                        $("#remarkForm input[name=realname]").val(rows[i].realname);
                        $("#remarkForm textarea[name=remark]").val(rows[i].remark);
                        $("#remarkModal").modal('show');
                    }
                }
            }
        }
    }
    /**
     * 提交修改的备注
     */
    function submitRemark(id) {
        $("#submitRemarkForm").attr("disabled", "disabled");
        $.ajax({
            url: "${webRoot}/system/user/editRemark",
            type: "POST",
            data: {"id": $("#remarkForm input[name=id]").val(), "remark": $("#remarkForm textarea[name=remark]").val()},
            dataType: "json",
            success: function (data) {
                if (data && data.success) {
                    dgu.queryByFocus();
                    $("#remarkModal").modal('hide');
                } else {
                    $.Showmsg(data.msg);
                }
            },
            error: function () {
                $.Showmsg("操作失败");
            },
            complete: function () {
                $("#submitRemarkForm").removeAttr("disabled");
            }
        });
    }



    /**
     * 解除锁定
     */
    function unlock(username) {
        $.ajax({
            type: "POST",
            url: "${webRoot}/system/user/unlock",
            data: {"username": username},
            dataType: "json",
            success: function (data) {
                if (data && data.success) {
                    $("#tips-success").modal('toggle');
                } else {
                    $("#confirm-warnning").modal('toggle');
                }
            }
        });
    }

    //查看用户签名
    function pic() {
        $(".container b").hover(function () {
            var tImg = $(this).attr('myHref');
            $(this).append("<p id='pic'><img src='" + tImg + "' id='pic1'></p>");
            $(".container b").mousemove(function (e) {
                $("#pic").css({"top": (e.pageY - 23) + "px", "left": (e.pageX + 4) + "px"}).fadeIn("fast");
            });
        }, function () {
            $("#pic").remove();
        });
    }


    //微信解绑
    function delopenid(userName) {
        if (jbstate == 1) {
            $("#openid_confirm .cs-text-algin").html('<img src="${webRoot}/img/warn.png" width="40px" alt=""/><p>用户信息（' + userName + '）</p><span class="tips">解绑后需重新绑定才能登录！</span>');
            jbstate = 2;
        } else {
            var id = $("#openid_confirm input[name=id]").val();
            if (id == null || id == "") {
                $("#openid_confirm .modal-title").text("提示");
                $("#openid_confirm .cs-text-algin").html('<img src="${webRoot}/img/warn.png" width="40px" alt=""/> <span class="tips" id="waringMsg">用户ID不能为空</span>');
                $("#openid_confirm .modal-footer").html('<a class="btn btn-primary btn-ok" data-dismiss="modal">关闭</a>');
                return;
            }
            $.ajax({
                type: "POST",
                url: "${webRoot}/system/user/del_openid",
                data: {id: id},
                dataType: "json",
                success: function (data) {
                    if (data.success) {
                        $("#openid_confirm").modal("hide");
                        layer.ready(function () {
                            layer.msg('解绑成功', {
                                icon: 1
                            });
                        });
                        dgu.queryByFocus();
                    } else {
                        $("#openid_confirm .modal-title").text("提示");
                        $("#openid_confirm .cs-text-algin").html('<img src="${webRoot}/img/warn.png" width="40px" alt=""/> <span class="tips" id="waringMsg">' + data.msg + '</span>');
                        $("#openid_confirm .modal-footer").html('<a class="btn btn-primary btn-ok" data-dismiss="modal">关闭</a>');
                    }
                }
            })
        }
    }

    //去除字符串中的中文字符
    function limitHalfSize(value) {
        if (value == "") {
            return "";
        } else {
            var c = "";
            for (var i = 0; i < value.length; i++) {
                c = value.charCodeAt(i);
                if (!(c >= 0x0020 && c < 0x007f) || (c >= 0xff61 && c <= 0xff9f)) {
                    return value.substr(0, i);
                }
            }
            return value;
        }
    }

    //去除密码中的中文字符
    $(document).on('input propertychange', 'input[name=mpw2], input[name=mpw1]', function(){
        $(this).val(limitHalfSize($(this).val()));
    });
    //修改原密码，清空输入框
    $(document).on('keydown', 'input[name=mpw2], input[name=mpw1]', function(){
        //编辑原密码前，自动清空输入框
        if ("********9_AAAAAA" == $(this).val()) {
            $("input[name=mpw2], input[name=mpw1]").val("");
            // $(this).val("");
        }
    });
    //查看登录日志
    $(document).on("click",".loginCount",function(){
        let userName=$(this).parents(".rowTr").find(".user_name").html();
        let returnURL=encodeURI("${webRoot}/sysLog/list.do?userName="+userName);
        showMbIframe(returnURL);
    });
    function recoveryUser(){
        $.ajax({
            type: "POST",
            url: "${webRoot}/system/user/recoveryUser.do",
            data: {"id":recoveryId},
            dataType: "json",
            success: function (data) {
                $("#recovery_confirm").modal('toggle');
                if (data && data.success) {
                    //删除成功后刷新列表
                    dgu.queryByFocus();
                } else {
                    $("#waringMsg>span").html(data.msg);
                    $("#confirm-warnning").modal('toggle');
                }
            }
        });
    }
</script>
</body>
</html>
