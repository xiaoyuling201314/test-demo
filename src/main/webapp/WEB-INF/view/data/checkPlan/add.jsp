<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/WEB-INF/view/common/resource.jsp" %>

<!DOCTYPE html>
<head>
    <title>快检服务云平台</title>
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
                <a href="javascript:">数据中西</a></li>
            <li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
            <li class="cs-b-active cs-fl">检测计划</li>
            <li class="cs-fl"><i class="cs-sorrow">&gt;</i></li>
            <li class="cs-b-active cs-fl">编辑
            </li>
        </ol>
        <!-- 面包屑导航栏  结束-->
        <div class="cs-search-box cs-fr">
            <button class="cs-menu-btn" onclick="parent.closeMbIframe(1);"><i class="icon iconfont icon-fanhui"></i>返回</button>
        </div>
    </div>
    <form id="saveForm" method="post"  autocomplete="off" style="margin: 15px">
        <input type="hidden" name="id" value="${id}">
        <input type="hidden" name="foodId" value="${foodId}">
        <div class="cs-base-detail">
            <div class="cs-content2" style="padding-left:20%;">
                <table class="cs-add-new">
                    <tr>
                        <td class="cs-name">样品名称：</td>
                        <td class="cs-in-style">
                            <li class="cs-in-style col-md-5" width="210px">
                                <input type="text" value="${foodName}" disabled/>
                            </li>
                        </td>
                    </tr>
                    <tr>
                        <td class="cs-name">星期一：</td>
                        <td class="cs-in-style">
                            <li class="cs-in-style col-md-5" width="210px">
                                <input type="hidden" name="itemIdMon" />
                                <select id="item_select1" name="itemName1" class="js-data-example-ajax"></select>
                            </li>
                        </td>
                    </tr>
                    <tr>
                        <td class="cs-name">星期二：</td>
                        <td class="cs-in-style">
                            <li class="cs-in-style col-md-5" width="210px">
                                <input type="hidden" name="itemIdTue" />
                                <select id="item_select2" name="itemName2" class="js-data-example-ajax"></select>
                            </li>
                        </td>
                    </tr>
                    <tr>
                        <td class="cs-name">星期三：</td>
                        <td class="cs-in-style">
                            <li class="cs-in-style col-md-5" width="210px">
                                <input type="hidden" name="itemIdWeb" />
                                <select id="item_select3" name="itemName3" class="js-data-example-ajax"></select>
                            </li>
                        </td>
                    </tr>
                    <tr>
                    <td class="cs-name">星期四：</td>
                    <td class="cs-in-style">
                        <li class="cs-in-style col-md-5" width="210px">
                            <input type="hidden" name="itemIdThu" />
                            <select id="item_select4" name="itemName4" class="js-data-example-ajax"></select>
                        </li>
                    </td>
                </tr> <tr>
                    <td class="cs-name">星期五：</td>
                    <td class="cs-in-style">
                        <li class="cs-in-style col-md-5" width="210px">
                            <input type="hidden" name="itemIdFri" />
                            <select id="item_select5" name="itemName5" class="js-data-example-ajax"></select>
                        </li>
                    </td>
                </tr> <tr>
                    <td class="cs-name">星期六：</td>
                    <td class="cs-in-style">
                        <li class="cs-in-style col-md-5" width="210px">
                            <input type="hidden" name="itemIdSat" />
                            <select id="item_select6" name="itemName6" class="js-data-example-ajax"></select>
                        </li>
                    </td>
                </tr> <tr>
                    <td class="cs-name">星期日：</td>
                    <td class="cs-in-style">
                        <li class="cs-in-style col-md-5" width="210px">
                            <input type="hidden" name="itemIdSun" />
                            <select id="item_select7" name="itemName7" class="js-data-example-ajax"></select>
                        </li>
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
        myInitSelect();
        queryById();
        //表单提交_start -----------------------------
        // 点击保存（新增或修改）
        $("#btnSave").on("click", function () {
            $("#saveForm").submit();
            return false;
        });
        var saveForm = $("#saveForm").Validform({
            tiptype: 2,
            beforeSubmit: function () {
                $("#btnSave").attr("disabled","disabled");//禁用按钮
                $("input[name=itemIdMon]").val($('#item_select1').val());
                $("input[name=itemIdTue]").val($('#item_select2').val());
                $("input[name=itemIdWeb]").val($('#item_select3').val());
                $("input[name=itemIdThu]").val($('#item_select4').val());
                $("input[name=itemIdFri]").val($('#item_select5').val());
                $("input[name=itemIdSat]").val($('#item_select6').val());
                $("input[name=itemIdSun]").val($('#item_select7').val());
                var formData = new FormData($('#saveForm')[0]);
                $.ajax({
                    type: "POST",
                    url: "${webRoot}/checkPlan/save.do",
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

    });

    function queryById(){
        if (id) {
            $(".account").find("tr").show();
            $("#saveForm .account").parent().show();
            $.ajax({
                url: '${webRoot}/checkPlan/queryById',
                method: 'post',
                data: {"id": id},
                success: ({success, msg, obj}) => {
                    if (success) {
                        $('#saveForm').form('load', obj);
                        $("#select2-item_select1-container").text(obj.itemName1);
                        $("#select2-item_select2-container").text(obj.itemName2);
                        $("#select2-item_select3-container").text(obj.itemName3);
                        $("#select2-item_select4-container").text(obj.itemName4);
                        $("#select2-item_select5-container").text(obj.itemName5);
                        $("#select2-item_select6-container").text(obj.itemName6);
                        $("#select2-item_select7-container").text(obj.itemName7);
                    }else{
                        $("#waringMsg>span").html(msg);
                        $("#confirm-warnning").modal('toggle');
                    }
                }
            });
        }
    }
    function myInitSelect(){
        $("#item_select1,#item_select2,#item_select3,#item_select4,#item_select5,#item_select6,#item_select7").select2({
            placeholder: '--请选择--',
            language: {
                errorLoading: function() {
                    return "无法载入结果";
                },
                inputTooLong: function(e) {
                    var t = e.input.length - e.maximum,
                        n = "请删除" + t + "个字符";
                    return n;
                },
                inputTooShort: function(e) {
                    var t = e.minimum - e.input.length,
                        n = "请输入至少" + t + "个字符";
                    return n;
                },
                loadingMore: function() {
                    return "载入更多结果…";
                },
                maximumSelected: function(e) {
                    var t = "最多只能选择" + e.maximum + "个项目";
                    return t;
                },
                searching: function() {
                    return "搜索中...";
                },
                noResults: function() {
                    return "没有搜索到结果!";
                }
            },
            width: "100%",
            ajax: {
                url: "${webRoot}/data/detectItem/select2ItemDataForOrder",
                dataType: 'json',
                delay: 250,
                data: function(params) {//发送到服务器的数据
                    //params.term 是输入框中内容。
                    //此对象的key就是发送到服务器的参数名。
                    //所以这里你可以添加自定义参数，如：page: params.page
                    params.page = params.page || 1; // 这个page会记录下来，且向下滚动翻页时会自增
                    return {
                        itemName: (!params.term ? '' : params.term), //后端取 key 它就是搜索关键字
                        page: params.page || 1, //分页：当前页码
                        row: 50	//每页数量
                    };
                },
                processResults: function(data, params) {// 后端返数据的根是 data，params就是上面的查寻参数
                    return {
                        results: data.items,
                        pagination: { //分页
                            //more: data.more // 是否还有后面页：true|false
                            more: (params.page * 50) < data.total // 后端返回总数量 total 算出还有没
                        }
                    };
                },
                cache: true
            },
            minimumInputLength: 0,// 输入几个字时开始搜索
            templateResult: formatRepo,// 定制搜索结果列表的外面
            // templateResult 返回的数据要从 escapeMarkup 过，默认会被转成text，要想返回html如下覆写
            escapeMarkup: function(markup) {
                return markup;
            },
            templateSelection: formatRepoSelection // 定制所选结果的外观
        });
    }
    /**
     * 搜索结果返回，列表中每个结果都调用此方法。repo 参数对应后端的一个 jsonObject。
     * 此函数可以返回一个html元素字符串，或者一个对象(例如jQuery对象)，其中包含要显示的数据。
     * 还可以返回null，这将阻止在结果列表中显示该选项(可以实现过滤某些值)
     */
    function formatRepo(repo) {
        if (repo.loading) return repo.text;//如果loading中，直接返回提示信息
        var markup = "<div class='select2-result-repository clearfix'>" +
            "<div class='select2-result-repository__title'>" + repo.name + "</div>" +
            "</div>";
        return markup;
    }
    /**
     * 将选择数据对象转换为字符串表示或jQuery对象（可以显示带图片的结果那种）
     */
    function formatRepoSelection(repo) {
        return repo.name?repo.name:repo.text;//如果没有name返回提示信息
    }
</script>
</html>
