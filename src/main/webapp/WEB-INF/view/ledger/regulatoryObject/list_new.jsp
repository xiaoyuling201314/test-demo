<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/WEB-INF/view/common/resource.jsp" %>
<html>
<!--文件上传样式-->
<link rel="stylesheet" type="text/css" href="${webRoot}/plug-in/myUpload/css/easyupload.css"/>
<style type="text/css">
    /*
    .cs-tittle-btn {
        margin-left: 4px;
    }
    */

    .cs-title-hs input {
        height: auto;
        margin-right: 5px;
    }

    .qrcodes {
        height: 94%;
        width: 750px;
        margin: 0 auto;
    }

    @media print {
        .print-page {
            height: auto;
            width: 100%;
        }
    }

    #modal-box-iframe {
        width: 100%;
        height: 100%;
        position: absolute;
        right: 0;
        left: 0;
        top: 0px;
        bottom: 0;
        border: 0;
        border: none;
    }

    .cs-search-box {
        line-height: 30px;
    }

    .cs-search-filter {
        margin-left: 4px;
    }

    .regTypeStr li {
        padding: 0 0 0 10px;
        height: 32px;
        line-height: 28px;
        font-size: 14px;
        border-bottom: 1px solid #eee;
        overflow-y: hidden;
    }

    .regTypeStr li input {
        width: 14px;
        height: 14px;
        margin-right: 4px;
    }

    .regTypeStr li.active {
        background: #1e90ff;
        color: #fff;
    }

    .regTypeStr label {
        display: block;
    }
    .release_up_pic2 .cs-modal-input{
        margin-top: -5px;
        width: auto;
        max-width: 200px;
    }
    .release_up_pic2 .upload-files span{
        width: 100px;
    }
    .release_up_pic2 .upload-files{
        padding-top: 1px;
    }
    .code-content {
        display: inline-block;
        min-width: 150px;
        margin-right: 10px;
        margin-bottom: 12px;
        border: 1px solid #000;
        padding: 10px 30px 20px 30px;

    }

    .qrcodes{
        padding: 20px 0;
    }

</style>
<body>

<div id="dataList"></div>

<%--<div id="qrcodeModal" class="cs-modal-box cs-hide" style="padding:0;">--%>
<%--    <div class="cs-code-bb">--%>
<%--        <span>二维码尺寸：</span>--%>
<%--        <ul class="cs-code-box">--%>
<%--            <li class="cs-current" data-size="small">小</li>--%>
<%--            <li data-size="medium">中</li>--%>
<%--            <li data-size="large">大</li>--%>
<%--        </ul>--%>
<%--        <span class="cs-title-hs"><i class="pull-left">标题：</i></span>--%>
<%--        <div class="cs-title-ib">--%>
<%--            <input id="qrcodeTitle" type="text" placeholder="请输入二维码标题"/>--%>
<%--&lt;%&ndash;            <button type="button" class="btn btn-success cs-tittle-btn">确定</button>&ndash;%&gt;--%>
<%--        </div>--%>
<%--        <span class="cs-title-hs"><i class="pull-left">LOGO：</i></span>--%>
<%--        <div class="cs-title-ib">--%>
<%--&lt;%&ndash;            <input id="qrcodeLogo" type="file" accept="image/*">(建议上传.jpg文件)&ndash;%&gt;--%>
<%--&lt;%&ndash;            <img id="img" style="width: 25px; height: 25px;display: none;">&ndash;%&gt;--%>
<%--            <div class="release_up_pic pull-left release_up_pic2">--%>
<%--                <div class="cs-al cs-modal-input" id="qrcodeLogo"></div>--%>
<%--                <div class="info-title2 upload-notice" style="display: inline;line-height: 30px;">--%>
<%--                    (建议上传.jpg文件，图片不大于100KB)--%>
<%--                </div>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--        <div class="pull-right">--%>
<%--            <button type="button" class="btn btn-success" onclick="preview();">打印</button>--%>
<%--            <button type="button" class="btn btn-default" onclick="closeModal();">返回</button>--%>
<%--        </div>--%>
<%--    </div>--%>
<%--    <!--startprint-->--%>
<%--    <div class="qrcodes cs-lg-height cs-2dcode-box print-page clearfix"></div>--%>
<%--    <!--endprint-->--%>
<%--</div>--%>

<!-- 用户新增/编辑模态框 start-->
<div class="modal fade intro2" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog cs-sm-width" role="document">
        <div class="modal-content ">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">新增</h4>
            </div>
            <div class="modal-body cs-sm-height">
                <!-- 主题内容 -->
                <div class="cs-main">
                    <div class="cs-wraper">
                        <form id="saveform" method="post">
                            <input type="hidden" name="regId" id="regId">
                            <input type="hidden" name="type" value="0">
                            <input type="hidden" name="id" id="ledgerUserId">
                            <div width="50%" class="cs-add-new">
                                <ul class="cs-ul-form clearfix">
                                    <li class="cs-name col-xs-3 col-md-3">市场：</li>
                                    <li class="cs-in-style cs-modal-input"><input type="text" name="regName"
                                                                                  id="regName" class="inputxt"
                                                                                  readonly="readonly"></li>
                                </ul>
                                <ul class="cs-ul-form clearfix">
                                    <li class="cs-name col-xs-3 col-md-3">开通权限：</li>
                                    <li class="cs-al cs-modal-input"><input id="cs-check-radio" type="radio" value="1"
                                                                            name="status" onclick="getType(0);"/><label
                                            for="cs-check-radio">启用</label> <input id="cs-check-radio2" type="radio"
                                                                                   value="0" name="status"
                                                                                   checked="checked"
                                                                                   onclick="getType(1);"/><label
                                            for="cs-check-radio2">停用</label></li>
                                </ul>
                                <div id="user" style="display: none">
                                    <ul class="cs-ul-form clearfix">
                                        <li class="cs-name col-xs-3 col-md-3">账号：</li>
                                        <li class="cs-in-style cs-modal-input"><input type="text" name="username"
                                                                                      id="username" class="inputxt"
                                                                                      nullmsg="请输入账号" errormsg="请输入账号">
                                        </li>
                                    </ul>
                                    <ul class="cs-ul-form clearfix">
                                        <li class="cs-name col-xs-3 col-md-3">密码：</li>
                                        <li class="cs-in-style cs-modal-input"><input type="password" name="pwd"
                                                                                      datatype="*6-18" class="inputxt"
                                                                                      plugin="passwordStrength" id="pwd"
                                                                                      nullmsg="请输入密码" errormsg="请输入密码">
                                        </li>
                                    </ul>
                                </div>
                            </div>
                    </div>
                </div>
                </form>
            </div>
            <div class="modal-footer action">
                <button type="button" class="btn btn-success" id="Save" onclick="save();">保存</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
            </div>
        </div>
    </div>
</div>
<!-- 用户新增/编辑模态框  end -->


<!-- Modal 上传照片-->
<div class="modal fade intro2" id="uploadImageModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
     aria-hidden="true">
    <div class="modal-dialog cs-mid-width">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title">上传照片</h4>
            </div>
            <div class="modal-body cs-mid-height cs-dis-tab">
                <form id="uploadImageForm">
                    <input type="hidden" name="id">
                    <div width="100%" class="cs-add-new">
                        <ul class="cs-ul-form clearfix">
                            <li class="cs-name col-md-4">企业/市场名称：</li>
                            <li class="cs-in-style col-md-8 _reg_name"></li>
                        </ul>
                        <ul class="cs-ul-form clearfix">
                            <li class="cs-name col-md-4">监管对象类型：</li>
                            <li class="cs-in-style col-md-8 _reg_type"></li>
                        </ul>
                        <ul class="cs-ul-form clearfix">
                            <li class="cs-name col-md-4">监管对象照片：</li>
                            <li class="cs-in-style col-md-8">
                                <div class="release_up_pic">
                                    <div class="cs-al cs-modal-input" id="regImage"></div>
                                    <div class="info-title2 upload-notice col-xs-12">
                                        支持jpg、png、gif、jpeg格式图片，图片不大于1MB
                                    </div>
                                </div>
                            </li>
                        </ul>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-success" id="uploadImageBtn" onclick="uploadImage();">提交</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
            </div>
        </div>
    </div>
</div>

<div id="seeimg" class="hide show-media" onclick="videoHide();">
    <img style="height: 80%" src="">
</div>

<!-- Modal 提示窗-确认-->
<div class="modal fade intro2" id="dcjgdxqcModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog cs-alert-width">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">导出</h4>
            </div>
            <div class="modal-body cs-alert-height cs-dis-tab">
                <div class="cs-text-algin">
                    <img src="${webRoot}/img/warn.png" width="40px"/>
                    <span class="tips">您未选择监管对象，是否导出全部？</span>
                </div>
            </div>
            <div class="modal-footer">
                <a class="btn btn-success btn-ok" data-dismiss="modal" onclick="dcjgdxqc();">是</a>
                <button type="button" class="btn btn-default" data-dismiss="modal">否</button>
            </div>
        </div>
    </div>
</div>

<%@include file="/WEB-INF/view/ledger/regulatoryObject/selectRegType.jsp" %>
<%@include file="/WEB-INF/view/common/confirm.jsp" %>
<%@include file="/WEB-INF/view/common/modalBox.jsp" %>
<%@include file="/WEB-INF/view/common/exportDialog.jsp" %>
<%-- 设置二维码样式 --%>
<%@include file="/WEB-INF/view/common/qrcode/qrcodeStyle.jsp" %>
<%-- 查看二维码 --%>
<%@include file="/WEB-INF/view/common/qrcode/viewQrcode.jsp" %>

<!--文件上传js-->
<script src="${webRoot}/plug-in/myUpload/js/easyupload.js" type="text/javascript"></script>
<!-- JavaScript -->
<script src="${webRoot}/js/datagridUtil2.js"></script>
<script type="text/javascript">
    var showBusiness = false;
    var ledgerUser = 1;
    var ledgerUserObj = 1;
    var reguser = '${reg}';
    var isshow = 0;//查看预留字段
    var shichang = 1;
    var regTypeStr='';//选择的监管类型

    //修改新增监管对象权限名称
    if (Permission.getPermission("1498-1")) {
        Permission.getPermission("1498-1").operationName = '新增';
    }
    //查看二维码-导出
    if (Permission.exist('1498-17')) {
        showDaoChu();
    }

    //文件上传初始化
    var uploaderobj;
    //二维码LOGO文件上传初始化
    var qrcodeLoaderObj;

    var dgu = datagridUtil.initOption({
        tableId: "dataList",
        tableAction: "${webRoot}/ledger/regulatoryObject/datagrid2",
        tableBar: {
            title: ["监管对象"],
            hlSearchOff: 0,
            ele: [
                {
                    //机构
                    eleShow: 1,
                    eleType: 4,
                    eleHtml: "<div class=\"cs-input-style cs-fl\" style=\"margin: 0 0 0 30px;\"> " +
                    "        机构: " +
                    "        <div class=\"cs-all-ps\"> " +
                    "            <div class=\"cs-input-box\"> " +
                    "                <input type=\"text\" name=\"departNames\" autocomplete=\"off\"> " +
                    "                <div class=\"cs-down-arrow\"></div> " +
                    "            </div> " +
                    "            <div class=\"cs-check-down cs-hide\" style=\"display: none;\"> " +
                    "                <ul id=\"tree\" class=\"easyui-tree\"></ul> " +
                    "            </div> " +
                    "        </div> " +
                    "        <input name=\"departids\" type=\"hidden\"> " +
                    "    </div>"
                }, {
                    //监管类型
                    eleShow: 1,
                    eleType: 4,
                    eleHtml: "<span class=\"check-date cs-fl\">" +
                    "<span class=\"cs-name\" style=\"padding-right: 0px;\">监管类型：</span>" +
                    "<span class=\"cs-input-style \" style=\"margin-left: 0px;\">" +
                    "<input type=\"hidden\" name=\"regTypeId\" value=\"\" id=\"regTypeIds\" class=\"focusInput\"/>" +
                    "<input type=\"text\" name=\"regTypeName\" class=\"choseRegType\" value=\"--全部--\" autocomplete=\"off\" style=\"width: 110px\" readonly/>" +
                    "</span>" +
                    "</span>"
                }, {
                    eleShow: 1,
                    eleName: "regulatoryObject.regName",
                    eleType: 0,
                    elePlaceholder: "请输入企业名称"
                }
            ],
            topBtns: [{
                show: Permission.exist("1498-19"),
                style: Permission.getPermission("1498-19"),
                action: function (ids, rows) {
                    showQrcodeStyle();
                }
            }, {
                show: Permission.exist("1498-1"),
                style: Permission.getPermission("1498-1"),
                action: function (ids, rows) {
                    var getregType = $("#getregType").val();
                    showMbIframe("${webRoot}/ledger/regulatoryObject/goAddRegulatoryObject.do?regTypeId=" + getregType + "&isNewMenu=Y");
                }
            }],
            init: function () {
                $('#tree').tree({
                    checkbox: false,
                    url: "${webRoot}/detect/depart/getDepartTree.do",
                    animate: true,
                    onLoadSuccess: function (node, data) {
                        if (data.length > 0) {
                            $("input[name='departNames']").val(data[0].text);
                            $("input[name='departids']").val(data[0].id);
                        }
                    },
                    onClick: function (node) {
                        $("input[name='departNames']").val(node.text);
                        $("input[name='regulatoryObject.regName']").val("");
                        $(".cs-check-down").hide();
                        $("input[name='departids']").val(node.id);
                        bigbang();
                    }, onSelect: function (node) {
                        $("input[name='departids']").val(node.id);
                    }
                });
            }
        },
        defaultCondition: [
            {
                queryCode: "regulatoryObject.regType",
                queryVal: regTypeStr
            }, {
                queryCode: "regulatoryObject.departId",
                queryVal: 0
            }
        ],
        parameter: [
            {
                columnCode: "departName",
                columnName: "机构"
            }, {
                columnCode: "regName",
                columnName: "企业/市场名称",
                customStyle: "regName",
                query: 1
            }, {
                columnCode: "regTypeName",
                columnName: "监管类型",
                columnWidth: "120px"
            }, {
                columnCode: "id",
                columnName: "二维码",
                customElement: "<a class=\"runcode qrcode\" data-value='?' href=\"javascript:;\" onclick=\"ckQrcode('?');\"><img src=\"${webRoot}/img/2dcode.png\" alt=\"\" /></a>",
                show: Permission.exist('1498-5'),
                columnWidth: "80px"
            }, {
                columnCode: "businessNumber",
                columnName: "经营户",
                customElement: "<a class=\"cs-link-text \" href=\"javascript:;\">?户</a>",
                customStyle: "businessNumber",
                columnWidth: "70px"
            }, {
                columnCode: "managementType",
                columnName: "市场类型",
                customVal: {
                    "0": "批发市场",
                    "1": "农贸市场",
                    "default": ""
                },
                show: 0,
                columnWidth: "100px"

            }, {
                columnCode: "regAddress",
                columnName: "地址"
            }, {
                columnCode: "checked",
                columnName: "状态",
                customVal: {
                    "0": "<div class=\"text-danger\">未审核</div>",
                    "1": "<div class=\"text-primary\">已审核</div>"
                },
                columnWidth: "80px"
            }, {
                columnCode: "param2",
                columnName: "照片",
                customVal: {
                    "is-null": "",
                    "non-null": "<a onclick=\"openFile('${resourcesUrl}?');\" href=\"javascript:;\"><img src=\"${resourcesUrl}?\" title=\"#regName#\" class=\"img-thumbnail\" style=\"height:100%;\"/></a>"
                },
                columnWidth: "80px",
                show: Permission.exist('1498-18')
            }, {
                columnCode: "taskType",
                columnName: "任务类型",
                customVal: {
                    "1": "省级",
                    "2": "市级",
                    "3": "县级",
                    "4": "街道",
                    default: ""
                },
                show:  Permission.exist('1498-20'),
                columnWidth: "80px"

            }],
        onload: function (rows, pageData) {
            $(".rowTr").each(function () {
                for (var i = 0; i < rows.length; i++) {
                    if ($(this).attr("data-rowId") == rows[i].id) {
                        if (rows[i].showBusiness == '0') {//不显示经营户列数据
                            $(this).find(".businessNumber").html("");
                        }
                        //农批市场：在市场名称后面加上图标
                        if (rows[i].managementType == '0') {//批发市场
                            $(this).find(".regName").append('<i class="icon iconfont icon-pifa" style="margin-left: 4px;" title="批发市场"></i>');
                        } else if (rows[i].managementType == '1') {//农贸市场
                            $(this).find(".regName").append('<i class="icon iconfont icon-108" style="margin-left: 4px;" title="农贸市场"></i>');
                        }
                        break;
                    }
                }
            });
        },
        funBtns: [
            {
                show: Permission.exist("1498-2"),  //编辑
                style: Permission.getPermission("1498-2"),
                action: function (id, row) {
                    getregType = row.regType;
                    showMbIframe("${webRoot}/ledger/regulatoryObject/goAddRegulatoryObject.do?regTypeId=" + getregType + "&id=" + id + "&isNewMenu=Y");
                }
            }, {
                show: Permission.exist("1498-18"), //上传照片
                style: Permission.getPermission("1498-18"),
                action: function (id, row) {
                    $("#uploadImageForm input[name='id']").val(id);
                    $("#uploadImageModal ._reg_name").text(row.regName);
                    $("#uploadImageModal ._reg_type").text(row.regTypeName);

                    uploaderobj = easyUploader({
                        id: "regImage", //容器渲染的ID 必填
                        accept: '.png,.jpg,.jpeg,.bmp,.gif,.tiff,.pcx,.ico',    //可上传的文件类型
                        isImage: true,  //图片文件上传
                        maxCount: 1,   //允许的最大上传数量
                        maxSize: 1,  //允许的文件大小 单位：M
                        multiple: false, //是否支持多文件上传
                        name: "file",     //后台接收的文件名称
                        isEncrypt: false,//是否加密
                        onChange: function (fileList) {
                            //input选中时触发
                        },
                        onAlert: function (msg) {
                            $("#confirm-warnning .tips").text(msg);
                            $("#confirm-warnning").modal('toggle');
                        }
                    });

                    $("#uploadImageModal").modal("show");
                }
            }, {
                show: Permission.exist("1498-3"),  //删除
                style: Permission.getPermission("1498-3"),
                action: function (id, row) {
                    if (id == '') {
                        $("#confirm-warnning .tips").text("请选择监管对象");
                        $("#confirm-warnning").modal('toggle');
                    } else {
                        deleteIds = id;
                        $("#confirm-delete").modal('toggle');
                    }
                }
            }],
        bottomBtns: [
            {
                show: Permission.exist('1498-5'),	//查看二维码
                style: Permission.getPermission('1498-5'),
                action: function (ids, rows) {
                    if (ids == '') {
                        $("#confirm-warnning .tips").text("请选择监管对象");
                        $("#confirm-warnning").modal('toggle');
                    } else {
                        viewRegQrcode(ids, rows);
                    }
                }
            }, {
                show: Permission.exist('1498-17'),	//导出二维码
                style: Permission.getPermission('1498-17'),
                action: function (ids, rows) {
                    if (!ids || ids.length == 0) {
                        $("#dcjgdxqcModal .tips").text('您未选择监管对象，是否导出全部('+dgu.datagridOption.rowTotal+'条记录)？');
                        $("#dcjgdxqcModal").modal('toggle');
                        return;
                    } else {
                        dcjgdxqc(ids);
                    }
                }
            }, {
                show: Permission.exist("1498-3"),
                style: Permission.getPermission("1498-3"),
                action: function (ids, rows) {
                    if (ids == '') {
                        $("#confirm-warnning .tips").text("请选择监管对象");
                        $("#confirm-warnning").modal('toggle');
                    } else {
                        deleteIds = ids;
                        $("#confirm-delete").modal('toggle');
                    }
                }
            }, {//导入监管对象按钮
                show: Permission.exist("1498-8"),
                style: Permission.getPermission("1498-8"),
                action: function (ids, rows) {
                    location.href = '${webRoot}/regulatory/regulatoryObject/toImport.do?isNewMenu=Y'
                }
            }, {//导出监管对象按钮
                show: Permission.exist("1498-10"),
                style: Permission.getPermission("1498-10"),
                action: function (ids, rows) {
                    $("#exportModal").modal('toggle');
                }
            }
        ]
    });

    //导出监管对象二维码
    function dcjgdxqc(ids){
        //导出全部
        if (!ids) {
            var qpDepartId = "";
            var qpRegName = "";
            var qpRegType = "";
            if (dgu) {
                var queryParam = dgu.getQueryParam();
                if (queryParam["regulatoryObject.departId"]) {
                    qpDepartId = queryParam["regulatoryObject.departId"];
                }
                if (queryParam["regulatoryObject.regName"]) {
                    qpRegName = queryParam["regulatoryObject.regName"];
                }
                if (queryParam["regulatoryObject.regType"]) {
                    qpRegType = queryParam["regulatoryObject.regType"];
                }
            }
            location.href = '${webRoot}/regulatory/regulatoryObject/exportQrcode?departId='+qpDepartId+'&regName='+qpRegName+'&regType='+qpRegType;
        //导出部分
        } else {
            location.href = '${webRoot}/regulatory/regulatoryObject/exportQrcode?regIds='+ids;
        }
    }

    //上传照片
    function uploadImage() {
        $("#uploadImageBtn").attr("disabled", "disabled");
        var formData = new FormData($('#uploadImageForm')[0]);
        var fileList = uploaderobj.files;
        for (var i = 0; i < fileList.length; i++) {
            formData.append("regImage", fileList[i]);
        }
        $.ajax({
            type: "POST",
            url: "${webRoot}/iRegulatory/uploadRegImage",
            data: formData,
            contentType: false, //必须false才会避开jQuery对 formdata 的默认处理 XMLHttpRequest会对 formdata 进行正确的处理
            processData: false, //必须false才会自动加上正确的Content-Type
            dataType: "json",
            success: function (data) {
                if (data && data.success) {
                    $('#uploadImageModal').modal('hide');
                    dgu.queryByFocus();
                } else {
                    $.Showmsg(data.msg);
                }
            },
            complete: function () {
                $("#uploadImageBtn").removeAttr("disabled");
            }
        });
        return false;
    }

    $(function () {
        //加载的时候取被选中的项值
        var showType = $("#showType").val();
        if (showType == 1) {
            showBusiness = true;
        }
        bigbang();
    });

    function setregType(e, b, showType) {
        $("#getregType").val(e);
        $("input[name='regulatoryObject.regName']").val("");
        $("#regTypeName").text(b);//标题
        if (showType == 1) {
            showBusiness = true;
        } else {
            showBusiness = false;
        }
        bigbang();
    }

    function bigbang() {
        var getregType = $("#getregType").val();

        dgu.addDefaultCondition("regulatoryObject.departId", $("input[name='departids']").val());
        dgu.queryByFocus();
    }

    function dguQuery() {
        dgu.queryByFocus();
    }

    //导出方法
    function exportFile() {
        var radios = document.getElementsByName('inlineRadioOptions');
        var ext = '';
        for (var i = 0; i < radios.length; i++) {
            if (radios[i].checked) {
                ext = radios[i].value;
            }
        }
        if (ext != '') {
            let regType = regTypeStr;
            let departId = $("input[name='departids']").val();
            let regName=$("input[name='regulatoryObject.regName']").val();
            location.href = '${webRoot}/regulatory/regulatoryObject/exportFile.do?types=' + ext + "&menuType=1&departId=" + departId + "&regName=" + regName + "&regType=" + regType;
            $("#exportModal").modal('hide');
        } else {
            $("#exportModal").modal('hide');
            $("#confirm-warnning .tips").text("请选择导出格式!");
            $("#confirm-warnning").modal('toggle');
        }
    }

    //查看经营户
    $(document).on("click", ".businessNumber", function () {
        if ($(this).text()) {
            self.location = '${webRoot}/ledger/business/list.do?regId=' + $(this).parents(".rowTr").attr("data-rowId") + "&isNewMenu=Y";
        }
    });

    //删除
    var deleteIds = "";

    function deleteData() {
        $.ajax({
            type: "POST",
            url: "${webRoot}/ledger/regulatoryObject/delete.do",
            data: {
                "ids": deleteIds.toString()
            },
            dataType: "json",
            success: function (data) {
                if (data && data.success) {
                    self.location.reload();
                } else {
                    $("#confirm-warnning .tips").text("删除失败");
                    $("#confirm-warnning").modal('toggle');
                }
            }
        });
        $("#confirm-delete").modal('toggle');
    }

    //查看单个二维码
    function ckQrcode(regid){
        var row = [];
        $.each(dgu.getData(), function (i, e) {
            if (regid == e.id) {
                row.push(e);
                viewRegQrcode(regid, row);
                return false;
            }
        });
    }

    function getType(e) {
        if (e == 1) {
            $("#user").hide();
        } else {
            $("#user").show();
        }
    }

    function save() {
        var status = $('input[name="status"]:checked').val();
        if (status == 1) {
            var username = $("#username").val();
            if (username == null || username == "") {
                $("#confirm-warnning .tips").text("请输入账号!");
                $("#confirm-warnning").modal('toggle');
                return;
            }
            var pwd = $("#pwd").val();
            if (pwd == null || pwd == "") {
                $("#confirm-warnning .tips").text("请输入密码!");
                $("#confirm-warnning").modal('toggle');
                return;
            }
        } else if (status == null || status == "") {
            return;
        }
        $.ajax({
            type: "POST",
            url: "${webRoot}/ledger/regulatoryUser/save.do",
            data: $('#saveform').serialize(),
            dataType: "json",
            success: function (data) {
                if (data.success) {
                    $.Showmsg(data.msg);
                    if (data.obj != null) {
                        $("#ledgerUserId").val(data.obj.id);
                    }
                } else {
                    $.Showmsg(data.msg);
                }
            }
        })

    };
    $(function () {
        $('#myModal').on('hide.bs.modal', function () {
            $("input[name='status'][value='0']").prop('checked', true);
            $("#username").val("");
            $("#pwd").val("");//食品名称
            $("#ledgerUserId").val("");
            $("#regId").val("");
            $("#user").hide();
        })
    });

    function getRegName(id) {
        var obj = datagridOption.obj;
        for (var i = 0; i < obj.length; i++) {
            if (obj[i].id == id) {
                $("#regName").val(obj[i].regName);
            }
        }
        $.ajax({
            type: "POST",
            url: '${webRoot}' + "/ledger/regulatoryUser/getLedgerUser.do?regId=" + id,
            dataType: "json",
            success: function (data) {
                var obj = data.obj;
                if (obj != null && obj != "") {
                    $("input[name='status'][value=" + obj.status + "]").prop('checked', true);
                    $("#username").val(obj.username);
                    $("#pwd").val(obj.pwd);//食品名称
                    $("#ledgerUserId").val(obj.id);
                    $("#regId").val(obj.regId);
                    if (obj.status == 1) {
                        $("#user").show();
                    }
                }
            }
        });
    }

    //根据不同的类型跳转
    function add() {
        var getregType = $("#getregType").val();
        showMbIframe("${webRoot}/ledger/regulatoryObject/goAddRegulatoryObject.do?regTypeId=" + getregType + "&isNewMenu=Y");
    }

    $(document).on('click', '.cs-code-box li', function () {
        $(this).addClass('cs-current').siblings().removeClass('cs-current');
    });

    //选择监管类型
    function choseRegType(nodeIds, nodeTexts) {
        $(".choseRegType").val(nodeTexts);
        regTypeStr=nodeIds;
        dgu.addDefaultCondition("regulatoryObject.regType", nodeIds);
        dgu.queryByFocus();
    }

    //二维码查看返回按钮
    function closeModal() {
        $("#qrcodeModal").hide();
        $('html').css('overflow', 'auto');
    }

    //查看市场照片
    function openFile(url) {
        $("#seeimg").find("img").attr("src", url);
        $("#seeimg").removeClass("hide");
        $("#hidevideo").append(html);
    }

    function videoHide() {
        $("#seeimg").addClass("hide");
    }
</script>
</body>
</html>
