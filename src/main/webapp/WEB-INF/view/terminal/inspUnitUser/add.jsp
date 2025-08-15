<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/WEB-INF/view/common/resource.jsp" %>

<!DOCTYPE html>
<head>
    <title>快检服务云平台</title>
    <link rel="stylesheet" type="text/css" href="${webRoot}/plug-in/myUpload/css/easyupload.css"/>
    <script src="${webRoot}/plug-in/myUpload/js/easyupload.js" type="text/javascript"></script>
    <style>
        .cs-add-new .cs-name {
            width: 176px;
        }

        .company-info {
            table-layout: fixed;
        }

        .company-info .cs-name {
            width: 70px;
            padding: 0;
        }

        .select-margin {
            margin-top: 4px;
            margin-right: 10px;
        }

        .select-margin input, .select-margin span {
            float: left;
        }

        .cs-in-style input[type="text"], .cs-in-style input[type="password"], .cs-in-style textarea {
            width: 400px;
        }

        .Validform_wrong {
            margin-left: 10px;
        }
        .cs-in-style .sp-box-width input[type="text"]{
            width:300px;
        }
        .clear-botn{
            clear:both;
        }
        .cs-in-style .col-md-5{
            width:400px;
        }
        .code-lists li{
            cursor:pointer;
            padding-left:3px;
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
            <li class="cs-b-active cs-fl">送检用户</li>
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
    <form id="userForm" method="post" autocomplete="off" style="margin: 15px">
        <input type="hidden" name="id" value="${id}">
        <div class="cs-base-detail">
            <div class="cs-content2" style="padding-left:20%;">
                <table class="cs-add-new">
                    <tr>
                        <td class="cs-name" style="vertical-align: top; padding-top: 5px;">用户类型：</td>
                        <td class="cs-in-style">
                            <div style="padding:5px; width: 400px;">
                                <label><input type="radio" name="userType" onchange="changeUserType(this)" value="1"  checked="checked"/> 企业</label>
                                <label><input type="radio" name="userType" onchange="changeUserType(this)" value="0"/>个人</label>
                            </div>
                        </td>
                    </tr>
                  <%--  <tr class="showColdUnit">
                        <td class="cs-name"><i class="cs-mred">*</i>所属机构：</td>
                        <td class="cs-in-style">
                            <li class="cs-in-style col-md-5" width="210px">
                                <div class="cs-input-box" style="position: relative; width: 100%;">
                                    <input type="text" name="departName" datatype="*" nullmsg="请选择所属机构" errormsg="请选择所属机构" autocomplete="off"  style="width: 100%; box-sizing: border-box; padding-right: 20px;">
                                    <input type="hidden" name="departId">
                                    <div class="cs-down-arrow"></div>
                                </div>
                                <div class="cs-check-down cs-hide" style="display: none;">
                                    <ul id="myDeaprtTree" class="easyui-tree"></ul>
                                </div>
                            </li>
                        </td>
                    </tr>--%>
                    <tr class="showColdUnit">
                        <td class="cs-name"><i class="cs-mred">*</i>冷链单位名称：</td>
                        <td class="cs-in-style">
                            <li class="cs-in-style col-md-5" width="210px">
<%--                            <select id="coldUnitSelect" name="coldUnitId"></select>--%>
                                <input type="hidden" name="coldUnitId">
                                <%@include file="/WEB-INF/view/terminal/inspUnitUser/selectColdUnit.jsp"%>
                            </li>
                        </td>
                    </tr>
                    <tr>
                        <td class="cs-name showPerson1"><i class="cs-mred">*</i>经营者名称：</td>
                        <td class="cs-in-style">
                            <li class="cs-in-style col-md-5" width="400px">
                                <select  id="inspectionSelect" name="inspectionId" style="width:210px;"></select>
                            </li>
                        </td>
                    </tr>
                   <%-- <c:if test="${!empty id}">
                        <tr class="cs-hide">
                            <td class="cs-name">用户编号：</td>
                            <td class="cs-in-style account">

                            </td>
                        </tr>
                    </c:if>--%>

                    <tr>
                        <td class="cs-name"><i class="cs-mred">*</i>登录手机：</td>
                        <td class="cs-in-style">
                            <li class="cs-in-style col-md-5" width="210px">
                                <input type="text" datatype="m" id="phone" name="phone" nullmsg="请输入手机号码！" errormsg="请输入正确的手机号码！"/>
                            </li>
                            <li class="col-xs-4 col-md-4">
                                <div class="Validform_checktip"></div>
                                <div class="info"></div>
                            </li>
                        </td>
                    </tr>
                    <tr>
                        <td class="cs-name">用户姓名：</td>
                        <td class="cs-in-style">
                            <input type="text" name="realName">
                        </td>
                    </tr>
                    <tr class="showIdNumber cs-hide">
                        <td class="cs-name">身份证号：</td>
                        <td class="cs-in-style">
                            <input type="text" id="identifiedNumber" name="identifiedNumber"
                            <%--onfocus="nunber(this.value)" onblur="nunber(this.value)"--%> maxlength="20"/>
                        </td>
                    </tr>
                    <tr>
                        <td class="cs-name"><i class="cs-mred">*</i>登录密码：</td>
                        <td class="cs-in-style">
                            <li class="cs-in-style col-md-5" width="210px">
                                <input type="password" maxlength="18" name="password" class="inputxt checkPassword"
                                       plugin="passwordStrength" datatype="*6-18" nullmsg="请输入密码！" errormsg="密码至少6个字符,最多18个字符！"/>
                            </li>
                            <li class="col-xs-4 col-md-4">
                                <div class="Validform_checktip"></div>
                                <div class="info"></div>
                            </li>
                        </td>
                    </tr>
                    <tr>
                        <td class="cs-name"><i class="cs-mred">*</i>确认密码：</td>
                        <td class="cs-in-style">
                            <li class="cs-in-style col-md-5" width="210px">
                                <input type="password" maxlength="18" name="password0"
                                       class="inputxt checkPassword" autocomplete="new-password"
                                       recheck="password" datatype="*6-18" nullmsg="请确认密码！" errormsg="两次输入的密码不一致！"/>
                            </li>
                            <li class="col-xs-4 col-md-4">
                                <div class="Validform_checktip"></div>
                                <div class="info"></div>
                            </li>
                        </td>
                    </tr>

                </table>

                <table class="cs-add-new" style="margin-top:5px;">
                    <tr>
                        <td class="cs-name" style="vertical-align: top; padding-top: 5px;">用户角色：</td>
                        <td class="cs-in-style">
                            <div style="padding:5px; width: 400px;">
                                <div class="clearfix" style="padding-bottom: 10px;">
                                    <label> <input type="radio" name="type" value="0" id="ptyh" checked="checked">普通用户</label>
                                    <label><input type="radio" name="type" value="1" id="cyry">抽样人员</label>
<%--                                    <label><input type="radio" name="type" value="2" id="jgf">监管方</label>--%>
<%--                                    <label><input type="radio" name="type" value="3" id="smqy">上门取样</label>--%>
<%--                                    <label><input type="radio" name="type" value="4" id="cwtj">财务统计</label>--%>
                                </div>
                              <%--  <div class="clearfix" style="padding-bottom: 10px;">
                                    <label> <input type="checkbox" name="type1" value="0" id="sjyh" disabled="true" checked="checked">送检用户</label>
                                    &nbsp;
                                    <label><input type="checkbox" name="type1" value="3" id="smqy">上门取样</label>
                                    &nbsp;
                                    <label><input type="checkbox" name="type1" value="1" id="gly">委托单位</label>
                                    &nbsp;
                                    <label><input type="checkbox" name="type1" value="4" id="cwtj">财务统计</label>
                                </div>--%>
                                <div class="clearfix jgf">
                                   <%-- <label class="select-margin pull-left">
                                        <input type="radio" name="type1" value="2" id="jgf"/>
                                        <span>监管方</span>
                                    </label>--%>

                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td class="cs-name">用户状态：</td>
                        <td class="cs-in-style">
                            <label><input type="radio" name="checked" value="1" checked="checked"/>启用</label>
                            <label><input type="radio" name="checked" value="0"/> 停用</label>
                        </td>
                    </tr>
                    <tr>
                        <td class="cs-name">备注：</td>
                        <td class="cs-in-style" colspan="5">
                            <textarea name="remark" style="width: 400px;height:70px;"></textarea>
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
    var id = "${id}";
    $(function () {//页面加载完成后执行
        queryById();
        //表单提交_start -----------------------------
        // 点击保存（新增或修改）
        $("#btnSave").on("click", function () {
            $("#userForm").submit();
            return false;
        });
        //表单验证
        var userForm = $("#userForm").Validform({
            tiptype: 2,
            usePlugin: {
                passwordstrength: {//密码校验
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
            beforeSubmit: function (curform) {//在提交之前进行数据处理
                //判断密码是否被修改过；若没有则设置密码为空不进行修改
                if ($("input[name=oldPassword]").val() == $("input[name=password]").val()) {
                    $("input[name=password]").val("");
                    $("input[name=password]").removeAttr("datatype");
                }
                //获取所有name为demand的对象
                let obj = document.getElementsByName('type2');
                let demand = '';
                let monitoringUnitType="";
                for (let i = 0; i < obj.length; i++) {
                    if (obj[i].checked) {
                        demand += obj[i].value;//如果选中，将value添加到变量s中
                        monitoringUnitType+=obj[i].value+",";
                    }
                }

                let formData = new FormData($('#userForm')[0]);
                formData.append("monitoringType", demand);
                if($("input[name=userType]").val()==0){
                    formData.append("coldUnitId", -1);
                }
                formData.append("monitoringUnitType", monitoringUnitType=="" ? "" : monitoringUnitType.substring(0,monitoringUnitType.lastIndexOf(",")));
                $("#btnSave").attr("disabled", "disabled");//禁用按钮

                //调用ajax请求去提交表单
                $.ajax({
                    type: "POST",
                    url: "${webRoot}/inspUnitUser/save.do",
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
                            $("#btnSave").removeAttr("disabled");//禁用按钮
                        }
                    }
                });
                return false;
            }
        });

        //表单提交_end -----------------------------

        //-------  密码、电话号码、身份证号码的校验_start ----------
        //修改了密码，则给密码输入框加上验证
        $(".checkPassword").on("blur", function () {
            if ($("input[name=oldPassword]").val() != $("input[name=password]").val()) {
                $("input[name=password]").attr("datatype", "*6-18");
                $("input[name=password0]").attr("datatype", "*6-18");
            }
        });
        //电话号码的校验
        $("#phone").change(function () {//此处与微信公众号那边校验的正则表达式一致
            userForm.addRule([{
                ele: "#phone",
                datatype: /^1[3456789]\d{9}$/,
                ajaxurl: "${webRoot}/inspUnitUser/selectByPhone.do?userId=" + id + "&phone=" + $(this).val(),
                nullmsg: "请输入联系方式！",
                errormsg: "请输入正确的联系方式！"
            }]);
        });

        //身份证唯一的校验（当输入的身份证不为空，且身份证号码符合，如果为空直接过）
        $("#identifiedNumber").change(function () {
            var identifiedNumber = $(this).val();
            if (identifiedNumber /*&& nunber(identifiedNumber)*/) {
                userForm.addRule([{
                    ele: "#identifiedNumber",
                    datatype: "*",
                    ajaxurl: "${webRoot}/inspUnitUser/checkNumber?id=" + id + "&identifiedNumber=" + identifiedNumber,
                    nullmsg: "请输入联系方式！",
                    errormsg: "该身份证号码已被使用！"
                }]);
            } else {
                $("#identifiedNumber").removeAttr("datatype");
            }
        });

        //-------  密码、电话号码、身份证号码的校验_end ----------


        // ----------勾选用户角色的change事件--------------
        //$("input[name=type]").change(function () {
           //let type= $("input[name=type]:checked").val();alert(type);

           // showAffiliation(type);
            /*var selValArr = [];
            $("input[name=type1]:checked").each(function (i, v) {
                selValArr.push(parseInt(v.value));
            });
            if (selValArr && selValArr.length > 0) {
                selValArr.sort();    //排序
                var selVal = "";
                $(selValArr).each(function (i1, v1) {
                    selVal = v1 + selVal;
                });
                showAffiliation(selVal);//显示监管方监管类型的方法
            }
             */
        //})

    });

    function queryById(){
        if (id) {
            $(".account").find("tr").show();
            $("#userForm .account").parent().show();
            $.ajax({
                url: '${webRoot}/inspUnitUser/queryById',
                method: 'post',
                data: {"id": id},
                success: function (data) {
                    if (data && data.success) {
                        $("#userForm input[name='id']").val(data.obj.id);
                        $("#userForm .account").text(data.obj.account);
                        $("#userForm input[name='phone']").val(data.obj.phone);
                        $("#userForm input[name='realName']").val(data.obj.realName);
                        $("#userForm input[name='password']").val(data.obj.password);
                        $("#userForm input[name='password0']").val(data.obj.password);
                        $("#userForm input[name='oldPassword']").val(data.obj.password);
                        $("#userForm input[name='identifiedNumber']").val(data.obj.identifiedNumber);
                        $("#userForm input[name='departId']").val(data.obj.departId);
                        $("#userForm input[name='departName']").val(data.obj.departName);
                        $("#userForm textarea[name='remark']").val(data.obj.remark);
                        $("#userForm input[name=password]").removeAttr("datatype");
                        $("#userForm input[name=password0]").removeAttr("datatype");
                        $("#userForm input[name='userType'][value=" + data.obj.userType + "]").prop("checked", true);
                        $("#userForm input[name='checked'][value=" + data.obj.checked + "]").prop("checked", true);
                        $("input[name='type'][value='" + data.obj.type + "']").prop("checked", true);
                        $("input[name=coldUnitId]").val(data.obj.coldUnitId);
                        $("#coldUnitSelect").select2('val', data.obj.coldUnitId);
                        $("#select2-coldUnitSelect-container").text(data.obj.coldName);
                        queryInspUnit(data.obj.coldUnitId);
                        //经营单位
                       setTimeout(function(){
                           $("#inspectionSelect").val(data.obj.inspectionId);
                       },300);
                        //当未企业的时候进行回显
                        /*if (data.obj.userType == 1 || data.obj.userType == 2) {
                            $("input[name=inspectionId]").val(data.obj.inspectionId);
                            let inspectionId = data.obj.inspectionId;
                            let InspectionUnitsList = eval('${inspectionListObj}');
                            for (let i = 0; i < InspectionUnitsList.length; i++) {
                                let obj = InspectionUnitsList[i];
                                if (inspectionId == obj.id) {
                                    $("input[name=creditCode]").val(obj.creditCode);
                                    $("input[name=companyName]").val(obj.companyName);
                                }
                            }
                        }*/
                    }
                }
            });
        } else {
            $(".account").find("tr").hide();//隐藏用户编号
        }
    }
</script>
<script>

    //以下为身份证号码的校验
    function nunber(allowancePersonValue) {
        if (allowancePersonValue == '') {
            $("#identifiedNumber").removeAttr("datatype");
            $("#user_number").removeClass("Validform_wrong").html("");
            $("#identifiedNumber").removeAttr("datatype", "*");
            return true;
        }
        //校验长度，类型
        else if (isCardNo(allowancePersonValue) === false) {
            $("#user_number").addClass("Validform_wrong");
            $("#user_number").html("您输入的身份证号码不正确，请重新输入");
            $("#identifiedNumber").attr("datatype", "*");
            return false;
        }
        //检查省份
        else if (checkProvince(allowancePersonValue) === false) {
            $("#user_number").addClass("Validform_wrong");
            $("#user_number").html("您输入的身份证号码不正确,请重新输入");
            $("#identifiedNumber").attr("datatype", "*");
            return false;

        }
        //校验生日
        else if (checkBirthday(allowancePersonValue) === false) {
            $("#user_number").addClass("Validform_wrong");
            $("#user_number").html("您输入的身份证号码生日不正确,请重新输入");
            $("#identifiedNumber").attr("datatype", "*");
            return false;
        }
        //检验位的检测
        else if (checkParity(allowancePersonValue) === false) {
            $("#user_number").addClass("Validform_wrong");
            $("#user_number").html("您的身份证校验位不正确,请重新输入");
            $("#identifiedNumber").attr("datatype", "*");
            return false;
        } else {
            $("#user_number").removeClass("Validform_wrong").html("");
            $("#identifiedNumber").attr("datatype", "*");
            return true;
        }
    }

    //身份证省的编码
    var vcity = {
        11: "北京",
        12: "天津",
        13: "河北",
        14: "山西",
        15: "内蒙古",
        21: "辽宁",
        22: "吉林",
        23: "黑龙江",
        31: "上海",
        32: "江苏",
        33: "浙江",
        34: "安徽",
        35: "福建",
        36: "江西",
        37: "山东",
        41: "河南",
        42: "湖北",
        43: "湖南",
        44: "广东",
        45: "广西",
        46: "海南",
        50: "重庆",
        51: "四川",
        52: "贵州",
        53: "云南",
        54: "西藏",
        61: "陕西",
        62: "甘肃",
        63: "青海",
        64: "宁夏",
        65: "新疆",
        71: "台湾",
        81: "香港",
        82: "澳门",
        91: "国外"
    };

    //检查号码是否符合规范，包括长度，类型
    function isCardNo(card) {
        //身份证号码为15位或者18位，15位时全为数字，18位前17位为数字，最后一位是校验位，可能为数字或字符X
        var reg = /(^\d{15}$)|(^\d{17}(\d|X)$)/;
        if (reg.test(card) === false) {
            //alert("demo");
            return false;
        }
        return true;
    }

    //取身份证前两位,校验省份
    function checkProvince(card) {
        var province = card.substr(0, 2);
        if (vcity[province] == undefined) {
            return false;
        }
        return true;
    }

    //检查生日是否正确
    function checkBirthday(card) {
        var len = card.length;
        //身份证15位时，次序为省（3位）市（3位）年（2位）月（2位）日（2位）校验位（3位），皆为数字
        if (len == '15') {
            var re_fifteen = /^(\d{6})(\d{2})(\d{2})(\d{2})(\d{3})$/;
            var arr_data = card.match(re_fifteen);
            var year = arr_data[2];
            var month = arr_data[3];
            var day = arr_data[4];
            var birthday = new Date('19' + year + '/' + month + '/' + day);
            return verifyBirthday('19' + year, month, day, birthday);
        }
        //身份证18位时，次序为省（3位）市（3位）年（4位）月（2位）日（2位）校验位（4位），校验位末尾可能为X
        if (len == '18') {
            var re_eighteen = /^(\d{6})(\d{4})(\d{2})(\d{2})(\d{3})([0-9]|X)$/;
            var arr_data = card.match(re_eighteen);
            var year = arr_data[2];
            var month = arr_data[3];
            var day = arr_data[4];
            var birthday = new Date(year + '/' + month + '/' + day);
            return verifyBirthday(year, month, day, birthday);
        }
        return false;
    }

    //校验日期
    function verifyBirthday(year, month, day, birthday) {
        var now = new Date();
        var now_year = now.getFullYear();
        //年月日是否合理
        if (birthday.getFullYear() == year
            && (birthday.getMonth() + 1) == month
            && birthday.getDate() == day) {
            //判断年份的范围（3岁到100岁之间)
            var time = now_year - year;
            if (time >= 3 && time <= 100) {
                return true;
            }
            return false;
        }
        return false;
    }

    //校验位的检测
    function checkParity(card) {
        //15位转18位
        card = changeFivteenToEighteen(card);
        var len = card.length;
        if (len == '18') {
            var arrInt = [7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10,
                5, 8, 4, 2];
            var arrCh = ['1', '0', 'X', '9', '8', '7', '6', '5',
                '4', '3', '2'];
            var cardTemp = 0, i, valnum;
            for (i = 0; i < 17; i++) {
                cardTemp += card.substr(i, 1) * arrInt[i];
            }
            valnum = arrCh[cardTemp % 11];
            if (valnum == card.substr(17, 1)) {
                return true;
            }
            return false;
        }
        return false;
    }

    //15位转18位身份证号
    function changeFivteenToEighteen(card) {
        if (card.length == '15') {
            var arrInt = [7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10,
                5, 8, 4, 2];
            var arrCh = ['1', '0', 'X', '9', '8', '7', '6', '5',
                '4', '3', '2'];
            var cardTemp = 0, i;
            card = card.substr(0, 6) + '19'
                + card.substr(6, card.length - 6);
            for (i = 0; i < 17; i++) {
                cardTemp += card.substr(i, 1) * arrInt[i];
            }
            card += arrCh[cardTemp % 11];
            return card;
        }
        return card;
    }

    $('#coldUnitSelect').on('select2:select', function (e) {
        var regSel2Data = getSelect2Data();
        var coldUnitId = regSel2Data[0].id;
        var regName = regSel2Data[0].name;
        if (!coldUnitId) return;
        queryInspUnit(coldUnitId);
    });
    function queryInspUnit(coldUnitId){
        $.ajax({
            url: "${webRoot}/inspection/unit/queryByColdUnitId",
            type: "GET",
            data: { coldUnitId: coldUnitId},
            dataType: "json",
            success: function(res) {
                var $select = $("#inspectionSelect");
                $select.empty();
                $select.append('<option value="">请选择经营者</option>');
                if(res && res.obj){
                    $.each(res.obj, function(i, item){
                        $select.append('<option value="'+item.id+'">'+item.companyName+'</option>');
                    });
                }
            },
            error: function() {
                alert("经营者加载失败");
            }
        });
    }
    function changeUserType(userType){
        if($(userType).val()==0){
            $(".showIdNumber").removeClass("cs-hide");
        }else{
            $(".showIdNumber").addClass("cs-hide");
        }
    }

</script>
</html>
