<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/WEB-INF/view/common/resource.jsp" %>
<!DOCTYPE html>
<head>
    <title>快检服务云平台</title>
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
            <li class="cs-b-active cs-fl">经营者
            </li>
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
    <form id="saveForm" method="post" autocomplete="off">
        <input type="hidden" name="id" value="${id}">
        <div class="cs-base-detail">
            <div class="cs-content2">
                <table class="cs-add-new">
                    <tr>

                        <td class="cs-name"><i class="cs-mred">*</i>所属机构：</td>
                        <td class="cs-in-style">
                            <div class="cs-all-ps">
                                <div class="cs-input-box">
                                    <input type="text" name="departName" datatype="*" nullmsg="请选择所属机构" errormsg="请选择所属机构" autocomplete="off">
                                    <input type="hidden" name="departId">
                                    <div class="cs-down-arrow"></div>
                                </div>
                                <div class="cs-check-down cs-hide" style="display: none;">
                                    <ul id="myDeaprtTree" class="easyui-tree"></ul>
                                </div>
                            </div>
                        </td>


                        <td class="cs-name"><i class="cs-mred">*</i>冷链单位名称：</td>

                        <td class="cs-in-style">
                            <select id="coldUnitSelect" name="coldUnitId"></select>
                        </td>


                        <td class="cs-name showPerson1"><i class="cs-mred">*</i>经营者名称：</td>
                        <td class="cs-in-style">
                            <input type="text" datatype="*" name="companyName"/>
                        </td>


                    </tr>
                    <tr>
                        <td class="cs-name">仓库编号：</td>
                        <td class="cs-in-style">
                            <%--                            <input type="text" name="regNumber"/>--%>
                            <input type="text" name="companyCode"/>
                        </td>

                        <td class="cs-name">类型：</td>
                        <td class="cs-in-style">
                            <select id="companyType" name="companyType" class="companyType">
                                <option value="0">企业</option>
                                <option value="1">个体户</option>
                                <%-- <option value="2">供应商</option>--%>
                            </select>
                        </td>

                        <td class="cs-name showPerson2"><i class="cs-mred">*</i>统一信用代码：</td>
                        <td class="cs-in-style">
                            <input type="text" datatype="*" name="creditCode"/>
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


                        <td class="cs-name">详细地址：</td>
                        <td class="cs-in-style">
                            <input type="text" style="width: 96%;" name="companyAddress"/>
                        </td>


                    </tr>

                    <tr>

                        <td class="cs-name showCompany1">法定代表人：</td>
                        <td class="cs-in-style showCompany1">
                            <input type="text" name="legalPerson"/>
                        </td>
                        <td class="cs-name showCompany1">法人联系方式：</td>
                        <td class="cs-in-style showCompany1">
                            <input type="text" name="legalPhone"/>
                        </td>

                        <td class="cs-name">审核状态：</td>
                        <td class="cs-in-style">
                            <label><input type="radio" name="checked" value="0"/> 未审核</label>
                            <label><input type="radio" name="checked" value="1" checked="checked"/> 已审核</label>
                        </td>
                    </tr>

                    <!--
                    <tr class="showCompany">
                        <td class="cs-name">是否供应商：</td>
                        <td class="cs-in-style">
                            <label><input type="radio" name="supplier" value="0" checked="checked"/> 否</label>
                            <label><input type="radio" name="supplier" value="1"/> 是</label>
                        </td>
                        <td class="cs-name">营业状态：</td>
                        <td class="cs-in-style">
                            <label><input type="radio" name="state" value="0" checked="checked"/> 营业</label>
                            <label><input type="radio" name="state" value="1"/> 停业</label>
                        </td>
                        <td class="cs-name">成立日期：</td>
                        <td class="cs-in-style">
                            <input type="text" name="setupDate" class="cs-time" onClick="WdatePicker()"/>
                        </td>

                    </tr>-->
<%--                    <tr class="showCompany">--%>

<%--&lt;%&ndash;                        <td class="cs-name">登记机关：</td>&ndash;%&gt;--%>
<%--&lt;%&ndash;                        <td class="cs-in-style">&ndash;%&gt;--%>
<%--&lt;%&ndash;                            <input type="text" name="regAuthority"/>&ndash;%&gt;--%>
<%--&lt;%&ndash;                        </td>&ndash;%&gt;--%>
<%--                        <td class="cs-name">详细地址：</td>--%>
<%--                        <td class="cs-in-style" colspan="5">--%>
<%--                            <input type="text" style="width: 96%;" name="companyAddress"/>--%>
<%--                        </td>--%>
<%--                    </tr>--%>
                    <tr>
                        <td class="cs-name" style="vertical-align: top">备注信息：</td>
                        <td colspan="5">
                            <textarea type="text" name="remark" style="width: 96%; height: 120px;"></textarea>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </form>
    <!-- 底部导航 结束 -->
    <div class="cs-hd"></div>
    <div class="cs-alert-form-btn">
        <a href="javascript:" id="btnSave" class="cs-menu-btn cs-fun-btn"><i class="icon iconfont icon-save"></i>保存</a>
        <a href="javascript:" onclick="parent.closeMbIframe(1);" class="cs-menu-btn cs-fun-btn"><i class="icon iconfont icon-fanhui"></i>返回</a>
<%--        <a class="cs-menu-btn" href="javascript:" onclick="self.location.href='${webRoot}/inspection/unit/list'"><i class="icon iconfont icon-fanhui"></i>返回</a>--%>
<%--        <a class="cs-menu-btn" href="javascript:" onclick="self.history.back();"><i class="icon iconfont icon-fanhui"></i>返回</a>--%>
    </div>
    <!-- 引用模态框 -->
    <%@include file="/WEB-INF/view/common/confirm.jsp" %>
</body>
<!-- JavaScript -->
<script type="text/javascript">
    $(function () {
        $("#companyType").val("${type}");
        removeDataType("${type}");
        //企业和个人的切换
        $(".companyType").on("click", function () {
            removeDataType($(this).val());
        });
        //=======================================表单验证和提交- start ===========================================
        $("#saveForm").Validform({
            tiptype: 0,
            beforeSubmit: function () {
                var formData = new FormData($('#saveForm')[0]);
                $.ajax({
                    type: "POST",
                    url: "${webRoot}/inspection/unit/save.do",
                    data: formData,
                    contentType: false,
                    processData: false,
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
        //=======================================表单验证和提交- end ===========================================

        //如果是编辑就去查询数据回显
        var id = $("input[name=id]").val();
        if (id) {
            $.ajax({
                type: 'POST',
                url: "${webRoot}/inspection/unit/edit_echo.do",
                data: {'id': id},
                dataType: 'json',
                success: function (data) {
                    if (data && data.success) {
                        var obj = data.obj;
                        $('#saveForm').form('load', obj);


                        // 2. 获取要回显的冷链单位ID
                        var coldUnitId = obj.coldUnitId;

                        // 3. 先查option，再赋值
                        $.ajax({
                            url: "${webRoot}/cold/unit/queryUnitById",
                            type: "GET",
                            data: { id: coldUnitId },
                            dataType: "json",
                            success: function(res) {
                                var $select = $("#coldUnitSelect");
                                $select.empty();
                                $select.append('<option value="">请选择冷链单位</option>');

                                var departId;
                                if(res.success && res.obj){
                                    $select.append('<option value="'+res.obj.id+'">'+res.obj.regName+'</option>');
                                    departId=res.obj.departId;
                                } else {
                                    alert(res.msg || "查询失败");
                                }
                                $select.val(coldUnitId);


                                //查询机构
                                $.ajax({
                                    url: "${webRoot}/detect/depart/queryById",
                                    type: "GET",
                                    data: { id: departId },
                                    dataType: "json",
                                    success: function(res) {
                                        if(res && res.obj){

                                            $("input[name='departName']").val(res.obj.depart.departName);
                                            $("input[name='departId']").val(departId);

                                            // 需要选中树节点
                                            $('#myDeaprtTree').tree('select', $('#myDeaprtTree').tree('find', departId).target);


                                        }
                                    },
                                    error: function() {
                                        console.log("查询机构失败");
                                    }
                                });




                            },
                            error: function(xhr, status, error) {
                                alert("请求失败: " + error);
                            }
                        });

                        //
                        var setupDate = obj.setupDate;
                        if (setupDate) {
                            $("input[name=setupDate]").val(formatDate(setupDate, "yyyy-MM-dd"));
                        }
                    } else {
                        $("#confirm-warnning2").modal('toggle');
                    }
                }
            });
        }
    });

    //dataType属性的移除
    function removeDataType(isclean) {
        if (isclean == 1) {//展示个人
            $("input[name=creditCode]").attr("datatype", "*");//身份证号码
            $("input[name=regNumber]").removeAttr("datatype");//注册号
            $(".showPerson1").html("<i class='cs-mred'>*</i>名称：");
            $(".showPerson2").html("<i class='cs-mred'>*</i>身份证号码：");
            $(".showCompany").addClass("cs-hide");
            $(".showCompany1").addClass("cs-hide");
        } else if (isclean == 0) {//展示企业
            $("input[name=creditCode]").attr("datatype", "*");//社会信用代码
            $("input[name=regNumber]").attr("datatype", "*");//注册号
            $(".showPerson1").html("<i class='cs-mred'>*</i>经营者名称：");
            $(".showPerson2").html("<i class='cs-mred'>*</i>统一信用代码：");
            //$(".showPerson3").html("<i class='cs-mred'>*</i>注册号：");
            $(".showCompany").removeClass("cs-hide");
            $(".showCompany1").removeClass("cs-hide");
        } else if (isclean == 2) {//展示供应商
            $("input[name=creditCode]").attr("datatype", "*");//社会信用代码
            $("input[name=regNumber]").attr("datatype", "*");//注册号
            $(".showPerson1").html("<i class='cs-mred'>*</i>经营者名称：");
            $(".showPerson2").html("<i class='cs-mred'>*</i>统一信用代码：");
            //$(".showPerson3").html("<i class='cs-mred'>*</i>注册号：");
            $(".showCompany").removeClass("cs-hide");
        }
    }

    //组织机构树
    $('#myDeaprtTree').tree({
        checkbox : false,
        url : "${webRoot}/detect/depart/getDepartTree.do",
        animate : true,
        onClick : function(node) {
            $('#saveForm').find("input[name='departId']").val(node.id);
            $('#saveForm').find("input[name='departName']").val(node.text);

            $(this).closest('.cs-check-down').hide();

            afterSelectDepart(node);
        }
    });

    function afterSelectDepart(node) {
        $.ajax({
            url: "${webRoot}/cold/unit/queryRegByDepartId",
            type: "GET",
            data: { departId: node.id },
            dataType: "json",
            success: function(res) {
                var $select = $("#coldUnitSelect");
                $select.empty();
                $select.append('<option value="">请选择冷链单位</option>');
                // 这里res.obj才是真正的数据
                if(res && res.obj && res.obj.length > 0){
                    $.each(res.obj, function(i, item){
                        $select.append('<option value="'+item.id+'">'+item.regName+'</option>');
                    });
                }
            },
            error: function() {
                alert("查询冷链单位失败！");
            }
        });
    }

</script>
</html>
