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
<div id="dataList"></div>
<!-- 用户新增/编辑模态框 start-->
<div class="modal fade intro2" id="myModal" role="dialog" aria-labelledby="myModalLabel">
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
                        <form id="userForm" method="post"
                              enctype="multipart/form-data" autocomplete="off">
                            <input type="hidden" name="id">
                            <input type="hidden" name="password">
                            <input type="hidden" name="oldPassword">
                            <input type="hidden" name="signatureFile">
                            <input type="hidden" name="haveSignature" value="0">
                            <input type="hidden" class="sPointId" name="departId" value="${departId}"/>
                            <div width="100%" class="cs-add-new">
                                <ul class="cs-ul-form clearfix">
                                    <li class="cs-name col-xs-4 col-md-4" width="20% ">所属企业：</li>
                                    <li class="cs-in-style cs-modal-input" width="210px">
                                        ${departName}
                                    </li>
                                </ul>
                                <ul class="cs-ul-form clearfix">
                                    <li class="cs-name col-xs-4 col-md-4">用户类型：</li>
                                    <li class="cs-al cs-modal-input">
                                        <input type="hidden" name="pointId">
                                        <input type="hidden" name="regId">
                                        <input id="departUser" type="radio" value="2" name="userType"
                                               checked="checked"/><label for="departUser">监管人员</label>
                                        <input id="pointUser" type="radio" value="1" name="userType"/><label
                                            for="pointUser">检测人员</label>
                                    </li>
                                </ul>
                                <%--<ul class="cs-ul-form clearfix cs-hide" id="pointSelUl">
                                    <li class="cs-name col-xs-4 col-md-4">所属检测点：</li>
                                    <li class="cs-in-style cs-modal-input">
                                        <select class="js-select2-tags" name="pointId" id="point_select">
                                            <option value="">--请选择--</option>
                                        </select>
                                    </li>
                                </ul>--%>

                                <%--<ul class="cs-ul-form clearfix cs-hide" id="regSelUl">
                                    <li class="cs-name col-xs-4 col-md-4">所属监管对象：</li>
                                    <li class="cs-in-style cs-modal-input">
                                        <select class="js-select2-tags" name="regId" id="reg_select">
                                            <option value="">--请选择--</option>
                                        </select>
                                    </li>
                                </ul>--%>

                                <ul class="cs-ul-form clearfix">
                                    <li class="cs-name col-xs-4 col-md-4" width="20% ">用户名：</li>
                                    <li class="cs-in-style cs-modal-input" width="210px">
                                        <input type="text" value="" name="realname" class="inputxt" datatype="s2-18"
                                               nullmsg="请输入用户名！"
                                               errormsg="昵称至少2个字符,最多18个字符！"/></li>
                                    <li class="col-xs-4 col-md-4 cs-text-nowrap">
                                        <div class="Validform_checktip"></div>
                                        <div class="info"><i class="cs-mred">*</i>用户名至少2-18个字符
                                        </div>
                                    </li>
                                </ul>
                                <ul style="display: none;">
                                    <input type="text" name="username" placeholder="用来隐藏浏览器默认显示的账号和密码">
                                    <input type="password">
                                </ul>
                                <ul class="cs-ul-form clearfix">
                                    <li class="cs-name col-xs-4 col-md-4" width="20% ">登录账号：</li>
                                    <li class="cs-in-style cs-modal-input" width="210px">
                                        <input type="text" name="userName" class="inputxt"
                                               datatype="s5-18" nullmsg="请输入登录账号！"
                                               errormsg="昵称至少5个字符,最多18个字符！"/></li>
                                    <li class="col-xs-4 col-md-4 cs-text-nowrap">
                                        <div class="Validform_checktip"></div>
                                        <div class="info"><i class="cs-mred">*</i>登录账号至少5-18个字符
                                        </div>
                                    </li>
                                </ul>


                                <ul class="cs-ul-form clearfix">
                                    <li class="cs-name col-xs-4 col-md-4"><i class="cs-mred">*</i>密码：</li>
                                    <li class="cs-in-style cs-modal-input ui-pos-re">
                                        <input type="text" name="mpw1" class="inputxt checkPassword password"
                                               plugin="passwordStrength"
                                               datatype="pw" nullmsg="请输入8-16位字符密码" errormsg="请输入8-16位符合规则密码"
                                               placeholder="请输入新密码" autocomplete="off"/>
                                        <span class="iconfont icon-biyan pos-abs show-password"
                                              style="right: 10px"></span>
                                    </li>
                                    <li class="col-xs-4 col-md-4">
                                        <i class="iconfont icon-jinggao text-primary show-rule"></i>
                                        <div class="password-rule cs-hide"><i class="cs-mred">*</i>密码规则：包含字母大写、字母小写、数字、特殊字符的组合，密码长度应不少于8位
                                        </div>
                                    </li>
                                </ul>
                                <ul class="cs-ul-form clearfix">
                                    <li class="cs-name col-xs-4 col-md-4"><i class="cs-mred">*</i>确认密码：</li>
                                    <li class="cs-in-style cs-modal-input ui-pos-re">
                                        <input type="text" value="" name="mpw2" class="inputxt checkPassword password"
                                               recheck="mpw1" datatype="*" nullmsg="请确认密码" errormsg="两次输入的密码不一致"
                                               placeholder="请确认密码" autocomplete="off"/>
                                        <span class="iconfont icon-biyan pos-abs show-password"
                                              style="right: 10px"></span>
                                    </li>
                                    <li class="col-xs-4 col-md-4 cs-text-nowrap"></li>
                                </ul>
                                <ul class="cs-ul-form clearfix">
                                    <li class="cs-name col-xs-4 col-md-4">所属角色：</li>
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
                                <ul class="cs-ul-form clearfix show_sorting hide">
                                    <li class="cs-name col-xs-4 col-md-4">排序：</li>
                                    <li class="cs-in-style cs-modal-input">
                                        <input type="text" name="sorting" id="sorting" ignore="ignore"
                                               onkeyup="clearNoNum2(this)" onblur="clearNoNum2(this)"/>
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
<%@include file="/WEB-INF/view/common/confirm.jsp" %>
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
        if ($(this).hasClass('icon-yan')) {
            $(this).addClass('icon-biyan').removeClass('icon-yan').siblings('.inputxt').addClass('password');
        } else {
            $(this).addClass('icon-yan').removeClass('icon-biyan').siblings('.inputxt').removeClass('password');
        }
    });

    //密码规则
    $('.show-rule').hover(function () {
        $('.password-rule').show();
    }, function () {
        $('.password-rule').hide();
    });


    var jbstate = 1;
    var showSignatureFile = 0;//用户签名文件字段是否显示，默认：是，0_否，1_是，2_隐藏列
    var roleListJson = eval('${roleListJson}');

    var getInfoObj = function () {
        return $(this).parents("li").next().find(".info");
    }

    //配置用户签名权限
    /*    if (1 == Permission.exist("511-6")) {
            showSignatureFile = 1;
            $("#userForm input[name=haveSignature]").val("1");
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
        }*/

    //进入界面加载数据
    $(function () {
        var dgu = datagridUtil.initOption({
            tableId: "dataList",
            tableAction: "${webRoot}/depart/manage/user_datagrid",
            funColumnWidth: "100px",
            defaultCondition: [{			//附加请求参数
                queryCode: "departId", 				//参数名
                queryVal: "${departId}"						//参数值
            }],
            tableBar: {
                title: ["企业管理", "用户信息", "${departName}"],
                hlSearchOff: 0,
                ele: [{
                    eleShow: 0,
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
                    elePlaceholder: "登录名、用户名、检测点"
                }, {
                    eleShow: Permission.exist("511-1") ? 0 : 1,
                    eleType: 4,
                    eleHtml: '<a href="javascript:;" onclick="window.parent.closeMbIframe();" class="cs-menu-btn fanhui"><i class="icon iconfont icon-fanhui"></i>返回</a>'
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
                    columnName: "所属企业",

                },
                {
                    columnCode: "pointName",
                    columnName: "所属检测点",
                    columnWidth: "13%",
                },
                {
                    show: Permission.exist("511-7"),
                    columnCode: "regName",
                    columnName: "所属监管对象",
                    columnWidth: "10%",
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
                    columnWidth: "12%",
                },
                {
                    columnCode: "rolename",
                    columnName: "用户角色",
                    columnWidth: "10%",
                },
                {
                    columnCode: "nickName",
                    columnName: "微信昵称",
                    columnWidth: "10%",
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
                    columnName: "次数",
                    sortDataType: "int",
                    columnWidth: "100px",
                },
                {
                    columnCode: "status",
                    columnName: "状态",
                    columnWidth: "5%",
                    customVal: {0: "<span class='text-success'>启用</span>", 1: "<span class='text-danger'>停用</span>"}
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
                        if (roleListJson && roleListJson.length) {
                            for (let i = 0; i < roleListJson.length; i++) {
                                if (roleListJson[i].id == row.roleId) {
                                    haveRoleId = true;
                                }
                            }
                        }
                        if (!haveRoleId && row.roleId) {
                            $("#roleId").prepend('<option class="add_option" value="' + row.roleId + '">' + row.rolename + '</option>');
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
                }
            ],	//功能按钮
            bottomBtns: [
                {	//删除函数
                    show: Permission.exist("511-3"),
                    style: Permission.getPermission("511-3"),
                    action: function (ids) {
                        idsStr = "{\"ids\":\"" + ids.toString() + "\"}";
                        $("#confirm-delete").modal('toggle');
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
                        //隐藏解绑按钮
                        if (rows[i].wxOpenid == null || rows[i].wxOpenid == "") {
                            $("tr[data-rowid=" + rows[i].id + "]").find(".icon-guanlian1").addClass('hide');
                        }
                    }
                }
                if (rows) {
                    if (!$(".fanhui").text()) {
                        $(".icon-zengjia").closest("div").append('<a href="javascript:;" onclick="window.parent.closeMbIframe(1);" class="cs-menu-btn fanhui"><i class="icon iconfont icon-fanhui"></i>返回</a>')
                    }
                }
            }
        });
        setTimeout(function () {
            dgu.queryByFocus();
        }, 200);
    });

    $("[datatype]").focusin(function () {
        if (this.timeout) {
            clearTimeout(this.timeout);
        }
        var infoObj = getInfoObj.call(this);
        if (infoObj.siblings(".Validform_right").length != 0) {
            return;
        }
        infoObj.show().siblings().hide();

    }).focusout(function () {
        var infoObj = getInfoObj.call(this);
        this.timeout = setTimeout(function () {
            infoObj.hide().siblings(".Validform_wrong,.Validform_loading").show();
        }, 0);

    });
    $(function () {
        var userForm = $("#userForm").Validform({
            tiptype: 2,
            usePlugin: {
                passwordstrength: {
                    minLen: 6,
                    maxLen: 18,
                    trigger: function (obj, error) {
                        if (error) {
                            obj.parent().next().find(".passwordStrength").hide().siblings(".info").show();
                        } else {
                            obj.removeClass("Validform_error").parent().next().find(".passwordStrength").show().siblings().hide();
                        }
                    }
                }
            },
            beforeSubmit: function (curform) {//判断密码是否被修改过；若没有则设置密码为空不进行修改
                if ($(".file-caption-name").val() == "") {
                    $("input[name=signatureFile]").val("");
                }

                let userType = $("input[name='userType']:checked").val();
                //如果旧的类型和当前提交的类型一致那就不做改变
                if (userType != oldType) {
                    //判断是选择了检测点还是监管对象，把不被选择的一方置空
                    if (userType == 2) {
                        $("input[name='regId']").val("${regId}");
                        $("input[name='pointId']").val("");
                    } else {
                        $("input[name='regId']").val("");
                        $("input[name='pointId']").val("${pointId}");
                    }
                }

                if (userType == 1) {
                    if ("${pointId}" == "") {
                        $("#waringMsg>span").html("请先给企业添加检测点");
                        $("#confirm-warnning").modal('toggle');
                        $("#btnSave").removeAttr("disabled");
                        return false;
                    }
                } else if (userType == 2) {
                    if ("${regId}" == "") {
                        $("#waringMsg>span").html("请先给企业添加监管对象");
                        $("#confirm-warnning").modal('toggle');
                        $("#btnSave").removeAttr("disabled");
                        return false;
                    }
                }

                if ($("input[name=mpw1]").val() != "********9_AAAAAA") {
                    $("input[name=password]").val(md5($("input[name=mpw1]").val()).toLocaleUpperCase());
                }

                $("#userForm input[name='mpw1']").attr("disabled", "disabled");
                $("#userForm input[name='mpw2']").attr("disabled", "disabled");

                $("#btnSave").attr("disabled", "disabled");

                $("#userForm").ajaxSubmit({
                    type: 'post',
                    url: "${webRoot}/system/user/save",
                    success: function (data) {
                        if (data.success) {
                            $("#myModal").modal("hide");
                            datagridUtil.query();
                        } else {
                            $("#waringMsg>span").html(data.msg);
                            $("#confirm-warnning").modal('toggle');
                            $("#btnSave").removeAttr("disabled");
                            //编辑的时候如果报错，那就重新设置regId和pointId为编辑的用户的对应ID
                            if ($("input[name=id]").val()) {
                                $("input[name='regId']").val(oldRegId);
                                $("input[name='pointId']").val(oldPointId);
                            }
                        }
                    },
                    complete: function () {
                        $("#userForm input[name='mpw1']").removeAttr("disabled");
                        $("#userForm input[name='mpw2']").removeAttr("disabled");
                    }
                });
                return false;
            }
        });
        // 新增或修改
        $("#btnSave").on("click", function () {
            $("#userForm").submit();
        });
        //关闭编辑模态框前重置表单，清空隐藏域
        $('#myModal').on('hidden.bs.modal', function (e) {
            $("#btnSave").removeAttr("disabled");
            $("#userForm").Validform().resetForm();
            $("input[name=id]").val("");
            $("input[name=sorting]").val("");
            $("input[name=password]").val("");
            $("option[class='add_option']").remove();
            oldType = -1;
            $('.show-password').each(function (ele, index) {
                $(this).addClass('icon-biyan').removeClass('icon-yan').siblings('.inputxt').addClass('password');
            });
        });
        $("#myModal").on('show.bs.modal', function (e) {
            $("#userForm").Validform().resetForm();
            // $("input").removeClass("Validform_error");
            // $(".Validform_wrong").hide();
            // $(".Validform_checktip").hide();
            // $(".passwordStrength").hide();
            // $(".info").show();
        });
    });

    let oldType = -1;
    let oldRegId;
    let oldPointId;

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
                    $(".info").hide();
                    var form = $('#userForm');
                    setTimeout(function () {
                        form.form('load', data.obj);
                        //设置用户类型
                        if (data.obj.pointId) {
                            $("input[name='userType']:eq(1)").prop("checked", 'checked');
                            oldType = 1;
                            oldPointId = data.obj.pointId;
                            //selUserType('1');	//检测点
                            //$("#point_select").select2('val', data.obj.pointId);
                        } else if (data.obj.regId) {
                            oldType = 2;
                            oldRegId = data.obj.regId;
                            $("input[name='userType']:eq(0)").prop("checked", 'checked');
                            //selUserType('0');	//监管对象
                            //$("#reg_select").select2('val', data.obj.regId);
                        }
                        $("[name=checked][value=" + data.obj.checked + "]").prop("checked", "checked");

                        $("input[name=password]").val("");
                        $("input[name=mpw1]").val("********9_AAAAAA");
                        $("input[name=mpw2]").val("********9_AAAAAA");

                        //设置签名文件
                        // if (showSignatureFile == 1 && !$("#signatureFileId").hasClass("cs-hide")) {
                        //     data.obj.signatureFile = data.obj.signatureFile == '' ? "" : data.obj.signatureFile.substring(data.obj.signatureFile.lastIndexOf("/") + 1, data.obj.signatureFile.length);
                        //     $(".file-caption-name").val(data.obj.signatureFile);
                        // }
                    }, 500);
                }
            });
            $(".show_sorting").removeClass("hide");//显示排序
            $("#myModal .modal-title").text("编辑");
            $("#myModal").modal("show");
        } else {
            //selUserType();
            $(".show_sorting").addClass("hide");//隐藏排序
            $("#myModal .modal-title").text("新增");
            $("#myModal").modal("show");
            $("input[name=sorting]").val("-1");
        }


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
                    datagridUtil.queryByFocus();
                } else {
                    $("#waringMsg>span").html(data.msg);
                    $("#confirm-warnning").modal('toggle');
                }
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
                        datagridUtil.queryByFocus();
                    } else {
                        $("#openid_confirm .modal-title").text("提示");
                        $("#openid_confirm .cs-text-algin").html('<img src="${webRoot}/img/warn.png" width="40px" alt=""/> <span class="tips" id="waringMsg">' + data.msg + '</span>');
                        $("#openid_confirm .modal-footer").html('<a class="btn btn-primary btn-ok" data-dismiss="modal">关闭</a>');
                    }
                }
            })
        }
    }
</script>
</body>
</html>
